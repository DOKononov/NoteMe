//
//  AnimatorService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class AnimatorService {
    func moveWithAnimation(safeAreaMinY: CGFloat,
              infoView: UIView,
              toSatisfyKeyboard frame: CGRect) {
        let padding: CGFloat = 16
        let maxY = infoView.frame.maxY + padding + safeAreaMinY
        let keyboardY = frame.minY
        let diff = maxY - keyboardY
        
        if diff > 0 {
            animate(tergetView: infoView, with: -diff)
        } else if diff < 0 {
            animate(tergetView: infoView, with: .zero)
        }
    }
    
    private func animate(tergetView: UIView,  with offset: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            tergetView.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(offset)
            }
            tergetView.superview?.layoutIfNeeded()
        }
    }
}
