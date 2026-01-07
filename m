Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887FCF6C05
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 08:17:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1569.1767773869414906170
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 00:17:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=U1c4ass+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767773861;x=1768983461;bh=Jk6FcKNiFkRSldJKweP14xOiBuJoYtOyIGKOH
	rker1I=;b=U1c4ass+lVG7YgV+d3xdqQy2hvTmJ2MJyFPelLil5DAjM4q0IFAccSctmK4JFDmIzjX
	4l4Yw8tRnVT5+lPWWPs6RZzkfpSqlZVYJFnFBQBlqGd3UAbZGZU+gt8mQho/pd48iR5zgbHDKUyY4
	xeC8g2y6WYUq5ODUyB/2xY5AEBD4EXVrPtJe7Uzgn0q6jhswnwF3L1dS9lX1UDGRnlMkRwJXO4qd1
	Fh0iZLBITU6cMOLMXDQ8ge8ItXVFoZAsulLkSKp3BgaydVi01Dl7nq8OVSIeL9XsUb2cMKYrifnzQ
	oztmjkSSj2orH4gsIYuAWMOadXlSO8LZfjWElUcjhq9w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6078HeGo476113; Wed, 7 Jan 2026 17:17:40 +0900
X-Iguazu-Qid: 2yAbRTn0jRNQWbwFYL
X-Iguazu-QSIG: v=2; s=0; t=1767773860; q=2yAbRTn0jRNQWbwFYL; m=+HD6aozkYzEQjdxaXZ3pH/PXIfbpAjeKPTSgxyf5zDM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmLW814j5zyPc; Wed,  7 Jan 2026 17:17:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZlPuGGV3IgCFKlzOfHfmi5FEXgBTUOEvGbIogyJnECCUKbP8xo8do0ysaxGV1LVGsROyIYn0+AWhAOKI2I7vO/dR3zJLVNLCXvfS/hf8eYNHw2O21Ymwu3NX9dzLK2iQPKhK1YVMNNWZg5YETX9q8JxHgeTORpvdNyuLlBf8YIZK1UhXTfgzeApmrS6HvxoO0IrkRZhqqyppg6pT8NYPjsYYGQDZsOs/8zR/gDrB/MjvG4fcyZJTgbFNzw0Z3rIRo26S9+snw7e7Hc6eg7gNYpnTZKdxYmfAUqXGbEm4aAkYljev5SYAsTQ3mnaFdIhPe3f27rvbnMkLQZ4AIwhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQK7vvNNN0fBqmaeGINR/ZGnzHv8H5/Ur/VDT0FvpHA=;
 b=X2bdwWzXyndZGGBIKpnEJHLOdHt+0ZgOxoEtQOSmBS5Mjaxz0kCw/01c7tg/CHHFpWyjS4NtKzlD14/TYXngR+pDGJ98cD28Qy8P5rLItPezV3VOnAGhSbIppiHV4eZqcCpxcbiZNVW9n97HKxkA77eEmpXsMjIJtVRs3KeWzdy98reB291AN6iDO7OTlTB18eqloh+fgDgdDQPyBRLcbEy9zNOkKCtwQ6ILKumrEnW+FKVuXf0v6h6z9kd4S4tPoeEZYF7AA1Bz/VcrBb2nv3FK8kh53aKuGmyFDEoUHeBU0/EHBu0GecO1qB0STYzJiv/gt6eQ171J//8q/LxbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 0/3] net: stmmac: Fix EEE-related issues
Thread-Topic: [PATCH 6.1.y-cip 0/3] net: stmmac: Fix EEE-related issues
Thread-Index: AQHceJ68rrsjy7x1m0ylIEJ9Hy/9KLVGaYDA
Date: Wed, 7 Jan 2026 08:17:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181A626CDA705EBDB0ED2DCD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB16003:EE_
x-ms-office365-filtering-correlation-id: 1086e758-573a-42b3-4ce8-08de4dc53815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VVZsZVRwWW1zMktmbW96dkNvd3k1QzM1cXBVR0xwY3MxU2pqdENwa0cv?=
 =?iso-2022-jp?B?VmpyRXdyZHYwY09rWnErYkF1R0U4RXpJVnRWL0llQ2lhcTE1T3kvZlR3?=
 =?iso-2022-jp?B?Y05EdEtpYjVmWnJTUStOZms3VHo5Z3hmZWpPalo1L1F5dTNiRWhGendu?=
 =?iso-2022-jp?B?QzA1czk0d3c4aTRZQS9pRXNYYzBrZlBpbHdEd2lZc1doRDNhWXhTeVF0?=
 =?iso-2022-jp?B?WklmblluV1NlUjNVbFlVRFpCZ2VkY2VMdEJ6K01KTFZDTDZKVWp1a25a?=
 =?iso-2022-jp?B?bWtRWGI3WjRqcXE2N0ZwNGhSQ21YQkFEZDdzNWpOcmxUOWl1U1M5ZDZn?=
 =?iso-2022-jp?B?d25VRjBzcDBlWUtteVQ0cGp3eEFtaCt4KzUzYzJ3VzBsVUttZ0l5NlJl?=
 =?iso-2022-jp?B?SHRZNjFPQUpCNnRzdzkrNSt4Z1Uzd0R0Wm1JRWRwblU4MDN4TW94Q0dG?=
 =?iso-2022-jp?B?QkVmTXNGWHRYSzE2bWJKZEt5bDNmMjFMQVdWWmRLaWxVclBpODNveDVo?=
 =?iso-2022-jp?B?aGVya1llZUtmY1AvdGI0dFd6YTRvMitFSlpDOUNKZklRc3BkMW1Md3Ni?=
 =?iso-2022-jp?B?U0MrK3ZGTlNWYUxYVEU1WFc2blQ4YU1QZEx2T1U1S0NCVjdQNzBaZzJW?=
 =?iso-2022-jp?B?MElWMCtNNlVBTmZ3ajVTOXhFVEdzSXJUb0hUaW5UOFVDYkpXRndsUjR6?=
 =?iso-2022-jp?B?Vi9UZWtPQmVDMHRsU05DVHp3Y08vMTZHZEtidkJZMzBrNS9tWU5JdTA2?=
 =?iso-2022-jp?B?ZFRhMW5xaHZNb1I4NTRyYU1tSkQ5SlNKeUlPZG52UUFxKzVMYzJpWVUz?=
 =?iso-2022-jp?B?YWYxRVZqY0MrVmI5eUoybitTU0pwR3d6aWc3ZFV4NjZtRC9VUlVVMkdq?=
 =?iso-2022-jp?B?V1JNWk5aV0tnMGtoQWIvL09JMHJKdzREZnh6cjJ0VFJiWE5yeEpENHVT?=
 =?iso-2022-jp?B?R0tJMjJoT2tmN0ZjT3c2c3VhVi95Y09GT1NyYkV1RnZaMmVVQ2UydndG?=
 =?iso-2022-jp?B?R2ZEZ0dITzRkNmtROWRXYWdRWVZpdW91VW9kZlZiTFhvQ0FqRHZPYmpt?=
 =?iso-2022-jp?B?SG9DKzNIaFc2VE40TkNOd1hhM0J5RjBXVzhjT2JqeXRqbytuNXA5ajBK?=
 =?iso-2022-jp?B?NTJMaVF4YmY5VEZta1JJME1rNEFxcXliaUkxejhJazhjRDNHZ2NINTdP?=
 =?iso-2022-jp?B?TTlGTVVtUmtIY3FxSTZkSWRkQjgvSzFpakZEa2owNnEyVG96TmtVUkRY?=
 =?iso-2022-jp?B?dFNGb1IxemVhLzRvUW55ZmI1a3VoZi9UVXhJVmltckY4QU5aQk52algx?=
 =?iso-2022-jp?B?SzVkQ0pkU3BxelpQUjhYM0pBZkhOQ2doRVFNc2drbVYrSlBXVnRWU2dt?=
 =?iso-2022-jp?B?bWtJeVEwUzVBNWxkbERpRkx1UHoybUFudTFRb1VPWnNFUDdzRmo2dlpO?=
 =?iso-2022-jp?B?SEN6eHBZT1o4S014NEtLY0tqSmc3WUo3eW1jSkZiUzlHZXlBMThuN284?=
 =?iso-2022-jp?B?YTRlSmJaMVJ0d3ozdVlNc3ZWWjlmbEJLU2JLYVF4V3BTMStlQUFieG5p?=
 =?iso-2022-jp?B?YnZGT3pWNkxVUzlURHhOZ2NJMnZqM0dJeTFpL2lnSjdTNVRQMEh0VHpI?=
 =?iso-2022-jp?B?U1E5VStValFYcG85ckxSY2JjOUtETnFIVWZXTWFSbHlKaUQzcFQveGE4?=
 =?iso-2022-jp?B?RnRsbFhYbE1oZy9BWHE2dGJ6dVhaakVMNlNzNGh5WFd2MFpCcjdvZUIv?=
 =?iso-2022-jp?B?aHE0bng5SGtMRmpaNjFJdmFYTnhZV0FxejRtazZLWGRxZEplZk0rMTB3?=
 =?iso-2022-jp?B?TjBab1JSUWJOdlVkR3huRVRBcllFVFh5MTJuVlVtYmpmWWZJYVJHWDRl?=
 =?iso-2022-jp?B?WVhmZ2dCdWtnNmtPS29IOE5ZUVdoT3JkQ2xZWGt5RXlXbzRROC84QklN?=
 =?iso-2022-jp?B?N09qODEwd25iRjltOUkwQjFBSy9vNk1LVDR5MFJoOUdwd05DYjV6dGtj?=
 =?iso-2022-jp?B?S085UkxMWWZkR05wS3NwbjR1UlJuK2VsRCthRDlNRUJvNVBoeGthU1di?=
 =?iso-2022-jp?B?Vm1yZkxwRDJkTngxRnZSdlcyNWpPbmREc0JjeE8xV0M0SzNSRThsUS9O?=
 =?iso-2022-jp?B?d216UE0yaWIzZnYrOXVLeWdiN1FBSTh2REFya1gxMHUxaUVkalRUOWc5?=
 =?iso-2022-jp?B?ODd5YzZNcFh3alZYUE1qSGZRVzd0eVl2?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aVQyVExud21kcmNwSE1mczVzaWRuc3g3QjRLRktOTm1UOEN2SzU3MWJ0?=
 =?iso-2022-jp?B?dmY1NHNVWmF1RUxnZmowbHVGT3VQTTB0YlhQRXBONGczYXVxSzVpMmxx?=
 =?iso-2022-jp?B?M0t0TTZ5c2l6THJBbmJwVGNwdDdEaEtaaTJRVVdIRkFJaG04bG5vMThz?=
 =?iso-2022-jp?B?YVNNT3duR01zUHlVMm9aVHVpZnVOZzBpWkVuRnNrSnF0VlI5a1ZkNENY?=
 =?iso-2022-jp?B?bzFIaWg3ekFUSTlxaHB6ejE1bDF5djhjWHNZK3NFZDVTT0ZRUW16ODFE?=
 =?iso-2022-jp?B?dlZvL3VrbUs1Z25uL29tZzJjekNXT2lseHVhNjZRK252L29saHdCWFU2?=
 =?iso-2022-jp?B?VXo4RlVySjBhV0JjMmEyVEplVmJmUHdEUlpXbkhndTk4dTBubitob09w?=
 =?iso-2022-jp?B?Yk84WmRwVWhyenBBeVFqeVdsK2NnVTlvSndVZy80SjhHMVRlRThyU2NO?=
 =?iso-2022-jp?B?eGl1dTQydXZmb1dzYWFqQXBpOURJWGpQUmdtMHVGQnppcmVES2YyOUFp?=
 =?iso-2022-jp?B?TkdUM0dnYXRURm1jOE45NWwydGtCVmRNK2d0c2JBMERISHB5SFFOWmNw?=
 =?iso-2022-jp?B?M1V3eUJmRldZR05OSytUb0ZFeUYvZE9Hckk3Tnp1d1RSV0V6MnJvVERM?=
 =?iso-2022-jp?B?dGZkSzdyUlRoeTlXZUY2N1FmaVBSbXpSa2I0aDUwYTVBcGlZcmswemdo?=
 =?iso-2022-jp?B?Rk53c0ZZemNzcjdhcVdXa1JqQW1oQVRNWm1URG5sbys2UWV5bWhncHpU?=
 =?iso-2022-jp?B?eFBITWorNkhHVlVHUGpYTW82UURFeEhBWWZRb1BteFJrc3paQU9JNEZG?=
 =?iso-2022-jp?B?QVIxZEtBUGdZRHNPbFBlZ1k0bXZlR0JxN0lwSHdNVzNqSHcwcW90TVA0?=
 =?iso-2022-jp?B?SkVYV2N2MFFJV2JwSFdKbmtRQS9hZm53aXRJRW5IMmxWeG5SWkN5UjNU?=
 =?iso-2022-jp?B?QTRvT2JuckhFWVpHVTYwUTdJNXhkVmZVTUl0NjBHOTRxQWtXQ2pHOHVC?=
 =?iso-2022-jp?B?Vk5XRnlnclJTZFlQL1V0NHJ2UGhRODN2Uld2YlNpWG5iNHR0MHNQQ3lN?=
 =?iso-2022-jp?B?R0s1MG5CV1hkSWFnSG8zTjByWEhqY2t5VUUrV1luL3laWGdmUXJ4ZmxL?=
 =?iso-2022-jp?B?S05PamJiYVVQVUdnQUwzKzBJYWNwSXAxdWR0SjhFMFl4NjFRa0VvTElW?=
 =?iso-2022-jp?B?bk1qTVdXMUd1eUpPSzhmcHA0Sk5sQ1lmTDlGTVBwb3NCMURBUlAzV1d4?=
 =?iso-2022-jp?B?WVFXZHQyczUzdjdKVjFteitYUTZpYmJ1aSsxSmhmMTRuK1NPMTJ5R2Mz?=
 =?iso-2022-jp?B?Ry9BR1loTVltcUpKZnF0MXhtSlROUGZnRFUzVlM2K0srS2Zaa0U1MU40?=
 =?iso-2022-jp?B?NWt2YWlDTElMUTk4cnN4MFJBY2ZNMzluS0tYN2tnWEI5SGs4WVBseGJl?=
 =?iso-2022-jp?B?WXV3elFOb1lQV1hqcDg5WW50QTMrOWRIUWtGSllpdC9mMmFjR0JYV3hR?=
 =?iso-2022-jp?B?Rm54bi9mL1E2VGxBZ2x3Rm5wL0FYOXdFOFhoL21kemwrYjlSRmgySndO?=
 =?iso-2022-jp?B?MXovaFRGWjBwWlZrUC9GNkJ5ZTNFMmFJd0dMdGNRSmFmQXR1SUpEbStD?=
 =?iso-2022-jp?B?L1ZyYWVaMHNaRDdMK2psY0RmckZOaEQ3R1N5V1Yxdms0VXpGMjltRmJW?=
 =?iso-2022-jp?B?eTNpd2dyNXRkaUk2blVHeGxOc3R2eVZBS3B6Z2piY3ZTd09kNnpwOHBq?=
 =?iso-2022-jp?B?TS8zNFJ0VVRRZkYvQk1BWExKQUR4QzQzUWNpU3ViY2ZTRkcyNVozWUgv?=
 =?iso-2022-jp?B?RVRES0JtS1l5Y0kvZlVxNjcwMVFab29ENnQ4UEJhclN0RS9RaCs4RUZz?=
 =?iso-2022-jp?B?aGNHTjc1R0dvTVRWUWFPaEhpZ2swakxSdjJqb1NEZjhEWEVoVDZiSTZ2?=
 =?iso-2022-jp?B?ZWpMTm5iNXpSWVh6UXJ6M0wyeGFCNVI1TGE4SVd6cDNaZWRVd2RkWW1i?=
 =?iso-2022-jp?B?c1BoUDVNNGdwbDk3TGNzdzhwNVdLMmpRY2dTOVBBbVZHaEkydlhxbUlz?=
 =?iso-2022-jp?B?d2JKYW9sYU1teElvTWdvWDVoOWcrQnY4OE05TUF2NEI1Wmt3bGk1UG1B?=
 =?iso-2022-jp?B?dlpibTRkWUlpYldlMWoxU2dORWphNGYxaU53Z3prdHcycWJoUDNjN255?=
 =?iso-2022-jp?B?RmpoVGd3UGY1ZEErMk9VNlF1bjU5YmdpditLcUFFNjYvU20zbmphU1pT?=
 =?iso-2022-jp?B?d05HWEV5SUFWTEd0aldJdDkySUxpWnNEU1drbkdRUUttWWxkTkJEdzJF?=
 =?iso-2022-jp?B?Y2t4NVA2OE9EZmNDNlBrNCtxRm1iWURWcWxoV3hSUmRrZndHNTJWQ0hR?=
 =?iso-2022-jp?B?OTdpYTZUK0tnM2JDOTFzdnVPdDFoVzBkTHdaUjNUWnFkbkZ4TVhrZ1Fz?=
 =?iso-2022-jp?B?V0lodTVxUXNUVnZFRmpTZXB1WFo4WklYOU1ieEpwSytwNDdWdExpNUQz?=
 =?iso-2022-jp?B?emhXeW9XaHZKY0FTOHd2MzVXbjRHSzJwb0p0TitSY1RicTV2eWVtM1JH?=
 =?iso-2022-jp?B?Tk9LNFBGMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1086e758-573a-42b3-4ce8-08de4dc53815
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 08:17:37.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdV70H6zGRC2j0l9LVezyKe9lC/AJOa7PjEEUUJbskrCfdtX8ORJEgN0gxNJdOaj0B68OCpUV2xFoGfsdJMSZHwi+9IdMMO1/FMMxjF1s+cGhaP9bVhLmiJM78C6qYB3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16003
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 08:17:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21398

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, December 29, 2025 5:40 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.1.y-cip 0/3] net: stmmac: Fix EEE-related issues
>=20
> Hi,
>=20
> When testing Ethernet on the Renesas RZ/V2H and RZ/V2N platforms with
> 6.1-cip, LPI interrupt storms and VLAN register access timeouts were obse=
rved.
>=20
> Both issues are caused by the RX clock stop feature being enabled by defa=
ult.
> When EEE is active and the link is idle, the PHY stops the RX clock to sa=
ve power.
> However, the stmmac hardware requires the RX clock to be running when
> accessing certain registers.
>=20
> More specifically, VLAN operations fail with:
>=20
>     # ip link add link end1 name end1.5 type vlan id 5
>     15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>     RTNETLINK answers: Device or resource busy
>=20
> Also, LPI interrupt storms occur because the RX clock may be stopped when=
 the
> driver attempts to clear the pending interrupt. The interrupt is not clea=
red and
> keeps re-triggering until the RX clock resumes.
>=20
> A comprehensive overview of RX clock related issues in stmmac can be foun=
d in
> these threads:
> https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideas=
on
> board.com/
> https://lore.kernel.org/all/Z9ySeo61VYTClIJJ@shell.armlinux.org.uk/
>=20
> These issues are already fixed in mainline. This series backports the rel=
evant
> stmmac EEE fixes to 6.1-cip.
>=20
> Best regards,
> Ovidiu
>=20
>=20
> Ovidiu Panait (2):
>   net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
>   net: stmmac: Disable EEE RX clock stop when VLAN is enabled
>=20
> Russell King (Oracle) (1):
>   net: phy: add configuration of rx clock stop mode
>=20
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  3
> +-  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 ++++-
>  drivers/net/phy/phy.c                         | 32
> +++++++++++++++----
>  include/linux/phy.h                           |  1 +
>  4 files changed, 36 insertions(+), 8 deletions(-)
>=20
> --
> 2.51.0

Looks good to me.
I will apply this with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro


