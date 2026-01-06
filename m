Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92640C9833E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88169.1767699903170884277
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fm4TYKch;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6641605e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699901; x=1768304701; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr7Pz2avPp7AUH1p+oihwPe4+XKum4LUM/JAalKJlhE=;
        b=Fm4TYKchrsAjkhBUULr4wYzISnj5HRx8Wg+rLXlR8LqKaK0EwRkTW7D48uGap6Y+6Z
         hZyBXcvBvas7AcjSeQQiYmfbrhQgp5/Q7EAVZgKMyOyYyy8+e/K0RazPRWOnimafsFve
         AhusUIavWfZ3H/n7Eph9MIza5QSb5tpd2cnsBTyr9FEtETGdbNTVPhHoV18ezh7rne+k
         hlst0j6oFyeQptTFL9V2w98QKJUHsmX5UtV5MSlONhyHbysLroJpdTSh02roemi2fKMJ
         Jy5NN5oa71gZJ3qnMUdv2sTY4twQqrq4F0zORtyySjI64QI2sVFeT29ZINTwovSbJgi/
         PMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699901; x=1768304701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cr7Pz2avPp7AUH1p+oihwPe4+XKum4LUM/JAalKJlhE=;
        b=ITFRMu+JexJudBq4gkZdDmWORjxv5xtImMuzYZ6G3TMSeHmdaomWx/eOr/dtjGSODo
         rwRgsrtxfSmYsbjTDw2iVpHaVw2t0wXhUjA0mdTceqSkZqNYeKkadm3KEljM1Z9pqwDl
         gSMgoIzBGd+B7HQJbzfdBgX7L9vBp854qZZdeXrnI9gclfVEfso4yASoknwpeWfcRj9I
         x9pgXL1jUIi8NsAAqgf8fepS2hDK/C+FtI4w6XlVFfbBJvHzPFho0Fe1waoWMs35dnLS
         1vXlcneeC2TECr4+58gMPIXdaiWT2oD9Hsnk/wxpykUbPGtjtXkTl3rAHPLbgvWgs3Zm
         uIfw==
X-Gm-Message-State: AOJu0YxRHciIKihE3r7Y4emDkTOlHOeBpousZsOc/p3DCuOjhhZjVfCp
	IumsvCvo4lkFoMNt1hQMW4RKygXwGlkSvFEAf2VftgKrLI1xihZ1MarUfKOPCA==
X-Gm-Gg: AY/fxX53gsl64sc/FxVGUW9GhJnr+9CqQy6pblD6Wx2gi3+rqQBhwErH18J6nvhwFoE
	r39UCPoSvxqXZIrX+/G03PoCj6HJVZMv81dju64FDEgW/KxpAYtaoxKq1WwyerDugynd3MfgbUc
	wkkTsCNkgjbpWN9zqrBlcg9ZdXDpKdDCIyVpSAIf/ZKXiJCtJZfls2UQ+/DIOkykk2AcL8ulaWk
	U4Zsyss4bxCWt4dm6qgj2/2cm8tLmU281sEfp7tRC8uzKrQH4J3ZhW8v6zCRFg5NbMxeg535aMl
	O86qUA91wzDECVCnrBG7tj01mWXUROw7r2EKTtihtxofEpX3I++PqD9UJz9yy+mxSF5l/DOx0Bj
	GEBjtvPDnnGFERT9SdsGXExIODiXfQvAa2PDIRAj3tRbViUq/POyOpSoyoL1QDI5TcbmteS4tV3
	px8IRoK3bhThCdVRmJZtgVrtA2Jj/G
X-Google-Smtp-Source: AGHT+IGqJHCkw3b47+rOalLvmP74jAzwY9fhsy71HlY1dv+9pYPQEYpJ+yL9GMjVO2doRnvoiT05OQ==
X-Received: by 2002:a05:600c:a4a:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d7f09299emr28113635e9.20.1767699901290;
        Tue, 06 Jan 2026 03:45:01 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:01 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 04/24] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
Date: Tue,  6 Jan 2026 11:44:27 +0000
Message-ID: <20260106114458.122333-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21336

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1f9b5003d4baf72055371fcdb15dda5759a8e908 ]

rcar_canfd_reset_controller() has many users of "pdev->dev".  Introduce
a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/21e64816808eb3eba722f4c547f4f5112d5d62a6.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9b40b787d913..ac6a942c3c85 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -821,6 +821,7 @@ static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
+	struct device *dev = &gpriv->pdev->dev;
 	u32 sts, ch;
 	int err;
 
@@ -830,7 +831,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GRAMINIT), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global raminit failed\n");
+		dev_dbg(dev, "global raminit failed\n");
 		return err;
 	}
 
@@ -843,7 +844,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 (sts & RCANFD_GSTS_GRSTSTS), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global reset failed\n");
+		dev_dbg(dev, "global reset failed\n");
 		return err;
 	}
 
@@ -874,8 +875,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 					 (sts & RCANFD_CSTS_CRSTSTS),
 					 2, 500000);
 		if (err) {
-			dev_dbg(&gpriv->pdev->dev,
-				"channel %u reset failed\n", ch);
+			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
 
-- 
2.43.0


