using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCam : MonoBehaviour 
{
    public Transform? target;
    public static FollowCam mainCam;
    public static FollowCam secondCam;
    private float camXpos = 0, camYpos = 5, camZpos = 0, fov = 80.5f;

    void Awake()
    {
        if (mainCam == null)
        {
            mainCam = this;
        }
        else if (secondCam == null)
        {
            secondCam = this;
        }
    }

    void LateUpdate()
    {
        /*if (target != null)
        {
            Debug.LogWarning("target is not assigned at spawn");
        }*/
        if (target != null)
        {
            
            Transform player1 = target.Find("Player1");
            transform.position = player1.position + new Vector3(camXpos, camYpos, (camZpos - 0f));
            transform.rotation = player1.rotation;
            transform.LookAt(player1);

            if (player1 == null)
            {
                Debug.LogWarning("player1 not found");
            }
        }
    }
}
