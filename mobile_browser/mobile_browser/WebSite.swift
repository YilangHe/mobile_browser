//
//  WebSite.swift
//  mobile_browser
//
//  Created by Charles on 8/5/22.
//

import Foundation
import SwiftUI

struct WebSite: Identifiable, Codable, Hashable {
    var id = UUID()
    let urlString: String 
}
