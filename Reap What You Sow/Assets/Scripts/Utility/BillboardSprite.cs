using UnityEngine;

public class BillboardSprite : MonoBehaviour
{
    private Camera mainCamera;

    private void Start()
    {
        mainCamera = Camera.main;
    }

    private void LateUpdate()
    {
        transform.rotation = mainCamera.transform.rotation;
    }
}