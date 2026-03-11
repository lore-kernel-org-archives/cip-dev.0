Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71886106121C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:07:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18356.1773227212597567455
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WBaB84N0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so52539775e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227211; x=1773832011; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdJCvYydshxC1K+8nnPkLxH7kk1L6H1eNf4T9sxzTtc=;
        b=WBaB84N0JD1Rs4a/qnHyLH8RH7ZwSiFYbKgrWkf7GvwrsIvHVHs5xBGKbDXj3yqTsv
         CYI8IIRAnRDB9HlSt5NOExhrv6gpBdVKY68kjQZYu8rV09nm6SZQbDGJ1aF98GE0cpiP
         2d6mJ+HKWtjt+xLDc8GbZV3O6sPfjLZytEEs3EyU9myngRkkCIS+xB7xIlQlRaxvcuBk
         nxfXhJNNqvrmW4tNxhsVAFBT64zNDV5N1u9OMwD7pDVQs2xI/wKbpj/ymhB9andKdle9
         EtgUeR6dtPoVSDpG+pzD3Qhn7b6OQjuZgskUDMW8+Mq7PtxK9r/3NZjO0O/PD4fLWlHJ
         UQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227211; x=1773832011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdJCvYydshxC1K+8nnPkLxH7kk1L6H1eNf4T9sxzTtc=;
        b=iflv9lD8VgOxV3I5ImaErA11wCFfA8zzvnkBp1tO72lmmDtvxDVEPnVrHFviUQLo0h
         J4Hd1cbseGcS6fBKULPoWrtvnM05ZttdFzT5MI4SZ7IVsvDvT/a8TbLGVs/YZpH+YDQR
         W9Djx5mEycg3eO3lVEGyPxVI5yJ8Sx0XOkMlCFuaum4h3KCJ7XhaNK4p2I3lczdLERoG
         f7OPN6rSHlCLi3o1einD5d2rK6+o69um/LPoU4XEAg3uQ6InSMfuDf8sVSk6FRfmrXWN
         Z6qYSwQEurRM914z2cw47wpY2kYMIyWbJBKodZrnvAWv9nEgzKQo6RzoQ43uvoplDvYl
         fXdA==
X-Gm-Message-State: AOJu0Yygl/ZEisloCSHSwMrKKgu9mnpblndCu18L4Hx5P1DsBlu5CVlv
	0udtT4S8J+MbvNAdPKo6TbPPMOasZ3bWbfTHiJhuXQ/5IeXgunwYF2jOWHjEjbqwFHM=
X-Gm-Gg: ATEYQzxeQhD1psMQ8R27XDUkh3tK1S0sz0EaEDTuBNOFu34H/m4HV0531uwQrgJx6RK
	G3W5V/tofRf6BozIH75CF3+RWMOgeB1FMCblPbCKWnptF5ViUhsdK6QU62ON8dAkvsfLq2iemWf
	ZL3oXGE5ofdOifM+CID1m6z4YGgrbaTeuFWU+P5ocMnM2xCrm8dvONpWpRbdx+yDCw5UV2clzST
	UbsTzWELa//pww3/klQdDcWghQC6W4utNIeHNRlaHlYkOau0byr+nQPBXwXCvdKcv1dBCgkLFZv
	nH/ozybfx8McThnwsBg92jLvtJo34MKvFaPiPBVL60h7XcV1vLmXN6ma+wyvXmqUTwiEEkn2sTv
	tEHby8Ebgj5LMoLzAhk5RVrESJHsy3wOVMtWxMdk7qeOeH08ol3qQWn50N5twx113JCARLbh/Qu
	Q5zvErodl2JBD2ajLwd5FwUI2peJMG2q+3iLqSTb9AmqRRSeGhlMEA8Dv1ljrBjZA=
X-Received: by 2002:a05:600c:4fd5:b0:485:379b:57be with SMTP id 5b1f17b1804b1-4854b0cb6c7mr33665635e9.1.1773227210996;
        Wed, 11 Mar 2026 04:06:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 13/13] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 11 Mar 2026 13:06:33 +0200
Message-ID: <20260311110633.1938579-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:07:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22339

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit fc913a1c9df1216db1e33dcea4eb864fd0ca794a upstream.

Enable PCIe for the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7cc3f46ece81..d198c09735a9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -223,6 +223,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


