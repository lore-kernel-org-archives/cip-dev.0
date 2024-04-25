Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884DC41513
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:09:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.15216.1714046799756294891
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ySCT1OTW;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtkJZonp3GtCq4K+DqHLPLaWMhkndvmMtAZtM9rbZm/aQGpYYeIJ5fLrCwbFSW9GWENkBteCIlwZawqe18Axp6eIot+nqunn3FHe/SrmQO8ydqlL0iUY2rLQa3Z2CKPXnNdSLhDYwDaB7SqZ9Ga4iQ2vzw0hsNRVLnF9dBzjKr5Rgx1dMTpm/GVl8W5yH4Y+IZe68EuicWcpTh7eTVNZLdYssaxiRXmifnDlnxeS8ELVefFCc7SzY60Z36mZE7CmWIY2FIP1tCXHGVUI9+PE7ovkfGA8fd+HTEjwk73MivAKtMNz/3UTxC4x0d8VwUV+1Ggt3L7u7SMebLMOFMDVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLpBrDOQroEbdO6FaquuhjeSvzgV9embciAyjrrMXxA=;
 b=e+ohQk2weC9qt2NJR2+VcrNtZMUFnlFP/A1DQ9uu10l5Oy6m4G8hORn8MgmTpbaQW+Vh9grHFSds/RJFOXeKZQyFt0wpsvuDbiD4W1jWEOKGwi7qb5s5m+UVgoNphLiMpU25ANYm42mRGfV3yjPFruyR53H0UPp7vMJGOWk2Eq/oU0qJQWjLbITQgo8cq5r5u11vTIcT9UByRg14+rPybfezlC6WxK4NkfsTg/QRcW+B0kGZeCMCvZac5dDqMKvGM6/D2QyDFtIYjli4vS2Riy4/u1E69Oe0aWNuJMEZ8UNztzfWxqA6coxD46dv87lvpdNmCqDxzyKS2IkXUDnC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLpBrDOQroEbdO6FaquuhjeSvzgV9embciAyjrrMXxA=;
 b=ySCT1OTWI3czgLf6+ITSFuJlMBF5sxNRO9oq48Nd0WwRt1ksKbiWhTZCvyvvYhWyhGxq1Gi95/PuyfO0aDOZmnKRdrar+a2poTdLvs1VcwnY5H/2NKjoRmjirLl2kM++05L9Tir0dw6fSuxBmSGfyRscRih57xmmjL6SC8ubIwFA3P+I6UO1kCqsTYjImo3UtOMT6Fu0vusGpazgXeFuZqXijbA9qzohoH4MBA5VM4TbbxVgOjVSf/OjbUoHSdsV2owXDUGKLPxpxKrBzgaZH5RJLHW+C3iA6rV00/UklgEA3k5nqjcCuoextRTeUwRrc7wtmG8WUHGHIDWRvMe52g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB8029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:06:33 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 12:06:33 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/9] fix: use luks2 to identify encrypted partition
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 4/9] fix: use luks2 to
 identify encrypted partition
Thread-Index: AQHalwblbZ0VnlQf9ESHMU+nUFl9ubF44/gA
Date: Thu, 25 Apr 2024 12:06:33 +0000
Message-ID: <a225004498fa9569d635d96e01d460ae8b9b3695.camel@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
	 <20240425115119.813384-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-5-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB8029:EE_
x-ms-office365-filtering-correlation-id: 71b77183-934c-4ad2-a17d-08dc6520266b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MXo5c0pwRGwyRnNxdTRjVnAxczdHVnRBdE1SMWVBbXdqcHF2d2VGbFBoUlN1?=
 =?utf-8?B?QUVWSlI5Qy82eWFrWEVFRUNYTWRzSlJHa2M4cmphaGlHbGN4U1Z3S0ROVHFu?=
 =?utf-8?B?dGV1aVIvN2k1S09WME0rVE94TlB2UHdidnJMWTZMZDlud2s3SGRWcHJOMDdN?=
 =?utf-8?B?TjQvWkc2Wjk0K3VwcnpOOUhzcTJsUzhMUmh2TnBoYStMMk1RT1pra2NhMU9X?=
 =?utf-8?B?aFZLMWhYZ0JCQ3FJMDZnQVFvdUZSYnEwV2NpVHpSWTFFTUdDczg3S2RzLzE1?=
 =?utf-8?B?YWFDQlJoU1ZwZ0k3WkRoeFJYUDdBcFRmVm9YbzJlU0hMUHhWNU1iamEvTS9I?=
 =?utf-8?B?cUlrV1JQUmRxOXVaUXhkV01VUmJ6RFJFL1FXNE5XMlhZbXRta0ZKbm1Qa1ly?=
 =?utf-8?B?UTh0RVhtRWEzMGR5SGhNVXJ6ckt2MFRGQlQ5QlhYeElwcTFtTVNkNGxSTzlD?=
 =?utf-8?B?YVhLZk41ZHhmbHFHejNrOCt0ZTAvd3FOaUY0SjdQVk5kTFF6SzFkcXRNTlRY?=
 =?utf-8?B?dWZveUdTWkxRdm9yaXNiYUxWRWVWZkY4d1dPSkhDR3dSb1BRQU9XeDdDSlJN?=
 =?utf-8?B?ZGZUZlhsZWRDRzlFeVBpWWNTaHY5U0J1NGZ0Mi9rZ1NMeVpMaFpRQnE2VzQx?=
 =?utf-8?B?RW91ZEplcXBaSjVUbFdPSHIydjlzYklkZVhURUN0WDFjWTJ0enFDSUhITCt3?=
 =?utf-8?B?dzNmYXl0MHN2WlZGRHpsOCt2TUNlRUdGMzVNZkF3Snd2YU5iN09FT2pEaElB?=
 =?utf-8?B?TVpLeEVXcTdKeFZvamJ4RGpEL0o4Tm9VR0F1bHdXNDhYc2ZGWk8wcFZZTGJV?=
 =?utf-8?B?TTZnM2t2NE1DMUF0VTEyVHd5a0Z4eFNlc1E0bC93Z2l2QXZCWldsQkxiVGF5?=
 =?utf-8?B?VkhzMk9EVmpYNHRmemVIc3haZi9kNTFCK3kyTTVvYWJRK0VFVkhaMVNGemJV?=
 =?utf-8?B?QUp0WkFxdGFhVjZuaU5icys0WWFGOC8xM0VFWE05R2pOSS9rNlVPdlY1VHJH?=
 =?utf-8?B?Y3JnUS9UUFUrRVYxYlNmeWNIQ2NUdVBUanJ1ck9la05yemNaa2pEcUphdnZG?=
 =?utf-8?B?NHlUQS9sL1NqZk1Nd3RtWkpCeVNBdDZ4NHFjUEpmRWdUQlJibWFML3BjVDRW?=
 =?utf-8?B?K05MT1dzSGV3NWpNQzUvTHhtbjMyWmNyUmU4czJ2MjRXcnlhRnBzaUtqbDZU?=
 =?utf-8?B?V0F6SVRQNW5CVmZiRm5ZZkMycGpoV3AwMnplMXh0STVKcFR1ZEZBTkdvaGFn?=
 =?utf-8?B?UzJsUGVsRXR4aEsxRllBSGNyZnd6dEgyOFVWSzZTeXJuSllYdXowbmhqUzFm?=
 =?utf-8?B?OHNlOGlCTnZTblp3KzJobkM5c29nSVZPWHowdVJWL0Nrd0hCWmRaekdJM1lk?=
 =?utf-8?B?OThiblhNMVk0NUp2SDZrVUNpa3d2SjVJTGliRW40c3NlL3l3U2ptczB0Zlpj?=
 =?utf-8?B?Qnp1R2MwTk9MOGdITUNaNk5CVTc2bnlOQjhrMVh2K0NaMGNITVFFenQwdGhT?=
 =?utf-8?B?cGtETnQ5WXNMTE9iMmNxNkJqZHE0YkdSbnd6cGVEK2U4OCtBL09ydkhhTU13?=
 =?utf-8?B?WU5iQzRMd1BKY1RoL3Zla2RIaC9mN3JIdzdNZTRxamozSDFXeExGZE16U2NB?=
 =?utf-8?B?Z0w4ekkyM3V0TFdqZWt4WnMwYkJWcDRCTHp5cjRNUGJzeTRydnoxREt4aWh5?=
 =?utf-8?B?T2pKcDE4c1gvOUVjM0xycFNIQXh5WEdzaEZ6Wmg4MmlraVliZ2FPdzlITHBT?=
 =?utf-8?B?NStXNjZRNTFlMW00Vml1R1RRNWIwR1lKeTBTV2Q0S3dyMjJyYU1vM1d3QW1D?=
 =?utf-8?B?OUhXVzVXbmNpSkN6b0UrUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WFpSdVR1SEVnV28wOU5jenNuMnNJMmNxZG91S29GcTFrZDZtVzU1U3dJVmt4?=
 =?utf-8?B?RGg2SVBRK2FnOXBTNEtyTTg3eXNaS0dlYUc5dTVtRmlRcGZtc1cxOHpZM0c5?=
 =?utf-8?B?NEtyY2ppVFgzYXRuMW9aYmRrY0xzZEpxU0JFaUxKYlFXeC9oaW9mQ3NNMWdv?=
 =?utf-8?B?N2lMQlJXeVgzRlU2d3RoRGU0TjkyQUo3U3RpUldvY1ZFTFJWQ3dqd2VKZXR2?=
 =?utf-8?B?cldOU0wyelBBK045UTUrK043cmdnZVhDUnJCWVBtangxZU9GU1NSd0lLSUk4?=
 =?utf-8?B?NFlIRU9Cam11RStMc2xnK3pzT1VvOW5MR0lTWTdXOGZCUVAzcTF3c2xXSW91?=
 =?utf-8?B?VllCVE9abGVkdnorb0lIbFpHTjhaSDR1K3Q5OUhCYTFzcGRrV0I2cHJPU3BH?=
 =?utf-8?B?RGQreFp5anFBU3JLZFJSTytGSWVSNjVKc3BSWEVnNy9WYjNZWVFYN0JrYm80?=
 =?utf-8?B?V2xVc2VoL2pNbGh0enQ2WFB6S2NYa0UvcjE4Rm5uMHJwbXBiSS92YjE1T1lQ?=
 =?utf-8?B?ZlM4U0ZnTzNFdFhRWS95TmxTV1VOZlZBZjAzdlJuZllnN2t2WGw1MzMzK2pF?=
 =?utf-8?B?Zm55dDJWOGNFcC9PS1lHQXVVTHZkM3hUbDJSZWZ0SXUwTGpBbFZ2Nnp2WCs4?=
 =?utf-8?B?Z3NuUS9oVWxTcVl6aUVmZWFoRm5BVEdEQmJ3NUtWNVkwWHZaeWlKcTFXRlRt?=
 =?utf-8?B?MWVBQ1p1WmlJS3ErOXo3dTVuc3o5djRHcWpQZ09MZWFwTlhhaXNCdTh4WWVK?=
 =?utf-8?B?Mk52RGVudjZpdGlqTTBaa1IyU09kVkNUTlplYTI2SDJaMG90NzBoMjIzMEho?=
 =?utf-8?B?eHIyYXo1Z1ZySXhldHNCTjY2eG9BVmlGZVlmZmZ0alhCZGZxRWpMZmZyUkpX?=
 =?utf-8?B?K080c3VqMkVWaEc2ckdHWmpiYS9GVDlwRHRyY2hQZUd3M3NOZk51S2FsaVE2?=
 =?utf-8?B?eXFJQjA1VFpPaWdBQ1BUcmZzRGU2YmJ2ajhJQkxsM1lsVjdJRC9HRWNpR3Zy?=
 =?utf-8?B?SStKb0dWN2FkSHZxUGo4cklMdS8rWnJ2c2c2bEhuUjJsKzM2NGdjZHZrWEk3?=
 =?utf-8?B?aDEzeG9ic1dSN3JtUWxkbjJLVG9vaU84NHQzSTM5cHF3bU1aT3FDNTB1d0l1?=
 =?utf-8?B?cFltOGE5OTdqcVRhYUpnVzFZTTZXdFB4WDNMM1BwVUIwTWpnV2hxSnJTcGtn?=
 =?utf-8?B?dDM5NTU0N1JvZEFGQWNJRU85M3daZGc5ZUsxczJOUG1rczBGZC9XZHNoMzRB?=
 =?utf-8?B?aUoxOS9xNUlKd0VnN0lITkV2U1ZCNENST0sxTlY4UDk3NFdYaEpwNXZRSm5w?=
 =?utf-8?B?ZkRuQ01JWFJrOFBnNWs0dnNCVG9mY2dUR3JJVGhTbFg5eldkMFhwY3hRUE9x?=
 =?utf-8?B?ekgvckhVcHp3ZWlyeC83TGQvNFNLUTR5eThnWHJYRFNHQTZTRjY1ZThSaElm?=
 =?utf-8?B?Mm5Wd1N6YjUyVTg5bTdJaG8rVWxtVnEvUk1rc3dad0QvNnFyMjlnSzNYd1Zy?=
 =?utf-8?B?QWlWR0FVRi9kamRmS1RmV2J3TVF6eG90VTdSTzFzZ2ZHVnIxTVNBRVFWRzZE?=
 =?utf-8?B?NUNSQWpxWUdBZmptbitZZVlBdlBJSGFzREs3VE0vUDRudngyQ3AxSEpOVzB4?=
 =?utf-8?B?dDVFZFJDVnBOMGp1REcyYkU4Tk0wNlQvT0VjTnZiUFhrSW5kMUthK0ZnZjFp?=
 =?utf-8?B?enhGbFY4QitvQVloNHc4UFRyOGNVZzdaLzhxaUhONHJCNTdnZHNPc3VmODJv?=
 =?utf-8?B?a1FmVXNPMFV1TTEwNjNQajAzbmFMd3hJdURXR1FJbGlOeUdDaXl2ZmsvS0F6?=
 =?utf-8?B?RXRwcUxHK0tFNTFubXVCd2R0R1FGTFkrTjFiRW5JMlh1QzVXRXFXLzNaL3Az?=
 =?utf-8?B?R2MvbFptRklOK3JnSjV2Q1U3QjA4NHlaVkJCc0sxeTNpejBpbnFaNjgyWVFT?=
 =?utf-8?B?bkZ0U1NpdzRhVEFzME1oOFFBbzdTUmhCRzM0dFdzdlU0Y3FIRUp4bFBUeHIr?=
 =?utf-8?B?bHI3SGVLWHNQWllRUWdCaUplSjAwMWcyRTVQRnQ0TXJMajRoQlVBVXhzSXBn?=
 =?utf-8?B?RXhhQXAxVkszdE5BRm5sZ0J4WGFEQ1VSL1U2ck82eDJDaG5wNjhZalU1SXRG?=
 =?utf-8?B?WmNMVGdTaXJWUDJFZVBvempGaDF5L1ljK1EzQ09uSldPNXd3ZlU3bE9qWUtO?=
 =?utf-8?B?MlRVc2VKTlZ6TmZ6RU1BR0FUQnVFZ1RGUjJYOFRPZWdGMGpIRStySE5jeFZm?=
 =?utf-8?Q?eQpjc3dVYfEXjy5XnsAi4ZFiJhBs+1ymnpIheTSr3s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b77183-934c-4ad2-a17d-08dc6520266b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:06:33.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53RkZKJtHfcmk1GX1fdVCVWIsJ5B2Gyhk7iaLsjPDuyrNeQnF7QshMNNU3MvTxAcDxcor+WZDUcT9e0uBjacYML6j6OfJX6aexhISYQR/Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8029
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <575F07CE81E09444A9926DB976BB5389@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15763

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEzOjUwICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBmaXhlcyBhbiBpc3N1ZSB3aXRoIGVuY3J5cHRlZCByb290ZnMgZHVyaW5n
IHN5c3RlbSByZWJvb3QuDQo+IFdpdGggdGhlIHRva2VuIG9wdGlvbiBpdCBjYW4gaGFwcGVuIHRo
YXQgZHVyaW5nIHJlYm9vdCB0aGUgbm8NCj4gdmFsaWQgTHVrcyBwYXJ0aXRpb24gaXMgZm91bmQg
YW5kIHRoZSBib290IHVwIGZhaWxzIGluIHRoZSBpbml0cmQuDQoNClRoaXMgaXMgYW4gaW50ZXJl
c3RpbmcgdGVzdGNhc2UgZm9yIHRoZSB3YXRjaGRvZy4gRG9lcyB0aGUga2VybmVsDQphbHJlYWR5
IHRyaWdnZXIgdGhlIHdhdGNoZG9nIGF0IHRoaXMgaW5pdHJkIHN0YWdlPyBEaWQgdGhlIHN5c3Rl
bSBoYW5nDQpoZXJlIGZvcmV2ZXIsIG9yIGRpZCBpdCByZWJvb3Q/DQoNCkZlbGl4DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVu
cy5jb20+DQo+IC0tLQ0KPiDCoC4uLi9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9lbmNyeXB0
X3BhcnRpdGlvbi5zY3JpcHTCoMKgwqDCoMKgwqDCoMKgIHwgMg0KPiArLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gaG9vay9maWxlcy9lbmNyeXB0
X3BhcnRpdGlvbi5zY3JpcHQgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtDQo+IGNyeXB0
LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+IGluZGV4IDUxYzgxZjMuLjY4
NWQ4ODIgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0N
Cj4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQNCj4gKysrIGIvcmVjaXBlcy1p
bml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9u
LnNjcmlwdA0KPiBAQCAtMTM0LDcgKzEzNCw3IEBAIGZvciBwYXJ0aXRpb25fc2V0IGluICRwYXJ0
aXRpb25fc2V0czsgZG8NCj4gwqDCoMKgwqDCoMKgwqDCoGZpDQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAvdXNyL3NiaW4vY3J5cHRzZXR1cCBsdWtzRHVtcCAtLWJhdGNoLW1vZGUgIiRwYXJ0
aXRpb24iIFwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB8IGdyZXAgLXEgInRva2VuIjsgdGhlbg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHwgZ3JlcCAtcSAibHVrczIiOyB0aGVuDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgb3Blbl90cG0yX3BhcnRpdGlvbiAiJHBhcnRfZGV2aWNlIg0K
PiAiJGNyeXB0X21vdW50X25hbWUiICIkdHBtX2RldmljZSINCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb250aW51ZQ0KPiDCoMKgwqDCoMKgwqDCoMKgZmkNCg0KLS0gDQpTaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

