using System.Collections;
using UnityEngine;

public class RomanHealth : MonoBehaviour
{
	
	//private int romanLifeMax = 1;
	public int currentHealthEnemi;
	public GameObject romanEn;
	// Start is called before the first frame update
	void Start()
	{
		currentHealthEnemi = 1;
	}

	// Update is called once per frame
	void Update()
	{
		if (currentHealthEnemi == 0 || Input.GetKeyDown(KeyCode.J))
		{
			romanEn.SetActive(false);
		}       
	}
    	
	public void DamageEnemi(int damageE)
	{
		currentHealthEnemi -= damageE;
	}	
}
