Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDABC44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:12:19 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3094.1784110330749917408
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:12:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Z+2jhVWV;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E504E119B9E;
	Wed, 15 Jul 2026 12:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784110328;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PHIHC66IXQ19Nd8z2EWRipTXdYA8QvKOzx5jO9ePsMs=;
	b=Z+2jhVWVH4ASPSEmKgtpP7sJU7E0DRULRPCCSbpQylB2nzaBmR0d5+AU+BChq0zv+tNyh+
	FFaGRvTMWb0BKAFEC1388J1vWnoZnokSAJ786Se+/mKiLBADYInE3LomEVC1vDxzd7LZYc
	T9pgViJrlaRXmw8QcJKrv+P3Rds34y8fenDRFKMyK7ER+aUqScmoA4Riwp+hAqFnu1l7mS
	MIK8BsCkGvFNtbZKXJPC3yUtlKMWk6Ieiwk8D6ggCF5f34lgEMj1MPZRbGf3R06zCyTq6K
	dL+ueOk5u+LgEzJ5oQtd65OMDB+auimEH9FgaWQxIgQl6Fro6Os89k0FWRJSGA==
Date: Wed, 15 Jul 2026 12:12:04 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: renesas: Document
 RZ/G3L SoC
Message-ID: <aldc9NpJgAOV7vA9@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hPoipsWZlNydMEof"
Content-Disposition: inline
In-Reply-To: <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:12:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23589


--hPoipsWZlNydMEof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There seems to be something wrong here:

> Add documentation for the pin controller found on the Renesas RZ/G3L
> (R9A08G046) SoC. The RZ/G3L PFC is similar to the RZ/G3S SoC but has
> more pins.
=2E..
> Document renesas,clonech property for controlling clone channel
> control register located on SYSC IP block on RZ/G3L SoC.

Ok, no mention of deleting constraints for *57.

> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -154,15 +165,10 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a09g057-pinctrl
> +            const: renesas,r9a08g046-pinctrl
>      then:
> -      properties:
> -        resets:
> -          maxItems: 2
> -    else:
> -      properties:
> -        resets:
> -          minItems: 3
> +      required:
> +        - renesas,clonech
> =20
>    - if:
>        properties:

But now we delete constraints for *57, and add constraints for
*46. That looks wrong?

Best regards,
								Pavel

--hPoipsWZlNydMEof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldc9AAKCRAw5/Bqldv6
8p0BAKCUoVy4SxTw2tIDcBOuF3CpLHyg2gCfajlPjab6qP0mfYPfHVcXisBKdj0=
=M+z6
-----END PGP SIGNATURE-----

--hPoipsWZlNydMEof--

