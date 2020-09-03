Return-Path: <SRS0=xpiu=CM=lists.cip-project.org=bounce+64572+5386+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB4C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 00:09:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6669420786
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 00:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="keoWF+vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6669420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5386+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FJ1hYY4521723xHChrgvQDRo; Wed, 02 Sep 2020 17:09:21 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.108])
 by mx.groups.io with SMTP id smtpd.web12.3017.1599091758815786870
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 17:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BySoZq1bNvDKCbld5oUrFaqLiNQnCF7O7vq91K34XXfNLtt2biOxrUJ8V9cAZOhaUvF8OCRjOojvr37jtesHBO/QTu+KDy5Cjl0x9pDJe/Esb89HuT5uLuW6bZLO1af5eWZpleP71kdOwBVhbAA+mgWfhOzQcZIl7oDNS5jfMGichfIcmqiDuSgVcYf3F97JoqQt1gBYGrNI+dQitrQKfy5Bg9ZfEwgcqQ9P/yCLyA3uq3wEeLsmivKStimwl1Bmp3p4U7S3ipxH5+I/MplRAi7qC9A7C9nXajfeQjWv1zXjMJAoUgSAP6DTms9luqcnSZI0TMGHpbfhNzEg39K1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P7hbeDq86XgGMLzAUEgnBjrvqaV+ac2NuGt0MPYxUI=;
 b=GMM9GuOSQ7yZFdKdbTh5fsVqXzel9Fy7sUdIGzkg8hYyZHq5qni233qxz0I/0cxBgKRyLahzZ72zHQM8bkn/3pCf/ulRhZSWH0rVQtcayzy+38M5jffqMPZ4huzWecHr7PhY0UXLTBAn/GhzrJd+LBselWT8tz7VbSOPAORlxVAp/G5reb7bmYAn+LNl7H+JhYCP3EAo+euJThXcAKwEOIiXylEVqpiW3mzQq/o5USpiWGMRbINcrE5/pQwAmAb79CAfNa7sDFizmpiQeMncDTQeAVCT2mfyWBGIIXR2Bs929Ygeya525DMOmg/a8MAO2+xcVVKd2s6OZTdkFM7npA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2700.jpnprd01.prod.outlook.com (2603:1096:404:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 00:09:08 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 00:09:08 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaBhmOQSEs7KVZQSTSdOQV/a+jzCQ==
Date: Thu, 3 Sep 2020 00:09:08 +0000
Message-ID: 
 <TY2PR01MB4972D2CBAA5812171EE53591A02C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ae608a5-b73a-4a1f-83e1-08d84f9d9441
x-ms-traffictypediagnostic: TY2PR01MB2700:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2700B0B6F36E9440E7366CEFA02C0@TY2PR01MB2700.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 J+K5bFTxdStSLJRxcd+4Y7smwtULM9eokebQ2y8SJLIyKRe5V4HpUYKcxIVyvz96YIU5Ef+TBGIc47x0pYwcSFbU62xOVGtniD46GCtXAKgpgFbF7CODsRQf/QitztEBEq+skSEDl/J7e8f0h/niGK45N9jKCnqFv6gLIo+nOM5CmdEYmuPdOmMJZCwe3FK4s//HzM3v0xI6ksl4pk0z2dqh/1qcrnC8SwTKFIR+wyWswHlmsHjqfpFYaukxkdhq24mz23FTgKvKtuNja8Oe7onOehAbZImKvaseT1ImIpjItFOI5ShSphScTv38M5EH0jfh0vOJ7uSB6OMMHRIckZbVUrWLWp9tSJ0sDcr3gEQT4y/MpZ8uS9POsHbq0VclK30LJ/hhtv40RhlVZ/Tpbw==
x-ms-exchange-antispam-messagedata: 
 WMTYJnENDjMVQV+G9KEYC8xOdT5/IabvIgPjfk03/94Xktf8jRpClZKgqNr7BbJ2VFdKiA5dvVulEucckFYa9w6Trqc2Djo7HukMh3QHTvKIiAJ9SEXKRaMBEOimLcftbahkKbeNbZU2l7Nt+2PFdC5I0wmk6HFUFe3BYCrymmHOzCUy/4oG4ihUnPHl7B5obSwJPSI24hSS5hwKA+x3gTyfP0IyiWSioUAytGrB8YdnzYESi+AfLqXwpVjkZH8I5gaCFRwZRdkwG74YTXj1bAhkmKtILAHDu3k8gJPeUxnPoMsIesq0ANa9f88DF+vLzBKVQk2kMp0xJLMdcbqcLw1uUZjcqMfnudyg8p/Uxz0NP1IzhfHvk53DHFJ/XlMQNpBgy2FELvALaUoPudZb6WKtuBd2th+4C6r2XQCOKFS/uKztBF7NecPyj+ZM5QjjWeCp1d5KwrKufUfjkt+/Gasb9WFw6q3tQjHT4a7/nO6MX6pI2QGd77VywxEMX8VbfH7Rjkosa9eE5jR7jlpoG7uTrIV+Z1gsN1WiEWnXntIZclJvZvoBbL9QexH3SOqF/Y6rxt3EdIdIm5kZvlwHQcZqh0a7EUyNQia0M6wR7LN/0DDD90qjskY54cFFTWvEy793kPm0YOjmyEguuNiRWw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae608a5-b73a-4a1f-83e1-08d84f9d9441
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 00:09:08.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3Jnk02OjVohvpFrFOpqgamGWR3qDXXVL/zymHzMW/TwnIiE0sn7gon5d541DxuDZDQzgOHWwftkhPVgPAsbHl63FqUvRzBDWRW8Z1ax0GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2700
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6Nz0zEpCoE1NjlCO9C93ICtAx4520388AA=
Content-Type: multipart/mixed; boundary="7utgEdJm6fj0R4kwkdpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599091761;
 bh=JWjfjLvUQlesg/WVo2hls4ryNDuH9lXKtgI1Uc4J1N4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=keoWF+vrYvgYYwuBgxT5plva0y9wrO1BZpfJrN1cxSFH8zv8ZWoK6Jrertj+sAHR1j+
 /NkTmH0FACHdtMfk1O7ZpKsU5W/StgYZCHCAs9h9c0Y/moVKvsz1dFemlxw/HigIbWtPE
 ogu4GgtYhNp8p172s8n89YWWplB9yrFSvEI=

--7utgEdJm6fj0R4kwkdpC
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D9&day=3D3&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/08/cip.2020-08-27-09.00.log.=
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


--7utgEdJm6fj0R4kwkdpC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5386): https://lists.cip-project.org/g/cip-dev/message=
/5386
Mute This Topic: https://lists.cip-project.org/mt/76596395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7utgEdJm6fj0R4kwkdpC--
