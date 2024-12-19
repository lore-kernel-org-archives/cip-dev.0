Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C0BE77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 09:54:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.32])
 by mx.groups.io with SMTP id smtpd.web11.126397.1734602085059378317
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 01:54:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=hqFhOniJ;
 spf=pass (domain: renesas.com, ip: 40.107.74.32, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqUeBD2NHGNOXZkhvlviqa/PGfKfbSXzDD/HWypMdexV7Vdpa4M4BWH/fXmXQOHw2bmSFqx1tmo9w6VpS3LM4TXpkG6tE0S7PBFJF3kFOaIiSBTggntGstY4v3h298glYSVm3Ty5uy0QrFTBMPNKg0HECkcPXkicKFHbziW9KbLW1IL8xuDcXw752dmYZfLOS9NRprLY0AH0xqtn7c5+MhZ4/fI2Vj6dI6GpJOpi2G+2n8X7D85KNaOG9YHxSepGgPy2oBONXSa+0T5oo90+JSfGLcg6VCCBgRQw0E4uy12NqC+ocTHw9Z3Ym8AuKABMYeMlREDufC72L68a2pePXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFAUleDCuXxJIPTCCplG8Opm81ISZccVkXDTcIxwWBo=;
 b=nMBdE2rXQIO41hmxZAQHhYrcNqzQ89val3CAJQjhCPEHlLDEGoUX8ENzV6PPILUM/ejAw5Cb3qI5ZIqQuLBMrBUAQ0WkiV/fmsWcLiM3CH9Z+VRxJBXV8qciZiYdFsHHiBvVXCVRu1D+UTdgkR1U0gGfiFlY0vcK2+W9n3pS5T07M9AA6Kn5S4mVRlO0Qh/HU3EYIrG5XxJNmx6wS63XgdjYZcDcasKfuVDH0kgm3lGEX6jI3Bbj/ias9aaVdiKV7CH7OdDlh/nzYsjNSZTyAYpIdxiVTA7RuCGtoyJ+VtgKvmdUfSN1oFi2VA0pcLpx6oacHrN9ymo8BfZY+0WbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFAUleDCuXxJIPTCCplG8Opm81ISZccVkXDTcIxwWBo=;
 b=hqFhOniJgIUD60gqiS1McvTFV/3GiVxu8Kw+dxksLbONd0fmQ0vdp8ZV9Hj6li5DMPOtnNLyTT6ozcKKZiuMCXq/nVap+ApLOojXeWPGRB0lvuJl9eWFMKqFfq+NAgNIKSFIE/n81Y+ClANVeRf6rIrwmqxej9Nl4vGN/HPmr9s=
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7)
 by TYYPR01MB6650.jpnprd01.prod.outlook.com (2603:1096:400:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 09:54:40 +0000
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b]) by OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b%5]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:54:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: CIP IRC weekly meeting today on libera.chat / 20241219
Thread-Topic: CIP IRC weekly meeting today on libera.chat / 20241219
Thread-Index: AdtR9SoexTUOBTfZRAmv/iKgDL7abgABqI5A
Date: Thu, 19 Dec 2024 09:54:40 +0000
Message-ID: 
 <OSZPR01MB84014FACA087AC9E878954D1B7062@OSZPR01MB8401.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6391EE99BC84D03BF2FC38A092062@OS3PR01MB6391.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6391EE99BC84D03BF2FC38A092062@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8401:EE_|TYYPR01MB6650:EE_
x-ms-office365-filtering-correlation-id: a4c656d3-d3b8-4dc4-efb2-08dd201327d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SmdtdjRNbTRCemMzeXFCVzRCM1J5R0t6SGxTRU1nVnJrSklKVDAvOTg1?=
 =?iso-2022-jp?B?QU0xVGhocHh5aGl5WU91NnhPMlB2Q2lpdnB6MlBPdS9mMXU2R2RsWkJs?=
 =?iso-2022-jp?B?a0FFTFdZMGsxMi9oR0JqUUJ6ZUg2TXpNWTNsQThtdGNPVkVwb0RZamZ0?=
 =?iso-2022-jp?B?MjV3aVRlZkoraW5Cd29tWHI1OXZkY3VSTUtVeXZ3dGs1WW1IZE1KNWV6?=
 =?iso-2022-jp?B?TkI5VFlVc29HY09iSm05cUpLaVZ3S1VmOW5jNlFDVmRGdnJlckN3Y0V4?=
 =?iso-2022-jp?B?dGxkNTJrZnNiYVViWEtzb1pSN3I0ZnZDdWlEdnVqa3pWVk14KzhSMFNC?=
 =?iso-2022-jp?B?YkpPSlFDZmFxSmM5TWdOY25zUFVTRnFCQW1uRnRJTW1ZdnMyZmZkYVVm?=
 =?iso-2022-jp?B?UW15VUYvZjhZQ2dBaHVmNHU2YUtYV2hUTy9nQXhRVlZ6QVpIZ2EyTThh?=
 =?iso-2022-jp?B?RTVCR1FhRVBOdnYxSGlaZ216RWdTQkxaZVpKajcxZDBRYjNsNGg0ejFP?=
 =?iso-2022-jp?B?L08ralVWQXBwRmhZUXNvMVh1L3RJbzNtcEtXby9DZlFrVk4vTWVRc2ZI?=
 =?iso-2022-jp?B?QzQ3clo2dGJ5UStsdTJTR1h6YmpCWFoxSFJreVRtMlN3UWcrNk1POGJq?=
 =?iso-2022-jp?B?Z09Way9YaE1aUmdOaXo0VWhzRjhQUXN0a01LSWY0S2JyWHZuQzVxYTVp?=
 =?iso-2022-jp?B?dndkV1FmQUJBQ2RuR0NsMWJXUm8wa0RRc21FeU15ODh1TTF3bDNrTnlm?=
 =?iso-2022-jp?B?eEFET0s5R2ZwZjlQYUpaSjlId3NoMFhIY1FFQ1lTeCtxOVVvU2YvZis1?=
 =?iso-2022-jp?B?aHQ1VExrNkFIcGJLUlNQMHpBUEs3OExJUEpvOHEwNjgzeUtLREZCU1lF?=
 =?iso-2022-jp?B?Q2x4dHB3MkMxU3FkVGliR1VmOHlpdzdQUEtOWkV2c1lJNzlYZ3RYbkZF?=
 =?iso-2022-jp?B?SmFWVWJ0eTBaQ1ZGWGZJTlFjS0RsQ1VaS3lIVFZmR0RvWmVsNU1WeGxu?=
 =?iso-2022-jp?B?OS9DYWMwbHlLV3lnalptT3RGV3lyV1VNSmhSYXU5T21qQ1NxUFg4MmR1?=
 =?iso-2022-jp?B?OW1vNkxFS3daeEVLd05mdkYvUUpJY2hhQy9OanY0ZjJrOU5JOTM4SU02?=
 =?iso-2022-jp?B?UEtBR2lXTVBEWHIwTlhJYzdSMnVyQkhuK3Vsc0JQYTR5UUJsS0tXYU5v?=
 =?iso-2022-jp?B?VktUQWlxYUNFSkQrdGZNTTJKb1FaZDFBbUgwdk51MUNYNTU3NzJocFU4?=
 =?iso-2022-jp?B?bU1kb0xkenJ0dFdwSG5jQTJDdk9kcVgvNU4zVzZ3YlJrZjlkaTBnbUpw?=
 =?iso-2022-jp?B?RHV4eTdYdjBmVFpIV2VKMGNMRTV2c096bG80T2FSb1cvaWJuc0hhK3R3?=
 =?iso-2022-jp?B?a283Y3FWc29yWlEwbXBaTGRIVzJ6UkFpT0xmZDZ1VWpCKzFSTXVCa0xV?=
 =?iso-2022-jp?B?TUpYa29paC9IZlBNd1phd1hGZXZEWlFtTnEwNkhiY1E4T3lZall2QVBz?=
 =?iso-2022-jp?B?Q1R0Z0Y1QnpTcCtiTHBtYkxDdWtwTHBsYnBuSFBFMW5YV0VDd1FFcVhJ?=
 =?iso-2022-jp?B?SU5vQURhMjVlTWNjOEtmZG5sd3UzWGloOWxRMnh5WWZmTUFiTnFUYk5P?=
 =?iso-2022-jp?B?WG85TzkyUDNxc3FJODRQTXBxWC9NaDZBVnlTWEFxMmdhZndRZkVXWFJF?=
 =?iso-2022-jp?B?Ykc2bkV4ZURGQi9wb0YxT1JIai9GSVYwS0ZZV25JcThtalNBRnZ3VFY2?=
 =?iso-2022-jp?B?bDNIdEJJN0liWUlwcGhsc2VOQkRJUTZKTGE2V0hQYVg1U2JrUHlEb0Nn?=
 =?iso-2022-jp?B?UzRKSzI3RDNKb3RRRktGN1hIVW9rQndpUmxGQ3lRbXBTT1RzRDJSeWp1?=
 =?iso-2022-jp?B?L3VNZlhRbVEyOUk4UWxOSDI4TnluajhCMDJUSnNldkNBdFNCRWVkS1Rm?=
 =?iso-2022-jp?B?c3QrS1ZUL2NHT1EzNzhiY0cwU2NBWE9qZ1VCUEpyRU1ka0lhT0pHbzIz?=
 =?iso-2022-jp?B?dzk4TDJBNVVSbVRIVXlSeE5wY1BCbQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8401.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UTQ1Q1J2amEwcGtlOStBdUFJb1NRNUZsc2c1NituQk10bDQ0MHl0ci9z?=
 =?iso-2022-jp?B?MndMQVpRTlloL2ZzdFJ1S3VUd1k2bGlzYmVGOUJGK2gxMEZ1QTlDVGRs?=
 =?iso-2022-jp?B?T0dPeEhGYjNhOU1XdTlVUHU0eG80dkxBM2wyOVR3c1Q1Z2lxdFloaGdv?=
 =?iso-2022-jp?B?YUk5ZFI5d2lzOHlvbndhUW1HbEhWcytPa20vUUM5bFZQbzlsNHI2Z21i?=
 =?iso-2022-jp?B?cWl6T1BDd1J4dDJwWU9vKzAyTjVPaGJPQ3FrL2kweEdId0FlMHJ5Q085?=
 =?iso-2022-jp?B?elpRNXlJSWQ0aWErZ1pvY2YrUjQxajdvWWg1b1RDSE1BbnROamJVc3NB?=
 =?iso-2022-jp?B?MmxqeldNWTBIamN3dnhOblphMjkyTS9SN05VTVVzcm4ydVFUazZGWkJ1?=
 =?iso-2022-jp?B?aTNPTWl5bG0yaHdKem9QSmxWbEZYYzczRjBwcDhqSTRpQU1pa1ZaVkd4?=
 =?iso-2022-jp?B?N3BONUhXVEppaDBiZWpiSVJrTElJRXhmTzljMGR1YkF3R1g0enkrK0w0?=
 =?iso-2022-jp?B?ZXR1REl2a1FVT085MW96WGtEWTlmd3pqeGlvbGlsR3FpUGlTTld5ZExh?=
 =?iso-2022-jp?B?WEc3OUlndWdXMzVjTEpMelNhZjQxam4vWUhFRjArOGh5blRJTU1FMkNt?=
 =?iso-2022-jp?B?Q0t0eXVXUDBOaDFlK0loK0VkVXo2MEZ6bW4rVXV4NDY0MFZ5cVRNOTRy?=
 =?iso-2022-jp?B?NUlhY0gyOHRSN2JEQ2FFQWRIYXhuNmhzaVVHb3VHSXdjRXREaFJMazlL?=
 =?iso-2022-jp?B?QUlnaHd6RUJxLzV2OEc5MVJWMXpMNmY3WHhSK1NQenB2enFZbnc3bm9Z?=
 =?iso-2022-jp?B?d0lYNnQzU3c1SnNZUW1kWlNja01FZytuN1hYU0NGYU82cGdGOVNXWUM5?=
 =?iso-2022-jp?B?TXNVSU9zb0FjWFcrUVFKMWREMVA0c0lFUGpWZ1MyRlE5Y3pkR2pZRVFt?=
 =?iso-2022-jp?B?elBzbXYxZlkyNjBwOTlxNlF4YkZCOFE4S29JbWlYTGxHNzU4ZmxQdU02?=
 =?iso-2022-jp?B?VW8zRGdFVmlSM0d3T3FJVXNyRXB5T2ZrUGE3ejIzZFZhZ3d3b251TjZo?=
 =?iso-2022-jp?B?UVVzbjJ5YlByWHdGQ3ZLQWJmK1g5QlFIZ0ttZlVYbGQxd21ZQitlR0dp?=
 =?iso-2022-jp?B?Vk1qanpndzB4UTdTWmR0Z3FFTHNQYnVnZ1MyM1VUUS9QdG8ydXByeCsy?=
 =?iso-2022-jp?B?UTNLZ0ltcjU3eEtoYXNPTHo5eEE0N2NHQVU2OVJLelpocVdLdzE4Uml5?=
 =?iso-2022-jp?B?Rk92RWxlSm44SjNMcW9XbzRKY2RkSHVDb1BFdGFQTlFla3ZjdWhLZHBV?=
 =?iso-2022-jp?B?S3VINGkwWHVlYkpXV3UvampURTh3NUxtaGY4czUyeHRneWNXdXJtVXkr?=
 =?iso-2022-jp?B?TzZ6VjlhaEpEd2FwVGdJOThmc1dzU0s2TXZxOTFVdUlLb0hnUlQzQVZa?=
 =?iso-2022-jp?B?SFNDTUFGM0hhMm0yZ2tzb1U3V1Y4d0NSNkpMc016KzhSWUFkdm5kc0Y2?=
 =?iso-2022-jp?B?bFJpVVRWQTNkTGxWSVJvSTVObU1FOFFFblNGNWJOOWFzcFhDQVBscStI?=
 =?iso-2022-jp?B?UU51WXJnckdvM1JnZXcwa2tCRHdibHUyM0tHbkE2RkJ6S2tITTF5QU5y?=
 =?iso-2022-jp?B?VHBXMWN5alpsVDR3MzJoaS94Y2V5VFRPU2ZoODdYWGFOM3JjdERxUUZo?=
 =?iso-2022-jp?B?SzVFVE9uZkhDcEtEVGZJYjhjR0RPYnpaYTVyMzk1WnpObjh2UE42bmlZ?=
 =?iso-2022-jp?B?RHl0ZDNuSEFxMXdZMC8wNzVFTzh3b1lPaTdvUVFXRUhuRG1ZWXdxbzRj?=
 =?iso-2022-jp?B?TTFZL1p1eUMydzZjcXcrbUQ5SVg1ZlM1UXZEK1VZbXlKZ3EwNmNtb1Q2?=
 =?iso-2022-jp?B?SEFEQ3ViVTRlV3ltMWNoM3BzZTRveDNzQjRYeDlUVTZJaHZZZU1naWwx?=
 =?iso-2022-jp?B?em9zaThnM1BBSE5wbkExNHdCV0N3WE5zRTlWamFkOGZXc1RSZXdLTk9Z?=
 =?iso-2022-jp?B?b0E1SFFrdVZ5WEVMTVdST3U5LzVXYmFlNWh6RTVkemRTQVhRVGtxQzIv?=
 =?iso-2022-jp?B?Unk0WFpiNkRramRUZHBNT0p6NDJhZEJOL3JlYVc1SlVWRml2cmZpYmhZ?=
 =?iso-2022-jp?B?aEV6Tm5zajlJMm5aYTJTdWd1RytwZloyTm1Ed2pUa01zajc4OHNwQ2Y4?=
 =?iso-2022-jp?B?WjhtZUYrUjhEUVNxOHV6WGFaRElhWCtwTWFYMS81dk1xbDgzVkkzcGRO?=
 =?iso-2022-jp?B?QXhzdi9VRzltNjR0K2k0b3gwSWdUWHYzUTVLZGM4dEJrRk5td0VCeU9p?=
 =?iso-2022-jp?B?dG5qRzFwMTFFT01HalhJK3JqTHJEQm42anc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8401.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c656d3-d3b8-4dc4-efb2-08dd201327d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 09:54:40.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0oiEqG2FFnI/h0GPLp2K3hxQXdbxZ19ETYlWhiEHw8n8id9zp2mw59GUzT+wDn6l6p62f7oU0ij2O1xBz1KYXpYXAiniiLMDZ/ZN8dKl7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 09:54:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17477

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: 19 December 2024 09:09
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:

I can't make today, sorry.
I will also be away next week, returning for the meeting on the 2nd.

>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mo=
nth
> =3D12&day=3D12&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>=20
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-12=
-
> 13.02.log.html
>=20
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status [*]
>   - all green
> * Kernel testing

No updates from me.

Kind regards, Chris

> * AOB
>=20
> Best regards,
>   Nobuhiro
>=20
> [*]
> Date the data is created: Thu Dec 19 09:05:47 AM UTC 2024
> linux-4.4.y-cip: interval 30 day
>   latest version: v4.4.302-cip94
>   latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
>   limit date: Sat Jan  4 05:21:08 AM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version: v4.4.302-cip94-rt52
>   latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
>   limit date: Mon Feb 10 10:45:41 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version: v4.19.324-cip115
>   latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
>   limit date: Mon Jan  6 07:05:01 PM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version: v4.19.324-cip115-rt39
>   latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
>   limit date: Fri Feb  7 12:30:02 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version: v5.10.230-cip55
>   latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
>   limit date: Fri Jan 10 05:28:57 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version: v5.10.229-cip54-rt23
>   latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
>   limit date: Sat Jan 25 03:12:05 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version: v6.1.119-cip33
>   latest version release date: Wed Dec 11 01:47:08 AM UTC 2024
>   limit date: Thu Dec 26 01:47:08 AM UTC 2024
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version: v6.1.119-cip33-rt18
>   latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
>   limit date: Sat Jan 11 10:20:12 AM UTC 2025
>   Status: On track


