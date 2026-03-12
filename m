Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FEB1067051
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24718.1773329729457691318
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZR/ptCrk;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so9810855e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329727; x=1773934527; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHSW1/21PzvMhTekpROFEwCLjPZx304kTM0OmtZUFbY=;
        b=ZR/ptCrkX4H80+zHZWXqBp7XqgdKYx+SygRnxh8vGIxSy44ADTvcRJCmLjidTWy7qA
         QbpVAJ4detoJsPNydLEzBZJrjm8dOcOTEiTK2k2tCjFry7t7dDxKNkkO94giLhKIrEBP
         6pKnwi5j8wI81Y56SbnouskJH21Vd7tkKrR3DNvPrqK9/mXF/2R3VwJRakU/t6TfylVa
         5qSHhIzT2Se4VB/ZRsbh0fjui5Mq6KM8gIy8HL5JxPrARtLCKC9YKMDuNEL9/AE6Bo+9
         wOV+W8WlzJ4IOTu9NgZmNViiscqv+7RlvR2I0ag2KdDLXy1jELsr1cKNXsQctyZ3063U
         9zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329727; x=1773934527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHSW1/21PzvMhTekpROFEwCLjPZx304kTM0OmtZUFbY=;
        b=g4KlHIS/knMIbPqVxj6OOya/Fbx9/yl36koizu9qI2CIibaV0o0ss+ybKzSUNMN+f5
         Uk75zTuiTVIB07IB97LKEaOmIacwdoZ8wyv9o0AaVxI2k+/n990cIrOdiOH1jvmEPhlj
         bGXT5oyNE8MH2eKm4MCO4uslRNuH6t0tGzrYO7kHNeIyZM08GRJOSSSvERq/5mOAS3oO
         /b8ZFB/Zlpaj7qm16rdRK0C8wu+JTbEd6cyg+BjpDe5Zd0+EB3tC6fpew5Yx+0C2DVWT
         MdhXtNr/lEBNzwdgqmPpC/M9qArb0RFNzzA5ckwyT9fi+pG91kgN/QiY102c2BTX7JTV
         2M2g==
X-Gm-Message-State: AOJu0YwJHfA5cebIyCDv/bOv9ntoBclai1Ngnuds6A3xGOHC29Ujr5Bk
	+x68SBHLqU8kUHCKLtZYJmCRaZqtoj80QFeTsa3UMUJEv01esMj8g4EidPhVUA==
X-Gm-Gg: ATEYQzy7DbA77IJT7EggBnpM8OR44y8kYS3kv/AmlreY44j4bUGEm/nAwFNnqHpwvRm
	JJqX904PwZ6hEDqXFIhgpfAQRqUvjVhBJ5a+JnLXmgJos4iNh9xEgcMQsdCy80+LHHa1yo3atws
	Zxn0bwW0EAlKXbAXeq7oVzJ58SWp5kW/0YGS7XB2rnCX82UCmEycOGFAQZEBAMHzgRHx9Ti+4VV
	slkhw+cDeYt7Gxk++RPF5+tE2BpRnEn8dIkXO9SR9alKeZd6CvF8BYWwIBxI37lyhiQodIAPe+k
	HBD77K0l+T2QdXEMAWcFlfz0BPvKx19FSsuo7Udo3JMI/j4VzEctUy9XUqu/tzgFphDW3rbt1La
	UN+64KB/STNr2ILoQDSKgxpPZ0x/5ADjcIN7JpHwIpMaIx8Oj2YgkeIit9iDeIpSHB1pZ+GbI1m
	hTE8w8zvwsZhx320jH/SSUCa8aNVbKW0I43NOpDYbFQjmcAYk=
X-Received: by 2002:a05:600c:4fd5:b0:485:379b:57be with SMTP id 5b1f17b1804b1-4854b0cb6c7mr112436135e9.1.1773329727428;
        Thu, 12 Mar 2026 08:35:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/11] usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
Date: Thu, 12 Mar 2026 15:35:10 +0000
Message-ID: <20260312153522.1131675-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22361

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2ef16e4eb41fe711479d92805e4b9e430c7bbefd ]

Some SoCs (eg Renesas RZ/G3E SoC) have special sequence after
xhci_resume, add .post_resume_quick for it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250916150255.4231-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 14 ++++++++++++++
 drivers/usb/host/xhci-plat.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 448656d68e49..48e0463ee194 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -74,6 +74,16 @@ static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
 	return priv->resume_quirk(hcd);
 }
 
+static int xhci_priv_post_resume_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->post_resume_quirk)
+		return 0;
+
+	return priv->post_resume_quirk(hcd);
+}
+
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
@@ -505,6 +515,10 @@ static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 	if (ret)
 		goto disable_clks;
 
+	ret = xhci_priv_post_resume_quirk(hcd);
+	if (ret)
+		goto disable_clks;
+
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 6475130eac4b..8c904b0fe555 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -19,6 +19,7 @@ struct xhci_plat_priv {
 	int (*init_quirk)(struct usb_hcd *);
 	int (*suspend_quirk)(struct usb_hcd *);
 	int (*resume_quirk)(struct usb_hcd *);
+	int (*post_resume_quirk)(struct usb_hcd *);
 };
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-- 
2.43.0


