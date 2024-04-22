using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEngine;

public class NetworkConnectionManager : NetworkBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.T)){ // a test
            TestServerRpc();
        }
    }



    [ServerRpc]
    private void TestServerRpc(){
        Debug.Log("test TestServerRpc; " + OwnerClientId);
    }


    // may be temporary (unfinished)
    [ClientRpc]
    private void HostLeaveClientRpc(){
        Debug.Log("before");
        NetworkManager.Singleton.Shutdown();
        Debug.Log("after");
    }
    // may be temporary (unfinished)
    private void Leave(){
        if(IsHost){
            HostLeaveClientRpc();
        } else {
            NetworkManager.Singleton.Shutdown();
        }
    }
    // may be temporary (unfinished)
    public void OnApplicationQuit()
    {      
        Leave();
    }
}
