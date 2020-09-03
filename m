Return-Path: <SRS0=ROZj=CM=lists.cip-project.org=bounce+64572+5405+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4850C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:40:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D7620737
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E9dgEadW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D7620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5405+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VBY2YY4521723x4mW2eWzBFZ; Thu, 03 Sep 2020 10:40:57 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.102])
 by mx.groups.io with SMTP id smtpd.web10.19806.1599154855482706797
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 10:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhMAqCZasgewLi5cBEJns1IXu7FdSMMikjhfHEjqGByfa/6Q2XTeGpJb0RWzfcbABRpS7YG9GfLkNhn+GrZw5J693B6wkuZ5/5BXE9Jo9p3MwBdv70CqudxnHJTQLvHxXrU1bpeQH3N9HjfoAQCx7Qb1u6E4YNHoTnDgKtglCjBOf06+inkvLiA0yh4cKhf/VJxqm+mozm+eMKc2VMqOoOvQjUaw5NuTmQ3VjP3wX1FwUp9+iOGfoHP6Cf9WTjdvqJVlUYlTNdPt4nF6bnhNZ55DUiM0uSaku+sZSJMTUmw0LIybA0DjamcrShH2ZRdL7onhs0544j+nXCvLKbUuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWxSOnK3HDIYgpzN6KtgipCSKSJL7Wq2mjipGR2o8jw=;
 b=OgBkeoDkOjha7Y0Q0kR47fRswt8f9SAHQN0/Yug08HnjsjA1Glz3tD6CJNHxExmnb4LVzteanfWT5INFLhoHj/qucnbP7R0YMPkR4T7sD/kFNaGZ/a6zS/ci1vJsbkRLzjPExS+/W6tke69Vcb9shatUlcj1K6khQ1qSG41ak/QxsDuTpg68kXCCyvYN3NlcRGFMzQhIt3lvR5cr6h94tawxhoeb2OVcob5eW69fvihF81iZJC3CTzjHv9t8XhL0MNRdm5S6essF6MWLAXyS3wgXCQPFxHDlE2d5mps3S8uaklSMLfiq/aEDrnvizUykrxM6aUTIQumc4KA7pPQRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2517.jpnprd01.prod.outlook.com (2603:1096:604:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 3 Sep
 2020 17:40:52 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 17:40:51 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] of: Add missing exports of node name compare functions
Thread-Topic: [PATCH 4.4.y-cip] of: Add missing exports of node name compare
 functions
Thread-Index: AQHWghgdaGUNMUx48ka9I7Sq4yG3/6lXLO3Q
Date: Thu, 3 Sep 2020 17:40:51 +0000
Message-ID: 
 <OSBPR01MB50487C1B7518C6B4B7835E37AA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20200903160052.8806-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903173146.GB7795@duo.ucw.cz>
In-Reply-To: <20200903173146.GB7795@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b798ca29-dc03-4615-cfd9-08d85030807a
x-ms-traffictypediagnostic: OSBPR01MB2517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB2517920950C3FC0D49046602AA2C0@OSBPR01MB2517.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 nM5Nm/NVIgVJM2DviO7TLI+99aIctp1jbVmnciHR6k9kD7f2mcW/OQnAaqV1FVgM/PMMapXXcsEcOWH2W+lihGY3XIwrM/3Bsg8RIc3b71sDroi2ay0vnAUze7vo7T+ITb14e9ERT3ENzOsHv1RfRAE5fe3BpuF6PBAuuWFhc0qEbVo7bLGOl+AFcC3Yw+DvTYz2YjKHsmr58oVNaKwo+SIFFBUJNUHyCQc16uyFWSXyWzBfTb1mV2k1vNwcHCxVCd2gU+sBF4HbeFDgB2BDZ4SYW4l7EVVyYgOleFRWqS//lSdix5E1XzSVLYiTQg/8s8HLgZOSr69NxVQIVlshAw==
x-ms-exchange-antispam-messagedata: 
 mgmVCzMvPSgxR+4eQ2V8aFsa5kk2PdSRnGER9fbe3z3v9oOydN26+KCXgwPOuq02OKvgWYQ8e0ghtYeWv19CxKNmN9SPWbl8IFHJgN7LeiIpYZwol2HmghsshZFSo91fzb/MPRTQ4mswQt/D03/1zDT73YqCACt0lV13XAXqIQuq59xkiD3QCzkUWTup/VQfMbYl/1qOc1iO6D3gJbEjbvZUmfFbU1oxXgLLpqAeOd2XyF1Fo6Hm7j2S31JquhqpkylWZg1E0l1cAwatHhWetymwI9yqFVDFe0RrxX3EFJmykuHv+1Wg+wfiy2i0wFMzBO3Vuayu/5ngMGGHDteH0qB1e4FMlERN0ilz5UNcyIgxCQgZQwQkstSi45cmi2ypidGr0ukTTr1AAX3uo/ji6Cqniq/fh0WUd9bpPwfPXD5nwWWkD0mrr4QjPRL2m32KyiIxIhnf2gAp5zXIKye2DUQEuDygxQ56JxeO8OxXEVJigpz2GElQpZ0+HTSxwLMVDQu29R8V03RlJ1dMRcEO6PcyM1gR3asoqNoaSAQQoYSiJZg1D3WWuZU0A7TzG7ZMjL78YdzmjAEPAgmQpaGf+TmwfmCkChT0dBRj6wKUDrdOVl2hj6erAijzypQNhSmaFZHMLtKInMcLTdzGw4vZHw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b798ca29-dc03-4615-cfd9-08d85030807a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 17:40:51.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxaIfhZQ/1yx5RvGLid/+Xk9MXgledzSTAwua5Wg6gxEORCgOh4s+fM9eSr+dntyhA24PnNM0EvTSfNamBoMLz/Efc5w8G3LZq8wB4Mp7KvfRE80E+jrcgHVQBj4aADQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2517
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Siol9ZpqonFd6lsRG40DAlbrx4520388AA=
Content-Type: multipart/mixed; boundary="D7gmF1MXLoXd2Enl1wPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599154857;
 bh=iG7xY3sL8gnFiPeFJCtbDSNMbtwYb7tTRKP911xts6E=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=E9dgEadWWbjeC56WYdqN4P5ZpSD9B17JT9fbxD8W8tGO6I1k9bwvB+8sKmJ82WQCvtY
 iFEjGKHAWq6IjnGBtiGRk5hByVn+42bl36BXIWKqQE2+I0DBhqXnJBTKFf3gYolKQhKm4
 m/T4BOGRrxQobFqXpp+hDiOiEiAqG623iHk=

--D7gmF1MXLoXd2Enl1wPC
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 03 September 2020 18:32
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip] of: Add missing exports of node name compa=
re functions
>
> Hi!
>
> > commit 173ee3962959a1985a109f81539a403b5cd07ae7 upstream.
> >
> > Commit f42b0e18f2e5 ("of: add node name compare helper functions")
> > failed to add the module exports to of_node_name_eq() and
> > of_node_name_prefix(). Add them now.
> >
> > Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Fixes build failure for multi_v7_defconfig
> > ---
>
> Ok, what is going on here?
>
> I don't believe f42b0e18f2e5 causes build failure; it adds functions,
> but it can't cause build failure without a user.
>
> Which commit fails the build? Do we have that in 4.4.y-cip? Can
> this be placed before the buggy commit so that build is not broken?
>
For multi_v7_defconfig I get this below build error:

ERROR: "of_node_name_eq" [drivers/gpu/drm/rcar-du/rcar-du-drm.ko] undefined=
!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1
Makefile:1161: recipe for target 'modules' failed
make: *** [modules] Error 2

commit eeaa48eee492d ("drm: rcar-du: Support panels connected directly to t=
he DPAD outputs") fails the build which was added in 4.4-cip kernel.

Cheers,
Prabhakar


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--D7gmF1MXLoXd2Enl1wPC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5405): https://lists.cip-project.org/g/cip-dev/message=
/5405
Mute This Topic: https://lists.cip-project.org/mt/76610346/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D7gmF1MXLoXd2Enl1wPC--
