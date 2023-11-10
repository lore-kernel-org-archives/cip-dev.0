Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B80C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:12:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.23045.1699600320748384830
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:12:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3AA7Bbj21447947; Fri, 10 Nov 2023 16:11:37 +0900
X-Iguazu-Qid: 2rWgs5nq7eqdZSIaC3
X-Iguazu-QSIG: v=2; s=0; t=1699600296; q=2rWgs5nq7eqdZSIaC3; m=rOYykX8EXjjjCwMTTm1LpaqeIL4+mKVodbPJyBS/kag=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3AA7BXp02478264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Nov 2023 16:11:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezaVGnUMWglu2ouIRXMrDE8dUfa/idwiakMXKfu8uQOkrK5sXNIvuTC8YCmtQPIPV6EKSKSveFXvt9+5lt3vQJFRIzHqJlDsvEoTzOIE10T2h4XKAgW7/oCN53BnXHJ9z7gaa8jyPd6ebaWkvVrLmEy+vajwFHOr+SwReIN1PB+7hseL7mWNvYgeC1Ibo1nZnKjArky+r6BUQhETTbfp3x7I1CjFxVbDZnZ1Q6mNOxsCu3savLO+nfPRmGwH/Sn7Zmp8OyO7/XEgzgprvvqw0glf03u0W+OmrMyDsOtut0k9dEm+ZZ+f86v5fwSBooNe6fTgbesirWk6kvj9PnE5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vS0oUqoeaLV8J9ytAsjwP0uU05w0UC0SPEp1Q40N3c=;
 b=RtuIXiLfjxuUEZnwshn14yWm1wxQcWzAxr4WP5uoqJibJWQMOQLN7TajpDWK/5XP0EpT77jy1SEmuNQH95wSsIzMxBZFemU0SuqF71gmfBm1CJAZqjf5rEsCtWrCr5nBGgD/6/wqwGcd2YOJgrHuG5Zu8SpFpP1zDjq65nqC4+1G8by1VK7UAaFB+ce3MgSL3PcTRgcgauXpFa4S3BjGo7uTsxQcnE4gorzz52TDgvslZmKVmDm8M2P0jT3kdfn4rs7lOCtp6YqyZk4e935goaUg5/a+CHfCsKyNQlKbZjwjAl0GgO870mRTfKUyZQJ3YuRCnAKYs9nMZLSPVjjFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] v5.10.200-cip40
Thread-Topic: [ANNOUNCE] v5.10.200-cip40
Thread-Index: AdoTpPzQRnRcVkfkS/COJjRm6eEbmQ==
Date: Fri, 10 Nov 2023 07:11:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245BE3411A7BBE511E17F7E92AEA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB11280:EE_
x-ms-office365-filtering-correlation-id: 412863ac-7147-40dd-76fc-08dbe1bc42bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cFvu2XTLy4Pzj1XUXHGLEFEHQYOAmnG9YXV85I+ZYgxRoAJwooOsRhAxLqV5GxOtt05IhUG1KHvsI5mbnRigigbXu5dNhN693H4CR8L4Y8yc3BOm5qaqsE4AizbyefUEYeov4isthoPhp+enwtFtrbfgMeNAPyWfC+Vo0HWOYsnlitky27KP2R/6Dz9a3JLHjKaTgpalMgzMscVmUu+nPyCJfXvrzpBjqoEFdxUAEcuMRZAg0Yk1oJzJz/t4QwZEDUNZGL4jliLA3O2sTyiOpSdJwcg4JqpzgImLAkHCwIswc38xCAstMGcmNIF3eYzS9vCtB0/BPeZENYmKsJ4+cyOd1WvwQpj2P3GP8CWq7uYvmWOaZVzp4fwzsGBdA3zhyV4CGMWf/rijZLLG5EOYyT6t368EBrgTlzMwba6vRh28hdLWulrMgmbtXe915QZzNa129DCsVx/0p8mD1mncpaLWZNhw7MhxajcM+51qUOUmneixIYasidAWc38fbEgOx47acGrlsH0jDx+Qm/m4oFzaRgQzRkT6Ld15pU8Hl3H1r/vDJjZNrTMPwjgwmWmqNMBdiZS7Ax03dDw75RSH4W4r+TM9kMBSv6Xo2a1henw1gpTVuW5+Djuq7jE/i0Yw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(9686003)(5660300002)(41300700001)(6506007)(7696005)(26005)(83380400001)(2906002)(55016003)(66946007)(66476007)(64756008)(66446008)(66556008)(54906003)(6916009)(71200400001)(316002)(52536014)(4326008)(8676002)(966005)(8936002)(478600001)(76116006)(33656002)(38070700009)(122000001)(38100700002)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q3piYWNBck5RMjNocW9oZWNBUjN3QW5aYndnNzZmS2ZyVU15dmM5U21M?=
 =?iso-2022-jp?B?bEJJbld2MnpyaEc4a3F2MGxkT3o3WWJGc3M5MElDaUtDQWZ4ekMzS2Nk?=
 =?iso-2022-jp?B?K0xUaGJOd3R3OStDQUg2WElnTVNwem1mdytWeXJCSFhCWE1RWVNTa0s0?=
 =?iso-2022-jp?B?ZjRzRytrUmdLMWxQTHB6VzZQaEUxV0Q1dHB1RHAwa0ZwVDIycTAxSlRP?=
 =?iso-2022-jp?B?cE1La28wUUw0ek0rRVN4WURUQzZpU09UVUpWQXBHaU9OdjhOcExIQy9i?=
 =?iso-2022-jp?B?YmF5bytpQVJXb3NHQmhDTTY5U3RsdmtpKzZiNC9iTUlPalNFamx1b01n?=
 =?iso-2022-jp?B?NnJnSEJBcWdiVFJ0clN3WnpHVDJ3YUNWcWxqWUdlLys5TCtOQ0FkWUkr?=
 =?iso-2022-jp?B?WlhOSzFNMHY3cXdMRVdjM1Qxc3RhVUVuck1ObHdyOGZrS1hmUC96UlR1?=
 =?iso-2022-jp?B?NC96cnl3ZjhoUkxlcE1xY2IxSVFSdVJyS2Z2VkdKOUdNZ2xuNUR5VXVC?=
 =?iso-2022-jp?B?VUJ6YXVueVFYUkUweFZqd0tyVGRHK0ZGM0crRTBCZ25JODRzNEFUVEpZ?=
 =?iso-2022-jp?B?Ris3d0wxNzVqdm1WOVQxUm84Q2I3SDhlQjBtV0NVVnIvalc2YjdsVnhs?=
 =?iso-2022-jp?B?NUpvKytVd3R0MnM3Ykl6WDBKYjdHbHlqY1NscmFFUFY1Qk1DMjIwOEhB?=
 =?iso-2022-jp?B?VWhXL1Z6SnN5aXk0QlJmWEF5b0ZBYkxwNjRjUmVNOE5PYzVvQkpqWDRv?=
 =?iso-2022-jp?B?ODJDUTR6MlRlVWVmS2N5TTY1SmE3dGRlb01RYVVIbXpwdzkrc25IZFdI?=
 =?iso-2022-jp?B?Y3VuMk9QdjVTKzBzVEFXNGMzK2loRU1BTkdGdHRaRmtHZk1HbjduOUI3?=
 =?iso-2022-jp?B?Y2pFWkFwWW1iZlZkL3JPaEZjL05qRVJndnlJUksxRm10Q05CWVVQbDNP?=
 =?iso-2022-jp?B?RWxxS2FTdWV5OVJjR0VQQjQ2d256ckFGb29JeUtHUGxadnAvOW1abVZW?=
 =?iso-2022-jp?B?d05vQnd3bnNlREIwRlBUYUxtSHZwc2FQL1JOcno5TVBmUWNZL2s3b05C?=
 =?iso-2022-jp?B?ZkZtT0lueGMrT1QxbVZJU2ZqeG9uNDNnOXhtMGNoSFZ4bTRGcVo5eEVM?=
 =?iso-2022-jp?B?dHFZR1NHcEljOCtraTNIZ1ZYbG02aUtlN3ROTklWT0h4cGJpeGJJT2xG?=
 =?iso-2022-jp?B?Qk53V2RNY05pMFlFMTRySGVyS3g1VHUzYVpGdkwrSlR2VkRWVDBQQ1Mz?=
 =?iso-2022-jp?B?OHRqeTZzdkt1K1ZnVlBKQlZoMTFhdkJPUzBvMnVoNWhBcE5RbnJEem5y?=
 =?iso-2022-jp?B?VXZ6TDVLbFE2SWZya2NXL3pHVStCUTJxOEdEOVE3QUhlSXI1YlBtTHQ2?=
 =?iso-2022-jp?B?eHYxdmZWaE0yV0V2S01TOTFiNTkzTDlQWEJZOHdRSitOVEltL3ZyN0oy?=
 =?iso-2022-jp?B?enF0aVNZWGVNSFF6dDBvS2JvOFl0cDdoeENhTldXWUZsYmlkUFZpVzVk?=
 =?iso-2022-jp?B?QnFLNUg4cVNuTStHRkJXSWY0QzJtUWREc1l4RTF0QlJIMFVBbXpZUWxp?=
 =?iso-2022-jp?B?cHVNUkdPRDFtWTlVUjA1VDJBcjNVOEkzNlIrWGg0NkcwZHQ4dWhRYzBk?=
 =?iso-2022-jp?B?VDkvZks5U3l0emJIZEtIaTY1V01hNUFDaGZEKzhBZXhNNW1xSWZnOFZQ?=
 =?iso-2022-jp?B?MDZEYUw2azhMTmo1ZkI0RmRMbURSdjBvS3FyWmk2U0NDZS91YmdTbVRI?=
 =?iso-2022-jp?B?aGhFMi9md2hSTmJka0hGeFZKOGJvVDFIZG1tUkswYlNJOUdBamx5aUhF?=
 =?iso-2022-jp?B?MkYvdThYSWg4Q0NxY3hGcGZLMHFEMnByd1gzbUFlTDRGMklBZzA1cDY5?=
 =?iso-2022-jp?B?U0haNDBUSFlHRDhPanpNNytyWUFyTUx5YTRkYk45VHYrQUp2Q0ZkcHVL?=
 =?iso-2022-jp?B?TGZCQ2NOdUFySHZ6QzQ1cnNjejgzNlh6cDVoRXN0ckRVQU43dHhrUFBo?=
 =?iso-2022-jp?B?WWlXSU0vQUhueEhnVGsveHc1Y3RBRUFZamhMVm0rdmwycDdyQXk5Ty9H?=
 =?iso-2022-jp?B?RWNaZUFQMEo3SitqMVdadGRydFZBbFpYb3pILzBlUVVzVlo0ZGMweE1K?=
 =?iso-2022-jp?B?SnkvS3Rvc3cwMnlKZXhVTkNoa1kwYlkyRXBGYjFHS0w2cDhORmE2T1pu?=
 =?iso-2022-jp?B?dDV5TU9wdG5DNkF5cjh2N0FhNjZKRzRQb3dhYWRYNkd6eDNkUnlBbWdv?=
 =?iso-2022-jp?B?L1E5T3J5b3VqMnRFL1pkUDRML3ROTDd3RTgwbXRIbzJDbkx3L2VHL0dU?=
 =?iso-2022-jp?B?RCt0ejFCMmVsR2s5cmhOV0I3YmVoa25tSVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412863ac-7147-40dd-76fc-08dbe1bc42bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 07:11:29.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOzQ7K5UzC2Dz4rCkM9B4MlyJmvYDeyInxJUf0DoXrH3nXarVxRkYDWGacD8TUGfjdY+ep5Z0tH4CjoFHNGRpU+5/dS7PqUn0LAI8fnhe3+Plu6xCZkOVs+bYcT5eXor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13555

Hi all,

CIP kernel team has released Linux kernel v5.10.200-cip40.
The linux-5.10.y-cip tree has been updated base version from v5.10.194 to v=
5.10.200.

You can get this release via the git tree at:

  v5.10.200-cip40:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      166400a23a22e665f5d880a99149b73abede402d
    Fixed CVEs:
      CVE-2023-42752: integer overflows in kmalloc_reserve()
      CVE-2023-37453: i out-of-bounds in read_descriptors in drivers/usb/co=
re/sysfs
      CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc cur=
ve
      CVE-2023-39192: netfilter: xt_u32: validate user space input
      CVE-2023-45871: igb: set max size RX buffer when store bad packet is =
enabled
      CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()
      CVE-2023-42753: netfilter: ipset: add the missing IP_SET_HASH_WITH_NE=
T0 macro for ip_set_hash_netportnet.c
      CVE-2023-39193: netfilter: xt_sctp: validate the flag_info count
      CVE-2023-39189: netfilter: nfnetlink_osf: avoid OOB read
      CVE-2023-42755: wild pointer access in rsvp classifer in the Linux ke=
rnel
      CVE-2023-4563: Use-after-free in nft_verdict_dump due to a race betwe=
en set GC and transaction
      CVE-2023-31085: BUG: divide error in ubi_attach_mtd_dev
      CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's n=
etfilter
      CVE-2023-42756: netfilter: ipset: Fix race between IPSET_CMD_CREATE a=
nd IPSET_CMD_SWAP
      CVE-2023-34324: xen/events: replace evtchn_rwlock with RCU
      CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack
      CVE-2023-5197: netfilter: nf_tables: disallow rule removal from chain=
 binding
      CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB writ=
e
      CVE-2023-46813: SEV-ES local priv escalation for userspace that have =
access to MMIO regions
      CVE-2023-35827: net: ravb: Fix possible UAF bug in ravb_remove
      CVE-2023-5717: perf: Disallow mis-matched inherited group reads
      CVE-2023-5178: nvmet-tcp: Fix a possible UAF in queue intialization s=
etup
      CVE-2023-45863: kobject: Fix slab-out-of-bounds in fill_kobj_path()
      CVE-2021-44879: f2fs: fix to do sanity check on inode type during gar=
bage collection
    added commits:
      CIP: Bump version suffix to -cip40 after merge from stable
      arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Best regards,
   Nobuhiro


