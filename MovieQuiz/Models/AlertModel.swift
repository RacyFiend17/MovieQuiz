//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 28.01.2025.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)
}
