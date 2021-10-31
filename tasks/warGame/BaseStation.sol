pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';

contract BaseStation is GameObject {

    address[] public unitsAddress;

    uint protect = 20;

    function getPowerProtection() public override returns(uint) {
        tvm.accept();
        return protect;
    }

    function addMilitary(address dest) external  {
        tvm.accept();
        unitsAddress.push(dest);
    }

    function removeMilitary(address dest) public {
        tvm.accept();
        for (uint256 i = 0; i < unitsAddress.length; i++) {
            if (unitsAddress[i] == dest) {
                address tmp = unitsAddress[i];
                unitsAddress[i] = unitsAddress[unitsAddress.length - 1];
                unitsAddress[unitsAddress.length - 1] = tmp;
                unitsAddress.pop();
                break;
            }
        }
    }

    function processingDeath(address dest) internal override {
        for (uint256 i = 0; i < unitsAddress.length; i++) {
            
        }

        sendAllMoneyDestroyWallet(dest);
    }
}