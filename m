Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB7DC44509
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:50 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6790.1784024320333018915
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 03:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FDujbsYv;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47df6a5202bso2469687f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024318; x=1784629118; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6r6wheefRe/qC8ZQzgwFmzQHy1aKvKOQuCBo3Bi2Ko=;
        b=FDujbsYvMSia9q4mPC40LD+uHsZ2e7uZI/pAOWluZbslC5k22gxeLt67XTVQa4eKjG
         KqPaQVp8EQ+Iq1WkQeG1l3cnQN9828Fq69wwdXYHduvbCGZ6cmj7oj0JG8U0nHzvLf8f
         ZjbtjWVmdxGUA2J0R5gpuelj7uPDZgNYMIgmonLJZUcxrrrVquzwIDuwA9vWOcvn1E8o
         eOUgPZ8E+tjirPlMqT33Ak3Cks12fT+oUq0Jmp6RHFs4mBCST7RiG0a/xRyna2QGfAX2
         Z71tcAVQB1YyZ9q7oUOEEAvYzDsWJCBhNyqfXLk+e+4uip5hl7uHOXaUF3KB/X2xrU5E
         JAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024318; x=1784629118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6r6wheefRe/qC8ZQzgwFmzQHy1aKvKOQuCBo3Bi2Ko=;
        b=OoVKo2ftaBcDlWecpjEx1iDr+v4sWruuXQNKS+GYvDRLMja+Nkrgy25i6ukMvHK/KR
         2TMFcxBa38e+eb6PdZFN3ehMR9rBqhOEYPo4rDzJ6p1VyTRrvalb2r4fumijDD4qQROQ
         +sGFj41CM9oHzjqQY+cWsvN043AbOB+scUDSYFZKkMf9+hfk84V4nioKa/DoUf/D3lnq
         ePw4rOumsQKiM7xQLQJfCbW8Jbueb2t4Hj2x33hDzfs6aabyPHDOVJsw8gpKYWv1QDp8
         Dty2ZWZBOYqVz7CS6ucVEakMqRCc46jVlHH6UxkdSQ0Hyk6EhHP9LjK2GWNxlOquv5E6
         87dw==
X-Gm-Message-State: AOJu0Yzzz1IbdBPaD10uBmt94SlLGTmqI1fnuMV4fbt2VVSdnuzv55HO
	DJppmUE2WCZGzkNscL+gDLCmkgNLE+9ziSB+MXRC5YtaAURAWjlgGHXSKHQRrQrX
X-Gm-Gg: AfdE7cl5zusxDrGUbaUutNdajOdHrp+WEsZGgN2l5jrOPvdw1ohWgsIRecadMpKousB
	sP8nzFH3TxdbkJrCW810SsUxfrr0zkl2D6iw1v0uTQGRh4EhdkNUwZ5fmG87Xi5acAxlQYjANsb
	S3scl/oBiky6JAqHlZrKHTMkipVDCqhrDnkgXILca8NmDsCaePAtGw6YXHtJ94FU01S4ZtvPvzE
	IEf1Qq94awNraVdoWj/ozAX3gOhN1S6JrcmIxaV80Re2ArByzBMbyBztpEoMEYkjWSvz8KNp+L3
	sGcDbujFOENIiVgFUeFGhXtQcc/nDY+fZmXNfK3vZwe7bBjzgpAInXtMjP95GtI3XtDjKs00Jqk
	IZmIz2qQj51si74mRk2icxeTfoNYPVd10SGhodsfZfBmy+VLIIEuWJ4mZw06Ck+dTuR9tShaPZM
	WZ3SuXQKNRQNxmgkOE4rlxQDBHKwIlELGBeMFy
X-Received: by 2002:a05:600c:a42:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-493f883c8ffmr134616355e9.36.1784024318238;
        Tue, 14 Jul 2026 03:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6218:8bce:b637:b72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2e8f07sm59103145e9.7.2026.07.14.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:18:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/3] arm64: dts: renesas: Add max-frequency to SDHI nodes
Date: Tue, 14 Jul 2026 11:18:29 +0100
Message-ID: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 10:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23578

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

This patch series aims to add the max-frequency property set to
133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
the RZ/G2{L,LC,UL}/RZ/V2L device tree.

This change results in approximately 33% performance improvement as
it sets the SD clk to 100 MHz instead of the max 133 MHz.

All the patches in this series are cherry-picked from mainline.

Biju Das (3):
  arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes
  arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
  arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.43.0


