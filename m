Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516ED6D245
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 22:15:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.83468.1732745732832582645
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 14:15:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=V90G/+RM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1732745730;x=1733955330;bh=JU
	F0ZUMqNzf5Bn3G0uPTiaZA+Q6LAsrYVWr5IcBK3PU=;b=V90G/+RM5FTsvPszE8XFk4VVKRQkav/P
	5zzAeH5WdJvP3+g2HuobGrTPrH3SsYL6eIypDVMkEySVmj2TltLGOQlkEcgocVFZ/P0z66GtduyAg
	DPG1lsbBJGKpSRefr3YNywbZrp8TJ9yoybujyxkc7AAU0ibQJgmeDtzvtbBaFwhxjTqTFF3USqhs0
	KIn4kIyOpFv3z8n29OpgZHcXIFzCJv4+4+4J7LIawQxbPsEyzk0WBkT5OyHQ1k76lvSRwIzRG7xL6
	+IZI0V5W5N/87wgk0CwNz8W95uwfHT/AGVBcvmZq2YmXDnCf5N2vS9zPXiAGeQOoEqLcLWjyvml6X
	sg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4ARMFUOg3328620; Thu, 28 Nov 2024 07:15:30 +0900
X-Iguazu-Qid: 2rWgEj6YkWQLzwqvdC
X-Iguazu-QSIG: v=2; s=0; t=1732745730; q=2rWgEj6YkWQLzwqvdC; m=vgl2grHb5CenntIMVuDBVA5VX2fxuifwh8SpVvbCfvo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4ARMFSVJ1458133
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 07:15:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuuUlbSFVEAQOo0z33hNK2vKtNtVK9hVPTlWmFGIQV0zMOKzEwwM30QE8yJgCopIzLAdhA8pV6rHjVTyRn20W5DUIxjjP5Iomf6eWhSk7u8ozRVg2c2pxjeyGGCjH2QA6hjq8N/Y5yVfSzGOmiLQ6ZtMLPPpRQx6asoDdpBre3pl+e4Sws5gaqAzuvvNvckS5e/NT11i8ZJZfV6pA2Cj8Vf69O6hqj7PLdqd7nTulcs0iH1xMF3dzLvvwzcYPZViEDrj78A4lig0fRmK//pkhmteiALJ4MbP1Tu7vgCI7X+TFHvW3BAQhQiZr3ZHiMRltFGz4mi9q6tr0y4x1G3LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kvNERsMMkyh9g5RfGeHlpxrZIhZeki6Mk6B788A+Mk=;
 b=uVb4bvqwOWuHYu84XmKur4tyxkhpsyGwL3W5Rd9tsJNEV+bqVA8EbJ3ghQZiiMPUSnnxODhgpQCezw8VoEpvXI0NjxVFQk+mLxCQiUlB6TS6bRScymbTZ4FEm2d9pafLalRveirE9/9f5WKionlp0uzTP3h+NFKezppg/sgVMNpDP0rS0Y2c0Un+R1Hxd36VwyVizleuqEyWIxhGizjhQqx7LXz6Un5+YtmrGpkhNtGAq+SUrUPjaw/oAX8cT78cYe/4IwWIkBCkmMQRdfEMqsVZgkUFEepXAm1ieowkXpMYHCFZtos3vw9sCW5tySUnOA03Fw/tUxFcHYSfUvmj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat (2024/11/28)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2024/11/28)
Thread-Index: AdtBGP7xUWTxmW8dQt6X+l0ef+eZxQ==
Date: Wed, 27 Nov 2024 22:15:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638817482BB139A6D14C24D692282@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY4PR01MB12944:EE_
x-ms-office365-filtering-correlation-id: d5ba81b3-0b8e-4d6e-14cc-08dd0f30fec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RS9WS3ZRZlc2OGdkVGxLRlg4dFcwOXQ4b3FPZTdieEVJdEs4TnNiYU9i?=
 =?iso-2022-jp?B?SmZYdU9kREUwMzQyVGpmSUtpUUtWN3h0WTFMZGZNMHNJcUlTMUsveHlr?=
 =?iso-2022-jp?B?N1B0MTFnUkhJaXc5c0c5OThWYndNVUNkazNGb3FUZjBZaVd4R0N5MjF4?=
 =?iso-2022-jp?B?MHFTVTQ1cDFLTjFxTWtVR3hKT0VTMStWUnBTU2FxM2oyV095cGh3bURp?=
 =?iso-2022-jp?B?T25LSEJwcjFLZHBsRmtPWlhaSlJveklZOTk2VkMxZEpzU3NQN0tjMW5q?=
 =?iso-2022-jp?B?WUp1ZExobzFhTEJ2Z1RXZzFKZi9xZmZsWTVBVCtXSHRTcXVCU0xkRjZx?=
 =?iso-2022-jp?B?WnIwT0Y4QVdKMDBLRVNPQW9WMEE5RUxFcGtRYkhtbHNrK1I2a3JiczYy?=
 =?iso-2022-jp?B?WjJHZHUyeDJUQnJUM1EvTjZrTW90cVZSK1pUOUZlbW0zbjMrbU5Wc2Rl?=
 =?iso-2022-jp?B?MWFCcHpmVCs3NHBlOWJoQStneDVpVGVSRXlBZGNXb2R0a0RXQnBtY0xX?=
 =?iso-2022-jp?B?ekRGRlBtK3M4VHVHQ2VaU1c4UFRyMzNCOGF6OXVTZDdvN1VRMDBKVVoy?=
 =?iso-2022-jp?B?MEJ5QUFIK0tMNWdkL3Rrbm00Zi9BaERlN3hwMHFXWWk4SjNkcmp5dkdt?=
 =?iso-2022-jp?B?V2VjMnY5TGg5MmpVZ1JPWEJWczQxNkZrTll6THVZTGZXWEJHNGRwYldB?=
 =?iso-2022-jp?B?a3l0bDFFRUFKTFgwNDJWL3RxTFN4b3pTdnpBeUtPWDZrSjFETUk1RDNa?=
 =?iso-2022-jp?B?QTB3ekxVWTZyUHdOcTk2VGxGVjlzTFN5S1Z6WGV4dzNkY2I1YkNEdFJr?=
 =?iso-2022-jp?B?T29rakUrNVpVTlQvUGdaalNjY0kyaTVxUlEvNm9STHJIa3h5d2VNNHM0?=
 =?iso-2022-jp?B?ZGtFU0pkSzV1VzRka0ZzNVNZeW1FcUs0TjNLZm50blhTN2JWTi9Qa1Y5?=
 =?iso-2022-jp?B?UFpwNlZ4cUJCM3lKREVTeU5hUVh6WkY0WUcwRE02NkkvSTE4UDBXL3Ny?=
 =?iso-2022-jp?B?SVFjcDl5cmdZN09wd0M3VXJvL3FsWHp6TU1NLytYNXZEbGxKOWVFdVZq?=
 =?iso-2022-jp?B?dUcyYndjYndPU2VHZ1pIQStVajlxandETEpQai9NMzNtOEd4M3pPZWx1?=
 =?iso-2022-jp?B?aWdFbnZCOFA2Vk16a0JVc29tS3ZKTWptejZjZFVuZ1dEMnAwclQ4ci9M?=
 =?iso-2022-jp?B?NThCb0JadFJMdDFvUXVLTFBmazdISGFhZjgweWQxWmRORzZobGhEWmFs?=
 =?iso-2022-jp?B?NUJ2cmZFYmhQNFcvVEp2aDlBWGpwQlgwMGFKd2NmWUhCbmlHZGVxazNW?=
 =?iso-2022-jp?B?VmRFNGJ3cUJ4TWswSjdsR0YyZkZnbXgvcC9mQkhxaDJNMVhGdTRTQ1hY?=
 =?iso-2022-jp?B?d3c1L1lYWlRJa1RsMFYzSUs5cW0yOWhxZzVLSUk5WFFVZVR2WHl6MFhS?=
 =?iso-2022-jp?B?bm9mdmNoRUNxTlpLUVRDbVJEa1FkcDB5TG9YMGtEYkl5V1ZvQk5NUDRE?=
 =?iso-2022-jp?B?eURGcVdBUVFjcmFPanRFRFlVZWhoYmViUnhPd0MvTWE0MTZlRzBrMy9z?=
 =?iso-2022-jp?B?Y3pKQ0NsbTZRTDdYcjBsRjM3eVFtWEp3azFOR1RVZ2JXdVlkbEF3MjNG?=
 =?iso-2022-jp?B?RnJrYjJ6Sk0yZkxFTGJVbHU4WVNJb0IybWtSRjlnTHZJY0VFK3Q4L2c3?=
 =?iso-2022-jp?B?cHBQdldFUzRIMnJSRlN2Z2x0ajkycGNHRE5nNnE5QUxsRHpQeTZVOU91?=
 =?iso-2022-jp?B?Qm5YVGo4bHRMQzhxT0JsWFluM3pINUVUM0E1azRDMmRINmRMdFRvb000?=
 =?iso-2022-jp?B?blI2UmExZFNtRmJPOVZGeHE3MVFPNi9HVlhza0RCMzUrTTgxeGJjM2NP?=
 =?iso-2022-jp?B?MGNzWHYwT2NRa3RqRGZ5cVNOSCtJWWI0ZWEzMmtHelRRVktveXdYQ0tw?=
 =?iso-2022-jp?B?V2xXcmdwY3hGZlQrWEtNSWkvYW13WjR1WnVJY3FXc0kzSS9EN3hOM0N2?=
 =?iso-2022-jp?B?L0p6dzk3M3FuY0dDdU9EVHdMVVB6WA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a2VjS0QxQTFhbDhaYzF2Wmp4Z2ZCT2RwMjlXSnkrQ2JPWXFNTEVyMVZ6?=
 =?iso-2022-jp?B?MlcwSE9hYyt0dFFneWxmNXZTazF5TDhRUkxtaUl4UnJvZHhyaDF4eVMz?=
 =?iso-2022-jp?B?NzlMaHY3TFdHc3VtR2NpVmZJYzY3cDRTMHVFMFIyZFVKTEQ5dFNNeUpB?=
 =?iso-2022-jp?B?VU5sNGo3UlEwTytnbXY4dmhjREswY2hoeGVrdStQcWt1VWU1dzRPWm1Z?=
 =?iso-2022-jp?B?d1hSYnFnejZtVFJIRlpLV0ovOGduY0hEd2M4ejVVZWdEMlMxZnBxN3pV?=
 =?iso-2022-jp?B?L0ZMcFJhdCtTV0I4RG1uTHowVE03eEUxbUVQWHhPZlVjRitHdytQWTgr?=
 =?iso-2022-jp?B?eUxER0JISVJ1eVVlS28wdjhJVGVvREFUdkM3citFTkZ4T05mSWFyd043?=
 =?iso-2022-jp?B?OWE5R21oUVZjK09QbDhHRTVsdVN0TFVaQjVuR01vSXpmSElWZTZvZFVF?=
 =?iso-2022-jp?B?TnhKanY5aE9vUE1BRTZ1eUxVd3E5Q3NjZWE2ZXd6UFNHaTZqcEZjd25D?=
 =?iso-2022-jp?B?SzNHUXZldjNvSTd1NDhRUHJtVk5nSXlLWGpMZi8rU2YyaWYyNVNUenJm?=
 =?iso-2022-jp?B?Y1NLU3FLM3A0eFU1K1FESGJRM25SQUNwK0pwSFFheHZiMUU3YUthNHVT?=
 =?iso-2022-jp?B?SlkyZG91QjdTY1hORXlXdzBtN0tHTXdMTDlteTZmeTNnWG1OSGZnNng3?=
 =?iso-2022-jp?B?NWtKUlpOU3czNVE5YVZnalRHSVA1aDFTNXRNMnI4OHA4QUJuaFVucmNt?=
 =?iso-2022-jp?B?UEtJbjJqa1Y3NXZoRmlzY013U1B5VmdFUEJFYWQ4S3RLejNYRXFsdkVD?=
 =?iso-2022-jp?B?RG9HeFpSMlBiZDd4aHhmU0NJM0tWVFNTbVhRMTE5bU9CeTdhcFk2WFps?=
 =?iso-2022-jp?B?L0puT2dFRnFFNDI2Vjk2NHZEK2RBYXlnVnZjTkhSWmhRTkR0UDQ4dW9u?=
 =?iso-2022-jp?B?YzZkNzZWc0w3anJwaEVZeEZsZGxmWVk1NGs3MHVzSkprY0I1UmU5WWpY?=
 =?iso-2022-jp?B?SDBYZ1pvdXF5NjBHSG4wTUlkek95TE9uYVQyQzVlMFIzdlpjdllmN000?=
 =?iso-2022-jp?B?SGkxS094RllYVVhlUE5UMHVObnR3OEx3VWQ4VUY0V0Q2Qjd4NzhyWjZT?=
 =?iso-2022-jp?B?YThYb0V0T2Zzb3ozNjA4a095U3FKcmVucjAzRGthTmtTbVVCVDdKV2tB?=
 =?iso-2022-jp?B?cVAwcUF4bEJMM0R6dG5kTHUyZGtHUUJDTjNENXR6Y205OSs3SUZvMVRz?=
 =?iso-2022-jp?B?ajVVU1BZQmROSzdTU3d6REdNZ2JzOC9GQzZ3UmNKYnVoMXlwemQvQlJo?=
 =?iso-2022-jp?B?cFJOWXhUdEV4cG9SK2s5ZVJJK05UU05GOTRjYjFHekloTUtsREt0VnBZ?=
 =?iso-2022-jp?B?eGhoMTVDSFBEZGdmMCt5R1FsMkM5KzRUNmJkWThkejFXZWZXR3krUElN?=
 =?iso-2022-jp?B?enMzeGI4MVBvL2xkZFpmMzhoc3puakxhc3lmYTJtRDhrM2ZlOXhGdWtK?=
 =?iso-2022-jp?B?eDl0UmR1QU1zVG50T0dLT2xBZ05MV0pzRTY3NjU3UUtBd2dGT1NSakZp?=
 =?iso-2022-jp?B?T2dYY1o4NzdXVXM4by81d0JHcHEzOXBtQ2pDV1RVbmtETGg5R2h0VnA1?=
 =?iso-2022-jp?B?Qm5NemZXUUgrWVN4OHJWQzArZDJKNDk2Z2hMaTJIZi9tRGR4VG9hMWRI?=
 =?iso-2022-jp?B?ZllJaUFWQlM2RmFBY2dzamllT0V1bG15Z2QxS0J2cnlzT2JuMFV1WmdC?=
 =?iso-2022-jp?B?MnYzZjNjZGJDT1Q5dGtDWU96RmtFZUdvUWVKYjhUei8rOGZCN094bFRO?=
 =?iso-2022-jp?B?eTNCY1QrWGsyM0gwaUM1Ym9zS25PYXRJUElKMTVBZVpZclBRY1diT0hX?=
 =?iso-2022-jp?B?K21QbndwbjdEZFliU3QvMEF2NjVOMzJpbHFaMGh1RUpkNm1xWGNXbEFQ?=
 =?iso-2022-jp?B?K29yREExcGNucnpMUlFUODR5QmhxdHBYYXlVTWhzanJkaHNWTkxZbXhZ?=
 =?iso-2022-jp?B?RWVJYWFoWnFOS0h1alI2UzJRN3RkQkkwOERDTmFmb2RMTUorRGxXRDhr?=
 =?iso-2022-jp?B?N0xkY2Q1cmVkdGNKUzVCMUFGWlE0dnY0Z1RLblB0RWFYUThqY0d3YUlC?=
 =?iso-2022-jp?B?NUE4a1hLUmJLeTc0YTRUM2xhd3dMejdpKzVYZTMvYXRZOWVsUGYvOXJ2?=
 =?iso-2022-jp?B?dHF0dlRlN0oyenVidmpOU2taS1pZRkFxOVgyZTVjeGxQRU13d1VtUzlZ?=
 =?iso-2022-jp?B?cFJjQVFYR1c2eXYzamZwZlhQSFRMbkk1cTdmdFNBYXhQR1BmU2h5SzlV?=
 =?iso-2022-jp?B?UHRkNjFpTnJDYUFrQnF6aEpvZ0VEeHVBV0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ba81b3-0b8e-4d6e-14cc-08dd0f30fec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 22:15:26.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhW7Bsmi+wxmzF9VVWeEJYSSmiWv8QwQrIxhEjKXadNbCo/bGHq/Ktaw8+96uUue0Rk6YBUS0FI2S20HDQZfM/kSFpXumAkCePS6qdn0v4T8bqOk50oTLjcQKsPzt8/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12944
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 22:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17296

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mont=
h=3D11&day=3D21&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-21-1=
3.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - meeting host for next week (28th of Nov)

Best regards,
  Nobuhiro

[*]
Date the data is created: Wed Nov 27 10:10:00 PM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip93
  latest version release date: Mon Nov 25 06:15:42 AM UTC 2024
  limit date: Wed Dec 25 06:15:42 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip91-rt51
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.323-cip114
  latest version release date: Mon Nov 11 07:08:57 AM UTC 2024
  limit date: Wed Dec 11 07:08:57 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.322-cip113-rt38
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: late
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.229-cip54
  latest version release date: Mon Nov 11 07:28:28 AM UTC 2024
  limit date: Wed Dec 11 07:28:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.229-cip54-rt23
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version: v6.1.118-cip32
  latest version release date: Fri Nov 22 09:04:06 AM UTC 2024
  limit date: Sat Dec  7 09:04:06 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version: v6.1.112-cip30-rt17
  latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
  limit date: Tue Dec 10 11:47:28 AM UTC 2024
  Status: On track


