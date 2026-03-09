Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F7CEF370F
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:42 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9239.1773043893437103033
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L7sSN+eK;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so14667705e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043891; x=1773648691; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAEUzOhEwow1SdjYw+P6sCBk4pZCMzXo47epXM3bH6Y=;
        b=L7sSN+eKahXSLHwyt61v0p9P1qnsYYPuuCY6aozOATZH5cG3yglDkydCidMDjrFzX5
         PeTKmeKC8c9oofZw6BFfZvckSbaT6FAhthDJ3NmtVgMgheFUay1fzKnVXxw4Egyk4zke
         zs0WodF/vDVUx7jnoJ85cZDITBI8Mt9IR7b9gtt7JuD1KTXr+gLuKgtcgMmdFxX3ik2P
         o6epKRHOW3zPPgeuQh0PkG9wiAxqtLlwZ2A1bjQTF/2l6jyDi+NBica6gb0Im1cw8CC9
         Xw5NOgWnZifgx2toQy2E7lWmA/+IjzExsShIb73XsgQN8zx18hE9747dm/9r9Ilmlr9q
         pQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043891; x=1773648691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAEUzOhEwow1SdjYw+P6sCBk4pZCMzXo47epXM3bH6Y=;
        b=JTLoE7Yb65GYGe9+mx8rp7xohmzzys95K/9FNDut3G783YuMh+dcEqjeRcGzNZbR5V
         gNKRFp5kMEneSfmZLQ6AfksqwKFTl3jHtgRbkmKUnbK2MoZJ4u50Fy5NTTFOgCY5TJe4
         llc/uOBMhpdYlIIrDjxGjVlpY6rI14vMUiviDWMFdHKR3mw1wctAGl4Gg8CAumodaVfL
         udMvVysbRXVd60Q0HpADZhrlobCja0qrztwk6MWRE+6hAjEgpp1AMJ80Vh9oU3Aw5Dz0
         ubAiZMraHVa8fAoRPEs0cDIN6yeJmudJwNcIqp+oUbDGncQyjGjTZXQDt3T0w17uznjL
         N2fg==
X-Gm-Message-State: AOJu0Yx9m8nmlAaaj2vW0pJXSuMGsIdEjmohX2pqvmgqeZOiCXh1ijdL
	NM/LeaumDc3TPvCD+5OvpS95q+PB2sjlG395Q2K4yOes+VkRONizaIeHODMsCg==
X-Gm-Gg: ATEYQzwZIzsys2xfER1N3amqSEiOcmk2kpJQyhtdsbHpWI59lU1pUEf8PA2PCCskP7N
	c1u9hPFH0cko6OlvGeREX3Jw/e7FgacQva5/A6O3zpTJxt6qyIL83X65/aeITO2DL2OEU0MFOMk
	LuYkMu7DkWCRrT7fNFEAEJJfYfu/OLOAQyOA5dNFs9WA6xykVtHWSfhN9XIAwc3l1794Y2Gg6zS
	rUSjOOsXxkAv25doUZE0nXuWs14Qy6UsYWITMq5N7YY9sMRWYbLkoZQ5rCeqaMG84bHR5AlO1lC
	0fuuVTDGfh4BBUnYyGEjXOfnrLFpu05gqM6jE4QT2a8tyMZSPLOmgb4sHAU0DHIkTG/bcXuLK4f
	Pt0GO5of6H0lHFC0IIC8Y5vG6vmRRg4wQV8kEvJXirNbyDtGMDSoW0fc1UWtAKdR+0g49qJoByV
	0ooUjJW6yGKt90XpOpLr8v4R7Xup1DOW58i6BhcjikL58beArq
X-Received: by 2002:a05:600c:1c25:b0:485:3e6c:aacb with SMTP id 5b1f17b1804b1-4853e6cae44mr15573265e9.4.1773043891155;
        Mon, 09 Mar 2026 01:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/6] Add suspend/resume support for RZ/G3E ICU
Date: Mon,  9 Mar 2026 08:11:20 +0000
Message-ID: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22155

From: Biju Das <biju.das.jz@bp.renesas.com>

Add suspend/resume support for RZ/G3E ICU(interrupt controller unit). Also
add support for CAN FD-Only mode.

Biju Das (4):
  irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
  irqchip/renesas-rzv2h: Add suspend/resume support
  dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only
    property
  can: rcar_canfd: Add support for FD-Only mode

Geert Uytterhoeven (1):
  irqchip/renesas-rzv2h: Remove unneeded includes

Lad Prabhakar (1):
  dt-bindings: can: renesas,rcar-canfd: Specify reset-names

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 71 ++++++++++++++-----
 drivers/irqchip/irq-renesas-rzv2h.c           | 68 ++++++++++++++++--
 drivers/net/can/rcar/rcar_canfd.c             | 14 +++-
 3 files changed, 129 insertions(+), 24 deletions(-)

-- 
2.43.0


