//
//  DashboardViewModel.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import Foundation

class DashboardViewModel {
    
    /// API call to get the dashboard data
    func fetchDashboardData(completion: @escaping (_ dashboardData: [DashboardInfo]?, _ errorMessage: String?) -> Void) {
        DashboardClient.getDashboardData { data, errorMessage in
            if errorMessage == nil {
                guard let data else { return }
                completion(data, nil)
            } else {
                guard let errorMessage else { return }
                completion(nil, errorMessage)
            }
        }
    }
}
