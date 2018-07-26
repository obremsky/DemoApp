
import Foundation
import PromiseKit


class ClientAPIService: Service {
  static let defaultSession = URLSession(configuration: .default)
  static let validResponseCodes = 200..<300
  var  task : URLSessionTask?
  
  func sendGETRequest(at path: String,
                      withQuery query: [String: Any]? = nil,
                      withHeaders headers: [String : String]?,
                      withURLType urlType: URLType = .local) -> Promise<Data> {
    
    var request = URLRequest(url: URL(string : path)!)
    request.httpMethod = "GET"
    return self.urlTaskWith(request: request as URLRequest)
  }
  
  func urlTaskWith(request : URLRequest) -> Promise<Data> {
    
    return Promise<Data> {seal in
      let task = NetworkManager.shared.session.dataTask(with: request) {(data, response , error) in
        
        defer{
          self.task = nil
        }
        
        if let error = error {
          print(error)
        }
        seal.resolve(data, error)
      }
      self.task = task
      task.resume()
    }
  }
  
  
  func downloadFile(url : String, fileUrl : String) -> Promise<String>{
    var request = URLRequest(url: URL(string : url)!)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.setValue("text/plain; charset=utf-8", forHTTPHeaderField: "Accept")
    request.httpMethod = "GET"
    
    return Promise<String> {seal in
      firstly{
        return NetworkManager.shared.session.downloadTask(.promise, with: request, to: URL(string : fileUrl)!)
        }.done { (url, _) in
          print("Did download file to \(url)")
          seal.fulfill(url.absoluteString)
        }.catch { (error) in
          print("Cant download file: \(error)")
          seal.reject(error)
      }
    }
  }
}
