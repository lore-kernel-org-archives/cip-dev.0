Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B17CA0EED
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 04:41:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.1406.1755837700870132085
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 21:41:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=pvFTPAQe;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1755837691;x=1757047291;bh=qoT6QzQd0aAeFdkWgPaLSAzAXZgOo93LRx1+z
	7cC2FE=;b=pvFTPAQe6Al2JymIVx46H2krBvxl24rwy44hpWfYy8wxqolTkuljcXZd4FXrYSDhd27
	flYCWkYwk2vOiNsveOsfhtDsqokWI+aIBFa/KbNMHrnhm7fZN6qPP3qP782Fzs/URxUMYuLMjGiEO
	59F/RTkxCGXMOEmhttOdWZna5NdISn0nNSqJsJ3KWT6HvnCIXsrgGXHseyDAtxkKS9bKGKmWdjM6S
	8NN/eHr+O9Dfyy9gRGtupg1gMgcI43+Ir/YLLz+NH9Vuka8QYKfsQhIIg0gsDVTk6cgiuNKETD1SU
	Vd7TMNk8ljWzC2Up21dwuT1XMHDlRKhNQjcj0VioysZA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 57M4fUXD1742079; Fri, 22 Aug 2025 13:41:31 +0900
X-Iguazu-Qid: 2yAbpfLvKaBiAXigYl
X-Iguazu-QSIG: v=2; s=0; t=1755837690; q=2yAbpfLvKaBiAXigYl; m=rQc/7kP5IAXpxw2LA5miWcDd5rtdaIqqPztkuSDftYQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c7SFQ0DXLzyPc; Fri, 22 Aug 2025 13:41:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAY6OFDnySFcCH7D4bLLnXXOEML0vlVBT19AgTnU6zLl1zDBnbYzMo839ugOjPF3oCYft30N7MWFV+UDcCpgfquPe254Ew+6FF6IKSG/EmW9QKycF95NDgYZdyLDR70aJokD9OtJO0jJzrmNCvQOVfJlpAK3PENxPZU1WtvHfW5Tv5Sr+a9I1ExGdYPpSOsXoo0G9HnTB4lmRYpW7weDmBe/9p9raCFLBDPX1HJsjtDHCSQ6+Z+GeBk6Dt/pXe+2cj5lejwZRrK6+KyTSYQZTOZooi4dSwbA00oVft4nop5LE1MJKR2OD9TJEGq/M9yf1yTdkWrMvQNaf16oO9tb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbf0P53x7Op3CFQkUJd+d86P+8UpF7ISiaAXoYaFv/I=;
 b=cpw5UrgOWzzIN/LqDSnzJGzO/TofgvfloRyAIqCl6PU/L8AIBSBSRjO/WHVah0JVdO4PtoPb7gQNVNLeVUFaz0mpqdIARx6A//oW+m+8epFDZURKCeBhMXBSX4uM6mIUFMlzhIwaAGF1M0rluiZ0yXOJorzuSHTnvH7c7FflcrxElhJYu3Yt3Svbb0M4ftNnFNLsbWpdqZROm+GNvwyvguaH11n90pF9pk7PueE0TWUJaO9Sg5I3gGviq2RDHXLW59QaQTE05QRSpasvwx0+rO/ALLkHwX5XndWLSFRbMQ7VIaEaVR9rEbRr35/2Ccq0WTDH3ujraP5jSUXwItM3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/23] Add RZ/G3E XSPI support
Thread-Topic: [PATCH 6.12.y-cip 00/23] Add RZ/G3E XSPI support
Thread-Index: AQHcEa8BB/6/h64cA0KY6cEOzNeHGrRuGeXA
Date: Fri, 22 Aug 2025 04:41:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481849D89F677869EAED3818CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15682:EE_
x-ms-office365-filtering-correlation-id: 3fa9034b-9386-4d1e-432f-08dde1362880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SHQvL3MvVHN2VmI0YndtMWdaN1E2YnJXZ2JJSkcvT1dENWpzUkF6K3N2?=
 =?iso-2022-jp?B?Rnh1ckY0YXFWSm5xOG8zVFVSN1E5V1VLLzhjVmoxYi80T2V0cDlicytR?=
 =?iso-2022-jp?B?VU04bG5pUWE4Mm8zQUdtVlJ4Q250RkpaSU5JS0RMVCtYemlHOFZ1OTdi?=
 =?iso-2022-jp?B?eFBCMGlRM2RMNTg3YWJYUFkzbDdnM09iS0lKczdENU9RNm5vYjhkMmxH?=
 =?iso-2022-jp?B?VFpwSFVyby9heEMxaURXY0JrWHVmRE4zdndUOFg5UU5xL2podGNpNjF0?=
 =?iso-2022-jp?B?NzlFaW9hSDNuZWhPWUtoODNibXl4RWwxYTR0ZGlRS05SRkwrRlh4L09D?=
 =?iso-2022-jp?B?UkpDUVpPdjN1MzFOcHRDUEJjZjB1Zzc0cXpzQVpCZkcwSjdpMWE3ZWpn?=
 =?iso-2022-jp?B?KzZPczBhbGFVeHV1WWFSbVJTc2RGY3lsUElRT2kyYmFDUnBOMGFHZXM2?=
 =?iso-2022-jp?B?ejBNc2d2VXN4dXRzM0VkWDlYUm50REtLbnJ5SitnNUx1VHpvcUwwLzBN?=
 =?iso-2022-jp?B?L0dzM25PV2pYcmpNUnBVVjc0djIwY3p5Znh2cm1VazIrelNzb0tMTW1w?=
 =?iso-2022-jp?B?TzdDcVJhaHdjeUMyUEkyWlRFSEt2QjJ1NjRhSUFJZjB6MytUK1NQNUVP?=
 =?iso-2022-jp?B?a3I5MzRodW1uNHB1T2NNVlBqZEtrQ3ZuODlPRFpPMWZxVThESGd2UU5a?=
 =?iso-2022-jp?B?OHhCSTEvaXRYVWd1UHQ5eDdRQngzeWtLeE9kWkpJRlh2dVVpQW1DUW9k?=
 =?iso-2022-jp?B?bkM1TldLR3NiZ3B1MlJmSkMxVDBzTDlCNDNHdWt2bnlWckZjS3NWTHkv?=
 =?iso-2022-jp?B?VkRnZWQxMWlzdGV0aEREL2NpVTJIbE5xd0t3ZXRoVS9yM2VoeGZGck1P?=
 =?iso-2022-jp?B?MjJ3Uis5dWRxYW9nV0VUWFRsZGpVL1hGUkJNMFRXWGhWRWtGSmt6b1JV?=
 =?iso-2022-jp?B?N0RtL1FFZ3BQbUFPWXE1MThSOGxZeTdJbkRjcTMwNzZMaHZHVGNpK2NR?=
 =?iso-2022-jp?B?eE5uTVNGT1ZtRmIxZmhlMks5aXYxVE10YlZJWHBEV1pmelJVcll5YThD?=
 =?iso-2022-jp?B?S3E2TjNVaU5LdHNjU3ZoVk93dUtkaWhYQWwxbWpZeTQrTDA4MFRSSzZC?=
 =?iso-2022-jp?B?WGRvZ1NLY2s5cWs4dHVQTDgzZTJoL2E0d0tsRS9FT3NaSk95THFNSWlr?=
 =?iso-2022-jp?B?ejRTcGFTWEd1bldjc0VPeXM3d0hjSU5TMjZwSUM3SlJGL3kxVjJtM0w1?=
 =?iso-2022-jp?B?WmdXZzF0MktuSHJiYmJJeHc3ZmRoMDdNYi9BS3NlQ0pzbWwwc3pOZ0NI?=
 =?iso-2022-jp?B?OFZuSWtTTlkwaUcyVnhsVm9jUnJUVktBVkpGTldZbVl5dlNROGxZK25V?=
 =?iso-2022-jp?B?a1RNeThzYUlHQmdBRHFoR2RueDh5aEdVR2o0dUZaN3NtVmRMczV0SWo5?=
 =?iso-2022-jp?B?eGo1R3Z2Y2NDUSt2VnlsSGFQQ2pwUTgyQm4rOUF4QnUyQ2lYc0ZyeGtP?=
 =?iso-2022-jp?B?eU9PSnJrLzkrYlhYTlkwOVNwK2xzUDJPRGRwRW1vYzRvazNyYWVnRSsw?=
 =?iso-2022-jp?B?SjJiL3ZUR0JkNm5qU1d2WmR1Tld5c3Y3MkJ1Zk83R3ZCSnZLTEQyR3kx?=
 =?iso-2022-jp?B?THdBRnY4Ulg3VEJ5WE1WWjRhRlYwUmN5bTkrbzVVTmRuSXp5ay8xeENG?=
 =?iso-2022-jp?B?elVFVTlNZnlxTlFnYVk4RGwrTU12eVllWHIweTBjdTEwQmpESHdGK0Rj?=
 =?iso-2022-jp?B?ckM4dyszbWFkc0lTNjFVNmNxK28rSlY1YUdmZXVXQkg3WG4xTzVMV1d6?=
 =?iso-2022-jp?B?TEFjVDFKcmJlRTBBalZ5L3ZpS21rQm5PRFhVaTc0U0p3aGVYUjg3akVr?=
 =?iso-2022-jp?B?YVhqbTFBWTNzQ0trMlR2cXJvbnNwd25Sd2pWU2pIdFZqZGh3TVJqRVhE?=
 =?iso-2022-jp?B?N1lvbEovRUpHVWFwejZHR0U3RGsvM3dOSVFmVnNzMlhrWEgzRUxWYjVt?=
 =?iso-2022-jp?B?TTlHTXFEY0VYRDZjODlYWHdGdDJDOWQ2V1d6akpIU00wYm52eFpKaUhr?=
 =?iso-2022-jp?B?ZVlaZ005ckRtRE4zNGdCdGNHZ2JBZDRRbldyb1Y4cGNtTjNWQzN4STZH?=
 =?iso-2022-jp?B?dGFrUmJBUnl6bjhVWFk0dlZ3RUpzZWV4aDQ5aGtaUzArSHA0VHhxM29S?=
 =?iso-2022-jp?B?YUQwPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Wk55dEdIVTlzWjNuYlNheDZRQzlPd0hVM1B2YmZVOU9pZnRGSFFYTGhy?=
 =?iso-2022-jp?B?djI2UDd1dHpJUVUyZGtWc01IaEhvcmxCUGlNWm5VSkhOSklPOE96aFgr?=
 =?iso-2022-jp?B?OExCUS9LYmROYXZ5ck1naWdobzlkMnZvWU5lTzFWdGs0Zmt1bjcrRWhM?=
 =?iso-2022-jp?B?T0p5YXJ1cGxlQlQ4b3lMTzd2NW52WEpkTVFFYitwbzBxbDBZWGIwb0tJ?=
 =?iso-2022-jp?B?Qk15SUd3UmVja1ZFem5GZ1NQZFQvZXlXdkZaTE1qTFpBckNFMU1rR21S?=
 =?iso-2022-jp?B?ellVemRlSEhZMyt2TmZCQTRhQU1iekpWaDNSdC8vbDB4ZFQ4Nldxd0dl?=
 =?iso-2022-jp?B?ZU5kSE1seTVQeVU5TDRCN1QybUgydTUxNXlYbzFQWGZLeHJtWU5la3B6?=
 =?iso-2022-jp?B?NWk3WHhMaTdLektaRHFMd0k5VFBoM2FkRFkrRjBZVVcvdXpXL0c4U1g1?=
 =?iso-2022-jp?B?K0J2OUFuT3FxUUNBU2lGNFJkQ2p5TzF6cVp2VE5tTkxSK1BpOVkyaitN?=
 =?iso-2022-jp?B?bFJDOU9KSnA3bTR4YWQ1VXBDeUkwc3dkR3RzcVZ2MVdBTjd5UmxMQXRo?=
 =?iso-2022-jp?B?Z3NsVEtuWm9UYm9oelRPUEFBWmoxYi9ZcEZSbWovY2tMVVdIU09KKzFk?=
 =?iso-2022-jp?B?dHZSMHVDWDRrWjExdnB1NzJudnlnaE5CWDBQREs3b0l4UE1nMVF4cFVv?=
 =?iso-2022-jp?B?TjlvQmYvazcvUUxjRjlGT1lGRXZHS2NwNFpzWjhCSkVHcFM2Z3IyQVdx?=
 =?iso-2022-jp?B?c29sSGdTQnR6VlljR2V6NEZROG9LYUZUWlBiVG1NQ2hPeUJ4bTM0ZXd5?=
 =?iso-2022-jp?B?SmRxNnlMeWwvMG1WaUwrd3pUVkVsNXV3alJBTmtjd3d2cWxHR2hEOVVF?=
 =?iso-2022-jp?B?blNXYkNXR2NuRm1tamI3MVBLUUQ0SjMvOVJhZXRna2UweklQbm0rajY4?=
 =?iso-2022-jp?B?a2dNcHNjdTRCTFMxSmlTR1R3azZuS0R1bUJVcXRKNzgzNHRXWmJndGx1?=
 =?iso-2022-jp?B?YW9BMDB3MTJ3WmdrSEJ3MGc4bTZYWDk1U0ppUThtQUtMeXlEOSt2bmNN?=
 =?iso-2022-jp?B?WStVVHpKYVVtNXlhUFl4ajhnTTRHbS9GUzZnWEZFTkRtdEl0NkRDT1lm?=
 =?iso-2022-jp?B?ZGJwTWZuR3JRVmxiUUNzckhESWVOR3BjTlpwME1aWWNxSmpEakFXdjk4?=
 =?iso-2022-jp?B?RkZIY0VrcDBRalhiTW1oVnI3T3QwUWpNM1drYmJ0NEJia1NBakZkYjV3?=
 =?iso-2022-jp?B?T1BuNlFDTHVtT1hBWFJVVW1OTEZFYmVUK0ZlSEVaV01YVnlBcGxyaVVr?=
 =?iso-2022-jp?B?c3pDYk9GbW1hTlRxZzJmU1htVzI4elNpOWFRTXVOVk85T0QwVHFVU0xZ?=
 =?iso-2022-jp?B?MUJsV2ZMVGJCU1hBWXhMUnFRM085SmhzNXVrdE1TMHlyMyt1cHFHdHlF?=
 =?iso-2022-jp?B?ZFM3Y1QxeUNGR3RUc1RwR3VVS3EzUFFSdHNLT0hBODNKWlFPV1JvVHNk?=
 =?iso-2022-jp?B?ZzZxRnN3aHFtaVloOXZ5b1BHcmNUQkdNWE15eWo1dm15eHdZVVB6bUs3?=
 =?iso-2022-jp?B?dVVzSC9HVWxvWHpualRMV1RHVDNrR3VPcG9MQ1hMdFNhK0krUFQxeEFP?=
 =?iso-2022-jp?B?SXhsaG1JM1d4QUtra01sNmZLbTRPTmhKZ0daRTc3M0IwaERrQUF1S1Vi?=
 =?iso-2022-jp?B?MDJNYkVlMWhPS1BCb3pkdDB5V1FYbEMxbHhvNU1uWXBiRXZEdlBsRFpi?=
 =?iso-2022-jp?B?OFV3cGt4RlFld3JpZWM5b3F3MmVDQnVMQ0hUL1VBbE1pcUlrNXFkSk9k?=
 =?iso-2022-jp?B?N1p2Y3EvUjdwQ1Rncm1PbW1FQTk4M0FQSFpXZHZNN1RGRWd1UFZWZHMw?=
 =?iso-2022-jp?B?dkRycUtEaDg4WmR3aWpUNEJhQ1djWGpNTkxrR3hoN2FJakNMc2RWK2Zq?=
 =?iso-2022-jp?B?dzcwa3VzUGlGTzVySDlCM0cvTjdhMmFQQUp3UEVLUVkzRkgzN0xwQ2sv?=
 =?iso-2022-jp?B?bXFnek5Ea3pScFJTUHhuMnZra2IySXJzQXYyZGFkUEprdDkyQWJtZk5N?=
 =?iso-2022-jp?B?R051cEF5ZitHVVRiZUdjV2l2VlJrcEUwT1FqMXF0Ny9OM2pvbFhUbW1U?=
 =?iso-2022-jp?B?TkJOam9RZTJMTUxWbS9hNWExRTlHUzNObDkyV2dkSzB5aksvSnFKSjNy?=
 =?iso-2022-jp?B?bUJGd3hkUktKSGhTVXEzcUtUaTA3UFRGZk01Tk5PY2liVCsyTlZiNGZu?=
 =?iso-2022-jp?B?UDJpSmZ2WkZvb2NXUEdDK3RUR20yVzJWcnBUSkZ6TzA2TmpEVWZ5ZlBm?=
 =?iso-2022-jp?B?cUpMOWxad0pXeDg3S1kvZEtibEtDd1JOTEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa9034b-9386-4d1e-432f-08dde1362880
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 04:41:28.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCm5X/w/kL06aCFbMmiaN/Jo8HQ6pgAaPQQKn+QrhgtrrDZsmbyLu/oommHHCYe9vgho5C17Uze74mk0o+5hvYCKkA2AL7gSjQ8Bvq+01v+DMFUNyfdN6TmgxbqzR172
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 04:41:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19942

HI all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, August 20, 2025 5:46 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 00/23] Add RZ/G3E XSPI support
>=20
> Add RZ/G3E XSPI support to 6.12.y-cip. Also backported clk and irq patche=
s.
>=20
> All the patches in the series are cherry-picked from mainline.
>=20
> Biju Das (15):
>   dt-bindings: clock: renesas,r9a09g047-cpg: Add XSPI and GBETH PTP core
>     clocks
>   clk: renesas: r9a09g047: Add support for xspi mux and divider
>   clk: renesas: r9a09g047: Add XSPI clock/reset
>   memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
>   memory: renesas-rpc-if: Move rpcif_info definitions near to the user
>   dt-bindings: memory: Document RZ/G3E support
>   memory: renesas-rpc-if: Move rpc-if reg definitions
>   memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
>   memory: renesas-rpc-if: Add regmap to struct rpcif_info
>   memory: renesas-rpc-if: Add wrapper functions
>   memory: renesas-rpc-if: Add RZ/G3E xSPI support
>   spi: rpc-if: Add write support for memory-mapped area
>   irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
>   arm64: dts: renesas: r9a09g047: Add XSPI node
>   arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH
>=20
> Fabrizio Castro (1):
>   clk: renesas: rzv2h: Add missing include file
>=20
> Geert Uytterhoeven (1):
>   clk: renesas: Use str_on_off() helper
>=20
> John Madieu (1):
>   arm64: dts: renesas: r9a09g047: Add SYS node
>=20
> Lad Prabhakar (4):
>   clk: renesas: rzv2h: Skip monitor checks for external clocks
>   clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv
>     clocks
>   clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
>   clk: renesas: rzv2h: Add fixed-factor module clocks with status
>     reporting
>=20
> Raag Jadav (1):
>   clk: renesas: rzv2h: Use devm_kmemdup_array()
>=20
>  .../renesas,rzg3e-xspi.yaml                   | 135 ++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  28 +
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  46 ++
>  drivers/clk/renesas/r9a09g047-cpg.c           |  39 +-
>  drivers/clk/renesas/renesas-cpg-mssr.c        |   3 +-
>  drivers/clk/renesas/rzg2l-cpg.c               |   3 +-
>  drivers/clk/renesas/rzv2h-cpg.c               | 130 +++-
>  drivers/clk/renesas/rzv2h-cpg.h               |  47 +-
>  drivers/irqchip/irq-renesas-rzv2h.c           |   4 +-
>  drivers/memory/renesas-rpc-if-regs.h          | 147 ++++
>  drivers/memory/renesas-rpc-if.c               | 714
> +++++++++++++-----
>  drivers/memory/renesas-xspi-if-regs.h         | 105 +++
>  drivers/spi/spi-rpc-if.c                      |  16 +-
>  .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   3 +
>  include/memory/renesas-rpc-if.h               |   4 +
>  15 files changed, 1217 insertions(+), 207 deletions(-)  create mode 1006=
44
> Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.
> yaml
>  create mode 100644 drivers/memory/renesas-rpc-if-regs.h
>  create mode 100644 drivers/memory/renesas-xspi-if-regs.h
>=20
I reviewed this series, LGTM.
I can apply, if there are no other comments and test is no issue.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/199775424=
4

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


