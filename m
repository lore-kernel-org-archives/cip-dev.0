Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D0C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 12:39:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7419.1745411944383793354
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 05:39:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53NCcrKh2706708; Wed, 23 Apr 2025 21:38:54 +0900
X-Iguazu-Qid: 2rWhMjEQKIcfZn5y1B
X-Iguazu-QSIG: v=2; s=0; t=1745411933; q=2rWhMjEQKIcfZn5y1B; m=0kQ5UyDOEBMz8LpXNQR4j8Adwxc3hteD4dS4TldjuLQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 53NCcpIU1893106
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 21:38:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMJ7zhbjYsiFSZRu05a6xa4LBHyRa60yKNnIT/hHDMuElL9BTG+46skLE5Naxq2C35L4BvvNkBKZ0NdSQ7k4MLw10/e219fGT/pjUYyQkEXK/FJyChM0LxrnV0A2k1BCyFTKMjFpXwJDpxDNLvGYLtaaeB7n4zTXtHcuZjKurkcol5W+E0i5Yqs7NHRfMbaBvYj5jY/Am1OUPZk4C3vrQYrQRaVpONpMWmaXDZmey8Fre8GZAWWGY1wJ57XrRPeZKnS/4ef2N/RwjBeTf4M4AonyTEifiH6zUMk8F8BT8atruc1wvdVacFhv5V0k3OiaLipxrsoOe4Xp02Yb0BJkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPqXsrXDTXc3pIrMyYGt7dctldjGxBH1v9EADng966Y=;
 b=Anx8Ts9ehv8ffgo4Aly9cx2YqsThps7d7Mr+BsV9fyi8u6+wuDz5El81LVzsY8FNxl6V/781lFGLk2bzgb6WPTwPgCO9EDf73tEM5vSXpgQiMCm/LVA85traCqfmJFZUF13sUBib76GnRnAdFTbuaebSOUJPHE2MdwVy+M9XuGsTf4aTlPW4jPtqOCzpaxaROMjVkFtOoSwaozLwBKYIgloqYltZ+klXAkDjdyDLSdnmBAoGmLqpAN+PDCy3ezZNQwSUQ9nLCAmfO9e34hT59xznJ87jAbsCzU7XBDmxMcp5WvXIXMB4m9WA/jzoAPZFaEA/h/WhYsayNqFs0GOceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <1103432@bugs.debian.org>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Reply regarding aide symlink issue
Thread-Topic: Reply regarding aide symlink issue
Thread-Index: AQHbtEjbTlKzVlwXM0mssEBtmUXjlQ==
Date: Wed, 23 Apr 2025 12:38:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838394EE5E73F0D515A0B67C2BA2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYCPR01MB9735:EE_
x-ms-office365-filtering-correlation-id: b1db8d0e-6945-4a6d-f147-08dd8263c99b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NG1hcTd5YXNFT3hFSDBURytkdkJ0VTdBWm1zVVdyUktYUzdvOTJBNlo2?=
 =?iso-2022-jp?B?R1M3citpVUVDaVlxamlWQ0ZTWUlJTGxoOFN1UDdPSGJnTDNwc0xxVFg1?=
 =?iso-2022-jp?B?Tmo1bmNHNTZFcytDWEIxc09kc2lGeWdLNTBHUmFDa20vYXpQUkZrdWE0?=
 =?iso-2022-jp?B?ZVlYUEdVZ0dUSU50aFVZTmFSaG54Q1ZCSitlTG54Smp3R1drVzVrS2hP?=
 =?iso-2022-jp?B?L243eHNVREljMGtlUnNRZlVUaUFrNUJnZFUxU2EyOGEwdDNycHNSLzMz?=
 =?iso-2022-jp?B?UHphM0hpb29EaUE2SjQzZDB0eHhuTUorZmdxa3dLaFRIQjBFSUVud0l3?=
 =?iso-2022-jp?B?RVpGOG9FL2NVMmpyWHpXWkdzZFVJSThmNm50aVZjV0UwSWMyVlgrZzRk?=
 =?iso-2022-jp?B?azFuK0hXaGlhM1FxV2NZcEF2Q0lkR2RCclkvKzZ6Wk1ZM3pKMnc5YVZj?=
 =?iso-2022-jp?B?dEZ0aU1ZYXEzMHgwT1ArUnRzTXU4WmZMZkFlRGpuQ25HQXFiUlUyTlg5?=
 =?iso-2022-jp?B?RUkvcnlOWUVWNzloVEcrMlRaeUc5RERPQW1oOEVwVytMRjBtdnpnc1du?=
 =?iso-2022-jp?B?RFphVGp0N2UySzU4c3RMU25hTkVMUjVLR2UrdVRhbHkyWlJBVUxhWnpJ?=
 =?iso-2022-jp?B?RFp4N3lTelM3TnhGRXVRSC90cHBKNnl6U2oxVmpZRzVIMk8zdUx4UHM4?=
 =?iso-2022-jp?B?akxDdllIVXhDR2pGc0hHbW5PS1NPdjJZU0Jqb0hLd3lQSVNWZU5yTUox?=
 =?iso-2022-jp?B?UjdZNlFRYlduRFJmTGs2V1VFb1Z3Z2Q4dkRVaEpGc2xWdHBEY1FEQ3hC?=
 =?iso-2022-jp?B?cDhXNW51a0gyMEJ6MC9TVTAzbVZ5UjVtMXNkMHpaMFhWYlhxMVZha2h3?=
 =?iso-2022-jp?B?aG1iUVBoYzB3NGZ0aVg2bUJoV0xvNXV5cmhNblN0RkZ1NlBzM0wxZm4w?=
 =?iso-2022-jp?B?Tzl3RnVGVE9naG9JVUJiRkJ6WHVIK3lGd0pmSFdya0pPejl5WkxmejZi?=
 =?iso-2022-jp?B?aFU0UURqNitmM0crWlVsdnpuTnZGc3IrU29JTy8venNPT2ZSK2ptZk9p?=
 =?iso-2022-jp?B?V1hzR0JMYlFNQnRnTmcyLzF5dHA5RFNCaXdvbkgxUXByYjhHQ0x2MTBL?=
 =?iso-2022-jp?B?ODAvbTQvWENmTE85OVhVaXlCN2NMTkZNd1JEK3hQTnEzTDQ1ZHVnMUFM?=
 =?iso-2022-jp?B?SkwzZE5aQ2syWWMwamVFQmhVQ3cvVUwwd0VtelU1azJGR0ZHRzIxK3lF?=
 =?iso-2022-jp?B?YUFNK1pYdXM5RDJmb1dhbUx5bXlYQU1TZmR5Ny9uQ0FMTzFDRUNMUE1P?=
 =?iso-2022-jp?B?QmQyTE01QXQ3SkcvS09CNFArSWJiYzhpNkhZSjdsVnRHMnRYb1JEVXo3?=
 =?iso-2022-jp?B?bVFCWlROaTM0cHlEMVlLdk5CQzdIK3FpRmlJTHlOMVEwSTZCbVkyNzRq?=
 =?iso-2022-jp?B?dlJBN0QwWmgvK2doKzJWaytlcVdOQ2hvdnJkclpRWC9DUWpOQ1JBZlgr?=
 =?iso-2022-jp?B?eXBSUUtxVysxbkdaMVdsMFY1THBLR0R1VW1rSjRlMitoaGZVRWVubWFk?=
 =?iso-2022-jp?B?Y1E5ZWJaVU9WTElPRlZzdzVQd0ZvQUlVSlRvUWFZNkIyczZoem5mbzF4?=
 =?iso-2022-jp?B?VEV1K0phMDJUUExKYWxMd09lSGhob3pQNm4veTdBeCtvRExPUHFPcERW?=
 =?iso-2022-jp?B?VG84R21RMUFrSGkzaWlDdEpiZmpZTGR2elNIUEt3TkloOFZ0QXVXT2p0?=
 =?iso-2022-jp?B?UWY5WGE2RGJLcGxQb25aWkVUdEVRc3ZDVkdPdTB6RFBCVGtBZG81UGV3?=
 =?iso-2022-jp?B?VjJ3YTFBWEE3WC9kcFppdkljbFNDTFVHU0FQWjBqb0VLcytmNmM2TE9s?=
 =?iso-2022-jp?B?UGtSRmhLK0hMOTVFSWJZc3U3eGxqaVNBU0dEc1EzTG1teEJrbkFNM1p0?=
 =?iso-2022-jp?B?TVFFM0FicVp2YnFCQ2E3ZGdXSGxXQmMvTG1hUkdrK05FRlZTeitIOVVN?=
 =?iso-2022-jp?B?WktWYnhQZ0tVNUwyVWl0R3FHaEVHazdNaDlFY1g4OXVldDhyajlBU0ov?=
 =?iso-2022-jp?B?UndOWHI3T2dyUGVqbkozeXErTzZlREtLdFJ4QTdScTlaVVhjbmFubXFN?=
 =?iso-2022-jp?B?amx4blRtQ3JhUi9HR1I4M2lFSXh4eVpCWEc3LzRMOUsvUVpKY05iYXV5?=
 =?iso-2022-jp?B?TDhvPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RFFvSmk1NXhraEtkSHVMMnc1bGZNNWJuQzFoV0lLc1hiREJmQUFKM0tk?=
 =?iso-2022-jp?B?aHFBNGMwRVpsdzROSlJmN0orcWFoeXRHS0d5ZzBxRUF2cVJBWVZZR3Zh?=
 =?iso-2022-jp?B?V3ZBdzRXLzVjSjROZDdMQjh1U3V4dDRKZ0d1VWtjSU5lWDU0QXFaZnoy?=
 =?iso-2022-jp?B?YllGR09qYWY4L1ppNWxjaXVuZUFuU3Q5Yit4NXp6V05GVW5PYzVram1t?=
 =?iso-2022-jp?B?bGxrWEVGU2dmSEdBMVRKUHcvZHhoWXdLbEo0ZGhYamtsWFRIajg4YkZq?=
 =?iso-2022-jp?B?QzlBSXZlbE1HN3I4VnVBSXlIbHJ5T0MrN09yV0lzZG9rRE93RDM0b1JT?=
 =?iso-2022-jp?B?cnFkOWhtcnhVS2VtbEhzM0JIeW9uMFRlRUxwMVhiQm5QUXpLZ3U5MUJm?=
 =?iso-2022-jp?B?QUZQeHBCWGFPa004VWlWMWJOc0w2NlplWVVhd3dHQm1uOWNCSFNrM2M2?=
 =?iso-2022-jp?B?N3lHSjNISzZBUnBzVno1SDVKNnRaMzRPYzRRbG1rQkYrcWUrd3ArbFo4?=
 =?iso-2022-jp?B?amRSMmZhaUNVZXJ4am92WUdoWVQ4S1l3TzhpS0F0cGhhc09XL3NyYStF?=
 =?iso-2022-jp?B?QzdIZmtwajdSMElBRWh2dmZVSW1qR1NvNWxDa1lhR2l2aERFUEttTXRB?=
 =?iso-2022-jp?B?RFo5ek4ySmtPbDdGaERRMG5aWnRmQ1hlZEJYWDZzSU8vQWllQytHWkVZ?=
 =?iso-2022-jp?B?RktVNEk1NnpjbTlOb2VqK2VhVmxPeE1kZ0VXV2RYditUYUtqbS9FMVpx?=
 =?iso-2022-jp?B?bUY3WkdLTEpwT3QvRGx3WkI3UzN3dGZVem02YkJaUDc1UVpjMS9HRkJ1?=
 =?iso-2022-jp?B?WXBoT0hWbHZRWWlNZVRzK2VlSTVaamVsNnJBYSsvMk1RR2QvYVgyMjNE?=
 =?iso-2022-jp?B?N2w5eUEwRXM1OFNJZFBJRGVGSEc4a28xTEgxbGQraVFKbytsTm1UZlVv?=
 =?iso-2022-jp?B?OTRDNmF4Tm5zVGxHVUVyM3hkU0VHa3hteTkzbHZEVVJrNU5XZDBzbnlw?=
 =?iso-2022-jp?B?cThuUUw3a0duVGNwZ2tOam1tTEV4M0poRDFrU3VmZjdsbDRmdEFGV1Nq?=
 =?iso-2022-jp?B?WFpqdEd6Z0YzUTJ1L3hmemh6OHBwaUtxMTVsK0YyNWN1b3UwRnBrM2Qz?=
 =?iso-2022-jp?B?ZXkrQ0J2QVdYME43RlNBNWc3T21aZFdzUDJjenNCWERJUWdxK05uNkx0?=
 =?iso-2022-jp?B?SU1KMHhvQjVhRjNWVGlXVHNvbjJzakpBbE1XRTFvQm5wNzFrbW1xWkJ0?=
 =?iso-2022-jp?B?YlozREpUVEJOUUVRVWxDZ05meWFNbzlhUGErd0lNR1d6T1RHUGt0MGs0?=
 =?iso-2022-jp?B?elBKZTM5aUZWdEhJZkhibWZQUDlhVEc1d3hsMkdHSzRRVFhSTDlPZ3RW?=
 =?iso-2022-jp?B?OW5Ha3VQM0krZ1QvVlZaY2xWdmtoTGpHZGhmZlQ1MkZHc1hOYWNJcC8z?=
 =?iso-2022-jp?B?NlhVOTNJT1E2ckQvQk1ZOVlaTFFlRSthTEVGZXhNaFdRcTU4TVRHa2hj?=
 =?iso-2022-jp?B?ZERuUkovOEdlVTRNOWJuQ0N6RXE0cEwxZ0NXQnNCWEplazN6eEtuOUxM?=
 =?iso-2022-jp?B?QTBkQ3FqYm93Y0c0TytMVGxBS09TLysvU0FybkxleDkwWkJ3OXNGdW1D?=
 =?iso-2022-jp?B?aWtrUVdnekJ5NHF5SVJOalBUU3FBRUVjZ2JEcVZTalM2cE56ZzI1Sm4w?=
 =?iso-2022-jp?B?U2JqaTlaYzRubkIwdmNwVlFvVS9jdUl2QTRUUUlaQ1E4T0pNVTR0MmtR?=
 =?iso-2022-jp?B?eFlMT28vRmdRbi9FYWNLb1BoSlpiNFJveFdzR0U1YytGNGNReFlaeWp0?=
 =?iso-2022-jp?B?OFVybmxDYUpiVGR1RUlmMXlZSjBnQi9lWnV3V0dwLzRMcGdHWkxJVzhn?=
 =?iso-2022-jp?B?SGxNOEFtek05OTNaeEJHODh4dmg0Z2srT2hhc09xa1VTVHVzc04vSmdI?=
 =?iso-2022-jp?B?K2lwbDVnbFBvK1VXSXRVc1o0TFNpVVRLRUxBN05JYVdQcEpYZVN5eXRN?=
 =?iso-2022-jp?B?c3ZSd2tUSkdZaTB6MWtnQlpIMU1mMDIyM0M0dE5qR3ZURE03a2hlZGpw?=
 =?iso-2022-jp?B?U3ZjZHdJZmNpYTBWaHdCKzlvbXFaOHRYbTBtTzhsVE1FUnVOQjV5Y1hV?=
 =?iso-2022-jp?B?dW81ekM3WVdjWmk2U0FMWUpYR0pqWldPNTFzbk0reXVDeGRyTXFpWnNX?=
 =?iso-2022-jp?B?dDl1OGdzUUFNa0lyZlpnakNBZTl2UHd1NzgyTjYwQ0JEaGJXMnNxVllW?=
 =?iso-2022-jp?B?aFNhNnd1UjhSTTZQVUtaUkpmRzY3ek9VOEczcUhSUmc1YysxcWdLRjJy?=
 =?iso-2022-jp?B?bjZETjdpa2toNmtqVzY0aExYSXhreVJKTXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838394EE5E73F0D515A0B67C2BA2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db8d0e-6945-4a6d-f147-08dd8263c99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 12:38:45.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RQggjyNz5FtHz+Op4RLtijghDa1fdWeUgp6LqkC3O55DzOMoreUaHCw24J2WA4gcDsPMkbIX1xsiAYXu8kWl4pCCVV9Yqjc64T30283UwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 12:39:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18567

--_000_OSCPR01MB14838394EE5E73F0D515A0B67C2BA2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Dear Maintainer,

Thanks for your response.

I followed your steps with aide (17.0.3) and got the same results. Yes, aid=
e is not able to follow symlinks. So, files created inside symlink director=
ies will not be added as entries in aide database, got it.

And also I am providing the output of ls -l /lib  of our machines as you as=
ked.

M1 (used aide: 17.0.3)

$ ls -l /lib
lrwxrwxrwx 1 root root 7 Aug  6  2021 /lib -> usr/lib

M2 (used aide: 18.0.3)

$ ls -l /lib
lrwxrwxrwx 1 root root 7 Aug  4  2023 /lib -> usr/lib

So, based on our discussion can we conclude aide will not be able to accept=
 files present in symlinks as it's database entries, right?

Thanks and regards,
Sai Ashrith





--_000_OSCPR01MB14838394EE5E73F0D515A0B67C2BA2OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Dear Maintainer,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for your response.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I followed your steps with aide (17.0.3) and got the same results. Yes, aid=
e is not able to follow symlinks. So, files created inside symlink director=
ies will not be added as entries in aide database, got it.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
And also I am providing the output of ls -l /lib&nbsp; of our machines as y=
ou asked.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
M1 (used aide: 17.0.3)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
$ ls -l /lib<br>
lrwxrwxrwx 1 root root 7 Aug &nbsp;6 &nbsp;2021 /lib -&gt; usr/lib</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
M2 (used aide: 18.0.3)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
$ ls -l /lib<br>
lrwxrwxrwx 1 root root 7 Aug &nbsp;4 &nbsp;2023 /lib -&gt; usr/lib</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So, based on our discussion can we conclude aide will not be able to accept=
 files present in symlinks as it's database entries, right?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB14838394EE5E73F0D515A0B67C2BA2OSCPR01MB14838jp_--


