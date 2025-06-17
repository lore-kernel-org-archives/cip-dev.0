Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEFC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 09:27:20 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.14663.1750152433744114486
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 02:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=SE6W5EmO;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F6CE103972B9;
	Tue, 17 Jun 2025 11:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750152431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8tsRvtefdURmGRvK8wgBp9tyd1zj/wns4kkBZmGJnL4=;
	b=SE6W5EmO8mIA++XxONXNBExcoVEcJN9YCxsh6oy5C48dGzSeU1EaB496lmCq04u0E+Yflo
	ct1sxlOnpxlHssX2SJgsTNA7JtKIXk0XT7An0ALxT7j3d8ipw0Y3TZUlBVjTW5OGxYmeri
	vzvcgXWOCpeJ44c9Qv5iyla9nzXRrfa7yZjxtMgzwICfXbonSuJ9rwq0XblYsNQ1AppA/L
	IZ0UALpdzL5QtfKDKX6LZBm+UR1aUBWh9jGwzH/J1O4Z3IMW+x+NS0mgb9yIn/U/ll7EeZ
	hNjiHfFn6dQ/H8mKY21g8lj2P2yV7a34+z1TmFUpWrml6o/5JdpbPx4HlNTwzw==
Date: Tue, 17 Jun 2025 11:27:05 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st65, 4.4-cip100
Message-ID: <aFE06VzaBSMttFH9@duo.ucw.cz>
References: <1652754680.135113.1750092922654@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zlnq90S0jviVxEBb"
Content-Disposition: inline
In-Reply-To: <1652754680.135113.1750092922654@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 09:27:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19117


--zlnq90S0jviVxEBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the upcoming 4.4 kernel release. As alway=
s they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/=
linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

One patch is not complete, the rest look ok to me.

a > 8dab9bb642b2e net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
> 6f43c571bf094 of/irq: Fix device node refcount leakages in
> of_irq_init()

4.4 has one more place to handle, AFAICT:

                        if (WARN(!match->data,
                            "of_irq_init: no init function for %s\n",
                            match->compatible)) {
                                kfree(desc);
                                continue;
			}

(Being behind WARN(), it is probably not too important).

a > 7f406a4c1fd70 mm: add missing release barrier on PGDAT_RECLAIM_LOCKED u=
nlock
a > d24045205aaa7 media: streamzap: prevent processing IR data on URB failu=
re

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zlnq90S0jviVxEBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFE06QAKCRAw5/Bqldv6
8geNAKC2auOzHmEAU7kw4eklCh6nBNsssgCdH82IYZAsrkemnnDy9BgfByHoXE8=
=9BGU
-----END PGP SIGNATURE-----

--zlnq90S0jviVxEBb--

