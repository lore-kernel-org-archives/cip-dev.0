Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9B7C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 04:45:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.17835.1754455544563536597
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 21:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=wH0rBbBa;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754455542;x=1755665142;bh=UtAzYzVNdk5rKSgHiStRFZ1MSfLwtrrqafSJVb9
	Vm9E=;b=wH0rBbBavfT9kaZUWTvrInJ+uN40o15+rSG4fFKchAI26gyGTTqH4N8WLGgEjpGCpt7Rj
	fNSb2eBL0hpvkETW2OepoejT7LTYOhA2+j1Qw5VUeO+lUPXj+0OkY6xrIxOqBNUu4Q8Qo4bvTy9G3
	7vVSu3wgx9KP98gLQV1KdTWK15chAKDbiNsM7hVNoRYJZMz2R6FFIcd3RshHOoyMun8byWHOuSMnE
	VQWHKV90lirdlg8kpCdekKGqrAvUreF6DNjxiSGDroB2qS73a5qHYDcHnInJ2C65mOW17y2+h4qR9
	3Nk/qIQNx3WmsVh9l/ismz1qltVJxUnpiLqSUYDnYA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5764jful1589878; Wed, 6 Aug 2025 13:45:42 +0900
X-Iguazu-Qid: 2rWhiV7hVZHtOQPzKU
X-Iguazu-QSIG: v=2; s=0; t=1754455541; q=2rWhiV7hVZHtOQPzKU; m=D5ve2SqJJXiEspLeX/2fqFwc2i1qTUs5KYoCHUSBej0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 5764jeZT2818530
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 13:45:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHJ0ifa6UP92IpGtu2JMLDFsi0aS6fGf497+LCP8q7J3F8ozBfo9Kjr4ZfU9irht+uL/fT2Atj98cOt4rU7MMh28g6ndpuo1cwoAnUnvdQWE+zjOegB635nhzm1ykM48Y+x1+aLTYoBxB1bYpaEA0qoo3G8LGAPrxzGUWQFBjqJuk7cKo+O8pTrlTO2bypjB/13t6+0U4irK2jyJCfOXZ/FkcnjTcPZr6QAUbg+xokPstpTYf/2T8xmyttZzmW23X5CbHWJN3vi5lb7aNJyPrLiRTg1YPvZm6F37ZN51IJEjV0dU65kV79IqPA6NAc+/LqYMJO82dcNAepaLiTUxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtAzYzVNdk5rKSgHiStRFZ1MSfLwtrrqafSJVb9Vm9E=;
 b=NAzZTLG3ifiOP+TGfEEPi38hqE6tlchIhSQSWliXpkrvHe/8KcYM3hWZs1RV/MEUUJya0tZCm0J19j+GGEfKpvGaJ5wa/36b9PqlDh8ZZPLRIOR9ON5kKN4Vc6RjA4iNdz/FLFxlGz/6Y4KWHbiHqShS1pvYzVVwTBOB9Ozmb2iZFNY0vTSxdAXn6Sh0eP+qcohaEiI8CTP4oagA2PCWABiGQ8jNtaPOmgu/+FMchMXucEjHNKHdkawlrKu4hTyK8ahV8pj3ySKajyTTGvjdWrOWzGmT7QSQZNPh27qqDsjE3oaY/KN8ZjkQT/R6Kwo4pINXw3+NZziDfxjbMMsQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v3 2/2] Kconfig: Add config NO_KERNEL for kernel selection
Thread-Topic: [PATCH v3 2/2] Kconfig: Add config NO_KERNEL for kernel
 selection
Thread-Index: AQHb/T/XKR/PkZkfIEOok9hFXnO6XrRT1kaAgAFI90A=
Date: Wed, 6 Aug 2025 04:45:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B456BFAC1F26A2417507922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1753432849-18257-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <f4e24a42-aa49-498e-94b5-b6a5193f42c0@siemens.com>
In-Reply-To: <f4e24a42-aa49-498e-94b5-b6a5193f42c0@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10323:EE_
x-ms-office365-filtering-correlation-id: 594c16f2-0003-40db-e0d7-08ddd4a4171f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bVE2dTdqTE9DR1JIRlBHRjFNMmlFUlVIeVNVZ250Z2lwdTQ4SlhNVitOS29y?=
 =?utf-8?B?N0hKVUlQWGVSZHFKMmltTzBIVWJ2eGw3a2FvMEliRkYxMU00RUIrRTBKZC9G?=
 =?utf-8?B?bHNmWjZDYzcvTDhrSUpMa1ZrOXNJb0UvSXduNkwvTjlqT3dZSWE3ZEp5MWpH?=
 =?utf-8?B?YkpzZFZjN3B6azBJdXRIaEI3UncwZVhDd2luazJOQXZyOWMxYU5zUHNSUFgv?=
 =?utf-8?B?bHNlbC9La3Bqb1RWRjNyY1NSbUs3ZE95MWpWZDQyRGU0VU9QdjVtVVFmVFZv?=
 =?utf-8?B?NXk0MkorUFovMENSTXY0Q1NoNDZ0UWtWQ24xNlo0cGZ6V3I4VE04bWJWOVVw?=
 =?utf-8?B?L0RsQ01abTB2VStFOW52MFVEYnFyWUhyTms5cTNlS1phK25DM3krckNmQWNH?=
 =?utf-8?B?TXc0YjZzNEs2N3FFMDRkZzdsRHR4WHRzbGdqb2F0elJsNTlkdXhDQ3NZck5G?=
 =?utf-8?B?WkJaS1RGblVHcm5XOU5FUEwzUFl6azg5RkY1QnJhMzJ1SE5mVDhabDRlaDh6?=
 =?utf-8?B?U2cvNUlBcThPRkwrREdqdXdCS0JOdVF0ZGZ5QzRkTTczS1J1UXpod2o0UW9U?=
 =?utf-8?B?cDhkNnMwZysxQkQ1MzlMT1RVeFAySVE4QmoySHIrMkF2alFSSE05ZXVtc0cv?=
 =?utf-8?B?TXVjSjgySm96cGUvZ2ZlTytyZUo3N1FJVVdyVktwRy9xK0RyRG1QdXdDQ2Fv?=
 =?utf-8?B?eTVsbU9rdHEvMnp6VC9nUit2UEFkdjlLSXZJcld0anIxeFFKSEwrL05KRGNl?=
 =?utf-8?B?OThkQXZOaUhJM24yZ1lOOGVDQVBQeGNnWTdCRFB5RDBLWWRhNHNZOHRUaWZ6?=
 =?utf-8?B?SFJ4UlJOY0daaTBsWStBbmFIWUVrVXpST1p3bGl0RTloa1gyTUViYktMRmJ1?=
 =?utf-8?B?c050VGNGVzIydjJtYnlWYUNLTDUwWlhEQkN6bWFDdEI2aURmT3BmTTFKaFhp?=
 =?utf-8?B?K2lQMHpGUTJvUTYrUk85Z250ZkFoeTQwRitqMmpNTmgvZzlDQzhDRWs0eUNw?=
 =?utf-8?B?b2ZlWTJTTmFKdzQ1OFA1enk5clA3dnB1bHpYYThrQ09TbkMva0t0NGI0VzJp?=
 =?utf-8?B?ZktoQ3lLNmxrTGdtNURSM0ptdUJ3TUN2a2lEcHl5Nzh6Uk5ZN1FkM1F2ajl1?=
 =?utf-8?B?c1lDb0h5bTZQak85SzZ1L3Noczc0VW1QUUJEYjQ0anhONmdOSkt2eTFSR1A0?=
 =?utf-8?B?dWNyYVJlVmg3b0lLeVVDK3BnOUF6QmErYm5ob2tnYWhMbUpVL1NKR2NMcEpL?=
 =?utf-8?B?VUxTSFdoQUY2MldrVm8vbE1FamdYMTA0OVdLckVXUXFTUXpheC8zYWU0L3Zz?=
 =?utf-8?B?b1Y3OVM2STNnQXhncWNVanZjSVN4U0Nld2ZNUWFjRFI5UkNtbXdYUUN4YTMz?=
 =?utf-8?B?VS9HVk96NnlNaFVCd1drK1JMeVl5Rm5pQlhiQmlMa0dMNkFEdXI2bzliTUZu?=
 =?utf-8?B?cjd4eG44d29BZHppQWprSjMwUGlPdDR6dWR1YnFrMk9CKzFMTUVZeEs4eGl1?=
 =?utf-8?B?RGx2MkpQSVFFekNPY2QwQ3kwbitrRis1OFZ0ajFFZlhTdG9oNDQ5bVNVZGg3?=
 =?utf-8?B?akdaanlCVjVYdVhUZS95S0NnZlBENnREa3ZwTFBaMis1QXpacENNcHljYnRx?=
 =?utf-8?B?YmREb1JkdjByeEhLSXVCczVuMWIzRE9Vak1UMjlJQ2EzM2N4K09IVitDRkFq?=
 =?utf-8?B?Zks5b1kvNUlZY0tYVWdEbXBNOVhXdHFEUVlkSUtDMUkxUTRMN1JsbmFZZW1o?=
 =?utf-8?B?L2tKck1zQ1FwZHhWbFlyQVU1RDlIZUpNWG9WOXhOTnIxbXZ1TnNySThHRFJB?=
 =?utf-8?B?Y25iYTJmZHg2UUE0dzB4SDF0bEtwS280UEc5eXJsdmo4Q3VLWk9PdHFVdGJy?=
 =?utf-8?B?VUk4MGtJUTdIZ1lDelhTWFh4akhob0ZrQVNXNXI1MEJhU204K3lNTzFvVFRS?=
 =?utf-8?B?b0drTVQ3YTd0aFVXYmRLOHVLUUJKelllK0xISHNwYzl2ZkQ1REI4QitJcjZz?=
 =?utf-8?B?b3hCdXc1c0VRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXhWOHF4K0Z0R2dTSk5VTUQ4dmNKKzVMem9SN05KZERvSHFBTDN1K1h0K3Rp?=
 =?utf-8?B?WXRNNk0zWHgxNXkzT0IrcXVQNlR1dkNnMUowUjRDd3ZHYXQvei9aZUVhMjZk?=
 =?utf-8?B?RHI3V3J0dE5USHBjTmdNOUtNUlhWNmpoUEFvZm1ZdFU1NWx2cW0yb3ZCK3c1?=
 =?utf-8?B?ekw5MkFCRHovM3JlSWg4a1UrWi9ZV01NV1JNS2sxdjJVZjBScWxwM3c0SWFV?=
 =?utf-8?B?UVV2bk1TZ29XUTIyRTZMWGo0VzlDYUc0U0tCTnRrcW5SOFBSZlE5M05BSEl6?=
 =?utf-8?B?d21CbEV2OE5rZmx1a05BaGQxdDFSTXZoeFRrcU5rRk85aWI1bURBZks3bWRT?=
 =?utf-8?B?ZDQ5YU90aTI4R2R0Wkx4Q1NYWWZDdFNwd1kydlE4K3JzWmVDbU1mb3phR0ky?=
 =?utf-8?B?VWJIY1ppSlNTZmhkMm9rK1JBdWdIYm5tTEhSaThlRDVDNmdtdS9XR2R3c3dL?=
 =?utf-8?B?akJsYndHVmlNVngxVU1hc2M3Sm1qRW1raE1HZldIUFRlUGpQbUxzbGUvNTgr?=
 =?utf-8?B?WGpvOFJnTEMwSmUxL01pbDJEd1VNaExFUnhIdXlVNFc2UDEvZll4U0xDdVRy?=
 =?utf-8?B?OS9QM1YrTWo1d0RHVlJIaE1wUFJlbGFSMFVxSFpSUGtoWG9XMXlFYXlDZElS?=
 =?utf-8?B?ZEIvclVpQ1k3WVFKb3BJa2Y5OHQydGY5TXM2dnkycXBFR1J4eVAybmpYQVhS?=
 =?utf-8?B?R2dQMWdEY0x0RDZaOTNoMnptR3M3SXRsaEF1dDg5VGE4RWM3TDdXN3R6bnZQ?=
 =?utf-8?B?N2h5MmMyWkxwYkFERnNESWgzS3hlbEpSRU9SMko4S3o4c2RHWk1Sdm40Smkw?=
 =?utf-8?B?eFFJN3g3dFJwaWg2dVhVK3YrUTNBSWpySW9KOGdFUnMyd3Qrcy9iNjl1RXFo?=
 =?utf-8?B?Z1FkNzFYRFNaemphSzY4RE9OY2JuWHlSVTN0WjI2OXluaXE3U2cyM2JpTnlV?=
 =?utf-8?B?RW4rdStPbUwyNmFMK0N1MGw1SllIQlNtZURrZE96a2FhUEFKNUh6Rm9DWXN2?=
 =?utf-8?B?YVZGdGxVc2ZUd0ZSbHdHV21LMm9WNFVoT2RPWmlscVlhRWY3YkRkN3RMK3k1?=
 =?utf-8?B?MDEvWXErZ24vYXI0VW5NTEVBZXJheEVGQVpKMnFsUTV0QVc2eWMwa1o3cDdl?=
 =?utf-8?B?ejNmUVlWSldxZmNoZVdJWENmOERnTldJeW9tTUdudHY2R0x0eXZXdG5IVGtQ?=
 =?utf-8?B?OWFrU1VCT3ByMVdGc3Z1YjdKRVBWbXRBQllObGoxVEdLZ2k5ZmQvdS8xR0xp?=
 =?utf-8?B?Z2J5VGZKcURYRDRYdXZVQS8xZDJhMnhxT3E0Y0wxdEQ2SE9zZnVSR0YxZVJD?=
 =?utf-8?B?b2daZWRyUHFLV2VjZ0oxcWc0cTcvZFlCZzBNNDhEdXNGaktBOExWSFloaVBB?=
 =?utf-8?B?d0VLWmhHeGhVNjNUa0R1MHFXeFVNMDg2SXRwZHdmTUs1VmFSWHNuZDRrekpU?=
 =?utf-8?B?RWVRdW1Jbk16OWtnVkllQTMyOWcwOWhvL1dzY3RlYUlyNC94Z01pcTJReW00?=
 =?utf-8?B?cldjSkFtZG1SRlNybUFBZ2R0Sm1LcG5ZL0krWXAzcGx3UU5td3J1Vy9HblVh?=
 =?utf-8?B?bXUyVTNuUE1XRFdGRnpvQkxPWVE1NlV3cmdyMnU0VjVkOG85azI3Wjc3MHUr?=
 =?utf-8?B?bnREVWI4QTRkdGltVnRBWTNSQisyZWRtcFNjWHU2MU9KSU5CNmtQU01adE1X?=
 =?utf-8?B?VHdROVpubEQrdXd6SHJvc09yUDdDL1FyVDJQRWVLSkZmOXY2VVZQRFBGeDNJ?=
 =?utf-8?B?Q3Z2bXRZUXY4VG01OG03Z0RkbEtUN2dqREVuTjU1bkpnQjRlV0VnZTlvQjFs?=
 =?utf-8?B?V2R2eTVnSXo5d1k0NXRpbXBKa0tIY3ZNRDB2RkhkdTNnd21jM2xYYUNWMC9B?=
 =?utf-8?B?Z3Q4Y3hkVCtrcUkzaXU2WXJGeXcxNTAreWc5cmk3U29OV25tZmV0Y1pFZnlW?=
 =?utf-8?B?YzlwcU52TDNpNVEzR0s4eXU3Zi8zbzRKV0pFTEM4MFJ0T1JwK2s5TVh6Vi9h?=
 =?utf-8?B?RGM0NDhqbk1vNVFLRXczMXpFcExSenMwZ0RWWnE3UkpQUXBYcDJ4MXMrUnJ2?=
 =?utf-8?B?R01oM1RiZUsyS3cxcXpiN2NFYllobXdtejY1VUdUQW56bi84T0xSNEt5YWcz?=
 =?utf-8?B?WFFTQk1SZ2dlSGJvQmFhRW1JdU5RN2hYZytXWTMxLzFyOGpMaEdQdUJwVmJq?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594c16f2-0003-40db-e0d7-08ddd4a4171f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 04:45:38.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTs1A0LTCziHPeZl6vfCT2o8XBvrMj/4cE+HMSZ1x32KtHBJzwa6DXLXvbFN527C1730CVZOl/5OFS5uHTz5Sxbwws7N4qbTaB5vq4UtGl+yXE2syFFheue/+R9YMfK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10323
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 04:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19678

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA1LCAy
MDI1IDY6MDggUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk
77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28u
anA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDIvMl0gS2NvbmZpZzogQWRkIGNvbmZpZyBOT19LRVJORUwgZm9yIGtlcm5lbA0KPiBzZWxl
Y3Rpb24NCj4gDQo+IE9uIDI1LjA3LjI1IDEwOjQwLCBOb2J1aGlybyBJd2FtYXRzdSB3cm90ZToN
Cj4gPiBUaGlzIGFkZHMgY29uZmlnIE5PX0tFUk5FTCBub3QgdG8gaW5zdGFsbCB0aGUga2VybmVs
IHNlbGVjdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1
aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPg0KPiA+IC0tLQ0KPiA+IHYzOg0KPiA+
ICAgLSBBZGQgZGVzY3JpcHRpb24gZm9yIGhlbHAuDQo+ID4NCj4gPiAgS2NvbmZpZyB8IDcgKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvS2NvbmZpZyBiL0tjb25maWcNCj4gPiBpbmRleCBlMDc4ODkyLi42YWQwZDY3IDEw
MDY0NA0KPiA+IC0tLSBhL0tjb25maWcNCj4gPiArKysgYi9LY29uZmlnDQo+ID4gQEAgLTExNCw2
ICsxMTQsMTIgQEAgY29uZmlnIEtFUk5FTF82XzEyDQo+ID4gIAlib29sICJLZXJuZWwgNi4xMi54
LWNpcCINCj4gPiAgCWRlcGVuZHMgb24gIVRBUkdFVF9JV0cyMEQNCj4gPg0KPiA+ICtjb25maWcg
Tk9fS0VSTkVMDQo+ID4gKwlib29sICJEbyBub3QgaW5zdGFsbCBrZXJuZWwgdG8gaW1hZ2UiDQo+
ID4gKwloZWxwDQo+ID4gKyAgICAgICAgICBUaGlzIGRvZXMgbm90IGJ1aWxkIHRoZSBrZXJuZWwg
b3IgaW5zdGFsbCBpdCBvbiByb290ZnMuDQo+ID4gKyAgICAgICAgICBUaGlzIGNhbiBiZSB1c2Vk
IHdoZW4gY3JlYXRpbmcgaW1hZ2VzIGZvciBrZXJuZWwgdGVzdGluZy4NCj4gDQo+ICIuLi5mb3Ig
dGVzdGluZyBrZXJuZWxzIHRoYXQgYXJlIGJ1aWx0IHNlcGFyYXRlbHksIGUuZy4gdmlhIEtlcm5s
ZUNJIi4NCj4gDQoNCkkgd2lsbCB1cGRhdGUgaGVscCwgdGhhbmsuDQoNCj4gSmFuDQo+IA0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


