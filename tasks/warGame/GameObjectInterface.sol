pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface GameObjectInterface {
    function acceptAttack(address unit, uint attack) external;
}
