Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A108AC4451C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 03:32:28 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb.securemx.jp [210.130.202.159])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19346.1784628869505986812
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 03:14:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=rKw/8O4C;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.159, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 66L9UaTW768706; Tue, 21 Jul 2026 18:30:36 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=shivanand.kunijadar.v45@mail.toshiba
	;s=key2.smx;t=1784626229;x=1785835829;bh=HaOG4fiv9oV7ZRaj20i4iNdoJhhhYAngVhx/
	XiugmC8=;b=rKw/8O4CC09csSEgTpI11lP502pGOM9wwGkUystuxCGoxbybjE8tLYiqZZ+eIIteU9
	8h1VrbaxAoypxbpvTlKicJB1W0iFFmua3cMC8kV2TbEwrHZ/R1lhdRxUg1mDdHnD3G2m5CZU8Bg4i
	KxeXUK+uskP/mF5bSmQu4OhzupPJXytfLAfXOWLslPN5uH05oL+yjqqEuSqg57egJg9wdIcil0XD9
	yYCFeBZiaLJBLaGucsLgRMdgiZijophirIGZH+ktG/IvkmVUq8Wh8aLh04tsbBtyBBiJjQEykBxy+
	35j6tZPvxLHd1CEXsWMt/oiWoFqY/9EZuRvUB96lcxABw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66L9UTHc2392922; Tue, 21 Jul 2026 18:30:29 +0900
X-Iguazu-Qid: 2yAbkFS0LzhicnkeX3
X-Iguazu-QSIG: v=2; s=1; t=1784626229; q=2yAbkFS0LzhicnkeX3; m=q1WYXBlOt9XDvNBwmL4LU5bDBU4qJT0qX6zZU14Z+8M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4Bv91ySqz1xnh; Tue, 21 Jul 2026 18:30:28 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5zV4z6wf3g/aklWc3OdJCUliPM7LLXHXqU3GbDDYXbNTI165fU9Yixmq7T03KHeuNo5YqVm241ytdItokTnS97BX0raDT1tkw7kIR43tGc90SsjZRJ1iZpbj8x9aQRSWjYqMERCXKwZzs95dwOALmKstqTpZQ9GYvMZF2jeVSnydt0qwNVxK4rTFwnmCh3gMA2HeEZe0IC/zb2ZDJWtOvW6O3Vl34r/IUbA6ZH26YPbt4Il5VPSNp2oLOGwSoUy8jPzXF+Ct+BCq+AVpX6IFqUL2aBs5dXdg7Hm9gjMToqKpQHCbk+CbZBtw2aPgJlCZyLTBRDfg/hW0Cv5yjxNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gm1Psfkl8KDIayl310ky2iTVdowqT2hwvTKKDnznRg=;
 b=dkIuI3VGOnTD0ozJ+H5AxF/c8WQM2N/XXYyCaNQYASnOfrv0MBEWgmGUXh5QYelJ7T6ycp+YiX0wx/VjC509xJOy5dUclTooL358XiVt3VuxaaOCrXhNz1u2gzamN3ORB9kEduvEjGitPX/rK0tjnbecb/jMRYrr5pzR1CY8Fflv441ycLy9U6O5VDTE9uK4roKb4nnA+LUFUo7FXhJiu2l+S8NB0v4pQTMGPHxtcvXm6GiDmE0+EmX0v6D/9u52D8H6TMhVQ5dTYPCzVHyPQ99k1camR/Z+XjgUHYVhvQsMTmC9S95zDEt026zJIMi65lh+m8pNgJG1jrX5AZQxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <shivanand.kunijadar.v45@mail.toshiba>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/2] swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 1/2]
 swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
Thread-Index: AQHdGAZYJYC3WUHIGk+lSjkg+PUnY7Z2D3mAgAFsuHA=
Date: Tue, 21 Jul 2026 09:30:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB1106381B97061401A6E0139B3C5C22@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260720045903.733394-2-Shivanand.Kunijadar@toshiba-tsip.com>
 <41d69f3e-2719-435b-8485-f8218f3a642f@siemens.com>
In-Reply-To: <41d69f3e-2719-435b-8485-f8218f3a642f@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OS9PR01MB17465:EE_
x-ms-office365-filtering-correlation-id: bad8156a-2328-443c-9596-08dee70ab225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 gE31KnpKOXEaAJWod1uTNxHCdoPiHQAWeqEZhJUN29GtqG1hhOrBOSbFL+g07WESexiwUwMQyCa8sMWpmBTdSQr1tTLn1k7RlsEwH31GLIlVcAaFBElj+19y5Hz+OppT/nJBi9TJsmHh8brM10yusnG852AKXA3dIZsEw5GFJ8ZmoKQwOJod3yvdKOJZwYFgQZroWN4yDmG/jYtc7fZjOuN11cvAdBi2C3x+Z/DNm4XzYrjgmPf0diW0gE4sorKgBhBIy6/hNwytp2ZXfRybPhvETNp4XYMiFaRCk/MbN4buDsaaADzsQYn4sL9MtVw6wICYcJ15DS0m0QDDVHKXVWix929fg+mvzUoLyfJqFLD4Lz6U8N1Mrjs4NMWiar4UKWi5rvrwrjur3zcHHrq7eRqYlKYMHlEwt1Ai95AkUCoqzG4Z+A4ZCeXh55G6wg0rBx6BA2nCmdWyFR8t95dqa34G405nnaCdbvdgVgtIxLxq7xfQ7ePW2Xo95xmZpP1NA+R4LiUizfHrzr4+F5huXpK6/skO1gUKDo6UHTlArgP/qElTlv6zNttjsG79w9PyUwmWgxh4txZUuIIgOgjOFMfvLiL7dd0mSQOIjC3yFRFO0z4Lgzcd20RMmhrtWUGip/3uac/9zXKnALRQVnWWNFRse4si8ozrxsWvINshpzk+Tp/NadborwxDyQNsVopR9kJ5z4NcfkX9X1bsVDAgSVv93PshF7RzAja76823MPg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Rmt6VkVrZ2E3ZmlDM1VWZlBYdC9PT25Kd0J2bE5VdkhWaFNsdFJRZWRr?=
 =?iso-2022-jp?B?ZlJSaHF5cTJ4blMyV3k1Wko1N0hhTW90SFl2MDQxdVplZm9wdk9xYlVE?=
 =?iso-2022-jp?B?RFJkVkp6MzJpejNoZDMxaVVMVkpsV0VqN1lmU3JqTjNFd0NHOWp5allI?=
 =?iso-2022-jp?B?Wjg1MXREL0ZUbTVRWkVDb2hGS2RpdzI1TFRtZEtDM0hpK1BQTmtVYkRx?=
 =?iso-2022-jp?B?MUx6WjZxbEdwcEwzT0kyYnVYNU1wL1hQZWtNZGNqQXkxZmdNUUNzZDdC?=
 =?iso-2022-jp?B?ZmFBT1Z3UWlQTlRsMUFNWEFMMEIwUTJ4aTlHbHZkSktUV0hXU2Z4Q3Np?=
 =?iso-2022-jp?B?YnVhY3Y4WHQvRGtaaXBTazhPcmFhcy9hWndENloyQ3hmTnFFY0cxdXc3?=
 =?iso-2022-jp?B?dzFSYlRYc3FrMC8yQlAveW9hcEVycDBMdk1WalJZQVkyc3dub0xtcVNo?=
 =?iso-2022-jp?B?emREOTZtQ3ZReHlhNVZVbWF1NWQwWWJVNDZlNXYySytsZkZhQVordi85?=
 =?iso-2022-jp?B?VG1sSy9WVzNwVEtkQ05OUHJQNWRIUXQ3Q2loaUhrYVJoNERIZW91YzJH?=
 =?iso-2022-jp?B?WXY5ZFp1b01aaVljMXRYcUdDZWFDdXRkQTAzYzMrb2NhTmFOZlBzZERt?=
 =?iso-2022-jp?B?b2FTSUdDU0kwN2J3U0FKdVlOT0t2M3hqaTFBRG5wS3pLS1NLakZmcnRY?=
 =?iso-2022-jp?B?SUpxNmR6VG5WRTBsSHFJTUhoU0Vmb1pIbDlGaEJkaXhJWjI0TW1Zb1VG?=
 =?iso-2022-jp?B?YVkrUnF3V1VvNHdSRW93TW9pZktiWXhSd3ZnbDAyVGEzZ2JldURkSTRy?=
 =?iso-2022-jp?B?bDEvMldHTjVxa1pBeStkMEMwb0pqRjF0cHlENHBTSHFXdDVKVHhXNUZk?=
 =?iso-2022-jp?B?bkNMcmVrQ2ZMYUZSL2E2YkRvUDF0eG1mdFZqcFp4TnhrN0ozcnNkc2xr?=
 =?iso-2022-jp?B?eXJEWUtFMU1VdC9UQzRGYXJQWWlMdzhzZUVmM1gvb2ZjZy9FMWlLYkFQ?=
 =?iso-2022-jp?B?Nm1zVUlITktjTS9hbm9kNUMxbDB3QzByMXBBSHI2Zis3czF6TmFibVFn?=
 =?iso-2022-jp?B?QkdwQ2t4aVdlenZNUER3WGp3U1ZIYStwM3dMazQrWmVEaGVLd3hJdWpr?=
 =?iso-2022-jp?B?V0NXc3MrZWxCNUQya0lCdVJyWU01eHJmVTFQaVZMb3FLODlwNHdRbjIr?=
 =?iso-2022-jp?B?MUd3alVyVjY2THpVLzlvOTFCQWV2WVVSMXFNSVV5UitMNWFpNTBqY1dE?=
 =?iso-2022-jp?B?azBaNGpDYUdyMm9acG9BUEpSM2thcERXS0hrVDBNQnREdWpXdndaU2hL?=
 =?iso-2022-jp?B?QitOMmcydENwY0V1d1BiUFFEL2I3ckprTjVtQTFRWFpuQnVBYmljS2J5?=
 =?iso-2022-jp?B?YlpDUTJuSEdJNHRSeHo0R2FuSDg3R3d1RG5sbVBwamxUanREVElYSWg0?=
 =?iso-2022-jp?B?NzAxaEE5VUhjb1kzbVovYVZsbFlLRHRjenBhWFo5N2Q5UGh4S3lXTVh3?=
 =?iso-2022-jp?B?RXo5cVV5Mi9RdkM0YnBPbmw2a1NzdU4ybjhrdlZ4N1dWRHAwbk53bFBB?=
 =?iso-2022-jp?B?RWNHd2pSUmp1WHdsQUJIczRWdXVpSWNycUQrMWsyUWJOTzRzU2R0a1Bn?=
 =?iso-2022-jp?B?SWgycC8yZXp5ZjAzekdYT0NoMkVUaHdjNGxjaVVSSFpPMWZtZ2hETlFh?=
 =?iso-2022-jp?B?NStsRDlJekExT1N3cVduR0hPUngrR1FlZmMyMENrOENLcFNGc3JDbHov?=
 =?iso-2022-jp?B?eS9reGh4QW8wYzNTU25sWUFvbGJhRDZnWk5pdW96OVlHditicTExQVg1?=
 =?iso-2022-jp?B?Z0FRTHA4b1V6NWkwSTdGdTZEY1VTMGYzbGNOcmVCaERyUE5aQkMxWkhJ?=
 =?iso-2022-jp?B?TEdyWnI0bWE1VVdoOVNFWTI5NlFOb1p0bGRERFFCYVhMNHpnLzJreCts?=
 =?iso-2022-jp?B?UGZVU2d0UDRydnBWUHdaWlJNdHYyZHpmRFpyRTdpNkE3dVdMaVg1U2s2?=
 =?iso-2022-jp?B?M25TTDF6ZEJaNCtYWmhXTW9sbkwza09YK0l0NUJDMVQ2Z0xDcW1EY3BG?=
 =?iso-2022-jp?B?V1k0dkRsNGZJUlUwZDV2TEN1bEhQakxtWEJJRkNhTUk3eWp5bTBHSEhw?=
 =?iso-2022-jp?B?TlNKczlUSklOWkw5c0Z4TnFWWjREbm5SbUVYU2hoZE5lSGZ4REg0dElB?=
 =?iso-2022-jp?B?ZllhYVhlQmJaWVgzR2VIaTFxaW5lRUdIdWtlVG5ZWC9CbEs5WXNsaFJs?=
 =?iso-2022-jp?B?Y1lxM2k2Q3pTM0tFS0NCYXl4ZTJ3VUREdHpoYnpwUWpEeFRjWDJHUmc5?=
 =?iso-2022-jp?B?a1hmRnpWK1k4K3lXVE82bkZiNzV0d0pHZWROdmIyRm05KzA3a1hrSXhh?=
 =?iso-2022-jp?B?Q0FvaFc5REdKVUlLbDNYZFhZUHRIWGw0N0xOYm5sYjFqODlCblRnVHBT?=
 =?iso-2022-jp?B?UG9oOHk4QmF1R2tPcis4SWNtVHFHeGJIdFZ1NU5rMmxOTFVTVEdsK1Ev?=
 =?iso-2022-jp?B?bkFTdjhTZEZLTm9jc2thdGlkR1ZUR2tsV1d4QWpRSG10Rm9rRlZocy9h?=
 =?iso-2022-jp?B?cDdDdnlPVkl1QlJMOG1PeDJJYmcxdHNiTVlDNQ==?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Lc6/+OO/NFkDD3w6JiUJKxYb/uuV+znygnTerlHHIEFwWqJI4yQuRXmbT+Bm1VyUV+BWSIyqcGv2qcORvIkuzMxAWOgn4BIhqMevYLbZs+pPZ5C3aPvVzh01cp3DctSseoxUVBeIwCb+DR/8Dg0RoQko1xcNWnSlB5hwmhO+AZ1T6n+nMAnB2Xv+aQrqWnP66NOdd/1jFUrC05zp8uBdmEbDUdZKgwYJ74vbDm7hh0nzX2LG+g4jh5te5a2OhctKPTFEoALVB+HJuMRIssqkOD8R1Nd/Vs1+2f/9lKEcJggawO7ab+xN5hLshaQ0651yr9KEAHpQZqyoYCPXQ9sDyA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad8156a-2328-443c-9596-08dee70ab225
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 09:30:25.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyjN11lCZTz9d6T2fCR9NQi8Z6Y5RX1odgCrsXXxAU+MSppDzZBE6OV+xbVpgP4Sz1FzPBs4ZMupWGGpzbgCpPwc2ev8z88lNJ9qJC7VIYCNdW6NE2Lu90PZr0wqfoQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17465
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 03:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23705

Hi Quirin,=20

Thank you for the review.=20

> It would be better to pin the version for the previous version instead of=
 sid."=20

Does this mean keep SWUPDATE_LUA_VERSION =3D "5.5" and add version specific=
 variables like below?
=20
SWUPDATE_LUA_VERSION:trixie =3D "5.4"
SWUPDATE_LUA_VERSION:bookworm =3D "5.3"

Thanks & regards
Shivanand K

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Quirin Gylstorff via lists.cip-project.org
Sent: 20 July 2026 13:44
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/2] swupdate-handler-round=
robin: Keep Lua version 5.5 for sid

Hi,

On 7/20/26 6:59 AM, Kunijadar Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
> Update the Lua version to 5.5 as the SWUpdate package in sid checks=20
> the lua script at /usr/share/lua/5.5/
>=20
> Signed-off-by: Shivanand Kunijadar=20
> <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git=20
> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
> _0.1.bb=20
> b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
> _0.1.bb
> index e3cc7f8..3505a35 100644
> ---=20
> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
> _0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundr
> +++ obin_0.1.bb
> @@ -26,6 +26,7 @@ SRC_URI +=3D "${@('file://' + d.getVar('SWUPDATE_ROUND_=
ROBIN_HANDLER_CONFIG')) if
>   # The lua version used by swupdate to search for additional handler is =
hard coded in debian/rules
>   # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880=
bf0dac408d5db5de7e2de99/debian/rules#L13
>   SWUPDATE_LUA_VERSION ??=3D "5.4"
> +SWUPDATE_LUA_VERSION:sid =3D "5.5"
>   SWUPDATE_ADDITIONAL_LUA_VERSIONS ??=3D "5.3"

It would be better to pin the version for the previous version instead of s=
id.

Quirin
>  =20
>   do_prepare_build:append() {
>=20
>=20
>=20
>=20
>=20



