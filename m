Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201CFED2C5
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:34:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13919.1773286475943494642
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 20:34:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=LihrDhKY;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773286473;x=1774496073;bh=SQp49YbkoJpCXHtgKVAXi7+YLvuKpN9j1XIdJ
	EvVavk=;b=LihrDhKYe3ouO5U36weoWVE0iKr7mbO+YxGNfjaBn2DeBXzg/kGbANSt6F7AAOsTlY9
	oIKb6wQbRh8Wpf7HpmOoyv5IAJFqzHMtDhUBEzCwgdXII+teQ3hHDEtnBPyOsp1yky5gNCF1oN4pb
	l0UD6KZbAFaIyd6fZTzK3LTLmL0JpUfTc0CqD0hYnArekKGtVJlXmznp3JlTj6judPu2oDjHiDw6r
	iIx2OMXbBc8i+/Ld3LGimOzNU/vDZmeoUzz9F8EVj9hcnOnY+aTHwN9E7lFkOptALrK2zyno8LEf9
	Ri4OxYaXXl+tHHjKcibBV8auSRI8S1FUioJrc8SXYXkw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62C3YXuI1293977; Thu, 12 Mar 2026 12:34:33 +0900
X-Iguazu-Qid: 2yAaii9iV4Wjyj8ODh
X-Iguazu-QSIG: v=2; s=0; t=1773286473; q=2yAaii9iV4Wjyj8ODh; m=s9zapKkApmYHulM+FcBZ6lQRYs5OvVZdapz/Z2LRAgU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWYBw5pRrz1xnZ; Thu, 12 Mar 2026 12:34:32 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUES4l32weaqVqSx78RKgNaYT4RltoPJ3hgSfMdr5H9vvKKOA8fFpKn95p49W8cKdcMT0w/2hv0JQumdfAnwACwAtX2MdvgifB53X4poFoCqXegQdg+Z+U4irRsPJlss9QdmmIeIGDOGevrGKF9H0fuw6LzeELsgwR0ww1Te0fTftEXzRqndeV08yhe0puvwGvAtTEHsHO5WwqtvAwaXLZVG4IhU6fkvsoLpkLrY2u5byn3lZdSw0JrSLxWvvRAeebekh5EmW/KNTUzY7EthH9tkaJcNnhh8JoryGYH+Itwq0sdMmafoJBD6QN4yyjjvFnSTMV6cyRwiMhRG88ULvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCvCs/s9cW6b5/EqGu+ZToJKaKxOUPupgiM4V30ciwE=;
 b=Nm3Rn1G76sI3WuF5scK8HBH5dfPMeT2KZbJgHSX6DYcnakAMvtmkK8LsFr2l5hWEl2xuZGSlxVPz8Gl4u150I7cUmvv1WHcyJQ+AHFoqxMexeh7EoQjEivM1ee0v1vA2JNMAsefvg12SZLBr4C0kBflBnn7gV46G0ytB6SogjnPda+8gNAT/mbyAD4bIyeZLHQ8uetrLEWVrYtqwbhSIx810LrZ+ER9Adna0xT1FqSDN+oGJmIvUShkvK4xZfbTlVqakBEoUuXxEzxpDJ2uuC1TUMHKMV19pmnrvTkfuAwCpptboJuCn/i/uhN5ug1X6/kmCwlWj/4QYX685pdZ92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N Interrupt Controller
 Unit (ICU) support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N Interrupt Controller
 Unit (ICU) support
Thread-Index: AQHcsKcayoHLma0qD0am8ss8OtLayLWpI+4AgAEcoOA=
Date: Thu, 12 Mar 2026 03:34:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481822207B41F66E8543FD22CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
 <abFFLOUfBwQWKZpc@duo.ucw.cz>
In-Reply-To: <abFFLOUfBwQWKZpc@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB13281:EE_
x-ms-office365-filtering-correlation-id: a9802e73-a8db-41a7-725e-08de7fe84362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|7053199007|56012099003|18002099003|14052099004;
x-microsoft-antispam-message-info: 
 7JmkcH5MpVcNHR1hYLyq+F68J90aipaJQcK5pwePfbqBzSWiZipSOKqibZBDFfHIP+Js1St1YxMww1y5Ul96JrfijF5qs8vsKFoCegk32eWrhpB7d5e3D0DwS22MNpJ6CSDRsHRdz9+untnY7Pmu1npBXqAv0Ok+3uQKAY/dGa18WfDlnxcx7hG9hRNC4niDFv9bjMuvTiZFHUDlSWWHElO16dA9WwxuKB1ZATKqAXSG5/mTHK2mgs5eWSNteoswUJ0c6ZI5F2cRccfgW2ZIJnz48ziFmbY1drwfedYzp1Dwacj8ZKVhTekpV/tPzsj4rhmBL2z6d+v4+0FjVOa+2Kux0OO7Ar02ri5mFLSkmBOxyCeQay5ROl81B/1CXJyBTGJt6Ev8M/SdqnWV7dtQrSulSpTJvFJcBTclbB1+JAUnr6xYmh+AzQkC8KoHCvfl8U9znYhCowOQlFCNBWDYpAlqey4uJrqdZQQlazIWtI+Urm4Pc5Xd0Wvc9M7RlhW/DqNmQiptp23tnlCZpa8fOZN7oBZteXCL9KLuBh/Ef0041yGpBTqLEZy9UiMChUBglUOsinbnWpaAGzQKcguUKyvvVK/NDWXcKbbuJ1jgb3LyrKPA9/Oei8g78WNq+4079pVaqTOLeJRp/f6akhjoxVGJTHwikTdlESboca5cO0Q5W7B+Eb5xdpnSP8g1BH4bvguCSA15eM8Pfp/3nx9Oc8/BbZVUT8n+9UeHSuv3dxlfZo+hb8QX8WvjjCjzqKsimCkPsP0YeHSFibVkiExIvZNRcfO9NoxNeT3wtuVCDZk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(7053199007)(56012099003)(18002099003)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Nys1OGd1ZDZtVFB4QkFwQzdUTFEyL2VMbU1rbGNkZldKK3h5eDJhSGNh?=
 =?iso-2022-jp?B?ck1UR2VCMEhGSE9HTDNrYXdzUnlVWkcySlVzRE9oQWEwQXhrUkJWT2gx?=
 =?iso-2022-jp?B?b08vR1lKaWxzZ00xK25LYXN4NjZ1UmdvYmZQQ0QxcC9oVmJITWR3WGZD?=
 =?iso-2022-jp?B?cGR6TnZTL3BreTR4czJTeWpsZzNYdDIwNlVXQUdlSUljNk5TdGxYMHNX?=
 =?iso-2022-jp?B?citmYnRpVVIwSENpeDk2MHMyTEFzYiszMjBoQmRxalpLODFTWWxPaFBk?=
 =?iso-2022-jp?B?dDJKWXMwNkR1THJ6RVZGVEo2TjJCOTZQdnlBa0tYMjRWV3piRHR2ZWhB?=
 =?iso-2022-jp?B?Nkx6VmNqeHlndVdMMXRrRlVJRXRVSTdWUkpuQmpoWHpwSTJaWkxBbk04?=
 =?iso-2022-jp?B?K2tueUc3RWxTaXhyYmlES3U4QVVweks1YnZFUUNGQkFhZVNLTWlod1lx?=
 =?iso-2022-jp?B?ZEpOWUYrQStLeWhYZWNXT21pb0tobDR6cTAzbXNsbFo2dGVBV0J4cEs1?=
 =?iso-2022-jp?B?QkEzUnBmQWw3c2VKb241L0NyZmZRaEVvandlVStFOGM1ekhjUW5MMGZq?=
 =?iso-2022-jp?B?LzNtU3pGQnJ1RXBtNjZxSnBKOTNNakUzVjFLZlFiZkNWMDh0UzZhTHo3?=
 =?iso-2022-jp?B?VVRlR3ZVdU5sdytpODdYOWNDY1FZUEJwdU96WTJQb2g0L2QyRGJncERK?=
 =?iso-2022-jp?B?eTl2ZjM5b3FqL1NQMnlzZW8xSU95MG5WanlISXY4UTF1TGJMMU9Rakt1?=
 =?iso-2022-jp?B?Nnc1ZG1zSW5UVVEzKy9UVnZwTE9JZmFXWUtjOGc5L3NqWE93UkFUWkt3?=
 =?iso-2022-jp?B?TVhkclQ4enFhVFk4MEZiWkVwMXRCTS9MUUc0WnNEakUvRm9tajVPT2VO?=
 =?iso-2022-jp?B?TCtSZHo0RHNKK0Y0cXhTczl0Q05nSnUycmxGRmJLVGpzc2lsWkdidUxx?=
 =?iso-2022-jp?B?VjBYOWt3d2NyL09hTmNqSWtpRlRXWlFLLzhNS2hOdmtyRFJCdHo3T0Iv?=
 =?iso-2022-jp?B?cjRjZ2pWcE85bEdpWEpsSFIzNE1jV3V4U1dPWDFhRFM0dDhZUjJGcm8r?=
 =?iso-2022-jp?B?enRYS2NpNXNsbnY1dDJRbjVvSmJtcEhRRlVibVg3ZUZPVVY2STFqY2ZN?=
 =?iso-2022-jp?B?eVJ1OXIwbDU0UkV6VTFQV2x4MjZVRkpDanJrRlRsb2FrMmtiM3h6TG1T?=
 =?iso-2022-jp?B?M2hJM3dWZFEwUFlBVHFVRVYvL21jSnd5eFJDdWJsd0J1TEhZVENLWnZk?=
 =?iso-2022-jp?B?aysxamNHREk5MmtremdlUWRZQXNwMWtPNFlXalR6czBwcWZ4NFBOdkJt?=
 =?iso-2022-jp?B?ckVIUit4YzU4L29FWFNQeGFodjNwVXJ4cTd5UXh0SE9USG1zY0ZVamlo?=
 =?iso-2022-jp?B?Mkx1clRWVCtrTmNoTUM3WGVPdXE0Z2cvd1c2dmpMUzl3bk5WdkNlQmIz?=
 =?iso-2022-jp?B?aDUxTkRrNFdBczRSc0lPcVR3WGpyek9EUnZUZldTY1JYTWdKd1h3STZz?=
 =?iso-2022-jp?B?M2xDbFdRUTBaUW1wdEtXNFJLY3RCSW1WK0F4dWJvRnhmUDVUMEpvdldt?=
 =?iso-2022-jp?B?Vlh1TW5aYVJ4bC9WckJ2TTZ2M2RqbHlwYUY2VHlhWmprMWtlbDNGbG94?=
 =?iso-2022-jp?B?eGRpMnZGc0ZXS2dyaWtzaUl5R296MzB3dnBGQ2NxaTJwbGZPeURFUkQv?=
 =?iso-2022-jp?B?VVhvZVB1WWk0OG1YV3A0OVdNVmw1TENibGVLR29FWVYxOHZwaWlGRDE5?=
 =?iso-2022-jp?B?eDMvYmhtQ1R3czBrRmQ0OHFyK2RYZ0I0bktNR1ZGNUdZR3I1RVNIdGNr?=
 =?iso-2022-jp?B?TEgvZnNVOVNrZnJjRXhheDljVEVKclZiYytNWVRxdGR3aFAxM2pOR1ZR?=
 =?iso-2022-jp?B?cm9CNlFTT00rTXVNamlGVFVSSGthVjJaRXlBdXFsUWUybHNWa20ram5E?=
 =?iso-2022-jp?B?OUZLMTEyMWNTeXo2eE51dmtFdStGc3BMa3hKeE8wV1FPQ3dvbnd4M2tP?=
 =?iso-2022-jp?B?bi8wcFdOV1VrZHhtOWVqY1lMNlY5enI0Mlk4aXk2eU4wRGc2OFRDRXNR?=
 =?iso-2022-jp?B?Uk1PWnpjOElmYk1IR1BNL3JZWjlUQktnblJzNTdUVVdnZmlDZFlSQkdP?=
 =?iso-2022-jp?B?Zy9ZU2FqaVAzZytKbWhmQUtFanNKZmxYbjlnTmp2eFBoaXZuTkhBRlU2?=
 =?iso-2022-jp?B?K01wQ01LRlNEcUNOQkNvSGJUUEJaSzJUVm10WDN5VGhHODBZSWJiYity?=
 =?iso-2022-jp?B?NlR3eVVtMHdSY2VsL2NXMmpJUGVSdVZQQlR0TzBJZlN1N3c2NG5tdGRx?=
 =?iso-2022-jp?B?bWVLWHBYbzhBazlxSVVJZCthbGVyR0djNVVqNVgxdk5meTNaUUlUdUgr?=
 =?iso-2022-jp?B?KytOWWhkaHY3TW9YaWUrNXZJcEh5NEZQY3dLa3F3QWpGZzcyTzdrV0Ji?=
 =?iso-2022-jp?B?czVDYTE5dkh1eFFLTENISCtWNFNYa0NqcUhFeUhlVEp2dEFySDdSZFAv?=
 =?iso-2022-jp?B?ME5reEZJNDNUdEtrNkVhZndNaTd2VzdzcFcxcDRTTk5VYUlsbnd6QS9H?=
 =?iso-2022-jp?B?c3MvN1VmOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	YKMmHRtti/vF78mPUqyyHnrXvj94ALGj2vvtlMUtABoPw0+5zBZRnqJIFTpYBWlNRWmZSLLSM3L47zkwjNgimHasFe7taWWEE35NyCHO3LnsX5nshn7FxSoJXn0ehpYcgDXe8GqsHMGh1tgFDL3pE/tcq0PYiCYldE7+W6ilVpVElFvO54AY61sAl7RWjGsluNwQ0aOrTiB+q4jEp/X38NSHDPlBKSdeKz91r6pO8bi2deim0HVBNNGkaVvM8plp0ct7fs85H93kYuYGTKAj7L/JW5BiwtKXwu3mlh49lRdRNyQlk32C8/6i2aHHQGoeb//JtzRT9FqYjK4b6IU2FA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9802e73-a8db-41a7-725e-08de7fe84362
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 03:34:27.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lso+iVt0m5aL6GW+vwv2ho4WNjUianAWkH02fIHiOUvW2l1iZYLPERCDy8jP7TYI+/BARGA0ScEgm3hydDqDQh+1GGuET/6AXXg9FMgy6Qa5D8tsLNXudRFJVg0U6Xw8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13281
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 03:34:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22351

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, March 11, 2026 7:34 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N Interrupt Contro=
ller Unit (ICU) support
>=20
> Hi!
>=20
> > This series adds Interrupt Controller Unit (ICU) support for the
> > Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
> >
> > Note: This series depends on:
> > https://lore.kernel.org/cip-dev/20260305153725.19821-1-ovidiu.panait.r
> > b@renesas.com/
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I will apply with Pavel's Reviewed-by tag, and push.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


