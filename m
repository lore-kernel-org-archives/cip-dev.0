Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCCBD5C0E5
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 15:11:05 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.41])
 by mx.groups.io with SMTP id smtpd.web10.14723.1731078662870827909
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 07:11:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=von7Lky7;
 spf=pass (domain: siemens.com, ip: 40.107.247.41, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5Lz8Gpf18A+31PtoT9KDiE6RlGE7qfQyuKRSA7Eqn+sLk5HnyY5e+1cwdbbPAeReUUBW82Y2nuVA6mG7lB0FvmmNyj4wZAmwrulwaPdzRg3vcKx9IJHHz7SD1057Aiy85LvyYDa1NOj3i+pPQRyMmpBaVNg/+5mC0BLUNRAy5b3DRQMLoa78rF4dni5o2A0SALHqjouRNC+kOo8mMOx9eJmfktwKUUJPrj+ZaZbpag18Dm/tYp2qVU0qX4biYUsXTsiLExi0t+byegfdGm7bIvikyYdOCpuu/ZZoiSdDieoCo8IPZtmEFpGlX2HDHKkz7gVQJbgobfFxqUPCQlwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2LK/jlL1RLryG1/UT5UjRxyyKDZLILrkPP03j1SwJM=;
 b=yj01XwwxcOczasRrjGZvmafGHW8EUv6GkYNCDwzbsWmUjZeodE9YTMnV3o/lQMaIVeS0pRLG9SMMKL6dWB4piDPFWlVJoAW5aefMX6b64f32utzQ5gXL117lrd6BQv+MkvgcJNZXrMQTiZYtMkxdjMe7zcfbsfupDXYI9Ews4oHqNFUk1du/hQjBrPIMbIlX9I0o68YY0OBgTp1BxknTA816Wt037Tnl3kpnS0Syt7sceiurwWzqur19TMehv8NBPZejvyXwR+iGhSqcsU4Zx11MVWy9fDtTKzku87CAM7iVH/DdhUhA2dQgFnxcq2Lbz/pe8KEZzO1u8H/O5YhEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LK/jlL1RLryG1/UT5UjRxyyKDZLILrkPP03j1SwJM=;
 b=von7Lky7eKCx9EjAsiPgLiSjTOcGMjC8jp3btB2GBHoyPe/mF8NVL8Y+ddDIN+L6My9zYVzQtCxaKuxIGowhrEu7HhT805ZrAw5zkdJoGg6IEE3zPmlo2cAdp3YZHcj5ie0GorJnO72bhYn3iDfvUn26GnoBuVZU78KFQ9k5uKOsdMrSHMgvILLGAQ5zLqkrr8cg7EXzugl4xOSJywB/J3VVY4ufMqiofnMU8DoHodiiqUFEZaTvqc7DydUDgvY2cXofdnTtpbTPG+QZYyQeC+JXd7wkMzqUQDzLIERRv1MtCN410eyE3A/SNdCAIKPXi5J0/aWkgse5jz2CrbK5fg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by GV2PR10MB7462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 15:10:58 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 15:10:58 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Index: 
 AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hCAFHuKAIABX72ggAFi9ICAAC5OgIAACXAAgAABKgCAAAEnUA==
Date: Fri, 8 Nov 2024 15:10:58 +0000
Message-ID: 
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
 <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
In-Reply-To: <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=758691e9-77c2-4e54-882e-a33ff4ed4d94;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-08T15:10:18Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|GV2PR10MB7462:EE_
x-ms-office365-filtering-correlation-id: 9eea509b-6cff-45ce-8fa0-08dd00078cd8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V3lueVhWTVYwcWkvWGtuN0VDbTRxWEptemtqQi9UVFRvdVFWNnNxd28ydU9k?=
 =?utf-8?B?bXdYTUQ3OWRjdklZWXNETXVtT0UwazFITXp0eDNoYUp6eHVNMWt6STQ5OHZw?=
 =?utf-8?B?Ym04dml5V3ZLejdJZzZhdkhMSnlVamRENUZiSno1SDBHaFArMW5qcjJlNGxs?=
 =?utf-8?B?cGtnOXR1RlpuUkFmZ0NvVnhQeG5pVjRnV0xwYk9JR1paMUhwNG51MklDM1lX?=
 =?utf-8?B?S3RkU1ZIY0R0TklUblZNUkh4Q2lCMHFWaS8ybHRPclB6c2dtV0pFTXJHelg2?=
 =?utf-8?B?ZWpPd3hmR0pLSkcrSXgvZEZWdHlQVEE3bm1ZM0JYcFpuYzNMWk9WZmJ3Q2NL?=
 =?utf-8?B?bU9tS0QvNEdISHJ0R0duUE5xZkk1R3ZweWlUY0NnckVrdE1EMEhhelNHOEox?=
 =?utf-8?B?cHhwWUtaNTVFcTBsWG4vWTh3U1VqTGhsM2VWVks0eWoxb1JjNzAxUUFsQ2Nt?=
 =?utf-8?B?OW9mYWFxOTc2Y2NDTG5UemphNWNDY0trLzlvcVVlMHlJazRRWXNDMkVuYmYy?=
 =?utf-8?B?T0ZzNHJ3SjZyZ0t3K2gySlFoV0l6QnM2bGFIQlNoOStNanl0akVWNkJ3b3Fk?=
 =?utf-8?B?ZkFoZHBuVk82VlVNeXV4cnU3ZEQ1MkJIYU1CdFZCQmdjWUJaMThPSXBkeWNB?=
 =?utf-8?B?RllQeDBRZ2R6S1o1WXZtdGFnV3hvWmFCdFMrNnRVeG9acDE4UjhpdHVYelpy?=
 =?utf-8?B?R2Rkb0E0eUdnSHhFeWlmOWlNREQ1THBrWGY0MzM1clY2NmhaT1QweEE3SHU5?=
 =?utf-8?B?WGZFU1VGcGYwdzIrQURFWjZ1UHpGWkROWjFsV1lFMXcyRHJObHFIVnZIaTdV?=
 =?utf-8?B?V1BrMEpDZjhvNWk4MTRpRnhzc2NBdEEzVXROM2RRNW9MQzdMYlNLOHpaK0ZR?=
 =?utf-8?B?WWdIdDBuT1dVQkZML3BuWXJpcWd0SlhWWHN2YmxKbmZodG5qcnc3d1pDczVm?=
 =?utf-8?B?a21BckdJdWlvd1lLdnpjeUEyZEwwa24xQlQxcTd3MW95TnBHaGVNWGJmUjlv?=
 =?utf-8?B?SFV3Tm9GNmU5MVg2a04wWHpINy9IRkNDOVhCbUNsTUx3c2lUdnZLWE5YeWxk?=
 =?utf-8?B?aTgyWDdkbDNiS1ZGYzNpSkpPWDkyZW0zVEtIZk81OFFaRmxGWk1XR3lmSEZo?=
 =?utf-8?B?aCtaZitGNGVIYTlBOGdmVzBGTXR0cEVmeG51WlF5SC9FY1p0VXlGcEFUZEc4?=
 =?utf-8?B?eTROckNPbGtNTFkwMitXa2EwS3hCbElzanZHRyswbGV0eVcyMEdGcWg1SnVY?=
 =?utf-8?B?bmxBZ08wTzVJOXhWUkFtNW1hWlF6ZnQ2eE1QaEdIRDR3N01XdXIzWkZwYkFq?=
 =?utf-8?B?ZTIzRmhkU2RybXFTSXV4YjFSV1ZYTXArUnU1QWxiTTRDVi9JMHYzYTBSaWgz?=
 =?utf-8?B?cHB5dUJxOWU1KzZKZ0dNNWR3eVRFQjdQaEZRZ3RLZ1ROVVZZM291eS9sSHp0?=
 =?utf-8?B?YWhPNjZuUkt1U09XbFMxbUZyNjMyS2tyMlBiSEI5WHlqc25uV1lQNWNOMWtZ?=
 =?utf-8?B?VzNLOXJ1SHZZQlkwaFFMQU5pdWhCZU0vUWdNTTNqTktzcXFXd3Fra01YSGx3?=
 =?utf-8?B?bFV0RGRZZjlnSXphZ0FnQ2Q1c0JwOGxWWGZldm1ZSXFidWRXSjcvQjcwdWpr?=
 =?utf-8?B?RGVQaU1CMXpyR040dlczUE04SW9kdkgrTitKQWpzd0pZN2V5TU5wbk40cG9h?=
 =?utf-8?B?VXpxNTJpM2FSMU5wUjZlWGhpWUYwWXUyUUZmaUVIamFKRHJHTVh5blZEQVpt?=
 =?utf-8?B?c2x0RDFGTURqcjlYdDJpQ3k2cEhsU2hyS05mWGEzRXJVcTUzeitXdVphVHpn?=
 =?utf-8?Q?VKnBwLIslIFgLi+D8KpwC87k1kUBvlAX7k6cw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cVViaExaMllKc2creW1uV0FYMzRzbEpqMldrUytGWVNoVEhMYkUvd295WnU4?=
 =?utf-8?B?K2l5MHhKUERYdWNXNDZESTEzZHV5UnNXRTVXY1IrN0k4cHdERzdkbDFib0Zn?=
 =?utf-8?B?TFpndzR1K05abG5jU1NmQUNKdEVWWmh5TktnVXJDWk1pN29yMlVkQ2gyTnli?=
 =?utf-8?B?bmN1cVlJTkd2Q1VyTWg1VVRCZEoydTcyQk4rN2lLMHBFemx0ZlB0MlhTU2J2?=
 =?utf-8?B?dGtpdjJRSVRJTkNxSmYzekhFdUxpY2crZ0RaVENFL0pQZms0SXlMb0hSU3Yr?=
 =?utf-8?B?YitYaFpLWlZoQkFCaW9BR2I1QmIvV2RSYzJKb2Y2Wmk4eGV0S1NMbUZjUWQ5?=
 =?utf-8?B?cDBTN2FmOGhSQm1VZEc1UUZ4aDkzNlE2b0Nkb0FtNnFhMkR0K1hJWHRnZWtM?=
 =?utf-8?B?WE51TTBqRSsvY2ZMZ0gxTk1VQTdBVjg0alZCOXlQT3FlbmpxcVBWTUhObmxL?=
 =?utf-8?B?b1Fwc1hOaVk3SUVtWmRSK3l0b0JLOC9iTjcrbTlMWXNIMDFYRzkvcjJpWkwv?=
 =?utf-8?B?TDhhcEMyS3JiM3VTNUovUVJZdTIxWVlPMHlMZHN0RUhZcWhEck9HSm5aZHAz?=
 =?utf-8?B?bHUzYk9aZ1d6aVZkQXM4LzdTQTZ5N3dINW5XMmozWmFXOFNOZWRKdWsrcWp2?=
 =?utf-8?B?eTRMOFR3djBuTlZMT3BidDhpdGtFbjNyUkFSbmlVUDVvMUNYN010OFlORlJ2?=
 =?utf-8?B?RnpjUUZ0RjFDN3poa1g0VEJweDZLTDRtUWhyRVJsaWkvRjFVOFdQMDhlN3Bw?=
 =?utf-8?B?d1Q5VFhoR1Z0amxmdWpKVjBSbE5JbVYzV0YzVmd4RnRBZGs4ZXpYSHhZNlFr?=
 =?utf-8?B?YTBNVDZENE55MWdRRWNIVU5LZ0x6MTRVaGVHTksyd1dZc3ZmVE5neEpFL3ZC?=
 =?utf-8?B?UGRUR1VJTGVBdmtIZHdoTjh3dVJPWHVsWDNVUXRXQkZZVnNDcG9Rb0VUWEYw?=
 =?utf-8?B?cUNaV2xPUzlRQ2NDZm44MnhGeUhJNDFhSGtLN0Z5cisyM08wTG1nQTVJcHUy?=
 =?utf-8?B?VllzS3Y4TExSdHFkVi9TR0oyOGZnQVYyejhnM2YzbEcvN094RzdiRXBhbTVi?=
 =?utf-8?B?QXpLOVNXNVo0YXdiNmNvc01rcVJ0RTV0cDBsajRsb0p4Yk5rS3lGbHpsTkZV?=
 =?utf-8?B?c2V3My9UUVpXSStGRzEwa2l5OXJXcEVWU3pXclUvN1ppVUJMZTJRS1JFT203?=
 =?utf-8?B?M1V6N0hwWG4xVW5NaDlzUFFocDl0eTU1OVAwU24zZmlHMHVtSmdGMGdIaEl3?=
 =?utf-8?B?YzRscmZaUW9OR21BSml6SWdDSTJzTXhTakNxZzZwWDVRWVo3TlNOOUV3N2g0?=
 =?utf-8?B?QjJoMWYrVG5YT1cxQTJ5OXdLV2JBTXhXLzlJZ2ttUXBpR3VxME04UXZSWlJL?=
 =?utf-8?B?OUE2RWNYS3Nvc01DcFEvT1BZL2dhVVF3eTlWeFFqUis0eG9GTFZGQUlwL1p1?=
 =?utf-8?B?N0ZHSzRIZVJIQ2pJQjUzeEhaTitjckdMNzdMNUljYVdIdXNuaHpGdUJPZHlG?=
 =?utf-8?B?U3RyS2tIc0FRODlvdkRGL2UzODhMTUs1SUNqcDBDOUhEcnJ3QVpqdWE4ckI2?=
 =?utf-8?B?VDRlOC8rZG9xeGxwcG9Xb0kwcjJUZnR0RUhQYk1mcWR4WU5LdmRsVHFlbUUx?=
 =?utf-8?B?VHFZdTgyOGUrdlhIa3poYzFqZzdHVDQ3QnF5RVhZYk8yT0I2T2ZLQ1p3cHVC?=
 =?utf-8?B?OG9vaFhtRTJsRGN3Skg5aVJhMFlYaGlEQSszSE5vSlg1QXhFd3NGQ1IxMzU3?=
 =?utf-8?B?QkJuVXhhRVNMcmhuUit2STZOclIxc0ErZVJWN2RYTlJjQm9KZ1JPY1ZFTTRj?=
 =?utf-8?B?TGxjZUt2SlZqZ3pFSSszZzh5R0RxY3huZ0x6emErZFgzaGtkeWxVZ2oyMG9G?=
 =?utf-8?B?cHNLQ0wweXdzN2F6R1E2Zzlqa3pmamFWVWRRYk9WNllDNW9sZVFnOU9TVHp6?=
 =?utf-8?B?TUQxK0gvT0pKbkViTTBJUEJiYTVtK2xMVmFTclF4WEFPL3RWT0ZBd3BxYTFJ?=
 =?utf-8?B?NjV1Mzd6UitjaWhwc2c1MWcxWThZdWQzV1pkeVBhZ0w3RnlIeDJRb0lKa1pB?=
 =?utf-8?B?dTRYTG1zbWRJZ0pOd3I4VXlLcVVvVXRQRDNEOGhXaTEvRmF1elNHVVVCeDl1?=
 =?utf-8?B?TzZ2dzJwUmFHVkhHWTNJdlhBUnUxWWJKb1BOQnpWVitZK2ZmOTR3Z3ZSZUhn?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea509b-6cff-45ce-8fa0-08dd00078cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 15:10:58.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvViOwdvIQ2v2AY/cPCluRt/KOggQD74McMHx8YeOIrdKLbhxyweqOeJr0t3Xq9sesJ+1tBhNkGo+6RwWmU64/wvU3mvqBupCfS9E1rvOrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7462
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 15:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17229

Pk9uIDA4LjExLjI0IDE2OjAyLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3RlOg0KPj4gDQo+PiANCj4+
IE9uIDExLzgvMjQgMTU6NTMsIEhlaW5pc2NoLCBBbGV4YW5kZXIgKEZUIFJQRCBDRUQgU0VTLUFU
KSB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IFF1aXJpbiBhbmQgSSBkaXNjdXNzZWQgdGhpcyBhIGJp
dCBsb25nZXIgdG9kYXk6IFdlIGFjdHVhbGx5IHNob3VsZCANCj4+Pj4+PiByZW1vdmUgdGhlIG5l
ZWQgb2YgZXhwYW5kLW9uLWZpcnN0LWJvb3QgdG8gYWNjZXNzIHRoZSBrZXkgYWdhaW4uDQo+Pj4+
Pj4gQW5kIHRoYXQgaXMgYWxzbyBkdWUgdG8gYW4gaWRlYSBJIHBpY2tlZCB1cCB5ZXN0ZXJkYXkg
dG8gbG9jayB0aGUgDQo+Pj4+Pj4gdHBtIHNlY3JldCBhZnRlciBpbml0cmFtZnMgc28gdGhhdCB3
ZSByZWR1Y2UgdGhlIHJpc2sgb2YgbGVha2luZyANCj4+Pj4+PiBpdCB2aWEgdGhlIG1haW4gT1Mu
DQo+Pj4+Pj4NCj4+Pj4+PiBPdXIgcGxhbiBpcyBub3cgdG8gY29udmVydCBleHBhbmQtb24tZmly
c3QtYm9vdCBpbnRvIGFuIGluaXRyYW1mcyANCj4+Pj4+PiBob29rIHRoYXQgd291bGQgdGhlbiBj
b21lIGJlZm9yZSB0aGUgY3J5cHQtaG9vaywgdGh1cyB3b3VsZCBvbmx5IA0KPj4+Pj4+IHdvcmsg
YWdhaW5zdCB0aGUgdW5lbmNyeXB0ZWQgYmxhbmsgZmlsZXN5c3RlbSAtIHByb2JsZW0gc29sdmVk
LCANCj4+Pj4+PiBqdXN0IGRpZmZlcmVudGx5Lg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gQWN0dWFs
bHkgdGhhdCdzIGEgZ29vZCBpZGVhIQ0KPj4+Pj4gIA0KPj4+Pj4+IEZvciBub3csIGFsc28gZm9y
IHRyaXhpZSwgd2Ugd2lsbCBqdXN0IG1ha2UgdGhlIGRlcGVuZGVuY2llcyBvZiANCj4+Pj4+PiBp
bml0cmFtZnMtY3J5cHQtaG9vayByZWxlYXNlLWRlcGVuZGVudCBpbiBpc2FyLWNpcC1jb3JlLg0K
Pj4+Pj4NCj4+Pj4+IEkgZ3Vlc3MgdGhpcyBpcyB0aGUgcGF0Y2ggWzFdIHlvdSBhcmUgcmVmZXJy
aW5nIHRvPw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gQ29ycmVjdC4NCj4+Pj4NCj4+Pj4+IEp1c3QgdG8g
YmUgc3VyZSwgc3RpbGwsIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgaW5pdHJhbWZzIGhvb2sg
DQo+Pj4+PiBmb3IgZXhwYW5zaW9uIHdpbGwgYmUgaW4gaXNhcj8NCj4+Pj4+DQo+Pj4+DQo+Pj4+
IE5vcGUsIHRoaXMgaWRlYXMgZmVsbCBhcGFydCBhZnRlciB0cnlpbmcgdG8gY29udmVydCB0aGUg
Y3VycmVudCANCj4+Pj4gc3lzdGVtZCB1bml0IGludG8gYW4gZWFybHkgaW5pdHJhbWZzIGhvb2su
IFdlIHdpbGwgbmVlZCB0byBzcGxpdCB0aGluZ3M6DQo+Pj4+DQo+Pj4+ICAgLSBleHBhbnNpb24g
Zm9yIGFscmVhZHkgb3IgdG8tYmUgZW5jcnlwdGVkIHBhcnRpdGlvbnMgbmVlZHMgdG8gZ28gDQo+
Pj4+IGludG8NCj4+Pj4gICAgIHRoZSBjcnlwdC1ob29rIG9mIGNpcC1jb3JlDQo+Pj4NCj4+PiBh
ZCAiZXhwYW5zaW9uIGZvciBhbHJlYWR5IGVuY3J5cHRlZCI6IEkgZ3Vlc3MgdGhhdCBjb3ZlcnMg
Y2FzZXMgbGlrZSANCj4+PiBpbiBWTS9DbG91ZCBpbmZyYSwgd2hlcmUgZGlza3MgY2FuIGJlIGV4
cGFuZGVkIGFmdGVyIGZpcnN0LWJvb3QgLyANCj4+PiBpbnN0YWxsYXRpb24/DQo+Pj4gLS0tDQo+
Pj4NCj4+PiBJbiBtYW55IHVzZSBjYXNlcyByZXNpemluZyB0aGUgcGFydGl0aW9uIHNob3VsZCBi
ZSByZXF1aXJlZCBkdXJpbmcgDQo+Pj4gaW5zdGFsbGF0aW9uIC8gb3IgZmlyc3QgYm9vdCBvbmx5
Lg0KPj4+IFRoYXQncyB3aHksIEknZCBwcmVmZXIgaGF2aW5nIHRob3NlIHN0ZXBzIHNlcGFyYXRl
ZCBhbmQgb3B0aW5nIGluIGZvciANCj4+PiBlaXRoZXIhDQo+Pj4gQWx0aG91Z2ggcGFja2FnZSBk
ZXBlbmRlbmNpZXMgbWlnaHQgYmUgdGVtcHRpbmcgdG8gY29tYmluZSB0aG9zZSBhbmQgDQo+Pj4g
cmVkdWNlIHJlY2lwZXMgKyBpbml0cmFtZnMgaG9va3MsIHRoZSB1c2UgY2FzZXMgYW5kIG9wdGlv
bnMgb24gDQo+Pj4gY29tYmluaW5nIHRob3NlIGp1c3RpZnkgYSBzcGxpdC4NCj4+Pg0KPj4+IEFz
IGFuIGV4YW1wbGUgdG8gcG9pbnQgb3V0IHRoZSBjb21iaW5hdG9yaWFsIGNvbXBsZXhpdHkgb2Yg
anVzdCB0aG9zZSANCj4+PiB0d28gcmVjaXBlcyBhbmQgcHJvYmFibHkgdGhlcmUgYXJlIGV2ZW4g
bW9yZSBjb21iaW5hdGlvbnMgdG8gY29tZSANCj4+PiB3aGVuIGtlZXBpbmcgdGhlIHN5c3RlbWQg
ZXhwYW5kIGZyb20gaXNhci4NCj4+PiAod2hpY2ggcHJvYmFibHkgYWxzbyBtYWtlcyBzZW5zZSBm
b3Igbm9uIChjdXN0b21pemVkKSBpbml0cmFtZnMgdXNlDQo+Pj4gY2FzZXMpOg0KPj4+IE15IGN1
cnJlbnQgYXBwcm9hY2ggdG8gc3RyZWFtbGluZSB0aGF0IChkb3duc3RyZWFtKSBpcyBieSB1dGls
aXppbmcgYSANCj4+PiB0YXJnZXQtYm9vdHN0cmFwcGVyIChraW5kIG9mIG5leHQtZ2VuIGlzYXIt
aW5zdGFsbGVyKS4NCj4+PiBUaGF0IG1lYW5zLCBleHBhbnNpb24gaXMgbm90IGEgdXNlIGNhc2Ug
YWZ0ZXIgaW5zdGFsbGF0aW9uIGZvciBtZSANCj4+PiB3aGVuIHJ1bm5pbmcgb24gdGFyZ2V0IGhh
cmR3YXJlLCBzdGlsbCwgd2hlbiBkZXBsb3lpbmcgb24gdm0hIFNpbWlsYXIgDQo+Pj4gY29tYmlu
YXRpb25zIGFwcGx5IGZvciBlbmNyeXB0aW9uLCBub3QgbmVjZXNzYXJpbHkgbWFwcGluZyB0aGUg
b25lcyANCj4+PiBmb3IgZXhwYW5zaW9uLg0KPj4+IEkgYW0gYXdhcmUgb2YgdGhlIHRhcmdldC1i
b290c3RyYXBwaW5nL2luc3RhbGxlciBhcHByb2FjaCBpcyBub3QgDQo+Pj4gZGVzaXJlZCBmb3Ig
bWFueSBvdGhlciBzY2VuYXJpb3MgKGUuZy4gdm0sIHNkLWNhcmQgYmFzZWQgaW5zdGFsbHMsIA0K
Pj4+IC4uLikgYnV0IGl0IGFscmVhZHkgc2hvd3MgYSBnb29kIGFtb3VudCBvZiBjb21iaW5hdGlv
bnMuDQo+Pj4NCj4+PiBBcGFydCBmcm9tIHRoYXQsIG5vdCByZWxhdGVkIHRvIHRoZSBpbml0aWFs
IHByb2JsZW0sIGJ1dCBtYXliZSANCj4+PiBzb21ldGhpbmcgdG8ga2VlcCBpbiBtaW5kIHdoZW4g
cmVmYWN0b3JpbmcvcmV2aWV3aW5nIHRoZSBleGlzdGluZyANCj4+PiBpbXBsZW1lbnRhdGlvbjog
VGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2lsbCBwb3RlbnRpYWxseSBicmVhayB0aGUgDQo+
Pj4gcm9sbGJhY2sgY2FwYWJpbGl0eSBvbiB1cGdyYWRlcyBmcm9tIHN5c3RlbXMgd2l0aG91dCBl
bmNyeXB0aW9uIHlldCANCj4+PiBpbiBjYXNlIG9mIGZ1bGwgZGlzayBlbmNyeXB0aW9uLg0KPj4+
IFRvIG1pdGlnYXRlIHN1Y2ggZm9yIHVwZ3JhZGVzIG9mIHVuZW5jcnlwdGVkIHN5c3RlbXMgdG8g
dXNlIA0KPj4+IGVuY3J5cHRpb24sIHdlIG11c3QgZW5jcnlwdCB0aGUgcGFydGl0aW9uIHJlbGF0
aW5nIHRvIHRoZSBjdXJyZW50IA0KPj4+IGluaXRyYW1mcyBvbmx5IQ0KPj4gDQo+PiBJSE1PIFJv
bGxiYWNrIHNob3VsZCBub3QgYmUgc3VwcG9ydGVkIC0gdGhpcyBvcGVuIG9wZW5zIGEgY2FuIG9m
IC4uLiAuDQoNCkkgc2VlLiBGaW5lIGZvciBtZS4NClRoZW4ganVzdCBpZ25vcmUgdGhlIHBhcnQg
YmVsb3c6ICJBcGFydCBmcm9tIHRoYXQsIG5vdCByZWxhdGVkIHRvIHRoZSBpbml0aWFsIHByb2Js
ZW0sLi4uIg0KDQo+DQo+UmlnaHQsIEkgZG9uJ3Qgc2VlIHRoYXQgdXNlIGNhc2UgZWl0aGVyLiBX
ZSBhcmUgY292ZXJpbmcgdGhlIGluaXRpYWwgcHJvdmlzaW9uaW5nIHVzZSBjYXNlIGhlcmUuIFdp
cGluZyBldmVyeXRoaW5nIGlzIGEgZGlmZmVyZW50IHRoaW5nLCBhbmQgSSB3b3VsZCBub3QgYWRk
cmVzcyB0aGF0IGFzICJyb2xsYmFjayIuDQoNClJvbGxiYWNrIGluIHRlcm1zIG9mIEEvQiBub3Qg
aW4gdGVybXMgb2Ygd2lwaW5nIG91dC4NCg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywg
VGVjaG5vbG9neQ0KPkxpbnV4IEV4cGVydCBDZW50ZXINCj4NCg==

