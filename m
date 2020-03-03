Return-Path: <SRS0=W4f2=4U=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7650C3F2CD
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 09:23:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C23320863
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C23320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76CCC8571C;
	Tue,  3 Mar 2020 09:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAB0xvQjYanC; Tue,  3 Mar 2020 09:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1434D85191;
	Tue,  3 Mar 2020 09:23:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E09C013E;
	Tue,  3 Mar 2020 09:23:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4926C013E
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D3F9C8535F
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HkpnH1ieUDgQ for <cip-dev@lists.cip-project.org>;
 Tue,  3 Mar 2020 09:23:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A978085065
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 09:23:46 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 6EDC21C031E; Tue,  3 Mar 2020 10:23:44 +0100 (CET)
Date: Tue, 3 Mar 2020 10:23:43 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Message-ID: <20200303092343.GA11594@duo.ucw.cz>
References: <20200303091556.GA10040@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200303091556.GA10040@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Type: multipart/mixed; boundary="===============6261005636808512752=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============6261005636808512752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-03-03 10:15:56, Pavel Machek wrote:
> Hi!
>=20
> I pushed candidate for -cip-rt, but it seems to fail on de0-nano
> board. Code under testing is at:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-c=
ip

It is pipeline

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/122762401

I'll reuse the branch for more testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXl4iHwAKCRAw5/Bqldv6
8ouAAKC05c3Mf0umwDzxpburCW6EGBs3UgCfdUZtwqmAPhMeLmM5Kci33WJSSSI=
=69Ht
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============6261005636808512752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============6261005636808512752==--
