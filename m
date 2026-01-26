Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A3CF65C3
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:45 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16221.1769420616993593485
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qUdvoMnB;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so62870555e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420615; x=1770025415; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfUHIYFnECmfc2OyolfxVczBFaGjph2hBPOY21kP0k4=;
        b=qUdvoMnBwxff+oYqbr2hPs0iPOqwWhfL9EyVShvj4WjQDIg0mSeV285kEnfbLoRqRg
         a4nMRU7AssdDZ4D8XZ5HdNOgxYte+06a1JWkvBPfq/SqBglbSM8OVJGaiYDrXOA0DoyW
         fJdrJHppEvKB3Tk24KpYyMDF6MTykAc3c3RWbrndLLWjVZeORQvHy5dLoYcxxKAoFI99
         BCG1PGBGp/ZnR/GrTSsAZxlJ9YXTK1sTlGnJ7/4RQmLdFo/SGYjnN0g/zOd8RYBOoWU2
         CuA3MLS3FpW5L89kWUIgyWRxY9R0PW1iYAspkj6Ihl6WH+FcMLCcH6zg3QoLT+19e/en
         qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420615; x=1770025415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfUHIYFnECmfc2OyolfxVczBFaGjph2hBPOY21kP0k4=;
        b=SEBi5IhXVUw3qMRySwj+4UzEP0XJFcdak+TMSAnYmJZsJwVVlrozNlr7pRQMysx0Kg
         tRWPneS/UokCN/g8dmMOaSaq1JTkfmCxMhnD0hVfO2AYcctVSNJQYwB8gTKvXlO9Epj0
         s2PN9jbrxJ3XerQI+apF89NhByniN9KSC22Z4bSDt3it/9izDbJXHDMluUH4bl5xnpcu
         pPaN6Cz3AvbNKm8HplWqXvOl6YZjas66BTQgbbXA4LTKZ3EEoN/OjxeCqI73vA69BunB
         HG8QOUWDLX6PX5eb6dZMq4P1mB8+0bgjQD4LkAD2Gs/NiLscqo/IQuhuwJGMnsO72I3n
         QStA==
X-Gm-Message-State: AOJu0YxkSluoPhPsRmH94XIlMEYEhMD/WM0huid69u6vEgenLgPfJ1QY
	b6CJw8v9e8jN8irAD0igCq/2CRxUL03DV3DZEpnBuWjY9C14EBR+Clm9rTWCgbjNKlU=
X-Gm-Gg: AZuq6aLwM63J+NV7+owzqjy7IWwxf1uR7wVSXxZDFKF+uqDEuRcFH7MtSxgsCN8SYkA
	dqBdTWNf/Tei1uMWQ2/Bxmaq5eoABUKtYJCDQb7O9dWPuuOMM4lQTCCjCLhPG6S0izQ6YTHES2h
	5JfKu3YVmNYQ421H3uwOVkHOVosl2jy47mo1v0Fn88/pLEb2SLLa7UQVpjzmDYGt6ZXpWCdI6N2
	RIparSSlZK/I1Vpv6lmdScbA/pHeeGSsSr5o8QpHM03eNXXcJLfgibv9QrD/OVLhxqSJHCizHan
	b0jSqgPcAlTL6+GbhAHw3ngBX34+tfLZp9CsHIsPmjg+WVUBP+ev1JFdIPaJszZLWVpoVuwdxbW
	SjE036X6WlCSXh0WswvVKwmfuaIlN6ztHo/2DWpah5ZFNX/l1PYckIkjBJtZT8WWbE2UI91bOgC
	v3JLq0YWCvkOEpOTTWbYKQQb02FBpCD6uHeIbYu74=
X-Received: by 2002:a05:600c:620f:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-4805ccdc199mr65738075e9.0.1769420615341;
        Mon, 26 Jan 2026 01:43:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804daf23f4sm103692495e9.1.2026.01.26.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Date: Mon, 26 Jan 2026 11:43:30 +0200
Message-ID: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21712

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports patches to control the reset signal of the Renesas
SDHI IP during probe and suspend/resume.

Thank you,
Claudiu

Claudiu Beznea (3):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
    and pm_ptr()
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 51 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 ++--
 drivers/mmc/host/tmio_mmc.h                   |  2 -
 4 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.43.0


