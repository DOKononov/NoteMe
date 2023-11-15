//
//  AnimatorService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class AnimatorService {
    func moveWithAnimation(for viewController: UIViewController,
              view: UIView,
              toSatisfyKeyboard frame: CGRect,
              with padding: CGFloat = 16) {
        let maxY = view.frame.maxY + padding
        let keyboardY = frame.minY
        let diff = maxY - keyboardY
        
        if diff > 0 {
            animate(for: viewController, tergetView: view, with: -diff)
        } else if diff < 0 {
            animate(for: viewController, tergetView: view, with: .zero)
        }
    }
    
    private func animate(for viewController: UIViewController,
                      tergetView: UIView,
                      with offset: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            tergetView.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(offset)
            }
            viewController.view.layoutIfNeeded()
        }
    }
}
