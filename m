Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA16D6553C
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11766.1765967542380675775
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WLDIMBlK;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b72b495aa81so983050666b.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967541; x=1766572341; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjM45rPHdEYHZvQb/wSJI0iCJcnGjyE4Vvo+jknuKNg=;
        b=WLDIMBlKODt82pmnicWGTkCECK8P2LEmNSq/Wv3sdOVnkod8noSBSes7VlVIo/1/Rk
         pjiFpdPY3dnCh/9jhWcDC03kxLr0nU2hqWt93yCClJ/J3VHJbIhe7HJ/o9tqQRslslO1
         HfXZ8WUwarJZAF3KswoVTV1pL+ewDX4EO8Nz80jRrT060UWinYY0bg3GLkbxCc7iA6rj
         qfF7guvfIzbyw2CmtwE3+FmKZBmA+2aFuwICKOQFllse+JGCIZMcc+sIRNdfzuyFuGUd
         p5NipIld0EmZoW7o74gg7og8we6vdYMx+1Gzvg2vCB8EakCsoH1qFVfTRWLjGE1TnDqO
         GWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967541; x=1766572341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjM45rPHdEYHZvQb/wSJI0iCJcnGjyE4Vvo+jknuKNg=;
        b=mWT9trHXSrrMgaeECxXaM4619lAZFu1w+K10HWPXdE1PizWOOQHZGj4d0rYONwJ80l
         qaIky5SZuer/ePM62XRbG3itMhRLu8rvCB2lpGOZLaUtCB7dmvpmkuXsKmOTdaOOyIu/
         U41SbZcEKcznmibJMSmXIfazTwxL7XTsPXlTaqBbnQlCvyxPtvyijHe81dkwf2BTHqRa
         VJBlQf+7/SmTuubFES8sjr2pezPsI1xTsQNBe5QHQz43iPb7sTeIaLEnH8YRoAJqHMU2
         Ca+Vs2322roXhO2fau6u/c4NuKvhWTVutUnbkhqB87RoU25AJFwM93IMwYVrU8S7mje1
         /MOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfVBELVaC5NwJ8pSR0/Kdb7kOkpPTmkuFs2ZEibX1aTNV3POVDZGBUtG7S6gzFPYG09bDZzpHP@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyh0c7pxBYs38Jym5ywKdSXmUFs4lG4CQVwKkkRiqpqYGJq81Ke
	z7mvzNCzMcFMXt+x5vXKnW2250LnjQ6xOGgX9pik/c0uxdAlgEGVJSrNk2lhexaV4Q0=
X-Gm-Gg: AY/fxX7dDuVtxfgjtNkEyjtSUBKfNgy/bTvZ+zZimMxt89qvndSAzXYGN7uZF9rXwCS
	7icI45XfGM8dKg9xjU2D9XSwby+FVyPRc1fSB6MknFv7m/HcgHBGtzZB9mKEQeEFl6fO/buIXi3
	hAV0TRdVjqCH7/jYjhTVUMltlAdyGXam2ZXJMf0Vo6t7hTxQ2t7CgQDi7sNI/SXc3hP8BUVT+Ev
	EE7U1IZWtMhVJns5YmtMFTd1Z2pvrkmtQ23hdaq+PTwzsCEaH1RouA0uaVAyrOESt/ItEcroPQE
	ol668lMGhFcUxCVCaeZIzf7qbcezYLoXxZCcItLPaKaO5Tn7Ue2EGlzmPRe3/RarvHhoc7DCnHf
	do2piHvpctOq8olSjB6Vq/2lDp4gOwKTcKBqRJMjeVHXBxtAOM8gYg6HXmgeUUe2u3pQpAdaKMo
	/mvzVhWJz4mh8/UOiecfbHyyS58HmbNCiel3V0a/r6
X-Google-Smtp-Source: AGHT+IEWTgUgqkTLjKRSI0zPu+Jd9NVljJvcPiJbkeNtZAs+GJ5L5KmkCRLA6B+BzvggXSeiM21WGg==
X-Received: by 2002:a17:907:2d2b:b0:b76:ece3:510a with SMTP id a640c23a62f3a-b7d23776e1fmr1940153166b.21.1765967540644;
        Wed, 17 Dec 2025 02:32:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 7/7] arm64: defconfig: Enable Renesas RZ/G3S thermal driver
Date: Wed, 17 Dec 2025 12:32:10 +0200
Message-ID: <20251217103210.4183025-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21112

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 823062d153851a944e61768014d7458d609fa4ca upstream.

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4c1305008789..212345c2b54d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -609,6 +609,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
-- 
2.43.0


