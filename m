Return-Path: <SRS0=rbHj=IK=lists.cip-project.org=bounce+64572+6277+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F0C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 12 Mar 2021 03:51:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752AF64ED6
	for <cip-dev@archiver.kernel.org>; Fri, 12 Mar 2021 03:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752AF64ED6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6277+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4bg4YY4521723xi2dVM2Vdjd; Thu, 11 Mar 2021 19:51:32 -0800
X-Received: from esa1.hc514-86.ap.iphmx.com (esa1.hc514-86.ap.iphmx.com [139.138.45.243])
 by mx.groups.io with SMTP id smtpd.web09.3849.1615521090437944761
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Mar 2021 19:51:31 -0800
IronPort-SDR: x4gJdkicRapp3ixcvnQMgrbLaaFjQ/oJXjV4XPqngeX7tMFXqtZHaVxBk2KU1W9w5zq5o6d9UC
 il3XeGHQMc3Nsih3HP97eVLx+2aIdgHI6qXB7juQztV3Go/SYe7AiAqBNJlRC2O+C/2fBF/Dp0
 N5v4cSR5NutzakLlFF8EBFDCKXQcglLh2g+oOCLKIrNL9EPwNlrqQ0kMUuMZj48WxCw3yH/ipt
 CAMRyHjlYmWWMp16/nY3kkT2GcHNSRI7aobEson/d5KLIjZlT45EUGT7tRA7jIjLFyLBLfkIoo
 Joo=
X-IronPort-AV: E=Sophos;i="5.81,242,1610409600"; 
   d="scan'208,217";a="5114308"
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) ([133.145.228.57])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Mar 2021 03:51:28 +0000
X-Received: from mlsv8.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 25DE43C0043
	for <cip-dev@lists.cip-project.org>; Fri, 12 Mar 2021 12:51:28 +0900 (JST)
X-Received: from mfgw03.hitachi.co.jp by mlsv8.hitachi.co.jp (8.14.4/8.14.4) id 12C3pRAh029465; Fri, 12 Mar 2021 12:51:28 +0900
X-Received: from GUjpTK3DCemcs20.global.hitachi.net ([158.213.250.21])
	by mfgw03.hitachi.co.jp with ESMTP
	id KYpjl5e1hB5toKYpjlS9U8; Fri, 12 Mar 2021 12:51:27 +0900
X-Received: from GUjpTKHDCemcs03.global.hitachi.net (2002:9ed5:d24c::9ed5:d24c)
 by GUjpTK3DCemcs20.global.hitachi.net (2002:9ed5:fa15::9ed5:fa15) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar 2021 12:51:27 +0900
X-Received: from GUjpTKHDCemcs06.global.hitachi.net (2002:9ed5:d273::9ed5:d273)
 by GUjpTKHDCemcs03.global.hitachi.net (2002:9ed5:d24c::9ed5:d24c) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar 2021 12:51:27 +0900
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs06.global.hitachi.net (158.213.210.115) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Fri, 12 Mar 2021 12:51:27
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBAExXlePgN5MqXcG/43t7kW7WPmp7NA7fuD2I2Ue9sJsfeuIQ3bkIOBAcB9t9McGpkJ3NZ1ATZgiEJ56q6r9P3q2ruR5yIDK6BLa33utlqmYHjf99EvI5hEDE5pshUFLPRrR/kbeRmJUhJfONyPpIFfcfdhsbKJbCldgE+u63q4U3zZ1E+JRtYQQgC0nETe7rPFckqvnVBSVJ+RVUxu7vCsqROmbOrvzpBa51qeUlljq1Htl41RxAwDmO/D4gscEHeGiu+qXCzkXohJO3JX3YMDFpVBXh/htqbNourqgNJBeSAFKnX8OMb74OTXoMRqpi7533bWUhJQ7uXeKJE4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfF8pCe4Ra8MiNV5vcYoujTLgYBE6dbheN824vMbzbQ=;
 b=i1mdsBerzWSWY8wUq4dELhOrl0PW1C5+6FE80lbLz+PqCjZrva6W0gXtvwef5Xsb3SjVz/DapLVShLUuj2DQksADQsyCuXPtjKd+GPODyojh7Kno5FS2kOvCjnaiaoM6GgPux0L0mXntw+Mha9kX53Ou0+teFHb3IhT2GRaYRp99k6Zqj/mJTOlMTrOCQx8SbhDo3ZdvMHRx5sQ+aZxUDEwbA3zY4j0Nkfxt3oEBgjxnt0UzsjgMnrlfrU76sXdgnd+t0dU4VHUXNcpnFGFCzC810VWoA9CWF3DWi+d7g+NGEBid4JT2w76PqdsUL8FRx/iTC+Gp4YasoRkVzeLFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com (2603:1096:404:6b::9)
 by TY2PR01MB4441.jpnprd01.prod.outlook.com (2603:1096:404:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Fri, 12 Mar
 2021 03:51:26 +0000
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe]) by TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe%5]) with mapi id 15.20.3912.029; Fri, 12 Mar 2021
 03:51:25 +0000
From: "Takuo Koguchi" <takuo.koguchi.sw@hitachi.com>
To: "'cip-dev@lists.cip-project.org'" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: Is cadence-quadspi working on cyclone V?
Thread-Index: AdcW6N7w+/NxEPWCRLqEbIuKn5Ciww==
Date: Fri, 12 Mar 2021 03:50:09 +0000
Deferred-Delivery: Fri, 12 Mar 2021 03:52:00 +0000
Message-ID: <TY2PR01MB26522E5CC577EC60BD354085D76F9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0630780b-d0a8-47ed-b613-08d8e50a1c30
x-ms-traffictypediagnostic: TY2PR01MB4441:
x-microsoft-antispam-prvs: <TY2PR01MB444153E47E63560E18AAC213D76F9@TY2PR01MB4441.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oKBUUHPakAShPF3ABOmZp2SqWdxIKS63Af+HqBCPgIf92kTjvKrYARAQ//NqwBQl1hKArFgbNe+ZviWGm9zw16oq4/yRn7QVJntZ+BWbemxbLc3LAIvxexNlcf6IzWwdW6AEAvLXMRU5Xt6jFbH0XLNBT8fvcltNGxJVflHWASnKyq3hqMqyTH3DSwyxRs1USnl3+3dspbz5TZkHSU/ckbqG8YMxLCA8rMLgBVnB9oAXGTq0kMlswBobD5MqZcg+74vSSSA49k2SOh/DB/xMf4cbIBokQjgptVc+BxQnk9mOrSb42tiK9nPtOw1zvFEOfcGqQSungs5VhK+Sj2Fg0eYqGrXkgTCNs9kgEBx1FnRm0xfQxyYAZPcynsMCZDCJyirdNEofKM9CQd9bDtwAkkOQjnT/YWITGAFRqz4aSo7a04IKd2XlqbqaSIbdp+gEQAftJkGzVNjCLJ08HmqVs9QYJmIU059bfpXeiFDJp1UmjLI7AI5nYBaIa3LfsBVppiA6m40y6roVocCfv8zusaF6M3tFUvkxwF4ECqyze9rGPrcqXBEV8EenMhtfQdSZ
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?eTN3Syt2cUVOTHR1OWhQYm9SRzRKU3FMU2hhMjBuQ01kL3VGcFF6YlJs?=
 =?iso-2022-jp?B?UGczUlV5eE12bGxFcGJkRlB5cExsMCtZWkx4OXFKL3FtSVhEM1dqZFI4?=
 =?iso-2022-jp?B?MGdBZWwrWm5aTklBZS9wMnp2WjFFWHBjZjRXV1R2eGVGNmR4d0RFSC9p?=
 =?iso-2022-jp?B?NCtKNzYvZVdUTm1ka3NIOXJyQnBTSk9MSkljeVE5YWdqRFJocy9kc0Ez?=
 =?iso-2022-jp?B?ZjhFQkJNa3VXTmxGOUVaaXJZYkYwc2o3K1FodWRlWGpPQzU3LzJndjhh?=
 =?iso-2022-jp?B?dFhTNmt4VjJGUVNtbjNpdlRKNWxJcnVVVkk2OUExcHFTZitSMHVjcUxZ?=
 =?iso-2022-jp?B?aTNQRFlhYlRuamZBWW9SVkVTRVpDMlJrNzBjditFTWs2TE9CUjdtTTdD?=
 =?iso-2022-jp?B?ZkxxY1A5NnhEOG42L21sN0dNdFZqSEVwYWVPNEJjNVN2bHBxN0RvSFRO?=
 =?iso-2022-jp?B?cVcwRmViUzFXZnZxWktoNDlURzJ6Yk84Sys5cUlxb3RXMVFxeGtNbFRk?=
 =?iso-2022-jp?B?L0Q5Y3Q1cEh1V2FGMFlQYXBLekxyc055eC9SaVZGak9MMjBCVytOcjZH?=
 =?iso-2022-jp?B?ZnNLUk5GNkRiQlI5ckExcy9nNnhOcVVPZ2hsZ1JaZGd2SFJWMS9kSWsv?=
 =?iso-2022-jp?B?YkJTN2tPeUtSeFRUcEs2V0pWNGNBd29CRWRuSGI4bGUxVVJ5NFlpeWRT?=
 =?iso-2022-jp?B?QVBrTm53TURKbzVaVWRIVFQ2RUlEUDRzU2w1WlVtUXptMDN6Nk9LaldO?=
 =?iso-2022-jp?B?V09qMXVuZWhHZjRYNkdNWXdWamhPZnUyTHMwcEtEUzlZditIKytSWnVu?=
 =?iso-2022-jp?B?dnRMUW5zYnFleXRxRWdNZGFKWFZsWURXWWdQWTRrZ2JvRktFcHJ3WHY1?=
 =?iso-2022-jp?B?ZDR6aUpHbitzOVhPNFc2bWFIQzhNSTJWQXR0WGRuV0FOVzkxSEJkVWZr?=
 =?iso-2022-jp?B?cHAxMlN0SWZpY3hxS3l6WlRUU3hQYzBZUkR0NkdpQ3YxWmhrUFZhR3g3?=
 =?iso-2022-jp?B?SFIwTU1HTDRxWERnWFpBa3pITUNuQ2xLeWJoRGNhNGROUi9FSDB2SHMy?=
 =?iso-2022-jp?B?d1IxQ24xRkc2T3pWU3ZaVVl5b2paa2lZaVFoU0VLQld2a3VwaS9rMHZX?=
 =?iso-2022-jp?B?NWU4dUVwNGw1akhpaW40Y2lJb2FGNWlyYmpYKzRQQjJEMDhHS2o2Sjlq?=
 =?iso-2022-jp?B?eCtFZFNsODhjVVNaUWJXWkE5WUhUQzhBdmMyRks1a05EQmZrSjJWaFRH?=
 =?iso-2022-jp?B?Q1JBeVUwYmVFMVpUc3pmQWFFcm5DMlkvUkZvMStqbXBjUHViZTQ4Y3Mz?=
 =?iso-2022-jp?B?V1JJMlc2VUJPdFRScHFpdmREZmMraFp1dWhDOUNrM3c4K2VtckpnUlRk?=
 =?iso-2022-jp?B?NjJpVm04bUZNMjZ5Y1BEUlNJN1ArN3pNdEFhUkR3cS92ZFdsOE9keXI3?=
 =?iso-2022-jp?B?WlBJbXYxNlFXOGNoaS9KSTEzL0NkZXpFRE9rWXorZFErbEhVNVpsbDRS?=
 =?iso-2022-jp?B?Y0hFUEVLcU9RVmwzTWxyR01mM0t2NGtlZ2VhTm13Q29HdU4wMko3NkRB?=
 =?iso-2022-jp?B?VTZCMEJ0cUp5bWt4Sk9TZ1FiM2VTSFNMWk1Ia25yVGwwNU5WWGxvclZ3?=
 =?iso-2022-jp?B?TERQc0wwL3p4K3ZyOTRHT3htVTM0Y0Z6SkVFK0lrUGQxMEhWZ3dxN2RR?=
 =?iso-2022-jp?B?U3Rwamg2dW5WUFU5ZGpJODVxbkFqdFoyeDZ4RGpzZHNlektpeU0rU2Ns?=
 =?iso-2022-jp?B?OUh5ekJPRUNJQzlwSEZNQnB5VTlNSUlMRkRaQjNhNUNOZmN6Tlo3ZVBK?=
 =?iso-2022-jp?B?U1VLZzBXTEhMa0RHUUNoanY3bHFTMXcrRzIybGphOTdqUUprVlZhbExM?=
 =?iso-2022-jp?B?T3lIM2VqWVN4RnVsaFFkYmpOeGtPTFY2akt4UzNQcTNib3pIUXR4anRV?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2652.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0630780b-d0a8-47ed-b613-08d8e50a1c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 03:51:25.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dydWj6qsMel1i9vopVMa9qQFldzjoHDSGrBn5nY8Gf7QyQCsjl8zDHXDZai9clBaWLzfzzIyCUEMvZs06dSbubAlGOfsT9HKPJDCFH4qfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4441
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f0EVA7uHcUl4sAriMmW6PXGqx4520388AA=
Content-Type: multipart/mixed; boundary="7Pig6IDJGfxNl40lY0rF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615521092;
 bh=SfPOLj0mY0jRTSHBUUh9TeYV2cNMp3JlMxOCTHZ28/M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BiVjJzRO+HhUQcpTJXCYrgWdD2rKmtO307UcsrOWGgf6Wk+Pm//ktvOpQ71LtFU4fqs
 dQ90DGnS1xDLt9NLu5kjIhd1mSg9SXJjkDvdIcWi5dQirBbp+k+xcO6yDEpWvitaGSZCZ
 Y/CL6j/ZqfgMvkst3ytk601mag6LceGFoGc=

--7Pig6IDJGfxNl40lY0rF
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB26522E5CC577EC60BD354085D76F9TY2PR01MB2652jpnp_"

--_000_TY2PR01MB26522E5CC577EC60BD354085D76F9TY2PR01MB2652jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi CIP developers,

Can anyone confirm that spi-cadence-quadspi works fine with SPI-NOR on cycl=
one V?
I recently moved to 5.10.y-cip from 4.19.y-cip, then my custom board with c=
yclone V failed to detect SPI-NOR

Git bisect has told me the first bad commit is
31fb632b5d43 spi: Move cadence-quadspi driver to drivers/spi/

Does this change requires device tree modification?
Any suggestions or comments would be appreciated.

Takuo Koguchi
















V

--_000_TY2PR01MB26522E5CC577EC60BD354085D76F9TY2PR01MB2652jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"=1B$B#M#S=1B(B =1B$B%4%7%C%/=1B(B";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"\@=1B$B#M#S=1B(B =1B$B%4%7%C%/=1B(B";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Arial",sans-serif;}
span.17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Arial",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break-w=
ord;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi C=
IP developers,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Can =
anyone confirm that spi-cadence-quadspi works fine with SPI-NOR on cyclone =
V?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">I re=
cently moved to 5.10.y-cip from 4.19.y-cip, then my custom board with cyclo=
ne V failed to detect SPI-NOR<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Git =
bisect has told me the first bad commit is
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">31fb=
632b5d43 spi: Move cadence-quadspi driver to drivers/spi/<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Does=
 this change requires device tree modification?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Any =
suggestions or comments would be appreciated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Taku=
o Koguchi<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span l=
ang=3D"EN-US" style=3D"font-size:11.0pt">V<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_TY2PR01MB26522E5CC577EC60BD354085D76F9TY2PR01MB2652jpnp_--

--7Pig6IDJGfxNl40lY0rF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6277): https://lists.cip-project.org/g/cip-dev/message=
/6277
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7Pig6IDJGfxNl40lY0rF--
