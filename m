Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16CAE77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 22:19:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.117251.1734560386283531450
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 14:19:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=eE7OnUrJ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1734560376;x=1735769976;bh=2o9HJEMrXyzKmmgF2BDAhyWb1nxAP8vkdzy8i+E
	Hvl8=;b=eE7OnUrJop3HoOxjMB5Md42LPJNTI/iSwqtRpl/DzLWbnolLHwX/SByE9ewwaiVo9KUyS
	y54x1EkTkytyAQOCSjYKfanTqOqtfU6Q2Pfq4p5nbsRD45kKOcJUUkJ1mbW1FwoBowazqzS2D5/Ob
	O9rv0aGNgZwUc8n1ViQda9Ny0rbM+v9r8Mqa5ZYh9qxE/eh/so1fdc4rLmOcRME2TWw6M6HtZHwHE
	TIY8h4L0oO18GKPc4/2AZqqeKFCKZPN/e22xtefg52wxzgZTZ8oZerZXp8lHyuRMLcDTViex6mfX0
	ELY2SBwLrYi7Rcj0/BSkKGn0XicgvYfZENthD//zsw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4BIMJa273742036; Thu, 19 Dec 2024 07:19:36 +0900
X-Iguazu-Qid: 2yAbUt1VCS07lQeA6f
X-Iguazu-QSIG: v=2; s=0; t=1734560375; q=2yAbUt1VCS07lQeA6f; m=KaeuxcxoakYODNq0Tj29tcIFTbaYfIq/e14d62CgY/E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4BIMJYT81708168
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:19:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7+2+dtXFPMKD5xt3ChbtmsU6zOkreZ1Mhtg7bDtOf8Lw72p6AFcrNT3ztnRwjyg6PEsxXuFRBw4g/gQ1FhTrS2hO5EmtM38Ldvz8k+OeS++ZVvTz8KaWPMQAEOTaXBTu5gzdmC2yqyjDDDN5xjRLJL77yvVYTNhUC4owxPgEdCCynrWEfZ+PR9LiPntFz1AYRQTBMKksVasJBt9w2VnG1vzgsqK16aW4RbyOW+ZJAn9kd22exUk49amApTalSEu2+AZaMzr+Nx0TUVxIE95Zc2hTPChhmdKPuMuJTuMQpDXa0CJaRWFuTOdPhKAyfb/gxb7vRhfT0A+DnNL6wQDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deRpIzd65kITAKmmwarcmMumJ9ued81KN0l1NHPaxT0=;
 b=uHKgpg0W8ieeb/8kBFzxoafloaNawZN5kt+yze4V6Ufsc12IMJKeUYq57Y9F8H6E1fiPvVOl7nDNrKfLyI8I7p8Ezm7BBgC1CyEYsijApCq/n9MgRcGheCjPsu+RsHrH99kgIC3aHO2fjnAnalqCvVbMi0wrqfShqJv5TAS6057LLVmetiBLweGIbFesCtiEQboGSVhsGEYuAETURoNgdXxvvpFzWDkDCng/YVc0b4uig0CpIPKJic6Id2bTXf4rSbDCAKIPf/CIq1arqQ6k5UxzzlSiO6xNIJ0oDT53lig1Kq+40PoarmMMTWQhOg7m45QtytfzV4cDFpmx69+5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV clk
Thread-Topic: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV clk
Thread-Index: AQHbS/iuEpMvCPjb+E2uoxNdnnCR6LLsnSfQ
Date: Wed, 18 Dec 2024 22:19:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388CA1D73AFD934D86A3FEE92052@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241211181524.28027-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241211181524.28027-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8403:EE_
x-ms-office365-filtering-correlation-id: c56655cb-c1a7-4069-cbac-08dd1fb20c59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZnR2UHBnTytMN01DR1lNNnE1Wkd0dHoyeS9takpwMjFKSEovV0ZDTzZk?=
 =?iso-2022-jp?B?SXBUd0poclNXbnJRREJ0aFI4dUNodmg3UVp5MlA5M2pIRlkxT28wZlJn?=
 =?iso-2022-jp?B?WlBLWmZ6L3RQd0J0Zk5tOHN0N1FuVE5IYmp3YVhyWTE0UlNxVDFDcWV5?=
 =?iso-2022-jp?B?R01hcWxjKzhMVFVhdWJjYkgwVy9sT1JnVEU4b1ZidUk2b2pCNklvR0xM?=
 =?iso-2022-jp?B?c1BpYWhEOU44c3JoVEZ3bm5kK2R2UVptRzFLZ08wdUxQMnU0NHJvSkM1?=
 =?iso-2022-jp?B?YW42ZndnYXJwNm5iMStkVmNaN3ArOTFQbkhaL0U0VlROa3N4cGtMbzRa?=
 =?iso-2022-jp?B?M3N4N1QrZG5EOUtjakFnV3p1NjZhUXplMWJOcGFVbWFNQnU0L1hzTmhI?=
 =?iso-2022-jp?B?M296cjdsTmQ0b1ZPUHZIUTVDTStucHhSY0xQUGVsMCtUcW9HNjhtOUtW?=
 =?iso-2022-jp?B?Ui84eTE4ZzNJa2V1WklZZFExMTk1S0ZySWZJZGxwbFJKbGJNVGJPb3BQ?=
 =?iso-2022-jp?B?c1Z1bFpvZ0htbWRtRnhZVjR4KzkwU04yeXJ3Z3hKUVpSelMyTlc4Y1pv?=
 =?iso-2022-jp?B?cWdlVE9HSHpOM0Z5WFc3SWJwbkJ3a0NkQnNENlh1Q2R3RUVmZmptejhq?=
 =?iso-2022-jp?B?SVpDakxjek05dUk2cTBsb204L25yUElabVN5cm1WTFNoamlpeWgxVW9U?=
 =?iso-2022-jp?B?Z3NKc3hXWm5UWVdLVHFrUUk3bUlMTzdxR0p3cFdpMHpkYk9aclJoSVNL?=
 =?iso-2022-jp?B?ZzNNMVYvZ3NRTlhPN3ZZMk9wUjdCMHIxb00xMldtbTlhbGF6RUNhR2FD?=
 =?iso-2022-jp?B?WjR0RGRrblNUSTl3Mmg1YTVaQk1keUJzcFNVZGREV0NYNmNxOWx1d2Zp?=
 =?iso-2022-jp?B?cVJ1TzFvQmdWdldMb3FXRHBJNHFwM3FGVzNkWFdodEJWcE9FNHhpVFdS?=
 =?iso-2022-jp?B?T2VuSUIwelgwdENpdXFZMUlBQzhNeW4rNEJESmpRL3JRRVNoQTNIa3dp?=
 =?iso-2022-jp?B?em0rT1MwVHN6MmlaZWVMd3EwYWVmSVBlTWQraFBWUkhNNDh4RDh1UWxC?=
 =?iso-2022-jp?B?QWdFZzQ4SGQybEU4QzhNY0lGT005dXBzZVBUa0UwcWt6R0dTbnlIWE5G?=
 =?iso-2022-jp?B?MmRUME1hWThkcHc1cTVDbnY3aUZvaStwTFhoYldNaVJWRmV1MTIrUWRq?=
 =?iso-2022-jp?B?VDdPT3ZucWxQTmswMzV6SUVxQ0l4bGJYR0k3K1dnUlNWWlRTTmZxNG8y?=
 =?iso-2022-jp?B?NUF0aHZNNytpTkhOWDB6Qk9ZSzBJMEdIVmNGelZKK3VIVXVMdmlETGRo?=
 =?iso-2022-jp?B?SDV1UGZuTUErSUFjRUEyR1h4V2FTazZKeTJDRzJKdzV2a0IwTXRmN09E?=
 =?iso-2022-jp?B?QXNFNTI2MzRrV29ycVBtZExGQXN3Nms5YStqUlkxczlaWXVJaFo1K01s?=
 =?iso-2022-jp?B?QTZMQjg0NndaeVA0d3JDTExqSXRicWVZWVFYZkdJRzR3RDdmdXJJSldX?=
 =?iso-2022-jp?B?aW5mLzlEcktUZ1JYYlNJcmVvbFhmS1pYU3V5TnpRTzd2a2NVeDY1S1py?=
 =?iso-2022-jp?B?NmxlYi9leFd2NnU0TzZqS0Y0VVJnNDhLUTBrcUovYnA3UWRpRUpiNE56?=
 =?iso-2022-jp?B?UDFKbDhaN0krOXNQeUV0OTNWYU9HZkxVcFlLbGVKUmhOZDFuWldsYWJW?=
 =?iso-2022-jp?B?UmhRUTZ6TnJDMzhuUzlZWWwxRExIekNONGh6RGtMODVKMmZEWmxJRzhz?=
 =?iso-2022-jp?B?WXRxa1RIeUpVWUVyb3BVeFV4VHR0UHBnaEtPeFVJL2ZtZmxHRzlCUVBG?=
 =?iso-2022-jp?B?V25iVGczRkVqbjB5amw2a09YQXlMdnFKWkJ2SzBKV0pFanZhOXJTTjVE?=
 =?iso-2022-jp?B?ZWpJTWVFWUYwZUFpcG1DaitFNTdyczByajJvZkk5NWRFKzdVSlRYcTNm?=
 =?iso-2022-jp?B?aEE0QlZUNzJ4WVpWcTlHbVhRZmRoR1c2WUZjRkE2a21BTE93bnZaYWdq?=
 =?iso-2022-jp?B?L05zdVh3eDNzSG9vRDNybklXdllndDRHZHAxeHBYSDlVdUIzMUdNVWZj?=
 =?iso-2022-jp?B?M1FWNlhNNUtyWTlIM3Q3Unc1UXhlUkk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c215M0UzR0tYdytVc0lCaHRqUExIaGw4SkNma2JqOGJIV3JWakw1T29y?=
 =?iso-2022-jp?B?QUZaNkZlY0tvNEZ1YlhXYlRHaVRnR0pEQTBkQTNzV0RDSGdwTGxtQ3ZU?=
 =?iso-2022-jp?B?L2t1UkdIT29Fem1uQUdUcm0rc0djenZtSEwwbkhSWnZnWXg5NW1nQjF1?=
 =?iso-2022-jp?B?NkNzTGdhblA3SFJhdVVwZWNDckxOMDdzd3ZpakNRdytiZkZFSkd1bkV0?=
 =?iso-2022-jp?B?THI5L2orZElqWEc0Sk9qL1JpbTdoVXdpV3FDZGEvOVdzUnJPRDZmd1Fu?=
 =?iso-2022-jp?B?blJsaDFPRnRQMDVLc0tDSmxpNjkxOWx0R2RYUlJERmF4aWRmZk1lWDNv?=
 =?iso-2022-jp?B?TFd3enhkODl3Rm52dzR5L0JJVVd6NStoN1dxbzNhUlpmcUNadGswem9V?=
 =?iso-2022-jp?B?MGsvdk45czM1YXErTW9iODJmQU42SFVsZlFyVUc4WHZKTkpNRngrejkw?=
 =?iso-2022-jp?B?VTQvQnNHNmFFWWk1NHlDRGdwSGpzeGVXb25sUFN6NUJ1UzVzZjR1cmxt?=
 =?iso-2022-jp?B?TWdkSGVvbDdzUkJEWno1Nk5hQUR5MzNhTFpkcEdTdUJ0M1o4eXhTbXU3?=
 =?iso-2022-jp?B?a1FPL1d2RU5BYld1aUVMMTBQOXNLcWkvWVE2Y0pIeDJHbjRhZzZYcHJz?=
 =?iso-2022-jp?B?RUJoeE1pc0xISnFnanQveUJEd0tNeFFRMG9zeUtmQTJ2cUNkbkkzaEN6?=
 =?iso-2022-jp?B?VEV1TTNPYllmUkRPdEswUjVEMXRXOSt6a3RMSk9MTmxrSjFmRm5NcGpa?=
 =?iso-2022-jp?B?aXBXclk4RTBsWThma0lHSlVraTRIZFhPam1oamIxRGk4azBTTmpoTjNL?=
 =?iso-2022-jp?B?QlZDK2g5dWdIU2d0cWYrSFZSK1hIZ1ZKRXgxYlcxb3MvUEhvRjJqMlpB?=
 =?iso-2022-jp?B?UTNOYlFCNlNQdkVqNjRQNmNwL2o5eXRsUndzcUtrUXF1TE9VL1RtMHdo?=
 =?iso-2022-jp?B?bW5NTHMvdTdFWno1UzlCNG9xbTlIV1FtZWh4NGEycXZGcWlJTjN2WkxJ?=
 =?iso-2022-jp?B?RWlqMUlSN0RqTVJBK0JnV2Joc09EQklFRWRPcll2bHRRRitJT1lIY2pV?=
 =?iso-2022-jp?B?SVpSOHRCdHlReGd5UUROd3kvVURVU2ZXYlJIMzRpNkZCT09lMGhudWl5?=
 =?iso-2022-jp?B?NVNDZXFzdDVTa09yZXJreVRGUkUzYmlzNlkvd2wyQno4d25YVFhVayty?=
 =?iso-2022-jp?B?UkRJeitCUFZ0WC9ua2Uwc0Z6UGV6Ty9HcVZINlN2NEtTYWZES1kzdEFl?=
 =?iso-2022-jp?B?L1BMNlY2RTZac0xuKy9IenNGNEtYQTRxK2FvN0JJeCtZYVpIN0dJaHQ1?=
 =?iso-2022-jp?B?UHJoSTBMNTB2eGhNZGl3NWVwUXBOc1kvZVdkMDRjM3BYWlM2ais4M1d5?=
 =?iso-2022-jp?B?QndISElDT0tYQ0loZ2JkR1FtYnNXcHhVLzJqcTRTZ2gyeVN3bEhreWox?=
 =?iso-2022-jp?B?Vm5IMFU0b0FSUzZJSEZhdkpvanZKZVd6Y0M3THBTYWJxMm03MkcrRzJq?=
 =?iso-2022-jp?B?K1JFSjVuUHBoZ3d1YXp4SHVKUlZqVTExenRJTS9aUTNPcmpJRFJFZGlw?=
 =?iso-2022-jp?B?aDJYb2RiZSsvUVQ4bVRJdFl6VnBsQ2dFcEFSekgvWWVmNWhuTk9nZCtQ?=
 =?iso-2022-jp?B?UEd4NmhqYXMvSHBjbnBZYVNJNXhpbmhyeXIvRkZwN0JZczNmSkd3Nk4z?=
 =?iso-2022-jp?B?L01PRTRvdGJ5Q0l2TDJXNkZzT3NvWWF3S0Ixb0FFYmMyU2ZwcmtrcTQ3?=
 =?iso-2022-jp?B?MkdIVk0rVTAvV2YxcTVLaVpnWEJzSGNrZEVrNG5XQVdTd2ZwY2dJRVh3?=
 =?iso-2022-jp?B?TFQ3dC95aDFoSUgyei9nOWh4NWJQazBybzE5YnpIb2Z5RjFzWWZZU2pM?=
 =?iso-2022-jp?B?bVpHSzR0LzRWc0RRK2JseEtwcjFHRktwZU9waTBFUmdOc21Ga2dJL0kv?=
 =?iso-2022-jp?B?NCtFMWVGdXNvNGk1SnA0MmNhU0RsZWgxdXJIN3daTTkza29MelEwQXcy?=
 =?iso-2022-jp?B?dHU5UC9tRVBQQVNQMEVENnVCaER6UndJVURSbWdaYUY5a1p0cENUdHZU?=
 =?iso-2022-jp?B?N0hLUWVZNmRmdjA4OVRBaXpjSkY1ZUpkZkdBYTF1bCtEYW0rb1BKRkdj?=
 =?iso-2022-jp?B?M3d3S0ZQNVQvaDRWWkJNbzlUTEdrK2dEbHdpcTY0V3AxRXJ2aE9UNmtx?=
 =?iso-2022-jp?B?d0VoeEV6a2ZwNjB1YmdHYmxTSG1zc25kN3RnMzkzcjVEM1ZZeHNuYkx6?=
 =?iso-2022-jp?B?N3VKUGxXNm05ZEVrM244Q1hPOHZrS0RicCtZbXRKOFk2cmc3ZmdXQnVL?=
 =?iso-2022-jp?B?cWdkU09ST3MwTWFpU0pVS1gvQTVKV1dQaWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56655cb-c1a7-4069-cbac-08dd1fb20c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 22:19:32.7791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AKxSQOGmTBt8lzQSjHlsrgYJT6s0tXBqN9t66XQIEAUaOiOha61G0+qO0pfrFOj8nV+akrvQ0O/2/bR6WDNUGcpTrwKmj9FkeptNC2WIEvHis/Y9utuj+zUMkP/tcPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 22:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17470

Hi all,

> -----Original Message-----
> From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, December 12, 2024 3:15 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV clk
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit dabf72b85f298970e86891b5218459c17b57b26a upstream.
>=20
> While computing foutpostdiv_rate, the value of params->pl5_fracin is
> discarded, which results in the wrong refresh rate. Fix the formula for
> computing foutpostdiv_rate.
>=20
> Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/20241024134236.315289-1-biju.das.jz@bp.renesas.co
> m
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-=
cpg.c
> index b1952d2ee8c2..379292eb6fb1 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -556,7 +556,7 @@ static unsigned long
> rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
>  			       unsigned long rate)
>  {
> -	unsigned long foutpostdiv_rate;
> +	unsigned long foutpostdiv_rate, foutvco_rate;
>=20
>  	params->pl5_intin =3D rate / MEGA;
>  	params->pl5_fracin =3D div_u64(((u64)rate % MEGA) << 24, MEGA);
> @@ -565,10 +565,11 @@ rzg2l_cpg_get_foutpostdiv_rate(struct
> rzg2l_pll5_param *params,
>  	params->pl5_postdiv2 =3D 1;
>  	params->pl5_spread =3D 0x16;
>=20
> -	foutpostdiv_rate =3D
> -		EXTAL_FREQ_IN_MEGA_HZ * MEGA / params->pl5_refdiv *
> -		((((params->pl5_intin << 24) + params->pl5_fracin)) >> 24)
> /
> -		(params->pl5_postdiv1 * params->pl5_postdiv2);
> +	foutvco_rate =3D div_u64(mul_u32_u32(EXTAL_FREQ_IN_MEGA_HZ *
> MEGA,
> +					   (params->pl5_intin << 24) +
> params->pl5_fracin),
> +			       params->pl5_refdiv) >> 24;
> +	foutpostdiv_rate =3D DIV_ROUND_CLOSEST_ULL(foutvco_rate,
> +						 params->pl5_postdiv1 *
> params->pl5_postdiv2);
>=20
>  	return foutpostdiv_rate;
>  }
> --
> 2.43.0

Sorry for the delay to review and reply.
I reviewed this patch, looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


