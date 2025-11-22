Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3FCFC52E
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:39 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7146.1763808697103336251
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BqejqH6R;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779d47be12so22183365e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808695; x=1764413495; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fbFgeIIvepTzz5oGKBNlJDobiN2hXFzg91KYKSf3Oo=;
        b=BqejqH6RE4jzJwPednlG75iBKZOpGb8zQW7qfN5MvXtAx/MiSrkLxjktL+bTeOUJn6
         +jT7OIZVvbPnjb88gsG+ZnPrntPWDFBwKdIMp2dXWIA3P1kFUt93K7u9Ic3GV0Jq1EBP
         /uiELT930242Cwwh8dMKhbtxq/F5+TYKW6Uk9vtSoFK/cSD3uU2TjcL8s6pBUqqVPTsz
         hH3WDOkPytGrPa7Nu57TMCsUL1sYIc+IwMkTJxXnt1stoNxBb7I0dtAZCydtlaQU2CHc
         lbCBB584TrGnfBB683nUqQ3NuF5DFqwbQ07zFr1GiHZt6fv3z2P7UyUd9NNJMSWHZ7mI
         Vsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808695; x=1764413495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fbFgeIIvepTzz5oGKBNlJDobiN2hXFzg91KYKSf3Oo=;
        b=FfaMQDtcFKvb80+jgLYHb2ZH3NBNMVC0RNPnU7MOSCEDbmkNVs8MfC8rch7b7hsnMP
         kHKWsxdggTSTInpL73C1PxBncGqzMdJMsloliMc8f9n2t1ilTI3c2Tc1FxXAcO9Jc4Nn
         Rh4PKP/zUjg4UEFpXoKjS96vuO8B5CPP2hHCmeyezi8o1Wh5ODPLnlLGrN2K2D4X8e2X
         5/cPWD0aeC12hPP0T1v7ddjm0hjX1GiFk9ELSs/xk/zniJfT0ItdYMR3DMqTflwk2Qkp
         8QkbxGdz+2+o8nqIshlcKiN6pimLroMrawQqt9+lcQnE/qhVY5tHyRZ3q0CKDeShMy9h
         pepQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVNoE7WSiF7i1YIGGPsNxh0fvroz/lG6iP7N+cQ1c2qqRej0N7oC2qIVb9hK1JC8k0eoGrLBAo@lists.cip-project.org
X-Gm-Message-State: AOJu0YyJQwc/+6NmzDltwk7llZJb7bwIv8hlah0vyo0TUiPtPXNyS2g+
	2DPEyo+Dcr6zYfrDS4dfq86qvmU4KCGnjs7RB9SoEKcdMzEFqaoaySAUWyQjPWeuS/s=
X-Gm-Gg: ASbGnctB42KM0GsrVCV/hBKBKc9Ysby4gneS7jC0Gm9c5qGOimqIdidRKq9r6t5+VnI
	7IOpdwuh9WrF7TB1Nx1KUQ0paXF228xsLt8IKYeDKRYh1KulFXiwfZfzEpSFYfx8ndjuOEJL0da
	DuuMh7OoCtXOOCtXYEJatLKpmuXbfkXUdcPcCR5I32kAQhly+qPkuF2xNdT4Po5A3JHG8evI2zA
	r0TlzfHW/+OPEvaMt8bM0KqvV4gaPZcfZ59viUuxjXpD+DxaKWfB9llvIft6B0Rsl8sedLc9evc
	8uS43Locs+4EjXuDi9AHFkMPYfzkPz+tQRTVzMn8Cxf7L1ihO8BPaUDk2q74997iHkxYTVQajZF
	I3sxgiNCbHlu3TSTl5hM9ZbMufoVoHUL0dauLkW8bGsHlbi9RFBE2z4l8Vhfl92eyBt7nLkAWr3
	MbNGLRVHNkBSe7BMFV/jHt6rmrA7GJ1nR9YTEnm/tP
X-Google-Smtp-Source: AGHT+IGKRuFRBtVWkzdKHmZH2blIOCI69wgufn/Y2Qh+8rnwsBncmWquAM310XO9OLY9P1Zaaj0/Kg==
X-Received: by 2002:a05:600c:45ce:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-477c01ff270mr61239085e9.31.1763808695437;
        Sat, 22 Nov 2025 02:51:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5a3sm16263356f8f.6.2025.11.22.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Date: Sat, 22 Nov 2025 12:51:31 +0200
Message-ID: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20693

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports audio fixes necessary for the Renesas RZ/G3S SoC
and the Renesas RZ SMARC Carrier-II board.

Thank you,
Claudiu

Claudiu Beznea (2):
  ASoC: da7213: Use component driver suspend/resume
  ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

 sound/soc/codecs/da7213.c | 67 ++++++++++++++++++++++++---------------
 sound/soc/codecs/da7213.h |  1 +
 sound/soc/sh/rz-ssi.c     | 25 +++++++--------
 3 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.43.0


