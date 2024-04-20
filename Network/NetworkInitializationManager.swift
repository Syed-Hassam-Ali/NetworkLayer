//
//  NetworkInitializationManager.swift
//  StarzPlay_App
//
//  Created by Hassam Ali on 12/04/2024.
//

import Foundation

public class NetworkInitializationManager {
    private init() {}

    private var baseURL: String = ""
    private var apiKey: String = ""

    public static let shared = NetworkInitializationManager()

    public func setBaseURL(_ url: String) {
        self.baseURL = url
    }

    public func setAPIKey(_ key: String) {
        self.apiKey = key
    }

    internal func getBaseURL() -> String {
        return self.baseURL
    }

    internal func getAPIKey() -> String {
        return self.apiKey
    }
}
