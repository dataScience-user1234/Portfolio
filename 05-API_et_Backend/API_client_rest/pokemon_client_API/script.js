const baseApi = 'https://pokeapi.co/api/v2'; //l'url de l'api

//on recupere tous les éléments du DOM au chargement de la page 
const inputRecherche = document.getElementById('pokeId');
const msgErreur = document.getElementById('search-error');
const divResultat = document.getElementById('poke-result');
const titrePoke = document.getElementById('poke-name');
const imagePoke = document.getElementById('poke-img');
const descPoke = document.getElementById('poke-desc');
const taillePoke = document.getElementById('poke-height');
const poidsPoke = document.getElementById('poke-weight');
const sonPoke = document.getElementById('poke-cry');

const selectGen = document.getElementById('gen-select'); //menu pour les générations
const grillePoke = document.getElementById('pokemon-grid');

const selectBaie = document.getElementById('berry-select'); //et pour les baies
const nomBaie = document.getElementById('berry-name');
const imageBaie = document.getElementById('berry-img');
const fermeteBaie = document.getElementById('berry-firmness');
const descBaie = document.getElementById('berry-desc');
const divDetailsBaie = document.getElementById('berry-details');




function showSection(sectionId) { //fonction pour naviguer entre les différents onglets de la page

    document.querySelectorAll('.section-container').forEach(el => el.classList.remove('active'));

    document.getElementById(sectionId).classList.add('active');
    
    //pour eviter de recharger pour rien)
    if(sectionId === 'list-poke' && selectGen.options.length === 0) loadPokemonList();
    if(sectionId === 'list-berries' && selectBaie.options.length === 0) loadBerriesList();
}



//fonction  pour chercher les infos d'un Pokémon
async function searchPokemon() {
    const id = inputRecherche.value.toLowerCase().trim();   //on recupere le texte tapé
    
    //on arrête la fonction si cest vide
    if (!id) return;

    try {
        //pour avoir les stats de base (poids, taille, image...)
        const reqPoke = await fetch(`${baseApi}/pokemon/${id}`);
        if (!reqPoke.ok) throw new Error("Pokémon introuvable !");
        const poke = await reqPoke.json();

        
        const reqEspece = await fetch(poke.species.url); //2eme fetch car la description est dans l'objet 'species'
        const espece = await reqEspece.json();
        
        //on cherche la description en francais
        let entreeDesc = espece.flavor_text_entries.find(entry => entry.language.name === 'fr');
        //si elle existe pas on prend l'anglais 
        if (!entreeDesc) entreeDesc = espece.flavor_text_entries.find(entry => entry.language.name === 'en');
        
        //l'api renvoie desfois le caractère spécial \f, on le remplace par un espace normal
        const texteFinal = entreeDesc ? entreeDesc.flavor_text.replace(/\f/g, ' ') : "Aucune description n'existe pour ce Pokémon dans l'API.";

        //on prend l'officiel sinon on prend le petit sprite basique
        let urlImage = poke.sprites.other['official-artwork'].front_default || poke.sprites.front_default;


        titrePoke.innerText = `${poke.name} (${poke.id})`; //nom et numero
        
        imagePoke.src = urlImage;
        imagePoke.style.display = 'inline';

        descPoke.innerText = texteFinal;


        
        //on divise ici car il faut diviser par 10 pour avoir les bonnes mesures
        taillePoke.innerText = (poke.height / 10) + " m";
        poidsPoke.innerText = (poke.weight / 10) + " kg";
        
        //recuperation du son
        let urlSon = poke.cries?.latest;

        
        if (urlSon) {
            sonPoke.src = urlSon;
            sonPoke.load(); //pour eviter les bugs
            sonPoke.parentElement.style.display = 'block';
        } else {
            sonPoke.parentElement.style.display = 'none'; //et on cache si ca bug
        }

        
        msgErreur.innerText = ""; //si ca s'est bien passé, on vide l'erreur et on affiche la carte
        divResultat.style.display = "block";
    } catch (err) {
        msgErreur.innerText = err.message;
    }
}

//fonction pour initialiser le menu deroulant des generations
async function loadPokemonList() {
    try {
        const req = await fetch(`${baseApi}/generation`);
        const donnees = await req.json();
        
        selectGen.innerHTML = '<option value="">-- Choisissez une Génération --</option>';
        
        //pour chaque option du menu
        donnees.results.forEach((gen, index) => {
            const option = document.createElement('option');
            option.value = gen.name; 
            option.innerText = `Génération ${index + 1}`; 
            selectGen.appendChild(option);
        });



        //quand on choisit une génération on charge la grille qui correspond
        selectGen.onchange = (event) => {
            const choixGen = event.target.value;
            if (choixGen) {
                loadPokemonByGeneration(choixGen);
            } else {
                grillePoke.innerHTML = ''; 
            }
        };

    } catch (err) { console.error("Erreur lors du chargement des générations :", err); }
}



//fonction pour afficher les cases des Pokémons selon la génération choisie
async function loadPokemonByGeneration(nomGen) {
    try {
        const req = await fetch(`${baseApi}/generation/${nomGen}`);
        const donnees = await req.json();
        
        let listePokemons = donnees.pokemon_species;
        

        //on trie ici
        listePokemons.forEach(p => {
            const morceaux = p.url.split('/');
            p.id = parseInt(morceaux[morceaux.length - 2]); 
        });
        listePokemons.sort((a, b) => a.id - b.id); 

        grillePoke.innerHTML = ''; 
        
        //on range chaque Pokémon dans des case
        listePokemons.forEach(p => {
            const div = document.createElement('div');
            div.className = 'grid-item';
            div.innerText = `${p.id} ${p.name.charAt(0).toUpperCase() + p.name.slice(1)}`;
            
            //si on clique sur la case ca lance directement la recherche de ce Pokémon
            div.onclick = () => {
                inputRecherche.value = p.id; 
                showSection('search'); 
                searchPokemon(); 
            };
            
            grillePoke.appendChild(div);
        });
    } catch (err) { console.error("Erreur lors du chargement des Pokémons de la génération :", err); }
}


//fonction pour initialiser le menu déroulant des baies
async function loadBerriesList() {
    try {
        const req = await fetch(`${baseApi}/berry?limit=100`);
        const donnees = await req.json();
        
        selectBaie.innerHTML = '<option value="">-- Choisissez une Baie --</option>';
        
        donnees.results.forEach(baie => {
            const option = document.createElement('option');
            option.value = baie.name;
            option.innerText = `Baie ${baie.name.charAt(0).toUpperCase() + baie.name.slice(1)}`;
            selectBaie.appendChild(option);

        });

        //Event listener quand on sélectionne une baie
        selectBaie.onchange = (event) => {
            const choixBaie = event.target.value;
            if (choixBaie) {
                loadBerryDetails(choixBaie); 
            }
        };

    } catch (err) { console.error("Erreur lors du chargement des baies :", err); }
}




async function loadBerryDetails(nom) { // Fonction pour afficher les infos d'une baie spécifique
    try {
        //fetch de base pour la fermeté
        const req = await fetch(`${baseApi}/berry/${nom}`);
        const baie = await req.json();
        
        //ensuite ici pour récupérer le texte de description
        const reqObjet = await fetch(baie.item.url);
        const objet = await reqObjet.json();
        
        //on garde le francais sinon l'anglais
        let entreeDesc = objet.flavor_text_entries.find(e => e.language.name === 'fr');
        if (!entreeDesc) {
            entreeDesc = objet.flavor_text_entries.find(e => e.language.name === 'en');
        }


        const texteFinal = entreeDesc ? (entreeDesc.text || entreeDesc.flavor_text) : "Aucune description disponible dans l'API.";

        //remplissage html
        nomBaie.innerText = `Baie ${nom}`;
        fermeteBaie.innerText = baie.firmness.name;
        descBaie.innerText = texteFinal;
        
        //on construit ici l'URL de l'image car elle n'est pas fournie par l'API des baies
        imageBaie.src = `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/${baie.item.name}.png`;
        imageBaie.style.display = 'block';

        divDetailsBaie.style.display = 'block';
    } catch (err) { 
        console.error("Erreur lors du chargement des détails de la baie :", err); 
    }
}