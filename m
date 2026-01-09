Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B785D26D99
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 19:41:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18431.1767987677170358971
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 11:41:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Fj4BwfqG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54B6010C196;
	Fri,  9 Jan 2026 20:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767987674;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uhOiWqnkVQC4i9Xma6upnsNJKqQejiR0l+Pqck1s6OA=;
	b=Fj4BwfqGCIfxxL9C1mPBwp5QoKtNCnhrnNXtxT3tlVYQsUnsbLppont8MUZhfACcngv4lm
	rzIj96ni3hAGH1F4F22JgNkKTsUNwEF1zscu0p3/4vhbDxzaJ4TZOkpXze+pDpHpLTFTxt
	QgOJSftUsR6S/eVCxU2MNZlyWJ5ENIXTwMrzg1uobONhnaqDJeH2TDJaB6fFOOumVHrN8x
	nr1L6Mx+coOPBvlQNXFBqLy9hOu8s0qiV+1aAcXK3satZGgx5MxbCb93QypccQIc9+xvh5
	E3Os7ikxhnB4twBxzKuOT7Hxh3oJ/T0QYTFpbQYvifm3LN5+AcPdFVIsDQMPZQ==
Date: Fri, 9 Jan 2026 20:41:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RZ/V2H RTC support
Message-ID: <aWFZ1h6xTAo2rMgn@duo.ucw.cz>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PnVzuZgNG8CHEa+v"
Content-Disposition: inline
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 19:41:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21526


--PnVzuZgNG8CHEa+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RTC support for the Renesas RZ/V2H SoC.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--PnVzuZgNG8CHEa+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWFZ1gAKCRAw5/Bqldv6
8nT5AJ4p4L43KcjwuKwLcg1LtYh/w5S93ACeIO1xsKLFl0Jb3iE7FRewYLmOiPY=
=ApK4
-----END PGP SIGNATURE-----

--PnVzuZgNG8CHEa+v--

