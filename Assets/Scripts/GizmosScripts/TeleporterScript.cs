using System.Collections;
using System.Collections.Generic;
using Unity.Netcode;
using Unity.VisualScripting;
using UnityEngine;

public class TeleporterScript : NetworkBehaviour
{

    //private enum EnumDirections {Center, X, NotX, Z, NotZ}
    //[SerializeField] private EnumDirections FrontDirection; // used to determine player rotation after teleported
    [SerializeField] public GameObject Destination;

    //private float _xOffset = 0, _yOffset = 0, _zOffset = 0;

    void OnDrawGizmos(){
        Gizmos.color = Color.cyan;
        Gizmos.DrawWireCube(transform.position, GetComponent<BoxCollider>().bounds.size);
        //setOffsets();
        //Vector3 LineEnd = new Vector3(transform.position.x + _xOffset, transform.position.y, transform.position.z + _zOffset);

        //Debug.DrawLine(transform.position, LineEnd, Color.green);
    }

   /* void setOffsets(){
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
    }*/

}
