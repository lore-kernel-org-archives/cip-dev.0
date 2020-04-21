Return-Path: <SRS0=RkeL=6F=lists.cip-project.org=bounce+64572+4593+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BCC2BA19
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:34:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C5320CC7
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EMrNZUNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C5320CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4593+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DzbRYY4521723x9uvdUH02kK; Tue, 21 Apr 2020 01:34:29 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.112])
 by mx.groups.io with SMTP id smtpd.web12.4845.1587458067672463636
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2020 01:34:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkF4ZuxnABUn+VSuVGsKK3pLGiHVUWAUvEK2O2XiRKXFmmLy+7ylmqMepQz41iwdHJeUSmoHlF5ib3PkgKNLsSodLiPalOOEf1u2vvODXic5/EYHLSzBP0UhpWpXk5Y3DMyCnJTBmSO3tc0z76Ta7B7cYN78Waj6l6d3q/jLhNu9A4AbD/ZWC6TmOUgKlb4+aRfwzHzYuyjD84UXDZZgLnjaPH1rhNoAWEJquht/b7FFpP8k/Q9zkigTIsHB/9nAJnWkXr5uKFU4fXoQp+K+rRnwn/9KiBaYnYBU9bluXQDwIkfJlWzxJ/1YHob3eWmcK2buBYL5VaYQ2qnbV1BlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VsGT7zPxn/erMCVrtcn1g54kArCs3TBTTngEXGL8lA=;
 b=aprvEX8SP5J0meyzm7M96dTpNzC+sFENmzvpagDwSnh85z+rPC0nEDW8Z1AXWLg1oRufP5uBTazKMPHFbLGEfWi1+xdSsGyglVwD+kXh8sBaMTH5nc8nxPorCURK6X8IpRLgJ7jFUFJJZrVW7HRoe2LTUlZL/OtEbJBFHg12Kgm8o2BvtEf64hmJy8DRPg2iKQ+GbeBGtkNaFBq6SK5BjTvZwDiSH2wcNvTzEWc3sXG1MSZsANR6wy+1FpjL9pD5pvzYUpc7S+hcOW2eUJH259DclPj7/MvnoQVnFkqYUURNtClbgzANtKFtnrPvawmsVCp8rBT9aXn88k0v3g1ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB5094.jpnprd01.prod.outlook.com (20.179.183.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Tue, 21 Apr 2020 08:34:25 +0000
X-Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::383a:9fc3:aaa4:d3b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::383a:9fc3:aaa4:d3b%7]) with mapi id 15.20.2900.030; Tue, 21 Apr 2020
 08:34:25 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110wr display
Thread-Topic: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110wr
 display
Thread-Index: AQHWF7dEnZEbRXmbxEW3YSSE1n7uJqiDP0wg
Date: Tue, 21 Apr 2020 08:34:24 +0000
Message-ID: 
 <OSBPR01MB3590E5EA28170A1E12750991AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: 
 <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200420202445.GA22198@duo.ucw.cz>
In-Reply-To: <20200420202445.GA22198@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8efb753-cd50-4aff-2a26-08d7e5cecc5c
x-ms-traffictypediagnostic: OSBPR01MB5094:|OSBPR01MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB50942D226345E1F98B1FE46BAAD50@OSBPR01MB5094.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 LBhx6/QubPtRubMpDAHcNdLoWT09GBDSVr9q4uyt6rOMrX7yZq1wccwMQISOlQYGMSUT/bMmPIQIZ4KkLiQMTykZBeQ5EQkKHN2JBqh8ym6X0rmG+SbtpUaKL0Okao8cv9olMcHEbogQY50094GOn881k2ZrOGg/Lj1rWLecLgGj8TB1NTSqTqQwQ69C7TotO85WekV3GYwi/wmrdFRhQ8oosS9Ee+9u+dAOpZ4gvz6dV08eBxmifvTifcjX5NASCF18CxkS9H+WV/Oy+lAI65dsmcIIx5MNh55iDHoKB5BsbjgGdd1o6On9IhmtYuYXdspLt+zS29YG62hoTCOOdktweAXGQd7qfoQ6iUClQ/7OeYTsHnuh8XoXrRAzA3S+CTOO/rT+AkUySCZK+llkqQEofBwaqOKjtmUX+tHWSwxoQm+ftMaRbNnC+AnEKhDf
x-ms-exchange-antispam-messagedata: 
 S3lQFNRUOGif4tqYk2Y5sU6eC72Y6+ii9Zuq2+yhEHDFnJlbIF0vzW33JNO05FmYBjo/IBZQ9GFvM8ftZO3HLlFmYt+JARz9Aj45ptw6SyBgQn4PpS3/bpqsYyqDg4jognrVNgUvLazg6oAlJi7qIg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8efb753-cd50-4aff-2a26-08d7e5cecc5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 08:34:24.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4hBek9/9ZIFg6PJv2N/87eMJ3oH/fMz9KrIPDz47sOT+/8yTy367CQtsgejca8K34Am5b8MWYojK2psVo4R3Xo0IZzn8RIFQEpw4nkbnfHbC7PFd8CODoxA3yaW7GQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5094
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H6YCrFrDqT8HphyaKGz7PhaFx4520388AA=
Content-Type: multipart/mixed; boundary="BFZW3Z4lPTCfX4EPqoPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587458069;
 bh=SoGG3DInf7LrxyVbzBgI6/VrMT9aEgmywmtaO2rpfiI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=EMrNZUNQq9/uYvOClXLKxj5pW3hGEGIciJE5tQPlNI0i3iGVm/Hzfv7qwh0i7RZkjZB
 KVWOfij+o26YWo1e4flwjyAYRGYMS8/bIkupDuQKAzy7jh5FoNMolgyoyC4kUoj23jexI
 P8j+I+55cZyniEPxIsig5OalJCVEhq6fSpU=

--BFZW3Z4lPTCfX4EPqoPf
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: 20 April 2020 21:25
> To: cip-dev@lists.cip-project.org
> Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <p=
avel@denx.de>; Chris Paterson
> <Chris.Paterson2@renesas.com>
> Subject: Re: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110w=
r display
>
> Hi!
>
> > This patch series adds support idk-1110wr display on RZ/G2M board.
>
> I assume it is for 4.19; subject does not say. Otherwise it looks good,
> so I'll test it and apply unless someone sees problem with it.
>
Oops my bad, yes it's for 4.19.

Cheers,
--Prabhakar

> Best regards,
> Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--BFZW3Z4lPTCfX4EPqoPf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4593): https://lists.cip-project.org/g/cip-dev/message=
/4593
Mute This Topic: https://lists.cip-project.org/mt/73158050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BFZW3Z4lPTCfX4EPqoPf--
