Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3310C47BE6
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87378.1767696114931374187
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qfv41DJ2;
 spf=pass (domain: gmail.com, ip: 209.85.128.67, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso7530555e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696113; x=1768300913; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3I7OS9Bx6hcr/45x4oFJv6FQI9kRYTPO2PeteYRRxI=;
        b=Qfv41DJ2wxeP6Jdd5gxmizDoEGRSmOq73AnqcXRW7uUNyZlDcwB8qU1NTSl1Ei8JXl
         s5ncL9PAKVZ2ZwmT+Njh6h2pcK9HN/OxNv41T6HCUPRG0NecTBcCO6uaRGLjOMpklv6V
         HdXW40IHmJBaSzJsm8yLUJCEo+2+7A4w2MjbnXLpuuyqTtab01gdZEpOJzQUorWDCNwF
         OWLlhStruUdEcsWbxJQdYb5dflOTBvVHlDwP/k6/3M7tH1Ig4j9CpUWDWiPtJ+//v0k7
         59MVerSAlUo3z56SNt6L6SBv3Cns37dadWR3tZPxlKFzQ79zsBLFgE5qg8ZVJbD8QShp
         dz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696113; x=1768300913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3I7OS9Bx6hcr/45x4oFJv6FQI9kRYTPO2PeteYRRxI=;
        b=qE7P3uYs4WkV+bx3U+jL56j3+rqqzE3BDkC0D4ypiI9r4/NTcple8z1HwtrmQu7xaM
         r5wLXaXxSYhnBYG5KBm228fbSjU6fgec3QFuqKgh5Mcy4ymqiEuD9+lE2uGbgH98lJ+r
         OQzdJsQodoo9oqZWrEgYqW/y7UvRIQrP/rCYuxRuBllzl3TV/VvnFs8a3WpxFdz1GzHX
         96AD6VuZswlevHcWzYlNRewV3OK+N0qXaPiwpyGa5BKN36IAPSqQ21o9NXggLNpZaNZ3
         1+84DRJdGdw9otSgmfy73cfOy2jCTwWkuGWwmKozBP/LUMt/08qGXvezdmbjsrx/QVRf
         LraA==
X-Gm-Message-State: AOJu0YwZvApIYrNS9mCw/I9+2TgPQJC4fVbGnQqpLOkoAV6vml28RaWy
	5FR67KCjZaOqZfFgrzvOQaMzceodEfnQb61H+JWOMOofhE5+kf7H28eXuxwAU4uS
X-Gm-Gg: AY/fxX5+yymFyWcOgD7hMrE34CKwPXwjiVdQWnNuFg37sUYTbnLlYCWzSZ2iZsw8QZm
	L5yvuzEnjOnBqOa29SN/LWd4DO3ryYnMz+y5oijAa9fo3Sy8e+6RQo5zP19cPgDAc6e5/g2VFtZ
	L6if1nrSSrXagnnHXKpX1MxUdYJHNB+NVA5wKNGlnPfoohbkxMwznu8U8FazCdH9ghIgtmMKNmU
	q8OyzU1F+K6W/QTa1PS8IvRhAognn5RG23Ssn+UwZQMX0qlSFoTuju1RN60iWwJ4uq9mzTyDYJi
	UhNoZBr6YfE6BAVhrooIlrsdRQxyRjxylquh4dQiF8OREcvXkwYipU44Ebe0rHZTUMlaSfDzOGV
	CPjhnGMEaACBQOwX3pmU2DbwWrgXxW04iF30IFaGy8L4/DLrkN1BBv6qc1jEsY7L8Rm/L4/zOYQ
	so3k2TsFWq2MrZAgIhl+vhxsFUbWYy
X-Google-Smtp-Source: AGHT+IGgoh39Y+ifKuCClNSmS2W8V/af9fOQ/iaUTepFohpt5j2iMPg4bPG72YXRtAXSmFQoqwpZkg==
X-Received: by 2002:a05:6000:3109:b0:431:327:5dd4 with SMTP id ffacd0b85a97d-432bc9f57d5mr3361663f8f.46.1767696112714;
        Tue, 06 Jan 2026 02:41:52 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:52 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 0/6] Add gpio keys/sleep button support for RZ/G3E
Date: Tue,  6 Jan 2026 10:41:42 +0000
Message-ID: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21325

From: Biju Das <biju.das.jz@bp.renesas.com>

Add gpio keys support for waking up from s2idle and sleep button support
for entering to STR. Wakeup of STR is by pressing and holding power
button. All the patches in this series are cherry-picked from mainline.

v1->v2:
 * Dropped duplicate SW_LCD_EN macro in patch#4.
 * Dropped squashing patch#4.

Biju Das (5):
  pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt
    control registers
  pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
  arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
  arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control
    node
  arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI
    function

Lad Prabhakar (1):
  pinctrl: renesas: rzg2l: Validate pins before setting mux function

 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37 +++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 31 +++++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 82 +++++++++++++------
 3 files changed, 123 insertions(+), 27 deletions(-)

-- 
2.43.0


