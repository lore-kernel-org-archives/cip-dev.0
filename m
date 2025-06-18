Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80885C77B73
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.37950.1750217909321406534
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HtBQgVTa;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: zaq14760@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6881961a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750217908; x=1750822708; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uonrVs/pRpGNPcjjmWWOHRenHXMMDe5KqCaZ0WZ1vWc=;
        b=HtBQgVTaGvv8IxSGTajpXsHRQu0soo5bkYxK3OGDpEEWtxAk8/T+qbKPB6M3YAaZGx
         WXYfS8ZnA8sbqvkqsXaZU4RPWiNxEMqMNtI6Ssh1Nl0QqCfVhe1KK0LHQyMdFPzHlOOz
         M66Af9LIyaKN5cHHYka1Gnm1ldX33fVyl6/kYOlnU5OEZGjzQTBZyQo/fXVk317QtK7s
         MWM1HrN/2vQWGCAXBxKIc2yRPQ8sd1rzRYPGpgNn0iGsBwD0wekkQ+WAcPxL+v9SjXU9
         67zzb5zqh2lCOwAHvDDyCm5l0onywrMPfZCDF+sxUn/z15HEaVfYHrYI/2R7bldjqCEj
         il7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750217908; x=1750822708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uonrVs/pRpGNPcjjmWWOHRenHXMMDe5KqCaZ0WZ1vWc=;
        b=wjNgU1vYkYuJPG+xJ1xRMX8x4GvLjzQ2tLPawMr1dBh1Yx3MhKZpVedHeI2Os0/Djh
         CTeYg+yhZYStfWO+JZ5wP+jDbrm000xZSOZ10xfK8Y5UsMn+Jq7VSLWE2yy4/bHsImPC
         VWWrYk8JHk94/C+dr0G0lYcCSQaBdNJfWQoRP/2BvAJ+ZeZZ4lwYbJ1eCTsVo7tZwpg+
         sqWT3VBe5H0Ctpnx5rFNLjsECCPBocZwXVhGF7Lh8k0R8nyKpGDzuhkZZ//z6v7cfPHY
         7Fy0eNAeR2VdXZFk29DirlYNAfPEfC3oqJV2gIXLE8gWPBOvBWWYTPG1Ti0j60H15N+t
         gTVw==
X-Gm-Message-State: AOJu0YwzTLffUHuIYw7zreDDtah61An6U30bt+6fDsyMip65Tx+2A0JK
	maOe3yNB6HFcsr/8aV1xABfgJQ+ntzieomY5d+Rjp45WSw9V//Ols422LzaXrJAg
X-Gm-Gg: ASbGnctogwIOzHOepLxUrnVpfkTW80p531w85QFlasHWIChidkAuz9GqVVQp+uTKMjf
	rqi3F3BlSbJz5qvl0sVyuV6/tNWL7Oc2YLKMbme++38AA4xmWoGSJ16FT0DZsMxSvtagUiElKgG
	s+9MU6+teczOeItSVfxfJfy8dVcYbJxcIVieZFbPn81jFEAjFbdb8ITfcLBXDDWB78YvVe9dZq1
	colDNG0hQEPbh/u4djCgY9nrtVJwRO2FXC0Dxxfow3QqwUqmBpwsHHIPI6zCLFTP1ICsZvmIYVr
	DQHlPSmcio6Cv5a8JQ5VsjU2Wt5pzcZKQgGxVOpJ97FM31CSOU/xvlwpmtsnb/UmfdggzGve0fJ
	PPOZbpyEkZgo1Lkxhl2HJM3h2x68aq9rGJSRXsJXg5rmD9EbuDw==
X-Google-Smtp-Source: AGHT+IGCpeONFeK+vCUHFAZvHE7jFSRmu9ICiUPdwHMxfwRud5mRe2MvyXaWeKME0aWnWjENgIdySQ==
X-Received: by 2002:a05:6a20:d049:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-21fbd459503mr26148333637.7.1750217907834;
        Tue, 17 Jun 2025 20:38:27 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900822b7sm10147934b3a.101.2025.06.17.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:38:27 -0700 (PDT)
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
Date: Wed, 18 Jun 2025 11:37:28 +0800
Message-Id: <20250618033731.171812-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19123

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


