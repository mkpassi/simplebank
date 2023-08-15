postgres:
	docker run --name postgres-local -e POSTGRES_USER=root -e POSTGRES_PASSWORD=amsoft -p 5432:5432  -v /Users/mitesh/projects/code/data/postgres -d postgres:15-alpine

createdb:
	docker exec -it postgres-local createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-local dropdb simple_bank

migrateup:
	 migrate -path db/migration -database "postgresql://root:amsoft@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	 migrate -path db/migration -database "postgresql://root:amsoft@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
.PHONY: postgres createdb dropdb migrateup migratedown sqlc

#To create migration, install go module https://github.com/golang-migrate/migrate
#migrate create -ext sql -dir db/migration -seq init_schema