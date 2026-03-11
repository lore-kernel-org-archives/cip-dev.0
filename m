Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0923104BEC9
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17325.1773223508466967533
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KPUDfwh6;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b611274bso6883788f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223507; x=1773828307; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiMKaFX4bXVJjRm5rNkO79+GKXOYFyAz3TFI/oBgSG4=;
        b=KPUDfwh6G5xRaySBxib4f98fZtbm28Vj5KkbgJnqD8Fco3Zg/QpHCvG2vXCYAjRAFW
         bVZPVH6mn59rYPslP0KMDheUtpLT8yqHKvd1n0qaqbqXXxPNPkEE6sxwzwZbqhfFU2Y0
         nYwLzhLv90aYrtDrH64Ndg2YciTsA4Dw4CIYL6hBJpnCKTpk9LhCIRm7N8qcgz/EH1ZN
         9xADtYBI5Logs/mTy4x7Gd5JQbogJJZ6KqmDIag7l+MW2zBtofVpNS05XUR53/zq5jCR
         RhROcJNYhgG48ox/JvdJoRbQaTvBirBmwcKn3Shnn1r+rz6svX1/f/JioRuszfLrNkxw
         8cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223507; x=1773828307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JiMKaFX4bXVJjRm5rNkO79+GKXOYFyAz3TFI/oBgSG4=;
        b=TW8H69u6XkOzPPLoOtSspUnCLLILH75HtIoyMWvG1tFQ45VL4MTNZvYxMjiwGHgYdD
         WE3AdBpmqXH4/odXkS5DQbccyTG2r1b6ngFAp6AYpz1SA6Ub5Eml8Snsx6DZr4KZX6Xi
         7jnDTDWW0QyP1AeEmp7OCf7JVue4mHL1PxjWH0gyUF6vX6QPQSD8xhe4W4//x39JLRDn
         Rv+51tTpu27JrUMsaVVbgJgdJ42EDySngblsWtTq/yPRlroFonzcjrOsKq0amrthogPX
         JW5sdK99tZ4hwsXmdVAOz/NO6YBe/RHV6AkHsJVcVEUWnV81eP1WkmquT3HFIuLxJCjj
         lH8w==
X-Gm-Message-State: AOJu0YzB50+PwH0ckvYuZD7pJ1tw3/pdHhBVFE3Dh67bznbDZQtaCIpV
	268MnZ11Kzi+2YnJH2L/idDeslNO7gTkQ4cJVXhwQlMIYNIIFT8HEEtUwUK9pA==
X-Gm-Gg: ATEYQzzuzHU7fn2E2qFSZ1gyz/d8TaVAFvsawPJsfVRVHvT478dD76lOgNK42tc48cu
	CwfyLGIHVOKepcOpqecblXhwjUfBQsZlVY0gN8W7l5zdhy9ALLUiaN6Y9no7Xp6bPz72YMJtSwx
	6DExZBj6nKZu11rMpYr6ETk2MSGCzRFM3MHc8EkFqPaFduXfoLo5HRzy0erm/9QMSQliJ6gNx1H
	PTMl+Ri0VAcWZRu/rjEeUGytvMn0JgfWYnjo3FnwAsF9kgFD/T+7mstZ0Kx/725eiH2f5PtCxVc
	CEpHL1tabU33nBjXdKnxKUJVI4aMxoWr+qxukbIle+msbTsUuCJzZIJ2/a5SqUBwSUxooR5KDaG
	VJOwhX3azyn41RGKnyBfcYTWjU5qv90QmL1h4/krHSwj9CveCJj4KAmLhpEiMTRSjS3JarVSnT3
	zxooa81eFmin4UAJl3C4Wov1SvNY7N8j0=
X-Received: by 2002:a05:6000:2486:b0:439:f612:9a58 with SMTP id ffacd0b85a97d-439f8222da0mr3749938f8f.30.1773223506392;
        Wed, 11 Mar 2026 03:05:06 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 11/27] serial: sh-sci: Drop checking port type for device file{create, remove}
Date: Wed, 11 Mar 2026 10:04:30 +0000
Message-ID: <20260311100458.162447-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22257

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
index 4da0251c0b10..7f23b63eca13 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3550,16 +3550,14 @@ static struct uart_driver sci_uart_driver = {
 static void sci_remove(struct platform_device *dev)
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
 }
 
 static const struct sci_of_data of_sci_scif_sh2 = {
@@ -3915,15 +3913,10 @@ static int sci_probe(struct platform_device *dev)
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


