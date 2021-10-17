
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract taskListContract {

    struct task {
        string title;
        uint32 timestamp;
        bool flag;
    }

    int8 key = 0;

    mapping(int8 => task) public taskMap;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
    }

    modifier checkPubkeyAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();   
		_;
	}

     modifier checkMapEmpty {
		require(!taskMap.empty(), 101, 'Список задач пустой!');
		_;
	}

    function checkKey(int8 inputKey) public view {
		require(inputKey >= 0 && inputKey <= key, 101, 'Введенный ключ отсутствует!');
	}

    function addTask(string name) public checkPubkeyAndAccept {
        taskMap[key].title = name;
        taskMap[key].timestamp = now; 
        taskMap[key].flag = false;

        key++;
    }

    function getTaskNumber() public checkPubkeyAndAccept returns (uint8){
        uint8 count = 0;
        for (int8 i = 0; i < key; i++) {
            if (taskMap[i].flag == false){
                count++;
            }
        }

        return count;
    }

    function getTaskList() public checkPubkeyAndAccept checkMapEmpty returns (string[]) {
        string[] tasks;

        for (int8 i = 0; i < key; i++) {
            tasks.push(taskMap[i].title);
        }

        return tasks;
    }

    function getTaskDescriptByKey(int8 inputKey) public checkPubkeyAndAccept 
    checkMapEmpty returns (task){
        checkKey(inputKey);

        return taskMap[inputKey];
    }

    function deleteTaskByKey(int8 inputKey) public checkPubkeyAndAccept 
    checkMapEmpty {
        checkKey(inputKey);

        delete taskMap[inputKey];
    }

    function markTaskComplByKey(int8 inputKey) public checkPubkeyAndAccept 
    checkMapEmpty {
        checkKey(inputKey);

        taskMap[inputKey].flag = true;
    }
}
