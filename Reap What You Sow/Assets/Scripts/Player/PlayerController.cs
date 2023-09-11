using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    //movement variables
    private Vector3 input;
    private Vector3 rotate;
    [SerializeField] private Rigidbody rigidbody;
    [SerializeField] private float speed = 3f;
   
    // Interaction Variables
    [SerializeField] private float interactionRange = 2f; // The range within which the player can interact with objects
    [SerializeField] private LayerMask interactionLayer;  // LayerMask to filter out objects that aren't interactable

  
    // Update is called every frame
    void Update()
    {
        if(Input.anyKey)
        {
            GetMovement();
        }

        if (Input.GetKeyUp("e"))
        {
            Interact();
        }
    }

    void Start()
    {
        //any movement input will allow the character to be followed by the camera
        input = Camera.main.transform.forward;

        input.y = 0; //locks the y-axis so there's no floating or other funny business with gravity.  Keeps player grounded. 

        input = Vector3.Normalize(input);

        rotate = Quaternion.Euler(new Vector3(0, 90, 0)) * input;


    }

    void GetMovement()
    {
        //direction is what acquires the input from the keyboard.  Unity defaults to WASD config for movement.  Add rebindable keys later.
        Vector3 direction = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        
        Vector3 righttMovement = rotate * speed * Time.deltaTime * Input.GetAxis("Horizontal");
        
        Vector3 upwardMovement = input * speed * Time.deltaTime * Input.GetAxis("Vertical");

        //tracks the direction the player is currently going toward
        Vector3 currentDirection = Vector3.Normalize(righttMovement + upwardMovement);

        transform.forward = currentDirection;

        transform.position += righttMovement;

        transform.position += upwardMovement;

    }

    void Interact()
    {
        Collider[] hits = Physics.OverlapSphere(transform.position, interactionRange, interactionLayer);

        foreach (var hit in hits)
        {
            if (hit.CompareTag("NPC"))
            {
                hit.GetComponent<NPCController>().Talk();
            }
            else if (hit.CompareTag("Door"))
            {
                hit.GetComponent<DoorController>().Enter();
            }
        }
    }
}
