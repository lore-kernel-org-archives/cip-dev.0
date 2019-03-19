From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 19 Mar 2019 00:50:07 +0000
Subject: [cip-dev] Testing Dependencies
In-Reply-To: <OSBPR01MB205553CE1E094E76BF4E681FE9470@OSBPR01MB2055.jpnprd01.prod.outlook.com>
References: <OSBPR01MB205553CE1E094E76BF4E681FE9470@OSBPR01MB2055.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB37637BF6E9C90C5766CC048ED0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Patryk,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of Patryk
> Mungai Ndungu
> Sent: Tuesday, March 19, 2019 2:42 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Testing Dependencies
> 
> Hello,
> 
> Some dependencies will be required by some tests. As discussed in the TSC meeting today, there are a few
> options on how to do this:
> 
> 1) All the package dependencies for all tests included in one CIP-Core filesystem

This can't always be achieved. For example, Deby v1 does not have many recipes.
Having said that, if Deby v2 becomes perfectly compatible with Yocto/OE, adding tests to the image will get easier.

> 2) Install the dependency packages during the test (this will require a package manager in the RFS, and an
> internet connection to the device under test)

This works well for the generic profile, but not for the tiny profile.

3)
> 	- Static packages binaries could be stored on S3 bucket

This option should work for both profiles.

- Other options:
4) Prepare a multi-node job where one node (actually a LXC container) contains Fuego. This is being developed by Linaro at the moment.
5) We can just use or create our own shell scripts for testing the basic behavior of most commands. There are a few test definitions in Fuego that can be easily adapted.

> There are 2 different types of dependencies. First, the test might require specific packages to be installed in the
> filesystem. Secondly, a test might require a test file/binary to run (eg. kselftests, ltp tests).
> Linaro store static test binaries (such as cross-compiled kselftests) on a server, and download these during a test
> (in the test script). They also download and install packages (using apt-get) during the test.
> 
> Are there any preferences in which of the above options to use?
> 	- We have to bear in mind, not all labs may provide an internet connection to the boards

I prefer to separate the test build step from the test run step.
The test build step can be a combination of:
- tests and dependencies installed in the image
- tests built using the SDK (cross-compiled)

> Are there any package managers that should be included in CIP-Core? (apt-get, pip, yum, dpkg etc.)

In ISAR, apt-get should be installed by default.
Deby v1 does not support apt-get. It supports dpkg, but almost a tar xzvf

> Any other comments?

Yes, I think we should clarify two things:

- What type of problems we want to find
  - Option 1: regressions. In this case, we can use always the same tests and test versions
  - Option 2: bugs. In this case, it is important to update the test version (e.g. run the latest LTP) continuously.
- What we want to test
  - Kernel regressions: LTP (including OpenPOSIX), kselftests, iperf3, IOZone, rt-tests, xfstests..
  - Kernel 0-day bugs: we need a fuzzy tool such as syzkaller
  - Black-box regression testing (busybox, findutils, etc..): custom shell scripts should be enough

In my opinion, we should focus on regression tests only.
#Although updating the LTP version from time to time might be important.

Thanks,
Daniel
