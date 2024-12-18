Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03752E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:22:55 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.104356.1734524569654726338
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VI6SzwVR;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f664af5so69107505e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524568; x=1735129368; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X54X21N2UmLDNUCUr4sM3QVDcKKp9AfWFjniv5MtSzk=;
        b=VI6SzwVR17K1mc3YNE4eSCXBSqMrxcgYDGbfdBqbb8LvvriJNeDgVC5wZiO+SLZrBO
         ujzyXhekCz+0A7TpLxlgCbf6FXfdJ7phZK5yki65Xz01faFYnHmTQP6GY9vhmL4gDYQH
         tLGHQGreGQm7RWJCPxwcmfcVOGPK/UU1V5Nx8Qvsop4Mp18uw9XLa4xmRXNI91tIk+8R
         CkEMvg9L+M1TTcH9Gn7bYlcd5nrM5yAgotaaNIpcXD0IX5/F/TS40JcSslDGjzcRwn5G
         irnHDabIiWwT6rd2k7uR4TkTBpuDCvNd/5eEodU4Kmj7i3ph/nVHMh4u3XRbYEv5SXvc
         VPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524568; x=1735129368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X54X21N2UmLDNUCUr4sM3QVDcKKp9AfWFjniv5MtSzk=;
        b=Yez22+4U6SZRGrMylFeegTt0rmhMtelYHDdzu/ccLmPUVL6xS6JNJwihVH0DtA/NOj
         ouGmgx94p/yWI5q8WybPB5wduygTVGtihnaoLVh32Qfnjj/G9dtYj6BYxVxE5taO2Tbd
         wVudEt79u/G9l0Cxb9UaMziM6IUZbuwepRGzZ8Nw+t3WavMwRs78g+zCOO/84d/qTTVk
         AlNjTq7RksZaSbcAMX+ubz8l1ry3COVWM6guWdHYTfA9WiMMdf4BMf+GBbH/ErkSqLpc
         tG+OQsMmAW731HV9WcLaN+ZiPR9GrvaUjhrg76CfvTMBR0K0tJOaphR//okG1pUSZXr5
         bvrw==
X-Forwarded-Encrypted: i=1; AJvYcCUAhSg3hYcStkk756ah+kcjBs551NwKCCyovVdokjdcV8Y6w4dHqzFEuT4mVlGizMEyf1btrPZw@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw1t2smaSqLaZWWljvn1ahs6678DY3yu3fPyQkItePU5M65Iyaf
	3DKiP9Oz6j3Nxfl8xPHll4ICGwbLQ2oIpEbgZLUH1DAe03mpFWvYVEgw+uodpuc=
X-Gm-Gg: ASbGncvdrFN2nETvKf1f/ZnveFVjZPcvZGwV7YPQs51PwUv6SBlEJ24F0k9I5eE4pfK
	OWDKmrMzLY8/li5+xh+JyaL+rPud+2yG2JTOS5nuPHNDZybKRumZqRvFWL6SlGx9szV70JH9EY+
	QYxcpmE9rIZ6vvzE82KXLvBb3GL3tcstkPusFIFjeDMdxUqW2j1cSkM2fAvQOHM18q2h8MYZznf
	NiBCHnCCaIamudigY4H6qyL8kcq9cIorI2oQA6pZDIrNL8ZJbWF9UzeDiHkjsU4c08G3gwKgd+P
	lukykHZn5sA=
X-Google-Smtp-Source: AGHT+IHWDUv5M32ajKxN5CtvtAHeYFPX0r7EQ9gt8sv2mwEEHOERFrkBnmJUCbNZyH7mwQyaE47NGg==
X-Received: by 2002:a05:600c:4f0c:b0:435:172:5052 with SMTP id 5b1f17b1804b1-43655341f9bmr20917855e9.1.1734524567886;
        Wed, 18 Dec 2024 04:22:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport RZ/G3S support
Date: Wed, 18 Dec 2024 14:22:38 +0200
Message-ID: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17444

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the watchdog support for the Renesas RZ/G3S SoC.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  clk: renesas: r9a08g045: Add clock and reset support for watchdog
  watchdog: rzg2l_wdt: Remove reset de-assert from probe
  watchdog: rzg2l_wdt: Remove comparison with zero
  watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
  watchdog: rzg2l_wdt: Add suspend/resume support
  watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
    handler
  arm64: dts: renesas: r9a08g045: Add watchdog node
  arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  14 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/watchdog/rzg2l_wdt.c                  | 111 ++++++++++--------
 4 files changed, 86 insertions(+), 47 deletions(-)

-- 
2.43.0


