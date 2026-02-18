Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399CE9A03B
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 05:07:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5889.1771391236515296398
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Feb 2026 21:07:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=rEEDPDMB;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1771391231;x=1772600831;bh=k+Msg/EKCXB9IGYARjcONWTaS9IYIQsmMkJMH
	+ChKy8=;b=rEEDPDMBEe0wrD8nBBk98oRXhG/lPm70HIWZ3zMHVHUYAY6TRK5Saw0fUx3NVWNigFl
	rV6K33tuuDYxeqRVgb1fdkz3BAH9hjABMGuGM6tLyyGvps0O6DhlPFOFLvyHpQvfI0aKEHedDu22n
	7FEhMXSyuSGRRzuNBTsnYf7eDJpNQkJqCFsZThyF/IVLBnODlszTjgMMT/fswu6Y+Jb6SblyGGRJM
	2Pk9VterkA9e+y9vpX0K6zNlE+SD4EKUUGe8rRiyAU8juIhHDb5cZUykMfCVn6EN6Tw627FWyvC32
	XqoFQpKNx/DsmnwQknTm6t4khfUWP5n9OPpHoMoHy+4A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 61I57AcJ2537647; Wed, 18 Feb 2026 14:07:11 +0900
X-Iguazu-Qid: 2rWh7Ml5jQXE4WsjlV
X-Iguazu-QSIG: v=2; s=0; t=1771391230; q=2rWh7Ml5jQXE4WsjlV; m=vIB6eb9HjGZ8tkfNthcVwTKJ53lJdX+CCuIK6rvPNxs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fG4Hx6fBHz4vys; Wed, 18 Feb 2026 14:07:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP92WnxSpTWM65AIX7HwLIEt4ZiWgkZ/Enaw/qYrUq9jiXebSzw/EKgdVspski0pVfKTjVwfkldFnwOzptoPQFqBKCMLC9gxAV5OjlJNHxxsIPbqFy5oq1Ni3ZoOngH4+jobD8wcQwBuHT/w31ditQ/PXL1Hfltt14XfIDre77UGYE/NEAUO2XaWoeoaZ3ulbCWVz4kasKE/2Y1luS2bkLBzNkP5ebr71i8qrYl1kdxFTZC0a8Ih580a0VWuTF++M25rdsWMzBL9yBkyY+JQnhZIARezbNLLG1VzQ2WAH7yXw3w8o+BG2AMauxbAsM9vpb3GS1CKFleV5yRGQA3k3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM+MYAYOdeU0JRYSFwKlO47blZwi7PAEha0dV8CzLGM=;
 b=ehTSYq+Bv9qxj1/dN0/eQUkbzl1RJMopOHIGj67zw5Tk+CsY2SzzL79nn3lctr3ujbm/DO/VjaYMyvE0CNXDEwT3LwNEPeFRSuoGIs7/DMC3dUtkObfwBdHKQKdICRN5q4WmxtCU+TT66DfpHd5jJml4xFsidZU9WDxcsXkylAGatD7wP4rej/XQYpkbv1E27hKCqXdm+whQCC1SsjFCHhfPuCYTppx4kS5JRRunPqYVP1GUNef+hCMEPO/VNKMowhyKKAJ7Z6nBzN2ImC1tFECsGpWbIebKcm6YgUs0+7Io7AGgjsOQZlqiM/InihmiNc8WsTiUF+EU+4VcTKPOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] i2c: riic: Move suspend handling to
 NOIRQ phase
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] i2c: riic: Move suspend handling to
 NOIRQ phase
Thread-Index: AQHcmnfV7K8Nr6mEx0KXVdI1Kpt2ybWFQVsAgAAArYCAArCxYA==
Date: Wed, 18 Feb 2026 05:07:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182A865E74A858EC2BC9DBCD6AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260210102637.484003-1-tommaso.merciai.xr@bp.renesas.com>
 <aZMFskqvbJa24JYR@duo.ucw.cz> <aZMGQ31JBsck9820@duo.ucw.cz>
In-Reply-To: <aZMGQ31JBsck9820@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10638:EE_
x-ms-office365-filtering-correlation-id: 6ec963e8-3c42-4bb6-97f2-08de6eab9042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZGR0N3RMekdhUGxoM1pIRnZURERxd3lDVzJ2dURoeUdCZjVaeFM5Z3Vh?=
 =?iso-2022-jp?B?Uk9ndThOTGltaWtlWUlQcXBZamdsVE41dDREMmpjTUlqTXFXNUhLdjJx?=
 =?iso-2022-jp?B?ZUMxOS9wanhKMWZjTGxXYXF2Y2szaUdlNG1BVUZPWHBPQUh3QVNTblJN?=
 =?iso-2022-jp?B?ck9hS2FOYzdWNGpPL2s2a2ovLzQxYTJpZnZmNk9MUTkxMTZCRkZEczJX?=
 =?iso-2022-jp?B?NW5UM2IzNWRJWDlDV3pZSmZyZm1MajdSWEhrWmZ6d0xZK3ZOcEltVzAx?=
 =?iso-2022-jp?B?ZHlQOGo3WGFrRkhrUU93a012NTdoa05VS1JSdUVwMjJ0cTlpeVkxeklw?=
 =?iso-2022-jp?B?NHBjWGIzcFNBWmNMUWZWcjBwTTEwclNMTTE2TXR2Tnd1OCtoOTJqTk9C?=
 =?iso-2022-jp?B?SXdxaVl0NzV4TnhoeDdmUlQzQWd4M0VNTkpFd1NXS0ZXeEU4K0gyd0pq?=
 =?iso-2022-jp?B?N1hNSXhucHZMeDZuTjBGM0Zpb0ZNUmZEMlZLbkV6R0c0L1JoTVcrdWFE?=
 =?iso-2022-jp?B?aWpQMFlReVBNTXM0UU9KakJaZlIvaDl6eE5kSnFmUEZsY2lQUTZWWjZ4?=
 =?iso-2022-jp?B?MENMVjlFNkdWZ0tudVhzNFhBZ0lPcHE1MnhDUnNlcDRTTkhXRHRaZklW?=
 =?iso-2022-jp?B?R3dLSHE4MTR0TVhaellxZCtCNmM5NlNtVkdxcmtYc0NUU2dzTWtKUUgz?=
 =?iso-2022-jp?B?WEpEU1F0OG9kQlJaQU9sa3Y5RXJWVzVmT3BNZ3FKeDBJREt3SmFoa1E1?=
 =?iso-2022-jp?B?SmNpSitpL3hjbGF2QmFGSnJEcTFtazgwNmtxKzVDZnJwVnB4MmtJWk15?=
 =?iso-2022-jp?B?bTExU045dU5TT0JZZmI5Q1d4d3ZHSTBnb3dla2pPNitqenptR2tDMFVo?=
 =?iso-2022-jp?B?N2FhWkovRy9xSUdLajIxandORExlODA1M2s2em5LUjBtMXpvclgyNHJZ?=
 =?iso-2022-jp?B?OXVybDNCMFp4SkduYjdCL3FaKzJ3S2JScS9aWmdxelpSWjg2akgvZjJo?=
 =?iso-2022-jp?B?TFYvRlltM1hVKzRiaFJuY29sSGJPNkIxcXNYcFdDVkJCNWM1MHhGb1h5?=
 =?iso-2022-jp?B?UUhTRXVIM2VzbkVyak8zOWRLdTBWQlUya3pKSGl2dkNyV0hnQlNzemZz?=
 =?iso-2022-jp?B?VDVjbFhMZUFWT1RpcEt4TG5xV0FCN0YyK1lsQzV3VDVZQ0ZWNUM2QzV5?=
 =?iso-2022-jp?B?NHVTNXc0SEozRkNFcGVIZ1VYVGpjM1J4Wm9aL1BqS0FhbnYxWG83SzFT?=
 =?iso-2022-jp?B?VUpLOHpQTlo1T1F2QjRKL0pSa2VpQnBtSFQ4Ukw1UXUydmZiTytoWjdE?=
 =?iso-2022-jp?B?a1BPR3RxN3hHTWZndmVER3NDS29iSG9lZzVZL2lSWUxyR2xOT2M0Ti8x?=
 =?iso-2022-jp?B?WHZudUorY2JQVGlyQmQwTGUydUJ6bUliUjAzOTBXM0w5T1pja0FmR0dp?=
 =?iso-2022-jp?B?S2pEZFNodVhrVFh6K1I4VHVVQjFDZkFneXdsYjdlTHh1cXNlU0o1cEgr?=
 =?iso-2022-jp?B?R3hlVmIxWTd2ampyQ0xCRmNvaWROdkZub21Ta0JPb0ZNSEVJeVpqOWpG?=
 =?iso-2022-jp?B?U1ljam1sbmY3a2JtNXFLMEZzTGJWT01zK3JqWFg2ZThVTllqaHY3ZmRE?=
 =?iso-2022-jp?B?bHAzZW9yRnpvZy9nL1BrTHdFSDBtMlV5cUM1NXE5UkdNNVNCLyswTTJ5?=
 =?iso-2022-jp?B?VkZFZkdraEloY3RDMW1DVkhKbnJSS1kweWlNMFJ0ZERET0h2SmtZdFNy?=
 =?iso-2022-jp?B?NVZnV1hYLy8xMUk5ZVVZbFcvN0YxeG1TYzVNT2xhUE52dEZBVEFiZzIv?=
 =?iso-2022-jp?B?dXI3TktXR2E1NXN1OEFTTkJ5TitYTDc5ckJ5SVdFL25CSlVOZmhaTndL?=
 =?iso-2022-jp?B?clJyaHhDbG1GU1NmZHhnWDk5aW8ySHpEZmNFb3VQZTlpUzRSVkZMQ3NS?=
 =?iso-2022-jp?B?bXZVTkw1VzlHWkxzdldMZTZoTzAySzBvMlRYSGZ1ay8wUWlYbzI2MmtB?=
 =?iso-2022-jp?B?Ylp3UEVaWWNsQmEyaUdEbE9ETGpYdUthZHZ6SFlITisvTTltcnNIYlFX?=
 =?iso-2022-jp?B?SjFOVGtRQmJmVDhIS1hBckFoRmNPRDJtNVVoK056NXdvcUtsaTU2Q0VM?=
 =?iso-2022-jp?B?VkNrVVdURlJtbkRWRUdxdFlCb200UnRGQXNhLzF2MFZ3czV1K1E1VEow?=
 =?iso-2022-jp?B?TnFHVW1PNzdmVnMrMFpEdzNGUVhiT1R6dWw3MG52WTJmN09ZdVB4VlR0?=
 =?iso-2022-jp?B?MGpMaEJJSmVERTh4bWxJekR6TXRTTDc5d1lYV2ZkcWJlRlF3YjNXK0Ju?=
 =?iso-2022-jp?B?VVIyaGR6dzQ3SENHV2JnOUdWc3MzWGlwSi9NYnpDNjlWbVRHQjRYQUVx?=
 =?iso-2022-jp?B?TVY4YU09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SEUwK2ZkalAzNkNxZ2tpaXdvQ0IvOElLTGpOYWNpV3RRT2diVW5kUWhm?=
 =?iso-2022-jp?B?SGF3bUxBNnBmTEpudHc0RitLR2srRGF2RmNuZWJES0Fnd1RNQW5EQVpT?=
 =?iso-2022-jp?B?RU5GYURtRDl4NmE2OUxGalR0VndwbGZNeUhMK1o5Y1FKclVoV2lIYUFF?=
 =?iso-2022-jp?B?WG5DUVZINjdyQ1lCTk5hVW96ME81ck5UT0crci9VVWVVS29sRXJLTFUr?=
 =?iso-2022-jp?B?UGU0UmVSM0F1Mzk2d29OR24rZENqU0FRQVYxQnIvUkJZblJNbkY5ZjVE?=
 =?iso-2022-jp?B?ZDVGQVFQR0pKVFlielQ0Nk5OZmdVUkVHU3VVZW42OXFMRlN5eDdFSkpo?=
 =?iso-2022-jp?B?dVdPUTFIRUV2YlZmV0d5czk3YVhHUUtWQTIvaFphS1RLWVlOVEtUTjRj?=
 =?iso-2022-jp?B?YlZtUThlUDI2MnF5aHlRci9EVWc1bG1qRytpLy9wNnJLaVkwNHU2RkJj?=
 =?iso-2022-jp?B?WDNpb2dLSWJNMVEvbzBRTk1DYms2ZnYrVTVpREl4MzE3ekNLa3o1c3Zx?=
 =?iso-2022-jp?B?R1g2S0hBWjQ4d056d25RYkhGTGVPQmxkWWZmOE9jWEU4a08rWnQwTFNV?=
 =?iso-2022-jp?B?QjFIOUVHSUM2UWoxMkNBMWV1ZUpJMktLWkdENWpvTkllSHNZc1VjMWZq?=
 =?iso-2022-jp?B?cm5LMG1PMHpDZ1M5bEF5ZzlmWm16QjROL3NSVXJuRVgzUHIwMHF4TGc5?=
 =?iso-2022-jp?B?L2NzOXlmZVRreTUzUWYyQ2xIeGNuMm82TlpWNjdXZEN0SHZUY2F3M0RC?=
 =?iso-2022-jp?B?cnE1dWNqN1g4RzhLWXJuL1BDVHIydjBWUWlFeGhkQytTdDlWQ0NKaWRk?=
 =?iso-2022-jp?B?ZFhyNGxQczBjOUprQW5KQW9nZHJobWVnZUNoRGlZaVJGK1VBUjdEK0wx?=
 =?iso-2022-jp?B?bWtVajN2VHJKRHZUcHdqR3NwaGh3eWgyL1lMNC9LUlVQeDlmaXQyUXdp?=
 =?iso-2022-jp?B?YXFEK0xlTC9qWDh6L1VNVlo0R3EzUE9sS1VvMFlscXNTc3FraGZDYjUv?=
 =?iso-2022-jp?B?OTNwamNCbE9MVVJvNjVxNmJCZ2xtaEU3aWwxU0NnQis3bExQd3FEL1hn?=
 =?iso-2022-jp?B?MnNySWl5K3NrOGh0MkhGdEhrekE1U1l3NVUrVTlrZGFPVGFTZDZXdGp6?=
 =?iso-2022-jp?B?c3gzWnJSMndSQnIwejgxME9WNnBrOWJIT3dCeHhTWXl3VEpYSWhTZmY2?=
 =?iso-2022-jp?B?OE9UbDFKNkV1NTVSR3RsK1hobzhYRzk2elIrNEZmUkMzcmUxWWc2czh5?=
 =?iso-2022-jp?B?RFdORmMzNFBXVjNmbmRKV05DNjI5YUxJamhHUmhka0QwRHpUZUJmY1U5?=
 =?iso-2022-jp?B?cWlVRlU0VDhKM1VyS3pwVXZIQ2g2Wmw2UXRFbFRQdUZPQU5nTW01S3Ba?=
 =?iso-2022-jp?B?cU1HV2s4SGZBK0M0NFdYVDB4bytUbXB1Zk05RWw3aXJlSHVsQnBVamlk?=
 =?iso-2022-jp?B?TkdNWVRDZzZGTTNRRW1hdkt3NTZTNUlBMnZLVTFOVlZEN2o2TnBjZXdM?=
 =?iso-2022-jp?B?d0x3UkxSUG9pSjZKY3phSVFSWDNQVWtZY09VSEt0UlJjVXpCNVhnc0hx?=
 =?iso-2022-jp?B?dHg5ZWVxdWlONWJoWFJzdTV3U1JURTVRQXlsRTRmSGVETEZ5TnNpN1F3?=
 =?iso-2022-jp?B?R3dBSFg1dUttYmhMcWxxMS9SK0p6ZXdBbnRQbW5QNE9uclpld2lkRVMv?=
 =?iso-2022-jp?B?OEh1Zi9GMzl3cWNPdHVGSlNaTkpmZXYwOHdUZ1pONE1JVEl0aEZ5QVRS?=
 =?iso-2022-jp?B?ek9NZ1YxODhTYXhIQTN4bllHZVJnOU5CajBQeFVDQlZRa0xoSW1veDNs?=
 =?iso-2022-jp?B?aDVYMmhoeFhWcVJNbzdWUUFtRTJCemVGTkdpNjQya3lWcGxQdFRpZGlK?=
 =?iso-2022-jp?B?Vm1OWnRYT3BZT0Q1a2JpVGswRTZqN0QveGsxY1hvOTNUcTZJSml1VFVH?=
 =?iso-2022-jp?B?SzJxVUg3dGh6NEhlV3ZYV1lGbFdnd3NhYlluWjdpTSsvZHFuMERMVU80?=
 =?iso-2022-jp?B?eWY4UzZEU1ZTa2FZZEJsQXZ5Qld4VUVBN3pMMHl4QVdTREs0eUdwb1B1?=
 =?iso-2022-jp?B?bzlCNjFma1ppV0E4aDR3RGlKRUhQYnNQZFREZFpyM0llZ0htQ0JBemxx?=
 =?iso-2022-jp?B?eTY3bW41Ry9FUzZ4YjJGNVgzNFo5SVlzQVpxNmF5bXZJbVpsYVF2MkRn?=
 =?iso-2022-jp?B?dS9mWnpJbWxmbVlEQUhUbnFmVUxoTXhDS0w4Q2lWd1hsTWxhSHd6VHZQ?=
 =?iso-2022-jp?B?WVh5Vk11QStjM2Rka1FIRjZ4S2NQYzBVMlIwekF3MmJMd0dLeHltRjNL?=
 =?iso-2022-jp?B?VzI0bmo4Q2Z1Vm05bFA2a0FqbE5IbVFQbW8vWjg2MzdqMGQwUE5uTjc0?=
 =?iso-2022-jp?B?TS8yeENRWm9HbWJrV25lTGpPQjVTSC9kRk5zZFdhelNYS0VJUTIyeWhS?=
 =?iso-2022-jp?B?KzIxdkpBL0pNZm1TVDhSaHppMHgycG0xVTN4cXo2WHVMTkE0VHAxSlJ1?=
 =?iso-2022-jp?B?bWhsT2RnNExjWTFhV2l2MFZycFRJSFMzNkJ6bVNjemtidHBUNFlueFgv?=
 =?iso-2022-jp?B?aXkyZXFSbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec963e8-3c42-4bb6-97f2-08de6eab9042
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 05:07:07.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyZrkZc5JCMmM23ItKsn5ysNdFXHDfgzA2GTT67nlGK93LkTPEtWMXG3V+p2cDWJ7wcenUiiU651nfmryAlo9AWJCUvCy8Y9Bk21pKa+dIHTLXRwlKzi7xsSodjsUuvf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10638
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Feb 2026 05:07:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21893

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, February 16, 2026 8:58 PM
> To: Pavel Machek <pavel@nabladev.com>
> Cc: tommaso.merciai.xr@bp.renesas.com; cip-dev@lists.cip-project.org; iwa=
matsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das <biju.das.=
jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip] i2c: riic: Move suspend handlin=
g to NOIRQ phase
>=20
> On Mon 2026-02-16 12:55:30, Pavel Machek wrote:
> > Hi!
> >
> > > Wake up the controller in the suspend() callback while runtime PM is
> > > still enabled. The I2C controller will remain available until the
> > > suspend_noirq() callback (pm_runtime_force_suspend()) is called.
> > > During resume, the I2C controller can be restored by the
> > > resume_noirq() callback (pm_runtime_force_resume()). Finally, the
> > > resume() callback re-enables autosuspend. As a result, the I2C
> > > controller can remain available until the system enters suspend_noirq=
() and from resume_noirq().
> >
> > > +++ b/drivers/i2c/busses/i2c-riic.c
> > > @@ -606,6 +634,10 @@ static int riic_i2c_resume(struct device *dev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	ret =3D pm_runtime_force_resume(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	ret =3D riic_init_hw(riic);
> > >  	if (ret) {
> > >  		/*
> >
> > Similar to the next error return, this likely should do
> > "reset_control_assert(riic->rstc);" before returning. I guess fixed
> > patch would be best here.
>=20
> Hmm, maybe that's not the best way forward.
>=20
> It appears that same problem exists in mainline, too? So probably we shou=
ld merge this and let you fix it in the mainline.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can this if it passes testing and there are no other comments.
>=20

I reviewed this and for other kernels , looks good to me too.
I will apply and push with Pavel's Reviewed-by tag.

> Best regards,
>                                                                 Pavel


Best regards,
  Nobuhiro


