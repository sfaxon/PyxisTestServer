import Foundation
import PyxisServer

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

let environment = NSProcessInfo.processInfo().environment
var port = environment["PORT"]
if port == nil || port == "" {
    port = "4000"
}
let portInt = UInt16(port!)


let httpPipeline = ConnectionPipeline()
httpPipeline.addPipeline(ResponseHeaderPipeline.self)
httpPipeline.addPipeline(URLParamParser.self)


let routes = Router()

routes.add(.Get, path: "/par/value") { (connection) -> Connection in
    //return Connection(request: connection.request)
    return httpPipeline.respond(BaseController().index(connection))
}

routes.add(.Get, path: "/value") { (connection) -> Connection in
  let bc = BaseController(pipeline: httpPipeline)
  return bc.index(connection)
}

routes.add(.Get, path: "/struct") { (connection) -> Connection in
  return StructResponse().index(connection)
}

routes.add(.Get, path: "/base") { (connection) -> Connection in
    return BaseController().index(connection)
}

var http = HttpServer(port: portInt!, router: routes)
http.start()
