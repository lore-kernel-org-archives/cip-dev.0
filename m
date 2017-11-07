From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:43:50 +0000
Subject: [cip-dev] Kselftest use-cases - Shuah Khan
In-Reply-To: <1510076438.2465.31.camel@codethink.co.uk>
References: <1510076438.2465.31.camel@codethink.co.uk>
Message-ID: <1510076630.2465.35.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

## Kselftest use-cases - Shuah Khan

[Description](https://osseu17.sched.com/event/CnFp/)

kselftest is the kernel developer regression test suite.??It is
written by kernel developers and users.??It is used by developers,
users, automated test infrastructure (kernel-ci.org, 0-day test
robot).

How to run tests:

* `make --silent kselftest` - run all default targets
? (`TARGETS` in `tools/testing/selftests/Makefile`).
* `make --silent TARGETS=timers kselftest` - run all
? non-destructive tests in `tools/testing/selftests/timers`
* `make --silent -C tools/testing/selftests/timers run_tests`
? - same

Set `O=dir` for an out-of-tree build.??(But cureently this
may require a `.config` file in the source directory.)

Set `quicktest=1` to exclude time-consuming tests.

kselftest outputs a summary of results (since 4.14) following
TAP (Test Anything Protocol).

The output of individual tests can be found in `/tmp` (currently),
but it should be changed to allow specifying directory.

It is possible to run latest selftests on older kernels, but there
will be some failures due to missing features.??Ideally missing
dependencies result in a "skip" result but some maintainers aren't
happy to support that.??One reason is that if a feature is broken so
badly it isn't detected, tests may be skipped rather than failed.

Some tests apparently check for dependencies in a kernel config file.
(It wasn't clear to me where they look for it.)

Tips and hints:

* Use the `--silent` option to suppress make output
* Some tests need to run as root
* Beware that some tests are disruptive

More information:

* [Documentation/dev-tools/kselftest.rst](https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html)
* [Blog entries](https://blogs.s-osg.org/author/shuahkh/)


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
