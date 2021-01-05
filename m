Return-Path: <SRS0=YrXh=GI=lists.cip-project.org=bounce+64572+6041+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8314CC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:30:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DA722CF6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DA722CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6041+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jFjDYY4521723xE3rija5wGO; Tue, 05 Jan 2021 09:30:18 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2.1609867769558615845
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 09:29:34 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 48B491C0B77; Tue,  5 Jan 2021 18:29:26 +0100 (CET)
Date: Tue, 5 Jan 2021 18:29:25 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length only when needed
Message-ID: <20210105172925.GG361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105165358.GC361@amd>
 <OSBPR01MB5048B4F5E3E312D79D262992AAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048B4F5E3E312D79D262992AAD10@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H7x1iJ402eKtQpKKwZQcWgxYx4520388AA=
Content-Type: multipart/mixed; boundary="gtFonrQYpJn2Z6jtKG2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609867818;
 bh=NDtyb5gKKE6+m+rzWpMDwfdwrTJUrwg79tSitaAcKsY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f9nXIuUt1DThLFQLI6TVZZQjrWZO1AcvnjyKFh/rTjTFqKAYA4mChbGcammQ2IpYBbH
 H2Br/dEDR2/IFcHreAI6gNlMhtWbEd+SlQzXAmlYlHjELI3+LfBIVUkuDh0pFLrHLnMlB
 QCSXPoEUN770YDe1zX3x6FOWm7Ib0yOC9rY=

--gtFonrQYpJn2Z6jtKG2Y
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline

--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit c0e035ac56680e74b27fc218c07e70f4b9b8b7a5 upstream.
> > >
> > > When adjust_op_size is defined, len is never used. Move the len
> > > computation where it's actually used.
> >=20
> > > index 59f7aa117a10..02cf8c3f7350 100644
> > > --- a/drivers/spi/spi-mem.c
> > > +++ b/drivers/spi/spi-mem.c
> > > @@ -412,12 +412,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,=
 struct spi_mem_op *op)
> > >  	struct spi_controller *ctlr =3D mem->spi->controller;
> > >  	size_t len;
> > >
> > > -	len =3D sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
> > > -
> > >  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
> > >  		return ctlr->mem_ops->adjust_op_size(mem, op);
> > >
> > >  	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> > > +		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
> > > +		      op->dummy.nbytes;
> > > +
> > >  		if (len > spi_max_transfer_size(mem->spi))
> > >  			return -EINVAL;
> >=20
> > If we are doing this kind of cleanups... I'd move "len" declaration
> > inside the if, too... Not that it matters much.
> >=20
> Should live without this change, will drop this for now.

We can live with or without this one, I'd say.

You do not need to do anything at the moment: I believe we can simply
apply the series as-is.

Best regards,
     								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0ofUACgkQMOfwapXb+vI1wgCfeaHPidDRn20FUfmbZOcDnkE/
lwUAnRNBZcoE/9c874xAuPLcC0725QwI
=IJxB
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--

--gtFonrQYpJn2Z6jtKG2Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6041): https://lists.cip-project.org/g/cip-dev/message=
/6041
Mute This Topic: https://lists.cip-project.org/mt/79450076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gtFonrQYpJn2Z6jtKG2Y--
