using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FarmPlotController : MonoBehaviour
{
    public GameObject plantNode;    //object which denotes locations where plants can be placed. collision with the object, while a plant is selected, will cause the plant to be placed. During development the item will be visible and given the DEBUG_YEL material for easy identification, but in the final version the object will be given a look that blends more seamlessly with the ground it is placed on
    private List<Vector3> plotPoints;
    // Start is called before the first frame update
    void Start()
    {
        plotPoints = new List<Vector3>(2);
    }

    // Update is called once per frame
    void Update()
    {
        //detect user input of [SPACE_BAR] to add a location(player Location) to plotPoints
        if (Input.GetKeyUp("space"))
        {
            plotPoints.Add(this.transform.position);
            //Debug.Log("Just Added: " + plotPoints[plotPoints.Count - 1]);
            //Debug.Log("plotPoints now contains " + plotPoints.Count + " points");
        }
        //if plotPoints contains 2 valid locations within the world, call defPlot and then clear plotPoints
        if (plotPoints.Count == 2)
        {
            defPlot();
            plotPoints.Clear();
            //Debug.Log("CLEARED PLOTPOINTS");
        }
    }


    //dev tool test function for creation of farm plots without a size limit
    //later implimentation for detection of tool quality, and the subsequent call to defPlot(size) for  creation of farm plots with a size limit
    void defPlot()
    {
        bool valid = true;
        //fail if plots are too close or overlapping
        GameObject[] nodes = GameObject.FindGameObjectsWithTag("Planter");

        foreach (GameObject n in nodes)
        {
            float x = plotPoints[0][0];

            ////////////////////////////////////////////////////   checking for valid plots   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (plotPoints[0][0] < plotPoints[1][0] && plotPoints[0][2] < plotPoints[1][2])
            {
                while (x <= plotPoints[1][0])
                {
                    float z = plotPoints[0][2];
                    while (z <= plotPoints[1][2])
                    {
                        if ((n.transform.position[0] - x < .75 && n.transform.position[0] - x > -.75) && (n.transform.position[2] - z < .75 && n.transform.position[2] - z > -.75)) { valid = false; }
                        z += .5f;
                    }
                    x += .5f;
                }
                //Debug.Log("Step X");
            }

            else if (plotPoints[0][0] > plotPoints[1][0] && plotPoints[0][2] < plotPoints[1][2])
            {
                while (x >= plotPoints[1][0])
                {
                    float z = plotPoints[0][2];
                    while (z <= plotPoints[1][2])
                    {
                        if ((n.transform.position[0] - x < .75 && n.transform.position[0] - x > -.75) && (n.transform.position[2] - z < .75 && n.transform.position[2] - z > -.75)) { valid = false; }
                        z += .5f;
                    }
                    x -= .5f;
                }
            }
            else if (plotPoints[0][0] > plotPoints[1][0] && plotPoints[0][2] > plotPoints[1][2])
            {
                while (x >= plotPoints[1][0])
                {
                    float z = plotPoints[0][2];
                    while (z >= plotPoints[1][2])
                    {
                        if ((n.transform.position[0] - x < .75 && n.transform.position[0] - x > -.75) && (n.transform.position[2] - z < .75 && n.transform.position[2] - z > -.75)) { valid = false; }
                        z -= .5f;
                    }
                    x -= .5f;
                }
            }
            else if (plotPoints[0][0] < plotPoints[1][0] && plotPoints[0][2] > plotPoints[1][2])
            {
                while (x <= plotPoints[1][0])
                {
                    float z = plotPoints[0][2];
                    while (z >= plotPoints[1][2])
                    {
                        if ((n.transform.position[0] - x < .75 && n.transform.position[0] - x > -.75) && (n.transform.position[2] - z < .75 && n.transform.position[2] - z > -.75)) { valid = false; }
                        z -= .5f;
                    }
                    x += .5f;
                }
            }
        }
        /////////////////////////////////////////////  create defined plot if valid  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //create a plot using the two points contained within plotPoints
        if (valid) { defPlot(0); }
        else { Debug.Log("Invalid Plot location defined, try again"); }
        
        
    }


    // universal function to define a farm plot with a certain size limit
    void defPlot(int size)
    {
        
        //place a plant node at each x val and each z value, step by .5, between location 1 and location 2
        float x = plotPoints[0][0];
        
        if (plotPoints[0][0] < plotPoints[1][0] && plotPoints[0][2] < plotPoints[1][2])
        {
            while (x <= plotPoints[1][0])
            {
                float z = plotPoints[0][2];
                while (z <= plotPoints[1][2])
                {
                    Instantiate(plantNode, new Vector3(x, .05f, z), Quaternion.identity);
                    //Debug.Log("Coordinates are " + x + ", 0.05, " + z);
                    z += .5f;
                }
                x += .5f;
            }
            //Debug.Log("Step X");
        }

        else if (plotPoints[0][0] > plotPoints[1][0] && plotPoints[0][2] < plotPoints[1][2])
        {
            while (x >= plotPoints[1][0])
            {
                float z = plotPoints[0][2];
                while (z <= plotPoints[1][2])
                {
                    Instantiate(plantNode, new Vector3(x, .05f, z), Quaternion.identity);
                    //Debug.Log("Coordinates are " + x + ", 0.05, " + z);
                    z += .5f;
                }
                x -= .5f;
            }
        }
        else if (plotPoints[0][0] > plotPoints[1][0] && plotPoints[0][2] > plotPoints[1][2])
        {
            while (x >= plotPoints[1][0])
            {
                float z = plotPoints[0][2];
                while (z >= plotPoints[1][2])
                {
                    Instantiate(plantNode, new Vector3(x, .05f, z), Quaternion.identity);
                    //Debug.Log("Coordinates are " + x + ", 0.05, " + z);
                    z -= .5f;
                }
                x -= .5f;
            }
        }
        else if (plotPoints[0][0] < plotPoints[1][0] && plotPoints[0][2] > plotPoints[1][2])
        {
            while (x <= plotPoints[1][0])
            {
                float z = plotPoints[0][2];
                while (z >= plotPoints[1][2])
                {
                    Instantiate(plantNode, new Vector3(x, .05f, z), Quaternion.identity);
                    //Debug.Log("Coordinates are " + x + ", 0.05, " + z);
                    z -= .5f;
                }
                x += .5f;
            }
        }
        else { Debug.Log("PLOT DEFINITION FAILED"); }






        //[LATER] if the two locations in plotPoints are within (size) of each other, in both x and z directions, create the plot

    }
}
