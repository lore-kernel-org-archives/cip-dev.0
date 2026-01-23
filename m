Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4FD7237B
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65751.1769168775699130780
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jan 2026 03:46:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=jjbNaOcM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1769168759;x=1770378359;bh=
	mZYVownqkTdRtLoygNOiV57fbbyBqyM7rlNbpZgmN/Q=;b=jjbNaOcMtynnMpyxw5CqBUeMD0pCep
	czewUX+qMAyXQ7FLCc5L9fvsponWXv5mFr6C66tKcfrpz2i6atEiofdEkDmOLKcx8EJdu0tRpPzwU
	FyLyHO/L+/MauADmvYdcvh/Nk9xXV0Z5lAnP7f78naN0W1kchmi9qJjIuenu8LJ5+6wZ23kpSaq0l
	k+7lK+Ip+kles0P/kyGenq3t/P7Xx4HEx+5KqnoNbhQJ43mEuu3zWnQrCn+MYdFeaE5Bopb5RTkV4
	//+mOn75DnCwsHmViTnQdcbhsr+jG2I0NKAq5+O7GekVN2oVq3cUafyXmk3+KOfB//tiOc1YYX2Cy
	gi0Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 60NBjvMB128934; Fri, 23 Jan 2026 20:45:57 +0900
X-Iguazu-Qid: 2yAbM59mtYz4FKfDc0
X-Iguazu-QSIG: v=2; s=0; t=1769168757; q=2yAbM59mtYz4FKfDc0; m=7EvZg2ruFrUx7FDQKxKrRD4iUpYsHGq67h8SHmn9di4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dyGN36tq7zyPQ; Fri, 23 Jan 2026 20:45:55 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQM4a3BMZP7njWVNfnJcJPYlnOEWF4zkVfd+dIuTWTifP7M8hjjlZNm12H/10NyQE2OZKXreK3bbiBZ5OUPolCApCDC8axjvRhxto+1Ctdy8Ab0j7YHwjJzpCJuKGncjEnUzXIt9P4fKQ0zCSUKLJGX4xpMQWFjNQzM4Cypu0dSPxfFf/2DDYOZ+MHbPW6+pVXNZBB4wpaRMIKFmaMWMStr1MagXhQiRLQqR3AQLp7RECaPOUIupID0DwzEcIiU58drCA7NeFykG+r5TrBw5jg5lvqjvfQyfGy5u+NpdJVBV6MLYLDCbcNNH18/gKallI0ftIEBnbtgjPM8kfzaU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H60ttEQIH6d16hq1KtG4+5VNpunSHnNfS3Q9bTKK1cw=;
 b=d+XFGEUPrUb6uAJi9UcRH+td8TOOq7ETt/1s/bcQjwdznIL4vn5iHkeUGGItLHDI8exh6M7RkalZdWCcg1ITdCd4bYpxIRuR6ae5V5kyn7wC4Xv7ZyMVAd4sR6vNub3NwGQT+aTgxIvuLYTnoY31aa2sA2sUZIt2J3kPhkLlj+NzNw2gKryaPstMCprxKF1Xc+T1DvQrb9R/zKAa8bEe0Ic8Z3mXL7Wl5ixdZ4Lq/DIpZi4JJQR2wWrgaLe6TP8KwunjWM3SNXnCSz6ld+x/z9Msuj1o/WG2ItXnNm8aqQjCrKLrfdeYJXr0+V1Jm2jHZ9ijwX5SOh6bXAcwvXbnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.66-cip16
Thread-Topic: [ANNOUNCE] Release v6.12.66-cip16
Thread-Index: AdyMXW0GdlqLcYduTXW2M7kFrraL8g==
Date: Fri, 23 Jan 2026 11:45:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB148085B183A14D61DA1E634C7CD94A@OS7PR01MB14808.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|OS9PR01MB14042:EE_
x-ms-office365-filtering-correlation-id: d5ba4c91-66e6-40ce-812c-08de5a74f5dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7142099003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M0ZpekJzMm9HbnpOYzBYWUVqNVQ3SFkzVmJ4MXRKcERhK2ZodDRraW1J?=
 =?iso-2022-jp?B?Y0h0b3BJbHpxbGpuNldOMDlLUjRKWW5mSjRLZVZrV3VQYmdFS3FqR0dh?=
 =?iso-2022-jp?B?Z0o4N2hrOWxKSm5aOXdYYmtrbHpvZmt4eTIxa3pFcDNGKytLNVo3Uk5O?=
 =?iso-2022-jp?B?UHoyRC9XbUdGUzhkeC9kY0syL2lsVmFlWDJRZjdSMzRheVJISVpTT2pO?=
 =?iso-2022-jp?B?Q3UyYTNMRHd0a2xIMnZ5RXVnbElJNENkYjh3ejdOcXczM3hWN093VHdz?=
 =?iso-2022-jp?B?Q0hkOWgwbHBDV0pnT0xrVkxLNjQrTTVVSWhYenJXQVRDNzl4WW84TUR0?=
 =?iso-2022-jp?B?eEpQbXZZZ2hmTy9ac2poMDRZcHNTendySzB1c1FnU0FYZS83ZUkxckxq?=
 =?iso-2022-jp?B?QUdNZ0E1NVZYTG9jOFZwRXczR3dsWDhJMEpoQ0lKM3VGRzFlcVZ6TWRt?=
 =?iso-2022-jp?B?WWhYMTh5SGowa1FUK0dMQXZYcm5HelJRUU1tc2tsK1FhUEJYdVBzb05t?=
 =?iso-2022-jp?B?TXJBRUIxNFJkbWxWUGk1b2EzQnc1d01FeXhTQ0VBaTQxWUgvR041VXdP?=
 =?iso-2022-jp?B?dU45Z09oQ01PeGtqVXVEK2d0b1lMNTAwREhBRnA5cnU4UjZLdTdXeGEw?=
 =?iso-2022-jp?B?SE1XbzRZU1dEYzFXWGJqVGNYbFZSNmhGWWxmYmhkQlZJeFd2Nkd1RFJp?=
 =?iso-2022-jp?B?NjdoVVhQU1dTdmpiajNaajRBcTduNWYvT2F1N3ZZbWM3YWhoMWhucXFh?=
 =?iso-2022-jp?B?V2NpemF6UHhUdFNkK2VkZlVCY3p2NUNhSzBDNnc1MjNGSWFVUzVRbFBy?=
 =?iso-2022-jp?B?K1hjZ1ZORDdDNUNzcnZDeEhua3U3MGp6ZUdYb09YWHlJZjUvUEd0U1ps?=
 =?iso-2022-jp?B?eFlxcEt5VG9RSHZWL00xcEVEMWY5KzJJWXlCcy81NkNtUXNveWJiSnpL?=
 =?iso-2022-jp?B?UFNVUFV6UTZnOHFhTzFnQ3duVHlTRGpRQzhramxzMlNlVHhNK1E2Nld3?=
 =?iso-2022-jp?B?cEhqOUxhdE9YRE9Rck5UWHdpcUxVd2FrejVvSTZBcGFZa0N4aHBVYnk0?=
 =?iso-2022-jp?B?eDNZNTVScXVFTURhUC81MjRkYnIrZmxwT0JiTm84cDdWZEsvczFBdnN6?=
 =?iso-2022-jp?B?bUN3aFVpd0drdE42eDZQZUliK0tFVmNIenRYNWNvZGlYWmNLZm9TZFY1?=
 =?iso-2022-jp?B?V1ZKT1d4TFNTWjB0bktQWkkyK3NsZkxZRHB6ZFVmalpmVFVtRmx3YTBO?=
 =?iso-2022-jp?B?ZjRPOTdObXVjMjZKRGFSYzNVTDd6aElaR3R5bkNpbG9uaDZtNzk3NXNZ?=
 =?iso-2022-jp?B?YVdMaVk5TDFtemkwcHlKMVZ4TkpXUy9OTjR5OHRORkJkQzBRSFYxZ0pL?=
 =?iso-2022-jp?B?RWRHQWdsS1N1RmcyeTRGdlJ1bUhGNjAvNDdGZWJqUHhPOTNJWHZuQ2Iv?=
 =?iso-2022-jp?B?aUo4QWFFMHRjeDNxbVdSRG94d1kyd3o2TGJEUERqOGFINEdtQjcrNGlR?=
 =?iso-2022-jp?B?d2U0SlNzM2lWMnJVaHQ5aFkyMTRhWnpQVURjRjJzVGpsWk1RTUdHOWNW?=
 =?iso-2022-jp?B?M2hWWElHNGJMVWdNbXZTdzFIUkxCZmUrdTcyZVA0M3drSFF2Q0cvY0t5?=
 =?iso-2022-jp?B?TVdRb0N3ODZKZVBST2VoV1V0bmkrRXQ0Rkh6YU9LK0dwMUNUTjNjWlBx?=
 =?iso-2022-jp?B?SW85Y1VabjhKUEZEeU1FN2ladkt0UFRpUVVUSVQ0eGtCTEcweWVhdlBC?=
 =?iso-2022-jp?B?RG1pWG15SGhYdHB6QTdqWSsxdUJHTk1lVFZxbk4zRHBPdmQ0RlVRRkdz?=
 =?iso-2022-jp?B?VmpFaUpHbWtDYzJtMjd2YXVYUFJGQ1FkbjEyTks4Tlh3eFQrTHBUczBK?=
 =?iso-2022-jp?B?M1ovaDNTVkE1S1J1ZG9MUVU4L2ttN0wzZlM2akFKOHVjaDNibWFpWWlG?=
 =?iso-2022-jp?B?ckt4aXhJVHRmM0hJMjRBb3BNN29ZTmEwUWFsemY5WE0rVU15V0F2QWE0?=
 =?iso-2022-jp?B?TFlVSVlrT0FPVDdGVjlnSklzUVpwWmh0azF5R3o4Tll0TzNvSjl2bmx2?=
 =?iso-2022-jp?B?eWJIQ3NaN2poUzBCUXRRZGxMNFdTREp3K0g2Z0hxd1FzMXUrTzQvQ1A5?=
 =?iso-2022-jp?B?eStVZDFmMlRVT1cyU1lqQVlQZVJBUzJQSlhrcXlRVExubzdrczNmZ01T?=
 =?iso-2022-jp?B?blNlL0NSdGhUU3J4Zis3ZXI5dXRTeXBoSUo2dW55VEQreWFYUHFrQlgz?=
 =?iso-2022-jp?B?cGF4NEpENjVKVTd1SG5oSXZkcHdDRnEwclplQ1N4MWE0aG15clMxTzFH?=
 =?iso-2022-jp?B?QzM5ZkRtSEtFbkkzdERzUWY5TFdpdkY2Q21iMEFXeDRrOUdzb1cwVDMr?=
 =?iso-2022-jp?B?SnJmcmc9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WEI3SHlXZGVzS2l5TklIOWQ5Ky9XdlBDRVpkamUyeWIvY0dUcU1SZ2R2?=
 =?iso-2022-jp?B?TU5ZVE1JeFNXVis0MEoySEY0bnhJVHJqVFEvSVk3Z0h2TUxVZEh1a2Yx?=
 =?iso-2022-jp?B?WmNmeE41TW9MWElLWXJiWXFSeEVseDFPVmRnci9ySGc3SGM2SVljMkRS?=
 =?iso-2022-jp?B?ZkZpY2JsN09iazRzKzRXTGZ6NGxrU3ZXMjlQR3JkRks5ZFlwQnVhOVJC?=
 =?iso-2022-jp?B?eitPS1dHT0pWaGQ3b3lPVmVBbHVjRm9kbm5vLy9rSlNLNjdSenZIdmg1?=
 =?iso-2022-jp?B?dStGTzFOTk96bURRWEFET2NGMUZqZUs4dGNaTjhoZnBvZ2hpQmd2Zkpl?=
 =?iso-2022-jp?B?djVlVU1KV0J4RmZieHNucWNESVpXQld4aUsxdkorMVRmYjJaOUxqZXAy?=
 =?iso-2022-jp?B?N0JDZ2V6SmsxL0hNTkRGS0JKamtsU2ZwQVBJVGtIVHVOUDJVUGRFUXZi?=
 =?iso-2022-jp?B?V2pReGQ4dU9vU3dDUGxPUUFQa0lrdGFIMUVWM1JhZ1JsNG93VzE0VmZi?=
 =?iso-2022-jp?B?ZG9wR3lLWEorUmMzNzJ0UHdmQXZCK1p1eFh5REhHTkNOQUtwSW1ZUjBm?=
 =?iso-2022-jp?B?d2Mwd085RkM3TWtoTkZZTG9PUXNJQWl4aXZCZEdkYzhpZ0w0SDk0azhK?=
 =?iso-2022-jp?B?aEpWa29FL1M0OWUrdVQrcGxFTkRIMmR4YnVXYlZBc3lFaTRsdFJGTFdH?=
 =?iso-2022-jp?B?ZXBDQ2Q2NnZyenJFUDR0K2JJYVBQamlaL29nRVEvdDVLVm1pOWNmSktt?=
 =?iso-2022-jp?B?Njg0dmZ3ZU11bVJBMTFhUlcvMUZ0QzJJZ3FOa3BGaTVvWlU3QU51L3NO?=
 =?iso-2022-jp?B?SS9iL1ExWnVmMVB5bWlzUnFOMERheW5TRGE2dmZYQWxqOEZHR1pNRkp1?=
 =?iso-2022-jp?B?ckJkS2xMd3dLaDBNcTF3dTRrRklQbXhxR0lsZWxPcXVnakY5NWVZQ3Y1?=
 =?iso-2022-jp?B?K2NtY1hvekRqWkZRWUxQdmJiNmR6YzB2UVFBYllWWkd3bVY4WFlNbUhx?=
 =?iso-2022-jp?B?SlpIZHEvMzVhYUhPQXNTUnVhdjFpbUg4dVBqT3RDcEorT2Z3YmZRR1VE?=
 =?iso-2022-jp?B?aDB5N0hac01CekZ1aVduUGNDYnpTTGIrWERRc1MxYjdsMG9CNUdVMTVL?=
 =?iso-2022-jp?B?c2ovak9GbjBtL0tjSGRncHo0TW1jVmU0MkNNSzNQaXFFRWNxNTlWVnV4?=
 =?iso-2022-jp?B?cGRJcldhRmlqSmJ3NGo2c21abjlyUnRRUmNRU3puVVY3VHA1cCtQUXdC?=
 =?iso-2022-jp?B?U3lMcVo2NUpzT0hKcld1eGtQaDBJY0NYVExmaXNWdVJ5anBpbGI1YU9k?=
 =?iso-2022-jp?B?ZUVwWHNIemJXQTQ2eGpxd3dtN28wamd4dkhDSDJNbzRUNno1K09nTFMx?=
 =?iso-2022-jp?B?endRVEZWZVhJRy9FQUQ1SzhlUmVPa0JjYjV1TkJNTytJYjJmbUxoZnQv?=
 =?iso-2022-jp?B?M2pNTjNsVmFBOUFBZTltZTFRRjJSaVhxOEZwdHpVTks4d1ptU1ZJdjNz?=
 =?iso-2022-jp?B?SmZ5bC9XTnptVnZiN0ZrSnBnR083ZWMwaTh5QjRTRDJYMHVUYW5hZk05?=
 =?iso-2022-jp?B?Y1p2aTBEeUhlanJ5VDM4TERoYTJWQWRhSEpjRlB5bmdVWG9MSm1oVW1p?=
 =?iso-2022-jp?B?dUxXU0hLaWRrVVJpRkZ6aFNENmpzWmpZWkVoTU93ZnFDT2gwZDM1TkFQ?=
 =?iso-2022-jp?B?cTJoaGEvYUhLaU5Ja1ZEUFhyVUJ3cXVaNTRxZ0VZa2lqRjBXWVVkS2hm?=
 =?iso-2022-jp?B?Mnpyb2VkZmF3THRtNEhaRUozeUZIdUt6Z3owc3Qrci9laUw3d0lvVHRK?=
 =?iso-2022-jp?B?NDRFenhqRkUwa1RTbFNCQXBiZGVPQngxWUNKclFSM1lOL3pGT0Y0anFI?=
 =?iso-2022-jp?B?Y2kyUEJYWlVuSCtmQWIvVzQxdWN1LzJaTHVVK3RRT1poS0E3Y2toRjAw?=
 =?iso-2022-jp?B?SWFROFM1ajRmTE9QVGx2SURqKzhpUjlIcS9DK3hKMUdTSEw5WjRua0Uy?=
 =?iso-2022-jp?B?Y2FIYXRXRm5EYVB1UmwxV1kvclEybjZ5WW9MT21kcGFudlhUSXFYRDFn?=
 =?iso-2022-jp?B?d3d3VDNsaE80ZTNmZWQ2UDhiL1IrWmtVUlIxT2VUOGcvZXdVakthVkg3?=
 =?iso-2022-jp?B?eFVYSHFGUkF1ejJPRW9OODVyMDZYd1pqSEFXTGc3UWpNcmp6RjNTMDJw?=
 =?iso-2022-jp?B?a1ZUNCtaMDdQdGpyN3JERmsxZ2dFeFJzZTZIWlJYcTcveXdNM2EwaCt0?=
 =?iso-2022-jp?B?MGROSWlxSDlrd0hTenM0QmxDeWdsMlFUc3RmRE4yN1BmZmpZT0lXbEk3?=
 =?iso-2022-jp?B?S252N2p2U1JCam8wazExejVHT3RUT2lFL0xqRnI3L0xDSVIyektNSFU0?=
 =?iso-2022-jp?B?dmdkZW84VGlhZFpndjJFb0FJTUduSFRHcW45bXZGK0NXVG1ib1UxclZL?=
 =?iso-2022-jp?B?dmRaVFFxVUVrcFhCekFtUmJibnIxVkVvUEVkQ3VVeVB4S04yMDRLWGR1?=
 =?iso-2022-jp?B?NVRxRXNtZFF1MFdsbWpEM29vSTJvbXBUMFovRnFQSHRjZG5LWTcvYVhQ?=
 =?iso-2022-jp?B?YjkwM0s3az0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ba4c91-66e6-40ce-812c-08de5a74f5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 11:45:52.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rMdXIIjoluSQEvfUYG5x/0g1XvVI0/hQw3MYmR91Kv78GoCPoYzm52/eOBQ1wRuj0WQ99p1aFSBjKPBq3iU4PMJYfDuiYjb7MLr0yGXP3Zz79KvkDZcP3BLFQGXqZrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14042
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jan 2026 11:46:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21702

Hi all,

CIP kernel team has released Linux kernel v6.12.66-cip16.
The linux-6.12.y-cip tree has been updated base version from v6.12.63 to v6=
.12.66.
This release includes Renesas ARM64 SoC i3c, ethernet, CAN and others suppo=
rt patches and related patches.

Information about this release is as follows:

  v6.12.66-cip16:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      3aed66b26cbd91b9c135a84e6248173aabb0a7f1
    fixed CVEs:
      CVE-2025-68777: Input: ti_am335x_tsc - fix off-by-one error in wire_o=
rder validation
      CVE-2025-71138: drm/msm/dpu: Add missing NULL pointer check for pingp=
ong interface
      CVE-2025-71135: md/raid5: fix possible null-pointer dereferences in r=
aid5_store_group_thread_cnt()
      CVE-2025-71099: drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioct=
l()
      CVE-2025-68800: mlxsw: spectrum_mr: Fix use-after-free when updating =
multicast route stats
      CVE-2025-71084: RDMA/cm: Fix leaking the multicast GID table referenc=
e
      CVE-2025-71087: iavf: fix off-by-one issues in iavf_config_rss_reg()
      CVE-2025-68822: Input: alps - fix use-after-free bugs caused by dev3_=
register_work
      CVE-2025-68801: mlxsw: spectrum_router: Fix neighbour use-after-free
      CVE-2025-68815: net/sched: ets: Remove drr class from the active list=
 if it changes to strict
      CVE-2025-71065: f2fs: fix to avoid potential deadlock
      CVE-2025-71085: ipv6: BUG() in pskb_expand_head() as part of calipso_=
skbuff_setattr()
      CVE-2025-71098: ip6_gre: make ip6gre_header() robust
      CVE-2025-68808: media: vidtv: initialize local pointers upon transfer=
 of memory ownership
      CVE-2025-71118: ACPICA: Avoid walking the Namespace if start_node is =
NULL
      CVE-2025-68774: hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_c=
reate
      CVE-2025-68816: net/mlx5: fw_tracer, Validate format string parameter=
s
      CVE-2025-68771: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
      CVE-2025-68770: bnxt_en: Fix XDP_TX path
      CVE-2025-71101: platform/x86: hp-bioscfg: Fix out-of-bounds array acc=
ess in ACPI package parsing
      CVE-2025-71076: drm/xe/oa: Limit num_syncs to prevent oversized alloc=
ations
      CVE-2025-71095: net: stmmac: fix the crash issue for zero copy XDP_TX=
 action
      CVE-2025-68778: btrfs: don't log conflicting inode if it's a dir move=
d in the current transaction
      CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted co=
nnections
      CVE-2025-71130: drm/i915/gem: Zero-initialize the eb.vma array in i91=
5_gem_do_execbuffer
      CVE-2025-71129: LoongArch: BPF: Sign extend kfunc call arguments
      CVE-2025-71078: powerpc/64s/slb: Fix SLB multihit issue during SLB pr=
eload
      CVE-2025-71126: mptcp: avoid deadlock on fallback while reinjecting
      CVE-2025-68781: usb: phy: fsl-usb: Fix use-after-free in delayed work=
 during device removal
      CVE-2025-71140: media: mediatek: vcodec: Use spinlock for context lis=
t protection lock
      CVE-2025-40170: net: use dst_dev_rcu() in sk_setup_caps()
      CVE-2025-68806: ksmbd: fix buffer validation by including null termin=
ator size in EA length
      CVE-2025-40276: drm/panthor: Flush shmem writes before mapping buffer=
s CPU-uncached
      CVE-2025-71121: parisc: Do not reprogram affinitiy on ASP chip
      CVE-2025-71080: ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT=
_RT
      CVE-2025-71133: RDMA/irdma: avoid invalid read in irdma_net_event
      CVE-2025-68784: xfs: fix a UAF problem in xattr repair
      CVE-2025-68782: scsi: target: Reset t_task_cdb pointer in error case
      CVE-2025-71081: ASoC: stm32: sai: fix OF node leak on probe
      CVE-2025-71132: smc91x: fix broken irq-context in PREEMPT_RT
      CVE-2025-71105: f2fs: use global inline_xattr_slab instead of per-sb =
slab cache
      CVE-2025-71108: usb: typec: ucsi: Handle incorrect num_connectors cap=
ability
      CVE-2025-71093: e1000: fix OOB in e1000_tbi_should_accept()
      CVE-2025-71119: powerpc/kexec: Enable SMT before waking offline CPUs
      CVE-2025-71089: iommu: disable SVA when CONFIG_X86 is set
      CVE-2025-68802: drm/xe: Limit num_syncs to prevent oversized allocati=
ons
      CVE-2025-71104: KVM: x86: Fix VM hard lockup after prolonged inactivi=
ty with periodic HV timer
      CVE-2025-71125: tracing: Do not register unsupported perf events
      CVE-2025-68794: iomap: adjust read range correctly for non-block-alig=
ned positions
      CVE-2025-68795: ethtool: Avoid overflowing userspace buffer on stats =
query
      CVE-2025-71136: media: adv7842: Avoid possible out-of-bounds array ac=
cesses in adv7842_cp_log_status()
      CVE-2025-68776: net/hsr: fix NULL pointer dereference in prp_get_unta=
gged_frame()
      CVE-2025-71112: net: hns3: add VLAN id validation before using
      CVE-2025-71113: crypto: af_alg - zero initialize memory allocated via=
 sock_kmalloc
      CVE-2025-71067: ntfs: set dummy blocksize to read boot_block when mou=
nting
      CVE-2025-68769: f2fs: fix return value of f2fs_recover_fsync_data()
      CVE-2025-71131: crypto: seqiv - Do not use req->iv after crypto_aead_=
encrypt
      CVE-2025-68780: sched/deadline: only set free_cpus for online runqueu=
es
      CVE-2025-68773: spi: fsl-cpm: Check length parity before switching to=
 16 bit mode
      CVE-2025-71086: net: rose: fix invalid array index in rose_kill_by_de=
vice()
      CVE-2025-71075: scsi: aic94xx: fix use-after-free in device removal p=
ath
      CVE-2025-68814: io_uring: fix filename leak in __io_openat_prep()
      CVE-2025-71116: libceph: make decode_pool() more resilient against co=
rrupted osdmaps
      CVE-2025-71082: Bluetooth: btusb: revert use of devm_kzalloc in btusb
      CVE-2025-68785: net: openvswitch: fix middle attribute validation in =
push_nsh() action
      CVE-2025-68820: ext4: xattr: fix null pointer deref in ext4_raw_inode=
()
      CVE-2025-68797: char: applicom: fix NULL pointer dereference in ac_io=
ctl
      CVE-2025-71066: net/sched: ets: Always remove class from active list =
before deleting in ets_qdisc_change
      CVE-2025-68787: netrom: Fix memory leak in nr_sendmsg()
      CVE-2025-68811: svcrdma: use rc_pageoff for memcpy byte offset
      CVE-2025-71097: ipv4: Fix reference count leak when using error route=
s with nexthop objects
      CVE-2025-71137: octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
      CVE-2025-68813: ipvs: fix ipv4 null-ptr-deref in route error path
      CVE-2025-68817: ksmbd: fix use-after-free in ksmbd_tree_connect_put u=
nder concurrency
      CVE-2025-71100: wifi: rtlwifi: 8192cu: fix tid out of range in rtl92c=
u_tx_fill_desc()
      CVE-2025-71094: net: usb: asix: validate PHY address before use
      CVE-2025-71064: net: hns3: using the num_tqps in the vf driver to app=
ly for resources
      CVE-2025-71083: drm/ttm: Avoid NULL pointer deref for evicted BOs
      CVE-2025-71102: scs: fix a wrong parameter in __scs_magic
      CVE-2025-68818: scsi: Revert "scsi: qla2xxx: Perform lockless command=
 completion in abort path"
      CVE-2025-68798: perf/x86/amd: Check event before enable to avoid GPF
      CVE-2025-71072: shmem: fix recovery on rename failures
      CVE-2025-68809: ksmbd: vfs: fix race on m_flags in vfs_cache
      CVE-2025-71096: RDMA/core: Check for the presence of LS_NLA_TYPE_DGID=
 correctly
      CVE-2025-68799: caif: fix integer underflow in cffrml_receive()
      CVE-2025-71122: iommufd/selftest: Check for overflow in IOMMU_TEST_OP=
_ADD_RESERVED
      CVE-2025-68345: ALSA: hda: cs35l41: Fix NULL pointer dereference in c=
s35l41_hda_read_acpi()
      CVE-2025-71091: team: fix check for port enabled in team_queue_overri=
de_port_prio_changed()
      CVE-2025-71109: MIPS: ftrace: Fix memory corruption when kernel is lo=
cated beyond 32 bits
      CVE-2025-68357: iomap: allocate s_dio_done_wq for async reads as well
      CVE-2025-71107: f2fs: ensure node page reads complete before f2fs_put=
_super() finishes
      CVE-2025-68772: f2fs: fix to avoid updating compression context durin=
g writeback
      CVE-2025-71077: tpm: Cap the number of PCR banks
      CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible c=
ode warnings
      CVE-2025-68821: fuse: fix readahead reclaim deadlock
      CVE-2025-39872: hsr: hold rcu and dev lock for hsr_get_port_ndev
      CVE-2025-68789: hwmon: (ibmpex) fix use-after-free in high/low store
      CVE-2025-71071: iommu/mediatek: fix use-after-free on probe deferral
      CVE-2025-68767: hfsplus: Verify inode mode when loading from disk
      CVE-2025-68803: NFSD: NFSv4 file creation neglects setting ACL
      CVE-2025-71114: via_wdt: fix critical boot hang due to unnamed resour=
ce allocation
      CVE-2025-68775: net/handshake: duplicate handshake cancellations leak=
 socket
      CVE-2025-71079: net: nfc: fix deadlock between nfc_unregister_device =
and rfkill_fop_write
      CVE-2025-40325: md/raid10: wait barrier before returning discard requ=
est with REQ_NOWAIT
      CVE-2025-68796: f2fs: fix to avoid updating zero-sized extent in exte=
nt cache
      CVE-2025-71143: clk: samsung: exynos-clkout: Assign .num before acces=
sing .hws
      CVE-2025-68804: platform/chrome: cros_ec_ishtp: Fix UAF after unbindi=
ng driver
      CVE-2025-71068: svcrdma: bound check rq_pages index in inline path
      CVE-2025-71111: hwmon: (w83791d) Convert macros to functions to avoid=
 TOCTOU
      CVE-2025-71073: Input: lkkbd - disable pending work before freeing de=
vice
      CVE-2025-68788: fsnotify: do not generate ACCESS/MODIFY events on chi=
ld for special files
      CVE-2025-68819: media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100=
_i2c_msg()
      CVE-2025-68786: ksmbd: skip lock-range check on equal size to avoid s=
ize=3D=3D0 underflow
      CVE-2025-38234: sched/rt: Fix race in push_rt_task
      CVE-2025-68783: ALSA: usb-mixer: us16x08: validate meter packet indic=
es
      CVE-2025-71123: ext4: fix string copying in parse_apply_sb_mount_opti=
ons()
      CVE-2025-71120: SUNRPC: svcauth_gss: avoid NULL deref on zero length =
gss_token in gss_read_proxy_verf
      CVE-2025-68810: KVM: Disallow toggling KVM_MEM_GUEST_MEMFD on an exis=
ting memslot
      CVE-2025-71069: f2fs: invalidate dentry cache on failed whiteout crea=
tion
      CVE-2025-71144: mptcp: ensure context reset on disconnect()
      CVE-2025-71127: wifi: mac80211: Discard Beacon frames to non-broadcas=
t address
      CVE-2025-22111: net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELI=
F.
      CVE-2025-71134: mm/page_alloc: change all pageblocks migrate type on =
coalescing
      CVE-2025-71088: mptcp: fallback earlier on simult connection
      CVE-2026-22977: net: sock: fix hardened usercopy panic in sock_recv_e=
rrqueue
      CVE-2026-22976: net/sched: sch_qfq: Fix NULL deref when deactivating =
inactive aggregate in qfq_reset
      CVE-2025-68792: tpm2-sessions: Fix out of range indexing in name_size
      CVE-2025-40149: tls: Use __sk_dst_get() and dst_dev_rcu() in get_netd=
ev_for_sock().
    added commits:
      CIP: Bump version suffix to -cip16 after merge from stable
      clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
      clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
      clk: renesas: r9a08g045: Add MSTOP for GPIO
      clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
      Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-c=
ells =3D <1> for RZ/G3S"
      dt-bindings: clock: rzg2l: Drop power domain IDs
      clk: renesas: rzg2l: Drop MSTOP based power domain support
      clk: renesas: r9a08g045: Drop power domain instantiation
      clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable AP=
I
      clk: renesas: rzg2l: Add macro to loop through module clocks
      clk: renesas: rzg2l: Move pointers after hw member
      i2c: core: Drop dev_pm_domain_detach() call
      driver core: auxiliary bus: Drop dev_pm_domain_detach() call
      spi: Drop dev_pm_domain_detach() call
      mmc: sdio: Drop dev_pm_domain_detach() call
      driver core: platform: Drop dev_pm_domain_detach() call
      PM: domains: Detach on device_unbind_cleanup()
      PM: domains: Add helper to check for PM domain detach on unbind clean=
up
      PM: domains: Add flags to specify power on attach/detach
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g056: Add XSPI node
      clk: renesas: r9a09g056: Add XSPI clock/reset
      clk: renesas: r9a09g056: Add support for xspi mux and divider
      dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g056: Add USB2.0 support
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2N SoC support
      dt-bindings: usb: renesas,usbhs: Add RZ/V2N SoC support
      dt-bindings: reset: renesas,rzv2h-usb2phy: Document RZ/V2N SoC suppor=
t
      clk: renesas: r9a09g056: Add clock and reset entries for USB2.0
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RIIC controllers
      arm64: dts: renesas: r9a09g056: Add RIIC controllers
      dt-bindings: i2c: renesas,riic: Document RZ/V2N (R9A09G056) support
      clk: renesas: r9a09g056: Add clock and reset entries for RIIC control=
lers
      arm64: dts: renesas: r9a09g047: Add I3C node
      clk: renesas: r9a09g047: Add I3C0 clocks and resets
      i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
      i3c: document i3c_xfers
      i3c: master: Add helpers for DMA mapping and bounce buffer handling
      i3c: Add more parameters for controllers to the header
      i3c: Standardize defines for specification parameters
      i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API
      i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
      i3c: master: Add basic driver for the Renesas I3C controller
      i3c: controllers do not need to depend on I3C
      dt-bindings: i3c: Add Renesas I3C controller
      bitops: add generic parity calculation for u8
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Add NMI pushbutton suppo=
rt
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable RTC
      arm64: dts: renesas: r9a09g057: Add RTC node
      rtc: renesas-rtca3: Add support for multiple reset lines
      rtc: renesas-rtca3: stop setting max_user_freq
      rtc: renesas-rtca3: Disable interrupts only if the RTC is enabled
      clk: renesas: r9a09g057: Add clock and reset entries for RTC
      dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support
      can: rcar_canfd: Fix CAN-FD mode as default
      can: rcar_canfd: Add suspend/resume support
      can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      can: rcar_canfd: Invert CAN clock and close_candev() order
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
      can: rcar_canfd: Invert global vs. channel teardown
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Simplify data bit rate config
      can: rcar_canfd: Simplify nominal bit rate config
      can: rcar_canfd: Update RCANFD_CFG_* macros
      can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
      can: rcar_canfd: Drop unused macros
      can: rcar_canfd: Describe channel-specific FD registers using C struc=
t
      can: rcar_canfd: Add support for Transceiver Delay Compensation
      can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not =
FD
      can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
      can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
      can: rcar_canfd: Repurpose f_dcfg base for other registers
      can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
      can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controll=
er()
      can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
      can: rcar_canfd: Remove bittiming debug prints
      can: rcar_canfd: Consistently use ndev for net_device pointers
      arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI fu=
nction
      arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control n=
ode
      arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
      pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
      pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt contr=
ol registers
      pinctrl: renesas: rzg2l: Validate pins before setting mux function
      net: stmmac: Disable EEE RX clock stop when VLAN is enabled
      net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
      net: stmmac: convert to use phy_eee_rx_clock_stop()
      net: stmmac: remove priv->tx_lpi_enabled
      net: stmmac: remove redundant code from ethtool EEE ops
      net: stmmac: make EEE depend on phy->enable_tx_lpi
      net: stmmac: move tx_lpi_timer tracking to phylib
      net: phy: add configuration of rx clock stop mode
      arm64: dts: renesas: rzt2h-n2h-evk-common: Enable WDT2
      arm64: dts: renesas: r9a09g087: Add WDT nodes
      arm64: dts: renesas: r9a09g077: Add WDT nodes
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable MicroSD card slot
      arm64: dts: renesas: rzt2h-rzn2h-evk: Enable eMMC
      arm64: dts: renesas: r9a09g087: Add SDHI nodes
      arm64: dts: renesas: r9a09g077: Add SDHI nodes
      clk: renesas: r9a09g077: Add PLL2 and SDHI clock support
      clk: renesas: cpg-mssr: Add read-back and delay handling for RZ/T2H M=
STP
      dt-bindings: clock: renesas,r9a09g077/87: Add SDHI_CLKHS clock ID
      dt-bindings: mmc: renesas,sdhi: Document RZ/T2H and RZ/N2H support
      watchdog: rzv2h: Add support for RZ/T2H
      watchdog: rzv2h: Add support for configurable count clock source
      watchdog: rzv2h: Make "oscclk" and reset controller optional
      watchdog: rzv2h: Obtain clock-divider and timeout values from OF matc=
h data
      dt-bindings: watchdog: renesas,wdt: Add support for RZ/T2H and RZ/N2H
      arm64: dts: renesas: rzt2h-n2h-evk-common: Enable EEPROM on I2C0
      arm64: dts: renesas: r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 sup=
port
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable I2C0 and I2C1 sup=
port
      arm64: dts: renesas: r9a09g087: Add I2C controller nodes
      arm64: dts: renesas: r9a09g077: Add I2C controller nodes
      i2c: riic: Add support for RZ/T2H SoC
      i2c: riic: Move generic compatible string to end of array
      i2c: riic: Pass IRQ desc array as part of OF data
      i2c: riic: Implement bus recovery
      i2c: riic: Make use of devres helper to request deasserted reset line
      dt-bindings: i2c: renesas,riic: Document RZ/T2H and RZ/N2H support
      dt-bindings: i2c: renesas,riic: Move ref for i2c-controller.yaml to t=
he end
      clk: renesas: r9a09g077: Add RIIC module clocks
      clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
      clk: renesas: r9a09g077: Use devm_ helpers for divider clock registra=
tion
      clk: renesas: r9a09g077: Remove stray blank line
      clk: renesas: r9a09g077: Propagate rate changes to parent clocks
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Fix pinctrl node name fo=
r GBETH1
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable GBETH
      arm64: dts: renesas: r9a09g056: Add GBETH nodes
      dt-bindings: net: renesas-gbeth: Add support for RZ/V2N (R9A09G056) S=
oC
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for GBETH0/1

Best regards,
  Nobuhiro


