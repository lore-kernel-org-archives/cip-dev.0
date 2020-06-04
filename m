Return-Path: <SRS0=c7GH=7R=lists.cip-project.org=bounce+64572+4700+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4936C433E1
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B932075B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RN9t36/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B932075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4700+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RIy6YY4521723xcul9QMkbym; Thu, 04 Jun 2020 02:03:36 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9906.1591261414439105631
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 02:03:35 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 673C21C0BD2; Thu,  4 Jun 2020 11:03:32 +0200 (CEST)
Date: Thu, 4 Jun 2020 11:03:31 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: "Chen-Yu Tsai (Moxa)" <wens@csie.org>, nobuhiro1.iwamatsu@toshiba.co.jp,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 08/15] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Message-ID: <20200604090331.GB18919@duo.ucw.cz>
References: <20200604041745.28886-1-wens@csie.org>
 <20200604041745.28886-9-wens@csie.org>
 <20200604085625.GA18919@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200604085625.GA18919@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zNenA1ZwXsYlGkHPZbTWCDj3x4520388AA=
Content-Type: multipart/mixed; boundary="Dj71Wf22fBz7kn2gp1me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591261416;
 bh=W5bS3tQfCqa2eIhq11b6mMNIV6VWde3DCU5luj/27Ls=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RN9t36/Q7VyjCMLnoaKAWanJW516kACXJ+jwyrmqk1g1J3C+XnWBE0zSr5vwwZtGFHg
 tt9eimnwsGWqsPLxkSkQiLSS1o27dZPSfnO2YjDB9qUF7CCAqkRaFM5Td2MWHBm4RrG8+
 RODe1UsouUxMA2RGifFA3qqXeAjEaWYwASU=

--Dj71Wf22fBz7kn2gp1me
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  /* TODO: Support multiple regulators */
> > -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *d=
ev)
> > +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *d=
ev,
> > +			      struct device_opp *dev_opp)
> >  {
> >  	u32 microvolt[3] =3D {0};
> >  	u32 val;
> >  	int count, ret;
> > +	struct property *prop =3D NULL;
> > +	char name[NAME_MAX];
> > +
> > +	/* Search for "opp-microvolt-<name>" */
> > +	if (dev_opp->prop_name) {
> > +		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> > +		prop =3D of_find_property(opp->np, name, NULL);
> > +	}
> > +
> > +	if (!prop) {
> > +		/* Search for "opp-microvolt" */
> > +		name[13] =3D '\0';
> > +		prop =3D of_find_property(opp->np, name, NULL);
>=20
> If in !dev_opp->prop_name, it will pass uninitialized buffer to
> of_find_property.

This is fixed in the next patch. But I wonder if we should merge them
into one for -cip... Unlike mainline, we already know about the
bug. No need to prepare trap for people doing bisect.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXti44wAKCRAw5/Bqldv6
8iVfAJ9sCsHQUOEfEcHWoAT0hPElS1towwCfR9Q031CYIjEywo37Z/P2C4T7NRQ=
=aqkh
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--Dj71Wf22fBz7kn2gp1me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4700): https://lists.cip-project.org/g/cip-dev/message=
/4700
Mute This Topic: https://lists.cip-project.org/mt/74665642/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Dj71Wf22fBz7kn2gp1me--
