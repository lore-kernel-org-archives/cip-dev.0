Return-Path: <SRS0=rvBl=D3=lists.cip-project.org=bounce+64572+5627+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244BC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:34:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E1522244
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PJw8K02D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E1522244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5627+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sEHnYY4521723x06BQZJBSXz; Tue, 20 Oct 2020 14:34:08 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.111])
 by mx.groups.io with SMTP id smtpd.web08.2050.1603229646578217799
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 14:34:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKZaDX9eNNSageRc6cwrZg9Sn32NA9VhDO85GsocG2IGFBBsaZeTsd1F3CgNMCtydm53f7pYtnQwd1T1Wi9ZHiLdWH69tjPACjd/Y7MV+cF3S067DhmhpUBMY08qtryUVAGdlqmCvAM4AzTyj3OxO/nCAHpVn/+sl27yePChpJM6zZWtjGM+gSVXc7U50ZiXc0GlBkYTJjGzt1H311IwintmKIal15u/6EhbYqlOI8fz8XjQ2eNX/7+YjVMBzh9EMoN11zhUoHQ2fHY4TUp3pA3xU4149MgBc+1/2EW1aUmAMybaYRzli5PbPiSG/PEBb3wsYn3Tx74v1y9jnoSW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZQddnjKRHhZ58NUILZbLqgaZ7rpIFKUtML7bGo9K3A=;
 b=ONux2s7fN+xhdiW9der5kV0W3ekSvEBMsmURwqYve+5qHKgpHSKzjII8QWY8JDn2xcrqHlN0YrNxlz+HbIlt+0d9zUnHz7KT6ILA0931gz3jeTNIusub95tNfxpXWoqN0UWa1Yp610BG5yfQBRkas+fJGZbOru12o8lNm0CzPbn4GKRrOV+uP36Tn19/syjn461347oGHdM7xLlkcOID5ugg3SlVH4RNc39/ynKkvqn2oaa4b7Y4V+T+OOZy8DU2B6DostDiZOKUrris0ZpvforSTPWxtHrhcH+yHOPwsDQ0yuX431zv87pBMLNgKW18FVwnJT+3/SpJVke7VSNdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB1702.jpnprd01.prod.outlook.com (2603:1096:603:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 21:34:02 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 21:34:02 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/26] Fixes and extension to PCIe EPF
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 00/26] Fixes and extension to PCIe
 EPF
Thread-Index: AQHWpvFcDIvak06nWkWh7lq3Kts1sKmg9K8AgAAOqnA=
Date: Tue, 20 Oct 2020 21:34:01 +0000
Message-ID: 
 <OSBPR01MB504849F6570ACA155C6B416BAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201020204046.GA29993@duo.ucw.cz>
In-Reply-To: <20201020204046.GA29993@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 855e4c69-257d-4639-0d8b-08d8753fdce1
x-ms-traffictypediagnostic: OSBPR01MB1702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB1702F865034AFB8710F9A78DAA1F0@OSBPR01MB1702.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 K+vF/sZeGg74LMznin1MxR2mHvuLr5REbNB0GJQd2umR9gDoeOcaHuYgBDnvIwGOqJpMxsFt0uySrAZJi5IxxLPTWome96iTmQwHqn8Kf1KtvzjQH/7uNpE2z+30HN7AEaugWkWiEVFDZ6N48JYxIBFsuFfDmpM3XUKTUGcuY1VRkBqQxgbuO6u5TlPq89sCldnJZpURHP+WTcrQKuBN4IU9dW1WfmNIKFejwm9arhYY07XRQ48MqLZ/cDVJW8KhvX///DJNCy2ID9/dlsVmyYi61eZabfXniWGtFlzFY9otERUhAJt8TkZbMuB76wzNmudRCgucvmo50SwwF6l3Ug==
x-ms-exchange-antispam-messagedata: 
 9+brE/y0MqTUC9UmqbIQoZNWaFQatKw1hdb7U9fS+ORsEXl6cvaw+fzcnyuHxvXS1d8+Z8YFLbuEXw3SOBnSeXcjzwgu5ExOnG6optxLjMJeM+JuCFyVngY6OcxjbG+5gezbKdZX9LiRaBQr4JZd8TAxlZSl+LTpQbr00zFGi7wWpA9/Y59nTE/XO8Qp6OiIpkO/NplvOl7TXLpGOS2ky0fHbtjF0cZyUCzBuLJiiRntFWbO8TNv+4Z0Qtcq3bfZpa4swLNaI9n2KgMCmC6Qq3FbD7HVVq7Ett3/IGBhS6LGfkDNJSzgXE+IZkbYFhJjZL3XCFlB7EjDd7I67HwVyOQoxaIifoeSWRhByivqxlmzyF8rAHbUKZrmiMKRPHN/fHnRFIQiHIXJVeD+v62gqQFWJLVAsBqe8W/T4BTgm5KwGPezVRPr/HGgm5nuJKxVh8kZIbIsMZ0mwRXfGJi+N9EZgbXsalPM92SkZ1OJz1/F8FTXEjkj+JVt/Ze3+pLs0tE6Q7Rt0zAd7J9WLEe0M3qs+dYnbtIOJYtcsfL+R1kbyIuy3QEAoST9Gr6fgyoBbCRzh5B4djL0L0FszYXMjJiQM3ot6ycnMy8q1klmJw8zrYtgV+Q034ejYnFEZ5eWB8L7XswE2qHSzIInTfSYkw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e4c69-257d-4639-0d8b-08d8753fdce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 21:34:02.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsJ0z0nHMepg7dX0wRHS0ORTYDRAO5bZwmthTlYBqNZPgqcy++eGgpLcntBVMPWJCn2LQzVt6e5j2EJ3g9R6UsrAaqmRRXxuy9VA9ge2WqSVfZJDm/jyu9LQvSB6ep3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1702
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KwHJfvF2Ium3QgaSVZNnzXIlx4520388AA=
Content-Type: multipart/mixed; boundary="6j7BobEVAzT9qt2WNALs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603229648;
 bh=zQnmOjQhS1a6gbZi2vIuHubt1VdoBzd+OPGfthsgWeA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=PJw8K02D8252Dqsw1fUDYBq1c11WhLEiLCJyYH3cghCPwdRjLw2agTwVvF0+dIu4Tdb
 UjmqijttnE0nITQ7baQUAUN/GF0DgL8lBi2cjGE1pDVyaN4FOK5OtxwAbIj9ZGJ3O0jre
 XZ9gWTMyua2J0lUBXuRyFjrxoZlc5RU7KWE=

--6j7BobEVAzT9qt2WNALs
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 20 October 2020 21:41
> To: cip-dev@lists.cip-project.org
> Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <p=
avel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/26] Fixes and extension to PC=
Ie EPF
>=20
> Hi!
>=20
> > This patch series is part of RFC series [1] ("Add PCIe EP support for
> > Renesas R-Car Gen3 and RZ/G2x"). For making it more cleaner and easier
> > to review series [1] is split up as suggested by Pavel, patches 1-22,
> > 30, 32, 49, 50  are included in this set from [1].
>=20
> Thanks, applied and pushed out.
>=20
Thank you.

Cheers,
Prabhakar

> Our automated testing did not find anything wrong (but I don't think
> that means much).
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6j7BobEVAzT9qt2WNALs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5627): https://lists.cip-project.org/g/cip-dev/message=
/5627
Mute This Topic: https://lists.cip-project.org/mt/77683509/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6j7BobEVAzT9qt2WNALs--
