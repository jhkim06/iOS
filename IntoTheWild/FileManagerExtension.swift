//
//  FileManagerExtension.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/07.
//

import Foundation

extension FileManager {
    private static func documentsURL() -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        return url
    }
    
    static func regionUpdatesDataPath() -> URL {
        return documentsURL().appendingPathComponent("region_updates.json")
    }
}
