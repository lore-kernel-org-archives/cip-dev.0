Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA0CA5FE4
	for <webhook@archiver.kernel.org>; Sun,  4 Oct 2026 04:36:42 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [223.27.119.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18286.1791088601974945651
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Oct 2026 21:36:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cybertrust.co.jp, ip: 223.27.119.44, mailfrom: hiraku.toyooka@cybertrust.co.jp)
Authentication-Results: ss11.sbt-mailgate.jp; dkim=fail(No signature) header.d=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id ENed08019B;
	Sun,  4 Oct 2026 13:30:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksZWAVVwTx8u/WmXUnOOKomvGA/EBNpmdhG+CTibA+p2tXV2ushEdEBg8/+9SBmf3Yl9UkBTGiTs9GnIhi+NZ85+YiipOSKA5K0vK7zLG9eBS51yuGsCdbvo8T0WzfrLzMdWn9N3HR9r8C1oBcdB9xgcn3lDUxrHrI0YLaBTMaa0UaTbGzXDveOtmoCBSHb1ybdIq0gfLnZJdAdTiwLejpWvN2XgPgAIvYWhND7rHYehd7rQVFvxTRRsWQdNDWYcxlwfN6MTHf6YCb74HLXJRee2n5qeRU8FzczNIo1Ok40WEWBbTARIiY2zcVEJTSTYIKSuVrmK4zHv7muiOWZ/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ku2dQ9C5Mcr+YU+WUhRUec/oBKiM+ADUIcxjAK8jLM=;
 b=Mwb74brjsBCChFURaqlcFtWhZw9TJHZWA4qBgZDb8w/7J9VlhcGvWsK7wiI4QMHRtdSGdzkDGNnpqK5yBiDLFmkwqPBYJ594kmXONnByYZoCR7XnnCrEfZEvowMCCy3fHarymB+drWkEWFXuCVQYb9XG1tarlwHhNYfDPSmHRspwaCkUMY8d82Hqe1jgAKo1kc4U8tIqElAiy3h+UBfszjh6brZyXHXSqi3sw3zHFagAMDK8Y441TY9jCPkByItzLNRJ11I13Ummq4UfSiqACHSrxD5dMY0Uw7+/evkYKc8mOVk9Pw32BEu5FzEI+yDQuE1Vl6a3pcW3o2FrYUsHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Received: from TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:388::23)
 by OSOP286MB7808.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 04:30:27 +0000
Received: from TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6610:6e59:3956:d8f9]) by TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6610:6e59:3956:d8f9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 04:30:27 +0000
From: <hiraku.toyooka@cybertrust.co.jp>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <hirotaka.motai@miraclelinux.com>
Subject: Re: [cip-dev] lab-cip-cybertrust
Thread-Topic: [cip-dev] lab-cip-cybertrust
Thread-Index: AQHdTBSHUszE6dpsc0yqnwV1dhKVuLbe3dSAgA37CSg=
Date: Sun,  4 Oct 2026 13:36:34 +0900
Message-ID: 
 <TY4P286MB77204908FD55DE24B604E4D0BD972@TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM>
References: <c9a0c64f-5341-4983-8020-32144e5fd0ca@siemens.com>
 <243f9dd8-960c-4c9d-ab65-4821d8aca1d7@miraclelinux.com>
In-Reply-To: <243f9dd8-960c-4c9d-ab65-4821d8aca1d7@miraclelinux.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4P286MB7720:EE_|OSOP286MB7808:EE_
x-ms-office365-filtering-correlation-id: bfd6871e-5223-4c9f-d52a-08df21d03774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|23010399003|18082799016|42112799006|1800799024|10067099003|56012099006|6133799003|4143699003|8096899003|13003099007|18002099003|22082099003|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 MjBMzULveItO42/ke1RyT2138km9MNyP9Yw5OIQYZfihXPI5DbAFZYI0/50xe1g43fSp80CHk7FjM4ZEkmCF8JIw1zdz+yzro3454VuXgYj+xU3Mz4QCdBNQi75sWbf/ZmXkaVyp1KBFSK2VWyIG8Y/OynK+tPLiUVZslXDa2xNKM+tKeCmG6tc8qRusz0K5rHYPbU0ATdXPyddcpD0ivYQXFqWJJY7ELytMFGgCOuLI7RixMqsnB6D3cPx1++4xZNevo/LbfURdDsrN6uNn6lwTL4xuHCbBQQuoevrUvtwpwJD6Zjks+IPUtVy/GJ0o/Wj3AIwnSOSLFNk9n6oWI/3hSRhjJv0rqz0+w/+UjqgaoEebJ2jPgL1p0sI5vxYjZRbehmHsPhC+4u9S5JSM67pg2yQeWwLc2ClxR1GaM2cZHBy2LHiKe++2DGiq/NqtXt5P+B5QctYehCt4tant3+Bf4stM8NLQRCX2acLeuYXfBekvL6ioZP3KsoCkdXrJMZo0je5TlUunyFMubPlQDTmA29uTlXYN6F1KJoRRpk4HeSibx+80LScAbMN9VKtAq23AEDN+bVkE2HDMpyTmvzo6Exu54Vy10/1PQZnnxPDbC6A5OQsG/PtzZXMClMFAUAEXe2TQaEDp8qGWeBTYYYZok4Ii3iBoxrQDslqX7pcVbegpine20VVEaYo7BvRmK9NdRXaC7wdd9yvFaO6eGCS6eApoJE8YAfi3d8us/A0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(18082799016)(42112799006)(1800799024)(10067099003)(56012099006)(6133799003)(4143699003)(8096899003)(13003099007)(18002099003)(22082099003)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dklRb2ZnbWxlWCtsclo3ditWRHIyU2U3a2hUOXlFTnVic1VuVFZrenFy?=
 =?iso-2022-jp?B?YWhJTUVHeVZWdy9vRVA0SmYwbXd4SFlrOTJMZTFkb0xKaWxrTzd1RjVz?=
 =?iso-2022-jp?B?VjJ6MkQxYlFlK1A2SlJxaWRnTEdiUUhROXo0Q1BHaklicmRKVHA1WmNq?=
 =?iso-2022-jp?B?NDdSSEFydkthMnlzblZ5a3dHMGxtVnJHRE5Ta0t4RHBMbW9KWGdvWm9S?=
 =?iso-2022-jp?B?ZmtiWkRuSWNINnZocVNJM25VTmpwY2JBOWlOcGdrQUc5L3o5REY1dHpj?=
 =?iso-2022-jp?B?WjhWNU9DeU9uNXZieWhSc1RMYUdsZW5YT21RdTRYUnRRSlB0UVVqTEww?=
 =?iso-2022-jp?B?endHcitEUXA0RFNpTFhjd1FicjdCYXRrVUNpa0NZZlBRV3AvQjZxcUhS?=
 =?iso-2022-jp?B?RkhtdC9Rb1g0cFlVWUVkNUthby8wd3RrL09NckR6RStSOXFaZnkySTE1?=
 =?iso-2022-jp?B?TnNRRW1tajA2VGl2c3dEdWxhZDNvZ0tZWGNrUVJPaEtvR3JaaytXWUth?=
 =?iso-2022-jp?B?RFBtbGIySFR1eXptOFNzNzFkSU1GQ0hmVVRwdFM5ZGk3K2k4dHhZY3Bz?=
 =?iso-2022-jp?B?WlRmeGttcEQzWUZlc1JhMm9ubUJqZnR5Q0RGazBCNlgyWFYrQnZ1TkZj?=
 =?iso-2022-jp?B?MmljZUNvdUp0QmZMcmpjWjFkTDZuVXhlZGR1aWR6Z21pZVNmUUV2VzM5?=
 =?iso-2022-jp?B?d1VmdjlObCtFNmJJM3ZBazJXcWZyNVliUVRsU0VFeFVWQkExWkhhbWw5?=
 =?iso-2022-jp?B?dFNVbmljQXJCRUFQekZ2L291TjdtNFV1d0xIS1c4UGZhRU00WlZ1U28z?=
 =?iso-2022-jp?B?cXZ2ajd5eGh6M241OXpZRlQ1SXo0dXp2bWxLVDFvVEFLZDBpMkdNdGdv?=
 =?iso-2022-jp?B?YWxDb2k0Yi9wZisyL3dJNlJxRzJsdmtYTW9NV1BzY0gyOEJ2alpvVFNN?=
 =?iso-2022-jp?B?ZjA5cEZhVkVVSGMvb1d1OHdNbzh4Y0hxakx3bWlZSUhKUllsZVFadkNS?=
 =?iso-2022-jp?B?djExdHUyWE11ZUpiV0ZoanBHbngxclBWNm80cmszTGdQME9RejdaajJ2?=
 =?iso-2022-jp?B?K1RaSkR3a0JBbVRuSFRCYUltWFdsQzNrb3FIQ253RElXSFBuUEptUTFI?=
 =?iso-2022-jp?B?MHJJWDUxNWxCcG5KVXRnNW5tUUZZTlhHWWpuQ2RmeEFaVTdGZXZIR1g2?=
 =?iso-2022-jp?B?MzJNMy9vUEdxSmhYeUVRcjJsK1c3VEkvZnZNTituVEpPYXJCRnRveExE?=
 =?iso-2022-jp?B?enUvWDlYdUZrSVJMV1ZtNzVsZERhOVd0L1BGaCs5dTBhMDRlaXBvajVq?=
 =?iso-2022-jp?B?SkVSdm5iYnJrakVoRzlWTTdWV2lNM240SmdScW5CQU9zODlLUFBIZ2h3?=
 =?iso-2022-jp?B?NXV4T1dDSDNlWkxITWRuUlF1OVhKdUg1dm1HT2lBYWwvNUplWVNnM0xG?=
 =?iso-2022-jp?B?T1NrRi9Ta2I0Sm1iUklERWxDaUNFTlh2Y01UVkZ5UHhaUW9GbGdvWnl5?=
 =?iso-2022-jp?B?dldiR2xSbWhPb3pVQ0NRMHRGL3ZjRFJJdWl4bXB1bVk4OU43VTVlVGl0?=
 =?iso-2022-jp?B?V0NXOWtIek1wcHQwVWJOMDZYNFJ4TGRzdXd4Z2JhMkNUZzJ0czFadWtS?=
 =?iso-2022-jp?B?alJhSFBQRmJNelRHTkVZZlgzOW5LRkhGYWw2VXpGZG5WZXNLSmxJRmhS?=
 =?iso-2022-jp?B?Z0xETHdRTFJKeHhOeEJObUFhZmowbEUyWWg2Vit3T3ROUWllQ0lWMEdE?=
 =?iso-2022-jp?B?cGE4WHMyT1U3aFBVN205bEF5ZytDUk14TDJNQkZmbE5IMUFzYkdudUl5?=
 =?iso-2022-jp?B?dHluNGJYc3BoaWpHc25qdkFGdkpJNjZTeWFrb0RwcEZHNTd6bnFmQWJT?=
 =?iso-2022-jp?B?VFdUYkFLbEVYUFZWN2FsQjc4VjlxK1h0SWtkTUtvSUNudWpiQlMwalBS?=
 =?iso-2022-jp?B?NXpvU2lJRjNPSEdHbHFHYzRhS210QnNmU0loK2Z3NWtwS243VWNMRXBI?=
 =?iso-2022-jp?B?T2pQSWg4eUM1RnlRakc4UWUvU3dVZUhEVU5aQm5jcFJ2MHFwaGdHVDZX?=
 =?iso-2022-jp?B?Mm9iT2UyZ1JZdHZuQ3cvWTVZdHBjbTRNaDBNbFBwTnRoWXA4U2RjTzFw?=
 =?iso-2022-jp?B?blR2UGI2dmFEczE0YmVOYnp0aXcvNkhiUzRieEtPcVpmQzF6OUwzV1hk?=
 =?iso-2022-jp?B?R1FSaGJDT2wyMUo4a1VnTlRzNEhMc2l5UUxFbndobjhVMEVFNG8yK1ha?=
 =?iso-2022-jp?B?dk4vZG9HcysvendlYVlidFVEZ2hvaUhpOFlleDVSUjJXOTlKa0dWUkln?=
 =?iso-2022-jp?B?ZUwxRndFWng3Vmx4dDg4YTI0NURwRXlDMktsTmh1V3g5WnhwNEFtZ2hK?=
 =?iso-2022-jp?B?NnRaaWVNYWVNelEzN1BITU1qQ3VZVEtScXpObUpkcyt4K0lZSHFrMUtL?=
 =?iso-2022-jp?B?cE9wbVF5SHdMUmdjV0lMNVFxSE1sQkVVSUp4aFlBSStFWm9HenFtWTNJ?=
 =?iso-2022-jp?B?RHBZdkk0NGQ4NThyQUorempoY2xDdkxjb0tjanhKTXFQRll4YnllNTFo?=
 =?iso-2022-jp?B?eWRWVGd2ND0=?=
Content-Type: multipart/alternative;
	boundary="_000_TY4P286MB77204908FD55DE24B604E4D0BD972TY4P286MB7720JPNP_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	2ymAEMUhHmTaK5kpmrbqwOg932Kia01o9n6DCCC5WkS1mOyqn4vOy8o7OtujrcY94JIRM4vHHR9ao/wVUgk1E8FUVXTV97HbWbGcrvBsWjpWHH57zs9gDUj5lF5nhNaxuty+sPDvSVAvvSvXCfHG/GbJ0VEKig1QVfLAo1yPreRW7ZKB12styC5jP8K6bFDtRqTTmAiJIZfxNF3yAuJE3c6jNQXlupO0au74fWu25NXLT2PNnohTVnX/ulRe+0s/BbM3v4XdyVve6yZLZqTZqaYL9jNb47dhwLyuXghnm5JLJHxLr0x/SErwwPvJoZHd3sBDWht0QOEGvoKonFIyAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rJDMMbWg1c0xcUuQEdQHRk84Q44aHZDld91xPE+YBG+0u2KxNwSbuz+PsIXHhOiNce0s2C62DhBWlQVGdiFaJ/rHR1lkTACNHHwKTXdqN63BXOpt3jqfd1B4mUJzpcXQ9OqYZ96sue/K093vcH8CWauwrtvdmHjQjYzQDKyv5S9VpahIGqNxBtH9WqDD9XUMiVch64j0mPk7PghHxuhlsARSNathI9cmPK1cAhWNwZjTsXs0RR3ExXmsJVlEWkHFHs0BWXCtqPGWHragQRUUIo7L0Y9ePAIFU1zoxUFyKbTtjH2YzSCZwOZpRDx6ixUp1wi90BIQXN5CG9zX57azwxSu8eGarrNUhCBmVSfPjWsOY7oy43zhWIKekLlkEd4v5Gbb/2hSsipto2D9WNphiEcgQ6biXqmHsQvEEF5JXW6+2AVBfzwFvt6pFPQfxilq4Qs+Q/F3W5w6TMuvR2aerHEzH0RFQvEqKquQr5r85N99xW+peE4JVH7oGWYo5Q/GND8toZbAs0M2OV1O+mrv101J9PCNLSjChbOG9U5PbyZRnk8zzgLeFtmHo4IBXruVxOw4BRuMXC2a8K4zvbToa8pp3B+EFpqvfSL+zSMAUDxijH0It99LbZPnYtPSbSuA
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4P286MB7720.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd6871e-5223-4c9f-d52a-08df21d03774
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2026 04:30:27.7207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 035f1967-273a-4ebb-aef8-11085443b6cd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuOUrpOsq5coaxRIwScW8xj9yQMhWZ2B6bwRdgz4d7GtzcAT8x3Levrlj4A8x2Lkdn4uMnTYTdy6wDaLpdZsQqIc/jnzoHfLFkgPDE7m4KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB7808
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Oct 2026 04:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24427

--_000_TY4P286MB77204908FD55DE24B604E4D0BD972TY4P286MB7720JPNP_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

(I am resending this email as it may not have reached the cip-dev mailing l=
ist.)

Hi Quirin,

I'm sorry for the late reply.
I rebooted the lab and resubmitted the jobs that failed previously.
They have now completed successfully on qemu-03, although I'm still
not sure about the root cause.

> > https://lava.ciplatform.org/scheduler/job/1514767
> > https://lava.ciplatform.org/scheduler/job/1514772
> > https://lava.ciplatform.org/scheduler/job/1514774

Resubmitted jobs (executed on qemu-03):
https://lava.ciplatform.org/scheduler/job/1521324
https://lava.ciplatform.org/scheduler/job/1521326
https://lava.ciplatform.org/scheduler/job/1521327

Best regards,
Hiraku Toyooka


--_000_TY4P286MB77204908FD55DE24B604E4D0BD972TY4P286MB7720JPNP_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
(I am resending this email as it may not have reached the cip-dev mailing l=
ist.)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Quirin,<br>
<br>
I'm sorry for the late reply.<br>
I rebooted the lab and resubmitted the jobs that failed previously.<br>
They have now completed successfully on qemu-03, although I'm still<br>
not sure about the root cause.<br>
<br>
&gt; &gt; <span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.=
ciplatform.org/scheduler/job/1514767" target=3D"_blank" id=3D"OWA8a702f1b-0=
3ea-c974-022e-439a44afd2cb" class=3D"OWAAutoLink" rel=3D"noreferrer" data-s=
aferedirecturl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.or=
g/scheduler/job/1514767&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;u=
sg=3DAOvVaw3_5O6vJKU7Ght2Zqz5tuaL" style=3D"color: rgb(17, 85, 204);">https=
://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">heduler/jo=
b/1514767</a></span><br>
&gt; &gt; <span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.=
ciplatform.org/scheduler/job/1514772" target=3D"_blank" id=3D"OWA289e1d2a-b=
ab5-a621-a7c8-de22cab3a78d" class=3D"OWAAutoLink" rel=3D"noreferrer" data-s=
aferedirecturl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.or=
g/scheduler/job/1514772&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;u=
sg=3DAOvVaw2udSxxwDdzxRFjnSEzBkiH" style=3D"color: rgb(17, 85, 204);">https=
://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">heduler/jo=
b/1514772</a></span><br>
&gt; &gt; <span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.=
ciplatform.org/scheduler/job/1514774" target=3D"_blank" id=3D"OWA91ff621f-f=
9b7-8640-e1d6-51c816e2c330" class=3D"OWAAutoLink" rel=3D"noreferrer" data-s=
aferedirecturl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.or=
g/scheduler/job/1514774&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;u=
sg=3DAOvVaw24U09qLBZz3UZVhSrC0U59" style=3D"color: rgb(17, 85, 204);">https=
://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">heduler/jo=
b/1514774</a></span><br>
<br>
Resubmitted jobs (executed on qemu-03):<br>
<span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.ciplatform=
.org/scheduler/job/1521324" target=3D"_blank" id=3D"OWA572facd0-a0fa-09e1-7=
669-6d16a25f7da5" class=3D"OWAAutoLink" rel=3D"noreferrer" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.org/schedule=
r/job/1521324&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;usg=3DAOvVa=
w2FXYvAdhtNeHlcPjXXMRHd" style=3D"color: rgb(17, 85, 204); text-align: left=
;">https://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">he=
duler/job/1521324</a></span><br>
<span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.ciplatform=
.org/scheduler/job/1521326" target=3D"_blank" id=3D"OWA6fbb951f-a397-3195-9=
10f-b9ba8c0f31d8" class=3D"OWAAutoLink" rel=3D"noreferrer" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.org/schedule=
r/job/1521326&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;usg=3DAOvVa=
w30tEm3igTZM0FGleJ9VLhH" style=3D"color: rgb(17, 85, 204); text-align: left=
;">https://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">he=
duler/job/1521326</a></span><br>
<span style=3D"color: rgb(17, 85, 204);"><a href=3D"https://lava.ciplatform=
.org/scheduler/job/1521327" target=3D"_blank" id=3D"OWA01daba91-de96-fe48-8=
27e-17ec8dd30f76" class=3D"OWAAutoLink" rel=3D"noreferrer" data-saferedirec=
turl=3D"https://www.google.com/url?q=3Dhttps://lava.ciplatform.org/schedule=
r/job/1521327&amp;source=3Dgmail&amp;ust=3D1791171069593000&amp;usg=3DAOvVa=
w26COpR7ZIUtvWh3Jnvkew3" style=3D"color: rgb(17, 85, 204); text-align: left=
;">https://lava.ciplatform.org/sc<wbr style=3D"color: rgb(17, 85, 204);">he=
duler/job/1521327</a></span><br>
<br>
Best regards,<br>
Hiraku Toyooka</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_TY4P286MB77204908FD55DE24B604E4D0BD972TY4P286MB7720JPNP_--

