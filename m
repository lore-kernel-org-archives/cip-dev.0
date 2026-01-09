Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684CD232E0
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 05:26:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4469.1767936389840549615
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 21:26:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=xJQuyaKe;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1767936364;x=1769145964;bh=
	In4c50P8ePlxgM7xX4emCbh/1P9p/P/W2KwmmxtlK9E=;b=xJQuyaKeumc1VEUzC8hKLzgGdTjMJK
	Vh6tX9Vi6D96XhmSnwVrZ+zC+6jOKXrxBwdkTDvzxtF+RFuJrlSdas9rQIBbwFNXfcSCZDuuuA/AK
	n8pTB3xDxOVY6U1vLtNOYT7cD0mcqy/Ikr4I7jGd2TW0r0yFss5bwSbAzcfB56rS5+1VulBU3MHHG
	9BCCxcz60MQGLxRZd5Tz2achW/fyhYrxozeY0sFYIWcvdiSw7AvP1BeETjYSbnwKlGTrqOYA1DQrK
	hF/WMDCVl6Hr0uSvvxQosK8GzNQMn8dlDf80ctAT0PPUddJ4c7RI4JrF30iBHvjlBbhaAI5aWPPym
	oI8w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6095Q3PD3613536; Fri, 9 Jan 2026 14:26:03 +0900
X-Iguazu-Qid: 2rWhaDm0CTINlrX637
X-Iguazu-QSIG: v=2; s=0; t=1767936363; q=2rWhaDm0CTINlrX637; m=yHP5aC9Z0sjgfeCutn+Lt/MrQRffvYmca1bEl5yMzec=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dnVcB5X6Sz1xnf; Fri,  9 Jan 2026 14:26:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DucpXF95TvkmpIU4+4yVYlH3eSitrecKy5iK7fmxf7967T3+445r8eMI3JLatcv3kQBvmxRaNQ6A2jgf8QcVGjkkBA8LBcdzIo4kDOdS4C0qgz5hb5UcpQzYjFI8NLw5sRFfmvl8rSozT6B7DrzbEAV72hOwwdpzyIRuKysnbWfIuZuf0AXfbt+fMYCaFR9XxVoDjg4UfdpQiFBT7WNeeFE1jGKgC1Zf8yL3wHxLAvEn2NjxcnBLpU/5azHwpO6ks56p98Okib21LwL7teeygwOnJdMevKTcXfoagDwomGpbB1xHwihly8HwZDeZ5BxFaVAJf/2rAC5UMH+DjU7gxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpAEtgGSERehD1t3c6iU9G1UKvO9ap84tHC2e8yyCDY=;
 b=R3S+30alqoiTAqAxAYT/RbQj1h9dnR6UumzoQLQjiPRZsocZkTj4yv8lMr+PYWTUPW/eZbrkre66WNjlOOi3uMiiNH3Jm8dyoknSKT12m/8f/LA+xQ8OrgsJYKc/sJDWoPDfzkMhI7SiyggwyM7YqPHO2T3wX9r1CG4CoGb9++Qaz7jBJdGxdrewb/RynNpgarIYkNVsaNA1wyVDuuxDdb48TJKSsUYm59KfurD7aF44CZFGiYb+/icEcMoArKq+cVYwLwNFdwnvRB746vr3IBxItMWGpU57we3xepkg1la6U9lbUKCAESYc/ldLNMYFydmaGMJ4dhBdv97Zq5zllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.247-cip68 and v6.1.159-cip50
Thread-Topic: [ANNOUNCE] Release v5.10.247-cip68 and v6.1.159-cip50
Thread-Index: AdyBJ9Q5fnEjMNbRSimA8VPpsb/NEQ==
Date: Fri, 9 Jan 2026 05:25:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C3384F8147F29D879F7ACD82A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB14124:EE_
x-ms-office365-filtering-correlation-id: 168fa781-012d-41d1-7dcd-08de4f3f91c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7142099003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UmRzUXEvSEZENk1HWlA3Ti9jajdIeVB3bS9NMEhKc3drSDl4enhwakQx?=
 =?iso-2022-jp?B?NjJ3YXFQUDRCY24ycVNzZDc1a1VVVzVLbERVay9JZ1RxK0hQa2h5UzIy?=
 =?iso-2022-jp?B?MFFKWWVrL2o5MU9pWm9FK3hYZXliaTBjemJqNVlkUEsvQ1d2UThjT2Jl?=
 =?iso-2022-jp?B?MmVoOTJUSFV4ekxCL1JYeCt3N3NRRlZKb3J0MC9ZdDhydVdsZW84M3M5?=
 =?iso-2022-jp?B?bXBqK2UxRzFTbVhaSWZWRHRTMkpWZjJIajdUdHR6QTVCaWtraU1JanlQ?=
 =?iso-2022-jp?B?cmxhRm5Vd3V3VGZES1JRYlZlSXZGQ1dkanc2dGZUelptRGJYQm1QSm90?=
 =?iso-2022-jp?B?bUJuUnlSc1VTLzhwZFhHclVCUTNGZzhveE02czJiNFR3QUt4cmptT25r?=
 =?iso-2022-jp?B?R3RhWjlJTjl6YUYzcytzQ0dSYkdyaThVN1prbFZadUd1RjJCTUwwUXJl?=
 =?iso-2022-jp?B?bXJJeStjelBDNnJoSDFYcVp1LzYzdW0renREaEE4WkF4TzdLSkZoOWpj?=
 =?iso-2022-jp?B?SVkraWVJcHFBMnRsaHJ6VTVEVFNLbGVwZEFySzJ2NFh6MTlyWm9uVTBl?=
 =?iso-2022-jp?B?VmdDMjA2bFR2ZDNzK0NXR3h4enpWTkRScnVQaWd6Y2x2YWpLWERpQ1VQ?=
 =?iso-2022-jp?B?Tk5NcVV5UU9tWFF1MUNybDRKMHQ3cm41eTJvQWIza0pnc0NZbW9EVncz?=
 =?iso-2022-jp?B?dFRmQWxlN2h6TXdra05YeDlCV2x0UzZFZHBTQldFZzZKWWd0UEF0enJn?=
 =?iso-2022-jp?B?dWRrRXVJdXJta1JEUDhSTXo1TzBla2RMN2ljcnhNc1gwS0VRWlJZRGtG?=
 =?iso-2022-jp?B?R21BSGZNZkhsZzEzY3FucE4rY2RnVUZzb3pFVmJUZk0rVmxwZWxiRjZW?=
 =?iso-2022-jp?B?WisrY29pcWJqdVkycGptczM3MVY1VmdQcmovdTJETi9sb2wwMVQyWms1?=
 =?iso-2022-jp?B?bjNpYzlLTHpkaE9FUHlUb0dJbGJBL2hvT3B0cEY1bUt6RlJGODdnR3pN?=
 =?iso-2022-jp?B?QXRNNEJoUFR3MU5icFB1V0xNQW5rY0VtNE5sSE1vVnQ1YlV6NVZpbjR6?=
 =?iso-2022-jp?B?OGlZLzVXWlUrUXpyeG5PZkNwZ0NIaUF5WWt3RkxwWVRGZEJTSEl2YlFV?=
 =?iso-2022-jp?B?VUM1VW81cWNZZEpibzNGQWFoUENRRzNjS1ZYU3Nad2tQTWJKSnpBMTR5?=
 =?iso-2022-jp?B?VEU2bVNvTE5vaWZhaVdCWjNOYXphbXlsNEpWZi84anBFMDhVUWdUQlQ5?=
 =?iso-2022-jp?B?aERtMVNhRlVVYThsR0gyRUNuTW5vNnBjazMzUGZMVmdEZEZSQTk3TWQ4?=
 =?iso-2022-jp?B?Qk1ZOS94VzJkYWcxQXM4TDZZWkJTcGt4Ym51ZG9zb1RDWkgydzIzeURy?=
 =?iso-2022-jp?B?Z0pYUzA3cDdSeUxnWElaOFFFWGJEMTBiZzdTZFdpMC85cmFkV0p6dzVC?=
 =?iso-2022-jp?B?QlNXTndPbHBzM3VqZk5CSnpGUzIxZGFQK1c0a1dwQjJhQnQ1RnUyV280?=
 =?iso-2022-jp?B?c0hWVmJLVGFwNmljZWJDSlRzRGRCd0lOemVkUkZ0MWdXcHhVc0QrWHg0?=
 =?iso-2022-jp?B?dGt0dWMzdHpRSHJhNTg1YlVDQnJyT2t1V3lmSkc5Unc1ZU05WWh3ZDRH?=
 =?iso-2022-jp?B?TEc0aUVuQXZoaGFZTGwxTWRGMVZNeG90c2J6YXlFWUpnMElxRElMRWdB?=
 =?iso-2022-jp?B?Qlo5WW1QdzhLaUVHZGI0aklxU01za3NQb2VaS0pPZVFad09QRmxkRldr?=
 =?iso-2022-jp?B?ZUkwaEN2ZmRTZEh3L04ySGhNMXFaQllIUS9qcitSMGw4YzdlU0VDSFBC?=
 =?iso-2022-jp?B?OHNzLzV1WEFvNGhCa1FHVFgxTFF2TkZPM0ZnQmRzclNCR2IvNmlUdGNY?=
 =?iso-2022-jp?B?WXFGUHczKzdBcUlMRG1rVjdmeDJNUUxZeUNaU2RsRW1tSzU5SHkvQ01x?=
 =?iso-2022-jp?B?NEtzSFcxVzl2eFdybkV5cE9wbWRienNxdGZrMmpldEkwcTdQbzdKcFIy?=
 =?iso-2022-jp?B?SjY0eXhFS0VOaHpLMEdlRzJhVy9xQ0EyRDJXWlpEV0N0RElMSWg1M01m?=
 =?iso-2022-jp?B?VFFlaUtIcVRacGYySXlCc2hya0FKaWpIeGRlVU1rYVkzdVJBSXNldmtH?=
 =?iso-2022-jp?B?SFhGN3JRWkVnQnJwRm9zRzRZbWF1ckNsOVpPRXM2V1dPc2RJTDdkTGVs?=
 =?iso-2022-jp?B?YVpBQUt0TTFSYXRaeWR0enJPQ0oyRCtw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0h6VWpkeGlKSVA5a0FnZlhwZnJ4eXREaW92ZkNUWXlRTnVpL1UrL2cr?=
 =?iso-2022-jp?B?cTM3N2VZWW5HMC9DQk1aMWhrN2JoRVYycjI4SHBJQ2hQdjYwRFkrOVlD?=
 =?iso-2022-jp?B?R05ZUVp2N3M4VVRRejJIRmZKdXVZYXphTE1lRGVqYmtvTjNudnJyU2s2?=
 =?iso-2022-jp?B?ZTdjUm5wVGxPZHd4M0duckdTNHJhN2dCbXM3Mit0eXVWejB5eHlyWVA5?=
 =?iso-2022-jp?B?RWRhNHROSnhIanZFbU1tNy9MRlhhQnp1RU9EeGVmRUpVM2sxRDRnSnZH?=
 =?iso-2022-jp?B?SGhjdHdBNHhzNU13K0V1UjBsWXIzYlh0M2dyaU5hSUUxbHVrc3plQjNq?=
 =?iso-2022-jp?B?YjVFUlNtWmRBajZoWnVnSzBjcTVBbXQ2VzU3MFJJUVZMR1JEMXc1amJO?=
 =?iso-2022-jp?B?TTNVd2FuZjRFOGNPRStQUDJjUU9iempDY3FLa2QrcHFoWlNMRjFxNUpr?=
 =?iso-2022-jp?B?RUp0S2taNkFVczBxcjFNTFhIcXprMXZibHdMWXEyZ2ZSckJKcU5JQzZY?=
 =?iso-2022-jp?B?R1V2bzB1dFFmV1Y0M3g2WktkblE3U0VreWkvbG1wd0NiK081SVRObnJy?=
 =?iso-2022-jp?B?cktpNDgwTUFQNk9YWVVwOWpnZTlTRTcwN2pHd0tRMUllVUZRdE9MRmpG?=
 =?iso-2022-jp?B?OE1Cdzduc1VXZ2p5cE5kdEVVOXdGem1nM3ExMkVBSFV2dkczS1RRa0Rz?=
 =?iso-2022-jp?B?eDlDM2ladUMyb0lSS0pCNmp6dUhUaDYxVzRzc3hlYkRuaUd3TTZXam5F?=
 =?iso-2022-jp?B?cWJVYUFpT1BhNEpxdVRRaHBnV0V4clBaZDlQZkROMTFMeFE0R3FsNnRB?=
 =?iso-2022-jp?B?cnQ0TnJlZy9BVGhCTXZFRXF0ZlRPdE5ZSERwdXlHWmRJMnRXakM4R3Rv?=
 =?iso-2022-jp?B?dHBUMXdIWmd5bkJHTFJSbWhnbU1DUm1wNS96UGFEaCtXOFM1T0l4d3lC?=
 =?iso-2022-jp?B?UVhzVGZjYTFWc2krajJEMmF4R092dk94Z3VnOGJtL3VzYkZJcVVXQ3dS?=
 =?iso-2022-jp?B?cWkzb0RFNHV5NkVPeVZodDZSQ1ZyMytuYjVBSU5GNzZOY0ttVTRTRzNr?=
 =?iso-2022-jp?B?N3RNNUViSUdqT09wQ3ZxQm5md2xrNkI3RVZlWkVmWU50RmhnWFZpUHQz?=
 =?iso-2022-jp?B?N2tKM284dUJaT01uc01LRVRqNi9wYktzUW4vc0FUcEZDS1V5eEFDWkVt?=
 =?iso-2022-jp?B?ZTBuM2RENFMrYkZOKy9jV1pDeWhXVGtpVzZrRWRmd3FLUnAvV1pZMzlV?=
 =?iso-2022-jp?B?Z3VxRHlBc0hmb0laOGVyamdXZzhRSHRaTTlnSE1JcEpGYXlmYWJqQ2ww?=
 =?iso-2022-jp?B?N2QxSU1hdkVqZk9UTE80eTNmVWZCOGU3dXpOQWxzSUthNnM0bytIQ3c4?=
 =?iso-2022-jp?B?ak5mbkFrSk1OSFhsb1Jwa3NRK3F3NFUwbU1OL051djk0WGtnYWRqc2ZF?=
 =?iso-2022-jp?B?UFJwbmhXQUxCaVU4cW0zTWdUYmtHSG9YOU5qZjZwYWJlQlMvQ29QUWhj?=
 =?iso-2022-jp?B?d0ROZ1M5QmZ0bzRLOWJWcDZDd0FseTdUSzVpQk9pb3lXNzkvakQxeG1T?=
 =?iso-2022-jp?B?bHAwd04xQzVkYWdvNm0yVVVWLzRsdDhUeURHZ3ZaV054TjFZOFdZZzRv?=
 =?iso-2022-jp?B?bWdvbXlZR1ZkbllEajd1d1ZYNTVzQjU5dFNlcGUrU3JtaFVnUWM2MTQ2?=
 =?iso-2022-jp?B?ODd5TmdSR0w0U1RZVDQ0aTh6OURRdDVhNlhldzBPUHVvWDdGVlBjeTV6?=
 =?iso-2022-jp?B?NzNiUXZkalpPNjBsT1FDWXVBV0hMc0xidlp5REkxc1YyR1I0SVRYd3h5?=
 =?iso-2022-jp?B?akk0ZlRIY2kxVUVVNEt0dWJCa1dlSUZmK3RUNXFrM2JtYTZtSDNzMWNO?=
 =?iso-2022-jp?B?aC9VZTRjbXVCYmNFSWVBNEJKRnJFZ1VyUkpnKy9manpuelZVVitOcjRR?=
 =?iso-2022-jp?B?aGNMM29uaFhGR1dtRVB1Sjg2VFo1bjRlNStLLzNtTk42QkVIbFp4SDRY?=
 =?iso-2022-jp?B?MkUxYlZrM1lYZExOeTlQbWNIYVpmcXhxWVNadmRDWSszOHNtYy9DaEph?=
 =?iso-2022-jp?B?NzVoZk5yU21kemlvYUc0TXlISUhzMjNabEE4QjVlOXc2bTVhSVpSQXMx?=
 =?iso-2022-jp?B?ZlRVVXRhTUp4eFFMYi9CNUhpcVlUcEVvOXdVMld6enhsNWdvZXA1bkVt?=
 =?iso-2022-jp?B?bVhsWWdMMVBYaU9NdnNER1JzcjYweEhiL3RNQ2RFRWgrcWZQNjN4eFVn?=
 =?iso-2022-jp?B?YUlETDFJT2dBRWVSenBzbWFlSHJIOVRQY3dTZHAremdhWElVS0RUckFa?=
 =?iso-2022-jp?B?Y0ZYa2FlRm5nUm5PWU5rRmRNcXF0ZjNaTmIxU3MvUHVKelRqOW1jQ0lI?=
 =?iso-2022-jp?B?WUNHZjRzWEZMRllMcE5YZ20rVlA1eGJka3VYcktJVFdVcnc5amQ2a0lX?=
 =?iso-2022-jp?B?Y1VHZ2grN1graWx4WmUvbEJTRkJLQ1FGK1BOQlRXNFE5bytrWjBKTnF0?=
 =?iso-2022-jp?B?Ni9yOG9ML1ZRbTZsOFY0R09tOEQzZzlXLy9DL0tUSklDUXdCRzhXZWlE?=
 =?iso-2022-jp?B?eGRmUFJacz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168fa781-012d-41d1-7dcd-08de4f3f91c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 05:25:58.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOorTvCCnJDodi4SZhdEYWPcrUqn3wj8gHdey/m3QdkbcmNlsqyNI/lz27gnd4dO0BladmZrDZQEmtLD4SwzEPS+DaK/IjK0rRwYRUXVWflRw0Q2H8Z4TASapXwnv6UN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 05:26:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21489

Hi all,

CIP kernel team has released Linux kernel v5.10.247-cip68 and v6.1.159-cip5=
0.
There are no LTS updates for either kernel. And Both kernels included backp=
orted patches for Renesas ARM64 SoCs.

Information about this release is as follows:

  v5.10.247-cip68:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      a8e956a4892cfb1679f0177eb48ef2a2d5576237
    fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip68 after merge from stable
      arm64: defconfig: Enable Renesas RZ/G3S thermal driver
      arm64: dts: renesas: r9a08g045: Add TSU node
      arm64: dts: renesas: r9a08g045: Add OPP table
      thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/=
G3S SoC
      dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the TSU IP
      clk: renesas: r8a08g045: Check the source of the CPU PLL settings
      mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_cl=
ock()
      mmc: renesas_sdhi: Enable 64-bit polling mode
      mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode

  v6.1.159-cip50:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      af5228617464dc5f255bbf5dae110cad796bcdb4
    fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip50 after merge from stable
      can: rcar_canfd: Fix CAN-FD mode as default
      can: rcar_canfd: Add suspend/resume support
      can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      can: rcar_canfd: Invert CAN clock and close_candev() order
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
      can: rcar_canfd: Invert global vs. channel teardown
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Simplify data bit rate config
      can: rcar_canfd: Simplify nominal bit rate config
      can: rcar_canfd: Update RCANFD_CFG_* macros
      can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
      can: rcar_canfd: Drop unused macros
      can: rcar_canfd: Describe channel-specific FD registers using C struc=
t
      can: rcar_canfd: Add support for Transceiver Delay Compensation
      can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not =
FD
      can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
      can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
      can: rcar_canfd: Repurpose f_dcfg base for other registers
      can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
      can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controll=
er()
      can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
      can: rcar_canfd: Remove bittiming debug prints
      can: rcar_canfd: Consistently use ndev for net_device pointers
      arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI fu=
nction
      arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control n=
ode
      arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
      pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
      pinctrl: renesas: rzg2l: Remove useless wrappers
      pinctrl: renesas: rzg2l: Remove extra semicolons
      pinctrl: renesas: rzg2l: Fix PMC restore
      pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
      pinctrl: renesas: rzg2l: Fix ISEL restore on resume
      pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt contr=
ol registers
      pinctrl: renesas: rzg2l: Validate pins before setting mux function
      pinctrl: renesas: Mark local variable with const in ->set_mux()
      pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
      net: stmmac: Disable EEE RX clock stop when VLAN is enabled
      net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
      net: phy: add configuration of rx clock stop mode
      dmaengine: sh: rz-dmac: handle configs where one address is zero
      net: stmmac: dwmac-renesas-gbeth: Add .init() callback
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Fix pinctrl node name fo=
r GBETH1
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable GBETH
      arm64: dts: renesas: r9a09g056: Add GBETH nodes
      dt-bindings: net: renesas-gbeth: Add support for RZ/V2N (R9A09G056) S=
oC
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for GBETH0/1
      arm64: defconfig: Enable Renesas RZ/G3S thermal driver
      arm64: dts: renesas: r9a08g045: Add TSU node
      arm64: dts: renesas: r9a08g045: Add OPP table
      thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/=
G3S SoC
      dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the TSU IP
      clk: renesas: r8a08g045: Check the source of the CPU PLL settings
      arm64: dts: renesas: r9a09g057: Add DMAC nodes
      mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_cl=
ock()
      mmc: renesas_sdhi: Enable 64-bit polling mode
      mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
      net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks
      net: phy: micrel: Add ksz9131_resume()
      net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
      arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
      clk: renesas: r9a09g056: Add clock and reset entries for WDT controll=
ers
      dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056) suppo=
rt
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on RZ=
/V2N EVK
      arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
      clocksource/drivers/renesas-ostm: Unconditionally enable reprobe supp=
ort
      dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM ins=
tances

Best regards,
  Nobuhiro



