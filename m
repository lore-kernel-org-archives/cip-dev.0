Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8CC3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 12:00:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.60])
 by mx.groups.io with SMTP id smtpd.web11.36177.1721044835340349686
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 05:00:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UgnPGjjS;
 spf=pass (domain: siemens.com, ip: 40.107.241.60, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMh/dnm5UwyzIzLU+mr9WDax4wBi1Ck7s/mDDrBjBOxcmoOkyutiUWIYhNm/rL8YJ1ZR846DGKVvRVSETNFqwvRXAm4WXaBuYkkJE/nttuRRHK4edaMw8bklBE0bzDd0DsFo1YOrv23lw4eVNyVb6J4nMOwyx29QU3Ia7vr0ARXG6fkr+xdLo5Zc1hlu34Muzr7Qf9Mg9rMmhfSkI5dGkrPnqz1cPEv+REELOvx144YiSSBmDTB3wX89E6dKbB25/Z40VHkuX4yWzxYgkX6p7mS2DfUkCv1sFGoyE6nPhfnXbphgF+YzuvJEvL5/q9mKG43LSnqYDMstmDnoOmISlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6LI0/RIou2nuMRaTb+GqoVMUzdLJSY+/Fp8gOQkt4s=;
 b=I5nNZIiplXWHGrgnW2bGrgeJDVzcdp6QX54ZqeAcBVAtl1LoTFxEOvGv0DjWc04G0DXEEpWixciBxVbcDT9His90Vb5VJOkZ+JMvhtg45BoAQo7ceNdBSkMYpZbY5j/z+qHoAgyX7z64D0Vb6J5p56fmdOEYrACISTTo/HypjRFL2VvBKshnSb3JpbPiTrb7yjRmui3+I6qMgvxfzq6EIrueqiSeqUJwB0cNwlTEIKmF4ludGwZqfoTkOInE6Dxa1kgEM7vy3S1ofyxzjGCuTMDTewNRh40H7YyRz9MPhR0qBgbs5apNQ1bC76AKaWjjWcg99TrC8ixPkME2676Ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6LI0/RIou2nuMRaTb+GqoVMUzdLJSY+/Fp8gOQkt4s=;
 b=UgnPGjjSDbPwk7RgveIdIuqTn/Z9cMPNE76dZHQFCik2bSctPyd0s4rzEq+CR0tfgfR3qbKe0GQEakokqpBJobkDpilsH5MVpRcR9U0vZoSI8zlqBMehKSOyGvmRd6l89mAX/Cgi1scUZFNvXRLzCaDJCUnnhK3Wq12Q6DULtTgpd46kNLxih6d/KVElV4gTaqakJN9Tp/6PyLW8rw+ETjoBZ8qj8N8/Jy29R+TeyZer0dcD9z88kAaJfdSJJndA8dN8e0VD5rs6NIZgQ7okz5ZDaYxEiSQaUkETIYeq/Kt3+kliBUfIYG4XkpX2PW1Sr+/kkGPMp3S+9OVnpTdirQ==
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PAXPR10MB5567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:00:32 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 12:00:32 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup
 executable
Thread-Topic: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup
 executable
Thread-Index: AQHa1povuChslToM3kGsN9guz/Q0HLH3n2QAgAAQloA=
Date: Mon, 15 Jul 2024 12:00:31 +0000
Message-ID: <60345d8f9471d087dc866f56688421232a5c3c12.camel@siemens.com>
References: <20240715093424.632716-1-stefan-koch@siemens.com>
	 <c183806d-c3a3-4860-a8f3-a4e4c12c82f3@siemens.com>
In-Reply-To: <c183806d-c3a3-4860-a8f3-a4e4c12c82f3@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4953:EE_|PAXPR10MB5567:EE_
x-ms-office365-filtering-correlation-id: f0388d4b-92f4-46d4-e2e8-08dca4c5ba3a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?blFJeG85cXhmZ25DSnZMT3hnVzh1YTFrOGRKWklmcnAvcGNHTTRUMUhZd1Yw?=
 =?utf-8?B?VUNPdE0ydnA3alNHZXBTdUIvRmFTZWRwSDF1elhLVEI4U3d3Vk52eURNMGdt?=
 =?utf-8?B?QWFPTXQwQnNuZDVudlVWNldTc2JIL2Y5OGt6aFM1L2FsL0FZNCtwVjk4T1dr?=
 =?utf-8?B?eStsMFFKMkNVNDNtSXZBQ21lQ09JZ0ZselRUTm1sSVErUEpRRU1BdmEzUjhS?=
 =?utf-8?B?RXU3ZWo4Z1c0RUxyVTlQN2t1UXJTT09MWXVWTlRZd0hEQzY0RU9oWThNUGlY?=
 =?utf-8?B?dmRIUDdXR1YyakFQNk91QkIrZE5tMlp6UElsbERKRm9FcDR4YkF4TmJ2M0Yw?=
 =?utf-8?B?TFM1bXpXdHh3RkI0UnN4WHRhNWx4M042eDQ4WlBCQzZjMjFLOUNLaUQ2VDZv?=
 =?utf-8?B?aTE5OU9lNFdGc2dySXZwWjA1RXp1TDNNZmZ2M2g0Y0NJQVpldG9ka2Y1Vzhl?=
 =?utf-8?B?MGgzUlFwV2pUQVBFT1R5RDdiUk1sWi9JUW8yVGZoaEtlQThDZXN2Q2pVWGZl?=
 =?utf-8?B?SmVpemo0RTNMN3VNOXhwRDJOQ1FmREtoWkRYaHJ2Zjhnb3ordkVFaVN2NC9C?=
 =?utf-8?B?SVh3U3hodVFEVkRuWk93SU9CUEx5Ti8xcTVBSDc4cmRXZ0tOWWRtVkF6Y2xy?=
 =?utf-8?B?dm40d2liVDhJS3RHZ21sL1NMRTJ1ckx4S3hLMCtGaW1rUW5sc3BORjArMllp?=
 =?utf-8?B?UzhtZzhPTXNLMXR5OG13K0lBaU03eENyMUVvVTE4SHp1WThicmZRdDlyM2g2?=
 =?utf-8?B?NTFiNHdKUSt4OExlMElMUll3VGFIMFVYQVlGUlVIMnFUaDlkdDdBdCtoS2Qr?=
 =?utf-8?B?dnFjdXdHUGVyOVd6Vkd0Uk9VbDVOYkNPLzZMNVVEcW9WOFUyVGFMZndXZm45?=
 =?utf-8?B?aTM0UkhHUlhYMW43VUphemFGaURUenEyTTgybWlrcFZUSkhqZUh0akFPNDIw?=
 =?utf-8?B?T0J6TFA4Tmlacy9xRGZWRjk5TXA5YnRXRXA5RE1TQWhqZTl4UFBQNUhTTllr?=
 =?utf-8?B?SGoxaE5NWlUxRnA2K2RMWFNEZitVeFJ3K1Bsd1U0YnkyWi9OaE1NSTg2UmFh?=
 =?utf-8?B?dXFrYUwvTCtkbDV2YWgwU09QSGtIOThDaUlhbHlkTjd4eDZHK3R2bXVQN3Bx?=
 =?utf-8?B?dHBxamw1RGxBNUVidXN0dHNBaUgwSEY1QnJMSUJudHl1eGtSZEorL3QyVnFi?=
 =?utf-8?B?emRuZ2xmcVhHUFhLVFZ2U1RMUjB2dWI1T3QwUVBJOHdtTk1oSmJpTitaVHQ2?=
 =?utf-8?B?Q05XeVp3VENhSlVMdy9tT3JzbWREOVFaKzU2OVlYNGEvaW9PMS9oR1RlVDJJ?=
 =?utf-8?B?QUpMWW00RkI1MmJ0cHdlK3I5VjhSMWs0RkZQdWZUWEcyc3JlUnZNellpRHN1?=
 =?utf-8?B?OG9DNGJ0UHB6UTN5dHJldHZieS9FS1J6dlA4YjlUbnp0Tk9mNk1JVC9KN2pt?=
 =?utf-8?B?TXQ0TjRuQW5NeWVqVTcwS09yY2dUZnhvZ2V6WGdYalVZSHQ4TFJ1ZWdScDRY?=
 =?utf-8?B?OVNFeTVLaVNNL2IzL2pnNmlWcEs0dTFGc0U2YXp3dDhueDM2L0dCZGtkTWNm?=
 =?utf-8?B?djkwNEZUWUNVajMxZ0ZMYWRFT1RkVExnNTEvaW9BK3M2eTFwa1dTTC8wd2FM?=
 =?utf-8?B?cFlvVGM0azJMYUpxVnJBM2dBaEM4ekc2S2hJWHJibDlpL1Zzb1NLTE5YNGpF?=
 =?utf-8?B?WjVtVW5iQ0VNSlFmQmswK0RXbnpCRS9QcXl2RE8xUTZDdXNiWXVtYWNQa0hl?=
 =?utf-8?B?L2Y1TlhYZjE0SFBZTWxFRDJxYlR1WHBNWjhQcFNrYiswSFhZU0RjYUJnQkI2?=
 =?utf-8?Q?7SYCEZiDfSC0zfouwlo1q0aPqtlcGkED+jiCg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUxnUVdMQk9id3RSaktLM2p0YTgxYnhjVGhCakMrZSsxcEF4KzlOM0FxSitV?=
 =?utf-8?B?RHVPbUgzN0FMTlpxMHBabUczTFE2SlBIUzJoRzlHb0xnYVQ1S2FucjRwZmV3?=
 =?utf-8?B?Qk9zWjVsQ1I1VHF3SHROYTI1ais0K3U1NEVPRi9kdGpBdHk0aytZbWtGMkdk?=
 =?utf-8?B?bEFGcnpYbVJyOG04SEM2TVRnNUlwVkFoVElZTDl3MlRKblhtQnczS1V3WlRi?=
 =?utf-8?B?OWhqcHFOSnJrZmxDZW50SkFyNVd2b0NtNDk3YlFTejk0MHBQU0dIM1YzSmFj?=
 =?utf-8?B?MHIvSHB0QU5VeE51eFMyODVBUFF3aFVGK0Rld1ZYYjNWMS9FU3pMZ1kzdjB6?=
 =?utf-8?B?NDEzRmpFaDJ2eFBlblJ1RnRQNzhoTkJCSWlta0daV1gvUWlsSlNpbWpETEtx?=
 =?utf-8?B?YkhSTklyS0drMThvSENpbElBVG03c2JTOGUzSENtNDA3eU8vOVNtYi91cmZ6?=
 =?utf-8?B?K0FlMkVwZ2xHUE9ScnBwK241VU1mOFNEWnhxSzh3dTd6S0RkQ0V3dU1wb200?=
 =?utf-8?B?UCtWRk9Zb3ZwVHFaMCtMRXlzNXZpbW96NzFSMUJ5Y3phazgvUVVPRzVzMEZS?=
 =?utf-8?B?d01pU24ydWlmbm0zUi9GUUJuOVVETStFQU9zellQL0p3SlRrRWhmMTAwYTR6?=
 =?utf-8?B?RW5menZ5WUV0V2hlcnVUeXYwMk05bXJSdy9tVTRKb21TSk5TcndzVFF3SDg4?=
 =?utf-8?B?aENMR1M0RDQ4OHl1RzNqR2ZubE9xYlJ4ZTJYVkd4UVJlMzRrQnZ2OGpSOHZr?=
 =?utf-8?B?Z1VJRXN6L0VSSGZ6QUNWUEtZVWRXeGtwQ2t2ZHBkbmpRRk5Oc09qaWdUVWk4?=
 =?utf-8?B?eEFic1lSQlR4dWlvcG41ZGlrdVRGY09HUWpmc0w1Y21aSmpJT3FSazR1VWJJ?=
 =?utf-8?B?SW9PWDNhNHlvNUVsSXVYclVRK2crR2xidXUzYlpxbkl2NkNIUXRaanZSamFP?=
 =?utf-8?B?NkFVdGY4ZlllaHUvbGhjc01yMGtDTEp4VUwwV1ZXS3J2SmczVVhKZ2Q4NjM1?=
 =?utf-8?B?M0plL3hpQk9DZUFtajA2eTV3dXY1U0FMWGlvem94WENMemFVZFpidWZkcGJP?=
 =?utf-8?B?ZjZhUTAxY2NEVkhVaUI0UFMxcnlaWXVNb0poL1FrL05pREdNamRiT3N2eDdu?=
 =?utf-8?B?b2NRcDJWMWZyOUZjbDdFVnIvRjBTUG5zb2JhNTRXai9CTStvZDNXdk1UejJC?=
 =?utf-8?B?aVR3SVM3dHpPYm1IMzdKY1V3TFJnS3NOdVdyYVFvWkg4RVNyOVcwOUFMeGxC?=
 =?utf-8?B?Q1E2Tk5XZVZVTDVTQnlkbjREU0dqOEN4bU5DSGdnQ1pVcWR4TTUvcTBYUHNW?=
 =?utf-8?B?bm1sd3IxTHVhdkFEbVlvNWIxazRzWEM1ZzVlMzhrb2QyWVR4WXVOOTBSNlh2?=
 =?utf-8?B?M0gwMng4TkpwQ0dRcXhTcU9uQVZrSi9WblRoZERud2VXbGhFTlFrMjRmcUNI?=
 =?utf-8?B?bUo4eVJqejZaUHFqM2FWYk5UKzg3TmlCdWxQRjhGTmdLNGdybTdDZ3oxYWNY?=
 =?utf-8?B?aFN3aFc3VkhrQTdyMTgrSU4rbzQ0VnFyRmJUM0szdURyQmxvVFNYZDFxTStk?=
 =?utf-8?B?UXNuL3NiMDdLTG16eW9lc01OS2tzU3I5VGJCaUczZms3c3YxNU1IeGU1M1dx?=
 =?utf-8?B?Y1krKzdwMG5aenRGU2NLMzVqc3BJbjYxdG1YakdoYUlEaGpIelJvODlFM3Bw?=
 =?utf-8?B?a0JVbmlsRWlIVFkwQ1QrZ0x5MkJxdGt0NDYzdlBVVFN0c2ZXemNnTjVHalo4?=
 =?utf-8?B?bGNCQUVQM2xmL2YxT1F5YlFxUjYzSkJHTGIvbjZKdTcwYWtlb3R1eUI1U0FY?=
 =?utf-8?B?ZU1xRmljQ1Fnb0gyZ1prT1pOY1FXNGhkaVllSjZ1OHVNNWVoUXJXcXhsdDZ1?=
 =?utf-8?B?OWx6Y3kzdXZ4NlZyb05rQU5Tem5KMlZpMUMxVm5Xbm1oOSs3MDA1MkhybXl2?=
 =?utf-8?B?VUxvRlM4R3RBT0NETDd3aHNxMlp1Z3hvYldrd1BFck5ac0JySTJPeGZOWnlu?=
 =?utf-8?B?VnNFcGZxNXFrS0NZamZDQXUzRmU2amhXenBjSys2Vy9kYjJlMjh3YTJMSDZH?=
 =?utf-8?B?M3VIRFEvUEphTno3K0VLQ1lweUlRS3IyMVZSeDdkM1FOenhWcm4renVHV09G?=
 =?utf-8?B?Nk9yODNCVm1aeW11ZmcwRWthSHIzZGJUcnZwd2JlMnEwNmZ4SDVocW9NSGxS?=
 =?utf-8?B?LzVoaFErTm5VYndPdCswTkxEMExWZGwvNzlGbmt3R0IzYUg2WWF1VURGRWd1?=
 =?utf-8?B?bFUwMUxVSnUwMGg5UVdzZ3ZxZVJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB4AE241EA098F4EAF72B2D09B46A3D4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0388d4b-92f4-46d4-e2e8-08dca4c5ba3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 12:00:31.9609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIvlqUDOOGpKhnjoTCosl8QmcELyxFLuWGckR1P0US69kcMDgS29qzRLKAPowWMepvL99cwLugxE5WfsPIPpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5567
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 12:00:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16492

T24gTW9uLCAyMDI0LTA3LTE1IGF0IDEzOjAxICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiBIaSwNCj4gDQo+IE9uIDcvMTUvMjQgMTE6MzQgQU0sIFN0ZWZhbiBLb2NoIHdyb3RlOg0K
PiA+IC0gQXZvaWRzIHVzaW5nIGEgYnVzeWJveCBsb3NldHVwIGV4ZWN1dGFibGUgdGhhdA0KPiA+
IMKgwqAgZG9lc24ndCBzdXBwb3J0IHRoZSAiLS1zaXplbGltaXQiIHBhcmFtZXRlcg0KPiA+IC0g
VGhlICItLXNpemVsaW1pdCIgcGFyYW1ldGVyIGlzIG5lZWRlZCBmb3IgaW50cm9kdWNpbmcNCj4g
PiDCoMKgIHNwZWVkLXVwIG9mIGRpc2sgcmVlbmNyeXB0aW9uIHdpdGggdGhlIGZvbGxvd2luZyBj
b21taXQNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hA
c2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gwqAgLi4uL2luaXRyYW1mcy1jcnlwdC1ob29rL2Zp
bGVzL2VuY3J5cHRfcGFydGl0aW9uLmVudi50bXBswqDCoMKgIHwgMQ0KPiA+ICsNCj4gPiDCoCAu
Li4vZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5ob29rwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQNCj4gPiArKysrDQo+ID4gwqAgLi4uL2luaXRyYW1m
cy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAuMi5iYsKgwqDCoMKgwqDCoMKgwqAg
fCA1DQo+ID4gKysrKy0NCj4gPiDCoCAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtY3J5cHQtDQo+ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5lbnYudG1w
bCBiL3JlY2lwZXMtDQo+ID4gaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2Vu
Y3J5cHRfcGFydGl0aW9uLmVudi50bXBsDQo+ID4gaW5kZXggYmI5MzM2MS4uNzIwMzNkMSAxMDA2
NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gaG9v
ay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5lbnYudG1wbA0KPiA+ICsrKyBiL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9u
LmVudi50bXBsDQo+ID4gQEAgLTUsMyArNSw0IEBAIFdBVENIRE9HX0RFVj0iJHtJTklUUkFNRlNf
V0FUQ0hET0dfREVWSUNFfSINCj4gPiDCoCBIQVNIX1RZUEU9IiR7Q1JZUFRfSEFTSF9UWVBFfSIN
Cj4gPiDCoCBLRVlfQUxHT1JJVEhNPSIke0NSWVBUX0tFWV9BTEdPUklUSE19Ig0KPiA+IMKgIEVO
Q1JZUFRJT05fSVNfT1BUSU9OQUw9IiR7Q1JZUFRfRU5DUllQVElPTl9PUFRJT05BTH0iDQo+ID4g
K0xPU0VUVVBfUEFUSD0iJHtDUllQVF9MT1NFVFVQX1BBVEh9Ig0KPiBXaHkgZG8gd2UgbmVlZCBh
IHZhcmlhYmxlIGF0IHRoaXMgcG9pbnQ/DQo+IA0KPiBJZiB0aGVyZSBpcyBubyByZWFzb24gcGxl
YXNlIGRyb3AgdGhhdCB2YXJpYWJsZSBhbmQgdXNlIGFsd2F5cyB0aGUNCj4gZnVsbCANCj4gbG9z
ZXR1cC4NCldoZW4gcmVtb3ZlIGl0IGhlcmUsIHdlIG5lZWQgdG8gaGFyZGNvZGUgdGhlIHBhdGgN
Ci91c3IvbG9jYWwvc2Jpbi9sb3NldHVwIHRocmVlIHRpbWVzIHdpdGhpbiBlbmNyeXB0X3BhcnRp
dGlvbi5zY3JpcHQgYW5kDQpvbmNlIHdpdGhpbiBlbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLmhv
b2sNCj4gDQo+IFF1aXJpbg0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtY3J5cHQtDQo+ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLmhv
b2sgYi9yZWNpcGVzLQ0KPiA+IGluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9l
bmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLmhvb2sNCj4gPiBpbmRleCBiZThjMTE3Li4yYWNlNTMz
IDEwMDc1NQ0KPiA+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4g
PiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuaG9vaw0KPiA+ICsrKyBiL3Jl
Y2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29rL2ZpbGVzL2VuY3J5cHRf
cGFydGl0aW9uLnN5c3RlbWQuaG9vaw0KPiA+IEBAIC0xOSw2ICsxOSw5IEBAIGVzYWMNCj4gPiDC
oCANCj4gPiDCoCAuIC91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL2hvb2stZnVuY3Rpb25zDQo+
ID4gwqAgDQo+ID4gKyMgZ2V0IGNvbmZpZ3VyYXRpb24gdmFyaWFibGVzDQo+ID4gKy4gL3Vzci9z
aGFyZS9lbmNyeXB0X3BhcnRpdGlvbi9lbmNyeXB0X3BhcnRpdGlvbi5lbnYNCj4gPiArDQo+ID4g
wqAgaG9va19lcnJvcigpIHsNCj4gPiDCoMKgwqDCoMKgIGVjaG8gIihFUlJPUik6ICQxIiA+JjIN
Cj4gPiDCoMKgwqDCoMKgIGV4aXQgMQ0KPiA+IEBAIC00Nyw2ICs1MCw3IEBAIGNvcHlfZXhlYyAv
dXNyL2Jpbi9zbGVlcCB8fCBob29rX2Vycm9yDQo+ID4gIi91c3IvYmluL3NsZWVwIG5vdCBmb3Vu
ZCINCj4gPiDCoCBjb3B5X2V4ZWMgL3Vzci9zYmluL2UyZnNjayB8fCBob29rX2Vycm9yICIvdXNy
L3NiaW4vZTJmc2NrIG5vdA0KPiA+IGZvdW5kIg0KPiA+IMKgIGNvcHlfZXhlYyAvdXNyL3NiaW4v
cmVzaXplMmZzIHx8IGhvb2tfZXJyb3IgIi91c3Ivc2Jpbi9yZXNpemUyZnMNCj4gPiBub3QgZm91
bmQiDQo+ID4gwqAgY29weV9leGVjIC91c3Ivc2Jpbi9jcnlwdHNldHVwIHx8IGhvb2tfZXJyb3IN
Cj4gPiAiL3Vzci9zYmluL2NyeXB0c2V0dXAgbm90IGZvdW5kIg0KPiA+ICtjb3B5X2V4ZWMgL3Vz
ci9zYmluL2xvc2V0dXAgIiRMT1NFVFVQX1BBVEgiIHx8IGhvb2tfZXJyb3INCj4gPiAiL3Vzci9z
YmluL2xvc2V0dXAgbm90IGZvdW5kIiA+wqDCoCBjb3B5X2V4ZWMgL3Vzci9iaW4vc3lzdGVtZC0N
Cj4gPiBjcnlwdGVucm9sbCB8fCBob29rX2Vycm9yIA0KPiAiL3Vzci9iaW4vc3lzdGVtZC1jcnlw
dGVucm9sbCBub3QgZm91bmQiDQo+ID4gwqAgY29weV9leGVjIC91c3IvbGliL3N5c3RlbWQvc3lz
dGVtZC1jcnlwdHNldHVwIHx8IGhvb2tfZXJyb3INCj4gPiAiL3Vzci9saWIvc3lzdGVtZC9zeXN0
ZW1kLWNyeXB0c2V0dXAgbm90IGZvdW5kIg0KPiA+IMKgIGNvcHlfZXhlYyAvdXNyL2Jpbi90cG0y
X3BjcnJlYWQgfHwgaG9va19lcnJvciAiVW5hYmxlIHRvIGNvcHkNCj4gPiAvdXNyL2Jpbi90cG0y
X3BjcnJlYWQiDQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1j
cnlwdC1ob29rL2luaXRyYW1mcy0NCj4gPiBjcnlwdC1ob29rXzAuMi5iYiBiL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAu
Mi5iYg0KPiA+IGluZGV4IDcyZGU1YjYuLjE2NzkxMzMgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBl
cy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svaW5pdHJhbWZzLWNyeXB0LQ0KPiA+IGhv
b2tfMC4yLmJiDQo+ID4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhv
b2svaW5pdHJhbWZzLWNyeXB0LQ0KPiA+IGhvb2tfMC4yLmJiDQo+ID4gQEAgLTksNyArOSw3IEBA
DQo+ID4gwqAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gwqAgDQo+ID4gwqAg
aW5oZXJpdCBkcGtnLXJhdw0KPiA+IC1ERUJJQU5fREVQRU5EUyA9ICJpbml0cmFtZnMtdG9vbHMs
IGNyeXB0c2V0dXAsIFwNCj4gPiArREVCSUFOX0RFUEVORFMgPSAiaW5pdHJhbWZzLXRvb2xzLCBt
b3VudCwgY3J5cHRzZXR1cCwgXA0KPiA+IMKgwqDCoMKgwqAgYXdrLCBvcGVuc3NsLCBsaWJ0c3My
LWVzeXMtMy4wLjItMCB8IGxpYnRzczItZXN5czAsIFwNCj4gPiDCoMKgwqDCoMKgIGxpYnRzczIt
cmMwIHwgbGlidHNzMi1lc3lzMCwgbGlidHNzMi1tdTAgfCBsaWJ0c3MyLWVzeXMwLCBcDQo+ID4g
wqDCoMKgwqDCoCBlMmZzcHJvZ3MsIHRwbTItdG9vbHMsIGNvcmV1dGlscywgdXVpZC1ydW50aW1l
Ig0KPiA+IEBAIC01Nyw2ICs1Nyw4IEBAIENSWVBUX1BBUlRJVElPTlMgPz89ICJob21lOi9ob21l
OnJlZW5jcnlwdA0KPiA+IHZhcjovdmFyOnJlZW5jcnlwdCINCj4gPiDCoCAjIENSWVBUX0NSRUFU
RV9GSUxFX1NZU1RFTV9DTUQgY29udGFpbnMgdGhlIHNoZWxsIGNvbW1hbmQgdG8NCj4gPiBjcmVh
dGUgdGhlIGZpbGVzeXN0ZW0NCj4gPiDCoCAjIGluIGEgbmV3bHkgZm9ybWF0dGVkIExVS1MgUGFy
dGl0aW9uDQo+ID4gwqAgQ1JZUFRfQ1JFQVRFX0ZJTEVfU1lTVEVNX0NNRCA/Pz0gIi91c3Ivc2Jp
bi9ta2UyZnMgLXQgZXh0NCINCj4gPiArIyBQYXRoIHRvIGZ1bGwgKG5vbi1idXN5Ym94KSBsb3Nl
dHVwIGJpbmFyeQ0KPiA+ICtDUllQVF9MT1NFVFVQX1BBVEggPz89ICIvdXNyL2xvY2FsL3NiaW4v
bG9zZXR1cCINCj4gPiDCoCAjIFRpbWVvdXQgZm9yIGNyZWF0aW5nIC8gcmUtZW5jcnlwdGluZyBw
YXJ0aXRpb25zIG9uIGZpcnN0IGJvb3QNCj4gPiDCoCBDUllQVF9TRVRVUF9USU1FT1VUID8/PSAi
NjAwIg0KPiA+IMKgICMgV2F0Y2hkb2cgdG8gc2VydmljZSBkdXJpbmcgdGhlIGluaXRpYWwgc2V0
dXAgb2YgdGhlIGNyeXB0bw0KPiA+IHBhcnRpdGlvbnMNCj4gPiBAQCAtNjgsNiArNzAsNyBAQCBD
UllQVF9FTkNSWVBUSU9OX09QVElPTkFMID8/PSAiZmFsc2UiDQo+ID4gwqAgDQo+ID4gwqAgVEVN
UExBVEVfVkFSUyA9ICJDUllQVF9QQVJUSVRJT05TIENSWVBUX0NSRUFURV9GSUxFX1NZU1RFTV9D
TUQgXA0KPiA+IMKgwqDCoMKgwqAgQ1JZUFRfU0VUVVBfVElNRU9VVCBJTklUUkFNRlNfV0FUQ0hE
T0dfREVWSUNFIENSWVBUX0hBU0hfVFlQRQ0KPiA+IFwNCj4gPiArwqDCoMKgIENSWVBUX0xPU0VU
VVBfUEFUSCBcDQo+ID4gwqDCoMKgwqDCoCBDUllQVF9LRVlfQUxHT1JJVEhNIENSWVBUX0VOQ1JZ
UFRJT05fT1BUSU9OQUwiDQo+ID4gwqAgVEVNUExBVEVfRklMRVMgPSAiZW5jcnlwdF9wYXJ0aXRp
b24uZW52LnRtcGwiDQo+ID4gwqAgDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K

