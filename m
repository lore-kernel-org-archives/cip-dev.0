Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AFD2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:05:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.279.1768885492235625177
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 21:04:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=f3O3qcPh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768885489;x=1770095089;bh=u+7OEg4ykMVl1r3G17+YCwt76ZyqZDB01O27c
	qbAabs=;b=f3O3qcPhz1crb4fB01Me0ZsY57GrICRckP/1zjXQGNZbL2AsevFWyigAxolRTld/VoE
	+1nnEiH8Vf8JLFl2zGI+QWwqBClQEnRpY1KMMn03TtgIfJq3ERTajQqF7mCaDN1bMn0tHn+y8/uG5
	JDI60LGFNxaCo9YSCHKLA68MPrDoeBd8JGe1LezWwoyjZFjs0+vMSzp5K960KyjLJlysZTf/MBq6O
	+Md5s1nyIVsOCOjrXUfR0zC8wNR3rPRBl2K1oCZ2QyJwvOPgxINBAQKm8diULoQsBqyqbnNWPJ1Od
	gbB89evnIJEToj5jPyJJ2M5PEBL4sw6e4cpp7LocbeAA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60K54mcI1330180; Tue, 20 Jan 2026 14:04:48 +0900
X-Iguazu-Qid: 2rWhxm4aqSLLBoLQyz
X-Iguazu-QSIG: v=2; s=0; t=1768885488; q=2rWhxm4aqSLLBoLQyz; m=TQNGs0v4LEzaZPS7SpXocZTy6+N1W/hGgAxn0ZZa4Rk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dwFcb6f4Qz1xnq; Tue, 20 Jan 2026 14:04:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnhL7zvPjC03t5b+R4ueEqIqfvonG4meWN/W2tP+MCNuR6T8VAt8BceU/ppF7GorK7tFOVN9Gkbn2/LzB1U4LdkCboaHctGvGNmgFqzZMqZQsUBkdjLKqicNkzbGd0IJNd90C63Xs4mcOKT5/AIDLrThMcpH67DkHMQOwZSgUIjPUegd69IjSWIIl7rBMmZ34HKpcjTYjpoabaIZFHBcIg25C6VLVrJhYcPnoEUuXZtkE8gpGon7vuFGeqAby6kZRvNLKN+wPGOj0haZyBnzrXYM3DvMiyw66VvBQYe9YB0fa+/Opuuk/vyu0P79PPYXOsRGjNT5iruOvqkKH7EtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWU4FVWNehF+ARP16Q7zxrhr4lyMsPTAYBtuTRfrnAU=;
 b=c9OwSk6jj7DsU1JdMraIiSgc9qoTXgFVYB7eiWQAvtHkgYjFx991FwAENpMWEWM9Uu5bJ3bq48v3iafMgfNBsHtxtzE6a3i7skweW74lVsoZ/BnYKrAZ4Fp19qvQQt+h4AjCUyAuit5bKuziIxRPyOH90yuSqwTo5vnQwTR/bdmAxYRUgT8LUj0KSZAPGB40L9m24Qe6Gsd7u02gzQIVRMH9UlFcq5gcTLA+Tp8BuCks0jz6KjtzhPlZ3XjegC6hrCnWE1It/9wVz8s+Dkpqi0zkCZ9uQ0pCsVcyJjZMf0eHuae2450AXAlDOBD1jcNHjTrOdEy8/b9aVffcbgPOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/6] Add RZ/V2N USB2.0 support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/6] Add RZ/V2N USB2.0 support
Thread-Index: AQHciUJlvYP8aLFeUkueJxSNp1EWyrVZpvgAgADa6wA=
Date: Tue, 20 Jan 2026 05:04:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186F4C214EE8E2034179D8CD89A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
 <aW5VIp5PQdEvoR8S@duo.ucw.cz>
In-Reply-To: <aW5VIp5PQdEvoR8S@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB16870:EE_
x-ms-office365-filtering-correlation-id: 64a40f7c-2b8c-4e65-00bc-08de57e16d5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bTdOTUhRTmtORjBPV0xRem9lUklTMjdpR3VrY0ltMVQwcGdZRUkyRUpD?=
 =?iso-2022-jp?B?Qng4V0lzWEswcVFqclgwbmVuMlMwb0xDaHEzT0o2NldmWGMzQzNQaFJa?=
 =?iso-2022-jp?B?R3JBVnU2MUx0eFBCUjZod0dVMkVVYXk3UmlYM0V2dk9wanpsQ0FkY0tn?=
 =?iso-2022-jp?B?N0l4b2NTS1VXKzErL2dwSi93RThOT0lNZlRUV2ZyY0x0UHhxWWNwTHly?=
 =?iso-2022-jp?B?T1JkOEpnSUQwaldaQzdERGUrcXlVSnpMVitkR3BoeFJlbjEwZ1lRaWow?=
 =?iso-2022-jp?B?aFRJUFZKNGlaaUNVdC9PU2dqU2UvTnNBc2ZpRW8yWStmWVgvbWoxQ3hX?=
 =?iso-2022-jp?B?eGZmMmhYc2J2SEFaanZvZzhUTmFaZGsyTHpONWcxSDlad0JLL0gweHl5?=
 =?iso-2022-jp?B?S2tnT2J1M01TRFVkcnF3SVZYM3luSUJYODdnb2lUcExjNEE4Q1EyVHJi?=
 =?iso-2022-jp?B?M3NrSkk4TTJSVkpubW5FUGYxMys2WGFYZk90Vm1nRmViOVI5K2cvOVBl?=
 =?iso-2022-jp?B?WmxHOTk0SklBSFpwUUhCTjZvNENDTlVaNEJVT0dhVTNYYjFqQlFmZ2pR?=
 =?iso-2022-jp?B?NFQ5V3JIWC9UOW9Zb0hpdUhtcTcvVWZFZXRDb3JOaHFHUElERzJPQmZy?=
 =?iso-2022-jp?B?Sjk3WFlWZlcwMnc3Z3c5V3g5VnRTWStSZXNHVytpcDJ5UnRXREpUQTl1?=
 =?iso-2022-jp?B?UmRLbExPM2hhbE8wcFJ4WitGRzg0SjgwTlQvUWZwR2ZGdGJKQnlnbE9N?=
 =?iso-2022-jp?B?aUFPbTVkaW1KR2ljV0JiamU1eTQyZWxuc24reTByNDVyVEtzak9WeDVX?=
 =?iso-2022-jp?B?dEVrVm9tb2Y3eldHbzFmS1pmc2lCWVh0U1l0RE5iZUJOZVQvMy9pazR5?=
 =?iso-2022-jp?B?T3JmQXJ6T1liZVdFSHc4cW1yeVFIRHJGTmRQTnFpWFdLemgzYThGcU9D?=
 =?iso-2022-jp?B?d3Zob2cwUzE3MGRJMFBBSldOUWVsbXNyQ0F5UHY3eEw0UXQwWXNlblEy?=
 =?iso-2022-jp?B?eUtpUStzYlVrTHkwN2V5cFJBcTFYcE1pWE52Y05aWUdxUDBzNE4zVnhR?=
 =?iso-2022-jp?B?WCtSWWdnVFE5WEFISm1hdjRFdVVqa1ZTRjhDUVZLeUhSU0t5YWdlQXc1?=
 =?iso-2022-jp?B?eCs1Z0RxV05FeEtZTUk3Nkh4dFBHd2w0NmNNYTJOWi9tNytnT0prc1R0?=
 =?iso-2022-jp?B?ZU9YS25TZjhYLzdVaTFkczZ5NDhiNGt1cG1NUm1XTDdUVGZwUHlxQ3Vw?=
 =?iso-2022-jp?B?dTB0b3o5bDRHejEwQU9yeUgwWXQ5dWdwMjFoZEhiTHJxRHdIeTc1QjNS?=
 =?iso-2022-jp?B?TXUwVWdkc3hjV3RibHdIQ25IYWhiWjh5a0J3dEF2S2hlTXMxeEdMckYv?=
 =?iso-2022-jp?B?VW5IczdKNlp0Q0kzTUlsQ1l1Wk5CQnU1amVSbDR1MkVTc3R6WmtoOEk1?=
 =?iso-2022-jp?B?dUIxRjc2WTR2c0MrMVdRWkxhckJWZzFxbDZPYit6ZEhLMHdQTkVqVGEw?=
 =?iso-2022-jp?B?ZUxVRXczK3J1SjRmRWYvdExYb05EODc2UWNVK1ZtL0I3bkVVWUxpanR0?=
 =?iso-2022-jp?B?NVhMQTN2blQ3RjVnbHNEM2RkUVMrWWdRd1hQK0V5bVl5Q1VXSEM0YkN2?=
 =?iso-2022-jp?B?QWp6M21JMjBqZnZsNzRuN3kwUjJ5bGlqdXpOcTFSTHZrNDFnL0l1K0lk?=
 =?iso-2022-jp?B?ZDFid3kxeC9wTTJJaDRCYm5jczYwcGsyOURYb04wRjk2K2VqT2M4T0Vm?=
 =?iso-2022-jp?B?RWJoZEFaN3NDYWNZbDBxMWtHSVl0N2hqdnVaUHUrUTVCUW5uUDQrZXZm?=
 =?iso-2022-jp?B?ZXFYOHRwaUNXbG1lMXdUYjRSQnNnVUxCcTVTNDEzbGpkTVljNFRsQU90?=
 =?iso-2022-jp?B?THo4M0JBSWNJek5qeWJ6dGh4K0VnNFlGcDd6bnFtaG12RXNIUmk4VHpN?=
 =?iso-2022-jp?B?TVBSM0huRk03LzBDdnhLYWg4dnl1SEZJUDFjazZlQmNjN3ZCRmtPdUN0?=
 =?iso-2022-jp?B?dk1tQlYxSFlHTGJzQk9CRVladnl5bVZDZGkrVjhVekxaSXNjam9peXpu?=
 =?iso-2022-jp?B?SWs1Z2ZhRklOZ1pQc0N2dzg4ZWtLa0JwanpjeW85UGNwcnJ6Sk41Yzho?=
 =?iso-2022-jp?B?aHNZU3N2Z0hCdnJPZGxKa1NBc01HTEhFRXM1VnBYOHBINUJVb25KenRx?=
 =?iso-2022-jp?B?SXNZWFUwVTZRNGozbWVZcEthWEFKUFh2dEhLeWd1TkJ3MjltZmhtZ3dR?=
 =?iso-2022-jp?B?ZTFzVWJPcER0QTQ1S3ROMHV1OENOOFN4cUcrTUpkSEtqZHVoNkFNK2RU?=
 =?iso-2022-jp?B?TGdhRlBXd0wwN3g2WFhna2UvWWtveklyS3pOMGxzRnl5SFRoTzJYNkEx?=
 =?iso-2022-jp?B?TmVzdUk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d0dwVmxXQSs1d2NxS0Z3NjRteDZNbFFoeGgwYnBnKzVmMU9pWlY4N3hI?=
 =?iso-2022-jp?B?dXNGYVRiSjRWMjA1VlAvMkJNODdJZ2xvaE1zNkd6STNrd2gzakNRd2lD?=
 =?iso-2022-jp?B?T3VCZEt0TURCb2dtSWVtUmdGdjJCd2xlam9yL0VwT2lSa0REK2hsYldZ?=
 =?iso-2022-jp?B?cUQzRi9mQjc4WUxucGtrTXkyMHI4SkN3VW9Xc2RrWllkbHUrd1R4cSs3?=
 =?iso-2022-jp?B?dFVuZ21BelhLUUZnNWYwUEFTSEJqQWlwbmxwNDJiSTVBSU9KR3hFTDZz?=
 =?iso-2022-jp?B?ZitvaGFwZ0VVaVR4dnl4VlhyN21FUGI1bWMwblhBemVTWi8yemIrUXNz?=
 =?iso-2022-jp?B?NWRhdVQwc0hLb3JtdTZ5Y3pxeldwNklDUExkQ1Z2dThFSlZVUjNoRHZs?=
 =?iso-2022-jp?B?eUtKREZRQnFlbGNnNDc0NlBaYm1hUlUxVVpBT21NUG44NUIvMGFUWEEy?=
 =?iso-2022-jp?B?cnVVYS9mRWp6UFZ4M0hNem10a1FuR205cnQ4K1dyTTdzQ0NRUzAyb0dI?=
 =?iso-2022-jp?B?RWhPNGhUQnJqY1NxRWZhWWsxVEVEQVBiV205WmZVdVRsRG1sRlIzZ3E4?=
 =?iso-2022-jp?B?SUlYelNMaE9MR0JqbjFOcGswSEV4eWkzZFh5V3BXV0pMK3Q2SkwxOWNP?=
 =?iso-2022-jp?B?SUtLbHlRRHRKelZvSG0rU21LeEZWL2k4dFlpTHQ2YjdSa0ZCeTdjSWtF?=
 =?iso-2022-jp?B?MDMzQzR0RGs1Z0lIRTNPQjJQdE5GWVZxcU1wS0NvdHRoZk9LK0toN1V0?=
 =?iso-2022-jp?B?QWcwTGxnYVhmcXV4ZkoxbmRhUE5OckI3YnVCbW9iUmdITEFHM1VpQlho?=
 =?iso-2022-jp?B?UDhGK2xQdXk1Qk1PSUsrOUNTTFZOZEVHV3FzRkdNY1hUS3hic0F6MWhp?=
 =?iso-2022-jp?B?RW5wSWY3S0tWRDM2M2Y0dWt6NTA0WEhaUWg0TXRjbjU2WnU4T25aS1VY?=
 =?iso-2022-jp?B?YWVvdXpDSDM2VTcySTd5Vm1Vbk4yS00wRDFWV2Q4aDZhMm44ek43L3hy?=
 =?iso-2022-jp?B?c1N3UFRqbjFpOXlGTEkyL0R3ZzZxMThGQ3M4VVYxSlNNUkZOUXBnNW9N?=
 =?iso-2022-jp?B?S3UvRDZYWVg1K0dUMXcySXNlNDNCVk9PL2RkaFk5RURCeTgvYVc0ZkY4?=
 =?iso-2022-jp?B?NllmYWx2c3hBSUhtOTRvRXZtQW9iRE1MbkJUWFJyRkJnMi9XRzlxL0Q2?=
 =?iso-2022-jp?B?UFlEUmJNNkMzT2h1U0pOOFlTaW42RzRjVXVwQkFocE9VQ3VvVEFaNW16?=
 =?iso-2022-jp?B?Uy9CQXpFMGIwRVIvemxSKzNmbVJKWEtFeVdkZWF5Yk1TdlFaOXd0Y09R?=
 =?iso-2022-jp?B?S0llaW5lQzZUZUY5VlFxb2dlbHIwWkJkREZJb0FrQ0doUlFXYStOS0tC?=
 =?iso-2022-jp?B?enRkOW9pSVJSU2JtcFBLVWhPT0oyVVVqb1gzUlE3amZ1dzVIcE4zQ2RC?=
 =?iso-2022-jp?B?VFltTkZ6L0xYYUtOd0d5MExCN2M3R1BNTG9wS1FJNWE4QXlGODVZOEFG?=
 =?iso-2022-jp?B?b1NNbnE2cE5tOXBoZWt4cUxmK25MYmVlenhXbDd3UzVYbVhNdVBFY1Zq?=
 =?iso-2022-jp?B?eUM0ZGw5T2NuaWJSLzJTUVFPUjIvVmx1VytUSFZGNVRMZUIvNWMzNCtY?=
 =?iso-2022-jp?B?SjVUUFdJMEpoMVk3NTZSZVR0bFBzRGE3SW9mSjVEV01CSFc0YXltTGZC?=
 =?iso-2022-jp?B?dUhvcU5rWndXWWZoUTVZZmY4ZUdoTk03WlVrcmQvWFQvL0g5dHFBUStJ?=
 =?iso-2022-jp?B?NHB3RnEwcTUyWnArWlNaR1ZXZFRqdHFidUNwcCsyT0dESmREVDF4WWVN?=
 =?iso-2022-jp?B?Q1QxOGlNVHlLeEdacVdQZFB1a2ZTbnFKaCtwWVRvTUNEY0tybmVLQnhm?=
 =?iso-2022-jp?B?UkExc2MrdW9lVE9rRVA0NU95Y2tIN1A3ZG9XeWtTQyt3Yyt5bklQbmNP?=
 =?iso-2022-jp?B?RXI4SlBydHE5Y0lzNllPdlNlOFI5NW5aalBUVHlXUGZtbUFyVzVYNkc2?=
 =?iso-2022-jp?B?YTZEcXNFY2ZBSUk0TVJqR2tzWGJxcXpXSSt5U3FsMjZ3Tm92SEM4c1c2?=
 =?iso-2022-jp?B?UXhoYUdsS2xWbzl3U1hmRnFTL01PSytxL3JORFVHazhDTktXaXJSYW1T?=
 =?iso-2022-jp?B?Ykg4dUx2Um5UYnB5Um1qNUZja1JJOXFOZlk3RWZaakQwMUxXYm5QbkNo?=
 =?iso-2022-jp?B?dEg0S0hlR2xTNWJYTHFmbHp0NzE2c1Y2WDl5SDJXc2VnNUkvdS9XUDFa?=
 =?iso-2022-jp?B?ekRzVDQvY25tTmg5dzFFRitrdFlLUWkyZkpoWkg4UjdEVERTdHJEN3Yy?=
 =?iso-2022-jp?B?U1RnTlpyaDNvQm9PNmRsRzliWGZGVGZTMkplZHZHNGtBUmFSWWQ5N1Nt?=
 =?iso-2022-jp?B?ejI3ck8zUGlrOS9YdGkwMFdKT3RjVWwyWFZqVENVM2xGQUNOeWtUcU5J?=
 =?iso-2022-jp?B?bkJCdjFsV2J3RHZBUitxYWRxOUNsRXJQZm9qM1dVOUNXVnEyVDYwQWVM?=
 =?iso-2022-jp?B?bEpPT1MvbUpqRGRkbVhEZHhHaHBObDM4dkZWeDR5OE5qTWFIWkg3clBL?=
 =?iso-2022-jp?B?QWY4ZUozbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a40f7c-2b8c-4e65-00bc-08de57e16d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 05:04:44.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncb3Eop0or95NdZzMTqKUUmaZ+eScX1d1lg9PWRIoSk2uutXnQ/i68/1miu9A0kWR8Cp4ItyH1TnuIfsmFBU/P2SOABd7l8UTNfyp9/RAjQn4nBF9Dss+vW6mP5GK2Sh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 05:05:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21682

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, January 20, 2026 1:01 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/6] Add RZ/V2N USB2.0 support
>=20
> Hi!
>=20
> > This series adds USB2.0 support for the Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks OK to me too.
I applied this with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel
Best regards,
  Nobuhiro


