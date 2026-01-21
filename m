Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7383D262B7
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 08:14:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7489.1768983275309519470
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 00:14:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60L8EWZq3377216; Wed, 21 Jan 2026 17:14:33 +0900
X-Iguazu-Qid: 2rWhHaaNAJJ1MnEC0n
X-Iguazu-QSIG: v=2; s=0; t=1768983272; q=2rWhHaaNAJJ1MnEC0n; m=UpGag3bDxE9IH6w3jbSCOyXseLwNdfH/Wch4ke9M694=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dwxn41jQzz1xnZ; Wed, 21 Jan 2026 17:14:31 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEytXfQ0afYI/7ljXReDhKDRrLzMqxMHHkbAqFl5AfL1vanl9rroQaiyCA4LJTsbOwiNBRdr4NrAc3Y/bUHRhqhafs89vz3ICCPXTBACuNQI8L5Gy8Vm4mzhE9VUSXHJPyilvW8XE5Vkpb1FZfBY6U3EaO+1p55w6izXhscBKa5ptSRt+MCmNxn2SfTiaeUCvfhn5Xtc6Y+NesgOw7wkUldIf5xdv7XPpzEb3B2KrFP/JfBYT1M8ZkyoOv/wtitvaZe+j1avvraPvcZ+bUgPu1MsVBw25HTwRSLXaMzfzzOqX7aH0LE+TM+6VDAIk1oji+QPi3RIW0EtkPjSOFEKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfAYUjBZ8iqGe7KAOEOOy4s9hUB6w/1L9yQ+eZl7+AQ=;
 b=OoofbERWY2xiw/gLfzOPhx1RcKlqdpFHUObru1uNrt81UqZn0qmz0eHKRNNfAe00CILPNDdRyruMR9xG3PlXjB5zaGAcDzf52EJk4tMQDPBdKgfPVAlDW0fE4vZXKp5d+Eor9OHJ83mAsSou0WS4X7/iZNK2WabHUCGrmpJsXNsYNBN5a6oYMU6BEc8Zm3qi/qhFkdCYRIpPOcHiF5lQx6Wy4V3jDrsGxlR+Mh5K56b0tiu4h8gg1lCeFPC0JQTBrcJF29NbGbY547rVH4yoyszolxryLe5hB6ggFeYgys49uzx6mvaeQ7HL20LqhntStlX6prodVrARhB+qI0OnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
Thread-Index: AQHcht4gKckjFVbe40S+sGa26CjewLVUz/8AgAAJU5qAB3RpYQ==
Date: Wed, 21 Jan 2026 08:14:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669482AEDEEBBE66196C416C496A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
 <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
 <188B3C54C2BB568A.3242018@lists.cip-project.org>
In-Reply-To: <188B3C54C2BB568A.3242018@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYWPR01MB9788:EE_
x-ms-office365-filtering-correlation-id: 0bacb076-800c-4bfd-9e0f-08de58c519c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021|13003099007|8096899003|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ODdYUkEzaW51Y3YrWEorUmdkSjhQWXZsZWFFZW1VeExVYUE4K09PRHRG?=
 =?iso-2022-jp?B?SzVPUS82QTZPOHJqZi9pKzJrTm5SdkZkd25RU2FwNW9UUlQ2Ylp2Rm5j?=
 =?iso-2022-jp?B?eDN3SE1jUG5Lck5pTWlZL2Y5MGVwZS9zdTNkakRZNGVCVnJYRnI0NUU5?=
 =?iso-2022-jp?B?ck9TdWY3REJUNE1KZC9iSkxLdGJZbTFDUEQyMHBlckZGaCtUWWU2WVV2?=
 =?iso-2022-jp?B?QnRUS05pK0x6N0xZVmNzUFhGSGpRQnRqUzJzSW1LaDRNbWlya1lqVlU1?=
 =?iso-2022-jp?B?dytGYlpjdGdSTkNzbU9zeG9xazBsSDJHeGJXOVBYKzZyaEZsTEdFNUxi?=
 =?iso-2022-jp?B?V0ZycmwzOTJvNEhlZ0tQc2x3YlVRM0ZlLzR6SFB0dTYrbXk4TVB4Unha?=
 =?iso-2022-jp?B?TDdST3BkcnNkaEVVUURDQWVvVHB4UXZSYVl4Y20zWnluRVNldUJ5dUVJ?=
 =?iso-2022-jp?B?dUpQQWEyTmRPejh3cmFpdkt3QU9xV0o0Yzg5ODRiVno4eG1ud1pDSE1S?=
 =?iso-2022-jp?B?Rkx4dFIyMnVrRlcrMHZaZ3Q2Yk05YVYrck1hN3VKRkNubHJRdkc1Tjhj?=
 =?iso-2022-jp?B?WUFyVkEyRU13Y21sZXpwY0wrc0lkTnFUUEJKbndGd2dOL0gzUFpEdm9a?=
 =?iso-2022-jp?B?bWFTckFJaGplSDZIZFE3cC93WFQxYnJPZVA3dGxiVkNTME8wbERlWm9W?=
 =?iso-2022-jp?B?bkVhRXMyY1RlSFhsMG5OS24xVDBSOVdhZm0rN1R2Z0V1b1FMVSthSXM3?=
 =?iso-2022-jp?B?YmJwYkdoZmJoZnByV21mUC93a0hyME1MaHpjcGVieTdCQTkyOTVIWmJ0?=
 =?iso-2022-jp?B?LzUzL1NKTGd3ZHkyd2pGeUhpUnZSUm0vVU1tdFpWSkhOVkR3Sm8zZE0x?=
 =?iso-2022-jp?B?UXNyTlFJRWlxK0pLMGxKUlNiVlRtbFBjOSsvMzdFUzdtYXdKclZZTVJj?=
 =?iso-2022-jp?B?Rnl4UnM2ZGtLRVFTZjhPeXUxY2dmYXZudFc4b05oY0pEeVR3MFJNSGU0?=
 =?iso-2022-jp?B?cDgvN0dXMW9saDdFbjdORytVSDJQYmU5RDMrUDhVaVh0bGsraUpDNXd3?=
 =?iso-2022-jp?B?N1JPNWkwcUxKTWhVZEU0c29iOVpGSTFrUk1aZHFwdXRjVHNwbGJrSXMx?=
 =?iso-2022-jp?B?TWh5SXMzNTRhS29ZcXpCSTArK0dQTWlHajBjQ0laanVPcEwzVVdueDg0?=
 =?iso-2022-jp?B?N2N2VFZlRlRuSVI0Tk5EUlRSSE4xSDJnSkhtZ08wanVYcU9ES3BKR0V5?=
 =?iso-2022-jp?B?RXhaQm9vWnVTbWI4emtIb0NoOVZEenVpUFV3a2dmcU1KaXhaZTdBTEFj?=
 =?iso-2022-jp?B?bmxoNmhoZlJPMjNMejlGbUtrS0dzTFNDZFhIUmRUYmhTVXNxV2xYdUth?=
 =?iso-2022-jp?B?WjJNUEUyTk5aQ1B3WXkvdE90TWNVU3pFWnZBaFFGbDZtS25wNTFYZlNl?=
 =?iso-2022-jp?B?Qno1Z3o4cXJFU2hzZ3NYbGUyT09wSUZ6ejVKQS9oa0dpZkM4dUlNaGtV?=
 =?iso-2022-jp?B?WUEzTmZRV1hFRTBBMW0vWitNZEg1TTBaZmxyd28raCtUT2tqajNiVFYy?=
 =?iso-2022-jp?B?OUlWWWRhUlNHYmNvV0JtM2lKdS9QcS9HRDBsQWZibHZILzAxVVBHMHds?=
 =?iso-2022-jp?B?RE1ua1plZm5QQTgvTjBPTGg2RXZ3WlVHczdlMzVpYlFvNm9EN3F1d0VM?=
 =?iso-2022-jp?B?UHh4eVdsUFhjWWYrTTZHVis4MmNNSHJJWFZSZTg0MU9yTXBRUU5ZenRx?=
 =?iso-2022-jp?B?QkQxblM5em5MczFjUkQzT1QzN1pJL2h2TXBhbkszTU9SYzFLbkVhSnNN?=
 =?iso-2022-jp?B?alhiTnh3YkMvaFFIeVVoeGF4VzFlRUdycXVFQlNRSG9jQkpRZmpQY2Fy?=
 =?iso-2022-jp?B?YWpsNU81QTVIUlNIWEl3c24ya0hyUEJ3MVdrVmhNZENmRVlxWU5sTFY3?=
 =?iso-2022-jp?B?NTdVaFJIYU5TNWcyQlQvTEdyRkFiVGxwMGpYZW1uU2kzL3BtbHV3eDRZ?=
 =?iso-2022-jp?B?N2V3SmRvR0JzWS9nczdnbzZqb1RqYkdNV0J6VEF0RUowdy9sWWlrQXNl?=
 =?iso-2022-jp?B?L1o4WWlIelcxNzBaNlZsZWVRWVh6RGZIV3Y4Y1B1UUdzbE9zK0ZHVWhk?=
 =?iso-2022-jp?B?Q2k0UC9hdXNja2FPVjF5bmlYeXFpdERnNFR3eUYxc011RTcrK2Niekdq?=
 =?iso-2022-jp?B?NTRnR0pidFdXTzJQTWNzdDR3ZktrbHEwYUUrY05zRk5Oek9mM3RZQVc1?=
 =?iso-2022-jp?B?SldFMU9CVitreXFrd3E0Zzl0c3Zzdk10ZVBQb2V1RXNQbHVkNVFidHhJ?=
 =?iso-2022-jp?B?RVRaMmtTeGxhZVVPeEoxK1ExdnJrT2ZqU0xMZkRsbW5FLzFLRHQvV0Rm?=
 =?iso-2022-jp?B?ZzdLejhpVy9kbDdkV2gxQ1ZQNFhkMUFhQ3BCYU9hYkZEUFM0dWhvbkZV?=
 =?iso-2022-jp?B?NnhlUFlnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021)(13003099007)(8096899003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cEVLZUx1dERTVUU5K3BYc3Jub1NrTHErRWM2UkMramVKRVAvdDI0M1NC?=
 =?iso-2022-jp?B?UWdDZVh0aXVhbURiREpEMDcxZmI4VldrcStZODIvZWZKdFBNQW11ODgr?=
 =?iso-2022-jp?B?bXkrbFVWU0E0QVcveG1Ja1lrbUgraE5acWJZNWltSU9meEtMWGdoRUo1?=
 =?iso-2022-jp?B?NzZHNS9scVZCSURXcnNvVE1EelhnZHBiNE9UWElQR00xUXJVTWhpWTc1?=
 =?iso-2022-jp?B?Kzh0djNjZHhNZmw1MDluU0NJaTIwWU9qMStsbzFlWXoxMFE2WU4wcXgz?=
 =?iso-2022-jp?B?MVFxb1B1VVY0SlYvb05UcmExd2cxMS9aZjVKSDE4eVNzdmpiMXBlSFg4?=
 =?iso-2022-jp?B?TmlCeU9ROURiWW1WcXk5YUg5UWw2SGFLVm0rU1p3VFg1eDF2L2Q3Vjhl?=
 =?iso-2022-jp?B?eGl6Qlc5ZnhMZVFCV2xvMjFHSE9zSkVpSERlK0J4elkvbEQzUG00RWFJ?=
 =?iso-2022-jp?B?Q1IvMXdLQUNkSlZSV1FPQUNEM2FkVDdaeTJBMVlwZmVwWVhtd3J1cG01?=
 =?iso-2022-jp?B?RTM0MGVPd2lhUmtQSmlGcjQvK0J4cmM3RW45NFJTalJwTElYU1FJbWFZ?=
 =?iso-2022-jp?B?QjgwbmNtSGR2U1RjSUIxM2xubXUrSlJRWW0weWZEUitRRVRqSW5NZVFm?=
 =?iso-2022-jp?B?NjZmbnpGbEM5K0dHV3hQbW4vQm5DdW5tYUlweTdRbjN6OUZUY01yQ1JL?=
 =?iso-2022-jp?B?YjNpTkN5ZFJXUTFvVWJjT0lRUnF1cWs2cUlXbCswRDVkRWFXLzJxZUJy?=
 =?iso-2022-jp?B?Rm80elduaVVLcVRTZFhCZWlBaHZ3SldocXhnSldQdERxaWxmRWM4WGRQ?=
 =?iso-2022-jp?B?R2RYaHZtWEtVcW5rWENNZ3hQT0gvRlErcXF6THhLM0JTSjhvYTFIejJy?=
 =?iso-2022-jp?B?dEE5N244emZxL2xZSVV2RUp0anY0a0hqdGpmaEhJZHdPV3NMMGV2NmQy?=
 =?iso-2022-jp?B?bjBqY2dNQTZXbnZJcmp5WnhBSjEwMk5qeFNnbSttVUpPOENYWmM0bVpt?=
 =?iso-2022-jp?B?UXdDbitrcVBXVTFnL0dCdktVaWdrYnYwbEVZN1pmSXNXYnN6ODc5M1o0?=
 =?iso-2022-jp?B?WGt1STBqRGppRFd6RGhkc1ZxYjVMNUUxWklWRFRhNUNUUmdVZjJBN0ds?=
 =?iso-2022-jp?B?MlQ2d3JqaUNoTVZRL29WWVd1SzN3ZGNTQVN4eHJ3MEZGNTdVTkI1V1Jl?=
 =?iso-2022-jp?B?WHU5Rk5ITnloVTVPSHZaMG03RW01MGxIVDFReFBud213SEFMYTdiQjNa?=
 =?iso-2022-jp?B?L09tMHZJVmdNVWtyTFI1MldDN0xnTUlxbGtBVDJENFZKMDd4Zk5VM2hT?=
 =?iso-2022-jp?B?NG1iN1pwS3NCUlhla3hjbVBVb25TOHYxZDd2amJPQXc1b3NPWUJNMGZ0?=
 =?iso-2022-jp?B?UzVCZTZLM045Q3lQRS9zbEJFRW9CMld4UUZnM0xFY2lwOW1PN29IWlhP?=
 =?iso-2022-jp?B?elFrd3hFMmVkUEZwUjdXTzRJcWhiMmdDS3EwcGQ1RXI2T1h1UEhNL3Uw?=
 =?iso-2022-jp?B?UU9FMlNaUmlpdnd6QjdqdGNHdktveU5OM2w0TlN0WnlvS1FHUGNMQTMr?=
 =?iso-2022-jp?B?NzNRelRXOTEzZDZuZldVWUc4RkdIeVNzV3pEVEVBbDQ3amdmYUdERzdM?=
 =?iso-2022-jp?B?c3NDRnI3SS9yQjRVSGVsTFJZQ1pxRTlOTGN4YWpXTFI1ek81QlBQL1VP?=
 =?iso-2022-jp?B?VjFHSTZKaTF6WDgycHBhdmNrVmZFYU56Z0kxQTRRUGVGOUJ6N3ZDdjZN?=
 =?iso-2022-jp?B?K0c5elZvQzhoc1JNaWtJWUQwRFIxc1JNR1F2bUo4dEptYnpvNXRaTnRZ?=
 =?iso-2022-jp?B?NzR6V1IwUWlHaTdBeit0WnNoRHViVUNTZ2kzRG5RT2RMSFNjYkNsNnNS?=
 =?iso-2022-jp?B?VDB0R0ptNEN0ZEZKdFNaL1Avcm1iVWR6eWI5M2R0M3BjMzhhT2pqVmNF?=
 =?iso-2022-jp?B?TUlmd0h0NXV4TGFwMXp2bGNsa0o2bXRXMHpvRGlaY0IzekorZjQzVjYw?=
 =?iso-2022-jp?B?WXVqZElXUjEyWHgraDBBMkpUdWowRzhiZ1VxOVJtZXFIWlcvV2MrMW1q?=
 =?iso-2022-jp?B?U0w3YU1lZldwR3RhTDNjTUhhdDR0QXAxK0EwOGhuV1hCbmRiRlFFK1c1?=
 =?iso-2022-jp?B?dWwxcWdYSWtMU1lrKzdEekRXSW5NWkRCZGdSdmFodllBZzZBNkZ5dmlO?=
 =?iso-2022-jp?B?dUg0QVZyb2FXKzJNRkxKcStORk9XN2xBNEtFTjgyNmRBRVErN0NycFl1?=
 =?iso-2022-jp?B?OHpHaTZEOUhVOS9OVTZ5bW0xczlyTm9jTWZPR29LTzVTY0wxNkVIdU4r?=
 =?iso-2022-jp?B?OURnOGpaUUNVQ0JFdzA2NHZwTFdLd3J5aTZkczlxREkxd0xVS3lxRmRL?=
 =?iso-2022-jp?B?OWtqNno5SHVCaU8vaFNtcEdPaUQ5dGszYjN1WVg0ZmhTQk9pUHpGVW5D?=
 =?iso-2022-jp?B?V1ZlbFBKYTVmNU1zdkh3WHk2Qk5UUmlGd2xmU0R4Tm5TQU5Id1dyVzZa?=
 =?iso-2022-jp?B?MmxweWF6Mm5ULzl1UXZvc2llSnltZ0Nka0RqS3ZjM3BxRndWVlNnd1RY?=
 =?iso-2022-jp?B?b0xTdE1Ucz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669482AEDEEBBE66196C416C496ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bacb076-800c-4bfd-9e0f-08de58c519c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:14:29.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GG5zKl+1kvtWm0FXju8+Qo2BMvgjbGVP1Po4g7bx14UARDr1IpGYKB8rd0Wc6rCxhqaa3cnFsbzxUVSQBfiShiBOYsC+pso3SNXfK2bNxw9Y37dLYOV7k62HmsGf0wqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 08:14:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21687

--_000_TYCPR01MB9669482AEDEEBBE66196C416C496ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Any thoughts on this? Do we stick with the current approach or switch over =
to a file in kas/opt ?

Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
Sent: Friday, January 16, 2026 7:56 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; quirin.g=
ylstorff@siemens.com <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable w=
fx based updates if WFX_URL is set

Hi Quirin,

>Why the getVar pattern? In all other cases we set overrides with a file
>in kas/opt/.

I took this approach after a suggestion from Jan in v3  [1]

[1] https://lists.cip-project.org/g/cip-dev/message/20264
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Friday, January 16, 2026 7:19 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable w=
fx based updates if WFX_URL is set



On 1/16/26 12:49 PM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>
> WFX_URL can be set via the Kconfig menu. Enable wfx backend based updates
> if WFX_URL is set at build time.
>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   recipes-core/images/swupdate.inc | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupd=
ate.inc
> index 7cd816a..7041058 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -57,5 +57,9 @@ python() {
>   IMAGE_INSTALL:append =3D "${@' swupdate' if bb.utils.to_boolean(d.getVa=
r('SWUPDATE_SELFBUILT')) else ''}"
>   IMAGE_PREINSTALL:append =3D "${@'' if bb.utils.to_boolean(d.getVar('SWU=
PDATE_SELFBUILT')) else ' swupdate'}"
>
> +# check for wfx url to enable support for wfx backend based updates
> +OVERRIDES .=3D "${@':wfx' if d.getVar("WFX_URL") else ''}"

Why the getVar pattern? In all other cases we set overrides with a file
in kas/opt/.

Quirin

> +IMAGE_INSTALL:append:wfx =3D " swupdate-config-wfx"
> +
>   IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>   IMAGE_INSTALL +=3D " swupdate-config"
>
>
>
>
>


--_000_TYCPR01MB9669482AEDEEBBE66196C416C496ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Jan,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Any thoughts on this? Do we stick with the current approach or switch over =
to a file in kas/opt ?</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Adithya Balakumar</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Adithya Balakumar &lt;adithya.balakumar@toshiba-tsi=
p.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, January 16, 2026 7:56 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; quirin.gylstorff@siemens.com &lt;quirin.gylstorff@siemens.com&gt;=
<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.i=
nc: Enable wfx based updates if WFX_URL is set
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: bla=
ck;">
Hi Quirin,<br>
<br>
&gt;Why the getVar pattern? In all other cases we set overrides with a file=
<br>
&gt;in kas/opt/.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: bla=
ck;">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: bla=
ck;">
I took this approach after a suggestion from Jan in v3&nbsp; [1]</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: black;">
[1] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA37e44283-=
7a19-e271-ef8a-31f7305d66d6" href=3D"https://lists.cip-project.org/g/cip-de=
v/message/20264">
https://lists.cip-project.org/g/cip-dev/message/20264</a></div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: black;">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Quirin Gylstorff via lists.cip-project.org &lt;quir=
in.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Friday, January 16, 2026 7:19 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.i=
nc: Enable wfx based updates if WFX_URL is set</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: black;">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;"><br>
<br>
On 1/16/26 12:49 PM, Adithya Balakumar wrote:<br>
&gt; From: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;<br>
&gt;<br>
&gt; WFX_URL can be set via the Kconfig menu. Enable wfx backend based upda=
tes<br>
&gt; if WFX_URL is set at build time.<br>
&gt;<br>
&gt; Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; recipes-core/images/swupdate.inc | 4 ++++<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/sw=
update.inc<br>
&gt; index 7cd816a..7041058 100644<br>
&gt; --- a/recipes-core/images/swupdate.inc<br>
&gt; +++ b/recipes-core/images/swupdate.inc<br>
&gt; @@ -57,5 +57,9 @@ python() {<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL:append =3D &quot;${@' swupdate' if bb.utils.=
to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}&quot;<br>
&gt;&nbsp;&nbsp; IMAGE_PREINSTALL:append =3D &quot;${@'' if bb.utils.to_boo=
lean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}&quot;<br>
&gt;&nbsp;&nbsp;<br>
&gt; +# check for wfx url to enable support for wfx backend based updates<b=
r>
&gt; +OVERRIDES .=3D &quot;${@':wfx' if d.getVar(&quot;WFX_URL&quot;) else =
''}&quot;<br>
<br>
Why the getVar pattern? In all other cases we set overrides with a file<br>
in kas/opt/.<br>
<br>
Quirin<br>
<br>
&gt; +IMAGE_INSTALL:append:wfx =3D &quot; swupdate-config-wfx&quot;<br>
&gt; +<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL +=3D &quot; swupdate-handler-roundrobin&quot=
;<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL +=3D &quot; swupdate-config&quot;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669482AEDEEBBE66196C416C496ATYCPR01MB9669jpnp_--


