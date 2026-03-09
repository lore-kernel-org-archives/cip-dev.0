Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0022EF36FC
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:20 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9055.1773042676940396539
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EAqYmpgo;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso101284295e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042674; x=1773647474; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAEUzOhEwow1SdjYw+P6sCBk4pZCMzXo47epXM3bH6Y=;
        b=EAqYmpgo/Nye+MLZGd7E8AOC71fb5BHrdvB+URjylvyUHZXmWzGp+os3tOJj76eUT7
         oLQi1TF4FTO5WrFelhmEIiOHXIGdIgds4T/nrB55NUR+SUuYW7EcpVh/EC3BOFLKsxza
         Bywq8nYwEIvZ1WpEw2yzgo+q3tx2swr8P5tIKTsIAnbfIvyxZTVhYhdqp31mIRq6oxE4
         icw/rZo8Q1xgL4kCsDFlDQy8B3HjdYm7jzZos5GwuXcJVH4lnxAX5d5gOzEn+aqsDOlv
         YJOFbolkzgcxIKcDjghd3bIGxNC5jLg9LIumLJ2LdukYqYIwZiwsDDrxU5qXfw9EmqgI
         FcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042674; x=1773647474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAEUzOhEwow1SdjYw+P6sCBk4pZCMzXo47epXM3bH6Y=;
        b=slI8J5biGzu+j0YUze2IdyJSNAMgRKkcR7+fKb+5INPIPTHcGx4JgGsFrGgY6dMVJ+
         BGOLWNz4h4O75dwp/rv3OEv/K31YIYpcE0VRBBqeGnqS+1x/800Y+AG1lZkz3Fufedzb
         FInKxWlv47fxqcl21seYSk/+gqYbUpWFydoxLJlKUJJr6weJXVhS0tx+BAEaIywJYPF0
         HQsk0dlmnNbbUgpWK2B7LOPdgp7YLGW/taIicnPeWFYWF+llfSrPngQViaYqcYbMUbUG
         Dqr9OZmjx+ZKyE969nh7O0eDkJpvGJO8kRsLkuA7Pe2UO2layCF5s4wT+EelL/tMjylM
         Gc3w==
X-Gm-Message-State: AOJu0YxjscV5kZfVuSR6oWhBX7C4TqDefxtsbdNAYnfGqAkiHHoRAVjz
	LIw0bIUT+AX0V3RXAktiyjuXE0k+2fPuKwtlyJUZCsbBE9r7Xyy55qOmJfmjqw==
X-Gm-Gg: ATEYQzxNco4+mPIkkkzI9aumfNb04o9ojlfbHgOy6DDqTJ58RKSxEcbTW77YK7Aaf/s
	AZwv+xAtSccuel+Qzhbr/mTuNDKjUqceatJv9fgCJ757D/1Vm0ipheNpqGHEI9GN/bDDQ0pKFF5
	LNFhyh0zkJ/mo8sQzLEQfgUVKQTXkn/xVmRzHh9XmN08SfT/K1ylTedEr/d1+75NEY4WlRpfUs9
	3xxCAmUO1IXvqduGtrKAwshNUvJTZnhSLJOvXf6ebzEembzYTHOy9fcVymT8kyrkSpRmHZoZAUo
	ws+dCO3imBT6aU0Gxi+3VCQdYZVFq5JM2PgHTOK1rx8nO6RhgLFERy+pEI6NIQ3m8YGLkLgQqlE
	QsxrUQGn1yLXI+oDU6TZ18jWBjxnUBteku+cGR1WJmLe8C/fmIrOxrJKcup/drYgfBZX1jj6Qb+
	oe+LT51ZciZrGBlUi1WgWwyMzhLWDkGMSalx7pvRczl3NxJBA9
X-Received: by 2002:a05:600c:1e2a:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4852695d16fmr167680325e9.24.1773042674301;
        Mon, 09 Mar 2026 00:51:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/6] Add suspend/resume support for RZ/G3E ICU
Date: Mon,  9 Mar 2026 07:51:02 +0000
Message-ID: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22148

From: Biju Das <biju.das.jz@bp.renesas.com>

Add suspend/resume support for RZ/G3E ICU(interrupt controller unit). Also
add support for CAN FD-Only mode.

Biju Das (4):
  irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
  irqchip/renesas-rzv2h: Add suspend/resume support
  dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only
    property
  can: rcar_canfd: Add support for FD-Only mode

Geert Uytterhoeven (1):
  irqchip/renesas-rzv2h: Remove unneeded includes

Lad Prabhakar (1):
  dt-bindings: can: renesas,rcar-canfd: Specify reset-names

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 71 ++++++++++++++-----
 drivers/irqchip/irq-renesas-rzv2h.c           | 68 ++++++++++++++++--
 drivers/net/can/rcar/rcar_canfd.c             | 14 +++-
 3 files changed, 129 insertions(+), 24 deletions(-)

-- 
2.43.0


