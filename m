Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A5C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:05:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14109.1789365921135294123
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:05:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=k9r2Ws0V;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789365918;x=1790575518;bh=Q9KN0mAA6HjZghaa+nW7oHVc5cXwgjXBD8Dcf
	BqsM3E=;b=k9r2Ws0VOMmqCQPOLcsIZ2wJ0WgOoR1atf0WRbIN2V/wYidoFj7YAuJhpbyRHCgPMzi
	c6E6TuIfIJzICJLq4R8oETv1K9L5v0iIcjI9z2eGpELxwCP5aV+k47JssYxESb1dMQxsgemrEqAHB
	1Bp+1JsExCNXgmFrJFxRT7DjZ4zeBPzVvI44gIGBDZJv8egUYdIugQtctYhKNZUdpk8Qkx6NCmlXa
	xY4bB2F6XjwE7ZY8+DS+miMlycFQG/lq+6pVCr+B7ZjKbntbKISvho+bwJkZAx1BTNKTbi5k4iE8I
	EwBInjacjEJE9Q9ecET+22J33939pEsblhZDmaweUIOw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 68E65HAR2818397; Mon, 14 Sep 2026 15:05:18 +0900
X-Iguazu-Qid: 2rWg3sYdYNlp4YrBVS
X-Iguazu-QSIG: v=2; s=1; t=1789365917; q=2rWg3sYdYNlp4YrBVS; m=8fj+O+F0Vc5u7168rVkocAhC+SSPIVmnDktnEn4tthM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjvl06d91z4vyw; Mon, 14 Sep 2026 15:05:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntI2pH5E2WTY1vfz6SFc3Br0rgwgQDtmZU/EhN1cbCY9m3cfeXr+N6SGwYGkmFQn8MkJL7MqrESUmwDLKx6zzWJXuSYhjrVqUsDKQ/xYsqjPX8nwqVeCOqsbmuVX9/syYS8Qk96bK3eQDx+Sk40ScUWeVoT8/uJu9EtQVI2l8exA66Nux1EtdVU4oOAYpoHJpSwd66Jk3t5Lu9gPfp6Pdeq3GalcKyBQCkIthnBtnj1Y3ffq6KIxZxUy4epz+POVLG7MN3c4Di0p0SphMWA1sI8v2SHKRgURCKv+iX9XTqZwsy/hM52ZA4hThxn+Qw5QcoLTgyurcS/EuFEXRXl22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqLWNH3uAQbNerZ+xn1/z5Ieiqlye6qr/XUY1yxSQ2s=;
 b=F+iQO5oElEhUCa0mSZZK7sG9lnVhy/2mk7wq5raDCDzCZ1eRtXbjDqeYVIpbQ9XppWhSKd6vZMZweb8q87ya3kynwMz8G+fs3Uk+ICk9tnIwxJMlT8XU5jB4korXO08CA3w3PvMckUTNRqWtopTR5It8iDzhblmhsM19QjE/t5DBEL9qgNwKQh4L39SUymsv4Fwa2agyySv6dFEHzp6OXZIO0A8P4ZuSZAYPseFCG4tJr1ZSefA0xD172DAc9MAOZ3hEaC/dImxF54AoZ8jTbCoWTOn+jj5+Pv3Hq+onbNTp+C296dho2HnKgVFLbbjUzTtRW7reWkhRcuzaw/MeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi: Backport support
 for RZ/G2{E,N}
Thread-Topic: [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi: Backport support
 for RZ/G2{E,N}
Thread-Index: AQHdQfZDJob54k08uUeeN1lHrp5PpbbNmetw
Date: Mon, 14 Sep 2026 06:05:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F25644168ABE36216676CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140251.2119701-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20260911140251.2119701-1-claudiu.beznea@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB18284:EE_
x-ms-office365-filtering-correlation-id: 4d0eab2d-0125-4241-3f47-08df122624b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 UXu1opv5q9U4jKKoWxcwSX/fhj0pxarm8DRBjs5FrxYYmWpUgQBXkYxJqR2RWmxu9hjhYsDheu8JjpRkPDHbqoZLPqNU/IDWN/zUceGv/3muglYiscI/ns0SQp4W1gueQF2eb0ceo//cncnnE8MENb9OUKKgltTh5u+ipHVSkIZwiWuy1x/AuXHhNdjbo/etoOiBC0wcElBQYV17ujhF0neSDBpgh9LJrXYdVS6tNk+lmH9ExEQWBoHcqwBQRRGlD3EZRKxWpkMHBV/pWfG32y4HR18BZJME3/Z0/8W9zZtqMz1ROfcetTfSvg3DuCNYxVoruJUwUwvZVeY8bHRa9AATqGrPlhs4e/owbfvywR8pJVU9XjN+gcPaNatMaIOBkBYEmrU0nJaeGroCE/NM+BKaOeDuNkvKYMtuuaSN30YjLXBtBWONMNADcTy/uM+GYjg9kcd9L/7amKyNtYsLBzgWex8CQ2WFtFQ0JPRmK1S3LyVSUuaYBNYIp5XNl3sInAVXKPfMXampp+I0CsKOv8DNOeUHkXijpuoD0iEKXBy1uJn7zV/6KkhfpAbX96ISStrve6eRJOxFeh50L+YuMFlDjeaUmg4RjWXbAa4gJtOtyaaWnMANGa9LjJA/UjejOshcGfQQSgxg/BncIEU+C/W9Co2efNzhmyiYmnsfKNHWZnDYFlIf9iZIEYROiS4M1jVIiZEo5arme776yY9Ii4AaVshe/0YaNnhz7eJZbNs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WnZyTXJHbDlaRG9tTG5YbzE5UVd0SmpNdm9XclhkTko4NjRGMkNBUHp5?=
 =?iso-2022-jp?B?aS9wOWFjVFpyOUhBREZEalNmK3orbGYwem15M2hvWUZ3d3k0Wi9FS28z?=
 =?iso-2022-jp?B?bFIxeDgrK3pLTk9vcmZzVUlVV2pKdi9XZXlCTDREUkVjL0dDSjF4THVZ?=
 =?iso-2022-jp?B?UDY2dWpoVzQrN2JmRFZhMjR5bk9kSWdDUWJhN0l4YUdSdEhZbHFlcjZ1?=
 =?iso-2022-jp?B?S0x1TG9KbnloZXBrUjhXVy9vUWVzK0trVElxSk9VTUpjUWV1OVN3RGp2?=
 =?iso-2022-jp?B?UkwwbzQ2SDRyYXFKK3djM3dtUk84aW96TXcrK0RoSlIxQnFvMUQ3RndV?=
 =?iso-2022-jp?B?eUJGdXhYVEpWQ3ZWeXlKTGhKaE9OZUpyalhYUDREcVRFdzdFbnQybHVj?=
 =?iso-2022-jp?B?VlJESnE2V2d6ekh3NGRFeW9Ia1RQOUQ5UURUc2M1bmFvcDZVNGVCTDRD?=
 =?iso-2022-jp?B?NzFjVi9lM01CYWYweFkrcjhGUEJETk5FWFhNdHJmUDlvd3UzU0MzNDFx?=
 =?iso-2022-jp?B?c2pTaUpkYzlJUDZicVdqNGpnM29uSlNjOGtuUGsyakplb0lSN1JEdzIw?=
 =?iso-2022-jp?B?VGtodjJ4M1hoV1BKb1E1YzE1RzlRNXJJZnhJcWdiSHgrb0pxQm1tRnVO?=
 =?iso-2022-jp?B?NjI4cXl5Ymdvc09kQUF0dkFDZ21nemV5Tmg4MXUvc0Y5dDdkNXZGYVlz?=
 =?iso-2022-jp?B?T0QxN1JZajU4dDBhU3BIWlV2am9VbDhzZnNrNVIyRnBzdmtXWDlqUXFD?=
 =?iso-2022-jp?B?VUJDV2I0Q1dUUys1N1pFK0l2OHMxenF2LzZDbkwvRGkyMTBtci9NTUtQ?=
 =?iso-2022-jp?B?R1FSQmYxNnNWVU9jZld5MG8zQjdqU041bm1ORU1hcEtPamNWaWxyaWhn?=
 =?iso-2022-jp?B?cGRKNXFxQ04wS3JDdlIwaWZVUmc0VDNlVXF1OHRFSDYxSmlBRVBlVjdL?=
 =?iso-2022-jp?B?Y0tKbk80REVVa0FmQ2NJSzNidUw4eUpKeU5Lbi8ybXhLSkNhYVdBRStC?=
 =?iso-2022-jp?B?Q3dWKzdTeFpCYzVGcWFNOGNMOUJ4eTkyOUJ2VkU2NVl0dUQ0VkZ1Yzc4?=
 =?iso-2022-jp?B?Q2Q3Y3ZRU1VsMzJKOTJFU214MGk2NmcwY3VTT1BCR0Q1UUJaTkd2L2tK?=
 =?iso-2022-jp?B?cStRTk1CRUhWUkVSSWtldzRhNFFIY0RZeUpqRWRjVTdNNDBCc0ZoSDh3?=
 =?iso-2022-jp?B?b3FQVjJ4TU5lc3owZ2xXQ05RSnU1OHk0cEJpUlNTYW50a2hjOTVGVVNI?=
 =?iso-2022-jp?B?eC94ajBUMWNITlJrdjFtUmZUUDczUUtoN0F5NElPcVFGbi9OUldsS0VT?=
 =?iso-2022-jp?B?QlFFUTJkQVRhWFFYNlZRUEpBdDdqRVR2RXdHZjVpbWdaZ2JnWlVOdjFk?=
 =?iso-2022-jp?B?cG11bnZlNi9aSkFENCtjbk1iSnBIamYzOFNNUWhuYmdVM2dqclJSbVFx?=
 =?iso-2022-jp?B?NVVVT0JDTDhjajBSamFzWmY5Q2hUNCtPRXhCeWo5Tm1zcFU1MFJqeld3?=
 =?iso-2022-jp?B?SFkyQUJoRHBZT2puTjVEaVBncnM0WWFFVU9YSU5aQlduVW1lZndZT2tQ?=
 =?iso-2022-jp?B?L1p6MnRFMFlxa3M4bm9hVkhzcEVKWlphYzlZaTYxZjdkWVlXRTd3cEFu?=
 =?iso-2022-jp?B?L2IvT2dvWWJ4QWZPKytROGRhTHVvd0FNZ2x1Uk5wN2M5akN3WVZ4emk3?=
 =?iso-2022-jp?B?cEJQb2IvNnFLNTRzRVYzc28xVjBGdTBkaFQza3BuNHRLeEptUkZpKy9K?=
 =?iso-2022-jp?B?MUtlaS91ck4xTFJKN0x5bmVPdVR5Rk9EN3l3Z00yWTNWdzNWV2ZlalZV?=
 =?iso-2022-jp?B?azduM1Aya1NYWFVBVHZ0Y2Zmcm5tMWFvYlIvdTQyOGIxVHZvSmdTZFZR?=
 =?iso-2022-jp?B?amJNbXNMeXNWWC83cjgxalVrTk4wTlVxZUk3ZkFHKytiNk16QXMybThW?=
 =?iso-2022-jp?B?UFAxNStzSURXbXY4L1NJK1FidFlpS1dmb25jS2xJWHAzS3hhRlFLbVpU?=
 =?iso-2022-jp?B?dEhJbUJTYjdTdUt6YmdFR2lZZVE3R0ZnN2xqRHNxclhjRFl0Y0lhVW42?=
 =?iso-2022-jp?B?QmpYV1RpeG15Rkl3aytQM0VYcmdYZE5aN3M3RXQrcEVsS2NDWXJRd2NW?=
 =?iso-2022-jp?B?ZDlncDVBeldjK01BNkFHUy9kaG1CM2Q0YXpKVXJRb2RtZGVsYi9HSGJ2?=
 =?iso-2022-jp?B?QUNrNTcvU0h6YWpCUzNFVWIxbnB5SjhuRW96REMyalJ1WmcyTDU0a2xK?=
 =?iso-2022-jp?B?cjRiVmgxT3cwZC96bmhrdnFKNUxEUEtUVmtiMXVnVXVWSEhtUldUZ3Jn?=
 =?iso-2022-jp?B?S0lUcDNPUjZmRkJGZHJObElFb2xZYktCTUJNK0YzZFFJRVd3cEM4ckhG?=
 =?iso-2022-jp?B?em11SnpsU2t2L1BQeG5OdkdGTWQ0SkcvMER2blJBU20zOGt5WlNPR1pK?=
 =?iso-2022-jp?B?OGFjT3haWHBtQllkRGpCU283OXJKV3RXdWVRQ0srZnZ2eWRnbUk1MjM3?=
 =?iso-2022-jp?B?OWpoWGpLQ2Q0cjBPREhZcVZjaVNnclVUWk9UcWVmemw2Qm1QU1FiNmtQ?=
 =?iso-2022-jp?B?RE9QTmVyMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	lkZeJHpT8JhxLCD695kHb6MuZY+EmylnWiyvM6rLUa1Jieqg+Z21lAC/pht2Y8r2LKlUHnY9J99BJ5fK5f9q1N2UWZB/zfVWkB81ACAsV5fVypM/lT/65zdLUiaZLjmKUkupKLpFTdSEla/Jk5L19m/yYLlN48+BEOdXk5XAYHLFjID0ttOZbifZPuNkRt1sZeBqNHJ1qdVjZse8jNe6MSRTfxbWByLA8BpDmMBGuT7nWj1e5Mc6t1QamLCb/qLKz6Rlzdcdhso/lQuEIwqO510iUowLfri7kzHHkBlSPiDqTu2Pg0XVd3QbGpfNZiKwbzbYv2aTCX6h9v8a4Frg1Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0eab2d-0125-4241-3f47-08df122624b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:05:14.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK4qChfh3ccxyyvmQ/FFLHIrRyxGad1W11R8Sb/+wof0zEHbAhKVncfYd4s8VmuSklW+KCAscudrbBWNWQBFlzE2V3OVLb1Eqo/RFHraJ7uilu7nLTHdPIHEefpdKmPr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18284
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:05:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24165

Hi all,

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Sent: Friday, September 11, 2026 11:03 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi: Backport support =
for
> RZ/G2{E,N}
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backport patches to enable SDHI for RZ/G2{E,N} though their own
> compatibles.
>=20
> Thank you,
> Claudiu
>=20
> Lad Prabhakar (2):
>   mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
>   mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
>=20
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284=
5749371

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


