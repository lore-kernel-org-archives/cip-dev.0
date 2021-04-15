Return-Path: <SRS0=IUnL=JM=lists.cip-project.org=bounce+64572+6377+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E4FC433B4
	for <cip-dev@archiver.kernel.org>; Thu, 15 Apr 2021 00:06:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C49611B0
	for <cip-dev@archiver.kernel.org>; Thu, 15 Apr 2021 00:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C49611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6377+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D2g7YY4521723xby5RswH4Qn; Wed, 14 Apr 2021 17:06:01 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web11.220.1618445158321029783
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Apr 2021 17:06:00 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id PJAR15464A;
	Thu, 15 Apr 2021 09:00:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUPfoqU6Bhj4M9fLg/RRKuZTzm0pQrAVJYZ/x5OH6G/5ygiSaZXtVtevA8rEIAFFETisw2o/nU/dyQPk+S3z99Xuxj4f42Px54Rl+n9D8VIZG1gUmYUvecVibaHYDWeC6rXKnOfHzDVtT2wZV/x/CXudPNUA9L6R0j53xBeszJTokH0HiQdahEKisgpal6NQgZUJjcQhAUD18WEcGUCXUEseADprNOwjnyGrG9hYVWdM1GeV0NLtxuc9swcVtVuubYOTrfDSpHwQmzb7PmFRc21CfLpuH4RtpgW4uZTa7NST6Q5NfAy0it8NCRLEm3aZPUqM9uz6O1yLHtlMKpUWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z23Hb4us2Btuu7ULxqjl33ySo4hjtREqytVxt10NpoM=;
 b=RKcJqmW1qLnwPCYjjWfNItDorQ+fYBylioVsaA58yv4SYhO02UZlbi0Yzrekehzsy94YhEZkhSn+uDY2w5Gps9O6WYpWhdQFl18NtN7UAo+B5zV8uWRq1nM8+ScRKH8zvjci3T+NZOSjdgrnzsjzb74Yq5bLieE5FKbqVpZ3lnVleJIHA7p1z5aT98K5T7WCz+bMKliVwQY2DeYsC3pdBUVReyIjnZhS5OsfaHOjguF8k517dmmY6K4DVZ3WaHKdkMPSlsJgrYi4t+ztGrgatc8ZRWneEOWlsCwSTzg9NahYMxB+wcTDkrEshTAzpLXUJyzNG2zMNHo5PxAKaX0LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5932.jpnprd01.prod.outlook.com (2603:1096:404:8057::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Thu, 15 Apr
 2021 00:00:16 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a991:357f:8cba:8599%4]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 00:00:16 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcxiktYO17kF5FeSaqe1otzcvoGzA==
Date: Thu, 15 Apr 2021 09:05:55 +0900
Message-ID: 
 <TY2PR01MB497257CB2105B0C811940FC8A04D9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dcb0e62-67ef-47b5-0d58-08d8ffa17358
x-ms-traffictypediagnostic: TYAPR01MB5932:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5932C4ECB3440625556808B9A04D9@TYAPR01MB5932.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 zBdBhXex7FbhSug8v6kUDQwBNgdrx4h+Qgw41I88xh/OlYRKCvII0vUn0gB9h8+AV0Tjbh+PwGCgE3BBxUDVY1fLA/yL+v9kZRb5sZLUWwc8RREZ1P7pEd821O2aaAI3lnTfPSZ2vG33iYufo/WOJ7IQg1iO0i/ZUFlJ1T5323AMUR5U+Kx8HwNmpzGsYKOPesvw+qFMzdMOhhjYv72zKUVYvnpLpFPgDEU8mjKCqQfQfqQKu+lKv6OWi8Mv5PefpzAfnC4dYXeCMiPtOnZHdMNPSiwiRRuQ2GhDQBQm0BL4JX8hWPx/40SN6ViTBEhc0bDh5+85Xs/nFa5M+hjQhllx9m6jU13j3dSNHTFTzHc82J7wr+J+Wt/xwzQYNQhOwSnbWJQtw7p9ystwA2keCZz+mTk93pYWjnsCDAytTQ/2O202xsNZqrSnoTPtnFn74MdO7RZ9MEd1URrlzf0z90FX0sxGpnRLowRVzMTXvlsViP8oNk+hKvR998zBpcvMB6xSGooziEmBFnVpMJxG6N6nbv97VI+4r3cTBJ3FlMAeoGL0PGuuSxfUvgZ4sKPsh5HZ7dvdXC3xt6aN4mQYuBhq+QvMlyuSZinoe+814+rRJT06QiNOvl5quN8fPXeWvdRHQywJJ8cznU6FgFVDPt/+PazVEKi0G+16JL3jdmc7ZIGXEo//3UbtvbqGmr2vhVljF7Iax0sd8NVKgug6PWfYplCIf2lyeKLKZGjUhvF0e1mPgR5FiTdILxOFXUit
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?QXdSQk5oSzN6T1orV1RWUFFlc0Q1ejhnQUxZdXFOa3cybjNGMjZ4NDUv?=
 =?iso-2022-jp?B?YWdHNm5nUUUwNThQU2ZIYU83bS80NWxZbEFHWjF1Skl2VTJobUhGNkw5?=
 =?iso-2022-jp?B?dFh4M1dtdG5EWnJWUDlrTDVwQ0lNRmp3eFh2RFRua3ZBdzRUcWcxRXcz?=
 =?iso-2022-jp?B?Z3BWejVwZU5KeFNwR1luZW0wWXNnTjFSSnZJMjJ6M3N5MU1ZMm5sYVhS?=
 =?iso-2022-jp?B?d2V3L1JncFo3emFsQ0g0ZVZsV3htem1HVUp5T1UrY2NzMEFyRk1IU3RP?=
 =?iso-2022-jp?B?cUdGU1FTQjJwdlhQK05NYzk1UFZjaEVPMm8rQVdRa1F2N01sSk1rNlR1?=
 =?iso-2022-jp?B?bmV2em9mbDhDSFFyRktWbHlXM3RibVJCR1pCL2prcDhKTzQ0LzVRcldj?=
 =?iso-2022-jp?B?WHZmZ3hOcTNiQmxycGUxNVNicDVwWWFNeTJkcFE2VkVuVi9pMHZidHNI?=
 =?iso-2022-jp?B?aFNDSzJuQWozRkhnSVhyM3EyS3B2UCs0ejQwVWF3VjN5TTZmdjhNTjFp?=
 =?iso-2022-jp?B?M25NM0hSWVhUUlZ6Zlh3YVAxMUJOcjgydmhFZlpteWhsTVB0MU1LOE9v?=
 =?iso-2022-jp?B?QUVTZG5pOW43VTl0b0l4VElZZG45aGZNS0cwSE9USEoxL0ljOWtXNkNB?=
 =?iso-2022-jp?B?OGh5QnZVT3NJT3lVWWpDcFNnWWZpUlN5K3FQUmxlNmZwSS9tTWpoOVV1?=
 =?iso-2022-jp?B?SitOaG5rZkFTUU5HWGxnQmJWU3o5VllaY0NPeDRmSGcvYk9icVpNeTd5?=
 =?iso-2022-jp?B?NDRHZFN6ZHdzVzJNaHB6RUI4a0RIOXFnQnkwQnZycXVFcWU0SzU3R2FV?=
 =?iso-2022-jp?B?dGxJMGs3a09ydkF3L2dUemlnbGk4c3pPWkRPdnZoNGNnTU9vMDlXMnht?=
 =?iso-2022-jp?B?TWZGbnE3VHRXa2phSG1hbWREY01YZnA4VVMwQWtMSVN2eXVJZWZBaXV0?=
 =?iso-2022-jp?B?YmsxVE1zQ2FFVk5laXBVcEU2OE11OU82VVQxSkdFSTlLbTlsR0E4UDdr?=
 =?iso-2022-jp?B?cVc2eXp5U2pmcVZKeVFkeWh5dVh1UFI0LzJ6eldvQW96UG5DR2VDa1Fj?=
 =?iso-2022-jp?B?L3hxYVRzTnNRZ2JGZHNYMGxHaC9LSDkyWVRzaWI1bkRxeXh4TVpJV2Qy?=
 =?iso-2022-jp?B?bkhSa2dlQVhrSVBGY1k4anJNekZKaXo3QkdnUEMvdEhYWm1jRzA2TkRU?=
 =?iso-2022-jp?B?RGdYUkIxRE53ZGxHb3c5RWpGdjlPQm9NNThwMmdMMjdkcCt3a1BOYUlO?=
 =?iso-2022-jp?B?b1JEZGswajhEQS9RcXVERzJFZ0F4QWtXcTY4ZjBCMDNPL08rNFQ5SFpN?=
 =?iso-2022-jp?B?QkhhSUxWcXRZSGt3OHFoQ3VCVzl1ZkJ1bVBpaVRxMDk5NEZIZ3gxNFlX?=
 =?iso-2022-jp?B?VEh2UnlmeTd1aGZCNmFUM2RYbXNiaVlVQ1J6ZUdTQ1ZpbWVQdks1TEJE?=
 =?iso-2022-jp?B?TGt1QlA4b2V4YUtHV2dLSDlIbXJWKzJZOEVHR1VXU0VXYUVIVG1Sd1RI?=
 =?iso-2022-jp?B?bTYwY090UEkyL2dnRHdTT3h0WjM4QXhWS0RjYUI1Y3FEaWJWbHhrYkl2?=
 =?iso-2022-jp?B?SGdSNVRkeGk3SG4zNWw1RWZDaUFJOVZSU0tWYTZ5UzhoVU00dytXek5I?=
 =?iso-2022-jp?B?cnI5dE5FNy9SRWRxd1JCbkVJV3UyQkE5T3M0RVlPdkNMWVE1UVVLUThh?=
 =?iso-2022-jp?B?Snc5SDdKbHNYbjhKZlRkSGplem05aHRzYnpUMUMvb0M1MVUyTHpNY2pZ?=
 =?iso-2022-jp?B?VUJqSUZnWG1FWFRmSkZGdFduWml3WEgrOWQ2ZCtDdmN0cmJJVU1sbWJw?=
 =?iso-2022-jp?B?Qy9UUHBuQ3A3NXlCTjJHdnhjQzdndEhaVjBIU2tGQWtLN3ZxK2xkSXVD?=
 =?iso-2022-jp?B?eHFTbGpBRlgwZUVFYVhPbFh4UjZPeDBKNlJZcmxoWGhGK05hYU9lNDdx?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcb0e62-67ef-47b5-0d58-08d8ffa17358
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 00:00:16.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSyh/aqomLZrXx3XDsa1/FeC9FjjqcrjxKEmIgVShbliibreBFFbdl2kUztoBxQO8ZhMTn+nUHsAgwFGYnV3QrG/phUEItUNzBt3tTURRo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5932
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WOEU9zAWwu7TBAwYaQjTHNNhx4520388AA=
Content-Type: multipart/mixed; boundary="kz0WwFK5AaccJ7KDpm0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618445161;
 bh=NCvOzOCVI/pq3cKvzfliK2WVYTgm0rT9cWQ+NXAJWMw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TaIhbsgKCRyWokvA4JzEY5N2tg2q8qQevtdMz1EnBdnAGeocRT3KBff8OsVmVH0jfs+
 d9bFeTOFXKk06p/W52YvALrIQBxxV8IPzqHZMWxsLmgw0miJpv5GwxL7otdG+N7s1tcD2
 2WnChEA5BOw7H9LS+edOf/U9vjQlKK+3ME4=

--kz0WwFK5AaccJ7KDpm0h
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D4&day=3D15&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/04/cip.2021-04-08-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
  5. Update "CIP Reference Hardware" table below with 5.10/5.10-rt info - m=
asashi910
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/cipreferencehardware
  6. Update Testing table below with 5.10 info - patersonc
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/centalisedtesting/cioverview

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

--kz0WwFK5AaccJ7KDpm0h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6377): https://lists.cip-project.org/g/cip-dev/message=
/6377
Mute This Topic: https://lists.cip-project.org/mt/82106332/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kz0WwFK5AaccJ7KDpm0h--
