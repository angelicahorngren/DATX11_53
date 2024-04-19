using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Unity.Netcode;

public class InLevelSceneChange : NetworkBehaviour
{
    [SerializeField] public string WhatDo;
    [SerializeField] private EnumDirections FrontDirection;
    [SerializeField] public string Scene;

    private float _xOffset, _yOffset, _zOffset;
    private KeyCode key = KeyCode.E;

    private enum EnumDirections { Center, X, NotX, Z, NotZ }

    public void PlaceCharacter(Component player)
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, -Vector3.up, out hit))
        {
            SetOffsets();
            player.transform.position = new Vector3(
                hit.point.x + _xOffset,
                hit.point.y + _yOffset,
                hit.point.z + _zOffset
            );
        }
    }

    void SetOffsets()
    {
        Vector3 size = GetComponent<BoxCollider>().bounds.size;
        _yOffset = size.y / 2;

        switch (FrontDirection)
        {
            case EnumDirections.X:
                _xOffset = size.x / 2;
                _zOffset = 0;
                break;

            case EnumDirections.NotX:
                _xOffset = -size.x / 2;
                _zOffset = 0;
                break;

            case EnumDirections.Z:
                _xOffset = 0;
                _zOffset = size.z / 2;
                break;

            case EnumDirections.NotZ:
                _xOffset = 0;
                _zOffset = -size.z / 2;
                break;

            default:
                _xOffset = 0;
                _zOffset = 0;
                break;
        }
    }

    void OnCollisionStay(Collision collisionInfo)
    {
        foreach (ContactPoint contact in collisionInfo.contacts)
        {
            Debug.DrawRay(contact.point, contact.normal * 10, Color.white);
        }
    }

    private void ChangeScene()
    {
        SceneManager.LoadScene(Scene);
    }
}
