Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034AC021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 12:05:53 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.86])
 by mx.groups.io with SMTP id smtpd.web10.21513.1740139550320072162
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2025 04:05:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Al2on7MZ;
 spf=pass (domain: siemens.com, ip: 40.107.104.86, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBkOwUR2F4Kgnxx30iR6NCkf2JRvZ1hFKERPDVpIwClvhAAl7gM1Cf5smFo6zsanYLXpDlRvbVgjVqouNESagjP/F+idAN+JO5yRHvOdLqVAc9SCQMgOwKWmGSuKfxCo419cxIl/N2F0N8J5iFShE6WadnEP2jeqX5XtPbBwSPqbFjZ7PoLSzsFrDVsxEjPAU9ia2dU3jIyAKYZxc+q2qWDpQP1MkUxb6qJS7BNepBHC52zdqd6ITOd8LzfJq4lNprM83g9ZAIYYE8DNDE316KNkcCSPB9Qyn/yVG6XtisDdFO7waMaY6wCAmQ7QrnCKKxvPDKnSVbX+WHl8F0/ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekL7Q/FhNFsDqUu68/vdscPiayQcc/IwWq0Np7IAMLc=;
 b=JyNN1n4hs7KhbinfEOZzaEpitYFSsEpsOcGk2WKBQmpaEg9GcWPjoXQptksADsT8VuUG2h50idXN5D/xMr9PiT1wc8qe4b5LvndrIepOrKq/BAouIIcxdBeJ8xdqU3as/DnzjI1JL9QoO9ZxHvLc5uIE0QifyaZUdoa86SM0mo56tTpWA0UdcxXTvbiOtapAUb14iiXvez68NO5hGy1w9NJk9X1PaoPHN7WrSt23y2Cy6Yrfn6JD2irTwSgFmMQhQHFxhoVUdEIc0mRHewdYTGVSQBdXJQWB6oXOfTX5s6lxnThoTJ9Pi04RK8Of9XmJhiS5xqdxGhDJBGw7nINxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekL7Q/FhNFsDqUu68/vdscPiayQcc/IwWq0Np7IAMLc=;
 b=Al2on7MZnME/TPgpZsPQEfk3JBZUb4eI7xT+xWMnsexUFFdNwJHukztpxNqebPSk5aRUzFwwHOXgDXS0B3aYAilNWUfT+CUwZfZIzpG0HXVCaibuwBhuOkLeqT6RYDWBcsDJCbxvDBLWFKrC0ijqPl64efE6piStamLda5X9m8ZqlPzsMA23hXrY9H44os3A/Q72mmHV2WTpVg4+z20a4rTYO6Gt1BaPRfGQaAI9SWTubTRtcWY0VpzDX5/X6UqBseH4ayKtdNi7odDGubMqwR69EIDsipGdB1IIiiB82L5pT4WOTebgfPBZ6uAkCtBzhn+FyAfxRNRpGDJWub+59A==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AS8PR10MB7428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 12:05:47 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 12:05:47 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: RE: [isar-cip-core][PATCH 0/3] Added support for rootfs-overlay (for
 development).
Thread-Topic: [isar-cip-core][PATCH 0/3] Added support for rootfs-overlay (for
 development).
Thread-Index: AQHbgSL2hzk/LWwrHkKf/OOEVnC6m7NMwNaAgATuBgA=
Date: Fri, 21 Feb 2025 12:05:47 +0000
Message-ID: 
 <AM7PR10MB3320A097C8BAFEABC4D22FD986C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <15b8d12e-46ce-47ce-be49-e22b2d8c16ea@siemens.com>
In-Reply-To: <15b8d12e-46ce-47ce-be49-e22b2d8c16ea@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=40345caf-2638-46d4-a61a-71442fe5e7db;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-21T12:03:06Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AS8PR10MB7428:EE_
x-ms-office365-filtering-correlation-id: 681dba98-4c6a-42ea-047c-08dd52701369
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RmN4NFNnbmFOVy9wUkpReE00UU92OFdJa1hvemdmcURoQUZTeVg1N0ViaVFr?=
 =?utf-8?B?NTdudjFKdExXU3ErOE8yU0gzMUk4TGFRNmliSFRqaWloZXRVVUhBSkxvTU9u?=
 =?utf-8?B?aXVISHI3Tk5pK1NteExWZmQ0VDNiMFdLdTd1TkI5d0UrV085eFJSOUxWR0RK?=
 =?utf-8?B?UVFlTmRvNG1Xb0FNREVDMWdpSEE4RlJJOVZxSXhYbmpiVmswc1ZueUpFQ2Rs?=
 =?utf-8?B?a252V1A0MFZnUGtwdjVOeEVZcXArVGU1NFhWb2lYRW0vN2krcnBLQmIyR01R?=
 =?utf-8?B?Zy9pbStNNnpoOFp1ZHdRSUZ1V3RNcmtYSktGKzFSRUNISnlZVUJyNlRDbHFH?=
 =?utf-8?B?VDJmVi9kSGp1OGhYNDRBRUl2eUN2L1prSnlLTDJScEVuUFc3U3YyMGRVMklC?=
 =?utf-8?B?SnMreE16NnhGeTBRNzIwVk9ReDNaWUpYR0ZsZ0ZlUzdCSEJ0RVAwTldsTDYr?=
 =?utf-8?B?V1QvaTVWdXJUZWM2clVKNzVzRzdERURzaGY2U0U3cW5VUHZVTkpIaGlxWFY0?=
 =?utf-8?B?TllUdWZUT1hBL2pMcGZyRUxuMG5VaGErZGszVi9oVVBrS0pKdll0ZkpTVmJM?=
 =?utf-8?B?cExGM1h2L0ZLUUhDeFNoUnBWYTNEOXg3WGs5a2llWjNGaXViZit5T2tEK28x?=
 =?utf-8?B?OUFSTGV5QlZzV0t4RGg0MDZVWlpVRXRrSlJ3eENUbkYvbGVlSkJCOHo4bjNk?=
 =?utf-8?B?OGJSRjMwNkt6S09obDg1SHE1QmxScURsMUlvWS9GRXVUYlIxeGlaU0hRUzhz?=
 =?utf-8?B?VVoxWHhNcWhYbEdlVEQrakJGdTRFS25TTUFZamJQTTRIdzI5cThMOWFhNnpy?=
 =?utf-8?B?d0Y1Q2lrWmg2Sk9TT1FOVG95bkwyRFp2TXBSY2g0WGRKRWJNV2UrTnp6RGhh?=
 =?utf-8?B?OFJURjNtSkFXWEQ2b2o5L0F1QWEyQ01WSU1zZldKemR2dlVYQ2tTK2dpSmU5?=
 =?utf-8?B?WGJpaE9yckd3dzh3a3BNQkEwOEhlTWpORXAvczREeEQzSjI1c1hJU0tkczNR?=
 =?utf-8?B?ZnphdGV1MHlVNlFnRWpoVDVuK2hHaUYvdTJFcTY1eEJORi9ZWVNROWNGeE54?=
 =?utf-8?B?cDZFano5cTc5c2lhVUE5dzFIS1IzTmoxckJCWGlseW5SVVhsbXd0Z1lRWWhx?=
 =?utf-8?B?QUtid0hTTXpYTkYwRnJwRW1CcldsNVBNRnJtSExIUGFWbmN6bkozdTMvYXpC?=
 =?utf-8?B?Z3I3NFB5L2xrZFNVYlNDbGpwY2FiRlhEVHkrNGxCZnZDTm1rMmJyUi80dGg3?=
 =?utf-8?B?MkFvcDZzQmRUTWIvNmxVN2hEaCtjb1FiNXJSeWFlS2k2ZHBNL3B2M3JFbThO?=
 =?utf-8?B?MldHQysyUzk5YVR0L0VyR2RVUnVINDJ3UjJVZmdsTVJkQllTb1JRZjhBSkYv?=
 =?utf-8?B?VjNDaW9BVThIUHBTZHBZU0N4blA0R0JMNzFUdlRDaXd3MkdJV1JpYVN0QjdG?=
 =?utf-8?B?djZGMmZBZ0FSWG4yTjhkS1V1RUlxQWNQVS9OZmcrc1d0ZloxMjNuRVM3SWVD?=
 =?utf-8?B?akE1SlNRTG1CRDdvNWo0RVRoZEdnWVBsblphUlYyeVJnSXluWlFDeUpvV01s?=
 =?utf-8?B?VDRiK2tQYUE2VmtvKzRZVlBqUnZkWUNLVGtyZjBzMUpkODFBZjhCaExYNWo4?=
 =?utf-8?B?RGl3VHAxQnE0S0FrVXJvWEpzT2RBR3VrYitheUdKZlJmM3dLd3dLVUdDNjFO?=
 =?utf-8?B?cjlWUGNvMnhnaFJPSkNLSmN5OTN4dEgrQzAzU0VXOGpRb3dESUhycERpR0Vz?=
 =?utf-8?B?Ni9KZTN0c3BweVJLeTh4VnRGTHIzR0xtMnNkdEpRRys1ZlRkYVU5ZFI1UzFx?=
 =?utf-8?B?MGlRZnJ3MkJjRXo2NWpYeUJ6K05OUXdhdjFDSzV3ZVc5aitNTTlKenRqcFM4?=
 =?utf-8?B?S0JtL3hyQ05FMFYrd1V0L2ttQ2VqYSt4QWZxZ2FHWjVrVTFuUGdDRVNQSXpL?=
 =?utf-8?Q?+jfXQ1w45mEaWFBxIJBCpsVh0tg+mLHw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVpMVVpKNjFQQmFpd2d1cmZ5ZnVHN3VWREg2RFZ4U3JOeDJieXNyVXlvbUpq?=
 =?utf-8?B?L3pTanVnVjROK3BhNHZJdE9hZDNVbnZ1T2p1b0xLRXdmTjVEQzdBTDVjTUYy?=
 =?utf-8?B?WkRtcGhmTnhvN3l1TXdaNi9rQ1EyYXFxU01XdDB5VVlqR0d1TWw2blh2c2Jn?=
 =?utf-8?B?RjhlaGlLSUtveitOaHhHbjZnZHh6L1NxVWh2Lzcxd0V6NStZdTZOYU15MmYy?=
 =?utf-8?B?UnUvY25WWVg3MUJCMG1IU3ZxU1p6K2UzTFNYSHZQcVN5V2F6bmNvSVNOa1Bu?=
 =?utf-8?B?VHBLckM0V25yK3JhTmprNTJ4Q0FhNVRhL1Fucm44TzlZRWJmd3dxcU1sT2h5?=
 =?utf-8?B?SkJBdDZCM1pvcjAzUXA5RWlIL1paVHEyVTZOblZmZi9wS29lSnpYR3VaSmY0?=
 =?utf-8?B?UXRzVWIxRzd0QUxYV0ZkTExFZFpSVXV5VlZBUVFsN2t5NmhVWHN0a2FKbWxK?=
 =?utf-8?B?LzcweDhJUWlzdXdqRG1CQTNWTzRVUzFqdzFnb0hXdnBUSTlGYzlXZGxpeW1Y?=
 =?utf-8?B?M1oxdEhZOWRGKzBnUmZRU1M0S0xHdUhXWWtyNzhrNmhRYVdVTzJOZXArL1NP?=
 =?utf-8?B?TkEySTJjZmtqWFFybkdYT1Ziek42bG10UmZRb2lzckxHRDJpNy9vQVBSS1hB?=
 =?utf-8?B?dkVMZWtSc3RRVlFFMitxRG53Q0xQa0c2a3IzQzgwQkRnMi9KVFgxR3RITmhS?=
 =?utf-8?B?ZXMwZ01sZmY5SjUzdFdETDRuajVMcmZYbUMxZDJzNWcvejQ4VjFFYmpaS1FY?=
 =?utf-8?B?RVpsZVdOYWNwMkRkQWt3UElyQm5CZmJpN0dKV2cvZDlmZnM0TE54T2YwQ1Nw?=
 =?utf-8?B?SHVZYzhXc0lqVTdrbHRCOXlxVHlYWUFaRzNqSnJCMStvNUdaL2hIYnB0Umdw?=
 =?utf-8?B?bHdkV0VFNkpkNUVSTHNqU2VHb0FzWk5UeTZuZWJ2TlkvOEZaaTRZT2RyVVZh?=
 =?utf-8?B?U2xrU3NTZWFncVp2V2NrU1dDNFZwSnNQdE96dGtDYnMzNmxHVExadWhhUTZF?=
 =?utf-8?B?WHNyWEwxNGVHS2ZEUlM3K2IwNkZlNng3TS9JSWNJOXY1WGdkckx2SUZYM2F2?=
 =?utf-8?B?c2lVSlhCb1R5SWtkY3N1b0ZoMmp1MlRKNmF6TjZibGw4RHA5czhEaGZRNm43?=
 =?utf-8?B?a0dSM09NVmFrZGxuYlJ6WlRhQ0cyUFYyNFJpSDUrbEhYSGE3U0FiSEpPZnpp?=
 =?utf-8?B?MS9kcmE1VkJrSkxaTjNtL29hSSs0OVBkR2tLSlhFVmJObmw5YW1SeEJQWDNL?=
 =?utf-8?B?QldkZUV4SWd2L1UrZ0pZekovLzNrNTdBbjk0RnNkbXh5TGpod21OUU1xOSts?=
 =?utf-8?B?TmZVTDl4VGdDSngvL0NyUU82YUx5cVl2aFlQV01OU0lIYTl5RDE2L2tHSHZ0?=
 =?utf-8?B?eHlRMGxiMFpyZDN6UDdJMGJDaWg4eldsWU0xUFNPdG0zZVFMNDZyQVpXU0ZU?=
 =?utf-8?B?RTQ5VDdkU25ZbllXeHVlK2x5OWhubzVEQ01oSzFRbzdnUjkrNis0ZkplTEJs?=
 =?utf-8?B?Z1E1cWtkS0ZRL0NPdHp4S1NuZlRiNEtJTklINU9FdDZHZlk3eDNWOXVQV2t5?=
 =?utf-8?B?ZzNOVnRHZ0VWZ1hsV0t4dGdJUWtXTy9OUGRuNHFTU1Q0UHhmM3VIU1A4Q25L?=
 =?utf-8?B?TnFUUUJpUGlIdmVTQVpyWktjb1dmcmFXYzJCSTZhdHFVTG0wdnptZUE4blg2?=
 =?utf-8?B?ZnFYTTloL0hpbmNCZHJJK3QwZmU1alFkMzRhblAyVmlwL0VaVHpERzNYemV5?=
 =?utf-8?B?SVhVaGE5RnREeVllL04vUitCR0ZoTWtUUWpuRkpFdkRqQ3NmaXZRdEFIL2hL?=
 =?utf-8?B?VW85bkRmcWJHYjcrOXRTMXVoaC9FUFNXei93M2QzSFBJaVkxUWZEWkFDeTNS?=
 =?utf-8?B?WHZHd2VSNzhiS2hBcy9aMU1GZkRUMGpyU1lPYnJkRDVIb3prdFJuL01aSG5Q?=
 =?utf-8?B?VVdnMVlXbUJIZjJ6UktJQWRNQko3S21ydC8yK0owSmJYVjlFRzhtRkErcFFk?=
 =?utf-8?B?YlRmYjVBYVJFUXJTQklmRFc3RENQNGE4UmZrd0VEaXBXOHZPKzR0bkVVbWZ6?=
 =?utf-8?B?YVF1a1lzNDlzTGRKOFRBL0gvRXdhaHBpc1l1eUZEdXNTRWs0dHdxOXBhMHMx?=
 =?utf-8?B?eGtQSWJidDZBN2NBTTNjbEg5SlA1QnlscTVoLzYvT0pVM0cwRmhzUnovbDRU?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 681dba98-4c6a-42ea-047c-08dd52701369
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:05:47.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuNG1HQ3ANr9bznUinTfjelICmHq5tPX7SVbb4Q80BlOjsd1nEOn3z7seokAOMdpkFAqDnN2w7CxETMxgGdhE3AAtY2usADNuGDt8bzO++8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7428
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2025 12:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17875

PiBPbiAxNy4wMi4yNSAxMTowMCwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tIHdyb3Rl
Og0KPiA+IEZyb206IEFsZXhhbmRlciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1l
bnMuY29tPg0KPiA+IA0KPiA+IFVwZGF0ZWFibGUgaW1hZ2VzIGJhc2VkIG9uIGlzYXItY2lwLWNv
cmUgY29tZSB3aXRoIGltbXV0YWJsZSByb290ZnMgDQo+ID4gb3V0IG9mIHRoZSBib3guIER1cmlu
ZyBkZXZlbG9wbWVudCB0aGlzIG9mdGVudGltZXMgY29tZXMgd2l0aCB0aGUgDQo+ID4gcGVuYWx0
eSBvZiBoYXZpbmcgdG8gZWl0aGVyIHJlYnVpbGQgaW1hZ2VzIHdpdGggYWRkaXRpb25hbCBmaWxl
cywgcGFja2FnZXMgYXNvLg0KPiA+IHRvIGFjY29tcGxpc2ggZGV2ZWxvcG1lbnQgYW5kIGRlYnVn
Z2luZyB0YXNrcyBvciBkZXJpdmUgZnJvbSB0aGUgDQo+ID4gcHJvZHVjdGlvbiBpbWFnZSBpbiBh
IHdheSB0aGF0IHNvbWUgZnVuZGFtZW50YWwgZmVhdHVyZXMgbGlrZSB2ZXJpdHksIHNxdWFzaGZz
LCBzd3VwZGF0ZSwgYXNvLg0KPiA+IGFyZSBub3QgcGFydCBvZiBzdWNoLg0KPiA+IA0KPiA+IEJv
dGggY2FzZXMgYXJlIGZhciBmcm9tIG9wdGltYWwuIFdpdGggdGhpcyBwYXRjaCBzZXJpZXMgd2Ug
d2FudCB0byANCj4gPiBzaGFyZSBvdXIgYXR0ZW1wdCB0byBzdHJlYW1saW5lIGRldmVsb3BtZW50
IGJ5IHN0YXlpbmcgYXMgY2xvc2UgYXMgDQo+ID4gcG9zc2libGUgdG8gb3VyIHByb2R1Y3Rpb24g
aW1hZ2UgYnkgb3ZlcmxheWluZyB0aGUgc3F1YXNoZnMgb3IgZXJvZnMgDQo+ID4gYmFzZWQgcm8g
ZmlsZXN5c3RlbSB3aXRoIGFuIG92ZXJsYXkuIFRvIG1ha2UgY2hhbmdlcyByZWR1bmRhbnQgYWNj
cm9zcyANCj4gPiByZWJvb3RzLCB3ZSBkZWNpZGVkIHRvIHVzZSBhIHBlcnNpc3RlbnQgc3RvcmFn
ZSBvcHRpb24gaW4gZmF2b3VyIG9mIGEgdG1wZnMgYmFzZWQgYXBwcm9hY2guDQo+ID4gKEFsdGhv
dWdoLCB0ZWNobmljYWxseSB0aGVyZSBpcyBubyBsaW1pdGF0aW9uIG9uIGRvaW5nIHNvKQ0KPiA+
IA0KPiA+IEtlZXAgaW4gbWluZCwgc3VwcG9ydCBmb3IgdGhlIHJvb3Qgb3ZlcmxheSBpcyB0aG91
Z2h0IGFzIGEgZGV2ZWxvcG1lbnQgDQo+ID4gZmVhdHVyZSEgVGh1cywgaXQgaXMgbm90IHRob3Vn
aHQgZm9yIHByb2R1Y3Rpb24sIGFzIGl0IGludmFsaWRhdGVzIA0KPiA+IG1hbnkgb2YgdGhlIHBy
b3BlcnRpZXMgd2UgaGF2ZSBmcm9tIHJvLWZpbGVzeXN0ZW1zLiBBbHNvLCBrZWVwIGluIG1pbmQg
DQo+ID4gdGhhdCBjaGFuZ2VzIG9uIHRoZSBvdmVybGF5IG1heSBwYXJ0aWFsbHkgaGlkZSB1cGRh
dGVzIG9yIGxlYWQgdG8gInVuZXhwZWN0ZWQiDQo+ID4gcmVzdWx0cyBhZnRlciBhcHBseWluZyB1
cGRhdGVzLg0KPiA+IA0KPiA+IEFsZXhhbmRlciBIZWluaXNjaCAoMyk6DQo+ID4gICBSZW1vdmVk
ICJybyIgb3B0aW9uIGZyb20gcmVhZC1vbmx5LXJvb3RmcydzIGZzdGFiLg0KPiA+ICAgRml4IHJl
dHVybiB2YWx1ZSBoYW5kbGluZyBvbiBmaWxlc3lzdGVtIGNoZWNrDQo+ID4gICBBZGRlZCBzdXBw
b3J0IGZvciByb290ZnMtb3ZlcmxheS4NCj4gPiANCj4gPiAgY2xhc3Nlcy9yZWFkLW9ubHktcm9v
dGZzLmJiY2xhc3MgICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiAgLi4uL2ZpbGVzL2xvY2FsLWJv
dHRvbS50bXBsICAgICAgICAgICAgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKy0tLQ0KPiA+
ICAuLi4vaW5pdHJhbWZzLW92ZXJsYXktaG9va18wLjMuYmIgICAgICAgICAgICAgfCAgMiArLQ0K
PiA+ICAzIGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiANCj4gVGhhbmtzLCBhbHJlYWR5IGFwcGxpZWQgcGF0Y2hlcyAxIGFuZCAyLiAzIGlz
IHN0aWxsIHVuZGVyIHJldmlldyBhbmQgd2lsbCBuZWVkIGF0IGxlYXN0IHNvbWUgcmV3b3JkaW5n
Lg0KDQpVbmZvcnR1bmF0ZWx5LCB3ZSBpZGVudGlmaWVkIHNvbWUgaXNzdWVzIHdpdGggDQo+PiBS
ZW1vdmVkICJybyIgb3B0aW9uIGZyb20gcmVhZC1vbmx5LXJvb3RmcydzIGZzdGFiLiA8PA0KaW4g
YSBkb3duc3RyZWFtIGxheWVyISAtIHdpbGwgc2hhcmUgb3VyIG9ic2VydmF0aW9ucyBpbiB0aGUg
b3RoZXIgdGhyZWFkLg0KDQpTcnkNCg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFH
LCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg==

