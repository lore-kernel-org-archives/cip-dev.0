Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB226D68BCF
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 02:29:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32284.1766024986900181549
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 18:29:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=rFPlD6kh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766024970;x=1767234570;bh=Edkys1NQRgznfG+Enlb8tfWhAm1nFaPvTq5IC
	IkLxoc=;b=rFPlD6khKbtXzNogrbDINYR9wvLOXabhPbvjG9dg8UthaPypn3JXCIM7GZnOSzZx0BP
	S6OeGehAmIbSjyXFWbi0IcG4GqlL7L6p5+Cg5zgZqyJnqBnKZHJ7BUl9JpwTKId1CUyo8/zv3IdJe
	sgCl7NMKPrKieQWShu7/6AxMO0s9B4rsGomJ78OHHvDnVuF6qX8W3uysEBWF0aVmpnHOwqUcWtm3q
	Aqhr+AaUt7OjyIp7pGCRUJWU/GnDLUa2jKBdT4r3P7ukVRo2Ph3EUY4czeKXknYeKUwKCXydLdvO1
	wmeYnGbp1CN5tdfSOVEHQDlwsjJgByZH9RPKgm4n8hsQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5BI2TTr9649988; Thu, 18 Dec 2025 11:29:29 +0900
X-Iguazu-Qid: 2yAaGFzRaZKbej7Kip
X-Iguazu-QSIG: v=2; s=0; t=1766024969; q=2yAaGFzRaZKbej7Kip; m=gLfIjKt5QaheMVViLX4s0/qLt1/yFR3tnHQ9PAjqPoc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dWvkd0ZNXzyPQ; Thu, 18 Dec 2025 11:29:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT8HVbyTYsXiMr6PyxVceddEPpydlI7n4Jkz4z4VBhylh4GfkMU0hX7Qsqw7pDcba9el/YNvsUXnuwwEekRQlhsG/CXU4W3ZGy9HCsVFCkpGwlH2vUFZwrHprfW10tfCtE9t7NcWnbv5AAPfL318wynJbk2iqc2QpRKD1P8YQ2ynpr816bCxqISl5aFEqckt0L6gIWVk8wCEpKs47kW9XPIFSPq/7ylrupCC61W5KYxOeerjFIDPOmIkZB2917Edqo/VKQwtPaX0Ibmi0Rw19/RXhydhhrjZKjwEaF3K9wPz4VDVGp5J+iE8mKftNl2Ca4bCW8VLq7ff8ZAmOjkPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2wymdLRcONGsGU3z7AohK2uGNsGCJgQ97IkQD5EkZ0=;
 b=o4EZxeI6vBAj1RciFnq/LrR79EprKFy0diBltu5O7Nqcm6zoIry2k01Hur2wvXO9pcOM6rvXZwgW/VEJxsDyW/UiZ5PHnycD8HSLrKWB1LIAZlZjDNFVh8IXGzQcjCy6KYFKoHK9N/MpfDnJ4MlN5f0k1ozlNz10JvjWVjaRiCuZV99NlzARM+jrNecNPUktYesFAppwcT2pP/GVOTa2taaI9TiuBOtP07eyol+W8XwL90nCO6G1LodD+LHFBk850M8i8cbIGKlc8OAgcLgN4dxsaZxqH8Hhc2IafQ4I0i1XNHV1Bja6+UXUvJ3T1JYO0knHY6RPhPYcYqoUBNI7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <pavel@denx.de>, <iwamatsu@gmail.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Thread-Index: AQHcX5Eow1enh3TVG020brhPvLoPYLUIr3aAgAWcCYCAF8TCgIAAvKRA
Date: Thu, 18 Dec 2025 02:29:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818878FCE79BCCC217A3F3FCDA8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC4HpsHngXRgjpt+MmR1Qi211fgDWv=+3vx7n9d9EXq=6Q@mail.gmail.com>
 <aS7YU1FbxmmtywFT@duo.ucw.cz>
 <TYWPR01MB9277CB6CCA408B8B70158CD1D3ABA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9277CB6CCA408B8B70158CD1D3ABA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB9681:EE_
x-ms-office365-filtering-correlation-id: 0fc6c0f2-9b08-47b1-35b6-08de3ddd4380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RUo0aVN5UngzbU1vNFY2QTVnbkJVTWNsQ2l1NFpydFE0OGdJZTNmODVT?=
 =?iso-2022-jp?B?ZDRJejhGaUY2aVRJMkw2WUF3Y3ZpakFkL3paN0Mrb1V6RnM5eFlmdWtU?=
 =?iso-2022-jp?B?Q3Y4dGRhTzJNZmtDdnQxRlBNQ1ozd0ZEbXVWTWdlMkNNQzMzamJVS0tX?=
 =?iso-2022-jp?B?R3NlMjBLWmNrVkNqcDNlVi9hVFU5VnQ0VzZwczhjKzlQamFhYy9GMEJH?=
 =?iso-2022-jp?B?M3JEUmVyQkVkNjlod3hReFViZUxqVWlUZ3FZdmpzdzc5c2tPdnNKb1g4?=
 =?iso-2022-jp?B?S1oxUFZOUXprV2ZTY2ZLRU9GWjkvYkpLV2U3cWlhenBFT2JBdGdEeHF1?=
 =?iso-2022-jp?B?Vm1mMzZBL2FiN000Q2NKeUVkYjdJVW5Ua3JPOE45cys0UFg5RUloQlBm?=
 =?iso-2022-jp?B?ME51Wlh6QlY5TTdkd1pweW54WHl0aHB0b25xVUo2WTcwSEpnNmhrVWhH?=
 =?iso-2022-jp?B?cDhXbzRRTTRBcStDWjM3NkpvSWlaQ0piTjFUREViN3o3VzVieGJKRm1F?=
 =?iso-2022-jp?B?dENiNzREbForVVNoUXBCSDVRbko0cFR4Vlh5S1EvcGpKQVhSbFVoT3U0?=
 =?iso-2022-jp?B?US82dlQwampHM1Vyc1ZPMmxjZkJ4dFFXWmt6djViVWtFN2Z0M3lGNDlL?=
 =?iso-2022-jp?B?dWtkSEZUYnBSckdBSi9RZ1NZMmkzQmk1S3RDK2xybmRuWklQMGpKRGVh?=
 =?iso-2022-jp?B?WnFZY1ZNaUlHeTR5cWk0V3l2VVVTVTZPTjNKUC8xeEoxZ2hzam1OQ3lO?=
 =?iso-2022-jp?B?VDQvL21GZTFDMDVLOTNhc2hjNktya0ZBaThJQ3RJOS9kYWFwNU9Ib3Mz?=
 =?iso-2022-jp?B?WldmQ3hrY3dmL042RnpYMmU1NlphdG1QMDA0SlZYK3kzVUFPdnFKQkhG?=
 =?iso-2022-jp?B?Y1h2Y2pkMUozUWg0cGN1WjV4T0pGcC90ODFGaWw4MysybzRlODJMOUVk?=
 =?iso-2022-jp?B?WEIyYmphbElkYkhzNThzVXVjY2sza2xKMkVTZTZMeFV6S1JDYlM5cUhl?=
 =?iso-2022-jp?B?UW1PL0RtMHQ5bXZmNitHdEIvelJVbzJiaWVpUmlkVzUzVHVTdm82ZCtj?=
 =?iso-2022-jp?B?Rk9pUGNDVFRUb2FYeUR5a0xMUkE4bkRlWkNIbVdUMndzbWZzWVZNek90?=
 =?iso-2022-jp?B?a0NCUnVkeW5kbUtBQWRCSWNHclBUOGdYM0svUGRDS2J6V2wrZkE3WXQ5?=
 =?iso-2022-jp?B?d3dpeFd4ejJKeUMvS1JyU1E4RFdUMmc0azBZazNUbGVhKzc3MzFJbFNa?=
 =?iso-2022-jp?B?bUgxR1RFYTJmU29KZWZjYmtXUkJiamxtVW9lYm5SUU5aYWRhcmMrOCtZ?=
 =?iso-2022-jp?B?MmZ5Z2dRancybEl5U1ptVGtFZHd1VDk1QmY0dkFpWGRHWXBiOXVHSVZn?=
 =?iso-2022-jp?B?MTZXQnhWVGR6YzhScmhZMG9wckVzMFB3bzl4YlNIN0VEamg1SUVwaU1V?=
 =?iso-2022-jp?B?d2NzN0pDbTArSmx2eDRwNk1BeXhPdDRBWlpVL25XOHE0VXl6cXlISk9K?=
 =?iso-2022-jp?B?VXFmRFVOU3ZQL3NYT0dhQjh6eWZTYnk0bjZ5MGh2MFA5eC9RUnI1SVJK?=
 =?iso-2022-jp?B?VUlEWVVIVjV0TnE5RXNGd0FHbTA0b0s5L2tGR0dPY1lobWlyNFdTbklh?=
 =?iso-2022-jp?B?dGZhcXRJKzlxRnVOZFhvU0pLME5nWHluQSsyRHdjdzA0MG50d2VmU092?=
 =?iso-2022-jp?B?eTMvd2tOQlY4cnlOYWtxTS9tQ1RFcEJ6YjNKckw5dHlzTURoZGw1SVph?=
 =?iso-2022-jp?B?bG1JdDhScitLMWNIL0pvb1dEOER0NmdnVDVxNCsyRGFwY3lYVll6TnBU?=
 =?iso-2022-jp?B?L2l5c2IrMHhjUDF4RFNFQUh0Y2RkK0xwbFJiS3dDeEN0dnRvVGNvcFBz?=
 =?iso-2022-jp?B?MlhmYS8yeWhiZ3RWbS81aVRnRkVHNTR5aWw1dlZ4anVxR0pVdkRzQjBl?=
 =?iso-2022-jp?B?SkV4ZGxoQkZQa2ZtQVB2NTFGMmtWYXBuT0tyZ2hyeWtJbzJ0UEpLNk5O?=
 =?iso-2022-jp?B?dmZMd0tLbm5UY09HdGhlRitlV0hNdUtCa0VEZEZ0M3o2WnFzdytRaFY5?=
 =?iso-2022-jp?B?WEoranZOK3BqbnhuTDRoM1hIdWFjQjhlSEV6RjlLZ1poSEpGMzcxZ2o5?=
 =?iso-2022-jp?B?M1Z1MWFrMUppanI1ODhzNE9UN3hIRDJIUEF6OWc0S2x3UVQyRDNUM3VZ?=
 =?iso-2022-jp?B?SXFOak5RM0o2Zm9aMEdHZW4xVElvdmdE?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUJPek80UldVa3cwUmh2dmIwL1A0Q1BIRkFHWFcvVFdzNWRtbnIxdldW?=
 =?iso-2022-jp?B?Z1NzQWs1UTVtSHJwSUVoY3BuWWM1Vzk3ZjJ2OVNhY2Qzdzg3dFEzaTRz?=
 =?iso-2022-jp?B?ampuSnNtdXlUcmxmMjduVkNmVDJ1NDVFMU1oZGhrbEpmRGxtSXBCWGRW?=
 =?iso-2022-jp?B?MGg2RjdtMlIvdnJiMkhnTzlpd3JWNjJ3T2pwMGNhdUJiN2R4aStSTlVj?=
 =?iso-2022-jp?B?S2o4a3pHMEN1VGZORnIzaWd2SDF4TmJVRTFMdUtYSTRJdUxPSXNBTXZW?=
 =?iso-2022-jp?B?NHd1Nm12VmFLeVFYSVNGelJFalEvS3hCQmp6eURoOCtuMkRNbUc2ZHd2?=
 =?iso-2022-jp?B?eTE5b3c1K2p6MTlNbEVJZCtuTTQ4YkFZc1BsR1M4Q3lZR3FnOXFVdDc0?=
 =?iso-2022-jp?B?TWgrQ0psanJMMGpUTGIxdGFFem8zWVVocklybXcwSUNRU2JZdmhWSnVW?=
 =?iso-2022-jp?B?dE95VTNaZlkvMmVZMm5iakpnMjVoajBrckRkUjNCbGZGMnllWllKLzRP?=
 =?iso-2022-jp?B?WE1WOTdYcXA5b2w4eUpxZHc1cW5GcHRCQ1Z1RzlxcDlzNHNzQ3FvVWVn?=
 =?iso-2022-jp?B?RTR1MlpNVTROMENCRmdmSnZxb1dib1ZIcnZvNHZ2NVMwMEdieFZwZW83?=
 =?iso-2022-jp?B?S3BmR2xnY3NyU21hMnBJWHBLb1QxbTd5eDZML2x5Rk5JVXNNbmsxTHQ5?=
 =?iso-2022-jp?B?UTlYWjc4K1M2YXpXekJ4SGcrZ25ON1M4ejQ2YUVzcERsTVAwMUVlSW5X?=
 =?iso-2022-jp?B?RVhrZHB6MG1wTUdyNVVDTHJlMmk0aHhsTXl2KzFJdEU1MjRlOWFGK1RB?=
 =?iso-2022-jp?B?TVc1NWtoN0lWc1RTeVZmTFUwSnVLTW15eUhPWTBINFRBVFVIRksvcHV2?=
 =?iso-2022-jp?B?bHZxMTZOS1R6VDhoRVQ2L3N2ekhVZzhaOFZEUzB6MzdpSlR4c05ESmhu?=
 =?iso-2022-jp?B?UFBrUVlvR25OVnV6bHlocVJ4WmdHWGVmamN1YWt5bVpGOFF0UVRDUnF2?=
 =?iso-2022-jp?B?d1V6ZXM5Tkg2TzVTYmk2SUFaazZYNHZHbjFuaFJxK3QvUUYxVENkaTJp?=
 =?iso-2022-jp?B?c1R2ZXVCSUFWdWR5dit6c25jYnFHdzhHTDlkZGlpTVcyWDF2SzRHUlpk?=
 =?iso-2022-jp?B?TW5qOFJRLzRNVUlxL041Nm1rLzI3SDlCc1k3azQ2MzA3anMrSXUyOWgx?=
 =?iso-2022-jp?B?WnM3a3loMmVKTEJBMFhYL0VsRDZJOFNCd0d3Zi9KY0VRSytiVFZ3Q0pZ?=
 =?iso-2022-jp?B?bStuaVpOMFplZjIvakF6T2RYdk9oSUJ6NkU0NW90N3VMNVZuMUl6cTNt?=
 =?iso-2022-jp?B?QVhqOGZqN2hheHhyRG1BazVERUxPRmhRN2kybTBTaVNBRU0rYXBsd09U?=
 =?iso-2022-jp?B?NmtaQzBtYk0yemE1YU1TRTl0V3VKVU5HNFRKUFAwV2tRL0FzZjRvVFZX?=
 =?iso-2022-jp?B?ek5lZXEvOWlnRk0zKzlaaVFSeG5WYXlSK0c1N1F6eGhqUWNwSUJHOFpR?=
 =?iso-2022-jp?B?UGRQUk1oZjZsSlJpcFVSY045OUZJQjk0VzFSVVZxU1M1Sko0eWxyaHVH?=
 =?iso-2022-jp?B?ZlhtSitEY2VNcWlTeDFCaUZ4bzVEMitKQ25aRjF6RnZpdE1hWlBhbWVl?=
 =?iso-2022-jp?B?UnBHTTFudHRha0dBOEx4QjVFdUxMdGRHWlY3ZEpUVFIxbmpSZ204MUlh?=
 =?iso-2022-jp?B?NVZPWStqcCtTVThvTXlhOFMxRzJuN0ZUV1FJTWxtbGxENkxhMGhxREY1?=
 =?iso-2022-jp?B?YmdoTmFVMndVYnVwRVZicy8rZ05OaWJKcTE4WGd0V2QyeWJSUEx6N0Uz?=
 =?iso-2022-jp?B?SmMrZ01hc2kvNzZiOXplb2JIWUVETm1ER3Vtd2hDMjNabkFheXAyWkpj?=
 =?iso-2022-jp?B?ZXd2R1lGU1RMNDFhRVgyOVZQMWgvV0t6NXR6Y0VzWFlocWNVRTJXM3Jn?=
 =?iso-2022-jp?B?bWpnQmRITHE0NytWdzRQN3VnaXUxelN4YWtwN202QTBodGc2ZEJaaURB?=
 =?iso-2022-jp?B?WHJGSDdQck1MNndMVHhWTGZiZ2lkeHZKWlVFTzBPM0NYVlZzeUFHWWlt?=
 =?iso-2022-jp?B?SVBSN0MveVNKOVp4RE03MnUvSkI4Ry9hVFZrdnhWUFJSSDBtL2YrRCsv?=
 =?iso-2022-jp?B?T2Jwc0ZkSmdYWWxpU01jWHBSTWx6WTFDb3lkaEs1dG1XSUtTSDV4RXZK?=
 =?iso-2022-jp?B?blJqK2VtMEZVa0VSaENCQkRmVDQ5YUZPU1BneG84dGkyTUpVa1RhQmVz?=
 =?iso-2022-jp?B?N2RPUW53cjRwbG1JUUg4YVEwN25rL1ZSS3JHY1hFVnVlOVBCUCtMTjJP?=
 =?iso-2022-jp?B?VGFiMXBHR09ud2NnQmMvbm50NTFnMS9wMHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc6c0f2-9b08-47b1-35b6-08de3ddd4380
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 02:29:26.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCIGskUcKbwUrn/sJd5dkHaMD65LuPtQEvQ6b0fIRVjAYwNAcCPewF2C4tlkf8k7dghhfzigfupzQDwymihF44rWG7j/2y4wpJiYYaEJg03YmkkyT9/UKzqwRl8MY1Mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9681
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 02:29:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21122

Hi Ovidiu,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, December 18, 2025 12:13 AM
> To: Pavel Machek <pavel@denx.de>; iwamatsu@gmail.com
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
>=20
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Tuesday, December 2, 2025 2:15 PM
> > To: iwamatsu@gmail.com
> > Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>; cip-dev@lists.cip-
> > project.org; nobuhiro.iwamatsu.x90@mail.toshiba
> > Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
> >
> > Hi!
> >
> > > > This series adds DMAC support for the Renesas RZ/V2H SoC.
> > > >
> > > > Upstream commit 1b86d3ecde5c ("dmaengine: dmatest: prevent using
> > swiotlb
> > > > buffer with nobounce parameter") was cherry-picked to allow
> > > > dmatest to validate DMA controller functionality with and without
> > > > swiotlb. The remaining patches add the actual support for the RZ/V2=
H
> DMAC.
> > >
> > > I reviewed this series, looks good to me.
> > > I can apply this series if there are no other comments.
> > >
> > > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >
> > Thank you, applied.
> >
>=20
> I just noticed that all commits in this series were applied to 6.1-cip, e=
xcept for
> this one:
> https://lore.kernel.org/cip-dev/20251127112941.55300-7-ovidiu.panait.rb@r=
en
> esas.com/
>=20
> Could you please check this?

Sorry about this, I applied and pushed.

Best regards,
  Nobuhiro



