Return-Path: <SRS0=wpNA=D3=lists.cip-project.org=bounce+64572+5591+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ECEC43457
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 07:16:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554542223C
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 07:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OmFSkG6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554542223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5591+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CsT8YY4521723xP5NhPpIVmx; Tue, 20 Oct 2020 00:16:06 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.128])
 by mx.groups.io with SMTP id smtpd.web09.1822.1603178165318158017
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 00:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp/s67rjSggPUFXxviVmmL8CZx4O2MjDyUI2xU20ioBwwy6lJHRUEpxQYWxitOjnjUXpTGVj6HYbhRj24SciNd39Tvxwip405gP9hTIINVpekSsnGxVfB6dx6uO/GsfFFmMVk8AawKiaMsM01MAQovxM6XurjRhrjuj2vVH4YqsrcJkmNVR+fpuEpMt2vBvyq8++15TZIEaWEfg0ly7tkB1I52UAFnNYBwPq2fFANHdtu03Yq38+IfiET2JmC01R0gKfzbrF7jqbUMh4hnPfAz8eP2IPmbrpNfJGf5GAz8mKGbGyiJIxIjP5OPjRj7eEAK8bfyIKTE/3hyJA1iDuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFDqUJVG8/1GvdzorbHUdJaQL2r0lWfqiFgjJqrzjMM=;
 b=a/9rRmjl2j+QrCFcUT6R0KeNN1pl+x86hPf/DuSnJ8x9Uge6M8Sfhnn9e+x0USgKFRY7FO7HsyjTjB2NheL4BVuJ+Hy6q9ho64U7xYfFCmYjLQS3kBB+HJy9dbxD8c0FlGARk7Qj1k3yqitn/C8wRS8vLuJgrTm2fn3apYfNPg/v4azukE6iA9FjzeeiQ1kpEzhuEWmQEusXQPvK0RU/A4OFETwoxkp7VkDvS6yCtnQlqpPpCKZI88xAUGKQ1sFgJUXaYIbV4ua9H8EOJGAXwd8NiEj/N3xswh+dziurXfB5mDgka9quVFxlS8ZnQTdNp7ctnRWLGJl5VK5umQOexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4517.jpnprd01.prod.outlook.com (2603:1096:604:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Tue, 20 Oct
 2020 07:16:01 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 07:16:00 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH
 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Thread-Index: AQHWoKK3exH1hEUZukOZtIVkSqUhZ6mW2nsAgAlFTmA=
Date: Tue, 20 Oct 2020 07:16:00 +0000
Message-ID: 
 <OSBPR01MB50488430A9BE629033D6990FAA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014093914.GB1866@amd>
In-Reply-To: <20201014093914.GB1866@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fa8b209-d270-40c8-56e5-08d874c7ff79
x-ms-traffictypediagnostic: OSBPR01MB4517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB451726820EC6ABE86156A764AA1F0@OSBPR01MB4517.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8gqW5Dgod/xiOfTlb8639xfFvHQFlqF/wBy6wRZ6jrRFXw/oJ6PNqUS23vnQdgQSw/nu9tYb//1Dr92cw9JHCD3sGWGIfydiGqdx2cyyPYrHzGUwRg/BaR/wcHwlGa7nI3XofEEBnItXFphu4kruKGbxyyVrnYeMYkATPbS8k3re0nkCXpFeG/f0aAerd4oC7H1VXCUkHQCmd8xK3Y0eUVwgYkLSgeLx25EQuO8lcOhulZzRDGtR4VVODaACQXUkN6ucT4zvjJQPiNxeqU9GOBETm4/TcdUksJUP5NycHfybXn3jhMJmfgD80TtTdj2tVQpsRhxuRHxcpl0r5bw8xw==
x-ms-exchange-antispam-messagedata: 
 NPI4v18VIHG9sWNhkYCjms4IqzHZquj9bBEgPCj3oTRVZJkgeDkADxPCZCzXGvD8q64xuGsvh2JlvO20b+rFUl9wYAFiZehYRtd2p+pqL0bdYqGKT8KObzWoPLGGDlvuHX3/ygKJozcv4miemjfnJEdHD1fJ3mfwPDTsgOeI8SvzTjAOY1cPy/P+8hzemIZmhzz+BRL9/8UYRbDlVdtE3AxjcCKFIrar0YJ2l6KoWLeBGv6nvr+LOyOy+tMhbnL2m8WRWbz+5XE4zZcD872UTQZ3G198z2TU8TqMpK0C1hVYWY6c77DYGOyeUFKEDmbSBVCNS7dyp3CUAbag/Kf8Vq9uqPi2ajG3B/WPK3tANKwYhT5aLpCUTl1pnJmthC+oBoEQPWsCp0xBm1zTA3OAboLMWsDf+kU8uXaT4HON4J1oRTIj4Eco57w5+yqp3MQ1KcwDjw2w2/xXP879eXMI8jRPwTbpRTPAsexZ1UmdX3SzQthT9klGHP6/AGOEzRcy3LnMB98nNGGPbZ7Y1yO/A48MKFTvil/GbVk/prqyXzZ+OdVD1wAfQ52VnRjAtX9Fsb3/Dmnpa8o0uCFBWg451s19CGY4B4EC1itz80ocH7TSziEYkFcuqFcQMVeCBqpOQZtD+hZIhb4m2Bt6YDrfiA==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa8b209-d270-40c8-56e5-08d874c7ff79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 07:16:00.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spyWzjSws9L43RjBKXqOZ/AA3uw7ZDoQRDXbTF9FZof1nRwu40+meLNCxQ1RmCenoAwv1IrsZSnxhSfoU6GaAE9hXlUlIPtWnCPPkfmqCgt6E4H40OAv+DTCAKqj276A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4517
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kxsKND9RE2v3okjUojKoogHMx4520388AA=
Content-Type: multipart/mixed; boundary="7PATr5P9vBnbTibA3Mbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603178166;
 bh=q4pbaEAi7cmMjnsc2Jq1ECud91gT8eLhtmIKxR5+9Gc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OmFSkG6+TXe5ACR+So8CTkqly4e62nJ8hUS4llLoysyYp2rdz7Va+Jjwd8iYUh3+Mg+
 nKnSKfVgVTivhXr6Jq2kG1wniJEy4D3tJ9b5M7xrrJS8iAxjKMJafNZa2aPsQtVKH0Aqa
 sssFT9hygmnzWxAkd9VY3UttDGEkWANk74Y=

--7PATr5P9vBnbTibA3Mbw
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: 14 October 2020 10:39
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH =
4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and
> RZ/G2x
>=20
> Hi!
>=20
> > This patch series adds support for PCIe EP on Renesas R-Car Gen3 and
> > RZ/G2x platforms.
>=20
> I quickly went through a series and code seems reasonably nice.
>=20
> > * Since the changes are huge I am sending the patches as RFC.
>=20
> And yes, it is quite big, which might be a problem. OTOH only Renesas
> seems to have PCIe EP drivers enabled in their CIP defconfigs, so
> there's good chance noone else in CIP project is using this code.
>=20
> [If someone else _is_ using it or is considering using it, please
> speak up.]
>=20
We haven't received any response yet, is it OK if I send a non RFC version =
or shall we wait for couple of days more ?

Cheers,
Prabhakar

> Could we get better explanation for 24/ of the series? spinlock is
> okay as long as code inside does not sleep, does not neccessarily have
> to do with interrupts.
>=20
> Should 30/ and 31/ be submitted to stable?
>=20
> > * Required EP framework changes and fixes are ported as well.
> > * All the patches have been cheery picked from upstream kernel.
> > * Patches [43, 44, 45, 46, 48]/50 are picked from linux-next.
>=20
> Ok, so we definitely want them in upstream, not in -next. And it might
> be good to wait a bit after merge, so it gets some testing in upstream.
>=20
> > * I was skeptic with patch 36/50 "Rename pcie-rcar.c to pcie-rcar-host.=
c"
> >   this is required as patch 38/50 adds a new file named pcie-rcar.c. Op=
en
> >   for suggestions if this can be handled differently.
> > * In patch 37/48 I have dropped the changes for host driver as the patc=
h
> >   doesn't apply cleanly and manually applying it was resulting in a
> >   big diff.
>=20
> Let me take a look at these in bigger detail.
>=20
> > * As the changes touches three other controller drivers I have build te=
sted them
> >   as done similarly while upstreaming R-Car Gen3 PCIe EP driver.
>=20
> Will this be tested somehow by our automated tests?
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7PATr5P9vBnbTibA3Mbw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5591): https://lists.cip-project.org/g/cip-dev/message=
/5591
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7PATr5P9vBnbTibA3Mbw--
