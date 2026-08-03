Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA1C55ABA
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:40 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44977.1785769114354225780
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DyE0EX/l;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495635a85d2so20557235e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769112; x=1786373912; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbTRMCJgYlmwOOT/tgJSH1qndbzqkUBcMUN15ieccA0=;
        b=DyE0EX/lv3pzhR9etzuwS8CPReikcKl5jVR3ZvMSagp4GwpAxiHCSg5iWqhErLP6Hx
         +YIL6D1uDXLTvQ6ZxOEqVfyGYjV+E+ERAUDXTkAAoEAcUvSoZMK3c98VCXItWDJBXHDo
         Pn1c4woZfkUIJtlru+ASgH6zooqYrHACwwl5nV+Uth6dUasxTjyTkg5m11xJeOOtrYmL
         OAcSsAaaQRxYF15eGLIgmgGn8mY7ldV2hsK+ViGQM5sZ0Y86d/MESdAvAqGQPv5fw1qk
         cHnUUfO1Xduh+CMUaUS3F0Pj+Ok3MBDHSY60VLuOUfJFFgAZPlMnEC6wGFQ22w/wUa1z
         of5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769112; x=1786373912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbTRMCJgYlmwOOT/tgJSH1qndbzqkUBcMUN15ieccA0=;
        b=HRcOdamg9DqC5RyJhp7Njt4AB6jp5sM99MYCFG2+HBkdhZU1WLcqsgdVSb2peb3JiS
         Tzi2vFlgaShsnfTS4gFOE4DdmOzxvrH0jUZxX3Oa49gOTg8gR6BjbCySKXSFEgNUApLU
         NShzyNmGDOlQlmLqEgNyqYK3pv3BVUTyjLEH5Nba3TQ0mk1hO5/+T0AynCh/2CaAx7t1
         st5wlMGmhOnFSPhGZX0GGLP23uif5D1agdOLHYKvMcUtIF/F8GkZ4v4ZW29KHGOeYY4e
         SzCgroEDCRRUjmGYIo66czfsD6wxtrbi3ZAJCGM97WM/8hr9HEeMroGV9IJMBjFlXKVw
         sRyw==
X-Gm-Message-State: AOJu0YxbBVRCrQiQ7GgcUPXE3Jl8OKaFeATd2xIo4GBnfwUHRMOGJvv6
	TW1uRpJtzNBrPnS9vGqhUQjgXwXXuH+eMp2LLfhuAJLNedGfrhwkWkCyqkoJCw==
X-Gm-Gg: AR+sD11CjwE06ix7JXgYkZmvFcyLZ36k6RbvnhcDmqTz1oBORZBvhd4SLkK26FySCLY
	RCsJrr9W3jnCE1WblStkuJEpwLwZvGYMltWCuuDi3FGrksjCZada2l+n7xkVHV6MyN09Ci2SfHa
	8SViK41FKiv5RjyM3WYBIeRomzvsafXn8Vs3LMcPVNV5IjjnbjZ+uJd3FxbU+eNlbfYmIijtvwh
	BpAGzcF3tpgs90PZPjgxrB+ZD8i21g3R3kFCVCNHC29ZLip7DjExMDlq597BAXOkObIN0ehD+Zo
	PXOnrzLBs0rvvOynCezibfSjp2cQ5EKIHWGTG2PvRnNKlCX9QZbfBdqIKxgJZ6+qq5iNukdXKco
	R7G3WdGPPshQca10SDn/R2GD9S7pK196rDAJRSnFtoXtgBqOkvIx8e5lJVD4ynhzgVwjDFgx18O
	tgrGc/3w7/vtkbLZZZlfDcTUKTCZjHR4s3s/AdsjERVA5ijF5+E0gJrD4Qb8N7gnnlpvbh
X-Received: by 2002:a05:600c:354a:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-4980c67d71emr211759985e9.19.1785769112573;
        Mon, 03 Aug 2026 07:58:32 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/7] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G3L SoC
Date: Mon,  3 Aug 2026 15:58:18 +0100
Message-ID: <20260803145831.91924-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23855

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fbb143e4a6efa4a175e856fc898754b06cb13c4f ]

Document RZ/G3L SSIF-2 bindings. The RZ/G3L SSIF-2 IP is identical to one
found on the RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260304072000.6787-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index e4cdbf2202b9..1394f78281fc 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -20,6 +20,7 @@ properties:
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
           - renesas,r9a08g045-ssi  # RZ/G3S
+          - renesas,r9a08g046-ssi  # RZ/G3L
       - const: renesas,rz-ssi
 
   reg:
-- 
2.43.0


