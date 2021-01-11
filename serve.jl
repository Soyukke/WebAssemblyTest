using HTTP
const ROUTER = HTTP.Router()

function not_found(body::AbstractString = "404 not found")
    headers = ["Content-Type" => "text/html"]
    return HTTP.Response(404, headers, body = body)
end

for (func, pairdict) in (
    (:get_html, Dict("html"=>"text/html")),
    (:get_css, Dict("css"=>"text/css")),
    (:get_js, Dict("js"=>"text/javascript")),
    (:get_img, Dict("png"=>"image/png", "jpeg"=>"image/jpeg", "jpg"=>"image/jpeg", "gif"=>"image/gif")),
    (:get_wasm, Dict("wasm"=>"application/wasm"))
    )

    @eval begin
        function $func(req::HTTP.Request)::HTTP.Response
            # ここで変数として展開しておかないといけない
            dict = $pairdict
            uri = HTTP.URI(req.target)
            params = HTTP.queryparams(uri)
            path_to_file = splitpath(String(uri.path))[2:end]
            ext = split(path_to_file[end], ".")[end]
            (ext ∉ (keys(dict))) && return not_found()
            fn = joinpath(@__DIR__, path_to_file...)
            println(fn)
            !isfile(fn) && return not_found()
            try
                body = HTTP.bytes(read(fn))
                headers = [
                    "Content-Type" => dict[ext],
                    "Content-Length" => length(body)
                ]
                return HTTP.Response(200, headers, body = body)
            catch e
                println(e)
                isa(e, Exception) && return not_found(e.message)
                return not_found()
            end
        end
    end
end

function getfile(req::HTTP.Request)::HTTP.Response
    uri = HTTP.URI(req.target)
    path_to_file = splitpath(String(uri.path))[2:end]
    ext = split(path_to_file[end], ".")[end]
    if ext == "html"
        return get_html(req)
    elseif ext == "js"
        return get_js(req)
    elseif ext == "wasm"
        return get_wasm(req)
    end
end

function serve()
    port = 8080
    HTTP.@register(ROUTER, "GET", "/*", getfile)
    HTTP.@register(ROUTER, "GET", "/*", getfile)
    println("listen $port access localhost:$(port)")
    HTTP.serve(ROUTER, "0.0.0.0", port)
end

serve()