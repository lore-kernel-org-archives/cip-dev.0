Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF90E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 00:24:28 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
 by mx.groups.io with SMTP id smtpd.web10.30450.1733358267122837028
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 16:24:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=X8qZliFQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e396cc8c9a1so609882276.0
        for <cip-dev@lists.cip-project.org>; Wed, 04 Dec 2024 16:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1733358266; x=1733963066; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NIocvZFhwUaMmjAK9ESyv39S/9aTuLRkZaQYY48T2w=;
        b=X8qZliFQV75K35FENm/gd6Tqn80GoMb7Pi71H8e/VaSKA6VQeG5S4eDOGFfz+Q7rpM
         qd2mVX/Ueb/LX2WozGqVyKIDbW/v/U9lr9SfPkxQgh+o/W6ZT0hy4DMWC/1c1di+mhtl
         XDfc/30cuJAYccz3MeOJgj/TRxZMPRc6DlKbsL44fQUNRE1TXoA2Q+fpAi8bQ0IUuVkL
         vxCytoEgwqLgSgIUTcuA+uoeY/l8qHZRC4ffqmDz+ovxkL70ApncnhHUiLHLfKXqAAwU
         1vEf9HblpjMfHAyLnJBcVSkCuGgPnnFHFiXV75u3TrQLRL3QCPMZdo44h71RyanHTp/3
         9PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733358266; x=1733963066;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NIocvZFhwUaMmjAK9ESyv39S/9aTuLRkZaQYY48T2w=;
        b=rSGQ7ymtX5s00IKUEXA84X5fFbmisMa5l3WHCjxSJCjKUd9lJZ5lYyKQM5kVd7CMb7
         D+nbBcqZK2sI9DhI8ZxsFwfzIVikB5u3AzEz5AyYFZnRfKl4S7gYUIRYKoszEIFwvjFP
         b8mZ3MGThv9Wwb6vUMWUZpIsvM3Y2M9Ib43DT88jw3q43H7/Nup8EjuvU7xEep72He/8
         RnP7VE5iL+rtJKdu+mx8lBg5WzkbLtFY7jlG6kq7g+oWIb6GaICR6PgnkbjS9a8Nmhe4
         3Y4FKX6y5F/4WCdM7zGSu1trcBpsA6Zi1p4GuQRI0GnwaYwmcdmVPnkyBt2G1Y1MIZIG
         Ejpg==
X-Gm-Message-State: AOJu0YxIdbKz+6jVwINev4HksRejeWT5S8mh0JnEmjvxGzCMCxcE34yE
	iIvKRBBW1gprUEhjlw2cIal/F1W9glYsXw1/+LLQTJZym4zmG33Q+I813vHZ+THEVtIcicAaJmp
	Ur0YY4J1Loiw86846UrDPzpEiYX3Rk5W/y0EiHsAqJfIK3u50eQU=
X-Gm-Gg: ASbGnctEhxEij/uDalAOGw1TJpZbjfesxF67Xi59DKZCs5BHqQDRrtuL0j/udUh7Kc8
	SBlWK3Dn7SfIm03tNKRE+nJxZNQ7c3Uii
X-Google-Smtp-Source: AGHT+IEnBOk7RY7vjVCb82oZtcHY4YsDFCMap3dUALvLQMslHV8Z1VpiwVTAzYk49HYSfLG9lkocvsJAj5TEo8mzgSY=
X-Received: by 2002:a25:3f86:0:b0:e38:8d3b:66e0 with SMTP id
 3f1490d57ef6-e39f23d0d33mr1710885276.19.1733358265786; Wed, 04 Dec 2024
 16:24:25 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Dec 2024 09:23:49 +0900
Message-ID: <CAODzB9qS6WmUmqTyt-yX63Gynvkp8a2iKrH_jda9fgghWzRrRQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Dec 2024 00:24:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17327

Hi!

It's this week's CVE report.

This week reported 38 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2024-53103: hv_sock: Initializing vsk->trans to NULL to prevent a
dangling pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024120230-CVE-2024-53103-b5ea@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It looks this bug was introduced by commit ae0078f ("hv_sock: implements
Hyper-V transport for Virtual Sockets (AF_VSOCK)") in 4.14-rc1.

Fixed status
mainline: [e629295bd60abf4da1db85b82819ca6a4f6c1e79]
stable/4.19: [285266ef92f7b4bf7d26e1e95e215ce6a6badb4a]
stable/5.10: [414476c4fb11be070c09ab8f3e75c9ee324a108a]
stable/5.15: [7cf25987820350cb950856c71b409e5b6eed52bd]
stable/5.4: [4fe1d42f2acc463b733bb42e3f8e67dbc2a0eb2d]
stable/6.1: [98d8dde9232250a57ad5ef16479bf6a349e09b80]
stable/6.6: [4bdc5a62c6e50600d8a1c3e18fd6dce0c27c9497]

CVE-2024-53104: media: uvcvideo: Skip parsing frames of type
UVC_VS_UNDEFINED in uvc_parse_format

Announce: https://lore.kernel.org/linux-cve-announce/2024120232-CVE-2024-53104-d781@gregkh/

Introduced by commit c0efd23 ("V4L/DVB (8145a): USB Video Class
driver") in v2.6.26-rc9.
Fixed in v6.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecf2b43018da9579842c774b7f35dbe11b5c38dd]
stable/4.19: [95edf13a48e75dc2cc5b0bc57bf90d6948a22fe8]
stable/5.10: [faff5bbb2762c44ec7426037b3000e77a11d6773]
stable/5.15: [467d84dc78c9abf6b217ada22b3fdba336262e29]
stable/5.4: [684022f81f128338fe3587ec967459669a1204ae]
stable/6.1: [beced2cb09b58c1243733f374c560a55382003d6]
stable/6.6: [575a562f7a3ec2d54ff77ab6810e3fbceef2a91d]

CVE-2024-53105: mm: page_alloc: move mlocked flag clearance into
free_pages_prepare()

Announce: https://lore.kernel.org/linux-cve-announce/2024120244-CVE-2024-53105-d978@gregkh/

Introduced by commit b109b87 ("mm/munlock: replace clear_page_mlock()
by final clearance") in v5.18-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66edc3a5894c74f8887c8af23b97593a0dd0df4d]

CVE-2024-53106: ima: fix buffer overrun in ima_eventdigest_init_common

Announce: https://lore.kernel.org/linux-cve-announce/2024120246-CVE-2024-53106-8432@gregkh/

Introduced by commit 9fab303 ("ima: fix violation measurement list
record") in v5.19-rc7.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [923168a0631bc42fffd55087b337b1b6c54dcff5]
stable/6.1: [e01aae58e818503f2ffcd34c6f7dc6f90af1057e]
stable/6.6: [8a84765c62cc0469864e2faee43aae253ad16082]

CVE-2024-53107: fs/proc/task_mmu: prevent integer overflow in
pagemap_scan_get_args()

Announce: https://lore.kernel.org/linux-cve-announce/2024120247-CVE-2024-53107-4f83@gregkh/

Introduced by commit 52526ca ("fs/proc/task_mmu: implement IOCTL to
get and optionally clear info about PTEs") in v6.7-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [669b0cb81e4e4e78cff77a5b367c7f70c0c6c05e]

CVE-2024-53108: drm/amd/display: Adjust VSDB parser for replay feature

Announce: https://lore.kernel.org/linux-cve-announce/2024120247-CVE-2024-53108-effc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12.
Affected function was added by commit ec8e59c ("drm/amd/display: Get replay
info from VSDB") in 6.6-rc1.

Fixed status
mainline: [16dd2825c23530f2259fc671960a3a65d2af69bd]
stable/6.6: [0a326fbc8f72a320051f27328d4d4e7abdfe68d7]

CVE-2024-53109: nommu: pass NULL argument to vma_iter_prealloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024120247-CVE-2024-53109-2481@gregkh/

Introduced by commit b5df092 ("mm: set up vma iterator for
vma_iter_prealloc() calls") in v6.6-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [247d720b2c5d22f7281437fd6054a138256986ba]
stable/6.6: [8bbf0ab631cdf1dade6745f137cff98751e6ced7]

CVE-2024-53110: vp_vdpa: fix id_table array not null terminated error

Announce: https://lore.kernel.org/linux-cve-announce/2024120248-CVE-2024-53110-3bff@gregkh/

Introduced by commit ffbda8e ("vdpa/vp_vdpa : add vdpa tool support in
vp_vdpa") in v5.19-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e39ecadf1d2a08187139619f1f314b64ba7d947]
stable/6.1: [870d68fe17b5d9032049dcad98b5781a344a8657]
stable/6.6: [c4d64534d4b1c47d2f1ce427497f971ad4735aae]

CVE-2024-53111: mm/mremap: fix address wraparound in move_page_tables()

Announce: https://lore.kernel.org/linux-cve-announce/2024120248-CVE-2024-53111-eb9b@gregkh/

Introduced by commit af8ca1c ("mm/mremap: optimize the start addresses
in move_page_tables()") in v6.7-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4a282daf1a190f03790bf163458ea3c8d28d217]

CVE-2024-53112: ocfs2: uncache inode which has failed entering the group

Announce: https://lore.kernel.org/linux-cve-announce/2024120249-CVE-2024-53112-e04e@gregkh/

Introduced by commit 7909f2b ("[PATCH 2/2] ocfs2: Implement group add
for online resize") in v2.6.25-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [737f34137844d6572ab7d473c998c7f977ff30eb]
stable/6.1: [620d22598110b0d0cb97a3fcca65fc473ea86e73]
stable/6.6: [843dfc804af4b338ead42331dd58081b428ecdf8]

CVE-2024-53113: mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

Announce: https://lore.kernel.org/linux-cve-announce/2024120249-CVE-2024-53113-57df@gregkh/

Introduced by commit 387ba26 ("mm/page_alloc: add a bulk page
allocator") in v5.13-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ce41b0f9d77cca074df25afd39b86e2ee3aa68e]
stable/6.1: [6addb2d9501ec866d7b3a3b4e665307c437e9be2]
stable/6.6: [d0f16cec79774c3132df006cf771eddd89d08f58]

CVE-2024-53114: x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

Announce: https://lore.kernel.org/linux-cve-announce/2024120249-CVE-2024-53114-c500@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12.
Affected function was added by commit 30fa9283 ("x86/CPU/AMD: Add ZenX
generations flags") in 6.8-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0]

CVE-2024-53115: drm/vmwgfx: avoid null_ptr_deref in
vmw_framebuffer_surface_create_handle

Announce: https://lore.kernel.org/linux-cve-announce/2024120250-CVE-2024-53115-fd6e@gregkh/

Introduced by commit d6667f0 ("drm/vmwgfx: Fix handling of dumb
buffers") in v6.11-rc2.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93d1f41a82de382845af460bf03bcb17dcbf08c5]

CVE-2024-53116: drm/panthor: Fix handling of partial GPU mapping of BOs

Announce: https://lore.kernel.org/linux-cve-announce/2024120250-CVE-2024-53116-ab42@gregkh/

Introduced by commit 647810e ("drm/panthor: Add the MMU/VM logical
block") in v6.10-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3387e043918e154ca08d83954966a8b087fe2835]

CVE-2024-53117: virtio/vsock: Improve MSG_ZEROCOPY error handling

Announce: https://lore.kernel.org/linux-cve-announce/2024120250-CVE-2024-53117-145b@gregkh/

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60cf6206a1f513512f5d73fa4d3dbbcad2e7dcd6]

CVE-2024-53118: vsock: Fix sk_error_queue memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024120251-CVE-2024-53118-c6d7@gregkh/

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbf7085b3ad1c7cc0677834c90f985f1b4f77a33]

CVE-2024-53119: virtio/vsock: Fix accept_queue memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024120251-CVE-2024-53119-4957@gregkh/

Introduced by commit 3fe356d ("vsock/virtio: discard packets only when
socket is really closed") in v5.10-rc6.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7b0ff5a866724c3ad21f2628c22a63336deec3f]
stable/6.1: [946c7600fa2207cc8d3fbc86a518ec56f98a5813]
stable/6.6: [897617a413e0bf1c6380e3b34b2f28f450508549]

CVE-2024-53120: net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Announce: https://lore.kernel.org/linux-cve-announce/2024120251-CVE-2024-53120-65fd@gregkh/

Introduced by commit 7fac5c2 ("net/mlx5: CT: Avoid reusing modify
header context for natted entries") in v5.14-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e99c6873229fe0482e7ceb7d5600e32d623ed9d9]
stable/6.1: [0c7c70ff8b696cfedba350411dca736361ef9a0f]
stable/6.6: [06dc488a593020bd2f006798557d2a32104d8359]

CVE-2024-53121: net/mlx5: fs, lock FTE when checking if active

Announce: https://lore.kernel.org/linux-cve-announce/2024120252-CVE-2024-53121-34da@gregkh/

Introduced by commit 718ce4d ("net/mlx5: Consolidate update FTE for
all removal changes") in v5.1-rc1.
Introduced by commit cefc235 ("net/mlx5: Fix FTE cleanup") in v5.9-rc7.
Fixed in v6.12.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [9ca314419930f9135727e39d77e66262d5f7bef6]
stable/6.1: [bfba288f53192db08c68d4c568db9783fb9cb838]
stable/6.6: [094d1a2121cee1e85ab07d74388f94809dcfb5b9]

CVE-2024-53122: mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

Announce: https://lore.kernel.org/linux-cve-announce/2024120252-CVE-2024-53122-f35c@gregkh/

Introduced by commit c76c695 ("mptcp: call tcp_cleanup_rbuf on
subflows") in v5.10-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce7356ae35943cc6494cc692e62d51a734062b7d]
stable/6.1: [24995851d58c4a205ad0ffa7b2f21e479a9c8527]
stable/6.6: [ff825ab2f455299c0c7287550915a8878e2a66e0]

CVE-2024-53123: mptcp: error out earlier on disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2024120252-CVE-2024-53123-cd09@gregkh/

Introduced by commit 419ce13 ("tcp: allow again tcp_disconnect() when
threads are waiting") in v6.6-rc7.
Fixed in v6.12.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [581302298524e9d77c4c44ff5156a6cd112227ae]
stable/6.1: [a749b23059b43a9b1787eb36c5d9d44150a34238]
stable/6.6: [a66805c9b22caf4e42af7a616f6c6b83c90d1010]

CVE-2024-53124: net: fix data-races around sk->sk_forward_alloc

Announce: https://lore.kernel.org/linux-cve-announce/2024120253-CVE-2024-53124-91b3@gregkh/

Introduced by commit e994b2f ("tcp: do not lock listener to process
SYN packets") in v4.4-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [073d89808c065ac4c672c0a613a71b27a80691cb]

CVE-2024-53125: bpf: sync_linked_regs() must preserve subreg_def

Announce: https://lore.kernel.org/linux-cve-announce/2024120413-CVE-2024-53125-69ff@gregkh/

Introduced by commit 7574883 ("bpf: Propagate scalar ranges through
register assignments.") in v5.10-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9bd9c498cb0f5843996dbe5cbce7a1836a83c70]

CVE-2024-53126: vdpa: solidrun: Fix UB bug with devres

Announce: https://lore.kernel.org/linux-cve-announce/2024120448-CVE-2024-53126-0282@gregkh/

Introduced by commit 51a8f9d ("virtio: vdpa: new SolidNET DPU
driver.") in v6.3-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b364cf53b20204e92bac7c6ebd1ee7d3ec62931]
stable/6.6: [d372dd09cfbf1324f54cbffd81fcaf6cdf3e608e]

CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages
bigger than 4K"

Announce: https://lore.kernel.org/linux-cve-announce/2024120449-CVE-2024-53127-518c@gregkh/

Introduced by commit 8396c79 ("mmc: dw_mmc: Fix IDMAC operation with
pages bigger than 4K") in v6.11-rc7.
Fixed in v6.12.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.6

Fixed status
mainline: [1635e407a4a64d08a8517ac59ca14ad4fc785e75]
stable/6.1: [8f9416147d7ed414109d3501f1cb3d7a1735b25a]
stable/6.6: [56de724c58c07a7ca3aac027cfd2ccb184ed9e4e]

CVE-2024-53128: sched/task_stack: fix object_is_on_stack() for KASAN
tagged pointers

Announce: https://lore.kernel.org/linux-cve-announce/2024120449-CVE-2024-53128-f08c@gregkh/

None
According to the commit log, triggering this bug need to be enabled KASAN_STACK
and KASAN_SW_TAGS.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58]

CVE-2024-53129: drm/rockchip: vop: Fix a dereferenced before check warning

Announce: https://lore.kernel.org/linux-cve-announce/2024120449-CVE-2024-53129-9f04@gregkh/

Introduced by commit 5ddb0bd ("drm/atomic: Pass the full state to
planes async atomic check and update") in v5.13-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1c793f457f740ab7108cc0b1340a402dbf484d]
stable/6.1: [656dbd1c21c2c088c70059cdd43ec83e7d54ec4d]
stable/6.6: [1e53059729691ca4d905118258b9fbd17d854174]

CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Announce: https://lore.kernel.org/linux-cve-announce/2024120450-CVE-2024-53130-5621@gregkh/

Introduced by commit 5305cb8 ("block: add block_{touch|dirty}_buffer
tracepoint") in v3.9-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2026559a6c4ce34db117d2db8f710fe2a9420d5a]
stable/6.1: [86b19031dbc79abc378dfae357f6ea33ebeb0c95]
stable/6.6: [b0e4765740040c44039282057ecacd7435d1d2ba]

CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint

Announce: https://lore.kernel.org/linux-cve-announce/2024120450-CVE-2024-53131-60ad@gregkh/

Introduced by commit 5305cb8 ("block: add block_{touch|dirty}_buffer
tracepoint") in v3.9-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd45e963e44b0f10d90b9e6c0e8b4f47f3c92471]
stable/6.1: [3b2a4fd9bbee77afdd3ed5a05a0c02b6cde8d3b9]
stable/6.6: [59b49ca67cca7b007a5afd3de0283c8008157665]

CVE-2024-53132: drm/xe/oa: Fix "Missing outer runtime PM protection" warning

Announce: https://lore.kernel.org/linux-cve-announce/2024120450-CVE-2024-53132-2d51@gregkh/

Introduced by commit e936f88 ("drm/xe/oa/uapi: Expose OA stream fd")
in v6.11-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0403e4ceecaefbeaf78263dffcd3e3f06a19f6b]

CVE-2024-53133: drm/amd/display: Handle dml allocation failure to avoid crash

Announce: https://lore.kernel.org/linux-cve-announce/2024120451-CVE-2024-53133-b0b7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12.

Fixed status
mainline: [6825cb07b79ffeb1d90ffaa7a1227462cdca34ae]

CVE-2024-53134: pmdomain: imx93-blk-ctrl: correct remove path

Announce: https://lore.kernel.org/linux-cve-announce/2024120451-CVE-2024-53134-cb0a@gregkh/

Introduced by commit e9aa77d ("soc: imx: add i.MX93 media blk ctrl
driver") in v6.1-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7c7c5aa556378a2c8da72c1f7f238b6648f95fb]
stable/6.6: [8fc228ab5d38a026eae7183a5f74a4fac43d9b6a]

CVE-2024-53135: KVM: VMX: Bury Intel PT virtualization (guest/host
mode) behind CONFIG_BROKEN

Announce: https://lore.kernel.org/linux-cve-announce/2024120451-CVE-2024-53135-8dcc@gregkh/

Introduced by commit f99e3da ("KVM: x86: Add Intel PT virtualization
work mode") in v5.0-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa0d42cacf093a6fcca872edc954f6f812926a17]
stable/6.1: [e6716f4230a8784957273ddd27326264b27b9313]
stable/6.6: [d28b059ee4779b5102c5da6e929762520510e406]

CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Announce: https://lore.kernel.org/linux-cve-announce/2024120452-CVE-2024-53136-f7f8@gregkh/

This CVE announce does not contain fixed commit in the mainline.
This bug was introduced by commit d949d1d ("mm: shmem: fix data-race
in shmem_getattr()")
in 6.12-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/5.10 cip/5.10-rt cip/6.1 stable/4.19 stable/5.10
stable/5.15 stable/5.4 stable/6.1 stable/6.11 stable/6.6

Fixed status
mainline: [d1aa0c04294e29883d65eac6c2f72fe95cc7c049]
stable/6.1: [5874c1150e77296565ad6e495ef41fbf87570d14]
stable/6.6: [64e67e8694252c1bf01b802ee911be3fee62c36b]

CVE-2024-53137: ARM: fix cacheflush with PAN

Announce: https://lore.kernel.org/linux-cve-announce/2024120452-CVE-2024-53137-b908@gregkh/

Introduced by commit 7af5b90 ("ARM: 9358/2: Implement PAN for LPAE by
TTBR0 page table walks disablement") in v6.10-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca29cfcc4a21083d671522ad384532e28a43f033]

CVE-2024-53138: net/mlx5e: kTLS, Fix incorrect page refcounting

Announce: https://lore.kernel.org/linux-cve-announce/2024120452-CVE-2024-53138-1849@gregkh/

Introduced by commit 84d1bb2 ("net/mlx5e: kTLS, Limit DUMP wqe size")
in v5.4-rc6.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd6e972cc5890d91d6749bb48e3912721c4e4b25]
stable/6.1: [69fbd07f17b0fdaf8970bc705f5bf115c297839d]
stable/6.6: [93a14620b97c911489a5b008782f3d9b0c4aeff4]

CVE-2024-53139: sctp: fix possible UAF in sctp_v6_available()

Announce: https://lore.kernel.org/linux-cve-announce/2024120453-CVE-2024-53139-4311@gregkh/

Introduced by commit 6fe1e52 ("sctp: check ipv6 addr with sk_bound_dev
if set") in v6.2-rc1.
Fixed in v6.12.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb72e7fcc83987d5d5595b43222f23b295d5de7f]
stable/6.6: [ad975697211f4f2c4ce61c3ba524fd14d88ceab8]

CVE-2024-53140: netlink: terminate outstanding dump on socket close

Announce: https://lore.kernel.org/linux-cve-announce/2024120453-CVE-2024-53140-6ecf@gregkh/

Introduced by commit ed5d778 ("netlink: Do not schedule work from
sk_destruct") in v4.9.
Fixed in v6.12.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [1904fb9ebf911441f90a68e96b22aa73e4410505]
stable/6.1: [4e87a52133284afbd40fb522dbf96e258af52a98]
stable/6.6: [bbc769d2fa1b8b368c5fbe013b5b096afa3c05ca]

* Updated CVEs

no updates.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

