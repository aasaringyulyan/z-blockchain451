pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'MilitaryUnit.sol';

contract Archer is MilitaryUnit {

    uint attackArcher;
    uint protectArcher;

    constructor(BaseStation _base, uint _attackArcher, uint _protectArcher) 
    MilitaryUnit(_base, address(this)) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
        
        attackArcher = _attackArcher;
        protectArcher = _protectArcher;
    }
    
    function getAttackPower() public override returns(uint) {
        tvm.accept();
        return attackArcher;
    }

    function getPowerProtection() public override returns(uint) {
        tvm.accept();
        return protectArcher;
    }

    function rm(address adr) public {
        tvm.accept();
        adr.transfer(1, true, 160);
    }
}
