Return-Path: <SRS0=NiLz=5D=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA26C4332B
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 22:35:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C462076F
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 22:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="f0Juh0QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C462076F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8041D878BC;
	Wed, 18 Mar 2020 22:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qHwy0eb2D6Qp; Wed, 18 Mar 2020 22:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 484FC878B7;
	Wed, 18 Mar 2020 22:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34300C087F;
	Wed, 18 Mar 2020 22:35:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDE60C087F
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 22:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA3C485E5C
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 22:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RqT07eodczTS for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2020 22:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410091.outbound.protection.outlook.com [40.107.141.91])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7BA9E8592F
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 22:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dle+bwOhqY9URm1mZqEo2QhAnK7mlil7dQ1ELuB2goT4Zc0GVez53fCb1yUm4rTn45ZuLovaHX0tjRdUWrqmtwbizUUuDN+C8PNoL4bOYTaMWWIqcsYT8BcOCpDPaNfhgfN+1hQ40QJojMs5pU0TCnIfmuZFq09igKr0UgvG08EGTnznS7nygCZVRG6LY7Q15VxLop+BYBFT8CngtTa2SDVkbN6DhD6lXC6cyEEWTSKvOxncMk/Q3a+3r2vX6ja0SAXoxWAvpT4CNaAnVxbFWWjKIiBdqJfvbupPtX27Cn0wJhuYwAHel/FUOTrG+hs5Yo+qGLh38zgHA8cXfmwSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc9GyDebgikqg6DmOefjoOSX8/kbKAqLy/944Sk0rjM=;
 b=V11skIXRJFb/FHN7dOPaVOmA7WEcMG1yQsR3yv6bXXLyJredznvCrV0Af5mzcouV6U0aQNChHFhu/3MH1pydP9Ck0FkfmZsgwk99tdtK08qqnI/lrVNlJWU5t4FYOv2T2VhHkWEXdFqXFnGfcmPKfPb0cqWyEZgql6RKUjdB4Q+suw+drjS8rwptk/6ST/FVGtbooW68UAhGozvCrJadoUztHVOeY35t3k4YrLS9qVca2FjCRAz+x7eWRGgtRF8WjCfmPAqWkJuK6o/L2rn6lwz8e0IkA8i/f6lJvO234427ZGIOiRecHcikr+OA2HmePZgCSUcLgi0OMXjMnIwvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc9GyDebgikqg6DmOefjoOSX8/kbKAqLy/944Sk0rjM=;
 b=f0Juh0QLqKMkuoLlMBXz0WyniraLsUYhGR6aNCFsz4822xVKcPXb618vogh3akwOJFVqYd5zQYucDzu/+ymbFU95FHNZz92WidyJSTDDodiuTkLcQt1wY5ZO3S/0Z3bzRDdtD8CU7giIzXcBlAeRerOaKZDDr4vk9dmkX1dxxvI=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1611.jpnprd01.prod.outlook.com (52.133.164.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 22:35:38 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 22:35:38 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdX9dX2slHPoB7r7Sb+Plxao3vu0vg==
Date: Wed, 18 Mar 2020 22:35:38 +0000
Message-ID: <TY1PR01MB1481511E8091785C5D10BAADA0F70@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae8d673f-8d9a-4689-020c-08d7cb8caf18
x-ms-traffictypediagnostic: TY1PR01MB1611:
x-microsoft-antispam-prvs: <TY1PR01MB16115545953ABB8C86C8CAD0A0F70@TY1PR01MB1611.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(7696005)(66476007)(52536014)(66946007)(64756008)(76116006)(316002)(86362001)(6916009)(2906002)(8936002)(81166006)(8676002)(81156014)(33656002)(966005)(478600001)(5660300002)(6506007)(66556008)(9686003)(55016002)(66446008)(26005)(186003)(85182001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1611;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61c6UWOr+NEf2li5i4vOVnoHEVapQhI7TdGKZcS2leaCdN8Y0nbcf1NujYEKS2Y+U5hXOoqHe3yzNQ4trRMTIENbrUH1EJr6XzGqX1ug/Omk8h2KBvAlL7aHwJP5ujXoxXmh8KmLnDxH7Hnr8pPaNjzbWM+zFqqJEOV2RMLR2NO4uL+D8HoQi16Z+DzuYmZwisrihy0ESPS9PzldIMEof/8WgbJfQYIkbsfAuIVR81w7Sv8TmxatDyxp3dosauO+ZSaC5J8c1/kqFxahKFNeMsuH3Md3won0U7IImOAvOpR+zZiamOBm9qpprftzVZ+5r1MB3+66oJgUbstiGf7jFbf0TSdv9Nel78C1XZsUzAwedu0R7c1fGUbMmEqSzNiwKG98t8/2yhLEFTktCEdwpupTbYMJtF/5WR1/lEZAZCbWee71/8shffJngQgnVfGqwNDW6ldbLUx9jQHLF6TKFDUfoyF8ZNub+CsxmSDVhugGNt1xNYRO6yxfEFOImWTGlt+d3JlYJ5d9LAP8pbc5kw==
x-ms-exchange-antispam-messagedata: B75I9qpt/h6CJ2P6oMvrZfZRLvivDj/TDEOtHF+1ZjNiebLoYkxFbIQSNYT2DksUDXAHWoSk45hrt4+8OtmV3dx4uAd2bjHlfdrGzdYhc9iJTI2v8M5fG0KXbzOl+TQFvA++letBbdOE3hVHYw4d1w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8d673f-8d9a-4689-020c-08d7cb8caf18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 22:35:38.9051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42hSJJI2bv6OO+qPliVYIo2kIEJ2cYjgnL3rKcwpUZi+G8jBr5M6VMYaoJqbf8Q7sHtu2y/rFFadDyYVGPl0niV3W15d5FPwGIynIkBEb9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1611
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
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=3&day=19&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

US-West US-East   UK     DE     TW     JP
02:00    05:00   09:00   10:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-12-09.00.log.html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 
2. Assign the owner of "CIP kernel config" - masashi910
3. Strengthen sustainable process to backport patches from Mainline/LTS - Kernel Team
 3-1. Workflow for identifying important fixes, backporting, and reviewing them
 3-2. Prepare the tools to be used for this workflow
 3-3. Get practice in backporting patches
4. Upload a guideline for reference hardware platform addition - masashi910

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
