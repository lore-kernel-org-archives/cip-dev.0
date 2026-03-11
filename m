Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E210611FA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:41 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18695.1773227132118576558
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=F7ll+8jB;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so22750695e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227130; x=1773831930; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvx/mDIP30+ev05rk5mC6JkNZOPHwyEXEIYdZeak8Xs=;
        b=F7ll+8jBaJCmIC6/7r2uoMJEaI1eOXc4YKpZBCsOIwSRmDJwWSATy/nQI8PhlZzjfU
         iY7smp+ebUOvhAd5VR1QSuwWNW4v85Z/xMiIAI5wMT0sUCx7PZjQqgrge+Ea7VS/7rIV
         4DoHPXPZ9htA5tVaHikMLl7TJOOlWUf9iwa24dPSDddwo491MR2k6uZzBofJVRx+rU0I
         3rleamRY6JO7wIo/T2AKhSPWt3zOYxiO11SXeI2+UwiftAgs7oxFuv/YByOebro+Lu44
         fWGI7tpHNqtSMJaV9qiO6omg53wyb5rCQJvBdpeD7IpAzaKwtII2Q8MabV5QiKYBW0vj
         ZwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227130; x=1773831930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvx/mDIP30+ev05rk5mC6JkNZOPHwyEXEIYdZeak8Xs=;
        b=d4kTgT8tI91uCsFv03jlWc5doR6X84A0ZAelGEC5bsicF0VxslGsRd72rqBK8gD53b
         GsrSqExq8Xfgokcumz8Gw2okjTa1iWEMkEB2SlY1craD7cy2SWtkHbuWYJMN+rEgP9nE
         6NdJ7k2yFLdJwUPu8pMmYEvsZvdYnykgj7F+ppzSX5q7sEo18QGLyfI+YAWpnPmnAs7d
         NpPHX6zLtNQPzz+Y+drGHnMuHENFUx+nJzXENEBJvhTzJ8BhMaRdl2Rw8UNEkfQJ2y+b
         xYQcLefMbcE/bTUaTs0fuGOOMcERIkMk4LGJVk/xgvKC2UY9cJozGh9dciz710k1puMO
         dOIA==
X-Gm-Message-State: AOJu0YzteLl5FIi1i1fJcZQYFyC0T6WcMN0YPxAHl3dN1WLyAEh71iwe
	GLj3ZHBl2ifpHgnglPqVHU/VsxjeNFObiHoWd+6lBDZ9MPJ1uExQ6uoiGJUgidLEjNvbfOYmueh
	Sl3Uf
X-Gm-Gg: ATEYQzyFd9HOFR9SP4rPvyYUnkU/i+oEzVgPA+kzpVx3r7LkO2MGcZ2vgY7LPWw64Q7
	l4WmVYEQRUkti9ggBk/D2ngDXt50Qb6ZRIhHFj9G6eT8NCJT+371p5I6NrPrADaMmOiPaK6eolG
	9fQxBHl7EZqSsAybiIjsery/dvu+QuxP2wpp42W169Uwif5jKWnJq0rKYZ0GNU5A/XUJ1+vltPU
	qSC7SsWSPqs1EZgzchoryY3MG71MpePw0ixYWZFShPs337ryCY9OqelVdw09/lcBJdWdkO67Nsm
	1qZ+WscDCIEHvsXI+p+e5bvN77nX6xxn2COxpJoh1N+sqail9qlg6W4bNLCltluRj8R64ocP2MJ
	YLfKMHps5Hmeu+xxIONU06AXftoepywkjaq0Lzwl5SVBbEaQV/kjCKiCCWofn619luRxscitvbU
	MdCnq3ol7+gDXOU0oMF+H/Ssxcb0arMwqmGKzoXztNn8iqIBSSwVFJ
X-Received: by 2002:a05:600c:1d06:b0:485:4453:401d with SMTP id 5b1f17b1804b1-4854b0ac446mr33291135e9.2.1773227130511;
        Wed, 11 Mar 2026 04:05:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/17] PCI: Move link up wait time and max retries macros to pci.h
Date: Wed, 11 Mar 2026 13:05:09 +0200
Message-ID: <20260311110520.1938414-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22314

From: Niklas Cassel <cassel@kernel.org>

commit d7467bc72ce4e3f64062017d6c9ae3816e8a7b0e upstream.

Move the LINK_WAIT_SLEEP_MS and LINK_WAIT_MAX_RETRIES macros to pci.h.
Prefix the macros with PCIE_ in order to avoid redefining these for
drivers that already have macros named like this.

No functional changes.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250625102347.1205584-15-cassel@kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[claudiu.beznea:
 - dropped changes to pcie-designware as the CIP v6.1 uses usleep_range()
   while the original commit uses msleep()
 - fixed conflict in pci.h by keeping only the PCIE_LINK_WAIT_MAX_RETRIES
   and PCIE_LINK_WAIT_SLEEP_MS macros]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f305fe8327d5..fd3270b3c0c0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -26,6 +26,10 @@
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
+/* Parameters for the waiting for link up routine */
+#define PCIE_LINK_WAIT_MAX_RETRIES	10
+#define PCIE_LINK_WAIT_SLEEP_MS		90
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.43.0


