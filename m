Return-Path: <SRS0=RCkn=BC=lists.cip-project.org=bounce+64572+4981+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE3C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 02:58:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EB3206F4
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 02:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tNqlAtrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EB3206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4981+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id S37IYY4521723xyOjd1U7zmR; Wed, 22 Jul 2020 19:58:40 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.99])
 by mx.groups.io with SMTP id smtpd.web12.4570.1595473117278813847
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 19:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXv69GEnR3fkBZeg6R6e6fQwBDkk0iTeFWUXJ6HN8vnkBWLh0m/KBTJaD/CSHVj+xqcfOyQovxjx9dnspunYP8O0IojHhIMg9GNB0QNdQUgRXbRhuX90Pal7Nt31AQWqNl0/28b8V7OsryMOcFU4WXvGRWOFmytWIDaVnKHwnjupqyOAKW+1AkiFRl1id9/Z4cCSMwlANomC5wBz5JX9n4X64VmO+cRHUM+vq5zWAzgAPaF67SkxGGE7zXvY6AtQDvhdD6WC/alnwnJ2LFHfx1ZOzrz5Y1khOu8pxw13d57/ijNEe3COg3cMumGh5F8JiVl8aR0gfZcjK89h15eqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybFM5U/xWEiKK7WH6ykLG+OOOxGMLUTuY47QBXMhVeU=;
 b=X18iM4b8CDBjs/C81XT6TX/+R5XlcAi7Wej43CVx/gvnRd6FUq7O1jCX0+WhYSPP9XxkIeySkfgL9Y2EraoLXvOYeiUqMbGVN423deWKqaDQHWyRxPlQeNdIj/6R5BV/D8vIR7m3O1wG2UnXnVj7UHyTwA3SLh4ZuEpdhlGhLOVT1izEJEbtTyMJo3SfssEsEp+zCTh0UhSLvwsEZjyyCrkA6khE+BKb+2fr+Glf9uowttJA7Fw42iZ4f4qv1polXnhM6ujfHuZ+X+97flDW1NPmAIBVS28wYws0jKZK3svFyQrlmOn8kU3D3X4stsBLb3sHAnZ1a77uV282JFgtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5392.jpnprd01.prod.outlook.com (2603:1096:404:8028::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 23 Jul
 2020 02:58:31 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3216.022; Thu, 23 Jul 2020
 02:58:31 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZgnINE0GQldgftRamowlp9iRaMFw==
Date: Thu, 23 Jul 2020 02:58:30 +0000
Message-ID: 
 <TY2PR01MB49725D13A78694E61A9E03B7A0760@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea2b4a07-14e0-42af-ae3b-08d82eb4480b
x-ms-traffictypediagnostic: TYBPR01MB5392:
x-microsoft-antispam-prvs: 
 <TYBPR01MB539217AFFF2D970003653382A0760@TYBPR01MB5392.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 etJCrGXMx3XBeVvgLP63lOvaqkdcUIlg5UiwsgOT5QKuZQAOInPRBuUzJ7IHiX8F5k6HoAkSijHWT4XZsV8nZfCDGhEBV3TCv5XlQeEb8Z4epoSpZFYe/8qxiDxCYBhLnT9oeibIfyWu2vsj+QT2mKEpsgke87TUQwAlGaZE9G15YmZeLqAeJ+kBwUyT7C8PHHQEAKO1G+hcHGK8r04tdsjF5rwEQFHdz9ZrCV2G6Wz/SrCQt/aS5fFU5fAKk4jTA5ECYER/a+gaUgd3jBT1XgZJnrzkYvlkPN77hMcvdtRiseEHk7txC0iuPHW5x/LtOa6RbXv2t365H8mHrGiU3wUajxZdJGHAs/KEAP5ssrJ+FjCb/AXAHVyNRpfZoy4zevYfQaapNvKldIT6f5EdDw==
x-ms-exchange-antispam-messagedata: 
 sazsHX5YI8dxkpY+7PZ6I8CfNVyYQa2WS72KgpEp1P0lkjGqHq/HtJ7J98swLNtPcNMGoHCgd3xotlZexkiq0fQx23EdfX3/MN6ZWqbJGbGwf14Tk7vL4isOaZgXbEh5bPxlXSKTEquacL4UMmVOsbDXmWi3GDOQ0LtspQfIpePeF0cyIwxYcrn2xYKi8SRcxPFNREg6/nl/eErCMvX22+qyfMy+jdIjnwW2z+hUNy2YkW/bazYq7BzHy0DoTpXZEnnw7Jrt2fFtKEcKCTOAhFBx4OLFj7832VGq91QTc8ukEa59MK0+XHvOcn0ckKtRt9GeCnSXElXdoIqznFzC3kdL2BwSpU1k+gsUI3KRljV6nXIoucsLWgR2rUI168ZhAdzH1ZxAYBAo9XfNMo5SHEzd0ggrHFmTTUu48Tej/bgs1opLJtU2rmXZ0A29CUzVH9MA1PMH34VsSRpBfvnjaL7erv1Tt1cV20BicQIl41MJ/e2Bdn814X4ftwcJBiXB
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b4a07-14e0-42af-ae3b-08d82eb4480b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 02:58:30.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgwrW6KTqBgcRCrNPtwxbUwyvV0t2LFDwx7NM2IvNfoPmY+75zGhc5HMf6WL9A80anHvybCmWVSH++avmHACA8uzNDfeDqDZ91YMZ2zCNgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5392
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gvIu1WNiqT4g2vW7isSt2C0wx4520388AA=
Content-Type: multipart/mixed; boundary="0o8PL3reODBKHk3GHhMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595473120;
 bh=bL/0IbcpCKeWStM1/fACeGYuh7BvdsYWKjkjhKO+j14=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tNqlAtrnqQQoj5FArtxYUxkpWF4FeAKlDaA1nyo4qAOQfb3dnrfwbQsgmVK/ItCl5xo
 d8sCbIBMEzGbai2h9yYyB+uYjdnRU/CTyboRErVnSK6klf1aiQYhy0ilxMVSK2H6LzsU5
 T2L5kvuSHCfS0zvVtVaKIJBxMH6xqNk9M+w=

--0o8PL3reODBKHk3GHhMK
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.
I cannot attend the meeting today. Chris-san will host the meeting instead.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D23&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-16-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

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

--0o8PL3reODBKHk3GHhMK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4981): https://lists.cip-project.org/g/cip-dev/message=
/4981
Mute This Topic: https://lists.cip-project.org/mt/75739176/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0o8PL3reODBKHk3GHhMK--
