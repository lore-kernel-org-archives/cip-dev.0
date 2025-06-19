Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE987C7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:16:14 +0000 (UTC)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by mx.groups.io with SMTP id smtpd.web11.3785.1750349479988256939
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 09:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=oyIgYnSd;
 spf=pass (domain: kernel.org, ip: 147.75.193.91, mailfrom: conor@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1B019A546C5;
	Thu, 19 Jun 2025 16:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FD8C4CEEA;
	Thu, 19 Jun 2025 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750349478;
	bh=L/4GQCmNp4End3bV26nQ0uPgKzbQn9lwe/QiKMgQu7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyIgYnSdcag72Xy1MvJrJHWa8zcMh9260RChoW/kjEG8Tr8iHnltwi5hvZPHCcHC3
	 kUkdxM6EeTe1+iH4YXP/IHbBqakGp7MWZLZdj6182PI0stgsFsE2+QuL18VFGVpqCv
	 70aMVuTVIRb/Zx3h58R/VPCRTQ+NB5BgPal4dbevE6GqDho6BNyiFcj8L1A5+MS1Za
	 b8bAFD77YvJvuVb+xoYThFrgQZbd1jKA302idHdWbnSg4Z35IUNQLgAZ5TmS+iljsc
	 6o6XlrA6m4hqsBHlgOMThKj602r6pVpKJFAryk54i+P8w3EpDyACWk58lHl05Zt7jB
	 doXIbiPRI7YTQ==
Date: Thu, 19 Jun 2025 17:11:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: LiangCheng Wang <zaq14760@gmail.com>, cip-dev@lists.cip-project.org,
	drm@lists.freedesktop.org, devicetree@vger.kernel.org,
	noralf@tronnes.org, robh+dt@kernel.org, onlywig@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Message-ID: <20250619-savior-aptly-39782910eb16@spud>
References: <20250618033731.171812-1-zaq14760@gmail.com>
 <20250618033731.171812-4-zaq14760@gmail.com>
 <20250619-earlobe-skiing-25605816a861@spud>
 <c466efe2-981a-4dcf-a278-f84a37d9caf0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c466efe2-981a-4dcf-a278-f84a37d9caf0@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9inD52BoC/bUAuhb"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:16:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19150

--9inD52BoC/bUAuhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 06:01:41PM +0200, Krzysztof Kozlowski wrote:
> On 19/06/2025 17:43, Conor Dooley wrote:
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: mayqueen,pixpaper
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +    description: SPI chip select number for the device.
> >> +
> >> +  spi-max-frequency:
> >> +    default: 1000000
> >> +    description: Maximum SPI clock frequency in Hz.
> >=20
> > Does this actually not have a max?
> > The display surely has a maximum supported frequency, which might be
> > lowered based on the board it is connected to.
> >=20
>=20
> Have in mind this is a duplicated thread - same stuff was sent two times
> leading to duplicated discussion:
>=20
> https://lore.kernel.org/all/?q=3Df%3Azaq14760%40gmail.com

Yeah, I saw the dupe but I deleted the wrong one and couldn't be
bothered downloading the mbox for it.=20

--9inD52BoC/bUAuhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFQ2ogAKCRB4tDGHoIJi
0p0/AP9sO8ovk33FvFe8Uc0xO46JGtywO5SJ8Y+nCh3b+wBiRQD+O39z852xvYn2
9wN8lBYsxPWOhE1dnIYFJeSzWE0z+QU=
=gQDp
-----END PGP SIGNATURE-----

--9inD52BoC/bUAuhb--

