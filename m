From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai Ndungu)
Date: Mon, 18 Mar 2019 17:41:31 +0000
Subject: [cip-dev] Testing Dependencies
Message-ID: <OSBPR01MB205553CE1E094E76BF4E681FE9470@OSBPR01MB2055.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

Some dependencies will be required by some tests. As discussed in the TSC meeting today, there are a few options on how to do this:

1) All the package dependencies for all tests included in one CIP-Core filesystem
2) Install the dependency packages during the test (this will require a package manager in the RFS, and an internet connection to the device under test)
	- Static packages binaries could be stored on S3 bucket

There are 2 different types of dependencies. First, the test might require specific packages to be installed in the filesystem. Secondly, a test might require a test file/binary to run (eg. kselftests, ltp tests).
Linaro store static test binaries (such as cross-compiled kselftests) on a server, and download these during a test (in the test script). They also download and install packages (using apt-get) during the test.

Are there any preferences in which of the above options to use?
	- We have to bear in mind, not all labs may provide an internet connection to the boards

Are there any package managers that should be included in CIP-Core? (apt-get, pip, yum, dpkg etc.)

Any other comments?

Kind Regards,
Patryk
