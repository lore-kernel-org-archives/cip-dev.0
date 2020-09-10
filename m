Return-Path: <SRS0=ewtY=CT=lists.cip-project.org=bounce+64572+5439+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD63C43461
	for <cip-dev@archiver.kernel.org>; Thu, 10 Sep 2020 00:23:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134A2221EE
	for <cip-dev@archiver.kernel.org>; Thu, 10 Sep 2020 00:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fzJ14bYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134A2221EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5439+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xyuIYY4521723xVtP4tYjZl8; Wed, 09 Sep 2020 17:23:33 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.130])
 by mx.groups.io with SMTP id smtpd.web11.10684.1599697411694874786
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 17:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdBqfmUg+Q2EH1TvXCMlKoxpz7UMHvHLPYxAis7HGfXmEvl+8wG3qx+dbweosHQ7JL8zht7WqGabixUJlvD8yhvgyGQB1jQV74xHVPOLQgAZLMpiqrdY5u4Bsj6GSGBExtuyoy5uNbQnKDM2uP6Xok8drf9qpIvhNjK07hYXcTvp+s9WHeqKi+maHHqPUPwia7iJDP2oAhZTxPTKLOgA1VfaRKqBJjRAXcOxihl8qR9ijdDmeUPptWB9Mho0EL8Y2j5MWhWrU0+VMZf8v3fpvVbTpz1drbNGYfSWxR6zSKOtP7MwQnSvVjQmfhWO/I1r1+dptTShw188zTVmKXv7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY9zJcqabO9Q6sWSTJU++XIVEQQTQnbwIiE4aZKUHao=;
 b=P4bwsoPB4w5VdMjO3MB0KV9hbkwoo5XmFk7bLiS60vjPnaaxelYUwGTTQ/AyN+8fpn6Wi/if1C8fYAatPLQk6B2Li4R6a7tUnlCHWXQfu3c3oomE0seDHK013sjdL7TtYAJuGi61WYidtC+5zCXkPfUhZW1VBPVGySNCZzZUyVI7T5eUkXN1J+FTIBib82IhUYs3AwYKeKIAbOTfh77Ej0K3EaTF6QOmbuCT/IsncRxhqpuV+flbHJzvIjO13sqmIY7EbZW1//J5CA9qh32W7mMr2K0Kfy4pghVaX+oRNFODVMPRz4b0tWRJqm23QNBsJRsed1umlPhtTHnXaX9Tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5472.jpnprd01.prod.outlook.com (2603:1096:404:801e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 00:23:29 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 00:23:29 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaHCJZTskm2rTDGTwOhy1OSZnZU2Q==
Date: Thu, 10 Sep 2020 00:23:28 +0000
Message-ID: 
 <TY2PR01MB497270686C7A7E2C068315AEA0270@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9deb102-1be1-4a5e-d1c5-08d8551fbdd3
x-ms-traffictypediagnostic: TYBPR01MB5472:
x-microsoft-antispam-prvs: 
 <TYBPR01MB5472AD4152A6F72186BFA001A0270@TYBPR01MB5472.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ihggEDPR0ICLuo7bEDLdD1emkvXEORruJFkVdYXE/JbpNAsE7/CxsraU+j8FqvRSJExsEiEQCHKucsxROqkFNg1xktlmsCbtm4RM6iCmz/o6yogaM6Ai2N8dT7L7LB2Z5MpNGfO2L6sbMsbCW4Tp40CmGZuP9ygsX2pMj4btHiEgRDEE60gq9ANrSlgxNffaQrDTyv1/dzl6iqobEFJztADrrt9dOEOCFbPR84VFcA9rqE4C6U8B+prIgwojcJNu72wcSrYkqRxLnyjYfXwNoJ+eLGcwy+N3BJeB+aA1Yurukn7c6NTo7YbHumZwQN9Fqi8Fl34Z2ne/4Idx9bv3H4VVhAgDZ2QImC1je+Qw+zWonE4ruVPkAioI49IYMP9j0fdP3aKJ6kIUmQb0fdtppA==
x-ms-exchange-antispam-messagedata: 
 cNXRPc8VUAuLPIEbDUTfa2d1NPl8IPZ9AJ4XuD8PnOpQiGDE4WC4nw1HmqI0XmyHB78VcLVj4xg9QgGjTzZG10V48s98SE58UFQNY+11oejErM2UvKMoxKmuPi7z1xUNkyGI/HllUfVXNA2NrWto1O0MAroWAYh75l1BTZY+GH+rOxwnjADYSOQglL6OCVc7K9eB/faVeEBjTW7rMrp/M7wsiNJTuF3VeLW4jlUAdHHAB9Qpj+cAEzIgaP0loWm/tZwzGR3J6yfRJOAzIfvsrBUOqhLjbDYe6BP52HBqgbYv4I1OrSYsOxthmDOAy/u8V2Wf4Cox+lufLCglye7jZcXXFEWC52t/oUNoHYD+2VSpoDDptD+hG6b+6m4zwVQTGLWHPeD8FpUlozNfjONN0O1jdSNx58wjxpEvPb3cJv4lgG4vblaJurrMlW9KgwPQpVSid4Z5IhM9mqduBYN5PWBxYTBQQeMt5JHVw9oo8EcCfDwW7FJF9jdT2dxJxtVkxjX74xuEZp4ktqeX4WDDQ84Hsw9oOMsrWZCtiifXWyuXyj8K3pzNaG17NJo4LDB4FOkxSCnsq0hzjj4JUdgGzIZqfzmKXTHcgM5oISiibUcgL9Pmj0KW6SN7XXFQjEMm92X5H4hbdTyiqp11ID1FiQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9deb102-1be1-4a5e-d1c5-08d8551fbdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 00:23:28.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt2lUVWnXMS35KmBVr3yreIdc2QjNb+EwRC3AeXUeORbq88JJl7UphmblPZJAoZgxV80PDvp6VvSv5LIbdWJbyV+IqpWvjjtZVPhGa42IvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5472
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gZciVfonK6tP0FQ7DofofVokx4520388AA=
Content-Type: multipart/mixed; boundary="fybkDaQBWl0mopLNxxdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599697413;
 bh=R4n+a8ohIQUMi0AYX4goWmdg4N2PMJVKGqvWEV4mkcI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fzJ14bYmLi7Z13CR1O5A4BQrQPPhkvjxEC7UFrG2eLbxccefu9PZDxtCIgqxt4NKZDF
 TmqxhSR7K/lfzT0YZ1McAzzXIVXMm5+bahY0RtMX8KnrZus1Alb/c1ATUTAACeVNWya5p
 Zs5zZOmUapo8QZu9/Ltn6J2YH8XOWg4J/xs=

--fybkDaQBWl0mopLNxxdV
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D9&day=3D10&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-03-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20

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

--fybkDaQBWl0mopLNxxdV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5439): https://lists.cip-project.org/g/cip-dev/message=
/5439
Mute This Topic: https://lists.cip-project.org/mt/76745849/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fybkDaQBWl0mopLNxxdV--
