// 1. 适配 Remix 环境的导入方式 (去掉花括号)
const Web3 = require('web3');

// 2. 连接节点
// 注意：如果 Remix 提示连接失败 (Mixed Content)，是因为浏览器禁止从 HTTPS 页面连接不安全的 ws 协议。
// 这种情况下，建议在本地终端运行此脚本 (node script.js)，而不是在 Remix 网页中运行。
const web3 = new Web3('ws://127.0.0.1:8545');

// 3. 合约配置
// 注意：我帮您去掉了地址末尾多余的 "."，否则会报 invalid address 错误
const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3'; 

const contractABI = [
    {
        "anonymous": false,
        "inputs": [
            { "indexed": true, "internalType": "address", "name": "sender", "type": "address" },
            { "indexed": false, "internalType": "uint256", "name": "newValue", "type": "uint256" },
            { "indexed": false, "internalType": "string", "name": "message", "type": "string" }
        ],
        "name": "DataChanged",
        "type": "event"
    }
];

const myContract = new web3.eth.Contract(contractABI, contractAddress);

// 4. 核心：监听逻辑
// 封装成 async 函数以使用 await (虽然 Web3 v1 的 .on 是基于 PromiEvent 的，但在 Remix 脚本中这样写更稳健)
async function listenToEvents() {
    console.log("🎧 正在监听 DataChanged 事件...");
    
    // Web3 v1.x 写法: myContract.events.EventName(options)
    const subscription = myContract.events.DataChanged({
        fromBlock: 'latest'
    });

    // 处理数据
    subscription.on('data', (event) => {
        console.log("\n🔥 捕获到新事件！");
        // event.returnValues 对应书中的 returnValues 
        console.log("发送者:", event.returnValues.sender);
        console.log("新数值:", event.returnValues.newValue); // v1.x 可能直接返回字符串，视具体版本而定
        console.log("新消息:", event.returnValues.message);
        console.log("交易哈希:", event.transactionHash);
    });

    // 处理错误
    subscription.on('error', (error) => {
        console.error("❌ 监听出错:", error);
    });

    console.log("监听器已启动，请去触发合约交易...");
    
    // 在 Remix 脚本中，通常需要保持脚本运行，但在 v1.x 中监听器是异步的。
    // 如果脚本立刻结束，可能需要人为挂起，或者直接观察控制台日志。
}

// 执行
// Remix 的 async/await 包装器会自动处理这个 Promise
(async () => {
    try {
        await listenToEvents();
    } catch (e) {
        console.log(e.message);
    }
})();