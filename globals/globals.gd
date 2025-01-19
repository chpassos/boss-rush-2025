extends Node


const COLLECTIBLE_ASTEROID_SCENE: PackedScene = preload("res://scenes/asteroid/collectible/collectible_asteroid.tscn")
const ORBITING_ASTEROID_SCENE: PackedScene = preload("res://scenes/asteroid/orbiting/orbiting_asteroid.tscn")
const PROJECTILE_ASTEROID_SCENE: PackedScene = preload("res://scenes/asteroid/projectile/projectile_asteroid.tscn")

const CLOCKWISE_ASTEROID_DATA: AsteroidData = preload("res://scenes/asteroid/clockwise.tres")
const COUNTERCLOCKWISE_ASTEROID_DATA: AsteroidData = preload("res://scenes/asteroid/counterclockwise.tres")

var player: Player
