Return-Path: <SRS0=Afy8=CS=lists.cip-project.org=bounce+64572+5433+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C50C43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:45:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCDE20936
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Dp2pa/6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCDE20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5433+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id keoEYY4521723xM4n0q1RXEQ; Tue, 08 Sep 2020 23:45:37 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7977.1599633936182523335
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 23:45:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A851F1C0B79; Wed,  9 Sep 2020 08:45:30 +0200 (CEST)
Date: Wed, 9 Sep 2020 08:45:30 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 04/11] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Message-ID: <20200909064530.GC27139@duo.ucw.cz>
References: <20200909044233.4115-1-wens@csie.org>
 <20200909044233.4115-5-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200909044233.4115-5-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N9FfAddiQhIQoNTwayw81ODRx4520388AA=
Content-Type: multipart/mixed; boundary="5s7Qr3g2pHge4ch1VDle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599633937;
 bh=hY5NS07Ly4A32vQ/pe01o9WVL4x8RNV9qHiqHtAjCdM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Dp2pa/6ghvs3Pf/HBQ/gC9zQMNxyhyUw5fiAkKYaR6DKLpOdoaTCtRENbWDDJH0YPiB
 sqyGc7n/F7TCT7fennB74Q2EPVHnrLoa20yb6eLUpdTms0k6O5+dxTXifXgZsor1uk4wS
 julg61GnxogkaHPOQs2CxJ7UMoQviMx2JdY=

--5s7Qr3g2pHge4ch1VDle
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +	/*
> +	 * The efuse on dra7 and am57 parts contains a specific
> +	 * value indicating the highest available OPP.
> +	 */
> +
> +	switch (efuse) {
> +	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
> +	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
> +		calculated_efuse |=3D DRA7_EFUSE_HIGH_MPU_OPP;
> +	case DRA7_EFUSE_HAS_OD_MPU_OPP:
> +		calculated_efuse |=3D DRA7_EFUSE_OD_MPU_OPP;
> +	}

Some kind of fallthrough marking would not be bad.

> +	ret =3D ti_cpufreq_get_efuse(opp_data, &version[1]);
> +	if (ret)
> +		goto fail_put_node;
> +
> +	of_node_put(opp_data->opp_node);
> +
> +	ret =3D PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
> +							  version, VERSION_COUNT));
> +	if (ret) {
> +		dev_err(opp_data->cpu_dev,
> +			"Failed to set supported hardware\n");
> +		goto fail_put_node;
> +	}

of_node_put() is done twice in the last error path.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1h6CgAKCRAw5/Bqldv6
8p+PAJ0fz/3IwaDPgnRjjXPoyXH3l5fNHwCfS9fFr8Ir1wJxkrxDbRmePFb5x4Q=
=Qoee
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

--5s7Qr3g2pHge4ch1VDle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5433): https://lists.cip-project.org/g/cip-dev/message=
/5433
Mute This Topic: https://lists.cip-project.org/mt/76726425/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5s7Qr3g2pHge4ch1VDle--
