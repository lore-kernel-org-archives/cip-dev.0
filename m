Return-Path: <SRS0=ngX2=FG=lists.cip-project.org=bounce+64572+5933+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA30C6369E
	for <cip-dev@archiver.kernel.org>; Wed,  2 Dec 2020 23:55:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45F221D93
	for <cip-dev@archiver.kernel.org>; Wed,  2 Dec 2020 23:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45F221D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5933+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1V1FYY4521723xxy2CUtmQha; Wed, 02 Dec 2020 15:55:29 -0800
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.102])
 by mx.groups.io with SMTP id smtpd.web11.2220.1606953328205503690
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Dec 2020 15:55:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deBbMaZZy6f0ysJgIGABMZZGK3dZdxGkhMvBuAnwcM8pM74anV5cjwwu+/IFpKzybyOQeYaeeTd/ouhutA+KtRjAqo/DbbWIGt9KeloI6JKiTb5sj6hxUy+h+UJ9UGwwO7oQ+YURj/k231gFtDlEsajDBILmKddjOKFgsB1Rigw4pSpsaFNZ4VOCqZTHCa5X65nz/u/6Ed/Yetb2dgQWedLnq93K+GrB8OWFesq5RZMqKrrWKE6lcJoOLNXdUHUJAv828dW5YWqWO4Cf4U2kN/B2uSRICVWtgTKXYMtOn37xQdsZYb6S9+ma1OCr4c/ckWLUyc6Cl2tZkWGnJmmpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqleJE3dHZ5drPET7CS4Yo5Z2tgiZLqcFrYQZkCFVzk=;
 b=FjMHO7FR55WYLZGzpq1y6O7a1JBbKJ17kPXQ9kCx2y4S3PuNo5gNij4ZamXKtLm5Dh/KR0QsRFqhZW/L8az3ODQplHgVYgdknRLBIu8yz3xG2+2NnxMd1lDb2+J3EV9GOz8Rtnvoxgphhd7X2LhMMVwv/bOE1ClkPI6QDguHkwPNzvHMzAOFxKIDVZgL2cobmTZRWwznSOtxZ0eCguJxgEdXx3+h6rbWuwi1UXgtAveIC8Y9k36TxDi5rKtvvh/5kVXVPA4bDF0b06VvG7FOsAC6g6EU3B8hy5k6td0gUSb80R+nT/oJGdl8yk6FjJfW5aScjShW2rV6gzWmd/3dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2090.jpnprd01.prod.outlook.com (2603:1096:404:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 23:55:24 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 23:55:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbJBpjuBJm/tDjFQZe89w1GkJCMYQ==
Date: Wed, 2 Dec 2020 23:55:23 +0000
Message-ID: 
 <TY2PR01MB4972472133E4D0025E345707A0F30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28c1e6b4-73b3-4606-0a68-08d8971dbc3a
x-ms-traffictypediagnostic: TY2PR01MB2090:
x-microsoft-antispam-prvs: 
 <TY2PR01MB20902C0369EE9953320F3088A0F30@TY2PR01MB2090.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 fDb1OEwcAqcv49t1lt06gT5cU8htllnjyEAqLlF3EJoLlkve7PJ9lIcD0f6TuXShTe4KcqnOpbXLr2gSl6NZ2WQrx02ooo2OjSlGadQ2EIeuR7KpCsbtKVr6p660HPIynM1A20OUu0xLrSO+glAxWcDiX0RkubtAgTfp8hkPu9RyP+jW6n+oIX9+iDS6uPNnXVSgMmImJBXMZOuqB4xyy/xzr3NYWctU7UaxmbxXns0OdbtaDLUw5eBSo66TRVPS7C3rcvAyqc0MuaNUyn2TN0LoPIGecgcEfLuNX9l3TMQM32B4y6X8Jf+qfWp0cXTJsAoJOECMuNHQpeQw4w7V1r61rSfWE/SaHe8/uT/LC9Ybe47RQghaVRtLqC626JlVlPqeLJbeFqcz4xZCdZMxDw==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?bzF1TnY5a1hWdVdRMURTWTQzeUxTeHFjK0hOcmRDdEdxUE5xV0QrYWxp?=
 =?iso-2022-jp?B?TVNhci9yM0pxSmN2ZDBFdGZsREROdlVadWdpQldHRXk3YzVqeFdWUmtW?=
 =?iso-2022-jp?B?cnMyVHM3eVZOY2JpSTBaSWVRcmR5R0NsamllYk9JdjlzSFFieDBmL2o5?=
 =?iso-2022-jp?B?UllUZHJaMEgrVUJ6WEE1NjhzQ1IvUUdTVFVvQkJBbWdRWUoyWU1oRTMw?=
 =?iso-2022-jp?B?b1N4YlBRdlBZeXRkbU9UVk9rQU54SFYxYWRUcFE0YjYrS0RhQlE1SzFI?=
 =?iso-2022-jp?B?Y0RiRzFVZUFvdXFhVUF3NHFQYlM4L1pSQjl0QlJJUWJQT2xPeDlOYjh3?=
 =?iso-2022-jp?B?WTgrNGp2czdmRUorREpVSkZMeTU4MnpIRUY4SVhhNXViMWljbEFxWmpP?=
 =?iso-2022-jp?B?Z1V3MkRGTTlmY3pnNy9rVCtlSW9QNTFKWGRqeTlhSWQ5VC9sc3doQits?=
 =?iso-2022-jp?B?T1BzdkxucHlrbnJIL1ZNS1o3emJhVlBkaXF0SVA1aVh0b0IwbzRSei9l?=
 =?iso-2022-jp?B?bnMzc0ZPd25pL20zbTJ3ZjgwaS8wTTVhMDJFUytCMEtjbjhkSXRSU0x0?=
 =?iso-2022-jp?B?a3hYUW5CZDR2U2xvdGx0WDVmMDVVVVhCU3NCODRybEthSnZzRUF3YTht?=
 =?iso-2022-jp?B?Z1lsdmFJTFRYdllBeUt3NHY5aWthZ0I1OVc0aGN4MFcrVGJ0Q0xYemtF?=
 =?iso-2022-jp?B?R2dHNkhzQ3FHZ1A3MnRERVAzSjFIQ2IxZnRFbWRqUFEvSzgxQUorY3ZP?=
 =?iso-2022-jp?B?MC9uVm5iYTQ3UjhWR1RsbzF2T3Y2UmpVUUtDNWc2ckNLSUZTbklqSzBZ?=
 =?iso-2022-jp?B?Q0QyZnZhNjZTTjZ6RVdUdFh1Y2xBMkhPclFCQjVZNjYwVWlQeWJGTWYw?=
 =?iso-2022-jp?B?Ung4OVEyTHhlQllobjA0c0tUR0g4d1hBSENoQTRrSFBQR0k1NGlyWGFn?=
 =?iso-2022-jp?B?RTZkOW1vcVRZQXdpZER1b01BRTd1ZlpCcFpVcW1OakdZSVc3aGtVMXFB?=
 =?iso-2022-jp?B?a2JhMnhaeVdidnlOZDM3ci8veGJMMTExa1Nsb2xRNjZFRnN0QzRHNnlQ?=
 =?iso-2022-jp?B?RUJiLzkzQmorU29IelhaOWh0N1N4Y2MwRkNoWnRqbkhVNmVVNVFYbkZt?=
 =?iso-2022-jp?B?dk5HTlAxQWkwQmtLMUNzTllIMXpMeTFDYWZJNzlId1J1WkhxbktLWFFP?=
 =?iso-2022-jp?B?RThzK3FDdXBBQ2twNWtaVGEvTmRsU3RibGprYUY0V1o4NkQ1d0hxNE40?=
 =?iso-2022-jp?B?d0tBQlJkdUFNcG5RTDZtQzN3dnpEWjZ3bkFYYjdoc1c5dndTQzhFOVdv?=
 =?iso-2022-jp?B?d09EQ2QzaWRYMEtid2RhWm5KN2hmVFBSVWFNVmphM3d0RE1NVjg4Qk1z?=
 =?iso-2022-jp?B?Vmx3ajhzZi9tZlEvUkdRZTJ1dm5vL2FSZlVtTThHYlhxajFxZz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c1e6b4-73b3-4606-0a68-08d8971dbc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 23:55:23.9761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LimUPgPx0+8huZk3QPmmWkB5p0SWEAnUdbi2JXVmAnCWdjO+6g6jmRYzZBgRKGgc3QvBg0qePYogzObVbuG/i5lMnqaMwZqSdgKMT324YNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2090
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mhAVsLI3lPDceF7bgg9s5IdXx4520388AA=
Content-Type: multipart/mixed; boundary="0zJsdWQ6YMx6DogE6Wff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606953329;
 bh=G8N56oYL+zg4pntGEC7vRRh+AfeMtWB7Bq9BwmLRqNo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Wczmn7FZGlEAkap/Ay7WeHb6AT31+W7opxT5bimm2k1Eok6oF6vwqIfqwWYXBTW1FyW
 aShfxc84DNoPkAAJY5JxFsNU2YEr9wtZnaYcCeRQ9Ff5zP8Fc2QgWFfgDlgbvNQVsxOQj
 UfJxO2XkuN1YHzRcyXzWEUzOBMMlQyuR4kk=

--0zJsdWQ6YMx6DogE6Wff
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D12&day=3D03&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/11/cip.2020-11-26-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20

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

--0zJsdWQ6YMx6DogE6Wff
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5933): https://lists.cip-project.org/g/cip-dev/message=
/5933
Mute This Topic: https://lists.cip-project.org/mt/78673807/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0zJsdWQ6YMx6DogE6Wff--
