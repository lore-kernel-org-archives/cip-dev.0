Return-Path: <SRS0=gapx=7R=lists.cip-project.org=bounce+64572+4698+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B55C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C4C2074B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CKydsiju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C4C2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4698+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BalcYY4521723xBYYKU1OixT; Thu, 04 Jun 2020 01:56:29 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.9685.1591260988050922541
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 01:56:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F14151C0C0E; Thu,  4 Jun 2020 10:56:25 +0200 (CEST)
Date: Thu, 4 Jun 2020 10:56:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 08/15] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Message-ID: <20200604085625.GA18919@duo.ucw.cz>
References: <20200604041745.28886-1-wens@csie.org>
 <20200604041745.28886-9-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200604041745.28886-9-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PNBEq63w1hKeLU6hvrZ23C0Rx4520388AA=
Content-Type: multipart/mixed; boundary="E8d5HhFa3A7NTKEsVji7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591260989;
 bh=LOtCSEtXZvmWubVNvazkeLKUVUZfreR+9omKEg0/IMQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CKydsiju1FIkmbSG3KzowG9hKaGKPbSoklE/JaAL7h5WQvng6VMkaPgXzMlG/DwvG2R
 0+GyGj4QxoooBzflRptVdA6SF4vUWqieQ/2IjBw7s9hAQiScOC4n04yd+0HCfIILlbzsD
 6Kio/h/gYOrXqgUFZ+PfWhIxpyOd7zLT7AI=

--E8d5HhFa3A7NTKEsVji7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is not right.

>  /* TODO: Support multiple regulators */
> -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
> +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> +			      struct device_opp *dev_opp)
>  {
>  	u32 microvolt[3] =3D {0};
>  	u32 val;
>  	int count, ret;
> +	struct property *prop =3D NULL;
> +	char name[NAME_MAX];
> +
> +	/* Search for "opp-microvolt-<name>" */
> +	if (dev_opp->prop_name) {
> +		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
> +		prop =3D of_find_property(opp->np, name, NULL);
> +	}
> +
> +	if (!prop) {
> +		/* Search for "opp-microvolt" */
> +		name[13] =3D '\0';
> +		prop =3D of_find_property(opp->np, name, NULL);

If in !dev_opp->prop_name, it will pass uninitialized buffer to
of_find_property.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXti3OQAKCRAw5/Bqldv6
8lzyAJ9uJUF4NW+TiRCnUtc0wQZRkQYOUQCgvYinP80lWAEe7Dyhp51+kk9CtIw=
=IhF3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--E8d5HhFa3A7NTKEsVji7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4698): https://lists.cip-project.org/g/cip-dev/message=
/4698
Mute This Topic: https://lists.cip-project.org/mt/74665642/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--E8d5HhFa3A7NTKEsVji7--
