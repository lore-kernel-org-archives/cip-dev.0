Return-Path: <SRS0=X6lk=6U=lists.cip-project.org=bounce+64572+4616+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D456BC54E49
	for <cip-dev@archiver.kernel.org>; Wed,  6 May 2020 22:28:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3994120708
	for <cip-dev@archiver.kernel.org>; Wed,  6 May 2020 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WjMFXa3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3994120708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4616+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1c8NYY4521723xUEkUdVARew; Wed, 06 May 2020 15:28:39 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.117])
 by mx.groups.io with SMTP id smtpd.web11.547.1588804117290416296
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 May 2020 15:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNouboOWilZiwEeHc/tqkSyDWC6839Cx10jYul0j+huCRV4KdD/QdK9QxpSvUMPc9P4OcJPcWvxVHIwnk+IeZo+mc5SZ6BtPkTxbDUnCqcaAdlM+YNmgH5jMwRTERqozsYdu/CvOzOsbEN/SDiIdSLHkCTVwcG3A0587m4rF2ziIaudRdYucOkVSB86Zye6vVV50kLYwfprhp7iT98IjGooycOgj1523j1xicQyMjsZLmD1d6Twddyqftps2nW4PiLTGm6Xscnna+qHAOSmyX7q0JVJN3ADjfdYOAiuca5gvQAzv1Xeea9JyPIaMGF0Ygp4k5dD5p5rdvue4D2fUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKFuoDV1q0iFgN+3l89VYV6x0T6UAQZonTUygeXxBvI=;
 b=QZUdksH7kybxe7TC8SDuJoTI7LLWOOMVz7Hc6y7mHezQNu5mMg+dMCtS6i0LRn9qjZTSxSzgSsQsw+GKX5rxny485KxIEsTlmKNsaknalIHnvrvMDAT3IM3P/ne6VPhom8jbnWkOnZd7PsYyA1pMUY2O1XVBWaGWz3zcRpL7C8A9BbNaPIJyI3X7UmLZLcIoWeR+6f0XrtMtmie10PNuR3mzJ7NYQ/WKryb9zgu3BCDI4eP2yN2+f9fdQr69ZXDMg3ASQUSrDq6Tl/VkMARoLJ1yB1d0XxtdPkDso6oLSGs7lycC+Qtp+wNZ3xQPXH508dVOKVJD9SJtY5ODvKubPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2SPR01MB0021.jpnprd01.prod.outlook.com (20.177.100.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Wed, 6 May 2020 22:28:29 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2979.030; Wed, 6 May 2020
 22:28:29 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYj9aokIGLZHY+rSO6enJJtVgYlKQ==
Date: Wed, 6 May 2020 22:28:29 +0000
Message-ID: 
 <TY2PR01MB49724FE267F5A196A94F2A3CA0A40@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f0c5b6b-f0ed-456f-f41e-08d7f20ccd59
x-ms-traffictypediagnostic: TY2SPR01MB0021:
x-microsoft-antispam-prvs: 
 <TY2SPR01MB00216B06878C77F9EA0612B9A0A40@TY2SPR01MB0021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8kiBArZtJdQMtxHfscEMO9LiSd7Nk3lnuA8meMUYq62NjF573c2ipwOtYmCHvcONaOMxE1jvAm2SkTOtardJmYb4bmXwnAyWoXJa6EnavSMBnifRWSQeCDRKKL3muX4pWa9z7/6DTRcaZSiKKVhrAxtOAzo2Hc8kjyedf4btPgWAr1wwOS4+Kr8O4nIkRnf6Evcgo0ThUIHvw+AiNmzhXafXI/89mZ9DidiX3ocC68EryMHsXYY4FiaNUI6heaVri4tCfKhQQyB7CEWbpjZ31cnIe+m7sA6KlyXK/2T0LUq9DssAyeXRMSw7LqtOXB0RZbzYZQTLTwz3bw9PS6+WjjkbpL2P8LlGYy7lU3fszvklUyfcQJcQ2VfygSbkbC8g0TthKxItDzEgbdf7cFnsJZ3TZ74HFVDJt5S4XJhvFUD6f8ISr2vKrqMzCmALJX7CcX55Hvqicv82t/WBB7tU9tEj14FEW+S9FlLMh9zG+Iubf0FgpcpToCy9Nfc1pmKRgIfxj16m9E9bDKf+oetOK+/Frd5R/l9dwK4LNVY9G+nhfnDHcskdlT66pdE0RfBeH7QI8Ai6PqvjiqNqtjI97uUzgvlK8DAG2B4bmDM40EU=
x-ms-exchange-antispam-messagedata: 
 ErZMFEUvJm2LZ08yiyAmpnv4RwkKwgsPOzHhrPCUUCfgSUZS66jKsRN2sw/P5UHnXeFszNp4arnywBPQrkKAYw5g77uLwHLrVvPROTmL9br+3JpZKcth2plK5QWBpE8KYr5ogRSw7tEESa8AU7bk3zFvl9Px9FfjVHLS0UZ3OXH1G8fXNb5ey1jlzUZo0ulc/YykpcoOp0F23I2pDIwignyxEWJf7GbgCDzHW4tXPMS9KsrtCkHXZUu1Fm5pJytiguyraHPEBjY0WQk5tdSlAJhCJB4ntMlT3yNffy5bLXum5V/JIOI+2UOnM9ECxDamQtn76ZxaC6QRathxyi8v91/kF0D77o6CCGLL354TajtJ0VuqJ3i99tcYo74EuJMqbJCOc42wtHDry+EdDykTKuW0PbYuQ+ulT66AbLc9aCpiNkIv5ENleimQ47g/Izc/k970uWnmK2d+N9eCGX0EOlomSJnACnvFPkVU1IOPl0HrrqSyvud1X2tnBxZVKo6e5ujQeP+RQnv4fEW25BU27icNSSYXSTEH2q0JUdEFieAb4yIs98JEJROVnJ8F/Ga9TukEJcey/P0yUt3F9R6VePaFOot+w9G6MhrJDdpLs/ExYsGJHVXfY8n2HkafXQWetAQQvJUm7Q9TGAiFZg3HPdOANU7gQRr8FF/4KBBit8dhm2Qi8sJLeOXHxZIIu8QK8JJx+MQlyG/DWA8vfTrd3FrbhgTfS8M1tzgrYghzByjqGKpBzK/fgwWcn4xlb2b6DBWYOVci2YbXHGMYE4YYrUkegSiKo5qrjL377oVolQM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c5b6b-f0ed-456f-f41e-08d7f20ccd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 22:28:29.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFV7TmpIwD3hrMHFDQBnWPBpxOT4HzCes5xIvPfZwB48N/qO9GcskpY7XW/iO1QfxW4DHxwKFZkzLI2MS/89Nv/RxGRfm46JXRlQZw8GZx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2SPR01MB0021
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0ga9TSW5evtwa7q3kdSkQlcVx4520388AA=
Content-Type: multipart/mixed; boundary="TyCGtUcAnXXXD01d9F07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588804119;
 bh=WTYz9xDy32h5go5yv9caYZN27fGE5c6Cd32kSNIFi5M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WjMFXa3eOytDCUctbPRbK2AQ9GvifFlOP2zdXYIODEdmtAeNsc2TTqdcu0lzqlznTvJ
 RXFr16p3Dr54zNDqDmhJFW9OCRNROFJ1NKxQpYRw3XLuaiuF07RGrBr3Rb57FC4PvVA8W
 mvzTU4ZAjjscupkP5p+y9wc6I2T5MVFSp8Y=

--TyCGtUcAnXXXD01d9F07
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D5&day=3D7&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-30-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san=20
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
3. Upload a guideline for reference hardware platform addition - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security=20
* AOB
1. Some topics from TSC call

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--TyCGtUcAnXXXD01d9F07
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4616): https://lists.cip-project.org/g/cip-dev/message=
/4616
Mute This Topic: https://lists.cip-project.org/mt/74039675/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TyCGtUcAnXXXD01d9F07--
