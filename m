Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC2C021B6
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 10:29:10 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.74])
 by mx.groups.io with SMTP id smtpd.web11.5322.1740479347282286100
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 02:29:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=OH3da5yU;
 spf=pass (domain: siemens.com, ip: 40.107.22.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4LdIAMMnZy4Qp2l1zEtDYufP1O4eONszwccjtpmUXJ3GwbaDL2YBAAz9pH1EZ4sw9znS7L7kiCgcRFAgHf9ScGo+xVyf/zYCD5sxMNQOtZSVoFvR29RhIn/V0zpIpgE7MztyU1nhAXhh+s2i1AODv/mgfMmBV4CLsNPju77lvqbwkA9/+WanyvZSgurm73jxjY0Ru17qV5mzjxyxh/Tj8rcgD+WFSrYpRjrACa3RALH9zN9vT0ie6A2AI46ASXDXyzN33JgXJomqlCmwBfHaxW7nIFPmWTDo72JD9gdScoBtjp7sVcqL/qVCc2X76CFHGeVMynyyWD+WL4sbjzXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOOJJNdmd+LzGe0M2JpEyjHcgfB9QkAcd/yBaWhrktA=;
 b=uQeiBeIAeEzq2hl6GTFkAJLXlLh2JCEomE9LKaf8CC5PjfF7frJG+YsbdAkvjk3qE/+j4zrHrbtLHyqdtPf0IbgkqmsUH09+0FaebDMINdyEbiCrFHX9yDqF0tjJRljHxk8xLgQzEpEfevLm0HIov+RisA82gpOtPs7xV1izh3ytjbw9sRkBIzzX861sgG934epGWbBxm4V7o062rB+GMhWIlxo68FIU/g+fRdUzCSRrg2hmlPIIHPMyJIhW1gjQsu3cWYcUikFLBJWp6Dm5mRN3MWW3t3VV2EMVgIc/vVycHkzktVs9aunSwCr99MAjw6ydcr7Z8n7vDjTyWwhzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOOJJNdmd+LzGe0M2JpEyjHcgfB9QkAcd/yBaWhrktA=;
 b=OH3da5yU77RhCZczc1mNs4Kd4HdpAxoL39mTsTvUU5aEz1wvj8Zfmy7Bx9esGtGIh7kVR+4fs7GQZ9RmNviAzpDx0vXf8XUii9sVTPp0Nnalrr5Fyg0FbRRqciBWs7lvIcQUOav1BTb+o9n7rOX5yK++PybxApLvvApkYEDy/khFkkg44MZcoF4mcfPy4f45TpwuPOoMdgEDlzT4OBYoM5RhOYdgJINs1C9unUdi7bE822QYorF2+0W1gXOOzRIJ8o4Q+vV9iulS2xXqhcfgiVdLTKAeSPgc4rvpWoBALA7tQAjUM8Kzaqk8P2oIazssHulYu3yqp+kWHZbNMI9VIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:29:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 10:29:03 +0000
Message-ID: <0d94ed3b-724b-4244-9935-bc907e0058c5@siemens.com>
Date: Tue, 25 Feb 2025 11:28:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Test reproducibility of
 wic images
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
 <ef4331c3-2142-46e8-9503-2c2f04dd376b@siemens.com>
 <TYCPR01MB9669E8D2FCD6B066660B0264C4C32@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB9669E8D2FCD6B066660B0264C4C32@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:610:4d::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: aba5e0ce-c7b6-4c5b-0f37-08dd5587397e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8+UOTrAWd2pHJfPJ9UIFqZYy/HouqHIwSF+Mxr11lo/LusD7RIsuHw8oJGCY?=
 =?us-ascii?Q?yf2poiADER/4thP3FtFsHn72Ki893TlUToNs9WzXljuJPfO4VhhSucw2ghZ6?=
 =?us-ascii?Q?xyrgV5o0mMd4qQrNxrozqIxR2zD2EzF/kjMl/m7nzNLSWR8PxoOEEuSCPUWw?=
 =?us-ascii?Q?W7k+wf4xnnDKK6sYn6Smamybo9gX298NfoUvmVnfbo3dZZ4xSJmFXkl1khpJ?=
 =?us-ascii?Q?/t+7OG7ID5fVIqpK+jtPXtBP04ETTPJXcF5zX7hj6b/6M/JBpV/ByfijAgKF?=
 =?us-ascii?Q?4bV81saf5/Tp5Bv2aG6g0C1TtQGE8WsipHWrdFhDZg7DWi/9QXETyPVqFmHV?=
 =?us-ascii?Q?WU6OAX+6dti4Bba0zax98FbiOhV0rgjC048/o2yrmFbwVDt8VSbixPCDjzuC?=
 =?us-ascii?Q?Sai9kEOVdmUJ92R2/akrgeUmwNlwVsRJWueCULfps2+wvVi+HVmZV6DKdjqi?=
 =?us-ascii?Q?pISUEM74bmUG6WwDSSzTJN2QH33Mm3MsfgEK7GRL0Zgn+j/OCOsy2ddRVCTj?=
 =?us-ascii?Q?XOG2I/WjDpT1xGAVaPXRG8oQj2wLdtoIFuas8cKrQeucIMyHKHu2qFbtrG3v?=
 =?us-ascii?Q?yDll/cavnSKzDSjuJ6z+TKUCLhi2ynWDnVlGTbetKM1M5oqrCEp0q2Y9h3cb?=
 =?us-ascii?Q?N5V/ftPGLwVnH1Oi+PuC802vmuNax440W6bDPPUujDYtC42eiiat2YJuQITE?=
 =?us-ascii?Q?7/1bav8ajKVul7KinLEN2NIijpoxyhK9JekjjyttFyMW/QXzPigXEBOW0E/l?=
 =?us-ascii?Q?LhLi9gWlraZPFyDudS31+e527DJ+gvkv1pidkjHvB0BIGwR1H7DPW1fU2AVS?=
 =?us-ascii?Q?rzATPakKskNaDtLcLrxfHpGm2yJXgRZNLSvFQl6D6XmC/IlwODKYqD3mAp6n?=
 =?us-ascii?Q?yNSkjzBuI7lbn+IoJAxI/7O7lbJbjFBroZIqKvJH5xqfbuabdogKh1zdRtrK?=
 =?us-ascii?Q?rdWjGu4OCVRwB8fzxgtuOgMNPNZuzJ2PeIWCgJL6ghsm0TEo7vs4TBRNtqmB?=
 =?us-ascii?Q?S+58jIxXvccfmwpINmGMEuzaTyUZEQ61cnJNqDuySm/Oi3F3LGTi6rxz/eJr?=
 =?us-ascii?Q?FmdmO085Wd/hqtGIX0HseZhLxuffe2UFtw9pe0Zu6m+U4WelfjIWWoiKNkja?=
 =?us-ascii?Q?St+StRum4yOLccngSPNrRbGDJVgCsnsDeX7RV4/3GnLDdEAsQTxjdETSgWOk?=
 =?us-ascii?Q?T5w7YwS60QhARpYaMIWBSGXSsRnTaiTkE9ZJm7F5M4kqAofg/d59f+WbNgDd?=
 =?us-ascii?Q?A0Pbv0I87SED7BwfvLJcp2r6IeJqDKXOTTOhxUzhY+ZoDf51mZhetuPcpb+T?=
 =?us-ascii?Q?jnUx61cOWnLsWni4fKCEUJcHsD36lz8dCzK1UiqUVViYsaCeEmUwPHunArDy?=
 =?us-ascii?Q?kazvoB/q5Py63xqqIVMWvXLCv4Lu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PNJdbEu0FfkpzOOEvep+GozE5Uz8w4HNt+aOsA2xA9CzMYl5VOCZ7aozyVDJ?=
 =?us-ascii?Q?qD3/DruR9OVHeLigHUBz/yftIdosJi5KQDQh4CbDAtXnrVdtSf8+Qlh3Lgpo?=
 =?us-ascii?Q?G6bOBj63qOUO+Qn08QQxOnpPcPmNoF0fouPsjjWL4/k4HunRrm4UXwa9WBCu?=
 =?us-ascii?Q?tT7UUq1YSRqVQFJ29MMCqwCNJwe9iguhD254sLRLZIIWgAuClq7Caak9wrpR?=
 =?us-ascii?Q?gKeyUu6yLfOyS6NJ7dghaxM5+rDybraWKAEEco0x0J+PjUJkch/nZDJYXH7t?=
 =?us-ascii?Q?+G5ML4Y1LMnRezb6mnkWdj32y3Z3OGmzzDR/dyR6EudXK1eQVNGxNRPuEKHi?=
 =?us-ascii?Q?YMiWHwsjiRfIuO8xgSF42W/gKr7rKwL6c5RixwNUZabvkfmPAQSl9avSQ9qT?=
 =?us-ascii?Q?xlXSCfOerObGUgX2qSL+uPIHZfPitvR5vG04XQ8vqFoHz1fSdmhHGCt3BhAt?=
 =?us-ascii?Q?zeG7N68nnBRgkjy2ZIgBh9QE/NZ7aX+vZkYF8iNUwxIJSuPROqVZYQX5M+KO?=
 =?us-ascii?Q?mVz2AMlZsNCOrx/n9YXkeuUynfDblNpWfuKxmXZHToy/x55FbvV4GCIjIwjN?=
 =?us-ascii?Q?Wf5CRJULLE6mGUO0HQupQMe1c39K7lDGdkfN6eb7pnU93KUuguiK5QQ+aqOh?=
 =?us-ascii?Q?60PO1ieyMBPJXezUJPzH+vW5TGQgXPKAxLYnY5PnlNMxwUNXyirMpPPPlu27?=
 =?us-ascii?Q?9zjrzvc93zB3cCESGycdOpN8eKEpggkzjsH4cAV/ODPSXduABLej3VMw8LQw?=
 =?us-ascii?Q?Hzap6QZNbGcHARexelYtFAY6w+Lkb6FOITv+lRPVQbhVin/mpD4vFpi81SOQ?=
 =?us-ascii?Q?bMD+qS2O9v/nto1eg+Zzzsce6aGl5IWE0Ll30j2Nd69e5OQ0QlVBJnA93Gv9?=
 =?us-ascii?Q?AX1Wz9XFUL4WOsDktY96Y8ihmkJEgk1ODg7ZFji70D1F/H7JxNkUmPscgLbg?=
 =?us-ascii?Q?QkCFgcOE7eLhKYMEIm/v81K6mKHJEjGQAzW3DRNPUYrNNkRVpzex+pLW5bAb?=
 =?us-ascii?Q?G/XtY9oZvEOZfYH/rw32QDLa2AkWwOJ20bUtRD+RmwKCv5wmPND+divjQPxj?=
 =?us-ascii?Q?vuGBNyRBGHdnCg82XRWP0e7plcrM49n3BmvgZjmf4h+5AeAdJHeoTOhF0/MJ?=
 =?us-ascii?Q?MpW5onMV58LTVKPjnz+JXhdqflRo6SG7pPqqbUcmhh02Yjp6qZjy0TTz5YBl?=
 =?us-ascii?Q?wmmwoKR/F+RU1GoFS+nYtxQm0SEVa+aUrzghoEtZJwTz86VMW4w/ewtfKsmS?=
 =?us-ascii?Q?d5ta2ZbWvp8dpUAP/O2wabODHSlOuqwuEQd4oiIu6wAYQK0YaP4FpLdyMIjy?=
 =?us-ascii?Q?xN/AMcp70iARHRP+72Pecp9sGiQF6NNpRsXWAJ04qA9/Hsw6z4dWyqcr8wW3?=
 =?us-ascii?Q?LPvOATFQLlGmYg9zUtME4txYcRjU0PfDMV4O8kYVHxcne61X4atRXvrBZmh1?=
 =?us-ascii?Q?1HHJnEr8LHsm3/+F6iue7u/NOyt+gHIDew2mUFpIaOYOsI1u/eYccAiCEr67?=
 =?us-ascii?Q?GQvu5hXqpzGbBdFzIFTcF14RJKcG/57GdUmic+6igdayHFIcVezAKeVXztMd?=
 =?us-ascii?Q?rQeQVizGis1Xxffy6JH2oa2NMSI89A+6hG0uuzxeD2mDqA9rPYUKLrkp5GVw?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba5e0ce-c7b6-4c5b-0f37-08dd5587397e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:29:03.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjnnEfUHn2MIQiodXqUKvZQfop1AwJMIHPemOetABmcgc/AISMXSKvVkGTCKB3Jvloeb2PAs7CGZhSmugMv7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 10:29:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17909

On 25.02.25 11:03, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi,
>=20
>> Are we now testing both, partitions and full images? Or are we rather
>> moving from partition testing to image testing with these patches?
>=20
> I would say the higher priority is to check if the full images are reprod=
ucible (As those are the artifacts often released/used).
>=20
> I retained the partition wise check (if the full image are not reproducib=
le) just as way of quick debugging to see in which partition the reproducib=
le issue lies (if one exists). And also running a diffoscope scan on a comp=
lete image has problems like I mentioned in the patch
>=20
> If you prefer to keep things simple, we can just full do the repro-test o=
n full images and drop the partition wise check entirely.

I just want to avoid that we are doing both unconditional. If the part
check depends on a failed fast image check, that is fine.

Jan

>=20
> Thanks and Regards,
> Adithya Balakumar
> ________________________________________
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on be=
half of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@list=
s.cip-project.org>
> Sent: Tuesday, February 25, 2025 3:20 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST);=
 cip-dev@lists.cip-project.org
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
); ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST); dinesh k=
umar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST); hayashi kazuhiro(=
=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=
=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=
=BC=B0=EF=BC=94)
> Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Test reproducibility=
 of wic images
>=20
> On 24.02.25 10:00, Adithya.Balakumar@toshiba-tsip.com wrote:
>> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>
>> Currently only the individual partition images are checked in the
>> reproducibility test. This patch set tests reproducibility of entire
>> disk image too.
>>
>=20
> Are we now testing both, partitions and full images? Or are we rather
> moving from partition testing to image testing with these patches?
>=20
> Jan
>=20
>> Adithya Balakumar (2):
>>   .reproducible-check-ci.yml: Upload wic files for reproducibility test
>>   scripts/repro-tests.sh: Update script to check wic file
>>     reproducibility
>>
>>  .reproducible-check-ci.yml | 10 ++++-
>>  scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------
>>  2 files changed, 68 insertions(+), 34 deletions(-)
>>
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

