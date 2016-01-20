
//
//  ChannelAddViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/15.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ChannelAddViewController.h"
#import "ChannelCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "RequetTool.h"

@interface ChannelAddViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,RequestDelegate>

@end

static NSString * cell_id = @"CHANNELADD_ID";
@implementation ChannelAddViewController
{
    UICollectionView * _collectionView;
    
    //存放id的数组
    NSMutableArray * _idArray;
    
    //请求类
    RequetTool * _requestTool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _idArray = [NSMutableArray array];
    self.navigationItem.title = @"订阅主题";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1"] style:UIBarButtonItemStylePlain target:self action:@selector(barBackButton)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
    //订阅按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"订阅" style:UIBarButtonItemStylePlain target:self action:@selector(addButton:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self createCollectionView];
    
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
    
}

//订阅按钮  在这发送网络请求
-(void)addButton:(UIButton *)btn
{
    NSString * string = [_idArray componentsJoinedByString:@","];
    NSLog(@"%@",string);
    NSString *url = [NSString stringWithFormat:@"http://app.api.yijia.com/tb99/iphone/apphome.php?appid=98a723d3f348b24c85251584250c379e586a851c&ids=%@",string];
    NSDictionary * paramsDict = @{@"appid":@"98a723d3f348b24c85251584250c379e586a851c",@"ids":string};
    [_requestTool postWithUrlString:url withParams:paramsDict andName:@"AddList"];
    
}
-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络繁忙，请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-60)/4, 80)];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 20, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, WIDTH-10 , HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;

    [_collectionView registerClass:[ChannelCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.addArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    if (self.addArray.count>indexPath.row) {
        NSDictionary * dict = [self.addArray objectAtIndex:indexPath.row];
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:dict[@"logo_2x"]] placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.titleLabel.text = dict[@"name"];
        if ([dict[@"is_select"] isEqualToString:@"1"]) {
            cell.frameImageView.hidden = NO;
            [_idArray addObject:dict[@"id"]];
        }
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelCollectionViewCell * cell = (ChannelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    if (self.addArray.count>indexPath.row) {
        cell.frameImageView.hidden = !cell.frameImageView.hidden;
        NSDictionary * dict = [self.addArray objectAtIndex:indexPath.row];
        if (cell.frameImageView.hidden) {
            [_idArray addObject:dict[@"id"]];
        }else
        {
            [_idArray removeObject:dict[@"id"]];
        }
    }
    
    
}



-(void)barBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
