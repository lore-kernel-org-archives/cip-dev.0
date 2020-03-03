Return-Path: <SRS0=W4f2=4U=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536CFC3F2CD
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 09:16:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12680214D8
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 09:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12680214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C086185308;
	Tue,  3 Mar 2020 09:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwvOM-ZZq5tT; Tue,  3 Mar 2020 09:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EA3B857D8;
	Tue,  3 Mar 2020 09:16:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F30C013E;
	Tue,  3 Mar 2020 09:16:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11364C013E
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E07D8620F
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIMVG5V6mtKC for <cip-dev@lists.cip-project.org>;
 Tue,  3 Mar 2020 09:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3215286044
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:16:01 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 9B4F91C031E; Tue,  3 Mar 2020 10:15:56 +0100 (CET)
Date: Tue, 3 Mar 2020 10:15:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Message-ID: <20200303091556.GA10040@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Subject: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Type: multipart/mixed; boundary="===============4967653075159135552=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============4967653075159135552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I pushed candidate for -cip-rt, but it seems to fail on de0-nano
board. Code under testing is at:

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip

So far testing fails, I did few steps to narrow it down.

? 0f2960c75dd68d339f0aff2935f51652b5625fbf 4.19.106-rt44
? 68541faf398c02bfa6a65ffcf4484e71b8e0306d v4.19.103-cip20.
ok  122663369 c7691f9c497d0f8393724875a8875b61daa9fc29 v4.19.100-rt41.
? b7f7a3d15716de6d78b6d4807e23fa46de106c2f v4.19.103-rt42.
ok  122667425 51184ac81b2de92545a3b9d330d4d53a176e0976 v4.19.104-rt43.
bad 122671461 f019fe97731d222ee59ac8e54a62753e9c69ef31 v4.19.106-rt44.
bad 122657523 881b771ab11616e2aab6e914d950467f7c8914bd v4.19.106-cip21.

So it seems failure was introduced between v4.19.104-rt43 and
v4.19.106-rt44. Unfortunately, I don't understand the logs enough to
know what the real failure is. If someone can help...

I'll proceed to narrow it down.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXl4gTAAKCRAw5/Bqldv6
8l9pAKCxl1bQ8BZIU4pfqolGX70GkJyo3wCgpLR5X8Jby2hUQ9xdB7AUs0WOwMI=
=uLvq
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============4967653075159135552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============4967653075159135552==--
