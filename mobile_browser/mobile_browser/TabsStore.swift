//
//  TabsStore.swift
//  mobile_browser
//
//  Created by Charles He on 8/7/22.
//

import Foundation
import SwiftUI
import WebKit

class TabsStore: ObservableObject {
    static var tabs: [WebSite] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("tabs.data")
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

