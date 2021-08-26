Return-Path: <SRS0=ezA5=NR=lists.cip-project.org=bounce+64572+6706+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CD1C4320E
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 10:01:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA7F60FDA
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 10:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBA7F60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Mp4gYY4521723xIZMkmpDJnG; Thu, 26 Aug 2021 03:01:11 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.28300.1629972069738042996
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Aug 2021 03:01:10 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BEF951C0B81; Thu, 26 Aug 2021 12:01:03 +0200 (CEST)
Date: Thu, 26 Aug 2021 12:01:02 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210826100102.GA5190@duo.ucw.cz>
References: <CAODzB9qV4uxi2EHoPbK8D_mW6cO-Ni2x+tVUMAUYzKGK7y+COw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9qV4uxi2EHoPbK8D_mW6cO-Ni2x+tVUMAUYzKGK7y+COw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8acHa8QmYJeHk65FPmi2KpKwx4520388AA=
Content-Type: multipart/mixed; boundary="wPSSeyvh0ZWmWnhwQ6T7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629972071;
 bh=FBMTFlgHZ4wMQCwczwQlKFPMMFRAttJN4vGIGVVMWMA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hhDwf4K35FUO/zdVXJ1fVD6kqfh0+Uv3eEFDsi/+bUP4vbDok5E0k+vSYwM6RFYl62h
 9wzmHMWr2Vdt10DTgLr3ixhNtuhICMUxKCQRm0c/0DU1I0SbFBfzQWBu5NEh2MjUpQr1f
 Q732cRgbzKaSEJef4lk/uAyIwa0KGt/Op48=

--wPSSeyvh0ZWmWnhwQ6T7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> New CVEs
>=20
> CVE-2020-3702: Specifically timed and handcrafted traffic can cause
> internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
> encryption with a consequent possibility of information disclosure
> over the air for a discrete set of traffic
>=20
> This CVE affects ath9k driver.
>=20
> Fixed status
>=20
> mainline: [56c5485c9e444c2e85e11694b6c44f1338fc20fd,
> 73488cb2fa3bb1ef9f6cf0d757f76958bd4deaca,
>   d2d3e36498dd8e0c83ea99861fac5cf9e8671226,
> 144cd24dbc36650a51f7fe3bf1424a1432f1f480,
>   ca2848022c12789685d3fab3227df02b863f9696]

At least some of the relevant fixes are queued for
5.10.61/4.19. Likely this will resolve itself.

> CVE-2021-3600: eBPF 32-bit source register truncation on div/mod
>=20
> The vulnerability has been introduced since 4.15-rc9. 4.4 is not
> affected. 4.19 is not fixed yet as of 2021/08/26.
>=20
> mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
> stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
> stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]

I took a look into this. Apparently 4.14 and 4.19 is affected. (
https://seclists.org/oss-sec/2021/q2/228 )

Due to BPF 32-bit subregister requirements (see bpf_design_QA.rst)
top 32 bits should be always zero when the 32 bit registers are in
use. So it could be possible to use BPF_JMP instead of BPF_JMP32.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYSdmXgAKCRAw5/Bqldv6
8jAMAJ0d88+XlBCb+EpQLui4xtTrE5xb3gCbBH3VwvyDgPavvhXVSU5YIPWFCaA=
=Ohsx
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--wPSSeyvh0ZWmWnhwQ6T7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6706): https://lists.cip-project.org/g/cip-dev/message/=
6706
Mute This Topic: https://lists.cip-project.org/mt/85151460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wPSSeyvh0ZWmWnhwQ6T7--
