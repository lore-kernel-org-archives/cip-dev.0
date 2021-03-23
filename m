Return-Path: <SRS0=zpZM=IV=lists.cip-project.org=bounce+64572+6314+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83776C433DB
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 11:14:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBC86198C
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 11:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC86198C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6314+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id otHLYY4521723xdNxmC7Hh6Q; Tue, 23 Mar 2021 04:14:06 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7162.1616498045394704652
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Mar 2021 04:14:05 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BDCD31C0B81; Tue, 23 Mar 2021 12:13:56 +0100 (CET)
Date: Tue, 23 Mar 2021 12:13:56 +0100
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.262-cip55-rt34
Message-ID: <20210323111356.GA13299@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FgGi22ICQyd2dElTwd3CTPtQx4520388AA=
Content-Type: multipart/mixed; boundary="KfP2uRB6JoC1D8LlAwxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616498046;
 bh=7iBxcjESi5gXOhhso1I03FnkNyvaz9Hkh7IiLVTwUE4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VtGO5NzTT/QSCnQuVhrdtXg15IMsJiNT5OujZv5WGqg40ELLlymAok22GfZEIMC+2PH
 gI3Jcp/AA2s2DCkrU+NvWe5yfu0af4mmQQfTrrVZJ3NJBrPlhCsvEoW2FEoEDoJLmEsYS
 9rrWNIVvFptAOZAZuS3YNpsjBDp/PNlo/HE=

--KfP2uRB6JoC1D8LlAwxG
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Upstream reports a known issue:

  - locktorture reports a might_sleep warning for spin_locks test

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFnNdAAKCRAw5/Bqldv6
8uW5AJ9sUj4vplE5rxI+/siNZBDkIYknTACeKE+zOOl1tG2Ya+Eiq48Jwabzvuk=
=A3Wp
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--KfP2uRB6JoC1D8LlAwxG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6314): https://lists.cip-project.org/g/cip-dev/message=
/6314
Mute This Topic: https://lists.cip-project.org/mt/81547988/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KfP2uRB6JoC1D8LlAwxG--
