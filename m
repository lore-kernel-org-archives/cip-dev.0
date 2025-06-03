Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18427C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.7092.1748942346589675511
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MgtcafRv;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88105874aso846704666b.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942345; x=1749547145; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxPoNh10+qqcyw1arnhiQYj7uSI7piBpALGHS+sHIUg=;
        b=MgtcafRvsX6770GiS+0S9Kq8YhB4M9f3c8isING9t31FWzyNzTRau2lvRGVf+EBNF3
         cyPid+KrTnLlJmANsnukOp/A2SxFCHZvIAWpmwzdIwkKFZK8k/8Ysv+tgPXtNkJg73/r
         qg3fG0zfcdgMvWJdAV9pAE6XYUEwYngIOobKNDQyVD5Xb/XRA2lsW1w7sBH/fGKmYIQ/
         FyO8B9rAjL9MUNfJ24X3IK7QON02lP/ociNgToDwmZIgHpVYTBnohuEAGBfwDDp3aviZ
         IvDdvJwUrrNhObGNtWlgB1gZ2fAPLI8rPSSnKRr0440HNnbyN8I3dKNoVVYza0Ca9L3O
         HprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942345; x=1749547145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxPoNh10+qqcyw1arnhiQYj7uSI7piBpALGHS+sHIUg=;
        b=GYyhcIOea1J7TEoj23zJopKrYBsntUC3EqiwBav6uvmQd/aZ84bplrJrRrksuNuJjJ
         0xB4/fqpqJMerM5RYR2A0j1eh0893z9XO8PzZuDXO1uU26Q4PzCV9JdFmjq27m8pNNuc
         lclEgw0L5COjMWxBdxRk00oNWur5/P9wYNAfb3bCjjcokGMQWAKozw4jJnJSvyskg+y9
         3+SWc1QzfHtyM/rU5rSHj4vy48pFPPvca/ftvigjX0xt2uYWbBYmLhqkPY5FR7/viRdG
         /BcTf8KzWXfFbpSGsykrRQMnvpQsfwcMn+7h83/4MApQE48BW+/19035u4Nia/ID8LS4
         DY+A==
X-Forwarded-Encrypted: i=1; AJvYcCUlCTlNyjzj93XPZlUmqGpCxhCDAfjAkAZhtzFB2zdQfCye1yzPpwL7fWOii1v/3HzA4/99aMRR@lists.cip-project.org
X-Gm-Message-State: AOJu0YwPo9wKyBj1WKxL13THfpmswSY2hi01vX/GGIraRxn2XlvtSmVU
	q0nhjcR7ypvAjbEKlzK75lFvcIiMnunlMwzU3wWo6s5R8z9ry8VKRRz5LRUdBAvWoSQ=
X-Gm-Gg: ASbGncvSLVCCj3N7kw1VEeQAEoZvbnSXUB/H2tmwCQnQ+2wwyJdhjmEipMNhHND90ok
	hsBHNHRDi7DJjSVAzGKSZH2zyV8OKIzZ0BRCyS8zShNGjelqpGu02RdzdKkK3quA73d0oTDd80h
	gxzwzc+nmgAEYONo9VT9TMCBdD7nk6ti9QKT2Gv2YXA/2IyKH6qp9yFpNvS2Q90p6G0w1bmzN2K
	b4+W7CUeqFdI0XAxmqk+XMNeqla407rsPjUDNg700obgFwrB0iVDqlfJuaOJb/1V5T/Hx2Hh5wg
	ujbVIlaAVfJS90/giWRbzUUe+rqQbUEQcxvxOXJ8d0W6rDdsxN2r9TNR2p0RdGvyeDL1ncH3S9y
	qRHIohQ==
X-Google-Smtp-Source: AGHT+IFZrfO1i+w4+atZXCXDTFMyw3TqmSa6l6fSKuEve96tUrmKDBWVfJEx3sLvqnpDZ5wW8qRWOw==
X-Received: by 2002:a17:907:3dac:b0:ad8:93c0:27a5 with SMTP id a640c23a62f3a-adb322b36ecmr1626710066b.5.1748942344653;
        Tue, 03 Jun 2025 02:19:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Date: Tue,  3 Jun 2025 12:18:55 +0300
Message-ID: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18965

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S SCIF support to v5.10.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (7):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

Geert Uytterhoeven (1):
  serial: sh-sci: Save and restore more registers

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++
 .../dts/renesas/rz-smarc-pmod1-type-3a.dtsi   | 45 +++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
 drivers/tty/serial/sh-sci.c                   | 96 ++++++++++++++++++-
 7 files changed, 300 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.43.0


