Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D8C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 08:01:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web11.2027.1745568082596675943
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 01:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pxXHpLbX;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEKTYQjaLFs2iL30vofzyc5DODd8LtB3BJVx4l2HVISg9B/Sxu10wAtFM1ydlIjDj64Evu9hqpcCKjR5r3V5oJq2+QqjhsgJ2nqm9EdIAimcYcDPBeR3MqQJtKOvZLjrd+Il7KYw5aYEN0f+gvJMwEx1Ni+Mv0kHuR2hr7N4geRghnm0JaDyDvZZBZnZZBWxaXFJH7Gk8TbDKFooY2s5XA4vJ3zG52SgY+6EEemp7QcJu+/f9MpyyGG3ArrPu844+DDWN3YlqQ79yOcrHEoKY0z4ZwmCg3gIPzFmnEG+qGBlaDhHbBvoCKOIrNJlabttgfn+JJVh7ByxzcK3N9HXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs812IiRkfwx8w2DxJBiOlSS4t3TeC5aRNUk/3v3q48=;
 b=KuUIVO60QMMpXOCaK8+6kUchmlJ30/1/3M9VNfRaBN5zKSD56a60nA3xJQq9PoC5nOKD7UirNh2ao5Dcvu8QbqmeeWW7G5nsjgBok7lDi5eN+qVsX3rgqR3Kyy4ocLFSW4LkD5X8xt1QDrSnsuMuf5ZeBkGiYVosLFtcRTrUbAYoRibYB/B+buSlVHXmsKnt8y15oLyzJFV0FZlgsjeSpSuTjMPJhEoYgNfO/t1EsFNUpjq3/mhhybjiXm6GSqbSOW5/2Bd13a7a0sxowt2+OY0bb44W7pWlUg5tH6jZJBPuAqeGSObsmaS2i6bbY4v5IoixKFIhLJoNQMtC0oLCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs812IiRkfwx8w2DxJBiOlSS4t3TeC5aRNUk/3v3q48=;
 b=pxXHpLbXg/iFdc2VAbv8ZXBEBXeLWG8TgWklkr6nkwU/RnGZ2tQOHl3aV/uxw1Ja8qnCdnR+2Rx0IOLLnpqveOGWI9zNnUrww6Ci6dFD2cFwCWa+KzFuNKc0SHiHlEkzi6gjj0tGj/ZSDrv3pNy8VM3byoS/1gWqUymRk5tpwwr7P34UhusRa7gIlevqv/n6wHCDXEqSCtYCrVxrazLVuqrOkhUNM+NIp8YzBc7rMF+neGuBzNuQPmTzfCdkkOXYXMSI25lcTPEl1OukDqOM3bfZxzu4k5S0KQZ/PCYElqRfUnwjQgKGauozQj037r7orEgUGM373XVc6LPLdkIPnQ==
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 08:01:18 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 08:01:18 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/5] Use kernel commandline for
Thread-Topic: [cip-dev][isar-cip-core][RFC v2 0/5] Use kernel commandline for
Thread-Index: AQHbs5X0iCq6Ps14kE+EtBPiDZaMv7O0CUWA
Date: Fri, 25 Apr 2025 08:01:18 +0000
Message-ID: <95e952da10ed1a0f98eb69a32eeaf4ca239076af.camel@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6823:EE_|AS8PR10MB6269:EE_
x-ms-office365-filtering-correlation-id: fc158a6d-ac75-48c3-2802-08dd83cf5c27
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VWJaU05MTnlLMU5INnZqQU82SkJyY1VzbEErQStRUWJhZGpXSzZBaFN0b2Qr?=
 =?utf-8?B?OFp4ak40bkV2alV2T3E5UU9mSlVScFhweHJVM1E0a1ArSmRkSUlDRHJzSXNY?=
 =?utf-8?B?UVQxcFE2YVM2VE5CM05qaHdNRU1jYzMxWG5tcHUycWNRYXZUSDAyaGlvS3VM?=
 =?utf-8?B?dktzb2FYUlhtMXpoQ3lWcDI4MmY2VFdaZjBaMkkyRTRWa0kzMnFZWFBKSERj?=
 =?utf-8?B?Nm1IblVZc29BcWU1b1JuSjdEZkxCSnlmeGIxMW1qMEhqeVk3dVVFUFRxTUxM?=
 =?utf-8?B?UXlOSEdnM2Qxem9vdmF1Nk1IcW4veUV4NVdFSFA2UjBQT1crckVNckRxbzh3?=
 =?utf-8?B?K1cvRmxpWkI5NTg5czlnY01xQVByVk1GUCtvQitjMXVPQ3FTbGxVTFVoa1FW?=
 =?utf-8?B?RUt4TnhPU0N2UWVkc20rWmFhc2ZNM3J4RlowbTFoR2NIUVVtcUY2R0o4ZllR?=
 =?utf-8?B?dnB5bGcvY0NYUXlia2dBQm1Tbk9KZldYaUhsQzltRUxtVUF5U2p0RytOcTVD?=
 =?utf-8?B?cDBkN2ljZjlrU2RucFhPUjRKVlJBQ3FyVXR0WHNFcWNuQjBsNUZkdXl4SW5T?=
 =?utf-8?B?akNkMzZMbFBweENmZkFsblBMQk1xWWZTeFNiQTNzc0dEUTU0a3hjQ1djekxQ?=
 =?utf-8?B?WnFUelJkOVVEQXhQdFVxbVVjUjhubWN0SmtNc2ZkMitNalJUYWc5RnNieS9W?=
 =?utf-8?B?KytvbW5WRFBOQlpiVW1EYjhhYzB5aHRtR3VaN2dDWG1ZUU5WZGNCR0REYmpV?=
 =?utf-8?B?OFhmTFF5dW9MZUFWcEU1UXZDUG4waTUxdk1aWkl1QVpwTTdMK2NOTXhtTWdM?=
 =?utf-8?B?aVlSWkJ4dFJHajQ1TmNVTVN1TXlpNlVYT1UzbmhhNm54UDQ5T0I4cGx3RDlU?=
 =?utf-8?B?Ky9RQ1ZoZktoNUlmKzREc3dsYzByeXMwSklpY3R1UGx4WW5uTW5CQWhucVFX?=
 =?utf-8?B?RVRLamZPWmdFNlpJekpvWktZaHhya3pvSms4K0FiRjJ5SWNaaDNtY3VvNUVj?=
 =?utf-8?B?UGRsSGN3L3NUcTJJQnk3MW52SHJHR2hNM2tnMk4rUzJSTWFSUzEwVWM1K3l4?=
 =?utf-8?B?QnBDRmQ0dXMrT0YyZWJlcmw0dTM1bks0b0tYZ2tyTWcwbFZxUHJZZ0lkV2FP?=
 =?utf-8?B?elhHMEt5ME5VUW5ScHpsUE5iaDE2MGVIYjIvRHdqYjc0a3dEWXhZMGFXVTFD?=
 =?utf-8?B?bTJjNnlYQnpLdFM3UlA4U29YczV5ZDZnQ0w1ZEhmaDFzN0ZqU1QzOEh2MVdq?=
 =?utf-8?B?dFNENUdSR2dBMFpPdUxFOFgvNFFHenRlNXU5ckpxOFh5MmhGQ0JsTjgzQnhI?=
 =?utf-8?B?WmM2VytNQXc3MFRHRDBIbWNLbUU0dWRPdVpyZHpoN2lkeTU3RG1JaTNSVnlt?=
 =?utf-8?B?SWlpMkorRW9JS21qdC9Rbmc0TFkxaThiZ2ZSVHpJa2c0bWxDTFU2RnQrZ25u?=
 =?utf-8?B?S09KZDdWSFFXNEFYdW1sc1NIUHQwVTJrN0pLSWdYZXBWakFQS3lLb0lUVlFC?=
 =?utf-8?B?WXRiU2VacGQ4MnI5MHovWHFTSGxzdHlZWFI2Q3NCaWNvUm5NWnFtSDJMeG1h?=
 =?utf-8?B?UFJHZzFIVFYwYm94R3NIVWF3bElSdUg1RTViaHdoZGtLMWUzWjE2eDYyYkxu?=
 =?utf-8?B?SngvSGw5ZWxTdDFlV0J5SFlwRWFWZWFicVRlbTdIYjVHT2NiV1JDdDlCQkpC?=
 =?utf-8?B?RnJiY3lETmw0SUp6QmdSbXNGVjM0UEZKMUtBbWhaM3ljT1ZGK0Qvdk9INEZ6?=
 =?utf-8?B?aEFGTUdXaHYrRWhZQ2J5WjErR1BkaUtaVk9oU05tTXhCaHFrU1hnb0RoSlo4?=
 =?utf-8?B?RWxMZHRLODZJajFNY1pwVDJzTVR5Zys0dXFoZVBWWnJMOHduKzZadDNiOUQ2?=
 =?utf-8?B?MVBrcVRCbTFIM2pLOEVEejZWdDN4bk9HdXQwZTh6UHhTY2ZkeDUxQlRReU5Q?=
 =?utf-8?B?dlhJQStUbkJCb3I1WjU2YTUrcHpxQXZQQ29CQ1J4Ly9lMm5LQk9pSFBFNll3?=
 =?utf-8?Q?m6BQHzcVxGwLyZmU3bbq4jFv0pbvs0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0FxRWtBQVljSXU3YU1TaFYvcmQ2SW1oU2dld080MHRZcEdSNnYrRE9TS0Ns?=
 =?utf-8?B?YjFVaUVUeWVOaVN1SWFIWFlHbExSeFVUdHRObE1tUEE4MThUVE1iQzVoNGpO?=
 =?utf-8?B?alY1MmlwTTdXOFNEYjNRdU12RnJlOHlCazVmSnNLRG1NMGI0Tk82VkEwcUJX?=
 =?utf-8?B?WVJxU05JVG1BaWhPMWR0ZVhsaHVZQzNuRWVva2xYRGt4MHFoenN0NG8wRS96?=
 =?utf-8?B?WUdGQitGNGxKZVFOUk81MlJwYzdBOEdwcG9ieSt4ejB6b29YUFp1SVBVeEM1?=
 =?utf-8?B?MWROVHN3TDZiYkZBVlczT29JU0R4N2Yvays1bFYyZHFLSjhhRlc3emdxUURM?=
 =?utf-8?B?djcyZEdmangwZTBuV0JHT3QyV1YxbWx3dFNHRHJUTU9SNUovUE5YelRDUmtO?=
 =?utf-8?B?aFRwNVhCZ2ZhSzhYb1RoR3VwTkI5V3BKSHZkbUQyWkk5aHlFRnJhTXMvWXZB?=
 =?utf-8?B?NEVXY2k2c2ZpZjRJU2VMZWFUNG9rMG1ieVE4UnptYWJQZ2djbE9LVnVLelpS?=
 =?utf-8?B?RlR0TEJuMHI2L1dlMXlabEgwdkMzK3lHbnlnbGNXT2tpeldGZnZrUEhIREFD?=
 =?utf-8?B?SS9uWXFFTVg3S1Y5d1NCa2VnblIrSmM2ak9yaWdmL3dhbTIwYjluRUQ4U1pB?=
 =?utf-8?B?VlBLV0dkV0R2cUhiL0dIaEtVWUFQeDlOUjRPUTZMNk1EcmRya1VkenBOY0li?=
 =?utf-8?B?bzk0aVNvMjlVR2gyRGdLaGNYaHFaREEzWmk5S1BHTXp2b3o0M29NNlpVMEJM?=
 =?utf-8?B?QzFKUiticXdBN3p4SWZOaEpUQld5TzJJOFdLSEVrbzJMR0E2WTU2TXE3N1lK?=
 =?utf-8?B?MVNjZXBQRksyVEMwcHorSUVJSXVDZm1NSjRrYUVpVTRabXZCV2VPNFVZcVJl?=
 =?utf-8?B?dGVpNkl1VVdsYkVuVjZSSGpyWFE5bE9JOFlwSlBaNE52Q0JLT2E2T3dtM1ZG?=
 =?utf-8?B?SUwrcS9DMkRsYmViQU9pMW1tMzB0SExCbUFRS2c4ZGVRQ0dCNk9ETW9HQVd6?=
 =?utf-8?B?UkZ4QzBCbUdodjhyWXdXZ0NsWnFFTW01UEEzNTNvaGNDdVUrb21vQUFJc0dr?=
 =?utf-8?B?N2ppNWQxaVZQbVJSM0RRNUJxalVRLzlkTytCWVhUWjBRSW1lZGFJSWZzbkhU?=
 =?utf-8?B?R1VaalJoVFZicEZyR2tIZ3pZSTlpd2xJaXFCRm9FSGFmc2swcFFTRXN0T2Ns?=
 =?utf-8?B?ZmtrQ0pIREhmMzhyUXkrOEpWYWQxWWVZMjE0SHRXMjJ0WUVyT0p1d28rQnhj?=
 =?utf-8?B?M0dNa0plQ2NLaTdXUmM1U25sd3FKNnB0Um5EY3Y2UFp5a1lmSWlnb1VOM3cv?=
 =?utf-8?B?c1VRTVpCSElwbG1rUHNnQnVNd1lqNkUvMHUzc254RFBxZFN5b1Bqb2ZMTlVI?=
 =?utf-8?B?Nmx1YmVRU1BwR2N4UFhWYmZHM2hNRERDbTdVMzFZek1WRkZaRFYyRVFGYm1Y?=
 =?utf-8?B?ekpaWkgrcWxxOEdtS3cwN05UeEs1dmF6cytIUlVtRnh3QWRTR3NZVDNIQ3dC?=
 =?utf-8?B?RFdzZjloc3JTODYyOTFxRjJXelJYYlhuNVd3K3JKUGN3aHdxQVE5blowV0s2?=
 =?utf-8?B?NHVVSVBCSXQvNmtzQmc0RXVFcnlCbGE3dXZrMGUvcldhVVBVa0NLZ2xHNkph?=
 =?utf-8?B?cVUzVE5Xc0dCT3dTdkpaWSt5cDVsZU5DdG5CSHFWUFBaeFFLcGFlYU82bUMy?=
 =?utf-8?B?Q0ErS0VORGFqdlhuc2I0RFpwaDk2RGVIbFJYTXJxMDZoVlc2ayt6cFcya0hL?=
 =?utf-8?B?c0FSbmJ0TzRhU1JrcXB2M0oxZmVCRlk3MXNjUDFBTHhSUVNlTDZNb2lHbG9t?=
 =?utf-8?B?b3hOZHljcWNrRURuNEhxbHNlZGJBNDZzKzlCenNldjhSUGNqR0RuVDNHVWNV?=
 =?utf-8?B?T20zdVNuSE5MRjJ3bUFSV1A0WUNwUjFVN3I4ZW1laGkxUEEwb1NJNTcybWZB?=
 =?utf-8?B?N1kvWkxHMWNzbXZJekVtVDR4OWF2WkdobkNiRG92Z0xtUHpnNnVFYVlDQnBD?=
 =?utf-8?B?YmpBWjFML25JRHl0NklBNHhKYmk5OEh4OWtQRVRPNG9rL2hmaGF4U3Mxc0t5?=
 =?utf-8?B?UWZEY05ZdzJVekhFRmFsYVVmbHNlaFBTQ2JiN05Dd2pvMjZQNGFqM2ZiNFBT?=
 =?utf-8?B?YXBROXcxd0J0Tml2WHQvalR2VVRLNTYxK3pIb29vRHBPYWM4aEovQVJIWVRZ?=
 =?utf-8?Q?s7JaFPafUrSaAKsVOJc608c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47427769138ABB42866C192A35C26431@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc158a6d-ac75-48c3-2802-08dd83cf5c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 08:01:18.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIT/iFJ2DD3zweEPTib80g/HMCMHONLQ3NfRjiZGc4IARv1vG6KJPGqN3FOueTy2DgMUcF8ItWo63cKaR9b9+99Clw8vu/9ZF01jr1MTJLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 08:01:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18601

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDE2OjM1ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGFrZSBGZWxpeCB3b3JrIGFuZCBhZGQgdGhlIG1pc3NpbmcgYWJyb290ZnMgcmVj
aXBlLg0KDQpIaSBRdWlyaW4sIHRoYW5rcyBmb3IgdGFraW5nIG92ZXIuDQoNCkkgdGVzdGVkIHRo
aXMgb24gdGhlIG5ldyBBL0Igcm9vdGZzIE1UREEgaW1hZ2UgYW5kIGNhbiBjb25maXJtIHRoYXQg
aXQNCndvcmtzLiBJIGRpZCBub3QgdGVzdCB2ZXJpdHkgb3IgY3J5cHQsIHRob3VnaC4NCg0KSXQg
YWxzbyBtYWtlcyB0aGUgaW5pdHJkcyBzc3RhdGUgY2FjaGVhYmxlIHdpdGggaXMgYSBodWdlIGJl
bmVmaXQgYW5kDQphbHNvIHNvbHZlcyB0aGUgaXNzdWUgd2l0aCBicm9rZW4gdmVyaXR5IGhhc2hl
cyBkdWUgdG8gbm9uIGJpbmFyeQ0KcmVwcm9kdWNpYmxlIHJvb3QgZmlsZXN5c3RlbXMuDQoNCkZl
bGl4DQoNCj4gDQo+IFRoaXMgY2hhbmdlIGFsbG93cyB0byByZWR1Y2UgdGhlIGFtb3VudCBvZiBp
bml0cmFtZnMgYnVpbGRzIGFzIHRoZQ0KPiB2YXJpYWJsZSBwYXJ0IGlzIG5vdyBjb25zdW1lZCBi
eSB0aGUgd2ljIHByb2Nlc3MuDQo+IA0KPiBUaGlzIGFsbG93cyB0byB1c2U6DQo+IMKgLSBvbmUg
aW5pdHJhbWZzIGZvciBtdWx0aXBsZSBpbWFnZXMuDQo+IA0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gwqAtIGZpeCBzb21lIHR5cG9zIGluIGNvbW1pdCBtZXNzYWdlDQo+IMKgLSB1c2UgYElNQUdF
X0JBU0VOQU1FYCB0byBzZWFyY2ggZm9yIHRoZSBpbml0cmFtZnMNCj4gwqAtIGFkZCBtaXNzaW5n
IGFicm9vdGZzDQo+IA0KPiBGZWxpeCBNb2Vzc2JhdWVyICgyKToNCj4gwqAgd2ljKGViZyk6IGFk
ZCBzdXBwb3J0IHRvIGFkZCB2ZXJpdHkgZW52IHRvIGNtZGxpbmUNCj4gwqAgcG9ydCB2ZXJpdHkg
ZW52IGhhbmRsaW5nIHRvIG5ldyBrZXJuZWwgY21kbGluZSBpbmZyYXN0cnVjdHVyZQ0KPiANCj4g
UXVpcmluIEd5bHN0b3JmZiAoMyk6DQo+IMKgIHdpYyhlYmcpOiBhZGQgc3VwcG9ydCB0byBhYnJv
b3RmcyBlbnYgdG8gY21kbGluZQ0KPiDCoCB3aWMoZWJnKTogcmVkdWNlIHNlYXJjaCB0byBnZW5l
cmF0ZSB0aGUgdmVyaXR5IGVudmlyb25tZW50DQo+IMKgIHBvcnQgYWJyb290ZnMgZW52IGhhbmRs
aW5nIHRvIG5ldyBrZXJuZWwgY21kbGluZSBpbmZyYXN0cnVjdHVyZQ0KPiANCj4gwqBrYXMvb3B0
L3NlY3VyaXR5LnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAxIC0NCj4gwqAuLi4vaW5pdHJhbWZzLWFicm9vdGZzLWhvb2svZmlsZXMvaG9v
a8KgwqDCoMKgwqDCoMKgIHzCoCA1IC0tDQo+IMKgLi4uL2ZpbGVzL2xvY2FsLXRvcC1jb21wbGV0
ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMSArKysrKystDQo+IMKgLi4u
L2luaXRyYW1mcy1hYnJvb3Rmcy1ob29rXzAuMi5iYsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
MSArLS0tLS0tDQo+IMKgLi4uL2luaXRyYW1mcy12ZXJpdHktaG9vay9maWxlcy9ob29rwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxIC0NCj4gwqAuLi4vZmlsZXMvbG9jYWwtdG9wLWNvbXBsZXRlLnRt
cGzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MSArKysrKysrKysrKysrLQ0KPiDCoC4uLi9p
bml0cmFtZnMtdmVyaXR5LWhvb2tfMC4yLmJiwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
NCArLS0tLS0tLQ0KPiDCoC4uLi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3Qu
cHnCoMKgIHwgNTUNCj4gKysrKysrKysrKysrKysrKysrKw0KPiDCoHdpYy9lYmctc2lnbmVkLXN5
c3BhcnRzLmluY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQ0K
PiDCoHdpYy9lYmctc3lzcGFydHMuaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0NCj4gwqAxMCBmaWxlcyBjaGFuZ2VkLCAxMjEgaW5z
ZXJ0aW9ucygrKSwgNTYgZGVsZXRpb25zKC0pDQo+IMKgZGVsZXRlIG1vZGUgMTAwNjQ0IHJlY2lw
ZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1hYnJvb3Rmcy0NCj4gaG9vay9maWxlcy9ob29rDQoNCi0t
IA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVl
ci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==

