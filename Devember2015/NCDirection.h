//
//  NCMovementDirection.h
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    MOVE_NOWHERE = -1,
    MOVE_EAST,
    MOVE_NORTHEAST,
    MOVE_NORTH,
    MOVE_NORTHWEST,
    MOVE_WEST,
    MOVE_SOUTHWEST,
    MOVE_SOUTH,
    MOVE_SOUTHEAST
} NCMovementDirection;

@interface NCDirection : NSObject

+(NSString *)nameForDirection:(NCMovementDirection)direction;
+(NSString *)shortNameForDirection:(NCMovementDirection)direction;
+(NCMovementDirection)directionForName:(NSString *)name;
+(NCMovementDirection)directionForShortName:(NSString *)name;

@end
