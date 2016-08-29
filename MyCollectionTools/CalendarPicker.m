//
//  CalendarPicker.m
//  CalendarPicker
//
//  Created by 王右 on 16/8/25.
//  Copyright © 2016年 王右. All rights reserved.
//

#import "CalendarPicker.h"
#import "CalendarCell.h"
#import "UIColor+Add.h"

NSString *const SZCalendarCellIdentifier = @"cell";

@interface CalendarPicker ()
@property (nonatomic , weak) IBOutlet UILabel *monthLabel;
@property (nonatomic , weak) IBOutlet UIButton *previousButton;
@property (nonatomic , weak) IBOutlet UIButton *nextButton;
@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) NSArray *tagArr;
@property (nonatomic , strong) NSDateComponents *currentSelectDate;
@end

@implementation CalendarPicker


- (void)drawRect:(CGRect)rect {
    
    [self customInterface];
}

- (void)awakeFromNib{
    [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:SZCalendarCellIdentifier];
     _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (void)customInterface{
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView.collectionViewLayout = layout;
}

- (void)setDate:(NSDate *)date{
    _date = date;
    [_monthLabel setText:[NSString stringWithFormat:@"%li-%.2ld",(long)[self year:date],(long)[self month:date]]];
    [_collectionView reloadData];
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return [self monthItems];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZCalendarCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#888888"]];
        cell.dateLabel.layer.borderWidth = 0;
        cell.dateLabel.backgroundColor = [UIColor whiteColor];
    } else {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            cell.dateLabel.layer.borderWidth = 0;
            cell.dateLabel.backgroundColor = [UIColor whiteColor];
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
            cell.dateLabel.layer.borderWidth = 0;
            cell.dateLabel.backgroundColor = [UIColor whiteColor];
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
            cell.dateLabel.layer.cornerRadius = cell.dateLabel.bounds.size.width / 2;
            cell.dateLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.dateLabel.layer.borderWidth = 0;
            cell.dateLabel.layer.masksToBounds = YES;
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#4898eb"]];
                    cell.dateLabel.backgroundColor = [UIColor whiteColor];
                    cell.dateLabel.layer.cornerRadius  = cell.dateLabel.bounds.size.width / 2;
                    cell.dateLabel.layer.borderWidth = 1;
                    cell.dateLabel.layer.borderColor = [UIColor colorWithHexString:@"#4898eb"].CGColor;
                    return cell;
                } else if (day > [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
                }
            } else if ([_today compare:_date] == NSOrderedAscending) {
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
            }
            if (day == _currentSelectDate.day && _currentSelectDate.month == [self month:_date] && _currentSelectDate.year == [self year:_date]) {
                [cell.dateLabel setTextColor:[UIColor whiteColor]];
                cell.dateLabel.backgroundColor = [UIColor colorWithHexString:@"#4898eb"];
            }else{
                cell.dateLabel.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day <= [self day:_date]) {
                    return YES;
                }
            } else if ([_today compare:_date] == NSOrderedDescending) {
                return YES;
            }
        }
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    comp.day = day;
    
    if (day <= 0) {
        return;
    }
    
    if (day > [self totaldaysInMonth:_date]) {
        return;
    }

    _currentSelectDate = comp;
    [_collectionView reloadData];
    
    if (self.calendarBlock) {
        NSString *monthString = [comp month] >= 10 ? [NSString stringWithFormat:@"%ld",[comp month]] : [NSString stringWithFormat:@"0%ld",[comp month]];
        
        NSString *dayString = [comp day] >= 10 ? [NSString stringWithFormat:@"%ld",[comp day]] : [NSString stringWithFormat:@"0%ld",[comp day]];
        
        NSString *dateString = [NSString stringWithFormat:@"%ld-%@-%@",[comp year],monthString,dayString];
        
        self.calendarBlock(day, [comp month], [comp year],dateString);
    }
}

- (IBAction)previouseAction:(UIButton *)sender
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentSelectDate ? [[NSCalendar currentCalendar] dateFromComponents:_currentSelectDate] : self.date];
    self.date = [self lastMonth:self.date];
    _currentSelectDate = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentSelectDate ? [self lastMonth:[[NSCalendar currentCalendar] dateFromComponents:_currentSelectDate]] : self.date];
    [_collectionView reloadData];
    if (self.calendarBlock) {
        
        NSString *monthString = [NSString stringWithFormat:@"%02ld",[comp month] - 1];
        NSString *dayString = [NSString stringWithFormat:@"%02ld",[comp day]];
        
        
        NSString *year = [NSString stringWithFormat:@"%ld",[comp year]];
        
        if (monthString.integerValue < 0) {
            monthString = @"12";
            year = [NSString stringWithFormat:@"%ld",year.integerValue - 1];
        }
        
        NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@",year,monthString,dayString];
        
        self.calendarBlock([comp day], [comp month] - 1, [comp year],dateString);
    };
}

- (IBAction)nexAction:(UIButton *)sender
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentSelectDate ? [[NSCalendar currentCalendar] dateFromComponents:_currentSelectDate] : self.date];
    self.date = [self nextMonth:self.date];
    _currentSelectDate = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentSelectDate ? [self nextMonth:[[NSCalendar currentCalendar] dateFromComponents:_currentSelectDate]] : self.date];
    
    [_collectionView reloadData];
    
    if (self.calendarBlock) {
        
        NSString *monthString = [comp month] >= 10 ? [NSString stringWithFormat:@"%ld",[comp month] + 1] : [NSString stringWithFormat:@"0%ld",[comp month] + 1];
        
        NSString *dayString = [comp day] >= 10 ? [NSString stringWithFormat:@"%ld",[comp day]] : [NSString stringWithFormat:@"0%ld",[comp day]];
        
        NSString *year = [NSString stringWithFormat:@"%ld",[comp year]];
        
        if (monthString.integerValue > 12) {
            monthString = @"01";
            year = [NSString stringWithFormat:@"%ld",year.integerValue + 1];
        }
        NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@",year,monthString,dayString];
        self.calendarBlock([comp day], [comp month] + 1, [comp year],dateString);
    };
}

+ (instancetype)showOnView:(UIView *)view
{
    CalendarPicker *calendarPicker = [[[NSBundle mainBundle] loadNibNamed:@"CalendarPicker" owner:self options:nil] firstObject];
    calendarPicker.frame = view.bounds;
    [view addSubview:calendarPicker];
    return calendarPicker;
}

- (NSInteger )monthItems
{
    NSInteger week = [self firstWeekdayInThisMonth:_date];
    NSInteger days = [self totaldaysInMonth:_date];
    NSInteger items = 0;
    switch (week) {
        case 0:
            if (days == 28) {
                items = 28;
            }else{
                items = 35;
            }
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            items = 35;
            break;
        case 5:
            if (days < 31) {
                items = 35;
            }else{
                items = 42;
            }
            break;
        case 6:
            if (days < 30) {
                items = 35;
            }else{
                items = 42;
            }
            break;
        default:
            items = 0;
    }
    return items;
}

@end
