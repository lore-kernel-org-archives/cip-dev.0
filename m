Return-Path: <SRS0=BjNT=DW=lists.cip-project.org=bounce+64572+5581+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E187C433E7
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:27:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D8722240
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fOYLkT/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8722240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5581+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Yf1vYY4521723xoBTkGNIuLJ; Thu, 15 Oct 2020 09:27:30 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.128])
 by mx.groups.io with SMTP id smtpd.web11.16506.1602779249854076706
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 09:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiS/VfczlPxYh/KyOlWAbvMh5J7KJhkqKU96CbKDEt6h9o5kslmlSa+FfSOccouj8f9BDwUHO/ARkrMZGAq3lPnbcoLlEwLB2LwZisMFwzb9i8X4YicCNRzZwaQ4Ci/1RcAH2mqh7KT2kWuIK+Lha+LL/lht8SNad0vzDUsfS84wpiU34MKxnnvDH5oUuC1LzNpz95Y76TKXq/oYihm2TheeaUlMtP5aQxU2zC9FQJVszF/Eiw/R72VmN1YzQ4NiaEfzK+3boAx9DyZ3q9caU/Fm46UOLsl08TpPl7C54WSy7KLP5Rf5lq8dY1bDDSJuO+m8xCxTe2jkNVfrlgTkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vop0nilf87WeJs9AXE9iP3IQc/0btoFFxS60QFcTeE=;
 b=H53tpNeKIJnuUxbwUD2DqXju1v59JH3gnzF+kRkx7UkETCvhvwYe4P/vGe2nXZU2n4Cp0rRxIEhj4X/O2ycFAmjKGr/+GJ5DVnuFJaj1k6BiuzxvRWyLi86+SRaK1xcL5rn4ilJhTnoJpFK/Sap64aINqTy8inxJNcsxdyxrJlkAeF557su3hlsTNxIhraBgbc0KYSBVaDhKAqSJEXnvtSHbsKUUcf2ogAc1sgbDtgAsE4UkQ1eYaSFziyaHVOlIIz8mR+KFFOgTQFJqGrMn4KWxyZExnOxKY2Je+Z9+D1uILPijCKnTdwMscHiy25rEHYE5qhYEIIfEnSOaQhAcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB3206.jpnprd01.prod.outlook.com (2603:1096:604:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Thu, 15 Oct
 2020 16:27:26 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3455.035; Thu, 15 Oct 2020
 16:27:25 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas
 R-Car Gen3 and RZ/G2x
Thread-Index: AQHWoKK3exH1hEUZukOZtIVkSqUhZ6mW4meAgAH6KvA=
Date: Thu, 15 Oct 2020 16:27:25 +0000
Message-ID: 
 <OSBPR01MB5048AB34A73EEFA26FCCC4DDAA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014100735.GC1866@amd>
In-Reply-To: <20201014100735.GC1866@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1279d05-7475-400c-4cd0-08d8712733c6
x-ms-traffictypediagnostic: OSBPR01MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3206BF9FD7A232034C7398A3AA020@OSBPR01MB3206.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 N5pAtLEYbJOQzUP/fvDgE8De+a2Uf+usQBP9LF/M6LZotaBJdzU1AEX3aN0A7IeVp0bgAP8oYeYg8mlkgz/h3OdM/8wDaK6V41VjJx9NZixXH/5Xivln5AFf8eVaO/XByYVCsMtMmL2/LzgUe/geeoSfiYcU5es0BvvimrYe6pt05B6wxcK+dA8V++7NfFPUVOiZNJxP0U1lszdaF45usZqAi8nYKSySfNs8rSmp5+I+adhku5iv5Sm5qEyElCt7wIW9hz2KLCGZLLg52vgVRMEghPn2Cj/bwBjDlPcAb+59rlI9EtHAfWObCg/7qO/9gUo680hPZnx5AOwFOq/mMA==
x-ms-exchange-antispam-messagedata: 
 EbxYo2eh2LzUmViYh4N89Jve86LriqMzF/gibF4aumxB9fW0NZDMEIERGehwRVVcarCyCFvVRj6FufJMWamyauAjXc91SU4j2zlorBiMwk3qcDP4Ccl6PYBh5qUnAFg6yEhVSbA8doojCV8svGqPfEhMv2/J82/iMQnOlWTfgZE78k+6WeL+soWxvDXKYA0vOrO1qyBY5KT0AdNgB9N8TTMSplDn+lkiIWT2n1y4jB/R5G5sKcTdWJdShFRip8gsxfJn9Ebc8D84B18HaKudwtxqUb3LIwfzTg5yB40IUkoLn5DSDZjl/TxmoVV2SCWJ1YP1F74jOCz9g+QT69dpDtb4qqylBVWpDcjgma+EMhCVzLjUEwyKjJ+roB8V925irVR8asbiXvwI9gvlFrllspkfwV8d6c4shMRanMTtXrTPzAjutiFvRxHiiCUH1zMSXoLEU+EsoSesmKUuK2wrRpMMOQPUA1oj7BJjavQunYFuHfui3WAui8NeEiwduZGLt7XzEsbOaA7Rit81zFpBfIyW4MC4RcZqEH9EwBUmA+yyr1vKKHWpM9WhXnL8qOX0HBYeUt3AhLORv/7Zy49ksQHdimcKSbCd7QiVpKZ/ZswkRFM8oCIUOmsYfYpMX4pWjoQem3M+A8d8LkRM9k1ZTw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1279d05-7475-400c-4cd0-08d8712733c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 16:27:25.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZlNLt3s4HkMc4Ny0l2uv1CRuX6Wv+0ue86q6J8dM/RnAbEPx4eV5koiAz0xy0sdpojqT8OCeAWeqNX84i3z6CYtcV3P84o+0AuLhJnn/dypJAzmKweFnlvEnCI/jKnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3206
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CyiJoWlDmy9ne0qi5ep7L9cFx4520388AA=
Content-Type: multipart/mixed; boundary="YvFceLChVn3zzg9o75l9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602779250;
 bh=tbPrm7vDln7WyIuxhrd3Xhb2gT3fxi/wnZD/BPzufA4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=fOYLkT/Aq+AdjPK+ZsMAh4Xiy/CuKyFd6+jdxtI4yujGz5eRLoMEVSb231qDeJKw0YG
 6j6I9rg2VwzNsvwHBXm+dEaaGnm9vwlXMe8egQ+tLzkiHd4ijSDTmonS8HvWHGi4+kyRL
 HEgHUd8Gf9PPa9HA2XKab3hJVHF9sdeqDWw=

--YvFceLChVn3zzg9o75l9
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 14 October 2020 11:08
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas=
 R-Car Gen3 and RZ/G2x
>
> Hi!
>
> > * I was skeptic with patch 36/50 "Rename pcie-rcar.c to pcie-rcar-host.=
c"
> >   this is required as patch 38/50 adds a new file named pcie-rcar.c. Op=
en
> >   for suggestions if this can be handled differently.
> > * In patch 37/48 I have dropped the changes for host driver as the patc=
h
> >   doesn't apply cleanly and manually applying it was resulting in a
> >   big diff.
>
> I have no good ideas how to avoid rename.
>
> Given the change in locking previously in the series, manual review of
> changes in this area might be good idea, anyway.
>
The locking changes are wrt EPF framework anyway.  OK so I assume you are h=
appy to manual changes to PCIe host driver while posting non RFC version.

> In 4.19, there were 75 patches in this area so far, and 5 patches that
> would reject due to the rename.
>
> pavel@amd:~/cip/krc$ git log --pretty=3Doneline v4.19.. drivers/pci/contr=
oller/ | wc -l
> 75
> pavel@amd:~/cip/krc$ git log --pretty=3Doneline v4.19.. drivers/pci/contr=
oller/pcie-rcar*.c | wc -l
> 5
>
> ...so we'll get a bit of additional workload from this. It would be
> more scary if there were -rt specific changes in this area, but
> hopefully there are none.
>
> I expect that you are willing to help if -stable or -rt introduces
> conflicting patches in this area?
>
indeed.

Cheers,
Prabhakar

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

--YvFceLChVn3zzg9o75l9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5581): https://lists.cip-project.org/g/cip-dev/message=
/5581
Mute This Topic: https://lists.cip-project.org/mt/77461654/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YvFceLChVn3zzg9o75l9--
