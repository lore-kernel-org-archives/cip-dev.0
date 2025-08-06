Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDECC87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:16:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.19505.1754464584369538715
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:16:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=I7JER9Pq;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754464583;x=1755674183;bh=wG2siHX1qti5FQ0CCgKTrzGUENTH3AhYoL7RUX7
	Ju7o=;b=I7JER9Pqh3raJGY5DG2Q6y47nRlNSrm+LJl140+7oJLeqjBlqxi6Y748k/GlbIb2Tmqx5
	ykBQTtNsWI6cPsunkQjUVqH6XHkdcRZ5+tW6Va/7IayPLXjiMwTy6JFeC7zgicbCzPp03bnniuIMX
	7yIvvy1+mA1CtwExSuI3rMiKSiytU+1kGwRLKj8S+VuPdlkeWZF+sxW13iJX7v6k+JezVe+wcMeoS
	n+B6ZP7MIA3vVUrXE/RSeK0IjTMWQfKWIETZkjTT60NyGD8njq2Ib1iRdalCtSYFSB2S3uhaL3392
	H+zJgd2sO1V9rTfbWjvD/neR6+x5ifYfKDoICgh1Ug==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5767GMTG3977135; Wed, 6 Aug 2025 16:16:23 +0900
X-Iguazu-Qid: 2yAbj3N9cWXyecTmsr
X-Iguazu-QSIG: v=2; s=0; t=1754464582; q=2yAbj3N9cWXyecTmsr; m=4CKl6c1NtJqqMJcTEjk/qwBDKiktYLIwBGqhxhRxHEs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 5767GLtA2413538
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 16:16:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFZYtjaTfRHZfEe90EZYOOJRcw7VAi6XvdGgYfqulb2wyQgzWNTNEylr8dLtaP0NRIxpRkugNQUT1YoiUwdGSnpKDPQzpVLACKW1Qzot003JibhMeMDZmWYB7x6ZD2mNxSQEHs0LuKvJ2w7IJZNpvtr7xMwZHJANNhjkWcH61iVZJmy82wusEK5CLHdswJ5ixjrzZBYo3Nr1TfJ9B/rCToK2FTIpm+OckRYCXze0Jyh+DpU4dUpeD935hXxpRDuXQIDTWSfafOgdxvC78MajxpOdcHPj7Ix4lCx9t7o/RRYdVVTyyOgmJlN2Jcxy9H+A9C1h8IXKOnfWx/omtD+mKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG2siHX1qti5FQ0CCgKTrzGUENTH3AhYoL7RUX7Ju7o=;
 b=TfsblbFzqhsvmWZPX1a7IGT1vjTdG1B0yGEtqZwFotSZvIE+9arqZSKaiPYB6+ZOeLskcLXDE2c4ABSyC3IgFBTh7EX+b8ll8i0X5T8jFzX9YPUbh+bwjLaagoEWImCA3ik6Y1MdtjXmhGUr4pOcuCd69l+4I2XfdmwQ2L6Uu/kGhvjBm3oNiSseksYNe7rUhXoTnwHZZ2mF0ZXpucWirGrqKlEoPP15R0fxRAqGx/mdd++m0EyndfiAhW4KqTY/1Y03pgExx0lhnB2QXgQgEcZAVh6Nrz766JFcQBvaWMWYsPKesMAUxmO6DWd61TuStXXjUUruQCP87B/Osl0BbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
Thread-Topic: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not
 install kernel
Thread-Index: AQHcBpIgOmzYuwbGeketUM1Yw7g8VLRVNewAgAAAh/A=
Date: Wed, 6 Aug 2025 07:16:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C313C950D6AD14730112922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ad7c3971-0c32-4288-ad45-8e96e07742b1@siemens.com>
In-Reply-To: <ad7c3971-0c32-4288-ad45-8e96e07742b1@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB15539:EE_
x-ms-office365-filtering-correlation-id: 8d13283d-fe67-4613-f43d-08ddd4b923f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M0VRWStETGFJN1NjTzFrOUhZcitvdWNwaFZhNmw0OEpLdEsvdHJJOEVsZWQw?=
 =?utf-8?B?YU14Z3N2ckV5RTYrUkRYcWIrT1M1eThhL2RsWVhmczV2aTJXMlphUnRJaUVI?=
 =?utf-8?B?Z2hjOC9jUHpUeXFkbnJ6ZzloemYyTFpDL0FHQ05PU0VROXZPWERQQXUzUktV?=
 =?utf-8?B?NXNTeFRGUVBmbGtVSnRxUjcyYXdUZmVFU01aaEV2M3FUZGlyRWVEczlMZm84?=
 =?utf-8?B?TFRCMnl5MVpGeHlRMmoxN0VXL05xSHkrRDRNcndTQzcrYTJSekZVTjZLRnZv?=
 =?utf-8?B?eWo2YklGVmNkL0dMSkVRMDNITkZVN3VXNTNXT09BenVFVllVdXAxck12T0g3?=
 =?utf-8?B?ZWV0ZW9STkVSUGppc0hNZWtWL0pZMVVVTDVsNnR5ajJXMDB4OVJLeHlMVGFC?=
 =?utf-8?B?Q2NTSlVDeVQ0Y0JCbjBKSUNnRlNJb3B4ZUc0K3l6RldoellhMXR3WldCUXhM?=
 =?utf-8?B?QXJsTjRkUldzM3ZhZ0czNXhIRmY0OWw3OExXWG90akxET0dqd3FhVS9HaFla?=
 =?utf-8?B?TTFEOTNNQ3g5RWgvb2FvVEV3NlZkTVpRekViaStoKzcvTHJJQTY5VTRXRCtI?=
 =?utf-8?B?M01SS3N4eXBlY2xDU1VsSEpPdk1adms0Q1pHQWc4YWloSkNDQTBMenRjeTVK?=
 =?utf-8?B?Wjc4Tmd1UzRyQXJLdWhjclB6N2k1Z2IrTkliTjg1QmZiQ1ltK2EzMnNJYm83?=
 =?utf-8?B?TFQ1eXh6cjBPQVRyL2Ruc3F4TTRTYVlGRUpuK3E5S2Z0bWZOOXNabG5pRWJJ?=
 =?utf-8?B?Z0hXZ0QveHQzNE1sRGQxbkRrYzBEZllzTWFHQlhvaGtrRytjUC9kdjJSV09Q?=
 =?utf-8?B?Z0tkcE9KYllwZk9tOEFjQng5RU9BcTVlTHVGTzVWNUhaamZ0NW1paXRCTSta?=
 =?utf-8?B?a09zVWgrZFpSck53cThQanprdTdRV2p6V1hMVDMwSGhXdjVwSEN5NW5sSVlZ?=
 =?utf-8?B?N3cyZzlabWJKSTBrU3VDTjZocDZ1ekl6M2VvTE4xdW53cUdUL0hra214bnhM?=
 =?utf-8?B?UHpjUHdpcDgyQ1E0Y2RIM3NZSnFiU1dnUmo3R2wzSXNUVmVoeVlHU2RNN2Nz?=
 =?utf-8?B?M09zV3dWdCtiVmxLSGdkSkxMeWtQbi9UVDg5VlplSERjMUlWTFVHcWpFNGs3?=
 =?utf-8?B?TUNhUnNHT0U3NnNZcytuaCtXOFJnd25yY0N4dzdHZHBtYXNCTXZqYkpWM3M1?=
 =?utf-8?B?WUc2c1hrQ1JlSDduSUI2cnJTZE82cGw0ZklyWlRtODIzeXRKYkJ0QlExV3h5?=
 =?utf-8?B?VDlNUHRBQWoza1BsMXdzUXNlNU93MnQyRjdoWG0vNnRaNUpKU2xvRnFQRDhC?=
 =?utf-8?B?NU5jMFE0dDhPenc5SjhDc0J1WkZDb2tMa25XRWhhNlJoMW84Yzk2RGtWRno4?=
 =?utf-8?B?cmIzZHNLZzh4ckVIT0hMTmpFRDdEYzJFODczemF6QVhDOVZiUkZlcS8wTUND?=
 =?utf-8?B?R3pBRmJER3MwYXhXUjVnQ2p5SFlKUUJlWWlGYUM5MDRmV3MvUDNkZUdMN0pM?=
 =?utf-8?B?ajlLdlVwN0EwSkxKMTA4Qi9pRjNMMG5oLzFVMGJtaUsvMU5ZSVM3NjM4M2Yy?=
 =?utf-8?B?ZldMNC8wcnNudUhvYlMxNnNNZkNxanFCNmUyOW11dnlSTzROMjlNRFRsYzJI?=
 =?utf-8?B?ZnBtdS9mSitWTWd0QWJDSDJma2h4THV1VENpbG9SeUhmclFyU2xQMHB0M0pz?=
 =?utf-8?B?ZS9JT0dCVWtGaytWclRCVTBucURtQ1hPeTVSWFQwdFhMeTBzZGZBbjFXd01M?=
 =?utf-8?B?TGdvWHIxTDF1cTl2dVdwQkxpRDdjUndhaStLVy9NS0oyVStZYUl5d0tGNEpT?=
 =?utf-8?B?VG9FVWhDdU9GK3pFUW5HN2hzUEd0MW15Mk1meDlSM2JLUTRnZUhtSDJYTkl5?=
 =?utf-8?B?WCtHS241THFsTXJ0VXNqbW9DTHRjNDg3czluL3FCYnlmakgwa3QvRUdadHIz?=
 =?utf-8?B?NkxWTEc5TEo0WVFSWXh6WVJaN3FmNm1wNTV3WTZQbTFodC9jMG5DK2pyaW41?=
 =?utf-8?B?MXV5cmhQVWhBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OXpETDU1cTduT1Q3ZTkrVmpKdFR0U3cyUWZhRVlNbXhUNTlRSFh2dXh3NGxp?=
 =?utf-8?B?MjFqQmtaVjNac2NKZGV4Sk1Fdm1hS0hwdkNudGpnZTRwYUswb2I1RldqVGM1?=
 =?utf-8?B?bGM2Tkw2UVZhMDdnVEV5NXFKL3kwbVlpUXZyM2p6UktKU0VETnZpNURKZkYr?=
 =?utf-8?B?dmtvZ3BLL3I4d1JRMy94MktLMTZFL0NrRHNYNFdPZDRTQlIvdlEwQVFjbmt0?=
 =?utf-8?B?K2NZU1U0YVluL25JSmFLSEN3YXlSalJXRG1kWDBHUGJpTUpGT1NlSUI3ZTFi?=
 =?utf-8?B?QlpkbVh5N1pCVkJzWUpobXozRHUwTjQ0TE5WTWtqT2xLeUwxendxeWlmc3FM?=
 =?utf-8?B?b0RENGMzUGRPaW4yeWs0V1pVYytVTnVRaWhwbmVyeXk5UDV2aFZXTlRtQWtF?=
 =?utf-8?B?NVhLS0NwWWdzSlpjQlJTdTdsNHkybHcxNytZVVNGRHpKZGFJYmFORVhpYTB4?=
 =?utf-8?B?aS9DbE8rSlpuc0JLZDEwbnphcjlwMmw1SElGa2dtVXFKWElNUWFMdzdSOGRQ?=
 =?utf-8?B?VE5rQSsxaGRXcDV1V1hzcFA3K29MY0toN0V4YmRkZ28yWVl1ZEhiU0tGOVJP?=
 =?utf-8?B?ckZwNmVqUnljUk9CS2xmOUovN01ST3RCbVN6WGZxeXFKNyt0WmhaeTJGM3hx?=
 =?utf-8?B?eFkvQ21TWFRYenQ5WkRid1MvWGJ0NjB3SDljdzQ3cEhIa0MwOXlyMXdHWm9G?=
 =?utf-8?B?QUxnM01DR1Q2RjMwMzkvOXl6MDBaSHd5RXpad1AxSnZRQVFGYjBXdHFOWDdm?=
 =?utf-8?B?N3gzWDlsOGRDUzZXZFFtM2lLZnoxUjVsTmI0cWlhVVRuQmhFcUhPdWNjYjA1?=
 =?utf-8?B?alBPZjlGVGNlWUJCREhCR21FSHVKVml5TU44ejFmbjFiNHpxMDh4TnRHKzZE?=
 =?utf-8?B?bmxwQVE2NlVPUFFaemJaNERtSkE4NFlBdmNSVnJ2TmlwSVFrUUNlbHdIaEc1?=
 =?utf-8?B?ZWxaOXVLbzdrajhiL1RwZDMrRHVIZ3ZmTFpRZmloRExqMWlCQU5JRllUMHVD?=
 =?utf-8?B?R09oNEp3azdSNk8zMDAwUEhhbUg1MnFFY045Ulo4MU93T0xiZjIrSWZqdEw2?=
 =?utf-8?B?MFZJeVZSU3RuSDBFNkJ6bUliWkNLc2N1RXpPbjNZb2hWTVAzOWpHUlErdmJy?=
 =?utf-8?B?Ky9Ka0lDV2VielhpK2J0SS9EVVNja1hjZlk3ZEU2a3ZKenZHL0lIWFhtZGMw?=
 =?utf-8?B?K0ZQMGN3bUYvc0x0M3R5RDEvc3hXQTN1VllQTW1XenZHR25KVlBZN0psZmVL?=
 =?utf-8?B?d0sxUFpIcjNBZ2I0VWRZVit0OU02VVV0eHFqYjUzb0tHTDI2VEQzVHNJYURD?=
 =?utf-8?B?Z1diT215bjZyRzJKa09xTnJCWUZjNjdEb3JYOVNZdXNYczRSR3dNcVRWcElJ?=
 =?utf-8?B?Zkd6cXBJQTBDOGVyNFg4T1hUNTRkeTJNOEVPZzhBYmNQVzFEMkdTZWhWVkw4?=
 =?utf-8?B?ajZTTWNURXhCN3QzM3lCRG41TnBQdkVlMndteGExSk5SR3ZEU09qUi9IVzQ5?=
 =?utf-8?B?NGJZSTExcUE0ZEtqZzhyc2VHOXBhVlBXajQycXkvWGtlWWVCR3hwbEJCdVl3?=
 =?utf-8?B?L1c5dTg3VUFFT2dqcVYrWHlCbzYyZVBTdFA4bFZGSGREekYvc2RjTWVSRUxp?=
 =?utf-8?B?VjBiVjZDTDVBdDFyaWR0V2t3dXhPMHJBSDhkblpUR3FDZHdmUE01TjcycWhH?=
 =?utf-8?B?WlA3M3JOVjJGVStuK0w2cUJuYmNCYlZaQ3RrSitLSDRCVlRpVDE4bjdhUis3?=
 =?utf-8?B?cXVmQzhNRm8rTEhpV01pM1cwSXFXcDJFSEUxT0V6dTBoU20vWmNURVFHV3dn?=
 =?utf-8?B?WjBwSHZiRElqMnJPWXRza2l1Y0lUbTYwclBhRjBxanlrZDVhOVBHV1R5QnFj?=
 =?utf-8?B?dVJVUTNTRHhPdERNN05iRHByZW9GeklYUm5VUk1mbGltSWhlMHJwTUdOaWFa?=
 =?utf-8?B?bmVPcDlRQUVTSXc4VzNUcVhocUVQR2tuMFJVMlBwWk5SZFlPWE9hRnkvN0dQ?=
 =?utf-8?B?MzRWeFZKczM3VzdlYUNUa2tVclFRakFsenZyNG1rbnBQbUZwY2o0U1hZQVlp?=
 =?utf-8?B?aUlIV2pONHN1WHg1REprYis1ZGY2Ti9rRFdCUS9PK0F3MWg1eWF1NkJSNFl5?=
 =?utf-8?B?bzZQd3RQcU5Mc2Q2d1FsTCt1K3dSUVFWL2RadGtBMmRXWkpaZm0rNWpGZzcx?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d13283d-fe67-4613-f43d-08ddd4b923f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 07:16:19.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3J+Yo9o7J8smUasZv94DTJy5wsuaiUdek+hcInoB5pbPm+NB8PTPPMEnQlz4y4JyHbCaNy554KcxLmTneg5T1/ggsTvVyagrReyFiiaf1kMznJzKkWmuHhcwaLmSh13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15539
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19687

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1IDQ6MTMg
UE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj
4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENj
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2lzYXItY2lw
LWNvcmVdW1BBVENIIHY0IDEvMl0ga2FzL29wdDogQWRkIG9wdGlvbiBmb3Igbm90IGluc3RhbGwN
Cj4ga2VybmVsDQo+IA0KPiBPbiAwNi4wOC4yNSAwNzoyMiwgTm9idWhpcm8gSXdhbWF0c3Ugd3Jv
dGU6DQo+ID4gVGhpcyBhZGRzIGFuIG9wdGlvbiB0byBjcmVhdGUgYW4gaW1hZ2UgdGhhdCBkb2Vz
IG5vdCBjb250YWluIHRoZSBrZXJuZWwuDQo+ID4gVGhpcyBpcyBtYWlubHkgaW50ZW5kZWQgdG8g
cHJvdmlkZSBpbWFnZXMgZm9yIGtlcm5lbCB0ZXN0aW5nLg0KPiA+IFdoZW4gdGVzdGluZyB0aGUg
a2VybmVsLCBrZXJuZWwgaW1hZ2UgZmlsZXMgdGhhdCBhcmUgbm90IHVzZWQgZm9yDQo+ID4gdGVz
dGluZyBhcmUgbm90IG5lY2Vzc2FyeSBpbiByb290ZnMuIFByb3ZpZGluZyBpbWFnZXMgd2l0aCB0
aGVzZSBmaWxlcw0KPiA+IHJlbW92ZWQgYWxsb3dzIHlvdSB0byByZWR1Y2UgdGhlIHNpemUgb2Yg
dGhlIHJvb3RmcyBpbWFnZS4NCj4gPg0KPiA+IHdvX2tlcm5lbCBpcyBmYWxzZToNCj4gPiAgIC1y
dy1yLS1yLS0gMSBpd2FtYXRzdSBpd2FtYXRzdSAzNTFNIEp1bCAyNSAxNzozMQ0KPiA+IGNpcC1j
b3JlLWltYWdlLWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQuZXh0NA0KPiA+DQo+ID4gbm9f
a2VybmVsIGlzIHRydWU6DQo+ID4gICAtcnctci0tci0tIDEgaXdhbWF0c3UgaXdhbWF0c3UgMjc1
TSBKdWwgMjUgMTc6MDkNCj4gPiBjaXAtY29yZS1pbWFnZS1jaXAtY29yZS1ib29rd29ybS1xZW11
LWFtZDY0LmV4dDQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPg0KPiA+IC0tLQ0KPiA+IHY0Og0K
PiA+ICAgLSBGaXggdGhlIE5PX0tFUk5FTCBjaGVjayB0byAnZW5hYmxlJyBvbmx5Lg0KPiA+IHYz
Og0KPiA+ICAgLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gdjI6DQo+ID4gICAtIFVzZSBL
RVJORUxfTkFNRSBpbnN0ZWFkIG9mIElNQUdFX0lOU1RBTEw6cmVtb3ZlDQo+ID4gICAtIEFkZCBi
dWlsZDpxZW11LXJpc2N2NjQtdGVzdC1ub2tlcm5lOyBwaXBlbGluZQ0KPiA+DQo+ID4gIC5naXRs
YWItY2kueW1sICAgICAgICAgICAgIHwgMzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiA+ICBrYXMvb3B0L25vX2tlcm5lbC55bWwgICAgICB8IDE3ICsrKysrKysrKysrKysNCj4g
PiAgc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggfCA0OQ0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBrYXMvb3B0L25v
X2tlcm5lbC55bWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5naXRs
YWItY2kueW1sIGluZGV4IDYyOGU2MjQuLjQ5NmE1NmQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS8u
Z2l0bGFiLWNpLnltbA0KPiA+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+ID4gQEAgLTI4LDYgKzI4
LDcgQEAgdmFyaWFibGVzOg0KPiA+ICAgIHN3dXBkYXRlX3ZlcnNpb246IGRlZmF1bHQNCj4gPiAg
ICB0ZXN0X2Z1bmN0aW9uOiBzd3VwZGF0ZQ0KPiA+ICAgIHNlcGFyYXRlX2hvbWVfcGFydGl0aW9u
OiBkaXNhYmxlDQo+ID4gKyAgbm9fa2VybmVsOiBkaXNhYmxlDQo+ID4NCj4gPiAgc3RhZ2VzOg0K
PiA+ICAgIC0gYnVpbGQNCj4gPiBAQCAtNjksOSArNzAsMTAgQEAgZGVmYXVsdDoNCj4gPiAgICAg
IC0gaWYgWyAiJHt3YXRjaGRvZ30iID0gImRpc2FibGUiIF07IHRoZW4NCj4gYmFzZV95YW1sPSIk
e2Jhc2VfeWFtbH06a2FzL29wdC9kaXNhYmxlLXdhdGNoZG9nLnltbCI7IGZpDQo+ID4gICAgICAt
IGlmIFsgIiR7c2VjdXJpdHlfdGVzdH0iID0gImVuYWJsZSIgXTsgdGhlbg0KPiBiYXNlX3lhbWw9
IiR7YmFzZV95YW1sfTprYXMvb3B0L3NlY3VyaXR5X3Rlc3QueW1sIjsgZmkNCj4gPiAgICAgIC0g
aWYgWyAiJHtzd3VwZGF0ZV92ZXJzaW9ufSIgPSAiMjAyMi4xMiIgXTsgdGhlbg0KPiA+IGJhc2Vf
eWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvc3d1cGRhdGUtMjAyMi4xMi55YW1sIjsgZmkNCj4g
PiArICAgIC0gaWYgWyAiJHtub19rZXJuZWx9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPiArIGJh
c2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvbm9fa2VybmVsLnltbCI7IGZpDQo+ID4gICAg
ICAtIGVjaG8gIkJ1aWxkaW5nICR7YmFzZV95YW1sfSINCj4gPiAgICAgIC0ga2FzIGJ1aWxkICR7
YmFzZV95YW1sfQ0KPiA+IC0gICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIgXTsgdGhl
biBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaA0KPiAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4
dGVuc2lvbn0gJHtkdGJ9ICR7Q0lfQ09NTUlUX1JFRl9TTFVHfSB3aWM7IGZpDQo+ID4gKyAgICAt
IGlmIFsgIiR7ZGVwbG95fSIgPSAiZW5hYmxlIiBdOyB0aGVuIHNjcmlwdHMvZGVwbG95LWNpcC1j
b3JlLnNoDQo+ID4gKyAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtub19rZXJu
ZWx9ICR7ZHRifQ0KPiA+ICsgJHtDSV9DT01NSVRfUkVGX1NMVUd9IHdpYzsgZmkNCj4gPiAgICAg
IC0gaWYgWyAiJHtidWlsZF9zd3VfdjJ9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPiAgICAgICAg
ICAgIG1rZGlyIGJ1aWxkL3ByZXZpb3VzLWltYWdlOw0KPiA+ICAgICAgICAgICAgaWYgWyAiJHtl
eHRlbnNpb259IiA9ICJzZWN1cml0eSIgXSB8fCBbICIke2V4dGVuc2lvbn0iID0NCj4gPiAiZWJn
LXNlY3VyZS1ib290LXNuYWtlb2lsIiBdOyB0aGVuIEBAIC0yMjksNiArMjMxLDM4IEBADQo+IGJ1
aWxkOnFlbXUtYXJtLXRlc3Q6DQo+ID4gICAgICB0YXJnZXQ6ICBxZW11LWFybQ0KPiA+ICAgICAg
ZXh0ZW5zaW9uOiB0ZXN0DQo+ID4NCj4gPiArYnVpbGQ6cWVtdS1hbWQ2NC10ZXN0LW5va2VybmVs
Og0KPiA+ICsgIGV4dGVuZHM6DQo+ID4gKyAgICAtIC5idWlsZF9iYXNlDQo+ID4gKyAgdmFyaWFi
bGVzOg0KPiA+ICsgICAgdGFyZ2V0OiAgcWVtdS1hbWQ2NA0KPiA+ICsgICAgZXh0ZW5zaW9uOiB0
ZXN0DQo+ID4gKyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+ICsNCj4gPiArYnVpbGQ6cWVtdS1h
cm02NC10ZXN0LW5va2VybmVsOg0KPiA+ICsgIGV4dGVuZHM6DQo+ID4gKyAgICAtIC5idWlsZF9i
YXNlDQo+ID4gKyAgdmFyaWFibGVzOg0KPiA+ICsgICAgdGFyZ2V0OiAgcWVtdS1hcm02NA0KPiA+
ICsgICAgZXh0ZW5zaW9uOiB0ZXN0DQo+ID4gKyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+ICsN
Cj4gPiArYnVpbGQ6cWVtdS1hcm0tdGVzdC1ub2tlcm5lbDoNCj4gPiArICBleHRlbmRzOg0KPiA+
ICsgICAgLSAuYnVpbGRfYmFzZQ0KPiA+ICsgIHZhcmlhYmxlczoNCj4gPiArICAgIHRhcmdldDog
IHFlbXUtYXJtDQo+ID4gKyAgICBleHRlbnNpb246IHRlc3QNCj4gPiArICAgIG5vX2tlcm5lbDog
ZW5hYmxlDQo+ID4gKw0KPiA+ICtidWlsZDpxZW11LXJpc2N2NjQtdGVzdC1ub2tlcm5lbDoNCj4g
PiArICBleHRlbmRzOg0KPiA+ICsgICAgLSAuYnVpbGRfYmFzZQ0KPiA+ICsgIHZhcmlhYmxlczoN
Cj4gPiArICAgIHRhcmdldDogIHFlbXUtcmlzY3Y2NA0KPiA+ICsgICAgZXh0ZW5zaW9uOiB0ZXN0
DQo+ID4gKyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiANCj4gVGhpcyBjYW5ub3Qgd29yazogcmlz
Y3Y2NCBpcyB0cml4aWUtb25seS4gV2hhdCB0byBkbz8gTGlmdCB0aGlzIHRvIHRyaXhpZSBvciBk
cm9wIHRoaXMNCj4gdGFyZ2V0Pw0KDQpPSywgSSB3aWxsIGZpeCB0byB0cml4aWUgb25seSwgYW5k
IHNlbmQgcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K


