using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
//using UnityEditor.SearchService;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class backtogame : MonoBehaviour
{
    [SerializeField] private Button BackToGameButton;
    
    [SerializeField] private FollowCam mainCam;
    [SerializeField] private Camera miniGameCamera;
    private Scene currentScene;
    public GameObject winScreen;

  public void BackToGameButtonClicked()
    {
        print("Back to game button clicked");
        miniGameCamera = FindObjectOfType<Camera>();
        miniGameCamera.gameObject.SetActive(false);
        winScreen.gameObject.SetActive(false);
        FollowCam mainCam = InLevelSceneChange.MainCamReference;
        if (mainCam != null)
        {
            Debug.Log(mainCam);
            mainCam.gameObject.SetActive(true);
            currentScene = SceneManager.GetActiveScene();
            SceneManager.UnloadScene(currentScene);
        }
        else
        {
            Debug.LogError("maincam is null");
        }

        
    }
    void Start()
    {
        BackToGameButton.onClick.AddListener(BackToGameButtonClicked);
       
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void SetMainCam(FollowCam cam)
    {
        mainCam = cam;
    }

}
