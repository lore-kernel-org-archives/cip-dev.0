Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73A0D33A31
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:21 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31284.1768466113598286446
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ka9hv750;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so926635a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466112; x=1769070912; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBOYtvejDNFN9R/Ciz8Bzze3nyvsxS+8oDprMU3CGKM=;
        b=Ka9hv750Py1Yb5oBIQxwEqmPDhF4+A/k1LOThAIKhdn29GBKeOvFqUlO5r4VHZ2M5+
         wsIlvm8hjsj5rJkoNP0XHxX6PRcqEv6RQZTww2ITj+rRibGKIZFwVOtq/iH9jRc9ZN49
         qfMN3bUMe5pPz/7GjRy0F3BJ5oV/kPExjnBc87JXQwND/Gqn9/kp8qM3ADcAp6jamoNK
         IHJGHAECvhRiSQs+McGdS1k7/XOZu47sQmbi/pjj+O/GnfdlU0w/SO03UsDbiBoIT2Df
         GTtXhlFCwfxtRMJgIzeYD2fDZfQNw24lU4ShBfsaPpDAteaj73nLphvNs7RBE0MKK97P
         jUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466112; x=1769070912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBOYtvejDNFN9R/Ciz8Bzze3nyvsxS+8oDprMU3CGKM=;
        b=oBcCvEo3hZORMEePXqWzvdpo0+IVuDA/UYYa+dNueGgDb97J5XToxEXkrSqGzHc3GZ
         TWp9F3EmNtYqLpyB8NWQgaalauUaO0830OFqGuu1TFYkO94lG4uKi+Mz9XhKErFBV4mY
         sEQL8gRR5pUilJD9NPqQSsp3Ads1qDn26P6a3Q0OgNWPlVEwLXlSFhe9xriGuqnM1yhX
         i2r/guuaVgw2kMrjNhSY8TBmFRJZVwdnU972Vi/QwuPHiGnkm+d/g9B5URmitSD32PeF
         2L18qvkHPjQ8s1M9SwFWIlb8Nj7gCNdPChWQHV9jwEZEk+m+6zsyl7JbUi8kEYuRrwR2
         1zsQ==
X-Gm-Message-State: AOJu0YwaYuubysDUQgUFHRYEFTSkWzGUtCR+AOTCkopeNXt4K6fo7m6K
	PeE99nqIVcjHRa1dnL0Bb0dZKH8FuvN9FBhfO2dOzxfzgb3Gy5hGV+pNhRh0B+Jlku7QBUeEZJs
	16M1B
X-Gm-Gg: AY/fxX4RAgT1IwpKnGTRtYsGdxzojmblfFzTLZ25AoSwyDu/yYW929U7ykmpJsjcgsE
	9plMl+lUf9u19/f+fJF2/v+8p7ufXJXrg+BcVM81rwcQkKF4hs1Sk2I3NfHh8Li7WMEVwKBdFtX
	KLcT/q5mzl7CciDYwA0PloDT/7e5fo8Xx+ZYFIaReybVbwi44QSY2gSMSVgBvFCDUf9TveZtnin
	Q2OAtkSJb77Xo9JsYqOhcou/G7whcEOXZHTZZCJgeQsH5+jmuSXHbmsRfiHvDHxFUC7wwmlBF/b
	nWLLqmYHnlwMEKT2XosWutyc2HhR6+ygAdU613LJw/m+6PSItYzm3R7tHcWGDrKqyPV6g8HnBsu
	g4giGvS2qWPsTxL1drdTFYpbVv+6Cl+/DowJvw1Ef1mtbedIj2xIyro79uyVl9QHfHFJY+5TWY4
	E0PP+VsXheWd+dgPrtVvm66eWYuRd2oD3R7qMqwlFR0ha49ZZQWEflJ0eUhzEweiOJGA==
X-Received: by 2002:a05:6402:210c:b0:64b:42a6:3946 with SMTP id 4fb4d7f45d1cf-653ec10b2c1mr4600173a12.7.1768466111963;
        Thu, 15 Jan 2026 00:35:11 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 10/19] clk: renesas: rzg2l: Extend power domain support
Date: Thu, 15 Jan 2026 10:34:42 +0200
Message-ID: <20260115083451.1064048-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21590

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
index 118610936194..36b273a93e5e 100644
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


