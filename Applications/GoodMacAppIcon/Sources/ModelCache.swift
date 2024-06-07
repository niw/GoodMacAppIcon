//
//  ModelCache.swift
//  GoodMacAppIcon
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import Foundation
import GoodMacAppIconCore

final actor ModelCache {
    func preloadModels() {
        do {
            _ = try goodMacAppIconModel
        } catch {
        }
    }

    private var _goodMacAppIconModel: GoodMacAppIconModel?
    var goodMacAppIconModel: GoodMacAppIconModel {
        get throws {
            if let _goodMacAppIconModel {
                return _goodMacAppIconModel
            } else {
                let model = try GoodMacAppIconModel()
                _goodMacAppIconModel = model
                return model
            }
        }
    }
}
