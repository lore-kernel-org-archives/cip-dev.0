Return-Path: <SRS0=ys6V=6F=lists.cip-project.org=bounce+64572+4591+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C588C2BA19
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:19:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0346F2098B
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GQ6TGtC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0346F2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4591+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id F6utYY4521723xEOsAk0Maf2; Tue, 21 Apr 2020 01:19:25 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.98])
 by mx.groups.io with SMTP id smtpd.web12.4700.1587457163773308744
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2020 01:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7bVyHAox8CC3oYUegxPjmT5zyd/te8HX0KNBSNWxy3sjWvOKH/QjPBeEMSLY9atxOhZRf/LtPlI63OA9mYL+TaWVrBUvuuDZ4yuyO72UJ6WIkFZ583kep/5ZUVUj0pERCQwmQ6yU4n6/sDhYHAlhOr34IbG4qlptC36hC+qXPRR2eCyv2ut0nm1PQnHqYHSB90/EtX7Q7RV8Pfr8BzY1hJUstEAHOcxtJwkY3S7VWaMw+tdj6W4T9OS3Y8m7O70vtt0gzXP8bp/gjsewQd9pj4Rsb0X2vDmOUkAW0DLTtCEB5TzUbEqjCm/NdvdW34OPA055m317SCtkTfHn7xNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSGjugHpDEcSVnTKQ6mJ8TwFzx6G8mWxRY6YOShk0dc=;
 b=c44JKWTE/7MtBQy5YumbgOovgk5pdThOiz7zLOWxIFd9Ca/Pkbf8aaLrCn0gOEOtV9YpRU+Nh5BmaA1dD5wKO1rlPeIA92K1Bd1K84C2kmEJZdVZo57+JHIKNnfqgfbB74+5u1S9qL2Tc1eJQTVbhQPHgve9BZWQhyTX+s5lY2Ir9hWn1NyseSdD+cL85a06JaXVbxAXHmOLqqInyyf+GCPEaSbbJnTmzhh5ItKApMyzMcX6nHOfRLBZL/5hmYbW2lkq8mfZbt9cwMmbwFmxQ3CXQDjPT1QKkd90SzlxmB4coq/HA3rrbo4XnW+0K06E5naGEQ2bA6YTO7OZ6J9jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB1608.jpnprd01.prod.outlook.com (52.134.225.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Tue, 21 Apr 2020 08:19:20 +0000
X-Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::383a:9fc3:aaa4:d3b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::383a:9fc3:aaa4:d3b%7]) with mapi id 15.20.2900.030; Tue, 21 Apr 2020
 08:19:20 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel Machek
	<pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr binding
Thread-Topic: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr
 binding
Thread-Index: AQHWF1B+WpdgTb4gpkSyr/xPCSuD8aiDNo4g
Date: Tue, 21 Apr 2020 08:19:20 +0000
Message-ID: 
 <OSBPR01MB359064AC4D27A061E7671640AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: 
 <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587412250-16752-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200420201554.GA15616@duo.ucw.cz>
In-Reply-To: <20200420201554.GA15616@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7774ee59-2bd4-4371-9dec-08d7e5ccb122
x-ms-traffictypediagnostic: OSBPR01MB1608:|OSBPR01MB1608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB1608C1E84E3A4BA38C5CE9AFAAD50@OSBPR01MB1608.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 XC9xACRwXr6A0knZSDOjdlHk4yM9e+aug7jVz78FdjyPCzbYxFUW+mSgkKt1IGEBIRaoV7op1C+PotYBcwdwYiuxbWJR6/mLW+N/91LAq7KogC8FlvkTK1YIWge3H7KcvFL+ZOoxUWpkt6Hv/EdySJ0DXiQ8ypvtx3iq+DjtiG0nw11ZdINVdVe9wAA6AD+mKOtPH9AYzZ63r/Nqn6eF4kMg5bnbSdzJGmSUogkZ/FhDtTb5Ga4wTsVBBxwzmajfyMnj5WkfTNjwvkZBgXRzKyCotPGsru4lJ+hYaqOc6KDeS6ELCTJCb70extGBZAcK9ESjHah9vLNDaOyYZ5fCkGJCisJxMacGMVKfyW81e2OOlCQprRCy3FvykWerOmbZg1Bq1JxlWp6sUHkZry0RSlvHuv9pPgE3MyzKnME7bk+UAylb/xn825CWGWa/6N+0dR5Y2mARQwx4wNCMcEc8sG3vOFoDtIHK4+zZnl5Iz7YdZCcvolpKcC2/TZgt1fj/WV6Y9CdCGzqlLk+2gXiyJg==
x-ms-exchange-antispam-messagedata: 
 D8T/qepwzqsHKdnelPw9zjLue7bRS0oChWctTgisquSWJ/sehV1PB1T2X5bEFzWcQWx1/z3OvN4ZlBvYYlK83VtkdHm//ftw8s2ldxFnYxqFmd2Vltbfduo7sxSg0rHyn39Af0ZoRMz7t2Y3oEGd7w==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7774ee59-2bd4-4371-9dec-08d7e5ccb122
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 08:19:20.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaAP+WKGaSR0BDGRVC2n6F37t2eRJ8AnhplDWNbfcql5WptH1Vjc9x5Cc+bxK+gK1e9gC3Jj7vXz3Ya+JzxVn59WqAEDr/LXXrj4bokkM8/+WAQn+rdRKzM9o8AlaXEi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1608
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: a0ZRpQ02tn4IufvCIGdpcN1Sx4520388AA=
Content-Type: multipart/mixed; boundary="cUEe80wP20tYCwldNsqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587457165;
 bh=7mWtgCfGpBUeZdJCmPICt7KjNhlhiyL4aBSqaLodAXc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=GQ6TGtC6H/9IWWKNPoyJzo+M0e0mudqZwFjABUA8exPyPDED+uZg9pSqMC4YnCH9mZl
 CrzIXVNrAXJIUIxT3EyA81fdXFjmK7VMRTxfAM4p7qH4cgymimKiBsUu/+0Li1WJvibnA
 Pmm5XAM1hJftppO8thoonIKeBYyMzKlgNx0=

--cUEe80wP20tYCwldNsqo
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: 20 April 2020 21:16
> To: cip-dev@lists.cip-project.org
> Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <p=
avel@denx.de>; Chris Paterson
> <Chris.Paterson2@renesas.com>
> Subject: Re: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr b=
inding
>
> Hi!
>
> > Add binding for the idk-1110wr LVDS panel from Advantech.
> >
> > Some panel-specific documentation can be found here:
> > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-LCD-Kit-Modules/mod=
el-IDK-1110WR-55WSA1E.htm
> >
> > This patch is based on commit d26087162857b12bd9d0424f2dea2cd9654e50a0
> > upstream ("dt-bindings: display: Add idk-1110wr binding") which adds ya=
ml
> > bindings.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Okay. In future, I believe we can take yaml binding, even for kernel
> where yaml support is not included. The markup is designed to be
> human-readable anyway.
>
Thanks I shall do that in future. Just for reference in case a yaml binding=
 has a reference to other yaml binding  so should there be a patch for conv=
erting to yaml format (for example panel.txt -> panel.yaml) ?

Cheers,
--Prabhakar

> Best regards,
> Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--cUEe80wP20tYCwldNsqo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4591): https://lists.cip-project.org/g/cip-dev/message=
/4591
Mute This Topic: https://lists.cip-project.org/mt/73158052/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cUEe80wP20tYCwldNsqo--
