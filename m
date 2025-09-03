Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFCFCA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 10:36:21 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.web10.9290.1756895775855926429
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 03:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jI3Sng5j;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU0fB9N4U2DMqcIofCZ4nXfXGcm/D2CDaEtTx8Qf+uYXft6GwPtXNwGThdBcfiihpHkTodJ8cYR3XZDCZVpzj6N54M0kMa2iUFwwaiWzDjYnJtM+CyZREDoeTgyJggiYjl10fXVZqn3JvbUnZp0LiPDb1cPFm6bDqBhjEGJap6ncJG8mwAYCLrMu7p4mPARefyRI8H16Zxp+i5Q8pjUWMxnJyVCJ9qnrpNrBIiPorTeMUq1aR4Fh3U8l553n6cvDnowdnBbiPSzHa4qs8ltYYZohCW/MOZzkLZc9e1BIUwkf/kTK+dfMvTv8BNsbL0Kq3BUfBw1rczXEbh0hojjpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWw0yNh0neMetmEQvyu5vVGagwoNa6+8rCcvlBixKTE=;
 b=woNdIcq05Yq8L0dqiMjr1iLSRwFb6E2vDw6or+V0rLN5wyiteGu43yoIMNys46pO3T1CskYVgEHmIT0T2wX0oJThFuLrgPmsUmx0wugRO1C/HWkRJADdOOgCapXjKVdw1I5QflLcraFw8TAjVcfT4T5FqtiK2/xRl1Vfsf7K2FkzPoGqwCS3f4jeBAKXGjU9lnaykWw0CmzosTvdIr3LFsRkzK0zZhif35cifMedZ1sDknjgBu89nqIOMhZQQayIIA1FgikEGIuLK9cnStJEbGux2ZYHnoCmjaaED7FrgoLVw4hP7M5HD2rCIqTpqWX/+v4GrzOn3kMMDJkkNntLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWw0yNh0neMetmEQvyu5vVGagwoNa6+8rCcvlBixKTE=;
 b=jI3Sng5j+Fer5jp//SgoAQ1u7i8fXJf2q0u0lzZMNRGVftFjflBA+jPM7+l69+dElZnfryPXMQdR/eP0cvokevNtshZxJBc2dYmuzg6qsLAG/KiJkYaWJQQsVT/j7UaA73nNQSWj/11q2XTQXBDIfSeLn6dT6IlTQikLmicHagbRkT2tSAKba5DrYU4Zcs6atdxlfQayI5yEk8MxCKTazoB9iSGfx37TQDGtrQx9I0Vp8+YDNIJ2nJZuelixuyNbk72EFTCvpGs3SWVGKSBWL2QzrxpZEpbDxmNabGL5MhNtfmb+/hIejTGD8QN9xp6tjPfVw82VtmQImb0r70vaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB8129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:115::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:36:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:36:06 +0000
Message-ID: <7a864d4e-3051-493c-a64a-cfda61c92936@siemens.com>
Date: Wed, 3 Sep 2025 12:36:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
To: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>, uli@fpond.eu,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "pavel@denx.de" <pavel@denx.de>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2409a1-7362-4f37-aab5-08ddead5b01f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HcRv3mLnGie3JxqaZv7TzvXmbSGcSeI5AUBsUXnsCS8ZniQZVhNad99iTdwR?=
 =?us-ascii?Q?BNsQxQRDxmaM+hdPgJHWbpVUPuqX45SGU850xURUWNxDxT754GfBlKi5o6oT?=
 =?us-ascii?Q?KPPuVKSiH47ONI3dlhYbBcLjUPkAlaMenCnRy6cB2pm6fmzkqsllJXRhQa/Q?=
 =?us-ascii?Q?acYihTw63Sdey5iyH+wQviDAaK/Gq1Ad0c3WSGZbPazM2KcqW5RNtZ1mXAiM?=
 =?us-ascii?Q?zHL/mC8Srx5qFKqldT8St0DFc3KSaNhqwJV2xCM4D80DCI4FwQrwaSaKk75k?=
 =?us-ascii?Q?tHIh5XxwejKiRgE9P90AiqzZsIu5nQGcrNHlGOvOat4LRFEw8UD6swouhbbk?=
 =?us-ascii?Q?ucZ7yUK30HK2VlJ2hHIygC1LXFBNb1Nm2F4hd7BuOMFN77ncNmzXm10szOmr?=
 =?us-ascii?Q?wo/w4VdjU62esXU5oZ+sbbgHOJPfMkn6TMqvEP/bZbkYPFJU6q5Kc0sVjVui?=
 =?us-ascii?Q?5UpAuG7v2NMQoQHmiQVLacxzUobAVhxZ4e2MaVlYdvedqP5pyRcuE58dYtWX?=
 =?us-ascii?Q?FU9zmQk/4Kq4aIi8jLRbKJr6iv7jycGAF2tVkLpYasuojreJR2BuhkVlKuAd?=
 =?us-ascii?Q?+GGiQ7EMF16n9eItMJFxvhMSeP8+cYIJW8nSURZ8Xevxr/mInaFej2MvcWtf?=
 =?us-ascii?Q?baKvEdYvI+AKYTJ8bUMO3SMR0plkPd+dNRIgR147JCex09ujk9eJynBzZ/IW?=
 =?us-ascii?Q?82NDnDA/jy7gXvKYoYA9sRR/gaaPqD43KsDg0u/oJw816ym6BE+Mu9wmim8n?=
 =?us-ascii?Q?cuFYxAl+4FrKpBRsQKn7KBxxXF6p6eKo2uaZJbbStgRqQPat5FxsmESKU9tX?=
 =?us-ascii?Q?hWLoToQQSlE3+cTTShNKcYSqNNpmjMcy0WzqdBZe+INXYTnN3p5dKZ2VtUmc?=
 =?us-ascii?Q?iNdS5CzLhkYWnzAwu1fiykQHxVnDuJKzilenJH1Qhc6C5x0rMWJ7TXBIKZ+v?=
 =?us-ascii?Q?mwi7LR3Jvy/7k/fzsfKuYD8UzZHuWlKZuLRFz6tjwbAPyOdoDotW7NYFG5WW?=
 =?us-ascii?Q?Zep87FKeuF8Iw7lpOi+Z2RYRhVSZVg6IBGDkfALaLUJu3I9fOM6HaFny3Lyq?=
 =?us-ascii?Q?OhWSsQSSwppIZSFlKx7tgYg712cMZxey+9oIf2OcPGaoLKqb1mhsbMc25B3+?=
 =?us-ascii?Q?iOv3saJEUN1BEigahvz6fTBfS2lhFOkfBz0T2zPwBvuXEJcXWKXinFR0GmS6?=
 =?us-ascii?Q?byFUuTvnn2yS4ZO5jr3NYZfGRCn5d6dnQE4wSCrWcORzDuCEw8r7an30zFAQ?=
 =?us-ascii?Q?zQ5Y+wTkg499nJasUBqY+Ulm3uSYr+MsLzYGL7+XpbgxrJRu9DmrFXqXoBmi?=
 =?us-ascii?Q?kMGgMJMCtYwIGLk2RMSfPhkCCbQ/Ao5rj5MRHMsFmFt3PFrKc4iZ3XpbJhCR?=
 =?us-ascii?Q?dupdqXc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8T0eu9W34I2KdDbmE7jG+BvPhf/dWUXh6GozLe7CdkxP6jQBkllCa8zeaqcO?=
 =?us-ascii?Q?GYPM4gw2AHIesfpagVxNHiJW4sQLsfCU05swRftMPXF4cJEiO9JO5Ew38W6m?=
 =?us-ascii?Q?3jeyAjaYf9wfQdnXkbpuEOvzv65KHTYsJFy/b+t+f8o9HehIwYZrJNiblxXy?=
 =?us-ascii?Q?yF8UIMf4nt1n/pDjqkz0tkcdWCkCSXRv5+AcxyaQfJ47cMRNLrt2FqsQaVWB?=
 =?us-ascii?Q?ULeMZM2bIjwHu30e7b88AbnIyvtepoOAzU5aeMDaYXxvqvglvPtKpvXj1gdU?=
 =?us-ascii?Q?Z657h1Gpr9iQQSeQv8QtOVhLQH0bNmdeX6b34Ua1foECAhYI+lGsem/R3YX6?=
 =?us-ascii?Q?fEvzOy9Qko0sIoCKx6NX64LWKg+w2cpj47QojqzTNQgLlg2pASPKpNVwl9ZV?=
 =?us-ascii?Q?5EDl1IimhTXaeG6VLblH/y6yNtF4pLLpnxfxoeOvcI4zITN2g75knQx3H3rs?=
 =?us-ascii?Q?ja59sAgmniS/0t9aLiRzE+W4rnF3qkYkckBQh19y9N45SnvUzJU8uFeHjfy1?=
 =?us-ascii?Q?Zqk0eJkE0SMmxTT9QQm3plS+HbyvpCwoXJwjlQ6z9/VwJZsYHsWgXxryEhLp?=
 =?us-ascii?Q?aRH99wEHuLkUnqMlI6/HR7yDVCSBC7B6V/mLf2bfY9S6WFLecsU9WoqaW95m?=
 =?us-ascii?Q?H6sXkOGrpwhTEgJD3nipYGPsKutoSHQRMJLrP5nwXVtXKcU35rTxz4r9Ysn8?=
 =?us-ascii?Q?wniLNV4tYr0qBS8SISwgq2pwxTdw5QRTPzs3zL2NAU21005D28vnBn2NpzQx?=
 =?us-ascii?Q?cRWYdDxNfKyH/SToLcXOGgC7imcdnme4wojTg4NsmOD20o8uULwFZRq1L9dT?=
 =?us-ascii?Q?wrjlPyn5AseXzzH/wTsuvUH41ttXeov5e6SK3w7sc3W7z9iBqLdat2Oq3hn9?=
 =?us-ascii?Q?9jyWkgHE7k4o28puuzjNF9Baq90lCX0j1wQ9gX++HF/Im7ic4OZ6yRVxCH2w?=
 =?us-ascii?Q?Xi04Ajj94xi9uI+mfMGvaY1doo1/SeCCamcKITGFaNiOjJS42/bRKaIMeWDy?=
 =?us-ascii?Q?c0jWaIbHjjzkNAI7DNy/lSkohU975wPAzfj+ANQkkJO7yM/OXXbxVTULJkUB?=
 =?us-ascii?Q?AEfvllZGIwPwyLm22u3Z0VBM71TUB/7+AgAm5Szl2ruR4p/8BviGAiephnEX?=
 =?us-ascii?Q?vjRWLqRbUewWULrqD0fgOr1CY/R6J86wNdyE8QEnNlse9SRnUnNnqlKhODG2?=
 =?us-ascii?Q?VSGVWLDmJV/VLijcz+luSiiLPuuUclSSsvvQcBibPhURm+1EHQOOdfJRKTn4?=
 =?us-ascii?Q?kdgZPHSwRHAhTs1Psmzrnl22vGoGmH3XqpBky/tiY+lh+xezE4KRnsuYOz3S?=
 =?us-ascii?Q?102+GiaEzHNpQY7yVXsm9Bq4FravdgZuz2oHUN+lj1zkrn1nQggMruMGtgPw?=
 =?us-ascii?Q?UrT4eRq/Cu3zITVTcpTBqfYTlnBhPXL/56FUelv52AU1mkVDImtHHa0bZ+vh?=
 =?us-ascii?Q?tJAoLvH1NpXiZznNJ++LvP4WXla2PA0ODvBkDrWbForSSK4gLymUfksy6WQw?=
 =?us-ascii?Q?44M3E4AEfJ53EB48rqlsvWPUeBH0YqkM7DBu1CQJMVU+A5MEGw3GiR3X1on3?=
 =?us-ascii?Q?zmeQY+0m+soc0ppo44tMgnorearL5t7uZAaXrh1/hyUCFqtgP8l9zpFbTiIs?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2409a1-7362-4f37-aab5-08ddead5b01f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 10:36:06.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teUMkHTWLnv3JgOe0j87Qn0Pa9MwioKbJ8xNhuBjy2OXcQ8+BAQ3xkInY/9MaERzS3tOJu6QXnjOM+q0Y66cBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 10:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19996

On 03.09.25 08:31, Kazunori Kobayashi wrote:
> Hi,
>=20
> On 8/19/25 00:21, Ulrich Hecht via lists.cip-project.org wrote:
>> Hi,
>>
>> the CIP kernel team has released Linux kernel v4.19.325-cip123. The linu=
x-4.19.y-cip tree's base version has been updated to v4.19-st7. The trees a=
re up-to-date with kernel 5.4.296.
>>
>> You can get this release via the git tree or as a tarball from https://m=
irrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/
>>
>>   v4.19.325-cip123:
>>     repository:
>>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>     branch:
>>       linux-4.19.y-cip
>>     commit hash:
>>       1e9cb006c55b0164de79c50947377a71deca9975
>>     Fixed CVEs:
>>       CVE-2024-26644: btrfs: don't abort filesystem when attempting to s=
napshot deleted subvolume
>>       CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
>>       CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and =
vmci_ctx_unset_notify
>>       CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects afte=
r cm_id destruction
>>       CVE-2025-38226: media: vivid: Change the siize of the composing
>>       CVE-2025-38230: jfs: validate AG parameters in dbMount() to preven=
t crashes
>>       CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs i=
n atm_dev_deregister().
>>       CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb=
_get_audioformat_uac3()
>>       CVE-2025-38350: net/sched: Always pass notifications when child cl=
ass becomes empty
>>       CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_d=
evice_down()
>>       CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments a=
re missing
>>       CVE-2025-38391: usb: typec: altmodes/displayport: do not index inv=
alid pin_assignments
>>       CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map fai=
lure
>>       CVE-2025-38403: vsock/vmci: Clear the vmci transport packet proper=
ly when initializing it
>>       CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
>>       CVE-2025-38445: md/raid1: Fix stack memory use after return in rai=
d1_reshape
>>       CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY w=
akeup
>>       CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class=
 does not exist
>>       CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sen=
dmsg()
>>       CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_pus=
h().
>>       CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atma=
rpd().
>>       CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
>>       CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
>>       CVE-2025-38404: usb: typec: displayport: Fix potential deadlock
>>       CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer derefer=
ence in zd_mac_tx_to_dev()
>>       CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc b=
acklog struct
>>       CVE-2025-38515: drm/sched: Increment job count before swapping tai=
l spsc queue
>>       CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics H=
P 5MP Cameras
>>       CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_=
create()
>>       CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.
>>
>> Best regards,
>> Ulrich Hecht
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#19754): https://lists.cip-project.org/g/cip-dev/mess=
age/19754
>> Mute This Topic: https://lists.cip-project.org/mt/114765008/7669380
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [kazunori.kob=
ayashi@cybertrust.co.jp]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
> I ran into the following compilation error with=C2=A0omap2plus_defconfig
> applied in this kernel version.
>=20
> | /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/
> build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/
> am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/ispccdc.c: In
> function 'ccdc_lsc_config': | /buildbot/
> build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-
> evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/
> kernel-source/drivers/media/platform/omap3isp/ispccdc.c:452:3: error:
> implicit declaration of function 'dma_sync_sgtable_for_cpu'; did you
> mean 'dma_sync_single_for_cpu'? [-Werror=3Dimplicit-function-declaration]
> | dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt, |
> ^~~~~~~~~~~~~~~~~~~~~~~~ | dma_sync_single_for_cpu | CC [M] drivers/
> media/rc/keymaps/rc-avermedia-a16d.o | /buildbot/
> build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-
> evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/
> kernel-source/drivers/media/platform/omap3isp/ispccdc.c:461:3: error:
> implicit declaration of function 'dma_sync_sgtable_for_device'; did you
> mean 'dma_sync_single_for_device'? [-Werror=3Dimplicit-function-
> declaration] | dma_sync_sgtable_for_device(isp->dev, &req->table.sgt, |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~ | dma_sync_single_for_device
>=20

Hah, now I can read it while replying to it in plaintext. ;)

> It seems caused by the following change.
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/
> commit/3483db997d491ba78957eb04743f6bb2ecc242aa
>=20
> This change seems merged from the 5.4 based kernel, but some other
> dependencies would also be needed to pass the compilation.
>=20

General question: Is that build breakage above not triggerable via the
cip-kernel-configs? If so, you likely want to make sure that it is. If
it was triggerable already, then we should try to understand why it was
missed.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

