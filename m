Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C00C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 09:43:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.98181.1747215792653558106
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 02:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: yltShOAKQ0mOJ3gmgmVa2g==
X-CSE-MsgGUID: qCiARrFQQga4EFugnYaMcg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 May 2025 18:43:10 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3989240A9339;
	Wed, 14 May 2025 18:43:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Ulrich Hecht <uli@fpond.eu>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH RESEND 4.4.y-cip] ARM: shmobile: smp: Enforce shmobile_smp_* alignment
Date: Wed, 14 May 2025 10:43:08 +0100
Message-ID: <20250514094308.60634-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 09:43:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18905

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
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
Note,
- Just resending the patch with Reviewed-by from Pavel and Iwamatsu-san.
- This patch needs applying for 4.4.y-cip only
- Patch previoulsy posted https://patchwork.kernel.org/project/cip-dev/patch/20250404095757.58956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 arch/arm/mach-shmobile/headsmp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index cef8e8c555f84..49df98d8b459b 100644
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
2.43.0


