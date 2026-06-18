Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82667CD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 07:00:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13863.1781765995027073736
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 23:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=nOxUkHK8;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1781765992;x=1782975592;bh=6otsrU4+j0uXqpw2rhR/Cy7V9WYlSVwWmoJw4
	zN0Y8o=;b=nOxUkHK8m2cwrwJjpjuYj/xKjo4fHkgu2bXZxwZMUKDITDZDfJgvhUHs0TFrHwcS4tJ
	P0LIqg0sQrfbibZj0egbRZQuvj94toBAezF4zOjKhNCy+f6+TP9juuIbzTYkPEIG+U5/tXJPV1DHK
	JqeeKqquXml8YlQ5VrycYwdVAXtEITFIEGo8wt/aEgK3msw/CuoGYH1+4shOqWiGIPcwPIHYY8Lml
	KWexve1/rkYHtaE/VRypvdpfw/A+efkjDGg/PKv5ryJoKzuWTa/ODrJf90AnLvXeIfzYEwZUbZ8eS
	Kqt1N1yzN+r2LNcmtuMn9SNJAIoFTO7rpx5M71DP+IPQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65I6xq3x446612; Thu, 18 Jun 2026 15:59:52 +0900
X-Iguazu-Qid: 2yAbL1s9gZ3bZWwgaK
X-Iguazu-QSIG: v=2; s=0; t=1781765992; q=2yAbL1s9gZ3bZWwgaK; m=74ozW5ZI34V9Oq30rl/XCnjMNlK9rGdUXsFXChJ8314=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4ggs6c0hjnz1xnZ; Thu, 18 Jun 2026 15:59:51 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dev18FW5/0lAS/1MUqfGf7a54/I/N+F6NO/xI5QZJZ6ii1UUyxrnXfTQ0JZDHWNIKFN9QCmAXrN2g2eV4o2WJGeikA9MOAJ629s8x1XWy+q5IXu6OLzVa5hzNJaGvLuGuX9uEZSiOF53RkaZQkWb+mECg7N9YwNaa9bk1K80CLJYhZjumCZ7ukYoit3cnMHZYo6yYB/zBS/d7nHnjMj7JAFK1UYZKHfQcJmixmIwvENQrCXaoAFEgkUjPVNx/un//2cCJ0+ajDPB0VyoxullcHft4tVMwQ0tEqsxSanK2K5NJRQmDzsPsE1uKxXOVUsY5ImWWy7ngKgB+y5ND3Ngvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjKTBwgCJDvIffQWlAYASVFucTuF5PIJM+DTyavi+Jo=;
 b=UIxOZOMnmpvVxrYdVQR9wejFO63fWpQ6ET4+KOHq2qruu4mclSOdkSgdPr0Rzu38SXYI//6VVGpV8//89miHJrqrrpLCaDLDf7Eb63+T4hiByUMXt5KxQSG0tdP+6yJoCAFzmd/iHQVi+EtMIOPCHdhtifD0pZlNDWNxohPNh5DB4NR9+sOZXBtyTwnDJ531kwfVPEIVcbHgGLSN5FQNX7RNYEW31OnnUFXMWauryEmVhRf43bNVAOhvTxsAOI2W2vWZWIvnY87A2DTS0bJIntzgjMJmu9pWhTw/Z+k5mwYguvIMQpaXViKTcJgDUP9at8aqmtKoT4Hxnln26fG4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHc/t9CRwPZYNasfUC3OTuY7K79ALZD3uFw
Date: Thu, 18 Jun 2026 06:59:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808F36FA3048A7E3D9924FFCDE32@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <67675b0b-394b-4409-8462-a3bfbca20e6d@siemens.com>
In-Reply-To: <67675b0b-394b-4409-8462-a3bfbca20e6d@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TY4PR01MB14783:EE_
x-ms-office365-filtering-correlation-id: 8c16cfde-d873-469f-ed39-08decd07304d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|18002099003|11063799006|56012099006|22082099003;
x-microsoft-antispam-message-info: 
 LNJDvtT/Na9+R/OuWDfF34jaoEJ98JmSHmaXR5gVt56+9rFjYrdFeLE8VooetG6AGbnZjE4mrzV+fvRZJVi5DNaG5YH3z8P7hLsfO4a9+kZrRdt9E/jUwWb6/5kYkNCYoMbCAEsT6u/6FvjpCn7kBL2903z+Uvb0P6jg5FFSEtzWn4/qsCo+HEnEcYeKDnYnTrmtmuvoch3Z1UvkoHxUyeAZ6ZqjTzt82oYlw/wDepur/B5MkpEQYduT9Uokc5e92dNtO3V30MKGID6EOWE5uhZBr7kGHm95KNztJWPWfF0FPtCY97H3s7hoY1K2BAFitQZcwE7IKf7qj/bFzw7xBAWjAVCfB9in88ZEBZaz3ZuMcfvMJLhm2JeKTu7JGEzCTiG/FBsskOTWfjtxpfewdQ7mngTOEnjUV3CY7GqGF68qU7ikPe/RsrY6BLmWjiT5J34yyrDJfqx6RrYNtxEHe+pTPstrmTN6HJkjXn5MRpG7rnG9dQ0YQmpZKeBqeJYfAahG557DaycXr1KoMZihmOOWX8zRfanVsoQK0y4CDXW4n1rjwKHWicD9Laku/T3Dqi+zwiPCBccpyspg+7ef9ocmvUsif2UMjba6IGzfSy5kZgDsUvHa2nwcYxmEiLDZLTCKASUg2q9r6bJ3gfAtRljgGshPzuhjosKPASudQ2M4AHiKOmwC+cxonEpPmAfL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M0VreVQ3NURyR3hHVHI1N01pZThHWFVZWUpja0t5bTlsZTU3U2tWTzFW?=
 =?iso-2022-jp?B?TUVMODlBaHBoOEJrcURhSXNKMWpnRkE2MDU1OTMxZUdPcyszakJsSjRH?=
 =?iso-2022-jp?B?WjBmcXhYU3hmcGl2aDJtK2N4cjJodWtadm1EZlZqMXhrc2lQSHFhVzBG?=
 =?iso-2022-jp?B?N3c2YTlMTlZIVnZJRkdRaEFGKzlIVUZlanJ0cjRyRzJUclFrTkljMVJR?=
 =?iso-2022-jp?B?QVJvSXNSZm9BTUROUjg4bENHcXBwOFFPaEllelJMbmI0blhUTlBsRFRn?=
 =?iso-2022-jp?B?aVpXQU5CZUNjazJXd1VRVko4ZkpxMXFkNmFDVzQvYWcyODN3blZWNnVB?=
 =?iso-2022-jp?B?d0JPSUwrczZ6S1dWZFpZbFN4d05HTGVKZmRvUnE1bE5xSHVLSFFnSnVU?=
 =?iso-2022-jp?B?eXdtWnpqNTRTdzlwME9ua1dXeFV0aEVrT0RqYjVrYzVBSGhNeHJJdkJ6?=
 =?iso-2022-jp?B?aHFhODVlWFptSkRoem1jcDJ6ZDJSNENRSTlleGhiekFEc29QdDFIa0hB?=
 =?iso-2022-jp?B?MllQelVhQlp2N1h4S1kvZksxQ3N0WDFyZldyWUluS2RVRkxVeCs2M1pu?=
 =?iso-2022-jp?B?RU9IODNQemFXUjF6MW5ub3d5RjhEWlNjaHppZFJVOEZ3N2t3eHVReWNl?=
 =?iso-2022-jp?B?c0VNV1QrN1JDK0E5YmE0bVFZTU1mcWFDL0ltb3h2bTNzUTdkWTZHSGZ5?=
 =?iso-2022-jp?B?dS9USVhsTFE0amVUdzVGYzZLSU9IK0xWUlg2MXpMMFpoeXFIQXFzQll1?=
 =?iso-2022-jp?B?YlJIaVRiUzhjNkdiN2drWVpYK01oV0YzK21xU1BnM3B4b1U1d1NiSVBR?=
 =?iso-2022-jp?B?N1llcE1waE5VNUppMGptVUYzckdONHRxTlJEd0srZU81djFxTlFBa1No?=
 =?iso-2022-jp?B?WkRLL3krdlVIRjl1azJGbkVlN3lSSHFSMHQyeWpNZXZFT3dNcFQ4L3hQ?=
 =?iso-2022-jp?B?TkVZMFNnclZvNzNPN2V5ZDI3S21GaSs0K2JFMjJzbzB0MXBnb0lBK0Fr?=
 =?iso-2022-jp?B?cXB6NU5HTG1XMnQzay9hbkphWm9Ya3lRdGIvMFBaVjhXWVJ5dURyeXgz?=
 =?iso-2022-jp?B?MEpjR2JaZjB2WjNGNHRnQWYyMUtWZHJQUDZKTnZyVVNGelp4bGFWQjdM?=
 =?iso-2022-jp?B?MEtxVHdvbkFVVG1kQm1hU282c3RjQ3d6ckhqQ09saXNNclg2RnFqSUhD?=
 =?iso-2022-jp?B?dEZDTDRQSTJla3hxc2Fzakhkd0t0cjUyaEVnWmkxcitrL2VYWm1UcW40?=
 =?iso-2022-jp?B?blhkV3luUU1PN0NqUlgxUDJQOHZxNTFQbExZU3B5RlEwV2JTbDBhQ3hO?=
 =?iso-2022-jp?B?TC9ZQVU4NEYxbWlrZjhvdVZETzRzVktTZzdEQ25VMHZGVkE5cFgxRFZw?=
 =?iso-2022-jp?B?cnYzUHlWSEZPL3hFbjU1clpmUjFtc1VaTTg3YU5yb1VvaEY3NHdEdGwr?=
 =?iso-2022-jp?B?R1dzNkZnTVQycnFxcmpNb3J4R0JaWGtSdHRab29kRDZuY0Ntd3E4ZUdT?=
 =?iso-2022-jp?B?MENqWkpRSk1tQm5zbEtUSXcxcnl3aUMwWlBoRTdCSjVvazNFK1RLT1hn?=
 =?iso-2022-jp?B?eGl5Q0FnVUx6ekJMVHVaRmVrSU1Bam96YzFNSXF4S0YxL0xMOFN5NVRl?=
 =?iso-2022-jp?B?L25HT1JhYmZGYU5rYnpwamthWFA3YlAvYmREUlhwa0RFSkxJV2ZoaHRQ?=
 =?iso-2022-jp?B?dmxtNE40QWdXbXA1ZXhmZDJjanU2MXB3a0pXOXJvYzBzM0N5dktoVkp3?=
 =?iso-2022-jp?B?TkdreWpPNmZ5ZFhHNUYyL203L2d5MWVkM1dYZmxoQURkSjczRVBsblZZ?=
 =?iso-2022-jp?B?SUN1eGVEL3VnVlN4NG9mKzY4NUtrZVdsQjArZU5JaENhd0RMVDJiVnVo?=
 =?iso-2022-jp?B?T01aTmcvNUhGUjlPZldsSHVnNEd4MVJKclp5TnhKOVF5VXcwSURWVWRx?=
 =?iso-2022-jp?B?TEdmSjBDTTgyUGNtUGlUamlnTTc2UjBVZFVBcURNUjUvenNnbjVyUlM4?=
 =?iso-2022-jp?B?LzlBTUJmUjRRMnRlRjFzdXFPbnU0OWNPd3BQdlZvNGhONGgvK0VNQlVV?=
 =?iso-2022-jp?B?bURkVzBYWDFhTUEvdzZVRW51Mjl6SFlXOUY5WmVYUGY2MTlTUFBIS2tj?=
 =?iso-2022-jp?B?UkVoZzNOWEY2Wi96NGZTbS92RUowb3ZUd1NQRzRMeStRRDQ2UVl2OVB6?=
 =?iso-2022-jp?B?SHM5ZndJQlRmNUtPUjNhT00yaHlEUEtSK1Jkc0owVzFZejlUaGtTcmxQ?=
 =?iso-2022-jp?B?VGx5b2VVSVVsNkpsZEVHc3AwWERSQzBvVkhXbW8xaVFheHcxdTVZSndO?=
 =?iso-2022-jp?B?eFl1K2V6RCtLZWsrSjBWL3ltaUxEWEJVWGEvcDYvVng2aUlqajNseG8w?=
 =?iso-2022-jp?B?YmdCYTVXYThlWURhVVR5ajNKL2g3NWF6T2lYRVRJMjZFSjlNQm5nMUNj?=
 =?iso-2022-jp?B?U3dSN1hLc3R4a1BqY2ZSbmUwbHB0VFo2YmhodFpVS3dDbHROb3FQbUox?=
 =?iso-2022-jp?B?OWlsUG5iV3krMEJPVGVUZkNpclRkUmlabmo3NjhhNlc4OXpqOGNnempO?=
 =?iso-2022-jp?B?aGNMZlBjaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	PPUjAqr+CtQqBVWwekwUch7ARQKRNE/GwEE5FxdId71DX8iIKmJspQA1cWPY27Ywoz1vOWYj4LWqqD91E6AIofgOl5YHFslAnZllLZH0OdcwfTXbVLtHaiP1Ayejfe+3EPoOFC/3HXE5WMvG0MzK1EYvNxCBHjFqqBPDrxdffH7PSmtVPF/j/jxy0lpJbFNy5eliKHtEBaMIS7OJciuiWNgdUf78AKvDL7sXaTLy/9AlU2vKBZpATsxeXVogNRvUxTSPPMxDIq9bV7lltD7PL4BVvC8g1eq4bw225kCUWXHBkok9KmFmUyA3TsAmk1nEHplb69tecLTWkQwx6XKr0A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c16cfde-d873-469f-ed39-08decd07304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 06:59:49.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMGXmhsNE9QBkAlkEttprFkJrB+4IB4IZ9GvtSo5CDWtPQKNfp5/aOFjOMLrZRvOyZQp6YRM9NTAufU3Zg7ZIXeA0pcwcPRroF92BGUwxvuOLLw2/6+HsYn+OL7pNSpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 07:00:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23223

Hi,

I can not participate today's meeting.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Thursday, June 18, 2026 1:59 PM
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today. Our
> channel is the following:
>=20
>     irc:irc.libera.chat:6697/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mo=
nth=3D6&day=3D18&hour=3D12&min=3D0&sec
> =3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>=20
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-11=
-12.01.log.html
>=20
> * Action items
>    - request extra budget for AI-assisted review experiments
> * Kernel maintenance updates
I am reviewing 6.12.91, and released 5.10.y-cip and 6.1.y-cip.
I added a COPYING file to lts-commit-list. It is licensed under GPLv2+.

> * Kernel release status [*]
> * Kernel testing
> * AOB
>=20
> Jan

Best regards,
  Nobuhiro

>=20
> [*]
> Date the data is created: Thu Jun 18 04:59:00 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
>   limit date: Sat Jul 11 08:34:12 AM UTC 2026
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Mon May 25 11:40:18 AM UTC 2026
>   limit date: Fri Jul 24 11:40:18 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu May 28 07:36:48 AM UTC 2026
>   limit date: Sat Jun 27 07:36:48 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue May 12 11:56:37 AM UTC 2026
>   limit date: Sat Jul 11 11:56:37 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Tue Jun 16 12:38:40 PM UTC 2026
>   limit date: Thu Jul 16 12:38:40 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Mon May  4 10:49:51 AM UTC 2026
>   limit date: Fri Jul  3 10:49:51 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
>   limit date: Thu Jul 16 08:11:47 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
>   limit date: Sat Aug 15 12:51:56 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Tue Jun  9 12:04:00 AM UTC 2026
>   limit date: Wed Jun 24 12:04:00 AM UTC 2026
>   Status: On track


