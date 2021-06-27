Return-Path: <SRS0=kp/+=LV=lists.cip-project.org=bounce+64572+6585+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76037C48BC2
	for <cip-dev@archiver.kernel.org>; Sun, 27 Jun 2021 08:38:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728B3619D1
	for <cip-dev@archiver.kernel.org>; Sun, 27 Jun 2021 08:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B3619D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6585+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AbxZYY4521723xFsr3GllECB; Sun, 27 Jun 2021 01:38:06 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.3031.1624783085468704769
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Jun 2021 01:38:06 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EBD3C1C0B76; Sun, 27 Jun 2021 10:38:00 +0200 (CEST)
Date: Sun, 27 Jun 2021 10:38:00 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, masashi.kudo@cybertrust.co.jp
Subject: [cip-dev] CVE-2021-3444 and CVE-2021-20292
Message-ID: <20210627083800.GA24489@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xPvd5z5MhOPJA9NRM8jAgS4hx4520388AA=
Content-Type: multipart/mixed; boundary="X6IccsrMlfekGUXo0kdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624783086;
 bh=nkbprHH9Vu4xkup3XO0fSkwcs9PHXPIVt0CVF6c0fRU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c2Ci44mHJnFzPdKykEPe+iPQ2fwZiDk4MShrWvuwmnc9ppvNWECfgpsFwYLjtrMG0Z1
 v3kqH+gnzwXlhP4jSBDjo77rFspHQJTfy8RCoEKP+Rv8fLGpRdjKbSKHN3DC+POmtgOyE
 k5F6ARUVXzeMc7GXnl0gpq1J09tDhfcFLlg=

--X6IccsrMlfekGUXo0kdH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

We have outstanding action item about these two, but at this point I
believe we should simply start monitoring these:

CVE-2021-3444 -- this is about BPF handling. It does not look like
easy backport, and BPF has ton of other issues (especially with
respect to speculative execution), and my recommendation would be to
avoid BPF. My impression is that BPF is not really focus of CIP
project (we may want to ask members if anyone is using it?).

CVE-2021-20292 -- this is basically non issue. First, DRM is not
exactly our focus, but more importantly, this is only issue if
attacker already has root.

quoting: https://bugzilla.redhat.com/show_bug.cgi?id=3D1939686

There is a flaw reported in ... DRM subsystem. .... An attacker with a
local account with a root privilege, can leverage this vulnerability
to escalate privileges and execute code in the context of the kernel.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNg46AAKCRAw5/Bqldv6
8oakAKC/dyQ8s8NyVc1n2HJ0d6idwPAi/QCgqeL9WwWsXr5NfbIMIE86nyvOATY=
=KSbC
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--X6IccsrMlfekGUXo0kdH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6585): https://lists.cip-project.org/g/cip-dev/message=
/6585
Mute This Topic: https://lists.cip-project.org/mt/83819975/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--X6IccsrMlfekGUXo0kdH--
