Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC5105D299
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18291.1773227078610785530
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SQY+IPTV;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so53653775e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227077; x=1773831877; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My4q0hTsUUOErOSNvjHDW09FjIpporOBv63oohvrqHY=;
        b=SQY+IPTVnDboBTfzthtEHtCajFW+7xcVDvL5G7cqCg1qm3KejCxvueghCFgVzc3We7
         AuMfsd/cF+vIPrlg9XnN42I5bV2VMOukYjzCsKTUJJsVr41Pghy9O11gA7LdBShcnpua
         5aBMlPd8Cvg8ETZENyXo/kyk6cigFx9q2Dxy7tYpoqeUjH86BKIodflTiQGL82vaXNeq
         AfJH/79psB6QPNQIBvj8q+viUcfIwdsrRHbulmpJ+3tzjaM3sQ5q18jOnEMuz/xgUo3t
         mKWOg4Y152+qLAEVTVsUc4ee6SZbWuCGUEcmLPisWi9Q/SgjqdWyG9e4UGymSYGltI6S
         8tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227077; x=1773831877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=My4q0hTsUUOErOSNvjHDW09FjIpporOBv63oohvrqHY=;
        b=f920bjJT1mIBh/GSZujAvxNbInMYIb05fy7sgZkaf0N0O0DqEItLJ6zRtygPNc0OgV
         uZqNnf5bqjOu+/79n6ZHTUohwu8lB0Ts7eKr7JnoM4ia/c9Zey4TRBqUe9OcMx6jXD9E
         zvlB+WDu1nePGlsLWr70aDnwTVzIbmFqWaaJa8ZIRUYUcQ9kGJKu1+lipitY/Gji/W5/
         HqqNN7HnYeALChxfHqdxa9dAHVJ2m3baMYWTfWkrS1XHKV/D5BAXpMft7/6QUJklvh86
         HjokJBZFuojF2p/YlKbn5OTohfN6tM7LkJmZyHxOADOYQEzNq+dHkJw2kw0QzijvfiP+
         KwUQ==
X-Gm-Message-State: AOJu0YxXNbIkD0O6pc1bhFdKfFF9t3mkhwQTzLMhxN8LPCCCV8YtR4/8
	31uqry2uUPZ8jaIlfzH/BVfrwUtgAhBNxqTRdD9KxhjahRocYc17a+FSbR62STHcJTw=
X-Gm-Gg: ATEYQzyZTFwTPFs2qunKSV8wthwrbYETr4wrUj3TRWatX/9eTqOJpPNu+bL+yyOiUfw
	IXjBUJsdWE0nGbOnByGyd0YDE8U19v3z8zF+58gfPjBP/tg98Ld9iI2UuXPpGanlnqaCNrjunrR
	Bm6Ouc/cDNmgnY80+IP89nJZxamTkGCt2sBK4rhOWalez5+fCCf+AC9w340uryB5syNTr71paLG
	boz2I4JkDnJpEnQZoiRSUCTAP8dVH2KNl1LGqzMIXoK1HDLM4AdZjJSOnAOAcT9oFpFU5xez5jx
	i6i9jTCag3mxH1NsbpmAmw9ifOaahvk0VWFDANzrK4YgMVuWNX12TlmFarBN8P7xdaGGon4/30h
	2J0Iau5lKyEKNsQb6yasCTnBmNkI8Sawm93PZJa32BIwJBaKlcAWf98JTC/7naMJWSDFq2ZU7SL
	VwU5zXjKldc/uQ09Rd9403GDIkrVBvzrWaHWLgmD+rdxUEckpqM1Bc
X-Received: by 2002:a05:600c:474d:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-4854b12393emr32860465e9.32.1773227076963;
        Wed, 11 Mar 2026 04:04:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 28/28] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 11 Mar 2026 13:03:57 +0200
Message-ID: <20260311110357.1938200-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22307

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
index 9e14e4605367..6aec23945cad 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -213,6 +213,7 @@ CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_ALTERA=y
-- 
2.43.0


