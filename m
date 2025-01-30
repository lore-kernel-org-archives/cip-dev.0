Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82263C02193
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 21:57:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.6205.1738274260563630322
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 13:57:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Rasbu4xp;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1738274258;x=1739483858;bh=t8LaqcQ4QQBnoxUj6R3igtO7OXO68E16nEnabIS
	lnnw=;b=Rasbu4xp4hkomn9f4HGAUcmcoNuUCsiMxwEMlEBcYyOMbkc8Cu+3xCYyiFWCrxR0I2uBZ
	V1xZWnrtlBFAGTKHpCklWnzUlUPKM7RQNe1QvfZ9cSDrX35c+2CaipT+s8bdp60JJLsOqnFWFTkg0
	9M0zyEgtaeDyajRwOcDZhoknsGRc6z0oNCWzEu7ooFTSPUc5+FsK90SWZmExuIJRpSXfSEg9iWjFi
	ipQDwOOnzRda1WCQnL46OWdJjPWVy7kI+r3iewrd2LHz92/3SWbkIG+xG7jPaea5ixoDttYJSScK7
	ETO5umGhziPpFAtEMINdlUy+tvDMMoAWbxMjOA+/9g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 50ULvbM63713292; Fri, 31 Jan 2025 06:57:38 +0900
X-Iguazu-Qid: 2yAb5TJlebEf8BYTFB
X-Iguazu-QSIG: v=2; s=0; t=1738274257; q=2yAb5TJlebEf8BYTFB; m=WL6lFlhcEtJ4rgKC/Uvgr49+iWpM/RJZ4MRkllW64eg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 50ULvZqN3195702
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 06:57:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyXPwsUoFt6ucC7OjvymkPV2HKcMlnNgtFqpwzthOGG7KC7x2x/sg3oLPSiGcIV36C6MY/E3Rvrg7AWAN/OOGtLOHaNuvIV8xCkNtiUtw+W3bwukEBhNRZNnKfjsaKaq0xg2E16diawKJfSV6AM7kuPhTN94m4ZR/WBf62mXYdi8h/B4GC7WuXppZC+xz9L7f1+Q4FoOF5h0stH8ytOjAsUnRnG3ymWib1l7eHOyrB44LwRg5GLGiCoTX50MqheyH44LMSVa1TJnUAKVInLUcPqH0DtPgmPB0PFduBUMOV4O9b0kQzo/t6+3aEv8lElXnZWT/btGJ57p2GUE4Mz0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8LaqcQ4QQBnoxUj6R3igtO7OXO68E16nEnabISlnnw=;
 b=yWJASZkyC37TVyEAun2x+WvANpRlsbVCG9xED3qtv6oqepldEoBwN+skcHDSsJYs6qLqfLlJPqO86TFd5ExNW7EZEs7ESUUR6KDLHKiiPtD3035ijyZ0wCgPDQMcK1W3Hbrz8+9FdEwM0B/7LycwsV6k5ckz3MIQ47+tlhZ2DpscNIw8elUWA5lK/LwZIPYF9acT53JceApUegYYoUqgDECRDRPTKGmy0CSaIASyu+jJJEjxe+GZR5H2zBO1Fa83SWApZJvvDg5ifdl/aweiEIpd6FBnH9x5zkLGQp5f2H3iK5IhDp3+U+C3u9HjKxdsqJ1iAmxLMuLyW4cgf0BBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <michael.adler@siemens.com>, <felix.moessbauer@siemens.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Thread-Topic: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Thread-Index: AQHbYbaODFOpOFly3ECuHYa35vdkyLMlh57QgAaHJgCAA+1HkA==
Date: Thu, 30 Jan 2025 21:57:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D35A13069092EE62700292E92@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250108100755.55673-1-michael.adler@siemens.com>
 <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
 <OS0PR01MB638822A2AA063548128D1A8192E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <D7DLXLIXEJ2B.1FZ2QPQSTIG41@siemens.com>
In-Reply-To: <D7DLXLIXEJ2B.1FZ2QPQSTIG41@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY4PR01MB13801:EE_
x-ms-office365-filtering-correlation-id: 659eebdf-12b4-42f2-ab8a-08dd41791965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UGZidllIMytqVEtKeURWY0syb01obHN5WTdLS2lzUlZFZ09wVjUzNmE4Uyt2?=
 =?utf-8?B?NUdld3ZuWFFTSk5aQ2ZlVUMwTGt6QncvUkhQdndNVGVEWklSOUhhcm5KeHlj?=
 =?utf-8?B?Ukh6SU5ESEdKdDZFWWZ5NkZDcEJvNU9maTJxa3Q3c0RFbFZBamFMYVNlQWd4?=
 =?utf-8?B?Qmw2WTJNdmFNVmFkVklLSnR3VDIyb2s4R2M2d2hJR3NPN1JiNzJiYmVyNngr?=
 =?utf-8?B?bkdyNmRQVE5qVjl4WERCdU1DRklWSUF6cmREZENHcjdkLzI2MHMwQXg2Nm5D?=
 =?utf-8?B?VU9Zb3NWUGNLQzhxZ1QxOXZqVXBEUHowSW54Q3pRWVRsYlpwdFBxeU1jRmRj?=
 =?utf-8?B?ZXArOFNEMjE3STlVWE0xcUpqajdQbE5aY2pFNStZbFBDK2pIc1JZOVpKWk5R?=
 =?utf-8?B?bVNhejRFRFhZVGRKQUI2UUwzQ1EveUJxcDdrOFl2cnNxQVNQeGJyT3JoT2ZL?=
 =?utf-8?B?L1JLeFg1ZVE3NTVLZm5DNWVkSDVRc0cweUdrTkliQlQ1VnhXZWdacHZEbHZo?=
 =?utf-8?B?NlFSL1BOcEMwdW8zQmN2TE5lalA4SnBWYkVHeWpwTzVVRlNaWGtjNmdCcDJo?=
 =?utf-8?B?WGx4WW5nbWt5Mm44UEN2RFN0czJ2emNHM3Q2MWxzRWY5aFRNSlZLVXJ2YWtj?=
 =?utf-8?B?SFR0bVllemkxQ0luUC9nM09PSExGODhaK0EzS2REWFVJSFJSWThsM3ViSElS?=
 =?utf-8?B?TFVML25ZOHFnLzdGTjZLSDhCYzhvd0JIeC9zTUNsdVgzemM3bC9UREJwZ09N?=
 =?utf-8?B?TTRLM0JreitEYzBOYnpzcmpkZ2RGdXNaVk1ITmxyMVVUVWhsK01HWjRHQ0Q2?=
 =?utf-8?B?VXF0dFBHalZ6NHVCUmRpVTR3YVdwM0JhaVppbm5Fb1liN0E5eGRqVUp5K2Ni?=
 =?utf-8?B?RXk0THJ3ejVJQ3RObTdrblRvN09OcGpEbXNvcmJuZk1udk5Yb3ljK3FlVXds?=
 =?utf-8?B?TjE0NXN5NHFnUVVjN3NPZTg1eTU1ODdsWUlPQzNvUmNqTDFlY0orOEt5NGha?=
 =?utf-8?B?bThYS1oxdGcyenJueUtuTldsblUrMXJRcEY4bzdMNmFQb2VQOEdtMCtDV2JX?=
 =?utf-8?B?emF1ckxVZkw0QWpEdUJUdGx0MGRZMlhaVVFaNkN1N3V4SVpzZndWc2MvdmtJ?=
 =?utf-8?B?NVF1VDZ1b1JNeERJMWk2UHFSa1UzdGVWNVd2U1N4S3ZJRGtUY2p0azd6bDFM?=
 =?utf-8?B?emRuNkx3WlU2UWJuM1NEV1FLbDB4UzVaTTE1b3o0c3N3TXg5Rk5CMUNkbXYz?=
 =?utf-8?B?QzZ2TXF2eDFldXdmMnJObHdLV1lIeFJ0cCtWenhKM2NCYm1zbTVrMFcwemVs?=
 =?utf-8?B?NllzVURQM0JBYlUwQ09JRzVGcm4vQnVHMCtORjgxMVc5UjBFOS91eG5wTTFn?=
 =?utf-8?B?bEFTUnhOTCtKS2xvaUNkdUFMcU1ZdmNpa2lLRVJuOXppZWs4ZnZoaFhCejVE?=
 =?utf-8?B?eCt2SitSeUdZUkRWdDBvdlBKRVVjaFkyVnp4bW9Ub1dtaEhVU29BMUJmQ3JY?=
 =?utf-8?B?V1VBdkRURXM5ZWsydVRZeGp5RVBzQzdXOUk4TjJlSnFTdDIzTE9BLzJUenpY?=
 =?utf-8?B?SDJMQW9kZkpmVldNQno1YWtqeHNlU0NEeUppYzJXSWNjWktCYk95ZzF3anB4?=
 =?utf-8?B?cEE2MVhJVk5nQXRwMHBRa2t4cWZ3ZHB6THNXeDZIMzJIL1owcjJYRDRpL2Jm?=
 =?utf-8?B?VzlSSCtlbzlOcTZXMjhvQ1BmQjI1NXZBQUxEc3hEcGt1VndkN1ZqaC9QcFA1?=
 =?utf-8?B?dnkwQ3FQWDF2bTJPSjFMK3IyN0FiZjhuMVJHcm9MVTFuTnBXMlNiVHhSamJH?=
 =?utf-8?B?L3o3YXpOeHVoMWxZWG9tMmdYRzZ0cVcxU2lQcTB5UStEY05jNUc2ckhuL3Jm?=
 =?utf-8?B?QTIxd2ZQdUZkYUxZK2JsYjNwL1F0end4ZlRUSmUyVStDQWRZL0pHaThIRitq?=
 =?utf-8?Q?PcVCnv+PTTVMjTlezyTf5GFxcUEPvX7o?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZkJRVTZ1UG5PRVZyMEZ1dllLMmxTYkJDcjZDYnRzZU9ZYU83bnZkRnZSYmVl?=
 =?utf-8?B?b2JpTVE5L3hJTENHbWZQOVE3Z0pJelNXOFhsM2w4R1dWSG1ZUFZtUlkxTFI4?=
 =?utf-8?B?SStpcWVzLzUyc052NzVlb0xLbXFCUGR4U1BmclNkWEd6Nktya1gvVnNVQmI5?=
 =?utf-8?B?LzlZeklEYjdmNzYwUFVLbHpWdTQ1d3NaV1F2UndkQjNoRWJ3SS9sVW1kSEVD?=
 =?utf-8?B?WFE2eWRkMnRwOEJpOUYveXVqUytCTzB0RjZDeGphOVBtNjYwaHNpb3Q5R2hz?=
 =?utf-8?B?WU9PMjJIMEZxbllVTmNucTFlbEYvRGRSMEM1QXg4M1ZvMWZ2VVZ5ZzBKWThi?=
 =?utf-8?B?SmNCeGRNT3Z5NXFqZDlpTkJNMitIY2dOUDI5RWcvOWpZcmpiODlHMG4vWWtB?=
 =?utf-8?B?bFExOW1kS2tBS2FPTDVCZmFEY21FY0ozMjZEWkJ3MzQ0M3hDL1dlR2tiRmpM?=
 =?utf-8?B?anNCdVBjY0x2WnlLRFgzN0tKU1NtTUxIaVFETG1sQlRIVWRDZVpmVTc2ZStH?=
 =?utf-8?B?L2o0QnFRTGMzREVqTytaeUgrVlhGc2x2b1kreWY4cmYrVUxPSUErVS9aL2NT?=
 =?utf-8?B?YkJxN05BVHpZNFZWcmFSdzJqV3BBd3RTZFNmQWVKTFJ3NUQ1WHNPbFM0bnFN?=
 =?utf-8?B?WVFSRExWcnIyOC9JVnBZN2VrNFRDNlAvU2J1WmZsOSswdmhMa2N2b2pPaVRo?=
 =?utf-8?B?RE51WHF3K1Brc1hlNW8vUndVYWlJZDBndkVPc3R3eHQ4Nm9ncjI4S250eERy?=
 =?utf-8?B?RXh6MWZyd01VV0x6Z3I0UkxHY0pPcEZ5U005dnFRaUZqOHFHTWxLZ2pIYlpD?=
 =?utf-8?B?OVkycStUK0hjQnB0UTdZNDd0VkFyaFp1b0xFVzVySE56bjR6MFV3bDVKbU1z?=
 =?utf-8?B?Z0VxdzMwOUJhVWxiMm83UlVxQzVsL3NjaWRHMEhSQnlHSjZZdW9CanRMd0Np?=
 =?utf-8?B?NVlLN3RxanZkc3dsOEV5N2JoUEZJTTRiZjNTV25XMTFoSnFIdVpKSGhVeDlo?=
 =?utf-8?B?dk4wZ3M1blVPNGx0c0IxbUdkZWZLdkJzT1BjczVHMTlmdDdEQ0xOQVlJeTZB?=
 =?utf-8?B?TC9ZbFNkUmVITFpoN1hNWVlZdGRnNXZCTlNyTlMxd0MzSjRjT0F3NllhM1pY?=
 =?utf-8?B?QnovWkJYQ0xtNk5oSmlXZVE0SS9naWRoaFlWNmR3UzdPM09yd0l0YUsrVnJP?=
 =?utf-8?B?WkVVM2lqdlNZTThjYVIrWVU4L3RVRlcwR25TS08rWHJWMGZCdWRXNU9yelFO?=
 =?utf-8?B?WjI1KzErMW4wVkt2d05EdDlOd3pWdmdVOVlORHhsNitvUXhRcTV1ay9FSE1L?=
 =?utf-8?B?ZGFvZWZGZzZ1U09wV2xIYmQ2MWRvWk4wWnNNZTNIMlVhZEorcUprUlRtWjd0?=
 =?utf-8?B?dXY3WWx6QUZhTnJBMUNCMDJyN3BDUVRqV1J2REpveUlLVCsyYjVSYUFJdjFU?=
 =?utf-8?B?ZjJBK1lqRFZhZmpwK0ZRdDl2VjdwdFhXci9vV2wvU3pZSmpPN1VkSGNzOEhQ?=
 =?utf-8?B?RkN6cmtSeVNqdUIyaVlUU3hBTGtSeUNUek5GTmJhYTlOYzhtUFh2cGtWMVp5?=
 =?utf-8?B?ZzVjVFJNYVhDaGI5S0JzSEZnQzh2eTNWWVNrZldmNUk3cWt4QzgxL3ZwR1NF?=
 =?utf-8?B?YVZaVlUwbWhFdUVHUzl3R0oyTTQvZWluSmxEcXBWWkV2L0JpclQzTVM3SFZT?=
 =?utf-8?B?UjJwRDZ0TUl1dmU0azR6NEpMb2NLNXZQM01QTm94MVNWTDIwSEJjamRQOTRZ?=
 =?utf-8?B?VEhyVmI4dG5NOHEyVFJsS28xbXdJK0VNc2pTbGE2SjJiT0RvL0hjOHRNODV3?=
 =?utf-8?B?L1M2NyswT25wc2loN0E3YWlQOXMzc3BrRjY5NG0zalhrMDc1L2JJdUFGWUlZ?=
 =?utf-8?B?MW9Ub1FFNVhSYll5K3VOTjNsZXlMRUR4ckQ0d3hWeTJTK3hiaktRcjRiSnh1?=
 =?utf-8?B?SjhyTzdoN0VHRnl1ZUlOd2hxN1IzTDJGVW5aNTNadTd3RDgyL1MxY0FyZ1VT?=
 =?utf-8?B?ZW15RDk2cXhmVE9BOUUwOUdJYWNGcWRxa2tGS25aOVBLSGZCUmlFcEJxVzN0?=
 =?utf-8?B?NDQ0K3BaWm1ZWG5hSjNmdTM4U1VFMDJtb2UrUUFmUktNeGFIajJVM1VIOWEz?=
 =?utf-8?B?a1p5VW1lblc5dTllMmhGaHB2MmR6UWcvVmlwaVp6K0J2MlJvWEVtaEZVMi95?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659eebdf-12b4-42f2-ab8a-08dd41791965
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 21:57:32.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5ob+zUgFacZh+iYk5nH/uyDgLkEPXzM+DjdBsgGv6nShsiCR9BZMfS6FE1/vYImsRLx4QCBanx2YMhxustFdM2I2ujxCfexdrKKRQoOvGHDk8PC5tREB9WaRSNgISYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 21:57:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17714

SGkgTWljaGFlbCwNCg0KPiBJIHdhcyBob3BpbmcgeW91IGNvdWxkIGluY29ycG9yYXRlIHRoZSBv
cHRpb25zICh3aGljaCBJIHNlbnQgaW4gdGhpcyBwYXRjaCkNCj4gYmVjYXVzZSBJJ20gbm90IHJl
YWxseSBzdXJlIHdoZXJlIHRvIHN0YXJ0Og0KPiANCj4gLSBUaGVyZSBzZWVtcyB0byBiZSBhIGxv
dCBvZiBkdXBsaWNhdGlvbiwgZXZlbiBhdCB0aGUgZmlsZSBsZXZlbCAoZS5nLiwgYGZpbmQgLiAt
bmFtZQ0KPiAnKl9kZWZjb25maWcnIHwgeGFyZ3MgbWQ1c3VtIHwgYXdrICd7IHByaW50ICQxOyB9
JyB8IHNvcnQgfCB1bmlxIC1jYCkuDQo+ICAgRG8geW91IG1hbmFnZSBldmVyeXRoaW5nIG1hbnVh
bGx5LCBvciBkbyB5b3UgaGF2ZSBzY3JpcHRzIHRvIGF1dG9tYXRlIHRoZQ0KPiBwcm9jZXNzPw0K
DQpUaGUga2VybmVsIGNvbmZpZ3VyYXRpb25zIHdpdGhvdXQgbWVyZ2VkX2RlZmNvbmZpZyBjdXJy
ZW50bHkgbWFpbnRhaW5lZCBpbiB0aGUgcmVwb3NpdG9yeQ0KYXJlIGhhcmR3YXJlLXNwZWNpZmlj
IGFuZCBzdWJtaXR0ZWQgYnkgdGhlIGNvbXBhbnkgdGhhdCBwcm92aWRlZCB0aGUgaGFyZHdhcmUu
IFRoZXJlZm9yZSwNCnRoZXJlIGlzIG5vIHNjcmlwdC4NCg0KPiAtIERldmljZS1zcGVjaWZpYyBj
b25maWdzIGluY2x1ZGUgbm9uLWRldmljZSBzZXR0aW5ncyAoZS5nLiwgY2dyb3VwcywNCj4gZmls
ZXN5c3RlbXMpLiBJbiB3aGljaCBmaWxlIHNob3VsZCB0aGUgY29udGFpbmVyIHNldHRpbmdzIGdv
Pw0KPiBjaXBfbWVyZ2VkX2RlZmNvbmZpZyBvciBpcyB0aGF0IGZpbGUgYXV0by1nZW5lcmF0ZWQ/
DQoNCkluIG15IG9waW5pb24sIGl0IGlzIGJldHRlciB0byBjcmVhdGUgYSBzZXBhcmF0ZSBjb25m
aWcgZm9yIGNvbnRhaW5lcnMgZnJvbSBjaXBfbWVyZ2VkX2RlZmNvbmZpZw0KZmlyc3QuIEZvciBl
eGFtcGxlLCDigJxjaXBfY29udGFpbmVyX2RlZmNvbmZpZ+KAnS4gQmVjYXVzZSBjaXBfbWVyZ2Vk
X2RlZmNvbmZpZyBjb250YWlucyBtYW55DQpjb25maWd1cmF0aW9ucyB0aGF0IGRlcGVuZCBvbiBh
IHNwZWNpZmljIENJUCByZWZlcmVuY2UgSFcuDQpJbiB0aGUgZnV0dXJlLCBpdCBjb3VsZCBiZSBj
b21iaW5lZCB3aXRoIGNpcF9tZXJnZWRfZGVmY29uZmlnIGZvciBidWlsZCByZXNvdXJjZXMgYW5k
IHRlc3RpbmcuDQoNCj4gLSBUaGVyZSBhcmUga2VybmVsIHZlcnNpb25zIGxpc3RlZCB0aGF0IHdl
cmUgbmV2ZXIgTFRTIHVwc3RyZWFtIChlLmcuLCA2LjExLCA2LjEzKS4NCj4gQXJlIHRoZXNlIHZl
cnNpb25zIG9mZmljaWFsbHkgc3VwcG9ydGVkIGJ5IENJUD8NCj4NCg0KTm8sIDYuMTEgYW5kIG90
aGVyIGNvbmZpZ3VyYXRpb25zIGV4aXN0IGZvciB1c2UgaW4gcGFzdCBDSSdzICh0aGV5IHdlcmUg
cmVtb3ZlZCBmcm9tIHRoZQ0KcmVwb3NpdG9yeSB5ZXN0ZXJkYXkpLiBQbGVhc2UgaWdub3JlIENJ
UCBrZXJuZWxzIGFuZCBub24tTFRTIHZlcnNpb25zLg0KDQpGaXJzdCwgY291bGQgeW91IGNyZWF0
ZSBhIGNvbmZpZyBmb3IgdGhlIGNvbnRhaW5lciwgYXMgd3JvdGUgYWJvdmU/XQ0KDQpCZXN0IHJl
Z2FyZHMsDQogIE5vYnVoaXJvDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1pY2hhZWwgQWRsZXIgPG1pY2hhZWwuYWRsZXJAc2llbWVucy5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEphbnVhcnkgMjgsIDIwMjUgNjo0NCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp
5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQpDQo+IDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVu
cy5jb207DQo+IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMC8xXSBsaW51eC1jaXA6IGFkZCBrZXJuZWwgY29uZmlnIHNuaXBwZXQgZm9yIGNvbnRh
aW5lcg0KPiBjb21wYXRpYmlsaXR5DQo+IA0KPiBIaSBOb2J1aGlybywNCj4gDQo+IHRoYW5rcyBm
b3IgeW91ciByZXBseS4NCj4gDQo+ID4gWWVzLCBwbGVhc2Ugc2VuZCB1cyBwYXRjaGVzLg0KPiA+
IFRoZXJlIGlzIG5vIHJlYXNvbiB0byBkaXN0cmlidXRlIGFuZCBtYW5hZ2UgQ0lQIGtlcm5lbCBj
b25maWdzLg0KPiANCj4gSSB3YXMgaG9waW5nIHlvdSBjb3VsZCBpbmNvcnBvcmF0ZSB0aGUgb3B0
aW9ucyAod2hpY2ggSSBzZW50IGluIHRoaXMgcGF0Y2gpDQo+IGJlY2F1c2UgSSdtIG5vdCByZWFs
bHkgc3VyZSB3aGVyZSB0byBzdGFydDoNCj4gDQo+IC0gVGhlcmUgc2VlbXMgdG8gYmUgYSBsb3Qg
b2YgZHVwbGljYXRpb24sIGV2ZW4gYXQgdGhlIGZpbGUgbGV2ZWwgKGUuZy4sIGBmaW5kIC4gLW5h
bWUNCj4gJypfZGVmY29uZmlnJyB8IHhhcmdzIG1kNXN1bSB8IGF3ayAneyBwcmludCAkMTsgfScg
fCBzb3J0IHwgdW5pcSAtY2ApLg0KPiAgIERvIHlvdSBtYW5hZ2UgZXZlcnl0aGluZyBtYW51YWxs
eSwgb3IgZG8geW91IGhhdmUgc2NyaXB0cyB0byBhdXRvbWF0ZSB0aGUNCj4gcHJvY2Vzcz8NCj4g
LSBEZXZpY2Utc3BlY2lmaWMgY29uZmlncyBpbmNsdWRlIG5vbi1kZXZpY2Ugc2V0dGluZ3MgKGUu
Zy4sIGNncm91cHMsDQo+IGZpbGVzeXN0ZW1zKS4gSW4gd2hpY2ggZmlsZSBzaG91bGQgdGhlIGNv
bnRhaW5lciBzZXR0aW5ncyBnbz8NCj4gY2lwX21lcmdlZF9kZWZjb25maWcgb3IgaXMgdGhhdCBm
aWxlIGF1dG8tZ2VuZXJhdGVkPw0KPiAtIFRoZXJlIGFyZSBrZXJuZWwgdmVyc2lvbnMgbGlzdGVk
IHRoYXQgd2VyZSBuZXZlciBMVFMgdXBzdHJlYW0gKGUuZy4sIDYuMTEsIDYuMTMpLg0KPiBBcmUg
dGhlc2UgdmVyc2lvbnMgb2ZmaWNpYWxseSBzdXBwb3J0ZWQgYnkgQ0lQPw0KPiANCj4gS2luZCBS
ZWdhcmRzLA0KPiAgIE1pY2hhZWwNCj4gDQo+IC0tDQo+IE1pY2hhZWwgQWRsZXINCj4gDQo+IFNp
ZW1lbnMgQUcNCj4gVGVjaG5vbG9neQ0KPiBDb25uZWN0aXZpdHkgJiBFZGdlDQo+IE9wZW4gU291
cmNlIEVtYmVkZGVkIFN5c3RlbXMNCj4gRlQgUlBEIENFRCBPRVMtREUNCj4gRnJpZWRyaWNoLUx1
ZHdpZy1CYXVlci1TdHIuIDMNCj4gODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCj4gDQo+IFNpZW1l
bnMgQWt0aWVuZ2VzZWxsc2NoYWZ0OiBDaGFpcm1hbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6
IEppbQ0KPiBIYWdlbWFubiBTbmFiZTsgTWFuYWdpbmcgQm9hcmQ6IFJvbGFuZCBCdXNjaCwgQ2hh
aXJtYW4sIFByZXNpZGVudCBhbmQNCj4gQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXI7IENlZHJpayBO
ZWlrZSwgTWF0dGhpYXMgUmViZWxsaXVzLCBSYWxmIFAuIFRob21hcywNCj4gSnVkaXRoIFdpZXNl
OyBSZWdpc3RlcmVkIG9mZmljZXM6IEJlcmxpbiBhbmQgTXVuaWNoLCBHZXJtYW55OyBDb21tZXJj
aWFsDQo+IHJlZ2lzdHJpZXM6DQo+IEJlcmxpbi1DaGFybG90dGVuYnVyZywgSFJCIDEyMzAwLCBN
dW5pY2gsIEhSQiA2Njg0OyBXRUVFLVJlZy4tTm8uIERFDQo+IDIzNjkxMzIyDQo=


