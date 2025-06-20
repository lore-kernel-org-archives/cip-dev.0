Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6EC77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 04:25:16 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.2278.1750403944105112992
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Jun 2025 00:19:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KYSMueWF;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350fc2591dso12427925ad.1
        for <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750403943; x=1751008743; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLtejJ//A/QSzUstIr3zh1lEvcjwzNqocz7zn4vFJ00=;
        b=KYSMueWFklBGG5WFdqi7ilA4wj5JlaFTLqQQkzfG3yIJNJDv8CewVlb7H6r7Iq13QV
         mSXk1hFM0enblilWH0sgj6KZYhKQfYvTeCM8oZ2BuGhFPJe0zBc4K53gg7K/PhvizhzI
         a7O2hFRf6NXAVgV+cBxYLBePrsYZImCRuSWLzGGtfAvCLaVuzJ7mGt0zzggO7ivdXL7Y
         6owdr08St6fzu57q1UQlX6w1fEpJaTAJURaLYfmjN3cgzKsILJIzJRWeTk0ZOHO6EONb
         T4WwH2dwPSwZwIi2Syp4w21NURbPzQ2EOsXBzGYyXOAq2Tzwiztigm+tSlHDDyKjvne4
         G4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750403943; x=1751008743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLtejJ//A/QSzUstIr3zh1lEvcjwzNqocz7zn4vFJ00=;
        b=va/RTO9KNAsziQpImWi+Jyg1F3TfxCczhdUVS5mh6Vm+fUybBcF690qZg9oHO1KIZP
         1kntPN4Nw1AftaGv2RGKmrdDQW97H4EMrt12wXjeGi0GKChe3MaU4bSPnKeYmmgayd3U
         Wqhmhy/NLcOria3uLeugIMse787WSxLKbXDtxqJgnjz0/pM95EMHbOcfPOPB9Lw0Ubz0
         qtzKrmfjI+Uprm/0aja8zzS0H5CcM8S2XhhrecjIpL9oTFVqQ23WlQ12erApkCC6INDh
         SgfPNlwcKDI42pPjAQUULjOnGyiJr40UcbMbMnI0m8hDOymP8fNpPLhG0cdFa54EywMN
         oQOw==
X-Forwarded-Encrypted: i=1; AJvYcCXsqZKnTj7ETxuMOIhN/jZfMQCAgbggTnXnUZGEbN3y+KO6ZsA9kNvYpLbdFXkOyO4HOECUKyDn@lists.cip-project.org
X-Gm-Message-State: AOJu0YwfH6b1J8bzS6Rj5WAvS6KEzFEQk9eWT0UOj9qO+kai+WubcAV5
	VSzmKGRLFe87xCkww+E0P8NPhnaesjJn8AqDeupNKEzOksIb3QmZafNV
X-Gm-Gg: ASbGncvl6tDOsjR+HXtQvUXNe2ZU2JuEw+jXlt9Te2P5XqgWaBhBqd4E0ywLrvWM/UE
	5cqMGj8f37krmZzDifxCqGrfILkBWcDi56bK7tgDV8beVfHfUd2LZFBBFGg86Vi3UOx8ASxBIXf
	g2xmm63ZD+vRdH84zYjDdkrY1EPkbgfZsvZJ0OSfPxigotpCAn7dNWlglkm85ExnRUe4gXaaLqk
	etO8nHYF0Jcg5ThX6erT8rbocuLNNlA8l0Q2LsA+rQH9TF7qb0AZ/pSVtfW1ZdfGPRaNtYNk5Rx
	10HBlK+USOR3M9DpRcOEpSd/90BNWzwaUl+WItz8kf0ojSAHJOizvR8bl4IO8DFt/UadXQcBAFt
	B4GDZgK24Fy9OPbAF8+HhdT1UWO1gOKxqpAD+GJM=
X-Google-Smtp-Source: AGHT+IGW5bBCG1YthBjZ+43KRwT91n6Ml1tjlOKii9r6uMi3wXRMYDqtk50/XPtrETenU9CqGKY4Dg==
X-Received: by 2002:a17:903:198e:b0:234:9ef7:a189 with SMTP id d9443c01a7336-237db071659mr26270815ad.13.1750403943453;
        Fri, 20 Jun 2025 00:19:03 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83cf981sm11431995ad.59.2025.06.20.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:19:02 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: conor@kernel.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 0/3] drm/tiny: Add MAYQUEEN PIXPAPER e-ink panel support
Date: Fri, 20 Jun 2025 15:18:25 +0800
Message-Id: <20250620071825.741903-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620035310.735055-1-lcwang@ieiworld.com>
References: <20250620035310.735055-1-lcwang@ieiworld.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 04:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19159

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

Changes in v2:
- Corrected capitalization in the title.
- Removed unnecessary '|' from description.
- Removed redundant description lines for standard properties
- Added 'maximum: 1000000' for spi-max-frequency property definition
- Changed 'additionalProperties: false' to 'unevaluatedProperties: false'

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


