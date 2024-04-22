using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridGenerator : MonoBehaviour
{
    public int gridRows;
    public int gridCols;
    public GameObject cube;
    public GameObject image;  //Quad object

    // Start is called before the first frame update
    void Start()
    {
        GenerateGrid();
    }

    void GenerateGrid(){

        float cellSize = 2.0f;
        float distanceBetweenCells = 0.2f;

        for (int row = 0; row < gridRows; row++){

            for (int col = 0; col < gridCols; col++){

                Vector3 generatePosition = new Vector3(row * (cellSize + distanceBetweenCells), 0, col * (cellSize + distanceBetweenCells));
                GameObject gridCell = Instantiate(cube, generatePosition, Quaternion.identity);
                GameObject imageQuad = Instantiate(image, generatePosition, Quaternion.identity);
                imageQuad.transform.SetParent(gridCell.transform);

                if ((row == gridRows - 1) && (col == gridCols - 1)) {
                    gridCell.gameObject.SetActive(false);

                }

            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
