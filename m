Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8DD5E154
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 13:31:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22477.1765891902447925039
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 05:31:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=wRARUg7N;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1765891890;x=1767101490;bh=iic/l8MkbY87e/qXA/voi6yrumPS+AulerBKe
	Mj11VI=;b=wRARUg7N9yukGNgB+yVNlHJw9/JztSpYoDfqmAH3hkwnJqKvfBScaaebjv+BoqknRaJ
	Y+rpYJnpI+1z0AdSQcMIF2rL0AmuD5TBUN5tyCylKbjTAmdRr5bq6UWNAwUDYxSd7AMxCm47fnFlf
	nj511t78KAX7KProddLE8YevLq+ALYoarpY04dYFKN+h1ie7+Og4PTA47beyl9qGzuf89OnRx+AWg
	Jhr4qV49Crkm9Iny7T8Pk+8Z0WoSW9qmn6OpZ4CLS5MS9AFa5UN123F8Umxm1E8LCc0SJA5+s3OxT
	/AHrUQ0rc0W4u795SPwYIbAs04E3B9A67fw8LXLFPsIA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5BGDVUaF3069225; Tue, 16 Dec 2025 22:31:30 +0900
X-Iguazu-Qid: 2yAafBYzBS9iMAjpPk
X-Iguazu-QSIG: v=2; s=0; t=1765891890; q=2yAafBYzBS9iMAjpPk; m=SOtTFbxM9a/nwaz4YjuF00MP9SO/HVaPGq5ky+SF9IA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dVyWP4pmYz1xnZ; Tue, 16 Dec 2025 22:31:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6eDCvD5XTKWXwrT2JDkVHGe33YQd3HBMfAWJ0BIbrW0whnkHzpPYUuIxV6cOnXE0Clz1R3J+mK1rjZpaPpXXDy14RZ5W2jPHU+EwarT3vhUjrxKbxQItNV+pqlXMAPgZCJIr+MkmbfDkVWE7myUtRhyB4XWkGGBpcIHF3xDIYv+Eh9HqKajKOjHC7sW4XS5Kn8i32QlIb7gsrafFOli18pFdtgAe0eIBhqOpiu8eND0P2c4Z8sRDyjO2A8nQWqR+vzZvUPh7D75K5BHxaNg/VPeKFmLnJogQuq7ooqy3xlw0YxxhUvoE1zgW2HAOIMouNL1lAX36Rgdcq2yGuLg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y2uxy+ZK0Uso1XdsJW1thsE+OTcHxQA0alEivMwKD0=;
 b=KFY8h0HPLnRzSskm+YvP0sgdQ/morJElR+ogxrRLdbw1u8Ari3UIrisDXWCwm1MRAdRhPQJqD3su9A1NllxpNAoP85/D4yc0+KRfVmiAPCe3NBXtSIFo3nd9LfFfCgPvlLaMWuSy23GsNWJg02Z0PnML4SEUJ4e0jiDOJiv/WggrHaCPgmZjSjgF9ImSqiF4yxsjAQfrqEDzad1/ywhPuBs5ReGWppApq7ECaW6UtI+lZbCoJaQ/2SL14lCkn62FhYfm3nMIKZ5YGdhIIQRk7P6jp33BzJmaKc7MuHM36c2zEY0G66vgxgOZJofgMjNbJMK7DNOpHmeOUeciEi3hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@denx.de>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth:
 Add PM suspend/resume callbacks
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth:
 Add PM suspend/resume callbacks
Thread-Index: AQHcbU1tYvF6BqkV5ky0CY95XDbu6LUkLHaAgAAY/NA=
Date: Tue, 16 Dec 2025 13:31:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180907407E3C42AE3997DDCDAAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
 <aUFJzat5zuhxSBiK@duo.ucw.cz>
In-Reply-To: <aUFJzat5zuhxSBiK@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14558:EE_
x-ms-office365-filtering-correlation-id: 21cb6d4e-dea5-4502-67b1-08de3ca76a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cFUrY20waUhiNzRsTEc4dFRBL2U3cDZqTDBuMlRIRjJxNlZPK3NzTFJk?=
 =?iso-2022-jp?B?ZkZZTG5ISEgwQVdrdUpIU2xwbmw5Y3IwOC9ZNzJnSkNpc1hnenp6cndO?=
 =?iso-2022-jp?B?Ni9OTWk2RDhNVUxibzRGT0k4QXpVdlZDVEt0S0xsTVVCUWJ1NnpoQUhw?=
 =?iso-2022-jp?B?WWNSZVpNdlVaNXMvanpId01LMmdQQXVhamJEWWJiYzRYTEsrWFVSSmY3?=
 =?iso-2022-jp?B?WkVva3hOQ0s3aE1XenIzZHd4Y3Jaa3VONmxxc0E3ajVEY0R0RDF6UUZq?=
 =?iso-2022-jp?B?L0x2WVppWGFzNC8xZEZzc1hVV3A2WTQxVXY5VjM1SFEvQ0M4ckttNEt2?=
 =?iso-2022-jp?B?bGppYWZnWno5bDF3SVdUT1l2VzdBdmhKU1dvK0Z3bnF1a0Yxc2ZHa0tK?=
 =?iso-2022-jp?B?T2pBZUpSb1U5WFkxbGF6UEZBOEpGUk91T1ZFaVhkU1BQUTJkQU9vTld6?=
 =?iso-2022-jp?B?dE9pUkZrUFJ0cmVlVS9vWFVwS3V3WFkrMURJdmMxUzlVdXk0TG0vaDIy?=
 =?iso-2022-jp?B?WEJqRURvMWlhUkp4aVUvcDZyTXFlY1c3YU1CcTU4YnNjRFFsbUh2Y3Az?=
 =?iso-2022-jp?B?Z2ZhdThXeGhNaXFBQVZrdVZKbmVQeDhoRjFvSkRUQ0RTSVVqbnk2VXVt?=
 =?iso-2022-jp?B?SDVUaTZhL2M1TVJPNzNQV0p6YkEreENKT1JqbEllR0I2WTRIMWNoWVd2?=
 =?iso-2022-jp?B?dkc1T3JLOVIvb3BsZzhRMGZLU2tnZElPWXZZa09RQU1aV1UvUzRWMlZH?=
 =?iso-2022-jp?B?WDQrenZ4d1ZheE1yZ0VhTUlpMXpKU0wxanZTMTlWNDFHcm0zYmYrVWpq?=
 =?iso-2022-jp?B?aFJEdW5mUDdXbzBacVpZK09Ec2F5YTVkRWpCQWJTcGZ4WDljSE5EMGo4?=
 =?iso-2022-jp?B?TEhuNkUwMy9WZi8wM2ZWN28yYjFZakQwRFgrRXRzanVwVEM5bUQyTzBh?=
 =?iso-2022-jp?B?bkN0V2lkVHp4R0tWNDF5SS9LdE9kdThMREsyQkhCRzBpcnR3M3Uyb05V?=
 =?iso-2022-jp?B?aFF1dXVlTzYzMVFoUjJKNVhKZ2FYalAxR1diRE53ckZmVWx6N1h4LzNx?=
 =?iso-2022-jp?B?RVhLR2NRK1NlNUl2akFDSE5MOG5oejdjbG5nTkpsMzRwSW5HbTgvVk9t?=
 =?iso-2022-jp?B?Rkhra0RuR05TUXluQUxlRnpNZXljNEs5WmdKcWtOSWp0VnBDMWs0VVg5?=
 =?iso-2022-jp?B?alhTYmtBRktpREVFekI3VGlIRVVZcVpTRnEyai9pS2hvbVQrNHdKdlQv?=
 =?iso-2022-jp?B?NjIzYm5kUVV0ZDBIL2oyc2xuTU1CRmk1WjFLdW9yNG1IQWR4MFMvWFBE?=
 =?iso-2022-jp?B?WmFJOUVxYjc1M2RqWWlOZUczZGZEVDRaSVgzR1JHdXY1ZGw4TElaVjh5?=
 =?iso-2022-jp?B?SXlJK1hiSHBMRjV6OGpPbE1rUWxTK2t1eTBhWFhMWStXT3pSZmlTZ3Bj?=
 =?iso-2022-jp?B?VkRiWVlPbis1NUUyQTMybEVCMHpQSW9Fd3krS0hPSzNjSitzV2hPTlgy?=
 =?iso-2022-jp?B?UUxQZ016WSsvNHdsdGErbExzQkhMVXRQRVdxa2V3cGNheFNUSnBvbEpO?=
 =?iso-2022-jp?B?b25jem9aT0I3c0tNRTk4T1BrWVI2VVdaR3FzRndXakNGNDdFeExMOFh3?=
 =?iso-2022-jp?B?MG4vdDE2eEJseEFuQ2FIRkNXUDNvWlk3ZDRlejRaVWxYVVJQVTk5ZTF3?=
 =?iso-2022-jp?B?OGZ3Q2pLTk5FZDQ4WGdiUTJpV09lMS9nNm1tRjlMRGloblc1YkZCT3Bv?=
 =?iso-2022-jp?B?MjBFeUROcVFXQXZWbUZ3Tit0VjRnN3RmYmlwOFo5SmkzbklGVy9VbFRv?=
 =?iso-2022-jp?B?UlgyRXhhYnZ4TE56UUtNdXZZWnFJTENtdXd2NjNvaVhuemxnM0k1anZ6?=
 =?iso-2022-jp?B?OUQrbkFvTEw5RDZjZ2tnUGFTaHNNSU1BZ29UbDlVaTRSUmY2U3dYYVdW?=
 =?iso-2022-jp?B?UWc0QkMvY09tQnR1UTRYQnFBRHRGWWNINjBmbmVKazRqS0U0Z3hsbDNp?=
 =?iso-2022-jp?B?a3RkQ3JpRUFvbzhJajZMUTJwdGVwcUJGOVRzS3VOdlpYRWNHTmxpeUFn?=
 =?iso-2022-jp?B?OTZETlAza0hLTzdlcHRkQ0xDT2xQVzZUcGJVVGl6MmVBQkZVRk9welpt?=
 =?iso-2022-jp?B?ZkxxczVGMkcxSzlVZ1hhNURVVmdKbWx3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cHRzSTAyYTNtRzB6MnNycGcyOS9scmp5UXBtSHBwcTY1bG43bW15S3Bn?=
 =?iso-2022-jp?B?VW5aZWtETGJWSHZMRjBQQ3AxM0FkdHJ4M3hJMlRQSUxvL3Uxa2lrc0lT?=
 =?iso-2022-jp?B?ZXcvdjhtTWZnMWJ5N2V2dktzWHdleTlmTmRjdk40anhIajdDY0t5SnBG?=
 =?iso-2022-jp?B?OVJDekxvOEJPejF1U1dnU1VPaTUvTUlZUGdqN1NEVi9mbElJUU1WeTd6?=
 =?iso-2022-jp?B?NHcwa1FSUVZnb1BpLzl2bEFtUEd3TUlVWEVWbC8vQWNBUmVUVjYrRmlB?=
 =?iso-2022-jp?B?NXFFZmFlL0JaRVJIaDJFZ252STRaeEpmbnVNc3FaaUJxZ255V2FJSmY3?=
 =?iso-2022-jp?B?eGRIQTJNeHlWVnlBTHJvcFI5Tk01Mys0c0tVa1lTWEJ0UXNmVkpQYlRz?=
 =?iso-2022-jp?B?OFBKcUhJbGh1TUdKWlRWTkZLZTd2UXpxci92WDJKRTdkcEYxVi9OV2N3?=
 =?iso-2022-jp?B?ZG9pSWZRRFdjbVBOeHpQL1RveUhsRkp6WVNqcndwQ3JvNnZxUk9ldWgv?=
 =?iso-2022-jp?B?WTh3c0xaWElONnJ4VVljMVJDSzNlM0YzbWJiMHN0K0E4SklINzBRc3I1?=
 =?iso-2022-jp?B?cWJUNUJta2ZwVzF2bHFBakE0amcwTzJUOGdlUG9GalpoVXBhL1FCakZm?=
 =?iso-2022-jp?B?aFdMa3hnRDloOW5Ia3R6WjBBN2NibnQ1a2wyWW9TUFNBeUtPanlnOG1a?=
 =?iso-2022-jp?B?ZmJxU0d1alBsUXdVUFJTTEdScWFvcU5YZHhxWTR3NW4rb0ljRlhGMWVo?=
 =?iso-2022-jp?B?ZnR1WTJFYkpOK05rT0hsZXMvMTBsMWFkdkdLdmJ4eG9oSURHTWd0R2d1?=
 =?iso-2022-jp?B?Y3J5cUJwSVNuUlNMYld6cjBtek4rNVRITjljU3dQU0ZsY3hwS3Bab09E?=
 =?iso-2022-jp?B?NHFsdTV6clhBYlY1Z2hMZWdxMURrNkhkelEyUStlcEpqWnFLUGY3QmFa?=
 =?iso-2022-jp?B?L0tLbkpyMXN6WWIycWg2YWZNbGg4Q0I3eVd6V0dNNERGc0VNZUNVZStz?=
 =?iso-2022-jp?B?RXQ0MTJrZlpPeVdGL2twTGt6VEM0Z3hHeTY4dUNoczFRTkZ3TU9tODE2?=
 =?iso-2022-jp?B?OEF0MFdCUk5WRzhjYmN4aGU5VzVqT1pUVkJkUmpsRVExd1N4RXJFbmox?=
 =?iso-2022-jp?B?VFQ2OVAzTWtFV2hBV21jL0FFcTFJQitXdDYrTlNxazY2VG4vcjV3U3hH?=
 =?iso-2022-jp?B?UTBpa2t2QmhVRnFkOXpnRHQrcTZ6VkdJb2s4M3NQNWpDN2xLbnNtSGlD?=
 =?iso-2022-jp?B?ZXkxU2c0TUZyVnQ2bTVlWDlGdWd0UlloYnhsREY2RVpNWFh1bVFRUkdL?=
 =?iso-2022-jp?B?VzZrOUExN2M1SlRWRG5Pei9BWmdLOTlZOFNIMWx0VFBCdHl0TnRMRG12?=
 =?iso-2022-jp?B?RDBuY3ovejR5VWkwVTFVZzdJNWlQQlR2eENLZkgxZnlyZ3hEMzdyZVdp?=
 =?iso-2022-jp?B?UlZjd20zRE1iRFNlK3MvUGdVa3NLOWFESnlhMmwwbnV1VmFxZFRLc20x?=
 =?iso-2022-jp?B?NVl1TU9MckxqYitqR3ZIdUdCem1UblFnaW9xcVNuSzRWYjlZemF6VDM5?=
 =?iso-2022-jp?B?WkRzL014b2szS2tRM0hXWkxQdm9IRUVVOFB5Z3luODFSd3N5bVM1TTN5?=
 =?iso-2022-jp?B?Q1FBYzhSQndTSGJqSFFONENFejhEcVl4M2dINUtzTlhCazV0VXJXK0tC?=
 =?iso-2022-jp?B?RXV6UzNGdEJNOEM1Ynh5enVCaW91b1hld0pRRFFKOUhyNUd2SUN1emMw?=
 =?iso-2022-jp?B?STh6cm1GUTJqaTRvdWNrY1duVGNGVi9pL1MxUE1LSlRvWENtNjhkeU1l?=
 =?iso-2022-jp?B?TkFYTGRBSGV6UHlIMS9NUWhqa2RzNit4MENRajR2aFFyUmFvcllpTXV0?=
 =?iso-2022-jp?B?ME1ocXhsSDZ2ZnUzMkhtY0d1SjdXTGFLekZvZW16aUZmU3dyZ3paem9L?=
 =?iso-2022-jp?B?SHNyR080TlRNRlBoOTgySFlOTVFsRGsvOHltTzFCRm5HMFdQQlFXbWY0?=
 =?iso-2022-jp?B?VGpCZFJCd1lUUTVjV0ZIRjdpczI1UVdhTnpaa2tEN0gxbGQrQ0RoRWxh?=
 =?iso-2022-jp?B?d0JNdE9LN2NrVHJ5RnFnWCtIc1NmWFlnZ0FPODFEaVVyVlVxOCtyQmpV?=
 =?iso-2022-jp?B?UkNtTDFnUGEvMU5mc3h5dU5FbFZKK00yM1V6OFZZTXlIWDF5VTFmdVdD?=
 =?iso-2022-jp?B?WUJiLy9mOVU4aHdWdFFyWnpTRGY1Ukh1ZUdPdEZncGM0bngvMUlUdEk4?=
 =?iso-2022-jp?B?SmR1Z2ZvcXVVaGRyMlJReEUrYnhHMVlIUjBvUmVuemQ3MmY1ekxUWGpn?=
 =?iso-2022-jp?B?TmE2QXRoZDdjNXZOVmRuMHBvck12TGhwTnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb6d4e-dea5-4502-67b1-08de3ca76a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:31:27.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/k9b2/5fB2WJAU/6vIAAIhXFxT8qqNHNyJWwL5Cp+TAoXRMGr9t1srjqnwmG479+QEzpDEHXhU3wWhNeiEaQKQUgKl8UpYmksbJrUPJCqL/yk3IUB6erbxUQ5aTkyA0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 13:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21086

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, December 16, 2025 9:00 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbet=
h:
> Add PM suspend/resume callbacks
>=20
> Hi!
>=20
> > Add PM suspend/resume callbacks for RZ/G3E SMARC EVK.
> >
> > The PM deep entry is executed by pressing the SLEEP button and exit
> > from entry is by pressing the power button.
>=20
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://patch.msgid.link/20250717071109.8213-1-biju.das.jz@bp.renesas.
> > com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Thank you, applied.
>=20

Thanks, Pavel.
This has already been applied, so it is a record of what has been reviewed.

I reviewed this series, looks good to me, too.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


