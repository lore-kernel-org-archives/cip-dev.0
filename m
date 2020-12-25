Return-Path: <SRS0=nFPh=F5=lists.cip-project.org=bounce+64572+5977+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D78C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 25 Dec 2020 09:27:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A838A22795
	for <cip-dev@archiver.kernel.org>; Fri, 25 Dec 2020 09:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A838A22795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5977+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OmZrYY4521723xTjinbbFkry; Fri, 25 Dec 2020 01:27:49 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.107])
 by mx.groups.io with SMTP id smtpd.web11.8750.1608888468370714682
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Dec 2020 01:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTqUDcxGBYQg4tdQ9NHXBPup4lB86rlXdTtxY73eWgpRQcykLj1IAb4lfit3XbkGfdqNNKIarEkC/cT70YN+zTWY4ETeLGVJHL2n7IrnbsRBkiY8evkKpLDv3hsRa3aZCtGlc5pRFoQrxnJsEEK4/P9ClGQmsbAvE7E28ALKT/cpncTc6K5QLAVVvYg2WP/rKWn6RCmukcPuSHQSkn+oapZ3Xs89Rjrl/ZaqV2YiFQUs8rKyaiDm0zwC35JirwyEf6ByxmTApEsAnRC9gBYlzH3eqHc1I4F4fuCgFaz89/DeN5EXG4EU6SSk5a00YtiD5HTSF2ZXyOlrxTtG9hAMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK1u+IZ2VTAhgw9fOtvJZDEVG0KzBKHDkFecEJU8t4Q=;
 b=hJV79G0rcMJusJlA/rywpXHshE15Pvayd7XPcRDWExlGqYGVt1nhJrVbeF6YAleyg5bjIkkPoEHols0AFbvXbLM64VayPqC/PxYoOGmw2cxlengvKN2csobj7mfQ7xTy4ZHxcUzhIBdaGeNyKAcWExiJ+neMRiime3wgvI3pECPQzs5QPZvQ5hblp/EmkSha7dCu7jwP5MXZzDUspX+cuIrX9UABMjEwq81y7i/RqqzMzaWFa16gbw7LPoMh4+UaghILOMYLQACINO3Upo8j57iqu2NQJuENMWXJ4/2F+3Z1QfUvHrrgk6l6NutSAUPPN5QMauQt9yTchxJz0jJMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5421.jpnprd01.prod.outlook.com (2603:1096:404:802e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 09:27:45 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3700.029; Fri, 25 Dec 2020
 09:27:44 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <hidehiro.kawai.ez@hitachi.com>, <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>, <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtgANHIwrAABi+8sA==
Date: Fri, 25 Dec 2020 09:27:44 +0000
Message-ID: 
 <TY2PR01MB497225A38DD561DEFF392ACAA0DC0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <16529B035A24E529.13568@lists.cip-project.org>
 <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 426714ac-28ce-4e7f-7091-08d8a8b75619
x-ms-traffictypediagnostic: TYBPR01MB5421:
x-microsoft-antispam-prvs: 
 <TYBPR01MB54215643E7F4CF44B756BE4CA0DC0@TYBPR01MB5421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 azy26zpJCCwxiXVJkMOolanNSbKrvZzbCg5A1pb7sYklr2J9dSW5eIZP39JPLR6ot20j8kcPxZZUemsgEeLTjxf68J3IyFipTgF+ehdr07fMI3Km/rMtHL79n+Fmvy1lWXv54f7FjlSyh9f7ExZh9Ziz02dnvh3YYJr+Q0ubkdrf3zAqYHcS4VcRRD0EkUn46oTWJyyka9bQTCzOroZHi2C+DfSRUaShk50JYBdM94biekgbDJXzUheZ95rd6dgINlsch1OAoB94BibH4u7nyHbjg+eEKc9rB5kyXaOq3OZm2XAvnf5dUoukT2EeWaHZVwd+hCMsWfv+qSH6g92+yuDAmDfjivvDHfqfWmzM4O0toNudV3b/5AjZRqaOaIe0n8JpaeKirUsyQRVH9MfJtsuLnhJ7/yLzwqgAjM8p/aT9nibHrVv6ohOEeDk7gEH53vZ2mOxcCGepn3diqMJEyb9GLH5LOblVGeGiyPgVkzrTf5Eb2pD1eqMCLHak3eu3
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?ck9WRjJxbEJHTGFNYlJtbi9CNHhkVklOdXFFVjd0TWhKQ0hHTEltNTZK?=
 =?iso-2022-jp?B?a2h1aHpyaFA4TnZpSUdBa3RSWnM4azZ5UG9uV3FPbnlyUGduWWpES1hV?=
 =?iso-2022-jp?B?Y0xRREFrQ0xrNGtWNzlRU20yb1VCVjdxQkJhL1FrWS81bXNGZzJwMWNj?=
 =?iso-2022-jp?B?TkgzNmQ5QnJ5QWZ5eTlxZm12ZWJZUnkxWmI4elBhWDEydWRTS1dQbllt?=
 =?iso-2022-jp?B?eE1sWVFabmVVdkFiSmpNeXdXL3krZWd5b0hWQ1NEaThXQlVNaDZ2bU1X?=
 =?iso-2022-jp?B?aFNwUTk2WC9MV3NhWnV5VVB2RTdjcnpEMXZYNHg0UFA0SHAyVFpkYjBM?=
 =?iso-2022-jp?B?VjZUT0dEOGJKaXAxYWE5emQrck9uWVhidk5abzk3UTZoRUNocXUwUDY0?=
 =?iso-2022-jp?B?dnNzUEErNnpkRkIrSG5OY21jQUlRYUdHa0s4NXpkVWh0WnhnNFYzdTlM?=
 =?iso-2022-jp?B?ek1vaGtoZlhQSzVsdEgxdE05a3ZaQWdxc2RNZXBZOHpTWTk4bUlsRi9x?=
 =?iso-2022-jp?B?Zlp1Z1hUUVdjcU1kZ21ZUnlFKzF6OFY2aXByMWJNTVpIWUU1cE9oOHVq?=
 =?iso-2022-jp?B?TlpFb3hFaDUrM3o2cU00dmE1Y3RzSVh0RFJlNEwwSjNrQXZ5Q0FldGht?=
 =?iso-2022-jp?B?V0R2b2I1QWViMnc5Z0doV1ZwM3NEVng0a3Q2dTJtejA5cjhqYjBHdHRR?=
 =?iso-2022-jp?B?Qlo4SDFMMnNGZjl3clo1ZWZZM09ldTM0elJZL0dJTUNxeGs2TFdrZG5u?=
 =?iso-2022-jp?B?aGZsbVB0WFB5ZXRycmlxRnoxd1BpTHZFUWdMd2ZRaHNleHp2YjA4RWE1?=
 =?iso-2022-jp?B?ckl5NmpiOERYUVJtb2lUS29OdWZMOXpqOTFBNnp3QnVpV21GTEkrQWVl?=
 =?iso-2022-jp?B?L2F1eUVmdWFkVE5jNE91dm9IQ3RvOU1kaGR2YThGSXczSkt4c2pQSSti?=
 =?iso-2022-jp?B?YzFHNTBlU3ZxOTkrQklvcFF0RW1zRWNBVW9LK3JEWVExOVRuczM1L0VD?=
 =?iso-2022-jp?B?U1Z3ZlkzU0lvR0hWQ3BZQ2srRmxxdENkQzZqS2dHZ3EyMEtTeUpVSW5O?=
 =?iso-2022-jp?B?ZzgzbFBsbDkzcVkvRHV4YVlyWjN3NTJwNW5KaUM3RFoxcUpBQWFOWGtj?=
 =?iso-2022-jp?B?UG05R1loa0VDaDc3bjBwVmZpMDBoT3ZIaHV0TjZTZW1FdXJUV1ZDVXBO?=
 =?iso-2022-jp?B?aU0zK2t5MUJEbWFzUDBWQkpCVURzaG9tUk9ETGp3Nlp0cTl5NHFxTU45?=
 =?iso-2022-jp?B?L0l2T1U1UTlEc0daV2lUcUdBc2lZbnpOS0RGWGRwOWVMRHh3dkxVWFRS?=
 =?iso-2022-jp?B?dGxhRER4bURhck94ZVZPUVJmQzk1Q20yR2EvSFU5ZlZENWlmVFFiRTZV?=
 =?iso-2022-jp?B?YmFsOUtXZVRJa0k0UlJZQ2ZzRWJkWXpaVjVvUGJtWmZINm5tUT0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426714ac-28ce-4e7f-7091-08d8a8b75619
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 09:27:44.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZZJKIeQG7uCjfXLXFrGtaeVOeCFnyXVeW0q+SF+gOFIQ8io0oyjS+EJiq3PyeCMQzQV4Ysmx1ZlRhy8WX9n7S2A58vtPY9SqLJBX4rXXhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5421
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sM6TtDXKuCTVoHRa2zSHxE7vx4520388AA=
Content-Type: multipart/mixed; boundary="mKS7uMfqMpBMsocnPf8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608888469;
 bh=7qGiPhMGSTYVUOIXq9t5fctxtsmz7MY80zqTeuVL0cQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=IA7M16lk5YIJthBw9LBzjb/3WH3DMFdVtR9oVYFl1EBqndEajm9WgRWcCv/Us7GtBQE
 AzI7SeZVSdJJWuJhEWzX3h1slS52bp7i2LIZ1Gj1ef0Ai3NxNF5Ds1RHwEHS46TbEDUP3
 j5Rrc7K0nEiEMi25+ZqzmhNbvE7AM8OluyU=

--mKS7uMfqMpBMsocnPf8E
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Kawai-san,

Thanks very much for letting us know the current status.
We will wait for your response, so I would appreciate it if you can keep u=
s updated.

Best regards,
--
M. Kudo

> -----Original Message-----
> From: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.ez@=
hitachi.com>
> Sent: Friday, December 25, 2020 3:34 PM
> To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masa=
shi.kudo@cybertrust.co.jp>;
> 'wens@csie.org' <wens@csie.org>
> Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> Subject: RE: hitachi_omap defconfigs
>=20
> Kudo-san and ChenYu-san,
>=20
> We are sorry for the inconvenience.  The confirmation will take some tim=
e.
> If you'd like to solve this issue quickly, please disable nouveau driver=
 now.
> After the confirmation, we'll send an updated defconfig.
>=20
> Best regards,
>=20
> Hidehiro Kawai
> Hitachi, Ltd. Research & Development Group
>=20
> > From: cip-members@lists.cip-project.org
> > <cip-members@lists.cip-project.org> On Behalf Of Hidehiro Kawai
> >
> > Hello Kudo-san and ChenYu-san,
> >
> > Thanks for reporting the issue.
> > Including nouveau driver, it seems that our defconfigs have some
> > unneeded drivers.  I'm confirming this with our development team, plea=
se wait
> a moment.
> >
> > Best regards,
> >
> > Hidehiro Kawai
> > Hitachi, Ltd. Research & Development Group
> >
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of masashi.kudo@cybertrust.co.jp Hi, Hitachi-team,
> > >
> > > Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the
> following email.
> > > https://clicktime.symantec.com/3Hrgtrrm6ninbLpVgrZpbS37Vc?u=3Dhttps%=
3A
> > > %2 F%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> > >
> fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2
> F%23
> > > u
> > >
> > > According to the kernel team analysis, it seems that the nouveau
> > > driver is enabled in hitachi_omap defconfigs for both
> > > 4.4 and 4.19.
> > > However, the configs are for OMAP platforms which, according to our
> understanding, don't have PCI for a graphics card.
> > > So we think that the hitachi_omap defconfigs should be corrected to =
disable
> the nouveau driver.
> > >
> > > We could be wrong, so please advise us. Once you confirm it to be co=
rrected,
> we will go ahead to change it.
> > > Best regards,
> > > --
> > > M. Kudo
> >
> >
> >=20


--mKS7uMfqMpBMsocnPf8E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5977): https://lists.cip-project.org/g/cip-dev/message=
/5977
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mKS7uMfqMpBMsocnPf8E--
