Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A980D5B179
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24291.1765714076445734365
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:07:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ex23QNoo;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7697e8b01aso493936666b.2
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714074; x=1766318874; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUYV7tvlZ8epo7EbGNCNyop+5SctqpLPFqtrJzyworA=;
        b=ex23QNoo4Hr7mclwvHCB4qpNYezizD8fvOF3jp8o7UeGJUrAwI2RQTLUj7a4wAoApb
         /Y9lxzQgwSEjr/gRMftb8YfI8MpBellxid8xIsYAcKjBduFJ5+r9xYzpLl+IRRU0tabR
         v2p1Rv8CxJ37wo/VZ4T7O2J4EqL/x28jST9ynNblNaEoJtCQPTj1sVnvK8nSorSQIR6Y
         OCgeaj6GJaqfBVvriob/2JXiXFCW1jq6OhHwa1EoH52Q7oI12Ozv/42m2gWQUpNTFgMr
         2CUL5i9wdFVb7HoddAS/sCsUGj7qm3O1kSJbLaYVbPpe4rYrgJ5DUG/SeKdbFhOn2ACW
         FLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714074; x=1766318874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUYV7tvlZ8epo7EbGNCNyop+5SctqpLPFqtrJzyworA=;
        b=jq8MPqoX21iwEHyThKNRpNePpGwsXdxOjHnKtyBRCpy8ijVoGU5HqxK5F2tIo05+on
         5e9WLoGpTeDqMBm8fPer/Qxhzvn2PqUCTIcJStIBdox5bw3C+e0gZFAkxkW9J2EkY2Jc
         F8dsSI6A3zQMwOisP2uO5VAEWOUfLhUjnEAjhQ6E6GJHeYsV/JfUykJs/tv/FoUoIHxU
         7iKKr4tFXw17LXV+S3b6Dmzi7czrTifc86yi1drWstmVnN/uuXulZoUMg3sc11roI92H
         ms4H0F+lamBekIwCCDJjrnIlCHpNc0NDMAwyu+x1CzwIRsgJqHimrKV3FQF/PxNVPtaD
         1u0w==
X-Gm-Message-State: AOJu0Yz6z9NpIU29MFmefC6K/aRQE/kqT4RfJuafhHXSlwxCbXpNTguE
	aM8SJZqHHrjrDRatRV/Mo9d3C4ZY15/lt1eFsd+sJI1CvbcxCGoZI2453HLpEw==
X-Gm-Gg: AY/fxX6EqhPkq13jbRKLMyxs9aadjmcjMkf0P8SPhLUbcJFEtHKvLr810DafDKdF7jA
	RNywRfBDzzE21733reFU7vpBsdIsXAiHqaeBssQ8ekn/Y3zAV08b/69JyYT8se/xJrtvROJlqw6
	Q39Wku/4DnESOw/WcSioFbc452q+E1KVjfp3IlFWcBI+jEJrSmJk2xP6CCJb9bzzqum1R7YCaMO
	VSCDpR+kONy9sJzAetZHirkK4va/FI0NWo71GTEVLg9UOeHaYjyqhh5rfSROr+i/wclXE0HU5sz
	vrrA30O8N/0VsUOruyk+uAZUAVL217S+M+UZsiZhpMoWISXiYB3OdS4T8Ou7yAY+TuIBNsKukpW
	L7fsiBLUuHoXpUDBEMvGkYLC02SSXqK436lTZtdEOhM+KRXzUqssH4fe6HYjX1WSq5Mt0M9MWA8
	IZNOQreKmCDh+hmTbWRq4NkuKvb8QSlqgbFIqNbhP6w7HLDmi1oVIJUHEjz1kB3DV5a1WR9pw=
X-Google-Smtp-Source: AGHT+IFvQ873vYjbKQ9MWQj05p83JMXGe+H7dqZ5FiISCb/6ZtO5GNv3DkyWRSOxG3SN8QPNbuE7Cg==
X-Received: by 2002:a05:6000:26cf:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42fb46e13f7mr8245055f8f.44.1765713684542;
        Sun, 14 Dec 2025 04:01:24 -0800 (PST)
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
Subject: [PATCH 6.1.y-cip 2/3] net: phy: micrel: Add ksz9131_resume()
Date: Sun, 14 Dec 2025 12:01:18 +0000
Message-ID: <20251214120122.3784-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21017

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f25a7eaa897f21396e99f90809af82ca553c9d14 ]

The Renesas RZ/G3E SMARC EVK uses KSZ9131RNXC phy. On deep power state,
PHY loses the power and on wakeup the rgmii delays are not reconfigured
causing it to fail.

Replace the callback kszphy_resume()->ksz9131_resume() for reconfiguring
the rgmii_delay when it exits from PM suspend state.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250711054029.48536-1-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/phy/micrel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 63392514c894..61c0f0cd4e5b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3194,6 +3194,14 @@ static int lan8814_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9131_resume(struct phy_device *phydev)
+{
+	if (phydev->suspended && phy_interface_is_rgmii(phydev))
+		ksz9131_config_rgmii_delay(phydev);
+
+	return kszphy_resume(phydev);
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	.phy_id		= PHY_ID_KS8737,
@@ -3422,7 +3430,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= kszphy_suspend,
-	.resume		= kszphy_resume,
+	.resume		= ksz9131_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 }, {
-- 
2.43.0


