Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD7E6895F
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 08:43:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.69])
 by mx.groups.io with SMTP id smtpd.web10.8036.1730364231060277326
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 01:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=NLJIv25l;
 spf=pass (domain: renesas.com, ip: 40.107.74.69, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez1oNe1kN1Nk4EMnMCmRsofl0sg81AzDcDeFiNtaRKQBJhq7ggPP23m+hLw7jqgrYaNcRKu10/tiiGld+mD+SMxmTScslSRc2ewTSpU8AcO05kiebpI38qV5AwXvoH4cHtjMShx+4iHoJNCNeAJGbvD9+igDnfekkZolY8A6OFbq8jsrRe4cCUiszpUV62NJgGp+JW6fmnm0zdPc0t1pvZC18We/6VLDOny9EUAc0TB9GxDF1xqyXNAw2b60Y2qQerv48oQJDafOnxk2g77CrmH/nN0hHN+0iIbyUtlB6mdnEHuKz4xDWyMRS7f96VZ9VVzZM+Fck/1wcgB8+KgUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4RvUPAtzhSJVcSX81yhBKaB2AUxbM00gpR/tHEFB5U=;
 b=DIvQ6ncW3QQF71fFDV8mbWmCmYFje9Cz6v44ADD+XUY0gBN0/4UXNZTUbCX5WHm7eu2GUMXOAS4gvVTqsrG39VxIPPHBMJcw05Y8wmjhyCgLvEae1epQDaBg38KzAShNjgkFiaE9731fxyInsV+ow87MtomQJIDSXwB7ZCBfgjFb3qd2HTf5vS8XOmgbWjeAFjFxKZ+63ENLgSN5XZ69D8Zr4GBAsn5l4vjQrVQmZ3OiCQH+W51dPRlN2FmYm3HuYxstsNAFnAddfDpc2BZ6xcZ6saP9QkMfPZsmKzRAwbtYrK1rOExExrObmH//nLeB4zS5g0Zjgf12obhE/8Kesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4RvUPAtzhSJVcSX81yhBKaB2AUxbM00gpR/tHEFB5U=;
 b=NLJIv25lFCrKPXF52QBSMAT7Au4t7GKsesTjHAz83nlet85C8ReFlso4Cf1jHzWCg2lirEFQfi2y9ne0ncVJKEbptsst6TH2vAMF/dDd9ZTmqXLg6SEJDUa8ARuMslTnOqT6YBSXUvb47CsmXTn4hVIUOR5o0MJDLkziaY8+jhk=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by OSZPR01MB6280.jpnprd01.prod.outlook.com
 (2603:1096:604:e9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 08:43:46 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 08:43:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] IRC meeting
Thread-Topic: [cip-dev] IRC meeting
Thread-Index: AQHbK24NIVO3B1wivk6NoLPuUjzNN7KgiwTQ
Date: Thu, 31 Oct 2024 08:43:46 +0000
Message-ID: 
 <OS9PR01MB123896B927DD878624AFAB4D1B7552@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: 
 <CANgtXuNXafvoYGxbym-eBW1eoJELY0M9e6wuOKBZRn5XB4Nfhw@mail.gmail.com>
In-Reply-To: 
 <CANgtXuNXafvoYGxbym-eBW1eoJELY0M9e6wuOKBZRn5XB4Nfhw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|OSZPR01MB6280:EE_
x-ms-office365-filtering-correlation-id: 33dbadfa-89c6-4a16-5f27-08dcf9882267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?L0FjbDlFQXZNcXc3V2o0TjNaRnV3NW52UitUQ3pVZVBIeDBXVmw0NUJLOGxF?=
 =?utf-8?B?RWxscmtIekd1dWtUUnFIaXVpU0RmTmQzZUNmNWd2TXBNNmtEaW43c05GT3Ay?=
 =?utf-8?B?TFJUMkRFQ1dvWnM4blN1S0RmbmlCQUtQU1JKV2QvZHVjQXgwd1JmZVJ0QlBa?=
 =?utf-8?B?Y3hXanhJSnk5Ry9yMEVOdjNXaTdCeTAxQWUrbFBiRG1xaFVRNklqajhmUHF0?=
 =?utf-8?B?VjR3WjZxVjYwN2ZZUGNIdjdGbnJuNlhlWlR3UkhWREU3ajY1NVZNLzh2cmZP?=
 =?utf-8?B?UGR5VEdYUktmOFpacWFXQTF5Z3lSckVQdG5NV3FYV054VE14L3IxNEdRQzI0?=
 =?utf-8?B?N0JUditIR25KN0t5UGxhaHFrU1NxUGlYUGZpVzlkdURkM252UlJGMVlkb3VG?=
 =?utf-8?B?RDlOREREU0d0SEc2SUg0bDBPck5UWDhkWWRnNjU0RGhIMzB6aEhMOTNtUUxL?=
 =?utf-8?B?cVpDWGh4ZEVTcmlmU0ppR0NFWlpRbitneFRSVy9aREZOdnJ3RzRnVHpvTnlO?=
 =?utf-8?B?TGZ4UWl6N01FRCs3eWFXSzlYdmlqVkN6TlpnSm5oYWRqYVVGUi9DSSsxK05W?=
 =?utf-8?B?V0prNk5xK1c5ZlhOYlZPa0JOUVUvbEplbG8zL2RDQUVtWlRYc0FVUHFRa0RP?=
 =?utf-8?B?SmVtdmRFd3I0bElERnMrY2xWMy8vaHA4VTJuemhPdzdQNHk1SytaT1hvdGZV?=
 =?utf-8?B?bXp1YlNQdk5TeXJLSzdhQWI0NnRzSzZrTXU4ZHFJUHJpN3UrSFkwMUwvNy80?=
 =?utf-8?B?OXViaUU4UnhpK1NDUzRieHhsbHkwQlcxaXA4Sm5pa01BcXlmMk5yR3EwdXR6?=
 =?utf-8?B?RnNCbGRBYlAxZExUWHVacTQwTUdxWkViNGJKWE9yWkdQb2pVSkJGSVkyUkEz?=
 =?utf-8?B?U3NZZFdmRFlBcFZoZzdaWm1yU1V0Q25RWDV4cEZOaWhKMkplS0RDVDBuNjJt?=
 =?utf-8?B?a25uRDRwUWYrcnVVWjE5ME50c3p0clZNTVdhRGMxSW1ONGJ6Um9BN0ZJcjAw?=
 =?utf-8?B?VUVjaktDVjkrWWNTa3FOallyVzdxK2hodHlBOFVVQzZSRVJrTEIzeVZMVUd1?=
 =?utf-8?B?WVRBVGlkSnBYdERxSFNZUVRJM0wvcnY1MmZvOHVjSU8xU3JJYTQ5UEs4MW9o?=
 =?utf-8?B?a2RMaEFpa2xLNktLWmh5NHFDMkxqcVBTS0RJUVZDdEFFN1I3MThQa011WEVh?=
 =?utf-8?B?ODFXRXROZXhpVzN6SnJidTc5c3BHWmhyUzd0SFhxOXdzc1hob29XdUR0UnZQ?=
 =?utf-8?B?S2hlMHk5cjBuLzFud04ycDROeFpTSUJUNjRhQUljdkd5RUp5aHhhKzBqWVJ3?=
 =?utf-8?B?L1NXdi9WU3BVZnNCaWZ1L1RHVUZvOTl5WG5SRlpqSWdXZ2dOcERpNHZrM1V2?=
 =?utf-8?B?MzVtUHJjSlg5YlQ2djBXQUN0bE1WWGZVbzF4b3JuR0NJajh3bFVsWC9CZW8v?=
 =?utf-8?B?MWxIbGdTTW9EYUtWM1MyY0lFc2hMYW1nMmo3eFN3elowaENkYk10NWgwSnFX?=
 =?utf-8?B?Ykx2ZzhYUWNuZVRVUmk3ajdPWnJ6a041SE01MzM4cm1lQjQ5OE5JVjJqUXhT?=
 =?utf-8?B?YStyQ1Z1SUYrMisvNVZ1V2dWZEs3QnFxN3l2eVcxU1dMcEJpSC9GQW9vWnFV?=
 =?utf-8?B?N3pPdGd6dTNVb2p2UHdBK1FVd2xlbFl1K1J2eStXQysrM2Fwak4rc0hYK3lt?=
 =?utf-8?B?VlZLaVQ5SUMybUFiRDlVZy9vdGhFMVdibGQ5MHREbGx3ZG4ydWZtVU11Rk1h?=
 =?utf-8?B?ZUo5OFl5bVJXN1d3TFdTdWFCUW5qc1k5THpzcmVFaFI3MlNmTE9DM1RLUE5C?=
 =?utf-8?Q?65urQ+pyA18Es75iEQSFI0pRBu7Fi3OCxTzOE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0hFSjI4UU5wTnRSb25ON0xnVCsrZVpxcnp5WTUzanFZNi9ZbVc2ODlEVDlQ?=
 =?utf-8?B?Q1ZtelRNS0MvNUNiZnNGVkFqaGoxZWhKdFUwUGVaN2wwNTVrNjhvVkdnK0or?=
 =?utf-8?B?Q2NSTE5sVEVOZm9idUpXdUMwd3FjM3ZUOVM5Mjl0cHJhR1Q4Y0lJc3hyYnZN?=
 =?utf-8?B?VGVYQVhHMkI0MmpPcWtBQUhPOWcvN3FISVFlQ1VsZE5ydkZPRklQb3gxcFNy?=
 =?utf-8?B?MmpjSlhTZXRYeWRPcWhrL3dkbXUwQXVWSDRHbG9ldnNyb3VhQmYvbkVWSkxr?=
 =?utf-8?B?Y2d3cUNoMmdJQjFEVkFkWXVVN01FcFFhVlQ5blZaSHAvZWJzRHJxTFVuVnhJ?=
 =?utf-8?B?K0d2SzcrRG03N1N0U0lCK1NkV3VaZURYVVA1SHp1MGhmU3N4dnpoeXc5OFFV?=
 =?utf-8?B?MlpORmpBL3RrYjRQK2pNNnZxQnlsTmhQc3BPSjJQR01DSXloVDNWMlFTRHh6?=
 =?utf-8?B?Z1B1c2syZ2xCSmpBOGJUUHUrZ1dPT0EzYTMvTitIN3NCUnRDMzZRbjVYMkpn?=
 =?utf-8?B?ME1wd3ZpMEs1OVZ4Vkw5RjVvNzdkWHEwdktJaWwvYU5DWGdCeG1RTlpUQVM2?=
 =?utf-8?B?dzhIWlZNMllaT202Ni9adVJGOHpnWUJLVk10MUc2K0s1YXJmT0xqZVAvZFM2?=
 =?utf-8?B?MjhTY2VhV1JmR2RBeDdCakIzZDRBeEN3MVc2K0h2NVFnRnVaTHI1QnhpQ05k?=
 =?utf-8?B?L1BZNzFSc3RHU0tVWlRkMUNaZjRwM094QUgrQmxZYlBadVFoYmkzOE9BeGRR?=
 =?utf-8?B?ZWJGOU5kV0tzMGdqaktEa2x2YlloNW94MFI2VkR4UElGNXV6YWc0V3BUK0g1?=
 =?utf-8?B?SlA5RWc3bUt2cnVPcXZkVjZnR0ozaEZMeVB0ZU53bUZoMjNBVmxRczNXYU54?=
 =?utf-8?B?bk9IOUNtakRySWtOWVVDY2dtZWxWT0Q2VXFZbVcybXE5SmN0OHZSK29oTENL?=
 =?utf-8?B?b25IbUc5UDdNVDRaVGZoU2lTRTJCZ3N5bmFwYnpMa3pWQTgzRTdUNFk2TDl0?=
 =?utf-8?B?b1R5TFgvRXZ4dXBDWEl3cHF2aFRtT0ZocnZmWVNIMEx3U0dyRlNET2FiQVoy?=
 =?utf-8?B?SWtpUVZ6cjZDZFZhSTdhMkZuQkRNSFJUa3VWY0tEQVZKM1NDSjdFTFV2aXNr?=
 =?utf-8?B?d2xqSGZEZFVUQTUyZ1cyaXZmSVYyeTR2VWI2MWpTRDRDdE81Vit5dzhmaHFa?=
 =?utf-8?B?OEtLeXY3bDlQcWs2L2tNdFVWY2Z0SWE2WDZ5MC9BWXNDOFF6Rmh3STNKeUdF?=
 =?utf-8?B?TG9HdkowM082dFVGQ040ejV0TEY0N0J3aFhwTkJJK1N2T0JNWlRGVzdhZkZk?=
 =?utf-8?B?ajYxemR4aHFMeC9TZGNlMVAxakd0TTM0QmpQbklnNXJVb3lOYXFFVFZVdXhJ?=
 =?utf-8?B?bUgySkdjelVMTWJrMVlzZk0yNkNoclhjRHF0Ri84RWd5VmZnUW1wd2wzaFd6?=
 =?utf-8?B?Y3liNnZ2bm13T2pOK05mTDBYVWdCTzRRZkExTDVHZEt2aHVNSHhvTFppZWRU?=
 =?utf-8?B?L29HRzdwREdOU1Zub0ZjUE5SYmcyL01mRnMrbDNsdHFoYlhWK3hkZE5IeDlV?=
 =?utf-8?B?UnpxQkwyNW15Y01LRjhVa2p3U3BiT3BhOUJjU0JjN3JUYW5jOXI4YkhkSmRC?=
 =?utf-8?B?WXkxUHo3emErYVBVSVRCMUR4Qi9IazFVa3B6c1I2NThvbTNDVnlNV0xDaUx0?=
 =?utf-8?B?QWh1U2RWZG9IUXg3R2JrZnpDOW4wNzJWaHlrMzRnWWtnZzFGUEVkMkQ1eFJ3?=
 =?utf-8?B?UUd5RmVQZnFUdkdsWDE0Q2krbjdKd21wTVNBVFlkSEljS0Q1QWpJTGJrV0tU?=
 =?utf-8?B?eUR3MkZCN1krVnpGOUlqNUY3Z0tHb3pZbGd2QXdhMjBwU3oyQ0kzclVFN25B?=
 =?utf-8?B?c01ENFA5ZHUya3R4Vm41Um14QzZpbE9Bekh1ZjE2M1g1RUJqQ2xHNDBGSlNP?=
 =?utf-8?B?amZJYTg5NmpCVUgydE5xbHpPSWJtUTRWK2U2aXY3blJFdHBOYWQxek9rNFor?=
 =?utf-8?B?YWtxSDV2YUYwRTRqQXdPKzZ2NTVpdWdOVnZab01XenZ6TFZxR05EVUhsaHMv?=
 =?utf-8?B?Mk85NDhoblc3eDBONDVVaXJ4RmZLTFRiS0ljc3pISXdNejNCc2x4MjNxalNR?=
 =?utf-8?B?dzhuU21CaGRvUWxmblpiZFhIQVZ5K1grSzBJaTlCVEdzK1B0dkhGTEJaOHZ3?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dbadfa-89c6-4a16-5f27-08dcf9882267
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 08:43:46.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpf5gDIN/egS5zMoPIYQdlXRFiR0NqCnVB2PuWjCDy1+Uc28lACCdd0/vxGL9IDCOh8Uk+SDLub+0KplAdyOpXe8z6eWykShmjTLHeImjVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 08:43:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17126

PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBBbGljZSBGZXJyYXp6aSB2aWEgbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFNlbnQ6IDMxIE9jdG9iZXIgMjAyNCAxNzoyMg0KPiANCj4gSGVsbG8N
Cj4gDQo+IGZvciBwZXJzb25hbCByZWFzb25zLA0KPiBJIHdpbGwgbm90IGF0dGVuZCB0b2RheSBJ
UkMgbWVldGluZy4NCg0KTm9yIHdpbGwgSSwgc29ycnkuDQoNCkNocmlzDQo=

