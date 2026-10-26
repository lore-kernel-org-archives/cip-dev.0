Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1962.1793033948266632970
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 09:59:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ioAmZWjz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89B75106E82;
	Mon, 26 Oct 2026 17:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793033942;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Hn5cxF/9H6VlQHvkb/V7WdpKbt/moDNL1jet91S0+BQ=;
	b=ioAmZWjzeplEc3aPSTmHs0uBj73aQu3ZGhTluR/10cOB4EpyJbGdpRAr5lthwmLD/pmOBq
	PCkg4BsmJ6kyWpjjBW4t7NGJUDauDUz6YH3xB+WGdef9AHVZ4HvRzry2bFFjU+JzNsIu1d
	cZoEBETflT+U7IueMUi0PaBs2/r14lX4giOZ0b1jKb3qiNKE/JvgTin9ihPAlY69O1dWjN
	AohoxryAIaGmYp3EQmPf3vHWwIWlGa5ojLV8UosB4V4fzUpXxiA//Eu9k7HwE+WxxVCNtb
	7dPHHnruTqm8jJ120S79FAVMQRck1CY7BXEbP9DVHwbq/JjBtwNZMk3ZcUTmGQ==
Date: Mon, 26 Oct 2026 17:58:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, fabrizio.castro.jz@renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 2/5] dmaengine: sh: rz-dmac: fix
 device leak on probe failure
Message-ID: <at-G0rpdQ3RHmZx0@duo.ucw.cz>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979242-32127-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0b/ZZR/rWtbdbVI"
Content-Disposition: inline
In-Reply-To: <1792979242-32127-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 16:59:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24547


--o0b/ZZR/rWtbdbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Johan Hovold <johan@kernel.org>
>=20
> commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.
>=20
> Make sure to drop the reference taken when looking up the ICU device
> during probe also on probe failures (e.g. probe deferral).

According to code, if "renesas,icu" is not present, that's still okay:

        ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &=
args);
        if (ret =3D=3D -ENOENT)
		return 0;

but we skip put_device() in such case. Original code did do
platform_device_put(NULL) in this case, so I guess we are still okay.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--o0b/ZZR/rWtbdbVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat+G0gAKCRAw5/Bqldv6
8vcaAKCAYltzFDws551nbkCZnB3icmE21wCeJstb50ncsDaM9Q6RiOES/y/bevY=
=h3i9
-----END PGP SIGNATURE-----

--o0b/ZZR/rWtbdbVI--
