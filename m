From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Sat, 27 Jul 2019 21:29:09 +0000
Subject: [cip-dev] powerpc build with Kernel v4.4
Message-ID: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I'm trying to build the toshiba_defconfig [1] for the powerpc architecture using the CIP v4.4 Kernel but I'm hitting some problems. The log from the build can be seen on GitLab [2].

Has anyone tried building this configuration recently?

I'm using gcc compiler v8.1.0. I mention this because I've see a half-related discussion [3] when Googling. From this mail thread I wonder if there are some patches we need to backport?


[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.4/powerpc/toshiba_defconfig
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/260410825
[3] https://lkml.org/lkml/2019/2/27/106

Kind regards, Chris
