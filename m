Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D5E77186
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:06:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.55906.1734354383360327435
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:06:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lk16J3K1;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43621d27adeso27873815e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354381; x=1734959181; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KomaiRhKj1ptGCHjfFHPLh+RsFLmezh+4ygK3Jgn/yg=;
        b=lk16J3K1ntTc7NfMmFj9+EHDZb0HDyjGdZuvrn9diyBTSzNeF4PzqTiLYZJa/Uw4R9
         Mn3u4KLdXJLCdXskD7ManAT5Ae84eZ7cqDhufUrtXhIb9ievnLfr8BWlBZgGn8F5jwSx
         NZ5Lko40qUm4IAYWArG+rkKLtwy7nqyuhiiSDKuW1uO3Oh8cPaj5+TXpaH55UXcE9TT4
         z+u9nekxhD4woin5ncH744CbUTHWFVsxtz0IbCd6yHJigRtR+b2OObPTkfkHIW/1GW4V
         /nHaxxE0CW+aBOtSs8Pa7iB2WBiA8Hvmbkn4IrrelKs2i/TyJdSfj7PQVtjz9t21kUFz
         +Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354381; x=1734959181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KomaiRhKj1ptGCHjfFHPLh+RsFLmezh+4ygK3Jgn/yg=;
        b=NXnJu3k+rZ5HWQdhd6YJL1ZcA2W1fLqQPl8gxm6VAt5mFHA9qo1KEdJNyFOcditd44
         zN3cydjN6R8KElUtIa8SBRYCYXM2gLFQC/RQcwNeLCUpEx4cdtPqgcSMUzQKvwCuFCeg
         anxBm2N6Nd3t41CT5slq7Os1pV8w3cNcDRpX1+A8dcsbuELB7DUcumqfa45D9JUFpldp
         eTJxo5DsXsBYfl0hNb2r7RqTq+OORY0AK+MIr5/+j+Ck1X7LAYk4BncMauE2iKrh6jUr
         891TdEV1sZViz8dkf1DUFSn3SOJPntzskL1TCCk6/X0IYvOGBYW/WVMKQktrJ0/W6ULF
         t9mw==
X-Forwarded-Encrypted: i=1; AJvYcCXhS+nj6hehpng4lc/P2C9LXrFv1gdm0aftg74265PLSbWvmVbW3bJ70VB/4qcUhwVTiq68Q6qy@lists.cip-project.org
X-Gm-Message-State: AOJu0YwwQTx7FDtnQwPinzjjNShMUeCmTl5sRX3seSdLNZPQEUhIIKPf
	+3fBnNywOLZ7GHBzzvKOPQ4SwdnjiQGSl3mnU/JO+LJ1t4bKPuKzv9iJqvZvbiY=
X-Gm-Gg: ASbGncus2PKAfe3gnEfnnVPP+uF+xD820advQM/aGJAJU8yuW5DvAUK9tz+cjrGGB1d
	n7QsOVmOUVElLY7Ql5OzazInuPwJaIb/mAoaa8ArTLGVaMS3bbiNN5FFJmw3JaoAFWwxj6dOgCk
	Fok5mS1Hf31ooS7RLgMxkHb4olRzlDlFXfFzdmgV1QcTP5BX+sIvW2nGW1aVIRrh+RFDvJT6+vW
	XYxLtGkHwMPxfUNlFbN8ToS/tXSlSzYtoltM7H2AKiLqkHjYSDCHnVg9bGl2igmwqDtz8IhWVX8
	7Cje6J8bXE0=
X-Google-Smtp-Source: AGHT+IGMGbFfrC3Z22HJurGDWHeQjYf8GtoOUTPjHKkwqk7Xn5FaI9l+8sE7pgzAbclWxjuafOAb6Q==
X-Received: by 2002:adf:f545:0:b0:385:f409:b42 with SMTP id ffacd0b85a97d-3888e0c0831mr8465371f8f.53.1734354381174;
        Mon, 16 Dec 2024 05:06:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801233asm8346252f8f.9.2024.12.16.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 0/3] pinctrl: renesas: rzg2l: Fixes for suspend to RAM
Date: Mon, 16 Dec 2024 15:06:16 +0200
Message-ID: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17423

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports suspend to RAM fixes for the rzgl2 pinctrl
driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  pinctrl: renesas: rzg2l: Execute atomically the interrupt
    configuration
  pinctrl: renesas: rzg2l: Configure the interrupt type on resume
  pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.43.0


