//
//  NCConsoleNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCConsoleNode.h"
#import "NCConsoleLineNode.h"

@implementation NCConsoleNode

-(instancetype)init {
    self = [super init];
    if (self) {
        self.alpha = 0.0;
        self.fillColor = [NSColor blackColor];
        self.strokeColor = [NSColor blackColor];
        self.glowWidth = 5.0;
    }
    return self;
}
-(instancetype)initWithCapacity:(NSInteger)lines {
    self = [self init];
    if (self) {
        _maxLines = lines;
    }
    return self;
}

+(instancetype)withCapacity:(NSInteger)lines {
    return [[NCConsoleNode alloc] initWithCapacity:lines];
}

-(void)resize {
    CGFloat lineOffset = 0.0;
    CGFloat maxWidth = 0.0;
    for (NCConsoleLineNode *line in self.children) {
        line.position = CGPointMake(0.0, lineOffset);
        lineOffset -= line.frame.size.height + 1.0;
        if (line.frame.size.width > maxWidth)
            maxWidth = line.frame.size.width;
    }
    self.path = CGPathCreateWithRect(CGRectMake(0.0, 0.0, maxWidth + 2.0, lineOffset + 1.0), NULL);
}

-(void)addText:(NSString *)text {
    NCConsoleLineNode *line = [NCConsoleLineNode lineWithText:text];
    if (self.children.count >= _maxLines) {
        [self removeChildrenInArray:[[self children] subarrayWithRange:NSMakeRange(0, 1)]];
    }
    [self addChild:line];
    [self resize];
    [self runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.8 duration:0.5],
                                         [SKAction fadeAlphaTo:0.3 duration:10.0]]]];
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    for (NCConsoleLineNode *line in self.children) {
        [line updateWithDeltaTime:seconds];
        if (line.age > 60.0) {
            [line removeFromParent];
            [self resize];
        }
    }
}

@end
