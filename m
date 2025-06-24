Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3BBC77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 07:10:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.2907.1750748996227678716
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 00:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=W6SGI1r+;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750748984;x=1751958584;bh=qmx600mYzCe9ZUKS4Ozkuv+qttiTVUz2XpZlpMo
	W50w=;b=W6SGI1r+865PmYGoQaqIh3U/lurh3bcPB35jQjZHukFOuxoF9BldujBJPjQIv81mdd5Fk
	BRR9EpBHMqGrvD85zwYd+jI0GPIMTDlH0QfWo3hI9mo1pWHCP/YkzIUyOrUsQYOcbgu61UQWh+gSv
	Ca40yyYIfr16mAjX3NRPDJOdVRrNiuF5PqGdIfeABiGf43sPxY1NMLsZL2OKk70RGcd3Ay+1ed64M
	128eKVoU03Tp1bSXU8+yXZykbYsZWIso/4pNU0yumjHe/UvTloZ2tEMxWA4chiGJPZGr3Ssfw8nbN
	RvSb21ixktZDHvi7tuAe55JVCtfbp3p+ezENYvMPhg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 55O79hxl729727; Tue, 24 Jun 2025 16:09:43 +0900
X-Iguazu-Qid: 2rWhBFYKMKTF1Om5Fk
X-Iguazu-QSIG: v=2; s=0; t=1750748983; q=2rWhBFYKMKTF1Om5Fk; m=ba1p1cOOB9sPLBKN/e630sjaR4t3yF5QxrPd8/PqJ4U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 55O79gDR1837889
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 16:09:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0ucgl8KBaIWqH/9CdplIesI2NZP5d0mhyjjr7/gJ/bdzKuB5GXp6EahaUJQwLVWUpVta3MkgvJ1PDdLOue0FoW9xJeKyP/7AUrjoetp1edTzqG0Jh4usc16zvXuIF/L1wEC1GAxVwl1ukoHJ+3+s/4ObbC/BETy4/jTJrVwGxRXoVIq1Kzj58RF/AwMs0l2OR3xEvumn2vBk7NmvtdXx8EqCujSCTwj7DE2+mll5KkY7Jxr1z4RcbBpiI1spGJiNlqhHF8VKgNFRSmAFkihc3eEj7MuSRhxi7vi/ocbzB5p0Gj8w8ZIGfjyOO9TS1z4Pih20zUISgjoylbqj7BYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyabn2poJWFb6jcsYkhbk/bdZw6I0dumT0PXgYvmVMc=;
 b=oRah9LypZgs9vZ6zJvtVZeInMaru8UyCxWLnlPNBFoKbQqHn9xu5NkCWoYq5uK6zkT8x31cnb+g6e279fBGMaZGnv2kIazmspe5bKgNsjVibvBAJvEZmEUjm5f9nVfCtzSvnIWN+luXXqNh0WWBXlo/JTFyhY+4a5PipALqz5Ec6SDee/UJVBduSHbebecqmWJQ4Q+V2K9b/0Atx4Kz/hqHYhdqLa/CSqnMYQV43PkfUViMT+sZA10U7L/+bh/o0g8133mxVQ+NK67q26Zw1rINneOvS8MUpepJtOqSKdN5dSvmdEpUXgnEuNvKeBMs7SmyaYmM9anqdYWUGmuWMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
Thread-Topic: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
Thread-Index: AQHb5CmDWL3Y/2deeUqRRzouqdiAQrQRr+HggAAy5bA=
Date: Tue, 24 Jun 2025 06:59:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818384D8D9C0CF2C8E312F39278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB148181D57390CA0AE449D1E589278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148181D57390CA0AE449D1E589278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB16123:EE_
x-ms-office365-filtering-correlation-id: e7943eff-d776-4504-7e8c-08ddb2ecbbe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bCtoN3dBNjdRNThmem9MZCswQ1JnZzVIeW16ZkhUU0h0Sk5ack5ERGs5?=
 =?iso-2022-jp?B?aGZXNDdLVk5EdXpiQzB3YmRyQmpXWUh4a29nZ1RMNVZuZUZ0OEVvdXk5?=
 =?iso-2022-jp?B?emtvYS9pSEhQNHRhRWV4N3hMN1hSOG5GZ2FRc3JJSnQzaXFXdVEvNzhn?=
 =?iso-2022-jp?B?SXpBVlBEcTFxNFJ1eG5zaUVSZTczQmpZRGE0bnpaNCtoQ200OXRHUFcy?=
 =?iso-2022-jp?B?cnplYTkzNzdaVFNGeldnUGlFYllJaE9qY2xrUGU3ZnRQc0hrMXoyRHVQ?=
 =?iso-2022-jp?B?NWd3eFZ2NnorNnN4bUdEcW9pdFU4SmhDeDJvd1g2K3k1Vi94TXc5dCtH?=
 =?iso-2022-jp?B?R3h2b3VMbWsrdmhXQ214U1FOdDVJb3RDeW1vbGR2YnA5REI4bXNCSENh?=
 =?iso-2022-jp?B?NktTQytkWjhmOEZvbjkrTUIveWRwNnZSUDd3aVJNMGhJcTNsdGNIa1o0?=
 =?iso-2022-jp?B?V3FSTm9kU3JUeFJ6dnByQkVEczlxcllqdEJOSkdnVVVtZ2lteHpkZjRx?=
 =?iso-2022-jp?B?dmpoMERmcU9FWE8zdEVsbjY5cTh4OUlReXhpNDJmVVk3ekh1YTZhdHdw?=
 =?iso-2022-jp?B?K0hsVmxTTy9rSmo0S001WEc1YkMrVm5ia0k3bktVd1pNWXVHSndxemtK?=
 =?iso-2022-jp?B?VWttWFRSSExSNGQ4bzJYMlNueThwRytsV3BIQW9nR1haRXFFL2l0YVlh?=
 =?iso-2022-jp?B?TzY4RU5NQTRpVHhJV0l1SGE5eEpJcGVLMTJVbDJaVmxaZ3BIWXhpbW9h?=
 =?iso-2022-jp?B?dy9lTmZGcmpWdDBhVDBkVHNMWmFRa0FpLzdFVWQzVVVDRVJDY2V0Zlh4?=
 =?iso-2022-jp?B?Zyt1aTdyazgrTTZQcG1yaXpGaTFFZGVtUHovZXlIdmFybEZhOFQ5RW91?=
 =?iso-2022-jp?B?UE5BalR4aUpQdXhjY0RYR0NLZGpMdERMZDFtN0c0WlR1cFlWY1QyTmNw?=
 =?iso-2022-jp?B?ZFFENlluQkIwVHhuQ0tKTjlHWG9sTzhTdVMwS1llQmxteWUxdVBHSFpp?=
 =?iso-2022-jp?B?Vi8vSjA3WEltdjBCVzBEaXRDY21SbFBPQStiWU1XRS8wVEVIVHFZOFNi?=
 =?iso-2022-jp?B?VkNJZU1UOWh0eHJrdGlrOUZZdTZIVXBXd01PL1Y3VG0xSU5SbS81RDV4?=
 =?iso-2022-jp?B?cW5qci9UQUJ4dEducXlYWXh5WGlVbGErWEppWXYxdVRnanl5cTlHQXVR?=
 =?iso-2022-jp?B?Ly85czQ2ekdYTzlJalJkbGdjZ2U3eEVvajB3bEUyQnpKa1YvZkpzdjRB?=
 =?iso-2022-jp?B?UXQ4a0txanZneUFnazU2VnJQSDl4L0FVMWpWS1pSdFZoWk5LOVdWLzJt?=
 =?iso-2022-jp?B?UkFFbkRtaTJEajBEdW5tTURwVXdMMlJPNnh0a2QvTU51bzRCQ0Z0emM1?=
 =?iso-2022-jp?B?eG1QeU15SGRIWU51SzU3blphZktKK3oxa1VLdUdWMWJRcXZIS2liM2Fq?=
 =?iso-2022-jp?B?cmg5dTVtc0VGRS83Q2RtQ1pIMUhEblM3SDU1NDg3VGlRQldtNUZ0MjVh?=
 =?iso-2022-jp?B?dUxNdDJxWkg4L0c2aStVaS9scDVZSFRwd29McUVFT0xxYnFNV1FxWHhI?=
 =?iso-2022-jp?B?amFBb3ZicVV2eG5LeWFGdGpRM2xYUjRBcHppODdzUmQ1Yis4N1FGTzRK?=
 =?iso-2022-jp?B?RVFZL3NlSU5ZK1NvZUF6T1hocXpEVjZueG1uald6cUR1M05uSTVabkcw?=
 =?iso-2022-jp?B?SVJ4UndKNEEyZGZ6Q25zNTNwQzdoQzNLYVgwZWMyaXdTUHNDMDE0NzR4?=
 =?iso-2022-jp?B?amYwZVhIR3RON0Z3akZjYStYVjNxRXEyZFRjMzNIRUsyWVZCZ1BnNVNp?=
 =?iso-2022-jp?B?aDlqYS9uQzBWb2QvZlVFK3psNDY3bjlKMGJOUHRQQVo3UHZVUVFVRWYr?=
 =?iso-2022-jp?B?MHBORVFPMDloU1NKL0tqREZyTjBWZzlHOUtReC9uci9NM0s3OHpPWGpu?=
 =?iso-2022-jp?B?cjVvakVaNzhFVnlCRHlPQ2xQYnpDVGtVYlMvbG4vVXNqOWJ4OXdPdE1P?=
 =?iso-2022-jp?B?cnNPT2ZUVnJOcVhhV2JNRWRqN1NuTjNFcDErU0xkRy8rTlQ4NklkejZZ?=
 =?iso-2022-jp?B?RWs2VUo2cmUyNVczelF2QWtpZkNsUTJYTGJmb0tUenUzMEZpUVR0K0Jr?=
 =?iso-2022-jp?B?V2Q1RjhZbW5OaWlESi9vbXM0b1ZKTWtRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TTJ0cytuRFh5NW8rUkVwaFBsaTUrU0lVazBteHF5YkJXM1RGaHRzSE5S?=
 =?iso-2022-jp?B?YnNnTHErUW11M3l0UVNma0REMTV5VytSQm51YzR3MU4xMEVBQnUzaEhU?=
 =?iso-2022-jp?B?WTgzZklZVHgyY3EwaXBCWDNEaDgveTV2V0tOMlllQWpFcXY2UG9pYkl5?=
 =?iso-2022-jp?B?Z0wzU2lEbEU0WUZNOWo5T0VWd3FHTWdzQkJFZU00TkRNODBLc3hGTjhM?=
 =?iso-2022-jp?B?RFhud3NMMVZPd1BsVGtZaS9wSXh0aUtEZW5IV3dLQXltMDlESkQ3VHNR?=
 =?iso-2022-jp?B?VWRVM09qMngrWTlqcGZDRmFBWnlsbGs4dHZlZTBQT2NtZ0o3RjVYMi9I?=
 =?iso-2022-jp?B?dkhnVXk3M0pyMk0zMXA1SWpUMWU2UjlmL3FhelFXcGhhYS9vSzhSaCtx?=
 =?iso-2022-jp?B?eHR5OGI1RXlWTmw1ZmI3VFo1ZmJXUnV1OEwrTnNRYkZ4S1hKdFdNTG9u?=
 =?iso-2022-jp?B?REVVbjhtcE5waXZ4U05adzg2QkRhc2VmVVI3Tkt2aVNKUUVSd2w5TlJO?=
 =?iso-2022-jp?B?Q1FZN2V5RGJvQ1FkYWprWEd0TWk3VTVUdTl2WUIwTElDQi9yMjBERHRn?=
 =?iso-2022-jp?B?bXk0MXU4R3Y5M0t4YlcxUmo2ZzhnaDlIUHpaT3pPbnMwanFsbnNpMkhh?=
 =?iso-2022-jp?B?V0tVaGpDejNEUExrYmFVdVd6VmNpSEhlV3hGM1RObUtVUTJVb21TU2h4?=
 =?iso-2022-jp?B?anpramlYMnl4MHdZK0ZabnFFOUtudU92dFdLendNQm9VNmsvMjQvdUtm?=
 =?iso-2022-jp?B?LzhCU0tjUFQzWWt4aEs4OVhtb0wxTGZScGFvcmxqdVB5YzZ0M0IydjBI?=
 =?iso-2022-jp?B?aTFEOUNlakNLemUvSnhKTklFNXNxZXJMRVNpUHhsTzhDdUNrMEJzNjg0?=
 =?iso-2022-jp?B?cjgvc09kdFZyaEVOMVBESFhVTW8rYnFCb1FYa1ViQWZPYkVldFdqZURl?=
 =?iso-2022-jp?B?Wi9oek1SbzlMVkhRK3ZEekNrdXhrU2RBdmNBYnZ0STZEaUtkdXdsZXht?=
 =?iso-2022-jp?B?aW5SbUZRcEtXZEZXSVpENnpYM2Z1Z2p0c0tLREJsZEt3aWFlM2dPZ1JI?=
 =?iso-2022-jp?B?MXpqd0VGM3lJQVNZY0N5Q2lYNW5SZFhpNmRRZHRJSklMaFlFRzhqUW5W?=
 =?iso-2022-jp?B?ZVVzc3luWmo5MWdFdisrK2ZCL1NQUTNicGlYcnRJMjg1dVFnclVvSjdS?=
 =?iso-2022-jp?B?QjQyd0t2NkdoRy8vcWg0NFV3OWcveDJqTzY1YWx3RHRLdlM0dGRsZTAy?=
 =?iso-2022-jp?B?ZlNnbjNXYS94aEdPOE82VkhybUJtb2kxU29scnFMeVJKMGVVMHpsSnZM?=
 =?iso-2022-jp?B?akZSZ0ptcTJhTVRZdnJNdFN2NXZ5UWcvU0pFNzM1YlQyN0FvaXJhTVox?=
 =?iso-2022-jp?B?T2NxdXpHckcwbWtXbHJGa0FFUmlPV2ppdjM2K294Tk5DaUZPdGs1NkJk?=
 =?iso-2022-jp?B?d2xadUJuT280a25UY1laczF1djdTZytTWkpBb0kxY3BXRVZJTVYwS2h4?=
 =?iso-2022-jp?B?eEkrWDQxdkx0VGtub2xJUEVSZTY0R3VRc1hoR094ZSt6ZmN0bFo2UUxW?=
 =?iso-2022-jp?B?SjRFZ2lPYXkzMmVvSlQwalcvME9IR2lNblJTMzNSTnl4TzhnR1VGYlZ6?=
 =?iso-2022-jp?B?QXdaTEUreTVEUzVIWmZzbENydXFaQUp1b1lRV2QwYlAvNjBkYWxDNDk4?=
 =?iso-2022-jp?B?VHlidGZXcUxtRXFxeVM4b1crYUdqSkc2QnRUY29tQ3pKblc3aFdhcHpt?=
 =?iso-2022-jp?B?amovYnZOcWtpU2pzbE5KMC9TaEFLL002TTFQQzRxNzBCdzFHUm9ENFNu?=
 =?iso-2022-jp?B?bEJJeitVaTZqK0diNnhWZkVySGlvUHNGb0xZK1d2dm9xYXo4eG82SGFL?=
 =?iso-2022-jp?B?ZE9rOWc4OTVualNJeVZJTmVtcjg2VTdIWEdLQllmT2pzRmd1R3VQREht?=
 =?iso-2022-jp?B?Z0RydXpsTXlZVEhPYlVLZ3QrQWZiWVFkNXRnNmZ0cGh0R2xKL01GbEdG?=
 =?iso-2022-jp?B?VDZSMTA1c3dIbzFqTnVNZTFmWFBwcmptc3lvbFNveWs3VmtHaTdEd1dl?=
 =?iso-2022-jp?B?ODFrbk43emlkcmtIdHIzV0pQdTZxNFhwVDc4Snozb3ZnTWJsVEFXdkQ2?=
 =?iso-2022-jp?B?U0xFVFhDRU9hUzQ1Yk1XYXRYbnZnRnlHT0JqQzRzS2xnODVzWlU0TjBt?=
 =?iso-2022-jp?B?azRIQnF3eGZvRVpaTTIrUWpzK25RS0QvdEJpTW05dXZ5VGJhKyszN0pY?=
 =?iso-2022-jp?B?Z24vUEVYclRTS3UydWRZUDFreWQ1ZHJBN1BrbXNqcW1WVHJJakNYdExL?=
 =?iso-2022-jp?B?eERQbC9jZ0NteTFrTVZud2lGYnZvek9ad0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7943eff-d776-4504-7e8c-08ddb2ecbbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:59:59.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HScn/V2Id1EcmGZsQPLg3oZU9XPzqhwhdMl5t43Rslf7ugnYKJPUQYTdD45sHTjv/Eate7gbCPEv30bZbHuCy4t7OK6FFAmj4hKgDGMJemG3XgCz4HnLxIJeFG6K/RVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 07:10:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19222

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Tuesday, June 24, 2025 1:03 PM
> To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: RE: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: Monday, June 23, 2025 7:27 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> > Subject: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
> >
> > Hi All,
> >
> > This patch series aims to add Watchdog Timer (WDT) support for the
> > Renesas RZ/G3E SoCs.
> >
> > The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33
> > cold reset, system reset and asserting WDTUDFCM pin where as WDT1 can
> > be used for CA55 cold reset, system reset and asserting WDTUDFCA pin.
> > Other 2 watchdogs can be used for system reset. So define WDT{1..3} in =
SoC
> dtsi.
> >
> > Thanks & Regards,
> > Tommaso
> >
> > Biju Das (5):
> >   clk: renesas: r9a09g047: Add WDT clocks and resets
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
> >   watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
> >   arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
> >   arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
> >
> > Lad Prabhakar (3):
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/V2H(P) SoC
> >   watchdog: Add Watchdog Timer driver for RZ/V2H(P)
> >   arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
> >
> >  .../bindings/watchdog/renesas,wdt.yaml        |  21 +-
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |   4 +
> >  arch/arm64/configs/defconfig                  |   1 +
> >  drivers/clk/renesas/r9a09g047-cpg.c           |  15 +
> >  drivers/watchdog/Kconfig                      |  10 +
> >  drivers/watchdog/Makefile                     |   1 +
> >  drivers/watchdog/rzv2h_wdt.c                  | 273
> > ++++++++++++++++++
> >  8 files changed, 354 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/watchdog/rzv2h_wdt.c
>=20
> I reviewed this series, looks good to me.
> I can apply, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


