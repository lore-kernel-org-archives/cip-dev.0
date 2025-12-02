Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB2CFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:56:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4347.1764669363253038929
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:56:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=Mh0QRrGk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-68982-2025120209560051f05dfcc6000207a0-zcr7zy@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025120209560051f05dfcc6000207a0
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:56:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Y5v8BQCk3UIruOwBcjMbkzm9qkv8HIdrEYDQMPd1yzY=;
 b=Mh0QRrGk6rK5ALuSnvA/Gl3rHkxIwsL7Na3RFIz6zSi1Wqd/0uukg8kR2Xa3lBLMuFHIlH
 x/X68pYD3xDq048get+A8ww+emXWVYQCAYufRiAucqWqJeHeekjGbUBZ3KEmJjijtk4w9wxl
 tJtdTMg6SO1UlumQiyp1xtKFlqRysl/NPDRsG+hG70pRvWTdDB12wsrUD8Gk6u1e5RatsPzv
 N2bKSahJ456y3m72h4XHbwpscCARS9pOeptkSjvD0w18Yt/D5S5PhwPuXG4YZ4WTpWLZQu6e
 bWT5akMzXO0by3g/TaggqDnuOSUenTIT8NB3qbB+eyqQdyNgZjfkkLtA==;
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 10:55:59 +0100
Message-Id: <DENN2WDIIV2G.1W0RTBCWK231A@siemens.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 08/14] Kconfig: Do not offer
 swupdate or security options without a kernel
From: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
 <6b42744057af96e3f1c00918aeed3c5ad2e9202b.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <6b42744057af96e3f1c00918aeed3c5ad2e9202b.1764667279.git.jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:56:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20806

On Tue Dec 2, 2025 at 10:21 AM CET, Jan Kiszka via lists.cip-project.org wr=
ote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Those variants only make sense for full images with a kernel.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Kconfig b/Kconfig
> index deb6044d..f8a93c2d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -258,7 +258,7 @@ config KAS_INCLUDE_TESTING
>  	string
>  	default "kas/opt/test.yml" if IMAGE_TESTING
> =20
> -if !KERNEL_4_4 && !KERNEL_4_19
> +if !KERNEL_4_4 && !KERNEL_4_19 &&!NO_KERNEL
                                   ^^^
Missing space.

> =20
>  config IMAGE_SECURITY
>  	bool "Security extensions"


