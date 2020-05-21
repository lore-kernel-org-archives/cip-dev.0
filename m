Return-Path: <SRS0=05Eo=7D=lists.cip-project.org=bounce+64572+4635+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C7C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 00:36:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14372078C
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 00:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ncc2IE41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14372078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4635+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d2gVYY4521723x6J28Vxr8z0; Wed, 20 May 2020 17:36:38 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.104])
 by mx.groups.io with SMTP id smtpd.web11.1788.1590021396183904473
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2020 17:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMpiyKPdQk+E02tzszDRYGhoXPQLU1NUbXoKq0DT8Aytyf8W2vO8zCNnrAByXByzB+5yiWgavy1mOphDq/b5yWC2fNa0bAT0LhCmdQMtemeOv0CIS54KgxObohS5lH9hLVALwYCmV+3CN+KucOE+by/p96/xK8AoIyV4zTp1knqtgYVDlwp4IuWsBX+P3/uZjS1Yn2+oyFUip0HyZuba4Qp4McFNt26BYRVViwBOMHmLlHG1iv6+0WrPLoPfyOgiz4pi8zPDO/yUPneAN45OPBQRc6kdJqyGrdXDRrtGFev+rJ0QYAlOhcT0dJNqV1Regf9q6QNxttNvHuE4zLIeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TOgWMCbUQ1VRzPHfsBe7TYj8tWl6MNjl0e6LRH84kQ=;
 b=ZplCVC3wmJf2cuwmdz0J5bSIC/B8wVvJbBlWeCQiw6v5ieJjzR2wuuuba0uRhIWw0/ZWvhLX+KhsOy0kjHjIjHBVWzZLbGHF+PWjAY/G5uF5PeiXNbaq8Tr9kogfs0XEcqtKf4fS7NJz/s6SgVb2iL+m6S06j2A5aDe/2XAg4GP2kclRPQGshjxsKZ+9qB8GXfwmxsIRo7mmyTRm1vElEOChZPL0yC3bUWPf92WBTKNNBfBKccAbhNUXKMHjs1xGix3IETJPwc6U+4KAKODYjeQX5IXxAr9N/qhtRCDWCoPckjnKFegJ6YaGcZqgnV9EKWWf8Wd4Ogq9rvHnorDgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3001.jpnprd01.prod.outlook.com (2603:1096:404:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 00:36:32 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 00:36:32 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYvB7QVKLJJTSekT7GTmv8mJ06fZw==
Date: Thu, 21 May 2020 00:36:32 +0000
Message-ID: 
 <TY2PR01MB4972A13626095E5A9810C62AA0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93bc2d17-743b-434a-b802-08d7fd1f0254
x-ms-traffictypediagnostic: TY2PR01MB3001:
x-microsoft-antispam-prvs: 
 <TY2PR01MB300117D53E1D76C402CE1B59A0B70@TY2PR01MB3001.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 zeXqiLKKx5zHVNMv/Bi0NwMmwor2h5XUyCvgQW2yOVIIqB2ZPGV0IdgTiMFH4+Asx1HRzxclpIu/i+g0NEgXVzp+OXZItDs8UyDXGD4RHKyO4q407GUnIFOuYQ7bOunjFGrmzNNS0z61esBMWmzcmx6KJZ3sCzgob1xsYCJOiag6vyj/mZd6GXuf8axv6u9AVlVnDuyRPDwwT5n/CmkVeWdk0CJXc6M6+8yq9anIYwHCurMlg0YFxHOXibpXpAMGcE+02QWWh1SUvAfs6nMwOCPfBm+1PpzeXh2PIUKLDvMiybtk+CMFbQAo8y8z5u1biUKskzBqS9Yt/rPTr1vbKwWU/HxbNEt2xzI2c7mcgDaC/f4e5pVRKM6SMXdB4VTE26vnuoBnrfaNzCewRcd+JA==
x-ms-exchange-antispam-messagedata: 
 /g8CsLfljUmbs81eQK5c+mApx+eweXxs2SHgpshSY8pF5eCjIKAnaW2msI7OG+Td2u/q4VlrDLMxx0xywo8JmvEgD2Ea6StKnKbxMYO69CY3cPsUMn+9ttG1K/QCT1EIiyS16oZe9azllVq2LwZDFjKb/UAUHe68C7+i7Iwk96MrbntpjVRYNOUN5H0z0kpkCOSHeMwo+rSRCxmhkXiOyjqOhmPqX4c3AGWxJh9TQtUNrzZ4KJtWBU/CosPbR3HH+U90o2XwJ3I8MUumiedsdPWw/czkSGF+Loy2DDKa0eZIjqp7wqH8gBXZRyBvWBFVyyrBeJTvGXBLKwJdY6m8PrdVCevHq/oOaO1y2YVRVHpzW53jB2YTqOKvsaASKPWLZsdZdx1hHw5QO2qxuhO4rLbvSt2+mfBlUuvxKSDyI7CoOdEIoN7cpuYxlIpniyirJC/k1qOv22phkGZ/5zL1UZ5pjIT/+nG2h+QsbS6oFwDcvBD6l8s+wYzQaMMvrkPT
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc2d17-743b-434a-b802-08d7fd1f0254
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 00:36:32.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEhPEmYS7htpVmXYPbdY5BbAdpTCmHKCVXd6EgdE2eiEafcg5fH+REr/5z9RcwAya+lwCMKq7fUDPoULOV14K11O0AmWGkc4Kn4Ql1HGkK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3001
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WPDTir7Z2tCS8vVh2wT2VdBFx4520388AA=
Content-Type: multipart/mixed; boundary="N1tPVVV44UTOkdB5Kjp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590021398;
 bh=hCVE1fE1/Z9Vo8YgmtBGRXLt5U+7ZevlsdJaGz6fU18=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ncc2IE41AvBhXm0VZTGUx2uxSTeL1/OywTzjA8d70CV+YoF1Ephi3cI/Rxd6BvC2vYU
 KvaVrwWomL70EOraKT7N8W4HLgxrixoMeAaOenNiGKKk++kIy2CZodWyX0QSF2aXgV9Yh
 bZ7D+WBtBeTDlSfSC1e7XYT7bIAM7vRO+WI=

--N1tPVVV44UTOkdB5Kjp2
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D5&day=3D21&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/05/cip.2020-05-14-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - iwamatsu=20
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
3. Upload a guideline for reference hardware platform addition - masashi910
4. Propose a reduction of kernel repository mirrors to TSC  - masashi910, s=
zlin
5. Post LTP results to KernelCI - patersonc=20
6. Ask board owners to review reference platform configs to optimize backpo=
rting - masashi910=20


* Kernel maintenance updates
* Kernel testing
* CIP Core
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

--N1tPVVV44UTOkdB5Kjp2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4635): https://lists.cip-project.org/g/cip-dev/message=
/4635
Mute This Topic: https://lists.cip-project.org/mt/74364606/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--N1tPVVV44UTOkdB5Kjp2--
