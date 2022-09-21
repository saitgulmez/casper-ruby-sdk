
---
## Get peers
```ruby 
def info_get_peers: [Array<Peer>]
```
Returns a list of Peer objects entity connected to the node

---
## Get State_Root_Hash
```ruby
def chain_get_StateRootHash(block_hash): String
```
Returns state root hash `String` by the given block hash or the one for the latest added block 
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `block_hash` | `String` | Hex-encoded hash of the block | Yes |


---
## Get Deploy
```ruby
def info_get_deploy(deploy_hash): [Deploy]
```
Returns a Deploy entity 
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `deploy_hash` | `String` | Hex-encoded hash of a deploy | Yes |

---
## Get Status
```ruby
def info_get_status(): [Status]
```
Returns the current Status of the node

---
## Get Block transfers
```ruby
def chain_get_block_transfers(block_hash): [Array<Transfer>] 
```
Returns an Array of Transfer objects for the block 
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `block_hash` | `String` | Hex-encoded hash of the block | No |

---
## Get Block by hash
```ruby
def chain_get_block(block_hash) : [Block]
```
Returns a Block object 
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `block_hash` | `String` | Hex-encoded hash of a block | Yes |

---
## Get Era Summary by Switch Block Hash
```ruby
def chain_get_eraInfo_by_SwitchBlock(block_hash): [EraSummary] 
```
Returns an EraSummary object for the given block hash
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `block_hash` | `String` | Hex-encoded hash of the block | Yes |

---
## Get  State Item
```ruby
def state_get_item(state_root_hash, key, path): [StoredValue]
```
Returns StoredValue object entity for the given state root hash, casper-type key and path
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `state_root_hash` | `String` | Hex-encoded hash of the state root | Yes |
| `key` | `String` |  Casper-type key  | Yes |
| `path` | `[Array<String>]` | Path components  | No |

---
## Get Dictionary Item
```ruby
def state_get_dictionary_item(state_root_hash, item_key, uref): [StoredValue]  
```
Returns an item from a Dictionary as StoredValue object.
### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `state_root_hash` | `String` | Hex-encoded hash of the state root | Yes |
| `item_key` | `String` | The dictionary item key  | Yes |
| `uref` | `String` | The dictionary's seed URef | Yes |

---
## Get Account balance
```ruby
def state_get_balance(state_root_hash, balance_uref): [Hash<String, Integer, String>] 
```
Returns Account balance 
### Parameters
| Name | Type | Description |  |
|---|---|---|---|
| `state_root_hash` | `String` | Hex-encoded hash of the state root | Yes |
| `balance_uref` | `URef` | Account URef object | Yes |

---
## Get Auction State
```ruby
def state_get_AuctionInfo(block_hash): [AuctionState]
```
Returns AuctionState containing the bids and validators at a given block (block hash).
if called without a parameter, it returns the  AuctionState of the most recently added block

### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `block_hash` | `String` | Hex-encoded hash of the block | no |

---
## Put Deploy 
```ruby
def put_deploy(deploy): [Hash]
```
Sends a Deploy object to the casper network.
Returns a Hash object representing the deploy hash.

### Parameters
| Name | Type | Description | Required |
|---|---|---|---|
| `deploy` | `Deploy` | Deploy object  | Yes |