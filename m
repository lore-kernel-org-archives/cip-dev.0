Return-Path: <SRS0=vly6=FZ=lists.cip-project.org=bounce+64572+5970+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4BC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 21 Dec 2020 02:40:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6422DD6
	for <cip-dev@archiver.kernel.org>; Mon, 21 Dec 2020 02:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6422DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5970+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mq4nYY4521723xOdb9I9yxfc; Sun, 20 Dec 2020 18:40:55 -0800
X-Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.4])
 by mx.groups.io with SMTP id smtpd.web09.34454.1608518454842063417
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Dec 2020 18:40:55 -0800
X-Received: from [100.112.130.202] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-a.us-west-2.aws.symcld.net id 3B/BC-03087-53B00EF5; Mon, 21 Dec 2020 02:40:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRWlGSWpSXmKPExsXSOvGJpa4J94N
  4g73PDC1arh1ms2iY+YfN4tbLdmaLn4fOMzmweGx4tJrVo3nlGnaPCy/vsgcwR7Fm5iXlVySw
  Zqy4GFJwjrPi/uOJ7A2M8zm6GLk4hAQWMUq0n7nF1MXICeTUSpz/1MEIkVjCKPF7/WsWCOcRo
  8T7K7tY4Zz2c8+ZIJy3jBLTzi0HyzAKLGWWuLDmFDuEc4xF4smJc2wQzmZGiUNbX0INWMgkce
  rCIWYI5z6jxIS9G9lADmATyJW4cu4jO4gtIlAgMefrORYQm1lgCqPE1F0JILawgIrE3FmNQEe
  yA9WoSvRLdjFyAFlGEvubREAKWICCsy8+YYawjSTuXfoLNpxXIEbi7arFUJ/GSFx6/5cRpJVT
  IFZizsxokDCjgKzE5F2NTBA7xSUuTV4E1iohICCxZM95ZghbVOLl439QD89ilLh/4ToLREJZ4
  m//PXYIW1bi0vxusPkSAr4S7dfEIEwtiRV7TCEqsiVmrJrBPoHRZBaSbRC2vsSeiadYIGxtiW
  ULXzPPAntAUOLkzCcsCxhZVjFaJBVlpmeU5CZm5ugaGhjoGhoa6RoaG+gaGVrqJVbpJuqVFuu
  WpxaX6BrpJZYX6xVX5ibnpOjlpZZsYgSmo5SCpts7GP+9/qB3iFGSg0lJlLfG+X68EF9Sfkpl
  RmJxRnxRaU5q8SFGGQ4OJQleXa4H8UKCRanpqRVpmTnA1AiTluDgURLh9eUASvMWFyTmFmemQ
  6ROMbpyTHg5dxEzx5rGJUByyUYQ2fr910Zmjl4QKcSSl5+XKiXOWwMyWwCkOaM0D240LK1fYp
  SVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMqw0yhSczrwTugldAxzEBHTet9z7IcSWJCCmpBia
  mA6X/bzb5SUzm6tgxzSDu7cdWvp1Xun2296nkcBp6MG/jP51wNI2lP+UW5/9LOoe2R/mIrT6Y
  9Yid+7TM5QNRPOtMr2jsLX560esdp8KWTF+Hi9KawkYZSUEscd0aOSVvNHx7LnyQb3FjUa14d
  c0oyuH/TvPDFbH72N8vOxn+bKavtfLBJBPbWefWOSnM1I3+/vS66OQJJvtO9K2RW8V3JLiNVT
  i7ON//2trvT7QWbcm2u3P9LtviiVv/nehzzrj8OPvalTlnksLn+YacZ9Di+cmR5Trzaf/V+cv
  WJp6pX+g+kVlC7+2ks0HdHf/3BX/wdXAvy93Edu9F2G/m8/d/Pbc0Pnk2Lkb6+U2JX0lKLMUZ
  iYZazEXFiQD/ebwBZgQAAA==
X-Env-Sender: hidehiro.kawai.ez@hitachi.com
X-Msg-Ref: server-30.tower-334.messagelabs.com!1608518450!127149!1
X-Originating-IP: [133.145.228.57]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
X-Received: (qmail 11295 invoked from network); 21 Dec 2020 02:40:52 -0000
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) (133.145.228.57)
  by server-30.tower-334.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 21 Dec 2020 02:40:52 -0000
X-Received: from mlsv9.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 73CA63C004F;
	Mon, 21 Dec 2020 11:40:50 +0900 (JST)
X-Received: from mfgw05.hitachi.co.jp by mlsv9.hitachi.co.jp (8.14.4/8.14.4) id 0BL2ekJj020753; Mon, 21 Dec 2020 11:40:50 +0900
X-Received: from GUjpTK3DCemcs21.global.hitachi.net ([158.213.250.22])
	by mfgw05.hitachi.co.jp with ESMTP
	id rB7yk3ljcH89urB7ykXyQ1; Mon, 21 Dec 2020 11:40:50 +0900
X-Received: from GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d)
 by GUjpTK3DCemcs21.global.hitachi.net (2002:9ed5:fa16::9ed5:fa16) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Dec 2020 11:40:50 +0900
X-Received: from GUjpTKHDCemcs01.global.hitachi.net (2002:9ed5:d24a::9ed5:d24a)
 by GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Dec 2020 11:40:49 +0900
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs01.global.hitachi.net (158.213.210.74) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Mon, 21 Dec 2020 11:40:49
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTpPAXxTaV2GFIx0SUjb8Q6kZmOMwkqgj0PYM9In4hwbJi8zT3fOyHx7Gveum06IIqwsPdPUd56fZHPHw91N9iVli4ynCXESDrz3cyo2RmTRNO5psIDpmBWF0wSgAufYz6uLSB7t3sqccJM6gPvMRoVzR1jiWjgy2albakLc8Cr8TNPCFOJjsUWiN6DeLmanH4Kp1likCxmuJNe+hiAwTD+nVzPUqZDeA3bNMSSQ17od8p+ksZPvFTURyTLIECTFFIR0BsuKCUktV7t8OmOUBtFmOwP40qwggs3p9rHrRopsIUiVQU3o3g4cTF8EeH/9lvBJNHIbLDgtoRdxFk4n0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2MXOGIJsMiXS9Q93NKsGJ76UTfWnHzuVWKH5DDQAPA=;
 b=Lq0WrgMfD2iXLQSiNuZreo8QjOVqlA6tMKnpsA9OgchcSkDXruEc+DknV5mizHYE8lmszR3f1l5go4gkwXTOIXa0scfXjJujkdDTogacwkD10KCgOL4JqCK8JU5HFSMf2c5Ukpcj5yTWciOqGgvuTJ4/HG9XbkSDOSLgPNuoa04Z1eo+6wZCAd1fxI7FSGEk+eCQvdYtsXwACxqNRul/jj5/BLRzK7tOeyvrIMpUy1P2dvi2hjSlo0SfO+AgP7NS2EVHnLSMnh3STz48O9CfXafGD6DYXp3eL3hnypGCtdL6E8ZEDPJohmphl82C2MmvX8Y7c0Zww9e3HPt2i0jpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com (2603:1096:404:88::15)
 by TYBPR01MB5440.jpnprd01.prod.outlook.com (2603:1096:404:8020::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 02:40:48 +0000
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4171:f1d1:9c3b:47dc]) by TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4171:f1d1:9c3b:47dc%7]) with mapi id 15.20.3676.025; Mon, 21 Dec 2020
 02:40:47 +0000
From: "Hidehiro Kawai" <hidehiro.kawai.ez@hitachi.com>
To: "'masashi.kudo@cybertrust.co.jp'" <masashi.kudo@cybertrust.co.jp>,
        "'wens@csie.org'" <wens@csie.org>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtg
Date: Mon, 21 Dec 2020 02:38:31 +0000
Deferred-Delivery: Mon, 21 Dec 2020 02:40:00 +0000
Message-ID: <TYAPR01MB2429B78798C5B1E0E68DA577B5C00@TYAPR01MB2429.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f00bc9e-1be3-431d-56da-08d8a559d267
x-ms-traffictypediagnostic: TYBPR01MB5440:
x-microsoft-antispam-prvs: <TYBPR01MB54404860D7B3FDB7FC0FBBE3B5C00@TYBPR01MB5440.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vEMyD5zVztbVPF/qyb+6Xp0EGcoxPkwpJLPC8YgLgzc7BR2j6Vtr2G26y/QT8/bJtTijPbQ+C7tYeTdWPerGVolA0OqNr8HcWvqElFczP+UeacX5Fo0619CDjO6ZFifJfD86lBA40JY3ldSYeAUzP8MWWOVhze4hADAQre2BJwhpmi99gThFxFZSJrmcI1ZymQ6EP6TPoMJHS7CMbGyg4m1LH810tkwmGH5zSv0hxvZIkNEn4QFzSyAwr4+fSDr0xkVy6n1zmOFV2OvIH9UTegE2zN+hDBHVYExSSs/gWe6npsZLWXkLoauRixUpEeRM8x4hDuMeywIWP4BO68LfpdW8k2aFN+YeGyE0rTBlfWmXFOLX1hXvyIE5TAc7TD6mGA7CYVdCjKBZ9fTFHNeIQRcDB4TkcMcA6jSFJC3LDKISJCn6/vYFrFuN/5PivsI5ghYUjN97z+aBQSFCPWSgaG8E1d3THTZSuKlOceDrGp/geZtY8qZcHk03hfV9hx8o
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?NDZ0UTVPemhCWS8wbXZDOHZqKzR0M1FZZDc4K2Q0ZDNHOHpSRG1hazJy?=
 =?iso-2022-jp?B?QnNVSHBPRGFnOGJFQkRFNVZJdkZLUFU1bEM5eVFkSGVaT3hBZmI0OXBm?=
 =?iso-2022-jp?B?bEJPRjVlM004N0NuTVZmeUlsNldGMWxHSld6bUIvVWNkYk52dHcxNFdx?=
 =?iso-2022-jp?B?WisyUnV5Ti94R0FUVjBpYmR3NkFVejNlSUJkbnc4MXFjbFA1b1hJeXNU?=
 =?iso-2022-jp?B?UnBJNjZMVXU2S0JNK3VNWGc5UklQMzllaDgxTGFpUlRKME1WSURpV0Qx?=
 =?iso-2022-jp?B?dkwveThJUm9mWUpVdDYrbjJOcGJvNlFudFNKRTJISGFoeDI4bGRJZTNG?=
 =?iso-2022-jp?B?NGJMcmgrV2grdkpKWjJNUFNVU2hobnk5cnZLYk5QbFJKQ1BHNHBWbVV2?=
 =?iso-2022-jp?B?WWx4STBQdnA5U21kZHVwc05CSDJJZDJ0WHUzY0NHanc4ZU0ySmFNUVpy?=
 =?iso-2022-jp?B?c2NkdmNRdVVXd1NqeWU2YzIvbkpWV2lKdERURFpiM3dCNXZtMGJmRXFk?=
 =?iso-2022-jp?B?Nk9yNzdKR0xVQWI5bXNsMzF2WVBwb3FwMUJvQ0pjOW1SMG1xeXdTN3dL?=
 =?iso-2022-jp?B?T2xEVmN2bGQ1R0htblpTamtFUm1zMDJyd2VURHNoaUYwSzBUeGxodDQr?=
 =?iso-2022-jp?B?SFZWSlloWFJJZ05reXRoeEFHWEdYVlREZmg5UHB3Rk16TnVSRVBPeDVG?=
 =?iso-2022-jp?B?b2VPa3ZxdXk2SHFuQll3ckNoa1RON1VLUFNwYUlHRjRiNml6T2Z6Z25x?=
 =?iso-2022-jp?B?cXZUc25PTUZmRmhqaTJhL2NqQnV6TWplNHlOYTFNakZLUnlrbjhpaHhk?=
 =?iso-2022-jp?B?WDU1UGRhUU5UbnVOaytRaDk3ejVMM3BBN25jcmZqUjRmY2k3Vmw5QUxJ?=
 =?iso-2022-jp?B?NDU4STh6dVkrNzNTTGo5NnROTFl0RktjVGpsdVNIUFVtdjZxaWlJaVBp?=
 =?iso-2022-jp?B?cEUrTE8yd3dqb1Q3N2pXT1IzckRMd2JUQ3dJSFEvRk1aRWZzcDR0NVhm?=
 =?iso-2022-jp?B?Sm5XSjV0aGdENDBHN0E3QkJZMXNKTWs1WS9YNXlUakUySnczNmZaS0Q4?=
 =?iso-2022-jp?B?Qkx6bkJzVXlINFZaeGw2U1BXa3lHdGFzVTlCSy9xalhFVGRlRmZ0Y2o0?=
 =?iso-2022-jp?B?eS9jM1YvVFFTYVVQNzBrMXltOCtlYmJOTmhuL1lvN3Q2dVo2WFd4SzB4?=
 =?iso-2022-jp?B?T1p2cGdnMVBMeVdIZjdIQ0g0Y1JPNFdySU56d3N1UjdHbENDOUgvbVNx?=
 =?iso-2022-jp?B?aVVDNzBIbWZDYzcwMVFoUDlWWmZvRDBJbU1YaFNMZldQNlVObU5UQnRR?=
 =?iso-2022-jp?B?Vmx5bmIrM1NKUGFudjRYdVJ0SHduOGxGQ0FKSzVNd2VTRU55cnp5S1c3?=
 =?iso-2022-jp?B?bUN5Nk1FTk8wVjZjenFZRjhJc05jZ1JQQmlrMERIWVhUWVlUeVBySXBi?=
 =?iso-2022-jp?B?VHlqZEN2NW9PdklFdDBmcg==?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2429.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00bc9e-1be3-431d-56da-08d8a559d267
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 02:40:47.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcjvUKGNKbJ2RfUD1bYK3CNTmCgmDflQrsQVFxYfysvn8Wv4N9esy+kqTlIYDE+yOsacrnYXXlBW85TlctDhf4oGS9p2VU/TswjAWixH4GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5440
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GzbLVkOijhlKF6iY0EjKPirnx4520388AA=
Content-Type: multipart/mixed; boundary="6YbiTmBNLem2of6Smn5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608518455;
 bh=ZvBgxfjUNHt1BwKQrgyRP1ox43rLiNey/jPg0c/Ht38=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Yas+whgYqaXjB8QGwNyzReUY3se0Mm7U2l47LWo1WaRQnZ20At58FYBI2uEqCFF48BL
 6WzUl0gf5baxDClEBy/33C0Gj67me6duBG4yw3VZI5FKqeDMUMD82twFhOqWsB/Wd6/l9
 8jaxVnXufjSAbXNaOTOe+TWDD0UvFhUmLgo=

--6YbiTmBNLem2of6Smn5B
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Kudo-san and ChenYu-san,=09

Thanks for reporting the issue.
Including nouveau driver, it seems that our defconfigs have some
unneeded drivers.  I'm confirming this with our development team,
please wait a moment.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of masashi.kudo@cybertrust.co.jp
> Hi, Hitachi-team,
>=20
> Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the following=
 email.
> https://clicktime.symantec.com/3Hrgtrrm6ninbLpVgrZpbS37Vc?u=3Dhttps%3A%2F=
%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2F%23u
>=20
> According to the kernel team analysis, it seems that the nouveau driver i=
s enabled in hitachi_omap defconfigs for both
> 4.4 and 4.19.
> However, the configs are for OMAP platforms which, according to our under=
standing, don't have PCI for a graphics card.
> So we think that the hitachi_omap defconfigs should be corrected to disab=
le the nouveau driver.
>=20
> We could be wrong, so please advise us. Once you confirm it to be correct=
ed, we will go ahead to change it.
> Best regards,
> --
> M. Kudo

--6YbiTmBNLem2of6Smn5B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5970): https://lists.cip-project.org/g/cip-dev/message=
/5970
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6YbiTmBNLem2of6Smn5B--
