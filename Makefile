PROJDIR = $(realpath $(CURDIR))
SRCS = $(PROJDIR)/srcs
all: 
	mkdir -p /home/uaupetit/data/mariadb
	mkdir -p /home/uaupetit/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	sudo docker container stop nginx mariadb wordpress
	sudo docker network rm inception
	#sudo docker rm mariadb
	#sudo docker rm nginx
	#sudo docker rm wordpress

fclean: clean
	@cd $(SRCS) && sudo docker-compose down -v
	@sudo rm -rf /home/uaupetit/data/mariadb
	@sudo rm -rf /home/uaupetit/data/wordpress
	@docker system prune -af

re: fclean all

.PHONY: all logs clean fclean