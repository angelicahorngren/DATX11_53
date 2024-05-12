using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridGenerator : MonoBehaviour
{
    public int gridRows;
    public int gridCols;
    public GameObject image;  //Quad object
    public float cellSize = 4.0f;
    public float distanceBetweenCells = 0.1f;
    public GameObject winScreen;
    private List<Transform> pieces;
    private List<Transform> puzzle;
    private List<Transform> puzzle_copy; 
    private List<Transform> shuffled;
    private Transform emptySpace;

    // Start is called before the first frame update
    void Start()
    {
        winScreen.SetActive(false);
        pieces = new List<Transform>();
        puzzle = GenerateGrid(pieces);
        puzzle_copy = new List<Transform>(puzzle);
        shuffled = Shuffle(puzzle);
    }

    List<Transform> GenerateGrid(List<Transform> pieces2){
        pieces = pieces2;
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
                pieces.Add(imageQuad.transform);  // Add the quad to the pieces list

                imageQuad.transform.localScale = new Vector3(cellSize, cellSize, cellSize);

                // Set UV coordinates to the quad object
                Mesh mesh = imageQuad.transform.GetChild(0).GetComponent<MeshFilter>().mesh;
                mesh.uv = uv;

                imageQuad.transform.name = $"{(col * (gridRows * gridCols) + row)}";

                if ((row == gridRows - 1) && (col == gridCols - 1)) {
                    emptySpace = imageQuad.transform;
                    imageQuad.gameObject.SetActive(false);
                }
            }
        }
        return pieces;

    }

    List<Transform> Shuffle(List<Transform> puzzle2)
    {
        pieces = puzzle2;
        int newFourthIndex = 4;
        Transform pieceZero = pieces[0];
        pieces[0] = pieces[newFourthIndex];
        pieces[newFourthIndex] = pieceZero;

        int newSeventhIndex = 7;
        Transform pieceFour = pieces[4];
        pieces[4] = pieces[newSeventhIndex];
        pieces[newSeventhIndex] = pieceFour;

        int newFifthIndex = 5;
        Transform pieceOne = pieces[1];
        pieces[1] = pieces[newFifthIndex];
        pieces[newFifthIndex] = pieceOne;

        int newSixthIndex = 6;
        Transform pieceFive = pieces[5];
        pieces[5] = pieces[newSixthIndex];
        pieces[newSixthIndex] = pieceFive;

        int nextFourthIndex = 4;
        Transform pieceTwo = pieces[2];
        pieces[2] = pieces[nextFourthIndex];
        pieces[nextFourthIndex] = pieceTwo;

        int nextFifthIndex = 5;
        Transform pieceT = pieces[2];
        pieces[2] = pieces[nextFifthIndex];
        pieces[nextFifthIndex] = pieceT;

        // Update the positions of the quads in the scene
        for (int i = 0; i < pieces.Count; i++)
        {
            pieces[i].position = new Vector3(i % gridCols * (cellSize + distanceBetweenCells), 0, i / gridCols * (cellSize + distanceBetweenCells));
        }

        return pieces;
    }

    // Update is called once per frame
    void Update()
    {
        //if (shuffled == puzzle){
        //    winScreen.SetActive(true);
       // }
        if (AreListsEqual(shuffled, puzzle_copy))
        {
            winScreen.SetActive(true);
        }

        if (Input.GetMouseButtonDown(0)){

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        // Perform the raycast
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit)) {

                Transform clickedQuad = hit.transform;
                if (AdjacentToEmptySpace(clickedQuad))
                {
                    // Swap positions of the clicked quad and the empty space
                    SwapQuads(clickedQuad, emptySpace);
                }
            }
        }
        
    }

    bool AreListsEqual(List<Transform> list1, List<Transform> list2)
    {
        if (list1.Count != list2.Count)
        {
            return false;
        }

        for (int i = 0; i < list1.Count; i++)
        {
            if (list1[i] != list2[i])
            {
                return false;
            }
        }

        return true;
    }

    bool AdjacentToEmptySpace(Transform quad)
    {
        // Get the parent GameObject of the clicked quad
        GameObject parentObject = quad.parent.gameObject;
        // Get the transform of the parent GameObject (imageQuad)
        Transform quadTransform = parentObject.transform;

        int clickedIndex = pieces.IndexOf(quadTransform);
        int emptyIndex = pieces.IndexOf(emptySpace);

        int rowDifference = Mathf.Abs(clickedIndex / gridCols - emptyIndex / gridCols);
        int colDifference = Mathf.Abs(clickedIndex % gridCols - emptyIndex % gridCols);

        return (rowDifference == 1 && colDifference == 0) || (rowDifference == 0 && colDifference == 1);
    }

    void SwapQuads(Transform quad1, Transform quad2)
    {
        // Get the parent GameObject of the clicked quad
        GameObject parentObject = quad1.parent.gameObject;
        // Get the transform of the parent GameObject (imageQuad)
        Transform quad1Parent = parentObject.transform;

        Vector3 tempPosition = quad1Parent.position;
        quad1Parent.position = quad2.position;
        quad2.position = tempPosition;

        // Swap elements in the pieces list
        int index1 = pieces.IndexOf(quad1Parent);
        int index2 = pieces.IndexOf(quad2);
        pieces[index1] = quad2;
        pieces[index2] = quad1Parent;
    }

}
