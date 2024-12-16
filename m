Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BC5E77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:07:09 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.56104.1734354424082282028
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:07:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=el+sDpXK;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38634c35129so3206254f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354422; x=1734959222; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KomaiRhKj1ptGCHjfFHPLh+RsFLmezh+4ygK3Jgn/yg=;
        b=el+sDpXKtoD327V4VjKGUee9wbrXldtw49OOCwTi5VEZ4+PsPKKkBqC2XrTy5N2SbV
         CZrIgb2+7SJQ76TCgM4O1nEHQn1mdPAEHW8SWtr88q50e/tsI+m4mPsupr9zsMfYMoMB
         QXJ7o78IiS+2LviawWoefa70ndAfXtRH4pzfLEyGkLTFCtRWikvG0o0p6p3/nnDeprpa
         q7aj/Ea1MXBqFt7EIh621PvSeoF2bZ01IPTK1pwrc33xsdwEKhnhU8tTTC07nUmTmLdm
         EN2RDVUQltFLCLRDHbRo9Hd12ziewbfUHD7sfyGEjUIcz+cOD38iuC5jRr2j+OZrpYbg
         zKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354422; x=1734959222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KomaiRhKj1ptGCHjfFHPLh+RsFLmezh+4ygK3Jgn/yg=;
        b=wGToaXUzw44D5P8+VTYmQji6t6QGLl/xXTAWxrN4J/lHK2nP9vZ4NO5c0+r2ODXwTq
         0LVhLkflHGW0kZxVWk2nE6LTyZ2O/MKS2txo0GvzrW9MRh5WYsY3u0ErqGuC/7WUZQLf
         zCWLNaDrhKnC1WYjQdPLLVQHdJeE+8mIzxoTfjMLawHbwuWSALQgcfGLfSSzkDuV5aMY
         9b4j3/+xFrJOTYLx0qvihxqtITWc89GSOnnXt4zuhA09nvtb4tTrDhhy9SEMJbQRUoGT
         BX5P/rNjqI+uKu4qpeCAMCNfohfn4AVVXRYB9ZWLOVZkQ5vDWIyFnTTWrKaSkgDpXG37
         X7cw==
X-Forwarded-Encrypted: i=1; AJvYcCVfsg5Af9o4vcPR+kSw6MCMxWOCy3oUTRPBOjY1ZrKQ2AAkeOzw0tx27DSQdxw5v2t4YOHPVMEk@lists.cip-project.org
X-Gm-Message-State: AOJu0YzAosQ0OF1l6gjAAMe7GkG/QHb50+yfeTJqUoJSOIHgD4yEGtj6
	KqxNaOHwcgkId8Bs9gun1DkGU8orjSd5PzMPUdLpw3rVNVQzUgC33pkXKsSeYw3uyrxj+jUibfO
	i
X-Gm-Gg: ASbGncvmBcKJHmmn1QTfDbsliOxcyT7G/H0i6fnFRa8VvFOK+Fq8o/1PdbOFgpBYpkj
	2LXRhdyLIiPhIAVQ7yviKNfxqkZPMK4x5trmtTpqfbdF9MctZh1bAKjB/4L8QajsnP83wtHaBhG
	//pNtpq5p3FYyporDv2eNvnrcOO2yciM+dBot3qMDWR9jN7DB1o6HOTyQBNoihESjpUnpB1zXci
	yqGVDfRpWdkXntSZAOvDOCVBOdU55vauCw4V1nXr1JTkLWWx058NssysnaRlk1TSmHQn/pveeBu
	j782TaiaRso=
X-Google-Smtp-Source: AGHT+IHbq58UlY+HlwOTH4CfWmWqxl47xdCdtvR1VgVGQzdMc0mRg4KqzuaHkmx0YeJt1p6kSrkCNA==
X-Received: by 2002:a05:6000:4025:b0:385:e034:8d47 with SMTP id ffacd0b85a97d-3888e0b98f6mr11520322f8f.46.1734354422305;
        Mon, 16 Dec 2024 05:07:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806115asm8031374f8f.107.2024.12.16.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:07:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 0/3] pinctrl: renesas: rzg2l: Fixes for suspend to RAM
Date: Mon, 16 Dec 2024 15:06:57 +0200
Message-ID: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:07:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17427

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


