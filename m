Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F31FC54FCD
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2452.1785575702433678745
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WW0p0Vdt;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so5098035e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575700; x=1786180500; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QhPKLdM91W3EmUKNogsv0rBs2u4YlznaKZE7GN4ugGk=;
        b=WW0p0Vdt4dGP+6oP1zRST22EFlEYYVW4R0YCQJ1FYCr0ibpBldXDHSpXf+/TyQ1lz/
         LrU/t+trBG8J+jbPLAr3khexNKS9olnbyaE7W/vqJdqFteGosJ6ebtvhl+EZudnIm5wJ
         iMr73YTv09dvgFC4ZwFFrEcDmiPvUnw1vkeTdLn1cuD3QCnIBs4tlqEW0sMoJMm08+W7
         Tp4/QxILa0g12xpxhSiFGU32LgPqs6lq5evFJ6Mfg9MkRPkK/7DCHPmO19htlCDYxO/0
         R26VcvddxlpKo6sASghl0sw84YrHlfYJkO9oag4XRU00kOQy2NYLZxkgt6l8rIbo9lG+
         T2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575700; x=1786180500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhPKLdM91W3EmUKNogsv0rBs2u4YlznaKZE7GN4ugGk=;
        b=GzBBMaAP5Eoe0BYt6sPK0Ra4Zl1uSzc0dxct3HM3FdPdS8WpkadDjonqwUzqUEl2Ci
         otdcDwJNcYXfYfAI4EDwKfKhRZxWNaJzKZJp6pbD4glmrDwpB8+El96heKKsWyo6lzlL
         fifXQRCKy3uKQI5d5MtT7qu8GrGC/PIESv1+sDh5Be0CaHlQfl5aykVPFA8/7fmvCj57
         nzPdYCmdojUWb0DV4lUN6+BjUIbOdSxT7c9s7DbbFUnnsST+kroskdEpBT6a+CcDWCKk
         COmyYWwQYqMtdYoP8sKk5XNytAVa1r0sRCWzauue4AkvyjZvCHcS7u9LZED9sKUBPjeM
         AuKA==
X-Gm-Message-State: AOJu0YxUNss1mB1fD/BOwp6hUFUfzGnReY6Ndyi+4UJ74C1uL3eNmwtx
	IsRA1Yzb0nryQSdHIvvSwr6E4W52649WTGaeNDuyrka2E5p+8Mfy+jwgft9UXg==
X-Gm-Gg: AR+sD13lWajEt4KXtOkE0Y9JkF8thwaTQJ4tKvYUmXOa0zzvO1GvUtM6iOS/1z+XvR+
	Q0WY02W2jOKRRyGrkHgyd64Xny8F6dW7m3iIF4X4V4yAWP6ZeGLT2dqEfAxBtBmNUivW0XOBMgZ
	CoajIOCA5QpY3dwESl5xBXzTG2MOiFa5dfozZCNy1IlUJD1HPIa6c2Nb8vuPL7t1dJIdU7WwhKh
	i7DOFkcOXR+zpyNV5luWM+HDyAp/7OYcE7cF4XeQt+Y3HiqIqruMl34yHTKxd0nBn1ovkeynmEm
	epaqzkF+NtDgGwA+qJgCAz46K9y4tQa08CyMDU8klENuwaygvwSIRuASW/RXOu1EsWbf0940mGW
	z7sSNyEPod8V+N6UDu97TY2RsjJ0HZO9WdOIEaL8Xb3Gji0gP4b8V2EnbvvFuZXy4weuVp/0uA9
	kAcdBEuz7LgBvsK1nRyj7wrQUAfkprPlum4IlbO/N9CddU0Poe5nGazK7s+/Wg09nNt/nHZH7Kr
	cUmk4tSiVxqErlX4hfKrwEP
X-Received: by 2002:a05:600c:4d97:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-4980c694ef0mr22276155e9.19.1785575700430;
        Sat, 01 Aug 2026 02:15:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/19] Add RZ/G3L I2C, WDT, Audio support
Date: Sat,  1 Aug 2026 10:14:31 +0100
Message-ID: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23827

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

This patch series aims to add I2C, WDT, Audio support on RZ/G3L platform.
All the patches in this series are cherry picked from mainline.

Biju Das (18):
  clk: renesas: r9a08g046: Add RSCI clocks and resets
  clk: renesas: r9a08g046: Add SSIF-2 clocks and resets
  clk: renesas: r9a08g046: Add RSPI clocks and resets
  clk: renesas: rzg2l: Simplify SAM PLL configuration macro
  clk: renesas: rzg3s/rzg3l: Simplify PLL configuration macro
  clk: renesas: rzg2l: Rename RZG3L-prefixed PLL macros to CPG-prefixed
    ones
  arm64: dts: renesas: r9a08g046: Add scif{1..5} device nodes
  arm64: dts: renesas: r9a08g046: Add wdt device node
  arm64: dts: renesas: rzg3l-smarc-som: Enable watchdog
  arm64: dts: renesas: r9a08g046: Add i2c{0..3} device nodes
  arm64: dts: renesas: r9a08g046: Add DMAC node
  arm64: dts: renesas: r9a08g046: Add SSI support
  arm64: dts: renesas: r9a08g046: Add audio clock nodes
  arm64: dts: renesas: r9a08g046l48-smarc: Enable I2C{2,3} devices
  arm64: dts: renesas: rzg3l-smarc-som: Enable Versa clock generator
  arm64: dts: renesas: r9a08g046l48-smarc: Enable audio
  phy: renesas: phy-rzg3e-usb3: Fix malformed MODULE_AUTHOR string
  arm64: dts: renesas: rzg3e-smarc-som: Sort GMAC pinmux entries

Geert Uytterhoeven (1):
  clk: renesas: cpg-mssr: Add number of clock cells check

 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 314 +++++++++++++++++-
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 101 ++++++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  49 ++-
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  60 ++++
 drivers/clk/renesas/r9a07g043-cpg.c           |   2 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |   2 +-
 drivers/clk/renesas/r9a08g045-cpg.c           |   5 +-
 drivers/clk/renesas/r9a08g046-cpg.c           | 147 +++++++-
 drivers/clk/renesas/r9a09g011-cpg.c           |   7 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |   3 +
 drivers/clk/renesas/rzg2l-cpg.c               |  40 +--
 drivers/clk/renesas/rzg2l-cpg.h               |   7 +-
 drivers/phy/renesas/phy-rzg3e-usb3.c          |   2 +-
 13 files changed, 670 insertions(+), 69 deletions(-)

-- 
2.43.0


