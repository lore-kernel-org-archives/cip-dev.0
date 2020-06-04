Return-Path: <SRS0=WvpJ=7R=lists.cip-project.org=bounce+64572+4695+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE1C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 07:12:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877852074B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="o0/yMAxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877852074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4695+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QJGBYY4521723xulGKHnzsGS; Thu, 04 Jun 2020 00:12:29 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.128])
 by mx.groups.io with SMTP id smtpd.web10.8966.1591254746988241871
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 00:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+OFGAkca+BGPeUC84cRGIeEmZV7TGdYz8tzsmIc7rtYwEYF5QCnxbfgynujWkzUtk00EugcGAcbNvpnwo5/wUZfD4R5izbPsIzT0sU1aPdSRY2Z9JPiv0xlNlOmFpcr+0qQqx98QFSpVLuhIoHRGUDDHOySbqhpntUAUM1eaM6j//QjNllAZ7O8IahRGbT7hrgE7gi5M2FTuy6w66rcnw27kYO8bAzkAmRaLb5Do4/cpGPx7mRnTrjEhQey9S94ouzTPZ0YhCpgSZ7hWZq3O2DSTr6GYcVi15tp87CMQ99PDu8v4Ej2tZJMNs5cpAsxrDftTzsvPqJSHUpGAHYT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MihUE/ZPm7Iyrjl3u2IG4PdnWZl5QqmbcfUq3z6IeVI=;
 b=OyQS+zGL04bBrO+o6EfXD1Fk/JmYmqxJSLqedM9RpaxwjMSlvAEQCCznPDzbjXDQHjiBFmX8PmOEX9JcamePwHPqzaWpIheSiA6fEuE8QFGfsJS9OgT5fEFwLYVoltn0QLbnrHWWt6sd7AZQDXpeBmeJot65zTxZBLFQ4OOOYBfhNHtaP47yihJn5SVqnpvB/A8s5/lVG2uoeLrvbdwpcBgx5kY1QFZ5VullXDfhXMIvr45W0ysFXoqaq8UhgEQ3bx24/0qW/TVmTEqm9ca0ELkhjyMYQyePiU0/ykoNVm2U4TuF+r8wOMs5iXpoH9bPSolUhtf3BYDBKaqgJpPMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2075.jpnprd01.prod.outlook.com (2603:1096:404:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 07:12:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 07:12:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <akihiro27.suzuki@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdY6GUi8/ClWh3wURD+LTAYT5PTP1AAI9fBQAACOsZA=
Date: Thu, 4 Jun 2020 07:12:10 +0000
Message-ID: 
 <TY2PR01MB497231676CE3607428E84EBEA0890@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972DC5057F16D60C18E2B99A0890@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSYPR01MB533454C9EC8FE8E3BC0E3DF5D9890@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSYPR01MB533454C9EC8FE8E3BC0E3DF5D9890@OSYPR01MB5334.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e1cf517-922a-423c-523c-08d808569919
x-ms-traffictypediagnostic: TY2PR01MB2075:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2075ECEA32057FEADE264149A0890@TY2PR01MB2075.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 x8OzKQFyz2HAP9srCx1OWISUpqRezfs5Ecl78rAK8sjpM0wFDiywHdK18F1hw6c7L00nQjn0x6DsFlAxDWoe9gsA+/T8ycAgADX43IFqGw1Bu6lktv1AvKksl+s8GOcSAQyLrzByrxrKtfEoyDKz6DI5kwY3grtl6Fpgcndax6dP0vJ3khjCw9W9Lijl8Tlhkvp8BIVLZaxHDUsf39df7AN4BGPIB/he15lYm1LyGYic0w+bY5jzmb2F976lSY9kTPRoi30Hv2A7oCbf2y2GKAL/IdKpmh3ZU68QFz2G54ZIS+CU/3Z+9ef0/tSF3qQ3ge7Y3zZctVApPMGHhxQJefFe4ItMICWPrQmPtdv6Gp6qK8ZZ9OyF+xl7WKue5OHjpyIYMsmuct1ttW7Pf59l6w==
x-ms-exchange-antispam-messagedata: 
 v3UdQknE0RBqBkfgGvS5WzHtM1UAqLoXjYDf5x11eLfJAGHKooZPmqMIqy3XXPkpzMjdUunHP5ff/eb+AFJYRzcVw5h6GY+S8TOYq6hDMULOeGFbFdLTikbU39uA2QjP52yzkA9XLDxJKw2qiaAkt6WsKl881QBVcwQZyQFMYxT/SW06rbWorHFPCuHqjJfb1kYiMsZXLqAD0E4CuglOnRf6EwlVBDLMl/A8SulYOr1rsS0J3A2d9/oMo1fWDcIrAnd6bwiWUauaAkjgqw/pxwgz2TjfITHhPtEIuWk3BSb4QDhpab4mErJfXIfgtG112UWnO5b7yhcvPlyjDq4GSdheadVQuBdsEUZ8bEcbvGI+SQRXXPSM3o/qPKvsS0en+QYetiI/NXBf2CEDJs9qOu+MoZRr7zR2yxUlui0mFUX7GU7crA/zZuaYz0N/u0hO/KMndYfJFGsEIS7v9IuFwInJDWPUwdstfL2L+a6V3cJKyTNqXc1s+kqHabzdEk2q
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1cf517-922a-423c-523c-08d808569919
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 07:12:10.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZG0M40otnHFoa5s/H5W4tI6A1i2tFsxNnaFM7oqwSHqdQiTP74hVhv/cjIyzQib5pglbxPwXxMh3Qhn5Pw5Kt16vozrRIV/rNPbEv5VF68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2075
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZsON753H24a8jOdDcYgHVCawx4520388AA=
Content-Type: multipart/mixed; boundary="CEy447KynTvU4RqTNNeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591254749;
 bh=E5RzosS//uAn81dGAPTXazpVooveN2TmleiBQJWGNzI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=o0/yMAxM5d5MJHd30C0eEoMCMIGc8CKmYH1v18AHYjxKJ3JiwnGoiqqqCpK3FabmjGp
 ygmGFuntm9OpvoKgBSlMFc47ldLiWy4Svf1GT743aAOQViPRvp7PfF0u6VWblZ7vpp+3v
 C2Wla8+m9cbHHFDCR0N1XEb0oKoh/NK39Kc=

--CEy447KynTvU4RqTNNeO
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Suzuki-san,

Noted. See you next week.

Best regards,
--
M. Kudo

-----Original Message-----
From: akihiro27.suzuki@toshiba.co.jp <akihiro27.suzuki@toshiba.co.jp>=20
Sent: Thursday, June 4, 2020 3:58 PM
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masashi=
.kudo@cybertrust.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: RE: CIP IRC weekly meeting today

Hi Kudo-san,

Sorry, I got a plan today. So I'll be absent today's IRC meeting.
SW Updates WG doesn't have any updates since last week.

Best regards,
Suzuki

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, June 4, 2020 11:39 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D4&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/05/cip.2020-05-28-09.00.log.=
html

Agenda:

* Action item
  1.  Combine root filesystem with kselftest binary - iwamatsu=20
  2.  Strengthen sustainable process to backport patches from Mainline/LTS =
- Kernel Team
  3.  Upload a guideline for reference hardware platform addition - masashi=
910
  4.  Post LTP results to KernelCI - patersonc=20
  5.  Ask board owners to review reference platform configs to optimize bac=
kporting - masashi910
  6.  Check CVE and Patch: NFS client (CVE-2020-10742)  - Pavel-san
  7.  Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - Iwamats=
u-san

* Kernel maintenance updates
* Kernel testing
* Software update
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--CEy447KynTvU4RqTNNeO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4695): https://lists.cip-project.org/g/cip-dev/message=
/4695
Mute This Topic: https://lists.cip-project.org/mt/74664504/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CEy447KynTvU4RqTNNeO--
