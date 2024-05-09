using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class PauseMenu : NetworkBehaviour
{


    [SerializeField] private Button ExitButton;
    //[SerializeField] private Button ServerButton;
    [SerializeField] private Button ResumeButton;
    [SerializeField] private Button MenuButton;
    public static bool GameIsPaused = false;

    public GameObject pauseMenuUI;
    
   

    void Start(){
        pauseMenuUI.SetActive(false);
    }

    private void Awake() {
        ExitButton.onClick.AddListener(() => {
            QuitGame();
        });
        ResumeButton.onClick.AddListener(() => {
            Resume();
        });
        MenuButton.onClick.AddListener(() => {
            LoadMenu();
        });

    }
    
    void Update(){
        if (Input.GetKeyDown(KeyCode.Escape))
        {
           if(GameIsPaused){
                Resume();
           } else {
                Pause();
           }
        }
    }

    public void Resume()
    {
        pauseMenuUI.SetActive(false);
        //Time.timeScale = 1f;
        GameIsPaused = false;
        Debug.Log("game has resumed");
    }

    void Pause()
    {
        pauseMenuUI.SetActive(true);
        //Time.timeScale = 0f;
        GameIsPaused = true;
    }

    public void LoadMenu()
    {
        CheckIfHostServerRpc();
        NetworkManager.Singleton.Shutdown(); //temporary
        
        
        Time.timeScale = 1f;
        SceneManager.LoadScene("mainmenu");
    }

    public void QuitGame()
    {
        CheckIfHostServerRpc();
        Application.Quit();
    }



    [ServerRpc]
    private void CheckIfHostServerRpc(){
        if (IsHost){
            HostLeaveClientRpc();
        }
        Debug.Log("test TestServerRpc; " + OwnerClientId);
    }


    // may be temporary (unfinished)
    [ClientRpc]
    private void HostLeaveClientRpc(){
        Debug.Log("before");
        NetworkManager.Singleton.Shutdown();
        Debug.Log("after");
        SceneManager.LoadScene("mainmenu");
    }
}