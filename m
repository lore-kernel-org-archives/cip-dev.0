Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E6FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 08:52:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15879.1777539177331187732
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 01:52:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=U3YruhMo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD176114B26;
	Thu, 30 Apr 2026 10:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777539174;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=c8sB63elglmQzhuFZM5oYZjzqGC1Qm9SqtsYWT+In1U=;
	b=U3YruhMof6OO3pSOrgDLmkkaOnpaOl8vfii6ry/kNBdTKiSrOCmOur9B4/EBupSg2lSg/J
	AfwqM6Xsz5JGAm4w13BQFY6A7iztnCnIrA/khapEsqotdTispGI1NO50Kbrcd/QtfhrNIv
	Bc13/+1P0Qk2QeC2icT7uktvd5dQk/qIEQ6x7uLZjSl1vvQVO1vlqGNHPVW8hs59wQdr10
	RjKSR0+AR5nQA/JketC4RajWuSFNjPwzWhEUK3KnkFgtPdRS3L5Jor++3IlWFnupbewxgC
	en17VGWQnlSO12o4YhiBwspu9a+aBCdgJ9XUiVpG4oy8mPBS/fKB2zSvU24PdQ==
Date: Thu, 30 Apr 2026 10:52:52 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: masami.ichikawa@miraclelinux.com,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: "Copy fail" -- Fun CVE -- CVE-2026-31431, likely should do
 out-of-schedule releases
Message-ID: <afMYZJ4CQynbitnJ@duo.ucw.cz>
References: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
 <18AB121F2F67B74D.2435051@lists.cip-project.org>
 <afMOaPbHBf806Ypb@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kmb0Z28i8VhXBHxL"
Content-Disposition: inline
In-Reply-To: <afMOaPbHBf806Ypb@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 08:52:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22829


--Kmb0Z28i8VhXBHxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Apparently there's new CVE with a name, and when a CVE has a name,
> > that's not good news.
> >=20
> > https://nvd.nist.gov/vuln/detail/CVE-2026-31431
> > https://xint.io/blog/copy-fail-linux-distributions
>=20
> I assume it is real.
>=20
> 72548b093ee3 -- place where this was introduced
>=20
> a664bf3d603d -- is the fix
>=20
> This is another remainder that running untrusted code on your machine
> is a bad idea.

# 6.12-cip:

I don't see fixes in the stable tree or queues.

Cherry picking f2804d0eee8ddd57aa79d0b82872b74c21e1b69b allows me to
pick a664bf3d603d, and looks like good hotfix for the bug. I'll push
it for testing.

Testing as 51d7d95a40bce11143de82150c2ff9372e3c34c4 .

# 6.1-cip

Trying to apply f2804d0eee8ddd57aa79d0b82872b74c21e1b69b fails, but
rejects don't seem horrible. I probably could apply a664bf3d603d; less
problems than 5.10 below, but I would not be confident in the results.

> 5.10.254-rc1 -- has a bug

Trying to apply f2804d0eee8ddd57aa79d0b82872b74c21e1b69b fails, but
rejects don't seem horrible. I could apply a664bf3d603d on top, and
somehow could solve rejects, but I give it less than 30% probability
that I got it right.

ae383e1448e2a9c5341604099680b7af86122aaf
https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

> 4.19.325 -- has a bug

Trying to apply f2804d0eee8ddd57aa79d0b82872b74c21e1b69b fails,
multiple places, seems even worse than 5.10.

Best regards,
								Pavel


--Kmb0Z28i8VhXBHxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafMYZAAKCRAw5/Bqldv6
8iWjAJ9mCPeC9dSIX7Nl3oQYlZSVlylUpgCeOZSd4XgAM5I6uhC/mS3OKeuWmng=
=5kek
-----END PGP SIGNATURE-----

--Kmb0Z28i8VhXBHxL--

