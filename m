Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA8CCA464
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 10:24:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18746.1792146294190151041
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Oct 2026 03:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gNnXCVZr;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0574B105AAE;
	Fri, 16 Oct 2026 12:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792146288;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k5kED7laQbG4WoaeLyc9pOdikfsqAiW9BaHO+9/oBI4=;
	b=gNnXCVZrEi/cJAJVsf/piDFqSsU5W+4dLrQVoMxfI+K8RhL3lw9QgzypDityL7jmFoBd6M
	jXTa4JVFkLSWuxl/AEA5NmtWIl53KNLaDWCxE7oG/RbbXRQM6HG/YsGZBB5XHShR5ymhiY
	HpkadyCpPa8GTcR5NdI9GPAKtcfdaW+cmgiQSStSLHgpoWa5oTxuFAkhOpKVrOI76/Xr/I
	VSX6MkU+RStpoz7Rsi++H+6H8yrVPiH1STV1Bejkh8NeKpWWgti/h20pABYaR9ptbxWOw1
	7uiTa/04eTrJhm1T4tdmQ6vUfku1uO/9Mje+5BoMh07jad7kR7Uw1qo/jzh4EA==
Date: Fri, 16 Oct 2026 12:24:45 +0200
From: Pavel Machek <pavel@nabladev.com>
To: bot@kernelci.org, Chris.Paterson2@renesas.com, kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, cip-dev@lists.cip-project.org
Subject: kernel ci results on the mailing lists was Re: [cip-dev] [STATUS]
 cip/linux-6.1.y-cip-rt - 407b1406d2fad2b7ac279f28757bbd06e1d541dd
Message-ID: <atH7baHpQxrGTH_F@duo.ucw.cz>
References: <179211780515.391248.13476473435623274437@244668f92ec4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkHHvo/9xAoKpmpK"
Content-Disposition: inline
In-Reply-To: <179211780515.391248.13476473435623274437@244668f92ec4>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 10:24:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24479


--LkHHvo/9xAoKpmpK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please drop automated mails from the mailing lists. Bots on the lists
are simply not okay, humans are trying to use this for communication.

Plus,=20

> https://d.kernelci.org/c/cip/linux-6.1.y-cip-rt/407b1406d2fad2b7ac279f287=
57bbd06e1d541dd/
>=20
> giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> branch: linux-6.1.y-cip-rt
> commit hash: 407b1406d2fad2b7ac279f28757bbd06e1d541dd
> origin: maestro
> test start time: 2026-10-15 11:08:26.524000+00:00

Okay, so now we have test start time down to microsecond. Useful, I
guess? But what we wanted to know is if the tests are finished, and
this does not tell us:

> Sent every day if there were changes in the past 24 hours.
> Legend: =E2=9C=85 PASS   =E2=9D=8C FAIL  =E2=9A=A0=EF=B8=8F INCONCLUSIVE

> Builds:	    6 =E2=9C=85    0 =E2=9D=8C    0 =E2=9A=A0=EF=B8=8F
> Boots: 	    9 =E2=9C=85    0 =E2=9D=8C    0 =E2=9A=A0=EF=B8=8F
> Tests: 	   19 =E2=9C=85    1 =E2=9D=8C    3 =E2=9A=A0=EF=B8=8F

If we want to do testing before release, we need to know if the tests
were finished. We can take a look at the web page, no need to spam the
list. (But it would not be bad if -cip page contained results from
-cip-rt, so that ...well, results are on single page).

https://dashboard.kernelci.org/tree?i=3D60&ts=3D-cip
https://dashboard.kernelci.org/tree?i=3D60&ts=3D-cip-rt

[What kind of unicode trickery is these? Do we have to communicate in
pictures now?]

Anyway, proposed solution is to add another field to the
https://dashboard.kernelci.org/tree?i=3D60&ts=3D-cip-rt page, right of
"Test status", call it "Finished", and it should show true when tests
are done, and false if tests are still running.

That way we can pause the release until the tests are done.

Now,
https://dashboard.kernelci.org/tree/cip/linux-6.1.y-cip-rt/407b1406d2fad2b7=
ac279f28757bbd06e1d541dd?df%7Cts%7CFAIL=3Dtrue&i=3D60&p=3Dt
contains failing test. If someone familiar with kernelci could tell me
if they consider this to be kernel failure, that would be great. On a
related note, ability to display logs without downloading them would
be welcome.

Thanks,
								Pavel
--LkHHvo/9xAoKpmpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatH7bQAKCRAw5/Bqldv6
8rPHAKCVHGRAJqDxH8C4kMPn3dbMS2sBkACgpIvqy7pJmd0iYMyVNavRETlL9o8=
=p5JQ
-----END PGP SIGNATURE-----

--LkHHvo/9xAoKpmpK--

