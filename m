Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75DCDC178
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88495.1767701181379949476
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VTCIuFor;
 spf=pass (domain: gmail.com, ip: 209.85.128.65, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775ae77516so9762185e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701179; x=1768305979; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KFPBkSUYwyXnPwmBWlXH2Boc2ESpSdhHEWOp0ChcoM=;
        b=VTCIuFor0Iwx3Nn2Wj07NyGtXxGvnt8eZLdwno/5E6qVG58qVoVs+wRf6CknTH2Hin
         dCypA+kAJaGLEfIPl/NhLJ0/tAcxN7VDu/5uLAE4JeGfm7Xc0DzI15m4TtoialA+XYPo
         CV8u9iH1e91ht9Xwt//2MFHF+QLM+urpwkDZcpDup32bivNJQwUjGv4oNuX/jnaCYhAx
         D1Fr2glGvOBjSAIIhVK35gqL9nXcHRgD2h2NHlOX/+mOkU0Twt+fS0MdcZgVroa6OvE4
         215cWbUj3JzvqFs1CKOxJSJ11Y2NQp6qUL8+El8D1Bp/CFV4UgPIJerlRub5PrASKbUZ
         1GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701179; x=1768305979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KFPBkSUYwyXnPwmBWlXH2Boc2ESpSdhHEWOp0ChcoM=;
        b=QCn89GpkfLojpt7SjPcuqISDTKGMmNg+PVwZndCLgUhEywqJ80TxaMjSDo4CwU+YO/
         tfARTrhCL8dg0pC1gl/7N71yS1fe7COh0z2blBnH6Vk/j8cl9OROSzo6vDaV5GvWro0v
         zNk5m5CjWIJhdxHPAGmTwWtr3QNkJwCN5YoVWnKfI3ak3Ga/P4chN1C28RSNjfwNuFGf
         ORkV+5tMJa8hS1lV66mjs+iFPbICiHfa3MtuYxcDNoCkgL/qU+rXpLntACnTGvP4NSXC
         bb3lsHP6ngGYrGj1GOv/gAAM9gM70lZI0ekzDT4pHcLFjCgh7jp5gWlZudypnql+e4Rj
         vGXw==
X-Gm-Message-State: AOJu0Yzy6CPztIpR1Na8TjXG/lc2ECFeslNBkBBoMEZL5QoJn4X68pau
	a2zPnNC+N2Vi0Mm/fXQizxjU8XlZNDNoQps7nllH1eS9FYc5wGQKYjKIfZzwaIuS
X-Gm-Gg: AY/fxX7aPxD7GUblnVnAHejFeEst+2MCDE5Qy4lAIyGKqi3GmKAA9DSAy8wiQobmZDN
	wMM/Hwf92stHA/yWCvyYLinq0GQB6OxMhrrEDgM8Q4BattqFTodpZppmd5IHFCy5D5upg4PYNm2
	6bfXEI3K+Sksf0MvUQachxW9lFjFvoN+naoZY8QOMWcaDiMo5RUGcKW3KDUVGGi3nn0r8KggziF
	jiKhyLdE5ZOo2Ib/H0in+Z/P3DZaVz9hUZZonEYBTXrLYse7CrzlIgga+J5FYm/8EL9+byi3GE6
	62gxeOEN0q+2m42CsxJzSuXsPGp7dK0Vx6GkiTKwS2RfMVJy76uD6SWVmcRjzwrCOqa9ug2bW8r
	AhdYWxzwfvju2PJ/7VLyYBW4fvhNPeAQJmwup7HpTZIh/DngEumVjviwkxB3u0O3SStXfneKWZ9
	SXO9TAk6MRE5vzW1dVXQ==
X-Google-Smtp-Source: AGHT+IF6rbtGRz6H7iu8GofpL3zXcNq+wXi0cBFWmUvS6yh6Y8pxo+da465wLZspTexRr3iL0gmArw==
X-Received: by 2002:a05:600c:4453:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47d7f0a2687mr34057965e9.27.1767701179513;
        Tue, 06 Jan 2026 04:06:19 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:19 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 00/13] Add gpio keys/sleep button support for RZ/G3E
Date: Tue,  6 Jan 2026 12:05:57 +0000
Message-ID: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21360

From: Biju Das <biju.das.jz@bp.renesas.com>

Add gpio keys support for waking up from s2idle and sleep button support
for entering to STR. Wakeup of STR is by pressing and holding power
button. All the patches in this series are cherry-picked from mainline.

v1->v2:
 * Dropped duplicate SW_LCD_EN macro in patch#11.
 * Dropped squashing patch#11.

Andy Shevchenko (1):
  pinctrl: renesas: Mark local variable with const in ->set_mux()

Biju Das (6):
  pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt
    control registers
  pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
  pinctrl: renesas: rzg2l: Fix PMC restore
  arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
  arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control
    node
  arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI
    function

Claudiu Beznea (2):
  pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
  pinctrl: renesas: rzg2l: Fix ISEL restore on resume

Cosmin Tanislav (2):
  pinctrl: renesas: rzg2l: Remove extra semicolons
  pinctrl: renesas: rzg2l: Remove useless wrappers

John Madieu (1):
  pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling

Lad Prabhakar (1):
  pinctrl: renesas: rzg2l: Validate pins before setting mux function

 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  37 +++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  31 +++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 247 +++++++++++-------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   2 +-
 4 files changed, 227 insertions(+), 90 deletions(-)

-- 
2.43.0


