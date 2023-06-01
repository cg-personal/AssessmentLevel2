//
//  DashboardModel.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import Foundation

// MARK: - DASHBOARD INFO MODEL
struct DashboardInfo: Codable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var downloadUrl: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadUrl = "download_url"
    }
}
