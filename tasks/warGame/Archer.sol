pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'MilitaryUnit.sol';

contract Archer is MilitaryUnit {
    uint attackArcher;
    uint protectArcher;
    address public archerAddress = this;

    constructor(BaseStation _baseSA, uint _attackArcher, uint _protectArcher) 
    MilitaryUnit(_baseSA, archerAddress) public override {
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
}
