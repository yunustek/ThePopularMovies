//
//  MovieModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

struct Movie : Codable {

    let id: Int?
    let `description`: String?
    let poster_path: String?
    let title: String?
    let vote_count: Int?

    //
    var isFavorite: Bool

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case `description` = "overview"
        case poster_path = "poster_path"
        case title = "title"
        case vote_count = "vote_count"
        case isFavorite = "isFavorite"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        `description` = try values.decodeIfPresent(String.self, forKey: .description)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}
