Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3EC71157
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 04:03:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.880.1750737792053664870
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 21:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=t260C/G6;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750737779;x=1751947379;bh=KXLsfQVctQR8sv2MIadiYOQx/PMhoNlNd5Skjvh
	Y1cI=;b=t260C/G60oZG+k1KBMmGPKWoAzItd2yEDNIJ0+wbNSZbf+IVLgHDNvIPlWofZVulhGb1q
	p5TbQbLtGnG1AgVnheE8FNhUTgmu6paWHkWh0x/7RVSTuQsP6fqGKyNZ6PiKVCJ7DOckGBIRz8yJS
	HdMdy45q8eKNuA6JN+E6hG5ijY/Xn75Vfx4FKFd4rBkK0TJDQqjtMqVVGqfb54d+aCBS9y3W4eRql
	aj+WFsuyoLWr1HFmiKs6Qs94hRJ4shktWoFGp6EQxF1oHhMM8w9rGrcUtx7KMoRqRkLA6nNDyc7p6
	JHDkveQgYm8fiuopy9NLFzd0LtNv8R2WIcMvVRxVvA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 55O42wZv4140596; Tue, 24 Jun 2025 13:02:58 +0900
X-Iguazu-Qid: 2rWh5b6vIIMisLDCZn
X-Iguazu-QSIG: v=2; s=0; t=1750737778; q=2rWh5b6vIIMisLDCZn; m=Ztgx+Vc5Xs+6rIPTv/vadfcVtZbOSzI9JgsOkVUwpCA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 55O42vW61416829
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:02:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHHrk2RhUVZupV5ylqkT0+VucdHBe2YAeXimE/gAhxGf5GWOck4Tp/U1IfuYQlm56jj8mDprw/FAZrI1n/lKxwFxM8ylzjHMRtuAT3ipKlDhMITk8XWy1/Rn4mZd3xthRs+C7l6u0QrAsH+sru5L5YTtWjP6syxOHtCJU0At/rmP0ti3kFRNUlsWpeEO49OEYkxZ1AE2D9Opg0Mov9P+JdzMN9abdU7q0FteNTWo++faNyXdoacGUAIdv5+iwWkcA0sGpWQGW1TungK+DNODZoJPj+om4dnuO52jY4gfJvV35hMeAqJ6Tuxi34px/itq8WTyl0JyjzQ2iW0dbhw5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HBZi2so+ypgpwNJtUC3oWSCGLRn2eYmP0l0SftqSIM=;
 b=YJ/PSsR5kJ7FAAceSPaX3JF7d1TLpJEPLpVRBQmisJb21SuS2AUfNo8hDQPSUdM3t+OOAguDRDj8uQXFAqHWOvbi7e18uVykMnBlOJls4mm6mePxDMVXQ5axh5BSBKjyRl+Kcrk5++NVt7Vsb+gzhjlLuCoYjhfTG3Bhe8796KqwvLusKfSfvIpkDNbdvKjXCxPe0evBGd6yqkscG4qE+4X62NJMwVrMh6d9rnGWjDU9EfaWQRP3CTxzQ0s+rFMuqmYN47ADPjhtK6z9Thbau89cHdz7obidJW2sZsqhA7FLNVCEpUN9roFg7glQv7fa27oPDkN0XV8M79TBtlAodA==
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
Thread-Index: AQHb5CmDWL3Y/2deeUqRRzouqdiAQrQRr+Hg
Date: Tue, 24 Jun 2025 04:02:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181D57390CA0AE449D1E589278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11912:EE_
x-ms-office365-filtering-correlation-id: dbd479f4-ba1b-4d81-eb40-08ddb2d3ff60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZTRjbmpaV296bk9adWdjaHpCM1VLZE1SUlRVaUJGYW5sUjFHblJob1BJ?=
 =?iso-2022-jp?B?dElxQVE0WFR1eEk5NXFmbktoWXpJT0FIN1BkeThraEEwVnZ3aWZKMGxy?=
 =?iso-2022-jp?B?cVFtWXRWWUU2Y3BmczlGSTV1RzByQXNacDFSUGU4dHYvcDJSamN1YTRn?=
 =?iso-2022-jp?B?TkwyOGdkNUZ1YmFuUE5RRndhM21BUVFWTHdsdFVUSyt5TG1VaThKd3BM?=
 =?iso-2022-jp?B?VEZCSmUzYzkzNDNLL2RxRlF3ZjhOaEN1dUl0NVFtRGVBM0V1K1EyMnFS?=
 =?iso-2022-jp?B?bWhzMkg2Vm1yQzdoMVJCMmVxbE51a2ZxeHYzUnhVKzdoL05wNDNzb2RX?=
 =?iso-2022-jp?B?bFRGUXJ3UHhGWjlhZk5ZNkZ1UHlXRUNWNDhSUllQYlBTSlZucnB0ZWYv?=
 =?iso-2022-jp?B?WGtiQWd6MnBXd21idU5tc0FqN0RaelB6OHdick51eU84RExraTAwUmts?=
 =?iso-2022-jp?B?VGw5K2xySDdFdm5ManBDRFgrZ0NqYmQvMkFHNVYvYUFGOFJMWDlocVg3?=
 =?iso-2022-jp?B?SUV3WXROdEtvYUlXdmJVRHNlcnBkWkh3R2F2UmNtSWx5ZFFCQVc0NXhv?=
 =?iso-2022-jp?B?VC9pTWNPa2sxdElQSC9kUnFHczdkR1Z3L3J1NWRib3ZsemczRVRKOGdC?=
 =?iso-2022-jp?B?VVRnQlJ5M3Qvc2IvNkhSNDNrRnF5cVFETXljaHdOUEk4QTM4RWpwWVlC?=
 =?iso-2022-jp?B?aGNNV0lTSGFQZDdmT2FWVFlmVlhFYzRyU1FGSXJvTE1BNXB3a0hFK29t?=
 =?iso-2022-jp?B?dUhTUkVQNFlmMkYrbTZ3VzJvY3pMb1JPbjY5MXdVOXh3a2RGNGI4VnJK?=
 =?iso-2022-jp?B?R0ZGQ0lLcWF4OFNZejBsOXphWVJWK05aY1hHUHpFR0ZXdWRWS1k3RmV0?=
 =?iso-2022-jp?B?TXZaeXVWd2RxMnJGdkxRWVp3WGE1cWNINjlRUzA3MmY3SU1iN1BZemNE?=
 =?iso-2022-jp?B?NHl5eklrM253eTdVajVacElpa3plUHJHTXliSnVaYmRMcU54WWh0VTI5?=
 =?iso-2022-jp?B?ME5jbXNiMTdMNnNyV3hQSjlhK0xhR2hvZkZ0RnpLcW5PTHhDbitFMEVP?=
 =?iso-2022-jp?B?VFlzUlZ1VGsxUlVSU1krcTd6UmtGNlpYMlBlbThIaWNSNjVocDZ5WmxJ?=
 =?iso-2022-jp?B?eS8xQkhsUktxcDNqVk5lcSsya1hpNWY1MnliRW9RV3hvYzA4MEhNV0c2?=
 =?iso-2022-jp?B?Wk1JNkRHWmMyRHY5U1VIUVdVeWZkUE5jamVBRzg1NTZsZmtBdmZ0TnpR?=
 =?iso-2022-jp?B?cXFlVnByVFNZYzNEWXhlck0wdi9ZK2kxS0g0RmYva3A5ZVdFODVVR2Q4?=
 =?iso-2022-jp?B?MUxiM0ZYWUdhRVdsYWNqdWhqZWFTMFlac0hGSUVYeTNHUkpYUmwxTUJx?=
 =?iso-2022-jp?B?bmVmNkFBVFl5VjVnbUdOMVJrMlBvZVBQOXBIenpGL3VEWVRxamVCYjhV?=
 =?iso-2022-jp?B?V3JCRkRJVERrcGNzK0RTWEVLTm9UUzI4TDBBS3J3K3h4U2xmeFoxRGNM?=
 =?iso-2022-jp?B?dGVMQ3IxMWdzR08rcGl0TmZqNExBNWk4S3hlelBLYUlRUUpFWVNpU1pB?=
 =?iso-2022-jp?B?b0hSMlJFd1ZWU25RL0RmNW8rRDNXY0E3bmpQSFF4U2pSZjEwSUZGZTFJ?=
 =?iso-2022-jp?B?MjZua1ZGMjRjNXpIbFNmRUZZYkVVYmNtVHZ0YzRrL3B3b0dJR3JaakhF?=
 =?iso-2022-jp?B?MFVZWUVjMFp3elVmbnBhcll1MzFEdE5teXVyR1h1QmZTdUk5czA5ZlZV?=
 =?iso-2022-jp?B?MXAwbVRvMzJ6eHNkYVlMR05FQWxtUmVNK2QxWVU1d01GS3ZnR09XeUJD?=
 =?iso-2022-jp?B?WTlhRDlwSjhmZWJnWkpJamljS3h2THZKdWVFN2lRYys4SW9kUkhQWWxG?=
 =?iso-2022-jp?B?SndOeWpER2ZBTWdOUzNSMXdPcmZqQy9WNDBDdFpkclVVYkdIQ0J0dmhU?=
 =?iso-2022-jp?B?VGovZ0c4T0NrNnBVeVZ3Y3lLcXRjdDlrbEU2T1ZTL2hUTlRFKzhRRERi?=
 =?iso-2022-jp?B?QSsvWkFTUzFRQzhXTEJPd3lWVTMyT1pQaUpiUExnb3RaTkx0ZnpPc244?=
 =?iso-2022-jp?B?ZVpLRUF5eDRyYjMrcWtwVGIvbUN4ZVN2a2thbml2NS8yODR6SVdDZDZH?=
 =?iso-2022-jp?B?VzBXMGFBcjl1cFVUQWV2UXFmU1VpQWJRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y1l5NGptM2hmQ2JOQXA1SHRIZHF4aVppZHJFa05kdUhMT0lpSG5nN1dl?=
 =?iso-2022-jp?B?NDFBKzk5d0ZTWHBRUGIraVVxaXFGMUF2R1JsWkI0MFVpWjloNC9UeEpy?=
 =?iso-2022-jp?B?QWlsNlFFTy9WTjNGNDVZeE1rQ0JTMms0RGZWcEJheitPU1gxeWR6d21a?=
 =?iso-2022-jp?B?N2pZdVRhZ0E2ekpvSGlIUk1EdTlrdmdTV2o0bTI4dVBESUZ1M1NxT042?=
 =?iso-2022-jp?B?VFU5dTduNytVZDZkM0xnM2YvT054bEtzQURLZWwzUkxpQnFDZHBySG53?=
 =?iso-2022-jp?B?akp4VGZXOXFoOGpNaGdubFNtaVowMnNQSXpicVM4SENGREROaUt4Z0NF?=
 =?iso-2022-jp?B?MDNadFh6bzA1L2JVNVhwZXdsZXh5UWRHamsvUTNXVEQwdU8xem1VbU5T?=
 =?iso-2022-jp?B?WW0yRjJWQlJ1RHBRRWdlRkI2bi8xNzlsVXRyMXlOVm5ZU3gyazdIZXlF?=
 =?iso-2022-jp?B?LzlqNTlGVENTejZKU1NmN0kraGptR3BTOWVVZzBpYXdwdmdpVGZ2aWpZ?=
 =?iso-2022-jp?B?STlyNXF2ZjZhUzVTNmRRd0tDRUxiWmh5ODlTSGhzallUUHdaM0JmaFdy?=
 =?iso-2022-jp?B?bEJBZmlPbGM4ci9ScUxwZEdrdTFQc3RCVHg3SGt0RHY5L1ZsdktwMDV0?=
 =?iso-2022-jp?B?em5IaDMyUEdzOHMrcHdaUG9Jay94TDVvYVdXMURKYUt6ZTFyVk5ZWENp?=
 =?iso-2022-jp?B?b05Xa0VrTVk5akdvRytRZVJId3BEc1doV3JSUzNSOE9ORElxbllsQ0xk?=
 =?iso-2022-jp?B?QXNNTERPeVRvSzZDYVVsOW04bklYREpOWC9mODBpaGlRZlM5VzcvVDJV?=
 =?iso-2022-jp?B?cWIxcW1LaUZCUzVvUHl4WFhyRnNSSWtCZGV0aW44VkZzZEk0dWN4N2Mw?=
 =?iso-2022-jp?B?SS9yaUR0Nk43L0pLNThtWHNXWGtXOEIvbjF0bHJkTndZNnN0Sm0rcGNn?=
 =?iso-2022-jp?B?bUEwT3B1SFNabWpVenVEV1I5bWN4OHNPN1J4NUxMV25VWkxaVGRPU3Fp?=
 =?iso-2022-jp?B?VUlPM2FSL2xkOThVVzA2SUJwZlFoYkhDVGpQQ0xZUG5sYTRCYTBtZDFP?=
 =?iso-2022-jp?B?WTJNc0t6bHo0N1ZPd2ttZ3JWQmwzZSs1M3pFTmpZTXZxNmhIdGQ1eUtB?=
 =?iso-2022-jp?B?LzBOT0NtMitDMTRhYUhrcGFaYStBNFpqRUZWZmhFelpzb2huNXlKdVg0?=
 =?iso-2022-jp?B?ODdUWUZ1d2tvOHcreG5Md0RBVkh0bG1IdlRlODM1M3EwWFJvS3MrUmd2?=
 =?iso-2022-jp?B?YmJHYnhSMm9Yc2Q1dVhGZGRxWVVIcGZjVHF4TXZGWmRmTUQvaS9uMnZx?=
 =?iso-2022-jp?B?bDIzbFVYWlphRXk4eHhZZ2trdjIwMDBiQkM5ZURTYnBxN0MrSzNlY1FX?=
 =?iso-2022-jp?B?VUlhYUpwTUllMDhzYWNiR2E1ZzQwdjczNWU0NFB3QnJSTDB4YSsyVlFs?=
 =?iso-2022-jp?B?aUZ1ZUJWdldyYWErRWtUQ2daa2V0NnV4ZUZtRG14cGpNU1NkY2NaRHVL?=
 =?iso-2022-jp?B?Kzl6U0NEeEJ4SDNhWDFiRjZQb0x1dnViS3dkNEErUFUyOTFNQ2Mwcktl?=
 =?iso-2022-jp?B?TVo5dTlyejdQcWFnMG1TTWJTbmdENXpOZWNLYlg5Qk5KMFRuS3pjbW16?=
 =?iso-2022-jp?B?enQvNHRpRFMvN0hRaGwxN1BMZGd2WXlycEJWRy9vajg1RWZreHpLYncx?=
 =?iso-2022-jp?B?bEhuOUhidFBucjloV2V0YXllTTRtRjBlYURKcEI4TjFWdFU5SGxreUR5?=
 =?iso-2022-jp?B?TDVTbE1TWUhPSzZYU1FiZHljR0tPM0EyTGhSRzFEdTF4ZXpJdmRSQ01L?=
 =?iso-2022-jp?B?OUVDTkFSK2VyQkdMNGFqd0JIU0VsbUhEZWtHYVJCT2kyS0pCbjZCTkRI?=
 =?iso-2022-jp?B?SE9iUy92djc2bjh0YXlZMEh6SDF4aWNVajhxNk5xQmdoem54ZG5wVGFz?=
 =?iso-2022-jp?B?cjM3amNxN2s0bytaekFKRVhlMEV2VCtqSkk5bUtXVDlWdTU4Q1hSejBU?=
 =?iso-2022-jp?B?MjJQWlRONCtiTGsvNUk3M1BuQTh1eUpva1BEQ0pSWkxkWjVLT2RhdWtZ?=
 =?iso-2022-jp?B?Q3V4M1NpeTBTUG9ETFRvVUtjRUczaTlPMXB5MExOdlRxeGNvMUxiS2Zy?=
 =?iso-2022-jp?B?bm9LZE53WmpSQWFQSS9DTml2OFQ1ekg2Y2FabFN6NmVuclFxbzVqUGlw?=
 =?iso-2022-jp?B?Q05QSU1NUmdvTmt6WTRNdE8vOWJxVWsvc0N4V05uVWwyanZDa3ZKWWEz?=
 =?iso-2022-jp?B?RHAvbm5vVm01a3AvTVRkeWltbVh3c0l6T1V2RGlGWGZvdlZnRzBaQlZx?=
 =?iso-2022-jp?B?WUY2dHhqSFd6QW1mcVozOWlaeGVzaVBQeWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd479f4-ba1b-4d81-eb40-08ddb2d3ff60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 04:02:54.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYmf3oL3hcj5Py50i7tqemmPDrcS5OQRDjiNqmsyCY7CJdMl/pUOtuHAGjGqixcRnOl+SJv+3RbJigykCuObhLN3fbX9zjwpzZA4QWLHvl0e76XcWNxqGQgEF6nCcfzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 04:03:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19219

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, June 23, 2025 7:27 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
>=20
> Hi All,
>=20
> This patch series aims to add Watchdog Timer (WDT) support for the Renesa=
s
> RZ/G3E SoCs.
>=20
> The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33
> cold reset, system reset and asserting WDTUDFCM pin where as WDT1 can be
> used for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other =
2
> watchdogs can be used for system reset. So define WDT{1..3} in SoC dtsi.
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (5):
>   clk: renesas: r9a09g047: Add WDT clocks and resets
>   dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
>   watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
>   arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
>   arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
>=20
> Lad Prabhakar (3):
>   dt-bindings: watchdog: renesas,wdt: Document RZ/V2H(P) SoC
>   watchdog: Add Watchdog Timer driver for RZ/V2H(P)
>   arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
>=20
>  .../bindings/watchdog/renesas,wdt.yaml        |  21 +-
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |   4 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a09g047-cpg.c           |  15 +
>  drivers/watchdog/Kconfig                      |  10 +
>  drivers/watchdog/Makefile                     |   1 +
>  drivers/watchdog/rzv2h_wdt.c                  | 273
> ++++++++++++++++++
>  8 files changed, 354 insertions(+), 1 deletion(-)  create mode 100644
> drivers/watchdog/rzv2h_wdt.c

I reviewed this series, looks good to me.
I can apply, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>


Best regards,
  Nobuhiro


