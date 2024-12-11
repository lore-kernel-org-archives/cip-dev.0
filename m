Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D0E77180
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 08:51:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.6270.1733907078662978556
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 00:51:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=e9kTHU1l;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1733907055;x=1735116655;bh=N/
	LTKce4iHCL6QAhlnDIUeWPEooYiVbB8nlutmWl1cM=;b=e9kTHU1lAXXdcXyoesU8ezPR6V22FWx3
	8NHWDp+3BH2b/mf8YAO/Kgkb0i613iPB/mOylJSqbArGRrpvij7oSUTdDM4kEhMIwbzJYGRY+oIUr
	2VRrhwou8KvAUAvwxwp/Lg7AlhtTKvEgIi8zwK25n6cyl8tYCEX8VdZp//Qe2VLoZmUPmPypFKKrm
	55XUhGSpWZc5RRq7GmV5vEc+vj/MSCyaO5oyeg/hExIvHvO/5rZ28tjARjm+/sXbRkUVqr3F0iseW
	h/0iSFADK/h4bEWGAM2vW16mXW4zmtYxCGSKKjFTZAuSpupQICPm7mNJ5Bv8Ua0F4IY87pXjU+9ew
	Cg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4BB8otDD791787; Wed, 11 Dec 2024 17:50:55 +0900
X-Iguazu-Qid: 2rWhMjEQGeJIbrO4T4
X-Iguazu-QSIG: v=2; s=0; t=1733907054; q=2rWhMjEQGeJIbrO4T4; m=ytFoKqqDbx96vqjlGgoFM3GR/5eVbp8M/3olb+XMuN0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4BB8orJ23553180
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 17:50:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrfBI82A/WswbuvUu5yqgKyn1DW9mihryRaQHFMjNeS6rSxQ0F8pSNTHXuGRa9yApZEnlfHSeJr1ZJUHlQVtSsHDdHtq2Ded52yrfCen/0+nejN0uzZK0VipkJFTUw5DRa33z4Zx5KdzJ8oBLQsbyH0qVrtRlr7vAy0vplukWsBraXIHAgZPh9zGTSL3nrgHqH3urCBmcKgGVZnwEipmaCvMlMsdFS7trgk6U1VNewAyZ4STe3Xi4leCBZncKE6qJ6HWr1h8w4A1hh46aXKkjyDxjQQ7pF6a7U1N7qpF+JTpogRpTdwDaMdvhhChKK86s9yuJoRof9C8lNuYhBmjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMjcmoax8U2LfdWfyZ2kQG8OgitttRn84/owRz216+o=;
 b=gxQe8Wi4L0UyOYdXiBAhf+AHIEMnCLrLY5Jp0AuVXjEKnxJjOrLHSgj9Vt/FXZPQWms8xAKX3D8+RVh7iXwiifGyLahUS4E+M8fsNYqD5EYifkz5gHfXYwFbE9S7Y8rtDL2aUvRE403pMqY4TmPbRL2if4YfV4CYaOKOU0Il8VwI/IgvEnCmViF7BXtWMlQkQQxuMGPdoZ4npGhR4dVpVwL7SPpRe0VCCNlO0SI5Xq2HaMy1e+z5P8g5JNn/ughHNhJKtyzv4/pZ/JkbQUkNTBWhz5QsOrKYbWKSjYCV2f3InC1NyXIhqBwoYcj3gh3ACltdJgXbnwTtlIXCjlsdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.230-cip55 and v6.1.119-cip33
Thread-Topic: [ANNOUNCE] Release v5.10.230-cip55 and v6.1.119-cip33
Thread-Index: AdtLn0TaTcdMVeagQfaycm/vk9yuxg==
Date: Wed, 11 Dec 2024 08:50:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D073426813B75F207025923E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB6336:EE_
x-ms-office365-filtering-correlation-id: 3945898f-b8f1-4bb7-18b7-08dd19c0e9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QVhXTzFYOGpaL3RYOSswUWdCdk1lOXdOdFdnaHVJZXB3dXM4NW14eVBv?=
 =?iso-2022-jp?B?NzFLYjdDQkl6RGdWaEtKSWdxVXY2Wk54Z1V2RlhNSUZmVkVMbzZ4K0hs?=
 =?iso-2022-jp?B?RGhXSlQ3ZS9KOHVtNlZJVXlGeHFwZ3AxUy80ZHdlL1ViRVFWbS9ZQThK?=
 =?iso-2022-jp?B?N3VubGQzaVd4aEtMekZ2K1hyT0xOeXJsOEtFOExBVU5uaVhxUzVKbEIz?=
 =?iso-2022-jp?B?b2FaZTZ1OGp3QkZjTWJaUDZoOURGditMSEVJTk51UXE1MUloUnpRWEtp?=
 =?iso-2022-jp?B?V0czUGRrZ2pwWTZJTUswbFdrVER5QVpGVFRPbUtSMXRFZVpabDJzdktY?=
 =?iso-2022-jp?B?UFJPaFdWcUF3WXE3QXlPQnUrWmppVERyay9wQTJUL211YmpGa29EVCto?=
 =?iso-2022-jp?B?cVRwUkU4UkwxeURMTnMydFNPNmRCRGhva21FUDB4SlhCL3pLYVAzS2wz?=
 =?iso-2022-jp?B?c3BLMkI1Y05QeHk1OEU4Mk5WRVBzK2lvV2FJcW5TOXdtS1R4L2RxRzFN?=
 =?iso-2022-jp?B?endTeG5qQnRNdWQ4MW5HUU9tL2VkVWsrSWFFTElSdW1PeWhCYzQwd3Fn?=
 =?iso-2022-jp?B?Y3hURFV5anNqaTRabFhyYnlaRDlidjhHc2hrTWwwT0pTTVZYMzVKUmhs?=
 =?iso-2022-jp?B?WTBOQVE3UmpDa3Rxbjg0RHc0K09tbG9mSHNlekdIeWh6RHpjQ0Q2RTY2?=
 =?iso-2022-jp?B?MGxEMkEvMllWVFJOLzF6R2lXMUhZc2VnTS9hSDA3cC9sdDF5QlRBUGNl?=
 =?iso-2022-jp?B?M2pxUXdPUFlmS2x5K1U0bnJlL2ZOcGI4TlYxVFFwUVh5NVBqWDlwc3Ix?=
 =?iso-2022-jp?B?cDdMbHlMOCtmUFhQd1Z0aFN1U2FheVVHejNoalJoMThJRWtWQ01qcTZJ?=
 =?iso-2022-jp?B?Vno5Q0RwbDR0dWFCV0lab05aYzc1R3A1WWQ1L1hsdWhQUXlUVWwvekN4?=
 =?iso-2022-jp?B?UmNNRnEyM2lOd0Y5WDA5N0d1TFIxYUdpaWh0VlNRUGQ5cG1HbDM0ak1D?=
 =?iso-2022-jp?B?OWxqOTh5MEFrOFJpU2RjUG5sQjlqbXFhcG5PSm9Jc3hZVnlXeFhXcjda?=
 =?iso-2022-jp?B?eGQ4THdwMVhuMXNNS3dnelBPVjlRMGVqc1pRQlJKUXVKRFJVMkJUNXdX?=
 =?iso-2022-jp?B?dHE3MUg4SlY2U2FRMGl1bzh5aWcxQUs0NkRveUo2aHByWmRTTlExL3o2?=
 =?iso-2022-jp?B?WHUrMTFsQjVlZlo2TjJSMWROSkk3NlJzVWc3RHJZUG1vMU1LVGwvSi9o?=
 =?iso-2022-jp?B?dGhFY0doMTBwcitFWlJSNXFqY2x1YnhWYm1jSE01ZXFNeUJYUHcvV3V3?=
 =?iso-2022-jp?B?dFFqVWNqTWpPMVZqWTcrNThTQVBidGdQbWhQNXRLclcySDJQUGFhWGtl?=
 =?iso-2022-jp?B?NnJBNmdxQkNVUitUaXFXek9NSUdscHF2SlVnaWZpU0JCZ1A5U3M2cDJP?=
 =?iso-2022-jp?B?NlMrSTlsUFNyM1Q3U0RWTDBIc0F6RnJjUVBYV0cvaENpRU8vb1NLVThG?=
 =?iso-2022-jp?B?MG1JcmsvVHk2cVZSdy80YWRDZHdFS3ovRjdaUnFkWmNKY0xPUm1TeUVZ?=
 =?iso-2022-jp?B?Y2p3eW5INm5zSEQ3V3Bzd2tjRHM2aVg1U1FJSFh2NU1BR2xta0Y3SXJz?=
 =?iso-2022-jp?B?UmM1d1ZRVGtGSWVBS2lkdnMyb0w0UDFYMXdzUUFheEVkaENnREUveEs3?=
 =?iso-2022-jp?B?Y0ZzNW9GaUFDT0ZpR21xS2xodXkyc0s5RVl4S3FZUUV5TTVkcVRYUmRN?=
 =?iso-2022-jp?B?VkVxYUN6cU80SXZiV3pnVzJURzdvZnJmcFVnbmRlQzF2cVdtV0Q2MkRw?=
 =?iso-2022-jp?B?SEhWQVNkTk5wR2N4Ykw2b1lnMkhFSEMxQThHZjdCQng1YzJQQlZFTnVw?=
 =?iso-2022-jp?B?QjJFU0FXQXExUkFKVzRTN2ZPQURLbm1vNFczK0VlU2ZHd0R5MUZwRFVs?=
 =?iso-2022-jp?B?ZElKbmdTN3RkSUlVVkhya3dCWHduTEYwTTAwRkhmT1hPV2dWU0hVcXRk?=
 =?iso-2022-jp?B?R2drbloxaGFSejNtK0ljQ3NJOWhzUm1OSTNjMWJkYlphNE8wazRGeHdS?=
 =?iso-2022-jp?B?WGt0bE9qRE1pRVdSU3RJY3c2SU1sTVQyeVlKdXNXcCs3b3h3eFV6VWxG?=
 =?iso-2022-jp?B?NHk=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a3dYdSs0YTR3UVdkT3YxWTlHZys4OXhnZGRkZmY4SGx4L1JrRmp6bU5s?=
 =?iso-2022-jp?B?NmlxWmNFaGFFcjZmTnBoQU1lay9qem9Cby9peDlFdFYwTkpyS1g4djdT?=
 =?iso-2022-jp?B?SFZFcHJFNVBYNzgyKzAycWhkRXFnY3N6RThRQW5wc0swRGlVdkNTMUUr?=
 =?iso-2022-jp?B?SDRUY2pZM3A2VXlZRzNpMWh3SWUzZC9zWFl6MkdFeTQzRDY5cEdiNFI5?=
 =?iso-2022-jp?B?L3N4U3JWaDd6K1FHRlhITzFzSHFwdVZpaXA5NDl6UFJFNUpGRlpaUFNH?=
 =?iso-2022-jp?B?MVJ0WUIrakxLQ2g4M0dFdyt3eFNUTzdwSmtiL2dlU0VFMGJXZmMwWWVw?=
 =?iso-2022-jp?B?V3hGY0ZKY09ROWJjT1o4VTlqSGNhcHRhYis4NDlzTUtJaWZTS0NhV0Zx?=
 =?iso-2022-jp?B?WVZCSzhyODBEWFRIYVI1TDk2YmtYeHAxQ0hWSmwwUDBHdjgvczl5Witl?=
 =?iso-2022-jp?B?OUxndUhMN25Jc1EzcFNSc1h3MHFUOVd5Z3JzSU5LajhBd1Y2UFB6cDdj?=
 =?iso-2022-jp?B?REQ0SWpHSUljTUw3RU9qUEFubGZZSXZ4Sk9SU1ZyWlY1VzRMcDdjcmd1?=
 =?iso-2022-jp?B?U2U4VkJGNkZFQm15d0VPRXlWNHp3VmJnKzNaZHNQbEkzRTZvYkw2R2ND?=
 =?iso-2022-jp?B?eThwM0JpZ0lDekU0NEpsaWJzZWY1eStZUUtUUGwzOU8rd1IxZTd5WDYy?=
 =?iso-2022-jp?B?ZUF6aFZFWW83N09JUUlIaHpvZjA5dVU5Y1FidUpEcWhPblJTWndTYU5n?=
 =?iso-2022-jp?B?ZFFWZE43SDVVWnFZZHIreTZtSXcrbXVqeHRDWU5GQTVIdDdkNEtoOGlu?=
 =?iso-2022-jp?B?bEh6OGFDTXk1ajFjNUZPYjN6bHdTakFMbmhMS1RLSTJINlZnWWR1UFd0?=
 =?iso-2022-jp?B?Um1TeE5nYnA3a04xRUk0TTdKdEk0VmlFTHNpQUZBMUVQZVBvQkF0ZmVr?=
 =?iso-2022-jp?B?RHBiM3lFNHVnOGZmaTJiTHRtVUZXdVlXbkV0WW1zVFYvMXY5Z25KS3hX?=
 =?iso-2022-jp?B?UzJmb214TWpkc3JvdzFHeHVTZkU0cnlVUDliZlo5cU5FNmF6Y3h5Sk1n?=
 =?iso-2022-jp?B?TWladmp6NWErOWZWNEU2U0dVdlhVUkMrKzdqWlpOWTdyYkhxa0R3S0pS?=
 =?iso-2022-jp?B?QUlOMUNPakRsL0plREMvczB1TCtQaTdtQXBvaXpUWXFma1d1NnR3a28v?=
 =?iso-2022-jp?B?UFBYOHFGeksrVVdaT0Excm5nRFNaZjNnNDVoZVNWdHNqdTJMaCtxY1dI?=
 =?iso-2022-jp?B?SHdLWEhhKzFKdnA3Y3hrV255OWppRDMwYldzVTZ6eDY3b0Y0bFVSaVhm?=
 =?iso-2022-jp?B?WlhNdFVlU0swaVRGYmJJeHJxUnFsN2k5c3d2V2xpZEtPeXEwdFQzZEE3?=
 =?iso-2022-jp?B?OTlXcUJNSzF2cVAwTmVOU2ZsODZPWmhieTZReklyQmhjVk5Zc1E1VU5v?=
 =?iso-2022-jp?B?M0hSUElhdDlWK1ZmVjhFZjRSUFI5NnpzUnBpeE8xNWdKcm9yMjVaMEMv?=
 =?iso-2022-jp?B?L1hKOU5RVHNJNENPZUpNc3UvUThFVFNxejgxaHZWeGpUMDBTSlRsYklw?=
 =?iso-2022-jp?B?dmV6ZkR5ZCt0VjFQajVobEZQUmdCa0NOc1cvTTFWRE1QZWJsRjBlckhL?=
 =?iso-2022-jp?B?WC95N3h4OEZMSGtDeW5JQUUzczNqaGpGM3B1TjhGY1ZwMk82Nlp2TFdN?=
 =?iso-2022-jp?B?NXV2c2x2SmNlWDdIMlFHTndEWWJLSVNwM0dkWFMzVzExV0VndDJGSjFL?=
 =?iso-2022-jp?B?ZXY2WW1oeVZ3ZjN0eTZCNmlZZG9wRWVzK2dtcElWWjRXUGhrdEc2WkJ6?=
 =?iso-2022-jp?B?Qm5aYkpSckQyajEwdEp4d1FweUtzazJ3Q01UdDJ0Ymxqb2pORnVrRi9I?=
 =?iso-2022-jp?B?Y1NnVnZLcWdLS2xXTFB1K2M5dEEyQlVXMGZ4ZWV0THhZZ3NTR3FVbklT?=
 =?iso-2022-jp?B?TGQyRmlVVHByTFdodk13U3d4Nm5pZlZkeFVhc1huZ3FtUGY2eFFpeGJS?=
 =?iso-2022-jp?B?VHhlaXkzRHBQR0k3eTNqY0J0RmlSOTBxVUFkQXRwNW11YytpNzlxZkc1?=
 =?iso-2022-jp?B?enhtbmR2QXQzTkE5cjNTdmhQY2JHVFRNLzAxMWI0K2xyZEprRlRONW84?=
 =?iso-2022-jp?B?ZmtrNWtFVWNZak9NUUw3V0JxMkF6RXNMQkxIL09BUHhCSHhLWDYvdkxi?=
 =?iso-2022-jp?B?NGxyYkVCSFhoczREOHQvR3NBUFRId1BxbFZWcFNhSUdwOXZhR3NYelFO?=
 =?iso-2022-jp?B?TEczZzFHeTA0TTRjdEtwRWNlZEJ1Y1I4WS8xVTl6dnhaK1luZXFJRE9h?=
 =?iso-2022-jp?B?OUg2UzRxbTQ3K3pNTTlMc05oZWgzYU9rRkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3945898f-b8f1-4bb7-18b7-08dd19c0e9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:50:50.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw9F7xoklbqzCnJSw8tJl6D4vRKgVZcKRu6DrE1vPVJ1pFltUEo3PM4WFbbXbU4Lz4W2DTjwDmG3C2NoggnOJVJvtdWGXhwAqrl8UvM4z33J4PmkLNc728xa0vR/+7eJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 08:51:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17398

Hi all,

CIP kernel team has released Linux kernel v5.10.230-cip55 and v6.1.119-cip3=
3.
The linux-5.10.y-cip tree has been updated base version from v5.10.229 to v=
5.10.230.
And the linux-6.1.y-cip tree has been updated base version from v6.1.118 to=
 v6.1.119.
This update includess fixes for renesas-rpc-if (Flash controller).

You can get this release via the git tree at:

  v5.10.230-cip55:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      7c675584493ff0915db171992bb3f9a88c45b57d
    fixed CVEs:
      CVE-2021-47195: spi: fix use-after-free of the add_lock mutex
      CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on SPI =
buses
      CVE-2024-38538: net: bridge: xmit: make sure we have at least eth hea=
der len bytes
      CVE-2024-41080: io_uring: fix possible deadlock in io_register_iowq_m=
ax_workers()
      CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()
      CVE-2024-50264: vsock/virtio: Initialization of the dangling pointer =
occurring in vsk->trans
      CVE-2024-50265: ocfs2: remove entry once instead of null-ptr-derefere=
nce in ocfs2_xa_remove()
      CVE-2024-50267: USB: serial: io_edgeport: fix use after free in debug=
 printk
      CVE-2024-50268: usb: typec: fix potential out of bounds in ucsi_ccg_u=
pdate_set_new_cam_cmd()
      CVE-2024-50269: usb: musb: sunxi: Fix accessing an released usb phy
      CVE-2024-50273: btrfs: reinitialize delayed ref list after deleting i=
t from the list
      CVE-2024-50278: dm cache: fix potential out-of-bounds access on the f=
irst resume
      CVE-2024-50279: dm cache: fix out-of-bounds access to the dirty bitse=
t when resizing
      CVE-2024-50282: drm/amdgpu: add missing size check in amdgpu_debugfs_=
gprwave_read()
      CVE-2024-50287: media: v4l2-tpg: prevent the risk of a division by ze=
ro
      CVE-2024-50290: media: cx24116: prevent overflows on SNR calculus
      CVE-2024-50292: ASoC: stm32: spdifrx: fix dma channel release in stm3=
2_spdifrx_remove
      CVE-2024-50295: net: arc: fix the device for dma_map_single/dma_unmap=
_single
      CVE-2024-50296: net: hns3: fix kernel crash when uninstalling driver
      CVE-2024-50299: sctp: properly validate chunk size in sctp_sf_ootb()
      CVE-2024-50301: security/keys: fix slab-out-of-bounds in key_task_per=
mission
      CVE-2024-50302: HID: core: zero-initialize the report buffer
      CVE-2024-53052: io_uring/rw: fix missing NOWAIT check for O_DIRECT st=
art write
      CVE-2024-53060: drm/amdgpu: prevent NULL pointer dereference if ATIF =
is not supported
      CVE-2024-53061: media: s5p-jpeg: prevent buffer overflows
      CVE-2024-53063: media: dvbdev: prevent the risk of out of memory acce=
ss
      CVE-2024-53066: nfs: Fix KMSAN warning in decode_getfattr_attrs()
      CVE-2024-53101: fs: Fix uninitialized value issue in from_kuid and fr=
om_kgid
      CVE-2024-53103: hv_sock: Initializing vsk->trans to NULL to prevent a=
 dangling pointer
      CVE-2024-53104: media: uvcvideo: Skip parsing frames of type UVC_VS_U=
NDEFINED in uvc_parse_format
    added commits:
      CIP: Bump version suffix to -cip55 after merge from stable
      arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support
      arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
      arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table f=
or spi-nor flash
      arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
      memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOV=
F pins
      memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
      spi: rpc-if: Add missing MODULE_DEVICE_TABLE
      spi: rpc-if: differentiate between unsupported and invalid requests
      mtd: spi-nor: atmel: Add support for AT25QL128A serial NOR flash

  v6.1.119-cip33:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      0c42523c715687c74002f687ae904143d259b7c6
    fixed CVEs:
      CVE-2022-45888: char: xillybus: Fix use-after-free in xillyusb_open()
      CVE-2023-52812: drm/amd: check num of link levels when update pcie pa=
ram
      CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset=
 is invalid
      CVE-2024-26954: ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf=
16()
      CVE-2024-35964: Bluetooth: ISO: Fix not validating setsockopt user in=
put
      CVE-2024-36244: net/sched: taprio: extend minimum interval restrictio=
n to entire cycle too
      CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring =
'power' and 'submit_queues'
      CVE-2024-36915: nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
      CVE-2024-36923: fs/9p: fix uninitialized values during inode evict
      CVE-2024-38553: net: fec: remove .ndo_poll_controller to avoid deadlo=
cks
      CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service
      CVE-2024-44949: parisc: fix a possible DMA corruption
      CVE-2024-49974: NFSD: Limit the number of concurrent async COPY opera=
tions
      CVE-2024-50241: NFSD: Initialize struct nfsd4_copy earlier
      CVE-2024-50242: fs/ntfs3: Additional check in ntfs_file_release
      CVE-2024-53073: NFSD: Never decrement pending_async_copies on error
      CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour
      CVE-2024-53106: ima: fix buffer overrun in ima_eventdigest_init_commo=
n
      CVE-2024-53110: vp_vdpa: fix id_table array not null terminated error
      CVE-2024-53112: ocfs2: uncache inode which has failed entering the gr=
oup
      CVE-2024-53113: mm: fix NULL pointer dereference in alloc_pages_bulk_=
noprof
      CVE-2024-53119: virtio/vsock: Fix accept_queue memory leak
      CVE-2024-53120: net/mlx5e: CT: Fix null-ptr-deref in add rule err flo=
w
      CVE-2024-53121: net/mlx5: fs, lock FTE when checking if active
      CVE-2024-53122: mptcp: cope racing subflow creation in mptcp_rcv_spac=
e_adjust
      CVE-2024-53123: mptcp: error out earlier on disconnect
      CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages b=
igger than 4K"
      CVE-2024-53129: drm/rockchip: vop: Fix a dereferenced before check wa=
rning
      CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer trac=
epoint
      CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer trac=
epoint
      CVE-2024-53135: KVM: VMX: Bury Intel PT virtualization (guest/host mo=
de) behind CONFIG_BROKEN
      CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr=
()"
      CVE-2024-53138: net/mlx5e: kTLS, Fix incorrect page refcounting
      CVE-2024-53140: netlink: terminate outstanding dump on socket close
    added commits:
      CIP: Bump version suffix to -cip33 after merge from stable
      arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support
      arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table f=
or spi-nor flash
      arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
      arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
      memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOV=
F pins
      memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
      memory: renesas-rpc-if: Improve Runtime PM handling
      memory: renesas-rpc-if: Remove redundant division of dummy
      memory: renesas-rpc-if: Always use dev in rpcif_probe()
      spi: rpc-if: Add missing MODULE_DEVICE_TABLE
      spi: rpc-if: differentiate between unsupported and invalid requests
      mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
      mtd: spi-nor: add generic flash driver
      mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
      mtd: spi-nor: move function declaration out of sfdp.h
      mtd: spi-nor: remember full JEDEC flash ID
      mtd: spi-nor: sysfs: hide manufacturer if it is not set

Best regards,
   Nobuhiro



