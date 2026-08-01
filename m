Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE5C55174
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:24 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2464.1785575715998118314
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HygZ5epM;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so3798835e9.3
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575714; x=1786180514; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9LKV8ChpIoWzO/K2p+gfhHZ+mNP6F3uQ01V2tV7woA=;
        b=HygZ5epMv6s6h6J+XetWi4SBDDee+eUi+S8IdLey8N3QFIbrCJCYWS5HZcay7e1Rsv
         bt7BR2QEFedbj2uPZ1roLE3b/fp5v7BbSgYDmTETPptjvGw4XdOUab7t11KjvUmDdIcl
         5NBSnDDspEE/x1fcchmFCOs/m8zczP2hYuWFInQuXIZ7Lc+RP8W5zz9iOK1P/wO3VFtc
         wsDQj6BHm1E6GnkeUcPXpheynnpKswioWB9+IXZ//hClcA8zdWPlyrXoRFjL+HcmiLjC
         wfSeNNs5ChId4NXFVuJW8WljBmZbSdumaFf+QzQv4fu6UTnEQUBzYhXJiT1FCTBQriJX
         JHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575714; x=1786180514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9LKV8ChpIoWzO/K2p+gfhHZ+mNP6F3uQ01V2tV7woA=;
        b=G7oMX3WZIKeeo9nkToiJb8+B61AVcJCUOnSEg88F77A8Qy2SXCjqJOrThpIPZGQMeK
         JWYyNK36eBtMwlptrQhcM5z7Hat+ioC0sCv0ueiMwRaBUOP5rFNJfzKcdf9QvNWm9rA6
         zhr/wHpUSLisqZwR1v3bxUy6yD8BNqFfQ8eK+aZLfpJEYTMSnqoL+oW4naZMua1DWVoV
         IjiseqPtEZbkjxy8W5kffNpDNEBDnwp21OBFBwpQinNvLSD+9ZcGJOsmMOA68u3eJoKi
         K0NvlWmNqYKoE93o4JfhhIk/zIsuG/DkPVUDeaBt8R3iLOpTR5sIzUmQiSYlfzZL2qqc
         VLNg==
X-Gm-Message-State: AOJu0Ywk+SMGTpcTERVWHMOv7nELORaY6J1h/y0lNloi5k6sTV/lGMwo
	YRdLffbW1IUpKCnIDCdr1e0YSc6+//0ITqGbv1WYyBlZUU84B8bvXuSMX/gLyw==
X-Gm-Gg: AR+sD10z4AIy1kfh3zRmG+TF7H88lqrGw2uKz6Hkzt36IW+qdwQ0IQ0742YMog+ede6
	CWHufw1/WM3Fttt6d076piFglCoeRi4FSTJRVSbc4I8d1VzQutUjaK+y5E6h8xxGmSmN3ggxzo2
	JwobCGuIZZHnJABOU9k/H0v3nD4bbOdOGhhyP42EY/XMa7mhSb9oXfa3QB13QADM0rNyH7aTlqq
	hsUeTWhvS8eUNjiSM0bTWSEFxfTZQ2TkbPQVJPSRU837h19N5FSW1+1SDPr5uTt2HWqJN3VmAW4
	BsGMcwjqzlpYqKpWFfLIlrsBvwgcfjrWElQApcRQZee3mpBfJqfi09SUdtYnRUja8RzXXeUEzmu
	wHbEKc8Vcl+JJMngL1gPrZW+n8kGILg8Wl9WHqw4arLtuq/LRFr9Aby1D7VbvsFzmPUBxCSrePu
	yl3xNBUfp0QjPiOWtYTUzoeNVIX4Jj+WahjeOxIntEgr5OxL6kBXxCYjOwiDcvOwlKvxPu1IC2l
	6y5C7f+5grSgBCNJbiVLiN2
X-Received: by 2002:a05:600c:1d29:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4980c66c867mr37011195e9.2.1785575714215;
        Sat, 01 Aug 2026 02:15:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/19] phy: renesas: phy-rzg3e-usb3: Fix malformed MODULE_AUTHOR string
Date: Sat,  1 Aug 2026 10:14:49 +0100
Message-ID: <20260801091458.14026-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23845

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 53f60930e3d20883364fc01fd46b6099acb8127a ]

Fix a malformed MODULE_AUTHOR macro in the RZ/G3E USB3.0 PHY driver where
the author's name and opening angle bracket were missing, leaving only the
email address with a stray closing >. Correct it to the standard Name
<email> format.

Reported-by: Pavel Machek <pavel@nabladev.com>
Closes: https://lore.kernel.org/all/abp4KprlYyU+jMPu@duo.ucw.cz/
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260319063211.5056-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/phy/renesas/phy-rzg3e-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rzg3e-usb3.c b/drivers/phy/renesas/phy-rzg3e-usb3.c
index 6b3453ea0004..030c600a53e6 100644
--- a/drivers/phy/renesas/phy-rzg3e-usb3.c
+++ b/drivers/phy/renesas/phy-rzg3e-usb3.c
@@ -256,4 +256,4 @@ module_platform_driver(rzg3e_phy_usb3_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Renesas RZ/G3E USB3.0 PHY Driver");
-MODULE_AUTHOR("biju.das.jz@bp.renesas.com>");
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
-- 
2.43.0


