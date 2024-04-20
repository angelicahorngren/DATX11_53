using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Unity.Netcode;


public class MainMenu : MonoBehaviour
{
    [SerializeField] private Button ExitButton;
    [SerializeField] private Button HostButton;
    [SerializeField] private Button JoinButton;

    
    [SerializeField] public InforamtionKeeper inforamtionKeeper;

    private void Awake() {
        
        ExitButton.onClick.AddListener(() => {
            Debug.Log("EXIT"); 
            
            Application.Quit();
        });
        HostButton.onClick.AddListener(() => {
            Debug.Log("HOST"); 
            inforamtionKeeper.JoinCode= ""; //telling that you are hosting
            //SceneManager.LoadScene("OutsideHouse");
            SceneManager.LoadScene("NetworkActivationMiddleScene");
            //NetworkManager.Singleton.StartHost();
        });
        JoinButton.onClick.AddListener(() => {
            Debug.Log("CLIENT/JOIN"); 
            inforamtionKeeper.JoinCode= "1"; // temp hardwired code telling that you are a client for a host with password "1"
            //SceneManager.LoadScene("OutsideHouse");
            SceneManager.LoadScene("NetworkActivationMiddleScene");
        });
    }

     void Start()
    {
        inforamtionKeeper.JoinCode= "";
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
        
/*        
        ExitButton.onClick.AddListener(() => {
            Debug.Log("EXIT"); 
            
            Application.Quit();
        });
        HostButton.onClick.AddListener(() => {
            Debug.Log("HOST"); 
            inforamtionKeeper.JoinCode= ""; //telling that you are hosting
            NetworkManager.Singleton.StartHost();
            NetworkManager.Singleton.SceneManager.LoadScene("OutsideHouse", LoadSceneMode.Single);
            //NetworkManager.Singleton.StartHost();
        });
        JoinButton.onClick.AddListener(() => {
            Debug.Log("CLIENT/JOIN"); 
            inforamtionKeeper.JoinCode= "1"; // temp hardwired code telling that you are a client for a host with password "1"
            NetworkManager.Singleton.SceneManager.LoadScene("OutsideHouse", LoadSceneMode.Single);
        });
*/
    }

}
