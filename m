Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D041DFD3777
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 17:18:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50484.1772039911781544966
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 09:18:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EydckRVx;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBA0D1114D0;
	Wed, 25 Feb 2026 18:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772039908;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oHCWqs82/jHDp6pdxEb8VgYAcatd/aeRMM6X+YChbUg=;
	b=EydckRVxZrmychSLqlzyZYIbohDkpeV7lPi0USqlPxb34ovckFogIXPM/XpBqxKaRT7myp
	LP4auMEDkfH/Am0YDi5ekWYz8u7TCoxAxBRsDk280Ew7AduE9x6Jb4IZQ9nXdrR5NaJAj7
	g+Z9Ty4/f0QhNKt980vDjZ5i2zK/rM05FxTtfGrR2+G2Uxi3GZvZCwFqIZqqzre9kCzhJL
	jhzXQZAiIlCs5I4U3Oo/aNPyu+Gku2KJPN6zi262cCK43ywD3pHY09soMroQ+fPJNoFo7x
	zJNbamyHR7FAsrkQf52k2wfXnz3RYBuuUcf9NMosBylVAPF7HnNhP3nH7Ze4pA==
Date: Wed, 25 Feb 2026 18:18:25 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com
Cc: Pavel Machek <pavel@nabladev.com>,
	Stephen Ecker <stephenecker240@gmail.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] i915 in 6.12 kernel
Message-ID: <aZ8u4fd1dcBZ88O5@duo.ucw.cz>
References: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
 <9927e980-b0d0-43a0-913c-cff2bda757e3@siemens.com>
 <aZ7Gz00emqLIThnm@duo.ucw.cz>
 <4eb6eda3-2ceb-4f72-9bc7-f30a1974afe8@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xKq2p+TgGrcbbqk6"
Content-Disposition: inline
In-Reply-To: <4eb6eda3-2ceb-4f72-9bc7-f30a1974afe8@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 17:18:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21987


--xKq2p+TgGrcbbqk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> But CIP decided to maintain only a single tree with 6.12, and that mea=
ns
> >> that we can only accept backports from newer kernels. Unfortunately, t=
he
> >> i915 patches are still not ready for being proposed upstream. I'm not
> >> into their details, you may ask for more details on the linux-rt-users=
 list.
> >=20
> > Yes, applying the patches should be relatively easy.
> >=20
> > Impression from RT meetings was that cleaning them up so they are of
> > suitable quality for the merge may be more of a challenge. Suggestion
> > would be to avoid i915 hardware if you care about realtime and
> > long-term maintenance.
>=20
> For some (or all) newer Intel SoCs, the Xe driver seems to be the
> alternative that does not need downstream patches. I do not fully
> understand if it is the driver for current and future SoCs or if there
> is only partial overlap. Anyway, trying it out if it claims to support a
> given platform would make a lot of sense.

According to chatgpt, anything Tiger lake and newer should be
supported by i915 and Xe drivers.=20

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--xKq2p+TgGrcbbqk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZ8u4QAKCRAw5/Bqldv6
8vqJAJ9XjOUEhVu11pnaumWIyx/LCkeU+wCgkzDX9QI8O1BOxAWiQTFqTHIED78=
=7Aem
-----END PGP SIGNATURE-----

--xKq2p+TgGrcbbqk6--

