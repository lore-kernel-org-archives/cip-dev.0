Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B64CD1294
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.32661.1711528511614802353
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IB0GAKzd;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so2532063f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528510; x=1712133310; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uO8U8L4wNM4fxHkWMNRhSkACaB7pCyVJ0potag9xvbw=;
        b=IB0GAKzdDE89YpFY2jGQkZr5WYZqt8aWhvF0mSwqwuRfdwr3zFr/5vr1YBrxyDoO7r
         lWk05ZwTuKqN6cE57zEsn/pUsS0Mr0bDBqKoXtetQiD4sczjyaphIrY+oMgC9CrgHQjo
         Xkd1wgPhXrWsYszKODj2H5tDCtaU/63nvs/OFOmUMCsIJPkxjXod1/pOntNpbMqBtyOT
         wMcaFfPWL01TfBpvwNE0QO3M0cM7APld99PF6WWA6yDjbIME/28VrwSMIg/3/LjL/4ZY
         5A7RI1kK4VCL3sH7yxOPxyGuoyjH0NgzBJvlSyKVc4dpWmgh+Cxy/BtC+pwhckLAxAI1
         S1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528510; x=1712133310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO8U8L4wNM4fxHkWMNRhSkACaB7pCyVJ0potag9xvbw=;
        b=nKFmcPysMpivd28YRqHRWdDKN/h8tWJJqWT16JW8u6R5WwDegUP+gVhGGPtpq/Yi/U
         OOT3WQmOSqij96ztYhlNLWMsv+ZPFMS8VjY4vP1DafnuCyhRalHmyNMI+oWQtpeDUhPa
         Kn69CMJS9fEyiW+PB3W5nzEyrXfI0j7VS5MRvPlgtPGm6mskO/7y8uYGHmD3kgGeupw6
         1XFcliINdfCsh3j8fDsrjlITpE67J6RCcjl6A52E7qXcXDOyPNe6q1asKHirlgtT1mSv
         P+5818bQz2fV/pTWn3AVYKZp+plmPA1NDvfpqVjBx3g2RKRKL9OWZzJr1fNyeGCTik5x
         IHOg==
X-Gm-Message-State: AOJu0Yx6Jx/HfqQ+/Y2mOtPDCl/lx9mDiLi8t6fnQtA2rkMg3XrroN1E
	7Pg6ZLAG6EZZIls74HPDxfe1+UCL9Lx0Sjy7avdIDogLhiRgmmAaMJyzunssxLo=
X-Google-Smtp-Source: AGHT+IHWBTldge7MaaqK4dLfj8Z61j/us9eAt0YZ0MxCD8Wh2EDZyJ8gB4aDczRalw5FQ/T6Dtuy0A==
X-Received: by 2002:a5d:6703:0:b0:33e:9311:5fda with SMTP id o3-20020a5d6703000000b0033e93115fdamr1231579wru.29.1711528510039;
        Wed, 27 Mar 2024 01:35:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 00/13] Update IA55 driver
Date: Wed, 27 Mar 2024 10:34:55 +0200
Message-Id: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15454

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series updates the Renesas IA55 IRQ driver with patches from
mainline kernel. Along with it, a patch for Renesas pin controller driver
was cherry-picked from mainline kernel.

Thank you,
Claudiu Beznea

Biju Das (5):
  irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
  irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
  irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
  irqchip/renesas-rzg2l: Prevent spurious interrupts when setting
    trigger type
  irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same
    time

Christophe JAILLET (1):
  pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper

Claudiu Beznea (5):
  irqchip/renesas-rzg2l: Use tabs instead of spaces
  irqchip/renesas-rzg2l: Align struct member names to tabs
  irqchip/renesas-rzg2l: Document structure members
  irqchip/renesas-rzg2l: Implement restriction when writing ISCR
    register
  irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset
    based on register's index

Geert Uytterhoeven (1):
  irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()

Nick Alcock (1):
  irqchip: remove MODULE_LICENSE in non-modules

 drivers/irqchip/irq-renesas-rzg2l.c     | 115 ++++++++++++++++--------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c |  32 ++-----
 2 files changed, 85 insertions(+), 62 deletions(-)

-- 
2.39.2


