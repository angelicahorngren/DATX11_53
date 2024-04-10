using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using Unity.Netcode;
using UnityEngine;
using UnityEngine.UIElements;

public class PlayerNetwork : NetworkBehaviour
{
    //Makes sure the other players get and send updated movement
    private readonly NetworkVariable<PlayerNetworkData> _netState = new NetworkVariable<PlayerNetworkData>(writePerm: NetworkVariableWritePermission.Owner);
    private void Update()
    {
         if(IsOwner){
            _netState.Value = new PlayerNetworkData(){
                Position = transform.position,
                Rotation = transform.rotation.eulerAngles
            };
            
        }
        else {
            transform.position = _netState.Value.Position;
            transform.rotation = Quaternion.Euler(0, _netState.Value.Rotation.y, 0);
        }



        if(Input.GetKeyDown(KeyCode.T)){ // a test
            NetworkPlayerStateServerRpc();
        }
    }


    struct PlayerNetworkData : INetworkSerializable {
        private float _x, _y, _z;
        private float _yRot;

        internal Vector3 Position {
            get => new Vector3(_x, _y, _z);
            set {
                _x = value.x;
                _y = value.y;
                _z = value.z;
            }
        }
        internal Vector3 Rotation {
            get => new Vector3(0, _yRot, 0);
            set => _yRot = value.y;
        }
        public void NetworkSerialize<T>(BufferSerializer<T> serializer) where T : IReaderWriter {
            serializer.SerializeValue(ref _x);
            serializer.SerializeValue(ref _y);
            serializer.SerializeValue(ref _z);
            serializer.SerializeValue(ref _yRot);
        }
    }

    [ServerRpc]
    private void NetworkPlayerStateServerRpc(){
        Debug.Log("test NetworkPlayerStateServerRpc; " + OwnerClientId);
    }

    [ClientRpc]
    private void NetworkPlayerStateClientRpc(){

    }
}
