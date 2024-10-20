Class {
	#name : #BaselineOfEthSfHackathon,
	#superclass : #BaselineOf,
	#category : #BaselineOfEthSfHackathon
}

{ #category : #baseline }
BaselineOfEthSfHackathon >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'EthSfHackathon'
		]
]
