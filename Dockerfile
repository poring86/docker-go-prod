FROM golang:1.20 as build

WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN go build -o hello .
# CMD ["/app/hello"]

FROM scratch
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["/app/hello"]