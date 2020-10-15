Return-Path: <SRS0=/HNY=DW=lists.cip-project.org=bounce+64572+5582+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11979C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343DC22240
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="McjkYK0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343DC22240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5582+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QGpHYY4521723xxUnJegH2bl; Thu, 15 Oct 2020 09:31:52 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.95])
 by mx.groups.io with SMTP id smtpd.web11.16619.1602779511916711936
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 09:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liujdxruA2waCrseITcZ39GBFq3bLduLPCNcliQtahr50Pfc7P35WJZlNq8dSgaKlYMPSWkQDOm89W3xrMNvPLBkSpDasLCmcS7cWDPo/XPYAlyUrmD6oiF6JSruZxK5Bo5V/TA74H+iWFvPiaYjJGhu6qpZj91Rwr5S0QfscRvb12kbH8ivfBV+eqbTOXeEO5pfn3TSxD4Az3MY7iMPZKeVrxeT9yLcAqPaTUNq+qFDQfL+MtsqX0UpfIZRjlhAfM9arrbEHMYjnYBggIV7aHlN9CBbfLqB3Rnu3bi8G5ZdC1MgsqpgSFuEVgV560D6grpfbwEG5NYOAwt9fMQKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYfb0/IlBBsGybAGfbdhZWqfYqT6wts1eJi9HnN+mV8=;
 b=W7lVqhO5wONC4G7pUfxWsdJdhW3Cv2TGn5L2dMg4PyN9VF0qyRju1InPz05rI9wOJOJN0ZId0vH4KhORa7auytRYcuRUa4zoq6GBYDAZ5e9SsnjeTO5rg2sj+0Y3v48OXDUBpv4lo/asgxFLxkhcJt1qrPpMt+EY10mmbtSnZUhgLZrQT9eOTXQoSqSl0/aFfiq2zD+/vygc8E4yMS39R6HESl9cV254xJY7A1TaFOjKLtQpX+MWvT8ITGHfMsFC6/Bvdex8BhFG6lqKmggBtmVRY1Xe9oEstw2ZAIUhwVCTiw9Q5J76+QnIEPHJX7lNsyvWJcnuy4Qg+4yNm0J1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB3206.jpnprd01.prod.outlook.com (2603:1096:604:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Thu, 15 Oct
 2020 16:31:49 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3455.035; Thu, 15 Oct 2020
 16:31:49 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode support
Thread-Topic: [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode
 support
Thread-Index: AQHWoKLcSt+8CZpvIUmHus58EbdG76mW1ckAgAIJQYA=
Date: Thu, 15 Oct 2020 16:31:49 +0000
Message-ID: 
 <OSBPR01MB5048542ADFEDC0D29EE57D8CAA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014092226.GA1866@amd>
In-Reply-To: <20201014092226.GA1866@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6995cdc-fb69-4590-0299-08d87127d11e
x-ms-traffictypediagnostic: OSBPR01MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3206B88F6EB78DE104255AB3AA020@OSBPR01MB3206.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 HNeJCkRCzRRS2uLkpZPzVmuveV8/FES9/TUyRY73/03HGc3pRRxfM8dj4N9Cst/lbN3spT0ZQrMXdiUwTpqZqgMHD1T1rLzAehhKuGLvEZz/QXaUxjvArFzfWHeDitYEUkP2eoOsLS3goD8KLY8NJqvOHYP+09DCwr1fgQZDl2C6EIQJnVMk4nyZVLXg3/O34P44EGTDrsuEPUbLnboFlM4z9u3C4Xq6C937ostSAYnPvN/5qgsAmsALK4fNQjgSl/fpjfhAE92C375guRMQVeVWSqkO+NQW6wue0POG6oOxXFdBybnm9g7l2elZnYSAVwx5qBQtZp9Dtxz3jM7c4A==
x-ms-exchange-antispam-messagedata: 
 tu7ItHJk51I8InjViLa0gwD3wlP2e6/nDZsTjEQqYrTTCN2j262q1FzAEUJG83u/eLYCguIkKOrfa9CGba22ysCl17xBnHZMzCnjS9dOyJbFSAOMr6NDLXNxzCrLQNupQPTu6Sagyf+fHU08psmkMelDarldiHK73472Ejf1hhMi1bNue9eA2js5ksWDgjDKUNxa8/jzSsLAYRB+yGixfhTWD1Fkw2UbIlWWC3LFIyOHCKYvE/CRUDGk3L8pgDIg4hUKAvWpFy3iwwpJPoEDghlmPP/cLSokGBlleBkMnIOGQPMeDpYW5ynj+Bqiqnn3arCxb5Vzzw/5nkfbMENzNrsUmlfx1pL9VhikDxcMvdMdVmU7fw1Bcxr4k1fUfus6btFrZXV2h2YaMh9rQ+TApnvkoZkWbOxUYZUNKpwLFSEVzwLkKo2E4a6774d0o/TQ8uivC0vXSAAgYWY5mR1T6K5F37bzQpXenn8xILDDpqyvTZ+IyyCHrYoertkXmnBJtJlR5q35cYToMS7tcJmkPKfgZqh6IRK6JWdJtiQzUmk6DyoZZu3WIL0dihH/vAfAvOGyZJAJjMeBCy/+U4F5YLKFD0R8vyT+B/VkV3cQQDeMq/rnsGW7tz+rmWrlADaSxD2EvfB4jy3Cdembgnjwug==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6995cdc-fb69-4590-0299-08d87127d11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 16:31:49.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZiCrZ8Mn6RLNOqpyRMPb5grane0O6JblGl1dEa84s01RErGl09mz/r0SUliC+8poXOXdRfAq66WN7YL483wnT3jBlWA64gv6jtCuvpVr4nBal3uF0KJxGulFAGymV2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3206
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Vi9Xu1BJX7izkCEixF12VQBAx4520388AA=
Content-Type: multipart/mixed; boundary="1rCI7DcmRm8K0RWyFFh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602779512;
 bh=8X5XdyEjhipHw2gBhJOUo3uWj6yeMgTKvNLb0N0ye4A=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=McjkYK0aAlCScODxinhIIb+QHQYRchImk1jGZFqb62De22l60TKXV5azZvW/u2nLMz/
 57wqB/ciP36AIWup0AYohRtfMJkClhbJoMbdEshlU99nIZNp/T2fGzSk+SWOUrc+muyHc
 FcH1rYvr6dlUKwtZwnZzGc+FeKbiqTulYd8=

--1rCI7DcmRm8K0RWyFFh3
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 14 October 2020 10:22
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode su=
pport
>
> Hi!
>
> > commit 2a6d0d63d99956a66f6605832f11755d74a41951 upstream.
> >
> > Add support for R-Car PCIe controller to work in endpoint mode.
>
> > +ep->ob_window[i].phys_base =3D res->start;
> > +ep->ob_window[i].size =3D resource_size(res);
> > +/* controller doesn't support multiple allocation
> > + * from same window, so set page_size to window size
> > + */
>
> Comment not according to CodingStyle.
>
Yep
> > +memset(&win, 0x0, sizeof(win));
> > +memset(&res, 0x0, sizeof(res));
>
> Plain 0 would be enough
>
Agreed.

Ill post patches upstream to fix this and then backport or do you want me t=
o do the changes in place ?
>
> > +val |=3D ASTINTX;
> > +rcar_pci_write_reg(pcie, val, PCIEINTXR);
> > +usleep_range(1000, 1001);
> > +val =3D rcar_pci_read_reg(pcie, PCIEINTXR);
>
> This is crazy. Either you need exact timing or you don't, but I don't
> believe usleep can guarantee microsecond accuracy.
>
> (And you probably don't need it, right?)
>
Indeed a sleep is needed but checkpatch complains about it so usleep_range(=
) was added.

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

--1rCI7DcmRm8K0RWyFFh3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5582): https://lists.cip-project.org/g/cip-dev/message=
/5582
Mute This Topic: https://lists.cip-project.org/mt/77461723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1rCI7DcmRm8K0RWyFFh3--
