From: don.brown@codethink.com (Don Brown)
Date: Wed, 15 Feb 2017 17:37:45 -0500
Subject: [cip-dev] Update on CIP Testing Platform using KernelCI and LAVA
Message-ID: <6a99d98d9167de5bd7ab2230071a380a@codethink.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Everyone,

I am writing to give you an update on where we stand with the Civil 
Infrastructure Platform (CIP).

As many of you know, we are using KernelCI for the Continuous 
Integration component and LAVA v2 for the kernel Testing platform. 
KernelCI performs the kernel builds against specific configurations and 
can verify boots and SOC's as well. LAVA provides the testing framework 
& infrastructure. Both come with complete results reporting to document 
what went wrong in the build, deployment or testing portion with a great 
level of granularity.

Where We Stand:
We have successfully merged the KernelCI VM and the LAVA Server VM into 
a single Virtual Machine.[1] We have KernelCI creating builds of the CIP 
Kernel [2] and we have LAVA running health-check tests in qemu. We are 
very close to having the health-check running on the Beaglebone Black, 
but we've had some trouble getting it communicating properly.

We expect to release the platform as a Beta version for the Embedded 
Linux Conference. The two original tutorials have been merged into one 
and can be found on the CIP Wiki.[3]


Links:

[1] CIP Testing Platform (Board-at-Desk-Single-Developer): 
https://gitlab.com/cip-project/board-at-desk-single-dev

[2] The CIP Kernel: https://gitlab.com/cip-project/linux-cip

[3] Tutorial: Board-at-Desk-Single-Developer KernelCI & LAVA VM Setup & 
Configuration: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/testinglavav2vmsetup


-- 
Don Brown
Codethink, Ltd.
Software Engineering Consultant
Indianapolis, IN USA
Email: don.brown at codethink.co.uk
Mobile: +1 317-560-0513
