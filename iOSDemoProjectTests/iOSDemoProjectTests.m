//
//  iOSDemoProjectTests.m
//  iOSDemoProjectTests
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TableViewCell.h"

@interface iOSDemoProjectTests : XCTestCase

@end

@implementation iOSDemoProjectTests

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

- (void)testJsonIsValid
    {
        NSString* filepath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filepath];
        id JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        XCTAssertTrue([JSON isKindOfClass:[NSDictionary class]]);
    }


@end
