Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CCFC4451C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 03:32:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18847.1784626579407420507
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 02:36:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=Yb/A3yOj;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=shivanand.kunijadar.v45@mail.toshiba
	;s=key2.smx;t=1784626577;x=1785836177;bh=TUxx7QgMu9g4YGuthMbTDKPpr122W6LWLOpX
	r6wb0hc=;b=Yb/A3yOjhHgJ+FdfbfiYZt9umXHJmS+mfTPKYpJgGlL5Td6+vnB7Gozd1rBvTDXfq5
	d0nIkI6lMkuvuLritJ2AipEg2pk9BvDiFsET7MHmyztlFuwupbpndyD+UX+lABZjLmpIn5Kl8m95B
	sr8dtonbW1JC4FUOYgB1wenNKc9G0eTdtXmZyqfbWg9lfwagJpOs4mMdx4g+9R+XX5jMWudR/jKC+
	+EsmVcczeKmmK162PGqMiOR01LLGnZcU3lO8XY5dzbKPAZBx56kK+KgU8M5eUPhdZ0UPfKywRz1w6
	ysSJQPkchDG6WE693K0oCtMQ9t3AeQIGH9zgkhSYobRpg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66L9aHhC2328269; Tue, 21 Jul 2026 18:36:17 +0900
X-Iguazu-Qid: 2yAbqIO4LgNhmfIag7
X-Iguazu-QSIG: v=2; s=1; t=1784626577; q=2yAbqIO4LgNhmfIag7; m=oyT/QJQahXH87/r/ulZ3p4ln3uXCLY5/Oy3FNP67kCY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4C1s1fWyzyPZ; Tue, 21 Jul 2026 18:36:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpVkBkFWHIRoTcDT2zWltYYnlqgkv9/VBg4+MNREm+Nh7fRCWnDmPrD85H0dW/JIcVlvDHeO3KktB3laEVc7HSNqkZZDPlBfUG+6NmINmnAknZLP9b2PHWqTseAsyFZSuoyVf90bcbOljpiXIZGyLUt9bFQBtX2ws/deDn5ed2AlHecqzMLEumAly9Eu1XAaSSHC6Uu6IgfWgmHTYTZxYkciX8d8J2MO2DtrO1+6F2eZYQKziEMsg3Qs5xahnZ1wwyYwBcYlUmlart2AvXP6K4dOzhN1+KbDzp5nomeMucKcAnZIch4XMRXXRfiLlB7t+6PiSI2kt+9lrha1RoD+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUxx7QgMu9g4YGuthMbTDKPpr122W6LWLOpXr6wb0hc=;
 b=xEFI3r0x796917R5hor6r35dIMHfDxnE1IXnCxgZJY+btmuYZsn4Wis4W2bSVbEUC23ExDkcMYiZA/TaBUPdDU/MbtfP2qyWNDN/NumdcGXijaLVCcc84A1STMdt/roJizJnY9sew+BjsVCEifwlKM4h6UD6GvdyVsd8SemJsked9VL/ciHJ8861fd2fOGY3oiv6QeV4CBGo+glcmWJLK2PLIWYx+JWC52eSOPDp58dLUVvi9MmmbeVLPCmq/+62n+JxGQT9c8wTh3xxooDOC0Cyku++bquteEerkAJdrZkLP/2eS+RojGyJBpSo/K54MK8bdL/eSm8z9I0Ul/UwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <shivanand.kunijadar.v45@mail.toshiba>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Enable SWUpdate support for Debian sid
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 0/2] Enable SWUpdate support
 for Debian sid
Thread-Index: AQHdGAZXAqHfq3e2dU6zXdgxdpOTPrZ2D0CAgAGogXA=
Date: Tue, 21 Jul 2026 09:36:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11063C8FF725A7A2F72417B4EC5C22@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <4a161528-95c2-473d-8445-fd50f64b516a@siemens.com>
In-Reply-To: <4a161528-95c2-473d-8445-fd50f64b516a@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OS3PR01MB6659:EE_
x-ms-office365-filtering-correlation-id: 89bf4ff5-7619-4ef2-af48-08dee70b8208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 a2k9VwocI2wZLh8a8Sz7Iw+5/6Yx7xqvrJ6vAJL3jBlgGGMARBKPj+dQxDxbgpoQnEcVTHiFhr5UQlWwZmYbEcUNar2lk1/qKB+/fRQN4WEjT2I7SbZ4MTeOdo2Plzfe1Xm05xIboAjD5C2f4gUHxrhA+sFV+hNWP3Hz+0TiAslA6xg7Zx1eows+WzDgEV8d5p8XQ7gSZQwcGfZSewogeXBj7B75oC26+SeuPdS+0HBgE3cQskHqRmWK4UQgJ47VNKZEJqNWNkeWTqfB3sxtCNf8f+e9GpnSkbodLj7xSMEUeDRFCcrH3F8+ZAMQbl8RX4p87KUHIkFRpxcANM2bl1wraMTaE67u9qN7ao7HBu5hba91MLL6sGtEGrB/XhHuKhByOFPF1+weq+MP89+4hh9+LZWsZXN03TprDkSuxh2r7G8LqMLc8mvuCQoxiH5VnoQfOuk0ezTsACC+mfM5qVHE/grDoxOS6bG2ZMx04U3rt8Y8uSB9oKvrt7WQHS7fjLi/gGtPShEYpBTDbNZ5jqNetCSy1XaG/xOuYLfqSK6I/L64C1gRHxNUZSD6DF+xDievTq8L5JNrq10/mm2NZFKGunT3AZvwhSQRxppxdyHpP0+j/0XFqHPtEcUbBEFe1VpyqyYMRgFXowHUvHY5FiwKdTng4glMHnWDIH1M+oScd6RW5kO+aaIfKS+5grX5HmV8TYlvJwtl+eYwM3iTAUsiniLepBBOwUj8H+hwg7k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bXRvNjFLZ01qU2pka2tkdnJlRi9vNWw0WVpXS1ljdFNQeVQ5UDNraHp6ZSs3?=
 =?utf-8?B?UkNpeTFZNm9LL1IzdTlMMzNra2NhMkNIaEdZOHFaZGxIdDFLN3hhTVV5L2d3?=
 =?utf-8?B?a3N2cy8vUE9rT0lPQll6Tm94dW84WlBaZTN4QzNUbHVqRmpHN2VaRkVTQko0?=
 =?utf-8?B?c01LaHptOVpHNmNnMjFneTRLQ1VyQkptVDI5ZUtLY2Iwcm85anJ4M1FEaW4w?=
 =?utf-8?B?aFgxTUZ5ajVnb3gyVFNQNWVrODhVU3A0UCtic0Y0RmQvTnVVY1QzNDZEelVt?=
 =?utf-8?B?YVY2OEpMdW8wdHhucW54NExXMjR5bDQ4S1N6citvN1d6SWpMT1FKM0ZFQUFF?=
 =?utf-8?B?SWVXMFpVMmozWmlLOXduOGJXMGhhS2x0dThIRUNaZnNQQVorbHNwOE5IZjg1?=
 =?utf-8?B?S29ZUGZzbXQ0K2c2YmtvN1djeHJTb1djZDF4bDRvUVNvNGM2RXpMUDcxc0pw?=
 =?utf-8?B?MGFlMVI4WkorQUhnWnV6RnFXVnBGZy91a0lGc2tmaTY0WTMyWkc2N2QxR25L?=
 =?utf-8?B?VmdwK3RSekszdFQ4M0J1d0lQTkVicm5IUUNNVE9vcEFPSGJtUUs5VFpmY0lR?=
 =?utf-8?B?S0RpSnFNcG1qb24xOG1WY1M2RWVEdmtqMFlFR28xci9LMjJVd2RKNUdoMDZD?=
 =?utf-8?B?a3JiN0dLUllRekE5ZWE3bDIxc21VajUxYlpKOGM4TjREdi95Tk55Z2Z1TkxI?=
 =?utf-8?B?c1pNTkxsUXN4N2ViMnZIZ25lVCtZOFR3cURmY095VGp4dzYrSm5McWVIUUd6?=
 =?utf-8?B?V1JvOW9vR0xuL3hrSVpDMnM5aWdiYk9ENXFrMnZ1dlhaN2lkS0JzQTlnK0Yw?=
 =?utf-8?B?NWwyQU43ZXZtdW5WTElIQzlvWExLcXp3bm56dHhlMDIrdjZrem9xV2pFSXI1?=
 =?utf-8?B?NEh4RU5zamhDYlVjSHJFbnpUZzFBekIxbiswR2lsMm5aMjB2WXdoMWlScDhC?=
 =?utf-8?B?VUlMSml6eWwydEFCYnM5N3Ixc3NCSmlWVnYvU21Helh4U081dk13OHRHdWwy?=
 =?utf-8?B?YjlhSmZlWUx4eko2aWxrR3pZbTQ4YmNCRWlxUSt4ZlRzdzljUVhBblVEQTR4?=
 =?utf-8?B?dGgwSFgxMnRjUUtNOXpJM2d6dkUrMDdoakRFcElES3ZSUGw5Q0R0Zk5pM2VW?=
 =?utf-8?B?aHU3bDFJQ3IyUXNWbjUvWmcxOUw3a000UWd4WGxMWEpqdEZydlpxSkZHdXRl?=
 =?utf-8?B?UUJGOFVPaGdIS2JYNWJrZzhZQklnZmJFWEdWbVFxVHRIODZ3SDJRbVZIVTBQ?=
 =?utf-8?B?UmhkUG0wcWdncEc3MVNSN09tdkgwRXNNK0MzNnFGNzJ0RmVyY29BT3laUnAv?=
 =?utf-8?B?czB2cnBmZWtYeGs5OWhGNThhYnFWK0ZRZE4zd0ZRWVZ6cDA4MXgvVm9yZlJ2?=
 =?utf-8?B?c1RSOXJUalhPWTBkS0w2dHdaVnMrMEVlb0hPc2FEdWtyMTBvQ1dCRXZ3b1g2?=
 =?utf-8?B?aXBtb0JiWDZ6dnQrOWN0V2ova29MUC9jbjhRZnZhTUVxRXZZVTNHbUVpa1BY?=
 =?utf-8?B?ZlVMZUVST3R3Y2FZK3BPbmZMMHAvUUFyb0xLZDdFWUhsMlBTd2pyakpWdHRi?=
 =?utf-8?B?Snd4ZTA5OG54UGxZY0JrUzRaQXBXZlNUeVlXUmM4em1xbElmZ3RLWCtxVS8r?=
 =?utf-8?B?MFZ6cXhIa1d1bnZUZXJJT081dEN6dWR6RHJjcUt0ZzEzTklHeDlxVVFCamlx?=
 =?utf-8?B?NjZYdk5yTmtjZW11dmY1YlMxMFV6L1dYYjV2Mi94NTdUcGxoQXZmVElSaWJG?=
 =?utf-8?B?MThtZHFlWk11ck9tenBMUmZYZThDS2ZHMzNRSGtzZURUU0dzUXdvOTlKR2pK?=
 =?utf-8?B?c2dLbm4zUGl1aFNCVU1kc2R6RnJaRE84K2VPN0FtUVBxbVZXLzJtb1VuUzJh?=
 =?utf-8?B?TWJGSWRrci9xVkIzUDREWnNtaVdvakQrRnM1TVAyNmlZTkR1MngydXpDU3Zh?=
 =?utf-8?B?RGJjTUE4MCs5NDhFdnVOTEV6Q2xHOHpuWlFhNElKU09ZRDRRMDhLL1V5T1Bj?=
 =?utf-8?B?cHlMclZsbXJ2TGtyemlJWHdhWkFCcGJTdXc1Mk1JV1pvdGthRHJzcE9UcUhD?=
 =?utf-8?B?algwcXRJUm1sK2R6eG1SMzFKTUdQY2RISU1JdDdsUW9kdGRhWUxEMFpFd1Ny?=
 =?utf-8?B?clp4Znd0cWZpdnJETzREbWJzV1RwTUxHbjZQYXFWYWpVYnJuODdxME9UN2Fu?=
 =?utf-8?B?K2ZId01STFFRQlhERjVjZXJJUHZBV29mSGFheHpyck0xMTk2WkFLeUsxeUgv?=
 =?utf-8?B?SmRvMStiWHZYQ1JCWHZ4NzZoWm4rK2tHdGJPTG5YQzBJcExBQytReGNpSy91?=
 =?utf-8?B?ajA4UTI1OXNZUWFGSmdHM0hFM2JvT0VVOXdDd1NZaFliNHpLSHlWVkg5aFpV?=
 =?utf-8?Q?Z2tSsSQ3WQcmHJgU=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	jhVlVNAR181WNJeSB3OWdglA+F834OZVP/ZOaNoquopl/UYixrw7z6NpVpmncnN9MeffdHhc4gr0GJLTz5nOfeZahN7llfnm02lYg7/Xju2/TGbCNINdcJttudJ0SXfEu1JEi/PEqHCehKzuD0SgdMh17uLYud8hiQLZ+l5/17Ir8jrlu3P9wqdhcW6pd6oN9egnxxM7dJO+IjsmW0/0osNMeSAInmsD6QLyCPEF0uThpHDgIFTGU43zKtaoHWc8Yy0bG2p8i2lrW40tAU3eDeSdFN3EttrgTG5/xZpD3BVpgVsCG+eO8UVr70h8C5oNjgMl5xG93gyZzUzNN3KR6g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bf4ff5-7619-4ef2-af48-08dee70b8208
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 09:36:14.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j+6N6ZNSA5XGZ5np4TbIUrI7P4+Kretzb9UkyoabjjPoURxJAJ+TMQueRE6mzO1eZHddxqAaBWIQPzXAIXKsF89zIabSElMAYKk2GxIW+n12PfMClxBhEAidD/OYVqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6659
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 03:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23704

SGkgUXVpcmluLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IEkgbm90IHN1cmUgd2Ug
c2hvdWxkIHRlc3Qgc2lkIGhlcmUuIGZvcmt5L3Rlc3Rpbmcgd291bGQgYmUgYmV0dGVyIGFzIGl0
IHdpbGwgZnJlZXplIGFuZCBub3QgYmUgYSBtb3ZpbmcgdGFyZ2V0IGxpa2Ugc2lkLg0KDQpJIHVu
ZGVyc3RhbmQgdGhlIHBvaW50LCBob3dldmVyIHdlIGhhdmUgYWxyZWFkeSBlbmFibGVkIERlYmlh
biBTaWQgYmFzZWQgYnVpbGQgYW5kIHRlc3Qgc3VwcG9ydCAoQ0kpIHNvLCBJIHRlc3RlZCBTV1Vw
ZGF0ZSBmb3IgRGViaWFuIFNpZC4gd2UgcGxhbiB0byBzZW5kIHBhdGNoZXMgdG8gZW5hYmxlIGZv
cmt5IGJhc2VkIGJ1aWxkIGFuZCB0ZXN0IHN1cHBvcnQgbGF0ZXIuICANCg0KVGhhbmtzICYgUmVn
YXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KU2VudDogMjAgSnVseSAyMDI2IDEzOjQ0DQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1BBVENIIHYxIDAv
Ml0gRW5hYmxlIFNXVXBkYXRlIHN1cHBvcnQgZm9yIERlYmlhbiBzaWQNCg0KSGksDQoNCk9uIDcv
MjAvMjYgNjo1OSBBTSwgS3VuaWphZGFyIFNoaXZhbmFuZCB3cm90ZToNCj4gRnJvbTogU2hpdmFu
YW5kIEt1bmlqYWRhciA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPg0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB0aGUgbWlzc2luZyBzZXR0aW5ncyB0byBlbmFibGUg
dGhlIFNXVXBkYXRlIA0KPiBzdXBwb3J0IGZvciBEZWJpYW4gc2lkLg0KPiBPbiB0b3Agb2YgdGhl
c2UgY2hhbmdlcywgSSBjb25maXJtZWQgdGhlIFNXVXBkYXRlIHdvcmtzIGZpbmUuDQo+IA0KSSBu
b3Qgc3VyZSB3ZSBzaG91bGQgdGVzdCBzaWQgaGVyZS4gZm9ya3kvdGVzdGluZyB3b3VsZCBiZSBi
ZXR0ZXIgYXMgaXQgd2lsbCBmcmVlemUgYW5kIG5vdCBiZSBhIG1vdmluZyB0YXJnZXQgbGlrZSBz
aWQuDQoNClF1aXJpbg0KPiBTaGl2YW5hbmQgS3VuaWphZGFyICgyKToNCj4gICAgc3d1cGRhdGUt
aGFuZGxlci1yb3VuZHJvYmluOiBLZWVwIEx1YSB2ZXJzaW9uIDUuNSBmb3Igc2lkDQo+ICAgIHN3
dXBkYXRlLmNmZy50bXBsOiBBZGQgZGlnZXN0LXByb3ZpZGVyIG9wdGlvbiBmb3Igc2lnbmF0dXJl
DQo+ICAgICAgdmVyaWZpY2F0aW9uDQo+IA0KPiAgIC4uLi9maWxlcy97c3d1cGRhdGUuY2ZnID0+
IHN3dXBkYXRlLmNmZy50bXBsfSAgICAgICAgICAgICB8IDEgKw0KPiAgIHJlY2lwZXMtY29yZS9z
d3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmlnXzAuMi5iYiAgICAgICB8IDggKysrKystLS0N
Cj4gICAuLi4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluXzAuMS5iYiAgICAgICAgICAgICAg
ICAgICAgfCAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gICByZW5hbWUgcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9maWxlcy97
c3d1cGRhdGUuY2ZnID0+IA0KPiBzd3VwZGF0ZS5jZmcudG1wbH0gKDc3JSkNCj4gDQo+IA0KPiAN
Cj4gDQo+IA0KDQo=


