Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.375.1794607686584039780
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 14:08:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=g9bIQ485;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794607682;x=1795817282;bh=IqLmXTB5IVWNHwseXQND3pg+IA5HUX4lGao+h
	oB81EQ=;b=g9bIQ485319H8zNbccYefT0Rcx6F9M6ojhjr6hhndaOs5supQlzLII+8p/s7+eafegX
	8pyvJZ1V1z8UPmexw9NyvX1w/9V7s0K+dsXMDZJakp3UW72/MGKs9jylPCP62sOVWBFkqSFhqtBd3
	FhUAoaOr10uh1BzwZQ4D+OG7G2WsWGfxGvu+/vmyKvKEIee/6BVOgUfz5hEJwI5+h7JuvpBDTMdDU
	yhvXbSOcq8Rx/DJ4MkKrP0S2CSYnkan0DosOdLi/nzsoqWmnVAtdo6uYnu1T9GcHKlmn+Rhp9ZMOg
	/ZkZ0iRqRmEy5i594959FXsj8uFw8tzJQd2YRZg7Arpg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6ADM81s71373268; Sat, 14 Nov 2026 07:08:01 +0900
X-Iguazu-Qid: 2rWhTexGsS7vxxiqtk
X-Iguazu-QSIG: v=2; s=1; t=1794607681; q=2rWhTexGsS7vxxiqtk; m=CuGlUfrB9/AXH6hoZtWeWtH6br0TtOddDgkcqqUD2gY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jRBG900hVz4vym; Sat, 14 Nov 2026 07:08:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGrT20z31ZvO9cKm+hzcmxBfdgeixUirv6HHfRkdg4y89+O+OZpR39jx0oytBg36JJs2vWQcHZeq47hpWb526u/RfHKLqp39p0Y97K0nn1XdEvw7ca3BpYSCfSsB7xypsDmCbrWcX2MPIGyrh3cHQewei0YG5oBtNqslofKQ8jGfBbf1M/lhnAxAavWKtmR3nZu+EMd2wV13vmvW6NpNamdXix2ZzPoE2t8kIfm6GL9ZROzgKVXvEKFk2I0kZgbBoV3MWRSpb7O4QUSFZCn2PxQwNUPk76RuDi4QeV8x2yye8qi1b8v6fv6Fm1jF9X/SsMFpiBrKUxTqzlbjPcCTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83qzzW87WcrkowMXOOjBVARNzI5oTZu2Z56vwsPM1VE=;
 b=NO+E4uwh8OFwXUbrJaPBAX9l8ckhaSR5YkYmHZiGlxQ5vpmj+8HOo4NpDAMb0PJTiT5+j/inRjNF+LEDAaLeiP4J22UlZTYT3Z7SB79FRRCqr4bRjbNbf2lAfxHa7Jj1ausXYRcb24bBl7JRbJjTrrH452Axe2dHA+xghWdk4jgfNnSTUpwEMhYbqwQpvVqqhgiffxiNAyBFFrxppZ1gSbCHIw2vtYq2ixmUC4aXvoLvsJ0Pyy5qXM9Bso0wiVboxORJkk+LmUWKawQ6osu5dYhcLdViW7IXZIVYqQ4hMD5aQfl3GcSkrfWgjuHJR7/mCoDtvV94TGT0OPDa1WBbJQ==
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
Thread-Index: AQHdcEP1MnrqEchTTESqm36f/PU88LcrslSAgADYBgCAAAE8oIAACcFw
Date: Fri, 13 Nov 2026 22:07:58 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818FA6E5331103730D5CF5ACD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avbK92i8jrUrGjan@duo.ucw.cz>
 <TY7PR01MB14818B045362B469FE775E88DCD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY7PR01MB148185341D3FC9F27DD489608CD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: <TY7PR01MB148185341D3FC9F27DD489608CD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB8542:EE_
x-ms-office365-filtering-correlation-id: 1bc4cb34-4899-49cb-18f5-08df41d2937b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|261102123227099003|10067099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: +I/M/hX9olmUUo9bJNrNHj/Lztc3jSngvEyX9rdxW6TyP2rMofq7/I4fuNzBdns1eoJb5a4Tt3kq/bsAaSWPN84kY6eBqLG7emnVroOS2a3WdZoBfaG6ikKxhCTzRVpCgIyVPQJRvmQN6PD4bbW9rIJhLS3FdTG0MhaDdCXwo/KCeLJmaqjt/lqJa54K0IijWPLCPUiDngmfIj64QzJUw5IFGGE5cSrh/tWcZbmbUO3pga9tw2w4m7TESDgTuouoiR7gDsTR2iJIZZn3aMiYVCYkYjPpWUIT1bfCdrN4RMF3hkZbkgylYjbgqt+SQ+c2ELbk6WYMmalFkdlvzeFZZt88hm9HofQLec6H4Ob8kBYKr3vBFbWoup9vJTUJmfnyuLvRTPzrJEcqAY/0rb1nWn2c51TL8d5emjJE/R7W6Nh5bJnqax8Dff1tBcsGv9KqtUwIPv21qqSC9rn+MWL5itVL5QhHUvUYgVbOdGS7rvT+Y+oRXmCgrsdU1whSbX2uKBV/YHo4vzXkbj61qTTBhbl/7i8S2tjL9mgQHE0qAMunh859HIZM+ilNKD5yNZzWY7xADRGeQv/zyz1BCpfKZmJsA+vHDx2VY9EE+UWWFvj1osvfxoc8sQ50Y8vAPbKXBlbHVTWGh8iOylBpuRDjGn2p3vtbIi62ONZ/fg/aMmhpQaHAyx0oUjrzsDgBTqBfCL9YIwt/6dShBT6d6ckNfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(261102123227099003)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Si9DWU9QUS9JYlNjN0I5SE9BNzhra0d5OVM4WFNYQVJYVTBjTFMxZUdw?=
 =?iso-2022-jp?B?Z0xWSy9XREsybk9ZL3cwVmkycVcwQyswSmlrSkowSkcwUXRBY2lWN2tl?=
 =?iso-2022-jp?B?OW9DdTZSZmcwT3hXdmlZU25wRXNad0FtZEtnNjVMVkVIZlFXQnJCQXNi?=
 =?iso-2022-jp?B?bENOeENvNnFJRjh4Wm1mQUdDYlpJcnBOTlRZUUJ4eHZyZ0pUYW9WeUlF?=
 =?iso-2022-jp?B?UXpMREgyMHV4bFZIYzBqeHk4OXIydmF4RnM5dW9zbXp4V2RnYnphMEkz?=
 =?iso-2022-jp?B?S0NPUXlkejNzNkZ3U29BdFdmTGhlckJXaEpHTXFVZnlwUlJUNHErdmFM?=
 =?iso-2022-jp?B?aVZPamttQTBEQjZKTmdBMk1DQ1dBNDRsYWhGODVxRGw1dm0wVGM2SWQw?=
 =?iso-2022-jp?B?cXpEQktublNxMGlCYTIvbkhoRmtvdGtJcFQycG5oR0YycVU3SkpzYk93?=
 =?iso-2022-jp?B?M0lpY24rYlN5N3RvajdSZHlyWVg1R2s3TlB4YXJiYWkvRms5MWJoWEJ4?=
 =?iso-2022-jp?B?VWNHSjJaVUJZWDNWbFR1UjJ5VkdEeFBmVlp1WVdlUGtLcUNFQXQrV0M4?=
 =?iso-2022-jp?B?Nk1XQXhwaHp0bmdaUmVwVGxORnZNRUVZYkdzeUd1aGlkVHBRSUFaeGpM?=
 =?iso-2022-jp?B?N3VqOGtRRVl2WkJBWHpYQzBiVVpFbStVamR2YmxXNDlzSDBCZS9BTEFt?=
 =?iso-2022-jp?B?enNkdUpjNHU3MXJuNHBDOWFQYXoyb2ZHTElvWFdkQmpoZTZkVk1YaDBz?=
 =?iso-2022-jp?B?M3V4NU15TmZBZlNHR2lRUlBHM2x5dkRtTnhJZ0s3U1ltcWdkWWZlM051?=
 =?iso-2022-jp?B?TlMwMS9hczdPdVhvU1pSV2VhSElNcDNjY2RGOFYrMnFTbWFoUWE4TlB3?=
 =?iso-2022-jp?B?VEZyWHRKSk81YVl1Q3Y1RCtWM1lEMTd6d0oyVThQVXdTcWRNSzJrYkt2?=
 =?iso-2022-jp?B?YStCMkJENndnWEVJV1dpMHVTTU8zQ2k1Um9lV255dnFHeTdRcUswT0lH?=
 =?iso-2022-jp?B?S2hLUUQ1Ty9aaTNQemVINGdTWjB0ODVLRTBmMFZuV0V0OXkzYi9UTmky?=
 =?iso-2022-jp?B?NEdIVmhLcHRZdGVrYXJRM0YxdUlRZk5Fb1NHYW1sUHI1ZWpHWE1TUytZ?=
 =?iso-2022-jp?B?YjV1d3dycUxOUm5rK2FPWjFhRzZyRUhRb1ZrM09tdk11NXRGN0ZKaHJz?=
 =?iso-2022-jp?B?eFZJV2JjZXNVazBwVi8xWmJ6cmpGYVFwMVpia2FaZWtEU2FGVUJORS9h?=
 =?iso-2022-jp?B?aVJuejkyRUREbXdaa2pMaUVRcnc3U1BBV3RwbmdvcDhOMkIvMkttWXZE?=
 =?iso-2022-jp?B?Y1JkS0pxaFhubU52S0Ewd2NKNVZPazVkbE5tUkpwRUlacmZGV0xoSm94?=
 =?iso-2022-jp?B?V2FsYzlEUHFYb2I0TDgvSFFqb0pvMWFtNTBodWVWSHhINlQzVld5L1dp?=
 =?iso-2022-jp?B?T1lhdm5NYXgyNEhqdzdQaGhmRUx2RDhLZ1VKUGpRSkJuYTJZSWQ3UHll?=
 =?iso-2022-jp?B?UVVjdEw0WlRNN3ZNUng2VkZvQ05XVHdhN2ZFcWVWUWRiOWJHcER3L0tz?=
 =?iso-2022-jp?B?NE5TMUVIR25wQ0tGZlVaeXhDUlpqTmR6TVhtc3gwSlc1dWQ0Tk84MDcr?=
 =?iso-2022-jp?B?TFNsVUszd3dkZHdhdFdQK3p4emJzbExMRHhPcWJPQVU4NTdvRGdSbURL?=
 =?iso-2022-jp?B?VGZxazkxR1Y1djhMYVIzcEVlSWt3SjRjOVBQOEtib3Q3OU5YNFZIejVV?=
 =?iso-2022-jp?B?MnBzWkZYLzNFT3JTRmd4cFJFV0dZM3R5eTZzQ0pldjZxb2RJSStvOVIr?=
 =?iso-2022-jp?B?QnptS3FveTdLV05acUtVVS9nb25WL29WTEpLSzAyR1ZSdHI3NGxXbitD?=
 =?iso-2022-jp?B?WjRxZHNUR3RZWStUaUNoZ21tN2tKMGt0MkU3NDZjTHlQNW1ONGpKbnFP?=
 =?iso-2022-jp?B?aXJEbllhSW5paTdOSzdraHVaUituZHQzSTJYU2NNdk9iV2RaQzVLU2Jn?=
 =?iso-2022-jp?B?bTIrZzlaVVVsdnZiZmlyeStkbDJpbkx6NTZTemRKTnhWeTBXVy80MkVH?=
 =?iso-2022-jp?B?d25HRDI3Z2N1c2thYkU3eGQvVkUzT0pVSERjS2ZZMk93aFRLdFdrN2RQ?=
 =?iso-2022-jp?B?NFFrT1NBdXovSURZbXk2bWtXRDEvbDVSTFRCOTg4K2ZiQnFDWWZQTDVu?=
 =?iso-2022-jp?B?b1F1ZUtTM29VVFFVWU1RVjlqMzR5cHF5NW5OSUJBNVIrUERoMDQ0Rjdh?=
 =?iso-2022-jp?B?UHlCV0lTSU9Ya0NIOGpudzZyUldrOWMveEZKb2VpMy9IT2hKNWJsVjVE?=
 =?iso-2022-jp?B?a0JSRjhwMU9XN2NNdk5jMG1tWEJqVUVaNi9VRlBkN3RGUTlhQnV3R1dH?=
 =?iso-2022-jp?B?aGFaTkdveVNtSXB0YjMydjNxY040V09VZGtuM3ZCckxaZGllS3BOaUZZ?=
 =?iso-2022-jp?B?WXMyRDQ2eU1NVG0yUEF4UmdZUjB6TUhTWDd5STJISmg0NTdsMzBmYzht?=
 =?iso-2022-jp?B?NFZQd0pWSjkrdGkxVnoxY25ORC9oa3BQeWcyeE1hOHY1cDZ4Rmlkc2dK?=
 =?iso-2022-jp?B?OVZxaEFDZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s/rnuLJ/IAmfPHWKac32DTBk9DmjplvMhL7panmdZVYNBnZZVjZFqH6WH961/v/mKPrF1U6gs7fRiOKC3NV4/Bjhz5rc/Vsjp6sD1E2rQAKjQTJ4KAKnfdeETlptHzEX/mzgawzO0omio1ZsOUJpgplPzsdYEvBmzu5HusIrZ4xcrYsPUdFGp5kaBjYX5IINnIYQABZDa4j8FwrzoovdzoHuTz6iKscnAkT/lVG5Duqiew4f0hLiz4SiwaA9C1bls4W/qSNamZQN01LY0f/+wvoBU4XCzdu7LqZ0fphTZN5qmIXz73SsF6mTZLQnQPcAemeaVJBwQ8EW+P8luJTK0Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc4cb34-4899-49cb-18f5-08df41d2937b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 22:07:58.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5EHwlN3SxYSTwSy3TpSe/1Zp6GaWFpGrtNNR3OxlHYYMWRjMiEPHFK4jx8CZA2L39xSdjB2LAqdAtZ+4WC52SefAcc2cYhak1NnqDe0UqCzX3YQmiJoUQIIqgc9Co4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8542
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 22:08:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24805

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Saturday, November 14, 2026 6:33 AM
> To: 'Pavel Machek' <pavel@nabladev.com>; 'Lad Prabhakar'
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: 'cip-dev@lists.cip-project.org' <cip-dev@lists.cip-project.org>; 'Bij=
u Das'
> <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
> RZ/N2H SoCs
>=20

[...]

>=20
> > >
> > > Hi!
> > >
> > > > This series backports upstream display support for the Renesas
> > > > RZ/T2H and RZ/N2H SoCs to 6.12.y-cip. It adds support for the
> > > > VSPD/FCPVD/DU display pipeline and board overlays for HDMI output
> > > > through an external
> > > > ADV7513 transmitter on the corresponding evaluation kits.
> > >
> > > I had some minor comments here, but those should be fixed in
> > > mainline, first, so they should not block the merge.
> > >
> > > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> > >
> > > I can apply the series if it passes testing and there are no other co=
mments.
> > >
> >
> > I reviewed this series, it seems to no issues.
> > I applied this series with Pavel's reviewed-by tag.
>=20
> I will wait for a version of the series to be posted from which the follo=
wing patch
> has been dropped.
> [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for clk_divider_be=
stdiv()
> ULONG_MAX handling
>=20

# I was not receiving all of my emails due to an MS O365 issue....

I applied this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro

