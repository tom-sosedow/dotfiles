function killdocker
    docker kill (docker ps -q)
end