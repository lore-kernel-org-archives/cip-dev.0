Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CDD74EFD
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:15 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16213.1769420587660827091
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CtP5duvC;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.68, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so45089465e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420586; x=1770025386; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bG1TuCqGIspAaVgsrg5EToAt82op5vf50kFrmau4Vxc=;
        b=CtP5duvCdGyVOlycmGDV0cIgENd5TcRn4AH72WBIin+V1vbhZwOJ7zx5CBVq0yK1Xf
         cvLPc3QXyPsBQYnm8bTe9glPJ6ahnm51d1T2fBTMID6fV/GIHleyfiMYgy4h+wu1xZeE
         t28i30D/elnRLS1Ti7f7iu4mx/y8TQH5C7bqR6uoiQ/fDASMmroghZT2hhuoKKB5jMb+
         XSnAeJ4dDNlbgXLRh+iI+E5l8PID6NNRsoqdspkU4m4wRN6pQ6TUbhMwMybTwoXNoJxU
         7bpeJ+rhv6E4GUwLWVE9FJ/GtDRo3KHHKszGg/Vfhz/t4UCgEVYIjP8ggcbOJGDNsiMd
         eZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420586; x=1770025386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG1TuCqGIspAaVgsrg5EToAt82op5vf50kFrmau4Vxc=;
        b=I7glXXZy4xwNinxSDw1zCoiDFchB4H5epY66YUr0TrC/eD3UqLPF760Bgwn4iBM9ht
         ETpkfkDCj3KA7twOHDhwrsE765JPvcvtN8bwZpJ6A7ND80D3bTIuXfR2mZVtyR+TRonr
         9xYLVEwdmE/lf04MEnywwf4/Myloro2Y9mpNNod0pTuiIYo+iyaac59mNyvTWcRG9xf3
         emH6RJOH9qQCQeYkYJd9n3L3Tdh5LnIInmrRRQ0DErkcQ0TTvoYqM3uLAY9hLqb2rDxy
         YLW+C1mFiVjlDbGAWfyDWjDA+ud4m56kBoRQf1KueIrIOsIjSKhrMP0X9l7FKpbt2N3d
         M7fQ==
X-Gm-Message-State: AOJu0Yx3mqcrCc9MFcfQqbnNkZcErPcfz/+963DlYYB8CZOXrNenPDEB
	YjNuGwCsT0KGNB0sNBCcEXlfhjaHPzh6kHuOYWHKA272MD/aq/yEvPz88IPpReOz0cI=
X-Gm-Gg: AZuq6aL7aQmMNdDwrKi6vnr3L04+JEKAkAj0hB8HNo+1bdkwGWaPNk91DaK7qeOx6RK
	QMMEsMynQjFeeezGpa0DU0NW7N5/mSw4IDUrIDNBftPcFLl1YfAsOXPRrL8NNNeXnM/9Yjs3tUB
	vqQEzGfifviE0RbxXJvWeDAAf1ubK+yWJNq3/h+37neyBXPAR56KDjV2FLFZEGXJaxLG9y/pHDN
	xWLBdQMzQ2NSCOmwFRivuE700TCpsdMX6v4Mz1clzlMaAgdzJ7XKwE17bDPVWjgs+sHzmlYt3tN
	3WDAlnm2l0eqN7m+S61DoSVn+VdVJVjulZyH5H4BHRgU6mNE6siLf5dDFCFPjYsFZkoDEinw8ue
	DQ2jSCBaZKVmMDw6sqX/77I/oInlLzvM//5bWafi7I+czyuDrroQ7VKRTdpHG/Age1GwKGZNhUx
	821ENK9fe7mXXZOiXKcFWIxyUFXTSQcsNnYFo2mDQ=
X-Received: by 2002:a05:600c:444c:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4805cf67274mr66286095e9.19.1769420585855;
        Mon, 26 Jan 2026 01:43:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d61f1f8sm101010705e9.5.2026.01.26.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 0/2] mmc: renesas_sdhi: Backport reset control
Date: Mon, 26 Jan 2026 11:43:02 +0200
Message-ID: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21709

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports patches to control the reset signal of the Renesas
SDHI IP during probe and suspend/resume.

Thank you,
Claudiu

Claudiu Beznea (2):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  4 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 53 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 58 insertions(+), 2 deletions(-)

-- 
2.43.0


