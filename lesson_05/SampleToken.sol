
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract SampleToken {

    struct Token {
        string name;
        uint power;
    }

    Token[] tokensArr;
    mapping (uint => uint) tokenToOwner;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
    }

    function createToken(string name, uint power) public {
        tvm.accept();
        tokensArr.push(Token(name, power)); 
        uint keyAsLastNum = tokensArr.length - 1;
        tokenToOwner[keyAsLastNum] = msg.pubkey();
    }

    function getTokenOwner(uint tokenId) public view returns (uint) {
         return tokenToOwner[tokenId];
    }

    function getTokenInfo(uint tokenId) public view 
    returns (string tokenName, uint tokenPower) {
        tokenName = tokensArr[tokenId].name;
        tokenPower = tokensArr[tokenId].power;
    }

    function changeOwner(uint tokenId, uint pubKeyOfNewOwner) public {
        require(msg.pubkey() == tokenToOwner[tokenId], 101);
        tvm.accept();
        tokenToOwner[tokenId] = pubKeyOfNewOwner;
    }

    function changePower(uint tokenId, uint power) public {
        require(msg.pubkey() == tokenToOwner[tokenId], 101);
        tvm.accept();
        tokensArr[tokenId].power = power;
    }

    
}
