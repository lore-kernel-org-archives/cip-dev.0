Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61411C6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 13:38:57 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.106])
 by mx.groups.io with SMTP id smtpd.web10.12287.1678973932817068567
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Mar 2023 06:38:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=nZuh2/M2;
 spf=pass (domain: renesas.com, ip: 40.107.114.106, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmnuxDNEGcDExFx3zfoylBbSYXTXX277tUENGwPz3T/gGofi0cTCth4SvgUPKF5qns0Bo9BKsYVQfi+kdRxnPzbLyGgCDK1A9yyfAF9oGMcuFqSQNT4UdCtYH8lE9Cc3uFs0fKLHkMfpPku4Ejkn3iEuf92W+iXmzwWF9aGoC8nUnVyBMaY3f6g/nl0UNJuHKn9ej9jhYhHww6vzHeBrGvclZkGzWEfo1kDqgMXCom6iIoWQJuixUcWxdj+GZ60DSAhJP3FQN0+wjpoJmj5vsXi1PaBIQ7aRBXi0r3pqL+SRwnS7iwuw6N/9uk/SK8DojCPWvtnrOI3Cmy88/M3Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVHKKhLeqi9ZuyFyRfoa46Cx3+CCa/e4835CagvH4Ng=;
 b=Em/ZabkF7lmelRZny9s8nfAhCKQcP08ujSBwp9Yeo1S14tjwQtMJI9kT2yhmnkeM5dxd9IfKkyi7Ho/ucO7MRayECoBhJdDeplC1t8Qfd7JGDYObLs6SDowAiCWNVrKPOXlmKqXoSxToD0FP5XtfIqshXNpQtynocFdDoMLNwaDybhYamno2M8oKJHIeHAGxJImnZcJ/i8rNL5tuDhQKqeC2q0UpRwagVOUJLbBwOBJi6cqgRq63IdIMDuQ9OIGZ0zAECx9/cQCUlVg4GPS9ASuR3XnodfzR3/GIaT0zRY4vtsP2en7lwl0xxeDSkQjMKdKcV57fj1q1VstEh4aFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVHKKhLeqi9ZuyFyRfoa46Cx3+CCa/e4835CagvH4Ng=;
 b=nZuh2/M2e66v3JkR9XbAZdSnkJHQ8rMcFh149tC1ibNjeHTBUyaZ4UqyBE2J5OJ3x2Hc2bHsrjrgTDSKY2zMPSn55T4an1lz9VwkteJOeCsIvgUZvg+3WXu0b/g9wxZ3MyJ9ANePDp7L6UP9/9L8GU9JqI4XZKTw9eBMQfSd7zk=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OSRPR01MB11522.jpnprd01.prod.outlook.com (2603:1096:604:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 13:38:48 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6178.030; Thu, 16 Mar 2023
 13:38:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
CC: "stefan.ss.schroeder@siemens.com" <stefan.ss.schroeder@siemens.com>,
	"GeorgeY.Hsiao@moxa.com" <GeorgeY.Hsiao@moxa.com>, Kento Yoshida
	<kento.yoshida.wz@renesas.com>, "Philipp.Ahmann@de.bosch.com"
	<Philipp.Ahmann@de.bosch.com>, "sandeep.shivaraju@toshiba-tsip.com"
	<sandeep.shivaraju@toshiba-tsip.com>
Subject: RE: About CIP Security image generation
Thread-Topic: About CIP Security image generation
Thread-Index: AdlWaUPbaGgryGgHRRCdsfXTRcaqSABotgnw
Date: Thu, 16 Mar 2023 13:38:48 +0000
Message-ID: 
 <TYCPR01MB10588EDBBF653B6739E9E190AB7BC9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB85155EAB6B807A73E6A201A4BFBE9@OSZPR01MB8515.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB85155EAB6B807A73E6A201A4BFBE9@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OSRPR01MB11522:EE_
x-ms-office365-filtering-correlation-id: c4f59fb7-7cb0-46ec-c8c1-08db2623c5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bTygitEKwIsGr6BVJdq9xPvjoWHItpjdB8o25lIIoOUxaF8mMvwkYrnEx1047hTB4iKX2vDt5vSUVXPVe99E9SehA1P4jmEOhRPsFO7F/B2zU870LLuk5WvT1qGiDaqWWvq7zPh/bpOxPV3Xyc4jhQCqe5rGoGrAymGXaLAxj3GarhP2jNUl0dBC/IbYZ+Wi1SiN1gIcUEr1DbMYxoYR4LrhnxjLIDes2VXVYRKz8MUGx2c9K78R4rLmr8TQa1Z3OfueIfqaWyQM8zucROzkFWQ6fIvnexAtatNByPM5lZBEHBy6KdSTyhS75DJ3awJQQm79RTCbPlsMhzOaOJKPjiy7rytt8Wzbhl16pvg9ovDJynHzmZW+0CjSGNqHxZ2RfzSPO7Av72P5hzaWWAken5VGYk4A5XJ/ItmfZpj9PpdCrCb8ZXEZ/Oe7qsTkxGxcI40aawJ9RS91A57lVmp7opVjNOSqu3QLa/Mepe+Yh4mGmoTCF0SN7ZAulyxE5KCqK3NQ4PpLP9GbSSFnwZS0Q/5307ql13JOsnSEdelJbynAlI6451WQ5zlrxvqeqvSPzw5YGLFd2EaecYE4TKOJChIwucM0zJkriaMsjeJh+Zpupac9vVzuZZGpGk1o6S8jkj6ofHBVU6gglX8GSH5fzP+S2CPGxAxqz8uqG9I6ZApZzSV1nv003xg01HQsYVXp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(15650500001)(2906002)(5660300002)(33656002)(66446008)(186003)(478600001)(54906003)(83380400001)(7696005)(71200400001)(26005)(9686003)(6506007)(110136005)(66556008)(4326008)(55016003)(76116006)(66946007)(66476007)(86362001)(52536014)(38070700005)(41300700001)(8936002)(64756008)(8676002)(966005)(316002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YlM0NmZCZ29Od0s0MGxVTXhERVBYTWxMYnFFalFWUmJaQW5Wb3JGWmpx?=
 =?iso-2022-jp?B?cVhiRENGS284S053UjdnT1dhOFpiQ2ZSUHd5U2QycGpnR3V1M2VzQ1Bp?=
 =?iso-2022-jp?B?ejN4OUtocWRRdXd5NGIyRUE4Y0VHVXpkaDZKMkxYbGEvQ2t1WVV3SzhY?=
 =?iso-2022-jp?B?Zm5DRXd0L2xuc2FEVUZ6RzdmSFAzNXR2MTVyOFcvcXpCeG4wRC9VUjQ4?=
 =?iso-2022-jp?B?Z3BrcC80YmpqcEhYa0Q2ZVFpSWlEblRWb01EWGc2SzlGZUpzQk81WDM3?=
 =?iso-2022-jp?B?Sjg4L0p0NG1NQTJCZHkvZ3VKamFVbDZtSnF2dndHTlgyNXFpOERNVFZm?=
 =?iso-2022-jp?B?RzY5OU0wS3JiZnIvZEx1V0duMXN0VnRLeGxnSW5mN0NCc0xDaGZRK0pG?=
 =?iso-2022-jp?B?ZTk0V25idXd5UkNYV2ZVMmxPaCtaQ0tGb0wycHAwS09ja0U5Qnp1ekxC?=
 =?iso-2022-jp?B?OWk0dGFBR1AvbUZpV3dkb0JFS1p3RGV2Y0lzWVU2eVFwaCsyczU1Vms5?=
 =?iso-2022-jp?B?dy83WEhOZmR4Q1JiYUJLZTlMMlFiSmFGWG5QWkpFTjlHczRNaklGR3JJ?=
 =?iso-2022-jp?B?Z1ZKbEFEeGdPeVZyTGJJNjRUbHpxVm1NYit6T05xM0UzcEJ0cExuaXFj?=
 =?iso-2022-jp?B?UVZ3RVdObGZQUzc3NCtzak1aZnpLNlU2VmVRS25QaHJiMmZnZGFTUFVz?=
 =?iso-2022-jp?B?RXNhSHBOMy9wYjBGQWFHMjFNQTBUbWJRVEZmQU9EOE1kUEtMZDFRRENi?=
 =?iso-2022-jp?B?TTJxQjQ3a29aUHlSVDhOaVFESmRiUnkyTFVKVkNLWHh1L1NEcjBFdWVD?=
 =?iso-2022-jp?B?eUhxYXgzTUdXMzZGRjI5c2xaamg4RzhlSERSSmJNKzNrWHhpN1V2cVRN?=
 =?iso-2022-jp?B?WHFQQTdNUExxUzhpUmZZLzlYZ1k1UURMcHVUUnRmMzlJZWl1WGJyYTFy?=
 =?iso-2022-jp?B?ajI3MGRCN3hBOHNEVmIzV1g4a1NXRTZJVzhZRXNnOGVyWm44czhzTkRJ?=
 =?iso-2022-jp?B?bUJyNk1KL3pRZ1cwK1ZzNlYvNjk3UGh0dkpBT3prcWRRQnA3b3I1L1NM?=
 =?iso-2022-jp?B?cXRXM2t3ZnZINXVVdk9CLzUrODdSdUZaR1FnMHlkUk5JOFRmb2N1K2FK?=
 =?iso-2022-jp?B?clVZL05EU01jdFZiZTlIVmdvU3RLOVRqUFVkcFVBNXY5bnZMN0JEYzBD?=
 =?iso-2022-jp?B?cHBBeENrL1dOUmhxS1pIVGloWlV1VGVwQVEwUG1HQzJLUlIwV3k5Vm0v?=
 =?iso-2022-jp?B?NzVjNW91VHZVdHlRMURWaE85OUtvT1p1YjU0MENrcFNxTjhaZi9RM2Va?=
 =?iso-2022-jp?B?ZHZkQS9qY3lMei8yZmdHSmhCUVlNWUFSeG5NTWlZTnhDNGEzZkNxQ1Zm?=
 =?iso-2022-jp?B?SEJ3VzhPSjhXN3gwSDNBdVNSRUtzTy9PVUt6dXI4WVJJZC9FRmRGWkNH?=
 =?iso-2022-jp?B?UFY5VlJySlpDUlovb2ZZY3JKY3cvQ2NMTTFSWkNiWVZjeGdZMnhwQzVo?=
 =?iso-2022-jp?B?ekJqUUJnYlZvSTA0MEFvZzZEL2lVWmhkaFVnU2tjSXBFSFRHa0R2bGFi?=
 =?iso-2022-jp?B?SC9nUFEvcFppcXFNS1NDOFJhakRGc3F1Z2pWdGdwaFl2L3NmenNocFdk?=
 =?iso-2022-jp?B?L1B5NlF3aXJoZ1I3b3VBaFU5RXczV2JDZTNRTExEdDBsN3I1Mmt2a0w2?=
 =?iso-2022-jp?B?WlJINndKZlFFZWNSM1YzUVhwT1djaG96WFF5QW9SUi9uYlNPblN1eVNm?=
 =?iso-2022-jp?B?WjR5S0xyRWJHd05vb3pKNkZSR3FBeG1FWjZmT0lmbEUyRVFlNTRPek1Z?=
 =?iso-2022-jp?B?SjJtL2JkSFE0ZHVZNktaWC9KVjNId2hjT1doQVV6WUV5blRKaVFrbG54?=
 =?iso-2022-jp?B?L3RlY0NWdmRRRG9HYUI4ZXdkSVp4Z0crZ3hsY1Z0R2ZzenBleUE1bHB4?=
 =?iso-2022-jp?B?K2dybTcxVitnRWZvciszWHNkOWVhdHBLNXFEby9NMFc1dlcwRjhhU1pJ?=
 =?iso-2022-jp?B?MHZmK1hwU25pMTVxcjR2ZmNpWGs0WWovQ2kyUnUvaFpPQ3A2Z0t5TmFO?=
 =?iso-2022-jp?B?endnQm1mTW9FMTJOTzRoU0NXNkJZYVRyMFVGcGJIKytaNmFXZlduSG9T?=
 =?iso-2022-jp?B?dE5wUFQxdnRkY1JNR24vVGUvNlVBajdYRmhBTUIrb3kyL2hyb0VlWElR?=
 =?iso-2022-jp?B?bytQR3YyWGFJMXJoTkpyc0tPV0VIWmE2dEs4c3RFYklGa0lFSUlaOVY5?=
 =?iso-2022-jp?B?ckd0aWF1RnEzd3l5QTMrUm5rQ21xQkltNWtvWk5tckMrMDJ4S1I4WVk1?=
 =?iso-2022-jp?B?ZVJ4M2xGeWxUZ0pwaUdqVkdKOWdqVlpiRGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f59fb7-7cb0-46ec-c8c1-08db2623c5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 13:38:48.5324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9Xf4NTcZY1O3g0svhc4Og60qbO1Q+Uemhwt5gaVu02dCSNFjZHp8xH/nNliHoZJp05VKdBjpuJJCfpV85hVj5Hr0WbeHjSWZ7olgQWQs6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11522
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Mar 2023 13:38:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11030

Hello Dinesh,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Dinesh Kumar via lists.cip-project.org
> Sent: 14 March 2023 12:43
>=20
> Hello All,
>=20
>=20
>=20
> We would like to know if anyone has any preference or specific opinions
> about how CIP Security images should be generated from isar-cip-core meta
> data [1].
>=20
> In current configuration, by default no security packages are added for I=
EC-
> 62443 compliance, user needs to explicitly select cip-core-image-security=
 or
> through KAS menu security image option to generate CIP IEC security image=
.
>=20
>=20
>=20
> From IEC-62443 perspective it does not matter how security image is creat=
ed,
> it=1B$B!G=1B(Bs up to CIP members to decide.
>=20
>=20
>=20
> If we want to use current approach then in my understanding we have to
> test two images in future (one default image and another Security image).
>=20
> The options which we have are. (Feel free to add)
>=20
>=20
>=20
> Option-1: Continue to use existing recipes/meta data and generate securit=
y
> image on need basis (Already supported)
>=20
>=20
>=20
>      Pros: 1. Only those users who need security enabled can generate CIP
> security image
>=20
>                2. Default image remains minimal and smaller footprint
>=20
>      Cons: CIP Testing WG needs to separately test each image.

This may not be much of a con in reality. At least not unless we start runn=
ing a lot more tests with these images.

If we have multiple versions of cip-core - which do we use for kernel testi=
ng?

>=20
>=20
>=20
> Option-2: By default include all security packages & security customizati=
ons
> (Currently not supported, needs recipe refactoring)
>=20
>      Cons: 1. Users who don=1B$B!G=1B(Bt need security packages have no c=
hoice to
> exclude security packages
>=20
>                 2. Larger image size

Do we have any figures?

Kind regards, Chris

>=20
>      Pros:  CIP Testing WG can test only one image
>=20
>=20
>=20
> Option-3: Create a small debian package which will include all security
> packages & security customizations (Currently not supported, needs furthe=
r
> investigation etc)
>=20
>     Pros: At run time security packages & customizations can be enabled o=
r
> disabled.
>=20
>     Cons: May need lots of extra effort for development and maintenance
>=20
>=20
>=20
> Any other options???
>=20
>=20
>=20
> Please share your opinion or suggestions which option is preferable by 24=
th
> Mar.
>=20
>=20
>=20
> Note:  1. As CIP Core WG is planning to make release of isar-cip-core met=
a
> data very soon, we need to finalize the approach.
>=20
>              2. In case of no suggestions/inputs, current approach to cre=
ate security
> image will be followed in future and accordingly CIP Core WG would procee=
d
> to make isar-cip-core meta-data releases.
>=20
>=20
>=20
>=20
>=20
> @Chris, if you want to add any other perspective from testing point of vi=
ew,
> please feel free :)
>=20
>=20
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/master
> <https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
a
> b.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-
> %2Ftree%2Fmaster&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C
> a9e5fcf71dea4976398c08db2489bdd3%7C53d82571da1947e49cb4625a166a4a
> 2a%7C0%7C0%7C638143946235804034%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&sdata=3D3IMNg%2BoxT0jqzH%2BbbEXqSdcZ%2BupqCu%
> 2BOpLB6HrS0XD0%3D&reserved=3D0>
>=20
>=20
>=20
> Thanks & Regards,
>=20
> Dinesh Kumar


