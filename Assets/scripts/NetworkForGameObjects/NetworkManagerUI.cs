using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class NetworkManagerUI : MonoBehaviour
{
    [SerializeField] private Button ServerButton;
    [SerializeField] private Button HostButton;
    [SerializeField] private Button ClientButton;

    [SerializeField] public InforamtionKeeper inforamtionKeeper;

     void Start()
    {
        if(inforamtionKeeper.JoinCode == ""){
                Debug.Log("HOSTHOSTHOST");
                NetworkManager.Singleton.StartHost();
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

