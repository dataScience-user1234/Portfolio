package io.github.some_example_name;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.utils.ScreenUtils;
import com.badlogic.gdx.utils.viewport.FitViewport;
import com.badlogic.gdx.utils.viewport.Viewport;

/**
 * Classe principale du jeu "Circuit Laser".
 * <p>
 * Cette classe hérite de {@link ApplicationAdapter} et gère le cycle de vie de l'application :
 * initialisation, boucle de rendu, redimensionnement et nettoyage.
 */
public class Main extends ApplicationAdapter {

    /** Outil pour dessiner des formes géométriques (le laser). */
    ShapeRenderer shape;

    /** Outil pour dessiner des textures (images) et du texte. */
    SpriteBatch batch;

    /** Police d'écriture pour l'interface utilisateur. */
    BitmapFont fontUi;

    /** Caméra orthographique pour la vue 2D. */
    OrthographicCamera camera;

    /**pour gérer l'adaptation à la taille de la fenêtre (ratio aspect). */
    Viewport viewport;

    /** Largeur virtuelle du monde de jeu. */
    final float WORLD_WIDTH = 800;
    /** Hauteur virtuelle du monde de jeu. */
    final float WORLD_HEIGHT = 600;

    Texture imageFond;
    Texture imageFond2;
    Texture imgPorteA;
    Texture imgPorteB;

    /** Instance du plateau de jeu (la carte). */
    Plateau plateau;

    /** Instance du joueur (le laser). */
    Laser laser;

    /** * État actuel du jeu.
     * 0 = Menu Principal
     * 1 = En Jeu
     * 2 = Game Over (Perdu)
     * 3 = Victoire (Niveau réussi)
     */
    int etat = 0;

    /** Numéro du niveau en cours (1, 2 ou 3). */
    int niveauActuel = 1;

    /**
     * Méthode appelée une seule fois au démarrage de l'application.
     * Initialise les moteurs de rendu, la caméra, charge les assets et lance la première partie.
     */
    @Override
    public void create() {
        shape = new ShapeRenderer();
        batch = new SpriteBatch();
        fontUi = new BitmapFont();
        fontUi.getData().setScale(1.5f);

        camera = new OrthographicCamera();
        viewport = new FitViewport(WORLD_WIDTH, WORLD_HEIGHT, camera);
        viewport.apply();

        // Chargement des textures avec filtre linéaire pour le lissage
        imageFond = new Texture("fond.png");
        imageFond.setFilter(Texture.TextureFilter.Linear, Texture.TextureFilter.Linear);
        imageFond2 = new Texture("fond2.png");
        imageFond2.setFilter(Texture.TextureFilter.Linear, Texture.TextureFilter.Linear);
        imgPorteA = new Texture("porteA.png");
        imgPorteA.setFilter(Texture.TextureFilter.Linear, Texture.TextureFilter.Linear);
        imgPorteB = new Texture("porteB.png");
        imgPorteB.setFilter(Texture.TextureFilter.Linear, Texture.TextureFilter.Linear);

        initPartie();
    }

    /**
     * Méthode appelée pour redimensionner la fenêtre.
     */
    @Override
    public void resize(int width, int height) {
        viewport.update(width, height, true);
    }

    /**
     * Initialise ou réinitialise une partie.
     * Charge le niveau correspondant à {@code niveauActuel} et replace le laser.
     */
    private void initPartie() {
        if (plateau == null) plateau = new Plateau();
        plateau.chargerNiveau(niveauActuel);
        laser = new Laser(plateau);
    }

    /**
     * Boucle principale du jeu
     */
    @Override
    public void render() {
        float delta = Gdx.graphics.getDeltaTime();

        //MISE A JOUR
        if (etat == 0) { // Menu
            if (Gdx.input.isKeyJustPressed(Input.Keys.SPACE)) etat = 1;
        }
        else if (etat == 1) { // Jeu
            laser.update(delta, plateau);
            if (laser.estMort) etat = 2;
            if (laser.aGagne) etat = 3;
        }
        else if (etat == 2) { // Perdu
            if (Gdx.input.isKeyJustPressed(Input.Keys.SPACE)) {
                initPartie();
                etat = 1;
            }
        }
        else if (etat == 3) { // Gagné
            if (Gdx.input.isKeyJustPressed(Input.Keys.SPACE)) {
                gestionChangementNiveau();
            }
        }

        //DESSIN
        ScreenUtils.clear(0, 0, 0, 1);
        batch.setProjectionMatrix(camera.combined);
        shape.setProjectionMatrix(camera.combined);

        batch.begin();
        batch.setColor(Color.WHITE);
        batch.draw(imageFond, 0, 0, WORLD_WIDTH, WORLD_HEIGHT);
        batch.end();

        if (etat != 0) {
            plateau.render(shape, batch, imageFond2, imgPorteA, imgPorteB);
            shape.begin(ShapeRenderer.ShapeType.Filled);
            if (!laser.estMort) laser.render(shape);
            shape.end();
        }

        dessinerInterface();
    }

    /**
     * Gère la transition entre les niveaux ou le retour au début.
     */
    private void gestionChangementNiveau() {
        if (niveauActuel == 1) {
            niveauActuel = 2;
            initPartie();
            etat = 1;
        }
        else if (niveauActuel == 2) {
            niveauActuel = 3;
            initPartie();
            etat = 1;
        }
        else {
            // Fin du jeu -> Retour au niveau 1
            niveauActuel = 1;
            initPartie();
            etat = 1;
        }
    }

    /**
     * Affiche les textes à l'écran selon l'état du jeu.
     */
    private void dessinerInterface() {
        batch.begin();
        fontUi.setColor(Color.WHITE);

        if (etat == 0) {
            fontUi.setColor(Color.CYAN);
            fontUi.draw(batch, "CIRCUIT LASER", WORLD_WIDTH/2f - 100, WORLD_HEIGHT/2f + 50);
            fontUi.setColor(Color.WHITE);
            fontUi.draw(batch, "ESPACE pour commencer", WORLD_WIDTH/2f - 120, WORLD_HEIGHT/2f - 20);
        }
        else if (etat == 2) {
            fontUi.setColor(Color.RED);
            fontUi.draw(batch, "CRASH !", WORLD_WIDTH/2f - 40, WORLD_HEIGHT/2f + 50);
            fontUi.draw(batch, "ESPACE pour reessayer", WORLD_WIDTH/2f - 120, WORLD_HEIGHT/2f - 20);
        }
        else if (etat == 3) {
            fontUi.setColor(Color.GREEN);
            if (niveauActuel == 1) {
                fontUi.draw(batch, "NIVEAU 1 REUSSI !", WORLD_WIDTH/2f - 80, WORLD_HEIGHT/2f + 50);
                fontUi.draw(batch, "ESPACE pour Niveau 2", WORLD_WIDTH/2f - 110, WORLD_HEIGHT/2f - 20);
            }
            else if (niveauActuel == 2) {
                fontUi.draw(batch, "NIVEAU 2 REUSSI !", WORLD_WIDTH/2f - 80, WORLD_HEIGHT/2f + 50);
                fontUi.draw(batch, "ESPACE pour Niveau 3", WORLD_WIDTH/2f - 110, WORLD_HEIGHT/2f - 20);
            }
            else {
                fontUi.draw(batch, "VICTOIRE TOTALE !", WORLD_WIDTH/2f - 80, WORLD_HEIGHT/2f + 50);
                fontUi.draw(batch, "ESPACE pour recommencer", WORLD_WIDTH/2f - 110, WORLD_HEIGHT/2f - 20);
            }
        }

        if (etat == 1) {
            fontUi.getData().setScale(1.0f);
            fontUi.draw(batch, "Niveau " + niveauActuel, 20, WORLD_HEIGHT - 20);
            fontUi.getData().setScale(1.5f);
        }
        batch.end();
    }

    /**
     * Libère les ressources mémoire (textures, sons, batchs) à la fermeture de l'application.
     */
    @Override
    public void dispose() {
        shape.dispose();
        batch.dispose();
        fontUi.dispose();
        imageFond.dispose();
        imageFond2.dispose();
        imgPorteA.dispose();
        imgPorteB.dispose();
    }
}
