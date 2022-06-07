docker run -it --rm
    --name paradox-server
    -e DOMAIN=explorer.example.com
    -e USERNAME=user_name
    -e PASSWORD=password
    -v /path/to/client:/usr/src/paradox-server/client
    -v /path/to/cache:/cache/lu-res
    -p 3030:3030
    paradox-server