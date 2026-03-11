Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3F104BFFC
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17651.1773223507314157201
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OhzGifCp;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so19841735e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223505; x=1773828305; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN664tXINQVo+99a2UW+3o3bNIUBSuL+x0WZZZXsTsw=;
        b=OhzGifCpIwdlK3Z8HE3WIhJFu0JozWbwMpwStWV8sReRn5XUS+P+ECFIJSys89qsV7
         MWOYnH3DBfArurkYHH6SBtYFPpbxZ86b6Sff6vIFkmZcibdHTsZVzCRMY8gXKdDHzu4F
         xRcgz1zH9ZLjZXEdZ1gQ07i/FrvmnorOhxOcESV9HXtphgb8rcqY/s7BU874reoQqG1T
         1YzVghEvrFdpyLr2lHS7D0DFIQ1ccOgkVwgSGK3VnA0dWl/EyMmmG3lOIkr44rhlit0i
         kDim2astxR+0qrL8hwrQlpbri9qJ3wshe/dS36yaktuP+VDnhCf4XbOHnq8/hOfEJTFW
         WTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223505; x=1773828305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RN664tXINQVo+99a2UW+3o3bNIUBSuL+x0WZZZXsTsw=;
        b=MNXy1IZcuOduEgUJKRVC96K3OPWK/p9fxSX1x0670WVRPKxxa8hG/JDNgTCxzOGkwD
         CZXAoW3rzB8Opr0Y3tGnyks8TzIaXbAzit/WFsdTUQo+iWVIHPPg3Ou8RUUiXFWdEZQM
         lb5zp7jCxbkij20LlB7NPVkkAGlnrRhE8rUZ3PVxi5WMqhV18FV2SqT/yqUZ5BZgcd8O
         5rB6mdj3mimW63VmWP6W7wcMH5ECFAS0T9q0YKws0xxCG1F6UOL+NurksZxR/q1LWzj1
         ZoIrINkum1+sgBKrzTXds34NKL0PnI5ewOCr3qiEbZC4IcWTJccom94mvpWaMReDKJkp
         Ahfg==
X-Gm-Message-State: AOJu0Yyos0FqBtRb8/9e96Psv7oTtyHbwdGhVPqZoS5wJs1RnfgH2RK2
	JtYPREaARSTi8NA1wVVQLsX9wBw59ZzZr9ddHej9j/2HAqwwlVYsb/dtyvqM3w==
X-Gm-Gg: ATEYQzx8eCE9nSKcUvqXCWG6c6qyIqQffouoQ0Z4G04v23O1VfA7HfXtDxI/TilTdvd
	iOC5YDdhy+dbmuvcDHcBeErEzgkAmbrfMHAVzEkGMNMhHEre/3iOYVY2Eqa4h/1c+1vwVOi2DlB
	fz4oXRWMXi3mWSKVyCPwuPFCjEkTrQCLRzymlmLoM6ACpiD69pPZSnbkfpdjZd2maYPllvBhK1N
	hRqgo4nyYILi9RLSORonEHhz0lRt2CIytKSVLFbSD98+npgBGTuRZevMtRaM9myp5FcWuFH4U73
	dn2Z4A7GBJtKpX54q/XTPta3m6k+AaNjERYhdr6ifFoPA7lE/nbSi6mfAUz082cD7DDzZUYzE2y
	mMb4VEgjQzti8S9jyE9I4sMb9gxE/4Ml6J3zXdVfFawtoQmTcPtOETdadvVBrGTaT6PePaFfRw2
	HKoGLuI6ffiaQy1HKAUMFYP1sV5CpPyXw=
X-Received: by 2002:a05:600c:4745:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4854b0ae77bmr29228455e9.2.1773223504531;
        Wed, 11 Mar 2026 03:05:04 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 09/27] serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
Date: Wed, 11 Mar 2026 10:04:28 +0000
Message-ID: <20260311100458.162447-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22255

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3a3ab10245b6779e32114bc70052ec7a8a380152 ]

The RZ/T2H RSCI has 16-stage FIFO. Like other SoCs, set the default
rx_trigger as the fifosize.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 80b2b9b3542e..4da0251c0b10 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3331,7 +3331,7 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->rx_trigger = 8;
 		break;
 	case SCI_PORT_RSCI:
-		sci_port->rx_trigger = 15;
+		sci_port->rx_trigger = 16;
 		break;
 	default:
 		sci_port->rx_trigger = 1;
-- 
2.43.0


