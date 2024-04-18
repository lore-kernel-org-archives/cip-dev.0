Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F0EC4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 04:10:30 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web10.4966.1713413421478144291
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Apr 2024 21:10:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Wo4XqNcs;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-222a9eae9a7so287254fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Apr 2024 21:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1713413420; x=1714018220; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9j5CJ3qC0e2lF7xS4dnpgO0+62+RwxD8yh3Ns574dQ=;
        b=Wo4XqNcs8QRWtx4s1KOiyt2FOFg4SSoro40rHrX/6zVtqF80uMlY42CIXqnQaPOPJW
         mElifYe15gcU0YT3LKVD58u8IjA0klitP6Zufcw4OMptShkwNuSfgkEYW1gMylzNmfFH
         jtQqS4k46HTA8qMLOQ3y7wLiBnDoN9SsdpOOtlB0xp81OdRlP9xQ5ndXaShN3wd1j8oW
         XlypqlqRnYOLxI8+PDM+jMVB+lVTSx2QlxiY2Q9xuOnnNHvLNJb4mJY2XgnQJWtSXos0
         sI7bxJNPheVxYozSNj5B9LJg+4Zv3APpotABR8ac+okISjfVrXf07wsQJMmz1zrqv5R7
         LJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413420; x=1714018220;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9j5CJ3qC0e2lF7xS4dnpgO0+62+RwxD8yh3Ns574dQ=;
        b=pGwWMr3KkUevR9DVCH/aZvxUWKep2ixvkVoRHkewgrxfPjGIp2zrcAYKgPb3CFvRS/
         eZZ2kmR6O9lYgA8bMwKKJ8GYISz4wBYDJy6GFuytPjiGD1Ee2+4roA9Fz6kYbIKrLBCD
         BCOOM/W3EFSNXDrcYEyD/I+Ch2v2m8OeiZYvGvHVMa+VVnhP9vsh6khGJPyjaiPiq7f4
         7GIe1NkbBCVvga4C2hMcYWsYZ4SY51mpX+QvJNkA0Rm2IcAXlc1UDdVKvgsR3yE16y/L
         WGZZh12GwsvxDvnwqhvBc/jIsCN5Szr6GwGZhpioqhjwUBYcuwewVAtGP6yK33Mf2eMr
         UMkg==
X-Gm-Message-State: AOJu0YzaHa/IeLl7FqEMUQOHfN5m2GNJsqdiT9/0Uae9gg9YFky8o0g9
	0USFzij+Z46xaLEH0r/BCqPCmB7fwBxI7DzqJgFxgACYuXle0wSkL1koD6XaDvxqvEm+VhmBhoS
	m6T7FXEMfelO8045SRPCaHntEG5ZYRof+DnsQngNfE6Cr479u3+8=
X-Google-Smtp-Source: AGHT+IHFbswL+AtgRGJNLjtlm35+DC39Gu5w7UF4aO6oiKEBsHad345W4ukEANoLG6rgYS6iMdt51MWwODwJXxF3YaE=
X-Received: by 2002:a05:6870:218c:b0:22a:919a:dc87 with SMTP id
 l12-20020a056870218c00b0022a919adc87mr1883882oae.56.1713413419146; Wed, 17
 Apr 2024 21:10:19 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Apr 2024 13:09:43 +0900
Message-ID: <CAODzB9pUURfj9iirtCABy_bSELepqCcfQjnV3CEUaziKyEM+Yg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 04:10:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15574

Hi!

It's this week's CVE report.

This week reported 108 new CVEs and 27 updated CVEs.

* New CVEs

CVE-2024-26817: amdkfd: use calloc instead of kzalloc to avoid integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024041311-CVE-2024-26817-e1a0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit is not determined. Fixed in master branch.
It looks as if this bug was introduced by commit c7bcbfa4f
("drm/amdkfd: Remove limit on number of GPUs") in 4.17-rc1.

Fixed status
mainline: [3b0daecfeac0103aba8b293df07a0cbaf8b43f29]
stable/4.19: [e6721ea845fcb93a764a92bd40f1afc0d6c69751]
stable/5.10: [fcbd99b3c73309107e3be71f20dff9414df64f91]
stable/5.15: [cbac7de1d9901521e78cdc34e15451df3611f2ad]
stable/5.4: [8b0564704255c6b3c6a7188e86939f754e1577c0]
stable/6.1: [e6768c6737f4c02cba193a3339f0cc2907f0b86a]
stable/6.6: [315eb3c2df7e4cb18e3eacfa18a53a46f2bf0ef7]

CVE-2023-52642: media: rc: bpf attach/detach requires write permission

Announce: https://lore.kernel.org/linux-cve-announce/2024041758-CVE-2023-52642-3261@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Affected functions were introduced by commit f4364dcf ("media: rc:
introduce BPF_PROG_LIRC_MODE2") in 4.18-rc1.

Fixed status
mainline: [6a9d552483d50953320b9d3b57abdee8d436f23f]
stable/5.10: [93d8109bf182510629bbefc8cd45296d2393987f]
stable/5.15: [d98210108e7b2ff64b332b0a3541c8ad6a0617b0]
stable/6.1: [9f6087851ec6dce5b15f694aeaf3e8ec8243224e]
stable/6.6: [93136132d1b5792bf44151e3494ae3691cd738e8]

CVE-2023-52643: iio: core: fix memleak in iio_device_register_sysfs

Announce: https://lore.kernel.org/linux-cve-announce/2024041701-CVE-2023-52643-8834@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 32f1717 ("iio: core: rework iio device group
creation") in v5.13-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [95a0d596bbd0552a78e13ced43f2be1038883c81]
stable/5.15: [1c6d19c8cbf6abcea2c8fca2db26abca2cbf0363]
stable/6.1: [359f220d0e753bba840eac19ffedcdc816b532f2]
stable/6.6: [b90126c86d83912688501826643ea698f0df1728]

CVE-2023-52644: wifi: b43: Stop/wake correct queue in DMA Tx path when
QoS is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024041732-CVE-2023-52644-e2a7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e6f5b93 ("b43: Add QOS support") in v2.6.26-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [c96084a13a9184651de06b6a8b4c939838271e3d]
cip/4.4-st: [c96084a13a9184651de06b6a8b4c939838271e3d]
mainline: [9636951e4468f02c72cc75a82dc65d003077edbc]
stable/4.19: [1824f942527f784a19e01eac2d9679a21623d010]
stable/5.10: [49f067726ab01c87cf57566797a8a719badbbf08]
stable/5.15: [04a2b6eff2ae1c19cb7f41e803bcbfaf94c06455]
stable/5.4: [31aaf17200c336fe258b70d39c40645ae19d0240]
stable/6.1: [c67698325c68f8768db858f5c87c34823421746d]
stable/6.6: [bc845e2e42cae95172c04bf29807c480f51a2a83]

CVE-2023-52645: pmdomain: mediatek: fix race conditions with genpd

Announce: https://lore.kernel.org/linux-cve-announce/2024041733-CVE-2023-52645-68dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 59b644b ("soc: mediatek: Add MediaTek SCPSYS
power domains") in v5.11-rc1.
Fixed in v6.8-rc4.

Fixed status
mainline: [c41336f4d69057cbf88fed47951379b384540df5]
stable/5.15: [475426ad1ae0bfdfd8f160ed9750903799392438]
stable/6.1: [339ddc983bc1622341d95f244c361cda3da3a4ff]
stable/6.6: [f83b9abee9faa4868a6fac4669b86f4c215dae25]

CVE-2024-26818: tools/rtla: Fix clang warning about mount_point var size

Announce: https://lore.kernel.org/linux-cve-announce/2024041701-CVE-2024-26818-d65b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a957cbc ("rtla: Add -C cgroup support") in v6.5-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [30369084ac6e27479a347899e74f523e6ca29b89]
stable/6.6: [8a585914c266dc044f53b5c83c170f79b45fcf9a]

CVE-2024-26819: dm: limit the number of targets and parameter size area

Announce: https://lore.kernel.org/linux-cve-announce/2024041701-CVE-2024-26819-1731@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
It seems as if all stable kernels are affected.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]

CVE-2024-26820: hv_netvsc: Register VF in netvsc_probe if
NET_DEVICE_REGISTER missed

Announce: https://lore.kernel.org/linux-cve-announce/2024041701-CVE-2024-26820-fc5a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8552085 ("hv_netvsc: Fix race of
register_netdevice_notifier and VF register") in v6.7-rc3.
This commit was backported to 4.19, 5.10, 5.15, 5.4, 6.1, and 6.6.
Linux 4.4 is not affected.
Fixed in v6.8-rc4.

Fixed status
mainline: [9cae43da9867412f8bd09aee5c8a8dc5e8dc3dc2]
stable/4.19: [bcb7164258d0a9a8aa2e73ddccc2d78f67d2519d]
stable/5.10: [5b10a88f64c0315cfdef45de0aaaa4eef57de0b7]
stable/5.15: [b6d46f306b3964d05055ddaa96b58cd8bd3a472c]
stable/5.4: [c7441c77c91e47f653104be8353b44a3366a5366]
stable/6.1: [309ef7de5d840e17607e7d65cbf297c0564433ef]
stable/6.6: [a71302c8638939c45e4ba5a99ea438185fd3f418]

CVE-2024-26821: fs: relax mount_setattr() permission checks

Announce: https://lore.kernel.org/linux-cve-announce/2024041702-CVE-2024-26821-de6b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Affected function was introduced by commit 2a18672 ("fs: add
mount_setattr()") in v5.12-rc1-dontuse.
So, 4.4, 4.19, 5.4, and 5.10 are not affected.

Fixed status
mainline: [46f5ab762d048dad224436978315cbc2fa79c630]
stable/6.1: [95de4ad173ca0e61034f3145d66917970961c210]
stable/6.6: [31f71f2d7a081fc6c6bdf06865beedf6db5b0ca4]

CVE-2024-26822: smb: client: set correct id, uid and cruid for
multiuser automounts

Announce: https://lore.kernel.org/linux-cve-announce/2024041702-CVE-2024-26822-04b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9fd29a5 ("cifs: use fs_context for automounts")
in v6.2-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [4508ec17357094e2075f334948393ddedbb75157]
stable/6.6: [c2aa2718cda2d56b4a551cb40043e9abc9684626]

CVE-2024-26823: irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

Announce: https://lore.kernel.org/linux-cve-announce/2024041702-CVE-2024-26823-0e52@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9585a49 ("irqchip/gic-v3-its: Split allocation
from initialisation of its_node") in v6.6-rc6.
This commit was backported to 6.1 and 5.15.
Fixed in v6.8-rc5.

Fixed status
mainline: [8b02da04ad978827e5ccd675acf170198f747a7a]
stable/6.6: [91a80fff3eeed928b6fba21271f6a9719b22a5d8]

CVE-2024-26824: crypto: algif_hash - Remove bogus SGL free on
zero-length error path

Announce: https://lore.kernel.org/linux-cve-announce/2024041702-CVE-2024-26824-98e1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b6d972f ("crypto: af_alg/hash: Fix recvmsg()
after sendmsg(MSG_MORE)") in v6.5-rc1.
Fixed in v6.8-rc4.

Fixed status
mainline: [24c890dd712f6345e382256cae8c97abb0406b70]
stable/6.6: [9c82920359b7c1eddaf72069bcfe0ffddf088cd0]

CVE-2024-26825: nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024041702-CVE-2024-26825-408e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v6.8-rc3.

Fixed status
cip/4.4: [8cfb41cc7ae740f0ab1721db1298c2bb1a0f9b56]
cip/4.4-rt: [8cfb41cc7ae740f0ab1721db1298c2bb1a0f9b56]
cip/4.4-st: [8cfb41cc7ae740f0ab1721db1298c2bb1a0f9b56]
mainline: [bfb007aebe6bff451f7f3a4be19f4f286d0d5d9c]
stable/4.19: [7e9a8498658b398bf11b8e388005fa54e40aed81]
stable/5.10: [2f6d16f0520d6505241629ee2f5c131b547d5f9d]
stable/5.15: [471c9ede8061357b43a116fa692e70d91941ac23]
stable/5.4: [71349abe3aba7fedcab5b3fcd7aa82371fb5ccbf]
stable/6.1: [5c0c5ffaed73cbae6c317374dc32ba6cacc60895]
stable/6.6: [16d3f507b0fa70453dc54550df093d6e9ac630c1]

CVE-2024-26826: mptcp: fix data re-injection from stale subflow

Announce: https://lore.kernel.org/linux-cve-announce/2024041703-CVE-2024-26826-b984@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1e1d9d6 ("mptcp: handle pending data on closed
subflow") in v5.15-rc1.
Fixed in v6.8-rc3.

Fixed status
mainline: [b6c620dc43ccb4e802894e54b651cf81495e9598]
stable/5.15: [6f95120f898b40d13fd441225ef511307853c9c2]
stable/6.1: [6673d9f1c2cd984390550dbdf7d5ae07b20abbf8]
stable/6.6: [b609c783c535493aa3fca22c7e40a120370b1ca5]

CVE-2024-26827: i2c: qcom-geni: Correct I2C TRE sequence

Announce: https://lore.kernel.org/linux-cve-announce/2024041703-CVE-2024-26827-67c1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d870355 ("i2c: qcom-geni: Add support for GPI
DMA") in v5.18-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [83ef106fa732aea8558253641cd98e8a895604d7]
stable/6.1: [083870b029c06da6a9a49340dd78637eec35a1d4]
stable/6.6: [0589dff4fbf4a7b88a909a34ecfa7b5d3daf51f5]

CVE-2024-26828: cifs: fix underflow in parse_server_interfaces()

Announce: https://lore.kernel.org/linux-cve-announce/2024041703-CVE-2024-26828-b2be@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fe856be ("CIFS: parse and store info on iface
queries") in v4.18-rc2.
Fixed in v6.8-rc5.

Fixed status
mainline: [cffe487026be13eaf37ea28b783d9638ab147204]
stable/6.1: [7190353835b4a219abb70f90b06cdcae97f11512]
stable/6.6: [f7ff1c89fb6e9610d2b01c1821727729e6609308]

CVE-2024-26829: media: ir_toy: fix a memleak in irtoy_tx

Announce: https://lore.kernel.org/linux-cve-announce/2024041716-CVE-2024-26829-e879@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4114978 ("media: ir_toy: prevent device from
hanging during transmit") in v5.16-rc1.
This commit was backported to 5.15.
Fixed in v6.8-rc5.

Fixed status
mainline: [dc9ceb90c4b42c6e5c6757df1d6257110433788e]
stable/5.10: [486a4176bc783df798bce2903824801af8d2c3ae]
stable/5.15: [207557e393a135c1b6fe1df7cc0741d2c1789fff]
stable/6.1: [be76ad74a43f90f340f9f479e6b04f02125f6aef]
stable/6.6: [7219a692ffc00089015ada33b85b334d1a4b6e8e]

CVE-2024-26830: i40e: Do not allow untrusted VF to remove
administratively set MAC

Announce: https://lore.kernel.org/linux-cve-announce/2024041703-CVE-2024-26830-5bc0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 700bbf6 ("i40e: allow VF to remove any MAC
filter") in v3.14-rc1.
Introduced by commit ceb2947 ("i40e: Add support for VF to specify its
primary MAC address") in v6.4-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [73d9629e1c8c1982f13688c4d1019c3994647ccc]
stable/6.1: [1c981792e4ccbc134b468797acdd7781959e6893]
stable/6.6: [be147926140ac48022c9605d7ab0a67387e4b404]

CVE-2024-26831: net/handshake: Fix handshake_req_destroy_test1

Announce: https://lore.kernel.org/linux-cve-announce/2024041704-CVE-2024-26831-2e6e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4a0f07d ("net/handshake: Fix memory leak in
__sock_create() and sock_alloc_file()") in v6.6-rc3.
Fixed in v6.8-rc5.

Fixed status
mainline: [4e1d71cabb19ec2586827adfc60d68689c68c194]
stable/6.6: [d74226e03df1bf19848f18344401f254345af912]

CVE-2024-26832: mm: zswap: fix missing folio cleanup in writeback race path

Announce: https://lore.kernel.org/linux-cve-announce/2024041714-CVE-2024-26832-77ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 04fc781 ("mm: fix zswap writeback race
condition") in v6.4-rc3.
This commit was backported to 6.1.
Fixed in v6.8-rc6.

Fixed status
mainline: [e3b63e966cac0bf78aaa1efede1827a252815a1d]
stable/6.1: [14f1992430ef9e647b02aa8ca12c5bcb9a1dffea]
stable/6.6: [6156277d1b26cb3fdb6fcbf0686ab78268571644]

CVE-2024-26833: drm/amd/display: Fix memory leak in dm_sw_fini()

Announce: https://lore.kernel.org/linux-cve-announce/2024041714-CVE-2024-26833-b435@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 743b978 ("drm/amd/display: Hook up the DMUB
service in DM") in v5.6-rc1.
Fixed in v6.8-rc6.

Fixed status
mainline: [bae67893578d608e35691dcdfa90c4957debf1d3]
stable/5.10: [b49b022f7dfce85eb77d0d987008fde5c01d7857]
stable/5.15: [33f649f1b1cea39ed360e6c12bba4fac83118e6e]
stable/6.1: [58168005337eabef345a872be3f87d0215ff3b30]
stable/6.6: [10c6b90e975358c17856a578419dc449887899c2]

CVE-2024-26834: netfilter: nft_flow_offload: release dst in case
direct xmit path is used

Announce: https://lore.kernel.org/linux-cve-announce/2024041714-CVE-2024-26834-a73b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fa502c8 ("netfilter: flowtable: simplify route
logic") in v6.5-rc1.
This commit was backported to 5.15 and 6.1.
Fixed in v6.6.19.

Fixed status
mainline: [8762785f459be1cfe6fcf7285c123aad6a3703f0]
stable/5.15: [13b57b5cd591d5b22f9bbf047b2922967de411f3]
stable/6.1: [a6cafdb49a7bbf4a88367db209703eee6941e023]
stable/6.6: [9256ab9232e35a16af9c30fa4e522e6d1bd3605a]

CVE-2024-26835: netfilter: nf_tables: set dormant flag on hook register failure

Announce: https://lore.kernel.org/linux-cve-announce/2024041714-CVE-2024-26835-083d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 179d9ba ("netfilter: nf_tables: fix table flag
updates") in v5.13-rc5.
This commit was backported to 5.4 and 5.10.
Fixed in v6.8-rc6.

Fixed status
mainline: [bccebf64701735533c8db37773eeacc6566cc8ec]
stable/5.10: [31ea574aeca1aa488e18716459bde057217637af]
stable/5.15: [664264a5c55bf97a9c571c557d477b75416199be]
stable/5.4: [ae4360cbd385f0d7a8a86d5723e50448cc6318f3]
stable/6.1: [0c9302a6da262e6ab6a6c1d30f04a6130ed97376]
stable/6.6: [f2135bbf14949687e96cabb13d8a91ae3deb9069]

CVE-2024-26836: platform/x86: think-lmi: Fix password opcode ordering
for workstations

Announce: https://lore.kernel.org/linux-cve-announce/2024041714-CVE-2024-26836-19c3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 640a5fa ("platform/x86: think-lmi: Opcode
support") in v5.17-rc1.
Fixed in v6.8-rc6.

Fixed status
mainline: [6f7d0f5fd8e440c3446560100ac4ff9a55eec340]

CVE-2024-26837: net: bridge: switchdev: Skip MDB replays of deferred
events on offload

Announce: https://lore.kernel.org/linux-cve-announce/2024041715-CVE-2024-26837-753c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4f2673b ("net: bridge: add helper to replay port
and host-joined mdb entries") in v5.13-rc1.
Fixed in v6.8-rc6.

Fixed status
mainline: [dc489f86257cab5056e747344f17a164f63bff4b]
stable/6.1: [2d5b4b3376fa146a23917b8577064906d643925f]
stable/6.6: [603be95437e7fd85ba694e75918067fb9e7754db]

CVE-2024-26838: RDMA/irdma: Fix KASAN issue with tasklet

Announce: https://lore.kernel.org/linux-cve-announce/2024041715-CVE-2024-26838-2fdb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 44d9e52 ("RDMA/irdma: Implement device
initialization definitions") in v5.14-rc1.
Fixed in v6.8-rc6.

Fixed status
mainline: [bd97cea7b18a0a553773af806dfbfac27a7c4acb]
stable/5.15: [635d79aa477f9912e602feb5498bdd51fb9cb824]
stable/6.1: [b2e4a5266e3d133b4c7f0e43bf40d13ce14fd1aa]
stable/6.6: [c6f1ca235f68b22b3e691b2ea87ac285e5946848]

CVE-2024-26839: IB/hfi1: Fix a memleak in init_credit_return

Announce: https://lore.kernel.org/linux-cve-announce/2024041715-CVE-2024-26839-1196@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7724105 ("IB/hfi1: add driver files") in v4.3-rc1.
Fixed in v6.8-rc6.

Fixed status
cip/4.4: [9528ec86a46ddbbfe876277bd169decc45686446]
cip/4.4-st: [9528ec86a46ddbbfe876277bd169decc45686446]
mainline: [809aa64ebff51eb170ee31a95f83b2d21efa32e2]
stable/4.19: [2e4f9f20b32658ef3724aa46f7aef4908d2609e3]
stable/5.10: [3fa240bb6b2dbb3e7a3ee1440a4889cbb6207eb7]
stable/5.15: [52de5805c147137205662af89ed7e083d656ae25]
stable/5.4: [cecfb90cf71d91e9efebd68b9e9b84661b277cc8]
stable/6.1: [f0d857ce31a6bc7a82afcdbadb8f7417d482604b]
stable/6.6: [b41d0ade0398007fb746213f09903d52a920e896]

CVE-2024-26840: cachefiles: fix memory leak in cachefiles_add_cache()

Announce: https://lore.kernel.org/linux-cve-announce/2024041715-CVE-2024-26840-057d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ae326a ("CacheFiles: A cache that backs onto a
mounted filesystem") in v2.6.30-rc1.
Fixed in v6.8-rc6.

Fixed status
cip/4.4: [aef24c9d27c5c28ca43e240a338698183b8e0ee0]
cip/4.4-st: [aef24c9d27c5c28ca43e240a338698183b8e0ee0]
mainline: [e21a2f17566cbd64926fb8f16323972f7a064444]
stable/4.19: [cb5466783793e66272624cf71925ae1d1ba32083]
stable/5.10: [43eccc5823732ba6daab2511ed32dfc545a666d8]
stable/5.15: [94965be37add0983672e48ecb33cdbda92b62579]
stable/5.4: [037d5a949b0455540ef9aab34c10ddf54b65d285]
stable/6.1: [8b218e2f0a27a9f09428b1847b4580640b9d1e58]
stable/6.6: [38e921616320d159336b0ffadb09e9fb4945c7c3]

CVE-2024-26841: LoongArch: Update cpu_sibling_map when disabling nonboot CPUs

Announce: https://lore.kernel.org/linux-cve-announce/2024041716-CVE-2024-26841-6433@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.

Fixed status
mainline: [752cd08da320a667a833803a8fd6bb266114cce5]
stable/6.6: [b1ec3d6b86fdd057559a5908e6668279bf770e0e]

CVE-2024-26842: scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()

Announce: https://lore.kernel.org/linux-cve-announce/2024041716-CVE-2024-26842-d556@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
The shift operation was introduced by commit 7aa12d2f ("scsi: ufs:
core: Update the ufshcd_clear_cmds() functionality") in 6.5-rc1.

Fixed status
mainline: [b513d30d59bb383a6a5d6b533afcab2cee99a8f8]
stable/6.6: [7ac9e18f5d66087cd22751c5c5bf0090eb0038fe]

CVE-2024-26843: efi: runtime: Fix potential overflow of soft-reserved
region size

Announce: https://lore.kernel.org/linux-cve-announce/2024041716-CVE-2024-26843-51a0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
Vulnerability in the drivers/firmware/efi/arm-runtime.c was introduced
by commit 16993c0 ("arm/efi: EFI soft reservation to memblock") in
5.5-rc1.
Vulnerability in the  drivers/firmware/efi/riscv-runtime.c  was
introduced by commit de1034b3 ("efi: runtime: Fix potential overflow
of soft-reserved region size") in 6.8-rc4.

Fixed status
mainline: [de1034b38a346ef6be25fe8792f5d1e0684d5ff4]
stable/5.10: [4fff3d735baea104017f2e3c245e27cdc79f2426]
stable/5.15: [4aa36b62c3eaa869860bf78b1146e9f2b5f782a9]
stable/6.1: [700c3f642c32721f246e09d3a9511acf40ae42be]
stable/6.6: [cf3d6813601fe496de7f023435e31bfffa74ae70]

CVE-2024-26844: block: Fix WARNING in _copy_from_iter

Announce: https://lore.kernel.org/linux-cve-announce/2024041716-CVE-2024-26844-c534@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.
It looks as if all stable kernels are affected.
For instance, 4.4.302 does the following check. That may need to split
conditional check when map_data->from_user is set.

    if (((iter->type & WRITE) && (!map_data || !map_data->null_mapped)) ||
        (map_data && map_data->from_user)) {
        ret = bio_copy_from_iter(bio, *iter);

Fixed status
mainline: [13f3956eb5681a4045a8dfdef48df5dc4d9f58a6]
stable/6.1: [8fc80874103a5c20aebdc2401361aa01c817f75b]
stable/6.6: [0f1bae071de9967602807472921829a54b2e5956]

CVE-2024-26845: scsi: target: core: Add TMF to tmr_list handling

Announce: https://lore.kernel.org/linux-cve-announce/2024041717-CVE-2024-26845-90d2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.

Fixed status
cip/4.4: [81c6ef786db65985883e0066b687247386fc8d36]
cip/4.4-rt: [81c6ef786db65985883e0066b687247386fc8d36]
cip/4.4-st: [81c6ef786db65985883e0066b687247386fc8d36]
mainline: [83ab68168a3d990d5ff39ab030ad5754cbbccb25]
stable/4.19: [425a571a7e6fc389954cf2564e1edbba3740e171]
stable/5.10: [168ed59170de1fd7274080fe102216162d6826cf]
stable/5.15: [a9849b67b4402a12eb35eadc9306c1ef9847d53d]
stable/5.4: [11f3fe5001ed05721e641f0ecaa7a73b7deb245d]
stable/6.1: [e717bd412001495f17400bfc09f606f1b594ef5a]
stable/6.6: [36bc5040c863b44af06094b22f1e50059227b9cb]

CVE-2024-26846: nvme-fc: do not wait in vain when unloading module

Announce: https://lore.kernel.org/linux-cve-announce/2024041717-CVE-2024-26846-9593@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
The drivers/nvme/host/fc.c was introduced by commit e399441
("nvme-fabrics: Add host support for FC transport") in 4.10-rc1.
Then added wait_for_completion and such by commit 4c73cbd ("nvme-fc:
fix module unloads while lports still pending") in 5.3-rc1.

Fixed status
mainline: [70fbfc47a392b98e5f8dba70c6efc6839205c982]
stable/5.10: [4f2c95015ec2a1899161be6c0bdaecedd5a7bfb2]
stable/5.15: [0bf567d6d9ffe09e059bbdfb4d07143cef42c75c]
stable/6.1: [085195aa90a924c79e35569bcdad860d764a8e17]
stable/6.6: [baa6b7eb8c66486bd64608adc63fe03b30d3c0b9]

CVE-2024-26847: powerpc/rtas: use correct function name for resetting TCE tables

Announce: https://lore.kernel.org/linux-cve-announce/2024041753-CVE-2024-26847-953f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8252b88 ("powerpc/rtas: improve function
information lookups") in v6.3-rc1.
Fixed in v6.8-rc7.

Fixed status
mainline: [fad87dbd48156ab940538f052f1820f4b6ed2819]
stable/6.6: [6b6282d56b14879124416a23837af9bd52ae2dfb]

CVE-2024-26848: afs: Fix endless loop in directory parsing

Announce: https://lore.kernel.org/linux-cve-announce/2024041753-CVE-2024-26848-0413@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 57e9d49c ("afs: Hide silly-rename files from
userspace") in 6.8-rc2.
This commit was backported to 5.10, 5.15, 5.4, 6.1, and 6.6.
Fixed in 6.8-rc7.

Fixed status
mainline: [5f7a07646655fb4108da527565dcdc80124b14c4]
stable/5.10: [b94f434fe977689da4291dc21717790b9bd1c064]
stable/5.15: [a6ffae61ad9ebf2fdcb943135b2f30c85f49cd27]
stable/5.4: [854ebf45a4ddd4cadeffb6644e88d19020634e1a]
stable/6.1: [76426abf9b980b46983f97de8e5b25047b4c9863]
stable/6.6: [106e14ca55a0acb3236ee98813a1d243f8aa2d05]

CVE-2024-26849: netlink: add nla be16/32 types to minlen array

Announce: https://lore.kernel.org/linux-cve-announce/2024041754-CVE-2024-26849-9e3c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ecaf75f ("netlink: introduce bigendian integer
types") in v6.1-rc4.
Fixed in v6.8-rc7.

Fixed status
mainline: [9a0d18853c280f6a0ee99f91619f2442a17a323a]
stable/6.1: [0ac219c4c3ab253f3981f346903458d20bacab32]
stable/6.6: [a2ab028151841cd833cb53eb99427e0cc990112d]

CVE-2024-26850: mm/debug_vm_pgtable: fix BUG_ON with pud advanced test

Announce: https://lore.kernel.org/linux-cve-announce/2024041754-CVE-2024-26850-f608@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 27af67f ("powerpc/book3s64/mm: enable transparent
pud hugepage") in v6.6-rc1.
Fixed in v6.8-rc7.

Fixed status
mainline: [720da1e593b85a550593b415bf1d79a053133451]
stable/6.6: [d2a9510c0e39d06f5544075c13040407bdbf2803]

CVE-2024-26851: netfilter: nf_conntrack_h323: Add protection for bmp
length out of range

Announce: https://lore.kernel.org/linux-cve-announce/2024041723-CVE-2024-26851-4652@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e35941 ("[NETFILTER]: Add H.323 conntrack/NAT
helper") in v2.6.20.16.
Fixed in v6.8.

Fixed status
cip/4.4: [b135d56fd7ad317bb15239c58c28bcf2590fd4d2]
cip/4.4-st: [b135d56fd7ad317bb15239c58c28bcf2590fd4d2]
mainline: [767146637efc528b5e3d31297df115e85a2fd362]
stable/4.19: [98db42191329c679f4ca52bec0b319689e1ad8cb]
stable/5.10: [ccd1108b16ab572d9bf635586b0925635dbd6bbc]
stable/5.15: [b3c0f553820516ad4b62a9390ecd28d6f73a7b13]
stable/5.4: [4bafcc43baf7bcf93566394dbd15726b5b456b7a]
stable/6.1: [39001e3c42000e7c2038717af0d33c32319ad591]
stable/6.6: [014a807f1cc9c9d5173c1cd935835553b00d211c]

CVE-2024-26852: net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Announce: https://lore.kernel.org/linux-cve-announce/2024041723-CVE-2024-26852-0057@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3b1137f ("net: ipv6: Change notifications for
multipath add to RTA_MULTIPATH") in v4.11-rc1.
Fixed in v6.8.

Fixed status
mainline: [685f7d531264599b3f167f1e94bbd22f120e5fab]
stable/4.19: [31ea5bcc7d4cd1423de6be327a2c034725704136]
stable/5.10: [79ce2e54cc0ae366f45516c00bf1b19aa43e9abe]
stable/5.15: [cae3303257950d03ffec2df4a45e836f10d26c24]
stable/5.4: [664f9c647260cc9d68b4e31d9899530d89dd045e]
stable/6.1: [394334fe2ae3b9f1e2332b873857e84cb28aac18]
stable/6.6: [ed883060c38721ed828061f6c0c30e5147326c9a]

CVE-2024-26853: igc: avoid returning frame twice in XDP_REDIRECT

Announce: https://lore.kernel.org/linux-cve-announce/2024041723-CVE-2024-26853-b549@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4ff3203 ("igc: Add support for XDP_REDIRECT
action") in v5.13-rc1.
Fixed in v6.8.

Fixed status
mainline: [ef27f655b438bed4c83680e4f01e1cde2739854b]
stable/6.1: [63a3c1f3c9ecc654d851e7906d05334cd0c236e2]
stable/6.6: [8df393af9e7e8dfd62e9c41dbaa4d2ff53bf794a]

CVE-2024-26854: ice: fix uninitialized dplls mutex usage

Announce: https://lore.kernel.org/linux-cve-announce/2024041724-CVE-2024-26854-1a41@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d7999f5 ("ice: implement dpll interface to
control cgu") in v6.7-rc1.
Fixed in v6.8.

Fixed status
mainline: [9224fc86f1776193650a33a275cac628952f80a9]

CVE-2024-26855: net: ice: Fix potential NULL pointer dereference in
ice_bridge_setlink()

Announce: https://lore.kernel.org/linux-cve-announce/2024041724-CVE-2024-26855-ac0d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b1edc14 ("ice: Implement ice_bridge_getlink and
ice_bridge_setlink") in v4.20-rc1.
Fixed in v6.8.

Fixed status
mainline: [06e456a05d669ca30b224b8ed962421770c1496c]
stable/5.10: [37fe99016b12d32100ce670216816dba6c48b309]
stable/5.15: [8d95465d9a424200485792858c5b3be54658ce19]
stable/5.4: [d9fefc51133107e59d192d773be86c1150cfeebb]
stable/6.1: [afdd29726a6de4ba27cd15590661424c888dc596]
stable/6.6: [1a770927dc1d642b22417c3e668c871689fc58b3]

CVE-2024-26856: net: sparx5: Fix use after free inside sparx5_del_mact_entry

Announce: https://lore.kernel.org/linux-cve-announce/2024041724-CVE-2024-26856-3dbf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b37a1ba ("net: sparx5: add mactable support") in v5.14-rc1.
Fixed in v6.8.

Fixed status
mainline: [89d72d4125e94aa3c2140fedd97ce07ba9e37674]
stable/5.15: [e46274df1100fb0c06704195bfff5bfbd418bf64]
stable/6.1: [0de693d68b0a18d5e256556c7c62d92cca35ad52]
stable/6.6: [e83bebb718fd1f42549358730e1206164e0861d6]

CVE-2024-26857: geneve: make sure to pull inner header in geneve_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024041724-CVE-2024-26857-75ac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2d07dc7 ("geneve: add initial netdev driver for
GENEVE tunnels") in v4.2-rc1.
Fixed in v6.8.

Fixed status
mainline: [1ca1ba465e55b9460e4e75dec9fff31e708fec74]
stable/4.19: [e431c3227864b5646601c97f5f898d99472f2914]
stable/5.10: [c7137900691f5692fe3de54566ea7b30bb35d66c]
stable/5.15: [e77e0b0f2a11735c64b105edaee54d6344faca8a]
stable/5.4: [59d2a4076983303f324557a114cfd5c32e1f6b29]
stable/6.1: [c0b22568a9d8384fd000cc49acb8f74bde40d1b5]
stable/6.6: [0ece581d2a66e8e488c0d3b3e7b5760dbbfdbdd5]

CVE-2024-26858: net/mlx5e: Use a memory barrier to enforce PTP WQ xmit
submission tracking occurs after populating the metadata_map

Announce: https://lore.kernel.org/linux-cve-announce/2024041725-CVE-2024-26858-34fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7e3f3ba ("net/mlx5e: Track xmit submission to PTP
WQ after populating metadata map") in v6.7-rc2.
Fixed in v6.8.

Fixed status
mainline: [b7cf07586c40f926063d4d09f7de28ff82f62b2a]
stable/6.6: [d1f71615dbb305f14f3b756cce015d70d8667549]

CVE-2024-26859: net/bnx2x: Prevent access to a freed page in page_pool

Announce: https://lore.kernel.org/linux-cve-announce/2024041735-CVE-2024-26859-a906@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4cace67 ("bnx2x: Alloc 4k fragment for each rx
ring buffer element") in v4.2-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [34e08399bc377c023a40ab0811d61c86bda69871]
cip/4.4-st: [34e08399bc377c023a40ab0811d61c86bda69871]
mainline: [d27e2da94a42655861ca4baea30c8cd65546f25d]
stable/4.19: [7bcc090c81116c66936a7415f2c6b1483a4bcfd9]
stable/5.10: [8eebff95ce9558be66a36aa7cfb43223f3ab4699]
stable/5.15: [8ffcd3ccdbda0c918c4a0f922ef1c17010f1b598]
stable/5.4: [4f37d3a7e004bbf560c21441ca9c022168017ec4]
stable/6.1: [cf7d8cba639ae792a42c2a137b495eac262ac36c]
stable/6.6: [3a9f78b297e08ca8e88ae3ecff1f6fe2766dc5eb]

CVE-2024-26860: dm-integrity: fix a memory leak when rechecking the data

Announce: https://lore.kernel.org/linux-cve-announce/2024041735-CVE-2024-26860-ebf5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c88f5e5 ("dm-integrity: recheck the integrity tag
after a failure") in v6.8-rc6.
This commit was backported to 6.1 and 6.6.
Fixed in v6.9-rc1.

Fixed status
mainline: [55e565c42dce81a4e49c13262d5bc4eb4c2e588a]
stable/6.1: [20e21c3c0195d915f33bc7321ee6b362177bf5bf]
stable/6.6: [338580a7fb9b0930bb38098007e89cc0fc496bf7]

CVE-2024-26861: wireguard: receive: annotate data-race around
receiving_counter.counter

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26861-3a78@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a9e90d9 ("wireguard: noise: separate receive
counter from send counter") in v5.7-rc7.
Fixed in v6.9-rc1.

Fixed status
mainline: [bba045dc4d996d03dce6fe45726e78a1a1f6d4c3]
stable/5.10: [f87884e0dffd61b47e58bc6e1e2f6843c212b0cc]
stable/5.15: [d691be84ab898cf136a35176eaf2f8fc116563f0]
stable/6.1: [45a83b220c83e3c326513269afbf69ae6fc65cce]
stable/6.6: [78739d72f16b2d7d549f713f1dfebd678d32484b]

CVE-2024-26862: packet: annotate data-races around ignore_outgoing

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26862-2605@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fa788d9 ("packet: add sockopt to ignore outgoing
packets") in v4.20-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [6ebfad33161afacb3e1e59ed1c2feefef70f9f97]
stable/5.10: [68e84120319d4fc298fcdb14cf0bea6a0f64ffbd]
stable/5.15: [d35b62c224e70797f8a1c37fe9bc4b3e294b7560]
stable/5.4: [84c510411e321caff3c07e6cd0f917f06633cfc0]
stable/6.1: [ef7eed7e11d23337310ecc2c014ecaeea52719c5]
stable/6.6: [2c02c5059c78a52d170bdee4a369b470de6deb37]

CVE-2024-26863: hsr: Fix uninit-value access in hsr_get_node()

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26863-b742@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f266a68 ("net/hsr: Better frame dispatch") in v3.17-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [ddbec99f58571301679addbc022256970ca3eac6]
stable/4.19: [e3b2bfb8ff1810a537b2aa55ba906a6743ed120c]
stable/5.10: [7fb2d4d6bb1c85f7a23aace0ed6c86a95dea792a]
stable/5.15: [a809bbfd0e503351d3051317288a70a4569a4949]
stable/5.4: [889ed056eae7fda85b769a9ab33c093379c45428]
stable/6.1: [1ed222ca7396938eb1ab2d034f1ba0d8b00a7122]
stable/6.6: [39cc316fb3bc5e7c9dc5eed314fe510d119c6862]

CVE-2024-26864: tcp: Fix refcnt handling in __inet_hash_connect().

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26864-397c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 66b60b0 ("dccp/tcp: Unhash sk from ehash for tb2
alloc failure after check_estalblished().") in v6.8-rc6.
This commit was backported to 6.1 and 6.6.
Fixed in v6.9-rc1.

Fixed status
mainline: [04d9d1fc428ac9f581d55118d67e0cb546701feb]
stable/6.1: [86d9b040421bbd26425f5a3edc226f57ecdecbfe]
stable/6.6: [856baaa100cd288d3685eedae9a129c996e7e755]

CVE-2024-26865: rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26865-56dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 467fa15 ("RDS-TCP: Support multiple RDS-TCP
listen endpoints, one per netns.") in v4.3-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [2a750d6a5b365265dbda33330a6188547ddb5c24]
stable/6.1: [9905a157048f441f1412e7bd13372f4a971d75c6]
stable/6.6: [f901ee07853ce97e9f1104c7c898fbbe447f0279]

CVE-2024-26866: spi: lpspi: Avoid potential use-after-free in probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26866-1e98@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5314987 ("spi: imx: add lpspi bus driver") in v4.10-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [2ae0ab0143fcc06190713ed81a6486ed0ad3c861]
stable/6.6: [da83ed350e4604b976e94239b08d8e2e7eaee7ea]

CVE-2024-26867: comedi: comedi_8255: Correct error in subdevice initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26867-45ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c57b1c ("comedi: comedi_8255: Rework subdevice
initialization functions") in v6.7-rc1.
Fixed in v6.8.

Fixed status
mainline: [cfa9ba1ae0bef0681833a22d326174fe633caab5]
stable/6.8: [cfa9ba1ae0bef0681833a22d326174fe633caab5]

CVE-2024-26868: nfs: fix panic when nfs4_ff_layout_prepare_ds() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26868-35ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b739a5b ("NFSv4/flexfiles: Cancel I/O if the
layout is recalled or revoked") in v6.1-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [719fcafe07c12646691bd62d7f8d94d657fa0766]
stable/6.1: [31db25e3141b20e2a76a9f219eeca52e3cab126c]
stable/6.6: [7ca651b4ec4a049f5a46a0e5ff921b86b91c47c5]

CVE-2024-26869: f2fs: fix to truncate meta inode pages forcely

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26869-c9e2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6aa58d8 ("f2fs: readahead encrypted block during
GC") in v4.19-rc1.
Introduced by commit e3b49ea ("f2fs: invalidate META_MAPPING before
IPU/DIO write") in v5.16-rc1.
Commit e3b49ea was backported to 5.15.
Fixed in v6.9-rc1.

Fixed status
mainline: [9f0c4a46be1fe9b97dbe66d49204c1371e3ece65]
stable/6.6: [c92f2927df860a60ba815d3ee610a944b92a8694]

CVE-2024-26870: NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26870-7aea@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 012a211 ("NFSv4.2: hook in the user extended
attribute handlers") in v5.9-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [251a658bbfceafb4d58c76b77682c8bf7bcfad65]
stable/5.10: [4403438eaca6e91f02d272211c4d6b045092396b]
stable/5.15: [9d52865ff28245fc2134da9f99baff603a24407a]
stable/6.1: [06e828b3f1b206de08ef520fc46a40b22e1869cb]
stable/6.6: [79cdcc765969d23f4e3d6ea115660c3333498768]

CVE-2024-26871: f2fs: fix NULL pointer dereference in f2fs_submit_page_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26871-670f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e067dc3 ("f2fs: maintain six open zones for zoned
devices") in v6.5-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [c2034ef6192a65a986a45c2aa2ed05824fdc0e9f]
stable/6.6: [8e2ea8b04cb8d976110c4568509e67d6a39b2889]

CVE-2024-26872: RDMA/srpt: Do not register event handler until srpt
device is fully setup

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26872-2d38@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a42d985 ("ib_srpt: Initial SRP Target merge for
v3.3-rc1") in v3.3-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [c21a8870c98611e8f892511825c9607f1e2cd456]
stable/5.10: [bdd895e0190c464f54f84579e7535d80276f0fc5]
stable/5.15: [6413e78086caf7bf15639923740da0d91fdfd090]
stable/6.1: [e362d007294955a4fb929e1c8978154a64efdcb6]
stable/6.6: [85570b91e4820a0db9d9432098778cafafa7d217]
stable/6.8: [ec77fa12da41260c6bf9e060b89234b980c5130f]

CVE-2024-26873: scsi: hisi_sas: Fix a deadlock issue related to automatic dump

Announce: https://lore.kernel.org/linux-cve-announce/2024041739-CVE-2024-26873-e310@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ff07b5 ("scsi: hisi_sas: Directly call register
snapshot instead of using workqueue") in v6.7-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [3c4f53b2c341ec6428b98cb51a89a09b025d0953]
stable/6.8: [85c98073ffcfe9e46abfb9c66f3364467119d563]

CVE-2024-26874: drm/mediatek: Fix a null pointer crash in
mtk_drm_crtc_finish_page_flip

Announce: https://lore.kernel.org/linux-cve-announce/2024041739-CVE-2024-26874-79b0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 119f517 ("drm/mediatek: Add DRM Driver for
Mediatek SoC MT8173.") in v4.7-rc1.
This commit is not backported to 4.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [c958e86e9cc1b48cac004a6e245154dfba8e163b]
stable/4.19: [accdac6b71d5a2b84040c3d2234f53a60edc398e]
stable/5.10: [4688be96d20ffa49d2186523ee84f475f316fd49]
stable/5.15: [9beec711a17245b853d64488fd5b739031612340]
stable/5.4: [dfde84cc6c589f2a9f820f12426d97365670b731]
stable/6.1: [d2bd30c710475b2e29288827d2c91f9e6e2b91d7]
stable/6.6: [a3dd12b64ae8373a41a216a0b621df224210860a]
stable/6.8: [3fc88b246a2fc16014e374040fc15af1d3752535]

CVE-2024-26875: media: pvrusb2: fix uaf in pvr2_context_set_notify

Announce: https://lore.kernel.org/linux-cve-announce/2024041739-CVE-2024-26875-8394@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e5be15c ("V4L/DVB (7711): pvrusb2: Fix race on
module unload") in v2.6.26-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [4bfc7ec23b25eced1a985408267fec015d497972]
cip/4.4-st: [4bfc7ec23b25eced1a985408267fec015d497972]
mainline: [0a0b79ea55de8514e1750884e5fec77f9fdd01ee]
stable/4.19: [ed8000e1e8e9684ab6c30cf2b526c0cea039929c]
stable/5.10: [ab896d93fd6a2cd1afeb034c3cc9226cb499209f]
stable/5.15: [eb6e9dce979c08210ff7249e5e0eceb8991bfcd7]
stable/5.4: [d29ed08964cec8b9729bc55c7bb23f679d7a18fb]
stable/6.1: [3a1ec89708d2e57e2712f46241282961b1a7a475]
stable/6.6: [8e60b99f6b7ccb3badeb512f5eb613ad45904592]
stable/6.8: [eaa410e05bdf562c90b23cdf2d9327f9c4625e16]

CVE-2024-26876: drm/bridge: adv7511: fix crash on irq during probe

Announce: https://lore.kernel.org/linux-cve-announce/2024041739-CVE-2024-26876-3948@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3b1b975 ("drm: adv7511/33: add HDMI CEC support")
in v4.15-rc1.
This commit is not backported to 4.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [aeedaee5ef5468caf59e2bb1265c2116e0c9a924]
stable/6.8: [28a94271bd50e4cf498df0381f776f8ea40a289e]

CVE-2024-26877: crypto: xilinx - call finalize with bh disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024041739-CVE-2024-26877-72a3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4d96f7d ("crypto: xilinx - Add Xilinx AES
driver") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [a853450bf4c752e664abab0b2fad395b7ad7701c]
stable/5.10: [8a01335aedc50a66d04dd39203c89f4bc8042596]
stable/5.15: [03e6d4e948432a61b35783323b6ab2be071d2619]
stable/6.1: [a71f66bd5f7b9b35a8aaa49e29565eca66299399]
stable/6.6: [23bc89fdce71124cd2126fc919c7076e7cb489cf]
stable/6.8: [dbf291d8ffffb70f48286176a15c6c54f0bb0743]

CVE-2024-26878: quota: Fix potential NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024041740-CVE-2024-26878-5748@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
IT looks as if 4.4 is affected too.

Fixed status
mainline: [d0aa72604fbd80c8aabb46eda00535ed35570f1f]
stable/4.19: [8514899c1a4edf802f03c408db901063aa3f05a1]
stable/5.10: [61380537aa6dd32d8a723d98b8f1bd1b11d8fee0]
stable/5.15: [1ca72a3de915f87232c9a4cb9bebbd3af8ed3e25]
stable/5.4: [49669f8e7eb053f91d239df7b1bfb4500255a9d0]
stable/6.1: [7f9e833fc0f9b47be503af012eb5903086939754]
stable/6.6: [40a673b4b07efd6f74ff3ab60f38b26aa91ee5d5]
stable/6.8: [6afc9f4434fa8063aa768c2bf5bf98583aee0877]

CVE-2024-26879: clk: meson: Add missing clocks to axg_clk_regmaps

Announce: https://lore.kernel.org/linux-cve-announce/2024041740-CVE-2024-26879-e0d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 14ebb31 ("clk: meson: axg: add Video Clocks") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [ba535bce57e71463a86f8b33a0ea88c26e3a6418]
stable/5.15: [a03ed00787b0ce7a83eebabd0fa95ecc4a5cac84]
stable/6.1: [7ae1b0dc12ec407f12f80b49d22c6ad2308e2202]
stable/6.6: [0cbefc7b5bdad86b18a263d837450cdc9a56f8d7]
stable/6.8: [9f3e5df38b4528213449e55b80f0316864f2a1c8]

CVE-2024-26880: dm: call the resume method on internal suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024041740-CVE-2024-26880-25d6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ffcc393 ("dm: enhance internal suspend and resume
interface") in v3.19-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [5b751acdbca079301db6ac4f8f7cfe95a3a38d58]
cip/4.4-st: [5b751acdbca079301db6ac4f8f7cfe95a3a38d58]
mainline: [65e8fbde64520001abf1c8d0e573561b4746ef38]
stable/4.19: [69836d9329f0b4c58faaf3d886a7748ddb5bf718]
stable/5.10: [f89bd27709376d37ff883067193320c58a8c1d5a]
stable/5.15: [03ad5ad53e51abf3a4c7538c1bc67a5982b41dc5]
stable/5.4: [da7ece2197101b1469853e6b5e915be1e3896d52]
stable/6.1: [ad10289f68f45649816cc68eb93f45fd5ec48a15]
stable/6.6: [15a3fc5c8774c17589dabfe1d642d40685c985af]
stable/6.8: [360a7d1be8112654f1fb328ed3862be630bca3f4]

CVE-2024-26881: net: hns3: fix kernel crash when 1588 is received on
HIP08 devices

Announce: https://lore.kernel.org/linux-cve-announce/2024041740-CVE-2024-26881-ffd3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0bf5eb7 ("net: hns3: add support for PTP") in v5.14-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [0fbcf2366ba9888cf02eda23e35fde7f7fcc07c3]
stable/5.15: [23ec1cec24293f9799c725941677d4e167997265]
stable/6.1: [b3cf70472a600bcb2efe24906bc9bc6014d4c6f6]
stable/6.6: [f0b5225a7dfc1bf53c98215db8c2f0b4efd3f108]
stable/6.8: [11b998360d96f6c76f04a95f54b49f24d3c858e4]

CVE-2024-26882: net: ip_tunnel: make sure to pull inner header in
ip_tunnel_rcv()

Announce: https://lore.kernel.org/linux-cve-announce/2024041741-CVE-2024-26882-be35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c544193 ("GRE: Refactor GRE tunneling code.") in v3.10-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [b0ec2abf98267f14d032102551581c833b0659d3]
stable/5.10: [77fd5294ea09b21f6772ac954a121b87323cec80]
stable/5.15: [5c03387021cfa3336b97e0dcba38029917a8af2a]
stable/5.4: [ec6bb01e02cbd47781dd90775b631a1dc4bd9d2b]
stable/6.1: [60044ab84836359534bd7153b92e9c1584140e4a]
stable/6.6: [c4c857723b37c20651300b3de4ff25059848b4b0]
stable/6.8: [ca914f1cdee8a85799942c9b0ce5015bbd6844e1]

CVE-2024-26883: bpf: Fix stackmap overflow check on 32-bit arches

Announce: https://lore.kernel.org/linux-cve-announce/2024041741-CVE-2024-26883-1fc4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6183f4d ("bpf: Check for integer overflow when
using roundup_pow_of_two()") in v5.11.
This commit is backported to 4.19, 5.10, and 5.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [7a4b21250bf79eef26543d35bd390448646c536b]
stable/4.19: [d0e214acc59145ce25113f617311aa79dda39cb3]
stable/5.10: [15641007df0f0d35fa28742b25c2a7db9dcd6895]
stable/5.15: [ca1f06e72dec41ae4f76e7b1a8a97265447b46ae]
stable/5.4: [21e5fa4688e1a4d3db6b72216231b24232f75c1d]
stable/6.1: [f06899582ccee09bd85d0696290e3eaca9aa042d]
stable/6.6: [7070b274c7866a4c5036f8d54fcaf315c64ac33a]
stable/6.8: [0971126c8164abe2004b8536b49690a0d6005b0a]

CVE-2024-26884: bpf: Fix hashtab overflow check on 32-bit arches

Announce: https://lore.kernel.org/linux-cve-announce/2024041741-CVE-2024-26884-433b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit daaf427 ("bpf: fix arraymap NULL deref and
missing overflow and zero size checks") in v3.19-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [6787d916c2cf9850c97a0a3f73e08c43e7d973b1]
stable/4.19: [33ec04cadb77605b71d9298311919303d390c4d5]
stable/5.10: [64f00b4df0597590b199b62a37a165473bf658a6]
stable/5.15: [3b08cfc65f07b1132c1979d73f014ae6e04de55d]
stable/5.4: [92c81fbb3ed2e0dfc33a4183a67135e1ab566ace]
stable/6.1: [a83fdaeaea3677b83a53f72ace2d73a19bcd6d93]
stable/6.6: [8435f0961bf3dc65e204094349bd9aeaac1f8868]
stable/6.8: [a6fa75b5096c0f9826a4fabe22d907b0a5bb1016]

CVE-2024-26885: bpf: Fix DEVMAP_HASH overflow check on 32-bit arches

Announce: https://lore.kernel.org/linux-cve-announce/2024041741-CVE-2024-26885-4224@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f9d451 ("xdp: Add devmap_hash map type for
looking up devices by hashed index") in v5.4-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [281d464a34f540de166cee74b723e97ac2515ec3]
stable/5.10: [225da02acdc97af01b6bc6ce1a3e5362bf01d3fb]
stable/5.15: [c826502bed93970f2fd488918a7b8d5f1d30e2e3]
stable/6.1: [edf7990baa48de5097daa9ac02e06cb4c798a737]
stable/6.6: [250051acc21f9d4c5c595e4fcb55986ea08c4691]
stable/6.8: [e89386f62ce9a9ab9a94835a9890883c23d9d52c]

CVE-2024-26886: Bluetooth: af_bluetooth: Fix deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2024041742-CVE-2024-26886-6345@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2e07e83 ("Bluetooth: af_bluetooth: Fix
Use-After-Free in bt_sock_recvmsg") in v6.7-rc7.
This commit was backported to 5.10, 5.15, 6.1, and 6.6.
Fixed in v6.9-rc1.

Fixed status
mainline: [f7b94bdc1ec107c92262716b073b3e816d4784fb]
stable/6.1: [cb8adca52f306563d958a863bb0cbae9c184d1ae]
stable/6.6: [64be3c6154886200708da0dfe259705fb992416c]
stable/6.8: [2c9e2df022ef8b9d7fac58a04a2ef4ed25288955]

CVE-2024-26887: Bluetooth: btusb: Fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024041742-CVE-2024-26887-1126@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0b70151 ("Bluetooth: btusb: mediatek: add
MediaTek devcoredump support") in v6.6-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [79f4127a502c5905f04da1f20a7bbe07103fb77c]
stable/6.6: [620b9e60e4b55fa55540ce852a0f3c9e6091dbbc]
stable/6.8: [b08bd8f02a24e2b82fece5ac51dc1c3d9aa6c404]

CVE-2024-26888: Bluetooth: msft: Fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024041742-CVE-2024-26888-48e6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9e14606 ("Bluetooth: msft: Extended monitor
tracking by address filter") in v6.6-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [a6e06258f4c31eba0fcd503e19828b5f8fe7b08b]
stable/6.6: [98e9920c75e0790bff947a00d192d24bf1c724e0]
stable/6.8: [5cb93417c93716a5404f762f331f5de3653fd952]

CVE-2024-26889: Bluetooth: hci_core: Fix possible buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024041742-CVE-2024-26889-edfc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dcda165 ("Bluetooth: hci_core: Fix build
warnings") in v6.6-rc5.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [80dde49b8ca7bff8e943ebd29a790ec4dcf2ec29]
cip/4.4-st: [80dde49b8ca7bff8e943ebd29a790ec4dcf2ec29]
mainline: [81137162bfaa7278785b24c1fd2e9e74f082e8e4]
stable/4.19: [6d5a9d4a7bcbb7534ce45a18a52e7bd23e69d8ac]
stable/5.10: [d47e6c1932cee02954ea588c9f09fd5ecefeadfc]
stable/5.15: [2e845867b4e279eff0a19ade253390470e07e8a1]
stable/5.4: [54a03e4ac1a41edf8a5087bd59f8241b0de96d3d]
stable/6.1: [68644bf5ec6baaff40fc39b3529c874bfda709bd]
stable/6.6: [a41c8efe659caed0e21422876bbb6b73c15b5244]
stable/6.8: [2edce8e9a99dd5e4404259d52e754fdc97fb42c2]

CVE-2024-26890: Bluetooth: btrtl: fix out of bounds memory access

Announce: https://lore.kernel.org/linux-cve-announce/2024041742-CVE-2024-26890-4239@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5b35594 ("Bluetooth: btrtl: Add btrealtek data
struct") in v6.2-rc1.
Introduced by commit 044014c ("Bluetooth: btrtl: Add Realtek
devcoredump support") in v6.6-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [de4e88ec58c4202efd1f02eebb4939bbf6945358]
stable/6.6: [dd163fa34c483f1674aa2510accce11a224f649e]
stable/6.8: [0c657e641df1e77d6087688190f632cad9c0439b]

CVE-2024-26891: iommu/vt-d: Don't issue ATS Invalidation request when
device is disconnected

Announce: https://lore.kernel.org/linux-cve-announce/2024041743-CVE-2024-26891-940d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f7db75 ("iommu/vt-d: Add second level page table
interface") in v5.0-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [4fc82cd907ac075648789cc3a00877778aa1838b]
stable/5.10: [f873b85ec762c5a6abe94a7ddb31df5d3ba07d85]
stable/5.15: [d70f1c85113cd8c2aa8373f491ca5d1b22ec0554]
stable/6.1: [34a7b30f56d30114bf4d436e4dc793afe326fbcf]
stable/6.6: [2b74b2a92e524d7c8dec8e02e95ecf18b667c062]
stable/6.8: [025bc6b41e020aeb1e71f84ae3ffce945026de05]

CVE-2024-26892: wifi: mt76: mt7921e: fix use-after-free in free_irq()

Announce: https://lore.kernel.org/linux-cve-announce/2024041743-CVE-2024-26892-809e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9270270 ("wifi: mt76: mt7921: fix PCI DMA hang
after reboot") in v6.4-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [c957280ef6ab6bdf559a91ae693a6b34310697e3]
stable/6.6: [c7dd42fbebcfb02bef070fd48f774d6412d0b49d]
stable/6.8: [bfeaef901194c5923ce3330272786eff2fac513a]

CVE-2024-26893: firmware: arm_scmi: Fix double free in SMC transport
cleanup path

Announce: https://lore.kernel.org/linux-cve-announce/2024041743-CVE-2024-26893-34df@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1dc6558 ("firmware: arm_scmi: Add smc/hvc
transport") in v5.8-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [f1d71576d2c9ec8fdb822173fa7f3de79475e9bd]
stable/6.1: [0d276d9f335f41d6524258d58c0c0241ef9a83a4]
stable/6.6: [857f56db8c3a71f9871922b6984ff74ad588cb2c]
stable/6.8: [ead445dd3d681020af333649a27306160eee761d]

CVE-2024-26894: ACPI: processor_idle: Fix memory leak in
acpi_processor_power_exit()

Announce: https://lore.kernel.org/linux-cve-announce/2024041743-CVE-2024-26894-53ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d339dc ("cpuidle / ACPI : move cpuidle_device
field out of the acpi_processor_power structure") in v3.7-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [4ee875ed7f4b1a278bde5af653d1fa2ea962ff1b]
cip/4.4-st: [4ee875ed7f4b1a278bde5af653d1fa2ea962ff1b]
mainline: [e18afcb7b2a12b635ac10081f943fcf84ddacc51]
stable/4.19: [d351bcadab6caa6d8ce7159ff4b77e2da35c09fa]
stable/5.10: [c2a30c81bf3cb9033fa9f5305baf7c377075e2e5]
stable/5.15: [1cbaf4c793b0808532f4e7b40bc4be7cec2c78f2]
stable/5.4: [ea96bf3f80625cddba1391a87613356b1b45716d]
stable/6.1: [fad9bcd4d754cc689c19dc04d2c44b82c1a5d6c8]
stable/6.6: [3d48e5be107429ff5d824e7f2a00d1b610d36fbc]
stable/6.8: [cd5c2d0b09d5b6d3f0a7bbabe6761a4997e9dee9]

CVE-2024-26895: wifi: wilc1000: prevent use-after-free on vif when
cleaning up all interfaces

Announce: https://lore.kernel.org/linux-cve-announce/2024041744-CVE-2024-26895-5eee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8399918 ("staging: wilc1000: use RCU list to
maintain vif interfaces list") in v5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [cb5942b77c05d54310a0420cac12935e9b6aa21c]
stable/5.10: [5956f4203b6cdd0755bbdd21b45f3933c7026208]
stable/5.15: [fe20e3d56bc911408fc3c27a17c59e9d7885f7d1]
stable/6.1: [a9545af2a533739ffb64d6c9a6fec6f13e2b505f]
stable/6.6: [3da9d32b7f4a1a9f7e4bb15bb82f2b2dd6719447]
stable/6.8: [73a2aa0aef86c2c07be5a2f42c9e6047e1a2f7bb]

CVE-2024-26896: wifi: wfx: fix memory leak when starting AP

Announce: https://lore.kernel.org/linux-cve-announce/2024041744-CVE-2024-26896-79fe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 268bcee ("staging: wfx: fix BA when device is AP
and MFP is enabled") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [b8cfb7c819dd39965136a66fe3a7fde688d976fc]
stable/6.1: [a1f57a0127b89a6b6620514564aa7eaec16d9af3]
stable/6.6: [3a71ec74e5e3478d202a1874f085ca3ef40be49b]
stable/6.8: [dadbb5d29d6c5f571a50272fce8c1505a9559487]

CVE-2024-26897: wifi: ath9k: delay all of ath9k_wmi_event_tasklet()
until init is complete

Announce: https://lore.kernel.org/linux-cve-announce/2024041744-CVE-2024-26897-5382@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8b3046a ("ath9k_htc: fix NULL pointer dereference
at ath9k_htc_tx_get_packet()") in v5.17-rc1.
This commit was backported to 5.10 and 5.15.
Fixed in v6.9-rc1.

Fixed status
mainline: [24355fcb0d4cbcb6ddda262596558e8cfba70f11]
stable/5.10: [1bc5461a21c56a36e2a7d81e152b90ce019a3905]
stable/5.15: [f8ff4b4df71e87f609be0cc37d92e918107f9b90]
stable/6.1: [74d0639261dd795dce958d1b14815bdcbb48a715]
stable/6.6: [a015fbf698c8957aa5fbeefc5c59dd2cf3107298]
stable/6.8: [4afa0246656d5680c8a4c3fb37ba6570c4ab819b]

CVE-2024-26898: aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts

Announce: https://lore.kernel.org/linux-cve-announce/2024041744-CVE-2024-26898-d199@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7562f87 ("[NET]: Rework dev_base via list_head
(v3)") in v2.6.22-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [dd4e20bd656b6a9618e60d86bdefc0f3db636f22]
cip/4.4-st: [dd4e20bd656b6a9618e60d86bdefc0f3db636f22]
mainline: [f98364e926626c678fb4b9004b75cacf92ff0662]
stable/4.19: [ad80c34944d7175fa1f5c7a55066020002921a99]
stable/5.10: [faf0b4c5e00bb680e8e43ac936df24d3f48c8e65]
stable/5.15: [7dd09fa80b0765ce68bfae92f4e2f395ccf0fba4]
stable/5.4: [1a54aa506b3b2f31496731039e49778f54eee881]
stable/6.1: [74ca3ef68d2f449bc848c0a814cefc487bf755fa]
stable/6.6: [eb48680b0255a9e8a9bdc93d6a55b11c31262e62]
stable/6.8: [a16fbb80064634b254520a46395e36b87ca4731e]

CVE-2024-26899: block: fix deadlock between bd_link_disk_holder and
partition scan

Announce: https://lore.kernel.org/linux-cve-announce/2024041745-CVE-2024-26899-3f41@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1b0a2d9 ("md: use new apis to suspend array for
ioctls involed array reconfiguration") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [03f12122b20b6e6028e9ed69030a49f9cffcbb75]
stable/6.8: [5a87c1f7993bc8ac358a3766bac5dc7126e01e98]

CVE-2024-26900: md: fix kmemleak of rdev->serial

Announce: https://lore.kernel.org/linux-cve-announce/2024041745-CVE-2024-26900-70a3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 963c555 ("md: introduce
mddev_create/destroy_wb_pool for the change of member device") in
v5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [6cf350658736681b9d6b0b6e58c5c76b235bb4c4]
stable/6.8: [4c1021ce46fc2fb6115f7e79d353941e6dcad366]

CVE-2024-26901: do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak

Announce: https://lore.kernel.org/linux-cve-announce/2024041745-CVE-2024-26901-34e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 990d6c2 ("vfs: Add name to file handle conversion
support") in v2.6.39-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [3f84230ccc80aeb6cbddcbd5f8f519251055c8bd]
cip/4.4-st: [3f84230ccc80aeb6cbddcbd5f8f519251055c8bd]
mainline: [3948abaa4e2be938ccdfc289385a27342fb13d43]
stable/4.19: [4bac28f441e3cc9d3f1a84c8d023228a68d8a7c1]
stable/5.10: [cde76b3af247f615447bcfecf610bb76c3529126]
stable/5.15: [423b6bdf19bbc5e1f7e7461045099917378f7e71]
stable/5.4: [772a7def9868091da3bcb0d6c6ff9f0c03d7fa8b]
stable/6.1: [e6450d5e46a737a008b4885aa223486113bf0ad6]
stable/6.6: [c1362eae861db28b1608b9dc23e49634fe87b63b]
stable/6.8: [bf9ec1b24ab4e94345aa1c60811dd329f069c38b]

CVE-2024-26902: perf: RISCV: Fix panic on pmu overflow handler

Announce: https://lore.kernel.org/linux-cve-announce/2024041745-CVE-2024-26902-5f77@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.
Affected file drivers/perf/riscv_pmu_sbi.c was introduced by commit
e9991434 ("RISC-V: Add perf platform driver based on SBI PMU
extension") in 5.18-rc1.
The pmu_sbi_set_scounteren() and pmu_sbi_reset_scounteren() was
vulnerable since commit cc4c07c89 ("drivers: perf: Implement perf
event mmap support in the SBI backend") in 6.6-rc1.
The pmu_sbi_ovf_handler() was vulnerable since commit 4905ec2fb
("RISC-V: Add sscofpmf extension support") in 5.18-rc1.

Fixed status
mainline: [34b567868777e9fd39ec5333969728a7f0cf179c]
stable/6.6: [3ede8e94de6b834b48b0643385e66363e7a04be9]

CVE-2024-26903: Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Announce: https://lore.kernel.org/linux-cve-announce/2024041745-CVE-2024-26903-de5c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.

Fixed status
cip/4.4: [7e4e21f7b33e0c5bdcd99a981826cccaaf465456]
cip/4.4-st: [7e4e21f7b33e0c5bdcd99a981826cccaaf465456]
mainline: [2535b848fa0f42ddff3e5255cf5e742c9b77bb26]
stable/4.19: [369f419c097e82407dd429a202cde9a73d3ae29b]
stable/5.10: [81d7d920a22fd58ef9aedb1bd0a68ee32bd23e96]
stable/5.15: [8d1753973f598531baaa2c1033cf7f7b5bb004b0]
stable/5.4: [5f369efd9d963c1f711a06c9b8baf9f5ce616d85]
stable/6.1: [567c0411dc3b424fc7bd1e6109726d7ba32d4f73]
stable/6.6: [3ead59bafad05f2967ae2438c0528d53244cfde5]

CVE-2024-26904: btrfs: fix data race at btrfs_use_block_rsv() when
accessing block reserve

Announce: https://lore.kernel.org/linux-cve-announce/2024041746-CVE-2024-26904-e3a8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.
It seems as if all stable kernels are affected.
The btrfs_use_block_rsv() was renamed from use_block_rsv() by commit
67f9c220 ("btrfs: migrate the global_block_rsv helpers to
block-rsv.c") in 5.3-rc1.

Fixed status
mainline: [c7bb26b847e5b97814f522686068c5628e2b3646]
stable/5.4: [2daa2a8e895e6dc2395f8628c011bcf1e019040d]
stable/6.1: [ab1be3f1aa7799f99155488c28eacaef65eb68fb]
stable/6.6: [f6d4d29a12655b42a13cec038c2902bb7efc50ed]

CVE-2024-26905: btrfs: fix data races when accessing the reserved
amount of block reserves

Announce: https://lore.kernel.org/linux-cve-announce/2024041746-CVE-2024-26905-69f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.
The global_rsv_size was introduced in need_preemptive_reclaim() since
commit 610a6ef44 ("btrfs: take into account global rsv in
need_preemptive_reclaim") in 5.14-rc1.
The global_rsv_size was introduced in
btrfs_preempt_reclaim_metadata_space() since commit 576fa348 ("btrfs:
improve preemptive background space flushing") in 5.12-rc1-dontuse.
So, it seems as if prior to 5.12 kernels are not affected.

Fixed status
mainline: [e06cc89475eddc1f3a7a4d471524256152c68166]
stable/6.1: [995e91c9556c8fc6028b474145a36e947d1eb6b6]
stable/6.6: [82220b1835baaebf4ae2e490f56353a341a09bd2]

CVE-2024-26906: x86/mm: Disallow vsyscall page read for
copy_from_kernel_nofault()

Announce: https://lore.kernel.org/linux-cve-announce/2024041746-CVE-2024-26906-bb35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.
Affected file arch/x86/mm/maccess.c was introduced by commit 75a1a607b
("uaccess: Add strict non-pagefault kernel-space read function") in
5.5-rc1.
Therefore, prior to 5.5 kernels are not affected.

Fixed status
mainline: [32019c659ecfe1d92e3bf9fcdfbb11a7c70acd58]
stable/5.10: [6e4694e65b6db4c3de125115dd4f55848cc48381]
stable/5.15: [e8a67fe34b76a49320b33032228a794f40b0316b]
stable/6.1: [f175de546a3eb77614d94d4c02550181c0a8493e]
stable/6.6: [57f78c46f08198e1be08ffe99c4c1ccc12855bf5]

CVE-2024-26907: RDMA/mlx5: Fix fortify source warning while accessing
Eth segment

Announce: https://lore.kernel.org/linux-cve-announce/2024041746-CVE-2024-26907-a02d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.
The set_eth_seg() was introduced by commit f0313965 ("IB/mlx5:
Implement UD QP offloads for IPoIB in the TX flo") in 4.6-rc1.
So, 4.4 is not affected.
Using memcpy() as "memcpy(eseg->inline_hdr.start, pdata, copysz);" was
introduced by commit 34f4c955 ("IB/mlx5: Use fragmented QP's buffer
for in-kernel users") in 5.0-rc1.
It replaced "memcpy(seg - size_of_inl_hdr_start, pdata, copysz);".

Fixed status
mainline: [4d5e86a56615cc387d21c629f9af8fb0e958d350]
stable/5.10: [d27c48dc309da72c3b46351a1205d89687272baa]
stable/5.15: [60ba938a8bc8c90e724c75f98e932f9fb7ae1b9d]
stable/6.1: [cad82f1671e41094acd3b9a60cd27d67a3c64a21]
stable/6.6: [9a624a5f95733bac4648ecadb320ca83aa9c08fd]

CVE-2024-26908: x86/xen: Add some null pointer checking to smp.c

Announce: https://lore.kernel.org/linux-cve-announce/2024041747-CVE-2024-26908-4690@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.

Fixed status
cip/4.4: [2cdf6485e8f1aec725fa4f12ddf16be3317755d8]
cip/4.4-st: [2cdf6485e8f1aec725fa4f12ddf16be3317755d8]
mainline: [3693bb4465e6e32a204a5b86d3ec7e6b9f7e67c2]
stable/4.19: [70a33a629090130d731fc1e1ad498bb672eea165]
stable/5.10: [eb279074badac0bbe28749906562d648ca4bc750]
stable/5.15: [8082bccb7ac480ceab89b09c53d20c78ae54f9fa]
stable/5.4: [025a8a96c7ef3ff24a9b4753a7e851ba16f11bfc]
stable/6.1: [f49c513f46dc19bf01ffad2aaaf234d7f37f6799]
stable/6.6: [a9bbb05c0c04b49a1f7f05fd03826321dca2b8d4]

CVE-2024-26909: soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024041747-CVE-2024-26909-d9d0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 080b4e2 ("soc: qcom: pmic_glink: Introduce
altmode support") in v6.3-rc1.
Introduced by commit 2bcca96 ("soc: qcom: pmic-glink: switch to
DRM_AUX_HPD_BRIDGE") in v6.8-rc1.
These commits are not backportedt to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [b979f2d50a099f3402418d7ff5f26c3952fb08bb]
stable/6.6: [2bbd65c6ca567ed8dbbfc4fb945f57ce64bef342]

CVE-2024-26910: netfilter: ipset: fix performance regression in swap operation

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26910-3617@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 28628fa ("netfilter: ipset: fix race condition
between swap/destroy and kernel side add/del/test") in v6.7-rc2.
This commit was backported to 4.19, 5.10, 5.15, 5.4, 6.1, and 6.6.
Fixed in v6.8-rc3.

Fixed status
mainline: [97f7cf1cd80eeed3b7c808b7c12463295c751001]
stable/5.10: [a24d5f2ac8ef702a58e55ec276aad29b4bd97e05]
stable/5.15: [c2dc077d8f722a1c73a24e674f925602ee5ece49]
stable/5.4: [c7f2733e5011bfd136f1ca93497394d43aa76225]
stable/6.1: [653bc5e6d9995d7d5f497c665b321875a626161c]
stable/6.6: [b93a6756a01f4fd2f329a39216f9824c56a66397]

CVE-2024-26911: drm/buddy: Fix alloc_range() error handling code

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26911-e758@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0a1844b ("drm/buddy: Improve contiguous memory
allocation") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [8746c6c9dfa31d269c65dd52ab42fde0720b7d91]

CVE-2024-26912: drm/nouveau: fix several DMA buffer leaks

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26912-9206@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 176fdcb ("drm/nouveau/gsp/r535: add support for
booting GSP-RM") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [042b5f83841fbf7ce39474412db3b5e4765a7ea7]

CVE-2024-26913: drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

Announce: https://lore.kernel.org/linux-cve-announce/2024041736-CVE-2024-26913-2cb3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
The get_scaler_data_for_plane() was introduced by commit 7966f319
("drm/amd/display: Introduce DML2") in 6.7-rc1.

Fixed status
mainline: [faf51b201bc42adf500945732abb6220c707d6f3]

CVE-2024-26914: drm/amd/display: fix incorrect mpc_combine array size

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26914-e47b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
It looks it was introduced by commit c51d872 ("drm/amd/display: do not
attempt ODM power optimization if minimal transition doesn't exist")
in 6.7-rc1.
Fixed status
mainline: [39079fe8e660851abbafa90cd55cbf029210661f]

CVE-2024-26915: drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26915-112b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.

Fixed status
mainline: [7330256268664ea0a7dd5b07a3fed363093477dd]
stable/5.15: [9a9d00c23d170d4ef5a1b28e6b69f5c85dd12bc1]
stable/6.1: [a28f4d1e0bed85943d309ac243fd1c200f8af9a2]
stable/6.6: [8983397951b4b0bd51bb4b4ba9749424e1ccbb70]

CVE-2024-26916: Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26916-4a45@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ab47503 ("drm/amdgpu/sdma5.2: add begin/end_use
ring callbacks") in v6.7-rc6.
It looks as if all stable kernels are affected.

The cik_ih.c, cik_ih.c, iceland_ih.c, and tonga_ih.c were introduced in 4.2-rc1.
The ih_v6_0.c was intrduced in 5.19-rc1.
The ih_v6_1.c was introduced in 6.6-rc1.
The navi10_ih.c was introduced in 5.3-rc1.
The si_ih.c was introduced in 4.9-rc1.
The vega10_ih.c was introduced in 4.12-rc1.
The vega20_ih.c was introduced in 5.12-rc1-dontuse.

Fixed in v6.8-rc5.

Fixed status
mainline: [916361685319098f696b798ef1560f69ed96e934]
stable/5.15: [65158edb0a3a8df23197d52cd24287e39eaf95d6]
stable/6.1: [ff70e6ff6fc2413caf33410af7462d1f584d927e]
stable/6.6: [caa2565a2e13899be31f7b1e069e6465d3e2adb0]

CVE-2024-26917: scsi: Revert "scsi: fcoe: Fix potential deadlock on
&fip->ctlr_lock"

Announce: https://lore.kernel.org/linux-cve-announce/2024041737-CVE-2024-26917-8eda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1a19755 ("scsi: fcoe: Fix potential deadlock on
&fip->ctlr_lock") in v6.6-rc1.
Fixed in v6.8-rc5.

Fixed status
cip/4.4: [63aab4c4ce32ca02703b2ac8e5820dc7d1c4b28b]
cip/4.4-rt: [63aab4c4ce32ca02703b2ac8e5820dc7d1c4b28b]
cip/4.4-st: [63aab4c4ce32ca02703b2ac8e5820dc7d1c4b28b]
mainline: [977fe773dcc7098d8eaf4ee6382cb51e13e784cb]
stable/4.19: [94a600226b6d0ef065ee84024b450b566c5a87d6]
stable/5.10: [7d4e19f7ff644c5b79e8271df8ac2e549b436a5b]
stable/5.15: [5b8f473c4de95c056c1c767b1ad48c191544f6a5]
stable/5.4: [2209fc6e3d7727d787dc6ef9baa1e9eae6b1295b]
stable/6.1: [6bb22ac1d11d7d20f91e7fd2e657a9e5f6db65e0]
stable/6.6: [2996c7e97ea7cf4c1838a1b1dbc0885934113783]

CVE-2024-26918: PCI: Fix active state requirement in PME polling

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26918-6767@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d3fcd73 ("PCI: Fix runtime PM race with PME
polling") in v6.6-rc1.
Fixed in v6.8-rc5.

Fixed status
mainline: [41044d5360685e78a869d40a168491a70cdb7e73]
stable/6.6: [63b1a3d9dd3b3f6d67f524e76270e66767090583]

CVE-2024-26919: usb: ulpi: Fix debugfs directory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26919-5100@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd0a0a0 ("usb: ulpi: Add debugfs support") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [3caf2b2ad7334ef35f55b95f3e1b138c6f77b368]
stable/6.1: [d31b886ed6a5095214062ee4fb55037eb930adb6]
stable/6.6: [330d22aba17a4d30a56f007d0f51291d7e00862b]

CVE-2024-26920: tracing/trigger: Fix to return error if failed to alloc snapshot

Announce: https://lore.kernel.org/linux-cve-announce/2024041738-CVE-2024-26920-a681@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0bbe7f7 ("tracing: Fix the race between
registering 'snapshot' event trigger and triggering 'snapshot'
operation") in v5.7-rc2.
This commit was backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
cip/4.4: [a906faff69366bb6fb3b5d33dc7fcb7213e3c2d5]
cip/4.4-rt: [a906faff69366bb6fb3b5d33dc7fcb7213e3c2d5]
cip/4.4-st: [a906faff69366bb6fb3b5d33dc7fcb7213e3c2d5]
mainline: [0958b33ef5a04ed91f61cef4760ac412080c4e08]
stable/4.19: [bcf4a115a5068f3331fafb8c176c1af0da3d8b19]
stable/5.10: [56cfbe60710772916a5ba092c99542332b48e870]
stable/5.15: [b5085b5ac1d96ea2a8a6240f869655176ce44197]
stable/5.4: [8ffd5590f4d6ef5460acbeac7fbdff7025f9b419]
stable/6.1: [36be97e9eb535fe3008a5cb040b1e56f29f2e398]
stable/6.6: [6022c065c9ec465d84cebff8f480db083e4ee06b]

* Updated CVEs

CVE-2024-25739: Check for too small LEB size in VTBL code

The mainline, cip/4.4, cip/4.4-st, 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
cip/4.4: [42cee143e393919d1e983ac044efb8b0a6838bf0]
cip/4.4-st: [42cee143e393919d1e983ac044efb8b0a6838bf0]
mainline: [68a24aba7c593eafa8fd00f2f76407b9b32b47a9]
stable/5.15: [8ce982285414b741e2dd6ebb5a62e79dede44f7f]
stable/6.1: [5ecbc7465f66bb7eb2be2cd423f84000872e3560]
stable/6.6: [d1b505c988b711673d6a2de35222028be081d0d1]
stable/6.8: [04c4f2394970fa640bc794d627fe6b9406285406]

CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set()
in bluetooth driver causes DoS

The mainline, 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2023-24023: A man-in-the-middle attacks was found in Bluetooth
Core Specification 4.2 through 5.4

The mainline, 6.1, and 6.6 were fixed.

Fixed status
mainline: [04a342cc49a8522e99c9b3346371c329d841dcd2]
stable/6.1: [0f7bffd40a517660853ebdc1a104bd493e6bbe4f]
stable/6.6: [34c032a72f97e05cd1388aaeb1b3b255ac3c9581]

CVE-2022-48627: vt: fix memory overlapping when deleting chars in the buffer

stable 4.19 and 5.4 were fixed.

Fixed status
mainline: [39cdb68c64d84e71a4a717000b6e5de208ee60cc]
stable/4.19: [c8686c014b5e872ba7e334f33ca553f14446fc29]
stable/5.10: [bfee93c9a6c395f9aa62268f1cedf64999844926]
stable/5.15: [57964a5710252bc82fe22d9fa98c180c58c20244]
stable/5.4: [815be99d934e3292906536275f2b8d5131cdf52c]

CVE-2023-28746:

stable 5.10 was fixed.

Fixed status
mainline: [e95df4ec0c0c9791941f112db699fae794b9862a,
4e42765d1be01111df0c0275bbaf1db1acef346e,
  8076fcde016c9c0e0660543e67bff86cb48a7c9c,
2a0180129d726a4b953232175857d442651b55a0]
stable/5.10: [6e04cae36b8f52c81cbcafdb8f198d80739943f1,
5fbd9f6c3953215923b8b4116e2d2b8dc4960d9f,
  66d5260fc7d5adb115c97f0e011ee13c0caa8ea6,
91cf85f75375359b73cd78a47cf1d6d50ec5e4b8]
stable/5.15: [a2b586df5546311f9be5f6acb9fe489b623c526e,
4fa001418efd40ad00ff429e6064ab8eeeddc739,
  2fb08b672eb78c4930413cf529734792456ae15f,
2ae88e83f3b7e579a7085d140f61122f128932f1]
stable/6.1: [8b5760939db9c49c03b9e19f6c485a8812f48d83,
29476fac750dddeabc3503bf9b13e05b949d7adb,
  d405b9c03f06b1b5e73ebc4f34452687022f7029,
b2e92ab17e440a97c716b701ecd897eebca11ac0]
stable/6.6: [c35ca0968de41952af2ad7d22881e4a7c6e1b145,
ddfd38558acc5b3891fd197372fedb76372da740,
  77018fb9efe50cf24e61275ee09253cf1fbb6854,
4a5b5bfea063745471af6395d22ebaea8242225e]
stable/6.7: [18867a204511d032c2a6ed083461a10905061fac,
13acf9f1df3513ea7a5170399c2a8e297e5fbdc1,
  fe5f4d14cdad934c5c92080cebd5b18189bf4ac9,
328607cf9e1fcbbc3f5521391d601306f72a5890]
stable/6.8: [056c33c67a74aec19668b927d460825f5e9aab42,
7586a7c0ba2f16ee6fe7f1ad95313775717e9f53,
  c8a1b14f43bb89a62c1471ec2931f152b37b3782,
50d33b98b1e23d1cd8743b3cac7a0ae5718b8b00]

CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
cip/4.4: [726d91d1c97799544aee356136de385d11f81eab]
cip/4.4-st: [726d91d1c97799544aee356136de385d11f81eab]
mainline: [0f7352557a35ab7888bc7831411ec8a3cbe20d78]
stable/4.19: [202c503935042272e2f9e1bb549d5f69a8681169]
stable/5.10: [bacb8c3ab86dcd760c15903fcee58169bc3026aa]
stable/5.15: [8c36205123dc57349b59b4f1a2301eb278cbc731]
stable/5.4: [8e3f03f4ef7c36091f46e7349096efb5a2cdb3a1]
stable/6.1: [0b812f706fd7090be74812101114a0e165b36744]
stable/6.6: [190794848e2b9d15de92d502b6ac652806904f5a]
stable/6.7: [6678a1e7d896c00030b31491690e8ddc9a90767a]
stable/6.8: [0a7591e14a8da794d0b93b5d1c6254ccb23adacb]

CVE-2023-52458: block: add check that partition length needs to be
aligned with block size

stable 5.10 was fixed.

Fixed status
mainline: [6f64f866aa1ae6975c95d805ed51d7e9433a0016]
stable/5.10: [8f6dfa1f1efe6dcca2d43e575491d8fcbe922f62]
stable/5.15: [5010c27120962c85d2f421d2cf211791c9603503]
stable/6.1: [ef31cc87794731ffcb578a195a2c47d744e25fb8]
stable/6.6: [cb16cc1abda18a9514106d2ac8c8d7abc0be5ed8]
stable/6.7: [bcdc288e7bc008daf38ef0401b53e4a8bb61bbe5]

CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous sets

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [e26d3009efda338f19016df4175f354a9bd0a4ab]
stable/4.19: [116b0e8e4673a5faa8a739a19b467010c4d3058c]
stable/5.10: [6f3ae02bbb62f151b19162d5fdc9fe3d48450323]
stable/5.15: [00b19ee0dcc1aef06294471ab489bae26d94524e]
stable/5.4: [49ce99ae43314d887153e07cec8bb6a647a19268]
stable/6.1: [b7be6c737a179a76901c872f6b4c1d00552d9a1b]

CVE-2024-24857: Integer overflow bug was found in bluetooth device driver

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/4.19: [466488b14a87dc97d8a3bf5e65a30bff032847c1]
stable/5.10: [e47088075477ea4129f9b000309f189e1392f138]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/5.4: [f5450973ebe8b7f6f66cfeafbb917671bb2477eb]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2024-24858: Race condition bug in bluetooth driver causes DoS

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/4.19: [466488b14a87dc97d8a3bf5e65a30bff032847c1]
stable/5.10: [e47088075477ea4129f9b000309f189e1392f138]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/5.4: [f5450973ebe8b7f6f66cfeafbb917671bb2477eb]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set()
in bluetooth driver causes DoS

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [7835fcfd132eb88b87e8eb901f88436f63ab60f7]
stable/4.19: [466488b14a87dc97d8a3bf5e65a30bff032847c1]
stable/5.10: [e47088075477ea4129f9b000309f189e1392f138]
stable/5.15: [a8170af8b10e904c0052aa4ec31c653635730d92]
stable/5.4: [f5450973ebe8b7f6f66cfeafbb917671bb2477eb]
stable/6.1: [18e189442a5896255e764f8e875c13d16248ef2f]
stable/6.6: [d75632d0db3cdc31873d25756066a7f56bc87737]
stable/6.8: [d0bfebd8ca411697248d0cebe4ad2649f23ab0bf]

CVE-2024-24861: Race condition bug was found in media/xc4000 device
driver in xc4000 xc4000_get_frequency()

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
cip/4.4: [7d5d34bfcf30298581bba6d5ca6cca69be117032]
cip/4.4-st: [7d5d34bfcf30298581bba6d5ca6cca69be117032]
mainline: [36d503ad547d1c75758a6fcdbec2806f1b6aeb41]
stable/4.19: [72ddb259a4d09f8e0d06cb2abc9a3eedfcb4200e]
stable/5.10: [7936e5c8da5bc975dec7e1e31e05da154f140cf6]
stable/5.15: [fec51819607ff0a80ad8ce678120fda80ca0b2fa]
stable/5.4: [ce6e52caded1d70e3a203da36a857b7d874e863f]
stable/6.1: [09c1be4d581d3356159abcc5a8a7a6c5f1bf1e77]
stable/6.6: [dc5e4f240473b64f7b2f24424e96c92435ebd8d7]
stable/6.7: [b0864de231dece0f7226b909521bebc86105743a]
stable/6.8: [5c26122885cedcb99606cdc06a3419db7feb1e1e]

CVE-2024-25739: ubi: Check for too small LEB size in VTBL code

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
cip/4.4: [42cee143e393919d1e983ac044efb8b0a6838bf0]
cip/4.4-st: [42cee143e393919d1e983ac044efb8b0a6838bf0]
mainline: [68a24aba7c593eafa8fd00f2f76407b9b32b47a9]
stable/4.19: [ff818a59ecdfb13a8eb4a38a87b869090dd1745c]
stable/5.10: [0a16a633a208b0b249bfaea5be699c07f304aaf0]
stable/5.15: [8ce982285414b741e2dd6ebb5a62e79dede44f7f]
stable/5.4: [4e09d5210ba481dd04ccc6e7d1b3b019d8bc3ddc]
stable/6.1: [5ecbc7465f66bb7eb2be2cd423f84000872e3560]
stable/6.6: [d1b505c988b711673d6a2de35222028be081d0d1]
stable/6.8: [04c4f2394970fa640bc794d627fe6b9406285406]

CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with timeout flag

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
cip/4.4: [170bf61cffad04fa5e31f82702296fc8a6c561a2]
cip/4.4-st: [170bf61cffad04fa5e31f82702296fc8a6c561a2]
mainline: [16603605b667b70da974bea8216c93e7db043bf1]
stable/4.19: [e4988d8415bd0294d6f9f4a1e7095f8b50a97ca9]
stable/5.10: [fe40ffbca19dc70d7c6b1e3c77b9ccb404c57351]
stable/5.15: [7cdc1be24cc1bcd56a3e89ac4aef20e31ad09199]
stable/5.4: [e9a0d3f376eb356d54ffce36e7cc37514cbfbd6f]
stable/6.1: [72c1efe3f247a581667b7d368fff3bd9a03cd57a]
stable/6.6: [c0c2176d1814b92ea4c8e7eb7c9cd94cd99c1b12]
stable/6.7: [8e07c16695583a66e81f67ce4c46e94dece47ba7]

CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding
anonymous set with timeout

stable 5.10 and 5.4 was fixed.

Fixed status
mainline: [552705a3650bbf46a22b1adedc1b04181490fc36]
stable/5.10: [e2d45f467096e931044f0ab7634499879d851a5c]
stable/5.15: [291cca35818bd52a407bc37ab45a15816039e363]
stable/5.4: [edcf1a3f182ecf8b6b805f0ce90570ea98c5f6bf]
stable/6.1: [406b0241d0eb598a0b330ab20ae325537d8d8163]
stable/6.6: [b2d6f9a5b1cf968f1eaa71085ceeb09c2cb276b1]
stable/6.7: [5224afbc30c3ca9ba23e752f0f138729b2c48dd8]

CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [051e0840ffa8ab25554d6b14b62c9ab9e4901457]
stable/4.19: [eeb2a2ca0b8de7e1c66afaf719529154e7dc60b2]
stable/5.10: [aa39e6878f61f50892ee2dd9d2176f72020be845]
stable/5.15: [8c990221681688da34295d6d76cc2f5b963e83f5]
stable/5.4: [4206ad65a0ee76920041a755bd3c17c6ba59bba2]
stable/6.1: [9d66ae0e7bb78b54e1e0525456c6b54e1d132046]
stable/6.6: [61d4787692c1fccdc268ffa7a891f9c149f50901]
stable/6.7: [e955e8a7f38a856fc6534ba4e6bffd4d5cc80ac3]
stable/6.8: [3c907bf56905de7d27b329afaf59c2fb35d17b04]

CVE-2024-26687: xen/events: close evtchn after mapping cleanup

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [fa765c4b4aed2d64266b694520ecb025c862c5a9]
stable/5.10: [0fc88aeb2e32b76db3fe6a624b8333dbe621b8fd]
stable/5.15: [ea592baf9e41779fe9a0424c03dd2f324feca3b3]
stable/5.4: [9470f5b2503cae994098dea9682aee15b313fa44]
stable/6.1: [585a344af6bcac222608a158fc2830ff02712af5]
stable/6.6: [20980195ec8d2e41653800c45c8c367fa1b1f2b4]
stable/6.7: [9be71aa12afa91dfe457b3fb4a444c42b1ee036b]

CVE-2024-26810: vfio/pci: Lock external INTx masking ops

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [810cd4bb53456d0503cc4e7934e063835152c1b7]
stable/5.10: [3dd9be6cb55e0f47544e7cdda486413f7134e3b3]
stable/5.15: [ec73e079729258a05452356cf6d098bf1504d5a6]
stable/5.4: [1e71b6449d55179170efc8dee8664510bb813b42]
stable/6.1: [3fe0ac10bd117df847c93408a9d428a453cd60e5]
stable/6.6: [04a4a017b9ffd7b0f427b8c376688d14cb614651]
stable/6.8: [03505e3344b0576fd619416793a31eae9c5b73bf]

CVE-2024-26812: vfio/pci: Create persistent INTx handler

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [18c198c96a815c962adc2b9b77909eec0be7df4d]
stable/5.10: [27d40bf72dd9a6600b76ad05859176ea9a1b4897]
stable/5.15: [4cb0d7532126d23145329826c38054b4e9a05e7c]
stable/5.4: [b18fa894d615c8527e15d96b76c7448800e13899]
stable/6.1: [7d29d4c72c1e196cce6969c98072a272d1a703b3]
stable/6.6: [69276a555c740acfbff13fb5769ee9c92e1c828e]
stable/6.8: [0e09cf81959d9f12b75ad5c6dd53d237432ed034]

CVE-2024-26813: vfio/platform: Create persistent IRQ handlers

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [675daf435e9f8e5a5eab140a9864dfad6668b375]
stable/5.10: [09452c8fcbd7817c06e8e3212d99b45917e603a5]
stable/5.15: [cc5838f19d39a5fef04c468199699d2a4578be3a]
stable/5.4: [07afdfd8a68f9eea8db0ddc4626c874f29d2ac5e]
stable/6.1: [7932db06c82c5b2f42a4d1a849d97dba9ce4a362]
stable/6.6: [62d4e43a569b67929eb3319780be5359694c8086]
stable/6.8: [0f8d8f9c2173a541812dd750529f4a415117eb29]

CVE-2024-26814: vfio/fsl-mc: Block calling interrupt handler without trigger

stable 5.10 was fixed.

Fixed status
mainline: [7447d911af699a15f8d050dfcb7c680a86f87012]
stable/5.10: [a563fc18583ca4f42e2fdd0c70c7c618288e7ede]
stable/5.15: [250219c6a556f8c69c5910fca05a59037e24147d]
stable/6.1: [083e750c9f5f4c3bf61161330fb84d7c8e8bb417]
stable/6.6: [ee0bd4ad780dfbb60355b99f25063357ab488267]
stable/6.8: [6ec0d88166dac43f29e96801c0927d514f17add9]

CVE-2024-27437: vfio/pci: Disable auto-enable of exclusive INTx IRQ

stable 5.10 and 5.4 were fixed.

Fixed status
mainline: [fe9a7082684eb059b925c535682e68c34d487d43]
stable/5.10: [561d5e1998d58b54ce2bbbb3e843b669aa0b3db5]
stable/5.15: [b7a2f0955ffceffadfe098b40b50307431f45438]
stable/5.4: [26389925d6c2126fb777821a0a983adca7ee6351]
stable/6.1: [139dfcc4d723ab13469881200c7d80f49d776060]
stable/6.6: [2a4a666c45107206605b7b5bc20545f8aabc4fa2]
stable/6.8: [bf0bc84a20e6109ab07d5dc072067bd01eb931ec]

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

