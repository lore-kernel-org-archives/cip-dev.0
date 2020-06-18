Return-Path: <SRS0=5uPe=77=lists.cip-project.org=bounce+64572+4802+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F4C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:12:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA1B20853
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aNvMhUVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA1B20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4802+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6p7vYY4521723xldkpkDsHUU; Wed, 17 Jun 2020 19:12:16 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.95])
 by mx.groups.io with SMTP id smtpd.web12.1279.1592446334828354831
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2020 19:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iriqSB0rnGIXmyZtjQA/7cZsKLTE7chYngd3DiZ/pz0erWDN2M8fDvp5udpxZSuZDETXlDn0NpluV81SWs24PLnGqOC5h2yf6gr8LmRYsVt89ck6eyXDMsvUXj3u9jo31CBBpbZRP+61xiwM2f5c2e9ZDB4oqGJ9EDI1Se6zywkFfWFfvUoPacOwaB0+v821tfFvsUNrnRH9ivt+YPZGip7tTq7LP6AZGbI4B9D+xeFtsjVYUETwZche7wEANqax3uWaTcoXfgqrE+bDUxbz/tbEU+OxAv2CfzmTJnUVzk/R3P/5z3LtAHvKVom4u4X13ESDhDkXfEEbfmDy09scrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4sA7wuS2hAmkAsD4K39/rcNT6JQS1zjq6qSPBzwhsc=;
 b=Si2U8zVA179WermER7eqlCn1ObCiDvI6KYWMMbH86gahs1DWlqv+dJMBDnNTm8WU40H7KOHy1H/yMMPEfJ8Eqb/tQNetsvPFlUQuUwj/SnEz7gekrSlyn//xEPndMbzr4biuV9FgOzH4jfqT0zjS7JKcHr9Q6lk2Vyfm6KjhWGv+oD6YFaAakJtoEPIzk61ilcETmI0a7gj8HXJ8VgYU2oK7SPoRb2RxDsP3aKGh+cNo4NChXHZlkfThtE97wMHJyEVgnkjUBdnA3okE9cmqHnFVsE79auZU2GnTxn/pw8UvJiusP/PP22yYa1yo/m5i7UGR2LFO0tuFHYzF9LOOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3882.jpnprd01.prod.outlook.com (2603:1096:404:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 18 Jun
 2020 02:12:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 02:12:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZFBivWuOLGgeYmT9uB8s67CZkn1wAD2/jA
Date: Thu, 18 Jun 2020 02:12:10 +0000
Message-ID: 
 <TY2PR01MB4972F41B9B265B4EC9F916C8A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17025ec6-90c0-4494-62c9-08d8132d0258
x-ms-traffictypediagnostic: TY2PR01MB3882:
x-microsoft-antispam-prvs: 
 <TY2PR01MB38820837F3D0B77C02DE5924A09B0@TY2PR01MB3882.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Lrcx6kFefP3Y9dx+lawku0yRwG6acg2uGb0BmuhSnd1EFrzrm5h9PqgVFGx5Jf9E+FNKzsBRp5Wbrl6Fqd6YgbT6kLBnE/zcR1MfPnLMPvwwqBU5VOB3bxCdyBnQaznLWaUWkfMuA4pwkhjoHFX5eMAqaSXJWUcnWVzgI8XcSM4hvPXeTghG4nvqQwce83r7RvUIcg0jeQqTQQLG3ADftEk7WpoOh8ES1hfKOUR1OoPF6ejy/bva05eWEvYi95/4FBYOdyWBg75KYUxEJaQtBa6M2hs8hyhfsm1FIrymnX7jZ5I6YfKNWn6dUiTFi5Y7ofm1VlR/pm1ZfRj1+TDIt7t9o+mVHZ8T2V38JEDokr7OXwSMc/i18dgr8Pz7gx4yAeCRmTu4YdD9qsoCbq8CXw==
x-ms-exchange-antispam-messagedata: 
 U8kgMWApctYlgbEk/g0jj5Zx5fLnWrp6Z2uOwF400ZHBbr1OAcr1l2vlsHEj0pi4oE6JG80HwYLQHNnhNgVFipynyXZ8qbSAPUOThRJ9wofylE6YYVMKWJZg7IqL6DeLLK6zOUAfW0cZJR99rl/WJEs8TpItoMC63GGs+rLKDhKvlSxnhsOHUKr+11g4Tx17Gg+O97LSoklzw1+/wmy7pvRwdnYjXJh9bYJO/fFg0TqMT9GrSkzS+dkxSmjCrfIMldF18gqnFimy163UAswoDsMlN8dqyH0VDEBgfgDoUALqdoJwK1iCKVC9592rBadhGpcv0S11f8h3HzqJCi5TeUrgAxwJq4EIE+PjBQ/PSYZZAdvIGEN/Bsyc6SNq7Ty3avuTmR/JP+ARoaz3/kyLkFCZ57sob3aeneeug4r/G9qWKXSGMytm5QgvUCVp+D7gDi0+SFF0FD4Zzu2x43xIXgdd8JUnTJjgj864K93LtsXlA9B9Z/o98H/oWJ166L/B
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 17025ec6-90c0-4494-62c9-08d8132d0258
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 02:12:10.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoFzObRqh+cRV+vn565eSzcSypc3Fk2SWmkTRFy883NFDUGgFb4/biOI2nbo9Jie+9Zj8QcJ+AI6SgvWvFO/CgajRfFCN/z4fJ6zOFD/77A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3882
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ehIxRzwpLYnZZhd4EPkAD1lax4520388AA=
Content-Type: multipart/mixed; boundary="K2yZHM0OSPreQmcWjPWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592446336;
 bh=CnfVePyKYb8eR3draDnahVXER1rueGdH9WtnHaCRxSY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aNvMhUVOR8zZwuTnQXRmeSCykM8sKvyf+aUuFa6Mro9qOoDwe0rGvVyYuyaMYu4zTwc
 l+tX/gaQnghiy7Jn/FzeImFpBL6+tmfqETyxdH+4XjYi6QpbPW0ZAPbSuoP0QdHgcEqDT
 D+aBHKhJTOJLPvP5ogtoCriDFtAeRADBgIU=

--K2yZHM0OSPreQmcWjPWQ
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, all,=20

Please let me resend, because the original mail does not seem to be deliver=
ed.

Best regards,
--
M. Kudo

-----Original Message-----
From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B=20
Sent: Thursday, June 18, 2020 9:20 AM
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D18&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-11-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Ask board owners to review reference platform configs to optimize back=
porting - masashi910
  4. Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - iwamatsu
  5. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

Note: The followings are 2020 Kernel Team Roadmap stuff. If there are any p=
rogresses I will report at the "Kernel maintenance updates" in future.
  +. Strengthen sustainable process to backport patches from Mainline/LTS -=
 Kernel Team
  +. Upload a guideline for reference hardware platform addition - masashi9=
10

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

--K2yZHM0OSPreQmcWjPWQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4802): https://lists.cip-project.org/g/cip-dev/message=
/4802
Mute This Topic: https://lists.cip-project.org/mt/74949757/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--K2yZHM0OSPreQmcWjPWQ--
