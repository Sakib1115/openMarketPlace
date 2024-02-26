// SPDX-License-Identifier: UNLICENSED

// File: Address.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: Context.sol

pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: Ownable.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: TestIDOInfo.sol

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract TestIDOInfo is Ownable {

    uint256 private devFeePercentage = 1;

    uint256 private minDevFeeInWei = 1 ether;

    address[] private presaleAddresses;

    mapping (address => bool) public alreadyAdded;

    function validTestIDOId(uint256 testIDOId) public view returns (bool) {
        if(testIDOId >=0 && testIDOId <= presaleAddresses.length-1)
          return true;
    }

    function addPresaleAddress(address _presale) external returns (uint256) {
        require(_presale != address(0), "Address cannot be a zero address");
        require(!alreadyAdded[_presale], "Address already added");

        presaleAddresses.push(_presale);
        alreadyAdded[_presale] = true;
        return presaleAddresses.length - 1;
    }

    function getPresalesCount() external view returns (uint256) {
        return presaleAddresses.length;
    }

    function getPresaleAddress(uint256 testIDOId) external view returns (address) {
        require(validTestIDOId(testIDOId), "Not a valid Id");
        return presaleAddresses[testIDOId];
    }

    function getDevFeePercentage() external view returns (uint256) {
        return devFeePercentage;
    }

    function setDevFeePercentage(uint256 _devFeePercentage) external onlyOwner {
        devFeePercentage = _devFeePercentage;
    }

    function getMinDevFeeInWei() external view returns (uint256) {
        return minDevFeeInWei;
    }

    function setMinDevFeeInWei(uint256 _minDevFeeInWei) external onlyOwner {
        minDevFeeInWei = _minDevFeeInWei;
    }
}

// File: SafeMath.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: IERC20.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: SafeERC20.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: TokenTimelock.sol



pragma solidity 0.6.12;


/**
 * @dev A token holder contract that will allow a beneficiary to extract the
 * tokens after a given release time.
 *
 * Useful for simple vesting schedules like "advisors get all of their tokens
 * after 1 year".
 */
contract TokenTimelock {
    using SafeERC20 for IERC20;

    // ERC20 basic token contract being held
    IERC20 private _token;

    // beneficiary of tokens after they are released
    address private _beneficiary;

    // timestamp when token release is enabled
    uint256 private _releaseTime;

    // Emitted when the token is released by the beneficiary.
    event TokenReleased(address account, uint256 tokenAmount);

    constructor (IERC20 tokenAddress, address beneficiaryAddress, uint256 releaseTimestamp) public {
        // solhint-disable-next-line not-rely-on-time
        require(releaseTimestamp > block.timestamp, "TokenTimelock: release time is before current time");
        require(beneficiaryAddress != address(0), "Address cannot be a zero address");
        _token = tokenAddress;
        _beneficiary = beneficiaryAddress;
        _releaseTime = releaseTimestamp;
    }

    /**
     * @dev Throws if called by any account other than the beneficiary.
     */
    modifier onlyBeneficiary() {
      require(msg.sender == _beneficiary, "Not a beneficiary");
      _;
    }

    /**
     * @return the token being held.
     */
    function token() public view returns (IERC20) {
        return _token;
    }

    /**
     * @return the beneficiary of the tokens.
     */
    function beneficiary() public view returns (address) {
        return _beneficiary;
    }

    /**
     * @return the time when the tokens are released.
     */
    function releaseTime() public view returns (uint256) {
        return _releaseTime;
    }

    /**
     * to update beneficiary of the tokens.
     */
    function updateBeneficiary(address beneficiaryAddress) public {
        _beneficiary = beneficiaryAddress;
    }

    /**
     * to update release Time of the tokens.
     */
    function updateReleaseTime(uint256 releaseTimestamp) public {
        _releaseTime = releaseTimestamp;
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function release() public virtual onlyBeneficiary {
        // solhint-disable-next-line not-rely-on-time
        require(block.timestamp >= _releaseTime, "TokenTimelock: current time is before release time");

        uint256 amount = _token.balanceOf(address(this));
        require(amount > 0, "TokenTimelock: no tokens to release");

        _token.safeTransfer(_beneficiary, amount);

        emit TokenReleased(_beneficiary, amount);

    }
}

// File: TestIDOLiquidityLock.sol


pragma solidity 0.6.12;


contract TestIDOLiquidityLock is TokenTimelock {
    constructor(
        IERC20 token_,
        address presaleCreator,
        uint256 releaseTime_
    ) public TokenTimelock(token_, presaleCreator, releaseTime_) {}
}

// File: TestIDOPresale.sol


pragma solidity 0.6.12;


// import "./ILiquidityValueCalculator.sol";

interface IUniswapV2Router02 {
    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
    external
    payable
    returns (
        uint256 amountToken,
        uint256 amountETH,
        uint256 liquidity
    );
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external 
    returns (
        uint amountA, 
        uint amountB, 
        uint liquidity 
        );
}

contract TestIDOPresale {
    using SafeMath for uint256;

    IUniswapV2Router02 private constant ammRouter =
    IUniswapV2Router02(address(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3));

    address payable internal testIDOFactoryAddress; // address that creates the presale contracts
    address payable public testIDODevAddress; // address where dev fees will be transferred to
    address public testIDOLiqLockAddress; // address where LP tokens will be locked

    address payable public presaleCreatorAddress; // address where percentage of invested wei will be transferred to
    address public unsoldTokensDumpAddress; // address where unsold tokens will be transferred to
    address public investmentToken;         // token in which the users will invest 

    IERC20 public token; // token that will be sold
    IERC20 public platformToken; // Platform token
    // ILiquidityValueCalculator public lvCalculator;

    mapping(address => uint256) public investments; // total wei invested per address
    mapping(address => bool) public whitelistedAddresses; // addresses eligible in presale
    mapping(address => bool) public claimed; // if true, it means investor already claimed the tokens or got a refund

    uint256 private testIDODevFeePercentage; // dev fee to support the development of TestIDO Investments
    uint256 private testIDOMinDevFeeInWei; // minimum fixed dev fee to support the development of TestIDO Investments
    uint256 public testIDOId; // used for fetching presale without referencing its address

    uint256 public totalInvestorsCount; // total investors count
    uint256 public presaleCreatorClaimWei; // wei to transfer to presale creator per investor claim
    uint256 public presaleCreatorClaimTime; // time when presale creator can collect funds raise
    uint256 public totalCollectedWei; // total wei collected
    uint256 public totalTokens; // total tokens to be sold
    uint256 public tokensLeft; // available tokens to be sold
    uint256 public tokenPriceInWei; // token presale wei price per 1 token
    uint256 public hardCapInWei; // maximum wei amount that can be invested in presale
    uint256 public softCapInWei; // minimum wei amount to invest in presale, if not met, invested wei will be returned
    uint256 public maxInvestInWei; // maximum wei amount that can be invested per wallet address
    uint256 public minInvestInWei; // minimum wei amount that can be invested per wallet address
    uint256 public openTime; // time when presale starts, investing is allowed
    uint256 public closeTime; // time when presale closes, investing is not allowed
    uint256 public ammListingPriceInWei; // token price when listed in Uniswap
    uint256 public ammLiquidityAddingTime; // time when adding of liquidity in uniswap starts, investors can claim their tokens afterwards
    uint256 public ammLPTokensLockDurationInDays; // how many days after the liquity is added the presale creator can unlock the LP tokens
    uint256 public ammLiquidityPercentageAllocation; // how many percentage of the total invested wei that will be added as liquidity

    bool public ammLiquidityAdded = false; // if true, liquidity is added in Uniswap and lp tokens are locked
    bool public onlyWhitelistedAddressesAllowed = false; // if true, only whitelisted addresses can invest
    bool public testIDODevFeesExempted = false; // if true, presale will be exempted from dev fees
    bool public presaleCancelled = false; // if true, investing will not be allowed, investors can withdraw, presale creator can withdraw their tokens

    bytes32 public saleTitle;
    bytes32 public linkTelegram;
    bytes32 public linkTwitter;
    bytes32 public linkDiscord;
    bytes32 public linkWebsite;

    constructor(address _testIDOFactoryAddress, address _testIDODevAddress) public {
        require(_testIDOFactoryAddress != address(0));
        require(_testIDODevAddress != address(0));

        testIDOFactoryAddress = payable(_testIDOFactoryAddress);
        testIDODevAddress = payable(_testIDODevAddress);
    }

    modifier onlyTestIDODev() {
        require(testIDOFactoryAddress == msg.sender || testIDODevAddress == msg.sender);
        _;
    }

    modifier onlyTestIDOFactory() {
        require(testIDOFactoryAddress == msg.sender);
        _;
    }

    modifier onlyPresaleCreatorOrTestIDOFactory() {
        require(
            presaleCreatorAddress == msg.sender || testIDOFactoryAddress == msg.sender,
            "Not presale creator or factory"
        );
        _;
    }

    modifier onlyPresaleCreator() {
        require(presaleCreatorAddress == msg.sender, "Not presale creator");
        _;
    }

    modifier whitelistedAddressOnly() {
        require(
            !onlyWhitelistedAddressesAllowed || whitelistedAddresses[msg.sender],
            "Address not whitelisted"
        );
        _;
    }

    modifier presaleIsNotCancelled() {
        require(!presaleCancelled, "Cancelled");
        _;
    }

    modifier investorOnly() {
        require(investments[msg.sender] > 0, "Not an investor");
        _;
    }

    modifier notYetClaimedOrRefunded() {
        require(!claimed[msg.sender], "Already claimed or refunded");
        _;
    }

    function setAddressInfo(
        address _presaleCreator,
        address _tokenAddress,
        address _unsoldTokensDumpAddress
    ) external onlyTestIDOFactory {
        require(_presaleCreator != address(0));
        require(_tokenAddress != address(0));
        require(_unsoldTokensDumpAddress != address(0));

        presaleCreatorAddress = payable(_presaleCreator);
        token = IERC20(_tokenAddress);
        unsoldTokensDumpAddress = _unsoldTokensDumpAddress;
    }

    function setGeneralInfo(
        uint256 _totalTokens,
        uint256 _tokenPriceInWei,
        uint256 _hardCapInWei,
        uint256 _softCapInWei,
        uint256 _maxInvestInWei,
        uint256 _minInvestInWei,
        uint256 _openTime,
        uint256 _closeTime,
        address _investmentToken
    ) external onlyTestIDOFactory {
        require(_totalTokens > 0);
        require(_tokenPriceInWei > 0);
        require(_openTime > 0);
        require(_closeTime > 0);
        require(_closeTime >= block.timestamp);
        require(_hardCapInWei > 0);

        // Hard cap <= (token amount * token price)
        require(_hardCapInWei <= _totalTokens.mul(_tokenPriceInWei));
        // Soft cap <= to hard cap
        require(_softCapInWei <= _hardCapInWei);
        //  Min. wei investment <= max. wei investment
        require(_minInvestInWei <= _maxInvestInWei);
        // Open time < close time
        require(_openTime < _closeTime);

        totalTokens = _totalTokens;
        tokensLeft = _totalTokens;
        tokenPriceInWei = _tokenPriceInWei;
        hardCapInWei = _hardCapInWei;
        softCapInWei = _softCapInWei;
        maxInvestInWei = _maxInvestInWei;
        minInvestInWei = _minInvestInWei;
        openTime = _openTime;
        closeTime = _closeTime;
        investmentToken = _investmentToken;
    }

    function setAMMInfo(
        uint256 _ammListingPriceInWei,
        uint256 _ammLiquidityAddingTime,
        uint256 _ammLPTokensLockDurationInDays,
        uint256 _ammLiquidityPercentageAllocation
    ) external onlyTestIDOFactory {
        require(_ammListingPriceInWei > 0);
        require(_ammLiquidityAddingTime > 0);
        require(_ammLPTokensLockDurationInDays > 0);
        require(_ammLiquidityPercentageAllocation > 0);

        require(closeTime > 0);
        // Listing time >= close time
        require(_ammLiquidityAddingTime >= closeTime);

        ammListingPriceInWei = _ammListingPriceInWei;
        ammLiquidityAddingTime = _ammLiquidityAddingTime;
        ammLPTokensLockDurationInDays = _ammLPTokensLockDurationInDays;
        ammLiquidityPercentageAllocation = _ammLiquidityPercentageAllocation;
    }

    function setStringInfo(
        bytes32 _saleTitle,
        bytes32 _linkTelegram,
        bytes32 _linkDiscord,
        bytes32 _linkTwitter,
        bytes32 _linkWebsite
    ) external onlyPresaleCreatorOrTestIDOFactory {
        saleTitle = _saleTitle;
        linkTelegram = _linkTelegram;
        linkDiscord = _linkDiscord;
        linkTwitter = _linkTwitter;
        linkWebsite = _linkWebsite;
    }

    function setTestIDOInfo(
        address _testIDOLiqLockAddress,
        uint256 _testIDODevFeePercentage,
        uint256 _testIDOMinDevFeeInWei,
        uint256 _testIDOId
    ) external onlyTestIDODev {
        require(_testIDOLiqLockAddress != address(0), "Address cannot be a zero address");

        testIDOLiqLockAddress = _testIDOLiqLockAddress;
        testIDODevFeePercentage = _testIDODevFeePercentage;
        testIDOMinDevFeeInWei = _testIDOMinDevFeeInWei;
        testIDOId = _testIDOId;
    }

    function setTestIDODevFeesExempted(bool _testIDODevFeesExempted)
    external
    onlyTestIDODev
    {
        testIDODevFeesExempted = _testIDODevFeesExempted;
    }

    function setOnlyWhitelistedAddressesAllowed(bool _onlyWhitelistedAddressesAllowed)
    external
    onlyPresaleCreatorOrTestIDOFactory
    {
        onlyWhitelistedAddressesAllowed = _onlyWhitelistedAddressesAllowed;
    }

    function addwhitelistedAddresses(address[] calldata _whitelistedAddresses)
    external
    onlyPresaleCreatorOrTestIDOFactory
    {
        uint256 local_variable = _whitelistedAddresses.length;
        onlyWhitelistedAddressesAllowed = _whitelistedAddresses.length > 0;
        for (uint256 i = 0; i < local_variable; i++) {
            whitelistedAddresses[_whitelistedAddresses[i]] = true;
        }
    }

    function setPlatformTokenAddress(address _platformToken) external onlyTestIDODev returns (bool) {
        platformToken = IERC20(_platformToken);
        return true;
    }

    // function setLiquidityValueCalculator(address _lvCalculator) external onlyTestIDODev returns (bool) {
    //     lvCalculator = ILiquidityValueCalculator(_lvCalculator);
    //     return true;
    // }

    function getTokenAmount(uint256 _weiAmount)
    internal
    view
    returns (uint256)
    {
        return _weiAmount.mul(1e18).div(tokenPriceInWei);
    }

    function invest(uint256 _amount)
    public
    payable
    whitelistedAddressOnly
    presaleIsNotCancelled
    {
        uint256 amount = (investmentToken == 0x0000000000000000000000000000000000000000) ? msg.value : _amount;
        
        require(block.timestamp >= openTime, "Not yet opened");
        require(block.timestamp < closeTime, "Closed");
        require(totalCollectedWei < hardCapInWei, "Hard cap reached");
        require(tokensLeft > 0, "No token left");
        require(amount <= tokensLeft.mul(tokenPriceInWei), "Investment would exceed left tokens");
        uint256 totalInvestmentInWei = investments[msg.sender].add(amount);
        require(totalInvestmentInWei >= minInvestInWei || totalCollectedWei >= hardCapInWei.sub(1 ether), "Min investment not reached");
        require(maxInvestInWei == 0 || totalInvestmentInWei <= maxInvestInWei, "Max investment reached");

        if (investments[msg.sender] == 0) {
            totalInvestorsCount = totalInvestorsCount.add(1);
        }

        totalCollectedWei = totalCollectedWei.add(amount);
        investments[msg.sender] = totalInvestmentInWei;
        tokensLeft = tokensLeft.sub(getTokenAmount(amount));

        if(investmentToken != 0x0000000000000000000000000000000000000000)
            IERC20(investmentToken).transferFrom(msg.sender, address(this), amount);
    }

    // receive() external payable {
    //     invest();
    // }

    function addLiquidityAndLockLPTokens() external presaleIsNotCancelled {
        require(totalCollectedWei > 0, "Total tokens raised should be more than 0");
        require(!ammLiquidityAdded, "Liquidity already added");
        require(
            !onlyWhitelistedAddressesAllowed || whitelistedAddresses[msg.sender] || msg.sender == presaleCreatorAddress,
            "Not whitelisted or not presale creator"
        );

        if (totalCollectedWei >= hardCapInWei.sub(1 ether) && block.timestamp < ammLiquidityAddingTime) {
            require(msg.sender == presaleCreatorAddress, "Not presale creator");
        } else if (block.timestamp >= ammLiquidityAddingTime) {
            require(
                msg.sender == presaleCreatorAddress || investments[msg.sender] > 0,
                "Not presale creator or investor"
            );
            require(totalCollectedWei >= softCapInWei, "Soft cap not reached");
        } else {
            revert("Liquidity cannot be added yet");
        }

        ammLiquidityAdded = true;

        uint256 finalTotalCollectedWei = totalCollectedWei;
        uint256 testIDODevFeeInWei;
        if (!testIDODevFeesExempted) {
            uint256 pctDevFee = finalTotalCollectedWei.mul(testIDODevFeePercentage).div(100);
            testIDODevFeeInWei = pctDevFee > testIDOMinDevFeeInWei || testIDOMinDevFeeInWei >= finalTotalCollectedWei
            ? pctDevFee
            : testIDOMinDevFeeInWei;
        }
        if (testIDODevFeeInWei > 0) {
            finalTotalCollectedWei = finalTotalCollectedWei.sub(testIDODevFeeInWei);
            
            _transferTokens(testIDODevAddress, testIDODevFeeInWei);
        }

        uint256 liqPoolEthAmount = finalTotalCollectedWei.mul(ammLiquidityPercentageAllocation).div(100);
        uint256 liqPoolTokenAmount = liqPoolEthAmount.mul(1e18).div(ammListingPriceInWei);

        token.approve(address(ammRouter), liqPoolTokenAmount);

        if(investmentToken == 0x0000000000000000000000000000000000000000) {
            ammRouter.addLiquidityETH{value : liqPoolEthAmount}(
            address(token),
            liqPoolTokenAmount,
            0,
            0,
            testIDOLiqLockAddress,
            block.timestamp.add(15 minutes)
        );
        } 

        else {
            IERC20(investmentToken).approve(address(ammRouter), liqPoolEthAmount);
            ammRouter.addLiquidity(
                address(token),
                address(investmentToken),
                liqPoolTokenAmount,
                liqPoolEthAmount,
                0,
                0,
                testIDOLiqLockAddress,
                block.timestamp.add(15 minutes)
            );
        }

        uint256 unsoldTokensAmount = token.balanceOf(address(this)).sub(getTokenAmount(totalCollectedWei));
        if (unsoldTokensAmount > 0) {
            token.transfer(unsoldTokensDumpAddress, unsoldTokensAmount);
        }

        presaleCreatorClaimWei = _calcContractBalance().mul(1e18).div(totalInvestorsCount.mul(1e18));
        presaleCreatorClaimTime = block.timestamp + 1 days;
    }

    function claimTokens()
    external
    whitelistedAddressOnly
    presaleIsNotCancelled
    investorOnly
    notYetClaimedOrRefunded
    {
        require(ammLiquidityAdded, "Liquidity not yet added");

        claimed[msg.sender] = true; // make sure this goes first before transfer to prevent reentrancy
        token.transfer(msg.sender, getTokenAmount(investments[msg.sender]));

        uint256 balance = _calcContractBalance();
        if (balance > 0) {
            uint256 funds = presaleCreatorClaimWei > balance ? balance : presaleCreatorClaimWei;
            _transferTokens(presaleCreatorAddress, funds);
        }
    }

    function getRefund()
    external
    whitelistedAddressOnly
    investorOnly
    {
        if (!presaleCancelled) {
            require(block.timestamp >= openTime, "Not yet opened");
            require(block.timestamp >= closeTime, "Not yet closed");
            require(softCapInWei > 0, "No soft cap");
            require(totalCollectedWei < softCapInWei, "Soft cap reached");
        }

        // claimed[msg.sender] = true; // make sure this goes first before transfer to prevent reentrancy
        uint256 investment = investments[msg.sender];
        uint256 presaleBalance =  _calcContractBalance();
        require(presaleBalance > 0, "Not enough balance");

        if (investment > presaleBalance) {
            investment = presaleBalance;
        }

        if (investment > 0) {
            _transferTokens(msg.sender, investment);
        }
    }

    function cancelAndTransferTokensToPresaleCreator() external {
        if (!ammLiquidityAdded && presaleCreatorAddress != msg.sender && testIDODevAddress != msg.sender) {
            revert();
        }
        if (ammLiquidityAdded && testIDODevAddress != msg.sender) {
            revert();
        }

        require(!presaleCancelled, "Presale is cancelled");
        presaleCancelled = true;

        uint256 balance = token.balanceOf(address(this));
        if (balance > 0) {
            token.transfer(presaleCreatorAddress, balance);
        }
    }

    function collectFundsRaised() onlyPresaleCreator external {
        require(ammLiquidityAdded, "Liquidity not yet added");
        require(!presaleCancelled, "Presale cancelled");
        require(block.timestamp >= presaleCreatorClaimTime, "Presale creator claim time not reached");

        if (_calcContractBalance() > 0) {
            _transferTokens(presaleCreatorAddress, _calcContractBalance());
        }
    }

    function _calcContractBalance() internal view returns(uint256){
        return (investmentToken == 0x0000000000000000000000000000000000000000) ? address(this).balance : IERC20(investmentToken).balanceOf(address(this));  
    }

    function _transferTokens(address _receipent, uint256 _amount) internal {
        if(investmentToken == 0x0000000000000000000000000000000000000000) 
            payable(_receipent).transfer(_amount);
        else
            IERC20(investmentToken).transfer(_receipent, _amount);  
    }

    function withdrawLeftoverERC(address _token) onlyPresaleCreator external {
        require(IERC20(_token).balanceOf(address(this)) > 0, "No balance left");
        IERC20(_token).transfer(presaleCreatorAddress, IERC20(_token).balanceOf(address(this)));
    }
}

// File: TestIDOFactory.sol

pragma solidity 0.6.12;
// pragma experimental ABIEncoderV2;

// import "./ILiquidityValueCalculator.sol";

interface IUniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}

contract TestIDOFactory {
    using SafeMath for uint256;

    event PresaleCreated(bytes32 title, uint256 testIDOId, address creator);

    IUniswapV2Factory private constant ammFactory =
        IUniswapV2Factory(address(0xB7926C0430Afb07AA7DEfDE6DA862aE0Bde767bc));
    address private constant wethAddress = address(0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd);
    address public constant moderator = address(0xE8C852FB61a6350caa4a5301ECaEa4F5DF2eAdE9);

    TestIDOInfo public immutable TESTIDO;
    IERC20 public platformToken; // Platform token
    // ILiquidityValueCalculator public lvCalculator;
    uint256 public poolFees = 0.5 ether;

    constructor(address _testIDOInfoAddress, address _platformToken) public {
        TESTIDO = TestIDOInfo(_testIDOInfoAddress);
        platformToken = IERC20(_platformToken);
    }

    modifier onlyOwner(){
        require(TESTIDO.owner() == msg.sender, "Not TESTIDO owner");
        _;
    }

    function setPoolFees(uint256 _poolFees) public onlyOwner {
        poolFees = _poolFees;
    }

    // function setLVCalculator(address _lvCalculator) public onlyOwner returns (bool) {
    //     lvCalculator = ILiquidityValueCalculator(_lvCalculator);
    //     return true;
    // }

    struct PresaleInfo {
        address tokenAddress;
        address unsoldTokensDumpAddress;
        address[] whitelistedAddresses;
        uint256 tokenPriceInWei;
        uint256 hardCapInWei;
        uint256 softCapInWei;
        uint256 maxInvestInWei;
        uint256 minInvestInWei;
        uint256 openTime;
        uint256 closeTime;
        address investmentToken;
    }

    struct PresaleAMMInfo {
        uint256 listingPriceInWei;
        uint256 liquidityAddingTime;
        uint256 lpTokensLockDurationInDays;
        uint256 liquidityPercentageAllocation;
    }

    struct PresaleStringInfo {
        bytes32 saleTitle;
        bytes32 linkTelegram;
        bytes32 linkDiscord;
        bytes32 linkTwitter;
        bytes32 linkWebsite;
    }

    // copied from https://github.com/Uniswap/uniswap-v2-periphery/blob/master/contracts/libraries/UniswapV2Library.sol
    // calculates the CREATE2 address for a pair without making any external calls
    function uniV2LibPairFor(
        address factory,
        address tokenA,
        address tokenB
    ) internal pure returns (address pair) {
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        pair = address(
            uint256(
                keccak256(
                    abi.encodePacked(
                        hex"ff",
                        factory,
                        keccak256(abi.encodePacked(token0, token1)),
                        hex"d0d4c4cd0848c93cb4fd1f498d7013ee6bfb25783ea21593d5834f5d250ece66" // init code hash
                    )
                )
            )
        );
    }

    function initializePresale(
        TestIDOPresale _presale,
        uint256 _totalTokens,
        uint256 _finalTokenPriceInWei,
        PresaleInfo calldata _info,
        PresaleAMMInfo calldata _ammInfo,
        PresaleStringInfo calldata _stringInfo
    ) internal {
        _presale.setAddressInfo(msg.sender, _info.tokenAddress, _info.unsoldTokensDumpAddress);
        _presale.setGeneralInfo(
            _totalTokens,
            _finalTokenPriceInWei,
            _info.hardCapInWei,
            _info.softCapInWei,
            _info.maxInvestInWei,
            _info.minInvestInWei,
            _info.openTime,
            _info.closeTime,
            _info.investmentToken
        );
        _presale.setAMMInfo(
            _ammInfo.listingPriceInWei,
            _ammInfo.liquidityAddingTime,
            _ammInfo.lpTokensLockDurationInDays,
            _ammInfo.liquidityPercentageAllocation
        );
        _presale.setStringInfo(
            _stringInfo.saleTitle,
            _stringInfo.linkTelegram,
            _stringInfo.linkDiscord,
            _stringInfo.linkTwitter,
            _stringInfo.linkWebsite
        );
        _presale.addwhitelistedAddresses(_info.whitelistedAddresses);
    }

    function createPresale(
        PresaleInfo calldata _info,
        PresaleAMMInfo calldata _ammInfo,
        PresaleStringInfo calldata _stringInfo
    ) external payable {

        require(msg.value == poolFees, "Pool Creation Fees not correct");

        IERC20 token = IERC20(_info.tokenAddress);

        TestIDOPresale presale = new TestIDOPresale(address(this), TESTIDO.owner());

        address existingPairAddress = ammFactory.getPair(address(token), wethAddress);
        require(existingPairAddress == address(0)); // token should not be listed in Uniswap

        uint256 maxEthPoolTokenAmount = _info.hardCapInWei.mul(_ammInfo.liquidityPercentageAllocation).div(100);
        uint256 maxLiqPoolTokenAmount = maxEthPoolTokenAmount.mul(1e18).div(_ammInfo.listingPriceInWei);

        uint256 maxTokensToBeSold = _info.hardCapInWei.mul(1e18).div(_info.tokenPriceInWei);
        uint256 requiredTokenAmount = maxLiqPoolTokenAmount.add(maxTokensToBeSold);
        token.transferFrom(msg.sender, address(presale), requiredTokenAmount);

        initializePresale(presale, maxTokensToBeSold, _info.tokenPriceInWei, _info, _ammInfo, _stringInfo);

        address pairAddress = uniV2LibPairFor(address(ammFactory), address(token), wethAddress);
        TestIDOLiquidityLock liquidityLock = new TestIDOLiquidityLock(
                IERC20(pairAddress),
                msg.sender,
                _ammInfo.liquidityAddingTime + (_ammInfo.lpTokensLockDurationInDays * 1 days)
            );

        uint256 testIDOId = TESTIDO.addPresaleAddress(address(presale));
        presale.setTestIDOInfo(address(liquidityLock), TESTIDO.getDevFeePercentage(), TESTIDO.getMinDevFeeInWei(), testIDOId);
        payable(moderator).transfer(poolFees);
    
        presale.setPlatformTokenAddress(address(platformToken));
        // presale.setLiquidityValueCalculator(address(lvCalculator));

        emit PresaleCreated(_stringInfo.saleTitle, testIDOId, msg.sender);
    }
}
