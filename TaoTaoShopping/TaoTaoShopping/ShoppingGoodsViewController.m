
//
//  ShoppingGoodsViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ShoppingGoodsViewController.h"
#import "MyView.h"
#import "ShoppingCollectionReusableView.h"
#import "ShoppingCollectionViewCell.h"
#import "RequetTool.h"
#import <UIImageView+AFNetworking.h>
#import <ZBarSDK.h>
#import "WebViewController.h"
#import "OrderListViewController.h"
#import "SearchViewController.h"


@interface ShoppingGoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RequestDelegate,ZBarReaderDelegate,UITextFieldDelegate,ZBarReaderViewDelegate>

@end

static NSString * cell_id = @"SHOPPING_CELL";
static NSString * header_id = @"SHOPPING_HEADER";
static NSString * picUrl =@"http://app.api.yijia.com/tb99/iphone/images/now_lsit/";
//#define picUrl @"http://app.api.yijia.com/tb99/iphone/images/now_lsit/";
@implementation ShoppingGoodsViewController
{
    
    
    //搜索框
    UITextField * _textField;
    
    //collectionView
    UICollectionView * _collectionView;
    
    //请求类
    RequetTool * _requestTool;
    
    
    //请求返回数据源
    NSMutableDictionary * _dataDict;
    
    //记录第几个左侧button
    NSInteger  _index;
    
    //title
    NSArray * _titleArray;
    
    //zbar阅读器
    ZBarReaderViewController * _reader;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //初始为0
    _index = 0;
    _dataDict = [NSMutableDictionary dictionary];
    _titleArray = @[@"推荐",@"女人",@"美妆",@"数码",@"居家",@"零食",@"男人",@"创意"];
    //侧边栏按钮
    MyView * myView = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 50, HEIGHT-64-44)];
    //block赋值
    myView.block = ^(NSInteger index){
        _index = index;
        [_collectionView reloadData];
        
    };
    [self.view addSubview:myView];
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    
    [self createSearchView];
    [self getCollectionView];
    //[self getUrl];
    
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
    [self requestData];
    

}
#pragma mark Request
-(void)requestData
{
    [_requestTool requestWithUrlString:@"http://zhekou.repai.com/lws/view/zhou_if2.php" andName:@"Collection"];
    
    
}
-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    _dataDict = [[NSMutableDictionary alloc] initWithDictionary:dataDict];
    [_collectionView reloadData];
    
}

-(void)getCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-50-20-40)/3, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(60, 3, WIDTH-20-50 , HEIGHT-113) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    //注册cell和头视图
    [_collectionView registerClass:[ShoppingCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
    [_collectionView registerClass:[ShoppingCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:header_id];
    [self.view addSubview:_collectionView];
    
}
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    SearchViewController * svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
    return YES;
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return 20;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake(WIDTH-20-50, 60);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShoppingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor redColor];
    NSArray * array = _dataDict[[_titleArray objectAtIndex:_index]];
    if (array.count>indexPath.row+1) {
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",picUrl,[array objectAtIndex:indexPath.row+1][@"cid"]]]placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.titleLabel.text =[array objectAtIndex:indexPath.row+1][@"name"];
    }
    
    
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    ShoppingCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_id forIndexPath:indexPath];
    
    
    NSArray * array = [NSArray array];
    array = _dataDict[[_titleArray objectAtIndex:_index]];
    [view.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",picUrl,[array firstObject][@"cid"]]] placeholderImage:[UIImage imageNamed:@"upload"]];
    view.tempBlock = ^{
        
        
        //headerView点击事件
        WebViewController * wbVC = [[WebViewController alloc] initWithUrlString:[array firstObject][@"name"]];
        [self.navigationController pushViewController:wbVC animated:YES];

    };
    
    
    
    return view;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListViewController * ovc = [[OrderListViewController alloc] init];
    NSArray * array = _dataDict[[_titleArray objectAtIndex:_index]];
    if (array.count>indexPath.row+1) {
        ovc.cid =[array objectAtIndex:indexPath.row+1][@"cid"];
        ovc.text =[array objectAtIndex:indexPath.row+1][@"name"];
    }
    [self.navigationController pushViewController:ovc animated:YES];
}


#pragma mark navigationBar
-(void)createSearchView
{
    
    
    //背景
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, WIDTH-30, 30)];
    searchView.backgroundColor = [UIColor clearColor];
    
    
    //搜索框
    UIImageView * baImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30-40, 30)];
    baImageView.image = [UIImage imageNamed:@"search_bar_bg"];
    [searchView addSubview:baImageView];

    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, WIDTH-50-40-30, 30)];
    //_textField.background = [UIImage imageNamed:@"search_bar_bg"];
    _textField.placeholder = @"搜索你感兴趣的商品";
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.delegate = self;
    [searchView addSubview:_textField];
    
    //放大镜
    UIImageView * seImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    seImageView.image = [UIImage imageNamed:@"searchMagnifier"];
    [searchView addSubview:seImageView];
    
    //扫一扫
    UIButton * codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame =CGRectMake(WIDTH-30-30, 0, 30, 30);
    [codeButton setImage:[UIImage imageNamed:@"barcode"] forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:codeButton];
    
    [self.navigationItem setTitleView:searchView];

    
    
    
}
//二维码，条形码扫描功能
-(void)codeClick:(UIButton *)btn
{
    _reader = [[ZBarReaderViewController alloc] init];
    _reader.readerDelegate = self;
    
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [self presentViewController:_reader animated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    
    ZBarSymbol * symbol = nil;
    for (symbol in results) {
        break;
    }
    
    [_reader dismissViewControllerAnimated:YES completion:nil];
    NSString * text = symbol.data;
    NSLog(@"%@",text);
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
