Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B776DC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 05:44:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5287.1737611079122354045
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 21:44:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=jhrGqwGZ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737611072;x=1738820672;bh=ozbQxAsbcnoNUkYSMS5EkIhRSgse2qJfma9Zt+z
	vRuc=;b=jhrGqwGZiSvheWmuq0TDBjVbqW/fMu2S0tsSSyUrXU3pBb/UtiBeLdpzGTtc3LtVC+qe/
	DKqQ+6IeePIQFlO5HlPm8c54GcelDouTDmyuMihVXrsG5vzBfh/gU2PLBudxm08X2wyxqg06zEroP
	ZdLKmDXKCZ4goMu976tbFz0jLuYewH5mnGsGdXdJEynLzm4v+jb8nhD2LF/1ah+2RzWSIqJ0PYhJu
	6YUgB816Y064YRdkjNhoI/RwkuYxGXSi73ylHp2TsUN4ymN0/MTRa+P7pyLwPragaZYCvPLaWmfTF
	Vqx270QjdtgzXMjm1mS6yss7evlCGycwkl+Wg7z+yA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 50N5iWGe3806007; Thu, 23 Jan 2025 14:44:32 +0900
X-Iguazu-Qid: 2yAbUt1VDQ0l9lrj5l
X-Iguazu-QSIG: v=2; s=0; t=1737611072; q=2yAbUt1VDQ0l9lrj5l; m=E8tULu5pcKuVTueyB/VDnkPjbbKzsaFzIm2YwEnzHSk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 50N5iVbO1438145
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 14:44:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDJu81wxDw+XDn+mK+j5dzPtRBaaBmd3joJOc0yemVyORWEIIAfAPNjQLPcwGPOLk8hqxFq9GOYZv9zEwuHTwTpQ7rIhU03NUb6f2zW3Ns4tqsEqKLZI3QyjeMhUqH4WtEwQJUl+OCL4tkz3EGowULXTSWiiT2dznRVBdEKkVEHs1OfaSPFw4riRaSwaWWxJ3Vm5zjiGsvRD13JLlXNckQK6X5twIM6Rhf/pIqWMYZlovNqViu47o9Sl2FrwFvjn59IVYJF2+8tUeX5PHZX7PafnvG05LfHoWbQu2XQ0UG2Wi0U/Fwt/CCAgVKOK9hSSugjRBI8ck7L8X12ZZv44+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozbQxAsbcnoNUkYSMS5EkIhRSgse2qJfma9Zt+zvRuc=;
 b=byLT2q6ogNfH7FXgO2URIBWLZMQ0bD7N8pslIVeTLj8sVVqD5SOWFXRbcJtxkP9zYvwTM9J3yfnp1ygUGqPsGPk8xvpvcwgGcI9fxU6Rx2PaJGUjfVRRTgt/mIR0QBOJMwKpf5G+ihmL36HoHwlubAe6GnbbFD2smJifH4qHWtAYEHh6Q5yAopoh0QyWF++8IFiwpgqCXG7mY77NWOttsWQj3yZLYPyfCrMmwlNktk22e6sTCeWNN98JlXP0w6gy8kvHWai0ihlmIuAnTqXncV8Vyx08jXxPeAV+1IdUPPpHB/m3egAHNLXxIJKaJPwcvdrxQB/EV0z/BlRHb254NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the RTC support
Thread-Topic: [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the RTC
 support
Thread-Index: AQHbbMP8OupQwieLgU2sP4S6iBS7IrMj2K3A
Date: Thu, 23 Jan 2025 05:44:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E136F89EFE42C5D4D43C92E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB13485:EE_
x-ms-office365-filtering-correlation-id: d85b84d5-3567-43bf-fbc7-08dd3b710089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WVNtc1dkTU9xS0ovSGN3OG9pVXYvNnJaaTNuWFdyc3hqRFkvaTZZeFg4WHNo?=
 =?utf-8?B?VFErZmlwTlJYVVM0TTBaUWR2Q014U012YXFHWnBLMlFFaEtCYUxMbjI1WEZZ?=
 =?utf-8?B?c21TM2FKTFEybFV6cGc5cmhMTFhsSzdMRHNJVWpvMVh1TXZQZDNPSUdkQWxl?=
 =?utf-8?B?aW9yYUZ4UTR4SkR4YkhSb0ZUSGl1VFkraFRRWERPTGZEZzZGOERHSkxxblpS?=
 =?utf-8?B?cm1GZEhzTXQyWVpBaHF6c2NrOWpkY254M1BVbHl3RUdhci8ySXZ3N09DSGVP?=
 =?utf-8?B?STlwL0EyeURYelVLVVUrcjB1amVINUxrSzEzNWRWMi8wR1ZGREVjSXd3UjdS?=
 =?utf-8?B?dFgyVHpTOHkvZDZYdXlrdy8rZHluQWdGbjQ1RXg3S2ZFcUhzZ3B2amJSRzIw?=
 =?utf-8?B?MFFTZUgrcnF0OTZXL3EyN0FZNWVrRDVNbHdTWGZMZTc1NTRoY1dhNGc4TnN2?=
 =?utf-8?B?cFlLZXlXZ0JKK2RzUkhWNnZBalk3ZVdvcFhpR3hWNHhtZkpPbk9XWGJxZEg4?=
 =?utf-8?B?WVhWYy84ZU51SkpWVTJ0VlZhOVRTSTlVVmpsNTRyVnlRR1hMWlpvSnNFMEdO?=
 =?utf-8?B?N0JBUXFWZjh4bGV6K3JKSVVzMXhuWjBRVjNlWHFST1hGZEJzSnk5R2hDVm5k?=
 =?utf-8?B?aUxUL1NxWFF2ZEhTejdjRWNYaGlIa3BPb3lnUHN4K2JuQVRiWDZDUFJQdGlq?=
 =?utf-8?B?OFppNjZvRDFiaS9zcVZVeWVmV1F0KzBhaEpUSnRVSE95TDgrS0lBUENzNDF0?=
 =?utf-8?B?M29teStubHprVngzLytKR3RKN05rb0FkTi9aTHM5TlZ0SjdIZndsOS9yMGJG?=
 =?utf-8?B?WERwbzlEYjVPT2k4dUZMM2R3bDNZQ01oRnBrQkhULzZBUDY2dGwxSS8rbjh4?=
 =?utf-8?B?UWNzZHFQRU9iZ2ZzckpLWDVpUjE3UnRBSFVWVTVZK2grWWxFWlJ1TzNBUlNG?=
 =?utf-8?B?bndJSGVqd0dVNUNUQTFySCtBdEsrTGxkRFVKUHVWQitPcnkrWC9RdnNBK2Fk?=
 =?utf-8?B?eWx2MzJCdjJNazZ6VVg4cmFYWEVwTnVmTDVCNytXMWZrVFJ1UVNoaGdWSHhs?=
 =?utf-8?B?VVZMbVgrTkpkZ3BpdlorNWZhZjlCZTY4a0w2NkVwd2I2UFdlTlhnc3dLY2dq?=
 =?utf-8?B?eDdzSWg3ZVJFTWl4b3NUZEVrV3p3ZVhBUGc0c2tFLzV2SGxHZ0c3NW1qdmIx?=
 =?utf-8?B?N2taQm1iNEM1WDNMQmxuUTB1ZlBJVVpCcVhBVlRlcmx0ejRXMldtNkwyb082?=
 =?utf-8?B?NkV5Y0p1RHZRNkxxa1MwbHRSQ1RrcGJPUVBTSkFSNElLR2FOb2tzbGF2ckhy?=
 =?utf-8?B?ZTNzYlBKNys5Z0k4TTZ4SUFFTnQycFNybzVGdmVjOXFUQmlScFQyWW5aajBG?=
 =?utf-8?B?N09CVGFsTjVqd0JIM1JUb3RvbXVJanhtM1VLU2toNXdncm9nOHhMaExPSHVq?=
 =?utf-8?B?Yjl6bGxZZDNYVnF1L08vSWd5NjBjM2VsNFFQRUVrbDUzdmwxUVJoenVLTER1?=
 =?utf-8?B?Q0xETUJydXcvZUtHOXhBRFVTNUpzWVlaUDZPSStUY0F0bWtrR1g1bS90Nk9K?=
 =?utf-8?B?RkdFRC9FNysrUXRMclI1WXhqSEhHZERTN3FMSEE2U2VId3RNd25xdm95TlpK?=
 =?utf-8?B?VWJoTDEybHNoN2h5ZDRIczRYdUZkajkyNTNXTWFzWjVJbWlzYXNRZmhJSnM4?=
 =?utf-8?B?SG1WbDdMSW5YTFlnYkxSQ2RBZVFyU0pCeFhKYS8xa0VKaG1YNzF0cHAxbHVW?=
 =?utf-8?B?SWpCTkhUcnBZYkZQUnM3YTY0bVJGY040dnRTNDVacHNBTVhkMEl5eTBSY1Mv?=
 =?utf-8?B?bmFaUEZ1QmhpaEJ2QVN1dnluaTUrUjZIU2Vqd241L0dxR2RBODlpN0Foay9X?=
 =?utf-8?B?bG1YaUFYM0RQZjhpL0hVOFBHNWhpb3Z0ODczaCtkRzBLeFpiNzRubzgzdVdN?=
 =?utf-8?B?b3dWQTNmdUhtRUNhM0xydmVmWGZZaXZCVmhSSVRSTDI5dGFBbmpwcmV3MEZD?=
 =?utf-8?B?OUova0RSZ0VRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WXhQWDVrcEJidmNYbGNWMlZ0S2dJM2pCbFE0cjF2NDQ1MlEvN2doTVh5SHNh?=
 =?utf-8?B?a1lpZE1kaUZrU0tpRDhLUWlTYVJtT1B1TXJRZFd3cTI3dGtxU2s0c08wUm9I?=
 =?utf-8?B?WW53MnZCWXZRemIyVTR6dHR1WVR1ZllCZlpTYndWN2kySE54a2J3OUp2NGF4?=
 =?utf-8?B?dldxTGEyQWYxZXc5YlNTYXVGeENOSHRUeU9sRndyc1MzLzAzMzdKNW84ejdC?=
 =?utf-8?B?WTUzemdtS3V3cVFrVlJGZnhnTGxHZVZpZ3l4T2s2b2xRemtyaW1IRWJmRXc0?=
 =?utf-8?B?RlRuZTBobURmUjU1QkNISDFDUGRvQ2F3K3Z2Uzdhb2twTkJlOGlWR2hGN01y?=
 =?utf-8?B?TkpmNG41Y216aytLSTlRUDE0V0RHdE9NemJpczhDN0QyZmozVzFZMVdRU0pm?=
 =?utf-8?B?d2J2NElNU0hBWWl3alNsMnpMUGdHdUZpczA1d1A5cVBvMnFoQUZQZnR3NEpT?=
 =?utf-8?B?MTZxSmZUbXZPWm0yZ24xQS9hY1ExUHAvTUlIdmJZWjNKOSsvOUZBTGx0eFRC?=
 =?utf-8?B?RWxkdDd5VTBCY3d2bGIwa1V5ektVRHFGTWt5cll1RktLNi9LZCtLV252WnNk?=
 =?utf-8?B?UHBCS2xjaFduN2NGTTFGV00xR3hEWmpCM2kwb1FuVTkxeFRSNDhUUFZCZlBQ?=
 =?utf-8?B?NXFrTkdXdktvUVBzTldXb2J0Q1Z3TkRzZjBLNlRGakx6K3dlUWpMcklrbjdJ?=
 =?utf-8?B?Rkp6bkx1RWZ2TTNkY3dvZzNVc2lHcmFlbmt3QXBvVXdINjdkODZ3MDZweWJl?=
 =?utf-8?B?SWtrcmY3NmVjbzQvdDdEYkV3UHk1V0ZXVC9jL3NFTFB1SmVFMGZXVENza0p4?=
 =?utf-8?B?eER2Tm4raU1CalVBQUljemlGWjZSYU1IZTFlemM1UGpudm53VWdFU0pnb1RF?=
 =?utf-8?B?akgrVjZRanhCVkJ4cWk3QXZIRkZuUktoUEoyakNEVUMzRktJcmtiVnZjRXcz?=
 =?utf-8?B?V0FEdXp4RWZzQi81NEpiTVlaMVE3K3BsQmFCK1d5RDBPSEp4S0ZPNENzVHZv?=
 =?utf-8?B?WEtaK2QxaWMrTG9YT01kNlBLaUpiQmpLN0pzeWNkV0o4dTFOcEJEeFkyNStC?=
 =?utf-8?B?SnU0RWpIajVYWkpOOUtNMDBhWnNrU3pJSFVEY0c5NnUzUENZNkRSRXdjd2tM?=
 =?utf-8?B?SGZnTHRmTlFoV1h6Mk44aXpCU0p1cWpzUzduVHJqMFpkclNqMXJmejBLQ0JE?=
 =?utf-8?B?bVdvaDQ5T3k1SnlVSmYxaW40YTFKNlpNNDBoc2lScVZTaTNqQmFhVnByZUpk?=
 =?utf-8?B?amNtb20yYi9PSzFPelBNVk8xV1AydFlLdGR1UFZyNk5qOWxEVjZZdjA4ZjNy?=
 =?utf-8?B?NVhKLzBRbWpUMTVvdVlpVHBnVy9HVkwxNXFIckRUbVVHTDFCbVhLSEFPaEsy?=
 =?utf-8?B?QWx0NUhiVWp0dlUzOHpMYjl4a2Z3MytQN0d4WnBUK3hMZXZmZng3QXNrVUZ2?=
 =?utf-8?B?UWR0Ujg2OFloYjUwaVBqSDFSaE8yUENlMm1QOUtIMDVDaE1QcjM3emFnOHJH?=
 =?utf-8?B?OERERnlPWUhwTkZXSFY3VUFudm1NUDZlTTlvYUxvbDk1TTZnVGJSejZ2TDRx?=
 =?utf-8?B?eDlKWU9mNVd3RzZpTVBnMmN1ek1hbVNTeDdTY0dTN2RFT3krdXE2LzRPUkNN?=
 =?utf-8?B?TVpUT20rUEt4UDVIK0tPKzZKeFhna3p6cFZKRitadEdDNkN5bzAwamJaY1hR?=
 =?utf-8?B?bjBoL2NEYVcvY3JQZGlqaUUxNUF6bnJUQUtiUzVnWE5VcGpIRVBxQ3VVc3ND?=
 =?utf-8?B?UExtMy9nTzdmdkpXQ3poMGEvV0V2dlpoWVVpeFRpV3p2czNpUFhUWEs2QzNN?=
 =?utf-8?B?OU1nNkJUUjdXWDBhTFlYM1poOEVrVHFmdG5JUHpBQkVJMmdVRFhwaXpMc3Bk?=
 =?utf-8?B?c1VYbUEwV0Z6UkdQckxtZkoxNWl1dHJ0SFZSVWtid1F6RlZQQTFhWC9CZ0ht?=
 =?utf-8?B?VG5hQk9SdDVVVG56eUQrUTNwV2lMcDdoQ1BqTTgzN09kVGQwamU0cXJicFFV?=
 =?utf-8?B?T3hFNG5xZmx6elZpVkRQdExkZDl1NkVvTGpJZTdONUVmc3B4aEg4TTgrODdx?=
 =?utf-8?B?S1YyaHp1MTlVenhVOVNmMkZGNmpMc0psb2NlcGhwQjJ6WUhiWWt0U1U0ZHhX?=
 =?utf-8?B?RjcxYWlNdm40RXR4VThhZFlwWnhmTXRGNFYzdHNOQ3ZjdGRTd3RPK3ZOVzNr?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85b84d5-3567-43bf-fbc7-08dd3b710089
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:44:28.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXnoX1QE25ViAW9m61pYWBrujXFVCV9AC+iMBpk/z2R/bc8AYfXMEPSs0/zHufe+GLaKc3mfiiCKp9koIxwX3pUyHjt8cfRvbspoU8A23yI0TroAr+hXbdWvYs7LpBkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 05:44:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17602

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IENsYXVkaXUgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4N
Cj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIyLCAyMDI1IDg6NTEgUE0NCj4gVG86IGl3YW1h
dHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4peL77yk77yp77y077yj4pah77yk77yp77y04peL
77yv77yz77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBwYXZlbEBk
ZW54LmRlDQo+IENjOiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ni4xLnktY2lwIDAwLzE0XSByZW5lc2Fz
OiByemczczogYmFja3BvcnQgdGhlIFJUQyBzdXBwb3J0DQo+IA0KPiBGcm9tOiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBIaSwNCj4gDQo+
IFNlcmllcyBiYWNrcG9ydHMgdGhlIFJUQyBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1Mg
U29DLg0KPiBBbG9uZyB3aXRoIGEgY2xvY2sgZHJpdmVyIGZvciB0aGUgY2xvY2sgcHJvdmlkZWQg
dGhlIFZCQVRUQiBpcyBpbmNsdWRlZCBhcyB0aGlzDQo+IGlzIGNyaXRpY2FsIGZvciB0aGUgUlRD
IHRvIHdvcmssIGFzIGl0IGZlZWRzIHRoZSBSVEMgY291bnRlci4NCj4gDQo+IEZvciB0aGUgVkJB
VFRCIGNsb2NrIGRyaXZlciB0aGUgZm9sbG93aW5nIHBhdGNoZXMgd2VyZSBhbHNvDQo+IGJhY2tw
b3J0ZWQ6DQo+IC0gY2xrOiBBZGQgU3VucGx1cyBTUDcwMjEgY2xvY2sgZHJpdmVyDQo+IC0gY2xr
OiBmaXhlZC1mYWN0b3I6IGFkZCBmd25hbWUtYmFzZWQgY29uc3RydWN0b3IgZnVuY3Rpb25zDQo+
IA0KPiBhbmQgYWRqdXN0ZWQgYWNjb3JkaW5nbHksIGlmIG5lZWRlZC4NCj4gDQo+IFRoYW5rIHlv
dSwNCj4gQ2xhdWRpdSBCZXpuZWENCj4gDQo+IENsYXVkaXUgQmV6bmVhICgxMik6DQo+ICAgY2xr
OiBBZGQgZGV2bV9jbGtfaHdfcmVnaXN0ZXJfZ2F0ZV9wYXJlbnRfaHcoKQ0KPiAgIGNsazogcmVu
ZXNhczogcjlhMDhnMDQ1OiBBZGQgY2xvY2ssIHJlc2V0IGFuZCBwb3dlciBkb21haW4gc3VwcG9y
dCBmb3INCj4gICAgIHRoZSBWQkFUVEIgSVANCj4gICBkdC1iaW5kaW5nczogY2xvY2s6IHJlbmVz
YXMscjlhMDhnMDQ1LXZiYXR0YjogRG9jdW1lbnQgVkJBVFRCDQo+ICAgY2xrOiByZW5lc2FzOiB2
YmF0dGI6IEFkZCBWQkFUVEIgY2xvY2sgZHJpdmVyDQo+ICAgZHQtYmluZGluZ3M6IHJ0YzogcmVu
ZXNhcyxyemczcy1ydGM6IERvY3VtZW50IHRoZSBSZW5lc2FzIFJUQ0EtMyBJUA0KPiAgIHJ0Yzog
cmVuZXNhcy1ydGNhMzogQWRkIGRyaXZlciBmb3IgUlRDQS0zIGF2YWlsYWJsZSBvbiBSZW5lc2Fz
IFJaL0czUw0KPiAgICAgU29DDQo+ICAgcnRjOiByZW5lc2FzLXJ0Y2EzOiBGaXggY29tcGlsYXRp
b24gZXJyb3Igb24gUklTQy1WDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDhnMDQ1OiBB
ZGQgVkJBVFRCIG5vZGUNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206
IEVuYWJsZSBWQkFUVEINCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOGcwNDU6IEFkZCBS
VEMgbm9kZQ0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNvbTogRW5hYmxl
IFJUQw0KPiAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBWQkFUVEIgY2xvY2sgYW5kIFJlbmVz
YXMgUlRDQS0zDQo+IA0KPiBRaW4gSmlhbiAoMSk6DQo+ICAgY2xrOiBBZGQgU3VucGx1cyBTUDcw
MjEgY2xvY2sgZHJpdmVyDQo+IA0KPiBUaMOpbyBMZWJydW4gKDEpOg0KPiAgIGNsazogZml4ZWQt
ZmFjdG9yOiBhZGQgZnduYW1lLWJhc2VkIGNvbnN0cnVjdG9yIGZ1bmN0aW9ucw0KPiANCg0KSSBy
ZXZpZXdlZCB0aGlzIGFuZCBmb3IgNS4xMC55LWNpcCBzZXJpZXMsIExHVE0uDQpCdXQgcmVnYXJk
aW5nICJjbGs6IEFkZCBTdW5wbHVzIFNQNzAyMSBjbG9jayBkcml2ZXIiLCBhcyBJIGNvbW1lbnRl
ZCwgSSB0aGluayB3ZSBzaG91bGQgY29uc2lkZXIgaXQuDQoNClRlc3Q6DQogIGh0dHBzOi8vZ2l0
bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL2NvbW1pdHMvY2kvaXdh
bWF0c3UvbGludXgtNi4xLnktY2lwLXJjDQogIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL2NvbW1pdHMvY2kvaXdhbWF0c3UvbGludXgtNS4xMC55
LWNpcC1yYw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


