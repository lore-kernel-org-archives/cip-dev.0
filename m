Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD03D5B170
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24217.1765714014325858312
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:06:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EKsivmE7;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5957c929a5eso3765228e87.1
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714012; x=1766318812; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ajJCT1gHe9+hETCuvtewJVsj++JxnZ8ojTy1eYcEXE=;
        b=EKsivmE7kMx+pP2eXuP/sadmtgdmXKfoO4q+bapjY2N8ns0gfENXG3RV3D2ZiR3bEB
         K/6DlL5MmlCq8o3NZTcYEjOiX1GdlK7JskE9kXVuqBuNy8DjOmQ4rn2Wv4YPne2XZWdI
         8e/B96w47DQ2NFR7qIGPr5sy+tFCsxOvfVPGgF1+aRi5ieAUXcSXa8xtGx+11nJrJijm
         sAXNUAqWu5+8D9pGGRmyIw9SbIc6j9myHF3TfpLuxFlrqnmu/BxXGwHU1vS3xNTqrCCM
         VqlDCHmZ00GGsQ7dluVb6jsK4G36R528c1D9GQXwQKM6xam3Wz7ghpOd8UW+G++aDLFz
         cJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714012; x=1766318812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ajJCT1gHe9+hETCuvtewJVsj++JxnZ8ojTy1eYcEXE=;
        b=I7MNJE1RpSQXJ89ZPuV0H7BmPTsZes1gS8QiFbAg2yXKr0co/mhj82nUCsbzpox8Yf
         aoPrUZ/3moQaFTCIjYibo9W9Ph85hzd9OpypyFneZGkidFLvnqFJrKzdK38o9MBqw5mz
         Ca4XN+9/l8K7ECtECeguE5z5fxWGv9xs6eoEl8yFCivYytwUgZBIZ/EVXvWqLrRIkNEY
         2qjCAas//Bd2vfTjGyZMbIqLkilxcI4ZHziXxPI8ifbbDHaIP5ZQ1DfELurhlpEpZ++G
         AH4dbGn8HbDpYWGGRNxxE+pzNFGKUpgDk3p7US+KrTfiqITxq6t/qMF56Pydyd022P9X
         QRlQ==
X-Gm-Message-State: AOJu0YzHBXMF18+4OlZlI6Buxqr9dBXgkRRT1iTdgTGzLe71ESamAU2h
	JAQMzaLsS2BmKjCI2vXbWEbMTTUpdIQhNaQHIJlxhI4JrK1mSrzKCrPU1IPfyQ==
X-Gm-Gg: AY/fxX6ezCppc/ziLP9RA2xhar5C3rbCH9alTj39Dpox8omOjbgWDTmF8I8KseN45o6
	Z6ehRMsdaWYN94/0NXMkAmjdp1uLe1Hb+7RErKlXPEZyeaEzmJvO87ei4alK4+Fd0ebA1TE6lLI
	ZDcO9PX+QrB6pwrj1UFzk2CL9TTFoQ2UykZIt3AI7mskXXwn4nPrrsAxjEBUbe5mMHnuKcBvuSI
	/SiaacVv1yEPpKJpNYgDO9grLp9zCCFXgrfosJjkCZs+7O1kJNNL38OtF8hnpZVO+IZjMSAh9fa
	q0+Qxwm7rbjHWbCqzzC41ObUJ9FS1IrE7kjj5/mx+Qlb/Eb6jPM6caLNo2cMZO0e94BQjt/ZrvW
	Q8c841Y6yqTntVN6EpY9Or50kvSnlPjLOyHb/VNde7ySjsEQgGdURXGkWmTo8y+gb6KAS7jEwLH
	AIhU8yXelk5A7M/WekQrId4+4PlgoHAUzUshnKGnB1e/I73su/yMjSD1Lkg1Jsc7KTj3DNoJA=
X-Google-Smtp-Source: AGHT+IHHePQPtK8u32yuXK6HnRJWatyQLuL5gbYIuix+trx5WJsz8S6K5rFKcFj6UEK7WaVn8OGvnw==
X-Received: by 2002:a05:600c:8b16:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47a8f90e81fmr82253415e9.29.1765713683590;
        Sun, 14 Dec 2025 04:01:23 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb68866f3sm14523386f8f.36.2025.12.14.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:01:23 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E ethernet
Date: Sun, 14 Dec 2025 12:01:16 +0000
Message-ID: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21016

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series adds support for suspend/resume support for RZ/G3E
ethernet

Biju Das (2):
  net: phy: micrel: Add ksz9131_resume()
  net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks

Raju Lakkaraju (1):
  net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131

 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  1 +
 drivers/net/phy/micrel.c                      | 91 ++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

--
2.43.0


