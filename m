Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D04D6ACF9
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1397.1766076962717022275
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cd3moMQa;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so422007f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076961; x=1766681761; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGADKP57AZajxwcDaBdSfoNW7vRgbbfbjxhdLqO7xDM=;
        b=cd3moMQa7eoKuaOr2xshkKFYdhAkowQe1KFBX7JkW3kIYkluE05YkhZYHEB2Tz8/3t
         mTb73m4kXRWCP8qlyNFK5l2VCM+8upq37T5H1O4mqyY0N2Mi6ntnKVRwUrXuHkfyQZRP
         +BDuE9tn6uznDkogT+yIBno4xdzfJMLDsWRedJtR17x+TihAPWKjlwd51iyVMR/1CZ1G
         /UqdQTBbX8qzXawMBJKUKSQGoSaD+xybMkTkEJk7AMAcpk8rmz0o8LT4wL8TlaYuMsvS
         fVniFkAykJkBRpwJS3LILxAr9VhrzEs85Zt6HfdqtFRMgZlaVB3AByrzWTbVwaedqMES
         LBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076961; x=1766681761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGADKP57AZajxwcDaBdSfoNW7vRgbbfbjxhdLqO7xDM=;
        b=qj8VihbIOXU4BZfdwVBFIbooL92cPXiY0zY3gHZ35hves9yfHCyvXVi6NllQft+0yS
         Niz9Y5AsbkykG5wZvX6gXgZ6Oooc4cM0ITFDUQYLp5WBpU/LUF3RM2nfgxWcLh4f2toV
         OTgE14qO6sVVjWZhWJBrkUV9Q5gDgSoPoPjuZUfZNvvQM7A6VphDwLfTI2HU+Z+yo05n
         6b6RlbSn4eSeJzNAT1gJsb1VT+QagQjlflnIVGMvpnoOnvvSXQwShy8NHCgAkmtN7Sl4
         n9T/mKJQv3ihiglozS3wDCRX5KYTnfqjTqfxKC4hm6+ugEWNChWwg+EcyA2fCrMnlxEe
         r+Mw==
X-Gm-Message-State: AOJu0YyjvmZe9SC/PV3HfWAnxYVUchLksT8mDXqit03WGOlrHjwt1Gia
	+eESUfQFzjI+5JthklA3V4cuXx4x1OV33s/XmUtuSUeeC1oLGFCqg/fgeekM9g==
X-Gm-Gg: AY/fxX7lYqlLfZGNKh6UAQ/xkT42ZgTXeGAHEFoScP5EjjEit3hxnedcM5qySRbkM64
	mOyu5LuhiI8ZX7cBtkzSy9kIgx+F7VZ9ArBhG86Icdyywky1i7MpQ9SSqfjlSTbt4TeThUtoaki
	13f89ZjlZjnUxSfjU7S6dKNvZxpj15CisKRiz01qBGmwxyINr7E7aBRDluV2zjoJjG/nsfK0VYh
	MkZ+1ViHHJLrhBac7VZns7y+jNhqE4K8ikEfrwYXjC9GQu0QwOKZP9b70lcuneKudMj3enJA0tj
	3n+c1pmX+mPVGO66xgiVcp9geZemFEFqQuBbaiEzM8tzIoNHaN4kQUFyu5+DgqwNE+aMQM0zv8w
	k36cCmXoyYUqPa+fl3GYaf9lJN7vpIsEX0eVwaEYWWtiwgaXa6NOZ+SURYTa8CmvCTyFLmQMyuo
	SVNH8yAdVPjE5wEQ5IhydWJS0nTO//
X-Google-Smtp-Source: AGHT+IH3UFGrH52EsRN6MY8VMyiVv57u8D/g/WHaBcLvDLjPSf/CzoMvpqZTXpVkG2TC5jqthq/Kfw==
X-Received: by 2002:a05:6000:1843:b0:431:342:ad44 with SMTP id ffacd0b85a97d-4324e50dc75mr129703f8f.45.1766076960844;
        Thu, 18 Dec 2025 08:56:00 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:00 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/24] Add suspend/resume support for RZ/G3E CANFD
Date: Thu, 18 Dec 2025 16:54:59 +0000
Message-ID: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21138

From: Biju Das <biju.das.jz@bp.renesas.com>

Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
powers down the SoC. After resume, reinitialize the hardware for
CANFD operations. All the patches in this series are cherry picked
from mainline.

Biju Das (7):
  can: rcar_canfd: Drop unused macros
  can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
  can: rcar_canfd: Update RCANFD_CFG_* macros
  can: rcar_canfd: Simplify nominal bit rate config
  can: rcar_canfd: Simplify data bit rate config
  can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
  can: rcar_canfd: Fix CAN-FD mode as default

Geert Uytterhoeven (17):
  can: rcar_canfd: Consistently use ndev for net_device pointers
  can: rcar_canfd: Remove bittiming debug prints
  can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
  can: rcar_canfd: Add helper variable dev to
    rcar_canfd_reset_controller()
  can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
  can: rcar_canfd: Repurpose f_dcfg base for other registers
  can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
  can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
  can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not
    FD
  can: rcar_canfd: Add support for Transceiver Delay Compensation
  can: rcar_canfd: Describe channel-specific FD registers using C struct
  can: rcar_canfd: Invert reset assert order
  can: rcar_canfd: Invert global vs. channel teardown
  can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
  can: rcar_canfd: Invert CAN clock and close_candev() order
  can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  can: rcar_canfd: Add suspend/resume support

 drivers/net/can/rcar/rcar_canfd.c | 672 +++++++++++++++++-------------
 1 file changed, 381 insertions(+), 291 deletions(-)

-- 
2.43.0


