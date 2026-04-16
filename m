Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17113F8D755
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:44:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15975.1776350675667598423
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:44:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tuFVMvT9;
 spf=pass (domain: siemens.com, ip: 52.101.83.71, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAZr+GGUNTxlokZ+wUMaJw7nEqVnJYynqnOiW4iiCLdo8iG56pDubDsTZsQAGVwCAGTB5h7SVKp17dxnpl6gscvUu4UXVOSIlljTrZty+tsz7NcmKev82DSoH25O08NZtslYuS+nV2nCN1RJOsbHGMkzvmhbzuG9SCugRk7YJ4XxOZBSkFCXw0DJQeHh7saUCYZH5XJui/INwC4VwnGuwa9Gz8soAd9Gydbseto+RYOTitbjTNJDB/jYU0FObXKFurY0aVc+ngTqR20AkCJLhMYkJ1zyIuSX3BHRTd2IamyWYkta5vBeqml33QDPUDdbMjskRn/i+h64GfL82s6LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Zyi6UvGEcrF4dB/TQeHIq/hSxdHcnEEnCVhruFBp4=;
 b=r9VgyuPrZwhIA6zk88BOewGnqfdjOdj0K/yMsyHCl2GkWiZALu4IQsAqq49KhcuSBXklIC7pPMlqwx3yymN0q4xfdexAm/nzzPuLt5rRovI0FkHTNYt75YgriF9mM92BD7qaNlO3ddiot9cZSjXdHc99cmv9WqwyV6M9ovDKYd5Fzy0nugSo2lV2J6uIyMD8JqmBq/2ho+RAW6v5Nb53p6OfE0pQnA2qRm9J/CD2F4ni1KubPpQH9Mdtl8LWGYm982VADgE+AhL7EbhwP8n2AEF8+rqt85kvmt94htGpv1X86ImBzllss6kOUCsu2a/Q1ANZPpikJ1Ljc/wn/LDjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Zyi6UvGEcrF4dB/TQeHIq/hSxdHcnEEnCVhruFBp4=;
 b=tuFVMvT9lbNqIK+sSDlg0LeC++mvgrSr9aCcW89fQG1pHqARFeOxGyY5tmTjoNqtNFIR12e5TroLguDEIjiWUzLMLfdd/DInXWO5Q+q1vsBnJy1opB53zl8ycPxL123xnPkOFwzbqjfH2ROQgEKOq5PZz7X8bTkMjw9o0t/GMEdt2mqzQgZA0AB26wCFuGfn2L32AzE/QcSZ6/TmBSeziVMEMUSpIaWgJfHxWifMEbp6hqyFJEbrdGSQ7Tryyx33gdApahpPw6a8pL8XhWFbgUsaEpXWM/TNkTxWza/XxVUiukzZjHgUufyx1VWmBL0FaZ5dcVY1R+IC2jp8yblurw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU0PR10MB5728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:44:30 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 14:44:30 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
Thread-Topic: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
Thread-Index: AQHczZ+Q0c9rZSRdRUiG3e0OuNuWnbXhw8+A
Date: Thu, 16 Apr 2026 14:44:30 +0000
Message-ID: <c337c5cb16f6593dad1099972da23a374ccc1495.camel@siemens.com>
References: <20260416083513.819854-1-Quirin.Gylstorff@siemens.com>
	 <5677bfda-ba9a-4c69-8989-071b96cbc1eb@siemens.com>
In-Reply-To: <5677bfda-ba9a-4c69-8989-071b96cbc1eb@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU0PR10MB5728:EE_
x-ms-office365-filtering-correlation-id: 256909d2-92f7-4d71-78ae-08de9bc6aaf4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021|55112099003;
x-microsoft-antispam-message-info: 
 usZ5r7eDZRuzFNgYMNMEbOSkeEc0Zfd6rOx889yZvv/keGaXoXqhuWF04Bqiyv05w1SbQNzC0XeKn/3YqLbpCuIV661rsGo/20kRBc+6QEMNggRbvHhwJJ+l5+m/yv/hKMMNaPtdUIqODpKhIetUeUGG9qFcbKTghCCLgqoP2uqGVrmvIeGjSR+uq6saeKMJpEXdfEf7pVLs478oDu9akvIFUIsCOkulQ+p05ryOycLFj4T3hlR0Gwkf9ty7caX/76NpNg0dQZvyXEnTT7li/q5ysUiJ2LtA1KE8RPNwfrfsIQZq/gUxY41Thy2+O7MviBD7Kqq25dUJr3DxFWT34RZ953XZcT3QK1AmmEFaTt8UrX6kbPMOYlwodX8TTkU3XRrfeUwMuvt+RJusLhqD9ceBoFNHx+hRPJOyV5VAkeZy+hCHPsRY+LfDB/GfgZcNm/SbViyogMt4abYpbJG3kWVhuSGX0Hoo3pS5ysnlcFj8OngH9t1LFIvEpOwu4oyfgheHlsN6JkTZJtIXTn2wLuBN3fmdSDRTCU2uY/Mxca7U36uKyRThsOR8xWDescP7tW7xtEd5toJL5FPwMbzAqdefN1uyGPEwsslbmnjK9ZcQb3CwO1RFqJ4A5YVPZsxplzX9r+EN2svP1eks+p7DfGhc4Ktvc98/OD5oXeVTJ6Exim9NRpi2q9NLRe9Xsf9K0ARyd4zy8e+BxRN9Dfn8o5jTQOdH766gfZcT0tiRLPKkC3KY3uGNey+ojn47lE1vziXGErtLUf20jfLfMOhEC/ssax0ID9VSV+7y4TWj8MLCtdXJfT2K516M2OOc3LCx
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R0xDRTNkdXV0b3VpTTdPWGlxMjQ4dmVyQXpRYUpHanNaQmk3QjcwWXcxTVlJ?=
 =?utf-8?B?QmYvVWdDKzZMdUFUZGxrbktvd2NFUDJ0RzV4TVFtSWxnVzE0bm5kbGRKeXRN?=
 =?utf-8?B?YnRNOHc2cEUwV25hQTFERjB0N1IvOGRPTEh4ZTk4OU96NGoxZ2dhQ1NNRHl3?=
 =?utf-8?B?TExYQjc5NGpFd0JJcVhiM0ZhU2h4TFg0ZUtrNDM4UHJlaUVyRlhtQ1lSMjZ4?=
 =?utf-8?B?d05RM2JUc1ZoL0R0UkN6dXQ0c0pFT2RLWW9rNmV4MmsxL0lIVkM4YU9iZEg2?=
 =?utf-8?B?OTBKQmdQaWhjMUQ0c0lkMlY5WW1NSkdVTkxncWtoby9pWXlxeElib21yYlRB?=
 =?utf-8?B?eFJseUsrcWU1ODBkTU5SajZuOUhFNTZFODZpQytZRjB6Ni80amdlK3c0dHZx?=
 =?utf-8?B?cTg4bUtuQTR3YWpQbTkzZGJkKzg3NS91VEQ4ZEp1a3pnRkF2VStFamxpcGVT?=
 =?utf-8?B?cUhRRmU3N0tPVDNCb2xkZkRtKzNCNEpKWmRJY0I4RlBBbzlUaXpvekN2dWlI?=
 =?utf-8?B?clA3aHpLMG50clhRT2xqYk1YM2RhSHVCN1h4aUVDMER1WnJSd29aUnFXYzF6?=
 =?utf-8?B?U0dOZFBmMG4zU1RLcnJRb281cjNmS1piTXd3RGVkQU5xbDV1Z0R4bU5sV0Iv?=
 =?utf-8?B?clArQ2xTV25EalI5Z0lYSW5PbUw0dGt3VjZYcFRnR0kwKzA5WFRwTWw1WEZ5?=
 =?utf-8?B?MWZYTVd3SUVvc1RuYlFLb1hGZ0o1ZGFnRXdFRkVpNy8zRWpLdmRkSFZqRHp1?=
 =?utf-8?B?NldISHJJVUo4R1pTZ2lXWHVzQVRmanBBTWlURU9GM241ZFI2T1ZpNElqWHhG?=
 =?utf-8?B?VnNSZ0Z1SXMreWUzdEZib0pmWEx3Z0dQOXRIQ29FRk5wL1NjRFdwakJqNnZZ?=
 =?utf-8?B?Nm1sTmF3bnJUNzc2Tnc4UVU0b29DN3V0YnFJdWRJd1hpUHBKa3JaMkprUWM2?=
 =?utf-8?B?VmRNWmNWbGNJZ2kxQkZWRVNMbXFSaWg2K01zZzRoWVVZZ0I3MjQxNUtLL3Jr?=
 =?utf-8?B?emtKZVIxd2U5ZURwOEk2ZnoreUZ0eWNrNnc2aFE4ZVJydHlNdkg2TXUxdnJM?=
 =?utf-8?B?Y0xOck0rWmFNUkd4c2p5dFFIeGhpbUdNMFdrSUZ0QXZVK2VCRXA5ZEZZSWhk?=
 =?utf-8?B?L3BxSHpaSG1RRGtDNU9RN1ZKMjNNVGxzNXRJdFNtWnkvOUUxeFpvWlBjZ2tC?=
 =?utf-8?B?RW9NOTV1ejhjMFBLdVRYZ1FCZThxUzlLMGRIa2lDSVhJTE9OaXVqcTRCamFy?=
 =?utf-8?B?a0ozai80NjBpeHVlZ0dVQlJyQUozajEwVFN3TE5KNmd1NzQ4VzdIU2dLQktQ?=
 =?utf-8?B?b0ZhYjJxR3BvWUkzbm9TOTZyS0kzTm9wTGZGdHU3U1cwUGdjckpqOWpSbGVz?=
 =?utf-8?B?bjhjcnVhNGdLQmVoaEw5NG9LUkpBVzJ1UmlDQnB2U015cDBxUFVCRlpXeXFR?=
 =?utf-8?B?NzEwRndCOXBBN2IzTWs3VFMwOHRnK2ZrTmxsUUhPK3k2N1ZBV2RieG1jRDdV?=
 =?utf-8?B?TUhtSytlb2VGTEN5OWh6S1ZRcjBBOE5rb0R1d1c3YTRab2p1Ny9GTlo2Mm1G?=
 =?utf-8?B?RmY5LytBNGlOSzYrWHVjZFVSWjVIbG81eTV0ZG1NSENXQnJxS1NMZ0hhcEdU?=
 =?utf-8?B?enBjSXBqYnRpOVhhb25mTytmVUhxNzRrTzNWWmJQb3FZTGpLUmhMSWlPWlI4?=
 =?utf-8?B?c1VydUdJNGIvLzNIY2tCSGFyYi9HclVqa1lJNU8xeEhFNXVySnprZU9rNmVp?=
 =?utf-8?B?OG9CQnNWeHlSNDZXbWlBakd0bnpUYTQwMzV4TEhvbWZrck41OWIrTDdmcW5E?=
 =?utf-8?B?cVFDb2tZYW1CMzFnVTV4YVVySGprclFyMy9HdnIxcWMzenVKWWlvZFU2enlD?=
 =?utf-8?B?OUs3TUdUNFV3ZDdrbm5adE9qQ3RMajM3SjNiak5pWWQyd3daWHRkTEZoT2pr?=
 =?utf-8?B?TFgvSnBTTlJja0Zma2d0RUp2ckk5bkdobXFMekpkV0tLZHhIM0Zvd1dSaVZj?=
 =?utf-8?B?K0w0UG1yaFREVU1yM2ZSVGhENzZOZmZhZDVDQkhKQnhpYTBDUWVENTVXQnR0?=
 =?utf-8?B?YThZbU1sdExHYTBEa2g5YW11OEs4SzBIZERBM1ppeXJwbUhLV1c1QVNvb2pG?=
 =?utf-8?B?U25VdW5IODFJYjlrbllNVnFUR0IvREp6V0U4R05PNHlmekp3UmdJMG03bkl1?=
 =?utf-8?B?VjV5SndnTStkQVZ2R0Y5Ykt3ZGNPbWE4SUFKb0lpL1BiSHE4NmgvRml1VGcv?=
 =?utf-8?B?Y2tnSWJlUWhJU3M0NXMxS3ZwMDZ6YVU2Mjl2NEFFUFk4SERGcklBTVowblBw?=
 =?utf-8?B?T3J5ekhxNTI2K2E4a3prNnRuZ1Z5a0ZSQkIrOTdVczEwZE5JdkRZaTJ5SzlE?=
 =?utf-8?Q?Og0O8+5paEgy4P/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFB489BD93BDC4DAB87BC8D74893320@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 256909d2-92f7-4d71-78ae-08de9bc6aaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:44:30.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTJDoaRPJDE+Y2ayRitjWVg/egl2ATDOO0TKeP7Cn3E+A40ViPrE92W5e18Ieq4BO4fib8doMocMImJgrHmBHEAH038CMuoUqzGxEsbBfFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:44:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22746

T24gVGh1LCAyMDI2LTA0LTE2IGF0IDE0OjQ5ICswMjAwLCBKYW4gS2lzemthIHZpYSBsaXN0cy5j
aXAtcHJvamVjdC5vcmcKd3JvdGU6Cj4gT24gMTYuMDQuMjYgMTA6MzQsIFF1aXJpbiBHeWxzdG9y
ZmYgd3JvdGU6Cj4gPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNp
ZW1lbnMuY29tPgo+ID4gCj4gPiBUaGlzIGF2b2lkcyB0aGUgZm9sbG93aW5nIGVycm9yIHdpdGgg
YnVpbGRpbmcgYm9va3dvcm0gb3Igb2xkZXIgaW4KPiA+IHRyaXhpZToKPiA+IAo+ID4gRTogVGhl
IHBhY2thZ2UgY2FjaGUgd2FzIGJ1aWx0IGZvciBkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlczogYW1k
NjQgdnMKPiA+IFc6IFlvdSBtYXkgd2FudCB0byBydW4gYXB0LWdldCB1cGRhdGUgdG8gY29ycmVj
dCB0aGVzZSBwcm9ibGVtcwo+ID4gRTogVGhlIHBhY2thZ2UgY2FjaGUgZmlsZSBpcyBjb3JydXB0
ZWQKPiA+IEU6IGFwdC1nZXQgdXBkYXRlIGZhaWxlZAo+ID4gU2lnbmVkLW9mZi1ieTogUXVpcmlu
IEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiA+IC0tLQo+ID4gIHJl
Y2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMgICAgICAgIHwgNCArKystCj4gPiAgcmVj
aXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMTIuYmIgfCAzIC0tLQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYyBiL3JlY2lwZXMtY29y
ZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMKPiA+IGluZGV4IDQ5N2IxYzIuLjU5ZGI2MzEgMTAwNjQ0
Cj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jCj4gPiArKysgYi9y
ZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jCj4gPiBAQCAtMzcsOCArMzcsMTAgQEAg
REVQRU5EUyArPSAiJHtAYmIudXRpbHMuY29udGFpbnMoJ0RFQl9CVUlMRF9QUk9GSUxFUycsICdt
dGQnLCAnbXRkLXV0aWxzJywgJycsIGQKPiA+ICBTV1VfU0lHTkVEID89ICIxIgo+ID4gIERFQl9C
VUlMRF9QUk9GSUxFUyArPSAiJHtAJ3BrZy5zd3VwZGF0ZS5ub3NpZ25pbmcnIGlmIG5vdCBiYi51
dGlscy50b19ib29sZWFuKGQuZ2V0VmFyKCdTV1VfU0lHTkVEJykpIGVsc2UgJyd9Igo+ID4gIAo+
ID4gK0RFQl9CVUlMRF9QUk9GSUxFUyArPSAiJHtAJ2Nyb3NzJyBpZiBiYi51dGlscy50b19ib29s
ZWFuKGQuZ2V0VmFyKCdJU0FSX0NST1NTX0NPTVBJSUxFJykpIGVsc2UgJyd9Igo+ID4gKwo+ID4g
ICMgYWRkIGNyb3NzIGJ1aWxkIGFuZCBkZWFjdGl2YXRlIHRlc3RpbmcgZm9yIGFybSBiYXNlZCBi
dWlsZHMKPiA+IC1ERUJfQlVJTERfUFJPRklMRVMgKz0gImNyb3NzIG5vY2hlY2siCj4gPiArREVC
X0JVSUxEX1BST0ZJTEVTICs9ICJub2NoZWNrIgo+ID4gIAo+ID4gIHB5dGhvbiBkb19jaGVja19i
b290bG9hZGVyICgpIHsKPiA+ICAgICAgYm9vdGxvYWRlciA9IGQuZ2V0VmFyKCJTV1VQREFURV9C
T09UTE9BREVSIikgb3IgIk5vbmUiCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBk
YXRlL3N3dXBkYXRlXzIwMjMuMTIuYmIgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVf
MjAyMy4xMi5iYgo+ID4gaW5kZXggNjgyMjE1My4uODk3ODViNiAxMDA2NDQKPiA+IC0tLSBhL3Jl
Y2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjEyLmJiCj4gPiArKysgYi9yZWNpcGVz
LWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYgo+ID4gQEAgLTM5LDkgKzM5LDYgQEAg
REVCX0JVSUxEX1BST0ZJTEVTICs9ICJwa2cuc3d1cGRhdGUuc3VyaWNhdHRhd2Z4Igo+ID4gICMg
d2l0aCBjcm9zcyBjb21waWxlIHdlIGhhdmUgYSB1bnNhdC1kZXBlbmRlbmN5IHRvIGRoLW5vZGVq
cyBvbiBhcm0vYXJtNjQKPiA+ICBJU0FSX0NST1NTX0NPTVBJTEU6YnVsbHNleWUgPSAiMCIKPiA+
ICAKPiA+IC0jIGFkZCBjcm9zcyBidWlsZCBhbmQgZGVhY3RpdmF0ZSB0ZXN0aW5nIGZvciBhcm0g
YmFzZWQgYnVpbGRzCj4gPiAtREVCX0JVSUxEX1BST0ZJTEVTICs9ICJjcm9zcyBub2NoZWNrIgo+
ID4gLQo+ID4gICMgdXNlIGJhY2twb3J0IGJ1aWxkIHByb2ZpbGUgZm9yIGJ1bGxzZXllCj4gPiAg
REVCX0JVSUxEX1BST0ZJTEVTICs9ICJwa2cuc3d1cGRhdGUuYnBvIgo+ID4gIAo+IAo+IEkgdGhp
bmsgd2UgY2FuIHNpbXBseSBkcm9wICJjcm9zcyIgaGVyZToKPiAKPiBodHRwczovL2dpdGh1Yi5j
b20vaWxiZXJzL2lzYXIvYmxvYi82NTA0MzIxZTg1YjVmZGMzYmI1YTgzZjA0MmI3N2NiMzljZDEx
YTZmL21ldGEvY2xhc3Nlcy1yZWNpcGUvZHBrZy1iYXNlLmJiY2xhc3MjTDE0OQoKWWVzLCBhcyBh
bHJlYWR5IHJlc3BvbmRlZCBieSBtZSwgZHJvcCBpdC4gQm90aCBpc2FyIGFuZCBzYnVpbGQgYWRk
IGl0Cih3aGljaCBpcyBuZWVkZWQgYXMgdGhlIHZhcmlhYmxlIGlzIGNvbnN1bWVkIGluIGRpZmZl
cmVudCBjb250ZXh0cykuCkRyb3AgaXQgOikKCj4gCj4gQnV0IGdvb2QgY2F0Y2ghIFdhcyBhbHJl
YWR5IHB1bGxpbmcgaGFpcnMgb3ZlciB0aGlzIHdlaXJkIGlzc3VlLgoKVGhpcyByaW5ncyBhIGJl
bGwuIEkgZml4ZWQgdGhlIHNhbWUgaXNzdWUgaW4gaXNhciBzb21lIHRpbWUgYWdvIFsxXS4KClsx
XQpodHRwczovL2dpdGh1Yi5jb20vaWxiZXJzL2lzYXIvY29tbWl0LzlkNGIxMWRkNmI3MjM3NjRk
YzViMGE2MzA5ZjE4NTg1NDZhNmQ2ZjIKCkZlbGl4Cgo+IAo+IEphbgo+IAo+IC0tIAo+IFNpZW1l
bnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMKPiBMaW51eCBFeHBlcnQgQ2VudGVyCg==

