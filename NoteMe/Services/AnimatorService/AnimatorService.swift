//
//  AnimatorService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class AnimatorService {
    func moveWithAnimation(for viewController: UIViewController,
              infoView: UIView,
              toSatisfyKeyboard frame: CGRect,
              with padding: CGFloat = 16) {
        let safeAreaMinY = viewController.view.safeAreaLayoutGuide.layoutFrame.minY
        let maxY = infoView.frame.maxY + padding + safeAreaMinY
        let keyboardY = frame.minY
        let diff = maxY - keyboardY
        
        if diff > 0 {
            animate(for: viewController, tergetView: infoView, with: -diff)
        } else if diff < 0 {
            animate(for: viewController, tergetView: infoView, with: .zero)
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
