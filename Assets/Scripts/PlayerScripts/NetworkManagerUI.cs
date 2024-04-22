using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class NetworkManagerUI : MonoBehaviour
{
    [SerializeField] private Button ServerButton;
    [SerializeField] private Button HostButton;
    [SerializeField] private Button ClientButton;

    [SerializeField] public InforamtionKeeper inforamtionKeeper;

     void Start()
    {
        inforamtionKeeper.StartLevel = true;
        if(inforamtionKeeper.JoinCode == ""){
                Debug.Log("HOSTHOSTHOST");
                NetworkManager.Singleton.StartHost();
                NetworkManager.Singleton.SceneManager.LoadScene("OutsideHouse", LoadSceneMode.Single);
        } else {
                Debug.Log("CLIENTCLIENTCLIENT");
                NetworkManager.Singleton.StartClient();
                
        }
    }

    private void Awake() {
        ServerButton.onClick.AddListener(() => {
            NetworkManager.Singleton.StartServer();
        });
        HostButton.onClick.AddListener(() => {
            NetworkManager.Singleton.StartHost();
        });
        ClientButton.onClick.AddListener(() => {
            NetworkManager.Singleton.StartClient();
        });
    }
}

