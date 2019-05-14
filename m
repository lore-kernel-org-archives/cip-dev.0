From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 14 May 2019 13:00:05 +0000
Subject: [cip-dev] RZ/G2E board now available in lab-cip-renesas
Message-ID: <TYAPR01MB2285114F9B6C4D8EECE29E65B7080@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

We have now added an Arm64 based RZ/G2E Si-Linux development platform (r8a774c0-ek874) to CIP's LAVA lab [1].

This means that authorised users can now run tests using the CIP v4.19 Kernel on actual hardware.

Please see job #1269 [2] for an example, which uses linux-4.19.y-cip [3] built with renesas_defconfig [4].

Let me know if anyone needs a hand with their testing.

[1] https://lava.ciplatform.org/scheduler/worker/lab-cip-renesas
[2] https://lava.ciplatform.org/scheduler/job/1269
[3] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-4.19.y-cip&id=e2a020d7b8887f395d139e94324ff7b7286ac681
[4] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.19/arm64/renesas_defconfig

Kind regards, Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190514/dd7b60c7/attachment.html>
