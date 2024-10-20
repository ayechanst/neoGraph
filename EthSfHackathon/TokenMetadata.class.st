Class {
	#name : #TokenMetadata,
	#superclass : #QuerySubgraph,
	#instVars : [
		'subgraphOutput',
		'id',
		'traits',
		'image',
		'token'
	],
	#category : #EthSfHackathon
}

{ #category : #'as yet unclassified' }
TokenMetadata class >> formatLink: anId [
	| trimmed start |
	start := 'https://ipfs.io/ipfs/'.
	trimmed := anId copyFrom: 8 to: anId size.
	^ start , trimmed
]

{ #category : #'as yet unclassified' }
TokenMetadata class >> fromQuery: aDict [
	| metadata _id tokenMetadata |
	metadata := aDict at: 'TokenMetadata'.
	_id := metadata at: 'id'.
	tokenMetadata := self new
			id: _id;
			traits: ((self getIPFSData: _id) at: 2);
			image: ((self getIPFSData: _id) at: 1);
			token: (metadata at: 'token').
	^ tokenMetadata asJSON
]

{ #category : #'as yet unclassified' }
TokenMetadata class >> getIPFSData: anId [
	| data json traitsJson |
	data := self queryIPFS: anId.
	json := NeoJSONReader fromString: data.
	traitsJson := (json at: 'attributes')
			collect: [ :each | 
				Dictionary
					newFrom: {'id' -> (anId , (each at: 'trait_type')).
							'trait_type' -> (each at: 'trait_type').
							'value' -> (each at: 'value')} ].

	^ {json at: 'image'.
		traitsJson}
]

{ #category : #'as yet unclassified' }
TokenMetadata class >> queryIPFS: anId [
	"does the query"

	| result |
	result := ZnClient new
			url: (self formatLink: anId);
			get.
	^ result
]

{ #category : #'as yet unclassified' }
TokenMetadata >> asJSON [
	^ Dictionary
		newFrom: {'TokenMetadata'
					-> (Dictionary
							newFrom: {'id' -> self id.
									'traits' -> self traits.
									'image' -> self image.
									'token' -> self token})}
]

{ #category : #getter }
TokenMetadata >> id [ 
	^ id
]

{ #category : #setter }
TokenMetadata >> id: anId [
	id := anId
]

{ #category : #getter }
TokenMetadata >> image [
	^ image
]

{ #category : #setter }
TokenMetadata >> image: anImage [
	image := anImage
]

{ #category : #'as yet unclassified' }
TokenMetadata >> neoJsonOn: neoJSONWriter [
	neoJSONWriter
		writeMap: (Dictionary
				newFrom: {'TokenMetadata'
							-> (Dictionary
									newFrom: {'id' -> self id.
											'traits' -> self traits.
											'image' -> self image.
											'token' -> self token})})
]

{ #category : #'as yet unclassified' }
TokenMetadata >> subgraphOutput [
	^ subgraphOutput
]

{ #category : #'as yet unclassified' }
TokenMetadata >> token [
	 ^ token
]

{ #category : #'as yet unclassified' }
TokenMetadata >> token: aToken [
	token := aToken
]

{ #category : #getter }
TokenMetadata >> traits [
	^ traits
]

{ #category : #setter }
TokenMetadata >> traits: traitCollection [
	traits := traitCollection
]
