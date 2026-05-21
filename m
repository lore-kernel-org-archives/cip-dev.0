Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E8ACD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 18:37:38 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.894.1779388648444697529
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 11:37:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pGcCMi4k;
 spf=pass (domain: renesas.com, ip: 40.107.74.5, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XY6kpzxclPERmcFFws8PsCVTDIzpRNUzLuMfHyiT+xneZqZonqUnNZpmMBRVrd4vrfNiSurickj6HAfiqhAvsrzdsELEbQzT9vx5LcjnmdGXdEocwUxN7PaKou+WDTrmoE80utV1ltPaDkcQlwgZS9jMs16vW+co5/caNg7svT0PGliY9QzjDmrcJ6YfghPZqef55TnpMNezKFMlBXMB2KmIZPqIE8X7WtvYpeULg8T5aSDCn7HOKxwf3EnjGcLrAicOOJn4SS3ZUl1FwpJnONAIw+hktAQ6s9wvpNYyDdqyVRHWshNn/eOqTnQcxYOZ/3n4x4iBZkcmETjGOvb2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du8i1d5o4P/fExZ7ZerEelR9M2C4r1Uov76zOFetE3w=;
 b=NG9X7fwuV4qdAYDgLoLRqsqD/WUc3X2SRjoPnDwfCETAOjTZkfzgR4L4xzK8tQIEP+VHW4wlqofLGXUhQZ9Gl7f+uYeUX0H0n8pk289yZ/jy6hK7XGsV8to/7nQeuLW1fhLudFqTMU5TGyjkqv9u2f1FOEVABP02/NX+RcrLL1TbRyK89ApNrvqxthWR5flkEhF4FAc0bLHpT1bmxbPhQuqbfWHXpnjC8cUzy4XVEL83t1eDID+I9vzqqVQ/J21m0SKXJySC07hs5aogucti49c8XeI9rcc9JXSO8uJ3P6rSw87Gcmn0LzvnxzzcPvTKLPms84EFbsRWGZxO4T9b3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du8i1d5o4P/fExZ7ZerEelR9M2C4r1Uov76zOFetE3w=;
 b=pGcCMi4kJ+4Hm0o02I4b+edSt+A7+J00HRJflByS6j4tkaiYLAEU84knN6pLGGsZGn1bQ99ZNQWneZLg9C64RXAABGdos6MO+pIf6xoZOidfWHyvGZw7zfMA52CFe85JV29ZzWlT/fy5k9/Hxa0MlyhH+2UZaO7OCWnhVsMLfsI=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS9PR01MB17519.jpnprd01.prod.outlook.com (2603:1096:604:44b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 18:37:24 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 18:37:24 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, cip-dev
	<cip-dev@lists.cip-project.org>
Subject: RE: CIP LAVA maintenance
Thread-Topic: CIP LAVA maintenance
Thread-Index: Adzo+JuHBZ5/iHf/SfWB9OFwxLDj9wAWCAEw
Date: Thu, 21 May 2026 18:37:24 +0000
Message-ID: 
 <OSZPR01MB8123FEAF029F43D90E9522CEB70E2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <18B1861DAB679118.3012052@lists.cip-project.org>
In-Reply-To: <18B1861DAB679118.3012052@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS9PR01MB17519:EE_
x-ms-office365-filtering-correlation-id: 86386ae5-e22c-47e7-4ebb-08deb7680056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 M5qUvz8Kdhfozqod0TiKYCgIfynOWSv52MuKslN78AgQJo0uQYRk4i/kNZF6z4/aM7nT1YeZvckm/e8ucbQB0nLyvrsFGIh1XlpEDTNCb3DsexDpaGGi4yuiPvu+isM03ui0z0Y/GiMRaNwmV+bdwWvlUMU/z2tiQOpzUr/JIfnV5YAOEjf+6qIvbStCltgJYHeVqrdqpAyk2uzLhazU/33gGDtLveP+NZtVxwrSuERq9caNCr6fQ9n8jddThOo+0mwEeWPLGwtx0bR6tFPk0wBCLlZnHWgPndhb628N0QU1OaPEBhXzYKNuDFKCaPG8UQ48b8P4HqYycwcpYJmA9rRLokYYX58VN2MhgXc+zPVdnjV9wiYsqUfFKIe+ik40Tb610VhUUJ5kWFhKddnhf4udiRJwkKlcgBE+EHlJ1Gp0zh5JCI8r56zzCpJiPmn4G46h2CtviBe0YNr1D8IMVCg/4BVPE2w0CDvNzdErvNFx1+shwopMrCjLvZn4EaYzi5hcnO0sjj3va1d38X69eJfFO4/TbKSZaWyQhusuEXczypQS35CJ0MMVZ91hrxVNZDBb1iV+Kne4csX+MWf7CTyGr/tIu1aJiaWQeCCNiMLXS8mX62lpuSQ5/vkT+R9VBhOpfHtWA7Z6TiBAVpsGCJ75IymoBCUj4K4dzuwt4fRVQqDbLK4cf+hRGcvtverjLgApOGfI+a/fpK6UI5K8nknJjbSbplWLazfbCWG2mVKUE6X4UklTkniEhuO1zg2G
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?MxoHS52bRtlFoB+xzCF+sgb8kx8C1cOlHZmqMIqN45FiTBcOnhO4u/Nk?=
 =?Windows-1252?Q?0xXEaoG8IOudPBWDI3GnzHDLhNjd/3S/DCaBSS3c5QGUApQF+vhlEF2b?=
 =?Windows-1252?Q?DST1zaqvuk0/plAuT0OfDXXg7V54pbqj0Y4+7Eu2dpGevv030pTpoS2W?=
 =?Windows-1252?Q?LYDT/1NzEZk1f1LxrSWmcSvsQ3uR+b+YE2+m9hA5gfmbJC6ZpwQ+Sp02?=
 =?Windows-1252?Q?h/zrCQm/ji2+UlRcgXmM3EazO2KIGKSWofZWwbW42XQu4WSBn3mwyq7j?=
 =?Windows-1252?Q?RIobW25Lddmvg++bXqNRYPxAgNrt6rEvJ1akT125go5qYtJcx6/pshG6?=
 =?Windows-1252?Q?uy4Ut1JT5NqF3Pq05/PkdA3Sl6Tvez8W7bHNZiIob1figo8HyTVXcN6O?=
 =?Windows-1252?Q?5al0cnIz8PLnr/H9rxVrMAiTcCmkBJUBEkyFkM0bYhE9mp0FkHenNPfN?=
 =?Windows-1252?Q?eo7XGebaHoOIeNmL8ea2TzKSZ3vp/pSu/MWw729tXfPbHyyunada5mth?=
 =?Windows-1252?Q?WQ/yfrK5EjHGdzNgmMDW3EIX9KIwgZ4ZbZYlG1WgkCSoZ4Jy3Fq8RB+Y?=
 =?Windows-1252?Q?ZRNCIefPr+BG18bknR04YeUHwSAogoXNrx1qulZXThSnfyA/h1qtXTKn?=
 =?Windows-1252?Q?A1Q0F5lvYaqs+DDlwRAgeae+SFAFxLkx0+w6uoP7C9Z29RP3t9fm5uzo?=
 =?Windows-1252?Q?rQ7bg9EdHGGXFgoTDCZKwUNxct/1KFxVlA66S6N2+tLJbP+Q1XSBJOTV?=
 =?Windows-1252?Q?Ntd+A10OTGCTJboYA/6z/ZP2VkBSLfrQl84BGxAbcRmPsfFgdMEAO9X8?=
 =?Windows-1252?Q?pCs1rAL/5ZLPzG5RYScoAOprDBeqUeCH5SLRMmk/7/rtBI5O3hijceMt?=
 =?Windows-1252?Q?LIP3W2HghXgxOplZlI62buJIPFkw7QJTfRdJUrYuHOkdaEkk9sD9Yl6C?=
 =?Windows-1252?Q?5a6n9atmFNJyJV0AQKMGSooqPhnxzBPoJwCTC/PcNB5e+GHKdS1pg2sl?=
 =?Windows-1252?Q?mGojN88kRUkrARmmVMdCkaVuG2nXxA35XmHCek2H6ZQantsP0XHEGx7B?=
 =?Windows-1252?Q?xnVbICiRALMljnkRTWmFbptn9WNVaZGVRQpU1bKZSY9Moo4tTkd/PYI0?=
 =?Windows-1252?Q?7DAKn0eCPtBksv94Kv9ZwDnj34a0UGY0meZUUUcxMaJIiUXI4ziljlO8?=
 =?Windows-1252?Q?Ml5EKAZlZytSWHo8LO5IP2UL4N265XgrbuhJfys2pvtGLIuYEtjSclPO?=
 =?Windows-1252?Q?ptzuNPFMTiA4nSUPP7D23dQk7x28zgplhc+Zvm1ntPxVfc+MlSUk+ELU?=
 =?Windows-1252?Q?isuyphhVSDcRr5PRpy2JJakMqooaWDDSC834l0z5n/0BZLcmdBT2L6Ca?=
 =?Windows-1252?Q?NbAYQzv8OqYTAKW6SGoMCE1PrP5cL2jMvQZySUGNZpAHV3mYOPgVf65N?=
 =?Windows-1252?Q?FOpAobOKgarNUaemNMF74s28q/n7I+njkcDpPNHw59ru37yofI+T95tt?=
 =?Windows-1252?Q?x+Ydxhs7eHOPPUlHUIiUr8mc93Q8d+zCodCDi02PpNrdkndNg9NGafyI?=
 =?Windows-1252?Q?ugj1MkWcUd2x3FLtauqd7VVGa5rDhfs4f8g46EhY4zadS09TTVuuF9Ky?=
 =?Windows-1252?Q?ip4HOr5kgo+jCw2esVzsB00bt+b2J7FumJ8QJaRHXWu3mSMwkpLF9ecN?=
 =?Windows-1252?Q?a56N3+kv7v+5WCrMlasNJM3zai1iS/FpD8wuSakbv/NqPVHLudt0Tv07?=
 =?Windows-1252?Q?FKY1VsbeCh3cqgPNZkS4s5hPrjFEcTxZxZQTWMfx0ezmHAOcHGdlMkiD?=
 =?Windows-1252?Q?aqcWhCiTVl822ue6tx0wv15jAjcLpFz0HfHPGWmXGSKty7WCOG8kMKbL?=
 =?Windows-1252?Q?Ij/vaOKBmBBw8A=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86386ae5-e22c-47e7-4ebb-08deb7680056
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 18:37:24.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1LuGaAEyg65tjbI7SymJ5MAPbLFdIv3/hW4NktoWb5Mu8L4iwd1tbbxepyfMX9T4FbuYQRAak0QaLy6ACI5k4jJGBZclsgJklQRSZYb5r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17519
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 18:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22993

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 21 May 2026 09:06
>=20
> Hello all,
>=20
> Just to let you know that the CIP LAVA server will be down for maintenanc=
e
> and an upgrade, starting at 0900 UTC today.
> Apologies for any disruption this may cause.

Just an update.
The server is back online.
The labs will come online as soon as the lab admins can upgrade.

Kind regards, Chris


