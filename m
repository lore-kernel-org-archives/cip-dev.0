Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C1C5DF8E
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:02 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7158.1787318218801681058
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:16:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=CR5rc01B;
 spf=pass (domain: renesas.com, ip: 52.101.229.67, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKbf+3IpKrR4YeKw6GR9sjydr22cTEGZ3d8XzlGHHttlSDjLANIb6hWVoCaRLxUDyjeBab05AbC5rNuSwdcejpv+r0eq6lIGWQ6Zb/Q6RHApn/2NEm7r56JZrkFfiGx4LOGEIfV8+6kmVeyTBAuh4bIRXyHmxMJC3OOfeUMvVC+J5FPONLi1rnjLJ/ybvM/Mt6YCwnWDLxeipIMyjx+cjWiLXSqW5PSar1OxWZlYI/VY3/HlOuUco6jw0ksYFeAEYOzdPUX/zMB2z/X5NRaDxa97K9pnvSxnZ5UtPr7f6q+qORmYF6JXLXLcfgFtgnJP2+gNAndJmjAnHLq4sf6PtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHz71ZUTtsx4vxZcPNJIMutsRp3BYfxOvntfP7OclVs=;
 b=mCEfU1znXXd62ZKmH0qyUIBMPlpxsShgZmOCD1/5+Nvn7hnO4TE5NvQ8E0TBmuepfThCobcNOwycNWD8jOD5WtdhcVVb40fJpErWQaNZpGMyRfn8CAeDW0b2rnxgF+fC7uy4bTyRcg5p+poUVZpnHIUo73i0cHQc8Qq7T0sVjjDG9xHXUAVUVRyxWfd4EsVFpqsWPVpERq10NEU6xfj/PWJiNucHh8hg3TWzimLLNKTbPMxGeDm2S+KGrsogWU5coMKnGP17qsx+dqbnZIsJhe4HZLZaPkKK2oezqfrIhLuSB+NAkJqsdeCaXPtmjqla0s8IbPi1w03N2/ZrRUXgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHz71ZUTtsx4vxZcPNJIMutsRp3BYfxOvntfP7OclVs=;
 b=CR5rc01BU3v7SE2WIQnkRiDhh0Z81dUtrhnGoJGBF0ixNXWP2Tb5wCpdrUbjXVjORNQ6ddnVFTkZex2IolVUemaRlDY0EnZS5qKgGxYMWJMkeSDMvDz/xD15Tx9WeYQdetGG086E+yNwukPT3jzsnFZnjIn6Q1n9WCDodJbaRu4=
Received: from OS7PR01CA0251.jpnprd01.prod.outlook.com (2603:1096:604:24b::8)
 by OSCPR01MB13063.jpnprd01.prod.outlook.com (2603:1096:604:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:16:51 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::32) by OS7PR01CA0251.outlook.office365.com
 (2603:1096:604:24b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:50 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 60095300037D;
	Fri, 21 Aug 2026 22:16:49 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 02/18] clk: renesas: cpg-mssr: Handle RZ/T2H register layout in PM callbacks
Date: Fri, 21 Aug 2026 16:15:38 +0300
Message-ID: <20260821131554.638741-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OSCPR01MB13063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd75cf77-fb40-4224-5905-08deff86763e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Z9BiVGAZqTTT6kuX78MfK/+N5gnxKmuGGMBMSX6x81C/LRHe9Eg+f3OyQbJdURM0YjkFxlVtBs7ClINJWjJJhNYUmynyI8J/eC3lOjZmsRoEtyyx5tLUnq5r2c6yfhgjXRctx8IX9uVbL1A0J6W/z7ORkQx2MTaTW7YX0ASEcozGPfLyni8L4zboPgG5Wx7moGS7Eh87njDMfltydwmsuOjf5p9fG9BvZxibzD3RlNVD/Gpz0ScUFZGiezqTg36C03MK456xgeaTWH8oKW5c5CctLAnvKNf5UO4bF+Vr+rShv2+4zyU5FucF5I/oQvMd/mLHku+wAk+1TKGuISrNCou6VGPwHm65y76x+UEC7TuQEcvHK9jIHXcc+PPYnuPraZAV0MAG6Viy5UeVAdf7WKS9/XTDdGxbvUxy5klZ6iAMrt14wsxKk2LCkflAZdCKE85GneUvv8J2PuFZmoscs0dxUI6USwU4vJdcqUa+MqgEkWnuhI48S9Rl0WrMcKMlkqMk694vw/Ffj09A9BBLtmnz6j+o8IOnk1jCIYagfo0REAkAJO549OJUWyH0BsqrliArGcP4Ca/ycPYgGfQJG/0JicBBshD7NolzAT91mtTQlJ/JJzNltw8SzZuPGBFmH/HKUdNf9O05eZ1sdRxnYQH+vkm5xdDkefhVyFWSNnk=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	vwVOt2KqAWyA8Cl03QgJOdXWxOTB7yFQT6OfUbXjvVH3m7s5ZiOYnOFcHE/MSqcwiPzqq/rFKS4Rt3W2BWwQFS3C4Y3JZcOTkKoBQbI0TfqFc/4blibxR1Q6snEEt5mKB0BW46GqfHVs8Df5wClYJhomEG4Gkvlk8zJM9WfzDUfT39OrGkj1EGggB3z3ZCUYCRJj6hVPfWAW0kuEFWlWtPLRBWiQxPM4+lRw0A2mpi+TKiJRJkU0RhwCCW3HuIq0BHqbyAbcg1cc8fdF0fZv48WxEfJifEy1g+Hh7j2CfcxERCvi9jYpxvCGESjYMITpAeyvRtAFY9hRKcQKq313wi6CucFjdFMxe1U9ekNQuw0H1cnFDVaw1F7CwFxv+HDl9kEp8Wswg8XOFKp1OAKVq2g88kfLoH1bLFK9t7/VCN162mLQNptfNYpWETuB64et
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:50.7039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd75cf77-fb40-4224-5905-08deff86763e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13063
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23960

commit 3132ec8c8c2c28787d0ad80e53db296713155f12 upstream.

The register layout for RZ/T2H is not handled inside
cpg_mssr_suspend_noirq() and cpg_mssr_resume_noirq(), causing a memory
abort because the wrong code path is taken, as shown below.

Explicitly handle the RZ/T2H register layout in cpg_mssr_suspend_noirq()
and cpg_mssr_resume_noirq(), similar to how it is done inside
cpg_mstp_clock_is_enabled() and cpg_mstp_clock_endisable().

[   90.052296] Mem abort info:
[   90.055420]   ESR =3D 0x0000000096000007
[   90.059553]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   90.065697]   SET =3D 0, FnV =3D 0
[   90.069211]   EA =3D 0, S1PTW =3D 0
[   90.072834]   FSC =3D 0x07: level 3 translation fault
[   90.078109] Data abort info:
[   90.081405]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[   90.087427]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   90.093169]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   90.099008] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000c60b40=
00
[   90.106756] [ffff800082816318] pgd=3D0000000000000000, p4d=3D10000000c69=
ef003, pud=3D10000000c69f0003, pmd=3D100000024002b403, pte=3D00000000000000=
00
[   90.120727] Internal error: Oops: 0000000096000007 [#1]  SMP
[   90.127058] Modules linked in: sha256 cfg80211 spi_nor at24 renesas_usbh=
s bluetooth ecdh_generic ecc rfkill rzt2h_adc spi_rzv2h_rspi industrialio_a=
dc gpio_keys fuse drm backlight ipv6
[   90.145201] CPU: 0 UID: 0 PID: 307 Comm: sh Not tainted 6.18.0-rc1-next-=
20251016+ #47 PREEMPT
[   90.155006] Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m4=
4 (DT)
[   90.163041] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   90.170777] pc : cpg_mssr_suspend_noirq+0x4c/0xc0
[   90.175983] lr : device_suspend_noirq+0x6c/0x22c
[   90.181309] sp : ffff8000838d3af0
[   90.185026] x29: ffff8000838d3af0 x28: ffff8000825c016f x27: ffff8000825=
c01a0
[   90.192973] x26: ffff8000809feeec x25: ffff8000827bebb8 x24: 00000000000=
00002
[   90.200815] x23: ffff8000825c0190 x22: 0000000000000002 x21: 00000000000=
00000
[   90.209058] x20: ffff8000827bebb8 x19: ffff000180128010 x18: ffff00033ef=
92a80
[   90.217100] x17: ffff000180051700 x16: 0000000000000001 x15: ffff000187a=
fc310
[   90.224847] x14: 0000000000000254 x13: 0000000000000001 x12: 00000000000=
00001
[   90.232793] x11: 00000000000000c0 x10: 0000000000000ab0 x9 : ffff8000838=
d38b0
[   90.240540] x8 : ffff000186387410 x7 : 0000000000000001 x6 : 00000000000=
00000
[   90.248600] x5 : ffff0001803240d4 x4 : 0000000000000003 x3 : ffff0001803=
240d0
[   90.256460] x2 : ffff800082816318 x1 : 000000000000000c x0 : ffff0001803=
24000
[   90.264208] Call trace:
[   90.267019]  cpg_mssr_suspend_noirq+0x4c/0xc0 (P)
[   90.272450]  device_suspend_noirq+0x6c/0x22c
[   90.277375]  dpm_noirq_suspend_devices+0x1a8/0x2a0
[   90.282902]  dpm_suspend_noirq+0x24/0xa0
[   90.287428]  suspend_devices_and_enter+0x310/0x590
[   90.292790]  pm_suspend+0x1b4/0x200
[   90.296811]  state_store+0x80/0xf4
[   90.300676]  kobj_attr_store+0x18/0x34
[   90.305002]  sysfs_kf_write+0x7c/0x94
[   90.309232]  kernfs_fop_write_iter+0x12c/0x200
[   90.314115]  vfs_write+0x240/0x380
[   90.318041]  ksys_write+0x64/0x100
[   90.321862]  __arm64_sys_write+0x18/0x24
[   90.326013]  invoke_syscall.constprop.0+0x40/0xf0
[   90.331445]  el0_svc_common.constprop.0+0xb8/0xd8
[   90.336554]  do_el0_svc+0x1c/0x28
[   90.340375]  el0_svc+0x34/0xe8
[   90.343900]  el0t_64_sync_handler+0xa0/0xe4
[   90.348426]  el0t_64_sync+0x198/0x19c
[   90.352609] Code: 8b040042 b9409004 7100049f 54000240 (b9400042)
[   90.359639] ---[ end trace 0000000000000000 ]---

Fixes: 065fe720eec6 ("clk: renesas: Add support for R9A09G077 SoC")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251127145654.3253992-3-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/r=
enesas-cpg-mssr.c
index fee13c0bc095..1b505de9dcd3 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1086,11 +1086,19 @@ static int cpg_mssr_suspend_noirq(struct device *de=
v)
=20
 	/* Save module registers with bits under our control */
 	for (reg =3D 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
-		if (priv->smstpcr_saved[reg].mask)
-			priv->smstpcr_saved[reg].val =3D
-				priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_A ?
-				readb(priv->pub.base0 + priv->control_regs[reg]) :
-				readl(priv->pub.base0 + priv->control_regs[reg]);
+		u32 val;
+
+		if (!priv->smstpcr_saved[reg].mask)
+			continue;
+
+		if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_A)
+			val =3D readb(priv->pub.base0 + priv->control_regs[reg]);
+		else if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H)
+			val =3D cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
+		else
+			val =3D readl(priv->pub.base0 + priv->control_regs[reg]);
+
+		priv->smstpcr_saved[reg].val =3D val;
 	}
=20
 	/* Save core clocks */
@@ -1121,6 +1129,8 @@ static int cpg_mssr_resume_noirq(struct device *dev)
=20
 		if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_A)
 			oldval =3D readb(priv->pub.base0 + priv->control_regs[reg]);
+		else if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H)
+			oldval =3D cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
 		else
 			oldval =3D readl(priv->pub.base0 + priv->control_regs[reg]);
 		newval =3D oldval & ~mask;
@@ -1134,6 +1144,12 @@ static int cpg_mssr_resume_noirq(struct device *dev)
 			readb(priv->pub.base0 + priv->control_regs[reg]);
 			barrier_data(priv->pub.base0 + priv->control_regs[reg]);
 			continue;
+		} else if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H) {
+			cpg_rzt2h_mstp_write(priv, priv->control_regs[reg], newval);
+			/* See cpg_mstp_clock_endisable() on why this is necessary. */
+			cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
+			udelay(10);
+			continue;
 		} else
 			writel(newval, priv->pub.base0 + priv->control_regs[reg]);
=20
--=20
2.55.0


