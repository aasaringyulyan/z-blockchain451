
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TokenContract {
    struct Token {
        string name;
        uint32 time;
        string title;
    }

    Token[] tokensArr;
    
    mapping (uint => uint) tokenToOwner;
    mapping (uint => uint) tokenToPrice;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
    
        tvm.accept();
    }

     modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);

		tvm.accept();
		_;
	}

    function isCorrect(string name) private returns (bool){
       for (uint256 i = 0; i < tokensArr.length; i++) {
           if (tokensArr[i].name == name) {
               return false;
           }
       }

        return true;
    }

    function createToken(string name, string title) public checkOwnerAndAccept {
        require(isCorrect(name), 101);
        tokensArr.push(Token(name, now, title)); 
        uint keyAsLastNum = tokensArr.length - 1;
        tokenToOwner[keyAsLastNum] = msg.pubkey();
    }

    function putTokenSale(uint tokenId, uint price) public checkOwnerAndAccept {
        require(msg.pubkey() == tokenToOwner[tokenId], 101);
        tokenToPrice[tokenId] = price; 
    }
}