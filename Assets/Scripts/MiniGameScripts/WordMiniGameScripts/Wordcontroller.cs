using UnityEngine;
using UnityEngine.SceneManagement;


public class Wordcontroller : MonoBehaviour
{
    public GameObject WordsearchGameObject;
    void Start()
    {
      
        
    }



    // OnTriggerEnter is called when the Collider other enters the trigger
    void OnTriggerEnter(Collider other)
    {
        // Check if the collider belongs to an object with the "mazeactivator" tag
        if (other.CompareTag("Wordsearchactivator"))
        {
            // Check if the collider belongs to an object with the "Player" tag
            if (other.CompareTag("Player"))
            {
                // Enable the maze game object and canvas when the player collides with the maze activator
                SceneManager.LoadScene("WordMiniGameScene");
                

                // You may want to add additional logic here to initialize the maze
            }
        }
    }

    // Method to finish the maze minigame
    public void FinisWordsearchgame()
    {
        // Disable the maze game object and canvas when the minigame is finished
        WordsearchGameObject.SetActive(false);
        
    }
}
