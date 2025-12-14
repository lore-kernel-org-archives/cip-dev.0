Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4962ED5B177
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24256.1765714250224472620
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:10:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LkKuib0V;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7a72874af1so410072666b.3
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714248; x=1766319048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+MNKAIMXw6V3h6Yc9Htj+AEHYGpG/D0Ak4MzSQOetY=;
        b=LkKuib0VCB31SrWvPBGZxGMCedjm+7x2Pz509exx6ObXv6gulhSpof5GbPQ2EMbBOw
         jjcC7BljfpBlXdtlD3pAkAAFRZWk7f4qsvImwI1RRi+XVhPWvxa1RplH7bUhSaqwTnOh
         ocnmxZHSpLMA6xLOYinxK8q0Tnzz/ZmD6jX2bB3dDRbGIGPrjKDS7sGt7ScARmiCuJpO
         jgWHJpur/TSOt+EgaVI1WLCg5AyijO/6DqZuphLv6PkCI8d9qSSKZfWZztCCIXsaKxyJ
         2XGl5OPehhAHwfNmhGCxukvu9Lb7k9BgGpD9NI/EkHcS4p6cMhPyeHts5ZGYxsTfUfnF
         cxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714248; x=1766319048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+MNKAIMXw6V3h6Yc9Htj+AEHYGpG/D0Ak4MzSQOetY=;
        b=iYShF8HfzlypIInzPae2sjScxzCiZtOl8zBddH+h3LTlalXPrHFuogPLsGzSCL1lPH
         ZCq+dOelyh591S8LpU8u9PFVIKH7qSqV+JI6+9VUTNwiuFTMkRfgA21oZrqLuIoHijCw
         eN1Zd8DUo0rnA0uavL1fkR7S8gYEMDN40Fvf8D8apfKEpZcmR/wTrqxc74RErENIWFa/
         rymsm/6rbv9tNwp2aDYhsgLccSDCWXXdCWncIuFKIg8Rnhzgr5VA0SLrk7oQ+9ms/xZR
         Z23Zd592hzoYGqYTqJKF0svqFlUnlElaWDU8wB2Vxjo965eqqiY13hTgbzeYPWwmyT6y
         WdKw==
X-Gm-Message-State: AOJu0YxSiKeWEQ8ScHvlbmFZvPGSan5c8/7pmAIeApDX8TbmI7z1kiJ6
	Y0bmRGTRIY20jA8/OIuj1xruKe5LKNugVnSYwhspGFJzJ6PwJfw7rz39lw7Q0Q==
X-Gm-Gg: AY/fxX4ZmCm8QR5mW59wCDe9GhJJcOa8LthdpaqCL64ySFRwGHiex+8+sFp1SQsvez+
	cE0Ltz2XyS/Dv3AF9laOBSaM9XoHf0lGbBU04t8ejsoa0RgVzHwz7Tr1oXclDEkQfKT+frtHlGq
	oPoceRyVI974Ta38X+wnYaHqXYhmQwVNc+NztrK0yOvwVy3YAuQEWtTVkuHmLFjbpsqo4FtOuoH
	UQwmbN134DMZhHiix9WA9MTQl0chQVeeyrpVCaTEv5Etem6kFdQbK0NmAm8Eh7IdKcWMvzyT1MF
	p21MGfCBN1I93pFp3PQKdTBCji7grPrE1DrpJAzzFyf6PlyDlH3LvYiZYJvAJUkIv82DTsaTDcp
	CArUys4oeM1dmKt+PGoGd7T5d5YDqoBg8pTd8NgkPpPzNPjrfwWoRIq9Ju9jMnW/FMXbAq0y+Zg
	D1tVXyz9CRUTYEK+Nh+8lsubmw0fJnBqwuZcLx214egN7kQV8SyAm+/aE88rnRber8XYDoo6rWa
	HJM62jjJw==
X-Google-Smtp-Source: AGHT+IGqdUVJQHh40oQUU+T144Hlxry/fFUPMk0km56hcFNAlpSp+F8qNe1HzWx6ik/IiRpaceGClg==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47a8f8cdfd1mr105481495e9.16.1765713794620;
        Sun, 14 Dec 2025 04:03:14 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4ef38bsm137055175e9.0.2025.12.14.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:03:14 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks
Date: Sun, 14 Dec 2025 12:03:12 +0000
Message-ID: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21022

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 72b4612af36fec844857415f14fd07126dc4499a ]

Add PM suspend/resume callbacks for RZ/G3E SMARC EVK.

The PM deep entry is executed by pressing the SLEEP button and exit from
entry is by pressing the power button.

Logs:
root@smarc-rzg3e:~# PM: suspend entry (deep)
Filesystems sync: 0.115 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.002 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
printk: Suspending console(s) (use no_console_suspend to debug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-162-g7148ba838
NOTICE:  BL2: Built : 14:23:58, Jul  5 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
renesas-gbeth 15c30000.ethernet end0: Link is Down
Disabling non-boot CPUs ...
psci: CPU3 killed (polled 0 ms)
psci: CPU2 killed (polled 0 ms)
psci: CPU1 killed (polled 0 ms)
Enabling non-boot CPUs ...
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
CPU1 is up
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
CPU2 is up
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
CPU3 is up
dwmac4: Master AXI performs fixed burst length
15c30000.ethernet end0: No Safety Features support found
15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
15c30000.ethernet end0: configuring for phy/rgmii-id link mode
dwmac4: Master AXI performs fixed burst length
15c40000.ethernet end1: No Safety Features support found
15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
15c40000.ethernet end1: configuring for phy/rgmii-id link mode
OOM killer enabled.
Restarting tasks: Starting
Restarting tasks: Done
random: crng reseeded on system resumption
PM: suspend exit

15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
root@smarc-rzg3e:~# ifconfig end0 192.168.10.7 up
root@smarc-rzg3e:~# ping 192.168.10.1
PING 192.168.10.1 (192.168.10.1) 56(84) bytes of data.
64 bytes from 192.168.10.1: icmp_seq=1 ttl=64 time=2.05 ms
64 bytes from 192.168.10.1: icmp_seq=2 ttl=64 time=0.928 ms

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250717071109.8213-1-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
index 8bd554bf94f9..2f1ddaa2c6e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -136,6 +136,7 @@ static struct platform_driver renesas_gbeth_driver = {
 	.probe  = renesas_gbeth_probe,
 	.driver = {
 		.name		= "renesas-gbeth",
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table	= renesas_gbeth_match,
 	},
 };
-- 
2.43.0


