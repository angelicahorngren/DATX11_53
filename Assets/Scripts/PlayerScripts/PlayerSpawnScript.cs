using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Unity.Netcode;

public class PlayerSpawnScript : NetworkBehaviour
{
    [SerializeField] public InforamtionKeeper inforamtionKeeper; // Assuming this is intentional
    private Scene OriginalScene;

    
    void Start()
    {
        if(!IsOwner) return;
        OriginalScene = SceneManager.GetActiveScene();
        Spawn();
    }

    // Update is called once per frame
    void Update()
    {
        if(!IsOwner) return;

        UnityEngine.SceneManagement.Scene newScene = SceneManager.GetActiveScene();
        if(OriginalScene.buildIndex != newScene.buildIndex){
            OriginalScene = newScene;
            Spawn();
        }
    }

        private void Spawn(){
            if(!IsOwner) return;

            if(inforamtionKeeper.StartLevel){
                StartLevelSpawn();
                inforamtionKeeper.StartLevel = false;
            } else {
                ChangeSceneSpawn();
            }
        }

        private void StartLevelSpawn(){
        // try {
            GameObject SpawnPoint = GameObject.Find("SpawnPoint");
            //if (SpawnPoint != null){
                RaycastHit hit;
                if (Physics.Raycast(SpawnPoint.transform.position, -Vector3.up, out hit)){
                    float range = SpawnPoint.GetComponent<SpawnParameters>().range; // taken from the skript in the prefab SpawnPoint
                    
                    transform.position = new Vector3(
                        hit.point.x + UnityEngine.Random.Range(-range, range), 
                        hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y/2,
                        hit.point.z + UnityEngine.Random.Range(-range, range) 
                    );
                }

            //} else {
             //   ChangeSceneSpawn();
             //   Debug.LogError("SpawnPoint not found.");
            //}
       // } //catch (NullReferenceException e){
       //     Debug.LogException(e);
       //     Debug.LogWarning(e);
       //     Debug.Log("Null point exception for no spawn point object for player in scene, buildindex: " + SceneManager.GetActiveScene().buildIndex);
       // }
            
        }

    private void ChangeSceneSpawn(){ // joining scene

        GameObject area = GameObject.Find("SceneChangeArea");
        if (area != null){
            RaycastHit hit;
            Vector3 position = new Vector3(area.transform.position.x, area.transform.position.y, area.transform.position.z);
            if (Physics.Raycast(position, -Vector3.up, out hit)){
                //setOffsets();
                transform.position = new Vector3(
                    hit.point.x, 
                    hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y/2,
                    hit.point.z
                );
            }
        }
    }

    /*void OnCollisionStay(Collision collisionInfo) // leaving scene
    {
        if(collisionInfo.gameObject.tag.Equals("Door Zone") && Input.GetKeyDown(KeyCode.E)){
            GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().ExitScene();
        }
    }*/

    void OnTriggerStay(Collider collisionInfo) // leaving scene
    {
        Debug.Log("triggerStay");
        if(collisionInfo.gameObject.tag.Equals("Door Zone") && Input.GetKeyDown(KeyCode.E)){
        //if(Input.GetKeyDown(KeyCode.E)){
            GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().ExitScene();
        }
    }

}
