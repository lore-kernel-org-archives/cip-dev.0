Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A82CC369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 08:45:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.3744.1745397911717939893
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 01:45:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=DjVqTIOf;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1745397902;x=1746607502;bh=kOotpzjOIPL6gE/se0iIWkWEQFcPrN5azS5jc8v
	IWjc=;b=DjVqTIOfwHzlVEAIlir1cDYGHGGOqvrPDMCS8w1uteI++5rWCE06AWVWsDbieWkCUW2sH
	6tWE7R7lu7vA9Gw+x41BFVohzD0Re9WQOFrfm6di+UDCKDpeGxvloILv/Q1e5JgdxKX4qqnb/Yd5I
	RrPCmeFTV7q8bgWf03QDNwpZdiSJEnEG4pgCzQQkciWFHltIl2CrXutlGPHTmuPE19Mt+TTZm42KX
	Z7r62gLHOZh3ymcOasc2Bz1H9Xn+7WdbaM5fCSVyedR6BOWNHiby5/3b1+HDT+tj4YtxnLNkxqlML
	Z+tCuVn2i6s1xE7NDZEoDIbIWLnBRAd7lsbsBSaJZQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53N8j2Jt1416119; Wed, 23 Apr 2025 17:45:02 +0900
X-Iguazu-Qid: 2yAbAvUQNKiqUCMnKS
X-Iguazu-QSIG: v=2; s=0; t=1745397901; q=2yAbAvUQNKiqUCMnKS; m=0QwiJB966DAsLaMruaUturrp91ymDO0oyKHBjkDIM2g=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 53N8j0981387525
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 17:45:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnurIrU9laiSd164XkUq8kKEEp1sG6nx+fsD6QdwAMHrVTkYOk0iNBDjIzHP/ACWyS/QwurZwhzLc7NbNPr/tVCgUoomAYWcWTi8dfZiBJsvi0zMuSWPJpwwJ9asdz3vQvMCHsSOZ9OlMBcpVOIxY0GJsyAiynjYp+3aqU5Yn6HZRZ6fBWMtJaUDVG4ndb+kfhDeMsaEOAAksN0DM6PyxX5DNq9o7NGQUgUasVfjeb5ZcOe+EfZkM9BI3BaVkSqxOe6w9y+hZS0ZbdFLWF25dFbfdUluVUO2ccij0lJ6a35p8oEZKbc3PyPPxynZ8TWdsI7Efiot0Z0pJRgVCWLfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnHio7LYnDoj7SB2CZhITjkY9xVc+pzio/jJxq00Zuw=;
 b=dSki+UM9DSTXlG19hxC5IuOQD2TcPCISxIMK27zAevx4fu0vjBv1wX1gsMrgSnXMnRPhghUfXXktysD39xuXZbAJmoealzHmSESsPHnzsf2oAUd9NRuDRA5Uloc7q1T6ptcbRGqmrCgqgHfvEEDl2yhId4SMHfyRtMCd3KN+LfYESub3epr6MGk5OnOSPjRnut3SvxeZ0Mg3LqLfOHNznWRw82u2Jkf+5S8kkVF8evOrBEZgPYlmptWgmBxxXCOkRCCve9CLgZW3lHe88/kSHOqpKKwLK6Jrm18HVY80Y77zrFOtVbZ4F6v7pdgis8C6WyMEqanB0ALWjzco9bAk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock and reset
 entry for DRP-AI
Thread-Topic: [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock and reset
 entry for DRP-AI
Thread-Index: AQHbs22y5I4nA99a00mHBXvggHrcHLOw8OaA
Date: Wed, 23 Apr 2025 08:44:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808326EE56BC7AC4472AA1492BA2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <20250421184657.633352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aAdpKSG1uUgP3QzT@duo.ucw.cz>
In-Reply-To: <aAdpKSG1uUgP3QzT@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|OS9PR01MB15463:EE_
x-ms-office365-filtering-correlation-id: d7b75b44-f76c-4b86-8175-08dd82431f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZVBWZnliQTU0R1BLQUhPMm5tclRnVlZza3hRWHBBdTJ5NkZiR2Y1NHFQ?=
 =?iso-2022-jp?B?RmU5R2VyZE1hS1htdnc3MzRBWUVGb1pWM3FmR21YS240N2FDMlYvRm1F?=
 =?iso-2022-jp?B?KysvcGRxNU9LcXhtY1ZsNklDRm9YMWxFY2htM0dyT25POWpFWDJMZUJD?=
 =?iso-2022-jp?B?V0JIclZzQVY2QXh1S2toZTl2bFhuOGpHdUsycTh0dFJnRTl6MXFxcVhu?=
 =?iso-2022-jp?B?RTcwWEhSOWpTdnRIbWNpY2dvOGVudUZBNEhGQUFuS1NTSFVwUFNwNGty?=
 =?iso-2022-jp?B?MTRWUWtYelB3OGlHeHNocUdtY3o0Z1U0UEdEVlJMZnd2S0JzOUs4bmdn?=
 =?iso-2022-jp?B?dVNMd1ZGVVVSY296ZnU0QVhKeTJSTURYOUovdVBKY3BTZnBmNWFvekdv?=
 =?iso-2022-jp?B?TEVLWE5QL1QxVGJtaC9hVVd5RFh5ZmtkU1FtMGVNYXQxN3NBcTVUZTRi?=
 =?iso-2022-jp?B?a0JGMzI0N2tvUEVGclhsbmcreUR4YllnUEdyU3dQWXgyenhUWmovNzZK?=
 =?iso-2022-jp?B?aWZ5U1lLWnBXRE9FUGl3ZnZaVW4xaTF5RmphYjdiaG44eFQ5S1RNR3NB?=
 =?iso-2022-jp?B?OVN3eThVbTdWS3o4bndrOWh5VkZ4MFZJNHRRTVQ3dm15WXhqVGQ5Q2xs?=
 =?iso-2022-jp?B?ZWZuaXBub0xFVUt2MGplWExZMmtiWVNCeERkcWNadXA2S0JpTlI0SUFI?=
 =?iso-2022-jp?B?YW1FWmI1WjNESEVDSTQ4ZGFpeFprbEh0ZzYxU1RnL1hQMHlFeEJPS05J?=
 =?iso-2022-jp?B?Rm1SS1BSOUpJNUMycEMyK09PRDR1aVRlN1FXK2R4VWhuT2N1SkpqWGRC?=
 =?iso-2022-jp?B?Tms1U0VYaXJNNTFVd245aFd2aWZzOWZwSUFSVkNiK2k5Vkxza0ZjS3c3?=
 =?iso-2022-jp?B?UTVISks5bzR5T2tqdDVueXk3TVFCdWNiVzF1VjFjSWhrNlFQS05WTGlT?=
 =?iso-2022-jp?B?MHNnemJraklOa1dTY1RNMk1SY1lvek93b1dFVk9mTHQrWEZwZkQ0cGJX?=
 =?iso-2022-jp?B?K1ErVVRQK0c4YU1IZHBXT0ZIZFZ4TXBPZ01uRENiTFE0a21PZ0Iwcnpv?=
 =?iso-2022-jp?B?MC9IV1FSWEdwWjFSeXBVU3BjeU00MWdOcGJwSGdkRDBHQ0x5eWdnNHZv?=
 =?iso-2022-jp?B?VEJ5ZTNSdk9jMGt2WG94VVRMdjhyRzhnQW1TTTJqZnpXVkxTK3pJMHFB?=
 =?iso-2022-jp?B?cGhBV2FHL2RzVU1SYndtaEh2NmQ5NHRwbjNyelI3b1lvNWF3eVJFRUpx?=
 =?iso-2022-jp?B?ck1SQUlqWWp2N3phZnRoVkhSaHR3ZTd1Sm4vQVBkQTBxZXBlRW5adSti?=
 =?iso-2022-jp?B?TlRSbUJpZ0JWd1JvWGtJcWFGWC8vb0xva1piUExWRFh5Rk5aY0RJMkp6?=
 =?iso-2022-jp?B?Z3g0b2lGUndrN285c2FKOHQ4NzAyMlU4VkxwQmRXbk4wTnFIQ2xTOTB0?=
 =?iso-2022-jp?B?bTNzY3ZXZTFmM25sNnJxelVZWjY4ZDE5UFY0Vlk2QVlxQTJXdVJwTGhm?=
 =?iso-2022-jp?B?QlJzdFZzcFdjazRITHpWZzhoUnd6bitqTjVoemlwaVVZWGcvaENXYitQ?=
 =?iso-2022-jp?B?U0Y5eUF6MG92ODI1UDN4K2MvenN0T2tFUXdlR2RZMmEyTy80V1plRmh0?=
 =?iso-2022-jp?B?cFZVL2FvR1R1a1RBQzdxdkFnb29PUnNURG5XN3FLYlR5aE1qcVZzMWZK?=
 =?iso-2022-jp?B?cWMyTmJ0WHVYWDV5SDJEblhSNElXdlFnNXdzRlM5bmc1d1JreEZRZGJ2?=
 =?iso-2022-jp?B?ODlBSFJkUEhzL3pybEpIaGZma0kwcHkxdUF5enVNcGJnUzA4UnA0Q21M?=
 =?iso-2022-jp?B?SFhjb1ZRNzhrQ1JKOFR2bU9DdnRlY2NFbGtyRlB3bWJtSkpQSzFBTEYv?=
 =?iso-2022-jp?B?YWR4SWd5ZFNLUk5FbTdQZlp6anBWbG5vaWhjL2tjSzl5OStHdW1FWUpK?=
 =?iso-2022-jp?B?YTdudExzckJERkVzeUVoNmk4L3lmZHZkdGhZYUVhY2xVZy9FV0JyR3pK?=
 =?iso-2022-jp?B?enpwWWxULzg4enozUFNkY0pBdE96aFp3eUcvNW96dWRIMTNuZWltU3RE?=
 =?iso-2022-jp?B?cGVvbWx2WnJEZW5MUEtRem16YkpDOGtMRzNEdllhRXhJQ3h2N1ZaYWNa?=
 =?iso-2022-jp?B?LzBTeWNLVkFBR2I3enNtT1l0UjkzWUdnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RVorSDNsMjZ4b0lTRm16aXRORk80aXlTVHBRdm4zWEdlbHpWTDBteFNh?=
 =?iso-2022-jp?B?QllSMDR0eGFPOWRwYnFQdk1wd0IyaHY5TmdpWjFFamhNRWdEaTRKTEQv?=
 =?iso-2022-jp?B?V1RZU2NLMVlSdDRpeHJmVVhyVC9McC8yVnQyVERHQmFuVUVIZVFGbVFS?=
 =?iso-2022-jp?B?Z0FEZnlpVnEzZmdQdERPYlJDZXhrUTQ3YVFwcmU2Y3llWkd2VytBcEpP?=
 =?iso-2022-jp?B?T3p1M3B6d2Q4Y3EyMEFVdll4aE4rOUVac2ZhOHQyclZCZW5iL2ZJQ1d5?=
 =?iso-2022-jp?B?L3ZPaDRKRHEvblE4VHFDdEJZaGpmSnA2TUxJWG05eFpKcmVQNkgvK0Vi?=
 =?iso-2022-jp?B?dUhrV01tTWdTclNZNHNxK1plNVhOZFM4UW5adWNmd3poOWI4S1BEQXM4?=
 =?iso-2022-jp?B?TTBSUUNiZHdtSHUyTDM4ZWZDbS85WGlLa01GS2NuS25GYm82NFpkdlM3?=
 =?iso-2022-jp?B?ZzFyUnlhR2NLZjhzSHFqRXAreXJzbnhKS1Yxem5QNU8vTXcxdklCQ29h?=
 =?iso-2022-jp?B?M2NOaWF2dVo5UkRFREdnZllaTlV4SE96WUVCN2RBM3dpd2cyUldQSVRh?=
 =?iso-2022-jp?B?TzNXd3pqUlhYRWUvWVdwZjEreUNWWVRpdzhuakh0cGwzNEJGOENCeGVO?=
 =?iso-2022-jp?B?QVhNL2ZmRDlDajNZemhmN3VicVZJUzY3cjFNM1IrUUpXb3o2bkE3dk9k?=
 =?iso-2022-jp?B?a1NoMzdUQ0trdlArNEZ4V0xRZFUwZmtwcUhkK1VXM0ZQU2YrWmtQbEtp?=
 =?iso-2022-jp?B?bjVSdkhnalFKN1NlUUtTL09WTjBsUkNDZFltLzB6WVY0T1E5bHRreVNt?=
 =?iso-2022-jp?B?WGZOUTNNczZaa3k1aXY4bFJMUGg0Vk5vZnZ2WVIya0ZGU0t2U29oYTFv?=
 =?iso-2022-jp?B?WmtVbG0vNGxoSE5jZkVjMlhVYXhvZUxqN3NaWkFBRUR4dVJpNXpKVEVy?=
 =?iso-2022-jp?B?SGhMaUd3dzIwVHFFVWIyOFUvcTRVZUl2bUFZNWhPei9CMmN3ZVBKd2I1?=
 =?iso-2022-jp?B?TlkvSllnZk0rMjRpVExQYkZqcHVPbWloZ1ZJK1lhOVRlR01aQURQQ1ZN?=
 =?iso-2022-jp?B?KzdNajJVbHFTYkVxUzRBWEVMb2djaGdHYmQyVWV1eU1PNVo4MGtrNXpX?=
 =?iso-2022-jp?B?ZVRuNXRjNm1JSFBiV3diSWNGUGc4aldMSFVmczRwTFNDR2xHQ0dNWExF?=
 =?iso-2022-jp?B?MmJRdE5lR2FpZW9udmJJY004TkxaaStwTElwTE4vWGdOd1NFUGVzNG9u?=
 =?iso-2022-jp?B?VTZMTWhUcW5SdVNVT3JSWkxCT2pOd01vRkRVRVp4cGlkVjlFMFRCUXow?=
 =?iso-2022-jp?B?WDhWWHNTZGJMemQ1VE10VUk1V05GRkN2aThkaVFIR0hHWG5GOEttUnhw?=
 =?iso-2022-jp?B?TFZWK0pTdDVwdTdqVVcxRUQra1hFYXRZdnhud2JXVmE5MUZiTHdhc3g2?=
 =?iso-2022-jp?B?enJTNlRuOE5hRlFNamZ5aXczbzM0cThZZ1gwMTMxMzNNVmVOUHpWWWhk?=
 =?iso-2022-jp?B?aFI1N29OYy9IVkM0VFNvMStTMGpXUEl1NVJjQ1hpS1BNb3pyYlVXMkpr?=
 =?iso-2022-jp?B?WWo2N1FaQS9SalBxbytaWGdEaU54OUo3eDFLYnBYZVJRQmpvUjhhWlJz?=
 =?iso-2022-jp?B?a1l1QlVWZlVtUmJ1Q1ZMbi8vaTRyRWtmWFB2bHdQa1J6dUlIRWwrZFBK?=
 =?iso-2022-jp?B?STJjYUUxelF2NHhoWmlya1BSZ2ZvdVdsaTU4WkFZOEJ0bElEYk8vVmpH?=
 =?iso-2022-jp?B?WHRCTjdFOVd0UTBMWW1UMVlaOUtTbDRKeDlReDNGZGhGdFh0dCtDYmdm?=
 =?iso-2022-jp?B?ajBuVkk5TDlucFlad3ZoSFh3MTNWUnByNEwwM1cvN3p1cWZiZ2RxMVN0?=
 =?iso-2022-jp?B?MEdQR2ZzY09YazFEMEJIS0VuQUNzY0RSbFBOT0ZON0thcUFZL3lGTnpt?=
 =?iso-2022-jp?B?RHFjdUVmOU1VM0pFMjRlbVMzQ0lqZUxKODc5ZVNFQXYwT1FLb1lsd0Vn?=
 =?iso-2022-jp?B?V21CK2tXbTFOeGw2TjBFaHMrOHZVaU1vMSsyTGhmdERoNnhxdFMyMXZP?=
 =?iso-2022-jp?B?THNlYWZqaFViV0hNQTJsZkF6L2kwMkNnL3pnNmtpbm55akRwVkFVVlFq?=
 =?iso-2022-jp?B?c2MrRk5pTTFtMXNnRStPVHYyZFZOTUJNbU1uUTNhTzZML08xOTVaTE5k?=
 =?iso-2022-jp?B?WjljNnZOMUJRQlhsWWRnZGJFRkpVa1d4c1g4V0VQbjRFeFJBc1MrcFU1?=
 =?iso-2022-jp?B?dTlGdXM3blZrQ1AzYWY3WVVNZ0RNeFAvVGNxTytQUEt6dkM4SnRNM0Zw?=
 =?iso-2022-jp?B?bVVGd1JFb2lrWGFrcWZpdDRqZHRydXI3Z0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b75b44-f76c-4b86-8175-08dd82431f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 08:44:55.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpsv7cxIF+MXJQ9cNtBayPGM4rffw+c3chBPLYfKpoJzOySfhD8j54GiZaQZZRWYSsOEFFWpuJQ/RzXsyXeCY/6v0A/xFUsa0z1F1Gl9rZX59d1+29Z7aehfRVbCHTtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15463
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 08:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18565

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, April 22, 2025 7:02 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock and re=
set
> entry for DRP-AI
>=20
> Hi!
>=20
> > commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.
> >
> > Add clock and reset entries for the DRP-AI block, which is available
> > only on the Renesas RZ/V2L SoC.
>=20
> Looks ok to me. Both 5.10 and 6.1 versions:
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
Looks good to me, too. I applied this patch.

Best regards,
  Nobuhiro


