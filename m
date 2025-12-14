Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDED5B16E
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:58:40 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24280.1765714000103928510
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:06:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KlaPKlGg;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-597d712c0a7so3134694e87.0
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765713998; x=1766318798; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rzPRRVuU8TBWVH0M0tPX5m5pIUJBrP7/vzADfKXh0w=;
        b=KlaPKlGgHUBv74/v4ELgb58HC987t5Gh1d5CysQSoE7Ce+Q0uQswo7/w+4k4bVYig1
         vsRppJRBWaVsRb84UGgtTuZbK7XGmtKzgZuCDJel2h8WhFaasSORsDaYODaENp/yWQrp
         khw/mNWv6qS/dTfJqKyu20Ad7703d/OqxzTH6C8Gl7R7U1dj85Ol43dzyYu/09+5DIrD
         gI05PO0naHhNrRhFE3g1OmS2YIlV8sJ9RgB/J2eZ+O1o99CvNY3JHf/sKFcDyR12BiYX
         CRNR2WnP8CycohhU4hXDcTurWo9sdXCdcP/qNCtfgiSHQoRV/jkoPP3O63ikLuaX4nZb
         y+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765713998; x=1766318798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rzPRRVuU8TBWVH0M0tPX5m5pIUJBrP7/vzADfKXh0w=;
        b=PDvV2vRLTrVFJfJTnpX1TOMOUqxSH/0zLHmCvO1K7IV/da6EM/i5RmSG+6YFZS6fb1
         7M/Qu9+NcE/qwb1gHXwgrYVOJPDC7zX8C8YMusUvUgUA3Yf6et67l6dK/eK7e/F/cs7c
         aQbsvkMOYucewj+WDSdPLzvZtOqiNRVtp0yzAcgqsVqE5TEQ+I/79N01M4PbcG0rNuHb
         F3EU7b7Bw6c4y8yNO59bQlLlnzftfcdfIu/MM5cOl9ziryhwpFonY5pHiiBO6J3lxr6l
         SlmjxYZ4PDql6h2C/ZaKoFT9o1vBeF5bzqbmhYz0Rx0ENqvIr9NN5EW1yJOtS29TyMGj
         qsww==
X-Gm-Message-State: AOJu0YwjjjkyREZPwnHlrbuQgmMZzaA6PQ3kAITuNsX6mH8KTiRlkSnX
	U2Tpb5eBZ4jb1I0dyPz7RzQSk4qqoU3hUIj6pk+GV1yESEO9/bblZV3VUcDIyw==
X-Gm-Gg: AY/fxX5iJUWkWtY5EVKUjXbOHRaOLyIpb8GUFGO/7EFAHwQsTNq+a5/TD+uPHN/nJTY
	ia7jpkL1w2Ono/IaeYONfCErLGD/B3OZ0ga7hW1yXOgHNH/YzVwhQJ7EVEKcYqhg0WGAvRQq79g
	wBzsLAi/GT7wmr1tzcAL6DeQLhcOrJg6kMcy5sy3MkW+WQhN85sX+Cfjvepah0HxTcCfNhTYSu/
	zC46RFsCDgQpVC1Y4C+zYNieVKCUq5RfjgSJhkTJr7snIZJs0jQy/SFzpwrLE0/cqTKw48TJMbi
	wo7DdoxE0fAFE0o/dj3QQBrD/d/l7ujVzVlWrf4h+/AEEVSlegW7rBUB64DKN167GW1St49auLm
	PT/MFphbLf5Et2TgNkLeLtT4nyhW3J5EmsJYP46AaA2zjY1BxsUU1M7Uy/Vfzv1N6wHV4NsAt+d
	sLfBB8vW7APmj8JpQgyaUuVoPSBKZJlt6joAnfgu4Oe8XWFuSpZmhRcqK8b4Kr7vbq8qv0+bA=
X-Google-Smtp-Source: AGHT+IFR3MUuMbk2XpY5kzolVRHTqkbELqrik277Lj8jamt4HvrTe1GsaKywwas654VC688dyuLvmg==
X-Received: by 2002:a05:6000:310f:b0:430:f704:4ef with SMTP id ffacd0b85a97d-430f70407bbmr1968542f8f.61.1765713685019;
        Sun, 14 Dec 2025 04:01:25 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb68866f3sm14523386f8f.36.2025.12.14.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:01:24 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/3] net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks
Date: Sun, 14 Dec 2025 12:01:19 +0000
Message-ID: <20251214120122.3784-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21015

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
index 4ed13375fd15..42cba9dd967c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -137,6 +137,7 @@ static struct platform_driver renesas_gbeth_driver = {
 	.remove = renesas_gbeth_remove,
 	.driver = {
 		.name		= "renesas-gbeth",
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table	= renesas_gbeth_match,
 	},
 };
-- 
2.43.0


