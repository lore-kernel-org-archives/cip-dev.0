Return-Path: <SRS0=DGjn=H3=lists.cip-project.org=bounce+64572+6197+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6269C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:00:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F45B64F06
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F45B64F06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6197+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jZytYY4521723xkM1gL9LYF3; Thu, 25 Feb 2021 00:00:04 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web08.8422.1614240002015662994
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Feb 2021 00:00:04 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id ZQ1204479A;
	Thu, 25 Feb 2021 16:53:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA7A9FuFrBK6gNLj5SBnQ8d8tD0CbtD4ucodHDnkAZzuc/73vOULRufprDvWQUAfLa2CjfxCyy40z4+lgUHCtTZe4ZPIm5s/g9ki2YMtIRolaIoT62vKQsKlfhe5DBxefuGS51SO6bxo4Av0JZlbWMjUOeyLqUXp/6/gps+PbkYD0MSy6XK5sICDiELWZfkeZ5OvCBoFOs4mGoDst/ypqlDg4a52BNeXKiZIBecEN8tcmvV+BWPjMcVQIMHknP1W3NdDFJRm1rSLHzqYU6dFnhC6YMQr6NE+d7KA5duYr27a1WsWPK/pYeG4Y25RLOAMKIb6EhI8tReAhIl2zzvIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq+F2BCagXBjBF7cYmckZu8RNs0BXPjgiiF1PvsqvB8=;
 b=YWG29f1jdig+EExYrTnY4lj2rQmJAV/IB+XfOkNS4akrdRG0CJ+LC9t+ak0R3dysvn05a0vyO0eb0KLmRWKucdaE5d5gR2WfucwKB0tpMN4zYD0cLDmdE0eMcghyAhAoO5R4MU1+/45eQfhH2jdTaQeI5ii1fKc9DKnuuPWKnLIWT0UAdyz9kAl9qSQvcGDsPyAHyOrKTU0z+hyLLR0otEg76NsDspOOe0sa2VM2hTrPz7achJ0TMTt0ruYbk0VeTXJOjIfRUrxo7MBLXK0EkRXnXLxHRz6VLQFUpLS+tafiXke6DFjk8extMRe2zBzb0rQlkVgnE4NsHr2IW6WFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB5629.jpnprd01.prod.outlook.com (2603:1096:400:44::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 07:53:53 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 07:53:53 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <hidehiro.kawai.ez@hitachi.com>, <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>, <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtgANHIwrAABi+8sAwq1QNg
Date: Thu, 25 Feb 2021 16:59:58 +0900
Message-ID: 
 <TY2PR01MB4972C67E512FDF94724B1B8DA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <16529B035A24E529.13568@lists.cip-project.org>
 <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
 <TY2PR01MB497225A38DD561DEFF392ACAA0DC0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB497225A38DD561DEFF392ACAA0DC0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3263883-98a4-4f0c-8ee2-08d8d9627f32
x-ms-traffictypediagnostic: TYCPR01MB5629:
x-microsoft-antispam-prvs: 
 <TYCPR01MB5629D7CA5DA66C92DD2DE6C5A09E9@TYCPR01MB5629.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yWncII3Zh3uh3oE5ehO6ME9Hi68PKLkE5QDRAwKT7bg2+8DTH4QjvR3u5aQDFvYgAUcyBiSachq7SToMdhmsvykEFuMhL+gavNCjQ3uoGM9IC1lmH5hERPN5ix604CdlJXXzjp2S+2q+J9gA81A56iObhXq6UZczxyCpJin7Llci3REB6/6ZgdrzR42IbHbTsNp7zZPUEsotBdRlyt9pg7ciwAPqyK1zFgX5c1DFumJhBqEbbklPaMmA3KLyhUDWrCi7Xxu1+bdvCxTT15iQSGUyT1x3I2sNVHklHV5vqW74WgK7+hkocvgXKd8fZlLz2RG08i1li7fpQTTZdd0LF/0bkPZbY7H8dO5BhWIxl5JMHtQ4vu9t/UkGSO56irPffpcPnIsuKWbigeF9olOOj3F6B/t1vAM5QqTFD75wOarvEYUNRODhB3PFiLnoakqCuCJZ+2ej/0UIldyqH1dkpd8d2q503s7RSjQzs9ggRQS4CHJLqj4S8BX6E7pPuFaR2hdUzGVmKEnF2dg7VcotoSaouhWpgI1aspFHZkCQcwohuW4XWHG1gnrEvlgYwSzJ7dwrsmGmm3HegfhqgEv3Y+V8S7JkosX8hP9YU0f1B2UmHql6vNWa18MavA0R8wtkv/r2RbZ5GP+DjMV/Nz4uFg==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?N3p1cEJjSFVSZ1dZY0ZPTjhpRkl4RUh3TUo5U211REdtZG1VdjdaUEF2?=
 =?iso-2022-jp?B?Nnl0RmxIVGFXeUpXYVMvMXY2bHIxcS9FMlZxYm5rSmlLMTh0K3hLS1V0?=
 =?iso-2022-jp?B?MENKTlBZdHNUYUsxNHFFbkZ3b1BRNVVCczVNK0Y1ckJ4WDBHcVErK2VM?=
 =?iso-2022-jp?B?MU1SSFR6VlhpTUtLOE1KU0c1bjZqU2tWaVNVeWpGUGIzN1FQWmlOQmJq?=
 =?iso-2022-jp?B?Z0YxcUdFL0tnRENvUjlWTjUzZjBkdlVvb0M5enYwSEIxT1ViR2psOWtY?=
 =?iso-2022-jp?B?Mi9kWndENTRLK3pwVlpIblhQd0ZodVhHODQzT2diK3ZpWms0eDNMVlQx?=
 =?iso-2022-jp?B?cUF4emNGS2dTdTdyUmJEWHFvYWRldEdTVGkyT3d2ZDlHUFMxZGl0aHVp?=
 =?iso-2022-jp?B?c2RDUWNPZDIrUktpa3F4aTFpMm5NNFpsZ2xVV3pXU2YvMDJNaVEwVmlW?=
 =?iso-2022-jp?B?U0l5cHRsTnhBSDZScFJsZTN5Y0M5cHlHMHozbTkydk1zSkRaSEllWTZ6?=
 =?iso-2022-jp?B?OTlpNVNWb0JsY2hLU1h0TEdlU0RnK3Y5b0VOSlZ3SVhqWm5SUjRGTlEw?=
 =?iso-2022-jp?B?K3lhRlNsalRjalc0THVrYnpoQ1FDZjFDVVdFYkdwQkFiQzB1d0orNnRR?=
 =?iso-2022-jp?B?eDl3WFFTdkRkckRKQ1NVTEoyUWhuTFhkcmJKcmt1dzZPS2RWZEx0TTAw?=
 =?iso-2022-jp?B?aHNtM0FDSGZJQnFmMEU5Rk04Y05BKzBxeW9uOUNhcnNCRE5pdXdaRzNp?=
 =?iso-2022-jp?B?WkxDYy9TblFBQkRVK2hxOW9mZ3ZINGh4NGRnMmFYWHpmcVhZWEo5aHdk?=
 =?iso-2022-jp?B?T3VIRjdaZEJURnM1OXZOaDdIRkRJSS83Sm9oRXB3RUU3WUZpZDBDdmFC?=
 =?iso-2022-jp?B?NU5TVmJuZXlSeHN1Y3ZuNWFYNlR0RUFYbFRWUS9haGFJVUZ4U0FPQWVC?=
 =?iso-2022-jp?B?MFl0SHpGTnpLQWZQNTBETy9BM240NmpSK2dlVjNTMnNpdW4rMitUUW4z?=
 =?iso-2022-jp?B?aDJqaTlXTEp3dHFFRUR3L0VRdHFyQ0hNd1I3REVSaVkyRFJUWnBmWEVo?=
 =?iso-2022-jp?B?eUdjZXNqVG5SdmNNeVdoVXFaVFk3QkJ0cnExc2tnNHozMGlmd3B1KytT?=
 =?iso-2022-jp?B?SlEwWWRyTWNlUksvRytHUU1RSCtLUVd3d1NzV2NCZ3lyd2IyQlJJQ3lF?=
 =?iso-2022-jp?B?Zmw4bU9jck5ISVcvWHkxZkRRR21Pek5iM1hqdU5nZlk5akRITGFDTTJq?=
 =?iso-2022-jp?B?VmpqUXlkMjRmUjJobkZxakdQQXE4ZmpDNkgyejEvY2haOU4vNlg4STZq?=
 =?iso-2022-jp?B?Z2U2V1JJWE44Z1N0RGxmd2htNkRJLzZkbXRUd29RWTdDTjREelpkYjBY?=
 =?iso-2022-jp?B?Y3VQOU5jNkMzMjZyZ0d4aCtLZ1F4NDhEcjd0cW12OHo0cXk0cUdpL3Ba?=
 =?iso-2022-jp?B?MXpPZ2Zza0E0UW1mcVN0Rlg3TlJObkZkYUtYN3F5M0g4MmFGUGpOS0VB?=
 =?iso-2022-jp?B?bkF6REpHdXBjR3BieVhDL2ZCYWdxQlFZU1Qvd3hJV1JyVDZKSlkxVzds?=
 =?iso-2022-jp?B?WURkS1lZVG9PbU9kWUZpNUE0REVDa1gvV3p6a0lWTXhLV0RxQVltdlUz?=
 =?iso-2022-jp?B?ZUk4TzdUN3ZiemJhMXhVMUlHaGEvb0wzWktpc29EVXZjMzRKVmt0cUVO?=
 =?iso-2022-jp?B?M1dtZWJlZ2dQMnBJL0dKOFEzWHpkcVlhYldyamE4M0dvZEI0bERnZ3lD?=
 =?iso-2022-jp?B?SzVYUmEvWUo1bnp0NzNLRzFtbUJwSHNRQVlIbzRGVEF0TGF2cUFEeVNH?=
 =?iso-2022-jp?B?cGp0MFV6MGFGb05rQ2R6Zk9wYVJPRXNzRGM3bUlNQVh6cVBSQWF3L2pG?=
 =?iso-2022-jp?B?eHBRNGN2Z3VnQU9FUEZ5NDJlMGh5UmhOQXpNbU9TUW8rRnVrTmFkUUhy?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3263883-98a4-4f0c-8ee2-08d8d9627f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 07:53:53.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6tDBtnS1SnsCuvlpZjTtDQMtHWgu07ll1SdZ6IDjNkwR0IhdRta19Cc+OtoCSwyvuOAdqpaH6dRfr8TAQdI/iaFYXFdC7Nw1F/rOqr1bfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5629
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1jRsViMusPAtTOi0AsHbOYJ5x4520388AA=
Content-Type: multipart/mixed; boundary="QUaAntQTx53ksL2an7jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614240004;
 bh=Jt1jg9fnhKtdvEUIX/3mjymozhsuly4E4asNrDj+h1M=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=V//7fQzfLQn0OgK5hl9HER1PM4QSI3uyF2vT+o4Kl7MaxFVe9dRJ/BEu8u7iz7U97PM
 BUal9yx/v9RUXdAWJ4UxnNV0dG8s6LrdbrsCHCkdadqHo0skFC9M5s3YJQ8+9EIekB9OH
 aJ+tl+ih7Z1v5ASQmg0LVWbdkT6Seg9snAQ=

--QUaAntQTx53ksL2an7jV
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Kawai-san,

It's been a while since we last chatted about this issue.
If it takes more time, shall we disable nouveau driver as you suggested?

Best regards,
--
M. Kudo

> -----Original Message-----
> From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B
> Sent: Friday, December 25, 2020 6:28 PM
> To: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.ez@hi=
tachi.com>;
> 'wens@csie.org' <wens@csie.org>
> Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> Subject: RE: hitachi_omap defconfigs
>=20
> Hi, Kawai-san,
>=20
> Thanks very much for letting us know the current status.
> We will wait for your response, so I would appreciate it if you can keep=
 us updated.
>=20
> Best regards,
> --
> M. Kudo
>=20
> > -----Original Message-----
> > From: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.e=
z@hitachi.com>
> > Sent: Friday, December 25, 2020 3:34 PM
> > To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <ma=
sashi.kudo@cybertrust.co.jp>;
> > 'wens@csie.org' <wens@csie.org>
> > Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> > Subject: RE: hitachi_omap defconfigs
> >
> > Kudo-san and ChenYu-san,
> >
> > We are sorry for the inconvenience.  The confirmation will take some t=
ime.
> > If you'd like to solve this issue quickly, please disable nouveau driv=
er now.
> > After the confirmation, we'll send an updated defconfig.
> >
> > Best regards,
> >
> > Hidehiro Kawai
> > Hitachi, Ltd. Research & Development Group
> >
> > > From: cip-members@lists.cip-project.org
> > > <cip-members@lists.cip-project.org> On Behalf Of Hidehiro Kawai
> > >
> > > Hello Kudo-san and ChenYu-san,
> > >
> > > Thanks for reporting the issue.
> > > Including nouveau driver, it seems that our defconfigs have some
> > > unneeded drivers.  I'm confirming this with our development team,
> > > please wait
> > a moment.
> > >
> > > Best regards,
> > >
> > > Hidehiro Kawai
> > > Hitachi, Ltd. Research & Development Group
> > >
> > > > From: cip-dev@lists.cip-project.org
> > > > <cip-dev@lists.cip-project.org> On Behalf Of
> > > > masashi.kudo@cybertrust.co.jp Hi, Hitachi-team,
> > > >
> > > > Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the
> > following email.
> > > > https://clicktime.symantec.com/3Hrgtrrm6ninbLpVgrZpbS37Vc?u=3Dhttp=
s%
> > > > 3A
> > > > %2 F%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> > > >
> >
> fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2
> > F%23
> > > > u
> > > >
> > > > According to the kernel team analysis, it seems that the nouveau
> > > > driver is enabled in hitachi_omap defconfigs for both
> > > > 4.4 and 4.19.
> > > > However, the configs are for OMAP platforms which, according to
> > > > our
> > understanding, don't have PCI for a graphics card.
> > > > So we think that the hitachi_omap defconfigs should be corrected
> > > > to disable
> > the nouveau driver.
> > > >
> > > > We could be wrong, so please advise us. Once you confirm it to be
> > > > corrected,
> > we will go ahead to change it.
> > > > Best regards,
> > > > --
> > > > M. Kudo
> > >
> > >
> > >=20


--QUaAntQTx53ksL2an7jV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6197): https://lists.cip-project.org/g/cip-dev/message=
/6197
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QUaAntQTx53ksL2an7jV--
