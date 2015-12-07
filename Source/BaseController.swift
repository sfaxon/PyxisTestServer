import PyxisServer

class BaseController {

    private var pipeline = ConnectionPipeline?()

    init(pipeline: ConnectionPipeline? = nil) {
        if let pl = pipeline {
            self.pipeline = pl
        }
    }

    func index(connection: Connection) -> Connection {
        var cn = connection
        if let pl = self.pipeline {
            cn = pl.respond(connection)
        }
        var body = "<http><body><div>"
        body +=  "Respons Body from Base Controller \(cn.request.headers["Foo"])</br>"
        body += "\(cn.urlParams)"
        body += "</div></body></http>"
        cn.response.body = body
        return cn
    }
}
