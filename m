Return-Path: <SRS0=huxU=4W=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB1C3F2D1
	for <cip-dev@archiver.kernel.org>; Thu,  5 Mar 2020 00:28:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FB120870
	for <cip-dev@archiver.kernel.org>; Thu,  5 Mar 2020 00:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="hBCnoaSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FB120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 30ABC85F4B;
	Thu,  5 Mar 2020 00:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdUePiDblIVP; Thu,  5 Mar 2020 00:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8FF985F0E;
	Thu,  5 Mar 2020 00:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA0BC013E;
	Thu,  5 Mar 2020 00:28:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4793C013E
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A055A85F0E
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCkbbaD5yqXE for <cip-dev@lists.cip-project.org>;
 Thu,  5 Mar 2020 00:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410094.outbound.protection.outlook.com [40.107.141.94])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 02D5385EC4
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL6bju0FBY0O/USztls/WCWV2EnI3exRZShejZ4RvpNTqqVZQ2/w5Gd9rdxStPh9sxOpZ2qeLnCJ9EpTIIfKSG+36/5j89F1aZcEOSXS4qriIK/5ZzvJK+iQTFP0Va87FNpxpCRzERPw4m0ok5CnZtIyEuAliy+vyzlXVMj8/dzQ23ggnwJs2RGBtPYZBbqmH9CymAygpUT5j4FGcAdADsb//Pjy1wTNvRShueeq4MNp+L5xTzT2VDRNbFEeoNzuxW7P46BidiXEJUZED6bytheT+CmnZSziVH/6ZdA0qcXFrip9HnOwmGJl1ErcjqmMVicEUL09qQLaBaqfe5bUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw/opUKYzBX7otWenaCwCooWgMLL/NmFKubDflPpw/4=;
 b=InSC8PgdAeNtQOHYnEZvkVar3nkzNSrrpNQQGPgRuXmbzm9tYoA6RZ+51yu2tfGeK3Y0oglcTkU++JAkBoEcS5A6QSxmEgdRrMFnDuA9WZaJLkn4EjUYUHgC01ZccnN//pusFGyQIRtu9uVoCG9ACEH0agcjy6p5rjX+CL0/JM7JGgjm3uZX4oFeEjm8XLlgZlL26YwLz79XzDtjbSDMgqfiVYkiF2ZK6xtZ/mtj60m8n9cnl2ddS+yCMVMEdCz7n+24XaJ5zVZJf0XBmzFqb+Hs6Cz3BrTLCNrO3NIH+z/gRDUgFeFeYftxUQYy5Tby188nUHJLnDLbybDt+kQUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw/opUKYzBX7otWenaCwCooWgMLL/NmFKubDflPpw/4=;
 b=hBCnoaSzOrIi2AUwwJje7Hvy90QP+yh1E22lEHlCTzQ6R3p8I6FbJbxWq3p4gAUv8mizqFUjDMvRoy3i15Q6PNj/eVRl/CXr+8DK3cpP1j5RkmBqo5AtdwjXgrsC6vE32+j5anMQjIF9W3xMXf1tjCbwF+NguLMzhy4Z6pStv+A=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1739.jpnprd01.prod.outlook.com (52.133.163.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 00:28:04 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62%5]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 00:28:04 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdXyhLFygWu3q1m9RIGmtev2qXB+AA==
Date: Thu, 5 Mar 2020 00:28:04 +0000
Message-ID: <TY1PR01MB14818214AC9D5C1864451113A0E20@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 576b36f9-9b9d-4feb-ac73-08d7c09c11c8
x-ms-traffictypediagnostic: TY1PR01MB1739:
x-microsoft-antispam-prvs: <TY1PR01MB17397346A4260D163B316D16A0E20@TY1PR01MB1739.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(39850400004)(346002)(396003)(366004)(199004)(189003)(66556008)(71200400001)(66946007)(64756008)(76116006)(316002)(85182001)(66446008)(86362001)(186003)(26005)(66476007)(7696005)(8936002)(81156014)(6506007)(9686003)(33656002)(5660300002)(55016002)(8676002)(52536014)(2906002)(966005)(478600001)(81166006)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1739;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vC+QcH88PU02lnfGhc8HLYDl1yL10S5z4yY2hMiVJDa5+mEhLwh8oxIYz4HvyqKt92WVvUZ4LIDvgsXsUyqIuO80wPvZIwQceFkvXP2KnBfwPRa/Fdfxig5tZv7EmQY8xyJhky+nWvkCVyGIuogwvyVkg1fvLGwTHF3yABfPkxvpjhteY8KBL0iTnxKaWzLzPPR7f1nwqc+X1pVnC+F0n3gO3mzeDAoMahIJM6w6rWnBfz3J738UOwsg8zCiFP9M9UQcI25wb2r9HvlbrVDG9ubBt00zsXgMc9W1aT2TQ5PrI51vN/aj2WeWrNOwdRbMppqvLQZ7awopGl5kUtWEpoEWtIqUFt/PN28m2sZlxCmi78jd8l9F3niIag/NLmSqRLOjkLJspijfP0XYWfcuJ1vXwuHvPZoGWcY8VzXorfVXX9vWamn+90M1LQd/i9bRHb0euLThoi+C+qBcOwz2OdmFTqMgvGONpbrMKRi8FTKynve/f4YoSZQ7Mte1gcXeLQc/6Wn5SyRKxMatng2Ihg==
x-ms-exchange-antispam-messagedata: XeT31O6AxJ+VX+XcHkD9mKJWjzo41PHQZaTjOvseFCefHjwRxDg8DbZAaZWWqKUyKYMMr9WlHFSuuMyIPQwyMIv3yo/BYFr4FmuON/IkdVt1BGtbWKBrIXGT6NwpIUlhICkb18KP7JQ59J8tzLorIw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b36f9-9b9d-4feb-ac73-08d7c09c11c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 00:28:04.1190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr6WEIopMbEzwSqYEsQJa7SxoZushYFWvvDWmrhgNcEnxC4hBuUimLhH/ArYsqaYFOa0lnxUW18v2tK4VTuinWV9yFzR3LxEIWAyVUEDdw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1739
Subject: [cip-dev] CIP IRC weekly meeting today
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019&month=11&day=28&hour=9&min=0&sec=0&p1=241&p2=137&p3=179&p4=136&p5=37&p6=248

US-West US-East   UK     DE     TW     JP
01:00    04:00   09:00   10:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/02/cip.2020-02-20-09.00.log.html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 

Additional action items were identified at the team call last week.
I am preparing to list them here. Please wait for a moment to appear them.

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* AOB
1. Migratoin from Mailman2 to Groupio
Any opinion about the migration timing from Mailman2 to Groups.io?
Excerpt from a mail of Linux Foundation:
+++
We are now ready to migrate from Mailman2 to Groups.io . cip-dev archives are already being hosted at lore.kernel.org, and when we perform the migration they will continue to be hosted on that site, there is nothing more we need to do. 
Linux Foundation IT needs about 3 weeks or more notice to coordinate the migration. 
There will be as much as 24 hours downtime for all the CIP lists, however, emails will be queued up and not lost, during that time. When Groups.io comes back up, the emails will come through. 
+++

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
