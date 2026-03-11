Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06167104BECD
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17328.1773223509505798671
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BwVUFjzt;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439baf33150so692941f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223508; x=1773828308; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fXFwJT90M+/FKqcQ3BPND5W/Dd7hh75uMvotRHSq8Y=;
        b=BwVUFjztDF9JOMrXye7B0O0ZabRAEZ+thTSzZqpFbeVOlFhgbHz9nLWe/vZLeu74hf
         x/RSvvp7DrNY3qu6Nuzq1V2RPKVpCwLvxTJfilReMerWavrb0xckrlYGnWht3zJU/Iit
         ga0qZ7rqSvO30rfIrkSADS3EEzrNZPDJWPaeEJs4sRzIbAdg7X9E1BArfN56MpibEHsC
         gUCR5SgXcUuoOvI407SBmDF9qO3OEIVBuOPk7He+SoBUVCFfps3vucv6LQhUXh/vpCNI
         Ivb0bd0eZJWatVuB+Ts+lgNbwifeZS3HdrO0AoQQP6o6A55u9GECyQI6n2B1jKpyJDXk
         yGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223508; x=1773828308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fXFwJT90M+/FKqcQ3BPND5W/Dd7hh75uMvotRHSq8Y=;
        b=uRif8jrRkdu3ERz0C2yXEn47pZcCPI6LidDM9F/sLt2J4rbDNBChc/CA0pwB3/fZH0
         uOCQg8v9u0VZ3XFQcJ6DsIYOETMTt6cO+2tXgWKcuousVfvOT4tiY2K/loQS5IYCsa1g
         phFXSycr+Ix/M/l1kQ8DSO0XJYicO/w6H9VxmXdWdvMcidxpKFujr7/3PBaDQtef7Rj/
         coyqROmRHvRrsjvAM5YnWd1D292r3fDF3k8s8e52PFrcv4AWTo0GlyGhBMibd2+OpVds
         CXpWuP1Fkhx+ktEMC4NQqu1QOYYFXTRtEzjQGraUcmG0q18b/MNpq3exaTHJA/aSq/9K
         53gA==
X-Gm-Message-State: AOJu0YwTCex/L1esesqqOGk5bSQf6PE7SFsekkoNDgiyxVa8AGd0Jqgz
	hx1PXfWMKNI7j/j83dQueLGL5MfBjjaPu1g3LUflYkBZbH38skO7NS2cY/zC1g==
X-Gm-Gg: ATEYQzzMpFY8HM3YPidfFvULlSgsQnaJ+UVEfnYG1gpJnN5oBkvQa/umzf6O55MWcHx
	CeEVbAa5kU5cMewK2ga8ExzQWJn6TnTpq6yHU4QC/WF0muagw7f7K9PSjN0CMKtUNhS7zQupZjJ
	grJB5DqOENmQdGYkF1yZpC9+mzND1gW8WwHm1Do9fs0KVclCxlMWAvDK90lqpSOOBR2e/Ham3RL
	EOXPi8e8hLTvLFXdcjZkZyQOcklOgFgbY36aZjbbE6wnd6CHlkQp3bGSFUqSenTqtJAz+8+khfC
	u7J9wEELgoJrHTrpPAswwl1OpwlcJMaSjteE0Cw/AHvQ+uGO67hbdRMzzgbT0M2hI+VNLNsLGd/
	gZTu4K6LgSYnl/eWRRl2YEvPoxsfqyMlYhw2OqDYziLioRj7N2Qal1MvDW6151NWNgWs3L4TGhi
	1KylDwdvqtpyiJTYg1kvvQC2Vr91JyI7yDDr2ltWREPA==
X-Received: by 2002:a05:6000:2902:b0:439:ce30:5b84 with SMTP id ffacd0b85a97d-439f8bb18d0mr3649038f8f.2.1773223507569;
        Wed, 11 Mar 2026 03:05:07 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 13/27] serial: sh-sci: Drop extra lines
Date: Wed, 11 Mar 2026 10:04:32 +0000
Message-ID: <20260311100458.162447-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22259

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c17db4d06cabc7746d48d99c6245d19bd55077d4 ]

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7f23b63eca13..97f6dc8692f5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3187,11 +3187,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			return PTR_ERR(clk);
 
 		if (!clk && sci_port->type == SCI_PORT_RSCI &&
-		    (i == SCI_FCK || i == SCI_BRG_INT)) {
-			return dev_err_probe(dev, -ENODEV,
-					     "failed to get %s\n",
-					     name);
-		}
+		    (i == SCI_FCK || i == SCI_BRG_INT))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
 		if (!clk && i == SCI_FCK) {
 			/*
@@ -3201,16 +3198,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
-						     name);
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n", name);
 		}
 
 		if (!clk)
 			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
-				clk, clk_get_rate(clk));
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name, clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
 	return 0;
-- 
2.43.0


