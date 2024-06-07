//
//  CIImage.swift
//  GoodMacAppIconCore
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import AppKit
import CoreImage
import Foundation

extension CIImage {
    private enum Error: Swift.Error {
        case failed(reason: String)
    }

    public var asNSImage: NSImage {
        let rep = NSCIImageRep(ciImage: self)
        let image = NSImage(size: rep.size)
        image.addRepresentation(rep)
        return image
    }

    public func renderPixelBuffer() throws -> CVPixelBuffer {
        var pixelBuffer: CVPixelBuffer?
        let result = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(extent.width),
            Int(extent.height),
            kCVPixelFormatType_32BGRA,
            nil,
            &pixelBuffer
        )
        guard result == kCVReturnSuccess, let pixelBuffer else {
            throw Error.failed(reason: "Failed to create CVPixelBuffer")
        }
        CIContext().render(self, to: pixelBuffer)
        return pixelBuffer
    }
}
