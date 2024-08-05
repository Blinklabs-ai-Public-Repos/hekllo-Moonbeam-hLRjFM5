// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/**
 * @title BurnableToken
 * @dev Implementation of a burnable ERC20 token with a maximum supply.
 */
contract BurnableToken is ERC20Burnable {
    uint256 private immutable _maxSupply;

    /**
     * @dev Constructor that sets the name, symbol, and maximum supply of the token.
     * @param name_ The name of the token.
     * @param symbol_ The symbol of the token.
     * @param maxSupply_ The maximum supply of the token.
     */
    constructor(string memory name_, string memory symbol_, uint256 maxSupply_) ERC20(name_, symbol_) {
        require(maxSupply_ > 0, "BurnableToken: max supply must be greater than zero");
        _maxSupply = maxSupply_;
        _mint(msg.sender, maxSupply_);
    }

    /**
     * @dev Returns the maximum supply of the token.
     * @return The maximum supply of the token.
     */
    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    /**
     * @dev See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the total supply after minting must not exceed the maximum supply.
     */
    function _mint(address account, uint256 amount) internal virtual override {
        require(totalSupply() + amount <= _maxSupply, "BurnableToken: max supply exceeded");
        super._mint(account, amount);
    }
}