Return-Path: <SRS0=eHck=GY=lists.cip-project.org=bounce+64572+6128+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A8C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 12:15:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474902065C
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 12:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474902065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6128+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FUsUYY4521723xxqohB9u6a6; Thu, 21 Jan 2021 04:15:39 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.6123.1611231338287576984
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jan 2021 04:15:38 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0517A1C0B9D; Thu, 21 Jan 2021 13:15:23 +0100 (CET)
Date: Thu, 21 Jan 2021 13:15:22 +0100
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.165-cip41-rt18
Message-ID: <20210121121522.GA19714@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XdPTLmL2SiQbNDHoS8uTTMX7x4520388AA=
Content-Type: multipart/mixed; boundary="AxWfvCSMiBAuwgrAmqFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611231339;
 bh=8X8iRzVqff/QdMMdizsXZZSX5ijKWkq4La9GEdcp7rA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SASGE7qq11AxRGVrTziBKTwW8RmvIm91DPZCxvUNe/YipDpnfLcTYI7T0W2+55SZ8Te
 9KENjGihEPIlCFcau7zAYFcLlHyn2WcgQHYUG/cr3A8e2bWt3WePux1qM1iXmktZWFH8O
 y91HYN1phnTlxuZ4ScN8x9QZcalsXhjmiMQ=

--AxWfvCSMiBAuwgrAmqFu
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYAlwWgAKCRAw5/Bqldv6
8sETAKCPDrBlout8QVrIMgl5iz7OO5YDawCgtti93lsPWn6G3Y8PuKZw4hNvvvo=
=CSbd
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--AxWfvCSMiBAuwgrAmqFu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6128): https://lists.cip-project.org/g/cip-dev/message=
/6128
Mute This Topic: https://lists.cip-project.org/mt/80002118/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AxWfvCSMiBAuwgrAmqFu--
