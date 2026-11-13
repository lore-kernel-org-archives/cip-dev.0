Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.457.1794607987933286846
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 14:13:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fT6VtHG0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794607983;x=1795817583;bh=b29M74aergIW5vwqjDq6RVnEtB84pUNxpzkGL
	YAbyMk=;b=fT6VtHG09VrKedLNK91bMfC56SvNSnM7nn/NCBdCp1zlxU2RQ7cvPiwypLdOyaHMY88
	R7r+2MBZEzY+liRxZ//fKqk354Gy/u/81Bwq6Jw5IOc8qRPc7dghCTe15mNSwLUCRwSeyJY16kHJx
	NXIRR71uWfSa3MTjQq+aukHQXyaIwqqyeBMHJkMb3EXGnlmd3usFrYFeSNclxB5RDQ3iihxBr6UHE
	NrCKt+qN3aINeUadvidvd72GEPh2Hewquj/UEpnC+fD2YBD0A7Q6+CkEvkmA6e7cFt/2jTb4UmHwl
	E10J2ZOLmUB2Wv3VTbhDqaztEXJ9vxNo8RG2EVBQwWGg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6ADMD3Nd1192096; Sat, 14 Nov 2026 07:13:03 +0900
X-Iguazu-Qid: 2rWhnX7phIc8JJ2hAe
X-Iguazu-QSIG: v=2; s=1; t=1794607983; q=2rWhnX7phIc8JJ2hAe; m=YGLNBtH7BNV+P3kxsKePS3qLVDzf8slNJJTPds0qqiY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jRBMy5jfYz4vyn; Sat, 14 Nov 2026 07:13:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScW5OLtmqi1Nk/gfBYjpiJD8N51wGvsiwgnsNvoldO5fymm87PH458tKpTkd2GPb9jypLxS6DxisGX48OBtFdURjqmolhKk2EJG9+D3dcxQ6cDxbjecPF5i1D0ESgswj6LZMIdvhF6Bi1zVk7LVCNY5eO0j7zfpfGWzqRnoS4vyDHGt3mBRWGCbxhY3wsaKNslxNJtfGUQiD4x2MPLbRhEYyGD5dzJ7++vVsX4XKA1637xil4rh1zUiXg6oRHijBCZRg/EGFKlV6BXliXOq7HcavDde474wb00NiKZwi7IDp4pl8USV81DWULM3dx+G/qXghwRqdpJnpY9HOt16QSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XteTVOy50HqykeKN//l0vGE0QZr5BW7vd05cGoljWZk=;
 b=fqx7ZE+azsegB64LJI0nNDfoasvzNbXAMJaHHtUpQNEoOIo407AhHTBtAUrOE2W8L9I1LCORdQERTxzFc4ZRl2Ynf9RB6tZxCWtm4IdJhfpcdJedufRW8EnUR4X51P/7mdhzVFLvNtdUSk3HoVoZYO5VSg6TIsav1J9CnVBYU60fsJ3Cqus7F2cgMZSx3mTZZzLhHwR9mMRkKpmsqtPsxFSHl0LiCXtH682R6Kq5MYxIKQAI+/w6GhvSBYi+CJMT5FF2IvEsGs4En+bmzMV/GSF6UFftSUyLtYuF5wsEmOAP1zveEcGyD8N/Xyg1ijVID3UYsEOeSWKlL0FUmmu1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/21] Add RTC support for RZ/T2H and RZ/N2H
 SoCs
Thread-Topic: [PATCH 6.12.y-cip 00/21] Add RTC support for RZ/T2H and RZ/N2H
 SoCs
Thread-Index: AQHdcb25oizaH30c/UGxqFMdcnp1KrcslBdw
Date: Fri, 13 Nov 2026 22:12:59 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818F25F87F42521DDEAFE29CD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB8542:EE_
x-ms-office365-filtering-correlation-id: 31f67aa8-07fc-4538-3f47-08df41d346f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|261026140227099003|261022105027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: h/u2jlc0+WFImUL/ETr4llxEjgGiY1LAVHALFnb4mDoDb+i2g05zegZoHQpQ31umvkJhzQoADb08/1Qq67Q5Hby1U0CPTq4ToEwMXRAestBhB4W2LCGNGudGr5+sRp+4egr6joQDz01zOLucGqhYZUtEYNREIt3TkV4bs8cUfgHXVPQMNIJA525nspdWzgfqULliB1wThNnrMKZ6ua3NVXt8R760qTU5VPnsjOBJ8Ure2prJNHjaB2qz+9LJfo4NjfQ2Ui1TNckri1h66wehzTrMfGAbtuw+Rwhu/TElPKOrrBiDIiwrGHrMfzAg5f/rQ/3Zbq19gXToXqPOaMfKWLDkLrZg4bkKaWBwwdVY7aHDuX8QJ63uoA/etvzKeGT6vnz/LYMX/4WNOD0MHMWZhQFZgggDBIMEtQUrsdLsT8OG0tAtnWtYjCRgMdn5bLmARRC1axnRRSUA9qKnRzy7hfiuWZDKd8f6zEYctnaExxtYcB6Y+Ef3h9nNdSI5ohjKuLRCtG4l+6NdQknctufFT3fOIIKyA+0BXkKYdvWj0UromHEIhYQ2Gu2Q/AXIDQ8JG8j6goJBBIc6uV+Y+iLwYHtE9RuD0VlP6oPkec1/S3eOfXzsEKEJle8ZM19q4kBwHNK1oF7dL6littUyZ8qeWh0AY4/4TTnkvpniyz3l0bg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cE1vY3Y5YlMzY20reTZ2V1hQUnYwRk1aakRLVWpocUVKZXdVekJpNVRE?=
 =?iso-2022-jp?B?UjF0WnFuZnBvRHhBajU3TUhNVHlhVHNRL25meXA5S0Ztam9EZkJvYzNT?=
 =?iso-2022-jp?B?VG5XMVhnUHhtRmV4N013NkozdjVTRlhxQk56K1M1SW53QU9QL3dXbzRQ?=
 =?iso-2022-jp?B?ZUNEeXdaU083ZS9HSGtNeG1OanVuc0h2UEprK3Vidzd3K1RRbHJEcThY?=
 =?iso-2022-jp?B?NTA2cVBCQnlxOVUrWkhrS3hyVXYwbnowdGw1U0NINEVmM1hQUWtSS0lp?=
 =?iso-2022-jp?B?YlN0RWZXZXBKQkhBZlFKLzhHQnhNQ01QaUQ2TzA3bG5zTGdZbkliSHdC?=
 =?iso-2022-jp?B?bzJBMnVhZHlEQnJyeTdYUHhaajNnRjRORGlyK3doQkpIZGYvY0s1dHBo?=
 =?iso-2022-jp?B?clUraHlPa1REN0d1bmZ6bzJWYXpySy9hSVJ2dXhtTmkxK25BU2hTTmxa?=
 =?iso-2022-jp?B?bm1pN0QrUWtIdThiNzZaZzdaWjJLTEt1eFFoZDNwQzhCQmZ4KzdEZWlZ?=
 =?iso-2022-jp?B?eS92Z3E5M2xuT21ZTkEvVW5OUjMyR3BKRlROaWt1TUdiNU9nSURISUJB?=
 =?iso-2022-jp?B?Unluai8rbEh6Ukw4cFlKUTJVOTB0aThybDloYmhPdXJweVFrM0tqV1g2?=
 =?iso-2022-jp?B?QXdKT0Q3NjhuNEhSTVRxTCtUZUNiT3JTZ0QvTnNQY2ZNMjZkWXBibWZ3?=
 =?iso-2022-jp?B?V1p3VXZWS1FncUdBREJrS1JpNVZGR0p6bmwwY0d4YklsWTRqbFViUGdB?=
 =?iso-2022-jp?B?clo4MXNyZHhXMXJDemg5UEdCL0pEVkhtcm5lYWMxREdXR2ovNHcrSlcz?=
 =?iso-2022-jp?B?VnhuaUlpaEI3NG1rWGN2bVNUaFE1eXJlUHlBdDMxOVl1VUcvYzY1ZFpC?=
 =?iso-2022-jp?B?OWNTMjlLazZLdGRsQUNSUm1LUGFQeFE3eWZqY2kxVXJIVjB1RTVXdHFx?=
 =?iso-2022-jp?B?OWJYM0dSSnRzdmVlRzN6ZEkrUDU2ZHpKN3o2RGZrMmpqY2JuRXI1SDhs?=
 =?iso-2022-jp?B?UnA1aVlGY2tYbkI1L2dSdEgveVVpRmdVV3FXRUtOOXE0MXVBUUpPbjNj?=
 =?iso-2022-jp?B?eGlWcitFQTVWdUtHYmJYa3hoSElURnRoN3pUenZxUEQxRTlxbFRybGg4?=
 =?iso-2022-jp?B?TGx0QXUvY2RXdTR1Tkh3cVRYN0cxRzI3ZFZjUzBOREduVHdQVFZ3akt6?=
 =?iso-2022-jp?B?azZjcFpuMkgxaXRqVWdXWW9UWG1lSTJiaktOdWRBMWhSNDJMd0ZIakxk?=
 =?iso-2022-jp?B?bkpxb1UyS0w4QmxQKzdmQ3YwREgvR2k0b2RubTdZQ3N0NmVTUUdhTG9n?=
 =?iso-2022-jp?B?OTkwT0hOcTVDRDRZYlBDRnFPQjRPR0tzYUJXUGF3OFY2b2RjNkpoVk5T?=
 =?iso-2022-jp?B?U2JXL1RxTEhpUnNwMVlKVU90TURzb0VDazdlV0RkVVNwakpwa1k4d0hZ?=
 =?iso-2022-jp?B?TTA4djArdTFzRUFIT3JnZHg3SXNoUjMyaFI0Nit2T0l0R1RJajlwMno3?=
 =?iso-2022-jp?B?V0VFWWJld1JsUUtNRXFKZWhKeGQxblJ4QTVCRm0rVEJKa2lMVEpkRGpj?=
 =?iso-2022-jp?B?d1hwOHJ6VVl5VGo4VXhHUXVYUi8zMDUvWXVkSXpCRWdsNWxYMTFETmd6?=
 =?iso-2022-jp?B?OWpCL3RGazM3bEFWdnRTZWNscWFQSWZXVVc0ZEFwbWxoWXFRSlVCYUxQ?=
 =?iso-2022-jp?B?MzY1NVFzVUx2VHpvMDJBT2JKVS9ZVksyMi9GQ0FMR0xhVUZOdFhMQ0RT?=
 =?iso-2022-jp?B?TW03MW1ZUE02VnI0b081WEdVdVlOZEplU09ySit0OER6SksrTVVoNTEr?=
 =?iso-2022-jp?B?N291eThMdWIxdkd1cjRLYW1KdWhRVldMd25zQW95cm1kN1g0aUJ0QW5B?=
 =?iso-2022-jp?B?N28vM2ZOR0srZ2VFV1hKWE9lMGpVeDI2NUt6alc2R0QzVHdodnQ0eU04?=
 =?iso-2022-jp?B?N3pLdU1LY1lMbDlCclhZdkdTTkRlRkJ6L21TM3c4WDc1R3FLMHZrMzNF?=
 =?iso-2022-jp?B?SG5MVWFhWlNLYmhTQzlEZnpjQzJCeTVyKy9idUVCd1YwQUNERnZEdk1h?=
 =?iso-2022-jp?B?cUxsSWJ2blYxeDlVOEhCK0o3UEsxT1V4UWlyL3NPODExSTZlaG9WT2J6?=
 =?iso-2022-jp?B?WXpVMmRYWDhQZ0hFR3liODFtZGZ5MjVzeUozVjA1Y3cvenc2OTdGVnVs?=
 =?iso-2022-jp?B?Qk9mM0M5QjhZa3NGUjhhOE9yWHNENThtaHllcU9YSnR6OWIzUVZndUdQ?=
 =?iso-2022-jp?B?OFduTElTN1VOMFU0ODBUbXB0UW40RlBXemsxcE83RHJ1UmwrakVxb0pR?=
 =?iso-2022-jp?B?TEZuVkEycXE1VzZaMmpUMGV2a3E4MjR1RVVpZ3dLWU9LWWsvWGdoVndp?=
 =?iso-2022-jp?B?UHBTNk9zaGxFK0txc2VyaGZvZE1VRWx0bG94L2pBajV6d0syWjFTZEl6?=
 =?iso-2022-jp?B?QzFLT0ZQZ05lYy9mUHA0dnN3VlNHVEdHWkJZK3Z2akUvbEd0amorM2dY?=
 =?iso-2022-jp?B?K0RlWEMxYkVzTVNXMDUwQ0RRMVl6a0FPUHNIMUhqZjRkUCtOQzZRUU9q?=
 =?iso-2022-jp?B?dFRTYkpJRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bjV25vIqhMihvl3KfgiUgUGxKC7lzPIYmnZH7BnWtTp8GqbQWHvLkw5+QWUr9JI8iH27w1EvqJuAFJ1G9pIMUEiKuxkyaOAUCaLR3XGczPpMaJXZHI+uVry1yDZ3vObK5a6zsCOnqHaNxQdly/or81cbyAzDAtn+iFriSyKPGxhn8HDhFEZi/RhCozm75cuZG2usylgMEhY5TRj/O7fnPu+ASqeBWt9uN40IJUHtUT5B5XiCDomT/FeuqQB5Rhs00LXmEGpc1lYUFkl7mZfEOIQykq5OJbJ+djbKiHjWV6XUy4W19X9TCx05/adxJEWGww6w7NFPxZ03k/K7KlXnvw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f67aa8-07fc-4538-3f47-08df41d346f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 22:12:59.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bowGkhIps/x6SMP9y644pisELK8tYbYgSrWcbZcsuwRX07p20FRmbr7WKergNJIrnafPmGPkNiEXvW9InZZYNFklsVIC5t2pEg8GVneBoKbEfZ9m8L7LQcUwMo0vb4+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8542
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 22:13:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24806

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Wednesday, November 11, 2026 6:19 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 00/21] Add RTC support for RZ/T2H and RZ/N2H
> SoCs
>=20
> Hi all,
>=20
> This series backports RTC support for the Renesas RZ/T2H (R9A09G077) and
> RZ/N2H (R9A09G087) SoCs to 6.12.y-cip. Both SoCs use an RTC that is
> compatible with the RZ/N1 RTC IP, so support is added to the existing
> rtc-rzn1 driver.
>=20
> All patches are cherry-picked from mainline. Note, this series apllies on=
 top of
> [0].
>=20
> [0]
> https://lore.kernel.org/all/20261109121451.6042-1-prabhakar.mahadev-lad.r=
j
> @bp.renesas.com/
>=20

I reviewed this series, it seems to no issues.
I will apply with Pavel's reviewed-by tag.=20

Best regards,
  Nobuhiro


