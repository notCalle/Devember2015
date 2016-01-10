//
//  SubsampledTile.m
//  Devember2015
//
//  Created by Calle Englund on 03/01/16.
//  Copyright © 2016 Calle Englund. All rights reserved.
//

#import "SubsampledTile.h"

@implementation SubsampledTile

+(instancetype)tileWith:(uint16_t)subsample {
    NSString *name;
    CGFloat height;
    CGFloat cost;
    
    switch (subsample) {
            // Water Tiles
        case 0x0000:
            name=@"Terrain/0000-Water"; height=0.3; cost=5.0;
            break;

        case 0x0001:
            name=@"Terrain/0001-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0010:
            name=@"Terrain/0010-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0011:
            name=@"Terrain/0011-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0100:
            name=@"Terrain/0100-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0101:
            name=@"Terrain/0101-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0110:
            name=@"Terrain/0110-Beach"; height=0.3; cost=2.0;
            break;
        case 0x0111:
            name=@"Terrain/0111-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1000:
            name=@"Terrain/1000-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1001:
            name=@"Terrain/1001-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1010:
            name=@"Terrain/1010-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1011:
            name=@"Terrain/1011-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1100:
            name=@"Terrain/1100-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1101:
            name=@"Terrain/1101-Beach"; height=0.3; cost=2.0;
            break;
        case 0x1110:
            name=@"Terrain/1110-Beach"; height=0.3; cost=2.0;
            break;

        case 0x0012:
            name=@"Terrain/0012-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0021:
            name=@"Terrain/0021-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0102:
            name=@"Terrain/0102-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0201:
            name=@"Terrain/0201-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0120:
            name=@"Terrain/0120-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0210:
            name=@"Terrain/0210-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0112:
            name=@"Terrain/0112-Beach"; height=0.3; cost=3.0;
            break;
        case 0x0122:
            name=@"Terrain/0122-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0212:
            name=@"Terrain/0212-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x1002:
            name=@"Terrain/1002-Beach"; height=0.3; cost=3.0;
            break;
        case 0x2001:
            name=@"Terrain/2001-Beach"; height=0.3; cost=3.0;
            break;
        case 0x1020:
            name=@"Terrain/1020-Beach"; height=0.3; cost=3.0;
            break;
        case 0x2010:
            name=@"Terrain/2010-Beach"; height=0.3; cost=3.0;
            break;
        case 0x1021:
            name=@"Terrain/1021-Beach"; height=0.3; cost=3.0;
            break;
        case 0x1022:
            name=@"Terrain/1022-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2021:
            name=@"Terrain/2021-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x1200:
            name=@"Terrain/1200-Beach"; height=0.3; cost=3.0;
            break;
        case 0x2100:
            name=@"Terrain/2100-Beach"; height=0.3; cost=3.0;
            break;
        case 0x1201:
            name=@"Terrain/1201-Beach"; height=0.3; cost=3.0;
            break;
        case 0x1202:
            name=@"Terrain/1202-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2201:
            name=@"Terrain/2201-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2110:
            name=@"Terrain/2110-Beach"; height=0.3; cost=3.0;
            break;
        case 0x2120:
            name=@"Terrain/2120-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2210:
            name=@"Terrain/2210-Cliff"; height=0.3; cost=3.0;
            break;
            
        case 0x0002:
            name=@"Terrain/0002-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0020:
            name=@"Terrain/0020-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0022:
            name=@"Terrain/0022-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0200:
            name=@"Terrain/0200-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0202:
            name=@"Terrain/0202-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0220:
            name=@"Terrain/0220-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x0222:
            name=@"Terrain/0222-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2000:
            name=@"Terrain/2000-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2002:
            name=@"Terrain/2002-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2020:
            name=@"Terrain/2020-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2022:
            name=@"Terrain/2022-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2200:
            name=@"Terrain/2200-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2202:
            name=@"Terrain/2202-Cliff"; height=0.3; cost=3.0;
            break;
        case 0x2220:
            name=@"Terrain/2220-Cliff"; height=0.3; cost=3.0;
            break;
            
            // Ground Tiles
        case 0x1111:
            name=@"Terrain/1111-Ground"; height=0.6; cost=1.5;
            break;
            
        case 0x1112:
            name=@"Terrain/1112-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1121:
            name=@"Terrain/1121-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1122:
            name=@"Terrain/1122-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1211:
            name=@"Terrain/1211-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1212:
            name=@"Terrain/1212-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1221:
            name=@"Terrain/1221-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x1222:
            name=@"Terrain/1222-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2111:
            name=@"Terrain/2111-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2112:
            name=@"Terrain/2112-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2121:
            name=@"Terrain/2121-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2122:
            name=@"Terrain/2122-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2211:
            name=@"Terrain/2211-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2212:
            name=@"Terrain/2212-Cliff"; height=0.6; cost=2.0;
            break;
        case 0x2221:
            name=@"Terrain/2221-Cliff"; height=0.6; cost=2.0;
            break;
            
            // Mountain Tiles
        case 0x2222:
            name=@"Terrain/2222-Mountain"; height=0.9; cost=3.0;
            break;
            
        default:
            name=@"Terrain/2222-Mountain"; height=0.9; cost=3.0;
            break;
    }
    return (SubsampledTile *)[[IsoTile alloc] initWithImageNamed:name height:height cost:cost];
}

@end
