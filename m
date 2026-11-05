Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6290.1793912413537126206
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 13:00:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DV+Qjl4J;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03F9E10D08A;
	Thu, 05 Nov 2026 22:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793912407;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fMw67qGpLfmxrCSp8VAl6Naj7NX9aENwlZk6ZGKkKpQ=;
	b=DV+Qjl4JUyyitAmyLVxtm7ahhJ10uu7VxPvvQHYlhlTL9H6nogwP2qcxKzZxKlnUWLh8b+
	BJph7rLq3ch66Yn+bEzBiTLssGIpAL6AVWjnF2Iu1NUnsB60AlB+jcO4JpXEGYrV5yXoMP
	LWj9Z1rYyY+IHwiyKV2wfKwnlEu4QUbEg1Va7WZZ20OGWiZDrWY1lk7t/ETTPSeaRC52lk
	+xOxpoY88m+Y63j4DEgh1WjhIDZQcrCpOWFRDV+D/ZyuDIOHevbkERONgIAXrj1tI22gqa
	s5Akbt7BEjQXWokkCUoqRDaV7tSzyjBVfzHh1V+4fDtfhFBNio/5Zs82FUlXRg==
Date: Thu, 5 Nov 2026 22:00:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P)
 SoC
Message-ID: <auzuVHRtEna4juie@duo.ucw.cz>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261102125309.7743-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <auyrOmptVJH_CEUm@duo.ucw.cz>
 <OSCPR01MB14315B5A4966C38A15309A4F1AA772@OSCPR01MB14315.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gmRmy2KRHhLUfLIZ"
Content-Disposition: inline
In-Reply-To: <OSCPR01MB14315B5A4966C38A15309A4F1AA772@OSCPR01MB14315.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 21:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24653


--gmRmy2KRHhLUfLIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hI!

> Hi Pavel,
>=20
> Thank you for the review.

> > > Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
> > > driver.
> > >
> > > The RZ/V2H(P) SoC features two independent PCIe controllers that share
> > > four physical lanes. The hardware supports two configuration modes:
> > > single x4 mode where the first controller uses all four lanes, or dual
> > > x2 mode where both controllers use two lanes each.
> > >
> > > Introduce a setup_lanes() function pointer to configure the PCIe lanes
> > > based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
> > > detect the configuration at boot time and program the lane mode via
> > > the system controller.
> >=20
> > ...
> >=20
> > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> >=20
> > > @@ -1762,6 +1873,16 @@ static int rzg3s_pcie_probe(struct
> > platform_device *pdev)
> > >  	if (ret)
> > >  		goto port_refclk_put;
> > >
> > > +	if (host->data->setup_lanes) {
> > > +		ret =3D host->data->setup_lanes(host);
> > > +		if (ret)
> > > +			goto sysc_signal_restore;
> > > +
> > > +		ret =3D devm_add_action_or_reset(dev, rzv2h_pcie_release_lanes,
> > host);
> > > +		if (ret)
> > > +			goto sysc_signal_restore;
> > > +	}
> > > +
> > >  	ret =3D rzg3s_pcie_resets_prepare_and_get(host);
> > >  	if (ret)
> > >  		goto sysc_signal_restore;
> >=20
> > This existed in original code, but I don't quite understand what action
> > sysc_signal_restore undoes, and comments do not really help. I would not
> > mind someone double-checking this.
> >=20
> The sysc_signal_restore label asserts the RST_RSM_B signal which is ideal.

Aha, I see it now. Thanks!

Best regards,
									Pavel

--gmRmy2KRHhLUfLIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauzuVAAKCRAw5/Bqldv6
8mltAJ4sRPfRPUx51Y2fsXLI0WATV7OPTACeOWPuXd3ArdB+qnrAv5dDil7muAo=
=xv1I
-----END PGP SIGNATURE-----

--gmRmy2KRHhLUfLIZ--
