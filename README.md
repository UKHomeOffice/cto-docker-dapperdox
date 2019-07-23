
docker build -t cto-dapperdox .

docker run --rm --name cto-dapperdox -p 3123:3123 cto-dapperdox

docker run --rm --name cto-dapperdox -p 3123:3123 --env SPEC_FILENAME="cop/swagger.json,uber/swagger.json" cto-dapperdox