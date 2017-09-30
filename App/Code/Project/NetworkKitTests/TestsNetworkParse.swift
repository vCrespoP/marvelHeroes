//
//  NetworkTests.swift

import XCTest
import Domain
@testable import NetworkKit

class TestsNetworkParse: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

}

extension TestsNetworkParse {

    func test_User_Parsing() {

        // Given
        var item = self.userTest()

        // When
        let itemJson = item.toJson()
        let itemParsed = User.parse(from: itemJson)

        // Then
        XCTAssertEqual(item, itemParsed)

    }

    func test_User_Response_Success_Parsing() {

        // Given
        let item = self.userTest()
        var response = ServerResponse()
        response.meta = Meta()
        response.message = ApiMessage(title: "Error", text: "Something went wrong")
        response.data = item.toJson()
        response.statusCode = 200

        // When
        let responseJson = response.toJson()
        guard let responseParsed = ServerResponse.parse(from: responseJson) else {
            XCTFail()
            return
        }
        let itemParsed = User.parse(from: responseParsed.data)

        // Then
        XCTAssertNotNil(response.data)
        XCTAssertEqual(item, itemParsed)

    }

}

extension TestsNetworkParse {

    fileprivate func userTest() -> User {

        var item = User()
        item.id = "user Id"
        item.avatarUrl = "https://image.com/userPic.png"
        item.birthdate = Date().timeIntervalSince1970
        item.email = "a@a.co"
        item.firstName = "John"
        item.lastName = "Doe"
        item.isActive = true
        item.gender = .male
        item.groups = []

        return item
    }

}
