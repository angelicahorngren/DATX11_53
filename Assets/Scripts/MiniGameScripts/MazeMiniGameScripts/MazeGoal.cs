using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MazeGoal : MonoBehaviour
{
  
    

    public MazeGenerator mazeGenerator;
    
    private int count = 0;
    // Start is called before the first frame update
    //-5 and 4
    void Start()
    {
        if (mazeGenerator != null && count==0)
        {
            float offsetX = 1.0f; 
            float offsetY = 1.0f; 
            //print(-(mazeGenerator.MazeSize.x * mazeGenerator.NodeSize / 2f) + offsetX);
            //print(mazeGenerator.MazeSize.y);
            Vector3 goalPosition = new Vector3(-5, 0f, 4);
            transform.position = goalPosition;
        }
    }

    // Update is called once per frame
   void Update()
{
   
}



 
}
