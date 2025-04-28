Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAACCC36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:01:24 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.40927.1745816456129958457
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GRytDvak;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so5957984a12.1
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816454; x=1746421254; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7cQ/p+d1UzDIO0ZYvdXPw89lhIsasK9YZypVu6R5Pc=;
        b=GRytDvakyUa5XHC4KcLQvQkg3hy4DfbdX2VkL2NrMkp/mNU7Nm4Hgd9/k9I4C2C+HF
         gVd/a6fvTLF9wEbGdbP7Xk0aBmQQOoBE5ntu5tzOiYXisSci2IiuCZdetVt6ZMMj1t09
         E0lKhVbzyk5nbMdI2xH2hBtNkFc2E9ZxzSYdIXwcQlw6SlljBWH1aaZz+ttpbK9DDsA5
         4DRwAdLbmh1MXV4SIkm3geiLkjnNyJUS1n/u0OXkeM97R6gokW+C7qDj4r0zzy6x2sxu
         amCKdDB3Cn4MVI8V4gD1D/pghShAX+pCuVh84ymd6DlkScUEjVkaEnhMk0/0G46oZ43x
         hlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816454; x=1746421254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7cQ/p+d1UzDIO0ZYvdXPw89lhIsasK9YZypVu6R5Pc=;
        b=otGeSJCvnYYZOTyLnIVOQG1mtttiaVQJkdQKzhPkOLlcpBY1Gd13jC71DJoD2Cwr0h
         Q6hYMzaK1pfglfDAXyiARj545QkmxYFBcHTxEUZBdrx8N6yVpDUUAMFktsWcOI2jEd8X
         R59Z7TBPUSN3q9HWT2rPtdB7d0UbHmVq7PD0u0m/VfdNmBPgrZwt4W1GReZ6X7KJkECr
         jefHQoJhZr/xgjEuFD463RxK7ceJthdh0n1jFSFuP9NIur6FF4hlu/t7L3udUgx7KzPd
         a8Bm5zjEecu3Ap8tCbuX8Uie5tIY+rtOPWTL5GRJcao6+7hx4w9bFDzkD6Q0i0xhRxUW
         QyNg==
X-Forwarded-Encrypted: i=1; AJvYcCUiMaCqeMR8d/xzfBKMfKTArBgAukO22cSNFM3JMbYnYxiNOHYP588Sgzuew0XpEZMNjQDJiKES@lists.cip-project.org
X-Gm-Message-State: AOJu0YyONIhGxaoc1UYqvl1vC7pI82FsgrnSa/eiy5wEt9LY0eJVs62u
	e4CBZ/+rExbjR4IkKcS/o7xvg26ZP0xcPG+o51Lc6Z2B1jafGQTfsgMNKfk+B+Y=
X-Gm-Gg: ASbGncutU9DixxWIRF5azipxctF0Me39VqpMgTlOL6kfuYYFdO53r7lMlB+KUPy6rbf
	I3Q+Be1rARhCPosdZTHfaJotLJnkOdCYWdk8qb8oe41JgkBtiUU4WomQmvIeBXnUg5+r2tpsDAh
	tts60g5ZqQIfpLqsPThp/rGq7RGdvDjp8I8M77/YRjs2HNAwLK9LpaK2I46GQnwjMz9dpmj7QS8
	GcmD8s5mlgawAoDhCLTL4nNFIoceGoxGa9ruuz1FvtLZwos0DF4HHOaKz00q5d55v3py6pW1WhH
	4s8QF3GlQHDgmJ21MTpgd/7/bE8oUmOlMRNeW18nTkhBCnd2KkPkGZRMz6WD6r4kpAep0gU=
X-Google-Smtp-Source: AGHT+IGNryto1btq/sENvWlflcIuoL5bNK/Iugw6JduayCDEdBW/sWxLma7pb/YMg5rLvhld10v48g==
X-Received: by 2002:a05:6402:234a:b0:5e6:1353:1319 with SMTP id 4fb4d7f45d1cf-5f7395efc31mr6215140a12.12.1745816454373;
        Sun, 27 Apr 2025 22:00:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc361sm5176645a12.16.2025.04.27.22.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:00:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 0/3] RZ/G3S: Backport DMA
Date: Mon, 28 Apr 2025 08:00:48 +0300
Message-ID: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:01:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18669

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  clk: renesas: r9a08g045: Add DMA clocks and resets
  dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add DMAC node

 .../bindings/dma/renesas,rz-dmac.yaml         |  1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 38 +++++++++++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |  3 ++
 3 files changed, 42 insertions(+)

-- 
2.43.0


