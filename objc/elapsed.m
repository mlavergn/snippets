#import <Foundation/Foundation.h>


@interface _Elapsed : NSObject

- (void)mark;
- (NSTimeInterval)measure;

@end

@implementation _Elapsed {
    mach_timebase_info_data_t _clock_timebase;
    uint64_t _last;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    mach_timebase_info(&_clock_timebase);
    return self;
}

- (void)mark {
    _last = mach_absolute_time();
}

- (NSTimeInterval)measure {
    uint64_t current = mach_absolute_time();
    NSTimeInterval elapsed = (current - _last) * _clock_timebase.numer / _clock_timebase.denom / 1.0e9;
    return elapsed;
}

@end

void demo() {
    _Elapsed *elapsed = [[_Elapsed alloc] init];

    [elapsed mark];
    NSArray<_LTDUAFAssetModel *> *result_new = [self _catalog_new];
    NSTimeInterval elapsed = [elapsed measure];

    LT_LOG_INFO(Assets, ">>> UAF catalog creation %f", elapsed);
}