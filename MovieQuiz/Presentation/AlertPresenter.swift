//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 28.01.2025.
//

import UIKit

final class AlertPresenter {
    
    func presentAlert(model: AlertModel) -> UIAlertController {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "Game results"
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        return alert
    }
}
