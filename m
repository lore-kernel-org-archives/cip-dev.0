Return-Path: <SRS0=mqGG=LP=lists.cip-project.org=bounce+64572+6565+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD70C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:23:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCB860FF2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCB860FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6565+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dYzhYY4521723x9toU2kDfTr; Mon, 21 Jun 2021 14:23:07 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.132])
 by mx.groups.io with SMTP id smtpd.web12.20.1624310585845907974
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 14:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhIW6i86Urr1MZ86Vpgx9VEKq0o5Auw2CJ3lxZM0KmOE5BmlJp7H8anreTCTtk6OEi5IZPs7XyxGUrrkWHKmqSXvgjD6QjW73QH3vfYrcNll7hnrIbMNJQCx+cHOF8gmwFtuj9btKQlXkmGuCMYlL3Q5sx95Xl8ZLQTA86VazHO1WUhCcUE12wlFXAyqF00hriqsNTszYI6zacU+sM43lJcWg2HvKIdCfyG8IbwoSPE0MF1whWcEgXDfbJe8HJr8R6FHmj5XuzdZI3FZXv2XPrBBVO2Lp6mdTZN6qTfdpFANAPo0tLSYqqY0Mq1dtxM/vgL2vHSw7sm9Cstt3I9peQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWq2UBaDVd4QcbAAUWXDqkg7fWURrrkudBKqq2Zxv8M=;
 b=FYjlKP5Z7+iEFrMOh2lBX798nEghEVwrSbIl/6Wb8DNCETjaAZQY7NoVQJRSvvE1XsBQhhNlg+1vysuPyWD37eBftEerPEMiTRTSngIJn424UA02i+/c4CZiydE/5gnqdY+kJb8J4y21VaZ0HQy6L2Q5tU0WtDj8qr2HPA8P8pvf8Ye6FS9H4OL0iCYNQ2cb3qa/wiqCHr461SQhXxeDnSaWZLPaA6MfeU9OZyEP91W+O2ogag57wLgxwbjywNxyMVm1Le9Qq8GkY1Ue4PzmfA8YOekuEJ9X0qNSegGQr7+7GK7lJII1wBNBqkvpt/gohyKMd3y8W43BeiOgeDPbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB2695.jpnprd01.prod.outlook.com (2603:1096:604:1f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 21:23:01 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 21:23:01 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Michael Adler <michael.adler@siemens.com>
Subject: Re: [cip-dev] Failing -stable-rc tests
Thread-Topic: Failing -stable-rc tests
Thread-Index: AQHXZtTA75fwnI1y+E+zKqDgBaUn1Kse9diQ
Date: Mon, 21 Jun 2021 21:23:01 +0000
Message-ID: 
 <OSZPR01MB6877C72DEA6B911F7DC43441B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210621193629.GA22045@duo.ucw.cz>
In-Reply-To: <20210621193629.GA22045@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de9a1cfe-7a2a-4b11-83f7-08d934fac01a
x-ms-traffictypediagnostic: OSBPR01MB2695:
x-microsoft-antispam-prvs: 
 <OSBPR01MB2695E2EA7BD8E0B56468A807B70A9@OSBPR01MB2695.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 w4GlABXbDbNPOcDV6xwbpKePYnOmXkzDeLe1ty3AgfHUVrah/3NdenWw9mZ0fZU+1wg3sHU4217lGL05T9ay62eyI70IqyjAtfB6jSFJwKGurjZdutcGrcgGHKEZ1QwVHM2+cCloRt/LR57ozePZ4bebIfaiJyqieyUoZavwNM4GjP6O+ENZ2YVY6CqgQOImRarEt68d4a3ceadaeKNAcpH16rnNVkvpqkUb6Jw8tmUuTEPlx1nGFECFBJFZm99N9h+YjwOSKudt1iElb4siGna1bdRPH2XftQ5Q7FbecT/0hcjuEcGg1qvhndlBJ/Wqyfmreibyvj2blDldx/+hZ4/0egDe2gzgCX0ptQN6msXUmSVfo+GjE11rtPUlPmqzMJhZciCGnuOTDEGInSZivpb2mF8Me3L1bVA6ixwFlklxD69slcEcxDtwzAevnbVAwwXNXeimgqFs4P7l68HcVXalkYjxaBjOwpc45mVjD5gSE2bRkjH/GbUFcHVCaRL7mL1tNu6B0AtqF3gfM8/kz8tatNAsRJygcfP4UpxNYGbei5FMvG3IFA2xOwspHkcu+SCGIuUT7acYryVg9e1dfsNCPtTT5i1WkceQ3EqjPNuiytPX2Xqpo11KA/cwCJAH6pMExnKxdiRyerG2EopRTvRs+at96iYU3Igyjgzz+8BNBajy1qcLPNDNPzVeU0pJDdUvrfpXv4X8XMOe97hVG6x7DUjw6m66lGKJT9UB7Orf9KYGIkZWHYCGhuym373jrOhpfLDTQnkZAcrAiIZsGQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?F9U8HnhR3I8tFRAg/NyXqVcAHAHfEwA+eorATv2wMSMkbhj3h9qZyBvV?=
 =?Windows-1252?Q?xCvCRQJQcy4uXwhqPhQSRjHQgJEP8hWzQV+ObU/HILpVXxZkWSwdkYAH?=
 =?Windows-1252?Q?KkCDwqe8A6L11uAAKos9Ft70DUl3twF4IUhDCvDpZut0GgGhV8xd9rJ7?=
 =?Windows-1252?Q?tcHLflF76ZjQkSWm2ZgPm0yW4ouLEnvAjmDmj+Trs+XmZm5J4Hqdjkx+?=
 =?Windows-1252?Q?rnsm2t57rs5Zfg0+s/sxXHtKoaVvGj/MyqoUHwLiFK9uRnYnk3+05F4M?=
 =?Windows-1252?Q?2CjNeRvX1PniC1PnRGseONTdBfzb2UZARJ/vaHqDmFZQDoXZhOm397N7?=
 =?Windows-1252?Q?FRONNjs32WoY6O/VXMrsnKPCtXGEhY8amCaSZ2RyqjssVVXyLwBgS8Vg?=
 =?Windows-1252?Q?w6Hed3NVaJupbpcnA/5T1fZbXvstprJZedJv323i1qOMnLPbuenXUzFM?=
 =?Windows-1252?Q?wvj4Qez+5rs0BV9F7oraZQ2lS7X8rgIHK04zNQbk0G+gaH9GgXZpJdtD?=
 =?Windows-1252?Q?+qpSu5MHtIfyCPHjspaOYLDEK07IzkLVe30wGHOdT8QIZ/qcxkkv1Njk?=
 =?Windows-1252?Q?0eU+DWOslBVe3KyveF3DMek+9Oi3XwLaW+hOknvBrgm98YB4yW9gJkfa?=
 =?Windows-1252?Q?YovY4znx51XFumM0AASoAZTkQ000fRs12jtSx350mSScYS94gVCs8Yvx?=
 =?Windows-1252?Q?H1lGPum/zOilucV+RMmCxN2OuBBPZlo1Mzv1MEsWmEKxZXmY9GMyAkVA?=
 =?Windows-1252?Q?cGZc8zlsPPUfH0hX4gAkxyjSXB5fSzh0GpuctcT3AdMQ6m0urJNuBnNA?=
 =?Windows-1252?Q?9U5PnlcWIX5NTTNNXRpFMaSeaOtkYwiZBx1/syEPrNxyzxUbSpAhv+3o?=
 =?Windows-1252?Q?P15kYU1/T0b3VhNMjxi0lbFXokO8jB4PpQpiyf1FfD3vd6FUHQpejlLq?=
 =?Windows-1252?Q?gjty530OLMn5m8Df8SFlcUnitWt1wGLzsPtNawC8oevJLa2V3xe3EEYz?=
 =?Windows-1252?Q?BPdfceekVnS8g1Kq1jYEwZ2EJ7ZZHes4zLecZm2jcJufNFLHsIseMVMG?=
 =?Windows-1252?Q?u/wZILRsPg7yVcfmd9mFLt7k+X0k9UFw5YtTFvaYNzEPYu490w0XV4nw?=
 =?Windows-1252?Q?CCPGwdDkw4C/5bwrxLlF9eX1gj5TezzKrerqkdszRcbeyViNQ2TSASUM?=
 =?Windows-1252?Q?xdlnNhtl0e4uWA5gkQ74AmMkdbE+vAK3gRalNcNUZ1PWIG1IRfOIi+oF?=
 =?Windows-1252?Q?MS37hy8yc9O0g0JgON9UAh6z7RljM9NGDhNC20DoPDier1T0o0aThQMi?=
 =?Windows-1252?Q?EVe+CVazGFfe1yuiab9YM1g9bOD6PaSfoXOgtSkM96oMfK7wDT5vCOF0?=
 =?Windows-1252?Q?sgqc6Ov1P1XIBScXFxBkXpBIXyWkmIHmZOZeXi4VyxhYoGpo590sVp7/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9a1cfe-7a2a-4b11-83f7-08d934fac01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 21:23:01.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd5vcts8IaBz3QIdrLlL4vUojgjsZ2SRnHMoCP6FwiUa6vPyUZ0+w0HOxKkDV3Zx0Ykk06MHopvAHd80YnMklbNlyQmIltQ0oLbdjFwQ/dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2695
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 10g1kJ0qGYIX3jr6TBDVnrABx4520388AA=
Content-Type: multipart/mixed; boundary="gvs5hpX4saySceoK2ZUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624310587;
 bh=eG3/2KfDvGoJUEGUS01LgBM7e/p/CGyKUQhmO+Enkkc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=UvEvtfNx5jE/o2RmDs8gH1Mg5LtVa6wP8C0f5mTPIj0ehziDqk5zAB6nK0bGvzibF6k
 tA4SB+5uL5gwlfXWw5R0ChIoorFpLGTknprDz4D4X2zg0AaNyUKEr1h4vCICaOpkXoZ41
 ZHKjAUjP/Iwc+zG831Ps1hLXXH0Hz7Ip2y4=

--gvs5hpX4saySceoK2ZUd
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 21 June 2021 20:36
>
> Hi!
>
> This is one of the common failures:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/1364210937

Thanks for sharing the details.
We'll take a look.

Kind regards, Chris

>
> The other one was not seen today.
>
> Uploading binaries
> 79------------------
> 80upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/config/.config to
> s3://download.cip-
> project.org/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/config/.config
> 81upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/kernel/bzImage to
> s3://download.cip-
> project.org/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/kernel/bzImage
> 82upload: output/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/modules/modules.tar.gz to
> s3://download.cip-
> project.org/ciptesting/ci/bzImage_siemens_ipc227e_defconfig_5.10.46-
> rc1_c00b84692/x86/siemens_ipc227e_defconfig/modules/modules.tar.gz
> 83fatal error: Could not connect to the endpoint URL: "https://s3.us-west=
-
> 2.amazonaws.com/download.cip-project.org?list-
> type=3D2&prefix=3Dciptesting%2Fci%2F&continuation-
> token=3D1B7XIJq02rzWljriOBePCr8doMhusLUS2jft0k2cLqJDmAxWeWFzs3V30z
> hXBtgfV87AvBf1P519d7AYS%2Bp7qt3yEDm7KapIDVvcmIAG8WJCA7F3O0u48
> 8Gs0%2F7oSTol6DRSt%2Btj3%2FJ4pXB7ZEDL47m4GSSNa0YzUJuMi%2B%2F5
> MyuaYuejHVTPV5mLw0GBv5oSzxDtIktUYrKcshmrP2CJh5A%3D%3D&encodin
> g-type=3Durl"
> 85
> Uploading artifacts for failed job
> 01:39
> 86Uploading artifacts...
> 87output: found 11 matching files and directories
> 88ERROR: Uploading artifacts as "archive" to coordinator... error
> error=3Dcouldn't execute POST against
> https://gitlab.com/api/v4/jobs/1364210937/artifacts?artifact_format=3Dzip=
&art
> ifact_type=3Darchive&expire_in=3D1+month: Post
> https://gitlab.com/api/v4/jobs/1364210937/artifacts?artifact_format=3Dzip=
&art
> ifact_type=3Darchive&expire_in=3D1+month: dial tcp: i/o timeout id=3D1364=
210937
> token=3Dd4_rH_yF
> 89
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
>
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gvs5hpX4saySceoK2ZUd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6565): https://lists.cip-project.org/g/cip-dev/message=
/6565
Mute This Topic: https://lists.cip-project.org/mt/83697468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gvs5hpX4saySceoK2ZUd--
