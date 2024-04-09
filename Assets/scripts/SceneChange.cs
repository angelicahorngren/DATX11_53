using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Unity.Netcode;


public class SceneChange : MonoBehaviour
{
    [SerializeField] private Button ExitButton;
    //[SerializeField] private Button ServerButton;
    [SerializeField] private Button HostButton;
    [SerializeField] private Button JoinButton;

    
    [SerializeField] public InforamtionKeeper inforamtionKeeper;

    private void Awake() {
        ExitButton.onClick.AddListener(() => {
            Debug.Log("EXIT"); 
            
            Application.Quit();
            //NetworkManager.Singleton.StartServer();
        });
        HostButton.onClick.AddListener(() => {
            Debug.Log("HOST"); 
            inforamtionKeeper.JoinCode= ""; //telling that you are hosting
            SceneManager.LoadScene("InsideHouse");
            //NetworkManager.Singleton.StartHost();
        });
        JoinButton.onClick.AddListener(() => {
            Debug.Log("CLIENT/JOIN"); 
            inforamtionKeeper.JoinCode= "1"; // temp hardwired code telling that you are a client for a host with password "1"
            //NetworkManager.Singleton.StartClient();
        });
    }

     void Start()
    {
        inforamtionKeeper.JoinCode= "";
    }

}
