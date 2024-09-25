Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D68CF9C7B
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 14:49:18 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.46])
 by mx.groups.io with SMTP id smtpd.web11.18081.1727275749779928716
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 07:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pZ7QvIQG;
 spf=pass (domain: renesas.com, ip: 52.101.228.46, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM5Eo3+MtuMK1IzJK9CZob3Uo857KfKwvIeM1liWERbTXjYb8VUMXMLTC2tJYazpfvxTW24A1KijdDLjXty8jiRt8aCcGIVBEUOgnZS7QAyqOTbTtbb13kIyBEtDr4rayEym/le87MWQ5fzfuiWDtXreAeP8NFkDdN9WOp7y5yyI0ZSGq5h7ZhZ3PeLJtRd2W4SinFyzZ92O3ktkz1ksdTwjhlCg3RsAcVhaZ3hSfJ71Z7EtF8+dup/BxDd5LQKutkYkXEEgWuuw066yHDsPkvepc/JnjkInzxgg6ATpNhI8TUfceJxC0vBZ8OgAG1sKr45/xm1rbyuaoVDF2cPo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gUqK/3J9BMQUmE9qYMCX/DjVQbVI7l1HYNm/3jTlwY=;
 b=cZnwG+sIG48kY6DoGHDgkhbcGFNpsXeP3bVdzlKzG5ViDKbyPJynM1gck/69l2gMvd100Ac3jLrkl0uNEe3zlq9cSScy/NMw7rpyg9Q/NnDykJVSZwZzI57ZQigARZAlvdKpqo++Ry+Vm/1JpIikgGv4MfhfOphtjTJa5PrpuztfmmXxCzjGvTLyOz8Mk3KXhgbWEDeOOcqOLGgXBrTioaXiASle43auSMvji8nexTrTr9G8BiyOIHMtI5i0o20JKQvkKP57VztxFIfq2AboONZl8pOCf80wiRFkTkvKrFLKcGHXP7+B7KP2EizCkbauRrIKjW7NXntm+0SX37IZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gUqK/3J9BMQUmE9qYMCX/DjVQbVI7l1HYNm/3jTlwY=;
 b=pZ7QvIQGvb6T29r+hL6JkgPT9N9I/MQHjZOaCjLHqUDxW4ehc2rgqsoKZJolOMgDyT0xUWzNzSB1VK5SDYjHVsjDGYbWogwhCfLJSRAJbwloz578SFz9/Oqpjd2Lsah3sOPwUqCWH378UzGktwb0iGC8OSqDgToVo2SJcYKJl7s=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYWPR01MB9836.jpnprd01.prod.outlook.com
 (2603:1096:400:224::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 14:49:05 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 14:49:04 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"michael.adler@siemens.com" <michael.adler@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: 
 Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQBBtW1XAAAKEVoQAAz0WwAAivPPcAALuQ4A==
Date: Wed, 25 Sep 2024 14:49:04 +0000
Message-ID: 
 <OS9PR01MB12389D1E353CAFF3A6A5640B8B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <OS3PR01MB61038FEE197308A2E5B51F56C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61038FEE197308A2E5B51F56C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYWPR01MB9836:EE_
x-ms-office365-filtering-correlation-id: 9d901539-76e4-460f-8beb-08dcdd71339f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RGtYUWI4TzM5V1F6cnZzVklvb05oMVJpL1JIenRZODI1dFNtaEpCY25E?=
 =?iso-2022-jp?B?VXVpTTBTeGZJU2cxRGEwdzQyRkU0R1AraG9ZYXNlWXV2VVQzQlRHa1o5?=
 =?iso-2022-jp?B?cFNDd2VQZzVUQmRLbXJSVnlBc3RWKzVOZWlSNUp1SDdqRzdwODZlSFQ2?=
 =?iso-2022-jp?B?QnhiaDQ3dlVmUnJYbmhOTi9UK0Y0M1RMWUFscXMrN1pWZVJnS1dLNGxo?=
 =?iso-2022-jp?B?MXpuZkJYRmFrRG82eE1KdVZLK3RCMDFXeXZZTUEyMzc2akQzQ29URHg4?=
 =?iso-2022-jp?B?bUVBaXlSUUFJSDFJb0t2Mjk3bC9NbjJFQVU4VUF5U1A2WW1zaDZoekJZ?=
 =?iso-2022-jp?B?L09mRHcrZ3B3Sm5GTzZHa2V2YytaaThHNDZZc1pKWVRIcWVUSWluQkxI?=
 =?iso-2022-jp?B?TnVtOW1nVklHQ1dmT0xBTE5XQjVjYk5BR1BFNUIrYnlwa3I1UFQrVVZI?=
 =?iso-2022-jp?B?V1VsNEhxM0t0TlBSV2hkb3Y5akFyY1VvaTlwRUFtN0tjS1lkc3d0aExw?=
 =?iso-2022-jp?B?Z05acklaWFptLzZYQ090Nk9lS0gwTzVoSDBZV1BGV2k0RWVmRm4vR2ds?=
 =?iso-2022-jp?B?a1ZZcU9qR0d3a0NYSUdTNTFhcmE1bmFQVzkwUlFTQk5oZVZwTUN5dHcv?=
 =?iso-2022-jp?B?SFhsMDcxSUhZT0pMNVlqVk5oSElSSXJMei9iSWhZN1hkU0ZnMVJ6VVVG?=
 =?iso-2022-jp?B?SGxBdjVNNW1xQ0k1Sll6dmg1TWNlbjdkZUo3MmxPUGxpbWF4U3pLeUVs?=
 =?iso-2022-jp?B?YzhaSXhMcDhpaVdWdUJYbjFFRFpJZ2VISkM4a01BQ1NBbDcxeXFZSVRh?=
 =?iso-2022-jp?B?NllFbDcweEZFcCtaV3RZRW1YbkVPUkRJdFZ4NWdxRnBWS1YrWXpNanJI?=
 =?iso-2022-jp?B?U0Rvem5BNEkyN3NBV0FQSG16c3hYUFpaSTdvRDhXQlZnS0cweCs3anVG?=
 =?iso-2022-jp?B?R0tGNnIwUVdtU21VT2g5TWdjSmpIYjVrLzVIamZGanRnTFZocWhhUS95?=
 =?iso-2022-jp?B?WHpFSDZ5RDZzMVRRQ1Y2RVBza2NZREoxbDRINE9zMlBjOHZMeVZkMkdY?=
 =?iso-2022-jp?B?bGRwc3hhdVpETUNWNnEyeGJwT0JiSEw3TVUzN2JMUHd1RWgvT2xPUnYz?=
 =?iso-2022-jp?B?Zlo3NHpBeDdSOHkwV2ZXV0N4T0FDSk5INGsvK1lmaGh6WDJDL3d3MG55?=
 =?iso-2022-jp?B?UHQ1U3AxREdHMDRwRldhcDUwQUszaUsxcDRha3RTek1XV0NEa21CbEJl?=
 =?iso-2022-jp?B?UUlmaUNOOEVMNlJtODNoRHRsRCtaK2VDWFROUnd0enRacm1KcFBvblF1?=
 =?iso-2022-jp?B?YnNINXVGZ2lKVmVWeE9GTkVobTl3Vm1qVE12anlCVHZyOUpJU3FtVktx?=
 =?iso-2022-jp?B?S0Q4alBuNktBazNieHlRUDNrSW5jbFlwT0NKNWJRRjFwUFhyd3FwMHdE?=
 =?iso-2022-jp?B?bjg3aEg3MkFUVy9xbUpGU1poT1NmZ3VIWTB0ZkYxQkJ1czg4ZUF1aWF5?=
 =?iso-2022-jp?B?RUVpdWNvVzNGNVJ5T2drREEvQ3hIWDRxZld2NkFvcjZKRVFMWGJKcEdx?=
 =?iso-2022-jp?B?c21MK2pxcXltWitweVphOXU4SWFBUXpjRkptYmxIZHJRaFBWRGNqcHlR?=
 =?iso-2022-jp?B?ckpOWnRhWDhwMk53LzFxeE5SUmZad0dBME5wRWFxOVpBblZkV2xOMDRG?=
 =?iso-2022-jp?B?NzdDZ3VjaW9WTS9ITE5Qa1JsV1ozejBnRDhBdmt3N3U5QU9ycjlKVjJ0?=
 =?iso-2022-jp?B?clZCQjMySVB3blF5cU1VVjF3alNzL2d2amxXYWhUQWNFeUdGQUVqZ1VQ?=
 =?iso-2022-jp?B?UjdYeHlJWUNOTUtuWE53RlZaRVBHaWx2SjdlVnVyRllvbHdZeTcrM0Fp?=
 =?iso-2022-jp?B?bUQ0WllQekllUEtSdy9SYjkyNVRUZG1sc1grcVZWQ1UyTVRvMnUwZDkr?=
 =?iso-2022-jp?B?ZnJLU1pNN2JsZHp3OW1RRDJUN2FFYUFMYkZOK0Jza3psUnRGRWxGSXIz?=
 =?iso-2022-jp?B?cz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d1d1dXFDM0JqNXBXTUc4YmJRTmRHazg2VThFd1lWdGhXSFBoN0dBR0dV?=
 =?iso-2022-jp?B?czNFZ2NSV3Q3RFdhYzJhanVFNitNUDNwRHR5SFBmMitPY0h6ZEdvRC92?=
 =?iso-2022-jp?B?My9MVVcwS2tITnRIM24xZEVYdmJ1SGlUV2hBQ1lrWjZ1N1VYM2tSVlZi?=
 =?iso-2022-jp?B?MEJWRVpjM1JqR293eTMxVStCMk1DcmR0Ry8xWXNlcGFEOUJpdlBma2pC?=
 =?iso-2022-jp?B?VG1rd1lac0JOeERPTmVQUHV2L0JtNjRnOUxrNkhDajFrTytqMjkvYTBu?=
 =?iso-2022-jp?B?Rk9DekYvNXdxMk0zMGgzNFJJN3lCTDN0UEhaL2dpdEpRcjZXRythWlFQ?=
 =?iso-2022-jp?B?REo1OWp1ZC91MVBmWVpaQ2pUKzRMM0k2aFJma0F5RzRoZ2hWc1hSN090?=
 =?iso-2022-jp?B?NS9UWlorOTNSTnEzZENtZjRUYnhEaVg0SjZCT3hkTnM1L0orOHFXVjR3?=
 =?iso-2022-jp?B?SU8rYWd4N2VISTJaN2YzRDNMU0ppYjBFRWVaN2hDVFZtQTc0ZjlpMFRZ?=
 =?iso-2022-jp?B?TzFOZzg3b0w2bS9WMW53NjduWHF1aE01NU0vSmUycHoxcWtxNFBlYTdh?=
 =?iso-2022-jp?B?WFduYzFQbU92aGtmSHI4RFFUUnFJZjlGdUwrNHlNNlp2Q2htcVdsdmpC?=
 =?iso-2022-jp?B?eWN2NDFyVWtRRUU2aFdVN0FvZysyZnFsNVAvZjk2YklYOHlLTEZMWHlR?=
 =?iso-2022-jp?B?RWNqSFlSL2hBeEVQRWlnemRvcFdJcjNsRGVRVjM1eWxwVFNnMzZVNTZj?=
 =?iso-2022-jp?B?T0V3YmJYUWk2aUpkVy9Xc0hjNEl3OUthc3diY3FWUjhiT09UdE1zeHV5?=
 =?iso-2022-jp?B?S3VRRUpUVCtmS0s4T1ZhWDRVSWtxenJvRnVVczU1ek45S3RQL2c3Yis3?=
 =?iso-2022-jp?B?UVczOFhmVDdDVVRaSjVSMjRxcHJqNFhucXgxZ1BpU09ocVdqcC9kK3pD?=
 =?iso-2022-jp?B?QmsxMklNL1Z4T3lVWlJta1E1allydmR6djhYNkltTnkvM2w1cHNoR21G?=
 =?iso-2022-jp?B?alZIR2dCeHdnN3ZDQ1NYdWJWSk80V0I4RXc5Zy9nK29taWxCQ3ZsSGhL?=
 =?iso-2022-jp?B?TmNYR3h2b1dzb2pJT0gwNXhKZmdqeVJXK1J5c3B4MGRwTWFTNXZYeXFP?=
 =?iso-2022-jp?B?K1dsbTN6ZWVTQndCRU1RS2JIV2xraFFnUGFxMlpmVWorY2l6M212U2R4?=
 =?iso-2022-jp?B?TVhNcG1BRy92VWcvbzJYL3FjM3k1MG9rdi9YM2J6akh0YkVYZDFsTWdV?=
 =?iso-2022-jp?B?NW9odW40Wm55Wk5MNFQ5L0txU2ZjQ0dUZ0t0VUo0R2dZekFmQWlZMENw?=
 =?iso-2022-jp?B?K1ZyeWFiNU5KZ3d0SHdLbUh1ZTVmTUI2OE4ydVVZSFhUaFlYWFlBVWJV?=
 =?iso-2022-jp?B?NUFERFVEM3BoODIxWWk2MFBWemZCc1RheFVMbzFHOFlTeHZsNHNsaGRJ?=
 =?iso-2022-jp?B?a0wzVFdIcmsrY0ZkMzZwb3YxVzJFNHVNMzFESERDTUw4Tnl1NyswU0FJ?=
 =?iso-2022-jp?B?VUVkZzlueDUrMWg0SzhTWGNBWENucC9jZDNNaSsyUFRlbWpaK2hLUkVS?=
 =?iso-2022-jp?B?ZWZZVGMvdHpReXYrWUZWVFhwMlpKamxLSjJmcnk4bTROR3JvdG1sQm84?=
 =?iso-2022-jp?B?RzVvREJ6c0M5YWkvVW01Z0tOUkwwYk9KdjBoYkFDY2swRFptcForeFVO?=
 =?iso-2022-jp?B?akFybS9jK0dXUE9GMWtpWnoremJCdTdkb0xXVkF6ZXFsUzYvSFl4WWhB?=
 =?iso-2022-jp?B?UE1wRjVtRXJLbEwwdnNMTzMzeENMZytPbmtTcXljd20vOWFJNStieGVN?=
 =?iso-2022-jp?B?WUhqNms3aXlOVlpTeWxSWXl4c3MvWGFkZFNkRTY1eEtseDl3ck96aytW?=
 =?iso-2022-jp?B?c0RyWnprUG50TFNWKzExWEp6cUhjNWRtZm13bUhxNytqQUN2S2Q1Vm1G?=
 =?iso-2022-jp?B?Z0diVjlOcUZrS2FDbE9xKzZOT3EvR2k4TGxkd2tCemhmc1pNdy9KLzRn?=
 =?iso-2022-jp?B?NUs1QW93ZENramFsTzNTblFNd1YrN0xQQk1DMWgyMW5iY05QSXNGQWtY?=
 =?iso-2022-jp?B?OUt2K2pmOHZuZlJaK1BtK3VNTjBHVkNiWlVqTHdrTUdISWFSZFh4YXBy?=
 =?iso-2022-jp?B?WWFtSldFTXYwQUJxdWJzcTFXaTNQSHVOVktWbUg1RzRoUE53N1FhejZO?=
 =?iso-2022-jp?B?eU1SVVc0S2lGaVJZeW5UUm1SbXpUY1dNZEJVYlI4dXpZWWZSb1JvVk1I?=
 =?iso-2022-jp?B?VWNhOElYLzlDaHMyUk13MXhFUTFRRjlNVWZFNTV2NnJ3MGJPNWt5SzNN?=
 =?iso-2022-jp?B?MERsZ0hnVCthcmJicWQxVFlBRXA1d1FjUmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS9PR01MB12389D1E353CAFF3A6A5640B8B7692OS9PR01MB12389jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d901539-76e4-460f-8beb-08dcdd71339f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 14:49:04.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuwT0/L8ZXsj0zu5ZvB9bY/S2QOWT+W6CekKDRDC+S5GhOywmt2956VRcGIJuSQ1w5Faq2TPI+bYCcsCiMRS9qZCHbHlf9OrOL9DDliiPQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 14:49:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16920

--_000_OS9PR01MB12389D1E353CAFF3A6A5640B8B7692OS9PR01MB12389jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Sai,

Our =1B$B!H=1B(Bsmall=1B$B!I=1B(B GitLab runners use AWS t3.small EC2 insta=
nces, which only have 2 vCPUs.
And each of these runners can end up running multiple GitLab CI jobs.
Clearly, it=1B$B!G=1B(Bs not enough performance for the cve checks so I=1B$=
B!G=1B(Bve submitted a patch to switch these jobs over to the =1B$B!H=1B(Bl=
arge=1B$B!I=1B(B runners.
From my testing that seems to work as expected.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Wednesday, September 25, 2024 3:39 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>; michael.adler@siemens.com
Cc: kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; cip-dev=
@lists.cip-project.org
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners

Hello Chris,

I apologize for an incomplete reply to your question.

I went through your debug pipelines in isar-cip-core. I observed hihope-rzg=
2m-buster.dpkg_status taking around 9 minutes to generate a cve report  in =
CI while bullseye and bookworm targets' cve reports are generated in around=
 1-2 minutes. Based on my understanding it is taking a lot of time to gener=
ate cve-reports from buster targets in CI.

Answering your question, I locally executed cve report generator script in =
my Debian machine (8 cores, Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz) inside=
 a Docker container.

I have no name!@c3cf62622aab:/work$ date
Wed Sep 25 14:22:23 UTC 2024
I have no name!@c3cf62622aab:/work$ ./cve_checker.py --suite buster --statu=
s cip-core-image-cip-core-buster-hihope-rzg2m.dpkg_status
I have no name!@c3cf62622aab:/work$ date
Wed Sep 25 14:23:48 UTC 2024

The duration is approximately around 90 seconds.

Regards,
Sai Ashrith Sathujoda
________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, September 25, 2024 5:13 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>; michael.adler@siemens.com<mailto:michael.=
adler@siemens.com> <michael.adler@siemens.com<mailto:michael.adler@siemens.=
com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; c=
ip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <cip-dev=
@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners


Hello Sai,



Do you know how long the cve checks normally take?

I=1B$B!G=1B(Bve set up my own branch for some debugging and the =1B$B!H=1B(=
BChecking hihope-rzg2m-buster.dpkg_status=1B$B!I=1B(B line seems to take an=
 extremely long time.

Either that or it=1B$B!G=1B(Bs done, and now it=1B$B!G=1B(Bs doing the aws =
s3 sync that=1B$B!G=1B(Bs done afterwards, and this is the step that is tak=
ing forever.



Indeed, looking at your job linked below, it took 49 minutes to the point w=
here it failed.



How long does it take to run the cve-check script locally?

Outside of the specific issue you=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs =
very CPU intensive then perhaps we=1B$B!G=1B(Bre better to use the =1B$B!H=
=1B(Blarge=1B$B!I=1B(B runners?



Kind regards, Chris



From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Wednesday, September 25, 2024 10:57 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; michael.adler@siemens.com<mailto:michael.adler@siemens.com>
Cc: kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>=
; dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; cip-=
dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners



Hello Chris,



This issue is still present in small runners. I ran the cve-checks job toda=
y. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#=
L655



It still shows 'Job failed (system failure): pods "runner-zwslwy9eu-project=
-10191315-concurrent-0-ulyylb1h" not found'.



Thanks and regards,

Sai Ashrith Sathujoda

________________________________

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, September 25, 2024 3:06 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>; michael.adler@siemens.com<mailto:michael.=
adler@siemens.com> <michael.adler@siemens.com<mailto:michael.adler@siemens.=
com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners



Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.co=
m> <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
> Sent: Wednesday, September 4, 2024 12:53 PM
>
> Hello Michael,
>
> I ran this job multiple times recently. I am seeing 'pods runner-
> zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' again
> while using small runner. https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/7740352129

Are you still seeing these issues?

Kind regards, Chris

>
> When I run with large runners, the job is successful ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984 .
> That is why I suspected there might be an issue with small runners. Can
> you please provide your opinion on this ?
>
> Regards,
> Sai Ashrith Sathujoda (T S I P)
>
> -----Original Message-----
> From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>=
 <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> On
> Behalf Of Michael Adler via lists.cip-project.org
> Sent: Monday, September 2, 2024 2:28 PM
> To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> Cc: Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@renesas.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mail=
to:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m<mailto:dinesh.kumar@toshiba-tsip.com>>
> Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
>
> Hi Sai,
>
> > I thought there might be some issue with the runners as the job failure
> message said, =1B$B!H=1B(BThere has been a runner system failure, please =
try again.=1B$B!I=1B(B
>
> maybe there was a temporary issue. I just looked at the cluster and it
> seems to be (idling) fine. So I'd suggest to try it again.
>
> Kind Regards,
>   Michael
>
> --
> Michael Adler
>
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas=
,
> Judith Wiese; Registered offices: Berlin and Munich, Germany; Commercial
> registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

--_000_OS9PR01MB12389D1E353CAFF3A6A5640B8B7692OS9PR01MB12389jp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Our =1B$B!=
H=1B(Bsmall=1B$B!I=1B(B GitLab runners use AWS t3.small EC2 instances, whic=
h only have 2 vCPUs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">And each o=
f these runners can end up running multiple GitLab CI jobs.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Clearly, i=
t=1B$B!G=1B(Bs not enough performance for the cve checks so I=1B$B!G=1B(Bve=
 submitted a patch to switch these jobs over to the =1B$B!H=1B(Blarge=1B$B!=
I=1B(B runners.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">From my te=
sting that seems to work as expected.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-GB">Kind regards=
, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:39 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; michael.adle=
r@siemens.com<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners<o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I apologize for an incomplete reply to your question.<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I went through your debug pipelines in isar-cip-core. I ob=
served
<b>hihope-rzg2m-buster.dpkg_status </b>taking around 9 minutes to generate =
a cve report&nbsp; in CI while bullseye and bookworm targets' cve reports a=
re generated in around 1-2&nbsp;minutes. Based on my understanding it is ta=
king a lot of time to generate cve-reports
 from buster targets in CI.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Answering your question, I locally executed cve report gen=
erator script in my Debian machine (8 cores, Intel(R) Core(TM) i7-9700 CPU =
@ 3.00GHz)&nbsp;inside a Docker container.&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I have no name!@c3cf62622aab:/work$ date<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Aptos&quot;,sans=
-serif;color:black">Wed Sep 25 14:22:23 UTC 2024</span></b><span style=3D"f=
ont-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I have no name!@c3cf62622aab:/work$ ./cve_checker.py --sui=
te buster --status cip-core-image-cip-core-buster-hihope-rzg2m.dpkg_status<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I have no name!@c3cf62622aab:/work$ date<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Aptos&quot;,sans=
-serif;color:black">Wed Sep 25 14:23:48 UTC 2024</span></b><span style=3D"f=
ont-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">The duration is approximately around 90 seconds.<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Sai Ashrith Sathujoda<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chris =
Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2=
@renesas.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 5:13 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt;c=
olor:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black">) &lt;<a href=3D"mailto:S=
ai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a> =
&lt;<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com<=
/a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt;color:black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#D#M#E=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"fon=
t-size:11.0pt;color:black">=1B$B#D#I#G=1B(B</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=1B$B""=1B(B=
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#M#P#S=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font=
-size:11.0pt;color:black">=1B$B#M#P#4=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt;color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</span> <o:p=
></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Hello Sai,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Do you know how long the cve checks =
normally take?</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">I=1B$B!G=1B(Bve set up my own branch=
 for some debugging and the =1B$B!H=1B(BChecking hihope-rzg2m-buster.dpkg_s=
tatus=1B$B!I=1B(B line seems to take an extremely long time.</span><o:p></o=
:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Either that or it=1B$B!G=1B(Bs done,=
 and now it=1B$B!G=1B(Bs doing the aws s3 sync that=1B$B!G=1B(Bs done after=
wards, and this is the step that is taking forever.</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Indeed, looking at your job linked b=
elow, it took 49 minutes to the point where it failed.</span><o:p></o:p></p=
>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">How long does it take to run the cve=
-check script locally?</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">Outside of the specific issue you=1B=
$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs very CPU intensive then perhaps we=
=1B$B!G=1B(Bre better to use the =1B$B!H=1B(Blarge=1B$B!I=1B(B runners?</sp=
an><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
ptos&quot;,sans-serif;color:#7030A0">Kind regards, Chris</span><o:p></o:p><=
/p>
</div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#7030A0">&nbsp;</span><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"xmsonormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN=
-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, September 25, 2024 10:57 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a><=
br>
<b>Cc:</b> <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hay=
ashi@toshiba.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners</span><o:p>=
</o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Hello Chris,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">This issue is still present in small runners. I ran the c=
ve-checks job today.
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/788=
5795173#L655">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#L65=
5</a></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">It still shows '<b>Job failed (system failure): pods &quo=
t;runner-zwslwy9eu-project-10191315-concurrent-0-ulyylb1h&quot; not found'.=
</b></span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Thanks and regards,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-s=
erif;color:black">Sai Ashrith Sathujoda</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chris=
 Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson=
2@renesas.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:06 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt;c=
olor:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black">) &lt;<a href=3D"mailto:S=
ai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a> =
&lt;<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com<=
/a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt;color:black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#D#M#E=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"fon=
t-size:11.0pt;color:black">=1B$B#D#I#G=1B(B</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=1B$B""=1B(B=
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#M#P#S=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font=
-size:11.0pt;color:black">=1B$B#M#P#4=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt;color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</span> <o:p=
></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@=
toshiba-tsip.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">=
Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
&gt; Sent: Wednesday, September 4, 2024 12:53 PM<br>
&gt; <br>
&gt; Hello Michael,<br>
&gt; <br>
&gt; I ran this job multiple times recently. I am seeing 'pods runner-<br>
&gt; zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' agai=
n<br>
&gt; while using small runner. <a href=3D"https://gitlab.com/cip-project/ci=
p-core/isar-">
https://gitlab.com/cip-project/cip-core/isar-</a><br>
&gt; cip-core/-/jobs/7740352129<br>
<br>
Are you still seeing these issues?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; When I run with large runners, the job is successful -&gt;<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/job=
s/7742283984">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984</a>=
 .<br>
&gt; That is why I suspected there might be an issue with small runners. Ca=
n<br>
&gt; you please provide your opinion on this ?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith Sathujoda (T S I P)<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt; On<br>
&gt; Behalf Of Michael Adler via lists.cip-project.org<br>
&gt; Sent: Monday, September 2, 2024 2:28 PM<br>
&gt; To: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip=
-project.org</a><br>
&gt; Cc: <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@ren=
esas.com</a>; hayashi kazuhiro(<span lang=3D"JA">=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B</span><br>
&gt; <span lang=3D"JA">=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B</span>) &lt;<a hr=
ef=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshiba.co.=
jp</a>&gt;; dinesh<br>
&gt; kumar(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span> TMIEC ODG Porting) &=
lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-ts=
ip.com</a>&gt;<br>
&gt; Subject: Re: [cip-dev] Issue with 'small' Gitlab runners<br>
&gt; <br>
&gt; Hi Sai,<br>
&gt; <br>
&gt; &gt; I thought there might be some issue with the runners as the job f=
ailure<br>
&gt; message said, <span lang=3D"JA">=1B$B!H=1B(B</span>There has been a ru=
nner system failure, please try again.<span lang=3D"JA">=1B$B!I=1B(B</span>=
<br>
&gt; <br>
&gt; maybe there was a temporary issue. I just looked at the cluster and it=
<br>
&gt; seems to be (idling) fine. So I'd suggest to try it again.<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt;&nbsp;&nbsp; Michael<br>
&gt; <br>
&gt; --<br>
&gt; Michael Adler<br>
&gt; <br>
&gt; Siemens AG<br>
&gt; Technology<br>
&gt; Connectivity &amp; Edge<br>
&gt; Open Source Embedded Systems<br>
&gt; T CED OES-DE<br>
&gt; Friedrich-Ludwig-Bauer-Str. 3<br>
&gt; 85748 Garching, Germany<br>
&gt; <br>
&gt; Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim<br>
&gt; Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and<=
br>
&gt; Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Tho=
mas,<br>
&gt; Judith Wiese; Registered offices: Berlin and Munich, Germany; Commerci=
al<br>
&gt; registries:<br>
&gt; Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE<b=
r>
&gt; 23691322</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS9PR01MB12389D1E353CAFF3A6A5640B8B7692OS9PR01MB12389jp_--

