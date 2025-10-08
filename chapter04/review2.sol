// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleCrowdFund {
    // 「结构体」：定义一个众筹项目
    struct Campaign {
        address payable creator; // 项目发起人，payable使其可接收ether
        uint goal;               // 筹款目标 (单位: wei)
        uint deadline;           // 截止时间 (Unix timestamp)
        uint raisedAmount;       // 已筹集金额
        bool completed;          // 是否已完成（提款）
    }

    // 「常量」：最短的众筹周期为7天
    uint constant public MINIMUM_DURATION = 7 days;

    // 「数组」：存储所有的众筹项目
    Campaign[] public campaigns;

    // 「映射」：记录每个地址在每个项目中的捐款金额
    mapping(uint => mapping(address => uint)) public contributions;

    /**
     * @dev 创建一个新的众筹项目
     * @param _goal 筹款目标 (以 ether 为单位)
     * @param _durationInDays 众筹持续天数
     */
    function createCampaign(uint _goal, uint _durationInDays) public {
        require(_durationInDays * 1 days >= MINIMUM_DURATION, "Campaign duration is too short.");

        // 「操作符」：'*' (乘法)，'**' (指数)
        // 将用户输入的 ether 转换为 wei
        uint goalInWei = _goal * (10**18);

        // 「存储位置修饰符」：`storage`
        // 直接在 campaigns 数组末尾创建一个新的 Campaign 实例并获取其引用
        Campaign storage newCampaign = campaigns.push();

        // 初始化新项目的数据
        newCampaign.creator = payable(msg.sender);
        newCampaign.goal = goalInWei;
        // 「操作符」：'+' (加法)
        newCampaign.deadline = block.timestamp + (_durationInDays * 1 days);
    }

    /**
     * @dev 为一个项目捐款
     * @param _campaignId 项目的ID (即它在数组中的索引)
     */
    function contribute(uint _campaignId) public payable {
        // 「操作符」：'>=' (大于等于)
        require(_campaignId < campaigns.length, "Campaign does not exist.");
        
        Campaign storage campaign = campaigns[_campaignId];
        
        // 「操作符」：'!' (逻辑非), '&&' (逻辑与)
        require(block.timestamp < campaign.deadline, "Campaign has ended.");
        require(!campaign.completed, "Campaign is already completed.");
        require(msg.value > 0, "Contribution must be greater than 0.");

        // 更新捐款记录和已筹集金额
        contributions[_campaignId][msg.sender] += msg.value;
        campaign.raisedAmount += msg.value;
    }

    /**
     * @dev 项目发起人提取资金
     * @param _campaignId 项目ID
     */
    function withdrawFunds(uint _campaignId) public {
        require(_campaignId < campaigns.length, "Campaign does not exist.");
        
        Campaign storage campaign = campaigns[_campaignId];

        require(msg.sender == campaign.creator, "Only the creator can withdraw.");
        require(block.timestamp >= campaign.deadline, "Campaign has not ended yet.");
        require(campaign.raisedAmount >= campaign.goal, "Campaign goal not reached.");
        require(!campaign.completed, "Funds have already been withdrawn.");

        campaign.completed = true;
        
        // 将合约中筹集的资金转给项目创建者
        (bool sent, ) = campaign.creator.call{value: campaign.raisedAmount}("");
        require(sent, "Failed to send Ether");
    }

    // TODO 如果捐款目标未达成，给所有捐款者退款
}