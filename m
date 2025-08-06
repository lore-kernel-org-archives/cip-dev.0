Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4136C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 22:32:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.37669.1754519518587075634
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 15:31:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=LUnMHys6;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754519516;x=1755729116;bh=hq6VIfKgUqzhN5OO2BCKbDoDj7wDOKZt6gjjE46
	Ytog=;b=LUnMHys6ujbsK7+ELlt4MO5Z/XKEBeVHnKoDP+AB4eaD48C1cbJ2/N3yuFtGrzcultshJ
	k3Xn5TktktOddHrO7thGTiEiAH284nEy4EsPUSlwek7kakNDSnqSFW4mcJRqUZO0Onl0gXz4JSo3H
	wKBfUjqbhKjNMOsnrrLPk8nehi2JdXBBRwVi7K5QXr+dQnNMoJ7/o90LD5l0/qEC53N/7dJEVD7yp
	kxRCCyrBoUrRZpNLXqXGcRxrnpOZHska2YWPjYObgNTVmbFrk27KHBhjC5TPjYPoGNIGBivqGj7vG
	kGbvFc3ygxyrMGY2Tz4xY1izo7D9HxKD3nmh0ijItw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 576MVtfp1034081; Thu, 7 Aug 2025 07:31:56 +0900
X-Iguazu-Qid: 2yAbaKzOkhlaNyLb2u
X-Iguazu-QSIG: v=2; s=0; t=1754519514; q=2yAbaKzOkhlaNyLb2u; m=ltohMfJ4xHCDp0FcnYQDUHc1DczpmwUpjYRBQZEVcOM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 576MVrx93128014
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 07:31:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb4Mr4/9qKL1Gg9LT1DJRjghZSEstP2UZ87ap4YrPPTLjvTjWwHUgcORZD6kv7tDssitJOCBJLeJyl0lyU6xSwcru/g+wZchPwqqP9TGZ2wJlZfdNWoMDjTS010RgmDhkzv4omokHN2Np1aUpMQZdRL/zGLbIkocDVND8Rw142LVRF4C1fU7i9nqUAhxL1RRl4nGWKTwtmP7O4wQwSZkmo967UkKiv8CtL4Fg5FiZjSwGJvRJjBfXz6ENiNUVchjMwGmPdMQeBkHxhW9FWZwWfNLqrwE2Q/U8WgfCW7GtzzGUn2vj9105xxuoZPU/shH17MO+rOEmrr3AYaWt8wDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq6VIfKgUqzhN5OO2BCKbDoDj7wDOKZt6gjjE46Ytog=;
 b=AEFXRu0GG1/EdN9PqvmMoveJYf5n8yVzmWMdKFXHVg6hlgSGi2s8RjxD+hyNwCxo8CHL7nR8xxiKBJ4wh8crMM6U6IGJnq5rk2I6fIpFBXSK6r5wry8+waKrTsJC9967HFtiPU4LRlEQICz0/WNF5XwJlCivbHg9BUNbakz40cloiontLmvTxCMoSkiEcS1RhTmElvRlQvHH1UxpGXpgUMttKsS2cz9KA5Y18z++XdMfsmsLi04yJIpddsGONJO123vhLjF7g55mXVnM+ej5vj2rZTGa9VbpmRob4Ynt4dWGqksYjb6rNacVWHXlPMLhVvONXixO7MaTzfMfS0vVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
Thread-Topic: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not
 install kernel
Thread-Index: AQHcBpIgOmzYuwbGeketUM1Yw7g8VLRVX3wAgADV52A=
Date: Wed, 6 Aug 2025 22:31:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CC004906CECD1732ADBB922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1be0fb51-87e4-4b8b-8f53-2d5a44b4e2ae@siemens.com>
In-Reply-To: <1be0fb51-87e4-4b8b-8f53-2d5a44b4e2ae@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS0PR01MB6002:EE_
x-ms-office365-filtering-correlation-id: 4883569c-7e12-4b38-6ccc-08ddd5390a0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RzBDdmhkbzg4NHIyOXp6NWNtaUZxZ3pTK2NFSzRWRUlybGI1VThYVVlZZ25p?=
 =?utf-8?B?WE91SHpTb0xLKy9HcUN5ZHdMMFZDeVB0N1Y2OW5LUlhvM0lvS21Jb2RIallo?=
 =?utf-8?B?L3dlcHloRThiUFdBb1YyeW9KV2JIR05qMzFtZlFzMEJBTVJkYUNGNXR5ck5W?=
 =?utf-8?B?QVM3MUNwNlN6UDVaMXJlRi9YTjNiUXVvcE0yblRTdzJLcjF1VThXMG5jSnJL?=
 =?utf-8?B?dG51NTlxQWxKVzdHeHlyUitML1dCWk1EaE9rckg1ZlovRHh1L2RDemFPZTNj?=
 =?utf-8?B?MWhVUVZpeU1xa3ZYK3NDb1lKMUVHQkxoVDNrRGIxVWxRZlplU2FLL2Q1eUFq?=
 =?utf-8?B?MElpaFBpYVc1dnU5ejB6eDlVdm5uek5pcG9INm5FS3pvTzN1NjdSTlFLOFJR?=
 =?utf-8?B?MmtaeHlLY3RpOXVvcVhhZ0hhd1NUSXYwZm50czFVdExsYkZKNUdJMk5Da0RN?=
 =?utf-8?B?WlVjTm9ua01CbTBINE5rRmc5STgxVmorTkVhdFlRM0lDUHgyUnpVY3NiSmNK?=
 =?utf-8?B?NURLcXF0dzBzYWxkQ1ZoRkNoVDNXQVIwbGpLMDFObGlZaktUZ2xZaHAxSlJy?=
 =?utf-8?B?Qlp1SWEybWMvaTRFclJGZFFYVGY2VXI3U2R2SWNIS0xqWEVvQnlFMnlCUW9N?=
 =?utf-8?B?bXo3L1hyRlZTODMzKzVQaFhnL2tZRlN6TnhLcjF6dmo0M3lKNjZad2lTRVBj?=
 =?utf-8?B?VjYrVnRWSHlaaEZXWGh2UVBmbHpFQm1hVXByTnRvZU1IU3hFWFNnUU1USjk1?=
 =?utf-8?B?bHIyRS82SUlUcmJYYStkN1FkVUZ6UnV5cUJlbWZBbWp1dzh4M0Iwc0M2QUU1?=
 =?utf-8?B?VWdQUE5SMHlyWTd6YzZueDg3ZGNzM0tlMFBLWVZ6SEg5OHAyKzZaYytEMXhz?=
 =?utf-8?B?MENKMU42cTZKTmpRYXlXL1BYT2xkQ1lzcCtGc3RDNGsvUFBpOEVhQm8za21j?=
 =?utf-8?B?cmxNM0hJcVNENXUwdDRpRzhzZjg2Y1I1TGNDOFBKUldOTjJrdy9Vc0I2ZlM1?=
 =?utf-8?B?MXpOZDhTSHpIbmJLSEo0RmF2MVBJRTlCeW14Q1djeWZHRGtxbVJHQ043bURu?=
 =?utf-8?B?UTVjZ09xM1NSU3lBdzdwd0Y4Y3p5NGNzVGxmYVFpNVljVWlQSzdXMDl1S1Jv?=
 =?utf-8?B?Y0pOckdLMUpNcjgwYXp0Ni9ZRWpwaVhBN1pYQmk3UE1YR2EvVjJLa3FsZGsw?=
 =?utf-8?B?THNCdmNXa0ZUTmN5TTRNenpzUjFhUzBEVjJQbnVUZXVza2dWVG9kd2YxOHVO?=
 =?utf-8?B?Z2hWVGwzSkVoVzNsaFo4bVVJSXZJMk9YMVcrSXBpMmpMV2piT0U2STJaQ1hI?=
 =?utf-8?B?Njh1TXRQMWxaaE01SzhFOHJydFBCbVFmV2tHR2FMWjd4dGZVVXQ2TTVqN1hj?=
 =?utf-8?B?LzNwUVpac2k3WERtOXBrQmZuaHlueWlYT1lhNUlRY0xvZWxsb1k4M2R2bXVk?=
 =?utf-8?B?c1lqZ3Jhb1lxcHVsSnF2dGlZM1YxbFc0bzB5OHVLa3MyQWhzb29BQVVMT1dR?=
 =?utf-8?B?UlV4a1RSemUyTGZveFFTMlE4ZWhFYjBxbWpBRFliS2toa1dBbG0wWDZlUTJm?=
 =?utf-8?B?WkZOSW9CS2t0V0lFK2V4aFF1ZHFVM2tudkdrWEZuVmQ2T1VGNlU2VnlZaEdT?=
 =?utf-8?B?SDZqOVVjZkpJTi85ZnpEcXNub2hzUkxiYVBlSFIyQ2ZjejJWRzVmNnM2V1kz?=
 =?utf-8?B?eS9ndTdQMDJtM01YR0l0ZWxzeEJRSjN4STBNd3JLanhDRU1rMVlia21jTTFs?=
 =?utf-8?B?RnZ6Q25McVQzM0R4YkpBUTN6MExrMU5kN1BOWDBsNE1pTkZvNzJzcGlLK1pK?=
 =?utf-8?B?cTJwY1RpZzFYTTZ1aklRUlBNT2hqR2tPYTQ2RHNvTjY5NGVIS1FiMzMwTzZB?=
 =?utf-8?B?TmVmVzMzWjMvZDdTd3h2em94N1RjVHo1RjJHYmJPTm40cWtOZ1lNMnh6eHQ2?=
 =?utf-8?B?KzJJUzlBZ2ZKSnlESUNWUkFKdlp2eVZPc2ViQmc2d3hRTHlaaHZuaFNCMms0?=
 =?utf-8?B?azBsRk1iNGNnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?elYzcjRDcW8reEozUTBBSHhoS3ZkM1FHa2lvTE5iVXdIaW5Ic241UFN2bDIz?=
 =?utf-8?B?UzhYOUFPVks3aFdGRHhqZVk3VjBaMVNqZmFObzg4TmpYREZoUllhT2c4dlh3?=
 =?utf-8?B?M0x0VlRqNGw0a2ZndUozQkhPeHFyTjBUeXAzN3ZUNTQrSFdoSXUyeWFITXNO?=
 =?utf-8?B?a1d0OENOWTlJN3N4NmswUDM3YUQxZ1BmVkxocFRxR0d3QkV2eVBVVXAxMzFB?=
 =?utf-8?B?dWpSOTZHaEUxZzdlRmJCTlJCbjRjSmJsNDB1MUN5dzhqc0Y5L3JSc2U4bmN0?=
 =?utf-8?B?MHE1MEZSRlZiSWk5bHBiUnBnZzVNSzVmZmNvOVJvajk1azN3Z0VyV2Z2ZCsx?=
 =?utf-8?B?RWxZenJ2VnZVMlZuR1ZIUFlTeWIybjFyTGpjSXJpd1M0N3haUUZFOGx5c2Ux?=
 =?utf-8?B?bzlFc2ZvUTJZZ2NqVDhwTzJyd0EzT0ZxM2N5V2Q3eFBabGd4R3JPR1F6Qkh6?=
 =?utf-8?B?VnVONlNlTnd4MkJWR3ZiMWc3VGwzbnB4K2xvRGtRVjBnN1J1SU12d1E2V3B1?=
 =?utf-8?B?KzRVQmJnMTdqQnlGYjVsTkdnWkgzNWNKczg3dUVSaTV1bTdqVGRUQmhXVUtz?=
 =?utf-8?B?YmVwa2g3OG9xQWdnZVdVdWc0K2FZcVNIUnQ5Mm55ZEY4VTFCbXdtYVpnTjdQ?=
 =?utf-8?B?QUUraDZtT2dqWnY3WXdtS21jMUhORjN5R245TWh3cmZKYVhiaDh5WFVDRFM2?=
 =?utf-8?B?QWFvbzVHNGluMlNjK3NxWm16Tks0OEhRUll6WFppOXBlSzhIUW5saEpwN1Nz?=
 =?utf-8?B?Y0FpMGZjSXcyOVhORDh3eVpxNXV4MkppOVdzTDNNNzM5M2I0WDhFc3RNSmpr?=
 =?utf-8?B?eGY4YjFDanhLRmh2cVgySEFRL3B6eWxKeThzdXN5RVlHdHNqM29DaFViWDRm?=
 =?utf-8?B?UGY5Q0FTNjZlVmk0alMvVTBEWGNobkZ3cHJOckpER0RWV2cxb0xBNXJoSFJx?=
 =?utf-8?B?cklPTmZrYmFIenh2ZTlhazdBU2JWUGZaSTQzT2VoVFNHYzJzM3hNWm9TNExr?=
 =?utf-8?B?QVd5clQraE52b3NraW5wb016ZHc5VnZ2dy9oTVFDSUtDN3M4R2NCSmQ5RU5a?=
 =?utf-8?B?RzAvbXVXSE9OVy9KS3c4cUU0c3lidWNpY2RybElmYTFqdEcyWUxXVnhyZjJS?=
 =?utf-8?B?cVJKSHFVbTNCSTdhWDB6YktBU3RFbUVGRWQveEhmbUtObTdZYkVUaDBIYkJK?=
 =?utf-8?B?d09TSFh1K1RQMXVBWDZDUHZpY09aMnptK2hTdENYRmUvbCtkM09kTmR3UVFJ?=
 =?utf-8?B?Nk5qcG91VGgrS0MrR3l1WjVSc084RFMvWjdpY3Y5aVZZZFpKK3EvVnZPSmEw?=
 =?utf-8?B?Z3BtV2RveUVLQ0lrOFZVN3RTMER3V0pQbDlqd3FSNnJPS2gxUmwrZGd1M3FO?=
 =?utf-8?B?ejYyaW45RHl6SGtydHE4Ync4Ry9hQVIzQjZSdFhBOG1BZ2o3Wk5ZZjRCZ3pI?=
 =?utf-8?B?bitIKysxTTBoZzZUMFhpUlFaQWhmYmtjam82K3hIVXRhZXpBN0MzckhKdW5l?=
 =?utf-8?B?akdzTmgrN1NnUGlRdmlWMDdlamY2aWlTK210SkprcUdkL1JneG9meCt3RXJT?=
 =?utf-8?B?b01uMThEeDgwdkVVdHFnUVdLa2ErRkt6K2MyYWlBUUN2TVA0L1dVd1BJWjlW?=
 =?utf-8?B?d2pKeVVNTk5RcFlHcm5zSXhIbmpWWWdLVUtOSGpMaGZzdmdnSjdBbG9HTjVh?=
 =?utf-8?B?QWdqOGFOSWUrclYzbVFYQ1ZLU1lqMWgvemhPYzVIREk4UldyV1FYT3cycGdo?=
 =?utf-8?B?UVowQTBqVEwvR3pQa1dKRnN1WVAzZUJIa091ejVXb3pDc3BTN0RPTmV1MTV4?=
 =?utf-8?B?bkFCRjJmalMxSk1ib1JtQjhncEFCME1xMk11ckM1Um9QVExuTnRURVVMdkxz?=
 =?utf-8?B?YmVTdndCWEU1NHdEVEZHNVprdWNKbnoyUmVPRE9kMDdRSytzejhJNXoraldB?=
 =?utf-8?B?b08xZXlFUzg5RWhhZjNCajJNODRBTnpDWHBpSmp2TlJIaU1pMUNtWHlxZzQ1?=
 =?utf-8?B?Nm9HWlVVSjU0bTBkMUNCQ0RaMmNtVFJNUmRxd1ptUmxJaVB5bFdDM2tBTnZN?=
 =?utf-8?B?aVQwcVora3llK01KRG13Wm1FNE9NbDZQUWFVUEl2c0c0a2luK2FKcFV1bTkr?=
 =?utf-8?B?Z0RmVmtRRFVaTmJJY3QwcDIwUm83NWdLcVhIWSs5cUM3bEp4b1JWQi9vREFO?=
 =?utf-8?Q?PsgEhD+HXQWmPlh/7uo+XZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4883569c-7e12-4b38-6ccc-08ddd5390a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 22:31:51.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ergo7MmVjktjYb1yrwX6UCQt1kL48Jzf77He+kwYNWC8lVjuw75ybOe8pdtZxWYuVI5kJQqCuL1W9fL+oLpKkd+tCuAdKfPeVFl8z+OAPCAzpIo7k02fiObnCsg+xl4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6002
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 22:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19698

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1IDY6NDIg
UE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj
4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVd
W1BBVENIIHY0IDEvMl0ga2FzL29wdDogQWRkIG9wdGlvbiBmb3Igbm90IGluc3RhbGwNCj4ga2Vy
bmVsDQo+IA0KPiBPbiAwNi4wOC4yNSAwNzoyMiwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+
ID4gVGhpcyBhZGRzIGFuIG9wdGlvbiB0byBjcmVhdGUgYW4gaW1hZ2UgdGhhdCBkb2VzIG5vdCBj
b250YWluIHRoZSBrZXJuZWwuDQo+ID4gVGhpcyBpcyBtYWlubHkgaW50ZW5kZWQgdG8gcHJvdmlk
ZSBpbWFnZXMgZm9yIGtlcm5lbCB0ZXN0aW5nLg0KPiA+IFdoZW4gdGVzdGluZyB0aGUga2VybmVs
LCBrZXJuZWwgaW1hZ2UgZmlsZXMgdGhhdCBhcmUgbm90IHVzZWQgZm9yDQo+ID4gdGVzdGluZyBh
cmUgbm90IG5lY2Vzc2FyeSBpbiByb290ZnMuIFByb3ZpZGluZyBpbWFnZXMgd2l0aCB0aGVzZSBm
aWxlcw0KPiA+IHJlbW92ZWQgYWxsb3dzIHlvdSB0byByZWR1Y2UgdGhlIHNpemUgb2YgdGhlIHJv
b3RmcyBpbWFnZS4NCg0KPHNuaXA+DQoNCj4gPiArYnVpbGQ6cWVtdS1yaXNjdjY0LXRlc3Qtbm9r
ZXJuZWw6DQo+ID4gKyAgZXh0ZW5kczoNCj4gPiArICAgIC0gLmJ1aWxkX2Jhc2UNCj4gPiArICB2
YXJpYWJsZXM6DQo+ID4gKyAgICB0YXJnZXQ6ICBxZW11LXJpc2N2NjQNCj4gPiArICAgIGV4dGVu
c2lvbjogdGVzdA0KPiA+ICsgICAgbm9fa2VybmVsOiBlbmFibGUNCj4gPiArDQo+ID4gIGJ1aWxk
Ong4Ni11ZWZpLXNlY3VyZS1ib290Og0KPiA+ICAgIGV4dGVuZHM6DQo+ID4gICAgICAtIC5idWls
ZF9iYXNlDQo+IA0KPiBBbm90aGVyIGZvbGxvdy11cCBxdWVzdGlvbiwgdG8gdGhlIGdlbmVyYWwg
cm91bmQ6IERvIHdlIG5vdyBzdGlsbCBuZWVkIHRoZQ0KPiBxZW11LWFtZDY0LXRlc3QsIHFlbXUt
YXJtNjQtdGVzdCBhbmQgcWVtdS1hcm0tdGVzdCB0YXJnZXRzPyBDSSBwaXBlbGluZQ0KPiBob3Vz
ZWtlZXBpbmcuLi4NCj4gDQoNCkZyb20gcG9pbnQgb2YgdmlldyBmb3Iga2VybmVsIHRlc3Rpbmcs
IEkgZG9udCB0aGluayBpdCBpcyBuZWNlc3NhcnkuDQpJIHdpbGwgY3JlYXRlIGEgcGF0Y2ggZm9y
IGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg0K


