Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E02CC5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:47 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.7108.1748942384085049872
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cvMezz5M;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso9667527a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942382; x=1749547182; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4rB8EzDQKgxb5d/MydLXM7qixoZTNqI9byao6HLgEs=;
        b=cvMezz5Mmdt/hdnFBW40CiNmjigooUGFe59xatdU//2HoD8jPFur67U5OKaO6RjmEY
         SsIn6Z6MLZK+jhHBeTkYaXCKJOY/h+54czd8KzQJQ46mWG8z10IZa8rMoF5cvGHsVWUP
         BpW8kQwN9qHF/l8TpanlYlFZV5WPcMmQ+AwlLRy0T7wocWB9km/lJyTTCS8OO7Bh5Ffb
         QbmiWrIJFFRTeV3/g/lMMozaDWNZRN4Ac6LgqIKW5bedad3kptOi/eCZOuzzisN4VEv5
         6nj2UK6g3KROR7MryiJLOzYJw9YEWhlJzaSARqA4ieRbQKCqfZndZqkQXpA/B6N1Ekun
         6H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942382; x=1749547182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4rB8EzDQKgxb5d/MydLXM7qixoZTNqI9byao6HLgEs=;
        b=rKq2zr7tXhZFlLp62qTDlxpbRz+Qzd0cno3s6UN15kUBarcwSJp2itPsC61r+BEQ/4
         IkUJNnM85yqNgcMfOmE/kuwcMdhwaC2S1u2/lnEJVQYP4oVAaEWOFfiZcwdtTm7WgI7a
         15wQ/ovLMio7KKVkw6KGtl2zB33GDg0osjIoqULydEXb/9d43I3fnxJnZZk/FIe6Rr7p
         SYjUGoEznbZo/zUjWvKSbdhtMfUFv7I7x+zkQhqZesYxjWlvQRizzPusQGGi78ssJ1dM
         Fue/1/fa9DhWS/OGaWcufj3GjWwp5tZkz50fcftbCbg3qeK3OkNYElccr1++xCrB8Tdd
         QfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUMPu+V8thR7w1saBBCf9vraTuqyQ1LA7isbQQiXHSVJY/C5pqWYWg78sCy2fYyLiFzn3BxW3g9@lists.cip-project.org
X-Gm-Message-State: AOJu0YziTiNm/a3pqZP0y0E9SxJki/VhWLjdBius5uvVTuPbTUdACRlP
	OZE2bvvnUBi7KZifPu870aR1u6fBY1OkByxxcdT20q84VybFlqoxmVXOwN9cdZFOCN+r/J47HrE
	Kp/fW
X-Gm-Gg: ASbGncskZQ/dDLuVzRM5wY4Ykq9WgWsk7kWuCyMLTC9rqvTmwgPU7korbsTO51sjPzZ
	8YjDKqzMSR6/wp85lBx8dqduucLEufI9uyRCssHQhO9AF8TrwNAfmWoG1mejQhXdtGE0LdwK/mV
	XUCYhkYP0/y3CLvd+9PFl4VfJs1BF8XmO/23D6QOByv1oPp4gyzBFXe/Ffp4VZJ74t89Rs6dILS
	O9S0sFuI1y+EW+gk5i9arMKJfCUlD0R8FS3pf2izgflLA7dRce4zOEyeKZ3goNBML5Jzo9+8Xyb
	y21hq2ELCCFPpqepKPp7qNWK2RARFKI8O1VjyxH/XRH/4ZEQ7XvZixDPGzfI+xI630xACyAZooV
	v9a8nyA==
X-Google-Smtp-Source: AGHT+IGawebRgm4KNqsqO4pXQ2ZutMK2BT1SUXGBFaVvYxToN246u8wwTMndWC8jOkF6+BPVMSf1Bg==
X-Received: by 2002:a05:6402:280d:b0:604:5a3a:277f with SMTP id 4fb4d7f45d1cf-6056df48994mr15723877a12.18.1748942382504;
        Tue, 03 Jun 2025 02:19:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Date: Tue,  3 Jun 2025 12:19:32 +0300
Message-ID: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18974

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.

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

 arch/arm64/boot/dts/renesas/Makefile          |  3 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++
 .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 20 +++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
 drivers/tty/serial/sh-sci.c                   | 96 ++++++++++++++++++-
 8 files changed, 305 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.43.0


