Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E9D29F94
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50862.1764872148148590543
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=djImaQ24;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477770019e4so12881525e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872146; x=1765476946; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=djImaQ24nb8N0Pmi4C+wWlm1Tl59xNTEmpyy9mh2B39GVKwOeoVt/WwfWFL8dWBCrA
         i1lghz3VJPKYrVOwNnbUuf2F7H0oYwoKEeSnkjVAkfC42j6pGHJ62adVXH+8NEilph2b
         Vy6R7dQDarZCv6qGaCu88ZJbgnPpEfTEtz59n+ZF1yQwdIhpoTTAyu9lRROGbNO+QZ5U
         jPrYlkZq3cUdR/xc02WrCfygy9xmLPyAx4pzphOR+s2gCOQ27wWWeQROkKyfKtU9OSSC
         kU18z4+lB5fb/y3Uy/E5qHUXrmcwhrNFxFvFbj51wLd8M4OlLnXo5nMoQYB9ofsl3Uwl
         XZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872146; x=1765476946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=U4UMemrjT6+vVGoi8tBdNK1FvNpwHEC4Upu4W14hadcRUMU/AivFYklqclYVVREsHe
         /CXJwG8JDPgVLcX+/k46z0IM0d3k6PsfCBhfDNcJ9E26l6odvNX73X5WVZtfLX3hQS+i
         UmZ1Ntffh6QBr3mquni/X+VVlsHG4xNFUxqVLQYK4GtCUdlnSPTrPutzxpJp3sb8UEFg
         k7Adjeg1gevkl3TbvhFV/GLqe0z9j3ZG77NKbFiIvzPhoYJj/YxlTNwg+6CBwMJ8TNPD
         msPJsGmuyCNdAgkiLZrvkhUE140cpaPuux7v0DCrEr5eVLkVl4OKvS3EzrpfWERI5Lqt
         4tHg==
X-Forwarded-Encrypted: i=1; AJvYcCV81yR6GYdjnv7lAK+WszFSfqcSNgH4d+KeKz48UrivmetnfokHP+q0i2FkVOkZj1wON3xboUc3@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzj43Y8h8tWQ6FU+VJvoCo10OOgyn2bjs1skNrgMRU0O5Wp6d+j
	YLtbUhVfGOQkf+BD9ncjodcdiKJpV0qjVhCi8UbXWcM3IRAcwSt2G//7ac8t6TqC/0o=
X-Gm-Gg: ASbGncsxbo01Vnx+BjyoXvnt9k1Qafy1e7/wJN8hR6IsBm09XwUhnxe22A2Sx5osA0L
	X/QG6K++MBj36OfcHiYid8oKVkyxh5ORpghOdhYVjBmOn69qCKHKtHtGH5UtJxcvphr1wGFWyaS
	ZIvcixq1mQHm06Hs/eiHrfyh/807Y82jNkGJocYP5o33EpqkVKmA/614XCYL1eA0bb0Shh5dYL9
	7H75rWqQxB/rxc351Q7PZVp6eTulYS/7U1Rlx93SDt6ThNG0ujyI3PGdEdhsB1uFVYmz48IWEFX
	ehL0RjnEJv7PXQgl66k4X1hivjrOzs/siVvxxPt7A9RGmQV5p0pjlgTCi520bALgX4QGdcZQhb+
	Ni3l7QFlvEiwP6noIJnJx4OpCyZMqHcao9poPFtQ5U/oWaiQpk0QbAjp4ztWJl511mXnZmhK4rz
	D7alEqo+bg9r8Xqerly1LTdxVOsBuXgnxc3FE2x37zxD7XzYqZmcE=
X-Google-Smtp-Source: AGHT+IHsnFExbVJx2q/e9xfd2X5W9LfvuaI7yKxRhff/IMbDlFWw4/1r3GfCteqc0/U0/+bATVzZkA==
X-Received: by 2002:a05:600c:a07:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-4792f23c7camr38959895e9.4.1764872146465;
        Thu, 04 Dec 2025 10:15:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 10/19] clk: renesas: rzg2l: Extend power domain support
Date: Thu,  4 Dec 2025 20:15:21 +0200
Message-ID: <20251204181530.689132-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20876

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


