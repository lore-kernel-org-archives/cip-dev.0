Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD15E9A74D
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:33:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16017.1774344820620111578
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jDHV57wA;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60B3010CC2D;
	Tue, 24 Mar 2026 10:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774344818;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3pg9bAvKLLQfiHA8LAtkj8FmfSlJJOnDaXWGOmXNpVM=;
	b=jDHV57wAGrXStKJHpJ7ecz5K7bAaB8oZvO0aDjTKoXFhMLM6ip9wXRgGvSaxiOM5skiw9A
	8PMUKbJZyLs5p2rvTFCsjset9z9gW0vYuWOg1h4Z1zlgDB02t9ANnrfCfyQJSdjoFPhrby
	POMdU8H1WaDZ6XqwZfyKoZzOBbXEZxnECTs24ba39s4ouQjKLnQlMB4kiWmMzlrTxE5NV1
	sH4pd0ZOkut9dyufMEOixRxmPGV6Air7owneOXa3/u8cPdYtqvB3b2orKW0rSSnyxph1fS
	Dd0OCv7ImfMou/JiUdF5n7B48HpYPt9RYvel2FFitBfZn19F0LTwiwRYDWv7bw==
Date: Tue, 24 Mar 2026 10:33:34 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 09/28] PCI: Add
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Message-ID: <acJabrcQAzuYQzi2@duo.ucw.cz>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-10-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZUBAckU9Tth8kgut"
Content-Disposition: inline
In-Reply-To: <20260311110357.1938200-10-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:33:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22544


--ZUBAckU9Tth8kgut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df upstream.
>=20
> Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
> waiting time between exit from a conventional reset and sending the
> first configuration request to the device.
>=20
> As described in PCIe r6.0, sec 6.6.1 <Conventional Reset>, there are two
> different use cases of the value:
>=20
>    - "With a Downstream Port that does not support Link speeds greater
>      than 5.0 GT/s, software must wait a minimum of 100 ms following exit
>      from a Conventional Reset before sending a Configuration Request to
>      the device immediately below that Port."
>=20
>    - "With a Downstream Port that supports Link speeds greater than
>      5.0 GT/s, software must wait a minimum of 100 ms after Link training
>      completes before sending a Configuration Request to the device
>      immediately below that Port."
>=20
> [kwilczynski: commit log]
> Link: https://lore.kernel.org/linux-pci/20240328091835.14797-21-minda.che=
n@starfivetech.com
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> [claudiu.beznea: fixed conflict by keeping only the definition for
>  PCIE_RESET_CONFIG_DEVICE_WAIT_MS]

I don't understand the message here. Upstream patch seems to be
identical to this one, but context differs.

Thanks and best regards,
								Pavel

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c2fd92a9ee1a..a391e4db9401 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -11,6 +11,21 @@
> =20
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> =20
> +/*
> + * PCIe r6.0, sec 6.6.1 <Conventional Reset>
> + *
> + * - "With a Downstream Port that does not support Link speeds greater
> + *    than 5.0 GT/s, software must wait a minimum of 100 ms following ex=
it
> + *    from a Conventional Reset before sending a Configuration Request to
> + *    the device immediately below that Port."
> + *
> + * - "With a Downstream Port that supports Link speeds greater than
> + *    5.0 GT/s, software must wait a minimum of 100 ms after Link traini=
ng
> + *    completes before sending a Configuration Request to the device
> + *    immediately below that Port."
> + */
> +#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
> =20

--=20

--ZUBAckU9Tth8kgut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJabgAKCRAw5/Bqldv6
8j63AKC/67FE6AKDfBwy25VqHjTgr6KkqQCgi0MuORf5TOXmKsZ1v7QpVmZFrpw=
=7N24
-----END PGP SIGNATURE-----

--ZUBAckU9Tth8kgut--

