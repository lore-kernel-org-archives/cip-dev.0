Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59651FD9E07
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:43 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78938.1772134960769084371
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GDJE+hXs;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso14597545e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134959; x=1772739759; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYKSypUQlU6KqqjuzJOM2ntL8UPoxkEdaVHWH6vcwq4=;
        b=GDJE+hXsaLhh3vY7MqESiUHmtH2xJopsjrS7z1niDhB3456gdV3Bw/sTvU1fpoVT0q
         XOaZA9YiIzv3pNBzgdN1hsYQLebv1OlW0i3QPzjhF8PxWq0b0/2NlfNszjcwaz2otz0r
         dJ+QIXbbMOycOH2W9a1WrDoTOIOYzf3z0n6f5fTRfs+d7Pl71/tXU61/TdZ7wUCxd6Ty
         W5x2avHvcus1vs9loYNXs+DsSK5buqi04de523GGmeX6Ztq99oQAzs72GH/JQkyrQ2dI
         YiU/ufmhif3oH02KxnScEdGpm1led4QY3T0K9w6xcGxXl+afct27n+qN6w0aHGiRWCkz
         4mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134959; x=1772739759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYKSypUQlU6KqqjuzJOM2ntL8UPoxkEdaVHWH6vcwq4=;
        b=wcrckTpaSTC1LOii6X2oSF+jxwkTdVT/0+Epxel3fIIba9S3jFGaT5EbFwuoFTOvY7
         xgJ+407b7+CgcNweANhalSlReFYLFjiK9cWr1fOoMXq3hsWCwFUoewl8dMmwxZ+3IWv5
         uK24/nTg89UZR+bUt/QBP/IWNK7sDJVgTuCHogApNjFSF+C0XwZJ36Taoo12zDgqEjmb
         APJ71YkordsTXQzBg5XOkPZsYLK83vlJ3gt4xaoS0FSxZol0Od4Fv/1xXTauJO+Z4hTG
         xBQN3XgD7SIIcHCb1T717I5gTbNsCU0lAUEwvBfxpZy1JFtYwSjQVeIwh9FfyN7ZaIgM
         nViA==
X-Gm-Message-State: AOJu0Yxgob/1gArAArvMyMT/7COYqKUMvK+6m55ohwOSoOf3iWmlzGi2
	sRFvQkb8Al8JeWIl0VE3xYw1sCkJA6Yf2BV8GVEx+tAlqW7WI+EeoLnW06vj9FYI
X-Gm-Gg: ATEYQzz40wInTJIITx2iG9W9eWu2vl1kn8E/M0yXPHaJjJr8RtTWND1+XfG/m7yQdx1
	xeKGkU44lD0TH66gvxh6ppgzwzcDq/rE0sJ3Vc/+fSvNRW/qVBm/TZoIsnEDVImhSkm1sYDin7M
	bIbuFe3CzH6vRC2RmJ5jXIU1cgk40XFerr6mi+pEDPnZCa2tM1MZse9BpzqLNox7f1R1+EaCtGC
	PH3pFjH1VJ8u8Ngxj31m9MmYJXpkfD84eR5YkHcZ1fS12TjI8ybzhK5WzSeWHjkC12tuTKETXwb
	Lo5WXXejZIZHCui/LO3bCNv0eZX7GtLhYtxhgfu0nKuNI3F5HjBEwCQ3aNTISBr80Zw9FZp/bDY
	8qNu/LVCiFYrGVk7/GD8Dp8wnfBNUcUWJ3L+kTrCyy0YoNksFDb8KnrRPr9oeEHPVG7/I0zMTEZ
	KFuqCxkB2+yfRxtmqJxHnrGhp1RMLc5w7Tv+YT2olaFxwFmaY=
X-Received: by 2002:a05:600c:3b18:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-483c9bb7c0bmr110755e9.2.1772134958743;
        Thu, 26 Feb 2026 11:42:38 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:38 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/9] RZ/G2L SSI Improvements
Date: Thu, 26 Feb 2026 19:42:21 +0000
Message-ID: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22011

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for 24, 32 bit sample format width. Also fix
channel swap issue.

patch#1 fixes 2 issue
1) ktime_get related kernel warning during ostm driver suspend 
2) Full duplex testing triggers an error:
   rz-ssi-pcm-audio 10049c00.ssi: timeout waiting for SSI idle errors

Biju Das (8):
  dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
  ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
  ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
  ASoC: renesas: rz-ssi: Use dev variable in probe()
  ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
  ASoC: renesas: rz-ssi: Move DMA configuration
  ASoC: renesas: rz-ssi: Add support for 24 bits sample width
  ASoC: renesas: rz-ssi: Add support for 32 bits sample width

Geert Uytterhoeven (1):
  iopoll: Do not use timekeeping in read_poll_timeout_atomic()

 drivers/dma/sh/rz-dmac.c |   5 ++
 include/linux/iopoll.h   |  22 +++--
 sound/soc/sh/rz-ssi.c    | 183 ++++++++++++++++++++++++++-------------
 3 files changed, 146 insertions(+), 64 deletions(-)

-- 
2.43.0


