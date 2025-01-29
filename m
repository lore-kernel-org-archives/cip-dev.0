Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3FC0218F
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 06:25:47 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.60])
 by mx.groups.io with SMTP id smtpd.web10.11211.1738153555474040968
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 04:25:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mKNfhuCN;
 spf=pass (domain: siemens.com, ip: 40.107.103.60, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/IIY1lmMYbfhacP6UVl0IGXUAamkt+dpo7a2Wq6zsjSflCUQ6fhi3JRW7Fp+r+jGMjB2S59lk83jPeDnDNsliI2JIe0Xk89Et/1D+UvtK/xohNUnG1Gr9qe6ZdCT1FSlwHiRX4hJJMirreK545ycaJWoOIHNjvLrY/XKB76cTEnn6SyGMwUGNQpQUwb3wvpkO8Kgydbh+/7xQfysYKrs/4JeFEReT3oqCwdxkqS0+7gM/jhr9enKSs00SRJUt+AELowrlmLbn1Byt5HnOk3q8SR+2afsWxy8hlqBFttbQyu+TYLdePupetyhBVzCaArb5onFyO+BraglwIF8whjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXrIyGJitOqarMds5LydoFBvEk4sGXfpe7mgCDgEgeY=;
 b=lm8ia2szwEBI6rg9LphSDkKWX+qZIjqQhub5SYHHoTKaEvueKUPUrzqDHlsmPFDvHVN0A5Iq4kHsA4H2kLbUMLTlLvtdnI7TDrksVmEU3jyVd9IvDzLQq+T0tRQa+UzsyMwo8sR7KHdhDDUHCaPQHJmjA6TLLMwdU5sBbXei8PKzQzV8vbOefyrISLuXvX+W6yuYuat4UNk1RisI0qCbtm5HUaUYgPWZcdPnApydUzCUhWj2ZOwUZKQXK251vJTKJV3291equ+XTNWhYI5qtaqVQYswPumteXVC+r/d2wh55er2tJmOKTVdWBBC0g+CneM/dU5Jszjhet900h4v5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXrIyGJitOqarMds5LydoFBvEk4sGXfpe7mgCDgEgeY=;
 b=mKNfhuCNA8A/ybMCAXBJXZtQcfKRNJIlOEZNnZTmlWPFRmTdog0BZjBjFIw783yQEiC8K0RlwmEHlhAgQxpVjh5DNookOt1tX2Z0GmaWzeKKiD+jWorv/CQRtSgNmk7JTNS8BOmvm6O7Y4pfFEi4TSQqbbCxjztiGdGmEzh4Z+sHXJfErA8U55JEoIcfsHP4ZGELSFFufWgESYb+nuiPLN3REswrf4JliyZ3aBm+YKwhkAmhg2KaRcN9EDXA6Kl51rjG5b/4AEc1qNcZu0PPknaJL3tOGEdbcdPKLIb8nwJHGgw7dIsut1xnSS08bx+ZfjxNtmIFoveGfwa3puJgRA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB5806.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:509::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.13; Wed, 29 Jan
 2025 12:25:52 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 12:25:51 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Nussel,
 Ludwig" <ludwig.nussel@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude var and home from the erofs and squashfs
Thread-Topic: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude
 var and home from the erofs and squashfs
Thread-Index: AQHbckjvaxIC9r+v2ki0zwadMQRQAg==
Date: Wed, 29 Jan 2025 12:25:51 +0000
Message-ID: <2fa58c7fef5275ce610cfcd6d4a936793b72f3b7.camel@siemens.com>
References: <20250127140814.762632-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250127140814.762632-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB5806:EE_
x-ms-office365-filtering-correlation-id: c43429a9-c5e1-407c-8bb8-08dd406011ec
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TDN1eHlFb3lqTmNSa2F6aWpmRVR1QnY1WWx2dWpEMGZPdm5JeTZ3Y2RpSGtt?=
 =?utf-8?B?TVI4T1gzVGNPTTNpUEZFdVR3KzR0MTh3WjlWZFZVYW1DemFDNFFIRzJzK0FF?=
 =?utf-8?B?TUFxTGU5R1Bwcm9DNkpTRmNtZkg1SFhkdzI2czFkNVUrcjFuZWRzZUw3czJL?=
 =?utf-8?B?ZVJQeGRCamkvdTYwMDVFRHdzUTlmemZ3aXRNMWFnTmcwQVpLV0JFRXh5eFJk?=
 =?utf-8?B?RFVkWW5mVnllVnNMa21kUzZaSWJDV3o0VmR4SnJTUG9PUFBsdTBPNGhDdytk?=
 =?utf-8?B?eEE2bzJkSnNPd0VUci9kK1NyVEI5a3ZTbTNXUEs3Y2xCc0hIdk0yakNsa1E0?=
 =?utf-8?B?VGgxcWQxL24yRGdESkF0TVpHN1VyWEpkMGQwNkt2bUdCMzY2eC95M3U0R1cr?=
 =?utf-8?B?UlFGQjJBMmtxbXpZQVorYVYvKzc5V0F1Wm9mMjIyT2pCVWZEN09vT2lNR3A2?=
 =?utf-8?B?UUphWmxhOTNnUkVYcjU0T01ES1JzM0UzQ3hNTCtDQjM3TDFlTlB2eG1HYnZv?=
 =?utf-8?B?YjliWjZET2RDVHNpRzZZWmp6ZHJxZHhQaDZtVit4VjFsMnVoSnh6RkxCZWIr?=
 =?utf-8?B?bHRrcGpVdFFQUGRvYTBLdndBR3BzMHpLRDUrR1ZJbnBvRzFYQjdHSkpmNWUx?=
 =?utf-8?B?NVM0YXMxK3FlU2lGSFpiVmo1WTdZblNaZDRzMWsrYTZpb3FmWHpJT0RUaU81?=
 =?utf-8?B?NGNWMnQ2TFJXR1BQS0lhZUxGRW02d0tjaGd5eUhPSENKT2NBSmJxeE5TaHNS?=
 =?utf-8?B?UE9IQzh0QWVkMmN5Q1JOTGpWWlhIN1Z5bVhHK0M5K3dNMk55MzBrWFZWT01P?=
 =?utf-8?B?T1lUbEgzN2gyNXcwRlNoTUQ1UDg0bnF1eWNPeHd0ejVOUDhLVFY1b25Pc0RO?=
 =?utf-8?B?d3J5ZG5ra1JkTjIxWC9SamlxTTlXWTl3dlFISnUvQ2FxYjNOelovYi9TRHRJ?=
 =?utf-8?B?V2RINWtrbW14Uy9MbEMxZlpFK1J5MGhpUjEwOGFiSTFqTW9yTEhWUHFvc1JN?=
 =?utf-8?B?ZHd3SmtFbGJROUlOOEVwTUxKZGNkdy9rcGxyWlVjUXp5eEc1TTZDT2dFaVFn?=
 =?utf-8?B?Nk5aWnNMVlBmM3FOYjg5S3BGKzhIZzI3Um5zeUVVRDJIMm1LTGFHRUtDRUJN?=
 =?utf-8?B?cUFqUDlJNHpBemJYVW5kb0RkUFVURWpheWRLRHRPV3pzY3Flc0FDblpNK1Ur?=
 =?utf-8?B?dEJiS0lRbkZsMEhuMnVZV3Z5MTZYOVJlbk0yVm5VMUt1Y2Z3M2xvVzJqa3l0?=
 =?utf-8?B?OVE4ZTdZZjVYZllXaE9NZlZrTDVnNzdCc1ZOOC9oUjJ0RUFpQjJjOCs0ODIz?=
 =?utf-8?B?QlRZYnB2T3JYMFJGSk5FaFN3SmVtOU9PcTVSUkJlYzhrZU1LZFAzTGRwMkF1?=
 =?utf-8?B?WStSWmpJUGtHUHB5MDN4N2FwMTR0bm1BclorRVFYNWRIcEdmQ1ZUUldUVDhi?=
 =?utf-8?B?cmkyYWo1eUQxc0V5eXAwMEdwajRxdERQQUY5MGFHazBDY0s1WkNBUjlWU2xs?=
 =?utf-8?B?dEdjN1N6cWlNN0poQ2hoeEVVRmNTdTlKNmVlbkdJQjdRRVZ5SW9EclQwMDBE?=
 =?utf-8?B?WTV1MGJaQUl1QnFmUnJqSWF5c20wUnk3S2YxZHVYYUFwQU5kVjUxalN4UXlq?=
 =?utf-8?B?bmNFQlc0Y0FoYm1mbWo0YWJoY2pVQ2dLWXM3b1VWWGRJR0RZMG1RcExXdWQ2?=
 =?utf-8?B?RXNmakYwSVVUbkZQY1B6YVdqUGx1NHFEdTdoR1p1QlIySGV2UEVvcU83OGVh?=
 =?utf-8?B?d0g2ekFCb0xPRkN5VktNMzVBMjYxRXBzZXoyQ2t5NXFTUmIyVS9pQnNwZ1hw?=
 =?utf-8?B?ak1uUk44UWFNaU12bEl3QllJbThpSmJIYk9HSzlRbi9IdllkTFNRdmJ1U0Qy?=
 =?utf-8?B?eXhQNTNaVDM5S25FK0xIYzRyamM0OHZIUCtRTE5vMGEzWHJpbXZRUmxHMlVD?=
 =?utf-8?Q?quC9Kkte08+z1+cGNlJ4xo3bJci/c7ql?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cXdVMXIzbVVYWEdRd3dXdHN3TXozcVdQUHpRQWhmS25hMVphRzYwbENxVnls?=
 =?utf-8?B?YXAyRWJNZElwVGZYU01jczgvcTRyTmdQbEJIbFVRdFZRY2g0Y0NkOFpCTzBC?=
 =?utf-8?B?MEpOR1BWOWxUbCtoVW5BQ1g4a1V1MHZIY1R0bzNiNFNwQ0hHNGFCWjlHclhP?=
 =?utf-8?B?ekxoWENENWQ0aHhPOWQzOTNNTW51c3pCQmQ4S09nQTI2UDNZZHQ4UmJHOVkw?=
 =?utf-8?B?L3BSYVpmWnl3TlNhUjEzTHpiTmJFQUkrUTRzTFVtZmlrTWJ5emhSM0J4Q284?=
 =?utf-8?B?Ynp5Vitqd1RsVUpHam04bG1zU0ZxaHZDVG5GanFYSFYyWUYrU0I5Q2Nub2hF?=
 =?utf-8?B?VFNtY1pid282ZS90UEdRWWJQWmlzWGttTXpjNmZiTGJ2UnkwcHpuM1hLTTk4?=
 =?utf-8?B?UHZ2NXl5a2pGZXdyWXlmb21vZUpXMi94YmhzNmtBNWVkOUZZQ2FXeWNxS0tM?=
 =?utf-8?B?Y3pldVBlVXZ5ZFM3ZzU1LzRudk1mU0YvZU5CMjZMOWpseGVoVU9tYXk3RkNR?=
 =?utf-8?B?cHZ1VUpkT1Nxa2RBckxJR0xQc1hzSXA1OHg0alMzK1Nyb1BrZjNtLzJlZVpr?=
 =?utf-8?B?anZRWjRUdU9VMndxQllhVkRSZkpkS3JiK3cwWnJHNzZSQUE1Zkt0VkhQejVL?=
 =?utf-8?B?YytNRmZYVmI1NHFMejM4N2FKQ3RjdEdEL01LbGFGSlpsRGljb1VjV2o3TVJ3?=
 =?utf-8?B?WTdxQUpHYlhqd1FnK0ZoN0w3Z2dRekdOYUxXZ1pXZlJ6bjJNaUNGRDNBUWc0?=
 =?utf-8?B?NGZpQWxsMmE4WVBlYjRFN1JVc2tqVFhhLzdsQTdpWG1SWC9aYnp0MzVEa1Ju?=
 =?utf-8?B?WEpKUE1VVlZvL1ZzZnJESWpVNC9XZEpReGJLWlRDRFRQY2QyN0pUcENOT29h?=
 =?utf-8?B?Nk5xME9JaHV1a01DSXdYSnRTN1I3aTVVSDUzbUpsNHkrclcxcW4wbUlLUk5p?=
 =?utf-8?B?UmVybFBqUU1ldGFDak5UaEEwazh0UURXUEk4LzV3OHFuL0RmN3JGczZ5djhy?=
 =?utf-8?B?SGdONE9sZnhOQUdHUEhxTncyZkova1U3TG5yaFpjcjlsaXBxdlpMdTQrMnpB?=
 =?utf-8?B?bkVjNkErY0xreXB2eWMvd2NKVDBURDBqa1ZiaXppRkRpMkpaSy9peFFOdkV1?=
 =?utf-8?B?dTVCRXNHTVB6bTkzYlRWcmVkWnR6NnlVS2RIT0xncWRxWGV5RHZBbmQzb05x?=
 =?utf-8?B?TmNZSGFRWXljOEtzZU5FZFVIU2l0MXErVndScDk3QStjSUd4NVdjM2tDU1o4?=
 =?utf-8?B?SFBlUVZXWmp5TXZuaVppNEJhRm43bGd1SHhXd0pOVnprZC9WTm9mTGpBdmt4?=
 =?utf-8?B?MjhGTW5hakJQZmFHN2gvbEdXVVREYjdROFRTTEcyczZ4cy96bDRsRjUwa1hE?=
 =?utf-8?B?R0hhK3E0SjJGZUxrTDI4SXdsbzdxSFV5Kzd0aHRqQ3pqb2ErMUZIa1BtdDFs?=
 =?utf-8?B?TU4zUFc2RlFHdXBvMG5XSDlLclB5RGhZbzc2NkJyVysrOW5CS2N5bEZOVk43?=
 =?utf-8?B?NGV1TFRLUDh1WTNRVzNyRWYwWHFIYUN3Z2dhRXBQbVlmd2E1UW00V056RlBz?=
 =?utf-8?B?enRrLy9VTFRTdFhmZG5kQTIwTG5HM1M3bVAwR1BTQS9rU0NrQ09SaWZGK2kw?=
 =?utf-8?B?WFBMQnJHUEpRODZRc0IvWk11Z0tIenE1eXZQNm1nYmluVkhobUdneXM1bUNn?=
 =?utf-8?B?eGpsbzh4WGlSUzc3ZS9oenNSbnpjaldyKzN4alZsblMyZzJ5SjFzUVEzS3c2?=
 =?utf-8?B?S3F0YzJYNDExUDFkRERzcDFpZE1ZV0I0emNQMFBEU3QzMXRxRFZXVStUcEF1?=
 =?utf-8?B?ZVZBNWcwVEpYOU90akJ1WnpJLzYwZi9wbVNRa0RyRjFwZG05eGRqVjUvUWNa?=
 =?utf-8?B?SWZJN002eTRLL3RtYlZva2hNVm9lMC9NanBlVmVBeGdxTUZCUmpZZGlIZTdX?=
 =?utf-8?B?TjVmaEZDNUk5Q0hXdGY5L1UyOUhtV3o5bklJWkRxUFRGRmpmRlI1YkdBdTR4?=
 =?utf-8?B?QWRoY2M1OHU4RzlLT0x5RGpTVHRLeERMNUo3dzJJblA4cXlBZnJ4eUpmVHl4?=
 =?utf-8?B?YWRFNk1id1A1UlJlUHF5Q3pSOXo2eFVtQlF6UkVNQVVjcnZ1YUFKcmE4SDl2?=
 =?utf-8?B?dHBlYm4vNEpLWEVRMlI3UlR2TFlYYjBSZ1pWVUR2U3FlUXBsMGswVnVGZGYr?=
 =?utf-8?Q?aMy25LITtp4Un4NuQ5/8JKE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c43429a9-c5e1-407c-8bb8-08dd406011ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 12:25:51.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnVWJ2zWflCa9AbdmQZdn4IwzsRsrzj9FG5FAe2A5tpisw+ShIWblfgXjI5Q49QFbuho7sX+eC3QI+lv51b4UwyZd0LFiXpg9P6cvLSk0n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5806
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <262D4BB08662124B878F891F29D62A38@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 06:25:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17685

T24gTW9uLCAyMDI1LTAxLTI3IGF0IDE1OjA3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBleGNsdWRlcyB0aGUgY29udGVudCBvZiBib3RoIHZhciBhbmQgaG9tZSBm
cm9tIHRoZSByb290IGZpbGUNCj4gc3lzdGVtLg0KPiANCj4gVGhpcyBmaXhlcyBpc3N1ZSAjMTI2
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgY2xhc3Nlcy9yZWFkLW9ubHktcm9vdGZzLmJiY2xh
c3MgfCA0ICsrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvY2xhc3Nlcy9yZWFkLW9ubHktcm9vdGZzLmJiY2xhc3MgYi9jbGFzc2VzL3Jl
YWQtb25seS0NCj4gcm9vdGZzLmJiY2xhc3MNCj4gaW5kZXggOWViY2FkYy4uYjNiYWIzMiAxMDA2
NDQNCj4gLS0tIGEvY2xhc3Nlcy9yZWFkLW9ubHktcm9vdGZzLmJiY2xhc3MNCj4gKysrIGIvY2xh
c3Nlcy9yZWFkLW9ubHktcm9vdGZzLmJiY2xhc3MNCj4gQEAgLTM0LDYgKzM0LDEwIEBAIGNvcHlf
ZHBrZ19zdGF0ZSgpIHsNCj4gwqDCoMKgwqAgc3VkbyBjcCAtYSAke1JPT1RGU0RJUn0vdmFyL2xp
Yi9kcGtnICIkSU1NVVRBQkxFX1ZBUl9MSUIvIg0KPiDCoH0NCj4gwqANCj4gK1JPX1JPT1RGU19F
WENMVURFX0RJUlMgPSAidmFyIGhvbWUiDQo+ICtFUk9GU19FWENMVURFX0RJUlMgPSAiJHtST19S
T09URlNfRVhDTFVERV9ESVJTfSINCj4gK1NRVUFTSEZTX0VYQ0xVREVfRElSUyA9ICIke1JPX1JP
T1RGU19FWENMVURFX0RJUlN9Ig0KDQpIaSwNCg0Kd2Ugc2hvdWxkIGFsc28gZXhjbHVkZSBib290
LCBidXQgSSdtIHVuc3VyZSB3aHkgdGhpcyBpcyBkb25lIGluIHRoZQ0KcmVhZC1vbmx5LXJvb3Rm
cyBjbGFzcz8gWW91IGNhbiAqdmVyeS13ZWxsKiBoYXZlIGEgcm8gcm9vdGZzIHRoYXQNCmluY2x1
ZGVzIGEgaG9tZSB0aGF0IGlzIG92ZXItbW91bnRlZCB3aXRoIGFuIG92ZXJsYXkuDQoNCkluIG15
IG9waW5pb24sIHRoaXMgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIGltYWdlcnMgaW5zdGVhZC4NCg0K
QmVzdCByZWdhcmRzLA0KRmVsaXgNCg0KPiArDQo+IMKgaW1hZ2VfY29uZmlndXJlX2ZzdGFiKCkg
ew0KPiDCoMKgwqDCoCBzdWRvIHRlZSAnJHtJTUFHRV9ST09URlN9L2V0Yy9mc3RhYicgPDwgRU9G
DQo+IMKgIyBCZWdpbiAvZXRjL2ZzdGFiDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0
IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBH
ZXJtYW55DQoNCg0K

