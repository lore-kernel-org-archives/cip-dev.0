Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C297D6ACCC
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 12:59:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web11.71295.1732712386710044309
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 04:59:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ELyhhwz3;
 spf=pass (domain: renesas.com, ip: 52.101.229.54, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+BkVIAckPUbSBp3ICr6lMkr3B8Mbp54pLuceR+7cVRFaRkf5Zole5nvCuQg/+WUYddvkrsX66mFzdszKSzBh9GMV9e6v7IYyE/+k9pSDATz+7HjmqbX37YBq4S+EqC92XoRUPUPMjSbWoQ9H3BNT3k0DIM4KJ2IexOK4jWuj0vE0GWcL7zyNqw38LKzxmc0kWzDfDnz8rUsWWBS/8BmsrA9XJmgpjySgJYhjxfsoiwtan86+3pYQ2AKSSjXM3l9uAVhOonV1m4+c1wXeIgJuQauEv+jsBRj9HUa7LX2E8uBFLjv+bVTs+3RvTue+UN4x8nOg/E2Ka63Yzgqc/GCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKy8XDt8hRl/adHupa6Bm9G5tYpTCM211hFCAgSGTEk=;
 b=ogWOaG6QgB/HWl46DzqoGvXh1FuxyC0CKecl7vFrXiHyQu1EeAwVFQfk4doDPfIET2k4EdcFJ3NTTvJAIxMy6yBpOgVkgdQqhjarr8qdHFe7Q6QTrnCy1+iDO35+KEQBE/T/q10HRKYJ1XwHNXTc5xoflS0FcjOUGvtuVO8D9iTg+ErIHP3yMT77y+REoiwWdH7spLlUFAPfZjEurFV/U09F8YKMz+JIpZwQ9kdsg4QMqO+K1zM/3mknhSKP8lAVyhgCA1KKGL5TDQAPw+Q8Nkpn3dafauPrd2Q0awsAg1x6digBItrWccd9qXN016+Y1F1yaeD/Q4HO5HaJHKVzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKy8XDt8hRl/adHupa6Bm9G5tYpTCM211hFCAgSGTEk=;
 b=ELyhhwz35zzDfl6i+H4JsbO+Pm9VNQhn1hnSgj7sDgoQqQil1ybPsrw8qTzBKBLEA5JM1Hj/K9E2h93comUYO08gJ9HllR95ibQxPa0RpmP8o3E5saSaja+o+GxN8ddywgrqxFJ1oif9WwGKhUx+3xHts/ACVa26NQqQicf0FrE=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY3PR01MB10254.jpnprd01.prod.outlook.com (2603:1096:400:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 12:59:44 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 12:59:44 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLAK5wgAAWMGA=
Date: Wed, 27 Nov 2024 12:59:44 +0000
Message-ID: 
 <TYYPR01MB1240204190923E866C03D6A3DB7282@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <180BD4AFAEBFC264.18476@lists.cip-project.org>
In-Reply-To: <180BD4AFAEBFC264.18476@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY3PR01MB10254:EE_
x-ms-office365-filtering-correlation-id: 01139a3c-b541-4f18-cfee-08dd0ee35d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?U3ltVlprYTZEM0RtekJ1VU80SVhPaDBYOGI4enp3SldJblR5dUExUDQ3?=
 =?iso-2022-jp?B?c0dTZCthUEc5Mmc4ZGdEdEFieTN3VkFzSmtLUWkvRTZZZzk3UFlqbm4w?=
 =?iso-2022-jp?B?d0o5V0pGbUZGSzNENHUxY2REYXh0clBKTzl0WmtrcExvWVJUdzVLcXR4?=
 =?iso-2022-jp?B?YklQUklXaFd5SE5RUjFneml6c2NId0VyTkhWQUpiS3REUWgxYTRLRzFU?=
 =?iso-2022-jp?B?a2RyZW5kajdqSytoWGNEYlNmUjF0MC9lUUR6Y0FxSVNHc2YvT3hKT1Ur?=
 =?iso-2022-jp?B?eG1ydGF5M0Y1UWlscXVwUEx1SldONGRINHM4eGNIRU5wemFvbVR0VW9U?=
 =?iso-2022-jp?B?VWFGT2VVU3ZEaGczaDhQYWxKRGQ3anU3YVNESU11Q1p5ZHZTN0txU1Ez?=
 =?iso-2022-jp?B?RGRwSWtTRjZiMUlQREExeTJ4blZxNGpHRlpFeDFrQVNGZk1BbU01RjN0?=
 =?iso-2022-jp?B?UWFzTkpYWVRiQy9vSzE2Z1liV3o1MHhXLzdwWHo2ZDk0S1RiZXJXM1c5?=
 =?iso-2022-jp?B?VU1RTDM0Nm9VakJwci9WdUJWRWhDK1pFTHVkcXZMdVFrdmgyL1FSWlBQ?=
 =?iso-2022-jp?B?OUVxcGtDakN2WGNyVTBhR1dFNVAxTEkzN0RUNmxSa2dNWHRJVXE5REha?=
 =?iso-2022-jp?B?OU04NUxwZUxMSk9jV3VzYmZxSSs3KzAxM1c2Q2xKV1dUR1R1akVvb2NK?=
 =?iso-2022-jp?B?bFhhMFlqcTYzc0oxOW9CQ2Y1VTZ2d0JoUzlSSnk4c0t4VkN3S2duaTRJ?=
 =?iso-2022-jp?B?Z0txejk5cFdKTURRajM0S1ptVnYxQUZqR1hXYzA4dWdJTmNiODljcDZ3?=
 =?iso-2022-jp?B?bVR4cjg4TVRveTFtbmpFTXo5STEvT3NQWS9LcFd1dnV2eWtLRXRFcGM4?=
 =?iso-2022-jp?B?RGFremwyVmliSmtTUTlEVEVSeEVmQ29XbENwQVhmNitzZzlUSTNSZFNV?=
 =?iso-2022-jp?B?OFlHZWtqMWhMVnBkd1VDUmpqUFoxQ0tjcUxIMlVWY0diN0lyTzh4WlJ4?=
 =?iso-2022-jp?B?UHZ1NmlnVTVtNnZuUG85T3luNzNHNzBoVjlOUlVjQXArbXgxM20xVjVE?=
 =?iso-2022-jp?B?UUo0bTdRZTFSTWc4RmZTTTFBRFZYU3FVRWhDS0lReFFsQUpMVDcxVHgw?=
 =?iso-2022-jp?B?T1kybXBxRk9pa0VNN0taMmNpT3hrY1BaWWRBMW43QjREbWE2MitKSjM5?=
 =?iso-2022-jp?B?eTZ5ZXFqYkNpcitUcDJUaERjRytFQkRWTFl6bktENXd5OXhON3hQb2tG?=
 =?iso-2022-jp?B?Yllrem1YMVNMVG1Ja1dVcGh3WUpzQk5IdFNYWnN1aFBjS2tWNEUrcVpU?=
 =?iso-2022-jp?B?TnE4dXJwS25uRGNSSm56ZjcwckczazU3RmNFYXhnY2V2Tjl2eklXTTh6?=
 =?iso-2022-jp?B?MjJXL1REQUQ2blN2SkhwSUVMVGEvRjhOZVVJaXU5QmFsdUlJeG9lb3BG?=
 =?iso-2022-jp?B?cWpja1lNUUY4b2x5ZjlodDFObHdDRUxmbHUwTDlRbDZNQzZvdVdMTVV1?=
 =?iso-2022-jp?B?amoxdHVuZ1RaVC9vOHl2ZXBCejJtcE41eE5xcXNJdHhvMVdLd3VuY2oz?=
 =?iso-2022-jp?B?eFo0ZzZUVVk0VkdyTUpTdFFwQ2Y2WjluOWp0cllsZmEyRjcvVUhvYThG?=
 =?iso-2022-jp?B?cU03UWN3SzZBQzBXKzFIdGtreUIyTlFQVDJOMklhNTU3bW41NlludHdG?=
 =?iso-2022-jp?B?ZGpoMDdPL0RISUxOdmh2aUgyU0I4ejRPVVVORFMxOHYwQVlxSWxkLy9y?=
 =?iso-2022-jp?B?dVRKU0pZeEJhdVhZczJ1dVJNY1N1dytHNTU1akFZZzJyTHpSbjNuZXo3?=
 =?iso-2022-jp?B?NVdwandwVEpDWkF5ZzMvT0tEeFJSMkhHMTdPUWRmY1lSSG9QVURoN2Y4?=
 =?iso-2022-jp?B?QWFCQXZEWnZDb1FJNTlhMFVjSmlYcDk1WXUzU0s3aVlrcWRYWFRtRHgy?=
 =?iso-2022-jp?B?Rjl6amxZS1pLUTA2Nm5CM0NuSE1scGZiSXRuQTFERGpKYzd6R0xidnI0?=
 =?iso-2022-jp?B?az0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TXVCd0NUWUxLckgrU05ROUxMMHovMVV1eS91WTVIeUhRaU5vOVRNczcy?=
 =?iso-2022-jp?B?MXNzSzRkdkU1SDhPVFkydUVmMTlyVmJjZnZlNmh4akZ2dWxIS3FhemZt?=
 =?iso-2022-jp?B?aVQrcTExMWNmUTNxM0VkK2xWV1BGWi90Q09WdDVNR0tBQVB1emM1b1E2?=
 =?iso-2022-jp?B?QlpMY1MwZUJqZU1iNXpJR3JiT0xqZkl5YVVlMjlkOFp0TFBSTzd0cW9h?=
 =?iso-2022-jp?B?K0VSbHkwazVHQ203SmVXanVDSWlnTTAvNVFmT1lDNGY2c0Z5UTJPOTdq?=
 =?iso-2022-jp?B?UnY5c1NreXZhRlg0OWc4NjZ3T3djYmFMaFdKNjRqb3RYZ1NBSXo5VGNm?=
 =?iso-2022-jp?B?b1BDQVFuSnB3UWFIcWFTZzREbk1RaFVMZkthNy8yQVlvZXFMcnlScmlv?=
 =?iso-2022-jp?B?Smc2WWlHT3Z6MTJaUXhPMkdEa2tva3MxZVVrd1BvdTdQUnNKZys1UkVU?=
 =?iso-2022-jp?B?QVhILy9TSUV5SG1JY0VnSG1UaUVsQkRTOGZaOHZwOHRaa3NDSFNjQ2ht?=
 =?iso-2022-jp?B?WkNXZ1BNVlFpc09jYStmVTVnSERlK3R4RHRRYkRyV3FqclBPNUlSNXZ1?=
 =?iso-2022-jp?B?dC8zeUtVMmNJbjV0Ymx0NFdwNmxZRUNtUVdQQm5GSktLcWlUS0cvWnlT?=
 =?iso-2022-jp?B?YjdKQ01aNUVUZzZmbTUyd0J3TlpXUjdKTzZQeTNqUGhCb3Vjekx2Z3Iy?=
 =?iso-2022-jp?B?aTdlZCtNMFk2akpYdG1ycktMS2RqNDdCNUVaWVp5VDA4NVhSNFpKOWp3?=
 =?iso-2022-jp?B?Vnh4cGFTV0tjcFBMOXlsQTl4SVFjcXhmSmlvRVM2VVNiTHNRNzZEK1NH?=
 =?iso-2022-jp?B?MnJTb0l5TmhUdVhFZGMwWnlsVWF4NFU5cUFYYzFFVSsrSWMrS0RKdGhQ?=
 =?iso-2022-jp?B?SWxZYlZMSDUxdEUvTnU5a2VNc2ZObndtVndUVnNiR1NBd0hpeFJaZjRF?=
 =?iso-2022-jp?B?Z01hK3lVbzVxMlFjNklkUjFpaHdQcjZXSmlzRGk4NTFhWGwwU3RaczZQ?=
 =?iso-2022-jp?B?U0lESHFmc1ZXWDBTT0txVytzdm4vWTg3UnlOa3RyY2RwRDNyTTdicTMz?=
 =?iso-2022-jp?B?Vi9tSjd3amxNOUUvVzlWNjNXWm9CVHZYcEZERnhsbS9JaVU5enNPd29C?=
 =?iso-2022-jp?B?Z24zMjgvR2lsMEhHZmZCTEkxNkRDUWlxTzVaWVhkdzg2K3B3YmFhSXJW?=
 =?iso-2022-jp?B?bmFWcVUvbUlqQ0o1cUZWZTBKY0wzSDd1c3JMOW1DVEdyd09SVTRkQ003?=
 =?iso-2022-jp?B?VEo3azNVNEVEd0ZUVXZRNmpSWXlNZ0x0a1BaaVI1V1U3R2Q2OVdMTjNm?=
 =?iso-2022-jp?B?S09LcEdwdERuWFZqY0M2VUZxVm5CQ0tyUXRBaGhLUFNlUFdSYjJQdThP?=
 =?iso-2022-jp?B?REI5TjkxNzY2T2lkYU8yd1F5aGo1b2xTY25DaHFkV1ZKOXg5TG5hK0Y4?=
 =?iso-2022-jp?B?RmlWVmdvRDMrbWYzK2ZpZVByaXEvMzlsUjh2aXEwRDRGTEI5bFd4emow?=
 =?iso-2022-jp?B?MjFrRkJKMFNYYU5jcERibGxobi9pVnlJZ3NESVpmTFJ1MXJvK2ZTZ2d1?=
 =?iso-2022-jp?B?Q21YNzE2WFJMQ1ZhdWZ5Rk5VUFJvVmg3N0p4ZklBN3RONGxkL3VtUGFz?=
 =?iso-2022-jp?B?NEM2OWJRb1Y2UWpoQ2FwbDY0eWh3K1FHSWV4bkt2b3dVRFd2RDlYR0JZ?=
 =?iso-2022-jp?B?aDJ0ZTQ3aDg0ODc2NXFxL3dGRmxFRkF2RXBZcFdUSldWUFJlMnZzcFdV?=
 =?iso-2022-jp?B?NjlXbFJJV3ZjdzNZWkxkZVN4MWovSk41WHlBWi8vOThvWFNtOU96dEZB?=
 =?iso-2022-jp?B?Q0VRU1VqTG5HYUttSG1oaGNIUVdJaExSNjQrWUxoZWFSYmFoTk9raVRW?=
 =?iso-2022-jp?B?cmNTVnZITk8zQ1djZzZ5SFNKcXdCbWY2ZFU2RWVtWlNpWXVkR0NvSGox?=
 =?iso-2022-jp?B?YlBwOUhCc1JhRWs0VlFiUFpuUkE5MHBCa1ZLOVFSN0hkYVpqNjFhZHpv?=
 =?iso-2022-jp?B?cVNKc0xkczkxblhTTWhERFN6RmMvRFBHaUt5Mm5keTJjbFI3VWRjVzUx?=
 =?iso-2022-jp?B?NUFZZVhvN2RZaXk2Wk9mSE13V0lmMmxGRUhIdHdXL2NvVFFLV0VSQklm?=
 =?iso-2022-jp?B?d2RiQ1VUU21kRmE5RkZYRy9UMWs2RUdnc09YQUhPUEsvVHpKMTVlR2FL?=
 =?iso-2022-jp?B?S1FteUsvcWk1V08zYWg4MGJLWW9DbVdCUFl3MUhncHI4cGpybG14RTV0?=
 =?iso-2022-jp?B?b01jVURha0RyQS84blBsRXF2bXBFQXdGUFlCSDcyL2pkdkY3NERCZHZ6?=
 =?iso-2022-jp?B?VDR1ZkZHV09OTFZNSVhSUFp5WjgwaTJSQmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01139a3c-b541-4f18-cfee-08dd0ee35d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 12:59:44.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msCX3nFZuaLUJMR8LMf+Eo/t+eYcgPfdDsESDC2biqSGdNlm8sK6ZCgIdgOMGZGySqusqydSGGkQkM2xwiLUzAbqAfhDIWGZXjnhv7BLl7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 12:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17292

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 27 November 2024 12:59
>=20
> Hello Sai,
>=20
> > From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> > Sent: 27 November 2024 11:08
> >
> > Hello Chris,
> >
> > We are planning to run software update, secure boot verification and IE=
C
> > layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believ=
e
> > there are two main challenges.
> >
> > Booting a disk image (.wic) on M-COM x86 in LAVA
> >
> > We went through the existing job definitions running on CIP reference
> > hardware on LAVA to re-use if any disk image is being booted on them bu=
t
> > did not find any. In every job definition, the root file system tarball
> > and kernel image are deployed separately to tftp. We are going through
> > LAVA documentation to figure out proper method to boot   entire disk
> > images on LAVA.
> >
> > Can you please provide your suggestions on how to do this, if you have
> any
> > ?
>=20
> Where do you plan to flash the wic image?
> What does it include? (bootloader/kernel/rfs etc.)
>=20
> If you are flashing the wic image into some sort of permanent storage I
> guess you could boot into a "normal" system using tftp/nfs etc., flash th=
e
> wic image into some sort of permanent storage and then boot again using
> the newly flashed storage?
>=20
> Maybe the USB or SATA deploy methods could be utilised?
> http://10.226.36.177:55555/static/docs/v2/actions-deploy.html
Sorry, wrong link.
Try https://lava.ciplatform.org/static/docs/v2/actions-deploy.html

Kind regards, Chris

>=20
> Perhaps this use case could be of interest to others and new deploy/boot
> methods could be integrated into LAVA.
>=20
> If an SD card can be used as the boot medium, another option is to use a
> tool like SDMux. This allows flashing to the SD card whilst it's connecte=
d
> to the LAVA worker, and then switch the SD card to be connected to the
> MCOM. I think there are also USB versions available.
>=20
> > Once we are able to boot a disk image, then next task is to boot a
> > security image.
> >
> > Configuration of BIOS settings on the device's firmware to boot a
> security
> > image
> >
> >
> > Basically, CIP security image has secure boot feature enabled, so befor=
e
> > booting such image there are some settings that need to be done in BIOS
> > such as:
> >
> >
> > 1.
> > 	Enabling secure boot option
> > 2.
> > 	Adding secure boot keys in EFI storage.
> >
> > Only after these steps, a security image can be booted on M-COM x86
> > hardware. I am mentioning these steps based on our current experience
> with
> > local setup. But I am not sure how to achieve this on LAVA.
> >
> > One idea is to pre-configure the above-mentioned settings in the device
> > present in lab-cip-siemens-prag but in that case I believe health-check=
s
> > and all other tests running on M-COM x86 can boot only secure images.
>=20
> This is one option.
> We could duplicate the amount of hardware so that we have some permanentl=
y
> configured in secure boot mode, and some in "normal" boot mode.
>=20
> >
> > Is there a way to change the bios settings through some arguments in th=
e
> > LAVA job definition ? If not, then can you please provide your opinion
> on
> > the above-mentioned approach.
>=20
> To be honest my history is almost 100% with Arm devices, so BIOS isn't my
> strong suit.
> If there is a way to remotely configure the BIOS over seral then it
> _should_ be possible for LAVA to do this configuration. It may just need
> some customisation work done.
>=20
> Perhaps see if anyone on the lava-users mailing list has any suggestions
> for either topic?
>=20
> Kind regards, Chris
>=20
> >
> > Thanks and regards,
> > Sai Ashrith (T S I P)
> >
> >


