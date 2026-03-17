Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01494FD8748
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73934.1773747409843449768
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IxccjOwn;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so61505855e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747408; x=1774352208; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOF+pNBDLG5CrkS+/Huyc90OdHcHVia+fTFchDT5gQo=;
        b=IxccjOwn7fRSl6RC1y2ORi1i2guWy40tL8uUPiD+P/vAcDxJWa65ScI3gK52iPcGkd
         xOtfPSw/TpjODaslY6rfJF5CCmXnoYPDTNSh1whshUPTbPXWM20rZ+tHNdZhRrWz+azd
         AFWJurMLhJrFTScfHn8KMMwGd/bBuXZvQEvRTZuZ18x1e82jwSAYn1fkCUH4+ZdiJ+rY
         SVO9jO0dIvQyJkgMddHeOcOUUn+PHQCuXCg5AxMgUjoHDIbr1hP4h6eZmO54UAnN64H0
         sXGQ+WtnGpeh1kLOd2b4/TtRcs60UHjHxWAjeHXkDi+wQpQcgA/2cIkRwEzQqhYDxyRw
         CBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747408; x=1774352208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UOF+pNBDLG5CrkS+/Huyc90OdHcHVia+fTFchDT5gQo=;
        b=AjeVloVJVmoslTWRRDsQK6n18dYa84isjIambQ1cu6D/INU/rUp+QTV3w5rocbDVxY
         W8iivAArio6KurUVw5B1D7an3aTIFIab7jXGBMUUWAQuHr0CV7vLNVhI9qsNuEK2kl0o
         S2rMDOknHDlJkKZSurCLCFt9b4whE43xMTmQ2E5gvi7M42E1jGwfAIgKVD7cTRsw6M5x
         2Us7NIgfuWyVbMTOxQn7yYTOdwJUhIllwuOKCcEutXfSX/jt98aQERDVymGqjvGPl7Lz
         yv5dCnoUF7VKFyOg7LR5Ehg9m2DQpNlb/sPRaG/2Ui2Dq6hk/Dgbqz1lvUndlH2ourlp
         ylRg==
X-Gm-Message-State: AOJu0Yyc1dkx5ZTchI8+fzoHhJWF6nFnOovd6uzomeeeu0j/Ky8qY8tx
	WpwGNxuEo8ybekba75E0SR7Dxahp9PJFkK/NE8X3agBJGx14b5/kWEbzGprUXg==
X-Gm-Gg: ATEYQzxSlfT9tOaQoHQ3GmZj5apOzq6s/wkF7g08ACE4FsJXdlW4vnKJMPJUECojV+S
	Zfn+dDzqoL+HoSldcdXqqOn3QWbjO2pSc3TSvQA1O5xFH5t45yessdkH0bLw4NH8xz1OCXhp9Nq
	pUYa0OnHiP4GXhElkS7VdqQKxRkmTM2iEdM4eeGjAYFWg7MKwep5swterfAM+RmF6rOQ+YRg8mv
	DMbkUz2jzoEH4BZFtLWH0uY/OSqE1dB2rT1aTak0cWWLQ32ncT60aG18D1M8++rg5auMbSd6lOS
	dGNg/jj0fzzW5hbV9vnDqqvkXCOQrNJ6vMJFTCLtD+a7u7l1g+0rxVFy8mOMV1blPMMB+q3aV/C
	c1EWPZbKg9MPUUJcJa/E0muu2BwOhby9aUDEZZZWtw/mRXzeDibyZIUMhL47pvDLlnmPyhfOEt5
	q/1dUZdIFz5iG2o6npO+SC1G2O0QpzoCH5zkJFD5YXc35o7Tti99RwnZ36Fes=
X-Received: by 2002:a05:600c:1988:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-4855a8d6fd7mr259181635e9.32.1773747407721;
        Tue, 17 Mar 2026 04:36:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:47 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/11] usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
Date: Tue, 17 Mar 2026 11:36:32 +0000
Message-ID: <20260317113643.311192-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22479

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
index 131d75063849..0e472dc62d96 100644
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
@@ -485,6 +495,10 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
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
index 14534aa5967d..25f9541bd144 100644
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


