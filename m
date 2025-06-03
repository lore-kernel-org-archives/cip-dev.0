Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E290C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 11:16:28 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.web10.8635.1748949384447434766
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 04:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QRCUadLj;
 spf=pass (domain: siemens.com, ip: 40.107.130.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcGuroIr6DpCUW36nZ2kph9Fs9otYg7SFOTpUvKvMmSTHc10GvWm1f7iYjLocooMt6ZszwY3RZO5dbWE5EkMszJfMac7PN/gguQVZArAzPi6+LYC+DRIQL9CwqLz1+JMvHnVq1u9abbi8DVxCB4np4Eqdg14pdHT8sxyC48OW1FmlkLOH2qsstNDhVtpHdLyjMTlU7a6WQx/ou82CJcRKGcLWm5m06eibKvpQqKwmOD9olaB5E6wkaO6ZM7zEq0ivqScDLz24K/LsHMNI50nJKzCLQi6krsg3A56ChYGFB/uxe4haD2iYOliQ3bhqGc+yYvXD0kh4s53LPp6+6DE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SdO8RBqfwIVytvb43gD5THtV7OKYjN+s1J8E/egpY=;
 b=HBlcd1OSuTtcjM4tlrGTgNXuQN33PINLxRTX39T8wJWyGJaCM5DKSDif3grMsxeh6yhLu/LkaVTTFTCMjHS0Ow/fvznx8pw2IUJusFOYS1WD8p1gzHuu/xLXYvxPjz2SWhS23T9e7aun9tEe3NJeL+jtHObDMNnP7ayED+Qe8bZxMyReHJKRYGS0uU0x80UtGKEZ6Xxr5CEj/tNThbxoOR6Le2dZsZ0ivHzSalfmUSwzBSfltyMmG8CJNbJ0Z7O8YBfViEiCoMtgf7SbnnXcZZv3eZy82ArcRYIIuNsIpHpvjwUGwqkJeSFRRi3ZAZwfjFQ/u+ELiK73r934w++uRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2SdO8RBqfwIVytvb43gD5THtV7OKYjN+s1J8E/egpY=;
 b=QRCUadLjaeeifgtZwlcBpHX6YFQU6yg2qaTt0N/tZTlmgNZac+TiKproL2Z2/TGOekjv2x14tK9hxQMvWnZdfpXyEZubrk1hkNuSu5t/OjSxYx0Bsh+7YdmIN9aNxXMWiUGxkK4Sn7K0GGBeuTfkGf6QrrvLHZiaY8fWZEs1il5a1yPdjPEAWUh2282pybtRoxkX7FGon7RHCuf3fqasvTIBnnFgVeUMz76URnMujx5tvNvzKfURCgaLjlWnLvEpuv9JGPuvMD1zfjuVIbfthyM2b2stqX3d0DLQ0n5NtjjBkZqnlT3PWFRp3qHt05lqXBymjY16/WMQcNNwW5V7aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 11:16:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:16:20 +0000
Message-ID: <fc47ba94-4f48-496f-be17-577742db6598@siemens.com>
Date: Tue, 3 Jun 2025 13:16:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Secure Data Encryption on board without TPM support ( AM62P)
To: "Gupta, Ayush" <a-gupta4@ti.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
 "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
References: <82039e1a1c384350af46fe375650472c@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <82039e1a1c384350af46fe375650472c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4f19b1-45f4-42f8-025b-08dda290115f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qvhz99mrxQjMJwhH0HnGQvxVc45zOiQUBQiBKfSOqhz7gWPojcPeDd5BtoDS?=
 =?us-ascii?Q?CxqhlaLFjtph1nfDat5j1CR44bid/1BXdjndTrOxmxU03YqxSEL3c/DuFR9u?=
 =?us-ascii?Q?P++Tzou6ulXOqA1uTqfQmAH9g53rkNYa3LkXyv2easQap2TJ3pchlEP3W2zV?=
 =?us-ascii?Q?ERxlYvS7rPHDX/HYdNete6rbuqeyy+sGiK/d+PiB3Gvxu6nRZKWHDUeKXmP/?=
 =?us-ascii?Q?LkRqGE0Xl/Tn2U3qg54Sr0nKDrsmhcExaX5UFCS5eA8lAmzW2zEKbb0HJLYw?=
 =?us-ascii?Q?kxOg/BMxYE31J0p4fNiG42zGeA25T8aXbnC2rcU9vK3RhARHjUXMAj4UjIun?=
 =?us-ascii?Q?KR1E8Jq0s2AM1BJsGGzRKLVtVkXLC7fK7cJH1VJPxT74R2+pg7pODXhpxMVr?=
 =?us-ascii?Q?jfuhDW4/wg6x51PErvqJb4oVQgWpJ9lngnDM309JFk9yG1XlLUo00O4WfIMW?=
 =?us-ascii?Q?zdztQInURtCUIQZXZU+bsxxgi1k89URZzgwck1Nz9Xb/NZBm3vAdhyGas+8W?=
 =?us-ascii?Q?yc3CFa2EIgkK//ZrChQAHOKJkXxJdxKD5wlQR8kKBSxxc81Uvx4nvL8bJjN+?=
 =?us-ascii?Q?aZ/LFEQyI9GhNFJEPpdNnYy+P4Nc455jjw9ujN3R7OCEnCnQ5kqpJOiOiM2e?=
 =?us-ascii?Q?QAgLK8o/0Ks9XNksa+OH55LakM+3Jmt0QJUW+7TfR1FHUhW9iO8nHN0J6Nwd?=
 =?us-ascii?Q?D/L1AaySDCXVjZEuW7NrxqNiYECiTAHK+dyeu6zcX0PeSFbSheRSFGiSkKhk?=
 =?us-ascii?Q?S1RIOvYt+wom7FV8qkqSis4yfU1DyHvj9wZAkIixKAquCQbmUgAhUHo4yjlY?=
 =?us-ascii?Q?VkFySTeeN6C4iOaayrFpUGJGmc1knfQGsOkYVvldvYgC7toUTzaxaNJ4dzpl?=
 =?us-ascii?Q?Y9ZxzZiunjDkWIe3ZSqooe/PB7WIjSy8eS0EgVyjDWXnZzXVi7RhvCSNdWtt?=
 =?us-ascii?Q?+rQKja5etihfJt8L6jdzo9+XqpGBlreUjcX+7i+QebQVVYBmb0F8YxvfH4B/?=
 =?us-ascii?Q?uXijq3AAxuCfZjbZHMI+ljIo+Ik9Vk3Z2SgXB9BVa12ouOngtXH1mbl9Xzed?=
 =?us-ascii?Q?/vaGE4HoSKQK8J0ghy7rwcRBGr1J7KuPaWNZPEQ7dM3S3X5S0oFvwXpgkswq?=
 =?us-ascii?Q?iz7jbctbU/GmZnvuONMWncYQkOSfVFbkHteiUXjwkIObcwEKd+NdbE9tFva+?=
 =?us-ascii?Q?qUItrmD54ImLfW0hHZIibI2LVq14wAffsBcQC5g4Vzcya+/NNqfNAoWW5kiK?=
 =?us-ascii?Q?xjFdtljTfpJ6urlO6WSQR5sWvs/OLWNqaRrZNmRbIwbQYHcxTb0sW60yrirf?=
 =?us-ascii?Q?iwnVaz/9meD6LGKhNrgqL2oXgos3WGx7YB5UW8wJ4i/w5NUTXmBIGmJncapn?=
 =?us-ascii?Q?rTrMewx75VhX6kiJSreYyvFmNr/o46lFQmnmQkXzCUR33Z5gJVNyger2bPyU?=
 =?us-ascii?Q?PWA9uJ6T/zQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z7G1MT9+iiIzwBtNNkvJGq9lU99Tp/RDng9UoDMSjatEZs3AHwceLmHQuW8k?=
 =?us-ascii?Q?sJZzp829gB7uFdy/n0FOPVC9huc551MjevkL3/+9S0u6w2/NYhE4uWYkqdrW?=
 =?us-ascii?Q?2pLVzOhb9VfB0QtcR20gD4nGWr/DucjJ9YgKhEAiGwIOWrgYM6ft5pSY7+YU?=
 =?us-ascii?Q?198gM1ulN6109OzJH8tvbxFrdgFwg7sPsTz1zOE6DfPm+HLU3nyaJxBkzaFm?=
 =?us-ascii?Q?O424HyEivAjxPXwUHizKQh+wGH1BvoxZmWj3X7VI+968LZUGdu13YP9JccZe?=
 =?us-ascii?Q?MmDpeHUhmHkMlcKfkvSPr5WUqjhSE6cw2dC7m0ZtGX6FbbzPX5VqYEpHv5yw?=
 =?us-ascii?Q?OF5PobLRK2DVxw9Yidgrp1qZH4dzdpNVxC6PmfH8kmaq4OA3dh41dnMRvvJP?=
 =?us-ascii?Q?G9HTRWr+4R9kUw1hLwhEyFZwBPhCWfzKAaZ1pmbN9QYXxjrKkx9urjDV6GVl?=
 =?us-ascii?Q?eH48tLjTK57jliiowxU9FuecJctYWKzsBWB+qGKoE2zOcwItYKgaga4Uck33?=
 =?us-ascii?Q?fEyYIna7QPl9PPA5uTBU6GJrClyIMvl4TCOQWfZ+2OxFW2JGZyf1zRyJrYGA?=
 =?us-ascii?Q?ycLHqFutRYh07B9rhvG3Ayx2o0cJtRXUAtt66Q472enkrAITr1cENR3eHJky?=
 =?us-ascii?Q?7VIOpFSXMwu4m2f8puSBCW2Qm+Z5Uu+N8+ZB6f9mdZC0oY29KnJiQJLO0o16?=
 =?us-ascii?Q?HcJQVeSnnIGx/ANoH3z0RWod2dYCfntbVh3UYRakTo8tYL25EKnYDp4dz28p?=
 =?us-ascii?Q?REMqf4y5k4EJ+lsQNb/YgOta8C1Rgo1KhQ9karlD0+X2v1oruIfUIfmy+L9/?=
 =?us-ascii?Q?ySvIzFWHLooKv1GebTv5GyqUatcHLcInNyPR5bc98kRTX74h8DVM/AJOsTb+?=
 =?us-ascii?Q?eUWvL8VRG3nxFd0AEYUWT3M37XbRC5+bcPQYo2hJpAmlFS8EKYwaB8pv2R5l?=
 =?us-ascii?Q?rCKAY2xYZvEurqtifHEdiS3jsr+IV74T4xKRn2FckMw5wZrPi4/Fzx8VkRgZ?=
 =?us-ascii?Q?xL7ftrwzQajqrXVUpcKujem+anE48relChWixkjJpnRJAAhyPGB24hC7vydb?=
 =?us-ascii?Q?V3evzFjJO7UCLlpdbZP+AnJ/hPuvqusAzSOW0jEsKnArI2gEKkatBtEGHlrC?=
 =?us-ascii?Q?UOKRqdmPZZccrDxL14UfKrey5m9GVHXVSitpS24l7os5DxKLgmk2MdpSMjoX?=
 =?us-ascii?Q?Dxk2BTrGxWDhb2PN5vm1IZvzkibzxSE3XkJo1YjQKwnuoH8dF8bUGumttdjx?=
 =?us-ascii?Q?dxEi+EIpyK2cNuygKzT0JtJwU4EQ6Os7kPrJMz8w03IYxVWP9ghsixrJFeEL?=
 =?us-ascii?Q?6YtQ4xVG85XItA/rdtV9dd4iwY2PWCs2uEiv5oPhQE6kuYcVtytZIzKBLTbB?=
 =?us-ascii?Q?suVBvBgQRkJIqWX0000d2IYlkYKOlcz/TP2kH4mEioXGclKX92dUozYBDjal?=
 =?us-ascii?Q?t5/6g+U/RPOrmNQHYy/2VsrMc5i5Yj7uQUtJFFhezA/lZWay9swqVkY4UxIU?=
 =?us-ascii?Q?6XiqX4/o6Uk8+Q+QmHur/Ac+XrBP3eLBuer5HSLAb59GqB4dQJuWwhTzeU7J?=
 =?us-ascii?Q?592loZ+BcmcKyhHiT9PSEjzo7fmEvq+8ATSqizMe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4f19b1-45f4-42f8-025b-08dda290115f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:16:20.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tcrCqIhCmjmxOBxFsClZ7YByiO4r4MBa4PrWnfXi3plGTSkLyH/WbTh+dBqL2KsJXaR2Nhr0qXEsVuYAdY68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 11:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18995

Hi Ayush,

On 02.06.25 20:03, Gupta, Ayush wrote:
> Dear CIP Development Team,
>=20
> I am currently working on enabling encrypted storage for the TI=E2=80=99s=
 AM62P
> platform, which, as per current hardware capabilities, does not include
> TPM support.
>=20
> To address this, I have implemented a working initramfs-crypt-hook-
> nontpm (link provided at the end) =C2=A0solution that removes TPM
> dependencies. It utilizes a keyfile embedded directly into the initramfs
> for unlocking encrypted partitions during boot. The initramfs itself is
> considered secure as it is protected by verified boot (Secure Boot is
> enabled on the platform).

That should be integrity protected but no longer secret, no? Physical
attackers should then be able to retrieve the initramfs from the device
and, thus, also read out the data encryption key. From there on...

>=20
> I would like to know if this is an acceptable and secure approach from
> the CIP security perspective for boards without TPM support.
> Additionally, are there any recommended alternatives or best practices
> for strengthening this method in scenarios where TPM support is not
> available?
>=20
> Looking forward to your guidance.
>=20

Did you already study how we are exploiting fTPM on the AM65x?
https://github.com/siemens/meta-iot2050/

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

