Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F2CF6491
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 08:24:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.49403.1727684648989657341
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Sep 2024 01:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Ny6D1PLF;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727684640;x=1728894240;bh=VQ3cqyy1fZbo5LnS9DEsSOh/kGCGnpJIVVUnZj3
	jk8g=;b=Ny6D1PLFe8ZBskox7QoO5n6SE0odcyUz57vaL4l7TTuaz9L2kux2ypCvdmPZtZ3laN21A
	iaxfe3WrM5sfjPyq7ljYjJWMSmHDn/yQVQO4ml1fQp8RrWS2ccGf3+M2rGwcEKSOz5OuFZ1nsOnCr
	JKXi699e1RQ7RtjXrnB4odBF1c3e3n5fJ0G1bULToENM41dBu+L57blbDXjitnfEP4l+n6pKO1qzF
	Bz4kYntlrhBiezpPvxObSbJTXrSMiFTmFmXgTFXr5pciOyS7u9DEcb/OivaDQte2ZFIun5x3nosiA
	h0zLU9ruD0EUxDvPwXBu6SYwg+tCtKwe2gPc+foj4w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 48U8O00g3669190; Mon, 30 Sep 2024 17:24:00 +0900
X-Iguazu-Qid: 2rWgO3UeHxZfxbDg8d
X-Iguazu-QSIG: v=2; s=0; t=1727684639; q=2rWgO3UeHxZfxbDg8d; m=yD5IrxjNmI+xnFPWhxI1dtxSaeBtNsuEA+RHNFyIYQY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 48U8Nw3H3122074
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:23:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua/9ZzZqRuH/94XMtURBJT0kKUMBEQ36eEK5pS8kuzTrzNK8VvuElIYl4/+iqI4qoVy+wyQ6sloUUvTVlY7vd+fMaeK1x5877dI4Q8BIzNvtLyh8oh7Z6eeh+p2u0yqxnLhq1XVPLDJSreQ5x/0F7kMYF+C8d1LTxH0VYaU9V+b18yo37FxPpvPdFk9gGH4MqD3VA7vFh5JaCaA7mOxO+K7HAn8ak+q0wzGKxNlEAz71+XJSOANzyobGdE2uOth0QFDt6P6E9gPNCntjiWmWfI02X1Bcbxn3RqPT90MiPoPBJGUCCP5yF6qdCnLkdSyHenXXx4JzbtMIDpJXrR7mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChKsXfEcqlH378V0yl8UqpHaCK4hc/ABIxRy/s7rZhE=;
 b=vrhEurJxQZTpsmi3yi5putTRaPCU2In33hqs9krXuwu5d/m53gbhm9qLUm1QXrj5RwfDDmnFDTY7ne5g2r5nDFSwao6jaWX1+yAG4rhLy6QhbfYTxakzS7wQQ0JjYWxv1PTqo3JiW3fzy7fzqn6paN06aO3wAXJaJsobCHmUml6Im4nWjupBiM6A6ic0GczftAW6RRV3kPb/1E7RZQMW8MEtaeqGo2iq3LiewnEEi1ttQRXs3Q8lXTCYghZOz37EPCnIbvHQpm4giAjZUhngjWXWYakTYxzhLDqS8OOpRpN6NG0fBDK+khPz5hHMJhHjqdKoOp/GigwxQKpxZdc02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] 6.1.107-cip release
Thread-Topic: [cip-dev] 6.1.107-cip release
Thread-Index: AQHbAC8HGLdMoGolZEifqGcS0srzXbJLSTFAgB5HCwCABpF3cA==
Date: Mon, 30 Sep 2024 08:23:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391DC2B457500DBB286A07B92762@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
 <OS0PR01MB6388BD6095E8058C2675DC39929E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OS3PR01MB642161E95C3634866218A284D76A2@OS3PR01MB6421.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB642161E95C3634866218A284D76A2@OS3PR01MB6421.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OSCPR01MB12501:EE_
x-ms-office365-filtering-correlation-id: 40dc9e1b-ac09-4938-8678-08dce12939d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QnV0S3Y3MzdSbWF4VUtoWWFsSjJKZDE1ZUh1Rk90NlY4TVBhN3pNVnlr?=
 =?iso-2022-jp?B?RU1VblgxUXZIWlNTb0ZpUHMwVGJSaC9EblJDMHVKT1B2dHFGekdQUHBn?=
 =?iso-2022-jp?B?cnVKa0hLZ2lsRDNzYmptaENjMysvOSswbkdMRmxQSlpVUkNXTGM1SERw?=
 =?iso-2022-jp?B?R0pQWXd2Njh5alBiZEJFbFJ0UTdjSWNHWTJ4c1RCKzhsRndtNEVVNzFt?=
 =?iso-2022-jp?B?WG14bVJtNVBiM3pyS2VQd0VlRE1hQlVvNU1VQThDWVpBby9FcjNKbEhU?=
 =?iso-2022-jp?B?S1dFRWdjeUhiUlhLakl2VWsxYnh0Y3crQmFVRlc4b3I5VDkydmhxcGdS?=
 =?iso-2022-jp?B?V09seHd3NXhZNGk5ekVOU3F3bytyRXZkUUE2aXhDU2daelB3eUlmN3hN?=
 =?iso-2022-jp?B?Zyt6RzJ4YXdRUDVxMG1TOWRTRXJYVlJaZy9OZ1dscFpmU0E5WVdYK2ty?=
 =?iso-2022-jp?B?NGhhaVd4V1I1ODVFTHRTd3JGLzdqQmdRb05OUUlobnFLd1hacnQrN3Fm?=
 =?iso-2022-jp?B?cUcvSHNraEJYN1lIZkw3K2NmaXlUdjVTWjRvVUkxcldVZmZmQ0U1alRo?=
 =?iso-2022-jp?B?SkFrbzdaZ3ljSTcwRUxoZW9wYk9rU2pnY1BIWUtGODdEUWQxOTFRYlBa?=
 =?iso-2022-jp?B?Tno5RFV6SzM4YmJzU3AyVlBJc2piY290QjVUbjdMdFM5Y0JuQXFuT0pB?=
 =?iso-2022-jp?B?d0VDZzZpcnJ3SGtqcnVUMzBaeFE2REpCeE5aNGlBSXl5Y3IwTk1vcTJV?=
 =?iso-2022-jp?B?aDNKUW5ZSXBNY1hhYTNWb2tJcGNrL0JicU1EQmFGV2Jkd0VHeWV5b1R0?=
 =?iso-2022-jp?B?TzZVMkYxL3h6ZE1mcHhvVXZJWFhvbWtnTFhMMDc5WEZOV3VLNnB6aExT?=
 =?iso-2022-jp?B?OWRIZHBHbEViZExVNUFiQlNqNklOc0t1VTRSdzMrcS9BU0JXOWRZcjhR?=
 =?iso-2022-jp?B?TEsydFBqVVlWVWZnbVozeHo3N21KaFZvZ1NnUFRQTTNnMys3bzYrUHJG?=
 =?iso-2022-jp?B?aFE3OHpld0hOanBRMzJ1SEJva2NCQmFlTFlVM2RGc3RlVWFxZEN1MmVr?=
 =?iso-2022-jp?B?aXFnZUhwaldpejlTdE5HdE1ZUHRRSWpnNndKUGJsSk45MVJMclFST1Fr?=
 =?iso-2022-jp?B?ckxZcGZvckVkQXdaY2t1S0lEV3o3OFZpZFRhSTJUL0FMdWpwMlM5ZnJ6?=
 =?iso-2022-jp?B?cjhYOTFYTlZHSmF5blNHUWpIYmdCMDNPaUZUYjF1TER6YlIzbUFVcWd6?=
 =?iso-2022-jp?B?VTBhY0FDb0xWS2xIUEFJM1FIUDBLbjZFU0ZIcTJNRkdkREhVNWJqdXdR?=
 =?iso-2022-jp?B?Vk45UExlaitmb0s2TUdOVkF4MHVCVzBNQnZGMG9ybDVtaFVQSUhidk5F?=
 =?iso-2022-jp?B?bHdzc25pRkk3aGllKzRtUEJjamJwSHJjTHRrYjQxL0JMcnN0ZW85dTdP?=
 =?iso-2022-jp?B?WWN2eTNYa01GNU9oMHJkSEg0dlg3dVhoTURlNFhhSzRHMXpDZDBtRWw4?=
 =?iso-2022-jp?B?UmRWZGpVS1RzMjVKVm0wM1dTaTIzeDZHMGxmeGxaeUM5eUpHZk5xS2hI?=
 =?iso-2022-jp?B?RkZkSDJmNXRzeDNmaFlFRytQSm5sczcvWFRxL0tFOWd1VlhEM0hkUW9i?=
 =?iso-2022-jp?B?b2VtV1BsZHp0T2pOeVU3SGh6Yyt2UWhQaGhkbDZDblMrS1F3RGxqenlq?=
 =?iso-2022-jp?B?a1lDNkVuQklncnJpcVg0QnVsUDZyUVpkRGx2LzM4SzQvdDhheTIwdW0y?=
 =?iso-2022-jp?B?SDdrT0xHUHQ3WnE0c2NBSEVxR1JabzNaNWUrclR3VGk2dlpNRzlSUmxI?=
 =?iso-2022-jp?B?UUtOMUJiVFk5M3ljOEkwaTBTWkhrNVh6dGc0UGcveHNldGFNSjROQWo0?=
 =?iso-2022-jp?B?T25BbXh3SVprTkhYTmM1VEZkUS8wSGFRbjZrZFRiejRQdHhCTHdYclNT?=
 =?iso-2022-jp?B?Nmdjb2VrOGlRU2VOV1o3WGpweU9FNW1oL29LaEFxaHVpRWtCbGpWWVNi?=
 =?iso-2022-jp?B?WXVhZU1DSFRKMU1uQ1JBM3hUUzg1aQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SG1CZDBMQVIwQTd5Mjdsa0k1QjdYVW5DKy9hNTM4UXhaRmE1dTdvYXJ6?=
 =?iso-2022-jp?B?MUZaZ0krUTJNU1JKeVNOaVlIRnZSUzRLN0xWb3ZtRlF0TnlxNUREckg2?=
 =?iso-2022-jp?B?blZ4T3MvR0VIZCtNanVwUXlUdndFSUFiVUdTNXVsQ01tRGlJb1FZeXdL?=
 =?iso-2022-jp?B?T1I5ZThWc08wNVIxU3phOTUyUHJoSGdSNGtSckdXdEgvbmcySlVUdXV5?=
 =?iso-2022-jp?B?S1lxQTdVaXdmYml1MENVY2JOR3Z4Rm5Kb1pyTDZFUmlRRm1waUpUanNO?=
 =?iso-2022-jp?B?UkJXY0ptTHk3bHB2ek9RM3JSd2swVVQxU0F0TEFYRWsxdStueVc2WE0w?=
 =?iso-2022-jp?B?d2ZGdFJpYTJZOVFTOFduNUQvcWcrWEFoK1pITzNmbEdVNnlscEtCTFpJ?=
 =?iso-2022-jp?B?dWlzOVR5ZUsyYUdPZ0UvV2NiUWV2aWc2d3J0OEVKUStabGo2b1lrcmV4?=
 =?iso-2022-jp?B?eFM0UEZtU3hQWEIrVmtlb1N5THZ6d3V4TEE5Y05wT0J3NTF6anhQdGFT?=
 =?iso-2022-jp?B?bmdMbFlzeFhXbnN5MlBKWHhaSlhKYzdlVTNUK0xEcGhvbnE0WHM4aXhh?=
 =?iso-2022-jp?B?c2NVNTZjU0c5Ym9ndDdDZWpJMjZRTkxTTXVmVUJJSFNMaHpKMUtyZExD?=
 =?iso-2022-jp?B?c1hXU0hZbzd3SWlhZTNIQmNTTjR4V2pObU5JQTBlQ0h2Q28rSTZJTmQv?=
 =?iso-2022-jp?B?eXJoRUEzTHh2ZmUxR2l4dU03RXR3SW5KbEFLNkVCMTEvL29FcXRvc2tG?=
 =?iso-2022-jp?B?Z1pQQlN1QWFGUkFya0hJZXFwZGZOcFpoOHlqNTl6cUF3cWFuSlJTcFJN?=
 =?iso-2022-jp?B?TE9TbU9DSVdPdmkyZkxrVmd0blN2U2N2UEo0WXpZUTFGaVVSWnRETDU4?=
 =?iso-2022-jp?B?M05NdnNWRmNLVjZWNTRpdlg0SFRMTlZ3WU5kQUFyRlltV3RJQmRtTjVi?=
 =?iso-2022-jp?B?WVpkQjllZklJMDBnNnNTNDFrTXhRelBkRFNJK1M0NXREL2g3VFcwcGxY?=
 =?iso-2022-jp?B?L2ZxRkpONG1ENE9HdHdIazQ4TzV4cWgwT05VcHovbGlnL3libjJOYVd4?=
 =?iso-2022-jp?B?dGpPZ3h4V2JvTFlCY0t4OFB6aXhnaUtlNHFablRuaU5laXZZL0FYZlhW?=
 =?iso-2022-jp?B?NDBVQUdIZ1ZOY0dTTGZ5ME5yRHFmVXFvRk9SQ1h5UkorOC81QUFYaTFi?=
 =?iso-2022-jp?B?WkpMcnU4dmxsVkFoWEFKQURZTmJ0dEdsSFBBT2FGUFV4cGZMSUxjVHBH?=
 =?iso-2022-jp?B?MUFOUXVHMWxkanBYblNsREZneWoyVnJXZVBGcnV5K2t6NDJTbmwvOU5E?=
 =?iso-2022-jp?B?OFVHaEdkQnJGZzZTeVl0STI5amdFK1lCZWdiUEh3MnUyOCtyVzZFYVdI?=
 =?iso-2022-jp?B?THBUM1pHNW5RZkpBUFk3MUZ0SVJFakNEUUF3SUMyRXlZc2JOOXVYSzRn?=
 =?iso-2022-jp?B?TFBqVzJWUHNsdHZVZWltZHN3R0t4Vm01di9rSFpETStNR1dzSFVJb0pO?=
 =?iso-2022-jp?B?UEs3NjAwcUlsYjFZbTA0V3BYWDUwNkxMdVh3Yy9PcysvOU5IaTdQeGZm?=
 =?iso-2022-jp?B?WUpCbE1yUDJTanEyZlR6NVNxNTVUQlpuQkNSUTMxVHlFbmlUVGlzSWQr?=
 =?iso-2022-jp?B?MTJKODFQYWpuNmRaQmdZVjQ2NjVPU0g2TncyM1YyY1VFMjdLV3puV2o0?=
 =?iso-2022-jp?B?SlRxcDAwR3ZNbzEyajNyUzNxd09NY3NrVDJzd2l3MjgyVjMyWGNidVZh?=
 =?iso-2022-jp?B?Qi9sVnoxcDVjUlpleGFVZnNZZEx0RGc5WFg5YnNWMDhKY3pISUR4UGhj?=
 =?iso-2022-jp?B?MmIyK28vVFEyRktwa1hPRzFDMlIyS2xiVHZQVkZlQWh5TUN0aHBoelpq?=
 =?iso-2022-jp?B?dnl1K2s2MEh4WE0rZHdncUpuT3h5akFhU0s4S3pVeXArOVJiTGRhSk9l?=
 =?iso-2022-jp?B?ZS8weEFEQjY3cDZZdmpkMU1NQmRzUmdvOHlpaHdPS3JCZU54d1dwaGFB?=
 =?iso-2022-jp?B?MXdXQTg5K3dpNGZ2dm93MTRwUHlWNFBMRE1DMjdEOVJoZ2ZVcjlSRFI0?=
 =?iso-2022-jp?B?YWFvMjBzcTRtSkNoZzBYdUhGZEpsYmQyM28vRW9QMnUrRUtPRSt4NSsy?=
 =?iso-2022-jp?B?UUljVGhSM1JwK09hQXc0Y1huZ2M4QUlJTHhHU0tzTWN5RE4xZkNVQXNP?=
 =?iso-2022-jp?B?Q0MvY3dVc3o1cXNyUW9NWTVTSHhQQ0VHQStMNUF6a3puUlpNR3l2K3lX?=
 =?iso-2022-jp?B?Z0lkMzJJd2FJWU1OMGM0bmFlZTR6SzF1ZlNUTE5TOVVlUDZVMFVlYTI2?=
 =?iso-2022-jp?B?NTk4bHBqZ0ZmNXkwK29veEZleXNRQzhOS3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dc9e1b-ac09-4938-8678-08dce12939d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:23:55.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pu48tG8ck1rNqGrCXMgH64J0M6KqoHiJ6FSyFKtc3gTeKdUVAzROc9gnn7K2l/mPNRUuWCAhMb26YeUlMRFNycicEKwIrtg2VhN3cAbWKjG+MU1eG2PHq0mH2y9aLEV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 08:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16935

Hi Koguchi-san,

> I recently noticed that 6.1.y-cip has dropped the support or testing on
> Beaglebone.
> I'd like to know the reason and I hope CIP supports Beaglebone again shor=
tly.

6.1. y-cip's BBB configuration would not boot, so CI was stopped by the Tes=
t team
until they could figure out the cause.
I am currently working on resolving this issue.
  https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/ma=
ster/trees/linux-6.1.y-cip.yml?ref_type=3Dheads#L217

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Takuo Koguchi
> Sent: Thursday, September 26, 2024 12:58 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: Re: [cip-dev] 6.1.107-cip release
>=20
> Hi Iwamatsu-san, and CIP folks,
>=20
> I recently noticed that 6.1.y-cip has dropped the support or testing on
> Beaglebone.
> I'd like to know the reason and I hope CIP supports Beaglebone again shor=
tly.
>=20
> Best regards,
>=20
> Takuo Koguchi
> Hitachi, Ltd.
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Nobuhiro Iwamatsu
> > Sent: Saturday, September 7, 2024 6:49 AM
> > To: pavel@denx.de; cip-dev@lists.cip-project.org
> > Subject: [!]Re: [cip-dev] 6.1.107-cip release
> >
> > Hi Pavel,
> >
> > > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -=
cip.
> >
> > v5.10.224-rt116 was released today.
> > I will be releasing a -cip based on v5.10.224 for this.
> >
> > > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release =
myself?
> >
> > Thank you for your suggestion.
> > I will worki on the 6.10.y-cip release at the same time as I work on
> > the 5.10.y-cip release.
> >
> > Best regards,
> >   Nobuhiro
> >
> > > -----Original Message-----
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: Friday, September 6, 2024 4:33 PM
> > > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""=
#D#I#T!{#O#S#T=1B(B)
> > > <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> > > Subject: 6.1.107-cip release
> > >
> > > Hi!
> > >
> > > I took a look at -rt releases, and...
> > >
> > > 4.19 -- no suitable -rt
> > >
> > > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -=
cip.
> > >
> > > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release =
myself?
> > >
> > > Thanks and best regards,
> > > 								Pavel
> > > --
> > > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > Germany



