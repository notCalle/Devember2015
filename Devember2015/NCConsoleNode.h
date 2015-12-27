//
//  NCConsoleNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NCConsoleNode : SKShapeNode

@property NSInteger maxLines;

-(instancetype)initWithCapacity:(NSInteger)lines;
+(instancetype)withCapacity:(NSInteger)lines;

-(void)addText:(NSString *)text;
-(void)resize;
-(void)updateWithDeltaTime:(NSTimeInterval)seconds;

@end
