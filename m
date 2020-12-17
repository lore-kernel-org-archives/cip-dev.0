Return-Path: <SRS0=auxQ=FV=lists.cip-project.org=bounce+64572+5968+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBCC4361B
	for <cip-dev@archiver.kernel.org>; Thu, 17 Dec 2020 02:10:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C5523715
	for <cip-dev@archiver.kernel.org>; Thu, 17 Dec 2020 02:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C5523715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5968+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f6ztYY4521723xDX0zGUGXAm; Wed, 16 Dec 2020 18:10:03 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.120])
 by mx.groups.io with SMTP id smtpd.web12.2095.1608171001904136373
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Dec 2020 18:10:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRcFTyDs8Xi/2GBbzzFCX42TZDHQ7OSDfjRRUSmVQxruN/PcZUK3NRdgz1iNIn66gaMWJt6Z1R4oxri9Hb2nRN55j4a/dwtrIfwjLM5ZCWNH8zKnxLsynxB1R1SEDYnelmv2AhN6o59PSuJgkoh69Cpj3ASipGuTvCwuZPqGTnLM8yN1EB3AOT/r2I8U6qgLxlLJb9md15VHi5SlxuReoNMMvol3bAOLIgtpjbXWGLimrs1OlzqM//57W0UuWdbUXWfixhYe2yHKm8vzOLSNmrQneruNYTh7EgTwSqrdBlq366JNqPy4mRoF5zJatDTPrd9mVKib/mR+GGNja+MmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85vOjhx3K2I1g1cVnLlhp7rRuvEuzlKm77BsXOM/7Qs=;
 b=P4ZbRL1zWHh2Ttp68bgzCqG5CHaXM0rYIrh9lXewL+jdtH9kqvLObFxTBKshQ45LY6Zv0cSF8L9Oz/oWFKpmjJ+VXfkq1MxT/kg8WyLzydrGazQNsHeqROXlCDah9VhOCSIcPpkuqIkgPy47J3TCZkEYZeqfmXVK4NyO62oTDb/0DqKX1i/aPvlICZZS2a1v7aEXFlAXCJyzSML3BBENcLd1wL+8BKJmnE0bKlNxWeDJdmTLD+4oSIXeLwaEce2+89fA0YF9YJdUs3VI0aCA/sZooQfRnMu4oZeqCBQ7t9apk68v2ykalML0zJxB3wyEaIr8XCXoW+Lx3msq59lY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5421.jpnprd01.prod.outlook.com (2603:1096:404:802e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.26; Thu, 17 Dec
 2020 02:09:58 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3654.024; Thu, 17 Dec 2020
 02:09:58 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbUGbb/tNm03rZgQ8umnMYySaU9cQ==
Date: Thu, 17 Dec 2020 02:09:58 +0000
Message-ID: 
 <TY2PR01MB4972735E4759DDDC9896598DA0C40@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 028ca31c-3d02-43d5-0e84-08d8a230daf2
x-ms-traffictypediagnostic: TYBPR01MB5421:
x-microsoft-antispam-prvs: 
 <TYBPR01MB542184FE080CD415DB8F6839A0C40@TYBPR01MB5421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 aLtnmIh84fOyGS4TqIHdE3Cx1qmZQ+dK5cFP3fNKoQ67bA5oS74IC8rUZvOCuWysG0ZYp48Hr4beJixQoX3rAY7UoIg6noIqZpZr1ccINGy/6mp51enseqRGxES9krwCsLY9ixHNP3cjjfi9ZXjzV40MZ++2fwInmHx50dZpcFRl9OFDPjF53GZTuz09UZM37llfT855djW+7oPeGQwQnEWoIB/Wz20IA7Ohwl650IGqCU/YFhTetpem4vLfboGSMaW5eYzKzl+jy4Pk0JekQkSbBh1zFWPsSfdK0riDrsJz8+SlvGVxuEcI8v1AaSdakkoDjzr86vP+cgWmcq5w2siIbmhKRyA52iEeIly6WWKMdXveCke03XoeL2kHDD5U7cX4bw5vlK8ibRnNDEaNfQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?L25acFN5aXNqUFVtZGtUdE9kT2gwOEJxQzRLYkNITHpsRkREZVRicVV0?=
 =?iso-2022-jp?B?ZE53OFlaRGVyUEFQSGE3b1R3MDVvRkp5SHhXbEpjR2VtZTJMWllwQ2hy?=
 =?iso-2022-jp?B?b0h2bjNWaFVwLzRQaXl4MUVxQ3Q5NU9GM1FIUytiMktYZkdzdmFwa3JT?=
 =?iso-2022-jp?B?anVpTElNZDRNa1FqM1JaT1BmNHpndW1xdktUOVdtdzRXSDRWdnBlR1c5?=
 =?iso-2022-jp?B?NDRGaHpkRWtnZS9XVWd4Mjd1bFQyc3dLOWM0M1VidEV4ZU5pL2RLdmJk?=
 =?iso-2022-jp?B?b20ramgxOWl5SEdFRHNyQ2tmZklxUkdmQ1JqaDNPS0pYeXpTamY3V0dx?=
 =?iso-2022-jp?B?ZlVWblBWNXZXMkhPWlc2TlQ5MnQ0Rk4rS0k3V2RIOWR6QmRjZmVzdVM5?=
 =?iso-2022-jp?B?djkrbTVreGd3UXJUbm8yWmpHZy9oakdhcHU5elpWZG5FcGVZWC9MT3BU?=
 =?iso-2022-jp?B?b25zRlVrQ1BxbXQ0YTdQS2JhWW5HZWFrbGFSWnlBZ3FQemRhVkkxTy8z?=
 =?iso-2022-jp?B?UWc2V3RCdlUycm1NT2Q0eVhid1dVeFZDaGpTN0NlYVdsSENjVTc5bWFW?=
 =?iso-2022-jp?B?TU14RGtNZlV3Z01tYU8vU2lHNmMzeFQ5OWZYVUd4U3Z4SDI0aU14Vzg0?=
 =?iso-2022-jp?B?VlVrL1lnY0tTejlTQjZpMlNCMDc0M0NvdlN0NGNvODFuODdhVCt4Qkhp?=
 =?iso-2022-jp?B?cE1mS0VUQWZTK3JpZFlUVDR3OUllMVpSOUhQdDZWRlY4dTdXZ1BXV1hk?=
 =?iso-2022-jp?B?MzJRRHFmU0J1RUlrdGtFMytmQTZUYUdJU1VhUURyamNWTDY0SXpDK3di?=
 =?iso-2022-jp?B?YjhGNy9PcllITkN4bVZLR3Q4NElXREZ6QXVleitxekJsTldSMmVZd0pq?=
 =?iso-2022-jp?B?UTBiNlMzQzFBTTdMVlNUeWhCeE9JSDJUUUQ1Zzk2NHdHdnBrM3Y1MkNO?=
 =?iso-2022-jp?B?djc0UWJwZXZjdE9Ia1JacW5SaXN1UDJJVUJZQW14aFY1TXRoM3hVREJa?=
 =?iso-2022-jp?B?eThEMEVycXF2Q0JDRzJWZ0dJYzJzT1l0dHlNWWxLOFVrWmRDbTdTNUhq?=
 =?iso-2022-jp?B?MVpIVnA5cEs5YzhPWllUc2FXYVhtQmZ6MEl4blJncUYvdUplbzFXdi95?=
 =?iso-2022-jp?B?WmJ4M3NGT2pOZDdFdmN2bEtEbDVpZlB3MDBnSjM5SzRoN0FFZnZPSmNk?=
 =?iso-2022-jp?B?aG5wNzY1MDBTTjRnYzdVVW1XMGw0a0FBQzBQSTJqM0M0bXpwS3dYY1JZ?=
 =?iso-2022-jp?B?SlM2L3BjM2c3djNUMzlTcHJtUUxMVFZTS2l4WW83YW1FL0lYYkpFVFJE?=
 =?iso-2022-jp?B?YzFDUXl4eGw3eS9TY2VKeEdwOUtJdjRMSFZGREJCaXpnRkVUdUZ6RVBI?=
 =?iso-2022-jp?B?bFpzMVZtU0JCSExJTTluTnNNZndybTRWUWUrdnpaRDZoZmkybz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028ca31c-3d02-43d5-0e84-08d8a230daf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 02:09:58.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+90MubYNMuPkHLeWj4Q5ptdmere+iIOv0Oq6I8vvwwVq5w8LMqXol4p5yC9v+8peYGNIC7p7yUwywvKLlej2anj/Apup5rwAhNK9agu/zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5421
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xHXdAx5JTvrSIPA3d3l35SXsx4520388AA=
Content-Type: multipart/mixed; boundary="YNnDdnA6WXSfXUhDwi2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608171003;
 bh=kwDBmwYDTcRmjyOIZj12aG5nLrQHxTy1Vuc6XTL4Q40=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YejC9rq05GUoHLehqVNFCp8h2o84DEk7Yps8wXtgeCQ+HJ1xT54vY2oNgA2MrYGayel
 GTi0Vem9yvs7WxZnd1QZw7IvTJfkfgttwZaFJXzX/agI1LZhq/256vzQ1UtsUp8ohCQzM
 Tlx/fyb8aoOXuMs/4R3C92X8fy1XOndj2Ig=

--YNnDdnA6WXSfXUhDwi2F
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D12&day=3D17&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/12/cip.2020-12-10-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Ask Hitachi-team about hitachi_omap defconfigs wrt CVE-2020-27820 [drm=
/nouveau UAF] - masashi910
  4. Track the status of CVE-2020-28588 patch - Kernel Team
  5. Discuss an open issue (https://gitlab.com/cip-project/cip-kernel/cip-k=
ernel-sec/-/issues/8)=20
      - the necessity to track issues that have been retired by distros - K=
ernel Team

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB
  - next meeting

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--YNnDdnA6WXSfXUhDwi2F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5968): https://lists.cip-project.org/g/cip-dev/message=
/5968
Mute This Topic: https://lists.cip-project.org/mt/79028319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YNnDdnA6WXSfXUhDwi2F--
