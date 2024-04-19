Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD8C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:40:01 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.18477.1713526795751487202
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=a6LvWgw3;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571e1429a95so16269a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526794; x=1714131594; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9vS/Q/xjHa+olBOIErr36bNXA7gTi5vRxe1DqqT2M=;
        b=a6LvWgw3R30/QtJlTsmGbsA2KQZe3rw8JgZfqO2kMuaR7QNRLY5ZFRZG52nAr5Ip63
         xdJRhX1ndq52Sl9fwfeGzAyd4Wtl+KYlivik0hRS4hKnENTUX1mfWDb7GapACQah+9vZ
         eXzFyR0dpPxBtymJH0lPxNAoHtM2UFRRjFlKSIPA0XW2jYtor5yL8+bBZpQTZqXz1/Ug
         Qe3uh22cef+gE/YDV2Co2kF9UHWkIx3HIQmOHRmiGKlId7c6nhPHr1ODs8EOLDU0ACxu
         41Nof8pP21x1ckDMYDbImwZe4L5YSfDxoNDmDcMvS0halX3D7egJAgPzQ+ZfuyKe0gKL
         ZwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526794; x=1714131594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt9vS/Q/xjHa+olBOIErr36bNXA7gTi5vRxe1DqqT2M=;
        b=cSXkAP1Ixj4ULoBlNxH7ax2E1uK1gUjQJInaDpFWpPRN6d5lK3s99EWYlVhnjnRjPM
         oVHmO2Mm+CUBSCvwBErnF/i2J6wnJV9u3t6pGArVgxauuWZrybVtEhXa9O51QutZskCW
         typiA9+sH18WPAOvuPkD14UetGYg95wjrksNOeeK3afMAXCnM5Ks7uAwrlFc+jyZ0bV2
         dc44CgX6KiD/vcjXixRqUK/U03AQj3ONhLikNcwRBZQ/RWq7s7s2K4lgAYZYFhUoD+NN
         qh1gWmXDjhuI/7BFEF8k1x5StUGJ8+JxcYMLegLfWnTFBcXfL4+6kV9qQDPl+2XYkBPW
         DIIA==
X-Gm-Message-State: AOJu0YxQO5LM+pC2oBQdMUYGHBr7cuT2fEDjiv9TgfmAGH7VcPkXcXtG
	d7a7xcq3TWzVveKkrWVVMNLNlKjD49OAU+yKjFe0RA3VpMPiaVksYYRJZkLqCGJqHIT12mH1G+V
	E
X-Google-Smtp-Source: AGHT+IEkaTOCv9TBBai2/R9iSIPW1MdWpQyEHjnqy8uwH8BSDSXkFOYZuuNingtECLSECalomp8xvA==
X-Received: by 2002:a50:9ea6:0:b0:571:bf62:81ce with SMTP id a35-20020a509ea6000000b00571bf6281cemr1838152edf.9.1713526794088;
        Fri, 19 Apr 2024 04:39:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 44/44] arm64: defconfig: Enable RZ/G3S (R9A08G045) SoC
Date: Fri, 19 Apr 2024 14:38:42 +0300
Message-Id: <20240419113842.3675543-45-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15695

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
index b43f74c282d3..9ef48e50cdfd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1171,6 +1171,7 @@ CONFIG_ARCH_R8A774B1=y
 CONFIG_ARCH_R9A07G043=y
 CONFIG_ARCH_R9A07G044=y
 CONFIG_ARCH_R9A07G054=y
+CONFIG_ARCH_R9A08G045=y
 CONFIG_ARCH_R9A09G011=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
-- 
2.39.2


