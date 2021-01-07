//
//  MovieModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

struct Movie : Codable, Equatable {

    // IsEqual for favorites
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        guard
            lhs.id == rhs.id,
            lhs.isFavorite == rhs.isFavorite
        else {
            return false
        }
        return true
    }

    let id: Int?
    let `description`: String?
    let poster_path: String?
    let title: String?
    let voteCount: Int?

    //
    var isFavorite: Bool

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case description = "overview"
        case poster_path = "poster_path"
        case title = "title"
        case voteCount = "vote_count"
        case isFavorite = "isFavorite"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}
