Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F536CD98CF
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 09:40:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.150308.1781602830716942497
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 02:40:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 65G9eRW01870364; Tue, 16 Jun 2026 18:40:27 +0900
X-Iguazu-Qid: 2rWhfe5nqJbyjEeri4
X-Iguazu-QSIG: v=2; s=0; t=1781602827; q=2rWhfe5nqJbyjEeri4; m=nakbQj+8Rwpa5pr1Mz7ATgeloe30SuCXClHh4ILdXzo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfhmq0jbgz4vyt; Tue, 16 Jun 2026 18:40:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct4tYQ+jskT9h2SgUrirynj625cTzEPXKRzRB1ryRFvIp60lZN0gxh4Wc/y40mqZV+L/cmHnJ1BFxZ4VkV49Y6AwFuy3OWf44aBNyUZGbFKOmwZUUFDAJIgFq1/q9/zfHBBzhZ+fRv1Ji+nsxKkGMrvehPr5a2K20u703NHOkKiAJP/FmEnFf2k1edLPqDLJu0PPvPzsytjc+xbSIdqhzn901ImV7L1aAJFl3/yZARi5+6/EoC1m0cwWryKiLcEXYgr8xQRxpVcG9eun1eaFh9Gc1DRkxQ8H2uR7UGeQGH68NpwSlgrDreJrNCzfbaipQ17tCARuG7zhTyxGF9SqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqB16YX/rIEfopg3/Ss0suDCo1QcVaIm5a4NuNrrO+g=;
 b=FuXMisVneRTyw0kn5woIAYYfHTlp8VPOWecCA9tS1icz+M84rezW1TfyvhEU+Ngba4RgVzTuqmnWkLK0QHoRMrt7STY5z/Zz8cmocl1Zz+f8SiB7Acofr1+/HnraHg+cZqQDVqGXi+R0qN6HoI100Tl4JlcP/nxWpuW53yGt9l7BneIK7xdd+LKpNpfEaV9nUVOmUk1yTmwQ0I+aps0tfpPbrTwaZIa09Pg8PfPmLer4F2oC5rjHBj0R/RbQ3vLXD49hkbIBTqqq97hStNOHJpLKML41b86k9htDtafiMCWQ8LfZnphQJ7g5m27VUYRGfs7t+hwEnlwX1ElZ37gXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
Thread-Topic: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
Thread-Index: AQHc/U+0lSSCbrzpCkWBeqj5OBE6xrZAxKaAgAAnpPA=
Date: Tue, 16 Jun 2026 09:40:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110757AA7CAC37C32CF6E444CC7E52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <34c18027-b049-41a7-b43b-fb200bde4abc@siemens.com>
In-Reply-To: <34c18027-b049-41a7-b43b-fb200bde4abc@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS3PR01MB10358:EE_
x-ms-office365-filtering-correlation-id: c4369043-1040-48c3-a308-08decb8b4a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 rEKO4CZjp7+svQwbDgtgLOr7hn+DUu1XGxKdPzxhu+986FDTWEfTqQqooFKkJYY4xL13EtfoHzy0xK2m732L52mNsAxaTg4E/unm21X8Sd3o7qpZ8Y29WcN6X2nL0/9S8fqlw9jOVWca22XMPw2DiE6rVqdRBOg75cRmEwVYPgTy739T1yZ76eTySf6BNN2GeEjLpnWYJr0xgmdsrMYXzvzgmwCjjYI+rAun6Y7dY0+vEG9zsW7kDhbNkVCIaztEsC1jupucss7ZcVCGOgSBXdC+LHnFYYsY63uxyjm69MBlUriLViaHrg+7Tv3445ApSiHWQsIzhqxsq5eQ9wE9vEZBH+tRxAzp6N45LgmPVxjUFBHRi1epE8RoSUjW7gh+l+HQvgHZnfPU4jIuSojviyU7RY/1q9NxAOi7ATi6VJNmk1fgqGd+YRxuiZLNXj+mk8K4mnrIUGYnAs0E4+raUSeCBrcfQ1xMof2foiX24ypmR1mBjRUHkJgepYNF7tln6Mt7Ogoqenoju5WlOAQ0/3A9oilfXwGqgZrVMvTKTHBLtiLtgFuEa4pu3rarBVA7Jw612+/osEHBcE8jnZeAXydUJTJEEC9gNt5FUCcSdIHxurTiSp7VI2QyOvw9OEbiq6KQ39HYUq5TCmBXHu7mZp43XPrCQYlLu9lsIJAHR77qBI+Op4aCBlkmTCg4z1fBvaVRFfJn+CqA+mqPtJfXLha9ICv2ktzPCFXF3WwcKLKiNEDSlJgLz5u6wraU0rmY
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MHFFTjNEbUpmMnZ5TU8ycjJkaWVhY0ZlOXdUQTFUSGlrdTdNMEkyeGlzMjAz?=
 =?utf-8?B?eTExbVhtTDErbDNhWlErWExUTWwzT1ZWS29XeGJhTmlBaGVxanZDaE1aZjdV?=
 =?utf-8?B?dkdDb1FtSHQ0ZFplUG1NMHNOWk1SNmV6N0ZXZi90c3dEVWxOY3ZtVzR5OW5E?=
 =?utf-8?B?MTBPUXJhNnIxT280d2txMVdqK0ZrRXlVYzByMWRFcWVrRG5NT1hwVmt6LzRs?=
 =?utf-8?B?dTUya0hmU0JYUmFhVStoNUU3cGowSWNLRUxjYzJvdVFablIxTUo4bkhWRUd3?=
 =?utf-8?B?OHBIQ20vcGE4MXZxcUhlMFNiTnlMMmRCRzlyaWpBbkJTUUttZ2lXNUt6TVhL?=
 =?utf-8?B?Mi9Jdjk1RGxjYTJBZkFocSt6VUR3LzU3SDdaRVFPUk50cHV6ZWh4QkpvYVV0?=
 =?utf-8?B?U1h5alNXdGhlYk16eE42VDFsM0xKdmVNTTBaTnVzZ2Jzd0RHMzBEbE5lRnV3?=
 =?utf-8?B?NHJvUnRCMEFqbThmR1JYODlvcStnWFUxd0lVdzBXSzh3NWoydDNadDFrdHF2?=
 =?utf-8?B?NGRTQkhJTHhyS0NUWVc0VUpaYmZpbk5LVHlLTUozTVorY2NwT3crc05vTWN3?=
 =?utf-8?B?NEg0enBZbi9zdmlSYnAwNHpJREpvaDVKL3h0MEVJMXZRRlBWelczaFFaMVBW?=
 =?utf-8?B?Vy95UXhZVDNKRFU0eEY1ZW1FeldpYmluUUxqWFpTSzQ1eUJhc2FabXhWME8y?=
 =?utf-8?B?emFPdDJIZUt2V1U0WkJpSG53YVcvajJnSXQ2dkhrSCtZcmo4dnN2U1lMajNa?=
 =?utf-8?B?ZTBBV3FpOWhySklBb1NNYWtaOGl6ZG1TUUluYktMWklhaUVWVnZ6aDk3dmpx?=
 =?utf-8?B?U2diL21lVDVWVEZFWHN0S3EvdURiQmVLMmFPdmxYa3cyWHJtd3ViUUl5ZnBB?=
 =?utf-8?B?aEpJbHN0NEFCNUhMeGIvaXgwdGVIOTFjLzRhaWtRWjdZWDI0dVBnVEJIN21n?=
 =?utf-8?B?ODdkbEJoeHlONkhQNmJ4aGROZEVYRUtNNXJyOFdoSGtJRkJwMHJzUzNkRFlk?=
 =?utf-8?B?RVc1eDMxMXBjUzFYNlF2K2dna21SaWZoLzhwK2pUMmptWVErcHlpRDFuS3VS?=
 =?utf-8?B?R29pQzFIRHl0ZklCQ1RSckgybStTc3VDWXNVcHYrbkF6c2NZaDA2R21Jd0lp?=
 =?utf-8?B?MEV6bTNXdmFVMDR2WklNUllwRFRTdjBQSGN3c2Vna2kwTmV4dHViSjBRQ3ZR?=
 =?utf-8?B?VzNvYS80aTdTaGRHcGh2VTBDZUU1cHdkQzE5MDZZYnpnYnlRSHlpakxDU0ZS?=
 =?utf-8?B?cERZeG5odjlXMnpEYXFvM0h0VWVPS1k0UWhEeEVrVDVlZnNrQkVOTW9vbDBP?=
 =?utf-8?B?TG9lbmFYYlpYaGowQTJhd3FJcVExUW5ZNnpsS1N0L2wxSXBzYkZHRUpZa00v?=
 =?utf-8?B?c05hRTJJSFUyckQydWFZSGVtNjJ6clVBN1JYOFVEQ09aSjVhM1NZMXBUdWEx?=
 =?utf-8?B?NTVxQ1pDblkzb1BDb2Y2SGxLbEJzUFA2RWxjdEZEWVYxT25KL01DZGVCcmEr?=
 =?utf-8?B?NGt1RDRpa0dCdXdxbGVFRkxIWEZId0x3akZFVnVYand6elFGVVM2dmtmN2NI?=
 =?utf-8?B?VUFpUzlmYjlXZVY2UDBNZlh6Qkk0Qi9iU2pwczNER2lQb1NSeHpLb3hzNTI0?=
 =?utf-8?B?K2p2YnJZa29ja0plajlyclg0aVVTRllCdWhTL054amsxdGJoRlRmV2VvZy9v?=
 =?utf-8?B?SzlEQzBkZTVZSG93YWZVQkFZRjBVaUNON0I0SFpQd1BQY2NUYWJOY3ptamRP?=
 =?utf-8?B?U2gvMUVhb3hCMWtrSUVSaWlxYUxZODQ5Rk53UEtOV0FUbEt0bVhtbDk0MDFK?=
 =?utf-8?B?U2t2VlhCbWVVT0ZjUFEvcTBHKzFRRWNqaGUxakNkelBZVzhGMlhncDVONzBO?=
 =?utf-8?B?ODFhZnFhdENXSUkvK2g3VGduWDhHZkJOSkliL3pQemkrRzhENzY0eVZoeHla?=
 =?utf-8?B?USttb0hDbzhicDl5Wjkxc3QyaGw5WUErL2diT25hNUlha0dTek1ueUFOWVJP?=
 =?utf-8?B?WFZWRFpEZEZiK2NCYndNQVdmZEFSTEdIVENnQ0xHbXBzeVpoaEZUNkJtaUhm?=
 =?utf-8?B?SkdVSWdNOUZMMS9DVHZiQzU4MFFuOHRHY0tqenZ4b3hQOVFldG5jWCtSaXVV?=
 =?utf-8?B?WjhESnNzUmdrTVpoQ3VOU1d1bS9MZWUycFVaNEthZjlpL3dpaEVWdjhyOW5C?=
 =?utf-8?B?M2ZNWS9JdDMvYk03NlNOeFcwSTRXMURvRVVPKzU5U1FuaG41R1VSNm5qcEhK?=
 =?utf-8?B?Tzh0MXAxbUZqMGtUdG5PckhpUGJiMnVScmE1aUFUaFhMYlAwZk1hemYzUXky?=
 =?utf-8?B?Z2o5Z0VzdHlsMGZId0lIU2c4NGlnU3hXQmJhMCtsbjA0VnBzS1Bpa0hUcTZY?=
 =?utf-8?Q?7duYxNM4fQWA/rtbz0/nP+SRcrFupgeA/zCv2/X3CjhEO?=
x-ms-exchange-antispam-messagedata-1: 
 cRAERpFOYHtKPlG1ou9yNbrKLjp7XmCVPyftaGM2wqp0abgsdNtefR8i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	pDJdSSBWpotxSckQ3NjgUBEYW/GfmkQIV66p8LjLZVxFs7fu0nvRXe9VbGPrjDLUxOZ/CYtQn0W3kmj5OcFb76NSDRwLh06MBM0kDTLNB5yfnDEFC8VMYBbApr2sDp5jGOY05HN/SZDbGlV+oDMwuhfwZ2+mWM+JWU49Unu9XhbTO0KiaHUjXQ7ps76/E011M1tcq9+sAKC5AZ8tKQJiCYN9W/9G4BLB99vqIkaa8d9h2pKUOpRxVJiyCVB4fNeOu0MRUxISZKKWmFgUHuNaXZNSReRN3efZawnEbiL4M7OXhdY7HZUXHd102Lm94Ib/9fPs9ZFfwycb0OTjdUaXww==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4369043-1040-48c3-a308-08decb8b4a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 09:40:23.6106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qk6io7GX8KxkZWJUnRonQpUFr39qpRZ91heJhwJUYJDQZUwAU1Nth77pbPdpQ6k3GZCLanNC3TN+qmYLTzd9o8vHU4DiJViESeBIXggNYOcwkpm1TFp+KT23x1EZDW3G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10358
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 09:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23153

SGkgSmFuLCANCg0KPiBTaG91bGQgd2UgYWxzbyBwcm92aWRlIGEgZm9ya3kgdGFyZ2V0Pw0KDQpZ
ZXMsIHdlIGNhbiBlbmFibGUgdGhlIHN1cHBvcnQgZm9yIGZvcmt5IGFzIHdlbGwsIHdvdWxkIGxp
a2UgdG8gc2VuZCBhIHNlcGFyYXRlIHBhdGNoIHNlcmllcyBmb3IgaXQgbGF0ZXIuIA0KDQo+IEFu
ZCBhbm90aGVyIHF1ZXN0aW9uIHdvdWxkIGJlIGlmIHdlIHdhbnQgdG8gaGF2ZSBhIENJIHBpcGVs
aW5lIGpvYiBhcyB3ZWxsLCB0aG91Z2ggb25lIHRoYXQgaXMgYWxsb3dlZCB0byBmYWlsLiANCg0K
SSBiZWxpZXZlIGVuYWJsaW5nIHRoZSBiYXNlIGltYWdlIGJ1aWxkIGluIENJIGZvciBTaWQgaXMg
c3VmZmljaWVudCBhdCB0aGUgbW9tZW50LiB3aGF0IGRvIHlvdSB0aGluaz8NCg0KVGhhbmtzICYg
UmVnYXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogMTYgSnVuZSAyMDI2
IDEyOjQ0DQpUbzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NU
KSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCkNjOiBiYWxha3VtYXIgYWRpdGh5YSjvvLTvvLPvvKnvvLAg77yk77yp
77y077yj77y/77yk77yp77y0Le+8r++8s++8tCkgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEt
dHNpcC5jb20+OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVz
aC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKW
oe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPGthenVoaXJvLmhheWFzaGkuZjc0QG1haWwudG9z
aGliYT4NClN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV1bUEFUQ0ggdjIgMC8yXSBFbmFibGUg
RGViaWFuIHNpZCBzdXBwb3J0DQoNCk9uIDE2LjA2LjI2IDA3OjA2LCBTaGl2YW5hbmQgS3VuaWph
ZGFyIHdyb3RlOg0KPiBUaGlzIGVuYWJsZXMgdGhlIHN1cHBvcnQgdG8gYnVpbGQgU2lkIGJhc2Vk
IGltYWdlcyBpbiB0aGUgcmVwb3NpdG9yeSwgDQo+IHdoaWNoIGhlbHBzIHRvIGRldGVjdCB0aGUg
aXNzdWVzIGluIGFkdmFuY2UuDQo+IA0KPiBJJ3ZlIGNvbmZpcm1lZCB0aGUgU2lkIGltYWdlIGJv
b3Qgd29ya3MgZm9yIFNXVXBkYXRlICYgRGF0YSBlbmNyeXB0aW9uIGVuYWJsZWQgaW1hZ2VzLg0K
PiANCj4gU2hpdmFuYW5kIEt1bmlqYWRhciAoMik6DQo+ICAgRW5hYmxlIERlYmlhbiBTaWQgc3Vw
cG9ydA0KPiAgIEFkZCBjcnlwdCBsaWJyYXJ5IHBhY2thZ2VzIGZvciBEZWJpYW4gc2lkIHZlcnNp
b24NCj4gDQo+ICBLY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNCArKysrDQo+ICBjb25mL2Rpc3Ryby9jaXAtY29yZS1zaWQuY29uZiAgICAgICAgICAg
ICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ICBrYXMvb3B0L3NpZC55bWwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysNCj4gIC4uLi9p
bml0cmFtZnMtY3J5cHQtaG9va18wLjExLmJiICAgICAgICAgICAgICAgICB8ICAyICsrDQo+ICBz
dGFydC1xZW11LnNoICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKw0K
PiAgNSBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgY29uZi9kaXN0cm8vY2lwLWNvcmUtc2lkLmNvbmYgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4g
a2FzL29wdC9zaWQueW1sDQo+IA0KDQpUaGFua3MgZm9yIGVuYWJsaW5nIHRoaXMuIFNob3VsZCB3
ZSBhbHNvIHByb3ZpZGUgYSBmb3JreSB0YXJnZXQ/DQoNCkFuZCBhbm90aGVyIHF1ZXN0aW9uIHdv
dWxkIGJlIGlmIHdlIHdhbnQgdG8gaGF2ZSBhIENJIHBpcGVsaW5lIGpvYiBhcyB3ZWxsLCB0aG91
Z2ggb25lIHRoYXQgaXMgYWxsb3dlZCB0byBmYWlsLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcs
IEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


