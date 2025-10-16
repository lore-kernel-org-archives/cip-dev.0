Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C889CCCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 09:16:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.3780.1760606195496689919
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 02:16:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 59G9GYID2188879; Thu, 16 Oct 2025 18:16:34 +0900
X-Iguazu-Qid: 2rWhCFFh0qIwLZl79c
X-Iguazu-QSIG: v=2; s=0; t=1760606193; q=2rWhCFFh0qIwLZl79c; m=pziXwSImKJVVKrdCzQOVcdgnqCnv9gZ4N2oAv6G8Mlk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cnMlP4fQ6z4vyh; Thu, 16 Oct 2025 18:16:32 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RveFwPEabyPT+QCbKBLRFEWHS0FzHXUh6wIR1wxylPu2xLW/ZPTwoh7N+m4bXxg07q/ndP/DYL2mticC4VrzHaXUOyNtR9DkzKwa+9Sxw+khI66+ca79GBIX0JGcFYYeMMUlyvr7ZFXmol++XatLwlNEb/4TLeKF6uJQpaovepGdtnJBAcpGaPcHy/nZ6wgGVLsY8zH3Mhq0gcLtP0F74GyFrRn9xe5yz/MErBsVOWpoDdPgX59BrUEm66YMg78NhUEE4ztoEAeQ8p9w1zkjMNd10FuOcjeL+GfeGee8sx78Y3iCNrxfJTKJe/P8XC3cZNKjTQZhHArRrTYK1gRbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4TZlDf4SUPg9QZFOLrFnv9ZfmfHMKjgciiT3rQ+Q6k=;
 b=pfE4ktaBmxVeJ6Ece+X/Ci7jg4Pz8NrHJ2OYlEkJTPsQYPqnvAD2cRw48k6wsrYXtGvp/qwahoFIoGQIn7JDsNLZijYqlavH9o3pBf0yqimPRuS/AhxYWXIb4k/pvlJRM3lBXBVjlnPG671G9zNFRRbxIvnTIoQa+RlmlqJbRvVqlpUUkWn/KQUMkwkDPqTgGqG93heFxLzBjaLjbixvP6IpdR2vX7CRLsTdp1Kg55+l98GKofFWEQa34SaKkipIWWP6VP+DCSSFUeO0bjjLaFK2qiRWBkDlH/PN6oXHlz3rP+sEB2Ii3ndXhYV6/LR5KW8JZfhdtxuYE0JAqyCuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <jan.kiszka@siemens.com>,
        <Adithya.Balakumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>, <dinesh.kumar@toshiba-tsip.com>,
        <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] isar-cip-core: on-device tests failing
Thread-Topic: [cip-dev] isar-cip-core: on-device tests failing
Thread-Index: 
 AQHcLVNEloTXUwMEUEOFybgBc8TVV7SjpJGggAAd8ACAAACxMIAAQ7GAgAXoUgCAABlb0IAALl2AgBWrgoCAACL+AIABhbHQgAA0OwCAAAoNAIABEBmAgAAuMoCAABULAIAAAicAgAF5Q+A=
Date: Thu, 16 Oct 2025 09:16:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075F1040D50FD87E26D929FC7E9A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
 <160719b2-7915-48e3-9e63-eb08fa9d5c6b@siemens.com>
In-Reply-To: <160719b2-7915-48e3-9e63-eb08fa9d5c6b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYCPR01MB11095:EE_
x-ms-office365-filtering-correlation-id: d9b53dac-3b0b-49df-a79c-08de0c94b0b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WW4wNjVuVVEzYXJmdlpUdUdVT1UwVitlOWtCZVJ1cHZWeGErL0Y5Z0NL?=
 =?iso-2022-jp?B?Vkx1S1QzUENBR1VXYnRRTWpBWHBHMlhlSmlTRkhROW9KbnZMUnNFVzl2?=
 =?iso-2022-jp?B?d3NBVWtPY05xYzFuWmxEbms1dlRNMFVLUWNqemU0NFZXZS9COFZCTkRO?=
 =?iso-2022-jp?B?djk0V0FhWVlqNzVaU3FWYjJuWlhQN3Q2RjZFZmUyOEJhRWpPRUhZM1hF?=
 =?iso-2022-jp?B?RTlja3c2TXhDTlg1R0ZRMzN4V1E1TGg0Vy9nZytneDJjdWdvUTFqb1do?=
 =?iso-2022-jp?B?K0dNR1dTMWpCUHlWeTBXTGlRdjV5QlI1Szl3eDJVK1lHd2ZXZnpHTncw?=
 =?iso-2022-jp?B?NS8xVVVLbnphdGRIWVpGcU1Ga2RsZlhCWGJrMnA3aGhEaysrbHA2RmYw?=
 =?iso-2022-jp?B?ajYySWJ1U3pjdysvNjBjQTVxM2ZUbjJFb25EOU5XWGFlQTJKcE12VUNi?=
 =?iso-2022-jp?B?b01vSE0yYldJRXlvLzhZVUM3aE1KTk56UWQ4QVJJVHZKaHVISVZ4YmdO?=
 =?iso-2022-jp?B?SE1nbUFsTWU4MUU4VG9CODF3Q1BMTUVrNXNCV0UwdDhMNWhyVUw1Qmc2?=
 =?iso-2022-jp?B?L0VvZW03QytqemNGLzY1d1FTVjZsQUs0WStuMFdTdnNVSVNvOXdwZ3BF?=
 =?iso-2022-jp?B?cEg5c25HSElNTklzNWpnUFV2N0VnTUtkTDNtWGNrb3I5anlsWGZDSVpp?=
 =?iso-2022-jp?B?NWovL2U1TW9sbnlERC94cG9UNnBubU5VOWhad29KblV3d1lvWWJwZW5V?=
 =?iso-2022-jp?B?b2hLVzhtS1RKTGk0eXMyeHZqVFVKa3FybzI1bW55M1U1L3VZQWdScEJv?=
 =?iso-2022-jp?B?cTFFb3VBWDYwMW5yblcrYUNTQVVBZlJOdHZwMmhRb2FkZVRqams1K1ZY?=
 =?iso-2022-jp?B?MUtsMGxoSGx3Z2NGOFhOeXJndXFPT0pibGJ3YmtydUtqM3pZUCsvdjZB?=
 =?iso-2022-jp?B?azl3T05GVFA5cVVpMkhja0NCeG5haXpzdVpTdEtCT1JDMzh3OFdUWGc0?=
 =?iso-2022-jp?B?T3RuVjFRNEV0WGJEWTMydUVjOUdpUWd1MENXekN3MnFtRGlXUkNZaDFH?=
 =?iso-2022-jp?B?RjF6V2NFQzExN0Yzc1A3MEwzUXUyR1VqN0Q4RXM0VkhKWjRDYTlqSHFG?=
 =?iso-2022-jp?B?RGsvQy9KYk51TVp5WEdzZWVybDg1WE9hOEQ3MUt2dDRyYUFMSjJNOS8r?=
 =?iso-2022-jp?B?QW9XT25FaFo0ZTJtZTFyR0xvM2doNHlpeW9iVzM4Vjk5RjRmek1KM25o?=
 =?iso-2022-jp?B?M2FYc1RXQkhUdjIrR0oycnNZQ010TFNDUEVUbnZkNEpPL05tMW9FRGRT?=
 =?iso-2022-jp?B?eW9TUURCbDJyY2RHS21JZS8xblgrWDBzVnFyMzg4cUNxaW10dGYxano0?=
 =?iso-2022-jp?B?NW1TdWIxaTdZRlo3Qzg2NndEL05KSTkvQkRPUVMxeWk0NEpYNzhsNzlL?=
 =?iso-2022-jp?B?eE4vdEJqT3ZYeXhndXN3YnJhcEtueDNUZTRIMSs0OTdDamN5eUMwNzI4?=
 =?iso-2022-jp?B?dXJuZ28vaFhhZ29DNkN4V1N6QTlkcnNzY1F2TXdEM1h0WDl6Z1BvemJM?=
 =?iso-2022-jp?B?WHhQeTlYNUo1b2ZKSHZZUFkrVElmV1lVWHBsNE42U0JoRWthd0Raamc1?=
 =?iso-2022-jp?B?aDBHa05NWno3YzlSVHAvN2Y1bStSQVZXdmtsbGt6YVlQQlJ1b2ZlWXJE?=
 =?iso-2022-jp?B?YzYydUtaakhJMFo0QXBaUjMyYlBHTmRMUzZTNDZSUDNBSEZzZmwyMmZG?=
 =?iso-2022-jp?B?ck1TNHBScjhLOFk0OHkydDBKR25uR2pOL21mbHdrZUJTVktVY3dySFFo?=
 =?iso-2022-jp?B?WHV1Y0llUFNiMXdpTjk4ZThKTUxFNWRjVDVSbjl2SVlmQXBFSUg4L0Nx?=
 =?iso-2022-jp?B?bFAwcFdWVGtQbm94TzZ6MHd5Wm1HcU9XMmtZQkhkd25vWDVNbjBZSUtY?=
 =?iso-2022-jp?B?NFk0L3p1YWtYV1dRT09aRUprYmdCdXUzQXJpZmFrZWVoWFNpcWQ3VS96?=
 =?iso-2022-jp?B?SlNDcWpmUVovSGZRVnBxZ282UlJxbDdRMmltOU9tczVaSWhrM0dYaDRL?=
 =?iso-2022-jp?B?UG00SmlnQ2lWMWQ1RmhkdDdBajNBQ1A3SXlQcmVYalJ5a3AyZlA1aWpj?=
 =?iso-2022-jp?B?QUFaZFVPaDJVM0hoZVU1bWZOMHZrTnB3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TWp1bmkxRVplOTdOTmtmME1OVkF6UXFKMHVvUE9CSVF6UTU4eGJpKysx?=
 =?iso-2022-jp?B?c2REWXFuTFRWdUZraDBZUGdDMm5QaEhRSmEyTThiRFRQWWVKUG95THF2?=
 =?iso-2022-jp?B?VDlEZHI5K1NkdFM5VEM0dXNnYVlmYUVmN3Y1TjVKYTFUY3VtQ0dIaWZl?=
 =?iso-2022-jp?B?T09VRExWK1IybTZnT3UrdTUvWEltNjRvTG4yVXo1VzBTYlRtaElFZG15?=
 =?iso-2022-jp?B?TXRNYURoL1RZRHlBb2dobGVEZHJlb2o3WGZFVkZLaFhYbDRqOG5ERkJX?=
 =?iso-2022-jp?B?V092empxZU5JMVlRZ3FySytpcmY0ckFQdlBiV25jZzFnQURlMmJyTSt1?=
 =?iso-2022-jp?B?TzJURlNpQzdzU2JjWnBIWmdqTE5SUlFNcmNHdzBjWmhrTjFzRng2bWlw?=
 =?iso-2022-jp?B?RThtN3ZYWjVIRkZ2amtiM1p3NzFEZlhkK2FlcXZNcVIvL05OSVpuY2cz?=
 =?iso-2022-jp?B?aUNzWCtLZjlXTWgvQkN4dUVLQVpNdk9BdHpETFhBQ2RWdWZsWHlCaS84?=
 =?iso-2022-jp?B?L1JIbkZOUFA3Z2tXZUU2ZjBsUHBDaWtaSVhOU0xHUHpNQkczUE9NZmtJ?=
 =?iso-2022-jp?B?V2dMUFp2c3VKNnFybmRXcHRGZkZkNVkybG96WmJUY24xbzN3QWRvZHdP?=
 =?iso-2022-jp?B?S3dxek9vdDFQSFBJdDNWZU1QZkw3MWJLMndyT1lrMTBTRXg1a1JDbktQ?=
 =?iso-2022-jp?B?bnNrL0xSd3JEbGFEcVp0elVsb21LaVl0aHcrMmZ6RjhqT25WTTdNNDM1?=
 =?iso-2022-jp?B?MGltazFTTlhrbVNGMk0vSXpxQU01UWdtRi9GMnNjQjJmdzZsZk5GdVRk?=
 =?iso-2022-jp?B?Y3IzV0xydWNldGQxMFlkeDcyTHNtazVZSVNJeGhHVDJBcG1KeGU5YlBz?=
 =?iso-2022-jp?B?SWxCTHFOa1pQNnN1RllmenMxYy9EOUorb1ZTUjlFNjQ3ZXZKbzArSFJN?=
 =?iso-2022-jp?B?d2xpSjg2S0xicnpJRjJrbzdBNlhLczl3eEROZHNlTUtXcDJ4cUh2R3Q1?=
 =?iso-2022-jp?B?Qy94YWZMck9aOWxROEpxS1E5bTZJT2d0UGpTWjVlOUFHZlA2UWNmMjJj?=
 =?iso-2022-jp?B?ZzlIQ0RrSlFEbWl2b21UbU1mODNzOStSVHRaVjh3TmgxcUtpaCtQNUhP?=
 =?iso-2022-jp?B?cVRQK2Y2WG9IUk5pZUFNYWExVndKZzJUcHg3bm85NW9BMyt3ZXpza2cw?=
 =?iso-2022-jp?B?WFF6OUJ5dUNaZzR3RnpGYVdsaGlWcnFlUUk5T3NpTWZKbUN5ckNQSm9h?=
 =?iso-2022-jp?B?MExxemQwUzA0czN0QlA1QXk2Zm1raXRLM2RLcGVYZkJNS1V6TlFCUFJX?=
 =?iso-2022-jp?B?bTRONUFWaE1iUEE1Mk56ODVqYWlhZHNLM2lDN3VYU0xMR0hjWlpHby9h?=
 =?iso-2022-jp?B?YzdoWFFjL3hUNmUyVmo4ekdHYXNDTmZpTlc3b3o4SFgycWNOdjkveEdK?=
 =?iso-2022-jp?B?R0szT3RnK09INlRYSWxRSVJZb0x3aDVVd0YyeE5ZYVFyM2cvNEdTQUFo?=
 =?iso-2022-jp?B?YngyeEM5TEp3UVc4NVpEdVc2ejNIamtwcGtyNU1uclBLVjVhZ2Z4RGJK?=
 =?iso-2022-jp?B?NzZ3WHF0cXdKK2owWjlVMVFiM2g0UUQ1aVlsREtDSUQwZndmREFhOSsy?=
 =?iso-2022-jp?B?MFhENmU4b0FFSWtSQ051QndQeFRiR0Y0dmJ5cDhrOS9qUy9EMHcraW05?=
 =?iso-2022-jp?B?NWY3VHVkWGR1aXFkODdRckw4Q2NTOThlSlVFS3lQTndadXFZVS9tWUph?=
 =?iso-2022-jp?B?cUM4SmVQS3c0cUxWQ3M5cXYva2NSeG04eUpCT0tPTWpWdi83ejBJRDA3?=
 =?iso-2022-jp?B?ZTdmNi9lbXBid0NFL0VqcFJ1ejdKL1RUNUl4RWFremJPTm1XNFdUMEw1?=
 =?iso-2022-jp?B?aVZ2N3hXY2FlZE1XSWcxTFBUTWsyak8wWUlnaGkzK1h2dUpHYVJ3Mmkx?=
 =?iso-2022-jp?B?RzAvVnhaUU9MU1Q1aVlQSDhIQ3Q5a3Ywd3lNU094VU5nc0RwMUx3LzN1?=
 =?iso-2022-jp?B?OHRjV1NIWGFjVFJLNHZuU1cwYmJpK01JZXcvcWdSMWlQZFRZSmEzMjZT?=
 =?iso-2022-jp?B?b1hURnNGbWhadTBVekFQNloyNi9Ocnh3L1ZsVDRGU0s4YXMwNmRscHhZ?=
 =?iso-2022-jp?B?WGhYL1JBYnR6MnhGZytiQkdlT2M1WkY2K1pPZFZ6cnBVUlZBNWJ2ZFdU?=
 =?iso-2022-jp?B?Q09qZGdMQmxaUnpyTkdyZmVucXE0N1lIeUhoUm1NNzV3ZFIzRTJqcWs3?=
 =?iso-2022-jp?B?Zi9qSU44NEpxMkw3QnBHZENiYnJqY3lPUzljY3l0L3dOQ2xQc0J4cHJ3?=
 =?iso-2022-jp?B?eDNhMk4wRys4Qnk3M1NjeGlUNExQWGpvMmZ2NEVrcElreDFDYlpoN2NM?=
 =?iso-2022-jp?B?d2VUS3c9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b53dac-3b0b-49df-a79c-08de0c94b0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 09:16:29.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvIMHFO5lUMSjTX+QOLwDWlw6ABgGet8+BkyWjTzl17p0/oGnKZg5DZV+vyl2M67lvYfW5oQXBuGurNSXz+oGkNWcPKPeimQaxZS/cjCs/P3f9zPqYP7nDySV5ON0jpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11095
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 09:16:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20184

Hi,=20

> the test case completed (without timeout issue) successfully on Sept 22nd=
, after that all IEC tests which are submitted on M-COM are incomplete (tim=
eout issue).=20

In a test branch, I reset the commit to the Sep 22nd version, which was the=
 last point where the test case passed successfully, triggered the pipeline=
[1] and completed the test execution.=20
It look 54mins[2] and 1hr 6mins [3] to complete overall IEC LAVA test job. =
Please note the kernel version is 6.1.148-cip45.=20

>We updated the kernel afterwards (Sept 22nd) e.g. Also some Debian package=
 update
>could have brought a relevant change.

Need to check more details on above.=20

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/21006=
42715=20
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1173497904=
5
[3] https://lava.ciplatform.org/scheduler/job/1317014 -> Re-submitted manua=
lly.  =20

Thanks & Regards
Shivanand K

-----Original Message-----
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>=20
Sent: 15 October 2025 15:46
To: Jan Kiszka <jan.kiszka@siemens.com>; balakumar adithya(=1B$B#T#S#I#P=1B=
(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O#S#T=1B(B) <Adithya.Balakumar@toshiba-=
tsip.com>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.=
Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; Chris.Paterson2=
@renesas.com; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@t=
oshiba-tsip.com>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D=
#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing

Hi,

On 10/15/25 12:08, Jan Kiszka wrote:
> On 15.10.25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Sorry to jump in here.
>>
>>> We may have a kernel configuration issue here - or a real CIP kernel=20
>>> regression. Going back a month to a passing test, we got this back then=
:
>>

these are the modules the debian kernel has loaded initially:
crc64                  20480  1 crc64_rocksoft
crc_t10dif             20480  1 t10_pi
crct10dif_generic      16384  0
mmc_block              57344  0
ahci                   49152  0
libahci                49152  1 ahci
sdhci_pci              81920  0
xhci_pci               24576  0
crct10dif_pclmul       16384  1
crct10dif_common       16384  3=20
crct10dif_generic,crc_t10dif,crct10dif_pclmul
cqhci                  32768  1 sdhci_pci
i2c_kempld             16384  0
xhci_hcd              315392  1 xhci_pci
gpio_kempld            16384  0
libata                401408  2 libahci,ahci
crc32_pclmul           16384  0
igb                   270336  0
sdhci                  81920  1 sdhci_pci
usbcore               348160  4 xhci_hcd,usb_storage,xhci_pci,uas
i2c_i801               36864  0
kempld_core            16384  2 gpio_kempld,i2c_kempld
i2c_algo_bit           16384  1 igb
scsi_mod              286720  5 sd_mod,usb_storage,uas,libata,sg
crc32c_intel           24576  5
lpc_ich                28672  0
mmc_core              217088  4 sdhci,cqhci,mmc_block,sdhci_pci
i2c_smbus              20480  1 i2c_i801
usb_common             16384  2 xhci_hcd,usbcore
dca                    16384  1 igb
video                  65536  0
scsi_common            16384  5 scsi_mod,usb_storage,uas,libata,sg
fan                    20480  0
wmi                    36864  1 video
i2c_scmi               20480  0

See also https://lava.ciplatform.org/scheduler/job/1316606#L1301.

Quirin


>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>>> [3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar-
>> cip-core/-/jobs/11344068159#L1724>
>>
>> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
>> QEMU IEC test jobs have always been quicker and are even now.
>>
>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>> As far as I recall, I don't remember the IEC tests run this quick on=20
>> the LAVA M-COM. Apologies if I am mistaken.
>>
>=20
> Right, I looked at the wrong log:
>=20
> "The time taken to execute TC_CR1.9_1 is 304 seconds"
> (https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068
> 162)
>=20
> Still a bit faster than it is now (448 s).
>=20
> Jan
>=20



