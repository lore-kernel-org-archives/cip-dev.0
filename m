Return-Path: <SRS0=nSmQ=CN=lists.cip-project.org=bounce+64572+5413+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DEFC43461
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 06:51:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A408206B8
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 06:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C5w0mdFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A408206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5413+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qaO2YY4521723xfKyRS25xos; Thu, 03 Sep 2020 23:51:53 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.105])
 by mx.groups.io with SMTP id smtpd.web10.32820.1599202311515355317
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 23:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU2ksABgfHAzK9gkHvIIrm0pel3tW5vIpXfD13DF2aFvhbAITQvbVfFh44qixp6yn2crcSzauyoTcT7aW6/4uk4tbmWjgzg3lHN2MG+MgY2H0gJxEtLMX/Mp52hQb2bEkl+ril0oibIQgxWwr57vomaytTfsU46AkDuq4Zx/jQ63RMOJU1vwMhz9f7m2vtgRgKG2BsGrnVWFT9d/tWKDX5CL4yiUJ7nF+Ehr/vs5DxXV8Kxt5+EppJYPjYrBOFc4UmBWFIlo7iK56Cbr66rHZ0+j82WgUBf+RbP6wfcfwtun643PKEf0e0WkRozp7kRez4ZcSISJSlTDNgAHHoy89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfWuStUJumGlXdNW0YAPqbYlK9JObQjpWmxc5dEI2ZI=;
 b=LTxRpq2KhAGd/5TO8U0gIB9ZTbCF8ZhjMbrrbUBaeTCZhzjzRgiK1m/exoZWeyE0zdkkc93QyVrYKE4NdeQqQ4tN6dx004RUPBtsqmguS4D4X+ubSC47PVOQe+jaBO1Np4QvcVOfVUWm5PxTszGDoeHxKtSqkpu5LjTsJ03qai38NazmD/yujbaG9HmiaZm9xTsWDTu8NvQoBSOUJTkc4oXX5We/vMuYn4Pmu8Z/cLT8nvNX+6xgs/VykuaQLv8jsBKQbrJvdvcsmqioG2zaDvTMpXNWsSBVMJkUC90+QPvlzYk7JqU6xg4UFAj7+bEkAAUgcbrBKdcVuUAAfqAeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2630.jpnprd01.prod.outlook.com (2603:1096:604:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 06:51:48 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 06:51:48 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/4] serial mctrl_gpio/sh-sci Fixes
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip 0/4] serial mctrl_gpio/sh-sci Fixes
Thread-Index: AQHWgf5aE8QEhjKzaUiWlQb1LVUI96lYCr2w
Date: Fri, 4 Sep 2020 06:51:48 +0000
Message-ID: 
 <OSBPR01MB50489D99A0B1C42AEBAD5102AA2D0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <16314C4E8BAB0A6F.8972@lists.cip-project.org>
In-Reply-To: <16314C4E8BAB0A6F.8972@lists.cip-project.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25dd3ff6-8bda-4abd-09a1-08d8509eff17
x-ms-traffictypediagnostic: OSBPR01MB2630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB2630F669AB0471FEE63D4BD2AA2D0@OSBPR01MB2630.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NNeWRnhhEztvpBYE+kiFbreqLQZQY/WU+Agad+YTE6eT2AH7yw7mspMQV3IB+U+MAB7xN8Pgn3MuyVJ02TIwoBa574PFvmoraY0i7sEJkLTJWRCUYtVaLuK00IIs9wfcbuhlbn9TOfv77xDxgqBhoicinUNZ4/EYwm1nwOkk/My+Qdp1gAjtW3u9q2hvvCBxb7XWZkaDmRtbABc0VSA8RO19pDGcPyOHMTLXlDimhhRbKXOi/xlrtKsHPE5MvqDbqhZjOxlSfgdqmooUTz0BUmtdRE2HVElv0tM0pZt4zPYOpFowb4qIbwsD2ynfUM4dyuFiMeIqtPEGcdnuvb+MkA==
x-ms-exchange-antispam-messagedata: 
 /dZQtrKVm9i8jq24qp2DakvzjXPL9EA7FTPfmZxtyg1/ccqZI8Z99o5U6XVbDSqxsXUW7kAiNcPGw4fasomf4axY5mYKE8pCi9YDYUQ+pAl4xWPzZDeAazlmZQoQRR7VVYyrFvrQtAXp18T3C5gTUonxiGJ46pbiSPQNkHxctexSzZUf+/XU02uJZ3LfO4jZAEIXQ8ybR1KFTuUrcEcDZWzYf51imULIGpahXlEaFKkb7QPqnoIwKuU7uloHLRjWP8ijj9rH9E6eDZ2nPVnoEdt4vpE2VCPbkyZSOPNEjZEV81XzWo5dqFsTS9RS4p6j/8GU3MlQUvVL+M8rdM0XZbM3QOVxyGcRURpaM2NK2Uk8pi7DNvfRwMZZ67wmZkCcTR9tr8+DoNOd9AscZ7jp7Afn8sWDRCjskr6hSFct8GK/9Mm0GqGt5oTM3Gf4zkI182bGZhHW0kkS7WMvg6Gs8F8P3UMpj+jR1HHqFA1WlPiJt0rwE0SGbXJv9stE5E2wXtmnP0zY5bzWt5RHqghXehSEWCOD/dDR+4lseUJMaDY6YOJjgQr6xg7AWBrqSLRvzA/9fQrDaPHf8rccJCnJFY+rVsUGbrfoDOso0CCyB+ly9vC4xu9SlXcmHEUfKC4FHxYlJx6H5nLXpW9uX2pOZw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dd3ff6-8bda-4abd-09a1-08d8509eff17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 06:51:48.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTvbhXg+ygC8fST42ZVuT4AM+fVmmEz30ApFN4pv7znLdfiMkW1joyOK6C1G16SB2x9j7NbasSM7C6s4h85JeermrLE7ghQDeBws4dJEIZcdG4SsqQh6BfETsISNsodA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2630
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vcl9caPKCPfdxqFwai9ERudnx4520388AA=
Content-Type: multipart/mixed; boundary="riJyNr9jk52Ttd09or0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599202313;
 bh=vhz/1w6/8x8LLtauHh4uYUJZ6amo+C+qFD0E0tguSsE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=C5w0mdFQC4eHftfd8D2j07nnyeuHi81ykRouBXgv5oJrZowHKihoYh47qHdS74bQZUM
 +xx2Xg6l+DzdnKOR4ffts1w0deeiuCFoFj7EqilzRFhnWaRvLOrM4mI1R4jbSHYisV/Yb
 HgZVhPv1vXUgL7Ai/j9OvXvs7BJHGN9279Y=

--riJyNr9jk52Ttd09or0o
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel/ Nobuhiro,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via lists.cip-project.org
> Sent: 03 September 2020 15:27
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.4.y-cip 0/4] serial mctrl_gpio/sh-sci Fixes
>
> Hi All,
>
> This patch series adds minor fixes to sh-sci and serial_mctrl_gpio driver=
.
> All patches in this series are cherry-picked from mainline.
>
> Cheers,
> Prabhakar
>
>
> Frieder Schrempf (1):
>   serial: sh-sci: Don't check for mctrl_gpio_init() returning -ENOSYS
>
> Geert Uytterhoeven (2):
>   serial: sh-sci: Terminate TX DMA during buffer flushing
>   serial: sh-sci: Don't check for mctrl_gpio_to_gpiod() returning error
>
> Stefan Roese (1):
>   serial: mctrl_gpio: Check if GPIO property exisits before requesting
>     it
>
>  drivers/tty/serial/serial_mctrl_gpio.c | 15 +++++++++++++++
>  drivers/tty/serial/sh-sci.c            | 25 +++++++++++++++----------
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
Please ignore this patch series. Pavel has reviewed it and has pointed out =
the issues. Ill revisit the Terminate TX DMA patch at later point.

Cheers,
Prabhakar


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--riJyNr9jk52Ttd09or0o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5413): https://lists.cip-project.org/g/cip-dev/message=
/5413
Mute This Topic: https://lists.cip-project.org/mt/76607960/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--riJyNr9jk52Ttd09or0o--
