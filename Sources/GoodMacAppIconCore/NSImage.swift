//
//  NSImage.swift
//  GoodMacAppIconCore
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import AppKit
import Foundation

extension NSImage {
    private enum Error: Swift.Error {
        case failed(reason: String)
    }

    public func renderCIImage() throws -> CIImage {
        var rect = NSRect(origin: .zero, size: size)
        guard let cgImage = cgImage(forProposedRect: &rect, context: .current, hints: nil) else {
            throw Error.failed(reason: "Failed to create CGImage")
        }
        return CIImage(cgImage: cgImage)
    }
}
