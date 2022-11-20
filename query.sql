-- name: GetTwytts :many
SELECT * FROM twytts;

-- name: InsertTwytt :one
INSERT INTO twytts (
	name,
	twytt
)
VALUES (
	$1,
	$2
)
RETURNING *;
