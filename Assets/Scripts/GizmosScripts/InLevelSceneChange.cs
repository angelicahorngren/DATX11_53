using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;


public class InLevelSceneChange : NetworkBehaviour
{

    [SerializeField] public String WhatDo;
    private Scene currentMiniGame;
   
    //private enum EnumDirections {Center, X, NotX, Z, NotZ}
    //[SerializeField] private EnumDirections FrontDirection;
    [SerializeField] public String MinigameSceneName;
    public static FollowCam MainCamReference;

    

    public void ExitScene(string minigameSceneName, FollowCam mainCam)
    {
        MainCamReference = mainCam;
        Debug.Log(minigameSceneName);
        StartCoroutine(LoadAndSetActiveScene(minigameSceneName));

    }

    private IEnumerator LoadAndSetActiveScene(string minigameSceneName)
    {
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(minigameSceneName, LoadSceneMode.Additive);

        while (!asyncLoad.isDone)
        {
            yield return null;
        }

        Scene currentMiniGame = SceneManager.GetSceneByName(minigameSceneName);
        SceneManager.SetActiveScene(currentMiniGame);
    }


    void OnDrawGizmos(){
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireCube(transform.position, GetComponent<BoxCollider>().bounds.size);
        //setOffsets();
       // Vector3 LineEnd = new Vector3(transform.position.x + _xOffset, transform.position.y, transform.position.z + _zOffset);

        //Debug.DrawLine(transform.position, LineEnd, Color.green);
    }
}
