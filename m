From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 19 Sep 2019 22:50:44 +0000
Subject: [cip-dev] CI testing for LTS release candidates
Message-ID: <OSBPR01MB228020E2379B1C958F4B4426B7890@OSBPR01MB2280.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I've put together a prototype for a way to automatically build/test Greg's work on the stable branches.

Workflow:
1) Greg announces a new review cycle for one of the stable branches. As part of this he pushes the patches to the linux-stable-rc repository[0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

2) This repository is mirrored in CIP's GitLab account, currently in cip-playground[1].
Why do we need this mirror? So I can add some webhooks.
I guess in time we can move this mirror to the 3rd-party subgroup[2].

[1] https://gitlab.com/cip-playground/linux-stable-rc
[2] https://gitlab.com/cip-project/3rd-party

3) When the GitLab mirror updates and pulls in the new patches, it triggers a webhook (for the branches we care about) that in turns triggers the CI builds and tests as defined in the linux-stable-rc-ci repository[3].
Why the need for the linux-stable-rc-ci repository? Because if we add .gitlab-ci.yml files to our linux-stable-rc mirror the mirror will stop working. And obviously Greg isn't going to start accepting our .gitlab-ci.yml files ?

[3] https://gitlab.com/cip-playground/linux-stable-rc-ci

Note:
There will be considerably less testing we can run as not all platforms are available in LTS - support has been added directly to the CIP Kernels.
Perhaps we should look into doing more testing in QEMU.

Things left to do:
- Add documentation/licences etc.
- Work out a way to easily see what has been built (at the moment the only way to see what Kernel version was actually built is to go into the build logs).
- Work out a way to notify CIP about successful/failed builds (emails/KernelCI).
- Decide what configurations we want to build, and what tests we want to run. 

Greg pushed new release candidates (Linux 4.4.194-rc1 and Linux 4.19.75-rc1) about an hour ago. These have already been picked up and tested with the usual CIP configurations.
CI Pipelines: Linux 4.4.194-rc1 [4], Linux 4.19.75-rc1[5].

[4] https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/83302432
[5] https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/83302080

I welcome your thoughts/feedback before I get too invested in the above approach!

Kind regards, Chris
