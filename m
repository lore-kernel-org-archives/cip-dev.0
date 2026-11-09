Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9445.1794191252873835837
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 18:27:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UCJqVh4q;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794191248;x=1795400848;bh=2FTvF1Ym+A/RdBlvzyaxnCBAkFPyM1r7yJUVm
	dqSY9Q=;b=UCJqVh4qvfFlRW6G49szBSRyw+vvENk4kqqkLtcTr0VsBuZ/Y/P0a+kK5Q113bKZj+3
	JdMwtWwuRDupYHL9VRQcVTRsCJwNPsu0THMhIvis49yaN2cqc6+3AhXqsTmWhBJFoiSwKG3Kzv64K
	LOSxmNlUsmCzCAEejHjkU2MN2tZVLtvDo7+7S6dqe73PTn6kC++u0MLLndVHMrmFgEJuABqUlzhAh
	v4qgqYWUhNOM+gfFRBytgAdCr9QaOO8eKnT1zw66eI9fkN5jXoYU8uKWsMJkrYy1iWHhaDP7atfMr
	woJwFSMAqAbvMtG6945ZFw3Aj/pfE/Bc1eccUP209zQg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6A92RSQP2588156; Mon, 9 Nov 2026 11:27:28 +0900
X-Iguazu-Qid: 2rWgw8g3rTSRaqUrJ3
X-Iguazu-QSIG: v=2; s=1; t=1794191248; q=2rWgw8g3rTSRaqUrJ3; m=Ij8Wsxehsn7lDAf7RVfi+5ZlYflmAFOM6bT6ybaDb1U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNDFq5jnrz4vym; Mon,  9 Nov 2026 11:27:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAID9szjdec60nPp9zwQ6/9gr+kP2UDaHiGhbF/eYtF+THY6MeQtSDUnh/kL1nS2gjOtmW50hSGl6eWaEm3vWX7loPJpRqAj+neD6Dpbko50A9NRd8GNswzE7pgav2yy3k4H+W9dPsaVH7LXHltjeLQuCQLlAPtaPTHRM4GQQGOA0DPY7vd3v/8sD/AaKrZTc3no/oj6E9lm5Gj6u3Vo2puZm2HcXb9A8ybxSRFlO+JVM6OdekBMFMYAtg2KxDPJtxuQEiooivVrmAPRbBIAE9aFddzGhdal5itTZkV9PzxlSgmiAUDhtz8eFbhW3M/7l9PEsoY+IPn+3O4kNTeJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+68SgPuYNn4AYrR8lmctyfzvUojSATHmUW1Xfj9dZqc=;
 b=WHwjuP2bowfMVBxf2v0TiaaFqhq8M82sH4vL6ECzTClxqaWkvjWOljRPt4Sv3wHJzDFoPo+wRKWXBMBSJA8DT0BlG7dtmE8+kRaeTJTHU82JU8iQhh/pOOc3y1dMqRGpcu57wrC28eEI3fek6uEt7ch46cOoJhCCJDcxMaths41eOQzmg9b3JAXVLEZpGoVpxKQ6Y78jaAZadcW7JU/wnjH7JYkGONMVWbwyy/xM0SiltKSdiY7fr62y96tLAIFhxvUO3UC5ACKHdXuymcMxh+twCpVz7w3LXVW5k+v9KGroFMbiHGkjlNreWI/m+EOzkswf+riSLIhg4GHEaYLJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/7] Add PCIe support to Renesas
 RZ/V2H(P) SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/7] Add PCIe support to Renesas
 RZ/V2H(P) SoC
Thread-Index: AQHdaskpnmkEVZdwl0Cqy03XKUegxbcfqu4AgAVjI9A=
Date: Mon, 9 Nov 2026 02:27:22 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148185B14693B7A673CF616D4CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <auyqluIRkxpRjoq8@duo.ucw.cz>
In-Reply-To: <auyqluIRkxpRjoq8@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB15460:EE_
x-ms-office365-filtering-correlation-id: f0b288f9-f9bf-4ba0-8fa7-08df3e08fc63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: GK6unywvGJdm1qbUdCiCfw+uDiebT4NVuNL8plgFAmdKjfX1rnEpDhColCFkWopXk11Asa175HhZF4QNs47MgrJMld48n/wXzrS0gx3X5ryj/1w0iGgDxwB2Q1DLxODYir5ME5+ZrLbHfgCmpUCQQ2YOW/7vJEPxmR3J0wuMEDsnQe1036+77S/S3QKhByYS0CisbvvhBJpS3XASUy+vrB8MAsgHjYgyxhH/nEWq2i2mp3/qI8+l3YKFdny6rf2V/QEcyuTeQ2WrfOxk9MFzRpaIeqqjgHx7Mt5CEs5pHcsRgrjof+KekMCV5ixXvqyyS5FD7He/sSZsY3ykRoZ1aze7gDiu658FBSrh+/CB9P4pqUPz0IIRdO34IjZexv7m9PLCwRFr47rP8oLRHWKHjlIX4Ae/WQSjG6AveHxl38fFpd501/G+Dae1LxFPMsHM+yqWji0MNk5cpdnioQiliZvXqwsf+ntdE9QYxQ0lAHrcXSBNScVIHcshqPtMEWMZYenQHzvDJjyf0uk+JY2hODVxqXtCU/3QasGmDNRtFSzn83gtYlJAUXzVjODes8yaE1UOJimpeq1jITr8dFK8zI/j9ODbUK5lSYAdFtnMdJ94ylPhF10wYbhuMdNreRjTeWEKb623M+U228AqEQCaA2jJ8yrgvaFpQPO+sHYfjk1MH9AQ+YW8inFBvy4QebDG9Zqhm2CxDyukXiL2bOI15A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NW4vSTlJKzVKNDdUVWM5VTk3SWxJSml1TkxnYUVnRW1DOU9Pa29sMTlx?=
 =?iso-2022-jp?B?M1ZwQWljNzMvZHY0Zm00cjltYStUZzJ0d3BWNW84Mm01NmF0ZFo2dGJm?=
 =?iso-2022-jp?B?N3phbkNrL29tUHBBZzRjZ1VWS2ZxUGlaaFVNc0pkWEJib29JTS95Y1M4?=
 =?iso-2022-jp?B?SWhHamlTQzF3cEVJVzNXeWRGWGdmZC9lMUFTZ3UvTGRweUxqanV1SE9l?=
 =?iso-2022-jp?B?YUFJVDdIRUs4bythYzF2dTFhNDNxU0ROVlFJRnQ0L1g2YzJadkk3MXFU?=
 =?iso-2022-jp?B?QjNZKzlML0Rab0tkVVhjbFVkMkZLRTRxU0JIb2VmVEU4aGhSYlpJVmd4?=
 =?iso-2022-jp?B?RFJPbHQ5RVNQS2h1WVhCVnhld1lEYUlRS1NPb2dRZzkvRit2RU00NDFG?=
 =?iso-2022-jp?B?OC8rMUs4am93SVBwM1RMTUJySFY2YXZKaWMwMk1rN3NLZnJUQ09yZHVw?=
 =?iso-2022-jp?B?Mm9CZlQ1UVBuY2FmbE0ycmQ3bFRGWHhmUDFUNzh6dGs5QkJETlliYUFO?=
 =?iso-2022-jp?B?ME8xU0E5N0lsMjFvSmxtVmJXWUFIb2xMRVQzK1JBbmFtM3BEZVZCVTBz?=
 =?iso-2022-jp?B?ekUwbGtNcXpsZGNsY3RQUnNLL2N2NDBvREIwU2lhVU9hQzZ6dU1DV0lP?=
 =?iso-2022-jp?B?bUNCem1PZm5qa0NQT01rMG9RTGY1NGdmM1kzcW4rZUNwcGJOVWN5OEln?=
 =?iso-2022-jp?B?NTB1dmhnRWZWMFdhT1p3cmVOenNtUXVEQTlDMkthZXQ0UU9RR3VFb2VJ?=
 =?iso-2022-jp?B?U0pGa3VnejMzd3dXc1hQbWdoYVBweC9XV0t4NzYxWnV0YndKeDFjejhq?=
 =?iso-2022-jp?B?ZitJb2J6ZW02ZUJTR2g0Y1pHN29WeGdMb28rVjBJS05MTWJvdVVuR1VV?=
 =?iso-2022-jp?B?UjJrNWhDcnY2WTd0WUtKU1F3bkw3ZERGMXA2R3VCMi9zY0VzcGtkLzlw?=
 =?iso-2022-jp?B?ZmRmVk1ZUTZSMStQN2x1a3d6NnU3Nlpqd3dBdnNpWTI0eW84T1pDa1Q2?=
 =?iso-2022-jp?B?VVBzSGhBOUZYd0FNUW5kMCtCcVlETmNWakFBZEt6czdJMGoxN3dvS01i?=
 =?iso-2022-jp?B?TXJRSGlyVHZlbU84c0wxNjZrTEZaSkJOeW5UWFp3THFOSjdRVVRQNTYv?=
 =?iso-2022-jp?B?NVYwa1habVVJak9sSUhnMnNGVnF3cEZleVpsQWxCVHYzTkYreWpmWEpj?=
 =?iso-2022-jp?B?eUk3aE15RUJwejZlZXpMY1JVMmQyWE9oaVhnTDlxRktKZG5yRnhSYUFE?=
 =?iso-2022-jp?B?STVnaG5FUC8wZ2xRWFNtVkV6OWpCRXVBVUM5ZUtmREdrQVpvUjdMUklh?=
 =?iso-2022-jp?B?dzRpUFd0bFJLdll0R2VnWkxJSkZ0NkJWUEVOczRvcW02UmdZOWpUTHZu?=
 =?iso-2022-jp?B?MDRBNWp0OE1sMUErcmZHZ1puSUF0TkRNS0dhS3B5N3RiNFZRQ1dsQ1RH?=
 =?iso-2022-jp?B?UlM4QUxTMTZBdS9henlnTHRQV2craDc0QXBFNy9LbjNaeVdBVGcvaUZu?=
 =?iso-2022-jp?B?dnZTaFd6YS9HVUFVRlBVRldzTXhzN0tab083ek5mVEJJZ3BadFFmUDZV?=
 =?iso-2022-jp?B?OG1UK0hxOS9aZjBSUW5RbTlNeEdORjY4aWxzQk1GN3lsNHpDY0Fzbk9o?=
 =?iso-2022-jp?B?ZnVSWVVPQ0hpZWRqWmZUa095SGZ3SXkyUHRnUnpUdG85amZTbzNVU0lQ?=
 =?iso-2022-jp?B?ajc0NURZUUJ3NHF1cm5BRU1neklQTXgySmQ4dUh5V2J4Ukx3MDlobVVz?=
 =?iso-2022-jp?B?Q05qSzNDR2FrKzBES29id1NzN3k5OG5LazQ4SUF1bTVBU0Z6OHZrYmFo?=
 =?iso-2022-jp?B?emlrbDRBUitpTytFMm04NEpGVjRmczhhMWIvZlhKamVHakVkMjhtWVhB?=
 =?iso-2022-jp?B?c2FaOHBwS3BkTWkxZy9rZE8vaVFhc3F6N1cwMW9Rd3hQN0pOSjY2SmJN?=
 =?iso-2022-jp?B?OU9ZNWErZmltUHhDT1N5aG5uZjN5dE5vaWw4OTBWN1QxSllEQnRWZXA0?=
 =?iso-2022-jp?B?TE1yMUlobnRUWkRPUGZ1SzluSmZGeUZ6OStyTVF4eVdRUTdacFZyR0ha?=
 =?iso-2022-jp?B?QkZuRUxWMUZwTWlPbnVWQThSMGhrWVFnaDExMkp0ajVWcHBISTJjUHhn?=
 =?iso-2022-jp?B?eDlmREFOQ3NRVlEyQVNlbnhUUkdqMmE3ODhzMkUxWDlBV2d4S01rdCtn?=
 =?iso-2022-jp?B?eWNxQk5mSTdnK1U1RkZRazd4QVUzNERCUjJoMCtjNWtLQ0JjNnJaWWdS?=
 =?iso-2022-jp?B?MUswZ3AveXJGMU5qajRIVk0zdmJNcEV2SitjazkvTVdzcWllZFUySmd2?=
 =?iso-2022-jp?B?cGFZZ3ZBTWZYbmdNVWRhTVllc2wrS2l4QUIra0RjNmdQTTNzWEpBTFpI?=
 =?iso-2022-jp?B?U01xNENmT2pnMFA0VHo5bTk5V1d3b25mZFlkMnh0RWZSUTV5SjluUVlj?=
 =?iso-2022-jp?B?UmUvVUJBNm1EMzNOWVNQTXhTMVM1NzhSSnYxaTB0MGY3N1k4WkR5RFdZ?=
 =?iso-2022-jp?B?dnFVZzIySUprMHlEbSt4RVo2SVlVc0d4bGl6aS82cDlEZGtBdFc1aWw4?=
 =?iso-2022-jp?B?ZndnWWhNMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GzWboD+Sbr/L1uFrghTXVi90u+XgwLbOmjQklYugq2O+RqD3S10gXjlzhhMbjlPH/7I0q8zDWl2vKRxtOsgEBeckTY2v9ASFJZq/7YkoIgsNFuzdmfJ1flZ7VvR14QptatSi3ARkXuowUEKGbTYwhRS8WRvlb+DbtK2Y5RlF+qYqi0jFshpngm5ahImSeDQf0iltq5ZBLD5OiFdbWlWkvzyg+XQ59IUNHpljxEcGWle0w1Sl3yMGgG2+dqRL4AZqmJwvMJNRS+xMO1RpLTCf5xSn6YQ7nuFkJwTfS4FEfvxUD2wm1Ml3h+XeZ6jMBgjY+y3FUX6QxIhrkpaTv/10DA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b288f9-f9bf-4ba0-8fa7-08df3e08fc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:27:22.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uckND12nHeZpcqxMtkqUeD+h3tnxxD/ZDahk08VErLMID/v6DbwJh4fev6tb5J8CXYVYdYpY+czB2QuIkF10a1hl+ZUXPF6de9x7FDVdsT/Uzr7+xw9Ci0u4pTGG09PG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15460
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 02:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24669

Hi all,

> -----Original Message-----
> From: Pavel Machek via cip-dev <pavel=3Dnabladev.com@lists.cip-project.or=
g>
> Sent: Friday, November 6, 2026 1:11 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/7] Add PCIe support to Renesas
> RZ/V2H(P) SoC
>=20
> Hi!
>=20
> > This series backports PCIe support for the RZ/V2H(P) SoC and its EVK
> > to the v6.1 CIP kernel.
> >
> > The series adds the PCIe DT binding support, updates the RZ/G3S host
> > driver for shared reset controls and multiple controllers, and adds
> > RZ/V2H(P)-specific lane and system-controller handling. It also adds
> > the required clocks and resets, describes the PCIe controllers in the
> > SoC DTS, and enables the ports on the EVK.
> >
> > The EVK DTS uses a fixed 100 MHz reference-clock node because the
> > Versa3 clock-generator node is not present in this tree.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I applied this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro

