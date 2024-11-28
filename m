Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D88D69108
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 13:05:17 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.47])
 by mx.groups.io with SMTP id smtpd.web10.93873.1732799116193249064
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Nov 2024 05:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ClRskSGY;
 spf=pass (domain: renesas.com, ip: 52.101.228.47, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyzlU5EvwhEQquTiwLb0PIIkjsqCfDdrHxBDr/k+YzWQJ27D0TtQvm2G90ySHbwvNwyltjCMs/2eHpuMjsrlN7Kbz4TLZjew4mE+mX5aN7ls7cXozT47RowYSoCHLh1NSrACxXFsc5/y/GXQ72KAA7tILI63apHsuP5lE/wpFZGZ4wzp7+4ScqEqXbOFC6QFKmO3oM4dpUBG78tLMbs28MRV+FDIEVm/baz8CQozoFqcomUbZN8JqWA/DQa5kjfHwVzw9exHyMuLo8ahKZNTtppoJq+kVMB4GT7P2ySfhsHvK4thlcg3CPnQFSJ95GAoO4cpzLZCz71xIVJRR/sR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E50HaqYqa1Zf2BpESCytNUEIb50gswfgJ7copkU/L/E=;
 b=sdqL2F09pdP6MpKAkXDoXSbbUtsZSX4zUiys/pEt2MdtjpwK0TEnF/94DFubhRT30NPZgFvBzeQE4V93sL53tajRqHScBuIG5xEqkTvMWljBo+aeDicqefDa1++VZ+onsydxgyR6NhfSVeUYvcJIAYL5JVOsMP+KCR3WQAtJMAPVw3Nisxd7aT5iV1+OrwEuwcIuTXwrNVMavD+8JrJ0z/zp9ICUav8Ld9JzZWpyWItras2CJAKf+t+rG90EY+UCm5JJ8LIXLFVP0A1Yk0E7stb8Tfeg9oXNBekXAM/hxEdeO4xOIlYi8M2OP9mGKrerVcnIYYHey7NnggcE63fKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E50HaqYqa1Zf2BpESCytNUEIb50gswfgJ7copkU/L/E=;
 b=ClRskSGYWBH4jA8ECCUl6NNg1X2jyrI9qpip3V6M3n1O+qsNux5sYUvYlfGr03KMH/UjqPhTaO/KM8scZhduc+OfQWb6f/XgWz+eDpxMTairWlWJ9ywLX8l2JflJJDtyruhzv4A52F59CwSahkEOtoxb1YJzKPw3eyCZiSm+cEg=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS9PR01MB13129.jpnprd01.prod.outlook.com (2603:1096:604:30e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 13:05:11 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 13:05:11 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: CIP IRC weekly meeting today on libera.chat (2024/11/28)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2024/11/28)
Thread-Index: AdtBGP7xUWTxmW8dQt6X+l0ef+eZxQAfSHLw
Date: Thu, 28 Nov 2024 13:05:11 +0000
Message-ID: 
 <TYYPR01MB12402D8AE4D3938F89D857470B7292@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB638817482BB139A6D14C24D692282@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638817482BB139A6D14C24D692282@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS9PR01MB13129:EE_
x-ms-office365-filtering-correlation-id: a5f84189-0024-48a7-6470-08dd0fad4b02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YXl0eXpJNEFEN1liejJnU3A4MVNtMU9Nc2FwbDBRUXBmWkc2dXVQS1RB?=
 =?iso-2022-jp?B?ejhoNUQvMGZ6bllxd2ZnSXNkb1kzVzcrOTZ1TVhlREdXZjRQWlhlYzhS?=
 =?iso-2022-jp?B?WXdsMTlrdVFQTlpRUHBTYXYxZDZhamdCNnQxejA1a3FJRTdjdVJHM3N4?=
 =?iso-2022-jp?B?QldpMUhTL3pyZHVDYStGWTF1ZzFLV0FGYkNYeUxvbWhNMlZzSlVEVXEr?=
 =?iso-2022-jp?B?TDh2eWxZcUJ2b0d5cFE5c0F5Y3VXL1pKZUpabGR2NklmT0hxS1NLcXRW?=
 =?iso-2022-jp?B?WmFiT0Nzb3FITVVQczZ6Y05MVkh2NWpNWXh5R3dXeURFeVN3ZCtQQkhS?=
 =?iso-2022-jp?B?cS83ZmRFSGp3dUJtZEFnOFhSMExnNzZXT1U1aUN3YTBKWWsvRDBaeDJa?=
 =?iso-2022-jp?B?Um9mZW81aVNCTzZNVjlDaXVpdnBxdm9NM3ZoZVJHRklsUE5CWVRnbEo1?=
 =?iso-2022-jp?B?T25RbWczU1YyQnZZNkRWNjZ2QWJ4MEF2VnV4QkhpMEZ4SjBVRjBIQ3p1?=
 =?iso-2022-jp?B?R3VQVS9XQnQxRkJnM05hbEoxRUVhakxVNVZ2ZWl6MFowOUpJQWpqcmNX?=
 =?iso-2022-jp?B?N0NGTDVyeDgvNjlPR1ZsMmV5ajhTZDIxUEk1ZDdYRWttcWgxUVN4MTNR?=
 =?iso-2022-jp?B?Ung2S292anNnR1pxNlF6U2N2Z1lNRmVIb0RDNkxsZmdkb3J4TVVTWVh5?=
 =?iso-2022-jp?B?V1I4eHVIK3N5azdpQnZaK0t4ZnJHRHcvc2x1Y0M2MDU3LzRpT2p3QlJL?=
 =?iso-2022-jp?B?RDN5N3RLRXVrV2hranRzUFh0V2Q3TGdMUG1WOGp0aGgxdU1MM1hFSUph?=
 =?iso-2022-jp?B?eC9DcVJvUjJKcGxuRlJvZHgwMlM0T2F4NldxamY2ZWdNM1JSSnl1NHds?=
 =?iso-2022-jp?B?QnNOemlqL0MvZVJjQXlJSUNhSTlpY2llQVJWeHUvRFRrQVNwWUNYVUNh?=
 =?iso-2022-jp?B?QnY4VkZwYVlSSnlqbFEwcTAvcWZNQSt1VTA2M3pUL0VaT3E5S2R2K2Y1?=
 =?iso-2022-jp?B?MlpyUUpJbjE0V3JyN2YwYmpVam9UNFBLT1ZCSmdkZTVyQXhOWFlZQU5S?=
 =?iso-2022-jp?B?UnBpV1JxK1VBaWFDdHYva0ZFdUo5aWlRWjlWVXQ1VkhFU3UvekFhaW9Z?=
 =?iso-2022-jp?B?cHlJOGFhRTBwaVNPeGdpcmYzaGNndXRVVDZNTWQzV1hQa0QzUDlKVXNM?=
 =?iso-2022-jp?B?L2dFajRtMVhsRy9aNHBUU1dDQzFBVE0zMlA4U2hnTjRlTmZkRlM1MUdw?=
 =?iso-2022-jp?B?M3JySmR4Z2NTaGhBMW5JaC94K0FOQXlmS1Y0ZS8rcHQ4TytaZWszQUVv?=
 =?iso-2022-jp?B?WW52QVBYTVVyT2pyVHNZWjhETmtHV25rWmkyNHNRREk3RUFpRWhyc3kz?=
 =?iso-2022-jp?B?OFNPRkp3Q2ozS2dhZXM1Y1JQTXFSeTlBcWdYUy8raU0vY081ZUhPOTU5?=
 =?iso-2022-jp?B?VERlTG1BdzBvckJQVUdLWlNVOVdTZ2dhamZtZThOUnViTGp3d1Nna1RR?=
 =?iso-2022-jp?B?Q3NPNTdrYXVCMVArTDlrWnRLdU11dkRyY0VSK1VVUzh1Y1pCckZEdG9v?=
 =?iso-2022-jp?B?a0FsK2pXRENqcWZwdUlzVFBLOTNYUm5zbys1S0R0SzlIRHRuME5jdWJh?=
 =?iso-2022-jp?B?Uld3a050bVljU1gwSklUYVNoVFdjTG9uL1N1bGtienlLeDFGdlRITjZY?=
 =?iso-2022-jp?B?YnZTY2d6cW9wTEtTdDV1WHZ1WGNBSFh0dzliVnEvbEkvZE1sREFCcURX?=
 =?iso-2022-jp?B?QW9kdStOb05MRTBYekZzbWxBbGpkeGQ5cHZFcWdCc241U1F1d0w3OE84?=
 =?iso-2022-jp?B?aVd1VG9HMGsrU21XVDhXL0R1YU5kTW11ZVFsNzhoWWdOeng1VkNaeDM3?=
 =?iso-2022-jp?B?SlROeTVnanVRMll4d3JFNXNKZENSeVRyMkhxakFlNG5Yc1F4b0E1MU5n?=
 =?iso-2022-jp?B?aUQrS2syOUE2aXBBRnRjc3ZoeW9PMjlNWHY0YnBtN3VHRWtJb3RhaGJt?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?djZYdkJQRUpGcldFMGF6YlJUOVJ5SVhOMmwyUzVvRzVNU0RzSm5JMjBY?=
 =?iso-2022-jp?B?T0tpZS84YUNtcks3Yms5L0ZIOHF5bUZaMGJnci9LNjR6NG8rS3lqK214?=
 =?iso-2022-jp?B?SERGNFZabGRXR0RlaFlIV0xCc1l6SkRqdXJMeHhrZFNuYmJuZHV5cEky?=
 =?iso-2022-jp?B?WW95aDg3Q1lrcVRDMUhpZnZ0RzZHNFhOY2NIZldjakJ5UWl4MjJCa3Z0?=
 =?iso-2022-jp?B?K0g4aUVGVHR6UC9jNVZwWWJMR00wb09yRVV5Zzc0bWxsNTM3b1h1Y0dP?=
 =?iso-2022-jp?B?cndmaHdrZW12Z2lkbnN5ZDVCTCs4OElORjV3N21PaE1ZTXdVMlJOdVNI?=
 =?iso-2022-jp?B?bW1EajlXdFR1ekZlOWRVNDB2bXVOb0xzZjV4ZThRMThUbzVhODR0czg0?=
 =?iso-2022-jp?B?MWxtOWhKSndwWmZibWM3VVlxN1FaTzVHWWovNk5xZmR6Q2tTQmtMZmZ2?=
 =?iso-2022-jp?B?bGluSDBBTnFDU1kyNkFBemNETHVWTSsxT3BBbjBvU2tRaWFoN24rbkNY?=
 =?iso-2022-jp?B?MmhiTnIyR2I3MU0zc0VXVysvcUhucEtZWWNpTmdXaXR2cjFla2djUG1O?=
 =?iso-2022-jp?B?dk1XV1VRdVg2SkwwSEpiL2xlN2dKNE81Wit4UFhuT2RyWCtaenIyWXMv?=
 =?iso-2022-jp?B?NnMzQU1OZUt5WEFjT0VmVkd2TzUyMVFvUlI1OWwwNkkwNVZzamFITGxy?=
 =?iso-2022-jp?B?N0RaZUVCRFRSSHJjaVR1QzNTVXRxam1GSytvVTNIWlBnY3d5Z2wzaHRm?=
 =?iso-2022-jp?B?dDFTc1lOOWJrM3pyKzRLZlFQRDBiZ2pUVjJJaWxzTlJIVllsU2tZaG5w?=
 =?iso-2022-jp?B?NkRBQW5TaHVOUWVWVmZZNVJydEpRaldUOS9MQzJpWnQwK0lPZnlCc1BZ?=
 =?iso-2022-jp?B?OU1MVFFoL2lmby92Sjg1QWlQUTF2cENVQlE1OUtFV3A5SVdOTkZGc2l4?=
 =?iso-2022-jp?B?a3I0NTl3UGh3ZDRtYU83TVRhUld2d2xyS0pObWhLV3BZMUdXc1RkRjF4?=
 =?iso-2022-jp?B?YjJXeVY0bWZUZTlvQ2F4QVlqbDc0ZFRnaHVyZHNOZVc1NTJ6MjR6T0xN?=
 =?iso-2022-jp?B?bmwwY2NNcFZuWHNUeFNwS0Rob3BvSjJxcnlZQWEzc2Evc2gvRGd3amRs?=
 =?iso-2022-jp?B?aTRYR1BDZ3ZzdTE0TXFWcGxZelJLSHU0eFBCaWtNNEFEV2pMU3VaUm1i?=
 =?iso-2022-jp?B?b3FWcWZ4cU94ek1OUXlDbVRLSUhQVzJTRE1PdGd6alA3Sm5HRUpMTWRZ?=
 =?iso-2022-jp?B?RmJINFpwNUt5bXVDZlFDUFFWNXhLeXBCT09tWkxvaXF6Q0J2bUlOeHRp?=
 =?iso-2022-jp?B?d0RsYmZwNzF6RG1OTjJ1SzJ2K1ZvVjlTWG94ekduSFQ3QUhLM2UvRTNK?=
 =?iso-2022-jp?B?Y0lNaFBKa3VZM0JDOVJuTlB3VzJwWnV5MVJlSWpSWk1ld3ZTc0tBWSsy?=
 =?iso-2022-jp?B?SzhkTlFmak5QQ2xObVQyc3BtT0ZqcXFFY29aM1VhaFVJRjh2czdZeWV3?=
 =?iso-2022-jp?B?N2g2QjloMG00RDdZaUdEWGJuWERjejlqTGQwZUdkcE5RSm5OWHowY1BO?=
 =?iso-2022-jp?B?dzZ6czZ5UXI3Ny8waU5ieG5Gdk92UEpWdGt3TngyRVZPZ3lReTRZdC84?=
 =?iso-2022-jp?B?RTJEQmgyRXZPOFBEc1ZGZS9pTlhKV0JYeW55QnlaK3dJZGNNN0NaMXFx?=
 =?iso-2022-jp?B?eXpiNW96SzBiSk8wckpyaTFoL0IyMFpjSXVaOUphOVdhTEFTZ1daVzgv?=
 =?iso-2022-jp?B?bHg3K0Y4QXJLQlRUZ0JrUGUwTk45K1FjVnNiUXNwdzNYQVJKUW9UQ296?=
 =?iso-2022-jp?B?S2QxcUJFT1ZBbkkxck16WmtZaHp0Rlg4alhsclRvbUgwY1UxRGJWU05D?=
 =?iso-2022-jp?B?UDhWR3JXMmxsb2prTmx4ZjU2QWhzakZhemwyaHNaNmZSYlNYdURxTnBE?=
 =?iso-2022-jp?B?dUZBOWIwWGNWSjhxUkJOcGFmOEV5azhkZWEvSWxJWGdJSlkrVE4wNGNW?=
 =?iso-2022-jp?B?RkVwY3FxbHM0WitoR1RyT0YrM2FwUDZocTNsUGNrVEdnSk5ieGhoNW5u?=
 =?iso-2022-jp?B?ZEd1SDlmSSsrL3ZZcUlGWVVhM0VyQVdUR1FvWi9ZQi9kTklhRE9EVzRs?=
 =?iso-2022-jp?B?K1dwMWplcm5ERFd6VlFoQktualorb1NSZzhvengzQXlGdVZuR2J6bk5L?=
 =?iso-2022-jp?B?QTlUbUNqN2VQRFhRZTJoM3NSVlZ4WXcwMEQvZzR6U0VuOVZlU1E2M2dk?=
 =?iso-2022-jp?B?ODZ4OEd1ZkZmcmpINk9Gb0x0eG5BZ09vbVVPNnVxNERaK0NvU0NzTE9R?=
 =?iso-2022-jp?B?MmtKaGZ4TmJKNi81ZUFCdUFNcDZ1R1lWS1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f84189-0024-48a7-6470-08dd0fad4b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 13:05:11.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOqyWsD3JraE2MLc1HEI/RZ6xXAAovn1NUDK40uLW1CC14xhVo9vpCWzizgSNCotGzhluyfLNco4MJshvAPSXwmLFZFWIdev9dHw5Z3I2Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Nov 2024 13:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17299

Sorry all, I cannot attend this week.

Kind regards, Chris

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: 27 November 2024 22:15
> To: cip-dev@lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
> (2024/11/28)
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mo=
nth
> =3D11&day=3D21&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>=20
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-21=
-
> 13.03.log.html
>=20
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>   - meeting host for next week (28th of Nov)
>=20
> Best regards,
>   Nobuhiro
>=20
> [*]
> Date the data is created: Wed Nov 27 10:10:00 PM UTC 2024
> linux-4.4.y-cip: interval 30 day
>   latest version: v4.4.302-cip93
>   latest version release date: Mon Nov 25 06:15:42 AM UTC 2024
>   limit date: Wed Dec 25 06:15:42 AM UTC 2024
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version: v4.4.302-cip91-rt51
>   latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
>   limit date: Fri Nov 29 09:48:28 AM UTC 2024
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version: v4.19.323-cip114
>   latest version release date: Mon Nov 11 07:08:57 AM UTC 2024
>   limit date: Wed Dec 11 07:08:57 AM UTC 2024
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version: v4.19.322-cip113-rt38
>   latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
>   limit date: Sat Nov 23 10:34:04 AM UTC 2024
>   Status: late
> linux-5.10.y-cip: interval 30 day
>   latest version: v5.10.229-cip54
>   latest version release date: Mon Nov 11 07:28:28 AM UTC 2024
>   limit date: Wed Dec 11 07:28:28 AM UTC 2024
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version: v5.10.229-cip54-rt23
>   latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
>   limit date: Sat Jan 25 03:12:05 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version: v6.1.118-cip32
>   latest version release date: Fri Nov 22 09:04:06 AM UTC 2024
>   limit date: Sat Dec  7 09:04:06 AM UTC 2024
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version: v6.1.112-cip30-rt17
>   latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
>   limit date: Tue Dec 10 11:47:28 AM UTC 2024
>   Status: On track


