Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6198CAC5BA
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 05:02:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.8443.1726635749130894463
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Sep 2024 22:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=IK+xrGup;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1726635747;x=1727845347;bh=BDA
	MI2pRB81UsRPusDCATcXrXG/7PMgXzo27tNgXblQ=;b=IK+xrGup998nhmLHAWqfDfj7ixSZ12CCF
	JO4hy0RMYTzB1kymTAv3QhmWgwrc5Bz06AW0g8MWX8EWaZoNG9UeSWiM7XdTimHK/Db3v83MrT6CD
	HYCczkC0o/snQ4NY2uavnXdbJqJIGqCcWltS8EdUHMrutOpiGcRj3JsuuFYkWQ8hdSk/oUrB1ufNK
	x6uiJznLXxKqjj4l416Adz3guC7nnrBukk0b70bvsC3yzycLrbc1GXhMqcqX88K9ls9jVW1kQHMzd
	5boOBIR/rul5Ry43hFk+3mH42NDZ6K9Ej4gYCoYKoFI5q1auOsuls1ze/85fhouRmWNeoeLLe8wxG
	A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 48I52QQk3778078; Wed, 18 Sep 2024 14:02:27 +0900
X-Iguazu-Qid: 2yAaPcpxoN94tuBPmt
X-Iguazu-QSIG: v=2; s=0; t=1726635746; q=2yAaPcpxoN94tuBPmt; m=9v7o0O6d2OWDmg7khJG/ukat8FcX1zwpRwGuriTTUPo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 48I52PgR749669
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 14:02:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcNqHbD0lLyQhvYePF6KzqyDZLpBSSeDB8KkmD392PEjlkDcutTjIDK8hZQc/tFgaWJMzaEcvhInZCY0hZRvvftb1cncIxxuHAWUrDKMHkOe6Qf/WkYJ12YRTqd9NoavvOwvKgb77rhJRII6PDehJdV++fAqxcglGLRpPJtBhEbTH8yO40A7OyXSQ0tL2fvhBcmEXXTg29B0n7DzKrPzoLwsDFDZ2bvNZzWi8h8SLNJl43l0AdnDjQuFDRt6b/3p6OBcmKPnr433yHg0PX7jdsPz02Q9BDIRxEnfayTMlRnpcN4vlzCaNVrLYR8Zxoifg5Ok6m7/vjAGoz33YlPXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJcpkxZ1/fgpAIhs0hGNlGRd8W/lRy2aegbeLsGUUc8=;
 b=MDUtD50xlK371RDM5MpaCQG4JtZMsFHUoPJRIATLZu7JwouSY7TcNqS90anP6Qr+Rkjo8BPG5Rey4c2IRik+/sGBvZesjVv4e+r1cm9UUufaCk1G7frOCwYOpsMCCXo18qieb0ntSslla/KHPBHaGBPZjmkrBgNobmTFhkJEvPvt4ikPEh2D0R1uejJuTKZZBKrpcMvg5eRGM5QfyuiO7BEW/e/6+DvHEY/MFq2jj1750JhlclvmJqW5oDYGkBd6m2XMuicKKUCxwSX9GwW/y4biHt8to1gsl4yBbgYa4rm0XA7rZp5Gdf+nfvbSh52ssWYWaRWxM0lFkp2UxguRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [4.4.y-cip-rt][RFC] Repeated WARNINGs in unpin_current_cpu()
Thread-Topic: [4.4.y-cip-rt][RFC] Repeated WARNINGs in unpin_current_cpu()
Thread-Index: AdsJh4OWhCfjKTeTTpWNGegB8O3M+w==
Date: Wed, 18 Sep 2024 05:02:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYWPR01MB9572:EE_
x-ms-office365-filtering-correlation-id: e2953bc9-20f3-40d3-16e9-08dcd79f1493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VjBraTMrYkhja3ZXaVRTNFU3MUpDY2s0NkpEa0dYZ3QzY21yR2ROZ1Bk?=
 =?iso-2022-jp?B?c3MzVmlvUTd0MzdXTk1vSnczbkUyd0dSY0lQY2FKMkZmWldwM2U5bEhI?=
 =?iso-2022-jp?B?dm9sNUJkM1NETjVEZUdYTEt6M3FlR3o3VmFhWW0xVW5TZFBmRnVuaHVF?=
 =?iso-2022-jp?B?MC9xQWZiMmUwM25SWVg5b3lITUVCSVRxd2Y4Q1B0elM1WVgrenYxa3VF?=
 =?iso-2022-jp?B?UzRxZG9hYUhoOEM5SGVHaE53cE9YbkpQYXJyS2hyNGxnZXk5R3N0VU9r?=
 =?iso-2022-jp?B?cy9MM0pUb21nTzh5ZnJyUXFUWXNDMnZWeUVwcFVyYTY3UWhaUFhDWDVw?=
 =?iso-2022-jp?B?VnVRVk81WjllSTcrWUwyZy84bFNrck92eEZpbjhOeXhSR1dKZjVIRXJn?=
 =?iso-2022-jp?B?VzNHU29RcGhObEdsYjN4K1lhYVNNVjZ6aHUwQk5Mank3aHBlZE1lRUdS?=
 =?iso-2022-jp?B?VEJCS2dQT3huOFppQkttSjRjNHZ1dGRMYXRnU3pCUEgwSzZKR1BSUEJ4?=
 =?iso-2022-jp?B?Vk1oWU1jYXdqa1lOSG1LYWRyNFExN1k5ZzVITk5GR2owNktBbEJHVzQw?=
 =?iso-2022-jp?B?N0szeTdPWUg3YklFRGU4Q21WcVZxcE8zU01NR2hqdmgzN1NrMjhHajBo?=
 =?iso-2022-jp?B?TVdQYmE0VENOSVJCWjQ0OUxQaTYyaTlTZ0dwK0JJaUs1T0daOWZGTEZl?=
 =?iso-2022-jp?B?cmtFcXk0QkdYcG9iMmVmZksza1ZqZGF2cUxJSG1sQzZ2bnFvaFRvV3NF?=
 =?iso-2022-jp?B?eENyQ25hVTJZNnRwNWlxQjVidkhQMGpLTTRNVUUzTnF5MXdNWk5XbTFG?=
 =?iso-2022-jp?B?MHR3ckNvd2pmcW54ZE9YT25IN2Fab0cvb3RNQmg5WktaTWkxZGRzbWVR?=
 =?iso-2022-jp?B?LzR3M3Y1bkpjTHRMRzhTUXRxZmpIUnR5eWduMy9abC9SQ042NDFkQ2l6?=
 =?iso-2022-jp?B?cHZKVmtqK1Z3NTNXVitkaDY0eHVUNm96OHIxcFRQdHd3VHR2YVVOWHp6?=
 =?iso-2022-jp?B?N2h3OWxJYytnaXV4ZTQyTnN1WUF5RGppUTB4dEwzNXBqTHh2dDRtaWov?=
 =?iso-2022-jp?B?ZXpiVHhTUjB1OEpLZTd0K25iOXBCNlNYVlRaN1pvb1orM0ZKaTdFUGlr?=
 =?iso-2022-jp?B?K0ZFV21Bc3RnKytSYTBZMERsZlRiMXh3RDFUdDBwUjdUY0ZlRzRhVURq?=
 =?iso-2022-jp?B?LzlYUFI2ZWExamtaSWZwYkw2ZmZCWldzRXVEeDQycHRQcFhVUUdIT2g0?=
 =?iso-2022-jp?B?SHh3V2JmaGltM3BIaVZLTkNlb2dnSFR5cWRobTk0aVFFSW5uNFF0aHEx?=
 =?iso-2022-jp?B?bTIvNDFOT2RXSU0xMFdSeWk3UlFBanVRRTZzWVFpUHkrREFFMmhXWk5y?=
 =?iso-2022-jp?B?ZHNEOTZ5QUVPZHBkNzJ6NnhuVFhCOGhMODUzUlhUdjNDMUJ2UmR0SzNR?=
 =?iso-2022-jp?B?NHBYOHJEOGloTlZ5UEthZHZXcm81NVhQb0s1NWVSUnhhK0paYitUNno0?=
 =?iso-2022-jp?B?aHQzdUZDRzFkK2xVZThucHFCaGFhY0R2MU5NNHlqZmNnL3c5Y3pNd3No?=
 =?iso-2022-jp?B?MWtROTRObVlaaE1YMHBYbFJPY3AwaVU4RFRzUVNyZUUzaVBBRjZkbGd1?=
 =?iso-2022-jp?B?NzRYcnhKYXk5M1pKSDZlR1pyMnNDaVZOMndUSlZlbFBJeW1FZXptSXN4?=
 =?iso-2022-jp?B?Zk80d0V2a3p2ZHNoYzFMMzBuT3ExdllQQ09GRXN4SXlYV2xQbDI3TGtq?=
 =?iso-2022-jp?B?d2RmdkdLMXBsMGNxQk5MZzRRR1JDcnVrZTZFMjQxbzZUb3BoWmRnVlJM?=
 =?iso-2022-jp?B?Uzk1T3dQd2dwbkNVRndlaHpsQWc2S2EwSXoxUC9HS0VkRElQOURuS0wv?=
 =?iso-2022-jp?B?NkNsd251V1B5MTgrN0IveE1JcUlzeVBpMC84ODZJRnFwdGQ2MGNnSzQ0?=
 =?iso-2022-jp?B?dzFJVEtUcENRQ2M5ajZROVArdEJtSFErUktzQm4rL3dBQWE4NVJJVnRa?=
 =?iso-2022-jp?B?UnBEZmFqY3I2OUVycmFJWkFSWTBQdCtSQTdwdEUrRTRXUDQzWkVsM1FZ?=
 =?iso-2022-jp?B?Y1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L3ptYlQ2dXhTUit3VzFKckN4YmwwQlhMZXhYTjAzNmplaUFtVUFMRUlJ?=
 =?iso-2022-jp?B?R0JBK3ZFRk5STiswNjNQNFlaRGxGVzV5VVVPcjFMM0JUak5JUGowNS85?=
 =?iso-2022-jp?B?dGZQTDRsWExyQzJtcnp5YkFzWUpRRUlaNGdZMEJNVkkxODBKbXdLejNl?=
 =?iso-2022-jp?B?VkZESElScEUxbUl4enV3U1NzRlVZajZEb1p2YzcrSE5QeHVraVdYem4r?=
 =?iso-2022-jp?B?Q2lyRnduaG4rVlZVRXlUT1BQSVYybEZUTUtDZFd1WVNpODlzQ1JNM3cv?=
 =?iso-2022-jp?B?WW1kdHFiNi91MVl6OXFZZS9MV0Rwc21wcnpzMnliOTI5YkxVT2NjTHdk?=
 =?iso-2022-jp?B?MW40YWU1SWZ6Z1VwTnZWcTBxSlpkY3VFTmhLa1Jhd1BUSkN1N3ZuMkVo?=
 =?iso-2022-jp?B?bTdtSUZUTCtVT2MrOE1RK0xMTENHNFFBcUlCQUxNejhBdmZMQ3F6M1p1?=
 =?iso-2022-jp?B?a2lRZWRvbWFEZ3o2NkE2YjdKYWRPV1ZkbkxtNGhBS1VlMXZEbWtTRnpP?=
 =?iso-2022-jp?B?aUNJMXBYZUN2LzR1cVlsV0Q1bFUrcmMra2pxQlFSZWhPZ0RVNi9IcXM4?=
 =?iso-2022-jp?B?YlhMSDNYWWRLOWVOQVdwWVNLcWd2SUtBM3lQcGs0QjVWR1ZoQVgxZ3NN?=
 =?iso-2022-jp?B?MksvMlk2cTdHcWtjMXVqWVZUak4zcHM3c25TWGcxdTJCamZTM3BnVWQ2?=
 =?iso-2022-jp?B?OFZHYTNkRzFKOVBDaUxSSVRtVEluQmZMbVRVaWRyTGJoRnVhelJyTkNy?=
 =?iso-2022-jp?B?OHB2VndnS2JIUDJxeHBrQk5vVGJqY0Npd1FFM05LVnkwTDYycUNFaUZH?=
 =?iso-2022-jp?B?UUxGTmpuR0NIWWlvK04vSW1GQjdIUWF5V0pGVWEvNlo5SkcyQUxGU2NM?=
 =?iso-2022-jp?B?eGk1UXVKTnFHcmJXS0pvNUV6aEFheTdjRUhDTytvNmVZbXNJNWxQN3NS?=
 =?iso-2022-jp?B?WTM5ZGRINS9pTlJ3WUkxaUdtemFjclJKYm9Xdjc3QXZENkU2V1R3MjR6?=
 =?iso-2022-jp?B?RnlKaGQrM3BseFUwbkFCeFFldnN1REd2TDNnNGVCd2llcEtWN2ZyTUFJ?=
 =?iso-2022-jp?B?amJWWGlKZE5tM3o2alMxQnJJaGpyeTMvQjVmdkV4YUxzWEVNaXRwTEtU?=
 =?iso-2022-jp?B?a1VhU253OGlaNER2bjNidS9WbVBpY09SV3FOVEJZVFFsajdjUHB6dE1w?=
 =?iso-2022-jp?B?Nk40TFRRUHZ0SjZqL3pKZmxKVjZrSTVCRFNSeWxYbE1KcFcwUk5BZy93?=
 =?iso-2022-jp?B?eXlFU0NUQ2xYL3pyVkxWL1ZGc00ycmxaV1FNUnZkVXM0OUEvcmlXRFRX?=
 =?iso-2022-jp?B?Ukh5ZjBFM0FqWktJY2pFQllRUFNJVmxBeElZN25OMkVwM0F6d0Z1TFh5?=
 =?iso-2022-jp?B?Y3hVMlNXZ2NiQm1rTzdBZ2V4emVyMDRrd1Q1cUQ0dFdxUzZWYXdPRCtL?=
 =?iso-2022-jp?B?cE5qRkpoRDVVQUJxL29aUTVRL2xWTlBXaFRhdW5OMzh6b2U3YllDRHBl?=
 =?iso-2022-jp?B?ZVB3VmNISTRtT3hONUtTWHJnRzR2cFgxSW9JU2IrRzVPRkR4ekQ4d3JE?=
 =?iso-2022-jp?B?RitKeVdYRU1kcHhnNzg4azExejlOSlg5VkRnQ002YWNDWU9BRkxJM1pY?=
 =?iso-2022-jp?B?M1laM0RzRXBjZk9LTmRkNEhBM2ZTZTcwa00xbGNuaHdwMDNvazhrZVJS?=
 =?iso-2022-jp?B?U2hXWjV4SXhVeEo0bjMra3dRVW5QUTZnenZaNjdXYVpLRVFkNDJxcHZB?=
 =?iso-2022-jp?B?dDI4b0VieW9MMUd1Y0N6aE5ES2VtbElYMGF4aEdDdFo3VUZ6VW5YN0pw?=
 =?iso-2022-jp?B?ZktmMjlmRXF2TnFYNnoxT1F2eE5uSTdyOHhnL3NhcTRtU0pIZTFwU1lL?=
 =?iso-2022-jp?B?aHZIcWJ5blhMTFpuSkNXenR2cS9NZW1lM3hQN1ZHb0d2ZkN2K2ZVeURk?=
 =?iso-2022-jp?B?TG1iNzJnS2ljYk0wVUVkSTROMXg5NjdzaDA0emJ3MEw3RDluc2g2VmZE?=
 =?iso-2022-jp?B?RmpZK0l1NUNFTVZNdENKeG1PdjhyNkNSNzBjZXk2aExWL0FmdGNpWmJH?=
 =?iso-2022-jp?B?Y0x0Z1dKeHhyMFJVd1IrQ0phQjdFdkV3Y3VCeDhZaWhJUDBONUlJWGNz?=
 =?iso-2022-jp?B?aG5JRVZVUkJOYzh2RXlYYW16b214ZGVTc252SDBqU0ZQODlXK3RNb3Z2?=
 =?iso-2022-jp?B?aHUyNGovVnRNS0FGdXdXcXNYa2xLa01KUzY5TTh2Y2VWOE5KZ0FxYjhI?=
 =?iso-2022-jp?B?MUNWUGRkczZtUVhlQm5uUHRsSFlhWXkrVUJqdm9Xc0RadithMjhKRVdV?=
 =?iso-2022-jp?B?b0hBekNFU2ZGVmp2Y3hPbEd6ZFdJay9FU2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2953bc9-20f3-40d3-16e9-08dcd79f1493
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 05:02:22.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8ojQgg2k+Rkk615U+QblWnkUxEX6p4vHXerXX9xI35K6C0OgGK6CELzN32AicFpEmTB7ZXkSpBHnOICSvPbYtZmSi32DMaeD1UUmGekjbeCeQ9Eau5gzqJxjqqPLoJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9572
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Sep 2024 05:02:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16907

Dear kernel maintainers, and all CIP members,

I'm facing a problem while running 4.4 CIP RT on x86 machines.
Let me report the things I observed so far.
It's appreciate if you can look at them once and give me your feedback.

=3D=3D=3D Appearance of the problem =3D=3D=3D

The following WARNING (and call trace) is printed on console repeatedly
and very frequently.
It seems kernel cannot process anything (but still does not panic)
while the WARNING is printed.

WARNING: CPU: 1 PID: 18 at /path/to/linux-cip/kernel/cpu.c:197 unpin_curren=
t_cpu+0x60/0x70()

=3D=3D=3D Reproducibility of the problem =3D=3D=3D

I can reproduce this problem only while kernel booting (before mounting roo=
tfs).
The problem happens very rarely and randomly.
Only one time in around 1,000-10,000 reboots.

Please note that currently I has not been able to reproduce the problem "ye=
t"
after kernel boot finishes, which means the same problem could occur
not only while kernel boot but also in userland.

=3D=3D=3D Conditions in which the issue can be reproduced =3D=3D=3D

* Hardware: VirtualBox 7.0 VM
  * The number of CPU cores: 2
  * Memory: 2GB
  * EFI enabled
  * Storage: 8GB SATA disk
* Kernel version: v4.4.302-cip89-rt50
* Userland: Debian 8 jessie
  * As described above, the problem happens while kernel is booting so
    which userland is used is not matter except kernel parameters setting

Just for your reference, please note that the same behavior can be reproduc=
ed
(i.e. the same trace I got) with the following proprietary x86 physical mac=
hine,
where some custom patches for the SoC are applied on top of 4.4 CIP RT thou=
gh.

* CPU: Intel Atom x7-E3950 (Apollo Lake)
* Memory: 4GB
* UEFI firmware
* Storage: 4GB SSD
* Note that there

The kernel configuration is created by merging the following simple ones:

* arch/x86/configs/x86_64_defconfig
* A fragment file with the following configs:

CONFIG_PREEMPT_RT_FULL=3Dy
# ftrace just for investigation
CONFIG_KPROBES_ON_FTRACE=3Dy
CONFIG_UPROBES=3Dy
CONFIG_TRACER_MAX_TRACE=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_FTRACE_SYSCALLS=3Dy
CONFIG_TRACER_SNAPSHOT=3Dy
CONFIG_UPROBE_EVENT=3Dy
CONFIG_DYNAMIC_FTRACE=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_STACK_TRACER=3Dy

JFYI, here is the kernel parameters I used.

crashkernel=3D128M console=3Dtty1 console=3DttyS0,115200 consoleblank=3D0 \
panic=3D0 oops=3Dpanic panic_on_warn=3D0 unknown_nmi_panic \
ftrace=3Dfunction trace_buf_size=3D100M ftrace_dump_on_oops \
ftrace_filter=3Dmigrate_disable,migrate_enable,(and other funcs to take tra=
ce) \
trace_event=3Dirq:*,sched:sched_switch,exceptions:*,kmem:*

=3D=3D=3D What triggers the WARNING =3D=3D=3D

The WARNING is printed at the following code.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89-r=
t50/kernel/cpu.c?ref_type=3Dtags#L197

This happens only when hp->refcount is attempted to be negative value when
unpin_current_cpu() is called.
hp->refcount (signed int) is to describe the number of request to prevent t=
he current CPU
from being unplugged and is incremented by pin_current_cpu() and decremente=
d by
unpin_current_cpu(), which means the value must not be negative.

Guessing that the repeated WARNINGs should be caused by that
kernel keeps using the broken (negative) hp->refcount.

=3D=3D=3D What makes hp->refcount negative =3D=3D=3D

pin/unpin_current_cpu() is only called from migrate_disable() and
migrate_enable() which are defined in kernel/sched/core.c.
All those functions are only provided in RT kernel.

migrate_disable():
* Prevents migration of the current task to other CPUs
* Increments migrate_disable counter
* Calls pin_current_cpu()
migrate_enabled():
* Allows migration of the current task
* Decrements migrate_disable counter
* Calls unpin_current_cpu()
* Print warning (once!) when it attempts to make the migrate_disable counte=
r negative
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89=
-rt50/kernel/sched/core.c?ref_type=3Dtags#L3246

When I replace the WARN_ON() above in unpin_current_cpu() with BUG_ON(),
it is always observed that the migrate_enable() WARNING above is always cal=
led
just before the unpin_current_cpu() WARNING. Here is a sample of trace resu=
lts.

kworker/-852 0....11. 930172us : unpin_current_cpu <-migrate_enable # migra=
te_disable=3D0, refcount=3D0
kworker/-852 0....... 930174us : migrate_enable <-rt_spin_unlock    # Attem=
pt to make migrate_disable negative
kworker/-852 0....... 930176us : migrate_disable <-vprintk_emit     # WARN_=
ON_ONCE() start
...
kworker/-852 0....11. 933420us : unpin_current_cpu <-migrate_enable # WARN_=
ON_ONCE() end
kworker/-852 0....1.. 933421us : unpin_current_cpu <-migrate_enable # Attem=
pt to make refcount negative

I can conclude that disabling/enabling migration is unbalanced when the pro=
blem happens.

=3D=3D=3D What makes migrate_disable counter negative =3D=3D=3D

migrate_disable/enable() are used anywhere in the kernel.
Here is a trace of the two functions (simply filtered using ftrace_filter).

              IRQ  migrate_disable
               |     |
# IRQ disabled v     v
irq/368--1007 1d....13 6352050us : migrate_disable <-get_page_from_freelist=
 # +1 (unchanged)
irq/368--1007 1d....13 6352051us : migrate_disable <-rt_spin_lock          =
 # +1 (unchanged)
irq/368--1007 1d....13 6352057us : migrate_enable <-rt_spin_lock_slowlock  =
 # -1 (unchanged)
# IRQ enabled
irq/368--1007 1.....13 6352065us : migrate_disable <-rt_spin_lock_slowlock =
 # +1
irq/368--1007 1.....14 6352066us : migrate_disable <-rt_spin_lock          =
 # +1
irq/368--1007 1.....15 6352067us : migrate_enable <-rt_spin_unlock         =
 # -1
irq/368--1007 1.....14 6352067us : migrate_enable <-rt_spin_unlock         =
 # -1
irq/368--1007 1.....13 6352068us : migrate_enable <-get_page_from_freelist =
 # -1
irq/368--1007 1.....12 6352071us : migrate_enable <-rt_spin_unlock         =
 # -1
irq/368--1007 1.....11 6352072us : migrate_enable <-do_current_softirqs    =
 # -1
irq/368--1007 1....... 6352072us : migrate_enable <-__local_bh_enable      =
 # -1 (WARNING)

The result shows the pairs of migrate_disable/enable() do not work together
at all due to the IRQ disabled section.
Considering that those functions return immediately if the IRQ disabled,
all disable/enable pairs need to be called in "either" the IRQ disabled
or enabled section.

Another point observed here is this failure of the counter always happens
inside get_page_from_freelist().

By taking more traces of the functions called around the IRQ enabled,
local_lock_irqsave() or local_spin_lock_irqs() called inside
buffered_rmqueue() enable IRQ by calling schedule().

* https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89=
-rt50/mm/page_alloc.c?ref_type=3Dtags#L2346
* https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89=
-rt50/mm/page_alloc.c?ref_type=3Dtags#L2378

Here is an example of (manual) tracing of local_lock_irqsave()
including inlined functions when the problem happens.

get_page_from_freelist() @ mm/page_alloc.c
  buffered_rmqueue()
    local_lock_irqsave() @ include/linux/locallock.h
      get_local_var() @ include/linux/percpu.h
        migrate_disable() ***
      __local_lock_irqsave()
        __local_lock_irq()
          spin_lock_irqsave() @ include/linux/spinlock_rt.h
            spin_lock()
              rt_spin_lock() @ kernel/locking/rtmutex.c
                rt_spin_lock_fastlock(slowfn=3Drt_spin_lock_slowlock, do_mi=
g_dis=3Dtrue)
                  might_sleep_no_state_check()
                  migrate_disable() ***
                  slowfn() # rt_spin_lock_slowlock(mg_off=3Dtrue)
                    migrate_enable()  ***
                    schedule() # IRQ enabled & context switch occurs
                    migrate_disable() ***
                    ...

The question here is whether calling local_[spin_]lock_irqsave() in
IRQ disabled context is allowed or not. IIUC, invoking schedule()
when IRQ is disabled should be a context violation.

Ref: https://wiki.linuxfoundation.org/_media/realtime/events/rt-summit2017/=
using-coccinelle_julia-cartwright.pdf

=3D=3D=3D What calls get_page_from_freelist() with IRQ disabled =3D=3D=3D

According to additional traces, it's clarified that kmem_cache_alloc()
can call get_page_from_freelist() with IRQ disabled. Here is the trace:

kmem_cache_alloc() @ mm/slub.c
  slab_alloc()
    slab_alloc_node()
    ...
    __slab_alloc()
      local_irq_save() # IRQ disabled
        ___slab_alloc()
          new_slab_objects()
            new_slab()
              allocate_slab()
                local_irq_enable() # only in specific conditions
                alloc_slab_page()
                  alloc_pages() @ include/linux/gfp.h
                    alloc_pages_current() @ mm/mempolicy.c
                      __alloc_pages_nodemask() @ mm/page_alloc.c
                        get_page_from_freelist()
      ...
      local_irq_restore() # IRQ enabled

Note that local_irq_enable() is not always called in allocate_slab().
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89-r=
t50/mm/slub.c?ref_type=3Dtags#L1412-1419

There are three patterns of executing functions, but it seems
the problem only happens under the pattern 3.

1. local_irq_enable() is called
2. local_irq_enable() is not called && schedule() is not called in buffered=
_rmqueue()
3. local_irq_enable() is not called && schedule() is called in buffered_rmq=
ueue()

The call stack above when the problem happens is definitely possible to occ=
ur.
The question is where the actual problems are in that sequence.

=3D=3D=3D Related changes in newer RT kernels =3D=3D=3D

I have checked if any fixes / updates related to the problem itself
or the functions in the traces above, but nothing found (yet).

There is a bugzilla thread that is quite similar situation here:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1441552
However, it's about 3.10 based RT kernel with the custom patches,
some of which are RT patches from (RT) upstream, and there are some
differences in WARN() and BUG() implementations around kernel/scheduler cod=
es.
This thread is just concluded by just reverting several backported RT patch=
es.

I cannot see any big changes about the functions above in v4.9-rt so far.
Interestingly, the following significant change is added from v4.14-rt,
which refactor migrate_disable/enable(), and completely delete
pin/unpin_current_cpu().
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/comm=
it/?id=3Df9bf712ca9fcf2c77f69f879b29893fed31878d1

=3D=3D=3D Queries =3D=3D=3D

I'm still trying to check more detailed behavior and the main cause of
the problem, but it's quite helpful if you give the following information:

* Whether you hit the same or similar problems so far
* Clarification about my guess in the sections above:
  * Calling local_[spin_]lock_irqsave() with IRQ disabled causes context br=
oken
  * Anything wrong in the sequence inside kmem_cache_alloc()
* Other kind of traces I should take
* Other parts of kernel that I should investigate
* Patches or discussions in newer RT kernels relatedly to the problem
* Other devices I have to try to reproduce the problem

Best regards,
Kazu


