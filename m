Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF1CA1010
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 23:36:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.27268.1756942566857189488
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 16:36:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=h1gzg4Y0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756942545;x=1758152145;bh=zWilXHo8xP1KPwEWn0SMeAmnu6uNYe5oXxAk4
	7rh2OQ=;b=h1gzg4Y0Huf/jVa3ToQ8gaFuz7/qSt9ylatk1TKAz3+cKRqIFGIR14OQXbeFmOCvl3Q
	TRQSCg4KIXmK2CdIPF6WqXFIc1RSldqb8EcNj3sCGXl/WIVMaGKAOzStINLJLGIjTz+GXdGlziDr+
	r7bBRVYCUPwxdPaBO7dOZq6zPNUm+N4QNaTSv2rlaW1YuIDgnxWmGBLwy2kg7bWPphRCpWVJRmwz/
	ZFCAdMS2F+WKJGuTIlAYQKKU6+qtj0j3T3gMXa8ER2d2gIk+GjDr1GjkVMm/Lbgc4gG6zxdKlx7se
	05V7S5deJ7zpniUBfpMg8cT2tIqNcFwfUQnM9X1WpMAw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 583NZiud714700; Thu, 4 Sep 2025 08:35:44 +0900
X-Iguazu-Qid: 2yAaIqknpHchtVg31t
X-Iguazu-QSIG: v=2; s=0; t=1756942544; q=2yAaIqknpHchtVg31t; m=m4vMSbqn5uHCKjsGPUxREVUeAvuAsDS0I/wQz6HmCh8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cHJrb31NhzyPp; Thu,  4 Sep 2025 08:35:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCRhxJWgPHeHvnGYw6FlhBBVQRB2pAZxLk1/Y5xpttjDcNZCnfUpinU0twXeUkQy8XcdM+qziPVzro99SEyUKg1WSH5XtQIAyXSvvfI1GDQM8iXhNOEe+Hpj+rzE83mi8geXkQlwaChZlT0r7CnTMZU349ACNspnoi9zyk31+kPCIkOLXW5FefXWwouk1otVRzp+/LJW5093F5LmG5uLrOgJTxiz3hqSZ8Pb6wEZUGQVMRaWwh1F/UWp8pQLPw8Gs1E3Uq9IbrEIktPitfEuJ4H3dmfrETfN3pnqSERAco/pMCo0D7/n8iDwx/HBhLhHquhsqlPr5gcRPV9lGkW45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWilXHo8xP1KPwEWn0SMeAmnu6uNYe5oXxAk47rh2OQ=;
 b=XevVAKxfiZl9lYdpZVvo1mtcprDvZjRn8Opk3K17t8JzRjjObbCYX2Dk6xpMNgmjmUMv/ZUppFtND0JbQMfmSHEvT2QNA3/LeZdp/n7u8RBY6RHnrn9AigEtnUqf30sgkWMWncG/jkNGYImPC4aQs3Rd+HPSW2FJkwrXWNiiaLqV723gy/kCGn3lYbKNie5YVE5g+Suu/oS3kKAedd8uErSJqYXdNpifwzLAbiXl8yuRlWttLyw7u9z70+40NbGIPHdboqlqWLw8UW4GqZGyelwZX5JDl+N/7dcjxOvGV1FmXoRQaU7AdZ0YZb/V5e2wbDZhIa1EJ1VkpyuwNZtkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <kazunori.kobayashi@miraclelinux.com>,
        <cip-dev@lists.cip-project.org>, <pavel@denx.de>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
Thread-Topic: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
Thread-Index: AQHcEFPVDCEPpTJ9Sku2x4Bs+FptH7SBGBUAgACIIQCAAJThIA==
Date: Wed, 3 Sep 2025 23:35:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808B325D8779D9C48834C57CD01A@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
 <165242228.250961.1756910318537@webmail.strato.de>
In-Reply-To: <165242228.250961.1756910318537@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYRPR01MB13741:EE_
x-ms-office365-filtering-correlation-id: 06b726df-7d7c-4af2-2cf3-08ddeb429783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U3NWdjAvTlJROFFEVWVLL0E4amY4S3hkZmMxdTMwbDZZNDVnMnZFRGVOeWl0?=
 =?utf-8?B?NlVQQlplZHp2UDBKM0dsMXBFelRVYlVEVWhWTmI3WTBCNmJvVXdHQU0zOUJN?=
 =?utf-8?B?aWIwazdVVlRJMkMxa2wwNTlrS0hZcjJOcnFsN0ZXTU9uU3ZOenRsWlZNaFNC?=
 =?utf-8?B?ek1Wam1DZzlCaXEyK21haWdOYW9zamZJakRZOGxPTjNnelU2NWYxTXhyVTZE?=
 =?utf-8?B?QnU0NXorNyt1a1VWRm9rYkUxd3JRbEd1S1NJaUhTZTQ0V3BZdkhYMkJ4NlZT?=
 =?utf-8?B?N1QyclFWMXZvM3VhQkpGM2pPOG1NcmFsb2RJSTBpQVJOUHdQMG5GQy9jN0p1?=
 =?utf-8?B?RS84akxibkNrTjFWWDlKeVhxTkJKRWMybE53bmlnZVZaL0hOSndKZVUrY2NK?=
 =?utf-8?B?VDJmSmNhWmd5WGwrQUZzbEk5NDlaamh4Ti9xTHdMMW1LcnF2Z2hCOVF1UU82?=
 =?utf-8?B?Q0pOODFiQ3p4QkFFb2pVeUoxdjlZL0JSc3J6NE5LWlh5K2tGd3N5aWJMZlRz?=
 =?utf-8?B?bms0ekE0cnZHbHdnMlg1eWNaRGhSWE9raW5VK0VhaE9KRjUwczNHQlZIbEZX?=
 =?utf-8?B?MzNMWWFyYSt3eDUyVjErRk5xTm05VllKRkh6Z0FWek90NUpEUnQremxWeTRo?=
 =?utf-8?B?R0FKY0l1T1p5M2RUNThPeDE0Q2JjUjEvUCs5aTExZFA4QjBCSXl3b0RRNDBj?=
 =?utf-8?B?L1MwNHNQU3RUOWJxSGtlbkZ0WWNNZmxIL3FsMGhmZTdBWllsaHk1RUpSdlIr?=
 =?utf-8?B?dUFiTnRDcFUyTDl5STBMTHcvc1d0SC9tMGlNTUxaWDFWL24vT3hxOUQvbG5Y?=
 =?utf-8?B?Z3BtdEFMSEhYcjZGZjYxUitHc2ViVXV4eUlxdkxEMVlpZWI0Qk9jRFgrUVhi?=
 =?utf-8?B?azRKSDNsV3JmNkYydTdnTS9xZ1huMjBaS1lUZysvVmJHZi9GN2lGaGVReTFn?=
 =?utf-8?B?NGc3OFdKR1JHSmZyRVh4bEQvVW1sUE95RVNUVGNHNllvT1J1SFZtNGxSSEhM?=
 =?utf-8?B?d0FNb2trVzRIbTh0enRtL05vSG93T1NIRGtDdHNJUkoraWZqeVhUcjJ3UFQ5?=
 =?utf-8?B?UjllYTY0emVUVEZmM2VDaEtBTnlvMnBFcFpaZ2NCSllFRzFPWG5Cb01PeEFN?=
 =?utf-8?B?Zk5GWStnYkJwQ1NyRjZWVzFPdEJOT3JBNmJGN3RHNVgwbHZZWGVVbW9RMlVo?=
 =?utf-8?B?Z0lzRkhEZ3Baa1RWQVpNVEhoQVZQMWwvOC9nMzNCQURDdC9hRWs0REkwKzNT?=
 =?utf-8?B?bFpSMXZhVW1MN2ptUDZrYVAxa1IwMENGUmNNYnlqbU9ETGVYeTBNTWFKY1pv?=
 =?utf-8?B?eWhiNnhPOW92MEN6djEzQzA1RUp5UmdzQmlVTkFQUnFFRDRpcUZIZVNzNVhB?=
 =?utf-8?B?OGtoSnp1N0x6RFJvZ1h4YmZWQzFwdm9US3pLN0VueGF4RlNoVGdmQ1NMcWM1?=
 =?utf-8?B?WlFabWZYdG1TdUtIR0dkNEVuYk91Z1lPSE94YnUwd1pkRDFTTWs2Ykh2b05T?=
 =?utf-8?B?WFFERDBJdHp4SnBRb3l0TGt1WnU4akZEclFGdnRCYkF5eStzNGNXQkFUbTd6?=
 =?utf-8?B?Uzh2WUthR1hZWHFUTVNVZWF1SkszUSszMUZBR255NnZUMHNxblJkWjhDYWVh?=
 =?utf-8?B?NTlSOWdBRW0xRFdwRStFWnlOdVdwTmNWeVhnUVZZZEtXSDBDYnRJVFlhNU1I?=
 =?utf-8?B?andGWTIrZlBheGVpUkxUMExhOWZPeUhmUkdyNWJ4N052eGhJOHJLRzJqQ00v?=
 =?utf-8?B?cmhJS2JUT3o4THJnREtmOGFTK1QvY0o1SW9jMWJHS3ZnYnhUYVI5V0ZIeHVG?=
 =?utf-8?B?ZHR5YmlxK2ZTZmM3a1ovQi9kczVyTnc0aGQ1KzZZMkxobThUMmNMcDQ4bUJm?=
 =?utf-8?B?TDlSQU5ZRHAya0pGNno1bDRsVTlvY0k4K0FUeHhXQk1Pa3FoVStPRlg1S1BY?=
 =?utf-8?B?WSt1dG1mbXRkbk9aVUtob1E0bjJyOW9iRFJmOGs0emVtWFc2STEvaVVDYmx4?=
 =?utf-8?Q?6Hir4TI8Xpp/Bv5eikUoS4hWaeAzkY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1FzR085R09JMWZhUVNRVVhORWM1cU14U3lxMDdVVXpHdlo1cXFxL3BMSFRx?=
 =?utf-8?B?b0xBZ3JPcUlvZ1N2RHVWVHRuZTZkMFlET2RMUFowVzEvVVJzS2tkTXU1RUlO?=
 =?utf-8?B?bDIrUjhsU2JZVkRHQlhZYkhYNThjRFk5ZGhtaWRja0dWR2hNSWdobE9HWEo3?=
 =?utf-8?B?aGxDK1FpSTZSdGFBNVg2U25QUG4xZFdhU1ZrN1RqSkFybTJWci9nSWlwaklk?=
 =?utf-8?B?b2FHSjdlRE51VWpoUmE2ZHhMMkZPd0s5YmtUalY0VHBiZEdPY2dnbWxCZU1X?=
 =?utf-8?B?b2oxMnl1dGpDc3FuQ3RsRGF2UDE1RjFraitFcXJqUkthdGp1bzk3eFgrbDlB?=
 =?utf-8?B?ZHdBQnV4MVlxR1NWaDBHUTMyaEgxcXoxdjlaS2xEbHhoNkhpMmVMb2ZtektT?=
 =?utf-8?B?S29zUWlFS2VQYnh1djdoNmt4cXRYUzEyblVjWCtDbG9IREQyK1p2M21lditw?=
 =?utf-8?B?TTJKNWtQRnhhZDZlOUlBdmhyb3M3M2VOY1VGcFJNUkFvOEl4MjNwWXlMamJq?=
 =?utf-8?B?My95U0w5dS9rRTZjZTFZZStxcUhMTjhZL1pPTFVzL3JrRjYxb0M1MS9LUFVJ?=
 =?utf-8?B?Z2NuaysyOEtJQU8vdFRCRmNkK29RdUU1WjJ4WlhDU241M0tiRk1Yc09ybE9T?=
 =?utf-8?B?MXRRdzRpNExDMENLeXY1b2dQWmJsdEwzM3l3VHZiV3J2cHFlNEZPSkU4S2RS?=
 =?utf-8?B?RGJWU0Mwb0F6eWRVQmtMcjZLYXhiNC93aExsZTRaYUpnVUxoVVdRall6MWlo?=
 =?utf-8?B?NXEvTi9mZ1Y3RDNvd29yMkI4MnB3RGwvYm8zcmxVcm5iR2ljZUFsOW1wdXlj?=
 =?utf-8?B?L2ZwaXNxbmt4UjY2VnJKN1dWNk1sZktkL3ZRWWpONEpVbWwwMGlLTGZZaXZq?=
 =?utf-8?B?TjVzaWRwTkhHNFk0WWl6eFBkd09tMnpvM0NIZ1JTK2d4WTBwY3lsaU41Y0li?=
 =?utf-8?B?RDUyRUYvS3YxQm9ZUlk3TEhzZ2U1MU9BclBKMExSZHFUMnlpaERzdTUrVG5k?=
 =?utf-8?B?TURWYjFTaVRwVzh0RzhVTEdvSzhoTWxOeENDOW41TjlZb3JrVC9meEM3d2dH?=
 =?utf-8?B?NGRrWkhTWW41T1hhOXY3YmJGNE9hYVN0bGxQSXI1a3NQcDJhUm9wK2RwTUxs?=
 =?utf-8?B?bzRzcW5UNmJ2eGF3cWlIVC9tWDFSZi9SNUFOQTA2NUJtWVZwQklEYmFJNzNM?=
 =?utf-8?B?cy8yY2RoQ0l5UWtmSlhNbVdGOXl0VEdXZ25kQ3BxWnRXOFhjS1NaQzUxYTFa?=
 =?utf-8?B?UFNoaTdYQnBqRk9XMmxKQ2x0MWlwMmRsdDBtL0NsbjZhVU5ScFNWbm4rdVNu?=
 =?utf-8?B?RmlsZ05NaFZubURNdkRiWUVJS3liZWRIMG9sRTN4NXFBdjkrNFZlMUVPTFBm?=
 =?utf-8?B?aUxIY1B3UWQ5WFl0WmdTTHJ1YkNZa1orcm0zd0VwS2Y1YXQ2V2JUdWdybnor?=
 =?utf-8?B?NXBzbnc2TysyUWdkdjVScGRXaUdwVTVvRXl6MzAybkZwUk1sTUc2ZEc3U2NB?=
 =?utf-8?B?T0Zpc2Z3WFVYcXVyOGxvamlZS1NaanNCRGVMWkJPMWRaYno3d0luQXA5eDZY?=
 =?utf-8?B?K3d1am9QZjdKVnRvWTFkK0tTekp2Mk8zTmZtT2FSejRPZ1pqWFFlOVVTY0FG?=
 =?utf-8?B?Z0llQ3Z1aU1YRi9DZWt1ZmpUK0tBcEtPRVhZbWNyamp6NTU5ZTdKWkkwaTg2?=
 =?utf-8?B?dmRRRUlDaGhxN2lPUCt2OVA0b0RPRXhtcHlyOWdyY0lkVFFvam5rNElEd2k2?=
 =?utf-8?B?UVJqcms0c2QwOEdxci9SQU91cHlmTDdBdW1xN0pQdDNLTWRMOUhGYjJXUC9x?=
 =?utf-8?B?aWo1eE9zNGI5cXpvRGxMZmNjMlNGaFNVcHNUQmlYRTJPL2FXQ2J2Q2pQVDht?=
 =?utf-8?B?WWVmZE56dFFTVTJRTVdmYnpuYXVreVVpVlR3VDhNR0g2K3hvci9qeWVTeVdC?=
 =?utf-8?B?TUVISS9UYlJ5anZCbk9QS1JUYThhUG4yUkV3L1pOUjlwWmprUWdCVjZoSlEv?=
 =?utf-8?B?aGdmT1VmNDlLRW5RQmNweE9rTlJRY2pkaEpzNmc3cUlGbTR2bU1UdG9udUU1?=
 =?utf-8?B?RFlmUkZlRStjQ3RBY2dKZFNRQ1Z6enpYbm5rZy9nSndJTERobUo2TUw3eEYw?=
 =?utf-8?B?KzBiMXBLbDVDQ2pkNWFzcFNmalNEWlhzN3BxZTNjMUNCTTJvYVgxZ3pyVmkv?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b726df-7d7c-4af2-2cf3-08ddeb429783
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 23:35:39.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vys6oS232z0/xiu64IBDAfPU9QsHq/mxXD/LJyKw71SHr9+HA1H5ZM7zIVcd+gP+taDIQFFHz7bRSAGCQl1t8C5baDU4Qa/hz/l8e++BbTRs7uGk836FKmwRvdCSgndt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13741
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 23:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20001

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxyaWNoIEhlY2h0
IDx1bGlAZnBvbmQuZXU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDMsIDIwMjUgMTE6
MzkgUE0NCj4gVG86IGthenVub3JpLmtvYmF5YXNoaUBtaXJhY2xlbGludXguY29tOyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsNCj4gcGF2ZWxAZGVueC5kZTsgamFuLmtpc3prYUBzaWVt
ZW5zLmNvbTsgbWFzYW1pLmljaGlrYXdhQGN5YmVydHJ1c3QuY28uanA7DQo+IGNocmlzLnBhdGVy
c29uMkByZW5lc2FzLmNvbTsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTv
vKnvvLTvvKPil4vvvKMNCj4g77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9z
aGliYT4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbQU5OT1VOQ0VdIFJlbGVhc2UgdjQuMTku
MzI1LWNpcDEyMw0KPiANCj4gDQo+ID4gT24gMDkvMDMvMjAyNSA4OjMxIEFNIENFU1QgS2F6dW5v
cmkgS29iYXlhc2hpIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPg0KPiBJIHJhbiBpbnRvIHRo
ZSBmb2xsb3dpbmcgY29tcGlsYXRpb24gZXJyb3Igd2l0aMKgb21hcDJwbHVzX2RlZmNvbmZpZyBh
cHBsaWVkIGluDQo+IHRoaXMga2VybmVsIHZlcnNpb24uDQo+ID4gfA0KPiAvYnVpbGRib3QvYnVp
bGRfZGFpbHlfZW1saW51eF9hbTMzNXhldm1za19sYXRlc3RfZGV2L2J1aWxkL2J1aWxkX2FtMw0K
PiA+IHwNCj4gMzV4LWV2bXNrX2VtbGludXhfY29yZS1pbWFnZS13ZXN0b24vdG1wLWdsaWJjL3dv
cmstc2hhcmVkL2FtMzM1eC1ldg0KPiBtDQo+ID4gfCBzay9rZXJuZWwtc291cmNlL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vb21hcDNpc3AvaXNwY2NkYy5jOiBJbg0KPiA+IHwgZnVuY3Rpb24gJ2Nj
ZGNfbHNjX2NvbmZpZyc6IHwNCj4gPiB8DQo+IC9idWlsZGJvdC9idWlsZF9kYWlseV9lbWxpbnV4
X2FtMzM1eGV2bXNrX2xhdGVzdF9kZXYvYnVpbGQvYnVpbGRfYW0zDQo+ID4gfA0KPiAzNXgtZXZt
c2tfZW1saW51eF9jb3JlLWltYWdlLXdlc3Rvbi90bXAtZ2xpYmMvd29yay1zaGFyZWQvYW0zMzV4
LWV2DQo+IG0NCj4gPiB8IHNrL2tlcm5lbC1zb3VyY2UvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9v
bWFwM2lzcC9pc3BjY2RjLmM6NDUyOjM6DQo+ID4gfCBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24gJ2RtYV9zeW5jX3NndGFibGVfZm9yX2NwdSc7DQo+ID4gfCBkaWQgeW91
IG1lYW4gJ2RtYV9zeW5jX3NpbmdsZV9mb3JfY3B1Jz8NCj4gPiB8IFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXSB8DQo+ID4gfCBkbWFfc3luY19zZ3RhYmxlX2Zvcl9jcHUo
aXNwLT5kZXYsICZyZXEtPnRhYmxlLnNndCwgfA0KPiA+IHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+IHwgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUgfCBDQw0KPiBbTV0NCj4gPiB8IGRyaXZlcnMv
bWVkaWEvcmMva2V5bWFwcy9yYy1hdmVybWVkaWEtYTE2ZC5vIHwNCj4gPiB8DQo+IC9idWlsZGJv
dC9idWlsZF9kYWlseV9lbWxpbnV4X2FtMzM1eGV2bXNrX2xhdGVzdF9kZXYvYnVpbGQvYnVpbGRf
YW0zDQo+ID4gfA0KPiAzNXgtZXZtc2tfZW1saW51eF9jb3JlLWltYWdlLXdlc3Rvbi90bXAtZ2xp
YmMvd29yay1zaGFyZWQvYW0zMzV4LWV2DQo+IG0NCj4gPiB8IHNrL2tlcm5lbC1zb3VyY2UvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9vbWFwM2lzcC9pc3BjY2RjLmM6NDYxOjM6DQo+ID4gfCBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24NCj4gPiB8ICdkbWFfc3luY19zZ3Rh
YmxlX2Zvcl9kZXZpY2UnOyBkaWQgeW91IG1lYW4NCj4gPiB8ICdkbWFfc3luY19zaW5nbGVfZm9y
X2RldmljZSc/DQo+ID4gfCBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0g
fA0KPiA+IHwgZG1hX3N5bmNfc2d0YWJsZV9mb3JfZGV2aWNlKGlzcC0+ZGV2LCAmcmVxLT50YWJs
ZS5zZ3QsIHwNCj4gPiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fiB8IGRtYV9zeW5jX3Np
bmdsZV9mb3JfZGV2aWNlDQo+ID4gSXQgc2VlbXMgY2F1c2VkIGJ5IHRoZSBmb2xsb3dpbmcgY2hh
bmdlLg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVsL2xpbnV4
LWNpcC8tL2NvbW1pdC8zNDgzZGI5OTcNCj4gPiBkNDkxYmE3ODk1N2ViMDQ3NDNmNmJiMmVjYzI0
MmFhIFRoaXMgY2hhbmdlIHNlZW1zIG1lcmdlZCBmcm9tIHRoZQ0KPiA1LjQNCj4gPiBiYXNlZCBr
ZXJuZWwsIGJ1dCBzb21lIG90aGVyIGRlcGVuZGVuY2llcyB3b3VsZCBhbHNvIGJlIG5lZWRlZCB0
byBwYXNzDQo+IHRoZSBjb21waWxhdGlvbi4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4N
Cj4gDQo+IExvb2tzIGxpa2UgaXQncyBtaXNzaW5nICJkbWEtbWFwcGluZzogYWRkIGdlbmVyaWMg
aGVscGVycyBmb3IgbWFwcGluZyBzZ3RhYmxlDQo+IG9iamVjdHMiLiBJIHB1c2hlZCBhIGJhY2tw
b3J0IHRvIHRoZSByYyB0cmVlDQo+IChodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdC9sb2cvP2g9bGluDQo+IHV4LTQuMTkueS1z
dC1yYyksIHBsZWFzZSBjaGVjayBpZiBpdCB3b3Jrcy4NCj4gDQo+IEkgaGF2ZSBhbHNvIGFkZGVk
IG9tYXAycGx1c19kZWZjb25maWcgdG8gbXkgbG9jYWwgYnVpbGQgY29uZmlncy4NCj4gDQoNCkFu
b3RoZXIgYXBwcm9hY2ggaXMgdG8gYnVpbGQgdGhlIGFyY2hpdGVjdHVyZSdzIGRlZmNvbmZpZyAo
YWxpYXNlZCBhcyBtdWx0aV92N19kZWZjb25maWcgZm9yIGFybSkNCmFsb25nIHdpdGggYWxseWVz
Y29uZmlnIGFuZCBhbGxtb2Rjb25maWcuIFRoaXMgc2hvdWxkIHJlc29sdmUgbW9zdCBidWlsZCBl
cnJvcnMgb24gYXJtaGYoZGViaWFuKSBkZXZpY2VzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVo
aXJvDQo=


