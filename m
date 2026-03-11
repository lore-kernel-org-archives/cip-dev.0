Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A79105D279
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18647.1773227055365646618
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Fs6sQtpe;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852ff06541so42607785e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227054; x=1773831854; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeyRKdLpsNyPORaxsCZGzaoAxbTFaxXLRUGR4V1rhYA=;
        b=Fs6sQtpehsmwGoilBRSnvjB7HlAyLyaOcSI6smbryC4EsYQAa/PcN2d/ZXlurAN6MZ
         LqhqAy4XsHCnpYxK/nWYnyze0Q7jGwK94RdQ3yxeblqItAVfXkZ3b1XMaRu0DdSEkIYu
         owvcjiUiGxCKDMsSrIsUsY+dHMDJxgR8qQlfGobOd6K0exre37uDMwg3+Vv9lBlSsNXv
         l6cYKEPVLygMzY3LZG5zU4U+Lh5jCJf7/ivfQomXUrE8AWxBzbYrzrECK0ollAzQrKtF
         YkZS2Bsx5hYW3GlSwCKgghR2jr6HVXJ+p9ECHv+GqTX4WO3y+XX6IL9p9VzjqPPb7d7f
         M+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227054; x=1773831854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YeyRKdLpsNyPORaxsCZGzaoAxbTFaxXLRUGR4V1rhYA=;
        b=C4L07niHxMW20HeqVlxxFt3DU9nBT1LTqpvRMO/tRee+0B+jVVgNc5C33OlLcmvavY
         bYZlz3F5tvhlmIPynDjxc/gqBUye6cse7YlxwowvflIBoTsPTW72PV88VTP+3vuMdlsl
         buMfKXQML5dDd6yF0exSFFmRrVLunABBfSfzV0ZO759iZX+7tNkfBnXu8FT9R1znM74K
         D5lL0czdOOmcDnTYbJNv/CTL61Gz+VKIfGAu19swAounJlXSHCcx79F87VJmJdxIFlfw
         yTiURZgAim+ffqsy3TygfqGEZb74KQ7g0+4D5MBukX/zBxGaBbmnNMIkBEx7iMtVq0ZA
         7d5w==
X-Gm-Message-State: AOJu0YxsmhZiRrwP0RKT684L2Pz4vli2agqKhKUrdf+xlDTQsCxk7NJ9
	22jJQ9tUgRGqLSfl7gUro4hwGoE/mY9RzpS1f/MrQ0r5WGZg1W96XaoU0K3Bqud7inA=
X-Gm-Gg: ATEYQzyjNHvNMA7CHwYD5F5A6cIcKxIAw8x6NwKCMqSYSzJ5TL85h5EgULQsInFXEZN
	yFSb6FtcqpkQ3/aYktMA33xKjzvcF59Xi9y4REdEr2UB0osG3LWXbwUEWezTr9QHJos0FVzLItB
	OLxQ3ahYrSbkpNYNCSjCyKAo+nCd8kjHMRmL7RmQ+g1UQmHY5FC46ePxu1klxQP+1gE90swdh6G
	EKOxPSkXDPWc7o34huUOR7t3WLbODrkdVWGh33gL6nlMDf8fM+LJtpeysNLSP4hVGdxMiSsJtHK
	FHAti2erxkYdy2JNF6NaMo+4r0FB7sJCX52NqeVGzvZDH06AYCS4uSWKyudY55Kzx9/tDrq8cT7
	sP/QqcQNUuZw55IAaGbOiPtysLZgJEnUqGkXlw+JvM1fFFFEnU2dYXmm8frJgqjIo2TKU4v3zKR
	UUbKAyaRCcyA/e5LGazatUuwLlm9n+kNq+3v3Wq1R2ghFHFZ0fhi79
X-Received: by 2002:a05:600c:3b16:b0:485:4533:9c47 with SMTP id 5b1f17b1804b1-4854b100c42mr33617095e9.22.1773227053653;
        Wed, 11 Mar 2026 04:04:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/28] PCI: Move link up wait time and max retries macros to pci.h
Date: Wed, 11 Mar 2026 13:03:40 +0200
Message-ID: <20260311110357.1938200-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22290

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
[claudiu.beznea:
 - dropped changes to pcie-designware as the CIP v5.10 uses usleep_range()
   while the original commit uses msleep()
 - fixed conflict in pci.h by keeping only the PCIE_LINK_WAIT_MAX_RETRIES
   and PCIE_LINK_WAIT_SLEEP_MS macros]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9001851a8ad7..0ddc1e37a796 100644
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


