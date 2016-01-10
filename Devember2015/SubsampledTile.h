//
//  SubsampledTile.h
//  Devember2015
//
//  Created by Calle Englund on 03/01/16.
//  Copyright © 2016 Calle Englund. All rights reserved.
//

#import "IsoTile.h"

@interface SubsampledTile : IsoTile

+(instancetype)tileWith:(uint16_t)subsample;

@end
