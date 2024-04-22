using Unity.Netcode;
using UnityEngine;

public class Player_Movement : NetworkBehaviour
{
    public Animator playerAnimation;
    public Rigidbody playerRigid;
    public float w_speed, rotation_speed;
    public Transform playerTransform;
    public bool walking, idle;

    void FixedUpdate()
    {
        if(!IsOwner) return;
        //movement
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        Vector3 movementDirection = new Vector3(horizontalInput, 0f, verticalInput).normalized;

        playerRigid.velocity = movementDirection * w_speed * Time.deltaTime;

        if (movementDirection != Vector3.zero)
        {
            Quaternion targetRotation = Quaternion.LookRotation(movementDirection);
            playerTransform.rotation = Quaternion.Slerp(playerTransform.rotation, targetRotation, rotation_speed * Time.deltaTime);
        }
        
    }

    void Update()
    {
        if(!IsOwner) return;
        //animation 
        bool anyKeyPressed = Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.D);

        walking = anyKeyPressed;
        idle = !anyKeyPressed;

        playerAnimation.SetBool("Walking", walking);
        playerAnimation.SetBool("Idle", idle);

        if(!anyKeyPressed)
        {
            playerRigid.velocity = Vector3.zero;
        }
    }





    
}
