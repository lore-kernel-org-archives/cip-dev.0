Return-Path: <SRS0=eC2r=A4=lists.cip-project.org=bounce+64572+4936+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FC5C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 11:55:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10C2207F5
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AVDhGAWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10C2207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4936+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qshmYY4521723xAn6ZBZ6oVk; Fri, 17 Jul 2020 04:55:04 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.90])
 by mx.groups.io with SMTP id smtpd.web12.7552.1594976433681319960
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2020 02:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkS+Nk/cz79ByW1GZ1uiTOr5itGDAJAiCf4/c5QZWlMrHJwkK+dl0HHyhV+QY/H1EIaVG1APn8UOzZVlaA+q9uLsAduaDzu/RuTOTZMaNDQFP26c6siTy/lSOnf7pNTVQB2rS7sBbyJuxkwdaKLiO2LhFGpw60dTyp5drmvQq6QcvCDd3whlJHsQW2/ctWZ9JffTyhmzXqaxmdY7i5BmDmv1+hLPcY7W6k0VuBvQw5vwEdD/0wRJp8O9KNY5/2Y/WnaWGrCzjRDiJ8lVAGVBSp1ccCQn6wV2NB4HO5wykJiWKKP6/66RS9quZkBivZWcGQw8jR2wF0TitYMJOK5gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgYzt3aj63c5CEU4CsTnDILuAArmSb3RQdodr+e5qBw=;
 b=dknH7O+RV7Izmc1mIpFBv1zZ546pWhIdnrC/XuApG5++5762Lya6woUZf3/cjvb31m+MkcXUx1TxaqRhuR1ApN5s0fTK3IBYPZ2qNPpkR94AKZrYyrTyCuZu8hQgWOsLfQI8YvkP9HZhVR5UQTidfHbQvphDa8vlD/m4TFUU/BHwSLFkVrYGL1URIjOxzXndO5X1KdNJiM+1hDNf1Uz177Nj3TrFtepd8BlUwOdS+9pIXKYpOVTLwUo2XknzTSk25adx03ehdII2MZTsFEKZvMQwPuAgx0M+/JRRdLX03xhTgKEUVKBPpKWTVtMUaYlk3o1U5QeJx4aw8TgsHQre1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB5529.jpnprd01.prod.outlook.com
 (2603:1096:404:803f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 09:00:31 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 09:00:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status
 register SCxSR is read in correct sequence
Thread-Index: AQHWW3TmuvYwjSzAi0GPET0+djrt5qkLcJkAgAAAt9A=
Date: Fri, 17 Jul 2020 09:00:31 +0000
Message-ID: 
 <TYBPR01MB53095DA3014999489CC56027867C0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
 <20200717082458.GA10436@amd>
In-Reply-To: <20200717082458.GA10436@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2804bb95-cb34-4b1f-4869-08d82a2fdbe7
x-ms-traffictypediagnostic: TYAPR01MB5529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB55291F46AEB1E4DDB512D6A3867C0@TYAPR01MB5529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8HDMLlUE0Gi+Cb9+vOCHXWniFsIDWVlHFO93EBH9bJqmIz2n1CuuVbuC41KlHK74qKIM1ZOca67ja+If+k/cO0X5ylbnsLLxQL3cV/ATXxX77vpbWGMUmE2IeT3KDc2619LSWLMbkoCtu4aPdMRL3qNW5NDCSW+ufDb7rAnLS3DJGm2iO28qk6uZgzuxKom2loeg0E7LZ9AYasw/B6wqFpC1nvnTjPFdWsrydMiEP4t7cfWSIg/K1rMP/CXfHhdJ4vQFVvyBOKK8TD6oHT1uh2oVnL0Z1GwJ9w6FsRXE9rOIks4ZS4Ur9czvA0uvIhToVt4r8MXxbPapk5rxUuXkPWGAGbvETgcKEviSIZnGy5dJfkb8de3N67H0ipM1699ZilGc9vwmmW3kY+OGzMtyWQ==
x-ms-exchange-antispam-messagedata: 
 JkYk+zKQ9hzX8p/8YGY7ioo3C5RRXwtARqIqPXj0ro8dzHCTvISfFg8W3PALOg0ATsaQBc2UCPZ6sV+6eL3BkAurRzQiKi4F25//72/4hf+O+dpL9qKdYG47G2gyMJNxTIWJaBkufwQp8IH0cpAHkzDwf7ld2aZ6aNXmqMvaJJJWtk3AGp30pR6A0RX3UqdrYb5GNGP5sTjpLx2vU8jlnH4DWp4rFcuSbA1hbIEeX8lbi+DRAAJB6Up7gEYvwAxpn/uVyMX6gkcDEXh0xGRLz83L262Mo6iZTJH0zHypBe1yc0uDabPZw6pkRL/lWrJNXvJDV8mLBfp2FIKHqQCGVh92fZrQAXRu9KyvDoxyIm7IWPZAB8DPyiza0aTzPgeDSp2iQ1RPwOHiFLRRGmdEjwze22SIGfYVQvzbztmGBUHBOF5/Tiodz01v5SlQJgWLGL6Li355Xi38ZoblrXOYlof+Yh8s7kUTxjLBYAVJI1yw3iRvyGTOD3Xd8xaHgJLx
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2804bb95-cb34-4b1f-4869-08d82a2fdbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:00:31.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO/glTJOlVK04BMMkJBXETD3qss+hapHmP3zjgyRuoC0VVKLAPXHVb29oFaL76Se8BPYDN4884C+j6lNVdILInI9Py70bbSg4iQK8Sh+3IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5529
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CBIDQOHNCTeUFk16HtOAof9Yx4520388AA=
Content-Type: multipart/mixed; boundary="oR6BQgmByymxsGIblh3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594986904;
 bh=VmzzPiBa4s745gB0G3ZuNa1sl/FbM/n8KwwZLdqfGBA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=AVDhGAWwEoqDdMFqnne8vPShqzhoORUqoaZJwjnMWKgoYElpraSrD7CVQcCU295QmVo
 8E5Nekb7C6EnOwSLUJ4JU/g/jA09Gjx8Tne5InOJRtBFDzhZk2CByZuveIKaps/nBcen3
 pZXhnTneQAg7FSe1mIE5zUuacLd3lp5rO34=

--oR6BQgmByymxsGIblh3T
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 17 July 2020 09:25
> To: cip-dev@lists.cip-project.org
> Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel
> Machek <pavel@denx.de>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status
> register SCxSR is read in correct sequence
>
> Hi!
>
> > From: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
> >
> > commit 3dc4db3662366306e54ddcbda4804acb1258e4ba upstream.
> >
> > For SCIF and HSCIF interfaces the SCxSR register holds the status of
> > data that is to be read next from SCxRDR register, But where as for
> > SCIFA and SCIFB interfaces SCxSR register holds status of data that is
> > previously read from SCxRDR register.
> >
> > This patch makes sure the status register is read depending on the
> > port types so that errors are caught accordingly.
>
> Looks good to me.
>
> > Cc: <stable@vger.kernel.org>
>
> I notice this applies cleanly to v4.4-stable. Was this submitted to
> 4.4 / do you need some help there?

The original patch is not cleanly applied on 4.4 see the mail below

https://www.spinics.net/lists/linux-renesas-soc/msg48219.html

> Does this have user-visible impact?

No, You can verify this on console after applying the patch.

stty evenp

Test Case 1:

paste "p" on the console should generate parity error and "o" should not

Test Case 2:-

paste "ppppp" on the console should generate parity error and "ooooo" shoul=
d not

Testcase 3:-

Paste "pop", it should generate parity error for "p"

Regards,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--oR6BQgmByymxsGIblh3T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4936): https://lists.cip-project.org/g/cip-dev/message=
/4936
Mute This Topic: https://lists.cip-project.org/mt/75541395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--oR6BQgmByymxsGIblh3T--
