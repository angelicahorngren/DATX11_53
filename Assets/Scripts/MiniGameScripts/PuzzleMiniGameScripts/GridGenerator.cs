using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridGenerator : MonoBehaviour
{
    public int gridRows;
    public int gridCols;
    public GameObject image;  //Quad object
    public float cellSize = 4.0f;

    //private List<Transform> pieces;

    // Start is called before the first frame update
    void Start()
    {
        //pieces = new List<Transform>();
        GenerateGrid();
    }

    void GenerateGrid(){

        float distanceBetweenCells = 0.1f;

        for (int row = 0; row < gridRows; row++){

            for (int col = 0; col < gridCols; col++){

                // Calculate UV coordinates to divide the image among the quad objects
                Vector2[] uv = new Vector2[4];
                uv[0] = new Vector2((float)col / gridCols,((float)row / gridRows));
                uv[1] = new Vector2((float)(col + 1) / gridCols,((float)row / gridRows));
                uv[2] = new Vector2((float)col / gridCols,((float)(row + 1) / gridRows));
                uv[3] = new Vector2((float)(col + 1) / gridCols,((float)(row + 1) / gridRows));

                Vector3 generatePosition = new Vector3(col * (cellSize + distanceBetweenCells), 0, row * (cellSize + distanceBetweenCells));

                GameObject imageQuad = Instantiate(image, generatePosition, Quaternion.identity);

                imageQuad.transform.localScale = new Vector3(cellSize, cellSize, cellSize);

                // Set UV coordinates to the quad object
                Mesh mesh = imageQuad.transform.GetChild(0).GetComponent<MeshFilter>().mesh;
                mesh.uv = uv;

                imageQuad.transform.name = $"{(col * (gridRows * gridCols) + row)}";

                if ((row == gridRows - 1) && (col == gridCols - 1)) {
                    imageQuad.gameObject.SetActive(false);
                }
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0)){

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        // Perform the raycast
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit)) {

                MeshCollider meshCollider = hit.collider as MeshCollider;
                if (meshCollider != null){

                    HandleClickEvent(hit.transform);
                }


            }

        }
    }
    
    void HandleClickEvent (Transform clickedTransform){
        Debug.Log("Quad clicked: " + clickedTransform.name);
    }


}
