//
//  IsoTileSceneTests.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IsoTileScene.h"

@interface IsoTileSceneTests : XCTestCase

@end

@implementation IsoTileSceneTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testCartIsoQ1 {
    CGPoint cart = CGPointMake(1.0, 1.0);
    XCTAssertEqual(cart.x, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].x);
    XCTAssertEqual(cart.y, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].y);
}

- (void)testCartIsoQ2 {
    CGPoint cart = CGPointMake(-1.0, 1.0);
    XCTAssertEqual(cart.x, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].x);
    XCTAssertEqual(cart.y, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].y);
}

- (void)testCartIsoQ3 {
    CGPoint cart = CGPointMake(-1.0, -1.0);
    XCTAssertEqual(cart.x, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].x);
    XCTAssertEqual(cart.y, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].y);
}

- (void)testCartIsoQ4 {
    CGPoint cart = CGPointMake(1.0, -1.0);
    XCTAssertEqual(cart.x, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].x);
    XCTAssertEqual(cart.y, [IsoTileScene cartesian:[IsoTileScene isometric:cart]].y);
}

@end
