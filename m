Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B13C10611F8
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:41 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18700.1773227135745795022
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MH5KOba3;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so165564045e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227134; x=1773831934; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaHmDRGhYSTmfESnPrXNK/3EaeiSSCarNRz/qcQtMUo=;
        b=MH5KOba3QFxdsz+x17/e83Dhp+RUC0KU3CxNIJw/+m5gSmXlbCW8/hKhEbmculHrZ8
         hiLVPB+iY4QmPggRBcpdx+p77x8kTGNmRWsXgDLXDOhOUCNAUpjCAiiEEm8eF82zknYJ
         +HA8AXIfH3de7a6wYgVqM77xBn2CQHKYdFJaGU89sAVZukvYIgIePpHnS9/b3asNgLW5
         s9lYbLCKeShuefldsVcUWS8DndEd5M9WTwTnVbblKOqCGj1w/o4SylZX5KcUux+83weV
         8esvpB/Mz58Tzoqeg85SsAO1G0O1rkGudnhYDZ3MXtFmtag2MsAWkcBynkWeVqSn6s4B
         RNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227134; x=1773831934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaHmDRGhYSTmfESnPrXNK/3EaeiSSCarNRz/qcQtMUo=;
        b=tZsXFXBOz1NL/wz3wsl6Nuoa3jelz5IY0gc72P93q5oKALFHD1HlnJE5DtriK7IUgL
         tCx+dVK1jejDTWEWimzIF692hnrCMHL8/g2hiQw4gfD5oH4xZLcIe4Ox5qq4gESSYO1q
         q9t1HsNjl6T5VUy1vokDlt4CMgsERNiEA/eO59vtchDxC8LuViMkVXzhRFeCnl4LW7nd
         llwGS95jcd7gnlr5WQGHdgF2LEVb/6bAJCaW2Sk0ugEbOULElRyNM+POGWwIV/qjzTip
         DJLynZ/S99p4sEO+4Ny3uEA4sDyJv4OtBlENjmctaQCCritNFt/RAH4oYWqNgGJVWGZW
         Bavg==
X-Gm-Message-State: AOJu0YySLGVPB1Tn1hCBt5YmE4GnDprqGsOF2lPyanObxcc1/wUIvqc8
	z6NhXR4G8lxqS+O1euCs4YhCOCvvSMOB20OeACfeQE2kR8Yz3sdK/xFnjwU2ULlc3AI=
X-Gm-Gg: ATEYQzzjPcLjOxcPhAi14ZIHXkf1stjThmIANFqp0KT7XsxUXy+8in7/BzPrBjnHNB8
	MOI/qbv5vZVzkx4EGAjeHrn82VtZoVZq8/bzdK0Ht+CJLDhx4j0cUbHQHFpFSyJSa/v1Lw2gMNM
	88oev5ppV/20bSSfCdBLlmMfmcnb7OObPFvXQO8qNPYgh1k/vuwCgIv5pQYCUvlKcU7ZZ9C47g/
	0lFbNw8QtSjvucgmfCjBCyq/Y+SMzClGLi1dJV6BBtePp9f0zC6tNzrgWI9mQNvMBzGxelYsgpX
	xa1qt3obqHY1oZNOhTou+n1Dnury97nVcdbVffcgSpSvkHHKjfkbc2tHTBoQn2Aq+IaC0F9HWrg
	NjIJn/5XCihjRpzG4OMILcnR+Mzfd5MkPQ/JMKUidxcjGjrLsGhPOUSHtcC+NqDgxgl65EBrjM2
	cV04b+MUW9QtOTbNIFRLomhWkxxIldhopDo80J351fpM+nlycIbi3a
X-Received: by 2002:a05:600c:8b6a:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-4854b0cb2e0mr33320545e9.2.1773227133979;
        Wed, 11 Mar 2026 04:05:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/17] PCI: rzg3s-host: Initialize MSI status bitmap before use
Date: Wed, 11 Mar 2026 13:05:12 +0200
Message-ID: <20260311110520.1938414-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22317

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
index 66b6a09498b7..81f8ddcdef79 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -478,7 +478,7 @@ static void rzg3s_pcie_intx_irq_handler(struct irq_desc *desc)
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


