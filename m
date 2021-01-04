Return-Path: <SRS0=4Uq+=GH=lists.cip-project.org=bounce+64572+5993+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD30C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:22:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCA62075E
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCA62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5993+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BoVZYY4521723xXopkylddlC; Mon, 04 Jan 2021 04:22:42 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12782.1609762961085922805
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 04:22:41 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C7BD01C0B87; Mon,  4 Jan 2021 13:22:37 +0100 (CET)
Date: Mon, 4 Jan 2021 13:22:37 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
Message-ID: <20210104122237.GA19121@duo.ucw.cz>
References: <20210104095848.7111-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210104095848.7111-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4i0E00KFPY08MaEFZbnmOi2px4520388AA=
Content-Type: multipart/mixed; boundary="fWWagnO3rQLhV5uxUsfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609762962;
 bh=zQnXrYlhrD1Gr+hhpoT2sgSGWa9rUfWs6m5a4trNdBg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wA2mYiBj5m05DSeGcDa68k6pA16vbxW0VXcv6febJLcTMOG5JpFaWiWQXpsg/LqyT/D
 /jyCBQSJ3pfUhO9PwoAmWlzUPvoQ9+h+THnrje8ixsZC0NKGTChync5izr/TYMY45OdeN
 JLQ8CBOL0bXmc0MVPNfKAzxghIfV5VLyRAE=

--fWWagnO3rQLhV5uxUsfX
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit f3c6c120614cfb02827ee7bbe6c4240847cc5f12 upstream.
>=20
> The R-Car PCIe controller does not use interrupts when configured
> for endpoint mode, hence the bindings do not document the interrupts
> property.  However, all DTS files provide interrupts properties, and
> thus fail to validate.
>=20
> Fix this by documenting the interrupts property.

Looks good to me. I can apply it to 4.19-cip if there are no other
comments.

Best regards,
								Pavel

> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -32,6 +32,10 @@ properties:
>        - const: memory2
>        - const: memory3
> =20
> +  interrupts:
> +    minItems: 3
> +    maxItems: 3
> +
>    power-domains:
>      maxItems: 1
> =20
> @@ -53,6 +57,7 @@ required:
>    - compatible
>    - reg
>    - reg-names
> +  - interrupts
>    - resets
>    - power-domains
>    - clocks
> @@ -62,6 +67,7 @@ required:
>  examples:
>    - |
>      #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/power/r8a774c0-sysc.h>
> =20
>       pcie0_ep: pcie-ep@fe000000 {
> @@ -73,6 +79,9 @@ examples:
>                    <0x30000000 0x8000000>,
>                    <0x38000000 0x8000000>;
>              reg-names =3D "apb-base", "memory0", "memory1", "memory2", "=
memory3";
> +            interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>              resets =3D <&cpg 319>;
>              power-domains =3D <&sysc R8A774C0_PD_ALWAYS_ON>;
>              clocks =3D <&cpg CPG_MOD 319>;
> --=20
> 2.17.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/MIjQAKCRAw5/Bqldv6
8oxJAKC7aeCA8otq/KNmNsb9POrdobdM2wCgkL6KVeoap585Sq7Ei6CfZQfLt5w=
=Idlp
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--fWWagnO3rQLhV5uxUsfX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5993): https://lists.cip-project.org/g/cip-dev/message=
/5993
Mute This Topic: https://lists.cip-project.org/mt/79420973/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fWWagnO3rQLhV5uxUsfX--
