Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93EEC43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 20:17:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.163.1783455471008164088
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 13:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dTXzNuNY;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9D48118FA4;
	Tue,  7 Jul 2026 22:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783455469;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Jd45u4kdYQhsKsEUnHhMoAPhWWoSVPftawe2wwXqI5o=;
	b=dTXzNuNY2WoLQXXC/upLTSIe8KVqL/i+UUv6g9OmomOAOnbJRNZb8ieevKWvxa/lauJfcr
	vN7+ykxcCPKYVKetESTjdj8orhpgHNkyw43Jx88YT8gnO6cFdHnTZXVu4ZU6HJwEhARq+i
	9m4uK5f4uXIsj99J7hPi/lf1wd3qzJX287gBKA+BsOutP9n4qQ6VuiwQiTec+rUHjb1s/6
	3gwBs4F6cmPEgZjg4U5Pg1vkWp0YO1OXpKH2cCOYBV6QClaHKwqsz8vMCElxM713/xPuvj
	eVUqD/HX/UXcSRrapFl7JgzQ6rGBOm3FFkU4+6CpGzq/xlfzZjUSNM5J4i15kg==
Date: Tue, 7 Jul 2026 22:17:45 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 07/10] dt-bindings: pinctrl:
 renesas,r9a09g077: Document pin configuration properties
Message-ID: <ak1e6WV392sQ09le@duo.ucw.cz>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702102349.23431-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5i0kslySyiGZAAFN"
Content-Disposition: inline
In-Reply-To: <20260702102349.23431-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 20:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23476


--5i0kslySyiGZAAFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
> @@ -72,6 +72,23 @@ definitions:
>        input: true
>        input-enable: true
>        output-enable: true
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      input-schmitt-enable: true
> +      input-schmitt-disable: true
> +      slew-rate:
> +        description: 0 is slow slew rate, 1 is fast slew rate
> +        enum: [0, 1]

Elsewhere in tree we have

Documentation/devicetree/bindings/clock/renesas,9series.yaml
      renesas,slew-rate:
        $ref: /schemas/types.yaml#/definitions/uint32
        enum: [ 2000000, 3000000 ]
        description: Output clock slew rate select in V/ns

atmel,at91-pio4-pinctrl.txt:
        - for microchip,sama7g5-pinctrl only:
                - slew-rate: 0 - disabled, 1 - enabled (default)

I guess having one solution would be best, and specifying real units
(V/ns) rather than fast/slow seems good to me.

Best regards,
								Pavel

--5i0kslySyiGZAAFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCak1e6QAKCRAw5/Bqldv6
8iWHAJ0fyfvkGmHQbmXPhhvdi0UQQojg4wCcC4IVR+jajcwZeoBll9jB5dFV2jc=
=3sIH
-----END PGP SIGNATURE-----

--5i0kslySyiGZAAFN--

