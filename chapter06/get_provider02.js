// get_provider02.js

// 1. 引入库 (注意：现代 Web3 v4.x 的 CommonJS 引入方式)
const { Web3 } = require('web3'); 

// 2. 实例化和连接 Provider
// (!! 替换为您自己的 Infura API Key 或本地 Geth/Parity 节点地址)
const providerURL = 'https://mainnet.infura.io/v3/YOUR_API_KEY';
// const providerURL = 'http://127.0.0.1:8545'; // 如果是本地节点

console.log("正在连接到节点:", providerURL);
const web3 = new Web3(providerURL);

// 您的代码需要放在一个 async 函数中才能使用 await
async function runScript() {
    try {
        // --- 从这里开始，才是您在 Remix 中运行的代码 ---
        console.log("开始执行脚本...");
        const nodeInfo = await web3.eth.getNodeInfo();
        console.log(nodeInfo);

        const protocolVersion = await web3.eth.getProtocolVersion();
        console.log("Protocol Version:", protocolVersion);
    } catch (e) {
        console.error("执行 web3 脚本时出错:", e);
    }
}

// 启动函数
runScript();