//
//  NCConsoleLineNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCConsoleLineNode.h"

@implementation NCConsoleLineNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _age = 0.0;
        self.fontName = @"Skia Black";
        self.fontSize = 12;
        self.fontColor = [NSColor greenColor];
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    }
    return self;
}

+(instancetype)lineWithText:(NSString *)text {
    NCConsoleLineNode *node = [NCConsoleLineNode new];
    node.text = text;
    return node;
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    _age += seconds;
}

@end
