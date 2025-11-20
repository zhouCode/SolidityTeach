// 1. 适配 Remix 环境的导入方式 (不要用花括号)
const Web3 = require('web3');

// 2. 连接节点
// 注意：Remix 是 HTTPS 网站，连接 http://127.0.0.1 可能会因为“混合内容”安全策略被浏览器拦截。
// 如果连接失败，请尝试在 Chrome 地址栏右侧点击盾牌图标允许不安全脚本，或者在本地终端运行此脚本。
const web3 = new Web3('http://127.0.0.1:8545');

// 3. 合约配置
const contractAddress = '0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9';
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

async function queryPastEvents() {
    try {
        console.log("🔍 开始查询历史日志...");

        // ==========================================
        // 场景 A: 获取所有历史事件
        // ==========================================
        const allEvents = await myContract.getPastEvents('DataChanged', {
            fromBlock: 0,
            toBlock: 'latest' 
        });

        console.log(`\n--- 场景 A: 共找到 ${allEvents.length} 条历史记录 ---`);
        allEvents.forEach((event, index) => {
            console.log(`\n[记录 ${index + 1}]`);
            console.log(`  区块高度: ${event.blockNumber}`);
            console.log(`  发送者: ${event.returnValues.sender}`);
            // Web3 v1.x 返回的值通常是字符串，直接打印即可
            console.log(`  数值: ${event.returnValues.newValue.toString()}`);
            console.log(`  消息: ${event.returnValues.message}`);
        });

        // ==========================================
        // 场景 B: 高级过滤
        // ==========================================
        const targetAddress = '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266';
        
        const filteredEvents = await myContract.getPastEvents('DataChanged', {
            fromBlock: 0,
            toBlock: 'latest',
            filter: { 
                sender: targetAddress 
            }
        });

        console.log(`\n--- 场景 B: 地址 ${targetAddress} 的记录 (${filteredEvents.length} 条) ---`);
        filteredEvents.forEach(event => {
            console.log(`  -> 在区块 ${event.blockNumber} 修改了数据: ${event.returnValues.message}`);
        });

    } catch (error) {
        console.error("查询出错:", error);
        console.log("提示：如果出现 Network Error，通常是因为浏览器阻止了 Remix (HTTPS) 访问本地节点 (HTTP)。");
    }
}

// 执行
(async () => {
    await queryPastEvents();
})();