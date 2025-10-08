// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title StudentRegistry
 * @dev 这个合约用于管理学生信息，包括注册新学生、查询信息等。
 */
contract StudentRegistry {
    // =========================================================================
    // 知识点：常量 (Constant) 和 变量 (Variable)
    // =========================================================================
    
    // 「常量」：SCHOOL_NAME 是一个编译时常量，一旦设定就无法更改，可以节省Gas。
    // 「命名标识符」：SCHOOL_NAME 是一个遵循大写下划线风格的常量标识符。
    string constant public SCHOOL_NAME = "Solidity Advanced Academy";

    // 「状态变量」：owner 和 studentCount 是存储在区块链上的状态变量。
    // 「基本数据类型」：address 和 uint256 (uint) 是基本数据类型。
    address public owner;
    uint256 public studentCount;

    // =========================================================================
    // 知识点：结构体 (Struct)
    // =========================================================================
    // 「结构体」：定义了一个自定义的复合数据类型 Student，用来组织学生相关的数据。
    // 「命名标识符」：Student 是一个遵循驼峰式命名法（首字母大写）的结构体标识符。
    struct Student {
        uint id;
        string name;
        uint age;
        bool isEnrolled; // 是否在读
    }

    // =========================================================================
    // 知识点：映射 (Mapping) 和 数组 (Array)
    // =========================================================================

    // 「映射」：一个哈希表，用于通过学生ID（uint）快速查找对应的 Student 结构体。
    // 「命名标识符」：studentsById 是一个变量标识符。
    mapping(uint => Student) public studentsById;

    // 「数组」：一个动态数组，用于存储所有已注册学生的ID。这使得我们可以遍历所有学生。
    uint[] public studentIds;

    // `constructor` 是一个特殊的函数，在合约部署时仅执行一次
    constructor() {
        // 「操作符」：'=' 赋值操作符
        // `msg.sender` 是一个全局变量，代表调用函数或创建合约的账户地址
        owner = msg.sender;
    }

    // =========================================================================
    // 函数与业务逻辑
    // =========================================================================

    /**
     * @dev 注册一个新学生
     * @param _id 学生ID
     * @param _name 学生姓名
     * @param _age 学生年龄
     */
    function addStudent(uint _id, string memory _name, uint _age) public {
        // 「操作符」：'==' (等于), '!=' (不等于), '&&' (逻辑与)
        // 使用 require 进行条件检查，如果条件不满足，则交易会回滚
        require(msg.sender == owner, "Only owner can add students.");
        require(studentsById[_id].id == 0, "Student with this ID already exists."); // 默认uint是0
        
        // 「存储位置修饰符」：`memory`
        // newStudent 是一个在函数执行期间存在于「内存(memory)」中的局部变量。
        // 它是一个临时的副本，用于构建数据，然后存入状态变量。
        Student memory newStudent = Student({
            id: _id,
            name: _name,
            age: _age,
            isEnrolled: true
        });

        // 将内存中的数据存入区块链「存储(storage)」中
        studentsById[_id] = newStudent;
        studentIds.push(_id);

        // 「操作符」：'++' (自增)
        studentCount++;
    }

    /**
     * @dev 更新一个学生的年龄
     * @param _id 学生ID
     * @param _newAge 新的年龄
     */
    function updateStudentAge(uint _id, uint _newAge) public {
        require(msg.sender == owner, "Only owner can perform this action.");
        
        // 「存储位置修饰符」：`storage`
        // 这里的 `student` 是一个指向区块链「存储(storage)」中数据的「指针」或「引用」。
        // 直接修改 `student.age` 就会修改区块链上的原始数据，非常高效。
        Student storage student = studentsById[_id];
        
        require(student.id != 0, "Student not found."); // 确保学生存在
        
        // 「操作符」：'=' (赋值)
        student.age = _newAge;
    }

    /**
     * @dev 获取所有学生ID列表
     * @return uint[] 所有学生ID的数组
     */
    // 「存储位置修饰符」：`calldata` vs `memory`
    // 对于外部函数的只读数据，`calldata` 是比 `memory` 更节省Gas的选择。
    // 这里我们返回一个 memory 数组，因为返回动态数组需要创建在内存中。
    function getAllStudentIds() public view returns (uint[] memory) {
        return studentIds;
    }

    // TODO 删除学生
}