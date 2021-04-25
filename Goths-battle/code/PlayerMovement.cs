using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
	public string InpDroite; //Touche droite
	public string InpGauche; //Touche gauche
	public string InpAvant; //Touche avancer
    	public string InpArriere; //Touche reculer
    	public Vector2 colliderPlayerSize; //doit gérer le collider 2D pour faire en sorte que mes bonhommes se montent pas-dessus
    	
	//Animation animations;
	public Animator animator;//on crée la variable Animator (du game object) que l'on appelle animator = il faut pas oublier de d'assigner la variable une fois que celle ci est crée 
    	
	public float moveSpeed;
	//les deux variables en dessous ne nous concernerait que si nous utilisions Rigidbody pour soumettre notre bonhomme à la gravité et pour les déplacement
	//public RigidBody2D rb;
	//private vector3 velocity = Vector3.zero;
	
	//Use this for initialization
	void Start(){
	//animations = gameObject.GetComponent<Animation>();
	}

	// Update is called once per frame
	void Update()
	{
	animator.SetBool("InpDown",false); 
	animator.SetBool("InpUp",false); 
	animator.SetBool("InpRight",false); 
	animator.SetBool("InpLeft",false); 
	//bon apparamment pour avoir la position fallait que j'utilise var pour définir ma variable
	var positionPlayer = transform.position;
	//float coordonneeY= Input.GetAxis("Horizontal");
	//print(coordonneeY);
	//Marche avant
	//le .y me permet de récuérer la variable y de mon vecteur3 position
	if (Input.GetKey(InpAvant) && positionPlayer.y < 5.55)
	{
		animator.SetBool("InpUp",true); 
		transform.Translate(0, moveSpeed * Time.deltaTime, 0);
        }else if(Input.GetKey(InpAvant) && positionPlayer.y > 5.55)
        {
        	animator.SetBool("InpUp",true); 
        }
        //marche arrière
	if (Input.GetKey(InpArriere) && positionPlayer.y > -5.55)
	{
		//animations.Play("Goth_Down"); 
		//(sans doute lié à l'animation mais pour le moment on en a pas besoin
		animator.SetBool("InpDown",true); 
		transform.Translate(0, -(moveSpeed) * Time.deltaTime, 0);
        }else if(Input.GetKey(InpArriere) && positionPlayer.y < -5.55)
        {
        	animator.SetBool("InpDown",true);
        }
        //marche à droite
	if (Input.GetKey(InpDroite) && positionPlayer.x < 5.55)
	{
		animator.SetBool("InpRight",true);
		transform.Translate(moveSpeed * Time.deltaTime, 0, 0);
        }else if(Input.GetKey(InpDroite) && positionPlayer.x > 5.55)
        {
        	animator.SetBool("InpRight",true);
        }
        //marche à gauche
	if (Input.GetKey(InpGauche) && positionPlayer.x > -5.55)
	{
		animator.SetBool("InpLeft",true); 
		transform.Translate(-(moveSpeed) * Time.deltaTime, 0, 0);
        }else if(Input.GetKey(InpGauche) && positionPlayer.x < -5.55)
        {
        	animator.SetBool("InpLeft",true); 
        }
             
   	}
}
