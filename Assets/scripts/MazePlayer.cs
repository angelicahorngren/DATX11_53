using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class MazePlayer : MonoBehaviour
{
    public int keys = 0;
    public float speed = 5.0f;

    public MazeGenerator mazeGenerator;
    public Text youWin;
    private int count = 0;
    // Start is called before the first frame update
    void Start()
    {
        if (mazeGenerator != null && count==0)
    {
        float offsetX = 1.0f; 
       
        Vector3 initialPosition = new Vector3((mazeGenerator.MazeSize.x / 2f)-offsetX, 0, -mazeGenerator.MazeSize.y/2f );
        
        transform.position = initialPosition;
        count++;
    }
        
    }

    // Update is called once per frame
   void Update()
{
    if (Input.GetKey(KeyCode.LeftArrow))
    {
        transform.Translate(-speed * Time.deltaTime, 0, 0);
    }
    if (Input.GetKey(KeyCode.RightArrow))
    {
        transform.Translate(speed * Time.deltaTime, 0, 0);
    }
    if (Input.GetKey(KeyCode.UpArrow))
    {
        transform.Translate(0, 0, speed * Time.deltaTime);
    }
    if (Input.GetKey(KeyCode.DownArrow))
    {
        transform.Translate(0, 0, -speed * Time.deltaTime);
    }
}



    private void OnCollisionEnter3D(Collision2D collision)
    {
        

        if (collision.gameObject.tag == "Goal")
        
            
        
        {
            youWin.text = "YOU WIN!!!";
        }
        
        
    }
}