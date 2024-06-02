Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F68C25B74
	for <webhook@archiver.kernel.org>; Sun,  2 Jun 2024 14:26:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.59673.1717338368764425502
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jun 2024 07:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 452EQ6FR4165524; Sun, 2 Jun 2024 23:26:07 +0900
X-Iguazu-Qid: 2yAbXhlxOjm8ECYogT
X-Iguazu-QSIG: v=2; s=0; t=1717338366; q=2yAbXhlxOjm8ECYogT; m=QeWwfnloD0wXC8Y1VKA2UoOT4n1Y6x3gN00z9OsahxE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 452EQ5VJ057461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 2 Jun 2024 23:26:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS7M0cmyZRkWPF191Oum/wlCEA4RZ7luTPTRsxLiMOtRKrLKIN7aouHcrGM6RmKHmASgzN8nwrmoqDHrl/OSNPO2C9bYuJJEIWGD14hCX2g4+wc5UDTPBAJMfyOqvp7uyyw56vtgan688CquVXCrrw5+vqZZr5cvnwHiWy+1TcAxYKyIzmJe/OXQZQ7MslsymLedHn40ZD8NRIymueIEJBiVQCUJhZ0AQ5JKBKPRWlWDVbBEbUEHg+Bq9NrkinEjDJ5c79wh9hbX5zJzvQcgbc3+ER++3WXK4H1nwpkMxvFciSuHlt1+r87Fnu9z9bU4NRobdqbA+joqWkplAjrx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4Sk/TyLamVFkyVyPuWZVM2h+/O+ePF8HxrqNO+XH7o=;
 b=GtBdAxNPBnXB1K4pMnpn9QlYZ7LYKOSNeVqXbXXW2jF6rwgJYB2QulVo8gKX9jbHzSrMM9RDSeMsnFXCpZyz/b04I9DbloTJpiXBHQpu3eGasPofB771NmvK2JfYgm9PThQIH2lMBZBeCVqIEZRlQDA+vtpZhZVQBs7U4/IF9bJ6m2ZbwIMjwy0wO1mvrtwdUOB5ALwwwuTTHUTA4VUAsW/TyKUMVo1c6ZGURpY544yX6BsIZ6RVGZvfr2bvexmhycGWGgra++6JaCyGUfkEzFyN5r7yzW4v2Gd+tX1nNiHORyzG78zFiwTHZHyNreTkI34ioUm+w+Vjio7VsXhlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <kazuhiro3.hayashi@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] Preparing test evidences for CIP Core packages for IEC
 62443-4-x assessment
Thread-Topic: [cip-dev] Preparing test evidences for CIP Core packages for IEC
 62443-4-x assessment
Thread-Index: AdqngyKNF2gl+sOgQmW8Zvoy0bqzgAAfUtvAAz3859A=
Date: Sun, 2 Jun 2024 14:26:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96699E420B7EAA6E49F50263C4FE2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669D37EC2865C6595EFD118C4ED2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB113852C6B7DC0548305FB8A0DE1EE2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB10462:EE_
x-ms-office365-filtering-correlation-id: 5b3bc752-086a-4420-85e8-08dc830fee8f
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aEJ3TWIxVXJHZExoOXdGaWtHZEt6NkpjNlpQLzR6ZzlnRUJsV2JRcyts?=
 =?iso-2022-jp?B?eW05akMreEJJNmF4cDl5c1VWVmpvRlVxYkZJUTROcTBoRS9McSt5QmNa?=
 =?iso-2022-jp?B?M2JUN09DTmpkblNzWndiM0FubEZxRUlZZ0pmTXk5TSttQ0w4WGNlcFN0?=
 =?iso-2022-jp?B?SGR1YTNobTQ2V0dXb2xlcisxUkZmWHhkRXdkOW52S3ZWU0ZNYThhS1dm?=
 =?iso-2022-jp?B?YmRIaG5Sbmpoai9wZmpDNVNVTlpmd3RqUFdPZEJTVmx3RFpyckR2ajYw?=
 =?iso-2022-jp?B?OGEycXVjYmczU21LUTZsMEpwQks2V1k1TFBEQmw1Y2EvRGdaWEFsVVlG?=
 =?iso-2022-jp?B?cnZqMFFlU1duUUI4QlFHZ3dYYlhObnJDZzE3VWh3alhnbFJFdTBlUzUx?=
 =?iso-2022-jp?B?RnlHSi8xM1N0a2NKR3Q4N090bVVnUEtadGpiajFMckJCUlF1RzB2Z3BP?=
 =?iso-2022-jp?B?NDhnM2FxeGtJWGRuNytKUjFobUNzdGpQaHZ6czRROVRlSWx4VVVnNjBz?=
 =?iso-2022-jp?B?Uys5cXR1cWNjTmNwVCtaenROV3h2TnNlWEZ5VTZnWTdxOGdSQllQNkZX?=
 =?iso-2022-jp?B?Z1hQK2JIbC9RaFFqNVFIVWYyajUxTGVmSXVuemJRTjVqWmJ6MEMvNFJn?=
 =?iso-2022-jp?B?QWNRSnBLNkppWEQ1RlFuVTNBeHMrNEIzRWZ4RUVPbmUvNFREODZHL3p6?=
 =?iso-2022-jp?B?VVgyNFE4TDBRSitETEVldHVhK05DZzZNWTF6S2VTdXBIVjdxc09TREMy?=
 =?iso-2022-jp?B?NitYaXlmR3NhWHFHWkZjcXBrOUdwWG4xOGlHa3JqdGNXSjZTdkQ2SUdG?=
 =?iso-2022-jp?B?cURHVmxMNFBsQWwxUGZLOEpVeXBvaXd4eXE2RHc1QU5tVjlQWDJycWVo?=
 =?iso-2022-jp?B?K2t5eDN6QkJmZ2NtdloveFJDUk0xaUhYQWRMZlBldm1DRkdrcS85ZVlQ?=
 =?iso-2022-jp?B?OE5rbThjbXdNQVdSR3lVSzZ4NFVlTVN4ZUlsOUhWZG8vNzNMTzBHMGs3?=
 =?iso-2022-jp?B?UjZYeGU1cEx5cHlsNEt6WTg0TG00d3hYY3ZRNzl6eDZoNGsrMERBbzdL?=
 =?iso-2022-jp?B?Rk5ZUmZkSmVhcFozZ3hMV1FBUldwcXpnU0JLNXpNQ1RoaDgrUkJ6RU12?=
 =?iso-2022-jp?B?OHFoUVg2TkJLcmtZRXJxcGZ4Um11ZXl0UW5nMnZHeHo5Q09kb2tKTkRh?=
 =?iso-2022-jp?B?d0UxbXlQZk5PQ0hlYXlaZ2VxSzhBQm9QK1FZWG4vRmlqMSsxd2pTRENR?=
 =?iso-2022-jp?B?ZTdOb2pCL2JHRVk1b3BxcjZ2N09rcGUydWRxWEtUWFdkVytpYnRrRHdt?=
 =?iso-2022-jp?B?MHlFZXBPWmFHclpnTEhGWHZwSUxmaVRhWVp0T0Eva3pnZkpRcEZyWHc5?=
 =?iso-2022-jp?B?U0o0SkpzRkVINldUQTVjYzNUQ0VhVTBPNEpBUGhwWkMyYm1tUC9sV2h1?=
 =?iso-2022-jp?B?VGF6WkFzM0JpTS9Qci9PVWFVOWEyaHZQZ09rQ0hTTElVSGpnNFVxQTNz?=
 =?iso-2022-jp?B?MUFDZWtpY21wcXhkRHE5akFYVFF5dTRad2hLNmZtMVYxbCtvODdXUXdu?=
 =?iso-2022-jp?B?b0dYTHZIS1UzdnMvT29wQ2xXTitJTVpGbDZxSFlaTDl2MHNRbGFEK2d1?=
 =?iso-2022-jp?B?ZDZYTlR0Lzdza1QwdmgxMXNSM3IrcnEvQnAxaVJBd1dzN0xVMXc5cWNs?=
 =?iso-2022-jp?B?UVFheVd2R0U1c3ZEUW9CNFBpZm1RbDhXY1ZON0drMDlKaloraE0wcFRG?=
 =?iso-2022-jp?B?TjNHcElPc212UWdqUXhTMEpYUXFmK0NvZlFadWR5QUdmODd0VEZxem1C?=
 =?iso-2022-jp?B?aENxR3B5K0cxc2oweVl3UlZGMGdpUithRHdBRHVTWmN3WkZYNmFWTEVn?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QVI4VFFINklZeUZPUE8ydmFFR3dEMk0vUlNrK21UTm84Vnl1YlV3MTRa?=
 =?iso-2022-jp?B?SjRNOUhDUWtnUVJObnlwVE52TkxiaGt6RytheThIdzlWcVp2blNZT1VV?=
 =?iso-2022-jp?B?d2FnVmxRNndoN0hHY2VKTmJsTjl6RFNka3htZmp5MkROK3BUc3FKWkx3?=
 =?iso-2022-jp?B?WFY1a2RoYkpNN2hCcWhQZ2ZadmtvK1gwWHVmQTh6bk1uS0llZzlYRFY0?=
 =?iso-2022-jp?B?akVrRHloZ3F0MkphczZiOVJ1WnZBeEFwZWdpZWFLZmhpZE4xeTFXaHls?=
 =?iso-2022-jp?B?VFRLNG5VczF6eTRIeWFvWXRvaW42SkMzSnM2cTZmTUc5UGVmRHdIS1hB?=
 =?iso-2022-jp?B?QkZnanVsMHRlWUc5OWZMQVNySEQwdVlHejh3UGtWQStLUlBFaUVzL1Fj?=
 =?iso-2022-jp?B?S0pId2Nid3JKMWU4N280SlNRS1pnUllNRktTTFNtc0oxdEJWM1Q1c0My?=
 =?iso-2022-jp?B?cXY3Ri9TWlh0MzZLMWc5QnA0K2kxd2RkSnN6U0JuS3FORXdkSXZwcmlW?=
 =?iso-2022-jp?B?R0g0SFhYTExpR1FaYnNZZ3RNWE0xaGpwZXJOR0NBZDJydjhTWWtmcU5k?=
 =?iso-2022-jp?B?dlo0M0ttWTUva3ZPemE3aGxCaTJCVFp1R3NqbXJ6dXZubzhlWGhxdG1E?=
 =?iso-2022-jp?B?NDN0MURrcVZhN3lTcEQyUWtHdzBtTEdiT2xiWXdSOGhqbE9xNFFIMDd4?=
 =?iso-2022-jp?B?VWxsd1dMd3ZMRmhXYTJWWjlOZVdyZXRzUFR0ZnBMVGo3OWFBU3hmbnM1?=
 =?iso-2022-jp?B?NDFuUUFoYWhhbHFrcHpIc3VLUGY3Vnd6bnpuOEFML1FYK05rR3NyNzYr?=
 =?iso-2022-jp?B?RE1DT2R5bHNKemhYaVZCcHQrd0hKUUUrdnh6V0xOZVExaFdlYmplM1du?=
 =?iso-2022-jp?B?Qnc4QXJmcldrWVJyRVRvU0lvOVloZkM0b3JRQ1U4bC9jQ2dldEtpbERz?=
 =?iso-2022-jp?B?dlRqNGx3NGNDd2lqV3JHTFBqY0FqRnVuV2ZsbmRGU09nTXpucnlkcHN3?=
 =?iso-2022-jp?B?QXo4RGhkcjV6V1VERUd3akFYUXU3OXJEQksySE1YYjRFSFAwUmVIOE5q?=
 =?iso-2022-jp?B?cU9zT1hZMU5GSWUvWExYR3I0c0V5U21CVmpJZElRVjJTbHlXQXlZVXBs?=
 =?iso-2022-jp?B?V1V3bzBqamx6ZjIrbkFzQWp6ajRSMTFEZUlsakdTTjdvT29KRllGanUw?=
 =?iso-2022-jp?B?QTdHRDJEWTk4T2JHaE5FNHFMS3V2NG9OdG1NRFFCZEF0NTJBUUg2WEti?=
 =?iso-2022-jp?B?Q0hlS212NXBrM1VsSW9DbWVzOEpOUGV2dHU5czZZZXUrNTYwMWIxckhQ?=
 =?iso-2022-jp?B?Q3E5VUNzQzgxSzdqUGlWYWU3VEV5MnBHWXBCZGRJa205VjlJTFlHbW9B?=
 =?iso-2022-jp?B?SktrSS9HK1NEdGZQQ1dMVlNMdjdQcU5mQzh3NDRqdERNclFXL0VsdG5q?=
 =?iso-2022-jp?B?Q1N4RXFaNjE1MWYxSStLSkVYeHRTejVFaUQ1T1hZUG9WQTlyTWJUUldP?=
 =?iso-2022-jp?B?dy9odWRoRTd3bDhqZEtQbG43eDVDV1FEUmJPRkwxSUZJQmRpZmlEa25K?=
 =?iso-2022-jp?B?NHVEczhRekwwNnV3TXg5aEhwVk85SnpjZWsyWGc2cEsyWTROQ2hLN2xN?=
 =?iso-2022-jp?B?RG1vR0s4NGhmUTJ3YUhjWlFrcWYyeTlPT2lWcFJ1U2d3N1Ezb0gycTMx?=
 =?iso-2022-jp?B?Q0V0QzZLbXA4dGNCK0hGbVZ3WnNiajcweUQ0alB1dUZtamw0WHM2VWN0?=
 =?iso-2022-jp?B?ZUt5T3FFVFRLZ1lxZk5wNithYUJPc1NsUitjMFFYTmNVNWRiSkRIam5V?=
 =?iso-2022-jp?B?WnZvTnpHdEZYV1RERWxxYS9sbWxpeEhEQlZiV2tGSTVpbDBXUGc0eUpF?=
 =?iso-2022-jp?B?QWlOWTg2TThPbWtxZUhRcmQrRHBxR1pTSWh3amhZNVl2QVhTTVNER0VD?=
 =?iso-2022-jp?B?Vk9tYS9wN0dITjlVRlZiL2NjU1NldUZSN0lLcHh4MHlJU0RFbTFZbFo4?=
 =?iso-2022-jp?B?a1Q0QUVRKzQ3ZUdnZVl3RTMySTZyY3A0VU5BS3FZU2dYb0V4OTY4SVB4?=
 =?iso-2022-jp?B?SFljT3Bvbjd1b3dFU0o3VkhzV3RCV1l1Z09qcHZCWkIyMEtQZXZNTFRF?=
 =?iso-2022-jp?B?UjZLS3pmSEd1Q2czZWxmNE16MVFmVXhKbk1DKzVxUVN5ZzB5T1J4aUxF?=
 =?iso-2022-jp?B?YWRYSmJ5WVVrZVVWVDhIaTViUEY3Mndha2o2Umh4UkZZZEhaeFhySml1?=
 =?iso-2022-jp?B?UEhJK2Z6Y3dJQ1RRL1h1ekZuMFB2dkg4R014N25yNnpLbUVtaXZ3ZUxS?=
 =?iso-2022-jp?B?Y2RrckFrenlJU1NUZDdxZWREc3ljRjBQbjRoSHBubEhrd25RcWZLdndV?=
 =?iso-2022-jp?B?YUEwVUE9?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96699E420B7EAA6E49F50263C4FE2TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3bc752-086a-4420-85e8-08dc830fee8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 14:26:02.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Db2iz8AOM+Eiqm9T4qVTyRpTJ3GQ/bngfM68pLAdAOS6IfCc6UzaMeNToSw9rSe4aQpoATMqn4VRE2HsBjBGb/6ZOvvqqlv9XbVrkF+TtFqmJQjcyGWSvIQS3lU+MSAc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10462
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 02 Jun 2024 14:26:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16078

--_000_TYCPR01MB96699E420B7EAA6E49F50263C4FE2TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Kazu-san,

Apologies for the delayed response.

As you suggested, it is important define what should be tested from IEC per=
spective. The suggestion from BV is also to create a process to perform ris=
k / impact analysis for the packages that currently don't have any tests de=
fined and provide tests for packages that are identified as essential.

Thanks and Regards,
Adithya Balakumar

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Kazuhiro Hayashi
Sent: Friday, May 17, 2024 8:17 AM
To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.=
MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.c=
o.jp>
Subject: Re: [cip-dev] Preparing test evidences for CIP Core packages for I=
EC 62443-4-x assessment

Hi Adithya,

> We would like to understand your opinion on the next steps to take or oth=
er distributions to target for tests for the above listed packages.

It=1B$B!G=1B(Bs better to define what should be tested from IEC perspective=
.
e.g. python3 does not provide any functions and just for controlling other =
packages (like a meta package).
See the package description and contained files: https://packages.debian.or=
g/bookworm/python3
No need to prepare any tests for such package at all (at least for OS secur=
ity).

Some packages like base-files only contain data, which may be hard to test =
without concrete methods to use them.

Best regards,
Kazu

From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <=
cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> On Beh=
alf Of Adithya Balakumar
Sent: Thursday, May 16, 2024 8:40 PM
To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T=
!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp<mailto:nobuhiro1.iwamatsu@=
toshiba.co.jp>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: [cip-dev] Preparing test evidences for CIP Core packages for IEC 6=
2443-4-x assessment

Hello Iwamatsu-san,

Hope this message finds you well.

We at the CIP Security Workgroup have been working to collect test evidence=
s for CIP Core packages included in CIP Security image as part of IEC 62443=
-4-x assessment.

To summarize the work done by CIP SWG so far, CIP SWG investigated the numb=
er of packages in CIP Security image and tried to understand the number of =
packages that have test results available in debian and number of packages =
for which we have to run the tests ourselves and provide the results. I am =
including the summary of the packages below:


*         Total packages in CIP Security image - 242


*         Custom CIP packages (from isar-cip-core recipes) - 13

o   These packages are created by recipes in isar-cip-core or isar that are=
 deployed into image as a .deb file.


*         Packages with Debian CI autopkgtest - 140

o   97 packages with functional tests, 41 packages with non-functional test=
s, 2 packages with no tests running in debian CI


*         Packages without tests in Debian CI - 89

o   70 packages have tests available either in debian salsa or upstream.


*         Packages without tests in upstream as well - 19

There are a few packages that do not have tests defined in either debian sa=
lsa or upstream. I am listing the packages that do not have tests defined i=
n either debian salsa or upstream below:

Binary Package name
Source package name
Are there Debian CI results ?
Are upstream tests available
Remarks
base-files
base-files
NO
NO

base-passwd
base-passwd
NO
NO

hostname
hostname
NO
NO

libmnl0
libmnl
NO
NO

libnsl2
libnsl
NO
NO

libpam-passwdqc
passwdqc
NO
NO

libpam-pkcs11
pam-pkcs11
NO
NO

libpasswdqc1
passwdqc
NO
NO

libpython3-stdlib
python3-defaults
NO
NO

libreadline8
readline
NO
NO

librtmp1
rtmpdump
NO
NO

linux-base
linux-base
NO
NO

media-types
media-types
NO
NO

net-tools
net-tools
NO
NO
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests
Autopkgtest running in Ubuntu CI https://autopkgtest.ubuntu.com/packages/ne=
t-tools<https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/test=
s>
python3
python3-defaults
NO
NO

python3-minimal
python3-defaults
NO
NO

readline-common
readline
NO
NO

sysvinit-utils
sysvinit
NO
NO

tpm-udev
tpm-udev
NO
NO


As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do not have tests defined in ubuntu as well.

We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.

Thanks and Regards,
Adithya Balakumar


--_000_TYCPR01MB96699E420B7EAA6E49F50263C4FE2TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\6E38\30B4 \30B7 \30C3 \30AF";}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:ZH-TW;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:ZH-TW;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:215094890;
	mso-list-type:hybrid;
	mso-list-template-ids:633612152 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:696588672;
	mso-list-template-ids:-473123258;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:805049656;
	mso-list-template-ids:-1763964900;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:923612629;
	mso-list-template-ids:-929027262;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4
	{mso-list-id:940379066;
	mso-list-template-ids:1002331722;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5
	{mso-list-id:1056929347;
	mso-list-template-ids:1467258768;}
@list l5:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l5:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6
	{mso-list-id:1263219702;
	mso-list-template-ids:1603552136;}
@list l6:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l6:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7
	{mso-list-id:1890071985;
	mso-list-template-ids:329809658;}
@list l7:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l7:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8
	{mso-list-id:2021394710;
	mso-list-template-ids:2031911568;}
@list l8:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l8:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l8:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Kaz=
u-san,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Apologies=
 for the delayed response.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">As you su=
ggested, it is important define what should be tested from IEC perspective.=
 The suggestion from BV is also to create a process to perform risk / impac=
t analysis for the packages that currently
 don't have any tests defined and provide tests for packages that are ident=
ified as essential.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Adithya B=
alakumar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-fa=
mily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=
 cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Kazuhiro Hayashi<br>
<b>Sent:</b> Friday, May 17, 2024 8:17 AM<br>
<b>To:</b> cip-dev@lists.cip-project.org; iwamatsu nobuhiro(</span><span la=
ng=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:=
none">=1B$B4d>>=1B(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;=
Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none">=1B$B?.MN=1B(B</span><span style=3D"font-family:&quot;=
Calibri&quot;,sans-serif;mso-ligatures:none"> =1B$B!{=1B(B</span><span lang=
=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:no=
ne">=1B$B#D#I#T#C=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;=
,sans-serif;mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"ZH-TW" sty=
le=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none">=1B$B#D#I#=
T=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-=
ligatures:none">=1B$B!{=1B(B</span><span lang=3D"ZH-TW" style=3D"font-famil=
y:&quot;PMingLiU&quot;,serif;mso-ligatures:none">=1B$B#O#S#T=1B(B</span><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=
)
 &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] Preparing test evidences for CIP Core package=
s for IEC 62443-4-x assessment<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">Hi Adithya,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">&gt; We would l=
ike to understand your opinion on the next steps to take or other distribut=
ions to target for tests for the above listed packages.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">It<span lang=3D=
"JA">=1B$B!G=1B(B</span>s better to define what should be tested from IEC p=
erspective.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">e.g. python3 do=
es not provide any functions and just for controlling other packages (like =
a meta package).<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">See the package=
 description and contained files:
<a href=3D"https://packages.debian.org/bookworm/python3">https://packages.d=
ebian.org/bookworm/python3</a><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">No need to prep=
are any tests for such package at all (at least for OS security).<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">Some packages l=
ike base-files only contain data, which may be hard to test without concret=
e methods to use them.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">Best regards,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA">Kazu<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Yu Gothic&quot;,sans-serif;mso-fareast-language:JA"><o:p>&nbsp;</o:=
p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-fa=
mily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language=
:JA">From:</span></b><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:JA">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;
<b>On Behalf Of </b>Adithya Balakumar<br>
<b>Sent:</b> Thursday, May 16, 2024 8:40 PM<br>
<b>To:</b> iwamatsu nobuhiro(</span><span lang=3D"JA" style=3D"font-family:=
&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:JA">=1B$=
B4d>>=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;Calibri&quot;=
,sans-serif;mso-ligatures:none;mso-fareast-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;PMingLiU&quot;,serif;ms=
o-ligatures:none;mso-fareast-language:JA">=1B$B?.MN=1B(B</span><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:=
&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:JA">=1B$=
B#D#I#T#C=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:JA">=1B$B""=1B(B</span><span la=
ng=3D"JA" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:non=
e;mso-fareast-language:JA">=1B$B#D#I#T=1B(B</span><span style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA=
">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;PMingLiU&=
quot;,serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#O#S#T=1B(B</s=
pan><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures=
:none;mso-fareast-language:JA">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a><br>
<b>Subject:</b> [cip-dev] Preparing test evidences for CIP Core packages fo=
r IEC 62443-4-x assessment<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">Hello Iwamatsu-san,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">Hope this message finds you well.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">We at the CIP Security Workgroup have been working to collec=
t test evidences for CIP Core packages included in CIP Security image as pa=
rt of IEC 62443-4-x assessment.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">To summarize the work done by CIP SWG so far, CIP SWG invest=
igated the number of packages in CIP Security image and tried to understand=
 the number of packages that have test
 results available in debian and number of packages for which we have to ru=
n the tests ourselves and provide the results. I am including the summary o=
f the packages below:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol;mso-fareast-language=
:JA"><span style=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Tota=
l packages in CIP Security image - 242<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol;mso-fareast-language=
:JA"><span style=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Cust=
om CIP packages (from isar-cip-core recipes) &#8211; 13<o:p></o:p></span></=
p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l0 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;;mso=
-fareast-language:JA"><span style=3D"mso-list:Ignore">o<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Thes=
e packages are created by recipes in isar-cip-core or isar that are deploye=
d into image as a .deb file.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol;mso-fareast-language=
:JA"><span style=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Pack=
ages with Debian CI autopkgtest - 140
<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l0 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;;mso=
-fareast-language:JA"><span style=3D"mso-list:Ignore">o<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">97 p=
ackages with functional tests, 41 packages with non-functional tests, 2 pac=
kages with no tests running in debian CI<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol;mso-fareast-language=
:JA"><span style=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Pack=
ages without tests in Debian CI &#8211; 89<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l0 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;;mso=
-fareast-language:JA"><span style=3D"mso-list:Ignore">o<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">70 p=
ackages have tests available either in debian salsa or upstream.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol;mso-fareast-language=
:JA"><span style=3D"mso-list:Ignore">&middot;<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"mso-fareast-language:JA">Pack=
ages without tests in upstream as well &#8211; 19<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">There are a few packages that do not have tests defined in e=
ither debian salsa or upstream. I am listing the packages that do not have =
tests defined in either debian salsa or
 upstream below:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"1261" style=3D"width:946.0pt;margin-left:35.85pt;border-col=
lapse:collapse">
<tbody>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid black 1.0pt;border-bottom:none;background:#8EAADB;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Binary Package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Source package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are there Debian CI results ?<o:p>=
</o:p></span></b></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are upstream tests available<o:p><=
/o:p></span></b></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Remarks<o:p></o:p></span></b></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;heig=
ht:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl0<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl2<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">pam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpasswdqc1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpython3-stdlib<o:p></o:p></span></=
p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libreadline8<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">librtmp1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">rtmpdump<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:45.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" valign=3D"bottom" style=3D"width:419.0pt;border-top:none;=
border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wi=
ndowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><u><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none"><a href=3D"https://git.launchpad.n=
et/ubuntu/+source/net-tools/tree/debian/tests"><span style=3D"color:black">=
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests</span><span style=3D"color:black;text-decoration:=
none"><br>
Autopkgtest running in Ubuntu CI </span><span style=3D"color:black">https:/=
/autopkgtest.ubuntu.com/packages/net-tools</span></a><o:p></o:p></span></u>=
</p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-minimal<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline-common<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit-utils<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><br>
As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do
 not have tests defined in ubuntu as well.<br>
<br>
We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA">Thanks and Regards,<br>
Adithya Balakumar<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"mso-fareas=
t-language:JA"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB96699E420B7EAA6E49F50263C4FE2TYCPR01MB9669jpnp_--


