From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Wed, 20 Mar 2019 13:29:51 +0000
Subject: [cip-dev] Arm64 configs
Message-ID: <TYAPR01MB2285078E1883115EAF97B917B7410@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello maintainers, all,

As discussed previously we need to decide what Kernel configs to use/support for the arm64 architecture.

Arm64 only has one supported config upstream - "defconfig" [1]. This is huge and presumably something CIP doesn't want to support in its entirety in the linux-4.19.y-cip for the next 10 years.

The alternative is for CIP create our own cut down defconfig(s) that meet the requirements of our users/members.

>From a Renesas point of view there is an out-of-tree renesas-defconfig [2] which our upstream team uses to aid their development on Renesas arm64 platforms. Perhaps we could either add this to the CIP tree, or to the CIP Kernel configs repository [3] as a starting point?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm64/configs/defconfig?h=linux-4.19.y-cip
[2] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git/tree/arch/arm64/configs/renesas_defconfig?h=devel
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config

Kind regards, Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190320/62e886db/attachment-0001.html>
