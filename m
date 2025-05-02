Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49FEC3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 10:17:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15799.1746181054835131080
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 03:17:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=enZkJZBb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9B3610267FBE;
	Fri,  2 May 2025 12:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746181053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WWMgtpJX139FNj+0K+HEfmDc5ylLWZ6oNOBGqiG5rcM=;
	b=enZkJZBboTI5LV7F119015sO44Rq2vEEnnHGUlyG3Egnv3xSCwjNkxhc1gdDsdKngla0z0
	TQ00cTg7wdiWIe5PQY14dRnzlee9bbpfYBvzu3Zw6mnDGk+QdLYKlzBF2F60Ub7gXkvxni
	LDFF67jImX6vUuJxCufVu1ZwsQP6IfIMC0OJUdEvbMIjzLKMvsrrwqJlhuDUtttbcBWGKt
	XiMekVjTG5cplkKb5TTqZjnA/RkLPqNf/xsr4aMyTI6XJ4vSxcSP00pqD05sk5OleTXtC3
	MJoM7qPBR8fiifNDQrh6mDapG8ZuHBm//qGfcTFCwSqmoVo7ynoFw48O8Kuf7A==
Date: Fri, 2 May 2025 12:17:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] v4.4.302-cip97-rt54
Message-ID: <aBSbubCPJRhuN3Ll@duo.ucw.cz>
References: <aAk12WeQsf2OeuZy@duo.ucw.cz>
 <a8f99b04-2587-4d8d-ace9-a8b9b32122c6@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEhntOcRfnThrCWZ"
Content-Disposition: inline
In-Reply-To: <a8f99b04-2587-4d8d-ace9-a8b9b32122c6@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 10:17:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18758


--DEhntOcRfnThrCWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt-rebase
> >=20
> > This does not yet have fixes for "Repeated WARNINGs in
> > unpin_current_cpu()". I'll work on those next.
>=20
> I suppose this update will also lift the baseline to the recent 4.4
> release, right? I only now realized that this was using the 4.4-cip
> version from March, rather than recent cip98. Why?

Yes, new version should be out. I believe that's how timing worked
out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DEhntOcRfnThrCWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBSbuQAKCRAw5/Bqldv6
8sxuAJ4/lyL5Lf4k4PCEQunk6uxbLfyvtwCdHlHc0ZUTLCEMD7QZX/sRpdlIY5k=
=HQJP
-----END PGP SIGNATURE-----

--DEhntOcRfnThrCWZ--

