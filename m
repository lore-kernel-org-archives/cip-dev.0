Return-Path: <SRS0=dsOr=5K=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F3C43331
	for <cip-dev@archiver.kernel.org>; Wed, 25 Mar 2020 23:26:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD43420714
	for <cip-dev@archiver.kernel.org>; Wed, 25 Mar 2020 23:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="qC4uAKch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD43420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CDEF875E9;
	Wed, 25 Mar 2020 23:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4VbJ2VZL0eHG; Wed, 25 Mar 2020 23:26:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 03CA8875BD;
	Wed, 25 Mar 2020 23:26:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB00DC0177;
	Wed, 25 Mar 2020 23:26:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02414C0177
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 23:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E5264875BD
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 23:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ufq9APVfECYa for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2020 23:26:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320092.outbound.protection.outlook.com [40.107.132.92])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9237A875D1
 for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2020 23:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM2Auy74odhQ3dgv7FFqL1e61TsANnwVtlTn1Vv0d8ei3eswjngynP6qNM7+8/bnSIm/o4COQqeeE19rAP5Lfr4w+TDa4WwA56hPPVE+faOyCVPBGiMqvr9uhUazlbiUpmHeDZgk7Y7u5t0vF7mJY9pJrvJYouiNKPHL/9RC3V1Z65XsVHN761C5rjTaDLXPh0+thMmgF02/8qHbzEYiYG4MLPwMh2ssrPm193cgj8LdvlQukt+sJU4MEMzbn+okjSsxYhE0iZ6UxFz/RtFVqwJaYP6Tc7EJcn3KY5yN5cOUANitMYdsG9OArHJK1Ff3xjyeS1nTI4rJ22lNXYsG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpDtqNXWPUGDpiNeNN4JhAu3I8yVCniiDMaNd56xYVg=;
 b=E3V98RXHTlCOGV766GB9I/QX9KBzNWqw8U9plVY6y96mTtbefGB+KtCBLnjDfybxbrz6LpA6+mVSsf26o7aI677xwoWp0juU2Cr87eMNBjLIoaN6hiOnSzFAxBzIEZcB6q14770MH86UT0R7YXAZaT4zkzmQJ9xh8WIu+dIJ0sAMCV0DiSHYoV7RA3sI9/4MKT7CkjHArp1Q5luC9JlBn8OVfj88LluoMaSUr586/fZUqyhgMqfQmfH2DUlg+g6KJ7pC8y0h0OwhT9vi8ePC5O3dN5xaWUY+c+s+E80L1qZP6MzOY6H8Ybh2nb1ESxRULe/X6HAzXG7NRabekm36LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpDtqNXWPUGDpiNeNN4JhAu3I8yVCniiDMaNd56xYVg=;
 b=qC4uAKchyZKPMV5zhO/zTyVFYaQ+wjtSZYoyYOj5mcRNENk9wFxxDgliKIo/UzK29gwlqAF5MhuAdPlJPNC1uaW1fdU+R6s4rRH6WtbgtLxUzquAoQeEJqk5bOTXsbADxgFqn9hy/XXOUdoT57APO6y5oC7RCUGZmnMJV6GOcZI=
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3098.jpnprd01.prod.outlook.com (20.177.97.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 25 Mar 2020 22:52:00 +0000
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2814.021; Wed, 25 Mar 2020
 22:52:00 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYC9/DApTGyuYmoSqOpRjj3/fUEgg==
Date: Wed, 25 Mar 2020 22:52:00 +0000
Message-ID: <TY2PR01MB49720412F80004F01E9BF8DDA0CE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93506874-31e1-4bab-0103-08d7d10f20e6
x-ms-traffictypediagnostic: TY2PR01MB3098:
x-microsoft-antispam-prvs: <TY2PR01MB3098FFB062DB03306055A478A0CE0@TY2PR01MB3098.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(33656002)(55016002)(52536014)(2906002)(86362001)(85182001)(66946007)(71200400001)(66446008)(76116006)(64756008)(478600001)(316002)(66476007)(66556008)(6916009)(81156014)(5660300002)(186003)(26005)(8936002)(6506007)(966005)(8676002)(7696005)(81166006)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY2PR01MB3098;
 H:TY2PR01MB4972.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgSeqoqvwn/SBEHje8iLo9YY/1TfPeL3Iy41YByj31UoFBCv/jy9OyBR06pwdbI7k4KeQnFgcORW4ONR+/yxL1OO0JxEQAdpvm4kxWjn/+XDJprSbUL8ckMbECpv60cPFPEGFZoGwslJLXlEEVpktiBLNUFookOpBjl3UnGySvrpcfikRMwEpuqS//ZLNu4H5WV2Rk6lHAHrVnGgnavTV7KHtF/cyXS9/wPuk012nE+Kj5qpUJ3nHdUseuLstmFxWUeE9hFKXKVWu7fOx++bVJ3gppH2gFWovqsGdkwIb0Wl0Z598BF1wynz1grnGYzZpvrBvlnPjvI4tw7Cas82oPaSJItRx72nAN3+4CHySu4ma7sjt4Lbs8Vr4a4KDeLKT6fLiUGr2LFiTdAhoM52Hx5dSNNfo82HA9SmPB9Hr96pQvn3CEACGZrHn9MTsZb8DhJoZPB4AjS7zncb7WF2HCLCR3eG8EYjcUQK4GbD7dwMMkl6PL0JQZuZJtCydrRRWoSdWaUhut8/qVGK87NEmw==
x-ms-exchange-antispam-messagedata: 82G2AZy/oc5wmVkfyCoLCZq6Z9c9OKhpfilQyS8Hm80+arOj2JXqXfAx6aVACy4UWy1ci2xO9XAJs/odF2muycoFJJR7bgSWPdjjOUSEdVwlrBtsY0HzhlrmQqtmxbd09OpYhZjL/ZcTGR/DInd42g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 93506874-31e1-4bab-0103-08d7d10f20e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 22:52:00.2453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxjyLX3NFCVX41yv5kRISGmaSC2pbipgJV4Im9xNA76yL2cQ/jaKTUxEJxmwD38zCqKOELXVPzbRN3CNoC75nbZ2g2pWYJDqqFNlFzVOkrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3098
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
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=3&day=26&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

US-West US-East   UK     DE     TW     JP
02:00    05:00   09:00   10:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-19-09.00.log.html

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
* CIP Security 
* AOB
1. Summer Time
US summer time started on March 8. CEST starts on March 29. This IRC meeting stays to start at UTC (GMT) 09:00.

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
