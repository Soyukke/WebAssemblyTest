import http.server
import socketserver

Handler = http.server.SimpleHTTPRequestHandler
Handler.extensions_map['.wasm'] = 'application/wasm'
with socketserver.TCPServer(("", 8080), Handler) as httpd:
    print("serve 8080")
    print("localhost:8080/index.html")
    httpd.serve_forever()