Return-Path: <SRS0=nF1V=AZ=lists.cip-project.org=bounce+64572+4927+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B2C433E2
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:57:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8576722597
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VoKCWa6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576722597
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4927+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CYx0YY4521723xChovffNvJ1; Tue, 14 Jul 2020 10:57:47 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2276.1594749465962326904
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2020 10:57:46 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C6DC01C0BDE; Tue, 14 Jul 2020 19:57:40 +0200 (CEST)
Date: Tue, 14 Jul 2020 19:57:40 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 06/23] PM / OPP: Manage device clk
Message-ID: <20200714175739.GF18210@amd>
References: <20200708154554.26450-1-wens@csie.org>
 <20200708154554.26450-7-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200708154554.26450-7-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TUrifF4kyMExOyNigzB3cnwRx4520388AA=
Content-Type: multipart/mixed; boundary="uDL3IwuA1ZIx9GuVycKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594749467;
 bh=4wE3Fjkft8TTP2jaAQidzt58gcJ/UJY0uhDlHmSeTBI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VoKCWa6YWKXZvXydjgpkJObjI+RTgP3JEzWf9CEG7QwNp39yCV0v6rhD7g177jOsfk2
 knz/8evrbN7LEesMxX4xyUeeebqqQbxBYscN6awWTw7Vw7cGbLpth9sZvsNSju102m/St
 4BSlcKlSRrD4iDuhpo6zZyfYinEzm6WUE6I=

--uDL3IwuA1ZIx9GuVycKV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> commit d54974c2513f487e9e70fbdc79c5da51c53e23da upstream.
>=20
> OPP core has got almost everything now to manage device's OPP
> transitions, the only thing left is device's clk. Get that as well.

> @@ -620,6 +622,15 @@ static struct device_opp *_add_device_opp(struct dev=
ice *dev)
>  		of_node_put(np);
>  	}
> =20
> +	/* Find clk for the device */
> +	dev_opp->clk =3D clk_get(dev, NULL);
> +	if (IS_ERR(dev_opp->clk)) {
> +		ret =3D PTR_ERR(dev_opp->clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
> +				ret);
> +	}
> +
>  	srcu_init_notifier_head(&dev_opp->srcu_head);
>  	INIT_LIST_HEAD(&dev_opp->opp_list);
> =20

Strange. Same code exists in mainline (drivers/opp/core.c, function
name changed to _allocate_opp_table), and ret is directly overwritten
there.

That's definitely not usual way of handling -EPROBE_DEFER.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8N8hMACgkQMOfwapXb+vJafwCdHjOt9f83v3DPYf28o//xnRB6
d/UAnjAWctGalQnhv7EiW1BkBg7tDxIx
=ULbl
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

--uDL3IwuA1ZIx9GuVycKV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4927): https://lists.cip-project.org/g/cip-dev/message=
/4927
Mute This Topic: https://lists.cip-project.org/mt/75379085/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uDL3IwuA1ZIx9GuVycKV--
