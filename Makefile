default: run
.PHONY:  run
run:
	@docker compose up -d
	@docker compose exec packerweb bash
	@docker compose down

.PHONY: build
build:
	@docker compose build
