using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Unity.Netcode;

public class PlayerSpawnScript : NetworkBehaviour
{
    [SerializeField] public InforamtionKeeper inforamtionKeeper;
    private Scene originalScene;
    private bool firstSpawn;

    void Start()
    {
        if (!IsOwner) return;
        originalScene = SceneManager.GetActiveScene();
        firstSpawn = true;

    }


    IEnumerator Wait()
    {
        yield return new WaitForSeconds(2);

    }
    void Update()
    {
        if (!IsOwner) return;


        for (int i = 0; i < SceneManager.sceneCount; i++)
        {
            var loadedScene = SceneManager.GetSceneAt(i);
            GameObject sceneP = GameObject.Find(loadedScene.name);

            if (IsPlayerInSceneBounds(loadedScene) && firstSpawn)
            {
                if (originalScene.name != loadedScene.name)
                {
                    originalScene = loadedScene;
                    firstSpawn = false;
                    Spawn(sceneP);
                    Wait();
                }
            }
        }
    }

    bool IsPlayerInSceneBounds(Scene scene)
    {
        GameObject sceneParent = GameObject.Find(scene.name);
        if (sceneParent != null)
        {
            Bounds bounds = GetBoundsOfGameObject(sceneParent);
            if (bounds.Contains(transform.position))
            {
                return true;
            }
        }
        return false;
    }

    Bounds GetBoundsOfGameObject(GameObject obj)
    {
        Renderer[] renderers = obj.GetComponentsInChildren<Renderer>();

        if (renderers.Length > 0)
        {
            Bounds combinedBounds = renderers[0].bounds;

            for (int i = 1; i < renderers.Length; i++)
            {
                combinedBounds.Encapsulate(renderers[i].bounds);
            }

            return combinedBounds;
        }

        return new Bounds();
    }

        private void Spawn(GameObject sceneP){
            if(!IsOwner) return;
            StartLevelSpawn(sceneP);
        }

       private void StartLevelSpawn(GameObject sceneP)
        {
            Transform spawnPointTransform = sceneP.transform.Find("SpawnPoint");

            if (spawnPointTransform != null)
            {
                GameObject spawnPoint = spawnPointTransform.gameObject;
                Debug.Log("spawn point found");

                RaycastHit hit;
                if (Physics.Raycast(spawnPoint.transform.position, -Vector3.up, out hit))
                {
                    float range = spawnPoint.GetComponent
                                <SpawnParameters>().range;

                    transform.position = new Vector3(
                        hit.point.x + UnityEngine.Random.Range(-range, range), 
                        hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y / 2,
                        hit.point.z + UnityEngine.Random.Range(-range, range) 
                    );
                }
            }
            else
            {
                Debug.LogError("spawn point not found");
            }
        }

 


    
    private void ChangeSceneSpawn(){ // joining scene

        GameObject area = GameObject.Find("SceneChangeArea");
        if (area != null){
            RaycastHit hit;
            Vector3 position = new Vector3(area.transform.position.x, area.transform.position.y, area.transform.position.z);
            if (Physics.Raycast(position, -Vector3.up, out hit)){
                Debug.LogError("scenechangearea found, if statement run");
                transform.position = new Vector3(
                    hit.point.x, 
                    hit.point.y + area.GetComponent<BoxCollider>().bounds.size.y/2,
                    hit.point.z
                );
            }
        }
        else
        {
            Debug.Log("scenechangearea not found");
        }
    }

    void OnTriggerStay(Collider collisionInfo) // leaving scene
    {
        if(collisionInfo.gameObject.CompareTag("Door Zone") && Input.GetKeyDown(KeyCode.E))
        {
            //GameObject.Find("SceneChangeArea").GetComponent<InLevelSceneChange>().ExitScene();

            StartCoroutine(PerformDelayedSpawn());
        }

        if(Input.GetKeyDown(KeyCode.T)){ //teleporter
            TP(collisionInfo.GetComponent<TeleporterScript>().Destination);
        //if(Input.GetKeyDown(KeyCode.E)){
            
        }
    }

    IEnumerator PerformDelayedSpawn()
    {
        //yield return new WaitForSeconds(0.1f);

        for (int i = 0; i < SceneManager.sceneCount; i++)
        {
            var loadedScene = SceneManager.GetSceneAt(i);

            if (!IsPlayerInSceneBounds(loadedScene) && (loadedScene.name == "InsideHouse"))
            {
                GameObject sceneP = GameObject.Find(loadedScene.name);
                if (originalScene.name != loadedScene.name)
                {
                    originalScene = loadedScene;
                    Debug.Log(sceneP);
                    Spawn(sceneP);
                    SceneManager.SetActiveScene(loadedScene);
                    yield return new WaitForSeconds(0.5f);

                }

                break;
            }

            if (!IsPlayerInSceneBounds(loadedScene) && (loadedScene.name == "OutsideHouse"))
            {
                GameObject sceneP = GameObject.Find(loadedScene.name);
                if (originalScene.name != loadedScene.name)
                {
                    originalScene = loadedScene;
                    Debug.Log(sceneP);
                    Spawn(sceneP);
                    SceneManager.SetActiveScene(loadedScene);
                    yield return new WaitForSeconds(0.5f);

                }

                break;
            }
        }}
    

    private void TP(GameObject Destination){

        if (Destination != null){
            RaycastHit hit;
            Vector3 position = new Vector3(Destination.transform.position.x, Destination.transform.position.y, Destination.transform.position.z);
            if (Physics.Raycast(position, -Vector3.up, out hit)){
                transform.position = new Vector3(
                    hit.point.x, 
                    hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y/2,
                    hit.point.z
                );
            }
        } else {
            Debug.LogError("No destination given for teleport");
        }


    }

}

