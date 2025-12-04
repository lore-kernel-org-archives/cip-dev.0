Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EDD29FA3
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50562.1764872182720001118
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=htAlSMuR;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso6847565e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872181; x=1765476981; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=htAlSMuRpU1pOBsafZ1UFt8d12+MFAF2CcgEZbZwUAOKDp4dRrA+yda/0VRNTvqqXl
         Q6Oq/B7N364wYotzMVBcasF/NRvAUCsjuwtU88WksyOhQyhNRkR/hex/vyj4SbLAXljL
         2bNkXXPxbJubEJ79z0bC4kJKXLvbvoOHmNUrabrrgK3+mRQLztsXfH4i4XTKY1dxCNu4
         NCXvnjHprbQZsXMCNVorRwtIM6HzZMLRvVuiliSIoa+ZZ7jQkWCsOJD2O6KdItWilr6v
         n2qjiaDrf13SZGHY3/3gxiOCqOh0ViWX85plmQ6t4ha1f1Y5TqZFzhrnG/NRolJXmwUj
         Szpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872181; x=1765476981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=hQOKcEetUyx2s8UVBh4SKimQdzEsVLl0F06kH/QCkWYsvGvXGymIi11u8lnzrtBcGy
         FrhRjqhOLrh9jRhjB43Tap8o41NGmenBThFL/D+bQw8YJ4psmouNBDzpSjSAUgrSTGSf
         qumiDdaBbZGXfx4Md7C4ALBsVMzYxe1ndfX3VEf8AEX+zZA4C7vjUN0nW0Dv8He1aG9a
         GY6DZG3I7ts1uK3v6WEGNhVOwO0YHTwy6B/rqSx/JwFgFKCwKPKHYVp57h5tLCBTBBi/
         DuSB4I+geNPHThqCMs8Zb3w19/9fvRiD984d6JLgc0PU3r4v6aLlK46fKEwm9F8OX2M+
         jqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWBAzbgZMTh0UBgRh9CSWlPtsNoZ+fztZ5o29clPPK0Uxha09o5H1VSaxiH+qUxwt/NJToUgoqu@lists.cip-project.org
X-Gm-Message-State: AOJu0YwTXouxAPZKKPKowJ4Z9rKcTvwaYr+zW+siAW3KJyjiai6KL0N+
	N0I3AW9vZDNjMJVuIQBzBFvu3f7ghi0ZtMRTB2zc3/TMEDwYhxxquaEC48KWWCn9d+A=
X-Gm-Gg: ASbGncsTDU3x/MpqWTQaPasmKB/dF+WbCAW6CMMLDpQdpmfDMyp0bYpnXed/Asl/opy
	pDvbw6jJmleMTPXn32+HRHUd+jifKz78RFfFBelGKCYFgiSUCkVUJE6/vr9+1lNacGyYdwP8I4Z
	QI3saUXcd4Zt/Ny+kEo0yOzizqi9knvOb90IIQm+Hfi5vnrKbWSEQayA9WmatHWlXgKMDWDFW+F
	Tqy0UuSJPvqswy/hJv3nTi81zIuPFEMBsengumusvj+ynceht0b9qg1A7/wh99hwRUVSzgrZvFt
	PVqfnjwpv6ckdIhKkHH6JHzhoC8GriUNoo4LVaSy8eRRrTODDoKUB62f6coRp2JhAB0zUsMRVKv
	YS9QP6HlMF0v1AckEpPmgN51QDTSka7hucA/twfiOBnrvmPvbcYMatiFMPU7OffR1PB/cIusWl1
	DIPRh0r33lYYyrc5GEIBcpQ0s5PsfzfZfAcKo29JHp
X-Google-Smtp-Source: AGHT+IE5hAetMLmKcgrRUWXfn0NDcxNn1SgQu1sK315mVMNAsRIYmfXvlB24KP4gZ17tgEPgrBpI2Q==
X-Received: by 2002:a05:600c:5254:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4792aee37famr61633005e9.9.1764872181139;
        Thu, 04 Dec 2025 10:16:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 15/19] Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S"
Date: Thu,  4 Dec 2025 20:15:56 +0200
Message-ID: <20251204181600.689203-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20901

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 705d9f8f180851c60e6a344881661c3d44b92313 upstream.

This reverts commit f33dca9ed6f41c8acf2c17c402738deddb7d7c28.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain IDs.
Currently, there are no device tree users for #power-domain-cell = <1>.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/clock/renesas,rzg2l-cpg.yaml      | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 0440f23da059..8c18616e5c4d 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -57,8 +57,7 @@ properties:
       can be power-managed through Module Standby should refer to the CPG device
       node in their "power-domains" property, as documented by the generic PM
       Domain bindings in Documentation/devicetree/bindings/power/power-domain.yaml.
-      The power domain specifiers defined in <dt-bindings/clock/r9a0*-cpg.h> could
-      be used to reference individual CPG power domains.
+    const: 0
 
   '#reset-cells':
     description:
@@ -77,21 +76,6 @@ required:
 
 additionalProperties: false
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: renesas,r9a08g045-cpg
-    then:
-      properties:
-        '#power-domain-cells':
-          const: 1
-    else:
-      properties:
-        '#power-domain-cells':
-          const: 0
-
 examples:
   - |
     cpg: clock-controller@11010000 {
-- 
2.43.0


