Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD49AC02192
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 07:39:00 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.30])
 by mx.groups.io with SMTP id smtpd.web11.64375.1738913931872451964
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 23:38:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IWVU8/Er;
 spf=pass (domain: siemens.com, ip: 52.101.67.30, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2HdLrRA7n8PYoIS5cwhTaDWM1lq8Eb1z+bf9Bo0DyQtMyaKBJHaNqDL5f6e2bwvs11+88yovmpM4GjeyqbG/Gpx/HiaHNM54RPBu0O62QAQEhi/BZPZIqj7NV0ga3WvSPDQQZ5a1BKO/jDEZ6gW7p2fLqm5mK5h/vx9VQpQGc77TDyHisIVlxoc+un6BT9qZcalEPRKaytCp9YfK7IX7ArVojpw7w6L1VePDdEC/DQxQOSvSfIWZKCoxKzPVK86XOMn2Sh6HhjkOBscMUWich5WEK4nlRd4H/9+8Dyfh3NcXZSgTTV8Ffv5ivBYrLaJZ2Pwa8FqDar6zZVxwL8MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5haJot7C3ZJCQiZ0FtPycZYwPOEghGb2xUr5LxSLMg4=;
 b=xEwncWAXOtQUmzcd/Tvz4IXqMcCoPXz4WAY+eTzpIf23vfwFmsuqiSaFvZbPqAXdsxqMbI330z7hPD2M6L0RHc0pTSimJg1FO0NZHOQSqZdkOjmb2iC5cN6GLezpax9puemvo3hoRxk0orXN10tjeQqFsRKE69vTh/gJ0Bu7z0wZKHDrfFlW0JS6yClesGLEgAdRCzAklJyxfYSgmrIjdX319BayWPESUuYS+UU7KWh7GC5K3n1bNT32I/8mPLyN/LbiVzDY3vuWYDfHUrKLkwHYB7RhqSybyJRQ01xGFViI1+30FYsqmjx4FXzsleuvMcNNPn1ssKj+m6GxUp0Lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5haJot7C3ZJCQiZ0FtPycZYwPOEghGb2xUr5LxSLMg4=;
 b=IWVU8/EraZzO7tNPYSFQ444+tVH22+ByYxhTS4BSPeB7VJ2jfjxlmdsX+8j92UbtYG9tuyaV9eJxYCjPdq41SySFL0bCeaI2STFrxFJwoYZJb3hptLY1LLXFv8G5mC1hXvh8gM3rgL0DXT46NkNXz0u2AUdIdObEMessCgvqusZtzKnY5QvIqetIaHWNvDq1G+HQ1szp75Nw30XSIJvcnkhd1n7fbVgg6EnrK4k77w/EiOSzQL+QNeuXMbvmaG7kWGBMRf0pq31HXtPEQJp4PsFAD6Hc0YC+UVc5KLmIEVfdL5H5yqjlar2z9GufsJ0nkuZfWHdWI07Knst0CuQ/eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by PRAPR10MB7621.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Fri, 7 Feb
 2025 07:38:47 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 07:38:47 +0000
Message-ID: <110d17f1-40e0-4fca-8006-5eef478695ee@siemens.com>
Date: Fri, 7 Feb 2025 08:38:46 +0100
User-Agent: Mozilla Thunderbird
From: Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize
 disk encryption in combination with expansion of last partition
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
 <305c5d01-8f9d-4bb3-b23e-330c6322eebd@siemens.com>
 <f8eb2635-8b20-4fac-b933-b80fa9ba404c@siemens.com>
 <AM7PR10MB33204CA0865C72F2B159B64A86EC2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AM7PR10MB33204CA0865C72F2B159B64A86EC2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:672::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8173:EE_|PRAPR10MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2241b244-8183-4b0e-d313-08dd474a7512
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zh1Wllcm6NBjRqzJDhNelSmWhhkD2MB2co3uUfrDl1IEq7gWjBZ1a24cnkx6?=
 =?us-ascii?Q?auCIxZn3d8K+3ehoe+DUy+KSydtgXB3P5bcK/a44cYJZNECdJjKYxhyz/w8U?=
 =?us-ascii?Q?NeUnLAr714TFLJ0q9s3ay9QBclh6sAp6uRhYYFppP2aqnfQeg0Ku/8kFvJnK?=
 =?us-ascii?Q?Ni85cgAexTtSAEcihvNe2WQZftOvQiDGOhR4+mE8TQrUSnSTu5m3zPyiOkLb?=
 =?us-ascii?Q?YIt0vdHbpgjWIbohlJv2cIyO7PvwQWN0iPtVUFE09LG7RJ9Q/1uV17iCZXij?=
 =?us-ascii?Q?Ai9aLrDlKMXwmhoeWSO6QckBvFVidDQHOGJGCLpFxLA5cGMOAGUMYVmR8bzX?=
 =?us-ascii?Q?j0X1Mf8QbRs8cdQgNez9UX2GGMflEiFlN5UlTtaFETgoeoj5NTeue9AwItpn?=
 =?us-ascii?Q?o/t2yUO/6YQK1syYk7ocLfiR3eIbm7MDnP5Fltrz1vIS0ciq2Q8weFpib13s?=
 =?us-ascii?Q?P/8ualSxBPTKn68W4HzEegby559kI+yzBSW1NNzw1wSUDELASgGGrovQYpj8?=
 =?us-ascii?Q?bNec/Fs30wtwDBIOPmuu+eOFgIEaSOqytRQpk095xR1jH40vvL5RpIUkF9ha?=
 =?us-ascii?Q?U8mZlJUvmchBiuM+IrZ7dAAb++Vn3j9GejmebVuS2AM34xGizXQGYM6vqeWq?=
 =?us-ascii?Q?9h8DTGeEf99qmU+tG1Dscb+pVicTIzidewBw3lnUNWPOpso5rifMJSxJwFS2?=
 =?us-ascii?Q?tCvdztGmMHM5lTGMX+83sRMR0KyxJcyMwm2xNcYjUy6F8IXFeGZfCJmA0R3Y?=
 =?us-ascii?Q?xgcTkGZe/CMsAyX3DiTHdatnypajBzsJPkOR9Y3k4VcvPjrEzOUE0AUTxfJ4?=
 =?us-ascii?Q?0bH1DNeRJJWDC7G3DdWJ88l+z0CBQBWtMww6d6aWoHxuMHKOkCC4r0vXH9a0?=
 =?us-ascii?Q?vZPLKNwHOJKFHvNWHh6tzngxCXwTzWPmDBbSkNvGkUmbAtW2LupyeZz2olcv?=
 =?us-ascii?Q?k7IseJvKN2a49kH2WY0H/VeiNNirSNjNj9PTB6e6W5sZPjOnF+xKGJgb1J+k?=
 =?us-ascii?Q?u/1NIARW36/80WgBVb/qXRspW90ELbhgNHYSySmA4bG9o+HvRiO/cXLz2TTz?=
 =?us-ascii?Q?SeIOIyP5FJMj5OjI5L6EEx5Ok6ITh0ytjQ9hvMmfPwhdKSmM5TmtbEFlK9E5?=
 =?us-ascii?Q?xxZiHTub7+Y5lOqWVY6Z8S5vjXo/CEqNO0iaqheZ02YC6dRra9Pa0pVPd6at?=
 =?us-ascii?Q?wsSyAZDfKJDmIRVyhCw+zZiEBUp23Sc2EaHf5fWNN79YJDtpaDvZqrzK00eb?=
 =?us-ascii?Q?ON0fQlFF0hS8SczhyKf+6ODjrNFSriPM48FgtwbQq0Ix9/RYNY4B/Tf1rnnn?=
 =?us-ascii?Q?UQa2AKB0UO37Q8W6kQXdIUpbmLaTszom0ET2qr6u922Sffwx/H9Ow3SYp7Jk?=
 =?us-ascii?Q?EX7eB/fh1Qig/+EoBFuJhBnF9lx1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fPt2ftzXgPz7CQQh7N/SQ2a4YWCHPG8iuX7MwQGu1O5f5TdaR0N1SuSM45Yo?=
 =?us-ascii?Q?1KDabA1gPfYPIQvsB6guCBB2xbZwd6Hwq7YDaqqEfibXyt6HG91oURYe2ngM?=
 =?us-ascii?Q?DSHWkG0Iq272b0JKNWtCqjNpfDP9riuVB0xYbjM5HQWU5PP0MjO+Hvn15R4V?=
 =?us-ascii?Q?Z7NGKYmHDGqLFtlGl5uKh2fIByBalL8pryLzsiOu4Gcq7pubIvi8AmHcmz66?=
 =?us-ascii?Q?L5yS52d2SHDPvEO/OKqL95GzLuy5UGXiiQqDP565u5BPc6aIHg8dF9/zqC0h?=
 =?us-ascii?Q?EN5fEnPqZWTZo841/H4yu3gG6b6rCWxUnw09IPUvOXSJnJEYz5iqkNX/Ds4I?=
 =?us-ascii?Q?5Uma/mSaB096w3cTji9lBW2mDhrdEr8rFDiD26yXv19JzYG08jn+tb1NBhx5?=
 =?us-ascii?Q?NzUoDJkYuhRk7p2ZzYaeApdeZCpzeuv/3e1SG4jMuQEwAixi7OrgNfhVZNgX?=
 =?us-ascii?Q?4sY6PonmaofvV+PZVmUUspnkxeaCwZLIqybJJBMm50fTA0uSNQWo4wyH6UF+?=
 =?us-ascii?Q?SVA4ozFuCWuQ+I6AISDyT5ildpXQqjNNCglfdmOwD/07GsJt7g5EpK/6N3cC?=
 =?us-ascii?Q?jZ6aEePdbwT2kfDVHfc/LtH9XQDRmWU3uvI5zGSQM3oF+1/DyfikQELaH5dq?=
 =?us-ascii?Q?UaCRPDOsJr0qDmiMtNy1KoAz071XTR1Fp1eJPvkWCHRpKnIeKWbQdAoltpQv?=
 =?us-ascii?Q?yn8tixSuNR/bL5s4pSDDC0IGxml+3JYEtrmpaAL3SBTSurg+YkYOjY031J+l?=
 =?us-ascii?Q?doUrpqBTL5JGa7zpDalq0XMv3UuTxjSfEAg2UssyL3SYuPH5dM4rjF3Av9XW?=
 =?us-ascii?Q?+VMbWKumV8kMeqvDJJYDXBr6WnA08gOyK1/2X+Ssd4ntSxm/PLNlmW3FQLW5?=
 =?us-ascii?Q?DWaJ36sb9XOJ+VLmAxovWQhjAdZ7ulbGbBXRJSJ23c1xMY2Zrw3sKYtrxCOz?=
 =?us-ascii?Q?fsXfeegf+TrQbq1GlUkolv5SXfHgmGnI9wzU7lD2wIO1RjE14coyOjCqd19J?=
 =?us-ascii?Q?+URRlhQO5RsUD4cycCQw1Q4OmtjMZTIKC2YL9tFvHqFf0ZiQwb87f8auDIhg?=
 =?us-ascii?Q?6wXe+DpI85EEM6UMCmcKhpn9vIeEmYkG3Ar/3oiB7qduvGjzNKciFUjdsjdB?=
 =?us-ascii?Q?a1mG7wl0cF8C96FypGET3UVUytibppBfLLO19JTxW0sLltdWytPzwfbE3VUj?=
 =?us-ascii?Q?0RAsuqVfkTSSUeKTgEiJqIGF5CdZDyxhR0a1udcdWZCl/z/rlqpS88gn0pOi?=
 =?us-ascii?Q?4pYv9AFfXd+DzGbYMslwsV4dLaEdWIjzeWmT5LYghvG7JjkioHi44+KBEn37?=
 =?us-ascii?Q?0DxQMsHZsfLzLxbqnM0CwBHarngt+VA5FYNNYwmhdDpEN7MvdhmwwVjyhJZF?=
 =?us-ascii?Q?yEh5Lac4qm7tJ1GO9NKmEb0WZqe3xzomW/R0oQkaiGSk2sYmYR/m5gQsiuL+?=
 =?us-ascii?Q?otRTtyxSeQytH6jykUhMnY9grlq7h/3Gh2dD3BczogIJIHHhaUfGigKCsZI6?=
 =?us-ascii?Q?RI7u7vBLdn2vBWJi3XspaxfLOmspUkh5nMHm5Xqi1ps2HntY3BGe+/PDe9MF?=
 =?us-ascii?Q?b8vLg/N8UUIKuA1kro6nM+d79SqILzEmbgx31ubCCIfYfwMMcDrFPWxwLiTu?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2241b244-8183-4b0e-d313-08dd474a7512
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 07:38:47.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+OK3SIKCq3wA9yMrHqHu5ZmAxETP+BV762HQO3HMYWeBUfaqDea4Z3r79ameg9cXqISEy1WS7d8p6nMExMt4VYJwkouOwivX6rPXDEuFoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB7621
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 07:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17766



On 27.01.25 10:59, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 23.01.25 09:26, Clara Kowalsky wrote:
>>>
>>>
>>> On 20.01.25 13:34, Heinisch, Alexander via lists.cip-project.org wrote:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> In the current implementation (since: 284175c3) disk expansion logic
>>>> is done before the actual disk encryption.
>>>>
>>>> This results in reencrypting the full expanded size of the disk,
>>>> instead of only reencrypting the sections containing the actual data.
>>>> This results in a drastic increase of time (approx 20x on our systems
>>>> ) needed for reencryption!
>>>>
>>>> Since relevant disk contents are only available in the sections of
>>>> the disk available before the expansion, it is sufficient to
>>>> reencrypt them only.
>>>>
>>>> This patch changes order of encryption and disk expansion resulting
>>>> in faster encryption (since only the necessary parts are encrypted).
>>>> The resize operation does not reencrypt the added disk parts but just
>>>> extends the LUKS container (cryptsetup resize) to reflect the maximum
>>>> available disk space.
>>>>
>>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>> ---
>>>>    .../files/local-top-complete                  | 37
>>>> +++++++++++++++++--
>>>>    1 file changed, 33 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>>> complete
>>>> index 8adc4e5..c4135c3 100644
>>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>>> @@ -153,6 +153,35 @@ expand_partition() {
>>>>        # Inform the kernel about the partitioning change
>>>>        partx -u "${last_part}"
>>>>    +    last_part_device_name=3D${last_part#\/dev/}
>>>> +
>>>> +    mount_point=3D$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")
>>>> +
>>>> +    mapping_name=3D$(cat /sys/class/block/"$last_part_device_name"/
>>>> holders/*/dm/name)
>>>> +    cryptsetup resize "$mapping_name"
>>>
>>> I tried out your patch and cryptsetup is here asking for a passphrase.
>>> As the passphrase is stored in tmp_key, I think we need to hand it
>>> over
>>> via:
>>> cryptsetup resize --key-file=3D"$tmp_key" "$mapping_name"
>=20
> Thank you for testing the patch!
>=20
> Don't know why this happens in V1 -
>=20
> After the initial cryptsetup + enroll_tpm2_token the info needed to decry=
pt
> is stored in the luks header (metadata) + tpm (key). Thus, the $tmp_key f=
ile is not
> needed anymore, and probably it was a good advice to remove it at that st=
age, so
> other initramfs hooks cannot access it.
>=20
> @Clara: Since I missed some dependencies for V1 the initramfs in V1 error=
s. Did you patch that before?
> What was your configuration?
>=20

Hi Alexander, sorry for the delay, just tested v2 and received the same=20
error of cryptsetup asking for a passphrase for resizing the last=20
partition. See my configuration below.

>>>
>>
>> I assume that this applies to v2 as well. Good that I still didn't merge=
 it. Alex, please have a look and come up with some v3.
>=20
> For V2 - we tested the patch with isar-cip-core upstream applied on 32fcd=
e2c
> against bookworm using the following .config.yaml:
>=20
> ```
> #
> # Automatically generated by kas 4.5
> #
> _source_dir: /repo
> build_system: isar
> header:
>    includes:
>    - kas-cip.yml
>    - kas/board/qemu-amd64.yml
>    - kas/opt/6.1.yml
>    - kas/opt/bookworm.yml
>    - kas/opt/expand-on-first-boot.yml
>    - kas/opt/ebg-secure-boot-snakeoil.yml
>    - kas/opt/encrypt-data.yml
>    - kas/opt/encrypt-all.yml
>    version: 17
> local_conf_header:
>    __menu_config_vars: WDOG_TIMEOUT =3D "60"
> menu_configuration:
>    DEBIAN_BOOKWORM: true
>    DEBIAN_BULLSEYE: false
>    DEBIAN_BUSTER: false
>    DEBIAN_TRIXIE: false
>    EXPAND_ON_FIRST_BOOT: true
>    IMAGE_COMPLETE_SWUPDATE: true
>    IMAGE_DATA_ENCRYPTION: true
>    IMAGE_DELTA_SWUPDATE: false
>    IMAGE_FULL_ENCRYPTION: true
>    IMAGE_RO_ROOTFS_EROFS: false
>    IMAGE_RO_ROOTFS_SQUASHFS: true
>    IMAGE_SECURE_BOOT: true
>    IMAGE_SECURITY: false
>    IMAGE_SWUPDATE: true
>    IMAGE_TESTING: false
>    KERNEL_4_19: false
>    KERNEL_4_4: false
>    KERNEL_5_10: false
>    KERNEL_6_1: true
>    KERNEL_RT: false
>    TARGET_BBB: false
>    TARGET_HIHOPE_RZG2M: false
>    TARGET_IWG20D: false
>    TARGET_QEMU_AMD64: true
>    TARGET_QEMU_ARM: false
>    TARGET_QEMU_ARM64: false
>    TARGET_QEMU_RISCV64: false
>    TARGET_X86_UEFI: false
>    WDOG_TIMEOUT: 60
> ```
>=20
> The initial disk size was expanded to 15GB:
>=20
> ```
> qemu-img resize cip-core-image-cip-core-bookworm-qemu-amd64.wic 15G
> ```
>=20
> and started using the upstream `./start-qemu`
>=20
> The relevant outputs in the initramfs:
>=20
> ```
> Device /dev/sda7 is not a valid LUKS device.
> Begin: Encryption of /dev/sda7 ... var: 11/262144 files (0.0% non-contigu=
ous), 34348/524288 blocks
> resize2fs 1.47.0 (5-Feb-2023)
> Resizing the filesystem on /dev/sda7 to 516096 (4k) blocks.
> The filesystem on /dev/sda7 is now 516096 (4k) blocks long.
>=20
> Warning: keyslot operation could fail as it requires more than available =
memory.Finished, time 00m17s, 2032 MiB written, speed 112.1 MiB/s
> New TPM2 token enrolled as key slot 1.
> done.
> Wiped slot 0.
> Begin: Expanding partition /dev/sda7 ... resize2fs 1.47.0 (5-Feb-2023)
> Resizing the filesystem on /dev/mapper/encrypted_var to 3024128 (4k) bloc=
ks.
> The filesystem on /dev/mapper/encrypted_var is now 3024128 (4k) blocks lo=
ng.
>=20
> done.
> ```
>=20
> Further checks done on rootfs, after first boot:
>=20
> ```
> root@demo:~# lsblk
> NAME                                     MAJ:MIN RM   SIZE RO TYPE  MOUNT=
POINTS
> sda                                        8:0    0    15G  0 disk
> =E2=94=9C=E2=94=80sda1                                     8:1    0  20.8=
M  0 part
> =E2=94=9C=E2=94=80sda2                                     8:2    0    64=
M  0 part
> =E2=94=9C=E2=94=80sda3                                     8:3    0    64=
M  0 part
> =E2=94=9C=E2=94=80sda4                                     8:4    0     1=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80fedcba98-7654-3210-cafe-5e0710000001 252:0   =
 0  1008M  0 crypt
> =E2=94=82   =E2=94=94=E2=94=80verityroot                         252:4   =
 0 125.5M  1 crypt /
> =E2=94=9C=E2=94=80sda5                                     8:5    0     1=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80fedcba98-7654-3210-cafe-5e0710000002 252:1   =
 0  1008M  0 crypt
> =E2=94=9C=E2=94=80sda6                                     8:6    0   1.3=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80encrypted_home                       252:2   =
 0   1.3G  0 crypt /home
> =E2=94=94=E2=94=80sda7                                     8:7    0  11.6=
G  0 part
>    =E2=94=94=E2=94=80encrypted_var                        252:3    0  11.=
5G  0 crypt /var
> root@demo:~# df -h
> Filesystem                  Size  Used Avail Use% Mounted on
> udev                        455M     0  455M   0% /dev
> tmpfs                       500M  6.8M  494M   2% /run
> /dev/dm-4                   126M  126M     0 100% /
> /dev/mapper/encrypted_home  1.2G   40K  1.2G   1% /home
> /dev/mapper/encrypted_var    12G  172K   11G   1% /var
> overlay                      12G  172K   11G   1% /etc
> tmpfs                       475M     0  475M   0% /dev/shm
> tmpfs                       5.0M     0  5.0M   0% /run/lock
> tmpfs                       475M     0  475M   0% /tmp
> ```
>=20
> BR Alexander
>=20
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

I tested it with my current bullseye setup and with bookworm. I=20
installed the image via the isar-image-installer to real hardware,=20
didn't try it out in QEMU. On bullseye, after unsuccessful resizing of=20
the last partition (cryptsetup asking for the passphrase), I can login=20
and lsblk shows that the encryption worked for/home and /var, but not=20
the resizing for /var.
On bookworm, I am stuck in an endless loop of initramfs trying to=20
encrypt and resize.

This is the used config for bookworm:

#
# Automatically generated by kas 4.7
#
_source_dir: /repo
build_system: isar
header:
   includes:
   - kas-cip.yml
   - kas/board/qemu-amd64.yml
   - kas/opt/6.1.yml
   - kas/opt/bookworm.yml
   - kas/opt/expand-on-first-boot.yml
   - kas/opt/ebg-swu.yml
   - kas/opt/encrypt-data.yml
   - kas/opt/encrypt-all.yml
   version: 18
local_conf_header:
   __menu_config_vars: WDOG_TIMEOUT =3D "60"
menu_configuration:
   DEBIAN_BOOKWORM: true
   DEBIAN_BULLSEYE: false
   DEBIAN_BUSTER: false
   DEBIAN_TRIXIE: false
   EXPAND_ON_FIRST_BOOT: true
   IMAGE_COMPLETE_SWUPDATE: true
   IMAGE_DATA_ENCRYPTION: true
   IMAGE_DELTA_SWUPDATE: false
   IMAGE_FULL_ENCRYPTION: true
   IMAGE_RO_ROOTFS_EROFS: false
   IMAGE_RO_ROOTFS_SQUASHFS: true
   IMAGE_SECURE_BOOT: false
   IMAGE_SECURITY: false
   IMAGE_SWUPDATE: true
   IMAGE_TESTING: false
   KERNEL_4_19: false
   KERNEL_4_4: false
   KERNEL_5_10: false
   KERNEL_6_1: true
   KERNEL_RT: false
   TARGET_BBB: false
   TARGET_HIHOPE_RZG2M: false
   TARGET_IWG20D: false
   TARGET_QEMU_AMD64: true
   TARGET_QEMU_ARM: false
   TARGET_QEMU_ARM64: false
   TARGET_QEMU_RISCV64: false
   TARGET_X86_UEFI: false
   WDOG_TIMEOUT: 60

And yes, when this part was still in isar, I patched it following the=20
doc/README.tpm2.encryption.md. My patch was this, feeding the LUKS=20
password to cryptsetup resize:

---
  .../files/local-top-complete                  | 30 +++++++++++++------
  1 file changed, 21 insertions(+), 9 deletions(-)

diff --git=20
a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete=20
b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index c4135c3..dfda787 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -153,15 +153,27 @@ expand_partition() {
  	# Inform the kernel about the partitioning change
  	partx -u "${last_part}"

-	last_part_device_name=3D${last_part#\/dev/}
-
-	mount_point=3D$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")
-
-	mapping_name=3D$(cat=20
/sys/class/block/"$last_part_device_name"/holders/*/dm/name)
-	cryptsetup resize "$mapping_name"
-	mount /dev/mapper/"$mapping_name" "${mount_point}"
-	fs_type=3D$(findmnt -fno FSTYPE "${mount_point}" )
-	last_part=3D/dev/mapper/"$mapping_name"
+	fs_type=3D$(blkid --output value --match-tag TYPE "${last_part}" )
+	if [ "$fs_type" =3D "crypto_LUKS" ]; then
+		if [ ! -x /usr/sbin/cryptsetup ]; then
+			echo "'cryptsetup' is missing cannot resize last partition as it is=20
from type 'crypto_LUKS'"
+			exit 1
+		fi
+		last_part_device_name=3D${last_part#\/dev/}
+
+		mapping_name=3D$(cat=20
/sys/class/block/"$last_part_device_name"/holders/*/dm/name)
+		keyslot=3D"$(cryptsetup luksDump "$last_part" | awk=20
'/Tokens:/,/Digests:/' | awk '/Keyslot:/ {print $2}' | head -n 1)"
+		if [ -n "$keyslot" ]; then
+			clevis luks pass -d "$last_part" -s"$keyslot" | cryptsetup resize=20
"$mapping_name"
+		else
+			cryptsetup resize "$mapping_name"
+		fi
+		echo "Resized the LUKS partition." >&2
+		exit 0
+	else
+		mount_point=3D$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")
+		mount "${last_part}" "${mount_point}"
+	fi

  	case ${fs_type} in
  	ext*)
--=20
2.48.1

BR, Clara

