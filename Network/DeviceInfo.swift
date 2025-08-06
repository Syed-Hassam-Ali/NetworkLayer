//
//  DeviceInfo.swift
//  NetworkLayerTesting
//
//  Created by Hassam on 06/08/2025.
//

import UIKit

class DeviceInfo {

    static let shared = DeviceInfo()

    private init() {}

    /// App version (e.g. "1.0.3")
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    /// App build number (e.g. "123")
    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    /// App name (e.g. "MyApp")
    var appName: String {
        Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }

    /// Bundle Identifier (e.g. "com.example.myapp")
    var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "Unknown"
    }

    /// Device model (e.g. "iPhone", "iPad")
    var deviceModel: String {
        UIDevice.current.model
    }

    /// Device name (e.g. "Hassam’s iPhone")
    var deviceName: String {
        UIDevice.current.name
    }

    /// System name (e.g. "iOS")
    var systemName: String {
        UIDevice.current.systemName
    }

    /// System version (e.g. "17.0")
    var systemVersion: String {
        UIDevice.current.systemVersion
    }

    /// Identifier for Vendor (unique per app install)
    var identifierForVendor: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
    }

    /// A dictionary of all device info
    var asDictionary: [String: String] {
        return [
            "App-Name": appName,
            "App-Version": appVersion,
            "Build-Number": buildNumber,
            "Bundle-ID": bundleIdentifier,
            "Device-Model": deviceModel,
            "Device-Name": deviceName,
            "System-Name": systemName,
            "System-Version": systemVersion,
            "Identifier-for-Vendor": identifierForVendor
        ]
    }
}
