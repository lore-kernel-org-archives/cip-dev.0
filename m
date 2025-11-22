Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAACFC52A
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:39 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7112.1763808691304891518
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DqB1Krmr;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso2341235f8f.0
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808689; x=1764413489; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fbFgeIIvepTzz5oGKBNlJDobiN2hXFzg91KYKSf3Oo=;
        b=DqB1KrmryxH/lC6kWKHZ1eedPzTS6S95x5i86x3Q/LlhpR17F8hFs6IW+0+YUAYVyb
         pyLp3eFfqLu2pIbsh2+qR8l9FAzMyY3jvlYnyC77ABrq12miF7Lz0417ztQ0MHouMp3b
         AGKK/ZvV+mBELf1I0IXzePtWRjT/BnqzMwygE5+i87DU7pSbQb26+EelnKVBY2kBEhv2
         A4naFK42W/lWFgYej+8GCYClIGK/ESUiazSMxLGFaIt0bhSX3LS0GlIGEZrc6qkyr2a1
         EJnH/38IbnBIzv7H9Q8AmZsCUlCvc5OvmJMZnl/LVUoJRspfQTaZ62JuLBSGQO2vrDPJ
         tB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808689; x=1764413489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fbFgeIIvepTzz5oGKBNlJDobiN2hXFzg91KYKSf3Oo=;
        b=J2oqx6cVN996aUbPCRoifZdGdVWNAVhc41GFIENXp0XtYLxW86DM1g3jSTcQtyYCvU
         2kUK8utzQldfn6kUmsbz607Upg8vG1pwTt9yBBqHpxmo5UeEa3EJONBQGElymhs641dW
         1/ZxJl23/dzxMuDdJR4mes6VQCYS5Hmw/axUqfY4VvW6jZxfB2RgP/+hra7nU0+CV7Kb
         fQZbuzy1xkT5vIZdOyeVMV/UsNSip47aLUUbjPY27t+dbqXE87h+M7zGi2QHdrxbkZw0
         +5ENP6nM9a5wNW0i2AKADOrdlhXt0QY1WyBCeb6ByzweerXlsTu+DBwaYLbwHhTGVBie
         vjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3OLbdlYhSqLu+QVQQnhtw83NMkYrlDbzD4F0fyLLDAtU09E5l/vsZ/9e3+PDWyaX1DX2LGMgE@lists.cip-project.org
X-Gm-Message-State: AOJu0YwCpxNsaQ8uKdDVWeTA6ayHXZMr0PIIVzkVDVXu3ehtZuEZB5qe
	tauQyMmHafCkMwgF8hKSKO2aYiMjgLpUzepGYCE4goTrxuLxai2JvFR5F7EpTsrz1aU=
X-Gm-Gg: ASbGnct1ceoPu8tcfDF7M6edsH2ov9lUi8A+rJgmkIgd4OCxsN5s/cAfwLuyLd7eTZW
	gLe8UPtro5xOtfWqlVDh9ortWPL3uHNKOfRm/UPs+ozLuMPn0+pw5hkUqgFzJknn6DD+13WVCqh
	HkVjnD18kyeMvLWtVAC7IRlNYJB2SFm9Vx4J+srP6t1JJlzRsO3KhgQMEGZVKKCapvT6htJ4aJ3
	AeWiL55sJWqZDPIxWH8j4JrcahunBrWCyQ9DjKrpY26DJ3PC2jEZLXRrjCB+sUWkXMIxoXXSTwY
	WKDkz5uM1r0dZW11in7CHvoJMNMCWnpXo+RABMWTH3oTuVOpGqioKeAR1uRfMSho9+PFOpB06z1
	hRqjA5ZnkWogVV3iiphVFRUaO3Kvvp8tHMcIZPrT43YbS0an155r0312ZBV0XtCM1BvLELQkc4E
	XM/GztMbDFWA3d8QaICn+t6Fb58ptwWM2JPMaG+xkeMaXXaeg1/i8=
X-Google-Smtp-Source: AGHT+IGP0mCLDErsraLUaTRpxCgGweGdPZcXSfy4c1nt4JBmOR5pfcQjXKWJHUDS1CSngmjEbJNnPg==
X-Received: by 2002:a05:6000:2282:b0:42b:40df:2336 with SMTP id ffacd0b85a97d-42cc1d19a9bmr5500233f8f.39.1763808689498;
        Sat, 22 Nov 2025 02:51:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm16335859f8f.39.2025.11.22.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Date: Sat, 22 Nov 2025 12:51:25 +0200
Message-ID: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20690

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports audio fixes necessary for the Renesas RZ/G3S SoC
and the Renesas RZ SMARC Carrier-II board.

Thank you,
Claudiu

Claudiu Beznea (2):
  ASoC: da7213: Use component driver suspend/resume
  ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

 sound/soc/codecs/da7213.c | 67 ++++++++++++++++++++++++---------------
 sound/soc/codecs/da7213.h |  1 +
 sound/soc/sh/rz-ssi.c     | 25 +++++++--------
 3 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.43.0


