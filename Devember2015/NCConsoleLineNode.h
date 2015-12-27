//
//  NCConsoleLineNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NCConsoleLineNode : SKLabelNode

@property NSTimeInterval age;

+(instancetype)lineWithText:(NSString *)text;

-(void)updateWithDeltaTime:(NSTimeInterval)seconds;

@end
