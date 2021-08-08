Return-Path: <SRS0=YXCt=M7=lists.cip-project.org=bounce+64572+6661+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322ACC4338F
	for <cip-dev@archiver.kernel.org>; Sun,  8 Aug 2021 11:28:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685A36101D
	for <cip-dev@archiver.kernel.org>; Sun,  8 Aug 2021 11:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 685A36101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kif1YY4521723x65ObOF2z2W; Sun, 08 Aug 2021 04:28:51 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web11.8734.1628422128250446345
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Aug 2021 04:28:50 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id IUWk05703A;
	Sun,  8 Aug 2021 20:22:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYmT9ixgdZcjQOHRzG4tTTBgWZ6XwnKwPWek5VYLt+xN6TM8GPb4N/NQEQq/HQ2mxeYu3eHGxWysEWIakTtf0eew3BxF410piNFN5awPjHPup7iHchNgA1unVOSwf/5IGjtrOHd7c4z6w8XHopJXA+CAwWYr2Tf/N3BcX+UyHkgEPOf48Yty4v+7anwYSsV7x0SXolRsGTxxil1Yt02iPv7vYsI2JWfyqZvoeaJ+zGI0MIFFTSDbGzEAIgTifVHnQaKddyiYY8CnJG4QT1gz2cvoVCpVdw5nR2yLUMhXyB+SD1SU9X6uupJHWnMb/VfLqh5sRrEq1hkmhiE26odymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xIM4eXVskLor6ocJWCMsjTedUp6kWLC1pcB7I+IT3I=;
 b=ky/qwbLw+DBgzdUNwt4sS2m9FDrkFG1hFWj7ShBQwq8GZQ1WZBcSu7EtCu8rkiDeCyDrZe+8gzE468EX/1TJDZB0goeh9WqHj393FiEjT1w/0rgoVLC+WcKskkslEdI9KVVgeMNjWeWcEZSFFjgrDQsX/HTx4hOYM+tv2Kti3yt2ON1zuGUq1ROJUq8oFtP8d0t8aUrccJB6PR1O0tG7ntJfVfLuFJ1MGkybADZzhaF6Ag6tp+oG0S1e0i+S4dZk1CbH2vWkgBz//KjotnLAdpjYEnX1d5uZo2psYyifBcUh+m0Q60AiB1KkrbSVxdkFA74cA9YV6LISooCST9ca2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3788.jpnprd01.prod.outlook.com (20.178.132.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21; Sun, 8 Aug 2021 11:22:28 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 11:22:28 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] lts-commit-lists updated: up to 5.10.55 and 4.19.200
Thread-Topic: [cip-dev] lts-commit-lists updated: up to 5.10.55 and 4.19.200
Thread-Index: AQHXjDhyvTKoqgVzEEK+SW8JD9RFh6tpdNgQ
Date: Sun,  8 Aug 2021 20:28:41 +0900
Message-ID: 
 <TY2PR01MB49728DBDBFC2B131C25FD1E3A0F59@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <20210808093312.GA4923@duo.ucw.cz>
In-Reply-To: <20210808093312.GA4923@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9371bdfa-48c6-4dec-5160-08d95a5ece5e
x-ms-traffictypediagnostic: TY2PR01MB3788:
x-microsoft-antispam-prvs: 
 <TY2PR01MB378846D363EA5FF55C69A1A0A0F59@TY2PR01MB3788.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 Cs0OveqrnVaswckpQ/bi3jODc7S/8Hef3MlAVUQp60iFKaT/rTeaZd7/BUQtoueQwAYIiKT1ThDq37hPOnCylVRW6NbKsn/UzdRR/zFmC1Qka6mRxV+9yCoZAgD679F3RQYUKSUjn+fd0dm6C5IQh5LM/epHMWzTlFUoLB927aFxNl0me8JdYMBy2JKy+0ZQ3yIP9HyHwVLDKwNNxIcOmCfuhHhfzy0AaaxdANwPfrMT+zVvWyBBG5RoW9whv4eLr50Rk7GoNywUQXw6qkuKDS+mmFld1becfBHIST7hrIMlDSQO/2pJUKXP6fcAQSdCBu/toi3O+wDbNZw7G+F/Xx+qzlr/izgmk2fHjhtw8IBN37c7P4WmDKbOOs8VWNHcBq3XjdDuuNIjq+BtMC3CzRNBMrgdf/4/jxmwX8Xgnxsz05yrRDZpI438yeC5nv364gsZ+gJsaqYetgvDwKlZLGghhsYWIaUHL3l5jGdz0mXtFhb+9JOkBtWgItx0aqzchV3/BYbY7kpsNgUXavnalAw7Sy6a/wAwS65nTTxfWlIYRR9iQMfonXHJ06tPrs17dl4C4n4StPwuhmfg26JGZzH/aa+KGiJ5cAY9LtIvZZPu6an7MQ8TiHFf2WqAryeOiL/ACmb5hyt6wvgpaQIQqx3GBTJhQh+I9XJEGawJ17KmqL7hTLHteGkdIfS78iH2fqHHUBMpmp/lGBC/h54qnVwKFWLkkbATs4DlDHea/vexGRXA+E/J792VBE0Rimea
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZXVWVzh6aVdWZXgzbjVCT0VaVTZsdXQ3NDc5c01QSjNPcVdUVXdxRERM?=
 =?iso-2022-jp?B?WnQyVnhFSUR3bHgyQ2c0VHZtNStJa1NXQy8yTGJFVjlMdlcySEM0MUdY?=
 =?iso-2022-jp?B?K1lTYVEwT2NzSkdvK0ExS0RVNG5sQ09YdlpxaThaTVZvdnMwdzJybEF6?=
 =?iso-2022-jp?B?OGZyeTMxNWJaeHVha1lxRDBhdFdxQ3UxdHI4bGc0SFNRUVZVbGljc25B?=
 =?iso-2022-jp?B?RjMrK3hKQWpYZUpwUnZHL0lFR3FvdGF2Nmh5dVp0MGd3WHQrTCs0V3do?=
 =?iso-2022-jp?B?WmxpSW9Ib3VsaDd6aGZMMmJhdlB1eStKQlMzZk8zY1pRdEF5a2dXMmx4?=
 =?iso-2022-jp?B?TkZMR3hDSVV4cVYvM2F4VjZRVEwybVo1NDU3Q1ZPc1p6OVdFME9MQTJa?=
 =?iso-2022-jp?B?VGhkdjE2MWlFb1JYVGhSVkc1SnFSYjFxVWFuelVVZlh6Vi9PNWRBWjRZ?=
 =?iso-2022-jp?B?VWJLTksrUlYxTFc3M2JremorVTc0a3Z5WVFKbGZva09qZUdrQ0xLY0Rk?=
 =?iso-2022-jp?B?Q2NVYUlpMEN4TDZaZlFIZzY5ZFcrUEFmWExNR01BQkpaRWlBdnF4K1hj?=
 =?iso-2022-jp?B?d1R3R2xlcmJIRjhSeEdQRkhYS05MbUtTaTZ4ZEMwZVp5QzVFb1RTQ3pw?=
 =?iso-2022-jp?B?VXdqTmQyUW1icjRNczIzMlJ1TVlDcEF6YkhRNjhWa29hRlJkdnY0ZU8w?=
 =?iso-2022-jp?B?Y0pZN0pGVGFtNnhiRjYzYjRxVTBXRGZDRzJzeGNNNnk4ZnNwUmdzY1Av?=
 =?iso-2022-jp?B?K0E2TkRKamJCMVV2dnhFRzdVUHBYN21zRXROWFZCb1piVEk0RW5ZVmtE?=
 =?iso-2022-jp?B?VUR2RGN6OVRjcnpXZHFERXhoRUVtZlhYSGJIaWE4Q081V0cwUDB1YVRh?=
 =?iso-2022-jp?B?VzA1a0dKZEQzQlhBaDcxZ2U5TjQzNDVmaGw4V3d0VERacTZBQVZ0RTdP?=
 =?iso-2022-jp?B?dWpacnRnNXlVOHpDcDZKU2d1SDJSSVBtZkJFOFkyTzhoTUNoL1Irc25m?=
 =?iso-2022-jp?B?RENPcC9KeHNRRlBJeUsrNjU0T0NRQkt0bVJxZThmc1FQUk54V1Y0WVlL?=
 =?iso-2022-jp?B?T3I0aDRnaDlvUDJFd043THU4ZytPUEs0MXF1QkFPbHZPc1dDRGxRNm9l?=
 =?iso-2022-jp?B?L0xFOTRHeGsrVVJuYXovVnBkTEZTSDRlWW85SENDQ1FudjBVWjRnYUNL?=
 =?iso-2022-jp?B?clNPYUdvVVJwQ2tVNVd5dlBwUHY2dDY2NXV6QlVtdkQzVzhsS1Z5SmU1?=
 =?iso-2022-jp?B?RzhjamZYWWpKUXZNQWRQTllXS05FMXgwVVRram1kZkJSajlEbUdJN3Zj?=
 =?iso-2022-jp?B?NDFaQ29XVityclpaNzc0OUUrMUpBVm5uaGJUQTlYU3lva0JsNU1DbHNQ?=
 =?iso-2022-jp?B?UjBQaXlOZTRsNDcrZ2FPSGR6U2ZwV1JrbnJNbk5SM3Jyd3c4QmxMd2JT?=
 =?iso-2022-jp?B?ZEY3UDYvQ1FNLzFFS2s5NTBCclNCVTFkSmJTdXRDdjk3d3ZnMWZWenBs?=
 =?iso-2022-jp?B?akxnNkdPTDU3YXRKOGxMMFlKWStsUTQ5MDZabUlaemFFdUt2aXdtcENU?=
 =?iso-2022-jp?B?azlmMGdoVzkxbVhTN1Q3YldZQWdpbnNqU1Q4M1FyaVl6cFFIN2RQVUQy?=
 =?iso-2022-jp?B?emRGeUJsYW9ob0FtWGl3ZFREdXZ1bkhFSU95Vlh0R3h1UzNyUkcwMENs?=
 =?iso-2022-jp?B?a3Zsd0lLQTJocXBpVU9MZ0VsTStaYzlmYkpKK3ZBcGFkYWN6VUQvV1Jq?=
 =?iso-2022-jp?B?eUlob1FpL2RDL2ZLdXB0czFYaTI3UmJVZ2wzZzNOVklyNVB4TWtsaFlx?=
 =?iso-2022-jp?B?NGh2d2x4b29JUXpKNTZkdVJsc2tDOVExUlhCU2h5aHdBUTdhd21HVSty?=
 =?iso-2022-jp?B?ZnpuZlBaNnpyeks1aEhIL0Rkc2pYa01mZHd5V1NXVG9Pak8zQkp6Y0dS?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9371bdfa-48c6-4dec-5160-08d95a5ece5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2021 11:22:28.4089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxqMRpVv9Pk6DhpvZGDOVKUwY6F0JTVJQ76/2Upc65WmjLkqZKB1GgAXPUN+RBYqmYxTVPmqqmjzsmv8eKv4GXm7VmgJx5egC5pSj5pQ+AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3788
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: i9wkDf92X7S70Uz6t06vu3VUx4520388AA=
Content-Type: multipart/mixed; boundary="56lYevwNkx2CLEd2ckLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628422131;
 bh=nDxbLqNmZCdyBx310fSfzL9aK0axR4fuUu9ISa2qvPo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Y3KEKrWr4XCSwgf4aZ09GBz6b7mvrKzaTLhDSh1tZAtmecegl4z3uhV4fOnI2xUyCvA
 h3jU+l3jprAorhMno5442Ces5eCTBRPmh/7hTaEaWnGAUsu7G3s8ZUwBcOip/dem1G9wQ
 AVlDPwtVYPhR+j1X9wLrr14IgjrgjjrGL6c=

--56lYevwNkx2CLEd2ckLC
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Pavel-san,

Thanks very much! They are very helpful.

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Pavel Machek
Sent: Sunday, August 8, 2021 6:33 PM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] lts-commit-lists updated: up to 5.10.55 and 4.19.200

Hi!

I have pushed updates to lts-commit-lists, it should now include reviews up=
-to 5.10.55 and 4.19.200.

I'm not primarily focusing on reviewing 4.4.X patches, but due to way revie=
ws are done, I have some reviews for 4.4.X, too. I'll merge them soon, unle=
ss someone objects.

Best regards,
       		  	      		      	       	   Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--56lYevwNkx2CLEd2ckLC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6661): https://lists.cip-project.org/g/cip-dev/message/=
6661
Mute This Topic: https://lists.cip-project.org/mt/84743932/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--56lYevwNkx2CLEd2ckLC--
