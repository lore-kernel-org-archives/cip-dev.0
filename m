Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB5CD13D3
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 08:10:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15364.1777536623934152823
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 01:10:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MQ+mcZaK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 616DC11316E;
	Thu, 30 Apr 2026 10:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777536621;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=03YSAbNZm2SNZ2ZaZacjy92VvilJfZv3cR0zarXU0b4=;
	b=MQ+mcZaKt/h1vUmbEAk9a1wo/D/idljAWEj+KGHZUy7tBlBbTFXMljTmASiFHMrNKPdj5f
	+kffCwWcYUrwVgp38x44az2r60lSJbrjJKTGY7LIBO//YnSzaymyWUTngf9GgsvaJmySki
	6DIwQTr7UY5J3hR8LnP0FVIpOApszmGBJc+7I+846gUi/+rgEgffPZYuk7CTW3HOCQ/Trr
	9hZIFmQnXdjKQW9pJjLmmgziBYYQ1HO86TKkp1Fo3rSQIb7ULmLaD/FnXEpHJDoGxoE7Ry
	mMsKepNL8KDx7nAVn8LIWnAtmB1oz0rguwoz0dETjg38AEWEiV8QyuvFMyneGQ==
Date: Thu, 30 Apr 2026 10:10:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: pavel@nabladev.com
Cc: masami.ichikawa@miraclelinux.com,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: "Copy fail" -- Fun CVE -- CVE-2026-31431, likely should do
 out-of-schedule releases
Message-ID: <afMOaPbHBf806Ypb@duo.ucw.cz>
References: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
 <18AB121F2F67B74D.2435051@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qnu4PQk1vLS3svFN"
Content-Disposition: inline
In-Reply-To: <18AB121F2F67B74D.2435051@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 08:10:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22826


--qnu4PQk1vLS3svFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Apparently there's new CVE with a name, and when a CVE has a name,
> that's not good news.
>=20
> https://nvd.nist.gov/vuln/detail/CVE-2026-31431
> https://xint.io/blog/copy-fail-linux-distributions

I assume it is real.

72548b093ee3 -- place where this was introduced

a664bf3d603d -- is the fix

This is another remainder that running untrusted code on your machine
is a bad idea.

6.12.84-rc1 -- has a bug
6.1.170-rc1 -- has a bug
5.10.254-rc1 -- has a bug
4.19.325 -- has a bug
4.4.302 -- likely too old to be affected

Fix does not look too bad, and I believe this is significant enough to
warrant out-of-schedule releases with a664bf3d603d included.

Best regards,
								Pavel

commit 72548b093ee38a6d4f2a19e6ef1948ae05c181f7
Author: Stephan Mueller <smueller@chronox.de>
Date:   Sun Jul 30 14:32:58 2017 +0200

    crypto: algif_aead - copy AAD from src to dst

    Use the NULL cipher to copy the AAD and PT/CT from the TX SGL
    to the RX SGL. This allows an in-place crypto operation on the
    RX SGL for encryption, because the TX data is always smaller or
    equal to the RX data (the RX data will hold the tag).
=2E..
    Tests covering this functionality have been added to libkcapi.
   =20
    Signed-off-by: Stephan Mueller <smueller@chronox.de>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

commit a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Mar 26 15:30:20 2026 +0900

    crypto: algif_aead - Revert to operating out-of-place
   =20
    This mostly reverts commit 72548b093ee3 except for the copying of
    the associated data.
   =20
    There is no benefit in operating in-place in algif_aead since the
    source and destination come from different mappings.  Get rid of
    all the complexity added for in-place operation and just copy the
    AD directly.
   =20
    Fixes: 72548b093ee3 ("crypto: algif_aead - copy AAD from src to dst")
    Reported-by: Taeyang Lee <0wn@theori.io>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

--qnu4PQk1vLS3svFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafMOaAAKCRAw5/Bqldv6
8tBVAJ0QtgNQoMBWS7uRXZhelM3s5hLo9wCgm9U7D+jXwkUfrH29qS/9ironLj8=
=pgi4
-----END PGP SIGNATURE-----

--qnu4PQk1vLS3svFN--

