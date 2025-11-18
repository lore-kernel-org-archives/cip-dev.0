Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB5ECED63F
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 13:05:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12015.1763471099134870578
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 05:05:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=V9OgZ7E+;
 spf=pass (domain: renesas.com, ip: 52.101.125.14, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgTrOIzC0uPqnFIi3LOW5Fl0Pk+cfnPFyIfDyfIhgdcEzZoh4jcYj/f8tnoqCE5jd8ZyR1xDpqQmbLzBxYIDYonZpSoVAW+Fr3MumUhJ7rVQeC594xLU44ANMR5OPfJDvZOdbuIOUUke++TFaRb+Q5KHdHlPhYwm723YOjSXl7p+g21LRvd5MCA5cwV3NZvA72IzBxZihOyh9EWU00oOgUAkqcF+VreYWqGUZKsnhL0e39yfVQ3rdRaEJOgqdlYdig9R0raXICavVqwGxKmSTkhCQEPJUb4ojNjzLl9V3UwxqkeXNJYnkhw92a7/zJB5sJ4NaqwsNJRAdcXFkk2f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njf/zDlLshaT+N/waBrhSX/CmCiivlJvFcSTtm43H+o=;
 b=E8P6EKSSaenOnPO/0NXjAyNzLpHTTATHQwBGN4vhjP9XWZFJFXad7jiaJ39Qks8zU4kpAghNvrN76q6v9DaN5TklD6X+T8t3P5iHuWO0izYgrCuTizxeyoTDRCKjzOA+4kSZV/dJoapchRaLXRkx/elU8k/ElAS839YDbryTv3/tlfyenZC/XYwERjLzO3dzkTgai6RtvXcBBi3uBwPuLVGvSV4rT+T7Z1DznO8kZ4HH/K+VGQkpQEbNQloowj3frUepv0iotxpoIAuuvby8R5x53h+g7+1tivvzq9tTxpE6q69eE5lf2iOmnvJHe9xUYVtDu+cFD2OcZ4W11t/fnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njf/zDlLshaT+N/waBrhSX/CmCiivlJvFcSTtm43H+o=;
 b=V9OgZ7E+49j/PQw2WevGsGImbNIkLqVevtBYw8qkFMSCavG7jw38uEFE+kPP7x7ufzsLHEFkhsSDXzD8e7tdBYCTPismdeKduPBg/l5xZgUa6ts67LTmM1lEmvOvYyxcY47euyLRRlxQMN4iZPba30KGjSSuS4VJlqr3YMHyebU=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSCPR01MB15595.jpnprd01.prod.outlook.com
 (2603:1096:604:3c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 13:04:55 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 13:04:55 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>, cip-dev
	<cip-dev@lists.cip-project.org>, Arisu Tachibana
	<arisu.tachibana@miraclelinux.com>
Subject: RE: 6.12-cip RT testing
Thread-Topic: 6.12-cip RT testing
Thread-Index: AQHcWE6PkW7DydJ4rke+DIHGtXDHqbT4ZvYw
Date: Tue, 18 Nov 2025 13:04:55 +0000
Message-ID: 
 <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
In-Reply-To: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSCPR01MB15595:EE_
x-ms-office365-filtering-correlation-id: ca033dab-223a-4315-e6be-08de26a311be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U3pvRnlrZU9SMG9OUDVURlE1cVBoK05jVzlyQTlGZjJ4ampUZ01MOGNMYXhU?=
 =?utf-8?B?UzMxNW9jSzNQS3ZqTnpGaUpMbHQxQlQyTmJmS2JYV21DQTRRWkhsQkNuTml3?=
 =?utf-8?B?T2h2VkwreExEL0hLR1d4WnlXZktQQXIxN0NaUUdYNDREemViNWFZeC91ampF?=
 =?utf-8?B?OXpSaXgyMW1XVjEwTEU5N1c3VFY4ellaK1dxdGZnQUZFZFNUZDJXYmVmYjEz?=
 =?utf-8?B?bUx4UVQxaE1KTEJ0c0VPWDJYSHBqV1pMS3hCaHBLOGR4TDdWeVUrVnNQejRm?=
 =?utf-8?B?UlZuWmQrZjdoUTk4Y1JZNmhJY2xhaDZndFBva3h6UmpiRlJUMTFYRW1aUEdp?=
 =?utf-8?B?djVCSjFIRXl3N3FsRWxkVUJsSmZmbFRiMU4zc0xibzlScjRxd0ViUFNHUWc4?=
 =?utf-8?B?OVo3NlZOUmZDODFLYUdqZjVTNE1CN2pQNzJ0R3FjdGduc3B3MlQ5TTJ5eFVi?=
 =?utf-8?B?NFBGUWxra1Q3ZW0zSi9YQWxJemM2UDJJRjRqVlFXWCtWY0s3YW1rM3VnRGVN?=
 =?utf-8?B?SDhKL1R1U0l1N3A0ajEvekZPNk5mZlpmbzJjaVdRZGFic0J5aVVteEMzQjNF?=
 =?utf-8?B?Q0JaWmk1emhVWlNxTUNwVG5KZDBiM01pOXdCMks3MzVEMitVLzFsekNmcjFO?=
 =?utf-8?B?L1R5aVR5bFRhRG5qcDN3OEhzd3pUOW9jQWMzLyt5Ky9vL1dEMzZRSDdYOHUz?=
 =?utf-8?B?L0hJVjFPVllXamFLMmFBdk02NGZ1UmpHeW44ckJZdDhIWG9kYjFmWUIwdzRq?=
 =?utf-8?B?eGhxWGlkWkhndzJWU2ZLUER5TVl1Z045K1BiZnNuQzQ5Rk13cUhFN0d0YnRM?=
 =?utf-8?B?U3NIQmhwV1J6eXdMcUNWUXd4Lzc0MGR0M0JQRjdWRDh3V3dGQTFDRHFQMkFx?=
 =?utf-8?B?ZFZFTksrdEE2NGNiVUhMc09wTWZiY1FmaGhkRkRhc01TVG5JNEpGYXM2Vk0w?=
 =?utf-8?B?T3RqWGpGZnVqNjNZTTRvdTFBNCs1ajV4WEFzSkFBU1ZoQnNBZ2YrcU94b3NN?=
 =?utf-8?B?QlQ2dytjTTRLQTZHVnpMS2x6ZVdOZloyY3NCRGxnbGxRVCtmM3JiVCtvdDVa?=
 =?utf-8?B?cFVYUk1OdUhCN1hoZk5yQitPcjhKUDY0Y0Izc2QybDNzMFpPSm9LN3IydlFu?=
 =?utf-8?B?V2ZITzVCS2ROQ2hrNURnVW5DU0lySzM0TTAzclpDT0thUVE5UlRiMzIyY0JM?=
 =?utf-8?B?QndLK1N4cUVzSE5PSTVYWTQ4Wkh0cFRNV2h6a0thcTNKSDR6VkYxUDhnRVRU?=
 =?utf-8?B?bzU4RG9WOW93aEFIL3o3M0IxNU4wQkErWkJjYmxhM0JjbDVMOTRhUWc4dHVk?=
 =?utf-8?B?QVJGNVllV01lU2M5MGtaSXdWS3hQN2MydDhZTHp1TGJJY1UxVFdQNUpxZ2hn?=
 =?utf-8?B?bnBsMllaK2t1RTFWRHNSSnZqeVo4dmxaLzAwZ2dyaXN4KzcxTlR0aElnbTdp?=
 =?utf-8?B?bVZsQm1ua2dyaXQvNlRkWW5JQjE3Zk9YdjE5MXgyV29GeWh4bEM0Mm55ZWNX?=
 =?utf-8?B?OGpzNjdpTTZtbG52QTQ4cXR2aktHbkh5T3phWEV3bjFCSHdOT1pBVi9COTF4?=
 =?utf-8?B?NmxyWktCTXplUU9CTzlOM1pXbWpWVE5XS0ZrZk9YVmVSLzBpcGlaOHFRVXh3?=
 =?utf-8?B?MFZTK0JkdzNVaWhUdWhUQ3hwQjRGNUtsakExdjZwbTBvU0ZLSUxOU2JaTkRx?=
 =?utf-8?B?RCtuRFAvQ0F4dDhkbVRmRzVMMUlobHBRUHUrQWZxTDBWUTNTUmgxSHVUbTI3?=
 =?utf-8?B?dGE5RFdDeEtYVW5wUGx3WFdKRHRsVjRwZ2h0bDFMclFTczVEc0hUeG9IRkVK?=
 =?utf-8?B?MUxlZ29ZaTZtQ04xSkovSVEwRC9rOGd1citOY3ArOHY3a091UUJYMHIzajMy?=
 =?utf-8?B?YXhoaVkxbHg1NDRvdkJvcm9GQVRFTExBSVlwUk9veHJzYXc0MDdRYnE2RnRX?=
 =?utf-8?B?bnZ6c0FxbXJnYzhKbG9XeWN2bHZjWHBwVG5pN0lZSjdCN0FYT1VoYUJJZkhr?=
 =?utf-8?B?cXluWVQzMzVnWWYvSWNDNzJHaEwzdmRBTGhBbGVRc1JyaC9OclZub3gzdzBu?=
 =?utf-8?Q?9hV77a?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cVBhMWFuaDJ0TEFUTGFWcDBIWHpWR041dW9uSlhra2QxU21tMTJuU1BBY3Zm?=
 =?utf-8?B?NitUN2xYdjdGcHdweHljMmdLZWlaY2FiUjVrT2VmMXdUdkhCanZadU9wWk5E?=
 =?utf-8?B?d1BBc05GVnBIVEVKNXRPMGZmQ3NreFQ5TDA1OGN2NkczWnprYVFOVE1tY0FB?=
 =?utf-8?B?SWJwd2ZzVGlYWkxvY1BPdkFXNmV6YWNmd252UVZ2aS9qS21uaDl3TDc0Zmor?=
 =?utf-8?B?L2FKS0U0MC95WG0rSk5Gd0JnTlF4ZTdteERvWXJNQ1NCMjZraFlLL2xQSmNu?=
 =?utf-8?B?dkg5b1RMbENzUnduVGFNNXJlYUE5TElQR1g2ajF3OW9HUTY3REtvSWJLY1Rs?=
 =?utf-8?B?Z21HMko2MFRyMHNEZXExazlvSXdUcjdLa0VBVkgzdTE2RVRTZXMwN01ZRGQ0?=
 =?utf-8?B?Y0NFVHcyNzJ2VUVQOWdRT21FcmZRZ2c2dXJsQ3FIZDVZK0R2cEdnVklZKzRl?=
 =?utf-8?B?cW0yODFGY1l3WTkwNzJ4cmxLeDE5SmQ0NUc5YnB4aHZDblhPa1FmNjZBVzAx?=
 =?utf-8?B?R2llRWVoTkpsYTByL0ZFNktoTndxd1lVM2luWm9XZUk4STJPMTNBbWJEVkNF?=
 =?utf-8?B?M2cwcGUrZTFjN0NoaEFsSjlXd2tDazlIMkJRQXhkNlVlZTZHdVRkYS9Wa281?=
 =?utf-8?B?LzlHL0dBMDZNdlZ2THlsN1k3TXFPbDRFTVRpVmJNc3NYK29Nb0g1aFl0REha?=
 =?utf-8?B?M28rZ255MXhiNEFRazZGeW5EMjNxNXM0bEhqL1lRbjZLeThEUUtPVVhHNFpE?=
 =?utf-8?B?QnhzdGxlSnd2RnpLYlVTUUUwalpQSnNKemxoQ0NQNXBWZG52cll3bjU2OUY2?=
 =?utf-8?B?UUZXblVXbnJpQVNZcjdFbG05eVRvbVd3TjhaSGU4d3pVRDJOQytkYkNkTGJR?=
 =?utf-8?B?RmwyL09kcEhtaHlycnpSYVBxSDI1cjd4KzhzZm5hN3EydmY3dWdpc202WTRB?=
 =?utf-8?B?TkNtYlcwMFRjTkk5SHc4aTNmaEoybUJKT005YlBFWEJsQXd3dWxqSVhjMGlM?=
 =?utf-8?B?UWp4UXJxR1RWcjNuWiszRWJSSGdLL2VZcnNjbTFSUVZubjBmSTNKa0FuUjdB?=
 =?utf-8?B?MDlIcFdsQmp5NVNUaGEzWng4SjZuQW9GblE2QU5wQTRyTmNnOFplVmRZRzhV?=
 =?utf-8?B?anBicmJqSjBlWE0rcjh4dDhtWU5yU0dwdnh5L3FQaFFsb2VMajQ4SEZSeDR5?=
 =?utf-8?B?SzlhK3E2cTlWWlFuTkhsait3WmpqdFFBSEhiYnhLeHNKUHNpVVBmVTRhS3d4?=
 =?utf-8?B?bERaMmZ3L3VEOVp0Z1hLK0l4NDJ6RURsTldTUU43NlFERFFGaUdWQ3JvY2VP?=
 =?utf-8?B?QUt6TFRaTUxXa2ljenRxR1JYN3Fpc1V1Y3RQY1YvVEl0dGJhOHdvSmZva3NU?=
 =?utf-8?B?KytOOWZtdDQyOHpzK2NoOWdhc25jSTdzNjA3OTlEeW9uNllJSlkyVVBsbEhj?=
 =?utf-8?B?MjF6U2dIUTdvbjZwTUVWc1oyNGF6YWpBL2pGOWdQbXVpdVo4Nmx4ZUZCTEFI?=
 =?utf-8?B?YnAzSllLSTA4Q2Zkd2ZiQldYR240eFF4dUU2bWxQRUpMRFdVTWkyK1VmaE5G?=
 =?utf-8?B?ZC9uaUJtUjN0Nk5XbHFpbHBJT0pSb1h4WlA3SmdSSEhJaHZHdS9Sc2h2dGFk?=
 =?utf-8?B?QjZxR0twbzNPSnhxMCtLOXhGTVJFTHdabnZUL1VsbEExTU15MkMwSGxOd01z?=
 =?utf-8?B?L0RXdzZWZ3BwYXdYZTcyZVkyOUpSNEZTYnlBa0ZIenludE9maUdyWThtbzRv?=
 =?utf-8?B?dnhTQi9qWTZOajB5TFQyNnV5bEh3N05EOXZSWXhoMVcrTTU1ZzJQZUtydVJD?=
 =?utf-8?B?dDNXR2NkTklYb0ZOSFVxS3p5QjltVlhRSzJKVWdpWDZRUUM3VXAwemo1UGJk?=
 =?utf-8?B?ZUF1QnZJd252WUJwNWltbFg4MEVLVkVrZU9ZUE94LzFSaHg1amozTW00djcw?=
 =?utf-8?B?UlN5UVpJK3VJelllVlBpMFBnOTdVc0pYbkkxMFhGNXNiUE1MZWdpY0Vyd1Fs?=
 =?utf-8?B?TzBiWnlnT3dSZXBEOWU3bGt1VGJSSk1BeXE5Wi9aM0RDYWhpVnNGV3phVGdT?=
 =?utf-8?B?cEdUazFWZnNTa1JXV1kzK285NE9CNnVhaDVWcXROZThCWVNXODd0MkhFK0FW?=
 =?utf-8?B?YUp5UERxeUVxa01PTFFzb2JVaStobWVibzE1c2NtRWZuVU1YTGVVcVVlRHFP?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca033dab-223a-4315-e6be-08de26a311be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 13:04:55.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2YA78XPjn6OvNnl6qIV/Qb2Elzfo9mS/alpvjSVnpucpcdSRjvkCDwcIcGEaofWLOLJmsFXFVoyoHtxmWkz46QMlKu0gNzbc5n3ijNTRhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 13:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20612

SGVsbG8gSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDE4IE5vdmVtYmVyIDIwMjUgMDU6NDUNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IGxv
c3QgdHJhY2sgYWJvdXQgdGhpcyB0b3BpYzogQXJlIHdlIHRlc3RpbmcgYnkgbm93IGEga2VybmVs
DQo+IGNvbmZpZ3VyYXRpb24gd2l0aCBQUkVFTVBUX1JUIGVuYWJsZWQgb24gNi4xMi1jaXA/IElu
aXRpYWxseSwgd2UgZGlkbid0DQo+IElJUkMuDQoNCkN1cnJlbnRseSB3ZSdyZSBub3QgdGVzdGlu
ZyBSVCBvbiA2LjEyLWNpcC4NCg0KSSd2ZSBqdXN0IHN0YXJ0ZWQgaW52ZXN0aWdhdGluZyBob3cg
dG8gZW5hYmxlIHRoaXMgaW4gS2VybmVsQ0kgZm9yIGFsbCBDSVAgdHJlZXMsIGJ1dCBJJ2xsIHN0
YXJ0IHdpdGggNi4xMi4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiBKYW4NCj4gDQo+
IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCj4gTGludXggRXhw
ZXJ0IENlbnRlcg0KDQo=

