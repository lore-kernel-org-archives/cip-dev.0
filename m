Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBACCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:04 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10042.1762416714848331221
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PfaEffa9;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47758595eecso3228405e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416713; x=1763021513; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=PfaEffa9I40VJron2y97QxtWC1CoyyDQuE2WmwOMXIJSaps+RDba8ufw1AiHF4w7Bz
         Sb5HgHSRLBddP2eACikAv8m97s2CLYue8fWUUz73IjkaFMySRzBcQEDfU9gDSvp+lCKN
         kGALNlYkRtBztzgPh+IOQ3ZIgDYWLKGDdS185GHHjQQks/8uP1qsHs8XoojbThi7/AAp
         PLvOPk/lXp3B0/KQkkFTuJkw43RN0D3+v0zD2EMMgZ9BBxVOue+hBpYREl31HH7gnYiY
         GWAk8NpAAkKpiGvwhGcfoBfZ0cgZL6z0njNfJfEsaHzveimeSVzVFsFBicrj5/tGkaQh
         XqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416713; x=1763021513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=lRzlWg327y+dwTSpgpnfEj9TbBiSiqcHdZ/xORnC9Bg4MV9KkCkoKVgBTvVt4pwL9u
         OveGwLtPyC6FPdn310RZalX1Xh8/YvnhTBf87HDY8gzU5QBrCOPHAKo06tVXK55OfHoa
         HOQGIcJhjWJx/CCjbst4Vz6BcL2h9Ed+UvbjAAfCWuOciLbKB3+ipQPfT4cfWAsbQU+1
         EjApWLKPivYvZSjgmOZJWpuUVa+A+yKJxryvFWphBIiGmlFnhyBJxy+0LlYQOdzyOxhI
         QuOBT6ye/UybelFCTeEis0fibQ2ioXW16/sZYaUtbX9VPI6P+GZRAjJMMZYcQB+2QGrt
         18Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXiIuG3gbiKpd6StegAQTf9o9OOBG3/LNab/geKETM+V9PwpcOBZ8Xewfn59K16M8omXeQQhFJ7@lists.cip-project.org
X-Gm-Message-State: AOJu0YyZZJJ3UhfOm92lPUJ1+dgcSiFIgHoo1nBOFQD/DEBGj5RZ18V1
	XJ/ufBQ5IGZUbF2TT6u7yv1ynj68ByqrygirzuLmObiw6mEzncy1HO/88o86+uTsT5o=
X-Gm-Gg: ASbGncvqDFJeXtyPeDDCjYEHQGkPnitXZMJnoCylYtfsCRQmCRSizpIpwffrKiNr2WL
	4Jxpjnjae3MFNWerOq92k/US4IjVs4kmeZosCm8zDUCCNXiIipukEsCccKzrBn6xBjnkPT7QYKj
	WMgtuwp4++LLqaBqigR/imQeTitW8sFZ8pKIGplU6Rpp0Vs9IOZIyjhdxelFTsyCNbKgFrK9Jfu
	3ejsRmCKqxZZ9ChZGidQXdKxsCoVIxV36NJL+On6fu3GjzPHNe06MPHBkHBxUePG4S7lxMfVOyL
	Jg8kc/nvtej65WWoQG3c7fASS2AnbGC02AvDrVyixBM3bqoHrPcrIHYrZp5Lwb1q5VjOCnFKqPK
	9tHorSxRbtlpD66xrPGX8ITJW1UnTsKCfizZsx3lHcknHcHuFG6+PDQp8loN6bi8riaLpzm0fDG
	bMLzuKH1qi+EtXqKq8xCCEp/W/FIBoowbgShJJWrEa
X-Google-Smtp-Source: AGHT+IEPNmRN7230S6NHgAgs4YXWYvMolx0ecQkp0zVeICxxnp6WlVvkUGiJ42w7h1lQldmdCO0M4A==
X-Received: by 2002:a05:600c:8b33:b0:477:af8:25a with SMTP id 5b1f17b1804b1-4775cd3536bmr58109235e9.0.1762416713237;
        Thu, 06 Nov 2025 00:11:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/23] clk: renesas: rzg2l: Extend power domain support
Date: Thu,  6 Nov 2025 10:11:22 +0200
Message-ID: <20251106081132.2574638-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20406

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0c8a59b3113ef6184d1e4cf2fb911c641d5172e3 upstream.

RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
power when clocks are disabled by activating module standby.  This is
done through MSTOP-specific registers that are part of CPG.  Each
individual module has one or more bits associated with one MSTOP
register (see table "Registers for Module Standby Mode" from HW
manuals).  Hardware manual associates modules' clocks with one or more
MSTOP bits.  There are 3 mappings available (identified by researching
RZ/G2L, RZ/G3S, RZ/V2L HW manuals):

case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})

Case 3 has been currently identified on RZ/V2L for the VCPL4 module.

To cover all three cases, the individual platform drivers will provide
the clock driver with MSTOP register offsets and associated bits in this
register as a bitmask, and the clock driver will apply this bitmask to
the proper MSTOP register.

The MSTOP support was implemented through power domains.
Platform-specific clock drivers will register an array of type struct
rzg2l_cpg_pm_domain_init_data, which will be used to instantiate
properly the power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20240422105355.1622177-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: kept only the register defines from rzg2l-cpg.h]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index d9be4317e587..29d53ed70eed 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -28,6 +28,18 @@
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_PL5_SDIV		(0x420)
 #define CPG_RST_MON		(0x680)
+#define CPG_BUS_ACPU_MSTOP	(0xB60)
+#define CPG_BUS_MCPU1_MSTOP	(0xB64)
+#define CPG_BUS_MCPU2_MSTOP	(0xB68)
+#define CPG_BUS_PERI_COM_MSTOP	(0xB6C)
+#define CPG_BUS_PERI_CPU_MSTOP	(0xB70)
+#define CPG_BUS_PERI_DDR_MSTOP	(0xB74)
+#define CPG_BUS_REG0_MSTOP	(0xB7C)
+#define CPG_BUS_REG1_MSTOP	(0xB80)
+#define CPG_BUS_TZCDDR_MSTOP	(0xB84)
+#define CPG_MHU_MSTOP		(0xB88)
+#define CPG_BUS_MCPU3_MSTOP	(0xB90)
+#define CPG_BUS_PERI_CPU2_MSTOP	(0xB94)
 #define CPG_OTHERFUNC1_REG	(0xBE8)
 
 #define CPG_SIPLL5_STBY_RESETB		BIT(0)
-- 
2.43.0


