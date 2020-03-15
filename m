Return-Path: <SRS0=bYQk=5A=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AADC10DCE
	for <cip-dev@archiver.kernel.org>; Sun, 15 Mar 2020 09:42:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FA3206E9
	for <cip-dev@archiver.kernel.org>; Sun, 15 Mar 2020 09:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FA3206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 47FD688BEF;
	Sun, 15 Mar 2020 09:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ur0a0KDZKgUB; Sun, 15 Mar 2020 09:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 649DD88AF7;
	Sun, 15 Mar 2020 09:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5678EC013E;
	Sun, 15 Mar 2020 09:42:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCB5C013E
 for <cip-dev@lists.cip-project.org>; Sun, 15 Mar 2020 09:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 718BE20487
 for <cip-dev@lists.cip-project.org>; Sun, 15 Mar 2020 09:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4y2lhS0DZUb9 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Mar 2020 09:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id B3E8B20349
 for <cip-dev@lists.cip-project.org>; Sun, 15 Mar 2020 09:42:06 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 2A4E31C032D; Sun, 15 Mar 2020 10:42:02 +0100 (CET)
Date: Sun, 15 Mar 2020 10:42:01 +0100
From: Pavel Machek <pavel@denx.de>
To: "Bhola, Bikram" <Bikram_Bhola@mentor.com>
Message-ID: <20200315094201.GA23740@duo.ucw.cz>
References: <20200303091556.GA10040@duo.ucw.cz>
 <20200303092343.GA11594@duo.ucw.cz>
 <20200303171049.GB24044@duo.ucw.cz>
 <20200303212826.GA16402@duo.ucw.cz>
 <fe189e62-baee-4f6a-cc19-295c4c023dc7@siemens.com>
 <20200309102132.GB18031@duo.ucw.cz>
 <c3f20059-7663-b216-a799-14cb943669ea@siemens.com>
 <78fd4f1df8034021ae195b8287cf2f29@SVR-IES-MBX-03.mgc.mentorg.com>
 <a9aa2dd7e7fd43eca840d7825e835ffc@SVR-IES-MBX-04.mgc.mentorg.com>
MIME-Version: 1.0
In-Reply-To: <a9aa2dd7e7fd43eca840d7825e835ffc@SVR-IES-MBX-04.mgc.mentorg.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] I need de0-nano testing for -rt release was Re:
 4.19.106-cip21-rt8 problems on de0-nano
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
Content-Type: multipart/mixed; boundary="===============1884992476296343442=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============1884992476296343442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Both de0-nano and IPC227E targets are up and running. I have monitored fo=
r test jobs on it and those completed successfully.=20
>=20
> Thank You!!

There's still something broken with the testing. renesas_shmobile
initially failed (okay after restart), rest failed:

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/126355890

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXm34aQAKCRAw5/Bqldv6
8vbvAJ9UrlgAeTBTnY5yeazvYSs6IkGBRgCeNbZO5jPAXWltrp1eknHhB++eZmE=
=g3lj
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============1884992476296343442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1884992476296343442==--
