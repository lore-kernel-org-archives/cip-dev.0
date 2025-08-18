Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4457CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 05:11:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.68038.1755493902424384216
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 Aug 2025 22:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=fqO8n78Z;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1755493888;x=1756703488;bh=RatNmnjbbJQCMFSCrv7ZPqulPMc1bANkGIMhx8I
	j414=;b=fqO8n78Zunk4gaUYqk6QAQXbdRTBpuxUTq9/BKyfAbSDkr1Ve3tLKHILazrZZB7dM2+zJ
	JM/KbGgh1/XH9KVMWH3ki2OyF0PfyYZPOTFcx7mWMsTHMe1RgQRA/N89qBX4LjWS5OzOlYwbDUlMG
	o9uurBkFom8z+aCzYTLGZEUpLAMJOYictBk05t5pIyzu2Kc49jU6VJIlsv/qKRDs6eSexx72ZDQ09
	zmPl60IbvzZ1ZptYPHfyXuhXbESBr+xIjM09jNxyT8Tocnp6CIW0B7l4HutWyHN7zYlhWd73rRsY0
	YFOBGRlrXQHGUX+dTfaZG+EoHCrRjwYQhX/Y3tYnmg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 57I5BSGH1309536; Mon, 18 Aug 2025 14:11:28 +0900
X-Iguazu-Qid: 2rWhMjEQNUwddBiv3q
X-Iguazu-QSIG: v=2; s=0; t=1755493887; q=2rWhMjEQNUwddBiv3q; m=hQbtQq7xtw+fP6c4Qzu4px87GGy7VJO0uvV3HLtGbNw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 57I5BQ683388296
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 14:11:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKX55uG+2ND5wtjC6iyPTbaSWxkZ73OdF4Grcf1Zk9JPFdIXvlv0pu61W9q4KJcUPDvJETZvWQZuQmEvOmecTXSj8m4yZN9eYby1fXbmgZeKWlDJXucwPCqjR/FHIkTJg2/RnVTiTlfGSAoKnfXeImoSf8koBNJ7WdZUNkt+1iFQXmnGpM9oqOVOw52cP6x1NyUHdeejdKf1JEQQwb/EmPGrWrYIvdoOI2e72tQWyh4PAIofp0sex3Mw9xTS+Uk9mzc7l2m6M60Kr75ToQZBiutIBORpal93QHiEND81C5RgY3b8r+aMtkrAhLQe0eKX3xEx9TvFn4dXC5nZ0KkJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RatNmnjbbJQCMFSCrv7ZPqulPMc1bANkGIMhx8Ij414=;
 b=qlY1VMM29MorQx95TdyK1wJQUTKYp4Dw24XdMk+OZAccKPT4TUBGCiqil/6CU0m52Q9arwC8fo/81X3lMey+EfNWV6ikunTubWU5IIwK9dDJ5Xz2Wd4XLtAC8+sxV6jlmS6azCKF8txaMnVRxlkFO2Rq3oX1SCLZXYxHVVy3vMF4Oeqmw/65NfRrH/LnIYmtvJHzX6u3W+eqVyUNg9HJatlLpvqxKELmB9S4eU42ea5rJkhTUfhQwkaywQQ1xnV0QW5AAHzSTjW8NCYHpAkIMbu57pPT5P5WyXEdZJnInCeXjlekOWUGqNTuwnRRjhGFSgUXrUioznqJ/b01rCwQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcDOQHXnIFBpubkECVP5g3Dvw2ZbRnnmoQ
Date: Mon, 18 Aug 2025 05:11:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182F05A812EE7B6A818FC89231A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <c2f3c57b-e434-4f85-af9e-4db9ddc0c856@siemens.com>
In-Reply-To: <c2f3c57b-e434-4f85-af9e-4db9ddc0c856@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8523:EE_
x-ms-office365-filtering-correlation-id: 3b4c9020-ee25-44fa-ea98-08ddde15acf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VDIwVHV0N0R4Z202dTd1YlVoWHhGejBrUUFLR3h6Sk5sd2FodTRKSEFsejNB?=
 =?utf-8?B?VG95QWlwWG01bUZyRHZyQzlhMlVQQ29tR3JKbUFLNDdjY0xvdUpodmd1Ym1k?=
 =?utf-8?B?QnNEaVFDYnlYMmVJUHFWUTRkWVpxdnZPaFFiU1VZRDVJWEdiMzkwMU1icHNG?=
 =?utf-8?B?TVhrRXMrOU1kc2ErbVZDQWVWcDFWTkRrc2dtaGlQNk0vMFVNb3dLK3k1ZXhu?=
 =?utf-8?B?R3RWWDZ5VitIQXlZM1cxTmx1YWo1Z3J6ZTE5NGx0NHZYTkM4ejk1R2NiVU4w?=
 =?utf-8?B?dVBETDRya0ZVQVhsK0dyK0VFR21OdUNmbi9rZmdmd3BPS1UwVW1tcUhlMERu?=
 =?utf-8?B?UVFrUlE5RW4yM0FRcFBxNlp5ZEM2bC9qMGVDbkFsOXprSGEyeG9BdnJrb0o2?=
 =?utf-8?B?YWtScytQc3M5N0o0NW9BNDhXU0Q0ZXZpblhyWU5Wa0tzaVBPWEhJYXdZQ24r?=
 =?utf-8?B?TjZxWU9qNVl4S09ZYmZKWVA2UEpSVnNmdEM0TngzMlcrcjhRVlFZaDZwa1RN?=
 =?utf-8?B?eGQ4cGZZamdDUzJWZ0pEeXM2M1hNL3NaZDhzRW42UHkyaTZqU0hwNTlCTTZZ?=
 =?utf-8?B?N2RuSFdwUUo3dDlHTWthSUc3QVltcExOTWk3bTVscnZhVkJpdHJWTzR3MXVK?=
 =?utf-8?B?TE5mU1c1dlNKWVA1aytnVHlZcUJHcEljUmp5b2RkRkVmUmJLTFJEUjJzUEZV?=
 =?utf-8?B?bUxNOFcvOGVhWlBYSTh6Qm5EMGM5aXFCeHRiQWtpbDhiNG9aR3AzMTF4ZlRy?=
 =?utf-8?B?L2lPWmRITzZJa2txSE9tRzA1Ym1Zb1p4dVN6SFVtV3dIYkprNURISU5RMkVY?=
 =?utf-8?B?NmN6OGp2SmhvSElya3FJeDVYOVgxaENtaDdLRWNsVEYvTUJwYm1rS3FLbzM2?=
 =?utf-8?B?VkhvdHI1RzlBNkl2RTVLMWl2S0FFNmF4Z2xERFNFM2lTTlRRU2s1UGlLMVV5?=
 =?utf-8?B?Y2dUVlBBQnVkODhZbk45WmVWTEdQTUV1L0s0cWMwY1hPMDhmaHhqazZPdnND?=
 =?utf-8?B?UHBrUkxsdTRDc0Z5QWFCTXFKcDNpUEVWN1R0REFyUWtkUmVtVGNhMjRITTlR?=
 =?utf-8?B?dDd6c2tYYUcwaUVnbXhnbTN3ZU5pQVNUSzZaeHZHck1SR3RaNWdIb242Y0d5?=
 =?utf-8?B?YUVwakVhV2d2S3BEMXRlWHpNTkNHYWpweUROQ00vRmI3OXZDeVlRL1NVbDc5?=
 =?utf-8?B?V3E3TG04azZwb0E3Mkx5MWFiSTZvTEY5TkdTOVQvWFdoRU5vRDk0TUNGQjdv?=
 =?utf-8?B?b1hnbCtNQytGeTJDYXo1Yk9SVEpuTUovNVZxUHB5aVEvMTdwWUlDa2M0aEg4?=
 =?utf-8?B?cFJQeUpjcFExSzViRDJJSkZCZTc5NndGV3plZGtsbWo4RkEwYjg4bjNpNWcv?=
 =?utf-8?B?a2VjSG82NThaNk1uaU5WOVdQMEV6OGEyd0xReVlNd0VUQ1V0SmNxdUtxR3dy?=
 =?utf-8?B?ZC9nNmdlOFIvVGxDYzdLNHpSMmlSN05qZEtNdnhZN3E5Q25sLzZ2VCtMb0Jl?=
 =?utf-8?B?SE5jbEhsbml0WWdNdkE1TXpCcHRoOVNPZ3JxVTk5MEFCdEFDNFdKZjIzUEZ6?=
 =?utf-8?B?L0IvMUloa0p6cVBiaGhoOWZOK05RSTNETEMyUE9ERzIzZjhUcWVsMU9BbTNM?=
 =?utf-8?B?bVNRdVRlR28vdzhKWTd5bk5CeWtBRmFaS1ErSXZ5b2EwYXMzZURIWFN5Mm5n?=
 =?utf-8?B?UnVJQVUwVnZ1cStLRGE0bXdFTHZIRzBIaFNLZHVmZjBDVmE4OXl2S3k3b3hp?=
 =?utf-8?B?dFp6Y3BEbGp1Wm8yQU9MU0pZWDhaTEk3aXBlT041MEQyeHdqUjFXRlI2U0NF?=
 =?utf-8?B?UDZhSXZrVUh6elZ5VXNQMGJmOEw2UW8rYkpwWGtXYk1SQ0d0NTJGK2xWK1J1?=
 =?utf-8?B?RG5zdHRKaVNHY3lDRU5PVnRtMEJmMmE1RWR6cDFFUjZYNU5Ba2tpUVUxMWIz?=
 =?utf-8?Q?Iu9KWXB0lAA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Vm5WbDhsNUZ6RTEyK2R3ZVhabTE2SVl3V0N2cksvSSs0M1o2dHZOeVIwS3Yw?=
 =?utf-8?B?OHZtRHd1dWlTNjFRbm5zbVJQTFVGclhkTjZmMkFhOTdQcHUzNDdjazd5QkQ4?=
 =?utf-8?B?QmpsMkpXWTQvempHSUM3U21HZkVIWjJpSEVMMml0RnBmcDc4bndWTDNRcDFB?=
 =?utf-8?B?TmNMRzg2cFJLN3JyRStnYlQ5YXVROURTREVmdXlzL0YxZVZhejNmbWRWdnVz?=
 =?utf-8?B?REd3MEMrZ3hMNTAreXJrSkFTdkNHdVR6V29rcUVnNlcwT01UQzlZbHFETlRx?=
 =?utf-8?B?M09pY2Fnc054bWFiMVNROHMvVHJkaXNHMkRzRGZDZDY4cmJLRThIdG9yRHZs?=
 =?utf-8?B?anY5WkxvNnZ5WElmUlJmYVplcFAzQnlLaWZ0UVgwRUFOcGVxZU4xN1hSTEdh?=
 =?utf-8?B?ajM2dlAxRHlXR0xpMHZLdk5pWmVEdXNNNGg2ekk2bG9CaHUraThpQU0xWlUx?=
 =?utf-8?B?dW5DVndhdVVGU29ZY1N3amsrd284enJzQk5QQTVFemFPT255cXQ0TVl1bkdo?=
 =?utf-8?B?d3lleWZ2ckNaTFEzNVFxSnExMzdzSFEyM3cycWFLeCtKS3pQYU5UMVRNMjgw?=
 =?utf-8?B?ZTJhb01LM1RaRXhrMUpJTDVrWjNvaXFEaGpDeEZGZFdGQVRLcUJWcHRTNWJP?=
 =?utf-8?B?RG14RkJXRmIvdkRmU3U5SVh6Q056RHYwNk8xcWREbmlxWUpMMlR6VHd6ckUv?=
 =?utf-8?B?Ulp5VVJRNkRVSy9manJObWdtbVdQcXBKY21DTjNNV3hYc3ltSlcybzVXTDUv?=
 =?utf-8?B?Vmh1NzJvZkQ2N0JoMVFrU2VUY3g3WE9wZjdZM0hFZC9BaWdtZ0I3U0RUN09t?=
 =?utf-8?B?UC8ybzB1Uko0S0h3S1hBM1h3VkFCNS83NFBXODg2RWQ3clNFZFhmQUY5UUNE?=
 =?utf-8?B?ejBiMnNNdnQ1SXEzVys0aFFaVnV4bUdXL2ZPL1lmd3AzaVpiZkxnTEl4N1di?=
 =?utf-8?B?TURNTU9DOE4wVmgxK0tPOXl4MGlaVFhkdWpReTR4VE9LcTNtOXNxRS9BL2dj?=
 =?utf-8?B?QkJaaHFhc0JkTGh5c1ZybkZEUmVtMmFrZnRTbzBlQmR2Q3FVTGJ0eUZvOW5q?=
 =?utf-8?B?NERhMkZDdlloWFdnYjhmNytLTXRKZkM0dWJkUXJzS3hwelArVktvMFNGTHZJ?=
 =?utf-8?B?VjlBQTUzNHNtejR6TUU0a21DaDZTdXpqaU9OS0lYeGZGdmRSaGpDcjlHaXRJ?=
 =?utf-8?B?NWxRMGdlREMvTllaUTAwYWdQQWNzdEhycWtZc09qYThLbmJHaUNTOU5RM3NR?=
 =?utf-8?B?KzR2WUlKdHp4aUl3ejVncncwbXljWWhsbTVXOUM2M3hBQ0RZU1V2b0M0endh?=
 =?utf-8?B?Q2h6MU81WEt5ZFlSL1Nkd2FnZS9iaWRoUmtoMVlqdG9HU2VXSnBpRlRnWFJZ?=
 =?utf-8?B?MmNod05YZ05oRVcvOHBGckNDR0VvcHcwS3hDeC9jZmk0WlFobmRXcVMzaWlK?=
 =?utf-8?B?aXZxTzgvS1JTWkt6aTJwYWNLbzdtN0xYcEhKWE1veUNONFF2OWlqclJQSytZ?=
 =?utf-8?B?em5ick93Z0FNZ3paZ1lwUzFGamdLWlh6L2xXY1pDOVcvQThLRlJJWmhPSVJp?=
 =?utf-8?B?aG1HNitUb1Y3NFVTcVpyamxFZ0VKQ3VHZForc0NqU3NhSDBFM3VRQ1djRDBl?=
 =?utf-8?B?dzkvWlJJWkw4M0hGcmYxbEJXNUU2Z3FjWkM1R2dyWkROYnNETFRBZTBxenNh?=
 =?utf-8?B?WUpsMklFSmx1dW4xVU1pMnZTYjZEQTJwNkxjcXdOQ2ttVXg4YWV3TEp6eWtO?=
 =?utf-8?B?dm1WUXpyYTRIUGsyd0srREkwZFRhNHQrdzZpSms4d1IzVDNWWndKdWRLN2dJ?=
 =?utf-8?B?TGNQZVQ5dkc5N2FUMTBkT2oybDhrZ3NwU3NPSHUrWkVaVS81b3h5dEdTVnlr?=
 =?utf-8?B?WXRPanR2d3A0KzJTSTFGK3d2b1dZenNHSm5HcUN5Uk1zdmEvdjgvcWdZNC9U?=
 =?utf-8?B?Q1UvUy9wbFpoa29XTDlFNDZ2NmUwalNIUitZWEs2WDJKdDhKdW14RWdlVGM0?=
 =?utf-8?B?elRVc21VWSsxdjF6Q3g4ckZ0YlJwaFJod1ZxaVh5anQ5WGZjSWZvZzR5YTNp?=
 =?utf-8?B?SjdmMXVwRFhrd1VtYkgvQUN0Qm0xTVhkTlgyTzFLKzk0dVBHdHV0UFBZcHF0?=
 =?utf-8?B?TWplVThPOVN5ODhHcW1zRGlmWnkwZlZ0V1JSWmVmZUZydXJldnExTEwwWkhv?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4c9020-ee25-44fa-ea98-08ddde15acf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 05:11:23.3541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQbBev53ZQt0pnK+lhFoFl0rIW9KsGBficuwEj7UTXL41tG+0cVkTtlmQwi0thZIRb3JAZsxD3FKDmH/jYprml+1ww/bWHjI181WoO4z25BtNA/HpiVYW/u3vL7aorzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 05:11:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19751

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUaHVyc2RheSwgQXVndXN0IDE0LCAyMDI1IDM6MjQgUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3
ZWVrbHkgbWVldGluZyB0b2RheSBvbiBsaWJlcmEuY2hhdA0KPiANCj4gSGkgYWxsLA0KPiANCj4g
S2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJ
UkMgdG8gZGlzY3Vzcw0KPiB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4g
T3VyIGNoYW5uZWwgaXMgdGhlIGZvbGxvd2luZzoNCj4gDQo+ICAgICBpcmM6aXJjLmxpYmVyYS5j
aGF0OjY2NjcvY2lwDQo+IA0KPiBUaGUgSVJDIG1lZXRpbmcgaXMgc2NoZWR1bGVkIHRvIFVUQyAo
R01UKSAxMzowMDoNCj4gDQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2Nr
L21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDI1Jg0KPiBtb250aD04JmRheT0xNCZob3VyPTEz
Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0xNzkmcDM9MTM2JnA0DQo+ID0zNyZwNT0yNDEmcDY9MjQ4
DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVLICAgICAgICBERSAgICAgICAgVFcgICAgICAg
IEpQDQo+IDA2OjAwICAgICAwOTowMCAgICAgMTQ6MDAgICAgIDE1OjAwICAgICAyMTowMCAgICAg
MjI6MDANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2JvdC53bC5s
aW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdzL2NpcC8yMDI1LzA4L2NpcC4yMDI1LTA4LTA3LQ0K
PiAxMy4wMS5sb2cuaHRtbA0KPiANCj4gKiBBY3Rpb24gaXRlbXMNCj4gICAgLSBkcmFmdCBDVkUg
aGFuZGxpbmcgcHJvY2VzcyBmb3IgQ0lQIGtlcm5lbCBbSmFuXQ0KPiAqIEtlcm5lbCBtYWludGVu
YW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KDQpgYGANCjEzOjA2
OjI3IDxqa2lfPiAjdG9waWMgS2VybmVsIHJlbGVhc2Ugc3RhdHVzDQoxMzowNjo0NCA8amtpXz4g
Ni4xIGlzIGxhdGUsIGxpa2VseSB2YWNhdGlvbiByZWxhdGVkDQoxMzowNjo0OSA8cGF2ZTE+IDYu
MTYuMS1yYyBpcyBvdXQsIGNvdWxkIHdlIHN0YXJ0IHRlc2luZyB0aGF0IGJyYW5jaD8NCjEzOjA3
OjMzIDxwYXZlMT4gQWhhLCB3cm9uZyB0b3BpYy4NCjEzOjA3OjM5IDxqa2lfPiBub3QgeWV0IHRl
c3RpbmcgOikNCjEzOjA3OjU0IDxqa2lfPiBhbnl0aGluZyB0byBhZGQgcmVnYXJkaW5nIHJlbGVh
c2VzPw0KMTM6MDg6MDcgPHBhdmUxPiBJIGNhbiBkbyA2LjEtY2lwIHJlbGVhc2UsIGlmIHlvdSB3
YW50DQoxMzowOTowMCA8amtpXz4gc3luYyB3aXRoIGl3YW1hdHN1IGJlZm9yZSwgYW5kIGlmIGhl
IGRvZXMgbm90IHJlcGx5IGJ5IGVhcmx5IG5leHQgd2VlayBvciBzbywgZG8gaXQNCjEzOjA5OjA5
IDxqa2lfPiBidXQgSSB0aGluayBoZSBpcyBvbmx5IG9mZiB0aGlzIHdlZWsNCjEzOjA5OjIyIDxw
YXZlMT4gb2suDQoxMzowOTo0MCA8amtpXz4gbm90IHlldCBzdXBlci11cmdlbnQsIEkgd291bGQg
c2F5DQpgYGANCg0KVGhhbmsgeW91IGZvciBjb25zaWRlcmluZyB0aGUgNi4xLnktY2lwIHJlbGVh
c2UuDQpJIHdpbGwgcHJlcGFyZSBmb3IgdGhlIHJlbGVhc2Ugc2luY2UgbXkgdmFjYXRpb24gaXMg
b3Zlci4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


