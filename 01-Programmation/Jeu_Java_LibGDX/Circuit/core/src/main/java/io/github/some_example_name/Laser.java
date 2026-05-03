package io.github.some_example_name;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector2;
import java.util.ArrayList;

/**
 * Représente le Laser.
 * <p>
 * Cette classe gère la position du laser, sa vitesse,
 * l'historique de ses déplacements (trace) et la détection de collision avec le plateau.
 * </p>
 */
public class Laser {

    /** Position actuelle de la tête du laser (x, y). */
    private Vector2 position;

    /** Vecteur vitesse (direction et magnitude). */
    private Vector2 velocity;

    /** Historique des positions pour dessiner la traînée. */
    private ArrayList<Vector2> trace;

    /** Vitesse de déplacement du laser en pixels par seconde. */
    private float vitesseDeplacement = 3 * Plateau.TAILLE_CASE;

    /** État :vrai si le laser a touché un mur. */
    public boolean estMort = false;

    /** État :Vrai si le laser a atteint la sortie. */
    public boolean aGagne = false;

    /** État :vrai si le joueur a commencé à bouger. */
    private boolean aDemarre = false;

    /**
     * Constructeur. Initialise le laser à la position de départ du niveau.
     *
     * @param plateau Le plateau de jeu pour localiser la case DEPART.
     */
    public Laser(Plateau plateau) {
        trace = new ArrayList<>();
        position = new Vector2();
        velocity = new Vector2(0, 0);

        //recherche de la case de départ pour placer le laser
        for (int y = 0; y < plateau.hauteur; y++) {
            for (int x = 0; x < plateau.largeur; x++) {
                if (plateau.getType(x, y) == Plateau.DEPART) {
                    position.x = plateau.offsetX + (x * Plateau.TAILLE_CASE) + (Plateau.TAILLE_CASE / 2f);
                    position.y = plateau.offsetY + ((plateau.hauteur - 1 - y) * Plateau.TAILLE_CASE) + (Plateau.TAILLE_CASE / 2f);
                    trace.add(new Vector2(position));
                    return;
                }
            }
        }
    }

    /**
     * Met à jour la logique du laser (déplacement et collisions).
     *
     * @param delta   Temps écoulé depuis la dernière frame.
     * @param plateau Le plateau pour vérifier les collisions.
     */
    public void update(float delta, Plateau plateau) {
        if (estMort || aGagne) return;

        // Contrôles clavier
        if (Gdx.input.isKeyJustPressed(Input.Keys.LEFT)) changerDirection(-vitesseDeplacement, 0);
        else if (Gdx.input.isKeyJustPressed(Input.Keys.RIGHT)) changerDirection(vitesseDeplacement, 0);
        else if (Gdx.input.isKeyJustPressed(Input.Keys.UP)) changerDirection(0, vitesseDeplacement);
        else if (Gdx.input.isKeyJustPressed(Input.Keys.DOWN)) changerDirection(0, -vitesseDeplacement);

        if (!aDemarre) return;

        // Application de la vitesse
        position.x += velocity.x * delta;
        position.y += velocity.y * delta;

        verifierCollision(plateau);
    }

    /**
     * Change la direction du laser et sauvegarde le point de virage.
     *
     * @param vx Nouvelle vitesse en X.
     * @param vy Nouvelle vitesse en Y.
     */
    private void changerDirection(float vx, float vy) {
        if (velocity.x != vx || velocity.y != vy) {
            trace.add(new Vector2(position));
            velocity.set(vx, vy);
            aDemarre = true;
        }
    }

    /**
     * Vérifie si la position actuelle du laser entre en collision avec un mur ou la sortie.
     *
     * @param plateau Le plateau de jeu.
     */
    private void verifierCollision(Plateau plateau) {
        float xRelatif = position.x - plateau.offsetX;
        float yRelatif = position.y - plateau.offsetY;

        int caseX = (int)(xRelatif / Plateau.TAILLE_CASE);

        // Calcul pour l'axe Y inversé
        int hauteurPixels = plateau.hauteur * Plateau.TAILLE_CASE;
        int caseY = (hauteurPixels - (int)yRelatif) / Plateau.TAILLE_CASE;

        if ((hauteurPixels - (int)yRelatif) % Plateau.TAILLE_CASE == 0) caseY--;

        int type = plateau.getType(caseX, caseY);

        if (type == Plateau.VIDE || type == Plateau.OBSTACLE) {
            estMort = true;
        }
        else if (type == Plateau.ARRIVEE) {
            aGagne = true;
        }

        // Vérification des limites de l'écran
        if (xRelatif < 0 || xRelatif > plateau.largeur * Plateau.TAILLE_CASE ||
            yRelatif < 0 || yRelatif > plateau.hauteur * Plateau.TAILLE_CASE) {
            estMort = true;
        }
    }

    /**
     * Dessine le laser et sa traînée.
     *
     * @param shape L'outil de rendu de formes.
     */
    public void render(ShapeRenderer shape) {
        shape.setColor(Color.RED);
        if (trace.size() > 0) {
            Vector2 dernierPoint = trace.get(0);
            for (int i = 1; i < trace.size(); i++) {
                Vector2 point = trace.get(i);
                shape.rectLine(dernierPoint, point, 4);
                dernierPoint = point;
            }
            shape.rectLine(dernierPoint, position, 4);
        }

        shape.setColor(Color.WHITE);
        shape.circle(position.x, position.y, 3);
        shape.setColor(new Color(1, 0.2f, 0.2f, 0.5f));
        shape.circle(position.x, position.y, 6);
    }
}
