Class {
	#name : #SubgraphMondrianToolkit,
	#superclass : #QuerySubgraph,
	#category : #EthSfHackathon
}

{ #category : #'as yet unclassified' }
SubgraphMondrianToolkit >> arrow: anEdge [
	anEdge
		ifNil: [ ^ nil ]
		ifNotNil: [ ^ BlLineElement new
				zIndex: -1;
				border: (BlBorder paint: Color gray width: 1);
				fromHead: (BlArrowheadTriangle new
						scale: 5;
						border: (BlBorder paint: Color orange width: 3)) ]
]

{ #category : #'as yet unclassified' }
SubgraphMondrianToolkit >> mondrianNode: aNode [
	^ BlElement new
		background: ((aNode typeName = 'Pool') ifTrue: [Color veryLightGray] 
		ifFalse: [Color orange]);
		geometry: BlCircleGeometry new;
		size: 80 @ 80; "(self nodeSize: aNode);"
		clipChildren: false;
		addChild: (self nodeLabel: aNode)
]

{ #category : #'as yet unclassified' }
SubgraphMondrianToolkit >> nodeLabel: aNode [
	^ BlTextElement new
			text: aNode typeName asRopedText.
]

{ #category : #'as yet unclassified' }
SubgraphMondrianToolkit >> nodeSize: aNode [
	(aNode keys contains: 'txCount')
		ifTrue: [ | txCount size |
			txCount := aNode at: 'txCount'.
			size := txCount asNumber / 347000.
			^ size @ size ]
		ifFalse: [ ^ 100 @ 100 ]
]
