Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4318CDC173
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88221.1767699911307732051
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mEt3DpAr;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477632d9326so5248885e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699909; x=1768304709; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOp6snvt2GgyBTkFuO4jN9v1tRoFUCRx0iIfWWRVHXM=;
        b=mEt3DpArHUOsRBV82R0G4OeQO5PIVwwa/3a5kdb96T9Bb1alwVCAkdAmHH2gsh5hsx
         GnjmOG3JSYJfr1xyKS41eFEFsXXJYLnTMiASZVkAMTr5f3zonoFBIQV3Mv0aFcE7BYmb
         a8JZ3mrHNRRZQnMmrMtludq/3ry283cNU1PQVROidKMWdlTlPC5dZq4iNMhHYD6PE2tO
         tCGRNmUUZegyfRee2QMT3ibM+nfc8ySCS3hQZpFRMVicDhyHjtcDb7mlpfr4iH24Ln7W
         rIZtJ/d/toEMMxHF+mTUUeW+QaL4R/y/GYOS6+rdLf/Ztr1FSrrseo/5VdYnckkjxujn
         U2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699909; x=1768304709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOp6snvt2GgyBTkFuO4jN9v1tRoFUCRx0iIfWWRVHXM=;
        b=HCXQsgr08iEtiBO/nozsUYefLWxMDXQIeERmFHUn5imNCgjzmr1XELnh81RhZitic0
         6HCUagXRXQBfb0mRjp7igWqKaWtGvgon7LNifG3AS/NWj8mSAttBGt4pyd3asDb8bEe9
         YR3ipozp0ysIYBljPhVUgd7LutdtY+IE6eXG01JJ0OG0LIMSVWo5wHtXJEzMPx2w4G03
         pAXZcrfP5LRSdRPacv243ck7YI3B0f0m9avisORK8PL8+jnPPa0QmJf6c9jyA3y4ttzY
         P+UDyE3HCD0lW9OnnZu35FCFTpxNwMlPlTGSn1/OgoK+FF5EAt7KChIh+7awuasXIKxY
         0Ntw==
X-Gm-Message-State: AOJu0YwGFvRATWNBbkq06sEN2EV0DX+YAujWaChn2WpzvqBADtcXWjNa
	FGVhRPKVjGHtyn0FfjNmv3j7W4Sz5Gi56SfsTLFDsQncns++3nED6Eb8lusdpw==
X-Gm-Gg: AY/fxX42VJXbidFTVb6H6ztomsVE1WXapXMwWVT5a098/OOBTb1niTsue5DfI2SPlEz
	d4kVWLgPGdK1whP809crsCGjpAij8OneD+nE9LfGdQAj947GVmFBD2B5UexsrTQn9SNY4nnAxhR
	Du+UEDEsAw4/yXf+mtB3VDZ42MKMWbqu/GxvZCNjt9K0sJTLo/MDkY0D5YxR4gkM5NUkwEx0Lof
	FLQYp2JingRqc5KMKLuOLxYS9oZjcUG9XF6DWTRIrEYmeiAcnQc9Gtn4j5GeZQG3Cgai4r2vKi1
	ZvY/PZLqCzs2O4kGohXGT+nv9FxOXXXWyyPRoSYv4Ui3Vhkq5qM6EHKYT+W267SXuFsKxLPFfSn
	dMmh3vs8Olt2hIQK617Hc54Alioy2XyhJqCyd3+6KiGuUsdSib+dRAWaYX8Y3OwZl9uEhd9g5pW
	im0cBiyp4h4CMJ1acWbQ==
X-Google-Smtp-Source: AGHT+IGk9xVgrlwfj1+pE92ew6PRkFfTpfy4Rg5mwSlrTyhTbcftCedp1TUyDUcP61akUhyvOC3KLA==
X-Received: by 2002:a05:600c:a46:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-47d7f06feffmr32518185e9.15.1767699909486;
        Tue, 06 Jan 2026 03:45:09 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 21/24] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Tue,  6 Jan 2026 11:44:44 +0000
Message-ID: <20260106114458.122333-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21352

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ddf9bbf22b70d6b1a10e7d45de8ec3b94de7c54c ]

The CAN clock is enabled before calling open_candev(), and disabled
before calling close_candev().  Invert the order of the latter, to
restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-6-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2b6321578e52..233ec0e4af78 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1578,8 +1578,8 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
-	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	clk_disable_unprepare(gpriv->can_clk);
 	phy_power_off(priv->transceiver);
 	return 0;
 }
-- 
2.43.0


