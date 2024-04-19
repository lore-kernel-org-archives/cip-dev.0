Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874BC41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:19:09 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.15298.1713514746182768529
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:19:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g+HN4tM9;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5544fd07easo194092566b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514744; x=1714119544; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsWLMdxYbNB+m5l4uv+6VkVys5+4SAj+aoAfRsQ0K34=;
        b=g+HN4tM99eGz89/2WXpjSz8s9E/nwgawGf+EjXGeDlX0sadm8q8BBT9BTckRsZhK4h
         AqxAauDME6unxmqLvbyTRYiPPVYhtr0bS9TqKcQ6rmE/t7fgaRrPZrXeXtthepYnFtWc
         VmaqbuF+Blgc+UHOHzo4XYWyLkfkmVnnjltQnmr6aw+oASH9l2X5d3j04hfQ8xwU7gJf
         L70DodMFwR7bV7Cnn6xDWfbYq3eIEX1iwnkVOILMnoLdXAVsTclU9VgJ/XmbVxl/5tGT
         hs67ScAmnjfS22Qcu14M+vuo4dwhjQQzfDuzm4+qdzdYdGrl8vwKOl2GR9jw/3H0gSQo
         xAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514744; x=1714119544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsWLMdxYbNB+m5l4uv+6VkVys5+4SAj+aoAfRsQ0K34=;
        b=Q23sVpIV4dgTaKqylMH2HxfiLTWKFOXRKziYTbxS7+vRAemTyo+nn3+T1bSWeOfThp
         eDz0Jak5UwKizgJeD5E8Xuxqfzz4Z2mRRLjf6IAyten9n7KduMW8Mjf5BLk3oRVVED1L
         ZhuX1h5vcV9dQXZxWJY+4Y6YVi5CCAewJf5j9X1M0DtVPMHhz8TN18F3whzKg/q8fRFU
         GHWbR/GWnkFBeKhnldrraOMcXoCguNXBfWaDe5zBb/wKoGxHtMQQiIx/Q19HzbBu6rai
         oe+qMNFNJYBBtTfHFcZMJZ8PCUqQPP1p5QjwWo4urzI/5K8dlacNo36a0yK9RlEXLWsU
         UIvQ==
X-Gm-Message-State: AOJu0YzTJi0uesmbN5iKtO9rZnYtctOafibkAoPEJ4i6Q8bt0O+/PCeR
	VJVeoeEoXygm+3rrM+SdBiPLIIWH4G20qztnk1Z3cvlD2qOKVGh5Wvfhkb+6Cq0=
X-Google-Smtp-Source: AGHT+IHNGpK4YhABRHKetjaDoUpAjuHA/iOqvJbyTRHan/KAem6QESUEomHlDPg6N6uBUptAqyZW4Q==
X-Received: by 2002:a17:906:a290:b0:a52:6832:1ae0 with SMTP id i16-20020a170906a29000b00a5268321ae0mr968393ejz.59.1713514744635;
        Fri, 19 Apr 2024 01:19:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:19:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 53/53] arm64: defconfig: Enable RZ/G3S (R9A08G045) SoC
Date: Fri, 19 Apr 2024 11:17:42 +0300
Message-Id: <20240419081742.3496709-54-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15640

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 09cfdb5a97b53d117682211a4d32a39af2e819e4 upstream.

Enable the config flag for the Renesas RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-29-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bd22f23b551c..25228f0a5c7b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -974,6 +974,7 @@ CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R9A07G043=y
 CONFIG_ARCH_R9A07G044=y
 CONFIG_ARCH_R9A07G054=y
+CONFIG_ARCH_R9A08G045=y
 CONFIG_ARCH_R9A09G011=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
-- 
2.39.2


