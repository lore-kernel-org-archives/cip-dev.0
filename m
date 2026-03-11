Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC74104BECB
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17332.1773223511257220017
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=euAvoifD;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439f59dfda2so1158088f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223509; x=1773828309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ7lZhYolkiA8KYaY4e9I5iUsNa7fwrgZMgoxqNlD1o=;
        b=euAvoifDmcqIbY1hrcZGjnhK3TJnjdYh+jqWvvNBxVCOzowhqh6bA1WJJy7/tn2TR0
         fp39H7hUJ2WJiveHWqPJvbrEzC8gI1c8NMnS2J2dGiPFcpIGcKmjpo2iCxVVg+RmtmTp
         aaLjezeIlyPDuqwKA/FODtqApk8/Q8phgPKMWHxR5F9D2qVO014XF+zHWT90AzF7Rz6K
         7wUUt4czUBClXGOJRagTZPaU8+4dzIsa18+O45JMd16D1WLvRD9r5fzMbRiDEwdSGKu8
         02tYtbiIHKLGtMomUm4hMDwgftzoT+tpPtyAzjFdsgXhIZRvZ69GSU225Jp5hfu9EMz4
         vwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223509; x=1773828309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJ7lZhYolkiA8KYaY4e9I5iUsNa7fwrgZMgoxqNlD1o=;
        b=PvBRDVJPrlLb8GvtULy+9VxqvXyNG7S7diOaZT8tshz/fkpu7GtSP3gm2MF755hCGS
         cwU92Hqz2ARqTZI517P1qZ/tn4n+i/owjIsDqgaDgFltU7n/JQcssQedOmOvi4L0Vulw
         dASfJqOBc/zUb5quLkdISgQfM6WWAp12AkfPbWZWjGZXXjUfxOxx7MkvZAEbLznoIZQ7
         AyU3A+KU4WXiQ030R/UWAr2fTZ2uMJ+79iZLu2/5wxwW/w+KX85LwcUjX6taQz1Zclwq
         LaCzE3BWotJI/EnI+YKXxXhf9oqm2/pHQXrqXiIDcaQj9qq+TggoYqr8jwKIAYJ/4my+
         sfBQ==
X-Gm-Message-State: AOJu0YxvQc7QS8FKLJ5HndWDAejddtVSzYJOGSolnA3EL5Cms2+/Oz3w
	hWpA7jUz42HFiKruA4ebEVKtbrtMYccyXpvVKuO3Dp5tto8yeVIKmHFd4bFlyQ==
X-Gm-Gg: ATEYQzwKbNZgKRWohCMCTnF32ggTubohhsNa4ogjzucL/s6N7mrnW93ONBhmn1QvNWy
	Ie+XGsXdCbqJM3/OaQqT0E/VV4vfRUfSMOk6C8QLAdBp8bqtX91VjJy+dxZuYK6jNjIyWJ49V3G
	vuj/Np7Q7mhTJyk1c7aOtsxVoJTWaDB9kOC1v3j19JwTmrcyGtp0EPe9PenWcsfShsytTdoEabU
	0ipLADcNjlmKFfgFEVxFF28uMkhKoGCZoxr4H0k9ucpBe5z19nEnGgKx9FBjRCN5ggAnd6OFymv
	AacR9n/EcNuGNyxCP9O883tJZHUY0syRF6JRqS3Vs/HGIX3ie/Ce/iGlNkNNH+UFP5uVpKB2DQc
	A5ieuYQqglpzMJgENPmzOv3XUSxVW+NFtcPk48/+AZ96lQ/QrYTqpIcwgBUFJgzgGaOL69QaAr3
	1GIeKtn3bh5W8LtzZpwNdUpZGUvQUCfn8=
X-Received: by 2002:a05:6000:2506:b0:439:bcb8:54b7 with SMTP id ffacd0b85a97d-439f82059f8mr3732159f8f.15.1773223509345;
        Wed, 11 Mar 2026 03:05:09 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 16/27] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Wed, 11 Mar 2026 10:04:35 +0000
Message-ID: <20260311100458.162447-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22262

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 850ec928922fb819c28eb175bf85b01e28afdea7 ]

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-10-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 97f6dc8692f5..cc6765463003 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3706,7 +3706,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0


