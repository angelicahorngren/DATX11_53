using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Netcode;
using UnityEngine;

public class CharacterControllerScript : NetworkBehaviour
{
    private CharacterController characterController;
    public float speed = 5f;
    

    /*public struct Test : INetworkSerializable {
        public FixedString128Bytes x;

        public void NetworkSerialize<T>(BufferSerializer<T> serializer) where T : IReaderWriter
        {
            serializer.SerializeValue(ref x);
        }
    }*/
    void Start()
    {
        characterController = GetComponent<CharacterController>();
    }

    /*public override void OnNetworkSpawn()
    {
        //if(!IsOwner) Destroy(this);
    }*/

    // Update is called once per frame
    void Update()
    {
        if(!IsOwner) return;
        Vector3 move = new Vector3(Input.GetAxis("Horizontal"),0,Input.GetAxis("Vertical"));
        characterController.Move(move * Time.deltaTime * speed);

    }


    /*[ServerRpc]
    private void TestServerRpc(){

    }*/


}
