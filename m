Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43870CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10108.1762416760149138384
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=U4WWgd5g;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso422566f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416758; x=1763021558; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sFjSUORCE2XFdzna5iDN0re0oUcBefSTsRxrXfXBM4=;
        b=U4WWgd5gjYNjw5spxGipd708Rs+4lbOsnfTXtAIzEwXG+ZsnCLv8H7oEVmqkNTMT+s
         jP2ZLpdRbxv3gqfv+ERk0K01l3f51EqlFBqcvgVkQAcebDcGoTkc6JD8xayehx8iMHuS
         ppusKag33F76u1O26dEQusMnljfut5FFzz0x3XQ0YzOVj3bk5HaIODDDy3kQ9fyUVYu/
         e0mOcH4/rc+eZzJ/ANjViqgafxcRjMDET8Fo5JK+a0B4aknZITkZ9W97E+Ex/vo+X9tU
         0WhsmIhDx+G1w98Wro1f5VfSAPG7R67kqBWEKTr4lFlBiti5z7MXAAqlq3/GCc3W07Rf
         8h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416758; x=1763021558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sFjSUORCE2XFdzna5iDN0re0oUcBefSTsRxrXfXBM4=;
        b=eCFyOUUVgpRAwNKp4+e3DAVuxaxkmb7aasaqW7ujmLJRZ+9f1Kkb6D8tc7+9VuODC8
         /7m1ziiTnTef8mgXTsBlfdLyUhfMDEuFJvdoXggEcYgdjrEt6vnZsQV+SCrH3hWOYcfg
         CuaFgTaM50gaZHMxgF4Sc5OoqQoj90mimFgrpKWWf+kOrGJcXwPEPgN7X04Y8YdranVJ
         LpGR4Q1XdT+xtIFsBdDnIR8M4NqqPZlJxmhROftFEkmUBtdJarOCCPUPXaFSGrKte1iT
         dQtxbynkpxJ6S4MH580G4WA/n5JREKpKsUJkF4rhFufpi/sCmSiBQizaC0iO3kFubvpI
         pnbA==
X-Forwarded-Encrypted: i=1; AJvYcCXlt7J2OWIv7U1WkI8fqcQTkQK4WnVDS7s2AJHoUiY0PG/h7QY0FlFybJRkq5ehbyDUrU9dXptr@lists.cip-project.org
X-Gm-Message-State: AOJu0YzEmRiuhD8LT1i9MNDskxuFid1m08mV3mi/vCQ7NzXSWIsx9aTd
	yYoE1CpbOMjraQ47EBv6KVR0T4r+IzZJHnMZsSyvBkOpAHUW1FZ8/Wcmz0dQzcPW1C8=
X-Gm-Gg: ASbGncs/x9denyKNURjMlZAE4nUFDq44zd3N8LS/uIB9Gup09Okdu66MgnUDVDOt9mh
	HEebK6c0yBb6IDNrJOIEOcog1Cw9yqFsiPt3nHVwv0e6S3o4HRMcnC/pvoQzeNIAz1Ww4fQIoke
	niJFOn5SOGmA45u5GeSZr/i6orPWiUdSpomi+rGjYkHd1PZlBZVeI5acN+fh5/ZdWmHXnfe3hXW
	tikK7GI6wdsGqzHDlw/5tB6MNgoAPMS9NPrIp5hl6RQSXTx2k67bTkvSzhpCRqRhLbWTA5wGCzt
	7l2hy6DMt6u0xs7q4eU211AGKCHp5oqsfdUihdP7vShmNcEpPgFI9ztS8gwNtCPUsQN+EMC0od1
	1zkq5KJS4qf6ZhREDKWFiqf3kVl/B7XSIl2TqZFadTuWhJvnAvhbN6yewrrDxt2g3Roynr8VTZf
	qeO96DbIbmrAm9bOaFLw2bROexg/ElTg==
X-Google-Smtp-Source: AGHT+IHTVETg+vqzpUuX+z/MwDr442IfnuSwxZESPM9YaIkZqABut7jZuj9i+6SDyNDEDqn/jb193g==
X-Received: by 2002:a05:6000:1786:b0:407:d776:4434 with SMTP id ffacd0b85a97d-429eb1cf7aamr1984388f8f.30.1762416758526;
        Thu, 06 Nov 2025 00:12:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 13/22] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu,  6 Nov 2025 10:12:09 +0200
Message-ID: <20251106081218.2574950-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20430

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2f96afdffad4ef74e3c511207058c41c54a2d014 upstream.

Since the sibling data is filled after the priv->clks[] array entry is
populated, the first clock that is probed and has a sibling will
temporarily behave as its own sibling until its actual sibling is
populated. To avoid any issues, postpone updating priv->clks[] until after
the sibling is populated.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514090415.4098534-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping the code from commit
 2f96afdffad4ef74e3c511207058c41c54a2d014]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 379292eb6fb1..a6812257bf1e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1389,9 +1389,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1403,6 +1400,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


