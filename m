Return-Path: <SRS0=N+Ai=IX=lists.cip-project.org=bounce+64572+6328+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA64C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 00:02:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B98E61A17
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 00:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B98E61A17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6328+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LaekYY4521723xK9AMQIZOEK; Wed, 24 Mar 2021 17:02:55 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web11.880.1616630573260599599
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Mar 2021 17:02:55 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id ZI4w27510A;
	Thu, 25 Mar 2021 08:56:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWYoyN7MfWU4R4skyaL5wKgmCRohCdarbDTFjMhv7aY1SV1DUrmBqjPehbIaAkAy7/FMYDUDBDaViack5svkGjQPBP2o/ueJ3jLF/SM73+oPaCoXl/SIOR38OmPao0qt02BJgZF7U2GC7z5U6303Yr3pD3TFFerZl2mPvUzzHE4zjw8yKJKWIf9MEjeb8IPAp/yMaXDTCsYPjh6/s2UuTUR0VGrqGMXe7RLrfA7kFbaQxT0FtLrMJpzS2eyWQUh2esoLLFSWf3oR1lWmX3Ey8PYtkbg1/pfB785abgWo++gw1Gp5o0vnJDzPr8uq7XRdgxBVq43NsZRRuFI0zC1+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZoAVa8iaOXpDnlRV7MtHchsfRYtAuN1oSn0ovy7wAE=;
 b=Rw220GNAStbngp6VVUMklv1YS8OrxYagARpGEI27QFNUNvsHhdi+l7EnHpjSCAn+zqOLPTA26AEHA66ibsgtPn9fHQbUH4SV5g5bvby4utXKobAw5IAM5HDo86ICVKhfYv3EIdOCksD94e/ybzQQeYJn98jrP8AvQtVxNtWjG474EXtIEFFEu5gfIX9QV9V8R8vGkqZy/rXZaNJZaVIA5p/sabalQNJK1ONp5ovwgG4BWbN1z+TUCA1ikgvh618x9cR/qqISidLiYEH/MHjOa5k4dpdZ4iSfasgTFpTa5Tdf1snA6yZXAuBTSmohPTEHxSRu+dCYWeezaSAox9guQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19)
 by OS0PR01MB6002.jpnprd01.prod.outlook.com (2603:1096:604:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 23:56:37 +0000
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::dd56:770a:3bfb:6029]) by OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::dd56:770a:3bfb:6029%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 23:56:37 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdchCVKfQyu1k3CfQgmkqnvUCa7AVw==
Date: Thu, 25 Mar 2021 09:02:49 +0900
Message-ID: 
 <OSBPR01MB4967EF41D9A0D69E6E46FCE4A0639@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a03c6454-ff77-4214-398b-08d8ef207687
x-ms-traffictypediagnostic: OS0PR01MB6002:
x-microsoft-antispam-prvs: 
 <OS0PR01MB6002F5445118F87246D4AD89A0639@OS0PR01MB6002.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 GiDUJWGtf64seg6vwIqppNVYj0n52V4fqp4/3DbmWPyFZoTefXNM238Zovfeee44pwZ0qRiyhzEcwrQRP9pVN1K8YG7B8dDIdTMgs2SIaNV+zXZgT9xj9dwo4JN2OFPK7Goa1uu5DyrwfkOEXuQP6SzxXcgBLd8BAn4IZLn0DbSVQFIuSaHameI0NGzLoUk1RoX1clUJyzGE4Typ58ZrCpRlMusyOYgNXs70W8iUsOzRMtHm3+Cbn98h8P5TOYD716MWGR/VhSy0A05jmn94PcyaylvIdo2MSRQ35beAEexo8AYFO2pDK436kx3eygUeOY9TuwkAgt7LeUtcXNvWANX3xYnh6XY/W1VVmiyEYsLglIj2+foRtOPw9yaiAm8cIqqIWfjHqQ1aCpfwedoLbcXzB3qusT9F4XDXebV+bOQM5nZYEyG0ig6ihUhRtIyxkhhKkM8qwXBBekwaz5ta2pBNP6+9er2G60LxmKCwKum1WwyV26w9pbynsjzKa7pqHrPedYgvbqUhP7VsO3rBKma+MPeuhZuTX/GFYeedhUTVNXrlYSCefsQuaftUrd3fQe4+N4BEcgJJLvYZFRYtZbWjstuRWiHuBRP10Z/Y9nFGkmT6A+BUWfxYHOjJqjgPwxSu9s18eQlPehnH8cpqi9KZIUIXbk2XG8EYRNXKf9aOjhBtppbXh9phnWqymW4rmHaK55zmbYvN2A+Zk2OcARlhYfugcagdOkD1O55kSJru+lJUWcWbsezHksjLyBZH
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?bmVSZUtyMWo1b1JsNTlvZ2F0dkRSU2U3dVhLOWQweXQ0ZzBoeGl2bDcz?=
 =?iso-2022-jp?B?NzFMejVobFpDK3VJQnQ1VU1iTjRsVEk1MTViQ3BQRm1xVmFPUGFOWGZ1?=
 =?iso-2022-jp?B?ZTNJRFJjMU9tMHoySFV4cFB3NjB2NmNaeUVSUkFxUzZQRG4wRmhQV1ph?=
 =?iso-2022-jp?B?MTFQYWwwbUtueGU4WjFzb1QxQkJqVFFiNjBKWUFpRG5EU2pYajU1aHpj?=
 =?iso-2022-jp?B?NUE2eVdLdWFnamxpUWNTTWxjbGhLaVRxWU1aMTFwWEU1MlkyaUZwY24x?=
 =?iso-2022-jp?B?TFBkYy9ZZXFyVnpjTzBMR1JnVkJIK2haUjBrdGtLZ244ZXZHYXJyaS9n?=
 =?iso-2022-jp?B?aitZSmxjSnJUd0RWMUlFY0pTZGFmYjhIRTNvRXJaRWRCSVFhVE9TRmFo?=
 =?iso-2022-jp?B?aEFLUGp4a2ppc21yeGVZdmdLU0pJelY1Mmp1czBYaWZzNXBJalNodTND?=
 =?iso-2022-jp?B?UFhseG1VOHVVSGV3Q241bHk2c2NtZmxqNVlEWkxWNElOOEp6QXJYdm1a?=
 =?iso-2022-jp?B?ZFJQejNVVDR4bllzbmd3eVZraWs4MUNFNHFnc2g2ci9IVEM5ellsUWU1?=
 =?iso-2022-jp?B?Mk1JcHhkOWZ0NEFUeGpReER3R1RsckNVUC9JY0dyUENvNnZyWmpCdWtm?=
 =?iso-2022-jp?B?NkxhZ2hsa0NhaDhtd3dCTk1qU3ppQzc2NVY3cWdUSDFtYWhadlFaNzcz?=
 =?iso-2022-jp?B?NUF2dFZ2WnVRZ2pzRHRlc2RQMTU1NEdNNGx5Sm4rT0kzUzhLNjc4V3Jx?=
 =?iso-2022-jp?B?aG1Ebm9oMlh6TXlqMUw2UVpnRldPOVIySnBsa0w5VVJnSG5SS25Ma0xE?=
 =?iso-2022-jp?B?cG9sTGo2N2NlOTBOaXI0dUtlYzROZ3Zxd1pQbmtiZG9XQWpTT0o3MnNa?=
 =?iso-2022-jp?B?QS9aTHdUQ2JycXJNNDJ6ZmJWdFBhcHV6b0kwS1NteE5GR2M1K3REZnBl?=
 =?iso-2022-jp?B?MVRHMWZWQyt0SUZsVDBvMFZiUnpaUGtlc01zM1BoeENaRWMwby9WTThK?=
 =?iso-2022-jp?B?dnV3aTdRMVNxWlRyL1l2WlZJbk44S0U4REludHlxeHVnd2hZSjRCMkFD?=
 =?iso-2022-jp?B?d1hTUUFNakpCMEFZYkhoaVJWTnpHbXF1WGtqbk1vQm9TOE85M1NSWmlj?=
 =?iso-2022-jp?B?c1lSV3NuRDNtSXk5bFRDck1laElOTkdJcWFqUVoxalByWE1mV0c0dVYx?=
 =?iso-2022-jp?B?UGRnN3o3MzR2dXpLeDFpNUJEd0tIQ0FKYlpNdkpsTUxTRmZVamN4TGdm?=
 =?iso-2022-jp?B?N3YvK1dRdVJJU2l0bFZrVnJyTUhwM2Z2dGd1TFZTcHJnMjg3TkVYL2l2?=
 =?iso-2022-jp?B?cllQOVV6MzhFS1FoUFJ6b0x0aFJ0WEs0dDJpZGpzTjdvT1cxa0FadjMz?=
 =?iso-2022-jp?B?QWwvaFZsMXJzeFludnU4d3BVVGltWjFFQnNoT3R2SGYya3Qra3d6OE9U?=
 =?iso-2022-jp?B?Vk9qaXZNamlsMXpBbTJITFRpa3JQb1cyS2V5L1BJR204OG1SdkNZdExM?=
 =?iso-2022-jp?B?ZWtsRkxiVktqVHNyMkFSZG0xS2ZTQ2FIUVJ0cTM3RmxtTHZVdHhCQ3h2?=
 =?iso-2022-jp?B?TVA0c245NFRPaSs4cEFJejJ6WXlPWjFhWmZBeUxJNXArdllWYVcvQk5r?=
 =?iso-2022-jp?B?SkgvZTdpdTFtZkVSOUJndml0bkFjWWVVUmRneFFnSytoK1hPQjNFQ2RO?=
 =?iso-2022-jp?B?dXVPa3FjdE43Y1FiT2RCb2IxVTFHRExOU1NEK2Z1ZlFGd2cxbE1jUGJi?=
 =?iso-2022-jp?B?aFVRMzFLelJSWCtmLzNTMjNKZmdiQnZiVWFKTmt2cklpcXQ5OVhRdGRJ?=
 =?iso-2022-jp?B?NXRDSHdyb0ExUVFmOXV1MnFVQlRTUzhwZnorV2xNbjNyM0ExS3lac2di?=
 =?iso-2022-jp?B?ZjZjcy9KNWpBVUlrUS8wcHd2WFVLaXlJOU1nS0RBcDlnYmhvdDlqR3NL?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4967.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03c6454-ff77-4214-398b-08d8ef207687
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 23:56:37.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AzFJBpIJXF5UoPYasyPP6247cXyYya2Xp1zzNSfGbvBae13jYMHK931TPazYwZ4NoWq8tGxGnJsV96fAwB1X9nKOOZjaibYruLQa6Xccag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6002
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v2oTVFJNIaiS03ih3TAZjGr1x4520388AA=
Content-Type: multipart/mixed; boundary="waZP5KhqLns1MFLLYJo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616630575;
 bh=3rWgf2mvDYgNio/76Ce3QxsEwutWBDEqKa1IMmXWOiI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gD66QBZIBknKE1PO0Fqewoce53ncNRpLgWXjOyDOXK4BhpboLEzIHSwZvK7YpLsNjW3
 QKtLmFxyX9cKjYBuIA6UzojYvy6Ll/ePDoQ+cvz4+LfG6thIiffLoNp43YifH+ckZDJKG
 WLQ2CLjdHVQbFxvD6uQr0+TATv6sAbUqdGk=

--waZP5KhqLns1MFLLYJo8
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D3&day=3D25&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/03/cip.2021-03-18-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Ask board owners(siemens_i386-rt/plathome_obsvx1) whether X.25 and flo=
ppy can be disabled - masashi910

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

--waZP5KhqLns1MFLLYJo8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6328): https://lists.cip-project.org/g/cip-dev/message=
/6328
Mute This Topic: https://lists.cip-project.org/mt/81591241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--waZP5KhqLns1MFLLYJo8--
