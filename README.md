# Data Analytics Project 1
> PPG plotter / AVNN and SDNN solver

![Output of sampled data.](https://i.imgur.com/Gz8M1d5.png)

## Table of contents

- [Dependencies](#dependencies)
  - [GNU Octave](#gnu_octave)
  - [Packages](#packages)
  - [Data](#data)
- [How to Use](#how_to_use)
- [References](#references)

## Dependencies

### GNU Octave
```
$ sudo apt install octave
```

### Packages
Ran within GNU Octave
```
$ pkg install -forge signal control outliers io struct statistics optim data-smoothing
$ pkg load signal control outliers io struct statistics optim data-smoothing
```

### Data
Data must be taken from a PPG sensor for 60 seconds.

## How to Use
Run within GNU Octave
```
$ cd /DataAnalyticsProject1
$ getPeaks
```

## References

- [FindPeaks Functionality](https://octave.sourceforge.io/signal/function/findpeaks.html)
- [List of Packages Used](https://pastebin.com/K6m1ukL7)
