Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF0D59F7C
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 00:15:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.60817.1730938531362857329
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 16:15:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Ti/HOQli;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1730938520;x=1732148120;bh=kLBbMOt9Izu5Y/LizDhzwp9uVxG+umM0oV1t7Hf
	HquU=;b=Ti/HOQlij4GpfyvovYOQQiaZzKN5n1sVyT6afGX3Q2kfBVRjfLsl1i/buPgRHox+s8zY3
	5IZiKAPdbMi3FsBKpOuwxT1rNe1yPFXJMd5/I1VwRAAp/x5pL9zyTMPR0ba33PT49i/CWbI19Qai9
	XL1rFlKN0wvyDRbcYod7w1EiOplavfROg10bLmrZlWGgrrM+WJvs7H+oZHTEnxaEPepcNq4GPHfvb
	e5bITYmHDcwA/F8oz0kw1DK8dMJA3FKYQlawaS9w6BRGx18UUxyXgK72enKDyn/NriJhq0MAj9Aw5
	piSF+ldoE/fIHKvClJZO3u4lvHEgvgkWvfZ4jsaL0w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4A70FJ4g266993; Thu, 7 Nov 2024 09:15:20 +0900
X-Iguazu-Qid: 2yAaPcpxpjmkPCMGxA
X-Iguazu-QSIG: v=2; s=0; t=1730938519; q=2yAaPcpxpjmkPCMGxA; m=JrO01XujsvD1QJgmxYIMMUjvnQS3Sya3x+rii10MJjk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4A70FI8f2178703
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 09:15:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTjPddm2g0hN/DDk6psoiTgWUCu5s6FF/d/VGsMa6gxK4ixqj2jeGx2jmbP3EkGX4KRASoRJ8i0GdSAMJtcRKB90owx4FOAyL8sivsCDw39IdqwFD2vnoLa1hOwKGAAMCvgbCm93uwiIBx7zoCHHpwUc3qd+jBdjdDDTjQCHXP7uTk2nt+Jpezs9zK6VInl5slsKAOsePdX1V1aLyTfGWUubMRHIimT3s9I7rKNMBmzHvi8TJN+Ys/lngvxzulu9716S6XV3KYutYFnlKNOQQZ9WSPIMeM26kwzu7LV2xUUl59Gb/SHFV543DvpD4rtp08Pgp1/TS9Xtq+2K4Jc+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5HhEr2UY/ycDCe3jBpSK7dVw8R/w47yOxe3f8uamuM=;
 b=saMAR8FB6Sn6hw3QtbvOAG9s3RNG+SZv15l+T5zy3H6rR5+LOWkJXrDF40q+HWwVtlGCwuT67hVgVm6iMTj84ozBaiOD2kLc6VJAds+UVaR/mWtp00no5JI7lmVjhw3pU3FCMRZiU9kBmXMkusiqie8T9h3G7vhiYnVGJCnnE7ns9DmuLjIGCGN04t+nejoLnNiRlsNbcR9hHkeO+ytpDEc9t47+OC/bXM1yUrsqTupjTj0wCNcdj22AQ2CFMcviyXaqtyzTRaqaIoxKB5B0VzQqBJS/e+Zsx5TJ6Fuc3OrvllRybvv3iWrIpXKnXAsw8XmBwjYmGGxRUeuVSZCpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC, G2UL}
Thread-Topic: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Thread-Index: AQHbMGVr7F+7KsSgHEmfV1HS9lamtrKq8ZOQ
Date: Thu, 7 Nov 2024 00:15:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63881D35836D698E201DE3A4925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB7985:EE_
x-ms-office365-filtering-correlation-id: 0922885d-00a6-4176-f609-08dcfec140bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MnlmbTZ6WWt1ZFM4bDFIeDczb1R4cDlSSytGNmswbEpWSXlVTDFBd0ZP?=
 =?iso-2022-jp?B?bG5iMTZQaEgvVTR2ZzA1cWcxTEF2R21EbGEydjhVVVErMnhodzFkUzNn?=
 =?iso-2022-jp?B?U01VMllFcmh3ZWlsLzlHdjcxYittQkZKK2FrVkM2cWVVQU5LNm45ZkNl?=
 =?iso-2022-jp?B?eHBsa3RTdkRJa2kzaDQwVkJDSlQ0dWkwajQ1NFlhSjZGazZkZVJibDli?=
 =?iso-2022-jp?B?U2dFV3NqbzJpM0lCcjkxUjNVYWVpWCtEUWhERXZiYWpkR251eTh3T3Fn?=
 =?iso-2022-jp?B?NzRRSHJUT2ZBa2xURnk2QnRsZUVGeFRDeGg4QnprNWNpdmprQnJneTR0?=
 =?iso-2022-jp?B?cVZPbVdMdjBIaUsxdGptdlgyN2hZUWtnSStET2xZZWtENStNaUF2cXI3?=
 =?iso-2022-jp?B?Uy9pNmNhYU4xR3QzOFhhdzNvSHQ0bGZ0Qi9WSkhTU3F3YmdUT2dVVElJ?=
 =?iso-2022-jp?B?Y3h2S01yNXU1aWppUUkwN3h4WHg1VjVEdzQ2azUwYTJUaDY3aXNDWU5J?=
 =?iso-2022-jp?B?K1hZQXdnQUREcVNNT3VscjkwMXpkY3F5aVgxVGVLNmo5VHhiWWVGalhr?=
 =?iso-2022-jp?B?NVBwTzZJd2ZUS1BVWDNLVmx2dnpUaGtlQVgwcVg2TkVSaHB1T1dUd0E3?=
 =?iso-2022-jp?B?U050WEo4ZFo4TzNCY2pzYk9YZUpwMFUxckc4QlZKZUVWVU5hL2VBZ1V5?=
 =?iso-2022-jp?B?UUlLeHh4OUtNdEJJcDl2Q1g3OXpNaTNhMGFNZnByc01XRFBVc1FDVS8y?=
 =?iso-2022-jp?B?VkdJTHM5UUdSZjJhRHhYMGpGS3ZUSWxmb3AzY2daUzIrVHljdUVITUZk?=
 =?iso-2022-jp?B?c3FWejNPUzA1RXZqTng4ZnNJRFdHdytPZkpmRFRLOW9XWlBmOFZuZ2M4?=
 =?iso-2022-jp?B?VzJjR0UyVHZuSHN0d2xLWUlzOUFhRVhld0ttUXJkakJPZzJJb3lFdUI1?=
 =?iso-2022-jp?B?ZHNEUDBvaTN5SDE4NGRoOFV2b242TzVQckhBbmVZdFNTclJIeEI0cjI2?=
 =?iso-2022-jp?B?VXVRcmtGbUFFYmJIQWVnckpPck43UEs1NjFTRGRMNi85blJtemVNYkVP?=
 =?iso-2022-jp?B?ZEExemFxdDVubDQ4MW1ENlRSUk5laDRUbUorWDBXK3VIT3FCcnU4NVls?=
 =?iso-2022-jp?B?cVp1OHJGaUh2RzVxY3R3TlVHdEU4MlZocnIxb29MZGNldzU3K0x3NW9B?=
 =?iso-2022-jp?B?b1ZrbEZ5bHAzK0lxbDI1aXFNTHBxWTBGaG5rUVpHUFJ2NDRRMVd5Y1hm?=
 =?iso-2022-jp?B?V1Q3ZXExTk5LWUpFbGhZUlB0ejdSNFh4S1dJSGVEUTlDT1crN2F4dzRm?=
 =?iso-2022-jp?B?TmluRkZwUGNqKy9GOFhOdFJDaHdsQjNEUVJBS0tZUVh3YUFtMEtFb3Za?=
 =?iso-2022-jp?B?TG1jT3FjenFhcEZLWjRBaEZWK0NrWmhqY284dDRJcENSanFmdHp1Skl1?=
 =?iso-2022-jp?B?STlLNjk5ank0Zjl4WEFrKzdCeDdESzdiNjArdDVLNW9uWEZYQ1dNSTJn?=
 =?iso-2022-jp?B?V0hHWnpUeEtlcnVCL3NLYmhVdXNsNGUrWlZpZ3luRDRoeXRybkFoMDQ4?=
 =?iso-2022-jp?B?aUZyd3NZdGhPR2FLd0NoQjdxdFhBb2crV0xiVjRQR0NiUGFEb2tZdHc5?=
 =?iso-2022-jp?B?Zll3Yk90NFlOV0ltaHhuak1pbTNxdzhvcW16TGxtYUozQlZNdVNwdWpK?=
 =?iso-2022-jp?B?QndLRW01Zzd1WUhjWklMbEwxOW9abnNFNnVMTFkzc284cmhDRnZ5bWU0?=
 =?iso-2022-jp?B?UGJFMDZiVWJnM0IwcmVsNkxBRUIzUzFwdWY4OXc1MSsyajM1OWJ1WVpB?=
 =?iso-2022-jp?B?bEluZjY5djJ1QjNWMWx5Njc2bHVaTHUzSzArcWtZbVk5N3dWYU1RWmNG?=
 =?iso-2022-jp?B?SlgwTnRLV2EyYjd1aDFudnp1Z0VxQmMzQVhvRENQNENtOWp4SjEzWWM1?=
 =?iso-2022-jp?B?aFhUVFpod2tiRG5NbUxhdy9FZmhrWVZFUkhTVUxiNGtLS2ZUMXpIY3c4?=
 =?iso-2022-jp?B?OWZ1eGRWdmZkRVZDUUo4MWFUSytNc1cyeGJRa2V3dGE2a0pxZndHY044?=
 =?iso-2022-jp?B?K1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bXc1a3NCR0o1Qm9mVU9xTGtZcnJsVnp0TUxUK29GZXNvN3RQSmtuVmRS?=
 =?iso-2022-jp?B?UTJlWTdJandqeEhTTFZldHVYQ3Zmc0VOak1lMHJKVU5raGZWSVVnVXlt?=
 =?iso-2022-jp?B?ZUk2RlBiRmxzenR2M1RQdVNsVXRGZUVpUHJNZ3pPanhuNWxQZUxHVzNM?=
 =?iso-2022-jp?B?Wkhib0lzK25CTHI5b2JnWTh6QXNKWUVXQ1J2bXJVdlFlYzUwOTJ3R3Ew?=
 =?iso-2022-jp?B?ZkdYUG1UV2Era2FMTlRlcURHSUVaWS83d1dIaHhWNDUxV1lLUTFuN1lQ?=
 =?iso-2022-jp?B?YXhxNVhXaTlrMjBmczNuMU10NHdOTGxpc3dydEZlb3BWS1JRYmEvcDhI?=
 =?iso-2022-jp?B?RUF4amRQSklCQU52THJXSWRxSnVUazNyK0xtK0JsR1VUNmFDWUI4bUdR?=
 =?iso-2022-jp?B?ZGlsd29UcXRxTEJKa044U2ZGNlpYdHFkeWNiMEV3V3pwN3BlS0ZDMVhn?=
 =?iso-2022-jp?B?WU9yZ0dZd1grOHdyRjB1QXJvbE50S01EcWpLblpQR0FMOFRKSkJOKzJv?=
 =?iso-2022-jp?B?bVJ5WGF4R3prZjNpVEFEUXRNSys4ZjF1N1FmOGpaQWtEYW04bXhvUDNN?=
 =?iso-2022-jp?B?THQxbE5hcFR6U2cxdUlGMGZvYjR1SEFka0lIWTBWVzc3RDZZc3MvaEMy?=
 =?iso-2022-jp?B?KzNJUFZsbS9adWZhTHZITFdnand0NTBzTktsd2lnNC9XNkpCbGpEdDVM?=
 =?iso-2022-jp?B?ZlB2dWs1NEJ3VlVVNGNjL0FwY3d3QmF6UnVWSDdQQUNHeWJWM2h6Snh2?=
 =?iso-2022-jp?B?ZzVkcVM1S2lFZTdmekd2KytNOW83Nm1aZCtSVHRabnVKRjIwQUt6Mmdl?=
 =?iso-2022-jp?B?dTY2anFPU1UyM2dvMElENFhBL1hhVHVkc2pyUzhVN0gwQnpXcEZta2U3?=
 =?iso-2022-jp?B?SGplalRBdXh5TjFDdmhHUXZZN285a09NUmpKNTd1U0Y2anRyU0VVZjRy?=
 =?iso-2022-jp?B?N3pIM2lUVzJTMnhuaWdSYXl0M3BOU1VqbCsvbXBZZnhHd2t4VHRJZFpO?=
 =?iso-2022-jp?B?aXdEeWtadFpiY1JDUUc2QUlXUGMrd01CVjJyWU54ajFrdDJMejNIVVBJ?=
 =?iso-2022-jp?B?bnM1Tis3dnBpQm11WjE3OXp5QTVLMDBjVjdmSXNRM2k4bkdWS25maUhD?=
 =?iso-2022-jp?B?eFNaMzFqdnhhNGVBSWYzWEF6cGV6UkpVWE4wMEwrUjN6Q2RTK3h0ZFJS?=
 =?iso-2022-jp?B?WG9IV0NHSTRUUC9QM3QyQ0Y3TTFDU00zN3hVRm1yd2Y5bmVXckhUT2dh?=
 =?iso-2022-jp?B?aGdyQ05oQ3BkS20rTlZpTjZJSEd5SDk4QUR0aGgvSStFMXVyMG1IbXZv?=
 =?iso-2022-jp?B?ZkFiNDBOQVR6WS84ejVyaWkzQm5lRFVzOGZ4SjNtZnJKQkVhSWJwaTJB?=
 =?iso-2022-jp?B?NWdDNXkxZDYxZU4rLzFKN1ppRWhCNEMzY25SaENNUmI5TDR6SWs4OUQy?=
 =?iso-2022-jp?B?VURrL2VXaUJZM1YrOUJvcHgraUc3ZHNqVmo0KzVla09yMGFqRjJtN05h?=
 =?iso-2022-jp?B?UmU1RU85QjduRzlyaVVsTHppZnlmL3djS3RhZUJWQ2xJUDhiU3laUE9h?=
 =?iso-2022-jp?B?b0drM2pGWmxHUTFxSEdoUWJhVk45QUQwYnhvdmY1OXdEaThLYlFYeXRI?=
 =?iso-2022-jp?B?RURyeXBpQ0VCa01saEZxZGpORzQ0N0NmZkcvMUJhYWsyd2JzVXlnUGxl?=
 =?iso-2022-jp?B?d3FjQmdRcTIwVlA4RFBNN2Q2MzNERlJ3Y1ErbmV3SlgvUGIxTU5Wcm5Z?=
 =?iso-2022-jp?B?WWUyLzBlQ2ZmM2llOW5IREJhblhvYWlNWkE4ZkJzbXRhMkNMVVl5ZXlK?=
 =?iso-2022-jp?B?TEZBSmZxNUl1YnFUSlVUY2VjVFZxb1NESGl6b2lrQ3JDaWtMOWFZbG5h?=
 =?iso-2022-jp?B?U0QzWmNJY3Nac3N2QTI5aFZHMXRXRHpucytERXkvcmJhT3U4alVKeloz?=
 =?iso-2022-jp?B?T0RXQURuZndLeStLWWJiVGlZT0cxcUxwWGZGL0ZxZXhRK3haUWxJaFJS?=
 =?iso-2022-jp?B?UkpMQzdSZklXVnB2ZXFESE15MUtSZ1hJTWlZbDlZRUM3K1FrcjV1OFow?=
 =?iso-2022-jp?B?aHRPekQ1b3lQUkQ0VkJkZ3JKaDFsRkcweTcvc3R0MUkrWGpyTU5DOUxJ?=
 =?iso-2022-jp?B?bER2TjVpMUhrM0lpVlV2cFA2SHYrR3BmLy9GTkZoZFc3T0VLWnMvM25z?=
 =?iso-2022-jp?B?bXBmRlJsWG00K2hteGVzSkFTdnVsM2xVcjFGQVJSZnpndEhjWXVnMXhr?=
 =?iso-2022-jp?B?eGhnTVZvRmlOUm9iSC9QSmhwODJBM2xqNHBITTdEck8wenhVWk5UbEpr?=
 =?iso-2022-jp?B?MUNqZ0FKbzFTdEw4NDBobXZhUXdBOUkyd2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0922885d-00a6-4176-f609-08dcfec140bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 00:15:14.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IO8DS4JI1DPBj1RfF3jJG7E8Ced5pKY2KKEesSojCIPZswWshKNsDmBSLq81wiaw7RqdQPMpZ0IYYqUriq+x4hxfet4I0KPisSiXaiXRxSIoEc5cYYNvF3UEMak9o8J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7985
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 00:15:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17193

Hello,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, November 7, 2024 1:03 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC, G2UL=
}
>=20
> Hi All,
>=20
> This patch series aims to add (and enable) CRU, CSI support on the Renesa=
s
> RZ/{G2LC, G2UL} SoCs.
>=20
> All the patches have been cherry-picked from upstream.
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (4):
>   media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU
>     block
>   media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2
>     block
>   arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
>   arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support
>=20
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++--
>  .../bindings/media/renesas,rzg2l-csi2.yaml    |  1 +
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 69
> +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  8 +++
> arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  8 +++
>  5 files changed, 117 insertions(+), 4 deletions(-)

I reviewed this series, there are no problems.
I can apply this series, if there are no other comments.

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/153062924=
5

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



