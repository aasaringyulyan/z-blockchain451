pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';
import 'BaseStation.sol';
import 'GameObjectInterface.sol';

contract MilitaryUnit is GameObject {

    address public stationAddress;
    // BaseStation baseSt;
    
   constructor(BaseStation _station, address unit) public {
        _station.addMilitary(unit);
        // baseSt = _station;
    }

    function attack(GameObjectInterface gameObject, address unit) external {
       gameObject.acceptAttack(unit, getAttackPower());
    }

    function getAttackPower() virtual public returns(uint) {}

    function getPowerProtection() virtual public override returns(uint) {}

    function processingDeath(address dest) internal override {
        // baseSt.removeMilitary(address(this)); // возможна проблема с адресом 
        sendAllMoneyDestroyWallet(dest);
        
    }

    function deathDueToStation() internal {
        
    }
}
