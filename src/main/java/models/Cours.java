package main.java.models;
import java.sql.Time;


public class Cours 
{
	private int id_c;
	private Time heureDebut;
	private Time heureFin;
	private String libelle;
	
	public Cours(){}
	
	public Cours(int id_c, Time heureDebut, Time heureFin, String libelle)
	{
		this.id_c = id_c;
		this.heureDebut = heureDebut;
		this.heureFin = heureFin;
		this.libelle = libelle;
	}
	
	public int getId()
	{
		return id_c;
	}
	
	public Time getHeureDebut()
	{
		return heureDebut;
	}
	
	public Time getHeureFin()
	{
		return heureFin;
	}
	
	public String getLibelle()
	{
		return libelle;
	}
	
	public void setId(int id_c)
	{
		this.id_c = id_c;
	}
	
	public void setHeureDebut(Time heureDebut)
	{
		this.heureDebut = heureDebut;
	}
	
	public void setHeureFin(Time heureFin)
	{
		this.heureFin = heureFin;
	}
	
	public void setLibelle(String libelle)
	{
		this.libelle = libelle;
	}
	
}
