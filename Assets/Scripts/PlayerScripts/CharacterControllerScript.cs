using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CharacterControllerScript : NetworkBehaviour
{
    //private CharacterController characterController;
    private Rigidbody rb;
    public float speed = 5f;
    

    private UnityEngine.SceneManagement.Scene OriginalScene;

    /*public struct Test : INetworkSerializable {
        public FixedString128Bytes x;

        public void NetworkSerialize<T>(BufferSerializer<T> serializer) where T : IReaderWriter
        {
            serializer.SerializeValue(ref x);
        }
    }*/

    void Start()
    {
        if(!IsOwner) return;
        rb = GetComponent<Rigidbody>();

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


        OriginalScene = SceneManager.GetActiveScene();
        
    }



    /*public override void OnNetworkSpawn()
    {
        //if(!IsOwner) Destroy(this);
    }*/

    // Update is called once per frame
    void Update()
    {
        if(!IsOwner) return;
        Vector3 move = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        move *= speed * Time.deltaTime;
        rb.MovePosition(transform.position + move);



        UnityEngine.SceneManagement.Scene newScene = SceneManager.GetActiveScene();
        if(OriginalScene.buildIndex != newScene.buildIndex){
            OriginalScene = newScene;
            Start();
        }
    }



    /*[ServerRpc]
    private void TestServerRpc(){

    }*/


}
