Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C9C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 06:40:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.74097.1720420812171905279
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jul 2024 23:40:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Hyr0hzrG;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1720420801;x=1721630401;bh=dVuMlgvJWdT/XtMhZsW5FvVZE/Q6Mtsr5M2lLjF
	/dzw=;b=Hyr0hzrG+8XGJY8aIlmGMFS3vN9b/25ZX0wq7IrxX0S0vg2Ukby0PtDaqZR0xLRJUfTo6
	N2P/HeLEXwwyjE6YAk24SPZU3Is9cUYTQ+FFF4Il5L+isupZg7PALkLdFNkl1Rnzc6rk7y1CHVWFH
	Vw6d6gKh0FURUrOiUoezfTthTK/SwMqG8fjhB6aq8W6jKNrXKu5QM248bOImnw1RuRusseBEGcQ8x
	8N8pbr4P3kbv3R1Plv0EUHz9OBrDk+vIdEHfuiMMGvRR60vNRxdnQMGA0SomF5a2E6D8+scJXlwsa
	OdvjGLgDeNv8kAzZhC55gUkq8kyX9LlBXzNy0IwNUg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4686e0h63587722; Mon, 8 Jul 2024 15:40:00 +0900
X-Iguazu-Qid: 2yAa9B2RMoo0zq3CgT
X-Iguazu-QSIG: v=2; s=0; t=1720420800; q=2yAa9B2RMoo0zq3CgT; m=SqlbE8j0LeHSb9VELY3J3jE7wTFbJimJdOZvAiluz/I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 4686dxDo089893
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 15:39:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtoqRWV3p5RORbLwZQb2B/vuHlS9Pa5s/VxPUv4XmOW5g5ZS15mgICBBVC+zhBrcDfdts5shrp+Nbey2QbPI12xhUjl26/rzN9VYnSvoN05xQoC/RDNFU1M4wJQfSeG3NywuxQ8G1yQfAoKLjm5j8MhU6jdTQLYLJ3oRv+OweoWmY7H8PJvsH+UqW4yEZyLFDjCPKRH1BUBlX9lLUrCK/ORG8XoSDGiF7eeCAHDKVKGeWYMdtTwXjlbrhSyhRPHi0/w8mgZkSX/p/mOyfKlBi3dY6W3VTIou5ZXbVSGkgGJmeoJCIprDfPfdQhXj8/OnP/CYVlFTM7orku4IXxaL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etjVpyq34nTt9Jbq8Hwm+zwkRgiypsF24jlFk000mmI=;
 b=A09LS9UB/l5s5SxeXSH3wkMUcP/EquaxygDQ7q5DXv29cJD3DNQ54+ZU3886ZbOpRnIPHnWif1EkrGe/F+t1pJPfMC0YsKdt8IQ2AsutTi4VLqlSSpwxl59FiQDQ0ITCw4DvpxLwRnQc2xHN/GWSy+glNnU9MoRkI8T2TmlzBaiYq/itjqmkKXKd8FYkFmzdwc1EXa6h7n+p7zpH9408tZsVW7Se5eHYqMwyRw2Zw4ynKSJAnXM0LmdcZoIKl5Wsrk0o4qh5toB93ZnZhabo5BE8VL2Tk7O8lDfEtTEJbfQnPNW+hZdoNksxdvSzCQfBywBZBQYQxvUwsDPXBbwKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
Thread-Topic: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
Thread-Index: AQHaztvfaIaOxW379EScgA/Dc6I9HrHsZSkw
Date: Mon, 8 Jul 2024 06:39:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391ADDA9FCEE7A5B46567E592DA2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYCPR01MB11898:EE_
x-ms-office365-filtering-correlation-id: 55b6b3fb-01a2-4e3c-5dcd-08dc9f18c7fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VHQ1SXpmRHNWNFNKb0tDbVBUeTVmeEtoejhweXZpZzQwd3B1ZWo4TmNJ?=
 =?iso-2022-jp?B?Z001Um9nMWdUTUNLS1dmVk45MmFMemRHNE9zN29odDd3UHRZNmNSdTZs?=
 =?iso-2022-jp?B?T01KT0xOY3FLWlNtL2lpL0ZvTFplOCsrM0gveGZhbUJGTUZyZlpuR0Np?=
 =?iso-2022-jp?B?cVRHOERReklEWEU3QXBhc09sNkpqMzVhMHlPWnpLV0hrTmJIUnlsN3ZS?=
 =?iso-2022-jp?B?TGtiaUZDVW9ZNm4xU3MzSTdTUUgxOWdZelpSSkhaWG9wYlFlTkxLSDlJ?=
 =?iso-2022-jp?B?bXcyaGd5OHIzYVBBOW5EekV2VE9oYWRTamdEaXI4SEIyeXBzY1BNcTE0?=
 =?iso-2022-jp?B?bksrNnVJclVHODFSdnhwV3lOTWZURUZSa050dkp6clVwVGo5ZWJEVFVL?=
 =?iso-2022-jp?B?NmJ5YkZCVnZMSWRFQVFDTWZQNE15UTkrOGlSZEE0aW51MnlSd096Vm5F?=
 =?iso-2022-jp?B?MCtPR25Ienl2eDhTYk45VUNnajR1SkxDOSt6L296R2FCTm92ZGtFOTFD?=
 =?iso-2022-jp?B?VGptSXQrQms4b05ZcmVTNEgyV0orTFFURWZKbkV2R3VMenRNUWhJUi80?=
 =?iso-2022-jp?B?dWx4UktzVGFoRUMyMjV3bENjRm9GeVVKOW1QNlVjODhidTBqQTBlYWxJ?=
 =?iso-2022-jp?B?Zk9xd3g2VzIvcDFCMmRvT2UvMCtZb25iV3o0VnRzR0QrWmJxZkF1aHlm?=
 =?iso-2022-jp?B?Y2N1SVk1b2RsVEtRcFhycVMwYld2RXdrcjFJeU9ZNzF1dU1RZGxmb3Fy?=
 =?iso-2022-jp?B?emNoekFRT1FTbXV6Q2ErRVhyc1c5cSs4RnZQRGtUK0QwMWRsWWRONzl0?=
 =?iso-2022-jp?B?dE04YWVXeDRiR3RSRytHWWtTM0pKM0oxTzdOWW5JdEU4REhERHJldG54?=
 =?iso-2022-jp?B?RDFiUnp5Y1paRFhYNzUyREo2cklURmRPb2VxVlJxUmpBSWxjd2drZ3pM?=
 =?iso-2022-jp?B?VVVZYWU1bStUaU1PZm5WMll3OTJ0NHRNZFdDQ2xwSVBDc0s5YzBoVkZw?=
 =?iso-2022-jp?B?VFZ0eWRkWEd3QW5oM1NnV09kVitFMnFWTm5JdG5GN1VZRzByMlpkQzNN?=
 =?iso-2022-jp?B?QTNIQ2VvdmUwcUpNTUZWYWVMQlZid0ZJRy9jZ1lUN2dlUldDYVYvNmJs?=
 =?iso-2022-jp?B?SlFNaWNJMExuWWpLV3hFdXNuTzlRVW8yNVJYWjI4R3k1ckhnMi9LZVVr?=
 =?iso-2022-jp?B?aXlFZUZNM2tVTEduODFoNVIvSDE1NVgyMXM2V2ZXblpCNzNFREtUVFJr?=
 =?iso-2022-jp?B?ZVpnQ0U1VXd0QlRLK00wM3dLVUVJdkxaYlBDTFczSVVVNCtWTmhJSUxB?=
 =?iso-2022-jp?B?S1E4U3FWdXB5UVBPN2xtSFpYUm1ZUnpsejdTZUk1dnQ5ZTlsaC84RHUv?=
 =?iso-2022-jp?B?WHNyeTNFUUU0YlVYRjEzdHQ2eWhrUXlaTm13YS8xMzlBdUtzdHIvcUht?=
 =?iso-2022-jp?B?QWtsVkEzbUNaeElVcEVTbnZaMTVsMndpUG5YN0VaSnZUWW51d3VzcmM5?=
 =?iso-2022-jp?B?bkZRWWlrcGthVFNuRGNLMm15bnA2SDMwcXlzSWZLNW4zQ1I2aDNxdVVi?=
 =?iso-2022-jp?B?TEZqaGdlM1FGczFDUEtpTnQ2ZnFCWGFhYW9jYXAveDRZazdQNDFrN0FH?=
 =?iso-2022-jp?B?QlhMRFJYT3U3aTNYSGp2ci8yb01GenR6Q2pLTWRaVFQyWlNmS3B1UExh?=
 =?iso-2022-jp?B?NkN5b1JpRklnWXFTK0dZaGpMa1pOZkJ1S3lzNUxSVm16Q0NPdWhTZTRH?=
 =?iso-2022-jp?B?VXVXY2l1ckhEL1FSN2gzTVNzYVdzenlaRm9TOUhPNTJVS2JqQTRCMWZx?=
 =?iso-2022-jp?B?VFRkUTNCZTBuL1NiWXdWZnBTUlNMUUtQMGJQeWEwNUlDT3ZrdkVrVGpr?=
 =?iso-2022-jp?B?N3NyOGJwZlMzQ21qRGw4SnN0dGdITjlYamNFTmljUGNaVXZ4NWpjTnBU?=
 =?iso-2022-jp?B?YmVQT2NCSXJ6T0IwTVNQTEtqRnhNRUF0UzM1alN6T3BpSlozVDdBY1Ro?=
 =?iso-2022-jp?B?QTRsNUd0SXNib2pvVDkrTHNmMnByTFJ2RHptc1JuNHpHZHhESHhaWFZL?=
 =?iso-2022-jp?B?UC9xTmNVa21aTWZwL3FCMHVpYlh0T0U9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L2t4SkdQSkhOSkVaUGRJakZ5SkliWUJJT2hWZ3l4MkFadUlCeWd5dFhZ?=
 =?iso-2022-jp?B?azZFc2RHWXh4MXhzTkxMemR2cXdsRHVpZ0JtRzVmbzlMM1lFQmlRZXlt?=
 =?iso-2022-jp?B?Z1h0TjJJNUxqRXByck81Mkwyai9wMklBNEo0K2dhNWVxcnlYR2Fya3lj?=
 =?iso-2022-jp?B?aW9yRWZDMzRmbFpRWjYrTi9Neit0cWZrNmI5WDdMUTNhQllHL3c5TTV6?=
 =?iso-2022-jp?B?YThZbTh5djYrbTBMMXRSblIyMGxuUnZVL0dqa3N4NlViN1pHcFJIVW9n?=
 =?iso-2022-jp?B?ODBGd2IwY2J5NW00TGlydUtMVFZqR0dwRVpRSkxwNnZ3RVFyODNPbTRC?=
 =?iso-2022-jp?B?KzZGT1RhYW03OXV5aFI3SVdic2pVVXhpOW9vVVdibGVGckFqWDMrQnhE?=
 =?iso-2022-jp?B?S00zVGgrUGMvK2VRMWlvcGFqZmJ4RGpWallVdmRBV1g2WVdQMVhMT2NO?=
 =?iso-2022-jp?B?VHNyc3U0RTMrWWVpMldCMldWRjU1Qk1SNU1ZWjEwYlBOOWwzd3dXUmsy?=
 =?iso-2022-jp?B?WTFiU013b3lXL09CRG5QaEJzWmdJVXUwTkxmUUprTWZLanJKYUpiUHZJ?=
 =?iso-2022-jp?B?V2s0Unovb01pa1JDekNzUkxNUmFaVFhsUkpDNWNWVGxKV205SkNhSTNu?=
 =?iso-2022-jp?B?T043c094MTJmREN3WnVuMWQ5NjcxY3pLWVlHcnp3djdDYkcwNS9Tc0pR?=
 =?iso-2022-jp?B?NTRTU2JvZ0pKMmVSUElnMWlUVVE3TXdHOENnQmpEV3JnSFZFelVNVTds?=
 =?iso-2022-jp?B?N0Y3eGJWYVprdVMwZWs5akp1ZDBBSjdUQklBTW5iOFAxb0Jzd1B5Lyto?=
 =?iso-2022-jp?B?bG5iZXo5bndoQ04rd3V1bUQwcVFvWHBuaWM4Z0RDZVVzT0x0M3VVNkhF?=
 =?iso-2022-jp?B?c3FpYkpnNHJwOHJiZzJjNlRmRkZ3bm8rQm1oZDhNKytFa0NvWVMzVk9H?=
 =?iso-2022-jp?B?eGpFMFdBYWc1UitPYjY0Y29tSi9QMUJWL0tSbFRlZm5vTE43aDRRRGVT?=
 =?iso-2022-jp?B?UWQ4MUFMVWJ3SFE2T2hXU0I4Wk1FTy85ajA5ejMxVU9acGZqUUgwVTV3?=
 =?iso-2022-jp?B?eVpVWkRvUFU3N1hUYWxKWVprbjEzWEt5U2ptRXRLazBQRjZ4Y1c1KzYr?=
 =?iso-2022-jp?B?bE90MGdrMTc4a3BxZGdySmlxWXZacGR0WUI0aktsUFhyZ0lLdldWdDBK?=
 =?iso-2022-jp?B?N1BPT2ZTOXY5NlZvZ09uRXRST0NOQUxXWkxxWDZSZ1B2L2VBWEpBc1Iv?=
 =?iso-2022-jp?B?NEJCVDVmdVZ0WGZ5ZFpxYU0yRUdpQi9kemNEV0F1MFBJd053K2g2SWFP?=
 =?iso-2022-jp?B?bmVBZU9ObTRHNTN4Z2kxUzBJakovMWFBNEN5end1R2VFMnI2T0NKMjBL?=
 =?iso-2022-jp?B?QjlMdXRLUU9CR3ZlSGpXTzBjTzZOTDNoM0hmakxVL042czhFVjRKdWNE?=
 =?iso-2022-jp?B?OFJjVWloQzZXdnFnNnA2OHVBZk5oRWw3dUZub2RkY25QekNYMHMwNkZO?=
 =?iso-2022-jp?B?NGNSV0xGZmtyTHpBNUw4MnZHNTdWYXAxOHl3c09NSU5YdDdDTmpxTHRx?=
 =?iso-2022-jp?B?Ungwb2MxNkJucXJYME1QTlpLNGlKenBFSDYyNlYzOEQ1Q2g5Mk5ZMjFo?=
 =?iso-2022-jp?B?aCtrOXh4V2hvRUpKTWR0WnkvRmR0Vm5STUlsZzdrN0xkT1lMYzl0L2lF?=
 =?iso-2022-jp?B?WXRFZEY4eDlsYndDVGFaR24zUFN4cHdYSXRCeG1BUVJnVWdwUE1OeGRI?=
 =?iso-2022-jp?B?bDlUZTVwVkliUHZreXVaVlZ1VThOSWNTV21yN1dwMUs4NlpPSHNvOTB4?=
 =?iso-2022-jp?B?UnlqZnBjTitCZnhFOVpMVDRLekVRc0VoWkVjVmxyekYyemlFMzhuNWJT?=
 =?iso-2022-jp?B?NnMwdDVjZ0xVUWtuUzFRMFNDd2F4L0xYdTdBWHRWUGQzeXVnTDNrbklN?=
 =?iso-2022-jp?B?WXVTVE11ZHE2SGlzS3F6MGRxeEJUQ3BRSzhEdWNvaUpzMjQ5KzI3T1d1?=
 =?iso-2022-jp?B?ZHBBZWtyeXVzbEI0WnErRTJlcW1GMjYyY1l1M3lQT0dCQjNJc2ZENkRW?=
 =?iso-2022-jp?B?YzB6MVd5VjlLNkJlMGdxdGc1ejAzTmY3QUc1U3gyeXh6bU8rc0pmRC9v?=
 =?iso-2022-jp?B?U3MwN1k4Z2FxNERnV2tXNkM4Q1hWRW1NeHZ4d2pIcVZoalhRS3djQkFL?=
 =?iso-2022-jp?B?ODdxditOWCtyRUc3eGphK1VQNkRrcVA5UE5zOTJ2UmdWRENibk82MTlN?=
 =?iso-2022-jp?B?R3ljcVFCSldtK21Ld2RFcXZnSXY1YXN0RlNCQUIxb1VtQ2VPSUdnVWI5?=
 =?iso-2022-jp?B?aXV2LytpS0FsR1hPVEdlTmdzdzZvamszclE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b6b3fb-01a2-4e3c-5dcd-08dc9f18c7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 06:39:56.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMjKyz02q2qSaI8iIdTKsFRiceR+idpkTN0DAsuCqhw0KOqL1r8DamF9Hgla5DQBpupZVZWy0agOharvCNnJee6R3qCGd/FpYyU+6TZevIb7bPhaEMaJwHqZCWPCo4F5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 06:40:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16425

HI all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Friday, July 5, 2024 10:04 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
>=20
> Hi All,
>=20
> This patch series aims to add IRQC support to RZ/Five SoC. While at it fi=
x build
> warning for RZ/G2L CPG driver and fix for ax45mp_cache driver.
>=20
> - patches 4/9 and 5/9 have been cherry picked from -next
> - rest of the patches have been cherry picked from v6.10-rc6
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (1):
>   irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
>=20
> Lad Prabhakar (8):
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
>     interrupts
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
>     RZ/Five SoC
>   irqchip/renesas-rzg2l: Add support for RZ/Five SoC
>   irqchip/renesas-rzg2l: Reorder function calls in
>     rzg2l_irqc_irq_disable()
>   riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
>   arm64: dts: renesas: r9a07g043: Move interrupt-parent property to
>     common DTSI
>   riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt
>     properties from ETH0/1 nodes
>   cache: ax45mp_cache: Align end size to cache boundary in
>     ax45mp_dma_cache_wback()
>=20
>  .../renesas,rzg2l-irqc.yaml                   |  61 +++++--
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   4 -
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  75 +++++++++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  16 --
>  drivers/cache/ax45mp_cache.c                  |   4 +
>  drivers/irqchip/irq-renesas-rzg2l.c           | 158
> ++++++++++++++++--
>  7 files changed, 272 insertions(+), 47 deletions(-)

I reviewed this series, I don' t have any comment.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


