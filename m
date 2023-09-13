Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DA4EE57DF
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 02:26:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.3105.1694571950286170319
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 19:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 38D2PdWm073478; Wed, 13 Sep 2023 11:25:39 +0900
X-Iguazu-Qid: 2yAaEO0URfhB0emIZF
X-Iguazu-QSIG: v=2; s=0; t=1694571938; q=2yAaEO0URfhB0emIZF; m=3cmd9vOb6EotUyJGpfAFgbIekxoAFpkg7D8AHo2sQ8c=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 38D2Pbj7994070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Sep 2023 11:25:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbZUZ8gbIUiq0lQaTp3pGTqtpnfAcraY12ndb9YiVw8/qkTOqPysSqIcnJRs0pHOc7ogvdTG4NtM3iSF36one6eeGqUt06Y1yMSrcqZe5cOBLFNPvhF9zg+m6wjlDNR6fcWRq5fNOff9YhkjXhyNVEEwxX+EWKB1Vq1IRr6bKvG/0MSXGk57C7BSK3VKCMTg+xRoZzjmRkzRcbv3IBWi36rUg2OgtRS9473V/mYOwM1G/C3hgmyOPRo9P58WJIp60ty4TEtVnPZ6A7gbFZ1c+N+52sPD0KZTbwm+8bbpc3N9jmQNUs/ySvND4y+t5nGZmr2N92KKIsZTyQJBMvntJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eOuSfxXmOWG1CUFLc++n+Vm4dGmXAR8uGQ17VQEqKk=;
 b=hI6hSAGTzU61Fe8NZBinxRLn9ihRO/HcxYo34ncl6CqFOdPYTi4806IUYOwfwTNYcdWaBSZsp66Qnkq4ynifoiiQ3FL4BUbmxXMtw/n9dSv/X4qKgCz79rXDcTqrCG7CAgEdVmg6F0KT72oGze9021I7mkEmSCM+Ukomgge2zhURzBDQ1DhJfFddx3CoEgF/MwfJhVmi44iP055g61MjGK50w/q0tte3fa/yMedOWzw2ZfneN6lVtAO5QjXTuovaN4izpyHi1hLePiJKvNt4kiH9IV8inL1jcnQJebvq0NmVyw3if/YyVzV7WU8gbcByPxpZdhF8upKcgT8C8YepRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/15] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Thread-Topic: [PATCH 5.10.y-cip 00/15] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Thread-Index: AQHZ5L7gdBevLxlzX0eZdb+tm4suNrAXsU6AgABXIPA=
Date: Wed, 13 Sep 2023 02:25:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94201AFC7560164310CEFAA092F0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
 <ZQDTgRxUYarvm9Yb@duo.ucw.cz>
In-Reply-To: <ZQDTgRxUYarvm9Yb@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11888:EE_
x-ms-office365-filtering-correlation-id: cf68aefb-bf25-46cf-ccf0-08dbb400b664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z8VOYFmSIOy61s03vAe8nD2sDtdyQU7Tbjr9gUGez372nDWGzwW7pMjX6o5EpNMpf2JbaMqUPkCfliOhVuvSDbTq17h1yI1vk+XsYfVHY1871rcYVhzRYjFdCYYQ2BQN16WQEF9J9HHuaPx/dwR3FdIppfW2jiEhThAMJOP4x/kbUKkTyB4Fu0z+9XplEXCTU1FlYHDOGE9kDLspEoMBCdjF5+Z0oWpuQetz3049YZNB5VP/A9z3h+EHnRUGLEdB0gguGtoTIR69pOeE8+WI72DGJndceMGAToOuZUaiTdgRQNhpkB2H1M6xDO0oLIItPawyl1waKIzCqIdH7fb4sZWX5nYkxmDPXV91P934nr0JbVBvV6HfURXE/B4shEb75nRwEMiG/0VZqbBaZe4Wt1S7zZubGLHPSpgny2uwQBsrZG0dIf/HJbH1Bs5c1Lk/BX6gzhXlfBRcrVbevc3cp13SW4QBb07jFkh+6QsaToqXYmUsOCb1Ayn8L/cnhSdJcG8CQijT2ZbhBgzt7ZD+iQ0JAkjAM+BgEnLuyoIl4obHW/wSZ5p0/wLLTHwK7pBKNzx6RbjugUBTsFqtG2ZM/hwd7lsJLDafHviVInlIV2Ajirvg3IN3TsG61B47XNfbGclJ8nwumwf+KT2WDCQZUQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(33656002)(52536014)(5660300002)(83380400001)(86362001)(41300700001)(8936002)(4326008)(7696005)(53546011)(71200400001)(6506007)(9686003)(55016003)(8676002)(122000001)(110136005)(66946007)(2906002)(38100700002)(4744005)(76116006)(38070700005)(478600001)(64756008)(54906003)(316002)(66446008)(66476007)(66556008)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WXpZb3FUMUhvei9OMmxqeGo0bndOWGJPeGV3aGwzazFqL0k1WTFiYlZ0?=
 =?iso-2022-jp?B?Y2d6ekJjUEhXNEJmbmp2Mk4yOG03aHJUVThSSWJ3bmlyVEJJU01zM2Z6?=
 =?iso-2022-jp?B?bHpkbCtVdzM4OWdha244VXpFZFBWdkZxd3V1ZFQwM0FhYkZaRUc2YUZl?=
 =?iso-2022-jp?B?VE93a3NVZlBCREJtRHRGT2dwRTU4dVlZNElnL0YzeFZ6U2U4Q2I5ZTYv?=
 =?iso-2022-jp?B?LzB0WTcwR0tvWGlCYWJkQ2Q3ZkJqbEt5ZVZJcHM1bm1NT2FvWE5kRHJK?=
 =?iso-2022-jp?B?T1VOZnpndk5zaVlLTUt6VW5Sa2FIOVJSeEgxVnkwNE9hNmVaNU5xbUY0?=
 =?iso-2022-jp?B?Vkk2MUxRcGhuZVlTS2tESUVkMFBFTFVYWUZRaVI4bHYvVEVDQU96cVBQ?=
 =?iso-2022-jp?B?U0hXbnkySk45b2pEM21OdVZCMkJDOFJtMUxpdGRRVi9ia2syQTdWaFFq?=
 =?iso-2022-jp?B?K3NSemtDekFlbVFZZVFGWG5uL29iemtyMGJJRDBaZHMzZ3FJd1JFWG1C?=
 =?iso-2022-jp?B?azZ5T2Vxam1wR09qR2J2eTA0SytSWndUNERtOTlvWGxCWUxPemZQTWtH?=
 =?iso-2022-jp?B?TG4vTUVnVzVVVm9RdVNlN1l1Q0lRckM2dXhQRGNJME9MZEpOMFNnYUVs?=
 =?iso-2022-jp?B?NkNCd1dieEkyd0l1SGQ0RHVVSnJHUGhuMFQrTTNQbG9DREQ2ZDd4alFu?=
 =?iso-2022-jp?B?WnlCeHpWRHdnR3l3alpLaHdneTRIMHl5S3lxMGRJZ0E3YUl0a2YrcU9l?=
 =?iso-2022-jp?B?SHk4d3hIL0NESGUyTXZRTkhidXAxd2ZRS2ZNbUtIZXhXbUc2YjB0NnFO?=
 =?iso-2022-jp?B?RkNpNExPWVR1ejU3YnF2SmZiYlVZMklHL1dUMTFtVGE4YkpBYWJ5bDFq?=
 =?iso-2022-jp?B?NUozWmtzR2J4R0w3TFg4UWUvOWc1Vzh6THBQZTl0ZW96cStaakE2VFZH?=
 =?iso-2022-jp?B?Y3hubGVlUVBLUU1zMVp4VitYNVh2K2xUVTdvYUtScEZBSmhsY0VYK0pk?=
 =?iso-2022-jp?B?RVRaMENsRkN1Z1ZxeHR0alFGSjlvR1JjclhHVTNKcFkxejFJM3Jpb1pF?=
 =?iso-2022-jp?B?TDlOdVdlYzFJcjNrbE9nemJPSXNrMG8yS3dxVTdJcXR6bUEwYVQ5Ynlt?=
 =?iso-2022-jp?B?MGtQUC9NZnhjaDA1eXdXN3FuaTZpNnA0aGhZNDJCVGNaNGJLRVduN0p0?=
 =?iso-2022-jp?B?MnByREN5b0JMVG90TDJZUGZWNHlKYUdBWnJkU3I1cWxaRlA4dFpQc3NV?=
 =?iso-2022-jp?B?djhvQ1MwbHVPdFZZLys2cThRUDZQM0JsaHlzQmxvSy9Zcmt5N1B4SWFo?=
 =?iso-2022-jp?B?bmtySXpGaUxFb1FVUmdzZjVkbTVIWVkyZjk2TEMxV2Z3QXF5WnZyZXJH?=
 =?iso-2022-jp?B?UWFIbDhmTzhpVXo0aHhTQmZVUkRTWmt2NEYwdkd4enRtYUltOUtVUEI4?=
 =?iso-2022-jp?B?RjdjMi9lL3EwRit6OGJJaFhuV0NEY0g3SW9NSlZqU1MrcHpxR1B1d1hz?=
 =?iso-2022-jp?B?UnN0N1pNckRjQmlXd2pUY2p4cVBJVEd6L3F6ZXNBb1g2YTY3QkFhME85?=
 =?iso-2022-jp?B?TUN0bHhUUy9NOTYvdENKbzFDbWRoQko3UW1vTnZQbG9veVZ1M2M3RWdC?=
 =?iso-2022-jp?B?eUFzVEpmd3Z1NGJPUHo5NFg1WGZHVDRWQjg4WjkwY2F0MXZNaFo2N3pO?=
 =?iso-2022-jp?B?dCs4ZW83VXVDM0p1cml6MC9xcktUMWsrV09sRHM3U21MbjlIWGdlL1RX?=
 =?iso-2022-jp?B?TW0xbVBXWE1seWpIL1BIMXZ0VmswZS9aK3JreHBEVjk5VzU1UjZLbFhD?=
 =?iso-2022-jp?B?aCtVV2lMdUhNUW0rZ3VWdm5ZdCtSRE1tUVAyWkwrZXZPSXZzZXYyQTZI?=
 =?iso-2022-jp?B?WHh0N3NUaEtsd3pQYmdiSTdzaTdUSENTMDdSTUUvcllqMlNSdkEwOUV0?=
 =?iso-2022-jp?B?Sk5pQnFDMk5nUkM4V3VJb3hGaE5YUjgyakNCNldBb01TR1U5SDRsR0My?=
 =?iso-2022-jp?B?TnY5dGR3TXRpM3hPbWg2N2FSaWM4cUNEQVNPRDZqVEk3SVA5aDF6MmxZ?=
 =?iso-2022-jp?B?K2EveHJJTlQ0WkN5dXpBR2NhNU9PTjJnL3gyTUhiOTRXQUhGOVhrR05L?=
 =?iso-2022-jp?B?ZVZDdDJaQUE4YjYyR1lreCthbjNpNklPMzdBVndWenZZeDZFMnBUcEh4?=
 =?iso-2022-jp?B?NTF6ajFXcUZDeHRQbVdwMlhMcndPRExOSk5qTWpCdGI2b08vQnZ6bGhS?=
 =?iso-2022-jp?B?cHhCTkQ1R1dnN201RlVwL1JXMUEyRFloMVFYR1BKVnZWdGgrYVNGd0JG?=
 =?iso-2022-jp?B?M3FyM3RYT1BhZ2N3K2VCT05SdXJRU3QvRzRvT0lsb1Mya2Y3S1RUSTVU?=
 =?iso-2022-jp?B?bnZEK2ZuMjJTTWdKUFJoTjlQMUdqUHl3ekF2Wm5lb1B0UFlHUk12a1hQ?=
 =?iso-2022-jp?B?WE9aVGh3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf68aefb-bf25-46cf-ccf0-08dbb400b664
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 02:25:35.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjpGHI0dC5GKInY6rgOzdZ6QGKfsNfjvCHR/Yf1uZQpVgXXOxm0j2QnU7+QT1BNOAlsznFWBEo4NbDWo5nk495PX6iZZCz5DclmXBxR/Jh2AjYnPG1djO19raogRbkoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 02:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13094

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, September 13, 2023 6:09 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/15] Enable Renesas PMIC RAA215300 and
> RTC builtin support
>=20
> Hi!
>=20
> > This patch series aims to enable PMIC RAA215300 and builtin RTC
> > support
> >
> > All the patches are cherry-picked from the mainline except the first pa=
tch.
> >
> > The first patch is equivalent to the commit 2023c5c8fe2e85 "rtc: isl120=
8:
> > do not advertise update interrupt feature if no interrupt specified"
> > on the mainline.
>=20
> Thanks for the series. It looks okay to me and I can apply it if there ar=
e no other
> comments and if it passes testing.

I reviewed this series, LGTM.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


