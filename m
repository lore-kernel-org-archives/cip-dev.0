Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A7C369A2
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 15:44:31 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.37])
 by mx.groups.io with SMTP id smtpd.web10.79290.1744127069616217572
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Apr 2025 08:44:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g67w4o5m;
 spf=pass (domain: siemens.com, ip: 52.101.65.37, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOEs14Artu9hQsl3SpUnHdgUc/JIEnXZEZe5IxUreq0DXspCAm5Sw2RUG6cyXbm2/UXNUVTZLiLybL0/I+he7bow0FZwKClATEQNQ3tgNUVQmStVh6Cym7J2s6ioHVqrScRgzGBH3iWwwdntbWDWNMwyYQt9xbOqIW+JJaLFPGswtfgtM64MK6Nh9eBXX4e9mShZXWYR6+W1J9+pWSURQtOinsDZ42g1SI7T+RyMGXhuBbfvM6a2kdlCjmJS3bxrZIs3tBSbAOSlRr7T4se/+V1QwNsH4lybHqV3ro1DxlXV3R2VxGEK53Fo2JKR1G7RQ6eX42znn6dYjSvAxlXJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTzkRimaIQFdX1tYEpLlYlNuWdQWWtMo1G0GYZdX+w4=;
 b=vjKKLRh2+dDppiYFk660MpnEIGzeQOacIDT2Z1H8DZoFXMwuiTMwwrm9fa/fwCmY9ulF/W07J0R/+jLGNNwPzxajo7jojjurXvYRqsWdBjI2QmjbgzNDOvWshbeEq49Dyk21MfsMXmWtNr7SvTr7xD4IQl6jcXYjgKsVTC03+praeoHjSL1uXXNcoZ+eHt5hDH2J1ce/RS2hZxahCfiSrUxcpY0cQrlrb0qzARLbSCodTXTm+ycS5esx4Bm1t/6nGbcQfzagPaljCfMdS/02o1S+qfVJSM9npGKcnD8Z9aQjlCCxZth/3JqaKV61Tmfdco8aY5giYdoG251Wt7p4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTzkRimaIQFdX1tYEpLlYlNuWdQWWtMo1G0GYZdX+w4=;
 b=g67w4o5mttU8U9d0Wqu7tANVStWMqMbvhiW32ZgEQGd2zmzbxATQcHhw850lqgSoBUxnm05at71GWCCPTzp3OtRZDHqR2hjjlCALFTO6BDMjNvkV1uxdJfqfndCJQX8/kYWz1G3ISZlvdRpsJj5qLXKydQbsIGT/wsVxWI19HDvYQJZSlPLSnuFs5GLrGctEyi9zZwmVHqRppDnPffhM+97E9eiUNEYhkh65IR0bgjpnf+TkMG4NQYng2WqraT6GFdpQPU0AIkSZ6KgRzcDGBijno4qA1DLCMMNg5LIIRKUILH0qBSCppVoNUrKjWzS77DyOqiGhgGfHorxgfd2PBw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 15:44:26 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 15:44:26 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Kowalsky, Clara"
	<clara.kowalsky@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make /home partition
 optional
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 0/6] Make /home partition
 optional
Thread-Index: AQHbjblKa87pQl+i2ESHAYvxLsNBJLOaBDOAgAAaj4A=
Date: Tue, 8 Apr 2025 15:44:26 +0000
Message-ID: <9417d96c0f23fe006c140b78eb7c87272681c052.camel@siemens.com>
References: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
	 <18345D248EC382BE.21691@lists.cip-project.org>
In-Reply-To: <18345D248EC382BE.21691@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB5PR10MB7776:EE_
x-ms-office365-filtering-correlation-id: 20b72624-bd57-4e3e-b5b3-08dd76b43df3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M1FzczY5bFF6V1FkaHM1MStPSnh6ajVUSkFDamtYWDc5eWJtL2JuS0pQOHg3?=
 =?utf-8?B?WjN3amo3bEh6MjRBUUcyWkl6d25SRXZML1V4TkRBVjdYbEdwSFpHMm5QQ3h0?=
 =?utf-8?B?SEdaRlM1WkNDQ29wSWFNSGFKTkJoRkxpV2l5cXVtRzRhTko0czdqTHR0VUdZ?=
 =?utf-8?B?Tlh5SG5SNVUvbmZVYjFScHM4ZndjTW5LZnhLZ2tSYitLNmY4azR2d0VqOE03?=
 =?utf-8?B?Wi9seUlXaEtIYkJMdm53cndIeFZZMnhodko5alEvaEVhRzZIaU9Ka1orcmJ0?=
 =?utf-8?B?b2xDaCtSVlNLc0hqTXRiSENSbzVVM1ZRcU4vSkNjV3Zrc0dNbkhOclRQUjZT?=
 =?utf-8?B?N25QcGhFQzlMdkdsRzgyZlJLNUxaZGtSeW1HNmp1OTcyc2h3ZHJsVkVrZkVw?=
 =?utf-8?B?dW1kVzg2eGNyWmdmZ1lsL2Z5Qm9ISFBiVjRrZkMyZjgydGQ3bUNvT25xSjZ1?=
 =?utf-8?B?WS9QcTF4QTJHTWpHREV2VXo4dFVWUmdBTmRuMjF1Y01sUTh3MnA2cnFzditL?=
 =?utf-8?B?WUtIb1FoRWhoeHJoR3AzYThWYWRadjM0ZE1MZEtFazNjT2hiVnZPcnk1aWlQ?=
 =?utf-8?B?SWpwZm9jcmU1eGdZWWVFN3JSbXErbWlUcVFON3RnVWZURUNwbTZ4SFI3VnVZ?=
 =?utf-8?B?QjZnYmtBLzlTcnpycTlNRHZjUTlHRUZZSkxpbkdlRU0vUFUwUTZjYkV4OXQw?=
 =?utf-8?B?Y0pmK0Y3eWRYa2V2bmVHK1dDZENNL2YzUnVHZ0lZdzlTcldvWHpJdll5Z3Bu?=
 =?utf-8?B?Y1FFVGZUSktZTGc2TEYySEw4YW5SODljbkovZHh4VmVROTgyY3dULzNTN0s2?=
 =?utf-8?B?V0tiQm1qUWZja08ydjVzUktmd1hyWTFGc2hnSHp0YmNtVEg5Zk9RdExCclpM?=
 =?utf-8?B?L1R3VUdRdmx3STJYdXF2T3NDZ2dGYkViTjRMeTdERlVnb0dBWHNWeDV3VDB5?=
 =?utf-8?B?N0xYOVBIL25QMFcyN1gwZ21QNWN1cG9DTHZaRnpNRkdFUnFKeU1tQXdDQnhJ?=
 =?utf-8?B?VTFVclYyTTN5UVM3Y25hV1lYbytKYyt6aDhXR1RIeFQwRGIxOTFFVXpqRHAv?=
 =?utf-8?B?aFBETU9RbWFKSWdZVHVhaXpNZlB2LzVYbWZkeEhWRFJlUW5MS1o5Q1NlcjI0?=
 =?utf-8?B?N0x1VjNBM2VQbXkxT3FlZk5JanE4T2c1Vm54Tkp0THVOekxtUkZyUG0zQW4y?=
 =?utf-8?B?TWdkaU9rUElHa2R0c0VGUnBiSElWUEtvaXRZZ0UxUDhhVlRNRzZNUndGRHR6?=
 =?utf-8?B?YkV6eGw4T1ZPakJCWjFrSDZSbmRCRkFGZUFZQkZrTGNaZ2V1b0JKeUxJbUUr?=
 =?utf-8?B?akExR2cvM2xZS01tVVV0amg0ZVQ0cVQ0c01xZURzaG5iZ3hJYVFQZlNTZzAw?=
 =?utf-8?B?dGNuZlZuYWE5WSszUzM1WjU1M1hsSEQwLzd4eWxSQ0lId1praXVUWGhKM1VY?=
 =?utf-8?B?K1pDSmFjSGo5RVYwTnpibDVmMzVDdDlvZC9jTkdUbHlXRS9TTStZY3YwbzVO?=
 =?utf-8?B?blBxaEk2MTYyT25PN290L3haSzViY1lna0RJRmsyQlV3bElPY0YzYnY5L1dR?=
 =?utf-8?B?WUtYL0pHMitsOGdXYjAvUkhrd1hvenpEMHFLd2hvdWo1V1BpZ0haUjg0c3cy?=
 =?utf-8?B?T0hRTXBUb2hDR1BpcVdHUUpFbXowQ1lkbm03M3U0WFVMNFZsT2JCSHNyQ05L?=
 =?utf-8?B?eW1PcFgvSkZnc2hKVy9CSlNPb2JidGdPcG1RNFlBamNlb0o0aUdJRTVTMlNw?=
 =?utf-8?B?cnNWVlU1dE1zU21LekJVVjZmeTRZbzAvMHcwdlZsMmpMN1NLMmZ3RHR0cUVM?=
 =?utf-8?B?VlZkN0NQZVhteWFWeC9TSGtSdUlpVWIwQ1hyRmpDZWE5bXhjanRMd2E0bVFT?=
 =?utf-8?B?UjUyRjc1ekg1TytTYk9ETGV3K0tjLytzOGRHc1FBVzJWUktwNmMreEZFbmhC?=
 =?utf-8?Q?ysQE5Ua/vgw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WDdFVHhRVGlwV3FBbXMyenJ5akxKU1FYZDhMNCtQYlJqUVlhclF3UFJja0VE?=
 =?utf-8?B?T25uOGw5VnRiZ0YvbEVFZnR0RXlCYzcveVFVbC9aT2wxbmd4Tmx6Tno0ZG9j?=
 =?utf-8?B?aGdmQzNublNIOTRhTTg0eGJkTnZxMlhVbzNNWHpCUnE1VThzTk1VMXExVEpm?=
 =?utf-8?B?bkp0VUx2angvV2xLQ0VUbGd1QVdyY1ZWdDNmVmc3bWdlZ2NJbzc5eFR1Y0Rj?=
 =?utf-8?B?UU44elRkQ2hLcDIzVmM0eUZKK2l5Qkd5Nzd1RU4zV01id0pvSXlvUnFXS1J5?=
 =?utf-8?B?NFN1M2xFNU1lZGY3em5Xc3ZKckh1ZGpZU21QWE5jMms1aFVZSWZuSXNBNHEr?=
 =?utf-8?B?dERkcGd3NUR4NDk2aS9ORms2Nmd4eHp6ckpaNHROaVVKTTVMZGk2MU9uVTVk?=
 =?utf-8?B?eFUwUTdNcGszdnQ2R0ZCclJ5ZnoxY2RRQXdMdHZMNStwM2NwQTVXdWZGOVl1?=
 =?utf-8?B?L1pPY0w3d1Q3akJzQTZiL3NOU1NJdm9KUnEraVdyUFhTbHVxWDA3djlBNWdR?=
 =?utf-8?B?WUdnelRXMDF3SkFXZnVpRkt3NE1wb1lhSytVclhJVXVFSnVKZjhEblVGdnVO?=
 =?utf-8?B?U2ZzaGlGZW56MjhNYWZXKzBjOHRCR01oSmdOTVphZyttQVFmcXNJZzdWL0JO?=
 =?utf-8?B?TEEzU2tKS3BLOWhBTTJnMlJibkZuNmF4b04zMDJkWXJSZGpxSks3aEhGejZh?=
 =?utf-8?B?dS9WVFBXU1U0dmx0NUpWK2xiRjdPVHY2T2ExZlcvYnd0QUg3bkVJSlVSQlEy?=
 =?utf-8?B?NkVNTGZPbGh4TVY2eFg4N0lGSjl1b21KUEZsTHVxZzNhNDc4ak1NdzZqZnp4?=
 =?utf-8?B?NFE0N2JuSkxFRWFtNDJOUzgzMFh4Z2h2VGFyWG96VE82SWpUa0tZcUMvYWJK?=
 =?utf-8?B?VWFsek1La2YxSlNmMnhlZ1dyaStHbEJtcElkSjdQS0tIU2tLVzl2NTdqTnNy?=
 =?utf-8?B?aE1RWEMwUTFEVWJxV2dGTFB6cUMra1hEZTNIVjd1UStDSnRZWlgxaXNuL2Ry?=
 =?utf-8?B?SUt2YnNKc2I2WkdhU2p0UUpZc2l0a1VCZXU3TXFYUFNVSVBLTFlpUTVNcFVs?=
 =?utf-8?B?T2dIK08zbnEvaTJXL29acW5GY1RwU1FDOGNDeUlRYmtRRjU3T3ZTSkhVM2dv?=
 =?utf-8?B?Y3J3QUNRYWRma0dVNHZnSzJONTVFQldSTUowSjFJMm94aTN4SkRLRFhKUXpI?=
 =?utf-8?B?TURSY1J2bG5YUUJSQzJJVG9mUzFVaTBQYjZQWC95WDdoNGpFQlEyakszYk9x?=
 =?utf-8?B?VzdhZ1IrcU9Lby9MRm9LUVdDdnhPNGhHcDlGMU8yUGQvUHpYZEpJd2hwdDhL?=
 =?utf-8?B?UndGYXY0ckVERDl3SDNvRXh4UkxENFdqQk9rY1p5STJ6dUF3Y3dKYzd1dTlW?=
 =?utf-8?B?eEZMQ1NlUmgyTmpyQ1pza2pEdkRGUDU5bHBlUFM5SnRqS3RjY2hKaXlLcnRt?=
 =?utf-8?B?RUMrSTBBM2x1WFhTQ3NQRkR6Mlgxdi9Ta1lobWU1N0RiZllNNzBweEQ4alBl?=
 =?utf-8?B?cUk0L0Q0WHRlM0txWEE1ZkV2OUZNSFpRY2ZQSllDVEZJUFFSMWpHVkF5NGFH?=
 =?utf-8?B?b0hXaXhkTDVQM0J0VmZrbWFpeEhYYmtvN3hGOE00MFhyYWlQRTZ5YzRmOXlq?=
 =?utf-8?B?YlB2OThXVHYyTm1HWXRySEpKRTBvRHZYUkRRVVBWVEJXYjdEU1A3Z2dpaFZT?=
 =?utf-8?B?RUMyMWZCS0tKWk83MzVwdWlmbUlhNmpJOUpaME5lazB4VUZkUDRGbmdpR3gv?=
 =?utf-8?B?enYzcUVya0JDMWp1NDNIMUdyazg1TWlJdnFBLzRzN09zaHQrSlZSZlFtb1k0?=
 =?utf-8?B?RDFpTnQvUUJBd3o0QktMblo4bGR6ZklycXBIS3hvUlB2RksyeTZFZDFRbXZZ?=
 =?utf-8?B?YVVvZ1BDVjhEbTgwampqZ3l2cHFRblJxWVlyQjdkRHk0Z1V6K3NFNXJhTERw?=
 =?utf-8?B?TWlueEFWVzFnWDVkSDBHYVdMSE0vTEhlcEpIb0ZBVFlTSjBpNjc4ZGtvRmxl?=
 =?utf-8?B?UldZVEtQc1BQdU1ZRFU4bDlrallENkdhdmFUTE5zVXlpSmVVWHJOMGtnRmpR?=
 =?utf-8?B?a3VDVzNodHcxa2ZubWd3T1pQbWp3dmJxUCtncDRjVXM1K0pHZCtVU2daMDhN?=
 =?utf-8?B?OHprcHdyS01EYVVhbmxKM2NvOUo2WFJPclRkV3ZaODhCa0k1QTYvUDVxVkVC?=
 =?utf-8?Q?+kE7RHj7g2odZR7q/OaJPQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5A905D7ADB72F4099AD251013C1A176@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b72624-bd57-4e3e-b5b3-08dd76b43df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 15:44:26.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOUBVAtoliAPz80ZBdBpEJcQaD38vt8h39kOMMV6bx5tN7F4VLyeWwNeCTIDLk011FQNGbn+Ykew04pqFEtPbypT0k8i13x+br5ZQi8hJj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Apr 2025 15:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18494

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDE0OjA5ICswMDAwLCBGZWxpeCBNb2Vzc2JhdWVyIHZpYSBs
aXN0cy5jaXAtDQpwcm9qZWN0Lm9yZyB3cm90ZToNCj4gT24gV2VkLCAyMDI1LTAzLTA1IGF0IDEx
OjI3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3RlOg0KPiA+IEZyb206IFF1aXJpbiBHeWxz
dG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4gDQo+ID4gVGhpcyBzZXJp
ZXMgd291bGQgbW92ZSAvaG9tZSB0byB0aGUgL3Zhci9ob21lIGFuZCBwcm92aWRlZCBhbg0KPiA+
IHN5bWJvbGljDQo+ID4gbGluayB0byAvaG9tZS4gQWxsIGhvbWUgZGlyZWN0b3JpZXMgY3JlYXRl
ZCBkdXJpbmcgdXNlciBnZW5lcmF0aW9uDQo+ID4gYXJlDQo+ID4gc3RvcmVkIGluIC91c3Ivc2hh
cmUgYW5kIGFyZSBjb3BpZWQgdmlhIHN5c3RlbWQudG1wZmlsZXMgdG8gdGhlDQo+ID4gY29ycmVj
dA0KPiA+IHBhcnRpdGlvbi4NCj4gDQo+IEhpLCBvbmUgb2YgdGhlc2UgY29tbWl0cyBicmVha3Mg
aW4gY2FzZSBvZiB0aGUgZm9sbG93aW5nIHNjcmVuYXJpbzoNCj4gDQo+IC0gYSBwYWNrYWdlIHRo
YXQgY3JlYXRlcyBhIHVzZXIgKGUuZy4gdW5kZXIgL3Zhci9saWIvLi4uKQ0KPiAtIHdlIGFsc28g
ZGVmaW5lIHRoZSB1c2VyIGluIElTQVIgYW5kIHJlbG9jYXRlIGl0cyBob21lIHRvIC9ob21lDQo+
IC0gd2UgaGF2ZSBhIDEwMCUgc3N0YXRlIGNhY2hlIG1hdGNoIGFuZCByZWJ1aWxkIGluIGFuIG90
aGVyd2lzZSBjbGVhbg0KPiBlbnZpcm9ubWVudCAoa2FzIGJ1aWxkICYmIGthcyBjbGVhbiAmJiBr
YXMgYnVpbGQpDQo+IA0KPiBJbiB0aGlzIGNhc2UsIHRoZSBkb19yb290ZnNfcG9zdHByb2Nlc3Mg
dGFzayBmYWlscyB3aXRoIHRoZSBmb2xsb3dpbmcNCj4gZXJyb3I6DQo+IA0KPiDCoG12OiBjYW5u
b3QgbW92ZSAnL3dvcmsvYnVpbGQvdG1wL3dvcmsvPGltYWdlPi8xLjAtcjAvcm9vdGZzL2hvbWUn
IHRvDQo+ICcvd29yay9idWlsZC90bXAvd29yay88aW1hZ2U+LzEuMC1yMC9yb290ZnMvdXNyL3No
YXJlL2ltbXV0YWJsZS0NCj4gZGF0YS9ob21lJzogRGlyZWN0b3J5IG5vdCBlbXB0eQ0KPiANCj4g
SSBmdXJ0aGVyIGluc3BlY3RlZCB0aGUgc3N0YXRlIGFydGlmYWN0IHdoaWNoIGNvbnRhaW5zIHRo
ZSAib2xkIiAobm90DQo+IHJlbG9jYXRlZCBob21lKS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgSSBz
dGlsbCBkb24ndCBoYXZlIGEgbWluaW1hbCByZXByb2R1Y2VyLCBidXQgcHJvYmFibHkNCj4gdGhp
cyBpcyBhIHJhY2UgY29uZGl0aW9uIHdpdGggYSBsb2NhbCAoY2hyb290KSBleGVjdXRpb24gb2Yg
dGhlDQo+IHRtcGRpcnMuZC4gQ291bGQgaXQgYmUsIHRoYXQgdGhlIHBvc3RpbnN0IHNjcmlwdCBz
b21laG93IGV4ZWN1dGVzIHRoZQ0KPiB0bXBkaXJzIGxvZ2ljIGluIHRoZSBjaHJvb3Q/DQoNClRo
aXMgaXMgdmVyeSBsaWtlbHkgYW4gSVNBUiBzc3RhdGUgYnVnIGFzIHRoZSBTU1RBVEVQT1NUSU5T
VEZVTkNTIC8NClNTVEFURUNSRUFURUZVTkNTIFsxXSBoYXZlIGdsb2JhbCBzY29wZSBhbmQgYnkg
dGhhdCBleGVjdXRlIHRoZQ0Kcm9vdGZzX2luc3RhbGxfKiBsb2dpYyBpbiBhbGwgdGFza3MgdGhh
dCB1c2UgdGhlIHNzdGF0ZSBjYWNoZSBhbmQgd2hpY2gNCmFyZSBkZWZpbmVkIGluIGEgY29udGV4
dCB3aGVyZSB0aGUgcm9vdGZzLmJiY2xhc3MgaXMgaW5jbHVkZWQgYXMgd2VsbA0KKGUuZy4gdGhl
IGltYWdlLmJiY2xhc3MpLg0KDQpPbiByZXN0b3JlLCB3ZSBnZXQgcmFjZSBjb25kaXRpb25zIHdo
ZXJlYnkgdGhlIHJvb3RmcyBpcyByZXN0b3JlZCB3aGlsZQ0KdGhlIGRvX3Jvb3Rmc19wb3N0cHJv
Y2VzcyBpcyBydW5uaW5nLiBXZSBhbHNvIHNhdyBzaW1pbGFyIGJ1Z3MgaW4gb3RoZXINCmRvX3Jv
b3Rmc19wb3N0cHJvY2VzcyBzdGVwcyAobGlrZSB0aGUgdXNlciBjcmVhdGlvbiAvIG1vdmUpLg0K
DQpBZHJpYWFuIChpbiBDQykgaXMgY3VycmVudGx5IGxvb2tpbmcgaW50byB0aGlzLg0KDQpCZXN0
IHJlZ2FyZHMsDQpGZWxpeA0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9pbGJlcnMvaXNhci9i
bG9iL21hc3Rlci9tZXRhL2NsYXNzZXMvcm9vdGZzLmJiY2xhc3MjTDQxMQ0KDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEZlbGl4DQo+IA0KPiA+IA0KPiA+IFRoaXMgYWxsb3dzIHRvIGRlbGV0ZSBh
bGwgY29udGVudCBvZiB0aGUgL2hvbWUgZGlyZWN0b3J5IGlmDQo+ID4gbmVjZXNzYXJ5Lg0KPiA+
IA0KPiA+IFRoaXMgbW92ZSBjb3VsZCBpbnRlcmZlcmUgd2l0aCBleGlzdGluZyBpbnN0YWxsYXRp
b24gYW5kIGlzDQo+ID4gdGhlcmVmb3JlDQo+ID4gb3B0aW9uYWwgaW4gaXNhci1jaXAtY29yZS4N
Cj4gPiANCj4gPiBDaGFuZ2VzIHYzOg0KPiA+IMKgLSBhZGQgS2NvbmZpZyBlbnRyeQ0KPiA+IMKg
LSBBZGQgY2kgdmFyaWFibGUNCj4gPiDCoC0gZml4IGRlc2NyaXB0aW9uIGluIGthcyBmaWxlDQo+
ID4gwqAtIHJld29yZGVkIGNvbW1pdCBtZXNzYWdlDQo+ID4gDQo+ID4gQ2hhbmdlcyB2MjoNCj4g
PiDCoC0gbWFrZSBtb3ZlIG9mIC9ob21lIHRvIC92YXIgb3B0LW91dA0KPiA+IMKgLSBmaXggcmVj
aXBlcyB2ZXJzaW9ucw0KPiA+IMKgLSBmaXggY29tbWVudHMgYW5kIHR5cG9zDQo+ID4gwqAtIHVz
ZSBXSUNfSE9NRV9QQVJUSVRJT04gaW5zdGVhZCBvZiBIT01FX1BBUlRJVElPTl9DTUQNCj4gPiDC
oC0gcmVtb3ZlIHBvc3RpbnN0IGZyb20gbW92ZS1ob21lZGlyLXZhcg0KPiA+IA0KPiA+IA0KPiA+
IFF1aXJpbiBHeWxzdG9yZmYgKDYpOg0KPiA+IMKgIHJlYWQtb25seS1yb290ZnM6IE1ha2UgSU1N
VVRBQkxFX0RBVEFfRElSIGNvbmZpZ3VyYWJsZQ0KPiA+IMKgIHJlYWQtb25seS1yb290ZnM6IGFk
ZCBob21lIHBhcnRpdGlvbiB3aXRoIGEgdmFyaWFibGUNCj4gPiDCoCBhZGQgbW92ZS1ob21lZGly
LXZhciBwYWNrYWdlDQo+ID4gwqAgTW92ZSBjb250ZW50IG9mIGhvbWUgdG8gSU1NVVRBQkxFX0RB
VEFfRElSDQo+ID4gwqAgQWRkIEtjb25maWcgb3B0aW9uIGZvciBzZXBhcmF0ZSBob21lIHBhcnRp
dGlvbg0KPiA+IMKgIGFkZCBjaSB2YXJpYWJsZSBmb3Igc2VwYXJhdGUgaG9tZSBwYXJ0aXRpb24N
Cj4gPiANCj4gPiDCoC5naXRsYWItY2kueW1swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrDQo+ID4gwqBLY29uZmln
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwICsrKysrKysrDQo+ID4gwqBjbGFzc2VzL3JlYWQtb25s
eS1yb290ZnMuYmJjbGFzc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjINCj4gPiArKysr
KysrKysrKysrKysrLQ0KPiA+IC0NCj4gPiDCoGthcy9vcHQvZW5jcnlwdC1hbGwueW1swqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPiDCoGth
cy9vcHQvc2VwYXJhdGUtaG9tZS1wYXJ0aXRpb24ueW1swqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
MQ0KPiA+ICsrKysrKysrKysrKysrKysrDQo+ID4gwqAuLi4vZmlsZXMvaW1tdXRhYmxlLXJvb3Rm
cy50bXBmaWxlc8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyIC0tDQo+ID4gwqAuLi4vZmlsZXMv
aW1tdXRhYmxlLXJvb3Rmcy50bXBmaWxlcy50bXBswqDCoMKgwqDCoCB8wqAgMiArKw0KPiA+IMKg
Li4uLXJvb3Rmc18wLjEuYmIgPT4gaW1tdXRhYmxlLXJvb3Rmc18wLjIuYmJ9IHzCoCA2ICsrKyst
DQo+ID4gwqAuLi4vZmlsZXMvbW92ZS1ob21lZGlyLXZhci50bXBmaWxlcy50bXBswqDCoMKgwqDC
oCB8wqAgMyArKysNCj4gPiDCoC4uLi9tb3ZlLWhvbWVkaXItdmFyL21vdmUtaG9tZWRpci12YXJf
MC4xLmJiwqAgfCAyMw0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoC4uLm9va18wLjYu
YmIgPT4gaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC43LmJifSB8wqAgMiArLQ0KPiA+IMKgd2ljL2Ji
Yi1lZmlib290Z3VhcmQud2tzLmluwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA0ICsrLS0NCj4gPiDCoHdpYy9oaWhvcGUtcnpnMm0tZWZpYm9vdGd1YXJkLndrcy5pbsKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKy0tDQo+ID4gwqB3aWMvcWVtdS1hcm02NC1lZmlib290
Z3VhcmQtc2VjdXJlYm9vdC53a3MuaW4gfMKgIDQgKystLQ0KPiA+IMKgd2ljL3FlbXUtYXJtNjQt
ZWZpYm9vdGd1YXJkLndrcy5pbsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQ0KPiA+
IMKgd2ljL3FlbXUtcmlzY3Y2NC1lZmlib290Z3VhcmQud2tzLmluwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA0ICsrLS0NCj4gPiDCoHdpYy94ODYtdWVmaS1lZmlib290Z3VhcmQtc2VjdXJlYm9vdC53
a3MuaW7CoMKgIHzCoCA0ICsrLS0NCj4gPiDCoHdpYy94ODYtdWVmaS1lZmlib290Z3VhcmQud2tz
LmluwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQ0KPiA+IMKgMTggZmlsZXMg
Y2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IGthcy9vcHQvc2VwYXJhdGUtaG9tZS1wYXJ0aXRpb24ueW1sDQo+ID4gwqBk
ZWxldGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL2ltbXV0YWJsZS1yb290ZnMvZmlsZXMvaW1t
dXRhYmxlLQ0KPiA+IHJvb3Rmcy50bXBmaWxlcw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJl
Y2lwZXMtY29yZS9pbW11dGFibGUtcm9vdGZzL2ZpbGVzL2ltbXV0YWJsZS0NCj4gPiByb290ZnMu
dG1wZmlsZXMudG1wbA0KPiA+IMKgcmVuYW1lIHJlY2lwZXMtY29yZS9pbW11dGFibGUtcm9vdGZz
L3tpbW11dGFibGUtcm9vdGZzXzAuMS5iYiA9Pg0KPiA+IGltbXV0YWJsZS1yb290ZnNfMC4yLmJi
fSAoNzMlKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtY29yZS9tb3ZlLWhvbWVk
aXItdmFyL2ZpbGVzL21vdmUtDQo+ID4gaG9tZWRpci0NCj4gPiB2YXIudG1wZmlsZXMudG1wbA0K
PiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtY29yZS9tb3ZlLWhvbWVkaXItdmFyL21v
dmUtaG9tZWRpci0NCj4gPiB2YXJfMC4xLmJiDQo+ID4gwqByZW5hbWUgcmVjaXBlcy1pbml0cmFt
ZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2sve2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29rXzAuNi5i
YiA9PiBpbml0cmFtZnMtY3J5cHQtaG9va18wLjcuYmJ9ICg5OCUpDQo+IA0KPiAtLSANCj4gU2ll
bWVucyBBRw0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo+IEZyaWVkcmljaC1MdWR3aWctQmF1ZXIt
U3RyLiAzDQo+IDg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQo+IA0KPiANCj4gLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRo
aXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTg0OTMpOg0KPiBodHRwczovL2xpc3Rz
LmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS8xODQ5Mw0KPiBNdXRlIFRoaXMgVG9w
aWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210LzExMTUyNTc2NS82ODc5Njk2DQo+
IEdyb3VwIE93bmVyOiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBVbnN1
YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9jaXAtZGV2L3Vuc3Vi
wqBbZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbQ0KPiBdDQo+IC09LT0tPS09LT0tPS09LT0t
PS09LT0tDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNo
LUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==

