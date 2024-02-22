Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B321DC48BEB
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 00:31:53 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web10.2363.1708561906385304602
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 16:31:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0Y6i9iNV;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.41, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21e5fa2f7efso605025fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 16:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1708561905; x=1709166705; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F02dBCulYayWhLsMEan/wnYaRdc753auZl4fB9NpbrU=;
        b=0Y6i9iNV6Px069UIk3xr4ySRIeomL1E4v3T3rgOgyCjnUNhZ6MMyudG+Kzf/D38sYH
         pRrC2gm4UJUg+YjzI0qej/GGZhm+BTbwKH+9ye74ERQNWvkqzOwTtRipdYS5DMYkhOMy
         MbTWs03FqU30KJkQ3uZXgO/QrqJP22M5CQBIttsUWEaRqnwMIVdebWlITYIEOh2C0+mN
         2Hud91hYawV+3/HCG/tyKeQHDNnE1Z9n1LHSCILITXZlw3lrasLUrgiZT/Xrs31RIy3u
         b5VhdUXCehrjfw1S8rNMHxCVVl7zYT3zUuyZg0YLD+JbuRJCj8Q9WLOT2JoqLMj1/gbb
         lW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561905; x=1709166705;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F02dBCulYayWhLsMEan/wnYaRdc753auZl4fB9NpbrU=;
        b=eAQM/okGq1DY8ywXaWH/fiQpXMEozfeP+8NWyvTZNLjpqdKB/9ggNGL5wqLssA7iEc
         ExpXcBm6R9F6VcDg7WnevpjS5ZUV1fSnSOyq2k4T98B7fhoHt8kqF7m5TYc/EK6ZBIaP
         GN1z4ON4Yz1d4FAJLTpDlXMhGon6kEcce/m1oOW5Qo5gvjdO3eaGD3PISWO8Ovoa/zKV
         L03siIhNRWCf1FO1p5m1IG4VXXIAa7ZMhRkJUvVQG0HRYw8VBGMmaKigjWbj48xx+Hep
         /P2cZK/nEA4L/MyeoOYMa21XCyQ2swpCqwevge2ibL4J5ydlL7T8gjLN67TwrlRk8iBf
         lLqg==
X-Gm-Message-State: AOJu0Ywetic5p17U+mIa9NWLes80v1WVI14uKDcVg09DKFNt++W2DHrB
	Vgrjhj5sp1+ic2Kn7PDejYMuEPOcvcVGZ736zEmvwdUo69a7D5aP4AbTEPXkvDS3MC95xm0Oxeu
	QK9JKYAKzaLtgC/6ao1sqhwaa7UJiE0D0A64bmZ1rQP91OolnJcw=
X-Google-Smtp-Source: AGHT+IHY0ensbXdvxZ+YXiMMIOovVUgRUOkRIGXEiGV1dImuMO98jsjUi5uan+n4FtpVMHYPGGb4tgQdgqHzIMjqPgo=
X-Received: by 2002:a05:6870:8a0f:b0:21e:c717:625e with SMTP id
 p15-20020a0568708a0f00b0021ec717625emr11757310oaq.46.1708561905066; Wed, 21
 Feb 2024 16:31:45 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Feb 2024 09:31:09 +0900
Message-ID: <CAODzB9qsE8-ADWL2JMgXJnLeOfdFHuDEi6D0tYhQb_J2cF9bAg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 00:31:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15057

Hi!

It's this week's CVE report.

This week reported 15 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-52433: netfilter: nft_set_rbtree: skip sync GC for new
elements in this transaction

Announce: https://lore.kernel.org/linux-cve-announce/2024022058-outsell-equator-e1c5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
netfilter: nft_set_rbtree: skip sync GC for new elements in this
transaction New elements in this transaction might expired before such
transaction ends.
Skip sync GC for such elements otherwise commit path might walk over
an already released object. Once transaction is finished,
async GC will collect such expired element.

This bug was introduced by commit f6c383b ("netfilter: nf_tables:
adapt set backend to use GC transaction API") in 6.5-rc6.
This patch is not backported to 4.x kernels. Therefore, 4.19, 4.14,
and 4.4 are not affected.

Fixed by commit 2ee52ae ("netfilter: nft_set_rbtree: skip sync GC for
new elements in this transaction") in 6.6-rc1.

Fixed status
mainline: [2ee52ae94baabf7ee09cf2a8d854b990dac5d0e4]
stable/5.10: [c323ed65f66e5387ee0a73452118d49f1dae81b8]
stable/5.15: [9af7dfb3c9d7985172a240f85e684c5cd33e29ce]
stable/5.4: [03caf75da1059f0460666c826e9f50e13dfd0017]
stable/6.1: [9a8c544158f68f656d1734eb5ba00c4f817b76b1]

CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_contexts()

Announce: https://lore.kernel.org/linux-cve-announce/2024022033-makeshift-flammable-cb72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An OOB bug was found in smb2_parse_contexts(). The
smb2_parse_contexts() needed to validate offsets and lengths before
creating contexts.

Fixed by commit af1689a ("smb: client: fix potential OOBs in
smb2_parse_contexts()") in 6.7-rc6.

Fixed status
mainline: [af1689a9b7701d9907dfc84d2a4b57c4bc907144]
stable/6.6: [17a0f64cc02d4972e21c733d9f21d1c512963afa]

CVE-2023-52435: net: prevent mss overflow in skb_segment()

Announce: https://lore.kernel.org/linux-cve-announce/2024022048-rind-huff-b1a2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Invalid mss value causes invalid page access when calculating
partial_segs in slb segment().
Added length check to prevent length size should be smaller than GSO_BY_FRAGS.

This bug was introduced by commit 3953c46 ("sk_buff: allow segmenting
based on frag sizes") in 4.8-rc1.
This commit is not backported to 4.4 so 4.4 kernels are not affected.

Fixed by commit 23d05d5 ("net: prevent mss overflow in skb_segment()
") in 6.7-rc6.

Fixed status
mainline: [23d05d563b7e7b0314e65c8e882bc27eac2da8e7]
stable/6.6: [95b3904a261a9f810205da560e802cc326f50d77]

CVE-2023-52436: f2fs: explicitly null-terminate the xattr list

Announce: https://lore.kernel.org/linux-cve-announce/2024022056-operative-cork-082c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
f2fs: explicitly null-terminate the xattr list When setting an xattr,
explicitly null-terminate the xattr list. This eliminates the fragile
assumption that the unused xattr space is always zeroed.

Fixed by commit e26b6d3 ("f2fs: explicitly null-terminate the xattr
list") in 6.8-rc1.

It seems as if 4.4 kernels are affected too.

Fixed status
mainline: [e26b6d39270f5eab0087453d9b544189a38c8564]
stable/4.19: [16ae3132ff7746894894927c1892493693b89135]
stable/5.10: [3e47740091b05ac8d7836a33afd8646b6863ca52]
stable/5.15: [32a6cfc67675ee96fe107aeed5af9776fec63f11]
stable/5.4: [12cf91e23b126718a96b914f949f2cdfeadc7b2a]
stable/6.1: [5de9e9dd1828db9b8b962f7ca42548bd596deb8a]
stable/6.6: [2525d1ba225b5c167162fa344013c408e8b4de36]
stable/6.7: [f6c30bfe5a49bc38cae985083a11016800708fea]

CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Announce: https://lore.kernel.org/linux-cve-announce/2024022009-subsoil-halt-4b28@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The commit 5e2cf33 ("md/raid5: Wait for MD_SB_CHANGE_PENDING in
raid5d") causes a deadlock bug. So revert 5e2cf33 to fix the deadlock.
The commit 5e2cf33 is not backported to 4.4 so 4.4 kernels are not affected.

Fixed by commit bed9e27 ("Revert "md/raid5: Wait for
MD_SB_CHANGE_PENDING in raid5d"") in 6.8-rc1.

Fixed status
mainline: [bed9e27baf52a09b7ba2a3714f1e24e17ced386d]
stable/5.15: [0ee3ded745ca8ce68e107d9b5e5d33938e091003]
stable/6.1: [bed0acf330b2c50c688f6d9cfbcac2aa57a8e613]
stable/6.6: [e16a0bbdb7e590a6607b0d82915add738c03c069]
stable/6.7: [0de40f76d567133b871cd6ad46bb87afbce46983]

CVE-2023-52438: binder: fix use-after-free in shinker's callback

Announce: https://lore.kernel.org/linux-cve-announce/2024022017-slit-wish-e5d7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A use-after-free bug was found in the binder driver.
This bug was introduced by commit dd2283f ("mm: mmap: zap pages with
read mmap_sem in munmap") in 4.20-rc1.
The commit dd2283f is not backported to 4.x kernels so that kernel 4.x
are not affected.

Fixed by commit 3f489c2 ("binder: fix use-after-free in shinker's
callback") in 6.8-rc1.

Fixed status
mainline: [3f489c2067c5824528212b0fc18b28d51332d906]
stable/5.10: [c8c1158ffb007197f31f9d9170cf13e4f34cbb5c]
stable/5.15: [8ad4d580e8aff8de2a4d57c5930fcc29f1ffd4a6]
stable/5.4: [a53e15e592b4dcc91c3a3b8514e484a0bdbc53a3]
stable/6.1: [9fa04c93f24138747807fe75b5591bb680098f56]
stable/6.6: [a49087ab93508b60d9b8add91707a22dda832869]
stable/6.7: [e074686e993ff1be5f21b085a3b1b4275ccd5727]

CVE-2023-52439: uio: Fix use-after-free in uio_open

Announce: https://lore.kernel.org/linux-cve-announce/2024022026-wobbling-jumbo-748e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A race condition bug causes use-after-free vulnerability in the uio_open().

This bug was introduced by commit 57c5f4d ("uio: fix crash after the
device is unregistered") in 4.18-rc5.
The commit 57c5f4d is not backported to 4.4 kernels so that 4.4
kernels are not affected.

Fixed by commit 0c9ae0b ("uio: Fix use-after-free in uio_open") in 6.8-rc1.

Fixed status
mainline: [0c9ae0b8605078eafc3bea053cc78791e97ba2e2]
stable/4.19: [3174e0f7de1ba392dc191625da83df02d695b60c]
stable/5.10: [5e0be1229ae199ebb90b33102f74a0f22d152570]
stable/5.15: [5cf604ee538ed0c467abe3b4cda5308a6398f0f7]
stable/5.4: [e93da893d52d82d57fc0db2ca566024e0f26ff50]
stable/6.1: [17a8519cb359c3b483fb5c7367efa9a8a508bdea]
stable/6.6: [35f102607054faafe78d2a6994b18d5d9d6e92ad]
stable/6.7: [913205930da6213305616ac539447702eaa85e41]

CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element from gc

Announce: https://lore.kernel.org/linux-cve-announce/2024022024-uniquely-recluse-d893@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
netfilter: nft_set_rbtree: skip end interval element from
gc rbtree lazy gc on insert might collect an end interval element that
has been just added in this transactions,
skip end interval elements that are not yet active.

The commit f718863 is not backported to 4.x kernels so that 4.x
kernels are not affected.
Fixed by commit 60c0c23 ("netfilter: nft_set_rbtree: skip end interval
element from gc") in 6.8-rc4.

Fixed status
mainline: [60c0c230c6f046da536d3df8b39a20b9a9fd6af0]
stable/6.1: [1296c110c5a0b45a8fcf58e7d18bc5da61a565cb]
stable/6.6: [b734f7a47aeb32a5ba298e4ccc16bb0c52b6dbf7]
stable/6.7: [6eb14441f10602fa1cf691da9d685718b68b78a9]

CVE-2023-52440: ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()

Announce: https://lore.kernel.org/linux-cve-announce/2024022123-glance-wrinkle-26c1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
If authblob->SessionKey.Length is bigger than session key
size(CIFS_KEY_SIZE), slub overflow can happen in key exchange codes.
cifs_arc4_crypt copy to session key array from SessionKey from client.

Fixed by commit 4b081ce0 ("ksmbd: fix slub overflow in
ksmbd_decode_ntlmssp_auth_blob()") in 6.6-rc1.
The ksmbd was introduced in 5.15 so prior to this version is not affected.

Fixed status
mainline: [4b081ce0d830b684fdf967abc3696d1261387254]
stable/5.15: [bd554ed4fdc3d38404a1c43d428432577573e809]
stable/6.1: [30fd6521b2fbd9b767e438e31945e5ea3e3a2fba]

CVE-2023-52441: ksmbd: fix out of bounds in init_smb2_rsp_hdr()

Announce: https://lore.kernel.org/linux-cve-announce/2024022129-gently-activity-ca7d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ksmbd: fix out of bounds in init_smb2_rsp_hdr()
If client send smb2 negotiate request and then send smb1 negotiate
request, init_smb2_rsp_hdr is called for smb1
negotiate request since need_neg is set to false. This patch ignore
smb1 packets after ->need_neg is set to false.

Fixed by commit 536bb492 ("ksmbd: fix out of bounds in
init_smb2_rsp_hdr()") in 6.5-rc4.
The ksmbd was introduced in 5.15 so prior to this version is not affected.

Fixed status
mainline: [536bb492d39bb6c080c92f31e8a55fe9934f452b]
stable/5.15: [5c0df9d30c289d6b9d7d44e2a450de2f8e3cf40b]
stable/6.1: [330d900620dfc9893011d725b3620cd2ee0bc2bc]

CVE-2023-52442: ksmbd: validate session id and tree id in compound request

Announce: https://lore.kernel.org/linux-cve-announce/2024022132-unvented-arguably-5ea9@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ksmbd: validate session id and tree id in
compound request `smb2_get_msg()` in smb2_get_ksmbd_tcon() and
smb2_check_user_session() will always return
the first request smb2 header in a compound request. if
`SMB2_TREE_CONNECT_HE` is the first command in compound
request, will return 0, i.e. The tree id check is skipped. This patch
use ksmbd_req_buf_next() to get current
command in compound.

Fixed by commit 3df0411 ("ksmbd: validate session id and tree id in
compound request") in 6.5-rc4.
The ksmbd was introduced in 5.15 so prior to this version is not affected.

Fixed status
mainline: [3df0411e132ee74a87aa13142dfd2b190275332e]
stable/5.15: [017d85c94f02090a87f4a473dbe0d6ee0da72693]
stable/6.1: [becb5191d1d5fdfca0198a2e37457bbbf4fe266f]

CVE-2024-26582: net: tls: fix use-after-free with partial reads and
async decrypt

Announce: https://lore.kernel.org/linux-cve-announce/2024022139-spruce-prelude-c358@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
net: tls: fix use-after-free with partial reads
and async decrypt tls_decrypt_sg doesn't take a reference on the pages
from clear_skb, so the put_page() in
tls_decrypt_done releases them, and we trigger a use-after-free in
process_rx_list when we try to read from the
partially-read skb.

This bug was introduced by commit fd31f39 ("tls: rx: decrypt into a
fresh skb") in 6.0-rc1.
This commit is not backported to 5.x and 4.x kernels.

Fixed by commit 32b55c ("net: tls: fix use-after-free with partial
reads and async decrypt") in 6.8-rc5.

Fixed status
mainline: [32b55c5ff9103b8508c1e04bfa5a08c64e7a925f]

CVE-2024-26583: tls: fix race between async notify and socket close

Announce: https://lore.kernel.org/linux-cve-announce/2024022146-traction-unjustly-f451@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
tls: fix race between async notify and socket
close The submitting thread (one which called recvmsg/sendmsg) may
exit as soon as the async crypto handler calls
complete() so any code past that point risks touching already freed
data. Try to avoid the locking and extra flags
altogether. Have the main thread hold an extra reference, this way we
can depend solely on the atomic ref counter
for synchronization. Don't futz with reiniting the completion, either,
we are now tightly controlling when
completion fires.

This bug was introduced by commit 0cada33 ("net/tls: fix race
condition causing kernel panic") in 5.7.
This commit was backported to 5.4 but not to 4.x kernels. so kernel
4.x are not affected.

Fixed by commit aec7961 ("tls: fix race between async notify and
socket close") in 6.8-rc5.

Fixed status
mainline: [aec7961916f3f9e88766e2688992da6980f11b8d]

CVE-2024-26584: net: tls: handle backlogging of crypto requests

Announce: https://lore.kernel.org/linux-cve-announce/2024022148-showpiece-yanking-107c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
net: tls: handle backlogging of crypto requests
Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt}
can return -EBUSY instead of -EINPROGRESS in valid situations. For
example, when the cryptd queue for AESNI is full
(easy to trigger with an artificially low cryptd.cryptd_max_cpu_qlen),
requests will be enqueued to the backlog but still
processed. In that case, the async callback will also be called twice:
first with err == -EINPROGRESS, which it seems we
can just ignore, then with err == 0. Compared to Sabrina's original
patch this version uses the new tls_*crypt_async_wait()
helpers and converts the EBUSY to EINPROGRESS to avoid having to
modify all the error handling paths. The handling is identical.

This bug was introduced by a54667f ("tls: Add support for encryption
using async offload accelerator") in 4.16-rc1
This patch is not backported to 4.4.

Fixed by commit 8590541 ("net: tls: handle backlogging of crypto
requests") oin 6.8-rc5.

Fixed status
mainline: [8590541473188741055d27b955db0777569438e3]

CVE-2024-26585: tls: fix race between tx work scheduling and socket close

Announce: https://lore.kernel.org/linux-cve-announce/2024022150-fancy-numerate-94ab@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
tls: fix race between tx work scheduling and
socket close Similarly to previous commit, the submitting thread
(recvmsg/sendmsg) may exit as soon as the async
crypto handler calls complete(). Reorder scheduling the work before
calling complete(). This seems more logical
in the first place, as it's the inverse order of what the submitting
thread will do.

This bug was introduced by commit a42055e ("net/tls: Add support for
async encryption of records for performance")
in 4.20-rc1. Linux 4.19, and 4.4 are not affected.

Fixed by commit e01e393 ("tls: fix race between tx work scheduling and
socket close") in 6.8-rc5.

Fixed status
mainline: [e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb]

* Updated CVEs

CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed by memset()

stable/6.1 was fixed.

Fixed status
mainline: [4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9]
stable/6.1: [4675661672e3730597babf97c4e9593a775c8917]

CVE-2024-1151: net: openvswitch: limit the number of recursions from action sets

Fixed in 6.8-rc5.

Fixed status
mainline: [6e2f90d31fe09f2b852de25125ca875aabd81367]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

