Return-Path: <SRS0=vgAL=HX=lists.cip-project.org=bounce+64572+6187+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EA7C433E0
	for <cip-dev@archiver.kernel.org>; Sun, 21 Feb 2021 08:40:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831D664DD3
	for <cip-dev@archiver.kernel.org>; Sun, 21 Feb 2021 08:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831D664DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6187+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZcsDYY4521723xHP7QPM0wRj; Sun, 21 Feb 2021 00:40:12 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17893.1613896811764173474
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Feb 2021 00:40:12 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BFD7F1C0B76; Sun, 21 Feb 2021 09:40:05 +0100 (CET)
Date: Sun, 21 Feb 2021 09:40:04 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Security from kernel's point of view
Message-ID: <20210221084004.GA27760@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EhcH38Cr4GXePIeAhQiDznTox4520388AA=
Content-Type: multipart/mixed; boundary="bOmUhrqoM3Am7xEWwBiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613896812;
 bh=tTwNL/5vegpO48Hjtg8sYEIBAafgb05w1Un77azoZJU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c6MIL3bK/N0oDYdRp/8XUXvV9Mku/EmxUTMt+X5J2nu5pPeX2awGUkPsDh7Jf++ajN7
 s1Allj7LEXrOmjXyUmwwgoparJCcAt1GeBj2zVLZfj64BXyLBOPO52R1VnflDt0uIFcdA
 //FA0jQbJFweZ6zk7SI1rLLHuulEaAOAyUU=

--bOmUhrqoM3Am7xEWwBiO
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I put this together... it may be useful for someone to understand what
the issues are. I guess I'd like to know from security team if they
find it useful, and from kernel people if I'm missing something or if
there are errors...

Best regards,
								Pavel

Good and bad ideas w.r.t. kernel and security

Kernel tries to provid many security guarantees at different
levels. Still, some things are easier to guarantee than others, and
some security barriers are really important, while others... not so
much.

Kernel should be secure against remote attackers.

    And it reasonably is, when not, we get it fixed with high priority.

Kernel should protect itself and other users against local, non-priviledged=
 users.

    Tries, but attack surface is big.
    People don't care about DoS attacks much.
    =3D> Running untrusted code is a bad idea. Forkbomb is few characters i=
n sh.

Fast, out-of-order CPUs leak user data via timing side-channels. Those
CPUs should not process sensitive data. JITs can be used to extract the dat=
a.

    We can try to work around the problems and apply vendor-provided
    workarounds, but there are likely more problems in future. Similar
    bugs are hidden in CPU microarchitectures, and in particular
    Spectre workarounds are whack-a-mole and thus incomplete.
   =20
    Hyperthreading makes those attacks easier.
    =3D> Use suitable CPUs to process sensitive data.

Filesystems are complex, robustness against malformed filesystems is hard.

    Some filesystems try to be robust against filesystems corruption,
    and some don't even do that. Some perform checks during mount, but
    that means that malicious device can work around them.

    =3D> Don't mount untrusted filesystems. If you have to, use simple and
    common filesystem. VFAT might be good choice.
   =20
Kernel should protect itself against local users with CAP_XX.

    Yes, there's capability system, and in theory capabilities should be se=
parated.
    =3D> Don't rely on that. Noone else does.

Some systems try to protect themselves against people with physical access.

    Laws of physics says it is impossible, but people can still try to
    make it more costly for the "attacker".
    =3D> Please don't rely on that.

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAyHGQACgkQMOfwapXb+vLPqACeMI3pk/00q3v3mxhXduA7vc4y
dh8AoLIvBnsHb6c4xVUcZ3cn9KEi1LdQ
=T4RG
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--bOmUhrqoM3Am7xEWwBiO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6187): https://lists.cip-project.org/g/cip-dev/message=
/6187
Mute This Topic: https://lists.cip-project.org/mt/80797148/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bOmUhrqoM3Am7xEWwBiO--
