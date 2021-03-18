Return-Path: <SRS0=jsig=IQ=lists.cip-project.org=bounce+64572+6289+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50449C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 02:50:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657DB64E2E
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 02:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657DB64E2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6289+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5o79YY4521723xMAMkvgn0Ml; Wed, 17 Mar 2021 19:50:56 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web12.4078.1616035854187379176
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Mar 2021 19:50:55 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id SLtL18603A;
	Thu, 18 Mar 2021 11:45:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfhqwKsoiFzBHH8/iV+kXi4jwI0CaTjZrAqC1fkSU2HOstW/nKcoYm1pd98pCE5NmS9pYCcbkIoEGClGGeVX0gSTf3yCArxjSZ6vgH97nZ/FW0nxrWPSjbSlswazAUVVZsg7SXDSnNbZEij0QAoypmBlFLUoWJmTuwn8o+JuBWJoKMqFHBQHutBJzgtbiGPOoSEngknkF5jQaPT1WyiS27MAXSS9aMcUS+CDMCtYb5ed9pGA/gsrYzSecsEtfuMoVoex8fXKVy6Db1j7QGKAdgfr0y9y+m4+mTsMnBCZVwHRJdNA1kfab26ZuJDyq+mE/82Ain2QsQfUgYP16gvDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ6mtRoOLRN8xUl34Dw1tNaNvhcmUXpZ/9cGwy3Tr7U=;
 b=iWCJ0Rjg+1qoa+hyc3iUnpYJQfx680W/IvamNCfmExKCwUAMEWT6E3VE1iRbL5Alz5x9/6IOfkCAVNAqQ9IuJ5H3vJqPL+rDSriKFEl1iw62CKzgc9E7poXa4Dx1Xp0v8EJVIw/02BqpXroYQmdtdoLyJOSAJn9vqWciS9oNtp7C3VXE/nJPdIkE9ykNaanB1VVsZAD5Kry0Hs8FhPFCi1zrzl01BSdNFlVAA5MuwDEp+vf8o+s+0WSpSvrKufbVBtYcQgwwGpKVbC/ApvGWG9vtWwbOyyzScqnZFVqt2z+P2w/BwRcff/T8Y0Lw342BcxATVWmilaW/POWZnT0B0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB6447.jpnprd01.prod.outlook.com (2603:1096:400:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 02:45:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 02:45:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcboIL5mO1sCuDBSCKZq7ZbucOPzA==
Date: Thu, 18 Mar 2021 11:50:48 +0900
Message-ID: 
 <TY2PR01MB4972E281920DEC8CA74B9B17A0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b33f1834-aba6-41d3-9f46-08d8e9b7d96c
x-ms-traffictypediagnostic: TYCPR01MB6447:
x-microsoft-antispam-prvs: 
 <TYCPR01MB6447BF57E16C7FC198B99FB2A0699@TYCPR01MB6447.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KuAQ/arBbEhgYsD/Junl6t3o8AOO9fCXL7s9Wo4SlZ7addNQ1GEGY1+de71i1CBw3ht6ZgLEhUH6XJcS+0SzOBr79Qdfy/tT8lV+RZR10y7STRifgZ/rBupMlQ0e6b4kq8g8holCGS8/b37OaTEy1G7rFoxb2+356kgwYddsub+YzpEIm4cFhVqcuUnC/JC02zBX+gGcDcstNhkZBrGnRkfVst4WMbChZeksLrEkr4se4sMZWduKjUZZM8Hb1u7lcjy6xqSWgvbDVr8MMOLKyq6B6wkVb9kZvEE9NgbzkwYtlnXb1VMSXpQlcjkl4Q24gdyhUz8T9acYFHs1yr/lV6dDenlEpUnJS1n+ojcNVNykBvheikA6/2GDCZHyyepwC6EcDyyGXhfJwH/bIAj0c9qxydzH+isIuoL4HEjEBaajDpBggcPpqmetwPLAqZCNo1gLwVcEsc3Xi11tr6j+VHvG7Gw16KlrGu2hnpGx0x3b/z5YZIysnvrHYmKl6BgCiBWxCYMjBsNb7waMHlhMCZLTrTTZ4r4DYqChlZdoIb3KudESi49/TNfEbUo/Ilhom/poHG8nQrVUwyZ0OQstNj6w8TRRA4QyrN5t8PLg54T79pu5qBBab91fzMzUiFiUd0pqz6oTkHntKNNUBN493xBRbIhiOe+KOvMCMhthokbykZkR52Acwo7AwSH5BjRHTkOGNeZoRI2nrWFe9yOonA==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?SkZFQTNVN0VHcEUweG8rc3BVTDBidzlvY3FSZmpZcldFQzNOSVdUVHA3?=
 =?iso-2022-jp?B?U3FRd0RETnN0M3ltSGtBQnBXMXU0OTFYUTRPb1hWU0R5U3h1bDZmakQ0?=
 =?iso-2022-jp?B?UXFRdEFScmltUVdBREcvbWdJN0NhL1krQS9qeWd4SlJtWkh3bWZsMWpK?=
 =?iso-2022-jp?B?QXl3YTRxVE45RHZacmhmS20xMFQwQ1B3QlR2ajZpSDRXSnNVMDhUZXp1?=
 =?iso-2022-jp?B?MDRuejVxSnRzTUwrdFdVbGtDQXhpUitYdTM2RGJXWTIvNHdPTkQzUzMz?=
 =?iso-2022-jp?B?NTFKV2k4MXNuNUE5amY3Q0xIMHR5S0Q5Y2dGams3eVU3SFNUU3JBUjU2?=
 =?iso-2022-jp?B?eXQyaHNDSEZPWCtLSjVKVFZ4Q01tM2EvTS9KTUx0S3JTME94R2hKU2tl?=
 =?iso-2022-jp?B?djdzVEdZVnZTQ21UZzRoTXNTV3NsRE9HRVltQW1HQUdobkF1Q3hDazl4?=
 =?iso-2022-jp?B?MXdEY0xyK3ZsTURHNDQzYjJrakw1dFkvUWphenZPZ0lLNVF1dU1GeWhC?=
 =?iso-2022-jp?B?WStsN1NDV1I1TFdzcDRod3dVbXo1aktXcWZ5c0w2L2gvNjZTeEx6Vjg4?=
 =?iso-2022-jp?B?bVZNZW1kOG9sdTdqWFV1eXltcStBYUtLNEdEV2dNOVhCc2Jha1hDelhU?=
 =?iso-2022-jp?B?dkZGWExUY1dydVI1TGx1RTgrSzY4M284ajdaSFNRVVYvYW5NOVdiazJr?=
 =?iso-2022-jp?B?a0RGOG1UQTdQcTBicExUUjBnUU1rc3JBMXBIUmdzVmV6VXdvSVlMQjcx?=
 =?iso-2022-jp?B?akV6dEU5cUdUT0l1UkhnR1VjSTg4dkx4SnlsZ3hRWTh0c3pMSHE0R0VO?=
 =?iso-2022-jp?B?b0ZWVDdtbHB2T29XbzltbVZaTk5hbkVwdC90anFuU0dhOGkrR0ltaUhy?=
 =?iso-2022-jp?B?WnN3WkpPeTJGZ0xiUE93amhpejU1WGhzR1lSTlkwUHArWGltVVAyZ0Jx?=
 =?iso-2022-jp?B?K25mZ2RobTJtNDAzM0lmRHZrUXFIMDB4RjdFSU9nUWJmeWcyQ3RqRTI4?=
 =?iso-2022-jp?B?eXozOEJ2bjNtMWM1NXIyYWJIU3l6djlqZVM1bElLOGcwOE5GK2M5cVRZ?=
 =?iso-2022-jp?B?eExRZVRvQjVkdTVYbnd3cWFPYWt3UWhlTDlNTzF6M1hLUEhXUHpxcS9N?=
 =?iso-2022-jp?B?MVpKMmRXUjk0aFdCVG9qUm16OGZIeVQxZVU0ZDJkckpMbTg1dXlmUzcw?=
 =?iso-2022-jp?B?c2FtME14dmpwcTNDRWRwUmRyUzcrbzl6dDJid0o1VlN5WnhaZzZQa1FK?=
 =?iso-2022-jp?B?T1VoNzl6SklGMVl0RTM2emZ3QW8va2xLakVEU29KT3lUMTJDL20xWjRz?=
 =?iso-2022-jp?B?YnVjSkZOUEU3R3lzTlNQM01uNGNLVzVmNUtpNkh2RzRBMG9tVElienZt?=
 =?iso-2022-jp?B?YVB3ZjRYL1JveU83Rzk0cG40UnFFSWlybjQvOUpXcDcwT2h4NE55T3hN?=
 =?iso-2022-jp?B?UlZWRTlZUzRSWWQ4WFBUckg3WFNscmY1VzY0cTBBaGhXd3dkYkVZNHo0?=
 =?iso-2022-jp?B?TVB6YmxuK2N3WjAxNlFFaG5ZalhDUVVoUkUzb1praUlqRUVnM21RYXpB?=
 =?iso-2022-jp?B?Vkh4OVZSeVBtUnFCN2NaYmJOY0REaVduM1R3ZnRUa1ZxRGlqS1VTOFh4?=
 =?iso-2022-jp?B?RFgzNmI5NWFoUzYyNXFNWGxDc2tmS0lPUm5lTEQ5U2dmTndObzd4MlYw?=
 =?iso-2022-jp?B?MUxZakpCRGV4L2xITUY3SE9HUkIrbmNJZGQ0S3llRmRreWNTS1VjQ2sx?=
 =?iso-2022-jp?B?MkRrc1EzZjZxazFoeE1uSHBmUysyMDkwQXdZeWZzTUVKOUVsdGQrV0VC?=
 =?iso-2022-jp?B?b1p0aEIrU2RpS2lJUlBMMzNoS3hnaUdIUkFhWWRXUUQ5SkJVQTU3djlL?=
 =?iso-2022-jp?B?dm1iZ3hsV2JDVWRlZ0I4NDZ5YkdBakZyTW9aQWkvSFlzM2ZoNFB2WVZJ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33f1834-aba6-41d3-9f46-08d8e9b7d96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 02:45:10.8207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGSP0kOq0MrzNsXOEjQz24TdyMOzofn6QR3LqFp7VV7I0lSEOHAcpP4le+yWdDxNsneaNXP/fiibHHiOA74zdpv+Et2jxU415juY/QHARzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6447
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 62VDUlP8fsFIzUxsZaIVwpN7x4520388AA=
Content-Type: multipart/mixed; boundary="RLCXc1GFkpxe9pF3JZNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616035856;
 bh=1+PfFhBpTP9odkYWocUBXWp7RimNZEwJb4khKi61NYo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=S1ZnTt7ZVPCT28iCE/YW+L8Ul9Pt2XxrPfOar/miy+tpYlVJJVuM/GuBGgHRfhKzRWZ
 BQH4f+rqjn55rdPZ2tzuKcTaEoj5YtlYAF8iRDkoblHXwgA+BFnP/H/LkxRP90j9zD4ps
 T1qxaAEUrWWstZpLmA4YDLBCwMaWtTi10ak=

--RLCXc1GFkpxe9pF3JZNS
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D3&day=3D18&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/03/cip.2021-03-11-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc

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

--RLCXc1GFkpxe9pF3JZNS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6289): https://lists.cip-project.org/g/cip-dev/message=
/6289
Mute This Topic: https://lists.cip-project.org/mt/81421400/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RLCXc1GFkpxe9pF3JZNS--
