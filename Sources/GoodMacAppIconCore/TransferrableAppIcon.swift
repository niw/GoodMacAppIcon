//
//  TransferrableAppIcon.swift
//  GoodMacAppIcon
//
//  Created by Yoshimasa Niwa on 6/7/24.
//

import AppKit
import CoreTransferable
import Foundation
import UniformTypeIdentifiers

public struct TransferrableAppIcon: Transferable {
    private enum Error: Swift.Error {
        case importFailed
    }

    public var image: NSImage

    public static let supportedContentTypes: [UTType] = [
        .image,
        // `.application` is handled as `.fileURL`, which anyways goes to same API
        // to grab icon image.
        // See `ProxyRepresentation` for `URL`.
        .fileURL
    ]

    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let image = NSImage(data: data) else {
                throw Error.importFailed
            }
            return TransferrableAppIcon(image: image)
        }
        ProxyRepresentation { (url: URL) in
            let image = NSWorkspace.shared.icon(forFile: url.path(percentEncoded: false))
            return TransferrableAppIcon(image: image)
        }
    }
}
