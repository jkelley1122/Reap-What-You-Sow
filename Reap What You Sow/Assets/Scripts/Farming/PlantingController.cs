using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PlantingController : MonoBehaviour
{
    public Material new_Mat;


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        other.GetComponent<Renderer>().material = new_Mat;
    }
}
