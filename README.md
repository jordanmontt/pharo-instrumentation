# pharo-instrumentation
Instrumentation profilers built with different instrumentation techniques for Pharo

```st
EpMonitor disableDuring: [
	Metacello new
		baseline: 'InstrumentationProfilers';
		repository: 'github://jordanmontt/InstrumentationProfilers:main';
		load ].
```
