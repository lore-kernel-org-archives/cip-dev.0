Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79FCF6C0A
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 08:24:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1619.1767774246027378689
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 00:24:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=hy/g4c98;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767774233;x=1768983833;bh=TFQ7QUwJ8whVc32BuPUPHxeu9gzurVg2ipLlo
	UfA8zA=;b=hy/g4c98ZTh+T/HbHFOHNOw+GBgliPLGIa8wP+FjX8ICNC490cGMd2Sq7jWl0LCT2WP
	UPHlaBZ4YaNm8+TlqV6/X+pnarUNhSJ88PNkxP1EdlX+tY6E/vUuUOd/Qd0f6GqBimlDcXYQvpOLg
	V0EwhEeRKuS8as2VDQTCF6bvVBdEjQ5S5ShWIwR/DKMDgsiTOPJUHdZM+rDvOWW7stts0vWdc2SZy
	taH3kYdbOc0lQ8Qo5mDPCtoA8BIGKsFZnukbbYFuCsQyroXPiTmVV0LcrzAfeO0rdmv+t7YeqEbxv
	+ybW1wl6dQNN5fh9tYzF+rR/gIOBNaEYcrn92wPlIJlQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6078Nq4G1413820; Wed, 7 Jan 2026 17:23:52 +0900
X-Iguazu-Qid: 2rWhoMOwutlR01xTTK
X-Iguazu-QSIG: v=2; s=0; t=1767774232; q=2rWhoMOwutlR01xTTK; m=9Pwltgu1YPis/RaFhCNfEoYtbJ3qSs7lLZVAIDXo1T8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmLfJ2Gqgz1xnc; Wed,  7 Jan 2026 17:23:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPh61a9smTKiFEtpL6iS6JJy4+/wERXFfE1MXcPohANfAylvyfsHbnVMy3lIqBz4C1lv+xKSpFLoLFQRoS3FTINhZc5TUl6RJ/qNmIGGuWxHYvGzC4pzboYlhdSjT/rRPEFB+k0JVsElrhVxUPxerlnJEJLhfr9uSNBQDyDJrHnIDvLsUYp03H9Vf3ziBKKrh5upK1bvdJCGQ8mJMVyndrhCa69QF2qMs1KEWjX83OOaRYIr2T0rv1K+w4fGsjtGm1hlx2hRXaoUgHyL/FIfb9PVIcIyZGtTDNdBgi1hLtea7WDMlJ3gnsfYBaJlf7Cb4Nu/a9XJMygyzJxX1pR24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atkieKkjGAw/BP3sSrk3pQpJ2C50A5HnJPOiildWoCM=;
 b=Ri91W5b95BOaYi3A1Akerd/WQudjZQbB4axIPtO/l3qSGAc7tQOGeGxagL0V5Wk6BIW+VvFtE5rZMEOqhnHEz71clbfO8eNKcuuwIDKKW/lxK62E/THU04wJjFIT8aJfdj1EgxCDq2MhzMIZfiXiDi5gjVCjIAndVWOy2IpINyzcH6EXu/Ih1sTCt9ICuwwPZWaJziHDodqOYmIIpCeqQPpkPR8tiN1ZLPWkuxve5t1y7l18od6L9WI88TFT3KoBLxaKv4XUr+ZyVsrQeV/8er9KYFoARlP/4XYidUhAnX1HDkOqlgednQVh1BtZld98qDL4rM9w0vVOb2VTC8Xcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
Thread-Topic: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
Thread-Index: AQHceJ71vRG0R2mvIECDV2QY/SmBaLVGbE4w
Date: Wed, 7 Jan 2026 08:23:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BF6479C1E24FEC289040CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB8377:EE_
x-ms-office365-filtering-correlation-id: d0e49e77-a6c8-4359-80b0-08de4dc61520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aXJCdHRZdzdCcVFDRGk0N1BUUGlLeHEvV25MTzZqYTFhWjNMSndBNVl4?=
 =?iso-2022-jp?B?ZXpsazV1dExFVm1YZjhqWUlGV2FQR25Cb1ZvbVh6WGZhdHB3STNMWXhC?=
 =?iso-2022-jp?B?UG52czE1UmRreldQS3BiOE1PS2dEK1VNenRHV0tVOEo0UUZzNDAyYng3?=
 =?iso-2022-jp?B?cmxLdUdBZHhhcGZ3SmZEOUtsc2xtNHpoeHJsQys5cEJSSm9vYlp4Qi8r?=
 =?iso-2022-jp?B?cFk5Z2hOVVJaU0N5OSttbDJRVm9WL3poSG5ZanVOMUlyUTMrNkNoQ0d6?=
 =?iso-2022-jp?B?d2h0WEY0elZUdXNVTkI4TFhNMFRlVzFFaHIyZ25va1dFOVB5dGhsRnRV?=
 =?iso-2022-jp?B?bENDOWlrUDc0VEZqdCt4WnM1aUwzNXlxK2N2cFRBZHlEZS83ZEtqNVlB?=
 =?iso-2022-jp?B?Z3hEaGFTYzJmQXJoZVUvMEhFREs5WVRESGtaNExsTDRYUE4wTFZoVktB?=
 =?iso-2022-jp?B?WDRwUHYrZHZEdDY5WEIzNjhyeXlzTWJobWhvNVFMcGNmRHhiazRmak10?=
 =?iso-2022-jp?B?eSt1Z3cxUElYTGhNdll0eGdBSjV5aVorL0RTT2xXTTdFcUkzbWs5TEw2?=
 =?iso-2022-jp?B?ZWQ2RDBBMm5wVTl3NzJwRFd5aXZxYW1QcjNOc05rUHh0djJXa1M3S25P?=
 =?iso-2022-jp?B?SlhKSnR4cHVZVjQwajYwKzR1cm9YWEJDZE5EQm44RW5kYnRveDRBcUUw?=
 =?iso-2022-jp?B?eWZyRmhuRlhsdDRFSlZmWkg0dnhVYUR1VGtudHFnQkpuUzV2UmNIaGZh?=
 =?iso-2022-jp?B?NjgvVFI4MUxSSCtyMkZJTDBnNHc1RmJHcGg3bEw2Mm96MUpRbDVjVStK?=
 =?iso-2022-jp?B?OU9TMkZWTmpsaTFpM2JrdHRpTkorVE1RcXFKV282aEtxaUhWa0RLUVFP?=
 =?iso-2022-jp?B?bEhGR2hpRkJ0YXV5UlRDd1NSZ2FCSEZ6bHNXT3FPWjlDcGtobzU2ZVlR?=
 =?iso-2022-jp?B?SkFDWUE5c1c2bFYzOGJNcE82Yjg3WG93VSs0dm14SzJaUUVvOUZrZHRw?=
 =?iso-2022-jp?B?QktrVG91Mk1wMWQ1bkZXdkMrM0REVXFVd2hUYm5SbHY1OUo5T0Q3elNQ?=
 =?iso-2022-jp?B?b0V5SThhQmpVODNBREhTVnRCNUN6Mk1Gd2QwQ3hHVnUyOGd4elNOOE9n?=
 =?iso-2022-jp?B?Qkg4VWtOU3A5SFo0eHBvNlJzazU5NVpxTEFnNTNHYmNVWktVeXlIZW5X?=
 =?iso-2022-jp?B?bFkzZWJFdzh4OTVpbDNsQW1mdXFERURLU3VPUEVKWXp4aTVPZ2xsTmdZ?=
 =?iso-2022-jp?B?aTZGcEZHalg2eDFxN3MyYnVzZlVoUTFtS05zR1RLQnlKdXdGa2MwWGVp?=
 =?iso-2022-jp?B?YTdJcVFORDNqWWFtbHFXS2tkdzltbDZUWWo5WWpNRzVSUWR0UTIvekgr?=
 =?iso-2022-jp?B?dm5qTzlnemZ6WnZQMFpwSzlWcllxVmtIKzJOREVRb2xwRmZkT1h6eU9v?=
 =?iso-2022-jp?B?YVJZS0p6a2dCdUUvb2hTdFZCMWtHcDZtVGh3VzlmaEpYMjNHRzhBNEVt?=
 =?iso-2022-jp?B?NmR4anREWm82RjRLUEJGZk5KQTNBL1hYZUFKNU9iMjFoaHhFWUt6MFZL?=
 =?iso-2022-jp?B?d1ZIa25iclU0bUJORmd1TEplNWxwY252NWh2T3dEN1JtdWx3WWlsdXlt?=
 =?iso-2022-jp?B?VENCVlZ2eTI2YzJ1VkllSlpFWVVFMGxqc2NVOWhUdSsveXlQTW9kV3la?=
 =?iso-2022-jp?B?MXBWMEF0SDYvd29zTHFnUC82bXNRay84TUttdi8rdThITFMrUWU3ckMx?=
 =?iso-2022-jp?B?b0VnNWNwaVJjaS9SRG1rOTQzeWg0MTVEclBoM2VsOHkzZnZ3NjdPOS9n?=
 =?iso-2022-jp?B?NHIvdW5WdkVQNDdONTNSS0RibWdsZ0NSSHBIcStvTGYwbjRRa1MvRnJp?=
 =?iso-2022-jp?B?cHpmWFJ1bW1aTVlEeG9hSy80NmRMRDVLR3dTdnZLK0RxbGFiRkFpdmwv?=
 =?iso-2022-jp?B?N1hRMk5qUWx2Tis5d0VUTkgwZ3N5bm01cUxqcldQRWlZK0NjaVI1Titm?=
 =?iso-2022-jp?B?emwvYmlURmtkTnZKb2Vvd053WFlIbWFVdXlMVEhweUUva0N2RkNHV3FI?=
 =?iso-2022-jp?B?TDFLd0k2dGFxdWRZMHpJRVdjd0tUdG5MbWhtdlF2aEpsa1l5dWx3U1c5?=
 =?iso-2022-jp?B?ZzBnUGZpS2s2UXZyNEZYWHRJUWZtQ25wNTZvL0VuSVhQRTNZcWdlYUlD?=
 =?iso-2022-jp?B?VXlEbXljZ1hPREwzKzdRODFYMDRtc3M5?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L2R1VVVIT1pMY3A2SE5TZjJUbUtCZEtZV1pNMHdpekhQQXcrd0Jjclcv?=
 =?iso-2022-jp?B?Y2FsbUNmcklSQUVaUzBMNkpEc1hvcTRoVjF1K3hxMGptNWwra2lPejVC?=
 =?iso-2022-jp?B?NEx1NUxDdXJrSTRMRGJ5UTBiYXdlVzRBb01RZXFnUGdUQm0zd2pFZnQ1?=
 =?iso-2022-jp?B?d1JmTThEV1V1b0pwQ1VMaVRwM3dZaEJSdThTcGhLMzJOc3FXYjEyL28z?=
 =?iso-2022-jp?B?Y09zekJ5Rlh5TnFtNEJFdE5lUHV1R1RXdVVESDZlV09ybmJDTkVtN2l1?=
 =?iso-2022-jp?B?RmgxMHJ5elIrTlY1MG02NW1XMlZMbFMrZVY4S1Z6YTRjR1BDMTcwekh2?=
 =?iso-2022-jp?B?S2VMSlFxeEM0VTlSaG9kbjhOT2VHc00wR1NubVFUSmQrcHA0dkFHZmZJ?=
 =?iso-2022-jp?B?SEhDVXNrMXdlQ3BnQk1mYkhiakFrMGVOQ3dxcm5RR2tadWRqU3FoV2ds?=
 =?iso-2022-jp?B?RkIvWUVUcHhxOWpZckxHQXZHcldaSlRNVDl5Vm1zblhuRmpMK2luNGxE?=
 =?iso-2022-jp?B?YjRlZG81cmpxSXF6NW1CdzNBTm9JZjIzY3IyK0ZVcVFVR2o5WVdoUUhs?=
 =?iso-2022-jp?B?Vm85djJmWFRGaHltd25qMGU2MXRMNk51YkFSM1hEMUZCVW5iVEhjaW10?=
 =?iso-2022-jp?B?RUNXWFRPTkhoSExhOGNyZFZObEFxZ0N3QndjektRSWJVWE0xYW11QWhQ?=
 =?iso-2022-jp?B?c3pRakM0cXYyNTNKWFVvVGxxZnFVTnRFOExIaEVDd01yc3RIcThwd3F3?=
 =?iso-2022-jp?B?NDA4cStVM3h0VGtWa09obUJCYWJZci84VWJTWEZOZUpWcWFIT2JLcUVJ?=
 =?iso-2022-jp?B?Ykxud203bnppNzcvV0VhUmJEcUY4M0p2MUdMeGl2QXJ5dzd3NkN6VHR1?=
 =?iso-2022-jp?B?UEszUDZyS0xReXdOOUFublhMd1d4Y08vVkQwVlo1dDNxeTVwWmNqNVNG?=
 =?iso-2022-jp?B?eFlERkhUeVI4c2FuVWEzSEp0aHdQYnkvWit5alVPRVliQVJheDJWN3hQ?=
 =?iso-2022-jp?B?bUlzS1hYd2tKTVhkZ09uNk02Z2ZJL2hCRFcyN0ZLQ2lJdlVZWXJSdUMx?=
 =?iso-2022-jp?B?MFNYQTJra01KY1ZuSmVadEtPODhUbEpNNmJPNy9KZDBMR0FVQkNaT1Yr?=
 =?iso-2022-jp?B?ZGNSUmRWT2xyNWpuSnJiaE1ybXAxbDRMRE5lVHUzVlRHbmt6WlFza05a?=
 =?iso-2022-jp?B?Vko5bXRtVlUxaGd1UmhuVnAyRnFpclNjODF6aytXc0hJRmFSRTVCb0VX?=
 =?iso-2022-jp?B?a1hRTkJucnVCSFc5c3FMNVBMVkE2YnZWR29QZmJ2aGZxaTFib0NVQk9q?=
 =?iso-2022-jp?B?a2tCTFh4WVNYWTNPSnp1LzQwYk5jWFlER1RGSWRKUkJzUWw0YUFuRTQ3?=
 =?iso-2022-jp?B?anpaa253NWxEZ1czN0NxQUZPSVYvWStOUlZ3M2VodUhjRTUrZnpIVFBa?=
 =?iso-2022-jp?B?WEhRQzJqVHlEVG1GYXp3TFVJellWcWJPTlF1eHZETnpVbkVUeVZMQTg4?=
 =?iso-2022-jp?B?NHF6TklENHFla0dGQThNaHE5RUcxRHB5Q2lISE4zSnhUTnh3V2lVaUts?=
 =?iso-2022-jp?B?bCtYSUpwdExWYkxpOFpEcXJrLzZvcjZKZDJGVHJjeGhrdlVubFU3M3Mr?=
 =?iso-2022-jp?B?Njl1ZW40UmQ1eW1TTWphV1JYQUJPckVMRC84SFBvMmNpZlJvd1VYd0I3?=
 =?iso-2022-jp?B?RUhXdVEwRi9qN2ovWHZaWDErSmc2MmtBRkYwckFCQzdSZ0F0N2F4cW9K?=
 =?iso-2022-jp?B?bmlXM2ZyaHdHMnFJRWs2SGVsU0ZDeFczOEJSblBhUXpLYkFGZWlzTHlW?=
 =?iso-2022-jp?B?eXptdmhJbW5XWGFhUG9yeXY3N1grWkxzVTA2UHE0dm5lY3kwOUZGa3Mr?=
 =?iso-2022-jp?B?bUJoVVZsK0J4VzJBWmNQYml4RVkxdCtYM3JrcEVOMG5GRkJpbmYralhY?=
 =?iso-2022-jp?B?YjFKRjE1WEZtb0FYUERucUxvdFE5c0RNcHlWbFFZQ3lyNzU1WENZTVF5?=
 =?iso-2022-jp?B?TTFFZVc1NGJiSzY5OWdEdlZVeWFNRzlmVURYTjNEd2pRNWFydkRUeVdi?=
 =?iso-2022-jp?B?MFZ6SkIyM005bk8yQXUzUFdwckFFdVdieUhQNmQxTmcxZktWYUJwQ2h4?=
 =?iso-2022-jp?B?Vk1YSnZpd2dmbUl4QVRJcmFocUNVVEw0amVtdEpBcDVtREVrYy9lU0l0?=
 =?iso-2022-jp?B?WWNSeE9jcXhCOXBqMVJUTlZrUnJHcVlGWkNJRmtSZVJ4Q2FqZWxQV2Fy?=
 =?iso-2022-jp?B?V0thd0FUZ1hBTUZLTzhQUVh5SHdONVhuWVRzam9CMnRTSEtPSHRMNnB1?=
 =?iso-2022-jp?B?dzBOTnJaeVlORmhnQmVRdGdzbHJveVBaSHVVYjBnM1R2cW1yVnRaNmh4?=
 =?iso-2022-jp?B?bzdJVXg3Q3E2bjhjY3FkV3RQQnpyTUJhU2liYk5temFtY25Ydm1Sc01O?=
 =?iso-2022-jp?B?R0FqdTFnWEdSR3JrNmRmZW1WdDVZa3ZTWlc5K2Z6L3haQ3pKSlNQZzJI?=
 =?iso-2022-jp?B?bnJ6ckw0YzcxNUNHOHc2azlHcWJrUE9ZcGVZSlJZT1FDSWV1Yjlqdmdu?=
 =?iso-2022-jp?B?b2EwZkQxMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e49e77-a6c8-4359-80b0-08de4dc61520
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 08:23:48.6450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9rfrCM1pEIAUvDD4hJUTWCvDYgFq9MKERC3nwp4xKHNZrvrSJwUZhIne29qpb32RWj/Hs7wrQwGlB2oBxoscL5hrgkj+u5v3EEAG262yaWDuHlKkTvQ8yV8aWSV2p6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8377
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 08:24:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21399

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, December 29, 2025 5:41 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
>=20
> Hi,
>=20
> The following EEE-related issues were observed on the Renesas RZ/V2H and
> RZ/V2N platforms with 6.12-cip:
>=20
> 1. EEE is enabled despite ethtool reporting it as disabled
>=20
>    When running `ethtool --show-eee end0` after boot, ethtool shows EEE a=
s
>    disabled but LPI interrupts are increasing, indicating EEE is
>    actually active.
>=20
> 2. LPI interrupt storms and VLAN register access timeouts
>=20
>    Both issues are caused by the RX clock stop feature being enabled by
>    default. When EEE is active and the link is idle, the PHY stops the
>    RX clock to save power. However, the stmmac hardware requires the RX
>    clock to be running when accessing certain registers.
>=20
>    More specifically, VLAN operations fail with:
>=20
>        # ip link add link end1 name end1.5 type vlan id 5
>        15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>        RTNETLINK answers: Device or resource busy
>=20
>    Also, LPI interrupt storms occur because the RX clock may be stopped w=
hen
>    the driver attempts to clear the pending interrupt. The interrupt is
>    not cleared and keeps re-triggering until the RX clock resumes.
>=20
>    A comprehensive overview of RX clock related issues in stmmac can be
>    found in these threads:
>=20
> https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideas=
on
> board.com/
>    https://lore.kernel.org/all/Z9ySeo61VYTClIJJ@shell.armlinux.org.uk/
>=20
> These issues are already fixed in mainline. This series backports the rel=
evant
> stmmac EEE fixes to 6.12-cip.
>=20
> Best regards,
> Ovidiu
>=20
>=20
> Ovidiu Panait (2):
>   net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
>   net: stmmac: Disable EEE RX clock stop when VLAN is enabled
>=20
> Russell King (Oracle) (6):
>   net: phy: add configuration of rx clock stop mode
>   net: stmmac: move tx_lpi_timer tracking to phylib
>   net: stmmac: make EEE depend on phy->enable_tx_lpi
>   net: stmmac: remove redundant code from ethtool EEE ops
>   net: stmmac: remove priv->tx_lpi_enabled
>   net: stmmac: convert to use phy_eee_rx_clock_stop()
>=20
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  3 +-
> drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3
> --  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 23
> +-----------  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37
> +++++++++++++------
>  drivers/net/phy/phy.c                         | 27 +++++++++++---
>  include/linux/phy.h                           |  1 +
>  6 files changed, 52 insertions(+), 42 deletions(-)
>=20
> --
> 2.51.0

Looks OK to me.
I can apply this if testing is no issue and there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


