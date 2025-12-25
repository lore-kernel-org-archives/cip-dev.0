Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC4E784AC
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 02:20:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.131979.1766629230380295058
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 18:20:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=gSEzJzmR;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766629218;x=1767838818;bh=iPf1GjLfPVklIiyQ/C9EVIa331iQUQaaiTSS5
	Q20nmw=;b=gSEzJzmRSdj2GRSQwLLV0IH/HfhNsKqmklIhkwa7UCDR+nNjgPcWx42aLiCtBxM43R3
	cYXDGXQgnmwImS8M0GlWM+tJg51QLjU6lIg6ufYSJ9szB/7PUsGjEwUPwr1aug0l38f46DbF0oRP7
	BrrHtg/rPyWC2u40kVg2DEimDhEXq4Cc1Ph11z+kDEmyJUcXNASG+/S1vy/gaIPDbBdsagxfpa9sL
	lXkwwetk/dJ8kQ3sRVYTAEVdrs0uugjleQzFEUPV0rKqqjWT5aivdxyd34/+Z0EyOMHCmp2MCupJt
	zVzmgT95vCq79C9IsriGTZXZg4w9vIsee2gMBqdLyrtA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5BP2KH1e3641585; Thu, 25 Dec 2025 11:20:17 +0900
X-Iguazu-Qid: 2rWgIwSDEULUrAucwa
X-Iguazu-QSIG: v=2; s=0; t=1766629217; q=2rWgIwSDEULUrAucwa; m=fk4Ab2EPncfbgOuvu7CbEVHqvxb7PhO92O/996FqhiA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dcCBm45x6z4vym; Thu, 25 Dec 2025 11:20:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CknUU0jD9HKu4884W9J9N4IYA90+hGEJY/VxdK7r+0M0RgCWcRkCbQCes7C8tMdpRaJl70CHEVxPDSeMYDCanCJOlV34/zDJhXyCnm4dap6oyXHtSo6psl5gxwttYvsgvBOGH/CXADqJVFwpxxoc6GRXvEA7j1yOA4Tf0iuRUSJyhx1DJHsQGKWL5c8fuf46Ilt445FXZhwSIj8xTEzvcRNZBVQnzL6Xa9exA0RCVfI6pxJ+KPrXPsye2deLN2z2Swa7/B+7NfNobXWy5gXtmRBhAc1AEk36QavV3QD4Z8cu3tayxlL+nS56pEca2Sc8daEz+bXj2lo7Zw8R56mChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPuCEo+JFczq8f9b0p5aXuieqQfCk5Y9bguzVzXaRUc=;
 b=KtGMQ8nCdl7E8jjNglktx/xdB6teFLQHvT1VL94BbBpVr7F6mH2Uz9okyecBmtta6Eol8jpLiUkq2QOtok9jbSZoBUyXi5kwnaxdPjzKP4roPnAxIRWOeHCr99SEMV7UbWWPJb3fJe3n69cJeyPS82fszvlm1KVMqi1Vx2FSGvQpmqkKCt0CUT3y6ETElVyYQGY+w99/wj1JIRAcBPGBfOuyx2JSah+A+teP4JPYoyhCrRBTXbETgrOqfwCwCsJ9Ks7Teo1jZUcgCOAGBmu/+0Elw7gfH4WTiSc52y7nqBKaQK2dQixwhgLkSHuHjmbhzufJFa/unYhbRLdmICr3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
 where one address is zero
Thread-Topic: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
 where one address is zero
Thread-Index: AQHccxkBwEWmW2YtGEStGoEfrZkWNLUxo2FQ
Date: Thu, 25 Dec 2025 02:20:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C473B91740921A3069E3CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251222075949.58472-1-ovidiu.panait.rb@renesas.com>
 <20251222075949.58472-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251222075949.58472-2-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13047:EE_
x-ms-office365-filtering-correlation-id: d5bc49bb-5159-4389-17c9-08de435c2312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d3N3N3NUdnlwK051c09rNVdaV2lETkFna1JOWTVvZjlzbUxDTDF0S0lG?=
 =?iso-2022-jp?B?anRlUGc2UDBFaElrTGhBM2FVVnROalV6WWxIVVpyeVN6Qk1OZHNuQ2hQ?=
 =?iso-2022-jp?B?UTd5V0tPWTJnRDJqd1JTSWc2a3dQZmRaVGozNS9PMVIwc2RIWEtId1h6?=
 =?iso-2022-jp?B?M0pFMndvU1JHN0xCWXhKTDJRUlBZNTFUdk9Gc1c3eHdzOGRWL2JUZ09E?=
 =?iso-2022-jp?B?OUdlSTZRV0I5aXhocnEyN0NFS3N5MmF6eDgzTkN6RnBnZ1gra0VFaE1W?=
 =?iso-2022-jp?B?QlR4My9na3hCUjhjbURPcTViVE5wVWNnYUFnTWM4NG1lTmVhM3BBWEFE?=
 =?iso-2022-jp?B?anNJY0llWFNuQmt3dnVDaXB5QlIxeURWazlVN0IvVWFFcUtndlIrd2Fw?=
 =?iso-2022-jp?B?cWZNWjlrZkpXaWkrVmp1dFY5T2l5T2V2QlhWVHlwWWtmSnVIM2hlU015?=
 =?iso-2022-jp?B?cWNEZE1qbm1IcHRyMk9rb2szbElBR3crSi9lcE85akk3ZkpnTnFHTmFs?=
 =?iso-2022-jp?B?enFHTWwwYlF1WjZkRCtsdjYvRGVSQjJ5RWtWeFJET3Zjd2dqVmNGR082?=
 =?iso-2022-jp?B?eDRnUnN2WDJFTFJyVGZ2SVp6ZS83andCYWt6eG9zKzArSk5LUUhIalli?=
 =?iso-2022-jp?B?anFyMGhwdnVZYXlhRjNjRWdDV0Zha0JlaGdiQzlsUUhSeHZTeUVGOWlZ?=
 =?iso-2022-jp?B?ZitIbDZMVWRDSFlpaVIydjFGSFZyUDl0OFFOK0tJRnFCb1hKVmFoQ0xw?=
 =?iso-2022-jp?B?SVRRRUZhVXdRb1NPdzBvT1dOc0tzbzVSNlVTSHlSN1VqQWtzMkJCN2gx?=
 =?iso-2022-jp?B?L0NSUml5UjNFNDBEUXp5ZXMwYUpuZkhhNmtKYWl1R1l1VlBqc09DTnhq?=
 =?iso-2022-jp?B?QTZXWllZbnEwM2l1MUEwdTJ0WkI3U1cxZjMyMEk0UHhsbHppYnBRK2U5?=
 =?iso-2022-jp?B?U0RldGlaUzRZTTIyRzUrWmtIQTkvOGNOcW1aTEsybzFGbmdSMFNUVnB1?=
 =?iso-2022-jp?B?UHpOb0p1enhPQkZ1N2ZaeitKZVkxcm9JRzhuTTJFREFUa2NYREwwTnJs?=
 =?iso-2022-jp?B?MnM2eS9TWVZRSFV5WXpVZmtBVTZZYUNsbmhERDFkOTd6N0NoaEJ6V1FH?=
 =?iso-2022-jp?B?amZ0bEwxNVlZUXlXaXJ1NjhPSGlvS0N2OUlJQ2R0dUJQM2Q3TWh1Y2tR?=
 =?iso-2022-jp?B?cEZUalBkSGlUbVNObGVxdnNDYUdQeTh1UVQ1VWJGVnE5L0RUR1krVmlm?=
 =?iso-2022-jp?B?R2J4K1dDc0FJcUtseHVMaXVDcUF5alQwWHJOcisvc1NjZzJlRFYxZXNr?=
 =?iso-2022-jp?B?akUwKy93UUttbGhrWm5qR0R4MS9uSUNncVRLQnFvcVNGNFRLRTQ2V1FY?=
 =?iso-2022-jp?B?THdJTFA2V0xSc2JtVHhDaGZZRWliaE85cE5Wenc2THc4dERUb2Vjd0FZ?=
 =?iso-2022-jp?B?QXJvNGY4dWs0MG9iWGxGbnJVN25DdE5lZnVQS2o3d2tUalZNRWdOdWRW?=
 =?iso-2022-jp?B?eUhWbjE3ekExUjRQaHI3cnN0Tmh0VzFBTGRSQyttYnVtQktNMXcwRU1x?=
 =?iso-2022-jp?B?dkMxTU5hVHFndWJFZUJLbWliRnFJTUtabGpzcVg1bDFJMmJDd1ZzM3NI?=
 =?iso-2022-jp?B?SUNMRWlvckRNODNqZnRjb3pQeGdGZVkvQVdidkRYTVFSU0FKNjhXTEY5?=
 =?iso-2022-jp?B?dWRCdlByT1QwWW1IZUl1N2xzd1djdkUxVmN4ZXVvNFMzS1NhZ1p0OEFY?=
 =?iso-2022-jp?B?TEkzNnlzNHZ5NmtFWmtMelROdGlPNDhNUmFSQTErelkrUi9ZQ0kzWEZN?=
 =?iso-2022-jp?B?RDlsNStPWVNtOHZwVGhKUlp6VWpJanVxbWlDZ1NhcHJjaGRjL3Zoc3Vz?=
 =?iso-2022-jp?B?ZHhpQmJ3bFJpdE1Sb3dBVzhUNWgyWXVWNWhpdWExVC84aHlISmR6SUtT?=
 =?iso-2022-jp?B?djNZZzJYRXZ3YXgydWtrMCthRE41VHdHT0ttUG4rdDBYTWx5WmpTUHRH?=
 =?iso-2022-jp?B?L0l3MzJRUXlNaXVUN2I1RC96N05OYjFVMTQ2dDd0SGNLRllyT2U1NHla?=
 =?iso-2022-jp?B?a2ZvdXROWGlrS013ZHgyRHJ4bEVWbGlSeGNYbUh1Y2J5dVNHQ1hyZlVK?=
 =?iso-2022-jp?B?Sm93UXYrdEdtZ2lSV3JxUFdsRjBNbHNkVWRTblJrQTJ4R3NBbXdSNDY5?=
 =?iso-2022-jp?B?czFEeGZDWjN5RFFnZlBxVmVZaCs0ME5D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ODNKU0paVGJNRWxzZjZFa0FqUFIrOHVKc3pYd1gxcmVySWZpVnU1YXBy?=
 =?iso-2022-jp?B?bzcwaWtNUmFjakJQdlB0K3EwWEYrdTMwNTgxZ3JlREpPRU1QZkFuazVB?=
 =?iso-2022-jp?B?OTdLRmtzbUVhaFBlaTRZbUZteHVzMUplUnN4NzdzWkF5TEl6VkovQk1X?=
 =?iso-2022-jp?B?VFR2OGxKR200R1ZSTXF0K1ZaTFFGN2orMjdQNjFqZDdKaTJpTVFwNFlZ?=
 =?iso-2022-jp?B?MkFBd0ZZbWNyME8veUM4RHI5M3pUU2hOY1I5VG0zSmtESlF5c2FUWGFw?=
 =?iso-2022-jp?B?cE8rSzZXOHFMS0tlcXprY1Bna0VWVjVoNXJlMTZtVFhsRW1LQ2pWQk5v?=
 =?iso-2022-jp?B?bTM1bVQ5NlFhUEpnTno3VFVzbWJlRkNSN1dQQW9tU3pWVUhNYzZLK21m?=
 =?iso-2022-jp?B?bnA2bm5sc3g0RlFDaVRFbmROYS9DeENaM2hHMGpRRUdUeEdlU01CNDRk?=
 =?iso-2022-jp?B?d3ZmUWJaOXkzM3NMT2NVcDdRcjlxcUtUcmsyb05FRVRuZC91WHVvdVRJ?=
 =?iso-2022-jp?B?SERITmt1bVhnNTdyS2ljdEtCbmZPS2hnVjROYU82SGduUDBmTHNjQVJH?=
 =?iso-2022-jp?B?czB2WEQ2ejl0dHpHNXE0TXMyTVFmREEvdHYwVU8xNU9TV0ZZV1pEaDdw?=
 =?iso-2022-jp?B?cElsVUZFdFBDajQzaXhMcXBZTkk5TmJzdXRxbjdIUW1jTEc4cGRLVlBV?=
 =?iso-2022-jp?B?aThWMXZVSzBydWxEQUZVMGNmQ3dqYkN2bElTWmRKZlRBVFBzZC9JOFhV?=
 =?iso-2022-jp?B?Zy9mck9SbW5rQzBOK1VqdEpmaEJHb29VMEMwc1VENnpPMnA4Vy9sbWJF?=
 =?iso-2022-jp?B?VFVaY2grdnZIRnRIN1NBZzZ1N1V3ZU5Wc1Z1TTl4OHJTTjcrWi8zVzJ3?=
 =?iso-2022-jp?B?NWxtMzhFcUkzNEJjYlMrbnZXbmJUTnd2N09SeG05aUxCRlcraXlzdnhB?=
 =?iso-2022-jp?B?eDRDaDVDQ251c2FzbnVnTVN4MWZQME5GZFZaWHdIeU13emk5Zlh4R2dO?=
 =?iso-2022-jp?B?NWdXb2gyM0k4OEZYM1FPZU5LYkFreUhZNXM1YXJDNjB1WUJaQ0JWeVBz?=
 =?iso-2022-jp?B?TVgxM1p6NW42SGcxcXdWWndLZ2ZiQW0rUkU3MEM4VEFIY2h3Z0pBVTR2?=
 =?iso-2022-jp?B?Q2ZIMXIxZ3BGbHhBWUk0T1dPUnIzZmxVL01XU0Yybkk2MDQvMDVVNEFT?=
 =?iso-2022-jp?B?RTdYUlc5WFJ5MnFTZDFjMjhhSjVkc3d2QzMwUE9nbXl4bG92SHpFai91?=
 =?iso-2022-jp?B?elFqUHdRb3EvUXl5RE1kRnQzaHdINFFueGptZnpuZVR4QndwcFBHUWpR?=
 =?iso-2022-jp?B?VnJFbEhtUzltOHNpNHY3Z1JBMjdIZ0pNMFd3eHU0cE41N1ZXaXNDRWZX?=
 =?iso-2022-jp?B?NGJOejFNcThJTFhkUWdqOGxyUEV4ZHNQckhGUm9xaFNabDU4ZmlIbTd4?=
 =?iso-2022-jp?B?dk9adlhsQWpQT1g4YU1uUGtpSk9ickhEVHFvUjBpTFd6YTJacWVmVCth?=
 =?iso-2022-jp?B?M1FHcGt1V0w2UXgrNi9STFRVU3dCOElNa29mQ1BxbTlQNEJRZTVKZXd3?=
 =?iso-2022-jp?B?bG9MMjBIS2Q3ZmQxbWpyN1RZU29OcGRpNDRDUlAyRXdycXMvU3RMa2Fn?=
 =?iso-2022-jp?B?c0Q4RWJlS3pPcWd6V0RRZXpsT3hWeE5Dak56UXp1VlJhOVlLU0JqbXU4?=
 =?iso-2022-jp?B?cG9manlJcVJKS1JMaVQ1ZDhncWladUpiMHlIdE0xTUxycytIR1I3Y09m?=
 =?iso-2022-jp?B?N2F6ZDRBaFNiRnEwSU9NenpIQ1BhaENKU3NCWU1CVVhkYTZlYmVFdmF3?=
 =?iso-2022-jp?B?NUtSUjFxRWxUNHE4ZUIzMHFPaVhjQ202WXVVUmZJNkEzdEU1bTQxWGh6?=
 =?iso-2022-jp?B?S015SUVselV1NVFWVjVmZkNPUmZmRG45RnIwNmhheW5jZWFjNGJ6Y2Ur?=
 =?iso-2022-jp?B?T2ttRTREQldxUkcvbXZGNnlPN1NtbkM3dGtLR0VycUhSTzk0dk5tSXVW?=
 =?iso-2022-jp?B?OEJScjlPZzlnaDFMdkN3c1ROWktEV291d1MwSjBaaUNjbUdUcWk5bHEx?=
 =?iso-2022-jp?B?dVRNbWcxSEN3SnErSTA2SFo4cGVhTExqWFdJbUNLOWpZY0VIRGdGT0Fk?=
 =?iso-2022-jp?B?M0ttSTExVi92M2t0WWN6Qk91K2duVnpzZTNCM1IwTG54MUhicHhORXpH?=
 =?iso-2022-jp?B?MTY2dzgzcXhhQU9TbDl3cDJ4K29yODJwbUZUUEFwL21LSWZKcUlnZlBx?=
 =?iso-2022-jp?B?eDhVRzBid3RPQlNaMUlYL3ROZHpmZlp0a1p4b2s4OWhJaG5OWmdmeHo2?=
 =?iso-2022-jp?B?c29QR1ExaFZ0aitreWZtVXdGK2hwNXRCb3hvT2wxaUdMWThRZHRSRk1O?=
 =?iso-2022-jp?B?NllKWGhQaVlsYjJGdlJPZElhVGZxVU1ub3RsL3RmTmIvbGFrdkYxV1JU?=
 =?iso-2022-jp?B?bWR2UWJUVmd3UmJvUTZYRnpkcWVtTk12cmg0MWJiaDVGeitWMHpNekl5?=
 =?iso-2022-jp?B?N29LQ1dEa1FQOWZuUktRRitjQWxRaVFTMFgrZ3FIbS95dmJrc1Z5ajhq?=
 =?iso-2022-jp?B?V2dVajlUQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bc49bb-5159-4389-17c9-08de435c2312
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 02:20:13.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9+fnavvyMtnAU/y5xqDm1gyAzgusbtsCJB5cgIfD95+XbA5bYuJZRD/MJtBi3F+pPuAlDCHiNJ6jOHKxHPCV7b8qJg5GqBlWGSylmgwStk1JeySwcj1GRa5dFHOuAhG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Dec 2025 02:20:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21218

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, December 22, 2025 5:00 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs whe=
re
> one address is zero
>=20
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> commit 6e9c5c8ef2820d18492d07172ac52f23ea8a54d9 upstream.
>=20
> Configs like the ones coming from the MMC subsystem will have either 'src=
' or
> 'dst' zeroed, resulting in an unknown bus width. This will bail out on th=
e RZ DMA
> driver because of the sanity check for a valid bus width. Reorder the cod=
e, so
> that the check will only be applied when the corresponding address is non=
-zero.
>=20
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link:
> https://lore.kernel.org/r/20241007110200.43166-6-wsa+renesas@sang-engin
> eering.com
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> 32850608d4c4..40bccd1746d5 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -625,22 +625,25 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
>  	u32 val;
>=20
> -	channel->src_per_address =3D config->src_addr;
>  	channel->dst_per_address =3D config->dst_addr;
> -
> -	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> -
>  	channel->chcfg &=3D ~CHCFG_FILL_DDS_MASK;
> -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> +	if (channel->dst_per_address) {
> +		val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
>=20
> -	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK,
> val);
> +	}
>=20
> +	channel->src_per_address =3D config->src_addr;
>  	channel->chcfg &=3D ~CHCFG_FILL_SDS_MASK;
> -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> +	if (channel->src_per_address) {
> +		val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
> +
> +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK,
> val);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.51.0

Loks good to me.
I can apply this if testing is no issue and there are no other comments.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223214093=
9

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


