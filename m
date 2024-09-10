Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E65ECE564
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 07:49:31 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.89])
 by mx.groups.io with SMTP id smtpd.web11.17529.1725954567295592707
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Sep 2024 00:49:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bZ8pr++l;
 spf=pass (domain: siemens.com, ip: 40.107.247.89, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai7gMpnbvi2OIVth7BnEzTlqQGTIaemEENnr/96XUaOnAEoaNWY9Ji/dbjk89se0lsTe1a9nitARjUC6Vui7ba89OFAedm5vTcXwVp1xipB8bChAxkS6e0mQJmZYIokjj/ux+DBSBCUvUA8midDGJO8532D8nu8rFORBP3mF6XdmS+vMGp+TkmsrJIUvkpo8KVinf7GFEHdYvVki3rkqHbtmN6cYYXaSwdpwtnlz9lBAAC3YPAwCdEG+AijYBPkUvk13fy2Gbviy3DorLoBovX4JRuOT1+FshEnjbAdnPvdn1Vt0VJ8A6FzaZENtaToPMWZY7Taqx7aS/e7H73N6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kh+6KQZ/9ExgbuGmOz3+21TLgfC8nvOgUBuZF4H31Q=;
 b=wpCQMzPsgR1eIthkzo2nQKpDhlOLXfa5dLcItJP+w0VwCQv/7MKPLBmhyoSGD2ReaGPCKD6he0WLdzdK+K92Cu+geqFWvt9v81weuy9dcSrPsMQRLyjm+Zv+KELpzORTaAFqghm8hFa1qEJYzDzSGptk06FUicgLAlvxx3ncDzHWjGAOMCMhrb7lPGeJ2HFmI6cRb/Byk5Rbx0g2BCe1Q6F+EEqw68uCASQXpxIzYMJJeUepb5Rmp3/bqW1Gt5m5nRKtzLcJYdzkQlRiaw+hUixyWO/h61nANfMc4Kw5Ir3ODoJmt1vOJaZzS1ib15v73hmp+Q6npERgt948r7/nGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kh+6KQZ/9ExgbuGmOz3+21TLgfC8nvOgUBuZF4H31Q=;
 b=bZ8pr++l2Ob5A00gRFBDk89nfcDNj/FaCWpKSWWOvXijK1wjrEK73igjDJ4wZvzvJeNZkj22kjB4vtnPzt3iy9QgE6t/IqZWUotZb0cQX+gMkbQgjPhxhNIIIlDMx1/LL/qbApFwiG9BSyMo+ypRtGfZzDFw6pIPDH3HVJKygp0ihr9e9k5QOshiAVxfcCQAQdoVHl4kVG8yNwEEC8YgYYZvgiBvdtPoAm+7OqUWPFMiu880xf6KlC7LT9+nK6IPPOTh+6pBietP/i6wW3fCi5D2+/ze3xfSHDIi9KBkN23k2u7ueNtCaRxiTuH5wZ+cE+g+IyMxlB/fHZ30qflcrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 07:49:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 07:49:23 +0000
Message-ID: <84bf903a-bfaf-4570-af77-b424dd82e9f6@siemens.com>
Date: Tue, 10 Sep 2024 09:49:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] QEMU reset issues in CIP LAVA worker
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 Chris.Paterson2@renesas.com
CC: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com
References: <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed5dc57-e3ea-4e12-4d8e-08dcd16d1632
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9g2oWBzlEyebN/EWz10V5t/SCIWvkbAdXs5yr7FhG5nroPLA5KWuo4ZtLltT?=
 =?us-ascii?Q?UMJaDhZb1D3GayNGdn8OG35+sSN0Kvi/neiA9ZdlPz3coRSX2vFeEHPTAY0l?=
 =?us-ascii?Q?KRiPte0d7uN3r6m3UuYjEG1xmkFIPLQ3UzYPT2n/XITDbz9GVqpI1HwhLNrO?=
 =?us-ascii?Q?K08A5dSGgg/DGVTgV2hyT3KVOZ9SmoeFnl6q8GMLi87k+jMwOAbxajOl+LYp?=
 =?us-ascii?Q?aGCF0H6Hu/EpQruI46cno8Wh90TRG4A11gmztTCfho2l2aG0ZYBlvj2dLfss?=
 =?us-ascii?Q?7yK7ug5/WUJZ9fV8aI9wQ1kERWGD0d9zaNvejRqg1yX1Gwy25UEAOik0g7VC?=
 =?us-ascii?Q?Flkp5A4BSnVEdYIZ2X4A7vbTH4a1roUJL9vYY9CGxU5UMk/PnD8ivkpkzTkA?=
 =?us-ascii?Q?VPlIzrahKw0c3tYDqsbiHqAoBe7W86SozYyF/U0tDmSS1eQb1E/tOz0A0Vjt?=
 =?us-ascii?Q?iWfjeDLbYtQKFRGVV/R02VoaCUNgCcKaG1s7sgpVm5EQbDFz6A97fW9E4Vph?=
 =?us-ascii?Q?af12EV7Bq42BMhK/0pQx33i9nbyIrpy0wp2kXlhDBcwFkLevSOkWP/XibOI7?=
 =?us-ascii?Q?rm560g9dFALhelKPRbd8CPdT0VpbEpw/ysqrKhQCeNi6ua8aRvIdB3QHoTe5?=
 =?us-ascii?Q?LOnbsZ6Whkyew70DJsqBWIcDDFMv1jbgeGXiUMac3Nz/Af9ZXzRlXFv30qsn?=
 =?us-ascii?Q?QDHJk9tIbtt2HErNbgdAjiUdSeBlhmK9HTJr9ZrPL9oXN1BXihp6OA86rQBI?=
 =?us-ascii?Q?YVfsHkf0Fi2SFxZOaNOHGJbH0xguJZwl4tvpp6JhS4CRoUv1D0e/0j1hP9ZX?=
 =?us-ascii?Q?fwo4xbAqyWOpwN+XMmYwJTKRKJCZZ9oFWGDWX9gqtgDs0HKX2tCyx8vtCs/l?=
 =?us-ascii?Q?BTGsg98hCcdttX2UtNoNHh3tFGyicc/3agq5Np+Oi2xO0WXXtTsJXN2XXy37?=
 =?us-ascii?Q?PQPX7ihCN1e100ksFlpA/D8lEGZqIVfLAYE1/+AUwHW6Cs9XvkSvPTYeRrCA?=
 =?us-ascii?Q?7jUmCi2DfhLyuOj5SHK9lX/Lr3DHfatUr7Et5/Re+cAsPnQOcWVgh1M+oJpH?=
 =?us-ascii?Q?m+oRvUJ3RfOmWimGSF4bnv6CM9TedOVWALdJxSzle83b9dUkhEGYVBULlDxN?=
 =?us-ascii?Q?b5EBmreCmj1NHgaTOhhdC/EYGUgDsxmEHtFzJRMoaxQK7uq/ug0ubxQPDlNU?=
 =?us-ascii?Q?rdfX7qRm3CBqUXeA3B7ACc0YdSJsZNwW8EpyHZYTPfz1Z6Un5AFZOJ/DMuWp?=
 =?us-ascii?Q?rhbk6jSWVTU7KMHes/0x/DM+VmRu0WWLMdn9t16qhBXW7kFenhmUDGIfOF+P?=
 =?us-ascii?Q?P9A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0PNV7rq5HRx/JRZft7wZ/w3OmY6tL20en5jmSgVTP3KOmfksDE2ewqkeb5ZH?=
 =?us-ascii?Q?2tl80zooQOhsVRozC9AuaMrlA5PYfQgO8+zmr1If+arU0aSRWEUashmLsEGQ?=
 =?us-ascii?Q?x+2mRjkNlmdyP2oxnNWiVYqx0HVXVGbWsq8m0PNHUEvJMr04BPrkuD7X70ho?=
 =?us-ascii?Q?kCI6bG9oo5w4gJ8Ak44iGwE6bVXZDz3QHhtIYvyTupR5ORcR0KyuQE4eT3LD?=
 =?us-ascii?Q?a+77nkAh2RgKDvXFMxrxwmsE0aVaOtsVRbKlgF4E+40ultbYDqcPz9OimA/q?=
 =?us-ascii?Q?boHH9TSqNRPqXW4sn4kXsBRSlsg+MH1zNeHhsIpQawvuvg68KZokeh+5fIkD?=
 =?us-ascii?Q?+Kd1InlBCM1C3gmkMSp0PjsxEeyj7a7TIIw4yepQcGW1RHGpiDiRx0bGRzjj?=
 =?us-ascii?Q?qpRxm3Li/3cdQNzOSB6YodNx8hSycyIhNd5R1GyKnLmj1VjVDllN6L8n6pRa?=
 =?us-ascii?Q?DMfT/ndqtUPbLhZhwtTT5fhltT/ub8/CPHJGJJtSL8UilxNWYX6afj4ngU+Z?=
 =?us-ascii?Q?+UeChQHaFNqPd+ZGpF3Kp/uCtv8X9ke2BXDn2q19WxgNG+AvPIu97wjKqOqn?=
 =?us-ascii?Q?PEXzm2usELdxvq8W/qCecxDiwA5Y8fnuqRJMrDJW84cabACnuyG09NtBh9cW?=
 =?us-ascii?Q?2Mh6dnCuIqEbYEk9sUEov61w107QFG+/NPHcvs692uwZd9fGPjsYesMn05zW?=
 =?us-ascii?Q?fBhf8qTj/7IXJlMoZ3dkD982mE0rL5Yws3rdI50LgSaDbQweedvjyr/2fs8k?=
 =?us-ascii?Q?DnQjaKqZS60d86AIH5UZguz4SREzNqhTUW2IAvq78bNsqtAAornD7ZSCKgr5?=
 =?us-ascii?Q?v/phdlnYKGkbzBs0XrHl0NVksn5OQnIH/DUbFND0MXkjqwOAC4ZbWkhtS3wh?=
 =?us-ascii?Q?yzjmcbyGEK4TMgUr2v7WztpTWvE9SHj2bkEWvCFwtg/YzmGhU1nIg54YSbT4?=
 =?us-ascii?Q?awD1HJCbVQYiY3pKboCevMjwJpPRba5d1NdMAK708+2Xhg7+pF1XEhJWThyu?=
 =?us-ascii?Q?GNbwz9xbVOWG6+6mTOszw7eTAbQ1HJMf1F6oCstsnuytuBXixhujJ9XqAdTn?=
 =?us-ascii?Q?EYsaoA08EvwuWUmDB/TNdF7tZm8/MT97uKIGYZtIFpz5MfV9upMXsAh7632P?=
 =?us-ascii?Q?yC1hqQSIayYdx+tedyMYLTgRS0WS4J1wlxY0FIGKN4FzCC3prlABP0HdbcTf?=
 =?us-ascii?Q?J5pAm5fxZBeXplklWo13l+49b7O8ZcNE9FJTmoJSXVxry713O+kWBfoeMtOP?=
 =?us-ascii?Q?KNf74GM/w6eVbRsLGq2vRXxT2XszkUSuhVfkvzHnkZLBaBj2RiKFD1NE6gMH?=
 =?us-ascii?Q?0/+St8lXzQyic8KhaoBGDZr2VdPqdygdE96yRiRSni3FW8YfTPuo2wdIQFwV?=
 =?us-ascii?Q?Lxpv1tPKIMiJz9/mn9V9Qz1N0spyyMeDX2r7n183GcWV0pRq42s3/N2NsXPn?=
 =?us-ascii?Q?AGKsJOIul2aUi6cro3OL5nu031En/Yeu3sK2Rmh7J8i7q6/bljDsZgl+Wdm4?=
 =?us-ascii?Q?XzeFnLsQzzac0NeGJz2wtK6M49ZaufsWkPstbvTphBxbfaPpDLsn1VpxErxs?=
 =?us-ascii?Q?QMexWDcCJdZT6/5ws3zkJ9VfCsyMXoRwY4V8zjymWpt4fnoONSOZ9HwzF3/Z?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed5dc57-e3ea-4e12-4d8e-08dcd16d1632
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:49:23.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3xEH/minR4LKnnQdfw+NHAOtzwLKnoK+5UHQX9f+xzxquT3FnZAF3fBEZ6jCiquKiM9A0zVA0vrJVxpBWZGojLaRSdYBHh1ZBJqGGKWK5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6339
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Sep 2024 07:49:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16876

Hello,


On 9/9/24 2:02 PM, sai.sathujoda via lists.cip-project.org wrote:
> Hello Jan and Chris,
>=20
> I have taken a list of all the failed jobs in LAVA after enabling secure=
=20
> boot, software update and IEC testing in isar-cip-core. The inconsistent=
=20
> reset issues during boot and getting stuck during encryption of /home=20
> and /var are found only in *lab-cip-siemens-muc*.
>=20
> Currently I have no idea what the problem in that worker might be. I=20
> think until we know the reason for this behavior in lab-cip-siemens-muc,=
=20
> maybe we can remove =E2=80=98swtpm-jobs=E2=80=99 tag from QEMU device in =
that worker to=20
> avoid failures for now and parallelly debug the problem.



I have tested on our runner the latest qemu image and the swupdate=20
scenario. As our infrastructure does not support internet access from a=20
Device-under-test i would recommend that we don't execute swtpm-jobs on=20
lab-cip-siemens-muc for the time being.

>=20
> Note: The failures in other workers provided in the attached sheet are=20
> known errors.

I also checked to errors, we have multiple source of errors.

e.g. https://lava.ciplatform.org/scheduler/job/1181952 has the error:

```
Resizing the filesystem on /dev/vda6 to 332595 (4k) blocks.
The filesystem on /dev/vda6 is now 332595 (4k) blocks long.
login-action timed out after 1438 seconds
```

and
https://lava.ciplatform.org/scheduler/job/1181944
```
MiB/s[2KProgress:  63.3%, ETA 04m36s,  832 MiB written, speed   1.8=20
MiB/s[2KProgress:  64.5%, ETA 04m41s,  848 MiB written, speed   1.7=20
MiB/s[2KProgress:  65.7%, ETA 04m32s,  864 MiB written, speed   1.7=20
MiB/s[2KProgress:  66.9%, ETA 04m26s,  880 MiB written, speed   1.7=20
MiB/s[2KProgress:  68.1%, ETA 04m22s,  896 MiB written, speed   1.7=20
MiB/s[2KProgress:  69.3%, ETA 04m19s,  912 MiB written, speed   1.6=20
MiB/s[  609.374786] watchdog: watchdog0: watchdog did not stop!
[2KProgress:  70.6%, ETA 04m15s,  928 MiB written, speed   1.6=20
MiB/s[2KProgress:  71.8%, ETA 04m10s,  944 MiB written, speed   1.5=20
MiB/s[2J[01;01H[=3D3h[2J[01;01H[2J[01;01H[=3D3h[2J[01;01H[2J[01;01H[=3D3h[2=
J[01;01HBdsDxe:=20
loading Boot0001 \"UEFI QEMU HARDDISK QM00011 \" from=20
PciRoot(0x0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
BdsDxe: starting Boot0001 \"UEFI QEMU HARDDISK QM00011 \" from=20
PciRoot(0x0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
[2J[01;01H[0m[36m[40mEFI Boot Guard v0.16
[0m[37m[40mBoot medium: PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
Found 3 handles for file IO
Volume 0: (On boot medium)=20
PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(1,GPT,D1360F76-B09A-4BCC-B=
923-8195088CBE02),=20
LABEL=3Defi, CLABEL=3D(null)
Volume 1: (On boot medium)=20
PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(2,GPT,F870258B-706F-4A66-8=
D58-B5A75CE61B8B),=20
LABEL=3DBOOT0, CLABEL=3DBOOT0
Volume 2: (On boot medium)=20
PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(3,GPT,6E41F2A7-E3EB-403F-8=
637-B111E4482EE9),=20
LABEL=3DBOOT1, CLABEL=3DBOOT1
Loading configuration..
```


Quirin

>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16875): https://lists.cip-project.org/g/cip-dev/messa=
ge/16875
> Mute This Topic: https://lists.cip-project.org/mt/108352607/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

