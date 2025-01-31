//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 28.01.2025.
//

import Foundation
import UIKit

class AlertPresenter {
    
    func presentAlert(model: AlertModel) -> UIAlertController {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        return alert
    }
}



//        let alert = UIAlertController(
//            title: result.title,
//            message: result.text,
//            preferredStyle: .alert)
//
//        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self]
//            _ in
//            guard let self = self else { return }
//            self.currentQuestionIndex = 0
//            self.correctAnswers = 0
//            questionFactory?.requestNextQuestion()
//            self.imageView.layer.borderWidth = 0
//        }
//
//        alert.addAction(action)
//
//        self.present(alert, animated: true, completion: nil)
