Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DDD111A8
	for <webhook@archiver.kernel.org>; Sun, 30 Nov 2025 12:21:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3311.1764505262226527012
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Nov 2025 04:21:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=P2Rpprlu;
 spf=pass (domain: renesas.com, ip: 52.101.125.49, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhLmp2xKbrth/p0J1NOuw2hlUm4kDzJ4NyVT5rDGwxNpl5dt0j8yO1bUsVWFXsFl2rZr1FE6u5ypWxvjhsb2hnHjn0bUe4lo8p6aguRegQ7WuqlE81faZmlZmNX7UGaIK6Yy5WF3tDSH9u6e6k2+fGEOOiW1IgewXhxPnEfxkEAkabAm5dcRlfiVGiHdgRUQQwgFPNKSbmUGksu9s6T4cU8NXQ8gXVdxP0KSGNlY3vKXxWB7oMae+lyPdMunoQXbb2vT55qebm51340KUnxi0+FtCyRCfTtpT4WFKp81JGtNotzxCUgaynxy6abtB3+pgiwKh6BfBpQnrOX+N83Efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2knVGwCSLlCXEMuP8owUM9vV5W12RS9Ow0YmYmp0ZU=;
 b=QuFhDi1emYYSsy4CdOLe+sjyaRgR/VB7aIc49Q2Fdci+6hhqxfgCI3abNoVcYwuJQx4VO/eITcizeO/HhbSb/aFyUQq9NtF4rNCojXvFVsm9DkPY4Kj3caFgwu9FQjBg8CDFYN+0NZyoFpR4rmJi+uzJRKnwxHwxCWuJ+UQjKUSFs9Dl2hE7444Au5UFb8pBgoDwy0iZ5RLjDIS74xj/Q4AXJuzXi4j1Jiz6Eq4J8ewpi79yb9wtxKoP/WHDItTOXg8+fiCa3iUK3K1aQmsmOgXTzfdRRrVmh+K6vAPn5pPBxdLu3DJXlsVVDFiDWOH64vzDLYXjkYeWKNk3e+38jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2knVGwCSLlCXEMuP8owUM9vV5W12RS9Ow0YmYmp0ZU=;
 b=P2RpprlumC+WbwbpTjWRaxRd/lWMDgkRfpSQuN6yaeP7SW5qV/0lXkhNi6rzis/lL0ybVEPK8U+U3THFG9ifg0s2AVGSurPOCRLsVwPO8ZCOLsaTynF/QBjTCG6DhsV1ZLfqMN9+GRZhCtzYKU/UaNL8Fs1XvUGf+G+JzSWC6KQ=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OS3PR01MB8875.jpnprd01.prod.outlook.com
 (2603:1096:604:154::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 30 Nov
 2025 12:20:56 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9388.003; Sun, 30 Nov 2025
 12:20:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Hiraku Toyooka
	<hiraku.toyooka@cybertrust.co.jp>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: RE: Enable KVM for x86 qemu lava devices
Thread-Topic: Enable KVM for x86 qemu lava devices
Thread-Index: AQHcYFBhEhoccxeNvkOO1maGzL29o7ULI9jQ
Date: Sun, 30 Nov 2025 12:20:52 +0000
Message-ID: 
 <TYYPR01MB151324B0FFB58A3F654CA8041B7DAA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
In-Reply-To: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-Mentions: hiraku.toyooka@cybertrust.co.jp
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OS3PR01MB8875:EE_
x-ms-office365-filtering-correlation-id: 5798c9cb-1319-4ca8-46b2-08de300ae73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SFJUdy9QdC9LTTliVllJdjZ0ZjFVeDU2OXYwQUJqUWJONHl0MjdJL2NpMVlP?=
 =?utf-8?B?cTBYQ1V5RFRld0NtbFFqY05BQlBuUWFPMGtRbmFVRkozR1hidTZoc2ROK3gv?=
 =?utf-8?B?d1cyWXVhNW5ES3U3WE1DUkJ3bVovUUUrZm1vcUxzTjZ6aHB1SCsrTlFISlU0?=
 =?utf-8?B?bkUybm9yZzhOS3hkZ3VZVVdjczUzd0Y5WmRKTUtWYk53OWVvbGlOa3YyR0xn?=
 =?utf-8?B?SzQvMFJIUHo2WUpLNmYvR05NTUdPNG1qSGlEdVk5N3dCV0hhc1VzZlVPUGZm?=
 =?utf-8?B?ditxN1J2SXJKeDVxcDNqZ3dxMndvVkNtWVhEeGY1dFhvQmNOblZkVDdwKzZX?=
 =?utf-8?B?eDRsV0xXOWhXbW1aaTEwQmU4ejJsME9YTzJoWFMra1NLM0VZZVlKdWJpYjM2?=
 =?utf-8?B?cFhTa0dpYzJIRURIR3dhVU83SG9lWWZZeTl1ajZjMFM0T1VYTHBSZytkcng4?=
 =?utf-8?B?WFoyakVzWFNkSlNoTktkZ3FYQmpoMCtVN1grN3ZoWThnSE9XdHF2VmZIa0I4?=
 =?utf-8?B?UHJ1WVhxbURKOU1RQ1B4ejY0TEhXdU9TbGFidkk2ckJmTDRPTUdtZERSK3pU?=
 =?utf-8?B?dkF3UU16NGVVdGZHcDhtRzAwNnh2TlowZjhEL3FDa3VpV3QzQmsxa29KV2hS?=
 =?utf-8?B?NVZ1dk5zcWg5N0dMYml5enM2VFRkSlNlU2k1U05WcmRNSzFER3dqclJZckhl?=
 =?utf-8?B?YmIyc3NOTlZpM2NjT0VnaDlrdFNJNmY1OWttczltMExEUklHNDJqY3NsbGdZ?=
 =?utf-8?B?UzROK1NweGRBQkpJL3Fyd0R5QW55dlhvZXk3ck96VVRoUkc1bEFtQzlvTnhy?=
 =?utf-8?B?Q2xHUElRT05sQlY1SnJLMi9iK0I3eFJlQWlXWUtVaXJyM091eHhwOXN0YXBh?=
 =?utf-8?B?Y3pCSU94MHVUR2dzb0gyNFYvWTAva29KU0hpajQ2UTFyTTlvTjNCc0dsdDFt?=
 =?utf-8?B?RTg2alFYbExNcDNjQ0dIVlVaN29SelFkb1Z3cG56UFpRRTJsbXZoY2lsQnBu?=
 =?utf-8?B?cXRhN2dsVkhIV25LNC9qbW1wK1ptWk9oUU5MOTdmMzZDZ2VkdHpvcHpGZnR1?=
 =?utf-8?B?anRraFIvNFBiSTc4RDNmRDNTYzNjYWk4c0NHWk1sRmlkUHhmUHJNQ0lHRzdK?=
 =?utf-8?B?NFlWSHhFNWVtdTIyU2ZLamtsdlZlV2hKTTRlNFVBa3RMbXRXaFRLNExTVFJr?=
 =?utf-8?B?emdtN0NYWU9yZU9pblFUTHgxcFJ4Zk4wUmg4T1VYeDhQTW5aR21Xd3krTGs5?=
 =?utf-8?B?UkJueVc5YlhiSnNQYWY1dm9KRDY4Wld3SGdBaFYrd1IzMWNZVStmTVJ5M1Bx?=
 =?utf-8?B?bXk3TkFBVDFNdlRvMWNuVnZ5cnZEYTFPZW9ib0hCQWtKRHNZZjNLRWJ5bW1a?=
 =?utf-8?B?ZW91dDA5VXFyYTlWWHluS255M295STZJMGVtaDk3dkpwSDJJeXAybVFPOUdi?=
 =?utf-8?B?d1lJTkt5RmFzSjNRNFA4QllXN0x3M0xkMGhPanZtemFNZXp0Qm5WS2x5M3Ba?=
 =?utf-8?B?UWVJQ29ZMGVHWmhEL3B2L2wxdVpRcmQ2My9yOElHc1BQR3VXZ0hMdElUcGNT?=
 =?utf-8?B?TTVPdkNBcTZaR01Sc0NacCtiNVMyTklFTlQvVzdzVmh0ejVKTkltbmZlRi9m?=
 =?utf-8?B?T3d1QURpdGFoRU5HMGpWcmNjbmlxYUlOMERGeUxhSVFhOEsyN2k0NDVkd2RP?=
 =?utf-8?B?TFc0Nk1rTi9DcDRWSHJzQW1PQTliOGppd1NVaWhZMUJXVzB5UFlETUhiejFJ?=
 =?utf-8?B?U2RNYVM0NFQ2UVNwcHd2eUUyQm1FMS8ycWtTWEZ2cjNUcHpSeVRqTlpLeHBw?=
 =?utf-8?B?WHNabkpQOGk0UTg1cm5Hc3N5a1JmSXRyQW9FN1JLeG9jdzNPMUFiQXhMYjM5?=
 =?utf-8?B?eFhuWXJkVDk4N0M1eXpqOVhQTUEvR3VCWkNXaHcxOUNtRHp5d3BQRStJZU96?=
 =?utf-8?B?VmoxUDdrTGczSXVSc29kNng2N0dHY3J3MURJajduK2pvN2cwREsxOTNTeFdF?=
 =?utf-8?B?NjhlMG9nV1NhajN0YWpvdXJKY0Vsa04xbUh6ajViMy9WOVgwVDIxbi9tcWsx?=
 =?utf-8?Q?0xdxu9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RHZqYTRsbjlYc1o4b1lQQTZsNHNkVGRmZjBnSWE4WTFrT0xVMHM3M3VJUHBi?=
 =?utf-8?B?WUdqNzhZODdHUHVSV1FUM1VGeDgrSERUeGZWTDF3bDNqWVlaT09hUEwzRmFn?=
 =?utf-8?B?ME1jOU1LYVRnc1hUcnhMd0NraitqY1ZRL0hxSkRpRXh5clozSHJuYmJDMFcy?=
 =?utf-8?B?K1hVTk82V1VaR25KVWtvaCtROERnZVNNc3pqM2VmMGFRekxjODZ5YTEyUWND?=
 =?utf-8?B?SVREVjF1V2ZOdk5WZWlNVzRmN1M3OGFCN3JwUUhJSkhUUktiRnVSKzFIaFJQ?=
 =?utf-8?B?NkFmQWovNmV3V3daT1lMQnpEc0RmOGxEZTlWUjNVc25CVnJHOFlEc2VZVy9r?=
 =?utf-8?B?RElwTkpKK1RoYjhPMVdadXN2UzBBVllxL1BnTmxqbmtuZkltVThpSENCaGdk?=
 =?utf-8?B?VURidHhmVUoraUJENjFMRHFRQjVac2NqV3VDeENwWW93MWJNMjh4Q2lBdFIr?=
 =?utf-8?B?TUwvcjAwM1NQMTJmWlZhMEgzZ2JOUHZzVEY5c2plNDhlaEVDbnJETmlybzRy?=
 =?utf-8?B?Nmh0eWtwYktwUGhadm5mdGhrS2RrUEJuZVNTWjdJZTNudnVlcm04aHExZEll?=
 =?utf-8?B?ak5nQW1mYUh3dEFGME5OMGNidGlFalpZdVlUWEtzNmZnc3lRekZCS2VZOVRZ?=
 =?utf-8?B?dGREYjB6TVFZT3MvV2lYZi9OVG1DTkFmRVFCYm5hc0VZV3Rkc0NxSm00Yk9S?=
 =?utf-8?B?VHZ0ZnFTRGNyNjRsWmlRUVJLTmh4L1c0MlMyVU1kRE50MVZvUDVGbGdobkgx?=
 =?utf-8?B?cmxTOGpNenMzK21lVTNyOWxRZWhjRnhJR0JaWEZ3MVErZlhvaTNhOTJ1U0Vw?=
 =?utf-8?B?U1MwQmZacmFqS2RPNDhJMjdUVEo4VU5XeTBTajJ5L3N4R3N2NUhYTm1WcVJ4?=
 =?utf-8?B?aTZNQVc3ZStaNXluaWQ3SktnWXdVUmg2THRzZ2I1UFJ1cVIzaVYxcmdlZzhq?=
 =?utf-8?B?Y2dSKzROT21PVEhVYTVVbTJxQ0xWbGJZYVYrVEdIRmkrUlhKRUdVazVWNnNH?=
 =?utf-8?B?elkzK21ETWtXRXZHVjNzNzV3NERCVlg0T3JQcVpkZjR4dVdRUUZxVU4ydmxD?=
 =?utf-8?B?ZWZXZjFITjNzV3pPSGFsN01Hd2hkRmZrNVppbE5ZWlM3eXh3SERHbWdzREhZ?=
 =?utf-8?B?WlpLL0t3RTJZWDBtcWczc3JiM05NQmVUKzFvQjRzNmg3amNTaG5FQmltOFRV?=
 =?utf-8?B?SmVPVUVKeWFUOFNWL2N6YmdpelBOY1FwVTViRnJUYmJpU2RPbjcrNkVEMm9N?=
 =?utf-8?B?REdiV200NDJaRnlNRXZBMnY0bjJIL3VHeVhKSFhldlI5UktCT2FlSFV0ditn?=
 =?utf-8?B?WVk3bHJtVXRzNnZIOVl6b3JOR09ReFM5ZDl2R2d3TjZDcklWc2Y4NFhhaThu?=
 =?utf-8?B?a3ozVCsrejYvcTdHcE84dUd4UlkydVUybDV4eERCbGRBMW4yUzVFVTB3aGNB?=
 =?utf-8?B?b2RBYVIzVzMwZEd3QkhHdm1YTFA4S3M5NzR5OS9pVm1TNFdSKzc3cG1NSUE4?=
 =?utf-8?B?bGJvUFNpYzBFMXRtb3pzb25NVHZlTTRVaHJCTTZ6WXd0N0Nzb3JaK2xFclFD?=
 =?utf-8?B?ekpSSERtbmYySGpSM0ppR1NHY01YUHpweGR0K0xMbmV4RmxMK1VJTGY5cGQ2?=
 =?utf-8?B?UktBYTZGVGZtNlNVb2phZmRUaFZZVzRzc2FJMHhpU3lNL3ZJWUhhdzlWWDJG?=
 =?utf-8?B?OVAvdlViLzNkbFcxNWpDbzZScnZkL08zTzVOSGw2Z2dzQU53c2FQUnhkOUky?=
 =?utf-8?B?eU9NdXBCSEZYTnJ3bk5xaFJpaU1PVjkwdTErSDROck4xNXd5MWtDaXduZzda?=
 =?utf-8?B?SlRXY2xPbnUwa2tKaWZqclVaT1NkZUpCTnhaL1pXNXdxU3YvNUY2bkVaUnhO?=
 =?utf-8?B?QklUMFBuOWlwOXVCclJLOTZ4NkZvMCtqWm1OUHJTMDNoQWthOU4zOXlMUmE4?=
 =?utf-8?B?UG9EYi9DSWEza2VxWjRDcnhIWmF6aUgwaFlLeFpFcGt0Tm5UUERpSWJkU1Nt?=
 =?utf-8?B?dnB6Z1ZMUEp5Zjg4L05iWlY1d2hvWm1iUmZUL0VOWlBvYnBXY21uQ3RRZXh0?=
 =?utf-8?B?NmNzamRJQklBb0NXSHQyV1BmNXpGcTZXTGNtM203emtUWXdjL1pyOHQrMURx?=
 =?utf-8?B?MCsycWxJYjBmZXBqdkt1Tm1BQlBGcmhMQm1BeDZQZFhUZ0FTZjBVSUo2WUtY?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5798c9cb-1319-4ca8-46b2-08de300ae73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2025 12:20:52.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jixnMc2Vix1Q/iSfyAPRu0MweBujMIY7XT+ViFKa/j+xOmx9kmRSbhn9jLKkgyhpCkioR6ThSVe7r9u3IJ5IP1wWqhZyr6IAF+Zoe7mjbmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Nov 2025 12:21:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20771

SGVsbG8gSmFuLCBhbGwsDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5z
LmNvbT4NCj4gU2VudDogMjggTm92ZW1iZXIgMjAyNSAxMDoxOQ0KPiANCj4gSGkgYWxsLA0KPiAN
Cj4gaXQncyBhbG1vc3QgZW1iYXJyYXNzaW5nLCBidXQgd2UgYXJlIHN0aWxsIHN0cnVnZ2xpbmcg
dG8gZ2V0IG91ciBDSQ0KPiBydW5uaW5nIHdpdGggdHJpeGllIGltYWdlcy4gQW5vdGhlciBibG9j
a2VyIHdhcyBpZGVudGlmaWVkIHRvZGF5LCBhbmQNCj4gdGhhdCBpcyBpbnN1ZmZpY2llbnQgQ1BV
IGZlYXR1cmVzIHdoZW4gcnVubmluZyB3aXRoIFRDRyghKSBxZW11IG1hY2hpbmVzDQo+IGZvciB4
ODYgaW4gTEFWQS4gSSBwbGF5ZWQgd2l0aCBsaWZ0aW5nIFRDRyBmZWF0dXJlcyBsZXZlbHMgdXAs
IGJ1dA0KPiBkaWRuJ3QgZmluZCBhIG1hdGNoaW5nIENQVSBtb2RlbCB5ZXQsIGFuZCB0aGF0IG1p
Z2h0IGFsc28gYmUgYmVjYXVzZSBvZg0KPiBtaXNzaW5nIHFlbXUgc3VwcG9ydCBpbiBnZW5lcmFs
Lg0KPiANCj4gQm90aCBmcm9tIHRoZSBmZWF0dXJlIHBlcnNwZWN0aXZlIChmb3JreSB3aWxsIHJh
aXNlIHRoZSBhcmNoIGxldmVsIGUuZy4pDQo+IGFuZCB0aGUgcGFyaXR5IHdpdGggbG9jYWwgZXhl
Y3V0aW9uIChzdGFydC1xZW11LnNoKSwgd2Ugc2hvdWxkIHJlYWxseQ0KPiBzd2l0Y2ggdG8gS1ZN
IGRldmljZXMgb25seSAoZm9yIHg4NikuDQo+IA0KPiBRdWlyaW4gaWRlbnRpZmllZCB0aGF0IHRo
ZSBmb2xsb3dpbmcgbGFicyBzdGlsbCBoYXZlIEtWTSBvZmY6DQo+IA0KPiAtIGh0dHBzOi8vbGF2
YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvd29ya2VyL2xhYi1jaXAtY3liZXJ0cnVzdA0KPiAt
IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvd29ya2VyL2xhYi1wYXRlcnNv
bmMNCj4gLSBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL3dvcmtlci9sYWIt
Y2lwLXJlbmVzYXMNCg0KSSd2ZSBub3cgZW5hYmxlZCBLVk0gZm9yIGxhYi1wYXRlcnNvbmMgYW5k
IGxhYi1jaXAtcmVuZXNhcy4NCg0KQEhpcmFrdSBUb3lvb2thLCBwbGVhc2UgY291bGQgeW91IGRv
IHRoZSBzYW1lIGZvciBsYWItY2lwLWN5YmVydHJ1c3Q/DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMN
Cg0KDQo+IA0KPiBDYW4gd2UgY2hhbmdlIHRoaXM/DQo+IA0KPiBUaGFua3MsDQo+IEphbg0KPiAN
Cj4gUFM6IFRoaXMgb25lIGlzIGN1cnJlbnRseSB1bmRlciB0ZXN0IGFuZCBjb25zZXF1ZW50bHkg
ZmFpbHMgZGVwZW5kaW5nIG9uDQo+IHRoZSBkZXZpY2U6DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0NCj4gL2NvbW1pdC8zMjFjNDAxZDFk
ZTc2M2FiOWI3YzdhZmIwYzEzZDI2ZjBhNzBiN2M1DQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBG
b3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg0K

