//
//  NCMovementDirection.m
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCDirection.h"

static NSString *__NCDirectionName[] = {
    @"east",
    @"northeast",
    @"north",
    @"northwest",
    @"west",
    @"southwest",
    @"south",
    @"southeast"
};

static NSString *__NCDirectionShortName[] = {
    @"E",
    @"NE",
    @"N",
    @"NW",
    @"W",
    @"SW",
    @"S",
    @"SE"
};

@implementation NCDirection

+(NSString *)nameForDirection:(NCMovementDirection)direction {
    if (direction == -1) {
        return nil;
    }
    return __NCDirectionName[direction & 0x7];
}

+(NSString *)shortNameForDirection:(NCMovementDirection)direction {
    if (direction == -1) {
        return nil;
    }
    return __NCDirectionShortName[direction & 0x7];
}

+(NCMovementDirection)directionForName:(NSString *)name {
    NSInteger direction;
    for (direction = 0; direction < 8; direction++) {
        if ([__NCDirectionName[direction] isEqualToString:name])
            return direction;
    }
    return -1;
}

+(NCMovementDirection)directionForShortName:(NSString *)name {
    NSInteger direction;
    for (direction = 0; direction < 8; direction++) {
        if ([__NCDirectionShortName[direction] isEqualToString:name])
            return direction;
    }
    return -1;
}

@end
