using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using TMPro;
using Unity.Netcode;
using Unity.Netcode.Transports.UTP;
using Unity.Networking.Transport.Relay;
using Unity.Services.Authentication;
using Unity.Services.Core;
using Unity.Services.Relay;
using Unity.Services.Relay.Models;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MultiplayerRelayScript : MonoBehaviour
{
   [SerializeField] public InforamtionKeeper inforamtionKeeper;
   [SerializeField] private TMP_Text JoinCodeShowArea;
   //initiate Unity Services
   private async void Start(){
        await UnityServices.InitializeAsync();

        //unity authentication
        AuthenticationService.Instance.SignedIn += () => {
            Debug.Log("Signed in: " + AuthenticationService.Instance.PlayerId);
        };
        if (!AuthenticationService.Instance.IsSignedIn){ //makes sure you dont sign in twice
            await AuthenticationService.Instance.SignInAnonymouslyAsync();
        }
        

        if(inforamtionKeeper.JoinCode == ""){
            await CreateRelay();
        } else {
            JoinRelay(inforamtionKeeper.JoinCode);
        }
   }

   public async Task<string> CreateRelay(){
    try {
        Allocation allocation = await RelayService.Instance.CreateAllocationAsync(3); //max number of clients to a host.

        String joinCode = await RelayService.Instance.GetJoinCodeAsync(allocation.AllocationId);
        Debug.Log(joinCode);

        RelayServerData relayServerData = new RelayServerData(allocation, "dtls");
        NetworkManager.Singleton.GetComponent<UnityTransport>().SetRelayServerData(relayServerData);
        /*NetworkManager.Singleton.GetComponent<UnityTransport>().SetHostRelayData( //old version (non-functional)
            allocation.RelayServer.IpV4,
            (ushort)allocation.RelayServer.Port,
            allocation.AllocationIdBytes,
            allocation.Key,
            allocation.ConnectionData
        );*/

        NetworkManager.Singleton.StartHost();

        SceneManager.LoadSceneAsync("OutsideHouse", LoadSceneMode.Additive);
                //LightProbes.Tetrahedralize();
        SceneManager.LoadSceneAsync("InsideHouse", LoadSceneMode.Additive);
        LightProbes.Tetrahedralize();

        ShowJoinCodeInHud(joinCode);
        return joinCode;

    } catch (RelayServiceException e) {
        Debug.Log(e);
        return null;
    }
    
   }

    public async void JoinRelay(String joinCode){
        try {
            Debug.Log("Joining Relay with joinCode: " + joinCode);
            joinCode = joinCode.Substring(0, 6); //TMPro input field puts a blank space at end of string, this line removes that
            JoinAllocation joinAllocation = await RelayService.Instance.JoinAllocationAsync(joinCode);

            RelayServerData relayServerData = new RelayServerData(joinAllocation, "dtls");
            NetworkManager.Singleton.GetComponent<UnityTransport>().SetRelayServerData(relayServerData);
            /*NetworkManager.Singleton.GetComponent<UnityTransport>().SetClientRelayData( //old version (non-functional)
            joinAllocation.RelayServer.IpV4,
            (ushort)joinAllocation.RelayServer.Port,
            joinAllocation.AllocationIdBytes,
            joinAllocation.Key,
            joinAllocation.ConnectionData,
            joinAllocation.HostConnectionData
        );*/

            NetworkManager.Singleton.StartClient();

            ShowJoinCodeInHud(joinCode);
        } catch (RelayServiceException e) {
            NetworkManager.Singleton.Shutdown();
            SceneManager.LoadScene("mainmenu"); //DOESNT WORK BECASUE DOESNT DELETE DON'T DESTROY ON LOAD CORRECTLY
            Debug.Log(e);
        }
    }


    private void ShowJoinCodeInHud(String joinCode){
        JoinCodeShowArea.text = joinCode;
    }
   
}
