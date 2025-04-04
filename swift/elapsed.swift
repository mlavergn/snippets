let startTime = CFAbsoluteTimeGetCurrent()

var timeElapsed = (CFAbsoluteTimeGetCurrent() - startTime) * 1000000000

print("\nElapsed(nsec): \(timeElapsed)\n")


    mach_timebase_info_data_t _clock_timebase;
    mach_timebase_info(&_clock_timebase);

    uint64_t start = mach_absolute_time();
    NSArray<_LTDUAFAssetModel *> *result_new = [self _catalog_new];
    //    NSArray<_LTDUAFAssetModel *> *result_legacy = [self _catalog_legacy];
    uint64_t stop = mach_absolute_time();

    NSTimeInterval elapsed = (stop - start) * _clock_timebase.numer / _clock_timebase.denom / 1.0e9;
    LT_LOG_INFO(Assets, ">>> UAF catalog creation %f", elapsed);
    return result_new;
