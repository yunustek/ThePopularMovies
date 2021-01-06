//
//  MovieCellViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

final class MovieCellViewModel: BaseCellViewModel {

//    let audioClips: BehaviorRelay<[(startMS: Double?, durationMS: Double?)]>?
//    var type: BroadcasterType?
//
//    init(broadcasterViewModel: BroadcasterViewModel,
//         audioClips: BehaviorRelay<[(startMS: Double?, durationMS: Double?)]>? = nil) {
//
//        self.audioClips = audioClips
//        self.type = nil // its adding in broadcasterlistview initialization
//        super.init(trackId: broadcasterViewModel.trackId,
//                   audioId: broadcasterViewModel.audioId,
//                   audioUrlString: broadcasterViewModel.audioUrlString,
//                   name: broadcasterViewModel.name,
//                   twitterName: broadcasterViewModel.username,
//                   isVerified: broadcasterViewModel.isVerified,
//                   avatarURL: broadcasterViewModel.avatarURL,
//                   closed: broadcasterViewModel.closed)
//    }
}

// BaseCellDataProtocol

extension MovieCellViewModel: BaseCellDataProtocol {

    static var reuseIdentifier: String {

         return String(describing: MovieCell.self)
     }

     var reuseIdentifier: String {

         return MovieCell.reuseIdentifier
     }
}
