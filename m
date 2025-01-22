Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E58C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 08:09:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.38316.1737533349260613834
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 00:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=n4KwEN8c;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:MIME-Version;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1737533347;x=1738742947;bh=3mMLs
	ru0bVdX5K0ZqC0gvP4JFwHsErtHuuM9XtSlLSY=;b=n4KwEN8c2cEGStzk17/i2m+TyAK86a4/HgT
	CDy9P1rNa5aQSCh/3j026iq5Ekz1wp+LjsEU/HC+Lt4U2VHtle5aDF5nqC2nTk81ya1y7RyF3l4G3
	2boR7wSb3lEvTB9bf+A8Sr8jCpPGFm23kAO+yujyKIreC6TYCIfNS/yGBEvf/X3vkwdX7G3ltAO1h
	QrBx4GaccK+teSKKWNNTgRPbzeTTJpr4M+6M87/7GWofQJSQW7dolUuIMYJKsRkxERL+PSrDnMzUl
	VZC5jYFHAn0YteiA8R9rsNdG+pXD+t9e2VJUlI5PTGSkA3mTWHY4fcWsBTVMVG/Ne0NmYd749gJw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50M896rK3826663; Wed, 22 Jan 2025 17:09:07 +0900
X-Iguazu-Qid: 2yAbRDIdsyidbpRZX4
X-Iguazu-QSIG: v=2; s=0; t=1737533346; q=2yAbRDIdsyidbpRZX4; m=bhL00ODIjihLy9fwZh7iCC3wkQSOb47rHdqKWi951vk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 50M895ji048867
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 17:09:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob5Z7DNQwKEyrOa9/M1DFP5YPXjfVf+1vSaGAU1T433I98M/UIGQC5MwCLZMKZeZAOG7HtFj66sgSpbKeG4XAxkA6vcZvSkH+P4yG/1IFv+yFpYeVN6tSfpRZ7iaw28e1VUR4pxvOe5FBuHtSQTxJ0ekcDSm3luwb3YuUsxYfzdTWoTMOEFtanyI6Y/DQJE9/AdM4VjJ3oDAaCG3iaKS4SXGec1FOkzLV9dEpvwmqkv+eEHfLqUpDyV4ek8PeDJ0vphs1b/WbMqzxMEfYUICd6NaKIo/Df2IUGgS/ECFMDlCeDI3PIx+P851hDPYJ1sM7sKSd9/qTBrHHx8TtFNvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPti4kUpbwjQXHGilP0oDB/fJb5tDQV5xJ1n6fBTbw4=;
 b=hXyHv+PcZTZvKhkB0F3X7LPJF+5cvF2qa1BH/UcxpidgSxUX2S3cykseYvLuF62V8pAUhj95XV5XLNYw9rwn5ZIZIaBoJngZ3LV6CrqiROf7nQI27BA3oTGE5IcW2+uCPubioYs/l/YvlgJ3D9j9MxlL8pJFyyLX+K4RGDr88mBVwOJm9bWpqqXR/8pIhRG9/d03yoO3FY7fICFVcr/s16saWo8liPAgPTfRyRBN69VPaADyQthHKuHStC5oNDuYf29g9YYRifwsIzccRvowCFj4zTI3dp8tRT9QxHpPqm6v5lmzoaNn97glYGNopvjHHdlFWl3X5lnLEzNB/Q3Bzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzgBe04HoAA8CxzMA==
Date: Wed, 22 Jan 2025 08:08:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
 <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
In-Reply-To: <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|OS3PR01MB10091:EE_
x-ms-office365-filtering-correlation-id: 41de6ce1-b0aa-4fe3-1160-08dd3abc06ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d3ByNE9KVjN6eGIwdzJPOEMrMVY0WkxsYk54QktwWEJZNFVoTnphM2hk?=
 =?iso-2022-jp?B?eWp1T1FMeE5YT3NJMWdOUlN1Q2VlZ0E0VU56MlZWcVM1WkpWNllrOFNj?=
 =?iso-2022-jp?B?cXBTa05IU1RxSmUyZzFTNFZmdXJmaURRMmlpZ0s4b2tGVkpoSS81eXlz?=
 =?iso-2022-jp?B?S09VY0lzQU9oeUF1MFdtUTJPREFSb3VWdTZvVjZ5N3BMNkVHRUVvMXpx?=
 =?iso-2022-jp?B?bmFsQjVDZ3dadWpONGRSYjBVaGtyMWNDV1lTdmpXalBqUzg0b0ZzbDRz?=
 =?iso-2022-jp?B?ZEVDNHFJNE11TEJLZXhPRDJyWTUvUEFXeXhSSHFNMXlkc3l2ZGErOW55?=
 =?iso-2022-jp?B?eWVWRGFiOTgrWEpIY2FuMnZ2Y3JCblczNCtWSDdNZzBEV3ZUNEN3MEcw?=
 =?iso-2022-jp?B?R2RsaVdQOUtpWEJaZzVkMjBDa0tSbndXTlNSNmpwN3NkZnhwZlhJeHFw?=
 =?iso-2022-jp?B?OCtxRlBCZmFoZW5IOGdIODVRdHJzSThkRmQ3cUU0ZGdkT3oxQyt3YXJC?=
 =?iso-2022-jp?B?c1JlVi9vb0x3Skl5bHJjUks4SHBVWEJpVlo4ZEZSTmNDUUpYR0JMNXdC?=
 =?iso-2022-jp?B?a2NqbUNURW8zQmJ2OWp3N0t2RmZua1BINGRKSG52VElOTy9rUmJCRis5?=
 =?iso-2022-jp?B?RFFDbHlkc3NiZ0tSSDdLK3hydHM3VkUwTE9jY1pOdGt6ekovRE1LZU53?=
 =?iso-2022-jp?B?WlA3ZDkrYUxMK3BWVUNuQU5Fbnh0eVJXaHRzSVhpWCtaZld6d2NrNHZr?=
 =?iso-2022-jp?B?MUV5UzFWVVZnMko3dXB0MHhQM09mRDRqSkhHQ1pnbndJbzFNa0paVUd6?=
 =?iso-2022-jp?B?RUEvM2EwSXVGVllScUErQVloRzZXd1MwSGJuRE5OVjc4ZVpZUmU1Umwx?=
 =?iso-2022-jp?B?TzkxS2xLNThPMjkreWdWa09LKys4OHhoaGYyMzBLZjhlbldFZWVBdnNY?=
 =?iso-2022-jp?B?UVVzQWpkdTE0OW44NGEvV1dVQ1plVmFid2E2SEM5cDAxUFRFM1ZmWHVV?=
 =?iso-2022-jp?B?REZscHdrVmN3WmFpQ2RzMTJlK2lQNTF0bTI5WWtYQ0J2SEF4Qm1WSi93?=
 =?iso-2022-jp?B?SnRVYU5sQmpUejZNRVVCUWUwY2dwL2NCWVd4dVlzMExhazdKRWF0SGVS?=
 =?iso-2022-jp?B?d1I2OGRnVm9lcmxMd09SVHhOR3hqbUdaUUdSN1pXaWY1cHBMQjd1Rkx6?=
 =?iso-2022-jp?B?dENjdUltV1NuTi9kS0lxay9YRlR0NXBrVGZHMm0wNkRDT3NqdGZVT05B?=
 =?iso-2022-jp?B?bEZBeTYwY2xCbENPVE1ESVpxdXJhdE4wRjh6Q0V3OStZR1ZDaFpvckFW?=
 =?iso-2022-jp?B?VVJocXlJdjBoMmpoa3RQV0dSSGxQN0NKNERLSVRjUDVsK0dKY1liUVB3?=
 =?iso-2022-jp?B?V2tZbHkyc1A3N2hPK3JMVUo3THpmQmJ3OEtGWXRhdERoN0NyT1BGcVpI?=
 =?iso-2022-jp?B?eWo2dWNYdytXemM0cEgxNG9xSUVYalFXS1M3cHRzclNER3NBdWhEWUNH?=
 =?iso-2022-jp?B?Wk4wdUl4bVdOV2kwN1lwQ245bkdWcC9KeDhpUWJsbmV3M3NicytnVUZi?=
 =?iso-2022-jp?B?cVdpamxqQWhacVR0bXJvZmlWNk8vRzZlQUlTQXZySWdKM3JJT3ZPUHdT?=
 =?iso-2022-jp?B?ZTFSL3I3ZEsrb1FjOHZHaXZTYmpaMHBsZGRKeDRYMVVSWVJ0YWFwTVVz?=
 =?iso-2022-jp?B?Znc4d1R5aWI3MnhTWlJzVk5LUVMxVWtOb2w1SWYxQW1UUkRsQWdYdVpp?=
 =?iso-2022-jp?B?bGI2dmhKRWxMRU05YzdFVFIxYUZ4cEhFQlFQMXpvSGkwMXVMSTRRbFBP?=
 =?iso-2022-jp?B?eWc2KzJMbGtNOGgycmduM28rRXVhcDVqNlgzd1R6Qlc5MEdNSVR4UDB4?=
 =?iso-2022-jp?B?aEhBa1JtTWhmT01tVlhmWHQ5MEVvbDUrNCsvYWdhMmFyQ3l3YzE2a3hE?=
 =?iso-2022-jp?B?TzJUSlhaMDg2SHpwbnVSSGg1b1RSQXE0ZkluR2lwSXpHN0lIekxKVTNJ?=
 =?iso-2022-jp?B?QkZpV2xDWlJEaTR3UjJzNGFpbm1yTA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0hHWmxwcjBQTGk2QjFUcnhzb1ppTzN4OGQ3NXZRVzVlSGpSMXNwOW1G?=
 =?iso-2022-jp?B?Q2dJRVNUM3Zrc1BwL21SaW16RVRRYWljVC9UWVkwNVBhY3dXVGRnbG5Z?=
 =?iso-2022-jp?B?aEFPR3d3Rlhqams3MDdBSG10Y29CU2ZVbFVRbjRVV3hmaDlDQjkrYkhH?=
 =?iso-2022-jp?B?NVBEODlKdDlralMxM1llV3FKREZRVjV0S1FIRzM0MmhldzgyTGZ0ZEdk?=
 =?iso-2022-jp?B?cnhuR01OaG5oZ25DMWVXNkdCdFFjWnJRaHMrL0xsbzRjV2pMeVd1YjN3?=
 =?iso-2022-jp?B?NDNHNlBtZHRmU2xseXUzbDVwSzlFNDVJNnR4dW9wMzZvMnBjZmlWc1hH?=
 =?iso-2022-jp?B?cytHZlV1YkFQQ2JEM0Y2SzlQK0w4U2hJQ3VNUHBwaFlOTk80WE9MNUN5?=
 =?iso-2022-jp?B?YlNldXAvNlJibFFtK0FKK2o4Q0NkNS8zOHE0cFBqeGxhcGZoZEl1Z3JU?=
 =?iso-2022-jp?B?U3Q2Ny9zS1dobG84cmRDUlJmdDFvU1dXRFZscUlDWkpRWGQySGZkNVVZ?=
 =?iso-2022-jp?B?dXJESUhVNkNQeVJEK2hPa05YQlFXT3krNU5JdmRxZlR2K01CMk02K1Ew?=
 =?iso-2022-jp?B?aXBVOE5PZEFRVVBJRkRNS3ZwaDcrVys2Y1BuSUJ4UERRZ0VyNEpCV0Q3?=
 =?iso-2022-jp?B?UzZqWkZUck14c0FFN2JrZ2dTYWNrZXkzb0pxWUloRk1vdEkzbCtCTVV0?=
 =?iso-2022-jp?B?ZjVxSmtCZm5kcFd4RnBZMU9oUHZqZVE2UldBa2Z4TjBQMVR1eFg0dmM3?=
 =?iso-2022-jp?B?Yk5UOWo1VnRRNFAxT3pzc0FpREpZT2pac2cxa2NrM2U0MzhJWXlLVWFU?=
 =?iso-2022-jp?B?a0h2djd1a29nM2ZUdXNhQXFrUnp6MWpaUUk3TDJGWFQ0bFhCSWJodEdn?=
 =?iso-2022-jp?B?WWFrRWNCelBPdkk1Z09OTmhzSFBGQWxUSm02RjRzaWRDclhXaU51a2ps?=
 =?iso-2022-jp?B?NURxalY1Mm5zNWdZdWdZOHBEbHVaZEJrWG4zSU45QUVzeGZQT2Y0VnVx?=
 =?iso-2022-jp?B?T3dUdkwyOWNNQ3NaK0x1cmc4SmswNTNiQXErMjFCMm9zWjdVYVNyeUlY?=
 =?iso-2022-jp?B?bnIrMUdyMWpzVDNuNGdoQi9CNHVERHI4ZVVqREM5RHNwVG1TeTZhYlA4?=
 =?iso-2022-jp?B?S1NjSjJ4V0JKbHhRNmVFK21tcCtMMHJ2ZEk5ajJKVWpGK0pwUUluRFdM?=
 =?iso-2022-jp?B?WDVCT3ZxcnJpTVdNRzhTTkVlejVkZE1kYVZXVVdnTGpVVjBaZEhFTUZX?=
 =?iso-2022-jp?B?TjVtdk9BVFZISGI2QnJtSU9HYjFUUTFYaWJjQmJjSWptU1V5L1E1TnRk?=
 =?iso-2022-jp?B?b0FXZE05VTZEYk0rNHU2bllEWXRmNnh5ZG0rMXNzeDdDK0c4dXR6Sk55?=
 =?iso-2022-jp?B?bUxpUFlTeVFucmM3UFFqeklGc2hycTdHL1ZKdjR0NjZ3cnRzTHBESjJZ?=
 =?iso-2022-jp?B?akZuOE5ESEpjTUF4MnNjNDRSWi9TV3dyOVZtU0h5U2NadVVpQ2ZheXhq?=
 =?iso-2022-jp?B?NS9ENWhSc1BvR2dMeXVJSVlQK2VsYlFQZ0xHRWxQTHhMVGlGQWxhczJR?=
 =?iso-2022-jp?B?aUZYOHFaemhLbDY2c09iMUNPSCtia21kckg5TG13YnpmUVhUV2phcHp4?=
 =?iso-2022-jp?B?MGNteG13SlFQd2tWc1JrVDQ2aGF5aThxQzMwMWVobkh6WFd2QTNFQ0la?=
 =?iso-2022-jp?B?WkxNaVZNVm1jRHcwL2xHWkZLZmowQkJtR24yV0E5NHpGZ25SeWFib3h3?=
 =?iso-2022-jp?B?WTMrYzJrQ3B4Wk5nNUFvaVJRdkg0VEV6MlV6aGxXYUlLd2tFbnd4Zmhr?=
 =?iso-2022-jp?B?Qm8xa1FBY09SK0JHc2tGMjVlUTBmQWcvVEgvU2IvanZXZW1qUVFTV0Fy?=
 =?iso-2022-jp?B?QVpEYlJSeThadTJHWEg5M3E5Smx6dzEvc1BtVGxLZkVqcFNnSDlCcTBM?=
 =?iso-2022-jp?B?ekRqTTVYZDM2VVBRTkdtVzRnSHpZcGZyZU1BNi9oMzZwdWk4WFZyNFZO?=
 =?iso-2022-jp?B?TWkyUWl2U0xRc0JxOFZUdFI5Zk9BbzZGSmh0ZktSKzROT3FWKy9mL1dR?=
 =?iso-2022-jp?B?ZExGbmFPRkFxbHlVakczd2psTXZ1MU1IWFFOQzlpRHJESm4vWWdrSUg5?=
 =?iso-2022-jp?B?bDNWbTllWnZEZVBVRk5PRHZlWGk3NHhKWW1Kc0RzZ0JBelhIaVM1R0Vx?=
 =?iso-2022-jp?B?SHNrdHRaMXRzM0tBTFlOQlZvU0ZkY0w2alM0ZmVzYU8vZHJkR1g1YmdD?=
 =?iso-2022-jp?B?Y1RtZThUMFhEOFNqVkplaVczVjhCUXMyaE5qRkJxRktFelFxN0ZRN2RN?=
 =?iso-2022-jp?B?a2E4ZENtRDFBOXh6MytPaWFBOWVJcGRJZFE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_TYCPR01MB11385BAF7D5C56CC8CC378440E1E12TYCPR01MB11385jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41de6ce1-b0aa-4fe3-1160-08dd3abc06ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 08:08:59.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkWz7/GO//3NHPOlVN55QkTozpIYVAkAaXUDW1+3cVuyhoVkNXf2IeCPTIP2IK2c+6viObsz/RgBSuq1SZ/R70xUSKG92Oh5WDNMtLbZLFcnJlQrcP+muHPrKlCOZ06K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10091
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 08:09:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17562

--_002_TYCPR01MB11385BAF7D5C56CC8CC378440E1E12TYCPR01MB11385jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

Thank you very much for your feedback.

> > Picking SYSTEM_SCHDULING and related changes up may be the only way
> > to resolve the repeated WARNING issue in 4.4.y-cip-rt.
>=20
> Ok, so you have a series that should fix the problem. Can you verify
> that it indeed fixes the warning in your case then post the minimal
> version of the patch here and to the realtime lists? No need for
> series in submission format for now, just "this works for us".

Yes, I have a (draft) series for 4.4-rt, but it is the same one as the atta=
chment
in my previous post[1]. I attached the patches again in this post just in c=
ase.

* 0001 - 0015 : Backported from v4.14-rt patch set [2]
* 0016 : A change picked up from diffs between v4.9[3] =3D> v4.14[4]

(A patch for arm64[5] is missing because it requires dependency resolving a=
nd
does not affect my case (x86). I'll try to backport this as well if needed.=
)

I already confirmed that the repeated WARNINGs in unpin_current_cpu()
do NOT occur in my x86 environments as I reported previously [5].

The patches can be directly applied to the both v4.4-rt and 4.4.y-cip-rt.

Do I need to send those information to the both cip-dev and RT mailing list=
?
Should I create a new thread or is it sufficient to add the RT list to CC?

> If your analysis is correct, same bug should be present in 4.4-rt
> .. 5.10-rt. Next steps would be to get nice series merged to 5.10-rt,
> and then we can fix it in 4.19-rt and 4.4-rt.

It's true that the bug is present (the repeated WARNINGs occurs) in
v4.4-rt .. v4.9-rt, but I cannot declare that the "bug" in v4.14-rt .. v5.1=
0-rt
because the WARNINGs never occurs after v4.14-rt (i.e. with the attached ch=
anges).
The most important thing would be to know what the patch 0016 intended.

[1] https://lists.cip-project.org/g/cip-dev/message/17273
[2] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3D9ed2ef6690a56
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3D6cec8467e86c0
[5] https://lists.cip-project.org/g/cip-dev/message/17260

Best regards,
Kazu

--_002_TYCPR01MB11385BAF7D5C56CC8CC378440E1E12TYCPR01MB11385jp_
Content-Type: application/x-gzip;
	name="patches_fix-repeated-warnings_20241125-draft.tar.gz"
Content-Description: patches_fix-repeated-warnings_20241125-draft.tar.gz
Content-Disposition: attachment;
	filename="patches_fix-repeated-warnings_20241125-draft.tar.gz"; size=9051;
	creation-date="Wed, 22 Jan 2025 07:39:57 GMT";
	modification-date="Wed, 22 Jan 2025 08:08:59 GMT"
Content-Transfer-Encoding: base64

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

--_002_TYCPR01MB11385BAF7D5C56CC8CC378440E1E12TYCPR01MB11385jp_--


