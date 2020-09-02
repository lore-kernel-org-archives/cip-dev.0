Return-Path: <SRS0=udzG=CL=lists.cip-project.org=bounce+64572+5385+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A7C433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 21:50:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF18020709
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 21:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VOdAyGvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF18020709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5385+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 81iFYY4521723xNEHV055gJz; Wed, 02 Sep 2020 14:50:40 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.356.1599083438697552448
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 14:50:39 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 587AD1C0B77; Wed,  2 Sep 2020 23:50:34 +0200 (CEST)
Date: Wed, 2 Sep 2020 23:50:33 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
Message-ID: <20200902215033.GB28048@duo.ucw.cz>
References: <20200708154554.26450-1-wens@csie.org>
 <20200714173342.GA18210@amd>
 <CAGb2v67RNWMWrMtoiobSSYrw4HXOL9+_rAn6awmPAgR-82Seyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v67RNWMWrMtoiobSSYrw4HXOL9+_rAn6awmPAgR-82Seyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EEWd3gHVZNekqaASkZx6YoIGx4520388AA=
Content-Type: multipart/mixed; boundary="44I1fxmUbKe7bY4oH960"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599083440;
 bh=+UYLEBnw8nTPoIEF6Xk9tYcVEYWZS/xV2s1rmiHqWaA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VOdAyGvh5FqiDU8o9g+KAUl7RiWhi63Xqsy7fmkzGVbHnEqYzQ/DlPJJY6jE77jtnjV
 vtfgMKZLT9iw8z7CS9oN4dXvLb3NTzDrK65ms2fa6QIrkKcPdgqOnnE9v126mJwJyjdUm
 KzQQvXg0mkTAYwRC2za4HHZcmbdi3+0aysQ=

--44I1fxmUbKe7bY4oH960
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is part 2 of MOXA's PM / OPP / cpufreq backport series. The whole
> > > series aims to backport patches related to PM / OPPv2 and cpufreq
> > > which were included in the v4.4 kernel from TI's SDK. The end goal is
> > > to include cpufreq-ti and convert am33xx to using it and OPPv2.
> >
> > Ok, I went through them, and most of them are ok.
> >
> > OTOH lots of them are changing common code, and I don't believe all of
> > them are neccessary for am33xx support.
> >
> > Could you identify changes that are not neccesary for am33xx support,
> > and drop those?
>=20
> So I tried just backporting the ti-cpufreq driver. However as the am33xx
> OPP table wasn't completely converted to the v2 format, missing the
> clock-latency-ns property, it is unusable in this standalone state.
>=20
> A couple of patches for PM/OPP are needed:
>=20
>     0764c604c812 PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
>     50f8cfbd5897 PM / OPP: Parse clock-latency and voltage-tolerance
> for v1 bindings
>=20
> I suppose this would be preferred over backporting all the OPP / PM
> cleanups?

Yes, that seems to be better solution than the previous series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1ATqQAKCRAw5/Bqldv6
8rtNAJwOHfcnvtgwISxwvXZUB55X/EiK+wCgxD4UIQPrlKA6LgZqhfFleJs9bd0=
=ho2z
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--

--44I1fxmUbKe7bY4oH960
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5385): https://lists.cip-project.org/g/cip-dev/message=
/5385
Mute This Topic: https://lists.cip-project.org/mt/75379082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--44I1fxmUbKe7bY4oH960--
