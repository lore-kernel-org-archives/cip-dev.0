From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 10 Nov 2017 11:35:38 +0900
Subject: [cip-dev] Kselftest use-cases - Shuah Khan
In-Reply-To: <1510076630.2465.35.camel@codethink.co.uk>
References: <1510076438.2465.31.camel@codethink.co.uk>
	<1510076630.2465.35.camel@codethink.co.uk>
Message-ID: <00cd01d359cc$98741060$c95c3120$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,
# I added the fuego mailing list to Cc

Thanks for the notes!

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> Sent: Wednesday, November 08, 2017 2:44 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Kselftest use-cases - Shuah Khan
> 
> ## Kselftest use-cases - Shuah Khan
> 
> [Description](https://osseu17.sched.com/event/CnFp/)
> 
> kselftest is the kernel developer regression test suite.  It is
> written by kernel developers and users.  It is used by developers,
> users, automated test infrastructure (kernel-ci.org, 0-day test
> robot).

It also works on Fuego now!
# Thanks Tim for integrating my patches.

> How to run tests:
> 
> * `make --silent kselftest` - run all default targets
>   (`TARGETS` in `tools/testing/selftests/Makefile`).
> * `make --silent TARGETS=timers kselftest` - run all
>   non-destructive tests in `tools/testing/selftests/timers`
> * `make --silent -C tools/testing/selftests/timers run_tests`
>   - same

In Fuego we use a different approach. First we cross-compile and install
the tests on a temporary folder. At this stage a script called "run_kselftest.sh"
is generated. Then, we deploy the binaries and the script to the target where
the "run_kselftest.sh" script is invoked.

The good part of this approach is that Fuego does not require the target board
to have a toolchain installed, kernel source on the target, etc.
 
> Set `O=dir` for an out-of-tree build.  (But cureently this
> may require a `.config` file in the source directory.)
> 
> Set `quicktest=1` to exclude time-consuming tests.
> 
> kselftest outputs a summary of results (since 4.14) following
> TAP (Test Anything Protocol).

Actually I think that this was proposed by Tim. 
There is a TAP plugin for Jenkins that can be used for parsing the results in Fuego.
However, currently "run_kselftest.sh" doesn't seem to use the TAP format. humm..
Maybe this is on the TODO list upstream, I need to investigate it further.
 
> The output of individual tests can be found in `/tmp` (currently),
> but it should be changed to allow specifying directory.
> 
> It is possible to run latest selftests on older kernels, but there
> will be some failures due to missing features.  Ideally missing
> dependencies result in a "skip" result but some maintainers aren't
> happy to support that.  One reason is that if a feature is broken so
> badly it isn't detected, tests may be skipped rather than failed.

In Fuego there is now full control for specifying which test cases
are allowed to fail and which not. I will enable that functionality
on Fuego's integration scripts.

> Some tests apparently check for dependencies in a kernel config file.
> (It wasn't clear to me where they look for it.)

On some kselftest folders there is a "config" file that specifies the kernel
configuration options that need to be enabled (or disabled). From what I see
there is not a general script to check that they are configured on
the target kernel.

Fuego does support checking kernel configuration before running the test (using
information from /proc/config.gz or /boot/config-`uname -r`). Maybe it would a good
idea to add support on Fuego for checking individual kselftest's config files
 
Thank,
Daniel

> Tips and hints:
> 
> * Use the `--silent` option to suppress make output
> * Some tests need to run as root
> * Beware that some tests are disruptive
> 
> More information:
> 
> * [Documentation/dev-tools/kselftest.rst](https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html)
> * [Blog entries](https://blogs.s-osg.org/author/shuahkh/)
> 
> 
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
