Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E3109E54C
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 04:57:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41370.1774501056113495981
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 21:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=XeuJrUBC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1774501053;x=1775710653;bh=zEtECRFWawSKyojm9klrfqjOQmddBbXPXTA4q
	4hB5zc=;b=XeuJrUBC4wNjpu7ocWoLxr1IDdASQlP+ch99D0PrYgczakRqxQASLN0GHl6mZrYSP9M
	AOzW31Rqsaw1QVcCOTidCJ3hn0dD6dAcI14Bmn/8C9UKizmZdPvX/7FIQLQehCqJFOyWqXYZ+W+A0
	ujJhO29uc9wWzHKXBQ1FmxqJXBh7gx2NrV/uBR5SfPeeN9LbvRR/5aoY147bZ37LiOXIbh9K1HdMg
	2GCLVsWrVsIiZRPFtSD8p0FeChcEI+AKm02hi04SNOSRX3ZOvF31A9Ij5ACwusPXJq/MgDVGB33fc
	Upp4zKi4Z2xmKXC5778sasIxNi2snOHwal9AUD8dV2Vg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 62Q4vWEV1331651; Thu, 26 Mar 2026 13:57:33 +0900
X-Iguazu-Qid: 2yAbiBABGuDgNBzpDf
X-Iguazu-QSIG: v=2; s=0; t=1774501052; q=2yAbiBABGuDgNBzpDf; m=Zjc5G3XGmXxjqHjWUX+HLA5tUmqtTT9Nwt3qjRM6U4Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fhBND21cGz1xnc; Thu, 26 Mar 2026 13:57:32 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifb8UxmuwWAXPedHaMdHI/30jXv0ssp8vqb7SZp6mtU9lYib4muH7iKyrO9cj0U5NOSDLIcR6wo2Ehi1SFGhuQOomVzl1Fq8Kq/ZsnO57NxdNT9LjJqdgwfPStALlw0eH1ist5CMklsjR3SxKy1stMWmmbGwkUdJPtsynQyVyDjZxy7zpq5W5J5UCPyWuc+WpjoCf68gil5Bo8McpbR01kl8XGlqRdw4fOZ+azspqwLG0QPq4bpz/wq/JRx2RlqEn5ak6iR8+DfP2ApeH8TN2IHojEZ4E8ilBeLYkN8XewgCDDgkpBgyAkOs2v99+IZfGEKZhl+YTl9DqvvSzter8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8hlzI4YI7MP4Ze/g5gLGXfIpKKzA6tL8JfLc+s3gfQ=;
 b=lknVuIQpHHOxccq3crN/u9CwsEyLchoY5WYTXCDk3vbd9XbVNfsZSie8WTDS3rWYGVd+GHcSkesHLbw5fhsCrYfHSZoz1qvfBi7nGwrHDHFzp1mNzAZupHUcCXDdpuflwMhlSupezbf/ZjnkDkQeT89Vz3Q+8mxKOeSqiwxr+kwiJLEcJp6xIXv/gc6SYABi5Q4O3FZ+e82rsfFrUKiyT6I8RUIrqdJN8CIxECAONoQvOv7RzxT2Q/KI0jVHUXcG2+zXJ0nfN6ze7U7NBbqNox5XM54VVOtmZykPvVLb7MTpKSBQrsqrR2blo5oSuBQ8WhAMvzCgkxu8iANZkS+Cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/35] Add USB and Ethernet support
 to RZ/T2H and RZ/N2H SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/35] Add USB and Ethernet support
 to RZ/T2H and RZ/N2H SoC
Thread-Index: AQHctVVsOuPiSaWPt0O/jxOV6dqiirW9dMSAgALaSaA=
Date: Thu, 26 Mar 2026 04:57:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188948D16FAD96DAF113BFCD56A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJXzZga4vox1MXo@duo.ucw.cz>
In-Reply-To: <acJXzZga4vox1MXo@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8171:EE_
x-ms-office365-filtering-correlation-id: b58279cf-f37d-4d27-e864-08de8af42d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 owA5IYLWrJcKknttb2FtrAoUULlFPU0KuWbheOZGRxPdgNYn2R10sWz7yIK1RxScv/XoO4v8dZ6H/vSkFrqz/7te7rqVgSp6MHza5UPI4BUURGX40ULcstA2HlI4P0Av0CQ4GlzoshiTtxmfSCGQCrQr40lsy5nOmli1HGwPDDF4dzxI9odr18zfZVgU5gJG5uqmUTGVDkFtvHjGZkXaC6QiFvwffF7GTrA7UFbgzYZucz/KQlwALciomlZWcZZCK81NF8KZ2lRoGmd6CuHcvbkrdxxTb9A1lFOq8XAn3g2x6px75AsmzYtZV0L37Bn0hGCNT9NmkDknPjqJq01W7WVwHgupT9Xpuu/V1wclxsjmPcod43nXBPNu2I44b+3GR1eQpRrm3v0jhQTtyow5JpFmO6i+BdM9gWy7xiPGQxJfiFCUS4FKpedTsj1UoFLkqsGOvGSMbRQkTaqXgdCMjuhUne4oOmYqX0eRKBK1L4uspqhHVws4goJrVlUaUaoqQYxcz9ZmhZ353b4o7rb1PazHyPWVUG17VAZ8/QkD/43iMZzDGeBYZeIHQWcGs0OBxkeKtmDHNkNo7SowHv0ttpQM4SRpB8IfR1YaQiLx4+8p8m/Wb0ts+x/o2gjPNzl5DBrR8Mtnj64F52K/LJWoKFLMnfcEdQc8ZgX2rjNu2VdtYH5nv2s7p6ACnroqQCMiy9kkH4WsgB6om1V0Quo3w/Q9B1zB2bYLgVHNpvB6NuWbzHgsRG0Zp8fm1CI8CDke/HwRhD+w8d2rAtRFs0p92Y7HZaSobulRhpcYq+Ros/U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZGlJam11VXpXUmg5SGdGVi8wUTR4bE5GU2hONVI0ODNRY3BhcWdhZlVl?=
 =?iso-2022-jp?B?ZVNwVFg2c3FuRmlKbDRaZHNxTzFzT3paeFRhZE9uNmtuekNZaGE4Mk52?=
 =?iso-2022-jp?B?akQ4clNMNCtERkN1VHhId1IvdFdHMWplVitOR2FnVzdkeXhoY1Z6am0z?=
 =?iso-2022-jp?B?d0VpSXRHYk1KZENFZkVTQUJmS2NmQnk1YVJTbWZWTWphQ21NdlFlS3lo?=
 =?iso-2022-jp?B?bngyR0ZxVWNFOTNxeXEvNXpTS0pnRWRITXdBQnYveVBVZGNGZ3ZNMFR4?=
 =?iso-2022-jp?B?U2NxVDZFcHE4MWZkdzlrYzlOa0djTDdWelU4TWVtSWVoOUpTR1JsVHds?=
 =?iso-2022-jp?B?aXhWT1ZMV3J3dGZJUlFXTnF6bllFNU9JTDBvMXcyak5zODNOakNnOXlt?=
 =?iso-2022-jp?B?UHpxcjhoeWh4KzVWcmV2cDFZTEExSnlaQkt1dTJvdnB6Mnl1ZHU2eGFK?=
 =?iso-2022-jp?B?OFlWLzFPckZadFZmTzhERUNvY3V6cjJYV1E4ejRHd2xZZHJPaDJNZHN3?=
 =?iso-2022-jp?B?TjZ5M0NKeEpjUGRpd0Z0dkYxOWZHeTJCNGhKMTJwRzBzU2diSGhTaXR6?=
 =?iso-2022-jp?B?cGo0NkRKVC96Q3E4RGw0VDRRT00zWndxd2J5ME05blFlSCtvaktWaFdZ?=
 =?iso-2022-jp?B?NkYzU3RvUDg5M0dtUFJqTnZGcWErQnlaMG1WbGZJZS9wMFRDa0VFOGU3?=
 =?iso-2022-jp?B?SlBLNlR1OFBraitIUGhjYTI0U2lzYytUUUpCaG5XOEdxM1h2ZnQvVHB3?=
 =?iso-2022-jp?B?L3BJWkVDSlh2dGlhWVNSN1pmOXc4MTRaQ3Y5eGtnN2hHOVdYMjlGb2Vw?=
 =?iso-2022-jp?B?ejNrLzBMQTc4d2tXWEliNWRpcEtHUi9LcXNma0VkMnZWQjBNL2gxNUls?=
 =?iso-2022-jp?B?T0RlclRhN0oxeDE1RXJLSk1kOG9jdFdsSzUrSmpUV1dVbjN6eVY4Z3dN?=
 =?iso-2022-jp?B?OHBtL2xSZjFWUWZHMlVYT0RLdkFzNUFiY3FvZTFHaXhZWllKMUFod0NZ?=
 =?iso-2022-jp?B?azhKUmFIUmN2OFI1d3c0QzY3Y1c2cytsTmRIWnBNRzB3SGgxZ1QyYTc3?=
 =?iso-2022-jp?B?VVNYU1FqakxWMVNVV2xyMmZCVXhxQk51MFVhRU5sNGFqTy9zVG1tZ2pn?=
 =?iso-2022-jp?B?UGJwRCtMK3lrZlFDbmZVamxGQnVjU0NsRXlpdnREVlJsRlV4eDAyYWZP?=
 =?iso-2022-jp?B?VGtaanhvZnBZK25ENm1QL21IZVV5SmhWWlZmV3lUZE5ZaEJodHlHZk5C?=
 =?iso-2022-jp?B?R2QxWnVJaXRHTlgxKzZGV0wrZ1VTNjYvSmtKTm1wczZyU0oySnplVHdW?=
 =?iso-2022-jp?B?Vm50aVdTb0kyb281dDZDMTlKbU82ZzlHN0Q1SHU1aXNoUCtORDFqbjdR?=
 =?iso-2022-jp?B?S3lUMkp2Zno3Mm5jSU1obHNJTEFsL3pYNGFRS2hGRHhyUStSN1VBNHVi?=
 =?iso-2022-jp?B?M2ZMVndma2U3SFlWTkhyNDFBTVV1ZGZzbkd1YWJyc2g4Skh6d2lIb2F0?=
 =?iso-2022-jp?B?cFMxenBqSjZFbUpieDUrS1U1NzVOUUZaT0hIeEpDMTNMRjFlbktvRHhO?=
 =?iso-2022-jp?B?QjdOWEFxUWtDdEZ1RXpmUmlNYjFXbXVXZisrNWlwT3pKNXpLbGltQ2sv?=
 =?iso-2022-jp?B?aGxyM0RkNUVSSkM4eHZzYm5nWGhaMmFNWUxUSWtlVkcydEN5eU10VERl?=
 =?iso-2022-jp?B?SXBORTBUWjJDT21TVlNNSytlenMzY2NtMEJlMHgxYTMvbkw3TEo3TWFl?=
 =?iso-2022-jp?B?TS8yR1ZqcFd2UkJjRTNiU0hld0FPUDFzbVZIT3RpMUUrU0hwVklWZVRu?=
 =?iso-2022-jp?B?NkxMWUNsUWpaaTVxZVRUditiRmlNWWs5Y0dvOVdlMk10dDZSZGM5UTZu?=
 =?iso-2022-jp?B?YTNIMExVcGpzc0IwRElvUHB1YTR3QzB4SjJ4YkhEK1JBSXpydS9xTG9q?=
 =?iso-2022-jp?B?VllmdEZjOVpIVVNjVUxCd2ZxbFVJckxIQmxxVllCUDlHVFFOUFViWXJl?=
 =?iso-2022-jp?B?aTdSaTg1TlRlS0IzRThRZGNTWFNSeloyR0hBT0d1MGFJM2VDcGxMU2lK?=
 =?iso-2022-jp?B?cHpDQkRGdHJDKzd1MHpGVDRlVHd0bEpRQm9aR3hzWmZ4OURtTW9POHJZ?=
 =?iso-2022-jp?B?b3NyMnZxdDFIeFVBb3lBMjZnei9OUXJzd3NMc0lBRHh4R1hTQk90VUxV?=
 =?iso-2022-jp?B?Zzc4cXo1WS9teGhLZ0NlVm5DMXZUb0VWRk1pbkt4NWkybysrOTJqNDFh?=
 =?iso-2022-jp?B?UjZpcXFzKytwWHZDbDBlZVgwTXRKbkwwT3RuZnMvaXlKa1V4QWtBZVRM?=
 =?iso-2022-jp?B?UXZOd3VVME9UNURHaFdGMGZXeEVKdVZSNmNCK24xT2xKdFRML21yZDJ0?=
 =?iso-2022-jp?B?c2FjdUNsZTZ6dWFmajJwaGM4aEcrekJwcHBrYzFVMnN1UlI5bnR6T0xO?=
 =?iso-2022-jp?B?eXBXWkhJR1hwYWhEbFZFSGg5QjA0RjNOREhtRVg4TFoyTTlxTlR6N3JI?=
 =?iso-2022-jp?B?cTZVdUJwVEljSjAreXUrSEFHc0lnbnV5bXN4TEgzZ3RkZFRLY0J0ejBt?=
 =?iso-2022-jp?B?ZkFkTWYyWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	mk1NSewbsxVGaInYYzUKg/EwUHOWy6TD9uS8nTS01/PbA+pupOK+GlsQzaaH09SyRjYXFIDPKqmtNL9U8pgHhkgwf2tMgEYoybii9pH9U+Tef4v0WYq0CRtlGGyhwi2AA8d33XcoijzbykSqZtoLAoMRB0Iln6dCf+yND4lYybHduqBdX+EgJw63t1NDxdk3sIQMZXSsVwC2o/3fyYkoVxjZTH5ceYbrBDjhHPQd+Kb+0zbpkdkOxwl3hNm3FbTl7UWZ/PcdZnmMujkO74gyFbnlz6X84wlUX9ykcElF0Uqp4svxXZkw3m9q78UshqgoW7IZOtTavjGXcA1gW8+ZcQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58279cf-f37d-4d27-e864-08de8af42d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 04:57:27.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIr7i1Bb7O6Z+Ydo4bF04WE7NVqtzIFccFX00F14Lx7jEI3/A3MYlTjTxEy5RdusbFka6j8URncunQZnCOhDSAKB/5Jvpk25L4Jd6nOCiEdO4l/3Iprbyl2gWRZSAJRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 04:57:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22574

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, March 24, 2026 6:22 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/35] Add USB and Ethernet supp=
ort to RZ/T2H and RZ/N2H SoC
>=20
> Hi!
>=20
> > This patch series aims to add USB and Ethernet support to the RZ/T2H
> > and RZ/N2H SoCs and enable support for it on the EVKs respectively.
> > This also includes clock support for enabling these peripherals note
> > there is additional clock patch for SCI-SC5 which I have included as
> > part of this series which was supposed to be ideally sent during [0]
> > was sent out.
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst, so they should not block the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, there are no major issues to point out.
I applied with Pavel's Reviewed-by tag.


> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


