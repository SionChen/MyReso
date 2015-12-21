//
//  SpecialListTableViewCell.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/15.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * titelImageView;
@property (nonatomic,strong)UILabel * weekLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * dayLabel;
@property (nonatomic,strong)UILabel * bigTitleLabel;
@property (nonatomic,strong)UILabel * littleTitleLabel;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;




@end
