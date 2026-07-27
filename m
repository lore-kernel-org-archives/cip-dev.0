Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE7AC53219
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 12:40:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30164.1785156049586803797
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 05:40:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Qu8rJQwa;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD8ED118E23;
	Mon, 27 Jul 2026 14:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785156044;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MFlDju3vdWFx19DEex31/k5ZGKAiDQfUrwBQ5flpTlI=;
	b=Qu8rJQwaghmxBWKWlsFZ7oFd3i9TsG8TepCM6zq9z9crOe1KytyuCVs5j3UeFkII4z7j9w
	9DQC/x0eBA+88ACu50JNPJuGznUfzdrB5BLLMzQQeqthJw/GiSJyh98ZTdb89DOmq6RD0s
	kFCJcuwkHxyPEU99KlpcaRp+amvRYRBZLGS+RhGnkdixiE5BSNBhQLG+ae5R+jaPPqgUn+
	wzsBfghpm+nGCoj3YWbfh1ymZHGAyCiadV7pSX3a7KqHy+qHS5s7rAhu0chMCB1vPy2ptI
	turmkL3aKBSf0fHri2FoEERW2egQ69ptFd2brIo9Ka0ad0J5pwobTNAU8pC5qw==
Date: Mon, 27 Jul 2026 14:40:42 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip v2 00/27] Backport RZ/G3S USB support
Message-ID: <amdRyvFNnVoYO2V_@duo.ucw.cz>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+BVZ8oBKwAau53lw"
Content-Disposition: inline
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23761


--+BVZ8oBKwAau53lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Patches backport the Renesas RZ/G3S USB support.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--+BVZ8oBKwAau53lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamdRygAKCRAw5/Bqldv6
8iBUAKCSMKvFam3DA0sPbO4jsA0WibWmGgCfWRZRJNAi2q4C34rb1/d5bGKr6w4=
=k58Q
-----END PGP SIGNATURE-----

--+BVZ8oBKwAau53lw--

