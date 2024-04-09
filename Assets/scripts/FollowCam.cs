using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCam : MonoBehaviour 
{
	public Transform target;
	public static FollowCam mainCam;
	public static FollowCam secondCam;
	public float camXpos = 0, camYpos = 50, camZpos = 0, fov = 80.5f;

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
        if (target != null)
        {
            transform.position = target.position + new Vector3(camXpos, camYpos, (camZpos - 0f));
            transform.LookAt(target);
        }
        else
        {
            Debug.LogWarning("target is assigned at spawn");
        }
    }
}


