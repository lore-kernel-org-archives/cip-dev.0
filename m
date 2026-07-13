Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E4C44508
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:06 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9208.1783944238385034422
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 05:03:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=X2ZMv08Y;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso918559f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944236; x=1784549036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKcVMODK6UyVK6BPc/tXWhqfr7Mm1akUm1WOqSSGZ74=;
        b=X2ZMv08Yi/haK1jr9xZP4e1FFe/6hSCdbD3ThbdLGZPthmkDmtdjI/37oduhJoxQ77
         ehYpG6jBsyWQZnEGlGRZj+nze4HW5RSMKtM3IGWNpO+bGUWaglM2R3XWBZmCuhaiF5Yi
         /B7ZobNnWsbQl9Yb69bYn7lZ4G6JjSvcHMzxpAFb9DJ1POF87D/NfeIpVbgqeq3qmDSr
         6ZXTpu7l0lK9bG8t/qJZBUkfPMm7swK4QEWnbRqWcWLw0GjFsn3SHKTq0jkwsHKsNZy/
         mmpDGxU31UIadOxtrP3+DMivYvAfiWnTMqiTVgAwrEmI0yo6KI8UGd28/DtaGhno2XPI
         GTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944236; x=1784549036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKcVMODK6UyVK6BPc/tXWhqfr7Mm1akUm1WOqSSGZ74=;
        b=G1zzr7KaE6fvQjq7aUi9BAyC4fwa3ms4HQi13Gnb3bdhDbMDiOI+63ywhEGNA+zpQz
         j3dBkxigxLdNSTX6bEma7P9XVn5t0vMOLiDsC5PjA3aqN2YebT4hb5PtPElnzzJ1t8vA
         02Cc9S/GZFXfxZ0LvIbjMzgJ4ELJxYQer8buXbP8TneOP6BUWeiZl/ksoVbH6dbNomY+
         6RSnMniJm4THMHICN7gToYzOLPfXkQQKSG5yE3SslVcJFNEQbSb4b4MYZl719K8QWMuF
         rc2Wb+FVaPT6GShkpIi8YHlSV9uCYZqYMCqCqJGK/od123eXi7EhZW1zycQSUcpGOnC5
         3bWA==
X-Gm-Message-State: AOJu0YxlOaSclNQnzyYnBpzh7pT3Ny4uScoqU9ySFFQcksqe8IwZsEYX
	acD9ezn0QDEyLsGuMYNMELNBvkLmt2kAXq9MGI0ZpKZlmOE34/XG6PZTxBSQvesO
X-Gm-Gg: AfdE7cmCasWFrse76jNAvWocnkIw3bj6ibyigzAfmkg4pOUkw+Z7ibNJBSKZK72OyM9
	nDO5v5mnQxHzRAhZbCAUx8wu1z9s4sQj1UselUKIxoiPSPmnVfDIJ25SFas0Utv6GobcxsLMu3h
	b8HQDPv8ueA27MCxafzSDdBG90UkVUGe5QezLo0i8UwOLcrXMb6lHQuyrdjTNF0xLm7HTDnh5t+
	3xX1Y9N+x7P0G6JUwfhefHi2k+hagMj/vxAzSqXGTEMPT6AUq0Sl0NGIIwXXqAYnHXp7ygE6duV
	IZi34hYAaQc9EMl61gT9aZ6zsa8BAklST+urtxCZISxDQJtWJvhoiPafaZNuBiuiFz6tdL6IUsk
	7DNaUNEffbpCUBKsxw/hqOQ5n5dmYCbin7g7G2Vp0LatprpH+BlZmGAJUKGf23mrgf/zKh4t+0H
	dsAf4/q8OJNvqU3iE7y/fW66aD0NkHcrKmUso/rA==
X-Received: by 2002:a05:600c:8717:b0:494:ca0e:880a with SMTP id 5b1f17b1804b1-494ca0e8a18mr4846795e9.12.1783944236160;
        Mon, 13 Jul 2026 05:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm322910705e9.9.2026.07.13.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to SDHI nodes
Date: Mon, 13 Jul 2026 13:03:48 +0100
Message-ID: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 12:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23562

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

This patch series aims to add the max-frequency property set to
133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
the RZ/G2{L,LC,UL}/RZ/V2L device tree.

This change results in approximately 33% performance improvement as
it sets the SD clk to 100 MHz instead of the max 133 MHz.

All the patches in this series are cherry-picked from mainline.

Biju Das (4):
  arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes
  arm64: dts: renesas: r9a07g044: Rename SDHI clocks
  arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
  arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 10 ++++++----
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi |  2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0


