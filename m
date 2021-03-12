Return-Path: <SRS0=+SRd=IK=lists.cip-project.org=bounce+64572+6278+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F08C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 12 Mar 2021 23:06:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BCA64F85
	for <cip-dev@archiver.kernel.org>; Fri, 12 Mar 2021 23:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BCA64F85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6278+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jMzoYY4521723xauvRMK3npv; Fri, 12 Mar 2021 15:06:49 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.24.1615590408060153550
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Mar 2021 15:06:48 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 952351C0B7C; Sat, 13 Mar 2021 00:06:43 +0100 (CET)
Date: Sat, 13 Mar 2021 00:06:41 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Message-ID: <20210312230641.GA17701@amd>
References: <TY2PR01MB26522E5CC577EC60BD354085D76F9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB26522E5CC577EC60BD354085D76F9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SqZgUqWFrukrKJ1YoEVZLx5Jx4520388AA=
Content-Type: multipart/mixed; boundary="a0zByr4t7GygiLeBExx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615590409;
 bh=sfnGekrJC5LyVcKe8OyfXcT6oj0215NeifBXP68bhLE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Wo7nVS6uahZkmcHDcneLVvM8nC5R/p6f5TegM5CDe21MMLIfJCUzIPdsQmA1XMF+PMF
 jXNk1f0ddEHiyZlLwQrxGtLSEZSXBMVQ2PYBwe9ox7FcR9a6Vx8JC9fHJGOkr/WNe1I6B
 kj4FbirQpd2R/lr5fRfphhyQgoKL2jAyrnc=

--a0zByr4t7GygiLeBExx0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Git bisect has told me the first bad commit is
> 31fb632b5d43 spi: Move cadence-quadspi driver to drivers/spi/

That's strange.

> Does this change requires device tree modification?
> Any suggestions or comments would be appreciated.

=2E..because that particular change does not change any C code. But it
touches Kconfig bits; can you check that CONFIG_SPI_CADENCE_QUADSPI is
enabled in the "bad" configuration?

Do you have any local changes in
drivers/mtd/spi-nor/controllers/cadence-quadspi.c or
drivers/spi/spi-cadence-quadspi.c ?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBL9AAACgkQMOfwapXb+vJvOgCgtcWTXRPD90puTD2Nm85vEbom
JMQAn1Wlw9fztiUJiKhHuljh5BfI3LaX
=tKAd
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--a0zByr4t7GygiLeBExx0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6278): https://lists.cip-project.org/g/cip-dev/message=
/6278
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--a0zByr4t7GygiLeBExx0--
