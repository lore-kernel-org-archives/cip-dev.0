Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4331.1795046156706435736
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 15:55:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=F+q/b8zb;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1795046145;x=1796255745;bh=oh2gKQUG82wkQOn+sdHOInE+nAJE57WsdNSJy
	rzNcsk=;b=F+q/b8zbHh8rUy9uWBBlYy5fMJ7Mz6OGdFilzjNzfnsjBMoHIvQw63wdQNqYJtXsQu1
	QEBj8ZG1F1VE3bbiVhbMsKCrrigxfBh5a4ZQqWSLGV8zvX4ydFiRS/nT/uBLenU3ZINrLgfAsdlkK
	GVHQDW3d7gKdDithxkiKuGZdxY6SnYlsVblk8C0hAv6phNnSsQfcgAR4AFv2tySn6QEadhtVm8YEc
	FLfyR9HUlu8OiPgIlyDZyqLniof2HEoy8ha0qQ3+JILvDRjPaJU4eviixwpkmrqF6MatGW5raQteC
	CwNyc+8eL5fTg4TaEdno5vQaiXFU9PKf91L6uvhY2jkQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AINtj6T3754972; Thu, 19 Nov 2026 08:55:45 +0900
X-Iguazu-Qid: 2yAbBL6ZOPiV6bwOD8
X-Iguazu-QSIG: v=2; s=1; t=1795046144; q=2yAbBL6ZOPiV6bwOD8; m=VNKtzxtg3Fk/fmGIlUp0Z9mmrsY5VJUhSwOfVZyjpgA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jVJQ763Bwz1xnk; Thu, 19 Nov 2026 08:55:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbT52kXiPbXQ/JmLdmw6UL3ZEjvc5P4CNPOabDsdENYAM0GsaEz5zx04rEKHTQ5ay8ln5U2h/Y+IuP0dMMNA4zY4sR/7DZHblBIoVn5jZvHUDNoqom5H8QWVCOt1iqMRp2PeG2t/hJUFWztNldIVPB8lN7YmnGryhtjHAhmyaczGNKPrWnNpSB7pMNQMV+rd0XP1o6UutEVdHdNnzl4jXgaxr9yz772vOl0vyfGAx5eUvzOfk7qIAqIIra/RSJxsoZCh/UNwe/GNFGFIpIKe/nx0s8gHWmYQUSwiywLK0KTdHd+HdyHm2RlitbuDvI3lOeKNIzECXzxYI8vFCTUUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYdfw2vQOCT4Pb8LhqhpVpxrvFjHTUMrkn/HBy7P1F4=;
 b=y8Mq7o//rCLHhfWgIRG0RLoV+H/KXvBBXOHx6rEjscKWjSF+qFKxMuwGwWX+E9jZcIeSJ2rSCOtAClHZFTgGYf2faIfAYD+otCdKfHMCItSPStHwkDnEWlxuIFPgzFVQMqmmOyISv/nZluzdAzcpKApFLY/kDbnu6YLm3Ce9X698grzlcNLuUv+DpoFuohTtTSPBQHo2+QHwz9YDhpgh9TErbTT4SIANf/xBItn/bvhuZq/HoWloOCNNx8/ZuMhhAf2G7E7LuVLtkd9eASkoMBWtKQ5bXCRA2BWfQ4x4SYVoSmBVD2JYTplfm9dr6hXu5lmRoLMOtYjO10v+VnDgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <jan.kiszka@siemens.com>
CC: <masami.ichikawa@miraclelinux.com>, <cip-dev@lists.cip-project.org>,
        <uli@fpond.eu>
Subject: RE: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this week
Thread-Topic: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this
 week
Thread-Index: AQHddf8kt9pQlXSsc0Ouo0UJR/DpHrcyyI0AgACSGQCAALWRgIAAciYQ
Date: Wed, 18 Nov 2026 23:55:40 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148181966A2E8A79ADB06B417CD7A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
 <avzGdm2kkPzk8cLD@duo.ucw.cz>
 <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
 <av3ZUzcCn01qH4YJ@duo.ucw.cz>
In-Reply-To: <av3ZUzcCn01qH4YJ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB144240:EE_
x-ms-office365-filtering-correlation-id: 43df6cbb-18fe-4cd8-ae40-08df45cf73a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261028144727099003|38070700021|10067099003|4143699003|11063799006|56012099006|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261021121427099003|261026140227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: mbZ6uJDQMdHKXDzgqfFUQPncV/nbHU+QZe3D22oG5uxftLtp/5NmDI4PM7+7suKuNcwANHDuq0ahQAha88JHISXun7Ev1Szl0GGaac2QHrRCfdE+/ntpMKzE/V6Lpma7rocOexuegJ+vmSEz/S4TVn71MGnZTRok1poLzjJgs4sZeimXFF4QUwAUflwGfOKBiy/FBl5Z6zEePgxtU19dLvPGEPyk5EEVEApzbmAhk5KwiqM0dt2rMYOby7jN7KbaSPVQIXyUCKtC4DZQjlKK6o4Xj/M7knBCKedp/COELoCeY5crdCUVVycjKplEs4JPUoBfUTykAaUT5PYTCrelevN98aYQl5RrYHzn0kLadBGlvPY4VMIIsjct8BXIYeBDbT1Zn65plGmBVz5O21E84ltIXZ6dNeVsBVGNOKjYgHgzuuBHa3x9JmDcjfa1Y591JaWt4/PFy1ih4JIzNIK3Ct2dxZF9lMtpSrrNFqzbm9h00QZEFlkzERTQFRtH5YlY+7SawypArqWfqkvRf9S5WVDoF1ag6VnrCNITf/MwBO7La4Zopo3lMq/M99gOghhrI09uMvo5H9hw/1tV6TlgwrC17lZP37EnLJ6XvF0zaxppo0nXSg3lEcAkOi2BR69kDZhTS7fsCofhVKMsSwOVFGFJGwgH3zBWzo3jN14mz4LeXxPR/tNZFPIJ/0bQSdKtCeSaMiRjlPpjc9icTtEC2Js4a6YIlARxLGtO2kex+Hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261028144727099003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261021121427099003)(261026140227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aVFsdUZ3L2s0T1V5dVFXZU1Tb1RaVE9WNEo1dkkwbjhxWEFRamU4MzhK?=
 =?iso-2022-jp?B?WHloREp3eGdZNjBaVDIrbTQ3NDZtU0xWbnVwclNZWEFKeVFwNzlyUW5L?=
 =?iso-2022-jp?B?Nmc3NE83NDlGMWNpVjJvQkU4SGdHZXdwMmUwRWsrRUoyeTRIMHpJeW5n?=
 =?iso-2022-jp?B?SEozRjRMNFZQaW5aVWJkK010cXR0bWZXeXY5bDF2dERTRzJEUnUrL2h3?=
 =?iso-2022-jp?B?bVU5c3dwYUJiREFGY21oamJHU0I5bzRyK20wWE15S2pwVEl0eVE4OXFV?=
 =?iso-2022-jp?B?SFJhRXJxK0lFK2ZRSXcwNzJjcjBTaE8xMlA3Ky9PZ2xCUVV0Q2oyaThx?=
 =?iso-2022-jp?B?YytmbElPSDZBYmpFQUFBSCtzV1BaemxLNW1DTzdyWGNiR1gwTU9KU1cr?=
 =?iso-2022-jp?B?aXMxb0xGOVRrRDRsdGZlR2duYnB0LzNzeVNpMkRPVU12WndPTmNGNTFR?=
 =?iso-2022-jp?B?S2xGazV5Zy9QbTJVY1Fteml4SkdxdEE5RjZOWlV6Q3F2Y0pBaStSUDJj?=
 =?iso-2022-jp?B?TjA3dXVBNWhWRzg3UnRWNkV3OHBMY3FpK21UNFJscmhzZTBHNW90dHVh?=
 =?iso-2022-jp?B?dHh2Vmg4Tlp1aHFFc2k1YlJhQnNPakxyMmFVdjhRdTV5V1Q1a21Ibkl2?=
 =?iso-2022-jp?B?T2RxV3VZN0RDRzd2ZTcxWlAwbDJkL3F0cUVLaHRRQlhjWmFiTWVPcjVj?=
 =?iso-2022-jp?B?aGtKcGRuSFJvMVlpeTMrc1pSVWdKQi9UMHM2WGFFT1RCQit5VVI4WjJI?=
 =?iso-2022-jp?B?SzdJaGZOL3A1czNlODJVVHJZVFNKNExCcEhxdlI5SExDdzMrRCtvTDc4?=
 =?iso-2022-jp?B?ckhtY1dQOVVkOXE5bHVTdHRjYkk0VkRHK0VqRnF1OWdQZ0RYTlZDdUFa?=
 =?iso-2022-jp?B?S0tUQkZJKzlpcTB0MnpQZFlrNHpjV1FFTDlxbEdvTUM2RmZtM0FKQkJa?=
 =?iso-2022-jp?B?bmI2UTk1cy9rL3picVJTOXM3VkFsTUg3Z2t3eG84b3dacHUrMEswaS9q?=
 =?iso-2022-jp?B?K21PeURmR1dpdllmR1Y1WVNxNUVHYTZoN3lsYzhKU2IybTI0UUd4bXho?=
 =?iso-2022-jp?B?SVJmZU4vV0xSZFFSYXp0Tytrc3hSM04wQVRCUDArZHBiNm1xcytjY1ZG?=
 =?iso-2022-jp?B?RFRzRy9JVmM5UVRVQkR2N3pNdXNIRDkxaXhLclVQQTc2M0JVZ1ZUYTg4?=
 =?iso-2022-jp?B?YW5nMUdyS2doR3dzeENNdTVQUkcyUVlBcENlZVdDaE5CSzhUUW0zb1Nl?=
 =?iso-2022-jp?B?OWVGaGttc2RUUVdjcG5DRk10ZFNXZVdWbjBYWmQ3aTFsSkNjaCtNL0xG?=
 =?iso-2022-jp?B?VGhIZ29zY1BYN3QzWmN5cWIvTWJLWEh6QzlqRzM2cmJ0cTBWblcxWHdk?=
 =?iso-2022-jp?B?a1pJbzVPZjYzaFBsQi9lN3dIMlJ6dUFDdVZmRkE3YU1aenVOdW9Za0Vo?=
 =?iso-2022-jp?B?dHBBWUNNNVVaWkNJNllhQWFWYi90YTVBenVIa3YzSXhScDdMMHpKN095?=
 =?iso-2022-jp?B?NHFqVHJlSWVCYnE5T1crUmNiMUtPTEludVNxUnR3UGQ1aFphczVmWmVx?=
 =?iso-2022-jp?B?Y2hYQXp4dE5HWmZqd2RhMSt6L0MxYnhuYjBrRHBQMFUrSEM3VCtIdFVZ?=
 =?iso-2022-jp?B?TlUvL0JKTkVlT3dmZ244NVJOVXAyWG1DM1dEUGtPVVNBWCtCUEhDOXFR?=
 =?iso-2022-jp?B?R1lXRk56dWV4V1B5MXo2S2ZNYVQxUEdvNzltQjM3SElIeFBpV2FOK2Jq?=
 =?iso-2022-jp?B?OFhuR2t6V25vQTI3VDhIRFhQWWk2ZTRzYU03d05UYXRKL3JFT3QwZHds?=
 =?iso-2022-jp?B?T2paRk1tYUpLaTNBRVdCTk9ZYVdRb0ZzdjkvMWQ0SnpTemFKd0JBbmsv?=
 =?iso-2022-jp?B?WEEvU0tEam9FQlBFVE93a0kvdlEzOGpUODR2citDR1NybDJXb21yN2ll?=
 =?iso-2022-jp?B?VCtKelhhQjVEN2hzNFlpazUxaWY5N1pGeWEzbE1jVGNPWUI2QVFmU1lB?=
 =?iso-2022-jp?B?czNiYzRBK1BkMndUZ1RqTFpNQnArbnppcU5oeXVvVkdBOTE2Zm1qMEVq?=
 =?iso-2022-jp?B?ZzRuSnpRQmsvY3ZrKzB5cDNrQnV2Y2IxWnU3UE9JdzNwT2tzQlFkV3pF?=
 =?iso-2022-jp?B?c1NobmMxTGVNWWxOR2FydUFUcTgwNldibXdKaGlaTVNrK1V1TmQ4bzk3?=
 =?iso-2022-jp?B?NXNOTXY2aEhHd2htTjNNWmIwNEFDTzhDbjg0Mlljc3F4RUE4bzFVaU1v?=
 =?iso-2022-jp?B?cU53T1hRTTcwL25TMjU3eXhCQUVPSmZuaGF2UFZDZHExb1pJT0Rid2tG?=
 =?iso-2022-jp?B?U2lVSFB2WVdZYU81NklVajRuK0xBT0d4TjErdW1NSEtvYVNsd0o4VGJj?=
 =?iso-2022-jp?B?MXdXYmFsNGZGT3FPOE13dmUxdU1lN0QxZmJjQVU4WE9CN0tXa0ZoWXpv?=
 =?iso-2022-jp?B?TkdBY2lmQ083dWNtclRHR0pKaXZqdk9qZWxVMGsvb2ZSQUlpaE9PamVN?=
 =?iso-2022-jp?B?OFZZSHFnbEJCbEJibEdIRzVmbDJjcjdpYUhsenZJOWV2T09rUFRDZEhj?=
 =?iso-2022-jp?B?YllzMmdpMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rnfe1mYJsUTrGNGFmF1HIc5Kkk0S1HFdjxcDBTvJ8uFi0yM+bb1LoADAknwffwn8ojiXdwOllVVnYxFsWJ9bAp33tAz19by9X4GqiaFB4s2s07bAhuv0h2EVobw1zcKnaA6g3lAYbrI+zSfyeNm2YZM2jVHxELIr7/Ehh6gGO/5t3YB4ZGjtkU8jImNVrGFaquLunehgEGDYih/hqScPQKQvFFcC52dVPmc/Oa5LocwZrn/Sg4rMeBE38JDpMHZCAtJ4lUsSmUuOW0I9o9Dvpy1h03vKCiH2naX+NwK1uGoXNeWxx+xL1CEO8XYfIZs6w4duRUnLJMABCCHtL0O7Jw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43df6cbb-18fe-4cd8-ae40-08df45cf73a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 23:55:40.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75+KDH3Ghcwks+o7dWqcMUqaz96MuaBkAtI+nSHIt+CbyhwpZ4aWxlLyzMrPgZFkhRejW06/D0ohn0+/bYZquDXCckXlRGRISYJ1d4SBTXJNtv/YJbow/dovF/5CcYXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB144240
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 23:55:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25004

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, November 19, 2026 1:59 AM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Pavel Machek <pavel@nabladev.com>; Masami Ichikawa
> <masami.ichikawa@miraclelinux.com>; cip-dev
> <cip-dev@lists.cip-project.org>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.=
MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Ulrich Hecht
> <uli@fpond.eu>
> Subject: Re: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this
> week
>=20
> Hi!
>=20
> > > I tried to do a quick research, and this seems to be more of server
> > > issue, and may be hard/impossible to exploit in embedded systems.
> > > Researcher's writeup seems to be at
> > > https://github.com/V4bel/NoisyTCP . Quoting "so it can be triggered
> > > against servers that have two or more RX queues, or where RPS
> > > distributes packets across multiple CPUs."
> >
> > Just to be clear: We have server-like scenarios in scope as well.
> > "Embedded" does not imply a specific size of the system or
> > performance.
>=20
> I know. I'm just saying people should not really be running
> "crash-me-if-you-can.com" webserver on 4.4-cip (on public internet).
>=20
> > > sudo sysctl -w net.ipv4.tcp_syncookies=3D0 was cited as possible
> > > workaround.
> > >
> > > If someone believes their machine are in danger, please let us know.
> > >
> > > We could do 6.12-cip fairly easily, older would be more tricky as
> > > there was no suitable -stable release. But I don't think this is "as
> > > bad" as bugs we did extra releases for.
> >
> > Can we support on this, or is this ongoing work already (<6.12)?
>=20
> -rc1 of -stable kernels was just announced, so I assume we should have
> suitable 6.1-stable and 5.10-stable with the fix, soon.
>=20
> Unless someone tells me otherwise, I can do 6.12-cip "soon" and 6.1-cip /
> 5.10-cip "soon" once -stable kernels are released.

Thanks for your update.

Although it has already been released 6.12.y-cip, this fix for the 6.12.y t=
ree was included in 6.12.117.
Therefore, it was fixed in v6.12.117-cip35.

$ git describe d69100340b4cae08d40f898f1b601032403f6be6
v6.12.116-857-gd69100340b4ca

Best regards,
  Nobuhiro

