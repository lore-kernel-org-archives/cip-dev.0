Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD96CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:07:15 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14250.1778166425321851212
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 08:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k19E0o0e;
 spf=pass (domain: siemens.com, ip: 52.101.72.21, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILn+LauNP77SmDcVx3jFBnDtQD7+nnAUC5YR2ampKcGmoWV4gSEFQldGhKf50lQdKhAKPwoSq5Yhdl2vVmx9m93ebkkwc/XurrUVMx9zJ56OIDq5FOApVRpSGiUfBTBaMPWMaW0HxAs34rTrgZGw2PiXKwBnNj1Ih07tRK6aKpFN4Yvfp2vwEZD51u4acX45Om1tM4YNCckCWBaEpnkrOKML4rlpk/6Faf7vqqUQNxuhE5vB/jSC/QH+WzBmIKrPohwiCis4Rlshoz816YAId1U+k91M2PsJsrbQw9901vST7jyjofLxiP+nL3j69iikZ/YH+P4OaKhj4LMgcsmZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+vRxQsurELc8A6hvwmdV9s4PuwmR1zJ6BKbRGgRd1g=;
 b=HJ47X7kDG1ZGsYt3iYXs61WNoKomVLpMA/158ohj/HMFDhoI8wsXJXlUX6sIVPXdsl3ZsHGkSLq9al8QcuwB9TXjZSiiV/2MoFJI0Dw5OyR4xtGd22LIx9oLSjJKxDUx8G7HCRzHlpKuHHrKDLz/AEFc/FGsjrvG7ZV2LUsgvx4cueFRnUgRMFLDLZPUZaCrTH/2DAEspCHo3dt9mTgGwFE8k9gDE1teq7PE2V550LKaz6InKakC5RTEqarQh8U95D45Zv+zdtfAgFmAvBzHQP3RSej8zYDvKSwvR5LhBvIfqIKl4IG7jQhfoyVZbFdTcYrlIeArOXoGSOFpsWMOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+vRxQsurELc8A6hvwmdV9s4PuwmR1zJ6BKbRGgRd1g=;
 b=k19E0o0emyfQOg4kU/3gwRRiPP70OoKRX3Z/eCw9MqoFR9TP7oMFqMlU5ShV2Lhegtp7S4YhaTjsDFJiwnUvlkyAe6hQ8gOfBNIxjgUPiAfs9/Ek0QUwuO27vYdPUJX6HSeQLLEKVNHzalGc3dBdxtFXQXUc4tGTTQZ5YNiyU86l75bgaxfE8ryJ5UEUQzg4XYzg8Laa8n+er9uLyXTJqUc9D/Q7xSrALCh6dbo8efwuost1yra8y5vh4Jy9j0vL88XpSA4iA5v/fLaezQzCaot1BaVwwPgWQC6lrCRaz3R+ZmBatu2SPQlqyIlH1RQGkxaNTT4ldrLBpLZ3SxUWHw==
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:110::12)
 by DB4PR10MB7446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:07:01 +0000
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599]) by AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 15:07:01 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v8 3/8] Add factory-reset
 initramfs hook
Thread-Topic: [cip-dev][isar-cip-core][PATCH v8 3/8] Add factory-reset
 initramfs hook
Thread-Index: AQHcLeHcByP91m7yMECWlRqz8nRGY7YEBi6AgAACroCAAAGwgA==
Date: Thu, 7 May 2026 15:07:01 +0000
Message-ID: <2266d3e5d22432f821dd37e04fe5f1045edfe0f3.camel@siemens.com>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
	 <20250925060009.1711605-4-Quirin.Gylstorff@siemens.com>
	 <357ee0ef6de6cea2e0a7eceedbe6aff35a122315.camel@siemens.com>
	 <1738efcd-5593-4eff-a09d-b85666ee0c35@siemens.com>
In-Reply-To: <1738efcd-5593-4eff-a09d-b85666ee0c35@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB2546:EE_|DB4PR10MB7446:EE_
x-ms-office365-filtering-correlation-id: 298734c5-a7e6-4d2f-93c6-08deac4a4ab7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 Gc3brrOvhgi3516UnhcQZahQEfrtR3CDpxdBcZbjba7pbtKbfbjU46fL8V4Ego+ONV8o7Qo1feVW6xmQ5Ib3C0lFei/zMtMis7SDMLi9ZJSLOyzCiNnZjombJ9SVPGInIJjdlNEz6F80fwlCf4AAwr8894/yq/qCn4mmnyklyiV+LQSNiFp20I8aYNqwu98k/OjUjKutfy7Qgg6bIIgMPRFl78tJ1UA4dBBm8VWJ80W0c2oNqwnS1zVerMIBRAUANNfGtA6Vf13pY25jQvhH7muYwNdofdjNA0ahASUcztImJl6ex2UE6ccxLSNO+oBC6ht9HG2pFsVq2gQB1XnFQgoU1hOccl8EerulGh/A/isT03LtFXLofsQZVnv1lfXUeZ1q0v7/deo9NhbKSWsZFK9YERCLDpO4Nk5B63OvRkH8M1mJjHFdf+ndNI37O+ylbf5zOMk8mWqdQ9nmsXEfgceKjTI/Q0r/1FOh1Zi45Ikz83NdQTjyMxBfjO6Fx3f5F9cUbIcZD2valB7+yfmAX0QVRpknVSgfMK41UqxbZ2zO+M9LbHQi29ode3GS/FAr8/870dk3k1twS6aw81HPyi6Xe9XWqrm3XNwJTibp17hgFIQYV17yD8+/C5PlT2vtkQMRi+Dt4brBd2pAo6EyRdrfcVb0KxpMy2Xiu8gS2bo3EiDam4HuaaWw2RNpwYd2x2xq3oFYVE5WIYHS9FjxLnPM5assCoy5iD+JPKB6pmF+SgMaj4cACMxJMxcdarlD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TWtTZUE4TVZ6YklzcGdmVWhORGROMUNPeWFZMHdhR09Ed3cxY2NUdEFaaTVV?=
 =?utf-8?B?VDlJWUdOVzlFN283RnlyNndxWUdFeEVqbDNuejZTM1pZU1phWnpaSWZ0clhx?=
 =?utf-8?B?WGpVMlh4Z2MxdDhVMy8zYXh0RExWT3lOZzQrcFdnWFF5ZWxvZGNYSlAvNDEv?=
 =?utf-8?B?ckVvTEFISFgveGFVOEFsaEg5OEp0eGdJUXBicnI4WG5QcDhsWWNPZWRSbDls?=
 =?utf-8?B?TU9EemdnN1ZSbmZpdXBzSnBieGpsb28yNWVmdmRDbkNicGFwbmFwdjBNL3pR?=
 =?utf-8?B?eDI4aE8xbUhEOE1pWnNFTnZwbHRkV1N5WDF0ZThCK0pjNFNGU1NOVjZRYk0z?=
 =?utf-8?B?ekFGeE5kN1lPNDF3RDA3VHhWK0NGZDJLMFV3VFkvOHJUR2VGSm1ZZWR3WFF2?=
 =?utf-8?B?bFR1NFBOTHV5elpXcy9YYUVUUkVxVzkycWprUCtxSGtLdHB1c2JOWElOZkFl?=
 =?utf-8?B?UDdBOWJiKzZXc3JnMS9aUCtKMklnU0w0cjUwNjFwRGRPamg1Unk4T0lFR0FM?=
 =?utf-8?B?elJQdVBEVVlTSFM4c2F2NDFLMytUR0NXTXBvRXBWd3N4dzBBR0xDdytVQnhC?=
 =?utf-8?B?Vk55REpXSjVwckFyb2dnZ2dJT3VVWHBQbGJ6dE9aRWpheTFCaTZkdkxGMHpV?=
 =?utf-8?B?M2tjNStzY3VxZDBnY0tEN0FvazgyQUptNEp6ck9VMTczQWsrREdLVGFvRzFx?=
 =?utf-8?B?UDcrSHdMcm1wU0t0ZjF6VngzRWkzZUpyMlVKbU5sWUhoZVR1dUJUNHJvOUF1?=
 =?utf-8?B?am9veThpS21Sb240cmkrRzdFUDNlVDRUcmRJZ3ozcHpQRklmUGg4Y2lmNTRr?=
 =?utf-8?B?citQWHEyWFNnRTFwWjZpdG5mOUZzS1U3RnFiaForSTMzc0lTNlNTeWx2WSsx?=
 =?utf-8?B?ai9MZmdpdUVBZDZoVjArOWg2cTVIVXpwbkI2S21JdWx6VjhUMzFXSzZCM0o2?=
 =?utf-8?B?RDlSVlV6WkRGWmlqUDYybW9LWmZXeEdiZU80NnkzS3gzMFhjQXRSZHBOWUNw?=
 =?utf-8?B?UmN3L3c1MWpSUWJObUV4QU1hSFdJT3FIM0JnVzhNTHZVQ1l2TmUwZEpabmxU?=
 =?utf-8?B?UEhPOEVDWDkvYkI5ek9mUWZzMWp6SnVWSjJYRW9YY3hlUTdsQUJ5UFhUNllq?=
 =?utf-8?B?eThoM0tlZkF0ZUNmT1g3dTFCZE9EZDV6Q2VSeHpjQlRTWXpzU1VGN2lXZWVN?=
 =?utf-8?B?THNpQVdFYThhRk94UFl3LytveXJWMFlXcjFXZFQ0d1BKbW1udmx3UHFvaHVO?=
 =?utf-8?B?MjA2UlBSSm84dmpYNmNFR1dNRHJVaGFYN3JRMis2NFVHbXp4K0hnSEwrT2tY?=
 =?utf-8?B?aHdnTkVSNWZFdGh1WlZFMWM4S2Rwei9pUk02REd0RHZSYisrdXlya3p6bEFM?=
 =?utf-8?B?VDJodDEzd0hiMFJ6cjUrTGIrQlRjbDY1dUFyS3V6eGtFS1UvTGptVkRLRlpW?=
 =?utf-8?B?VWFBbk44cEtsZndrODFadTFUTXc2ZU5kb1pyay9aemNGaG5PQ1NieVlBYlZ0?=
 =?utf-8?B?SnBwaUxKTWJZelpITXpUT0dXSGtITU9ONnRYTndMcURZbWsvaDBmNkRCM003?=
 =?utf-8?B?VklkQUw3QTJPZW5GY0ZHNUpWdm1yR0IzN0JDY2tOc1I1RkpSY2lhTmhzK1Yy?=
 =?utf-8?B?RDgvTjFpYlN5SGp0UVFteWU5ODFUVkYxRlBkQ2ZjNC9ma2hvb3NzcS8xMUMz?=
 =?utf-8?B?M2NuaFJ3NEE4a1FaZURFMXlSOGxMQWFPeTI2WjQvcXc0MVJUcjBpcTBPTXU0?=
 =?utf-8?B?VjJVT1YwVXRuS3lsVXU1Q2dZTlJvZjdBS2dOUzJFbFp5R0pYbThrUjdxZUdi?=
 =?utf-8?B?UzRKd2FWRkM1WU4vNlprR3ZHMm1MMTU0WGhlZFdIK1MrWXhGMW11VHlLdWky?=
 =?utf-8?B?MnhJVjd6RjVDNWxtNXJIK1hYTnoxeHAvamJvVlR1RnlDajNFZ0pIMms3c204?=
 =?utf-8?B?Z1lscTgvcWJJSHQrZHdXbjFHTXA5TjlwNFdIWm01aTFvaXA2eXl3c2FocGFF?=
 =?utf-8?B?NXJwYUNLT040OGdiTkRqYkNxNVZMK1pqenlEWi8yZDZYUmtqYlI1cklOYXMv?=
 =?utf-8?B?b0IzdVliazhnRVNwc1h4Q0toRVpFS3Y0YVl5Q05lQXYwTFVIUkxncFhqaUVO?=
 =?utf-8?B?Z1NDODNsM1pDV1drMStUeXQzc21JVk9uK1g4MU1IR2Uvemtna1VZbVQ0UFdy?=
 =?utf-8?B?NzV5Zk5UR0lQUFVObS9TWGNDQTB4VGhqbUxHOHpQSEFOek9JM05ISThsa090?=
 =?utf-8?B?UDhwK24wa0RoQTMvVTNqMDNDSWd6WWFlYjczYjBPYVlZcDduRllrYTllSDZw?=
 =?utf-8?B?Q1F1TkZrTTY5dmViM0NVVHB4OG5IUm1yV1hwYXdJdzQvTlBRNng4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <202CD94F428FA34AB1BB86CE086FA5EE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 298734c5-a7e6-4d2f-93c6-08deac4a4ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:07:01.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGvr4zjyBsMddZn78xF6CeW5aVqFJCuYnWr3sdfTYdmqE9usSXCCmPmOTF2SPxhPu2ll4FxayYCTcnxdxJ6Yz9A/ln3eeMnYPQKkYHdw5c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 15:07:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22911

T24gVGh1LCAyMDI2LTA1LTA3IGF0IDE3OjAwICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDA3LjA1LjI2IDE2OjUxLCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gT24gVGh1LCAyMDI1LTA5LTI1IGF0IDA3OjU5ICswMjAwLCBRdWlyaW4gR3lsc3Rv
cmZmIHZpYSBsaXN0cy5jaXAtCj4gPiBwcm9qZWN0Lm9yZyB3cm90ZToKPiA+ID4gRnJvbTogUXVp
cmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiA+ID4gCj4gPiA+
IFRoaXMgYWxsb3dzIHRvIHJlc2V0IHRoZSBkZXZpY2UgYmFjayB0byBmaXJzdCBib290IGJ5Cj4g
PiA+IGZvcm1hdHRpbmcgdGhlIHBlcnNpc3RlbnQgcGFydGl0aW9ucy4KPiA+ID4gCj4gPiA+IFRo
ZSByZXNldCBvY2N1cnMgaWYgYSBmaWxlIGRlZmluZWQgYnkgdGhlIHZhcmlhYmxlCj4gPiA+IElO
SVRSQU1GU19GQUNUT1JZX1JFU0VUX01BUktFUgo+ID4gPiBleGlzdHMgaW4gdGhlIGRldmljZSBJ
TklUUkFNRlNfRkFDVE9SWV9SRVNFVF9NQVJLRVJfREVWSUNFLgo+ID4gPiAKPiA+ID4gSW4gY2Fz
ZSBvZiBkaXNrIGVuY3J5cHRpb24gaXQgd2lsbCBpbnZhbGlkYXRlIHRoZSBrZXlzCj4gPiA+IHN0
b3JlZCBpbiB0aGUgVFBNIGlmIElOSVRSQU1GU19GQUNUT1JZX1JFU0VUX0NMRUFSX1RQTSBpcyBz
ZXQKPiA+ID4gdG8gYDFgLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0
b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICAuLi4v
aW5pdHJhbWZzLWZhY3RvcnktcmVzZXQtaG9vay9maWxlcy9ob29rICAgfCAgNSArKwo+ID4gPiAg
Li4uL2ZpbGVzL2xvY2FsLWJvdHRvbSAgICAgICAgICAgICAgICAgICAgICAgIHwgNDggKysrKysr
KysrKysrKysrKysKPiA+ID4gIC4uLi9maWxlcy9sb2NhbC10b3AgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDUyICsrKysrKysrKysrKysrKysrKysKPiA+ID4gIC4uLi9maWxlcy9yZXNldC1l
bnYudG1wbCAgICAgICAgICAgICAgICAgICAgICB8ICAzICsrCj4gPiA+ICAuLi4vaW5pdHJhbWZz
LWZhY3RvcnktcmVzZXQtaG9va18wLjEuYmIgICAgICAgfCA0MCArKysrKysrKysrKysrKwo+ID4g
PiAgNSBmaWxlcyBjaGFuZ2VkLCAxNDggaW5zZXJ0aW9ucygrKQo+ID4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1mYWN0b3J5LXJlc2V0LWhvb2svZmls
ZXMvaG9vawo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1mYWN0b3J5LXJlc2V0LWhvb2svZmlsZXMvbG9jYWwtYm90dG9tCj4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWZhY3RvcnktcmVzZXQtaG9v
ay9maWxlcy9sb2NhbC10b3AKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtZmFjdG9yeS1yZXNldC1ob29rL2ZpbGVzL3Jlc2V0LWVudi50bXBsCj4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWZhY3Rv
cnktcmVzZXQtaG9vay9pbml0cmFtZnMtZmFjdG9yeS1yZXNldC1ob29rXzAuMS5iYgo+ID4gPiAK
PiA+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1mYWN0b3J5LXJl
c2V0LWhvb2svZmlsZXMvaG9vayBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1mYWN0b3J5
LXJlc2V0LWhvb2svZmlsZXMvaG9vawo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gPiBp
bmRleCAwMDAwMDAwLi41ZWEzMjg4Cj4gPiA+IC0tLSAvZGV2L251bGwKPiA+ID4gKysrIGIvcmVj
aXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWZhY3RvcnktcmVzZXQtaG9vay9maWxlcy9ob29rCj4g
PiA+IEBAIC0wLDAgKzEsNSBAQAo+ID4gPiArIyBDb3B5cmlnaHQgKEMpIFNpZW1lbnMgQUcsIDIw
MjUKPiA+ID4gKyMKPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVAo+ID4gPiAK
PiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4gPiArUkRFUEVORFMgPSAiZmFjdG9yeS1yZXNldC1oZWxw
ZXIiCj4gPiA+ICtERUJJQU5fREVQRU5EUyAuPSAiLCBjb3JldXRpbHMsIHV0aWwtbGludXgsIGUy
ZnNwcm9ncywgYnRyZnMtcHJvZ3MsIGF3aywgZmFjdG9yeS1yZXNldC1oZWxwZXIsIGZpbmR1dGls
cyIKPiA+IAo+ID4gVGhpcyB1bmNvbmRpdGlvbmFsbHkgYWRkcyBhIGRlcGVuZGVuY3kgdG8gYnRy
ZnMtcHJvZ3MuIFRoaXMgaXMKPiA+IHByb2JsZW1hdGljIGZvciB0d28gcmVhc29uczoKPiA+IAo+
ID4gMS4gdGhlIGRlcGVuZGVuY3kgYmxvYXRzIHRoZSBpbml0cmQKPiA+IDIuIHRoZSBkZXBlbmRl
bmN5IHB1bGxzIGluIGEgdHJlZSBvZiB0cmFuc2l0aXZlIGRlcGVuZGVuY2llcwo+ID4gCj4gPiBU
aGlzIGlzIG11Y2ggYmV0dGVyIG1vZGVsZWQgaW4gaW5pdHJhbWZzLWNyeXB0LWhvb2ssIHdoZXJl
IHRoZSBidHJmcwo+ID4gZGVwZW5kZW5jeSBpcyBjb25maWd1cmFibGUuCj4gPiAKPiA+IE5vdGUs
IHRoYXQgd2UgYWxzbyB1bmNvbmRpdGlvbmFsbHkgcHVsbCBpbiBidHJmcy1wcm9ncyBpbnRvIHRo
ZSByb290ZnMKPiA+IHZpYSBleHBhbmQtb24tZmlyc3QtYm9vdCwgYnV0IHRoaXMgY2FuIGFscmVh
ZHkgYmUgY29uZmlndXJlZC4KPiA+IAo+IAo+IFNlZSwgd2UgYXJlIHdvcmtpbmcgaGFyZCBvbiBt
YWtpbmcgYnRyZnMgaW5ldml0YWJsZS4gOykKCkFuZCBJJ20gd29ya2luZyBoYXJkIG9uIHJlZHVj
aW5nIHRoZSBmb290cHJpbnQgYW5kIGF0dGFjayBzdXJmYWNlIG9mCnRoZSBpbWFnZXMgd2UgZ2Vu
ZXJhdGUgOikKCj4gCj4gRmFpciBlbm91Z2gsIHRoaXMgc2hvdWxkIGJlIGNvbnNpc3RlbnRseSBj
b25maWd1cmFibGUuIE9wZW4gZm9yIHBhdGNoZXMuCgpXaWxsIHNlbmQgYSBwYXRjaCwgYXMgSSdt
IGN1cnJlbnRseSBhbnl3YXlzIHdvcmtpbmcgb24gdGhpcyB0b3BpYy4KVGhlIFNCT00gcmVhbGx5
IGhlbHBzIHRvIGlkZW50aWZ5IHRoZXNlIHVzZWxlc3MgcGFja2FnZXMuCgpDaGVlcnMhCkZlbGl4
Cgo+IAo+IEphbgo+IAo+IC0tIAo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dp
ZXMKPiBMaW51eCBFeHBlcnQgQ2VudGVyCg==

