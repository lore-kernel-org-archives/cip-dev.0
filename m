Return-Path: <SRS0=Ba2N=JT=lists.cip-project.org=bounce+64572+6381+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65561C433ED
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 02:00:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830236144A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 02:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830236144A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6381+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id On0vYY4521723xYnWQfQh8EV; Wed, 21 Apr 2021 19:00:20 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web08.6739.1619056817208593384
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Apr 2021 19:00:19 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id WK3G10557A;
	Thu, 22 Apr 2021 10:55:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC5u92g6L065HDXPd6Zv9Tz+ESKYw/K8QziiY/5YLi+1eIrmM2Cl6G6F7e8hKEMpV9p+PEio3WtXZ0sSTy6J0Y2WOxCZHNHBhCqzuhn1vWh18IiWNxogqL+BgKoCAw4ThhxrovFjVUrQOvWJlL2PA1oyVJY788ZdRWIVXQGjZT8rIF1Pv3ijRo5wisKcRnkBu2FGOhdUWUZV9WiNsLVqG0Y08G4h2JXbvZGHBaBaNBtCTA5Q1ZWysMnCdUSlbp7L1/ZYviSRBr28WM0p+ykTJIJdE9g4yC7pHSaZ+yM2ri9Z8zkXc0JdJX931GW+5DlYvw+zgx/j+64AdOlsQFp2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkSrxtVX+w0Fsll929v1RTrSZBOdX8Lzt+FuEDFvai8=;
 b=hWdDlJDAg+hZNFibFVNMSrshTFPVjVl+q7mO3jkxqjsNSuAvujey+T9csTriEWQbr1lMn6OkvJGoM0Gs9aL635k7T/Iz350z7cvTyg9sSAYJn1zSv//RatdB14Ya3IgQ372IpBRzRqc0oRf2HRFdf879BSPphnYgpk4xyqTskLfeMDRKsBG8XK19UBQj+kwVqjzm3K3K7V61tE0KBhbmuB+2SnTlrbCKWOxCcOi3mYbh9O6BkBn9TgS5rPWr0lb4DGgGaeZBDzs9vinRgiOlhvGs6zTIkCg/KSjmKq59/qt2QBWGhSrbmWPF+Nrqcbc3CzFJeGrXlDclbWRUsvEB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYXPR01MB1696.jpnprd01.prod.outlook.com (2603:1096:403:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 01:54:48 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599%4]) with mapi id 15.20.4042.025; Thu, 22 Apr 2021
 01:54:48 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adc3GkaN/pizAM5hTwGdytUf7xv80A==
Date: Thu, 22 Apr 2021 11:00:10 +0900
Message-ID: 
 <TY2PR01MB4972607E584418DD16E09CFCA0469@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36e14693-4986-40ec-e653-08d905319c8c
x-ms-traffictypediagnostic: TYXPR01MB1696:
x-microsoft-antispam-prvs: 
 <TYXPR01MB1696D338C85980BC2F4227B7A0469@TYXPR01MB1696.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 hiERsuQMFdoUt/zLq2bBc9MPWWo3d4SUj/+UXnWRO4xcHS6qCgptv8GYtq3rvpnAxBFd8CxRNsVfkDGGQYZfl5yZPzI2sAw0Ov8F+pe1N0/CKUB/FqKfhvaOanSr0Muuco4sCpeV+/1iAL2WvLVqmaqGopL7KUBShmw3eNpkCRlc89QyCmOhi0TsIGBSlPtsajcHNynk1AwHvgtOu0xiwF9jl86SkILaFCRFS/gXpU1txUo3Gfja85XZWWnOn0nZBmkNWw/gUSd1dapeNLJJj+PBW/qTQ9MPWZYZhHffyIJckqKjcXgVPZcrPnBa5C1pZbGvcaonnHkgMYI50BLy1zWzxa+ydpasdmb7RsJpNjA0ekwUrdlD7eBncUSYgNjY7PHjoWXfDjcIzRINl08GowArXHIRGCLEnJpWx8eLAkedc4gZn9UNNEbIiifekonE5AYkthkvXnL64TndweDGmVKP+cfHIcesOR66bYNAJFM0JOuRppTxEV0Jttl8QKsqwGzoGBj9LtpW/HkSYQgSxTWvb0ubhXjUa14Khci2VHdOlAFhHI3BFcIWxKmF4pNoYDn38nxnT981w4ImAzzqB4sI0rPg1uDpwh0SLZLUoatUSc3UrhjVGMuZLP6W2UFYP1sFBMhGQGkvGgIi9ZTOozJb3Ez6fSAieHKpgbIg3RnirfxFanB1nckQiLP9RSKFJab2sTTq8mIPSS69j/OQ9iVfZuIZ85DwP0L9HA3Wwravi1GPSeS3tovl7cnuYsfJ
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?aFJ0b3EySzk2NWlNSjIxOEc0aUJ5TUtMNDFkdFRCK1VmRFB2ZGsrT2Jx?=
 =?iso-2022-jp?B?WHg0ZXg0LzMyd0M1Vi9Qdkp6N2c5ZHR3bm9yTElNS3VTdGI3K2I3cTFx?=
 =?iso-2022-jp?B?SmFEaEJzZTU1RUd6VW1iK25yY2pCc3E3WldtM0hOSDdsdlRoaTdNWmpn?=
 =?iso-2022-jp?B?NVlYeW5JU201SXlwUlc5aFRYbUxpVitmS2hwdXVJZHJYaE44bnVDRWxB?=
 =?iso-2022-jp?B?VHdFNkoxTnpEZEg5Nm1SSmpyVjVkdi9XaDA0TkhkZElodFNYRm43ajJk?=
 =?iso-2022-jp?B?aDJmU29PamRVV1pZRWVoUFJONGpIa0tmczIwd3NGSU55R0Y3SGwvZ3BC?=
 =?iso-2022-jp?B?dmpTUjJXS0cwdGYrNXlwQnBuWDNNUVVTL3RFYWpyclV0QkgyMENFNUJB?=
 =?iso-2022-jp?B?Y0xZZDZvWUo4YzlQNXI4U0dhSzFvSUsvVElxUjV4M0lua3E1Z1ovMHll?=
 =?iso-2022-jp?B?YzhUaDViSzFWREJmYkFyb3JvZXFQY3puWktDV1lWeDRoUGk2QkVpR2VN?=
 =?iso-2022-jp?B?N2JHWVZzd25EUFB0NkduSkxPVjZqWUZaUFpiNVFpTlVpM1J3Y3FYeGxr?=
 =?iso-2022-jp?B?b1l6ZGFnZmRnRjhEWGNpZnNWY1FRN2hTeitXQ09ZUVN2TVBoZTlqTFpz?=
 =?iso-2022-jp?B?RlZSSFlvSDRMMEpEY1AwWklPWVZrZlFJdGhseS9pY2RieVZ6aUJzNCto?=
 =?iso-2022-jp?B?emo2TU1JUWhDM3p4bVNWQkszTnNyMW8vRDhoeFdWd0Y1WW15MjhRbFI5?=
 =?iso-2022-jp?B?NW92dU5ybitzNW1PUjVyVDJqZGZyYmtScC9UQUhqZnFaQkJVN0EwT0x3?=
 =?iso-2022-jp?B?cHpQSi9ERVgxRjRqVzdickpRdWc2djBmci95amliT1Y4VXRBMzB0VGxL?=
 =?iso-2022-jp?B?enhiNEpvU0l5b0RtZkdDZGFrTVJWWG5sM0w3OTBnSTI0WHAxT0hYYXB2?=
 =?iso-2022-jp?B?RStqNzU2N3l1dzFLWHZGS1Bkem04Y0diSzFaRWFUVFFhNWZxM0ZZaDhY?=
 =?iso-2022-jp?B?blA2c3hxQmdpd0h0Wm1OYWsyS0ZlRjI5TVlmRCtTWWkydjhneHVDTVNK?=
 =?iso-2022-jp?B?Zlk5bzcyVDFjQTh3OVdVR2g4a1hLWUdaaHBWL1JEN09oZVFKN0FreWtB?=
 =?iso-2022-jp?B?WS96UXNjQ2RwbW5IU0E1SkxTaHc3UTRRMlhmcGdPRi9tZzVFOEJpdEgx?=
 =?iso-2022-jp?B?MFlYU0VvTVNGZytWSlA5NXA2UUZWL0NEZkpxL09KK09oeFdwbVY0WDZG?=
 =?iso-2022-jp?B?ZzZxMlBhMUJ2QmF2eFFuNUk2YVh2L3ZvU01zVU5hdDliU04vMExTTHpP?=
 =?iso-2022-jp?B?VDVadTAyZ3FVVDhrbUdPa1g3cmR0STJCMUhndEk0aDBoaURmWjF0a1Y5?=
 =?iso-2022-jp?B?WGFZaUtpQTM4MjlOeWtQaGErdVoyRGxnTVUrajdISU84RlpzaWduYTMw?=
 =?iso-2022-jp?B?d0NJMGhhQmNVL0gyN0lqclZRYm9CQ0hWZm9yLzYrL0ltTGg2akU0SkJD?=
 =?iso-2022-jp?B?WWw2NXphMnVpUmRYVThXcXJzbXRzano3Q2FnR2lvV0xtMUlaUnI2SmMy?=
 =?iso-2022-jp?B?VzU2c0RQaktmTTV6TkxXUHkvcjJUSitMNTlRNk0ycGVhMzRGb1AzMDBK?=
 =?iso-2022-jp?B?SjdiRHRoTnJuc3BOVTJUMW5ZMmpLeUFvK1RSWE00SkJhL294TG9JVFhF?=
 =?iso-2022-jp?B?VllxenM5NjFXSGxPSXMydVIwS0Q2Y285WTZ4TTVLR3RvSkdZNndwKzlR?=
 =?iso-2022-jp?B?VkZwWTM3RUcxNVlVYTB5Tk0wMElvTEF6clE3c0lBYjNxeFBsTzdwS2Iv?=
 =?iso-2022-jp?B?Tm9hb0FLOFZuY25WS1NSVVpDdHpUTnpNcnExaWJlOTE4L29tQmp3dDRB?=
 =?iso-2022-jp?B?Y3k5L05pemh6QUZ1QlZ1UlVtZDNJNEc3M1JxSEhwR05NdnNDR05SNWZN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e14693-4986-40ec-e653-08d905319c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 01:54:48.7152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTWiJzOUM8eu+Y/YvOp3dY8C7VmlmT5yO2GxjLBSPC+cnRfA0GmDb5fNjEq1uMwFK+87fVxQymVj7m23MzltPoLloRSJq8D/jdqXG0UTII4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1696
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F0IQAu5ltPuCe5pXYOGz8Ajnx4520388AA=
Content-Type: multipart/mixed; boundary="ad8buManaWPwMh28ZOiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619056820;
 bh=jYapYDjO7N3Z3uIFSTu5tZ+ULMwXDv8nbrvkocpwGy8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=aVYCEbCqNOmqYG/K3ZwLtvAXeVrGED2tdzHH9Ye/lZZpdna6mljBB8Wz6GKtTKlBc/T
 FbDtkw+095JNcFONDwui7TgQSurnp8LNdPjrPnt0y/ScW45cnde28KdaV4SmiRcokT4Dg
 5tW1l21g5VcBh8m6fyrzwvw6NtpK/EW1wHs=

--ad8buManaWPwMh28ZOiz
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D4&day=3D22&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/04/cip.2021-04-15-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
  5. Update Testing table below with 5.10 info - patersonc
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/centalisedtesting/cioverview

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB
  1. Next IRC meeting

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--ad8buManaWPwMh28ZOiz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6381): https://lists.cip-project.org/g/cip-dev/message=
/6381
Mute This Topic: https://lists.cip-project.org/mt/82277082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ad8buManaWPwMh28ZOiz--
