Return-Path: <SRS0=dz3f=D6=lists.cip-project.org=bounce+64572+5671+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D03EC388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:33:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C324420BED
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YepPo0g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C324420BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5671+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jEAyYY4521723xNc44gdkwz0; Fri, 23 Oct 2020 13:33:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2651.1603485180963861388
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 13:33:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B02FA1C0B81; Fri, 23 Oct 2020 22:32:57 +0200 (CEST)
Date: Fri, 23 Oct 2020 22:32:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] PCI: rcar: Move shareable code to a common file
Message-ID: <20201023203257.GA10156@duo.ucw.cz>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023194039.GB6002@duo.ucw.cz>
 <OSBPR01MB5048EA292D626F32EB60B393AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048EA292D626F32EB60B393AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x6WPVrlfVQlF42LHwVCSrgi0x4520388AA=
Content-Type: multipart/mixed; boundary="aOePwXBS97bnMqNS8eyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603485183;
 bh=iK2X4lEmWbFmwRkuSmEO9qivfzSJO+PL6jcqU+kX//Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YepPo0g9EIdZVlPqLnWa9EFPAOYCo49GFvfiOzQhdN397q2nkU15qbpJJzRY1VrUO2K
 DSDicLpJP/bLatlUH/8hivh38oYFHfzpC5cP2KBj2KPG+N89MAjzR7AXXkOEPrA2dyBZ8
 f9oco2WrChOeScnVDgCxXzyIeqfzhFu4Bj0=

--aOePwXBS97bnMqNS8eyG
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> > > +{
> > > +	unsigned int timeout =3D 10000;
> > > +
> > > +	while (timeout--) {
> > > +		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
> > > +			return 0;
> > > +
> > > +		udelay(5);
> > > +		cpu_relax();
> > > +	}
> > > +
> > > +	return -ETIMEDOUT;
> > > +}
> >=20
> > This has same problem. Plus, I don't believe cpu_relax() is good idea
> > there. Relaxing CPU every 5usec will not change anything.
> >=20
> Agreed (as above).  wrt cpu_relax() I believe this was added to improve t=
he performance of other HW threads.
>

Yes, but you'd need to call it in a loop. It will be effective if done
inside udelay(), but not like this.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5M9+QAKCRAw5/Bqldv6
8r/aAJ9UDlAW7CsiU2saxKBzQLuckTJblACfSSOVvBkUNmIC70dSAebCggqu7xI=
=Psd8
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--aOePwXBS97bnMqNS8eyG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5671): https://lists.cip-project.org/g/cip-dev/message=
/5671
Mute This Topic: https://lists.cip-project.org/mt/77756293/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aOePwXBS97bnMqNS8eyG--
