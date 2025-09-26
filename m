Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB75CAC5AC
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 06:02:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.11064.1758866538622286371
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 23:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 58Q627Ml498582; Fri, 26 Sep 2025 15:02:07 +0900
X-Iguazu-Qid: 2rWgFt13WEch8DZA1i
X-Iguazu-QSIG: v=2; s=0; t=1758866527; q=2rWgFt13WEch8DZA1i; m=Nivko49Ha1/ZpAIIFbFc4ySwp43etG8FEDQd73th65s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cY0NG4LP0z1xnm; Fri, 26 Sep 2025 15:02:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWe3Qpfnos/vFqaxvTShegHSXdwN3G4/jNptbTPHaKbBUvMO+BXjarQa5Og0EagxI4YyRFqZv115x6lCGFg5c5JnwDfd4qw4lGKfJXYilITiSsokEYIg9l/07NRLziAlkAsJvsv3p1ABaOGmSy3RlGrIkF7wo7JCnwnZBIdWIKTlhm2x9Z98+2Pd3dkXpFDUFmiC+mDVOugpmii8v0xROcaP0XVxNskZg4kPIuzQ6KyWrm/+B3dqESvvy3YPWLfmQeMCkRrOb1/kssauQvHP/gl+VKKfNIHSmPjC8isJqXkaM9J4KOWvBfi4NiGK9ztRieLbt20GqpdmrLtEXzGCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wNBocpfX8k4VHiQUULQy+w/CGH91NbB/aC82/qCkbg=;
 b=u7dTk1DaHgAIRE2QhmXAj6KGmtTcXGB8pc8e4du81EJ1ENHT2sxnMM+qXiZWLqYaLL4vZ3nEirDxa0ejZV1JfmqPeMJ8/Ga+JJHbp+pvxX+C8SwYDe1tXQ0x3DoAe1I6OEC/Tbo0yNDvNJe9W8sfIyQGMVu1iopsb4KeruFcz83kZbH2ccziPjZYQSmk/kk5PO5MBu4feI0ibOHeLl2MPA3+6aAJKZVxfdRsv6g+e4i7hqibSGnZl+ThB4J/AH00u/6z96PNZB7mIBwjvfLuTRz04njpRDjuK90I4x7jAO+c7Jq5u7sG1tUMs0NHYfT3cVjRYGFrWC35OBUQ1cq0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <pavel@denx.de>
CC: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: Threat model documentation for kernel
Thread-Topic: Threat model documentation for kernel
Thread-Index: AQHcLhCKQFlvImV7akONdCp9NhkyXbSk+Ohw
Date: Fri, 26 Sep 2025 06:01:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB8515CA230A6C9A599F8CFEC6BF1EA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <aNUo+0Mc3ez9ufD2@duo.ucw.cz>
In-Reply-To: <aNUo+0Mc3ez9ufD2@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|TYCPR01MB8785:EE_
x-ms-office365-filtering-correlation-id: c124911e-3c5c-464f-bf50-08ddfcc22b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?clRVeWFhSE9ETUUvUkF0U290RWFUVmhnbkRVQWZVeGZ0SGZkOTNlUWl4?=
 =?iso-2022-jp?B?WHpKdUhHbDVXYjlWSmNzWjdKUTdnOWQ1OHQvcGQyU2xEWm9PNFNsUnlr?=
 =?iso-2022-jp?B?ek1FbHd4eXByRUtncFVNRmM0V3JxREdpMXdRTHgrK1dFTU1NQ2NYUFc1?=
 =?iso-2022-jp?B?T3J1MmpYT2pId3RVYjFEVXA2NGpSeEFrR0sxeVR6VmdlcTNDTTA1ZmFv?=
 =?iso-2022-jp?B?QngrM2NjaGZwTUtsRW1abkt1Z0VJUDJrMlllVWxIRnBTNXpDbXdkMlBT?=
 =?iso-2022-jp?B?QmZkUWVHR0xqbk1CVXd3cnA4dStXRmI2a0FuakdTUmR4d0UycU5kemp1?=
 =?iso-2022-jp?B?bXlhOXBhUEJqSW9zdGM3bC91THFFWVNINFdlMWg3Z0VQS05WMmtPVS9u?=
 =?iso-2022-jp?B?L2lsNlRsMW5mSGNxaFpoU2R4Y2tPcDAwdDNLaDFzblhKeDQ1SnZZOWZX?=
 =?iso-2022-jp?B?eHZlTk95cTZoL0R2T1dMNnJnTTZpZXc4WXV1aWQwMGl6enh3cjdiU25q?=
 =?iso-2022-jp?B?K0d6YVR4TkdtQ09nNmVTSFQrUFlXSmVlYWp1T3B1VDVFK2o2MnhRNEZU?=
 =?iso-2022-jp?B?K1F4dnJtYmU4U1d0M1UvWlR3NlJvVUE3MVF2UVo2T2FCODVkRWFwbXM0?=
 =?iso-2022-jp?B?TkE5ZGlKZFNMMU02ODBUdk50d24xbUFUR1RTY0pUdVBiNVhSKy9yN0Zy?=
 =?iso-2022-jp?B?bFduV0dHWExONFFKQ3d1Mm9UeVdGaTlrb0UyNTdvTFg0cTMwWWs2dm55?=
 =?iso-2022-jp?B?OWRHMmMveGo4bFZ0UEJ0VThaa3VSY2tUV0MwOXRSKzZ0eUQreTU1M29u?=
 =?iso-2022-jp?B?dVZvY2xONVJScEpPZ2t4M0VuUjc0bi8vNTQzcGRWQi8zUi9hRTdVZWpJ?=
 =?iso-2022-jp?B?ZFBuall0L0F0TFdXWFRSVkt2OU5NcGVRa1RMemJiTDBPNEkxQjhGUnc1?=
 =?iso-2022-jp?B?NVJKWGdhaTVKSyszb2kxcHc5STN1SlhZVy9aYVVId0p6a09Gai9nUDdY?=
 =?iso-2022-jp?B?aUVDN29RU0NkYlVqQlNsRUsxekYzS2Q5RXNwQ1gzZjZDbTlNTjB4MU9O?=
 =?iso-2022-jp?B?azJGdk9GNnRQb3R1OXRlNDR4bUtnUnVRSVcybUVjWEdsMzBubCtYOU11?=
 =?iso-2022-jp?B?ZVQwRFFFOXNNTk15RzFRd2UzaDhvZU56UllzVHNFR21Zbk5CV3FHREZQ?=
 =?iso-2022-jp?B?WUZYL1ZVNTB5UFZZSTBzMjZwdVdoZ0ZSQ2RhMmFPaTFhQXZGYzNDSXRE?=
 =?iso-2022-jp?B?R0hYeHFFd1VtK2JLNjBxQWZjbXJPVWJZVFJNMU1WclJQN2laZWdLNEhx?=
 =?iso-2022-jp?B?Tmh1V3NCUEl1M0R1Q3J4dlp4VFRHUmRWRVpCcitROU80YUVHNS9qMHRM?=
 =?iso-2022-jp?B?bTdHSWdzcllBTHR3WmIrMlZYZVdPOFVrQ1ExSUE4YkVqT1YrV2VaZFlV?=
 =?iso-2022-jp?B?MXRMZXpUekJZT2FGM09nbnNLaUNFWXhld1M0T2pyNTl5WFF5U0gwbWh1?=
 =?iso-2022-jp?B?N0J0SDI2U0llQ25FbzBUY0J0UDc5bnlGN3ZJZGR6R01MV3AxQ3NzSjc2?=
 =?iso-2022-jp?B?TjJBVGsxdFk4S0ZKN1dwUGNGTFdVWFM4UzJhVDBEalUwWUswVXRDdjV2?=
 =?iso-2022-jp?B?Wm1tUDJVQ2JKZllvdmozdkpQd0FCbEhxT0VNbmtjK1RQY0dXYVp5N0Y3?=
 =?iso-2022-jp?B?U3pHM3I1UDB1c0VxSWNRZmMwMXVVcFBrSDZmT0g4QW93ZzEwc3RGbHpI?=
 =?iso-2022-jp?B?MDNMalRNR2M2ME9VZGdXcms4bGZ2SzM0TzI5ekZ6bStaakpIVkJhSXFD?=
 =?iso-2022-jp?B?MGVENlJjRkNVRUVIYzVLbFhWQUVOdTh4RjdVUlA2ZWtFQm1nR1NuM0li?=
 =?iso-2022-jp?B?bWhDTDREV3lyaVNOZkxoUU5TQ3dmRTU4eERDdDZWVVlOTW1CZlB5cDls?=
 =?iso-2022-jp?B?YnI3YkNNUW5vYXpxa2F0VTRBWGNoOTV5aVoySndVa05ZbFlTL0FxTC9k?=
 =?iso-2022-jp?B?c1Y2c3lPUDljcHNST2JheS9BeGJyNDhLcW4wcUY5dnhnbS9SQVFvMmNU?=
 =?iso-2022-jp?B?NG9UTHRYVFprUXQyOTJ6RkVaYVVFMmE3SHoyRitoWGpZUSs0dE9qRkRq?=
 =?iso-2022-jp?B?SFBRN2JhYUdsZkNtRUh0TVA3N3JpNzZnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MlVsTk1GbFE1L1JWSUdCL2VVMkNaWnhVaHZpaDdzY2NSdmNTc2lRTnJq?=
 =?iso-2022-jp?B?RjR0dlZTL1E5c3pQK2l5NHFjNnJQT1JMR1ZBaGlKenRNRGJqMURjNENN?=
 =?iso-2022-jp?B?Y2lpYU5pZEhHbCtHZ2VFbjZ5c2F3UjFlYVN5T01MZHZNdk1LU2h0RzVP?=
 =?iso-2022-jp?B?dUJkSjM3b0NTSWJxNmtGekRVMEdCZ0V1WG10OGZQWHZEZ2k2YjFvQjdK?=
 =?iso-2022-jp?B?UVo1WHNPa2I3WVVkV1p1MGdubGNlWDlEaUREY1hCZ29DNWxYSFhlc1Bi?=
 =?iso-2022-jp?B?TkUyaEt5bzkwZGNJdXFBTXJ6bW5uNThZVXllOURHWkxUdjlMbVVybU5O?=
 =?iso-2022-jp?B?eThuMEdSSEc0VHNQWjZzN1YyQStoeXAwMDkrZ0c0REw1WDdQRTUwMnln?=
 =?iso-2022-jp?B?QlNOSkRpK0tCSzQxZnk5WjJoL21YOUhVb2xRYXVRYU1iNSswN2k0SXJY?=
 =?iso-2022-jp?B?UXJ5M3BHNkxtZ1pPYU1TdnBBTmxrNkdGcU9XMVp3bGhsUHVhZTduUTdn?=
 =?iso-2022-jp?B?T3JoNnp4dVlLTElqZ2ZYa2pSTVVQTkREc1dQTVppS0JOdVZ3ZFl3NEFY?=
 =?iso-2022-jp?B?ak5ISTJWa01IMmREMXB5RDF6Z0NsUVFCem93a0VWdHFJODI4a0o2ekRE?=
 =?iso-2022-jp?B?WTE2allnZDdydW5nOTRpMFE3RWcxWFI2a0FqM0M4NXVuVXJqbTNkOWhi?=
 =?iso-2022-jp?B?ZTBoRnUvM1RlZjVzSER4NUV1WEkwODN0OXJ2NXpPYWpOT3dWbG1NY0p6?=
 =?iso-2022-jp?B?V0tSYmEzL3h2TWtMNEhjbkwvT25BZEtMNVNLWHVoNGI2NmRNUmNlVkN5?=
 =?iso-2022-jp?B?b21nbHc2K2VucFJ5R0hYdkxLeFI0Q2FNVFBtZFJCYmcwL1dxc3JCYWlL?=
 =?iso-2022-jp?B?c1ZJa2lnRDlsdmgxaEdUMjJrdEdseW0wRlg1amNkckNEbEx1ZTVhUk82?=
 =?iso-2022-jp?B?SGxMNjlJWjBPVzN1MzlPdDJubmlRcVdFakUrWWhSdnAzaTd3MTR1OXF1?=
 =?iso-2022-jp?B?VGVqRlBpTTljbHZqVHBDM1k4Zi9lVkIzajZHdEpUaXc3RGNVbnF0SURH?=
 =?iso-2022-jp?B?UmpIK3dqekFodlprNkhLL3hnS2trS2FsVXROOFVPUUc3WHFMc1FwMkh6?=
 =?iso-2022-jp?B?RjYxTDVrZmJDYTJ2SWhaQTAwTTRqL29LSi9mbnJ4aXF3SkY4OHExVU9j?=
 =?iso-2022-jp?B?eEw4N0M4M0lFMU5VdGdlTFVvalVMZ3pDWk1JajFuVFJ2M1JYM0pNVmdH?=
 =?iso-2022-jp?B?SlN1cVo0ZlZ3bnpORCtZcmxTdXVjT09WLzEvelBKYWlPUHloVlpMa1Yz?=
 =?iso-2022-jp?B?bHoxK0lZTkpyNDZqUnFiS0ZjeTJ5TTVBeTErVnVhWWFuSWg0bGsrS3hR?=
 =?iso-2022-jp?B?dFdLT2lmUVJYS2tJMlVtdHM4Tmo2c3I4cndnQ2V3Q1J1UHhsZ1Iva3M2?=
 =?iso-2022-jp?B?Vi9aKzRhV2RpYnlNK3FaS1hpaXRkblgrMXpKNlNYckVHbko4Rk94Q3NX?=
 =?iso-2022-jp?B?L3FEZUpIVms4bmxZVHJUNUtTUS83aWkrZEJuYkRlRE4zbUR6eUlGcEJ5?=
 =?iso-2022-jp?B?eFZ3dmJzdk9IcXY5MG5wQm9iV1JVTTBJRE83YVh6YzRHSTAwV0h3Rkgz?=
 =?iso-2022-jp?B?SWJSb0JGTzd0TTN2NEtNL1RQVGc0QTBWQ0k0UWkxNjd2dFBTenNzYkZz?=
 =?iso-2022-jp?B?WlRIWllIRWlWMytrRDN1Q2FXUXRyV0hFZHhSWkw1ekZHbWNYSlZ1MjhM?=
 =?iso-2022-jp?B?eXlaS2ZmaDBEWUY1bnl6OFJ6Y1hCOE1aNGNlbDEyVzRVaVBqNGZMQWtq?=
 =?iso-2022-jp?B?N3ZlYzFEVFZxT0pibzFrSnlhMFFkbGNpd2Zza3lqaHNPU1NVY3JWdDUr?=
 =?iso-2022-jp?B?NGZYOURIR1FkN1JDeXNKZ3VBaUsrdlg3MjgzQUlsRi9oeUM3VkFwMHp2?=
 =?iso-2022-jp?B?cGY3Mjg5MDYwUE5iMDNjNTZOd2VHZFQyZnpjSUJZZVp0VHFGY1o5cDBV?=
 =?iso-2022-jp?B?aTIvWmF6NUdSMmx2eHRsRHlKVUJhUXc5VVVlOWNHelVWTUxOeENwNzNO?=
 =?iso-2022-jp?B?SW93TWhpRDAvem5YTlZrQy8zVnhCTzloNmVoZnNSK0lLWktSbGtjc0U1?=
 =?iso-2022-jp?B?Y09RR0M2TzBqbHNmelYyTEswVEdQa1JqTC9kaEdZS0x3bkhrdXJ4amdT?=
 =?iso-2022-jp?B?eW1KWGJPLzFhQnMwOFlNd0Y1MVQ1VVhhZy82eXp2bFFMVGN0SGFLbFFB?=
 =?iso-2022-jp?B?K1BsazVUQTFpMmRnYzU5ZDFLZzFYSkVMY25yM0hnSXBVMmwvTlNKM2xS?=
 =?iso-2022-jp?B?cnlnM3B4aGJsRlJzbElhbFlsQTkvdURvZjE1ZG5DazYxMEl4WTVtV1hr?=
 =?iso-2022-jp?B?QVpxcUk5QWloZTE0Q01qOVY4WmpVK0dGcUNrWFFLbzBEaFpNUThxTzRq?=
 =?iso-2022-jp?B?aGN6cFZRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c124911e-3c5c-464f-bf50-08ddfcc22b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 06:01:43.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxV6b+BPYMkGrhGR5rtpbyRijpvrIJwSsAAMqoY604HkI39+giHKcxl/88NGClyRnQYsro3ThoujU8a8bjbiRJ3SHFL3FWzN3rBuL4ty35g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8785
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Sep 2025 06:02:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20145

Hi Pavel,

In Security WG, we plan to review the proposed kernel threat model and shar=
e if there are any inputs.
However, our response will be slightly delayed, and you can expect around M=
/Oct due to some key members not available immediately.

Thanks & Regards,
Dinesh Kumar

-----Original Message-----
From: Pavel Machek <pavel@denx.de>=20
Sent: Thursday, September 25, 2025 5:05 PM
To: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
Subject: Threat model documentation for kernel

Hi!

Below is start of threat model documentation for kernel. Did I miss somethi=
ng significant?

Best regards,
								Pavel


Currently, CVE numbers are assigned for any bug that is fixed by -stable
-- that is not only for security-related bugs.

To make sure relevant security bugs are given suitable attention, it would =
be good to define a threat model for our kernel. What is security relevant =
differs according to use case, imagine for example:

Alice runs an NFS server on a ship, storing black box data. Server is physi=
cally secured against unauthorized access, and only trusted devices are con=
nected to the local network, which is isolated from the rest of the world.

Bob runs a web server on the public internet displaying weather. Server is =
physically secured and only trusted users can connect over ssh.

Eve records video demos for youtube. You send her a binary over email, she'=
ll run it in her user account and record the screen using a camera.

Now, I'm pretty sure we want -cip kernel to be secure for Alice's use case,=
 and for Bob's use as well (provided he chooses reasonably secure web serve=
r and his ssh password is not "123456"). I'm pretty sure -cip Linux is not =
really suitable for Eve's use case.

Privilege escalation from local unprivileged user?

    $ ./tricky-code
    # id
    0

Resource exhaustion from local unprivileged user?

    $ _() { _ & _ }; _
    (hang)

DoS from local unprivileged user?

    $ cat /sys/foo/baz
    Kernel BUG ...
    Attempted to kill init, system halted

DoS from crafted filesystem.

    # mount /dev/usb0
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from crafted filesystem

    # mount /dev/usb0
    (shell appears listening on port 1337).

DoS from malicious USB device.

    (plug in USB device)
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from malicious USB device.

    (plug in USB device)
    (shell appears listening on port 1337).

DoS from malicious device.

    (CIA exploits firmware on Wi-Fi card).
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from malicious device.

    (CIA exploits firmware on Wi-Fi card).
    (shell appears listening on port 1337).

Privilege escalation from local privileged user?

    # insmod foo.ko
    Module signature failed, but module is loaded anyway

DoS from local privileged user?

    # echo foo > /sys/.../bar
    Kernel BUG ...
    Attempted to kill init, system halted

Remote code execution.

    $ echo xyzzy | nc target 1234
    $ nc target 1337
    # id
    0

DoS by crafted packets.

    $ echo xyzzy | nc target 1234
    $ telnet target
    target is not responding, still trying.

Are there any other threats that should be listed here?

I believe some threats are clearly in scope for us. Can we agree on threats=
 that are out of scope? Does it make sense to collect "which company needs =
to care about which threats" list?

--
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany


