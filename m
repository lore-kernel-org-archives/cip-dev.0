Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF2C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.20564.1751452700126495007
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 562AcH5G611006; Wed, 2 Jul 2025 19:38:17 +0900
X-Iguazu-Qid: 2rWhg4sy4ZJ4OGMp1f
X-Iguazu-QSIG: v=2; s=0; t=1751452696; q=2rWhg4sy4ZJ4OGMp1f; m=iDUuRxxMM4t+at+r9em2T0ODmSOVeKzUQRpljvn+530=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 562AcGQF3249501
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 19:38:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBIfSCouu8O/MmoLv0UQ9Zv79ZQdP8Q5Mwn9/AtamZMIt13B0zZMn6BkrW910YSeYu9DXLyhpW7ASvLthAwHQYyXgTSG3CqkJRLDIcV6WknB1KuFEpoVsAVXz1pevInk1DKkpm9Drxuk0GdAgmkAa4EwqNYfYp49a+OcLv3GiBxg7uifrBjr/Yfz44bkGwHm9yvNm58CfVXiJ9BAaLB5xfUUPsgwQPqNZwSRpVVNYr5nlA264UUW6VNBWd7x8x7brvGZqyl2GH2471tqcWRRg9eYBQAmCFpUkfpMxcYLLFuD9dKCP9ZUt5ProeniKPdCdE5x6mtecuPLhLCz69lHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS9D/lfU8732bMsp7bZeG2yOvNNLxXuaDZUULbLPlho=;
 b=SQFQM82ctiPzFmCf4icBouNdlNaxjxf2/LE/6JEbdF2i07k3/gX5Xoh14t5DBq4C5uAEcZjqWPuUfPkpZGEAjmL66P7wdFWucl2JkOCJyNGB2oGLX2mRXz5e5OToFVSyslLk133jI5tVHZz117orQjwVOvAp3kf2S3xk7M+JbdFCfS7ot/tw63jtx5DSbtWfcVqq5gi+ZKj8Cj5z6kId2SHelfKeEdHngktSb9IzW/XBhOJi8zJNOkVEyoKWWUHrKgv4DLDxy3P8lOl164hC8n6fX+tpkLZKiz0b2/rmDi/WJis88clLY/BtGVgU1QXcB4R+q4T23c8NdClVbBm7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Topic: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Index: 
 AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldAAAq2dgAAAqsrwAADXmQAAADm2oA==
Date: Wed, 2 Jul 2025 10:38:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
In-Reply-To: <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYAPR01MB6026:EE_
x-ms-office365-filtering-correlation-id: 86a55d4e-535b-461f-8d22-08ddb9548ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RVpTTWRxSW1sU2l3YkF5Tjh4Tmh3Rm1Gc3lWV2RnV0xrcHUrbjhPWlhyQk1B?=
 =?utf-8?B?TlZFbnBRRHQyTStjdFVENG1XdXFFZHB2Vml6dTd2S0U3ZC83WDBTYjV5dVk1?=
 =?utf-8?B?TS8rcklvR09RL1VoNzJrL0RRdjJWRE1hOXFMWUhaTFI5b1BVVVU0bGhJQ2RE?=
 =?utf-8?B?ZmZTT3RabjRrVTFCdXYwRHJCOFdudlZGQTJSRjFYbXdjRE5ySmw0eFY5YjNw?=
 =?utf-8?B?bm1FQnFoSFRBdGZCUzYrUDZmSkptTXFVbjRhbExKVFk5MnBuUzc4YnhwQWZP?=
 =?utf-8?B?bWlVTmNLR1VRNFlSWjlob0ozZWhSMWJybHFhMWJmVEQ5aXQzYUZob045OWRS?=
 =?utf-8?B?RjlXWWJqWE9IWTQveVFHZnNSRGF6YXpsU3NrdDZLN3FXc055V1huTWNGeEZT?=
 =?utf-8?B?a0pSc01SRUF4ZjU0Z01lMkZFd3pGZEVlQ1JiUlo3WDRDVmdQYkVqd0xCM0dn?=
 =?utf-8?B?eWdpSG9ndElsTkhKNHhaVlU0V2N2amhBTmM4blc5ZGZNK2UzOXorbllJYWly?=
 =?utf-8?B?elRvK3JDSGNURkNhQk96Y3U3VjNnNGVOd1dPVGtaQWh6dFIvUXYyaFdEcm95?=
 =?utf-8?B?MS9HTzdvcVMxZ05QT293Z0pwT2V3ZXZPOE5ocVJDeFRaa2ZTVVozQ24zRTUx?=
 =?utf-8?B?RGkyalNwS2gzZlBONG5KanZzR25VRDE2dGJmTWhlMzFiVUdlS2VtNjJOWWR1?=
 =?utf-8?B?Y3E2NHJFR3pycEUzN3lSaXV6NERpOXdEb3h0UWNIR0lDWkJhT2duMUlYWXdN?=
 =?utf-8?B?a3g5NUY1azNtQ1QrSXZaRm5RSUY3TGNSVEFnTitSRWRVang3N21Hbk40RDNR?=
 =?utf-8?B?aXA2SnZld2IycXBsKzNHVHQ3cUdWT3BDejl6RFBsZjJtU0QvTTN6UnZsc1RX?=
 =?utf-8?B?UGNLVnhpNktBNW1seEMxalVwM0lpOEFTdXZhRTAyaVVFdTZNRnMvOGp6OUxU?=
 =?utf-8?B?czM1M1VTaXFDVFFwcFUxLzJiaTc5ZGhvdjQzdDJVNUtUTFdqNGF1YlhLd0l6?=
 =?utf-8?B?N0liL1dKNzFHd0ZneVlyYXJiTTBYeHpuU1hYVUVLY0VpNFQvdUVGSzZyelNJ?=
 =?utf-8?B?YzZMalhmTTZ2Qy9qYUR5SXA3eGZkT1NBUTJVb1FPL2Nva0creGVMNHkyd2Jy?=
 =?utf-8?B?bjZLSkhwbTFUZTMwR1dmYU10ZlJidnlEYTVVUVlFZVVoS2NvT0x5NEVENlVh?=
 =?utf-8?B?MjdVSkd5Nm4vT20yejNDRFNPd3FLckkvQTgwc2tFbVZabUpXNSs3SGttNCs2?=
 =?utf-8?B?am1BaFJod2FTcmVsTStFWGRPVEFJTjhIZUMzczRuRS94N2o4VGJBcWVVUyt3?=
 =?utf-8?B?RzVwWExEQ3cwZGlaQVZTa21xeEdWeTJiOThCZ1NaeDN1Q3JYbksxeUpYOXVv?=
 =?utf-8?B?SlJ5MURPdzdZeGZseDEyTHE1TU11NGxHVW00Um92UGJzSEdEeXIvaXI5d3BK?=
 =?utf-8?B?T3B2V0FzRXkvWmZZRUlZZkluR0plczlDWFFoS0pHU3UzMU41RmFWRWhMTjBX?=
 =?utf-8?B?dXBZTDRTeWF3aUdBaEtSMTRXNU1yYTZ3b0ZLTjdSVHJ2Y1h1WVVBSmJ0Mm5z?=
 =?utf-8?B?bzlhdlM5b0ZCRlJzYnd3cGk0OXBNQ3JxazRsVTJXc1N5Smh1SmZtWGlJcXow?=
 =?utf-8?B?dTAxNnhlL3Q2OHRqbXZnNC9YN2l1dHU0aFZSOVRBZGk0QkJQemxtZUNMMEE5?=
 =?utf-8?B?djhYSHR0bm5yWGtoMnYxTHA5OFdZYVkxNEV5U2ttTnRXRlRZMExsTzhwam81?=
 =?utf-8?B?T204T2x5OVpNV1RYcndBMDJoenFtUHpON2JCR3lCWlpBVzRlSGg3MmpUOEl3?=
 =?utf-8?B?STZVTVlsNHB1UXR0eXhvRE1WNFFnQ2Zvc0h4N2dWWFExMDd0cWRrQTN5RGFO?=
 =?utf-8?B?TFpFd0NuOVNHcmRlS285SmRoa2t1dktXdkgyMXlyc2R1dDNyRTVRaGF2L0No?=
 =?utf-8?B?MG41QjVZNUJKbk5JbDZCSlNuM00xMCszWE5jdjhOQVJLTDFJMXQvbzQvcW5q?=
 =?utf-8?Q?ekLJZ/iI4FKFIFLNWV04//R0irI1r4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dTl1djhlMWxteFI2YzcyeEtiSFRzbFRCdkhlNHpJdHB3eENSRUtBVjlmRkcv?=
 =?utf-8?B?QW52Tm9EcmFZdG9sTUgwNjJmYWJMeWpPTzd3YTRkL01wV1RMUFpKM3o2UUR1?=
 =?utf-8?B?NlB2dEhtZTVPNTNoWlVaaFhTb3gvUzIzNm8reE1XdnpJaU0rSXZ1VlhwcUpG?=
 =?utf-8?B?MzUvRFhHTWdCZG14UmJpQVVvcG9FY0hYamNIWkRkWEJaS1drSVJiY3dCTGlN?=
 =?utf-8?B?TGdUZWZ3K21vQ09Da1Y2WkdRbkhpeVkzL3RvSUZLWmhLVncvV2pqZnkrRUVy?=
 =?utf-8?B?Zkg5UEZIWllldzV6amd3QUx3RXVWdDd0Sndvek11R0k5cmVFb09mRmhyVHBt?=
 =?utf-8?B?SkY2a2NKeFgwZlJ0dmZFUnQ1OGptTkZEZHF1VFRHUHNqOVA0dTU2aWpueENG?=
 =?utf-8?B?M2dOWE53ZUNrQ0N6TzFWNFE2OHdxYWZUakVYNWFFNHBzbzVFV1gxZHJyWk5R?=
 =?utf-8?B?WUtZMEtQTFdKWlFya2VicW9aNDVDcGQ0M0t2ZDgzM3N1dS9mUko0cHRvQXVt?=
 =?utf-8?B?aGlTRTNXaEg0QmFpaXlPVTExeHRFSEtPdUNrMWVFeXg2SzZWTThQWktsRGx3?=
 =?utf-8?B?VFpqbjdoR09nTFN1aGhjc000cjJVR1hyeU5sK0NCRWdmRWc1eFc4akJsbGw2?=
 =?utf-8?B?YUZaWWxscTVUU3E1cWhpR0hDeUh3NDlnT0k4UU9JSThRS1RPeVN6dmhQSjFN?=
 =?utf-8?B?T1FMbnY1VlQvRlhONzZiQVpLWGU1MTJLdWdZazFQeHFGRHB2QWFSRmYxaXd2?=
 =?utf-8?B?SWN5cTFwWERhMWUrNmxsVWdHUFhHVjZ5RlVpK2dpb1Z0MnBlMHZreVhabDdn?=
 =?utf-8?B?VEYxN1l6RitWWGZzT29aZ3o0MXNkaUpOQWxoR0U4TXJocXBoRzlySEhGME5o?=
 =?utf-8?B?dm0zdE1NeXhPN0YyTDlxeVNaNUs5bzZBTXgxMEFkeVpOemdJaEZEalA4Um42?=
 =?utf-8?B?b0RpMEZhZGQwSStXM1hDYmI3dUZKL29XMURVNGJTUXZqK0ZuM2xYL0xKa3FV?=
 =?utf-8?B?THFrdUk5OEE2dG9JT2V1bkRUaDJXUHZsVU1DMURjbExXZmdKeXZUUUxiN3J0?=
 =?utf-8?B?UXNLdkhNNWVxdEgrMVVYeFVUOUlJR0pYVGplMjBycnBPK2lZbG9RR0twSlJl?=
 =?utf-8?B?Z2FNcU9ka3JuZ0E0eWpSb1Nzd2VHK2xuOTRzUjdDb2tCczA2MXY0RUx0ZGV2?=
 =?utf-8?B?cHFleW5SYXl6eW9CUHVHTVM0N0hNVWljdkNsWThRRTBqaExuMjB2TlBaZGpk?=
 =?utf-8?B?aXE0NHNrVWRYVzVwVmcrTVhNbExxZTlFSW5HVzFpajBGNnl5UFlwdU5pZjBu?=
 =?utf-8?B?NmRNYXIyTVNzcmRJcHJPY2hUUWk3M29aT3d1a0hRQzNKMURBMEpqU1FZYURI?=
 =?utf-8?B?WjBYSWV2VjNBTlN4bmdVZ3J4c2twamxtanE3a240MVlSY0N6RHNhUmZtN2Zi?=
 =?utf-8?B?MzQ4VkRtQmx6UVEycGo4OWJxVnFLdldhVGJ1RzRhOEUvUFJOMkRJV2E2OUw1?=
 =?utf-8?B?elRQZ2p0SzNMWWw3QWRKdlZySndjSWJNMDB6ZjArd05mM0lYMm0zZGlBUFNx?=
 =?utf-8?B?dDVuYUVuK01EMEdBUWhrUStFL3lGL0FnNFQyc2lwd3Mzd3paL0p4Z0lUbUt0?=
 =?utf-8?B?MEJOOXpraUoxOHR5ZXJneG9FbDF3SmN4KzZIVFJMOVhYaXVUb3pBMjEyZTZT?=
 =?utf-8?B?TnhQdFRxMi9MUi9OYXJFTHVsV2cvRVloVnAyVldrLzlmUjN4ZDVZSDNpcVB1?=
 =?utf-8?B?Q1U0OHNjZkFpYlgxQ2F4bGtteEJKSHdKMDZVdEpLMHozcVNiT0ZYSWViTUJ1?=
 =?utf-8?B?aFMydEhSdVh2clo4U0pkV1NibUcyRVZDeElDSGhKdC9VK3A1Y2RkaWZWRTkw?=
 =?utf-8?B?cHE0Z1lWTHdhMkl1K21EaTN1TkltMFdmeFJRZG1IY25Cb2RkcnNKaGdxUkpl?=
 =?utf-8?B?N3RGcWUvTDNybEdFdllZd2dMa3lRc3ozSG03Ti9Va2ZpVHFQeDdYUG5BMGlT?=
 =?utf-8?B?Sm1heHNITThpV2hYTWtKNnVVTUFvT2ovT1RSRTNZcGdPV01nWk9lOGxLWGN5?=
 =?utf-8?B?M1hJZWQwY0ovZTFiOStBa1lwZVN6S1VVbXZEb3Z4TlhLdlY2R0xadldJNUVK?=
 =?utf-8?B?MFFmcFFHS2xQbUQzSkVjTWxBY1hjaWM1WElTcFdVWVNGZjVmcUNZSVM5RWVp?=
 =?utf-8?Q?2N3Hp/E+BmantvOfZzR9VFM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a55d4e-535b-461f-8d22-08ddb9548ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 10:38:14.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /beTpXatxAAh4tWKCNVLtZW+X4Osd3ezw5eoFMQ85Ab7lYf1ZxbdyZJvRpmASG6kL1LD+Ljyvc6GIWN57DwMsTm7O4XLgGq0q1DqiwhQlvS+29dc2SH+D52hlNx9nxtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19311

SGkgSmFuLCANCg0KPiBUaGUgYXBwcm9hY2ggeW91IHRvb2sgd291bGQgaGF2ZSBiZWVuIG15IHBy
b3Bvc2FsIGFzIHdlbGwuIEJ1dCBtYXliZSB5b3UgY2FuIGVucmljaCBpdCBieSBkZXJpdmluZyBh
IGZpdHRpbmcgb2Zmc2V0IGZyb20gdGhlIG91dHB1dCBvZiBzZmRpc2sgZm9yIHRoZSB0YXJnZXQg
aW1hZ2UgZmlsZT8gVGhhdCB3aWxsIGFsc28gd29yayB3aXRob3V0IHByaXZpbGVnZXMgYW5kIHdp
bGwgZW5zdXJlIHRoYXQgcGFydGl0aW9uIGNoYW5nZXMgd2lsbCBub3QgYnJlYWsgdGhlIHRlc3Qg
Y2FzZS4NCg0KVGhhbmtzLCB0aGUgb2Zmc2V0IGluIGRkIGNvbW1hbmQgd2FzIGhhcmRjb2RlZCBq
dXN0IHRvIGNvbmZpcm0gdGhlIGJlaGF2aW91ci4gDQpPZiBjb3Vyc2UsIHdlIGNhbiBkZXJpdmUg
dGhlIHByb3BlciBvZmZzZXQgb2Ygcm9vdGZzIGZyb20gdGhlIHNmZGlzayB0b29sIHNvLCB3aWxs
IHVwZGF0ZSB0aGUgdGVzdCBkZWZpbml0aW9uIGZvciB0aGF0LiAgIA0KDQpUaGFua3MgJiBSZWdh
cmRzDQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFu
IEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiAwMiBKdWx5IDIwMjUgMTU6
MzkNClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxT
aGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8
ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozl
ro8g4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGli
YS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTEFWQTogU3VwcG9ydCBST09URlMgZG0t
dmVyaXR5IGNvcnJ1cHRpb24gZGV0ZWN0aW9uIGNhc2UuDQoNCk9uIDAyLjA3LjI1IDExOjU4LCBT
aGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+IEhpIEphbiwNCj4g
DQo+PiBOby4gSSBtZWFuLCBvbmx5IGlmIHRoZSByb290ZnMgaXMgZW1iZWRkZWQgaW50byBhIGx1
a3MgY29udGFpbmVyIGJlY2F1c2Ugd2Ugd2FudCBpdCB0byBiZSBlbmNyeXB0ZWQgYXMgd2VsbCwg
dGhpcyBraW5kIG9mIGVycm9yIGlzIGV4cGVjdGVkLiANCj4gDQo+IFRoYW5rcywgdW5kZXJzdG9v
ZC4gDQo+IA0KPj4gRG8gd2UgYnVpbGQgdGhhdCBzZWN1cml0eSBpbWFnZSB3aXRoIGthcy9vcHQv
ZW5jcnlwdC1hbGwueW1sPw0KPj4gSWYgd2UgZG9uJ3QgdGhlbiB5b3UgbGlrZWx5IGRpZCBub3Qg
aGl0IHRoZSByb290ZnMgYnV0IHRoZSBsdWtzIGNvbnRhaW5lciBmb3IgL2hvbWUgYW5kIC92YXIu
DQo+IA0KPiBJbiBDSSwgd2UgdXNlIGthcy9vcHQvc2VjdXJpdHkueW1sIGZvciBzZWN1cml0eSBp
bWFnZSBzbyBpdCBpbnRlcm5hbGx5IGluY2x1ZGVzIGthcy9vcHQvZW5jcnlwdC1kYXRhLnltbC4g
DQo+IFNvLCBpdCBtZWFucyBpdCBpcyBoaXQgYmVjYXVzZSBvZiBsdWtzIGNvbnRhaW5lciBmb3Ig
L2hvbWUgYW5kIC92YXIuDQo+IA0KPiBJbiB0aGF0IGNhc2UsIGlzIHRoZXJlIGFueSBvdGhlciB3
YXkgd2UgY2FuIHNpbXVsYXRlIHRoZSBkbS12ZXJpdHkgY29ycnVwdCBzY2VuYXJpbyBieSBtYW5p
cHVsYXRpbmcgdGhlIC53aWMgZmlsZS4gDQo+IElmIG5vdCB0aGVuIHdlIGNhbiBhZGp1c3QgdGhl
IHRlc3QgY2FzZSB0byBjb25maXJtIHRoZSB0aGlzIChDb3VsZCBub3QgZmluZCBkZXZpY2UgbWFw
cGVkIHRvICdob21lJyBjYW5ub3QgYmUgZW5jcnlwdGVkKSBiZWhhdmlvdXIgaXRzZWxmIGFuZCB3
cml0ZSB0aGUgTEFWQSB0ZXN0IGRlZmluaXRpb24gYWNjb3JkaW5nbHkuIHdoYXQgZG8geW91IHRo
aW5rPyANCj4gIA0KDQpUaGUgYXBwcm9hY2ggeW91IHRvb2sgd291bGQgaGF2ZSBiZWVuIG15IHBy
b3Bvc2FsIGFzIHdlbGwuIEJ1dCBtYXliZSB5b3UgY2FuIGVucmljaCBpdCBieSBkZXJpdmluZyBh
IGZpdHRpbmcgb2Zmc2V0IGZyb20gdGhlIG91dHB1dCBvZiBzZmRpc2sgZm9yIHRoZSB0YXJnZXQg
aW1hZ2UgZmlsZT8gVGhhdCB3aWxsIGFsc28gd29yayB3aXRob3V0IHByaXZpbGVnZXMgYW5kIHdp
bGwgZW5zdXJlIHRoYXQgcGFydGl0aW9uIGNoYW5nZXMgd2lsbCBub3QgYnJlYWsgdGhlIHRlc3Qg
Y2FzZS4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVz
DQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


