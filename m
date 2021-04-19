Return-Path: <SRS0=FIbG=JQ=lists.cip-project.org=bounce+64572+6380+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E43C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 19 Apr 2021 06:48:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EE461107
	for <cip-dev@archiver.kernel.org>; Mon, 19 Apr 2021 06:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EE461107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6380+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yNSbYY4521723xwpI4rcKJIh; Sun, 18 Apr 2021 23:48:42 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.133])
 by mx.groups.io with SMTP id smtpd.web09.5320.1618814921157578356
 for <cip-dev@lists.cip-project.org>;
 Sun, 18 Apr 2021 23:48:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8ce85S37UbmJIE7q7XMu11eUSN5oVQa7oLSDPbpI5Fml2JpiLBV76qoEFgRM/wr6zQNjoRc38pgss/Q1bDXSYtwqMkhGKNT3BFIHvdOlr7W/aE9Z+TimdLz3gr+F3tf3sYhF8Fl9JzU55OOeVHQGKofHlTlj3m0tOtpmgt+Y0ZsdTpnPCkaqewauB0L4YqQDDZaCWeKqqDMN02VZwdIep1AfDJkXrvB53ZNLlM3/hFRnMSD03Ty7rMGHAOmGD1P0vgL/eA6nYLkijBhRvObm/o4csiERlSNpWWgzRQd9/541slq3OwZnSxUX5bFhF06a7Wy5S3xPT1gMVl4HInJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auZGmvQDvr3DwyLLyujdxbeTBLPLNYJ2tE3V5A3Yobw=;
 b=iBW+NvLJIkFSidQYgfolwFZWsPHznsn8O2WhuD8ZfNeWLavDGJBYgIJIP8G+++w41EyRQOx1xDAEvGWG7TI28tVRRuOUTpgCVYUn9SN4GbN1XgETyX1Zd3jlc89qL+ZJ43sVwfeTTaKfyhlGhCXSWmTiNVeXdLPD49TxVbLed6CLH6QkCQMFxQe709dRgLFe548/T1nU4w0zLoLZcJoWugpw1VdtqFbeApPmPQRSgNbs9il5AvEGhoJUi786aOT6Qyf5K92MXVZPhzi2UEgofMKzKUGohYOSbtTA/i9fyWRKgbYcMwoI6kzPkMadGMfqz/ceALrmGd2fX0H2WpkA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB1558.jpnprd01.prod.outlook.com (2603:1096:603:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 06:48:38 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 06:48:37 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "pavel@denx.de" <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "masashi.kudo@cybertrust.co.jp"
	<masashi.kudo@cybertrust.co.jp>, "yoshihiro.okada@cybertrust.co.jp"
	<yoshihiro.okada@cybertrust.co.jp>
Subject: Re: [cip-dev] 4.19-rt tests on zynqmp
Thread-Topic: [cip-dev] 4.19-rt tests on zynqmp
Thread-Index: AQHXIDeP1Grm3d/t/0yJugE1Nfu/mqq3dc1wgAQZoCA=
Date: Mon, 19 Apr 2021 06:48:37 +0000
Message-ID: 
 <OSAPR01MB2385F3CD8091DBA11728044EB7499@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210323225455.GA22020@duo.ucw.cz>
 <166F29397571E962.16188@lists.cip-project.org>
 <166F462C2FF9F4F0.22720@lists.cip-project.org>
 <CADPJy8Vvx7TZVaTt6yRQF7BijYKi3Qoax0gCzKmjgRa=PN-bBQ@mail.gmail.com>
In-Reply-To: 
 <CADPJy8Vvx7TZVaTt6yRQF7BijYKi3Qoax0gCzKmjgRa=PN-bBQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.190.96.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 948e26d4-a89e-4dbe-dda6-08d902ff290f
x-ms-traffictypediagnostic: OSBPR01MB1558:
x-microsoft-antispam-prvs: 
 <OSBPR01MB155822D4FA484675A742E8EEB7499@OSBPR01MB1558.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 XrqgzoHrAu+o/jyHgDF/HDj7pF+/jzgPqxNPuHCQQjFTHRSmWxOLwBntwgAqhE3/b5yWF5RvQbpNhC5zpcznf/7dWHIGfdo/j3EFBW/9YzTaJWayyYeS6mCBHXyo3PEMbu1SXNQ3JwizP1uzafDlE8ZC1mmBY0ceCAHGYzyFShbbO7PLiUD+bNrc3hip/Rsf7JUBe0xuKIRPce57JsZOx2ZN6XbR4fWd4WWpZT3XxhruFxamE84ljDO3Edkw00eFmen5jmMnS7oYYCQYZsa2g1qJnxXrZf5GncPztVuGP8aLZrH+M7lhxHVBPIjVzvCUuXUCdwrAILPixQfFUcO/E0W9PBmvEoh3/Vi8qSq+czqlg0nZB05ClLkQUtFghLzd/wFTdJEis9DHgFLN7kDn9tRvkNCq523y8BglS5PYwypeWULhEn8czH3NTR86P0Y29EQcehIVs5DFEUiBtecW9ntDzVszfBr3xkq9GOYXD7NXi16h5kpov4SiNzuTkD0UdGHOk7vO8x/Uq72WQS7rZSJsZ6610jNMdgvMWR2/kyE0C+DMackXwVdggmLnXMolPUX1JRO2akV39ffIv01BPvoB9Nmkpvqg9NbcdI1EhYtiOc5o27l3ppOsm/3LQ/t6PlmJyBMtWUyC6849MHKKpomsEuFzGFri5VzfYyx/NKbWnF/bohXDxsFMAm6OWvAR
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?Ey8TL2LuCWWBsdIaqVw9teRAYpgsqyWSyu46+yQ/A3swr88C/6MIjyeZ?=
 =?Windows-1252?Q?lS9ScDVqR8UJS244Qv9SEh/P0TES+zVJsCxDpJUssz25rwjDq42pDPwi?=
 =?Windows-1252?Q?6UAZwjJdiWetK7XjZCcvqmcFydpfZsCA/02KpZuFRvdgFUrGKllOySKW?=
 =?Windows-1252?Q?NTATyT4iKZOFknW6ZbvpjkgCXBmhRkrWANOGLSk5R90Z89zJRpO2nfab?=
 =?Windows-1252?Q?Ag5tklsp1Ci7yHilJbkQBNikXHTx3ETyvou9YfwmBJzFFDFcjcR/bAls?=
 =?Windows-1252?Q?dO4ItIByR+ddAGNgf9mkZEBhdClQXiWUsYh6eBA0rUetYjepaju/hJ6B?=
 =?Windows-1252?Q?hZHdHz//gHAlSbtpx8M/Gt7gX4FYhSYVoKqs8wKkQ/Gsi9jH3NSf0eEQ?=
 =?Windows-1252?Q?g/F984wYDMkf+af6TBwGiclkKfNx2V/OGusbHQEAGf4QlmUeRfNmwToG?=
 =?Windows-1252?Q?C4IYXZWb42kQ2V3rLUdIFaBZXo8qK8AgC0wjYz0NzYvow5Ib0uvUigs0?=
 =?Windows-1252?Q?5eBZYfWF861RaGGaLTRqTrETOqa/8gpN0Su6kghn3Y81+IXPkDfAXvrP?=
 =?Windows-1252?Q?PuxILskocOQvlc4gE3i8TsBVWV70olJWKRJpCYVtBR7txo7CBeL6uFqt?=
 =?Windows-1252?Q?BkYooOtd0ul1giutkqFdXqv4l5iS/EkB1xJBZDKZrcNgs/XaicdCITd6?=
 =?Windows-1252?Q?+nid/jvM9CDB1/upioQtBC7gcHBPIyO2s2+1cuiW6tkdq6UcMbsA5mG7?=
 =?Windows-1252?Q?VA9r9ELyf+/Tij/FLutKnN2TxJ5p8JO1s4uiwU70sHuD6Pa1hycPGcKm?=
 =?Windows-1252?Q?6HYrdfb0jJEzSqUSFYsrVbsxreO+/xArppPBhUYrQWCErUpHZ3XipqEo?=
 =?Windows-1252?Q?MreLMJFV8xKu9sdRUNET5f7tLVFH0wkcb8FTxCaCHNWgKnbrPn5td0h3?=
 =?Windows-1252?Q?mYYuHSFV08EP+MINJxRDl+qyINelruSlbeKKml2QeY1ZbM80jt0oNbii?=
 =?Windows-1252?Q?EZmT9fVFuTLhD7zhGOMhE9XfBeYa4gs5nuKc7KsdeYko6Oo1uc6fsZOx?=
 =?Windows-1252?Q?nDEGqfdYPoHouTu3YAI75Ge/MzaYr/8OxtmDAr0XkEzkkzoUG3BBP7tj?=
 =?Windows-1252?Q?NH6vgiU3ZvPTbTSZXJhGryoNCx0lO1hY4f0wsXyWC9NNAwqXBD9YLdHm?=
 =?Windows-1252?Q?zbHe8UH+q8148PaBERztmdD3vOM4RHCMECgh/yFFtGVhsbjvsFP8fpQ8?=
 =?Windows-1252?Q?cJdgqTJhiC31fwEAt4tByFiivZi6QZ8fNBtkya8dmJTtBwc+Beo/DGTT?=
 =?Windows-1252?Q?J6HA/2F5vrACXGsugIqUj2m6qDobJA5w/uTa6R2s168Yo8L3B+wFExSU?=
 =?Windows-1252?Q?BwT7P/Bml+tVdGkbw/74ZM+15odeB5pQyw6ObPs1LnjB2v2c9SRC4++Z?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e26d4-a89e-4dbe-dda6-08d902ff290f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 06:48:37.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKfy/RuqxjJksUWtrNNgB3oHemciayb/+PJLIbKNy3vYHgvU8RQNAlgdEkwlEc7crk3pRa8zICtcVKSBhNAgMHtPEsqo8lvTC5jQoxyK28g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1558
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UUYqbTwJRrmdmzJdOdE2O9vWx4520388AA=
Content-Type: multipart/mixed; boundary="haS1IjqhzSe7IYyPQtS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618814922;
 bh=Vs2/5iblmXyUTxtrk+peB5V+Ui3/jx5A/HNnZUL8/Y8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=CGUk/AIuxDpbjFD76seBmn5q3x+I62hrP8MmbaAFw5nAGKL8vHb+3ZOh/P+y4ayYu8h
 r+A6Ll5Jf+/GS2DbKL5oGqreYLvYUMXS5lSxGY0Do0yfj4RqR30JcJZE+9woGh/7V/izg
 xewX1Uyw0IXlnnO54mr0uh+oVH0ShcSUKMU=

--haS1IjqhzSe7IYyPQtS7
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Toyooka-san,

> From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
> Sent: 16 April 2021 17:11
>=20
> Hi,
>=20
> After staring at the logs, I noticed that duplicate MAC addresses were
> used on the
> two zynqmp-zcu102. I believe this is the cause of the intermittent
> TFTP termination
> problem.
>=20
> So I made those machines use a unique MAC address. Now this problem has
> been
> resolved.

Thank you for looking into it!

Kind regards, Chris

>=20
> Sorry for the inconvenience.
>=20
> Best regards,
> Hiraku Toyooka
>=20
> On Wed, Mar 24, 2021 at 9:12 PM Hiraku Toyooka
> <hiraku.toyooka@cybertrust.co.jp> wrote:
> >
> > Hi,
> >
> > I found that the TFTP transfer of the kernel was terminated in all
> > failure cases.
> > So this is at least not a kernel failure.
> >
> > For example,
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.c
> iplatform.org%2Fscheduler%2Fjob%2F191862&amp;data=3D04%7C01%7CChris.
> Paterson2%40renesas.com%7Ca984f521d1a445e1045708d900f23fb0%7C53d8
> 2571da1947e49cb4625a166a4a2a%7C0%7C0%7C637541862716437777%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DvFnuBFSijckj4gdGDQRvtE9S
> GYCSdiCu2LuKJWdhlJA%3D&amp;reserved=3D0
> >  TFTP from server 192.168.11.5; our IP address is 192.168.11.9
> >  Filename '192436/tftp-deploy-4hdvrfd6/kernel/Image'.
> >  Load address: 0x80000
> >  Loading:
> *#########################################################
> ########
> >  ...<snip>...
> >  ##################################T T
> >  TFTP server died; starting again
> >
> > I will continue to investigate the TFTP issue.
> >
> > Best regards,
> > Hiraku Toyooka
> >
> > On Wed, Mar 24, 2021 at 12:22 PM Hiraku Toyooka
> > <hiraku.toyooka@cybertrust.co.jp> wrote:
> > >
> > > Hello Pavel-san,
> > >
> > > I'm sorry to give you trouble.
> > > It looks "Infrastructure error" and happens intermittently even in 5=
.10.
> > > I will investigate the cause.
> > >
> > > Failure case:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.c
> iplatform.org%2Fscheduler%2Fjob%2F191862&amp;data=3D04%7C01%7CChris.
> Paterson2%40renesas.com%7Ca984f521d1a445e1045708d900f23fb0%7C53d8
> 2571da1947e49cb4625a166a4a2a%7C0%7C0%7C637541862716437777%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DvFnuBFSijckj4gdGDQRvtE9S
> GYCSdiCu2LuKJWdhlJA%3D&amp;reserved=3D0
> > > Success case(Resubimit):
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava=
.c
> iplatform.org%2Fscheduler%2Fjob%2F192183&amp;data=3D04%7C01%7CChris.
> Paterson2%40renesas.com%7Ca984f521d1a445e1045708d900f23fb0%7C53d8
> 2571da1947e49cb4625a166a4a2a%7C0%7C0%7C637541862716447769%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DQZU6rsK4zm7iEzhvBoNQcC
> Tp4T%2B0xAQEz7N%2FPVG2FvA%3D&amp;reserved=3D0
> > >
> > > For a while, if the same error occurs again, is it possible to
> > > resubmit of the LAVA Job manually (or ignore errors)?
> > >
> > > Best regards,
> > > Hiraku Toyooka
> > >
> > > On Wed, Mar 24, 2021 at 7:55 AM Pavel Machek <pavel@denx.de>
> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I'm preparing new 4.19-rt release, and I see tests failing on zynq=
mp.
> > > >
> > > >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
ab
> .com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fpipelines%2F275281028&amp;data=3D04%7C01%7CChris.Paterson2%40ren
> esas.com%7Ca984f521d1a445e1045708d900f23fb0%7C53d82571da1947e49cb
> 4625a166a4a2a%7C0%7C0%7C637541862716447769%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C1000&amp;sdata=3DjC5XQTCE5MSoQ1HAj7X31wAXoxSC6OXtTA
> eKtWpoglU%3D&amp;reserved=3D0
> > > >
> > > > But they fail on old release, too, and IIRC 4.19 simply does not
> > > > support zynqmp.
> > > >
> > > > So I believe this is not a kernel failure. If I'm wrong, let me kn=
ow.
> > > >
> > > > Best regards,
> > > >                                                                 Pa=
vel
> > > > --
> > > > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> Denk
> > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> Germany
> > > >
> > > >
> > > >
> > >
> > >
> > > --
> > > Hiraku Toyooka
> > > Cybertrust Japan Co., Ltd.
> > >
> > >
> > >
> >
> >
> > --
> > Hiraku Toyooka
> > Cybertrust Japan Co., Ltd.
> >
> >=20
> >
>=20
>=20
> --
> Hiraku Toyooka
> Cybertrust Japan Co., Ltd.

--haS1IjqhzSe7IYyPQtS7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6380): https://lists.cip-project.org/g/cip-dev/message=
/6380
Mute This Topic: https://lists.cip-project.org/mt/81564242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--haS1IjqhzSe7IYyPQtS7--
