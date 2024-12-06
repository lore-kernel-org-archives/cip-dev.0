Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E197E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 12:56:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.36244.1733489788514508993
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 04:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4B6CuPiX1506596; Fri, 6 Dec 2024 21:56:26 +0900
X-Iguazu-Qid: 2rWhSHZE2B8ociQkhk
X-Iguazu-QSIG: v=2; s=0; t=1733489785; q=2rWhSHZE2B8ociQkhk; m=NtK4HAhPeq/h3ZbLiChoqmHDctPJ/f5mKr5JNOdGRt4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4B6CuNid3461257
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 21:56:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjUBruLJEnZn6bjubPHN/1UFiCYcG9Vxaesuc2wgseyfN5yOG+lewI5iI1guwlVUxWyxccT+8O8KbYNRZthoLroSXoQpKU1hRGWHsFynNWDwmsekJNjjV0Tzs2kQ89zaeVjdBQ50SOmFYE2lxJ6IdYGNBrsvNbZpZjWTyn17IsxPNc3OCCZl6ahdPQ0DmpNls2dlNaEWxIvQuPHIRF2oUv3esC/nj276vQjqSa1JH/9bGDKCCS1SoVfyW4KtXxiC3/HbTcihnOS3tLUiip380lLwF9bON81YULlh5H2g3SHJC7wIyXS8OhLkCS8XoaT8RGEo6QOCW+1JfqN2aggpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9f/H1Rb8ew3tONHs2iNEKyDE8WGSvkbw7QQGtJCNgQ=;
 b=d9gvDfQhLkNWrPD9Rf5TYXVtzAS7r+ivlDQG90n4yT46FaqGURLbs45Kmu2PmLp8inLLT/coG/8S1g9BDmLqW4ItSYlB8PTLpvIyOo7BxH52vEyRaq05so/hOKLvWrcQu5OEkOlo2QPS7DDuq4t/L0zwxN/3ixSfTolSFFTGQoVkGmbeKWcTK2QSMd4nP9CM9RnDy6amWdB4NMqk6L+fftp8fyy2Z5BeagVL7/YNgPbtAfJc+ecvuYBd6s5JJ0FljnBRoLyiO1N+r9i52czy30soFbrHpN20FXM0EH1xYBnJHQ7hQ3q1qZe0Q8kNiKNSE77zEYiMm8uYBpPobADVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] Update isar revision
Thread-Topic: [isar-cip-core][PATCH] Update isar revision
Thread-Index: AQHbR8QCsCavDUjcnEuwFBF+g/9NRLLZJTusgAAEdQCAAACSiA==
Date: Fri, 6 Dec 2024 12:56:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966908622D9B64CEE3551B33C4312@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <155e2bf8-3a8f-4760-be0c-fefdd0bba180@siemens.com>
 <TYCPR01MB9669290CAB5E0F4DC7E468FBC4312@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <f3a8ce77-8728-44e8-a554-10c32ef7b68e@siemens.com>
In-Reply-To: <f3a8ce77-8728-44e8-a554-10c32ef7b68e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB6376:EE_
x-ms-office365-filtering-correlation-id: 86fb1c59-c225-484f-f187-08dd15f56226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?R01ZQUpJbEtvbEpRdisvbFVwN1JLTFNLcVBVaGt3cnRsV21HQlNM?=
 =?ks_c_5601-1987?B?d2lRaklRWVA2K1Y2MTNrTnpOSTkrRWNwUVRIWkZNbmtVRE4rckR1?=
 =?ks_c_5601-1987?B?d2x2anBybnBLOGZhdnVpNmhrNENwWjU2K0VQL2l5TXVsK0RodWlD?=
 =?ks_c_5601-1987?B?Q3hHWlhhNWpDWXA1NTZmbkpiNmRPQVRTRE5UWHM1RmQvcHF6cUVw?=
 =?ks_c_5601-1987?B?TC9hdHNzZ0MwZ1ZKVENMYW1NcUxwNUc0VGRUNzRkcTZPV05Kb2RR?=
 =?ks_c_5601-1987?B?YVJoMnNDRTA0TzVaOUxXeFZTTFo4aG85U2tCb25MYmlrU3lBMXdL?=
 =?ks_c_5601-1987?B?ZXhvbDdXUEs0UEZtZUZPa3hiam9tZWF0aXZEcHdYUE43elBQaEcy?=
 =?ks_c_5601-1987?B?dmZaUDR1OVR2UXhYZFY3UXRKdjNuUklwWHNQc0NHR1UwSWdtVzl6?=
 =?ks_c_5601-1987?B?eEd1UmUyVzRMV0lYNlNMRVJsK2xaMXlKTDQ3RHFNa3psb05lNnVD?=
 =?ks_c_5601-1987?B?WWErQkpmLzlrcHBlZkxuODdhWFV3R1dvOVRzZEhWaHBIWW1rWGdI?=
 =?ks_c_5601-1987?B?MVJFR3Y4WWJyNmdSUmMzYk1sNDNZekVKNUtFTWkyNHJjZjJIRHo1?=
 =?ks_c_5601-1987?B?aDhLcGluMUMxdVlxS2VjVXZPTnFicTYrSG9meDhsVzR5VE9NT3Yy?=
 =?ks_c_5601-1987?B?VTFXSzJINno0Ly9NYXFiY3psY1d1SVErS2Nld2dPRFd5UmZITzN1?=
 =?ks_c_5601-1987?B?K1ZLbjRDcEZRNFZQLzhJazdtalpXSlErd3lKcDhXQkN2QUNHZDBv?=
 =?ks_c_5601-1987?B?ZzZpYkdEbUhxc3dRRXlVWFFXRVFEN2R4ZmVPeU4wWGtKdngxa0tV?=
 =?ks_c_5601-1987?B?RXRnZWRHNVJ4K1BXaklTWk4wbU8xb1FGYU10U3plbEpqMzM5eW95?=
 =?ks_c_5601-1987?B?bjdLSjh6YitXNDd1WEpzZFQ0MVVhV2RSRzlmWFRRYVpHQkhMdnFM?=
 =?ks_c_5601-1987?B?WTZrZUhYVyszcFltYzBvZ2xXTlExUHdleFAwbkQxSWEzRGpDbVZo?=
 =?ks_c_5601-1987?B?elJXa21DRUZJbEd6ckNlNGpjNExJS25Sd0NxRVlRaWJTRWFlUUU4?=
 =?ks_c_5601-1987?B?N0RueXpiL2h5WHc4clp4ZHFrc1pQOHdESFhSb1NJL3ZlYjJrRmNJ?=
 =?ks_c_5601-1987?B?S0NtdFZxL3R1SXhmOUlzb1pDSG9OZzlJcGFhdSt1Sk52cndxeXZC?=
 =?ks_c_5601-1987?B?Y1FCMUw4M2lnSXVsYlF0TFQzL1l6OW1wcmRCWnRuYXpsdXNJRDkw?=
 =?ks_c_5601-1987?B?aTY2THhvand3SFpWc0hhMHZJQmVRc244ZEYreC9HNmFsZEYwa3Nz?=
 =?ks_c_5601-1987?B?cklnSU01NnUxU2JQbDZuTnhXUWhZMDBmQmUxckRCeGFscE9HdjlC?=
 =?ks_c_5601-1987?B?dWhKY0tMcWJJQlcvKzF0WGYxWS9sSGdnb0dMb2MrQWJRaTF1bllV?=
 =?ks_c_5601-1987?B?a2lrblZMc0VXMDZwRVZHVnUyNXJUeGYwdUp0K0lLN20wRWJqM20r?=
 =?ks_c_5601-1987?B?QzNieGlaNWV4MTNDYVlXc1EwSUx6TnBqM3BOMmRSZ0dXb1J6UlNI?=
 =?ks_c_5601-1987?B?cmdmZE5TM05pNjNKejZndndjaTAxUXBYVTFoN3RZd2NKRmRxU1Z3?=
 =?ks_c_5601-1987?B?UVNpYkkxeE80M1A5SmxoRURLZGRhNHBjYUo5cEMvbTdSeVJaMkkx?=
 =?ks_c_5601-1987?B?Z0tBaTk5a01mTTMwWmFJdUpYUDAzV0NGa1ByZ1llRStUbU13N2JQ?=
 =?ks_c_5601-1987?B?dncyWWpGTTkwcEx2Uk9VRHVLcVFQZGdoSENENGV0dFAyQ3RURnl0?=
 =?ks_c_5601-1987?B?TU4xQWNOVG1vd0hVTkppSUpkOVpjZ3NCZkJrUVUzalM1aXJxazdz?=
 =?ks_c_5601-1987?B?NDl5RWdYMG9aRjlTY2xldWxWRi9zckRmbW5GaFl0Q2RRLzU4cmdq?=
 =?ks_c_5601-1987?B?b3I2QUZyd1VkK01YMWkybW40ekNpYUZGcElLMGFjeUQ0VFB1V2p0?=
 =?ks_c_5601-1987?B?d2tHaEJXelZYUmJpYlZVMWMveDBUdGlPWHNDdysrbFQ3SVZqSC9E?=
 =?ks_c_5601-1987?Q?cn0TxcbZjZdt4aSC0JhQ0Q=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?ak5RREUzdklPdE5lcG9kR3pKWVJueGpUbHYxb2RaL1F6UURmTEFj?=
 =?ks_c_5601-1987?B?NlU5cDJzVCtLQ01TcC9kS3hmRGY0cHFHVHFGTU9tNklHQ2t4Wk5h?=
 =?ks_c_5601-1987?B?dFoxUFVROFFUODU0SUJsQ2g5TjduUGh1REp3bWR4dlpmbmhFL1pt?=
 =?ks_c_5601-1987?B?VmtZbVpJSVp5L01FL3Q1WnRwZUpSRlBncW9KNFoyUFoyUi9Sa1pE?=
 =?ks_c_5601-1987?B?dDJ1V0NxbkZocS9EUW95RGdaZFdLSTNYN1Q2TzdtYnB5dUZOMTJQ?=
 =?ks_c_5601-1987?B?VFVWamFzSlBvS1dLUHgwRnZOU0JSRSs2SkJCN1Z2RFpHcWxBTU1i?=
 =?ks_c_5601-1987?B?NWgyeFFBdHlKdHpwSE1NUkJRZzBHTDEvQ3hZcFZtQnJNOTdrd0xN?=
 =?ks_c_5601-1987?B?aEIyQVQxWWVRU3RtbjZ2UFpka1ZrWWFQeUNKTVZHNktzOFBjZWZm?=
 =?ks_c_5601-1987?B?MTFkdTAxMUxtQ0liY1dSalhxU0Q3SkpwN0s4eWhGSGpVWk4vQ1V6?=
 =?ks_c_5601-1987?B?VUNYQTIreG9VS1AzYXcxbW1rQkROTDBFb00yNVNRYVRjLzQ3RmJo?=
 =?ks_c_5601-1987?B?K1lobHZKbXFHblpmalA0L3ZqZVFnVHJoUWlTemNoUTNmQTNvUFRU?=
 =?ks_c_5601-1987?B?UjBhbDNqNUZxTEJEQk1tQnR6K3hvYW9PZ044RUJwRjk2bVBFZnFY?=
 =?ks_c_5601-1987?B?QWZUVWRiOFRzVVFoc0cwaHJRbXMvMktEZWczWUJ1MGd2ZitFU09I?=
 =?ks_c_5601-1987?B?VFJyZE1SSmZhampMcnErR1dzc2dnSHp3QldYMnJLYllPZVVXOHBO?=
 =?ks_c_5601-1987?B?Wkg1RmoxaFprN29lNURFSGMyRTQzTG9ZOFRPV0l0SVltZ2dUWTNV?=
 =?ks_c_5601-1987?B?cTBDQnptblBybStzeGtqV1NSc041am8xWVFpd01yMnExcDdmZ2Vj?=
 =?ks_c_5601-1987?B?a0VyZlJremd6M1R4SVR2blBVR0pRTTE5Z3BRZFZYUkl4SkZ6dUNz?=
 =?ks_c_5601-1987?B?ZmhLRExWbFI2Q2dNVWh2bHBYWXhHNlFkVFE2THdPK1BDeUJlbTN0?=
 =?ks_c_5601-1987?B?SDNkSXJpaTBqZEdzckZWWTN5Skk2R0dsejJNLyswLzJPWkhGek1i?=
 =?ks_c_5601-1987?B?OW91eFZUZjFBczBkVEFOeTdra1R5UGloYkphc3Y3Z1dsY21tZlpi?=
 =?ks_c_5601-1987?B?OEtNeXBoc1l1SUZOUDVTTk0xNDFPM2hTUlo4NEtvSnpWek0xYzNB?=
 =?ks_c_5601-1987?B?UFgrMFl4Vkh6Rkx3a0FORndVNkpjdlRSSDVaK2ZTaWNCNzliZXJQ?=
 =?ks_c_5601-1987?B?cWd4UlFaU05BaTVpN0tmVjA1NmNSKzhQd0NlbTR3bUI4SkxVd1lD?=
 =?ks_c_5601-1987?B?TUVRQVZjRTJYaUhFY2tmb1dBdkhtM2F1RDBBNmtNazVuQldLNTFp?=
 =?ks_c_5601-1987?B?RDNIU25jV1dkeGdLWERIcHEvMGRZYmxQWHE0dWdIYm1ibGRBMXN2?=
 =?ks_c_5601-1987?B?YVh1UjBZdWlEM2toZURGenhEUFBMbTAxbktXL2NtckdBSlk5cDV5?=
 =?ks_c_5601-1987?B?cmUrR2JOR2VraEpKZlFoS1cyK2N6enRSOGd5RGR4aEd2QkVOVFRl?=
 =?ks_c_5601-1987?B?QjFwMHRLb2ZVeStyT1F0NThyR1BvY2FtTGprMituN0ZDSStKU1ky?=
 =?ks_c_5601-1987?B?c1ZqWVZJdFlUZzc2VFhrdFUreDBYVWI4OHBEVHVRT0dBZHVjL3Vk?=
 =?ks_c_5601-1987?B?S0Z1U0w1RVdQYXBENVU4eEhGQnFTN2gzWUtXT0I5OUw0eE5QN2VD?=
 =?ks_c_5601-1987?B?Umdyc1hPamVUWWZtcm91eDAyTHJ0ZGNIYlNGbndVNUtIRG1GQTlK?=
 =?ks_c_5601-1987?B?YXpOL0pjc0pGVDBQeGZrK1FvclYyTGxLSC9GOTVqTmorN3cwNFBY?=
 =?ks_c_5601-1987?B?R2E2b05pSEFqT3dqTTZxN1MzUmFMUHQrT1lZbjlQeWY4UjltSk1P?=
 =?ks_c_5601-1987?B?cnpuMjczY2VVdDI4VVpVQ1FoNGg4ZnhjNHowVnIwRnZUTkUydzFF?=
 =?ks_c_5601-1987?B?d3E5L0dCREpRcjllbU1PS0RIaUhXQjA3aE4xMEcxZjFrTGlKMU5O?=
 =?ks_c_5601-1987?B?NFVMY0xZSDFEb0QzWWZZWUN1RHdITVBNclJsbDFncWZoU0JQSk05?=
 =?ks_c_5601-1987?B?YVNHRWExK2lWWUswOU9acmlTUGEyem8yZ2psZ2tGUnh2OWt1d1ZC?=
 =?ks_c_5601-1987?B?NThuSFE5LzhjbG1pc1U0OEZoa29GeFdib3NGbkdrY0NoOXByNDVE?=
 =?ks_c_5601-1987?B?amNlWU40bEpLRENrS2ZOc1I5a25lamZuajVGWnlvUlpIbk9nNW5R?=
 =?ks_c_5601-1987?B?d0MwWU1ZYm00VTBWNVdWaGNVMk1hcHdrbXdGazJ0Z3drTklRcXM3?=
 =?ks_c_5601-1987?B?ZjlNOUFlN3VlTG9PWjYvS21Zem4vVUo5L3BVTDRsWHVGVU5KN0VY?=
 =?ks_c_5601-1987?B?eWtYQU1CNkJkVGxneFdEd25wZXV5UEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB966908622D9B64CEE3551B33C4312TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fb1c59-c225-484f-f187-08dd15f56226
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 12:56:21.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okG7KV0ylQ+Ha0/JVQHf47LE9jEB6iksf4FH9cpKQbxtMVNlAFdVHcCqg3JqQGiOVZ4/rmjGoxXaTAJ4IPHrEkFLpXhPq1mHNOXGCS4tXsZqwH5JlUm5EWulIiYLnATH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6376
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 12:56:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17367

--_000_TYCPR01MB966908622D9B64CEE3551B33C4312TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

PiAgQW55IGlkZWEgd2hpY2gga2VybmVsIGNvbmZpZyBzd2l0Y2ggY291bGQgbmVnYXRpdmVseQ0K
aW1wYWN0IHJlcHJvZHVjaWJpbGl0eT8NCg0KSSBzdGlsbCBuZWVkIHRvIGNoZWNrIHRoZSBkZXRh
aWxzLCBidXQgcG9zc2libHkgdGhlIGx6b3AgYmFzZWQgY29tcHJlc3Npb24gdGhhdCB3YXMgcmVj
ZW50bHkgYWRkZWQgZm9yIGFybSBjb25maWdzLg0KDQpUaGUgcmVhc29uIEkgc2F5IHRoaXMgaXMg
YmVjYXVzZSB0aGUgZGlmZmVyZW5jZSBpbiB0aGUgdm1saW51eiBmaWxlIGluIHRoZSBsaW5rZWQg
ZGlmZm9zY29wZSByZXBvcnQgbG9va3MgbGlrZSBzb21lIGx6b3AgbWV0YWRhdGEuDQpodHRwczov
L2NpcC1wcm9qZWN0LmdpdGxhYi5pby8tL2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzg1
NjY0ODU4MjcvYXJ0aWZhY3RzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LWNpcC1jb3JlLWJvb2t3
b3JtLXFlbXUtYXJtLndpYy5wNC5kaWZmb3Njb3BlX291dHB1dC5odG1sDQoNCldpbGwgZGVidWcg
Zm9yIG1vcmUgZGV0YWlscyBhbmQgZ2V0IGJhY2suDQoNCkFkaXRoeWENCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+DQpTZW50OiBGcmlkYXksIERlY2VtYmVyIDYsIDIwMjQgNjoxNCBQTQ0KVG86IGJhbGFr
dW1hciBhZGl0aHlhKKPUo9OjyaPQIFRFVVIpIDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRz
aXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gVXBkYXRl
IGlzYXIgcmV2aXNpb24NCg0KT24gMDYuMTIuMjQgMTM6MzgsIEFkaXRoeWEuQmFsYWt1bWFyQHRv
c2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+IEhpIEphbiwNCj4NCj4gVGhhbmtzIGZvciB0aGUgcGF0
Y2guDQo+DQo+IEhvd2V2ZXIgdGhlIHJlY2VudCByZXByb2R1Y2libGUgY2hlY2sgcGlwZWxpbmUg
cnVuIGhhcyBmYWlsZWQgZHVlIHRvIGENCj4gcHJvYmxlbSBpcyB3aXRoIHRoZSBxZW11LWFybSBp
bWFnZS4NCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lw
LWNvcmUvLS8NCj4gcGlwZWxpbmVzLzE1NzY2MjgxMDggPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAt
cHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC0NCj4gY29yZS8tL3BpcGVsaW5lcy8xNTc2NjI4MTA4
Pg0KPg0KPiBUaGUgcWVtdS1hcm0gcmVwcm9kdWNpYmlsaXR5IGFsc28gZmFpbGVkIGluIHRoZSBw
cmV2aW91cyBydW4gKDEtRGVjKS4NCj4gVGhlIHByb2JsZW0gc2VlbXMgdG8gYmUgdGhhdCB0aGUg
YXJtIGtlcm5lbCBpcyBubyBsb25nZXIgcmVwcm9kdWNpYmxlLg0KPiBodHRwczovL2NpcC1wcm9q
ZWN0LmdpdGxhYi5pby8tL2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS8NCj4gam9icy84NTY2NDg1
ODI3L2FydGlmYWN0cy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS1jaXAtY29yZS1ib29rd29ybS0N
Cj4gcWVtdS1hcm0ud2ljLnAyLmRpZmZvc2NvcGVfb3V0cHV0Lmh0bWwgPGh0dHBzOi8vY2lwLXBy
b2plY3QuZ2l0bGFiLmlvLy0vDQo+IGNpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzg1NjY0
ODU4MjcvYXJ0aWZhY3RzL2NpcC1jb3JlLWltYWdlLQ0KPiBzZWN1cml0eS1jaXAtY29yZS1ib29r
d29ybS1xZW11LWFybS53aWMucDIuZGlmZm9zY29wZV9vdXRwdXQuaHRtbD4NCj4NCg0KWWVhaCwg
YWxzbyBzYXcgdGhpcy4NCg0KPiBJIGFtIHlldCB0byBpbnZlc3RpZ2F0ZSB0aGUgcm9vdCBjYXVz
ZSBvZiB0aGUgcHJvYmxlbS4gQnV0IGp1c3QNCj4gd29uZGVyaW5nIGlmIHRoZSBwcm9ibGVtIGNv
dWxkIGJlIGJlY2F1c2Ugb2YgdGhlIG1vdmUgdG8gdGhlIG1lcmdlZA0KPiBrZXJuZWwgY29uZmln
cyBmb3IgYXJtPw0KPiA8aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lz
YXItY2lwLWNvcmUvLS8NCj4gcGlwZWxpbmVzLzE1NzY2MjgxMDg+DQoNCldvdWxkIGJlIHdvcnRo
IGEgdHJ5LCBidXQgdGhlbiB3ZSB3b3VsZCBzdGlsbCBzaXQgaW4gZnJvbnQgb2Ygc29tZQ0KbGFy
Z2VyIGNvbmZpZyBkaWZmLiBBbnkgaWRlYSB3aGljaCBrZXJuZWwgY29uZmlnIHN3aXRjaCBjb3Vs
ZCBuZWdhdGl2ZWx5DQppbXBhY3QgcmVwcm9kdWNpYmlsaXR5Pw0KDQpKYW4NCg0KPg0KPiBQaXBl
bGluZSChpCBjaXAtcHJvamVjdCAvIGNpcC1jb3JlIC8gaXNhci1jaXAtY29yZSChpCBHaXRMYWIg
PGh0dHBzOi8vDQo+IGdpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29y
ZS8tL3BpcGVsaW5lcy8xNTc2NjI4MTA4Pg0KPiBEZWJpYW4vSXNhciBsYXllciB0byBnZW5lcmF0
ZSBpbWFnZXMgdXNpbmcgQ0lQIENvcmUgR2VuZXJpYyBQcm9maWxlDQo+IHBhY2thZ2VzIGFuZCBD
SVAga2VybmVscw0KPiBnaXRsYWIuY29tDQo+DQo+DQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAq
RnJvbToqIEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ICpTZW50OiogRnJp
ZGF5LCBEZWNlbWJlciA2LCAyMDI0IDM6MTggUE0NCj4gKlRvOiogY2lwLWRldiA8Y2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+ICpDYzoqIGJhbGFrdW1hciBhZGl0aHlhKKPUo9OjyaPQ
IFRFVVIpIDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPg0KPiAqU3ViamVjdDoq
IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gVXBkYXRlIGlzYXIgcmV2aXNpb24NCj4NCj4gRnJvbTog
SmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4NCj4gQnJpbmdzIHR3byBpbXBy
b3ZlbWVudCBmb3IgaW1hZ2UgcmVwcm9kdWNpYmlsaXR5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBK
YW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gIGthcy1jaXAueW1s
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9rYXMtY2lwLnltbCBiL2thcy1jaXAueW1sDQo+IGluZGV4IGFi
ZGY5MmFmLi4xYzg2OGFmYyAxMDA2NDQNCj4gLS0tIGEva2FzLWNpcC55bWwNCj4gKysrIGIva2Fz
LWNpcC55bWwNCj4gQEAgLTIyLDcgKzIyLDcgQEAgcmVwb3M6DQo+DQo+ICAgIGlzYXI6DQo+ICAg
ICAgdXJsOiBodHRwczovL2dpdGh1Yi5jb20vaWxiZXJzL2lzYXIuZ2l0IDxodHRwczovL2dpdGh1
Yi5jb20vaWxiZXJzLw0KPiBpc2FyLmdpdD4NCj4gLSAgICBjb21taXQ6IGE2MTcxODU2ZGU4NGRh
M2RlY2ExMzU1ZGE3YWE5YzA5NTg4ZTdlYTINCj4gKyAgICBjb21taXQ6IDM3Y2IwMTdhMGU2M2Y5
Y2MyNmM1ZmYxODA1MTkwYTk1Y2QwY2ZhZDkNCj4gICAgICBsYXllcnM6DQo+ICAgICAgICBtZXRh
Og0KPg0KPiAtLQ0KPiAyLjQzLjANCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4
IEV4cGVydCBDZW50ZXINCg==

--_000_TYCPR01MB966908622D9B64CEE3551B33C4312TYCPR01MB9669jpnp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&nbsp; Any idea which kernel config switch could negatively<br>
impact reproducibility?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I still need to check the details, but possibly the lzop based compression =
that was recently added for arm configs.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The reason I say this is because the difference in the vmlinuz file in the =
linked diffoscope report looks like some lzop metadata.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-weight: 700;"><a href=3D"https://cip-project.gitlab.io/=
-/cip-core/isar-cip-core/-/jobs/8566485827/artifacts/cip-core-image-securit=
y-cip-core-bookworm-qemu-arm.wic.p4.diffoscope_output.html" id=3D"LPlnk9778=
18">https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/jobs/856648582=
7/artifacts/cip-core-image-security-cip-core-bookworm-qemu-arm.wic.p4.diffo=
scope_output.html</a><br>
<br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Will debug for more details and get back.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Adithya&nbsp;</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr" style=3D"color: inherit;"><span style=
=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
"><b>From:</b>&nbsp;Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, December 6, 2024 6:14 PM<br>
<b>To:</b>&nbsp;balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithy=
a.Balakumar@toshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev=
@lists.cip-project.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [isar-cip-core][PATCH] Update isar revision</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">On 06.12.24 13:38,=
 Adithya.Balakumar@toshiba-tsip.com wrote:<br>
&gt; Hi Jan,<br>
&gt;<br>
&gt; Thanks for the patch.<br>
&gt;<br>
&gt; However the recent reproducible check pipeline run has failed due to a=
<br>
&gt; problem is with the qemu-arm image.<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/" i=
d=3D"OWAf997a310-1b2d-be07-6c19-9d49f57284bd" class=3D"OWAAutoLink" data-au=
th=3D"NotApplicable">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/</a><br>
&gt; pipelines/1576628108 &lt;https://gitlab.com/cip-project/cip-core/isar-=
cip-<br>
&gt; core/-/pipelines/1576628108&gt;&nbsp;<br>
&gt;<br>
&gt; The qemu-arm reproducibility also failed in the previous run (1-Dec).<=
br>
&gt; The problem seems to be that the arm kernel is no longer reproducible.=
<br>
&gt; <a href=3D"https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/" =
id=3D"OWA2c12fb0c-3fc2-0e37-0404-2b0790cdb771" class=3D"OWAAutoLink" data-a=
uth=3D"NotApplicable">
https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/</a><br>
&gt; jobs/8566485827/artifacts/cip-core-image-security-cip-core-bookworm-<b=
r>
&gt; qemu-arm.wic.p2.diffoscope_output.html &lt;https://cip-project.gitlab.=
io/-/<br>
&gt; cip-core/isar-cip-core/-/jobs/8566485827/artifacts/cip-core-image-<br>
&gt; security-cip-core-bookworm-qemu-arm.wic.p2.diffoscope_output.html&gt;<=
br>
&gt;<br>
<br>
Yeah, also saw this.<br>
<br>
&gt; I am yet to investigate the root cause of the problem. But just<br>
&gt; wondering if the problem could be because of the move to the merged<br=
>
&gt; kernel configs for arm?<br>
&gt; &lt;https://gitlab.com/cip-project/cip-core/isar-cip-core/-/<br>
&gt; pipelines/1576628108&gt;<br>
<br>
Would be worth a try, but then we would still sit in front of some<br>
larger config diff. Any idea which kernel config switch could negatively<br=
>
impact reproducibility?<br>
<br>
Jan<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; Pipeline =A1=A4 cip-project / cip-core / isar-cip-core =A1=A4 GitLab &=
lt;https://<br>
&gt; gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1576628108&g=
t;<br>
&gt; Debian/Isar layer to generate images using CIP Core Generic Profile<br=
>
&gt; packages and CIP kernels<br>
&gt; gitlab.com<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:*&nbsp;Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
&gt; *Sent:*&nbsp;Friday, December 6, 2024 3:18 PM<br>
&gt; *To:*&nbsp;cip-dev &lt;cip-dev@lists.cip-project.org&gt;<br>
&gt; *Cc:*&nbsp;balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithy=
a.Balakumar@toshiba-tsip.com&gt;<br>
&gt; *Subject:*&nbsp;[isar-cip-core][PATCH] Update isar revision<br>
&gt; &nbsp;<br>
&gt; From: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
&gt;<br>
&gt; Brings two improvement for image reproducibility.<br>
&gt;<br>
&gt; Signed-off-by: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;kas-cip.yml | 2 +-<br>
&gt; &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/kas-cip.yml b/kas-cip.yml<br>
&gt; index abdf92af..1c868afc 100644<br>
&gt; --- a/kas-cip.yml<br>
&gt; +++ b/kas-cip.yml<br>
&gt; @@ -22,7 +22,7 @@ repos:<br>
&gt; &nbsp;<br>
&gt; &nbsp;&nbsp; isar:<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp; url: <a href=3D"https://github.com/ilbers/isa=
r.git" id=3D"OWAdde5a230-5e53-78a2-209a-509496ad62af" class=3D"OWAAutoLink"=
 data-auth=3D"NotApplicable">
https://github.com/ilbers/isar.git</a>&nbsp;&lt;https://github.com/ilbers/<=
br>
&gt; isar.git&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp; commit: a6171856de84da3deca1355da7aa9c09588e7ea2<b=
r>
&gt; +&nbsp;&nbsp;&nbsp; commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9<b=
r>
&gt; &nbsp;&nbsp;&nbsp;&nbsp; layers:<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meta:<br>
&gt; &nbsp;<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
--<br>
Siemens AG, Technology<br>
Linux Expert Center</div>
</body>
</html>

--_000_TYCPR01MB966908622D9B64CEE3551B33C4312TYCPR01MB9669jpnp_--


