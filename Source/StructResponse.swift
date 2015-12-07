import PyxisServer

struct StructResponse {

    func index(connection: Connection) -> Connection {
        var cn = connection
        var body = "<http><body><div>"
        body +=  "response from Struct Response</br>"
        body += "\(cn.urlParams)"
        body += "</div></body></http>"
        cn.response.body = body
        return cn
    }

}
