using UnityEngine;
using TMPro;

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
    private Vector2Int startCell;
    private Vector2Int endCell;

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
            {'M', 'I', 'B', 'I', 'L', 'A', 'V', 'U', 'K', 'R'},
            {'O', 'T', 'V', 'C', 'D', 'B', 'I', 'W', 'X', 'G'},
            {'T', 'X', 'I', 'S', 'R', 'L', 'T', 'Z', 'A', 'T'},
            {'I', 'F', 'Y', 'K', 'M', 'U', 'T', 'F', 'X', 'P'},
            {'V', 'O', 'B', 'C', 'Q', 'V', 'N', 'L', 'J', 'O'},
            {'F', 'P', 'N', 'Y', 'Z', 'E', 'E', 'P', 'T', 'M'}
        };

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

        if (startCell == null)
        {
            startCell = cellPosition;
            Debug.Log("Start Cell: " + startCell);
        }
        else
        {
            endCell = cellPosition;
            //Debug.Log("End Cell: " + endCell);
            ValidateWord();
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

    // Function to restore original material
    public void RestoreMaterial(GameObject cell)
    {
        MeshRenderer renderer = cell.GetComponent<MeshRenderer>();
        renderer.material = originalMaterial;
    }

    // Function to select a cell


    // Function to extract the selected word from the grid
    string ExtractWord()
    {
        string word = "";
        int startX = startCell.x;
        int startY = startCell.y;
        int endX = endCell.x;
        int endY = endCell.y;

        // Your logic to extract the word from the grid here...

        return word;
    }

    // Function to validate the selected word
    void ValidateWord()
    {
        string word = ExtractWord();
        startCell = new Vector2Int(0, 0);
        endCell = new Vector2Int(0, 0);
        // Your logic to validate the word here...
    }

    // Inner class to handle click events
    void OnMouseDown()
    {
        OnCellClick(gameObject);
    }
}
