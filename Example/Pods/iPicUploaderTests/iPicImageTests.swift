//
//  iPicUploaderTests.swift
//  iPicUploaderTests
//
//  Created by Jason Zheng on 9/1/16.
//
//

import XCTest
@testable import iPicUploader

class iPicImageTests: XCTestCase {
  
  func testiPicImage() {
    let image1 = iPicImage(imageFilePath: UTConstants.imageFilePath)
    XCTAssertTrue(!image1.id.isEmpty)
    XCTAssertEqual(image1.version, 1)
    
    let jsonString = "{\"imageHostId\": \"ABC-123\"}"
    let jsonData = jsonString.data(using: String.Encoding.utf8)!
    let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    image1.json = json
    
    XCTAssertEqual(image1.parseImageHostId(), "ABC-123")
    
    let data = NSKeyedArchiver.archivedData(withRootObject: image1)
    let image2 = NSKeyedUnarchiver.unarchiveObject(with: data) as! iPicImage
    XCTAssertEqual(image1.id, image2.id)
    XCTAssertEqual(image1.imageFilePath, image2.imageFilePath)
    XCTAssertEqual(image1.imageData?.count, image2.imageData?.count)
    XCTAssertEqual(image1.version, image2.version)
    XCTAssertEqual(image1.json as? String, image2.json as? String)
  }
}
