version=$(shell git rev-parse --short HEAD)

idl:
	rm -rf pb/*.pb.go
	protoc -I=. pb/*.proto --go_out=plugins=grpc:.

bin:
	rm -rf exec_bin
	mkdir exec_bin
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w -X main.version=$(version)" -o ./exec_bin/server-darwin ./server/*.go
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w -X main.version=$(version)" -o ./exec_bin/client-darwin ./client/*.go
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -w -X main.version=$(version)" -o ./exec_bin/server-linux ./server/*.go
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -w -X main.version=$(version)" -o ./exec_bin/client-linux ./client/*.go


