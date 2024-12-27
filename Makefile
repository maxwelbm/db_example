up: 
	docker compose up -d

sh:
	docker exec -it mysql5.7 sh -c 'mysql -u user -p; exec sh'

