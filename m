Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2977D2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:01:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.222.1768885282514767973
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 21:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=btG7rnNd;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768885279;x=1770094879;bh=MyIZN1PhNGrEXIutDDvpVkx++zRFra0nE7Zlv
	jAU8eY=;b=btG7rnNdyP+120u0BNspswlZfhDYlaHnTAzih3bbgKuN6wvtxtVjV/K/Ybx2LUB/Ijr
	mqlIc+s3Xj883rwfubjHkJGSv3LF2Jjvs8/RKzwbvlUCRE5ypJsOj75OFmFxmrwO2mqxDjSRqq6Ol
	NqxRPDOhvWN51Mdsz4z6KgcjYpdIKRZ/PD2SeL2p4DdO90zPt2wa0mQS70uWs3/iK4xlnpqk/dc4X
	kGIaFR96cfCRlgIVS9gzc7DE8Mt0VugHYsKoORQlKUZkhSAz4rfD2RCHFeXvzvTIkrYpC19ZC+iQm
	wnV+5vtoqECVk8UP0CY8XxDAtFzm0MU7LoADJNO6LnGw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 60K51IVu2682344; Tue, 20 Jan 2026 14:01:19 +0900
X-Iguazu-Qid: 2yAbqIk2wyJbiMZmma
X-Iguazu-QSIG: v=2; s=0; t=1768885278; q=2yAbqIk2wyJbiMZmma; m=mMMXiQrEjy03pf2ddG7qmoGudO5w/ge+gDTdo6oO+I4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dwFXZ3F1nzyPZ; Tue, 20 Jan 2026 14:01:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfdy4pBRtHNDPsV32XzCvHjM0Oay3fRBunC3eoaxmybtlRgewebqiYAiTnhk6f9P1ITE7/TH47MwHAWkI/aduVhNMQP3wjwZ6QuTejdsn7bM81M3w42xjdLfaLCINkstdWW/IHX/PqLrTF8Eh5BjTtXn6oeSuD6JY6O8/BioKIGKk6OEM9gVgsIMzkyfybo2wdDjr2za5JwUGJxOdFdI5htDq6ySZeLITX5yMwX22gSk54BvkC0rpUu2/ZvMSRGV+VYhpMyAjDUEsAzen70Y3CU4gq8fIskmBW3H5MZ+ZV41gjgMcmYQ/G1CVAzKV1+riBRY6Sv6JPA0VsC3c/l4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+F0pK8y7XM3t5P6GuIH6TN6LIuFE3RA4mGBmKB15/U=;
 b=SebwcfaCOm+8zwzIevR9PQNQxePm5/iG8WWx8fFWgPR0+EK/o7MM+htlNVRmZVlxUUDEjpA0/wDVcB+6j3R1+xpbcHtdtE2vY5UGNDdwJP+7nUQI1iiJ1OtoivFp5sk5kdyyiI9C5x0zftUBVhUceafItJzemzC3w0gYz21oLeGafGJb+jGibkr35d656PR6Q1Kfa4eJVfinzX26viYHa2acEGjnABnt4mAZJPt3BO/21ptaj/1GjBZpuppBckwemk7BYZbm6Gs3DVZOjagyfDepa6chW6M6Vd9YrwaERVlBRBC0jqQmJF8KEU9x0sV5TCz5KgV90/XbZAY/VB/dpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2N USB2.0 support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2N USB2.0 support
Thread-Index: AQHciUJMYdIWCyOX8Ei7yRD2NBDBVLVZpS+AgADXxaA=
Date: Tue, 20 Jan 2026 05:01:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481819D7E4F75DCA3A312D43CD89A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
 <aW5To/fZ3bbZAVPo@duo.ucw.cz>
In-Reply-To: <aW5To/fZ3bbZAVPo@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12742:EE_
x-ms-office365-filtering-correlation-id: d2eaf7ae-02ad-480f-1780-08de57e0ee97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WVBaL1ZpajQyV2wxWFM0eU9hdm9USDRtelJZT2lIWGI1LzhCSFdjT1gx?=
 =?iso-2022-jp?B?YjM5UVZpeDYwNm0zQ3gxa0pmZ1NYbENnTUs0SFRPdzB2c0dVRFFuczBT?=
 =?iso-2022-jp?B?SmdmNkxaRlRKWTdqVzVkOXdSLzVzRXpFRXFXRHBaalZsOTcrTnJIaEky?=
 =?iso-2022-jp?B?WEhrRzJlQWRKZlNLSFFuQXVNVmFDM3RwN1FpUUFpeEhYNy80bWgxdWUr?=
 =?iso-2022-jp?B?dTNZR1dwSXhXa1h2QW1oMXhGSXpYSW8zdHR3NVBKMlNNeUFJYzFCeXRj?=
 =?iso-2022-jp?B?azFFMGtqY2gzb3Y5enVMS3hxa1h4K1E4WHRhdTNwZGY2YU0xK1hvOGc2?=
 =?iso-2022-jp?B?U1dWeGZqTnlLSnRRbTZSdThrSG5HVFdwOUpFVVo0bWRDc3lFTkNuZm1S?=
 =?iso-2022-jp?B?R0xrSkFpVldjUEptdU0xQWU4RmtwK1o2ZjFGeGJRMEVlQW1zR1pheEdN?=
 =?iso-2022-jp?B?N0R2NXB5Z2dpVytScDJzUUhaVktkcGFtQVZSS2NNaitLenpjUUFCTk5n?=
 =?iso-2022-jp?B?OE5VdkxZc1lWK0xsNXBhRTdhaFhBV2FxMnlIc0hSbkZWY2xmamdSbUwy?=
 =?iso-2022-jp?B?V2NUKzBEeEtkSFMvTVJ4Q1pyb1cyaEpPYWtFL2dQckZmT1V6V1hZRkdY?=
 =?iso-2022-jp?B?K0Nrem5oQXdNcDRpWjY4QWc0QWdVZjBmcGtqWitWTUROM1E3RkhyNW5v?=
 =?iso-2022-jp?B?TXZVaWxzTTYzVWpjQUNDNWcvOVYyV0kvdjQ2WVlaaHllTnkrVzJhb1pj?=
 =?iso-2022-jp?B?eEJWQzJHamloOGc0dlhKTDRQRWYzZUNpWXlLMmtBLzBIMmw4dExWUytv?=
 =?iso-2022-jp?B?QXlPdWV3SlRHSmNjdk8rL05JZWVDOXBzdk9DNjhESnUrQjIxOUllMW1T?=
 =?iso-2022-jp?B?WGZ3aVlXRHYxSWNvK0ZuYkJRYTgwb21zeXpxV1pqWVVEVGpud256dEVw?=
 =?iso-2022-jp?B?bGFTWTNiRnVZUURZcGtqVGRMMTJ4bFYxS1ZqdXMyaVZ3cFVoQWZmNU1u?=
 =?iso-2022-jp?B?eXFXOE1YLzRWS3VoQUVZK3htV0NCWkJuU29jNW81VzAvVTJtN0R4N1Qy?=
 =?iso-2022-jp?B?RTZaRFhVQW1PUExDV3hzNGorUXRRUTIyVUdmem44SU9IMTExM2xEVy9X?=
 =?iso-2022-jp?B?ZkdaRlhFNHpjdHdQYzFxQ2hqbWZsa3RPdUZmOVNQRUM0V3hJYjZrZk1p?=
 =?iso-2022-jp?B?RVBOclZuVlFRelVvRkpweW4wTFpCQWdJb0FOYmxWR2UwR1VjV0lZOFgy?=
 =?iso-2022-jp?B?TkFhbmZqUEF1eng4Ymdwb0cwa29rUEw1eUJjRE5XUkltbys3OGJyK1Rl?=
 =?iso-2022-jp?B?aUU5cGgweEVWVDlCNXlsYU5zVjQ2NUwza2xOZ1NVOURiMXdyNEVDR2Jl?=
 =?iso-2022-jp?B?ZWFsVFdrS1B1Zzk5VG1PRXpjU0hDRjNjWDY4RWZNaUQ3ekhTSmM2TWxO?=
 =?iso-2022-jp?B?Z2xLcS9sWHd3ZmhGR1FtU1NvdTFqS0ZJNFZsRk9rNjlFS0QxTkhnSGJq?=
 =?iso-2022-jp?B?cXUrR0xrSXorSTJjZEFsQjNldnZ6djBjLzJlSW53UE1aQ0syb1VpNGVn?=
 =?iso-2022-jp?B?WmwzRk1UTDQrWGxDQWR4dXZnSUc0Y2RyMjJGdFZ6RjNNRCsyNzk2amd4?=
 =?iso-2022-jp?B?dVRJOWR4a25FaHEySGRKcDIwcFd4L1J2a1VGYzJFNVVKTjZTeDFjanRa?=
 =?iso-2022-jp?B?YzYrbFhhRFJ2SkxQU3NpU3FsdHRZN1FVRE92SVI0OExZOWlYQmRMdE0x?=
 =?iso-2022-jp?B?UldkZk5QS3pvR2d2Z3J1VUtSV1YxeFZUb1JNeFdLTmVJSFh3RWJrWDZw?=
 =?iso-2022-jp?B?a0ZaOE5YcnBkLy93VldKTVo1d1J0Q0p4UzYzL3BaNUFUN21HQkU1UGlE?=
 =?iso-2022-jp?B?Q1dRNDMxZjYzR3M1bGN2WHZ6cTh3M0kxRzQzL3g2TDBJdEZvdXVHai9j?=
 =?iso-2022-jp?B?WVIxZzI5MGRZTFBhRU4wS3R6UzQzSXJsWDFSOGVGRy9mbWFGc0kwaGRQ?=
 =?iso-2022-jp?B?eWNHYXRNenpLRjdqVGFRbzRpdWxZL0RnU1E3Q0J2Sm00dkpleUllTkdq?=
 =?iso-2022-jp?B?QzN6UlA5aVhOQ1lFMHRUMjQyMnFZMkV6OUNLM2hvQzVjSW5CcGhNRGg0?=
 =?iso-2022-jp?B?OHFHL3hIeHBTcjFDMGZrSEZFR1JHUXpvWHU0ZG5Jc3RyandLVG5LOEVX?=
 =?iso-2022-jp?B?V2JJNmh2VFBJbXhXVjlLNlVaQkhNQUR3QVphaU1jZ2cvUVlQczBWcmV3?=
 =?iso-2022-jp?B?UnRFRDJGM3N4aTFnT2diSmNVM1E0WjlwMHM2L01oK0ZRc1E2cDVQZUdZ?=
 =?iso-2022-jp?B?dHpLNFIwVklycU9tWXpqVUJSaHZzVWprT2x5aWJFcFZ0QmR2a1VsbENY?=
 =?iso-2022-jp?B?bVphN3c9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?enFzMFk4clVLUytJOHZqM2dRdnZOU1U3TUl2Q29CanpQMDNVak1URzRS?=
 =?iso-2022-jp?B?c25ZaW5TTDVScnN4ODFqcUtuTmxMcHVxbk5RdFh2eWYxcm1pdGFjMUZR?=
 =?iso-2022-jp?B?NmIwSGZ2WllxR3VKeTg0eHdrNE93ajQvSlZrSVJyVkhCNFFlL3J1RTJJ?=
 =?iso-2022-jp?B?MmlHWkx5WXlPQUFPaVEzTzl0VnB4UHFMckhBd09vZ2FMTVg3eEFRa2Np?=
 =?iso-2022-jp?B?TmY1VWY1VmtqZDJkVXAvcGs1QXdRSDdwdVRkZnBQbWpIcEhHTEkvbGtq?=
 =?iso-2022-jp?B?UHc4S2o4cEM2Zi9qd1BzN1ZLRXIwNTVZaEhNdVg5T09jdkYwcjZ3dHps?=
 =?iso-2022-jp?B?UHB2QjRKVTFlaXF3am1WQ3JUajlLNXRyN296TTh4QVh6U2k2UG5qUHVY?=
 =?iso-2022-jp?B?WjAzOHNWSWtGVkk2UzBRWjByZ2ZIN1NnWERkM2RZLzVSUG9rVlV1RXJK?=
 =?iso-2022-jp?B?cVFaL1BzTnpYbWJtMTVLOXNMbkQzMml6RElxaC9McHVUamVGMlpVdS91?=
 =?iso-2022-jp?B?RElra2RSOWtTcGZ4dis5ZldpcGNRRnczTDdnREIrUVVGZk9MQXo0SFpp?=
 =?iso-2022-jp?B?UmZsTXlxSGxBL0RQL2ZPdlRseSt2VVMvU0F3WHFhYkVPdm84QlphWjdh?=
 =?iso-2022-jp?B?ZlVNdkN4VW1nUlFRV0lYSHZRTFVXNVQ0UEpLekloL09uODQ5Tkl1MG5m?=
 =?iso-2022-jp?B?cnVqUjdMdEtQN0RzS3J4NEsvMG9qMTM4RVJWSkNKWGQ3bWtsSVBaY1dF?=
 =?iso-2022-jp?B?RFN2NzlaQ2FuRitvUDhlbEN5RndGTHVOWUE1VDhzeGJrOHRhd1N4anFi?=
 =?iso-2022-jp?B?OXR4eHpqVkhQd25MRExQRENyTHBsOGRuSnN2WG0zWnVqUGZSRU82Ty9F?=
 =?iso-2022-jp?B?SVhmSlM0QWh1TTRyQUFPdW9udWlVZ0QvVTVnZVk1SnhvaXJmUUxrN0ZI?=
 =?iso-2022-jp?B?dG1zOGxnUUtQWWgvemlCRVJMZkx5cjBBeDQ0UlJINnU4OHlZNWNXd2Uv?=
 =?iso-2022-jp?B?cmJ4MnNxV0dnMUtqZkI3THRyaUU0eGNpakhiZ2tIclpJc1RpZTlGb215?=
 =?iso-2022-jp?B?amhoeXdWRWJrd3htZllyMThMUlZ2Q0t0VDVvcklsM0ZNRmdjUnRHcVcw?=
 =?iso-2022-jp?B?KzVCNjRjeGIwMDFaN1E1K2dySkZWaVl4am9SbENsaytuM2w5RmdmdVcy?=
 =?iso-2022-jp?B?dzFvREZMZWpwdHY0ZDAzU0ZMVld2OVprbXArS1QvMlRGQ0tNanliNnhR?=
 =?iso-2022-jp?B?MVgwUnJ2Q21PZFVvV0J3U3UyU1hJU2xxVVFUd3FZZWpXZm0xbEg1VHJr?=
 =?iso-2022-jp?B?NTNVZDRpbC91SjJhOTNxUkhVVGsyR2VZeTljS3JkV0I5VGtDYzJ4Tm1P?=
 =?iso-2022-jp?B?NXhDd05zS29CaTBPWks5V3B2WWZ5b0xjSmgvak5FSVJ6RmQvZno1UlVH?=
 =?iso-2022-jp?B?am5NaHZzMUhqRVFiakJnQWRxQ3ZKSjM4N1g0U1pzQ3VQV0J5cFJiSVo4?=
 =?iso-2022-jp?B?bXY1ZTRuaWRQQ3hpVm9QeUNWNzdyMXFaNG4xUnpmRHFiWXVxeDJSUFJO?=
 =?iso-2022-jp?B?c1ZQQkxOaVNTQkNxUGRLNEtzaXh1aHArWXVmZlM4UjdEbVl1dlBGVENI?=
 =?iso-2022-jp?B?eklPNitJU01FbmgrRFZQMmxsZGYyVG1kdDM0SFpMNE9HbWxXK1pmWVhH?=
 =?iso-2022-jp?B?bjNaWlZaekJEQ0ZnVm1BRGVIK0U0aVZia01OMUNmWXJ0R0Y4VUJFVkkz?=
 =?iso-2022-jp?B?VGJxOVFxa3lubDFtWCtuZHlyRjFoWVhwSkxWS3RHVUlldGEwZEhBeFIy?=
 =?iso-2022-jp?B?QkxydHhtQjlWdjVZSis0QTFDakRGYXNtZUU5a2RUZWgwNVpsTTF0MmJ5?=
 =?iso-2022-jp?B?dnlRaHIzZkpYSHlRRklJRGRZVUdGLzdvait5bytTa1hMR2NLa0JjSkR1?=
 =?iso-2022-jp?B?OEhRRFBBVS9XNTRWazB4Ny9MV3NPUUZ2YUFHMjRFWUtacVN5cnRkTyth?=
 =?iso-2022-jp?B?SlpZLy9ZQU8xTUUvRytxVktCQ2FacjhqdU9yMEhNTFpzQ0pMMExMdnZX?=
 =?iso-2022-jp?B?QVk3VGFqajdJYlZ4SGVQY0NLU2lCeXVjMEdVa2hIVDJySUMxK1FTZVds?=
 =?iso-2022-jp?B?TXZJZnpOOEQ2Q2dRVnI5VVp3Q3pnQXh0VS84Y3pVdU9EeUovZjFVL3Rl?=
 =?iso-2022-jp?B?VWxLNThkejN3QWdoaFhhaS9neGZCZ0piREVXQ1l1bXRPYlhQV0NPc3pN?=
 =?iso-2022-jp?B?bm5Uckh1R3JvT1MxR0VXMStBYWtscmxVK09kcWpLS1ZRdzhhZmtWZXUv?=
 =?iso-2022-jp?B?WDg3WDNWUDAzbkhFZ2dqeFZHMzFCWEY3Umd5Q2dTMGJ3T3RKWUJzWEFs?=
 =?iso-2022-jp?B?TE5pMjNQKyt6S25HOGxmVS9LNlg2UGZ2NmQ0V2FEWFJuamk3ZDJ6S01D?=
 =?iso-2022-jp?B?VTZQK0NJcHRBeG5tenhEU1ZxRTN4eW9KdjI2ekxTNzJ0L0M4NitRalo1?=
 =?iso-2022-jp?B?Q1g1UUhPOTFCWE5OTUU3Qm9QYkVvTU1QUEdscTRJdGxRRXZYdGlEQlBp?=
 =?iso-2022-jp?B?Zk5RcjN2RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eaf7ae-02ad-480f-1780-08de57e0ee97
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 05:01:12.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuBI0uaAMEZuNxu5nQ4bv0Y8IFJ5ekpFVR22DM7tfP0sntiQAcrp3lCP5u/+BQ3iZGnPcQztbfuZixDLn57+eNFZNqBuhidhnqDgVUOxpucCtZX1l8Qe9O7UlSsMVvn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12742
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 05:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21680

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, January 20, 2026 12:54 AM
> To: ovidiu.panait.rb@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2N USB2.0 support
>=20
> Hi!
>=20
> > This series adds USB2.0 support for the Renesas RZ/V2N SoC.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

Looks OK to me too.
I applied this series with Pavel's Reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


