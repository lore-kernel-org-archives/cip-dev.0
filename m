Return-Path: <SRS0=gGgr=77=lists.cip-project.org=bounce+64572+4801+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D633C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 00:20:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5792F206E2
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 00:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C2tIHhbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5792F206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4801+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YeEGYY4521723x6WQm8p649K; Wed, 17 Jun 2020 17:20:13 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.133])
 by mx.groups.io with SMTP id smtpd.web12.1993.1592439611458466966
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2020 17:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6FAwgLhFSXF1P9lVCYkvnA2sixgRdYTswFoilMxQjP+sljrbVP5SXHCb9uJPb6+92gA6n+bjxBLqWTHzgYvtenV3CrqIaJZE4gC08S+HrzaHliW85iKbjYAQW4NZOVoWRVMuzVnSnW4X8E6Ek5xaZ2iqMA3PaRWJgwrAjJDMvND+e63D/hIeZbg1OubEof/zjL9H5TazIdqHzjzfdfhKXu/iiK5U1o0ZxQP6AuEfsJGv+KZ7Gd8pgDY5g2g/Fqrbqi4rAOaqSY6mjTZIFAj85YkStkp4crv1dQTuBHURoiOoY29zO1ZwQ44M15NrC+bCEZIEFcUm7do4pmMoE+0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbM0GIeeVbUVZebpbJMROgUhV1OVxbvQeE61Al0M2eM=;
 b=WhrSqqY/kIXKsympEWJJ09RQuFEXZkzUeTl90QuZF60cuzDP9K3TqVDVRhomK46AsUQ0PXglWuydbkj4Gv3PedVOmGFVASoKzpWVoM2ecUJ8b3NA1t5LmIn7/bobAtapz1U+YsZyBbwQ+Xw8Lq+nE7fINJgp0FgU/zd2S0Q/3jAWrCFu16d8FxEONBpG2a8nM7H6ruJvDB7sBtauRUQMZ9k6zlyrk4mGMmKpVDjE31XmU8ihtRA24tHbgQYNJOT6hlZpsXjPoj7e3ieOgSywnNuzxdBtX8oBghCvt1zn6Fm8P0sr3WonJ3NVdTyNZe4X0/rLIBpTFaUMz9GC98YZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2762.jpnprd01.prod.outlook.com (2603:1096:404:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 00:20:07 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 00:20:07 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZFBivWuOLGgeYmT9uB8s67CZkn1w==
Date: Thu, 18 Jun 2020 00:20:07 +0000
Message-ID: 
 <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aba0e877-f8f4-4c01-144b-08d8131d5b12
x-ms-traffictypediagnostic: TY2PR01MB2762:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2762447F487880DCFA22E2FDA09B0@TY2PR01MB2762.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 zjbyKQtHUzMq88LJIycS/+REE0XgqUDB/9MbQFihXs4jxxuu8nmx185+1cct1pxoRgET+RsyZ2E1MATLynmFwnB7gmmr7xr/x5fm6E+3/akA81ao3I9EdL8igjxpHhfMumso2Oel3i65McwqiuFqP2EdBCT0PIB3SJI9cStjm6sgPOAjcMqL4/RLQAB3XQ7oilLdzbzZkYgM7qX7NlMnMYVewIN5DNEAQkM1YJfE2r7K03pKtLOKoDW6cDNPBSieXf66VbB9S6ugI17hF1KRU/bz2QDT56WxGBqmDDuuVEr3GBko6w0oycZmSnY3DsEwsTCipO4u20JytK9NDkZhxmRAPO9KKIcAW+a/EXZiRxI17a6MHPD4usRUY9ki/8lmYUGymfl4VNL10onIz1clFg==
x-ms-exchange-antispam-messagedata: 
 MoOGIq9bcZW0wxxaoBDDR/FpSQPAG4LipSFIAH8SorJuK9VB4F5FNOmMK921raLgGfwRMhHkvIGQhcpSQ6J1X5fn4Z/7PzzrA0XtVgzU6qevVBtpkbb8d8jOqOOK9GDy6+AVJqMX/wj1Egd+Bnw5/G6+diUV3aMqr6Xfigiw7jwFLFBDSFe4/I5Kmzq/cTH8N8lOg6/QuJmV4AvxMheMa120K3fEHaJvTenwDoNrltJMmDwBndAbz4dE+a85JbvtqPymXlyfzSqHYS8vZNj1eop2W98zB7T2xw2naCAMTC8vVRPniZohT7aBFhqz2GyMW2CFZwxCsOi4M/hZ8kqpiCaJHMOZMnHo7Ng5U/jz3Xd/q2682otnSq3ZOxegY6a8H7wSoTlhb36SOejvmyy+FXNkPR9yNX/mLt4NpveaxgrtuSP6jsBpUtVde/AdofEEgMcGSgOT1ApgKjSvvOKg6Y4ZDAWJzJku/9SPD0/Ac4AjE1364M2MngN2hvFhbL+r
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0e877-f8f4-4c01-144b-08d8131d5b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 00:20:07.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbHxlBusCpf2qVCpeIoTY/VzcaIX/rFPLT8NEHe9kVn6Qy1S1QeQ+HN51mn3XcxpJFG2Znel9OZxFsA0qSirkdXGhG5NCLpQ9Jx4QDUrAHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2762
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7HIOAeJy1lDzGVtHuqppAs2Dx4520388AA=
Content-Type: multipart/mixed; boundary="SybkSxdP3RdCd7O7efsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592439613;
 bh=8XLM5bgvF/lqUNaPbo8Qj+qjbx16eK6xgLqNnMjt4G0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=C2tIHhbnGV1c5h6tbDveiO+GQCCmt0xoymUZJ3kRir31fd+T+erFZMflogmCvj7qp/O
 1FMMol1eqHPMPgY0PKsie7fbfnI+mO9X7tLP4RWwGVQaqL5WsigQid4EXGQ8n1L++JdCH
 znDZeZQS/uBnPZWQpG9ip4q+7cw2irPDWPU=

--SybkSxdP3RdCd7O7efsf
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D18&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-11-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Ask board owners to review reference platform configs to optimize back=
porting - masashi910
  4. Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - iwamatsu
  5. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

Note: The followings are 2020 Kernel Team Roadmap stuff. If there are any p=
rogresses I will report at the "Kernel maintenance updates" in future.
  +. Strengthen sustainable process to backport patches from Mainline/LTS -=
 Kernel Team
  +. Upload a guideline for reference hardware platform addition - masashi9=
10

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

--SybkSxdP3RdCd7O7efsf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4801): https://lists.cip-project.org/g/cip-dev/message=
/4801
Mute This Topic: https://lists.cip-project.org/mt/74949757/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SybkSxdP3RdCd7O7efsf--
