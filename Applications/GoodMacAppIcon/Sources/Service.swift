//
//  Service.swift
//  GoodMacAppIcon
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import AppKit
import Foundation
import GoodMacAppIconCore
import Observation

@MainActor
@Observable
final class Service: NSObject {
    private let modelCache = ModelCache()

    func probabilityOfGoodAppIconImage(_ appIconImage: NSImage) async throws -> Double {
        let appIconCIImage = try appIconImage.renderCIImage()
        let probability = try await modelCache.goodMacAppIconModel.probability(image: appIconCIImage)
        return probability
    }
}

extension Service: NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        Task.detached {
            await self.modelCache.preloadModels()
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
