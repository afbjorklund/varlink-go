all: cmd/varlink-go-certification/orgvarlinkcertification/orgvarlinkcertification.go
	go test ./...

cmd/varlink-go-certification/orgvarlinkcertification/orgvarlinkcertification.go: cmd/varlink-go-certification/orgvarlinkcertification/org.varlink.certification.varlink
	go generate cmd/varlink-go-certification/orgvarlinkcertification/generate.go

.PHONY: all

cross: varlink-go.linux-amd64 varlink-go.darwin-amd64 varlink-go.windows-amd64

clean:
	$(RM) varlink-go.linux-amd64 varlink-go.darwin-amd64 varlink-go.windows-amd64.exe

varlink-go.linux-amd64: cmd/varlink/main.go
	GOOS=linux GOARCH=amd64 go build -o $@ -ldflags "$(GO_LDFLAGS)" $(GO_GCFLAGS) ./cmd/varlink

varlink-go.darwin-amd64: cmd/varlink/main.go
	GOOS=darwin GOARCH=amd64 go build -o $@ -ldflags "$(GO_LDFLAGS)" $(GO_GCFLAGS) ./cmd/varlink

varlink-go.windows-amd64: varlink-go.windows-amd64.exe
varlink-go.windows-amd64.exe: cmd/varlink/main.go
	GOOS=windows GOARCH=amd64 go build -o $@ -ldflags "$(GO_LDFLAGS)" $(GO_GCFLAGS) ./cmd/varlink

.PHONY: clean
