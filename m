Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D6D25B45
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 11:15:31 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10734.1769598923047530059
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 03:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ro5LZMp1;
 spf=pass (domain: siemens.com, ip: 52.101.84.41, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHc/aki7eRpmbhg8R/uNCEcnxdcvASJFhqqcgGv3PUm+U12aSOIpJxhhYHlseDh2e6DfeuMilSMLVn9sDFVNcdKvlrjBGHz4L2WPfNhH+YWo8GgtlZ0elKa+33eRyufk/kNVx5ASmoko0K+JcC9+ww2SR3uvLu/RZa39T3LKYMx0u7przYQ8EGTxenM5YqWr1YHJhbKCg2JlEiWGvRySyNOGwh5e9MhwjQWz8tZaK2iQzuV+r8exuy6mZ10I24haNCaY6HoUkpkGlLfljWafWGi7o1n/oRJvFmjI1Qf4SDVO+H/6oQExfMaH7L3NeHWVZEK962WVdaZv7d/WsG2hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=075CSUURSnFyU4X9/olpaeBiLYTSKd4yPk4njIpI0OY=;
 b=PMDBic6IQCwxt6+Diydy3pZOsNqRNpeAFjo4KPPhemytxRw672BCVal7vFAOx+IjUCWRK9GGgg507svf1CW4JvL9X2oUt8vgN7J/rT9B9yHUOYNiBAdGhUcw9ksLXPZ4AOSBeSbLnaODsKnkPnwkIrJtfUhK7OwJ8wFxk6D+Tb7gh5qiFzifprft55r3fBoVSHewjG0FgayKogjd4QcUlLIJcgG/CYs/Ayj1N5/zGF+RLyqwgoHEI4PyULYNoMwomgtqUEcDy78/fI7iiEfXi7md4aO0HAP3wqQy0JlEpjbDce28LpWN2gGllizF75qhGJi7S6PSnq+gm4Dc4XqoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=075CSUURSnFyU4X9/olpaeBiLYTSKd4yPk4njIpI0OY=;
 b=Ro5LZMp1uPOceeJaljEgeCORZDG30SwRweYFulLsKd0K2jymaTfjIJATfGojxhiXGMCUIAOVXukr0YfjaVf27+SJr2UA9U90ukV21juVYRIo/2QxnnUKYZT+1xH4TAssNdTKSn5lqD8mL5TOhTyc5qLRFlmZF6ntFzJbr1hRGmDJlNHS+yi2zZTqSVJB8WZuI/+6fq+ktrm4/OVX7ScVMB306a2lzOs8MmekzTVJEBZcR9g0dlDqLXxVRdA9Pb5XW3lAXYqFjWeY9AIwbJqp/mM+8Dfzpr35X32dTIYNq5dvd2hc/oImg4JcoYC90xRslwumf3hnNJQSx7aup3xrhA==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by GV1PR10MB8369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 11:15:19 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 11:15:19 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Topic: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Index: AQHciWA0+no2hYoNOEuQkOtrpvl0h7VnfAQA
Date: Wed, 28 Jan 2026 11:15:18 +0000
Message-ID: <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
In-Reply-To: <20260119162444.672037-1-alexander.heinisch@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|GV1PR10MB8369:EE_
x-ms-office365-filtering-correlation-id: 38edbe4e-73a6-448c-8c96-08de5e5e8565
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VVVYd3hOZVNZWVhtOERXMCtLc0pEblFUbDY1VWhOZzV4V1duVVZ5QzBCVTg2?=
 =?utf-8?B?MlpPUXhjSGNMbTlHWHZFWlpYeHByQVZIREZYd0lKQXFnOVp6Z2srZFI1R3hL?=
 =?utf-8?B?OGM0QXRnUzQ4WjRQbHQrL2hTSUJkVkdzWWRkdFR2aHFveG1wSVlOV0xwWDJX?=
 =?utf-8?B?dWZwMDVUYU5FWU43MlQyTjRsenNlU09tMkNZS3d3c0Zsb21wUHZLYWlkVGVR?=
 =?utf-8?B?VGRkNGFnZmtDNzRNOHByS0pBVnpWWitLSFQ4L0MvSDFmbXQ2WndycmpJUW9V?=
 =?utf-8?B?bnkvdFdSM3lWREp3VEVHK1RRZlh6dVpOUFdGS2tnd29HK1pNZmVId2VsZGla?=
 =?utf-8?B?Wkc1ME5SOGlGL0R1Um1IdDNndGw0Nk8vR1FlZVcwWjVUdGNDdnVxR0RZM2x5?=
 =?utf-8?B?S1RCZE5ldTBYQ0ZnSUtyWStsRytWTzY2eUE4YmZ4MitTek5DT1NvYWFvQjI5?=
 =?utf-8?B?dFFuM0NzcVc4MXNHR1lxNWJTMGpKUEkxNmw1N2Q2M3dFL2daSXIwM1o5Ymo1?=
 =?utf-8?B?dWdFcFRvd2p6UXQ2Vkt6S3lMT3A1amVMYnJiYW55bFU0THZQallVaVlrSXY1?=
 =?utf-8?B?bUJ1ZG1uVElKWXQ1Y1RtelAzMXJXcmkzL0VzWngxdUJTWW1OelYvY3BDK3pn?=
 =?utf-8?B?cjRvY2pQVTNSZVhMZU0wcmkySC9TSy93Q2lWR1YzbzR4OEQyeTY5WkYzc05m?=
 =?utf-8?B?LzhxZ0djQVJHN3pJbngydFk4VWRRTDQvcjgwSkdaRXZSc2hNZUkvZ0Z5ekgz?=
 =?utf-8?B?dThKVk10bmUyRUJ6VGJoRXRoVUE2eHYrQXBHdmI3M3VEL3dkY2lIUlVvWWRV?=
 =?utf-8?B?ZUNsZGlxYjNQQWM2S21peVZzNjdkR29yTHMxbGJ1QWtqczEzOXJlUlYydVc4?=
 =?utf-8?B?S0htRytrSit1dnp4ZHNrbGNVS3VQTGZOZWVpQVhHRVBlaUVmQnBQOXlYMkVF?=
 =?utf-8?B?cVdBNFVmdzZmcG9KZ0ZLak85Z0FHTzliVWhlR2dEWEloMFFjSEFleVpsZ2Vz?=
 =?utf-8?B?eFdPZlV2Ump3Ui81QVJOYVJkSzVoSFNkMTdPRGUrenRJWUJwejAzem96My8x?=
 =?utf-8?B?MlFteFZjOVNYdlhPbkdmZERKdUJzRFVxSUpQV1ZsQVl2Yi9JbmhUamd1bG54?=
 =?utf-8?B?TXpRMDdWeWRtQmlpVnhGN2tKN3YyOHRubGRISFdNY2tFdzlqTUVkMndkOWJx?=
 =?utf-8?B?MDg4Qm4rNXJHMlczU0QrTE03T0k3V1Q3SGoxQmh0ZVNCUzFpNjJTWUFiTVY2?=
 =?utf-8?B?eEY1enhXdGZxQmFNSm9seER6TEZPY2ZBL1l2bnFpazkzWjZsN2NlSEdIZG81?=
 =?utf-8?B?ODlBRkxseGkzZTdiaXRGeTVmd3BIbm41Mk5iTmlPN2lQb3MrM0xOWTBja0M2?=
 =?utf-8?B?dTlLT3ZSQzBTVE9nd1JBS25LeEdUUis3WDZhOTZrWk43Zzd0WVhXbTFIRkY2?=
 =?utf-8?B?dzhEOWtCbXBJZktLUi9Qc0U1T1VtTklsdHZycjVXcDhuSHJmT0h0eDYvc1dv?=
 =?utf-8?B?aVVjWjBWbU13OVExeFVuTkFiVXJkenJKa3NOUlhEbzFkdG5tdGlpbUpLdjR6?=
 =?utf-8?B?eDdqa1laeXFralF6b1NRUWx0YUtUK2Z6WmR0dlBFdnVEWEZQTkllUWNEck9H?=
 =?utf-8?B?S2NGYmExQUMyTVRlR1kzYzdzL1MyWGpWR0haM2ZCd3VuOFR2OFQvQWtoRXI2?=
 =?utf-8?B?WVN3K0J2eWVCNG9QWTZHZko3MjN1T1ZIdW9LcEFJUXJReFZPODF0OVVHZE9C?=
 =?utf-8?B?alZFK0pyVjlhODhXU0cxVkxOMkluY1BLci9FR2d5clRFYyt6U1plS2JYenBH?=
 =?utf-8?B?UW1NbEY2NFkvTE1ka1BzV3RDN3JISDFtTVdCalRKWE9aeHl6LzhVaG1yL1I0?=
 =?utf-8?B?VlR4dENFaGZ1aERQT3VsbVQxc3EwWHg2RERxcGZzQXhYdCtReVQ0cUZTV3Z6?=
 =?utf-8?B?NDlQMUVwYVJGblNsdTBDNW9aUG85aWh6cVYxTlpFOTFRSnV2RmFpelFzZmZ1?=
 =?utf-8?B?cU5CdzBZeGROaHkzVjJPd0RocVNDUWYvSmwwNkh2R3ZhUjNRNmkvSlJrNmpE?=
 =?utf-8?B?RHVvYXF1Z1pJby9XUysxMDl1Q2Vpb1E5UzhhMzdvYUpsMld4QjRzNy9XbEdP?=
 =?utf-8?Q?lJ1vaYeB8gfEddE8IsyY20I3p?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OU9UZkpYUWxFNGFRUHg3TXpVYTZnUjlSSkZEYXBMbXdNL09ud3JERDBDTFFl?=
 =?utf-8?B?bjM3b21vbldqOCtmT1F2QnFHaHBiSmYvZkp3amkwY0s0b0ZUbVpPNElrdVVZ?=
 =?utf-8?B?bnFENGcyVjN5MGRhUVl5L3Fac3FoZUUyTW1UMjZIZ2VBYlpJcTAzQWZTRmRM?=
 =?utf-8?B?cjFlWGw3dDkvcThFQUlEc0tKWTVlTUI0SGVqVFhaSUFya3hrR1d6RGpvTzJk?=
 =?utf-8?B?RDJDTDd4UThncVRWN29zVUEzU0F0bEtIS0lMVlZoTU1IMGJGYmhjZng1OG02?=
 =?utf-8?B?MnVzUVkwNjEvbXFVNjBxSEFmTGZtY2NramloYUxrY1NUQVJtNHZrZjFkRC96?=
 =?utf-8?B?S016T1I4YS9kYmp4QnNsWkhmbkEyVXlFL2tKTDF1clFLbmZ5SHZQS3NzdnN4?=
 =?utf-8?B?Z1F4T0d0M2dLbjMraG5FSjE2V3RlN21CTzhnbkZGWklFUy9CbnRTZTJ0RnR0?=
 =?utf-8?B?dUxzaExqUlVhbmFaYnFzVkpFZ2VsRnp4NFR5RnoyTWEwS2hiejBWT0xDcU9k?=
 =?utf-8?B?NEhORzNEcmRnVUxVY2pqQW5udzZMdnZnSUt4T2RhTGdtWkdLRHptVy82SHBz?=
 =?utf-8?B?MStkcWVaTDZaazRJTDQrMDlPQ2RVWXFLVTBKdFBHeFAzMUVBbHhaWWxKLzFW?=
 =?utf-8?B?ZEpQNE1mMzhBUXVDbGFGZnh4UER3K2hqMHVkMkVGL2FvQnJxKzkvZkpkRTRL?=
 =?utf-8?B?aERjSmJFbnA1djBaeEhmaHRBbWVlRGxjWDA2LzF6bXVWbUx5cytvOWxTMnQy?=
 =?utf-8?B?c3RNaDVuOW1kWW1LNVNFYUk3YW5Mc2tsTzB4amU4NnhpTmEzYmRiNUVYWXJZ?=
 =?utf-8?B?TUNxR0l2c1g3bm5IWXMwVjd3Zk5pSDB4a3hCTWlqWFRMM2lLcm1naU5aQ3BX?=
 =?utf-8?B?T21zSE9xaVFHNnNLYzRtbmxYNFBHRmdBM3VpTm4vaDAxUWRHakJrWGJKZi9X?=
 =?utf-8?B?aVFiQjlSVTlsRTVXcHg2NS83QmFuTFRIZS93SVd5Tk15cHJHeTYwemhnaEZ1?=
 =?utf-8?B?WWlKb2RVcUZzUnpVeStnOWVXUVdyeGtmTDdlZ0s3OENLNUFUVHQ0b1VjdGdv?=
 =?utf-8?B?M1RVSGluTm9XRkNpaE5sVDRmaGkxU1RuTEIvUzVEOXBENFVaajZCZ2ZDVGpS?=
 =?utf-8?B?YjNrRGNMSGtkNUJOTGc5di91WXNFM2JFa0R5WjVBQnZkOXB6Y3pnQzB1Nml5?=
 =?utf-8?B?b1F4SHJ1Q1V2V1YzcEpPTnRWcGNpMTRLL3EwcjRuZVNPTEFKbk9zUmFtOS8z?=
 =?utf-8?B?bHFZQXo4L3lyMlRwQVp6VVJrZkJrQVlPcHJUVWczclk2cHFGV0h3dERXY3Vz?=
 =?utf-8?B?TGhEdHV3d3VHSGVvNmhNbFgxL1krZkgyQWhhZE92SVB6aDlkWVIzbVltcG5v?=
 =?utf-8?B?aWt4cm1oZzM3aUt1WUlqZEtaRXpHMGhpMDByTzFiT0xuRWFDZWdwQW4vKzhK?=
 =?utf-8?B?WkNJUy9qbk1IQ0ZjK2dkRVd0cTF6aEpyc2R5RTExU1NGZnVWUi9QQWFUYzZj?=
 =?utf-8?B?RWl4SHMvbUN3eVJoZk96UW5uaDFmclRScGd3YmhpVGloQzB2cElrcS9hMStr?=
 =?utf-8?B?YjBWM1pVZHdFVGt3c00vQ3ovK3VNb2dqR294enMyNjhGaFEwRWZ0U1p5eGpX?=
 =?utf-8?B?VEpLdncrNmtJWVplOEVLaHN5Zm4weXZneE5nOXM0UG9jUTl3eUZ0bWJVckJC?=
 =?utf-8?B?ZE4rV01PWUljd3hCbWliNXk2c2ZpaG1rRjNzYk9oWEVUY3FzakkxQS9sT0RZ?=
 =?utf-8?B?THJzYUtFV1VFMDZGblNHdXBYQ2dkQ0ZydGVSZVd4OGc5VnlONjZ0N0JsalA1?=
 =?utf-8?B?QXg2Z2M3TWZNSEtwYjNLMTgyME01Qk5YN3ZXdU1uYUJzVEFkWHRGejlVZnkx?=
 =?utf-8?B?cUoxb3FQVHA3UzZ5a2t2dS80NWRqTHVTTXZTY2I0eHF4ajBWSXl4Wnh2a1RG?=
 =?utf-8?B?UGI5RGJhZFA2TlVWcGgxcTQ5djRtK0I2STdLa2puTk94NXdhU3BZVmxiWGl5?=
 =?utf-8?B?b0dPNmZEWEdBRXNaR3FXZ0syL0laSGNFTnZOQjhNdnlZWDltNkVFWktFUThy?=
 =?utf-8?B?WlA2cktXcXQ3SnRjZklCQjMxUTduUkVyUEV0dnBBM2hzRGpSYVBDMENVS09Z?=
 =?utf-8?B?TlBPaGZUd01zdTFoYitIcnV0VmswUkVoQnc2RHgvMVZvaVhGL1dyVDY3WTgw?=
 =?utf-8?B?OGNhcEt4a1NodU93K0JpUGk1ZFJ3Q3JTTEZaU3hmbEZXdlZJSXVyZ1VSSHYx?=
 =?utf-8?B?UDlZYmFxYkJoSkFzVWdCM0N2OTU4OHNtWVNtK0NJUkdIOURHRFZiNzJtNk13?=
 =?utf-8?B?VnN6MTNKUlo2SkhleTZTYlNZVWtKeXpEYVcwWm9MTXJCVEU4SVJGWUxzY1BW?=
 =?utf-8?Q?aIu4WFaM+yQ36oz5QSXdwkYX1ACAuzKEtx2YS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3988CEEDF0E7224992D30B95AAD4FAA8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38edbe4e-73a6-448c-8c96-08de5e5e8565
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 11:15:19.0056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF2G8z9PobGkTfYLEkbjxpcq3xjW8zdBCflurw7vacZuhZB166gbz/HTryIjZ9qdWgiHuE7JMl4noRcvAaz08DOs1TZcburiYNRZsXfHBmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 11:15:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21734

QW55IGNvbW1lbnRzIG9uIHRoYXQ/DQoNCk9uIE1vbiwgMjAyNi0wMS0xOSBhdCAxNzoyNCArMDEw
MCwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tDQp3cm90ZToNCj4gRnJvbTogQWxleGFu
ZGVyIEhlaW5pc2NoIDxhbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20+DQo+IA0KPiBUaGUg
c2VsZiBidWlsdCB2ZXJzaW9ucyBvZiBzd3VwZGF0ZSAodXNlZCBieSBkZWZhdWx0IGluIGRpc3Ry
b3MgPA0KPiB0cml4aWUpDQo+IGRvIG5vdCBlbmZvcmNlIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24u
DQo+IA0KPiBgYGANCj4gJCBzdWRvIHN3dXBkYXRlIC1uIC12IC1pIGRlbW8uc3d1DQo+IFtERUJV
R10gOiBTV1VQREFURSBydW5uaW5nIDrCoCBbcmVhZF9zZXR0aW5nc19maWxlXSA6IFJlYWRpbmcg
Y29uZmlnDQo+IGZpbGUgL2V0Yy9zd3VwZGF0ZS5jZmcNCj4gW0RFQlVHXSA6IFNXVVBEQVRFIHJ1
bm5pbmcgOsKgIFtyZWFkX21vZHVsZV9zZXR0aW5nc10gOiBSZWFkaW5nIGNvbmZpZw0KPiBzZXR0
aW5ncyBmb3IgbW9kdWxlIGdsb2JhbHMNCj4gW1RSQUNFXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOsKg
IFtzd3VwZGF0ZV9kZ3N0X2luaXRdIDogcHVibGljIGtleSAvDQo+IGNlcnQgL3Vzci9zaGFyZS9z
d3VwZGF0ZS1zaWduaW5nL3N3dXBkYXRlLXNpZ24uY3J0IGlnbm9yZWQsIHlvdSBuZWVkDQo+IHRv
IHNldCBTSUdBTEcNCj4gYGBgDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBlbmFibGVzIHNpZ25h
dHVyZSB2ZXJpZmljYXRpb24gYnkgZGVmYXVsdCBmb3INCj4gc3d1cGRhdGUuDQo+IFRoZSBzZXJp
ZXMgaXMgc3BsaXQgaW50byB0d28gcGF0Y2hlczoNCj4gMSkgQnVpbGQgc3d1cGRhdGUgd2l0aCBz
aWduYXR1cmUgY2hlY2sgZW5hYmxlZC4NCj4gwqDCoCBUaGlzIHNpbXBseSBmaXhlcyB0aGUgcHJv
dmlkZWQgZGVtbyBidWlsZCBjb25maWd1cmF0aW9uIGluIHRoZSBrYXMNCj4gZmlsZQ0KPiDCoMKg
ICgrIC4va2FzLWNvbnRhaW5lciBtZW51KS4NCj4gDQo+IDIpIEVuZm9yY2Ugc2lnbmluZyBhbmQg
dmVyaWZpY2F0aW9uIGZvciBzd3VwZGF0ZSBieSBkZWZhdWx0Lg0KPiDCoMKgwqAgVGhpcyBwYXRj
aCBtb2RpZmllcyB0aGUgc3d1cGRhdGUgY29uZmlndXJhdGlvbiBmaWxlcyB0byBlbmZvcmNlDQo+
IHNpZ25hdHVyZQ0KPiDCoMKgwqAgdmVyaWZpY2F0aW9uIGJ5IGRlZmF1bHQsIHdoaWNoIG1heSBi
cmVhayBkb3duc3RyZWFtcyByZWx5aW5nIG9uDQo+IHVuc2lnbmVkDQo+IMKgwqDCoCBzd3VwZGF0
ZSBpbWFnZXMuIEhvd2V2ZXIsIHRoZSBkaXZlcmdlZCBkZWZhdWx0IGNvbmZpZyBmb3Igc2lnbmlu
Zw0KPiBhbmQNCj4gwqDCoMKgIHZlcmlmaWNhdGlvbiBvZiBzd3UgZmlsZXMgaXMgcHJvYmFibHkg
bm90IGRlc2lyZWQgYW55d2F5cy4NCj4gDQo+IA0KPiBBbGV4YW5kZXIgSGVpbmlzY2ggKDIpOg0K
PiDCoCBzd3VwZGF0ZTogQnVpbGQgc3d1cGRhdGUgd2l0aCBzaWduYXR1cmUgY2hlY2sgZW5hYmxl
ZC4NCj4gwqAgc3d1cGRhdGU6IEVuZm9yY2Ugc2lnbmluZyBhbmQgdmVyaWZpY2F0aW9uIGZvciBz
d3VwZGF0ZSBieSBkZWZhdWx0Lg0KPiANCj4gwqBjbGFzc2VzLXJlY2lwZS9zd3VwZGF0ZS5iYmNs
YXNzwqDCoMKgIHwgMiArLQ0KPiDCoGthcy9vcHQvc3d1cGRhdGUueW1swqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDEgKw0KPiDCoHJlY2lwZXMtY29yZS9pbWFnZXMvc3d1cGRhdGUuaW5j
wqDCoCB8IDIgKy0NCj4gwqByZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jIHwgMSAr
DQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiAtLQ0KPiAyLjQ3LjMNCg0KLS0gDQpBbGV4YW5kZXIgSGVpbmlzY2gNClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K

