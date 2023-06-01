//
//  DashboardClient.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import Foundation

final class DashboardClient {
    
    //MARK: - DASHBOARD API
    class func getDashboardData(pageNumber: Int, imageLimit: Int, completion: @escaping (_ data: [DashboardInfo]?, _ errorMessage: String? ) -> Void) {
        let url = "https://picsum.photos/v2/list?page=\(pageNumber)&limit=\(imageLimit)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error?.localizedDescription)
                return
            }
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([DashboardInfo].self, from: data) {
                completion(jsonData, nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
        task.resume()
    }
}
