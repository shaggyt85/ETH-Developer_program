const {
    expect
} = require("chai");
const {
    ethers
} = require("hardhat");

describe("Pokemon Contracts", function () {
    it("Pokemon Factory count 0 pokemons", async function () {
        const PokemonFactory = await ethers.getContractFactory("PokemonFactory")
        const hardhatPokemon = await PokemonFactory.deploy()
        const pokemons = await hardhatPokemon.getAllPokemons();
        expect(pokemons.length).to.equal(0);
    })

    it("Pokemon Factory should pokemons", async function () {
        const PokemonFactory = await ethers.getContractFactory("PokemonFactory")
        const hardhatPokemon = await PokemonFactory.deploy()
        try {
            await hardhatPokemon.createPokemon("Charmander", 5, [3], [2], [5,3]);
            await hardhatPokemon.createPokemon("Bulbasaur", 2, [3, 5], [3, 6], [2] );
        } catch (error) {
            expect(error.message).to.include("Pokemon id must be greater than 0");
        }
        const pokemons = await hardhatPokemon.getAllPokemons();
        expect(pokemons.length).to.equal(2);
    })
})