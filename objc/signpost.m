#import <Foundation/Foundation.h>
#import <os/log.h>
#import <os/signpost.h>

@interface _Signpost : NSObject

- (void)begin;
- (void)emit:(const char *)message;
- (void)end;

@end

@implementation _Signpost {
    os_log_t _logHandle;
    os_signpost_id_t _signpostID;
}

+ (instancetype)signpostWithSubsystem:(const char *)subsystem category:(const char *)category {
    return [[_Signpost alloc] initWithSubsystem:subsystem category:category];
}

- (instancetype)initWithSubsystem:(const char *)subsystem category:(const char *)category {
    self = [super init];
    if (!self) {
        return nil;
    }

    _logHandle = os_log_create(subsystem, category);
    _signpostID = os_signpost_id_generate(_logHandle);

    return self;
}

- (void)begin {
    os_signpost_interval_begin(_logHandle, _signpostID, "interval", "start");
}

- (void)emit:(const char *)message {
    os_signpost_event_emit(_logHandle, _signpostID, "event", "%{public}s", message);
}

- (void)end {
    os_signpost_interval_end(_logHandle, _signpostID, "interval", "end");
}

@end

int main(int argc, char *argv[]) {
    __block BOOL done = NO;
    @autoreleasepool {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];

        _Signpost *signpost = [_Signpost signpostWithSubsystem:"com.apple.demo" category:"foo"];
        [signpost begin];
        [signpost emit:@"OK"];
        [signpost end];

        while (!done && [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
        }
    }
}