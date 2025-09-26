Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF52CAC5AC
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 06:49:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.11619.1758869357731860621
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 23:49:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=F7/55duu;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1758869341;x=1760078941;bh=+A+4g/+Chsii2sVOSihMmw8GbM0uwpkErwA4E
	Aabqck=;b=F7/55duu8G9v6zhWkaES74lXWSQGIIXS/d+2GxrSOqv/Wb3OyhRG7jv42VY2Ouvs8sk
	zmIG/4Z68b07/1Gbo0qU+TKJOZrVzD7THV4OVexmMH8W7cvPtNznQoSENQMHI+PMON4c2iP40radx
	rDJLpvpknlLhUfh96cEWBuSrK3od26f7jPh6tYHfjb1UdrhbC0lMeNe5h5mx7NkeMnrrktDKjEMMP
	v0UznmyDvhSqWbYnigryRBoMI6/gjG/5q29wBb+Ss/u8rRPUhKJdYEs+QHUFW4urVKZTQVkwSUIwH
	BgmAR0WiuKR/kJwDSPqynZhLC4UXEHz1RbH10bZxTTRw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 58Q6n0AN3310163; Fri, 26 Sep 2025 15:49:00 +0900
X-Iguazu-Qid: 2yAamy98unKkhrYjj8
X-Iguazu-QSIG: v=2; s=0; t=1758869340; q=2yAamy98unKkhrYjj8; m=5siR0Y1tZPjLibJs76szi11yjYm0imchC397x66ZHYg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cY1QL5s8mz1xnZ; Fri, 26 Sep 2025 15:48:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDqN7qOGo5OqXB5A9oRmeZNAFGofR0btDa0ZWPPnT/d2IrD/si/Y96mxN9GxU5WC/tXHkvvP/bzKTp7sfiVFsG+0ZuPzX3FUycv0Gy6f8sCfQXXN5dH/w9R2btGT3x0m6/nytp5GfJMHDsTYrGydx1r8fFRStjlMYwKi6V2AOC15r/43oex60dyXvD3P5URun0VGhkToDtoMZmbwNLE5aXWakErpUh5OZLta6gd2v+wAyVbxevFw90SRGFE1+cpTwg5kXVRleJh2gt1g1Wi9f5a6ZDRR6xQ3N1zOFZStmDirrQeeEkp/cfpm+arjFYf4FZ936Dzbi/8/UrF62M+3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A+4g/+Chsii2sVOSihMmw8GbM0uwpkErwA4EAabqck=;
 b=qqSIxl8PC/69A/1PaQ5feuF7M7zSAUFIORR+zzGi0lLjSSEVhZ/B2bA6PR7tSa6IVlnL0W8U2y88PAc26/sPriO2mnbjN5uXbbqD3Ooma3zylT26VgiPAh9U9Y0/J5ShI4POAH0HrzcH1scvogDCCzOCq6uGwZd9lkpez4KVlYlX9jnOmwsuAq0SneGyso3fr85ts0aZCyDEAhkHHLuuH3jhGZNGQEWqFBV6OGDV0GgNrbsWbyUlgfF5rCMUNSr2KzTGx0bg70l1DDBjsjoPP9T86nLQFrlrPcn4HNqd81ey68A6GWN6dQ8SBJ71R6uJ0GGA5MJKM1YlSdMhNR9A4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.4-st68, 4.4-cip103
Thread-Topic: Request for review for 4.4-st68, 4.4-cip103
Thread-Index: AQHcLWaQCIOKqHJFTkG9eStuHUdLD7SlB+DA
Date: Fri, 26 Sep 2025 06:48:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183D49BA4AABEF298C7510CD1EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <886040472.424568.1758727128905@webmail.strato.de>
In-Reply-To: <886040472.424568.1758727128905@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB13382:EE_
x-ms-office365-filtering-correlation-id: 77a8607a-6f0f-4b1c-4a70-08ddfcc8c3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b0pvOUN5VGJmeHdPRDdqTHUraS9mWGt3TEM0QUFETTdHRzVGUUZlMXowK2xk?=
 =?utf-8?B?aVlVYWJRVHVFUnpVME5CYWxMNEg0Vkw4QUJqVk5MdnVzRkI5SU9TeWtaY25N?=
 =?utf-8?B?cTVDdFBxMFl4Wm0rd2UxSnhKaFRrdURSYVMrT1NuZGR3TzYzQWhENXptZHNB?=
 =?utf-8?B?UzVLMzM4L1pLU3B1Y0NoTVg5dm0zMk5McjN6K3IvYThsdW5GS2llbnppYk0y?=
 =?utf-8?B?MWdVNFJsRjFMY2poWEtqSU5ndnBteG5JUFkxNkQ5Z25wMXl2MS95ZERIcDUz?=
 =?utf-8?B?OEN6NXRjazVFN2E1K1kwYktkQWY1b3dzMjk3MUl1UEN6eVJKdVJxbjV4azJp?=
 =?utf-8?B?OElsYTZTM1Yzc2JlVDlnS05PbXlrRGdXdjRiWHVjdjE3UjdWUmNVYVJJNkgx?=
 =?utf-8?B?bWZoWXJtOWtpejBoVGo3NkswZkhiNHBmSWc5YVpYUWs2WlVCMVQ3dldnM3pi?=
 =?utf-8?B?eW13NG8rVit4NFFXT1lZNEJFOHdoOC8ybndTckE0eXZJdy9sM1ZwSVAxWi9r?=
 =?utf-8?B?U3pMOFMzM3g2S0ltN0RqWWxwS0crNXdCNXpnS1BoMW43OHE3TUxobFVOcDV2?=
 =?utf-8?B?dWlvTncybk9KOUxETkpEUWsxQlNaVmNiV29hS1p5bWl2UjRmSlYvWU9tcTJB?=
 =?utf-8?B?bzNsenlwQ0N6aWFMVGhKSWJyeUVrdVZlRUoyKzYwTzhGdk9QM1FQNGQreGx6?=
 =?utf-8?B?anVzS2FiN1RYcm1JUm81NlhsK0ljK2FNVE41Q3FMZ1d1UkowRnRiaXluVTda?=
 =?utf-8?B?SFhvMjZNMVMzNHhBcnowN1FhK0pYNVZwR0REL1o2bFUxSkdvTm5OcDQvUHBS?=
 =?utf-8?B?bVNBRElKRkxoejdNVkF5VllmVVM0NDYxVDkxZUZ5aUtyOW0rbFcwZ0Y4TnZH?=
 =?utf-8?B?TXd5eEM1K2x3QXBhdzdmZG42TTZsTU1xM1EvdWZ3MWFmVEpWMVFQVjJuYWsx?=
 =?utf-8?B?Sll6enc3a25SZzBYMkdZdFQrd2JHTUVCMGRWWnpTakltUmhNb2NBYTRHT1Ro?=
 =?utf-8?B?a0krSjhCdndtT2hzY0FvR0R2NWlVdnRpejFFenI3NHZBTzZ2S3dnY0dUWlRv?=
 =?utf-8?B?dkkzeVZPd0t2VFR1Vit0bE01NEc1RjVibEVTN0NHbitZSnlqKzFzNUFCVzkx?=
 =?utf-8?B?M0xxc3pTbTRVUVJrUU9LemFuUWJJTXVnNVIvckI4V1BTMnhDdUdHSFU4Vmpy?=
 =?utf-8?B?eWFmdHVBWnBsRGJHaTBZd2lSUURoTktvZVlucFQyWnZaVHhJSldHeHZ6L0ND?=
 =?utf-8?B?eTFNNzRrQTU5eFVxc0FEM1RmUXJqR1ZHeFNRa3NNaHNNa1JKdFBkcWQxWHR4?=
 =?utf-8?B?Sk1ZVWVUclF3anlFend6Q0N0N2ozM2NOMDJWM1dlaHdXTVUvMEJWUDJhazMx?=
 =?utf-8?B?QTV5N2dxeFpyL3BSdEJhMkp3NXh6UG9nc3Bka0M5ajgvWmp4aFplSTJXQkNu?=
 =?utf-8?B?VnRLR3d4WFFQQjQ4Q0tHWGVhWm53OWRIeGw2QXRVd0pwdkZwdWdrR0ZUaTFS?=
 =?utf-8?B?U1BMbGk4c3FxcXFYQ3FLRWpRSzhKWDB0b1dmWkhvYUxPRFRRQVdKQzV3aFhC?=
 =?utf-8?B?ZUd1REpFclFXeUNhM3R2UU9RMExUK1hCODFtLy9FZFI5NnRyeXZYVUhyM2Rt?=
 =?utf-8?B?ZHlKRGZrd05EYlJYcUprYVdISjdVMGQ5VFE1bXN6NGhod1FOR3ozMENzbzUx?=
 =?utf-8?B?V0YvbU5JNC9vU2FJeDZGaU5rbzZRbmpiUVpqTGJuajlNVlV0K29MRGNBZWJz?=
 =?utf-8?B?bmx1TTVHT1k1SzBxQ3U2Qk94N0hIOXRtcjlLQndhSFhmV1RqU0EvL25yNG9M?=
 =?utf-8?B?UlEvQjVCM0VjV05jbFJkWUVVTXdmYURqamtGSmxmWFB2MnB5NXdzbjlLVWk4?=
 =?utf-8?B?Y2QzM3UySVNhMjlrL1lRNEViUUlHYi9OQjR3dHpmcXpHWi94TDdPZHhRbnJE?=
 =?utf-8?B?L3B4WGZsWmFzM0s5ZGNXM3liMkVld3JjbEphcE1UbHFUTUc2RUhvWnY4K05Q?=
 =?utf-8?Q?E/xxkvWGGdApsR8nT6xZ/ODZ84kYSY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MlM3RVl2QnZxaVBueDhHRkRnY3hRTC9nUSsvMEt5Y1lrQTlzQjFuazJHZDhJ?=
 =?utf-8?B?ank2WHJDd2NTN3RjdThWMUxuWHFOeTlFSFQzbEp6Q1NHR1RKd0RmZ2Fhd2Vm?=
 =?utf-8?B?WmxKVEdNZDZMS3B5RjduYVRhNXUyUHNyTVV0UEpYY3V1SUc4aFFTb0FUZDEy?=
 =?utf-8?B?N1JWdnZYTFduMUFSS1NLS2F3Y2VXYmlDUFhKUXh6MXNZM255cng5c1ZmeXZz?=
 =?utf-8?B?Skh5cDI0OWlDT2daYlp5Z09wWUNsbGdUL0NDQko5Rmw2V3ZhWUpJeno4cjV2?=
 =?utf-8?B?bFpMaU9GVlRTRkxON3RINS9vRGJvazJQaGlvSW5HU2hDdmdRT0xmM3BoQXkr?=
 =?utf-8?B?MFNzVFhpTUVOd005Y3IwcVJkZVpsOGJ0M256M1drT2phbGt2cjU1bmhwaWRH?=
 =?utf-8?B?RjhqbEw1WFo3UjJ0ZWxIRVI0K0FkRm1CS0prNnM0bFE1RDlveE9sNm9oNXFC?=
 =?utf-8?B?YzczN3lvdkY0Mm1YUE9xOXNDL2M4TUZFajVQOXk0L3ppSVVWNjJkY3MyM0V2?=
 =?utf-8?B?V0M0WGVXY3FWWU1xWUxqYVUyT2svWHdOZWkvaTVZMk9EV0pxSWpJMVVqcmlI?=
 =?utf-8?B?ZG1wSlkrYnhySmJVUW5acVJNdVI3QkRaV2prNWQ5VlcrTlFpYkdJWVMrQUpu?=
 =?utf-8?B?eXlYTTR3V2tQWng3UUVjZ2pqV0R0TlRINE1oT2hiL0ZkSk1IdElsNGRvNHRi?=
 =?utf-8?B?bDlnWEFMU29ac0FzR0pYdFNBM0dCT29vcHlYZldrTG1Tem1EQ3ZPQStjSm5i?=
 =?utf-8?B?REMzdW9ZeDZRUE5ZRkFyQkRWUzFQU0VNcjlwTHJJWmRlbmxBNzJDYVh2NjZj?=
 =?utf-8?B?Qjg1RHNoVWdLQWR3ZGxUWFgwWDBsclcxRXBZdld4WDJsS0ZOS1lySll0cFIy?=
 =?utf-8?B?dW9LVHBLczhUeGFobkxCUVZjRDhHTUlVL09RTHRCWXVhMi9JMUdhYjFVekJH?=
 =?utf-8?B?T0VHNjZzRGdXdFA4N2w2bzlVRVhXbTU0eFg2cDlsQmdaRUYzTzhURXJLbFJp?=
 =?utf-8?B?U1QzWDVJKzUvSFUrbHA2UlhHY0tCSS94ZTI0U0lLQnVGNlJZOXUzaUFxd0Uw?=
 =?utf-8?B?ZXl0ZEl0RW55dE52akwrSDFsZ1dlTEZTWU9DSTVFcWhIbDh4dHVPdWhMVnRS?=
 =?utf-8?B?MTNGQ2EzV3BwZCtqeHY0QlBSWnlVcDBQL3VGN1RRVHlvZExHc2RLSEo3OXdY?=
 =?utf-8?B?R3N5UUttd3Q1Y0tjeUp2bTZaeWJGemhhcHBUSHRDUG9oa0oycjZnRmZpTG9E?=
 =?utf-8?B?cmpFajA4RWUxOFc5bVkyN2RlMGNHRU9aNW5qT3Y2QUpHL1htNHRaMkJxZUt4?=
 =?utf-8?B?Y1RVeVFYbVdrVmZVNnZraTliQnZZVnZZOUJzbUxIaXNNV3V6ZFVxdWF4S2JY?=
 =?utf-8?B?MXR4ZHNXamZnUjJOWEN0QUJJbmQ2bEtnNHVENEV3UnBvSkxvVndpNGoyVU8r?=
 =?utf-8?B?TjA1b09tZDRUdGMrWmNKNGExcGN2T0ZFSnJJaFpMQW9yV3ZFQU9NUCtFckdM?=
 =?utf-8?B?eTFxUmxMMFczVjRMNEVDdFdQa2xXdWhzOXJqdjhUM3FVM1FubFZUN2xzaEsw?=
 =?utf-8?B?OUg0WVRTazdleVkwblhlQ3BXeDkyTC9lVjcwazZta1J4SzRvV0ZBWkxVZWhI?=
 =?utf-8?B?Sk9mS1lTZTFYVmN0Yk9jamorM0hyMUFMRGZHTytHUHRVRGEvRTIwek9EWnpN?=
 =?utf-8?B?Y1RJMGozNk1jc1JYV1g0VFYvTXZyaUVaaTJOMGQ2amhwTGZPeUNlWXBBdnR6?=
 =?utf-8?B?NUorNzRHOE9OTm84aHNZWDdBaytjTTdVUit0dmxzcldidnNYVE5OTjcwYlJs?=
 =?utf-8?B?R082eDNFdjh0ZUNSWFU5MjZIM09MRUVlRkJUN2U3d3U5N0dyR1poOGVoTHA3?=
 =?utf-8?B?dno1T2F5R0lJTFdWZVNZWHcwbmw0MkhudE04emZZV2Y0RDY4M09DUTRNcEVT?=
 =?utf-8?B?K1JVNWtkQlNab1h4UWY1N0E0SXUxMHVqSS9HUWlBSTFGZ0gzRlo2WFpDSlI3?=
 =?utf-8?B?M05zSHkzRWhVeDRoRVVwd2g2bzJOUlp1R3NWbGxodXZGcHVHNGVzQXNReHBW?=
 =?utf-8?B?UjJ4Y0hYVWVwREs1NEJqaFdLQmF1MEEyMTlsblFGWEFOblZrRmc5Q3E3Yjh2?=
 =?utf-8?B?ai9YOWpldnJDMjk1b3hwcE8xV3YrY1hzalh0UjlpN3hBcGE2UzRBYlpVZGFO?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a8607a-6f0f-4b1c-4a70-08ddfcc8c3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 06:48:56.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94TWaAI61Lf+Fq0HD8RYJMLqDzwyZEPyXunWKfTeIaEg4fIjvh2tFGtg813S7lU/ddu9UoV/CPp5oTySN6V38oyBiIkHbi/BaBu5KgLrHjs+rQlSv+h7OsH1czDMvuAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Sep 2025 06:49:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20146

SGkgVWxyaWNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmlj
aCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI1LCAy
MDI1IDEyOjE5IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgcGF2ZWxA
ZGVueC5kZTsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oQ0KPiDmtIsg4pah77yk77yp77y0
77yj4peL77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4g
U3ViamVjdDogUmVxdWVzdCBmb3IgcmV2aWV3IGZvciA0LjQtc3Q2OCwgNC40LWNpcDEwMw0KPiAN
Cj4gSGkhDQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJhY2twb3J0cyBmb3IgdGhlIHVwY29t
aW5nIDQuNCBrZXJuZWwgcmVsZWFzZS4gQXMgYWx3YXlzDQo+IHRoZXkgY2FuIGJlIGZvdW5kIGlu
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9s
aW51eC1jaXAuZ2l0L2xvZy8/aD1saW51DQo+IHgtNC40Lnktc3QtcmMNCj4gKFByb2JhYmx5LiBJ
IHN0aWxsIGdldCBzdHVjayBpbiBhbiBlbmRsZXNzIEFudWJpcyBsb29wLi4uKQ0KPiANCj4gMTU5
YmRjZTZkNmI3MCBuZXQ6IGRsaW5rOiBmaXggbXVsdGljYXN0IHN0YXRzIGJlaW5nIGNvdW50ZWQg
aW5jb3JyZWN0bHkNCj4gNDU3NjI4ZjhjYjAxZCBhdG06IGF0bXRjcDogUHJldmVudCBhcmJpdHJh
cnkgd3JpdGUgaW4gYXRtdGNwX3JlY3ZfY29udHJvbCgpLg0KPiAwZmU0NDZjMzczOWE5IHVzYjog
bXVzYjogb21hcDI0MzA6IGZpeCBkZXZpY2UgbGVhayBhdCB1bmJpbmQgOTg0NjNhNDkyNGYzZg0K
PiBjZGMtYWNtOiBmaXggcmFjZSBiZXR3ZWVuIGluaXRpYWwgY2xlYXJpbmcgaGFsdCBhbmQgb3Bl
bg0KPiAzZDA2ODQ5MjA2MGUxIHVzYjogaHViOiBEb24ndCB0cnkgdG8gcmVjb3ZlciBkZXZpY2Vz
IGxvc3QgZHVyaW5nIHdhcm0gcmVzZXQuDQo+IDVmNTVmNjQ1YjY1OGYgdXNiOiBodWI6IGF2b2lk
IHdhcm0gcG9ydCByZXNldCBkdXJpbmcgVVNCMyBkaXNjb25uZWN0DQo+IGQ5NmM2MjNiZjgxMzYg
bmV0OiB1c2JuZXQ6IEF2b2lkIHBvdGVudGlhbCBSQ1Ugc3RhbGwgb24gTElOS19DSEFOR0UgZXZl
bnQNCj4gNDJlMGVkYWY4MTNkNSBydGM6IGRzMTMwNzogcmVtb3ZlIGNsZWFyIG9mIG9zY2lsbGF0
b3Igc3RvcCBmbGFnIChPU0YpIGluIHByb2JlDQo+IGQ0NTMyZTg2NjdjMDcgcE5GUzogRml4IHVu
aW5pdGVkIHB0ciBkZXJlZiBpbiBibG9jay9zY3NpIGxheW91dA0KPiAyZjgzOGI5MjIyMTdiIG5l
dDogZmVjOiBhbGxvdyBkaXNhYmxlIGNvYWxlc2NpbmcgMjM3NTA0YjU2MDg0ZCBzZWN1cml0eWZz
Og0KPiBkb24ndCBwaW4gZGVudHJpZXMgdHdpY2UsIG9uY2UgaXMgZW5vdWdoLi4uDQo+IDBkN2Nk
MzA3NWJmYWIgbmV0ZmlsdGVyOiBjdG5ldGxpbms6IGZpeCByZWZjb3VudCBsZWFrIG9uIHRhYmxl
IGR1bXANCj4gYWI3MTJjN2EzNmM1NSBmczogUHJldmVudCBmaWxlIGRlc2NyaXB0b3IgdGFibGUg
YWxsb2NhdGlvbnMgZXhjZWVkaW5nIElOVF9NQVgNCj4gNmI1ZDY4MGI2ODRkMiB1c2I6IGdhZGdl
dCA6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBjb21wb3NpdGVfZGV2X2NsZWFudXAoKQ0KPiA4NGUx
ZDdjMWQyOWMzIG5ldC9wYWNrZXQ6IGZpeCBhIHJhY2UgaW4gcGFja2V0X3NldF9yaW5nKCkgYW5k
DQo+IHBhY2tldF9ub3RpZmllcigpDQo+IDQ1YWEwY2RjZDI5MDEgbmV0ZmlsdGVyOiB4dF9uZmFj
Y3Q6IGRvbid0IGFzc3VtZSBhY2N0IG5hbWUgaXMgbnVsbC10ZXJtaW5hdGVkDQo+IDk4MTJhNjJj
NmZjYmIgaXdsd2lmaTogQWRkIG1pc3NpbmcgY2hlY2sgZm9yIGFsbG9jX29yZGVyZWRfd29ya3F1
ZXVlDQo+IGVmZGY1YTFjZGQ0NmQgdXNiOiBodWI6IGZpeCBkZXRlY3Rpb24gb2YgaGlnaCB0aWVy
IFVTQjMgZGV2aWNlcyBiZWhpbmQNCj4gc3VzcGVuZGVkIGh1YnMNCj4gNTM4ZDA4YTQ4Y2VlNCBu
ZXRfc2NoZWQ6IHNjaF9zZnE6IG1vdmUgdGhlIGxpbWl0IHZhbGlkYXRpb24NCj4gOTQyNDM5NTk4
NTE3NSBuZXRfc2NoZWQ6IHNjaF9zZnE6IGFubm90YXRlIGRhdGEtcmFjZXMgYXJvdW5kDQo+IHEt
PnBlcnR1cmJfcGVyaW9kDQo+IDhkMjhlNjYzOWE0YzUgbmV0X3NjaGVkOiBzY2hfc2ZxOiBkb24n
dCBhbGxvdyAxIHBhY2tldCBsaW1pdA0KPiANCj4gVGhhbmtzIGZvciBoYXZpbmcgYSBsb29rLg0K
DQpJIHJldmlld2VkIHRoZXNlLiBMb29rcyBnb29kIHRvIG1lLg0KSSBhbHNvIGJ1aWx0IGl0IHdp
dGggZGVmY29uZmlnLCBhbGx5ZXNjb25maWcsIGFuZCBhbGxub2NvbmZpZywgYW5kIHRoZXJlIHdl
cmUgbm8gZXJyb3JzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


