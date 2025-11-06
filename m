Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD9CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10104.1762416753900360290
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cc0hL2qq;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bcddad32so464984f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416752; x=1763021552; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn2ch+CBfvCjhPkhaAD+IvpbTQcWSIXGygjRky+rwZ4=;
        b=cc0hL2qqWA/en2ucbEvWFRlb7lGFWSsDK1Usfl1YNNFdzLA8CL3/wR22y0QZ5v4oEl
         m08PFD0c/9xDfiETC0sQ1KMh8hdHf6IzCGGKdiaB55MYtBsKh3CAHdTWi5tkvGA5QoYs
         jC2boXFJIR66pTMXcR0HgMA57mfDSRsTBO8x4lvlCGXIP6hmLG7A3ONBlALBXAbzYnb9
         XOy7OmM+fxQie/Azp9Ic9BsbubwLrEeXgDs0gDK9YRrMCLdS/Xbg8GFbjimcKVGC5ylR
         VzABVhez94SQ3eWY9qyLvo4GrNELJwxhawtQXNTrmwY5lPRQ83jMjr/GW56Gavz17Pdz
         NYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416752; x=1763021552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn2ch+CBfvCjhPkhaAD+IvpbTQcWSIXGygjRky+rwZ4=;
        b=IJmAbmCvC19sINCDLziaSLMqxQoryceQZBzyN5/BxgkRuqcQqZDjtgitCa/LAFfnyx
         fC4M4aYF+bJeGezvraFiYbicSh7R9yffnh6maFSQwH7+6kCdLbd0lrkBXGbR7S3jfn98
         grKXEQVidVNBq19nAlRZqlEIjb19+EIFMh8V+upzjvcXWSGWHk9NWzPE9lWGi4ie1T0j
         jwkaduUrEcrkq3Yv2IS6o3bHW85YapzBRfC2AHImwN7Vgxzyn9jUI/wBJ55IImRQ5R0f
         6X+bNxdzhzDKiskrBG2w5wc+50eBQShw4BrblyPtA6CslmQu5sweCQ9avdS4RdVVy5NT
         s8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwzfz7Hjb/EFgu6lVmHQ6If6lU0p2eea0ixsJFUd8jPEM0VX6E8NaQBGC2oDZw9KVbRmGVpREt@lists.cip-project.org
X-Gm-Message-State: AOJu0YwvZOlAwVerFuqjAPYjLjM41B5yCAjYrgkpB5jYkjeMrkTN6er1
	pAZ93OMjjRwliFLp5VkDoPHBFtj7zga0PUUb1As4cv7Cx+FdleWT4dgkzAGY0hOXS3BhZUZajOx
	ZCbO3JcI=
X-Gm-Gg: ASbGncsRdv0Hv1U7OLcy1pIUICCEBGOk7oGU1NljA9hToHELpcFMH0OMaTgMw2bDpXF
	j6X9wSXP3NiRmdQv4o6fR4URk0WFC+jLPW0soqILvrAeHi2YeTKo5NDPCvIG8C+VP4dOVVgaQy3
	yVNUY+mXPKrUsX2rx8Crq6TFbX9qh3WiNQvG3qmID8pyahKTO/epKPj0/kKh8Yii+B62cCcJyz+
	kWJkuIfHiq0ARHN1vpVt8RbARw/lBhHmvyzouZ9i0Vt1cIh8fkBGl1CryHwOeqHC2DTkk6OmLyN
	JB2BANjRLR4OyO0G6KDXZNN1hUs2vdmIDOrbQXiVXIvsDoZkrcs92HkhppWW1WhmJtRrXLD/g2s
	nP0MciWirn32cAOTRej3T3YAMWjzY/DlBeGyLZqdnBliFEe+s+rFdTJS2JLbWtST17eeRbR92oX
	eIBr8IAV8iCpjE/DdnoPWBX+ZoluHO+2051Pb4EYK7
X-Google-Smtp-Source: AGHT+IHDO+JT9ABHvnep2GpT02Redzyw5Tv8JIMXV35hiyx/SW5gvsPu53HX1g04UNDy7jvjOJ2Pvw==
X-Received: by 2002:a05:6000:2681:b0:426:d5de:e454 with SMTP id ffacd0b85a97d-429e3305fd1mr5106054f8f.31.1762416752306;
        Thu, 06 Nov 2025 00:12:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/22] soundwire: bus: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:05 +0200
Message-ID: <20251106081218.2574950-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20426

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 969bf687c12cd9f64ed9368f0c7429445de7c10b upstream.

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - fixed conflict by keeping v5.10 CIP code
 - drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soundwire/bus_type.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 3c7b12b130ea..d012b631e9a9 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -109,7 +109,8 @@ static int sdw_drv_probe(struct device *dev)
 	ret = drv->probe(slave, id);
 	if (ret) {
 		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
-		dev_pm_domain_detach(dev, false);
+		if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+			dev_pm_domain_detach(dev, false);
 		return ret;
 	}
 
@@ -151,7 +152,8 @@ static int sdw_drv_remove(struct device *dev)
 	if (drv->remove)
 		ret = drv->remove(slave);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 
 	return ret;
 }
-- 
2.43.0


