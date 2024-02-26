Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6347BC48BF6
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 11:47:19 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.64])
 by mx.groups.io with SMTP id smtpd.web11.18338.1708948029036656143
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Feb 2024 03:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=V+7Jdocb;
 spf=pass (domain: renesas.com, ip: 40.107.113.64, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3dZlA8RVMrqnWLs+e0kkUeg/exLwDQsUkpWk1l3QKX4aIJtDXgySKBRwg/j+zLw2D8exPhg/Ks+exqN+Wqttww7563bBBPl8Ta7WH7jj0f54JU/E84ifrHhdlJQu7TeOL7+FD8TrNe2h0RE/PRu5zCVN5vYd1HiwtGhxicwe+bEu/FYDbr1hfC+nwf57EtssthlbizIBzRDmPdls3BD6rYb3LUqpy/En03/3tjADCtI52lE7maByNzhyg1rNYSksY1drn+pqDgARaS69LL0kd+cO0cLxG8f1euW7z5w4t2cw/ntTB4tMHbeh4sD+UkOxK5xejLe31tUgc7pfzACwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaBNHQmDT46Uun+Zgvq7Elm1o1y5wwAtJmMa3ZL3AW0=;
 b=j7oArurH4Zj2L9ugi7xqHY/FxRDdWfwBg3hVBU9ofKMevefj7BufaQNb+sqKFJ1zXwrLTAYgk7CmOemiCnZI9cUTA7HAlIyJ4GMRTdUSJX+5GAgLuMqI7ihfMKKOoOj5BT3ciKAnc1hrIF0B6+gLv5sQqfu5EKDc3YhSdkCFsmfPBnJ6N9XxgDPB2hivzd+/BgfHBJKGac1JYS6EtOcHD0rCmAfFVlEvTH4u+ZMA1JM/xbb3o99HBjo0jWKR++/eTYUL73DlcWEO5VTH398eypshuBmJrUv6gMG99AYeOAQBECWJjWd7FxULtBYNB3fhj48eifnqMmkF5c97lUTOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaBNHQmDT46Uun+Zgvq7Elm1o1y5wwAtJmMa3ZL3AW0=;
 b=V+7Jdocb6qATkrYQMTMDBQDhjJIc3pyNHhyZQz3x7tE/H8tlmthposE91EQc/rWpNUFI6JiKgICvm3mC+BrGaTwNR9NbaEXEKMRLSwfTulaeDb5kxLVrAK67Lhpb3vo8Z+/gCBbTZIJP7Vnn5hlf1Mnv6R1upOo+WR7Ke9PyILc=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OSZPR01MB8153.jpnprd01.prod.outlook.com (2603:1096:604:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Mon, 26 Feb
 2024 11:47:04 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 11:47:04 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: 
 AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoAAT66ioAD7Ws/gAHPcRqAAAY+0YAD4uywgAAE7SGA=
Date: Mon, 26 Feb 2024 11:47:04 +0000
Message-ID: 
 <TYWPR01MB11862164EF6555E3A1ED9DB94B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB61034E05C271281A1CD2FE78C2512@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862816FF930969C5B302BF4B7572@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610352AB4942C739EFFB9C6AC2572@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB61033585CAD035FB994A609DC25A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61033585CAD035FB994A609DC25A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OSZPR01MB8153:EE_
x-ms-office365-filtering-correlation-id: 0bcfe17d-f610-4fac-4184-08dc36c0a6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XYDpyYjz4iEwShVtsbRLZNOh8MO0OQ4WnWCCq95iR1DayVI/hPKf9OGqfdJSBm3OWMDasxOtVgYobT4lvMPmwJMoJt32Vd/2DOPTt0gqQVTokWjdbh3iWrN3zDsZHo+vjjpH8M8rYjiMIihYoBTHMRAyCm8w8Q0md/lBldUZQCYm3TUrdkTbQuwK+QFlyihlmaWDApMIk3d2I56vOTLva8rJUs5vbQubJLNQses8jQJ7Rsq5e20E8ia8w8fMbwa/wrXui/wBrESQYtkbdV2i3GgKurSYyoLY5gxrkNJUbSIMqoE7cwya8sOmrEaAV0ab8lAqG94k5QmtdXi9BzXQRT5xkBDviad4SVzts7iYkP0rcsD/DuDnHiLZzqIZrDKH9j8Ew6uqG2KekYsgKjpCO/XQIaxisI1GwKWxtFP5mO/WSYi1+XtvMNUlso6Qxddi6tQldKF9j+B2gbwhkXw0EnfQp7MwvUZb/r9hnlmwguRZZiBtv6Y8cMxNq4MhbWjAxM2GK/GWJb1NoDrMw2gX11VE3YA03Ph+PKkP8Z0Ioykns0KggbPH9UhU36w/FR2u20Eow96abToT/u9GTjcC/eYxsTqqA0X21bFaQ3DUM4vLRaIEs1PdPiyYw+wXr27P6TMBdJB8Wk2FfHL+AwD6R5DAzFE8MIMZzFwWP5a1JWYzM5UKSsNIFC8sgGG+7SQiMrTDS3JNh3ofDaaLCzkvcg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?a0VMQkhxVWFoajdreW9paTZEK25sY1dhalEvYm9tczNVWTVENkVt?=
 =?ks_c_5601-1987?B?K256dzRDRDZDQnVvRVNsaEgxMTJxUmoxcDdxT2pFQXdHL2RrWmFi?=
 =?ks_c_5601-1987?B?ZjQzVTdOWExOcVdMSldLYXZsYUxSU0pTZHUvS3NGUGEyV0ZpTGNJ?=
 =?ks_c_5601-1987?B?aWJHd0hCcWxuQjh1SkhmZ1JtSkVpL0dHN2d2YVhKQ3pTMSt3R2Zn?=
 =?ks_c_5601-1987?B?OEdYNEdPN1pGamF1M2N6bEFBL0EwVTVHSjFiQzJ6cG9sQkJIWE9q?=
 =?ks_c_5601-1987?B?TU9YSjNJWUkzUG53ekxvV0tEYkVVUVdpYUM2a0hPaDVQQTk5bDhk?=
 =?ks_c_5601-1987?B?T0RxMVdMYlhDSFc5WHZleWhJd3RJME9UeXQ0enp6WVhKUXQ0M0cx?=
 =?ks_c_5601-1987?B?dUdtckZLVjVwd3hxLy80dzQ4UW41SCt0dU9xemtrZXFCV2FVSUNG?=
 =?ks_c_5601-1987?B?ZmpTcEFrY3NwTVlQWmdudW1GV0lYUEozcHZ6SnhkNU1FbFJiZzRj?=
 =?ks_c_5601-1987?B?Smk0bVBHdWpERi8yQ0R0STJpayt4dUZyMitja2pkOExqNTREcTFJ?=
 =?ks_c_5601-1987?B?T2dTU0JxWjRaNCsvYllCaEZYY2VLRDR4cjNvV1F5ckNiM1RCV2pr?=
 =?ks_c_5601-1987?B?Y2h1ZG13STd2d284Y2l4SU1rUERQcjNDeWZaU2lCTk05enFtUGZD?=
 =?ks_c_5601-1987?B?L2gzYm1GODNadGlveHYrWTgwcDVqbzRiWDY2aElhNWU2NUp4Q2R0?=
 =?ks_c_5601-1987?B?eWcycHdLdzk4VUtZMStIWDlaVFpGa0czcXM3MVVBbExKb1ZDU24w?=
 =?ks_c_5601-1987?B?V2ppUXlIM1J6WHpzSmpDdkp3YmFKWUpxS0ZjK2hGejFRaDhvSlZP?=
 =?ks_c_5601-1987?B?a3d6WEVhN2FGMFg1T2JPbFlvYXN1aVRQTUV4WDdZa0FoYUdnZk1w?=
 =?ks_c_5601-1987?B?a2pIY3RocGJRME5zUFJNaGJMQUdzV2JCQXNUeTdHbS9iY1RlZ2xH?=
 =?ks_c_5601-1987?B?RGZ0SlVQU2kyWGhGdEgxeGYzaW1SZlpCY2d2ZERvb3VMeG15bmJ1?=
 =?ks_c_5601-1987?B?L0dkL3lSVzJrN0MzWkRUU2JqUXR1Z0NXVnluSzFId2k4Y1ZLYUpv?=
 =?ks_c_5601-1987?B?WDRMd2Z4bi9uVnVONWlRem44blVySElteXlCUGFoWTBwc1JMTUl2?=
 =?ks_c_5601-1987?B?MFFQWlV3c1E2TWhCd0RHZ3lnT1cvVWdaOGE0NzZDN0tqdHdkdldW?=
 =?ks_c_5601-1987?B?MHBvWklYOGhnaVczeVdmOWhQdHFDYVpoZlB5MW9lN1lEYkJMZGxR?=
 =?ks_c_5601-1987?B?SlduVWZDeEpFOEVLS1lURnJLQTQ5VDJmaEFZdWFXZGZnU3N6N3NQ?=
 =?ks_c_5601-1987?B?TEFpMW41Z0g1TzdtUmNBVlh4UW9xVmovSXU5QmVOTmdkeFd6aU5p?=
 =?ks_c_5601-1987?B?L0VDTGV5cEJKZW5HV1ZrbHlENmNseFJScEtHcjVOTWJaTGVXVFNK?=
 =?ks_c_5601-1987?B?Y0xmUjQza1VmWStTY0JIb1VQcm1nSHY4L0pXZVhZby85RWNkdkJv?=
 =?ks_c_5601-1987?B?T0F3OUlzQVg2SWJMdGluUVlNNkFMNnZ1ZEZwNnJuSi9zWHc5eHk1?=
 =?ks_c_5601-1987?B?YVlBM3dpZnNMTnFQNHZrQ2pucVFlMjlWb01jeExISStwZkZaaG5I?=
 =?ks_c_5601-1987?B?MEV3dTA3MlhXbnVqS3dPZDRXSXZWUDExeVRLeTBBVDZVa2wxaWlu?=
 =?ks_c_5601-1987?B?K0xqNjZYSmNhYk16dGVDYzNUUitBb1VUUVBqYVpSbk9iS0JUam5H?=
 =?ks_c_5601-1987?B?M3YySmo2UndpK3lvaWI2Wkx4QU5nSTBnU3J5TUpZZVRzQmlBbjJy?=
 =?ks_c_5601-1987?B?RFhmQmZ0MlR6MWluRVpKaC9YdzJKUmI4VXJwOVpqWkxzNzNmWkVY?=
 =?ks_c_5601-1987?B?UDczYUdZQnVMZFRSTnZZL2w0R2k3SEp0ckcvVjhubXhpM3BWWDFT?=
 =?ks_c_5601-1987?B?elovOFdKL3dxdjdaOEFXRlQya1FjWnNCbkhOZ3B1amsrWmVKcHBZ?=
 =?ks_c_5601-1987?B?OUFOblRiemI4Nnc0b0xMNnV4Y0s3MG1yZDVXRXRrRlFidUZRazVV?=
 =?ks_c_5601-1987?B?Z1JRZlBzUHJ5ajZpVnNwdE9YY3FPbThsbTJ0bHZaL2dlTThlNEJH?=
 =?ks_c_5601-1987?B?ZDV6VkRXeHY4OHZmOVZ0Y2M1T2M2Qlo3aW4rV1Q4NXR5QjRpcXVj?=
 =?ks_c_5601-1987?B?S3dHd1NCSWIzeVdhUkExUG5GWGhVeHEvNGJPcGorS3h3WmFoK0t3?=
 =?ks_c_5601-1987?B?MG1PQVVFVi9FOUlEVnZzblJVMkpkMlY0K1R0enh2cGcxVEhQZTBU?=
 =?ks_c_5601-1987?B?R21XdDQxRk5NRjRxUHNTaGdVY1JEUzFZQjVNd1BZa3pENk1LcGhy?=
 =?ks_c_5601-1987?B?bFZ5K2NzaFhpcVVNSlBVUmNTYmRscjdaZEFMMG44QStlYTBxZHhW?=
 =?ks_c_5601-1987?B?b3Zoc0kwKzFJN1hOT3hCeW4yRUVueEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB11862164EF6555E3A1ED9DB94B75A2TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcfe17d-f610-4fac-4184-08dc36c0a6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 11:47:04.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYE0zA4CPujY/Uh+Cz/SG1Zhqf6l8u2hviIi2RMcRupjn/qu5pKzpHp6S5yV7KvSrVwY+7G1bsYDEEsrLk4yFbFEC1IZASQMBNv2g7sAywQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8153
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 11:47:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15095

--_000_TYWPR01MB11862164EF6555E3A1ED9DB94B75A2TYWPR01MB11862jp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gU2FpLA0KDQpJIGhhdmUgdGFnZ2VkIHFlbXUtcmVuZXNhcy0wMSB3aXRoIHRoZSChsHN3
dHBtLWpvYnOhsSB0YWc6IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvZGV2
aWNlL3FlbXUtcmVuZXNhcy0wMQ0KDQpMZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnl0aGluZyBJ
IGNoYW5nZSBmb3IgeW91Lg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCkZyb206IFNhaS5TYXRo
dWpvZGFAdG9zaGliYS10c2lwLmNvbSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0K
U2VudDogTW9uZGF5LCBGZWJydWFyeSAyNiwgMjAyNCAxMTozMiBBTQ0KVG86IENocmlzIFBhdGVy
c29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc7IGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA7IGRpbmVzaC5rdW1h
ckB0b3NoaWJhLXRzaXAuY29tDQpTdWJqZWN0OiBSRTogTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9u
cyAoIHNvZnR3YXJlIHVwZGF0ZSwgc2VjdXJlIGJvb3QgYW5kIElFQyBsYXllciB0ZXN0aW5nICkN
Cg0KSGkgQ2hyaXMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLg0KDQpZb3UgbWFkZSBkZXZp
Y2UgZGljdGlvbmFyeSByZWxhdGVkIGNoYW5nZXMganVzdCB0byBxZW11LXJlbmVzYXMtMDEgYW5k
IHFlbXUtcmVuZXNhcy0wMiBkZXZpY2VzIHRvIHJ1biB0aGUgam9icyB1c2luZyBzd3RwbSByaWdo
dC4gQWxsIDExIGpvYnMgd2UgYXJlIHJ1bm5pbmcgd2lsbCB1c2Ugc3d0cG0gc2luY2Ugd2UgYXJl
IG9ubHkgdXNpbmcgc2VjdXJpdHkgdGFyZ2V0IHRvIHRlc3Qgc2VjdXJlIGJvb3QsIHNvZnR3YXJl
IHVwZGF0ZSwgcm9sbGJhY2sgY2FzZXMgYW5kIElFQyBsYXllciB0ZXN0aW5nLiBOb3cgc2luY2Ug
d2UgZ290IHRoZXNlIDIgZGV2aWNlcyBydW5uaW5nIG9uIGxhYi1jaXAtcmVuZXNhcyBzbGF2ZSBh
bmQgMiBqb2JzIHdpbGwgc3RhcnQgd2l0aCBhIG1pbmltYWwgdGltZSBkaWZmaWVyZW5jZSwgdGhl
IGxhdHRlciBqb2IgbXVzdCB3YWl0IHVudGlsIHRoZSBmb3JtZXIgb25lIGlzIGNvbXBsZXRlbHkg
ZG9uZS4gQmVjYXVzZSBvZiB0aGlzLCB0aGUgam9iIHN0YXJ0cyBkZXZpY2UgZ2V0cyBidXN5IGJ1
dCBtdXN0IHdhaXQgZm9yIGEgbG9uZyB0aW1lLg0KDQpTbywgSSB0aGluayBpdCBpcyBiZXR0ZXIg
dG8gY29uZmluZSBvdXIgZGV2aWNlIGRpY3Rpb25hcnkgY2hhbmdlcyB0byBqdXN0IG9uZSBxZW11
IGRldmljZSAoIG1heSBiZSBxZW11LXJlbmVzYXMtMDEgPyApICBsZXQgdXMgdGFnIG9ubHkgdGhh
dCBkZXZpY2UgYW5kIHJ1biBhbGwgb3VyIGpvYnMgb25seSBvbiB0aGF0IGRldmljZS4gQW55d2F5
LCBhbGwgb3VyIGpvYnMgd2lsbCBzdWJtaXQgdG8gdGhlIHNlcnZlciB0aHJvdWdoIGEgc2NyaXB0
IHVzaW5nIGxhdmFjbGkuIFNvLCBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBoYXZlIGEgam9iIHRv
IHdhaXQgaW4gbGluZSB1bnRpbCB0aGUgZGV2aWNlIGlzIGF2YWlsYWJsZSBpbnN0ZWFkIG9mIGhh
dmluZyBpdCB0byBiZSBwaWNrZWQgdXAgYnkgYSBkZXZpY2UgYnV0IG11c3Qgd2FpdCBmb3Igc3d0
cG0gc29ja2V0IHRvIGJlIGF2YWlsYWJsZSB3aGljaCBtYXkgbGVhZCB0byB0aW1lb3V0IGZhaWx1
cmVzLg0KDQpJZiB5b3UgYWdyZWUgdG8gdGhpcywgdGhlbiBwbGVhc2UgY29uZmluZSBvdXIgY2hh
bmdlcyBvbmx5IHRvIG9uZSBxZW11IGRldmljZSBhbmQgdGFnIGl0IHdpdGggc29tZXRoaW5nIGxp
a2UgobBzd3RwbS1qb2JzobEuIEkgc2hhbGwgcmVmZXIgdGhpcyB0YWcgaW4gbXkgam9iIGRlZmlu
aXRpb25zLg0KUGxlYXNlIHByb3ZpZGUgeW91ciBvcGluaW9uIENocmlzLg0KDQpUaGFua3MgYW5k
IFJlZ2FyZHMuDQpTYWkgQXNocml0aCAoIFQgUyBJIFAgKQ0KDQpGcm9tOiBhc2hyaXRoIHNhaSij
1KPTo8mj0CkNClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjEsIDIwMjQgNjowMiBQTQ0KVG86
IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb208bWFpbHRvOkNocmlz
LlBhdGVyc29uMkByZW5lc2FzLmNvbT4+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsgaGF5YXNoaSBrYXp1aGly
byjX+SD7+s7bIKPEo82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMuaGF5
YXNoaUB0b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pj47IGRpbmVzaCBrdW1hciij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1h
ckB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4+
DQpTdWJqZWN0OiBSRTogTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9ucyAoIHNvZnR3YXJlIHVwZGF0
ZSwgc2VjdXJlIGJvb3QgYW5kIElFQyBsYXllciB0ZXN0aW5nICkNCg0KSGkgQ2hyaXMsDQoNClRo
ZW4gSSBzaGFsbCBwcm9jZWVkIHdpdGggY3JlYXRpbmcgYSBwcm9qZWN0IHVuZGVyIGNpcC1wbGF5
Z3JvdW5kIGZvciB0aGlzIHVzZS1jYXNlLiBJIHNoYWxsIHJlcXVlc3QgZm9yIHlvdXIgcmV2aWV3
IG9uY2UgaXQgaXMgZG9uZS4NCg0KVGFrZSBjYXJlIENocmlzLg0KDQpUaGFua3MgYW5kIFJlZ2Fy
ZHMsDQpTYWkgQXNocml0aCAoIFQgUyBJIFAgKQ0KDQpGcm9tOiBDaHJpcyBQYXRlcnNvbiA8Q2hy
aXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPG1haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5j
b20+Pg0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyMSwgMjAyNCA1OjQ2IFBNDQpUbzogYXNo
cml0aCBzYWkoo9Sj06PJo9ApIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb208bWFpbHRv
OlNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsgaGF5YXNo
aSBrYXp1aGlybyjX+SD7+s7bIKPEo82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1
aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPj47IGRpbmVzaCBrdW1hciij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRp
bmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT4+DQpTdWJqZWN0OiBSRTogTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9ucyAoIHNvZnR3
YXJlIHVwZGF0ZSwgc2VjdXJlIGJvb3QgYW5kIElFQyBsYXllciB0ZXN0aW5nICkNCg0KSGkgU2Fp
LA0KDQpTb3JyeSBmb3IgdGhlIHNsb3cgcmVwbHksIEmhr3ZlIGJlZW4gcG9vcmx5Lg0KDQpJdKGv
cyBjZXJ0YWlubHkgYW4gb3B0aW9uIHRvIHNlcGFyYXRlIHRoZSBjaXAtY29yZSB0ZXN0aW5nIGNv
bnRhaW5lci9zY3JpcHRzIGV0Yy4gZnJvbSB0aGUga2VybmVsIHRlc3RpbmcsIGhvd2V2ZXIgbW9z
dCBvZiB0aGUgZnVuY3Rpb25hbGl0eSB3aWxsIGVuZCB1cCBiZWluZyB2ZXJ5IHNpbWlsYXIsIHNv
IHdloa9sbCBlbmQgdXAgd2l0aCBkdXBsaWNhdGlvbi4NCg0KRmVlbCBmcmVlIHRvIGNyZWF0ZSB5
b3VyIHByb2plY3QocykgaW4gY2lwLXBsYXlncm91bmQsIHRoZW4gd2UgY2FuIG1vdmUgdGhlbSBh
Y3Jvc3MgdG8gY2lwLXRlc3Rpbmcgd2hlbiByZWFkeSAmIHdlIGhhdmUgYXBwcm92YWwgZnJvbSB0
aGUgVFNDLg0KDQpUaGFua3MsIENocmlzDQoNCkZyb206IFNhaS5TYXRodWpvZGFAdG9zaGliYS10
c2lwLmNvbTxtYWlsdG86U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPiA8U2FpLlNhdGh1
am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5j
b20+Pg0KU2VudDogTW9uZGF5LCBGZWJydWFyeSAxOSwgMjAyNCA0OjMyIEFNDQpUbzogQ2hyaXMg
UGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJz
b24yQHJlbmVzYXMuY29tPj4NCkNjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWls
dG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBrYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgZGluZXNo
Lmt1bWFyQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOmRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAu
Y29tPg0KU3ViamVjdDogUkU6IExBVkEgdGVzdCBqb2IgZGVmaW5pdGlvbnMgKCBzb2Z0d2FyZSB1
cGRhdGUsIHNlY3VyZSBib290IGFuZCBJRUMgbGF5ZXIgdGVzdGluZyApDQoNCkhlbGxvIENocmlz
LA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KSSByZXF1ZXN0IHlvdSB0byBwbGVhc2Ug
cHJvdmlkZSB5b3VyIG9waW5pb24gYWJvdXQgY3JlYXRpbmcgYSBmcmVzaCByZXBvc2l0b3J5IHVu
ZGVyIGNpcC10ZXN0aW5nIHdoaWNoIHNlcnZlcyB0aGUgcHVycG9zZSBvZiBjcmVhdGluZyBjb250
YWluZXIgaGF2aW5nIENJUCBDb3JlIHRlc3RpbmcgbGF2YSBqb2IgZGVmaW5pdGlvbnMsIGxhdmFj
bGkgZGVwZW5kZW5jaWVzIGFuZCBhIHNpbXBsZSBzY3JpcHQgdHAgc3VibWl0IHRoZSB0ZXN0cyB0
byBDSVAgTEFWQSBzZXJ2ZXIuIFdlIHNoYWxsIGludm9rZSB0aGlzIHNjcmlwdCBpbiBhIHNlcGFy
YXRlIGFjdGlvbiBpbiAuZ2l0bGFiLWNpLnltbCBmaWxlIGluIGlzYXItY2lwLWNvcmUuDQoNClRo
YW5rcyBhbmQgUmVnYXJkcywNClNhaSBBc2hyaXRoICggVCBTIEkgUCApDQoNCg0KRnJvbTogYXNo
cml0aCBzYWkoo9Sj06PJo9ApDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE0LCAyMDI0IDEw
OjA2IEFNDQpUbzogJ0NocmlzIFBhdGVyc29uJyA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29t
PG1haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+Pg0KQ2M6ICdjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZycgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4+OyBoYXlhc2hpIGthenVoaXJvKNf5IPv6ztsg
o8SjzaPFIKHbo8SjyaPHoeCjzaPQo9Oh26PNo9CjtCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hp
YmEuY28uanA8bWFpbHRvOmthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+PjsgZGluZXNo
IGt1bWFyKKPUo9OjyaPQIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEt
dHNpcC5jb208bWFpbHRvOmRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPj4NClN1YmplY3Q6
IFJFOiBMQVZBIHRlc3Qgam9iIGRlZmluaXRpb25zICggc29mdHdhcmUgdXBkYXRlLCBzZWN1cmUg
Ym9vdCBhbmQgSUVDIGxheWVyIHRlc3RpbmcgKQ0KDQpIZWxsbyBDaHJpcywNCg0KV2UgZ290IHNv
bWUgb3BpbmlvbiBmcm9tIHllc3RlcmRheaGvcyBDSVAgQ29yZSBtZWV0aW5nIHRoYXQgaXQgbWln
aHQgbm90IGJlIG9wdGltYWwgdG8gdG91Y2ggdGhpcyBjb250YWluZXIgRmlsZXMgoaQgbWFzdGVy
IKGkIGNpcC1wcm9qZWN0IC8gY2lwLXRlc3RpbmcgLyBsaW51eC1jaXAtY2kgoaQgR2l0TGFiPGh0
dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS90
cmVlL21hc3Rlcj9yZWZfdHlwZT1oZWFkcz4gYW5kIG1vZGlmeSB0aGF0IGJ5IGFkZGluZyBDSVAg
Q29yZSBqb2IgZGVmaW5pdGlvbnMgYW5kIHN1Ym1pdF90ZXN0cyBzY3JpcHQgc3BlY2lmaWMgZm9y
IHRoaXMgdXNlLWNhc2UuIERvIHlvdSB0aGluayB0aGUgc2FtZSA/IElmIHllcywgdGhlbiBkbyB5
b3UgdGhpbmsgY3JlYXRpbmcgYSBmcmVzaCByZXBvc2l0b3J5IHVuZGVyIGNpcC10ZXN0aW5nIHVz
aW5nIHdoaWNoIHdlIGNhbiBidWlsZCB0aGUgY29udGFpbmVycyBhbmQgc2NyaXB0cyB1c2VkIGlu
IHRoZSBDSSB0ZXN0aW5nIG9mIENJUCBDb3JlIGZ1bmN0aW9uYWxpdGllcyBpcyBhIGJldHRlciBj
aG9pY2UgPw0KDQpQbGVhc2UgcHJvdmlkZSB5b3VyIG9waW5pb24gb24gdGhpcyBDaHJpcy4NCg0K
VGhhbmtzIGFuZCBSZWdhcmRzLA0KU2FpIEFzaHJpdGggKCBUIFMgSSBQICkNCg0KRnJvbTogYXNo
cml0aCBzYWkoo9Sj06PJo9ApDQpTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDEyLCAyMDI0IDg6Mjcg
UE0NClRvOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPG1haWx0
bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+Pg0KQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnPG1haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz47IGhheWFzaGkg
a2F6dWhpcm8o1/kg+/rO2yCjxKPNo8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhp
cm8zLmhheWFzaGlAdG9zaGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGli
YS5jby5qcD4+OyBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5l
c2gua3VtYXJAdG9zaGliYS10c2lwLmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNp
cC5jb20+Pg0KU3ViamVjdDogUkU6IExBVkEgdGVzdCBqb2IgZGVmaW5pdGlvbnMgKCBzb2Z0d2Fy
ZSB1cGRhdGUsIHNlY3VyZSBib290IGFuZCBJRUMgbGF5ZXIgdGVzdGluZyApDQoNCkhlbGxvIENo
cmlzLA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KSSB3aWxsIHN1bW1hcml6ZSBteSB1
bmRlcnN0YW5kaW5nIGFuZCBhcHByb2FjaCB0byB0cmlnZ2VyIENJUCBDb3JlIHRlc3RpbmcgTEFW
QSBqb2JzLg0KDQpTbyBjdXJyZW50bHkgd2UgaGF2ZSBhbGwgdGhlIGxhdmEgdGVtcGxhdGVzIGlu
IGxpbnV4LWNpcC1jaSBjb250YWluZXIgd2hpY2ggYXJlIHByZS1wcm9jZXNzZWQgdG8gZm9ybSBm
aW5hbCBMQVZBIGpvYiBkZWZpbml0aW9ucyB1c2luZyB0aGUgc3VibWl0X3Rlc3RzLnNoIKGkIG1h
c3RlciChpCBjaXAtcHJvamVjdCAvIGNpcC10ZXN0aW5nIC8gbGludXgtY2lwLWNpIKGkIEdpdExh
YjxodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lwLWNp
Ly0vYmxvYi9tYXN0ZXIvc3VibWl0X3Rlc3RzLnNoP3JlZl90eXBlPWhlYWRzPiBzY3JpcHQuIEFz
IEkgd2VudCB0aHJvdWdoIHRoZSBzY3JpcHQgSSB1bmRlcnN0b29kIHRoYXQgYSBsb3Qgb2YgbG9n
aWMgaXMgaW52b2x2ZWQgaW4gcHJlcGFyaW5nIHRoZSBqb2IgZGVmaW5pdGlvbnMgZnJvbSB0aGUg
dGVtcGxhdGUgc3BlY2lmaWMgZm9yIENJUCBLZXJuZWwgdGVzdGluZy4gQW5kIHRoaXMgc2NyaXB0
IGlzIHJ1biB3aXRoIGEgdHJpZ2dlciBmcm9tIGhlcmUgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1w
cm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LWNpcC1waXBlbGluZXMvLS9ibGFtZS9tYXN0ZXIvbGlu
dXgtY2lwLXBpcGVsaW5lLnltbD9yZWZfdHlwZT1oZWFkcyNMNjkuIEkgZmVlbCBpdCB3aWxsIG1l
c3MgdXAgdGhlIGV4aXN0aW5nIHRlc3RpbmcgYmVpbmcgZG9uZSBvbiBDSVAga2VybmVsIGFuZCBz
aGFsbCBhbHNvIHJlcXVpcmUgYSBsb3Qgb2YgZWZmb3J0IHRvIGludGVncmF0ZSBjaGFuZ2VzIHJl
cXVpcmVkIHRvIHByZXBhcmUgam9iIGRlZmluaXRpb25zIGZvciBDSVAtQ29yZSB0ZXN0aW5nIGNv
bnNpZGVyaW5nIGh1Z2UgdmFyaWF0aW9ucyBpbiB0aGUgZmluYWwgam9iIGRlZmluaXRpb25zLiBB
bmQgYWxzbyBzaW5jZSBzdWJtaXRfdGVzdHMuc2ggYWxyZWFkeSB3aXRoIGV2ZXJ5IHRlc3QgYWN0
aW9uIHRyaWdnZXIgaW4gbGludXgtY2lwLXBpcGVsaW5lcy55bWwsIEkgdGhpbmsgbWFraW5nIGNo
YW5nZXMgdG8gdGhlIHNjcmlwdCB0byBzdXBwb3J0IENJUC1Db3JlIHRlc3Rpbmcgd2lsbCBpbXBs
eSB0aGF0IGV2ZXJ5IHRyaWdnZXIgaW4gbGludXgtY2lwLWNpIHNoYWxsIHRlc3Qgb3VyIHNvZnR3
YXJlIHVwZGF0ZSwgc2VjdXJlIGJvb3QgYW5kIElFQyB0ZXN0cyBvbiBRRU1VIGltYWdlcyB3aGlj
aCBJIHRoaW5rIGlzIG5vdCByaWdodC4NCg0KT3VyIHJlcXVpcmVtZW50IGhlcmUgaXMgdG8gdHJp
Z2dlciBhIHNjcmlwdCB3aGljaCBzdWJtaXRzIHRoZSBDSVAtQ29yZSByZWxhdGVkIExBVkEgam9i
IGRlZmluaXRpb25zIHdoZW4gYSBjaGFuZ2UgaXMgbWFkZSBpbiBpc2FyLWNpcC1jb3JlLiBTbyBJ
IHRoaW5rIHdlIGNhbiBhIHNob3J0IHNjcmlwdCBzaW1pbGFyIHRvIHN1Ym1pdF90ZXN0cy5zaCBs
aWtlIHN1Ym1pdF9jaXBfY29yZV90ZXN0cy5zaCBhbmQgc2VwYXJhdGUgZm9sZGVyIGZvciBMQVZB
IGRlZmluaXRpb25zIGZvciBDSVAgQ29yZSB0ZXN0aW5nIGluIGNpcC1wcm9qZWN0IC8gY2lwLXRl
c3RpbmcgLyBsaW51eC1jaXAtY2kgoaQgR2l0TGFiPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJv
amVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS90cmVlL21hc3Rlcj9yZWZfdHlwZT1oZWFk
cz4gY29udGFpbmVyLiBXZSB3aWxsIHJ1biB0aGlzIG5ldyBzY3JpcHQgdXNpbmcgYSB0ZXN0IGFj
dGlvbiBpbiAuZ2l0bGFiLWNpLnltbCBJbiBpc2FyLWNpcC1jb3JlLiBJbiB0aGlzIG5ldyBzY3Jp
cHQgd2Ugc2hhbGwgc3VibWl0IG9ubHkgdGhlIENJUCBDb3JlIHJlbGF0ZWQgam9iIGRlZmluaXRp
b25zIHdoaWNoIHdlIGFkZGVkIGluIGEgc2VwYXJhdGUgZm9sZGVyIGluIGxpbnV4LWNpcC1jaSBj
b250YWluZXIgdG8gTEFWQSBtYXN0ZXIuDQoNCkkgY2hvc2UgdGhpcyBhcHByb2FjaCB0byBtaW5p
bWl6ZSB0aGUgZWZmb3J0IGFuZCBhdm9pZCBtZXNzaW5nIHVwIHRoZSBleGlzdGluZyBpbXBsZW1l
bnRhdGlvbiB3aGljaCBpcyBoaWdobHkgc3BlY2lmaWMgZm9yIENJUCBLZXJuZWwgdGVzdGluZyBh
bmQgdG8gYWxzbyB1c2UgdGhlIGV4aXN0aW5nIGxpbnV4LWNpcC1jaSBjb250YWluZXIuIFRoaXMg
aXMgdGhlIGZpcnN0IHRpbWUgd2UgYXJlIHRlc3RpbmcgQ0lQIENvcmUgZnVuY3Rpb25hbGl0aWVz
IG9uIExBVkEsIHNvIGluaXRpYWxseSB3ZSBzdGFydGVkIHNtYWxsIHdpdGggUUVNVSBhbmQgaW4g
dGhlIGZ1dHVyZSBvbmNlIHdlIHNwcmVhZCB0aGUgdGVzdGluZyB0byBtdWx0aXBsZSBkZXZpY2Vz
LCB0aGVuIG1heSBiZSB3ZSBjYW4gc2V0dXAgYSBuZXcgcmVwb3NpdG9yeSBsaWtlIGNpcC1wcm9q
ZWN0IC8gY2lwLXRlc3RpbmcgLyBsaW51eC1jaXAtY2kgoaQgR2l0TGFiPGh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS90cmVlL21hc3Rlcj9y
ZWZfdHlwZT1oZWFkcz4gdG8gYnVpbGQgYSBzZXBhcmF0ZSBjb250YWluZXIgb25seSB0byBkZWFs
IHdpdGggQ0lQIENvcmUgTEFWQSBkZWZpbml0aW9ucy4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgb2Yg
bXkgYXBwcm9hY2ggQ2hyaXMgPyBQbGVhc2UgcHJvdmlkZSB5b3VyIG9waW5pb24gYW5kIGNvcnJl
Y3QgbWUgaWYgSSBhbSB3cm9uZy4NCg0KSSBhbHNvIHJlcXVlc3Qgb3RoZXIgQ0lQIG1lbWJlcnMg
dG8gcHJvdmlkZSB0aGVpciBzdWdnZXN0aW9ucy4NCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0KU2Fp
IEFzaHJpdGggKCBUIFMgSSBQICkNCg0KRnJvbTogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVy
c29uMkByZW5lc2FzLmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NClNl
bnQ6IEZyaWRheSwgRmVicnVhcnkgOSwgMjAyNCAyOjA5IEFNDQpUbzogYXNocml0aCBzYWkoo9Sj
06PJo9ApIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOlNhaS5TYXRodWpv
ZGFAdG9zaGliYS10c2lwLmNvbT4+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8
bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsgaGF5YXNoaSBrYXp1aGlybyjX
+SD7+s7bIKPEo82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMuaGF5YXNo
aUB0b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPj47
IGRpbmVzaCBrdW1hciij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0
b3NoaWJhLXRzaXAuY29tPG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4+DQpT
dWJqZWN0OiBSRTogTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9ucyAoIHNvZnR3YXJlIHVwZGF0ZSwg
c2VjdXJlIGJvb3QgYW5kIElFQyBsYXllciB0ZXN0aW5nICkNCg0KSGVsbG8gU2FpLA0KDQpGaXJz
dGx5LCBsZXShr3MgZ2V0IHNvbWUgYmFja2dyb3VuZCBmb3IgdGhpcyByZXF1ZXN0Lg0KDQpXaGF0
IGlzIGl0IHlvdaGvcmUgdGVzdGluZz8gQW5kIHdoZW4gaXMgaXQgeW91oa9kIGxpa2UgdGhlIHRl
c3RzIHRvIHJ1bj8NCkmhr20gZ3Vlc3NpbmcgaXNhci1jaXAtY29yZT8gQW5kIHdoZW5ldmVyIGEg
Y2hhbmdlIGlzIG1hZGUgb24gX2FueV8gb2YgdGhlIGJyYW5jaGVzPyBFLmcuIG5leHQsIG1hc3Rl
ciBvciBmZWF0dXJlIGJyYW5jaGVzPw0KDQpPbiB0aGUgTGludXgga2VybmVsIHNpZGUgb2YgdGhp
bmdzLCB0aGUgdGVzdCBwaXBlbGluZXMgYXJlIGRyaXZlbiBieSBsaW51eC1jaXAtcGlwZWxpbmVz
PGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtcGlw
ZWxpbmVzPiB1c2luZyB0aGUgc2NyaXB0cyBwcm92aWRlZCBpbiBsaW51eC1jaXAtY2k8aHR0cHM6
Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LWNpcC1jaT4uDQpIb3dl
dmVyLCBuZWl0aGVyIG9mIHRoZXNlIHJlcG9zaXRvcmllcyBhcmUgY3VycmVudGx5IHNldCB1cCBm
b3IgY2lwIGNvcmUgdGVzdGluZy4NCldloa9kIG5lZWQgdG8gYWRkIHNvbWV0aGluZyB0byBpc2Fy
LWNpcC1jb3JlIHRvIHRyaWdnZXIgdGhlIHRlc3Qgam9icywgYW5kIGhhdmUgYSB3YXkgdG8gY3Jl
YXRlIHRoZSBMQVZBIHRlc3Qgam9iIGRlZmluaXRpb25zIHdlIG5lZWQgdGhlcmUuDQoNClRoYXQg
c2FpZCwgcGVyaGFwcyB0aGUgdGVtcGxhdGVzIGFuZCBzdWJtaXRfdGVzdHMuc2ggc2NyaXB0IGZy
b20gbGludXgtY2lwLWNpIGNvdWxkIGJlIHVwZGF0ZWQgdG8gYmUgYWJsZSB0byBydW4gdGhlc2Ug
c2VjdXJpdHkgdGVzdHM/DQpUaGUgYnVpbGQgc2lkZSBvZiBpc2FyLWNpcC1jb3JlIGNhbiBvYnZp
b3VzbHkgc3RheSBhcyBpdCBpcyBub3cuDQpUYWtlIGEgbG9vayB0aHJvdWdoIHRoZSBhYm92ZSBy
ZXBvcyBhbmQgc2VlIGlmIHdlIGNvdWxkIGludGVncmF0ZSB5b3VyIGpvYiBkZWZpbml0aW9ucyBp
bnRvIHRoZSBzYW1lIGxhdmEgdGVtcGxhdGUgc3R5bGUuIE9yIHdoZXRoZXIgeW91IHRoaW5rIGl0
IHdvdWxkIGJlIGNsZWFuZXIgdG8gdGFrZSBhIGZyZXNoIGFwcHJvYWNoIHNwZWNpZmljYWxseSBm
b3IgY2lwIGNvcmUvc2VjdXJpdHkgdGVzdGluZy4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQpG
cm9tOiBTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOlNhaS5TYXRodWpvZGFA
dG9zaGliYS10c2lwLmNvbT4gPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbTxtYWlsdG86
U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPj4NClNlbnQ6IE1vbmRheSwgRmVicnVhcnkg
NSwgMjAyNCA1OjU5IFBNDQpUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5l
c2FzLmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NCkNjOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmc+OyBrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5
YXNoaUB0b3NoaWJhLmNvLmpwPjsgZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb208bWFpbHRv
OmRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPg0KU3ViamVjdDogTEFWQSB0ZXN0IGpvYiBk
ZWZpbml0aW9ucyAoIHNvZnR3YXJlIHVwZGF0ZSwgc2VjdXJlIGJvb3QgYW5kIElFQyBsYXllciB0
ZXN0aW5nICkNCg0KSGkgQ2hyaXMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLg0KDQpQbGVh
c2UgcmV2aWV3IHRoZSBqb2IgZGVmaW5pdGlvbnMgYXR0YWNoZWQgdG8gdGhpcyBtYWlsIGFuZCBr
aW5kbHkgcHJvdmlkZSB5b3VyIHJldmlldyBjb21tZW50cy4NCg0KRG91YnRzOg0KDQogIDEuICBE
byBJIG5lZWQgdG8gYWRkIHRoZXNlIGRlZmluaXRpb25zIGluIHRoaXMgcmVwb3NpdG9yeT8uIGh0
dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy90ZXN0LWRlZmluaXRpb25z
DQogIDIuICBJIGFtIG5vdCBzdXJlIGhvdyB0byBzY2hlZHVsZSB0aGVzZSBMQVZBIGpvYnMgaW4g
Q0lQIExBVkEgbGFiLiBDYW4geW91IHBsZWFzZSBoZWxwIG1lIHdpdGggdGhpcyA/DQogIDMuICBJ
IHJlbWVtYmVyIHlvdSBpbnN0YWxsZWQgc3d0cG0gYW5kIG92bWYgcGFja2FnZXMgaW4gbGFiLXJl
bmVzYXMtY2lwIHNsYXZlLiBDYW4geW91IGluc3RhbGwgdGhvc2UgcGFja2FnZXMgYWxsIHRoZSBD
SVAgTEFWQSBzbGF2ZSBtYWNoaW5lcyBDaHJpcyA/DQoNClRoYW5rcyBhbmQgUmVnYXJkcywNClNh
aSBBc2hyaXRoICggVCBTIEkgUCApDQo=

--_000_TYWPR01MB11862164EF6555E3A1ED9DB94B75A2TYWPR01MB11862jp_
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
<style><!--
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
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:#7030A0;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:228655134;
	mso-list-template-ids:1614416764;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">I have tagged qemu-renesas-01=
 with the =A1=B0swtpm-jobs=A1=B1 tag:
<a href=3D"https://lava.ciplatform.org/scheduler/device/qemu-renesas-01">ht=
tps://lava.ciplatform.org/scheduler/device/qemu-renesas-01</a><o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Let me know if there is anyth=
ing I change for you.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Kind regar=
ds, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none;=
mso-fareast-language:KO">From:</span></b><span lang=3D"EN-US" style=3D"mso-=
ligatures:none;mso-fareast-language:KO"> Sai.Sathujoda@toshiba-tsip.com &lt=
;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Monday, February 26, 2024 11:32 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; =
dinesh.kumar@toshiba-tsip.com<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">You made device dictionary related changes just to qemu-renesas-01 an=
d qemu-renesas-02 devices to run the jobs using swtpm right. All 11 jobs we=
 are running will use swtpm since we are
 only using security target to test secure boot, software update, rollback =
cases and IEC layer testing. Now since we got these 2 devices running on la=
b-cip-renesas slave and 2 jobs will start with a minimal time diffierence, =
the latter job must wait until the
 former one is completely done. Because of this, the job starts device gets=
 busy but must wait for a long time.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">So, I think it is better to confine our device dictionary changes to =
just one qemu device ( may be qemu-renesas-01 ? ) &nbsp;let us tag only tha=
t device and run all our jobs only on that
 device. Anyway, all our jobs will submit to the server through a script us=
ing lavacli. So, I think it is better to have a job to wait in line until t=
he device is available instead of having it to be picked up by a device but=
 must wait for swtpm socket to be
 available which may lead to timeout failures.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">If you agree to this, then please confine our changes only to one qem=
u device and tag it with something like =A1=B0swtpm-jobs=A1=B1. I shall ref=
er this tag in my job definitions.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Please provide your opinion Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> ashrith=
 sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"=
EN-US" style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, February 21, 2024 6:02 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=D7=F9</span>=
<span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Then I shall proceed with creating a project under cip-playground for=
 this use-case. I shall request for your review once it is done.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Take care Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none;=
mso-fareast-language:KO">From:</span></b><span lang=3D"EN-US" style=3D"mso-=
ligatures:none;mso-fareast-language:KO"> Chris Paterson &lt;<a href=3D"mail=
to:Chris.Paterson2@renesas.com">Chris.Paterson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, February 21, 2024 5:46 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=A3=D4=
=A3=D3=A3=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none;m=
so-fareast-language:KO">) &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.=
com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font=
-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-languag=
e:KO">=D7=F9</span><span lang=3D"KO" style=3D"mso-ligatures:none;mso-fareas=
t-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=FB=FA=CE=DB</span><span lang=
=3D"KO" style=3D"mso-ligatures:none;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=A3=C4=A3=CD=A3=C5</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none;mso-fareast-language:KO"> =A1=DB=
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=A3=C4=A3=C9=A3=C7</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none;mso-fareast-language:KO">=A1=E0<=
/span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;m=
so-ligatures:none;mso-fareast-language:KO">=A3=CD=A3=D0=A3=D3</span><span l=
ang=3D"EN-US" style=3D"mso-ligatures:none;mso-fareast-language:KO">=A1=DB</=
span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;ms=
o-ligatures:none;mso-fareast-language:KO">=A3=CD=A3=D0=A3=B4</span><span la=
ng=3D"EN-US" style=3D"mso-ligatures:none;mso-fareast-language:KO">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-f=
amily:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:=
KO">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatu=
res:none;mso-fareast-language:KO">
 TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">di=
nesh.kumar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hi Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Sorry for the slow reply, I=
=A1=AFve been poorly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">It=A1=AFs certainly an option=
 to separate the cip-core testing container/scripts etc. from the kernel te=
sting, however most of the functionality will end up
 being very similar, so we=A1=AFll end up with duplication.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Feel free to create your proj=
ect(s) in cip-playground, then we can move them across to cip-testing when =
ready &amp; we have approval from the TSC.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Thanks, Ch=
ris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none;=
mso-fareast-language:KO">From:</span></b><span lang=3D"EN-US" style=3D"mso-=
ligatures:none;mso-fareast-language:KO">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 19, 2024 4:32 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">I request you to please provide your opinion about creating a fresh r=
epository under cip-testing which serves the purpose of creating container =
having CIP Core testing lava job definitions,
 lavacli dependencies and a simple script tp submit the tests to CIP LAVA s=
erver. We shall invoke this script in a separate action in .gitlab-ci.yml f=
ile in isar-cip-core.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> ashrith=
 sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"=
EN-US" style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, February 14, 2024 10:06 AM<br>
<b>To:</b> 'Chris Paterson' &lt;<a href=3D"mailto:Chris.Paterson2@renesas.c=
om">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> 'cip-dev@lists.cip-project.org' &lt;<a href=3D"mailto:cip-dev@li=
sts.cip-project.org">cip-dev@lists.cip-project.org</a>&gt;; hayashi kazuhir=
o(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans=
-serif;mso-ligatures:none">=D7=F9</span><span lang=3D"JA" style=3D"mso-liga=
tures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">We got some opinion from yesterday=A1=AFs CIP Core meeting that it mi=
ght not be optimal to touch this container
</span><span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-t=
esting/linux-cip-ci/-/tree/master?ref_type=3Dheads">Files =A1=A4 master =A1=
=A4 cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> and modify t=
hat by adding CIP Core job definitions and submit_tests
 script specific for this use-case. Do you think the same ? If yes, then do=
 you think creating a fresh repository under cip-testing using which we can=
 build the containers and scripts used in the CI testing of CIP Core functi=
onalities is a better choice ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Please provide your opinion on this Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> ashrith=
 sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"=
EN-US" style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Monday, February 12, 2024 8:27 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=D7=F9</span>=
<span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">I will summarize my understanding and approach to trigger CIP Core te=
sting LAVA jobs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">So currently we have all the lava templates in linux-cip-ci container=
 which are pre-processed to form final LAVA job definitions using the
</span><span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-t=
esting/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=3Dheads">submit_=
tests.sh =A1=A4 master =A1=A4 cip-project / cip-testing / linux-cip-ci =A1=
=A4 GitLab</a> script. As I went through the script I
 understood that a lot of logic is involved in preparing the job definition=
s from the template specific for CIP Kernel testing. And this script is run=
 with a trigger from here
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/blame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/mast=
er/linux-cip-pipeline.yml?ref_type=3Dheads#L69</a>. I feel it will mess up =
the existing testing being done on CIP kernel and shall also require a lot =
of effort to integrate changes required
 to prepare job definitions for CIP-Core testing considering huge variation=
s in the final job definitions. And also since submit_tests.sh already with=
 every test action trigger in linux-cip-pipelines.yml, I think making chang=
es to the script to support CIP-Core
 testing will imply that every trigger in linux-cip-ci shall test our softw=
are update, secure boot and IEC tests on QEMU images which I think is not r=
ight.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Our requirement here is to trig=
ger a script which submits the CIP-Core related LAVA job definitions when a=
 change is made in isar-cip-core. So I think we can a short script similar =
to submit_tests.sh like submit_cip_core_tests.sh
 and separate folder for LAVA definitions for CIP Core testing in <a href=
=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/master?r=
ef_type=3Dheads">
cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> container. We wi=
ll run this new script using a test action in .gitlab-ci.yml In isar-cip-co=
re. In this new script we shall submit only the CIP Core related job defini=
tions which we added in a separate folder
 in linux-cip-ci container to LAVA master.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I chose this approach to minimi=
ze the effort and avoid messing up the existing implementation which is hig=
hly specific for CIP Kernel testing and to also use the existing linux-cip-=
ci container. This is the first time
 we are testing CIP Core functionalities on LAVA, so initially we started s=
mall with QEMU and in the future once we spread the testing to multiple dev=
ices, then may be we can setup a new repository like
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/m=
aster?ref_type=3Dheads">
cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> to build a separ=
ate container only to deal with CIP Core LAVA definitions.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">What do you think of my approac=
h Chris ? Please provide your opinion and correct me if I am wrong.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I also request other CIP member=
s to provide their suggestions.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith ( T S I P )</span><=
span lang=3D"EN-US" style=3D"mso-fareast-language:EN-US"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> Chris P=
aterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@=
renesas.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 9, 2024 2:09 AM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</s=
pan><span lang=3D"EN-US" style=3D"mso-ligatures:none">) &lt;<a href=3D"mail=
to:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<b=
r>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=D7=F9</span>=
<span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Firstly, let=A1=AFs get some =
background for this request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">What is it you=A1=AFre testin=
g? And when is it you=A1=AFd like the tests to run?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">I=A1=AFm guessing isar-cip-co=
re? And whenever a change is made on _<i>any</i>_ of the branches? E.g. nex=
t, master or feature branches?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">On the Linux kernel side of t=
hings, the test pipelines are driven by
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines">=
linux-cip-pipelines</a> using the scripts provided in
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci">linux-c=
ip-ci</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">However, neither of these rep=
ositories are currently set up for cip core testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">We=A1=AFd need to add somethi=
ng to isar-cip-core to trigger the test jobs, and have a way to create the =
LAVA test job definitions we need there.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">That said, perhaps the templa=
tes and submit_tests.sh script from linux-cip-ci could be updated to be abl=
e to run these security tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">The build side of isar-cip-co=
re can obviously stay as it is now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Take a look through the above=
 repos and see if we could integrate your job definitions into the same lav=
a template style. Or whether you think it would
 be cleaner to take a fresh approach specifically for cip core/security tes=
ting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Kind regar=
ds, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 5, 2024 5:59 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> LAVA test job definitions ( software update, secure boot an=
d IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please review the job definitio=
ns attached to this mail and kindly provide your review comments.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Doubts: <o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo3"><span lang=3D"EN-US">Do I need to add these definitions in this repos=
itory?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></sp=
an></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0=
 level1 lfo3"><span lang=3D"EN-US">I am not sure how to schedule these LAVA=
 jobs in CIP LAVA lab. Can you please help me with this ?<o:p></o:p></span>=
</li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 le=
vel1 lfo3"><span lang=3D"EN-US">I remember you installed swtpm and ovmf pac=
kages in lab-renesas-cip slave. Can you install those packages all the CIP =
LAVA slave machines Chris ?<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and Regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith ( T S I P )<o:p></o=
:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB11862164EF6555E3A1ED9DB94B75A2TYWPR01MB11862jp_--

