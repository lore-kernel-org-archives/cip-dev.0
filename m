Return-Path: <SRS0=BiZv=44=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775FC0044D
	for <cip-dev@archiver.kernel.org>; Wed, 11 Mar 2020 23:42:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D572075F
	for <cip-dev@archiver.kernel.org>; Wed, 11 Mar 2020 23:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="OrN0jMGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D572075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A23FF8614A;
	Wed, 11 Mar 2020 23:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkv4gT6t4OeK; Wed, 11 Mar 2020 23:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB4C282DDF;
	Wed, 11 Mar 2020 23:42:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FCC7C0177;
	Wed, 11 Mar 2020 23:42:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64E6CC0177
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 23:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5C2BD8927D
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 23:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQlROWhI+YnC for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2020 23:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410111.outbound.protection.outlook.com [40.107.141.111])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A8EF388E95
 for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2020 23:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqW1DCZNvYCzyhsQ1WCwgocd/uZIQ2g6QVHpERX1fOLR27OEpjkudDOOyCGelgOLVC1816Pcppkh2Rk6ioYgeYmqOQ3Df9Ekuzwu1W0AEClkXa/DUiYpL35I2xMy3uXgFnJAj9oMBNi7fosN6TOtEg/xbbnNcSYEhGyfTmrMTvqtk1hSXv/994+qBdR8wFWReOhrLRwimdoWGqrkG32g39+9z/DzVDuDSaXnpTIUIkSS4z11HksTjR72btyBJhTT7g4QPYrlI1DVgTM7rWOLA+HimWJBtN1daldH3z8O8Uwm5sc8UIu4FEE8Pr75iZTSOHKKxx467ekEE84SS71xwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17UlrTB8ldN1DFLKr3i+t68AYG85kR9v89cnw646xXg=;
 b=ArZTY8HNT2tGGAJzmpBAuZNHP8UjihkMOYH8ia5mA73ir8mdW3MtMlserQJyLtKrdBn5pHyez6pM41qBe80q2AagPF8WqA4GogGUllzEVGZjwx4RJAZPam/3ifZX6RSFxNzKOps69smn/7ywO71rDL1+lBVX2RGh+Elo2SYtwlVnfQX7rsWIpzMFDrggQju7zA8KytS8VePVObcI52g1j5LHEsxP/REwVEPlbMRcehQ62NuaJV8u+Tb2Z7A5nvBveSIN5l56DTp7sVCLoMr1noOKWH6ORnsPK4ZRZK10na1BcBX6f6Mhf3Ze8y8c3tMJs1GK1eE7DFP8fwxVl8W+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17UlrTB8ldN1DFLKr3i+t68AYG85kR9v89cnw646xXg=;
 b=OrN0jMGIyfrDdG8IA8VubPJcOipiG0hI8iH13wYZ/qd9upCBvqe5ODF5NGl5iDHEkQf1hHofjSUvjGN0MPNgDqUxcsZFZAaUDtLcfRX2kY1gcuxtVOmaQFxzc0EfdvK9bfQg1xPHMKVN8Dyx8DEmPT25pXcfKQSVlCkUBkY7Nuk=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1753.jpnprd01.prod.outlook.com (52.133.160.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 23:42:33 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 23:42:33 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdX3/hlEK7WYbFopTSeY+hTY8F4Cag==
Date: Wed, 11 Mar 2020 23:42:33 +0000
Message-ID: <TY1PR01MB1481A4F2CF9E4905A3CA7246A0FC0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fd031f5-4d70-40a1-6ed3-08d7c615def5
x-ms-traffictypediagnostic: TY1PR01MB1753:
x-microsoft-antispam-prvs: <TY1PR01MB17533DF155DA7492333735DBA0FC0@TY1PR01MB1753.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(478600001)(55016002)(6506007)(76116006)(9686003)(86362001)(186003)(5660300002)(52536014)(33656002)(26005)(7696005)(316002)(71200400001)(8676002)(81166006)(81156014)(8936002)(6916009)(966005)(66446008)(64756008)(66476007)(66946007)(66556008)(85182001)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1753;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eo7RJFboZyHSos4dJZBRPQmU5doZVK24Mapc3kCwDvpAfVPbV1gXUif968QTU7LGRDJeUNL0Vp/T8fqXMOkwrVBG2hP7QBNgFRENqLgRijAGJhMGaRGxDqNwBa7fQWgi58Lnkz2xazxvqJaCCibWpQgIaHXiwPaywqQoTe/XiY1JUHeBN9VzEbfS07UixX9SEQ5vCTTSpxgXztS4yivNK6cid1h/t61wkbsv4OybRF0ScxGCxez+759wu0bd7jzrNvNYt7GVSRgYd7U8IyQUVLNzo/u91gtc3kfbZzXnt8A6Y4sx6V2ySC/b1y2WkC/Q/QRac/bkpyJTs0TuoS/eThFiZdYO+SBkOaeOhosN79EPCGOKSd/DYMeN0x3KYXg6fWHZeijtMXBJ0QSu+JIx6TEEFI/eUM8mHJ+2mfXy/7753x1OBvAz6N9Bfr8uBu+lyrCfXrHCxzCnwPEilhD2gtplQbml0BRVXbIBKKPhyIxeEHs6yrXab/ailtupkUeRRJOfkrbacKRy0E8r761y9g==
x-ms-exchange-antispam-messagedata: HWsDmvgb51cYF6VZDjXDe05EN7tQZmGvuA+X0nAEHwzOsINXlc4ATqNpbLsHx3k86AEFy0Yt9bc5HFeTVBRtBw+WRh3CDmr4q1B2VL2kDdYU7GBhLv4rJwL/SxfiBBSR7XEqB8EOItIMSo2mr0Zksg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd031f5-4d70-40a1-6ed3-08d7c615def5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 23:42:33.2434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caJoYNRbLv88Csbd2q5bCH2BY7zJc4jgpxdblfEQIFSY75w55SZ+3IQ8pFwxiA5LDGxzCg4/VrrvgjsWEq2tlbUSGDrFwye5h9wBZ9ONxXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
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
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=3&day=12&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

US-West US-East   UK     DE     TW     JP
02:00    05:00   09:00   10:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-05-09.00.log.html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 
2. Assign the owner of "CIP kernel config" - masashi910
3. Refine statistics figures of Kernel Team contributions to upstream (LTS) - masashi910
4. Strengthen sustainable process to backport patches from Mainline/LTS - TBD
 4-1. Workflow for identifying important fixes, backporting, and reviewing them
 4-2. Prepare the tools to be used for this workflow
 4-3. Get practice in backporting patches
5. Upload a guideline for reference hardware platform addition - masashi910

The following action item was defined at the team call on Feb 27th.
We will work on this when time comes.
  x. Explore the possibilities to work on security fixes proactively

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* AOB
1. Summer Time
US summer time started on March 8. CEST starts on March 29.
This IRC meeting starts at UTC (GMT) 09:00.

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
