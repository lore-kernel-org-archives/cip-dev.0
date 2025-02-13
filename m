Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECBBC0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 11:40:11 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.65])
 by mx.groups.io with SMTP id smtpd.web10.9280.1739446808497953988
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 03:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FgPIlOL8;
 spf=pass (domain: siemens.com, ip: 40.107.103.65, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6W234OcifSe4aBgm/S+ZBLNudTaAthIoTOxeg8FAtLZIcwM8+gBpum3WEhPTbDh5B8xTy8RBoO/gIbbjaOzQp7QQ1ejF2DnQ4RQf0rYRhLtbzcI9+nZgjWytDVqZCuzysIPBsOgN6ptA/2cs4B/gjxJN+x6CIKn2h6BIbGhDHiTtyqPlsg5Y9j+UPEKJH2Jt/zv48Fry6P41/M5OOQhzhAs/GhOWMj/Lvol76OaWNhfMqVvRIJT47FyhltXv9+RV43WGEY5eCQBU8MBaKvurja5SCh809nV0I9EwrYKB+OGS9MhHmeI6u1up3QF0cE5MaLPbVIrB4ySMqVBhDzLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et1XeMzjJshk51y+w3HT38R1GeHhB1EjtPc+CP2yoxI=;
 b=XYeUxPnucsYtF2uAjAfx9wHI+Cbddr2zYiC44NOeDGaZoBna3Uz20ayx7so9iJEIqpEEvR0l9I0z7TDBx3d7mgSsuc/QzuYRp3M8NmUdavZB/Ywr7IzFMAA7XzuC7kiLAv/V0VaFhXGP58IqufXSLr9rhbF3CHI9VMdWsBkIZJvZE43UCyh9Ol2XbZb870Z1todrCuWSTD9OF9R42KGSIPvhmeR981eEk92XuqFpacCo47K1wGaMTiEeTZMzQDjcHjSxaT7lhx2V3/eWbYnO8HAE4+DwFh12KH0fo7SozYE/2/m09ZOPRLyWvUjd9e/ZaD/ElJS0uG+wFZFaprSaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et1XeMzjJshk51y+w3HT38R1GeHhB1EjtPc+CP2yoxI=;
 b=FgPIlOL8vdeXlHWHfas21/ftjvLuRO04gst4bu7fFEE4U3d/x02f36FbbzRNTHIld5tAIdWemDbKZ+NS5IU+J8ddCvwoPmr4RKwww5ugcWnW6fCA4KnLGM59NMTIEBQ8D9qYX71tuZTtjVIPXFntjR94doXrV0hj0QPH8AxyzJ8krTLVTOhnNI8ENcYLwQM9y6rCKBxJFSHkEbgssxdrYgtQ+5PcyHquG9DiFOcgJZsDRX5WyB25J8NyjfJCjL19Csmf32TaSjdR4WVhVWjCslVBJ+26J42LVcFe8/XM+hdH0D+SdQ+CI1pElMq31700UuQ78hrC/oCraHleKwOmdg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DU0PR10MB6155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Thu, 13 Feb
 2025 11:40:04 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.008; Thu, 13 Feb 2025
 11:40:04 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] swupdate-config: suffix package
 with -${MACHINE}
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] swupdate-config: suffix package
 with -${MACHINE}
Thread-Index: AQHbfFksD6RUMNmorUmKhR1iQ3LWRrNCdLSAgAKqpIA=
Date: Thu, 13 Feb 2025 11:40:04 +0000
Message-ID: <0dbecbd4224dcb08f6ec672a9e5f3f5a2f368e31.camel@siemens.com>
References: <20250211074636.348469-1-cedric.hombourger@siemens.com>
	 <2ceea85f-73f4-48dd-be48-a5f927314a02@siemens.com>
In-Reply-To: <2ceea85f-73f4-48dd-be48-a5f927314a02@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DU0PR10MB6155:EE_
x-ms-office365-filtering-correlation-id: 2614f58f-eb0d-4ff7-6dfa-08dd4c2328b9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RStmclZDeUVVeFR2dHFhbEZaOWRleTF0RThHdHQrWWhrMVdqVHhUbEtVczNX?=
 =?utf-8?B?VGVuV0NBVkNsd3BmRDBiWnU3dGs0UUFjOGdXdkJUbFRjOFEyWlRWWjQ2ZS93?=
 =?utf-8?B?UEVDNERLZ0QzMmpVVmZUZkFoYTlWdVc1MHRjSEF5Y2VkYjEwZDh3QzF2U2Vn?=
 =?utf-8?B?YW9HTE5uRmE3NCs1S0w2R3M1aEQ2b25lYTM3MExhdlo5OCtQUXhyWjlGNFcz?=
 =?utf-8?B?dUxZQmdxQmsyTG50L2dGUm9TUGd0SFZzK3JJVmRpYWZ6QTRROSsvcmtTZkd5?=
 =?utf-8?B?VEplUTZjVDlWU2JoYS9pUGR1aDB6NFlEQXdIbHMwL0txc2ZJVGx6VUpuTTJt?=
 =?utf-8?B?Nmo5a3B5TzBxZncwdmIxa0VKTXgvL00rTU43a3VHRkc0QjdaQjVDeEIybUd6?=
 =?utf-8?B?Zk9GaVVvdW5ObkNHUFpxNjJYZnVCckM1OEVvUTFIT0gwU0ZuM0tMc2F4SXdo?=
 =?utf-8?B?c3BGcGREdEEzSm94MlVEUDZJRnk1VDNPMXhPUnkzWUQ4cXVHVldmbHI3SHJm?=
 =?utf-8?B?bmJWNTd2bS9peGR1Z21mY3VXR3BiUEp4dlpsZnRKeWhXRTA4bERqSWNjc2hw?=
 =?utf-8?B?QUVqbnNoV0RPTWNOR2RDZUpWQzlKdmtpckdiRGJEWm56QTVxbk4wcVBHNTNE?=
 =?utf-8?B?MGtPWkFKQnpOck1sU09yMnR1bEppQjFKcFA4V3Nub2IwdDhGNE45bzNuSzkw?=
 =?utf-8?B?ZUVnQzFrc3ByL1k4Y1ZNa1lkMXgvTHpEQlF3S3JzVEsvMmk1NFZhaFBLckM5?=
 =?utf-8?B?dEhpQlQwdnBQTlphU1RXK0Z1OXpOSXg2b21uTWdXK3RMd1g5QStpUFVSdUdW?=
 =?utf-8?B?UFlUNTJOVnVCVGRZekRsMjRGT0FyQk1XTlVDMnNzejVRNlpRRUZVcFpxTU9H?=
 =?utf-8?B?Ti9ndHZMYk85b2ZreDJsN2ZrQzBGTTlHZm9JTmhCRjZ3V1ZTR0s0NmtBWDNG?=
 =?utf-8?B?Wlg1Ymt1TTRyY2dlTUtZMDFHdWp6a0tXTDNBMWdoUVFsRlJJbXZUUWpYY2w1?=
 =?utf-8?B?UW1ldG5WMTNLWWc5RlZLL3R0YmZVSk0yT28yUDFoTGJrTVdEK0Ntck10Wm9u?=
 =?utf-8?B?TGdFL2M5VW8vQkRtQTd0TTJHQW0yTWx2S21OWFlUbDExVDhROUhnQm5wYjBs?=
 =?utf-8?B?L0ovYnJzUTE3cTdpd2IrUWlwMUE1R0R3TjcyY1NPd01NVzg4d0t5U0grdlJK?=
 =?utf-8?B?VVdLZ2NXUlBaTXNPRDZCQURmcW9SZTl5SVY2VXhtV001YnVwQXdBTzIyYUxD?=
 =?utf-8?B?QnkxUG9jak9jYmw1Q1JlUzFFdG04dFlwZkFiNzY0T1RlaURSbUE0UHlXMllo?=
 =?utf-8?B?bjhPSWcxanlGelR4bkdPbyt2YXYvam5WOGtlaHNLY1JJRFhhZksxeGt5dTR1?=
 =?utf-8?B?c3Nqc3ErTVdlMzBoYjUyL2dIM1J1UzJpZDJvcFFkNTlXV3VEMHNYczh1eS90?=
 =?utf-8?B?Vk9lNTBLelFDbE5LaFFRanJIOTJCVGRCeEJ1STNOQVZQdG9EREhPalVpTjFh?=
 =?utf-8?B?cmh1MFhNN2I4UzF6Y1ozRTViZ0VZbFJ1VWtnemtjaXpKd2hPVG1ZdDZ5cWFX?=
 =?utf-8?B?MHFCNE1hdzZCNnJYU0Z1MHVjRit1R2VIWDh0YVltVkptRTdwTUZUaCtLYmhQ?=
 =?utf-8?B?anJMNTMwZ25wVU1sMk1ZZVI3MEYvZFFBUUtDR2krVk5QZm0xaWhIVnlXWjkw?=
 =?utf-8?B?ODNzckpmYTdhU3JjbzlwODhKcTVoY21HU2lzUmVvSGExK1RLV2VYNGpFeEF5?=
 =?utf-8?B?TUxtK2ZGalB4aTlqMDlRS1RhaWZSRHJ4ckdONHZvc2JJUUFVVFBuVHpqbE02?=
 =?utf-8?B?UkorejBTeHgxRXh3S3FrMnpXZFlOeFZHY3VoaGJLY01TTXNSWmhneVo2SDJQ?=
 =?utf-8?Q?UQZZHZgZao1vh?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UHJGcUF6NkVPNHhnUWxCQjR2Z0MrSnAvVGZITVBjMktDTWlNSDIybDRNci9D?=
 =?utf-8?B?RVpiVjMwZzNkRlNlbXBIbEpDV3NuS2hiODhNa1lyMGh3ZVZRQW9STi9hQmJB?=
 =?utf-8?B?cEtVSWR1Zm9OS1IwU05FSG02b0dYZk9IdWxFWmJhUTlQSUpHVWhwQkpmS2ky?=
 =?utf-8?B?S09aZVRsNWxsZldUdzA4TldyS3pJc25MRUhkSVVCTnVDRDNVczlyQ2MzbFV3?=
 =?utf-8?B?dlFNSkxib1lMaHZFMjNjNzE4NThlRHBLL3YwWEs4dFRrMjFpRzFLeFBiamtm?=
 =?utf-8?B?UmJqL0E1NjNyZSt1OWNCODFVRk55bkZzdUcyN1VnMWd0c0JMWS8vaVZFYnBY?=
 =?utf-8?B?MjNWMW1ZSWpzNHdDUnRxQlpuYzJvRFMyWkNQTVhQOEJzTXpNbWxNemRMdktM?=
 =?utf-8?B?U09JSjBTTHVSR3ByeFdMdEc2VFhzVnV3WWlOcENEVk9DUVRFZXJkVlhhWGcz?=
 =?utf-8?B?YnNGcG9nbXY4dGQ2YnlrUW9uV1NWdjBCR3hXQ1Vqck9ITXQyTHBzdWp6OExx?=
 =?utf-8?B?Qk50S0pERWhJL0ZXWjNYRGJHUmYrR2tGRk53ajZLaVJlWFE4NVZ5T3lsUkhv?=
 =?utf-8?B?Y2lDcGJ5alBiVEl0NnFNeEp6dWd2Zjh4Znd4ZDV5QWFROENTTXVNQm5WZjhX?=
 =?utf-8?B?YThmdGVuWk05Q2swb0lPc3RxWU9pWEVNNHJ3cjVOTjlHQ3FDb2JjdjRWVmNa?=
 =?utf-8?B?em41TFlWc2o2U2prbnJsR0RFK2gyR1JHVFVzK1NZOXBvSm9zUWlURk1XeWpz?=
 =?utf-8?B?YWFOYkZYbk9rM2g5ZHNoYzJUbWNJbXVxekk1Tko0S0srT0pYckQ5YTYrQVhK?=
 =?utf-8?B?RmJzNGVmaThKRW1uM0p3Y2d4SnRpcTBjdkVnTENNTW9kY3hRQ0lYZnZQcVBz?=
 =?utf-8?B?ZWJ3c1lzNXpXWkVFOGlDS0IzN3h3MVdNVXE5QkJ0Qk5PSkpOZ3FRYThLc1Qr?=
 =?utf-8?B?YmJaQW9oenBSaTNFSi9FWks2S0ZWNWVoNFJBTmZyNGhoOUh3WEYwT1VUcDdi?=
 =?utf-8?B?YlZMY1QyZCtnNGRDS05jNHVsVHM4cEVmNEdIYlM0aUFRdHdvL2c0Vm9qTU5M?=
 =?utf-8?B?c2lhNTNJSEtneVNlay9MVlhGbnV3QmZ4RmpaUEhGOEdlaHBJcGFlRVlQZDBh?=
 =?utf-8?B?RkFBYS9iVlJJZVFVRFFlcm0zSkF4WkljYXZwU1RqVDY5TENDR2ZPUEdHR1NT?=
 =?utf-8?B?UDJ4aEV5YXB3ZVpTOUVIZmJwRUxEZXIxN1k1cE56Y3FleG9YV3NtbElGK3hL?=
 =?utf-8?B?c1ppSGpYTElwQ1RPMWJnNmkyRVdZak45Zks2b2hkbDhEdzVrVjhlbjk5Tk5l?=
 =?utf-8?B?MEJhbzFRMXBoamJyNHdTYjVaSmhhM3ZWR2NTQXJQWWR0Y01LTTY4YXAvY1U1?=
 =?utf-8?B?VlFOdVZKYkM2NDYvQkk3YUVmZXRTKzlRc2V0Z2Q3d2xod29kY0JQZkYzTFpV?=
 =?utf-8?B?KythMDV6d0J6US9JYy9yc1lkc0IvQjhqY09Nc2tYWVJpdjluSFdsL2NqaU0x?=
 =?utf-8?B?U1QvT0RRKzE5NnNTUDJwdTkyNFpaSVJ2SkdIanBhQUpwOXFacFBCUU9EVjQ5?=
 =?utf-8?B?OER0UHBaNVFrU2ljQ0VZVG9JQnpGcDZkNjBtTzE2Zi9hVlRzWFg2OHp3VHY3?=
 =?utf-8?B?T3hKamdvdnllZkZXRmNNWHloMjNWYjVhY280MkVxZlhvZFBqbS93OE9vRWN1?=
 =?utf-8?B?N1EwTXRRek9RZm1GNnBzVFo1czc1WG5qRXA4RnhBRGU5TkJ1eGhjbjBTMStI?=
 =?utf-8?B?d0ZJYlpkSGZLMDNIVmhzeVducktNTEVQZkwxR2phVTMrNmdVWG1TU0RVMnZE?=
 =?utf-8?B?ZVNrWGRhZzZ4endFS0xDK3ZEMWNwN2UveWJqRnkwc21IVFcvQ0EySjBGZ0FK?=
 =?utf-8?B?L1FZakRDTkl5c2Z1WTVpWk4zdG9OeXo4YzJxZThQSjg2ZDd4NFFSMzJrZTlP?=
 =?utf-8?B?M0NHb0JkQ1IyeXhWV1lRRnkvVVpFRnA4UlJRZVlYeHZkSFl5NmlDSFhJckow?=
 =?utf-8?B?dTlLREVjVTBaN1hTUzhhdzhkMkR6TVUrOVV0SmZuK1BCeStMNDI4bjlwdGo4?=
 =?utf-8?B?b0ZXUVdDbGtnRVBzSzdpYkJDWUpZTzNKVVhvV2MxL2t3QzBRQ0pKTHorWUpX?=
 =?utf-8?B?K1RjdEZ2TDZJMHQzbTUxUm4xTk1IY1NXODlBVjZQeHNjM3hZMVd6bEJOS3hD?=
 =?utf-8?Q?cooiW7fwoTFb1TdDXI5eWBM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6E941311F347640A8BC5378B309F5CC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2614f58f-eb0d-4ff7-6dfa-08dd4c2328b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 11:40:04.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7K9R6+f3Vx0G7/6hh+VP4e8ihj0sU4BZOfzEqJY4G8ZL2Cn425Dxp36Nbj3Mifp3nSOaedMMp3ZMVHqQFpMwnzsNT45LECYJ2qpf/LEgHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 11:40:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17831

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE5OjU2ICswMTAwLCBKYW4gS2lzemthIHZpYSBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCndyb3RlOg0KPiBPbiAxMS4wMi4yNSAwODo0NiwgQ2VkcmljIEhvbWJv
dXJnZXIgd3JvdGU6DQo+ID4gc3d1cGRhdGUtY29uZmlnIGdlbmVyYXRlcyAke01BQ0hJTkV9LWRl
cGVuZGVudCBjb2RlIHNpbmNlIGl0IHVzZXMNCj4gPiB0ZW1wbGF0ZXMgd2hlcmUgJHtNQUNISU5F
fSBpcyBleHBhbmRlZCBmb3IgdGhlIGNvbmZpZ3VyYXRpb24gZmlsZXMNCj4gPiBpdCBzaGlwcy4g
VGhpcyBjYXVzZXMgcHJvYmxlbXMgaW4gbXVsdGljb25maWcgYnVpbGRzLiBEeW5hbWljYWxseQ0K
PiA+IHN1ZmZpeCB0aGUgbmFtZSBvZiB0aGUgcmVjaXBlIGFuZCBwYWNrYWdlIHdpdGggLSR7TUFD
SElORX0gdG8gZ2V0DQo+ID4gYSBzZXBhcmF0ZSBidWlsZCBmb3IgZWFjaCAke01BQ0hJTkV9IHNl
bGVjdGVkIGluIHRoZSBtdWx0aWNvbmZpZy4NCg0KSGkgQ2VkcmljIQ0KDQpXZSBhcmUgYWxzbyBo
ZWF2aWx5IHJlbHlpbmcgb24gTUMgdG8gY3JlYXRlIG11bHRpcGxlIGltYWdlcyBmb3Igc2FtZQ0K
YXJjaGl0ZWN0dXJlIHVzaW5nIGRpZmZlcmluZyBwYWNrYWdlcyBmb3IgbWFjaGluZSBzcGVjaWZp
YyBjb21wb25lbnRzLg0KDQpXZSBmb2xsb3dlZCBhIHNpbWlsYXIgYXBwcm9hY2guDQpDb21wYXJl
ZCB0byB5b3VyIHBhdGNoIHdlIHNpbXBseSBhcHBlbmRlZCB0aGUgUE4gLj0gIi0ke01BQ0hJTkV9
IiBsaWtlDQp5b3UgZGlkIGFuZCBzcGVjaWZpZWQgdGhlIGV4YWN0IHBhY2thZ2Ugd2Ugd2FudCB0
byBiZSBwYXJ0IG9mIHRoZSBpbWFnZQ0KSU1BR0VfSU5TVEFMTCArPSAic3d1cGRhdGUtY29uZmln
LSR7TUFDSElORX0iDQoNCkkgaGF2ZSB0byBhZG1pdCwgeW91ciBzb2x1dGlvbiBzZWVtcyBtb3Jl
IGVsZWdhbnQgdGhhbiB3aGF0IHdlIGRpZCwgYXQNCmxlYXN0IGFzIGxvbmcgYXMgdGhlcmUgaXMg
bm8gY29uZmxpY3QuIEhvdyBkbyB5b3UgcmVzb2x2ZQ0KcGFja2FnZSBjb25mbGljdHMgaW4gbWMg
d2hlcmUgc3d1cGRhdGUtY29uZmlnIGlzIHByb3ZpZGVkIGJ5IG11bHRpcGxlIA0KcGFja2FnZXM/
IGBQUkVGRVJSRURfUFJPVklERVJfLi4uYA0KDQoNCkhvdyBkaWQgeW91IGZpeCBtdWx0aXBsZSB0
YXJnZXQgaW1hZ2UgYnVpbGRzIHdpdGggdGhlIGV4aXN0aW5nDQppbml0cmFtZnMgcGFja2FnZXM/
IFdlIGJ1aWx0IHNwZWNpZmljIHBhY2thZ2VzIGZvciBpbml0cmFtZnMgaG9va3MgbGlrZQ0KYGlu
aXRyYW1mcy12ZXJpdHktaG9vay0ke01BQ0hJTkV9YA0KDQpXZSBkaWQgdGhhdCBmb2xsb3dpbmcg
c2FtZSBhcHByb2FjaCBhcyBtZW50aW9uZWQgYWJvdmU6IA0KYFBOID0gImluaXRyYW1mcy12ZXJp
dHktaG9vay0ke01BQ0hJTkV9ImANCg0KRGlkIHlvdSBmaW5kIGEgbW9yZSBnZW5lcmljIGFwcHJv
YWNoIHRvIGZpeCB0aGF0Pw0KDQpCUiBBbGV4DQoNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
ZWRyaWMgSG9tYm91cmdlciA8Y2VkcmljLmhvbWJvdXJnZXJAc2llbWVucy5jb20+DQo+ID4gLS0t
DQo+ID4gwqAuLi4ve3N3dXBkYXRlLWNvbmZpZ18wLjEuYmIgPT4gc3d1cGRhdGUtY29uZmlnXzAu
Mi5iYn3CoMKgwqDCoMKgwqAgfCA1DQo+ID4gKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCj4gPiDCoHJlbmFtZSByZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmln
L3tzd3VwZGF0ZS1jb25maWdfMC4xLmJiID0+DQo+ID4gc3d1cGRhdGUtY29uZmlnXzAuMi5iYn0g
KDg5JSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZp
Zy9zd3VwZGF0ZS1jb25maWdfMC4xLmJiDQo+ID4gYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29u
ZmlnL3N3dXBkYXRlLWNvbmZpZ18wLjIuYmINCj4gPiBzaW1pbGFyaXR5IGluZGV4IDg5JQ0KPiA+
IHJlbmFtZSBmcm9tIHJlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmln
XzAuMS5iYg0KPiA+IHJlbmFtZSB0byByZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL3N3dXBk
YXRlLWNvbmZpZ18wLjIuYmINCj4gPiBpbmRleCAzNDk1Mjg1Li42M2ZhMzIwIDEwMDY0NA0KPiA+
IC0tLSBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmlnXzAuMS5i
Yg0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmln
XzAuMi5iYg0KPiA+IEBAIC0xMSw2ICsxMSwxMSBAQA0KPiA+IMKgDQo+ID4gwqBpbmhlcml0IGRw
a2ctcmF3DQo+ID4gwqANCj4gPiArUFJPVklERVMgOj0gIiR7UE59Ig0KPiA+ICtERUJJQU5fUFJP
VklERVMgOj0gIiR7UE59Ig0KPiA+ICsNCj4gPiArUE4gLj0gIi0ke01BQ0hJTkV9Ig0KPiA+ICsN
Cj4gPiDCoFNSQ19VUkkgPSAiZmlsZTovL3N3dXBkYXRlLmNmZ8KgXA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmlsZTovL2h3cmV2aXNpb24udG1wbCINCj4gPiDCoA0KPiANCj4gWWVhaCwg
bXVsdGljb25maWcgaXMgbm90IHRoYXQgZnJlcXVlbnRseSB1c2VkIGRvd25zdHJlYW0uIEFuZCBp
ZiBzbywNCj4gdGhlbiBmb3IgY29tcG9zaW5nIGNvbXBsZXggaW1hZ2VzIChpbnN0YWxsZXIgd2l0
aCB0YXJnZXQgaW1hZ2UNCj4gaW5jbHVkZWQpLCBub3QgZm9yIGJ1aWxkaW5nIG11bHRpcGxlIHRh
cmdldCBpbWFnZXMgYXQgdGhlIHNhbWUgdGltZS4NCj4gQW55d2F5LCB0aGUgY2hhbmdlIG1ha2Vz
IHNlbnNlLg0KPiANCj4gQXBwbGllZCwgdGhhbmtzLg0KPiANCj4gSmFuDQo+IA0KPiANCj4gLT0t
PS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBz
ZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTc4MTIpOg0KPiBodHRw
czovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS8xNzgxMg0KPiBNdXRl
IFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210LzExMTExODc3Mi84
ODg2NDIzDQo+IEdyb3VwIE93bmVyOiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBVbnN1YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9jaXAt
ZGV2L2xlYXZlLzEzNTgxNTU2Lzg4ODY0MjMvNTQyMzY0NDY4L3h5enp5DQo+IMKgW2FsZXhhbmRl
ci5oZWluaXNjaEBzaWVtZW5zLmNvbV0NCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gDQoN
Cg==

