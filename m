Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06661C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 08:53:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.16403.1718787219353029955
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 01:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45J8raxL1088350; Wed, 19 Jun 2024 17:53:37 +0900
X-Iguazu-Qid: 2yAbxjwjwfuZjpWhnh
X-Iguazu-QSIG: v=2; s=0; t=1718787216; q=2yAbxjwjwfuZjpWhnh; m=nOlvQQWSVW11siw2bSCMfjtplomg5KyMkEFsJx1V4p0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 45J8rZeK2598224
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:53:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+gMfmsjMe9roTXoXxQdN/VyGbtRSDTzHsYEb7b6dYijlOVV5J7CgCV0eGGh5WD9Qq1WAUu8Pmwivbjmn1zZ9KcPx+mmHOYcZaE8IdghW7tpBnUMQiIGi4+0GrLyCbxRSXCpj4N0NkrcN6GTe3O3yjlvRoyibpGPUv47Ezdb81GMaDQH/h1Geaa5ypqCNP+dVnSlwPcOPn2oKYW1JBmhmeTkbrtkNbuaT38Sg+ol/j3251sEA1PvW0pd6VenOjAt+WHXEdxcDEDJijtsAfMX2yb9Hs1tODS6G3HxMoe8ehKrXJwetvEQ+8FXiY8nfPRgkWnCUhUGcoLVezy/Dqv7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUh4XQ7tqJy1QT5+6r3KpeGkNu4TdB68JSlZq4VwtAw=;
 b=IfKdpLPTLsCf1r5D4j4JDTa0NBnj2FJCkvTJZqwxsFhNvzNgVfIx3KTiF4sUfRh7faYZhPJK5pmi2EPnhK+s3l2BBBOqWGC47rZWYiYiSwPLCkMKowr9Vdk8x4ZsbbDDq0JSwEUR3t/rQnMe3TPnmhCF523pcT9lQQReuxgIt3z8PROq+I/7oqqb07S6htbCwHYCSO1CQh1h7yOicL8mNSGfKuJroocbP5hLO8f7QJgQnQSc42+aQQG+ZAsAhhSnED4pC2UvSWC3oNejWlUEesArsqGKbsjv2zsqSRbSlVm3TadBf1N6SpDfXwajCQKI+4nPyc2uYOJbEy+xHUBZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Unable to start cve-checks job because it cannot be picked by any
 runner
Thread-Topic: Unable to start cve-checks job because it cannot be picked by
 any runner
Thread-Index: AdrCJV9SjQ/myfPNSdO7WDG07nlVFg==
Date: Wed, 19 Jun 2024 08:53:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610300320EFEC1A03B28BAC1C2CF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB10777:EE_
x-ms-office365-filtering-correlation-id: 7202ac79-af9c-4599-711e-08dc903d4afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WDVqK2hKVExLOUh4ejRhQnY3WExtT0t3VG5jN2E1WmduaFM4SVVyWUZr?=
 =?iso-2022-jp?B?aHdYMFZJT1pjVHZIQ29pUDlFczdSMHBVem9sZlFMMWRHSWVOV2liTGtV?=
 =?iso-2022-jp?B?cUtoQmgyMTlma0hCS1NRSDAyUk1iR1IyTCtObUViRmdzSHpsMTFvaitB?=
 =?iso-2022-jp?B?bW53SldrQmpvektvdnk4YU9NNVliK09IdnIwa2Q2YTZDSndFZHBpOGdw?=
 =?iso-2022-jp?B?S2NZTncvbzc5dGhCMzZsRWtVZWtJQUY0Y0NMVVk3R1VkOXBYUEE3QVpW?=
 =?iso-2022-jp?B?SDF2Qmg0ZkhnMDYzRFM5elRWT2w0VXRGWDJvcHZXMmtYcXZseVVnU2Mx?=
 =?iso-2022-jp?B?RGM5ZDFZUFhBeU5HN0lkMjhjTmFBQTdORlFsR3RRVllXejNoQ3pzRDFh?=
 =?iso-2022-jp?B?SGZ5UW9WUlp4aDdEdkFYekJjb0tSNzhjT1VwbkZzVGw2dEFncnhCSzhE?=
 =?iso-2022-jp?B?SU1mdEpNcCs4YXVIK1UrQTFHWnZlOEVGUzIzcnpWUXB4YloxL2Q3OUU3?=
 =?iso-2022-jp?B?Q2FtK1VhWXc1WkI3bVlNQ2JxS0tTODNsNXhCdHVwOXkyKzdQN2RTM3BC?=
 =?iso-2022-jp?B?cHk2aW81eG9vT3NLT1pjT0VmZ2hDK3dWYWc0UkNINW9DNzM3SGdWaytv?=
 =?iso-2022-jp?B?T2I4YnVEbndFQS82ZGFBaWJjYTJ6M3NieG1Jd3RNMUltMTAxeFRhVkNn?=
 =?iso-2022-jp?B?U3gxT1RETU9nZmNqRCsvTndOQVNnZC8rb2N5MWNSUFIzMzEwZjRkby9M?=
 =?iso-2022-jp?B?bVpZZkV3NFFSSnhIcW13SHA5TU1acU1xUldKd0NwQnRYVFZ5OE02WkZr?=
 =?iso-2022-jp?B?Ri8rR00ydmF5VUZ6T0J4VzF3dG11MW1uTWtaVnVxd0xoVUpjdUxseFNC?=
 =?iso-2022-jp?B?SXBLeGFiaW1ycVZoT20vb2Z4TThHRGZ5YnN2bnBkYzVhWGh6dEdqbHZt?=
 =?iso-2022-jp?B?NDhiUjdoRHB5KytoNCtYRTJ3d0NTSGxmcWg2Sm1FbkNWMnRSYnJyd1Ex?=
 =?iso-2022-jp?B?OE9VYUFHdDBkM2trQ0o0MXRaM2ZUMmpFQUtlS2JzWXc4VlV4K3p1Smw0?=
 =?iso-2022-jp?B?UjRqYXpJeEpvMXJOaWdKM2FwN0t5eVN5Sk1MaW5PaGRRdFI4UXkyaEdY?=
 =?iso-2022-jp?B?d2l2UTNpTmFWR3grN0xLRS92clIxYjdvVi9DSmtQU0FNMWtTMjcvditp?=
 =?iso-2022-jp?B?OEFMamFqNlFYOXlXRUJFdzFOdVBIQ08zb1U1d2Z0bjZCbXJKd1k5VmND?=
 =?iso-2022-jp?B?eGUrdUthcEpKaHhOL0tiRlR3WmdYUEdmZnpETkhmazNNM2JXdzBZYnpB?=
 =?iso-2022-jp?B?clVCZUNYTTFicEhBdlM3TUVROG1UUTcxNHVtdWhaOTFUQlUrUVhuL2lk?=
 =?iso-2022-jp?B?ejNCc0ZoWURlLzh4dU5VcTExb1JFN1pRQzIrWC95eGNZbVBUOUVPWlJF?=
 =?iso-2022-jp?B?aTRCMmVyVmlTMUVRQSs1YXJIWHp0RU1Hc3RNV3A2Ym1MV0g5QW9hZG84?=
 =?iso-2022-jp?B?NDBtaThuaEdPZXYya1FkVFl5WmFETmoxbEhmUGQ4aS9zRHp2VnN4RTE1?=
 =?iso-2022-jp?B?dDFPUUEzUTdTOTEyR1E0a1g3eFJ6WE9keHFrWHdRcnlHR2tZTDdta1Rq?=
 =?iso-2022-jp?B?N2R2djZCYndvQWV4S1hDaGRYMElrOWl1M01uK0ZuNFkxTEs4WUZWUWdy?=
 =?iso-2022-jp?B?SnhtWDFZNHZFVHNvWlRkRXlqTStwcDQ1bnFHTDFZYlo3d2Q1WkdZaTRF?=
 =?iso-2022-jp?B?WFd1VUt2ZE1QeGNqdUxNcWZVQlQ5TGRFSjFNaDU4RmtOTWI4S2lBek1B?=
 =?iso-2022-jp?B?SUZieldmZ1IrUmdyOEVDTnBGMHdwRmx0c2dBSTBwam9vTTA5ZGZnd0lI?=
 =?iso-2022-jp?B?a1ZtVEdXKzZjaUV2QlBRYkpTcml1SjJ3U01nbEx5Nk0xUlluTU5iVWRr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?am9raCtBZW52UWpGaTFXL3ArRWRRVHplUTh4UFBNd2xDTmo2TkttUkhS?=
 =?iso-2022-jp?B?TXVMSTZCeCtqd2xDSHNSOHZaNG01amRLSG1PRDZvMzZaTzVZSHdIelJT?=
 =?iso-2022-jp?B?QWlQbUJlWU1nZUtyT0UxVVUrcFdiZ3hJK01ML0VORCtHNWVlbDRkUG15?=
 =?iso-2022-jp?B?UU5rcUt5Q3FXOXpCNzYxUzNsNW8zV0U5SDNMQ2trenFkM2tkTlBiaTVY?=
 =?iso-2022-jp?B?S0wreHZuSjhUS1hkQXEyTm9SdFhhZ1M3RG9OSFp0QTBFNjMwL0Jpc25x?=
 =?iso-2022-jp?B?YUZFNVpkQ2NxL01QOEVxSE1Iei8vR1FCdHhrUENkbFNmMmQvM2d2YVNx?=
 =?iso-2022-jp?B?RG9oVHkwWWRkSjFYL2poRjd0TVZMUUZ4OWRpeTBXYTR4NlFzRVU2bElj?=
 =?iso-2022-jp?B?TnNXcmxQUXZ2bENISktRS0pIOVFiaVZwT2lGUDJmMFZtcnBkWnQxcERI?=
 =?iso-2022-jp?B?UjZtSXZXZXYvYlJGdjloWmF5ZlAwNllIWjhWSGxFNDFUSU9hQWZpdnpN?=
 =?iso-2022-jp?B?VGZ0QURoaGN0Z203dHQrVGlFajRjSHNRTXVjNWZaQ3QvbnVzY3ZTNGhW?=
 =?iso-2022-jp?B?TGN1WUh3QU9EZFlLRUFvMHQyK1RQNkE1OFZOeTV5dVB3REgxbXZ3QUM3?=
 =?iso-2022-jp?B?SlhZTUpPOTVPaWhsbnFkckxRL3lhejM2eHRYMWJKdHQzV0t6c3ZPdVFJ?=
 =?iso-2022-jp?B?Z1MrUVVBRjZVQzQxM1pIQjF1UHZmS1d4eU1HTW4xcmZpTVVYVzVQaXRH?=
 =?iso-2022-jp?B?WHg5RUJ1dFlFby8rMnptR2txTjRtT3VmWHAvZ1pmbktaYXRhdGtFZG1r?=
 =?iso-2022-jp?B?WVhMZklGTEpTYW94a2FFYnhNeXIzYVkzYTY5YXladmNQRDg2OGY5TmVB?=
 =?iso-2022-jp?B?eWhlTTFhUFo4KzRUYi9hQnF0eEtrQ2dLREdXRHF5OTZad3BXMzQ5SURy?=
 =?iso-2022-jp?B?em1BRDVYa24rTTcrZlBMdjdEa0srU0RpQXdycXpRQytMSTI4S3ZaTGtJ?=
 =?iso-2022-jp?B?UnVZSkIwNVh6SVRFVkVvOSt6cCt1dGRWcUVEUHBFU0d3Q0FoRVVsQWta?=
 =?iso-2022-jp?B?UmJkTGZyNzk2RFNzYUcyam1Mck9WMDdEZExBK0FiZlNQQ3oxakdiMzd3?=
 =?iso-2022-jp?B?NVFHY09jcWsyb1UrQUdlUXBjM01MTVZ4TzAxNW8xb0xmVzV0SjYyeldu?=
 =?iso-2022-jp?B?SmlEb05vWm1Xa1NDNktwaElpV200cTRyYXk4ditNUTVydnBSektJUlgx?=
 =?iso-2022-jp?B?cXRlVDFtcTJsRklid0lQQXhpMTM3alM5VUN6VTNreEh5MGRIaU81UElO?=
 =?iso-2022-jp?B?L2R3ekJ1RW80Tzh5Z2w1clBmbXBYTW1rbCtNOUNyWEhZRUhjNmR5M0FS?=
 =?iso-2022-jp?B?T3RNZ0lPYS9Nb0JwSENKdXBvVTd1N2cvdGx4RmNsUDRCNUFzeEpyY2JU?=
 =?iso-2022-jp?B?THV0NkJ6Mk5jTytUSjNlR1R2MDcwL210RUs2MkVTVVRlK3lZRXgxWVFE?=
 =?iso-2022-jp?B?UnJhd1NPV3lkR0RtNFRNaEVuS2ZNN0Y4T3NwWURTWXFVZzhZYVVZYVF4?=
 =?iso-2022-jp?B?UW15Rit2VE5tVEs5ZDB2M3psMjV4Tkd0S3BMVEJvSlR5RUZHU09ISTBM?=
 =?iso-2022-jp?B?dHFQTytsNFEzQ0d4VG4zdVJOQTh0TFl1Mks4c083Q3djVVRCeHY4Z0NE?=
 =?iso-2022-jp?B?SGxXaFl4Wi9YMWdBYlV1WktHblFTcVFzS2J2MkRuSWMxSE5FUml6R1do?=
 =?iso-2022-jp?B?RDMweU5RcE50dnN6WHBQekQwZVB1Si9xWURsQjQxRzhpYjF0em5zakhh?=
 =?iso-2022-jp?B?dUxpQkhjUlZiaFVianYwZmxsbUYxZVkwTk5Xai8wNFhzdythdHRidWc3?=
 =?iso-2022-jp?B?SVlhcGhKYWh5TXgweDZUeUNDc1pyZjlydlZseEV2TU5TSE9WYWZTSmMy?=
 =?iso-2022-jp?B?VCtJYUlyTlp6bnZRTitnUDdGT2pZajVYVXJUaVlLOUNYOUtOaStZelJn?=
 =?iso-2022-jp?B?TnJ4VFMwNXM0WTF1OGpCMEZsRTExNENmeTJaa29sOVlqL0V1ZEZQbDdB?=
 =?iso-2022-jp?B?ZEVMMlQxRTlLWTIyWHlFL3pDeUQwdkJXOGovQkpvS2NaWXMvU0FEa01P?=
 =?iso-2022-jp?B?N0VFUVVkdHI5RmpiSmJuNnYybUJZcW1HWmovL0U4WG1KVFRJTnRoWFdD?=
 =?iso-2022-jp?B?M1ZYNUNVc1hrSXhRTTBTZ3RZQWRVNCtpaTUzSnh5bDRMbWVlbXlmSTBV?=
 =?iso-2022-jp?B?SEttLzRFMkpldnFGclk0VnFXRkV1ZGZlSEluNDYxeSs2N00xeU5mRlcx?=
 =?iso-2022-jp?B?MjUyOWVrck1SM05Pb2E4SnB5aklnU0Frcmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610300320EFEC1A03B28BAC1C2CF2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7202ac79-af9c-4599-711e-08dc903d4afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:53:30.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3Ep/JbGU31qSR4ZzbJrxz0A7iXNa9b7tMoKhnN8M4/xRua6rzjyyR7HrqN7V+txmkm5xJQPyEeIQr2RgvEhZ/+R99OwY6Dvh2XJ9HS6j4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10777
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 08:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16292

--_000_OS3PR01MB610300320EFEC1A03B28BAC1C2CF2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Previously cve-checks job can be run manually in a pipeline at the time of =
applying this patch https://gitlab.com/cip-project/cip-core/isar-cip-core/-=
/commit/bcc87ac5309b0c606eaba3a760ab5fd5acce5a3a even though the job has no=
 assigned tag. But now when I tried to manually run this job, it is stuck b=
ecause there is no assigned runner to pick it up. Is it OK if I send a patc=
h to assign =1B$B!H=1B(Btags: small=1B$B!I=1B(B runner to this job ? Can th=
is be included in the upcoming release ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB610300320EFEC1A03B28BAC1C2CF2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Jan,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Previously <b>cve-checks</b> job can be run manually=
 in a pipeline at the time of applying this patch
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/b=
cc87ac5309b0c606eaba3a760ab5fd5acce5a3a">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/bcc87ac5309b=
0c606eaba3a760ab5fd5acce5a3a</a> even though the job has no assigned tag. B=
ut now when I tried to manually run this job, it is stuck because there is =
no assigned runner to pick it up.
 Is it OK if I send a patch to assign =1B$B!H=1B(Btags: small=1B$B!I=1B(B r=
unner to this job ? Can this be included in the upcoming release ?<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB610300320EFEC1A03B28BAC1C2CF2OS3PR01MB6103jpnp_--


