using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro; 

public class WordSearchGridGenerator : MonoBehaviour
{

    public int rows;
    public int columns;
    public float spacing = 1.0f;
    public GameObject cell;

    // Removed TMPro.TextMeshProUGUI text; since we're not dealing with UI text

    private char[,] grid;

    void Start()
    {
        GenerateGrid();
        InstantiateGrid();
    }

    void GenerateGrid()
    {
        grid = new char[rows, columns];
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

                TextMeshPro textMeshPro = gridCell.GetComponentInChildren<TextMeshPro>();

 
                    char letter = GenerateLetter(); 
                    textMeshPro.text = letter.ToString();

            }
        }
    }

    char GenerateLetter()
    {
        return (char)('A' + Random.Range(0, 26));
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}
