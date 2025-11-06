Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399DDCCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10107.1762416758774844521
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fWM4DCFd;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426f1574a14so359488f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416757; x=1763021557; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=fWM4DCFdB1cLFBEXFqVbPpIqep7wpU9vL9p0R3xGRaNV7Aem8h1i89Lz2dUqGeTi/K
         Hc0j02zWUzuXpNC9/rHIIpWO0mi9pbueKwwNEFPggdCwsmOY44OA+K0++XoR1VaD+HDi
         ba8GRxqdJpMJN5h27wVO6P7BFXEFuBM4bjOQkN70PHoXY1rKo5yvt5OhBABTpVcr9obO
         4X+i6lhDOxqKZMW1q5/ORwbUVzJWC3glUNTBjj4e5brJKq7O5Vq1a6AIJvrPnHl4ShUZ
         z4+nRqrfez+4amrfNr79Y2g7QQtwzjOqNhBWyrWuhenF9ZxvIAOWX2Ilh0b3O2PXP3uc
         Zjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416757; x=1763021557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=HgneNiyKKsY2vI7fxEIGxhD8GqTWXdNJ4S6qYgo9O2IRBh4e3bhWW2TI7mktuuouAL
         o/stVcN5k4r8U2peyTEyRGl+MuuWZpSdNDa3Gz2PLxyg2XeJpndCcpz2PM/V6PgN2lDi
         UKTZoehE662adauCx1i4NY9hxgnA+sCSC4UdJZPf1EKQm8Wc/WzuUR7vwMr3UnrDoNED
         geIIT9bvnEKtXEt0xxzjdYTMi5VsGUwBQo6OwuSZwnIpFm3iNPX7LDbXXXUiAUjBhs32
         9yY8KOX4VilDvDCAgmtETtdyeUyBIjocC+r+EBhKBG1UnaRdjvI5j1+jN84iY/LNe38b
         lLow==
X-Forwarded-Encrypted: i=1; AJvYcCX7PL1qJ1gb3lo+jjtf1KV/Os/E/gEH9IFMzon/oW6GXH9ABgGgiDlHCit0d3gU3D2jpUiVYg1x@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz8gfBwkB65OCXygfnV30eiFhloOgNUgtrv/ujlgBYMz/r4xF63
	oMc2y4m8XbwKUECDIBB68h0MNJr3jg39OX2SNLmc3E1Fzg6VPgSs5WdHDk6M4yngalA=
X-Gm-Gg: ASbGncu/CAtG0muXe0sx8JZ2hj3tUHvyNVuv9F6dXY0tMLa1mtUreQggyr9a3t+au4y
	2czPQpGkuMJoWyQvhj1ldJLU6LLLp0Fi2gWHgQefvEKK9QG1L3tTUUFT/NDs/enWihAu9R0PsJZ
	9UHPxqsDQrNMKmvu69L+FTSgkxJ6355s5GEPQxE1wulDLkj4tClE8t5bgWrXRwvuKHUVGo+Vdp5
	gc1VNJ36fFqxlMZNqy4UjbRmIvQ12up3ZByfpgrffFqG+tlNm4y0pkZ+PIXMNqMoAhsb+c/FwHf
	UxGZfHb6AE1kTZv4EpvLw5M1D4sREQHREsogwkjHGlab0g2ePo07uRudewfV2govgnqRcusJDB9
	z2L7zeIl93PHGstK5HooMOSRsjYsHBuwt4yAzXnb6meQJZ3y1o5x9an/z+mXxAk+qJrjO9uphDb
	XbQCEB/pFfcA5PPPk8JwGn15+Ye1wzSulsiQRqYROY
X-Google-Smtp-Source: AGHT+IFZdPYquKJQvUp5klTHytXnx1OGaEFP7WMcPNSl+5DO7fa5aMvxis804xSF/AOqwXABsstQ6A==
X-Received: by 2002:a05:6000:4285:b0:429:cda2:9ff5 with SMTP id ffacd0b85a97d-429e32e4494mr4489742f8f.21.1762416757115;
        Thu, 06 Nov 2025 00:12:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/22] clk: renesas: rzg2l: Extend power domain support
Date: Thu,  6 Nov 2025 10:12:08 +0200
Message-ID: <20251106081218.2574950-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20429

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


