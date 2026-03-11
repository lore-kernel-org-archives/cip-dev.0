Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF5105D298
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18267.1773227053178879027
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MUALGcNb;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48529c325f0so37124225e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227051; x=1773831851; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhLAokWZJg3knp+fPNjAArp8papoNT+gO/u+hWpBM6Y=;
        b=MUALGcNbSBScB8FNMOKqkwqa4IMLoFCwbQXEWIp1IG6rVfCOZmG4665ILbKZ6xSDfd
         mJKJOw9fmZDoqTR+jGqshgnrjmfjGyRcUhXvpDpXGK5tNgdmmhBFqMWBJ117WoSl9jMg
         DOh+e1HEbw6RD41OusDF/WXU4yxiRpbck5+Bep2vM0xUXBV3qN2WCgc9VtgRKjrg7gns
         YK/MHqtrvkJW6hl3ZGt8CUyHl9mUUySgsqHQgJohvlQZWOnznLEaBC+YQt0Rm6yxXDmC
         xJlEOFiIRycG2VudHmUBLScV6qkoodlJocCXf+FyjWq5VytPyJMb+himdZVMbjYBdyxL
         V4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227051; x=1773831851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhLAokWZJg3knp+fPNjAArp8papoNT+gO/u+hWpBM6Y=;
        b=Edl3+Ve3vkKFjMPeSs83YObsJy2wtcuQME/B5sWWqjMBACTmtmSo7XhzipohjaGnBN
         WXFpvsQVV/d7K7ZzO1IMx1TXSgSkflYXw+4ENKpPveWHeDvvE4KVXPCrZWvy+O2OVKI/
         Cj/2jZNPrtb5NYVXnsrO97YLYUtFHBfKGpjErQdwnoxSsivBikZUjRz6SZoA3RwfIJsa
         hf/rM2RK6y9k6G3JnOnhEzoMevzey50XPgVMaYToWwq2+L42mz+phJH3QZtU2hQacNBo
         gRhl2HcibbrOaRxMCCkIShejc17QqcwB6FO+OdWQX640QpOPd4ZabjvlF0oFuMnv5F6C
         EhyQ==
X-Gm-Message-State: AOJu0YyldaV3KSHvrTBAAaWZHvUlFLdyDQAFW99iJ2H8hovUnA+Iehad
	VEou+bldQO/v6DB8sYMadKGdcdFm0ik1B90BAbqu6ZWjXuvVW+tadLaQH+dvtv9ObQ4=
X-Gm-Gg: ATEYQzwI4BFjHmQ5OOuknHe1eXKBhdsUpnynsY9tys4ujbALRTyniyikMwqX/dxwiLH
	3kXzKi8vKsiJYKSC4akRyCf9zOn+pUx7J6tf8ITtBMvZP5XmNpg2YLTyL7v3RAULmBeUcPje82k
	rvKiVfLlL4QKHXcPSOyImjnGyjG+xgQGzBTC3kvGHfjKT+yPA4zfuo5zFhf9IUMs8trrAOYnPSV
	tQQ3hvYhbgoVEz5I+VdiyBI2wd2tlxpj4xdNAqj77Qv5/fE/mz1ncWUyK6zhFx4qsPEfDPkLNUk
	4IEyXrcF2+jSEHySaoySBIwyUfpJTr9JS+JlG9U8fvZIxXbPINmqA2r1zc8mHgOlBUGBRCz/Jco
	9im0SJ2yKMYlRj3fBfCO+IlbRuR8PNsnY9AXP0IUHC38joWLQJzrxsUNaHHOMeAQE/zaFOuaIwk
	Jij8sT39ZHO2KD7t9joMiy0TtxL8EFQcm8KTBVN+BFH1K7USpfOGTw
X-Received: by 2002:a05:600c:314e:b0:485:3bc7:a21c with SMTP id 5b1f17b1804b1-4854b10ec37mr37874205e9.24.1773227051499;
        Wed, 11 Mar 2026 04:04:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/28] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Wed, 11 Mar 2026 13:03:38 +0200
Message-ID: <20260311110357.1938200-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22288

From: Kevin Xie <kevin.xie@starfivetech.com>

commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df upstream.

Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
waiting time between exit from a conventional reset and sending the
first configuration request to the device.

As described in PCIe r6.0, sec 6.6.1 <Conventional Reset>, there are two
different use cases of the value:

   - "With a Downstream Port that does not support Link speeds greater
     than 5.0 GT/s, software must wait a minimum of 100 ms following exit
     from a Conventional Reset before sending a Configuration Request to
     the device immediately below that Port."

   - "With a Downstream Port that supports Link speeds greater than
     5.0 GT/s, software must wait a minimum of 100 ms after Link training
     completes before sending a Configuration Request to the device
     immediately below that Port."

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20240328091835.14797-21-minda.chen@starfivetech.com
Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
[claudiu.beznea: fixed conflict by keeping only the definition for
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c2fd92a9ee1a..a391e4db9401 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,21 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+/*
+ * PCIe r6.0, sec 6.6.1 <Conventional Reset>
+ *
+ * - "With a Downstream Port that does not support Link speeds greater
+ *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit
+ *    from a Conventional Reset before sending a Configuration Request to
+ *    the device immediately below that Port."
+ *
+ * - "With a Downstream Port that supports Link speeds greater than
+ *    5.0 GT/s, software must wait a minimum of 100 ms after Link training
+ *    completes before sending a Configuration Request to the device
+ *    immediately below that Port."
+ */
+#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.43.0


