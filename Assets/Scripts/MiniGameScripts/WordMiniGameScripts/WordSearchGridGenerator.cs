using UnityEngine;
using TMPro;
using System.Collections.Generic;

public class WordSearchGridGenerator : MonoBehaviour
{
    public int rows;
    public int columns;
    public float spacing = 1.0f;
    public GameObject cell;
    public Material originalMaterial;
    public Material clickedMaterial;

    private char[,] grid;
    private char[,] letterGrid;
    private Vector2Int startCell = new Vector2Int(-1, -1);
    private Vector2Int endCell = new Vector2Int(-1, -1);
    private GameObject[,] gridCells;
    private string word;
    private List<string> wordList = new List<string>();
    private List<Vector2Int> correctCells = new List<Vector2Int>();
    

    void Start()
    {
        GenerateGrid();
        InstantiateGrid();
    }

    void GenerateGrid()
    {

        grid = new char[rows, columns];
        letterGrid = new char[,]
        {
            {'K', 'M', 'R', 'V', 'S', 'D', 'B', 'N', 'I', 'W'},
            {'P', 'E', 'X', 'G', 'S', 'I', 'L', 'O', 'P', 'C'},
            {'A', 'L', 'Y', 'H', 'T', 'O', 'V', 'I', 'D', 'R'},
            {'Q', 'Z', 'B', 'X', 'G', 'W', 'S', 'N', 'L', 'C'},
            {'M', 'I', 'B', 'I', 'L', 'A', 'U', 'V','K', 'R'},
            {'O', 'T', 'V', 'C', 'D', 'B', 'I', 'I', 'X', 'G'},
            {'T', 'X', 'I', 'S', 'R', 'L', 'X', 'T', 'A', 'T'},
            {'I', 'F', 'Y', 'K', 'M', 'U', 'R', 'T', 'X', 'P'},
            {'V', 'O', 'B', 'C', 'Q', 'V', 'Q', 'N', 'J', 'O'},
            {'F', 'P', 'N', 'Y', 'Z', 'E', 'E', 'E', 'T', 'M'}
        };

        gridCells = new GameObject[rows, columns];

        wordList.Add("POLIS");
        wordList.Add("MOTIV");
        wordList.Add("ALIBI");
        wordList.Add("VITTNE");
    }

void InstantiateGrid()
{
    float cellSize = 1.0f;
    float distanceBetweenCells = 0.1f;
    for (int row = 0; row < rows; row++)
    {
        for (int col = 0; col < columns; col++)
        {
            Vector3 position = new Vector3(row * (cellSize + distanceBetweenCells), 0, col * (cellSize + distanceBetweenCells));
            GameObject gridCell = Instantiate(cell, position, Quaternion.identity);
            gridCell.transform.SetParent(transform);

            gridCell.name = "Cell_" + row + "_" + col;

            ClickableCell clickableCell = gridCell.GetComponent<ClickableCell>();
            clickableCell.SetCellPosition(row, col);

            TextMeshPro textMeshPro = gridCell.GetComponentInChildren<TextMeshPro>();
            textMeshPro.text = letterGrid[row, col].ToString();

            gridCell.AddComponent<BoxCollider>();
            gridCells[row, col] = gridCell;

            
        }
    }
}

// Function to select a cell
public void SelectCell(GameObject cell)
{
    ClickableCell clickableCell = cell.GetComponent<ClickableCell>();
    if (clickableCell != null)
    {
        Vector2Int cellPosition = clickableCell.cellPosition;

        if (startCell == new Vector2Int(-1, -1))
        {
            startCell = cellPosition;
        }
        else
        {
            endCell = cellPosition;

            ValidateWord(startCell, endCell);
            startCell = new Vector2Int(-1, -1);
            endCell = new Vector2Int(-1, -1);
        }
    }

}


    // Function to handle cell click
    public void OnCellClick(GameObject clickedCell)
    {
        ChangeMaterial(clickedCell);
        SelectCell(clickedCell);
    }

    // Function to change material when cell is clicked
    public void ChangeMaterial(GameObject cell)
    {
        Transform cellCore = cell.transform.Find("Cell Core");
        MeshRenderer renderer = cellCore.GetComponent<MeshRenderer>();
        renderer.material = clickedMaterial;
    }


    public void RestoreMaterial(GameObject cell)
    {
        Transform cellCore = cell.transform.Find("Cell Core");
        MeshRenderer renderer = cellCore.GetComponent<MeshRenderer>();
        renderer.material = originalMaterial;
    }

    // Function to select a cell


        // Function to extract the selected word from the grid
    string ExtractWord()
    {
        // Calculate deltaX and deltaY
        int deltaX = endCell.x - startCell.x;
        int deltaY = endCell.y - startCell.y;

        // Determine the direction of the word
        if (deltaX != 0 && deltaY != 0)
        {
            // Selection is diagonal, which is not supported
            Debug.LogWarning("Selection must be either horizontal or vertical.");
            return "";
        }

        // Traverse the selected cells and concatenate the characters
        string word = "";
        int stepX = deltaX != 0 ? (int)Mathf.Sign(deltaX) : 0;
        int stepY = deltaY != 0 ? (int)Mathf.Sign(deltaY) : 0;
        int x = startCell.x;
        int y = startCell.y;
        while (x != endCell.x || y != endCell.y)
        {
            word += letterGrid[x, y];
            x += stepX;
            y += stepY;
        }

        word += letterGrid[endCell.x, endCell.y];

        Debug.Log("Selected word: " + word);
        return word;
    }



    void ValidateWord(Vector2Int startCell, Vector2Int endCell)
    {
        string word = ExtractWord();

        if (wordList.Contains(word))
        {

            // Extract word direction
            int stepX = Mathf.Clamp(endCell.x - startCell.x, -1, 1);
            int stepY = Mathf.Clamp(endCell.y - startCell.y, -1, 1);

            // Iterate through cells between startCell and endCell
            int x = startCell.x;
            int y = startCell.y;
            while (x != endCell.x || y != endCell.y)
            {
                // Change material of current cell
                GameObject currentCell = gridCells[x, y];
                ChangeMaterial(currentCell);

                correctCells.Add(new Vector2Int(x, y));
                // Move to the next cell
                x += stepX;
                y += stepY;

            }
            correctCells.Add(new Vector2Int(endCell.x, endCell.y));
        }
        else
        {
            Debug.Log("Word not found: " + word);
        }

        // Restore material for all cells
        foreach (GameObject cell in gridCells)
        {
            Vector2Int cellPosition = cell.GetComponent<ClickableCell>().cellPosition;
            if(!correctCells.Contains(cellPosition)){
                RestoreMaterial(cell);
            }

        }
    }


    // Inner class to handle click events
    void OnMouseDown()
    {
        OnCellClick(gameObject);
    }
}

