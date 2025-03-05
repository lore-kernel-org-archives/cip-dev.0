Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C0C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 04:53:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.6565.1741150406528797900
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 20:53:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=MvSf3dhN;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741150404;x=1742360004;bh=FUpjcusaXVOcILHLaKkyvpH8Q2GxjScx9Y50VdE
	Y5ms=;b=MvSf3dhNrjqZ3d1EbSN4GpoVKN15PhBs/IfYMaIFHvS9bbaIH1wO3MfFF2m28Snqo9S35
	FIiAdhcMXQsqfWSCdQuDtGi+lEa8lMoLXSboQ+wRJLkXU+DLBsV7y7B9kt8Nx7UXpbIaqtuqwAfzA
	YZrg7/kv2Fbu5/qRWPz0AfccZnxsXAy72K4LbMfIt93/owQLpJCqvLCG+gssAomjJ4cPpm/VUsrWe
	lSdliq9cME3p1rUI1Kp2KVIadbkJre18JVz5i5xAmFPZ0ElTImq0eY35Rulnt6efa70LOUP7mBi+z
	r5Y0D2Iz4F2xXf0ORGvMd//bFDWrRp+QOGc+LuvlKw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5254rOca1250500; Wed, 5 Mar 2025 13:53:24 +0900
X-Iguazu-Qid: 2rWhBFYKJHenRNNXSg
X-Iguazu-QSIG: v=2; s=0; t=1741150403; q=2rWhBFYKJHenRNNXSg; m=55U7UEE7rA+gmW/214gk8Okcv5PpusSIhEExVNaWibM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5254rNYZ2635723
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 13:53:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVXV0c8ib4gbqikb3p20+y6cCFd8r1szrWFb/Aj1NsueL2zrNDdDtHu9nswXRUJ/dXXJxAkpfPXyc9N3/VK222/rKrV/pT5DEBRdXC+p7ops/9hgzuDXr3brGr8NMXTizxxhyQXu/BHA0vJK+438gL5O5LcGkperx3ag1tr5T8W4cXZcXjuuej0DmbkPuJSs0GffaXfwFHjn4wL5OANZ5GCYdYiXwHj7KVA7InBEmR0j2fo2A17PMRy8Wh8ncYgTF6hsngr+3Aa/4GG/AM4wQcV139VwteXDYqGtgBb1bldPJmMeH8ungTwTuBnYuTYQckbC1t49NN5zbUvQBsmBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUpjcusaXVOcILHLaKkyvpH8Q2GxjScx9Y50VdEY5ms=;
 b=zRnmFdQkC7Tqr/aYBI73JD80KdGScTcnRl68Xzym0TsC/onMJitBT5prYxVax3MRVH4xjV3QvaRUr68bhVjybpoWclnvuXw10MHyuOISD/PfOE/QlLij5B0z5ds30SocWebWyTKXFkusTYNualT499N4vnG/suRpfjxua9We20eexg89ciJnzrdnSzi8weR5aUgb0nVnH/DPR0izOMPk8j948gZn/BJHoavIPH/gO4UwfQpaEOtuYqnKu9/ivCCThjBmtFXd+75uq0moFzwo3ozMBQ/riMQQV8fEFEi9PANKFwWcLzNb24X2CJ+0Zzp/Bwu0vuvnDqXSENTaF+pxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 2/2] Kconfig: Add config
 NO_KERNEL for kernel selection
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 2/2] Kconfig: Add config
 NO_KERNEL for kernel selection
Thread-Index: AQHbid7dyuHAtWXU0UCboi9s6gjyxLNc2r0AgAcmdPA=
Date: Wed, 5 Mar 2025 04:53:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148187AA86B83FA1B6D8A61A092CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1740746806-6557-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <3deff6cb-afee-4f1b-b6fe-e8b4261ff8cd@siemens.com>
In-Reply-To: <3deff6cb-afee-4f1b-b6fe-e8b4261ff8cd@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8845:EE_
x-ms-office365-filtering-correlation-id: f30feb60-9bd2-4e27-6528-08dd5ba1a72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SEhWNVhNcEdBRUhYNEs3dktUSmV2SnNSaEFYQUhoM3B1b0dDUm56bWdCZVlN?=
 =?utf-8?B?NWVCeUNIRmhFRUV4aG5ZN2JuT29jQTAyRmptdit0YzV6azh0V1dLUi8rV3Uv?=
 =?utf-8?B?SXdlL1RGaTFyQStyOTViQ056NlFNTkwrREtETUtCeGR2MXM4aEV1WUNZTGJ3?=
 =?utf-8?B?RTlXenVoWlRQS1I3Q0YzejA1UzNyOGtBVnlKK2VNR0VMdXZPY1ViaUdBMnZ4?=
 =?utf-8?B?bEJER01mdXhYckVUK3AvRFVIRlRUODVJdmN2NGNMQTd5L1JlZ0h2WTJyakoz?=
 =?utf-8?B?bW8vcUlEL0s3MEtwUExRN2hSdWQwYWlMR3dyZUNuT3haMDBMcUREQmVJYlNw?=
 =?utf-8?B?a1Zuem04WSs3ZElGQlVXY1dETUFodFFPRElYR1BXV0NWckxUVjhCSnkxUzMr?=
 =?utf-8?B?ajFvc1owVGZhSUNUNmFYK1V6dkp2YXRROWtING9yR05qV09qNHdZcTNDUWRQ?=
 =?utf-8?B?RTNhK3Bya2xsN3dYRFRTUWxiVXJRVWE0TU1OeUpMOXcrT2tNS01RaFcrb1Vk?=
 =?utf-8?B?amZycEhnUGx0T28vRXVmUTZZU0pYSFQ5cnphYkd2MHRoYnp0WjcwZlJEQ1dp?=
 =?utf-8?B?VTloT1p4R2JyRTFsdGNYdUQxUDdFK3RDelp0bmMwTjFOclVBZ0VhOFpiMDRw?=
 =?utf-8?B?ejM1QkIycXdvMUVnSkRxcWM2dWNCV2VOQStaUmdWaVh5MmdZNWVqVkt2SXFG?=
 =?utf-8?B?T1JmTHhuamt6NG92RnVORUZpODVaQ1QxaVkvZ1ZTK0VteG8xaUdhMWgzaDVz?=
 =?utf-8?B?MTFnNjUwdllzQW50VlBQbTkvMGpid0F5anhidVI0bEZ4NWt4dFEzRHg2VXlD?=
 =?utf-8?B?K3dERUJweHpYQnlYM2Z1eTZVTDczQ2xvMGlxTTJpSFN6SXQyZHpMRytuY2JS?=
 =?utf-8?B?RWl4a3crRU9Dem05Z1h4R1grWWkxL1A1YUdWamM2SVZzaGc5OE5Bbm9kczZq?=
 =?utf-8?B?V2JETEE1NUlIYm91aXBEekIvZklueGF3aW1vOHlVYmUvdWJVaTRGVGovWE1z?=
 =?utf-8?B?ZXhsTWFzemJhNDY5ZVN1NmFxTDVHMTYxRlRha245MmpZZ1k3Q1RybnU5dFZs?=
 =?utf-8?B?TzRLaVlRUmoxN0VXeWpUWXZTVmF1M2c4dVQ5aFRBdUZkcVFuSEczc2x0ZlFO?=
 =?utf-8?B?TFE1ZmorWEdpeXZMQ0xFUk8wenZYZ2F0eWJVWnh2TWdmQ2N0L05ZWWxiaEpa?=
 =?utf-8?B?SXAzTEt3QmVXbDBJaERpUU5lYzBRazlUbkR0WHl5aW9hTkxhVElZU0RieDhP?=
 =?utf-8?B?YTRQZmtTS0FFTUs4WGt6akFZdzZteVdUb0I4aVpOZGFiN1dEVVJLemo2a2t0?=
 =?utf-8?B?UFFpWUk2MmMrZWkrdFBPS1RVZzNZd0QwVDUvOEJjTkhjTEhNZWhIUmZQRTZ3?=
 =?utf-8?B?Q1pnSEkrYkFRMG9wclRLOWFRNng1bS9KR3FPN0NiazFLSTdpeXdaUmpRL2Jz?=
 =?utf-8?B?M2VTa3VYOHNTaUtPUUNla2FpWEVWQjBudUZCU28wL2h0VnFyK0ZjcUxXRU9t?=
 =?utf-8?B?dk1aZ0RGckZPK3B4OEJIZUhkR1V1aGQ2RlFOTHhJNnl5cHZNN01qTURsMFBS?=
 =?utf-8?B?ZW1ZeDNSaDhhV1YxS0ZzU1VsRTFyZTAxSHZINjVNS0FZR1VndDYySXFTSDUw?=
 =?utf-8?B?NjhaNWNvU0VoTVduRDhKNkRDZ0ZyRFpGUXNIOCtXMUhYZGlyVHNxUVY2TkMz?=
 =?utf-8?B?dzdlN2tSMFg0SlhvTjZQc3pkcUc3KzNDVXRwMlBBcUZHaFd0NHdMV0F0VEQw?=
 =?utf-8?B?ZEswSzJOWHRmWWdlNUdDLzY5Y0ZzN2RMcSt0dUh6VGNWWWM2R2R6WEdaQ3Ix?=
 =?utf-8?B?V24vRFQvcHFXbG1EQzBMUkZKemd6eExrbGFHRTBnS3MrMks2NGc5dnkvMjln?=
 =?utf-8?B?TkREL3hnQjgzQmhNM1l3Vzk3WmhydTBjRVU3NHNkYWxPdGdnSjRtQmF2T2E0?=
 =?utf-8?Q?TGWTBqiVteE+ZA3EIhqqFr5UyMs8EIwK?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bmpvNmpRQi80R0lqNEN0MWV4TXk2TEJLQ2p2RWppT3ZqVjBIaFVHaHB1NUdz?=
 =?utf-8?B?R1diMTlBUW5qRGZqZ1ZZM3l1K2ttOEhCK3hCQTFFRGJLNHZMbUZFR25HbnQ3?=
 =?utf-8?B?aHNvTHdsalFrMFcvMGw3QjdubnkwN3BKU29HamtxUmNrZ3hGVnZ0M0tLTXlC?=
 =?utf-8?B?ekRLR2pvTVpQTTJRNHV4bUJpTmlqRTdYd1RJZ282M2FYZURQWVlpK3RzanBD?=
 =?utf-8?B?VG1IQ1FOUjR0cVByZzVka2VSOHl1TlRTM3RPV0Z5c3h3R3piWnBBSUwzVEFS?=
 =?utf-8?B?NFU2dG1IendyUlNXSEJtMXdlV2xRaWxpKzJkNlF5N2FVNElzbGNQL0w2eU51?=
 =?utf-8?B?c09FVGNoRndURXA4T2NPdjNiM1dxSUNKNXNxdFV2WVplZ25OSFp1WnovVVFw?=
 =?utf-8?B?cVhMbzdCRjBMaXYxZXRsaTh5YkJUcVZ4MHVndjdMWWpYMW1jRlJiVjdOZ0Ry?=
 =?utf-8?B?UWtiR1JNb1A3eEVRbHNkTnNJK0xpREo1aVB0dDZGOG1hUVlGU1grdFN3UHM0?=
 =?utf-8?B?U0pHM3ozalBhVnJQMHB0MEpBNG9QYnBYdXQzYTF2YVlIQkVTVXJvMDRoOVZ3?=
 =?utf-8?B?KytkMnIzMzRTT0F4aXZxdGRRT01CcUg0RVNPcCswRHVBQ2x6SU5CR1I0VVdN?=
 =?utf-8?B?czdWUDFaeFlzbGJCeDNMaE5VQzlKSWs2cDQ1Wm1qR2VZQllkaEt3MEZxT3Zl?=
 =?utf-8?B?YUttSmRJOFF2MWNmejVqOVZCbncvaGVkWFFMeW9iNWVmajZnMUhES3ZWQVRY?=
 =?utf-8?B?RExtMmQzOFJvMjVDSWNKMXEwYVQwMlFvbFk5L2lIKzR3eFgyNGQzZlNIMC9v?=
 =?utf-8?B?TzRZQU4wdCtXN0hKdDJ6ekk0ZjlTb0tKeXY4Q1R5ZjdWY3I2UTBKNHhWWjZE?=
 =?utf-8?B?eW9jY1ZXVjBwTks5Ky9KME9ST0Jia1NDaUxuVWkvb0VucENQUWdVV1NVT2E5?=
 =?utf-8?B?cThybkVkNzB0aUd4N1hGYTVwNnJVZ042UFBjOHFaTFI4eEkxTVdGSDR3WFZv?=
 =?utf-8?B?T1RXSUczR3RQT2Jpd0VuSmFwYXJkTFE1VlhaWEpDYU04ZENpY2UzVUdaaTZL?=
 =?utf-8?B?TUtZVEhZTTFEencyRlBQNUQ2d0FlL2tmYmZqWmNHWkJPbWdBV1JadVJXeDRN?=
 =?utf-8?B?eHhXY052WlVsc3VTWlovbHFiQXc5REdITXhNdHRTNXZFb2o2NDZKcUJvSnpi?=
 =?utf-8?B?dWJ5emcwMHdRN0pGTThINkpJTjlBRXVLOHk5Mms3MGR4dUpFU2lrTmZuS0gx?=
 =?utf-8?B?Qml5SHJaMVMrc0p6clNSeHl3KzFLUERMcHlENUhrYnpUR0xnWWgzTGZpYmEz?=
 =?utf-8?B?Mld4UVZMUTFvT2htdUQ0WTQ0MVlxMmwyZmNlK3dvQmlJVHpGUjVzTFJGVGpu?=
 =?utf-8?B?ZW5zR3ptRjMwVWM2dWpTeDA4MXhnNXl1UDdadkpqb3hlMkFIL3dvL2tVbk01?=
 =?utf-8?B?RjNpNUdXTk9wc1VzWWh0S0dIREZPU1NkMDRBMWFKUmdJSEVZaW5CVzZudTRD?=
 =?utf-8?B?L1B1WkF1eGJmbEgycWdYSGU4am14UTQreGhCRkdqWm5ta3MweVpSMHcwS0I3?=
 =?utf-8?B?TnZVeWdMSlhSOE1EeEV1eWpoTVg4UUM0L3BpUngwYkRMV2JvVWZHQS9pVVpI?=
 =?utf-8?B?b2NtYmhoWlQwckVNS2NNbDBGaTkyTFppVjJGazBJNUw3N0REVVNwdEsvSElr?=
 =?utf-8?B?S0wyUHRsM3ZTeHJDa3ZzbnpGWm9aR0xKYllMU2s1WHRaNy9LdWhUcnVVZ0dC?=
 =?utf-8?B?MGNrNnhseG1vWitoUzBsSC9yc3BIeDVhWTdLalBSVVVLRm1FNXM0Vnc4NkZX?=
 =?utf-8?B?Y1ROVzdXQW5Pa1VmZEI1TmM4ODk2T0RMaU92eDBYc2g1Zi9XTjFYd042S0NP?=
 =?utf-8?B?WEVMbXM4cFFKZEFadVZCU1o2a1Fod01nWGg4UDlvMGxCWUZUMVFBVllBdUM4?=
 =?utf-8?B?RitjNHJKUTFhNkJsRENRbms3dno4M2NRMlNuL2FObDJNanZBM25CeGVPYVh3?=
 =?utf-8?B?bEZrMFZCM3F3bk02eC94dTZyRElpMWhxcUJLbmR4NnUrN3R6R1FUY1kwbkNv?=
 =?utf-8?B?dVpBckYxWTVRZnRodnN4aEVlSjFVTnhqakRQZ0lna2dYRE9jLzE5MGI0cHJr?=
 =?utf-8?B?ekpLUUdzRDl5aDMxcDlySFpxVXcySktVcEloVEJWb2FpNkdGQ1JXRDZGMXI3?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30feb60-9bd2-4e27-6528-08dd5ba1a72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 04:53:20.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J+M8AMyxL/1bQYVzREGD2FRF/3D7HPaWujREunwtOgk7bH2Uqt4dx1dFQHBSrSU7nkE8IDBxFQtLoUCS0Vy2k3VmwtbdtqrOxY4X9vaOFncRBvePDE++74Gx/cmQJI2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 04:53:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18028

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBTYXR1cmRheSwgTWFyY2ggMSwgMjAyNSAxMjo0MiBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhp
cm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQp
DQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1BB
VENIIDIvMl0gS2NvbmZpZzogQWRkIGNvbmZpZw0KPiBOT19LRVJORUwgZm9yIGtlcm5lbCBzZWxl
Y3Rpb24NCj4gDQo+IE9uIDI4LjAyLjI1IDEzOjQ2LCBOb2J1aGlybyBJd2FtYXRzdSB3cm90ZToN
Cj4gPiBUaGlzIGFkZHMgY29uZmlnIE5PX0tFUk5FTCBub3QgdG8gaW5zdGFsbCB0aGUga2VybmVs
IHNlbGVjdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1
aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiAtLS0NCj4gPiAgS2NvbmZpZyB8IDQg
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvS2NvbmZpZyBiL0tjb25maWcNCj4gPiBpbmRleCAzYzI0NmZhLi5jZmE0ZDExIDEw
MDY0NA0KPiA+IC0tLSBhL0tjb25maWcNCj4gPiArKysgYi9LY29uZmlnDQo+ID4gQEAgLTEwMCw2
ICsxMDAsOSBAQCBjb25maWcgS0VSTkVMXzVfMTAgIGNvbmZpZyBLRVJORUxfNl8xDQo+ID4gIAli
b29sICJLZXJuZWwgNi4xLngtY2lwIg0KPiA+DQo+ID4gK2NvbmZpZyBOT19LRVJORUwNCj4gPiAr
CWJvb2wgIkRvIG5vdCBpbnN0YWxsIGtlcm5lbCB0byBpbWFnZSINCj4gDQo+IFdoZW4gaXMgdGhp
cyB1c2VmdWw/IEFuZCB3aWxsIGEgbm9ybWFsIHVzZXIgb2YgaXNhci1jaXAtY29yZSBoYXZlIHRo
YXQgdXNlIGNhc2UNCj4gYXMgd2VsbCBzbyB0aGF0IHdlIHNob3VsZCBleHBvc2UgaXQgaGVyZT8N
Cg0KVGhpcyBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHRvIGNyZWF0ZSByb290ZnMgaW1hZ2VzIHRo
YXQgZG8gbm90IGluY2x1ZGUgdGhlIGtlcm5lbC4NCkZvciBleGFtcGxlLCB0ZXN0aW5nIHRoZSBr
ZXJuZWwgZG9lcyBub3QgcmVxdWlyZSB0aGUgcm9vdGZzIHRvIGluY2x1ZGUgdGhlIGtlcm5lbC4N
ClNpbmNlIHRoZSBrZXJuZWwgaXMgbm90IGluY2x1ZGVkLCB0aGUgcm9vdGZzIHNpemUgd2lsbCBh
bHNvIGJlIHNtYWxsZXIuDQoNCj4gDQo+IEphbg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQo=


