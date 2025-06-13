Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE0C61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:09 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.7063.1749809704854104543
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ozEIFBGX;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acbb85ce788so322405666b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809703; x=1750414503; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqLwOaW/yPF2E3cHC+he+Bi/RPjZkR00zBvHjnhlwng=;
        b=ozEIFBGXRO08k+6NhxoZdfImTH3XDrZCG9LvETLNbjFiGwKm6Nub5WxrHM3ZynBumC
         YUur7mVtKqWTx+ABDUwNW9xtK+AvgLdDRAEGQSj+AWXJkVVEEQBs36zNOCDeOHcHQZEi
         THhd23ZyDqazODaKoImVVfc12rnRUWz9RoPeljMxjxN7gfEfMwWJjpEL5L1F9doF3SuB
         isnB0CgSykte+xJWRPN3Cb1x/HT0E0r65c2Y0c9Pk+BssluL7TC50os2G0ipH5pYdBtH
         miIVDK3omMBX43I9jORuM++w69nnaPICNMJuizmDHx+Cqvzv6tfnjYVu15HCZjJc8KAj
         0LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809703; x=1750414503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqLwOaW/yPF2E3cHC+he+Bi/RPjZkR00zBvHjnhlwng=;
        b=H1bs4BAHXLttgOJ5tJnO1d3Wjv3Ao1v6VoqOlgz/i8aTsf4cRzCyKNDlv5uz2ko6KR
         EZks3rsaTLCOCRazDDb/JTe2RcpO33MPM61fXoPtrWMG6zilUvLZBHjwF6tTGPE71Oo6
         1UIHxnbRk4p/cE283ZXRCY4e20gQcuczFmJkTVkvmtj7/M342dJLkuu7Xvqh2IRCTHNg
         lIyFs6SqXgkyYPbzJDYivuPE/NAfxJr0pGh008XrDCuCK5KTPCy3lzmTmE8PyIZKRXIK
         0cXjzV6N7I5HjcnpePwIYZoiHKvya8dtnPdoKoJ07eqr6dmhWwjN2loEi7iUboKFHYa1
         ijFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5/UxzdwuUJpiV4AB77uQVV+KkBE0uePgC85xWQCqPX7QwkbtOtqTNkYw0tWQyOasMWWQd8LE4@lists.cip-project.org
X-Gm-Message-State: AOJu0YzbRVYNZNpHx1H9u06DchgDwlp3KdNziwmohbrdbt9oM6ewnVAj
	n+bTJVVEGhd+wgAY6GNfm5u2OF2asDh6NKA5TBDdo9IKIALidW4DDp9DPAyZBgdB8Zk=
X-Gm-Gg: ASbGncta0fov4s4VgQSkmVLijG7LTP3XH26hiH/N04irvUP5rHbN8S/Ifl2W7uzvZP1
	YZDjajdZo0IKgK7S34Zcd2xqwb2YvXQK5wSojM0nRtPfwQkMPEVQaG5oxXW3G0KrtCIF34lJZJq
	sl9p57PV04Q6xcdizmgpfe6HJV0R4d9RxGx6TVDKrYW0fwx0VEdKloqAbcuBumwTWKGkTYjkAP1
	6/3z0awdVXXjZWsV91RxpQxklF85WOXN2ZgYaoD+IDEDnEPF4oHCqS+S91KQoAvaT2CQvOa+xhh
	P/bni7kfxLVHbxnsmloLAO0DJhifncbj/COHOi2OBsKBbfp3N4a2SknemKNx/Ade74o7c7JgpYO
	Ijv5spkDbEUlFq6Bdh0QmvtQ1otU=
X-Google-Smtp-Source: AGHT+IGp/av6CPUQe1eGuUOplAXauxg3pcEWVgfZ0/1Mexgfi6Do1qFVLEJlE+SOW0NocnvVuGnN9g==
X-Received: by 2002:a17:907:2d0b:b0:ad8:89c7:2735 with SMTP id a640c23a62f3a-adec5ca1112mr272164566b.58.1749809702719;
        Fri, 13 Jun 2025 03:15:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
Date: Fri, 13 Jun 2025 13:14:49 +0300
Message-ID: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19041

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S ADC support to v5.10.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (12):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
  iio: adc: rzg2l_adc: Simplify the runtime PM code
  iio: adc: rzg2l_adc: Use read_poll_timeout()
  iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
  iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
  iio: adc: rzg2l_adc: Add support for channel 8
  iio: adc: rzg2l_adc: Add suspend/resume support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
  iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add ADC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable ADC

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  39 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
 drivers/iio/adc/rzg2l_adc.c                   | 405 ++++++++++--------
 5 files changed, 323 insertions(+), 183 deletions(-)

-- 
2.43.0


