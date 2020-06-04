Return-Path: <SRS0=7pa6=7R=lists.cip-project.org=bounce+64572+4672+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460EC433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 02:39:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937A0206C3
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BREV2ytA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937A0206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4672+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YMYpYY4521723xlCLUBvAjGY; Wed, 03 Jun 2020 19:39:03 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.122])
 by mx.groups.io with SMTP id smtpd.web12.5834.1591238341102894223
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 19:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+lMvjll51vNf7mhaJ8Saz++eBh0Ll9vjAyst1TqVuGYayMzGyq5OWxm9urgX2/5nQiF6ImPk9cnSxkPYA21oJwODBf6Y7z3cOrySKGrP3jsqx3E4jWT4RNxkZYjG3ludWa1AAtQL4V2FgILDnzuXxQxYalS7D8/BMvepAFhOmTGmylTd6YjG7ayr/og+fs0DFB2mQML75vSktQIgqz90TJg5fErFVMzGKGj0R0D80Z/fyHrA2g0+g2c19AEfaxVpF/ZmpNzS+fvoBgpBTou2fSoWC1+j+1AgIdug4bgdjtVizG4rwHCJXEW9xiam7Zjk+LiqaR/PHuGypEAn6xCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eecbx82SAgQAIu7m7KbTQPougVVaP6y+ZaDuXGKx9HU=;
 b=Ufmfje+x7FBf8K7jkyZ+l1BhjW/9moT48qmJ0ZUcjmvdD6X7LklgPus4ACyivVLG1phVnIYvrIM4Wil5RqvSp6TLQzIMAfJzUggwQ5KsiCxLpd3ZrQUThESuw8sIR1sCtEFo9NhWZPf/u/8PZ7iZv2mLyRCRLxbutF8iSBv+qNM2r8f6YbZmoGddSMrBTB01Xfo7RB2hmzdZH54AekBlM2fNBHye8Hp/ZErTQxLqzY/sB4pDKfTfs7CzQqYxlE/QSbeLvoXXViscRCFQaC4eyoTpBS/bZK6XDni4SchXZQxGd7gPaAE5k0fw2ny9tHb85IHuo4X2V1LjZII9Mab7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2011.jpnprd01.prod.outlook.com (2603:1096:404:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 02:38:53 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 02:38:53 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdY6GUi8/ClWh3wURD+LTAYT5PTP1A==
Date: Thu, 4 Jun 2020 02:38:53 +0000
Message-ID: 
 <TY2PR01MB4972DC5057F16D60C18E2B99A0890@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 615f94e9-1a3b-4b25-99e0-08d808306bf3
x-ms-traffictypediagnostic: TY2PR01MB2011:
x-microsoft-antispam-prvs: 
 <TY2PR01MB201142A284B25970AAF89DDCA0890@TY2PR01MB2011.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 cBRrN3CE3LXI/IDng710N1/tmE7B7Ki+IwnF4EAJGeqjUuIZWfVqaXo8AlUz60XHIsXH+sTvt7LcakntIazmu7Za1UT3rwuSIZxwp9SgP37mY3A+KCwg+4d4uXjMxSDntPRgNB9AQ/rIXqU1iye3Ye5G7WZYf3pge4MlnuDLxZbxd7pvuzV7JRHrXtYbO1R+A9KZaM3J/wGssvudW371gEJpgqCVTYpPZ4JTXPW3lfw4FWkVTfszOJpyQSCcYfOtPoKTUFJ8g3Go0HT+O072FO7OKLTSklpHETKPKmEVvQQhrJnekcdZ5DGWtK+pOz3zKpqejUWgeE2JxZ1gq6L3fR9O7vPf4XwggHBQAn+TKAlLdE+z5HOjaj2+TMM3e2MEWk4Wx0tif9rpZ1ZN8f+KMA==
x-ms-exchange-antispam-messagedata: 
 SpqfOqe+xPD+JD6mRVF1xdKHMGRtPYtUQ12S1PRcRVlbiDMpzxuoG3gBFtJTxA1KJa4F3tD+fiOX/r8N0wkumzCmwXKa4FbNi4+PrzyVRDyD+YxTiVfLrQBFaapsAqWPezTfamLtwg2mzyYcS94127EkWAMBX/iLkL4IzRr8qqAhLUudJ+aUYv4nI31terBhM/Evqt+adFnMtYDSJsqJQsZhHPadpIeD9TsRjMR3U3Bm8OAl3jKV+16ivoDdsjr+0vgBDOsPb2pnOsE8j1fTSF+bd7i7yLNN6Scjz0w0DSFC9ctmsbWYr8nERcHrl/QbAz5JZN9guN+SV/OsJWTvTzf6SmzDN3el5S9G0adJwVO4Fam0Lqn+U+6XWWcHnhpb/c5BYMgKuW/969APaGbISZLfNjGp/gnnqYBBRVeNMb1kEfr6YP2b5fP67BMedR7HrZHLdWM52hsWq8nS5/qP+eCAuNcpMGeSzRfZ/HH0XLgFcC40lT+LEpEJwP9bpKTQ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 615f94e9-1a3b-4b25-99e0-08d808306bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 02:38:53.4305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMGIsZlM0S75/PpNVelksVn/ytt6T7JRozzRxuwqxHWKT2/tBXxOfwABXxCa152eWzm+mdfAvztxvwKCEK0IVRMZCc985G/d/krewLoad5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2011
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3ZskTw8neSplLoKiGppqAxirx4520388AA=
Content-Type: multipart/mixed; boundary="iitnTHz7helM8uTL0PQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591238343;
 bh=deTU7gDAkKEuvmbl/aopdGlJggVtnHvP3qkr9Mbnr6s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BREV2ytAaBim0Wy0BaP29LnYygJlLcYsunmstAIrw6nVUMh5577DzW9g7KLKuwxnhd1
 /92FAI6ZHIGq1ANECPEXL5nC79uNTWu2koIS4J4Dcl/D2BDFrfGGtUWQxXLRlNwECxH88
 +uV/F8pFqBOI7qAD9HpmIsTrYGv5+kue26k=

--iitnTHz7helM8uTL0PQq
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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

--iitnTHz7helM8uTL0PQq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4672): https://lists.cip-project.org/g/cip-dev/message=
/4672
Mute This Topic: https://lists.cip-project.org/mt/74664504/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iitnTHz7helM8uTL0PQq--
