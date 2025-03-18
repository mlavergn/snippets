#import <Foundation/Foundation.h>
#import <os/log.h>

@interface _Log : NSObject

- (instancetype)initWithSubsystem:(const char *)subsystem
                         category:(const char *)category;
- (void)log:(NSString *)message;

@end

@implementation _Log {
    os_log_t _logHandle;
}

+ (instancetype)logWithSubsystem:(const char *)subsystem
                        category:(const char *)category {
    return [[_Log alloc] initWithSubsystem:subsystem category:category];
}

- (instancetype)initWithSubsystem:(const char *)subsystem
                         category:(const char *)category {
    self = [super init];
    if (!self) {
        return nil;
    }

    _logHandle = os_log_create(subsystem, category);
    return self;
}

- (void)log:(NSString *)message {
    os_log(_logHandle, "%{public}s", message.UTF8String);
}

@end

int main(int argc, char *argv[]) {
    __block BOOL done = NO;
    @autoreleasepool {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];

        _Log *log = [_Log logWithSubsystem:"com.apple.demo" category:"foo"];
        [log log:@"foo"];

        while (!done && [runloop runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]]) {
        }
    }
}