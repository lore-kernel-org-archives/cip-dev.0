Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C029DC83F1A
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 02:25:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.5475.1752546290654350324
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 19:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=IBY/FtdQ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752546281;x=1753755881;bh=5y/8XWl0qYpYa3GtGf0mPw2aNr9RQiUllY3fbbb
	czpA=;b=IBY/FtdQCbX7CH2ouV6CJbfv4xpNiowoEDA5t46jx1QBpECdZs1C7uLNPBXYzBr4XZadd
	qvk8x78a8de3J78fII5iD2Xd8RwC9HTEP4N4esapJq3W9M1kOxH36S7UA5+3Ad4+ZX3w95W4D6sRx
	KHZLMyMPe9MRGvG/rKMf7KSXpOQSlZaTpPLBY71A+Dg7wixn6Dg9eEYn0rtkXaZ8xuYViIO87VXev
	S3nr0e92tknywNaYLlIqMNYdlyvWzCudxy7/vrq2jRUOwFH05ItfA4Z4uW5kEIdWdD2GnJP8iyBZK
	qHpzFvdGUVOZIq22NUH/nXkft17gWIxRZcCrMDbWJg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56F2OfgG1614300; Tue, 15 Jul 2025 11:24:41 +0900
X-Iguazu-Qid: 2yAbG2MEIy8e71zAlo
X-Iguazu-QSIG: v=2; s=0; t=1752546280; q=2yAbG2MEIy8e71zAlo; m=Z/y7ZDZGEmyBI0H1hNRod0zrV+ZmEjpOzQkmJMeRSdU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 56F2OdaX1516061
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 11:24:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUrgCKa0OcxNBJTbvcZ9HVhKRXLFV4FscLZCwxozOSe2B/CXWSqdyoprakhQIc7uvOcL94GtEubB6VVeTnc9LYmPgWU7uKjMxy3yb3yepLE9MhtMDYK8l+Jqy9WxW6cSO+w/TfjXT7jpwapU0xOKW/k0Ac1+IF2rgTgC/K1K4mQyleg0aLsB/0XF8tBhFopcKj8h11zgQbNb/TzKHnpHVM1VdL4SNmnItT1p5e+zyLgg+jaz5CQTe+iILT2kJwIJ1Fv3pvjbZxlnHK0r7qG0sxXZLYC944C6WEGWQDvsM4CvKMTUZckzH6JTzpsMCJL1v1Y4bgXKdfLWHZu8jduzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhvQRx56dvFlI0vv/bOpfEBM+c8OJFYGKtxxiPKe1Ec=;
 b=sxdD4vmkYfZ2ZVM1nrETEL7tergtMwk85ALS+rbmvUeq3ODmHPttPgaxu0lprNCxxvcIXIw7VftNuNOkjOM2Osk/lddE0ztav59AXzHfwyGB+WjiIoqVA+Le/zomzwddZYN2ihEX+rTrpBIui2zVPIBcozgrwbyMb8wzaWDiCnb44MvHF8YhLVTezR1JY7et55hqAAjMgAKhziD1a4gVe7+I1MIWUlZGTgaycufD2BS+X9QqyULfP4WNr1DwSeZU4opdfgyaZXIfMXAZONCGj1hYRuSqowq3u3S2Zd3qjCOT1KmtM5afwAP8MVA0/wO1qOdTRGZJv155m29GPqigjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
Thread-Topic: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
Thread-Index: AQHb9KhypX9bXwERBEGCfhum8wnFDrQyZyMA
Date: Tue, 15 Jul 2025 02:24:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185D54E4F592CCD62938D79257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB12781:EE_
x-ms-office365-filtering-correlation-id: 9157d65f-6fe6-4f95-c1c0-08ddc346bf3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VFZYMEJOaXQ4eHpWcHpCZ0lDeHdHUXg0aVJSRXZSWDJZWC9CZHVWRGpm?=
 =?iso-2022-jp?B?QlJSWUpDSE5uTms0OTUvKy9ZZ291TW9HTVdTd3pTQ1lVcTBSczFLdFh4?=
 =?iso-2022-jp?B?OXVYTmxNODZDT2VQeEozUHkxeWpnNWhpTzRNck0vK2owL0g5cXAvOGFu?=
 =?iso-2022-jp?B?ZjN5TGJuNDdreUlWK21ZMUZTWXlUQ1kyVnlIUjR1Z1BKaURDN3BPeVpF?=
 =?iso-2022-jp?B?c3k0cEhtWktGSDdKbVhKMkVOWWVjLy9WaWVFY3RueW9CYkgwNHlIcFVB?=
 =?iso-2022-jp?B?ODd0NkR3dGoxRG4ya28rYUV6NUxSeis1WUd4Uzh4Y085NWhqUFc1VlVo?=
 =?iso-2022-jp?B?VTBXa0lyeUc5ZmNtYnJRLzVzMjBINWZ0RDBDd0lWVzFId2R3RkJPZW9B?=
 =?iso-2022-jp?B?S2VZVkNVRWRuYlZ4VWJXTGtiQzJWeXJvSENiOVczZ1g3UWh5UlRXRGJp?=
 =?iso-2022-jp?B?cFNLbFVFYWNKS1ZQTVZ1dkVDNytaLzA0d3YzbWpJWDYvUUZxTFFIbTBk?=
 =?iso-2022-jp?B?Y25yRDRVV2xidTArQTNIUFBrY0QrMkJONVhRVmZjZkVxUWJScElZd0xh?=
 =?iso-2022-jp?B?VjZMRERFbnlIZ2diSWR1Nk9TQ1dWd3FHQWl2UlVIWjRGc29HSTNWY1E1?=
 =?iso-2022-jp?B?NVVCazBNWFNqcGZsTytSRGpUeEtBQzZCdHhQV05VbE1LbUN4L21qc0pI?=
 =?iso-2022-jp?B?TGpaL0F1OFJIOUJuWXhXN2JUVEVneFdHZTA5cHFqWGhLZGRYSHM3MEpV?=
 =?iso-2022-jp?B?V3VQTXBiNmhPVmNFTkRUWUJpTEkzY2d0eEN2Rm0vTW11S0QrWmFLaCtB?=
 =?iso-2022-jp?B?d24vWmVRY2ZpSUdtd3NGUWVmZUZDUFBrVmNUQ2hIR0piamR3WElGSG1S?=
 =?iso-2022-jp?B?SE9kbjVaLzEyMXpIc2s5amExMFV6Zk5ocTdkU3ZDdDVpT0VVYmt1SGZj?=
 =?iso-2022-jp?B?eEw1S1h0U1lwemkyQVFkRm11VStBd2xjOThlc3BWcnQ1K04xQ0UxQVJm?=
 =?iso-2022-jp?B?MkZoU1pJRjVCb2lneFpPcjFhbVBTNWI4TmNBVVhibndiWVlsYjF0Z1lr?=
 =?iso-2022-jp?B?ekFjVlZBMkx1TmpqeHhWMlovMWJFRXV4aG5sdWgwRnNneEx3Z1Vpd3FE?=
 =?iso-2022-jp?B?MENDdVBvWE1Hd3JETk1XRmlWb2FhU2xrenovbEhYYXhYV2I1dGpNa2hZ?=
 =?iso-2022-jp?B?YzY4Z21BZU15bTI4ek9yR3JSU3RHZGRGWGJiNG1hUVNLRWRxT0xnekdC?=
 =?iso-2022-jp?B?NytCUHIrR3NxTUxJMGRPdDB1NElGMVZSdkNWekxDMFZaRjg5YzJVVTFm?=
 =?iso-2022-jp?B?enN3MTF6VjBoWHpyanZQbiswTWhFSEl0VEhRRENRMW1PcFJ0d2o4SFIv?=
 =?iso-2022-jp?B?NDhzZVpGK1RSMmxDSzRqdldxbFZKbzNRamtCL1hQOUlCYmtBRlloejBx?=
 =?iso-2022-jp?B?cEZYNFE2YzhGcVI0Rzk0Q2FzVVNoR1VBbHBZbXo4U2N2WHc0TkFLMFh1?=
 =?iso-2022-jp?B?NGJnOFhIWFFIcTFpQ0VKejFjUmFkT1Zpcm5ubEsvQ0lFNXNuaWRzeHd2?=
 =?iso-2022-jp?B?emNZYnUwVHlySS8rNEV1cnBrZk5mV3o5dHZ6bE1hRFdyVUpvaDdZdXpr?=
 =?iso-2022-jp?B?M3IwdUFLNG5hWVhYdGVhMFQxbk1tT0hSeG5ITGZ1YzRBcXJTQmJJUnNG?=
 =?iso-2022-jp?B?d044VFVRNmpsOEJidVZZeXpCc05xNHFpeDBDZFU1dmNWbURJdkZKTnJC?=
 =?iso-2022-jp?B?SVBZWDFjelFNdUJQM3dLeFhmQ3N2R2NscjZlWEV0RHB4VmloLzV6cHRt?=
 =?iso-2022-jp?B?Vy9oNnhRSmZJazBIbHdXc1BCRzdLUUpqTmc2K21jQmxSTHhlS25JZ3BE?=
 =?iso-2022-jp?B?VktZOWNuOHdPczNFQnJRcG1mY2Y2dzFhOGJ0UC82YXMwUGdmNXYvbjRM?=
 =?iso-2022-jp?B?am1JWVF1QTlFcitmak00b0VVcE9lbm5zaFFnZFJ4Rjh1d21CRStxa3pN?=
 =?iso-2022-jp?B?aHJUZjRyTjEyYVFlQ1FKclErVHNtWHJ5bFdWd2VwczNWVkNiQWM4d3pu?=
 =?iso-2022-jp?B?bXdmMzFzZTdKTE5nVjY3clNYUjJuUEFSajNDTzBSMUNUbkY3Z1c3SVVD?=
 =?iso-2022-jp?B?L1IxaVR6N1VObTZnTzZURTFZaGcvUjJQYkFnQnRjZ1FnUFdCQzBid3Nl?=
 =?iso-2022-jp?B?ekE4PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eG4yZ3BsRlM2RTdEWjlzT1BhMUF2eTlnS1BzNTN0cGwrcS9zR0x3dFFt?=
 =?iso-2022-jp?B?a1dGQjV1cVdqLzhDaUIwNEpKcjdFR09LcDAxQ1RZb013OFNQVU52MjYw?=
 =?iso-2022-jp?B?V2JkcHgzSVZQNXlHU0Z2a3lUSzRSR1VKWEwrQ2dETG1jWWFWa1FOY0tN?=
 =?iso-2022-jp?B?M2NHN0p6RnkxckR6MnF0SGNvdlpEZjNoeVNydm9YY29uQklzQlVBSWwy?=
 =?iso-2022-jp?B?V2FucDhqdDgwVlhQNDhpUURwME1DMktkSnZqTGRpZ01GZGgyNkZ0WmZK?=
 =?iso-2022-jp?B?WTZJcHpWbGNJRTNRU0lqYjdPb2RJZXhTcmltTmFxaWhJdXRpRlh2ZDgw?=
 =?iso-2022-jp?B?WjFvK1N5eTd2WW1nL1RQNUVpc0RDYy95dFVnc1VFYXZueUF5dEd4WEQ3?=
 =?iso-2022-jp?B?cGtUblhXR1hod3AzL1NTZ1MrVW1ueUVBYzUzOHU3eHRyL2RraWNRck4r?=
 =?iso-2022-jp?B?R3o3MVNOdmFQcFlHUEhSWDVEQnhjODNXNVNmTmZTOE9FM2JESzV1dm42?=
 =?iso-2022-jp?B?TXJZamIvSVJxSTlqVERoOXFMeFlVcDM3b2tOcDJBOWtwazV4OEFraDlw?=
 =?iso-2022-jp?B?dk85RTZGeEw5QTVPS0FxYzUyd0xFbUZIc01DdjFzeGh0NlBSdURuQlNi?=
 =?iso-2022-jp?B?QmYxZG9nVWR6VU5aa08zRGZtc3hqUG40c2pheC9UQ3hVUDNJQkxCc25U?=
 =?iso-2022-jp?B?dEQwMDBYUHlDSG14bkFET1VjYWlIUnNKczNGakEzWlFPdFNONkFObExp?=
 =?iso-2022-jp?B?UndINGlZejlUMWpSUVY0aEtLZW9qS3dPRnRWREFqSW1SUjZWaGxZTy8w?=
 =?iso-2022-jp?B?TkZCWk9yR2RGaGtudlpud1BZTGtxWjJvcmlWUUZLenJXc0IvakxPSzV4?=
 =?iso-2022-jp?B?djJ4aWhhZXc5emR3Z3pzRGMzeUd2bzVwRUN6a2tVWGlSbjA3cCtIS00v?=
 =?iso-2022-jp?B?VWVXR0xYWjZYK3BSR1dzTWpiSnhuazdNcGw5aXVLNkljNFdLaEVSdlhC?=
 =?iso-2022-jp?B?TEVDWU83UDl1SjJYWTNrK20zLzBwVk9hVmIxMVFyMmNES1RDWUJXaWRQ?=
 =?iso-2022-jp?B?Y05kQm8xdFExZ1JZV3JubE5LK3BydzlvZG9STnVZZXBCY1Urc01Qd3VQ?=
 =?iso-2022-jp?B?aUg5d0dOR2JnbUErWEJERWdBMEhHVnplY3dkNnNSRmJFdUtDTHJaSWpL?=
 =?iso-2022-jp?B?cWxadFZLVkxsbEdTNGowQmNQUjVyWWQxWThkbVdmV2NVVHhmSWlnd1FJ?=
 =?iso-2022-jp?B?QXVjVTRYUFFLaGw5cDkzamc4eGt5Q1BXU0pJcFF0NXlaTmJNUldneUZm?=
 =?iso-2022-jp?B?anJhdTExNkhOSTAwUThKTExhZjZ2RXV0TldGdTM0aURPL0djN2krSVRB?=
 =?iso-2022-jp?B?RFlRRFZ1ZTdySVErUUxBSkdqa0txYlg2VmpLcEtQaWpaMWJ6U3NhUlFt?=
 =?iso-2022-jp?B?MkFLaElyaVJJSlRybE1wZnVvK1RjMzU0bU5zY1BnQmhVdUlkb2orRnhj?=
 =?iso-2022-jp?B?NkFRZFpZQW1iclVoaUhBdGdSU3BJZUs2WVFRTmxpbGhDR2RHaC9EMWZJ?=
 =?iso-2022-jp?B?VEIybGcwUXlFT0x5ek5BMWJOMDdGYThXWlNmSmQxSXF1NXpaalpDUXh3?=
 =?iso-2022-jp?B?eE9OU2lOeHBoWUFpbldaZy9aS3ZIYTBka2VYczBPdUw4b1IzMEpQb1Rx?=
 =?iso-2022-jp?B?VDd1d3gySFJPVERTTTJ3Y3I0MXlxdHlvOU9BdkQwMUsxYkZMOHN3TDRF?=
 =?iso-2022-jp?B?Y0dvZllZQjlVa1FuODhjUXB6N3FPRGlyNW51NURqRThkVzZ0UVFpU1c0?=
 =?iso-2022-jp?B?L2l2cUhtd3NLZkZHZDVtTURZcjRwOG1VbGF6UU9XaFhmWGQ3ZlhqSXU3?=
 =?iso-2022-jp?B?N1AzaHdqUy9FdERaRWdGM3RKVjdQWjBKTFZMcW9Qd2Z4dXpTRE5IYnVj?=
 =?iso-2022-jp?B?WVdEZE1XaFduVjFNbGpIMi9lT2pjU3J1dkxxU1JHZ3NDSFdDcjZtMmgx?=
 =?iso-2022-jp?B?dG40b05SMHZGSnI5VEplRGpNTFlIM25vVnVNbE5QN1FTUjdNeEdmUEhi?=
 =?iso-2022-jp?B?Q01IVkVQUk9KNnc4Z1p6R09GdlRqRjhua3Q3ZnkwUDZLMCtDcC9HalRU?=
 =?iso-2022-jp?B?OG1WYnkybUs4a01xQVl2aGc5NVlyOFpYMHNtYWkzTEdRQkJGWktPKzF5?=
 =?iso-2022-jp?B?a05MbCtXY3dxdTB5dDdOcml6K1BlY05FT3YyeUtKbEFCaFlVMHF1YTYx?=
 =?iso-2022-jp?B?THNOSHMxbDhSUjMyZzZRRVp2YnJmcGpVWllKczRybC9nNUhsR0gwM0Y3?=
 =?iso-2022-jp?B?VXN0ZXh1cUh6Zi91TzBzRUE3OENKd3pRekE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9157d65f-6fe6-4f95-c1c0-08ddc346bf3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:24:38.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+qyrW6VeV6U3nCczcz/sLCT/y0SjsKOLduw7FnjeqbjqlPGJh3WmTgvc1kcpkumhiPfu5+RKmlV77mLma64YbNu2yfYOHQDHwqnNfdcJ8YMvBBzbXdQ7s7jIxfU5en7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12781
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 02:25:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19530

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, July 14, 2025 7:16 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
>=20
> This series adds support for the RZ/G3E CANFD driver into 6.12.y-cip.
> All the patches in the series are cherry-picked from mainline.
>=20
> Biju Das (25):
>   clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m =3D 1
>   clk: renesas: rzv2h: Fix a typo
>   clk: renesas: rzv2h: Support static dividers without RMW
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Use of_get_available_child_by_name()
>   can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>   can: rcar_canfd: Update RCANFD_GERFL_ERR macro
>   can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC
>     macro
>   can: rcar_canfd: Add rcar_canfd_setrnc()
>   can: rcar_canfd: Update RCANFD_GAFLCFG macro
>   can: rcar_canfd: Add rnc_field_width variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add {nom,data}_bittiming variables to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add ch_interface_mode variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shared_can_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add struct rcanfd_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add external_clk variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>   arm64: dts: renesas: r9a09g047: Add CANFD node
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver
>=20
> Lad Prabhakar (9):
>   clk: renesas: rzv2h: Update error message
>   clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
>   clk: renesas: rzv2h: Add support for enabling PLLs
>   clk: renesas: rzv2h: Rename PLL field macros for consistency
>   clk: renesas: rzv2h: Sort compatible list based on SoC part number
>   clk: renesas: rzv2h: Add support for static mux clocks
>   clk: renesas: rzv2h: Add macro for defining static dividers
>   clk: renesas: rzv2h: Use str_on_off() helper in
>     rzv2h_mod_clock_endisable()
>   clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state
>     validation
>=20
> Tommaso Merciai (2):
>   clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
>   clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 ++++++++---
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 ++++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  53 ++++
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |  29 ++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +-
>  drivers/clk/renesas/rzv2h-cpg.c               | 183 ++++++++----
>  drivers/clk/renesas/rzv2h-cpg.h               |  54 ++++
>  drivers/net/can/rcar/rcar_canfd.c             | 278
> +++++++++++++-----
>  8 files changed, 676 insertions(+), 166 deletions(-)
>=20

I reviewed this series, looks good to me.
I can apply, if there are no other comments and test was OK.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/192=
6889907

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


