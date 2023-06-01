//
//  ViewController.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import UIKit

class DashboardController: UIViewController {
    // MARK: - OUTLETS
    
    
    // MARK: - PROPERTIES
    var dashboardInfo: [DashboardInfo] = []
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.fetchDashboardData()
    }
    
    // MARK: - CONFIG
    private func configUI() {
        
    }
    
    // MARK: - HELPERS
    private func fetchDashboardData() {
        DashboardViewModel().fetchDashboardData { [weak self] dashboardData, errorMessage in
            guard let self else { return }
            if errorMessage == nil {
                guard let dashboardData else { return }
                self.dashboardInfo = dashboardData
            } else {
                guard let errorMessage else { return }
                self.showAlert(message: errorMessage)
            }
        }
    }
}

