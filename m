Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E892FE67498
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:10 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78192.1766402229047716927
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LcnLdQpl;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7a72874af1so664261566b.3
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402227; x=1767007027; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ1vx1ETvzlbyCGbzG4GePVBBDJUExM0m2iod0Q18ZY=;
        b=LcnLdQplf/Nkv4/RPBm/HdVsRFctmlyTxvy8h4aImYGKgQNGhzLbZuHvAgcJgbempu
         VrQeqa7oGz1wO/u4A6mfGjzUwerpNshHk1QfkCX+TC13pfZjAvCUKYbCRJY3e7Z7+k5v
         d185AwszhhHJKt+et+SJ/2JssNZNWdOTjIFqeOUmButOIvoO27xhjZ1jnTQviy3j187z
         vAy0W+wXVu6wt/pv18RxkfY/3Fy2YZM/ElE+q0UmIkN9QTlfdreePJ3HBz7GPStdnJ8H
         yGGIojxY1vEIHpVLLJ9qnLnBRAjiVtX+Z5d81QwzhKcBPrMWpRwGhRxJQl2deQqwIuNN
         fvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402227; x=1767007027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dZ1vx1ETvzlbyCGbzG4GePVBBDJUExM0m2iod0Q18ZY=;
        b=sficqWhdZrayqGw1U44y/0R50coYCtLW5DgAnxvWBOzGN8asjsbntgp6X5nGEZGcrL
         06TtwbfhZX4WFp6To6MMz1vfJVuoE7s1xZmMpXBeM95kLIpiZTT3GfdcrwAMxBWzPrNi
         ryJPWtVYEfJroPMNNpGNy95Z6WLhTMkMtc7UD58HoyPu6nbt643jTWpQKEAQLPZ2T9MW
         UF6C+lScFJukRySizm2ku23fq2CrF/WGAoFecfQipnfG1qco3SmVZJgBIeFS/ODFMDuK
         NLK2RVFNF6IK1/d6CHTg0TXrkaxcfjs499JPTcLhdnrBtA2N+EmhMCM/3fOSYMkVskup
         bi6w==
X-Gm-Message-State: AOJu0Yxm0K2vfnmg8lOaFbZ7abb/be6pV/zsWbS2I96w2QIJxN9wWZ8z
	t4X57lcsPga2EiacjFp7BH68Ys7pUS/2xif5QP4PRoMFt3YDbrq3SQRRa0X0pw==
X-Gm-Gg: AY/fxX57gzOH0vHZkat0JYeRHZuUwkyqLhcx4w1jAQgMz9nhVnvbIg0LJv536IZPwxp
	Yf14BvPwVugGrO8JTfgLwauEn5VLxqstQf7tmgwDFW/Z0SKtHWooupDapuvkVEYx7LLq4+h/gPj
	kfzhY4uR4lbNZLNtD2ouY3N6Zi7SHbMMukg9DOMemBQ1scFLHXcSaXW53Rnah+V3JTISay4jHeU
	VtcGGHiK+m2yo4eYjx9q8Daq3vNoWVDUlLAHucNt0hszTBfYxQOMIN8SH6mcQVqxQY8Y6ggAzru
	GaFagfJQxVKfZo7l0FapflUXUSx5viYAj5pEgefZozxsaDu1bHNb18ex4MVh9yt+fArag122D5O
	vsfxxI1Y3DL7So1KrLvwyMiY9qkz2PERAwFl32mn33ToyXq+meMKYLGdOg/XditWJhy4kXooYZn
	fL4Q7AeahY3KsI2vtwk/UcQwd9Enla3bjiLICsJ1PlN88rIQ==
X-Google-Smtp-Source: AGHT+IFTpKdb6wko8nS1TfX+3M/+BwMMaToNkxfTE00JdKPCP+HfkIloQAhtpFYy40oUDOyE5ZQhew==
X-Received: by 2002:a17:907:7eaa:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b80371d6c10mr1200237066b.58.1766402227076;
        Mon, 22 Dec 2025 03:17:07 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/24] can: rcar_canfd: Remove bittiming debug prints
Date: Mon, 22 Dec 2025 11:16:34 +0000
Message-ID: <20251222111705.27028-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21187

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a627813431600c5582e59022659f11790f94a25c ]

There is no need to have debug code to print the bittiming values, as
the user can get all values through the netlink interface.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5136454a1300..11a1d1b992c6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1459,8 +1459,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
@@ -1472,8 +1470,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
-		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
@@ -1489,9 +1485,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		}
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev,
-			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	}
 }
 
-- 
2.43.0


