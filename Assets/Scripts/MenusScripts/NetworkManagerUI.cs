using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class NetworkManagerUI : MonoBehaviour
{

    [SerializeField] public InforamtionKeeper inforamtionKeeper;

     void Start()
    {
        inforamtionKeeper.StartLevel = true;
        if(inforamtionKeeper.JoinCode == ""){
                
                Debug.Log("HOSTHOSTHOST");
                NetworkManager.Singleton.StartHost();
                //NetworkManager.Singleton.StartServer();
                //NetworkManager.Singleton.SceneManager.ActiveSceneSynchronizationEnabled = false;
                //NetworkManager.Singleton.SceneManager.LoadScene("OutsideHouse", LoadSceneMode.Additive);
                SceneManager.LoadSceneAsync("OutsideHouse", LoadSceneMode.Additive);
                //LightProbes.Tetrahedralize();
                SceneManager.LoadSceneAsync("InsideHouse", LoadSceneMode.Additive);
                LightProbes.Tetrahedralize();
        } else {
                Debug.Log("CLIENTCLIENTCLIENT");
                NetworkManager.Singleton.StartClient();
                
        }
    }

}

