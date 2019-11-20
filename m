From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Wed, 20 Nov 2019 10:27:44 +0530
Subject: [cip-dev] [PATCH 4.19 000/422] 4.19.85-stable review
In-Reply-To: <20191119181619.GB2283647@kroah.com>
References: <20191119051400.261610025@linuxfoundation.org>
 <TYAPR01MB22854E4F20C28F3A10DA65E3B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119122909.GC1913916@kroah.com>
 <TYAPR01MB228560FC98FFD1D449FA4EC2B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119154839.GB1982025@kroah.com>
 <TYAPR01MB2285698B8E0F38B9EEF47128B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119165207.GA2071545@kroah.com> <20191119180002.GA17608@roeck-us.net>
 <20191119181619.GB2283647@kroah.com>
Message-ID: <CA+G9fYufKfsvtHHTmc+yODAeqhE4qego2R3Kd3V=4kr301M9fA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 19 Nov 2019 at 23:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
>
> Ok, I've now done just that, and pushed out a -rc4.

Results from Linaro?s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.85-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: d0112da1f7e63d8c9a40263ced73eb673177a053
git describe: v4.19.84-420-gd0112da1f7e6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.84-420-gd0112da1f7e6

No regressions (compared to build v4.19.84)

No fixes (compared to build v4.19.84)

Ran 23846 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests

-- 
Linaro LKFT
https://lkft.linaro.org
