using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CharacterControllerScript : NetworkBehaviour
{
    private Rigidbody rb;
    public float speed = 5f;
    private UnityEngine.SceneManagement.Scene originalScene;

    private bool isActive = true;

    void Start()
    {
        if (!IsOwner) return;
        rb = GetComponent<Rigidbody>();
        
        //DontDestroyOnLoad(gameObject);

        if (IsLocalPlayer && FollowCam.mainCam != null && FollowCam.secondCam == null)
        {
            FollowCam.secondCam = Instantiate(FollowCam.mainCam.gameObject, Vector3.zero, Quaternion.identity).GetComponent<FollowCam>();
            FollowCam.secondCam.name = "SecondCam";
            FollowCam.secondCam.target = rb.transform;

            //disable audio listener on second camera (only 1 allowed..)
            FollowCam.secondCam.GetComponent<AudioListener>().enabled = false;
        }
        else if (IsLocalPlayer && FollowCam.mainCam != null && FollowCam.secondCam != null)
        {
            return;
        }
        else if (IsLocalPlayer)
        {
            FollowCam.mainCam = FindObjectOfType<FollowCam>();
            FollowCam.mainCam.target = rb.transform;
        }

        originalScene = SceneManager.GetActiveScene();
    }

    // Update is called once per frame
    void Update()
    {
        if (!isActive || !IsOwner) return;
        Vector3 move = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        move *= speed * Time.deltaTime;
        rb.MovePosition(transform.position + move);

        UnityEngine.SceneManagement.Scene newScene = SceneManager.GetActiveScene();
        if (originalScene.buildIndex != newScene.buildIndex)
        {
            originalScene = newScene;
            Start();
        }
    }

    public void SetActive(bool active)
    {
        isActive = active;
    }
}
