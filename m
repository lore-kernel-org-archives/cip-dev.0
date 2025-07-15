Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E25C83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 08:06:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.2963.1752566812568251949
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 01:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=d9QP9be5;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1752566794;x=1753776394;bh=B8
	UPBZBKaG5FOh6bvbuTTK9dRh2mz/b/RcSCMkj0MfY=;b=d9QP9be5ggF9B3iXIOiOe5S9l/6Z+9Ky
	V/0Yjv4NrednyOTVol0eJfEBf1M4X9vy2+x2g27dvuKNS47B9V4Hfa6SF0gPVmkWEZhawT067SGLd
	qMdmU3wGkSwl1VQE4R0bBQAKae1f7E6lmoi8kom5MHcEYA8uwMUahvcbksOREzJsRduThllEEUCf4
	YpDp9TkMbpYL2a1gSarY2/npJGM1UUtjSXeL/XUFt8ViNs+smnUU/aCJsnICSdA9Qw5/7cCQMB/Gi
	XYI/MYlO5NQgXOaPRhbV2BU/+4FF8GFzf4dVZFXg1LAxdwesVReQfclH+Y6zKVxgJAtp9HzCiq10F
	yg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56F86XBo386313; Tue, 15 Jul 2025 17:06:33 +0900
X-Iguazu-Qid: 2yAbG2MEIyXfD27NNB
X-Iguazu-QSIG: v=2; s=0; t=1752566793; q=2yAbG2MEIyXfD27NNB; m=GcPWzIUUNhFE49bvPihGW+qxdwb3b4ob1Yg7XTgJvo8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 56F86VS43098681
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 17:06:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUP5XBZk+Xn0+7JFRvjNF9Hhp5/Z7FV57zxOcI0M2Wy36TeKbS6FshrJTnXg4jkzmyxlplQkF616V9p0zbC6lFgtKfasqp1LU+8xS1ODbCL1BLFmEvv64e36MBRAUCGd8oFuice/XWmTmUhkSXNdGGvuCFH7apoCIs5GfWU4gk8XO3gE/HloHWgKo+PHquULesmv6UUkPZKHMyzKD4311Of6vJYAebeB//ckNwpzF3ntsefx6dQhvoMPtwpE367ikD+5wIuak1hCR/N5diegq8zcoksdzF7/sxi9voUhaMBkfr3op2XZ33HTSwhwSGbXDEdib0cs9CrPruKLfy11RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWHI334Yx3nTe+EWq38ExlmEbN09YaTComoIei6tkVk=;
 b=TYim659RHNTFkUDmrX9omfZ6/TuAmlclh8oDokclAWyLSpPISjCp+xaeSJhrwBEa1GvTfyUHXSbQgf1Nbo+l/5oYo7MbetJLh06jdnqNaLJ5C0DesK7sSzjXwWMi0jjJy+1nVzyiobri0SaK/jEhOeKLtilz4GY36MHg1Q+xSi14YVo0v+DNavRGCkBo8Wo0VrcT3koJM7+e7P5b7Yn+/yXe1wJO4Sl9h2X/FPnVWyEek8WpRjdLkiOBowBMtjYdtj6eTlhvdo1oEQnOXIyb9QqC6FPWiONwdtxZjdzbUbORN63G8f3SPB1JJMnfZ81ugrUScbOKW15mXzf0DXKQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.145-cip44
Thread-Topic: [ANNOUNCE] Release v6.1.145-cip44
Thread-Index: Adv1Xy1UoXCELFAwR9m2r1kNXnVaDA==
Date: Tue, 15 Jul 2025 08:06:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYAPR01MB5498:EE_
x-ms-office365-filtering-correlation-id: d4848336-d67a-4740-4dd4-08ddc376803b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?KzJBRmJYZmtYWG8wdEM0eGZ6SGpqb1pCTzJxOFVmNElmQS9YbXlPODBi?=
 =?iso-2022-jp?B?TktJL3RsalU3ZFNHbHRzdmY3TG9PaDdEcE1abkYvSWV0bVFKZ1RJc2xk?=
 =?iso-2022-jp?B?QmNxQ1J0YktiR1dneTZzTXBZSGh0YmpIblpGbytxZURzaGQzZ3c2dHB5?=
 =?iso-2022-jp?B?c1NXcXZzUS9LVWpBaUpTUmZJU2NZQUNFZ1ZIK0I4dHVjVHNFZFJBYU9w?=
 =?iso-2022-jp?B?Qk1TRlpjVkFhcDU5dVpPa25Yck1tZjYxQlJpQWZZSXdza1g5WFg1STdJ?=
 =?iso-2022-jp?B?KzlyM2ZEUGJuaWpFSmdYa3haUi9JOHFRRVpGZFpFdGxFOE4yR1dhS2lL?=
 =?iso-2022-jp?B?STgvSFlrZUYvNzNjSGxQVGxIekhZT3o3NU5xdWs5MEVtcUNCOW5IOUpR?=
 =?iso-2022-jp?B?MUdGV3RpK0duRytybXNsRjBRMzFEVkVSZnd4a1J5MGgrTm5tTDJia0Rv?=
 =?iso-2022-jp?B?YmplZlJ2WmNQc1lhMFlZZ1p1QkxEM3M4eGhlbE5mcENrdDB5RjVYbFJx?=
 =?iso-2022-jp?B?SFdyZkxXa0QvYXRHUnZxMUM1a2VTQlJwY29LN3RwaEE0anRVdG5qaXVY?=
 =?iso-2022-jp?B?c2dpMHdkQnBEOVRKVk56c1ZxUEJURFAzb3lmWS9jdWlzVWk1UHd3Y3dJ?=
 =?iso-2022-jp?B?Y3NZSHZuaDRSQWRJczgzYjFoTkhXZzhmcXR2elpFTks5MFVFMHhRZm85?=
 =?iso-2022-jp?B?UXlvc0tPamNOTmIwemV5VGo1ZTF5Qldnckg2T0d2T1lSSFBaVGJaR0d1?=
 =?iso-2022-jp?B?a0s5cHdPMEY3c2hoenBGb3NUWUxWMW04QXpGTTRqSDZyYU5HU0pmS1VP?=
 =?iso-2022-jp?B?SFV0Vmx0WkpHUm0xQUU0WTBTNkNrSUVTL0JaVFA4VVZOdi9GTHdaRmJZ?=
 =?iso-2022-jp?B?L1RhWnN0cHU0MnZKdDA0N2J0dUVMMU4rQ3pVS1ZOWGJxc2hwVEhHWjlw?=
 =?iso-2022-jp?B?eUNtMG05T25rcFJpWkx3VUR6QStxUjd0eGlCOGJYMTliRVpDLzYyRi9w?=
 =?iso-2022-jp?B?cGZWRHB3aW9MQVo5L0loR1Y3NWNjNnJRRzdhSkQrb2ZPYytSdVNjOWZp?=
 =?iso-2022-jp?B?ZEN5VkpkOVN6T09PRktUQk44V2xFYUJONFR0SDl1TGdvTmFZSlpSWCtF?=
 =?iso-2022-jp?B?Q3IvRDMxYVB2VjBRYjgrTXNkWnRDd1RHdk93QU12L2FxZkxtekdzTC9a?=
 =?iso-2022-jp?B?U3VtY2FMSTBNeGZ6L3B1QlQvT28yUTRZVGZmWmtQa0pXakYxdXVOd3Rv?=
 =?iso-2022-jp?B?NkIwVHg0ZUEydEZEaFFEQmlVYVZTOEdZS0tKZ2kxRzAvV3hsVHl6SGtF?=
 =?iso-2022-jp?B?a1dKQWNPckd3b2taaXpBekpKVkRwVm9TWFZvdXpjRVI5L2pmUTcxNWhK?=
 =?iso-2022-jp?B?K2pYY0pSSnR6dkN4RW5kdVNDY1FDdXVQYjgxTElBTGo0WTFXM1RaUjhS?=
 =?iso-2022-jp?B?R2xPL0UrbW5xQTIrZ2UwTFQ4Nm5jS3NtRHZJVHVNS055OUtRRXg3Ykl2?=
 =?iso-2022-jp?B?NE96RHZLTDJQNTBpUTEwR2hkN0xOTE5uRWdQOWkzUkJXN3E3cmEvVGhB?=
 =?iso-2022-jp?B?MHVYMFZ0ZENIQzZhcnZrN0FtWE52Q0F4SzUyLy9qTFJreUlhU3pKNlo0?=
 =?iso-2022-jp?B?NWNsZURXTEVNMGo0dGxNNmp5cnJIOXJaQVR4OFhMYjdTemYrVHczdG1m?=
 =?iso-2022-jp?B?YUswa2Z6c2dabityclFCcWpvTEMvajJhSm5KcElSbXNwdUcxNmJ1ekRF?=
 =?iso-2022-jp?B?Y3QwNzB2b0FNT0NuU0lJUzRreXRFQ2RCNitqTFVveUNzQU9OZkl4dkJX?=
 =?iso-2022-jp?B?bXd4emNyZjhGcDNSN0ZLZm9kbVpCUmdHcC9Bb3JWUm1pb2YzTTVja2pU?=
 =?iso-2022-jp?B?dVVyQnNaMm9nOUJHUG9SbURBblZoZnVzOFZKNFh3Q0VXbWpyeFJTMzQx?=
 =?iso-2022-jp?B?QXJITlJwUFphYm9JTG9KMFdnTGIyRVhJanlaSzNQVThqZTF6SlBTdEk1?=
 =?iso-2022-jp?B?VDNOd09LTWpIUkpQdWhQR3VCNk51MHA2RjhIRDZaVUkxL0J5VU51SU1h?=
 =?iso-2022-jp?B?emJ2S09CeDBRT25wVzNjWWpJZ1pIeXNtMmVNc0tVemh3ODN0dGpSNXM4?=
 =?iso-2022-jp?B?RzZWcFBNZXN4azh5ZG1vb3VPY2NkTnlkaGtCL29CbDdZczFEZkJ4Z1VQ?=
 =?iso-2022-jp?B?WmlZPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cDlMQU9qbzNlaW0yMndKYS9KQnhiakJzbzRlemduM1YxR3hMeS9INFVh?=
 =?iso-2022-jp?B?UXJmOER1SklmeTdQUFVxVG8wOTNVYzJ0a0syU1pmaTdxRDJPSWVUUWRn?=
 =?iso-2022-jp?B?cTVCQzFlQ3FxT1dnS1dBczQ0a29zN3NWdXBBeVlwMTRzOEtuKzRnZ1Qr?=
 =?iso-2022-jp?B?QzQ1VFVRREI4eGI4U3BXZTZrOXQ2OXpRaWVRS1k5emh1b1BiNE81MVVu?=
 =?iso-2022-jp?B?K2pGakpaN0NZaXdaUno4RVowdTF5N2JaM21QQWFLVHdCeUU2OG82YVVO?=
 =?iso-2022-jp?B?bG5kMnplT2pZNndHeHZjUSt3NXBLbU90VHlnVytqNTVHNnBiRXBsU0lT?=
 =?iso-2022-jp?B?RHVmSTRsUnhLUnVTUjJKNWkwYlRDeGtMbWo2UmUvVUpGUUVERkVja3NC?=
 =?iso-2022-jp?B?eWpGb2p3ZEhPSzlOYzFoOUh4VHZWTFI4ZFVMYVpmSjFNaVdQRy9jVVVY?=
 =?iso-2022-jp?B?WHZOemhLV2lOWEN1bmZHVnNoVkFNaGtzYkd5YjJnZCtab1NqNHI5OU0x?=
 =?iso-2022-jp?B?TlRSY3RWcktyN1RQS0IrSTkwSTNVLzJJelRSc2J4YzhEVUFoMFpUWWtZ?=
 =?iso-2022-jp?B?aWNVNjI1ZzFEMkRIeFk3alhLWVdJNktaQXdxTzBJNmlzWjRLalNmeGRX?=
 =?iso-2022-jp?B?S2tMNERhZmdmWHJFMGJtWUwvUUtxd3hKL1hOZXlFZFI4WVcrKzg2U3B2?=
 =?iso-2022-jp?B?ekNOUGRyZWtrcXJOMWd1MWRVMTFFTTJxQWljbmNPQUpxQ3VGc2hKVWFx?=
 =?iso-2022-jp?B?THhWQjRCK3ZBMXFNRnZjbU40SXJHMy91VjR4SGFoVlhYakQvV2trY2Yv?=
 =?iso-2022-jp?B?QVJYMkZsNElMK3gxS1IrOC9RaUJFRkI4amQwU3hQVmt2b3Q1aWg3TlZv?=
 =?iso-2022-jp?B?YkkyT0w1ckFxMHkrTEgrNGhIVFlVZTJXc0creWJCR0NVSEdKVEtXSVE2?=
 =?iso-2022-jp?B?TldNakFwSUpFWU85REFNQi9ZY0RCazZpUmErU2NkVDN2RW1WWERaN251?=
 =?iso-2022-jp?B?OGt6Yy95dlQ1VU1CbllZc3NrTmJaL0FOblBUcXlSOE1KVzhsd0YwQ0VK?=
 =?iso-2022-jp?B?QlZsa3lCMEE3TjNXdHd5azVCakthcHJlQ2FoUWdVRC9uYUt4UGJ0YjQy?=
 =?iso-2022-jp?B?MysvbzZGbTVLWTVydkUyVVRBcUl4T0FUS09UUFNUY1lnL2M1dVQ0Smk4?=
 =?iso-2022-jp?B?WUVaM0FrbXZJTDdkdnkwczlCOUFGK3UyN3RSSSs5Z2hpK1R5SGVjaDNp?=
 =?iso-2022-jp?B?YmVISXdzeHpIYkxmeVdLK2VleHg2ekc1cDJLOVMvZWdkY1p6cEdoQ1Zm?=
 =?iso-2022-jp?B?QlJBQkxnR29vSHNxcFpkeEsyVmovYnRQQzN3cVZwNEhIV3N6ZU1Zem9R?=
 =?iso-2022-jp?B?MGxqL3hxYjlPbC9yZ3Q3OTdISVF5U2krdzh4Y24zVVVSdFEyVkxhVXBY?=
 =?iso-2022-jp?B?dHMwOHBocHRFL09UNVlPUzk1VzJreG5CaDRxc0tXdzY5NDk5YTVnd2VG?=
 =?iso-2022-jp?B?cG5XL3owbVhXTHRiMEF5WkthMFlIQkxBZjR6S2hNOTkwcHdYN0JTckR2?=
 =?iso-2022-jp?B?SnRyU2s2UEtyZG1SZG1vTHMrSW1aZVd4Yy9pT255K3pBMXVZNTRJSEth?=
 =?iso-2022-jp?B?d1BmcnBsdHNDaFpHVWthcnBKci9CYmljeGl6L1ZRMys3M3RsYmNlcDZl?=
 =?iso-2022-jp?B?UGs0QURDamZ0aTBFOEVDWnlsL0lyZjNES1k2TzAzbTY0Vi9HdE1Ubm1h?=
 =?iso-2022-jp?B?bWFhZ3BiSjNFSkhIdmxTWTBxUzczcU9aZ0s3T3kxcDFydkpjcXg1WWY5?=
 =?iso-2022-jp?B?Qno1aXk3djBDeHdlM2JRVlVabXVMcUU1V3lPTGRCNlZwVlN0cmRwQmI3?=
 =?iso-2022-jp?B?RGtKdEZENlBKUVc0cU9xTGc0R1BLUFM3RjhIRDlZNllUVEZJdExpODUx?=
 =?iso-2022-jp?B?SVVYdTQwWFhWWnQ0d2d3ZmVQYkVUS1E2bllaWlNZVGl5NzRMUXdvcDFF?=
 =?iso-2022-jp?B?TGxiY3d6dVBadEtueVdsWTdhc0tNb3g0aWdKSjNaQ0c1c1h1WGdSQzg4?=
 =?iso-2022-jp?B?akVPWStORDJXdmNMUGFXZzF0eTgwN1FiUEVlUllLZWZpVVVpbUlRWUlC?=
 =?iso-2022-jp?B?V050T1pjVFdPa2l0dXYwNjkrOTFPY0VUV0k3YkgzdCtTNE9wbE9HSlcz?=
 =?iso-2022-jp?B?alM3aGZzMHg0dDhYRXl5Qk4yNFFPWlRBN0RyYkV6aHU2Nm1MNCtncCtm?=
 =?iso-2022-jp?B?ZnhSTzZBbnBna0NudlNJRExDUk5Fc2NNc1RLVmVWcjBGMFpoMUJWeGha?=
 =?iso-2022-jp?B?Y2lDS0w1SzhtWDVuYy9PQ0YwdmdQTGdTNWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4848336-d67a-4740-4dd4-08ddc376803b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 08:06:28.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Srod8e6gFcj+wNu7SfY46itF5hLVV7E5dKba7N2gyQcG2fAwoiJ+43CYEIoGY3N/CYTOa2f1mrkQmV6i/qzTCMRHG45Rgc20bphfD4ddfnvZhByo0VpU32Dh8P9yhos2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5498
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 08:06:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19533

Hi all,

CIP kernel team has released Linux kernel v6.1.145-cip44.
The linux-6.1.y-cip tree has been updated base version from v6.1.141 to v6.=
1.145.
This release added updates for iio, clock, mmc, irqchip, and drm on Renesas=
 ARM64 SoCs.

Information about this release is as follows:

  v6.1.145-cip44:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      d31d18a3a01aec488157b5c8aca68f22a8afe3ba
    fixed CVEs:
      CVE-2025-38148: net: phy: mscc: Fix memory leak when using one step t=
imestamping
      CVE-2025-38119: scsi: core: ufs: Fix a hang in the error handler
      CVE-2025-38154: bpf, sockmap: Avoid using sk_socket after free when s=
ending
      CVE-2025-38124: net: fix udp gso skb_segment after pull from frag_lis=
t
      CVE-2025-38332: scsi: lpfc: Use memcpy() for BIOS version
      CVE-2025-38227: media: vidtv: Terminating the subsequent process of i=
nitialization failure
      CVE-2025-38118: Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_c=
omplete
      CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_r=
eadback()
      CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period
      CVE-2025-38183: net: lan743x: fix potential out-of-bounds write in la=
n743x_ptp_io_event_clock_get()
      CVE-2025-38331: net: ethernet: cortina: Use TOE/TSO on all TCP
      CVE-2025-38213: vgacon: Add check for vc_origin address range in vgac=
on_scroll()
      CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline=
_data
      CVE-2025-38298: EDAC/skx_common: Fix general protection fault
      CVE-2025-38153: net: usb: aqc111: fix error handling of usbnet read c=
alls
      CVE-2025-38120: netfilter: nf_set_pipapo_avx2: fix initial map fill
      CVE-2025-38165: bpf, sockmap: Fix panic when calling skb_linearize
      CVE-2025-38146: net: openvswitch: Fix the dead loop of MPLS parse
      CVE-2025-38190: atm: Revert atm_account_tx() if copy_from_iter_full()=
 fails.
      CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_=
rcu().
      CVE-2025-38122: gve: add missing NULL check for gve_alloc_pending_pac=
ket() in TX DQO
      CVE-2025-38334: x86/sgx: Prevent attempts to reclaim poisoned pages
      CVE-2025-38285: bpf: Fix WARN() in get_bpf_raw_tp_regs
      CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks
      CVE-2025-38282: kernfs: Relax constraint in draining guard
      CVE-2025-38194: jffs2: check that raw node were preallocated before w=
riting summary
      CVE-2025-38319: drm/amd/pp: Fix potential NULL pointer dereference in=
 atomctrl_initialize_mc_reg_table
      CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway=
_restart
      CVE-2025-38115: net_sched: sch_sfq: fix a potential crash on gso_skb =
handling
      CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after c=
m_id destruction
      CVE-2025-38198: fbcon: Make sure modelist not set on unregistered con=
sole
      CVE-2025-38304: Bluetooth: Fix NULL pointer deference on eir_get_serv=
ice_data
      CVE-2025-38273: net: tipc: fix refcount warning in tipc_aead_encrypt
      CVE-2025-38161: RDMA/mlx5: Fix error flow upon firmware failure for R=
Q destruction
      CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in=
 few other places
      CVE-2025-38147: calipso: Don't call calipso functions for AF_INET sk.
      CVE-2025-38160: clk: bcm: rpi: Add NULL check in raspberrypi_clk_regi=
ster()
      CVE-2025-38305: ptp: remove ptp->n_vclocks check logic in ptp_vclock_=
in_use()
      CVE-2025-38218: f2fs: fix to do sanity check on sit_bitmap_size
      CVE-2025-38280: bpf: Avoid __bpf_prog_ret0_warn when jit fails
      CVE-2025-38219: f2fs: prevent kernel warning due to negative i_nlink =
from corrupted image
      CVE-2025-37958: mm/huge_memory: fix dereferencing invalid pmd migrati=
on entry
      CVE-2025-22119: wifi: cfg80211: init wiphy_work before allocating rfk=
ill fails
      CVE-2025-38126: net: stmmac: make sure that ptp_rate is not 0 before =
configuring timestamping
      CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU
      CVE-2025-38214: fbdev: Fix fb_set_var to prevent null-ptr-deref in fb=
_videomode_to_var
      CVE-2025-38312: fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hpe=
riod()
      CVE-2025-38100: x86/iopl: Cure TIF_IO_BITMAP inconsistencies
      CVE-2025-38131: coresight: prevent deactivate active config while ena=
bling the config
      CVE-2025-38135: serial: Fix potential null-ptr-deref in mlb_usio_prob=
e()
      CVE-2025-38202: bpf: Check rcu_read_lock_trace_held() in bpf_map_look=
up_percpu_elem()
      CVE-2025-38159: wifi: rtw88: fix the 'para' buffer size to avoid read=
ing out of bounds
      CVE-2024-57883: mm: hugetlb: independent PMD page table shared count
      CVE-2025-38166: bpf: fix ktls panic with sockmap
      CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send=
().
      CVE-2025-38226: media: vivid: Change the siize of the composing
      CVE-2025-38138: dmaengine: ti: Add NULL check in udma_probe()
      CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40=
e_clear_hw
      CVE-2025-38300: crypto: sun8i-ce-cipher - fix error handling in sun8i=
_ce_cipher_prepare()
      CVE-2025-38342: software node: Correct a OOB check in software_node_g=
et_reference_args()
      CVE-2025-38083: net_sched: prio: fix a race in prio_tune()
      CVE-2025-38107: net_sched: ets: fix a race in ets_qdisc_change()
      CVE-2025-38113: ACPI: CPPC: Fix NULL pointer dereference when nosmp i=
s used
      CVE-2025-38163: f2fs: fix to do sanity check on sbi->total_valid_bloc=
k_count
      CVE-2025-38173: crypto: marvell/cesa - Handle zero-length skcipher re=
quests
      CVE-2025-38142: hwmon: (asus-ec-sensors) check sensor index in read_s=
tring()
      CVE-2025-38229: media: cxusb: no longer judge rbuf when the write fai=
ls
      CVE-2025-38084: mm/hugetlb: unshare page tables during VMA split, not=
 before
      CVE-2025-38323: net: atm: add lec_mutex
      CVE-2025-38111: net/mdiobus: Fix potential out-of-bounds read/write a=
ccess
      CVE-2025-38275: phy: qcom-qmp-usb: Fix an NULL vs IS_ERR() bug
      CVE-2025-38151: RDMA/cma: Fix hang when cma_netevent_callback fails t=
o queue_work
      CVE-2025-38286: pinctrl: at91: Fix possible out-of-boundary access
      CVE-2024-41013: xfs: don't walk off the end of a directory data block
      CVE-2025-38085: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
      CVE-2025-38277: mtd: nand: ecc-mxic: Fix use of uninitialized variabl=
e ret
      CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmc=
i_ctx_unset_notify
      CVE-2025-38157: wifi: ath9k_htc: Abort software beacon handling if di=
sabled
      CVE-2025-38103: HID: usbhid: Eliminate recurrent out-of-bounds bug in=
 usbhid_parse()
      CVE-2025-38158: hisi_acc_vfio_pci: fix XQE dma address error
      CVE-2025-38197: platform/x86: dell_rbu: Fix list usage
      CVE-2025-38170: arm64/fpsimd: Discard stale CPU state when handling S=
ME traps
      CVE-2025-38326: aoe: clean device rq_list in aoedev_downdev()
      CVE-2025-38346: ftrace: Fix UAF when lookup kallsym after ftrace disa=
bled
      CVE-2025-38167: fs/ntfs3: handle hdr_first_de() return value
      CVE-2025-38108: net_sched: red: fix a race in __red_change()
      CVE-2025-38174: thunderbolt: Do not double dequeue a configuration re=
quest
      CVE-2025-38337: jbd2: fix data-race and null-ptr-deref in jbd2_journa=
l_dirty_metadata()
      CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c
      CVE-2025-38191: ksmbd: fix null pointer dereference in destroy_previo=
us_session
      CVE-2025-38145: soc: aspeed: Add NULL check in aspeed_lpc_enable_snoo=
p()
      CVE-2025-38293: wifi: ath11k: fix node corruption in ar->arvifs list
      CVE-2025-38088: powerpc/powernv/memtrace: Fix out of bounds issue in =
memtrace mmap
      CVE-2025-38136: usb: renesas_usbhs: Reorder clock handling and power =
management in probe
      CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling
      CVE-2025-38310: seg6: Fix validation of nexthop addresses
      CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/=
VT6330
      CVE-2025-38231: nfsd: Initialize ssc before laundromat_work to preven=
t NULL dereference
      CVE-2025-38143: backlight: pm8941: Add NULL check in wled_configure()
      CVE-2025-38181: calipso: Fix null-ptr-deref in calipso_req_{set,del}a=
ttr().
      CVE-2025-38090: drivers/rapidio/rio_cm.c: prevent possible heap overw=
rite
      CVE-2025-38112: net: Fix TOCTOU issue in sk_is_readable()
      CVE-2025-38184: tipc: fix null-ptr-deref when acquiring remote ip of =
ethernet bearer
      CVE-2025-38320: arm64/ptrace: Fix stack-out-of-bounds read in regs_ge=
t_kernel_stack_nth()
      CVE-2025-38313: bus: fsl-mc: fix double-free on mc_dev
      CVE-2025-38260: btrfs: handle csum tree error with rescue=3Dibadroots=
 correctly
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in a=
tm_dev_deregister().
      CVE-2025-38236: af_unix: Don't leave consecutive consumed OOB skbs.
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent c=
rashes
      CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()
      CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()
      CVE-2025-38257: s390/pkey: Prevent overflow in size calculation for m=
emdup_user()
      CVE-2025-38215: fbdev: Fix do_register_framebuffer to prevent null-pt=
r-deref in fb_videomode_to_var
      CVE-2025-38259: ASoC: codecs: wcd9335: Fix missing free of regulator =
supplies
      CVE-2025-38225: media: imx-jpeg: Cleanup after an allocation error
      CVE-2024-36913: Drivers: hv: vmbus: Leak pages if set_memory_encrypte=
d() fails
      CVE-2025-38262: tty: serial: uartlite: register uart driver in init
      CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_ge=
t_audioformat_uac3()
      CVE-2025-38239: scsi: megaraid_sas: Fix invalid node index
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
    added commits:
      CIP: Bump version suffix to -cip44 after merge from stable
      drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in
rzg2l_mipi_dsi_start_video()
      drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
      drm: renesas: Extend RZ/G2L supported KMS formats
      drm: renesas: rz-du: Drop bpp variable from struct rzg2l_du_format_in=
fo
      drm: renesas: rz-du: Support dmabuf import
      drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and RZG2=
L_MIPI_DSI
      drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
      drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
      arm64: dts: renesas: r9a09g047: Add ICU node
      irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
      irqchip/renesas-rzv2h: Add RZ/G3E support
      irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
      irqchip/renesas-rzv2h: Update TSSR_TIEN macro
      irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
      irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
      irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
      irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_typ=
e()
      irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
      dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E=
 SoC
      dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt Co=
ntroller
      arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
      arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
      clk: renesas: r9a09g057: Add clock and reset entries for GE3D
      clk: renesas: r9a09g057: Add entries for the DMACs
      clk: renesas: r9a09g047: Add clock and reset entries for GE3D
      clk: renesas: rzv2h: Refactor PLL configuration handling
      clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
      clk: renesas: r9a09g047: Add CANFD clocks and resets
      clk: renesas: r9a09g047: Add CRU0 clocks and resets
      clk: renesas: r9a09g047: Add ICU clock/reset
      arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
      arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on SDH=
I0
      arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
      arm64: dts: renesas: r9a09g057: Add support for enabling SDHI interna=
l regulator
      arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
      mmc: renesas_sdhi: Use of_get_available_child_by_name()
      mmc: renesas_sdhi: Add support for RZ/G3E SoC
      mmc: renesas_sdhi: use typedef for dma_filter_fn
      mmc: renesas_sdhi: use plain numbers for end_flags
      mmc: renesas_sdhi: add helper to access quirks
      mmc: renesas_sdhi: take DMA end interrupts into account
      mmc: renesas_sdhi: remove accessor function for internal_dmac
      mmc: renesas_sdhi: improve naming of DMA struct
      mmc: tmio: add callback for dma irq
      of: base: Add of_get_available_child_by_name()
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
      clk: renesas: r9a09g047: Add SDHI clocks/resets
      arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
      arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
      arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
      watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
      dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
      clk: renesas: r9a09g047: Add WDT clocks and resets
      watchdog: Add Watchdog Timer driver for RZ/V2H(P)
      dt-bindings: watchdog: renesas,wdt: Document RZ/V2H(P) SoC
      arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
      arm64: dts: renesas: r9a08g045: Add ADC node
      iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
      iio: adc: rzg2l_adc: Add suspend/resume support
      iio: adc: rzg2l_adc: Add support for channel 8
      iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
      iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
      iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_ra=
w()
      iio: adc: rzg2l_adc: Use read_poll_timeout()
      iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
      iio: adc: rzg2l_adc: Simplify the runtime PM code
      iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the ADC IP

Best regards,



