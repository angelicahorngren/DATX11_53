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
   
    //private enum EnumDirections {Center, X, NotX, Z, NotZ}
    //[SerializeField] private EnumDirections FrontDirection;
    [SerializeField] public String MinigameSceneName;



    public void ExitScene(){ // exit scene
        //NetworkManager.Singleton.SceneManager.LoadScene(NextSceneName, LoadSceneMode.Additive); //make sure this doesn't do somehing weird
        SceneManager.LoadSceneAsync(MinigameSceneName, LoadSceneMode.Additive);
        //LightProbes.Tetrahedralize();
        
    }


    void OnDrawGizmos(){
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireCube(transform.position, GetComponent<BoxCollider>().bounds.size);
        //setOffsets();
       // Vector3 LineEnd = new Vector3(transform.position.x + _xOffset, transform.position.y, transform.position.z + _zOffset);

        //Debug.DrawLine(transform.position, LineEnd, Color.green);
    }
}
