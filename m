Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D497C3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.10265.1746783160437775470
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eTXMCZNd;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbf29d0ff1so2958352a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783159; x=1747387959; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47JmxKekL9PFhXUcgae9Qem3DhekL9CoS6BkJZlZzZw=;
        b=eTXMCZNd0xpAeBCmpsgCj7oqYmw8cC3I5RdnQrbyralAiS7F8hwOU9OMEujnPGqNXI
         Td78mg9kOHXomGOgln8carDCdBz8u4UznNs7zc9a326c4/41NlweRPCxLf/8XakWkeFV
         cs7hDFwtuKXHkeV+NZR32x04DUOiHrK/VgFq5sF68HNDAWHe6VvNRotlP8T90m76XGQg
         arCZ7l59EVof2Zz0mLymIhYXBmvXq8WQViq7XNfMI7SpiZLc7jYtq2MtHRbm82XZtDPO
         NsIEV4hWME51Ve33KAWAbastxRKWP0MlZE2H6i+xRLkxafUNYNLBgL1BZ1zTgha4R1aA
         zyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783159; x=1747387959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47JmxKekL9PFhXUcgae9Qem3DhekL9CoS6BkJZlZzZw=;
        b=F33yeObAS7Rit4EYIDANBfa/lNvuGcE6VSnLWp71eecIK9d9MxI1OL2qGiMaOziF1V
         b2aSZCVGRvlmJGZKnjJSbfqO3MyorxfIjnF6n17DQ4npT2yvL0WtH+afVqa3qGv1f4ea
         6FueZsgD2O3h+LSLs1eslKD7v9em6kqElQC5cAwjzJlMhT2rMiUsftLbGW9CRHQwy0mh
         kyhET+Hv4MY9xOPA+lbufcDfHsLZnXzG2qb+tj4tWWCRuB18Y034dLrowBq/D7bwu0Yd
         xLUwcxUQUXAo7KIpgj8LrpthKh7a+hfS2UyiwpHiZNm/S5Ptzn8PFNjBfhjoCkgnPphe
         OR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVrgIZsSZM7Hbuw6KQIWLx11znsSFzwaYaVXXHFriNQMzhWj5fecZlH6vJ8kMc9o2VVbqjDqB1T@lists.cip-project.org
X-Gm-Message-State: AOJu0YxH2ZHsLNNfvc2LJiEikOKmcgiL30mbsG+mBSwescqIn110bgJn
	NG6jnC9aHP2zKnGma9QjO4qbGtLHzaEKyV9VmksU+cM/CiMqyL1JKTptezpr6Ek=
X-Gm-Gg: ASbGncu6uOxVDLQxlD5YN3z+HDHEwDs/eY4Uml0I7y0ICeBF7xYqvbD3+qrjalawAjg
	qtyMuBaUMR72hcAhgLOCPrHbzzY9W+71cURt63RbCdJotDAx0KXtrNjLut5piQKZDGtpRyJuJlz
	ARyOHuBd6oUZP/KCfFheITpttnyfaxI9qKAudtD2DzBmWX0K1WhsHajQhiQuzyU/hn+c4Cnhr9r
	tpEX6qT3Y3IT+bZmKCZsEqQaCJG6xgds6jLguiJk6cdnh1SYDe8rpJFvsvBBY5zYx0wnag8j1fZ
	Xq/tKoioX2RGx1AH15yyV19nccXoGe6mGjZ3+typFo/PPxPIGAppJnk+IGFf3KcgxUrhJA==
X-Google-Smtp-Source: AGHT+IFxVuI4QdKl+Fz0ND02gS3j9N6EpoAw0mlQCC4Ri6QoaTAXnfrbOFvt7mJ0l7tAS5T7L9OPAw==
X-Received: by 2002:a05:6402:234f:b0:5f9:3174:dcbf with SMTP id 4fb4d7f45d1cf-5fca081b4f6mr2108954a12.32.1746783158707;
        Fri, 09 May 2025 02:32:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 22/29] ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
Date: Fri,  9 May 2025 12:31:56 +0300
Message-ID: <20250509093203.4014750-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18809

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c28dac5d3a6e87615d4c8e50f574c320172a3d55 upstream.

Remove the DMA description, as it duplicates content from
../dma/renesas,rz-dma.yaml. Additionally, remove the MID/RID examples
mentioned in the dropped description (this information is already
documented in the hardware manual).

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-19-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml         | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index f4610eaed1e1..5b42eec864f8 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -57,24 +57,6 @@ properties:
   dmas:
     minItems: 1
     maxItems: 2
-    description:
-      The first cell represents a phandle to dmac.
-      The second cell specifies the encoded MID/RID values of the SSI port
-      connected to the DMA client and the slave channel configuration
-      parameters.
-      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
-                    MID/RID value of SSI rx0 = 0x256
-                    MID/RID value of SSI tx0 = 0x255
-                    MID/RID value of SSI rx1 = 0x25a
-                    MID/RID value of SSI tx1 = 0x259
-                    MID/RID value of SSI rt2 = 0x25f
-                    MID/RID value of SSI rx3 = 0x262
-                    MID/RID value of SSI tx3 = 0x261
-      bit[10]     - HIEN = 1, Detects a request in response to the rising edge
-                    of the signal
-      bit[11]     - LVL = 0, Detects based on the edge
-      bits[12:14] - AM = 2, Bus cycle mode
-      bit[15]     - TM = 0, Single transfer mode
 
   dma-names:
     oneOf:
-- 
2.43.0


