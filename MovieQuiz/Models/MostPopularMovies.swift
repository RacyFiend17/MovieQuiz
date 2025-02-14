//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 06.02.2025.
//

import Foundation

struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
    
    private enum CodingKeys: String, CodingKey {
    case title = "fullTitle"
    case rating = "rank"
    case imageURL = "image"
    }
}
