Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C2D58D61
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 15:47:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.11])
 by mx.groups.io with SMTP id smtpd.web10.21606.1732549668494418225
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Nov 2024 07:47:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZgHYOyl5;
 spf=pass (domain: renesas.com, ip: 40.107.74.11, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nnzk1QhXLN+cR7PcrblB5533vJi8cWJX36JFUHy0ARPjzNAgl69NMqYsNgPiTI2RuB7TthJWgi5o2MUlf/+hln7/ZVk1OKRZKiG4PLgKnWfggDv6CKFi/IRL4+z7dQO4IaMtr9dXLHixENFhEH4cjaXZ+r4xLlI7Er0KRc/5HhnUshxb8/R86pi/Jp9APw0P+NbArjMqoq/XAVxGimhuoOULFVhezv8NCzI/zx9l2SJZkm9Zx1LYWx8aDNZMxu/athfIL4Ibl4hpruYc0us4Vuy0XbDuqRKLp7/vfCyR9c3TrRCgiA32e5Keyu8jxZg8Ky8UbaiF69eofwa2s4ZLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY+irp6PU41cN4GdaLmPDNKVEhwIl6PeqLbDU8pUbLk=;
 b=axmHOfoyArZ/asFpbTtIw8SyI99q8l32FQLx6hkWwBt1jR9syUqfK3vR1LrKyAMFensgx8L7ZRXLqYG/jFdp90bb94gQt7UO9c89AWFBcp7VIxGJ+vwCjJxQXj/Eb2+nZzzTOTwGDYNJbRtZryZcHrSk0Hhn0VwSJHICtYn9BiMyylkHa8UlrGIGHOJAL7CCJwXXDo3Is4Yro2QOQcljBbzxKz2heir6yZeMkrf9AfGzsXEJVVAKTeLFk1/2t++7ck33rzvQAXyGce4n5W1NEa8ASAHiPA2yv+YRIDSXc3tm84dGo8GPV0cneEMfBETxm+n+r4JCoZEXv6PIz0015Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY+irp6PU41cN4GdaLmPDNKVEhwIl6PeqLbDU8pUbLk=;
 b=ZgHYOyl5W1mz4Q4Qw27hd3KTBoBOymwPSENZb9LdwDjJXm8K/8GA09q0HGEf8rlMjT4n5HgVeNV43AcQX9ak76NB+X4Xe+jIJv1JdK0hc2bHuJbDs/x3ItBR+EslBN7mB0LpR4xdbaG4h6CM7QmYeqv353yeHDwDmMo9oBFugaU=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS3PR01MB10357.jpnprd01.prod.outlook.com (2603:1096:604:1f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:47:41 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:47:41 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Topic: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgASohfaACXHRW4AGb/wQ
Date: Mon, 25 Nov 2024 15:47:41 +0000
Message-ID: 
 <TYYPR01MB124029C5A19C30B588BCFB6DFB72E2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <1808283AFE02050D.20097@lists.cip-project.org>
 <OS3PR01MB6103A8419829A8FDDCC767FDC2222@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103A8419829A8FDDCC767FDC2222@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS3PR01MB10357:EE_
x-ms-office365-filtering-correlation-id: e8d6fa30-8516-4c49-f33f-08dd0d687ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?RmNmb1MxbTZ0dmtJODEvUEZ2Z01XelZwQ0NqNkJYeHBGeG9BTEo3?=
 =?ks_c_5601-1987?B?bW52S0xrREFWWGFUVTA4WXNNaGZJYWRoT1owMXVyTkgvWG9JMGU5?=
 =?ks_c_5601-1987?B?YXArOHZKdFFtMFFmNmxJZ3RIZ255bXpORENheUo1QjBXdzhQckZI?=
 =?ks_c_5601-1987?B?ZXhJbmkwQkI4RytXTUk0ZDlMT3VPaGN2bkZxeVRKTUhyOVRaU1RU?=
 =?ks_c_5601-1987?B?ZTlPM21GUmRsejhqeXlsS1FUZitqWUdMQXNwUjFEa1VDSTNUcEly?=
 =?ks_c_5601-1987?B?ZHc2Z0wyellhdStkb0NBQlhJSXFVZnhuUXdkdUVVajI5M3hia3A1?=
 =?ks_c_5601-1987?B?SEdQU1dHUG03SVFkdks5dXEyYndNbTZ4bGxQQ1B3anFmd0FWbXpD?=
 =?ks_c_5601-1987?B?bS9IVTVUUUt0eUx6TjRBVmJWTnM3TnorOGZFckNRam14aEtCekFz?=
 =?ks_c_5601-1987?B?T2hoVEhoOFB5SlppWjl0UWdteWJ2cGlhR281MlZUWnlMbzN5VUFz?=
 =?ks_c_5601-1987?B?N21JbkQ5RExyTGtJUEE1ODhObXBEUGJoMjMwOVMxZHNKYnZiN1R0?=
 =?ks_c_5601-1987?B?V2liWGgxam5SREFMRG04bnN4S0g0S2RhMnJTMHhHTCtIZis2MnRa?=
 =?ks_c_5601-1987?B?a3FUL2NrZ1lvOGdMTEJEbjVxcVJSa1hIUlEvWkhvM3JoT0xIN0JB?=
 =?ks_c_5601-1987?B?Mit0a2ovVTRHbU5qNjIxK0czQmRsZSs1TmNLNkE2VWNQNEZ1S1BB?=
 =?ks_c_5601-1987?B?YkhHVnJKZkZ2WHI4L2NtY3dlQzBiNDEwUkkxOS9XMmMvaUFibmZn?=
 =?ks_c_5601-1987?B?V3FpWnhWTUJuZGpEbXR0eW9qeGxMZWwrQ3ZMV0hRekJtUS9CbHJ4?=
 =?ks_c_5601-1987?B?eUw1S0lUU3dkTkJ3Z1dIcjRDS3IzcjNQYWVkdXZ1Q09GMHpDUDRG?=
 =?ks_c_5601-1987?B?cFdTOWF5Nk9Ebmg4TGRiblVWUVVJUGFwYkZvOWZJeHlxSmxqdUpF?=
 =?ks_c_5601-1987?B?ZldvT3p4RWVWWk4yYVVDYTZhZkxiYVg2cXk1aENBUS9oS3hScHE2?=
 =?ks_c_5601-1987?B?MThnSmRTQnlVYTA0aGpramFqdy9BQ2lsM2xjUUpHTXdnaG9taDZz?=
 =?ks_c_5601-1987?B?MEhuc2RsMnFsZyt6R0hTVGpSM3pxSGZMYVljbjd4UVY4Mmwvc05i?=
 =?ks_c_5601-1987?B?N2FtdHd1d1NnYVBtWXQzaGc4RHJtRmZIcitsSlE5R1AwSllOWFcz?=
 =?ks_c_5601-1987?B?U0tpdzU3c2RYeDlKUk00TkZmTXRhZ3lQbndGaGNvd1dEdW13WHFV?=
 =?ks_c_5601-1987?B?eUxUanptaFlzRlpzRnZtWEx4clBTQTEyc0JYb3Fsa0hzODJ5bFBW?=
 =?ks_c_5601-1987?B?V04vcmRUOWIwdUZDVm9tS1NLL0pkY2syaXc3WXdvMWtXbWcrR0hy?=
 =?ks_c_5601-1987?B?eFFXOVVkdmRtM1dGMWx0ZEZQWStFdHFhRUpiZkl1MkRzUG9PRGI2?=
 =?ks_c_5601-1987?B?cEhCdU5BNVBpNDVOU3JBdXdGOGQxeEY0c0FDdzVNNG5wUC9YK1R4?=
 =?ks_c_5601-1987?B?dWV2bW5ZTEd1emhKQ1hHOU9ZNWdjYStWK2ZUQW1JMGlBYkxhZnNO?=
 =?ks_c_5601-1987?B?Z1ZuWlBmQTllS0d4bm5tMlBMYnllRFZ3aWtTY04rK0E0YTZvaWMv?=
 =?ks_c_5601-1987?B?elBINllYT0FVSkpZZk5OODhMazJWRjRtTnRzMFJGTmUzMXdYNXVG?=
 =?ks_c_5601-1987?B?UnltSXd5UnF5YlVYTUM2K1ZiMEEzaVRXOFRoV0gyN1pMNDhMME5j?=
 =?ks_c_5601-1987?B?RW1Cb0NjcjdFTWRJNC9LRVVFRmFJYTZFRGJYU3dSYXRDQlhBSTM0?=
 =?ks_c_5601-1987?B?NkVLSXdJWFBaWjkxQm93ajBiV1VFVjVBWk9LYkRnOUtWV29YSjJ5?=
 =?ks_c_5601-1987?B?dDMraHRvTzRDaElxMHoxRkptMS9OR1FZTXNtVlJKZ0FHRTZ5UGQ0?=
 =?ks_c_5601-1987?B?T1ovNHRHaUt4SEluVEpXYWVDdnM4NVdRd2FOTTdpbThyQmZTZHZw?=
 =?ks_c_5601-1987?B?azRlQWNNQ3AybEtFYmNLTHRjbU5VNnc1aXZIR0hZQisyQnkxc1BV?=
 =?ks_c_5601-1987?Q?mEAHoegEgPo0p9y4TkNC/U=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?clBaaC9EVmxsa05uR2pTcXNMYk8rbnhmWnh0U3dCQ2dYYUl4bkdD?=
 =?ks_c_5601-1987?B?UDZaZzU4Wm1NOTQxTmxHbUNnSG0vLy90d3NLVzd2Z1lOckt4dzA4?=
 =?ks_c_5601-1987?B?dVE4R0huWFkrQjAyeWFYbFZUVmNaMW5iMWx6Yzg1aFZRcGNBb1Vt?=
 =?ks_c_5601-1987?B?QThmK0doYzg2L1Q4MGQ2WGtja2ZYTSsxY3kzbXVwcGd6TUFGVVAw?=
 =?ks_c_5601-1987?B?NkdZVlc2MHhtdmNQaUlTeFZlSHNXWEE2NW9VRm11bmRxalc3UjE3?=
 =?ks_c_5601-1987?B?cjZtcjJRL0NnTDBhQnlUaG5yaUovNFZJR3pxYXRFeVFGYjNydFpL?=
 =?ks_c_5601-1987?B?Wk5ITVlzRm9kTSt0ekM2OExZVXBVaVZFZlAxaUxXdHpYY2RsbHVO?=
 =?ks_c_5601-1987?B?ditMYXRVWDNWTS9hS043VXdFWG8waHZCaFlobGEwVWlTam9WeDF2?=
 =?ks_c_5601-1987?B?ZVA4a1pqL0VhQ2NGRU9OTFgxcHpHckhnNTZwd0FTZVEvaUsxcHI4?=
 =?ks_c_5601-1987?B?TDNaSHRXRitOWFo4MDVkWTlLWTVYWHB5dUtwMUlodXM0QndLZjNK?=
 =?ks_c_5601-1987?B?N1lTeFRxS1JDQzZHMTRkdExuNUZUSWM1MW4wR0RxTElpd3BaK25r?=
 =?ks_c_5601-1987?B?NmUzdDloVjVxN0xFSnY3N1dnMldDSHdNREhGUDBMZHdkcThUSGl5?=
 =?ks_c_5601-1987?B?WmtncUdKSlJncmZxMHJSanQyTUcyd2dUbVEvVzdLY0lFMmJCUWM0?=
 =?ks_c_5601-1987?B?amZ0YkNZUjl5VlIwTHZHbmRxU2JsTzROUTdYWXA1c0I0NlpwSEVS?=
 =?ks_c_5601-1987?B?V3h0UnMvZmJpdVN1dHpkOE02SElGc0w4NmhTeHhmQlNENkRBeEIx?=
 =?ks_c_5601-1987?B?dzhLaDQxSTZUWHZjK3Y5aTNmODQ2ckJuWWZwbjlKWWdSYjYrM1V2?=
 =?ks_c_5601-1987?B?THc5bUJyaEp0MzNFWlEwdWwvVkY5YXMxcEFnU2lFdElId3E3MUNS?=
 =?ks_c_5601-1987?B?OXVFWkNGK3FvcjgxM2NBeEtxQ1ZjeWtYVjA3dE1vWFVSZ1RGTjdO?=
 =?ks_c_5601-1987?B?UVAyUVM2YTZLR0NYbzE2WUora2NzN25ZSzZXSmlXQ1NldjNubjZx?=
 =?ks_c_5601-1987?B?WGlUNERuYzI1Y0J2cUVlc2RJeWhpWGxZUXpkZFlLRDh5RWxRcndm?=
 =?ks_c_5601-1987?B?amVsNml6YUgxc0RVaTJBZzV5VEM2ZjFjN0RwN0ZqM1BvZEVMVGdP?=
 =?ks_c_5601-1987?B?SUZDb2ZrckhsdlEvMFY4QXVkWlBCVkJpbUovM0RjRnhVY0NyRUtr?=
 =?ks_c_5601-1987?B?Q1lwbmlkYmNOSFJGVjJqcmU5TzFjeEp2NzZVcFVGdG1vQjBoSUNR?=
 =?ks_c_5601-1987?B?MDdveE4ra05xbGRiQnNTdDcvbzBXYlNhMUtiam9KV1F6YzNCR1Bs?=
 =?ks_c_5601-1987?B?bEoyT1g2Y0RScHJGTnlLVkVySEdRdVZ3NmF6QlJaZkhpbWhsTzdT?=
 =?ks_c_5601-1987?B?Y0pmTG5rUUVnSzduMWZnWUp2Qi8yQWFhQWsxQ3k2dktUS2hRNW1L?=
 =?ks_c_5601-1987?B?bndSU1F1dTdBbFVtSVlUZFJMd2VpYXhVVTM0UzVuaU00NW5mOTF5?=
 =?ks_c_5601-1987?B?dS9pRFMxOE1Ud1pQU1BJV1poNmV3Wmg5djgrQzRxemJjWGpnME1H?=
 =?ks_c_5601-1987?B?SHhhTDBtb1FnazZVUWthY3pmRlA0bXEwQXMvRkhoWFExQ05XWk8r?=
 =?ks_c_5601-1987?B?UlBoQmIwN1NGUlRmaklQQWtTZXRGbk1UdWN3TDRqMlVWWHZBcG91?=
 =?ks_c_5601-1987?B?N1Znam5nSXNxVnVTazBKL0tnRzMvNyt6ZlRJTTJXSm1XSDZ6M003?=
 =?ks_c_5601-1987?B?UUx4eCtsbHlJdHhCd0V1QzZnalNnWFZ2RWpMQ09MRFhXUFVHNUNO?=
 =?ks_c_5601-1987?B?ZlUyUis2NnQrNmtvRGdGVDVBdk5LdGg1azlYbEJEeDRyZDlhWDVh?=
 =?ks_c_5601-1987?B?QVQvaXg5TVNNbDQwM3FGRkZJNExpMGVTMkpPQnRQamVEVTh5K1FP?=
 =?ks_c_5601-1987?B?aUJ4ODYxVjdNUUw1TFJnL3lxODlGcG43SGREbS9IdEpVSlEzL2Ur?=
 =?ks_c_5601-1987?B?eGJ6SkIzb09hNWxsUHA3QXN1OHB1TXlmRml3cmNkOEpZUndza01Y?=
 =?ks_c_5601-1987?B?bEtRYXpxSGxPVVluRE44cllaT1pESmRoNzl0N0FjVit5cDdQSGNM?=
 =?ks_c_5601-1987?B?bVNocUQvOG9FeDNGM3RMKzJRZnVkd1hZajZ1WG10MzFITmxQZm1i?=
 =?ks_c_5601-1987?B?bU96WkNaSHErWUhQQmVUWXJ6bnZwOXpZZ0VrZHp5TmQ3Vm9YRFFT?=
 =?ks_c_5601-1987?B?TTdZa0YrZzEybUp3QzNOWURoVHQ2R0I1QUJBTEQrL3MwTW5oUkFC?=
 =?ks_c_5601-1987?B?Q2UyQW9xLytibmVHMW1mVHV5K1dvZDBlSXBGcks2blZPOUJsZzZ2?=
 =?ks_c_5601-1987?B?QkxlckxieFZoSzNQcExzem04MWtKbGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB124029C5A19C30B588BCFB6DFB72E2TYYPR01MB12402jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d6fa30-8516-4c49-f33f-08dd0d687ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 15:47:41.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gwu1S1bZgkuRC6VyZXYn+l75nKCDAmuvg7/nbJmXYxfRNtYuhCo6tQHLsKWt5Z9Wu0bRYVESRHZlVA3hTSBOimvDCb+kYYhzJZ/NRsAOoMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Nov 2024 15:47:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17276

--_000_TYYPR01MB124029C5A19C30B588BCFB6DFB72E2TYYPR01MB12402jp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gU2FpLA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBzbG93IHJlc3BvbnNlLg0KDQpXZWxsIGRv
bmUgZm9yIGdldHRpbmcgdGhlIExUUCB0ZXN0cyBydW5uaW5nIGxvY2FsbHkuDQpJZiB5b3Ugc2Vu
ZCBtZSB0aGUgdGFyYmFsbCBvciBsaW5rIG1lIHRvIGl0IEkgY2FuIHVwbG9hZCBpdCB0byBTMyBm
b3IgeW91Lg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCkZyb206IFNhaS5TYXRodWpvZGFAdG9z
aGliYS10c2lwLmNvbSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KU2VudDogMjEg
Tm92ZW1iZXIgMjAyNCAxMzozOA0KVG86IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJA
cmVuZXNhcy5jb20+DQpDYzoga2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcDsgZGluZXNo
Lmt1bWFyQHRvc2hpYmEtdHNpcC5jb207IGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5v
cmc7IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwOyBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBNYW51YWxseSBydW4gS2VybmVsIGFu
ZCBJRUMgdGVzdHMgb24gTS1DT00geDg2IGFuZCBnZW5lcmF0ZSByZXN1bHRzDQoNCkhlbGxvIENo
cmlzLA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgZ3JlYXQuDQoNClRoaXMgaXMganVzdCBhbiB1cGRh
dGUgcmVnYXJkaW5nIG15IHByZXZpb3VzIHF1ZXJ5IGluIHRoaXMgbWFpbCB0aHJlYWQuDQoNCkkg
d2FzIGFibGUgdG8gcnVuIExUUCBvbiBzZWN1cml0eSB0YXJnZXQgaW4gbXkgbWFjaGluZSBhZnRl
ciBpbmNsdWRpbmcga2FzL29wdC90ZXN0LnltbCChpCBtYXN0ZXIgoaQgY2lwLXByb2plY3QgLyBj
aXAtY29yZSAvIGlzYXItY2lwLWNvcmUgoaQgR2l0TGFiPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAt
cHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vYmxvYi9tYXN0ZXIva2FzL29wdC90ZXN0
LnltbD9yZWZfdHlwZT1oZWFkcz4gd2hpbGUgYnVpbGRpbmcgdGhlIGltYWdlIGFzIGl0IGNvbWVz
IGFsbCB0aGUgZGVwZW5kZW5jaWVzIHJlcXVpcmVkIHRvIHJ1biB0aGVtLg0KDQpGb3IgTEFWQSwg
SSB3aWxsIHRyeSB0byB1cGxvYWQgYSByb290ZnMgdGFyYmFsbCB0byBjaXAtcHJvamVjdCdzIFMz
IHN0b3JhZ2Ugd2l0aCBidWlsZDp4ODYtdWVmaS1iYXNlIGNvbmZpZ3VyYXRpb24gYWxvbmcgd2l0
aCBleHRlbnNpb246IHRlc3QuIEkgaG9wZSBJIGNhbiBydW4gTFRQIHRlc3RzIG9uIE0tQ09NIHg4
NiBvbiBMQVZBIHdpdGggdGhpcyBtZXRob2QuIEkgcmFuIFNNQyB0ZXN0cyBvbiBNLUNPTSB4ODYg
d2l0aCA2LjEuMTEyLWNpcDMwIGtlcm5lbCAtPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcv
cmVzdWx0cy8xMjIyNjE2LzBfc3BlY3RyZS1tZWx0ZG93bi1jaGVja2VyLXRlc3QNCg0KVGhhbmtz
IGFuZCByZWdhcmRzLg0KU2FpIEFzaHJpdGgNCg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
ZzxtYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+PiBvbiBiZWhhbGYgb2Ygc2Fp
LnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpzYWkuc2F0aHVqb2RhQHRvc2hpYmEt
dHNpcC5jb20+IDxzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOnNhaS5zYXRo
dWpvZGFAdG9zaGliYS10c2lwLmNvbT4+DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDI0
IDc6MTQgUE0NClRvOiBDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb208bWFpbHRvOkNocmlzLlBh
dGVyc29uMkByZW5lc2FzLmNvbT4gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbTxtYWlsdG86
Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NCkNjOiBoYXlhc2hpIGthenVoaXJvKNf5IPv6
ztsgo8SjzaPFIKHbo8SjyaPHoeCjzaPQo9Oh26PNo9CjtCkgPGthenVoaXJvMy5oYXlhc2hpQHRv
c2hpYmEuY28uanA8bWFpbHRvOmthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+PjsgZGlu
ZXNoIGt1bWFyKKPUo9OjyaPQIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hp
YmEtdHNpcC5jb208bWFpbHRvOmRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPj47IGNpcC1z
ZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1zZWN1cml0eUBsaXN0cy5j
aXAtcHJvamVjdC5vcmc+IDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0
bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGl3YW1hdHN1IG5vYnVoaXJv
KOTb4eYg4+HlxyCh26PEo8mj1KPDoeCjxKPJo9Sh26PPo9Oj1CkgPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPG1haWx0bzpub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4+
OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+Pg0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBNYW51YWxs
eSBydW4gS2VybmVsIGFuZCBJRUMgdGVzdHMgb24gTS1DT00geDg2IGFuZCBnZW5lcmF0ZSByZXN1
bHRzDQoNCkhlbGxvIENocmlzLA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KQWZ0ZXIg
Z29pbmcgdGhyb3VnaCBMYXZhIGpvYiBkZWZpbml0aW9ucyB3aGVyZSBsdHAgdGVzdHMgYXJlIHJ1
biBvbiBDSVAgcmVmZXJlbmNlIGhhcmR3YXJlIG9uIENJUCBMQVZBLA0KDQpJIG5vdGljZWQgdGhh
dCBsdHAgdGVzdHMgYXJlIGJlaW5nIG1vc3RseSBvbjoNCg0KcmVuZXNhc19yOGE3NzQzLWl3ZzIw
ZC1xNw0KcmVuZXNhc19yOGE3NzRhMS1oaWhvcGUtcnpnMm0tZXgNCng4Nl9jaXBfcWVtdQ0KDQpV
c2luZyByb290ZnMgdGFyYmFsbHMgc3VjaCBhczoNCg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEu
YW1hem9uYXdzLmNvbS9kb3dubG9hZDIuY2lwLXByb2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEt
aGVhbHRoY2hlY2tzL3Jmcy9jb3JlLWltYWdlLW1pbmltYWwtcWVtdWFybTY0LWx0cC50YXIuYnoy
DQpodHRwczovL3MzLWV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2FkMi5jaXAtcHJv
amVjdC5vcmcvY2lwLXRlc3RpbmcvbGF2YS1oZWFsdGhjaGVja3MvcmZzL2NvcmUtaW1hZ2UtbWlu
aW1hbC1xZW11eDg2LTY0LWx0cC5leHQ0Lnh6DQoNCi4uYWxvbmcgd2l0aCByZXNwZWN0aXZlIGR0
YiBmaWxlcy4NCg0KQnV0IGN1cnJlbnRseSBtLWNvbSBoZWFsdGggY2hlY2tzIGFyZSB1c2luZyBo
dHRwczovL3MzLXVzLXdlc3QtMi5hbWF6b25hd3MuY29tL2Rvd25sb2FkLmNpcC1wcm9qZWN0Lm9y
Zy9jaXB0ZXN0aW5nL2NpcC1sYXZhL3Jmcy9yb290ZnMtc2ltYXRpYy1pcGMyMjdlLnRhci5neiBy
b290ZnMuDQoNCkkgdHJpZWQgdG8gdXNlICBTS0lQX0lOU1RBTEw6ICJmYWxzZSIgaW4gdGhlIHRl
c3QgZGVmaW5pdGlvbiBiZWNhdXNlIGx0cCB0ZXN0IGNhc2VzIGFyZSBub3QgcHJlc2VudCBpbiBl
eHBlY3RlZCBmb2xkZXJzLCBleDogL29wdC9sdHAgYW5kIGRlcGVuZGVuY3kgcGFja2FnZXMgYXMg
d2VsbCBleHBlY3RpbmcgdGhleSB3aWxsIGJlIGluc3RhbGxlZCBpbiB0aGUgaW1hZ2UgYWZ0ZXIg
Ym9vdC4gQnV0IHRoZSBqb2IgZmFpbGVkLiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi8xMjIzMTQ5I0wxMzM5DQoNCkkgcmVxdWVzdCB5b3UgdG8gaGVscCBtZSBpbiBw
cmVwYXJpbmcgYSBzaW1hdGljLWlwYzIyN2Ugcm9vdGZzIHRhcmJhbGwgd2l0aCBsdHAgdGVzdHMg
YW5kIHJlcXVpcmVkIHBhY2thZ2VzIGFuZCBwdXNoaW5nIGNpcC1wcm9qZWN0IHMzIHN0b3JhZ2Ug
c28gdGhhdCBJIGNhbiBydW4gbHRwIHRlc3RzIG9uIG0tY29tIGRldmljZS4gUGxlYXNlIHN1Z2dl
c3QgaWYgeW91IGtub3cgYW55IGFsdGVybmF0ZSByb290ZnMgY2FuIGJlIHVzZWQgdG8gYm9vdCBv
biBtLWNvbSBkZXZpY2UuDQoNClRoYW5rcyBhbmQgcmVnYXJkcywNClNhaSBBc2hyaXRoDQoNCmh0
dHBzOi8vczMtZXUtY2VudHJhbC0xLmFtYXpvbmF3cy5jb20vZG93bmxvYWQyLmNpcC1wcm9qZWN0
Lm9yZy9jaXAtdGVzdGluZy9sYXZhLWhlYWx0aGNoZWNrcy9yZnMvY29yZS1pbWFnZS1taW5pbWFs
LXFlbXVhcm02NC1sdHAudGFyLmJ6Mg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdz
LmNvbS9kb3dubG9hZDIuY2lwLXByb2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hl
Y2tzL3Jmcy9jb3JlLWltYWdlLW1pbmltYWwtcWVtdXg4Ni02NC1sdHAuZXh0NC54eg0KDQoNCg0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPj4gb24gYmVoYWxmIG9mIENocmlzIFBhdGVyc29uIHZpYSBsaXN0cy5jaXAtcHJvamVj
dC5vcmcgPGNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAtcHJvamVjdC5vcmc8
bWFpbHRvOmNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
Pg0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgNzozOSBQTQ0KVG86IGNpcC1zZWN1
cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1zZWN1cml0eUBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpj
aXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGl3YW1hdHN1IG5vYnVoaXJvKOTb
4eYg4+HlxyCh26PEo8mj1KPDoeCjxKPJo9Sh26PPo9Oj1CkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPG1haWx0bzpub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4+DQpD
YzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGhheWFzaGkga2F6dWhpcm8o1/kg+/rO2yCjxKPN
o8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4+OyBkaW5lc2gga3Vt
YXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lw
LmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+Pg0KU3ViamVjdDogUmU6
IFtjaXAtZGV2XSBNYW51YWxseSBydW4gS2VybmVsIGFuZCBJRUMgdGVzdHMgb24gTS1DT00geDg2
IGFuZCBnZW5lcmF0ZSByZXN1bHRzDQoNCkhlbGxvIFNhaSwNCg0KPiBGcm9tOiBjaXAtc2VjdXJp
dHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXBy
b2plY3Qub3JnPiA8Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC0NCjxtYWlsdG86Y2lwLXNlY3VyaXR5
QGxpc3RzLmNpcC0lMGI+PiBwcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIHNhaSBhc2hyaXRoIHNh
dGh1am9kYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IDEyIE5vdmVtYmVyIDIw
MjQgMDQ6MTQNCj4NCj4gSGVsbG8gQ2hyaXMsDQo+DQo+IEhvcGUgeW91IGFyZSBkb2luZyB3ZWxs
Lg0KPg0KPiBSZWdhcmRpbmcgSUVDIDYyNDQzLTQtMiBjZXJ0aWZpY2F0aW9uLCB0aGUgY2VydGlm
aWNhdGlvbiBib2R5IGhhcyBhc2tlZA0KPiBmb3IgS2VybmVsIGFuZCBJRUMgdGVzdCByZXN1bHRz
IG9uIE0tQ09NIGRldmljZS4gQmFzZWQgb24gbXkgY3VycmVudA0KPiBrbm93bGRlZ2UsIEkgYmVs
aWV2ZSB0aGF0IHRoZSB0ZXN0IHN1aXRlcyBtZW50aW9uZWQgaGVyZQ0KPiBodHRwczovL2dpdGxh
Yi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lwLWNpLy0NCj4gL2Jsb2IvbWFz
dGVyL3N1Ym1pdF90ZXN0cy5zaD9yZWZfdHlwZT1oZWFkcyNMNTUgPGh0dHBzOi8vZ2l0bGFiLmNv
bS9jaXAtDQo8aHR0cHM6Ly9naXRsYWIuY29tL2NpcC0lMGI+PiBwcm9qZWN0L2NpcC10ZXN0aW5n
L2xpbnV4LWNpcC1jaS8tDQo+IC9ibG9iL21hc3Rlci9zdWJtaXRfdGVzdHMuc2g/cmVmX3R5cGU9
aGVhZHMjTDU1PiAgc2hhbGwgcnVuIGZvciBldmVyeQ0KPiB1cGRhdGVkIGtlcm5lbCBpbWFnZSBv
biBkaWZmZXJlbnQgQ0lQIHJlZmVyZW5jZSBoYXJkd2FyZSBpbiBMQVZBLg0KPg0KPiBTaW5jZSBh
dmFpbGFiaWxpdHkgb2YgTS1DT00gZGV2aWNlIG9uIENJUCBMQVZBIExhYiBzdGlsbCBuZWVkcyBz
b21lIHRpbWUsDQo+IHdlIGFyZSBtYW51YWxseSBydW5uaW5nIGVhY2ggdGVzdCBzdWl0ZSBpLmUg
U01DLCBTbW9rZSwgTFRQIGV0Yy4gZnJvbQ0KPiBodHRwczovL2dpdGh1Yi5jb20va2VybmVsY2kv
dGVzdC1kZWZpbml0aW9ucw0KDQpBcyBKYW4gc2FpZCAtIHdlIG5vdyBoYXZlIG9uZSBpbiBDSVAn
cyBMQVZBLg0KSWYgeW91IGhhdmUgaXNzdWVzIHVzaW5nIGl0IHBsZWFzZSBsZXQgbWUga25vdy4N
Cg0KPg0KPiBUaGVyZSBhcmUgbm8gaXNzdWVzIHdpdGggcnVubmluZyBTTUMsIFNtb2tlIHRlc3Rz
IGJ1dCB3aGlsZSBydW5uaW5nIExUUA0KPiB0ZXN0cyBpdCBpcyB0cnlpbmcgdG8gaW5zdGFsbCBz
b21lIGRlcGVuZGVuY3kgcGFja2FnZXMgdG8gdGhlIHJvb3QgZmlsZQ0KPiBzeXN0ZW0uIEN1cnJl
bnRseSBpdCBzaG93cyBpdCBpcyBhIG5ldHdvcmsgaXNzdWUgYnV0IGV2ZW4gaWYgaXQgZ2V0cw0K
PiByZXNvbHZlZCwgdGhlIHBhY2thZ2VzIGNhbm5vdCBiZSBpbnN0YWxsZWQgYmVjYXVzZSB0aGUg
c2VjdXJpdHkgaW1hZ2UgaGFzDQo+IHJlYWQtb25seSByb290IGZpbGUgc3lzdGVtLg0KDQpTbyB5
b3UnZCBlaXRoZXIgaGF2ZSB0byB1c2UgYSB3cml0YWJsZSBmaWxlc3lzdGVtIG9yIHByZS1pbnN0
YWxsIGV2ZXJ5dGhpbmcgaW50byB0aGUgb3JpZ2luYWwgaW1hZ2UuDQoNCj4NCj4gQW5vdGhlciBp
ZGVhIHdoaWNoIG5lZWRzIHRvIGJlIGRpc2N1c3NlZCBpcywgc2luY2UgS2VybmVsIHRlc3RzIGJ5
IG5hbWUNCj4gbWVhbnMgZm9jdXNpbmcgb24gdGVzdGluZyBvbmx5IHRoZSBLZXJuZWwsIHdlIGNh
biB0cnkgdG8gdXNlIGEgZGlmZmVyZW50DQo+IHJvb3QgZmlsZSBzeXN0ZW0gdG8gcnVuIHRoZXNl
IHRlc3RzLiBCdXQgdGhpcyBpcyBqdXN0IGFuIGlkZWEsIHRoaXMgbmVlZHMNCj4gdG8gaW50ZXJu
YWxseSBiZSBkaXNjdXNzZWQgd2l0aGluIFNXRyBhbmQgd2l0aCBDZXJ0aWZpY2F0aW9uIGJvZHku
DQoNClRoZXJlJ3Mgbm8gaGFybSBpbiB1c2luZyBhIGRpZmZlcmVudCByb290ZnMsIG9yIGluIGlt
cHJvdmluZyB0aGUgb25lIGN1cnJlbnRseSB1c2VkIGZvciBLZXJuZWwgdGVzdGluZy4NCkluZGVl
ZCBJIGJlbGlldmUgSXdhbWF0c3Utc2FuIGNyZWF0ZWQgc2VwYXJhdGUgaW1hZ2VzIGZvciBMVFAg
dGVzdGluZyBwcmV2aW91c2x5IGFueXdheS4NCg0KPg0KPiBJIHJlcXVlc3QgeW91IHRvIHByb3Zp
ZGUgYW55IHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyB0aGUgYXR0YWNoZWQgTFRQDQo+IGlzc3Vlcy4N
Cg0KWW91J2QgbmVlZCBhIHdvcmtpbmcgaW50ZXJuZXQgY29ubmVjdGlvbiB0byBzb2x2ZSB0aGUg
c3BlY2lmaWMgaXNzdWVzIGluIHRoYXQgbG9nLg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCj4N
Cj4gVGhhbmtzIGFuZCByZWdhcmRzLA0KPiBTYWkgQXNocml0aCAoVCBTIEkgUCkNCj4NCg==

--_000_TYYPR01MB124029C5A19C30B588BCFB6DFB72E2TYYPR01MB12402jp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Gulim",sans-serif;
	mso-fareast-language:KO;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
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
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Apologies =
for the slow response.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Well done =
for getting the LTP tests running locally.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">If you sen=
d me the tarball or link me to it I can upload it to S3 for you.<o:p></o:p>=
</span></p>
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
<b>Sent:</b> 21 November 2024 13:38<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-security@lists.cip-project.org; nobuhiro1.iwamatsu@toshiba.co.jp; cip-d=
ev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results<o:p></o:p></span></p>
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
rif;color:black">Hope you are doing great.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">This is just an update regarding my previous query in this=
 mail thread.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I was able to run LTP on security target in my machine aft=
er including
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/mas=
ter/kas/opt/test.yml?ref_type=3Dheads">
kas/opt/test.yml =A1=A4 master =A1=A4 cip-project / cip-core / isar-cip-cor=
e =A1=A4 GitLab</a>&nbsp;while building the image as it&nbsp;comes all the =
dependencies required to run them.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">For LAVA, I will try to upload a rootfs tarball to cip-pro=
ject's S3 storage with build:x86-uefi-base configuration along with
<b>extension: test</b>. I hope I can run LTP tests on M-COM x86 on LAVA wit=
h this method. I ran SMC tests on M-COM x86 with 6.1.112-cip30 kernel -&gt;
<a href=3D"https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-c=
hecker-test">
https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-checker-test=
</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Thanks and regards.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Sai Ashrith<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of
<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujo=
da@toshiba-tsip.com</a>&gt;<br>
<b>Sent:</b> Friday, November 15, 2024 7:14 PM<br>
<b>To:</b> <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@r=
enesas.com</a> &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font-size:11.=
0pt;color:black">=D7=F9</span><span lang=3D"KO" style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-=
size:11.0pt;color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=CD=A3=D0=A3=
=D3</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt;color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC =
ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-project.org"=
>cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(</span><span=
 lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E4=DB=E1=E6</span><spa=
n lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size:1=
1.0pt;color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=C9=A3=
=D4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">&nbsp;</span><o:p></o:p></p>
</div>
</div>
<div>
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
rif;color:black">Hope you are doing well.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">After going through Lava job definitions where ltp tests a=
re run on CIP reference hardware on CIP LAVA,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I noticed that ltp tests are being mostly on:<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">renesas_r8a7743-iwg20d-q7<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">renesas_r8a774a1-hihope-rzg2m-ex<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">x86_cip_qemu<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Using rootfs tarballs such as:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/download2=
.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemua=
rm64-ltp.tar.bz2">https://s3-eu-central-1.amazonaws.com/download2.cip-proje=
ct.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.t=
ar.bz2</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/download2=
.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux=
86-64-ltp.ext4.xz">https://s3-eu-central-1.amazonaws.com/download2.cip-proj=
ect.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp=
.ext4.xz</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">..along with respective dtb files.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">But currently m-com health checks are using
<a href=3D"https://s3-us-west-2.amazonaws.com/download.cip-project.org/cipt=
esting/cip-lava/rfs/rootfs-simatic-ipc227e.tar.gz">
https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-=
lava/rfs/rootfs-simatic-ipc227e.tar.gz</a> rootfs.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I tried to use &nbsp;SKIP_INSTALL: &quot;false&quot; in th=
e test definition because ltp test cases are not present in expected folder=
s, ex: /opt/ltp and dependency packages as well expecting they
 will be installed in the image after boot. But the job failed. <u><a href=
=3D"https://lava.ciplatform.org/scheduler/job/1223149#L1339">https://lava.c=
iplatform.org/scheduler/job/1223149#L1339</a></u><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">I request you to help me in preparing a simatic-ipc227e ro=
otfs tarball with ltp tests and required packages and pushing cip-project s=
3 storage so that I can run ltp tests on m-com
 device. Please suggest if you know any alternate rootfs can be used to boo=
t on m-com device.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Thanks and regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Sai Ashrith<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/download2=
.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemua=
rm64-ltp.tar.bz2">https://s3-eu-central-1.amazonaws.com/download2.cip-proje=
ct.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.t=
ar.bz2</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/download2=
.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux=
86-64-ltp.ext4.xz"><span style=3D"color:white">https://s3-eu-central-1.amaz=
onaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-=
image-minimal-qemux86-64-ltp.ext4.xz</span></a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of Chris Paterson via lists.cip-project.o=
rg &lt;<a href=3D"mailto:chris.paterson2=3Drenesas.com@lists.cip-project.or=
g">chris.paterson2=3Drenesas.com@lists.cip-project.org</a>&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-p=
roject.org">cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E4=DB=E1=E6=
</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size:1=
1.0pt;color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=C9=A3=
=D4</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt;; hayashi kazuhiro(</span><span lang=3D"K=
O" style=3D"font-size:11.0pt;color:black">=D7=F9</span><span lang=3D"KO" st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-=
size:11.0pt;color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=A1=E0</span=
><span lang=3D"KO" style=3D"font-size:11.0pt;color:black">=A3=CD=A3=D0=A3=
=D3</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">=A1=DB</span><span lang=3D"KO" style=3D"font-size:11=
.0pt;color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif;color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt;color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> TMIEC =
ODG
 Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar=
@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">&nbsp;</span><o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-%=
0b">cip-security@lists.cip-<br>
</a>&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-p=
roject.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-">=
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;<a href=3D"https=
://gitlab.com/cip-%0b">https://gitlab.com/cip-<br>
</a>&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;</span><span styl=
e=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">&nbsp;</s=
pan><span style=3D"font-size:11.0pt"> shall run for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions">https://githu=
b.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB124029C5A19C30B588BCFB6DFB72E2TYYPR01MB12402jp_--

