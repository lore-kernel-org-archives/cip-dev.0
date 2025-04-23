Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454BBC369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 18:48:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2490.1745434081088856674
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 11:48:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fqjv13PT;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 800D210293397;
	Wed, 23 Apr 2025 20:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745434079; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=z5blOn5ikP+boJ2Sdc8Oa87TK+jh/DdAPwX8NAMPZFU=;
	b=Fqjv13PTcmBwQcuz+7VkZhgvZ8OQ5ev3+tuOu+DguD3f1X4Awa7vP/S3JLrOPZBW6exw/X
	2ChMvv0iGnCYpQrM3xE0R9pK3+FgF6BxJEoj4wvzwkPk8iTc+u1t4zemECP0M05OLIC6+e
	Fv4mgkD/3r5he49Jlkdb+wn/MDuOwVgCufRMOYwZzgDC8V/YqkulSDc99Nt3ZhvDCzQvGS
	vt2niqjgCdzxNAEGTrhFRSilnxRH6NZk7xxqwQn7tumTehgjK4NfeOtJtgEkn560wlC4Vy
	5JB3v9+ggPebM6CUDvjLX+0aaSWiPiela7fj5zYKAdZmsIc9/ds4As6ssprluQ==
Date: Wed, 23 Apr 2025 20:47:53 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip97-rt54
Message-ID: <aAk12WeQsf2OeuZy@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xa/XlnpGJQ4EyRUz"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 18:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18579


--Xa/XlnpGJQ4EyRUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

This does not yet have fixes for "Repeated WARNINGs in
unpin_current_cpu()". I'll work on those next.

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xa/XlnpGJQ4EyRUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAk12QAKCRAw5/Bqldv6
8moRAJ4tMiecp8BpqAl21+V1IcoUgcpn/ACgqsMoHde3LYN8UTqemGoZUzre53M=
=TSdz
-----END PGP SIGNATURE-----

--Xa/XlnpGJQ4EyRUz--

