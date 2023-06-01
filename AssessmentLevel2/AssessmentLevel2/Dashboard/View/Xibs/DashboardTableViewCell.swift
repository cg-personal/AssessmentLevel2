//
//  DashboardTableViewCell.swift
//  AssessmentLevel2
//
//  Created by Sankar on 01/06/23.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var pictureImageView: CustomImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageSizeLabel: UILabel!
    
    // MARK: - LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    // MARK: - CONFIG
    private func configUI() {
        self.pictureImageView.addCornerRadius(radius: 10)
    }
    
    // MARK: - HELPER
    func setupCell(data: DashboardInfo) {
        tag = Int(data.id) ?? 0
        self.checkButton.tag = Int(data.id) ?? 0
        self.pictureImageView.loadImage(urlString: data.downloadUrl)
        self.authorLabel.text = data.author
        self.descriptionLabel.text = data.url
        self.imageSizeLabel.text = "Width: \(data.width) Height: \(data.height)"
    }
}
