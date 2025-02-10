default: run
.PHONY:  run
run:
	@docker compose up -d
	@docker compose exec packer bash
	@docker compose down

.PHONY: build
build:
	@docker compose build
