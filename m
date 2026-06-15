Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B2CCD98CE
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 21:03:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.139755.1781557405450854484
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 14:03:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IIZuX3nh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1818E11627A;
	Mon, 15 Jun 2026 23:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781557402;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=du+sCIpzNAOswpxlZ3cSoeGWBvDFIF6m/ZIpdjBbOuA=;
	b=IIZuX3nhJnLGOmbWpDQhjttzQvjoaUlS32pKlJwm6S6qKglkBQZ+t6SYgRMvwUf2UbbHAk
	PnBCLDNGpLYk8ExCZondLxNCWSpu0UhzP1GdewJ0GU9yYw1U2sCdQmf/FnpQRaqz1rvVI0
	5QZNYtGXIg4CCiG+PTWntaOBHWfjOA1vxVjSTfZNFq1ZPRL1ls/K2Ch1wQYsNMRFaPqjVb
	T/gxKmIh4fdGymOzLzr4yhEXRFMpC3YJEajYZv8RW0Itia/uQAiteFGCctCkHQ9kVIokWU
	bqPhyapv24jJ2Gf1sjEj4gajxzCyuDjwwgcaOGNzy/uFK278MKhIxINLAFoTJQ==
Date: Mon, 15 Jun 2026 23:03:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Message-ID: <ajBolVke5ENiZ9n2@duo.ucw.cz>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D6tDLaSyqkT5XzpF"
Content-Disposition: inline
In-Reply-To: <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 21:03:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23142


--D6tDLaSyqkT5XzpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
> Hi,
>=20
> On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
> > Hi!
> >=20
> > > Thanks for your patch.
> > > I reviewed this and other series, these seems to be fine.
> > > I can apply this if tests are OK and there are no other comments.
> > >    Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >=20
> > I'm looking into it. As this modifies generic code, I suggest we are
> > cautious here.
> Please let me know if you want me to limit that code to RZ/G3S SoC only.

I'm still reviewing the series, sorry for delay.

My first preffered option would be explanation why this is okay on
5.10: (Will it change behaviour on non-renesas boards? How sure we are
the behaviour change will not break something, or slow things down
significantly?)

+++ b/drivers/usb/host/ehci-platform.c
@@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(struct=
 device *dev)
        if (pdata->power_suspend)
                pdata->power_suspend(pdev);

+       ret =3D reset_control_assert(priv->rsts);
+       if (ret) {
+               if (pdata->power_on)
+                       pdata->power_on(pdev);
+
+               ehci_resume(hcd, false);
+
+               if (priv->quirk_poll)
+                       quirk_poll_init(priv);
+       }
+

If we can't have the explanation, limiting to renesas boards would be
fine next option.

Thanks and best regards,
								Pavel

--D6tDLaSyqkT5XzpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajBolQAKCRAw5/Bqldv6
8nFvAKCvv3lwxmN7Vyr0sGPmqu4aZ5Ha0ACfVcGbBGZMedSXG6iMRZoo4mcAJGw=
=H5qr
-----END PGP SIGNATURE-----

--D6tDLaSyqkT5XzpF--

