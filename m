Return-Path: <SRS0=Tvce=5O=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D12C43331
	for <cip-dev@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428A12076A
	for <cip-dev@archiver.kernel.org>; Sun, 29 Mar 2020 17:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428A12076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BE8A86200;
	Sun, 29 Mar 2020 17:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rlq-kVGOBRl; Sun, 29 Mar 2020 17:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63C01860B2;
	Sun, 29 Mar 2020 17:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48CCFC07FF;
	Sun, 29 Mar 2020 17:57:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18472C07FF
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 17:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 026858735E
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 17:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cRTjN3v5PlRU for <cip-dev@lists.cip-project.org>;
 Sun, 29 Mar 2020 17:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3206B86E15
 for <cip-dev@lists.cip-project.org>; Sun, 29 Mar 2020 17:57:49 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 2015D1C0323; Sun, 29 Mar 2020 19:57:41 +0200 (CEST)
Date: Sun, 29 Mar 2020 19:57:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Message-ID: <20200329175740.GA32392@duo.ucw.cz>
References: <20200329105752.GA8804@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200329105752.GA8804@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.4-rt: Need testing on arm32
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1916908633521455910=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============1916908633521455910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I tried to prepare next 4.4-rt release. I have code ready, but while
> running tests I realized that only two targets are used to run them.
>=20
> We 4.19-rt has known bugs breaking boot on de0-nano (and probably
> other) boards, and according to code inspection, same bug is present
> in 4.4-rt. Fix is not complex, but I'm not comfortable applying it
> without _any_ testing.
>=20
> If I'm right, 4.4-rt should be broken on socfpga boards (arm32) in
> non-realtime configuration; it should panic on boot in cca 50% of
> cases. Patch below should fix it.

And I pushed code _without_ the patch to kernel.org,

To gitolite.kernel.org:pub/scm/linux/kernel/git/cip/linux-cip.git
   924af895a033..fbc533f445d2  linux-4.4.y-cip-rt -> linux-4.4.y-cip-rt

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoDhlAAKCRAw5/Bqldv6
8ugDAJ4o7ANFyycTSjQtyQiyiUd/Mv0bXwCfYtBrxHOaNas1meKhL3Sb19hCBCw=
=ZGqn
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--===============1916908633521455910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1916908633521455910==--
