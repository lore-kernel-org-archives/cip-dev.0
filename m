Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65941D24477
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50790.1764872069955304832
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oCgShtaF;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso819768f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872068; x=1765476868; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=oCgShtaFosLnfiqf5qKi5AYR/f+XkIqUVVpoiXIt2wsFxZkQxgTJNPkhw3iGBaPi/f
         pDd2EMNFBhEXmxZHKsE83TJjLuGer9hz9/S/vC5/oa39NmcREAEGrZJdq2ZYTKCyG4f2
         olu8rms0BYUSrTGWl0vqIZ1/W/sWqyKfLYaum11ZGslIW0kMOxhf3MqvDnfvYsUC2WJr
         AqYh81U0kn+sKZdFefElBAalFP9poNaORUhK4I/sWaE2Bk9fY1bAjLk8g87Fl9yeI1ec
         qnkb56emZ1AsMnnoEhXcbB9+FwQq8Pjo/0NNNeJgtC416gx1cSawtVpo5EGtXzqGeKfT
         LFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872068; x=1765476868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BE3BqxYyAQENBEeB0eG2xk/SPw80peinml7of1+9xEA=;
        b=uUQ0Mo4XItTk4KiyJA1MZzY5BfQqhJ28HZsXJL65nKL0dFnkqQvkHTulQCmdYw7NSn
         8c0BtXO/TeXUZkqq54WwqDJwY20zciRLSWLzjCDkgiz+jBAByr91wW8QQFt7DKbSBnFl
         zhcFKpEHEL+oDAVrQd0pMJQhvmGjkVMNw+idBqesCEKEBXnwIAe0oNooCrl7jxjQC1qF
         P9fo93rT/17RoPTa3gk66DqhuYFmWh0IzfTF+jDaq1vkn75Um+NTfxzbbK44IrV68j8M
         SRaTCjJAKJZoZZ+8c3o3H2tNIdv9ZKOYQPmtL9bFw2ON4Vp1/20dMDJvFL9IJ9WW9L9a
         M/1w==
X-Forwarded-Encrypted: i=1; AJvYcCUGl55vYHK5YcvioYrZYMX0gKkjtlqu4mgQGh/+LGSwJYoZiArcXaARpzoAVIrGztaG/pXqml4Q@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzkbp09U2T29mXESBL+D60iTbZozQ1SzgPKVeOALjv3IvuLTElz
	D5byJFFwDFuQpVi5FjdPlB0oprsbOcwT5TH4fkJ7MblPIoWxKarlrGeZnketPT3dcC/46+UUh3d
	ewy8f
X-Gm-Gg: ASbGncuumH/+kdfl7EU2ysCxMzVGol6sycb5enmlW4ONtnUiv8upIdGY9rDF+PC35lB
	qVTyX3MkUUzPW5iddvBANr3VtwSZcUBmIdUx8bjh0wyNBNGJfAOOzxjNZ3h4r4BXo3iV4IVH494
	AJph3Oso40u8PKRWGraBK2HAn31fjNyemxXkPmqwQnMqNVtRy6aOBVjrMRekQx/KqCvYxJRTwYu
	PdrCqNwClhouvFHOVpPoT7qRwkUCRPx4LYH/SrPaas1z96uWDgt+P9RwHJgCsps08i5h85ZSy4u
	Ausq28QraP6+pTKMjVpYQ06aFySYbhUhRyYx8N3zgSGtpfOiR70mMPpLQ+CB5Fa3Wlx6LhL2SZc
	zxokIqvVZHGuEeEtv4HC9sNYfLFkAdXAewiG80+oZIKxHHoNNBlJi0N5dpsxATafL34gm9Va7j6
	yn9nJuV5aBeR18fW/pNCJBwvecyTJt5e0rz1cc2Yog
X-Google-Smtp-Source: AGHT+IGLKSBENKMGRJL63XSNZHIuZz+my36OGII4pADvmEmrziJ/tQlJYRmLayLXhlncZ23l0h+3VQ==
X-Received: by 2002:a05:6000:2506:b0:42b:31a5:f032 with SMTP id ffacd0b85a97d-42f7319b364mr7224884f8f.28.1764872068309;
        Thu, 04 Dec 2025 10:14:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 09/18] clk: renesas: rzg2l: Extend power domain support
Date: Thu,  4 Dec 2025 20:14:06 +0200
Message-ID: <20251204181415.689009-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20856

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


