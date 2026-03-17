Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEB6FD7094
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73594.1773746260477962788
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d2Pu5cnr;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso47149455e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746258; x=1774351058; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0r6h2C2Ka3ic9+MZTYtdcFn361EeGDE8RtEUbTGMFw=;
        b=d2Pu5cnrP2An36tDxolAqxK9V9QLLWc+Rd1Z23ehHhpUgPWxO0ODAJ1hUvJyPsxWmc
         D5TRaGJ2v+0ocgXaadi/zYBSV1e1EB748Ekh+SpUjIjvkFj+W+oMP0VYjxYtAJ7jMlPM
         YYjkLDQjTLH4NdqsLm+nY+snmu1kajELzAsA2BWMQQBQUfHHQJcldBhqcHkTC5MCjI4W
         kJUBN+rUBc+b4x9zuQnYXV5ffnq++TP+kVdvoqCP4h9McQxjkE8oVKDuw/ctHG1ml897
         mGLPbrhUXg12RS85RsmFeDkhJ50via2p7l5eydghM+pxKuKhVHy6OVW9jfwveoUGNDFp
         uicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746258; x=1774351058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0r6h2C2Ka3ic9+MZTYtdcFn361EeGDE8RtEUbTGMFw=;
        b=egXDtv3Hgma/LOe2OjoEcb8I9wMVxvS57ITUW0PRraXC2EUx1fz+i8rj/rxihrrYjP
         ZLfW7mC1Tp8u7/RRVFp5MSPxIW+EZgD/KAlU5CY6zx2qDCXpxstwaibYGvLIi5+JRP2Y
         j9aS9VUMcKOgrV9+/FIkm81emVRaSZsowjKSsF/sl8uEn9GacE2i3SGJjM/rNigu260M
         ngtc6q6nWE9qLpbocMf8662mvLtr04kIt8dZo/PW8Yg2KIpB8E72vo6T+D5VGkv6jSG8
         OmXFpsHupKRPdsOcr8lzxwiRYaIz1u1yHoRoVdkqwdr8QnWZYwZKJf2H5d33sc1HPZEv
         K2GQ==
X-Gm-Message-State: AOJu0Ywut56XitpJiu9EZywsN5EwU4xYnLbXhxckk9SQjkhbyv0LbpFN
	aIoBqeX++XqzEe/ZvRemPB+3c2BvHYdP3ze547r2hZ6NTpq1x73W54P+oWWvEA==
X-Gm-Gg: ATEYQzxpiplsIqGknNEGAHbJ8HuQcIN7ly+Kg1L2pwLlH5LGcspeUE0syAEMKC8wu/e
	5dwQWGC5fhj4sgakhibhyN4BfaQH7I53k6+MUSbmz8ooE/3TVlaecwUJlJOpQGwNprBVRA50Xb6
	8zxX6+x9H+gElVua+6Un27fzlfd2aOYVz9Bl/xyw/JkdJ5WPri8WkB2sUJl1e6ZIbsbAg3X4NJz
	N7oGuVqCrZz5YBPCqyozTbHhYEftwwotyrKwD7P3DwZVflfPWCg+TplBCXI3yES3YUZoDClxBw8
	JSW4hcmT0QvhFJ4IR1yVe1AipxhkhWXn5ygasTmuEeLk3LRrmGvpwZmAuaVH61CvwSR4oEsbfGu
	TXhDL+SY/Kx6DPe9lJtanghBNRkj1a+sh+5SpGktce+SFvCFRliL+niwllNPH8t+oEXtGnqBKZu
	FZ9OZc1azI3uyRtyv+5g9qvdZuQXGqUyK7Hiw7kk/HA8NFMiia
X-Received: by 2002:a05:600c:8b56:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-4855672ad40mr276083675e9.33.1773746258348;
        Tue, 17 Mar 2026 04:17:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 23/39] serial: sh-sci: Drop checking port type for device file{create, remove}
Date: Tue, 17 Mar 2026 11:16:48 +0000
Message-ID: <20260317111718.281633-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22456

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 42f7303c5f668403f06d9b938d3de2bda3736530 ]

Ports that support FIFO has fifosize > 1. Replace checking the port type
with fifosize for device file{create, remove}.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 02284def0a35..3effde1090a6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3545,16 +3545,14 @@ static struct uart_driver sci_uart_driver = {
 static int sci_remove(struct platform_device *dev)
 {
 	struct sci_port *s = platform_get_drvdata(dev);
-	unsigned int type = s->type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(s->port.line);
 	uart_remove_one_port(&sci_uart_driver, &s->port);
 
-	if (s->port.fifosize > 1)
+	if (s->port.fifosize > 1) {
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
-	    type == SCI_PORT_RSCI)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
+	}
 
 	return 0;
 }
@@ -3912,15 +3910,10 @@ static int sci_probe(struct platform_device *dev)
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
 			return ret;
-	}
-	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
-	    sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
+
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
-			if (sp->port.fifosize > 1) {
-				device_remove_file(&dev->dev,
-						   &dev_attr_rx_fifo_trigger);
-			}
+			device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 			return ret;
 		}
 	}
-- 
2.43.0


