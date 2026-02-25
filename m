Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C0EFD23D
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 09:54:31 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42247.1772013268481820126
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 01:54:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jd5bSz/5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27211110B1B;
	Wed, 25 Feb 2026 10:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772013266;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=u82+gfVvpJpHSKiTdbBQq5ziShSv6se+yAqrf3SIHvs=;
	b=jd5bSz/5hLa7uU3wzQG4XVSyJfHad7Hs3KSEDE3tdToRf0iRyc/Mv/IE1RAtSn36aX8AjF
	PeHGW35i0IXyZRvLOc6fuKFwBN8o6c0+qN28+1Kt4uU5xxYWPRAWOBXa002RCNmz142GXp
	NJQH5TAdTQwrAecX5YCfeyVovDR51QpbBBKc1KYX6ouWfm9xeB2YolyYeIPfhPwfIykDwx
	iDSNFYA5LU6uFZ+3+DJR0b6UsOnCC3yITakLB1HKNPhxW26VwD7QKAK5T/lrxGJSWHnMvk
	oUlY3xrKzoDhjZzCUXe9Y+ahMnj1xtY3IaJ+RXr422uVHZDiQ68CvWPhm/9Ocw==
Date: Wed, 25 Feb 2026 10:54:23 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com
Cc: Stephen Ecker <stephenecker240@gmail.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] i915 in 6.12 kernel
Message-ID: <aZ7Gz00emqLIThnm@duo.ucw.cz>
References: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
 <9927e980-b0d0-43a0-913c-cff2bda757e3@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BWgbcYuNiIXo7zrs"
Content-Disposition: inline
In-Reply-To: <9927e980-b0d0-43a0-913c-cff2bda757e3@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 09:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21929


--BWgbcYuNiIXo7zrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Has anyone been able to apply the patches for the i915 module in 6.12
> > with RT?=A0 It was working ok in 6.11 when it RT was still an out-of-tr=
ee
> > patch
>=20
> You can pick them up from
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/lo=
g/?h=3Dv6.12-rt-rebase,
> they should apply.
>=20
> But CIP decided to maintain only a single tree with 6.12, and that means
> that we can only accept backports from newer kernels. Unfortunately, the
> i915 patches are still not ready for being proposed upstream. I'm not
> into their details, you may ask for more details on the linux-rt-users li=
st.

Yes, applying the patches should be relatively easy.

Impression from RT meetings was that cleaning them up so they are of
suitable quality for the merge may be more of a challenge. Suggestion
would be to avoid i915 hardware if you care about realtime and
long-term maintenance.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--BWgbcYuNiIXo7zrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZ7GzwAKCRAw5/Bqldv6
8jVzAKCBcuhDIRIKLyUd4rM38tW6z6j9zgCcD+XTmt287ZWwTYey/MX4gqaWyC0=
=PtoW
-----END PGP SIGNATURE-----

--BWgbcYuNiIXo7zrs--

