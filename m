Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4EC47BF4
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88167.1767699901634108582
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V0Wz6LU2;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8283705e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699900; x=1768304700; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwqpdd3UpGaXvzFXwpy/6bF/9sqGsMYwDJKUK09IK84=;
        b=V0Wz6LU2BCNNmWra/NyhC7fjVvOOLTvfmOdIFfw3EpFnLQGWROfzZbmNTzIWV3n6dQ
         XSUzYZJZ86YQkZqPFUBehTC7iQ8hFPXswD4QEGWhwRi1Kdwvuy6on8iwJYwlnFuaKIEa
         qsq2PpAsKy3h7/20lmENh5gbGO5EvLj+/XZWAXfPQx1rl2c24C2oxPflMx9bDNI7Plp1
         l7zg8yuoadlOItRPjutf+wEiPQ9pamO7sey9cY8DnT0vaM5+oWyQj02ssY0sWtSS52+0
         ArFGbXJh5lXS6L4FmYb1w4Ts2bOXVv59QcnJGD0FsKC4zD1plDXJDFsSXkyLSHjE8xvk
         EuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699900; x=1768304700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwqpdd3UpGaXvzFXwpy/6bF/9sqGsMYwDJKUK09IK84=;
        b=i9EUfxiYeTY9uRIoFdjO8SYi8stKPWUsZuWDkAerNl+SptZ8hX3uOTzrgU/UMDIZBz
         gEOlxvq2LuDt+oBZ+tGbERzGI4hjYc/R9MI2jjMDOn0CRQCDqmYq7yqAtJYHarb4WNiV
         kQKrPl/uVwsJVUh5im+NxD5RkVzbI3Ud3qegLP0evTFNWcSQeCM0WgCZBlX5XXL8n9L2
         LTdrg5IXCqWb+hMKCus9kzgiVFfFL67ol0Tqf8reZ83PQw7JQ4ZFACC9uCosxwQ3t9x4
         Y5Hn8OfAkGKGcXPCJ5Dh6kKgklsFd/PlYcSb/gsKdxFB+Y3OS9rs9XTY9qh/zFPU/d6L
         Zjiw==
X-Gm-Message-State: AOJu0Yzw/MvFvzalFZzwfZKGxE0Sth6vCzcm5P8XFw9YloUYaIHDZ52F
	gM9DF+EtDexTnSxvbrtZKiWpdCAwE0DB7SFDdt+xQ37YCzhEGmtwKjFG6uLIMA==
X-Gm-Gg: AY/fxX5z4ARP08dwq5W0XP6pG5UYPATE6CjkWCyFom4il+kF1Pzcnk+xD/vOX1cNxgw
	VKvNfiZ13z2kz2+Ry9e//srHwwgsSIfgNdrGjVBSGotuBkxIEVa/sVa7qlcMOFV1sq4QoXe/IOX
	mJAdtype1FWGjSzUz5lwjCbX16b17Fe0BdEBZOYtTEc53JrtkQhzXkHtojzumTJrvgNr3QluXfr
	aqsVc3EJBgg7rlcfT5zpRJH1H3RLLHXlnHt9dbP4kgV8Y8C/TR5Cs1iASbnTxAu+hRvgmRXu1yV
	PoyXaeWeruU2/CFIp5wzLtXVM2fi7u4G4fbGQZ5p6Pa21qsEsiNQS07/JgX/7KxPFmHRb23x58q
	PgPmVa0vdwd78ihiK4FXlbpEc2rtfe/p+oADPjv9LcfbLvdhL7fAZJTw4sNFKEInCuqBsLdBxqM
	xl96u1RBEqqPjk2DItYw==
X-Google-Smtp-Source: AGHT+IFsDJrGihkaB0iCgEjretUuo/VdfpuSa2zFCujjv/6C4lRHN5B7OiitPURtP1tqJnn17tMaXg==
X-Received: by 2002:a05:600c:4755:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-47d7f425bbfmr31521845e9.17.1767699899527;
        Tue, 06 Jan 2026 03:44:59 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:44:59 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support for RZ/G3E CANFD
Date: Tue,  6 Jan 2026 11:44:23 +0000
Message-ID: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21332

From: Biju Das <biju.das.jz@bp.renesas.com>

Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
powers down the SoC. After resume, reinitialize the hardware for
CANFD operations. All the patches in this series are cherry picked
from mainline.

v1->v2:
 * Rebased on latest 6.12.y-cip
 * Synced patch#24 with mainline.

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

 drivers/net/can/rcar/rcar_canfd.c | 647 +++++++++++++++++-------------
 1 file changed, 365 insertions(+), 282 deletions(-)

-- 
2.43.0


