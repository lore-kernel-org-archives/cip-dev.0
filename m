Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F5CFD65A
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 08:19:29 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2223.1767860368560567669
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 00:19:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SdXojGeB;
 spf=pass (domain: siemens.com, ip: 40.107.159.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLu9M2AtZEk5h2t7L/zF9ExHJ+u6d28K6glj6EweeNS5EruN7Yz5q7hiXJIYtctCOWWyHy/KsWO2VUZjzo5IJLKzuksbm+HK5lEutJGY7tltc4MERi9j8ZIoppsRvZOKfTut9BUNRs+XVjQ1Nh10E+2JRzSoewDLZRR4hao+dJhc08jFQXYKiGSoy9oOSLPN+iLlBWVmloaHs215Wyr9EPQW9uJ6qfOMN9R0U8bUgvcnyej+POmsDta/clzVSchAoHAEhEm4Wa5Qd0t8l0hfPHo8MZIt/ZNv1XCQhM0bnnmM3Vpd2RNfB2ht3YbcHyMnBdFir7Dg+Kd2L5qOkpcCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6EZnjAbfBeqFAFdgN9yCoMwln6tkLytJikdNmaKJ2I=;
 b=Ht0BqCEx7g5bbQ03/CeIUSx+Fy7Y3EJQlyFvqg8mUli1xaTDuJMls83saUjYxRhJDOkjiqmu7PZ1qP2QHBtRglbCqFDFlNVw0Ye6ib/r8uJC8afivDW8QCbnt4tTKGux5PPGbpGgjcb6rr2r4RxqzmNmE1o/EFGXPsDuvADiUGfe8oZc4MUXckuqiUAcy7/IkbR+rztnP1ebhf+95xj9ZLa9sVtmT7sgahgyMj55H9bkVVcoUt5O0J8e0cbIqmh7WvvGRrZCKYnNMpKdTaiOBDotVTLnKua407PlulPzPUqUkyRDdO3MMfBb8FgrwNps9nK2yTFZ7jyljILQKgndJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6EZnjAbfBeqFAFdgN9yCoMwln6tkLytJikdNmaKJ2I=;
 b=SdXojGeBaWqnjMf1CNavB1QYv7JWVrPv6fFIHs/VVpSPcL9lv4m6/Y9fLtbupDZ1yAjcrdVxOGHLrcJn1ydiSNT5mo4JXhFtiFwH/t9U6ZBDv9lU4H66wvV0MNUXIFLehjic3z8oiT5E8n3EbuaHESuVqhhnFFhAfSXGn7EceepRAX0rw6TAKKXOSLnRVHhcSxkdKbgLPxjY0CiSsMVUaA6GH0gvuJc7JBH7uC5C3pPHuvqdNm3l6pfi3WY+kSKPI962/FNxbGYLfoEzgeEVrYitc15Bkzszi0osLSxAHz6Z+CUHbwOI3bYw56juX5JleVmsyMHrR595/4lyU0nRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 08:19:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 08:19:24 +0000
Message-ID: <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
Date: Thu, 8 Jan 2026 09:19:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
CC: patches@lists.linux.dev, stable@kernel.org, Zhang Yi
 <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251013144334.953291810@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f341bad-139b-4d9c-43d5-08de4e8ea1c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0CQU2evcFsYVACTGCwf5cIkyr6NDCpEFQTAiEv7WIoMf3QfqfSFhVafyA21x?=
 =?us-ascii?Q?JFO11wTxwJBvq6kfxy5ZHQ/wNB0pSkx4BpSNdRnyXE2oCsW9SUhgkAibCkTt?=
 =?us-ascii?Q?z6zFcM6SMQ6zY9uU3JoeAsDMiICTyw/OyUw4ldmGyTWcNF1hz0oP5lRZwI6n?=
 =?us-ascii?Q?l4nWKH1nj5EntmeIyYwbFdEMyLFlkwcY0ohdiSdy8FZX0qtHBMPRJqI/Ow6N?=
 =?us-ascii?Q?fVBoXwP+NmqR9KevqhxcmZL4K0cYqpak6+NapRjDW9un6QmHUuQltFmgpVNh?=
 =?us-ascii?Q?2llWP2Fc4xkAa9cEsdzy4SlkG73YcWH9EOsow0tN26mAuxgvSMUgYTK8Ac9Y?=
 =?us-ascii?Q?+IcN08OAAHhzvmTEnZvBuTktg2eXhpMKjOozfATUCYC+cckTENfRp+6rixQB?=
 =?us-ascii?Q?JS4E3Jw/rTjyw+CadKd5s3IWoa7omn/woCs2U5E/tJX9v31MDl/VhGfzxa6r?=
 =?us-ascii?Q?5uemqFGJRYZPPmLv8QNHKKtEIhIKdNV5pM0xeNKIUt7h6y8YxFyCUlFAt7+w?=
 =?us-ascii?Q?+CjySj/StkbDl9m7GIaMEYWOoagWX2Ug127uUvSBhe9yiyAI261Xd8iyCgRc?=
 =?us-ascii?Q?4flvA62wzMOPm9najmFFg89/tqTdr9sLux0rrTvnDrrqzvNLOMPpUxb6Svlq?=
 =?us-ascii?Q?rNkO3Bw60xW/r59ayhvpZZ+j7tb3FmkxkeBZnTYOqU4+z0tHPCz18Nhh3buI?=
 =?us-ascii?Q?vsRe3ASEfvs+vnMlsu5iQYy6PRtaH+3g8gK9JzIKBeWWLlfpY63pcJHv9H7g?=
 =?us-ascii?Q?oxj0hIcci9cSDzxuPcJ7IpAVN0RUxOHxzxZQebcQGlq1eplR08Y/74Y65U6N?=
 =?us-ascii?Q?IqTgDAMUDAFperJxTVb4reAkhiTWX46KOHj8MfbIue6oXehuaoZCTj76v+uz?=
 =?us-ascii?Q?uKlaUOnsmAHV9tnxv3/uRZsYdyQvfOiO0jqMNx731ZFeWoENsaeNREYGmq+f?=
 =?us-ascii?Q?Sv6Eyo9ni+8dz/Jm2ZchJAABfv/V5n+qxjUQupgrkeueG0jdegQatFR2awMm?=
 =?us-ascii?Q?jEbQ+iDge7XoCHdMCCf4uLL5PSqglBpBmH3//cEfZXWlusY2zShmQOFNVFdl?=
 =?us-ascii?Q?wxaSV35+wMdfcUkTr6XveYqmfUmKSet0GRsftrY622d8FURdTPyzO8rQRKhr?=
 =?us-ascii?Q?RXsqWvoij8jpPx7XJ/GgWOP+MiSnJ07d3z+1IG4/YHnNDx31kQSLrBHbwpY5?=
 =?us-ascii?Q?rwJNE33Noe72GXiIOqLBIQ20+1wDxuQG2cDDSkg4XYGhroIgI681+QIohapO?=
 =?us-ascii?Q?u5DdbMXnF9XYleLHo9bv8ARwdX8X3INDL88hn422xMQulPuzRgqhAxlu4ecn?=
 =?us-ascii?Q?Ls8Sy7SBp5vKlWBeCLYZHUMhZTPMP8kFn57eRAFHvwAoMrrV+AuVHOZ27VBy?=
 =?us-ascii?Q?xA5PyXY5ba05IPoMkvvGJVlXQp+VehUm03LWCtRywmbIIf/v8CcKQ+9w4Fxm?=
 =?us-ascii?Q?wrA1+97h+ExsvvMrfUF/yQvC+UjN+Hj5y/9tCaUlHVsxI2eaZNqj8Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xhnorcgoE81S8dwImL7/6oFuPXZv+E7ytMPtq7zN97U22G/UOv6o//WsPRRw?=
 =?us-ascii?Q?gMfFSoWz2lGY/e4ZpV1JGSsXlBOabgfOxOBke/eARpv36Cww8PZh9Uny0GEH?=
 =?us-ascii?Q?LCm1c7hEDXrs+KGQtKtFm7JC5wyD+myfeeDahoxdCYaxz2Zhq8zYMJ2UBxaK?=
 =?us-ascii?Q?ee4C8yQ2/GQWBXT6Uypdmh+jaZd+r37MVb1rtSMZzVKg24P88h5hacTFV/me?=
 =?us-ascii?Q?jo5D3n76X7z1unVbG71/HF9nNIVW7/H+3iHC1EYebFIfDyy9zkHwijHAKtqP?=
 =?us-ascii?Q?MH2wxu0BzFaY0o6UI+wECpEzxDnvmKAC4pJF1s06KmNohS/lICdm56938TEO?=
 =?us-ascii?Q?SmSlRqyZNX2tlzrk7U8PNkJYR2z3aRH8Q2qLkJNQVYiP8j8X2X8urXUZr8IU?=
 =?us-ascii?Q?Lk98E0L9mKi7Opd7Qs0Kr2D3tJMn9OOsrPod+Rs7VvcLjpOC2XF8vkD4j0MO?=
 =?us-ascii?Q?zrc77bj0eAQ87E9Gkxj4EWVUobkxcaNOj/ugJ5kQjhclY6oeD9TNAoQZxt5U?=
 =?us-ascii?Q?QIBY9WDBb+hh42NxZr3qKE8CpXPTXaqgqpJMivpoxgOvkXXMflDojIxWd8wE?=
 =?us-ascii?Q?fVQyYdDJ76GCZ8oLtTSMwW3sNCfWIN8tE7eZuxNvqFu6DVzIJMHeqkvJmel5?=
 =?us-ascii?Q?zxWA3CqBTnBoCn8VtItZOVOzDWdxFyxzQeTioeLD2oU7apxrifuvX1xv/lB9?=
 =?us-ascii?Q?kKAYpEVex7k8ZguSqly/0yFJwHzJ8u4JAwsXu/JnVKuE56RHOfJwV9u9lMDj?=
 =?us-ascii?Q?VFDrWqXIhYkkMcdHLqT8Cnio96ZFU8GEOT3s5C0OuLWSzskzqlSXfXBdpKpT?=
 =?us-ascii?Q?D+g+610wJWvv8G+wSvIY8y7zuZT9kn81b9lG1DuRWVL+SNqXj8lPzpJXh9Oj?=
 =?us-ascii?Q?60oOEKws/25gDSV3B0V00UIxW5Swtqy+7yjc+vpJXW61qsBF5SjNn7tBe88l?=
 =?us-ascii?Q?IEYZF0/P+Xsm71PmguRdSTKBz/nZpCzFqFjjQ4Qu1SeBEggmiF4ZOIgnd0oj?=
 =?us-ascii?Q?+dCmErm8BKuFobE2diXeRSOrG9yM0wR3vceqSNmBEFSeIxg+4lOJWdKTkBi8?=
 =?us-ascii?Q?1doF17ZhKqI6/fzOkFNZaYLLacoIAyfSuTAxA1jhaL4OkciN+rPlIg8T7J5S?=
 =?us-ascii?Q?TC2GDRb0yrgWQBzsxuHQPcMuj4RSLzi9D4hQ/qbbSjWHy/QrVofshl8UMium?=
 =?us-ascii?Q?W1amSHOVKsKol7z8qdaAhwWqBicB954300GpJcvVn4K+SwT1be9B0xAshV7K?=
 =?us-ascii?Q?nDx9+ANJXgURkRzP0YfCPMfsaPOCDJzFTGa7YqSLarRHtb7ET8njfYwNO/KK?=
 =?us-ascii?Q?LYBWonO9jw/Ub+J5yc7qz1GLz3P1CV76uF8Fe9DopbNIZqZGPla16DUbQrV8?=
 =?us-ascii?Q?rzm1AAy+5RvPludbAmWhL5gjPCjhqQVxsFsJxBcZtPjFdsAvMit7yITeS4Sp?=
 =?us-ascii?Q?BSI06F6WXtFvD1j2jj2QfUgCj4sqkoqjR9pnDREy73AhPvGBrrhs/PQcHMMh?=
 =?us-ascii?Q?zbeNx+AUPAGptutqhUJQPg/+Rs8ojEk5EdkzVooFBhlB9MPMLBSz6C5z05/H?=
 =?us-ascii?Q?TLbVOMKVrFEzYd+948Mjcl/63mjmDjRzUzALugL7VyWuDYigNuOj9bucwOzu?=
 =?us-ascii?Q?SIwPZDJyUIgw7PcX4OG6hwF+lI1GZsh5ABgPz5lEMXnlyt3TCefJyo5lcH8P?=
 =?us-ascii?Q?nuWY+haN4fbtLoF4U0ciagHXVX6ECJnELSCDR6jd4tJcTHu+1zlkRr+IiXDP?=
 =?us-ascii?Q?Q9bvglhisg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f341bad-139b-4d9c-43d5-08de4e8ea1c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:19:24.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh7jGQjzxQnq/m+wJhCD3L1hhjAMX7gJBzS3irnKLucon769VxoH5z1kKKVrOs/Sy1EfyvIvfKgEvI3snnmCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 08:19:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21434

On 13.10.25 16:46, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Jan Kara <jack@suse.cz>
>=20
> commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
>=20
> When orphan file feature is enabled, inode can be tracked as orphan
> either in the standard orphan list or in the orphan file. The first can
> be tested by checking ei->i_orphan list head, the second is recorded by
> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> we want to check whether inode is tracked as orphan and only some of
> them properly check for both possibilities. Luckily the consequences are
> mostly minor, the worst that can happen is that we track an inode as
> orphan although we don't need to and e2fsck then complains (resulting in
> occasional ext4/307 xfstest failures). Fix the problem by introducing a
> helper for checking whether an inode is tracked as orphan and use it in
> appropriate places.
>=20
> Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handl=
ing")
> Cc: stable@kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Message-ID: <20250925123038.20264-2-jack@suse.cz>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/ext4/ext4.h   |   10 ++++++++++
>  fs/ext4/file.c   |    2 +-
>  fs/ext4/inode.c  |    2 +-
>  fs/ext4/orphan.c |    6 +-----
>  fs/ext4/super.c  |    4 ++--
>  5 files changed, 15 insertions(+), 9 deletions(-)
>=20
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
>  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
> =20
>  /*
> + * Check whether the inode is tracked as orphan (either in orphan file o=
r
> + * orphan list).
> + */
> +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
> +{
> +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> +		!list_empty(&EXT4_I(inode)->i_orphan);
> +}
> +
> +/*
>   * Codes for operating systems
>   */
>  #define EXT4_OS_LINUX		0
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
>  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
>  	 * now.
>  	 */
> -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
>  		handle_t *handle =3D ext4_journal_start(inode, EXT4_HT_INODE, 2);
> =20
>  		if (IS_ERR(handle)) {
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
>  		 * old inodes get re-used with the upper 16 bits of the
>  		 * uid/gid intact.
>  		 */
> -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
> +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
>  			raw_inode->i_uid_high =3D 0;
>  			raw_inode->i_gid_high =3D 0;
>  		} else {
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
> =20
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
> -	/*
> -	 * Inode orphaned in orphan file or in orphan list?
> -	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> -	    !list_empty(&EXT4_I(inode)->i_orphan))
> +	if (ext4_inode_orphan_tracked(inode))
>  		return 0;
> =20
>  	/*
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
> =20
>  static void ext4_destroy_inode(struct inode *inode)
>  {
> -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
> +	if (ext4_inode_orphan_tracked(inode)) {
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): orphan list check failed!",
> +			 "Inode %lu (%p): inode tracked as orphan!",
>  			 inode->i_ino, EXT4_I(inode));
>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
>=20
>=20

Since this patch, I'm getting "inode tracked as orphan" warnings on ARM=20
32-bit boards (not qemu, other archs not tested yet) when rebooting or=20
shutting down. The affected partition is used as backing storage for an=20
overlayfs (Debian image built from [1]). Still, systemd reports to have=20
sucessfully unmounted the partition.

[  OK  ] Stopped systemd-journal-flush.serv=E2=80=A6lush Journal to Persist=
ent Storage.
[  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
[  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
[  OK  ] Stopped target swap.target - Swaps.
         Unmounting var.mount - /var...
[  OK  ] Unmounted var.mount - /var.
[  OK  ] Stopped target local-fs-pre.target=E2=80=A6Preparation for Local F=
ile Systems.
[  OK  ] Reached target umount.target - Unmount All Filesystems.
[  OK  ] Stopped systemd-remount-fs.service=E2=80=A6mount Root and Kernel F=
ile Systems.
[  OK  ] Stopped systemd-tmpfiles-setup-dev=E2=80=A6Create Static Device No=
des in /dev.
[  OK  ] Stopped systemd-tmpfiles-setup-dev=E2=80=A6ic Device Nodes in /dev=
 gracefully.
[  OK  ] Reached target shutdown.target - System Shutdown.
[  OK  ] Reached target final.target - Late Shutdown Services.
[  OK  ] Finished systemd-poweroff.service - System Power Off.
[  OK  ] Reached target poweroff.target - System Power Off.
[   52.948231] watchdog: watchdog0: watchdog did not stop!
[   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked as or=
phan!
[   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.12.52=
-00240-gf50bece98c66 #12
[   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x Beagl=
eBone Black, BIOS 2025.07 07/01/2025
[   53.449740] Call trace:=20
[   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
[   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
[   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
[   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
[   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
[   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
[   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
[   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
[   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
[   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
[   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
[   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
[   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
[   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
[   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
[   53.450190] dfa0:                                     00000000 00000009 =
00000000 00000000
[   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000000 =
be9e0a20 00000000
[   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2ac0
[   53.730379] reboot: Power down

I'm not getting the warning with the same image but kernels 6.18+ or=20
also 6.17.13 (the latter received this as backport as well). I do get=20
the warning with 6.1.159 as well, and also when moving up to 6.12.63=20
which received further ext4 backports. I didn't test 6.6 or 5.15 so far,=20
but I suspect they are equally affected.

Before digging deep into this to me unfamiliar subsystem: Could we miss=20
some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to=20
try out first?

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

