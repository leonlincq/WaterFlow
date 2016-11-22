//
//  LcqCollectionViewCell.m
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import "LcqCollectionViewCell.h"
#import "shopModel.h"
#import <UIImageView+WebCache.h>

@interface LcqCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;

@property (weak, nonatomic) IBOutlet UILabel *numbLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end


@implementation LcqCollectionViewCell

-(void)setModel:(shopModel *)model
{
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.priceLabel.text = model.price;
}

-(void)setMyindexpath:(NSIndexPath *)myindexpath
{
    self.numbLabel.text = [NSString stringWithFormat:@"%ld",myindexpath.item];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
