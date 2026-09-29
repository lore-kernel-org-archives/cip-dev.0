Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F354CA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 11:55:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6090.1790682953404408798
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 04:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=bWLyZ2JW;
 spf=pass (domain: renesas.com, ip: 40.107.74.33, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2Vxq6YKQNnXNVHAp1EkEMWLoZ0oir6t5DdzLbRVzXoqud4CQ2GMA8xWAaYDLz4OnFozi9V47EuRhE7XYJiBDghiunbh2VL9cLiBtVTVyr2Vy7q4sRNd01k42RAIg98cwyTxVAsgQl4TeJctaAw1wmCQ7XCtDwv/oXIsx+3a+TnGy1ImNglKxqsrZNo4WWnmg2RkOL5tSSMU0itApaHNLK6IpNpzUMyaJygZr/I1xiDJYdlP4ot+0y30mWZ1BqzWMbe5yuvn75Paqt8DsZa2Lk2/Z4+g4BRqPYXq3dnjNHQ4DCz3hdPVLm0NGMTQYqnMGoiUdeBN4IL1464guXu2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRQ9vMdUDLULOLhaToYVzJFubBBrFh0O6EbDyi++Jrg=;
 b=r31s715PNCkZ7N0rHehPpAwteFtb4ZB/nojf0i7DUP2noFkYcHYdW8a3IFAb1v+sbeX4FGzIUZQXO1ZHwo+eOzXtL4GthDKG1umPkb+Z7dXNuwGz9MLWArExOv9TTakegP4KvPvywApUbTYK0Ao6lrRzc5Gt7dDNkScE+Lu1M23cEA8l48bGKzFZxhP3Lw8QU6bU3iFJMKKQW6awiIak99IVAefpWnXQupjS6RbAx0Wd0xWfJABy+MaoGTniuSnyWnw+fAw6EaqIHk/4NT8sSdPQV+xpU2mLGIAmHv9n7bjkne5zg7dy3Nn/KoHK0zeONtj6sMNUCJiniitNpn6Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRQ9vMdUDLULOLhaToYVzJFubBBrFh0O6EbDyi++Jrg=;
 b=bWLyZ2JWUB7mEq8nfsH83VHbuiPC/oSGbd0RYgWlPv5lYGfncBAufQU/KMc/fYUc9qlueee9P3jfNvQFkqhUUh998BgY+1GxaNGKzKac58BNkZyWCgeuE8Y46/2gGjZ5Yh+zcVV5N9bpac7+RPZNPbpgwjk/3aTz91DoSvMb86M=
Received: from OS3PR01MB9738.jpnprd01.prod.outlook.com (2603:1096:604:1ec::10)
 by TYYPR01MB14132.jpnprd01.prod.outlook.com (2603:1096:405:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:55:48 +0000
Received: from OS3PR01MB9738.jpnprd01.prod.outlook.com
 ([fe80::8bc7:407c:4c32:df71]) by OS3PR01MB9738.jpnprd01.prod.outlook.com
 ([fe80::8bc7:407c:4c32:df71%6]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 11:55:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>, uli
	<uli@fpond.eu>, Arisu Tachibana <arisu.tachibana@miraclelinux.com>, Masami
 Ichikawa <masami.ichikawa@miraclelinux.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: CIP kernel lunch
Thread-Topic: CIP kernel lunch
Thread-Index: AQHdUAkbZCJOVxJ/E0Obr23wU3hhfLblcrkw
Date: Tue, 29 Sep 2026 11:55:48 +0000
Message-ID: 
 <OS3PR01MB9738E9D0D4A0C5B0A1C65D7EB78C2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
In-Reply-To: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9738:EE_|TYYPR01MB14132:EE_
x-ms-office365-filtering-correlation-id: bfe9add3-ba62-4146-af68-08df1e209a01
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: 
 vodVIrgdPyb8N6hJ4ibrbgZKYP0ZfauRfNh+LDHY60pT8eEddsRMrCswY95NBL7ND4g15vG0m5ER+Y9is7HddqcuD9+nsRIZ8isB9Y1xxTSoC6wxUnXcrBGZb7KvzdOYJuz4a/Hu0LWEyMsrJ2KLKEMNmU1M8CqmcC+a+z8GmQ8bTV0/6BdXHMTH25OTowj+fdX31RXgGg83vPw/qETrwffwjLf8N2kgqRK0E1joMu2/XoSGp3QXCYuhQWu9GisVRxsCzGJtRYjpnw9zbXDRX9aXVaUIZ4EWQfqpmGWRmbUbiw/LPmJ0va13FnBjKoABLs36fCS3++APKRTrhINJq13ZVEELWx8JqJHP4yenQgS26IZHdsa4s0a1FYrQCx0nVl7etupDfYpfL83XMNX07ECw9yyv3JuyTFogwrDUPlni1BoZ8l1P6FqwDY6Cy58nYtsA7bltQ+Jk/rjsyOj+QMPU0W1iGvr7Cbwss6Tt7ciDuiPgKiFXFleGTpFByipswWUkHqkWe2NXQNGhIB4/pL57W1ZCi1QSRPbqJYDvc5yH2vS49LfpqezZ4xES6zX6g9MhzF/FT65cqx/Q2ksCA0z0Owrs+jU9Y5BnViNBs1W/w42akk3FipoWjYTnG6Qe9SIoOJ0WTkNLG8yuCJ03Vfn8NoIMqVYQofUzFuslLk6dDtEivzdrO4LYFBtEPNoxDxM8/OOF9pHFNOS1HzidgDOtMqt/q3kc219qDqAjTD4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9738.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b2I5VjFZTzdSNGZIYkdmYVN2MjJOU3FBZmRheENVSEpaN1FwSkJxOEJCalp1?=
 =?utf-8?B?V0V1VFZWL3FuZE9UQ2pMZVFMTVBJMnAzUFBUSXJUM3QzQmlJMjAzelNKSnB6?=
 =?utf-8?B?MmcvZTVoWTA1dzlUcnpQZHN2WWVLTHVnRDBHS3hqTWhvcS9FeGxkY2Nva1JJ?=
 =?utf-8?B?NkJKNU1UakhjYS9Wd25zd3FnSGQwdUxWOG5KeVhEa0s5ZDBkRHhoelp3ZXRs?=
 =?utf-8?B?UGZuZzNzOFlPajZodEUwbHlPRDQ2TnNsREVRUGZiS3A3MlF6RTlsR2xYU2xP?=
 =?utf-8?B?bXZDNVBtV3R1TjRxNG1YTHAvQ1NTczI3NUxDRGVFdk9vMk5Bb2ZzNlAreFk5?=
 =?utf-8?B?WHBKbFdZcDB0QW5sSlAzWXBGYnpIUVdPdnlaQm8rbk9kOXdaSFpDbjJSdzMy?=
 =?utf-8?B?N0JMZE0zeXNqY003N1pYOFFYWG5ZTDBVd0xnV3Bnd3FBR2ZRNTA0NHpZUzJL?=
 =?utf-8?B?N2MxaldUTzRZVFljUEVzRFR1dVJKV0dYVXFSVzM4MDFtWVZJbmhLaGpJSktP?=
 =?utf-8?B?cUVncjc3RjdGdW5JblhUMTgrSFZITlpIZEdBYTRXQzJxaThPNWZoRHgwSVRE?=
 =?utf-8?B?ZE5FNytRMm95WldQSjJNUHdZSWxnNzdTNCtZR0xYLzBWb0NudWpPTWZhY00z?=
 =?utf-8?B?Qi9xSS90T25WVzl1ODl1SEMrTjAzN0FNMmxsSDhGWGpSWVJhdWgzMGVYbUE0?=
 =?utf-8?B?NmdnaUtxUFAvNGJUTXdyclRLWUVFOVQyU29ObU5wMEI5MkVmYmxHOHpXVjl3?=
 =?utf-8?B?bXk4ai83Ukwwc3k0cFpzZUUxYStTdUUrZ1J4NDVmWm9NWFBCbmxHbk1QbTF1?=
 =?utf-8?B?MWVzczQzWnZ4eDA4dnlHL3NtelB2SnRLUm1oc3hBQnhYUlNvVHlSMks0WGYr?=
 =?utf-8?B?djZsdU4xNEhWQmJTajU1aGsvajRhbmZlWnJtZXpsOFg5d1haRThTaXVxYnZh?=
 =?utf-8?B?d1RydmpGc1BJRC9SbFRmWlA0ejZPaUpBZ00zdjRoZ3NvV3lxcVhjOU4waHhH?=
 =?utf-8?B?a3oxZ0NNUE1yWHk3bUdoUmlPaTBXc2prdURURDdKY0VLLzNZMXdHeDExWFYr?=
 =?utf-8?B?Rm9CVjBDL0d2ZTFkS25WYXhTNi9tdEo3MnBYbjVnRXFDaVkwSTZjRzB6djd1?=
 =?utf-8?B?SFhwWEphSlA0QUFBeDVIczJCcjZiZDJMNHkrU0FZSmV0WjdPYUliSS9MYXR3?=
 =?utf-8?B?MzgzbUV6NFZFY1BVMVREbENJU3RwQS9vV0pSNVY5UExncEEwM0dEQVB6eUJn?=
 =?utf-8?B?SEF4UTVKeHptNlFCQ1JlaHZOOTVGbm1BUklRN3NWWVJzalo5V3ZValQ3NUgr?=
 =?utf-8?B?TDJyTzZOWDJKTnZWd2t3S2dubjFrdTdjcE1sM0Q0eHVjenJEb0pYd2FFdHJS?=
 =?utf-8?B?NVlTSlBlU01SNjl3b3lDNFNmZFBua2wyZnQrZ0RYTTY4Nnl3QVhRL2VKODg0?=
 =?utf-8?B?dmwvSUJveHlJNHFTdTBkR2l4WFdOclhRM05IQ25ia1VxOVIzeUlFa3BnNndp?=
 =?utf-8?B?blJ1N3ZldHpxejk0ZlhvZmc0enVCYTRZbGFQOTlCNnc1MUpTa1h5YTl0R0Ni?=
 =?utf-8?B?UUZmODNuNS9nb3VGbUtRZ21ZYVBlYTMxWEl4Vm1pMXFFY0NJSnZjNERaYkh1?=
 =?utf-8?B?SjZxQ3NRVHRsM0tpZW45S1E1Nk51ZlFmeGhuZXB4QTJvTjVpQkgxbVRKOUF1?=
 =?utf-8?B?aG5Ua3JBL0lGRzFVNC9heUc4SGVkaGZFbG93Z3QyVGhCNWh1aHZNUG54WEVF?=
 =?utf-8?B?YlpyRm8reUExZm90Unp6cHpmdDJ5aGNFQnoveThpeVBRRE5Vd0RxTUlLay8x?=
 =?utf-8?B?T2dlN3BMYXRtMWdrWFVza21tbkxFcFJpOTN1TEJrY0E0QmJkWk9mYnJHWER4?=
 =?utf-8?B?RFBGOXFXVzhpdm02dDJicjY1RGxNRkE2Z2tMeU1OZGI0Z2I3VjNXYSs1MEY1?=
 =?utf-8?B?V05MMW9kWi9TajF3UVgwZ2I5dnlRUWtoNHhmaHozdjd2Qk9kdWpySm4rcW9Y?=
 =?utf-8?B?OHM5NEdSU2drU0ZRSjVvcjdzendZVSs1YXRnZmM4U0owTG5aQm4wOWhIQUs1?=
 =?utf-8?B?RUc0NGpmVHVWcHhWcWFheTNtemUrbHVkWVRMMHZNb2xwdUMrVHJwR3dsK2tn?=
 =?utf-8?B?WEcrOUV3Y25uNE1KeEZZTk1Ua0tGdGRLOUZqUk10dXNEVlZKRjZCSk9JMGFj?=
 =?utf-8?B?TXFBUkR5ZU9PTXZhZFI1dXJ6cE56TzBTZzI3WFlTN2ZBTnc2S0JFYXhiMGgv?=
 =?utf-8?B?QnlrQ0hGTFFSVS9kNTZnMUFUOFBKaktJSWJEWTcxbEV2QU83MFo3RzRVeFF1?=
 =?utf-8?B?NWVjUmQxVTBrTmFWS0xsQmJpakgrR25vck1UNlExRU50eGoxd3N1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9738.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe9add3-ba62-4146-af68-08df1e209a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 11:55:48.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaW8xir2Mwp1AWSXbxIu36dnY17ps1xfEUlukXaOUyz01ue9zdonIISant0npF++s0na5FQMArOubFc4GaySOxGM23N1EhylLh6uSl1oiVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2026 11:55:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24375

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiAyOSBT
ZXB0ZW1iZXIgMjAyNiAxMjo1Mw0KPiANCj4gSGkgYWxsLCBDSVAga2VybmVsIFdHIG1lbWJlcnMg
YW5kIGJleW9uZCwNCj4gDQo+IGlmIHlvdXIgYXJlIGF0dGVuZGluZyBPU1MgUHJhZ3VlOiBIb3cg
YWJvdXQgaGF2aW5nIGx1bmNoIHRvZ2V0aGVyIG9uDQo+IFRodXJzZGF5IChPY3QgOCwgMTI6MjAp
IGFuZCBjaGF0dGluZyBhYm91dCBDSVAga2VybmVsIHRvcGljcyBhIHRoaXMNCj4gY2hhbmNlPw0K
DQpTb3VuZHMgZ29vZCB0byBtZS4gSSdsbCBrZWVwIGl0IGZyZWUuDQoNClRoYW5rcywgQ2hyaXMN
Cg==

