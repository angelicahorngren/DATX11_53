using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseMenu : MonoBehaviour
{
    public static bool GameIsPaused = false;

    public GameObject pauseMenuUI;
    
    private int val=0;

    
    
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.P))
        {
           Pause();
        }
        if(val==0){
            pauseMenuUI.SetActive(false);
            val++;
        }
    }

    public void Resume()
    {
        pauseMenuUI.SetActive(false);
        Time.timeScale = 1f;
        GameIsPaused = false;
        Debug.Log("game has restarted");
    }

    void Pause()
    {
        pauseMenuUI.SetActive(true);
        Time.timeScale = 0f;
        GameIsPaused = true;
    }

    public void LoadMenu()
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene("meneubranch");
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}