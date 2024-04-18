using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnParameters : MonoBehaviour
{
    [SerializeField] public float range;
    void OnDrawGizmos(){
        RaycastHit hit;
        if (Physics.Raycast(transform.position, -Vector3.up, out hit)){
            Debug.DrawLine(transform.position, hit.point, Color.yellow);
            Gizmos.color = Color.yellow;
            Gizmos.DrawWireSphere(hit.point, range);
            
        }
    }
}
