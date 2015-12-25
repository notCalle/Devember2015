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
        self.strokeColor = [NSColor darkGrayColor];
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

-(void)addText:(NSString *)text {
    NCConsoleLineNode *line = [NCConsoleLineNode lineWithText:text];
    if (self.children.count >= _maxLines) {
        [self removeChildrenInArray:[[self children] subarrayWithRange:NSMakeRange(0, 1)]];
    }
    [self addChild:line];
    
    CGFloat lineOffset = 0.0;
    CGFloat maxWidth = 0.0;
    for (NCConsoleLineNode *line in self.children) {
        line.position = CGPointMake(0.0, lineOffset);
        lineOffset -= line.frame.size.height;
        if (line.frame.size.width > maxWidth)
            maxWidth = line.frame.size.width;
    }
    self.path = CGPathCreateWithRect(CGRectMake(0.0, 0.0, maxWidth, lineOffset), NULL);
    [self runAction:[SKAction sequence:@[[SKAction fadeInWithDuration:0.2],
                                         [SKAction fadeOutWithDuration:10.0]]]];
}

@end
