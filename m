Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31346CCF9EB
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 02:33:33 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (SEYPR02CU001.outbound.protection.outlook.com [40.107.44.35])
 by mx.groups.io with SMTP id smtpd.web01.3330.1761732671378951403
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 03:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aJQVFjtZ;
 spf=pass (domain: siemens.com, ip: 40.107.44.35, mailfrom: ranjana.teli@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK9OWhxVt+IuBAAmBhoYwzCJvrgCM5bDR8X+m8uSi29cwhjvsiFU9qDbVoxBvaZ5pJDBaoCJ/e73Btr1B0kwTs7IxwXK0m5UxRfrhd3g6lXdTAr1GI0Hm1suwYViLiTKjyFgdzhH4RJnIPp2KHqae4HIW0Va47hk4L5Szr0SZ3weJInygo2mDvG5lzfSNRcZPcsCjJ50pf0xyYbHjQGn4Acme4xJvl1Y1ExKF/To+EmcUczl7FrMwi61edUw22NOfh9ZpSyc+baNE/a9fOPtPHwUHzyca5qTgjv0jB+1460zkRXGVZwy7Upifkx3mcyfJxt8kiSXTGJIVi9g2cJhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu9AX3/JYrYb4GMXxNt+R5n2sHggtkLUnnoH7X8STog=;
 b=kEkrWCfFowEK+wIpcVRPuLdXaCHn1ghGSexZa26G2tspQh7Uhr1j9l39zcecmxN87muusslciWBZ99s2RzonfhTRueoelf9c0k4QV7PvrfS3Jctrjx1M7f3DsAQ7PZOgRLTWFAMydwpUu41YZdIMjS9rwLqTBYG25wC083QwEKDFI3YMwlIHgVWznAFd3lxCweyuDxRgKHEDVnYb+0ThbX85RrQeassW9CwQiMHnM9fjBt/pA2MIdTINSpAO8YxXh3Vpgy/yd7KI7Phdq4kb0DTaAx8p/AGfw4QAM3Sw4weRD+LDFkitb27SBWSVqmOhoCzEiXQo6MvTZV3XCKjjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu9AX3/JYrYb4GMXxNt+R5n2sHggtkLUnnoH7X8STog=;
 b=aJQVFjtZPmK/mCFi/p2s02S2Mhu4j0tNuObsZ0RjVhW3CVIfwx12/NEDDnfc++HzkcmZmIxQWVLDCIX09s762/W5VEHWJ90R4Rv7c7NBg2eXI1cYhvlDG6s9wtNST8kXsZ/Uo+vFXHoNn70HZZ6Cqn6U+wVWouCTfbe2OSOEkWQ8vesTyZ1tysHgV7rarklWWE42YFy1ElcjkbfKpBhMMdJX/QMLO86HM1fBdjQAokDFW3MrekNtHFZY52GmUD1D2Wn1oQlnfaTUn38iHYejvicEYvWb0uKwEu4GnggOuyWKD5w+8eitzly2ra/t8DWDocu/2X+Ynw9w+D4sD0Cnog==
Received: from TYZPR06MB7583.apcprd06.prod.outlook.com (2603:1096:405:d4::14)
 by TYZPR06MB6748.apcprd06.prod.outlook.com (2603:1096:400:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:56:21 +0000
Received: from TYZPR06MB7583.apcprd06.prod.outlook.com
 ([fe80::936b:9a42:1e5f:6396]) by TYZPR06MB7583.apcprd06.prod.outlook.com
 ([fe80::936b:9a42:1e5f:6396%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 09:56:21 +0000
From: "Teli, Ranjana" <ranjana.teli@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: isar-cip-core: swupdate process fails on trixie builds
Thread-Topic: isar-cip-core: swupdate process fails on trixie builds
Thread-Index: AQHcSLgUmd5Sb+KMdkihwPXAirho+g==
Date: Wed, 29 Oct 2025 09:56:21 +0000
Message-ID: 
 <TYZPR06MB758380BBC1865D10C891850F9CFAA@TYZPR06MB7583.apcprd06.prod.outlook.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-10-29T09:56:20.798Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7583:EE_|TYZPR06MB6748:EE_
x-ms-office365-filtering-correlation-id: 820cd51c-e167-48d2-464f-08de16d169cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|31052699007|39142699007|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?AhpzaJy1y4qh143+YZ+mDN7rlc3sCjIOJ7UrJapHUVlu0AgMo7VMYbLxPG?=
 =?iso-8859-1?Q?yUYKi4E1VUUxNsRtZX6fdVqnpqbUkSdZHkzf2dAcg12s85CxG0nGNjH0eH?=
 =?iso-8859-1?Q?SPL6rc36KOd6EjVsPZmdpOdj6MyXwZjsoef/YhxKf3Ogoa5djDiikZKPpp?=
 =?iso-8859-1?Q?eemMizOyGXCpfjOq7k6JfDOUm421oYz7qmYXM9MqfBaWMSGUs0Z5308q92?=
 =?iso-8859-1?Q?9Ox/nTD8muUT2VLKAw1dr4QCzVzBdh36P0X+xVf/E9DkvagMbIrsL7JUXz?=
 =?iso-8859-1?Q?RyDBWZW1Q8TS+0J96Jwv+4cW8Bx32Y/+Hs9nrTL0xuYm2dMYuUhLcLU39B?=
 =?iso-8859-1?Q?vaybAlFnsv0SGinwFeAP8UKVBae6UOZCbs7SBcWIaARCP4O1E+gPhTkUXZ?=
 =?iso-8859-1?Q?mvfM/P+5WYT2n2DfvnEQfw3d5fTYRfrzvgqCa786FoVXW6YMQVDlEOFeST?=
 =?iso-8859-1?Q?jqO4BYltuj9LSHBUoVVqnBZC6Y2laNBmBIF/R0Pdad0tGP+yItj4HJseAV?=
 =?iso-8859-1?Q?5cSgE65JO3gciXDhYzAc6RFnaa2/XjoE77/8u2ngOYRvIxTD6SUb7PD+Bq?=
 =?iso-8859-1?Q?7w/yRKTws9TLJcWfTyuj4AbhqKM+2kCSHTHbX+gzZhnClvmsF8B3WSf1LF?=
 =?iso-8859-1?Q?N6V0chPsDS3FasmzazoI7M60FWvoNW80fKhxc1kIv85JdE5YBT5SfLpy7m?=
 =?iso-8859-1?Q?yzQZF3LspyhP5DBcePcNr71PUseJPWdI+KqgJQLvTWyTRaD+ABN7zAMCmZ?=
 =?iso-8859-1?Q?88997QbwkU63++GncKYc8AK95QzUaOoGx2NY9RRYaKCfJSQ7kWL3FfYPgD?=
 =?iso-8859-1?Q?HOqoeWcgXlibrC/mu/MIBBKEPjo3r16jEmzej/TeB5LoNANiJEMjdzSKni?=
 =?iso-8859-1?Q?5gB7tyDrttWRjxKMX8rscs5Gmn/TPU5yna2JrbHehL5guITRYsB+GOCwTh?=
 =?iso-8859-1?Q?7CuOJMdXxgIvvCwOnYL0wdmv3Xo4qrk3Qvjo+rSXPpFamEryIOX62dBW8d?=
 =?iso-8859-1?Q?qUeW+qCWRQlrzaNiYjL3Fi6WVtn8Zqmnt8GSjJhFq9s3b5axoJwpAY5b6+?=
 =?iso-8859-1?Q?2YOvfYEFXeKs4hoTz0guG0RFfHxNe+VpyaFF48UNXxGuLLvpam2XIP00o0?=
 =?iso-8859-1?Q?frhq7BaIbM0roaW+fYzUS0EMO5MBbNafHs+uYJXDI7b5D0dBg4SAGJ/lae?=
 =?iso-8859-1?Q?yan3PqsZUUCqDgnkxogKDJjRtS6z8rYGTaDEbEl+3ounUTnpGK9fvXDZd6?=
 =?iso-8859-1?Q?572gYtlBeyNwmYakNtMKI0IbMJ9OV78a+Xtio8YxBaeNt3SQDLIzWZHYTF?=
 =?iso-8859-1?Q?XBcQQ0Yi/kSg/gKK6UkOq4j6Akcmdwrdk25hZalm//k/5frrY+RPvGgjaC?=
 =?iso-8859-1?Q?bla9rzF7zIaf5oPaln9wBC+lnwlh8LhC7K6Xc3wka1pH8QNiwbbvINVBjO?=
 =?iso-8859-1?Q?by0MP/mM8JuqmxF99gWgfeyMogDWe0qcq0QXhr9MaiX38cV+rR0pOxSdmi?=
 =?iso-8859-1?Q?tCu8x6Xzq9QoRfJ1Y6XuGthVgFlW/BwB8M6CQ368L4Z9ho5B8+H7lywHoa?=
 =?iso-8859-1?Q?dpb1LXcu+tyXj6w0g0UgF2owgifD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7583.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(31052699007)(39142699007)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?THHTbjt1DgJpRiR46LciZYJ9z+e7/0W7BXuzMynjk09Gvmhn8SVvodI+gT?=
 =?iso-8859-1?Q?Ltj6WAZu8Dbb2UTL2t85LppzSG1Sxl5/lYkjh2cjNSCf6LyITIyY8rBbo1?=
 =?iso-8859-1?Q?cx1RVU1BvtugpA6NllbZlH2mZPGDrOmeAMN0fdnjnDIRPwprCeNnHrL67l?=
 =?iso-8859-1?Q?p2KQVWNCtKmHYGI11sIPoN4KGvTgnLuLNHD0ryIpZlxb8shQo6tm9ybhDJ?=
 =?iso-8859-1?Q?tRGWgcfN4Q+1CQXT8VsOWjP0CsTr3LQii9Xgp8ta4xt8sofyIpwr1ULlVm?=
 =?iso-8859-1?Q?Uk99Cz1THhohuMJmFcb9TZHz6EMa3cMBfxaFlwCbnA1gwVxUDEiA0IpowZ?=
 =?iso-8859-1?Q?jENJwxgqdS4M7+Qf59HEyIY8HxtnxLVPWcVrdR3FCmOxO8fMaDCIK5PIgd?=
 =?iso-8859-1?Q?NVkA6mVNOG/6kkx4sTuMDGVHj84BeT6UZDXWhGXlu6wSZnpu5wXCCFx5tB?=
 =?iso-8859-1?Q?K82Y+YmjQFYNGflYbM1iB5dsowN2UN+l+tDfXoDeXENSvhKn4xiN2htiJb?=
 =?iso-8859-1?Q?M8XKEyJbOcopJeWiMSYAKVTvHjahdy6yaPqQyAGxZlumtdEXBxhZn7SJSc?=
 =?iso-8859-1?Q?o8gdAN+H3sscn2RlcExgkt5le+BFL3S3j//e+qsnoR/3DQiCKW3Xp/QgBi?=
 =?iso-8859-1?Q?HKiLodiuQL3juSwGxYTvTm0M4a1y07YU5RlCM1Hb6PqoXQJQebjQiwfWPf?=
 =?iso-8859-1?Q?DoqAYyQYQjmEcG7Ga58K0ICLHWV65sgsJEUzdPKfCpkbjmCea95g+O3ZQM?=
 =?iso-8859-1?Q?h3rGBNUnwXH9yJU0UDDZevoUnDDUcnz02+kSyIDNJwpohIbZZSp2qaIH6U?=
 =?iso-8859-1?Q?Ob7Gl760jmw1Z118Wyn5Tg3ygcFPp3GiJGskWHboeTKNEWjxIPQQXvny88?=
 =?iso-8859-1?Q?we4ktm54BzhvxEJChCxtbQEWJIVKkPAwxxCUd1fsLV9si69YPiureckkqE?=
 =?iso-8859-1?Q?8WP9szpw8tfr8D8KXASWPr06E3PF4VWgYIhBafZRzH3B7gDPpykXneOnH9?=
 =?iso-8859-1?Q?0ZWkD5vPOFsv9lzyy8Ox9uZdm4yxKqoZ4vkwv/2IQ6GZVHru2FXkZ70lDN?=
 =?iso-8859-1?Q?NEMxdAVDJjQFkHPHyHo6Wk517WAtIPQZTijAI91Rn2PG0u/Am45h7HFPLy?=
 =?iso-8859-1?Q?xdND034cuZB+SLRn3yx3BLEA9R5HwLAfugBMhl5NACDwyb4m9ZT1l9c8qQ?=
 =?iso-8859-1?Q?KIuqHuhdXmZC/GUObFcpuYk7UXxqbsXvx5T7HJYxgL9q/BDqzJCryYeSJz?=
 =?iso-8859-1?Q?Sa1zrHtMifyr7xhzeaDnk4eFpCVtwF1aY95NbCeslLiMvIe78CO+h/JXzj?=
 =?iso-8859-1?Q?nD1Ca8ongqTs4QYlM6TVzjk/8OHG+x/pqInj6hK0ONW3dPUzaeJF9wLN/X?=
 =?iso-8859-1?Q?H5yOtRdko42FcBs0A7gx1zotWitc0PFfazsFvRTsn/lVZEyZ34RNAjErnQ?=
 =?iso-8859-1?Q?2dPqP2RXEHBhnBlxHGVTX2PZo8Ziy8f9QCLEjceS6mIcgyI+j1adkw53+B?=
 =?iso-8859-1?Q?AqI+PdEzn5e1h8+ZRJc0k06eQNvUyIrc044LIzpk+cqVrD2prA7IuzLIX1?=
 =?iso-8859-1?Q?PdbhQ5U1xGBxJm78YBdVtKF2K2UwZhonp8j9nXpSdRQbNGc/CgOhMKb/w1?=
 =?iso-8859-1?Q?z9eRFZaS4M/2/OM0j+sjfmyHG0UDyeEl/j?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7583.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820cd51c-e167-48d2-464f-08de16d169cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:56:21.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HphNwiP41Q8+Btz+dFtiOWpDkEDDTzagorE1ja7NctUx2nAT1sz9yRjgNOndahuFEEXlgM8t6PyiU9bMNrRzsaJ+OooIHnWJONNisr0Hs1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6748
Content-Language: en-IN
Content-Type: multipart/mixed;
	boundary="_004_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 02:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20278

--_004_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_
Content-Type: multipart/alternative;
	boundary="_000_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_"

--_000_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,
SWUpdate on trixie builds failing with pre-built Debian's SWUpdate [ 2024.1=
2] package.
Steps to reproduce:

  1.
Build the base image with SWUpdate feature:

$ ./kas-container build kas-cip.yml:kas/board/x86-uefi.yml:kas/opt/ebg-swu.=
yml:kas/opt/trixie.yml

  2.
After successful build, copy the image artifacts to a separate location:

build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-x86-uefi.wi=
c
build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-x86-uefi.wi=
c.wic.bmap

$ mkdir base-image
$ cp build/tmp/deploy/images/x86-uefi/wic* base-image/

  1.
Rebuild the image with the rt kernel as part of the modifications for the u=
pdate-image:

     $ ./kas-container --ssh-dir ~/.ssh/ build kas-cip.yml:kas/board/x86-ue=
fi.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/rt.yml

  1.  After successful build, the update image will be available as:

      build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-x86-u=
efi.swu

  1.  Boot the SIMATIC IPC device with the base image and apply swupdate wi=
th the generated update image

Result:
The SWUpdate process failed with "swupdate_async_start returns -1" error me=
ssage.
Attached file is a detailed log of the observed error.
Findings:
The same update process was tested using selfbuilt swupdate as done for boo=
kworm [ SWUpdate 2023.12 ] on the Trixie build, and the update completed su=
ccessfully without any errors.

Regards,
Ranjana Teli

--_000_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
Hi Jan,</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
SWUpdate on trixie builds failing with pre-built Debian's SWUpdate [ 2024.1=
2] package.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
<b>Steps to reproduce:</b></div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<ol style=3D"direction: ltr;" data-sourcepos=3D"3:1-18:0" start=3D"1">
<li style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation" c=
lass=3D"elementToProof">
Build the base image with SWUpdate feature:</div>
<pre role=3D"presentation" class=3D"elementToProof" id=3D"code-818"><div cl=
ass=3D"elementToProof"><code>$ ./kas-container build kas-cip.yml:kas/board/=
x86-uefi.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml</code></div></pre>
</li><li style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10p=
t; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation" c=
lass=3D"elementToProof">
After successful build, copy the image artifacts to a separate location:</d=
iv>
<pre role=3D"presentation" class=3D"elementToProof" id=3D"code-819"><div cl=
ass=3D"elementToProof"><code>build/tmp/deploy/images/x86-uefi/cip-core-imag=
e-cip-core-trixie-x86-uefi.wic=0A=
build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-x86-uefi.wi=
c.wic.bmap=0A=
=0A=
$ mkdir base-image=0A=
$ cp build/tmp/deploy/images/x86-uefi/wic* base-image/</code></div></pre>
</li></ol>
</blockquote>
<ol style=3D"direction: ltr;" data-sourcepos=3D"3:1-18:0" start=3D"3">
<li style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation" c=
lass=3D"elementToProof">
Rebuild the image with the rt kernel as part of the modifications for the u=
pdate-image:</div>
</li></ol>
<pre class=3D"elementToProof" id=3D"code-820"><blockquote style=3D"margin-l=
eft: 0.8ex; padding-left: 1ex; border-left: 3px solid rgb(200, 200, 200);" =
class=3D"elementToProof"><div style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof"><cod=
e>     $ ./kas-container --ssh-dir ~/.ssh/ build kas-cip.yml:kas/board/x86-=
uefi.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/rt.yml</code></div>=
</blockquote></pre>
<ol style=3D"direction: ltr;" data-sourcepos=3D"23:1-24:0" start=3D"4">
<li style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
After successful build, the update image will be available as:</li></ol>
<pre class=3D"elementToProof" id=3D"code-821"><blockquote style=3D"margin-l=
eft: 0.8ex; padding-left: 1ex; border-left: 3px solid rgb(200, 200, 200);" =
class=3D"elementToProof"><div style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof"><cod=
e>      build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-x86=
-uefi.swu</code></div></blockquote></pre>
<ol style=3D"direction: ltr;" data-sourcepos=3D"29:1-30:0" start=3D"5">
<li style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
Boot the SIMATIC IPC device with the base image and apply swupdate with the=
 generated update image</li></ol>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
<b>Result:</b></div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
The SWUpdate process failed with <b><code>&quot;swupdate_async_start return=
s -1&quot;</code></b>&nbsp;error message.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
Attached file is a detailed log of the observed error.</div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
<b>Findings:</b></div>
<div style=3D"direction: ltr; margin-top: 1em; margin-bottom: 1em; font-fam=
ily: Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" c=
lass=3D"elementToProof">
The same update process was tested using selfbuilt swupdate as done for boo=
kworm [
<b>SWUpdate 2023.12</b>&nbsp;] on the <b>Trixie</b>&nbsp;build, and the upd=
ate <b>completed successfully</b>&nbsp;without any errors.</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Ranjana Teli</div>
</body>
</html>

--_000_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_--

--_004_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_
Content-Type: text/plain; name="swupdate-error-log.txt"
Content-Description: swupdate-error-log.txt
Content-Disposition: attachment; filename="swupdate-error-log.txt";
	size=10168; creation-date="Wed, 29 Oct 2025 09:54:37 GMT";
	modification-date="Wed, 29 Oct 2025 09:55:05 GMT"
Content-Transfer-Encoding: base64

U3d1cGRhdGUgbG9nOg0Kcm9vdEBkZW1vOn4jIHN3dXBkYXRlLWNsaWVudCAtdiBjaXAtY29yZS1p
bWFnZS1jaXAtY29yZS10cml4aWUteDg2LXVlZmkuc3d1DQpzd3VwZGF0ZV9hc3luY19zdGFydCBy
ZXR1cm5zIC0xDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpzd3VwZGF0ZSB2ZXJzaW9uOg0Kcm9vdEBkZW1vOn4jIGRwa2cgLWwgfCBncmVwIC1pICJz
d3VwZGF0ZSINCmlpICBsaWJzd3VwZGF0ZTAuMTphbWQ2NCAgICAgICAgICAgMjAyNC4xMi4xK2Rm
c2ctMyAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBMaWJyYXJ5IGZvciBjb250cm9s
bGluZyB0aGUgc3d1cGRhdGUgZnJhbWV3b3JrDQppaSAgc3d1cGRhdGUgICAgICAgICAgICAgICAg
ICAgICAgIDIwMjQuMTIuMStkZnNnLTMgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
U29mdHdhcmUgdXBkYXRlIGZyYW1ld29yayBmb3IgZW1iZWRkZWQgc3lzdGVtcw0KaWkgIHN3dXBk
YXRlLWNlcnRpZmljYXRlcy1zbmFrZW9pbCAwLjIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWxsICAgICAgICAgIG11c3Qgbm90IGJlIGVtcHR5DQppaSAgc3d1cGRhdGUtY29uZmln
LXg4Ni11ZWZpICAgICAgIDAuMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGwg
ICAgICAgICAgbXVzdCBub3QgYmUgZW1wdHkNCmlpICBzd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9i
aW4gICAgMC4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFsbCAgICAgICAgICBt
dXN0IG5vdCBiZSBlbXB0eQ0KDQpyb290QGRlbW86fiMgc3d1cGRhdGUgLS12ZXJzaW9uDQpTV1Vw
ZGF0ZSB2DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQpqb3VybmFsY3RsIGxvZzoNCk9jdCAyOCAxMjoyNDozMyBkZW1vIHN5c3RlbWRbMV06IFN0YXJ0
aW5nIHN3dXBkYXRlLnNlcnZpY2UgLSBTV1VwZGF0ZSBkYWVtb24uLi4NCk9jdCAyOCAxMjoyNDoz
NCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtERUJVR10gOiBTV1VQREFURSBydW5uaW5nIDogIFty
ZWFkX3NldHRpbmdzX2ZpbGVdIDogUmVhZGluZyBjb25maWcgZmlsZSAvZXRjL3N3dXBkYXRlLmNm
Zw0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0RFQlVHXSA6IFNXVVBE
QVRFIHJ1bm5pbmcgOiAgW3JlYWRfbW9kdWxlX3NldHRpbmdzXSA6IFJlYWRpbmcgY29uZmlnIHNl
dHRpbmdzIGZvciBtb2R1bGUgZ2xvYmFscw0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUu
c2hbNDMxXTogW1RSQUNFXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW2xvYWRfY2VydF9jaGFpbl0g
OiBSZWFkIFBFTSAjMTogL0M9VVMvU1Q9Q29sb3JhZG8vTD1Gb3J0IENvbGxpbnMvTz1TbmFrZU9p
bC9DTj1TbmFrZU9pbCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290IC9DPVVTL1NUPUNvbG9y
YWRvL0w9Rm9ydCBDb2xsaW5zL089U25ha2VPaWwvQ049U25ha2VPaWwgVGVzdCBLZXkgZm9yIEVG
SSBTZWN1cmUgQm9vdA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogU1dV
cGRhdGUgdg0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogTGljZW5zZWQg
dW5kZXIgR1BMdjIuIFNlZSBzb3VyY2UgZGlzdHJpYnV0aW9uIGZvciBkZXRhaWxlZCBjb3B5cmln
aHQgbm90aWNlcy4NCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtUUkFD
RV0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2Jvb3Rsb2FkZXJzXSA6
IFJlZ2lzdGVyZWQgYm9vdGxvYWRlcnM6DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5z
aFs0MzFdOiBbVFJBQ0VdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9i
b290bG9hZGVyc10gOiAgICAgICAgIHVib290ICAgICAgICBsb2FkZWQuDQpPY3QgMjggMTI6MjQ6
MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbVFJBQ0VdIDogU1dVUERBVEUgcnVubmluZyA6ICBb
cHJpbnRfcmVnaXN0ZXJlZF9ib290bG9hZGVyc10gOiAgICAgICAgIG5vbmUgICAgICAgIGxvYWRl
ZC4NCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtUUkFDRV0gOiBTV1VQ
REFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2Jvb3Rsb2FkZXJzXSA6ICAgICAgICAg
Z3J1YiAgICAgICAgbG9hZGVkLg0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMx
XTogW1RSQUNFXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfYm9vdGxv
YWRlcnNdIDogICAgICAgICBlYmcgICAgICAgIGxvYWRlZC4NCk9jdCAyOCAxMjoyNDozNCBkZW1v
IHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFttYWluXSA6
IFVzaW5nIGJvb3Rsb2FkZXIgaW50ZXJmYWNlOiBlYmcNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3
dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtsdWFfaGFuZGxl
cnNfaW5pdF0gOiBFeHRlcm5hbCBMdWEgaGFuZGxlcihzKSBmb3VuZCBhbmQgbG9hZGVkLg0KT2N0
IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1
bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogUmVnaXN0ZXJlZCBzZXNzaW9u
IGhhbmRsZXJzOg0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8g
XSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAg
ICAgICByb3VuZHJvYmluDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBb
SU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbbWFpbl0gOiBSdW5uaW5nIG9uIGNpcC14ODYt
dWVmaSBSZXZpc2lvbiBjaXAtY29yZS0xLjANCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRl
LnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVk
X2hhbmRsZXJzXSA6IFJlZ2lzdGVyZWQgZ2xvYmFsIGhhbmRsZXJzOg0KT2N0IDI4IDEyOjI0OjM0
IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3By
aW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBkdW1teQ0KT2N0IDI4IDEyOjI0OjM0
IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3By
aW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBleGVjdXRvcg0KT2N0IDI4IDEyOjI0
OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAg
W3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBhcmNoaXZlDQpPY3QgMjggMTI6
MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6
ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIHRhcg0KT2N0IDI4IDEyOjI0
OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAg
W3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICB1Ym9vdA0KT2N0IDI4IDEyOjI0
OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAg
W3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBib290bG9hZGVyDQpPY3QgMjgg
MTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmlu
ZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGJ0cmZzDQpPY3QgMjgg
MTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmlu
ZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGJ0cmZzLXJlY2VpdmUN
Ck9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFU
RSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAgICAgY29weQ0K
T2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRF
IHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICByYXdjb3B5
DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERB
VEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGZsYXNo
DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERB
VEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGRlbHRh
DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERB
VEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGRpc2tm
b3JtYXQNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBT
V1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAgICAg
ZGlza3BhcnQNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0g
OiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAg
ICAgdG9nZ2xlYm9vdA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lO
Rk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDog
ICAgICAgICBncHRzd2FwDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBb
SU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10g
OiAgICAgICAgIGdwdHBhcnQNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06
IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJz
XSA6ICAgICAgICAgdW5pcXVldXVpZA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hb
NDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFu
ZGxlcnNdIDogICAgICAgICBmbGFzaC1oYW1taW5nMQ0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1
cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lz
dGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBsdWENCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBk
YXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3Rl
cmVkX2hhbmRsZXJzXSA6ICAgICAgICAgcmF3DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0
ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJl
ZF9oYW5kbGVyc10gOiAgICAgICAgIHJhd2ZpbGUNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBk
YXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3Rl
cmVkX2hhbmRsZXJzXSA6ICAgICAgICAgcmRpZmZfaW1hZ2UNCk9jdCAyOCAxMjoyNDozNCBkZW1v
IHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9y
ZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAgICAgcmRpZmZfZmlsZQ0KT2N0IDI4IDEyOjI0OjM0
IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3By
aW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICByZWFkYmFjaw0KT2N0IDI4IDEyOjI0
OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAg
W3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBzaGVsbHNjcmlwdA0KT2N0IDI4
IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5p
bmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBwcmVpbnN0YWxsDQpP
Y3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUg
cnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIHBvc3RpbnN0
YWxsDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dV
UERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIHNz
Ymxzd2l0Y2gNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0g
OiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAg
ICAgc3d1Zm9yd2FyZA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lO
Rk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDog
ICAgICAgICB1Yml2b2wNCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJ
TkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6
ICAgICAgICAgdWJpcGFydGl0aW9uDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0
MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5k
bGVyc10gOiAgICAgICAgIHViaXN3YXANCk9jdCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNo
WzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9yZWdpc3RlcmVkX2hh
bmRsZXJzXSA6ICAgICAgICAgdWNmdw0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hb
NDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFu
ZGxlcnNdIDogICAgICAgICBkb2NrZXJfaW1hZ2Vsb2FkDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBz
d3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVn
aXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGRvY2tlcl9pbWFnZWRlbGV0ZQ0KT2N0IDI4IDEy
OjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBEQVRFIHJ1bm5pbmcg
OiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBkb2NrZXJfaW1hZ2VwcnVu
ZQ0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0lORk8gXSA6IFNXVVBE
QVRFIHJ1bm5pbmcgOiAgW3ByaW50X3JlZ2lzdGVyZWRfaGFuZGxlcnNdIDogICAgICAgICBkb2Nr
ZXJfY29udGFpbmVyY3JlYXRlDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFd
OiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVy
c10gOiAgICAgICAgIGRvY2tlcl9jb250YWluZXJkZWxldGUNCk9jdCAyOCAxMjoyNDozNCBkZW1v
IHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmludF9y
ZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAgICAgZG9ja2VyX2NvbnRhaW5lcnN0YXJ0DQpPY3Qg
MjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVu
bmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAgICAgIGRvY2tlcl9uZXR3
b3JrY3JlYXRlDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbSU5GTyBd
IDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9oYW5kbGVyc10gOiAgICAg
ICAgIGRvY2tlcl9uZXR3b3JrZGVsZXRlDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5z
aFs0MzFdOiBbSU5GTyBdIDogU1dVUERBVEUgcnVubmluZyA6ICBbcHJpbnRfcmVnaXN0ZXJlZF9o
YW5kbGVyc10gOiAgICAgICAgIGRvY2tlcl92b2x1bWVjcmVhdGUNCk9jdCAyOCAxMjoyNDozNCBk
ZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtJTkZPIF0gOiBTV1VQREFURSBydW5uaW5nIDogIFtwcmlu
dF9yZWdpc3RlcmVkX2hhbmRsZXJzXSA6ICAgICAgICAgZG9ja2VyX3ZvbHVtZWRlbGV0ZQ0KT2N0
IDI4IDEyOjI0OjM0IGRlbW8gc3d1cGRhdGUuc2hbNDMxXTogW0RFQlVHXSA6IFNXVVBEQVRFIHJ1
bm5pbmcgOiAgW3JlYWRfbW9kdWxlX3NldHRpbmdzXSA6IE5vIGNvbmZpZyBzZXR0aW5ncyBmb3Vu
ZCBmb3IgbW9kdWxlIHZlcnNpb25zDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0
MzFdOiBbVFJBQ0VdIDogU1dVUERBVEUgcnVubmluZyA6ICBbbmV0d29ya19pbml0aWFsaXplcl0g
OiBNYWluIGxvb3AgZGFlbW9uDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFd
OiBbVFJBQ0VdIDogU1dVUERBVEUgcnVubmluZyA6ICBbbGlzdGVuZXJfY3JlYXRlXSA6IGdvdCBz
b2NrZXQgZmQ9MyBhdCAvcnVuL3N3dXBkYXRlL3NvY2tpbnN0Y3RybCBmcm9tIHN5c3RlbWQNCk9j
dCAyOCAxMjoyNDozNCBkZW1vIHN3dXBkYXRlLnNoWzQzMV06IFtUUkFDRV0gOiBTV1VQREFURSBy
dW5uaW5nIDogIFtsaXN0ZW5lcl9jcmVhdGVdIDogZ290IHNvY2tldCBmZD00IGF0IC9ydW4vc3d1
cGRhdGUvc3d1cGRhdGVwcm9nIGZyb20gc3lzdGVtZA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8gc3d1
cGRhdGUuc2hbNDMxXTogW0RFQlVHXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3JlYWRfbW9kdWxl
X3NldHRpbmdzXSA6IE5vIGNvbmZpZyBzZXR0aW5ncyBmb3VuZCBmb3IgbW9kdWxlIGRvd25sb2Fk
DQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzd3VwZGF0ZS5zaFs0MzFdOiBbVFJBQ0VdIDogU1dVUERB
VEUgcnVubmluZyA6ICBbc3RhcnRfc3d1cGRhdGVfc3VicHJvY2Vzc10gOiBTdGFydGVkIGNodW5r
c19kb3dubG9hZGVyIHdpdGggcGlkIDQ2MCBhbmQgZmQgOA0KT2N0IDI4IDEyOjI0OjM0IGRlbW8g
c3d1cGRhdGUuc2hbNDMxXTogW1RSQUNFXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOiAgW3N0YXJ0X2Rl
bHRhX2Rvd25sb2FkZXJdIDogU3RhcnRpbmcgSW50ZXJuYWwgcHJvY2VzcyBmb3IgZG93bmxvYWRp
bmcgY2h1bmtzDQpPY3QgMjggMTI6MjQ6MzQgZGVtbyBzeXN0ZW1kWzFdOiBTdGFydGVkIHN3dXBk
YXRlLnNlcnZpY2UgLSBTV1VwZGF0ZSBkYWVtb24uDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ==

--_004_TYZPR06MB758380BBC1865D10C891850F9CFAATYZPR06MB7583apcp_--

