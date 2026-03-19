Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE51075279
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 08:48:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6491.1773910103229797212
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 01:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Qd5pNEIK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 735C31089A7;
	Thu, 19 Mar 2026 09:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773910100;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T5z9skBy1Tt7Y0b3Dx+gnnU9OsyFHf3RrooDV7v/j34=;
	b=Qd5pNEIKDibbGc3LLEDxiOx5gBkqgTZSd7gqDjY1lhL3WDQ1nZh4LOLCsqhd9HwMZJAN5C
	PPUhxo2Q+rySTqobDhklPefQVu1MVu3DJ/om3S7aT4qS5Y+uSREl9ydZ/qvMOWLUaspY2E
	ALrKPWnKiB3cXgStWw0yz/EtMc0P81ecZ1CwgoK3pY+sZP21vzDFRnIcW0BZOii4XwKv2j
	LSlnkoIiVyUDJ6/xkezvOrX8fVBqKUlUPBjjG14Tj1lAS3MZfFgwicOuJbwq7GNzACll6x
	urQtiS7jZl0D8DsSsDEnjFbs8JZDB0cgGNRBHrCsS6xIsl8nmjeNL6/oG83Uig==
Date: Thu, 19 Mar 2026 09:48:16 +0100
From: Pavel Machek <pavel@nabladev.com>
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] arm64: dts: renesas:
 r9a09g077/r9a09g087: Add DT nodes for SCI channels 1-5
Message-ID: <abu4UPD2VcgMJdLj@duo.ucw.cz>
References: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACe6DC4fGvWoSG=9uU8U3h4prtqY7h1TjWXfjFk0aTz2KTBFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Piim+8+GP55r1JX"
Content-Disposition: inline
In-Reply-To: <CACe6DC4fGvWoSG=9uU8U3h4prtqY7h1TjWXfjFk0aTz2KTBFcg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 08:48:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22508


--3Piim+8+GP55r1JX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The RZ/T2H and RZ/N2H SoCs expose six SCI controllers; sci0 was already
> > present in the SoC DTSI. This patch adds the remaining SCI nodes
> > (sci1-sci5) to the respective SoC DTSIs.
> >
> > Note the patches have been picked up from upstream and manually merged
> > to resolve conflicts.
> >
> > Note, these patches apply on top of the RSPI series [0].
> >
> > [0] https://lore.kernel.org/all/20260309150619.761962-1-cosmin-gabriel.=
tanislav.xa@renesas.com/
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (2):
> >   arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
> >   arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
> >
> >  arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 70 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 70 ++++++++++++++++++++++
> >  2 files changed, 140 insertions(+)
>=20
> I reviewed this series, looks good to me.
> I can apply this, if tests are OK and there is no other comment.

Looks good to me, too.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--3Piim+8+GP55r1JX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabu4UAAKCRAw5/Bqldv6
8rqVAJ48zVk/fBui+n307C5IQ6lObwQxFACeP2INYu/gTj33u37S1tpFUCo1L4Q=
=iGKZ
-----END PGP SIGNATURE-----

--3Piim+8+GP55r1JX--

