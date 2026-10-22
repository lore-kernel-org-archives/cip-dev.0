Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23079.1792676426564420142
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 06:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YAqpeAUB;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso23929015e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676425; x=1793281225; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7eOuCX1dEWNJC7RFoVh9yp7Qcauv9ID9wab1YHJFmrI=;
        b=YAqpeAUB7xqFXAM52PJYSaNeamjcVorwNc8FIl/E5VPIVwo6ItLijC9PJ0mvCv4MLY
         Vuwcf9cuaSVB4zUMe9PqF7SfKxFasiijpVMd+NAAacXfJ/FzuBBu82rwKSa7EPwGOAAJ
         /Uky8niu1NsT79jRBnvHfOcPQ3fXFtdebwQ3gCaZEWNYULvBd4eo9Cf0Xe0zQfVqO1+T
         NVO7KkCOFcnWnMhxHcXWAOBZLeG3rypRATIAjAMi0SRnVz/P++QERE1Mb+n6A+I8Qab4
         Qv3ORlXFSgmuanEWjvoEiXbOOfeGiRaRLmx1AHR8d60S6bInrdJHCqusSXuX85PSv2xP
         kptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676425; x=1793281225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eOuCX1dEWNJC7RFoVh9yp7Qcauv9ID9wab1YHJFmrI=;
        b=hkFKs6S61l3NeEfUZwtw/PVDV0Y7VRHiqzdjJNI34EEWOUTZvSQNrBtL+9AJ6Zcq3g
         f9B/lXfpi9j8GCt2xYogVrRCWORrWHUnwR+UxD2sw0fwMIDHzU27bxc+8kbk+UYACq2R
         77qzLmVYdPl6/yVVVtmrZPCuI6n2JEnzpRqe5lm1Y5gFWFise7fAS6MU2U4yDy12kOfy
         oh4pi6oes1C7grbfJ1nJQ3RF7aDbaqjsaVlWX1ffiCmgB+lrI3uW3e3nZr5UxNQmg7RA
         TNKnce3/0NkYxLzchylgreTZ/Z+RO2WSJ9YdiKqVFi5eQsa+3n4X8rwa/Lkh5SAPkpr7
         tQFw==
X-Gm-Message-State: AFq9FYIyaXx4XuLAaQcEJBULD2ck85jo8UcuY1i/o5WoziSWCbuz7WVt
	vV/eedJuY2hr128/7BSoSnKDTmTXIO+gu2Usj0tpJCR+oLZjH0yxiJXsRSECdQ==
X-Gm-Gg: AYBFou0ff3ZpKvCKhef75fQr9lPHyB9GutX1dBqxTmWkTAqDhqQsAkukGZMXxJpwkV9
	psuUsWux2WKb7oxSmjVB2zkEraYMjLUbwboWaOmu/MpaDclaivHI6PUQeaXXOonXG/bvlQBML5l
	ov8cyRjfE92xa2xMYK7/tcVx4SMmosUe2svCNvwfqlaDASkrnxgnRlb5GtI/jNo/3Hk+TR9TJVx
	qNc2QFlyF+jxqSepC6O3G1VF0LTVMlPaFgqC3EUzGJj+f0M2Jcl1p/KJtgKbmcUOdAkOsQHdTBt
	6v17cERc2HLF/zQSfJ9ig3aKKcYp34zyexwAV8JlyY6F4aOWggEKjsO3C4YSCQuEUHq9bwaOKy7
	TZrSm1qfJeADOBw73y3bDKX/zVxts9S8aCzDENhNI4hfTF43VmaTCA5tgkre5dyGnc1OdGFHKVI
	6AH1ABRgSwbHlVDZ1Njs2CWMiyBuYRD3jFZvYixdIH1J8SY+n8b3C23SZa+Iy/e8x/FXfGVcot6
	yLF1ZqRKXdlOGJp97Jlr/tvMraeGWm3yVuGhO5IbT6s0OIwoaH6rWJke+jEqJOB8LGE4owMTVbr
	YOHdUFNh+QeIoyj/7a+c/5WeEwEVLji6PgFfA9+U7j/6vPNWH3g=
X-Received: by 2002:a05:600c:4fc8:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a1fdd2472emr115201985e9.11.1792676424352;
        Thu, 22 Oct 2026 06:40:24 -0700 (PDT)
Return-Path: <biju.das.au@gmail.com>
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3c4e:ba43:9a8e:7e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm82888415e9.2.2026.10.22.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:40:22 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
Date: Thu, 22 Oct 2026 14:40:09 +0100
Message-ID: <20261022134021.217964-1-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 13:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24509
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series aims to enable RSCI support on RZ/G3L SMARC EVK.
All the patches in this series are cherry-picked from mainline.

Biju Das (5):
  dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
  serial: sh-sci: Add support for RZ/G3L RSCI
  arm64: dts: renesas: r9a08g046: Add rsci{0..3} device nodes
  arm64: dts: renesas: r9a08g046l48-smarc: Enable rsci{1,2,3} nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Drop SW_SER0_PMOD condition
    for rsci4

 .../bindings/serial/renesas,rsci.yaml         | 26 ++++++
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 84 +++++++++++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 59 +++++++++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  2 +-
 drivers/tty/serial/rsci.c                     | 13 +++
 drivers/tty/serial/rsci.h                     |  1 +
 drivers/tty/serial/sh-sci-common.h            |  1 +
 drivers/tty/serial/sh-sci.c                   | 14 +++-
 8 files changed, 196 insertions(+), 4 deletions(-)

-- 
2.43.0

