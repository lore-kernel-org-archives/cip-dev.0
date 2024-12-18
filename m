Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3175FE77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.104377.1734524600342600013
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=e9OTY5dc;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434e3953b65so45146915e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524599; x=1735129399; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yosLr6vP9MWE8IT6YyKdm1c61UEeU6octdL2WUXvls=;
        b=e9OTY5dcMFn91EfkwVfCPFnf6vdbxPsWI6hFo42Ze/GwoStPKgO+o9Bs2tH49V7KzG
         kBe0J+MoKRRKshLgnMm4FnoFa3PSPPsffOgp6n0N1egtHKpYvulUXgi+9r2r/idXD4gJ
         YUNlsXdb1BDBh1BQp3NKX4Ix3pYS7mRcDztWdy5+46hg33mClDmDfpG6YrDxnZEO6vsO
         KMeXKa/W6pSgEjDWs1YNvJlVJelK5MFoaAocpMtDDZysL+KNrdY6OU0UL0CZcpv8ggAZ
         r7ynGs9NDbeivjiXnzYOnKjOlRwuKQjHaPxJtw4KWvw+taxMJPudgqD6ISx/TAegEcn1
         0gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524599; x=1735129399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yosLr6vP9MWE8IT6YyKdm1c61UEeU6octdL2WUXvls=;
        b=oPDvt1Zl450sLnGnhZASfUbTfvIzViBViMjj/A6+gQwj+8TSdTFQk+fAJRld1BomYC
         V+G5MI65QJU/7MCUwwM2xFbin0JDp9cp24dG4PrT+ebJZaqGZ8sN7dc8UdQKddTXXDa1
         ZPR/WEEDFNwHX4ICVDeDhbXNDZM5zrmxR8nQgrxeTfRdexCZ8Sdp5L9o8Ky+vdPsZAnn
         J+spkWItKNQUa0L4ixtz7Y3z41mYJL1v/GnnNlRTECfJX/PVMcOGrS1pWboWsAmAZZ+j
         7F6sjxtI6o2ZvElA7KLnziBM7oiSCVdyTcPtwueJ5C79JmsezxUz6IinmrnmBo/mP+/j
         hnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUW1XHRc70wp8/fKYqr7TQfvAZegNQv+yvtu5gcD3XdYL0IXHKchbNr/HJuxvnbTR2whDOuay2@lists.cip-project.org
X-Gm-Message-State: AOJu0YxH173SlDufJ+hE/50IDznJu0fGeVnCKsQaiai5NAVeOMb1AWTw
	JrHU1fPjPjNf4cywbyjuvxHR+WntKkwnEYZ5GFy3mP3bmtfCjwNm3Dt/QEhxjK8=
X-Gm-Gg: ASbGncvE+zUojWti1pTTT9e9Z7IF15Vbw5kjmMS9Z4Yw5ob/OE+YKKbBHiu0ny/vxf9
	t7S4Cb8AnOkR5d8TUo42Yt5KO7IUmWDeLSw+AK+9mGz8xAa5Kh6b3RaQBuIgXYf4GeUVhb5UB1e
	eJwYBSyYjsKNuTP30x5x1fXD9Bx2bg9YdH3xcAa8B5OrR4CqEiFY8OnnMFuJfFDnKsbsKOxw9wl
	dpUI0Uf6ciUg3vR6siZlZAVDkif24klp5BBwfx4RcFPesghxO4HdEqxpvAA/gdVN9h4sksLKuVZ
	79XaiAPesnM=
X-Google-Smtp-Source: AGHT+IF4V340v2PTBjckpIbuKW5tRjOZDSg7WlGLfnJ7Qtiocy/3OMDfVofZEURqjQ+hWbLJhmKpfQ==
X-Received: by 2002:a05:600c:46ca:b0:434:f270:a4f0 with SMTP id 5b1f17b1804b1-43655426983mr21235845e9.21.1734524598749;
        Wed, 18 Dec 2024 04:23:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport RZ/G3S support
Date: Wed, 18 Dec 2024 14:23:07 +0200
Message-ID: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17453

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Series backports the watchdog support for the Renesas RZ/G3S SoC.

Thank you,
Claudiu Beznea

Claudiu Beznea (10):
  clk: renesas: r9a08g045: Add clock and reset support for watchdog
  watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
  watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
  watchdog: rzg2l_wdt: Remove reset de-assert from probe
  watchdog: rzg2l_wdt: Remove comparison with zero
  watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
  watchdog: rzg2l_wdt: Add suspend/resume support
  watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
    handler
  arm64: dts: renesas: r9a08g045: Add watchdog node
  arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  14 ++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/watchdog/rzg2l_wdt.c                  | 133 +++++++++++-------
 4 files changed, 103 insertions(+), 52 deletions(-)

-- 
2.43.0


