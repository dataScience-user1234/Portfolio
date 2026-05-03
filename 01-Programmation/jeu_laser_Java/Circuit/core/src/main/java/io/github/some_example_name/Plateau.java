package io.github.some_example_name;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;

/**
 *Cette classe représente le plateau de jeu.
 * <p>
 *Cette classe stocke la structure des murs et du chemin sous forme de grille matricielle.
 *Elle gère aussi le chargement des niveaux et l'affichage des murs.
 * </p>
 */
public class Plateau {

    /** Taille d'une case de la grille en pixels (40x40). */
    public static final int TAILLE_CASE = 40;

    /** Largeur de la grille */
    public int largeur = 12;
    /** Hauteur de la grille */
    public int hauteur = 8;

    /** Décalage en X pour centrer le plateau. */
    public float offsetX;
    /** Décalage en Y pour centrer le plateau. */
    public float offsetY;

    private final float MONDE_LARGEUR = 800;
    private final float MONDE_HAUTEUR = 600;

    /** Code représentant une case vide (le mur). */
    public static final int VIDE = 0;
    /** Code représentant un chemin (Fil) où le laser peut passer. */
    public static final int FIL = 1;
    /** Code représentant un obstacle (Mur interne). */
    public static final int OBSTACLE = 2;
    /** Code représentant la case de départ. */
    public static final int DEPART = 3;
    /** Code représentant la case d'arrivée. */
    public static final int ARRIVEE = 4;

    /** Grille actuelle du niveau. */
    private int[][] grilleActuelle;

    // DONNEES DES NIVEAUX

    //NIVEAU 1
    private int[][] niveau1 = {
        {3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0},
        {0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 1, 0},
        {0, 0, 1, 2, 2, 1, 1, 0, 0, 0, 1, 0},
        {0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0, 1, 1, 2, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 4}
    };

    //NIVEAU 2
    private int[][] niveau2 = {
        {0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0},
        {3, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1},
        {0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1},
        {0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 4}
    };


    //NIVEAU 3
    private int[][] niveau3 = {
        {3, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0},
        {0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
        {0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0},
        {0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0},
        {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0}
    };


    /**
     * Constructeur de la classe Plateau.
     * Elle calcule le décalage pour centrer le jeu à l'écran.
     */
    public Plateau() {
        offsetX = (MONDE_LARGEUR - (largeur * TAILLE_CASE)) / 2f;
        offsetY = (MONDE_HAUTEUR - (hauteur * TAILLE_CASE)) / 2f;
        chargerNiveau(1);
    }

    /**
     * Charge la configuration de la grille pour le niveau demandé.
     *
     * @param numero Le numéro du niveau (1, 2 ou 3). Si invalide, charge le niveau 1.
     */
    public void chargerNiveau(int numero) {
        if (numero == 1) grilleActuelle = niveau1;
        else if (numero == 2) grilleActuelle = niveau2;
        else if (numero == 3) grilleActuelle = niveau3;
        else grilleActuelle = niveau1;
    }

    /**
     * Retourne le type de terrain à une coordonnée de grille donnée.
     *
     * @param x Colonne de la grille.
     * @param y Ligne de la grille.
     * @return L'entier représentant le type (VIDE, FIL, DEPART, ARRIVEE).
     */
    public int getType(int x, int y) {
        if (x < 0 || x >= largeur || y < 0 || y >= hauteur) return VIDE;
        return grilleActuelle[y][x];
    }


    public int getCaseX(float pixelX) {
        return (int)((pixelX - offsetX) / TAILLE_CASE);
    }


    public int getCaseY(float pixelY) {
        return (int)((MONDE_HAUTEUR - (pixelY + offsetY)) / TAILLE_CASE) - 1;
    }

    /**
     * Dessine les éléments statiques du plateau.
     *
     * @param shape L'outil de rendu de formes.
     * @param batch L'outil de rendu d'images.
     * @param textureFond2 texture du tapis de jeu.
     * @param porteA texture du point de départ.
     * @param porteB Texture du point d'arrivée.
     */
    public void render(ShapeRenderer shape, SpriteBatch batch, Texture textureFond2, Texture porteA, Texture porteB) {
        // 1. Image de fond
        batch.begin();
        batch.setColor(Color.WHITE);
        batch.draw(textureFond2, offsetX, offsetY, largeur * TAILLE_CASE, hauteur * TAILLE_CASE);
        batch.end();

        // 2. Cases du chemin (en gris)
        Gdx.gl.glEnable(Gdx.gl.GL_BLEND);
        shape.begin(ShapeRenderer.ShapeType.Filled);
        for (int y = 0; y < hauteur; y++) {
            for (int x = 0; x < largeur; x++) {
                int type = grilleActuelle[y][x];
                float ecranX = offsetX + x * TAILLE_CASE;
                float ecranY = offsetY + (hauteur - 1 - y) * TAILLE_CASE;

                if (type == FIL) {
                    shape.setColor(Color.GRAY);
                    shape.rect(ecranX, ecranY, TAILLE_CASE, TAILLE_CASE);
                }
            }
        }
        shape.end();

        // 3. Portes
        batch.begin();
        for (int y = 0; y < hauteur; y++) {
            for (int x = 0; x < largeur; x++) {
                int type = grilleActuelle[y][x];
                float ecranX = offsetX + x * TAILLE_CASE;
                float ecranY = offsetY + (hauteur - 1 - y) * TAILLE_CASE;

                if (type == DEPART) {
                    batch.draw(porteA, ecranX, ecranY, TAILLE_CASE, TAILLE_CASE);
                }
                else if (type == ARRIVEE) {
                    batch.draw(porteB, ecranX, ecranY, TAILLE_CASE, TAILLE_CASE, 0, 0, porteB.getWidth(), porteB.getHeight(), true, false);
                }
            }
        }
        batch.end();
    }
}
