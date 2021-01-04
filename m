Return-Path: <SRS0=WHhA=GH=lists.cip-project.org=bounce+64572+5995+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE110C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:24:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1F320769
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1F320769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5995+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yZPgYY4521723xzZ0YnhPL48; Mon, 04 Jan 2021 04:24:27 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.12736.1609763066896987388
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 04:24:27 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 57B661C0B87; Mon,  4 Jan 2021 13:24:23 +0100 (CET)
Date: Mon, 4 Jan 2021 13:24:22 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: thermal: rcar-gen3-thermal: Add r8a774e1 support
Message-ID: <20210104122422.GC19121@duo.ucw.cz>
References: <20210104102911.8533-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210104102911.8533-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LAxTd44qtUt55xCWmFCdck7bx4520388AA=
Content-Type: multipart/mixed; boundary="Xf0emP4tGNrTsJ5Ll6be"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609763067;
 bh=jmj9rlSI7hntH0QHE2+tfpjlkBNZC7itEz1tDixutdI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=B7Qx+OlTLZETNl+XTlW58/V06WalgWUszzM2tgXZDGn9kcihdL9O1hOOuuM3CvGtU9T
 sOAVyoHQneq+m99wYufs5FB2hlF/axlS1tuq8ImSsvM9lrYTVvjX4UjIzLvTXW9jVM5KD
 hEMmrvQGG+VHEEFdBeqpJGObVdpbDl+JysM=

--Xf0emP4tGNrTsJ5Ll6be
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch has been cherry picked from v5.11-rc2, note the DT nodes have
> been already added into CIP for r8a774e1 SoC, hence this single
> patch.

This and dt-bindings: PCI: rcar: Add missing RZ/G2 SoC's series looks
okay to me. I can apply it if there are no other comments.

Best regards,
								Pavel

> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> @@ -9,6 +9,7 @@ Required properties:
>  			  Examples with soctypes are:
>  			    - "renesas,r8a774a1-thermal" (RZ/G2M)
>  			    - "renesas,r8a774b1-thermal" (RZ/G2N)
> +			    - "renesas,r8a774e1-thermal" (RZ/G2H)
>  			    - "renesas,r8a7795-thermal" (R-Car H3)
>  			    - "renesas,r8a7796-thermal" (R-Car M3-W)
>  			    - "renesas,r8a77965-thermal" (R-Car M3-N)
> --=20
> 2.17.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/MI9gAKCRAw5/Bqldv6
8oR/AKCiMZUdgvPxrDlkgG1Vslh0K9lndwCdEACB+UAmEzEfe0OGiEdgqim+AqI=
=G6XT
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--Xf0emP4tGNrTsJ5Ll6be
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5995): https://lists.cip-project.org/g/cip-dev/message=
/5995
Mute This Topic: https://lists.cip-project.org/mt/79421300/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Xf0emP4tGNrTsJ5Ll6be--
