Return-Path: <SRS0=Cco9=GK=lists.cip-project.org=bounce+64572+6053+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40499C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 15:48:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B77B23428
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B77B23428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6053+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nvtlYY4521723x6PpLBTSjy0; Thu, 07 Jan 2021 07:48:00 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.10167.1610034479641884128
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Jan 2021 07:48:00 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1DC521C0B81; Thu,  7 Jan 2021 16:47:55 +0100 (CET)
Date: Thu, 7 Jan 2021 16:47:54 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-07
Message-ID: <20210107154754.GA9524@duo.ucw.cz>
References: <CAGb2v65+1w18yz2R=GbxrFtq_RZO4afHry-DMgj83NGKsttBgQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65+1w18yz2R=GbxrFtq_RZO4afHry-DMgj83NGKsttBgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aVzxexF404DgfxB9BfJ6qi5qx4520388AA=
Content-Type: multipart/mixed; boundary="zPodWVJiCNIMMo1WUOLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610034480;
 bh=EpogXRyaRF7EGycyIEzyeerlWfF+qmBxB2iiYwMjCfw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aCMaxwC6Fj+C/EB6yI7AVomz63tYmbglhi7MKBbfYG6p56mC5V0nhV+ffE7IoPGuaxI
 ZlPBb9vseMR27MFYTAZjhILuCyXKJt+9yQX0NljZDEQvZag8UMam8Fa89PluKUI2b8kb1
 yHlO1aZn6/q8mrWp6w8ouLLgYZ98+xA3lxE=

--zPodWVJiCNIMMo1WUOLX
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Three new issues this week:
>=20
> - CVE-2020-36158 [mwifiex] - fixed in mainline; needs backport

This afternoon backports of this one were queued to all branches
relevant to us:

v |2ee7362d6 5c455c o: 5.10| mwifiex: Fix possible buffer overflows in mwif=
iex_cmd_802_11_ad_hoc_start
v |69c37921f 5c455c o: 4.19| mwifiex: Fix possible buffer overflows in mwif=
iex_cmd_802_11_ad_hoc_start
a |3a1e2e3e4 5c455c .: 4.4| mwifiex: Fix possible buffer overflows in mwifi=
ex_cmd_802_11_ad_hoc_start

=2E..so it seems this is going to be handled without our intervention.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/ctKgAKCRAw5/Bqldv6
8hC0AKC+5lHTazlGnd8kCkR1iFA66zl5EACfe3HU8+MBSb/fAh0qzuDDMi+a+yQ=
=Wvz4
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--zPodWVJiCNIMMo1WUOLX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6053): https://lists.cip-project.org/g/cip-dev/message=
/6053
Mute This Topic: https://lists.cip-project.org/mt/79494128/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zPodWVJiCNIMMo1WUOLX--
