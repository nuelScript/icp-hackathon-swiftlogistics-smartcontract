// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract LogisticsDocumentation {
    struct Document {
        string documentHash; // Hash of the document
        address uploader;    // Address of the uploader
        uint256 timestamp;   // Timestamp of when the document was uploaded
    }

    mapping(uint256 => Document) public documents; // Mapping of document IDs to Document struct
    uint256 public documentCount; // Counter for the number of documents

    event DocumentAdded(uint256 indexed docId, string documentHash, address indexed uploader, uint256 timestamp);

    // Function to add a document to the blockchain
    function addDocument(string memory _documentHash) public {
        require(bytes(_documentHash).length > 0, "Document hash cannot be empty");
        documentCount++;
        documents[documentCount] = Document(_documentHash, msg.sender, block.timestamp);
        emit DocumentAdded(documentCount, _documentHash, msg.sender, block.timestamp);
    }

    // Function to retrieve a document's details by ID
    function getDocument(uint256 _docId) public view returns (string memory, address, uint256) {
        require(_docId > 0 && _docId <= documentCount, "Invalid document ID");
        Document memory doc = documents[_docId];
        return (doc.documentHash, doc.uploader, doc.timestamp);
    }

    // Function to get the total number of documents stored
    function getTotalDocuments() public view returns (uint256) {
        return documentCount;
    }
}
