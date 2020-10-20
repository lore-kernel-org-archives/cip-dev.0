Return-Path: <SRS0=IFgU=D3=lists.cip-project.org=bounce+64572+5626+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA5C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:48:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4592822283
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Z6xX2fVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4592822283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5626+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4DpXYY4521723xN8MaEZIqVr; Tue, 20 Oct 2020 13:48:17 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1451.1603226896850298810
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 13:48:17 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 83F4E1C0B77; Tue, 20 Oct 2020 22:48:13 +0200 (CEST)
Date: Tue, 20 Oct 2020 22:48:12 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Message-ID: <20201020204812.GC29993@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014093914.GB1866@amd>
 <OSBPR01MB50488430A9BE629033D6990FAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <20201020120144.GA15948@duo.ucw.cz>
 <OSBPR01MB504893210A9C263F008A8F04AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB504893210A9C263F008A8F04AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4kwk9AOTlGfabI71322UnOksx4520388AA=
Content-Type: multipart/mixed; boundary="c8ruI253iV0h213jPsjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603226897;
 bh=GA4hlmA8Ms/v8iS5rNmhNR81WNDaSxJE4DcqKcYqbmY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Z6xX2fVTFVmBvhK8XYM0OUXr/0kB+NZbKRbUl4fIWyvOU4JxStj/q1FPJND3U/McniO
 1qoZHibW4OtzogQroLloayy9Pm1DM3dFbunkeKFVJRVy1KTLvW+xqfrnkUh89eTfvoApj
 17bMPAD+lM5S6tQ6rLeGJmOFB6Ovucy1qEk=

--c8ruI253iV0h213jPsjV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline

--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > This patch series adds support for PCIe EP on Renesas R-Car Gen3 =
and
> > > > > RZ/G2x platforms.
> > > >
> > > > I quickly went through a series and code seems reasonably nice.
> > > >
> > > > > * Since the changes are huge I am sending the patches as RFC.
> > > >
> > > > And yes, it is quite big, which might be a problem. OTOH only Renes=
as
> > > > seems to have PCIe EP drivers enabled in their CIP defconfigs, so
> > > > there's good chance noone else in CIP project is using this code.
> > > >
> > > > [If someone else _is_ using it or is considering using it, please
> > > > speak up.]
> > > >
> > > We haven't received any response yet, is it OK if I send a non RFC
> > > version or shall we wait for couple of days more ?
> >=20
> > I guess I'd like non-RFC version of patches 1-22 in a series. I
> > believe it makes sense to add 30, 32, 49, 50 to them, as they are
> > simple and fix a bug.
> >=20
> > Would that work for you?
> >=20
> Sure ill get on posting the above mentioned patches as non-RFC in a serie=
s.
>=20
> How do we tackle with rest of the patches ?

Well... I applied this batch. If someone can explain the mutex
vs. spinlock thing, then I guess we can do next batch up to 35...

OTOH I did not go through those patches in detail, and RFC is good
enough for review, so... maybe you can just wait.

Best regards,
    	     	    	   	    	   	      	    Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX49NDAAKCRAw5/Bqldv6
8nDyAJ42A6yqksabJyQ63cvv+vMB94vw2ACgnKJhHxqtHT1HOn6ejo7nz1+UTWs=
=X+qO
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--

--c8ruI253iV0h213jPsjV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5626): https://lists.cip-project.org/g/cip-dev/message=
/5626
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--c8ruI253iV0h213jPsjV--
