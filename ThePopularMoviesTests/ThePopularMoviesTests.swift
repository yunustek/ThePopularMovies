//
//  ThePopularMoviesTests.swift
//  ThePopularMoviesTests
//
//  Created by Yunus Tek on 5.01.2021.
//

import XCTest
@testable import Popular_Movies_Debug

class ThePopularMoviesTests: XCTestCase {

    var provider: Provider?

    override func setUp() {
        super.setUp()
        provider = Provider()
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    func test_fetch_popular_movies() {

        // Given A Provider
        let provider = self.provider!

        // When fetch movies
        let expect = XCTestExpectation(description: "callback")

        provider.fetchMovies(with: .movies(pageNo: 1), successClosure: { movies in
            expect.fulfill()
            XCTAssertEqual(movies?.results?.count, 20)
            for movie in movies?.results ?? [] {
                XCTAssertNotNil(movie.id)
            }

        }, errorClosure: { (error) in

        })

        wait(for: [expect], timeout: 0.5)
    }

    func test_fetch_movie() {

        // Given A Provider
        let provider = self.provider!

        // When fetch movies
        let expect = XCTestExpectation(description: "callback")

        provider.fetchMovie(with: .movie(movieId: 755812), successClosure: { movie in
            expect.fulfill()

            XCTAssertNotNil(movie)
            XCTAssertEqual(movie?.title?.isEmpty, false)
            XCTAssertNotNil(movie?.id)
            XCTAssertNotNil(movie?.poster_path)
            XCTAssertEqual(movie?.poster_path?.isEmpty, false)

            provider.fetchImage(with: .image(imageId: movie!.poster_path!, widthSize: 400)) { image in

                XCTAssertNotNil(image)
            } errorClosure: { (error) in

            }

        }, errorClosure: { (error) in

        })

        wait(for: [expect], timeout: 0.5)
    }
}

