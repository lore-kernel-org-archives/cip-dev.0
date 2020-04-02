Return-Path: <SRS0=EZCl=5S=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE0C43331
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:44:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D76F20721
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="LIr8O7of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D76F20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3061486473;
	Thu,  2 Apr 2020 00:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T98B0YkkRX-u; Thu,  2 Apr 2020 00:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9BEF0863D9;
	Thu,  2 Apr 2020 00:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9117EC089F;
	Thu,  2 Apr 2020 00:44:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E54A9C089F
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 00:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D507086443
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 00:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EoFZMpUWwzrO for <cip-dev@lists.cip-project.org>;
 Thu,  2 Apr 2020 00:44:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320094.outbound.protection.outlook.com [40.107.132.94])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0B7A863D9
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 00:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMQF/iOuLhgjYYzRaOHBFItpMIHqK/cz09aQ7WZB4l1qEtWWKPqV2F+Xf/mPz2jX3jgNjKBm/aQaNCwKAhJl2Yw16VWBtW4OwZeRFpS7+Eq/Fn95LXvZ6i4ZLb3tPMyZuSW+AB6735HAEwSD+fZkIG8aJAg5RQh6NuCZVLXKs3+aKTqKrszLT531H6eue0Z70r+NTb/oyNFc0VEabdcXdZXRw2igoY66bwzlx11SOxyPJWf3hw0bIQoCXJFUZIi/DSqooYXp91q6E9Px84srJ3aZAut3yz+4495y3LwXVrTmWQ2D1qyU2VxIRgYQp2CbcY6vkz4RbjwxLxK4xjX3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0hzMP8DjinuehHqMUjQ4/xG1TvgwmiPEsNO2RqGkHU=;
 b=eRQ061P09fkcrsyCzd7+b0F/XQe2y5tSNv19mkbHjGTqxUGRRGO06sB5X2ZpTLL5YSbo7rDKu0WRaNv5Myui0s22xbnnNw0WFI1UyIVOqoHXytr2KCduggmvPdvyAMUnVKeTaRGdv2aHjFQE7uR5PHRKaLHxuWLL0JC1uVVjy2N0lQsRTqgARO6nOrtYS3P7Rez8h1fpyWgp3qEdWeji4XYsEH6q4VIP6ON7zi0DUP3lhNYLi2wcRUURJAFqJ9VDfUuj2WUbTpAe3A+ahnxvJuygXOwK+I3XUa6a1JK2ijIbFcvUdJ7+SxAEoWfLqM3VOnBvNgHYWlTDM7JX3qH0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0hzMP8DjinuehHqMUjQ4/xG1TvgwmiPEsNO2RqGkHU=;
 b=LIr8O7ofBA+t3wU0k7xAzBnvjvmS2FFnXjqJciLi/G7NEzvuWnSCrwqfGubiZzgkArb9EyPEs6qux0kQKQRLrsEfiO+DkZSw4FxB/NLODctGwtY4Tf9T5WHBp7k4SQ2Glrb6W3hivIEYlw1ZhKqiDAxcf5JWfXe7cvJf1P07n2M=
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3049.jpnprd01.prod.outlook.com (20.177.98.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 00:30:06 +0000
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 00:30:06 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYIhZVqicFEP+tqR9SIqW8yobQpWw==
Date: Thu, 2 Apr 2020 00:30:06 +0000
Message-ID: <TY2PR01MB49720341AA7BCA1D28EF8480A0C60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46f6574d-43c3-4456-d39e-08d7d69cfe40
x-ms-traffictypediagnostic: TY2PR01MB3049:
x-microsoft-antispam-prvs: <TY2PR01MB3049B76417DEB88782A1185FA0C60@TY2PR01MB3049.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4972.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(86362001)(66946007)(64756008)(8676002)(7696005)(66446008)(2906002)(316002)(478600001)(66476007)(966005)(8936002)(81166006)(81156014)(186003)(9686003)(6506007)(33656002)(76116006)(66556008)(52536014)(5660300002)(26005)(6916009)(71200400001)(55016002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4UMih86TNwEb8YEBfmM/FdW7NSJS/awn4XatI6AUfp76h72EzQrmPlFMtifRBIkwLVzNJSH0TmAd1K/athjt+lgJwhggrgmg+UDWCp8TpxHWKKRw+aG5OB/mHxctRAKxKDGA6gAKH3o04JhDgzWnw/sO+VTczx/G403ueBD6DfoAgzBiEOg0mtFPzTRreHREzMtlSvdMxglu2pUVyU30HF1wUppQYDJ5kiTy31jKVMvjj2E3eRmP+8bQn098Vn2fFd1gfzUer9cC7BIUpBemISB2OkrDSqOP7ZxbOfecMuY/HbEPn33tI7s4jgOHUDkvV9gzwX4wjNHE6TiresKNfhTUpVIszZGmYhhUAYsACk5Myj+caH7wx4dUKuTWWIfS6BjLjBMlECBWc8SxNmW4nWTE2OLGSYiN6Q7Wr+Pf/HaterpwJad/SNagKYJMS9Yvap5rW7mhJ9nMgp5wDqNkeTNa1jpgfDF4WrZy/rEm8JCao3/IcNe5W6UwjOX0PHrcbe56q4KViOJQ1mNMc0hjw==
x-ms-exchange-antispam-messagedata: Q0XfmSAGT+kaljjv9wDyZITPuo8gFBO2BYP1HQ/KqagwG2bujIY9WjwYJug8h71j3muckYkFCbtlpLqQ/wB3BeHrEe+xdt8bmqrzC7xmmYqb0qwr3cyivAIQPE/xP5Piq0WqSld8hEmk/RJsZCEuCw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f6574d-43c3-4456-d39e-08d7d69cfe40
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 00:30:06.3998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kX3yjE76G2HWacWcjBuDMaWfQgCw3z0A57cthMsaBzAO2OOXCeb/EQyC5VJ0S1yhWhSgiVCORgaXGEghZ0TNclpGTnQtiWc+kfKBn+b4V9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3049
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
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020&month=4&day=2&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-26-09.00.log.html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 
2. Strengthen sustainable process to backport patches from Mainline/LTS - Kernel Team
 2-1. Workflow for identifying important fixes, backporting, and reviewing them
 2-2. Prepare the tools to be used for this workflow
 2-3. Get practice in backporting patches
3. Upload a guideline for reference hardware platform addition - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security 
* AOB

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
