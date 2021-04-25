using UnityEngine;
using System.Collections;

public class Movement2 : MonoBehaviour
{
	public GameObject swordAttack; 
	public float speed = 10; // c'est la vitesse que j'associe au rigidbody lorsque je déplace mon joueur
	private float h; // la composante horizontal de on mouvement
	private float v; //la composante verticale de mon mouvement
	public Animator animator;
	private float timeAttack = 0.25f;
	private Rigidbody2D rb; //ma variable qui correspond au rigid body de l'objet
	private BoxCollider2D XX;
	
	// Start is called before the first frame update
   	void Start()
   	{
        	rb = GetComponent<Rigidbody2D>(); // a l'initialisation du script on fait en sorte que notre rb soit égal au component rigid body de notre objet 
        		
  	}

	// Update is called once per frame
	void Update()	
	{
		XX = swordAttack.GetComponent<BoxCollider2D>();
		animator.SetBool("InpDown",false); 
		animator.SetBool("InpUp",false); 
		animator.SetBool("InpRight",false); 
		animator.SetBool("InpLeft",false);
		
		
        	h = Input.GetAxis("Horizontal"); // on associe à h les valeurs sur l'axe horizontale qu'on obtiendra avec nos touches 
        	v = Input.GetAxis("Vertical");
        	//des petites conditions if pour que notre personnage change de frame et bouge avec les flèches
        	if(v<0)
        	{
        		animator.SetBool("InpDown",true); 
        		 XX.offset = new Vector2(-0.3128939f,-0.4954132f);
        		//Origin = new Point(10, Origin.Y);
        	}
        	if(v>0)
        	{
        		animator.SetBool("InpUp",true); 
        		XX.offset = new Vector2(0.3128939f,0.4954132f);
        	}
        	if(h<0)
        	{
        		animator.SetBool("InpLeft",true); 
        		XX.offset = new Vector2(-0.565f,-0.13f);
        	}
        	if(h>0)
        	{
        		animator.SetBool("InpRight",true); 
        		XX.offset = new Vector2(0.565f,0.13f);
        	}
        	if(Input.GetKeyDown(KeyCode.E))
		{
			animator.SetBool("AttackPlay",true);
			swordAttack.SetActive(true);
			StartCoroutine(AttackTempo());
	
		}
	}
	void FixedUpdate() // ce lance après l'update et à la même fonction (se vérifie à chaque frame
	{
		if(Input.GetKeyDown(KeyCode.E))
		{
			rb.velocity = Vector2.zero; //on bouge notre perso selon les axes définie plus haut fois la vitesse 
		}else{	
			rb.velocity = new Vector2(h,v) * speed; //on bouge notre perso selon les axes définie plus haut fois la vitesse 
		}
	}
	public IEnumerator AttackTempo()
	{
		{
			yield return new WaitForSeconds(timeAttack);
			animator.SetBool("AttackPlay",false);
			swordAttack.SetActive(false);		
		}
	}
	
	
	
	
}
