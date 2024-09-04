Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88096CE7AAB
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 03:32:02 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.79])
 by mx.groups.io with SMTP id smtpd.web11.55977.1725470431719279765
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 10:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f6+0nlh4;
 spf=pass (domain: siemens.com, ip: 40.107.247.79, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fihix1n3xXRaS2ohUX03UV9kLATpeV2Zll2HgQHUtuc66MjDw/WaNLPoWMwW9dVYQP4T8kdtgpN9Tq8gRMpcrh9e6NZ5LAIY5zZQRxPkQqAPeUEGIKTr0l8QoRdegvkuwyClddm/5Q4zOwhC6QI/VI8Vd9weeCjhqUnWyyVWx9O3j0S4/RCZX6UogAyQgnDpMtasmStNPcQIEbkdjtCfSMeSeDluKL4VlK7yoJHF/6bnHHZlk4NIv1Xc+S8jZJuDYVMfgPA/VGHN271Fnsz8Cn8uifXE1dwlYfb2SBibyoKq4iu3z8k7r000kSugvEAqlJMBPWgLInhR2+dcKNElDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGzeQIrPXipO5FllAbfcFaOjkRSPfjy4jGJ0ZEpvq0o=;
 b=M8QocGqdVva+EjGAt/I/np8RxKrQOirOAIcqU3k9Gax3RBy0aNYzHE5zrNYwjeTZOaIm+56GXhVFdB1oWF+GLBjJip0rAMMIMPXgIdYUAdXfJzCC8FGLUzFlvwDbROX96pPTplVOvzZfe5K96NxjcZdjtq9TISwmw6hrV0shEhpl3stouAgXkMoJXoJR8k0NwSw2mgY2IVwc0kZ5C6vA6TXCAM9VzyXljnGOjaPJCfWG7o+uuKbTpKKtWlWX+9aRq5p2tljCDEPbK66wQsZCu/4h6MtqS0PIyB/WL1gSiAoXsw/xcPQpvR/hqm1P/svJ7YF4Ylz3EPq6UBdCzPWzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGzeQIrPXipO5FllAbfcFaOjkRSPfjy4jGJ0ZEpvq0o=;
 b=f6+0nlh4ZsmoCoNNMkjQiJ9Ic9N8qteIJrLER2Qgu91LD8QjQATwzhlexl2PqvAmeR1gjdLHwbBaMOFUGixYKmPAoXfJolUSDNvX7yND7MHUYtWZptv7C7LD7ABhF4pFd3B/zc87aFct7KocJ7ce0tNVMcqnlaxwEsSCS75rgfA6/wDMNfZ/oy006HZJkBMeWPy4F3W14sTuvUfVwocOeePfBCiBGbjE/dOhGG14W9dgJd07ZAiBDB6mj2C15ACzu0Ln/yn1cdOxGRr7kwZjvlCm1R/DwiJpLR6BpBhsdELBt3HAY0fcTZ821ebPHEndw0uvH6ppXxLj3sMw3bT20w==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by PRAPR10MB5274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 17:20:25 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:20:24 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] Fixing dependency of package expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building with disk encryption enabled.
Thread-Topic: [isar-cip-core][PATCH] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled.
Thread-Index: AQHa9XhkqUioTrhStEWehPx7jPwvT7I5duyAgAAHWNCAAAtCAIAOaJDg
Date: Wed, 4 Sep 2024 17:20:23 +0000
Message-ID: 
 <AM7PR10MB3320316F8B496C5BCC7D62A4869C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
 <70399ffd-bf1f-4a28-b8d6-b7a7981c7726@siemens.com>
 <AM7PR10MB332074787FC29E44AC3F6AF3868B2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <875945bf-6be7-46f9-803b-dbad06734b72@siemens.com>
In-Reply-To: <875945bf-6be7-46f9-803b-dbad06734b72@siemens.com>
Accept-Language: de-AT, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=24d2eb63-bbdf-45a6-a17b-53669bd1c317;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-09-04T17:18:52Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|PRAPR10MB5274:EE_
x-ms-office365-filtering-correlation-id: a7242767-2f92-480a-260c-08dccd05dc9e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cExNQkQxd3lTSks2YlpDTHlqZTNET2ZNS1Y3d3lIMVN1Y1k3Mm9DcEdZeGRn?=
 =?utf-8?B?OUhqblhGQ2FuV1BTK3U0anlXQjBsWkt3K1hXQm53S1RpWlQwaXYrZ3phUDZh?=
 =?utf-8?B?WmlTT2VyNTB4SGNjZjN2UldGUVBwdEU2T2ZTSnpFbkVvU0gwVmpqaVlzc2k3?=
 =?utf-8?B?R1ZQazRvOVZQTnZYQ3hQNW4rUWlTakkxWTBsYmpicXVnZ0xkNmxmbW9kcjBz?=
 =?utf-8?B?SEZQOXVBLzFqNVY0WmFvL3pseSt3Y0g3RHIyOW1NL3haK2lWSHk1WWlJcDZI?=
 =?utf-8?B?V2U5TnV4Tk1IUVJYN0U3WXdzREN4bjg1UGR6SCtKaU5Xd3RucUZ0TGluY0J2?=
 =?utf-8?B?RENFekV2eXRRMWxKRXpHZEJpRGFteTNGS0dVTFNiRTNsNHc0cG53c1RzZ0xn?=
 =?utf-8?B?YUgzSTQ5TitnYlVnckZOZDVyVmQzSDNTcGtxYW4rS2FJWkxYM1V5bWdxN2ps?=
 =?utf-8?B?VUozNlBXZVVWVWZEczNaMGk5UjRmUENLOU5TRVRrS25CQkNrRmV6OFRXWnhR?=
 =?utf-8?B?eU4xM0orV2F3djdCc2gvS28vVTBaVU94NkRDZnJPR2dEaGI3Y0cxaDYwSkhx?=
 =?utf-8?B?cEdWc3pOaTRCbml5MFJoTkZIZ1A5dGFTMTYwNENIMmRMWUY1R1BFY1VhREFO?=
 =?utf-8?B?aFlxT0xBMEFmaG9pd2dIRC9pN2MxR3orbU1oSjV6WWVTMm9pM0w5cmx6UDhr?=
 =?utf-8?B?TTVpY1oxck1qWDh2NXFxTTFKYTZLMjFNQ0E2UEtRVjVBVUx3aCtVZGNyNTZi?=
 =?utf-8?B?Y2dXL3JjNEdmMW5tL3IrL2ZlSTBobmQ0QXBNbFlDWkx5c2pYQUZraGJWVGdi?=
 =?utf-8?B?WEh1QkVZckZOdVFsOFBsa0FjeUhCK1FCZ0VINE4wbzNKYk00NTltMVNFbVB0?=
 =?utf-8?B?Z2VqekN1OXM2L3Z4dngrZjFGbnkwTlE1bWZvNVhGL0dTVDYyTTczNlg3Ritl?=
 =?utf-8?B?ZWFmdDBrMTVDUy8zNytuZGxFTDF1ci90MFRlRTk1b3UraGlvUDhTU1hIcVhq?=
 =?utf-8?B?c0tFWWFoaCtIdmlPaCt1M3FEL0Yxa0psYkY3c2NPVlN1QlNqL1VEM2NDcmh3?=
 =?utf-8?B?YmY0bytsVzNXaytpTFlKam5PVlN2MmE5T0VNMjZtNzFjaGkyTE5uOGtPcVJV?=
 =?utf-8?B?QlRZUTIydU90N1BraVEycnRlcnpkVnhacmc2M0pZb1JxMTZVbHpOeFJJTDRC?=
 =?utf-8?B?NHZhZW9wbnQzd1BaVTlHTXZvYzQ4TS9WbloxMlhGbEJpTzJ2VldsUHg3WWNY?=
 =?utf-8?B?SnFXcUM4SjYvUmpBemhBOGt3aFA0ZmF4Ulc5ZEhXMXRnb3Vac1lIK1J0UUM3?=
 =?utf-8?B?UUFuWHJYc3czS0F0Q1FPWk1YYWQ2d2hrY1gxSnVrcjR4ZXpkTU5SY3o4Q1ZB?=
 =?utf-8?B?aXZydC9IV05XNlB3TDJPWmFnQjBvaUwwMnFtNWJLclYvSlIyaU9MRFpZMTAy?=
 =?utf-8?B?ODVxT3Y0d3IyTHlXa21KWUxIRXkwd3hHN0NxL0FmVkZOVzRqQ0R3Y2ZVWUlT?=
 =?utf-8?B?THdmTldNcFNDdTlOakNSSTk0bFJlRXlIVWlKUFZMS0VCUUluUVUrQXh3d2RR?=
 =?utf-8?B?RUpxYXNSRDNhaHVkQ1l3MkRaejVZdFY0a25jeks5OEtoTDhMSmFpS2hEcFBl?=
 =?utf-8?B?dDVRUmp5SW4wOGJWSEltT1hhWC9UQ1RZNWFSWmZ3TnRMTVVtMTVXZ1JyQ3Q3?=
 =?utf-8?B?MURHeVM5Rlg2T0FtaGd1WTBQb0VRRHlqMXdJTk9GUnJhYnZtakNRN2R2SHdV?=
 =?utf-8?B?OFFDRVgrVHhlRjJpT2wrK1JBMnNYOXpmS0J5a3pHUk5yZWk3TzlDbWxSYWNy?=
 =?utf-8?Q?wC/7atV8V2MlJc7YFCj0vBE38EK8ywC/1tADo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aFRXY3RTdVVjY1RVUEZoUVIzVXNPS2JlTk1hLzBwSDZKek81OFZkSkFnRGVP?=
 =?utf-8?B?T2dlUWxKdEY4MTRaSElUS09UYXdYRjN4Z1pLUm91Ym85SVREQjB1bzJzY3Z4?=
 =?utf-8?B?YlI5eTM5bzdXRTJzS2YzUGNzZjd0SThMYW9FQWNyTVZlYmFzd3ZFTi9NdUFQ?=
 =?utf-8?B?a21pdS9EMkR2cGNxMEtQbW1GcUJ6d2l0OWk2azc4QStZdk1kTkc1aVhtYVdt?=
 =?utf-8?B?MjY5VFNWQ1dwaThuRXNIU2RFaHdvSStpTDdMZEptSUhsMEhDQUJHYzByTVdr?=
 =?utf-8?B?MGkzQkk1T0prWUlDRkg2alFGM1h0NU05UTNrU1E3N2FlZDYvWUREWGJLSm9i?=
 =?utf-8?B?ZUxEczYwejBLWklnWVZyVTk5TGdsYnpmT09NaExROXRWeFUzNzBESnJCaUZx?=
 =?utf-8?B?M3ArWFZRakF4a0tHeU1PYU9rV01jTUNRZnovaHFqMWpyY2pxU0V1dmVUang5?=
 =?utf-8?B?UnhyN25IaVNONzh4dElpbEVNSkJ1clBBQi9hRlNjS2g2VTU3ODBMb2h0SnRs?=
 =?utf-8?B?UjErVGxaQXN3MkE1cFNvdTFaT25hRjhQWlliLzYxeWlselNjUE5mVGNCWEVx?=
 =?utf-8?B?dG5YMUhRdHIxTVdmQ0pkZnBXOVRKc2xRSVRkRFh2MUZvbWpvVFAvbDUzTHJX?=
 =?utf-8?B?NHNSZGFsczlXMll5YXkxVXlXQ3UrL3lrbEVSNHRwTE5NREM4aDVhRE44TEFV?=
 =?utf-8?B?bGFGRnBPdDQwKzQ1T3dTYjNRVWU3UWpITmRTdUJkRUs2WGNmMTJPZW1BQTNH?=
 =?utf-8?B?QnR2bFVUZGliaE1YNVlBVmpqV1NMZW1XTExJRW1SVU8rK0thWHRXU3BkWTNP?=
 =?utf-8?B?b1I2TXVwNlY2bThlTVcrajdmZjBpcWtuSG00L3Ryekg2cHE4OVJLWlZUdm95?=
 =?utf-8?B?Zk4xL29HTElCbUpGUHJWdWF4UExLSDlkeWxXZ090S2xDT1dGbGZOOHhVWmxS?=
 =?utf-8?B?aEQvb1BoZ1JiVTI2VCtxZHZMSEkzRTgvaEtZTHcvUDIzTzJXdlQ5ci9QeTcz?=
 =?utf-8?B?eHFKWHpLdlhpdkZuVTZKcW9BRVoxclErYzk5UkRYR0VrL3h0ZkxxQ3FLZSs1?=
 =?utf-8?B?VEQ3ZGg4OFoxb2lyYkV3ZHdrMEZac3ZMR0ptV3NUR1VpYTVWRm5hSUc4UEM2?=
 =?utf-8?B?dDcrWE8vZXhQQUJQbzdZM0lrS0lZWHRVTmljTldwQXloMTdFcERhRGVESjg1?=
 =?utf-8?B?RzJGTVBPWC9jUUJHNnh3eHYwcnNFSThVcy9OZjhpeTRyTzJ1WVZqMzZQclEz?=
 =?utf-8?B?QUY5WHRFZE4rN0xKY29kWTVHVnA0VFp5NVNLYlBHS3FFeTFhTXZKUHNFUGN0?=
 =?utf-8?B?NUFRVlFid3BwUWI5VDBSdlcxY0czTGJzVnpTbE1oQzlGaDh6L053L3RPTEV3?=
 =?utf-8?B?VUlVS0Z1VDllOXpXcTIzbkdxcllzTE9xV016U3BlQmdMY3lTR2lqU1B4RDcv?=
 =?utf-8?B?eTBDQ3FZenZyR2lHVGUzcmdFVFRVQ2VWRC9MdUw0a1dXUFdkNS9qMFh1MTJv?=
 =?utf-8?B?U1ZEU2Nnbld1WmlGcXNVc2o2bnJHU2o4dFBQRHlXR1ppd0IxbXhrVUNqNk56?=
 =?utf-8?B?eTdzdlNvZHF3QWZCOUVXQzBEcXprUnVvdzZpWSsyZVBSSjhXWTMySVp2QmFp?=
 =?utf-8?B?d1J5ZWNBVXZ3a1ZRSTV5WGVoMFAwcUs1YmpzOEVtWisvaUNuTHJRT2VuZzhm?=
 =?utf-8?B?SllwZHdoNmRIT3k2MlNjNWN0WUI4bUMzMERmQldwc0g1clRPZmYwbTFlV3d3?=
 =?utf-8?B?SGUyN2UxclV3dE85Zy9KTm9CNkpiYmxFenFwaU5nS1pxdjRlK1lZazI4Y1Mv?=
 =?utf-8?B?R1JVS3VYTDd6dDFOM2lHQTU0YzlUZXY3YUE4Y1owd0ZLUnk1MVY2ckZuU0hn?=
 =?utf-8?B?TitmNVhSY0ZsODI5RnU5OFI3QjBYR1Q4cGtIS1A5YjQ0bDZlSVJUUHB0U3pn?=
 =?utf-8?B?cGxKMWRqQ010dWNXVE4rUExpY2w3UFRwWUs4cmN0SWFvOHpHd0dzS3lzeHR0?=
 =?utf-8?B?Q05WSXdWSmt0R1BrbFJqQ0VWZVkxT3dsZlUrVU1nZ0g4RGYrZ1dJakpFT1pX?=
 =?utf-8?B?c2x5QlJjT2ZTT25HV0hpUENxQURieHFPengvQ0U5OWdEcWYrd0dTUWtnbnQ4?=
 =?utf-8?B?THc0cEdlMWJjTk0vS1g3Wnhsc29IZm9TWHhoeUhubk9MU3poM1RsU05MenIw?=
 =?utf-8?B?Q3c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7242767-2f92-480a-260c-08dccd05dc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:20:23.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Irzn9UG/E73T103IDV0dRbw0gbNHki6PzAnQ2vh2blunC6SPq8TQNu5+k5A20nMxaiiYhXV0PxfofAmd4rbq2vEf6EqMdfEoiZ/GtT+jrrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5274
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 03:32:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16855

U2hvcnQgdXBkYXRlIG9uIHRoaXMgcGF0Y2guDQoNCkFmdGVyIHNvbWUgZGlzY3Vzc2lvbiB3ZSBk
ZWNpZGVkIHRvIGltcHJvdmUgdGhpcyBwYXRjaCBpbiB0aGUgZm9sbG93aW5nIHdheToNCg0KMS4p
IEluc3RlYWQgb2YgYWRkaW5nIGFkZGl0aW9uYWwgZGVwZW5kZW5jaWVzIHVzZWQgdG8gaGFuZGxl
IGRpc2sgZXhwYW5zaW9uIGluIGNhc2UNCm9mIGVuY3J5cHRlZCBkaXNrcyBieSBhIGJiYXBwZW5k
LCB3ZSBhZGQgYSB2YXJpYWJsZSAoYEFERElUSU9OQUxfRElTS19FTkNSWVBUSU9OX1BBQ0tBR0VT
YCkgdG8gZXh0ZW5kIHRoZSBkZXBlbmRlbmNpZXMgDQpvZiBwYWNrYWdlIGV4cGFuZC1vbi1maXJz
dC1ib290XyUuYmIuIA0KVGhhdCB3YXkgd2UgZG9uJ3QgaGF2ZSB0byBzdHJ1Z2dsZSB3aXRoIHZl
cnNpb24gbWF0Y2hpbmcsIG9yIHVuZm9yc2VlYWJsZSBjaGFuZ2VzIHVwc3RyZWFtLCANCnN0aWxs
LCBwcm92aWRpbmcgZmxleGliaWxpdHkgZm9yIGRvd25zdHJlYW0gcHJvamVjdHMgbGlrZSBpc2Fy
LWNpcC1jb3JlIHRvIA0KYWRkIHRoZSBkZXBlbmRlbmNpZXMgbmVlZGVkIHdoZW4gZGlzayBlbmNy
eXB0aW9uIGlzIGFwcGxpZWQhDQoNClNlZTogaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL2lz
YXItdXNlcnMvYy8wbWMwQUd5UDN5WQ0KDQoyLikgT25jZSBwYXRjaCBpcyBhcHBsaWVkIHdlIGhh
dmUgdG8gYnVtcCBpc2FyLWNpcC1jb3JlIHRvIGlzYXIgdmVyc2lvbiBjb250YWluaW5nIHRoZSBw
YXRjaC4NCg0KMy4pIERlZmluZSBgQURESVRJT05BTF9ESVNLX0VOQ1JZUFRJT05fUEFDS0FHRVNg
IGluIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3Jl
Ly0vYmxvYi9tYXN0ZXIvY29uZi9kaXN0cm8vY2lwLWNvcmUtY29tbW9uLmluYz9yZWZfdHlwZT1o
ZWFkcw0KDQo0LikgUmV1c2Ugb2YgYEFERElUSU9OQUxfRElTS19FTkNSWVBUSU9OX1BBQ0tBR0VT
YCBpbiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29y
ZS8tL2Jsb2IvbWFzdGVyL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2lu
aXRyYW1mcy1jcnlwdC1ob29rXzAuMi5iYj9yZWZfdHlwZT1oZWFkcyNMMTINCnRvIGVuc3VyZSBj
b25zaXN0ZW5jeSBvbiBmdXR1cmUgY2hhbmdlcy4NCg0KUGF0Y2ggc2VyaWVzIGZvbGxvd3Mgb25j
ZSBwYXRjaCBpcyBhcHByb3ZlZCB1cHN0cmVhbS4uLg0KDQpCUiBBbGV4YW5kZXINCg==

