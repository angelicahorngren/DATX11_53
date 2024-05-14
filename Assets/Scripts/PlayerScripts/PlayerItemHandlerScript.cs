using System;
using UnityEngine;
using System.Collections;

public class PlayerItemHandlerScript : MonoBehaviour
{
    enum EnumItems { Empty, MagnifyingGlass, NotePad, Blacklight }
    [SerializeField] private EnumItems ItemInHand;
    private GameObject itemInHandObject;

    // Update is called once per frame
    void Update()
    {

    }

    IEnumerator Wait()
    {
        yield return new WaitForSeconds(1);

    }
    void OnTriggerStay(Collider other) 
    {
        
        if(other.gameObject.CompareTag("Interactable") && Input.GetKeyDown(KeyCode.Return) && (ItemInHand == EnumItems.Empty))
        {
            switch (other.gameObject.name)
            {
                case "MagnifyingGlass":
                Debug.Log("picking up magnifying glass");
                    PickUpItem(EnumItems.MagnifyingGlass, other.gameObject);
                    break;
                case "NotePad":
                Debug.Log("picking up notepad");
                    PickUpItem(EnumItems.NotePad, other.gameObject);
                    break;
                case "Blacklight":
                Debug.Log("picking up blacklight");
                    PickUpItem(EnumItems.Blacklight, other.gameObject);
                    break;
            }
            StartCoroutine(Wait());

        }

        else if(other.gameObject.CompareTag("DropArea") && Input.GetKeyDown(KeyCode.Return) && (ItemInHand != EnumItems.Empty))
        {
            DropItem();
            StartCoroutine(Wait());
        }

    }

    

    void PickUpItem(EnumItems newItem, GameObject itemObject)
    {
            ItemInHand = newItem;
            itemInHandObject = itemObject;
            //Debug.Log(ItemInHand);
            itemObject.SetActive(false);
            
    }

    void DropItem()
    {
        
            itemInHandObject.SetActive(true);
            Debug.Log("dropped " + itemInHandObject);
            itemInHandObject = null;
            ItemInHand = EnumItems.Empty;
            
        
    }

    private EnumItems GetItemInHand()
    {
        return ItemInHand;
    }
}
