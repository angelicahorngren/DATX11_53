using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerSpawnScript : NetworkBehaviour
{

    [SerializeField] public InforamtionKeeper inforamtionKeeper;
    private UnityEngine.SceneManagement.Scene OriginalScene;
    void Start(){
        OriginalScene = SceneManager.GetActiveScene();
        Spawn();
    }

    void Update(){   // checks when joined new scene
        if(!IsOwner) return;
        Debug.Log("update");
        UnityEngine.SceneManagement.Scene newScene = SceneManager.GetActiveScene();
        if(OriginalScene.buildIndex != newScene.buildIndex){
            OriginalScene = newScene;
            Spawn();
        }
    }

        private void Spawn(){ // on joining new scene
            if(!IsOwner) return;
            if(inforamtionKeeper.StartLevel){
                StartLevelSpawn();
                inforamtionKeeper.StartLevel = false;
            } else {
                ChangeSceneSpawn();
            }
        }

        private void StartLevelSpawn(){ // on joining new scene
       // try {
            GameObject SpawnPoint = GameObject.Find("SpawnPoint");
            RaycastHit hit;
            if (Physics.Raycast(
                SpawnPoint.transform.position, -Vector3.up, out hit)){
                float range = SpawnPoint.GetComponent<SpawnParameters>().range; // taken from the skript in the prefab SpawnPoint
                
                transform.position = new Vector3(
                    hit.point.x + UnityEngine.Random.Range(-range, range), 
                    hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y/2,
                    hit.point.z + UnityEngine.Random.Range(-range, range) 
                );
            }
       // } catch (NullReferenceException e){
       //     Debug.LogException(e);
       //     Debug.LogWarning(e);
       //     Debug.Log("Null point exception for no spawn point object for player in scene, buildindex: " + SceneManager.GetActiveScene().buildIndex);
       // }
            
        
    }


    void OnCollisionStay(Collision collisionInfo)
    {
        //GameObject DoorZone = GameObject.FindWithTag("Door Zone");
        // Debug-draw all contact points and normals
        if(collisionInfo.gameObject.tag.Equals("Door Zone") && Input.GetKeyDown(KeyCode.E)){
            GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().ExitScene();
        }
    }

    void OnCollisionEnter(Collision collision)
    {
        foreach (ContactPoint contact in collision.contacts)
        {
            Debug.DrawRay(contact.point, contact.normal, Color.white);
        }
    }


    private void ChangeSceneSpawn(){ // on joining new scene
       // GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().JoinScene(transform);

        GameObject area = GameObject.Find("SceneChangeArea");
        RaycastHit hit;
            Vector3 position = new Vector3(area.transform.position.x, area.transform.position.y, area.transform.position.z);
        
            if (Physics.Raycast(position, -Vector3.up, out hit)){
                //setOffsets();
                transform.position = new Vector3(
                    hit.point.x, 
                    hit.point.y + area.GetComponent<BoxCollider>().bounds.size.y/2,
                    hit.point.z
                );
            }

    }

}
