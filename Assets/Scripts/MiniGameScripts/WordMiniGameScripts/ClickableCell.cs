using UnityEngine;

public class ClickableCell : MonoBehaviour
{
    public WordSearchGridGenerator generator;

    void Start()
    {
        generator = GameObject.FindObjectOfType<WordSearchGridGenerator>();
    }

    void OnMouseDown()
        {
            if (generator != null)
            {
                generator.OnCellClick(gameObject);
                Debug.Log("Cell clicked");
            }
            else
            {
                Debug.Log("Generator not found");
            }

        }
}
