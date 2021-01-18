Return-Path: <SRS0=tvkc=GV=lists.cip-project.org=bounce+64572+6109+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2874C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 22:10:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CE122CB1
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 22:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CE122CB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6109+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KMK5YY4521723xu1bFzEFtqO; Mon, 18 Jan 2021 14:10:12 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.105])
 by mx.groups.io with SMTP id smtpd.web10.3018.1611007811184840394
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 14:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeLQaK/qr+d4YqEcTppiTCJyxOhOr3/uGudzzo2IpeKhK/L53MohMqe38QaPxPGKop0PGtHMxITMdtBMkBQB6wNHU4TlU0C51C02cF4Tb5Y+V2BkiriOctLtL7gQ3Ep4NLG4pnPgO5IpSjO1An7BDi6uyLOgMkLEJdr+uUBDx9WjUeM/cg6+0yuUEiBZa2rnWH1qXbG45FAuf4UJmgFRTW5ZmkKlwkSsYSAVt3FA7ZTdXvj4eusfnJRquWPm9ImB9ymOo3+dgRFg8e614wlZDn5K9PtT0IGhKl1MMA0zX74eSotrX+LpA1HmZ/kACpxMV/hDUC3T5o0YaENUm1Qn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou/KzlRaPz31B+iPu0c7VgQyhhRsk/anvAUAvnxo3kw=;
 b=DIOWGuleilOyGQWKTl0QyMvl+FfoNxwGzRPx8k7dnVNEG485p99XSnx7VkrtXxYuyUBEjXHxO2WZhZG0dxQ7Q2CBFyRD2d8lcRA/9U45o2AotP3d2P4TEIZ0jxXx02MJ8hvLfbxuV8vDwXQ2jkZ4ddh+Tz7oZGSUULKYJCRtJdJzcsTiykm9PWh46qjn0XtjB1WLhS2PsdE6qEXJ3dZM3qAoPcqoKbhzUzb7M1sWzd60j+y4mzfHV73Cm8boUyhUzVBY7471q4Nveg9VGu4y/xHQS61eTM6rbUwdXm1gBECZj98zMcjhMh2XUW+uFNeHuWE89F+07OMRCP/3ziQ39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2228.jpnprd01.prod.outlook.com (2603:1096:603:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 22:10:05 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 22:10:05 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Quirin
 Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/4] update linux kernels
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 3/4] update linux kernels
Thread-Index: AQHW7auOMQJrnUv9kkeNNLVNwX/9Mqotp+CAgABJLBA=
Date: Mon, 18 Jan 2021 22:10:05 +0000
Message-ID: 
 <OSAPR01MB2385E11214EA1D725FE28E22B7A40@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210118150625.20155-1-Quirin.Gylstorff@siemens.com>
 <20210118150625.20155-4-Quirin.Gylstorff@siemens.com>
 <2d49cabe-6069-c09c-d82e-d03ae3b3c937@siemens.com>
In-Reply-To: <2d49cabe-6069-c09c-d82e-d03ae3b3c937@siemens.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e80ef61-2c13-4c77-b3cf-08d8bbfdcf9d
x-ms-traffictypediagnostic: OSAPR01MB2228:
x-microsoft-antispam-prvs: 
 <OSAPR01MB22286E1469580298279B6C79B7A40@OSAPR01MB2228.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 n1dVWJ1omm8AGa/ijzhJG5sjoYvtIDQqlEmYy5/Er22JzZa5+LFn/0Wxo8Gv8osMzQ4wqLpzVoJY5EwmRAZ0S2ovBrvsrV6aJUmJap8D+jASEQtPMNfJAtw99BR07o8lYgzb/D22YehgHFjefsWvZrVqduYBC2cpIx/qlSYxp289C/z0w85A4GTLB2JyKi0vVhf/2IWjUyKhs1RPN8k7TjVEmj99FQw3U7fzeGOs+D3DHCPxnrPAYQDcSQ2Y75jBHxhA44sXi1o/OyHm1D+0ZMDHEjGp8t5VofxKpKw0G1D6bTR9vLIlFnWE6/7zkP5Dmjlge2TF+5R9cNRd36STuNAZRHfutUbZXWKLn/yUQOWZ9G1TPvTeyU4mb5yblmLBy/vlWubxD44A2TUKLtoeuIjrr0VXOM2mvossD6pvH0JHKYRfiR5Xb5ujU+nrssPd9y69Jix13fcUtDWQExXY7Q==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?8aAZ8RJhzZVVbhdLh0HbjYBZEECuj4yjEaSJf1G8t1vJ25UmEempW7BF?=
 =?Windows-1252?Q?QmWh3HJy5zdPRLgWXAdqgedgBKbTFC7vgV3bAX3U6pFKsZv+kYBcx3Lb?=
 =?Windows-1252?Q?86LERCNWQPhj1jGUq3xvsi7gvk63mJNOH90zfSrEJmjCqAsywf5lb+4D?=
 =?Windows-1252?Q?DyVBGZV5YWFa5s1pZ0stEIqACs8RzdhH9Cgw8SDFZbZnzBHHDzCpk7hT?=
 =?Windows-1252?Q?gAx+hOU+R0DgMC0Ghpeg5pMjP9+s2uvYY7srrdugEshsBq9jmdM90yxd?=
 =?Windows-1252?Q?Be5VvA7AeaE1LipzrxjwYrUpsGd51X5EIyEmAEfZsm7SCshDZ930dD0B?=
 =?Windows-1252?Q?1M23Op9Il5l9+Y3NWLZQiUD6RjsuHgcNINLWLqvVtXPTV9eVdV44sml0?=
 =?Windows-1252?Q?a2T3vvFHTX+B3Vjn7Mh0iqAsI9MMC2bF9js3pj8ivm4YMQr7M/MOn/T6?=
 =?Windows-1252?Q?qgtEXcVeVesQ3QtkL+ayrqeV/BZfRY6xsjhu05OSq7dY7RkDFSeCruMS?=
 =?Windows-1252?Q?3dauA48JXX5Xr62Rf/RwLomItOOn2UpmI9CNjp6AztaNf49rIDJMyPa8?=
 =?Windows-1252?Q?/s7p6J2xWVxjZkyhz0o5h86JokMOQvESY+5vTYXj+8mYAPXqLI+boTKJ?=
 =?Windows-1252?Q?Lqlxsyl+qnlU8n2i30/4w08rjE6+pb6ewRss6cHMbRfYUzId7+flaCQN?=
 =?Windows-1252?Q?9xeYAJrS1Lhg6/tN6+Roe+iV21JBcrKYDfkun/vcZD+1pZMERx94OiOj?=
 =?Windows-1252?Q?cECNnr+qKkd46+FAPjh9p8DoIP7pHlRi7T2FGqXyGud3kPjcDQqFsAH1?=
 =?Windows-1252?Q?18qYukaaKXfH9AvrEs2xSFi3NJmeeLN2MF//WW+EEuc2YbhXEWr6F7Z6?=
 =?Windows-1252?Q?YhM7/YqdpXj4yfCuJ+VIRYWznsXW5kijdmf9vaWGDeeh0zXpjOLa9xaS?=
 =?Windows-1252?Q?c3XJYs/t0Eu/XtFEVHM371sdrcTZW3lD4qqZDK5y9D1mFTaUvaCDS5hV?=
 =?Windows-1252?Q?6anPBvVanYIlG5QoiY+U0IGijLfbuGdiLwc8+HIDImap/mTTWJI=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e80ef61-2c13-4c77-b3cf-08d8bbfdcf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 22:10:05.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BY2aocNjam3GBABv0ucpD1Y44Qame/1q2yL0AVhYAovevp0hz0kIVY/1a9ArfuvR/br5EKLZLGxPE+VSZTWW046WgtXTWVDFUiFLATzn4Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2228
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k7lTxyNKGozWynCgpcvkWYXex4520388AA=
Content-Type: multipart/mixed; boundary="Ajnyd0lFEOaGybaEcb3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611007812;
 bh=qhcgjw/8X+P1jrPMr+/ar3aRM+TykTmt+bXYoHiPmTI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=j3h1ZpxE2U4/N+y/aBXPA77SPoET0yQ5+VugF3KFUELHtQw1QwuO0MKW6U/C2v9H402
 IYzmxoNhb4eUFBSQdwMDMLIpKGZ3+IFIyoVEO2lSp0SoPOXpTe1m+N0qhcPTQQHHRD5ut
 BfyWzD+WA+PVfaOHRdgOGbNftXTZ85WXxUE=

--Ajnyd0lFEOaGybaEcb3c
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 18 January 2021 17:45
>=20
> On 18.01.21 16:06, Quirin Gylstorff wrote:
> > From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >
> > Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > ---
> >  ....135-cip31-rt13.bb =3D> linux-cip-rt_4.19.160-cip39-rt17.bb} | 4 ++=
--
> >  ...4.231-cip47-rt30.bb =3D> linux-cip-rt_4.4.244.cip51-rt32.bb} | 4 ++=
--
> >  ...inux-cip_4.19.140-cip33.bb =3D> linux-cip_4.19.165-cip41.bb} | 4 ++=
--
> >  ...{linux-cip_4.4.230-cip47.bb =3D> linux-cip_4.4.249-cip53.bb} | 4 ++=
--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >  rename recipes-kernel/linux/{linux-cip-rt_4.19.135-cip31-rt13.bb =3D> =
linux-
> cip-rt_4.19.160-cip39-rt17.bb} (54%)
> >  rename recipes-kernel/linux/{linux-cip-rt_4.4.231-cip47-rt30.bb =3D> l=
inux-
> cip-rt_4.4.244.cip51-rt32.bb} (54%)

This is where the issue is.
The new filename is using a '.' instead of a '-'.
i.e.
- linux-cip-rt_4.4.244.cip51-rt32.bb
+ linux-cip-rt_4.4.244-cip51-rt32.bb
=20
Kind regards, Chris

> >  rename recipes-kernel/linux/{linux-cip_4.19.140-cip33.bb =3D> linux-
> cip_4.19.165-cip41.bb} (53%)
> >  rename recipes-kernel/linux/{linux-cip_4.4.230-cip47.bb =3D> linux-
> cip_4.4.249-cip53.bb} (53%)
> >
> > diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
> b/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
> > similarity index 54%
> > rename from recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
> > rename to recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
> > index 820c1ab..3c0aea5 100644
> > --- a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
> > +++ b/recipes-kernel/linux/linux-cip-rt_4.19.160-cip39-rt17.bb
> > @@ -1,7 +1,7 @@
> >  #
> >  # CIP Core, generic profile
> >  #
> > -# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Siemens AG, 2019 - 2021
> >  #
> >  # Authors:
> >  #  Jan Kiszka <jan.kiszka@siemens.com>
> > @@ -11,4 +11,4 @@
> >
> >  require linux-cip-rt-common.inc
> >
> > -SRC_URI[sha256sum] =3D
> "b827f45b8f97b71b3917c84b43fd6593030d01ea7261d3be6c15a76250308743"
> > +SRC_URI[sha256sum] =3D
> "c2e0f50670c298aed94c35628caf4ddf0eefc20d2f17e0a5f024bf4d99a38460"
> > diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
> b/recipes-kernel/linux/linux-cip-rt_4.4.244.cip51-rt32.bb
> > similarity index 54%
> > rename from recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
> > rename to recipes-kernel/linux/linux-cip-rt_4.4.244.cip51-rt32.bb
> > index e13fc14..6679144 100644
> > --- a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
> > +++ b/recipes-kernel/linux/linux-cip-rt_4.4.244.cip51-rt32.bb
> > @@ -1,7 +1,7 @@
> >  #
> >  # CIP Core, generic profile
> >  #
> > -# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Siemens AG, 2019 - 2021
> >  #
> >  # Authors:
> >  #  Jan Kiszka <jan.kiszka@siemens.com>
> > @@ -11,4 +11,4 @@
> >
> >  require linux-cip-rt-common.inc
> >
> > -SRC_URI[sha256sum] =3D
> "e7a0c7b8e4d91f52cbc2ee17a546d1afbc5fcfed95ba44dd113e534fab3a157e"
> > +SRC_URI[sha256sum] =3D
> "070dc2084d2a64c1c8d64382978ec01ed7875b012401d09f37428a9c8c52b9c3"
> > diff --git a/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb b/recipes=
-
> kernel/linux/linux-cip_4.19.165-cip41.bb
> > similarity index 53%
> > rename from recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
> > rename to recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
> > index 9e958c0..f19b4c3 100644
> > --- a/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
> > +++ b/recipes-kernel/linux/linux-cip_4.19.165-cip41.bb
> > @@ -1,7 +1,7 @@
> >  #
> >  # CIP Core, generic profile
> >  #
> > -# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Siemens AG, 2019 - 2021
> >  #
> >  # Authors:
> >  #  Jan Kiszka <jan.kiszka@siemens.com>
> > @@ -11,4 +11,4 @@
> >
> >  require linux-cip-common.inc
> >
> > -SRC_URI[sha256sum] =3D
> "f6a9aec6848a5897c90bafda5a9eba010c03d5d0cf99508adfb1cf7a2f4af9e5"
> > +SRC_URI[sha256sum] =3D
> "c1404d0a0a1ba71656c237d6d606714d34364814dc9a3998add93fe1749cb27d"
> > diff --git a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb b/recipes-
> kernel/linux/linux-cip_4.4.249-cip53.bb
> > similarity index 53%
> > rename from recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
> > rename to recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
> > index af49441..03b1a04 100644
> > --- a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
> > +++ b/recipes-kernel/linux/linux-cip_4.4.249-cip53.bb
> > @@ -1,7 +1,7 @@
> >  #
> >  # CIP Core, generic profile
> >  #
> > -# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Siemens AG, 2019 - 2021
> >  #
> >  # Authors:
> >  #  Jan Kiszka <jan.kiszka@siemens.com>
> > @@ -11,4 +11,4 @@
> >
> >  require linux-cip-common.inc
> >
> > -SRC_URI[sha256sum] =3D
> "3ff33e497064ba8e7d9b5e1ee575c6a936154fa8216774782cbc0db2e4b71cdf"
> > +SRC_URI[sha256sum] =3D
> "f8a6eba35572da13c81fec6c2d451db8f75b0ab4a5b6b80113523fbb035bf384"
> >
> >
>=20
> Something is still broken, see
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-
> %2Fjobs%2F970301333&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.
> com%7C28b00c4b88d546dfe5c208d8bbd8c261%7C53d82571da1947e49cb4625
> a166a4a2a%7C0%7C0%7C637465886945464208%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3D60fmWcwX%2FRGooW3onB1r%2FdJlkuwQXiAo9o
> xY5Idr1vg%3D&amp;reserved=3D0
> and
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-
> %2Fjobs%2F970301342&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.
> com%7C28b00c4b88d546dfe5c208d8bbd8c261%7C53d82571da1947e49cb4625
> a166a4a2a%7C0%7C0%7C637465886945464208%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3DGAcUIsBs9yp9%2B3mtcmoRTXmRDM8VwW3bE%
> 2F1hEWMpl%2Bg%3D&amp;reserved=3D0.
>=20
> Pulling this patch out of next for now.
>=20
> Jan
>=20
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

--Ajnyd0lFEOaGybaEcb3c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6109): https://lists.cip-project.org/g/cip-dev/message=
/6109
Mute This Topic: https://lists.cip-project.org/mt/79924717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Ajnyd0lFEOaGybaEcb3c--
