Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F87CD5BAF
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 05:03:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10805.1779426210699810163
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 22:03:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=myqHQW5b;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1779426192;x=1780635792;bh=
	2xPlKszSK8ys8dL2e08NtDPkSR1+mudiC4nnzYx9lNI=;b=myqHQW5bBgCyKg49//Qf0pkJCQRgoZ
	xDTASLsg7QR24Qc9owgCx1ZlXdx21lZIy5Ktf/qBsvz2NZPIm0N0nS0FqPWl5n3EX08TizYrka2+X
	3QHlFtz2xotHSWv1lAizpX/Ds3P2DZtLj0Rjxwyq+3WQf90T+ZtBwn7G0BWcPFxcomYd7tsWOfpt7
	14HX7fVVSrCPKajpvKpXZN+4RQhAPFpY4wUKPlvybTrlvCDX9YMzuPlhD7u8P6tNY+vhY3tmLnYpf
	t4Rr3U3wT6PrTxKA2sUnoco+xE0A+J4P1H/7zas8V0Ao19cFIssDVC8sA2KshTIPN+msUpFAo4MMe
	0qhA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 64M53BxH3810064; Fri, 22 May 2026 14:03:11 +0900
X-Iguazu-Qid: 2rWgltJ450JYhD8DZa
X-Iguazu-QSIG: v=2; s=0; t=1779426191; q=2rWgltJ450JYhD8DZa; m=c4mUGZWNQQz82iQMrlK9Gf4g8nZPsJNgX24O8X8h6L8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gMCpQ3v10z1xnl; Fri, 22 May 2026 14:03:10 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmqkS6bfW5DNJvZmjKnl6ODhNg+S91MsMa4xWRX1BvTATmzyCKEio0GdXr/OoHXg5xTLAnaWzy8Db427+VxengGKHWm3cqcmTv0oZ6jSODiy7ISxdvHNY+v6zHbwLoJUULQVdNKQmIV+um8kCMBJrOA7iSH1NO+uOmjuWKDVs96hY1gEV4rf3UMDIRpfXAu4mhoqPgnzMV7/8qEwCeiJVUoLuT01Dhs481tdLzVUhSzw4dmNBypQsj4Ok07lqdzqTP8aejSjESnqQ2beYwAPNm5pUDtV7uuP2Wyh9yN4QrEY6Rip2qnkVQpc5RWcg4ZygTaarvGqF0pCn53f7FoCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmtGyMF6/4z9nu/inWVoa6g+bcKsw+uTM1pQJkjk608=;
 b=hOwjoFTwRE+ELul5opAvkR2FFE/+nHkSx+nyQzRywFVOts33w1iPcCOcjsOS5LCGTB8LzP/7IrZ3wCz1ZnNvCtIuX//ka8COufYg+WccpGLIve6p1ZAGIMJwG5ATHAjjRBf8ij30bKUsPk6e3o5zozrQsGCGpF+PhW3ztto6TbTI1s7hEyqkVhUPuAjf9W085FGd07YwK7seaKP7xfPqlXH/KEEIKYXfy66ee2lV7JsOQqzJagf10Fm/BvSQh1XonObPhn1bJW1CNWAbLowtFWGlxnA3hn/INf+m9XTt13TE68RiLEjXrmqDuq6NpMfxrX5cv1KFnpzqtOFSrxjOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>, <uli@fpond.eu>, <pavel@nabladev.com>
Subject: [ANNOUNCE] Release v6.12.90-cip24
Thread-Topic: [ANNOUNCE] Release v6.12.90-cip24
Thread-Index: AdzpqCu0dscTpoVRQ/OZXRI7FJRZmA==
Date: Fri, 22 May 2026 05:03:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184C81E2C0A077B1B2209ECD0F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB16177:EE_
x-ms-office365-filtering-correlation-id: 0a2493a0-0802-4f49-16c4-08deb7bf6950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|11063799006|6133799003;
x-microsoft-antispam-message-info: 
 2s6I7LUgxc7ID8E7dkEN2QXjMbOfkcaMhmRlzyaKVecF1WQJrfITVBli19OZxRWX53BREJXHWdSjgFrT+i4KWsvzP1px9yZ/jQR7SrKkh7bOhTiRfWDr81cVlqb5WrV/RpS2Ewwp1gy7ZFRRaTNrtlEVusaX2jcOuUBp2tq+h5xCP5l471XYz31htii4DGBypu8vG2ILN83u++/ndX7ilNKwd+i1tRdC4AQAQNCP5tug4Jh4WQNYcnoRBlPROJFZ7Od86TumtF8r3Mx0hfuzmx0Cq/L62rg/dvqkqfLpQ0hb6u/nxY7aNNFJyg5XvrVLlFX8sHVSCjzeKJlh3FmatpKjQ8791JvbduFwQ8qfjNN3IqfX8fNOYx0v6UMT0XTY6BuGDotwN8DX2ZaCXuVd0RW8gHCFjgtQpyFU9FXaC2KIo1Lx8R5aEg2IfMbDGRWMPqpMAs0xmVH/+E9YNIthwZzWD7iK/DjUZtXqi5VIiyEKDwFzu+zqiOwpXxbtXL1fWgmsnTUhllVloPmNc3HuOLEOaGkx14gjd5oLX6LM77f8B5mf0yP6z+TTxXMwBxZ5rjdIBYX/5Pn3cN0zjCUvCGgtQNlpIUCtAB38IJzcn1w+RHz1e2qTud9tsTW1WeSB1FhUsUFhTDzO4jjph35Rk6twNYBi9ziqK1Abg0pS7GPCx3GFI+NGmYdNGqyfRFzdk/8Wtnp2ye7m2+nokbD/HztMnp/K/V2/GKOQK6lNXoW0Fw1jdRFtM4lfyVZF1aKr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dkE3dithelo0RXVwL0NhV2F3ZU10QmJ5TXFKQlM3SVFLYmZ1VVRTajF5?=
 =?iso-2022-jp?B?Vks1TFZyUDRNU3o2aTR2WTNTMjZva21YZ1FuMWVSY3JuRTBXT2w1WEJj?=
 =?iso-2022-jp?B?Rm5lbzl2U3lqYzdocC9mZnlKTDNKRkVUY3JCSFkwVXRkS0hnQVRYdXpT?=
 =?iso-2022-jp?B?UkxnYnNtVTNLTk5sc2xTRG9kMWpUUDRMeVNBMU13N2VDUzNteWhsSThM?=
 =?iso-2022-jp?B?c3hxWnl4M00rTFdOK2xHODB4aUMzaXpmVzk2STB3bm9SaHk5TTJ5YUpL?=
 =?iso-2022-jp?B?UnNhK2FrSVN3Rks0VVVTYW1TUFpONGJ6K3d1anUra0lzLzgwenhNQUQ0?=
 =?iso-2022-jp?B?KzBqZmMvZTNRdit3VUxwK1JEOENSTm5yeWFYVlNsalhBSDViYlBFVFha?=
 =?iso-2022-jp?B?ODFsK2twcTNIeEV5Zzd5aGs1Wml2MGVmTVl3VFRhMnRUWm11LzVlSEhM?=
 =?iso-2022-jp?B?cjVWR24rRzlGYnpzT3JDZlZnNm1kcEFSTjltM3VkVFl5U2JZcSsrU3Vk?=
 =?iso-2022-jp?B?UEY4WmF4NEIvSmNTRUhjWEtZVUhGYmR0VzZVMjZLNG9FUzltSVJCVkVm?=
 =?iso-2022-jp?B?VkorTUVQSGRZVVFOSlVIdlBrZnZjb056MmhDanNyMFN0ZjF3ZnhSc0tn?=
 =?iso-2022-jp?B?SHRWQyt2WUc0cCt0cm9yNHJ0M3RjVVlYakI2bHZwemRpckgvSTFzQjFL?=
 =?iso-2022-jp?B?dEcrd3o1LzNVZGFPQUxpbzBQcEIwS2lPNnVieG5vR3BzRzZxT0k1emNr?=
 =?iso-2022-jp?B?UFZwdFdIMktIWEgyWThEeVljUjhRY2NSTFBISSsrcGwyYUhIOFBsRy84?=
 =?iso-2022-jp?B?a0puRjI1NmJOMk51Qk51SHpGSUtqRUVGSVY2YVZiQ3BvTmR0dW1MQXlG?=
 =?iso-2022-jp?B?TjBIUkR4YjNROFJuaDlzQWpuTVdXcm1xdWdTRkZ3UE03ZzZmNExRWEdm?=
 =?iso-2022-jp?B?d3YzMEMxMjU0VFRDaTZzQnF6Qm5sZVNWSTdpejVZbnVJczhRZ1V5QTEx?=
 =?iso-2022-jp?B?Ni84VktKaWUvV2tTL2xsTUMwMGNaelZyakpwUllvdFY3NWY3VmRFMkRy?=
 =?iso-2022-jp?B?cGFRcmlJSTJTS3Vya2U3VlM0eFQ2NzhodXcvc0lNR3RKOFB1NkZoUFRz?=
 =?iso-2022-jp?B?dXgveHA4bm5ybHRJbjdBb21yVXVTRjFKRWFuTnB3aVRCTkZRbXFxNFZk?=
 =?iso-2022-jp?B?YXJ6bUljbGhIK0pYRHlGQ1VKSm96c0MzOHRzZFJQeEYyRzdVOEN6Q1Vi?=
 =?iso-2022-jp?B?N3hjOVIwSWZycS9wVEF6Vjhpc0MvZFZSSjB3SlY4Yk1KSWZFdjM5WFBu?=
 =?iso-2022-jp?B?RGYxU0NTbEZJTmNwY2d4MHZPeXdQU0xoMXNiVmUyUWp4ekFwR0o3R3Vq?=
 =?iso-2022-jp?B?b2VZcXd0UElUdW5KZVpjM1pwb1d2QTNodmxsSC96T2tWeVkrcmlIMW1h?=
 =?iso-2022-jp?B?R0ZHNDF6aUpCYUtqNElrdVF6TEpxMGwwOUM1WU55RG44TkVwMWRoQXE3?=
 =?iso-2022-jp?B?ZVN5WHRONm9vbWE2YU5wYTZXbFVINk5TSGg2U3RNaVh2UllManMyQlFM?=
 =?iso-2022-jp?B?c0RQM3hBYnAxK0lGaVhSZktveEZ2WGFOeHhEZ0tFeitCRHMwbC9NaWly?=
 =?iso-2022-jp?B?V3hsR1JNakdMZGtoTmFyN3JyTW04MUNtV1M1anNacU96ZXYzaWRlVjgv?=
 =?iso-2022-jp?B?Smsvb0htdjIyNWtHMjVoUlF2ZkNvd0J3a3R1RmlFMmYwc2NvVkN5R2ZL?=
 =?iso-2022-jp?B?NVNNRHdZNURzY2N2VnhHcG9mUk04RUN3VXZLSXpqenJHZkhURVJPZkdX?=
 =?iso-2022-jp?B?d2pwMGVIUm1JTzZpMEpyWXpWMkh3a1dJaW5UVmZ6UUxIMXhWTTkwVnFv?=
 =?iso-2022-jp?B?K0RnRmpLZWZzUGdMV292dEZFekZqaU0vSUxOM0daaHhMeXZLcEVvTUVP?=
 =?iso-2022-jp?B?KzlTc2VWSmpYYi9KWXlvZHU0cTNaQy9kN2xTZjkzSW00RDJjemtIWGsx?=
 =?iso-2022-jp?B?UVBVRVZoRzQxb29OU3lSdTV5aHg0VnRuNE1DVkJsQTI3alh0UFZ5dEJZ?=
 =?iso-2022-jp?B?RGozM2tBMU5uNmtzaTliV0dtdWZsWlBwcTFlZXZMNmx6cmZXbUNpU1FC?=
 =?iso-2022-jp?B?R1JldU44eExtQm5hRjhVUWdOOTM5MkNudCtpYUdBb2twV3VScmdpQ0hZ?=
 =?iso-2022-jp?B?bFVOQVVQVVJqZ0syTXJEYVFKUXlMcUIxaXVva2VVTTVuYytTZ0swYVh4?=
 =?iso-2022-jp?B?UDBIc3dqOHkzNzVpWVBPR3owRUNOb3c3WlQxYlNBRk1sZ2lkd0hUQndD?=
 =?iso-2022-jp?B?QlpXTmF3ckRxc3VxVzlsdDFnRHpGSjQvOEdjTWk1R0JUejB5MU5pblVY?=
 =?iso-2022-jp?B?YVJWeThrQkh6NGwybjZjMDlEQUk1UXcrN0xjelN1NG4vdHhDUWtnV2Zq?=
 =?iso-2022-jp?B?RVBFSnZ3d0tqUlUzbnVodXgyTmN2RnEzdmVLUDJTZ29lS3JEb0FyWXFp?=
 =?iso-2022-jp?B?VjRpSzBxTE1HejJvZjJrajZWViswckdzbUNWZVdOalRldDJDdmcwNU1z?=
 =?iso-2022-jp?B?VXEzSXVyND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	aNPi23/Zm7pih4/j/aY4DkQSZQcuw1LbcfB8bQhQopqr+HGoMpyAgMraAtDKfOHaqg7bmClDRhMlPF17GpLRVRPsOCDt9XCuahvGLImwNVoiTfmzD+v00iKQuC+cmO2ZnhFOq1CnGv6+WRUgtJHoe992MPNWkPZIo5IOcKSx0t21uRxWg19fhQtq0yf5PMrsIXsrKENjK9GWCgMFEQP0IrO4qidrZulD+pN2IgOFqWAMjPENQTov4T491nT12UO8t4684IB/hSnkF4oWVcpD30wG/GgxzwTidioHlJms1n/c7CAoTLuHsdW37ZZmJ5x/tbSAGtCidni6HtsceieFbA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2493a0-0802-4f49-16c4-08deb7bf6950
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 05:03:06.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mo7B4JvkwrxxeNkK1svza77S9hYvHXKsCQMwj3QxH1N+93X8fXebaUn84HDSr1ECyz+7gSy820SPBqW+oihZtICTAP+pt17A1KuOFPi72IoIB4ouSI7tWPs5IvMvc8i5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 05:03:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22997

Hi all,

CIP kernel team has released Linux kernel v6.12.90-cip24.
The linux-6.12.y-cip tree has been updated base version from v6.12.88 to v6=
.12.90.
This release inclues PCIe updates for Renesas ARM64 SoCs.

Information about this release is as follows:

  v6.12.90-cip24:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      1079d280c6514c2fe7b3c543d484b913c37869d3
    fixed CVEs:
      CVE-2026-46333: ptrace: slightly saner 'get_dumpable()' logic
      CVE-2026-23171: bonding: fix use-after-free due to enslave fail after=
 slave array update
    added commits:
      CIP: Bump version suffix to -cip24 after merge from stable
      arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
      arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
      arm64: dts: renesas: r9a09g047: Add PCIe node
      PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
      PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
      PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
      PCI: rzg3s-host: Add SoC-specific configuration and initialization ca=
llbacks
      PCI: rzg3s-host: Make configuration reset lines optional
      PCI: rzg3s-host: Make SYSC register offsets SoC-specific
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
      PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3=
E SoC
      PCI: rzg3s-host: Reorder reset assertion during suspend
      PCI: rzg3s-host: Fix reset handling in probe error path
      bitfield: Add non-constant field_{prep,get}() helpers
      bitfield: Add less-checking __FIELD_{GET,PREP}()
      clk: renesas: r9a09g047: Add PCIe clocks and reset

Best regards,
  Nobuhiro


