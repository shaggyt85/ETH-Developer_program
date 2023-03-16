// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Skills {
        string name;
        string description;
    }
    struct TypePokemon{
      string name;
      string description;
    }
    struct WeaknessesPokemon{
      string name;
      string description;
    }
    struct Pokemon {
        uint id;
        string name;
        uint[] skillsIds;
        uint[] pokemonType;
        uint[] pokemonWeaknesses;
    }

    Pokemon[] private pokemons;
    Skills[] private hability;
    TypePokemon[] private pokemonType;
    WeaknessesPokemon[] private pokemonWeaknesses;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;
    mapping(uint => Skills) public SkillsbyId;
    mapping(uint => uint[]) pokemonSkillsIds;
    mapping(uint => TypePokemon) public TypePokemonById;
    mapping(uint => WeaknessesPokemon) public WeaknessesPokemonById;

    event eventNewPokemon(address sender, string message);

    function createPokemon(
        string memory _name,
        uint _id,
        uint[] memory _skillsIds,
        uint[] memory _pokemonType,
        uint[] memory _pokemonWeaknesses
    ) public {
        require(_id > 0, "the id must be greater than 0 ");
        bytes memory nameReq = bytes(_name);
        require(
            nameReq.length > 2,
            "The name must be longer than 2 characters"
        );
        pokemons.push(Pokemon(_id, _name, _skillsIds, _pokemonType, _pokemonWeaknesses));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, "new pokemon its create");
    }

    function createSkill(string memory _name, string memory _description, uint _id) public {
      Skills memory newSkills = Skills(_name, _description);
      hability.push(newSkills);
      SkillsbyId[_id] = newSkills;
    }

    function createType(string memory _name, string memory _description, uint _id) public {
      TypePokemon memory newType = TypePokemon(_name, _description);
      pokemonType.push(newType);
      TypePokemonById[_id] = newType;
    }

    function createWeaknesses(string memory _name, string memory _description, uint _id) public {
      WeaknessesPokemon memory newWeakness = WeaknessesPokemon(_name, _description);
      pokemonWeaknesses.push(newWeakness);
      WeaknessesPokemonById[_id] = newWeakness;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getAllSkills() public view returns (Skills[] memory) {
        return hability;
    }

    function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }
}
