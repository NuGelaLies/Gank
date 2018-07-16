//
//  ShimmerCell.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/16.
//

import UIKit

class ShimmerCell: UITableViewCell {

    @IBOutlet weak var shimmerFirstView: UIView!
    @IBOutlet weak var shimmerSecondView: UIView!
    @IBOutlet weak var shimmerThirdView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shimmerFirstView.shimmer()
        shimmerSecondView.shimmer()
        shimmerThirdView.shimmer()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
