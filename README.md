docker run -it --rm -v /path/to/client:/luclient -v /path/to/client:/usr/src/paradox-server/client -p 3030:3030 --name paradox-server aronwk-aaron/paradox-server:latest