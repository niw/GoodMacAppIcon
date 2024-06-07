//
//  GoodMacAppIconModel.swift
//  GoodMacAppIconCore
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import AppKit
import CoreML
import Foundation

public final class GoodMacAppIconModel {
    private enum Error: Swift.Error {
        case failed(reason: String)
    }

    private let goodMacIcon: GoodMacAppIcon

    public init() throws {
        let configuration = MLModelConfiguration()
        configuration.computeUnits = .all
        goodMacIcon = try GoodMacAppIcon(configuration: configuration)
    }

    public func probability(image: CIImage) async throws -> Double {
        let inputImage = try image.renderPixelBuffer()
        let input = GoodMacAppIconInput(image: inputImage)

        let output = try await goodMacIcon.prediction(input: input)

        guard let probability = output.targetProbability["good"] else {
            throw Error.failed(reason: "No probability for good target.")
        }
        return probability
    }
}
