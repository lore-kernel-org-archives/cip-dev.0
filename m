Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56160CCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:14 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10065.1762416667351469606
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=d6licnzW;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429bf011e6cso631709f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416666; x=1763021466; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=d6licnzWCIf92AeQLsxYISNP5W9Vc6PCvWR4umOzMZV+KaFdQBMhn0XninhPlZeIOF
         mhvmHOzxlUMGIcoeaM5I9KyXoCXAALBdqGd21SSYgwu2iJfSl+Q8OfVDMT5wh45SE9/x
         4wKE84EMW8OECjgRuVDL1c5o7JXPfq4WeJJwrNmkweu1Z5Hc1vMsyvH77iNdZ7ToUlKu
         lVC+moeZ4pMZ2WB25RFu4CALrGt2zrfEKSpgpHqfWroYqBU9Zv9rWlda0lpQjCePHf23
         XH0/m9KTv+pCfqRMkpLPrskV2Jt61UjJcAtsGY2euoAujIG7sdlyPUJNU5E/G38cP1hH
         Nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416666; x=1763021466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=oLukus71GjPOR2CnBYl9D/w2E5/HVoLizj0vFSw+L3D6I6k3I4aG/BWe3/JFqqNsaa
         yW+UzOXcOA0BngU0ELQ+Dcx3UtKA1nRhmeAKaM5g3iuuPzEr2JhH6R2uyZ1l5KdENa0t
         w6djsQzNyqJ12Jx/axajbxoBW07TO5dXRV0GrzikwZ/Ut/iK0kNqAHxULjF8qHvc8cUx
         X83jTQWTiZcH2lf0TjznkbBw+j1nhl4O/4+yFfCqZ0RX8M0qXkzRC7D+eySGLEbZ3kup
         fQsXs9BgWDLmh2lPUZcCF0mBtvqdZoHAy98vLS99TLhbPtQC1K0WLFoKk+2qJvEN+EOV
         uK9w==
X-Forwarded-Encrypted: i=1; AJvYcCWW1LPe5lUo4nAM2gTVPwSJWQ4oc7wnphBIeHtmeI16SVDzVkACt+kq6G5zSQVIqL91ExUKoH0X@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw8+tIoiXj0McUP0JuOQUuLaipIbwl0GFLDE/3pE42nAk87YJSn
	iLHPZBuDstnFqAOzyyoPHEqzkjnBFH/yVpxooQ54tFyjqr2I/gjU5BR+7xyDvMgKSeQZHTOF+9o
	WNGqdY78=
X-Gm-Gg: ASbGncu4zM2MHjsJOnjVmfbgs9cQqlC3VUC6jzOR511Q7DMv/El10/VpXnNRDd3dkbH
	vo7MClf4CyNK5OBUFy56XOHGfH9vpVCUD/t89gci/TbdmLc2r15nGbFxZyK+gKhamDJDzHKaAb3
	pyZOwsKL17kZceVXTgEev1rDfnva/4RcPc3Ttz1iVIoP8fOodtIFSKRGZBKwpLNQQs2bC1UDjqg
	ZRSMhGLKUq1WtCHzL//yTcmbGrSjK1czGJ4rrY8tmP3eS0oRkQOvE28hhmf4IrzI+Fg5rDo1TkZ
	9rnZTygimf6TPL6UgsBwntvRO+1lAupde1XhwA3OWln73sM6dGHm+2qep6xV3e3RJoOj79ccJcs
	kh3h8DJhVWSqZSI4D6eu6ZJTByeSMv1+oOIx+7BXKw1/QPVv/Tvk0wOFTiycI6iSfpDRBZnF6dk
	WbvV1H3Qgvw0y/9vq1O+jIVw0yynf4Eh2U4BJCwi2PgOPF2UP8MBY=
X-Google-Smtp-Source: AGHT+IGvjankt7uGcLfHtbpZ3r310MMOjQUWN90hZtc0FvbztCYdh3556SZJnAdONhx5f/zlLdxpAQ==
X-Received: by 2002:a05:6000:280d:b0:429:ee5b:f32e with SMTP id ffacd0b85a97d-429ee5bf67dmr585305f8f.53.1762416665718;
        Thu, 06 Nov 2025 00:11:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/23] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  6 Nov 2025 10:10:37 +0200
Message-ID: <20251106081048.2574345-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20381

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a68ea80f85bbf7b69f69ef9e17e3e1be14d948c8 upstream.

Reorder the pointer members in struct mstp_clock so they appear immediately
after the hw member. This helps avoid potential padding and eliminates the
need for any calculations in the to_mod_clock() macro. As struct clk_hw
currently contains only pointers, placing it first also avoids padding.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250514090415.4098534-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index e4f2d974f38a..dd94eca21b19 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1190,19 +1190,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * struct mstp_clock - MSTP gating clock
  *
  * @hw: handle between common and hardware-specific interfaces
+ * @priv: CPG/MSTP private data
+ * @sibling: pointer to the other coupled clock
  * @off: register offset
  * @bit: ON/MON bit
  * @enabled: soft state of the clock, if it is coupled with another clock
- * @priv: CPG/MSTP private data
- * @sibling: pointer to the other coupled clock
  */
 struct mstp_clock {
 	struct clk_hw hw;
+	struct rzg2l_cpg_priv *priv;
+	struct mstp_clock *sibling;
 	u16 off;
 	u8 bit;
 	bool enabled;
-	struct rzg2l_cpg_priv *priv;
-	struct mstp_clock *sibling;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
-- 
2.43.0


