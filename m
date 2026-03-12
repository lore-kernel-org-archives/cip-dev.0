Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A41067048
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24571.1773329726484675725
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nPQnahkH;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so12961225e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329724; x=1773934524; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/mIySWt7GcZv3IqZNVm+NpPza5/LTKJrgitxWuvOrU=;
        b=nPQnahkHCjJ54/fNTgUuRIREEOAO4wt/0TqGVKU3SYuGF1CXFP3SGjHQsHGLnZeJa2
         rXBV2/OlPyoWZxlGxrTDtyT2jymQKt5YyhGW3lM1ym1yH4FH28dYTSQG6ucaB2UdTY1y
         NUWUurw/tfnNz7+reYPsVSb8zpWQ1yWC/4IQ/OfJbRs2NLEtLGv2WT8dlF3sdd3O/m2R
         xp0hHEQdd2Ie9HRulhQqlRALOrAFmCmPzpzNOWWtLfQM2xalwmcwGMWPdoMF0BRyOpcp
         ND9/w7rxBYFOiFiW78i2zdB3E/ngqIpcZbM1RjF9m4x8/SP1YpveFUP37lkva3UmyI8E
         rQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329724; x=1773934524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/mIySWt7GcZv3IqZNVm+NpPza5/LTKJrgitxWuvOrU=;
        b=oB+O0jbNO34nT26v/+OhMdBvwkrCyROPEhR0ftCKueE8LhV3FKT40gJTtZqQ8J3UGK
         vLi/d2BUZe0KJsX8krzhunm4uvdEtt/aV+5F8QFVj0W2U0bGE1O7Nlwrq1pRvsQm55gn
         BaFx3ODY7Fqix2/QWe7RZ+p/CDkqu7j+3vc9gnnfjmanJ2tpeF4EhdBEmDMoeLXmRVI6
         IDnKuBX20KNrkgEii7oWb44S3Q3MVIy/4Mba+xs9JeqP+qA7Gq7ltBQEYRmOnMDtxggc
         UqGG4XwzzGkuHI8YaA4HzwJkP4lcGNHy7BTGOTRd4Gds66Qvas/+Gtu/jZidIK3QLn85
         hrHQ==
X-Gm-Message-State: AOJu0YwCyp8TUy6UHO3joBft3cSD3ICLTGBr6sh2RIH+wlITIPCBbWmd
	VrR/0i/DBXmOmmLkFo7Emkr5U9jo56OtIv/7kkhAqbFjj2n+CLq385jT6ZXupw==
X-Gm-Gg: ATEYQzyxqMV0LNZwiXheiVM4evghN3leWPGFU+07X6wv/aNLH9QqgPrFtJOrLfWwCq1
	7IJ/YFybKHV4xp4B8TsT9R5494hykYxyjxAQm9+6KsodSTyFBVqYx+GxIVqk8630givExoAb22t
	XUTHTNxd5yo3mjY2E2RAhZobzjw7e28+cS1NLmiOzKaExFG1n60dEelUpp0ZFZYBLR7C+LuyR5s
	9fh4TtBqMvj+pvpipUDqp9Oh5sxKnyUIVPXByOZQnsuz/3TzX6Yz3OMn8OxwYZhAz688YyiHkb/
	P/rVDQbDyIlrIseE/G1Tv8oPObEaxJxNbp38Z1S2ei6OHKiufrNw/BF6XpSJj3UnSiqB3/FcgAy
	xHPXV4F0eZar4yUBuTTP78rXLjuHxTQCCFNfAIiVWQJyPGMGvT8YYPkG0/LBGSNf5v/4/1g+pRo
	Si1Gd9cSYiK15pSbC+JL6ruf+pP7EH+5cWbVI0GTfHtDz5HQ4=
X-Received: by 2002:a05:600c:4f89:b0:485:2fd9:3d4a with SMTP id 5b1f17b1804b1-4854b102656mr117310695e9.22.1773329724412;
        Thu, 12 Mar 2026 08:35:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:24 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/11] dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
Date: Thu, 12 Mar 2026 15:35:06 +0000
Message-ID: <20260312153522.1131675-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22357

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a24cd110e664396061b0a72930734bf419bf88c4 ]

Add definitions for USB3.0 core clocks in the R9A09G047 CPG DT bindings
header file.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250909180803.140939-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g047-cpg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g047-cpg.h b/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
index a27132f9a6c8..f165df8a6f5a 100644
--- a/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
@@ -20,5 +20,7 @@
 #define R9A09G047_SPI_CLK_SPI			9
 #define R9A09G047_GBETH_0_CLK_PTP_REF_I		10
 #define R9A09G047_GBETH_1_CLK_PTP_REF_I		11
+#define R9A09G047_USB3_0_REF_ALT_CLK_P		12
+#define R9A09G047_USB3_0_CLKCORE		13
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G047_CPG_H__ */
-- 
2.43.0


