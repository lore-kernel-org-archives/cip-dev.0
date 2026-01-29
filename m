Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE2D358C4
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 06:18:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9379.1769667513563042190
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 22:18:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=BvU1RlWq;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769667502;x=1770877102;bh=LHFInuRTOoCD1kT/D0kK5/OLy3FX52F/COGIu
	3wjB/g=;b=BvU1RlWqNHS2n11b6PwG0z8Y3i2Mx6GXMWKMR0plJ/9dl6whdQ14OL8K5uWPbzC8Te7
	SZqaojxdZJTEj/yVhjHvPJ+g7FxfDRM9w/wg2Oxqo6WbWrJDxhs2szDHPxJAHoMeNka308dGEwSAx
	HuufnEizrKN5zBJRDTRfhZ2que+v5hlR4lEtzQYtE7aVFVqQOHDASd0Wj7cRw6Y8zH3NMF7y6No94
	sPILntXQsZbQRKdBgo9tYZsYu2XjoogSlqvSCZJcSHpxe+Bm9b4JHJE7XUj6T804QgMHkS+x9QSQs
	nv6DNiIf3ErSfWgYhbOCPUmPhT+XhQ4xtmC9+l/M/xCw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 60T6ILXN2908057; Thu, 29 Jan 2026 15:18:22 +0900
X-Iguazu-Qid: 2rWhHaaNAWlVYLrwQe
X-Iguazu-QSIG: v=2; s=0; t=1769667501; q=2rWhHaaNAWlVYLrwQe; m=EPMKQDXAReHW2ms9jSw+WYpKxPDWp5IQsrjSmn+pd08=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f1pqJ3TVSz4vys; Thu, 29 Jan 2026 15:18:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBhZYfuIQ9iyY/9QIazEGuDUqUugXoazvlpKf9vwaCbjeBO9X/KMIHrmM2veWn3+N5haUbXCjb1EBHGX5F3hfIXDnqpyivh8G/eZjGmQuZRdKT4D2DutNyd5r74Gz3JZsb7UZZ328P0UoD0WT1hRaDCFwMFpVhWC9/p49Xl+LEPlcYhzcH+eCri7Yh7dHysm620pYVR2oDTB9jcyLD8+Fy078IWXymU7KvWfswig1qVnEMME+kjNxfHA6+PSPgn2oMdwRz/JEI+VpZPEix3Le3/KcsoIy0jlRZu3M9yngz4H1A6kLSd1iORSmLJDD7x3uBJKW0QD8AH+CpQFQZDYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHFInuRTOoCD1kT/D0kK5/OLy3FX52F/COGIu3wjB/g=;
 b=PW9O2J9Mqpi1hEICQ/kqhi/9EF7R9S9AXwa25XpGrIhanyKG6/+osjOF7BT/80KWJTGQXNqKLrFPxZ479WvNB3pm07LHntLmHtlpIcpICXb9bL8bvG/l77Q3TmBp24S8YzZgxnQmoskPHwQJghB/j57kFz1Lxts375x96VUxstD7AarJ0gXwngaC4dvVo0OMKQk2Sl0p4LImHNe+Naivgwu/j7uyOAhL88SsUvbwOkXKb64L8WTN0SY9kfAy9ounJGieuK3N/Nei9Oijp6OjboeGZVYQar5aqthHGVad8nietQw94hFJjfVxjW9sm+oAB3y/2lWQqsv+s0UMINYLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.19-st12, 4.19-cip128
Thread-Topic: Request for review for 4.19-st12, 4.19-cip128
Thread-Index: AQHckAlibhfO/N78Fk2XqJv+3NlPf7VorA4A
Date: Thu, 29 Jan 2026 06:18:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B1A2EE5EB022BB4ED83FCD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <604968144.210835.1769572263316@webmail.strato.de>
In-Reply-To: <604968144.210835.1769572263316@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12476:EE_
x-ms-office365-filtering-correlation-id: 0f21a72a-9af2-4c98-005c-08de5efe306d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WTY2UVRlSFYyeFlTeTR1UVJES2Q1enBaQ05wYzExRitmMkdNNStaRXB2UXdX?=
 =?utf-8?B?dnR6N0gyaEUxdEdtWFRyT0JiWHgrakxmbEIxU1hnUXFuaXBRMkdaN3FYMVFV?=
 =?utf-8?B?VGFVdVdzbkpKdzB1eWQ4ME5HSlYwc08rdk9ZZ0hsVFpWeVFIdUlwR24yeXRJ?=
 =?utf-8?B?NjlPalQxdG5xbHh5bGRUK1lFdW9DNmZ6MnlZT0F3NnljcTNrWTZSaE0rOXM5?=
 =?utf-8?B?eWYzL3A0NDFpOEdOVnMyelZFcnRYY2p5RHBxdWJKQVBGaFN6SjNhTzR1Ynk2?=
 =?utf-8?B?ZjE3UzJZekUwNzFEdm9aQllWSWd3cUpVZWNLeFdPTmxqbUxJcXljYmE2bng3?=
 =?utf-8?B?TmhXL2pFYkN4elZWUnE1dVVycXBGbHpmRmJqbEp3NVp5bk1zMmtLbkVNUndY?=
 =?utf-8?B?a2I1dzY3cmE1UU95RzNrZU1QRGJFdXhLQ1FPd1daTkRCWGFDclRjQmdCZDZ4?=
 =?utf-8?B?YjZhdGkwUFNTWFhUNzF4aWhObnY0YTlxMm1YWmhYRTNPYmdQSlRsTXdrQU1N?=
 =?utf-8?B?d05jWGRINGFUUGozejduVzUwLzhhWGlwSTBmd1AzbGZkVVdPMi9ybWdWZHFs?=
 =?utf-8?B?QysxeWNOcGZycU0vZmkyYUZETWMyREFYVmx3SEZpaS9EcGFmNlpVYSthTEVF?=
 =?utf-8?B?dXUvdi9WT1Y3a2d5RkVOdzV5TjdwR0w5aGRzWjlBdVBoQmh4Qys5RUN2aFlL?=
 =?utf-8?B?Qm9kMDVMVndqbWl0aGNybGphODFIOVk2dDBRSU85aUZxUk14UFdyODJ6V2xP?=
 =?utf-8?B?dXdKbVcwNlVFcW5mYTBJdUpxejZXbUJlTEd1RnhFNWdncktGUVJBNmZLY3Fi?=
 =?utf-8?B?WGJ4bytiSGdBVk9OdU5KaE5Wa1ZiL1JkUWQ3TnN4QkoweEFOcGZHaWI2WWhl?=
 =?utf-8?B?dGlxYklzMXpBa0hqV25GaWhEa0MyQllhblRpNzh4MnFObTRtMkpaaXhEQmZ3?=
 =?utf-8?B?WUJuOFQ2R1c3cGJDQnEwVVg5am82aEZxOVpnLzgyWFQrZnhUSmdUMjlhQUhG?=
 =?utf-8?B?M2dFcHhmRWRBWm5oaE5WbnpjUW5TVWJCOUszaDViOGJjSmRCaEQxQ1d3TFlJ?=
 =?utf-8?B?a1lwdXg5eFFrQnQyNVVpTklGVXdEWmRnL3ZrQXpmdWJUN2lNLzNreXJZVWF2?=
 =?utf-8?B?SHdrcFpZN1NUMndOaEd6S2haaHEwbWdoYjVQN0FoSjJqRjRXdGh4MVdmVE9x?=
 =?utf-8?B?Y1dmQTVLdXdKNDFzcDhKSkFIVnFsVCtkd1RuK2xoZm5XS3U2WXRNY3EwUGFW?=
 =?utf-8?B?bXUzYXhvK3dxcHF3THZvNjRqOXVJeWRBQ1ZEMGVQWEdEamt2YUx6MjdGSUIx?=
 =?utf-8?B?N1hxaCtIenpoVHJYR001MFhNcmdyRzdkM0dzZHNVblhFSzdlRHhxT2NITnhM?=
 =?utf-8?B?dUdzMWhGM0ZDQmVGN3FPWkNBdFhJbEZ1RE01aXJteU5aT0l3dC9JOURtTURz?=
 =?utf-8?B?Z3lGNytlRTVIcGc4aEhkZUNiWkN4dEZyNnAwYWtaN09nNjlJM0hucE9sRGsw?=
 =?utf-8?B?dmcvWGo0L1NZQ0ZJV2ZVSU9yZzdUTGY5RGhheDcwOFROZ3o0akRUbmt2Q2dB?=
 =?utf-8?B?aUUxeUVnUHNZVDRwbHZpZmZwNGF0TnVxTkNWWkQ0elF1K0F4TVpCekJMeGVq?=
 =?utf-8?B?c2FlUW4ycXUwWC9kdG5KZ05Ia21kamlFb3QyUk9sN2hjRWRUWC9UTUdZTFFQ?=
 =?utf-8?B?ckNhMHg5a3NsQzliZWZabkN4K2pPR2pzVmFrVTVBeTNnSTZXL0QxZHRBa1Rx?=
 =?utf-8?B?aC9KZ1cyeGRqNXFZblRHMnJydk9WTlNjcjNJbVhyRjRvVjZxcG9GLzVkVWhB?=
 =?utf-8?B?aXI4V0c2ajZ4RkRjbFN1WWxqQ1BDMnV4N3ZCbXJSbHZ1NkZHN0hucUZtQkZr?=
 =?utf-8?B?SGxja3dPVnZOa09ybThmS2ptWURrRnVXUmZTeTczV0tYUmVKN3NaZ1oyL3ZF?=
 =?utf-8?B?NnZpZlRsbE5pOFZtMndJZmc2c24zcTZQZUgyN05sWjNjWGkyVFdjSW5nQ1FL?=
 =?utf-8?B?ZUVQM3lMWTNLN3JRYzBMV0NxYXphcnVyK3RJU3cxRTBwZmkyblNONE8rUGdW?=
 =?utf-8?B?aFRpeW51R2VZbHlWNU5VVUVKNGpsMDR6WGN2bUxZMVpITU9sY1VQVjdSbVBy?=
 =?utf-8?B?WjNFNEdHSGRBOVhGTFJvUldNcVlmYlhoTWNjUmY2c29RVFNWYkFrQ0VhWFFY?=
 =?utf-8?Q?prUucxpqCTsVdsEOBFT32mY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0Z2Mm9ncHJtdjRkVUVyRGxIY3VhZE8vU2llQVQ5YlFlU29JQmhodXFSUHY1?=
 =?utf-8?B?cStaYVlGMy96cUtQNGlQUjlyVWN2cHNidGRDNXVsRjhEUjBVSm0wYUZ5MVo0?=
 =?utf-8?B?WU1maElNMmZXSlVsM01LOXhqUDZPbHV3SUFIZ3hzS1I1NUJSTnNmSEo4enc2?=
 =?utf-8?B?aGE0WGhaN3pHRUtIODkrVkt6YTIxOS9INTF6b1ZZMDlGUUJFMnphOUNrRGRz?=
 =?utf-8?B?N1A0K2dTWXRIVDFzcHpzUUJZdUZrcGh4T2wzZVJBTGVLcWtoTzZlREx2T2hC?=
 =?utf-8?B?NWVjYXdSVlk0TzdUZ2NlV2dEeWFTdEVzOEJtcWxham9UNWNUU216TXljRWhW?=
 =?utf-8?B?bTVraVhvT2dvYkhBdjA5UHdqY1N1ZlZoT0t3elYwQzVZc3Fhdi8wdUE0VnRV?=
 =?utf-8?B?ckNGOTFrNFNvbm9DdmFwRUJQMCtmWS9POEMvakwyR2hjQllEeS9Va2M3N0lp?=
 =?utf-8?B?RHhHZ3JWOFRTWm5oa0RLa2hIU3ExeHVzUXVBUGlpNjZENUYyWnkwS0EyWFEv?=
 =?utf-8?B?QWlUY3lPMnNQWkc3SnU3VVNCamZPTytiS254UjhzWTJRVWVORVNtU0NVT2Vk?=
 =?utf-8?B?SHN2a3RkMjdNZDFVK2FvOHFrK2VSZnZCMWU1L2d4bDZwL29UU0ZqL3ZIUGUz?=
 =?utf-8?B?NEx2Tzl3aW41MGJGYnBuVStWR3NtOWVNemUwdWsvMXUwZThjb1pqSzZscURR?=
 =?utf-8?B?NGVvbytMLy91QXdiS091M1NKN2o2SlBvTlZaZ0YwY3JjVmRUT2xGbXliR0FE?=
 =?utf-8?B?Nks5eTdMQVk1U0N0U1VxR2JwTUNzRFNDd003UFlZdS9VUmp1dXpvdFZaU1N6?=
 =?utf-8?B?bEFIcTdxQ3E3TmhWWXN3cE13YWJ6NFBOZWhTb0JLZ0pYV1NncEE5T3JWeHZQ?=
 =?utf-8?B?MDhmbXJBd2JYRloyS1E5eTdtT3F1U0I2NTZ6VEtWYkd2Q21nQ1B1YjRkdWNz?=
 =?utf-8?B?UUdvRFlMVnNTL2w0Qi9ENEFBeVJWckxZbFZjWVRYSTZ0Mno2bXpzN3h0SWVw?=
 =?utf-8?B?TENsd0NHTHorWU5VY012cmxuSTdGM3NLUThMcXpGRUFybDFlSTlMQm1mT1lx?=
 =?utf-8?B?bUpKM3lPbXhqTHIzMkJnUEJJSjk4SlFMdHRha3Q2MFFJeEt0dCt6eC9VOE9q?=
 =?utf-8?B?YkNhY1RidzF3cUhhSE45elUvSEJqSWtEeTl1aElTbFUrKy94TEUxTk5iMFVn?=
 =?utf-8?B?T2NRWEkvbEpVUkYrcU5RRURNdCsvQXpicGF5NjlvN3EvTHBmTGVod29zZk5E?=
 =?utf-8?B?RmwwRzNnMzF2K3NNdHhOWCtNS0Q4YkdTY2x3aXQ4U2ZLaFdLT1U4VlJsYnJ3?=
 =?utf-8?B?ekpTclVxVUgyZStSMlB4Wk9KbS9Pc0lSeFRQRS9ubVRXUFQ0RFRTVE84WnRy?=
 =?utf-8?B?TUdvcXY0NU1GNlZrRGd1ck5CZ0dSMmt1bGxtQTFrUE16SStucjhYQ01kcmJi?=
 =?utf-8?B?R2FlRE9jbXY4UFBRN25QankvZ0NxZDJMT04xN1VWS2NneUM4Rkw3TytPdThk?=
 =?utf-8?B?UTViYUh6T2tqSTIzbVY2L2M2ZEU1ei9QNGZUZkdKZ2tFd243NU90elNhamx5?=
 =?utf-8?B?LzVXR2JxOVJQdmxYUkF4U3psb3FHeG5GT2ZzbjVuNG5CQWJYY3Y0allxVU9t?=
 =?utf-8?B?NHVNM0hjbUptYXZyTWx3NTdNczFDQS9KMk40cDRSYzNaNmYrODNTMkpsekJj?=
 =?utf-8?B?dHhPbTlOWnQyWW1LTlNlbnhsb21hUGMxYWEzYldLRkx5UEgveDkvKzBDZjZ0?=
 =?utf-8?B?VURLSmdpWmdKSElqWnEwSDk2bmtwcmdBemVqSFVJUnk0YWw4UjE0cmxsU0Nr?=
 =?utf-8?B?RityUUVxRkJ6THhnQTI2dElqaGVWV09yN0ltQ1o4ZFV6ZWZMdTh2MWpJUDdt?=
 =?utf-8?B?M05IaVBsWElLM3RwK2g4YmUvMXpmWTlwTkFKMGE5UmpBT3FkMm81VlBiRjhx?=
 =?utf-8?B?N0Z0enNYRUVIMUVsdVRZRmNKVTg3UktYRGpWeUxvMmxsQUw0R1ozRjdZbjZp?=
 =?utf-8?B?cmVNMVFiWXYwK0JzSjVUeEs3dDBXTWtKakswTlNVWWk5Ty8zcDhXOERsWHNo?=
 =?utf-8?B?N1FHSFduY1dVaXhubjhVQ3VLWHFFL2l3TWNBVlNoNHBwNDgrTVREck4zanYr?=
 =?utf-8?B?NFJTT2tjN09zQ25hZVkrcnQ2clRLUVFJcGdlekdNQ2Zzd2xtMHpzbTgyaXJ3?=
 =?utf-8?B?TlhhaW9MNHhyZHcyeG1xdVl2ZVNVZmY2K3dUUGF1dkdJakNRRlJybzI1OTU0?=
 =?utf-8?B?TFRaQTRjZ1lWUVdZU2JsRXlIWnFsMndpaXR2Ly9IalBZWFU2ME5aNDRhOCtF?=
 =?utf-8?B?WWNFMTNIYTBTeHp5T0VDaDF4aG4yclFweWpuVDlpclRnM0ozdnUxbm5DUFhX?=
 =?utf-8?Q?xW0xg+zX0Iqxx3Ig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f21a72a-9af2-4c98-005c-08de5efe306d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:18:15.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbkvl8I4V1nLYtwTrhbkvNgR63eeBhnJpbQZSaZ4XUWqjKfvxauqzcDpMMnTYMqc2j+ieh81p/v2aZ3tELjFIb8rG1jkH7hWH46M+/6O2l+xvI1zafGE8cA8akecbphg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12476
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 06:18:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21782

SGkgVWxpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBI
ZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjgsIDIwMjYg
MTI6NTEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBuYWJs
YWRldi5jb207IGl3YW1hdHN1IG5vYnVoaXJvKOWyqQ0KPiDmnb4g5L+h5rSLIOKWoe+8pO+8qe+8
tO+8o+KXi++8o++8sO+8tCkgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+
IFN1YmplY3Q6IFJlcXVlc3QgZm9yIHJldmlldyBmb3IgNC4xOS1zdDEyLCA0LjE5LWNpcDEyOA0K
PiANCj4gSGkhDQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJhY2twb3J0cyBmb3IgdGhlIHVw
Y29taW5nIDQuMTkga2VybmVsIHJlbGVhc2UuIEFzIGFsd2F5cw0KPiB0aGV5IGNhbiBiZSBmb3Vu
ZCBpbg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9j
aXAvbGludXgtY2lwLmdpdC9sb2cvP2g9bGludQ0KPiB4LTQuMTkueS1zdC1yYw0KPiANCj4gMTIx
NDAxZTU1MThlYSBORlN2NDogZW5zdXJlIHRoZSBvcGVuIHN0YXRlaWQgc2VxaWQgZG9lc24ndCBn
byBiYWNrd2FyZHMNCj4gYmFjN2QyNjAxMjkyNiBsaWJjZXBoOiBtYWtlIGNhbGNfdGFyZ2V0KCkg
c2V0IHQtPnBhdXNlZCwgbm90IGp1c3QgY2xlYXIgaXQNCj4gMmM2MDU5ZGVlZTJlYSBjcnlwdG86
IGFmX2FsZyAtIHplcm8gaW5pdGlhbGl6ZSBtZW1vcnkgYWxsb2NhdGVkIHZpYQ0KPiBzb2NrX2tt
YWxsb2MNCj4gODI5ZjJmYzJhODI3NCBqYmQyOiBmaXggdGhlIGluY29uc2lzdGVuY3kgYmV0d2Vl
biBjaGVja3N1bSBhbmQgZGF0YSBpbg0KPiBtZW1vcnkgZm9yIGpvdXJuYWwgc2IgMGJiYmI0MGI2
YzBiZCBmMmZzOiBmaXggdG8gZGV0ZWN0IHJlY292ZXJhYmxlIGlub2RlDQo+IGR1cmluZyBkcnly
dW4gb2YgZmluZF9mc3luY19kbm9kZXMoKQ0KPiBkZDhiZmQ3YWVkOGM2IGlvbW11L29tYXA6IGZp
eCBkZXZpY2UgbGVha3Mgb24gcHJvYmVfZGV2aWNlKCkNCj4gZmQyYzFmYWMyZDUzYSBjcnlwdG86
IHNlcWl2IC0gRG8gbm90IHVzZSByZXEtPml2IGFmdGVyIGNyeXB0b19hZWFkX2VuY3J5cHQNCj4g
ZDhlOTM2ZWM4Y2MwMSBmMmZzOiBmaXggcmV0dXJuIHZhbHVlIG9mIGYyZnNfcmVjb3Zlcl9mc3lu
Y19kYXRhKCkNCj4gZjMyZmExODUwMmZlZCBleHQ0OiByZW1vdmUgdW51c2VkIHJldHVybiB2YWx1
ZSBvZiBfX21iX2NoZWNrX2J1ZGR5DQo+IDdmMTI4NzEwZGMwYWQgY2xrOiByZW5lc2FzOiByOWEw
NmcwMzI6IEZpeCBtZW1vcnkgbGVhayBpbiBlcnJvciBwYXRoDQo+IDZiZmRiOGZjMmNlYTUgbmJk
OiBkZWZlciBjb25maWcgcHV0IGluIHJlY3Zfd29yayBkODFkZjg1YWZkZmVmIGpiZDI6IGF2b2lk
DQo+IGJ1Z19vbiBpbiBqYmQyX2pvdXJuYWxfZ2V0X2NyZWF0ZV9hY2Nlc3MoKSB3aGVuIGZpbGUg
c3lzdGVtIGNvcnJ1cHRlZA0KPiAyYTYwNmM2ZmQ0YmFhIE5GUzogTGFiZWwgdGhlIGRlbnRyeSB3
aXRoIGEgdmVyaWZpZXIgaW4gbmZzX3JtZGlyKCkgYW5kDQo+IG5mc191bmxpbmsoKQ0KPiANCj4g
VGhhbmtzIGZvciBoYXZpbmcgYSBsb29rIQ0KPiANCg0KVGhhbmtzIGZvciB0aGlzIHVwZGF0ZS4N
CkkgcmV2aWV3ZWQgdGhpcywgbG9va3MgZ29vZCB0byBtZS4gDQpBbmQgSSBhbHNvIGNoZWNrZWQg
dGhlIGJ1aWxkIHVzaW5nIGRlZmNvbmZpZywgYWxsbm9jb25maWcsIGFsbHllc2NvbmZpZywgYW5k
IGFsbG1vZGNvbmZpZy4NClRoZXJlIHdlcmUgbm8gZXJyb3JzLg0KDQo+IENVDQo+IFVsaQ0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


