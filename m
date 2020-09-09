Return-Path: <SRS0=pTqQ=CS=lists.cip-project.org=bounce+64572+5435+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF84C433E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947DC21741
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FYbtKvJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947DC21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5435+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qFCRYY4521723xP3zU8MuPTF; Wed, 09 Sep 2020 00:03:11 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8077.1599634990206299249
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 00:03:10 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A717F1C0B79; Wed,  9 Sep 2020 09:03:07 +0200 (CEST)
Date: Wed, 9 Sep 2020 09:03:07 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: "Chen-Yu Tsai (Moxa)" <wens@csie.org>, nobuhiro1.iwamatsu@toshiba.co.jp,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 04/11] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Message-ID: <20200909070307.GE27139@duo.ucw.cz>
References: <20200909044233.4115-1-wens@csie.org>
 <20200909044233.4115-5-wens@csie.org>
 <20200909064530.GC27139@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200909064530.GC27139@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g0TSfC37ztlsqsYavcO98dBex4520388AA=
Content-Type: multipart/mixed; boundary="uWljBmDAecyHjJxWeFjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599634991;
 bh=vYi83vGxMMF/umxE/PdvEwdF4udrns1J5TNJ9ibBzTo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FYbtKvJe8vhWvCuRMlCSysa50l/+TouErZuGTTTsYFDRPS7fW11oepWuPLKGOp+Ax+i
 YAlFeHcw18SXr7dpKiSJmUKMSkNOPOmXo//dro+hTRP1LZtJK4xHevT7lHV70GqgNuCn4
 kKZujHjVw/IQeERokqTdSTkvFS18fHeCw78=

--uWljBmDAecyHjJxWeFjZ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline

--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +	ret =3D ti_cpufreq_get_efuse(opp_data, &version[1]);
> > +	if (ret)
> > +		goto fail_put_node;
> > +
> > +	of_node_put(opp_data->opp_node);
> > +
> > +	ret =3D PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
> > +							  version, VERSION_COUNT));
> > +	if (ret) {
> > +		dev_err(opp_data->cpu_dev,
> > +			"Failed to set supported hardware\n");
> > +		goto fail_put_node;
> > +	}
>=20
> of_node_put() is done twice in the last error path.

Aha, it is fixed in subsequent patches. Sorry for the noise.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1h+KwAKCRAw5/Bqldv6
8nR8AJ9uxD3Rp9iP2rsZUrIhv8T2goaCdgCeJf6Ka/tKaZIPzfIAHShd7t1TAnc=
=uV2W
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--

--uWljBmDAecyHjJxWeFjZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5435): https://lists.cip-project.org/g/cip-dev/message=
/5435
Mute This Topic: https://lists.cip-project.org/mt/76726425/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uWljBmDAecyHjJxWeFjZ--
