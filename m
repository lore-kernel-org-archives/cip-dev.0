Return-Path: <SRS0=UkFi=MT=lists.cip-project.org=bounce+64572+6633+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF07C4338F
	for <cip-dev@archiver.kernel.org>; Tue, 27 Jul 2021 09:36:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939AA6135A
	for <cip-dev@archiver.kernel.org>; Tue, 27 Jul 2021 09:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 939AA6135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vRsiYY4521723xBSt1O1DIDY; Tue, 27 Jul 2021 02:36:04 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9166.1627378562638518100
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jul 2021 02:36:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 677F51C0B76; Tue, 27 Jul 2021 11:35:50 +0200 (CEST)
Date: Tue, 27 Jul 2021 11:35:50 +0200
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.198-cip54-rt21 (-rt85)
Message-ID: <20210727093550.GA10787@duo.ucw.cz>
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
X-Gm-Message-State: kupWbzTzQ2xHs5dHyGSYQNZHx4520388AA=
Content-Type: multipart/mixed; boundary="G3LLBouVHrgq4fSKBb9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627378564;
 bh=XCR+KiDG2lOVfeOQIV0UrtjYI1e2Z1jnkAmeMNPa1iI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YHL71FLGPJpoOzQSzJwXRlc9IXA6jquwEfL4WnYU9Xj+fQZbRqYdSDDvWqbEq+y5MJH
 M9sCTnZp/n6q6E8BKV4hsbRtccJBnkGTcNRS4A8CQIVCagZzo4i5UUFgme6mumE7OUaNq
 0SU0QlEEeAwT2hYNtuAi8NA6V4az/HDuO7k=

--G3LLBouVHrgq4fSKBb9P
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline

--PEIAKu/WMn1b1Hv9
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

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYP/TdgAKCRAw5/Bqldv6
8lM4AJ9wdSp7hrVoqEK48aSa5rasZBdmPwCfY0v22z61wkekpAXemmFADbcA7iE=
=LJjN
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

--G3LLBouVHrgq4fSKBb9P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6633): https://lists.cip-project.org/g/cip-dev/message=
/6633
Mute This Topic: https://lists.cip-project.org/mt/84478100/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--G3LLBouVHrgq4fSKBb9P--
