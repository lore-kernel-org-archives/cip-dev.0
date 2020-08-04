Return-Path: <SRS0=l/S7=BO=lists.cip-project.org=bounce+64572+5090+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3808C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 08:59:33 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFE92075D
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ifSk04QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFE92075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5090+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1kkJYY4521723xtwYRBflu5J; Tue, 04 Aug 2020 01:59:33 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1604.1596531571134106065
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 01:59:31 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D69021C0BDD; Tue,  4 Aug 2020 10:59:25 +0200 (CEST)
Date: Tue, 4 Aug 2020 10:59:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.135-cip31-rt13
Message-ID: <20200804085925.GA8792@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MuYjhkj4evWKsroq2mQapiLEx4520388AA=
Content-Type: multipart/mixed; boundary="LMvtMBqAfM7bOSh17f2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596531573;
 bh=hGzCyd+vkufypmMWnKtX9pwfOAP5mK2yUrckuG361/o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ifSk04QCbwOIqsvEFK3k8hccTwCeTwqK3q5PLsmL9t85v5oUmPn2PZ0AGUbNa1QtPC1
 oXBi3KYZx78CMe31wjEWEWTC96ScM8O3JRon8LfyLr9usZBp83H5JHPzPDOkKz0Oc+Dle
 2LxGmliHTA9SwqWXtOPiaCSxMWGyUgazqeU=

--LMvtMBqAfM7bOSh17f2J
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.135-cip31-rt13 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

There should be nothing interesting in this update.

Best regards,
                                                                Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXykjbQAKCRAw5/Bqldv6
8hcaAJ4nagRrwOkFme2RCyatCH+OxGLYWgCfQL+582UuPDAkedY986UiaJjQcpc=
=4+Jb
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--LMvtMBqAfM7bOSh17f2J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5090): https://lists.cip-project.org/g/cip-dev/message=
/5090
Mute This Topic: https://lists.cip-project.org/mt/75983416/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LMvtMBqAfM7bOSh17f2J--
