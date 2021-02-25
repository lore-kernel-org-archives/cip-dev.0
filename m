Return-Path: <SRS0=TIGq=H3=lists.cip-project.org=bounce+64572+6195+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B49C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 01:37:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1F964EF1
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 01:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1F964EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6195+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7m2UYY4521723x16LCX2flu7; Wed, 24 Feb 2021 17:37:10 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web09.5526.1614217027295159619
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 17:37:09 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id ZKgA22174A;
	Thu, 25 Feb 2021 10:32:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhME+8p7g0/OWvxA5abPlkmAr9ZDKj0eRHFc3zQirUUZgJ8QuXnQ088gbBXI12P5zRzS6r4leqZJmhU/sxp6anDtZ749bTH28KX9DTk1g+c7GB8v44q8sgL9QwNYSjbQ3JRSaJFrXUL6SxajFMoMC36M7LV6AvxRLBwwL1kSNmxrKA/XJtNfY8cG60lCVI8jp22CR/8kr+3vx4pF8/T5sr0alYwRjar1tKa+Or0zZ/vzULzL3TYsMXbkcDX+rgzv6qByF40gH7Qu0/9XkZHbgcPp8ExNQK21EvacKR/R+GMENfgWaV5IaAftfqYdz8QtY+1anphhCR/g6j9hzxnm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Sd0ex59ZMjyaH8kEEBH0+RBJGM/O3Zys+MTrNEe30=;
 b=EB2AczdnjS3GwUfI3NU9N1EpphFS/yyBFeWXSUXiErrkZj+WeRiKrXpMQJOTLnupvK6EY+Wn4fIpbBwW4sz4gtFGUmAhaxzgy5oUYbS7znL0WpAK/EIJ9CccAc8l6Xu6gD9M4fy0VLA6fWUgXnJDtESF1xuWTOXCrbSaYRyULBsQTCIycs/+WQL94wTpvcpEnk3QOF0BT2EUpOrg5b8fgdivsK3dRvOFdwH8eKt6G39eLjaaChtfTu43KQgRzwM132GoM1XM7ejGCDG12dPRos5oZdwQGQfJpq0WeSMeA9SVPHgoq42HGNKIwK/ojE/iaq9DfqxPPOBjWVlUNRe2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2378.jpnprd01.prod.outlook.com (2603:1096:404:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Thu, 25 Feb
 2021 01:31:39 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 01:31:39 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcLFetqVKbnosikRteUKID630xDUg==
Date: Thu, 25 Feb 2021 10:37:04 +0900
Message-ID: 
 <TY2PR01MB49725D694551F1D47C1807BEA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47213d43-729b-4a66-c3c8-08d8d92d193b
x-ms-traffictypediagnostic: TY2PR01MB2378:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2378DC7F3874877A6003B176A09E9@TY2PR01MB2378.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 mZKJH0lIl1+ZiQyKWdDKN1gI9yRCQFu1CXQPHKV0YWmBzf5r87E779zj1YWuZT47DTj9XoTYYNNFXmtlOiiUls/m7voF0yQyehGeiCCgEDIdOo1xZwsRMEdjjVoI3KEbHbw6xqUEjTqutESOo0aGYjDlYRlpwY4tb2q+MX7CS/Fa5DKxW8WyWkGsPyBnUQTRC2jiiRdCJLjRv3sBcqTg50tV9OLdRoMcBtu3dY3v9+occGJwX0q3QLDnInmuIcDg85ifQ2qjIfLVKpEiWS+WMgs/ntS/5pi9cIf/ql+8Hsf0xnxQb7ZJkOJF6Hp8h79H1aVOT7ePz3g7q22CYQzLT+EFPYWoA3ygYLRUNbsYAlnm3xy3f83l3oNSDq62WLIdimMSec/8uEiQB4f9WWdiAbAk2ZlJJSb3KNujU/UkzQJqdvVLqIRlp80lbUGD4qI4I3SbdlhV4b3p4LQfiXMFYltG5lrxcPazPvnGkUZHv5LNB7fe4nyJvjo6zEzypHzWk/wmTjl0ydrDFAWqIjXlCfCCaRabO9OrxjqXqIXjY1E78ifjiaM757lVHBjprTUWtLZu1+ncFpRzjavudTWo6GunNDHhN+Jwt4nCrJaBHAY=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?ZG1sU2FJamh5RWJPMEkyczZnVk80NnVMU2t6RXdWNmRaREgwSVZ2OCs2?=
 =?iso-2022-jp?B?OEpHdm90WlBzWWEvMldmbklPOENkZEFWSUJielBwOGpKRDJZcnIydlpS?=
 =?iso-2022-jp?B?alh0aVhPUkhDdlY0OVQ3QTk2aE5Ob2tZelFXTEppbUJNSXNaUi8wZnVF?=
 =?iso-2022-jp?B?czRXcG53SXF2NXVkZlFuK1RZNk9RWk9TbFBWRnVYWE04cFdpcm1neUgv?=
 =?iso-2022-jp?B?L1hXTDJhZGw3cTBOVnd5Nm5wbU5kV3ZtWnROZHZibVZ5eWtlNHZhc0Z3?=
 =?iso-2022-jp?B?ZW13MnF6MFU3YzJyUWZMSlREaHNTSi9Jcy8xdGlJWEFyWHFLSXJrT2xa?=
 =?iso-2022-jp?B?T3h1Sm4vMDFaN2VwWUdGRTBXSElIdkR2SnhSQ1RIT0JrYWE2cm1CTG9G?=
 =?iso-2022-jp?B?bXp0WWdqcnB2NEc2cW13alJxSDVqUzZJZHQzbDhtWEF3cjRCekZhUGtI?=
 =?iso-2022-jp?B?b1YrQ25QdjdlRytoaFU0NEJlbTRha3IwQ1JxRTZ5UEkzbTU0Y3hrQ3gr?=
 =?iso-2022-jp?B?aW44SnllN2RPQnFVdXFpdHltOUJ2MVIzSU1mblNxTEVvRmlRSFA5YmFz?=
 =?iso-2022-jp?B?MnhJTmpmYVNaMXNVZVpFSVQ5cjRMMi9GQU5pdHp6MkViSWJuZE9Lam9U?=
 =?iso-2022-jp?B?c2lPdW5oRldyZGRlS3g3ZjFjdk16YXFCK1pKSG1qeWRERjBHbFlOTWgy?=
 =?iso-2022-jp?B?QWQ4b0dnM1hkRFhEc2V5dG9qWFlLWHFLaVNPM0ZWUndqenlFc1B3dU1x?=
 =?iso-2022-jp?B?bnZoeS83LzE4WDZ3WDk0UlRKRGhBYVFZZGZaVXZYVFc2Sy9Kc3RreHE3?=
 =?iso-2022-jp?B?ajJ4dmZ2eUFMZm92MVI2YzYxSjI5NWx1a0ZLamo1ZEpYeG1iNmRjKzIx?=
 =?iso-2022-jp?B?Y3BHck91L2I3c0wya0o5Vjc2ZWVPVVptdWZoSGFOajZjeUpCSU1DNWtY?=
 =?iso-2022-jp?B?bzNoM0pwMWdhOUlyVTR5bzhINDdMcFlnaHRKV1FtZ29SenhOUDhZUTZP?=
 =?iso-2022-jp?B?cjFvYUxKMHZXUmh3dkl4QWk1OHZxNEFGd2tUTnYzT1JuQVBDbVI1d1Ey?=
 =?iso-2022-jp?B?VjRsL1hubnhkS2ZEcVhQeDd2NmEzNWxrMGxIOWJPN0dHQlVSVHVWV1hM?=
 =?iso-2022-jp?B?TmdRdS9ZcFcxb0dSelVPc1hFc3NxaWRHaUtLM0ZXYWkxcVdwSEZQcVRV?=
 =?iso-2022-jp?B?bE83Y2tvc1AzY1B6RnEzd3FLNjdxckY4VFErSkcvakJDZDRsUXUxMVhK?=
 =?iso-2022-jp?B?MFZFamRJZkwvVHVvM0ZMTGFnY2ZwR3lDcGFUSlJ3Y3ltMVdDWmpvQlZa?=
 =?iso-2022-jp?B?K2NpVy9idTd1QjY2VjFNV3RFbGdCZ1NDYndNMFRCQWN2RCtFWFdoczBE?=
 =?iso-2022-jp?B?d0puYUN0dXl4bUNHVzRWQ3d2ZTVaUS9HeENoaFhnT2l0b3Z4c2tJdzdh?=
 =?iso-2022-jp?B?VWpvd1l5VTNGSURJQ3FYUEw3ZTdMS2V5WVhxWnV1SzFJQXBRcWFrTG9Q?=
 =?iso-2022-jp?B?Ty9Wc2Z4cFRrMm9xL0EzZGZZYjVvOWRjNjRNeWp1Nkg1MFRxdnhReXF2?=
 =?iso-2022-jp?B?VFoyWTl3Nk1wcG9JUEZhMXBRdG1ULzNjR2FoVW5WdFV4Zk82ZUtqZXpW?=
 =?iso-2022-jp?B?MEt2T0FBR0dvdHlLREYzbmhvdkxYYkt6UjBqdUJVNmtSZFBkYXhYSG00?=
 =?iso-2022-jp?B?MzF6VytVYTRWYzFheUVHT2dKam5zRlhjSE15ck01QU1QZzV0ZFpZUHY2?=
 =?iso-2022-jp?B?cHdBMExhdXlmL3d5a2JYbDhGdklVLytYK3hhZE84Yy9TVVhGZEZmNDdI?=
 =?iso-2022-jp?B?M29aVTlvdzVSMlVKcE1RcjFkSnRSeFFieE1rWkw1QTZiK2dHK1ZlK1Z4?=
 =?iso-2022-jp?B?OFU5VDN2Vk9ua2ZNSUlnbm8ranoyOTNZMmhvUkIrbUxORlVCOGZ1alR2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47213d43-729b-4a66-c3c8-08d8d92d193b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 01:31:39.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0P6BJaCXWzuUJKAO1Tq9bBz32sradQqrzyTKK6wcLXor8/44/zf1kDFwUcVM6YWnwyF31yCzGLp+hVmxiHNLk2YvWFMOVsuX1GOKumH7xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2378
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2YqdKwD2gi8b1raqtgy2Hoinx4520388AA=
Content-Type: multipart/mixed; boundary="2pwa4m7ykfc5HRfIZ7I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614217030;
 bh=zxOXz8h498fx2PaJbWHP4sAm3xAt8N/TFXsE8cV7sOg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=jXXgBbFaxVAsL9kjTV+45kqpUow5rxg98HOd3kyf519CMdh/hzQtcPcCkn3g+BGkVQX
 bLysyPhf969fx0NhmTgej6I2Qa28gBFUZ2OsQh65/Lc5eLGYSESMCKs5EA5HOWUynReIO
 S9TjdypMsdGTOoHRsFEBvVQLlCtXroDVGr4=

--2pwa4m7ykfc5HRfIZ7I6
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D2&day=3D25&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/02/cip.2021-02-18-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team

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

--2pwa4m7ykfc5HRfIZ7I6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6195): https://lists.cip-project.org/g/cip-dev/message=
/6195
Mute This Topic: https://lists.cip-project.org/mt/80893035/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2pwa4m7ykfc5HRfIZ7I6--
