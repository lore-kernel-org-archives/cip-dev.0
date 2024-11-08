Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F8D5C0F1
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 15:48:05 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web10.15734.1731080882029705018
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 07:48:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I6JFO7/b;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkw15Rg4mVgMQUwRprvyI+LdKGh1kBqylqxKdVpBvlnq07kmfF3h09Tkldm5A6HEoek1ejIE87Fclu543w4DasHcR3nq+eq9rY0B88vpM6g0rmlCoo0RsKdqA5YAtbKgmvZIhCFKbEjk3YbkQryCUL0/SE+m8BlG7dMxH7ic5pdn3FO5i2EDV2QfQruEDMuk2JXRrVcfC6GKWkX0Yv+lmmmDuRSReXHU291iXcY1sysk+UfNUhayblzIpp4uADFNBucLCwg9mdtPWVQwhYuAneAJ1yQtj83+RtEJrulIYHqbZ5ML8fANkCMnDxoRQrPa+M96/SuoP30jTAymjeOe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zrMjwDTISoWdjtdXyQx0cf3i+kpxBqqekDZk4URIpQ=;
 b=RNL3uDP18kWwcNAiBdwAOBYIHH+cTzQS6sRYktLrjWvFaNT/XP9RFejhHbCyyCKgoGP1C87i3uKNTXf3dCfpPzwEeNOvZPY5ta7yS3qc7NPb6VlmPeiDH9fEX1GOBDLuq5FORXl2wHDnDapzrVoV6Y2sE5Ftzx4YkTa2LcCR1L2ydAlYatvQxfBoFPYSJ6TJu854ydORb351brJ9RTniOyX/LwwpZTx7+Pu6J4EDDAO5uczhJhqba5nL4Psdf0Nn3dlwMKOYEDAZ4DPws9+pFoaYCCUQ4t3t19VNmR5wArhI0ACGgQsAK9c/QgbA5lvpo61i+hlFLEFhOnDvAeF/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zrMjwDTISoWdjtdXyQx0cf3i+kpxBqqekDZk4URIpQ=;
 b=I6JFO7/bRbDlQwaxT8idYdPmvdunxhdnfADk7VzBDEqObsTLVDYqeFITDUbTmP2KWXhrYwW7iYH7NoQ98qY0CE7i4SAbidBgtv4/Qupq2dHJt8yvyUf/oie7zlmg5QDLv3mHLAK90LqvSRtgFVw37ufx/H0mwz6XQ21TRC1u+sLDqYcrrDR9P+7oamZ/pnxLhy4nBm/oZacXpvPQIwrgcSH3EKuFIYskPOBsEFXTEsI/NFu3fRHSO5E13Th0qASLARVNskqj3vPurEhSGGKt2t6lZjfXQwyXlofGmlcfBcivxlZa/iK25haQ6ip/fD2bojiZC7zUsJqP9P6Q45Ne1w==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DB8PR10MB3877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11; Fri, 8 Nov
 2024 15:47:58 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 15:47:58 +0000
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
 AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hCAFHuKAIABX72ggAFi9ICAAC5OgIAACXAAgAABKgCAAAEnUIAAA/WAgAAGehA=
Date: Fri, 8 Nov 2024 15:47:58 +0000
Message-ID: 
 <AM7PR10MB332073758FFEA64F2CAEB1A8865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
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
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
In-Reply-To: <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bde22400-292f-4c7b-8c3d-d905ce18c025;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-08T15:47:39Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DB8PR10MB3877:EE_
x-ms-office365-filtering-correlation-id: 0a918f8f-93dc-41ab-9172-08dd000cb7ea
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UGUrOWFRSWVpb2VvZEJpNEpPUkpIc3dFYVhKV1I1dGdKRUpraElrbjBQMnRj?=
 =?utf-8?B?TlNCM3BValo5c2tHNnBTWVh0Q3NrbTZRYXRHNFQwbnNPVHlseWdYbmJnNmFW?=
 =?utf-8?B?STY0OE11SEFuaWlJa0ZTRkQvTEVtZThrM0MzVGlqZWY5S1E5M2FpSVdxejhx?=
 =?utf-8?B?c3R1ZzJrN2ZYRisrVUxTWnl2UXlBTmNUc0NDTDNHVmpXNk40WWVxQm5qUStX?=
 =?utf-8?B?MnE1bnlkc0JDRUF2YlBzZFloQjJiT2pIVmlmaHBtZnkxNGdZY1U0YXhPY2tB?=
 =?utf-8?B?QUZvSlBGQmh3MWtBb1FLeEdQZDRVeVNGODZYdjdrUEZLaTBoZ3dVNHVFb0RB?=
 =?utf-8?B?SndpaURCRWdxdWFOYldaTlROa3J2UURjN0xYWUNlaDhLakZFcy9UbFZyZ09B?=
 =?utf-8?B?QjFnZEVsbjBCTXpMUlpzd0NCbFQyYXRvalpIOCt4NjlPS1JwQUVnSE1qT0VB?=
 =?utf-8?B?amJ3MWV3OTd3ZGROcGdib1czZlo1K0JoWWJ3ZXMvcWQvZVBXUzcvUjZXN1lm?=
 =?utf-8?B?VXo5WDQwQ2FyZ3lORk9LUzhSMVZmWXpMc1ZsRGJQOFlKYU5DRlgvRE9KaEtL?=
 =?utf-8?B?ZEdaYWhFL1ZnSFJZODl2a3F0MXhzbUp1VDZGOVQ3QStnRXlFM293elpUKzlI?=
 =?utf-8?B?YmtqL3dKUTFsbGlhOEtxNHNYUUhJUDh0bUJaNjRhMWRsY2pLSytEeGtxbGph?=
 =?utf-8?B?enF1cXhRNHJKZDRic3VqWWEvVU1sWUI0UGsrZHZFUWE3dVludTlRRmJJc2xD?=
 =?utf-8?B?ZEJEb0JtaXVnOVViaCtQUkhFbmxocnFDeTlmVnd0d2loelZyU2dBUklzaHNR?=
 =?utf-8?B?d3Zsclcydnp6RG9rS0hzcEpkck9aMjZ4S1cwMk5GTDJxQ1g2ZHVVRkZwR1Iy?=
 =?utf-8?B?QVlLL2Jhdkh0N1BmNEh1b0Rya3ZJTEJkamc1NmJUa2tkNDcwNEVwaU90eVZV?=
 =?utf-8?B?NkNxZkFDOGdPdnJaaGxWQnhVNkRZeTZsbnVUWlNzVXJqL0w1UGJOQjNHdHAw?=
 =?utf-8?B?dWIzd2VoOUdCNkl5Y2xvcVcvTjJaakYyOXM5NzRBTHE3QS9GS0FZWURNV2JG?=
 =?utf-8?B?TzE5bVp5NUY5bXZWaHdMcVVSQU1sOWo0WUxmdFQwaVhGZVhKdG1uUlZibHRy?=
 =?utf-8?B?Tmo0cExQeDlONllORGpjSWxCRFBBRTNDZURhZEtzMWpQaXVrb3ZFdWNCN2x0?=
 =?utf-8?B?UUhNYVdRdEQ1NkUrQW14QlNKdVhjb0NQYjB0Tk1lemxycnhmL2phbU02dW05?=
 =?utf-8?B?dDV0cE54eE03YVRZbzNpZEhoK0pZUG1YVU9nazc2YStEOHJBTGVKZGVvL1NF?=
 =?utf-8?B?Z0ZYMFViVUx2OHY3ZnkvUjhNRmxaSVRNUm54MHV1Ujh4QmtlYUUrQWM0aWtP?=
 =?utf-8?B?RDREKzgrYnBhbFJJL0I0K05BSVVLYnNIdzdZTlBHUHlFbkxNL1VSU040ZGJJ?=
 =?utf-8?B?MXJjZDU3KzV2dGpOYTN0MmVlZysrQzZuUVdyNHZBcXo0VXo4d1NPNjFhU0JO?=
 =?utf-8?B?cHBuMDFrMWFCZ3NKYmlsRGgxWkhqN1poV0R1WWE2aUR6Q3czOFB0eHQ1Qkdn?=
 =?utf-8?B?V3N1dFZsNDh3aXIya1V5MFJ2YlRCSVVwazgyRHRjSktZZzd1NllzNFo2Uk50?=
 =?utf-8?B?NmRoeGJ5TjMwMVk3YkxTSGQ5bHRsNWJOaTFZbVdDK3QxOXN2ZmVab1c4TytH?=
 =?utf-8?B?Zm9PR21kRURYaGFqU0wyeUh6bXM1U0JlNkZhOFdVVnNWclFYeXdicFBuaDZk?=
 =?utf-8?B?eHBLeTR3blRYbThiQ2djdFBiYXdWd2RCS3pYS2dkbXZDd3NCYXZNRGhFNnc1?=
 =?utf-8?Q?GQxdI0IMi5rKjt++V/g1lyL+TZRSQXKmNN70c=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RmE4YnN0aGNjNTkzZVExaithYmVEZFhMZjFZcUN6VHROSWhGaDNSOHFqb1Fl?=
 =?utf-8?B?ZWFFMHlocVBWTzZxK05sUFJ0dFh0NDF5L3ZvN241SUJKSEs3TDdxSW1xSzRu?=
 =?utf-8?B?SGRMakllSkNTNEs4TnJxaWdDd1NHcEU3Y3ZCTC9yUmJZMHV6ck91dk1EVDVx?=
 =?utf-8?B?bXdlSmQ4U0ZJVE9tR1M3N3pOSVF1LytMbU51L05Beld3S0U4RldMaXZGcS8v?=
 =?utf-8?B?enBaZUx2ajJLaFprdW1oY3hFSFRRU1FUdW9FOWlnWXpsa0ZJQldNQWt3dE5x?=
 =?utf-8?B?S3B4V0NDU21CTi9xeEYvTC9OMEJhQzNsaEJwNml3VG9hZ0VRSDFCV3l1eHZB?=
 =?utf-8?B?M1FaNnU0Z09oUjBQOGsxRHlNRnlmc2dndERkUUg0ODRuUzc2OWJ6L2NNVXE1?=
 =?utf-8?B?V25QZ0FidGRYV00zeUZRb2xINU5ycEt6NXB6dlVmZ2NoRk1wVE1oRUdEMzdK?=
 =?utf-8?B?M0xLa3pRZTRMREVsWTBYaXUyUWZYTmF0SEdmWTVZZjJmakJLRjNZUG4ya0pr?=
 =?utf-8?B?aUYxblFTYWNUM3RMQkVwNjVIWlFWb1ZKY0FqY1loRnl1UDNhZ2dZM0dWSFRv?=
 =?utf-8?B?dXFUakFLRVU1ek9nZkZMRyttMmlGWm5nSDlMNnVYQXRuemI1Z283NzR2dS83?=
 =?utf-8?B?V051eWJWVzJmdzNEVk10ZzhEQkpNdFJLajV3YUI0Y1I1WmpJeCtOY0RkRjk1?=
 =?utf-8?B?MGhEVTVkWkJoc2tMcjNqTVVVMDJQWTQ0M3FublRwMlJXU2JIaUhSK2UrMzZO?=
 =?utf-8?B?U2NxdllYWFovK3pIMGQ1RWgxRE9MK2xpbnlNWDZmMUYzQ2lzdkYvWVlIcnpS?=
 =?utf-8?B?MlRuTDNhWW1ocHB6Z1h4QkNBbXIveUNraDVCSXhzalRoWWZZL1N6WDFiSEJx?=
 =?utf-8?B?TGJIOXdINHdWM0VMMUdRM1E5TzUzQ0kwTWRSbXRJbGpMbW5RSG85Vm5yODg1?=
 =?utf-8?B?ZCtobUlMOFZrZE5tR2pJWVFwWjM2Y2xPQVhHRFFRa01sTUE0b3NrT29waHp1?=
 =?utf-8?B?N1NBSnAwTFlwTHRrTHVSNnlJaHlPTWdqaTVIQUthUElGYitNcEZ3cmF1MG95?=
 =?utf-8?B?Q0c3MTVHT0NHR3ZiVVdoQVc3MmJrWERiR3FuWHRSaCtqclhTeTIybTdneEg5?=
 =?utf-8?B?V0VONElVZkhKMVJtRDFxYlpiZGlHeDltb0VPN2x2VmZ0elBkU1F4VzJsYW1m?=
 =?utf-8?B?M3lqeVpCaGVWc0xpUStvbUc5ekxtTDlpd0lHZVBuenVxcitQS1IrRmRHRWxx?=
 =?utf-8?B?S1ZhSXVXVHpEY2VsVEp5TC9hbVAzTUNFTzUwU1NXZmdadXlCWU93cXAyTEpT?=
 =?utf-8?B?MU1pWjhicGVWMTRiYjNidHV2UVk1L0pUV2x2SWswOVZaOU1CK0JsbnlzOHY5?=
 =?utf-8?B?U01HVDNwMHdZZE1vWEhkbUhuM3JKVEkrNlBiWEo4NWtmWFFXRmQwL0p6TTNi?=
 =?utf-8?B?d0loNmg1d3ptZHdGZWEzWWRqY0Qwc0pmME9DYkpNdjVQSWQrSUEvMXRwL1ZC?=
 =?utf-8?B?VG9wdCtidk9TaWxXangyRjluVXprdWs2UER0c3lGcldxOGc1b0YrNnk0L214?=
 =?utf-8?B?ZVFmZnY4dEFpZGtxa0Q1d1hOSys2ekRZM1U0OWpUV2txd3FBUU9rZHBRRzY1?=
 =?utf-8?B?b0MzVy9WdVg5MnZXbCtzUENQSVF0dkJCZVJzLzJxZXhWQTFEaGV3dHFtUU95?=
 =?utf-8?B?Q3FBMlM1am1jQm9xRlQ1QlR1S1lGYkhKUlgxUjE2eEJ3OVlCOVI5NzJQNGpG?=
 =?utf-8?B?WDMxM2RjOFh4YWdrZnYzbmJWODN2bEZBTExZK21rZ3lCZ3k0Tmk0NjBrckRP?=
 =?utf-8?B?eGxZbkhDYUUweXgzSmp6eGJjdzVOOHorQTdxdDRHK3FmTkR5Z043YkJYc2cx?=
 =?utf-8?B?V0FtbFdzMDJ1OFhSNUg0SlZqblluMk8rd0ZKMjBXNEFGSXZqVGIwbHcwNU9I?=
 =?utf-8?B?QXNDVkFLS2NUZVlZWlhPVVBzL3dIc29pQVpvZUNnTHNVeEZRbmJ3cGlFNWlr?=
 =?utf-8?B?TTBKRVIwZWE5cVJLajBrNlVwYlhWMzY5MGoyTmtMTU1WSEhZNGxTRUhvOVZt?=
 =?utf-8?B?UTdiR0lFU2EyelZFYjJoYnY3NG9QUG1USUZnRXBQYjhZMFVKOXVqbURHTjR3?=
 =?utf-8?B?T1l6dGlmeDhGcHgxTm40Y1gyb2t2OWVRT2h2ZXpyazBpRUpLZk1oRGJtWXZy?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a918f8f-93dc-41ab-9172-08dd000cb7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 15:47:58.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAP0Y5BebkYtXRuWetMa5MZm21AwLjEhdpEdHRDCUKXozSERmmfDWg1wQzq/78qCH6thVVafJt7/dhn3REZdNaixrWqmz8Tm7t7b7+GO5qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3877
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 15:48:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17231

Pk9uIDA4LjExLjI0IDE2OjEwLCBIZWluaXNjaCwgQWxleGFuZGVyIChGVCBSUEQgQ0VEIFNFUy1B
VCkgd3JvdGU6DQo+Pj4gT24gMDguMTEuMjQgMTY6MDIsIFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6
DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDExLzgvMjQgMTU6NTMsIEhlaW5pc2NoLCBBbGV4YW5kZXIg
KEZUIFJQRCBDRUQgU0VTLUFUKSB3cm90ZToNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBRdWlyaW4gYW5k
IEkgZGlzY3Vzc2VkIHRoaXMgYSBiaXQgbG9uZ2VyIHRvZGF5OiBXZSBhY3R1YWxseSANCj4+Pj4+
Pj4+IHNob3VsZCByZW1vdmUgdGhlIG5lZWQgb2YgZXhwYW5kLW9uLWZpcnN0LWJvb3QgdG8gYWNj
ZXNzIHRoZSBrZXkgYWdhaW4uDQo+Pj4+Pj4+PiBBbmQgdGhhdCBpcyBhbHNvIGR1ZSB0byBhbiBp
ZGVhIEkgcGlja2VkIHVwIHllc3RlcmRheSB0byBsb2NrIA0KPj4+Pj4+Pj4gdGhlIHRwbSBzZWNy
ZXQgYWZ0ZXIgaW5pdHJhbWZzIHNvIHRoYXQgd2UgcmVkdWNlIHRoZSByaXNrIG9mIA0KPj4+Pj4+
Pj4gbGVha2luZyBpdCB2aWEgdGhlIG1haW4gT1MuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gT3VyIHBs
YW4gaXMgbm93IHRvIGNvbnZlcnQgZXhwYW5kLW9uLWZpcnN0LWJvb3QgaW50byBhbiANCj4+Pj4+
Pj4+IGluaXRyYW1mcyBob29rIHRoYXQgd291bGQgdGhlbiBjb21lIGJlZm9yZSB0aGUgY3J5cHQt
aG9vaywgdGh1cyANCj4+Pj4+Pj4+IHdvdWxkIG9ubHkgd29yayBhZ2FpbnN0IHRoZSB1bmVuY3J5
cHRlZCBibGFuayBmaWxlc3lzdGVtIC0gDQo+Pj4+Pj4+PiBwcm9ibGVtIHNvbHZlZCwganVzdCBk
aWZmZXJlbnRseS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFjdHVhbGx5IHRoYXQncyBh
IGdvb2QgaWRlYSENCj4+Pj4+Pj4gIA0KPj4+Pj4+Pj4gRm9yIG5vdywgYWxzbyBmb3IgdHJpeGll
LCB3ZSB3aWxsIGp1c3QgbWFrZSB0aGUgZGVwZW5kZW5jaWVzIG9mIA0KPj4+Pj4+Pj4gaW5pdHJh
bWZzLWNyeXB0LWhvb2sgcmVsZWFzZS1kZXBlbmRlbnQgaW4gaXNhci1jaXAtY29yZS4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gSSBndWVzcyB0aGlzIGlzIHRoZSBwYXRjaCBbMV0geW91IGFyZSByZWZlcnJp
bmcgdG8/DQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBDb3JyZWN0Lg0KPj4+Pj4+DQo+Pj4+Pj4+
IEp1c3QgdG8gYmUgc3VyZSwgc3RpbGwsIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgaW5pdHJh
bWZzIGhvb2sgDQo+Pj4+Pj4+IGZvciBleHBhbnNpb24gd2lsbCBiZSBpbiBpc2FyPw0KPj4+Pj4+
Pg0KPj4+Pj4+DQo+Pj4+Pj4gTm9wZSwgdGhpcyBpZGVhcyBmZWxsIGFwYXJ0IGFmdGVyIHRyeWlu
ZyB0byBjb252ZXJ0IHRoZSBjdXJyZW50IA0KPj4+Pj4+IHN5c3RlbWQgdW5pdCBpbnRvIGFuIGVh
cmx5IGluaXRyYW1mcyBob29rLiBXZSB3aWxsIG5lZWQgdG8gc3BsaXQgdGhpbmdzOg0KPj4+Pj4+
DQo+Pj4+Pj4gICAtIGV4cGFuc2lvbiBmb3IgYWxyZWFkeSBvciB0by1iZSBlbmNyeXB0ZWQgcGFy
dGl0aW9ucyBuZWVkcyB0byANCj4+Pj4+PiBnbyBpbnRvDQo+Pj4+Pj4gICAgIHRoZSBjcnlwdC1o
b29rIG9mIGNpcC1jb3JlDQo+Pj4+Pg0KPj4+Pj4gYWQgImV4cGFuc2lvbiBmb3IgYWxyZWFkeSBl
bmNyeXB0ZWQiOiBJIGd1ZXNzIHRoYXQgY292ZXJzIGNhc2VzIA0KPj4+Pj4gbGlrZSBpbiBWTS9D
bG91ZCBpbmZyYSwgd2hlcmUgZGlza3MgY2FuIGJlIGV4cGFuZGVkIGFmdGVyIA0KPj4+Pj4gZmly
c3QtYm9vdCAvIGluc3RhbGxhdGlvbj8NCj4+Pj4+IC0tLQ0KPj4+Pj4NCj4+Pj4+IEluIG1hbnkg
dXNlIGNhc2VzIHJlc2l6aW5nIHRoZSBwYXJ0aXRpb24gc2hvdWxkIGJlIHJlcXVpcmVkIGR1cmlu
ZyANCj4+Pj4+IGluc3RhbGxhdGlvbiAvIG9yIGZpcnN0IGJvb3Qgb25seS4NCj4+Pj4+IFRoYXQn
cyB3aHksIEknZCBwcmVmZXIgaGF2aW5nIHRob3NlIHN0ZXBzIHNlcGFyYXRlZCBhbmQgb3B0aW5n
IGluIA0KPj4+Pj4gZm9yIGVpdGhlciENCj4+Pj4+IEFsdGhvdWdoIHBhY2thZ2UgZGVwZW5kZW5j
aWVzIG1pZ2h0IGJlIHRlbXB0aW5nIHRvIGNvbWJpbmUgdGhvc2UgDQo+Pj4+PiBhbmQgcmVkdWNl
IHJlY2lwZXMgKyBpbml0cmFtZnMgaG9va3MsIHRoZSB1c2UgY2FzZXMgYW5kIG9wdGlvbnMgb24g
DQo+Pj4+PiBjb21iaW5pbmcgdGhvc2UganVzdGlmeSBhIHNwbGl0Lg0KPj4+Pj4NCj4+Pj4+IEFz
IGFuIGV4YW1wbGUgdG8gcG9pbnQgb3V0IHRoZSBjb21iaW5hdG9yaWFsIGNvbXBsZXhpdHkgb2Yg
anVzdCANCj4+Pj4+IHRob3NlIHR3byByZWNpcGVzIGFuZCBwcm9iYWJseSB0aGVyZSBhcmUgZXZl
biBtb3JlIGNvbWJpbmF0aW9ucyB0byANCj4+Pj4+IGNvbWUgd2hlbiBrZWVwaW5nIHRoZSBzeXN0
ZW1kIGV4cGFuZCBmcm9tIGlzYXIuDQo+Pj4+PiAod2hpY2ggcHJvYmFibHkgYWxzbyBtYWtlcyBz
ZW5zZSBmb3Igbm9uIChjdXN0b21pemVkKSBpbml0cmFtZnMgdXNlDQo+Pj4+PiBjYXNlcyk6DQo+
Pj4+PiBNeSBjdXJyZW50IGFwcHJvYWNoIHRvIHN0cmVhbWxpbmUgdGhhdCAoZG93bnN0cmVhbSkg
aXMgYnkgdXRpbGl6aW5nIA0KPj4+Pj4gYSB0YXJnZXQtYm9vdHN0cmFwcGVyIChraW5kIG9mIG5l
eHQtZ2VuIGlzYXItaW5zdGFsbGVyKS4NCj4+Pj4+IFRoYXQgbWVhbnMsIGV4cGFuc2lvbiBpcyBu
b3QgYSB1c2UgY2FzZSBhZnRlciBpbnN0YWxsYXRpb24gZm9yIG1lIA0KPj4+Pj4gd2hlbiBydW5u
aW5nIG9uIHRhcmdldCBoYXJkd2FyZSwgc3RpbGwsIHdoZW4gZGVwbG95aW5nIG9uIHZtISANCj4+
Pj4+IFNpbWlsYXIgY29tYmluYXRpb25zIGFwcGx5IGZvciBlbmNyeXB0aW9uLCBub3QgbmVjZXNz
YXJpbHkgbWFwcGluZyANCj4+Pj4+IHRoZSBvbmVzIGZvciBleHBhbnNpb24uDQo+Pj4+PiBJIGFt
IGF3YXJlIG9mIHRoZSB0YXJnZXQtYm9vdHN0cmFwcGluZy9pbnN0YWxsZXIgYXBwcm9hY2ggaXMg
bm90IA0KPj4+Pj4gZGVzaXJlZCBmb3IgbWFueSBvdGhlciBzY2VuYXJpb3MgKGUuZy4gdm0sIHNk
LWNhcmQgYmFzZWQgaW5zdGFsbHMsDQo+Pj4+PiAuLi4pIGJ1dCBpdCBhbHJlYWR5IHNob3dzIGEg
Z29vZCBhbW91bnQgb2YgY29tYmluYXRpb25zLg0KPj4+Pj4NCj4+Pj4+IEFwYXJ0IGZyb20gdGhh
dCwgbm90IHJlbGF0ZWQgdG8gdGhlIGluaXRpYWwgcHJvYmxlbSwgYnV0IG1heWJlIA0KPj4+Pj4g
c29tZXRoaW5nIHRvIGtlZXAgaW4gbWluZCB3aGVuIHJlZmFjdG9yaW5nL3Jldmlld2luZyB0aGUg
ZXhpc3RpbmcNCj4+Pj4+IGltcGxlbWVudGF0aW9uOiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biB3aWxsIHBvdGVudGlhbGx5IGJyZWFrIA0KPj4+Pj4gdGhlIHJvbGxiYWNrIGNhcGFiaWxpdHkg
b24gdXBncmFkZXMgZnJvbSBzeXN0ZW1zIHdpdGhvdXQgZW5jcnlwdGlvbiANCj4+Pj4+IHlldCBp
biBjYXNlIG9mIGZ1bGwgZGlzayBlbmNyeXB0aW9uLg0KPj4+Pj4gVG8gbWl0aWdhdGUgc3VjaCBm
b3IgdXBncmFkZXMgb2YgdW5lbmNyeXB0ZWQgc3lzdGVtcyB0byB1c2UgDQo+Pj4+PiBlbmNyeXB0
aW9uLCB3ZSBtdXN0IGVuY3J5cHQgdGhlIHBhcnRpdGlvbiByZWxhdGluZyB0byB0aGUgY3VycmVu
dCANCj4+Pj4+IGluaXRyYW1mcyBvbmx5IQ0KPj4+Pg0KPj4+PiBJSE1PIFJvbGxiYWNrIHNob3Vs
ZCBub3QgYmUgc3VwcG9ydGVkIC0gdGhpcyBvcGVuIG9wZW5zIGEgY2FuIG9mIC4uLiAuDQo+PiAN
Cj4+IEkgc2VlLiBGaW5lIGZvciBtZS4NCj4+IFRoZW4ganVzdCBpZ25vcmUgdGhlIHBhcnQgYmVs
b3c6ICJBcGFydCBmcm9tIHRoYXQsIG5vdCByZWxhdGVkIHRvIHRoZSBpbml0aWFsIHByb2JsZW0s
Li4uIg0KPj4gDQo+Pj4NCj4+PiBSaWdodCwgSSBkb24ndCBzZWUgdGhhdCB1c2UgY2FzZSBlaXRo
ZXIuIFdlIGFyZSBjb3ZlcmluZyB0aGUgaW5pdGlhbCBwcm92aXNpb25pbmcgdXNlIGNhc2UgaGVy
ZS4gV2lwaW5nIGV2ZXJ5dGhpbmcgaXMgYSBkaWZmZXJlbnQgdGhpbmcsIGFuZCBJIHdvdWxkIG5v
dCBhZGRyZXNzIHRoYXQgYXMgInJvbGxiYWNrIi4NCj4+IA0KPj4gUm9sbGJhY2sgaW4gdGVybXMg
b2YgQS9CIG5vdCBpbiB0ZXJtcyBvZiB3aXBpbmcgb3V0Lg0KPj4gDQo+DQo+VGhlbiBJIGRvIG5v
dCBnZXQgd2hhdCB5b3UgbWVhbi4gQS9CIG9ubHkgY29tZXMgaW50byBwbGF5IGFmdGVyIHRoZSBm
aXJzdCBib290LCB0aHVzIGFmdGVyIGVuY3J5cHRpb24gaGFzIGJlZW4gZXN0YWJsaXNoZWQuDQoN
CjEuIEFzc3VtZSB5b3UgaGF2ZSBhIHByb2R1Y3QgYmFzZWQgb24gaXNhci1jaXAtY29yZSBkZXBs
b3llZCBpbiB0aGUgZmllbGQgd2l0aG91dCANCiAgIGRpc2sgZW5jcnlwdGlvbiBlbmFibGVkIChp
bml0cmFtZnMgd2FzIGJ1aWx0IHdpdGhvdXQgYE9WRVJSSURFUyAuPSAiOmVuY3J5cHQtcGFydGl0
aW9ucyJgKQ0KMi4gQWZ0ZXIgc29tZSB0aW1lIHRoZSByZXF1aXJlbWVudCBmb3IgZnVsbCBkaXNr
IGVuY3J5cHRpb24gZ2V0cyByZWxldmFudCwgYW5kIHRoZSBpbWFnZSBnZXQncyB1cGRhdGVkDQog
ICB0byBzdXBwb3J0IGRpc2sgZW5jcnlwdGlvbiAoaW5pdHJhbWZzIG9mIHVwZGF0ZSB3YXMgYnVp
bHQgYE9WRVJSSURFUyAuPSAiOmVuY3J5cHQtcGFydGl0aW9ucyJgIHNldCkNCjMuIFVwZGF0ZSAu
c3d1IGZpbGUgZ2V0cyBhcHBsaWVkIHdpdGggU1dVcGRhdGUuIFRodXMsIHBhc3NpdmUgcGFydGl0
aW9uIChsZXRzIGFzc3VtZSBCX3Jvb3RmcykgZ2V0cyBvdmVycmlkZW4gYW5kIGEgcmVib290IGhh
cHBlbnMNCjQuIEFmdGVyIHRoZSByZWJvb3Qgd2UgYm9vdCB0aGUgbmV3IGluaXRyYW1mcyBmcm9t
IGVmaWJvb3RndWFyZCBwYXJ0IChCX3VraSkgd2l0aCB0aGUgaW5pdHJhbWZzLWNyeXB0LWhvb2sg
YWN0aXZlLg0KNS4gQSBmdWxsIGRpc2sgZW5jcnlwdGlvbiBnZXRzIGFwcGxpZWQuIFRoaXMgaW5j
bHVkZXMgZW5yeXB0aW9uIG9mIEFfcm9vdGZzIHBhcnRpdGlvbiBhcyB3ZWxsIGFzIEJfcm9vdGZz
IHBhcnRpdGlvbiwgYW5kIGRhdGEgcGFydGl0aW9ucy4NCjYuIEFmdGVyd2FyZHMgd2hpbGUgZmlu
aXNoaW5nIHRvIGJvb3QgQl91a2kgdXNpbmcgdGhlIEJfcm9vdGZzIHdlIGlkZW50aWZ5IGEgcHJv
YmxlbSAvIHdhdGNoZG9nIHRyaWdnZXJzIC8gZXRjLg0KNy4gUmVib290DQo4LiBlZmlib290Z3Vh
cmQgc2V0dGluZyBpZGVudGlmaWVzIHdlIGRpZCBub3QgY29tbWl0IHRoZSBpbnN0YWxsIGFuZCBm
YWxscyBiYWNrIHRvIGJvb3QgZnJvbSBBX3VraSB1c2luZyBBX3Jvb3Rmcw0KOS4gQV91a2kgZG9l
cyBub3QgaW5jbHVkZSB1dGlsaXR5IGZvciBkaXNrIGVuY3J5cHRpb24sIHRodXMsIGNhbm5vdCBz
ZXR1cCBkbV9jcnlwdCBtYXBwZXIgYWNjb3JkaW5nbHksIGFuZCBmYWlscy4NCjEwLiBEZXZpY2Ug
YnJpY2tlZC4NCg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkxp
bnV4IEV4cGVydCBDZW50ZXINCj4NCg0KQlIgQWxleGFuZGVyDQo=

