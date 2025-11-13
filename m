Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E36CD5BAC
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 09:21:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19845.1763025696435116473
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 01:21:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=LDnJMD/5;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763025693;x=1764235293;bh=brkmdgx/wWnbFB9GjCVUAovohAK7AyQTtyJWU
	zjWWM0=;b=LDnJMD/5EOwZv/IUt+edSn8DGKfE4A97cMoFlKi3sX9uT0W0joy2STFYbXUigm5Qfrk
	jHV9cO1R8aV39NJZoNAiAIDd7eGWYnwsZ3MBnAbY1LR6NePERyHUcMdHPUU6zlJxZbx+bySPnHm/M
	LQkhjjALlmyfhyWYl2tdhTTvB3zzrIC4s+EOiJZbd3Pcqz3omSsQihxgnEBbgkv56DlAiT9hL24uG
	mIo1+MjRo/oVO8C7+oiObBtSDu5V5LDWUL5rdUvxvLe3uqYiUs44Xls4myEdCA3n695TE7143l7Bk
	cTfuw0koFn81qF4sPoR0oSYwsP1Ux4z8SBBA9GHc1BNw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5AD9LX0H608340; Thu, 13 Nov 2025 18:21:33 +0900
X-Iguazu-Qid: 2rWgP4I4zV93OkB34q
X-Iguazu-QSIG: v=2; s=0; t=1763025693; q=2rWgP4I4zV93OkB34q; m=ExAA6w4FA4MpI5LpT2222iHFSU+ncmf2usX7gNvD3jI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d6ZXF1hK9z4vyh; Thu, 13 Nov 2025 18:21:32 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMyDfKp6dZNBi4gwF4ERbO6SisN4S6qnZ+mVCkoFDipaMLTSgA4ZNR9hDBpUr4k6kOOM/5CgNQRzKrtWYXOhSI+5sXYRRDaB37vkXF7cwqrUEcQ4eZz7TZAaNggXaWbC6JK7hnUgNTi/yRS07IA8yB5PnkXfJxwA7FhUGuxjYpPIMm2v+o6GK/fTzZRUz2KOA/RJg4BeGSgreFZCpxi0nTy5pBdKnMY/JJv7zFQ4Cpt88XCVbKqQ5V89W3NJLgxoodt81SElC7oYTJ5Q6O+J5xm6WEU1Q3nRvgzlue5/Yduf7pL2FWWoIlNG9yeRC+BlHe2ElETT/ymw8/l2x8UIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70poOLiUX79vBzneKoAUi1J+jhIkbQEc1ilnbDaffCU=;
 b=k9RujDPQDEOPqQn5MGTD6E6740yuyvmF2PygdD4S6xUAu+MUHPplKJDjrH+HVHd9o+CPJ4vv9EhvtDBjsTupL32R9jyWA3dM/e0BM5QnttOuyQ7Dk+y+ea5L0ytpexynihkExoONe4giu62JmSLoKg7zZ4HaeS4mBbUcrUIFChIasiRzLH+bgn6fGqbG8KkhzKfH0ZdJi8B6IerqzkMNKzFNaDsj24PRYDdFnP9JoqqJIv6BuMuvd6JBSAH3cz0HEbSg2e178+nhxa1eU+eHPRMXN5LF/tjUy0PrtIple7zVRA4k4WWj74f/1njVJ+/E3AOa840BekBsgju6ojanTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcVF+oJtXh1BBenEC51cP3yjPLfbTwUSFg
Date: Thu, 13 Nov 2025 09:21:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818ACD2CEDC192FDF53BC98CDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <2082e0ff-07cc-4d83-8767-21efa3e89d80@siemens.com>
In-Reply-To: <2082e0ff-07cc-4d83-8767-21efa3e89d80@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB17204:EE_
x-ms-office365-filtering-correlation-id: 948eb3e7-af0a-4963-e3b1-08de22960731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|18002799006;
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230040)(1800799024)(18002799006);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bENDRWdZbkJPbkYweFZWTUQvRnFpc3d1RUtvU1VrUGJUN09ZMlVlY3JZ?=
 =?iso-2022-jp?B?eXYyNzNJbE8xWFhXc3NwK3VCTWt3R1Nsa0ZSZnZ5dG1uMTlLZEZPTm1E?=
 =?iso-2022-jp?B?OWVUYlgzMXBZMnRTR05rQXcvbzFzRWNUVlZmeGVjNHpKZGY3c1B4aktR?=
 =?iso-2022-jp?B?OXp5M2oyQ3RMbFN2L2xweHhkSGszaEpzaEVxWGlHK2Y0WU4zSW1Vd09z?=
 =?iso-2022-jp?B?VkZ1VGRRRGpZc2pONTUwT2N3Y2ZhSDRvVW9EYUoxT1NpSGdOZU1qSElz?=
 =?iso-2022-jp?B?VG5mVzhBc2RuVTV2TVJ0ZUJBVlh5eVBKeHdXdG5VMldZOURiUEh1RjND?=
 =?iso-2022-jp?B?RHNwZ3BlcWNBaDNYNDByaUhzZmNLMGJnVWNDTnF1cUNCWFc5Z3JzT1hz?=
 =?iso-2022-jp?B?Z0toNlMzMDZKY0Z3SnVpZ2VXQmxQYVJIZEt6NWE2c2hJSmlMRHFCQ1dp?=
 =?iso-2022-jp?B?RHlPRjhkUEw3L3lXNWZ2cENhWTNwMy92eWxUZFRxazlpN2pGYlRkdWJ1?=
 =?iso-2022-jp?B?b2YwTzBWRnVDQjJQZkhkNlBkSW9JNU1pRGRCUzlpclpyT2VaYnV1Y0Yz?=
 =?iso-2022-jp?B?MEw2aDVVblRqakJHWkF2WDhvNEJ1YUdxR25CbXk0MmFLWllBRGFNQ0l4?=
 =?iso-2022-jp?B?N2Q2VHFSVllrZDhhQjl3UStPVWw1MTRMSUJSQzNlelFjRER3OFVVd1l2?=
 =?iso-2022-jp?B?NTNaaUxMWHJIYnowZUdTRVQ0eWIwTU92ZHBqbzV4Nm0zdXpqQW81cXp4?=
 =?iso-2022-jp?B?VC9CKzZTUzIrN2RPSkZXZlBpbTBMMzZGelJxYlJibnpvdlhXOHg1UjAv?=
 =?iso-2022-jp?B?eHhRaHMxcVArZzBiZmNIeXVBUExHWXNhZVhoQlk2VjB4b1hTUCtnbFdr?=
 =?iso-2022-jp?B?TitDV1E1WDArOHNPakFoeEZ3d2wrQUZHTHpCSDdpc3pBR3Nyd01Fa1BQ?=
 =?iso-2022-jp?B?eUNESW9zcDFmRllQMkhmOTl1OVN4RlpsajVlN0NSUHhIMFhWSHkybVB4?=
 =?iso-2022-jp?B?dllUK1ZXYzRFTWhncUlwNnpHdG15bWdzeXliVTlVcEtUb0NIV1RIUTUx?=
 =?iso-2022-jp?B?YlRsTkZhcnZIM2lBdC95OHk4SnpadFJncjRyR3hiODhYOTRwQ2dLOGlp?=
 =?iso-2022-jp?B?dWtSUXZ2dUlzS3JMeTZDaXlTd3pOWmR6UVNOMFBhcFBySExRRzhFTTh1?=
 =?iso-2022-jp?B?R1ZrMFg2bVp5ank4OEErVnV4OTQvQUVYdG1CTFE0ZnQxenVtdU9Nd3Zn?=
 =?iso-2022-jp?B?cVV2UTVVS3dZQmJtZ3ZRSVVBWlRRa2krWU5Ubi9sZy80ejNXR3l2cFVj?=
 =?iso-2022-jp?B?TzN1Y1hFQkFpNGp2cE9SZ3NON2ZPWFNlODJja0J0YVJBNzdoTzIzSFp5?=
 =?iso-2022-jp?B?bHBMNE8zcGRBUHhHb0xYVWliRXpXOUc2Sk5kS1FNTzlpb05TV3IwNWdK?=
 =?iso-2022-jp?B?aWtsb3FBUjJXVVJ5SVQyVlM2clg0Z0lseDd5NndWTTVaZjdTa2Q5VDdo?=
 =?iso-2022-jp?B?Q1YwdU9QRkJaZktqNGdWNzJaVnNJSmM2TFhjajBrQlduNjhvSFVReU5O?=
 =?iso-2022-jp?B?dlFPRG8vaU0wRzNxc1ltN3c3QzVoV3RXQ2FORnZsWjZLNzlmYzJBRUQ1?=
 =?iso-2022-jp?B?cVphZ3pUajFXNUtwb1dkNnkzUnpJdG9uQWQ3Q3ZyVkZPQkxDdHVPbEpB?=
 =?iso-2022-jp?B?eVR6YjdHdGtudENReUxxdUVHZ3ZzZEJtcExJUmhVQStKeGJWck9Obzl6?=
 =?iso-2022-jp?B?NmhtS2NQZCt1cXQ2UmdEdWpNMUVFd1IyWWpKQU1BZDdjbTRVeldaVSs5?=
 =?iso-2022-jp?B?SnBnUUkxMU5lY0F0QmFDdUxFRWJRTkVORlZuM2tTQkJia1o0aEdPQ250?=
 =?iso-2022-jp?B?eC9MTUt2am1lQVB2bTJza29hbGw2RGQ5SXNBMWY0QytvN0lXYVFrUklu?=
 =?iso-2022-jp?B?ZUQwZ3NIblA2WmFDVFVwMG5SYmVlSGJaekRyZUVRUGNrQ3VtMUhVajVn?=
 =?iso-2022-jp?B?aWc2NXJJM0hyUk92eUx3WmM1WllraEJsUW0rdXc2dTgxRitpUFVyVlhj?=
 =?iso-2022-jp?B?cnpjbzFVRW1Wa3N1elkraW5MMFVwaHY4OVNXV0ovNG5nSDJZSVBpY0Rz?=
 =?iso-2022-jp?B?M3RXWGYya2ZRWldsZGRCc0lZVlUwKzd3NDM3c2gyT2ZCSDhmRFY0NVJJ?=
 =?iso-2022-jp?B?ZW4rSmRyYzVTbVNXSnBmNlRJRUd1NkkyaVRlOGliZEFYQkNwaGVabFkz?=
 =?iso-2022-jp?B?VG1VT1htYWRKV3cyQjFNM0hVVU9LN3RpZlRpOVlIdmtSN0Y3am9pTWpP?=
 =?iso-2022-jp?B?a2tsenlOYTdjMncxbVJWMENLT2ZEaThkNXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948eb3e7-af0a-4963-e3b1-08de22960731
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:21:29.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UupbqTW5EXNDGEfBZCi75zvgGmbA63Zz+Y/rVoT73i6pNF2JC3BeGP7asoeTBn5RionnvwK9WibfubdCXLl1K6WPEM2uCet6qxbi/AJULYJSWkdZLGMTM2DDHsaWzpBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17204
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 09:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20521

Hi Jan,

I can not join today IRC meeting for personal reason.

My update is here:
  I reviewed 6.12.55 and 56.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Thursday, November 13, 2025 2:37 PM
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&
> month=3D11&day=3D13&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&=
p4
> =3D37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 04:00     07:00     12:00     13:00     20:00     21:00
>=20
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/11/cip.2025-11-06=
-
> 12.01.log.html
>=20
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>   - riscv reference board proposal for next TSC call
>=20
> Jan
>=20
> [*]
> Date the data is created: Thu Nov 13 05:35:34 AM UTC 2025
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Wed Oct 29 02:00:44 PM UTC 2025
>   limit date: Fri Nov 28 02:00:44 PM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
>   limit date: Sun Jan  4 10:07:00 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon Oct 20 10:22:11 AM UTC 2025
>   limit date: Wed Nov 19 10:22:11 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
>   limit date: Sat Nov 22 10:53:07 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
>   limit date: Sat Dec  6 09:00:25 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
>   limit date: Tue Jan  6 09:45:57 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Wed Nov  5 12:32:45 PM UTC 2025
>   limit date: Fri Dec  5 12:32:45 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
>   limit date: Sun Jan  4 06:50:13 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Wed Nov 12 11:22:48 AM UTC 2025
>   limit date: Thu Nov 27 11:22:48 AM UTC 2025
>   Status: On track



