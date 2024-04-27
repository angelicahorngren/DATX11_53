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
    [SerializeField] public String NextSceneName;

    //private float _xOffset = 0, _yOffset = 0, _zOffset = 0;
    //private KeyCode key = KeyCode.E;


 /*   public void JoinScene(Component player){
       // PlaceCharacter(player);
    }
    private void PlaceCharacter(Component player){
            RaycastHit hit;
            Vector3 position = new Vector3(transform.position.x + _xOffset, transform.position.y, transform.position.z + _zOffset);
        
            if (Physics.Raycast(position, -Vector3.up, out hit)){
                //setOffsets();
                player.transform.position = new Vector3(
                    hit.point.x, 
                    hit.point.y + GetComponent<BoxCollider>().bounds.size.y/2,
                    hit.point.z
                );
            }
            
        
    }*/
/*    void setOffsets(){
        Vector3 size = GetComponent<BoxCollider>().bounds.size;
        _yOffset = size.y/2;

        switch (FrontDirection){
            case EnumDirections.X:
                _xOffset = size.x/2;
                _zOffset = 0;
            break;

            case EnumDirections.NotX:
                _xOffset = -size.x/2;
                _zOffset = 0;
            break;

            case EnumDirections.Z:
                _xOffset = 0;
                _zOffset = size.z/2;
            break;

            case EnumDirections.NotZ:
                _xOffset = 0;
                _zOffset = -size.z/2;
            break;

            default:
                _xOffset = 0;
                _zOffset = 0;
            break;
        }
    }
*/
 /*   void OnCollisionStay(Collision collisionInfo){ // when colliding with exit scene area
        

        String t = "Använd " + key + "För att " + WhatDo;
    }*/

    public void ExitScene(){ // exit scene
        NetworkManager.Singleton.SceneManager.LoadScene(NextSceneName, LoadSceneMode.Single); //make sure this doesn't do somehing weird
        
    }


    void OnDrawGizmos(){
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireCube(transform.position, GetComponent<BoxCollider>().bounds.size);
        //setOffsets();
       // Vector3 LineEnd = new Vector3(transform.position.x + _xOffset, transform.position.y, transform.position.z + _zOffset);

        //Debug.DrawLine(transform.position, LineEnd, Color.green);
    }
}
