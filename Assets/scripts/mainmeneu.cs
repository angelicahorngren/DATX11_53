using System.Collections;  
using System.Collections.Generic;  
using UnityEngine;  
using UnityEngine.SceneManagement;

public class themeneu: MonoBehaviour {

    //public GameObject menu;
    //public GameObject 
    public void PlayGame() {  
        Debug.Log("if you see this play button works"); 
        SceneManager.LoadScene("InsideHouse");

        //SceneManager.LoadScene("Playtest");
    }  
    public void QuitGame() {  
        //Application.Quit(); 
        Debug.Log("if you see this exit button works"); 
        Application.Quit();
    }  
    public void PlayGameOnline() {  
        //SceneManager.LoadScene("Playtestonline");
        Debug.Log("if you see this online button works");
        
    }
    public void HideMenu()
    {

    }
     void Update()
    {
        
           
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
       
        
    }
}  
    
