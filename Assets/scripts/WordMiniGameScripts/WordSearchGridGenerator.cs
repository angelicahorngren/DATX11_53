using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WordSearchGridGenerator : MonoBehaviour
{

    public int rows;
    public int columns;
    public GameObject cellPrefab;

    private char[,] grid;
    // Start is called before the first frame update
    void Start()
    {
        GenerateGrid();
        InstantiateGrid();
    }

    GenerateGrid()
    {
        grid = new char[rows, columns];
    }

    InstantiateGrid()
    {
        for (int row = 0; row < rows; row++)
        {
            for (int column = 0; column < columns; column++)
            {
                Vector3 cellPosition = new Vector3(row, column, 0);
                GameObject cell = Instantiate(cellPrefab, new Vector3(row, column, 0), Quaternion.identity);
                cell.transform.SetParent(this.transform);
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
