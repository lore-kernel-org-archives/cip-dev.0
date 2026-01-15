Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684AD33A14
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:01 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31266.1768466032898910276
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QnY/c0kh;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b876b691fbcso133856166b.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466031; x=1769070831; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBOYtvejDNFN9R/Ciz8Bzze3nyvsxS+8oDprMU3CGKM=;
        b=QnY/c0khtekri+gt1t6H/q/ZHHzgElWjKbF+RyNVYv89/Lz3hKveIWJ03BNsxQqZC1
         0efQ0UDfNXLBkicMTEBpRsQR8AoWkGwIXSOuyW5lPKj4H05uyxAEeLWYXFA74c0yUEEO
         rw/dRumpUoVG87+aBGdGcfj81uJnMRYtP9/GADL1p7i07AVDCwzgxZ4RSahuka1QgQAO
         JgMTEQjTz/LeCPWxS9PGnsL3uayNc0cKmg/6qBqu/KQTIsb8AhiXZ/ryFP5+YXAemKzN
         fII0tnba0zF5ysxtAp2FAUPpRC8/QYpsKGt6pDkwrV+USg7dCJQcj8eFDz2wHV6bI74Q
         uhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466031; x=1769070831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBOYtvejDNFN9R/Ciz8Bzze3nyvsxS+8oDprMU3CGKM=;
        b=WeMI8qpJe7yGQmtNF883zppKn1O63gINV4/Iz07PVSm1HL9FeorOAuRUJTiK61YSIq
         jC7hMIrpq4QxoSIAXZwPOw6CBt7qhm5xqydVLwdQxb/VidOU8uI0Y1CiIU+yBVBceWLU
         MB9ab7rGuC0z+7Ji24EfKEvbv+cgXA3JS5WfDu09J5YlDQVihTI0q1/TTwvatsnFHPRc
         2wjEOq1fwr3v2+LmdU42iCDCkeW6w+Z01QGu+X3y9MpCnUorKKyf2YZHfRxmIoSSwggS
         wJUwLdYRZOElSMWvIMnUYTK/H/mfAS0SGn7QFbEGiDfNu2I23JeCTdjQeiZfYhws+lH+
         I1jw==
X-Gm-Message-State: AOJu0Yyzq42HCRx/fGT/3lQDMJvWrhbuOOxDvN+lb+b7ap155RnRVjuK
	uUpDTp4bGUnRBM60KzmY2sBuh9IqCVf1j/ZTWUHlKF70cJD7BWr3EJ6PdkdG8jBQwM4=
X-Gm-Gg: AY/fxX5J9Guo8X0mehDj7kpiyqMnMESEBPpU0OvP8kO9ePD8pUgoFAxQ3ZoPe5tUs3D
	0LbVMMyZeDFiOiowdgO1NOgQQzXW1OVaQ/7ec0a41rSIvqSStmqlxDjSRL3vCRe6s1oNJ+sq9cw
	/nP5b3LO6Zr87VaBiaKyXTBRm2DzNJ0tijuqoZ7XzmqJaYS/CEPsiaUGDW8sVrgzyN40JI7WPCb
	RawMixncYMdalEcTjgn0vtPul/8/Jjc2YmNvmZtGG/DuMu2k1Z82xat5CrJMhGscy/J7mR1Leuy
	JCSmYoLeT6y0RtjogtS1FpznBzoewr+jtAhrSphHFnaIgbTb2GZeFHshVbiuD0KL1EFBRbXMqnf
	4K8ajcTr3hfV1eMHpcEOxtBg2PX0R/1j5DvW8/hvgQI3RVSAKwhU/v0SHF8QU6D6IIxL2O6KUUK
	QPyZWSEMINNpZslRdw+4cGNLFLNB2xNXjzF5dKrGmxx1K8EL3yjxlNiOyz3j3rTQTFIQ==
X-Received: by 2002:a17:906:6a27:b0:b87:908:9aca with SMTP id a640c23a62f3a-b8760fd7852mr452164166b.9.1768466031149;
        Thu, 15 Jan 2026 00:33:51 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 09/18] clk: renesas: rzg2l: Extend power domain support
Date: Thu, 15 Jan 2026 10:33:23 +0200
Message-ID: <20260115083332.1063820-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21570

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


