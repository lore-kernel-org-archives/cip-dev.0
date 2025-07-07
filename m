Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCA7C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 05:00:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.52783.1751864455054250564
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Jul 2025 22:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=P56gppkH;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1751864439;x=1753074039;bh=Wa3gPspXFZu3LUcTrcDe4JdBDdQxydqoQvYxKKm
	rKtU=;b=P56gppkHW3HFdZUPgKxqjrgB5AwhPt4YdXZ3dwdjacv72MesIouRdEXYWZHf6uVVQP60H
	lmsgG5FQNaFxab3mCGdBSaW2rw3Per2QKAAMoaMXLz7b6F06QrETkJ1och2oENwft6jKjli4DlFYo
	sVhKWS1xti4q78MP447vM+xDzqynuZjseASLm8UJqoNlXRI71Hi21TKYqPUbf9PLl28jjTG5wkRPc
	nM5Pyj2sI5b4JtwBitlUH/6TRqaW2KFNE06QNz27HhdGDvRDEQCcs3PT0uQslqSDTtE07VyjazTEy
	6bZv0fe6718T9sOY9L5EEnvy6Ud2pLaUJXT3a2roqw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56750cNC605399; Mon, 7 Jul 2025 14:00:38 +0900
X-Iguazu-Qid: 2yAbG2MEIkj4Q5HPpy
X-Iguazu-QSIG: v=2; s=0; t=1751864438; q=2yAbG2MEIkj4Q5HPpy; m=ZCxw3yT0GVm9Rc3+UNIJRR1CipcY5FprZg32tQfxLQI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 56750bLe2549692
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 7 Jul 2025 14:00:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPrwuW5WIYLKjnwCNPv/hFtX5kIOcKP58lH3tRY26ANnpZGAcOG855o1BK/uv7l2TirUTHuuCXXjQZXj/wPg6lJ5Axn4Tm8kUg2JO3ZTy6//7KJu1nDZvxtgDdSxOcywMSgKKOTvKqztvsvTA0V1a6q7BWNHyX22nCBQGVlAxba7wt/HCOTxzzztGJq/5qanpUrCjN4N/dERLVlGBcbrwEVK2qCvwqbK2NXdNanpqy+OV0YPo/BwDeRqD7Yd1Xrcut6s+Ha9uN8SGXcr1ZJz7Ms/C2dnKXWdDhSRcQe0jD9KguQ1gaJNRLrO+2jMq0xyCb+SqRVfpvk4+iZwS+xJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE6AFHFM87hn74dlqVIgLaeK8o/xZtz1Z+LHw0s8ULM=;
 b=ZSBkQnVzBEogQNOu+TTRQT7VhIsatlfWjitoKTBV71vThjEL6OjGaBM9mPFYVnUVNoHdussv87w1AJ2S/SEZrk6Dkw/nBA3rxD5xlBrpqbYyJYEd03WoCCQbg2i2f6qrH1L8nFIAykBytG6hcBo+ygsQiexzDq/gIvXrN4xKF9isKYFcr9LnbGDgYQ3L2X4sdTCg6/N1zds9xAQutF6BUFriSrzI9M8LnevL6Ry6a27xqBgmea2dKZf5saExmTG+uDu+z1w9TIVa/tjExGf0qUl88+ryOKtS8e8sT7nyEGK+cpTGjXZUo01jZWA8QhuulKAqx7rSNbsZFQU2Urt8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Thread-Topic: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Thread-Index: AQHb7MMi1LBAP1sIC0mK+tDd0YhVrrQmHmMw
Date: Mon, 7 Jul 2025 05:00:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CB81D68F62448BF2E546924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB12816:EE_
x-ms-office365-filtering-correlation-id: f0c491e0-20fc-4ab0-a0ea-08ddbd13352c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Q3dxT1hwc1VBYWV2V2xCcEpLR0d6dzd5alNnaXl5dkMrcFNFNFVraUtn?=
 =?iso-2022-jp?B?TUlKdVc2VzdnSmNPeUJ5YmJvTTFtVEp3eFJsVXlQM21CUWtXWmNMQXk1?=
 =?iso-2022-jp?B?cDY4RzZqZ1R1dytFck9Oa2Nydkh2Uys2cTN4dGp5MEUrSHdwaVo1MXVa?=
 =?iso-2022-jp?B?ejNPZENHdm1YanZMV0xSU3NXNHN2WmNxaHFicWdEMzlFN0I0Vm9aTXFx?=
 =?iso-2022-jp?B?blJUdXUwa3R5NkJxankzZ3M2ZStUbmlUQU1pcU9VdWZGS2doR2JOTGRn?=
 =?iso-2022-jp?B?OFprQnA3STVvLzF6VDFxVVpUemZSWlhDTmdGYXcrSWg2MXdDWVZkQ2Jl?=
 =?iso-2022-jp?B?Vjk1QmZ2cTBVMjk1L2lxZkRzYllKWmUvbkxQaVF1bVB4SGV3a2JnZmh0?=
 =?iso-2022-jp?B?M0o1QVhDMFNRMHYycWtncnRLNVVkNnFYdTJNNzZBSlhCZEF3MmYyT0M1?=
 =?iso-2022-jp?B?Zkw1cSt3Y2UvR3JNUXdrSFAwNUFoYnpWdEw4dUNHaHJVaWVIQlZDR0gv?=
 =?iso-2022-jp?B?dzM5ZVR0VDVkUHBFUU5KRjlmV293UmF0R1FjT0pTdWJENStJMVByNnpP?=
 =?iso-2022-jp?B?cmF1MTN0TUI0dUFUdi9RZU5qNENyTkMzaUU3ZG5GUHdsUU9Kd0RXMVlm?=
 =?iso-2022-jp?B?WjBhSzNuai84bVZoNlhhcDlwMGd1WVpOWFFhVElXWEROVmFPNlp0ZzJE?=
 =?iso-2022-jp?B?dHRDT2t5cS9aeDd0b21IeXdCTEhqN012OC9SdmhNblp4NGlUV0xCby96?=
 =?iso-2022-jp?B?aDBVTkVXV29HQythN1ovUDVuWkQ3dURaa2lHOUZxRUpIQ2M5a2FrRHpi?=
 =?iso-2022-jp?B?a1VvTVRQWWo5dWpSNG82Q3RINlFJOVp0bUxLazVZcEZ1YmZpa1VBZVRQ?=
 =?iso-2022-jp?B?azcreHZWYmRmY0phcmNFT25HdHZrdUpVekhza2pxUUxjZlhpc2JSR0tq?=
 =?iso-2022-jp?B?VFN4SFpVcVhSY1dDL2ZDU2pCWE85OUcrOUhZVFlzSHFlUzFqNXo4UDRH?=
 =?iso-2022-jp?B?YmZoVVRCaURQUm5Pbm53dUJmQjZwTzRUUHB0L1N2Sm9pRXdSWGJhUzJl?=
 =?iso-2022-jp?B?TlRQRGRsRzNpUGY5WDJWYUhBTlRVVEs4QlpWV1g5T2Yrb0pMOGRXSDlu?=
 =?iso-2022-jp?B?MzF0RERMK0lIVlN1TzNYTENHT3R4TWxpWjVKbjBXTHN6UG9JdzVxRThT?=
 =?iso-2022-jp?B?MXF3YVM2T0dpWE93ZE93OW0vR1o2bkhDWkxFbW1rMURDbXdueXgramI5?=
 =?iso-2022-jp?B?QWVlUXlxbERaaVZwenRZNUVzbmlHNnIwMTBtaWtJWFF5ZWZuSTc1ZjRs?=
 =?iso-2022-jp?B?TFN5VUR6bno5TENsS2ltVWFXWU1LeU16b2RQK2ZrRlhiS2dsT1JWN0gx?=
 =?iso-2022-jp?B?dXBoYnhyWUhwdk5lL3IwM09MUTJTWk1qNVRtWlJPdTR5NzJRRFRvaXB2?=
 =?iso-2022-jp?B?bnJ0N2IrS01CN3J4WnB0eHNkRHpCNHgyQjVvYWh1K2xmaHA3QmU0eUF4?=
 =?iso-2022-jp?B?TFU0WUc1UkNNaUU0NDJMVTZvVTJjZU85MDhPNkFpRGxyTTlnWjh4eDBF?=
 =?iso-2022-jp?B?S083Ynhjd0lDWk5HQitrVElhVmpaYUZnSUZ1UlpSbzZ0SFkycHlYemNB?=
 =?iso-2022-jp?B?UEhjR0dZV2dpWnhqazRHQ0haMDJrWmFDNHIwbDFmQUZMMVYxWUFIck5O?=
 =?iso-2022-jp?B?ZzZmZ0VIT1BMeTVRa2tFRlg1dkl2NGw5Q0NNYVdOc3UzN0VESGY4MjNz?=
 =?iso-2022-jp?B?Mnl4bGl0VTgraUhiNUl1cHdseTVmMlQvTGdNdkNPZ0hIS3BWVmVmWlQ2?=
 =?iso-2022-jp?B?SWJSb3NpdXFWTnY0SGZvVGRmQ0kwMHJGL2pqNmhFS0k3NVdoOWR3clhq?=
 =?iso-2022-jp?B?YW1uSGJNZk5DK3JrRkUxS2M3b1MyR0k0R1FkbXp4cHFja0NzbWx5Y2k3?=
 =?iso-2022-jp?B?MWhjQnFOQXNFNmhTRlZkRWdkd1hqK0J2TGlDWG52TnA2MG04eUxEZzBk?=
 =?iso-2022-jp?B?VlA0WUg5TjVickoxdXl0V2ZmMmdlTEIyZE5jUDhoZnYra0dWR1cwZW1o?=
 =?iso-2022-jp?B?WnV1anRiRVpjUTcyUFREMXRhZFBmUjNjY0MwRUpDMEhNakRBQlp4YUJG?=
 =?iso-2022-jp?B?azl0cjI0MjIza01ZcGNvTjhCU21GS0t3WlFORXMvM0xSQmFoOW56RlBF?=
 =?iso-2022-jp?B?K1dFPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NFIyZ0VGUnhFaFlrT2d0bU14aGNUWFRVeWtFdFQ5SysrZTVZUHF3Sllm?=
 =?iso-2022-jp?B?UlFkN0gwZUVNYys2dGErZW80bGVwSFNza3BnSTIyTHVBS1h6UUtYajli?=
 =?iso-2022-jp?B?cmtMYXV3RGptQmZnT2VtT0ZUek5EWm1XRVhEWktZeXpXa1pEZnB6L2RL?=
 =?iso-2022-jp?B?ZVlVYUQzQThUNjVPSEc2cTVrWXk3TlRWb3ovc0s1ZFh6VjVESkxORHVi?=
 =?iso-2022-jp?B?M3daN3EySXZZVzIvYnJHWXdDN3lZQ1p3YnpTNVVBWVJvU2FSeEhvM3BW?=
 =?iso-2022-jp?B?cDZqM3dLRHJKRitSSnFYUWRlMjNub1hDZ2F5QXpNcVVseEVONHFmdFg1?=
 =?iso-2022-jp?B?THBmazZubFZsaG10L1MrS2IxL2xMYytCWUZ4QWdOWTZXMnZBKzVwWGVX?=
 =?iso-2022-jp?B?V056NDc3QzJuOTNJNWJ3a1VkckY4MVVteklPL3ZtUHExT3Y5dTRtd2RC?=
 =?iso-2022-jp?B?b1dKcjZxM0xzRzllUTBFYm1lMkc2M3oyRVVyWXpKYjZNMmdlR2lSS0Jv?=
 =?iso-2022-jp?B?by9HbDFKcEtZVHlMN3llYSttMUFVbktrVExCOWxLajQrWEdpa2RjdG9L?=
 =?iso-2022-jp?B?NTlmeUdDRW1mdEpLL24yTFU1d3YzWmdPL2tDblFMQzcyMzl5bnZQclZl?=
 =?iso-2022-jp?B?QlZyaFpnbHdVeDRrbFFWMU45V01KZGdmcG1YenZzWkU3VENRbmxpbFV5?=
 =?iso-2022-jp?B?dGJ3bEUwTm5FZ25ubkxFLzRPdGNDOG9KcTVONkdzNlhNamZwdm92bS9l?=
 =?iso-2022-jp?B?THpLMWpLY2VGWlAwOTJraXdMK0p4bWhYT2RoMHVGS3ZNZ25SeEQ1aitu?=
 =?iso-2022-jp?B?VzhkZHpQVEpYMDR3d3U4MFprZ3VZdXNpblUwOUZudkhlYzk4NEZpdmV5?=
 =?iso-2022-jp?B?Tjd0OExZUGh2aU5qTU0xeGRnZjAyNWxYL0g1QitlcGRocDRtM0pNT0Vv?=
 =?iso-2022-jp?B?Mm5KMzk5RzlMNjcyWmdSdzJwVEJ1ajJ5Y3g2ZmVvbGR3RGJCR0oxSkZY?=
 =?iso-2022-jp?B?UldyWWVCZFQvNHhYUDNvU0NDQlBMcFVxQkxTbncyTXlPbkRLckR6bDBT?=
 =?iso-2022-jp?B?RWpyOERib2lUclZ0ckw2VUc3UjVlc0NFL0hCYTBKeW9XdWIwanh6czc3?=
 =?iso-2022-jp?B?blVackxTemZyOUtzcWQ2dlFidWZCTzFyR3F4dnBnNlFheWJMNlUwcTI2?=
 =?iso-2022-jp?B?MnMrUjJqNU9EMFF6Nkx5Z0ZURVEzbE93UFJtdHptYUs0YzdFS3g0c3lk?=
 =?iso-2022-jp?B?MTU3NG8rNEd5OVhJS1duOGRoRitpcnVRcUhnMVVWWnE2d0cwU0JaRk55?=
 =?iso-2022-jp?B?VnBEM3hCTUh2L1JHT1ZVaUN6bHlBV1VHWS9KUlR6QzBwV1pMVVVwZkpQ?=
 =?iso-2022-jp?B?ZStzOXhEWHBYaXUvNEFrbGlUVjFjVFJtdVVITnRuS2RoSkdVejNoOXVo?=
 =?iso-2022-jp?B?ZysrTUc3eVRTRWtRRml2SjNoeXpIN01qb1JpT1BJQlRId0tORmVjUS9h?=
 =?iso-2022-jp?B?eENVcm9Fd05Ya2NCb1ZNSmdrSTlvL1g2enVnUFYzVU1BUWRYYmtyWmha?=
 =?iso-2022-jp?B?SDBLSnZVV05mYmdVemZsd0RyZXowcVl3K0lsbjVYWEQya2RlRS9ROU4y?=
 =?iso-2022-jp?B?ZkRzVXR3TDRyQ1JKaHRKU1NCbVFtaXR1bi90eWhYUk5VZ1JFbHdCTEVp?=
 =?iso-2022-jp?B?cE0yK2p4a2Z6MzJsTVY4dysxVUZLZTlxSVR4ZEVMQVQvYXRLdnlRbEpv?=
 =?iso-2022-jp?B?WFRNMHpwWFJDN1F3MGNldjBvVWVxSUY2V24rdkJjZGJUZzQ1ZDFWY0xI?=
 =?iso-2022-jp?B?citlSFZOMHpSMnd6VGJOZnBKeHl0YkFRTVFKaGM5WGtMNnkrQjdBcCth?=
 =?iso-2022-jp?B?SGFYUWQvOTRXcDZnYWdPSWVXZlFXc1oxdmhyb3E3MXIydXluWmR6bVZo?=
 =?iso-2022-jp?B?VTVaZk85WkpGRTFJVmVDeGRmYlM3N1UvdWxLY25NMThvZ1FLSnA3MlpH?=
 =?iso-2022-jp?B?R2w3V2I4MlZqbVF0alJhQXk5WXhiOU1TYzk5ajkvZTR6aEp5V1NqdHpG?=
 =?iso-2022-jp?B?RnQxdzFOZ1orb3hLTEZucXNLQVVna0p0THczdkZGUjV4bEhLQmRnL0NU?=
 =?iso-2022-jp?B?RFRSOWYxbVRqSmE1aFBaam5OTVdPVk1hMk53Rm1ZSXNVYTN1Rklyd1Js?=
 =?iso-2022-jp?B?WEVTNHY1UVFaUzVINXdZandIeDlFdmlWRDVXdmVoOExBODVJNklHYUJY?=
 =?iso-2022-jp?B?dFBMSnNtWU9MNWZGN2NjcG5ZWm5CQVZmWGNDQjVaSUpCdUJzblhiejlY?=
 =?iso-2022-jp?B?MFExN2F2QmZwVUtkTEdZbHMweE40WUkzakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c491e0-20fc-4ab0-a0ea-08ddbd13352c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 05:00:35.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzbzOwfFcNLRUGhWpSmD42l3koLNtEVv4wxJz/H9XbrwNsci8YVwayIU4o9AxvLkoXWohhOyxmD8mfEK6WjjNwIHquloCMn3fJssHn8+LAmf2xPa62WvlrURwV5GhkPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 05:00:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19367

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Friday, July 4, 2025 6:07 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
>=20
> Dear All,
>=20
> This series adds support for the RZ/G3E ICU driver into linux 6.12.y-cip.
>=20
> The ICU block on the RZ/G3E SoC is almost identical to the one found on t=
he
> RZ/V2H SoC, with the following differences:
>  - The TINT register base offset is 0x800 instead of zero.
>  - The number of supported GPIO interrupts for TINT selection is 141
>    instead of 86.
>  - The pin index and TINT selection index are not in the 1:1 map
>  - The number of TSSR registers is 16 instead of 8
>  - Each TSSR register can program 2 TINTs instead of 4 TINTs
>=20
> This series applies on top of [1]
>=20
> [1]
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D978150&state=
=3D%2
> A&archive=3Dboth
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (14):
>   dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E
>     SoC
>   irqchip/renesas-rzv2h: Fix wrong variable usage in
>     rzv2h_tint_set_type()
>   irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
>   irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
>   irqchip/renesas-rzv2h: Use
>     devm_reset_control_get_exclusive_deasserted()
>   irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
>   irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
>   irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
>   irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
>   irqchip/renesas-rzv2h: Update TSSR_TIEN macro
>   irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
>   irqchip/renesas-rzv2h: Add RZ/G3E support
>   irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
>   arm64: dts: renesas: r9a09g047: Add ICU node
>=20
> Fabrizio Castro (2):
>   dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt
>     Controller
>   irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
>=20
> Philipp Zabel (2):
>   reset: replace boolean parameters with flags parameter
>   reset: Add devres helpers to request pre-deasserted reset controls
>=20
>  .../renesas,rzv2h-icu.yaml                    | 280 ++++++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  90 +++
>  drivers/irqchip/Kconfig                       |   7 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-renesas-rzv2h.c           | 601
> ++++++++++++++++++
>  drivers/reset/core.c                          | 119 +++-
>  drivers/soc/renesas/Kconfig                   |   1 +
>  include/linux/reset.h                         | 274 ++++++--
>  8 files changed, 1278 insertions(+), 95 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.=
y
> aml
>  create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c
>=20

I reviewed this series, looks good to me. I can apply, if there are no othe=
r comments and test was OK.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


