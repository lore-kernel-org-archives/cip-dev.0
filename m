Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16AC36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:02:24 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.41029.1745816480691497940
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dnJVltEW;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so8030583a12.2
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816479; x=1746421279; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7cQ/p+d1UzDIO0ZYvdXPw89lhIsasK9YZypVu6R5Pc=;
        b=dnJVltEWXNVeghGtyzie3ymspoMu0QJiKMFbH/rWBnlnoplBcPMlTn3yGYXNydTNxu
         DuBz1G4QM7QCJ1j1z3rNvQ4eiVHw+fkIjYpe4fpxlZAJmSACP/0rJXcc6HMRJ1bnkDoU
         psCOyPD5K5lhdzUuwXZqxWXPkOTvW1gEzHL3mHDGdE+3MpHqiNaDsJqeIY3kCyZPDtu1
         p+zanPCyQSOLQwT9JHsMyz5nMjCvUG0nRSiDz/14btGuMFbITcwLkbO3KjapTIihGbpN
         sAXzZMYmDIb4uLL/9pUf0K4XlKI9gWAHUsd+gd2H4NDjH8w1azA3T297OolyHEXsoP3z
         A+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816479; x=1746421279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7cQ/p+d1UzDIO0ZYvdXPw89lhIsasK9YZypVu6R5Pc=;
        b=l1kre+axO37emFAOBfWADecHPcP8nqlQyZ82OALTNTmvIn8rQ9IbFkxWLet3ErjawT
         IH03WrSqfVGb1+N+2C5mseIRndDs7bBl04HWn+bsG0S9nMi6/Z9H4bPLfr0fk692x7ss
         mRwBwsATzbsMj8flhujmcObESEXRGZ7ZOwkQFMnrix5AaTaU42w66cE2w+haXNVggmde
         uzYumKTtuUJUZ8Gd9xeunconhsem9re1KfXn0jyHste1tyZlr83qGoHDLEo2LnVtJScz
         GlNaPcOAOv5am5h8Vs+lICj/tK0c/nvt0+/qM5MOdUJ4a/Rpb/pNbEVIY1S+yni2M3Xs
         augg==
X-Forwarded-Encrypted: i=1; AJvYcCUv3R/W93CmclSIdGTCvnHJKBp8zv75+Qsq2Q6DbRWt42bgntItTQIjbNNh/+gMYrg3j0wZ+hVo@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywpqneqrd7HbQogfnRcqG0O0Bms0ePKgUhUbyU4pki/KX8QkDKM
	zmqRrKhXMzyJjIzdDAja+NoUD7mxiJOlyBUnLWpdw9hwQuAFvv5FchTXK6LtgGs=
X-Gm-Gg: ASbGncshUxMqjQoY6EeXLBT5Njh8oIKiBy83zg/uzi7dPmZLv+BMn4PIhjlvh1uHerk
	QucFIUeiz3FN/oGJH56Jy7eQ3bGpY/fbRLiMegs+J9iTE/hnDGGmGguL+vb2JpsobMy51dUu+Gu
	nesXH1z5kUFrtLpgjAB/YJRRVR6tNM2IIfzcrb2v9b0RFM6Y1f/3OmeDHxC00n3R4VVGAMArKLn
	sXiNw6aRuOWnzIywh5XTUx2hPNftSz9TMMdggVSU8BswA7LLwLBDNtB8A/gAfotQxvZIB2EeaQn
	/umzQiwElaDyjUzgFT9XJjYc1OZaOtgfJbtY5S1dzCTx8b2YoKnLvuho8Rp+mxBfgIQH5Ro=
X-Google-Smtp-Source: AGHT+IEUldidQvsThyimqrgOjWM0tGnvvHyUm6+7E2EwYSXvuazVOBSlezZCAYS3j5fMX0NVzLvKTg==
X-Received: by 2002:a17:907:7ea5:b0:aca:c864:369a with SMTP id a640c23a62f3a-ace848ff5admr707915266b.18.1745816478305;
        Sun, 27 Apr 2025 22:01:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cfe8sm566055866b.17.2025.04.27.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:01:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 0/3] RZ/G3S: Backport DMA
Date: Mon, 28 Apr 2025 08:01:13 +0300
Message-ID: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18673

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


