Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BBC3DA42
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 08:11:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web10.9233.1720599110598417988
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jul 2024 01:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EPn48BwQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwg6f3ZBBaWWPjUHsJrMg1hUl6vOIcPmGJl6PG9LrrOZlcNmyO57qilO8Q6O+QEX0LJ8NmUYaYMcfZYBHmJn6nKzUlCBy6Uzi/VTHsa1BG5tHaBMTqWW18mOCa0Lzu3EO9ofq0hD63WSVGTrYfl6TuAZBJZ4hhuix8MqLfKcMRIF62sh81mkenJOpe5pjW9lOAO+tsdRDGT2A32R+xGWgeckqkcbOf9Gw5EQC8B+FHJctwyvQ46uMwq/98A/OLSpmKBWDL0uBaIm6rxg2LRvvHiAFmrmeNTfkQF6iEnmjRCJkx2RgLwPqjYh++jMEs5Ubm+vOICdzOjDGz0nVGVRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJyj0Zs/L1J/sDbWaYRw/iGyWtQxMpWjhW2rjkGsblE=;
 b=Y+vUYiRzER+3Gn2Gx72PbR16t0hFz106Ke89U4EkV3eVdjp+tX/xet6+IMeTly62qJruFb4ZMp/UBFX44BhZuZBDSV8PmVSBIDTccAmRZfg5x3+KY2IOodNPAddcm9xCkZMiLPWVLI/KzKjdEzPIHTYGzI89dKl+KiVK+vZm8sgQwu0jcxYnK1azoA4EOY1hskuq9Dgsg7ln7jpR1f+oQ+3mpHYLSAOZLRK2xJoePqGv3BVZzm3IInoxElkp72AvkMiyBcm+go8JrYXHD3UFJ6OfMoYdGX96ieFj1XyLCIO/j0z+G0Ef5QLdq4erwUSccXI7IRs00XCh24uK7cEIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJyj0Zs/L1J/sDbWaYRw/iGyWtQxMpWjhW2rjkGsblE=;
 b=EPn48BwQQ0seSFvChX9112Xf9J/mHq41jwhXCQLXF0qS7xbAfIY1bs0e3whS5e0GNx4wqBhhYaesVb7Epv9O9xN6GEZiuV93+v9BY4PJLoy5EBEu0DaDnXCecoBfFZqgKXhNBGhfoI3vMuGqBiKAqNrT/ssNj8SI28NlQCJ8oxMjhUwpDeutNbB//PE1ay9S3b6mD+7TBKynzetKcs1YKIElkOXS1Rn+tH5NviNws3Z2o8SNKzw9FyP/1k0+V3W37asCKxpw4d41GlXHhgUOz3qmh6iM6WpK0liS4yQFRECcECzrf+JVA1cIvbAeLqwvGAYWBy0FPlsxmFWE7Omtqg==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by PA2PR10MB8617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 08:11:47 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:11:47 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev][isar-cip-core][PATCH v3 1/2] initramfs-overlay-hook:
 Add INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 1/2] initramfs-overlay-hook:
 Add INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Index: AQHa0TUEuVh6UHylSEqjjOl9ymhYtbHum2GAgAEDZvA=
Date: Wed, 10 Jul 2024 08:11:47 +0000
Message-ID: 
 <AS5PR10MB817307EACB90962B68F3B5E093A42@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
 <981de05d3d6836ab9b8b7c15e55baa98b5a3073f.camel@siemens.com>
In-Reply-To: <981de05d3d6836ab9b8b7c15e55baa98b5a3073f.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=75ede5d5-19d9-47dd-b42d-b94e2f6b4e54;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-10T08:10:15Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|PA2PR10MB8617:EE_
x-ms-office365-filtering-correlation-id: e7c1b356-2f42-4d3a-99ae-08dca0b7f1e4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SjdmTlZRMUZSdFg4NHNyblBoQURqTGVpNmdUUWZKUHAvVk4vUVlKVnVxTU04?=
 =?utf-8?B?UDVDU2NVQ0h1aitPWHJZaThoYjZ4VkhJcU5rNHVkck9McS9ndFdoMk94TmRo?=
 =?utf-8?B?NGJrSU5ia21aNEsyV0JMUUVWbURCNlNkUjFEUGZmbjNjeGRXQlhLNUgyNFN0?=
 =?utf-8?B?WXBaZThmWlNqbkVyNWh6TzFYTmUwT3B1TUt2TmM1c3JPa0g5MENzZVlKWkha?=
 =?utf-8?B?RGZjdnErVGVhYmFETko4RG1XVDZnYU0vTkhtZ0hzcDNKWGtOU1FVNitTb0xK?=
 =?utf-8?B?czVVT0E4eVZiVlQ3MW1SRjMxV3c1L0N4a2ZFMkFHcmoxTGc4MDIwVzdWYll3?=
 =?utf-8?B?a0xYTVBaRGFzejhuT0lEYXVOazBlZGdTc0dmVVZOSW81bndjMDZ0bkxpK0xJ?=
 =?utf-8?B?SE41RDBpbnhaakVrSkFGaUhrTG1udzVsU0xtT0ovNjk3Q0JYM1dWZ2NXSGxX?=
 =?utf-8?B?dUJQaklmYXpleVNzWnZ3enJXSWFLa21Ldnl1eXpWMGw4Y0p2Q3hzd2h5SVEr?=
 =?utf-8?B?U2ZOUkYzb2ZscFBtYjJncXQ4OGtoNndEYW0ySTJUcUZhNmFiMXVjeWg5Nmw1?=
 =?utf-8?B?blFYUkhOTUxBbTRlcnVWNm1OWjVFcXc4dk04anprUnRPc2dHY1RKMHAxN0Va?=
 =?utf-8?B?Z29VWS83N0lrVk91ODZaTVhiSis3eFRGUUZsUENKbFZIbExQTWZQeVV3QzlM?=
 =?utf-8?B?cnB1aWFmaUd4L2RoZElzaTJQaGQwUTlZazZPOGxnUVhFVGltd0c5V2tlZWl2?=
 =?utf-8?B?Z3BOazhVQ2tuU1FSeGdjTmRieFBmTVpYN2xROTNHaDVjQ2w3VjJFMzFHVmxa?=
 =?utf-8?B?VUVld3BSN1lGRjNIQm5VQmpGanRoU3VCWUJMZ0hkbW9tM0tVQmtkU1BMMnVi?=
 =?utf-8?B?VlhKeWp3N3VMT2dVZStPRk96M1o3S0RMT3NNbzNEN1lqSFBUclBRQzBRZ2dF?=
 =?utf-8?B?Wjhzc3pZSFpxanNYSUhVUkMxcFlyWlhzNVJqQ3h4QmVNRjNoSnJEWTU1ekFr?=
 =?utf-8?B?MnVSTk5wVm4yRXhYVG1mQXJCMk1rMll0NmtQM2ordjFlNFhjZk1qNVd4VURl?=
 =?utf-8?B?dlRycVpITy9OdVU4alkwMFpnWjBKMU5jYzl0Ty9xRTVXby94QXRTWEk4V295?=
 =?utf-8?B?bVprLzk3MDdlMUwxMDZySDJIOXJOVEJpNXpkZDhpdlo3S1V2ZW52ODBvUm1a?=
 =?utf-8?B?dDV3dkZrQXVDUkI3LzBPN2psMFRlUDRFa0dEQ1JPbWdRclU4dVdLazVkOE5t?=
 =?utf-8?B?MjV3WmMrczlHWTlabVhUam1ENEptaHF4cDltNXU3V0ZDQ2dUd1o3aDRmR1li?=
 =?utf-8?B?MVhidGMwSVQvLzl2SHMxZ2pLYVdtSjlLc2hwck5iN004K1RkV3c0eFF1Q0NL?=
 =?utf-8?B?cXV6UUdQK3pVM094ZUVUd0NkUmk0UHF3RzR2TzFLWHpROGtRZ2wxZ2NxVlBS?=
 =?utf-8?B?WWUvY1kzaDByTFNPMnRuZmJsd3NweGk2ODArWEM5NmtXZkxrUkxhUTh1U0tP?=
 =?utf-8?B?YURSWHJ2TmJqa2dnNVJTM1FXVmlGY3VwS29HKzBDMjJKSUl4ZVBvUFBUYUF3?=
 =?utf-8?B?TldnTkVFUHp4VXd6NlRWbWZ3eVZWWk56eDJGTkVRYUc5TzRKNzBzYmIrUUR0?=
 =?utf-8?B?MWlYZjRRcVIzQzFWR1prSmNjTDdpN1o2MDJwUm9BSzFRY0FTMHdySUFoWlhC?=
 =?utf-8?B?MnFIbWYzc1ROUEpsSjNFaVBkTWs3bE8yYWp3bzA0bnFRMFJUTEl2TW1YRXEx?=
 =?utf-8?B?V2hKenZlbkpPTk4zamdodTQyYklNRUNTdWlLM2xFYnlnRk1VSjNVcE5LdG5q?=
 =?utf-8?B?amlibnUvUHZqR2lUSTN4OGMzaWVlNWFobkRyQlpUTndNTWM2Q1hLeXRFVmV0?=
 =?utf-8?B?dk1JT3dLSkp4U2tKeWFudlBaSTBqVlVTVTdtcG9IMUFPT3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eE9USURsOFFDZW1OeUxlc3VHM0h5b0RIcE0yc0kyWFhmZ1J0Risxc1NDVFVq?=
 =?utf-8?B?eDFoRnNTWlgwbm81NjdqR0pSN2pCWFpoWlJYRFFGK1EvM0ZNNU91YVBLMUUv?=
 =?utf-8?B?ZnFMbXFEdEV3NVR5SEZnTTlDci9hWU1vVklDWlBNZHpOT2hxTEZxemFSaFVD?=
 =?utf-8?B?T1B4UUNWaGxwMmhOMFcxN3FKZkNyam1kM1JqSzVUdnNQNEd3ZmtsM1pKVzBC?=
 =?utf-8?B?QzVGakQvQjhDMXYrWEcwaEQvZXYraFByME9VaUNyQlU5dDNYQWo0ZVYyaVJ3?=
 =?utf-8?B?YTI3VjJxYnpLT20zbDdoOFUreXZEMm5hTDVLN0VCQmI5bzJtRGcyYmp4ekxz?=
 =?utf-8?B?TGtqQ1NwWUFXWnY4NHlDR3Zha1NsV1laOU1lMi9KSFdVUEcrQmQrRm81emU4?=
 =?utf-8?B?Mm5kUVc3UWt3dktLQXFycDZESGZJVGxvck1kenlPWXlQeGthTFMvZlNwQU1o?=
 =?utf-8?B?Q1NudDZFNk5na3NFT0NVc2ovZlE4S3J3L01kMmxQWHNNdXJiNTJiWWQxVW9h?=
 =?utf-8?B?Yy9rZnB0blVSU09TUHRsdmkvVDhpa1BCRWlxajdxU0FTdHNUL0RKV2d2V0xi?=
 =?utf-8?B?SHlMQlBMbEFGVzVEazk2UVVackxnMjlNQ3JIdHZSVHRvRk5VcUxQRWFMbUh1?=
 =?utf-8?B?cWdSZlFrRWZxRWF3QnBNYVc0Wk1IeXdQVlhBcVBlQll5TzhFZjhLTytDWmdh?=
 =?utf-8?B?aFlNNzFYSVpoTU1jN2txME9MOFZTUVMvdFh4MGlYRWlPRmZNZWh4S3d4VVA3?=
 =?utf-8?B?ZnF4aUl6ZHJuOWJBdFh0dVRQcXlKT3Q1dlNWSklNUE5UVEs1cmF2OTRCbEk3?=
 =?utf-8?B?dEtGdXRVMmZmV3pORlJlTHBNcGdRNXd0a3F5VklEbWZraGxVRlJ5QmhLNFFQ?=
 =?utf-8?B?WEZyMmdEU2VTcEtYVHh2ZEF4bGFaSGhieWUrdG9DUGkyUzRCaFZqTGZ3WjM1?=
 =?utf-8?B?TmlEcmh1NHJoNTVTOHJyeCtseEZvVGlmdXBobjV3R09MbjVLa1doVlg2alJL?=
 =?utf-8?B?VWEvN3h6QThTT2RTRDl2ZUdQcjZwcEZyclRlSGxOdHpRRnhnblFLUHlOemdM?=
 =?utf-8?B?RzhMUHlDcEpwUjhEeTZzV2c0OXpvY2d1eUswNGRTSExKUDRvSmoybEhxUlV5?=
 =?utf-8?B?bWoza0s2SnBQTlYvTmgrSWNKWms2U2Y4M3FNMjhYU2w2SUJPQjk3QW11QUhE?=
 =?utf-8?B?SjFGOWUvcGo3blo5T3QwcTF4TGxVVVFrNTRKYU5wZVUvMFJmRUFPcXdZQzJ3?=
 =?utf-8?B?TDFyZm5KUjk3QTVzeWFzemp0NEdmeDdYMVFQZ3BIWnpWRXpSS3BpaVQ3QjNt?=
 =?utf-8?B?QjJNQmJjLysyOXNEUk9iNXFteDJGQnJLRGZFaExBdC9OQ3dhMUNUVG5BN244?=
 =?utf-8?B?UGFnRnMvYkxoWFF4RlNiZDdxTXJaOWVhVDNDZ2pROHdxTDY0SC92VEdEQ2p3?=
 =?utf-8?B?SnYwT1ZnSHhITW43YXBkOUJQUXkxU1oyVi9xMjdWbm9PYThUdWN4SkFuSTU3?=
 =?utf-8?B?MDJDa3pVaXFzZjk5WmdqMEsxVjZsM2NnUlJSZHVKcWs4VDNmbE5XYVorOEM5?=
 =?utf-8?B?L0VvYzErT2Y0Q3RQZXNncHpBbTVoQmdMdEpML2M3UVo2Nzh2ZmNnVzJOWlM1?=
 =?utf-8?B?YVAveXVuZFJEVUxJakJsdXBYaWozWTdtQ1JwdnVnNC90aUo0Mk15bEhRVUpl?=
 =?utf-8?B?U1g4TDdJTVdkOVhyZW5wMDhRSG9MSjRvS1ovbzYwYWdRRlphQkpSYkdOYkpj?=
 =?utf-8?B?RDNMZTVuZEhVV0FLQ1U3L0krOGxiLzRNd05HN3VJRVJYeGJsaTkzcE1kUmVY?=
 =?utf-8?B?Q1hFQm45MWdmVkcrSndkSWFLT0FNVjdLei9Ib3N3ZFdHQlJBd3p4bXV6bnFC?=
 =?utf-8?B?Lys1RWtoQ0EzTTRjcnIwWWdvV3dLY2xtN3RybTBiWklSRDVvQ3JBcEpPcWtW?=
 =?utf-8?B?Uk5kVVVaY1JNL1BTS1ZHK0NaT0M5bFRrMzRTMGJBbnVEeERxOXBzSWtQaTFj?=
 =?utf-8?B?ckFyT2pPVGs0cmc2VDB3R3E0b1ZmZTV1azQ5L3RvSGhROG9TWEtiK21nUXJY?=
 =?utf-8?B?czZlMTBNZVVKRHQzd1pTVkpkdE00UExLczFPcG03TUh6MFNDeFJXMGtBSC93?=
 =?utf-8?Q?k4dQ7DFaO7ZfOzFmnP1hj5SfM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c1b356-2f42-4d3a-99ae-08dca0b7f1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 08:11:47.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w2xH7rg/bzj2ozhnSkmF01cb98Y/y4422OWxJuVOBERlSUp59JCwR4RWPCxySTdVNoTrRtxDlaLE18dce8DQb15mWpDYh0crDkWNq+H0GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jul 2024 08:11:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16446

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9lc3NiYXVlciwgRmVs
aXggKFQgQ0VEIE9FUy1ERSkgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bHkgOSwgMjAyNCA2OjQyIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZzsgS2lzemthLCBKYW4gKFQgQ0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47
DQo+IEtvd2Fsc2t5LCBDbGFyYSAoVCBDRUQgT0VTLURFKSA8Y2xhcmEua293YWxza3lAc2llbWVu
cy5jb20+DQo+IENjOiBHeWxzdG9yZmYsIFF1aXJpbiAoVCBDRUQgT0VTLURFKSA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XVtpc2FyLWNpcC1j
b3JlXVtQQVRDSCB2MyAxLzJdIGluaXRyYW1mcy1vdmVybGF5LWhvb2s6IEFkZA0KPiBJTklUUkFN
RlNfT1ZFUkxBWV9NT1VOVF9PUFRJT04NCj4gDQo+IE9uIE1vbiwgMjAyNC0wNy0wOCBhdCAxNDo0
NyArMDIwMCwgQ2xhcmEgS293YWxza3kgd3JvdGU6DQo+ID4gVGhpcyBhbGxvd3MgdG8gc2V0IG9w
dGlvbnMgZm9yIHRoZSBtb3VudCBvZiB0aGUgb3ZlcmxheSBzdG9yYWdlDQo+ID4gZGV2aWNlLg0K
PiA+IEZvciBzZWN1cml0eSByZWFzb25zLCB0aGUgbW91bnQgb3B0aW9ucyBub2Rldiwgbm9zdWlk
IGFuZCBub2V4ZWMgYXJlDQo+ID4gc2V0Lg0KPiA+IEFzIC92YXIgaXMgbm90IGludGVuZGVkIHRv
IHN1cHBvcnQgZGV2aWNlcywgbm9kZXYgaXMgc2V0IHRvIGVuc3VyZQ0KPiA+IHRoYXQgdXNlcnMg
Y2Fubm90IGNyZWF0ZSBhIGJsb2NrIG9yIGNoYXJhY3RlciBzcGVjaWFsIGRldmljZXMgaW4gL3Zh
ci4NCj4gPiBTaW5jZSAvdmFyIGlzIG9ubHkgaW50ZW5kZWQgZm9yIHZhcmlhYmxlIGZpbGVzIHN1
Y2ggYXMgbG9ncywgbm9zdWlkIGlzDQo+ID4gc2V0IHRvIGVuc3VyZSB0aGF0IHVzZXJzIGNhbm5v
dCBjcmVhdGUgc2V0dWlkIGZpbGVzIGluIC92YXIuDQo+ID4gTm9leGVjIGlzIHNldCB0byBlbnN1
cmUgdGhhdCB1c2VycyBjYW5ub3QgcnVuIGV4ZWN1dGFibGUgYmluYXJpZXMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDbGFyYSBLb3dhbHNreSA8Y2xhcmEua293YWxza3lAc2llbWVucy5jb20+
DQo+ID4gLS0tDQo+ID4gwqAuLi4vaW5pdHJhbWZzLW92ZXJsYXktaG9vay9maWxlcy9vdmVybGF5
LnNjcmlwdC50bXBswqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArKw0KPiA+IMKgLi4uL2luaXRyYW1m
cy1vdmVybGF5LWhvb2svaW5pdHJhbWZzLW92ZXJsYXktaG9va18wLjEuYmLCoMKgwqDCoMKgIHwg
NA0KPiA+ICsrKy0NCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJh
bWZzLW92ZXJsYXktDQo+ID4gaG9vay9maWxlcy9vdmVybGF5LnNjcmlwdC50bXBsIGIvcmVjaXBl
cy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktDQo+ID4gaG9vay9maWxlcy9vdmVybGF5LnNj
cmlwdC50bXBsDQo+ID4gaW5kZXggMjU2M2RmZC4uNDJlYjU5YyAxMDA2NDQNCj4gPiAtLS0gYS9y
ZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtb3ZlcmxheS0NCj4gPiBob29rL2ZpbGVzL292ZXJs
YXkuc2NyaXB0LnRtcGwNCj4gPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtb3Zl
cmxheS0NCj4gPiBob29rL2ZpbGVzL292ZXJsYXkuc2NyaXB0LnRtcGwNCj4gPiBAQCAtMzAsMTIg
KzMwLDE0IEBAIGVzYWMNCj4gPiDCoG92bF9wYXJ0aXRpb25fZGV2aWNlPSIke0lOSVRSQU1GU19P
VkVSTEFZX1NUT1JBR0VfREVWSUNFfSINCj4gPiDCoG92bF9zdG9yYWdlX3BhdGg9IiR7SU5JVFJB
TUZTX09WRVJMQVlfU1RPUkFHRV9QQVRIfSINCj4gPiDCoG92bF9sb3dlcl9kaXJzPSIke0lOSVRS
QU1GU19PVkVSTEFZX1BBVEhTfSINCj4gPiArb3ZsX21vdW50X29wdGlvbj0iJHtJTklUUkFNRlNf
T1ZFUkxBWV9NT1VOVF9PUFRJT059Ig0KPiA+DQo+ID4gwqByb290X21vdW50X3N0b3JhZ2U9JHty
b290bW50fSR7b3ZsX3N0b3JhZ2VfcGF0aH0NCj4gPiDCoHN0b3JhZ2VfbW91bnRfcG9pbnQ9IiQo
ZWNobyAiJHtvdmxfc3RvcmFnZV9wYXRofSIgfCBhd2sgLUYvICd7cHJpbnQNCj4gPiBGUyQyfScg
KSINCj4gPg0KPiA+IMKgaWYgISBtb3VudHBvaW50IC1xICIke3Jvb3RtbnR9JHtzdG9yYWdlX21v
dW50X3BvaW50fSI7IHRoZW4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgISBtb3VudCAtdCAkKGdl
dF9mc3R5cGUgJHtvdmxfcGFydGl0aW9uX2RldmljZX0pIFwNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC1vICR7b3ZsX21vdW50X29wdGlvbn0gXA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICR7b3ZsX3BhcnRpdGlvbl9kZXZpY2V9IFwNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAke3Jvb3RtbnR9JHtzdG9yYWdlX21vdW50X3Bv
aW50fTsgdGhlbg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFuaWMgIkNh
bid0IG1vdW50ICR7c3RvcmFnZV9tb3VudF9wb2ludH0gcGFydGl0aW9uIC0NCj4gPiBvdmVybGF5
IHdpbGwgbm90IHdvcmshIg0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtb3ZlcmxheS1ob29rL2luaXRyYW1mcy0NCj4gPiBvdmVybGF5LWhvb2tfMC4xLmJiIGIv
cmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktDQo+ID4gaG9vay9pbml0cmFtZnMt
b3ZlcmxheS1ob29rXzAuMS5iYg0KPiA+IGluZGV4IDI2OTQ3NjYuLjk1NTc0OGYgMTAwNjQ0DQo+
ID4gLS0tIGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFt
ZnMtb3ZlcmxheS0NCj4gPiBob29rXzAuMS5iYg0KPiA+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZz
L2luaXRyYW1mcy1vdmVybGF5LWhvb2svaW5pdHJhbWZzLW92ZXJsYXktDQo+ID4gaG9va18wLjEu
YmINCj4gPiBAQCAtMjksMTEgKzI5LDEzIEBAIElOSVRSQU1GU19PVkVSTEFZX1NUT1JBR0VfUEFU
SCA/Pz0gIi92YXIvbG9jYWwiDQo+ID4NCj4gPiDCoCMgb3ZlcnJpZGUgdGhpcyB0byBzd2l0Y2gg
dG8gVVVJRCBvciBQQVJUVVVJRCBiYXNlZCBtb3VudHMNCj4gPiDCoElOSVRSQU1GU19PVkVSTEFZ
X1NUT1JBR0VfREVWSUNFID8/PSAiL2Rldi9kaXNrL2J5LWxhYmVsL3ZhciINCj4gPiArSU5JVFJB
TUZTX09WRVJMQVlfTU9VTlRfT1BUSU9OID8/PSAiZGVmYXVsdHMsbm9kZXYsbm9zdWlkLG5vZXhl
YyINCj4gDQo+IEhpLA0KPiANCj4gZGlkIHlvdSBjaGVjayBpZiBub2V4ZWMgd29ya3MgaW4gY29t
YmluYXRpb24gd2l0aCBkb2NrZXIgY29udGFpbmVycz8NCj4gVGhlIGNvbnRhaW5lciBsYXllcnMg
YXJlIHVzdWFsbHkgcGxhY2VkIGluIC92YXIvbGliL2RvY2tlciBhbmQgY29udGFpbiBleGVjdXRh
Ymxlcw0KPiB0aGF0IGFyZSBleGVjdXRlZCBpbnNpZGUgdGhlIGNvbnRhaW5lcnMgcm9vdGZzIChh
c3NlbWJsZWQgdXNpbmcgZS5nLiBvdmVybGF5ZnMyKS4NCj4gDQo+IElmIG5vdCwgd2Ugc2hvdWxk
IGF0IGxlYXN0IGRvY3VtZW50IHRoaXMgaW4gdGhlIHJlYWRtZSBhbmQgaW5mb3JtIG91cg0KPiBk
b3duc3RyZWFtIHVzZXJzLg0KPiANCj4gRmVsaXgNCg0KSGksIHllcywgUXVpcmluIGFuZCBJIGNo
ZWNrZWQgdGhhdCBhbmQgZG9ja2VyIGNvbnRhaW5lcnMgYXJlIHJ1bm5pbmcgZmluZS4NCkNsYXJh
DQoNCj4gDQo+ID4NCj4gPiDCoFRFTVBMQVRFX0ZJTEVTID0gIm92ZXJsYXkuc2NyaXB0LnRtcGwi
DQo+ID4gwqBURU1QTEFURV9WQVJTICs9ICIgSU5JVFJBTUZTX09WRVJMQVlfU1RPUkFHRV9QQVRI
IFwNCj4gPiDCoMKgwqDCoCBJTklUUkFNRlNfT1ZFUkxBWV9QQVRIUyBcDQo+ID4gLcKgwqDCoCBJ
TklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdFX0RFVklDRSINCj4gPiArwqDCoMKgIElOSVRSQU1GU19P
VkVSTEFZX1NUT1JBR0VfREVWSUNFIFwNCj4gPiArwqDCoMKgIElOSVRSQU1GU19PVkVSTEFZX01P
VU5UX09QVElPTiINCj4gPg0KPiA+IMKgREVCSUFOX0RFUEVORFMgPSAiaW5pdHJhbWZzLXRvb2xz
LCBhd2ssIGNvcmV1dGlscywgdXRpbC1saW51eCINCj4gPg0KPiANCj4gLS0NCj4gU2llbWVucyBB
RywgVGVjaG5vbG9neQ0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo+IA0KDQo=

