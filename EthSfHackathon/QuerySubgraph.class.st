Class {
	#name : #QuerySubgraph,
	#superclass : #Object,
	#instVars : [
		'queryStrings'
	],
	#category : #EthSfHackathon
}

{ #category : #'as yet unclassified' }
QuerySubgraph >> builtQueries [
	"uses queryStrings to make formatted json queries"

	| queries |
	queries := OrderedCollection new.
	self queriesForUniswap
		do: [ :each | 
			queries add: (NeoJSONWriter toString: (Dictionary newFrom: {'query' -> each})) ].
	^ queries
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> builtQueries: _queryStrings [
	"uses queryStrings to make formatted json queries"

	| queries |
	queries := OrderedCollection new.
	"self queriesForUniswap"
	_queryStrings
		do: [ :each | 
			queries add: (NeoJSONWriter toString: (Dictionary newFrom: {'query' -> each})) ].
	^ queries
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> newSubgraphOutput [
	"uses formatted json queries to query a subgraph endpoint"
	| results jsonResult |
	results := OrderedCollection new.
	self builtQueries
		do: [ :each | 
			jsonResult := ZnClient new
					url: self urlAzuki;
					entity: (ZnEntity json: each);
					post.
			results add: (NeoJSONReader fromString: jsonResult) ].
	^ results flatten
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> queriesForUniswap [
	^ {'{
  pools(first: 10) {
    __typename
    mints {
      __typename
      id
      token0 {
        __typename
        id
        tokenDayData(first: 5) {
          __typename
          id
        }
      }
      token1 {
        __typename
        id
        tokenDayData(first: 5) {
          __typename
          id
        }
      }
    }
  }
}'}
]

{ #category : #getter }
QuerySubgraph >> queryStrings [
	^ queryStrings
]

{ #category : #setter }
QuerySubgraph >> queryStrings: aCollectionOfQueries [
	queryStrings := aCollectionOfQueries
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> subgraphOutput [
	"uses formatted json queries to query a subgraph endpoint"
	| results jsonResult |
	results := OrderedCollection new.
	(self builtQueries: self queriesForUniswap)
		do: [ :each | 
			jsonResult := ZnClient new
					url: self urlUniswap;
					entity: (ZnEntity json: each);
					post.
			results add: (NeoJSONReader fromString: jsonResult) ].
	^ results flatten
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> tokenMetadata [
	| tokenMetadata |
	tokenMetadata := self subgraphOutput
			do: [ :each | 
				each
					keysDo: [ :key | 
						key = 'TokenMetadata'
							ifTrue: [ tokenMetadata := TokenMetadata fromQuery: (each at: key).
								each at: key put: tokenMetadata ] ] ]
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> urlAzuki [
	 ^ 'https://gateway.thegraph.com/api/b5f1fdec075645683caa5936e7c00c37/subgraphs/id/68vsUkuPeGbYu8rSGTcDmpRyLBK72nhpdxQbhYFQJKYp'
]

{ #category : #'as yet unclassified' }
QuerySubgraph >> urlUniswap [ 
	^ 'https://gateway.thegraph.com/api/b5f1fdec075645683caa5936e7c00c37/subgraphs/id/HUZDsRpEVP2AvzDCyzDHtdc64dyDxx8FQjzsmqSg4H3B'
]
