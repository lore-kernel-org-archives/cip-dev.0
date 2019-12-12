From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 12 Dec 2019 16:02:03 +0000
Subject: [cip-dev] Add CONFIG_IGB to
Message-ID: <TYAPR01MB22855636F95B0A1706815692B7550@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Smita, all,

I've submitted a pull request[0] that sets CONFIG_IGB to 'y' in siemens_ipc227e_defconfig.

The reason behind this is so that the Kernel will boot/mount the RFS when using a bzImage in our CI setup.
See [1] for a test run without this option. [2] shows a run with this option.

Please let me/the Kernel maintainers know if you have any feedback for this.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/merge_requests/17
[1] https://lava.ciplatform.org/scheduler/job/8141
[2] https://lava.ciplatform.org/scheduler/job/8267

Kind regards, Chris
