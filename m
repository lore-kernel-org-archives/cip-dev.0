Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EDF417F3
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15643.1773066358228646956
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=irGQXad/;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c5b40f60so4731683f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066356; x=1773671156; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN664tXINQVo+99a2UW+3o3bNIUBSuL+x0WZZZXsTsw=;
        b=irGQXad/zBxj9ABOszqDXsVNVEPDcwsRIhiomYoTUcrDigoTAgUT6eCGH3IDGsKvfJ
         wjNZOINeAzTpBSfOKOQhe/KlP83Yr+nx+FIQotGsFxc+xTG2kZ2AzDz/JVyiMWTTl986
         pc4v0dpwDWIg/uvWvr6WKgpG2hdZ0Xmvq4IO2PE1eE5cz73lV8SvrqEsxAweqeueZSrM
         I/v/Aa/5YnQVGjtF7GR/tXXkmD9C56gSLEPZs8G8Em7meJuTVskyYg7oNZL8REmvZQoQ
         yc8jQ55+L2wGpxzRo1Nv5xgNDjFgPYAsu4hYipd2o61xbUGN7/XGQb5sD4eArkMRf+19
         Tw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066356; x=1773671156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RN664tXINQVo+99a2UW+3o3bNIUBSuL+x0WZZZXsTsw=;
        b=gVjiWcUTSSXb2xpO7Z2u+QyJqlywNW2l6QZGgklyHKolaII/3y2x8FRSmqGcMEIFCw
         USsaI42WSx8zOAFcfyQiVysNhX7Qtp3piIwTlPSTMFbQp+0mxqAok6YnN3Hiyy6DSsLZ
         CcSjijXmd1ljTPEiA5r3rWr6Hp8JZVmQOBPxQdJ2ZeygFQFanXStdr0BKrGdps/kgNes
         MRhmXTOpN1CvRP8loGE6w4qOmhCS+X2/FJcaCqsM7paJ+mYWUQN/FIs3DUrCcfXLA2PQ
         od0YC6hCND7acLoMK5ZWJ0BeAxFuptdnLglU6BXhbAxJ132Tilj9Xp4r9UFdBG4LL6A2
         +Eug==
X-Gm-Message-State: AOJu0Yx2rL8CMSzoNjtZsVkb24xiLCWnJgokC9VgMI62fCilKjvd1sdh
	iFA5yrEVd4kjhZMtaXC7BD83Hl0GwF3YPitOHYiwqspr1UrQTqo7gToe4uTG6w==
X-Gm-Gg: ATEYQzziDug0vzWI+o0K+hIlreaAb81/ZNMQzszPpv65oHuYMqQ3AbA80yl9GA2EIr7
	2DvnJaEHFY862KKfSFFxaeOIs64A9I4HLM8O+GY3Vp8Qe7KfRGBbTwFeVFpDChbvMFjUC+5Mla4
	BEX7UmOUnCfwMG/gGGnv+knrnJmxmG+kusmNIQ44iqrbuQt5OVb5yVt+6evNsPVWCXuXMyymkGA
	AUj2Mf0N5buCBTF8pzNMk2FjCuFNC2R3aIR4rEbRwlVCGjxCnyxRBi3hu7V6NUXHvN65l2TPE66
	WCxHQGRdowJWXOQ2ABMbur1aH1OZDuqAYvYkRO/0lwRwEhLYdEu/oJtrGJrM+4D8mvRrNBjbobP
	/8cxRjkgEV937cjgarJw2T8w0bTOIWD9KCJwWCIUHtyrhsyqAJ9J2J1aOcHgwdvFNiRM2ld3ndJ
	3SfscFNfnE9grqsT6JOr8hF91m64BNRo8yKFoYOZxqEg==
X-Received: by 2002:a05:6000:2506:b0:439:aef4:944b with SMTP id ffacd0b85a97d-439da351a36mr18607486f8f.19.1773066356160;
        Mon, 09 Mar 2026 07:25:56 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/29] serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
Date: Mon,  9 Mar 2026 14:25:09 +0000
Message-ID: <20260309142549.987737-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22177

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


