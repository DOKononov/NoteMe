//
//  LocationPinView.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 8.04.24.
//

import Foundation
import MapKit
import SnapKit

final class LocationPinView: MKAnnotationView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .MainTabBar.location)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func commonInit() {
        frame.size = .init(width: 40, height: 90)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: selected ? 1.2 : 1,
                                               y: selected ? 1.2 : 1)
        }
    }
}
