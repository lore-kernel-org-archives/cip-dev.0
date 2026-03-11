Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296781062862
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18740.1773227203037929280
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PyBn+CGF;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so9673938f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227201; x=1773832001; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaHmDRGhYSTmfESnPrXNK/3EaeiSSCarNRz/qcQtMUo=;
        b=PyBn+CGF2dSiAzc76srFiTaQ56TNSCSDUrth3q97H0IFJ5iNNC37bhwQCPBhlZuar7
         rFx7+EWtjRf3E1CW4zbgcrenEEGprQdzngl6iBdplnEgj5VwhVYuSmVEWZ6HaQOnDsNa
         zKmUVjRj0JVInDIVdMGoNknOUAUfHNnpsOF+mjo92q/GiW8TZfDtB2zy65eLyw6XsifJ
         vY103JJV6bK2kwt/bjXLRgk2Fx6x+Gl7XzFSwwqhWn3f416pqzhwqNm5hu4IfumgoXLu
         /+3wMYNthRfYZVye05/oRgDS7GfvqrPfzNqyvOlTBrE6aGN467+qSZ9rtWfsgd4MI0B6
         vZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227201; x=1773832001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaHmDRGhYSTmfESnPrXNK/3EaeiSSCarNRz/qcQtMUo=;
        b=Q5HBIo2nFqMEDKquBgqNDHPDChQqvrDcTgnh6VVaP+fntJO7Qge3v1PdWBymrAaFNi
         8ayEIEv+7qm2U5Bn7R68FaQQpjlyikwRsOVWtWCXtgyfkn/9goH4K3Bsyemospwsb+B1
         nCNWjtOWac+MxkQxPR+r+ltWVknp9NPJCOROjD74u9dLHQFd06t/37IUzXqpcxEPurja
         RfDL19HJumModsXaNbMipusOYezWpDdW3LKjHOpNpdWQO3HkGCr5mSNPiJ8FUHuQBZfb
         05vJb+W8ce4IA3bNKyK51IXHOo8pHPsaUotkO1L1KOT/YlOyO0BaKgy3uMkAAV4/YbxH
         wFtg==
X-Gm-Message-State: AOJu0Yx8fo4cNk2kTcLpdNenk+RrO/lF7Iqr9c+Xmai95/HmE8VsbMq4
	rNkLn9c2aa1W+POqVnTo+YmqJr4Jx8KLq3ThJiZAvWLrD8cSUkWjhHfVNI0WgerkAXA=
X-Gm-Gg: ATEYQzyiOQeHUmrB/4xVKajWgxWngWEyVaXEwgqqRS0MJRdVcOrNxuM9WIRqNynUiLR
	/uA9k7Ae57OyZXxSH24cBS1OfhMAohK/D9UMHFpFRN5QJHNo8ivbLmB+ladOoVekUPyQssmagBs
	eERWEECXCJU7AKquLzHNUT+u7NVZra/pawRfUk0oLjXCU4Jx3YbgmOaO5DUOCZKW/4N0qOz+Tg8
	rarlAbU9eD9fHNaQ7gpefsbq9r0XplgU9tdkkAHbJaG8zb9wb+iabFnG0HFzD9Lk26TWOeBlbBN
	UGu2rDMYOjiykm0CylLmB74ggRIfBdNGjl/UH3N/wMt0+9HmF5Hs0GZc816BW+pQq1yzNuo07PU
	DVbr0XPkqMQbwuhnrzPDSPoEv2wZ6xiK8TGJn1QJyAytNTAYcnlrK7v1yJVzAffjJNRmpWt5NDF
	38fgIip2rAagrlph7D7g04NriqEHOqqq1oerS3W4IOxuFFGBN6oF8gw4/XC7ghhFs=
X-Received: by 2002:a5d:5f52:0:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-439f8206d6emr4214266f8f.38.1773227201384;
        Wed, 11 Mar 2026 04:06:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 05/13] PCI: rzg3s-host: Initialize MSI status bitmap before use
Date: Wed, 11 Mar 2026 13:06:25 +0200
Message-ID: <20260311110633.1938579-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22331

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


