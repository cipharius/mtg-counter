import ospaths
import jester

routes:
  get "/":
    let public = request.getStaticDir()
    resp readFile(public / "index.html")

  get "/index.html":
    redirect uri("/")
