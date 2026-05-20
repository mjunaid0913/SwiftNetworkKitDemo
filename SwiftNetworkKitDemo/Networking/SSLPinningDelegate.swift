//
//  SSLPinningDelegate.swift
//  SwiftNetworkKitDemo
//
//  Created by Muhammad Junaid Babar on 5/20/26.
//


import Foundation

final class SSLPinningDelegate: NSObject, URLSessionDelegate {

    private let certificateName: String

    init(certificateName: String) {
        self.certificateName = certificateName
    }

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {

        guard
            let serverTrust = challenge.protectionSpace.serverTrust,
            let certificatePath = Bundle.main.path(
                forResource: certificateName,
                ofType: "cer"
            ),
            let localCertificateData = try? Data(
                contentsOf: URL(fileURLWithPath: certificatePath)
            ),
            let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
        else {
            return (.cancelAuthenticationChallenge, nil)
        }

        let serverCertificateData =
        SecCertificateCopyData(serverCertificate) as Data

        if serverCertificateData == localCertificateData {
            return (.useCredential, URLCredential(trust: serverTrust))
        } else {
            return (.cancelAuthenticationChallenge, nil)
        }
    }
}