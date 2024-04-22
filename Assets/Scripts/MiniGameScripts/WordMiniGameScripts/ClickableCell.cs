using UnityEngine;

public class ClickableCell : MonoBehaviour
{
    public WordSearchGridGenerator generator;
    public int row;
    public int column;
    public Vector2Int cellPosition;

    public void SetCellPosition(int row, int column)
    {
        cellPosition = new Vector2Int(row, column);
    }

    void Start()
    {
        generator = GameObject.FindObjectOfType<WordSearchGridGenerator>();
    }

    void OnMouseDown()
        {
            generator.OnCellClick(gameObject);
        }
}
