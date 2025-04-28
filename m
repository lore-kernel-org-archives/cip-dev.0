Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1114CC369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 09:03:18 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.72])
 by mx.groups.io with SMTP id smtpd.web10.43616.1745830996824684055
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 02:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vowozNrb;
 spf=pass (domain: siemens.com, ip: 40.107.249.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pltYRlHOC4BhfXpAdXypfLmXPM8Agvn6hiAh+/miIqR88L+VsaC/arYH1yWPZxGitk+EgVRwxWAvmKR9pKcANrIOcqk38Be57dGM/RwMulejmq0fEiT+P7QCwCMKiSHlPPDyM4FRJCdr/VK/gRsnER/tes0hooGUdVUdTJA3U5y2O11ib1RVLNeq10bldPs8n6cHZdc+T5FEVOezNN7u6KcOTaMevGGhvMfCzg1WVL1WSRj5oXduxzpEPbE7s1n4RUKvkfRIYS7euvgRsZaXinKzxmtcXeLJ4ZI7L0Z9IUUUv6jqHFvkqkKz2zm/rowGc0MN3DV204aNh6+s1gPDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCU5LVOfzEktWhS9oWSqmjVqdt0crHe3/Yb2ilYXyFo=;
 b=kMo3+xmp7Vmv9G8AXVFZ8cjzuXd2XFAkUzfNLVIYn3RAwsl1Pb5AIveGobLNoaHBdtc473qGkhrpCfVi8InolMWjb4Dfrahm6jxWxKjISeOl5w7g6eGdZsconc7JRqK+f4yWoG2CT4XzKy4vzX+A1MjA/QNjBKR32DcC5IgdaC1Kp4H8u6eCSzTtyxPQFO1NOgc7qDrODAcpPDWuoKCC6zTPK3DIW4Y8eQb0FkKSTEC9Il8tQ4/L55XZoGzUmRKIjwZ8LzoxM+0UlCd1hxj9L/Idrr6YQj6kjRBnhrpvJuTj2JDcNR9KYbUjvGgKr+/6UdgDFpKMi47+1RHhE5rYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCU5LVOfzEktWhS9oWSqmjVqdt0crHe3/Yb2ilYXyFo=;
 b=vowozNrb6eLmAhxKGD7o/yDHWls7ARxXwpNm148Z90Pp5rZvlmD8aXXiwWCfsktjLbLWr9k9iiPwjM2YqZpgkJi/pVFQmDRRoO7vaPlinG34tOEsAYYbETBF3XZZQr0K1obXfMZ5dgkNHA2gA/DbQvjBYA0VvqwZW6lYyTqPqnpvW/nNE73Pt23KfiDrp0GCeBE0GtkoTR4FquEqGKR+ztuve9iAFDuZjE+Pp1052tD8kUJu4asmyee5qyr2XON+XGr1OEIdH2GrE9TXOl0LHDKD2FXGa8lfre2yPZry3PMVR4YVFpFc2u9/sv12KIYol1A1eI9UEEypKuHFKgEN7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 09:03:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:03:12 +0000
Message-ID: <3d45d258-6aba-415a-b894-dae3594844ff@siemens.com>
Date: Mon, 28 Apr 2025 11:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] initramfs: add hook for data-reset
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
 <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
 <79b2bf60-e5f3-42b6-9542-e91ba0bed677@siemens.com>
 <d8e87b5b-0869-4805-b087-f7bdcbc9185e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d8e87b5b-0869-4805-b087-f7bdcbc9185e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: c9839e76-bda5-4c21-c1e7-08dd8633811d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jfcZDVhWIHWXN8GzUTNHcVVyXCDX5M7FyXE4abjnpNXkY6o/2LwuLVASdYWE?=
 =?us-ascii?Q?nfBE2J/NJHiz+iStcE5UYDI1NW2LokRK7m0M5wuxFBLF9GwEYoIm2dvAeM22?=
 =?us-ascii?Q?FchRVfA3WwNcId0gd2uWD2gITVovbi5HrooQOJ9xBVNtx73cxIcdNPZM7aBK?=
 =?us-ascii?Q?DPx0O8BNp2/lFRg1bqR6Hga2hTJSUl2zUoHaeeuw6mgAb1ScpoPAKWbQ9Xy7?=
 =?us-ascii?Q?vWd9LPhg3gz/f5HE1aC9r+eS4sYV4Y0G+wIGNt+Dg1hG40TMiMuPH9bhMJPX?=
 =?us-ascii?Q?RCu8TcMy1haR5lDMZT6YanZeGzfUA/am7H0AUVuvv3BMtKFtiQyKRasBJR77?=
 =?us-ascii?Q?++EHLsdla/OalqYexS5sQuM+HHJtLxwuN21sKlDuuAGETcVdo6jW+ZpJPq+9?=
 =?us-ascii?Q?sII5cc7Oi8kzDy8Y/LsjpP/FbJ+4wFT3i4/LsyV+LnXGJsvP4D/x67qnzAaT?=
 =?us-ascii?Q?eRtq/5drHTxdk/+cciMoMkarh6a734gAbXkwP61+J+UL3g43iMY3VLTrNr6V?=
 =?us-ascii?Q?hBklHv170SgtQSd6hgsIXl89zTBs9ig+bU0+urSulfT3BJMSHB+JArJWKopM?=
 =?us-ascii?Q?C18CMXQ9HOEev18urz7vZxOB0wi0ea0osgBTr7gxLKdQ3Y2Q2uQgT1j6swTd?=
 =?us-ascii?Q?BRFPuk5aBsWit37cDip+xh4v7jDNQA56W8YmRi3Le+8vSLe/JcLPEZ2xzgzP?=
 =?us-ascii?Q?tIn9ibKeNagiBrcojRMCIl/wR0qBGsU3rAlPCC7zEXDXc6sLkReZ4t1XKtw3?=
 =?us-ascii?Q?V4BtzT6AITuFzFAVJWmKqklxN+8+MSWNzULXANTVNWBs1AdCZqfOlh9n3dPm?=
 =?us-ascii?Q?tDS9kmsw/aXUrfLaHMXAfXSpMobNSPoi4u2Wla4FUnWuVXScjVVYVfsu52er?=
 =?us-ascii?Q?du0g7wj/cz/VrfBqRZX2lDbHOxlDUHOlUo0WhRTELwaHXTSP+czCHPvYVFHV?=
 =?us-ascii?Q?jf2OV4fYaTRs5zJ7lD8gKnHzhMcWErO2CfGZhauE+jzTs0XXK11fgTXvPg4N?=
 =?us-ascii?Q?T6lxadLkFdRjf686OhVocBz/o6puWhQnb9tjy8/ETZS292HXsnrdMhFcyGTO?=
 =?us-ascii?Q?lbtXNfZJ4Fl2wXLqMWDLnnAHlhe6yGp0ZXQJ1SVaSyGe69zDNJg2bVh0veQs?=
 =?us-ascii?Q?q7N1JhX8+OssmDKwmWiZHq+7PeYMK/0DuW6wxib9Nwfh2Vmx6OGD7MV3+59Q?=
 =?us-ascii?Q?mA2iXDa7Zwou9eg6lQKwbuF6Pxehdu/7WU7DBJhA7CF1Jj7Jfn9/CRdMS0/C?=
 =?us-ascii?Q?vrxIoB2v/u7s8CBOgyuTY9ROkWkTxsPkOS0wSc3gPxnWUvEKf54Umxe4koFk?=
 =?us-ascii?Q?zKrEl9Dy9kBEz7r2AWKY4NKkqZMDWK2slOP5zR7mxB2W/8RJ/cffCFnPIxAk?=
 =?us-ascii?Q?gjLTIV1BjACJA/f7VOq+U37dgPyRHrLLaZ/aw4UrRLGqEBdZeYr7NAEEkcUV?=
 =?us-ascii?Q?MEnQZTnLl18=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lMqrLBYo/k1Brz0/0ma+Ohg742WAltkHP9M8rnW8c9kYlGtT4C85j6XbwEUT?=
 =?us-ascii?Q?LqKatB1BRoFtFOPYtlczW09P/WuSmbhg0QVy68WcahCGAqxfSc27CQN/HmJ3?=
 =?us-ascii?Q?G7Pefh3Bhfx7LOiQxVmeTmHIHdeldEoYsR/gQlilTPNlNf2kEtJrGxKrmqTP?=
 =?us-ascii?Q?952hEtZM6XzAwGEyqyo2WpRQz7uodEUczXkrbTyYksgB3yxyf81xmINCVb6P?=
 =?us-ascii?Q?JWpoFZ1y/3/oCrfqoEp7rbAGmJiElapjk5TlR42TGOcGQjsiPooFVVincOfB?=
 =?us-ascii?Q?yZzhsvtVVjAj/IUNlJotrbvpGcOtq6HgxEsNMlCn61yNm09kFxLbn7Fy1khU?=
 =?us-ascii?Q?hY8Lk0ZmtFm2Bix0DzyEXAq17pqBAynTyf9JaQqxdVJHMP5njXf+lKMe1eID?=
 =?us-ascii?Q?zSvxC77odTKnsj8XFgrjZHzyXjhv5wpZEQ9UVQf/4UNkHPSOMq1Hd+G/OTWp?=
 =?us-ascii?Q?IZhuLDEVTscE0zeMYp8mhRhme7ZVxkwuiv/cHGriYOTphjfZif74zBfbbeMs?=
 =?us-ascii?Q?Ymzslf5TwqS4hYaiV/wYfyIWhPf9Sj/dyMJZ7ReWfxMv8A9XkgOj/S3am9N6?=
 =?us-ascii?Q?E8JA6uYptTDerxSja7XzejVTfJuniRnLa3ykwXjx5E+6fJPgGOROyOlH5n+v?=
 =?us-ascii?Q?Uy+qXxFtDLjlHT52nOcyabK1ef8orQC2eLnA2H1WqIZGIhWY3hc3RgWfIxDF?=
 =?us-ascii?Q?RdmTwTo9xanSCohR92hVyMKE7m3YqU4YOI5VwZVCFoeRcLdCfjnFxiodZYfX?=
 =?us-ascii?Q?vzmZfwUs9zQZB0KxQzqC4L9dWGwkpnCWGggxaBR/m7c12ULiqy7XPkOv7Tcr?=
 =?us-ascii?Q?VKxuRFy3em5B8qIYi2mU0nnY4wORIG3pWeI2CNk74/SE08l6iKfQbx2wwHOy?=
 =?us-ascii?Q?ONvKuyKiAIlxtc4b//EpOf50bsElFxzGHcDhVGmQ425aYN5CIB6qSXr8Gb0Q?=
 =?us-ascii?Q?kQt0jv1u0krIu88cHQTyInb2M36HXv6JWw4zbCXjiSqtp3vkB+qOd3wOUAG5?=
 =?us-ascii?Q?gaEJ/eDRlal/diWf47+dJouHYjqKnKO8sThHUPK8Q6DyZyB91LlSVRfCkAV1?=
 =?us-ascii?Q?FtD5KjVie9pq4FGpvshYHQWmus8GptujrXrCs5CF93fziKASFaBfcoaKZTZJ?=
 =?us-ascii?Q?EXeykMYIep6C6Umbcp6KHWeYoQ6aYw0VUA1vAc9xDNCL4KBEbSC7YFN5V/w5?=
 =?us-ascii?Q?J6xwecQzFKV8t1X/KKvGccNuspvT5AxS4w7W/jpgY+wMZwR22YcgA40qNDz8?=
 =?us-ascii?Q?rBGs+JKR0I0EeHQGAUIUHoDTxjcxN79ohgn+2PQW1MgKhITRrgOPS9Te25F9?=
 =?us-ascii?Q?fIAIlx6bHXnglkcY9e70qqgOIgbClOw9jrmfq+rBvyRWhq2lISnHHPvr+vYO?=
 =?us-ascii?Q?3C7R97d3t9kGi7zoJewdfRH40+a5h1H3wq417DHQrnbPF9n3EEfsPmcgucIC?=
 =?us-ascii?Q?uxPLzVD++j4kJO7rlKbwEUh3wnQy/3d9vPmsFEk61KfatmviGuyADOEe0GeQ?=
 =?us-ascii?Q?KaPwYBJaiH5TVuhWZH4tT3T/I80GxfW0PTHmeOFr3TDqeP14Fznc5cQWbKwg?=
 =?us-ascii?Q?ypEEM1QJ7cHpDeqMZlN6QAwdj2R3gc451Rkouwme?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9839e76-bda5-4c21-c1e7-08dd8633811d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 09:03:12.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0xLlZ5MKxzpY4/sxh2QSpj079qXBs6nWIcNtkEp7Z8rkVOOfSfTgwsDKIRurOP2THDwc7dZqvfzWr/OVcTBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5837
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 09:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18692

On 28.04.25 10:23, Quirin Gylstorff wrote:
>=20
>=20
> On 4/28/25 08:35, Jan Kiszka wrote:
>> On 24.04.25 11:22, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows to reset the device data by deleting
>>> all files in the persistent partitions.
>>>
>>> The reset occurs if a file defined by the variable
>>> INITRAMFS_DATA_RESET_MARKER
>>> exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.
>>>
>>> This feature allows to add device specific trigger to restore
>>> the persistent file system to the first-boot state.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../files/local-bottom-complete.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 76 +++++++++++++++++++
>>> =C2=A0 .../initramfs-data-reset-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++
>>> =C2=A0 2 files changed, 112 insertions(+)
>>> =C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-reset-hoo=
k/
>>> files/local-bottom-complete.tmpl
>>> =C2=A0 create mode 100644 recipes-initramfs/initramfs-factory-reset-hoo=
k/
>>> initramfs-data-reset-hook_0.1.bb
>>>
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/
>>> local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-
>>> reset-hook/files/local-bottom-complete.tmpl
>>> new file mode 100644
>>> index 0000000..f02f95c
>>> --- /dev/null
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-
>>> bottom-complete.tmpl
>>> @@ -0,0 +1,76 @@
>>> +#!/bin/sh
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +prereqs()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 # Make sure that this script is run last in local-t=
op
>>
>> But it is called "local-bottom-complete"...
>>
>>> +=C2=A0=C2=A0=C2=A0 # but before overlay
>>> +=C2=A0=C2=A0=C2=A0 local req
>>> +=C2=A0=C2=A0=C2=A0 for req in "${0%/*}"/*; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script=3D"${req##*/}"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$script" !=3D "${0##*=
/}" ] &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "=
$script" !=3D "overlay" ] ; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pri=
ntf '%s\n' "$script"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>
>> Will create undefined dependencies between this and the crypt hook.
>> Please sort that out.
>=20
> I will move this before the crypt hook for now.

Don't you need crypt to run first to unlock the data partition?

> =C2=A0>> +=C2=A0=C2=A0=C2=A0 done
>>> +}
>>> +case $1 in
>>> +prereqs)
>>> +=C2=A0=C2=A0=C2=A0 prereqs
>>> +=C2=A0=C2=A0=C2=A0 exit 0
>>> +=C2=A0=C2=A0=C2=A0 ;;
>>> +esac
>>> +
>>> +. /scripts/functions
>>> +
>>> +marker=3D"${INITRAMFS_DATA_RESET_MARKER}"
>>> +marker_storage_device=3D"${INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE}=
"
>>> +target_devices=3D"${INITRAMFS_DATA_RESET_DEVICES}"
>>> +
>>> +storage_mnt=3D"$(findmnt "${marker_storage_device}")"
>>> +factory_reset=3Dfalse
>>
>> I thought you didn't want to call it "factory reset"?
> As the hook does not to a complete factory reset ( the disk encryption
> stays) I used data reset for now. If we add formatting a throw a way
> =C2=A0the disk keys I can rename it.
>=20
>=20
>>
>>> +tmp_mount=3D$(mktemp -d)
>>> +# check for marker
>>> +if [ -z "${storage_mnt}" ]; then
>>> +=C2=A0=C2=A0=C2=A0 if ! mount -t "$(get_fstype "${marker_storage_devic=
e}")" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${marker_storage_dev=
ice}" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${tmp_mount}"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount ${marker=
_storage_device}!"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 storage_mnt=3D"$tmp_mount"
>>> +fi
>>> +if [ -e "${storage_mnt}${marker}" ]; then
>>> +=C2=A0=C2=A0=C2=A0 factory_reset=3Dtrue
>>> +fi
>>> +if mountpoint -q "$tmp_mount"; then
>>> +=C2=A0=C2=A0=C2=A0 umount "$tmp_mount"
>>> +fi
>>> +if [ "${factory_reset}" =3D "true" ]; then
>>> +=C2=A0=C2=A0=C2=A0 log_begin_msg "Factory Reset"
>>> +=C2=A0=C2=A0=C2=A0 for target in ${target_devices}; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_mnt=3D"$(findmnt "${=
target}")"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "$target_mnt" ]; th=
en
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
! mount -t "$(get_fstype "${target}")" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${marker_storage_device}" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${tmp_mount}"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount ${target}!"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar=
get_mnt=3D"$tmp_mount"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # delete all files in the t=
arget mount point
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find "${target_mnt}" ! -who=
lename "${target_mnt}" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ! -=
name "lost+found" -exec rm -rf {} +
>>
>> rm --one-file-system
>>
>> But wouldn't reformatting be simpler?
>>
> That is the question - My first thought was reformatting but then we
> lose the information from snapshot based file systems (e.g. btrfs).
>=20

Which information? Aren't snapshot considered data here as well - which
we want to reset?

For a future solution that uses a/b btrfs plus some factory reset
snapshot state, this logic here will surely need adjustments. Or we
won't use the hook but rather embed related logic into some a/b data
partition hook.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

