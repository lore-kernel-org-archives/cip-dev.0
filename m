Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6498C87FCB
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 02:08:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.52212.1753927685442744337
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 19:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=bvMjq8PM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753927670;x=1755137270;bh=FplIY84uC00tENo9fr59hQRfPypP1PImGRWaGhq
	acww=;b=bvMjq8PMZh/4NPdY2dGiT4alEOp8ofk1PIyYMLb0apSNSQXG3CLNZ3ciu9jT8ZUOr3WQo
	+H4Y7H1tEd6IKdq14TRPzbReyf0NWCUxAKXZLZA67YXjwqohdKXIvm/uSNPM5EnRZSD5jqrnVka8J
	Bxp/EuYIPhA9Z7BIp8GxirgXsHKDku6uqXfoG00q+8FsMSF5hPRgsOzF/UkVVhyjCBWhx8syxX7Ab
	3sFsJeJ7xnAsEYP+cpADALY2kxT7QnnnUzcADUe2S2dZ6nOkKkMskaYDi+rpGxk8owzoJQ6AqBtx0
	SrHG6snzchmPs+L6T4XMLkqf36XCvv6/NckYW6kbQQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 56V27n2Z1092704; Thu, 31 Jul 2025 11:07:49 +0900
X-Iguazu-Qid: 2rWhBFYKNKzyLFnQUJ
X-Iguazu-QSIG: v=2; s=0; t=1753927669; q=2rWhBFYKNKzyLFnQUJ; m=YUlnhickt3RbBJyWxDbmoj+L3o+izK5cXTXekbXEkH4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 56V27ldG477178
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 11:07:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL+W+Cj2+Xz+bud/+aM3oaUApYzRmgRzdFChrTHCwAdmNmaIzjKrJm/Mx3VIBmIwaZKkhw1S+Ds/CpxR1pz7AyQLlweV9afM5uWABjT+rJ9c7MOoviqeU8dMxG+6f6uuDKegdse6gkL8fQPUJQXMT/0w0QgqUnpCy+amlGXj3+xo+nKYeXcmDaXiocZDOChAlRT3GoZ9fJiHApYC1cb7dI0ljAX465cFdp/J5Q19N7RhauPCNMWYja0BVVSPR5Ps7Qxvjn2HBQBjm+gnqufPbnKr8mAyX4H4fMjN3qb+mqcJXcSzeT3gbp+EpLbK1DY2q12BDX6qK2fY1/tsohAjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C3PERZLbOavd+Z/6/C0qDBBDZAMJ14kqbSwIsSxYoQ=;
 b=kQLDNLV1pE09ZLd2/x/O2o359P9yEeR3hjkfEzKOLuXocPGzecSerB7CuDKFZyVJYMNdu/yeMAV9NrVKIwMCO+n1ROorQO4Kj9VX4LQtAtHLTK3B8hMRZ+KRk4lCER/c0zBTgJaMMP48YEckW18yhIIucONJj1c/DN0Itr+EQfTqWJz6LZLFLrKLITC0y39IAFEkP0RpwB8kdq3GpLKlmXnK0da5f36+s8Zlb8wLOZ8uQfwX6U1GJtvmIHZqkW+ujH1Zgt/ARqxsm0jJtxd4jB3I3LOJwixIG0iiGcwTNYRPa9Pxdd2jIKRs0BXyOEXBVNwDh96INKw1Vse3YgRUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <tommaso.merciai.xr@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Topic: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Index: AQHb/8ZoEyzJxO3hJkunaTPNgpRNOLRH+FqAgAOHmaA=
Date: Thu, 31 Jul 2025 02:07:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481820F245E972D09AC448329227A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
 <aIfZseR9WgRYf45U@duo.ucw.cz>
In-Reply-To: <aIfZseR9WgRYf45U@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15541:EE_
x-ms-office365-filtering-correlation-id: 9f2f692d-c051-426e-c84f-08ddcfd70954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WUk4d1JCaW0wRDc2YUVnbEJHZUxwRmRuSzZRdWxlcmFWayt6SW1vSE5y?=
 =?iso-2022-jp?B?WUFDMldzbFVOQ0xEanV1dnZxOEtxYW1zSStUR2FHZzZvVnVxWTdYdnV3?=
 =?iso-2022-jp?B?ZnR5R1FtMjV4Mmg5WDVrWnZXTjRycXBHVnFYWmhiNzZMbUNqWFdvbVZJ?=
 =?iso-2022-jp?B?a21FdWtlbk5JTlhJWnhycGdoMCs3V0FRaXI0OTVvVXhxbVVjN3hGNERp?=
 =?iso-2022-jp?B?NHVtb3pqenJ3b0xIcGtxdzJaRnRGUVI4VkFWd2p2YkpuTUNHRnpka0xN?=
 =?iso-2022-jp?B?K2RsOE1wZmhtb3QwVlJvbXBhWVBIVW85UEhYdWQ2Ukd0QnNyVU9TMm43?=
 =?iso-2022-jp?B?YUN6WWFYVEt2Vm5xclozeG4vUE9UV0V5bUx3NForUnkveklXN1pZTUVB?=
 =?iso-2022-jp?B?c2EwaXlLQk16aHBtTDJ0SGRjVjdZWDZTbzRCZ2JlbFFRM1gzREQ0ZlJy?=
 =?iso-2022-jp?B?dkwxNU0yWlYybEtxZGRYVGtoR2dESE9yL0NEMjlySitDTU1ldkFFMFJj?=
 =?iso-2022-jp?B?SUVMNnJNWjgrK2Fjb0VUd1d4V3NBdXk5ai9SeFlyMm1BalNwa0s5STNu?=
 =?iso-2022-jp?B?WGpBb2RSbDNYL0MxV0dJSkNuRm8wU3c3dVhRcE9pQ0d1bW1ycmZ2V2Vi?=
 =?iso-2022-jp?B?WWpYVkg1OSt5L0pzYU4zV1FsRDBvZVVXaDlIcDlVMXZvT2I5dmd4NkFw?=
 =?iso-2022-jp?B?R29xMkFYMmIwTUVZV0hDTCtrNnQxWnhOOUErVXdadk83UFVwN0RTVnhi?=
 =?iso-2022-jp?B?NW9LVHdYeTRRQWcxazRqWTNlenlUN20vK0NOU3pDVjJzamMrV2ROVjhY?=
 =?iso-2022-jp?B?alVETGp1enFSbGdYblRYZFhUNzNPK3JhMmpzd3RqVjQyaUZzcDI5Wjdk?=
 =?iso-2022-jp?B?TFk0YU1RQTVRSWs1MjdhV2RGSzFEdm1OT3lDcHVxM0k2MC9OWG9YTnZ1?=
 =?iso-2022-jp?B?ZlF6Ny9iVnJlZU95VnVYM2tva01MemxmNzRGYmlpUzdZSC9nL1kyV1VM?=
 =?iso-2022-jp?B?cy9wSlh2S2F2dFFoU2tYNGExWUpudW5WYjJ5c2k0dkRONU94YlVOTlFR?=
 =?iso-2022-jp?B?eVM5YjFWZmo4R0NSUGhyaU4vV0kxdzdyZlRWenROZGpNdnlEZ21RSmd3?=
 =?iso-2022-jp?B?QlhiSlBoS2NTdDRBTFZ0QVlQRXo4RlRXZW40WGpNdzRZS0hBNkNBUWZQ?=
 =?iso-2022-jp?B?WXBNMFltc2t3OXk0NlZtQ0ppendOWlhHOHFya2VENjhvVzdZendwTXR3?=
 =?iso-2022-jp?B?Y3ZxalJHSHhLMXlBYXAxcVNlUkowd1c1UWdVV05mdlJoMDhEY0N6RUlG?=
 =?iso-2022-jp?B?WWxVN1ZTWEcvMmVzZmJ2Z09OM2FDTFhhc3dGMXI4d0s4T0s3Y3l2bEtk?=
 =?iso-2022-jp?B?OVc4cEdmS0kxamFsMGpBUzN2T3BsV0luSDQ0Y2FmdkQ1YTFjZnJ0WWtq?=
 =?iso-2022-jp?B?YzJOVjllbmthYWhaN1RWUTcxT1F3dFlTZUxMdkMzc2JiYnU4aDFQUkk2?=
 =?iso-2022-jp?B?ZmRLTmVNR1k2RzJiYUpaSzA3aUVGU3U1aGx2OHlaZTlKWnkxcjJvME0x?=
 =?iso-2022-jp?B?SHNYS2FHYlpKMEN6Nk5IM0d2dEVMcmRYSUM5Y1dCZlRVNlhGMHUwZzE1?=
 =?iso-2022-jp?B?VzJaWUEwNmMrSFFTNy95VlBiY1l0dHkrdHR4WTJXNzlvcjVuSEx2bHpT?=
 =?iso-2022-jp?B?S0JKd0lJa1dwNXhuNTl4TmNlR1QzT3oyUTBpcitPTDQwKzF2QkNjUUc4?=
 =?iso-2022-jp?B?enpIeEc5U1lUN0JHQnpKTmJmbmhHamNrZVN5NnJlS3dxMFJ3c1hXU3Y2?=
 =?iso-2022-jp?B?eVF1Qk5KMEIxOXF2ZENKb1QyZkFIYXZsN0J2UjhDM2RhbVVwYm9nTjFk?=
 =?iso-2022-jp?B?U2JLQ1M0OVdDVC9Ua3Z1Y2dST2x4cEpDSnlrTWNWU3dSSHNYTTVsQ1JV?=
 =?iso-2022-jp?B?RlY3Rmp0R0VqUkNIUVpzZk0xYTVoTitWRmczYyt3TVRHcjFSR1JBMGd5?=
 =?iso-2022-jp?B?dmJNRGRkdU5EOGwwYlBtOHhuclVuWWVjcE82eFkwYzE1aGdaNUZCbE9F?=
 =?iso-2022-jp?B?THNtTmV2c0NXZy92c0RFS3kyallIaUdHK3BBbG9aYlhVQnlIRWpTbUw0?=
 =?iso-2022-jp?B?NEMrdHIwY2Qxdkp1U2N6UWJWNDdIRXdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RzdzNVBvZlM4UXFYS0ZxWkgvUERYK0lzazltWmlDakhoWmpFY1lsWkFT?=
 =?iso-2022-jp?B?azlmVlNLTXMvcHFTUXhvZDA4SStBVHRNZmg3ZHc4OGNjNWViODlxQnBE?=
 =?iso-2022-jp?B?OXlJVWNUUzN3Sng0bS8xaFBVRTlXR1ZvbzUwUXlic3hXTVQ3dWN0MFZt?=
 =?iso-2022-jp?B?WXlmSE5OeWV6bUtUMFRvU2FPK0kwK21Kdy9lVWhUOW16b2tTaUh2dyt6?=
 =?iso-2022-jp?B?N2dOcjZPV24yMURzWkVXNnFwTVV1UEgrM1RDNW83d0hCalJFVVJkSXRV?=
 =?iso-2022-jp?B?eE1FODcwRVF3ejkzOE55cU9OTnBlNDBXSlFXazZQUVRyZ3lCVnlsUWx6?=
 =?iso-2022-jp?B?QVg2bkYvVndPbVVZbGJGMjd3aFZUVVk2a0dkQ0hHSHRWV2xpcUFqSUVB?=
 =?iso-2022-jp?B?YkNYYzdicDdtMW9YTyt4TGs1VWhPd3RUZWMxd0dqM08ybXpFckpkY1Ny?=
 =?iso-2022-jp?B?ejVqSWF2SjArVG9selVPRGI5U0FJQ0dUTW42V1puU0VIdWk5TDJXa3Za?=
 =?iso-2022-jp?B?VWxJY0hTdW9TR2JXOVF5K1I2cXBmZWEvMTFvdFVXLzdWNTZYYUVQMmZs?=
 =?iso-2022-jp?B?eSt3R2pFaStmNFdva3E1aHNZTkl4R21pM0lYaDlHR05DT0FyY1kraVYx?=
 =?iso-2022-jp?B?NXpQUy9DcWZ3UU5rNVJMTGRCbTBGKzQwQ1NmREpQd3ZMbURWZXo2czM0?=
 =?iso-2022-jp?B?QktQakd6U2gvYURkVGNlS0F1MVkrSkJlNzEyamdXaTREc2FqM3pYb2Iw?=
 =?iso-2022-jp?B?N3FmZFN2dFNpMXlEM0JhMTQwa1RKaXM1K1NqeHB5aTZpcWVsZTZ4bEwz?=
 =?iso-2022-jp?B?QWtFcGF2eUZCeSt6cW9WQ21QaVB6bERLYTBTcXRpV1YzUkhZakczNVhp?=
 =?iso-2022-jp?B?cllhMU0xcWxRY0dBTm5Xb3dUTTRjdGY1Wncram10WjNmQ256OXQrUURa?=
 =?iso-2022-jp?B?T1RzQ0JNOThQeGJpZzRYV3NJaGtqMFdCdEp6WVQ1eVJOckhPSUNxK3Jw?=
 =?iso-2022-jp?B?UTJSZ0V5WVVFelBFNWNwelI5YzdDVUJsam1NSUM0aGJLZjVnWGZvbm9t?=
 =?iso-2022-jp?B?L0xqZkVMeTVFcVp6YVB5UEo0SDRQd0EwNXU0WE9hdERuVkY3WU44ZGRT?=
 =?iso-2022-jp?B?MVhYK2pRbE9wTWJEZytaSHpNUzlHWWp6Y2VUQmF0VGRoQkFpNWtvaGtL?=
 =?iso-2022-jp?B?amphVlJHWENYQXVMWEw3Slh0Y25IL1pmVUo2SElsVXBxYnpwQzJFbTg0?=
 =?iso-2022-jp?B?OGF4c2NZcFR2QlozYnZwRVRDSUFUK3NpL0hVTDhITHNSazFMa0luNlF5?=
 =?iso-2022-jp?B?K1c4Z1FiWDlLMUxYOU9CWTFrdTNEUm9QcnFBdVdtblY2R3k1c0U4eWVa?=
 =?iso-2022-jp?B?bnlFeTl2RFJVZzJWd3A1VXhCUHZuTytJL2RFTzRRQ2ZFTlBRcGYya2Ix?=
 =?iso-2022-jp?B?dW5hKzFnTWJ6bDVncHF0dmR2UW5DMG9QeTAzTmJDV21nOEo3aEJVM2sy?=
 =?iso-2022-jp?B?Ujl1WTNRQUFwNjBBcEw3eDRlckE2WmFkQ3pRSjBZMms3R0pxdlFWT3Iz?=
 =?iso-2022-jp?B?Y1hoby9DZ3VhMlRLQ0pTM1NPVWdnYi9tNUpLYWx3LzAzNy93YkU3RjBa?=
 =?iso-2022-jp?B?TThZelhacFpJQUtreDZneFR4WFpMSkw3WUt4eDR1VytUL2lCTGgzOE9O?=
 =?iso-2022-jp?B?allWVkZ2Mis0T2JseGliMjZKUEp0d3RhdE9veFJJT05ITVdRa3czRWZj?=
 =?iso-2022-jp?B?RXpUc29yVlVxbVVjODd4WXVCdDU0T01wVDlwUWRSdFRiT2U1alhuMFVm?=
 =?iso-2022-jp?B?bWhpcDVISUtOQW1TTWtWKzYxd29jN2o0cEVicWRQTHdmaHEyTW4yeEZP?=
 =?iso-2022-jp?B?cTBQblRrYWpqUk5veDNjUmk0dVVnK3RRd2I2RHIzQjFiL3EweHBRSmRQ?=
 =?iso-2022-jp?B?MndKbC9sRy9pME5CRlpwUWlDSStOOUxueTdEaWUyMUp6aEtsS1ArQXRs?=
 =?iso-2022-jp?B?WVYvZGV6aHBadjV2WDJqd0dtWkpRVElvRm4rMkVxcFovNTExazZpd0V3?=
 =?iso-2022-jp?B?OWFIZDR5MkM4d0VxN2I0anBvSVMwb0lvY3NUcWl6R3V3NG1ReXNQRk85?=
 =?iso-2022-jp?B?a096TDhMbk8waXlkY2piSUNSWjMyVmdTT3E3cVNpa3RlZXpXZDM2dW82?=
 =?iso-2022-jp?B?ckY0QS9pR0hTYTRNbmFuVlhDelZwazViVkw4MGFWRkU1elBtSGo1c3F2?=
 =?iso-2022-jp?B?bzl4dGZFSlJ6MWVYd3hqb1J4alVmc3Jnd1E1b3oxNXk1bjZSWHpSRENE?=
 =?iso-2022-jp?B?TkRvbW0vcWo0cGdKNEthREFLVTd5S0tkR3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2f692d-c051-426e-c84f-08ddcfd70954
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 02:07:43.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDqa0nuBhnyR1QSyJvj4hB8WdZ1ELybhyEe2kTubH+tV6bkvOIh62aACW8F0jB6ZvG9G0zHBb9KYT1hsO+b/LqX1kShmYgyAueZpRlQ/JGBmfvPt3RzzAaIUU5xbhXRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15541
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 02:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19624

Hi all,

I applied this series and 6.1.y-cip with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro=20

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 29, 2025 5:13 AM
> To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das
> <biju.das.jz@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: Re: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-sma=
rc:
> Add I2C2 and PMIC support
>=20
> Hi!
>=20
> > This patch series adds support for the Renesas RAA215300 PMIC into
> > linux 6.12.y-cip kernel, on the RZ/G3E SMARC EVK board.
> >
> > To enable PMIC communication, the I2C2 pinctrl configuration is added
> > first, followed by the RAA215300 node.
>=20
> Thanks for the patches, both this and 6.1 version looks ok to me, and I c=
an
> apply them if they pass testing and there are no other comments.
>=20
> Best regards,
> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany


