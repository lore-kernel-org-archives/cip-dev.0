Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3351EEFB7E8
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 02:23:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11683.1771899796237468820
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 18:23:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=Xsl6YibK;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1771899793;x=1773109393;bh=+xcJjcQ2Y7DUlaUl5aQTFhespHi1JvnF4wOff
	nosius=;b=Xsl6YibKtxTeB/an+/LeW1ZOQJws6M2OOwKg8KQmRqKz0/t7iJs7iuwfDuAhA0qFq1q
	NnmbH9CmQxgAYB9pAJ2u22aJqTPB1qCyx6H5a+J8KQCtBgneVKrzHZfDCcqQrFyhwHcn05Ftv/MBJ
	7aGpoSeqPXSJwz0YIv7xg/OI9IPP46pgpljvK0OtJVjriSHcPlhaGGfYCMQftfbZvEf2rxNP+TQGx
	lEaSiTZ4fTwkVSqzkWGzzGGQaW0VCSS/eONYzMcIGnk9O/1p1MB0ojD8aJQM3QusrZWeDBwu0dfz+
	ml3tQeUus9ulB1UKgTX0F1Rn3HlmAd/YiVBuVZlCam/w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 61O2NDFp2752316; Tue, 24 Feb 2026 11:23:13 +0900
X-Iguazu-Qid: 2yAbM59muQhqNFbB5s
X-Iguazu-QSIG: v=2; s=0; t=1771899793; q=2yAbM59muQhqNFbB5s; m=lKkzs2ysL8kHUvK5vFd2QZ85/tft4MPQDm0b8qA25bk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fKhN063t4z1xnc; Tue, 24 Feb 2026 11:23:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuduvV4ToNBywDb/xkOSWISJkSQm4dHH0DHsXLDkb6UmSLhzOs4bcHOvaBq13ym22P0hPf+VEorIGn0eZszhLZ7DOvnjO2AqfX63pep62Zxj54kIvWxx8pzqJ+v/+hlWLBJP3ta1PVHelpw67nbaL+Tfaf0RQYo4A2/M5rA3APKXgJySG5u2lgYuTA4BZcxWBvW31ERm4OpdIe4Phs+0BGpj+Cxn6IEredLUMUpFktEQ9/6sdiw9friFbovgVMx3daZCzbVFsj9JX6NktOLFiCJ24HUBRWgRHZw+hyz2wg3oL3tiNZh6WxrTjKQpRHTDTRg7r+j1pvQBAEP2ToTSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioJ3EKQ3KhhcXvCcOPDu0H5lw9ErPYUsFbHD6hlnKCs=;
 b=KDAQ0tQgXsOdphQTW/9nX93AkOpob5JnYwVDDHSrijSmnfyTljCOqf2o2+rv4pcAZqac/5HTfGTTgjRFkQrVU24Vq5e9lGzHeQ80uLWtmyl2G+Y3ZeFjO5xuyEbQwMSrqwyVqCUe5RuKDNOG209Ui9hrmEHSsbPNc9ZqIH0xVf7zVuTS2OWb72ZsMFGSFRtdBfGOYAbsJxH7yYvEaT5XrU88dNGnpwZT7eic+ikD3gDJgotzGRuyNPhu9fivZTrGj1Ir/WAOxMKXUIJ3nVOxCIXBuUbV26t5yM+RuC3hf0Tc2Wk3usQFEC63ncRJA6cM4s0ghQQ64ZK3ZJaPlwFfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N GPU support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N GPU support
Thread-Index: AQHcpK8cfrp+n8ocjEi364lAeLQNJ7WQO9qAgADjVtA=
Date: Tue, 24 Feb 2026 02:23:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818382A043FDE6C717FFAF1CD74A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
 <aZxMc0vctvgxRG3r@duo.ucw.cz>
In-Reply-To: <aZxMc0vctvgxRG3r@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB16001:EE_
x-ms-office365-filtering-correlation-id: 9a0f4ea7-1ea6-4a15-3861-08de734ba618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|14052099004|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UGJlMVNSMFhQdlhXRCtSWFhGYk5PZXdSYVh1U1ZxamdoajhIYWN6SUtR?=
 =?iso-2022-jp?B?MTdiQkF5d0d3R2ZuaW9Ja0ovVUxzOVRjWEdhbnNvSldtejl0UXBjSklq?=
 =?iso-2022-jp?B?N1FmZE52SVQzN1Uvb1ZOeG1ZQS9NUFBEbktodHo1WmtvaU9LME1jTmJ0?=
 =?iso-2022-jp?B?MDRpdUhTMm5XZWZSbnBEdU0xaXA2TTFjWXB1T3NSVEV5WHFvazd5T3hE?=
 =?iso-2022-jp?B?Z3lEcDRDenZIcUJYZVFWSURTS2ZJbk1tdUFrb01NQjdqanZCaHErM2xI?=
 =?iso-2022-jp?B?Nnc2TWE1UnZYMDY3ZEhvQWNTYjlreUJ4SlFNTHAxNitxWGVRNzRzdXlH?=
 =?iso-2022-jp?B?eHdLUVhDSnJJN0J0M1pWeFY2cVpOKy9PdkdncU9zd0tmYTNKZ1MrVThK?=
 =?iso-2022-jp?B?RkRnRWx3QVg2OWxDZG1QYzJHVnZsZWtoSkNka0l4aFFpQUNrbGZxcFB4?=
 =?iso-2022-jp?B?ZG5xRk1PZFk4OFl2cjdwWFZFOU5LakVPWVhwdUpwVERjUWpGVDJrVzJy?=
 =?iso-2022-jp?B?dlFxZ3A4c1ZreDQvRTBJbjhHYXNicmpFb0dENXJlUUZPbUdsR1V0dlRL?=
 =?iso-2022-jp?B?aEZhZmJxKzhESkxneExmYTNSdHhhQTJVWGtkbWc0NTlORnNtb21VeHda?=
 =?iso-2022-jp?B?RGNrQm8rS0hQNFVkdEc3TE5qWjhrVFRKNm1XQXgyTEdKZnlweXFuRUlr?=
 =?iso-2022-jp?B?SHNxSVhVekh5Mk9LZ2lJcG01L1M0ZWJmM2V0bnRPWWI1SGQrWThpZDEz?=
 =?iso-2022-jp?B?R0IvL2ZaRnoyZFdibFFINzJhL1EyclZqbVI5cjRZQVBJUEMvR1gwM1Rj?=
 =?iso-2022-jp?B?ZjB6YUxKWkdkYklUZGhVQlM2Y1UvRm91eTNlV2xEUk1SZkZkWWhoUzRh?=
 =?iso-2022-jp?B?aHRTbmtWWWpWNUx2OGhrbDRCQlNHQ0RZb3dDRHRwQXd5a3czTCtWMmV4?=
 =?iso-2022-jp?B?Y2pXaWtNaTFkakdqZ2RrR1NkUEp6SWh4SjRCaTlaQVpzZEZJeUFiN2Er?=
 =?iso-2022-jp?B?NVFjdHdqV0lmTW03V3NkMy9iY1RJei9oS0dEYUtMcUdvL01kaU1NQVFj?=
 =?iso-2022-jp?B?aE0wanVIUWVYclpQZXJkRDdIMnZnYmRMcUZJMnB4aXA5SWNWWmtDMjRG?=
 =?iso-2022-jp?B?UnltTzlWKzNwNTZlRWEwWkk3OEVhejk2cElRdmlzZUVJcTBPaHRzT2hJ?=
 =?iso-2022-jp?B?ODQ3dmd0UGlUbm4xVkNpc0FvRm45WCtpM1pHTi8wMGNjTHAwLzFUa2tB?=
 =?iso-2022-jp?B?Q1VudzlKeDdxaGlPZHdXcW9QakdiNTV3anNlN3Y0NDRpeWo1MVV4QnpR?=
 =?iso-2022-jp?B?VHZjU0tKZ3o4MHNlSXBzSXNiMld0WExVMEZjVXlNQWhpMjNOV3lPOG5Z?=
 =?iso-2022-jp?B?c3dBU2J3bFIzcXhZTWJJU3pSeUYxalJFMUVQdENzWE8xSEM2ZnpCbTZR?=
 =?iso-2022-jp?B?cC83UEY4U3FsZkpBcXZKVlI0Q29FbWltaG9RbDNxMU15VzdyYW43cjF5?=
 =?iso-2022-jp?B?UWxieDZucWxLTnBaT1hkNUpzWVQ1cE5sN0N4ZSs1MDN0aVk1ekJ4WlBI?=
 =?iso-2022-jp?B?Y0NYWjdQTUE4dE03VnIvMkpoaFAzSit6Sm9mVVNqRVU5dDNMZ1BDN3NN?=
 =?iso-2022-jp?B?OW11RDV0bEVXY0kwV21mYWU4TWNlQlRrUU9qVDI1b0hwVEFmd0czemtG?=
 =?iso-2022-jp?B?bTJOOE9kWE5WTm5Zamh4MHQ5cHF5cE1jY2ZuVVFHVlZ5SGhBQjRqQlJt?=
 =?iso-2022-jp?B?ZmUrMzZObjNOUU9DOEVQSFBKYzJXeTVHUmxIbVRaWUx3dTNRV3kwVjBX?=
 =?iso-2022-jp?B?cEJXUXJFcHhIaEllcjEwNUx4b2ZsdVVUZk1zNi90aHBNSE1oamdPcEtR?=
 =?iso-2022-jp?B?OFVQcmNldXFyUDlUZGVGaGluejd4ZytyNWg5RU1kMDBmS1Y1UzFOR3dh?=
 =?iso-2022-jp?B?cTJKNHVjNHhLek16aHYrL041bW42WCtlaDNaZkc3UUNvVndHUjUrMWRJ?=
 =?iso-2022-jp?B?TDU4T3RkNFo5cHJwUlVOYkt3bHFmYWdqNjVzc2VuN2I1QnZVQVZhSVdL?=
 =?iso-2022-jp?B?c21yN1ZwbzBIaDF6LzRVcFNsMHdqYS9zR1J3RCt4VHFiZVNHYkJCcGNq?=
 =?iso-2022-jp?B?b3hXc2EzbG02dGdVR2RuYXBSQ1c1ZlcvSzdocVdpdG92dWpqWDR4alVi?=
 =?iso-2022-jp?B?Qnc2UE9aSkxEcmZJWlc3U3R2aHdlbk1WY2FCYTk5VVlxbXU5TS9FZXda?=
 =?iso-2022-jp?B?cGZ0bGRUeDFTZmdOUjlBVElEN1d1L01MTVY5UXA5OFpoVmV1cnR1YjJ0?=
 =?iso-2022-jp?B?SmJzZytLK0laWm9EVVJYU0Y1SWd5VjFWM21iSTFIS0xTc29ra3ZjR2Y2?=
 =?iso-2022-jp?B?SUdpTWM9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(14052099004)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bjRkU0o3TlZaRG9OeGxTWERoQVlmemtnOS9JYlNwZWZSSXBHdEREZGd5?=
 =?iso-2022-jp?B?TTlucm1mOEM0Zkl1aXdrZXp1SDhwMGVOQXovWld0Q1FIeFlzSmtzRlFk?=
 =?iso-2022-jp?B?ZndCVnFLNktsVmVHaC9SV2NDU3czUHBtalhzdCtheDNlT0NwYmV2bmRi?=
 =?iso-2022-jp?B?RC9GUnFYMVRjVUJkNTQvSGZxK01qdlEyZUNXVnZDZDRrMkc2blRYajFY?=
 =?iso-2022-jp?B?QlVEZGplWm5JK3BlV2NObEltWElKQWZlbEx3SlFTTVk1c3ltSDNjNU1D?=
 =?iso-2022-jp?B?cWpmaWl1ZU9GZ3FFeGlFRHNYZjhtaHJPRkM0MHJ1bjBDSnowS2pKamRO?=
 =?iso-2022-jp?B?MUlSZFNHZXdmbDZCM3ZmL2xzWkhEZGZETE1yMm1RYVhiV3RQaExSbVpw?=
 =?iso-2022-jp?B?Nm5tcjlRZ3hld3k3aWZCS1hkVzUvdHI5YnFSek9FbEVSLzVkTUlHVlRr?=
 =?iso-2022-jp?B?c2syOWtNbzl1cHQxVUFoaHkyMDdyM0hSM0lZclR5UGlNUklYUGl6QUt0?=
 =?iso-2022-jp?B?Unk3RXpyNE8xYzZxQ0tGNGtQclBGS3Roc3R1bVpMS0VKYlBsczRhSUVl?=
 =?iso-2022-jp?B?Y3M4U205a2hOL0F0VHVRbm9ZTllJTTJ1VmZkQmdwVlRWdHgxVEVvbHFz?=
 =?iso-2022-jp?B?M0pITi9yNWxQaUZXdFlHTzJFdGpnQnJBOW1qcmJ4eENoVkphK2tBamRS?=
 =?iso-2022-jp?B?ZFM4a3d3UkttNU1IQlFDMHI4a3BvSnRiNUxBQW04bEZZdlRRajNXZVl0?=
 =?iso-2022-jp?B?UE5IQklNSlJPUnkvTXhxRlVtOXkvNCs5ZFFaZ09TQ0hWZ0hLeUhDWEU4?=
 =?iso-2022-jp?B?Sjd6OGdzUGVMYmhhZ2tnRlo3dkhKOWxQQW1RRFJSQTJDRTJ4V1FPYXhn?=
 =?iso-2022-jp?B?VjFOMHpMSktpWnVhSThWdTZlcFJGRzlCTFJVandTR0F3QzM5aDFKSDI1?=
 =?iso-2022-jp?B?enF2YmVpMkZXNnBmQ2lmbjFxRVFVdjJSNnFCaEs1TmpIV1BwRmtDSmVs?=
 =?iso-2022-jp?B?RTlja0dFWjRob0JwM0p2czZ3dXU0bCt5MVVxc2t3Wmt3YUNUZFZJWEJM?=
 =?iso-2022-jp?B?anJjZ281SUFNZ0tFMFQ2bEFCWHppVkVWWTY0SkFjUWhFY2RMVG9TZk1U?=
 =?iso-2022-jp?B?cTdOYjFHdmtSMnVBYjBMaW81aUI3UFlTa3pSdEcyK3cxUUNnL1E3amVO?=
 =?iso-2022-jp?B?QWY1ZzRNS0JmQ2tsM1c5dmRWbkRnMm9QRHpaT1lsaUhCY1BZdVF3U0cw?=
 =?iso-2022-jp?B?Y1prWlhGSGRRWUVEMndYTHRuQlNoYkc2VCsyRmxiUWJjVWliR2JYUEhm?=
 =?iso-2022-jp?B?YmdLV3FCcFF4cFZvRk52aDlURG9FZm15dGRqV2RBWVJQT0k2b3ZvbTdm?=
 =?iso-2022-jp?B?RXdVcXdlT1g1Rk5XT2RpSDBvbU54S2VvRUkyaWFMOEUxTndTSDdRbUFm?=
 =?iso-2022-jp?B?eXNMMjlBOEF6NG5FRXhUR3MrY0NCbFVORytEeVN5WmZ2QkFlTXByTjJG?=
 =?iso-2022-jp?B?U0xKZ1ZvYnN2RStSVGttWmF2aDZaVmplK2JGQVQwL3hDQXFHS3FZbWM1?=
 =?iso-2022-jp?B?dUdXcFg0b1BCRzZITllWQ3pRWXA2VVJVQ0VteU9vU3UrdzhUMSt2WW1y?=
 =?iso-2022-jp?B?RS9aMExRWFdOMDdkNTIrV3Z3dGZLblZiTjhEUWpmejlQNzlTZHY3ZHhX?=
 =?iso-2022-jp?B?M2Y1UnIxa1VYMjVKRWIwcGQwVXN2by9JaUxsTWZxUnRpVEhYdmpRYUdS?=
 =?iso-2022-jp?B?ejI2SlN0WnE3OC9xeTdvd240UGlKSEVHV2FpSVBvK1dSaXFtUmVDYWdX?=
 =?iso-2022-jp?B?UzZyRDFEbk9sQk1NQWRXNGxNQWJNVUdDMjB1aG42YmV2NFljZVRIRjlD?=
 =?iso-2022-jp?B?Z1V3VXNpcWlJN29NV1I4VFllNFptSE9hdG14b3JsSEMxZUNjUGxUMFpK?=
 =?iso-2022-jp?B?VEpFeE02VmFyallMTlA0bFlOZXhvMDVLVmx1MkIyZTdNSlcrT1VlWXht?=
 =?iso-2022-jp?B?L3pEVVhWZEtmRXh2TDJYREowN25vTnYrRGh6V0t3WWJNY2tuTXRsTFFQ?=
 =?iso-2022-jp?B?bmtsdkV3cDhsQUpzd0kvV2ZidUNGQXBiLytHM2F5SXdNVVgzU2orTWdR?=
 =?iso-2022-jp?B?UTRBdm43N3FnZE5kS1RsVmtIRENSWVhJK3F5TlVJLzM4UTZsQmVDN3ha?=
 =?iso-2022-jp?B?RVVOVHZCdFFld2J5RVRCeU5zZnpkYzFySTZxTURaR2d0RUY5VzhwUFZL?=
 =?iso-2022-jp?B?SWZ1ZnpGa3hObFd3bG1rK2tCQ0RYV21nSWtOb3d0VXltdjQyMVB0OVJp?=
 =?iso-2022-jp?B?TGhZdjkxckhaSnZHeW9VL25EeHQ2REhid21mWnpkblQ5bHplejFGNGhS?=
 =?iso-2022-jp?B?eW81SjYrL1E4c3g1bFZWTEM0T3ZtS3NMVjNjak9ua0Q1NmplS2RRYzFF?=
 =?iso-2022-jp?B?NDZBUDVnYzRaQmV6Z09QLzM2SzlzTitGeTIzUGhiaDYydDVvZmh5K2F2?=
 =?iso-2022-jp?B?aW5YdWplZGdJL0dYWFhnTnptZnZpM1l4OXFqbXVFTHgyS1drd25aZ2Y5?=
 =?iso-2022-jp?B?dDdwcUhxYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0f4ea7-1ea6-4a15-3861-08de734ba618
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 02:23:07.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVGnr6Kd2A5gzScKTNpd3M95Z3mWupKM63BUhAkOjPbULxGf3dgdR2O7ZOniqhoc9tLLB+z9xmFoaEowPP5caFGVYjndW2/ZrjQt031SviPTnd8bslvE0Ph/G8K6HMyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 02:23:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21919

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, February 23, 2026 9:48 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N GPU support
>=20
> Hi!
>=20
> > This series adds GPU (Mali-G31) support for the Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I will apply and push with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


