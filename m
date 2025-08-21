Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58396CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 10:26:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6050.1755771961484419500
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 03:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IgBkvMHj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE470103F5651;
	Thu, 21 Aug 2025 12:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755771958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OsWiSGPzO8+BCula2E637x9h1oWFgfxFcqp2Pff51n0=;
	b=IgBkvMHjQ4apTSQ/4y5j8CWgiUo8E7QMw/gTJynqSMMqRlcFFgZGujYnSTdE3bar5/IIDl
	Cvfj7tDUw5Er75+E/X0ciSnziMQSZtOWmwfJNN0ZLKHocEqnJtRiIaWPiCz2KtMMyx9QC7
	eYcvmS+ecJRz8VymI1xa6H+FvmlcajiaLqom7WJtxVDhWtUIhhhGcmiFNoA7RGpsQ78Dme
	D5oHn6kBTyIDuIVPPPbbjd3Crf/RrONr3oisukQRtgfuqKkMX6TAxz31wNIWhbRMtXo2Xk
	pwehXzucwviBf/IBoQvea9vNs1SC0CHFZ96+A1NuUk63REWawL0MKTNG6dxewA==
Date: Thu, 21 Aug 2025 12:25:51 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Ulrich Hecht <uli@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Message-ID: <aKb0L5X9xSysixyH@duo.ucw.cz>
References: <20250820140553.4730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="urw5/jTwViPeT+c/"
Content-Disposition: inline
In-Reply-To: <20250820140553.4730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 10:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19930


--urw5/jTwViPeT+c/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2025-08-20 15:05:53, Lad Prabhakar via lists.cip-project.org wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
>=20
> When performing continuous unbind/bind operations on the USB drivers
> available on the Renesas RZ/G2L SoC, a kernel crash with the message
> "Unable to handle kernel NULL pointer dereference at virtual address"
> may occur. This issue points to the usbhsc_notify_hotplug() function.
>=20
> Flush the delayed work to avoid its execution when driver resources are
> unavailable.

Reviewed-by: Pavel Machek <pavel@denx.de>

									Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--urw5/jTwViPeT+c/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKb0LwAKCRAw5/Bqldv6
8qItAJ9NFSCTTsfqo9JzhUUbYAcDYI3jtgCfSdOL74ZueCSc1oYR0GvB0S2MRWg=
=ufmq
-----END PGP SIGNATURE-----

--urw5/jTwViPeT+c/--

