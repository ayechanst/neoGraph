Class {
	#name : #SubgraphResults,
	#superclass : #QuerySubgraph,
	#instVars : [
		'subgraphOutput',
		'associations'
	],
	#category : #EthSfHackathon
}

{ #category : #'as yet unclassified' }
SubgraphResults >> gtNounsMondrianFor: aView [
	<gtView>
	| view edges toolkit nodes assocs fn |
	view := GtMondrian new.
	toolkit := SubgraphMondrianToolkit new.
	nodes := Set new.
	assocs := Set new.
	fn := [ :each :parent | 
		| node |
		(each isKindOf: Dictionary)
			ifTrue: [ node := Node new node: each.
				nodes add: node.
				parent ifNotNil: [ assocs add: parent -> node ].
				each do: [ :e | fn value: e value value: node ] ].

		(each isKindOf: Array) ifTrue: [ each do: [ :a | fn value: a value: parent ] ] ].
	fn value: (self subgraphOutput first at: 'transferEvents') value: nil.

	view nodes
		stencil: [ :node | toolkit mondrianNode: node ];
		with: nodes.


	edges := view edges
			stencil: [ :c | toolkit arrow: c ];
			connectAssociations: assocs.

	view layout force charge: -3000.

	^ aView mondrian
		title: 'Nouns Mondrian';
		priority: 90;
		initialize: view
]

{ #category : #'as yet unclassified' }
SubgraphResults >> gtSubgraphMondrianFor: aView [
	<gtView>
	| view edges toolkit nodes assocs fn |
	view := GtMondrian new.
	toolkit := SubgraphMondrianToolkit new.
	nodes := Set new.
	assocs := Set new.
	fn := [ :each :parent | 
		| node |
		(each isKindOf: Dictionary)
			ifTrue: [ node := Node new node: each.
				nodes add: node.
				parent ifNotNil: [ assocs add: parent -> node ].
				each do: [ :e | fn value: e value value: node ] ].

		(each isKindOf: Array) ifTrue: [ each do: [ :a | fn value: a value: parent ] ] ].
	fn value: (self subgraphOutput first at: 'pools') value: nil.

	view nodes
		stencil: [ :node | toolkit mondrianNode: node ];
		with: nodes.


	edges := view edges
			stencil: [ :c | toolkit arrow: c ];
			connectAssociations: assocs.

	view layout force charge: -3000.

	^ aView mondrian
		title: 'Uniswap Mondrian';
		priority: 90;
		initialize: view
]

{ #category : #'as yet unclassified' }
SubgraphResults >> gtSubgraphViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Subgraph Output';
		priority: 100;
		items: [ self nodes];
		column: 'Items' text: [:each | each ];
		column: 'Type' text: [ :each | each typeName ]
]

{ #category : #'as yet unclassified' }
SubgraphResults >> nodes [
	"Returns collection of Node objects"

	^ self preNodes collect: [ :each | Node new node: each ]
]

{ #category : #'as yet unclassified' }
SubgraphResults >> preNodes [
	"Returns data that will populate nodes"

	| preNodes |
	preNodes := OrderedCollection new.
	self subgraphOutput
		do: [ :eachDict | 
			eachDict keysDo: [ :key | 
				preNodes add: ((eachDict at: key) at: 1) ] ].
	^ preNodes
]

{ #category : #getter }
SubgraphResults >> subgraphOutput [
	^ subgraphOutput
]

{ #category : #setter }
SubgraphResults >> subgraphOutput: aSubgraphOutput [
	subgraphOutput := aSubgraphOutput
]
