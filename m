Return-Path: <SRS0=UcL5=EI=lists.cip-project.org=bounce+64572+5710+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5517C2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 11:39:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0884207C3
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DM8iP0EE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0884207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5710+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dbHIYY4521723xkzoNtz3xSB; Mon, 02 Nov 2020 03:39:12 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.30053.1604317151617793249
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 03:39:11 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA3171C0B8E; Mon,  2 Nov 2020 12:39:06 +0100 (CET)
Date: Mon, 2 Nov 2020 12:39:06 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] cip-kernel-sec Updates for Last Week of October
Message-ID: <20201102113906.GC9840@duo.ucw.cz>
References: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HAqazCyPHiskom68cCzdhCoix4520388AA=
Content-Type: multipart/mixed; boundary="BYzcXNBv281GaT2cToob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604317152;
 bh=2y/kQ2wu9A6fqXhAI6krIPowdsB4kjtWvY3mGwJC6pU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DM8iP0EEvV/SxzdJENXzz9iCzljcDCn2JIsAxk9s2EPIIm2q17mddXNrxQp/f/iVFfs
 fwDXDvQxDnL8nBVUkKT0hoiueyxouhXHfdHEarbjIp0bCe7lRcVwHLRXFdL8eDZbBSnwI
 B+pU7+jXG83efQ4m7hP7/lwbeH5Cc4W03T4=

--BYzcXNBv281GaT2cToob
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline

--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> - Fix for CVE-2020-27673 has not been backported yet.

Some kind of Xen issue, not really relevant to us, and fix is not
easy.

I'd say we can ignore this one.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5/v2gAKCRAw5/Bqldv6
8hgZAJsEX779JokBnqtOK5RsYDCGtqysWQCfW2nmvch8ozRHhiK+LTGE1Mum+gU=
=lhe+
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--

--BYzcXNBv281GaT2cToob
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5710): https://lists.cip-project.org/g/cip-dev/message=
/5710
Mute This Topic: https://lists.cip-project.org/mt/77879900/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BYzcXNBv281GaT2cToob--
