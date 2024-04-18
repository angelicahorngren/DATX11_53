using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using UnityEditor.SearchService;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerSpawnScript : NetworkBehaviour
{

    [SerializeField] public InforamtionKeeper inforamtionKeeper;
    private UnityEngine.SceneManagement.Scene OriginalScene;
    void Start()
    {
        OriginalScene = SceneManager.GetActiveScene();
        Spawn();
    }

    // Update is called once per frame
    void Update()
    {
        if(!IsOwner) return;
        UnityEngine.SceneManagement.Scene newScene = SceneManager.GetActiveScene();
        if(OriginalScene.buildIndex != newScene.buildIndex){
            Spawn();
            OriginalScene = newScene;
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
        GameObject SpawnPoint = GameObject.Find("Level1SpawnPoint");
        RaycastHit hit;
        if (Physics.Raycast(
            SpawnPoint.transform.position, -Vector3.up, out hit)){
            //Vector3 location = new Vector3(hit.point.x, hit.point.y +0.05f, hit.point.z);
            float range = SpawnPoint.GetComponent<SpawnParameters>().range; // taken from teh skript in the prefab SpawnPoint
            
            transform.position = new Vector3(
                hit.point.x + Random.Range(-range, range), 
                hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y/2,  //temp 0.05f
                hit.point.z + Random.Range(-range, range) 
            );
        }
    }
    private void ChangeSceneSpawn(){
        GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().PlaceCharacter(transform);
    }

}
