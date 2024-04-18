using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Player : MonoBehaviour
{
    public int keys = 0;
    public float speed = 5.0f;

   
    public Text youWin;
    public GameObject door;
    // Start is called before the first frame update
    void Start()
    {

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


    private void OnCollisionEnter2D(Collision2D collision)
    {
        

        if (collision.gameObject.tag == "Treasure")
        
            
        
        {
            youWin.text = "YOU WIN!!!";
        }
        
        
    }
}