//
//  NCRandomResolver.h
//  Devember2015
//
//  Created by Calle Englund on 29/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameplayKit/GameplayKit.h>

@interface NCRandomResolver : NSObject {
    GKRandomSource *_randomSource;
}

-(BOOL)isSuccessful:(CGFloat)attack vs:(CGFloat)defense;
-(CGFloat)successGrade:(CGFloat)attack vs:(CGFloat)defense;

@end
