//
//  DateShimmerCell.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/16.
//

import UIKit

class DateShimmerCell: UITableViewCell {

    @IBOutlet weak var dateshimmerFirstView: UIView!
    @IBOutlet weak var dateshimmerSecondView: UIView!
    @IBOutlet weak var dateshimmerThirdView: UIView!
    @IBOutlet weak var dateshimmerForthView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateshimmerFirstView.shimmer()
        dateshimmerSecondView.shimmer()
        dateshimmerThirdView.shimmer()
        dateshimmerForthView.shimmer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
