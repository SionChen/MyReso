//
//  SearchViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "SearchViewController.h"
#import "OrderListViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@end
static NSString * cell_id = @"SEARCH_CELL";
@implementation SearchViewController
{
    //搜索框
    UITextField * _textField;
    
    //tableview
    UITableView * _tableView;
    //无信息label
    UILabel * _noneLabel;
    
    //存储搜索记录
    NSMutableArray * _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    _dataArray = [[NSMutableArray alloc] init];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    //leftbarButtonItem去掉
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
    self.navigationItem.leftBarButtonItem = barButton;
    
    [self createSearchView];
    [self createTableView];
    [self createNoneLabel];
    [self createSectionLabel];
    //设置搜索框为第一响应者
    [_textField becomeFirstResponder];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray * arr= [[NSUserDefaults standardUserDefaults] objectForKey:@"SearchArray"];
    [_dataArray removeAllObjects];
    for (NSString * str in arr) {
        [_dataArray addObject:str];
        
    }
    //隐藏 提示
    if (_dataArray.count>0) {
        _noneLabel.hidden = YES;
    }else
    {
        _noneLabel.hidden = NO;
    }
    [_tableView reloadData];
}
//section上的view
-(void)createSectionLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 150, 10)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"搜索历史记录";
    [self.view addSubview:label];
    
    UIButton * cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanButton.frame = CGRectMake(WIDTH-50, 10, 40, 20);
    [cleanButton setTitle:@"清空" forState:UIControlStateNormal];
    [cleanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cleanButton.titleLabel.font = [UIFont systemFontOfSize:11];
    cleanButton.layer.cornerRadius = 2;
    cleanButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cleanButton.layer.borderWidth = 1;
    cleanButton.layer.masksToBounds = YES;
    cleanButton.tag = 1002;
    [cleanButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cleanButton];
}

//清楚按钮响应
-(void)buttonClick:(UIButton *)btn
{
    NSArray  *arr = [[NSArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"SearchArray"];
    [_dataArray removeAllObjects];
    [_tableView reloadData];
}

//无信息时的label
-(void)createNoneLabel
{
    _noneLabel = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-130)/2, 190, 130, 10)];
    _noneLabel.text = @"暂无任何搜索信息";
    _noneLabel.textColor = [UIColor lightGrayColor];
    _noneLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_noneLabel];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1];
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    [self.view addSubview:_tableView];
}

#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count>0) {
        return [_dataArray count];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    
    if (_dataArray.count>0) {
        cell.textLabel.text =  [_dataArray objectAtIndex:[_dataArray count]-indexPath.row-1];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    OrderListViewController * ovc = [[OrderListViewController alloc] init];
    ovc.keyWord = cell.textLabel.text;
    ovc.text = [NSString stringWithFormat:@"搜索:%@",cell.textLabel.text];
    [self.navigationController pushViewController:ovc animated:YES];
}


#pragma mark navigationBar
-(void)createSearchView
{
    
    
    //背景
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, WIDTH-30, 30)];
    searchView.backgroundColor = [UIColor clearColor];
    
    
    //搜索框
    UIImageView * baImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30-40, 30)];
    baImageView.image = [UIImage imageNamed:@"search_bar_bg"];
    [searchView addSubview:baImageView];
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, WIDTH-50-40-40, 30)];
    //_textField.background = [UIImage imageNamed:@"search_bar_bg"];
    _textField.placeholder = @"搜索你感兴趣的商品";
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.delegate = self;
    [searchView addSubview:_textField];
    
    //放大镜
    UIImageView * seImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    seImageView.image = [UIImage imageNamed:@"searchMagnifier"];
    [searchView addSubview:seImageView];
    
    //取消按钮
    UIButton * codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame =CGRectMake(WIDTH-30-35, 0, 35, 30);
    //[codeButton setImage:[UIImage imageNamed:@"barcode"] forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    //codeButton.backgroundColor = [UIColor redColor];
    [codeButton setTitle:@"取消" forState:UIControlStateNormal];
    codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchView addSubview:codeButton];
    
    [self.navigationItem setTitleView:searchView];
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField.text length]>0) {
        [_dataArray addObject:_textField.text];
        [textField resignFirstResponder];
        NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
        [users setObject:_dataArray forKey:@"SearchArray"];
        [users synchronize];
        NSLog(@"dataArray:%@",_dataArray);
        NSLog(@" users %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"SearchArray"]);
    }
    
    
    //搜索关键字赋值
    OrderListViewController * ovc = [[OrderListViewController alloc] init];
    ovc.keyWord = textField.text;
    ovc.text = [NSString stringWithFormat:@"搜索:%@",textField.text];
    [self.navigationController pushViewController:ovc animated:YES];
    
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    textField.enablesReturnKeyAutomatically = NO;
    return YES;
}
-(void)codeClick:(UIButton *)btn
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
