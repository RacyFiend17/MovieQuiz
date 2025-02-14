//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Дмитрий Перчемиди on 07.02.2025.
//

import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        //Given
        let array = [1, 2, 3, 4, 5]
        
        //When
        let value = array[safe: 3]
        
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, array[3])
    }
    
    func testGetValueOutOfRange() throws {
        //Given
        let array = [1, 2, 3, 4, 5]
        
        //When
        let value = array[safe: 10]
        
        //Then
        XCTAssertNil(value)
    }
}
