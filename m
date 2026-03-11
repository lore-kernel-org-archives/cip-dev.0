Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE6104BEBF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:06 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17641.1773223501689604808
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bZqh4DoW;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439baf33150so692793f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223500; x=1773828300; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kyIJ168GawWjOmjwlHIz8e1RjBCrRQZP0ABLQ3VY4s=;
        b=bZqh4DoWpmyBrJ8qUWYRMCSyFE4nSBiajLIeXAu9L0VLraYPzQ1oAmgoAdUzcLVc/N
         W81ppMQhwMw7eTwr0A7OwK9OATTQ9WUqdcVhy+LjxX0RInwPP/41etygp3K0N8W7oQqR
         8p6jAqCdPEb2yxvMBI7+DRfqtpreJTqFwrVpSN8eNzoAvGTZiK1FsqtU2Hf0dew2/EyY
         pZpxTDimwfKAAbxGAb6sCKFQW1IXHWxFM3eYXx0cm5XXHjoYVq/RQi1JJ6hOi6o4WEEA
         bzBE3PmvM74/hZTN/m2bBIl8D766lGQ59dRqHUzU9kFfRGLbbnPdFHc9t8oflNV9QaXb
         A26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223500; x=1773828300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kyIJ168GawWjOmjwlHIz8e1RjBCrRQZP0ABLQ3VY4s=;
        b=Md1VLhVf8AdPQWJk9wQ37WojOeOQXN77O5lwuIxMdCc6KHSIfWsLMUvimL7OnDUt4R
         h9hZxKyaCPig9jRtZi+8j5fXE0/ZUgcxZZh2RCTVCmBJv4VRmsPrO+IZFtl4K5DW5Ui0
         o+JnO7hPonUcEzRPiD2YcPJKcN7DPfX0UjYA1JxD913ihb2GIJjNMqgD81U4r3mySdGE
         TxkG2sP7/N39RzCusBl7FlYPGO2n9OwEohK/M5s2hztM527/dhCmnOQzGZs1k1UFojdp
         RMbLWJY+53Wx2ygcNTMUyyAzUkk9rVw26euswuc4jMmJYdFgLmJUZ6U8n19WGjqpPjoK
         bJwg==
X-Gm-Message-State: AOJu0YzyuDBC1hSo+Nh704KuG45/brLvGy9y8iS/bhD0/olqzuDRPRyM
	+20Jc8T9U6RsyxCxLl3PpFvDXKX1g6+x3Hg8lLZAKdZq5wPHibWs/m3nNHcVYA==
X-Gm-Gg: ATEYQzzU3oavobyLCpJZMyAUBy/5XN47j52XEWLqZk1PxJj+3J6RJtrmXGIWsWz7KJX
	8S9AK13V8nBM8TEKDHQeqZ2l3PQHFRbddn2GS5eDP+NBoMIemQ3nMSrlddKb/2drWQs2NlvC8zU
	TuEC71R9uAoTTVxjfIK3fHBCklTfWneGKQvlszfvd/w5FlIxLlvGlTeeVAd+P5H9Parr6sbyWwa
	xz0m9sHQVBD7dkmiSfS40Xo+l10LkKYiEud84y029O9nxqpjF9znQAoBZkP1VqcLtUuzojYpiCn
	D6AGGe1dQG6hv33ZGaOuT6YM6hAdECNL79cayE3VIyacP7JpjFo8xN5IfdNg39DGpAbzXUJ3irt
	sjvPsJGV12hWx6QRtoAvmLVneGDN44bMw7IkcmV4nuODOSk8YKfSNCNAUubPs+9UdxgnvP4gpNp
	YXqDRRNmSB5L5pXoHwbZgc/bmUL79LyRuChv5QWNsOZQ==
X-Received: by 2002:a5d:5f93:0:b0:439:a95b:3c47 with SMTP id ffacd0b85a97d-439eff1be54mr12239657f8f.10.1773223499587;
        Wed, 11 Mar 2026 03:04:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:04:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 01/27] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
Date: Wed, 11 Mar 2026 10:04:20 +0000
Message-ID: <20260311100458.162447-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22247

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a6cdfd69ad38997108b862f9aafc547891506701 ]

Drop "uart-has-rtscts: false" from binding as the IP supports hardware
flow control on all SoCs.

Cc: stable@kernel.org
Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114101350.106699-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index f50d8e02f476..6b1f827a335b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -54,8 +54,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  uart-has-rtscts: false
-
 required:
   - compatible
   - reg
-- 
2.43.0


