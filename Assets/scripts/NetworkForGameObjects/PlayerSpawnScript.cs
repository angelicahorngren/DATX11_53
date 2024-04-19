using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Unity.Netcode;

public class PlayerSpawnScript : NetworkBehaviour
{
    [SerializeField] public InforamtionKeeper inforamtionKeeper; // Assuming this is intentional
    private Scene originalScene;

    void Start()
    {
        originalScene = SceneManager.GetActiveScene();
        Spawn();
    }

    void Update()
    {
        if (!IsOwner) return;
        Scene newScene = SceneManager.GetActiveScene();
        if (originalScene.buildIndex != newScene.buildIndex)
        {
            Spawn();
            originalScene = newScene;
        }
    }

    private void Spawn()
    {
        if (!IsOwner) return;
        if (inforamtionKeeper.StartLevel)
        {
            StartLevelSpawn();
            inforamtionKeeper.StartLevel = false;
        }
        else
        {
            ChangeSceneSpawn();
        }
    }

    private void StartLevelSpawn()
    {
        GameObject spawnPoint = GameObject.Find("Level1SpawnPoint");
        if (spawnPoint != null)
        {
            RaycastHit hit;
            if (Physics.Raycast(spawnPoint.transform.position, -Vector3.up, out hit))
            {
                float range = spawnPoint.GetComponent<SpawnParameters>().range;
                transform.position = new Vector3(
                    hit.point.x + Random.Range(-range, range),
                    hit.point.y + GetComponent<CapsuleCollider>().bounds.size.y / 2,
                    hit.point.z + Random.Range(-range, range)
                );
            }
        }
        else
        {
            Debug.LogError("Level1SpawnPoint not found.");
        }
    }

    private void ChangeSceneSpawn()
    {
        GameObject sceneChangeArea = GameObject.Find("SceneChangeArea");
        if (sceneChangeArea != null)
        {
            sceneChangeArea.GetComponent<InLevelSceneChange>().PlaceCharacter(transform);
        }
        else
        {
            Debug.LogError("SceneChangeArea not found.");
        }
    }
}
