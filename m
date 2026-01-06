Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5690CC47BF2
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88216.1767699907698499148
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dpgLp61K;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so6095845e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699906; x=1768304706; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX+FMcXjNFK75t6JICmHeYUXxC2n2WB5MvYjsXZ6iyM=;
        b=dpgLp61K1x34TFYDo7Y7ElO9135ZMDbCNjc7qxd9OVet21Nx4HzfDc2/5ETrCT0JSI
         kv/QoU070Vb4PVO37gZ+XeCAbnVv711LSpT8uMjhZa1aA2HB1PqZYwWsli+Z+LHKLZ/1
         bZdlB+VCvf32gEp63OCltQr4YZeLfaoP9z9LhOK96UWjD3Thlj0RXlre7IArPsh5hgnQ
         LTeJRIflmr01+P4UUQT+U9USy9jBhS5ZP5y1frzTWbD0UYcE2fquvoUoVKXk57W6Vnc3
         C96sGiqbpq62LDTf9qnbfyWY5LL9TtVXG4Ej3ak79V59hd+ikeiLSrPHL0qjmThABvAw
         1TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699906; x=1768304706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jX+FMcXjNFK75t6JICmHeYUXxC2n2WB5MvYjsXZ6iyM=;
        b=UjMJJJTbS1uud/rCQwjyQj9582xSNiBLvUHsT3L9t/lXw0jYwXzWfFNS025ypKYhL7
         PtunY5NsZRAqJKn2DTSiJcfvAFv/xQerh5Na942vGRAJAWls6T8Ya1hIxKRBuXTIkOA+
         4eTCTDyHCDDBNQjrj8spW4nCqR2maqwFEgDYZCF0E3CAWo5Ig/zS4nZOF7+2VnldpocK
         XaWZUfrIW3XoaaQXHYkA8/TpyGbwDkicRWLr+Gx3ybIPto5mR2rWTR1IJeceYNXRXhjd
         9xoLlaYTaS9e2MzDhhUt/GC4CndJl+8B9Ho/5RMP2lDBzkfZW3PhDZU0HELPZwLS6Hb/
         I1nw==
X-Gm-Message-State: AOJu0YzcQFqvktvX/2l/anlMBZ7cKDG2NQT94HBcZ0nOV49zcRtQMSgK
	RmIVOVwAkYyjDc2Zb4FPZ2nAuLf3Ne9W2S+PQ5qPD06UE47welsHhJ70g5stnQ==
X-Gm-Gg: AY/fxX61iQQeaDVV32nqkT1a6oLnivY0UO6b0g1CBn4FvTPqyBW1HZFoMeuJz9dDoXQ
	9QbPkeNDeKKR8snXtb4xSFZvswGuV04lczCkZtEY+LGnMP84s5aSLkZbFfhsk+5YUhd8sDGuAqI
	iYFJL7DpCe6YzijYjzR56ARZ3XTxN0Iz0vDYy4C04yHEzV/tLSRx41kp60Z6DLenWBnJiWm91Lc
	uiVjeuyy18eWWng3AfXuvTgthfOGsCmkoDQaslnHQtBaTk3eZj16V6ityAVsgswklRB/bKYX28K
	IhN0vkSPR3XkUQtwXXpaFF9AnwxoFX/BIC9DQfyJ4NBUSTDPOwBY+CnBpVHyd3JhO5yDm/w5nuy
	o+zKIzCBJF62scJ486W/Ay4V59m/2lg/DqbR7P9VrO3leFuQMI++c/idli068ddlqu+k1GXX6QF
	xSSWHVZmOj4bUSsYyu6A==
X-Google-Smtp-Source: AGHT+IFZ975ClxWI+zVHoYeDmei9MAJFezJAUgg96QLd7T/WKeFtmPCY1IGILDvSHZRBX0vxUPqViQ==
X-Received: by 2002:a05:600c:46ce:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-47d7f40a986mr30384415e9.1.1767699905814;
        Tue, 06 Jan 2026 03:45:05 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:05 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 13/24] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
Date: Tue,  6 Jan 2026 11:44:36 +0000
Message-ID: <20260106114458.122333-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21345

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 100fafc3e46138cb5a6526ddc03dcede8b020c8c ]

The calculation formula for nominal bit rate of classical CAN is the same as
that of nominal bit rate of CANFD on the RZ/G3E and R-Car Gen4 SoCs
compared to other SoCs. Update nominal bit rate constants.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250908120940.147196-2-biju.das.jz@bp.renesas.com
[mkl: slightly improve wording of commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4133ede60575..e67a808c7fa0 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1921,7 +1921,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		priv->can.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
-		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
+		if (gpriv->info->shared_can_regs)
+			priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		else
+			priv->can.bittiming_const = &rcar_canfd_bittiming_const;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	}
 
-- 
2.43.0


