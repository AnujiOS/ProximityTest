//
//  AirQualityIndexDataProvider.swift
//  ProximityTest
//
//  Created by Anuj Joshi on 19/10/2021.
//

import Foundation
import Starscream

protocol AirQualityIndexDataProviderDelegate {
    func didReceive(response: Result<[AirQualityResposne], Error>)
}

class AirQualityIndexDataProvider {

    var isConnected: Bool = false

    var delegate: AirQualityIndexDataProviderDelegate?

    var socket: WebSocket? = {
        guard let url = URL(string: Connection.url) else {
            print("Do not able to create URL from: \(Connection.url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        var socket = WebSocket(request: request)
        return socket
    }()

    func subscribe() {
        self.socket?.delegate = self
        self.socket?.connect()
    }

    func unsubscribe() {
        self.socket?.disconnect()
    }

    deinit {
        self.socket?.disconnect()
        self.socket = nil
    }
}


extension AirQualityIndexDataProvider: WebSocketDelegate {

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("@@ Websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("@@ websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                handleText(text: string)
            case .binary(let data):
                print("@@ Received socket data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                handleError(error: error)
            }
    }

    private func handleText(text: String) {
        let jsonData = Data(text.utf8)
        let decoder = JSONDecoder()
        do {
            let resArray = try decoder.decode([AirQualityResposne].self, from: jsonData)
            self.delegate?.didReceive(response: .success(resArray))

        } catch {
            print(error.localizedDescription)
        }
    }

    private func handleError(error: Error?) {
        if let e = error {
            self.delegate?.didReceive(response: .failure(e))
        }
    }
}
