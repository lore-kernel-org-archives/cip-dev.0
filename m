Return-Path: <SRS0=wccr=AT=lists.cip-project.org=bounce+64572+4912+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA103C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151BB206F6
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bcIOkRPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151BB206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4912+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lMxzYY4521723xEmfZVLbnTd; Wed, 08 Jul 2020 15:42:40 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.90])
 by mx.groups.io with SMTP id smtpd.web12.280.1594248158578135263
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 15:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exv1PIp9LySaxTqzaQ9koem1242Qr0lqTvV33D2g4RL5csMMHUXd5GvjDVb8mDSfD3FH4q4nh9AWXU+flI19JvvaCPAYo82ofVKTnTEbXMwZCASM2SOLIgnQO1AoyOfIOtAxtquB5HKAW+hLhuhXMR7kxSGC2lCnKqDP1aeTzsv4zC9IfEBr9vlRUMS8Ap06012fUD6sU/F5yDbq7xOj5PYHuGQifPf8nIWkFsIl7lFUVNWFJTfpiV7bpIZLhNMdlQjpesiDOiIgf8FlAS97RVkEo3z25PBmypOon9Fm7AjwrKgiLkepfNxxG8m1fMtT8nYc4MVgYWVs3ZP38QDWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b98WzoB7nQlN2HZ44JWu/1WVEdeZ9naXRGEqPotX9MQ=;
 b=X/c9E11c2yaNvMeyqaQIbSHeQuuzack+MWHGSAmh1K3zhQcWMwLii1it+urlZH+7MasO2qCVcNhul2uLPKtL8vOUEm8opSQrH0zfSb4yMdHX5MUgjNKEma4vd9f0/5xJKkV/fZy6BDzGpoh9TIAk/t5iqhlLPVwStlwgHMmBuZZRBnkmi4lwHpbedRRtsoF6EJt13Oc5AS6tFzWqUccf1Faks51hJlce0JoqfFv5MjqiNjMqbYmkgyYZevwiFvdL1ZQsm7MSW3wEzvwtGqaBZbK/u7o2MlmtEgO1LUua5rR3hYKjl6Sb86dFdib/wK/MJMhAaISJkp0iIS05MuFUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5375.jpnprd01.prod.outlook.com (2603:1096:404:801c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 22:42:32 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 22:42:32 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZVeQcDWxsFqQg+QZKbWdHglVCspA==
Date: Wed, 8 Jul 2020 22:42:32 +0000
Message-ID: 
 <TY2PR01MB4972D3A51538BD7A8477772FA0670@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85462ae1-1c65-4d8e-9b8c-08d8239033ff
x-ms-traffictypediagnostic: TYBPR01MB5375:
x-microsoft-antispam-prvs: 
 <TYBPR01MB53751929E064213A2B289E34A0670@TYBPR01MB5375.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 02iwa0MhUebPZrrmIqBdUdVk5D15WpDo9qjxZVQs0WDdtIQ48qR6KPyayxh690BZ4/HgJhWr5ixeNmQYwdfzOxeC8MBCx6jIUICmeGDYUJUwnelQ8E/CtTPakFoPnw2x3mLl4g1lQ5sm3rz4SYCPakWsNx8lbr4QTjgx52O/crQ3ls25nbx4WaLPhuLIeFWIFb2TgX1REDXhyFC/5ZvYGM0EIH0f138YsgpDb/v9WDJ7lJ46e5qPxe0LeNe6zRW7kUx7bYzeHESwErsONZA0Q/DTWGRUHEHw1qy2ypV+cr8LmUrTixFwH1jhdM4FMBXcviIV/7vxGDXChxlGmnh0hDEvpvT3ornmA5vc2GJ+IEIJWNF4AopRwAZkTAmoHrgO/tqwDJCLW9BeCB3gFsFDbA==
x-ms-exchange-antispam-messagedata: 
 PgSqWLTJnnLvX49vAIKVM233gz1Dm6rAPUr5ilKNh2E/148eOl+O+1hqzG2hK71GxSflGnBl2IzI4Vt6DsUOhZQEoTBC8jdmscGFkfog+E+Mi6SKhdC4kN2bNitY1OK4rbam9VdJJ5qDi0iHp/7j3aOvLq36Ss2bmOJ+FVlNK7nnZ+rH/uJ1vUY3ZwWUl0Ig/6DvQWzRGVkKtU0ZXGK87MESRqf6Xhl4ap8YeZQn75RVLvewTjdrOpArH8+y9uhvzA1C6WhG+fEAegW50ioTGx0ajuSzQ8OWjD3jFTouuF7p47edicy9UNXhYZuChjtYwIlIw4Q3sPaBG+Eu4MqmPP2vdUoDpmFPspWZsJoxLGIeV9QOj8bS0E204Z/GviSqsOJt0kK/WU1GxmxWL9U6AdXisYBN8ul+mcF8ZrElrxeJzvXEfhyikvwTpMPOzyxzu/pM6OZuVoUkHwcLthHBCNdE6aB7fUprPA8S9E7gBMMIM75NbDOX4+NaURQE9i4h
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85462ae1-1c65-4d8e-9b8c-08d8239033ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 22:42:32.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Bnmed1WyWXwXuWX4/dgjeE/kM66jRQ0Lk93QwJ5fLXUqWYawgVdd3yS+pk/z/LX7v24TZq/r1anTXYJNqGv3I24N7uNyWas2l9EIkMuytw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5375
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: za9efdBnxxNboGjEpwtWzLhVx4520388AA=
Content-Type: multipart/mixed; boundary="bv1BdazfAF4veQWuSuJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594248160;
 bh=1ib5DAh2e1zocWrjkj7XfX/zjqLZvZ9jKhGq4LgOhhI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bcIOkRPvwxfjJBH5XCvF6IDHiFttZJKh7RtwagPMMncn7DMUIwqAIL2oNHr2tFMt74L
 ogvBZyq+OybudRLN2Z3dJAJMq4OdtutQG10FbmJ+jOCSxlwEaMJszwaQ1qTmSM4RUV3qr
 8gD1IqgbBO5wjgUg0o/W7vnfAdUM+XgX/4A=

--bv1BdazfAF4veQWuSuJc
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D9&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-02-09.00.log.=
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


--bv1BdazfAF4veQWuSuJc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4912): https://lists.cip-project.org/g/cip-dev/message=
/4912
Mute This Topic: https://lists.cip-project.org/mt/75387533/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bv1BdazfAF4veQWuSuJc--
