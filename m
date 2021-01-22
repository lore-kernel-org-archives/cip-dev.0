Return-Path: <SRS0=JbcR=GZ=lists.cip-project.org=bounce+64572+6134+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9BC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 22 Jan 2021 09:06:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC25239D1
	for <cip-dev@archiver.kernel.org>; Fri, 22 Jan 2021 09:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC25239D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6134+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PhSfYY4521723xGNHnzwFnY5; Fri, 22 Jan 2021 01:06:19 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.131])
 by mx.groups.io with SMTP id smtpd.web12.6589.1611306378099081058
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Jan 2021 01:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXVWv0CRC0JqJMV2jGjK0oUV2STZLFEVVMMlCaO3jkH1vTrjxaJJDY6/bW9wYQRu9YtvA77cXx33RayOhbDX/cZJDtKhcnefjSjxzr46cXKMiwrwC+TyIwtUvA+ya2K5YAQHleQhTJto8nLR+5WSUovxCGICGt/+N7PmbEExsEfyuOaxokJ/K6CCcWu/HUdJD33b4i353LdXxB75Q67NWEPBC8ConfCqiBLVJO5qQ7In7PwvDpMAH5OngNgi/cPWkpVaz84kGZtZs6fnggSDpUkiOzlu0bl+HoUVy8GjU4498tMNtyKSNwXEh71NYIf3DhDevJot0Iivb5Jrp5ZfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmAvFtQ/SLZ/9r02r0akREFHDY1jdo1zN/U/EJMbCuc=;
 b=KV8dBPS783ezvpiYJ7EO1Fk9lty08jL1AYinT7QgZlMW3fkof2q62f5Pl4ed/wmjVzYy9pvRYloF6vCXp3qOWaL0UPrNPgE0S4RsotwvB07hUBtKL2KhlFItu+FXXJ1QEYkynSRlrIJRB95Tdnpvf5sr6OJ8tJrs7ww5r3JnlQsWYmNHlfyCMOGv8dMG5AThyRHglxKezxjXFPovsAriWdywnC+1OKVg/9d6pmiBzssKiXMjc2bRkGMduIrZu6le18r3+Q+1e5nDAAXBCde5y7nnYpIQarR6KjsFRdgm0x26u6+R4MEYWbNEE6bwv1UEDHjE0HCD4DcbY1HZIQGUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB1490.jpnprd01.prod.outlook.com (2603:1096:603:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 09:06:13 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7%7]) with mapi id 15.20.3784.011; Fri, 22 Jan 2021
 09:06:13 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] Renesas support for 5.10
Thread-Topic: [cip-dev] Renesas support for 5.10
Thread-Index: AQHW72JqIrsjXf0nWk+XY2O3Nx886aozXBeg
Date: Fri, 22 Jan 2021 09:06:13 +0000
Message-ID: 
 <OSAPR01MB238574E54CF30107A32A00B2B7A00@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210120192809.GB24348@duo.ucw.cz>
In-Reply-To: <20210120192809.GB24348@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f859980-e5a2-4200-b9f6-08d8beb4f819
x-ms-traffictypediagnostic: OSAPR01MB1490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB1490E017A3D0701DC8B590EBB7A00@OSAPR01MB1490.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 xflnFmt0P0gQxKlrPckofeh7G4mmbw9lDAvhYn92D1bQQt7LQkOHii7lo5uMK08UngV0zQ1Gkuuz+KnCKrPAdNza5LdbUk1dN1u8XeiAqijf7QgSjC1dgIDr8lxzC6LKIlTQM6vg3u2ccrZl/fYezYVjt9VPoKtIy1LChstR1tnIZhG/J51JRPRy2LBYUmmpIcqZpMWa9uPNKkKavLETDqQ31LRa4+jEPBz02qcT5FN333JgS7T6VzSXEWUllfwkLO3aMsl0Hwt3pMhh0iEpadwTUyICWTPo5ZURqJworo2vnDnzY+et4AOoaHCdB4kbaqhJNWp8On3mm9TjNeNad7jMsAv7gLvfh+65z9B9eZVUsPQE3Im9lhslEvSVD7gM
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?0fFHu6WUgM6bpVtEG4TNZ6jNe3AvAFXPhEqwziA7sY+L4nLyhURJNLqc?=
 =?Windows-1252?Q?/vi4YxStrdkPDN0BPVF6EOtUZHODFLocCgKgaqM3n5ulTvTO771ZThkn?=
 =?Windows-1252?Q?qZrLJKL0haANK3IysQQNcdpvMhEARoPrMwowAW8xzZg+P/QRbKA36HB5?=
 =?Windows-1252?Q?QTtSOVwAj+JepNjWyUS3fyis9KSv/PKRtWtThnSP4jIRcWkFiSnlb5x2?=
 =?Windows-1252?Q?00QLGn5PnXAt2aQg4WhQT+bb/hpkgNrKiBLqpMrEhhTbnz7FbX0nEsNU?=
 =?Windows-1252?Q?q6lDQQQmhzuDiqOMWQ5ECzp6Se8TNlRJxsf8xn6ggBogZgPK/rVbH52j?=
 =?Windows-1252?Q?4a4NyaBIiav2jfpv61uJNwDuNcAlT1HCqYdLfjyRb0Z53CqqGX0loNWx?=
 =?Windows-1252?Q?xjynzDGerG/KJU3670CVjOFQdlAFZhV8peNkWzGwXWObiLHD2YZiQ7U0?=
 =?Windows-1252?Q?TJpBieylJsRF5LIIOOci9ERxszl61x89HtQK5F1OxCgECKIOBmZ7ge4r?=
 =?Windows-1252?Q?3JYwQNhQBjEiBKF/lT0uclh7Yy0vVcA/UTs8lpZsNjbCHszr8KErm7Pp?=
 =?Windows-1252?Q?SHQWsdunUAewbOGuQYB89MkK6YXlLMmYbQMCJEVnIBhzhF7g9V/RRw9e?=
 =?Windows-1252?Q?PQ+uZSwjzHE2NXIJKkYUm0qy5i5E8B06P4gSFEyvWD2l+ns+WuBQJle2?=
 =?Windows-1252?Q?yOON4XM20j0ZoK/dICMxdzAyJkZuyHbBFZYh6W9kzM9eI6jn5OAUeWqI?=
 =?Windows-1252?Q?MqCptmurSEEMWUHKZZMQQMebJ/+5AshC41z4+kcE5oHGkDSH0gaP8+s+?=
 =?Windows-1252?Q?mpKzwBPK0AmNAxyXWqJdh5rfK9FvPdPHnOVzpKuDZK8VKLK3KZH82Czb?=
 =?Windows-1252?Q?QQ7+Tw3FT0AEBJNArbc96cANUAWB269RROaSFHrWhVlcEgvc7YabY3nG?=
 =?Windows-1252?Q?UIJp8IAuwNOdXz3Y/c8bCT4UbM9PLibkOls4d6gqixSQ+lbi0i/WkMIL?=
 =?Windows-1252?Q?pPpz7Lng7/6xt6br5/m4ldXWIrUGhtULxdx5BaNOEn/tcMncuNA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f859980-e5a2-4200-b9f6-08d8beb4f819
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 09:06:13.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hw2qtas1/5pUqLEsnJLCucGvXmrELsvjmA86+qrQ638RYzUDdnx43LYFvbdoOJ1MFezxIQxiEdTK9PHwx9Z1sgNBjxKBYAN1Ndar4wbty0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1490
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AJM0nLsQezTdhc2XVtgxSl3ix4520388AA=
Content-Type: multipart/mixed; boundary="vJua9E4u4VXlaqhB3EcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611306379;
 bh=nVWDvaRLakH/FuwKpa/fBjdVSal+wVpFBeJrgkC5Y0Y=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jZsDiwSk+WMvMovS7OW/88UtRMzhzDOs4yXROehxSl7MjVMdJyazrxDqGfs/37VFyJK
 klxRaJlMABajW91R7NorjW/dbBlaH0ilhnQi4YZuywz9WDEW4X7gYau0AmbkL7WWZtqkz
 wcdDEWOTankmJAXGEAqeJ9rPZ9pTsPx78Aw=

--vJua9E4u4VXlaqhB3EcL
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 20 January 2021 19:28
>
> Hi!
>
> I believe there are few patches in linux-4.19.y-cip that were
> backported from 5.11-rc.

Yes, and there will likely be some more soon :)

>
> Could we get those patches submitted in the usual format?

We plan to, yes.
Although it may not be for a little while as we have some higher priorities=
 at the moment.

Kind regards, Chris

>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vJua9E4u4VXlaqhB3EcL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6134): https://lists.cip-project.org/g/cip-dev/message=
/6134
Mute This Topic: https://lists.cip-project.org/mt/79986495/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vJua9E4u4VXlaqhB3EcL--
