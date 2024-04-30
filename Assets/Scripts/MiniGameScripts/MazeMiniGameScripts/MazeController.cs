using UnityEngine;

public class MazeController : MonoBehaviour
{
    
    public GameObject mazeGameObject;

    // Start is called before the first frame update
    void Start()
    {
        // Disable the maze game object initially
        mazeGameObject.SetActive(false);
    }

    // OnTriggerEnter is called when the Collider other enters the trigger
    void OnTriggerEnter(Collider other)
    {
        // Check if the collider belongs to an object with the "mazeactivator" tag
        if (other.CompareTag("mazeactivator"))
        {
            // Check if the collider belongs to an object with the "Player" tag
            if (other.CompareTag("Player"))
            {
                // Enable the maze game object and canvas when the player collides with the maze activator
                mazeGameObject.SetActive(true);
                

                // You may want to add additional logic here to initialize the maze
            }
        }
    }

    // Method to finish the maze minigame
    public void FinishMazeMinigame()
    {
        // Disable the maze game object and canvas when the minigame is finished
        mazeGameObject.SetActive(false);
        
    }
}
