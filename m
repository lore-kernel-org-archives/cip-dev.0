Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F48C7EE2A
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 07:35:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.3062.1750750524783267711
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 00:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=k+4kfzLQ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750750513;x=1751960113;bh=l1uGLXMWUW5I/YjpMumuk8faAU8clrw9KvDb0E1
	PLJo=;b=k+4kfzLQQvTjGog+FMFHBL6lWX/4QtYeeP/WZDHWaZ4qAGFq6WNJW9Vq85KWBFpb1vCzN
	qmk5PNVH7MXXwxV6U6mepOFI1JRbQZ/62/p6+Ux7Worm5P+8R6kedOIaVn8exqfsj0zDepedL09km
	Tqr6fnaVHgEygnvLdJ9jYKYOksbNjs2R6rIlDvtxGq7idKx+172NWBGOAnYqy8BpHTsmahbvQbguu
	IbpUzhtDnIFhgT8nmu9VcOl6COLd7J2ocjrruZDKkEZU5F4TjNjACwB15jjEz5MavwcdJ3fI4+iHh
	7+EFs46QuYgGXuxOCsPGbcq71SC2b5zptiVZCu0g6A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55O7ZDbs238838; Tue, 24 Jun 2025 16:35:13 +0900
X-Iguazu-Qid: 2yAbUt1VHaTdxM33Bc
X-Iguazu-QSIG: v=2; s=0; t=1750750512; q=2yAbUt1VHaTdxM33Bc; m=W6Hbr7PKhrG0+7CtbZPZ1NqfK9gOKvGcXIjy4HrS0P0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 55O7ZBFn1952530
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 16:35:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jymXrdW4rBR3o7JgSKJ8f5FtFbUSvJfHvCVkjJmoHnWqa/jwhrV6u420Rsoab/p917mZwMNl0ILoFyiKb7GK92HXsW1P8TlwPBqoNmaJINZzy5CsyJsCfRLYudGRhDwVh5nOHBeesqFOvFtcCrq/0HOmX/3HS8KwofD2BOdgvgbYLqtn9NdAXXZOoyczD8Xkb4SpBtUHxdHeUiMA1QqyFKlhrDQKSkPzNeIiFMt+FDKZSr3tqpretcbiYk3c3quGQ2f5LQfG+2erAcyBHxTImeOLTDjyBO19TSlRalTmQAYdzlBn6J7zjHyg6mtPIAIVg6wr0xtqA5xmL1Wc8lbGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTYW+XDWE2OA7F7Te7cmVI1rNI3+ZPkegvYzJ1DlqwM=;
 b=wBFk+UkOJjwHoPlvOZk3v02J54W9tkkZP3sCZRSRXs/W9CO4bEuFWdB4poMYYbz1LcesUyLnUTAl/oXAr5RejLB/AIJM/lYLb50ZaE38KcLmsi5VHA1oEqOG0888wTXJ1hzLFvXOidRTg8SdWuH61rYjJ08LU/EjTgGa6aTkACzQbOHX4uE/XQhrzLpkBs3TtNHZH7AoAwrhYECZiNyqrlxu74nVdzRYOGxIu5McC4oFQLtX57c9yFdQsrX6rJNi2TW0QgSMW49mFDpbnJahwgoSk5dI9Yi/BN5lExbMqw5PwmZXERvYA7slBYKIQEdeinu6RL3kue3f6xMY5Zz3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 00/10] Add support for RZ/G3E SDHI
Thread-Topic: [PATCH 6.12.y-cip 00/10] Add support for RZ/G3E SDHI
Thread-Index: AQHb5E3sgmQ0Z+yQq0qBvhs4eXK947QR5qpg
Date: Tue, 24 Jun 2025 07:18:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185605EC0D8AD4B8DFB7D89278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11828:EE_
x-ms-office365-filtering-correlation-id: 89c683b3-2512-471d-7bd2-08ddb2ef545d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M0x5REZldVczbmJsOEUxRFR1VTFYTXVvdEkzWGdURmQybExvYnRQbXpR?=
 =?iso-2022-jp?B?WXBlTlljTmxxZmhQRXBGbGRlR29EOEJnblh6NXZscWZ5bFhYdlZLUm81?=
 =?iso-2022-jp?B?cXFXbjhsdTMzQ0NCaVR4SndlSE1TZVFrbGIySTdtdEcxQWZLUXI4dmxn?=
 =?iso-2022-jp?B?TUx2VndLcVp3UEptQ3VMWnZmV25hSEVyZEJqMVJoaGdqOUo4UnA2UmRs?=
 =?iso-2022-jp?B?c2RoSEdlRkpUaHJFUGRLTDQ2WHI2dkZvdTIzOE15NU1nUU51djJ6MklU?=
 =?iso-2022-jp?B?VmVpcjN2dTJHSFVEbk4xK3o3U05DamZUZTlUdllsUktKTENlZEtYdXFY?=
 =?iso-2022-jp?B?ZDd0N1l3ZUFZNjJmVll5WmR5cCtyZTZpY092K1FHNVBvaUIrQ2JVdVAv?=
 =?iso-2022-jp?B?T2RKclM0U2htVWNQRUl1YU5KU01CU0Rodml6clBkVHZZS1pGNldJZERq?=
 =?iso-2022-jp?B?UjI3aWRUdmxiTWY4bGFVZHpkUEt6WWRzRXFuUTdQelJwUTFtSUVvbFAz?=
 =?iso-2022-jp?B?bnBmMVlDZHh6dk9OUC96UkNIbk1IbkZ4QjI5ZFpOUWRLQWpaWGpsNnV5?=
 =?iso-2022-jp?B?dm5QY3RybnQ1YXVyajhrV2ZVTmI4dmZHRHhQMXVFc3FwVVlyemp1aUZR?=
 =?iso-2022-jp?B?V21kWWVubXlhYmYyUk5XZmZBbTdWK01LczFueTd3Z0w3MmdjU1Bzcm41?=
 =?iso-2022-jp?B?RHFCMFNIOWxuT1ltb1lkMUlOaDlDVHBITHREK2prN3dZSUZkS0piYVNj?=
 =?iso-2022-jp?B?VHNDQzFIellHVGhzK2k5akpUdm1JMDdFTU1MYnQ2MFUzbERLN3ZhdmJS?=
 =?iso-2022-jp?B?RFB3a0V0dzVacUI3MmVmcmhhSWtEdGpvc3pOdVdiU3hDbGFRQ0xtNWll?=
 =?iso-2022-jp?B?Wmh5dWxPUzhhN3lhVXVseHltV3hBdG5sYytaSHVBbEpZcmd3eFFaU2hx?=
 =?iso-2022-jp?B?Z3BxVWxPdW9Xck4rcHIwZTRFalFBWiswOVdGd2J0L3JBc2tKalFPU2V6?=
 =?iso-2022-jp?B?WVhYV0srZFRWOWpDdHBSK1ZSN1FUM1BFVllnbkxpZ3hGWVB5TXQ4eTZn?=
 =?iso-2022-jp?B?dndTTG9JV3FBTTl3d052Z2RGUWZtUmN0dUsrMWFrSGRlWFl5aEVJWGpC?=
 =?iso-2022-jp?B?Z01kV2tTZkU5Sis5R3BXbTZNUmkxL2FmY3VqY2F6WE1paEcxYXgvU1RC?=
 =?iso-2022-jp?B?Vy92SmcrdWpYdmova1ZLeTVhMHQ3a1huczlJeGcwUWxQY2RNaFRzb3Iz?=
 =?iso-2022-jp?B?MlNDRjhKUWNkYUZ0T1A3UDlHNjBLeWJyQ0tDN0ovUitEaE02TWNLTjZI?=
 =?iso-2022-jp?B?aC9jeENneU5mM09MNHdGMUNCUEppN0ZYbEk2bmdETGJoOFhiU1BBZk1n?=
 =?iso-2022-jp?B?d2VhZlNScmZZQUhxR1N2cGxJUzlLWTVSY0RTMms1eGdWdkVhNlFEYkk2?=
 =?iso-2022-jp?B?dGRQV0Q2UHVFbXg0WGFKd0JJZ3QxYXphMGcvODUrZEc1MnRmZWN0Mlc4?=
 =?iso-2022-jp?B?NUM4anVQamNqcjlsSEZaRnk4RnA0TUZhekdQNmp0dzBGL2M5cXpvczlX?=
 =?iso-2022-jp?B?S3lKcmVRTXlBMFVaa242aVJrQVg0WWJGTi9uQXNzNjBET3MrMVpiTHl4?=
 =?iso-2022-jp?B?TG9ocGdGMEYyeHNWWk4vbjFlLzhjNk5kUHhKS3U3T0pLWVg5Und5Rlpv?=
 =?iso-2022-jp?B?alRyNE5VajJDamZkZ2grQmtzNU01L1A1bWVOOTQ1bjlycnczR2duc3Zy?=
 =?iso-2022-jp?B?bXI0cWNoRnY3dlduR2FTZzV2QnpPOEt4VmRDdlZkNGhXSGhPcEJVelll?=
 =?iso-2022-jp?B?Q3M5UjdwQVZXSUVKYWFaKzdwWThOVEd2SzZzRjZRNVMzYU52OExDZm8y?=
 =?iso-2022-jp?B?TnY2ZWhWUTBjQlAvTkRsNXhlUzlHZFNoRmExWDBMb25sZVBxbnFaaHR0?=
 =?iso-2022-jp?B?U0dxa3VaeG0rSWRTNm5Ub2ROUzhXRHppV3p2SnF6a3ZSSW5wVHhsOFJh?=
 =?iso-2022-jp?B?c3J3T0krS1NBQnVXRldRWmpYVWxDd2tpQ2FZQmJYL2R6VmZ1NEtwdkRI?=
 =?iso-2022-jp?B?MENqcFpFSG4zY2NBY1BHdGhmOStnTmdIUzIzQ3BUUytlZGE2eTB6RXZP?=
 =?iso-2022-jp?B?MWprdnpweFZhM3ZuVDcxalRvVjUzOGptbElDMEdUQTdxcnpON1I2bzFt?=
 =?iso-2022-jp?B?MHlVPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dWRMS296Qm5lT1BwUTRMeTVUSCtJdDkra0c5VGc4K2R1Q3JUK2ErZkNO?=
 =?iso-2022-jp?B?TG92MDJyOURXOGxuYTU4TVNHc1dYYU9JdXdicHJBQld1N1lqVXNOSkVO?=
 =?iso-2022-jp?B?a1U4cXpoNVZlZ2owVzB3eFBrVk1RdHM0dVBsY29hZ0RyUHpXT3p3c21q?=
 =?iso-2022-jp?B?a284aiszOFFYREoxSU5icTkrYmIyT2Z6aTBrYnhKQ1V5KzFSejhkNWVx?=
 =?iso-2022-jp?B?WS9NMFJSUnA4T0dWZjZTbWlQTk55eDhvTEJIaVg0RG8wKzVZN3RPaWly?=
 =?iso-2022-jp?B?QmxNc2hrbGRBdjVOQmxLQ3dKZG5BQ2J6SnVTdmNiS1VYUTEvYUZBYzdw?=
 =?iso-2022-jp?B?VWx1V055UVRSSStseGx6RldVc0dGdjJXdXNpSXBwZENUU1M2SFFqTTVD?=
 =?iso-2022-jp?B?b1ArZGRVNTk5T0RFWDRwY0lSdTIwL2x3UFNFN285TUl5REhGbm5hWkY4?=
 =?iso-2022-jp?B?ZUNNZUpXNnlMcmcyT2h5YnhDU0hDSEVHRGczaUFjdmxFZGYwVTVXOGlP?=
 =?iso-2022-jp?B?d0ZhMHZ4U2d3NGY5bzd2bHJrOWZUWVFlaWN6QmdjcTN4VDJWQ1FKbk1B?=
 =?iso-2022-jp?B?VnVXN0wvN3UwRDdMZnVaMFIwajZWZCtaR3g4cjJ5OXRocGI1RXdIZ3ll?=
 =?iso-2022-jp?B?TlZPRFhUVjk0cGJZSEdpWXE3OUtHV3l3VHc3VytReEhiNG92UU53WWpN?=
 =?iso-2022-jp?B?cStlMEU2UkZja0ZjaEdrVStjelNuYTBGVHRwTjhjV3NPY1VSNU5CdHhD?=
 =?iso-2022-jp?B?THlaVks3UlY0UzhtRGtRZCtHUjJ2VG5BR1VFc1R2OVNFREFWVUEyTU43?=
 =?iso-2022-jp?B?cmt4MEpPdjhlalR0KzVyM0k4Q09aVXJYVWIyTDk4bnBvV1RkRG9lTFFZ?=
 =?iso-2022-jp?B?RmVLNXc2T2p2S2RxUWo5WDdYUkIya1VqclRNd21DbUI1UEdBTDlzNWJt?=
 =?iso-2022-jp?B?M05xNEhJanRJMG1WZlIyTUI3TWlvTFFJSXZDSjJaTmU4SWI1VG9ibVJM?=
 =?iso-2022-jp?B?SzJ0UllFUmt2QW1YWXhHRnJ2YnVWTitycWNsdDhmaVpLTTJEUlhjRWhR?=
 =?iso-2022-jp?B?MHg5UU1XWG9ac0w5ZjVocGh4SmtZQVFJbmEzUi9jN3hiYUV2bGliMFJr?=
 =?iso-2022-jp?B?Q0xMRmFCdzlzMHhvWU5MeG1Lbk9DODFua0x2UGVlMGFpYTZUbG5TSitQ?=
 =?iso-2022-jp?B?N0hMc3BYUFFkazRmQ1RzbHZQUVVLRVE1QXk2bU5XYVY3eXlWUVBLSHp4?=
 =?iso-2022-jp?B?d0Vlc2hJdzVTWWQ5OE1sNjdlL3daYlBPMTBYcXdPUUlsYUVXWEdqOU5k?=
 =?iso-2022-jp?B?YnMzeXFsR0c0SUZKVTRpU01IZTdjbGk5QnV2eTlTeUZBT3Z3dlN6WTJn?=
 =?iso-2022-jp?B?b05NRXk5VTRvNzREVDFiWVhuSGhiZHZGaFZMRUVHaFVIWjkvcWZCaUF5?=
 =?iso-2022-jp?B?YSs5NFpPTHByV2pEMmR6YldMOXkzV09WTmVNYStpSklxZi9BOWtlb2w2?=
 =?iso-2022-jp?B?dUNDckMwVjhnekROUWE5U2NrMlJXY2JrTFJIZ0JMUFZBVkUrbGYzL0Ir?=
 =?iso-2022-jp?B?M01GOUk1Tm55NlE1ajJnWkhFRmxvanY5UXJUditEL2lkMm9tZTBQVDVH?=
 =?iso-2022-jp?B?OWF4OHlhLzB3cHA1R0daRk9pcWtHVDJmdFFvcW5SeFhkN1NMeTRmeStK?=
 =?iso-2022-jp?B?M1FZZTg3Tjd1T05DWmRuZ3Q4K3BxZnNLc0d1cE04OE5vZ1h2eFJqTXps?=
 =?iso-2022-jp?B?Mjd6RDAvTkdpRm9pYnVUVWFTWnFtNUVQNkJkdDh5RUJMNEdkRjF0aHhi?=
 =?iso-2022-jp?B?S1NJWnFXSHV6Rk03c2lRUWtGMCtDWkZXdXJiVzh2QVQ0WVFzU3l2eS9y?=
 =?iso-2022-jp?B?aTI3Qlh6S0x0a0lmRWhPbGxBZnpyTytrNElSQXdMMkRDY0ZJclB0QWRN?=
 =?iso-2022-jp?B?YjFDcUx6RU9FcUlzL0dMZGVERkpuNzFrNUl0OWlTRjd3STlTRStCK3Qv?=
 =?iso-2022-jp?B?L3U5TUpicGhJRmdKMkRwajhSZFhwejN6amRQZGVkS2IzK2U3MVVIQlc1?=
 =?iso-2022-jp?B?dVVmQXVZZjhvTzd1a05ueVRraERNejlGcHdBTnlWK1YvOXA4Q0h2TTY4?=
 =?iso-2022-jp?B?bUtqTS93N2hDNjFiMGVaWTI1T2hZbDNQNGcyWXF1ejkwN3FNaHN6Qkda?=
 =?iso-2022-jp?B?VXRRWEpnWThwcEhHMi9nRWVzbXdnQlliQ2FxQlpFUzZjSm0yUU1EK3FT?=
 =?iso-2022-jp?B?WmVVekFqSXFHMWhXVXh0TXJkdzdyelNVcXBLVlQzbU5VU2hhWFVrQnRT?=
 =?iso-2022-jp?B?dEdhYXJPcnh4Z1ZmSmtieVR2QWxxQWN0WEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c683b3-2512-471d-7bd2-08ddb2ef545d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 07:18:33.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5ENOgfypui6o23CCYMY8c1b/oCY2SYRk/CJdFNS6uPYmdJIjblUzQoN/msPuci765ONQrnaBuc8Veu3TrwpS27//ajLOTO+0UWz3lzNPeMbu2prSQPEpwQ4ghTkpGjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 07:35:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19225

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, June 23, 2025 11:48 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 00/10] Add support for RZ/G3E SDHI
>=20
> Hi All,
>=20
> This patch series aims to add SDHI support for the Renesas RZ/G3E SoCs in=
to
> the linux-6.12.y-cip kernel.
>=20
> The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that of th=
e
> RZ/V2H, but the SD0 channel has only dedicated pins, so we must use
> SD_STATUS register to control voltage and power enable (internal regulato=
r).
>=20
> For SD1 and SD2 channel we can either use gpio regulator or internal regu=
lator
> (using SD_STATUS register) for voltage switching.
>=20
> This patchset applies on top of [1]
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D974772
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (10):
>   clk: renesas: r9a09g047: Add SDHI clocks/resets
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
>   of: base: Add of_get_available_child_by_name()
>   mmc: renesas_sdhi: Add support for RZ/G3E SoC
>   mmc: renesas_sdhi: Use of_get_available_child_by_name()
>   arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
>   arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal
>     regulator
>   arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
>   arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on
>     SDHI0
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
>=20
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 ++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++++++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  49 ++++++
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  21 +++
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |  18 ++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 154
> ++++++++++++++++++
>  drivers/clk/renesas/r9a09g047-cpg.c           |  31 ++++
>  drivers/mmc/host/Kconfig                      |   2 +-
>  drivers/mmc/host/renesas_sdhi.h               |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c          | 126
> ++++++++++++++
>  drivers/mmc/host/tmio_mmc.h                   |  10 ++
>  drivers/of/base.c                             |  27 +++
>  include/linux/of.h                            |   9 +
>  13 files changed, 523 insertions(+), 1 deletion(-)


I reviewed this series, looks good to me. I can apply, if there are no othe=
r comments.
Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/18859=
35233

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


