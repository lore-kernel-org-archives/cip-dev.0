Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA474105D28C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18277.1773227065228220340
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Gqpd/V4l;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so48880805e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227064; x=1773831864; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiR2DNxVvb7GMoi+WYoR8wCCPYZrMBwaBdGkp6MdOtg=;
        b=Gqpd/V4lIJFsKirjSwVUH0HDQ8zh5van5S3j0SZoKwdWmTSvAqEJMytEPhovzJPHKV
         Ax18hs3zpynbz9YkNxixJY73lGu0RtWKf2rqDM1dNvwehEU2t4AWc3udmBmYgSEYMCsZ
         TVNGGG2v5+UL1Z19aqz7lB949d1PsH1nJpRFtVeRKZJTVJuRVZMgiE5+XfZzZuf9fKQM
         sNOqT7Z8UtnJzDOqOTtV6fpDjYFEIkCEXyVjCvjbyCSSmZihOlq/7SU1BF87PNNWyQyL
         w614fiZ8HL5JHWwcr4aJm9cx4PhK5+jI0jxufgVhrGK8YWvdEHUtJxJNw3DId7ukser0
         d1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227064; x=1773831864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiR2DNxVvb7GMoi+WYoR8wCCPYZrMBwaBdGkp6MdOtg=;
        b=nuz1k0hCBD7q6BFq/etWzNvC+VdIOEuUMA9SNsWMGl7C1cSNTgfWw3iEvcbv7Do3HU
         2TLs/sw+lR5kZieZbaYMH3nGtgLT6zvDMe/eItuDfkTLHM6MpG2j//GAJynAkbAwJGha
         0z0i2P7uK7bMZjXBmzliK0Z58ldzlDdhlvubC/8g5dlAEzK9FI9nxuzQ3JV/fuXwLaeb
         Fw/GbY01dv13p9aVoHS+4zI7sFw6g7z/F3iBKLMXj0h4BJS+aYxgECTtdnELiQTM4q+B
         ssmSZSeon64uSrpIK0/2X6Jvq0pnCfuqC/IOvonTBlFoooFI0KV7BeOgiXNRl2n6TkX5
         8bSA==
X-Gm-Message-State: AOJu0YzP0tuufbfMoFdnUQXdZiK8P7WOC/L4L9q9i3xNuFci8HReerma
	HsvCiLKSHRGmYVSYGD95eM7rvgMCoLZI5mKKs7ljBttf752TE7al4QL6dlB5Yk7cMkI=
X-Gm-Gg: ATEYQzzmWbgHtGPd7IPySkDdOGESUnozgZTYc3Ovt3601NKmepEPK2eGB26dM5zo9BZ
	6U0CXNvHqDa8Vmx1ZtDeKhLu0rjlZdveJNcKdSsXug5HT9zsy9aNG9OHZARg+1ne7yOgiHG7LJq
	YQHzjD5LsUUrKk/d5Xyz+DqALyISjvhxRr02NsgLhAuBGopiMCpIql+UbOqPTG68rWDn53uPCsq
	pAypVz0xuzJa3nqfg8k+u2QFZe31I4iProb085C68L77JUP+xGu/jRmpadPmtnil61NjLVVXNGj
	iwAxCB+cknat0sLKs+BhcoRXuebQwjcDeh3wDBcsVn9hyIFfx2c9vAtrsWbmnNeKNYVM+22LM+e
	aELEeavkG7UMi9sPVKNUXwkKgTYe6N5HWaWIEDuErQZ1XcEws8ufThDXvkDUgJ7HoyAm9KYCOXQ
	MmLEUbZEqwS8iTyYrBIS3iVbHQ+bBVPm5NSKkwtGkXGXrA/6cm/3y0
X-Received: by 2002:a05:600c:3106:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-4854b158125mr44016555e9.32.1773227063529;
        Wed, 11 Mar 2026 04:04:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 19/28] PCI: rzg3s-host: Initialize MSI status bitmap before use
Date: Wed, 11 Mar 2026 13:03:48 +0200
Message-ID: <20260311110357.1938200-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22298

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 94bf74830a977a027042f685c7231c5e07cc3372 upstream.

Initialize rzg3s_pcie_msi_irq() MSI status bitmap before use.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202512070218.XVMUQCl7-lkp@intel.com
Closes: https://lore.kernel.org/all/202512061812.Xbqmd2Gn-lkp@intel.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20251209125122.304129-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 124c07d72ff6..794515e5a6f0 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -481,7 +481,7 @@ static void rzg3s_pcie_intx_irq_handler(struct irq_desc *desc)
 static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
 {
 	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
-	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
+	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR) = {0};
 	struct rzg3s_pcie_host *host = data;
 	struct rzg3s_pcie_msi *msi = &host->msi;
 	unsigned long bit;
-- 
2.43.0


