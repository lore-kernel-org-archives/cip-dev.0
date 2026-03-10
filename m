Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2450FD4F31
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 20:14:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4716.1773173637007731538
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 13:13:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dN6bPy+t;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F78A10FB2C;
	Tue, 10 Mar 2026 21:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773173634;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=O1wft5S0e9BoamG2lhQTUbcZ9oQtk15tCfXzqTFGtCo=;
	b=dN6bPy+t+p5a+Waac9hojk2XeEKeZY0qC79aFWF4jhksKIpt8yJeElkl8wvQXj8QqB4MVo
	H/PVWeLA4Xi4k6/h23TtzyRxH/0ZNK4jClIl9aosLcmyjSLVI5mCL5gExcgKLo7GAX5yQZ
	YNs9hvRNqGvG/Yy4v4CfbwDLgIOXi0aHZwmWuymq1gkNHT2606bxDYDI89lvj5E2AM/JCw
	E88kaASm8UKIgeevv+tLv8hz1xaW0yVAyiZX29ANsSLwbooTyuewt8eA1RlMz9kZG++cMX
	rE/yrDUrX6JiRz9UCqhirjlRd8MjfUdDBM8Z1kZKqrdNLc22JcpLj5HJi8d5tw==
Date: Tue, 10 Mar 2026 21:13:50 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Message-ID: <abB7fvgC4V4qXeao@duo.ucw.cz>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
 <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
 <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4mqnErPk/zycs5t8"
Content-Disposition: inline
In-Reply-To: <TY7P301MB198402755BA8B35FC4ABB850D346A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 20:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22242


--4mqnErPk/zycs5t8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This series adds display support for the Renesas RZ/V2N SoC and EVK
> > > board.
> > >
> > > All patches were cherry-picked from mainline kernel.
> > >
> > > Note: This series depends on:
> > > https://lore.kernel.org/cip-dev/20260225121232.129678-1-
> > ovidiu.panait.rb@renesas.com/
> >=20
> > Thank you, applied.
> >=20
>=20
> Looks like this series is not present in the 6.12 branch, could you
> please double check?

You seem to be right, sorry about that. It looks like I forgot to push
the patches, and release happened in the meantime. I'll do rebase,
retest and likely push the result "soon".

Best regards,
								Pavel

--4mqnErPk/zycs5t8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabB7fgAKCRAw5/Bqldv6
8p2mAJ9yoCRJ6TCKXvG2JTks6F6Njg68TACdGNHeRMfGq3YWOOHZEsm1R1qTbmo=
=bqK8
-----END PGP SIGNATURE-----

--4mqnErPk/zycs5t8--

