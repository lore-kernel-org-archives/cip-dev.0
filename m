Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA2DE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 12:24:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.9045.1733833447847997460
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 04:24:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=E4WDrFsc;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733833438;x=1735043038;bh=IFBxOFUrcSHCScwd2u3Id3X0d0aV5RPUmgvun8N
	N0RQ=;b=E4WDrFscxsa/cp0JdIJ8uhjTlyWNz+UherPu9rrYHA0ZuQA6pPlk9K8fEdTUxg+EE0nL/
	8JEK0HuQyPWVyEWp46slqL2yPA4fmL5isYcGXCs55FTJY6KoloiCiJcBGlO+6iXTsCCvsgGlHLkV0
	+tq7dvmscByjkd+34v5645gYDPwirkG5O99/aKt2lXVVpiYEAhd/Ykza16GWF7wrcrbM0K/IxAJi5
	cJ9pMns5o2tKhrJxIhPHQDKoLrVO/soI0R0QeXkN8+roF+rAVHFvptcXWQiUI7Q6IngTOxGp12vTR
	AkZocd3p+yqddHgTkpQnF4XECWWkc/GugwTpuM8CvA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BACNvQf1116686; Tue, 10 Dec 2024 21:23:57 +0900
X-Iguazu-Qid: 2rWhSHZE2HtvyWYvas
X-Iguazu-QSIG: v=2; s=0; t=1733833437; q=2rWhSHZE2HtvyWYvas; m=lND/O20PlAKkN4RkqsQi5V3oZk71hRMIErHTx3LlXgA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 4BACNuHb2680856
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 21:23:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERFQO1vEwbPvjNfrhcoSrP4G/Ln9jxfWc0D4q+oE1JivLNqil1Tcg8lcND9VoYR1xG9JZaFxGBEvRb5Vp6Tel0sXP/hEExGIMgzai5QZ3dU29xgtabuUW1B79PR0WdmQCC/oZVIDg1hfqLG+OCy9Kcout0xYojVBMupcR0/aZC+256Vs02TD4AqFrGfu0Fps9kpOGChUFkArFC4DmwFP1eo0RQFkIwAH7EJNP0VyP3k35uCkfQQ/hAdPtIAxf669GwmHQE2ppOpDpMvrdKBiOJ7kSo9Y1yYYjSboMrbYJRaYbdavuQhNbQWcEyODnwQx1yVvmVKab/lCKT8QLSDODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGIaj99/O9UbwgcgxgaJjsaCCczZBsTjwbQa7tSrX38=;
 b=O9VBfn7DP+P503hlMN4ef9fE9hN8tyc2BHvwzV7/nRZsuY5351cssct479prilkzw1Sp7hj9Q/mKH1KaNyiRcDzRKMqKDi5/L6rDf+NuG0zvVl+LlAiDYvx2K0YLNFKByzEVTSZHEYM1/BiDFA2NF/LnAhdRFGw1RFDsozj2xzBuGud2YYarvaRcu/HcOr194L3S3zo203klx6nf96tIbTIWOzlaXcoFDV+NKCehcb+5Vi23ivDsluuDhzPqVWnlSk26G6eLA12NBXYGuyjJWizKHu2AxvQQVKG3lDnUwec3Yrunbrq8bQUSOM4icH4isOAokQwKsPQmNE2YpYPklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
 4-bit tx support
Thread-Topic: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
 4-bit tx support
Thread-Index: AQHbSmOyEUAbX1knJECXZmOzXEpFtLLfZ6bg
Date: Tue, 10 Dec 2024 12:23:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638803892246F094444B8358923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241209175611.20172-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241209175611.20172-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB10222:EE_
x-ms-office365-filtering-correlation-id: c4ef7a86-101d-467f-4401-08dd19158345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VkRQVlloeUlXeGFNM1pOSnVQYVk1b1VZZU9RaEJ6N0d6ZW9EVm5EdlBq?=
 =?iso-2022-jp?B?RWY0bTNlSnVuZ2RtaUFabEtiWUVqdW9yRjgzTEV4Ky9LR09qZFAwYnc5?=
 =?iso-2022-jp?B?dU9NZ0NFVGZnK2IyZXFRQXAxSTJ6ZENLaE9kMFkyYVRwTnBpZGs4TnZJ?=
 =?iso-2022-jp?B?cTRkTFVXcVAwUTBlcHFkZEtYampnWUtqSWVrakNiYlpLMklML2Noc3ZG?=
 =?iso-2022-jp?B?REZSQU9OVEx4dU4veVhKNE5kKzU1TnBpS1hFVGxBVytPNGFqOUx2d1I1?=
 =?iso-2022-jp?B?VWpqOTVadStqaldjbnlDMWlKN3ZMSzNEL3FVbldEdXdlK3JjQ3U4N3dt?=
 =?iso-2022-jp?B?a3c3WEZXS2hKZkVUUGlubGUwd28xTU91bjNzZFhaM3dTV2djUUlrTFg5?=
 =?iso-2022-jp?B?dmswdjZZUW1YZC9xbHU2VTZ5TzdzYjJmMmtaTW12TFBHTXkrazRQd3Ev?=
 =?iso-2022-jp?B?N3V5dXk1bmtjSlpsNWNaRVJsMzdTa2RpL2NJbGdWeGwzMGNJZzRrekZ0?=
 =?iso-2022-jp?B?bUFCYmx2Ump0YjdkUFlGNXFWZHRCTnowYUl4aFVXdk5TVDEvZllPQkZs?=
 =?iso-2022-jp?B?VEVvTy8xOThLUkg4bzdFWHRPbmtKWDN0YUZSdnJtMHB1ZE1LYlh3R2lW?=
 =?iso-2022-jp?B?NnFpZ1gyTHFsTGFJdlRqbnRkNTZBZ3B1cWpPbVNyNWZXaUtWMk1FYVIw?=
 =?iso-2022-jp?B?VWxST2tNb0FlaXhURWtGcnNXYWNTOEE2TWhGNDdHQzFrN3AyR2x2UTZn?=
 =?iso-2022-jp?B?dExUTmdOYnRjZDJFY3RaZFFoOHhuRDNKajVEeUFjSjQ2bitHZTdvOSto?=
 =?iso-2022-jp?B?RUlsZjZwTzJhS2wrRjA1ZEt5eHUybXptQzlhZk9KMjZsR2V1bGN0R0w1?=
 =?iso-2022-jp?B?c0JYR29aaDRLM1Rma1owbjdSeStCZ2UrczBoeWE3ZC8wWkZkR1lsemgy?=
 =?iso-2022-jp?B?alZXT3JFYWtKeXhldG5vblJ3RERxNVJtMDh4Rm51YjZySlRWZ2Z4S3lx?=
 =?iso-2022-jp?B?R1pLdjdNQzdZWkRSQTJjeEF3d043UmNQTEQ0MFA5L2FCanZSd09HYnJk?=
 =?iso-2022-jp?B?eVdWSG5PbUkrVnpEeXhBT0tNMGVSRTQ1MkdGQUZveVRWOWlQZGMvMGg5?=
 =?iso-2022-jp?B?UUlrS2V3SUVndEE2Skk4Lys3amZyVUhIQzdjcVVOelgybDBnY1Rxc25R?=
 =?iso-2022-jp?B?TkxnRXcxTFh6ZktCeEVabWg0S0Q3VFY4ZmJ6MmdQUHZqOGx0OHdGMk9q?=
 =?iso-2022-jp?B?R2NOTndyQXNad2ZaYkVoWjZEUnAvczBvMEE0QUU2MFZyL2ZoNnhHTWJ2?=
 =?iso-2022-jp?B?dDNzS1F5c3huKy9EcG9aUFIzUzdNNHY1ZEtzTDZISWpLTldkYk1jaWxz?=
 =?iso-2022-jp?B?L3F2K3JqRURVZTIxTzhidk95Ukw0MWpGRjVidEJQd1gyY0NKaWpYTW50?=
 =?iso-2022-jp?B?cDVBRERNWE5ycXNvWmJmaEhzOVZLSVc4SnpTcHEySUpoTEtyaHFhbWFB?=
 =?iso-2022-jp?B?eTYzU3hibjBTZGZRTENtUDA2WnJ1QTR5aXlHeFNLWWdVWXFuRzhFVHhS?=
 =?iso-2022-jp?B?REhyMmV3REIraXEvd2pWUzJnVXVUbzNuRFFNUVI4dzFYZml6aDhmTERB?=
 =?iso-2022-jp?B?NlNLb2NPNkJzTUMyQ0RFaHNEakhWV0dSYytCRWNCRWJBdUsxekhYbmhW?=
 =?iso-2022-jp?B?N2p5ZTk1MGRLUWw1UXFEVmV0U1BXcy8vRU02RFpicWV5VjNvZEZNZ1N6?=
 =?iso-2022-jp?B?ZEs2VFNaeWJLTUh3NktRc3dPUGV3K3RyZU5oRjdZRTJZaThVUWJBSU9E?=
 =?iso-2022-jp?B?QXZENDBtdHNpT0tjM20ySFpWRFNISkZCU0FhS01yaVgvTGhXR1RRL1hw?=
 =?iso-2022-jp?B?bVFvaC9IZnNtTkFUMjA5b2F2WHhPWUdyZytmRUhIRHMxczMvaThJbkVy?=
 =?iso-2022-jp?B?UERRQWdYdU1JdFgvaHJEQURWdHl3SGpBWnRXMUgvaHlNMzV0UzF1S0s5?=
 =?iso-2022-jp?B?RUprMDJOalJYU0dLWTVQS0RLSW1zb2c2VW5BTlV2K3lRQnZmS3JBT2Vx?=
 =?iso-2022-jp?B?ejdGc2xtbXQxUE5OVzdCYmNKNWhDTWpoR3dJa2Q3WVVvMlhtNjV3QWFx?=
 =?iso-2022-jp?B?Y08=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ek5SMWdxQkM5M0ZDWkJWSnRvbG0wWW1XTXY1Mm41eTVBV3BHNUtxellu?=
 =?iso-2022-jp?B?N1FuQzVvS2tFbUxvcFlFR2pRdzQzeUdiYVBLUXUyTU41YlBTZVQ5aFVO?=
 =?iso-2022-jp?B?SngxVFRaR2NiWTBFRXZCQ0lqdGprblNHVEtCaDUyUFdGa3V2Z0k2Qlk5?=
 =?iso-2022-jp?B?enBzUjlXblg3aHNnQUZoWk9VaDZkR3Fkc3pINFluQWpvVnJ2VENSYWJw?=
 =?iso-2022-jp?B?YlBNRTlGZXF4RFh2dEREWUZBd0xZanRIK1lXZ2lnRDRGSlNTWVg1WWpW?=
 =?iso-2022-jp?B?M0x0V1psLzQ4NU9yMDUzeHJFUk1IN0ExZmF2S29WVkdVK1I1emVNZDRI?=
 =?iso-2022-jp?B?YUFGekk3eE5LRjhJZG9LaHB5c0M1M2kzTFR2YzcwMjV0YjZFdGpiMC9x?=
 =?iso-2022-jp?B?VFMxSjMwMkxpajhQdXdwejhSVVhSYk1RR0ROVlZ0em00MUczUUsxemUr?=
 =?iso-2022-jp?B?NnEzYVNQb3B4NUQwWm5Ua0Q0NGxzd1pmam96dTdoSk9QUjFCbnlzeUhy?=
 =?iso-2022-jp?B?UHIzQW5DeFpybHlub1ZOS1V2a1YzdmJrUXhjTHU1U1hhYnVpOVkxMzVG?=
 =?iso-2022-jp?B?dnh2UzN1QjhSTmVlblpxbm1nZ00zOWxOaVZEMHgxUVZnc0pxS1R0K3dp?=
 =?iso-2022-jp?B?QUd4aFpBclpJQ1I0ZEVDOFFwamdjdEJLVHJ6VC9hWiswMUt2VGhibDln?=
 =?iso-2022-jp?B?ak5MVWFOTW9VRTZtWCtkc3RTVU9VQW12dmdPVlkwNnExbXZBaFk2cmNK?=
 =?iso-2022-jp?B?UUNrMTNHMEVmYVFiYi9CcGZ1SGhaaVJzaEx6TGNES0JzeDU2TVhOd2JB?=
 =?iso-2022-jp?B?bDdRajJlYUhKalpkNTg2Ukk2RWNNUGdCYzZtL0p5SWkxZ0VSeVFnUzB0?=
 =?iso-2022-jp?B?YytzRnhPR240NVJ6cndnUWlBOXRHUGoxRTcvbTJJNUR1Smcrd2Q1UGY2?=
 =?iso-2022-jp?B?N2djcXJ6SFEvRVNqUjNyWjQ1S3Bld0I1SmFET1JPVW1QK1dPZGVLcGxX?=
 =?iso-2022-jp?B?aEx1czhSR2h3Tm4xYXZsdVNJRERQNjhFR3BtQlZuQ3NlZzFsREtWbTky?=
 =?iso-2022-jp?B?QWNabzEvRDZjNUpIdU9VaDJvZVNjbUc4MzZsWU9TeE5UWmZKRHNOSkNj?=
 =?iso-2022-jp?B?ZlAza2tHVHhOVUdKL1NYcCt6VE1OWC9nRVFqYmdEMkY2blg4MXZwNUxQ?=
 =?iso-2022-jp?B?dGxHdjk3WldjTk4xdTdGVG9ERk1vL2RzMHdJOCtUK0lpTkJseVdiVW9S?=
 =?iso-2022-jp?B?SzJ5ZGxwUytuQXNHUjMvdE5WOGszVEtOcm4zWXFPRE9qQWFIcjA3bW9k?=
 =?iso-2022-jp?B?ZzlpaWgxZlB0R3ZGL3RxVFd1UG56Q21LMEJMOWRvYVlIeGJQMEdydHZy?=
 =?iso-2022-jp?B?aHFHZHR2SzNwYkxiVDdNbEMxOC9IaGVRNkY3dWR4STRxLzRyeVh6dFFN?=
 =?iso-2022-jp?B?eG9LcmhLYm00OGRzNDNieHBpUHVSMllWaGJ2YjNtalQ3UlBGNXYvU3NL?=
 =?iso-2022-jp?B?RHYyR0N4VWdMbXJrb2c3aW90ZlpHbFdxZUVZODN5RXFFRHdsUVFadjJG?=
 =?iso-2022-jp?B?eUtjZ1dRZkc3Mm5xak1pQnU4Mm5JMGoxSE5tTUdWbmFEZTdKczgvN3dK?=
 =?iso-2022-jp?B?TXJCbDZPeGUxZjQ3OVRvYVh5K1JaVFl1VHJuWkZiYm1DVzdxcWxvUFhU?=
 =?iso-2022-jp?B?cGVoZUpzT3BEQ1dQWGtSRUxTdjU2UFg5c2trVFdhd3M5V3hWalhIUHdU?=
 =?iso-2022-jp?B?d0JQN1RoZU5iTzB3VHdFUk1NS0hzbllGek1DNzdhTmNhM2RjS2p3RXNL?=
 =?iso-2022-jp?B?d3hCRUdnbXdwYWppYk9XR0w2NXhUK2d0NkdDSXRPZUJIZklTWStnVnlm?=
 =?iso-2022-jp?B?RjVqWHVxYXRzNFVHWTlQNGZzMldrbmNORVY5Vi84eVNiM2d6M0NOYVJj?=
 =?iso-2022-jp?B?Wjg5MUVyYWE3azQxMVhQZVJ3UitkZGlPOElXMUJvWS9HL0RkMC9hSDhQ?=
 =?iso-2022-jp?B?a3Q1K1JHNlR1enBpSzVlWVpYOVMzZFFXSGVPUG93allDVk9oeXloYjI5?=
 =?iso-2022-jp?B?aFhBalZ5VEZRWUUrR3RDQ081anQ4RFBUbUFtd2cvbTBjVTN0ZHladCtM?=
 =?iso-2022-jp?B?cWUwUnd6V1ByR2YzMGltbkZMd1RKQWI2RjBhT0NEbDI3VHVuT2RiN3FC?=
 =?iso-2022-jp?B?bUdEaWZubjFWaU1jVzE5TStZeUxMUElES2xIMDZMcWtJdW5tam9GMmtl?=
 =?iso-2022-jp?B?Yk1Ob251YkwvTEErSmtMNUxxOXIrOXErMHVSWGlUSXhZSkZYSjFXWkpI?=
 =?iso-2022-jp?B?ZDJsWWVZS2pGSHNqSzY0NFAyMU1WYTVCVEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ef7a86-101d-467f-4401-08dd19158345
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 12:23:54.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKlSwnl5X5ELev2N0ONHymQmhsClimy5iqshD+vvbbhVFkyHBXmB5KFrWAjgEBUiws4XIAcEjPduGYR/eHPr2dydT5sGtSfGZ0IuY4zFMspN+OsCfr2dxrOiEn0KkFyT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10222
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 12:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17390

Hi,

> -----Original Message-----
> From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, December 10, 2024 2:56 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable 4=
-bit
> tx support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit ce3adea16612a677dd50bdad6861f37f5dc878c3 upstream.
>=20
> Enable 4-bit tx support for sbc node.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20231108172232.259301-2-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> index 46673bf41e9b..b79ca6da5a09 100644
> --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> @@ -312,6 +312,7 @@ flash@0 {
>  		m25p,fast-read;
>  		spi-max-frequency =3D <50000000>;
>  		spi-rx-bus-width =3D <4>;
> +		spi-tx-bus-width =3D <4>;
>=20
>  		partitions {
>  			compatible =3D "fixed-partitions";
> --

Looks good to me. I can apply this if there are no other comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


