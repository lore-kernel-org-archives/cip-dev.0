Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D73F3C27C
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:25:57 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15518.1773066352969640907
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jNQJz+Y7;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b78b638eso8921459f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066351; x=1773671151; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kyIJ168GawWjOmjwlHIz8e1RjBCrRQZP0ABLQ3VY4s=;
        b=jNQJz+Y7xzmkKDn02tPMs6q2nqsIsliU3qTglE1DsNQhIoMMxudQzyd7yVay5SrIVi
         P/uS4mEHrkmxEz8Cx0Jm1k27gpsmprsmONgHqU/DjzrTgA9LAhaY4J8JuqHyQx0eYPyO
         FnNo4JKcsx3qBPlDdNvze5mJmunlo+uY0z75Y1sn6QKR9BxLaeRBHFufUADhvZdNHR9v
         cqK2Bc+S4K5K+xIeKUKopAvc5m88JcGc3WQCFNaIqjHeF/0VGyDN8ArPjI447Htm+DXM
         eLKo4wRSY2I+yBvaGN35oPeRt9M7lvuosTCXLO8i0rBZ2FFQ1cHMuSfI7Ep+FbgKh+A0
         DJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066351; x=1773671151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kyIJ168GawWjOmjwlHIz8e1RjBCrRQZP0ABLQ3VY4s=;
        b=InqBsDvEVq4bqalcn00GyZUGqnEc45McFeeB9DBy5ZQf26ETBUPLarC5exPQOj92LD
         e7x8z1sp+7QybiKIt4Zp0NdtNSYw6aMpPRztGmXnu16G19tSHopixDsr/dOhrMu44dp3
         Mh+7pEmPyTavzAJda02oz4VUEeyoy9mbvDUo+LmLg+ylDw87IqleQy6UXXvWS1yl4g7Z
         2IgvzFScnz+klotqlOi82puTvzzXO1NiXWU9EE8f3xl73Wymi+App25JE1WDUfAkEovW
         LIUsk9WopuisdSiD8Wl+5cejAcRtY4edqUL7C9mjWSpnLm1M8f30YN0Q3mLA+fayD6KN
         Ru4A==
X-Gm-Message-State: AOJu0Yw6nNr61ozxxilkKOBiQQaiKjIRnMbut4dhGuQYYkHYkdffAxY4
	AQFRgXPqXnzkU+15x1LQpgmHsW1aoJkWtpzqVsYSye0uYlAhONesjFgulz+1ow==
X-Gm-Gg: ATEYQzwQ/KxguSJ1Ri6Ozo+tNOUObe84CmfpxjOF9wCUgCT5tKIIU3tNBNZ1k0SSWpQ
	M1RT6rag3JFYP3sJstmCD6wEneORMLia6BYYzjq7+3Av1Tb43gC9qO34oaQlD/XHqvDGjNYd3i6
	tOK8TC7o1lsrAsdtweQbovj5e0sgQK1Ip4+jIRox0GnSSgwTsQmV9GLcRsQ0v739iNCnBmBNjf4
	po5eLJ3hWDv5gqX2j73HuoV+2n6531NthxYRH785KHSffggdMvmERr/qx8jJr8GZ+mU0hi7c+ny
	7VA9/MR7/9+JlhE2hM5m6elmmESEbYuEFSQWy9+Fa9aIbfpDxfiCNmZd14P1ltFX90/1JFY+WM7
	2iZAjbYq7kj0yzmzlHMUHOI0VhJGkZEAGLbvjbq6UPvLU1W0ec2EMNFa3Hv8WOJUaie/IHyvUac
	RBTreNxWespWJ+tQqOi1XWfahX54tXY8c=
X-Received: by 2002:a05:6000:2312:b0:439:b1c3:84bc with SMTP id ffacd0b85a97d-439da6542ecmr20171831f8f.7.1773066351051;
        Mon, 09 Mar 2026 07:25:51 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/29] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
Date: Mon,  9 Mar 2026 14:25:01 +0000
Message-ID: <20260309142549.987737-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22169

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


