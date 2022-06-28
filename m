Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A9C43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 10:56:14 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.121])
 by mx.groups.io with SMTP id smtpd.web08.54443.1656413771719414562
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jun 2022 03:56:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=my8Duv59;
 spf=pass (domain: renesas.com, ip: 40.107.114.121,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbOf/8V0hkHRPIG6jDNkhY/wiiLgaHiAE+yDxmnoRbujmjtLXgqHpN6JKYJQywZSIs953Gr4Pr33MwPOlciTSAWTyoWabHIKPeM5pNtT9SxbHSFnKhle6fKS/BkRncPGujcAnI70H3Viix1m9Cmk3c0Vkfak7yvoF2HCrugsCs7SJSlE4KsjTmPceTjVcjDVnbp5ctJWF/YvqnwVDjRoLG1cfRxd4h3ODDs4hpjRX+k+yXCoIhhAfsfTkbr+6uKN+IYP94OyzNmsRUV8V1SJUPd55P+Fg6j22P01jojo+Qs77NrztcR2yrKsnjDDHbYSj4DM6ugM3JNcw/9vKP++Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnCS7kFwPN7CWe+iMn/NAw7Ot6ePR8cyWQHvTApelrY=;
 b=ElS63Xyyoas2yUUPgFmZISsE0V0vbLxfVc7wP8h2yM8njoY82cdSHFowISWSXPZzR5U//MNV7c012agA9PNAaIsIAf4j8jWAh/I3kfzkmODkOmPdceXUH/9ciT2hP3J3laaL+ZtNwqmOYcS8hDNmYC2E5dwLLEy3wq3LzwcJ1uNG8UDtkwEkY7DQOx77iZkOHCIfQzOW6lEX/4pH/dpNqGdEogtuWVmT6c4LevKZalfyz2QzpJj5veTconP1znjZfal9DzFq5dh6ncvNwSr0BjXdGmhDCQWKOgr1T2nijSSy4dQ4+aMEDZjpwif7Gu5TcjYhNP5Mzmjrf9Fd8t+3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnCS7kFwPN7CWe+iMn/NAw7Ot6ePR8cyWQHvTApelrY=;
 b=my8Duv59Dy9bTO0YI/gTkoP8lZ9lQVNlEHjrzLs8Vnh9quTGZCRwKMYlCcg2dpxavUXI27odekOlB9Tsw4FlOzmnBY1x7kLRvntQXh4ZIT98B7J8BTr2KcUkDHEiQ0gPoQulo54vUXMldVBnCXI1tSwHsQB7X2LTZI3MB5Buehc=
Received: from OS3PR01MB8129.jpnprd01.prod.outlook.com (2603:1096:604:170::6)
 by TYAPR01MB2816.jpnprd01.prod.outlook.com (2603:1096:404:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 10:56:07 +0000
Received: from OS3PR01MB8129.jpnprd01.prod.outlook.com
 ([fe80::6cd3:f038:4e84:21bf]) by OS3PR01MB8129.jpnprd01.prod.outlook.com
 ([fe80::6cd3:f038:4e84:21bf%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 10:56:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
Subject: RE: [cip-dev] gitlab testing down?
Thread-Topic: [cip-dev] gitlab testing down?
Thread-Index: AQHYiiUlLtqzvD52QEGg7MphkB9G0q1jijYwgAEcX+A=
Date: Tue, 28 Jun 2022 10:56:07 +0000
Message-ID: 
 <OS3PR01MB81292E53BAAE8B44CBB27ED7B7B89@OS3PR01MB8129.jpnprd01.prod.outlook.com>
References: <20220627125510.GA13594@duo.ucw.cz>
 <16FC8C06F16261DD.466@lists.cip-project.org>
In-Reply-To: <16FC8C06F16261DD.466@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588716be-e1f0-44d6-776e-08da58f4ce0a
x-ms-traffictypediagnostic: TYAPR01MB2816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pdmDrQfqW05OAPEGHaQYC/0tXxsFS0NnbXSCAQSwLBgx736z3R9Hz1pYXYl0V6LwGWvL8hgCEr/K6zkn0nvPg8fLtg6t0Oh5UsBCmZ5Uawv4CCouXZq3QJf5VQUKstkibeS0f7mfyYjPFUvXl63Z3qSugOHdJLEjFaDS4TXBvWkQCyIO5HYBaen7S2uAlVa2SoRrZkEi8iFGcS2q8DnG4qMEql0BQOmbVa21bavyNYI1MxYRvcf3xETFYLrVXt2QUN6JpnZmyTQDHFXTmdY8nCfIE5BgOefe8lGv66pybFoLI4LrW64CLUXWLGGXUzPuqGX9oYj3ZfCO+7aqLkF36VOo198lOfLXnv0/46zAREfqD8rtcRkQxEa0lhNvgshizcYlPYXKB/8bql255sNH1AuSQ+SM3YEy4Uhl0C7tJD2jbmZwr2TFxXZJH/KJLTInmjPkygN/uXTWtMz7O6VrogvYK15VMmXiKLlBF7CLcbzBsaIXR8SjLkgQ1zBtx/6aFGe+Z4gxMC+Bw3skHZRmKHhun54VWIAqPKh/rLBYdIDUM4uQg+ur4of14Drz/pHkl4UihbxczBqadbI7SMnVe2GwK7MLyOi89rx8s2RlOlha5Z3b6KQu0bh0yS/klvEL5CNkhEqt3YiZPOFW1EHoF4q1YeOGzY22BUAdubJahLP7KUCZfke8TWbWpoOYh3cUnUcQd5hmwSVWcQmlggPvEw4Etl3gs5OClG7WpHRURcwHz/ijS5FCUmfek7yv9W+gTn0LbOQ652JnFa8NO06C8kjNxL1dtPwVI92rqx21lc51zEFIi2opKiXV/emh5De8cXFoNZGMYQ6N7bMGJ/TYwA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8129.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(76116006)(33656002)(66556008)(71200400001)(86362001)(66446008)(122000001)(110136005)(966005)(6506007)(8936002)(38100700002)(83380400001)(55016003)(2906002)(52536014)(7696005)(45080400002)(64756008)(9686003)(478600001)(5660300002)(8676002)(41300700001)(316002)(186003)(66476007)(38070700005)(26005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?2knppSa7BRazZBi+lLaXIvwe9WCzwg5CFzrgCSmyCwtiXsTWFrV46cD2?=
 =?Windows-1252?Q?lp1DCZeaKe4P1WrU48p7QPfIOIvC1rrB6hSg2LnPFPrFWqTmJq0lOD8Q?=
 =?Windows-1252?Q?CEtpdLhaeIAtn97YaUziHhtlZ4vDH6wVOeA3Sb3P6KnxL18lqra+Il+D?=
 =?Windows-1252?Q?Iz0ZBhSEt/v33ScSNBW17eXn5KCVRinpzzaTujPFM++wuMrr//dxj97G?=
 =?Windows-1252?Q?9g/rjcfxAF8j8Y8OMsL6WLrOSz4sZM5nAUwydk8EUF6zebBEX3PLcRHY?=
 =?Windows-1252?Q?Li6+0BRVyOfIJl/K8u7hZgCXMH6sRKi8v1wjYt0rabGlEjgGlEt3g62/?=
 =?Windows-1252?Q?RdOuQeAu983N4PZmDDs5TxtCWr9NFKWNvwRRD2haKGq2C0vkm+WMbmsM?=
 =?Windows-1252?Q?US4FV457bHEQNSRy7ULrLdmrWkNM6uFrFwoDNQkLM5+VyUnDkD12pq/v?=
 =?Windows-1252?Q?wcv+md2iomOg3yYs7a99xLsrb32/GvGbw9qNXT0MF7c6NsQEkwkH0PO1?=
 =?Windows-1252?Q?afe25HxKexitOiY7XxOAMpuZDt8kMd/1lo2a+k9DTR13mBZJlK2no2Zs?=
 =?Windows-1252?Q?JRmW4BLhGpDQ+UBgEU9Clqo9l8LCYkJPI1w5o6NfjiJgmLW0ymoMZYQg?=
 =?Windows-1252?Q?SjPSEbobczopGve5yIk3C62Qe6umI6Q6r/fpKOvEsbeeB02ajMOyGrxZ?=
 =?Windows-1252?Q?w6GwSYopZ9HL77DmcZT7pw23XvFdSM1mhu1qnK0e1AvbcrqN8JKYxMMc?=
 =?Windows-1252?Q?OawpLjkNsZh1AaYnKdPAbzGaZoXbsNjv9QGIICgjU0NdNRD1u0oKnTXH?=
 =?Windows-1252?Q?Nl2EKGo9WR34jNQGCbtfUC8d+Z2MYpHLO/A8nDtHtYZ8+Bv7rUDfXxpY?=
 =?Windows-1252?Q?aQZSpE35kABKqECADUm0ZIsYQRlnkND+tf6orsprVYknchUw3ThaRWoZ?=
 =?Windows-1252?Q?hzS4ukx6NnG4F47j0ve8QnYxhhu6oRdMzuOWRgkmqcc4wnp65opm6qCW?=
 =?Windows-1252?Q?cKoCaYZcqvJDD5odj9JA69iWrkXYkYdCwTeDCMTwDUyx5n5k33EL3S8y?=
 =?Windows-1252?Q?1YdjAw4zG+/q2nYd4yteLB0mpCk3F5cS0BTwZXXSpKlmVHUnZnjLtuiM?=
 =?Windows-1252?Q?Iofxk3d6rMBjkVKTqquuRAUCBTVW1gzY6vfkb2ruUtO9A6gPj+dATc/j?=
 =?Windows-1252?Q?/l3IIIlKqHXAn6n0mM1gO9V5NDfN4SNgPZmommDZ7cKjJkBUfga12x6z?=
 =?Windows-1252?Q?MA7ip2yyEqxl8ql02kk4+8ek6On8Mof2oEkuZmkb2U94VwO/k4g6pOEB?=
 =?Windows-1252?Q?ydMDvYm5xkdge/qTeCbGBo5E+abmhN9lAGkSGfg7xXYUGDqfNE87VaiQ?=
 =?Windows-1252?Q?uuXZc+6Xm0G55vnc8JFpuUppVPJ8RR6/TtTwWnRJi1dS5noXWibGLwZf?=
 =?Windows-1252?Q?OnKLJdxxzwnqKD3G8BqTtknlawxgJQQ681+M451RdA0zObN8OGYcGU4N?=
 =?Windows-1252?Q?j1cDujElMIXcn94lRudQO8xHZvM2pRSaR0pHZCmWD/uhOIcqqfArDV9T?=
 =?Windows-1252?Q?DbF8XyE4fkJpyQa4DkQFG3lwTv02U+DVDfxSPVjkldbW6pXnaIcC+Aik?=
 =?Windows-1252?Q?IGVQDZTWKoKIPOZMp5DSibF+iZ2W3MMeLVUn6IN9D4VkoW9MfpO4PyRW?=
 =?Windows-1252?Q?eHSX1ZhW8DOvJm4N/Yil9cK74KQmPao7UKVLtzWWJoDGYbK8JN+Geg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8129.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 588716be-e1f0-44d6-776e-08da58f4ce0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 10:56:07.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 39ZZCDLUuIzo/nXWQTriIrghv/y6C3dW+O7SfV+PhBp+gJcqfpNWnvNL27YhDPntkpNlp3j+Ai9OvhuxxvJCveuwjRUhQOrJbw69vBNitPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 10:56:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8623

Hello Pavel, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 27 June 2022 18:59
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 27 June 2022 13:55
> >
> > Hi!
> >
> > 5.10.127-rc1 is out, but there's something wrong with the testing.
>=20
> Thank you forgetting in touch.
> Sorry for the delay, I'm on hols today.
>=20
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> &amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C4755b6c368434
> fce3ec308da5866b171%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7
> C637919495336322976%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&amp;sdata=3DhanTxTN2yKMSPf%2BSRqJSTfHihi9REQHeJ7P4lVyKK8Q%3D&
> amp;reserved=3D0
> > /pipelines/573859895
> >
> >
> > 56There are currently 0 "qemu" devices online.
> > 57Refusing to submit test job as there are no suitable devices availabl=
e.
> > 58There are currently 0 "qemu" devices online.
> > 59Refusing to submit test job as there are no suitable devices availabl=
e.
> > 60
> >
> > (and similar for all the targets and other trees).
>=20
> The whole
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2F&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%
> 7C4755b6c368434fce3ec308da5866b171%7C53d82571da1947e49cb4625a166a
> 4a2a%7C0%7C0%7C637919495336322976%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3D8eeIdTU7L7Que7lF8R3A6t535lT%2B7ZFXnIh
> PFU%2B%2FPMA%3D&amp;reserved=3D0 domain is offline at the moment.
> It looks like the EC2 instance rebooted a few hours ago, but there are st=
ill
> some issues.
> LF have said they are looking into it. I'll let you know if they get back=
 with
> more info and/or the server starts working again.

Server is back up and 3/4 labs are back online.
Hopefully the fourth lab will be back up soon.

Kind regards, Chris

>=20
> Kind regards, Chris
>=20
> >
> > Best regards,
> > 								Pavel
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

