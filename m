Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C9CDB47E
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 22:55:03 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.864.1697064902125686245
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Oct 2023 15:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=DPeFEaB2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e9872c88aaso192349fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1697064901; x=1697669701; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrx9a/8WLxFe7il7q/9Y5YkN6Rq4lA3kbvo2tO0ceWg=;
        b=DPeFEaB2Bj2k/MwirBvvRIFwXk/uyzbHEjE+rzgBDcb21Ro70k9t+DDa5TpQaPYIWK
         hgCheKsczOTdhX2CPt2umtegfSrvDWzsoE21U2+ZAuJEs5XYZTgjpQv3zv/WybLT+srs
         qjRcWQ5R+vQ5zdxT3rvZ91dO89L1eDdUhNrXdK50YnlRQ9ydBc+GYvdqOBUmhJYdUy9U
         ITkTVrRAAaPUXX4M4swjqGkEyS9HoqDamo5LjqP2AtVEpKN0+NYCf3YWBdVjAY5sZqIW
         A+y+sH78mYnzoNZ3YOkjJE/2WnAhiyVYZ5+0o3qWbJH8ABmh1k5RHDWu4cyrIaNr7R7j
         ZMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064901; x=1697669701;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrx9a/8WLxFe7il7q/9Y5YkN6Rq4lA3kbvo2tO0ceWg=;
        b=CzcC2CJqOa8dlXjF/40sbbpiNR5v5yRbRziP1TfNpU+WJAT9iRO8FaAlM7QhM+qDa3
         Rd/ph1ay3ru3QP3015G0Wg9YfNuueDNd/6I0Bqwy0oOYS5VrYeFogVYLutFiMySAmFPi
         UQ/LcL6V9tG4qTPRs4/aQfdhqI4oDzWriJ65a7awl1Eqe5TC/tBcoIk86Ou39sJIsCbk
         PCjGoME9Lo+XkMZ/52bRYDSBlBkm1CNyiFHfKLztSgxmz9hePQfO5DmDykayauvcDvOl
         Skw2YYrC6SBaORlXZ/bmLje7UbeGUMpupIUgeBRP8evAUP0l0pEvh+ffx+20PK9qETcg
         8ZYw==
X-Gm-Message-State: AOJu0YwbkoIllUGxSdN2Z+llQNTtwXEFWlrfMfMHl4+trdD9uBFZEvnO
	XU1b1ebJEeoYSixGbIi94YEOgkW6EQ1yj1QkNrXA/qOZrx6+U1MSdsY=
X-Google-Smtp-Source: AGHT+IELBPFpmuvZH+zpFvJZaLPDY7F4sKyLrggQ3hr5R+QroO4NgrdApOHjcy9h7XWFRGx50QgoKyN6ijKpzYQAem8=
X-Received: by 2002:a05:6870:2309:b0:1d0:f5bd:6cf with SMTP id
 w9-20020a056870230900b001d0f5bd06cfmr24979015oao.43.1697064900894; Wed, 11
 Oct 2023 15:55:00 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Oct 2023 07:54:24 +0900
Message-ID: <CAODzB9qEeHAWom2kTWJ0TbHceMAUJdMnRxjKbw-fFRh90pxfrw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 22:55:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13388

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 8 updated CVEs.

* New CVEs

CVE-2023-39191: eBPF: insufficient stack type checks in dynptr

CVSS v3 score is not provided (NIST).
CVSS v3 score is 8.2 HIGH (CNA).

An improper input validation flaw was found in the eBPF subsystem in
the Linux kernel. The issue occurs due to a lack of proper validation
of dynamic pointers within user-supplied eBPF programs prior to
executing them. This may allow an attacker with CAP_BPF privileges to
escalate privileges and execute arbitrary code in the context of the
kernel.

It introduced by commit Fixes: 97e03f521050 ("bpf: Add verifier
support for dynptrs") in 5.19-rc1.
Fixed in 6.3-rc1 in the mainline.

Fixed status
mainline: [d6fefa1105dacc8a742cdcf2f4bfb501c9e61349,
79168a669d8125453c8a271115f1ffd4294e61f6,
  ef8fc7a07c0e161841779d6fe3f6acd5a05c547c,
f8064ab90d6644bc8338d2d7ff6a0d6e7a1b2ef3,
  379d4ba831cfa895d0cc61d88cd0e1402f35818c,
f5b625e5f8bbc6be8bb568a64d7906b091bc7cb0,
  1ee72bcbe48de6dcfa44d6eba0aec6e42d04cd4d,
91b875a5e43b3a8dec4fbdca067c8860004b5f0e,
  f4d24edf1b9249e43282ac2572d43d9ad10faf43,
ef4810135396735c1a6b1c343c3cc4fe4be96a43,
  011edc8e49b8551dfb6cfcc8601d05e029cf5994,
ae8e354c497af625eaecd3d86e04f9087762d42b]

CVE-2023-39192: netfilter: xt_u32: validate user space input

CVSS v3 score is 6.0 MEDIUM (NIST).
CVSS v3 score is 6.7 MEDIUM (CNA).

This vulnerability allows local attackers to disclose sensitive
information on affected installations of the Linux Kernel. An attacker
must first obtain the ability to execute high-privileged code on the
target system in order to exploit this vulnerability.

The specific flaw exists within the u32_match_it function. The issue
results from the lack of proper validation of user-supplied data,
which can result in a read past the end of an allocated data
structure. An attacker can leverage this in conjunction with other
vulnerabilities to execute arbitrary code in the context of the
kernel.

Introduced by commit 1b50b8a ("[NETFILTER]: Add u32 match") in 2.6.23-rc1.
Fixed in 6.6-rc1 in the mainline.

Fixed status
cip/4.4-st: [023311531a6ae3aa7e3d6ca27da52988cef78453]
mainline: [69c5d284f67089b4750d28ff6ac6f52ec224b330]
stable/4.14: [e416d65ff456066d60d813c540ab2dd2a06d3d12]
stable/4.19: [ddf190be80ef0677629416a128f9da91e5800d21]
stable/5.10: [a1b711c370f5269f4e81a07e7542e351c0c4682e]
stable/5.15: [b3d07714ad24e51ff6fc6dced3bd3d960e99ac25]
stable/5.4: [28ce8495b5599abaa4b4f0bbb45f1f8e89b07e15]
stable/6.1: [1c164c1e9e93b0a72a03a7edb754e3857d4e4302]
stable/6.5: [799cc0fb184408f688b030ea381844b16d1d9c62]

CVE-2023-39193: netfilter: xt_sctp: validate the flag_info count

CVSS v3 score is 6.0 MEDIUM (NIST).
CVSS v3 score is 5.1 MEDIUM (CNA).

Introduced by commit 2e4e6a1 ("[NETFILTER] x_tables: Abstraction layer
for {ip,ip6,arp}_tables") in 2.6.16-rc1.

This vulnerability allows local attackers to disclose sensitive
information on affected installations of the Linux Kernel. An attacker
must first obtain the ability to execute high-privileged code on the
target system in order to exploit this vulnerability.

The specific flaw exists within the match_flags function. The issue
results from the lack of proper validation of user-supplied data,
which can result in a read past the end of an allocated data
structure. An attacker can leverage this in conjunction with other
vulnerabilities to execute arbitrary code in the context of the
kernel.

Introduced by commit 2e4e6a1 ("[NETFILTER] x_tables: Abstraction layer
for {ip,ip6,arp}_tables") in 2.6.16-rc1.
Fixed in 6.6-rc1 in the mainline.

Fixed status
cip/4.4-st: [ad14bd8357a265ce12ebe9698db3c66ab8110bc5]
mainline: [e99476497687ef9e850748fe6d232264f30bc8f9]
stable/4.14: [be52e3c14651ade0f4539f319f9f0c40a230b076]
stable/4.19: [f25dbfadaf525d854597c16420dd753ca47b9396]
stable/5.10: [5541827d13cf19b905594eaee586527476efaa61]
stable/5.15: [267a29f8bfdb949ad2a03a3b6d7ad42aeb4c2bab]
stable/5.4: [64831fb6a2040c25473ff8c8e85b3a42bd38494c]
stable/6.1: [4921f9349b66da7c5a2b6418fe45e9ae0ae72924]
stable/6.5: [85ebbbe845823be6f8c04b4901da9a0a6f866283]

CVE-2023-39194: net: xfrm: Fix xfrm_address_filter OOB read

CVSS v3 score is 2.3 LOW (NIST).
CVSS v3 score is 3.2 LOW (CNA).

This vulnerability allows local attackers to disclose sensitive
information on affected installations of the Linux Kernel. An attacker
must first obtain the ability to execute high-privileged code on the
target system in order to exploit this vulnerability.

The specific flaw exists within the processing of state filters. The
issue results from the lack of proper validation of user-supplied
data, which can result in a read past the end of an allocated buffer.
An attacker can leverage this in conjunction with other vulnerabilties
to escalate privileges and execute arbitrary code in the context of
the kernel.

Introduced by commit d362309 ("ipsec: add support of limited SA dump")
in 3.15-rc1.
Fixed in 6.5-rc7 in the mainline.

Fixed status
cip/4.4: [f5973308eb3a388a3a1c02a67ebf60e2c9355ff8]
cip/4.4-st: [f5973308eb3a388a3a1c02a67ebf60e2c9355ff8]
mainline: [dfa73c17d55b921e1d4e154976de35317e43a93a]
stable/4.14: [0a42d1335985f9ebfbc997944ba8b1d84b9b661e]
stable/4.19: [a695f0e724330773283a6d67e149363b89087f76]
stable/5.10: [7e50815d29037e08d3d26f3ebc41bcec729847b7]
stable/5.15: [1960f468078b3471d1ee9aafa0cf06c8c34a505f]
stable/5.4: [373848d51fde9138cdc539b1d97dc6b301cc04d5]
stable/6.1: [9a0056276f5f38e188732bd7b6949edca6a80ea1]

CVE-2023-39189: netfilter: nfnetlink_osf: avoid OOB read

A flaw was found in the Netfilter subsystem in the Linux kernel. The
nfnl_osf_add_callback function did not validate the user mode
controlled opt_num field. This flaw allows a local privileged
(CAP_NET_ADMIN) attacker to trigger an out-of-bounds read, leading to
a crash or information disclosure.

Introduced by commit 11eeef4 ("netfilter: passive OS fingerprint
xtables match") in 2.6.31-rc1. Fixed in 6.6-rc1.

CVSS v3 score is 6.0 MEDIUM (NIST).
CVSS v3 score is 5.1 MEDIUM (CNA).

Fixed status
mainline: [f4f8a7803119005e87b716874bec07c751efafec]
stable/4.19: [40d427ffccf9e60bd7288ea3748c066404a35622]
stable/5.10: [780f60dde29692c42091602fee9c25e9e391f3dc]
stable/5.15: [19280e8dfb52cf9660760fdc86e606e0653170fa]
stable/5.4: [a44602888bbe89d9dd89cb84baed2e356aba7436]
stable/6.1: [7bb8d52b4271be7527b6e3120ae6ce4c6cdf6e34]
stable/6.5: [a3d0f898b80ac9b049e590b3ee6391716002da17]

CVE-2023-34324: xen/events: replace evtchn_rwlock with RCU

CVSS v3 score is not provided.

A (malicious) guest administrator could cause a denial of service (DoS)
in a backend domain (other than dom0) by disabling a paravirtualized
device.

A malicious backend could cause DoS in a guest running a Linux kernel by
disabling a paravirtualized device.

Introduced by commit 54c9de8 ("xen/events: add a new "late EOI" evtchn
framework") in 5.10-rc1.
This commit was backported to older kernels. cip/4.4-st, cip/4.4, and
cip/4.4-rt contain this commit that hash is
1d762cb6676b5f9c57c6ac56856e540529a8d928.

Fixed status
mainline: [87797fad6cce28ec9be3c13f031776ff4f104cfc]
stable/4.14: [bc32110d6176cc34c58f4efa22194546f103b81a]
stable/4.19: [3fdf2be9089b5096a28e76376656c60ce410ac4a]
stable/5.10: [660627c71bc1098aa94e5f208f14748b105b73bc]
stable/5.15: [c8af81a9d36e0d2e5f198eaceb38a743d834dfe2]
stable/5.4: [f70c285cf02c2430da74c58b8a177fcb5df6ca43]
stable/6.1: [a4cc925e2e12c3bbffb0860acdb9f9c1abde47dd]
stable/6.5: [76b33722e2d2336a6e2a7d9eacbbb8988478cf98]

* Updated CVEs

CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack

Stable 4.14, 4.19, 5.10, 5.15, 5.4, 6.1, and 6.5 were fixed.

Fixed status
mainline: [0113d9c9d1ccc07f5a3710dac4aa24b6d711278c]
stable/4.14: [084c7ac9e8d60bf21a423490021b7c3427312955]
stable/4.19: [a2cf7bd75b3992e8df68dd5fdc6499b67d45f6e0]
stable/5.10: [8689c9ace976d6c078e6dc844b09598796e84099]
stable/5.15: [8860d354f653628b6330e1c5b06b2828948135a4]
stable/5.4: [810fd23d9715474aa27997584e8fc9396ef3cb67]
stable/6.1: [2712545e535d7a2e4c53b9c9658a9c88c6055862]
stable/6.5: [cda20fcddf53f0f959641c8ef4d50ab87ffa5124]

CVE-2023-42756: netfilter: ipset: Fix race between IPSET_CMD_CREATE
and IPSET_CMD_SWAP

Stable 5.10, 5.15, 5.4, 6.1, and 6.5 were fixed.

Fixed status
mainline: [7433b6d2afd512d04398c73aa984d1e285be125b]
stable/5.10: [f1893feb20ea033bcd9c449b55df3dab3802c907]
stable/5.15: [a70dbdede0c7173d4a44247a454d1015e361b72d]
stable/5.4: [02a233986c9eaabfce0b08362189743e4809f579]
stable/6.1: [ea5a61d58886ae875f1b4a371999f2a8b58cf26d]
stable/6.5: [20a93d402b6fe6757e14b0eeb400dfac8b8aa3ad]

CVE-2023-5197: netfilter: nf_tables: disallow rule removal from chain binding

Stable 5.10, 5.15 and 6.5 were fixed.

Fixed status
mainline: [f15f29fd4779be8a418b66e9d52979bb6d6c2325]
stable/5.10: [5a03b42ae1ed646eb5f5acceff1fb2b1d85ec077]
stable/5.15: [0c5fd85fb01fa1a5dbb9f213b0d1925e671f30df]
stable/6.1: [9af8bb2afea3705b58fe930f97a39322f46e5b8b]
stable/6.5: [13f385f99147b4445a1ff151fabd44c12d366ab0]

CVE-2023-5345: fs/smb/client: Reset password pointer to NULL

Stable 6.1 and 6.5 was fixed.

Fixed status
mainline: [e6e43b8aa7cd3c3af686caf0c2e11819a886d705]
stable/6.1: [f555a508087ab8210b4658120ac6413d6fe2b4c7]
stable/6.5: [0c116005af551e9cf437a9ec8c80204c2d4b1b53]

CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's netfilter

Stable 5.10 was fixed.

Fixed status
mainline: [5f68718b34a531a556f2f50300ead2862278da26,
f6c383b8c31a93752a52697f8430a71dcbc46adf,
  c92db3030492b8ad1d0faace7a93bbcf53850d0c,
a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
  24138933b97b055d486e8064b4a1721702442a9b,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
  02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]
stable/5.10: [448be0774882f95a74fa5eb7519761152add601b,
146c76866795553dbc19998f36718d7986ad302b,
  77046cb00850e35ba935944b5100996b2ce34bba,
911dd3cdf1083f4c2e7df72aaab486a1d6dbcc0a,
  b15ea4017af82011dd55225ce77cce3d4dfc169c,
4046f2b56e5a7ba7e123ff961dd51187b8d59e78,
  dc0b1f019554e601f57e78d8f5c70e59d77e49a5,
a7653eaea0a59a6993c62d3653af5c880ce28533]
stable/6.1: [7148bca63b212fc8e5c2e8374e14cd62b1c8441c,
59dab3bf0b8fc08eb802721c0532f13dd89209b8,
  ea3eb9f2192e4fc33b795673e56c97a21987f868,
df650d6a4bf47248261b61ef6b174d7c54034d15,
  4ead4f74b3a9162b205f702d72d4a3421356dbc1,
0b9af4860a61f55cf716267b5ae5df34aacc4b39,
  41113aa5698ad7a82635bcb747d483e4458d518d,
afa584c35065051a11ae3ea3cc105b634053fcd8]

CVE-2023-4563: Use-after-free in nft_verdict_dump due to a race
between set GC and transaction

Stable 5.10 was fixed.

Fixed status
mainline: [24138933b97b055d486e8064b4a1721702442a9b,
5f68718b34a531a556f2f50300ead2862278da26,
  f6c383b8c31a93752a52697f8430a71dcbc46adf,
c92db3030492b8ad1d0faace7a93bbcf53850d0c,
  a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
  02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]
stable/5.10: [b15ea4017af82011dd55225ce77cce3d4dfc169c,
448be0774882f95a74fa5eb7519761152add601b,
  146c76866795553dbc19998f36718d7986ad302b,
77046cb00850e35ba935944b5100996b2ce34bba,
  911dd3cdf1083f4c2e7df72aaab486a1d6dbcc0a,
4046f2b56e5a7ba7e123ff961dd51187b8d59e78,
  dc0b1f019554e601f57e78d8f5c70e59d77e49a5,
a7653eaea0a59a6993c62d3653af5c880ce28533]

CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve

Stable 4.14 was fixed.

Fixed status
mainline: [b3d26c5702c7d6c45456326e56d2ccf3f103e60f]
stable/4.14: [3c0bd0b79733b7f628af1c967269db339eeef8d3]
stable/4.19: [7c62e0c3c6e9c9c15ead63339db6a0e158d22a66]
stable/5.10: [b08cc6c0396fd5cfaac4ca044f2282367347c062]
stable/5.15: [4cf994d3f4ff42d604fae2b461bdd5195a7dfabd]
stable/5.4: [da13749d5ff70bb033a8f35da32cfd6e88246b2f]
stable/6.1: [a1e820fc7808e42b990d224f40e9b4895503ac40]
stable/6.4: [5293f466d41d6c2eaad8b833576ea3dbee630dc2]
stable/6.5: [eb07894c51c7d6bb8d00948a3e6e7b52c791e93e]

CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB write

Stable 5.10 was fixed.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/5.10: [a7d86a77c33ba1c357a7504341172cc1507f0698]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]
stable/6.5: [c8f292322ff16b9a2272a67de396c09a50e09dce]

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

