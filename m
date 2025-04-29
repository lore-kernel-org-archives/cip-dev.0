Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23DC3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:37 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.20359.1745934509627160408
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VkYDlRhu;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25d2b2354so901571966b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934508; x=1746539308; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVU4qcPi7JbXciTwe33Qna6a7kM/bMtIUKm+h0MSCb8=;
        b=VkYDlRhujgVq8riCyLQJqKPDvMypJUaWeZ6pELXa3u5AxnRx0At5B+ZqG6UKek9d4g
         6+9hVqhU/Fy7ie4EBsvNbZ4mfGUs81IFMTaQ4DRtmCrf4LFHIyNHGe+WWUt819Qo6sI2
         SPydgNn6oO4ZPXHvIALfIVMYQ1Nam5TICrwh6BY+QqhTydo6geBjDKe98ytCfFAIA7ax
         F5UH9br7qZjzJpgrpny/A5ycbujnfUMsN92It+JwmyWB1rUM9Y861ItMlwhwBuJfiiym
         jPGj8/rLL1bUYycX27Ej8hM8cmD+Si0XXXEqUZlO2+ddvN8L2SkQ9b6siMvrNC65RBbV
         QkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934508; x=1746539308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVU4qcPi7JbXciTwe33Qna6a7kM/bMtIUKm+h0MSCb8=;
        b=rsddeiayzPDzGVDKL16Xhk0MpaZDHDULi0oTjwTirIeKsqxDtZN5kPsWDA83TVVaJm
         Wfr1XpoRXNz40KFI8pKuAxQigfWCPzlgqeNB4A/49fDZCsJEz9ZskRacVphLsqvrpX8P
         4N9ZrIADeBq2rkc6s5I9f+vdaA0Xa+OpFwsVne8Zk3CYUiRlY1W/pV+uq7/izfXDri8/
         CSgekfOfSC9Ren+ANkp2tgeZh7QiHE9TW4hrsUwW+3lTuBWBYIt269lw1otOgKi8XFz5
         DIbWgancEn7Mi9FD5M1yl1s7eVpSVgi4Lvd9IU6cuoUXWAr8XgIFngz47WNr1fEHmwS8
         BJFg==
X-Forwarded-Encrypted: i=1; AJvYcCXc3BMJEvrdg6QkeCVqKL84f+HLZ40Xuq3LuEQ8PcxG3I5WTP16sf2NFxTIhiHmwB1mvtXg9jwn@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx6aBN0j4PNk+4WUZ/mHX965Syiw2tCMobDjMfic9rX2Oh4M54o
	teuA0WEsmzgzO9I0nZTYpYEiNT+lJQMZVuqqZDud/c7ML8bIGuU7EW/iIXS1Yxc=
X-Gm-Gg: ASbGncsm4A6kZYdSf62tiJ8gNiQONc4bSXXPGsm3RfwGZbBO3x/eIevqFXmzmWA//db
	mUrzWq7Fc3uSDNPK2IyXllMFoe9HEXMlpxXszWqy+QaDKr8IOvEom1sLPPTP10wT8SmtO+7/Fza
	jVx6ClM4VAw7H9OkjA6+cEKC/l/3UoIU56jREMNKLP83BoVdqG2mE0W7txbCysiPZPHprjSqze6
	FliIeOCz5QGKHJ2Mun2Fw9MVVMuYeSNBJMGA6eAPiHIOxUGzfXLWbWmxkr4JmJL8gRt9rwZGRrn
	srHVMCsJYa//uBJK6tE343hh6uw/plfeTqmOBzwQ/jCPXNR7BlGKjS2EB+b8fB+dRxuGWOM=
X-Google-Smtp-Source: AGHT+IHgWbfUOV+ZJ9KLjbLrIkH6AbAeVjZ4MsPPEjlxTsISIb99EH2Tq1Eju9TCP65g/m6EWZWyVA==
X-Received: by 2002:a17:906:c14f:b0:ace:6d53:3da3 with SMTP id a640c23a62f3a-acec4cb226bmr383316666b.23.1745934507945;
        Tue, 29 Apr 2025 06:48:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm780033466b.7.2025.04.29.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 0/4] Backport I2C
Date: Tue, 29 Apr 2025 16:48:22 +0300
Message-ID: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18735

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S I2C support to v6.1.y CIP.

For v6.12 CIP none of these patches need to be backported. Everything is
already integrated.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    I2C
  arm64: dts: renesas: r9a08g045: Add I2C nodes
  arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
  arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  5 ++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  7 ++
 drivers/clk/renesas/r9a08g045-cpg.c           |  8 ++
 4 files changed, 108 insertions(+)

-- 
2.43.0


