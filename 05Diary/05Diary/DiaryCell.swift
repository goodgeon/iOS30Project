//
//  DiaryCell.swift
//  05Diary
//
//  Created by Good geon Lee on 2022/06/14.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
    }
}
