pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObjectInterface.sol';

contract GameObject is GameObjectInterface {

    uint health = 5;
    
    function getPowerProtection() virtual public returns(uint) {}

    // скрыть от пользователя internal
    function acceptAttack(address unit, uint attack) external override {
        attack -= getPowerProtection(); 
        health -= attack;

        if (isDied(health)) {
            processingDeath(unit);
        }
    }

    function isDied(uint value) private returns (bool) {
        if (value <= 0) {
            return true;
        }

        return false;
    }

    function processingDeath(address dest) virtual internal {
        sendAllMoneyDestroyWallet(dest);
    }

    function sendAllMoneyDestroyWallet(address dest) internal {
        dest.transfer(1, true, 160);
    }
}
