Return-Path: <SRS0=n/sC=GR=lists.cip-project.org=bounce+64572+6083+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90406C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 00:21:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D1C23120
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 00:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D1C23120
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6083+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tK9EYY4521723xl2jxrC474e; Wed, 13 Jan 2021 16:21:13 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.118])
 by mx.groups.io with SMTP id smtpd.web08.977.1610583671290229336
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 16:21:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC7sPoglre/OdlBaLhub5F34xS7XNEXsBGY/URdLSdeR6mKmdQ7ODi8lnCD13XJLwhvCJ5vsKuJqaZr5HRzHYANkEcbajg4BJ7yy+lJhXE8iIl9hXBsdKwYvAjV6FkgQz/FlWIvoqFYDYnr8WY6B0nzGCGQknQG9qvip1F2eFk+NX3hJfJ191YLXUKVxhYnvPY6H8m5ePltqgNj8reCjeRQsfiBbCc7vUgONytcDS6Fs2xcdKGZ8dQouuRgNrKQl3WW0fAjTwVQ4uXkAqenHD9O0FACzHQfI4KXH82UafHTjmMqdBKs3EzsPCHZwb9uS5brfd4XQ8fG9kqqN/lB0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZcIuE/pYhAtTqOq9psMNtZps/ns0rGTayBRLLMQ30I=;
 b=K8/W0fK9v1sMxODei2wTFXCklFy4Aqm22wRPg2XvDrB4GGwhs+aK12AASvU0GCsLrPGh3kYUJ+MWsVlvVbyOpdudCd5q0GNTUML13v5Ahndlh9TPuNqow+klyaTVuMmdbfIZef5nxwsMPsgqtAAv9X6WhbHZy2XLjjiwQjtgoOSexGYal6b+AWuCbVsadh6xwmcvF36M0KjKI4dzgTLaRiPcKUs9vftCx6LGOyMn/bkGDfmD43//o7Ipyy7uySLX5wfCB9LVLRXE3cWf91q1tq/DwZi/fwb+5OI3fkBTxehsqUEjbsnXOq3Y5YlakaTXe4/zXn9TVdnsFil8vl9FbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5772.jpnprd01.prod.outlook.com (2603:1096:404:805a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 00:21:01 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f%4]) with mapi id 15.20.3763.010; Thu, 14 Jan 2021
 00:21:01 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbqCwtct50fv3utSKqH+b4iQ+7vuw==
Date: Thu, 14 Jan 2021 00:21:01 +0000
Message-ID: 
 <TY2PR01MB497230534375FC175CAED629A0A80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8b982f-cf22-477e-43e8-08d8b822461c
x-ms-traffictypediagnostic: TYAPR01MB5772:
x-microsoft-antispam-prvs: 
 <TYAPR01MB57725D5624171AF415389014A0A80@TYAPR01MB5772.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 RmRCqccE+K0sPnl5RQgbNc8k+UE2Twcs5/sQ9QN+RQcFHF4ufxhzhR53Ws42Hux+X65Oe8ECnlcVhnqrpKzRlUynUfn4ahb8EHPuxfglFNWl65ibNR6+yyaSY+YSKe6P9ZiESuxaR8X+YOPocwstX3c1gL5noN03Q4XOlGnA+7FqqlS0XQmvTyv+sDJtxBbDJXuaDiMsY/aCLI9vqhI8jm27Cax5AhgKMTWVbn9SUF0peC3GAEZUCSRE+kttobOrDky9gw1Lyu2YULlfFyxp3Bk2bWH7j8jptDiJp/a6nlnousBSVAk3J0R5Jofcv/j9FClMLULR/kwYFfYe9NgAeDPX9Xt/7NyRTecH+ewmRjx3ImdKdb2P7QBv8Ljj/Qvf9GZ18Bs7LaJcY4g5vjq+p6VNiCQHsLK1bs5EAnCGAWxl+Zv+jSsxfCo1//uxLR+NLiOK42Ulz225r3fZtExJcg==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?Uys4Wml0NUtzVzcrVFNVdlVCeWdkY1RLci9jeTdKeklwZVVFdXJNK2kv?=
 =?iso-2022-jp?B?eVJTWkxMMmMvdlRNRHFoancwM1oxNWVrbUpSK3RUMk5FYnJoYnRCT25J?=
 =?iso-2022-jp?B?M2xTYzFyTXdyQ0JrTCtjUk9hZ3QyYmpydk01anVLNXhGZ0Yza2ZhZXBk?=
 =?iso-2022-jp?B?Yy9kSHlNTHpkQWdiM0ppZVgzOXE2eDgvNjU3a3kwYUlEd2l3SkNDQ0s3?=
 =?iso-2022-jp?B?VWdyaWszVjg3VWI0MXV2NHdmODdna3N5dEY0N3M5VGNMa1JodE9JcTFX?=
 =?iso-2022-jp?B?ZVc5bFg3aWlnMlRHTTFHSm9kUlg0cTR4cGNEWGcxa1h3R2hKaEtFekQ3?=
 =?iso-2022-jp?B?OEZ5MVplUFIzV3BGOTRZclpIcjJzRmpsN0dHbTAvNVV1RHJhNDRIMnBC?=
 =?iso-2022-jp?B?YlU2QW5ldWdGRHV3R3JLakNybVZBUEsvMytmZlpkZWJwKzVSNnoyakZw?=
 =?iso-2022-jp?B?M0VOSjI4WGpFUFpoM0lWSmZwN0h1dUNNZkZKMWhaanJhOHdZRE4zVG9Y?=
 =?iso-2022-jp?B?SUVZNVN2RWZNYVcyLytCZ0hPS2tXbE4xOHFuRjBPWVlEalZDUzkxVWhv?=
 =?iso-2022-jp?B?OWlFbUZvM2lhOGE1dDdkemxvdzIwdm5KZzB4dW9DQkRXZlRrUGxObHFG?=
 =?iso-2022-jp?B?WVRoNVZXZmVMS0lvZlhXajdaa01iZ2lPTS9ORWp6eFZselN6MUJoSjRZ?=
 =?iso-2022-jp?B?RkVidGRtZmVUcWpmSVZWeGxMTktaUS94RTh5V1dmOFd3VVc0V3doNzIr?=
 =?iso-2022-jp?B?aTVOaWxGVVd1VjlnN1ZvVDhmbFlUWjNNak5VRmYvMmhzRDlxWndROXJ3?=
 =?iso-2022-jp?B?dFpncmVGRE1NbFh3bEM3RVdLVTk3YWRDMElxVlVLcGRtRVM3NVBWMVZ4?=
 =?iso-2022-jp?B?N01tUkFobzNwb1R3YmNqMWIyeWRTVm1DSGtnc2ZPVWVlQlBSamprQzZG?=
 =?iso-2022-jp?B?aUdGbmVsbjBlbU5xelNNN0NuREo0WDFFTzJseElPUEVPUGRsblVIRnJy?=
 =?iso-2022-jp?B?akdweG1XaXhoR3h3RlliVklTcUpEaUc5OE1oZU9LS3Q4UmJhQWFScW5J?=
 =?iso-2022-jp?B?a200K25Xa3VtUUtsZmd2K0tLOTVWQTlkZ2lEdmUyNEY5WStkdnlQY2tN?=
 =?iso-2022-jp?B?LzlNbUtBeWNFWlRjaHZPSEM2Mm0vZjBaQTB1KzFad2Z0M3F3MHB0TGsw?=
 =?iso-2022-jp?B?bGF3bzRHQzlvNHRYZjh3UEphUllPVXk2c1h4dEdIMjJOUEVQK0lVZ3Bm?=
 =?iso-2022-jp?B?T0lya1R1LytQOGlWSStwbkRVTmpUWFd4UnFicm5uanpPU0dpSXo3MkFV?=
 =?iso-2022-jp?B?Z0dvZWI0YWZaMGRyS293cE5YTkJTaENtNmtDTlVqZUo1K0EzWFZ5RFNY?=
 =?iso-2022-jp?B?c2w2Mi9hdDBBbUdCRDRJUjBBd1hvdFRKTG1DaW5ma2Nxbk50cz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b982f-cf22-477e-43e8-08d8b822461c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 00:21:01.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXyyyNWSCxXCjMiWCh9JgJX/K8bVrOfUbhkBVskIdIGncKwx3xNI3Qi7gN3Ajt7I5njY+zmPOHoqp5wTqCkMP37LqJD3iM529FVDpzC0EFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5772
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wcxP8H91bjIGM6no2DuMK4gcx4520388AA=
Content-Type: multipart/mixed; boundary="VuxYOat5zO3TonlqhiL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610583673;
 bh=oJpk+CcATfE9awAfn4Ei+5bdyWi1d6iGbhg0gkd84Vc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gN+pXh5WgfzsSEmug44tE1PAim9PxYVNeUW+oAxBNdVkX1htZBPKQw+q+5j11hknWlH
 gygM1DjL6XgjEQhylPkQ7p0LzSFCTixNQJtG5fSoWzzvAAk6W9Wec/6RUDoc69tbdO72j
 g/UKQxFjN2/axNxuX5kJkhg35KH/bcYrWAM=

--VuxYOat5zO3TonlqhiL1
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D1&day=3D14&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/01/cip.2021-01-07-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Decide the timing to branch 5.10 to start CIP development - Kernel Tea=
m
  5. Monitor the status of CVE-2020-36158([mwifiex] fix will need backporti=
ng) - Kernel Team

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.


--VuxYOat5zO3TonlqhiL1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6083): https://lists.cip-project.org/g/cip-dev/message=
/6083
Mute This Topic: https://lists.cip-project.org/mt/79665211/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VuxYOat5zO3TonlqhiL1--
