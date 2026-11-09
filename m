Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9438.1794191234667383787
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 18:27:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=nFx8xnVS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794191230;x=1795400830;bh=1UTyrwsGdhzf/vW1AA76AEYs0wvfyJY3lnI3Q
	Qh2Q+0=;b=nFx8xnVSNbtltZEJiGhRtJGVcerFqxcowrcNL+G/LinspK4QaG2HJkBwH21a/ELCDKK
	ROz+zAIYnwkg1YtjdcIicpv7RmnzKLkQrOqXtMIx8RkNlgJBK7+ke1e2H8hz0I0RPXBS8sG5Hbwib
	//iNdotLBx7eU6p6yndfF15D433GBkwtZIgcRZZVw+HwzVurqAcXqEgSyzEJIMsFbew2ZMg4olAKc
	I3i09rXb/CDZfmxa7A3pszRbVhcZXwntjsIbIqklYG/XhrOUliITpIsbH5Z1B+i5gf3oXpA7gRHt+
	KYAQ7+kK3mnPz9USRgktFACsXNlwuHHa8XD/lZxuMm+g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6A92R9u31698205; Mon, 9 Nov 2026 11:27:10 +0900
X-Iguazu-Qid: 2yAakicNrKLvYCnX3E
X-Iguazu-QSIG: v=2; s=1; t=1794191229; q=2yAakicNrKLvYCnX3E; m=/2Did0Nmq/JHnYCQ0EFKOdDv2lajOk5NveSklQOMnwg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNDFT0LnhzyPQ; Mon,  9 Nov 2026 11:27:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSXrbBF06554BQPyZQZ0lpeU5JsmCjRURHXiAqVnqZkTLTzjIVE6cThYgfQFgK+nwl2PvZwzjF9Ue3t7cbQJZEbm6xt20V+XYf/MTHyby9UdPe3E4omdrE9sdSxDb1qotoVJpVMPiFrS/65lAVvEQ1CgMBQLFia6vo+FYhYM/oK//PGRcBIcS7kf2EiPCx59r3StpocA2u+UDPySxFk3JbLFex/yeJRsYweq4xPLZE2Oox6hY0Xf4fukd+MHLQriY4/O3p4HvJoH5+fF1xlY6K9MhbEhSGTxUOloAXneACzbWSAMHR8IVtmoSXwiqqKUeCi/FlhSPtFA3CiFeA26xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSLG/zMfwrARIhJqRVffzl0Ory/JzZyEUx2q2eMC5zA=;
 b=F9BJhwTGUtLWu7noB8BtXLk7aFrYT4526X0cEgzLKB7hjSWV8i0rY+/W0hoD1jkyanlsZxKDu8VUkg32cwMXE5EbpJjLZS3puBBr6EdJAczwZUPXjO+ydRKGp8Urko8d68NPuZde+/GcgXbjCJ7TH9jT42FqGjotgA0MSNVibPeADPqHxhEoN/vnVSKsULeZi/A/LW47m57n4g09EqrOJMU1QiWcGBnoKfW3tKnxkDQCqN9X5HMrFEpP61JK+yGO1Zlf28J5VaUH4NDxp3G/nNvV74t4EiM2zg2K0LjM7Cva2SVdX1tjUKIpzkyNvrc7FiUznpn/nfCJkLlytr8y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/7] Add PCIe support to Renesas
 RZ/V2H(P) SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/7] Add PCIe support to Renesas
 RZ/V2H(P) SoC
Thread-Index: AQHdaspqfIfOsAOduUq5/UEaztlG47cfqtCAgAViEOA=
Date: Mon, 9 Nov 2026 02:27:06 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481840F87BBE8C2230AFACFACD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <auyqf5fY_t_IPxiJ@duo.ucw.cz>
In-Reply-To: <auyqf5fY_t_IPxiJ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB15460:EE_
x-ms-office365-filtering-correlation-id: da1059b9-79b4-4297-d5ed-08df3e08f2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 31fdbrM8QQ4CFRJ8BPMZL1rRnLDwqI85jUq0X97oj7br1hblMvmLeapOAJUyRr0YQPrS23uGshJBOthBd3rwXzZKHuSK1j/Eh7+gweIyEOSiq9Q4tqoxjcLhHt41NYw5cbUfuOcBw9cA9etKGZ8ey4m3f3OZMG64jjSoj6fvsPVwIzz3K+mWeFOVfv28B3MeCjBaA21g4FhQc2izc28KqlZCls9fDw5t/v0Y+K1nNwO4EUUF3fNMjdsjnuMoebzyfmwQvPrMBxTLqdwblZNERHEQL7eDSozGbpAKX1F7kTnFzZ0rUYgCvT6EDJhIjKOnHe46Km+7PjhWiS2c5dcoW10ePEKn9m/inUTkO8nE8Zt8G64GBRcXPQaHmH6/t5AchWKn6A9MeJS9iT8DtyDNIV2nPktoXD90vewCLKWyq913oQY+Y+FC1mXTSaDhOZCEhZ8i2UWAhsGsJ/mK+IU0vlvB4CjAMCoD2hcawRuwzZZmSvED9YU3/dP2ysWDalLPcGEWxOHcJZYcHw48HtcHMukBUd0shfAB+Rn6KA3LtebJC+5qu1j9ucGc8r/bVC5Mq4Bn9EzIzyLZ1bms+M04XjtavuYDJMkMUPlN/zA/uW7zyzjUNpCAlME3N8HUXEB9dCZ+t3lnZVCz31dszOhsdfGPox9Dvz90LVhOwHjHZKPmuhQy0U22RerA63kY4Y8Gunw3aiAKjayzwETWuWE8NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VytrSEVabGZweTNrMUNnU1MyckpPeHQ4V3krYW4rd1NKSXRNSWFlSjNL?=
 =?iso-2022-jp?B?VjY1MVE3SC9JVTJrWTVoZXhUK2x4bFJjaWRpK2dFczM0WVIwZzdXdGRB?=
 =?iso-2022-jp?B?VldOMC9aOG9nTFoyclhqZ1VPemRVTHBZTHJIbFVzZ25qc2lUM2JIU3NU?=
 =?iso-2022-jp?B?UGUzSGtKUFgrZ2FSSzBVdDNHblZZaHd0N3h6NmxIaUgxOXA1VFNmT3JX?=
 =?iso-2022-jp?B?Y0hxY3NFOGM5MHBRWkNQQXdPU21jLzdWb1V3Z3RlWlkxbWlMc1BpSjVG?=
 =?iso-2022-jp?B?Y3djME5aUnBtSFNkVmJYOHFsQ3hiMGRoWm1UbGMwYWdENmxRSy9GWG1X?=
 =?iso-2022-jp?B?UzlFR0VBY2cwY3ZVY1lBaGF3TTZzV016enpNUFJjVnM5TlQxRjZLS0Iv?=
 =?iso-2022-jp?B?S2hoTVBHRjRBUEJmVnp2RW1FUGdLVkVFd1p0NmNoRGd2QjBad0xpQUtD?=
 =?iso-2022-jp?B?UmlsMDRlOEx5VUphVzE2TEdqOU8yclNkZDBuZldYOGx3a1prMzhzclA1?=
 =?iso-2022-jp?B?WWdQaGxhdEVEQ3B0OU1uOElQL2lzYXJKeXI1Uk10dEgrOWE0cDhJbGwz?=
 =?iso-2022-jp?B?YWt5V00rK084UDBaSXhhd0xucUtDeHg3VHdSUmZuU2szckpVbzNLT2tZ?=
 =?iso-2022-jp?B?clRYSGZkamNFdEE4aUM5dVp4L1AvZU84KzJ6S2VURS9rdytmK2lxYVRm?=
 =?iso-2022-jp?B?OWxOdkJxc1dKMGxtQ2tqa3p2M0pPRFVzbEZVWWNZS2JGaEYxbXdNU1dH?=
 =?iso-2022-jp?B?dVYwVHgzV0s0QW90VmtxSnR2Ti9FaS9jcCs1NDM3YWhUSHJOVWdyOHBX?=
 =?iso-2022-jp?B?anNGeFhaWExEdXVrWm1Hc3A1dGF3UTdCYkg3VytrVFA0ZEIwRktrcTF4?=
 =?iso-2022-jp?B?VmlESFJIUWdWVlNKRWY5OU9IbHdMemZ4Z1BKUXNtK1dWZDBVUjZDdysy?=
 =?iso-2022-jp?B?Tk5lOU5XQ0t2cjIxZ3IrK0ZUY2pjRGlsRFVkZXlOREV3bmJBMVA3Rk1x?=
 =?iso-2022-jp?B?Z1VFL0EwQjlqT1Raa0ZpUUpTVmhTeUMzWU5zcmtod0M4UkEzMGxPT0g4?=
 =?iso-2022-jp?B?UWExMkxURzdNNG9ldC9hbmh1aHF3amtreEdSV2hTMWYzV3JNZTllS01F?=
 =?iso-2022-jp?B?ZTVBLzRnSno4K3RvK3JCcy9FV1JYdTdENS83OUV0RzZCQWJ5Y1V6bldo?=
 =?iso-2022-jp?B?TzFMa2JoUU44Z0tlNHFxbWlvb1lzZWdMem50UThWckIzTlhTVm1WaFQr?=
 =?iso-2022-jp?B?VGY1M08xRi9pOWdBTUtBQTZTUVpNMGYrRC9wb0crQlZkRHlka1h1eHV5?=
 =?iso-2022-jp?B?RGtnRnowaDFUSC93eFNwMXllSHFiSDFDNTcrZkVLaHhaTTBZWE1zYi9G?=
 =?iso-2022-jp?B?aUo5VnNSUkZFNGxMejl6MTVGY0hybDB1aUhlSk11R1R4RGs3ZWlJRUxl?=
 =?iso-2022-jp?B?T0NuemViRWVqUHNaekRwYVMzNE8rY0ZSSHpOc1RXTWhwbjdaOTdXR1E1?=
 =?iso-2022-jp?B?SW81NEFZQmhXeEUza0NSaGdkeHo1QS9ZR0xBejg1bElpcS8wLzhSL2h4?=
 =?iso-2022-jp?B?Rmc4ZVhlK3VKTVBjVDkzZXZ6M1BwL04rSVZ5Wmo3YUpJZU9KOWIzZmNv?=
 =?iso-2022-jp?B?aUhCZTczWHNZV09JSlhtUHVqK2dSWEVWQnlNM3ZaRzhzZDN2K3BGRjJ1?=
 =?iso-2022-jp?B?UmxXVmV4ZE9GY1NPOXZ3OHhNVytRTkVQaVVkSTU0SkpGOS91eUQydGND?=
 =?iso-2022-jp?B?N0g1N0FWWkNPRlBQV3pqQWVkSnh3VnEwd21abVEySXpObkZ2UlZXM01y?=
 =?iso-2022-jp?B?Z09FQ2Rqa2lYZEdnbUMrdENBT0lkWjdMQW1PM1YzWUpYRHFKVkZXMmRI?=
 =?iso-2022-jp?B?RDhnRFBabHZGRWNKeGFJY0RDQkNwZE4yUUkyYkk5ZWVyZW9sLzhLa1RK?=
 =?iso-2022-jp?B?OEFMMlJ0NlVzbXh2ZW5qZVdJSSsvUHdxT2dEUDJkU08vUGNpeFFNMWZz?=
 =?iso-2022-jp?B?NFozaWhKb0Jtb0NIRm9aa3JoV2JwMzJpRnJIVll4TDAwL0c3eHFpZzR6?=
 =?iso-2022-jp?B?MHErMGhhVXU5Q09iY2dvcWhWNUtXcGJUVHpGMmluck51Wm5hanBaZjh6?=
 =?iso-2022-jp?B?cWUvVkRQdm92cGVkTWlqVDRra3ZCT3dmZG5zSDlSMGZHTFRPRVBMVk0x?=
 =?iso-2022-jp?B?VkVRWDdPeXV3cTIrVjVXZHN3Rm02VWQ2Q3dzRVdtN1JDbDhtaDRhbmRI?=
 =?iso-2022-jp?B?OEQwc2JIK1lxM1ZucEZjU2YvaWRFSWVtaU95WWw0Zllqa0hSYTJxUGsx?=
 =?iso-2022-jp?B?bmtuSFZ6eUpKTVNYM1lBaGhPaHJtSG1UZG9pS05WanQxMFlrSWpzZUlu?=
 =?iso-2022-jp?B?M1BVT1hscUJZMGt4eC9xSUVaSlJJZkVDSU9QY0JiMDlySzZMUTFDUC9N?=
 =?iso-2022-jp?B?cnBxSkptRmF1V09vc3VCNlVDTEJsajViZnhwd3ZKTDlrWnA2eFliVUtM?=
 =?iso-2022-jp?B?bndxSVkxMGRwNU9XTjhWRUR4N3pvS2VvNDR5azdGZjVLc2pqWjIySkhK?=
 =?iso-2022-jp?B?dnJDSmt6Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DAAhUdXOuciN2Ayc3C354aHFChcJGtcFUZ7LZhqcYBvEN1U3U55D6udttNeEDNUX8sMwHhJqZ88cgEzWcbVmzOBOhhexhlUtfRE9eOYjGLiLrpmo5R4ShQVZLuc3YFqftHXeT8if5+a2x+g8Bd3dgbSH9J8dW6SRWowuE8K9YutS2LhPEnXedsENpfZOHZvmJW9wEnJF41zor8eNr0YwYJ7IKR/EgB0QoR3KMnxH4NshfqRYcuc6ipqZSovjlqTDbEg3AClfEHID0YnfzcFF/pC1PQ62rQQSQUIky/Z4wYc7tjE4PMnkzXq0hgJm1+MSCv/LbTlBbjnXr9QxoxbKDw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1059b9-79b4-4297-d5ed-08df3e08f2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:27:06.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0HkI2dhjKA9yHdqt80R4L/doDbPBtQpjienX/A8Lxc5v35Hb0FjqJYRctpFwyDtDc1sbv+FlRkRQnSbnjecz792UiFcv9Pq6Xqp3ap4Wk6naPvd4bsZFikH/psNq7xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15460
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 02:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24668

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
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/7] Add PCIe support to Renesas
> RZ/V2H(P) SoC
>=20
> Hi!
>=20
> > This series backports PCIe support for the RZ/V2H(P) SoC and its EVK
> > to the v6.12 CIP kernel.
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
>=20

I reviewed this series, looks good to me too.
I applied this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro


