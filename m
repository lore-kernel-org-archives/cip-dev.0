Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C6C43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:46 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19069.1782820120667195333
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LxY/HaYC;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47362928f65so1776046f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820119; x=1783424919; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7kKnqChXMTthTPzEGOpJ7CCNkgD3pp+494FUzid9l0=;
        b=LxY/HaYCjRw8YuxNVriCdBOE1NvNM5uZSY9f81DFVKTIJgD3Npc1vgqP1QLE7usH5i
         bWkxexm5blgRcYXrE1p7fbZF/aCtM0fdK3mp3HE0Y0Dmya9k44bunGdMjrXTWSpzAWrc
         mzeH6tk2C4LqBkJ54hzqfeDs6t5x6g/PVN4Lfwl5Fg1qZMn/ztukgmnpCQvh8sjWwYJm
         WtSK1mQ+ekhrFg9sIXzRweBW/It8mvFrEUqaE+jRwIE2zdmPgsh1+iaTX541/sJ8lRkB
         BCpBf8pr5nGWqrmQxqgujvxBIl6KsCiLln684xFg6NTX63xSst7VurczrSUi0JSaoTb3
         9mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820119; x=1783424919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7kKnqChXMTthTPzEGOpJ7CCNkgD3pp+494FUzid9l0=;
        b=XWyQhMlaEcZe79GtudWVYiVH4WpTSLMvCrfeLOdyFA4timWTycd9kutB9KtedkdtOE
         RUPehL5gcCkTTCoLyQbi0Ccc8bMpnPNPaidEx/u98Ege7l4Jg5pJvJyHgJkCZzuvpPSZ
         aO2u2FEjRTWsdZU1uOp5FnfCMmuv/rpayJMn1iLjH6NSBPX1RMAXEMyb+vqV35E3z8j4
         HPJoHolqMTK0HIMAmRMbZpCkdPRcJgrxZspLNFsihBWnhop1UvPYj2qFHb5gyPJ14AMz
         oChqdFZIeR0hTgMQ0jy84bLnfKN2U/vZAYaiDS7xw6bFlayAmb+SvnQkmqY7dk+Tamcw
         K8Eg==
X-Gm-Message-State: AOJu0YwxldByOoqE+hUx/LVJqH8kaQp/UQnMOewEaOD7B9Gem91CEzjE
	FyTmsNwrNURLVOBIbyBiQ5E3y+OnDBd4Y91y9kh7RS/l++1D7acYALTPca0Ec7l9
X-Gm-Gg: AfdE7cnqD9HMuejREKNVvmn73EDu8S/hbYkxqMS3rE/ZIbZD4X8mwLHAY/c3Xf9A4re
	WQZmDpXos9HZaXhtGc0/Ufsjg7jHbfWXESBkskQ4/BlHJB53WYgWQDq6KxLC7LjfFSfvhMywN/6
	0D05nc3GkTf+mjWiScPQRmjFnyfYhLKdecy22jfKZXLkHh1ydiOnhdnJsyro0n1y8o0RAFPyM75
	S2vqT3TVPS+TSZOrRXaTsoG9v5jlkh5XJchaFKIPGJQQxKfoi1PY8fNhnKw1LJ9yx7guvLjD9l6
	4WQCSwM/iHSX3nS8736gOGT9afMlqRi/raxJS2IxwUlIh+vvWTa1/hLBr4yHh+slsCb14fHXOs8
	/7oqvvKRP/RjHLMptP7yKbUshvhLAOErAhuiBWCVgXqhOzgOplRYADqiPqOtP2igga7YJVuiYSJ
	3okO1XPOtOb8lInZR0JGpZdvsWWpAV1GsdCOwhjA==
X-Received: by 2002:a05:6000:184f:b0:475:f0d1:eb70 with SMTP id ffacd0b85a97d-475f0d1ed5fmr2479719f8f.61.1782820118805;
        Tue, 30 Jun 2026 04:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/39] net: stmmac: platform: Group GMAC4 compatible check
Date: Tue, 30 Jun 2026 12:47:23 +0100
Message-ID: <20260630114813.92739-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23328

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit f8add6654d3c859e8a020e0708fdc8bf7d966623 ]

Use of_device_compatible_match to group existing compatible
check of GMAC4 device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20250307011623.440792-3-inochiama@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index abc03019af67..e685e715556d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -405,6 +405,16 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 	return -ENODEV;
 }
 
+/* Compatible string array for all gmac4 devices */
+static const char * const stmmac_gmac4_compats[] = {
+	"snps,dwmac-4.00",
+	"snps,dwmac-4.10a",
+	"snps,dwmac-4.20a",
+	"snps,dwmac-5.10a",
+	"snps,dwmac-5.20",
+	NULL
+};
+
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -544,11 +554,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 	}
 
-	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	if (of_device_compatible_match(np, stmmac_gmac4_compats)) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.43.0


