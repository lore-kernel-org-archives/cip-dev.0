Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1AEC87FD3
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 03:31:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.web10.86207.1753721480270083528
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 09:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SQxcm1EE;
 spf=pass (domain: siemens.com, ip: 40.107.130.21, mailfrom: nicusor.huhulea@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1uSileRcraSxyFWH/PzGFxZZJw9GySdX81eoB4qukVkacc/nPBfQ/uBKbwBiG2MoaahNqkEZ2Ewj85oX/qc9jAsrSlysAc+3y2i81mDGTRVx/Rwn6mOhDuLa5UGkhQHYbayaT3lIFVdz8zuPIcP/GQzANZDvxq9mQof0N2HOp8oLNWT5TRfztosuKuwkACeQcpowfFZxgy/bJjrvCEhmcBtmzeZuoKM3LKpYBrZ/reBKX78vYWr+I5WFHSmoLVVsqMZEH4KNIyOhXK4h5JLqT97gDbV1sjmsWbItmbCHBmLJxs1QXT9Rr28QxLi48wlRc0xGJL6/FDas50SgEPBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5eqVEOs6G8C7jMylfdYT+y7QcrH6YIE6W6G9UrjB1I=;
 b=U/InhtKITFN6Bxo/DTSH2vEY9sP9tz7S+gE8DHls7xTBcUJoqJvAVb9NYY1vcInaJ3O1DEnodYwtdoY8TsYgXgLp2ilvPODXWLznpiIoN/jduzjKbDkMD3AFDeePyvaHDNaaa7Byb2ngj/bH1bisHZEstWt29cJrz6GH0XuUgJKx1xrkc2fr0Oylixjyb8FvRRDsXJPGNlMhWZM/DWPOdEzdUMytihQFHXg5jr+fluCVMBY92wBt5EfLpBJgj8rLPMDIDbvlTyG5hzp/+I/gD2xqy2B7B4zfnnIktX4aAw/FQUQm8pNLklkQGCh+XuMoDDfA7d+0uf1bYvKRFlu8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5eqVEOs6G8C7jMylfdYT+y7QcrH6YIE6W6G9UrjB1I=;
 b=SQxcm1EE6NPCr2lgXbnOOI4sMvkDQj8NCyr4+VpIXeMLBLfAaSiLyy2EK3LhdSfBZYPUSyw6g2XIgkeQtVaiJtRSlFza9JNzGd/4d8ii2XEUHAoXPhfc+UoAThtdE9DAgIBCclHyKydp8O5HNAd6dsZp6Awp6amtMDh5ObYOklL+QnZ2GiJmybZTftZ8zlRQfYWLK89PweJHwgDTyBPzsGABIrdnG7Egf2bWXkNaMmDOJrWIVpR7WHtZHymgWJNmYeHSeuqJOl8GtuhTHrGVCuIhkx6N1c8iwD1gTrEFDKZHw0eIsfdhuVaYDxHVn2g1KFzEulnp4xtgXewtvUJjDg==
Received: from PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:320::17)
 by DU0PR10MB6276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 16:51:16 +0000
Received: from PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::24f8:f8c0:8ad6:66cc]) by PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::24f8:f8c0:8ad6:66cc%6]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 16:51:15 +0000
From: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot
 Plug Detection and build/runtime issues
Thread-Index: AQHb+9D1JO3MDz459UKk3bu5fHleZbRCAZ0AgAXF3cA=
Date: Mon, 28 Jul 2025 16:51:15 +0000
Message-ID: 
 <PAVPR10MB6910DE8D76C096B0CC614868E65AA@PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
 <TY7PR01MB148183384926CD579DA7618F89259A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148183384926CD579DA7618F89259A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-07-28T16:51:15.459Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR10MB6910:EE_|DU0PR10MB6276:EE_
x-ms-office365-filtering-correlation-id: 93f0f863-4722-428e-e8be-08ddcdf6f7aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?M+6i+Aqcvvel7z33OtRZynOe77Q1hsI6TOMERpgoc7hLeozcIf7jA7Mh9v?=
 =?iso-8859-1?Q?NrjN+y8EkdbyMkrytBJcgWeqpcpPeQbkWlTcCx7XR4O5XlozejvYYVF3P6?=
 =?iso-8859-1?Q?BHUY/TaVKdr34Sb+yHXeJ8TdlkZf35kzkyIH/68sOTW/XBtko6JBbb0xHN?=
 =?iso-8859-1?Q?FMK1eRtsRUHoVAl1GNshX2lRYSa2xzLyhGXprToNzouq0R3uNTz6w/Furn?=
 =?iso-8859-1?Q?wMiYmLmtLRePFIgnTtPuY1biuHkHcGtz9ngL1j1888GqVrG+k0R55nEP8b?=
 =?iso-8859-1?Q?OMAeOQPyxCcG2bxAUnwFjWW1xHvXpEU0PxTbcmjFGNC6xd1wq1uN3RSxcB?=
 =?iso-8859-1?Q?BZoVVpNqh2/IaW4GwJQj7PgyGRhf6p+kAt7RMVf5rqF7FKVCIubZzawXL3?=
 =?iso-8859-1?Q?FEN9F8EUSFwsd8CV3DibKWvEppiU2Wuw9m3YCCxu6FOIuw5bWQDXPStZzq?=
 =?iso-8859-1?Q?/Na8h5kQtgKtnr04QFd1oSuDFVxTJIU6UMQod39PWtaYE3wBliyBQ7eck+?=
 =?iso-8859-1?Q?YQWlnGFvqqlLp8LmEVra1e/IDO8f4ECivQ3a7yhPjwvj9uSWBNfMPudhI4?=
 =?iso-8859-1?Q?DV+w14tRr1g99gVep3anEIq1FsMJ9UI/vRGl+gjoNPDi4fAPJ7e7EBWOGG?=
 =?iso-8859-1?Q?5ZFlrl+upGprtIr/2uuRgeo71SDIem6sjdaWBfz03lOvp+rHXmHukzvaDH?=
 =?iso-8859-1?Q?IXsu9Hf87r6akowimfXXhApMnCVv+F+LJK4D2gvz8U2WumZzngGqkqfx6U?=
 =?iso-8859-1?Q?0qb/OqBv0JCBZH5ZbqMnMeMWIKyotYuv0riBSzFGlgE9RfcDn9jxTqdoli?=
 =?iso-8859-1?Q?Mt8KtiB4Id+Oc41UMe2yLuOaps7tB1DDpVW42SIGCSQNZVCS24b3hgxXre?=
 =?iso-8859-1?Q?galHhtoKhs62QAEnhU97gsEB21pUNvwwleUtTtG0vC2YS5Zh/+zlgjqLFO?=
 =?iso-8859-1?Q?U9UXvhz7x5IIwAq7eLjuG5KGPqMZhN7bdTxFRnWiG0JugVEWyxbTEJyU9m?=
 =?iso-8859-1?Q?JdPqXPi1/tnEW6Ek394aaqVIN66PoBSgk4OPWuowPML5d94NtniEZl3X2W?=
 =?iso-8859-1?Q?tF+Oow8BmoRfRASxdScs+BACUIgSRuCivolDP4BeMjCXtqf9TDYpwd984X?=
 =?iso-8859-1?Q?T9JkkF1SV5ZrlPX511q0RY2QxozfVc3exUGRC3Vcw4vYOMphrPGtU4Ymvs?=
 =?iso-8859-1?Q?uV2wN90ZOiJGmxW0D19140cVIkH6vMaanVtH0ZnFKKQ9AWcdB6mHT1cvwn?=
 =?iso-8859-1?Q?MpgprUoUZO5KpDtzvOKxdH6aM0i0IyZGM1bx0HTr66MLa/KNPFIVmz/E5a?=
 =?iso-8859-1?Q?/FlfvzjaFvL9aaDsIyo0nxuJvDilh3kCn48P2bPpTV5ZaRvSpAHJPti4m8?=
 =?iso-8859-1?Q?ykIoj53cERb2bpk0AGmQclf74jsJkMXepfexClyhdjPNSuxSv/J31ZQNwB?=
 =?iso-8859-1?Q?BYYJQQzwd9VQH9yeIz3ob+tHl8CGzrOk3si7a2qZEldYDDf5wHXKInY1rD?=
 =?iso-8859-1?Q?w0bcIC1/kmYkRV25f1MCQkgtsFsY2zuchjVzZTdLMHgQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ZfRDNXY1gDJPzyEgKqlrm0GMTPTv7i7shmgERxbZn7qJvqiDsqkW8ZTd/m?=
 =?iso-8859-1?Q?He8Etae6MHwL17pR0MFiQoZ+kop/AI+YNTs3LXe9uK3/7bdG+dm5fk6dWM?=
 =?iso-8859-1?Q?5y8Z/QSXb7i2sVkZfgbDY3qd1ej8sBsUQmKzcAGAZRLhoF7PBW/NuGzSie?=
 =?iso-8859-1?Q?xjixLbXQ4bo+T1LKKDoJqjTLFt5QiZghcbpM9oq6QVUtIF46B7zsJzP4UZ?=
 =?iso-8859-1?Q?f2XIv8YEM1xjpfaWqBrJJPWDlx0VAZKe65a5vadBS0cc77I96cZYbmX3YB?=
 =?iso-8859-1?Q?jqu9Skg4oEdMWTY0acNivc6MmPyvKU9zRf0riIINNdRODHWKYDNVRi8To8?=
 =?iso-8859-1?Q?qmlWnSFdpM8Ya/y4JCWWM6sX/2L3MgC+dpWC8Tu2/jDpXN+YtZrqPWYyr8?=
 =?iso-8859-1?Q?g3d23LQbx+vPARHjEGF5zc+9XRHfKHXLIyASFrn1qwP9IrlaTHMudEzp0q?=
 =?iso-8859-1?Q?huzIyL3I/FtpDc1N1Z4YTdaeZk+9cmCtNAdHDZbBPVO90PasXE1cmbtJiB?=
 =?iso-8859-1?Q?t8KZPCyjhpBdQsrTz9hNNIVCDSb8NvoHKP0CTlTyM5Rm8GOvXXUo7mKnOZ?=
 =?iso-8859-1?Q?rwTTLFFTISqIDtgEu9LKHd5zo86uMwZRGffEzA3K0p4RPy0bYZrUw9r1um?=
 =?iso-8859-1?Q?uHKLBOPH9q488X/lf2uEFn3tlQ5wTBzhxdlpIAYtz1tBIkng3vSUitywt9?=
 =?iso-8859-1?Q?7WTnZ0TEdzkaKkSOlXJZbiqZi4u7lUVBtfHN6Fg7NNm482Q5bKnWL2DNKZ?=
 =?iso-8859-1?Q?tpLhNP92zAJI+fIaCDbmLWtiHKQ6QIXthiSxCudNyMTILnd4+HQu+RDXoF?=
 =?iso-8859-1?Q?c+1x9Oqc9GAT/o1VrHcW4FEO7vSda3Pc89TOWZwjB5BAdyqY05bqWHueXT?=
 =?iso-8859-1?Q?zD+PkeB2FSFa3NEwuDaf5ZCMG6A7xtk1doTpps+J2otzU3YxrDf9i6q/aP?=
 =?iso-8859-1?Q?X8wdo/lgavG8ZQOyJ/UkXiHKLCwM/oNW0Ox4AthxvOGsamjBhE+d5tJCXb?=
 =?iso-8859-1?Q?I1NVghJcTvNAAN1h9J3IOZGaPHEcLAjToMlbfHuwFj6qXCw3SR5l2eguD3?=
 =?iso-8859-1?Q?aOsO9QqT9GWM1/gkbeluuY3MHqydkxfjuc0taERR77mV04kUEDIgQogIeV?=
 =?iso-8859-1?Q?5F3cyzJBzsN1U5OSzd17Z2YcF8YBj6RfU6XqvQruGh50EgDjJLkWoVHA5g?=
 =?iso-8859-1?Q?Moh0HU7dxPiTsipVXIMwjqQCQdPUgywhdrcru/GeLyadrKbs3sKRpRUO1F?=
 =?iso-8859-1?Q?meuGPqD4d/eA4zwnWiBOMduSWK7RrSb9wD6AP2jUz8nhS0c3S5ATBwzV1a?=
 =?iso-8859-1?Q?377yQZi7LRophU5FUHQzdE4VhN7kMuPVKnxrXGOgcBKviEj11ZHHUw93da?=
 =?iso-8859-1?Q?gOCVDi9AysGF0wjiaQ98Ku3VAg/IztobXPygqgBMx0UM+tPT93pQe3fzEN?=
 =?iso-8859-1?Q?JITCfQSB5Hib/s+OjD/f4omqp2bE+5PxmphnHeaGSTGFm+wnADd2ZAself?=
 =?iso-8859-1?Q?O/na9u4mBS11yddGWriy8kQptp+QKGn0u25jBO7q44OAKAE0xv5YlmZYb/?=
 =?iso-8859-1?Q?+KYzEdV3wz5+ZPWam9rnG77Iw+8ab/4UiNA/ZwNgzWfDXzo29XHIrmupow?=
 =?iso-8859-1?Q?aw1/aGndIjBLMy8IWp1YvNy1sFxDlbLSEK?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f0f863-4722-428e-e8be-08ddcdf6f7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 16:51:15.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTYGU41+IFO+w/YLCIeWG4n2ncyqtNeR9uVJ3tsCQPL+R0ro5KV9HpQlTAyTlY0mSahnlPjLpahQqcfdB9wizsj7zYKG2Vm4nMwil1V4Ryw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6276
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Aug 2025 03:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19712

=0A=
=0A=
=0A=
________________________________________=0A=
From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>=
=0A=
Sent: Friday, July 25, 2025 3:39 AM=0A=
To: Huhulea, Nicusor Liviu (FT FDS CES LX PBU 1); cip-dev@lists.cip-project=
.org=0A=
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot P=
lug Detection and build/runtime issues=0A=
=0A=
Hi Nicusor,=0A=
=0A=
Thank you for the patch.=0A=
I've looked at this patch and it looks like a fix that's needed not just fo=
r CIP=0A=
but also for the stable tree.=0A=
Please send these to the stable mailing list instead of the CIP.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
=0A=
=0A=
Thank you for your review. I will resubmit the series to the stable soon.=
=0A=
I took the liberty of doing another round of tests on stable=0A=
=0A=
> -----Original Message-----=0A=
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=0A=
> Behalf Of Nicusor Huhulea via lists.cip-project.org=0A=
> Sent: Wednesday, July 23, 2025 9:54 PM=0A=
> To: cip-dev@lists.cip-project.org=0A=
> Cc: Nicusor Huhulea <nicusor.huhulea@siemens.com>=0A=
> Subject: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plu=
g=0A=
> Detection and build/runtime issues=0A=
>=0A=
> Hello maintainers,=0A=
>=0A=
> This series addresses a defect observed on certain hardware platforms usi=
ng=0A=
> Linux kernel 6.1.127 with the i915 driver. The issue concerns hot plug de=
tection=0A=
> (HPD) logic, leading to unreliable or missed detection events on affected=
=0A=
> hardware. This is happening on some specific devices.=0A=
>=0A=
> ### Background=0A=
>=0A=
> Issue:=0A=
>     On Simatic IPC227E, we observed unreliable or missing hot plug detect=
ion=0A=
> events, while on Simatic IPC227G (otherwise similar platform), expected h=
ot=0A=
> plug behavior was maintained.=0A=
> Affected kernel:=0A=
>     Most of the tests were conducted on 6.1.127 (manual/standalone kernel=
=0A=
> build, CIP/Isar context). But it also happens on 6.1.145-cip44 Root cause=
=0A=
> analysis:=0A=
>     Through testing and diagnostics, it appears that the HPD finite state=
=0A=
> machine or polling logic in kernel 6.1.127 is marginal for this edge case=
. Device=0A=
> IPC227E's behavior triggers=0A=
>     this kernel edge case, likely due to slight variations in signal inte=
grity,=0A=
> electrical margins, or internal component timing.=0A=
>     Simatic IPC227G, functions as expected, possibly due to cleaner elect=
rical=0A=
> signaling or more optimal timing characteristics, thus avoiding the trigg=
ering=0A=
> condition.=0A=
> Summary:=0A=
>     This points to a hardware-software interaction where kernel code assu=
mes=0A=
> nicer signaling or margins than IPC227E is able to provide, exposing logi=
c gaps=0A=
> not visible on more robust hardware.=0A=
>=0A=
> ### Patches=0A=
>=0A=
> Patches 1-4:=0A=
>     - Partial backports of upstream commits; only the relevant logic or f=
ixes are=0A=
> applied, with other code omitted due to downstream divergence.=0A=
> Patch 5:=0A=
>     - Additional modifications to ensure the driver builds and resolves=
=0A=
> run-time issues=0A=
>     - Contains cherry-picked logic plus context/compatibility amendments =
as=0A=
> needed.=0A=
>     - Together these fixes greatly improve reliability of hotplug detecti=
on on=0A=
> both devices, with no regression detected in our setups.=0A=
>=0A=
> Thank you for your review,=0A=
> Nicusor Liviu Huhulea=0A=
>=0A=
> This patch series contains the following changes:=0A=
>=0A=
> Dmitry Baryshkov (2):=0A=
>   [PARTIAL BACKPORT]drm/probe_helper: extract two helper functions=0A=
>   [PARTIAL BACKPORT]drm/probe-helper: enable and disable HPD on=0A=
>     connectors=0A=
>=0A=
> Imre Deak (2):=0A=
>   [PARTIAL BACKPORT]drm/i915: Fix HPD polling, reenabling the output=0A=
>     poll work as needed=0A=
>   [PARTIAL BACKPORT]drm: Add an HPD poll helper to reschedule the poll=0A=
>     work=0A=
>=0A=
> Nicusor Huhulea (1):=0A=
>   [PARTIAL BACKPORT]fixes for i915 Hot Plug Detection and build/runtime=
=0A=
>     issues=0A=
>=0A=
>  drivers/gpu/drm/drm_probe_helper.c           | 125=0A=
> ++++++++++++++-----=0A=
>  drivers/gpu/drm/i915/display/intel_hotplug.c |   4 +-=0A=
>  include/drm/drm_modeset_helper_vtables.h     |  22 ++++=0A=
>  include/drm/drm_probe_helper.h               |   1 +=0A=
>  4 files changed, 118 insertions(+), 34 deletions(-)=0A=
>=0A=
> --=0A=
> 2.39.2=0A=

