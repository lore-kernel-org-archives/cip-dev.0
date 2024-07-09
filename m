Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37213C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 17:54:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.83])
 by mx.groups.io with SMTP id smtpd.web10.701.1720543315130366822
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jul 2024 09:41:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fr/1PES0;
 spf=pass (domain: siemens.com, ip: 40.107.105.83, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPbiuRNQm/rh8trIiE9Y2drHaKQ0wHY0uHurcBTm4dq+FgZh0N9eUhZlhvoDIgNjJB1UkPXMncRQfo8c5/LD62j47mTp5k4ThSEaA83T13FDass9PnVFjspAf+nwrwkTNccXP6kQaCoD04ykm9rJEfh95PPp5frXGpMsF5wpM8b42nm/OYpAaGcU0SXBU+8aj7/0+kXpyaoZZRKgWBDY+xAs61cRL/qD/VG+azLZ9kUJZ4ejE7PYKtnPtwZFYhwLfPfz7q1qe3yqSzDTw9KqVIsvTKe6XkTOistsNo5cyznmOByffnXVPssqJE+ijVAfNzRB/vPed1d9oMBqDwY1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEHZBjtl/TStSeF19sz8Q7QckgBwEtM4mC/K0g65ggw=;
 b=faXS/xdrHO3XfWwo/CXxGUJsc8niyi7GjhEsVUb9ImUEAf9FInnH4ld8UJPqebvFEgr6F3gdmUsZEAM4bhfDkiO0ieSlAaeVF2/rA3S55hR6sqlaySVuMk8nh6D67YGxdrfjfqkHUtyMPf776rT59V43kmQ7ZuqxYwcQzfa/RAJYz4Cx2WPAu+1hAWu9spMN4fXaEhwb31iozZ2IeSbF2vfGSX1RQTwrMwzCnbPHgMrCTj7BXDuhmy7QA2e1kkaw53/ZiSGTYRHbQeksZaJdF3XiM4vJ2CTYR2jMjhJ/wSy5Bv995SkPlpfd7dc8814+seNMMk2PUBzMUniK7YJboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEHZBjtl/TStSeF19sz8Q7QckgBwEtM4mC/K0g65ggw=;
 b=Fr/1PES0NxfsQpwcIxEFaBCPrhdiEl5mensMm0Ejzj6drExKiPCu9vHfnSXYlLtAJTXO7g5dT82joL4J/7/l4KDsJYL1C72clik6/D7UsrpdJiYE2E8Y4wiL7Mvv1GX2Y1+GOZTTN16qJpcqZkKnwxv2YbYTpGYry4tRT6C6GKYmZp5p40AWTy1NMsmH0dd4mW+a7vh7r9OqfvmAB+h7PH/9lKX0tZanhzyBPEimxKGLWL3rVQQjdhva3Cj3Hk163+dO+zYtIsyuxvo9thnoSLBw68JTQU0j1MeFT4eJ0K5/VB5JaynaXn9GD9iMm0zLnLknPOYvpTZ0w5maTerSgQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB8PR10MB3829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.37; Tue, 9 Jul
 2024 16:41:52 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 16:41:51 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "Kowalsky, Clara" <clara.kowalsky@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/2] initramfs-overlay-hook: Add INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 1/2] initramfs-overlay-hook:
 Add INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Index: AQHa0h7mYxhcIu99sU6Epl1ZMk+JJw==
Date: Tue, 9 Jul 2024 16:41:51 +0000
Message-ID: <981de05d3d6836ab9b8b7c15e55baa98b5a3073f.camel@siemens.com>
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240708124734.591324-1-clara.kowalsky@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB8PR10MB3829:EE_
x-ms-office365-filtering-correlation-id: 8c77fc7d-7072-49ca-6822-08dca03608ee
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZkVJZUtQL1dOR2swbkJwWVQwbkhtZ0lITURINS9CZ3hQU1JESUVJSzBnbDVR?=
 =?utf-8?B?K0FwV3cwb1NRSXRJWXE2dmx0VUJDN2hHTFJlU2pFWnVZOW9lVkJKTFBHU1Nl?=
 =?utf-8?B?Q0owVmtRc1IwR0xacnA3VTdrUUpOQ3pZdlJtQmFrU2pLclZXdm1vaHFJUzU5?=
 =?utf-8?B?amFHT0lmOTJaYVp4UzNOVnVTZm93dEhYclFpbHgyWkJvUXpZbzNHdEZsUTAy?=
 =?utf-8?B?WEFQZ0s3SXZUcGtyVCt0YkNQL1RPeC9wY29VeHowaXZlTUFjeTNOcVlvbmhs?=
 =?utf-8?B?ay9LVWZoc2Y5akMyNGxSVXY1ckpxbkhZbXdjMUZuUmRDM1UzZ2F1NzhKNm1h?=
 =?utf-8?B?QkhjN29yYm1xWU5aVEFrWGFXSWxtNjVlb1J0a29ORm42Y2Y1TlB2eXY3bE90?=
 =?utf-8?B?T0JibTB0Q21DVWZRNFRqOGpRek9JaXVQajlrTlZNaldPTllQQThEMUtMVVY1?=
 =?utf-8?B?aGgxSDRERnI5SVVnd0kxdVp2R2xyajVZcWdxRVJBaW9FRjNxd25sMFBTdGRZ?=
 =?utf-8?B?U2tqR2twV1J6YkRna04xWG1yRzR3R1RYV0NUanJUbXpZNWZ5cCtPYlVJeEJo?=
 =?utf-8?B?TDNjRmhxdllmOElUU0JNKzdWMnFxQnp4QkFOSWl5eGNMbE1vWStVclFmZmZa?=
 =?utf-8?B?OWVsYXlxU3NrWjdVaUtWRythYzc2YVEvQkpMUUlDcjR6RU1UWXIxNHVZOVZ1?=
 =?utf-8?B?VzNhRmdWMzBJc01sSUFMRHJDQ0VPcjZ6ZXlkdUYydlRZeW1iZ0dRN2RZV2M2?=
 =?utf-8?B?TXUrQVNjT0xBY1lRbk0vZ1k5cUtBSSs1NFl0RlhJV3dNQjJGMGRsQ2QyYzlG?=
 =?utf-8?B?cU15Wk5USWtwMU9DNUtXQ3lvSGJCT3ZlSS81WVA1eHdGZ1duM1lXK0VZYmdu?=
 =?utf-8?B?aFZmdi9sTFpEL3dwc2szZURVR0JQT1NHRUNLNG9xTG1iWFpYcEV6andoWTJT?=
 =?utf-8?B?OVBFTWx4YmlJRk9Fd0ljb2tkU0tzbzNqL1BzbVJjT2FzRHpiVk05UHloN0xr?=
 =?utf-8?B?REIxN2N5d2xiNTNFUkN1QkZuMStiako3QlFFY2YyelAvWDMwSmF3bzVHMys0?=
 =?utf-8?B?SlNOS3lyN3ZUMnFCZ3dxbHVlR0VJdEE0T1NsQUNYU3o2dEIweC9QbzFNWk8x?=
 =?utf-8?B?UzRmSG1lVHVxUnVQTS9vM25KTnZCNVhuNEJxNkdaQ0RYNWp5Z3JwRjdURmsv?=
 =?utf-8?B?YmtKTC96amp2eXFZRkYvSWFYL05leG5DemhpK09Ic3l0dkVUVGFpSllRai9q?=
 =?utf-8?B?a015dkxNQlYxTTR6a3FuSGVSZ0htYTkzeGg0MXAwcVhJdTNZLzdyRGN4bjVi?=
 =?utf-8?B?VXVNN1RKZGVpQTFDZ1hyTFd1NTVxNzJnWE5WVEViS1ZOMTNHRCtGMzNpcHk1?=
 =?utf-8?B?M0ExM01mQUYzbEpMWHdZaHBQRWg4SjJYaWU1ZSszb2RISG8xY0FWU0swY1Jt?=
 =?utf-8?B?ZGJtcVFaSFlUSVpFNjU1dXRWeHpjdFVhQjJkbE43aGt1UXVqQXhuclFYdHMw?=
 =?utf-8?B?WS9pNnBkUW1OSVNlZWsyVlJhT1VGZVRtQzNid05YZ2xzTXB0MjNydUE0SlNK?=
 =?utf-8?B?NVd6d1UyK3UvYlJQazE4Z1l3dzN4RTl5dDhtVE5yR3FIWUdWRjBQQnZNWlRs?=
 =?utf-8?B?UkYxNjZYL05wL09Fek1BZmV2SmFpRDRZNGxWeVF3R2VWYnN2NGJQdXRYdlBD?=
 =?utf-8?B?YlAvZjdIQ2dDR0VuZ0xwYlNPa0ZxMXU2NmEvTndaYUtpQzFUL3UxYXJtS0RB?=
 =?utf-8?B?SjZZNnI5T043ZUU0MTFIclFQWG1pc0t1ejdxald3WmtpRmlzaUp5dnpwTkk2?=
 =?utf-8?B?dGJlcURQbVlkVmxXMFM3cDI0d0RmNS9SQlV1b1Y3ZlRDdVJXR2o3alVoSXBV?=
 =?utf-8?B?V3BZdDRzVEpwRTV1bUxabUc2MUNjYVBDUzh3QTd1cUQ1OFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N1JFdW5MU0RkUDhCT3JFdnB0YzRKakl3NXlUUDgrT3ZpVVJHNWVMK3BMcXJ4?=
 =?utf-8?B?clR0VElHRW4ySEhQbXFnb0tTRThkQ0k2U1VXV1QxSjAvYnh3K1NIWWttYlBJ?=
 =?utf-8?B?VCtIZzlRa1ZoVkdvY2pSeE9hNkFhb3hVNDh1S3VYOU50ZWJXWDFpVmpVSjly?=
 =?utf-8?B?WlhVQm1oNmhUNGlkTW5FTTFFeExoMlFWVmp1SEZySUVGNHJEZEluaExDc0sr?=
 =?utf-8?B?Z2diOVBzYWlxL1h0MHV3cjV3UDFzMmxKb2s1MW0wUXdTSGVPUHA0TGVzejE5?=
 =?utf-8?B?eGpLaHFJcnQ2VTQxUnNlV003Y2h6MlAyaG5nVW9vT1doM3NQVkJsTm5HYVhy?=
 =?utf-8?B?WEt3QzFLb3VZa2lwSnZ0ZVNhcElnNXgwMnZsbk9TNDRmWThOOGlUSnIwczNT?=
 =?utf-8?B?VWZnR3VyZmR6K2FrL2cwN3dNeWRJbS94YnR1VkZteGR1eFlLY2RoVU10a0ha?=
 =?utf-8?B?VUQ5L3BwaFk2WTlLbzQwY3kwUWNBM2RUa0dINE94c2dJQ0tXQXB5QUE2ZXpK?=
 =?utf-8?B?TWtFTm5TY0JIWE0xaEE0bjNia3NUZEFkcGVUejFOUDFxU1JpeDI4SzFUZTJK?=
 =?utf-8?B?MzlNeGo5anMyY3A2eVlZVDBZYXA5S2NNOHdLUEJxY0VjUDdIanVodmk0TTZW?=
 =?utf-8?B?V1lzMGRnUEZPQ3MyM3VGcEp6WnpRUWZjdThaWWtlZysxTXJhVldNN3hQOHVk?=
 =?utf-8?B?cW02bUpHNDVvOUxHRW9vQ1lIWUJqM2tpcExxcGluOE5TOTJwQ3l4YXFPWUxO?=
 =?utf-8?B?aHFXVjJReVVFYUlMRnZERGtKWFVEU3RLakF2VExXbnpLK3o3K1k5M0Qybis2?=
 =?utf-8?B?YUV5WmxRZjRFMmlVWmRxeWFCMGJsUEZXRncrWTc3eEpvZjl4aTBoazExQ25N?=
 =?utf-8?B?Vlp2RkZSWXozaVlHU2c3MnplSGxnc1VGWXk5SDEydFFoZVl5L0RjTlNtcGhJ?=
 =?utf-8?B?NEpVRERyVERybFJrZUFTVXNKNjBpUVUxTmhUZUU3eHByWjE0Y3RaOXZmQ3ha?=
 =?utf-8?B?a0hwQjlwUG0raEhrOWNnNkdPZ2RyMm1hRWRSZkloaXVnZUtkRlBZaTZvbFpj?=
 =?utf-8?B?dWJwWHVKSm4rU0dBVFZvSFdSNFFYR3UreDhtQWRtd3I2eGhPSWVNNU56YSsz?=
 =?utf-8?B?S2VoUmdkc3NuaGFqa0VPTHd4a3FUeDIrOVU1R0NFc09rVEJ5eGNYamtqNmgy?=
 =?utf-8?B?QzdqZFFpcDc4cnd0dG9Yai95aUhtYlZNT0twbDIvYmcrQWo4T0JaNDA3Uk1t?=
 =?utf-8?B?UHlsTWs1YXRJOHg5TSs2ZVRvNUFKLzQxei8rSmxGS1VPbmRYMzBqNjJ4RnZp?=
 =?utf-8?B?aWVhT2lXdkVHRzE1cEg3RXlXdjV0bFZSREFTUG5JZ3dGNDVJb1dRNEFmc1Jr?=
 =?utf-8?B?TmJrdFpudytZSVpySmJCT0ROc3VTY0sxZDRVU1JpMDFIaUVHSzBUSkcxU1U1?=
 =?utf-8?B?Q3BCVytycHp0YlFhNU5ZSXBQWlkzczFpTGVpY3dKOW1SMWZYMTlQcUtmZE5X?=
 =?utf-8?B?VnJOWURvMzFkcXU0TVl3bFlZN3N2VmRuMGtHdTM1VGxtSHNldDhPQi8yTE82?=
 =?utf-8?B?ZkR5c2I2RmVwQ2xZWm0rWEVoODMwQmNrWll6TlpPa29nWU5YcE5mSW1JbjhH?=
 =?utf-8?B?TXNWQ2NWQnJWWTNpdjNXNEFDUmJEV2NVbFN0cW9aSm16YjV2Z29wZ1NLUlJG?=
 =?utf-8?B?VEMzTEZyNko5WEhUNXUvbTg3QS9HRGhKY0VvQStiaTV1OWRNODFhWHhRcHVG?=
 =?utf-8?B?ZzVXUDFqOTArcHc5aTZTUjlXZW85YytwOFdmUmZYdXNsTHo2M0VWV1V0NW1T?=
 =?utf-8?B?aHlGaThmajlJK3l3WWNmb0lVN3NFZkJFL09JRUpFdUUzeXJMS3dIa3JzTlBU?=
 =?utf-8?B?MnRjQ1dhMVlMKzNURnBKZHBWa1o4UDA1L3U1VEZOVDBWSWxSYjhZWnk2VDB0?=
 =?utf-8?B?R1dHZytSb3lGMVdaRk9qOWVNVnJBRm5QRnRKQWFjZlpmVjVSU0l2aG5adlpL?=
 =?utf-8?B?THhEb2htNGFtbWtjS3hTMjA5ei84NTZxN2VlMjJYbjdpRERpRUpUMXRyRFg4?=
 =?utf-8?B?TUZacXlxTkJsZW9YSU95dEZveXRmNDVQSmY0Um1RaHJTYzg0OWYzVVZpWFZ1?=
 =?utf-8?B?SzJESllTOXB1TGNQdmhwMDFrMjNDejBXblRwd1hxeUxRN2xXMGZ2bVhzQTh2?=
 =?utf-8?Q?x5crZm6ltJAF3Yt+wD5qb9Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c77fc7d-7072-49ca-6822-08dca03608ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 16:41:51.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAiAKJwQ8OSyuN7MyOM6wJO1RjUzdeBT4SCMuFYsql/+5PFuWNqXgjo8YtGXeviO5DXRSpdbPSWt7SHyJQ+CvV3xwPss4yDKlhk3khkaivY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3829
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEF4819E0A267446963796704ACC0783@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 17:54:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16443

T24gTW9uLCAyMDI0LTA3LTA4IGF0IDE0OjQ3ICswMjAwLCBDbGFyYSBLb3dhbHNreSB3cm90ZToN
Cj4gVGhpcyBhbGxvd3MgdG8gc2V0IG9wdGlvbnMgZm9yIHRoZSBtb3VudCBvZiB0aGUgb3Zlcmxh
eSBzdG9yYWdlDQo+IGRldmljZS4NCj4gRm9yIHNlY3VyaXR5IHJlYXNvbnMsIHRoZSBtb3VudCBv
cHRpb25zIG5vZGV2LCBub3N1aWQgYW5kIG5vZXhlYyBhcmUNCj4gc2V0Lg0KPiBBcyAvdmFyIGlz
IG5vdCBpbnRlbmRlZCB0byBzdXBwb3J0IGRldmljZXMsIG5vZGV2IGlzIHNldCB0byBlbnN1cmUN
Cj4gdGhhdA0KPiB1c2VycyBjYW5ub3QgY3JlYXRlIGEgYmxvY2sgb3IgY2hhcmFjdGVyIHNwZWNp
YWwgZGV2aWNlcyBpbiAvdmFyLg0KPiBTaW5jZSAvdmFyIGlzIG9ubHkgaW50ZW5kZWQgZm9yIHZh
cmlhYmxlIGZpbGVzIHN1Y2ggYXMgbG9ncywgbm9zdWlkDQo+IGlzDQo+IHNldCB0byBlbnN1cmUg
dGhhdCB1c2VycyBjYW5ub3QgY3JlYXRlIHNldHVpZCBmaWxlcyBpbiAvdmFyLg0KPiBOb2V4ZWMg
aXMgc2V0IHRvIGVuc3VyZSB0aGF0IHVzZXJzIGNhbm5vdCBydW4gZXhlY3V0YWJsZSBiaW5hcmll
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsYXJhIEtvd2Fsc2t5IDxjbGFyYS5rb3dhbHNreUBz
aWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgLi4uL2luaXRyYW1mcy1vdmVybGF5LWhvb2svZmlsZXMv
b3ZlcmxheS5zY3JpcHQudG1wbMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKysNCj4gwqAuLi4vaW5p
dHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMtb3ZlcmxheS1ob29rXzAuMS5iYsKgwqDCoMKg
wqAgfCA0DQo+ICsrKy0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1m
cy1vdmVybGF5LQ0KPiBob29rL2ZpbGVzL292ZXJsYXkuc2NyaXB0LnRtcGwgYi9yZWNpcGVzLWlu
aXRyYW1mcy9pbml0cmFtZnMtb3ZlcmxheS0NCj4gaG9vay9maWxlcy9vdmVybGF5LnNjcmlwdC50
bXBsDQo+IGluZGV4IDI1NjNkZmQuLjQyZWI1OWMgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1vdmVybGF5LQ0KPiBob29rL2ZpbGVzL292ZXJsYXkuc2NyaXB0LnRt
cGwNCj4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktDQo+IGhvb2sv
ZmlsZXMvb3ZlcmxheS5zY3JpcHQudG1wbA0KPiBAQCAtMzAsMTIgKzMwLDE0IEBAIGVzYWMNCj4g
wqBvdmxfcGFydGl0aW9uX2RldmljZT0iJHtJTklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdFX0RFVklD
RX0iDQo+IMKgb3ZsX3N0b3JhZ2VfcGF0aD0iJHtJTklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdFX1BB
VEh9Ig0KPiDCoG92bF9sb3dlcl9kaXJzPSIke0lOSVRSQU1GU19PVkVSTEFZX1BBVEhTfSINCj4g
K292bF9tb3VudF9vcHRpb249IiR7SU5JVFJBTUZTX09WRVJMQVlfTU9VTlRfT1BUSU9OfSINCj4g
wqANCj4gwqByb290X21vdW50X3N0b3JhZ2U9JHtyb290bW50fSR7b3ZsX3N0b3JhZ2VfcGF0aH0N
Cj4gwqBzdG9yYWdlX21vdW50X3BvaW50PSIkKGVjaG8gIiR7b3ZsX3N0b3JhZ2VfcGF0aH0iIHwg
YXdrIC1GLyAne3ByaW50DQo+IEZTJDJ9JyApIg0KPiDCoA0KPiDCoGlmICEgbW91bnRwb2ludCAt
cSAiJHtyb290bW50fSR7c3RvcmFnZV9tb3VudF9wb2ludH0iOyB0aGVuDQo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAhIG1vdW50IC10ICQoZ2V0X2ZzdHlwZSAke292bF9wYXJ0aXRpb25fZGV2aWNlfSkg
XA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1vICR7b3ZsX21vdW50X29wdGlv
bn0gXA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAke292bF9wYXJ0aXRpb25f
ZGV2aWNlfSBcDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICR7cm9vdG1udH0k
e3N0b3JhZ2VfbW91bnRfcG9pbnR9OyB0aGVuDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGFuaWMgIkNhbid0IG1vdW50ICR7c3RvcmFnZV9tb3VudF9wb2ludH0gcGFydGl0aW9u
IC0NCj4gb3ZlcmxheSB3aWxsIG5vdCB3b3JrISINCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1vdmVybGF5LWhvb2svaW5pdHJhbWZzLQ0KPiBvdmVybGF5LWhvb2tf
MC4xLmJiIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktDQo+IGhvb2svaW5p
dHJhbWZzLW92ZXJsYXktaG9va18wLjEuYmINCj4gaW5kZXggMjY5NDc2Ni4uOTU1NzQ4ZiAxMDA2
NDQNCj4gLS0tIGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0
cmFtZnMtb3ZlcmxheS0NCj4gaG9va18wLjEuYmINCj4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMv
aW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMtb3ZlcmxheS0NCj4gaG9va18wLjEuYmIN
Cj4gQEAgLTI5LDExICsyOSwxMyBAQCBJTklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdFX1BBVEggPz89
ICIvdmFyL2xvY2FsIg0KPiDCoA0KPiDCoCMgb3ZlcnJpZGUgdGhpcyB0byBzd2l0Y2ggdG8gVVVJ
RCBvciBQQVJUVVVJRCBiYXNlZCBtb3VudHMNCj4gwqBJTklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdF
X0RFVklDRSA/Pz0gIi9kZXYvZGlzay9ieS1sYWJlbC92YXIiDQo+ICtJTklUUkFNRlNfT1ZFUkxB
WV9NT1VOVF9PUFRJT04gPz89ICJkZWZhdWx0cyxub2Rldixub3N1aWQsbm9leGVjIg0KDQpIaSwN
Cg0KZGlkIHlvdSBjaGVjayBpZiBub2V4ZWMgd29ya3MgaW4gY29tYmluYXRpb24gd2l0aCBkb2Nr
ZXIgY29udGFpbmVycz8NClRoZSBjb250YWluZXIgbGF5ZXJzIGFyZSB1c3VhbGx5IHBsYWNlZCBp
biAvdmFyL2xpYi9kb2NrZXIgYW5kIGNvbnRhaW4NCmV4ZWN1dGFibGVzIHRoYXQgYXJlIGV4ZWN1
dGVkIGluc2lkZSB0aGUgY29udGFpbmVycyByb290ZnMgKGFzc2VtYmxlZA0KdXNpbmcgZS5nLiBv
dmVybGF5ZnMyKS4NCg0KSWYgbm90LCB3ZSBzaG91bGQgYXQgbGVhc3QgZG9jdW1lbnQgdGhpcyBp
biB0aGUgcmVhZG1lIGFuZCBpbmZvcm0gb3VyDQpkb3duc3RyZWFtIHVzZXJzLg0KDQpGZWxpeA0K
DQo+IMKgDQo+IMKgVEVNUExBVEVfRklMRVMgPSAib3ZlcmxheS5zY3JpcHQudG1wbCINCj4gwqBU
RU1QTEFURV9WQVJTICs9ICIgSU5JVFJBTUZTX09WRVJMQVlfU1RPUkFHRV9QQVRIIFwNCj4gwqDC
oMKgwqAgSU5JVFJBTUZTX09WRVJMQVlfUEFUSFMgXA0KPiAtwqDCoMKgIElOSVRSQU1GU19PVkVS
TEFZX1NUT1JBR0VfREVWSUNFIg0KPiArwqDCoMKgIElOSVRSQU1GU19PVkVSTEFZX1NUT1JBR0Vf
REVWSUNFIFwNCj4gK8KgwqDCoCBJTklUUkFNRlNfT1ZFUkxBWV9NT1VOVF9PUFRJT04iDQo+IMKg
DQo+IMKgREVCSUFOX0RFUEVORFMgPSAiaW5pdHJhbWZzLXRvb2xzLCBhd2ssIGNvcmV1dGlscywg
dXRpbC1saW51eCINCj4gwqANCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBF
eHBlcnQgQ2VudGVyDQoNCg0K

