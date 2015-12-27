//
//  NCPlayerBrainComponent.m
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPlayerBrainComponent.h"
#import "NCTorchComponent.h"

@implementation NCPlayerBrainComponent

-(void)willLightTorch {
    NCTorchComponent *torch = (NCTorchComponent *)[self.entity componentForClass:[NCTorchComponent class]];
    if (torch) {
        if (torch.isBurnedOut) {
            [torch didReplaceTorch];
        }
        if (!torch.isLit) {
            [torch didLightTorch:YES];
        }
    }
}

@end
