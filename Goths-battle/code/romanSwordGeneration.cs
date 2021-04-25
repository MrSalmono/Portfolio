using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class romanSwordGeneration : MonoBehaviour
{
	public GameObject theEnemy;
	public float xPos;
	public float yPos;
	public float enemyCount;
	private float count;
	// Start is called before the first frame update
	void FixedUpdate()
	{
	count += 0.2f + enemyCount;
	
	while(count > 10f)
	StartCoroutine(EnemyDrop());
	count=0;
	enemyCount += 0.02f;
	}
	
	IEnumerator EnemyDrop()
	{
		
		xPos = Random.Range(-2f,1.2f);
		yPos = Random.Range(-5.47f,5.7f);
		yield return new WaitForSeconds(1f);
		Instantiate(theEnemy,new Vector3(xPos,yPos,0),Quaternion.identity);
		
		
	}

}
