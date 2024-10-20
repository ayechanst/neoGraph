Class {
	#name : #Node,
	#superclass : #Object,
	#instVars : [
		'node'
	],
	#category : #EthSfHackathon
}

{ #category : #'as yet unclassified' }
Node >> gtNodeFor: aView [
	<gtView>
	^ aView columnedList
		priority: 20;
		title: 'Info';
		items: [ self keys ];
		column: 'Keys' text: [:each | each ] width: 140;
		column: 'Value' text: [:each | self node at: each]
]

{ #category : #'as yet unclassified' }
Node >> id [
	^ self node at: 'id'
]

{ #category : #'as yet unclassified' }
Node >> keys [
	^ self node keys
]

{ #category : #'as yet unclassified' }
Node >> node [
	^ node
]

{ #category : #'as yet unclassified' }
Node >> node: aNode [
	node := aNode
]

{ #category : #'as yet unclassified' }
Node >> typeName [
	^ self node at: '__typename'
]

{ #category : #'as yet unclassified' }
Node >> values [ 
	^ self node values
]
