Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B9104BEC4
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:06 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17644.1773223503539840377
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FVb4xaE3;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439ac15f35fso10337955f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223502; x=1773828302; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTreNAs3ON+xtKgLZuRmRUsIUIft59+OGiTbNZlAjrU=;
        b=FVb4xaE3pZ6x4jfpX2CXh8NAQfA9syLnYbUR0hWJbzZHOvu3Kbx/gmpLccs6p5+hPB
         4drrlb9Gi9Bou7967bVhcTTtzYADro6azHOS5f84xuHhkpavkxyCcxiwSfmqXR/pYP0S
         cQOu8UU0nMLvGQsAOj+L/ldQqcfkliHw3UYLMJtwROjvVYXfulccnGocSnnRzGXzCsF6
         XUPk7SkLSvQjYdESDWQzeHBlss5KoVk9+0/z3GSD2/WmjwZok08seSXDiBgigWYxIUDx
         G3AABX+bR2sULFgvyXmwfEz/55V0+ULFCKpnjye58Cha6Y2UK8Am/mfnNq3u3vVCtvTi
         4Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223502; x=1773828302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTreNAs3ON+xtKgLZuRmRUsIUIft59+OGiTbNZlAjrU=;
        b=mTZC+DP8G8LicONgwZ74JTF2LKohnSAWP/G44iCP8XMCzYByul5mENBAuDPDzlXlMT
         FZwSvY5LrP7ITffT4EVR3uXVVBoG+F816HBqnbZDTIvF7YWnBtfq9Y72fExBiCP3b0Yg
         dyyyKUMVM4r7QdQ/RAQZRtvdBNX4W4so4xZDMP5zOZ3H8nC1XKVJHLzJhsHk5dcPKW3A
         8zhw+5wKzkn5nrKkejGwQuONwL+msZqayA5SWjsMEOabtPw6OlPPVYisQvLa53OyAJ/N
         tteROkx00HKOQ1i8cj2I+eg2zi2B5T6RZoNDzkTAHmNYaDr9i20uBWqJOiEZmb570FiC
         YD/w==
X-Gm-Message-State: AOJu0Yx60fvVvKaAg9v/nrAPBOZ+FpbuVEoNWq53IguUdDFzJDEgAvtd
	mfBgfuk2Qn+YXgCNeRLMFzaGKQT6hSndVUdn/+BZf/VBIfk/p+4mVtT97OCqgw==
X-Gm-Gg: ATEYQzwG4UCWbiVW5sqX7u4X3sNeM9B7tEwcevHwD0Q7hHwa6OV1Rp/AiUCvNa1WmUK
	oVFEhRW8W5q0ZsapuYIhHeIZxPFZOqrK2K7vmGatKQgdmPnH0mwe7qWHPUKXmUUW9COQtZu8qNU
	6FYw+I3mItm6uK61aSmqTieneXOocEqq94jnBP/R3O+kUaB62uS9Abqm0bLcTC3YujtqCEj52E0
	s+a+js2zS2HVWNfPClYCjkJI0BSL7XeVgkLKIphQOmkI3LkuiNhubo08eGW2nQukxYsOLWVXfQV
	yxJUiPVYm2Ftfl4OzSkhg+oWfQbrE8IFup+OIyQIjKcQupfLUQUAK9cEn85SWML6LnBqItM6WYe
	PnAV9O5ti7Xbg+W0nPNk1Vy99FZCXHzaz3k3mI6K5s2mjGgdgiZj1HGwTbTYz4OidyOhWVG4Uhf
	OOWTMlMYnYySD+Lgeo6+MgnxEweE111b0=
X-Received: by 2002:a05:6000:2906:b0:439:936b:bff4 with SMTP id ffacd0b85a97d-439f8439118mr3710496f8f.46.1773223501357;
        Wed, 11 Mar 2026 03:05:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 04/27] serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 11 Mar 2026 10:04:23 +0000
Message-ID: <20260311100458.162447-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22250

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 65acd0d86f2fa104fc0a0c9d86aa1ee6b1a4763e ]

Convert the Renesas SuperH SCI(F) serial port driver from
SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().
This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/a5628fe028362ae3f8729021a7864dd39f7869bf.1752086885.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 03d248b2d8da..4e094d8ee882 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3752,7 +3752,7 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_suspend(struct device *dev)
+static int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3770,7 +3770,7 @@ static __maybe_unused int sci_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_resume(struct device *dev)
+static int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3791,14 +3791,14 @@ static __maybe_unused int sci_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,
 	.remove_new	= sci_remove,
 	.driver		= {
 		.name	= "sh-sci",
-		.pm	= &sci_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sci_dev_pm_ops),
 		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
-- 
2.43.0


