Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB7CF64A2
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:16 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.89])
 by mx.groups.io with SMTP id smtpd.web11.15724.1726739140389857878
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Sep 2024 02:45:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zwoG3laR;
 spf=pass (domain: siemens.com, ip: 40.107.22.89, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozHBqrCSgIhyNEGpZAejYoWJZIJidOUFcWvnWwEcMip9cYHkoiWYOVe95R8KBsgbekTmjG1clNbo4G/PRPCtEtX19OtyxxmWLJJvsVH6j1rRF/66XYScqNiJ7emABPRHX1O0k7MoFKsod05SE1RUBrNU+q4Zs0CWQF0vEi7Q64fEzrSO/MrMPD0Ok162JPBRlMUMmtdxuGVYZf7FPQwWhOkdfYR+gfY7z1EEAAAlpul+VPyL/1d9b3NzALXIbaOvypHT+Akl1ahBl01docpTPmB8Ae4tAmrh16hsN2Jzrr9CFM3yN6JYTo+aNUYmzn9Z01/8Gz+tDngJlVd7aBvj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FyBW7eCw2fVq4X+Qt/nirG5jwWdex5ajgKWphg8ZEw=;
 b=pLPCaWRZCzgbontnCbzwi4oRkPB3E4D0kgdClEcOcRcBciqXht2ZrhznsUzYaIPkYViWAtJycfrKRjLFDSyf5ewAv3x5qSkkKEnfaimfK9Us1KYAR6/kDkSq5u8DLno+q7tXKCsjQFPml33TjS3OsP6VEeADP2NToJGPOkOtNi5LOEcfClgug01EzAdyb4efJygMow0oXgSMmI1s1//nhz0iIrLr+HC+X77hh5K7xFXC/ZhpKoixTTqSggZ29Ia1IExyy1hy4ZXMhWwGLeYdz0h38IEnXlgpMxq9iH8C3oZ0UtEI5RhKcISH1sVUdOaAgHWG9CRsTrOgi5KjvwouoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FyBW7eCw2fVq4X+Qt/nirG5jwWdex5ajgKWphg8ZEw=;
 b=zwoG3laRL7tivXi9EfhVbk6rfHfSHSJ4acMYe8Yuwv+R8vsNdnt1NUCDY/khJ9ydQfYfUcm2Wcxo1uy/YzKWV0HWtORW0ft5U4GR7O+VAa/AiSv/FArR8A1w9s+jmH5D8xorHBUZmlQ6R1GdhuT7fWtcJmO0c8UaHo2W3Mr/nNmPLonBVJLSW9FzjkgsPLVf0X5cDS4ae5zU7cB2TOIdqq/SJL4Y2T9NmU5wc7dTleKVIQlVKY74tXwK2mADT5Pdb8uBYgd/bF4+fvGdIC5Lmwhu4gIMkQsQQgrwIITbrEpnH4C1gvmbQznBRufnFT8E9clFD0SI0aJ+iPeli2+H+w==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU0PR10MB5751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 09:45:29 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 09:45:29 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "venkata.pyla@toshiba-tsip.com"
	<venkata.pyla@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v4 0/2] Add dosfstools recipe
Thread-Topic: [isar-cip-core v4 0/2] Add dosfstools recipe
Thread-Index: AQHbCngWWN/xDv3ZfkadXX/qorKpg7Je3GEA
Date: Thu, 19 Sep 2024 09:45:29 +0000
Message-ID: <04c34b86139cc06e828da6242306dd54ddaadf61.camel@siemens.com>
References: <1788B037A0B186C6.25332@lists.cip-project.org>
	 <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU0PR10MB5751:EE_
x-ms-office365-filtering-correlation-id: a97bc6d3-c8bc-4131-0e42-08dcd88fcc09
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b0hUcVVianZvOTl4NHJjc2E1QXlRU0M1TlZuNFFIZkFZQ3E2aDVtZnRiOURq?=
 =?utf-8?B?US9mbmhRbk51WFBMTUN6UEIwQ1dnNW1lTU8vV0NQVmpzdElhUEU1Q1lURnpQ?=
 =?utf-8?B?c0JJdmJDRkhOTFU5NUJrNnU2YUdka0ZMQTg1Y2xrU3BldGttbXNoRHNUOFox?=
 =?utf-8?B?UE9HdW8xU0NMbGNwYk04TWpqUitxU1ZSNkJxQ3ZHWHFCNEc1YWwrVzV6emdx?=
 =?utf-8?B?a3RtZUVGK0xjTGlJR2s2Sm1STjVKaXhWUi8wUW11eFppR1UrcUYydmVSK2hE?=
 =?utf-8?B?WWhHVDFUSTM3UmgrMWh6Zmc5cGxGTlB6c0laYjJTL1BJb0FqS25KNzFuWmMx?=
 =?utf-8?B?RktENXVQbkt4MnV1bWh3TG5nTldBdUtVcGthTnRJMU9uUjdVcEN3dGlidVhX?=
 =?utf-8?B?S3F4OEFnY2l0QjRFSkpTbE42NC9GYUJpT0ZacEl4R1BpZ2FpbG0xcEN2U295?=
 =?utf-8?B?U1hGVmFSZTRaeTZYM3NDWmN6T0FudzY2ZENjeHBQb1l5c3pYWEhnaGlSLzJI?=
 =?utf-8?B?K0VTdHNrdXcrU2x0NnJ6cDRYTUdrMndUTDlCZTF2MGNiQVhRMExzTFh4Z3Qz?=
 =?utf-8?B?cVNxYk5kbFg3UEpmSG82RHVBc3dPeXJkTU9mdGk1Sjg5bDJObmg5WHEyUkxp?=
 =?utf-8?B?MXVVdU5CZUM1dHRQVlNxNUowZThzOGltaUR1djQxQ1diRTl3Q1I3eTZLdmVU?=
 =?utf-8?B?ZmJneFN0ckp6RDI0VzVDdkZaMjIwdU4yQjl1ZmpzZmVRUGp0YjBoSDM1RFhz?=
 =?utf-8?B?cGQydEdwUk55bE1xMVVPWitRWEJMenpRd1EvclZkUzFYbGN1REVTV2tFUS9k?=
 =?utf-8?B?MStweUJYdUtCRkdWU0d1SGtlTGNxSTQrdSs3bzd4d0dMMGQzZGxLeExVK0dB?=
 =?utf-8?B?N0NFbGtnTGdaaW5xR3oxTWdndTN5dEthRHE1Nzg0U0NSZlpOS0hqVXZnYldG?=
 =?utf-8?B?TEVHbkY3ZWdSSFczT3VMQk91QkFhc2dJRVpqdmFaZzFTajlqa2FPaGpKOUJB?=
 =?utf-8?B?cVdLYTA5UitTakp2WGNleVhhaEFXdGVsL3hFVGRrOFNvbW1xZjk5T09mcGRh?=
 =?utf-8?B?TWdtQWxaMk16RVFZYlZ5SUl0TERmTE9RSmhNVkJkc0ovL2ovQWk5eTRuY2R6?=
 =?utf-8?B?NkpBSXVyeTFxU1RubnEyWkF2akxGYjE5WVM2aVN1SHduNlZVS05CRGJCUG9U?=
 =?utf-8?B?ckEvSUNtLzVYQXlMdlpDQXBSTjQ1bDlGc1Rxd0FvSzRHMDBPVWhWbUNDRGsr?=
 =?utf-8?B?ZjB4a2pKWVFHR01lT0JINWUxbGMrRk03SWw0MDREYXhxNTFnY201czBFK1hM?=
 =?utf-8?B?VlVFMGtSSi82SjY3UjlxR3huM2IzS3IwVDJ1SEw1anRZM29lYWdDckdGVjdm?=
 =?utf-8?B?Q3Y5TzFSVjJPcW5iS2FsMWszOTNGN1JXVkwxRGxqc0FVNTZBNmtGTC9rU2xE?=
 =?utf-8?B?OHM2U0NPU2cwQm1lcmdXM1JtUjRSelBLdEdhU3BkM3BrRVY3K1gxdzhoVW1H?=
 =?utf-8?B?dk5tN1V1TnVpNk9OcjA2M0V6aG95TkRxWjdJdlBtTDMxSnltazMwYzduamRU?=
 =?utf-8?B?cko5SVRDSE9ocUxpdFhLaitSbFVWdzRVRWxNN1lWOG1PeFJwMmptQTEyN012?=
 =?utf-8?B?Ny9SWnNLRHlRNDJRTVFBRUxQMWpmNkZERXpoaFVUN1ppbFA3elUvZm0ySmVE?=
 =?utf-8?B?d0d0MElpWkZHU3FBRDZva3Z1THhTMlBpbGNhMkZZbWVDU1VRQzNZTXVKSEJz?=
 =?utf-8?B?NzNjbGUweWF2WHVaVGVYSkZzL1FkbGNJM1duenltSGJTTW9FTVpmVUs4NThL?=
 =?utf-8?B?RUNXMm1vYU9EQlZSTGdvVEg5dnZkdzViSUNKS2cvUGFjakpjMldSWGJBSXVs?=
 =?utf-8?B?djdHMUkrSVFDREhueDF0Vk5ETDFwUkJEeDJDUldZeSttdmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T3MyQXFTaFR1RHdtQ0c3MXJUV3lKU1dWV2c4clV0MUQ5NlhCcnZFNmMyMHJa?=
 =?utf-8?B?Nm5ZUkQ2eXA4YkFqT1N2dDRjVjd1RXZyQkxyaHQ5SXQ1NS9pRG0wVUdJMWpP?=
 =?utf-8?B?cUNHSi9CWm1jbFFxM0dJcXhwQmthNTZWaXpnbGJGQW14d2ZhcUxwcVk2aEQ3?=
 =?utf-8?B?THc2ZHJDVnhtS2trSDB0ekN3c2d2dVdzUG5FTmFKZ05pSVFYRHh2WlNuMEx3?=
 =?utf-8?B?MjZscGRldWNPQ01ZSUZZWFNlREh3RnFzUzJWQXJubFdhcWs3NlpzZ24zTHlU?=
 =?utf-8?B?Uy84aUlZYmxyMnZmWUtTbzdlMFZFdjJIM0VUcnQzSjRnM2FKUnUvaWpGaE5a?=
 =?utf-8?B?YzhCelFBbTRrSVdJNy96cDF4Tjl1RWI5THhNNkJsTmRYL0o4ZXo1TEl1Yytv?=
 =?utf-8?B?bGpPTFRXK2ZmcjFhZ0U1Wk9YZUNlMnhOT0RvdzVNZTREVjhCdWkrQy9HdTBm?=
 =?utf-8?B?bFlsRkZJZHJkQkJCS1puTXpqMG9ic1JRL1I3Zis0bndicEpNS3h6cmRxR0ZQ?=
 =?utf-8?B?cUFaWDg3ckR2ckt1bUdSLzRjY0JjODBKeStWeFpvWTBSTzgybzNSdFYwbXcz?=
 =?utf-8?B?c0JnajFnNm8ya04yUUdpa3M3ZnZudkc1Nk1rWGU0WGIrK01JeFhud2lFaTZ0?=
 =?utf-8?B?Slp6L1pqTDVhSzNWMlphY0p0Y2FKY05oS1UzWUFCQjlrRmxXVGx4ZjhsT2h0?=
 =?utf-8?B?NWRhcTMyVkFSSElHVDFBcVdTdnU5U0hzNUNEK0loQWVuTDdrNmgrL05BaWRS?=
 =?utf-8?B?Uy9JSFhmQzFyNDEzZFMybTVVa29WSVhqRHFiZVA5bWxTUjh5NG11OVIzT3NI?=
 =?utf-8?B?eGZxTStUY0xkeTZjbHBMak0vaXZPSk9HcHRzZHc4Z2ZhY0V3OE5RWTRYZHZ5?=
 =?utf-8?B?Uno0VW9RSGNVc2d6SzlXNW92OEhhNXRUMHdWd21GbVpQSDVub1hkVUFFT2VF?=
 =?utf-8?B?Z2lLOE1mLy84U0ZjZTNUV1Q0cHZ6aXUwWnNaTVNHU0NVckdWUGdvb0JqMjJL?=
 =?utf-8?B?REVicExBVjVhekt2MnFIUTV5c2pjMlVTbWl2aDZsT0Z6bkNLZFp2T24vVTZN?=
 =?utf-8?B?Y3BMOVNxblR4bUpGRVJnZWVoZmdGUE9yaGc0d1BrMDB5dXVOdmlvMGVXTzht?=
 =?utf-8?B?MndQWmRidTVnTzU5eWh6VnZzdmVtY1lJQjNkZVdRakYrVjFvY3VXakhtOGpK?=
 =?utf-8?B?MEhxTlptdHVRZnprWmpiZ1JJRVVGZ05Va08rZ3VIKzlHNE54UDBKRlNxaFRO?=
 =?utf-8?B?VnZUbzZmVDR1SE85REtaRkI4WndpZXdzemN3bFRxTlJiRWF0YzdDMHJldEFk?=
 =?utf-8?B?QjQyZFZxVzJtKzdJS2NYRmRKR2pUWkdIaXNFWWFsQTl4alFDZ05xSFNyOU5G?=
 =?utf-8?B?RTlRYjF0MkQ2MTdzU0lMRURISVB2ZUVPMnNMeU5VcGJuQnZUeWJleDREUWxY?=
 =?utf-8?B?Y3ZmbFJMV3VvUUlpbUVYckJVNTVVbS81WjhLM2hZd005eXkxQUNFVC8vL3Jx?=
 =?utf-8?B?a0R0NFJTbkV5dmhGKy9ES0hrOFBZUGVoWmxRaXJXdGc2V2dBalRaSThGRStu?=
 =?utf-8?B?cEU4ekJTSVZCUDN3d1I0LzBVRDVXdW10UVRHUGZDZkZhdXBRVEQzaHNNdzN1?=
 =?utf-8?B?TUt4blV0dFdrRmVwWGt1OGpvdTMrSzEzT3ZZUHprTlBTOHlIWmptQ2xYdkVa?=
 =?utf-8?B?NXpsZllESzlkcHVoSklOY1Q3WnhlNkJUS0JsQ2lWeXkwTkNEbi9vaElhZFlP?=
 =?utf-8?B?UjRxMVk2U3Bma1dJaUJWOFgrZFgwNUluRHdTcHI0bFc0V0V5UVdDeDJUcWpS?=
 =?utf-8?B?NTNxR3Vid01RWUxsRW81TS8xMXV2MVpHTDIxa0VKVGtFN0R2TTloRDl2anZa?=
 =?utf-8?B?b0tRaTFZcHlFdFloZnoxWTJqZUY5Q0lBZSt6a3E1aWMyemUybEgrNzNtRFNX?=
 =?utf-8?B?WWlGYU5sb1daUkN3dTZiQ2pkbDFrVEZnM2I4SURvU1J3ZFZHTFlVc2k2YWpS?=
 =?utf-8?B?Vjc2OHByQXRYUzhRWmF6VkpJaFdjMUwrZzJhRUVZT081aXZKcENaRlFrRWox?=
 =?utf-8?B?OGFQeTJNYVIrZnZBaVRZODQ1Yk0zbVZGL0RBVHF2YzhGK2ZOSUpSNy9tc2gx?=
 =?utf-8?B?bUVsZWEvQXlpQ0huOW5pWVlpZFY4MGYreEFHQVQ0dS9iU293RzBCdEFuZm5Z?=
 =?utf-8?B?YmExc2tOUElxWlZLQ0JXalJWZ2lyVFdudzhwZGNySmtpL2hxU0FTN0ZqcTly?=
 =?utf-8?B?aTFVSUt5L1BiWXlKbko4M0IzU3p3PT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a97bc6d3-c8bc-4131-0e42-08dcd88fcc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 09:45:29.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtagzoSZ0cZM+fFSHOaF+7BOlBQBwQorNHCYt9k3S/9GkoP6lMnqlEUWpcsDhuxmgwy+phvHD4icm1Hym2eJfxhGynpPGIG4gMbUuCnCGck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5751
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC25E78AD1E6C468D8E21D0DDD4080C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16930

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDEyOjE0ICswNTMwLCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10
c2lwLmNvbSB3cm90ZToNCj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGli
YS10c2lwLmNvbT4NCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkIHJlY2lw
ZSB0aGF0IGJ1aWxkIGN1c3RvbSBkb3Nmc3Rvb2xzIGFuZCB1c2UgaXQNCj4gZm9yDQo+IGNyZWF0
aW5nIHJlcHJvZHVjaWJsZSBET1MgaW1hZ2VzLg0KDQpIaSwNCg0KSSByZXZpc2l0ZWQgdGhpcyB3
aGlsZSBkZWJ1Z2dpbmcgcmVwcm9kdWNpYmxlIGJ1aWxkcyBpc3N1ZXMgaW4gSVNBUjoNCkhhdmUg
dGhlcmUgYmVlbiBhbnkgYXR0ZW1wdHMgdG8gdXBzdHJlYW0gdGhpcz8gVGhlIGRvc2ZzdG9vbHMg
cmVwbw0Kc2VlbXMgdG8gYmUgYWJhbmRvbmVkLCBidXQgbWF5YmUgRGViaWFuIHdvdWxkIGJlIHdp
bGxpbmcgdG8gYWNjZXB0IHRoaXMNCnBhdGNoLg0KDQpBcGFydCBmcm9tIHRoYXQsIHdlIG1pZ2h0
IHdhbnQgdG8gbW92ZSB0aGlzIHJlY2lwZSBvdmVyIHRvIElTQVIsIGFzIGFsbA0KRUZJIHRhcmdl
dHMgYXJlIG5vdCByZXByb2R1Y2libGUgZHVlIHRvIHRoaXMuDQoNCkJlc3QgcmVnYXJkcywNCkZl
bGl4IE1vZXNzYmF1ZXINCg0KPiANCj4gdjQgY2hhbmdlczoNCj4gwqAgLSBkb3Nmc3Rvb2xzOiBB
ZGQgcmVjaXBlIHRvIGJ1aWxkIGl0IGxvY2FsbHkNCj4gwqDCoMKgwqDCoMKgwqDCoChObyBjaGFu
Z2UpDQo+IMKgIC0gZGlzdHJvOiBTZXQgZG9zZnN0b29scyBhcyBidWlsZCBkZXBlbmRlbmN5DQo+
IMKgwqDCoMKgwqDCoMKgwqBSZW1vdmVkIGRlcGVuZGVuY3kgZm9yIGJ1c3RlciByZWxlYXNlDQo+
IA0KPiB2MyBjaGFuZ2VzOg0KPiDCoCAtIGRvc2ZzdG9vbHM6IEFkZCByZWNpcGUgdG8gYnVpbGQg
aXQgbG9jYWxseQ0KPiDCoMKgwqDCoCAoUmVtb3ZlIGRvc2ZzdG9vbHMgZGVwZW5kZW5jeSBmcm9t
IHJlcHJvdWNpYmxlIG9wdGlvbikNCj4gwqAgLSBkaXN0cm86IFNldCBkb3Nmc3Rvb2xzIGFzIGJ1
aWxkIGRlcGVuZGVuY3kNCj4gwqDCoMKgwqAgKG5ldyBjb21taXQpDQo+IA0KPiB2MiBjaGFuZ2Vz
Og0KPiDCoCBkb3Nmc3Rvb2xzOiBBZGQgcmVjaXBlIHRvIGJ1aWxkIGl0IGxvY2FsbHkNCj4gwqDC
oMKgwqAgKG1vZGlmaWVkIGZyb20gYGRwa2ctZ2JwYCB0byBgYXB0Oi8vYCkNCj4gwqAgaW1hZ2Vz
OiBBZGQgZG9zZnN0b29scyBhcyBERVBFTkRFTkNZIHRvIGFsbCBpbWFnZXMNCj4gwqDCoMKgwqAg
KG5ldyBjb21taXQpDQo+IA0KPiDCoGNvbmYvZGlzdHJvL2NpcC1jb3JlLWNvbW1vbi5pbmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKw0KPiDCoC4uLi9kb3Nmc3Rvb2xzL2Rv
c2ZzdG9vbHNfbGF0ZXN0LmJiwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI4ICsrKw0KPiDCoC4u
Lkhvbm9yLXRoZS1TT1VSQ0VfREFURV9FUE9DSC12YXJpYWJsZS5wYXRjaCB8IDE2MA0KPiArKysr
KysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE5MSBpbnNlcnRpb25zKCspDQo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtZGV2dG9vbHMvZG9zZnN0b29scy9kb3Nmc3Rv
b2xzX2xhdGVzdC5iYg0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWRldnRvb2xzL2Rv
c2ZzdG9vbHMvZmlsZXMvMDAwMS1Ib25vci10aGUtDQo+IFNPVVJDRV9EQVRFX0VQT0NILXZhcmlh
YmxlLnBhdGNoDQo+IA0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVy
dCBDZW50ZXINCg0KDQo=

