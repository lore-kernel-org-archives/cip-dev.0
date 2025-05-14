Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED3C3ABCC
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 10:02:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.98918.1747216954141937406
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 03:02:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WZPbIY37;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4153310692226;
	Wed, 14 May 2025 12:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747216951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tMbkST/7ur0wtwuaQIAGck9cjugsaL69nrF8gbIlWco=;
	b=WZPbIY377WN6qFT3ecSaanifoSRBmWuuhrAPfzWZSqqxmCWiuCktf+0/1wsrqvhGLLD9u3
	rcQtzRv7P62a9KRmRKxP522R2TNtkEiZhImcS6VlmG6FfV7U7TJ2gX/+5aSWk+VyZPqumX
	7Sd7kS/YGUTa3Pf9IIt6sDpm4hrgxixjShNPspSrVfCD+/TbuNAUPJH3SsvtidyYYX4+eg
	vT9cQ/z5vKcOeFBmq7q0/eX6VJHbA+mIlr2Qz+k4CIJVrlJuEZTMmSzH2TIG23JOfcXGnS
	szjIrKzoWlGNYuukn4DPyIdQYhKAys4PAbsqUCbpGKleGnQpEqzVye/nLwms9A==
Date: Wed, 14 May 2025 12:02:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st64, 4.4-cip99
Message-ID: <aCRqMeCYmmC2pFVm@duo.ucw.cz>
References: <594897735.236352.1747215068214@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YuAvsppdD/9EJD17"
Content-Disposition: inline
In-Reply-To: <594897735.236352.1747215068214@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 10:02:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18906


--YuAvsppdD/9EJD17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the upcoming 4.4 kernel release. As alway=
s they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/=
linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

These are ok:

a GFP_KERNEL failures are mostly theoretical > 21503a13375d5 qlcnic: fix me=
mory leak issues in qlcnic_sriov_common.c
a just a hw bug workaround > 952bc6f3a0ebb HID: ignore non-functional senso=
r in HP 5MP Camera

Are you sure about this one?

!! > ece0f8e21aa7f net_sched: Prevent creation of classes with TC_H_ROOT

Unlike newer kernels, out: has non-trivial cleanup, so we probably
want to goto there.

> There is also one new patch that I added mostly for my own benefit:
>=20
> 18a3ce42a20f0 mm/sparsemem: silence "'mem_section' will never be NULL" wa=
rning

Looks good. I'd quote commit id in the log ...

    This is similar in function to the upstream patch
    a431dbbc540532b7465eae4fc8b56a85a9fc7d17 "mm/sparsemem: fix
    'mem_section' will never be NULL gcc 12 warning" but avoids adding
    extra checks to minimize the potential for regressions.


Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YuAvsppdD/9EJD17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCRqMQAKCRAw5/Bqldv6
8nTrAJ9+V4euvrqLA5T//vlFqdGU8tIdBACfXqBt9ipBHmPLpBf6TeXrDS0oQxg=
=9lCJ
-----END PGP SIGNATURE-----

--YuAvsppdD/9EJD17--

