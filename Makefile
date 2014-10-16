
all: banchanggo

banchanggo:
	go build -o banchanggo src/main.go

install:
	mv banchanggo ~/sbin/

clean:
	rm -f banchanggo

