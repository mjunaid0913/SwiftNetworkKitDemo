//
//  NetworkManager.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

final class NetworkManager {

    static let shared = NetworkManager(environment: .development)

    private let environment: APIEnvironment

    private let timeout: TimeInterval = 30

    private let pinnedCertificateName = "api_certificate"

    private var baseURL: String {
        environment.baseURL
    }

    private var defaultHeaders: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout

        if environment.sslPinningEnabled {
            return URLSession(
                configuration: configuration,
                delegate: SSLPinningDelegate(
                    certificateName: pinnedCertificateName
                ),
                delegateQueue: nil
            )
        } else {
            return URLSession(configuration: configuration)
        }
    }()

    init(environment: APIEnvironment) {
        self.environment = environment
        NetworkLogger.isEnabled = environment.enableLogs
    }

    func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {

        let request = try buildRequest(from: endpoint)

        NetworkLogger.log(request: request)

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            NetworkLogger.log(data: data, response: httpResponse)

            try validateStatusCode(httpResponse.statusCode)

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }

        } catch let error as NetworkError {
            throw error

        } catch let urlError as URLError {
            throw mapURLError(urlError)

        } catch {
            throw NetworkError.custom(error.localizedDescription)
        }
    }
}

// MARK: - Private Helpers

private extension NetworkManager {

    func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(
            string: baseURL + endpoint.path
        ) else {
            throw NetworkError.invalidURL
        }

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = timeout

        defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        endpoint.headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(
                AnyEncodable(body)
            )
        }

        return request
    }

    func validateStatusCode(_ code: Int) throws {
        switch code {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError(code)
        default:
            throw NetworkError.custom("Unexpected status code: \(code)")
        }
    }

    func mapURLError(_ error: URLError) -> NetworkError {
        switch error.code {
        case .notConnectedToInternet:
            return .noInternet
        case .timedOut:
            return .timeout
        case .secureConnectionFailed,
             .serverCertificateUntrusted,
             .serverCertificateHasBadDate,
             .serverCertificateHasUnknownRoot:
            return .sslPinningFailed
        default:
            return .custom(error.localizedDescription)
        }
    }
}