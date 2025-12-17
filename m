Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F1D65544
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11768.1765967546001904123
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=I8f3ilSq;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so929959466b.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967544; x=1766572344; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DkC23jSofmo5i9gBcHMZSR1s037o84DY3V7tY/fvb4=;
        b=I8f3ilSqWeQ4RqsWYCK7OsJmCUTjQrmXeurDDP3LAqMQTmBUUDGMd8RnRZIeZz9xS1
         k5QAxmIWR5PazSd0fPD7t1eC7pIjQlNDjZlZXzlWa6l3DQKO6+PxGkDCC7G/F8soScpJ
         69AHSexqMPAHRde2aBmJuLf8qOaDhTnUgDhZOiBrxA+3A5TY98q0XhWnr+1ErsPA7Ovk
         KQ3Dl3acADYip8bvR9fPatOvlbRXQEGn+KVRwMz23hMhn4AZYso7Je426lIZM1A/Gdw4
         FUu/TJRaJPXIV/d38JvKmJPGBvjGLANkWYkbmYlpIm484t8Cc5oBkTK7Bf/pDxBztIvY
         prYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967544; x=1766572344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DkC23jSofmo5i9gBcHMZSR1s037o84DY3V7tY/fvb4=;
        b=EHsDKxGVk1OB2P1jsZT0kkLFQC1xD0vfq+y/juJ2007nwC4RIZI04mUR8U/Vpv4C/m
         78NTVnDP5hJ9f8p5xKlSu+Jor1KX65Pmb2yNYul3X06vh2Qgt8ApPAsLItZcwUI7jcpm
         ci+23YHp+LSmVM5NrPGhEuvnphTEtVZTr34EHo+zpBLHu8mcV75EijcBCtgaxJldFEvZ
         ZQZaElTXe7RGJiHv8Hd8ey/o4o6pRBsgmC4CGEAbvybvnjKTFtj+c3Ahfyv1Q5pKtb5R
         HPQHoOZ4P/rw802CoBz+Uapos6umd30bfAKpF0qsQtWl977j4lIcwCsDAzeJM+JWW/CO
         H2LA==
X-Forwarded-Encrypted: i=1; AJvYcCWzqXmFLPujrarbST7ZTMR4M7wbZYLP92R/+MO/0G4mg4HOGFAGtyN9Dmy52TTw1byqj7rf06v5@lists.cip-project.org
X-Gm-Message-State: AOJu0YwwRUnpilg6nssbDgEtfPQLYhVkNjIf06B35ki2rtAuZ9UBjmiv
	0GMxbdRjFClkGs96NCMM/yncg5XtUXAP2ycIvUQFcSUV9ASvyMfhL8SRJR/PLh7md/KcV4fTrjR
	A0NOS
X-Gm-Gg: AY/fxX5USGVHD8yj+GDDAKBaJE9N2zdeDVWBtEvX21Fq5jhzsh7DqfFK7jE2N6aA3c7
	viaxT9/nIW2aQcwGB1Xs2OOijbWCf/HDSv2OJm36jYlM1AEHUyWr5ELv5CRXQGeh9+VJhlnofbd
	6PpefQiPcfOW8PtbS3/Atft5OTxzRW9jEwbJwPtPy756JpBSAq/GF2Kp7g8P4426Nzh5ml1Prgv
	rDpIBe8DfxLh8cDYFBRam+K+WZBSEyQevGkJMxvsaDfmt3ncBsVlZPCge318h4nNlqPxof0rVkI
	BSHEALvIDtHy74m2i928w+xeRozE1IJUzDwayqlv9Y1wiJpHoimb+ehdwSDPp4x5psJqScr9fsS
	IUv3vlDy24BJ+dhhFH30LAVeBJJ5YDNzW+oQfxYPJwktAan+1e88Sb1OPE6CoVG9K6EPnwAclkV
	IzSTQA37tqYrlG3OKz68kAJpkl/RBo1uMh1q8N6XcRsYq2ZV0D3U4=
X-Google-Smtp-Source: AGHT+IE8TGQqFkP/2tL8kLEtrTBbpqzGdW1JQwN/TVG4o7uGTDb/g8KYqHgqUg00tHV2IE7+E7ISMA==
X-Received: by 2002:a17:907:3e11:b0:b1d:285c:e0ef with SMTP id a640c23a62f3a-b7d23665c6cmr1977974966b.26.1765967544310;
        Wed, 17 Dec 2025 02:32:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Date: Wed, 17 Dec 2025 12:32:16 +0200
Message-ID: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21113

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.

Thank you,
Claudiu

Claudiu Beznea (6):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the TSU IP
  dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
  thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas
    RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add OPP table
  arm64: dts: renesas: r9a08g045: Add TSU node
  arm64: defconfig: Enable Renesas RZ/G3S thermal driver

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
 drivers/thermal/renesas/Kconfig               |   8 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c       | 274 ++++++++++++++++++
 9 files changed, 465 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

-- 
2.43.0


