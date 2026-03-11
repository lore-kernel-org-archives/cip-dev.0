Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE310611F1
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18325.1773227150358603421
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MpPuq1g4;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48540355459so25664445e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227149; x=1773831949; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io2OlVxR/iQvIV+zJPFAByyoCf8ml6HylkJTLEq2fg0=;
        b=MpPuq1g4DvqKIqHvp+nKbjmH+TnYLYgg5A7ctdgN1YYHGaGvcLHPOQGhb4hs07WSkC
         J7CpOgNxcrphuRNwV3eKWgBNEbHC3eiFzWPLFbHSN1BexwAhxDCO/bh9GdS6uH6V8yAo
         5XUQKQZFKkCzYhzOnLWuSUWyQ/jaNnhNebimOmee4iR+i46RAGJtAALPALxTpT727Cc8
         NQxrI6paPLRMD53AlfaWCaPYLfilJC4Yt9QLxZZlRBHiLFNxcDaKYbVkOs4o4lLt0qnR
         QWDFu+yd9IupW4dXzibh57HluVgc822/YCrfUuyWKB/sPZuh1K0BQE/2QGv+KjhyL91e
         BpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227149; x=1773831949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=io2OlVxR/iQvIV+zJPFAByyoCf8ml6HylkJTLEq2fg0=;
        b=WkJboj/eTI+TDtW13goLP5tyLJE6MVhRkyG37bgVzMiPHdEwlWJxC6QoZkxwlYCtOX
         njIMeEP6XHWtXbGstypQFpO7G7t6oO0wwNLlvV4U2HcRfbKZC/Jn6pHUR9Wk8Cb8pUzm
         fF8ahBjMH3XpCyK96eZ1mR0GUtxdCgPp8wObv7sgOkDNiOeCe/ftI/WZ8n8NBif4xGx7
         ucduOelY+GNLlNxPRCfwgPSnXT3LzfhiBhqp6fGe7wryClNjav5R1vd9fSrOWOUuwpmQ
         VmEHojzHl3mkt5iAHBHnk+OnYY3tPBmjn1f9T9Xtoicf5DbC0Gonakqo1Mv6Q69CvOg1
         v2DA==
X-Gm-Message-State: AOJu0YzQOV3D6aVOG1xbLr/IEeLn3kflZaw7h0YgDVqGHmkAZ7GPAGw8
	vfZPezHk9rjk+Mdl/vKWIUScsF9apjEkFSzDfKhmkPoGV7ucOgjSB+P4jNfbWG1PpiAC5vROQWz
	9pCfC
X-Gm-Gg: ATEYQzzxFWsdYAjN1z0Tt3IsBAHTe7ys0P/u//+be+FO6r1wesqCoUB+MX2l3xIMqGF
	YRFJQ+Kh+rQi69yj+ztMqgs0+/+AyJYfLV4dMSH0pSfqNsHmbq5/c2IiKugAJ8sWPNyDWB1vW2z
	KX7oMxYZOlQLkSHfMpr076NrRHxtitJLoW1RTjNih0WGJ4R+nF9ZnSUx7dJosdsMJJuM/vm5ALO
	sX2uaYQz1lLjYnuABOLYP+7NhPHSigi6QkFJjwimzn4jZ5S6vgsbvu94QBavtm6MiDTmfMsQjTY
	b5oi9P7mM4OTDrzb5s2XJTDc9JKit2YGhY4ledta09/ZcVC/C8ZH4GUpzdxJw9LUfbTosK3ECAD
	uIWAIb7+abdHV/OIB2wgjdXM9cw9ViNTBbNMsBjpdFlnEarRxBY+BT+D6k8zPTWn/HRdFfzRFGj
	V+o3brGbOpzpAFAhMTaN4E0ZzQL+WAb/teCBTwtCRwg0iWY/PDHgUW
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4854b0bb5c0mr37297245e9.13.1773227148707;
        Wed, 11 Mar 2026 04:05:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 17/17] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 11 Mar 2026 13:05:20 +0200
Message-ID: <20260311110520.1938414-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22325

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit fc913a1c9df1216db1e33dcea4eb864fd0ca794a upstream.

Enable PCIe for the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping CONFIG_PCI_HOST_GENERIC and
 dropping CONFIG_PCIE_ROCKCHIP_HOST]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 911fe95af244..913f4300159e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -224,6 +224,7 @@ CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_ALTERA=y
-- 
2.43.0


