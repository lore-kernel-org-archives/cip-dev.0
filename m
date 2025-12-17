Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E09FD65531
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:15 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11307.1765967527885243789
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZYnilNez;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso9738715a12.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967526; x=1766572326; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8W8IxRA94DUVwPVUelGM4+ON+gtPBJ/u7QO5l6CNRk=;
        b=ZYnilNezVTms8sangk+c6oyP2ZZSUJnYEpQEXYd4qZRfBJNFwc5k7mY2LCsZCUnVFF
         2E4qKfLAx2S3XzbwkXFN8keLVrYwWZgI4PwurFNsYniFR7U/NVrH8MVVFsES31NFR8mZ
         Kd05ADss7YLZCKgp0224XpQjquUpXM3YJbuGpLRf6Tqy63yoLZ81z/Q66m0csr7t9dD+
         wZWA8tJx+wB+uuDpy7vpQNkMrxcGr8mnxlcNTg3uwBMmsRicSNytJF49y/hXvlEFKANi
         lkQhpv0KRxAjw3jneZKpZg3B/l9ynHbXOyBSDNcY5Dx12cZmqQL3cuTHAlPfLoTKTpHI
         OPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967526; x=1766572326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8W8IxRA94DUVwPVUelGM4+ON+gtPBJ/u7QO5l6CNRk=;
        b=Wm3OYd6NExUAzok/oeUBE4/mVCVAtHAP/5otMc3yOR5uP95lgv8yzPYZGWotxGHkkY
         Y0emX4yQ2Ne6T/NVsPCJ9I6NaI+jsI2dqE9w9hJt4nG94UXMvhMMUnEL8yQJlFhg1QsP
         30abt0sVih6XLXh02/oN9SASvN4BiUQnWNGUSbt1g9jE67BwuYjNkUWE1PFI3REh7Aq6
         RNKdvPpA9HwzAijPjUXQk12NvAuvU/yv7Hj4QuOJQ0+4+MKJNZkSmvgD2he7HkxhLTGZ
         X1F5eIzOQl1FHXgB7U7xxo1Zzlzmqknzs2c0KcZ3NDcIT/VbQO4T2FvewhiJkxVdmaFc
         B+7g==
X-Forwarded-Encrypted: i=1; AJvYcCWhAJIb/I/2mm9YvwgS8uiluoA6cV2L2FhERj+z0ysbAh9/VilmlOqwf155FMR2e6SWBxTgqGSh@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz2HC+ROXox4u0NyoBIpQpZKFLPGlJtuAN/elGOtTMIvWuSjPAe
	3q3gS+lRx0leHGA2zWuwZl83f5MjPGTJ8RdH4Q0EU3D1xcdjy7nNti6dl8Z3a+43dxg=
X-Gm-Gg: AY/fxX4y2HBSzsjP5ECjozQM8bU7THzn5tAUw4lOM42uQqcqG3CV4lZeQps5KGQPYER
	PFXvQn4ohl91RPQlLNpMbaGv4HGXe+aNQgX48JfVDlIPenvCX+VTThskeSA2ktpGmFxN9XwkBWc
	uD7n+JcZqJtz/61qza/+5oiMO82KloOSjKOgkviHTLXtD7pkKJPdNPd4mwRDE72x+TMUq69BGYk
	DWlX3FIVxRo6Ep3LGyYY4brz/O6xHguQEENkKSTQ+sS5u4ZdrCW1NnHnhYbJptat8EUzUYN5RUF
	dPJuU3CaOX4QOwKMbrVHQaZHODs2BIGrdgDt2QdJFsXOP35OkR2FVCF6sCEdSbuFC+za29oBBti
	Qh3wHkePZ0pNUfR30buG6DvWmh2VZrQZCCRvFhVSbDcWwJ1QKXP6bWEBbVJPhd8ERGuPdpQYkpS
	wchtCRpsIywMUd5aXF9+B1TqmyHCI8t3egk8G4TW+f
X-Google-Smtp-Source: AGHT+IHgQ/wjYnZbJB2MUUxPej03epE7Quy6Dk39rh6qS72x5pFOTLkKK5m6gJjL6gjI49P0+ftTbQ==
X-Received: by 2002:a05:6402:26c6:b0:649:8857:5974 with SMTP id 4fb4d7f45d1cf-6499b1aee79mr17360832a12.18.1765967526281;
        Wed, 17 Dec 2025 02:32:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 7/7] arm64: defconfig: Enable Renesas RZ/G3S thermal driver
Date: Wed, 17 Dec 2025 12:31:48 +0200
Message-ID: <20251217103149.4182935-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21104

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
index 0bda64450d24..9e14e4605367 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -546,6 +546,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
-- 
2.43.0


