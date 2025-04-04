Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B4C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 09:58:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7562.1743760682219174603
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 02:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: NcWNM2aSQ3mvEBgzlI4nwg==
X-CSE-MsgGUID: kSeQxAqPQq+PclwJ1OIYnw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2025 18:58:00 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB2824241EB0;
	Fri,  4 Apr 2025 18:57:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce shmobile_smp_* alignment
Date: Fri,  4 Apr 2025 10:57:57 +0100
Message-ID: <20250404095757.58956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 09:58:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18479

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 379c590113ce46f605439d4887996c60ab8820cc upstream.

When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
bring-up fails:

    smp: Bringing up secondary CPUs ...
    CPU1: failed to come online
    CPU2: failed to come online
    CPU3: failed to come online
    smp: Brought up 1 node, 1 CPU

Fix this by adding the missing alignment directive.

Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss")
Closes: https://lore.kernel.org/r/CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.1741612208.git.geert+renesas@glider.be
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Note:
- This issue has been replicated on 4.4-cip with older compilers and
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
- The offending commit 4e960f52fce16a3b is not present in v4.4 release
so this patch wont be backported into 4.4-cip by stable hence just sending
this for 4.4-cip only. Please note this patch has been cherry-picked v6.14
release.

Cheers, Prabhakar
---
 arch/arm/mach-shmobile/headsmp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index cef8e8c555f8..49df98d8b459 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -139,6 +139,7 @@ ENDPROC(shmobile_smp_sleep)
 	.long	shmobile_smp_arg - 1b
 
 	.bss
+	.align	2
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
 	.space	NR_CPUS * 4
-- 
2.25.1


