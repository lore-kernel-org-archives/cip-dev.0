Return-Path: <SRS0=DGkw=IX=lists.cip-project.org=bounce+64572+6330+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C2AC433C1
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 08:23:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F9619F9
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F9619F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6330+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AJuMYY4521723xnxJgS3M4xC; Thu, 25 Mar 2021 01:22:58 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.127])
 by mx.groups.io with SMTP id smtpd.web12.4926.1616660577191076042
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Mar 2021 01:22:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5IIqe7W707U/w8fVSu8W0dz2v4OX8ab1cIyoR7c5om61fLMo/Q7UUtDvXrZN12VWq+cPBO5smrL2d7KdpQ9LhjNyub2qhx5SjQQF00GQNTJJtESKGb1GPgLC/fPM1+yvv+YWWV/FslI+iYmH9doJJS6PzweuiGz58NFbQbPf0cfNSS6gPRP3S2mGnBxYqL5mGhlGd7+aWCkFjlkpqpPMZ9TuyW7spfEIGOBq/mCtB85kgrJWPEi4Yi4VDqYp8b8HPIcsejEvyQo6vKgOIQNNgAUAbqxCrlWq27QMi3tMpxJ+JAc3txPy2Kr5HYLwGXxoervEibY122QT9A5sAyXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCymp/9UznwM+53MATfYDMCKmLHR8ARqlReCYGV5WvI=;
 b=KRFlLjk9VSnMSBvPd6DDgxbKLIJ7AzPe/wlQzuEQC+k5vc4DYIh8tfJThGzLaUpWqXIkPI4eFjTqUSXPbsySBlTIow09xm6xBRZX78zvPjVDYedCw/a3ZGcjKbnV/tlSWg4JsYltjhX/fDQtFDv3uUCM4qCXZnZa9XW1FhXWGOfnCPPpRUN1uPX+3KvHC04VNC3g4e64zyyk3FsmDrW+Uh21ndM5il/97SaPFfObUiX22ek138b1qLCwBD8IF6KoU/4AwCRjOP5tLFObg9zRULgB1EPQfyB4tql9i/7gvV5vcjIO0n4fykJGFeNn04ThraRRVT6t0c6akwTdhw2asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OS0PR01MB5667.jpnprd01.prod.outlook.com (2603:1096:604:bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 08:22:53 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::b1fd:f7b4:412a:19e5]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::b1fd:f7b4:412a:19e5%7]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 08:22:53 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdchCVKfQyu1k3CfQgmkqnvUCa7AVwARoRLQ
Date: Thu, 25 Mar 2021 08:22:52 +0000
Message-ID: 
 <OSYPR01MB53665EDF0B2DCDBD01B0C2A5DF629@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <OSBPR01MB4967EF41D9A0D69E6E46FCE4A0639@OSBPR01MB4967.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB4967EF41D9A0D69E6E46FCE4A0639@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.44.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17040f9f-fe16-4b87-9f6e-08d8ef672f80
x-ms-traffictypediagnostic: OS0PR01MB5667:
x-microsoft-antispam-prvs: 
 <OS0PR01MB5667BB41215F83FDEB2E9FB6DF629@OS0PR01MB5667.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 xbQO6Ba4bZU2otRXg+Sy1wDBNyvxia31olrl4ZXRhWhgBFfaTOXy5Mn7FYS5T55qPd7qpHql9lgaQURwrMmsImP8LF9Jj8QISTw1NbzXhw/QliEaufMG21uzbrQng1mrwmlLZWd4+z1JSXf9gykV94txKiqCt8IkNV2fi590J4UKtPm4y+bh4s8burcezgkGOPrwa5+s/lIs7VfKTrdriuDjXVIsVjwdhoKDVCPda4Y05nwjwRGrNmiAVhtSAgYw46N8go2J6cXaIIT3Q1gL4RryPy9Lon3EsWliSeZATP1KICrpyorGdWtoIIYU97lghF7/tb732OxUJHVVWHbqXGq76hbxprugNWz/WSAJUszK1UEoRJXhG3CM+PIofruwrniAM3HcgIbeZ1is2iQHIxjM/WMNlatDBpMjaTB1r+W58zDcYdx5UObDHPCEeGGDEh48xR4XulPVknhQFeBOXx9wEcThkmZCD/g8wQx9hIXhvCpl8neE/R8Ije3s7nmRBPIeyvdGVJ+BAD79/E72FbQ5yjIsdgkXeSoQzWTxfx67SltT4yiVtSbIFuU8VKk5axCSNFWG5eGAPLr2Nz8m1Lf7Duktw8ceZWB2lqY152HFskl6WN+wVWFC5NjWKVQwtdDu1SZwsdjljHRvigu2Hcv3DIcS2AUnYZF7LVhXFVN7XIr8sNRrktETL1JcrxXcNgfGT6vu8RGo5nq9WFJY/Umt5R8p3QXkvKHkIjOKnuA=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?Zuvl0upDKyjLKNk6094cJTQRc9MnZ1IdffMTpa+ct4dm6C1me/gajJVRaG/V?=
 =?us-ascii?Q?mkWEBZfTJT8JOdYUA8yDBD6QoONX5RbIK/2OaJjsanZvoDNef8aGl0cLifhI?=
 =?us-ascii?Q?LRpTeNgBASR6swwR8cLgg0yyGP38d32RkFRkR0IA1ZjO69X442iyzVNfROJD?=
 =?us-ascii?Q?dpzjimHj0dyRFbr+pyfDzmgWfvAyjkxQirFoneepRi10XRMk70nuIMw8jS+j?=
 =?us-ascii?Q?6laOf2hscMb93vQx9vDH6zkazXaWq0GhXdj4L1MRD7rxvd1LVk1ocvU5gelG?=
 =?us-ascii?Q?lZr04hzQyStRj8j6q3jjUSB9lkVMFCJR/KrDZxp5lXTZdAcPpEfxAWxFE/KR?=
 =?us-ascii?Q?Ni4oVTDcwa8fz11+cXAa4/LOHGAl+tIPzQUf5acYP82Oy+w0SdJCCTSrOq4L?=
 =?us-ascii?Q?lnfgN/huHLBy0FdBdYDPpcuOf+znvlS/d053J8D35IzJQYRqOhtJSQZRwDd7?=
 =?us-ascii?Q?dXUfhOJKRO/T+CO9YXN4kEvnH1iucX8B4F9t4ftCIBBVaQhVRni76evL2qB4?=
 =?us-ascii?Q?tWh5Ml1haGtqEQ3/ovU17KCzB2GhhBFjdkffIgKEWq4ARpV5Zr2ENJh+wm2d?=
 =?us-ascii?Q?He5jQCuH8CidsWA3eqSPNCPfMPLWU3mM20KDALYWz1/LlnJNY/hID7aFC+2q?=
 =?us-ascii?Q?DM2Xqyo5NO4cqcvk24/0e86UTwZPmqnH6gmOQaODUptr1nUCARZhWBbRZmk9?=
 =?us-ascii?Q?3OV5Ci+OppuX0wLLQqJNeW6IvxYaFeV2e0ovzQ+iZ1pKiS413sxZaiAocxJr?=
 =?us-ascii?Q?pUejJzgdpwIf49heeOSpnlsQTf+WxYUSTuW4c8Ss2FLIl0pR6ZZ8RT3wrmhK?=
 =?us-ascii?Q?r/rVF9CMYtutaaeykQXeRAFSoTY0mG5VqySVQ4wK63+xS6nGU0UfU4F6ozJi?=
 =?us-ascii?Q?Of3ShEDdLwL6YtTXwPxpJYE++Wsu1Lnihk6K5/UI09YkFlsjuw283UyMHzkf?=
 =?us-ascii?Q?LXKy0gGwmyMSTyjZm4htMM8CW7REk/gzutHJXM8pge4qzRu6y22Fs6L8M97u?=
 =?us-ascii?Q?nakKYC81+hc81IjDYl7Y/Afv6JMVFZj6gxTwMwl3xQ1CNmohowPMOcv1tRLi?=
 =?us-ascii?Q?0Bbn8+2L8Y7dZ5Q+QTOKwPR3wVUp6k0ZMnnFg52i+p8t1B7zuv60AkVO1gjd?=
 =?us-ascii?Q?iH7cs1Q8EnFnrsG/dpQhTdsb01CdEvf4zrMmSecA0i6jTvossWVX+9yH5DQP?=
 =?us-ascii?Q?KrrpYhLNLq5ZPtR2/V4yTqbMXwIDyFwLe1yxUGlRYfQckRD0IIB1Q7F0myPZ?=
 =?us-ascii?Q?7ELgKlOSuBtrxRRWxbAchcXxmmR/a64uPobiBqJlTjxlceQR9jOqiInAxdhh?=
 =?us-ascii?Q?ZSg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17040f9f-fe16-4b87-9f6e-08d8ef672f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 08:22:52.9169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIOCUfmy+1UD0o1BoCVIWeClw0tuZy8eJPoRwQv8AMuqkYibuuw5cvk8qCA3drgVyEXmDZ3gedk5tAxTCPvTe2q2W2LTdWZKRKCzt3HTF1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5667
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NQ0VLbxyXEbc4hohkt4CI8t5x4520388AA=
Content-Type: multipart/mixed; boundary="JmpsuFKSH1zb2o5EWLFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616660578;
 bh=jNkSftf90M/iiTP2qe6PZg6lJDnWjJSujMRCw7pZCxs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=r1Q4nXAOYJb+epqCv67wz8WWh1KHaFqBZZWisQPAjNwnJ2BkUlKabgkIJzM7551a39z
 zBqxaYcydQpHTBtd4wchhmmiQHHlmv0yMzn/m2OKJdYU/rrSgkMmnt1amOhjdSYJY4g1a
 rkT6qg0SIyaNOzB83QclcWDzolMLzKdeH1s=

--JmpsuFKSH1zb2o5EWLFQ
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry I couldn't attend the meeting recently, but I'm absent today as well.=
 There are no updates from the SWG latest.

Best regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, March 25, 2021 9:03 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ti=
mea
>nddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%26month%
>3D3%26day%3D25%26hour%3D9%26min%3D0%26sec%3D0%26p1%3D224%26
>p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;dat
>a=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C60eea488c5b74301ca1608
>d8ef216b1a%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637522
>274109972656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
>oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DC079ktOntI
>PlfrypsJk4kb55H%2F226wrakJgBwfxalww%3D&amp;reserved=3D0
>
>USWest	USEast	UK	DE	TW	JP
>02:00	05:00	9:00	10:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclog=
s.base
>rock.org%2Fmeetings%2Fcip%2F2021%2F03%2Fcip.2021-03-18-09.00.log.html&
>amp;data=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C60eea488c5b7430
>1ca1608d8ef216b1a%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
>637522274109972656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dp9c
>2WMBVbojr2%2F62eNJDxYQCN4ZS0GxUW55%2BWsyy4zs%3D&amp;reserved=3D0
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Do some experiment to lower burdens on CI - patersonc
>  3. Ask board owners(siemens_i386-rt/plathome_obsvx1) whether X.25 and
>floppy can be disabled - masashi910
>
>* Kernel maintenance updates
>* Kernel testing
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.

--JmpsuFKSH1zb2o5EWLFQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6330): https://lists.cip-project.org/g/cip-dev/message=
/6330
Mute This Topic: https://lists.cip-project.org/mt/81591241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JmpsuFKSH1zb2o5EWLFQ--
