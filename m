Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB1D2F010
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 12:57:29 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10075.1769518647060471589
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 04:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mdUWD1jg;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbc305914so4838472f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 04:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769518645; x=1770123445; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOYDnQc0cctsLW1y95c4ygXfrjX1pVC8EsD/oJwhFp8=;
        b=mdUWD1jgEbMHmldiJraNOiDx7yYFOt85m/9pmSGsZsYsYME7U8W+cFvK4XFcYPQtx9
         //3EFqfOTT4AV2V9T5orpgAkeTZxGJ1FrYLmJs3KT4r2N2JduJ28I27OMe++Vee1CvJ5
         hI3YHh1c+WOiA11Ru8DnCZatLljEClFVm/UpEMmzBZQRMPlGrs7e0Ryn1Wofn5WtIYzs
         FACdMYK4fTW0Rk5FuudHkgkcQdUAAGaa4FowCP+2axHQNSVUOp90Cpd+pf9qP9gGGKZE
         PWCDp/+lKeUaJhXMpg5zdiWjTKlhOUBj9ioq8Iu9cRuhhYLTdAcRpN8YQj+4Mpm3tbDz
         n2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518645; x=1770123445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOYDnQc0cctsLW1y95c4ygXfrjX1pVC8EsD/oJwhFp8=;
        b=jL+99scqaGSdRzH/g58fnykRhqjXMc3c8qwNJ4iS8P2FYcespS3sKeO7yJdv0D+Rt6
         +FdQpaUaegnop8vIjaaWCIUMe4mcn/TjI2wWPSEAF29/zvCCYtSfJwpqyN9zYGcajLTj
         3kuSqF+5qljPKlDO/pKz0JT7/DvQAKdUSHG4tpczh2hVH9mw9ZjqCoV2zy87B6mN7W4o
         4lXt5ME6fl0MVn1pUbZBINEmlHfdtNyKbhuBbZ8d3V0CCT9g6OlI7yfUhtbzHRuElxDX
         oy9MgIWkTXKjc55x/VmhWE1l+EwQ2j6cAIQ/dM/hVaswt4wqGdLUFVhhnKzJRdxeUzPH
         dVzA==
X-Gm-Message-State: AOJu0YyCWgDVueIUfjXq/IWO0JWzOmFtDJVTow1Fb+tg1TSP1at86wPK
	ZG+zqIxbRkdhL5g6i5uuF4ZgkO4e2hd0kixkiYWp5GljvfJauHlw85H9q19G9Bl9QIU=
X-Gm-Gg: AZuq6aLceXVyeFlOJDLyTqm/SZmk/8w9aR8z1UQMDHpkCIVm4UjKDlcpiRfwQ7pu0LU
	zWcYUsrv7XI8XP1XeU4WxEWhiZVM1IMUcvvZqiAo5Ho1gi48GfRxfwRa1J99pJ7hJwnlTngr5kJ
	JO9qiyy/jlj3eUv1h+PEOfu8EEnwtaSK9GPcQeDTaCtAoGATUWmWbIgWc0abUdrQJDFaL2URiR4
	7lpaHmlAeYnlOzb1fuDOCLEfD9o4QBtanOsQWVJhSD2U9uAsj5JvRHNamhGZXHattGF6VA//TbB
	T4gx+OgWTQFbYnLUh+4JwOR5Eq1b2fTIzUt+PsDYKrMHkpnCXhJQ0C2tRpnXrercsdlMRs2yXnc
	vpdOOJ1luLRjOlI460Km2IGf/vyQZo8DSQV/pcUOZ6srkzS1Mklwm5Ohd61/OVjyRaddkGHgU4O
	RwX46diAb7u8NHLur2v9d1douX9261VQkjVdlM/ZKS1Xia9iJjcg==
X-Received: by 2002:a05:6000:40ca:b0:435:db6e:e3b3 with SMTP id ffacd0b85a97d-435dd1c0cdcmr2224205f8f.36.1769518645148;
        Tue, 27 Jan 2026 04:57:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm37089738f8f.2.2026.01.27.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:57:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport reset control
Date: Tue, 27 Jan 2026 14:57:21 +0200
Message-ID: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 12:57:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21726

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports patches to control the reset signal of the Renesas
SDHI IP during probe and suspend/resume.

Thank you,
Claudiu

Changes in v2:
- used CONFIG_PM_SLEEP in patch 2/2

Claudiu Beznea (2):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  4 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 53 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 58 insertions(+), 2 deletions(-)

-- 
2.43.0


