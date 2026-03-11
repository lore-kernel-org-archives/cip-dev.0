Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4101061207
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:41 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18348.1773227199185106283
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qgoF6rsR;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439cb5af25bso4173736f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227197; x=1773831997; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDKfg2ZqrCQ65fEHYrZuZ8eQ9cZPKzazDOIRx4OSMt0=;
        b=qgoF6rsRH2nu9cGheSY/TwmjPu4dcaSP+Tbg2486zSTY5g3IV34LNcTqHTAGfbPHXC
         9O++nZUohz2GkBs6UdUoeMbW2LXCE0LVw+7c+xrqoNx4nC21vopDPO3pUjWjWWoTUeTd
         098+wxH3RhMx0R3Zl439ft8XIj4SbLomFw31Pf1Ta/NCu7IA2iBNPoZSDHQORBIcnPj5
         ASnKhE9YqM1i5IUztvOFB6Nzq9TpbkERAqMUv7B+966X3QN3cIvNSWWFAlWZQzaQCEiP
         oymEpBjgf36vVBAuSCAQH1yFSzyNspRSucK6d151+adM2lToCpMCG5dDBdGUmYAZtR7h
         /yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227197; x=1773831997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDKfg2ZqrCQ65fEHYrZuZ8eQ9cZPKzazDOIRx4OSMt0=;
        b=rq1HRVBFR91Y2RkK1scUiRxY4BwNPzlmYZO6gl8bsqfcZnKGsKurt4kcfzp4iDehM1
         JGL+AK0mn/zlsugA/XJ9C04pN4WWwKs04zUiEn4lyT2MqPaAvXsve3AodqJbkh2xVdmb
         UTuACwZg7yEIiudXtuhgiB2jNvyWLxK9+2S7UqkmalgkFuzty8cigE05HWP8dpQKvE9a
         dUaF2IZvcKkYqct/egVAjquOfQ1ruaIa0dnaJ21CARD+Fwy8vh/P3HQnSq3e79DqpkMg
         8VfjVSvvRuANzYQUF/B45fTwaFEN+rsSYZOVtP6tbZDuFmdL8ywryf7YoE+YL5lTqisQ
         DVXw==
X-Gm-Message-State: AOJu0YyTXm3xXOr+Bi5KSlGbdDWMtfJEc6N7oR6IB2qYPYX9zwS+KbEf
	SqlzAMvP0dIzKkI2FkAhhRdnvTK8F5cTVUgS6v8wlVaH59BPTVvNJcJkY1sHDHaxYQfhpjy2EFj
	uZXCZ
X-Gm-Gg: ATEYQzzeNHKGh7kDgQH1mZvGEAUkACg9L+TpEN9vNdjMqyhKQD/3jFIC7tzG0xGt/un
	0aH92H2OA39T0S++9NLm33YvnMFN606DzHfw3pHleOy/kYS6Qj64REp3qVgbjm8d2X98/nCQLaG
	DeLVkIUEXMfrndpCq1HfQHwgIcX/VfvNfFOH1WgPPlhPC4R0QAkJzlIDDs/vjYS+mlZaa9yEmEZ
	Jg4+HCYeHrC53+cbtZ22qbE829xv7gwuvztauo67B2A6JmoT9gaJOW3f6Fcaa7iTX/dyNBM081o
	83LlQ1z1UvgTB73+o41RHoUn2dy+XHS2SPA11VRnY/6k8KKED0H56n1SdJf4Shtd1xSOvqBaivb
	GEKOfGbQqoa9ja6lrNaapbNsdYuoWKV6F4W//s8FPprMPjHohV/5xHOxP/7U/One9qgsulyCuay
	sjEGIhosSG0QRiWGZ/L6iVksM8MkWuPKaPqlpUfbFbJ5+zSO+3gwPK
X-Received: by 2002:a05:6000:2889:b0:439:b60a:b3fd with SMTP id ffacd0b85a97d-439f842ae67mr3708589f8f.37.1773227197545;
        Wed, 11 Mar 2026 04:06:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 02/13] PCI: Move link up wait time and max retries macros to pci.h
Date: Wed, 11 Mar 2026 13:06:22 +0200
Message-ID: <20260311110633.1938579-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22328

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
---
 drivers/pci/controller/dwc/pcie-designware.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h | 4 ----
 drivers/pci/pci.h                            | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f7d10cb788e0..6a6cd1d9cb86 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -643,14 +643,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	int retries;
 
 	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (dw_pcie_link_up(pci))
 			break;
 
-		msleep(LINK_WAIT_SLEEP_MS);
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
 	}
 
-	if (retries >= LINK_WAIT_MAX_RETRIES) {
+	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0fad7751490f..61d7d8d13f36 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,10 +60,6 @@
 #define dw_pcie_cap_set(_pci, _cap) \
 	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_SLEEP_MS		90
-
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c951f861a69b..213dfd22713f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -59,6 +59,10 @@
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
+/* Parameters for the waiting for link up routine */
+#define PCIE_LINK_WAIT_MAX_RETRIES	10
+#define PCIE_LINK_WAIT_SLEEP_MS		90
+
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
 #define PCIE_MSG_TYPE_R_ADDR	1
-- 
2.43.0


