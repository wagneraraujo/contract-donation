// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * Contract Style Guide
 * Variables
 * Mappings
 * Structs
 * Enums
 * Events
 * Errors
 * Constructor
 * Modifier
 * Functions
 */

contract Donation {
    /**
     * public ou private para usar essa vairavel apenas n ocontrato ou em outros contratos
     */
    address owner;
    uint256 public total;
    uint256 public ids;
    Donor[] private donations;

    struct Donor {
        uint256 id;
        address donor;
        uint256 value;
    }

    /**
    //quando eu quero iniciar alguma variavel ou parametro, alguma regra na hora do deplot, eyu uso o constructor
    */

    constructor() {
        owner = msg.sender; //dono do contrato
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Voce nao e o dono deste contrato");
        _;
    }

    /**
     * 
     *     //metodo para retornar todos
    // externo mais barato, porque e chamado de outros contratos ou uma aplicavao que tenha acesso ao contrato

    //view -porque não ta interagindo, não ta alterando o contrato

    //memory -: só vai existir quando eu chamar, 
     */

    function donate() external payable {
        require(
            msg.value > 0,
            "Valor menor que os custos da transacao na blockchain"
        );
        ids++;
        Donor memory donation = Donor(ids, msg.sender, msg.value);
        donations.push(donation);

        total += msg.value;
    }

    function getDonations() external view returns (Donor[] memory) {
        return donations;
    }

    function withdraw() external payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "valor muito pequeno");

        //caso de erro, consegue reverter
        (bool success, ) = (msg.sender).call{value: balance}("");
        require(success, "algo deu errado na transferencia");
    }
}
