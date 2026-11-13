Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4121.1794605245958256272
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 13:27:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=EWyZcOFH;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794605241;x=1795814841;bh=C5Vdt3bSdIHBi9kc8vvAqaBEW6dYDlJlLI28H
	kuOG4Q=;b=EWyZcOFHk0yD5vInvu386hhTJ/mAyleflAZPfmSes0wz6DayPvkBrW176IA/lIQcGJH
	K0BH4IscxXJoUsb56aOdwzl78gv9rawNAffmMCzvKVJIeKd9lUyDv/S1ge8LEwM7aPS7ieM+LjTU8
	S06hhzlkI+qktUBAo40roFbASLrMn/ssr9GmTiS+9G5++GN8FUP9teeN9QM31N1KtjGB2S762p4c7
	Mn7gh8O5ROC6dJuDZCHOngdEdhe9YHVMytoYA439bFAuh7RsVNoUyok1ZOJfB2tcVsRLuYd5fmx4Q
	dONWtmkr2POsm6tHtBYmxDRwLFLbzt/FFsGdOEkPKiKw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6ADLRLGX1340527; Sat, 14 Nov 2026 06:27:21 +0900
X-Iguazu-Qid: 2rWhqUWdou8jmKxbBQ
X-Iguazu-QSIG: v=2; s=1; t=1794605241; q=2rWhqUWdou8jmKxbBQ; m=cBAzc+IVc1ZS6Twdy6MiDtnCNWu8BZVGa15PzB6qQvg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jR9MD1n7Jz1xnf; Sat, 14 Nov 2026 06:27:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZuYZqOWfDIt4RBnpTmTV1rel3w5omu/RrYWsULTqTcz5jdqGjsplxG3/YdBOysQXSp3+RjlgrRG1Pd72Nr16gkLiO4Tv3xJOShfuN00tqeWzJ7AmrQI9oocUOb/PWvC5ZyvtsIXtvFKIWpULxQpqXm1dbb6v4Hlo5TFf5xsUIGK5q/4DRbQ3viYgraouqXiQVAKH/XSUaPqIbCAdUcelCZGwVEA/1+LaE6oGrFNAKwIGRZLm6mIVN2PkArxDgvAWNYc1GjAqGyriD4lWZKephbvXpFY+PR6ESl2yDyEg49lqmZtUesSl4hLL4Ut6t+EIqJuksgCYMh7sxqqHg4R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB5dS/XZ8yFqAimnhIrhF7zRNRUuB0Tapf1bS1ucTLk=;
 b=UlUi3NgfLTpV8xbjwJCKR0zVmv5uigGxrwNMIHhk4joMtJR2fY6gOg0GzR3NtDzW7pFvb1BJr2xcaaGfM+qsLZbo/5UBIHv1MRW0Yl0x/l+BTfgHomJ6YY1ufv/iTwFBqiKwjPlYjTNQJnleCkyEZQ4ePPl7uT9zI3gHWBqCzg131G0vg3qXa/UX9cHzqby3tr65MgATlJ5h8mdQuVI3BQtyleyJFEDYBD6tyzy9Y6sbxYwdyHCK/Mz14J+V/HUPTL2ZsLJhveElmHRJKkv21mqRRDUa1h6LyMNvUeynFX3T51neJetps5hWrYVjxWHXJZ/N3xyIwIKReDNYZtx38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
 RZ/N2H SoCs
Thread-Topic: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
 RZ/N2H SoCs
Thread-Index: AQHdcEP1MnrqEchTTESqm36f/PU88LcrslSAgADYBgA=
Date: Fri, 13 Nov 2026 21:27:18 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818B045362B469FE775E88DCD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avbK92i8jrUrGjan@duo.ucw.cz>
In-Reply-To: <avbK92i8jrUrGjan@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10064:EE_
x-ms-office365-filtering-correlation-id: 7dbf878b-e40c-41b2-2daf-08df41cce509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006|261102123227099003|10067099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: lwvIwQPHzks2mqdn3qmuvTdCCG+FZzG6m4dYnMf8HKENR2SdftOXoLOj9IUw5sMSr7gmeDvkcjIcKNhKAyk3PWQw6xhdqslYnRc6Sv4XLqvinQbAXZOFhQacFFX6aMvQ6kn/Nm7at6zcBjvgyZbJMzXiQdMb8nv3wQp8ZoPnr+Js9yJj+Q1my98G83cJ/YnnrJL1XeZBob+KTNczNrrkZvlUrzI4ahnMDfSymRn8o6MKT1qqOkEiZOc9u7LZyhVi+P3WLG8f1NVXYgamRi2fa6wHRoPqrC5HGM9RvuvjRl+OWZ9pNWzPDKSxbNc4UTrXO5U6dtb7FIzFlqklGBMwLq+l3uLPX6AiHTXFK6GM+Hpown/oz6wGOx4QA7cmvtI78UL0m22WJCEeKP0f/4H1nvjx2Lr6DuKHjJ5o32KMGEwPPhuQ9M9JIDsyFZxGAWLp7rvlY4W7Br6dzse9e3sn7pXyvmvTH3TcvYCb4fPX93yAfNTwlLv0tLSxSPTbt1ZUhrQeJQRXVxTHs2+b+fQ8gVRGuH4veyZZt+k9Q6G5Q6jSxZaRC5AQXpxavL13579SG7KsxLDECmmiK8d35QkMu4W6rV64KaWxYjlsEfpdZcNWXa6NFzHPrE1B7fuoccaU5f8bc2X2+WeWVtCOjunmDBytKScqd5gPv+vtUGhNrS0Div0utYGepCG/kq8IbmiT1qwWEUZvxUO7DwWZmK5sdFgddp/4CYIZu+G1Ye6QdsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006)(261102123227099003)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dnF6QTVpTHl5dEFDekM1Vkd2Mm1rM3ltMVM4RlFFVmVVNmNOb09VV0t4?=
 =?iso-2022-jp?B?WitmYk5TL0hCYTlXMFZXQzFGSWtHbUtQanFmT3p4YnVraU04cU9QakRj?=
 =?iso-2022-jp?B?aE1GdVRMNTZiNUxveUs2SzcyK05ZY2Exbk9VaFJlZS9icG1PcDBxRm55?=
 =?iso-2022-jp?B?bi9xNXNJVDN2Vy9aZDk5c2Z2dDRiMlNCY2VoakdiMSsxczZTRG55OGI1?=
 =?iso-2022-jp?B?dkFTK0M0VGtSM2YzQUJkMlEwNGtqYVc5b05TNTZhdmFoeTBLTlc5aStp?=
 =?iso-2022-jp?B?UWd1U0V5Ly9Qb2NKWlZLRmQ3aDFZNFA4T3creGNnQWFWaEtqQnFRd1di?=
 =?iso-2022-jp?B?aE8rSG9WK0ppS2tUK214QkVuYVR5ZUNlOXZmYUhSbnlaUXJKTlhrbit2?=
 =?iso-2022-jp?B?QnRjWEowbDRPOXBxN1dUWk8vT0NTV0FKM2RQQUxmMnpYVjhVWGpUTndu?=
 =?iso-2022-jp?B?WEU3amptZ0pDVisrR0JDeHVVeTcyd0ZUbkZLS20wTTl2emtLTkd4NE54?=
 =?iso-2022-jp?B?YVlWZWpJUXhGS1ptcHBrUUVzQWlHTno0Y0QzeUdUcTRDeW5UbU4rTHJv?=
 =?iso-2022-jp?B?MnpaOWg2TWl1MUZRMDcyektTUTJjKy9vMjRZR0cxZWFOaXlPMHZxa1Y1?=
 =?iso-2022-jp?B?T1B0bTg3eTIzbDBIckNOK1ZKUmlST1NnSnV6QmxFWFZhY0dHTVZHQ05p?=
 =?iso-2022-jp?B?cU41WG1BNlI0NDNQTW1hMHBhRTNEczRUd21TWDRIOVZ1TEh0bnNEUGM2?=
 =?iso-2022-jp?B?NDNrdkxKU25GQmpWWXdWVEtIZ1FqQjliaUh4QXh3V25vUHFlcUhpMEFO?=
 =?iso-2022-jp?B?dUI2TUZJbEhHT2lyejZ0dC9qcU94NmpTUnZDcWpveGZ3eWpEZmw4b1J2?=
 =?iso-2022-jp?B?cVpGRHNLbkMxSy81RFE1eVVMZVc0ajhzYkZTZWVzOWtRWHY0Ujk4VVQ4?=
 =?iso-2022-jp?B?US9reFgwb1Mwc3htY0Fqa05NN0RFbHBVTG84eGR5NGJsQ0tYUURheHhY?=
 =?iso-2022-jp?B?UTlxNVZSeDdqTVNsejFUSWptV1dyUUhhZmFHc1F5VmxLYlRaMjAxeXVy?=
 =?iso-2022-jp?B?VVpyVWFuYklpYlJGR01maCtpNVVzVE53VzBobS9JQVlWV1BjUDEvZkt4?=
 =?iso-2022-jp?B?WUxrSjZlQlIyTTVJNyt4MExMOE9GNTZpNWtZL2hLUWFEZ1pjYnp6aG5y?=
 =?iso-2022-jp?B?cmx1RnZxY3JZc0t5bzFyVlU1bm94S2VpZ0JIcGhKYnI5NFZXeGVmT3c3?=
 =?iso-2022-jp?B?YkZ1OFAycUh0dmhZUWpLeDc4WElwbFQvSXdTVTJtVmgyblg4cFVlUlFy?=
 =?iso-2022-jp?B?RUV0N0RmakpHS3A4Vyt5a0UxSWZTZzNXenZ0MVBSQVNjOEd4blJla05L?=
 =?iso-2022-jp?B?aHAzVTBTcStUK0JqaSsyMTlHbm5jaFV1UzZyR0FEQ3RrR0cwRUlMVEx4?=
 =?iso-2022-jp?B?UU9JVDZ0RitUV1V5bG8xU0FuNXM4dEI5MVVIT1AyMTRCVFZhaTJ1dDI4?=
 =?iso-2022-jp?B?cWxqU0Z0dk1lM09PaDUyT0dGTXQ3eDFDZnNwMUFvaEczVVFoblY0aWJH?=
 =?iso-2022-jp?B?SXRmWXJSTU5aYm9lM1drVnNVTWJSQ3dIeWpXNVdFT0dSeUxsTDY0NjFy?=
 =?iso-2022-jp?B?QkZ5ZDBTSmszYVFydGR4WWVTRGE0dXVMb0FKOVF4V0QvU2dVU2ZKZ0pJ?=
 =?iso-2022-jp?B?Q25VdW1lanBGak5xaDUzbjlGOUtkOFRaeTZuL0JDUlJvT3hCR01hS05l?=
 =?iso-2022-jp?B?dnZndVhwTFhTL25iWTlueUZDY0Z6V1pvU2pTY1kyU3c5UkxrWWVycnl5?=
 =?iso-2022-jp?B?WEVmQWZTNWpTMlhpZHFzZXpad08weU93aE4zcm5iVk9ac3EwTlFYZEY1?=
 =?iso-2022-jp?B?Tjh5ZXg3a0NzNHJBOEdGT25rTGI0dnVOdFBpYnIrNmdpbExYZzhFZlE3?=
 =?iso-2022-jp?B?MHlDdjdPcEdBV0p3cU0xT1RYVWtaakVTL3JsSzgvWmh6cllqWGg3V0tm?=
 =?iso-2022-jp?B?SjdrTXF4YkpqWDQ2QnRXdlcyZTRYbVo3YTd6cUMvYlpJQ0NxSldvM1k4?=
 =?iso-2022-jp?B?b2ljdFRiQzBObnc0NDhhZXJwb0lJRlhiSy9CdEVzaTNsOUNKQ3lNOUsw?=
 =?iso-2022-jp?B?VzlOYWMxYkRQejBNSm53b3BRdkhCZVNhUlpMVHlhQWNtL3dKUFcvY3Uv?=
 =?iso-2022-jp?B?WjMrd1I1Z3pVaVEvMVY1cVBZTE40d1JhdXF4WWtXMk9Ya0RkQlpkZ2M3?=
 =?iso-2022-jp?B?dkxmd3RUSHhreVByWnhmcFIwSm1xc0lqTTUrSy9wR21sZEQ5R0djT0h2?=
 =?iso-2022-jp?B?QnR6ZDhJd2Zsei91ZzBHU2NSR29pbThMOFArWTVpbW9idkVxcFVSZUxi?=
 =?iso-2022-jp?B?VGZvWHdRaFk1TWxhWmlxNkk2Wm9jN1VaQVhQbTBVaTByQ2lwRWpOYjJP?=
 =?iso-2022-jp?B?ZTE4SFd1bDJkWDF3YXNBd1l4OGx1MWhsS3NqU09ubE51Y3BIZTZiZzIw?=
 =?iso-2022-jp?B?a2FEbmdHSEpwMEQ2M09wQTAzQkxsV3Rzend4ZHB2L2ZpbDU4aUFtQlFk?=
 =?iso-2022-jp?B?Z3N4QlJSOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qtJNiXF1tyaTMgKl/Hv7SZES/bRcuaFEsIv5p2HaJqJZdx+ttvm5YYgc7fkR6kS6+W5ChHI+1VOw8P7aYr1naRA5Nax4MDZk6z8jWqoCjtjgbWkevGXa87bPcgI25nsZnAx+TBBgtXzKSPw1zy7Zhtbh4aUodS5oJaM2QPkrnYMfZhyACXwpGhBuvY+HrHtF398xX2Kt6+UY1mHo41COUAOjATaZWHZSp0mbS8u5uwm1iEarZt+9Rda8LTOSgiVEx/FACUw8V7uh+8ZD53k0YrDoWNUJAhkfSY/IgL/6pApCp1dyOyhS8voV4C+3hTp797SEspMKdykpCcQ9dIWhXA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf878b-e40c-41b2-2daf-08df41cce509
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 21:27:18.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ee6bSUX6RiwGcl1K6YJbNBREfiD/w6xtgsDMMncMSjaYe322wCAN1C6xzhzash66tmrDotq87Cn4vBmJ2KK7MF5KXWs7Obv0evH/2sw/9axJGCQ+flxNKZlFRfruvrJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 21:27:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24803

HI all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, November 13, 2026 5:32 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
> RZ/N2H SoCs
>=20
> Hi!
>=20
> > This series backports upstream display support for the Renesas RZ/T2H
> > and RZ/N2H SoCs to 6.12.y-cip. It adds support for the VSPD/FCPVD/DU
> > display pipeline and board overlays for HDMI output through an
> > external
> > ADV7513 transmitter on the corresponding evaluation kits.
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst,
> so they should not block the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, it seems to no issues.
I applied this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro

