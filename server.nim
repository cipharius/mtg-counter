import ospaths, parseopt
import jester

from strutils import parseInt

var port = Port(5000)

for kind, key, value in getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "port", "p":
      port = Port(value.parseInt)
  else: discard

settings:
  port = port

routes:
  get "/":
    let public = request.getStaticDir()
    resp readFile(public / "index.html")

  get "/index.html":
    redirect uri("/")
