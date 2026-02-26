Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC1FC5937
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:28:53 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78615.1772134129842784059
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B19zztfd;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837584120eso8857415e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134128; x=1772738928; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDkR0eCJEqVxtTj9+br9jNrNq0XC7wAg4SPDhSaEkyQ=;
        b=B19zztfdNLYyOuWku4rw2Lrqxoo3n3cfAgBLfBBsgkbggL5hNt33EvG4PaKJoaDQgg
         NiXcQL3eenWS2Yj29Af3N/pZKAWH924DIiFxGVA3ebSH8hu9fb/h8gRPUqlsTkEu4zF4
         k4XHO0dEdO6WuKfq+gJLOxfTZCp1ZgurDpX0dxjRG2lw6CCWxarz2a9PrYdA43+qsWet
         EoPIlJjIYVL5ewMNZUWeifaVolM2NNI9BojFtN1O8a/AQw3HHaVmpQVr65wZ+bZMcdWQ
         fDUVwT1Y6BErizunSjZowDKfaCMWd3dtjFNEGKUp7Lp5l2rSby1nMtJxGr/4dJl/M5An
         VjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134128; x=1772738928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDkR0eCJEqVxtTj9+br9jNrNq0XC7wAg4SPDhSaEkyQ=;
        b=quW43Ia9JBOiFGqwageduq2w+v0bFN3FzK0nAHcVQqlkZx6sCtfLX6svgoYros4h23
         m4a+bDz3INfT0Gc0Hbz7ESoYA70mmkAIXGbHCC0awPgtMYY00BWsINynXj6RrEqSRbCh
         WbXslvH+s7X0xfp+lUQybxiGKqhzyB8CiFeH40hMVhAeLwevz9UVb/I39/E3k4UGpnva
         +cGI5NNUU843nS+gprGf2sUjMpdsymSZUIoRD+ApndTG9qihC2mImxGYdkKlruV1Wf1B
         9nBiOKqze99VtQZrBNa09/rIXGCH65KYJ93frlRrGOsuP/4P1JPi5oaMYsZzvn69nDAU
         OE7w==
X-Gm-Message-State: AOJu0YwVdjYvZgLi/KNwb9uR3AwDBrMYwKOSH7lonMkwnCWNNBjX0y1J
	wvPMZuNlzrSBnMS/4SbT7xpN/dTeSSI50LETB+VR097j/HZtiO6Dn9V/VyHJaU82
X-Gm-Gg: ATEYQzzjCLfvwulZWktOerGSw1cswqKch6+73pdvhhook/fNLgFYkjH+B/h7eVos2xG
	TvA9fsP/LS9YqNaxCYGsJ7VR1DlewDnFszgPd+3Y+kzDucAZmFaqLcff7z1kLrpH4E7Q6DTmkUY
	cJjfgDYrJ/b3kUbvr1F8EwqDylhLUUtPX2RhKiSuW9ZbabaO1tOSrGXTtInurEeo/HvbJXHkWLP
	McltK5ES5paQs4RqEhC/P5lBP7RFkA/N1ZgL67Tzl/0Qm21JAI6eXPNYg8wg8ZGlvzWRu1/2md6
	DMrzeRLhelLOqBncKWAz1d2SfTofHMiI9wuBlKABoNILEIErlx7Q8dqm4oH8NRLcLuXSTQ5ZqY7
	ZL+CoQ482UVc99MPM2nRsWTZMWWTvvDqoXtaqrHheGSDJUVR3SsXlVJ+QHAbbauneCeyY46X6iG
	SE2NKbFMlKijqBFgY1Wb3IKyOanDZCzFxDCDMHCB6s5fxeZv8=
X-Received: by 2002:a05:600c:c493:b0:471:1765:839c with SMTP id 5b1f17b1804b1-483c219804amr77272235e9.20.1772134127853;
        Thu, 26 Feb 2026 11:28:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:47 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/5] RZ/G2L SSI Improvements
Date: Thu, 26 Feb 2026 19:28:37 +0000
Message-ID: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:28:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21996

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for 24, 32 bit sample format width.

Biju Das (5):
  ASoC: renesas: rz-ssi: Use dev variable in probe()
  ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
  ASoC: renesas: rz-ssi: Move DMA configuration
  ASoC: renesas: rz-ssi: Add support for 24 bits sample width
  ASoC: renesas: rz-ssi: Add support for 32 bits sample width

 sound/soc/sh/rz-ssi.c | 119 +++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 42 deletions(-)

-- 
2.43.0


