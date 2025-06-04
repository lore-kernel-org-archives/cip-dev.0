Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF2C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:23:50 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.13335.1749032625571054500
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QR/P1piZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89f9bb725so1317934566b.2
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032624; x=1749637424; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DS89vxX+1qNG+hISRlvUwcj1EKZUGPF+czIlqOhbrfY=;
        b=QR/P1piZqF5y7TfhAy0Y/U8Gve829r/l0GkqBK7ur3Qd585VVYGz65zows9sg1urwP
         PoI/GLrnzkVa3grKCt3XZL5W7sfuUTXkp2zWWTA4i/+eg6aSNaF4r9/Jgol73rQzn+0i
         kX0+paGSYzPhS645xSRVc37Yz94PXCbmusgYDi5WQUgDoQWdLv2y2LGqlAhH+XOYATZl
         YeXXxr+lm5UMoInBYt68ssDpsxwk6LsTdF93a8hjKTqTSBbE7CZXBKcS+DnePyqBdcOW
         mq4OIt6FSUMi1cTnLCGAMdtFUZdIBaLjoKibV6iiseSWDH5wNgPI+tYDOIvkeS71t6oD
         YVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032624; x=1749637424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DS89vxX+1qNG+hISRlvUwcj1EKZUGPF+czIlqOhbrfY=;
        b=WWQzBGHze5oHgGqsMtBxZOVW8C36nOe9AlR4ZmHWFLaThOGuWuy5ByMX3CiZ+uhFrR
         Pu1HChZ8rdA0IgmeYcP2MQwYu4NvCNxhK2dcA9Ps8QRx1RnOB7indoeSycEme3HBcHDo
         FoRWlhB5abmGnjvFSj/KtE+1ewzd5fMPuIMl93vJHd11p2D5Kj8EpBgrKcPkAdi5yoPs
         KX+Dj/mY/oSqWpXs1mKIWlhzJpBn+hC7ioxgfU5TC7+KDLXe95MVDl6iwl92vdYcgI9a
         YZAbxY+D1T8R1JYGEMW+sWHV0OHh9HU5m/pVLZAWvwFuy9ov/sh5l7syCudkaUHVRhIj
         gCMw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/JUpQg4Hi7XC6Ngi41bDW9t8b5og8/HszhPz9BTpAE4YymNCohLdu1nqujX1C97E7lmRyqb5@lists.cip-project.org
X-Gm-Message-State: AOJu0YxHEW2GJztLZxXZTW/Ds65EySMtyqs+UHH06sz0OCU/cu/y6bbc
	bvqS/6xazgjPJ7cQhrq+Q0ObL12n0MeWBHn3DUiZXS02KaOjTIm9vk0jIgn16zQlHbg=
X-Gm-Gg: ASbGncti/qzCYZkaI+kvTCUlWzdeg5ncunmliiGgmoHLUudRCpx+psb7p1CggDlQB/4
	VkB8fjHaWBUElFyYGXsFqsgVSqvbjb+qnz62HqRtEGhOyDq2F6K4/nv5xY9RGy9e89YWyPWZb1t
	BO4vkdX4B2Ex9Uvpchl5hXmaT0B7T0Q6cPxZ9AJ6haa/SVOs9+rgg0j7aEIIlOWa38wKc6xqz+2
	g4AewPpjaUo0p76oowwbQUPBzNXqn/XVP3NX+s0nXIvQjgYwPoQtODbcbybv6/O8h9oEkB3g8sR
	DkC+LMkQe7Ivv+tVVxLlnkO4V6vu76M0MTpjHek5TbLqBID0RWukIVA1EoKWEuVfcS7LKlS9t9j
	DSUzmFw==
X-Google-Smtp-Source: AGHT+IHHfDhY4asl7E9psRzS+7x4hxF3OAW/AaZLm36R/CUtO0jv+La2F1fC1L0Sbq+u0+01qeSJdQ==
X-Received: by 2002:a17:907:971d:b0:ad2:2d75:d7fb with SMTP id a640c23a62f3a-addf8fe231amr199430866b.55.1749032623802;
        Wed, 04 Jun 2025 03:23:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 0/8] RZ/G3S: Backport SCIF support
Date: Wed,  4 Jun 2025 13:23:33 +0300
Message-ID: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:23:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19001

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.

Thank you,
Claudiu Beznea

Changes in v2:
- fixed build error by dropping overlay in patch 8/8

Claudiu Beznea (7):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

Geert Uytterhoeven (1):
  serial: sh-sci: Save and restore more registers

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++
 .../dts/renesas/rz-smarc-pmod1-type-3a.dtsi   | 45 +++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
 drivers/tty/serial/sh-sci.c                   | 96 ++++++++++++++++++-
 7 files changed, 300 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.43.0


