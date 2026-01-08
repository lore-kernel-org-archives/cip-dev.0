Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53881CF6ABD
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 14:12:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7129.1767881520230605303
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 06:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sJj+nS4i;
 spf=pass (domain: siemens.com, ip: 40.107.130.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg9ea3E/b+KYnIDrFefkkQ3LvmPHaZCrqGdJXYsp3Axw9LcsZ64jIehAVq8PDNMVCs1hPqTJ19ebZ2qzS86zcd0cAbVMY3fqv912KIkz5+F3pKrSmVwEmYuYmP3kbH08z7O3FTl37Qulo2pvHHhKGpvpbibywQGemBhsAZOy30XvzYbP4OHfW0PXR88SPRRfg2iFzwihpnn/nhf9sd/NJwq7sNlY5uC4lEENfhtN5NMovXSTpNBnmXd7bjSKSwyHy96izaayXajQMdjRohHsTHXMITvCyUHS8PAo4fCaGbzrBs9wNoJ61Va+wSK0W4f+MhO2Hc18DtOAyK10JXrhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYbgod6BP1o7hhnP2vGvZ33pBDedWiqB6xykFcqfQbk=;
 b=H/OZFBGYjadd4t5CvYiMEcDtuoMi9BJXD8DTMUcF1kUsXbYjzs64vP9j6vUcRxSIHFURnMB42yOnBcyfGW07U+lxsryMQTchYKQ44wVQ1dgaei8M2/G3e5VfaxY5vz0ZfmCfEKj4TtUtJHtgWTVj7qiJJEoyZwyj737mZAt/hwpiwxNkhBkUwHQvlqocLNT3hmoSNauvJD6fiMPpftn9N/USZ7i+WoUb7rxmS59Jm/YFZTfxbfhvQvj6zcdVoNm44KR5QasMWuWCiMuX811ptAfwoiptsFKqGOWBPv039jAIs2eOf49sdBnEYpm//9JeGzrj2UYL7rFMPX3twp++Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYbgod6BP1o7hhnP2vGvZ33pBDedWiqB6xykFcqfQbk=;
 b=sJj+nS4i0gdocHyQeztNf+hREyqy6RrrJEpFuRUbWWABeVv4m/e3fVoTKkBzwTPd0fYpTr9TlgYOQEenh5CdxLx/DoMWXt1ajH0YaOs4JQX6XtCkdESU4d2p7XJ2IvxHi7WZNv7vWW2VotsiZGJr6bSC1kmptZiVhF8qVYJPMgDK2GvAHbhtw+AsVHRls+VeUPF0PFSGbUtbIB2JovJ4Au9/A16lN5ktQYnonLE7Vh2gFlk3byYaqNkaPtavt0TMBlw3rtqMk+03G0e6Y+55bv5MbIrBP8evGvoqKqMrVr3yDI/CJ2g0uGRsgfYwWCE5J2qjD9Lm2QxYYwN8gPSseQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:11:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 14:11:56 +0000
Message-ID: <b39a740d-ae58-4b83-bede-dad0845da1dd@siemens.com>
Date: Thu, 8 Jan 2026 15:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
CC: stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 patches@lists.linux.dev, stable@kernel.org, Zhang Yi <yi.zhang@huawei.com>,
 linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
 <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
 <l36p4covbdywhdkmsxqkswww3azubmlew3imqv7acggcd3pm2k@sazu3kvtuzqn>
 <2026010845-undivided-stability-8bba@gregkh>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2026010845-undivided-stability-8bba@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:610:cd::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: f487577f-da47-4ff7-336d-08de4ebfe13b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nfqMMp6yDj/fkBGH3HT7cJjncMoAwjW4mtrzrodaZKo1aR0R/ZQsnCAeiCz0?=
 =?us-ascii?Q?+yIikc2GO7nYyzlS0VMehPUHkrnRXffrnNpPu9CphyVpdOaFMsgaPiJ22Dql?=
 =?us-ascii?Q?XEN/Ov8yeueQ/D7/3pW4Fw9NJzfH5iKfzAcdYeSFvwX017ehSV6yRiaN5rge?=
 =?us-ascii?Q?wwvaSircdkqAZ1OoT3os4jdwViOODwASww4oXTHEKGimNxxf0rxYpX/oTBIH?=
 =?us-ascii?Q?gqlyfuYqnLBSGG3msYRVZu6jfAP+WqWgLv2VH9OLBiKG/yaA+dRSM5STrIzM?=
 =?us-ascii?Q?GJ5f9UEP+X54jCEDdn76XD0PeD9wIuZ2MnlODTrchzxcOi8jp1LsfVqeXPUT?=
 =?us-ascii?Q?DPEjcSXfZ6I4ZyaWWa6vUJ4MRmLg7RjyNS3cUI/CJertXgMKIm06/cSG0M+1?=
 =?us-ascii?Q?lUjitNbg3sbfgST+lv1MzrtiH1EeRf8M7aw1R1wDCLoxpMs6j/4+XDDjWcSR?=
 =?us-ascii?Q?SMpTAIE0KekshbiOM9h8LBTbblnQc9pUsMmalKDblcK5WxbgLjQ2VrofrdGE?=
 =?us-ascii?Q?F+dMPH7lqYl702DqTh1hz5C5GdAtUUT263wT5IjxHnQPoDGHO5PSCUp9F3pp?=
 =?us-ascii?Q?X6E1ONw7p7lIsYYtNeV2sz/7SakaKGKfiEy+Kf6ipfPaZLKCUrdBrDfZzJnK?=
 =?us-ascii?Q?3EvYCHM3s+JgetonUoCHqN/AfKzrCzf0EpLo2Wi24Tx+FL7WH6RBt14fjMBb?=
 =?us-ascii?Q?RKJn6O9O3dZY5Bgdhl8VO+TGkp2CfMlUYBgTKJ8Za9HEurkE/Ra4kdcImFii?=
 =?us-ascii?Q?P9eGh7NL/W37vVNzD6q0hQsUXpQBKRddElEw4bFcJTU44RAxda/gKjP7hYQ4?=
 =?us-ascii?Q?sFpQOAYM0/HcRTzOlRwfqrvphyCwR3PKuy+1CMg1qqhPvMVoNlB8m5e1KNM4?=
 =?us-ascii?Q?nC/iyjcuiVmBMp3nSUrxuovb3Lz4lmNcFK/cIQ6eddIYxFRpjX6G7+3+7ejZ?=
 =?us-ascii?Q?p6K4bGbfjmQHfVQI7xFeR3wsKqVbsYJ3+KXD28Lw6JDdIpETZ1rJY2WJywi6?=
 =?us-ascii?Q?h9Dncorpv7YNBLohomYjgEOlBGV9DKpKx8XzhRYANDVt78H5D46+guVrvW+n?=
 =?us-ascii?Q?d2KwJpp2G7rrcQD1VUkXddFZ2YK7ehMiIRbkADpaCk9DZAjwmvd17Vxqtp1q?=
 =?us-ascii?Q?Wc7CZtV72PsLqCBComzmXDp2tDeiwGrIiJSNfSbDmAMWYOgnNyiTRBAwEv2K?=
 =?us-ascii?Q?R/PeC5BFs0a7ajJKwrOxyrkbyJ5PE1/qJblNF0yPp4YcMz3MzPAd9u/Ae917?=
 =?us-ascii?Q?Z6ZRt8YZ2mJCfJkxdeaz5B7OhsvNLe7W3WpGuNgbrMzaRgYkeXPllKujjLLE?=
 =?us-ascii?Q?dAx5s0mclceB/11lBJKiJ7/w/5Gla9C4Y23/y5HOsiqV6BZOa+A75nVFXtRt?=
 =?us-ascii?Q?liqv9wbHQsxQnt70ORYp5s8LpDHOHtv6uMB4YWDyIW/lPTJ5lL7Zvj+qXhhH?=
 =?us-ascii?Q?th5/id4faOt7UDjAm/TY8njnPSbDmh7I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OGFt5ySpxUGe4KDd+bMYHGmHAoraAxpHE1NuxoZgsALN47J+fGk7WjSC5t3a?=
 =?us-ascii?Q?LUH1M4H0Ql5Klx++qUIlUCfY/YxnfHLUtDwmJQ7kGDdbDXCQ+JVCfFYrmuIl?=
 =?us-ascii?Q?e390JV8Gm7dySUhWVsip94dGFmuw6SeTeGS8aPh0OA27SBkjlJ5vSOvPBHhp?=
 =?us-ascii?Q?UoyEGU1CQkSeaszMeHBoIIIwRZHNjfv9lo6zG+Lr9Prz0b0beA7rgquZYn0s?=
 =?us-ascii?Q?iRt7bXiv/h0gYJ9295vJJcC7yfGdD8rsTmWVAH7c/99ilfyb75fKspExAjfm?=
 =?us-ascii?Q?TQraHGuwaaKa/L1CasFZu4zfIm+umR/Vh0I642RXY1hKUKBeAPESnh8TcMSq?=
 =?us-ascii?Q?zCuPlyHE3qz/rP7cJrwjy5hvsP37lQyQ9wJ0sNyPj1SW2F5HHg9Ldu+nl/KE?=
 =?us-ascii?Q?gmX8s6tqkOm8Dzu0doUYl/tUlIeyN/jnrU2eM8Yi2NPEZB04vd63mB4oCSZl?=
 =?us-ascii?Q?9/YCoNyq/jBqFmboTYzcZl7IzNXI08S//IxoqjksuUbYvycabTuVMm3TuaPd?=
 =?us-ascii?Q?IHpjcdo9dVUeqhbkLQvKcubOoyJDkYUCOVekqmZYkgf09l4bcCY0cd2+WUty?=
 =?us-ascii?Q?EgiT8/G4Rck+EMsOgAMLLz2Gcm0F5fkWKRBCIbz5n+n/ByyT4IjP7QnD8x2B?=
 =?us-ascii?Q?mSp681RRbFKMxaEUavKvRW0NXAdxognBsDm5nEfg27UZe2dS0i9M9RjKEROO?=
 =?us-ascii?Q?T1kB2ZWTOcQcwW6Oam+wBNxdZbjoKencHxMOcIVgcxwYcDJowpFPi3QzYu/5?=
 =?us-ascii?Q?WHEeSxXzP5gewQmKkeWWwoP8X7zMwG3K8zfYu0CdpAIpXWmMUjS0eLGva1kl?=
 =?us-ascii?Q?z6Yj6Hxos++zNcfvAtNr9T7EW8SahyTv3KPcNGLFglu5AiQ8bvZ4XtHmZtbb?=
 =?us-ascii?Q?2JQL6OiXQfK1Aj1iR/rbRod5JJaUAF1jU7LVIUGv0C39rPuVq2XDRIjzyiLr?=
 =?us-ascii?Q?Aw+DuxDCWgay+ZpGe8p1+/N0R3y62nJTPCwWCRJ7VJPx8w6CaX/i1J/JmSjZ?=
 =?us-ascii?Q?q/PC9kUBui406lAOwsSdaNSjPFUKwMKt1zn7lmVna9ViZBwWzAzxEhNfWSM7?=
 =?us-ascii?Q?wPKshsQllng7jgokB1ePtNhRynKBf8Q/SNvPL1rGkjcQx0E0kzH7lyukulUF?=
 =?us-ascii?Q?9OqQtG3JyYbmjd8b9J+rpujoHMVASbI1eV/LJGLtzsJS1Y5oawPd/pGFfwcQ?=
 =?us-ascii?Q?KbSBeNSpi0m23KcOUipvfkDLDKEWjeXPaGaHmNP855JJQCFRf3mBYKIv7zD7?=
 =?us-ascii?Q?674u+6C6bhhExhy9i1h62sYP3o6vqvrWfw1LGn4IbieOpv4yCjto/u2Qh+Rr?=
 =?us-ascii?Q?Qoo2fld/8pHS+1pkyO7YrXbsMTV9DIxHMzFlVUqN+n9EypjfGtWtTg+EUTlz?=
 =?us-ascii?Q?Wrv5ROqG+Zx1Zi1Fc8l+YBVapWvypLroTbLp/VPbJtgRQx6mDZpdve5XBima?=
 =?us-ascii?Q?tSMg2ogGPR8p7eg+AXnU5NppLlIjPVh//mJsoYKW1AAgpq8Ws3KenAVLD8+k?=
 =?us-ascii?Q?ChhC4duFlQoh/q06xLFc5fLAjs5sdezUiTK6o5T1r6cVfqfNxmMegyBAVBp5?=
 =?us-ascii?Q?5HWisemZZjfF8J8rkgcHsX4UOvD90juTMdGN0OXJY7LNCHZ988VvVtPz49E1?=
 =?us-ascii?Q?CC2aw4hwXC4Frkcr/ie2zx6S1jSpHI3hdmZWctKOhFigGjPGgQmObEUkLFfM?=
 =?us-ascii?Q?xBOrj+k8ZUP5zghyffVuMpqoFc3Fy91lGCg9SIXwRzxkoxNPiB4W2q++UVDs?=
 =?us-ascii?Q?PmRldZJvUg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f487577f-da47-4ff7-336d-08de4ebfe13b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:11:56.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI7P5kErugCGoBYelHZydxteqiK2l5UVCEP0OGfFK4DlyoOfFGmFSjsauNkOfsCdMQxGf6kkjyMCsXHmCwDhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8861
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 14:12:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21479

On 08.01.26 11:43, Greg Kroah-Hartman wrote:
> On Thu, Jan 08, 2026 at 11:31:10AM +0100, Jan Kara wrote:
>> On Thu 08-01-26 09:19:23, Jan Kiszka wrote:
>>> On 13.10.25 16:46, Greg Kroah-Hartman wrote:
>>>> 6.12-stable review patch.  If anyone has any objections, please let me=
 know.
>>>>
>>>> ------------------
>>>>
>>>> From: Jan Kara <jack@suse.cz>
>>>>
>>>> commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
>>>>
>>>> When orphan file feature is enabled, inode can be tracked as orphan
>>>> either in the standard orphan list or in the orphan file. The first ca=
n
>>>> be tested by checking ei->i_orphan list head, the second is recorded b=
y
>>>> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places wher=
e
>>>> we want to check whether inode is tracked as orphan and only some of
>>>> them properly check for both possibilities. Luckily the consequences a=
re
>>>> mostly minor, the worst that can happen is that we track an inode as
>>>> orphan although we don't need to and e2fsck then complains (resulting =
in
>>>> occasional ext4/307 xfstest failures). Fix the problem by introducing =
a
>>>> helper for checking whether an inode is tracked as orphan and use it i=
n
>>>> appropriate places.
>>>>
>>>> Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file ha=
ndling")
>>>> Cc: stable@kernel.org
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>>>> Message-ID: <20250925123038.20264-2-jack@suse.cz>
>>>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  fs/ext4/ext4.h   |   10 ++++++++++
>>>>  fs/ext4/file.c   |    2 +-
>>>>  fs/ext4/inode.c  |    2 +-
>>>>  fs/ext4/orphan.c |    6 +-----
>>>>  fs/ext4/super.c  |    4 ++--
>>>>  5 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> --- a/fs/ext4/ext4.h
>>>> +++ b/fs/ext4/ext4.h
>>>> @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
>>>>  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
>>>> =20
>>>>  /*
>>>> + * Check whether the inode is tracked as orphan (either in orphan fil=
e or
>>>> + * orphan list).
>>>> + */
>>>> +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
>>>> +{
>>>> +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
>>>> +		!list_empty(&EXT4_I(inode)->i_orphan);
>>>> +}
>>>> +
>>>> +/*
>>>>   * Codes for operating systems
>>>>   */
>>>>  #define EXT4_OS_LINUX		0
>>>> --- a/fs/ext4/file.c
>>>> +++ b/fs/ext4/file.c
>>>> @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
>>>>  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do i=
t
>>>>  	 * now.
>>>>  	 */
>>>> -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
>>>> +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
>>>>  		handle_t *handle =3D ext4_journal_start(inode, EXT4_HT_INODE, 2);
>>>> =20
>>>>  		if (IS_ERR(handle)) {
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
>>>>  		 * old inodes get re-used with the upper 16 bits of the
>>>>  		 * uid/gid intact.
>>>>  		 */
>>>> -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
>>>> +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
>>>>  			raw_inode->i_uid_high =3D 0;
>>>>  			raw_inode->i_gid_high =3D 0;
>>>>  		} else {
>>>> --- a/fs/ext4/orphan.c
>>>> +++ b/fs/ext4/orphan.c
>>>> @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
>>>> =20
>>>>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>>>>  		     !inode_is_locked(inode));
>>>> -	/*
>>>> -	 * Inode orphaned in orphan file or in orphan list?
>>>> -	 */
>>>> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
>>>> -	    !list_empty(&EXT4_I(inode)->i_orphan))
>>>> +	if (ext4_inode_orphan_tracked(inode))
>>>>  		return 0;
>>>> =20
>>>>  	/*
>>>> --- a/fs/ext4/super.c
>>>> +++ b/fs/ext4/super.c
>>>> @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
>>>> =20
>>>>  static void ext4_destroy_inode(struct inode *inode)
>>>>  {
>>>> -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
>>>> +	if (ext4_inode_orphan_tracked(inode)) {
>>>>  		ext4_msg(inode->i_sb, KERN_ERR,
>>>> -			 "Inode %lu (%p): orphan list check failed!",
>>>> +			 "Inode %lu (%p): inode tracked as orphan!",
>>>>  			 inode->i_ino, EXT4_I(inode));
>>>>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>>>>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
>>>>
>>>>
>>>
>>> Since this patch, I'm getting "inode tracked as orphan" warnings on ARM=
=20
>>> 32-bit boards (not qemu, other archs not tested yet) when rebooting or=
=20
>>> shutting down. The affected partition is used as backing storage for an=
=20
>>> overlayfs (Debian image built from [1]). Still, systemd reports to have=
=20
>>> sucessfully unmounted the partition.
>>>
>>> [  OK  ] Stopped systemd-journal-flush.serv=E2=80=A6lush Journal to Per=
sistent Storage.
>>> [  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
>>> [  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
>>> [  OK  ] Stopped target swap.target - Swaps.
>>>          Unmounting var.mount - /var...
>>> [  OK  ] Unmounted var.mount - /var.
>>> [  OK  ] Stopped target local-fs-pre.target=E2=80=A6Preparation for Loc=
al File Systems.
>>> [  OK  ] Reached target umount.target - Unmount All Filesystems.
>>> [  OK  ] Stopped systemd-remount-fs.service=E2=80=A6mount Root and Kern=
el File Systems.
>>> [  OK  ] Stopped systemd-tmpfiles-setup-dev=E2=80=A6Create Static Devic=
e Nodes in /dev.
>>> [  OK  ] Stopped systemd-tmpfiles-setup-dev=E2=80=A6ic Device Nodes in =
/dev gracefully.
>>> [  OK  ] Reached target shutdown.target - System Shutdown.
>>> [  OK  ] Reached target final.target - Late Shutdown Services.
>>> [  OK  ] Finished systemd-poweroff.service - System Power Off.
>>> [  OK  ] Reached target poweroff.target - System Power Off.
>>> [   52.948231] watchdog: watchdog0: watchdog did not stop!
>>> [   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked a=
s orphan!
>>> [   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.1=
2.52-00240-gf50bece98c66 #12
>>> [   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x B=
eagleBone Black, BIOS 2025.07 07/01/2025
>>> [   53.449740] Call trace:=20
>>> [   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
>>> [   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
>>> [   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
>>> [   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
>>> [   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
>>> [   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
>>> [   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
>>> [   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
>>> [   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
>>> [   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
>>> [   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
>>> [   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
>>> [   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
>>> [   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
>>> [   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
>>> [   53.450190] dfa0:                                     00000000 00000=
009 00000000 00000000
>>> [   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000=
000 be9e0a20 00000000
>>> [   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2=
ac0
>>> [   53.730379] reboot: Power down
>>>
>>> I'm not getting the warning with the same image but kernels 6.18+ or=20
>>> also 6.17.13 (the latter received this as backport as well). I do get=20
>>> the warning with 6.1.159 as well, and also when moving up to 6.12.63=20
>>> which received further ext4 backports. I didn't test 6.6 or 5.15 so far=
,=20
>>> but I suspect they are equally affected.
>>>
>>> Before digging deep into this to me unfamiliar subsystem: Could we miss=
=20
>>> some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to=
=20
>>> try out first?
>>
>> I suspect you're missing 4091c8206cfd ("ext4: clear i_state_flags when
>> alloc inode") (which BTW has Fixes tag to this commit).
>=20
> That is queued up for the next round of stable releases.  Hopefully the
> -rc releases for them will go out in a day or so.
>=20

Perfect. It indeed looks like that this missing commit was causing the
issue.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

