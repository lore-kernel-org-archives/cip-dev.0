Return-Path: <takuo.koguchi.sw@hitachi.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4436CCFA15
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 03:58:23 +0000 (UTC)
Received: from esa.hc514-86.ap.iphmx.com (esa.hc514-86.ap.iphmx.com [139.138.45.249])
 by mx.groups.io with SMTP id smtpd.web10.34987.1727323100160142372
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 20:58:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hitachi.com header.s=hitachi-com-20240118 header.b=h5ajwGVp;
 spf=pass (domain: hitachi.com, ip: 139.138.45.249, mailfrom: takuo.koguchi.sw@hitachi.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hitachi.com; i=@hitachi.com; q=dns/txt;
  s=hitachi-com-20240118; t=1727323100;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EZMC9fKnwtiV+rkP3JY6JUaTTJ/yZXiBIui0/JCApec=;
  b=h5ajwGVpTSOpK2plZD8jjpZCgyehC/jAvWHIlQxfn4qG6vQ4uNE0YGM6
   iJoHWoe80Z2mQo+6QC5lqv68Tz1UFhhCQiwaU6pIeH8sNdbudTZiL3CuG
   xxN3DdGGb1h5E4Bj7r1Dh3gcanLwxcumaGwqKTgSCzvnYMz+TXeFyuqD+
   c=;
X-CSE-ConnectionGUID: NLfLP1ASTXCNs1RuZFdqIw==
X-CSE-MsgGUID: pw9KaXkvRZOeDwPnRvs6fw==
X-IronPort-AV: E=Sophos;i="6.10,259,1719878400"; 
   d="scan'208";a="323695542"
Received: from mail12.maildeliv.hitachi.co.jp (HELO mail12.hitachi.co.jp) ([133.145.228.59])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2024 03:58:18 +0000
Received: from mlsv5.hitachi.co.jp (unknown [133.145.228.43])
	by mail12.hitachi.co.jp (Postfix) with ESMTP id 6BD371E002A;
	Thu, 26 Sep 2024 12:58:18 +0900 (JST)
Received: from mfgw10.hitachi.co.jp (unknown [133.144.234.179])
	by mlsv5.hitachi.co.jp (Postfix) with ESMTP id 5EEC4404E67;
	Thu, 26 Sep 2024 12:58:18 +0900 (JST)
Received: from mrelays02.hybrid.go365.ext.hitachi.co.jp ([133.145.227.158])
	by mfgw10.hitachi.co.jp with ESMTP
	id tfdys9ts0Bjm0tfdysHDDG; Thu, 26 Sep 2024 12:58:18 +0900
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazlp17011030.outbound.protection.outlook.com [40.93.73.30])
	by mrelays02.hybrid.go365.ext.hitachi.co.jp (Postfix) with ESMTPS id 3BC7D10063AF;
	Thu, 26 Sep 2024 12:58:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxkYijJkSPwiGs7g+Pwy06dqxfsJKb63GJwC2R/bJfTRQKXLQTTudIF+elS+cs3krKO1qtPThYijcHSbP/yt1kSU1QI6qW593WAq8a9tLXDrP7QPoFndz2inQSS+r2rfssbu/AR042z7hZ2HLZsu47M9eW5bg9rbofJROkcYdpxFva1mM/laqytbHqTWUfF+J1NaxzhXWt8ZG6pn6R2S+Euqtr7c9z0btnP4wnaSymGe7a7/4fRFwjmn5KhDnZKVsIlzJecFLROqe75X4DiCuDiyeMCj/QPcn+3tHGsOb5B8+3r8CP+8qP4jMYFpJe7BQT2pDkPYRN+UmKCrbf/1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meN5mvvtMvW3lMuEnO4DKeYxhxspiZ2TcOM/Qzoi1fI=;
 b=Vxgda5C571oFWafFPuxxp/5t2zOmDH+1vjzHpNeB6Bd9sqr7YVdQfnMfy1Gwc9PbrdrVFHsvcmcDb2/HUuE+TQffAl8Pnvvnp8Krpm92wcqhA74n4xGUz17ENB9iwIe+iBefnHwk7fSpI2zA6ONsFkT5UUQk0WGzFnazxhBgROEMV361gIAJW38XxCX4d3KGTNK1D/entn9GDNPs8tda5Jm7NNrSFuv12iTi/96W89wmAkfNxtdDbogPsS9jooIkEE/J7RhXseEZ2MiNRQ/OF/occuO3obJ96hhPg5NGqDdq4zIPmuistsaCZEAqxB79XMtho5FP0hKVfL7IHLyR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from OS3PR01MB6421.jpnprd01.prod.outlook.com (2603:1096:604:e6::8)
 by OSCPR01MB13411.jpnprd01.prod.outlook.com (2603:1096:604:32d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 03:58:17 +0000
Received: from OS3PR01MB6421.jpnprd01.prod.outlook.com
 ([fe80::93cd:2e53:c3a:71d9]) by OS3PR01MB6421.jpnprd01.prod.outlook.com
 ([fe80::93cd:2e53:c3a:71d9%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:58:17 +0000
From: =?iso-2022-jp?B?GyRCPi44fUJ2SVcbKEIgLyBLT0dVQ0hJGyRCISQbKEJUQUtVTw==?=
	<takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: RE: 6.1.107-cip release
Thread-Topic: 6.1.107-cip release
Thread-Index: AQHbAKasYG9NvJPhkkyAvZxZy+Ym7LJpjTeA
Date: Thu, 26 Sep 2024 03:58:10 +0000
Deferred-Delivery: Thu, 26 Sep 2024 03:58:10 +0000
Message-ID: 
 <OS3PR01MB642161E95C3634866218A284D76A2@OS3PR01MB6421.jpnprd01.prod.outlook.com>
References: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
 <OS0PR01MB6388BD6095E8058C2675DC39929E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388BD6095E8058C2675DC39929E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6421:EE_|OSCPR01MB13411:EE_
x-ms-office365-filtering-correlation-id: 8158c954-0caf-4659-2506-08dcdddf7401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OGlOUWgxbVpRVzJPU205M3hPZzZmOXJxRFVpQlRRQWppYXA2VDMxT1pv?=
 =?iso-2022-jp?B?YlJQdzIrWTNmcnF5aFp3UEpadDAwczNCQjlBaU1hYjBOYXk3dGpmMDc2?=
 =?iso-2022-jp?B?eU1mL21QZHVHL2dBK2lHUXB1R1ZOMWYybjFNbExKWGczbE4wRXBzZ2tx?=
 =?iso-2022-jp?B?ZUZiVHRQY3IxUmhyWmN4LzljZ2NsRjZRVDhPZW1HR2R6ajJHSWczTmtQ?=
 =?iso-2022-jp?B?Y0pFNWNaVzJJd3RuaVdoL1NFOW1iMzN6TmUzZ1EzSHdJSHNCSm1kbWkv?=
 =?iso-2022-jp?B?ZkxSbHNkR2M2VUcwY05sT3I2VGpTMkk3ZWdpRWdveGU1M0cydFRRc0tn?=
 =?iso-2022-jp?B?cm5KUTFGQ2pHY0pkamZOYWhNc2lWRUtJTitOTzlFam9wS1AwcjdIbEww?=
 =?iso-2022-jp?B?K0Q2MlV0UklpN0MrZWJKU2JJTWdDZThjdXBjMDU3Q2I1Uno4WFdwOGZu?=
 =?iso-2022-jp?B?Wm9NZndvRDFIOUQ1M2swblNZdWx5SGFqV015T1ZYS2wrMTgwMVlqL1d2?=
 =?iso-2022-jp?B?c1dXakZzVHNSVlJKeCt3QUV3NUlxNWZsYjQzZHEzM2hscGlJZHRxWTJU?=
 =?iso-2022-jp?B?dkU5cTd1SFJMalBsa3FHRWJHU2dXUzNEQmZSMVVtbjJZSGFwSXAxdmw5?=
 =?iso-2022-jp?B?UmZyZlk5MkxlTEQ5RjRBcXFJZXJqTktTOG1aTGRQSXh0YXFtaHd0TGh4?=
 =?iso-2022-jp?B?TXdiMzloWEp3L2xzYmFSTlF6NzdPL1dwYVJpMVhrNllxQUxGT1BCd0Ru?=
 =?iso-2022-jp?B?ZkRpWG53SFRlQU9XcEE4TzllNjg5cGhYeHJNcVBtRkJmTHQ5d3NJWnNO?=
 =?iso-2022-jp?B?RjFOZHhqSUNKWjJ6N0tSUXhkQlg3SFYraFM0MVMxbWxBMmdKckdPQm4v?=
 =?iso-2022-jp?B?WWZWbG9GMlZqWENRUm9JZ0l4OEFRYlphb1VjdVRXRWZ3SStIejZKTlFQ?=
 =?iso-2022-jp?B?M3EzaTdPVlZhdzhiWk0wMS9LcHBQbk5remFqd2JMZ29jWmllK3R1RGo1?=
 =?iso-2022-jp?B?UG1TckdsZndVTDZib3dnenV6OGN2eWNCSlVaczJRdEFlc2JxMk96S3g3?=
 =?iso-2022-jp?B?Vnpxak5vUUdhNklyeGp2T25FbHJvVElRQ0FWSzk5eStzU3B0VkpWRjcv?=
 =?iso-2022-jp?B?L0laczVmZUE1M21nR2JIUmhnaHMvcVlGMXhTaDd5VThCMVI5M2cySmNM?=
 =?iso-2022-jp?B?NUNrTzJVNkFQK2dVYitJT1NmTTJodm8rVlVZT1hlU2N1ZFdKSHRmTjRD?=
 =?iso-2022-jp?B?QWhHNUhrTWVHSkYrLzRCMFAvcEs0dGl1czhEbkNKaEFnazdKVHlyWEVv?=
 =?iso-2022-jp?B?eUJsQ2M1NVhkQThSOTRBWWNlUWJ6ZnE0eEkweUIxckJoTitlK2x4bXpN?=
 =?iso-2022-jp?B?M3F2RGNZRUNNL0pDaDl0TGZoL1V5OHVnUndTYjVZeENFU0czWXM3WElR?=
 =?iso-2022-jp?B?bFBjNGFQcDhoTkl2azVHMTZNYzl0Z3p5K29Pb3dmemFLNDlNcEtwcUhT?=
 =?iso-2022-jp?B?SStydGlVZS9tZmVJRDUrVEZLRE5rd3dqOU1OL2JZdEdYNk5DTmRNUlFU?=
 =?iso-2022-jp?B?UkF5WWVrVzFzQVYyWWhsSlFKcElmeEdzMDZKaWZub0ErRGFKTXQ3VS9L?=
 =?iso-2022-jp?B?RW1xaWRZQ1UzNHd3UHhqNFdMS0RYMlNBSFU5RzIvaklPckJNZVFhcFNR?=
 =?iso-2022-jp?B?ZlZWdXBFNlI3MDNUaGxyVmJDZk9wNjJscFdKQm54Q2VFTk5RbVhnMXY5?=
 =?iso-2022-jp?B?c3d4VS9ILzVtRUcwclByKy9WVU5yV0VURUJ4dC9WZi9WbzVzOEJkRzFp?=
 =?iso-2022-jp?B?SUtJaVRNTVNKZVV5TGVEaFlQRXc4djRzMzVXOXNobUFiV0dGUDQ2RWwz?=
 =?iso-2022-jp?B?WVBhcktlNy9CZzRkYWhaREFPdlY2STN4QkRKZU1Kd0lUV1pmOHJNOGhU?=
 =?iso-2022-jp?B?Wm9VUjVabGJuUVNENEZvek5yZ3VkUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6421.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V3V6b1YzcDNRUzI5aisvV2lLZ0JKUllsVVVaU1djTDdyMFR0Zi8wNGFS?=
 =?iso-2022-jp?B?dkxHY1JiT255ZjN6aXcvV3UyMFd1YlVVSHRLOW1mbWpKKy9qTmc0SnJ6?=
 =?iso-2022-jp?B?MlVlQXpUcU11OUF6QUc4Vk1jeVFlRkhwc3YzZC9NVkllOUxRMXRyelpx?=
 =?iso-2022-jp?B?OFlaQUpCcmw0V2dORUhlQVhJclpraStGU1ZEVk5Nam9SUUp1aUFDWnlS?=
 =?iso-2022-jp?B?ZWx0ZFM5TlFJOUU1dDdWbzVhK0pKVm4yNzc4SjJGV29xNDBQcmFHUkc3?=
 =?iso-2022-jp?B?dGdiZHNOZDYzQjhyZ3EvTGRrUldsRTdrc3lxL3dXZzV2MXhnSkFQVHlV?=
 =?iso-2022-jp?B?dWE5OXprckVwUzZwVnRRTSthNEFhdGp5cThkTWJWNDBzOXBuWUVqdlRD?=
 =?iso-2022-jp?B?V2pCckI1K3hkYzVlY3Q0eGtrRkhMT3NRMWZGeXlGVWRnN0E0bkRjYy9O?=
 =?iso-2022-jp?B?ZXpQWERrcjE3Uk5zVFppM2ovblRONlMxTC9rUlRQV2F6UUNHSkJHNGQ1?=
 =?iso-2022-jp?B?NG1JQ3ZtRFkwWU5tZFpCUkFjcDF3VmZZZW1RaXowUlVIWTRRU2VGM01m?=
 =?iso-2022-jp?B?Q2JmY3RpSDZPWTNEOW9YYVJ2czkxeVNNM3NZMk1DNE5peUVCZy82QWxF?=
 =?iso-2022-jp?B?UWZBMkhFQVBNb0sybFVLUjY4Q2U0VkFMQVFPTzFLamp5M0g1YXVSUFds?=
 =?iso-2022-jp?B?dCtvUWQ3QkxVMHJPWmFuSjVWMnJWS1ZzL3BjK0hJTU1uUjJFb3BnV3Mz?=
 =?iso-2022-jp?B?TWRsM2FhM1d4TkpHclhqTzFvTzFibzI2a2g0bGZnVWNPMWFMdXNCMk5V?=
 =?iso-2022-jp?B?a081RVFOWTZJSEMxaWdKZ0JkbjlqeCtIQ1BXelpPNS9iU3FyUjJtVWZH?=
 =?iso-2022-jp?B?ZWdoMituaDZVV2NYVTJkWmlseXlrWDJ0NGFVZE5GT3ZoVDE5U1RBVm9F?=
 =?iso-2022-jp?B?NFBsYkJ4S2hKeVk2alkxZVZybk41U0NWa1ZmUjFoZ1FXQlNiYi9IK3Q3?=
 =?iso-2022-jp?B?MXZZR25vZFNJRitsSlF2RHB3eEhWVWVxRy91NTlxQTRIVW9UMTVqMXMw?=
 =?iso-2022-jp?B?OWozQWhRaUZoZGxNMFhnTFpUV1FZbEtlWEU2eEdTNG9nTE9WUzNZQU51?=
 =?iso-2022-jp?B?L1o1bGpTT2V4TzNLR2FXMlJ2SWlmcldCVTVVWmRIOGIrVW5nQ0xLK3Jr?=
 =?iso-2022-jp?B?Z0M3dU9oWlN5Q2lBZFdaQnFKanNoeVp2VTBRMmR1azZFR2FWNmtmY3Fx?=
 =?iso-2022-jp?B?VGdsWW5welZ6bEdnbzE0WnBwWDllT0EwbEFYdU5JZ251WWFmN01wMEta?=
 =?iso-2022-jp?B?YjlmM3ZrUnRwSVNYTG9Vb2FvTjcyVENWNXZKbFRSSGJEZEF3RVluaEk0?=
 =?iso-2022-jp?B?dk91cXljeEVSTDFKWXJxK3lrUGtITC9XcE9EenZ5KytnQnVtZ2ZJeVZk?=
 =?iso-2022-jp?B?TXgyMVJQR3MxSXc4OWFvUXRlTk1QVVM0Y29CYTlsd2NNN2ZvdXJ6Ym1G?=
 =?iso-2022-jp?B?QmUxdjZoNmpGZFFKeDcyOHZVQWE3QjVsSTByL25TNm9zRW5HOW1icW96?=
 =?iso-2022-jp?B?dUFDVEhhVXRzU1JDV3VUcXlXMmFYVXZFRTEzMEs1WVhqcno1cDFIcmdm?=
 =?iso-2022-jp?B?ZlRhOGJZWUw5Q1FIa1RnZ0U2M2krbzJqdjZmY2htdWZZWWx6Wml4djF5?=
 =?iso-2022-jp?B?M3ZsUXZXYkpkZ2pOYmxsOEx2TElTa0kvWDZnSTZUYjN0S082bjh1VE51?=
 =?iso-2022-jp?B?eEpQZVRtZVRHT291YWpxT3Yybnp1MC9jU205NGVBbVRxd1pvczFNRmYx?=
 =?iso-2022-jp?B?Q0ZwWEM4N0d6QzVoc3VRSTZrTmZ5ZCsweUx2Tm40VElPeHl2V1ViVmtH?=
 =?iso-2022-jp?B?RTIzMkJEVWlKUXN5ZTBEbTNBUENndnl5U3g5WWpyUGM0dWN6aTlHSHov?=
 =?iso-2022-jp?B?eTRlL2k2QW45emVuMTAzUjNCcGxpeTY3WS8zZTc0VXlHVklsUEE3cFpO?=
 =?iso-2022-jp?B?UXBXbWFVa0UyNnp6VmdKNnRtNURCU1NsbTJXM0NxLzduaHljMERFTkVU?=
 =?iso-2022-jp?B?TlpSR2pIQkxSSG5ORDhlbWl4ak1GT1N5aDhhUmhPMTM0ZEF1VDdBSzQv?=
 =?iso-2022-jp?B?SjZKNDZqaFhQa3ZoN3k2RjFJc1pTOVhUb0xPVUNyTWZ3a1BVZkVKRHh3?=
 =?iso-2022-jp?B?akdOR2dBSXlsQnlWMnBJalhFN25KRWJMcGJ4SU1MKy9NMnpDRnhxWGVE?=
 =?iso-2022-jp?B?Vk10ZWN1L3NRaCt0bkk4d0VFT0N4TGxuQm5XNEpqcGFIN21wYUQ5Q2l2?=
 =?iso-2022-jp?B?U010Mld3OWNLUGxBcHZ6RytLa3Q0cThyT1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6421.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8158c954-0caf-4659-2506-08dcdddf7401
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 03:58:17.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fseEQHTlxJlI6V8AftahidGUmrLXkGDroFUSw7d1qqU8dtVfFgbPPGoYm1Qotkew0YDuAus7BdJus3wIjhZ1F3tWhBU3nU9wkamQuWcEP+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Sep 2024 03:58:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16922

Hi Iwamatsu-san, and CIP folks,

I recently noticed that 6.1.y-cip has dropped the support or testing on Bea=
glebone.=20
I'd like to know the reason and I hope CIP supports Beaglebone again shortl=
y.

Best regards,

Takuo Koguchi
Hitachi, Ltd.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of
> Nobuhiro Iwamatsu
> Sent: Saturday, September 7, 2024 6:49 AM
> To: pavel@denx.de; cip-dev@lists.cip-project.org
> Subject: [!]Re: [cip-dev] 6.1.107-cip release
>=20
> Hi Pavel,
>=20
> > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -ci=
p.
>=20
> v5.10.224-rt116 was released today.
> I will be releasing a -cip based on v5.10.224 for this.
>=20
> > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release my=
self?
>=20
> Thank you for your suggestion.
> I will worki on the 6.10.y-cip release at the same time as I work on the =
5.10.y-cip
> release.
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Friday, September 6, 2024 4:33 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> > Subject: 6.1.107-cip release
> >
> > Hi!
> >
> > I took a look at -rt releases, and...
> >
> > 4.19 -- no suitable -rt
> >
> > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -ci=
p.
> >
> > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release my=
self?
> >
> > Thanks and best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


