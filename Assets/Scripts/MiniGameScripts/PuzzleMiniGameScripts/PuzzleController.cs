using UnityEngine;
using UnityEngine.SceneManagement;

public class PuzzleController : MonoBehaviour
{
    
    public GameObject PuzzleGameObject;
    
    // Start is called before the first frame update
    void Start()
    {
      
        
    }

    // OnTriggerEnter is called when the Collider other enters the trigger
    void OnTriggerEnter(Collider other)
    {
        // Check if the collider belongs to an object with the "mazeactivator" tag
        if (other.CompareTag("PuzzleActivator"))
        {
            // Check if the collider belongs to an object with the "Player" tag
            if (other.CompareTag("Player"))
            {
                // Enable the maze game object and canvas when the player collides with the maze activator
                SceneManager.LoadScene("PuzzleMiniGameScene");
                

                // You may want to add additional logic here to initialize the maze
            }
        }
    }

    // Method to finish the maze minigame
    public void FinishMazeMinigame()
    {
        // Disable the maze game object and canvas when the minigame is finished
        PuzzleGameObject.SetActive(false);
        
    }
}
