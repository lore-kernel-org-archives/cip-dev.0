Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F0C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 12:01:00 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.215.67])
 by mx.groups.io with SMTP id smtpd.web11.13444.1721304055973906916
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 05:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=U+FHcONo;
 spf=pass (domain: siemens.com, ip: 40.107.215.67, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbjOI17iJMm4XLsTNPIaR3G78MiB5XjILERk1q7tRJFdQbq4QqjMwohjAolxzq3N7ACIwxaI53en0attXOf/4KMMJajlw9mQnRUihKUAsMhbmYxOEswAB0N0b9evp9qDzw7NiY5TzVta/AooeTfQ9FY1Z0bLT0F0OpBTjLyMCDqSr7BRKOHBP/ehlW04p9cxFnEy8f6uKpM/7aNGZgErPC3jbeZDSxqcUArD6CMnwTYtIvEDmM3UICpo6WAJw8vTr4FQ38JxVThBmwnP6qvzACZg7n16R53pYLMHzCoUk1M8wkPfPfd+UjJTyvEwR65n9cj7IfSMB62NyGt8f+Sljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRRbHQ3KrnDjMV0ny2vnhcKncJlK+1tbHl2OrCN4djY=;
 b=gZkUtRVMwW98qjl+GulKYPFIiHrJsXZX9SYXVIrcmjavliMR1t6m9qKgHl1fgVzly/vwpWnm7x/15NjlwZZ3QdRkV50h2P6QDaP3SVObKfun6LiueHHhH8f/i96AY5lhH4IDiiodgHDzCE09rueEY2tlaQvOGGXaUpnhMLVNG8GR0AnqvgklenmrmhPpmP2nONty1c3DNRQ7GB8UIOV2KM0uUWw8kwe21AlV4o8p993S46YZqGaQ2Mfh1b1OM1GWBP/IewGOBbTIm2EbgOV1ByjqQwEnpqAAQTsVQB9ItDaOfixtJ0KDebqfTcVaayruEaIzjl3lxiOKpGWUPwb29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRRbHQ3KrnDjMV0ny2vnhcKncJlK+1tbHl2OrCN4djY=;
 b=U+FHcONoprHYQIuDMuee7c40LroOIXsDpQvb+8ePkMYoYp8uCQXxTpVoqet8NdFcO3p4uGwu9ukFVBs7z4KcvOa2YNUyJ7KwgfaiiT/Ejgc/+Zz8EdEyikHEjHZM7YjPZ0ZmPphahWeplbSmy+JVQax8S8st09+8b3yKfXfCnvEi0SPzwgFgQXj/UvhxJEC1yxcOKur0TmA3p19EpwhWQxb5zhF10ArF8ksjExQgdYFmmGLiwuSpzu9idDivqZJGBSisTk0Cec1nnCLHw6HM3cZsDGCg0rGy6wb+1Cw0qcUZcMJsf4Z3lT+HW0mC3YiS4uEniVgZR0pk0cM/jX4aYQ==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by PUZPR06MB5825.apcprd06.prod.outlook.com (2603:1096:301:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 12:00:50 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 12:00:50 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir during
 squshfs image creation
Thread-Topic: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir
 during squshfs image creation
Thread-Index: AQHa2QFQCCQbzuqNmU6hcjMqNGVQALH8WbWAgAAIS+A=
Date: Thu, 18 Jul 2024 12:00:49 +0000
Message-ID: 
 <PUZPR06MB57478202F05E16E67FEB0EF188AC2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240718105718.11562-1-srinuvasan.a@siemens.com>
 <a3d45b99-702e-4ecd-910e-4dc1f3ae6301@siemens.com>
In-Reply-To: <a3d45b99-702e-4ecd-910e-4dc1f3ae6301@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-18T12:00:48Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d404d13e-6e12-4539-9650-b9a445f25623;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|PUZPR06MB5825:EE_
x-ms-office365-filtering-correlation-id: 8a0829f3-26ee-4e39-7dc4-08dca7214437
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?S20xNXM1aVpBMXVxdy94OVJHb2JGUFd4VGV6UWRtbEJZeXA2WmtZQUdjQ2k5?=
 =?utf-8?B?UGpqYkY5ZHpMYmQxYXRCZ25TUXZ6Z1BhZWR0MVplVHFjWGluS29xekc2aHhn?=
 =?utf-8?B?ekNEaUFVTGpJTy9SQnY4OVVkY2paQ1IzUTlYRFJPdUliVThuVDRvdlgrS09Z?=
 =?utf-8?B?cFhMdGFWSU0vOGJ2amxLemdMTkZVNUJudSt4Z2g5czRnVWZCTnZjdHlWRzE1?=
 =?utf-8?B?RWg0QWFZNkFlOHd4R3hYZ3NBZVNhN0grMFJoTnp4YXZpUDRRZWhIT3ltTjRU?=
 =?utf-8?B?QmFpMUZOL1Z2VXBxS1B3TjQvMDdaNUVhbjBaaGFGZlhFTWp4eCs4Q1hxVGV1?=
 =?utf-8?B?c3EwbnE5Y24yWmtROVBGMW5lOE1pQ2pTMzdtTkE0SmU1OGVRRU9ndlE3TmVD?=
 =?utf-8?B?eGI4R0wwSVU1a21UOFpXOG9iSWwvUFJsMVZmdTIyMllzeTBGalVTTzJXWWVx?=
 =?utf-8?B?dVpDTzI3VlBVOFJhUTNCVjczaE9ianZXam9xKzI0VDRZVGpBSVFxNnJVOTVX?=
 =?utf-8?B?T3pPeWtRdFFvRmhQNS8ydjZEYkpxanNDMCtTOXlBbzlib21YY2drR2hZUjQy?=
 =?utf-8?B?Z3FhTHEycDRaOUpsZk83M1RIUzZsUHdqQllDdjBvZks3WmorSGpzR0N1UWtB?=
 =?utf-8?B?anhmWm5YRmVHb0o0VFFjY3VVekRqYkh3SnN4eEpveThOSWlxeTVVZ3k0QXJG?=
 =?utf-8?B?UG5YaENBVm1DaStCM2lCWUtmdjltRmE0aEs1ZXl3MEQ0NDJUaWxTUFBCbWE5?=
 =?utf-8?B?Z1Z4d2diTmtKWGpESTdoMk8xY085SVo5Yy8zZTVINWwzck1LcFQ4dVNJL3p6?=
 =?utf-8?B?OGwzenRFUENYb3JsR0J5MUNtcURIb3FrdU9CQ2xPTzNCVXRqaXdkMTRpZFNu?=
 =?utf-8?B?Yitrc0NmbnlBWWxjRFpFMWkzcTlvMzV4YVpLdnd0NFJzNWJ2SjNqUWNoNCt3?=
 =?utf-8?B?dEhvZ3MvTFNtWXY1cDVCUkcrMUFILzAwKy92bTRPK3FQclpYOCtZTVNjUUh4?=
 =?utf-8?B?WWpvVWRQQ1hrZVdGNCs3QzNmT2kxbTBtMldXRnZPbGZOQzB6Y0hyNEdZUWcz?=
 =?utf-8?B?VVdWNWk5WGVYMktGOEliYVdjVklpUGtkUHN1V3Y5ZmFacWtsV1BPR3pJZ1hF?=
 =?utf-8?B?cWJlNFRlbnZTV1ViZUc5Rm41K2ZveHNROEVwcGtnWDNqM3FMdDh4bGRVazRL?=
 =?utf-8?B?STRYbTcwMDBOakpSaHh4cEo4dVQySjdXaDZsRHhmZU5uRk9ucCt2Wkp0d3Jo?=
 =?utf-8?B?QmJ0VDJxVUJkak90WGNlVkZ1bm03ckoySEFqY0FoUEdXU1JGOVFFVGdnMjRz?=
 =?utf-8?B?dWlPS1BNT21mVmo1QXM0L0hGcU9DNExHcXpDQnV2OVpZeEpaRVFUZHNvVFlB?=
 =?utf-8?B?VmFIY0EwWWd1QmZaUHpnWW1tOG8ySDczS3NvNlNmeEdYYkpsUUVqTGVGUHRL?=
 =?utf-8?B?VXVhUHhOTWl3ZHlHenRSdllmR1lFMVZ6MFFSTWFFMC9GaCtVTXltRHpMZVZp?=
 =?utf-8?B?emkvSVR6eW9odXAyRm5qQjBScVZZUlB6bGEzZ3g1aUdrdm0wb0pXZURqeENV?=
 =?utf-8?B?NktLMEhBamlXQTFrdTY4bUJ6TEh4TVVmVDU3V1FMbDFXZWZHR0NXUE1LQVFp?=
 =?utf-8?B?MHJRYXJGYWM0ZldicDNqRWNHQjROV1JxMk9BSHJ4VytJRnRlWVVKcW9sWmkr?=
 =?utf-8?B?RkRsNG5hQ2RMeWw2V2lHU2NZUnhHMktRSXRHWDduM292TFlibFFqWjZhR1Rh?=
 =?utf-8?B?dFVTaGpQT1d5d3dWZ29MWXpOVXp6L3dMeU9leldJM04ySzhURnViMzdqTG90?=
 =?utf-8?B?Nm9aQTNpNGxTeUU3MXBZVDJvYzg0d0grREk1K3l4SGhyeGlONWhMRXhWNEFZ?=
 =?utf-8?B?TEZ5Tlg3aUttVmpNZW12dVBmMUR3Wkh6emwxVHJkR2FBUnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkNUdGgwREJnaHBSVWlCQVhvand0dmgxV0hKTThBd1k5NjR5QUUydkgya1Bv?=
 =?utf-8?B?amFPT3lldU9OWmgzTmFLUzN4MWVnM1c2SjRLWjNMQzRYRXU5SnByRHh6ZVN6?=
 =?utf-8?B?ckxSVmNiQk94V2R2RnlBNnM2bE5ucDR5SERuQm5DSm82N0NCM3NlQy9GVlpR?=
 =?utf-8?B?S0ZsM0RoNTg3T1VLdlpkQVJ1cnh5bk9NRnNjN1A1QTY1cXM5UCtabG11ZmhS?=
 =?utf-8?B?bzREdnhsQUZqUDdqb3FRT3pvRkJoK2FrV1RUYTkyS3dFK3JNb1dNZlZ5NkNR?=
 =?utf-8?B?UVdRUlZXUktJWkpyb1NHZ01lN24wYkJRck50UkNEYmcrbTZnTTNJL3JwYUYx?=
 =?utf-8?B?d21CZDIvb1d1SGRxOGVpZWQ2WHhVNHlpSEJYOGI1cG9Yb1VRZVMxd1pKL2Jh?=
 =?utf-8?B?NEFzZGgxeVJ4NzNHNEluazJVQmdMY1g1RFNEWVcwRlAxc21DdkpSa0pDUFg5?=
 =?utf-8?B?Z0tuakZuME5RNmxTYVVXeXI5dXEvdTFhQUF6Rnc4SkZWdkhCN2xnc2N3SUZ0?=
 =?utf-8?B?WjJ2NzBLcnl0d2RpLzY1N2E0S2xJbUxPdmhMTW00SU5CWHNudGtDbjJoeGlt?=
 =?utf-8?B?b3RHdGtRWVRSaFhrY3ZuRVZuL2FHUWdaazIySVdaUVc4YmFDUG8wY21XOWZP?=
 =?utf-8?B?b296TU5Rbk1rVWNNQ21RRGQwWk52cWJ1MXBFYVdkdXllcm1zMzhOdmgvTVFS?=
 =?utf-8?B?Y3ljdFI3UFB5d1M0VHM5dGduSVhrekp0Y2tqR0pmcjI2Sjc1dGFGU3VIZnpT?=
 =?utf-8?B?WUFUMU9LeHVYcHppZGhOWkFremRzVmJqdndueU9PeU4rSmdvV2dOQ2s5ZmVG?=
 =?utf-8?B?NC9ENjcvWlpoS1FVZjBjNCt3ZWNKdmkySXl4MzZRM2RhRWR1cVZ1VVJOUWY1?=
 =?utf-8?B?bDdOSllNbGl6SGZBNm5CMGRycVlZMlBUTWVFbzFtaC9ZNXdJRjZoVVBEeSta?=
 =?utf-8?B?SjArelA1OCtTVktYMW0xVlEybXJkWjZKZmZsMVBEZk1sK0RaNmpmdkZrWUx4?=
 =?utf-8?B?cHVOcTVZejVVN0ZwbHJYSWtzai9XcllwNjNjUWk3d1poMGFNMlBiK2NrL2hJ?=
 =?utf-8?B?RXl3WGtHZjcrQk84SDZ1UlJaTGhpSEZielRFcmVkTzhzTlhnN3F1a2lQVlRq?=
 =?utf-8?B?QjRUY21JZytFUURFQU5TU3lWazI1dFc3VWJISFpoY2ZHZ2dzU0dlYktxaFRl?=
 =?utf-8?B?SWFQdE8vZEhzdk1MV1NFMVdVdk16bDJqd0FUVDBlV3k1c0xQZXJNVHJUMFZz?=
 =?utf-8?B?ajdxaTFLeHRRQkN0amkweDY0YkhFMEFPZVFPdkVlc0pzZmlUTWFvSWROUmVU?=
 =?utf-8?B?bCtOTVlpd3ZPRlRkYVd4OEthOVpZenEyR2xOQVU1bmt3YlBsVGZOUmxteVJj?=
 =?utf-8?B?K3F2Y3JvVmUzZThMMWdwR1lyYWQyWEhweWN1NkJ1dWVpUlhkb1ZCZEU0R25O?=
 =?utf-8?B?SnBUREZtTks5WjRxM0Z5c3Z0VUYzTFNNaExzNTJkbWlGZ1pCckVTWExYS1lN?=
 =?utf-8?B?Y0M2M3FNN3o4NzhqRE4yb25XbEx3Vk4raUlDak9VelJpMFh4dk1ZRU5Xb1Ir?=
 =?utf-8?B?UkN4Z1VUUEJtem5TMWh5NHFtUHNIZnRONUFneXA2d3BKanFTME9Uc0t0QWNs?=
 =?utf-8?B?b1RsWlpiVTcvMGQ2bTYwZnhOVEhrZzZ3bWNFS0Z4T0FHYWt4WU83bEZjZitk?=
 =?utf-8?B?MXBiNkhuamZUbVdIT3BkNDdTZDk4YklTSlBBLzR1SUhBeEQ5dUVTOXluMW9W?=
 =?utf-8?B?aEJTbGNuUllYM3hWRGM3NHQ4YjZPZGlJQkJxTUEyN3FCMkh1Q0FLQjNzSTcv?=
 =?utf-8?B?RHN1blNQQWs1TWNpbDM0QUhjMHFOZzFwSTNCWitRL01XcTJhSVJDQWwyNC81?=
 =?utf-8?B?MlgySmVoQXFaVWlvT0E5bFlSUWkxMzcwSjcrT3VuWUJ5WWZNbGhOMUNINTlZ?=
 =?utf-8?B?STlpZm04ZXRYN3FSTG9JT2V4NjVYaDZCSHAwZG8rR3V1VnVRQ0ljSEVMUDdN?=
 =?utf-8?B?dmsvdHo5ZTBvRFdQcDZBbkIwR2l1RUF0M2xuZlRRTFRJZDArTVk0NHpWZWtv?=
 =?utf-8?B?NDdxSXNZdkM3bVZvTVVaSFMvLzdnaUZGSXMzK0hpZ3kyVnV1RWRreUg0TWlt?=
 =?utf-8?Q?XEyn9sZuFWrIKBuR1aNb0mEo/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0829f3-26ee-4e39-7dc4-08dca7214437
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 12:00:49.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic7ek/BbylMaMIdRLjw2KhQvel4R6346b+EUDxi5xHAAn3Zz0O6fJe4KNjf/tv65mFqn51lackrez7eYA8C6nv8Qj8j8wQcbHkzMf4zdwUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5825
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 12:01:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16589

WWVzLCBpdCBpcyB2YWxpZCBwb2ludCAsIEkgd2lsbCBjb21lIHVwIHdpdGggdGhlIGNoYW5nZXMg
aW4gVjIuDQoNClRoYW5rcywNClNyaW51DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBLaXN6a2EsIEphbiAoVCBDRUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6
IDE4IEp1bHkgMjAyNCAxNzowMA0KVG86IEFyanVuYW4sIFNyaW51IChESSBDVE8gRkRTIENFUyBM
WCBQQlUgMikgPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdIFtQQVRDSF0gY2xhc3Nlcy9z
cXVhc2hmczogZXhjbHVkZSBib290IGRpciBkdXJpbmcgc3F1c2hmcyBpbWFnZSBjcmVhdGlvbg0K
DQpPbiAxOC4wNy4yNCAxMjo1Nywgc3JpbnV2YXNhbi5hQHNpZW1lbnMuY29tIHdyb3RlOg0KPiBG
cm9tOiBTcmludXZhc2FuIEEgPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT4NCj4gDQo+IEZvciBh
bGwgdGhlIFVFRkkgYmFzZWQgYnNwcyB3ZSB1c2VkIGJvb3Rsb2FkZXIgYXMgZWZpIGJvb3RndWFy
ZCwgdGhpcyANCj4gbGludXguZWZpIGNvbnRhaW5zIG5lY2Vzc2FyeSBib290IGZpbGVzIHRvIGJv
b3QgdGhlIHN5c3RlbSwgaGVuY2UgDQo+IHJlbW92ZSB0aGUgYm9vdCBjb250ZW50IGZyb20gc3F1
YXNoIHJvb3QgZmlsZXN5c3RlbS4NCj4gDQoNCkkgY2FuIHVuZGVyc3RhbmQgdGhlIGdvYWwsIGJ1
dCB0aGUgc3F1YXNoZnMgY2xhc3MgaXMgbm90IGxvZ2ljYWxseSBjb3VwbGVkIHdpdGggVUVGSSBi
b290aW5nLiBJIHN1c3BlY3Qgd2UgbmVlZCBhIGJldHRlciBwbGFjZSB0byBhZGQgImJvbyINCnRv
IFNRVUFTSEZTX0VYQ0xVREVfRElSUywgYSBwbGFjZSB3aGVyZSBpdCBpcyBjbGVhciB3aGF0IHRo
ZSBjbGFzcyBpcyBwYWNrYWdpbmcuDQoNCkphbg0KDQo+IFNpZ25lZC1vZmYtYnk6IFNyaW51dmFz
YW4gQSA8c3JpbnV2YXNhbi5hQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gIGNsYXNzZXMvc3F1YXNo
ZnMuYmJjbGFzcyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcyBi
L2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcyBpbmRleCANCj4gYjM5YmUwYy4uZjljN2JmNCAxMDA2
NDQNCj4gLS0tIGEvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+ICsrKyBiL2NsYXNzZXMvc3F1
YXNoZnMuYmJjbGFzcw0KPiBAQCAtMjIsNyArMjIsNyBAQCBkZWYgZ2V0X2ZyZWVfbWVtKCk6DQo+
ICANCj4gIElNQUdFUl9JTlNUQUxMOnNxdWFzaGZzICs9ICJzcXVhc2hmcy10b29scyINCj4gIA0K
PiAtU1FVQVNIRlNfRVhDTFVERV9ESVJTID89ICIiDQo+ICtTUVVBU0hGU19FWENMVURFX0RJUlMg
Pz0gImJvb3QiDQo+ICBTUVVBU0hGU19DT05URU5UID89ICIke1BQX1JPT1RGU30iDQo+ICBTUVVB
U0hGU19DUkVBVElPTl9BUkdTID89ICIiDQo+ICANCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xv
Z3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0K

