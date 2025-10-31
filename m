Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56CCCF9F0
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 01:38:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.5346.1761874721715439544
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 18:38:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=q2b0DDDv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1761874707;x=1763084307;bh=887NEP/Z9o/owHMrt9t+Lsj/PGGIQmWV98ht+
	u6tu1g=;b=q2b0DDDvIB4m/rV6/ez/fZ6UrYoO88NFLuIxite8zLhdy9nvjc6ky4AspcJPXgDXlQa
	xo5Kx3PHah/3YIQUFBTigw1iaY296mbmcQvvvuCmcpcULmCq249rcNrNI+11GGDxpNkhXB6bvpu/A
	ccnLvBq6c7O9pBxB/QWyJDu3H/pFJ42NM4eX6124nNtAKegZLh9ExW2irF27I/dc0Wdp2Vmlj8b5I
	K3Ah6/ngwPDaTFjQ9lQYJN3N94vgc6vNCq4HhX5OFN8/sYAqQkIZkr9PoisPm97NSng8D0QzOewgi
	fwAQdeet54RwWcfq4i562kG5OtVeyiWcAaHhO0IoEh9g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59V1cRgK828112; Fri, 31 Oct 2025 10:38:27 +0900
X-Iguazu-Qid: 2rWhqFKk8SrzBSkjyi
X-Iguazu-QSIG: v=2; s=0; t=1761874706; q=2rWhqFKk8SrzBSkjyi; m=Ow/rZrop81nEgPd9ucIIqnYOXGepX/lxTUI1JXQdB2s=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cyNst2R5Dz4vyk; Fri, 31 Oct 2025 10:38:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL76+zjVF3cdxxGvhusuCkgTdx1YSnNZdsH1Kr6bTXc4gCPpGL4TMk4t3LdRQk4kG1J+zccawABtnoUwHzcUZs6hq86bd1M3S6AuSOEvvL2+D0c//DbscY6W46a+OgRn1nP9DBhKKRGIsmKmqo1cAtMtLdixLhLfAwAJD3mmmTp9wdyfKQUPRJk2nBmg0j72hXCf1EiCEhxp9UUwaTVL96iru6svS739ZcgCHQH8PCYC7sxgCwUKMahmfdwyku5BhXt3WUcDD0KdR4BW7pOGLPJY46kz8g+mwG7qasH3siWMGQ1GdsXCoy2TODkBEFrVgRunJwb9nu/pV3vxL48nrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJnakbtjvst+xw9C8A390LZg6zYvaXRt0G+RRCF66e8=;
 b=TmqCc4Dd8+ZyyH5x7kR25UdT1HviSFCo51TWi086p4CpTZTsltP409VZjkWfDwWXRTXA+ogMzvRhKVwUkgp+D1oQzBP5nUEQX99h6tckqU5qQSPd32B5Bhw6Wn+imylk9jkCWMeshJHLKku+6VMoLPtMcDOSan4jv7s4kF4Qs6x0JXm0fHV8vJubK7CnNXPC8Rbt0HRLGOrS0qYp+qZ3DWpRLKACcODO4JF6kW9J0GqWRgI9AG/z5VdgGFXBTEaKC6hXDpReSzwy0E29Uf9v/A419Df8flenicLrvuVxnspTtxVbtKvw6Q/+y87EXM0q1KfiwTcdkBDXAivFPSLD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 0/1] Add RZ/V2H ICU support
Thread-Topic: [PATCH 6.1.y-cip 0/1] Add RZ/V2H ICU support
Thread-Index: AQHcSXUmMjhbsM5NpkyRBUIAla2elrTbeonw
Date: Fri, 31 Oct 2025 01:38:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481830DACCAC346A9313F61FCDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251030081349.47403-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251030081349.47403-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7819:EE_
x-ms-office365-filtering-correlation-id: 7e9c739d-d285-4607-869d-08de181e2dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UmtPU2JYelhLZThqSUNZS21YVHgvY1prbEtJdXlyQmtOVzBSa09MRnZK?=
 =?iso-2022-jp?B?Z1ArejBtUXB0YkZsbEEzSEZHYVhnVVAydEdBcklHbEZXd0RtY3RObysw?=
 =?iso-2022-jp?B?cnZLNEJHTTZEanZJT2pndG5RU1pjVTdtL0ZVVnVyZWNlVUpYMnE5d1VW?=
 =?iso-2022-jp?B?ZE5SRGNMcHJSOGRJdCt4V2xZL0dQL1lKem5kaHk1VU9sV0tqQmdJZXRm?=
 =?iso-2022-jp?B?UGpQSzZyUlgwRjVmOE5DNUExQ1gxVTY5bFlTYlhkbm8rR1JOVGRkYjlE?=
 =?iso-2022-jp?B?NjRQT3BBU3NsME5hVHRMV1Z3Q2JjeHFKSXRtS2IzWTBQR0dOMTZrWkNv?=
 =?iso-2022-jp?B?a3FPcU1OcXNkbnBvb3ZOSkVrRnl2ZnRWSVVDSGp2TFpUd1lKbG5BOGZO?=
 =?iso-2022-jp?B?V1hpSmFKdFl2THdUQWloNk53TnVqckUyM1g3TC8rTEtOS0dIRStxZWVI?=
 =?iso-2022-jp?B?MEJmZnZsVXdZNzFPVzVaaGFEWTRsd3piK3FYalZ0aUVxeDhIbzhML2F3?=
 =?iso-2022-jp?B?S29KUTNObGw5c0lueGVCRXJrRklZYlJNZDFhVUJTK1BZWlVITlJDMWNx?=
 =?iso-2022-jp?B?ZHlWVnBVcG1Bdjc5Sk94MVBsYWU0RkpYTlJhZzdZTkdraG9aTXFoMXZk?=
 =?iso-2022-jp?B?Wkg3MEhrK1JjSjhEV1RuNHVUZWFvaUFDOElqdlcvamFESHdUc0dPb3hn?=
 =?iso-2022-jp?B?YXFlVUM2cGh1U1NNNEMwa1hXL290M09sN2FDVEFkU2UwVFU1YW1NWXlr?=
 =?iso-2022-jp?B?azJUaDdYUlJ1NkhjRU1tdlJsZVdXelhqemMxQUpRb01OR04yY1JHMERE?=
 =?iso-2022-jp?B?REN1TUpZbWx2RUYxNlltekYyaS93ZE05L09Ra0YwQUVhTHF0R1pibFF6?=
 =?iso-2022-jp?B?NkJBYUozZVFXZEFUV2RlaCtrdVdCREN6K1FITEFLZlA4R2Y3czJUQksz?=
 =?iso-2022-jp?B?RXZDN3orK0JQUTBlOXdXV2tsVjRyRzZPenIyVXkvTkEveVlIRGlCTUNN?=
 =?iso-2022-jp?B?NVJ4dGs4YTdXWHJMMkp3OFNhKzdvQlV6TlAyVHNBelA1a3dRWDhCdlNl?=
 =?iso-2022-jp?B?N1RSWHlramhuOUtOWEN0YWIwVlZWOU9EZm15bm9KclRsZzFtUjVCNXA5?=
 =?iso-2022-jp?B?UDdHbjFQQ3NWYWV0V2ZxTnFQQnhCV0hDRGlYbjZKeHdWdUJLQjNJdmdM?=
 =?iso-2022-jp?B?U2JXelNHQVNpQTk4dU51WGZrZ0l1WWg3YVA3TkN1YXV5WEV5VkZIOXZP?=
 =?iso-2022-jp?B?QjgxR1p0c0Nuc1BHMUYxQnprZnNta0FURHlxYnR0REY2dGNvU0hTMG82?=
 =?iso-2022-jp?B?RFZQenUxcmVpeTAyZlRuZ1Zod3d4ZjhhelF5Z2p1MUU4b2lBN04zR0Fv?=
 =?iso-2022-jp?B?S2hCSTlNOXA2OTJRK014bHpwenZrazdkNUZraVNCY3FoV0did0ZCUW1F?=
 =?iso-2022-jp?B?L1owTDJqOE55NmNpUHQzQXJUanVsV3ltd0dGb2ZTaDNHMUFxMEhCS1p3?=
 =?iso-2022-jp?B?dlcrS3VKeGhYZVE2NFk0Vks2WDA5RGxRMFhvbmh4SmlmbnlpS2cwM3Zk?=
 =?iso-2022-jp?B?STFhMUhxQkhHSGFIY1FZbDA1WGpIbC90Rlg5NzZpTFVhR3Z4UmJ5bEZ4?=
 =?iso-2022-jp?B?d01MOC9sQ3lwYkc0UTV2WUFOOWpmZ3FDakZaYlpkVDQxWHBRU1VuTE9o?=
 =?iso-2022-jp?B?a2JPZ2x4UENrYVRKMGFobVRWVWdqN0xKZ0RNbThCV3JIcU8vbnVkbFh5?=
 =?iso-2022-jp?B?UkhBUVhoMWtqejNkYytpbS82cXVmTkNtZjJZUnREZ3YxMDhMSmJ0MXY4?=
 =?iso-2022-jp?B?Zlh4RWw3QVFLdGppS3MzeVBjMUdPVDBPRmxlTm5KOVRKV3ZjaHAwOEcr?=
 =?iso-2022-jp?B?RlZPc2xPZDNTaVFrVytZdCtLakFVQW9mTkc3RUJ6Tjlma1lGZDlzdStD?=
 =?iso-2022-jp?B?eXV6R1p5Mm5OV0xoSGJkNDhud3NzRDJFanpQZ1h3RXJYanNLNmFWVmNQ?=
 =?iso-2022-jp?B?NW1NalkzR0h3NDhKa3lrYjh0aC9KQ25wb21xTVNDb3ExT2lKdmMyTmlX?=
 =?iso-2022-jp?B?TjAyZi9TTzVTYzA4N3JneStBWUNKQWxWUDhGQmQ5eFRHc0NBYXpqVXNx?=
 =?iso-2022-jp?B?QVVnaUVyVHlUU0RlMEthRmQxNFBNUEFCREFYdStPMW41MTIzN2JMVmNT?=
 =?iso-2022-jp?B?cFR4aUlHeW9vSHhuRmdGSWxSU2NmUXhQ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0F1TStqV0hzWTN4WW4vSHhsdUlJWkVFRVdFK25nUCt6djF5MndSQzFZ?=
 =?iso-2022-jp?B?cE4wTWYzaDRnNkJCNGg4SVU1R21mVU9mQjMxN3ZkckNKTkp6T3lmajBW?=
 =?iso-2022-jp?B?Wkt0UkR6K2NnRXZ3QkFVR3NQN0Nmci9HYlRZM2xoVW91Rk5TNEI2Z3Jp?=
 =?iso-2022-jp?B?UmZpZzFqTE1CNTM2NDl5OWcyR2xBR1RzSTR2VC9tUkd3WklaVVgweGxh?=
 =?iso-2022-jp?B?SVVDMmZTQkw5cmtEZWt1THlaZmh6NTRIUFFNbU8vVnJRVngzN2xvRU9K?=
 =?iso-2022-jp?B?eTIxaUtWb0pBQmpVUVdqSUVmekllbjV6eXhzdlJXRUoveHE4cGFiZEpz?=
 =?iso-2022-jp?B?Nm5oVXFxa2h4czYvNFZLTEpJYmVoSEhFc0NyV09INW5aK0tpSGtxbVpw?=
 =?iso-2022-jp?B?TUJJTWNpWDRZdDhQWTNWejlmTUppNStnWno1alNwQlNsK09mQWI1OUtJ?=
 =?iso-2022-jp?B?T0VGMUFRUGZxcWV0Vkdmdjh1NEszdHFTTm9vdnRLbk1ObnJic0hhdEdV?=
 =?iso-2022-jp?B?cXhCR091TU5mcnd4YU0wYVUyTTBuaHJQVTFSc1pYcURPem1ZMng0YlNT?=
 =?iso-2022-jp?B?UkNUQjNlU2RXcmZuY2s1MEh3b21rNktBd29TYzFrWTJoQlpoTmJUeVc5?=
 =?iso-2022-jp?B?bGN6aURUNGlOdmE0MzhLTCs0L0s0WmlJa2w2UUJ1cmNMaW9LNENmSjBt?=
 =?iso-2022-jp?B?cklhcFJDUUp4NlZaVGlWZkdrV0pCQ0l5L1BPQW0wMnpESkdOZ2k3M0Ru?=
 =?iso-2022-jp?B?Vk9TYzc4dktwY1JxSTkvb0pPTG9CWEJ4aWFocmVFdVFLazdzTm50cStP?=
 =?iso-2022-jp?B?YnpuaThkbzRiOEVlY2tSRnQ2ZzZLQlVJMFp4eW14WVo5eVlEQTFaZU9N?=
 =?iso-2022-jp?B?NVYyTkFDamdzd2Q1RTFzT2FRWHVoTlZlMXM0aTA2QnJkL3gxRnNtdFdk?=
 =?iso-2022-jp?B?bkhNQ1JDWWhZSENqMDQzamoveHpDQVpsSHA0cTFiVFpVZlpBS3p5cTlX?=
 =?iso-2022-jp?B?SnFZUlIzUVpWZWlxbitGQU1vSHZoelBoOFJkL2dxbEhRMWNvS2s2WW5F?=
 =?iso-2022-jp?B?ckpqSStNVjlmVVYxdlQyd2xDR3ptY21MZEkxb0JFdkNxVFRleW1vLzRs?=
 =?iso-2022-jp?B?bTh6bm80YitVMm92RVlja0ZVS25GT1V5L2tyYm8zdDlIR2poc29vaFhI?=
 =?iso-2022-jp?B?SGdaYnJCa1EvWUJDU1NLUzN2eHh0Znl6Q0M5Vk82UUVYRUN4djU4amdL?=
 =?iso-2022-jp?B?RnF0aXZEem5McVpZTG1QbFVuMjhkTEdBS0RlZnBndlhNT1QxYmRpNDJi?=
 =?iso-2022-jp?B?WjFZMEpsd1dhb2N3d2p6RDBoK1FMUnFzNzF4TjRzVGFSenJ1QmsvdjQx?=
 =?iso-2022-jp?B?dSt5SmovZ1lYcVc2U1NHOEFxc0J1d1N2dzJ1L3R5ZkhsdXdFb3VtTWdh?=
 =?iso-2022-jp?B?S1lTMEYyTUtWcjBCSzB4MkJPQjF4d0xkM1drZFB5VER2blpVUTRndnZD?=
 =?iso-2022-jp?B?YzNJampoUDJuZ01zQmZJSkJSek83Nnd4bVBFU1VKa084bHNNUmNxUHJT?=
 =?iso-2022-jp?B?SXNWREx3UXUrTDdyVjJNU2V4eTBaTzlvMk9oOEVyRjFoSU9HRU90QnpE?=
 =?iso-2022-jp?B?ZXZ4T3lZejRQK3JuemFWbGtkcHBOSVRaK20xTUtSMkxZMXR4aFNjaGZC?=
 =?iso-2022-jp?B?ZU5nSUoyWi9FSHVYREF5Z1ZRaDMwaUFpTDkxaE5DeGttT05WUENwSGJm?=
 =?iso-2022-jp?B?WU9UaGt5VWNrd2hMS05ZVHFyenJtWkFPTzZ6OUpzTDQ4Vm04QkZFR2lV?=
 =?iso-2022-jp?B?SXpxaUNrMm1qaSt5UXA1NllLU0ZtcXRqTm9jTmRad2dhK3JNNmc2d1Vx?=
 =?iso-2022-jp?B?Ty9DSkxEZDgyeUcwSWhuczdsbHZVYUw5Qk1lZnVOZjI0cE56WCt6cU5P?=
 =?iso-2022-jp?B?MzdSOFVwUHlKbFEzRGdJdllyYWhFWStNVUpsMEJDMzJMbGx4dG1uTmlP?=
 =?iso-2022-jp?B?VlIwZFlmc25IcDdMUkN3MVF1RXRQTDhsRkZiYWY3VXRjL0RRVXl5Tkc2?=
 =?iso-2022-jp?B?Qk1sTGtLa05xRk55UE5XVllKZFdwZ1VjT1EzZUlKZnFYcVo5SEtiTzlv?=
 =?iso-2022-jp?B?b2IzVWozdDZJbHRWc0RIdEM2d0N6WnJHNFlZTjl1QlNMZWpDbWlYOEVN?=
 =?iso-2022-jp?B?RXVvRm53UE5CcW9DZmhDMFY0eEVRcXF4YXBFRUJGSGdPMnRMMVdDZHpC?=
 =?iso-2022-jp?B?TUtMQVNUMUUxbXUwd1ZNTVR1dVpaYXlXYW1UZlVPbmR3T2pINUQ4N1Av?=
 =?iso-2022-jp?B?R2M1eUh4TThXd3hVQlNkS0R1UFcwTzVyVXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9c739d-d285-4607-869d-08de181e2dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 01:38:22.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGfoQzBQgzVhlLOKuQEAXBhlNecouXtVH175XV7mHYhqIIYAs35H6S1FZWSPeBAmZkvBZpl3vx6aaqqD4UnDmC/WuNHNoyzcHw6VU0Wh3XZr7ShuDiRFFY9wGT6NgtP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Oct 2025 01:38:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20287

Hi,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, October 30, 2025 5:14 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.1.y-cip 0/1] Add RZ/V2H ICU support
>=20
> Hi,
>=20
> This series adds the ICU dts node for the Renesas RZ/V2H SoC, to the
> linux-6.1.y-cip kernel.
>=20
> The ICU driver and its dependencies are already present in the 6.1.y-cip =
branch,
> having been included earlier as part of the RZ/G3E backporting work.
>=20
> For reference, see the related commits:
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3Db142b3b91d5235096ee472472c7a5690d1d8d6ef
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3D46696984ffc837b920d05ef5a1e07588af08e603
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3D4a97e4b6845fa6e577ee707b7530dc77f3a38568
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3Dcc2cb4eb962467d04c319620a00677fef5f3c915
> [5]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3D30c326b3db178a302bfb34f3689db33c5e51306f
> [6]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.1.y-cip&id=3D0b0e21f2a5c1a1fcedcf7b82b0543c0e45c90b47
>=20
> The patch was cherry-picked from mainline kernel.
>=20
> Best regards,
> Ovidiu
>=20
> Fabrizio Castro (1):
>   arm64: dts: renesas: r9a09g057: Add ICU node
>=20
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90
> ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)

Thanks for your patch.
Looks good to me. I can applyt this patch if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro



