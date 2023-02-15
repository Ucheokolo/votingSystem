// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract votingContract is ERC20 {
    address public owner;
    address public Admin;
    bool public votingOngoing;
    address[3] public contenders;

    mapping(address => uint256) public points;
    mapping(address => uint256) public ballotCast;
    mapping(address => bool) public voteStatus;
    uint256 tokenPrice = 1000 gwei;

    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        Admin = msg.sender;
        owner = address(this);
    }

    modifier onlyAdmin() {
        require(msg.sender == Admin, "Only Admin can open voting");

        _;
    }

    function registerContenders(
        address contender1,
        address contender2,
        address contender3
    ) public onlyAdmin returns (address[3] memory _contenders) {
        contenders[0] = contender1;
        contenders[1] = contender2;
        contenders[2] = contender3;
        _contenders = contenders;
        votingOngoing = true;
    }

    function mintToken(uint256 _amount) public onlyAdmin {
        _mint(address(this), _amount);
    }

    function voteContenders(
        address firstChoice,
        address secondChoice,
        address thirdChoice
    ) public {
        require(votingOngoing == true, "Admin yet to Initiate voting");
        require(
            firstChoice != address(0) &&
                secondChoice != address(0) &&
                thirdChoice != address(0),
            "Address zero can't be a contender"
        );
        require(
            firstChoice != secondChoice &&
                firstChoice != thirdChoice &&
                secondChoice != thirdChoice,
            "can not vote an address twice"
        );
        require(msg.sender != address(0), "Zero address not permitted to vote");
        require(
            balanceOf(msg.sender) >= 6,
            "Insufficient balance for voting participation"
        );
        require(voteStatus[msg.sender] == false, "Double voting prohibited");

        points[firstChoice] += 3;
        points[secondChoice] += 2;
        points[thirdChoice] += 1;

        // uint size = votePoints.length;
        // for (uint i = 0; i < size; i++){

        // }

        _burn(msg.sender, 6);
        voteStatus[msg.sender] = true;
        ballotCast[msg.sender]++;
    }

    function purchaseToken() public payable {
        uint256 tokenEquivalent = msg.value / tokenPrice;
        _transfer(address(this), msg.sender, tokenEquivalent);
        // balanceOf(msg.sender) += tokenEquivale
    }

    function endVoting() public onlyAdmin {
        votingOngoing = false;
    }

    //0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    //0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    //0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
}
