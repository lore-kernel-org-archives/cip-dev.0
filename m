Return-Path: <SRS0=9e7g=6H=lists.cip-project.org=bounce+64572+4596+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE6C55185
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 00:06:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57372075A
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bN6gutuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57372075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4596+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bJA7YY4521723xm9U5XwYOqr; Wed, 22 Apr 2020 17:06:51 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.91])
 by mx.groups.io with SMTP id smtpd.web11.5961.1587600408653178263
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2020 17:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgLkHOXHt2G1DiVIh5bwRJ3scBzZbMwxtyFs+PjH3eWoEAxhcUfkMxw7UU5q0Vm5f0RN6Xw1DIa6ZKsUu+GXlWxO7aWsA3nx+//y459H4qkZep/9D5CSCEv2DSvPP4Y4B540TVeYA8/sNeu/oinaKY666zCEnLl6z3rwHupxjlrm3XY5kaWfFLTA43FDvtzazaVrr/rFs3aLT/diIqX5uoe1LC3wL7xPTCE3XDss+L+gs2MJU65b1p2u/9lnMZiDcy6vcBh8N6wH3p7O5LiFg6QnUAU/VNoSTf0Q3MfBECmh3sA7KdJio0+lKtI9ZK5++XUbupeKXoMSdsHB9QrdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0kEeHi5rVKKH5aP2tMvX91bEZhLmK7iaSoRxRkHZg=;
 b=UHF00n7UtkTlgJnYBNQfMCqvBMA25QSLQnszgMiF0q3eLLdSPwR069uL8rkDLVJtx0u7aFOIqRGpQ9n1aX4tdOw56rCv/ooWUrr2C8MqxwxOnw4K4GojNDJwHMc9h91zbzKkXLSBVOHoAalS6sl4f7MlX9b2YUGkrL9tsX9nQZGE98/c6prAdShomBH+vzxms2Y/FfFm/mC3JR+aDxqjAR584/yeD12Ng0/aXCfib0ID+DjgMMCI7voNgt1xb7+OoBL9aAzuoKy0wDpSsvi8Sp3zozV9SUd1rtbDhufA/8Ucr9iBQOgDOWnls9zhoiwHT88uFDeNMysdHJAnZgEXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3322.jpnprd01.prod.outlook.com (20.178.143.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Thu, 23 Apr 2020 00:06:41 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 00:06:41 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYZAw/dNE7M/n10RWOLa0W5ttoGLA==
Date: Thu, 23 Apr 2020 00:06:41 +0000
Message-ID: 
 <TY2PR01MB4972C9832D1CE44EC15964F8A0D30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f92c07a-e5b6-477a-7fb9-08d7e71a337a
x-ms-traffictypediagnostic: TY2PR01MB3322:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3322784392E6F8ACC0AC36CDA0D30@TY2PR01MB3322.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 jSfi1Z26koAq0iWx9j9gNJ2auSzuw+VxCmTM5YUtl4TgdB8LNT//d+s9AvhC5294eAVrNEu7nwCxNt1688/4wiC8lqulA2laHYDB5VHagn0CXIjelfOAMJ9X0Ml2fsZNsO3HGsLYe2X7rlP5hlBgiMn7EbhuW7ClhrZYiv6dql5Ob5RzScp0Hm5MQpTLUCOqZJcucA3omhoG88pSemH2PenAekLYhAg9JeM4iDdw9WDYmfZSzDRdFyhd4Fx2M62l4yDjnWjFReMMZj7CmCvFrCgEDvxcNIl/IyWkDGDSGbuIOzwNaMres+rf+Xr672Ui3d1BzHJ3ZGXqzoMqMifZyErznLHyWevnbA4lpy4iumwkuGZGuIps32o/ufglCRwZD5GrhKouJQTUP+Y2c4VTkxMJYfpxzJ8vMaloNKEpA/KpGGH3LtdN7qplmNtjC1DE19eB9DuDybotnA0tfTi1NifHKUnFE/MUKBGiPTHk4LJtqxfxW37DFl9pzqMm+ky7rhXlVztaGwCqs5swOYD0tA==
x-ms-exchange-antispam-messagedata: 
 ZFkLAn85q80i99gAktv4bL579ZzQJk8vLnK4tGGIkyW1aE5i/rY+PTnBGDrhu8Lqlj+9aRy6pyPHIyqdrrWpA76VLRjUSglMWDtAmtdxPKzv0Zn7Yvv7s14yBlvAoPRJHIbHj+MR4bgBlruuCEK0Pg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f92c07a-e5b6-477a-7fb9-08d7e71a337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 00:06:41.3967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHcMUvgM9l4x09CisjDf7aWJsqKwv65mzhs/dG1Azp8+2AHE3CRzeAVgZxiwBEbclWA4JJmQiYhqZR2NRnL9hhUNq6602ITcx3vl/kKifVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3322
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MxY6XENeTX7rgXFCzSRwzcQTx4520388AA=
Content-Type: multipart/mixed; boundary="5Ccja0KU4JWMaUveOphK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587600411;
 bh=HRF2zWCygmzhLLk1wjgN3lk9j8kdaanyLaM03PrELLE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bN6gutuh1fwXRKR+PaUuBCYKY8bLORYeFAh5VYFVEYrsDT4LZyk//M1aBzdZ6YNJhn/
 pQJj+bZJZxpjP3U3CMVyLjUodEBvsTAN4GH0x23vBf1S1fzKxquTG1Bh1wxpjzDIbdcgy
 UAjHeMJwkUfzkub2E0HepKse4WTGPSJ7gjA=

--5Ccja0KU4JWMaUveOphK
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D23&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-16-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
 2-1. Workflow for identifying important fixes, backporting, and reviewing =
them
 2-2. Prepare the tools to be used for this workflow
 2-3. Get practice in backporting patches
3. Upload a guideline for reference hardware platform addition - masashi910
4. Identify target boards and configs for RT kernel testing (4.4rt and 4.19=
rt) - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--5Ccja0KU4JWMaUveOphK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4596): https://lists.cip-project.org/g/cip-dev/message=
/4596
Mute This Topic: https://lists.cip-project.org/mt/73209616/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5Ccja0KU4JWMaUveOphK--
