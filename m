Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609AC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 05:38:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5222.1737610699107268571
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 21:38:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=WHmYiJCb;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737610687;x=1738820287;bh=fg1+wDQG9V7AD5EyS9ywSnH80x7n32PTZtnJdJa
	bFwo=;b=WHmYiJCbqr6gHnK6uLTPw4QLzFiZ+HRum5M/eOY9ppJg9Xg4b1z9CB4VEBpTdVLJVKTpK
	HYQfD6pPweXHitDldvon49KQLWq25GoAKPvBakLcOcN1NvsEGJJu0BfNsEKuVtoB2ZA8hX/sNbfP4
	V6h5Gwyp9GSAVkRp9/rPjFwfwI3zpaiF3WSV1ixroUHTbM0p6QpFUmMFonbpTg/E1/JEXPZF/+I+c
	sUsR7YXODI4FUXfY7iXvTCKGXarBPRcKActI0BVe27eXTGW3jbFIzUtQVkzPsXw3Z1H5MAgL9LYFo
	/8GtIRu09YwaNhnnyZxJXQ/ig/Y8NJ6xOF282jMNbQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 50N5c61j3772994; Thu, 23 Jan 2025 14:38:07 +0900
X-Iguazu-Qid: 2yAbJ3LJ1RiMV0hZwY
X-Iguazu-QSIG: v=2; s=0; t=1737610686; q=2yAbJ3LJ1RiMV0hZwY; m=xp4Y6KsTINmGf8Wefa1ngNMr5CfmDMfekXcapMhIAI8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 50N5c5dS789851
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 14:38:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr3uzT/GhG4o8hQx9FUpUaYVKLaP7dC9SCcWQb+Clhbes7INH3kDCZ8g/sfJoi2NRaYtsCXVf/lyp8QZPsy2TNKi7N7AlsU8MS/zhyzT+lFhc8Fvh//VqZbS1biUgrvenpnSxIzAqgTa0520L1D34y/J7ZXu/fryaFCkm0TPW7ywncRHFQan6fbbXsQm0zLr0QqLpbZFxd1KK5R8WTg0UL0DdE6i3jzqU+WEhWKJtt0YoCz0h88RPXDfgwdv8iAnI2Qb+45D+a0ToCHXAi1noFjYGitCuGPFhSiDFm3L2WzI71LTc0exrRNU2DlGv6POWaG0h4Gci3stSRk9XKZqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjkhdQdSpyY77ac1lTt9hiXiHLaH7gPEOKXICwKVYlA=;
 b=f4vjeKaweDVqiHszNIVd/WKbyiDJJ8QZDm6bLPty+8jW+4O/1Kcyd7qvpzWbSL1N5VXvEpEOedhBDq9wQSipbCQ2Em1hK4qArEqHMaUdoPxql1cCfo3PmeevzziGyGkzT+gmA9MTJT0BhrWiW+f5ySIptD/ElXPpV5CnhL+SGEQCacXOrRgaxbjG2V+66OhSMT8xdtO++PLh1ZLXC/5201N7yACppIBXNBp1q2xK/NA1Y4XefSTZOclH/OrOudJrgg1abdFtgF21RSc8sN9onMZHV7waLUS+BdN10Nbf0Fn6rN1QeVaJPOfScCcKcq+rXkj03YkDkllQkC4ETSwh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHbbMP+fCJ7q/KP2Uqj6k8rb/3R3LMj1a0g
Date: Thu, 23 Jan 2025 05:38:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388CDA2AEED05007496E31892E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYAPR01MB5977:EE_
x-ms-office365-filtering-correlation-id: 199e23d4-5fc4-4b04-7a49-08dd3b701b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WDZFSGhiSlNrSElGckRrVW9FTGZub0pKaE1CeVRFZzVuQjY0WG52YUVn?=
 =?iso-2022-jp?B?TUdSRkVXYlhwTmJYS1VERG5iRE82QThCUkdhNERXaGxwN3N1UGNHZkhw?=
 =?iso-2022-jp?B?MGh1TUpQS1JUZlFWQmR6alhLeHY1QnJGYkl3UFBjeENlVzZpOUdQNkNh?=
 =?iso-2022-jp?B?S3VWaGd0ejVWKzJMWmRpNmY0UjliMVljNkV6dGs1VHQ2anl6L1VaUTIv?=
 =?iso-2022-jp?B?d05TNklNR0ZqT0lXa3MxVGR0MUhJWVlCQVRnL3crVTZ3bEFmVHlGbU5y?=
 =?iso-2022-jp?B?dkJ1NSs3NHNDckp4MUgrbHFpRWNKYWZ3M2J1SkxBaklIRXNUU1NNbkln?=
 =?iso-2022-jp?B?YjRKbHRHMkpWV3hQbi92N0VQcm1HZndhOWpNOFY4c3lUa0JPL0pSSmxN?=
 =?iso-2022-jp?B?WkNUek9xQ3BlU0MwcDhWNi9PbGMrZjh3L1NwKzRXTHVpTCtGdTdPNUhT?=
 =?iso-2022-jp?B?QVhuOFhRcTMvQ210SnlCRjU3ZVREZXFOc3J1SjZHaGp5S0Z1dVhqRDYy?=
 =?iso-2022-jp?B?ZE9PQ0d0L29FRFVNbVh5RkNYcTR2K0NTMjErTVVNRWFzeXVFYjlsWEVN?=
 =?iso-2022-jp?B?NzM2dUkzMTgydDBvRzZoTjFSSEM5REl0WTQwOGZDZnFqNXpENm56TGJv?=
 =?iso-2022-jp?B?V2REZURlaVByWnpqSHEybTY2QUM0enFKdDh5dW1oMGZma2UyZzNUNEdV?=
 =?iso-2022-jp?B?Q2taVFlEQ2tXM2ttTnJWUXIwTVdTYlpoTEpNQ2VKNE1MVktNUElZTXhs?=
 =?iso-2022-jp?B?OVVjdEJHOUc0VEJ5TDRFMVl6bEJMbGFQRk5mazNFNzZJRUtzNEpiY2hw?=
 =?iso-2022-jp?B?ZmdGcDNHdmN2RTRvSFkvSWliOFQrRmQ3UWFaSzlQUWlOMzUybGhqNURC?=
 =?iso-2022-jp?B?dW5LN0R6R091RUp1V0hzQ213cGdON1dPM1d4Sml0VVhzMEtUR1dldURv?=
 =?iso-2022-jp?B?UUJSRVVUbDZ4amRkcnJyeUNUVExXMFdMbDJOK3Npd3VxM3Rhc0FkQXVt?=
 =?iso-2022-jp?B?WGVIeWFTWkd1bmJsY2JkWk96T0xySy9meDRydSt0N3FRTWJLaXg4U2Qx?=
 =?iso-2022-jp?B?OVBrOTNhbUtvdFJ0ZjA2TFhLS3JKVlNucTRkMDltOEJLYVp2azZ0VWc0?=
 =?iso-2022-jp?B?azFQdUE2dDJ4bjNqNXZUUHViYzdGZkVVelNmZkhwcEpjWjRzTnNMakJG?=
 =?iso-2022-jp?B?KytGUlB3TFA2c2FNc2I4bVJOOVliK0pXL1lNTndITUEvOXRUZFhFUWc4?=
 =?iso-2022-jp?B?QUd3S1RIKzB3alo5TW40RnFScUxRWXYvZ3NBeTE1TU1SVTFqQUUyQWp0?=
 =?iso-2022-jp?B?TGo1WVl3eGpWekt5eXNjUjY2Y05zNlcwcm90SGM2TjM3WUpydzdDbDFL?=
 =?iso-2022-jp?B?NDBnZzdaQkZpMzNvT05TUTlXcm04Skxyam5yeGhib0owRHdoNUxqNHlN?=
 =?iso-2022-jp?B?emtLbjduVDhSQzg5ZUY3Vmx1Q3VXZjlISnBBSW1Qbk5qRzRNWGF6NFVR?=
 =?iso-2022-jp?B?QkczcldoNEo4NGd6a3hDQ1hTOGhmKytPdytjZ3NBTTVJYklrYTM0ODgz?=
 =?iso-2022-jp?B?ckFhN0RKYi9ZOGlTT05yd2Z1MkJGMDNqN1dPRmVzRXhHT1ZsZ2RTT1dK?=
 =?iso-2022-jp?B?T1Z2VTlocVMrcXJ5Ymw2QWFjc0xKYlI4TkRtOU80TFNIMFJiYlFSbHh0?=
 =?iso-2022-jp?B?N1RDQUJiR2FZb2NCSXU0S1FEeGNwKy9SUE1QKzFxRWtha0F6ejdzcm5Z?=
 =?iso-2022-jp?B?UEZMRTVabGRPMjVBZSttRnBSd2lDWGdiek53NzVIRW1lZW5KSjc5N2Zk?=
 =?iso-2022-jp?B?MEFteW9BbEtlMzRSZmx4Wm42aGhaMDYwRlZ4akMrR1BEQ2gxQ2cyUm9V?=
 =?iso-2022-jp?B?UVN2MlEvQW1OUkZqa25Qc3dxbG5WWGNNcTdNcjlGZmJZOXU4S2ROTUlq?=
 =?iso-2022-jp?B?RytTY0V6czQ0Sy9KMWpqRTc2UFc0N0ovNUpsWGR5aER2OStBNFNTMVhS?=
 =?iso-2022-jp?B?NzFYcUgrWmk1RzIvUmZEY21icmdyU0hWdmZDZ25jVnpYdWJrTmliMjgv?=
 =?iso-2022-jp?B?RzR1WWFEZWVXUGswaFp5TkJJblliTDEySlNWS3lJOGV0OWV0MkJPZ3hJ?=
 =?iso-2022-jp?B?U1ZBUXdoVmRWeFdWQWZaenFzblhDS1ZyWFlNR3ZWM2pNQ0lwK1pXOFNJ?=
 =?iso-2022-jp?B?Y0lzPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dFprTmdQZy9FWGM5aEYzU0pjNXZPMVpZZEhteWh1emorZkU5OGp6bnB4?=
 =?iso-2022-jp?B?M0VYaG5Gb2xWVUozVy9ySkx6d3VtWU13OEUrQ2hFWVJnKzhTZ3YyemJr?=
 =?iso-2022-jp?B?TW5lQWVlc1VUa2czeDZaUHh2NUhQTkxnRENySVpwN0xyN1N5aG5rUHFR?=
 =?iso-2022-jp?B?cWowNkIyN25jQ0tvV25hZkJRWjVmemtGcEUvUVN2VkRoV2ptTzZMNlNq?=
 =?iso-2022-jp?B?STVCcm9KZTY3MnlsR3NyN2ZYbVNvVThxUHZSZmpjQ0g3SjFuQzkzV0xS?=
 =?iso-2022-jp?B?YTg3RW5BeVBwYlZ3T3hMdU5DaGliSzRCRGxhRVJMTGtCcVN6Tnh2SW5K?=
 =?iso-2022-jp?B?b2ZjSGxYYkpGdUVFQTFuM1Z1TDZFV0dNanp3aXBtOWxzcU9OYWpOczVl?=
 =?iso-2022-jp?B?a2VSVzdrMXFVbVQzNFNUYXRpZEVxb3FtMHlWNFJLU2FCdE9KK2Z1K1ht?=
 =?iso-2022-jp?B?NW1jVHYyTnNhLzMySlk3WWgyVFRaNHdNRmt1MXFkcExXbDV3MmFTRzNS?=
 =?iso-2022-jp?B?TFFvWDFLcmZQTUN3VXdUWXFxZk1PLzVzZjhTR0VuV05oM2JOOGcrQmpr?=
 =?iso-2022-jp?B?eWRqY0Q3QVZjUlg3aVJXbmwveVNxWWNwMFNZMUtUcU1ZencrajI4MGNQ?=
 =?iso-2022-jp?B?K0dNeDFHQVVPd1Yzc2ZDdUFpbTQ3K0huY055bHh6VWwybkRMaVN2dFpE?=
 =?iso-2022-jp?B?MklvWEpsa2Juc1hMa2Y3VTNnYU9lUTJxSTJFaHF4cE1jVVp4c2RpQ3JT?=
 =?iso-2022-jp?B?R2g4UTdaK01OclhTVjdPLytCbUkxa2t2ajl0T2FvMFh6akVkRnpJY09V?=
 =?iso-2022-jp?B?eEQzWFY1MDZaUmFleFEvL1BBTlRWS2VIeGsvQVpJRk5idGs3RUFHN2xF?=
 =?iso-2022-jp?B?dHJ1QWVDcDdJOGthTTNpdjNPem1nZEh6M0JZNnlaOVZxVkV6d0ZPMjBv?=
 =?iso-2022-jp?B?ZzNGMHF5M1d1enp0SnBtdHZPYzBkQktuY0t4NDViOGN1a09jL0h1TWhj?=
 =?iso-2022-jp?B?Qlg1Qm1md3RlcytiUXNDMEpOTjVzRkthTjJjbytMZkdGSkNVUUpZdVJG?=
 =?iso-2022-jp?B?QVFPSmlFbklZMzltbzRKOGphK250b3luU3UydUN3MVhCV0RMSUszaXZm?=
 =?iso-2022-jp?B?R0xCMVFnS2lBUzF2MVZ1anFYVXpHbjBQY0Z6ZkZPUzl6enFDNGQ4d1FB?=
 =?iso-2022-jp?B?M01OM2xCUEdzV256bnJubzJQMXRyK016UWF1aEpUQnBxeHhOTzhLSVZ4?=
 =?iso-2022-jp?B?dk9mUEtPNkdWR0hpb2J2UnJQMVJPZ1dQS1FlbGFVNXNVNW1KR3RlaXJo?=
 =?iso-2022-jp?B?UlNycTZaaWxxcmRPbnZoclo5SEFmY3hBVm9kcFJDNFdzUEZYSlVuMUVB?=
 =?iso-2022-jp?B?OVUwd3pzK3JQUDFvL2E5V0Mvc1prUnc3cnZWeWk5ZHdYS0RhWkU3Q0N2?=
 =?iso-2022-jp?B?d090ZnJKTVNrRTVCV3luWG1PTlJEZmZsUUdJSnB6eDlzdndkOXFMdU55?=
 =?iso-2022-jp?B?eGdhQmdSYjFza3g2RU9YU24xbWpYRld1NjlkY3FJYVRQZVFhWkxmdkVW?=
 =?iso-2022-jp?B?WFIreVZ5ZjNYTHg2TGxDVXhDcjlSZm5hR0paNzVvdGlndzVOd0sxeTJV?=
 =?iso-2022-jp?B?Y0pPQ2h0M2QwU01UQlpZVEhYb0ZTOVlIbzNXMlRRSER5eVZYVkZTRkUv?=
 =?iso-2022-jp?B?MTE1c0xpSzNiSWJxRThsSjBZYUdmU3hheUFPK3l1Q1V5TUVlTDJ3QlVM?=
 =?iso-2022-jp?B?M096Ti9DbUZZenFZUXpPQjdsa1FLQmwzaUhnSUFzWHEyWlltRjdkN3Va?=
 =?iso-2022-jp?B?OVhaT2ZHUlZUdEhrM3Q3UWQ0cjAyR3hIODhycWxZL3Jac0J4VE9BNXU1?=
 =?iso-2022-jp?B?clNHSFhpWldRdnY4SkpoNDljY1JhNXZTMWozaVlkbUhTL2NENEozYkUy?=
 =?iso-2022-jp?B?M2E1My80N3QxSHZoT0JlMC8xT3dkTnJuZDhvRkc2UmtRRnFtcXdHNWFJ?=
 =?iso-2022-jp?B?RFRTUzN2TG4rZ1V5R0ZZMjBRRlZkK3hSejRtb1ZOVWV4UU1pVzhUYjRR?=
 =?iso-2022-jp?B?Z3paZmFTZHBLVk5ML0JTN1hmcDB6T1FBaktYZ21YT2QyQ3krRnRlVE8x?=
 =?iso-2022-jp?B?SDZJOG9pL3lWUFZuVDIvOUhabUgrT3FTM3VGb3Z6OVNVd0F4Rk5TeE50?=
 =?iso-2022-jp?B?NVEvWVZrT1pTUDUxRjlWa014Uld5WFNvQTlkV2tjNmc4c09iRjc2Zk1I?=
 =?iso-2022-jp?B?SzNENGswWHJJelRIc1FveFJ1RnFkcmdvZ1YvbVhLSHlNSXJRd2R2MWsz?=
 =?iso-2022-jp?B?d0NlSVZwaDNpazRpTVR1SEtVczVXSGR6Mmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199e23d4-5fc4-4b04-7a49-08dd3b701b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:38:03.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNIdJWGvgUIpM1UOYNZd2/zaQKV5KseRFzz0RvC4MhKKMs+wOl/Sb8F+WmZqSPJMJaccK1XAp9mS7NvrSlwgirbLHgHM+rowVDcUc9ojc6/ew2vzDj4w2tXuecTXk6sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 05:38:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17601

Hi Claudiu,

Thanks for your patch.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, January 22, 2025 8:51 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock driver
>=20
> From: Qin Jian <qinjian@cqplus1.com>
>=20
> commit d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2 upstream.
>=20
> Add clock driver for Sunplus SP7021 SoC.
>=20
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> Link:
> https://lore.kernel.org/r/20221219015130.42621-1-qinjian@cqplus1.com
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> [claudiu.beznea: kept only the code from include/linux/clk-provider.h]

I understand that the SP7021 driver itself is unrelated to Renesas SoCs or =
this patch series.
However, would you consider applying the patch as is without deleting the d=
river?

From what I've checked, there seems to be no problem with building the driv=
er.
However, there are several fixes available upstream, so you should consider=
 applying these.

As I've recorded here, the patch subject content and the commit content bar=
ely match. I think
it's better to keep the modifications required to backport the patch to a m=
inimum.

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  include/linux/clk-provider.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h =
index
> d2c799595d5e..53dd7c9dcc94 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -606,6 +606,25 @@ struct clk *clk_register_gate(struct device *dev, co=
nst
> char *name,
>  	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name),
> NULL, \
>  			       NULL, (flags), (reg), (bit_idx),
> \
>  			       (clk_gate_flags), (lock))
> +/**
> + * devm_clk_hw_register_gate_parent_data - register a gate clock with
> +the
> + * clock framework
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @parent_data: parent clk data
> + * @flags: framework-specific flags for this clock
> + * @reg: register address to control gating of this clock
> + * @bit_idx: which bit in the register controls gating of this clock
> + * @clk_gate_flags: gate-specific flags for this clock
> + * @lock: shared register lock for this clock  */ #define
> +devm_clk_hw_register_gate_parent_data(dev, name, parent_data, flags,  \
> +					      reg, bit_idx, clk_gate_flags,
> \
> +					      lock)
> \
> +	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, NULL,
> 	      \
> +				    (parent_data), (flags), (reg), (bit_idx), \
> +				    (clk_gate_flags), (lock))
> +
>  void clk_unregister_gate(struct clk *clk);  void
> clk_hw_unregister_gate(struct clk_hw *hw);  int clk_gate_is_enabled(struc=
t
> clk_hw *hw);
> --
> 2.43.0

Best regards,
  Nobuhiro


