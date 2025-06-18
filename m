Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C74C7115E
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.37972.1750218581836121455
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=krg4q8KM;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236377f00easo83011555ad.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750218580; x=1750823380; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uonrVs/pRpGNPcjjmWWOHRenHXMMDe5KqCaZ0WZ1vWc=;
        b=krg4q8KMlw2OfuwFWVbdm1DbRZuHxA1KxoXwZi6agaLYPQKDED8kLxq5lF7VYOGWc+
         mL6oj8fLXgQFlsCXbRqOP2aaeQbPGug9qDXvD/gX9XoshVmG3+cOc+9s/Jn1aFFCCNpk
         NYPu72vcUXT9GsarSLRgR6RM4unXhjH/uwQBJPP2p59nsihGFl9aB8RcSY+YhLh++zCz
         AWNYsgu3+18xyPuGQF9M3oHrViGv7eS7Zuts+puVkKxn/u0SUYvYLpkxIDAaYKOAcFdr
         kCFFXYa1VyaGlrBeySSOObJ4xnsup7fVhxhIi+mJv9A65mBG+MAxRwrDKfZkv9l8iiQK
         uy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750218580; x=1750823380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uonrVs/pRpGNPcjjmWWOHRenHXMMDe5KqCaZ0WZ1vWc=;
        b=G6YBqlDRUOc+cNOJ/VLFK51Yw5WaKcWNrePZm/iteaSGf+znGxqqVXUjMm9h2AwRgb
         aP+QTDuSzYAnhp9W7cDf1kTx4tKXw2P2cG09++FoK/y/TF+wrJVRI/Y4lBG9W2OsXVOZ
         sr8spWIaDAkdyQYhMu3MhjHHmgaFFytscSS78Fd6jrsWHP0ykrBkZ3jyrWekqjjOUHaf
         e6LPxQ/9WIMxxPqjo9kC+qFDSS9U0IRRgerOs0blxNVNSlfeB3GjLga0u1F9QHPa4QDt
         mYQu8kj9UI9SLhf9VcuU9RBT48gvpUhxjQykYHB8vu0c+BG3YmYv8UO21/9kbD5ZDD13
         T19g==
X-Gm-Message-State: AOJu0YxBIXtlZgujTjmr4/vj4HhNJZ6N40o8oVlQ6goHHX0ekYGG66Nz
	6wO46PaQ/V4vOZoyj2eNX57cb7Cog2nVSrqf0R7PRFtmEkPiu44ng3xiMl5iwvZV
X-Gm-Gg: ASbGncvJSEmIPBupWheunD8PcMBMnTqy+5LC+2f1TNlVQ57rsPTh7BMPq51mlTXBQs+
	UOkEbwJEZgLlZAfq+WqQFuXoL3W+ugMKOxIuvXQyFgW1m0MplGTElxCud2swXsznUghklclkHmR
	g0XHvKpWNnGd9/J0y+A3f1osJl9aUdOwGMr16Ux1MKxus+Ax27sdBt79ABL55EEetL+I2YDsHuw
	F/Ji69e517i4y+Kuwgdl+Qc6JC9ahIwa4NnU3VkUENL8lhCfKaqrJlDbJ2IlntJMnMXPzGTVE62
	CAkhUe5Aqvnj/ws237/fqzyaQh0KrX/7pIheTdhs3JGdUtvuXyAk9vS3T7vtl7Eaa07Fm9a5UsB
	VrV9KAzdK/oVcPiVkMIxKdkH3G9oBCn8Xm9xqDVA=
X-Google-Smtp-Source: AGHT+IE7Vg3PD5i+hf6+8elC6Q61qDmmCHHO2u2OoQshKIclquzMiQYEl6w5OCvJrDOpEOEJHlhkOA==
X-Received: by 2002:a17:902:d2c9:b0:235:ca87:37ae with SMTP id d9443c01a7336-2366b149bd7mr260175125ad.41.1750218580570;
        Tue, 17 Jun 2025 20:49:40 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236736cb4f9sm63418405ad.138.2025.06.17.20.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:49:40 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com
Subject: [PATCH 0/3] drm/tiny: Add MAYQUEEN PIXPAPER e-ink panel support
Date: Wed, 18 Jun 2025 11:49:33 +0800
Message-Id: <20250618034936.172150-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19127

This series adds support for the MAYQUEEN PIXPAPER e-ink panel
(122x250 pixels, SPI-controlled) to the tiny drm subsystem.

Patches (must be applied in order due to dependencies):
Patch 1/3: Adds 'mayqueen' vendor prefix.
Patch 2/3: Implements PIXPAPER tiny drm driver.
Patch 3/3: Adds PIXPAPER device tree bindings.

Tested on PIXPAPER hardware with linux-5.10.y-cip,
verifying display initialization and refresh.
All patches pass checkpatch.pl.

Signed-off-by: Wig Cheng <onlywig@gmail.com>
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>

--

LiangCheng Wang (2):
  drm: tiny: Add support for PIXPAPER e-ink panel
  dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel

Wig Cheng (1):
  dt-bindings: vendor-prefixes: Add Mayqueen name

 .../bindings/display/mayqueen,pixpaper.yaml   |  67 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/pixpaper.c               | 716 ++++++++++++++++++
 6 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
 create mode 100644 drivers/gpu/drm/tiny/pixpaper.c

-- 
2.34.1


