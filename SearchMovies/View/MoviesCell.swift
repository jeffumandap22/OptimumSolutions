//
//  MoviesCell.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/7/24.
//

import Foundation
import UIKit

class MoviesCell: UICollectionViewCell {
    static let identifier = "MoviesCell"
    var movie: Movie? {
        didSet {
            movieTitle.text = movie?.title
            movieYear.text = movie?.year
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
        //movieImage
        movieYear.text = ""
        movieTitle.text = ""
    }
}
