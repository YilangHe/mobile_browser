//
//  SavedTabStore.swift
//  mobile_browser
//
//  Created by Charles on 8/6/22.
//

import Foundation
import SwiftUI

class SavedTabStore: ObservableObject {
    @Published var savedTabs: [WebSite] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("savedTabs.data")
    }
    
    static func load(completion: @escaping (Result<[WebSite], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tabs = try JSONDecoder().decode([WebSite].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tabs))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(tabs: [WebSite], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tabs)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(tabs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
