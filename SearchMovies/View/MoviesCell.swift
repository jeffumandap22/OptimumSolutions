//
//  MoviesCell.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/7/24.
//

import Foundation
import UIKit
import SDWebImage

class MoviesCell: UICollectionViewCell {
    var movie: Movie? {
        didSet {
            movieTitle.text = movie?.title
            movieYear.text = movie?.year
            
            guard let imageURL = URL(string: movie?.poster ?? "") else {
                return
            }
            movieImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholder_image_error"))
        }
    }

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieYear.text = ""
        movieTitle.text = ""
        movieImage.image = nil
    }
}
