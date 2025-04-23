Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5299FC369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 08:43:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.3728.1745397797031847041
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 01:43:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=SyjeW+IQ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1745397782;x=1746607382;bh=j5oFhnPyK1moIJOsnnOdwh6GjN6Vf9GUxl6W+F1
	zSzA=;b=SyjeW+IQwtZOWFPPfV0sQV4Y1YpKrb4lt+Ftc1eS6BsNggX/LFo7TD8H/yLarl4eNUnVx
	F7GTZbwVAMBtxHxkGlWE1hnWjVLovsHUeLzYFvV6vOk3/55LVH11JaPJ8VuuMEbWK0Tu5300tPa1a
	3/M4K/WwayauxN/89jmy5fqFu40oamIE7RFuErbeEFJ0yd0J3b5TkRkrwYKcn2zP/6TZP4AFkp57h
	e0WX+pUsRcevj1SpYSsSLTbb0rUgPPDqd1krjbPoqdC4oO05JoCEspbtihy1Ds7vqU6TNP8b0l/C7
	U3pUHK/wYzLBE8CL2yKbVWvOWz/th6t2Jy9haewO8A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 53N8h1vE1340889; Wed, 23 Apr 2025 17:43:02 +0900
X-Iguazu-Qid: 2yAbyr8UpuliOA5adG
X-Iguazu-QSIG: v=2; s=0; t=1745397781; q=2yAbyr8UpuliOA5adG; m=QBGMEuJukYMU0oHlTNV9a/2rA7BiJoImUqftjWsOFiQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 53N8h0th1382816
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 17:43:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/kkMbNbvTar1/GItUImGHrL4JSb0n3lu57NbxqmK/3UsyuuUfOyDZVx/Whwhd078yvcCGqpbFBtQitfN0gm+NKmfQFg7k+CcZczsYpUUFtksPjOYNn+dTVxbkkeYXJrV0+4sEBEWXjRoYmbZWOnV6xDx/txeR8HtosHZroAnXbsheHBM+NLRETetEQHFRt5gGGbCyfA6wFo8m3fKtcJe5BqlcEc513YSQtf4BzDaSBixigvhehxz73KNtMstlQw4LWxHgG2ANGnendE5Ay0ALAtOw7RNUNYQ2Yz5c71wmiqtTH90Br10MwLP60GX9ggpfCpYJDou+f5uYdUSqrRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cfUdJiutYcSuDlqZ5qeWEbZVxB/pY3cV9gWa6QP2Hk=;
 b=TF/C/zvl2l7UsRNnlp3TnQzS/Q1fM/a27T1mEpH1eBnNKrMUyPKseK5o6sbX4flN9fqwNo/bCXbQNBalmN3SPJ/nTijLLUdVcknugQFBShv4idWOQbR1N58o7pv5WVymlqmUGQhWzPStGkywOZlIQ/ctp7GxljmZrEBR2rd+2h3DlIp9YeMy/iEJ2ujmi3oUmn2he3iFfssrBU0J4/QI+ZknxTSCVHFNZAgUIpfUxjwF5dMf5Er7GvoMAnK5+c+bBDwJSmQN/XH2lTlegXDKXHoaZKt4hH4KPNLI21xKRgOr2oDfxtHxNUNeYzKuYGMMyvuYen4BSxj2HAlaNH+kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Thread-Topic: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Thread-Index: AQHbsut7sTKLCk/5rUKvAwbNCsAwHrOu59EAgACOewCAAXsT0A==
Date: Wed, 23 Apr 2025 08:42:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808050F4F8E55E820FAFC8092BA2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aAdp5jO3LmPfci7Z@duo.ucw.cz>
In-Reply-To: <aAdp5jO3LmPfci7Z@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYWPR01MB8329:EE_
x-ms-office365-filtering-correlation-id: 2b51a940-bd4d-4df7-d7f8-08dd8242d741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZExQRWJZYk8xTVpReXlnVmZBTS81SnFZYlpBd1k3NE90L1FFZ203KzNE?=
 =?iso-2022-jp?B?NEhaaEhFN0MzMnBBQkhreEFld2tMU25kWEU1OHhidE5TZHFiazVUNUNx?=
 =?iso-2022-jp?B?YVpRZUdYZ1pjVkFBRlJDNk5OVmRPWGc5WklaT3NOQVppd3g1bzJsZzFR?=
 =?iso-2022-jp?B?aGgzZ1BnR3Zpai9TS3o5cWRnbDhFSTRvUTJxQStwa1FpNlFMZGQwaU92?=
 =?iso-2022-jp?B?MEVFSy9PSGtRRTludkl0NTM2YjFEMmlvekx4VlQ1b1hGNTB2WHZJaFNz?=
 =?iso-2022-jp?B?MnFqTll0SFFTZGgrQVFoaVhZL1dCWFkrUm5iaW1La1BwOEkxdHM1RmpX?=
 =?iso-2022-jp?B?bDFzbCtlNG84Y3N5YjdwU0Z0N3NwOHVIa1AxdXdER0RlVnVERUlZWFRr?=
 =?iso-2022-jp?B?MGN1Q3FLZFlUYUJKYUkrWmJab0RtbUt6cHVqQXpaRnVzaHNFQUxRUncy?=
 =?iso-2022-jp?B?Z1cwUStGZmMvV2RqaXFhRU01ZEw3SlZnNVRSOTlEVC90U2I3Wm5UWElt?=
 =?iso-2022-jp?B?cHJ2ZVVrVXVGbnVZbGk4TWNlMFcwMjVKRDRYclBkaGdkTzRsNExHNWJo?=
 =?iso-2022-jp?B?enVPN3Nmek5wUGJoWGZKdGpYQmNlNVBXYktUM0pFVGFjUWxxTHFpTzYv?=
 =?iso-2022-jp?B?Z1Q5TEd3Q1BkaVZUWGJRcFQ2L2JWdHN0b0xNekdGdzRWZzJXamwyYktZ?=
 =?iso-2022-jp?B?WUMyQmlobFltdHNMMlJPNTJVQ0xweFJXTG1CY3hYWktiRUVqWEdBVzVp?=
 =?iso-2022-jp?B?Y3BxUzhTTmZabU83SWIyYUc2YjFIQzJGdWxwTE9SUzNYR2tmOFNKbzE4?=
 =?iso-2022-jp?B?L0FWeFppL3BBN3FTZ3ZvYkZ3VEVQR2F3WThRWlRxaGZLaGQ5VDJweE96?=
 =?iso-2022-jp?B?ME1PamlvbUUyRnVwTXRQUU9HcU9ncTdxZTM2QW8rbkxSbktZck1TdVZY?=
 =?iso-2022-jp?B?OEY4V1lrVEM0K25wTGJrVDV5Y2kvV0RUU2RTdmxOd0xyMldNWDd5T1Jx?=
 =?iso-2022-jp?B?R3A2QU8xd1drOEk1V2Nvc2pVRlZlMk5iTytKM1pBb3kyRVVyeHNwd3R4?=
 =?iso-2022-jp?B?dCtCVzhhN3dSaWVidjU5dGpyZGRabmtaQ1NQTHp3OWJ3WmNTb2pld0Ur?=
 =?iso-2022-jp?B?WlRQR2FVZm9OaC85RWdQY08wM1JkbDRZZEJaVkh6Z0xVSDQ1UnF1THR2?=
 =?iso-2022-jp?B?M25NQTlmNDR2VW1BeFlkTmVJVnpWNDFJa0I5U3kzTDlDTlRzOHFZdDkz?=
 =?iso-2022-jp?B?OG50Mmd0eXUzY0RhMEFtSFo3RFdKNTBpL3h3UUJtWlVJU0VldEVMbDMx?=
 =?iso-2022-jp?B?ai80enMxRTkxa0Q5bHVGZlUybDF3aytpZXgxRThUc2lQM0pvWHh4MEJw?=
 =?iso-2022-jp?B?enIybmdpd0JqQU9vSHN1MzdEaHF1c1hSM3dEUXI2bnRpWDFBMnViZmxC?=
 =?iso-2022-jp?B?UG1qSTNWVHRHcEVhQ1ZiaEVSSjZvRW1jR2lGSks5U1JWc2d6ZUM2aTMw?=
 =?iso-2022-jp?B?bkl0MElrMllPamlkeHl0b1podjZQNEZmYjk4WEs5dU9sMDhFSGpaaGhs?=
 =?iso-2022-jp?B?aW1JZDBEcng3aDdZdnVGL2RMaGdmQVNBSHRiU1MrUFBTOTdoMDVnQ2VB?=
 =?iso-2022-jp?B?WXk5aHdYeEJHRmNYazlNaGwvU3hjZlZEVnVPZzdBRGFpRVVyeDE1RkJj?=
 =?iso-2022-jp?B?Wk5yRXNKK0lmQVNzR2NrVlh4QkJYeGJuWXp6STcxMys1MmJrSUhHcFVW?=
 =?iso-2022-jp?B?YlhXQ0lsSGt6VXJpY0F6UzQ3d2ZydXJIM3RBS2p4cnNINjlnSGF5VEhm?=
 =?iso-2022-jp?B?SlRUeVcxakNrSDdPbjhuMnZzZXlQMFpoOWY5Skt0UUsvTXRNN2hHaDJk?=
 =?iso-2022-jp?B?RXFEaHcwdlZzUjBYRTRuUjhvMks1RG5vUzZUWnNTWVRFbzFUcDFEcXg3?=
 =?iso-2022-jp?B?RnFRcjdHeHdDTFI1Sm9OREtKRm5paU5yTnlkREp4Z28zZDFpaVF1ZjU2?=
 =?iso-2022-jp?B?YmtzSGtra0dWWHNnTVJoMGNmZTNKb0Z5RzMvMFBpcVU4SDBXZ3duZjJj?=
 =?iso-2022-jp?B?UnppVk1sdmFIVy9EZUp5ZFVaUzEwYkk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V0diOS9jdlAxRmxhVmdSOUpnQkJ3UlBlN2JsUkhGYVVldlU1dUZ4ZHgv?=
 =?iso-2022-jp?B?ajVaZWE0b05EeGJYK1FidjBwZEZtazIrNXdXUEtNcUVNRXBRTC9xR1Fn?=
 =?iso-2022-jp?B?dXdJYXJXYlhQSDlldnA5cEptUHZGN3VuT3g5Mi9iYSs4K1pURCtZV3VH?=
 =?iso-2022-jp?B?Rk56MXpsV3pXNWVqNStiSWplV20zaXdYSEtoTXRkcjl0SDRSWnFPNDhV?=
 =?iso-2022-jp?B?K0ZTaFB3OFQwajY5TE1laFZBeEFqamJ0WFlXZHZZTVlsY2pxSVY3V1NW?=
 =?iso-2022-jp?B?SDk4cEtEcXg5cFR2RjhsWlZCQUhyUFNZenZJRFI3ZDNSaCszclRWQnds?=
 =?iso-2022-jp?B?TFpoSktvMGFFRU5vKzRrbS9BbEg0YklhamhSMmV2WkhCK0w1T0lFSGV5?=
 =?iso-2022-jp?B?RUtFZWFLM0I1RU5hYW10cUYzb0k2ZDQ4WWtLZVlxMmQ3SGhNdDR6QWxB?=
 =?iso-2022-jp?B?am1kYyt5OTJNSFVKc0RNaTdxaUlXRmM5b3NwTFhsYjd3Nk9QSENZMHZH?=
 =?iso-2022-jp?B?YTRpalBIVEZzN1hrS0hjTEdBc3BGaU1MRVJzQitudHdtTDRBUWkyTXA0?=
 =?iso-2022-jp?B?L1Y4TnZpRUpEcGgvK09OdngxL2JPQ3NyODVKK250Z0xuWHo5T0ZNT2pa?=
 =?iso-2022-jp?B?Qmo3WmJzOHNMNVUvVEt1S0hGOHQzeXpralUyMWcxb2VPRmg1L0JtVTFT?=
 =?iso-2022-jp?B?c2RwVVdHc1dJc3JTRUU0K0JXZjQ4b2FOckRSYW91RFR1MkQ4VGttUEJ0?=
 =?iso-2022-jp?B?Wno3Qnd1RG1xTXlRK1FvNEFxWXFLMXByRVpabE5rM1RYVkZud0YwV3VY?=
 =?iso-2022-jp?B?SmNRNmR1TVhHLzBjZlRyd3VTb253dVVVL3I1S3Y4eGU1L2gvb1lYaXg1?=
 =?iso-2022-jp?B?aTF0TUE1Mk9FTHIzMzZmaE5Gcmw5eXZ4VDd0RXphVGlxczdJcVR5S2JQ?=
 =?iso-2022-jp?B?WnZVcGtENGVYTVhpbWRqN3FncytmZVdnQWxNUkRkeStQMjlJeFloQStS?=
 =?iso-2022-jp?B?bFRRNVFUTm83SUJ2bGJlVVBoM3JoSUptRzNwNWM4cUVwaEJFNWdBd1Nk?=
 =?iso-2022-jp?B?MDNKUmNUeWVjR2RYRTY5YnN6OVFiRG9odjQ4b2xpM1BuWFFneFcrOTVS?=
 =?iso-2022-jp?B?RHdVNzVONjBWUHJIYVhpSm5BbjZLT0lxcHRxeFlFcmZ4cm5OSjNHRjU1?=
 =?iso-2022-jp?B?ekpkOWt5STJvWTBGWmdLdzhoM2g1cWxMV0FrQlp6UWNxNUpMKzhkSjNM?=
 =?iso-2022-jp?B?UmdjNTNCVUh5THF0NWlPZnQyR2dqUTY4ZW9JREpwVTBkdVBUMEtaMWtl?=
 =?iso-2022-jp?B?TDhhNzJGd3ZlazhNMXF1cVlIYlRFa0FzcVl5NElka0w2L1pPcnluMFZF?=
 =?iso-2022-jp?B?SjVwUFJSNHp2YlpENEdieEVQa1lDUzRENFZLZFFJRlpCemN1bksreXdL?=
 =?iso-2022-jp?B?V1dGNHdMaGNRdXRyOXRFeHVPdW0waGxVWEcwVTBaSDVBSzQ2eXFWTVVj?=
 =?iso-2022-jp?B?QlA5b2pzTmw5a0twanRtdDIxc2JHUzNaaGU0ZVBHQ1AyZDNmSVBPLzNx?=
 =?iso-2022-jp?B?aHQzOXhraFJwWFpJOTZrcmVlc2xHNDREa2x0YVlZVzBoNkNGWWY1aCty?=
 =?iso-2022-jp?B?cHdlbjl5Ri9Ea1N3czJCT2x1TmtCa01VN2picVhobXRUdTFrVWhNajJj?=
 =?iso-2022-jp?B?d3pxVktRU2IraUtjc0NSTm1HYUJOK3BZOGNYempqMndpVEFvWW1reStQ?=
 =?iso-2022-jp?B?RUprbkhnY2xzUzNqdlNob3lIWHJ2cFhvcTRBS0FRZVVkRzd2YUJxRVU2?=
 =?iso-2022-jp?B?aGtZUzRKMTNGMWV6cGV0a0lmdTdKekwwZ3FEd1pZSndlOVcrL3FRUWV1?=
 =?iso-2022-jp?B?ZzlYdThNenlZVjBERWVVeXJrSkIySjh2bHlnU0FqcGNTWFpjYUdCV2JD?=
 =?iso-2022-jp?B?eVJjMzlDUmRvOUFYOGROMG9zNXdGQjJuR1BiN1Vja054VzVoUnpQcXFG?=
 =?iso-2022-jp?B?NUYrY2NnaVlSMFE1U1grWEZwK1NLWDJXUUE2TEk5L3hrMm1tR2ltSGNn?=
 =?iso-2022-jp?B?eWwxL09XNHYxeUJsVlZ5b1RYbzg2Yy92ZUozZldIMFB0a3YxQzVnWmEv?=
 =?iso-2022-jp?B?MmZ1WFVIN1FxR2Z6c1JsZ1g5VTRFOEtMcWF0OW5zZ2htNVYraTBET1Z3?=
 =?iso-2022-jp?B?UWJIeUpuR214dHBIRzhNRjNHUmJTaHpPbGFwWDg0TUlidHcvQkF3ZURy?=
 =?iso-2022-jp?B?b3VScjhuV2xqUU1IWHRzOEU2WExkY1JkeGZ0NjRWbDMvc0thQkY1Vnln?=
 =?iso-2022-jp?B?cStyakNUU3YxL1ZDMzIvMGw4V0owWFpkZVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b51a940-bd4d-4df7-d7f8-08dd8242d741
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 08:42:54.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZh6l1qI0ARXHwM6Zdy5OvRszEMERGJ1F923181wuch9FW4yCDGg6AfHYDZJLV2MMdRvvBsk+F2lYnn4srVJw1s+K9I5NFaldn1lcG/3qnQ6dv2zCq7bNF+j40s0MfYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8329
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 08:43:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18564

HI all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, April 22, 2025 7:05 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g;
> biju.das.jz@bp.renesas.com
> Subject: Re: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock sou=
rce
>=20
> Hi!
> > > Claudiu Beznea (1):
> > >   clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable
> > >
> > > Lad Prabhakar (1):
> > >   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
> > >
> > > Paul Barker (1):
> > >   clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
> > >
> > >  drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
> > > drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
> > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > >
> > >
> > > base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc
> >
> > I reviewed this series and 5.10.y, looks good to me.
> > I can apply this, if there are no other comments.
> >
> > Test:
> >
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/177888521=
8
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/177888
> > 5853
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks ok to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
Thank you, applied.

Best regards,
  Nobuhiro


