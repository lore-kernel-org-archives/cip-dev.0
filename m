Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07675FD7098
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:35 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73588.1773746253112221703
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=njHj402f;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so64070865e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746251; x=1774351051; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLHLCGNA6A3bx6Xr8eRfrg6QXXvkqYufXUbP7kMzJiI=;
        b=njHj402fVNyGgitUxN94B0/ngBRa+cUcfcPO9DJ+KDPY/84nHDMEEsxbluSre4+ogo
         Bzt3G+eQV+maUbCDWg0TD0Vexotlh6nvxjN2VcvKAZTMXGtS2rgipZs+Vtuq6oDhU0+N
         i++9G8oVEqLs0S7HSV5VDgseIyn2vkPhjWGuqwbi6yfJRdiQIP/nibj3ktHay66dmGYq
         56g4AR3QhW7FzzDkSx9zmQuFFGYJvkF/InsOzByTvMzCi2J7qr7S7kcaNmVckDYSIiE8
         5Th4rLwbFuyy/jZiajUTNldyafgVuLtFel1ff/ObhKW6wOwA+SOc0oXs+89KIlq0k4hT
         ANPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746251; x=1774351051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLHLCGNA6A3bx6Xr8eRfrg6QXXvkqYufXUbP7kMzJiI=;
        b=D9fBxomgJOgnLckFmhunBNIXegOHapNcAyKP99aoU5GXDhd/LxHQ7hOaHOn2JqKjFx
         4KxBCCX6YjMQ/azVCO3uQYVnuxK+8FEbu4S9gRIHFqskNerSlmmldozqqUjKDJZt6wud
         H+fTtXlOfbEQQB1TbMvLwSCziOXZTt9qmOsIgLawzKctQ98sEfH5+SGXs89bShyvu3QU
         RHjmfz7bgNo2gHgBMNZK42I3gUYwOKH6e5WGb/hSOvtF38+IVCI/s1z2ugtorblc/qY1
         PEEpHoisPGcdjsszbd8MIxTmLSJGiQDUbD3GkYyryC/c2KXs55PjJ9e0Kyzt8WMaiDNX
         UFAA==
X-Gm-Message-State: AOJu0YyOnyd9p3VCmeENCEneaEhj1kFUdSi/xA22qRHHFvY1aO7/koqt
	tnHWWEVfiR0Kj2wgZhV0/g74rdvKSp4hHQ5r5a6Qc7kZZmAtg5oKrKASIVY6oA==
X-Gm-Gg: ATEYQzwLyhY8fxRDWOmDykGYZm7TVbQIN/0S8QKLwv4IxApMR32R6eplt3HcaMM0FBb
	M+JVLSBDVwCVuwTqZWhFyFUUooDmSNRH5yzDfRdIyubKZb9oBE9txduTqwXF8mc0vawCC6/RdNm
	ApuREk0fOx720Fhcb6EWDqc1v4wsBy8UuXeYWjqdqk/1hA1ltvOYocqnTVZfPQ6oYbQnd1gN5oZ
	KOKTWKXFPz7+QOcq+OqZQBG5DPk9qkrb0Z75ewhbyA+mBRVBuO/2wsHDJIzng3YOLuXFe2R1EuO
	2wvbOU85AT2b3l2q0+/rvs6j9Ung7UFl0httL1c9D3QrUuJd1376mHqPpP9/NZQTdf9d6pi51aO
	91LYQdwJ26IMlZuG6eG+lVFN6PvTvlBNRn2ssTyHWX3JeH+32BdWirraLtmFc4de3tTr3lWZZDP
	HQAWsf2cggWGx7ElLHwP2dS7fO2IPXvIgZRN+ATkSeDmYYI7ws
X-Received: by 2002:a05:600c:8b46:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-485566d7092mr272329745e9.12.1773746250634;
        Tue, 17 Mar 2026 04:17:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 14/39] arm64: defconfig: Enable Renesas RZ/T2H serial SCI
Date: Tue, 17 Mar 2026 11:16:39 +0000
Message-ID: <20260317111718.281633-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22447

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit 3fe8685424e3a351b151f37e71f0e5f2f3e3fe79 ]

Selects RZ/T2H (aka r9a09g077) SCI (serial) specific code, as used on
the RZ/T2H and RZ/N2H EVKs.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/20250515141828.43444-11-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 93efd7caffb8..ffdd6bc3170c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -445,6 +445,7 @@ CONFIG_SERIAL_TEGRA_TCU=y
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_RSCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_QCOM_GENI=y
-- 
2.43.0


