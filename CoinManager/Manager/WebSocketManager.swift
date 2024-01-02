//
//  WebSocketManager.swift
//  CoinManager
//
//  Created by 한성봉 on 1/2/24.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    static let shared = WebSocketManager()
    private let upbitSocketURL = URLs.upbitSocketURL
    
    private override init() {
        super.init()
    }
    
    private var timer: Timer?
    private var webSocket: URLSessionWebSocketTask?
    private var isOpen = false
    var orderBookSbj = PassthroughSubject<OrderBookWS, Never>()
    
    func openWebSocket() {
        if let url = URL(string: self.upbitSocketURL) {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
            
            ping()
        }
    }
    
    func closeWebSocket() {
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        timer?.invalidate()
        timer = nil
        
        isOpen = false
    }
    
    func send(_ codes: String) {
        let requestStr = """
        [{"ticket":"test"},{"type":"orderbook","codes":["\(codes)"]}]
        """
        
        webSocket?.send(.string(requestStr), completionHandler: { error  in
            if let error { print("send Error : \(error.localizedDescription)") }
        })
    }
    
    func receive() {
        if isOpen {
            webSocket?.receive(completionHandler: { [weak self] result  in
                switch result {
                case .success(let success):
                    print("receive Success : \(success)")
                    
                    switch success {
                    case .data(let data):
                        print("success - data : \(data)")
                        
                        do {
                            let decodedData = try JSONDecoder().decode(OrderBookWS.self, from: data)
                            self?.orderBookSbj.send(decodedData)
                        } catch {
                            print("decodingError : \(error.localizedDescription)")
                        }
                        
                    case .string(let string):
                        print("success - string : \(string)")
                        
                    @unknown default:
                        fatalError()
                    }
                    
                case .failure(let failure):
                    print("receive Fail : \(failure.localizedDescription)")
                    self?.closeWebSocket()
                }
                
                self?.receive()
            })
            
        }
    }
    
    
    private func ping() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error  in
                if let error {
                    print("Ping Error : \(error.localizedDescription)")
                } else {
                    print("Ping Success")
                }
            })
        })
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print(#function)
        print("WebSocket OPEN")
        
        isOpen = true
        
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print(#function)
        print("WebSocket CLOSE")
        
        isOpen = false
    }

}
