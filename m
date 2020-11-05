Return-Path: <SRS0=R/tW=EL=lists.cip-project.org=bounce+64572+5740+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40727C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 08:01:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE9E206B7
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sMlvsrrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE9E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5740+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8C5IYY4521723xtuSNvTHrRK; Thu, 05 Nov 2020 00:01:21 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.92])
 by mx.groups.io with SMTP id smtpd.web10.4518.1604563279217041864
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 00:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfy3kdrCP3GpzlrBWxqesTaImeFBEmWENeMXAW37o2vD83s1YOufYgzcT6gxKXLYzv8zu1D/cypLCy8fhIKPFhadzh2h8htRJzNTiLJKqYnIR9Rg0Tus0xfEFdBq0i6ls7p2lcFXZc6b2f4XApsuwP4q8048rmt+Dl2Mx06G+mSnHse59jSL3SlUFretheLrQmW9mwzQ3koZrRsAV/TAVZtKHPIJHKJDlHm97ulTmF0/F4RTQxj2eLl7ItHYE8esVCwD5fvTc/PGU0FG3GoA8pHnCOOh1VfRGV2we+NTpXzNPZn2/LJa3dMh0mW9f737fbM8lkx77vsp2Z9MaJuwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLqFDI7pitjrx+OKgsgdDQ3TWnF/6gp5NmPy2GiGoYU=;
 b=WtgqkK/ODLmXTYGIoMZRQmqxhXQvkrXtJqtNOKyA4iNql2Z9UWZgx2+5xZgWagow0sh0Pb8E30/veezdEnM13Feo/eBlcKtckesxNmZ2mXsneK4DR70ItKsrL5Rec+jomBAyi/sS8ka0VhQBdjpbmOXgn3cggFBXdguxmZeBSvhHLh2h84zJsZEwExS/FkRVZCZ40iKvJDOreUx18naZhADEpL5q90aiKCw1W9IiwHMgZUAvUuYvflInTrJKHnSrT2Ny3pqtWVoWeC8vTDCtmvNwKLzyxhN6VpTzU0zQ9VeNCV3GyhEof7Q4QgaRMbod0RqkDgCYO9/FO5gg9SNn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB1933.jpnprd01.prod.outlook.com (2603:1096:404:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 08:01:00 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 08:00:59 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdazAPaeIGqRDfO9Q9e6Vg/ZlNyhVQASA7cAAAASWSA=
Date: Thu, 5 Nov 2020 08:00:59 +0000
Message-ID: 
 <TY2PR01MB4972E2A0C1A4EDCB99423C57A0EE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20201105075526.GA1658@amd>
In-Reply-To: <20201105075526.GA1658@amd>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a6dd7a0-73cf-43e5-5999-08d88160ef02
x-ms-traffictypediagnostic: TYAPR01MB1933:
x-microsoft-antispam-prvs: 
 <TYAPR01MB1933E106D6FDA5C84173CA0BA0EE0@TYAPR01MB1933.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 SZnEUrs2LLrhhz5gXHp+BsLZMEus7YrSMD+OI5fWKk3o/DcY0V0EjWFrCZP+t8J277NqxnI2glRGNxRciC4ig8O3nQmMoIdLTONdgXUG11cTNDtw4YpMRv3eMRms3u1SKG4wL95yrsU9CfJ26uifqWoZ3QvMbrCy7tSisqgi59pOpgHPDLZgGOXSN7axAybSIPq5IvXiifgB9w4BDmwVv1VPz5xYY90gnJO+xnBT8DnpgujzsKCek6ILPHWYgwJDRr6saaHFVA6ctikFee8weoMv2lz3k2utGCc1a7invT0t6S0nh3GLDQeNGTAOVMZBau6hSw7jD8/SZaze5tg09yQ8ZQWtTnqvX/C7OhnwxG0sXLoBTEHb8r7+G9DXRV9dWyKpO0H6iSjzGa5qElZomw==
x-ms-exchange-antispam-messagedata: 
 5ZtgWCNHBQqKn0tVpICzCSVenq7VvULnNgA3DxsA5G8cGR9iDaC+ShcOJl8uOPKB4fiTFcZxEBQN8n6tb3Es6mh0WZ8Lm1T3Zm+hVdEUfGoxLc14fHIjaYp02ZztBEsDno5rs4Aq8PzVXRcyGXdkjEY7oROQQ9l3mqZN0EWf2PSrHqAMpVS8vn0+PjqQK1cmJPgCqs+F2o/p4tShaPkIu/787jkPTKr+9lU20Fuic2ewBmqrhH61MY+gdynan5XAzxQUxdVJSSgNup4ICagoS4ifpMCjTvOs/2y2ERA3xak23C4G4NJEP+gOObPWm20J8Z6B7/5yt3xXgmkrnPtRiV1ilWo32K48pqlZAkYBKCdyzwxUO1XSGZQjUHg0Fl4tue+B4oSi76xSewuMaSuyflfaTbCrm/MF/vDHzszPVJRuXViick0mkGgPCtfK9GwJuvJ0SaCb9LoboJAxBSQIydQ7SQGBrCLcdsHR8yeaiIaYRdUEpIqj/VgzQOtcZGEfIZ/qtfmqK5WjVZH/cAgStZYIXOSwWexxY3Tp68W7Zhix1r5Jy4xGbeXDtFqfglov49Opc64pBQp9pBhc49yI8EAUzIl5GaFWqC4ums15HLOS3fouUIXD3RTww9T92aXe2kENPzhwfs0NyaM1BaYKvQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6dd7a0-73cf-43e5-5999-08d88160ef02
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 08:00:59.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42qkMv/7Om4g2qi69M+E8TX9rBfTeboNL3LrfNtF6uhcAEacl5KEVb+JFqXRdO8SnkasmpX8pF/jCqPoU0vOUcE7V2p5BZjMLNiX2nnaDZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1933
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UfbUZe7NCIo4eJGlpmeFbv9ux4520388AA=
Content-Type: multipart/mixed; boundary="t9XjuyKqigmaVuWyMAUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604563281;
 bh=Uvl0BwPIMff6MNbIebGXAo7v5vcWQEKQ5dipZWPKBVY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sMlvsrrZKmTNtGZ60WJqv2jcBv8in3djf1EbXRWTi8eokQO/Qxzpdx3al/3K8Td52W+
 ERe4jNyrotU/gU0/UdvbtRSgjCMRsEZPjTgUz7ZEJapklzKGBQzH3Zvo4jxKr0MfKOE6j
 Zv4j49s2KAJcIPvniiF2q34Leq3KQWDRQ6U=

--t9XjuyKqigmaVuWyMAUj
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

Thanks! The correct starting time is the following.

USWest		USEast	UK	DE	TW	JP
01:00		04:00	9:00	10:00	17:00	18:00

Best regards,
--
M. Kudo

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of
> Pavel Machek
> Sent: Thursday, November 5, 2020 4:55 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
>=20
> Hi!
>=20
> > Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
> >
> > *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> > starting from the first week of Apr. according to TSC meeting*
> > https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&=
m
> >
> onth=3D11&day=3D05&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&
> p5=3D241&p6
> > =3D248
> >
> > USWest	USEast	UK	DE	TW	JP
> > 02:00		05:00	10:00	11:00	17:00	18:00
>=20
> Daylight saving time kicked in, and 9 UTC is now 10 CET. Similarily, othe=
r times
> are shifted for UK, USWest & USEast.
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t9XjuyKqigmaVuWyMAUj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5740): https://lists.cip-project.org/g/cip-dev/message=
/5740
Mute This Topic: https://lists.cip-project.org/mt/78041044/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--t9XjuyKqigmaVuWyMAUj--
