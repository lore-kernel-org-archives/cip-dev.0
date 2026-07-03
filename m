Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28EBC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:05 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89966.1783073279004500528
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Jq0CapXv;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b27c7451so14559305e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073277; x=1783678077; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ksWAmMfZTGO6MefdKGBWIDq71SvRCx/2kMIniRGsUA=;
        b=Jq0CapXv9vdJB1NGlbal+3hz1y9TeRZpNALUlAhvPqTLplMdGwl8T7CjPLeL6V0EEK
         CTOgYeLbxyngw7GDc8gTg1ReQIhS9QsZmzBJXAJ72yJpzk+I2CSPQDowVxc6tHB0LDZW
         2E2VIX6RjzEaRQS0TLZu1TYJF3G0JlZzY9qgrGhwileebqvPKka+heCbNYGf7Lbu6t10
         +6f+TC51opxH+496DtXUdmhLZ1AaCNN04NVFPFOtwpfzexqZijLwFKtFGyDgv4GMWZPm
         W4h1RAVbd/hpzCgEJTFioT82WfRtst4bPM1SOrJ0ZAxsYguk9gRyYDUXxkP6nkBoDhAX
         jSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073277; x=1783678077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ksWAmMfZTGO6MefdKGBWIDq71SvRCx/2kMIniRGsUA=;
        b=N4iKJg3Mg1cOxBEWuvSoqHZShzz0rXfSJ4GOc/0324K8+n4IFxmq9uY+MG/DUzheaD
         pgCxxfobwgjNcMr9O8xhEVr6w3qBJqYxCmAzOu/VvEnNxZSf6QXpoUMMV1b6jSJD+wyR
         CUM6TRSADoXEj2vn6Z6ejTpVX4X/W6yU3uXclpmgK57x0IckBJ3LiP0HJ6r2gGKlq6hi
         MS5N5Wpnc5Zctm0rTxvk0yVCGbQHRQuQRzOr7ZadmATTcaQz1lWScC9iXEd/z8l51B2W
         9tC1kvXcXbmrJl7lTrxs7FtsP3Oa3tPmtePs9JA2++6TzfLjH8AZUaBmgua53njcAU+3
         BiXQ==
X-Gm-Message-State: AOJu0YwZIADSgYTvW0fsSZjeetaAIg3TmmHy2GH4qHJPx5A5MFbRCq54
	CRpA0Z9qT4YS/PRta5KgB93dYP2VCVJoecAOZWIe8pMKrwaPjS4yU7kajhclkxaG
X-Gm-Gg: AfdE7cnX+A5d0JcBSd4KN2kGSPaQuP9lBuWJDjSKvZ8LNFmWACXazrHUHPxFBJV7PEs
	XEx+Mc2+oq+VQ/GH9g3dYlAVQkO2vrm2VOFqmLRjjGj8PEC5Aw1jm4kUoihvGaxmEei6oU0PPVx
	LliScmTV0zuMC3OMgcMf0HwqcsTjiDS5p8bn0MagkC10nX6Ugee1ulxuhY8jZNE/WFaNSgjYF7j
	eDFPWxP23hrFjOKEYQBsu69VGHFDlqRLdZ/07bMu9/e6FkiE51lhuQBfBUIMmn+0uuprPNfpFPN
	mq5VAlsKYyieazps9G6VjihOHuRwJN45LPpB+KP7oR3YZ0lbOQTgOPlWe9QSspZfs7HiLQaBdXM
	YLg3ZSgZ6Mj8VzC6miQIEX+AauLK4QSSnpeYZrW86GYI29wkWlrLrRYam89Kpd+YW5v+PV6wX/q
	0ad40D/X4ByFY+BcjJRqQ2
X-Received: by 2002:a05:600c:6217:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-493cbae3312mr25059035e9.13.1783073276875;
        Fri, 03 Jul 2026 03:07:56 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:56 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Date: Fri,  3 Jul 2026 11:07:19 +0100
Message-ID: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23392

From: Biju Das <biju.das.jz@bp.renesas.com>

The IRQC block on the RZ/G3L SoC is almost identical to the one found on
the RZ/G2L SoC, with the following differences:

 - The number of GPIO interrupts for TINT selection is 113 instead of 123.
 - The pin index and TINT selection index are not in the 1:1 map.
 - The number of external interrupts are 16 instead of 8, out of these
   8 external interrupts are shared with TINT.

All the patches in this series are cherry-picked from mainline.

Biju Das (19):
  irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
  irqchip/renesas-rzg2l: Drop redundant IRQC_TINT_START check in
    rzg2l_irqc_alloc()
  irqchip/renesas-rzg2l: Replace single irq_chip with per-region
    irq_chip instances
  irqchip/renesas-rzg2l: Split EOI handler into separate IRQ and TINT
    functions
  irqchip/renesas-rzg2l: Split set_type handler into separate IRQ and
    TINT functions
  irqchip/renesas-rzg2l: Replace rzg2l_irqc_irq_{enable,disable} with
    TINT-specific handlers
  irqchip/renesas-rzg2l: Split rzfive_tint_irq_endisable() into separate
    IRQ and TINT helpers
  irqchip/renesas-rzg2l: Split rzfive_irqc_{mask,unmask} into separate
    IRQ and TINT handlers
  irqchip/renesas-rzg2l: Dynamically allocate fwspec array
  irqchip/renesas-rzg2l: Drop IRQC_NUM_IRQ macro
  irqchip/renesas-rzg2l: Drop IRQC_TINT_START macro
  irqchip/renesas-rzg2l: Drop IRQC_IRQ_COUNT macro
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Use pattern for
    interrupt-names
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3L
    SoC
  irqchip/renesas-rzg2l: Add RZ/G3L support
  irqchip/renesas-rzg2l: Add shared interrupt support
  irqchip/renesas-rzg2l: Replace raw_spin_{lock,unlock} with guard() in
    rzg2l_irq_set_type()
  irqchip/renesas-rzg2l: Clear the shared interrupt bit in
    rzg2l_irqc_free()
  irqchip/renesas-rzg2l: Add NMI support

Fabrizio Castro (6):
  irqchip/renesas-rzg2l: Use local dev pointer in
    rzg2l_irqc_common_init()
  irqchip/renesas-rzg2l: Use
    devm_reset_control_get_exclusive_deasserted()
  irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
  irqchip/renesas-rzg2l: Remove pm_put label
  irqchip/renesas-rzg2l: Switch to using dev_err_probe()
  irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()

Xichao Zhao (1):
  irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM

 .../renesas,rzg2l-irqc.yaml                   | 157 ++---
 drivers/irqchip/irq-renesas-rzg2l.c           | 627 ++++++++++++++----
 2 files changed, 536 insertions(+), 248 deletions(-)

-- 
2.43.0


