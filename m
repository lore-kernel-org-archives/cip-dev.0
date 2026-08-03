Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87902C55ABC
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:40 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45074.1785769113893041229
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gzaVoI/n;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49557167508so19934135e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769112; x=1786373912; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DyueezjB3zjfVAjBJsnGTfMtx3cKJzSkOQuxy9h0qzI=;
        b=gzaVoI/nP2Q1NkWrWIbDY/RnwsHTDOMsywCBQTylRbf8JnyGVKUZBO5Wah4NkrBs1O
         1FJwxjP/NYhvN9t01U6j9bQX4n7Vlhck/2LbmbJSHyN4vaqnZGSXIMRSaXDIPZIq8F9q
         OIPx+ALkcr0afnNGH+V4HdCuWcwUQObD4kPx6jJ/8veaOdlBdf8ZcnjMmrlxac6uBXiV
         B5gkzh4FmmZwInhIecxLbg/oxmqUg3YOKfFNEDKp/MZtSjIGxcsw3L5brbe6fc2V4eGd
         LKiMdyue38ibQkXPxlaWF+TYnX7fUg/P4VxdgpYN5abE99gJLh2cKoj2UA4KoFUrbw8D
         Y73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769112; x=1786373912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyueezjB3zjfVAjBJsnGTfMtx3cKJzSkOQuxy9h0qzI=;
        b=RQZs4tiwH2vtuIzs4B6T8IxHAXFcMySSRpOFPkm4RQW1q6WCt8AaiS7vRtTUC7Hauu
         kKJPIKarhnNOk8jyXzT9n3q7qzFZcRY57j/CBACfDzSbPsO3fmVNVDgVDbi+Ipi5jyeK
         wPWSWMkbItwMOMHEmiqe2Ig2jD9ezYB4KsUAWEGWjoLSXAf8P9CwHWgPzTE/2NU+uSp5
         Rvjexsc9QJb2AurIfukxpt+QLl3bPJNhYQBpNWfqhuen9Pjy6n5ba6pvMMnvMY/OHUZn
         m8SDc1IibklFtiK8JWfY2hB6hRg9HniQmB6ae9mGmCadnxGHhWazAdXTT/e6jSMQzdEN
         8ZKQ==
X-Gm-Message-State: AOJu0Yx484ckUF/cE6/ka/qHOsflAq4vFO4XED1gMkcrkjJlZEdUWAzK
	Pn1P1JG3AHp4R6qfvo+JryXS3YTab0wdEqs224u5lPxEzSTLmToVwi/DW76+5A==
X-Gm-Gg: AR+sD12lW4hXkN6d+oJXUOoE68mXzZgFyG3H9t8iyOCbs7LOkVCs4wBxaTvaL7f61Pn
	IqOwjrxoaH+clTdb3J/YX2UOCMWhNjdYspH7/2ezbruqyyfNDjK+uIWHM+0I5D1SJF9R3ymRTt7
	Pzp3/S7sSiw19y86qmqzZfBIq1uey6vVctCgcEReK/gHdVkODIFwMlaTdnI8pXHt38AJ9aTVijO
	TRKEHZbx67c/57mVWXEETcWF2Q09Or4pYqFBM7u9GJJ9i6eSJ3QcrUbY/1wuWM3CNec+Tlzt7BH
	mfizmNiIa9ay6dZosTynHqvQXJMWs0Wci31KYsv2Xcb+9BZAzxbxhzeyre+ZXxAfK5fFIAMz63x
	4HHkZ+5RemeujoozJW0zckccZLrzj8iXfwOhT/ttXHtXxF0M1AIkc2K9Hj/wuhkbSTH3LgWlG5l
	LjePY160bfMVQS4tFFsfRNihtrvcH9kPy7f8jeXqCcAKSqe6oVcmoFVfaRGK+k5na+KGlZ
X-Received: by 2002:a05:600c:4689:b0:498:162a:dbda with SMTP id 5b1f17b1804b1-498162adbdfmr107242865e9.5.1785769111810;
        Mon, 03 Aug 2026 07:58:31 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/7] Document RZ/G3L I2C, WDT and SSI
Date: Mon,  3 Aug 2026 15:58:16 +0100
Message-ID: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23854

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series document I2C, WDT and SSI IP found on Renesas RZ/G3L
SoC. All the patches in this series are cherry-picked from mainline.

Biju Das (3):
  dt-bindings: i2c: renesas,riic: Document the R9A08G046 support
  ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G3L SoC
  dt-bindings: watchdog: renesas,wdt: Document RZ/G3L support

Wolfram Sang (4):
  dt-bindings: watchdog: factor out RZ/A watchdog
  dt-bindings: watchdog: factor out RZ/N1 watchdog
  dt-bindings: watchdog: factor out RZ/G2L watchdog
  dt-bindings: watchdog: factor out RZ/V2H(P) watchdog

 .../devicetree/bindings/i2c/renesas,riic.yaml |   1 +
 .../bindings/sound/renesas,rz-ssi.yaml        |   1 +
 .../watchdog/renesas,r9a09g057-wdt.yaml       |  99 +++++++++++
 .../bindings/watchdog/renesas,rza-wdt.yaml    |  51 ++++++
 .../bindings/watchdog/renesas,rzg2l-wdt.yaml  | 112 +++++++++++++
 .../bindings/watchdog/renesas,rzn1-wdt.yaml   |  50 ++++++
 .../bindings/watchdog/renesas,wdt.yaml        | 155 +-----------------
 7 files changed, 320 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rza-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml

-- 
2.43.0


