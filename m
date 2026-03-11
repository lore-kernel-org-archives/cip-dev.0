Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4986F105D290
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18269.1773227054256440882
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GOCkkWJC;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48534e9076fso27090695e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227053; x=1773831853; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEZWLu0eZM37b3W1Ml/FBnU8Cow52ew0V5ulNisue60=;
        b=GOCkkWJC4vzKUMPUmfO4uF9EsNU0N0NlzrcU8ia/ctTXPSt3sGKiwJfzZc5k9P53bo
         8p6amx5qBLMO9wdezhvi+adnnFaAw/ycKKKVnfD+bqoCWB4UpRBp6NDjOqY2e7533ufF
         M1UmZwVCLGQu5QHXkHCLdwK2KzLyQOBG//xhcWw7OFqG4YS90QSLLY5X6kf9duxomJjJ
         7rAC61gBKjG2Ewj3Y/gk/AOsRxlesS8JIGM6OFW/0rIMckq50n+35vuqCKfWSunRbWHx
         AdJoGFleu7zRT4thMOQ0InJQXTtzGUG8q/RvOYszpAkQfAlzTPTDZxID4DJIx31OFf0G
         wC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227053; x=1773831853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEZWLu0eZM37b3W1Ml/FBnU8Cow52ew0V5ulNisue60=;
        b=nM9yeQnjPKVpfeAbSCRGH8kaNCwiNI0+lUF4sAPilr87yl9n7VR/qDsgrjWquXrp0R
         B9Jr1clvgHu0vK0ah9KQo1TgeoCTW+/+iVbUveZHlX41+AcsJ4ipnWoR3KjkiyVfzj40
         cB48zYZZSjeuWlzJ5Pj4F1MUz/fPmX+olhp5bo6Fiy2bGoRk/l0rKHyiOKolGKlfyT3c
         XZ+OFblcgszXl7sweMCMfSIkCjnZR+mqRd2UoMgWEmIXK5fa0sSrv7Zq4l2xDLhBjmu7
         IA0fhUKmO2AtoNW9OwdyW9cLuNS7wbVGv6rNFuu7z3ZbbNynpvShXCYXKhB2BMST6Z9O
         GuhQ==
X-Gm-Message-State: AOJu0YwbFbUHuhCczRjqVEJMMvU7Vl+glSlYCsj0VSgPmKiA4wnfueZP
	UkcCno7GdnYnWqetP2gZ3cb76A21+323FV29D4fymjNz5V8tmKJohi+Xa4+LDO/meFE=
X-Gm-Gg: ATEYQzxUWK7LtMJ3MuWCgjncpqEsc9+K0IkPPfYc4wdXH/1s2NMI9+ODxbHF/5USNjW
	SI4VlQHEO+SooZYsfUH0hlzkZafcyPPQH7Vg/e0e+tT3Pxy90vT10nXEdWpiaO0gcRD7ZgUOEuR
	HoVyXrbaZ+WnS+3k/IOmG6CRdp/yPNGYWaOqES9Vc8A7+MWKa5TXFCqrxl8F5SlGwxFPvEegBfD
	2DD4akGksLKxCANH0Pyxen1ExHwGHnfebMaC5RqwS4TKFxFyltaon9nJUSdWd0IG1zZIrDBBhUB
	E073GiwLMzRpW9oafmeUUTjZBS60hrtfWAZcBJYDb56OivZt8oD/d+0Izn+xT7Q3eGDwfWHZXf3
	vdTT5vr1juLFQMsfdgNgDn7YiC9zW6K9te9PleB+1A8FzEBZlLHlwAg7hY1OkFD4HouHrMQrj7n
	PjbYyDdPm/sLFo6Vq4Jc0+cJbYXNYzbmEidbtYn1QAZD+6ugp+f5V0
X-Received: by 2002:a05:600c:1d0e:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4854b10f2b3mr35256445e9.24.1773227052616;
        Wed, 11 Mar 2026 04:04:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/28] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Wed, 11 Mar 2026 13:03:39 +0200
Message-ID: <20260311110357.1938200-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22289

From: Niklas Cassel <cassel@kernel.org>

commit 817f989700fddefa56e5e443e7d138018ca6709d upstream.

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250625102347.1205584-10-cassel@kernel.org
[claudiu.beznea: dropped the changes for
 drivers/pci/controller/plda/pcie-starfive.c because it is not available
 in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a391e4db9401..9001851a8ad7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -24,7 +24,7 @@
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
-- 
2.43.0


