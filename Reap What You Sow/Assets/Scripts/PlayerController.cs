using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    private Vector3 input;
    private Vector3 rotate;
    [SerializeField] private Rigidbody rigidbody;
    [SerializeField] private float speed = 3f;
   

  
    // Update is called once per frame
    void FixedUpdate()
    {
        if(Input.anyKey)
        {
            GetMovement();
        }
       
    }
    void Start()
    {
        input = Camera.main.transform.forward;
        input.y = 0;
        input = Vector3.Normalize(input);
        rotate = Quaternion.Euler(new Vector3(0, 90, 0)) * input;


    }
    void GetMovement()
    {
        Vector3 direction = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        Vector3 righttMovement = rotate * speed * Time.deltaTime * Input.GetAxis("Horizontal");
        Vector3 upwardMovement = input * speed * Time.deltaTime * Input.GetAxis("Vertical");

        //tracks the direction the player is currently going toward
        Vector3 currentDirection = Vector3.Normalize(righttMovement + upwardMovement);
        transform.forward = currentDirection;
        transform.position += righttMovement;
        transform.position += upwardMovement;

    }
}
