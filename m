Return-Path: <SRS0=7zTi=AB=lists.cip-project.org=bounce+64572+4806+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FD2C433E1
	for <cip-dev@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1370323BDC
	for <cip-dev@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jYA2beHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1370323BDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4806+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rIFpYY4521723xsGM4dRWka0; Sat, 20 Jun 2020 07:38:04 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.70])
 by mx.groups.io with SMTP id smtpd.web12.11882.1592663883266456321
 for <cip-dev@lists.cip-project.org>;
 Sat, 20 Jun 2020 07:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrsn7J+/izI47fBeUdQxORdae4a6e4ZNUzQtNOXwpkPnzywQqSm6noD0pdBkHiViAP37u+WHkvft0EvkhXkoAo/d+mudPfdmRWG9yKc5Xt0O9b6GqsW3xqY5suYMTjAhHVeVZGLraDap0NPc4I0UTkHhI6I1KLio1rx71Tj3htk1V3OGf18f/MkU8MluxD2E95FYDRoA/5W+8lFNfnsaxGEVhDLfDAegFxeglmXTRn9KmoKpawQLGiTI4lkFA6ng0oWvL7FYs9DRk7sfVXzec78SChZ/Ix8w22ahY7wH3x8IHkeZ5gB1aT1Hg8cQl/VP9FYfY6ARibKoYn0zcR/AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+fPJPzdjEi/JFOR/hFVVO8Fe72nx0xbEF7/y6rnlJk=;
 b=J2SNE19228Aq8rpHfuYfoDUBMAwsaN7zRO5eexJrqfj+tWOK3GJXLiUAOSt/kwNpfMfxwSDy9dOLp+HptCp8c8AR7ulX9jFvQdR1O3tMDxsDpHwrvnax3+OrLT6M+mi79GIxZfo/V17vSl1F61ZnFovyaSDQ/wu37jh2RjwLt9O40a6/GHihk+uUS+sv8JfUbv/jFWC7fpJMgf8Ui0oD1RX3oSrJfNioWuYAL6m8gO3hSIiifD1nanyWDOqHiRiZXm/N6pSHXiwhC8PJQUMOa1hKPQnTgFv409a3mfMnUNnaWeAJJ/EY/OwgM5riCiCXumfi8EofDkACNNwgW/ImFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK0PR01MB2738.apcprd01.prod.exchangelabs.com
 (2603:1096:203:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 14:37:59 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::e089:90c2:4697:70ac]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::e089:90c2:4697:70ac%2]) with mapi id 15.20.3109.025; Sat, 20 Jun 2020
 14:37:59 +0000
From: "SZ Lin" <sz.lin@moxa.com>
To: Pavel Machek <pavel@ucw.cz>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] staging drivers in use by defconfigs (moxa_eds and others)
Thread-Topic: [cip-dev] staging drivers in use by defconfigs (moxa_eds and
 others)
Thread-Index: AQHWRwRFP0tJHiH0nk6iyYZJ+Dwea6jhkagw
Date: Sat, 20 Jun 2020 14:37:59 +0000
Message-ID: 
 <HK0PR01MB2450B3BB2977F483FB1B9EA9E2990@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: <20200620131057.GA31680@duo.ucw.cz>
In-Reply-To: <20200620131057.GA31680@duo.ucw.cz>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [220.141.69.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5b70bd1-8f4a-49e0-dac6-08d8152787a9
x-ms-traffictypediagnostic: HK0PR01MB2738:
x-microsoft-antispam-prvs: 
 <HK0PR01MB2738FC32B4EBF887AFB1DD0DE2990@HK0PR01MB2738.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 UdNhIugS1ouvTDzUAcJDXCZ/PN9sy1j173+Mi2jANEih/XWxDUwO3lUwQee0M/AS0f3yhbxc8Q1eMrwu5hhiO/WoOaCLPlLgbBD83bP36eaSEr1wCbsHV47MIHwhF6Ny8aAIL2fxDwhxkm7vmNJEs6xJUJG1xbIREnl6pHmMafmeIYyKdd8XK5M39xniBcfPit/J8UoqzQVkYpahh+uqytDyev9WrzAhzLOmewaKWyib73IyauDYn92DWPMuMuGFh9LtjtD11gMrJugPlpiDaVghjshMADoJpqIIsz5v45mV1FpBsC5nttx/9/Kr60WZNDhRQCDvWPMsVncE3bCWLO9wGn9ySyFZPOA27HkSr7YI19kaGTdABxOPsLKGwuY5KE+ZKPXGAA6aD94uExCd/A==
x-ms-exchange-antispam-messagedata: 
 s4BcfiXWS/jGFax+mCmZU1d7Aph5LAfg7XbRFW1n29zsEK4yhSLde+DPSbzonfqBlixQ5yiVTCSDzPGI7vsFZLwtduI28o8+aOB60/xKtb2CRA7al6U90YpGw/FLTz4SWxvQrlxfgHUL1SUpOeTglLPwf3m7KcA3eC4Xj85yzhR8wt2XkmMS00ol/wXY5akEJQ0AT/jpSunfd2P8jIiCNzpauFSGJKKSh/5PyFvBgXJGBfFxlSGvXrLxmXNhx0z7FVOo6dgmSKdn8aX/esBqpm53UhC6ZahWw9CPhsxfBadgiGDrLB36if34do5v51gY4uECh29vsEXAGCiGHOquOWwtzl+zGFbgSIuS/aad1FzXxhxrmfKDWo5wf+tUo9Dg41RqQmp6pAZ/4S5Ev2J+uYXHYXPKN/P+BTKIzyO8fP/xfuEDiabX6C2r0ug2kigmsyhOGlokuXvyhFpwV+6JsUC5gwXtjSkvWaMHtkCGKvP1dzBeb+2j5KWN7lFtcLdj
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b70bd1-8f4a-49e0-dac6-08d8152787a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2020 14:37:59.5479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmtnE13f1P/dsJiuNeKHjLfXO3SIjgcoc12gy+9TmFQuuPtrOwZC8YXQEYqxJ1Ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2738
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rvP9QvNHrEcci1e4qDAKdPirx4520388AA=
Content-Type: multipart/mixed; boundary="DbKjcsJ3NAZxvsvyxjNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592663884;
 bh=YIf8kSaigIa0Wz7i+hUrqBNPTHrZVI2ybZR+4RFjtsU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jYA2beHCADHjNgrSsz/taWY4AA+JYyCB7qqU6fKbkpIHjLAZGM5n7/0pu46TEZy9FJV
 VMWq2h9W2r9rcAOzZF0JJy2cJuIR4lBc12BnQnhwnw86bKUM3jR6QDjsMB4zcdVURj+Wg
 c6A/IcCQOoXsYM8SDKJ2mbYpGwO4V43/Py8=

--DbKjcsJ3NAZxvsvyxjNh
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
>=20
> Hi!
>=20
> I noticed that android drivers in staging are enabled by moxa_eds:
>=20
> CONFIG_ION=3Dy
> CONFIG_ION_SYSTEM_HEAP=3Dy
> CONFIG_ION_CARVEOUT_HEAP=3Dy
> CONFIG_ION_CHUNK_HEAP=3Dy
> CONFIG_ION_CMA_HEAP=3Dy
>=20
> I normally don't review staging changes, and they are deemed by community
> not to be ready for serious usage.
>=20
> Is someone using them in production? If not, could we disable them in
> defconfigs?

Thanks for the heads up, I will confirm this issue internally and keep you =
posted.

SZ

>=20
> ./4.4.y-cip/arm/toshiba_tegra_defconfig:CONFIG_STAGING=3Dy
> ./4.4.y-cip/arm/siemens_imx6_defconfig:CONFIG_STAGING=3Dy
> ./4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_STAGING=3Dy
> ./4.4.y-cip/x86/siemens_iot2000.config:CONFIG_STAGING=3Dy
> ./4.19.y-cip/arm/renesas_shmobile_defconfig:CONFIG_STAGING=3Dy
> ./4.19.y-cip/arm/siemens_imx6.config:CONFIG_STAGING=3Dy
> ./4.19.y-cip/arm64/moxa_eds_defconfig:CONFIG_STAGING=3Dy
> ./4.19.y-cip/x86/siemens_ipc227e_defconfig:CONFIG_STAGING=3Dy
> ./4.19.y-cip/x86/plathome_obsvx2.config:CONFIG_STAGING=3Dy
> ./4.19.y-cip-rt/arm/renesas_shmobile-rt_defconfig:CONFIG_STAGING=3Dy
> ./4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_STAGING=3Dy
>=20
> Best regards,
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--DbKjcsJ3NAZxvsvyxjNh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4806): https://lists.cip-project.org/g/cip-dev/message=
/4806
Mute This Topic: https://lists.cip-project.org/mt/75001103/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DbKjcsJ3NAZxvsvyxjNh--
