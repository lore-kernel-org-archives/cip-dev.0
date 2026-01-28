Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E1C88E41
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 00:37:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2508.1769560622307835750
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 16:37:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=GxhYslfd;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769560620;x=1770770220;bh=YoKkimHpdIcDt8OKLSozfsIOvpQCR00aExU8Z
	oqRVm8=;b=GxhYslfdQ/ZDWvdV5eXS6aW0vchJ6pfX1l5Gr1c6qz+4kHPAjOtIfZEDj4yUN0GKmzj
	4NdWPOBt9fMGVHLkX8mmDWvjlh1StcPKtM4r8H7As+NAJKcOdJ6768sIHqNap0XUr+gpPz3cNEF4+
	p7VCgNyETXuJ7tX9aWvFM3WxI/GaJ/O48Of410EqPCofzlZHceUeKIwXEplZ+S9eBH/srxsRsVn9q
	IrU5282hMv7XM7dkUFfHth6cObI4xF0MpxqUyMUa7dGy5EiOvYWMwZ3PU5Pmke5C4XV3k+U1m0F/1
	HU1T2i5IHrvoxSEqZ0ZXM0H/qX2VYkbcre4PuGjiD/Ng==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 60S0axik746824; Wed, 28 Jan 2026 09:36:59 +0900
X-Iguazu-Qid: 2yAb9zgpOjU6VPBxog
X-Iguazu-QSIG: v=2; s=0; t=1769560618; q=2yAb9zgpOjU6VPBxog; m=P1T4ci09kN5K8LCDHuzNEicjktJ24dMPRfr8k1OdJS0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f13Ht48dhz1xnl; Wed, 28 Jan 2026 09:36:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTw4sPVr9ctr4xHwTRhNjwYHgyGOdcybX0VS8CkJ8Y8E6bzjCepm9znocGuVi+dLnsItHIz8YxM4/O+2nrW8WQCALA8p5tooK3TRBCw+5aKF3K5jcJNTnCTqhLfCFY5G/Q77NDoHZVCCpnjst4gE3MDDdkjMo4NLaO0TUQYzDFaPCIK0qneGQgI4fkkxH9vYCgkc4E30jd/kBdDb6gLeG4vxRGa1QZbtF9jGjpEa/u95pbsFzf5hncVd+cWnLMwebq92xsrlLh6ZRTe3ro3bvkPN0JDAqQo1Me2o9ms12RY0OpjO11FO+5C34F/qrE54FkN9awqGHmD02uJkVizBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY9ZVKsM5UDCrT6Unb8CMyFj1lxBSuB9ZMaqixDtccM=;
 b=o8Z4M1mHN2R2NalKfonBFo8vLl1ydb8lNx+MIHVxDJROYnFoLFpHSlCBmqqHgSK3ThlVkxn5CjybOKZmVX+eCjACCwrM75b+y4fcxm6Ss7HJsslvlvkfzyeWVsqTnST0BeJ1AG5cOQwSOs2qcTRLozP3QRBlkk+9FNHwY+YLhOO750WB3folL2hgxyxzFZneSgCU/QeO1ooxC73//a1KL2lO3tGy5kv9J/gcl17uwnUjcc801HyMKFWwf3zilWDO4Mzn3+I+do4YKHs7ix1PThBT9FeHjbELu0TFsBJUlG0HAPGxddG1vXF2QvPwqaHkbLYRZ9/3txVH3nr0FDI1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport reset
 control
Thread-Topic: [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport reset
 control
Thread-Index: AQHcj4yDGXMYauQD3kGZR6iIdHatWbVmu8TA
Date: Wed, 28 Jan 2026 00:36:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818183DC55A8674F1F75896CD91A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB14082:EE_
x-ms-office365-filtering-correlation-id: d0438015-97b9-468d-6d87-08de5e055642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b3hqVm1TU29meTFqYVZrd0EvODI0QWZodVpwbW52YWRhUFVNRVRuQkNO?=
 =?iso-2022-jp?B?Y0VUNmVRUG9VOFlIQnBzaEd3YzVyL3YwZ2RjVEw0dmFXWkxjUkpZRkdo?=
 =?iso-2022-jp?B?UWQvOXVaZHZUZ2F3K28yM0FLZ2Zwb2ZPbHY0cHh0VkNXUnhKbmdjbllD?=
 =?iso-2022-jp?B?Z3hteWlrYk1mNE5lN0lXSkxDRzJRWE5hS3RGT1pDSUkvZ0NwTzg3cGlE?=
 =?iso-2022-jp?B?SzMxVlN5ZldxdnBYeTBNUFVhUnBKcjdZSzZDRmo4aFRVSjduRDRES3dL?=
 =?iso-2022-jp?B?YXpVYWhIZjhSM3FXdjZYWFFoSXBLenllNmtkU0xXekwzeUsvL3VKQS9k?=
 =?iso-2022-jp?B?NVJQZVNxUWduamkwc1U4Q0E2STExMExkZGx2N3daa3BBUlBCa0xhRng4?=
 =?iso-2022-jp?B?Vm9sVWFXZXRUNzAyTzA5UUlXTFg5WVIvV3pYWmhYOXBLQjJlazRSM1d3?=
 =?iso-2022-jp?B?RFZ2RUVPNmRxNHRZbEZ5ZnVXeWl1TXFHeEcrSXZnaHYzdFFvSHdpWWk2?=
 =?iso-2022-jp?B?TDBQNGthT1h3alR3REZIbVJkWko1NEtwc0dsS0gzUnNEV3BuQzVZMjdz?=
 =?iso-2022-jp?B?azQwWmZUSVNwb3ArUGN1NjhETEo2QzAyTnpnMXN2N2VnT2pIelIveTB3?=
 =?iso-2022-jp?B?cHVON0E3NHNKUHJzQ2tYR2RIUk53SXI4TW4rKzNiYTBGaHhNczlSUy9P?=
 =?iso-2022-jp?B?NG1GdUdhR25DWTV5c3pNY0wvUTlIQlB1dUJkYTJlcFY0WFVVaDFvclR6?=
 =?iso-2022-jp?B?RG5VaWZTaFVGMzIyVzlWSEtBT1ZuOTR4THZHdmpjN0JRRmJQVmdkazBQ?=
 =?iso-2022-jp?B?dkMzQ3lyVmdSMHQ4QlhZSEVrUFlyaHhVdklRb2ozNmMwakZPOGVmOHlL?=
 =?iso-2022-jp?B?RFphT2x3ZTZOT1drcE1uYVdEeFpuUU9QZ0p4d04rbEhnb0lvUjhIN2NU?=
 =?iso-2022-jp?B?cGdtektHZ1ZyNFJKWWJoRFlRUlRiMTJINUxNUkJrSEg4RVV4UlREd01D?=
 =?iso-2022-jp?B?OTl0eDFtbC94MS9qYVBQOS9qZnZsQTBNZEtSNFBjZUNudHIvejE4NnBR?=
 =?iso-2022-jp?B?MzR1UUNac3dYZHRaSGZYbXRZV050QnNXY280dGJQY0ttZ3kwUjRJbDF1?=
 =?iso-2022-jp?B?a1FOS0luU1FVWEQySkxHeDVjNmVKMVZHTHhNazFhV0x0V2FHZlpmVXFQ?=
 =?iso-2022-jp?B?UWtMTHdiUGdjU3J4MDB1Q3RjcmVUai9BbnFPcWlJU2hESW8vZjVaOCt3?=
 =?iso-2022-jp?B?RUNiSHYyQW5mQVQwV1cwci9FTFRkK3BjZGdvWnQ2Z3U0UVJKWlVkVmFS?=
 =?iso-2022-jp?B?L2YwSUN2dDhBR1AyUjdocWlOajVGaEdFMGlNL2NhMlVZaWxXZTRvVEhp?=
 =?iso-2022-jp?B?UzAwU09ZS2NzT05qMFdOemp1UDFOMkFuU2lyNFpyM1VYcWYxR2JIN0Fl?=
 =?iso-2022-jp?B?T2h1RGtBYkpOZFNJQldiMTcxK0twbjk0TTNFWWdrZzlla1VFTmtKSjBk?=
 =?iso-2022-jp?B?Z2kzUW5hU215VlcxYXlSRGxVdzhObEVKdVZaLzBJQitKSjNyN1dKNlhT?=
 =?iso-2022-jp?B?VjhhSzZPUG9oTWNacFFxZE5uRlYrMGJRVy9IZkJYbjlvbWxIeDVnM3ZH?=
 =?iso-2022-jp?B?Ym5HYmtSc2l1NGVuRlY1Y29GVTVkUENwSWlWQm54dWdDck5kU1VPK0VD?=
 =?iso-2022-jp?B?a3ozRXRhZ2FpSkYxSkI2WWRNVDZ3V3RvVWZTNWNWNVBad0Z3bFp2NDZx?=
 =?iso-2022-jp?B?V2FObHhreFNQL0tqTERpYU5wS3hpRHJ3WlIrN1JrbmlIZnVrREdXWUx5?=
 =?iso-2022-jp?B?amNsUDltNFBBaVFDc2Q3LzdxclAxSit2eHNEUkRHKzl2U1ZadVZzSTFo?=
 =?iso-2022-jp?B?UnJzZDhmY2phcFZpR2FRNFpPTS96S29kTnVEWWlUeEZ3QVM2cW80QnJl?=
 =?iso-2022-jp?B?T2xIbURudm50REVMMFA2VzkyYWtmdDNzQk04SFpxdlN3UHFTUmFFYlov?=
 =?iso-2022-jp?B?U2RsK3RyTTFPOTJoV0QwNXFLOHVBSjduRUp4M3pSQ3NvOWNKdGhnZVJO?=
 =?iso-2022-jp?B?aXgwWlBHVHJJVTFNdVZGaS9Fb0hyT091cmp3Vkw0clB3dVhORXdYclM5?=
 =?iso-2022-jp?B?OTBRS2k0bVhtOFNmM1dBaFBsdVcxdHBabktFNi9NZDI4TWxRMERuQjJq?=
 =?iso-2022-jp?B?YmRpU3NLYWVxN2lzTXBzR2ZJZmNOU1REVC9yQXA5UmdjKzhlY1kzbXZv?=
 =?iso-2022-jp?B?V20zYjk2MXBBYXYvUC8xbEl6QlppOVFiN0JmZkRsV2ZUQXI4SmhxRHF5?=
 =?iso-2022-jp?B?M1hGbVI0VHdSQmNqTm9FRzlCUEZQaHlxZ210Y09RcG9QYUVGQ3hkTVF3?=
 =?iso-2022-jp?B?YVVqZkU9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bU9OQzA5U2dlOGFsaVFndjVNMkdhR3VrQzJSa2hvSXc4MFV4UnBhaGJG?=
 =?iso-2022-jp?B?VHFTRlpPSkRpWDFZUlpVRDYrcXJvbVlkaVRGK2VkK3NXMUxaOHV3Rzhk?=
 =?iso-2022-jp?B?aUJtRWhSZW9oTnNsMTB4QVN5ZjYzc2hZaERlaWtWWDdaa1EvNHpxTjls?=
 =?iso-2022-jp?B?Z29OS2QzNmVvSFBlUDZORlBOYXA5akgwYlNibjEzNVo2THp4MUJ4N1Y2?=
 =?iso-2022-jp?B?clZZQ3QwQWpReWFrNmYvRnNIZitYTDRpcU03dVQ0SmZWc2t2U1BIc1Bu?=
 =?iso-2022-jp?B?bWU5WitHc09XU2NrUWdZQWRaN2VLVFYrVFlvQ0d3cTJ6Uy9DVDN4QnFo?=
 =?iso-2022-jp?B?VFpTcUo2WHM0bFNveHdWMkJqdmVSaXZDbTZEUVZMMFYxOE53Y0ZKZ2Rh?=
 =?iso-2022-jp?B?ai9JR3FYQ0kwN2pDV2w1TUZNRkltQWs1aUd4YTN5cGhmZE9hbFJSb0Mz?=
 =?iso-2022-jp?B?QzlGZmZUZDZWMEZHbVNXa2ErVHQySHZBYTRQb1RLaXpiVkp1WlRSNjdK?=
 =?iso-2022-jp?B?TkRKUG9jVXdVR1ZKZG9PdTdzNis4eDloVDdQRU0raUNGTE5udXA1Z1lI?=
 =?iso-2022-jp?B?WExnSFVnZGhsSTh5dTZ2RnUvZC9jaWxkQ2xPZWNqbE9LVFRDRHZ3b0tH?=
 =?iso-2022-jp?B?Y3c0TWU4aVU4cWQ2UGdsUzV1dDVFNmovRTZNMnR1cEhMVnFqWFFQTGU5?=
 =?iso-2022-jp?B?aUFadVU2T1Y1Y0lhSnVrNVJhRDl4MkZXbzRaMi9LZENnM3pFSnkrUXQr?=
 =?iso-2022-jp?B?aG5ESXNmbk9NYnhsbVNJRTlJbTBhT0FtZVkzWnlYdE5EQ2NoeTdJY0x5?=
 =?iso-2022-jp?B?ZWlZdG1iSDFGcy9wUStrb2psNGQ3ZHB1Wm50Um5DL0Z2eUl2aFNkS0VL?=
 =?iso-2022-jp?B?dU1HYkJjRytsQmNzWG1JRnQ4MjNYLyt2VkM0QisvMWVjZFg4ZjdCNFlm?=
 =?iso-2022-jp?B?dVFpRWg5ZXZjeW9QeXozcnl1cWJ3L2RQMUQ3cm1MNmI3ZU1wM3lpdzZK?=
 =?iso-2022-jp?B?QTRNRnpKUkpvREV3Ry9mUEJtbVNDaUdVaGVPVFZrVU5QL1JuRmpRVm5x?=
 =?iso-2022-jp?B?dDE2TEU3ZWRmdmhEc1V3L0FBVzdsZW5KZVVLbkVrNkpEcWs2dmF3VVFt?=
 =?iso-2022-jp?B?QmZ4Y2x0WTBqelN1bDU0QWx2WVFyQ21CYlVGOEFRZGNENC95aE44dThJ?=
 =?iso-2022-jp?B?Ny8wQnQ2bzZIU1JXRjJXNklmVHRzMWE4aUwrV0RTVEZ4QTBlNVBUNWQ1?=
 =?iso-2022-jp?B?V2JFTWdZc3dwRjMwS1RKVm9CUmExamZmY3VDaW0zamt1Wk82MWtBN1lM?=
 =?iso-2022-jp?B?REZ5UW5TYjFFVkZyLzdycWdIeHJTcmZNSzVnZjB3dEMxVHpKREZPWGI3?=
 =?iso-2022-jp?B?R2w5TVB5QWphTUwwd1lsQkhTZUtDQnMxNHg2WHpZSThUcm1HOUdXdjFG?=
 =?iso-2022-jp?B?d0J5VkZPQkQ2eThCVk94T3N1a2RiRHlXK25XODBndlM4RXU2VTVuUURY?=
 =?iso-2022-jp?B?di9kOC9pWFJZQm1VOTU5ZlR2SHRhS1RyK3ExdW5JSzdzcFlMMVNLbEhP?=
 =?iso-2022-jp?B?eTF4NWpFRE5sQzVWbm1CWWJxUmhkejdQOWJmbXp1WlpoRmNqZjJVRklj?=
 =?iso-2022-jp?B?clV6SnVDWklWMFhWcWNDNkk4ZW9yb0VhVWhyQzBVVGliQUFCZG5SR0JJ?=
 =?iso-2022-jp?B?YjRiS1ZnYVpvTDZpRENMRDd6MHFoMzlyZlc2YXM3cnZ0WUtVc2E3TzIy?=
 =?iso-2022-jp?B?Mlk5cWJZUWZWVFBjYW9ZbWZsZDYxZFF1SlBsRGl6YzNNUjhRL3NHRW5S?=
 =?iso-2022-jp?B?Qy9qaFNlT0dPUGN4U2tzLzZPT0xoQStkVlltMUdEaXRhVkw4TjU4dDlZ?=
 =?iso-2022-jp?B?Q2VGNGZ3LzVVL2Y2N25NYlFzMnhpWm9zWUZSdk03a1VJZEZJSzhubDM1?=
 =?iso-2022-jp?B?VnRUYWNuV296ZC9FOTFvNVFXUmNncjhHTFh5Mmc2VWNMR251RG14RE5v?=
 =?iso-2022-jp?B?dTFQZ2gxdmZHd2d3U2llUlF5NzFuV0xKOHpGOVZaUk1DNmJYaExMSHhi?=
 =?iso-2022-jp?B?R2YvUHJXTlZiS29wK2xEQS9RSUozTEN2VS85UU1HM0trU3R1VmVLcGZM?=
 =?iso-2022-jp?B?M093SWIybi9CbzZIOGRWcUhhZ1A1RVk1bUUzcmFyWnlhTURFRTdBS09l?=
 =?iso-2022-jp?B?ckd3clFVVkdsWDY5aXdCMzJld3ZMcFZCa05INiticHBjd2xFWUxTZ3Vm?=
 =?iso-2022-jp?B?cGhlVEVKaWJpWUZUcGE3dC9sWC8yVWFQTXhhNTRsQkdLTEsxaVE4RC81?=
 =?iso-2022-jp?B?aUFXWG5kTEJXdVhCL1M5OUsxNmZlSlMrS0tLYUYxUVlCUUNNRnBaWXNB?=
 =?iso-2022-jp?B?MS9IbTdQNW5ZZnFZeVNoY2ZXbzBXQzRzVUphdHNvc1lZUTZ0akdrS1hM?=
 =?iso-2022-jp?B?dUVFeTBQZHNRdHVLQ240c0xrbE1GUmlTVHpGeVJzTkdRL2RLVCs1WWxv?=
 =?iso-2022-jp?B?clNMSUVMOFl1MnpwbVVlYVh1WmxkRlZFZE42ck5DWlVydFVZWVVpSkRW?=
 =?iso-2022-jp?B?d2ExckdKYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0438015-97b9-468d-6d87-08de5e055642
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:36:54.7964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l+w6H0wg/Nya9dWVNe5CbMvpI1ISLE1ML2cT+sw9QYiwBtG7ZMcN6w9SQr/TixtOh7RR6fKBe6ah32tvC8layk95jZ4A1xi6+xEXnKJS5UAX2x1cRmmKYaL+01UHUa/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 00:37:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21731

HI all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Tuesday, January 27, 2026 9:57 PM
> To: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport reset cont=
rol
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> This series backports patches to control the reset signal of the Renesas =
SDHI
> IP during probe and suspend/resume.
>=20
> Thank you,
> Claudiu
>=20
> Changes in v2:
> - used CONFIG_PM_SLEEP in patch 2/2
>=20
> Claudiu Beznea (2):
>   mmc: renesas_sdhi: Deassert the reset signal on probe
>   mmc: renesas_sdhi: Add suspend/resume hooks
>=20
>  drivers/mmc/host/renesas_sdhi.h               |  4 ++
>  drivers/mmc/host/renesas_sdhi_core.c          | 53
> +++++++++++++++++++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
>  3 files changed, 58 insertions(+), 2 deletions(-)
>=20

Thanks for update patches.
I reviewed this series, looks good to me.
I can applyt this patch if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro



