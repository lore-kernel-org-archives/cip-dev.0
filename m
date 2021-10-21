Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC120C433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Oct 2021 01:21:47 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web09.3344.1634779304731091169
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Oct 2021 18:21:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=sd8n8w02;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f42.google.com with SMTP id
 s18-20020a0568301e1200b0054e77a16651so10457275otr.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 20 Oct 2021 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4kVykhufqf15KN6jKmvfsCfFwAW3L/4k5ZGhRKipwu8=;
        b=sd8n8w02IkxYOvG7B91nzss00GL2WOpbmsLqqi036gSlge+TC9tby0xOpWWyziyVH9
         8fveoFtICGXdm5f9lq7HeYC/fmBQq62kplt+VWno2gSbEngo8t7B2gJoqE2j7XqjE/L5
         pI2/KwDbNFqBEMjB225NCSrwQvkbuA3pKqf6YO3WvqdHyw/90LGM/juRKszjjA/yJTXN
         eJi1DnXtKF+uK0hIlaj6PCxylBgiEBfAVvs/bW4rRuJom189hKkoVoS6z/HuN9zw5dkG
         xN+S4TOtSRUan72VH5vg8JQUti9puXsNUe22QOw4nVLahTxGZoGdCOpYAjajcX1lLUSN
         j/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4kVykhufqf15KN6jKmvfsCfFwAW3L/4k5ZGhRKipwu8=;
        b=hvN42kGRaqMNOYba1f6+ALvVEirDpd+KHlrx0ij+Xone6ieOgfM+GKtICAv95uAJgx
         KquraAwHRz+j0N3bI+uRTZPK+GX1RHWW5Y+5LRXY7UE/fRzWX4qCfPeUV4Z8uypWQAVK
         WnHnQzadmxjASum0JQRtfFARnd3vVSlsGXqJCBv/7r37+oEFkj0VfE1pEAKG+NwMoYvv
         v4vRW3aCp/lgJQxI/33FO1oYwQUkQicauVy4AvxVKfDD6IuLBpfCPdWnYInEcUYCmX8s
         xjAgzqiqvpN3l1qCDEhboEO4ga8gQzZ1zipXGgivywyMj9bT3ALEUjD63MhB00NAbfA0
         vKZw==
X-Gm-Message-State: AOAM533wmmnkJ/7ZN9J8nkdtQU4JKpV6TTW9WOasZKSC6rRUalVDnFx3
	bwVt2OUlRBEERT+CgAiNVllgDZaS/5IUHHqacHthfbijAlDzyg==
X-Google-Smtp-Source: 
 ABdhPJywWNZrcl8ys+tABE+ou+AiNGl82mMQrm6Nl9T8aHUo9onWS33SHHCvk5E1/Qq0Ok2OB7GIxgu6e4pCWNOguGE=
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr2301013otf.180.1634779303606;
 Wed, 20 Oct 2021 18:21:43 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Oct 2021 10:21:07 +0900
Message-ID: 
 <CAODzB9pMmbJugyNLdvOOifW1Tm+1NhnsUi+zQBdRaj3Z=aC+fw@mail.gmail.com>
Subject: New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: multipart/mixed; boundary="000000000000ada4af05ced2b76f"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Oct 2021 01:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6832

--000000000000ada4af05ced2b76f
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported 7 new CVEs.

* New CVEs

CVE-2021-20320: kernel: s390 eBPF JIT miscompilation issues fixes.

This bug is in BPF subsystem and s390 architecture specific. Patches
haven't been backported to 4.4 kernel. However, according to the
cip-kernel-config, it looks like no one uses s390, so can it ignore it
until someone backport patches?

CVSS v3 score is not provided.

Fixed status

mainline: [db7bee653859ef7179be933e7d1384644f795f26,
6e61dc9da0b7a0d91d57c2e20b5ea4fd2d4e7e53,
  1511df6f5e9ef32826f20db2ee81f8527154dc14]
stable/4.19: [ddf58efd05b5d16d86ea4638675e8bd397320930]
stable/4.9: [c22cf38428cb910f1996839c917e9238d2e44d4b,
8a09222a512bf7b32e55bb89a033e08522798299]
stable/5.10: [d92d3a9c2b6541f29f800fc2bd44620578b8f8a6,
4320c222c2ffe778a8aff5b8bc4ac33af6d54eba,
  ab7cf225016159bc2c3590be6fa12965565d903b]
stable/5.14: [7a31ec4d215a800b504de74b248795f8be666f8e,
6a8787093b04057d855822094d63d04a2506444a,
  a7593244dc31ad0eea70319f6110975f9c738dca]

CVE-2021-20321: kernel: In Overlayfs missing a check for a negative
dentry before calling vfs_rename()

CVSS v3 score is not provided.

A local attacker can escalate their privileges up to root via
overlayfs vulnerability.
Patch for 4.4 is applied
failed(https://lore.kernel.org/stable/163378772914820@kroah.com/). It
needs to modify the patch. I attached a patch, if it looks good, I'll
send it to the stable mailing list.

Fixed status

mainline: [a295aef603e109a47af355477326bd41151765b6]
stable/4.14: [1caaa820915d802328bc72e4de0d5b1629eab5da]
stable/4.19: [9d4969d8b5073d02059bae3f1b8d9a20cf023c55]
stable/4.9: [286f94453fb34f7bd6b696861c89f9a13f498721]
stable/5.10: [9763ffd4da217adfcbdcd519e9f434dfa3952fc3]
stable/5.14: [71b8b36187af58f9e67b25021f5debbc04a18a5d]
stable/5.4: [fab338f33c25c4816ca0b2d83a04a0097c2c4aaf]

CVE-2021-3847: low-privileged user privileges escalation

CVSS v3 score is not provided.

A Local attacker can escalate their privileges up to root by overlay
fs's vulnerability
(https://www.openwall.com/lists/oss-security/2021/10/14/3).

Fixed status

Not fixed yet.

CVE-2021-42252: soc: aspeed: lpc-ctrl: Fix boundary check for mmap

CVSS v3 score is not provided.

This bug has been introduced since 4.12-rc1. so all stable kernels are fixed.

Fixed status

mainline: [b49a0e69a7b1a68c8d3f64097d06dabb770fec96]
stable/4.14: [b1b55e4073d3da6119ecc41636a2994b67a2be37]
stable/4.19: [9c8891b638319ddba9cfa330247922cd960c95b0]
stable/5.10: [3fdf2feb6cbe76c6867224ed8527b356e805352c]
stable/5.14: [865f5ba9fdfc3ac6acabcac9630056ce99db600d]
stable/5.4: [2712f29c44f18db826c7e093915a727b6f3a20e4]

CVE-2021-20322: new DNS Cache Poisoning Attack based on ICMP fragment
needed packets replies

CVSS v3 score is not provided.

A flaw in the processing of the received ICMP errors (ICMP fragment
needed and ICMP redirect) in the Linux kernel functionality was found
that allows to quickly scan open UDP ports. This flaw allows an
off-path remote user to effectively bypassing source port UDP
randomization.
This flaw is similar to the previous CVE-2020-25705 (both DNS
poisoning attack based on ICMP replies for open ports scanning, but
other type of ICMP packets).

Commit 4785305c ("ipv6: use siphash in rt6_exception_hash()") fixes
35732d01 ("ipv6: introduce a hash table to store dst cache") which was
merged in 4.15-rc1.
stable/4.4 doesn't contain upstream commit 35732d01. stable/4.19
contains upstream commit 35732d01.

Commit 6457378f ("ipv4: use siphash instead of Jenkins in
fnhe_hashfun()") fixes d546c621 ("ipv4: harden fnhe_hashfun()") which
was merged in 3.18-rc1
stable/4.4 and stable/4.19 contain upstream commit d546c621.

Commit a00df2ca ("ipv6: make exception cache less predictible") fixes
35732d01 ("ipv6: introduce a hash table to store dst cache") which was
merged in 4.15-rc1.
stable/4.4 doesn't contain upstream commit 35732d01. stable/4.19
contains upstream commit 35732d01.

Commit 67d6d681 ("ipv4: make exception cache less predictible") fixes
4895c771 ("ipv4: Add FIB nexthop exceptions.") which was merged in
3.6-rc1.
stable/4.19 applied this patch at commit 3e6bd2b5. stable/4.4 applied
this patch at commit bed8941f.

Fixed status

mainline: [4785305c05b25a242e5314cc821f54ade4c18810,
6457378fe796815c973f631a1904e147d6ee33b1,
  a00df2caffed3883c341d5685f830434312e4a43,
67d6d681e15b578c1725bad8ad079e05d1c48a8e]
stable/4.19: [3e6bd2b583f18da9856fc9741ffa200a74a52cba]
stable/4.4: [bed8941fbdb72a61f6348c4deb0db69c4de87aca]
stable/4.9: [f10ce783bcc4d8ea454563a7d56ae781640e7dcb]
stable/5.10: [8692f0bb29927d13a871b198adff1d336a8d2d00,
5867e20e1808acd0c832ddea2587e5ee49813874,
  dced8347a727528b388f04820f48166f1e651af6,
beefd5f0c63a31a83bc5a99e6888af884745684b]
stable/5.14: [4785305c05b25a242e5314cc821f54ade4c18810,
6457378fe796815c973f631a1904e147d6ee33b1,
  55938482a1461a35087c6f3051f8447662889ea8,
4589a12dcf80af31137ef202be1ff4a321707a73]

CVE-2021-42739: A buffer overflow bug is found in the firewire subsystem

CVSS v3 score is not provided.

Patches have been sent to Linux Media mailing list but it hasn't been
merged in linux-media tree nor mainline yet. According to the
cip-kernel-config repo, no CIP member uses firewire driver.

Fixed status

Not fixed yet.

CVE-2021-34866: Linux Kernel eBPF Type Confusion Privilege Escalation
Vulnerability

CVSS v3 score is not provided.

A type confusion bug is found in eBPF subsystem which can leads a
local attacker escalates their privileges via this bug.
This bug was introduced in commit 457f44363a88 ("bpf: Implement BPF
ring buffer and verifier support for it") that has been merged since
5.8-rc1. so before 5.8 kernels aren't affected by this CVE.

Fixed status

mainline: [5b029a32cfe4600f5e10e36b41778506b90fd4de]
stable/5.10: [9dd6f6d89693d8f09af53d2488afad22a8a44a57]

* Updated CVEs

CVE-2020-29374: gup: document and work around "COW can break either way" issue

This bug has been fixed since 5.8-rc1. 4.4 and 4.9 have been fixed this week.
All stable kernels are fixed.

Fixed status

mainline: [17839856fd588f4ab6b789f482ed3ffd7c403e1f]
stable/4.14: [407faed92b4a4e2ad900d61ea3831dd597640f29]
stable/4.19: [5e24029791e809d641e9ea46a1f99806484e53fc]
stable/4.4: [58facc9c7ae307be5ecffc1697552550fedb55bd]
stable/4.9: [9bbd42e79720122334226afad9ddcac1c3e6d373]
stable/5.4: [1027dc04f557328eb7b7b7eea48698377a959157]

CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()

4.9 and 4.19 have been fixed this week. This bug was introduced in
4.6-rc1 therefore 4.4 doesn't affect.
All stable kernels are fixed.

Fixed status

mainline: [30e29a9a2bc6a4888335a6ede968b75cd329657a]
stable/4.14: [f34bcd10c4832d491049905d25ea3f46a410c426]
stable/4.19: [078cdd572408176a3900a6eb5a403db0da22f8e0]
stable/4.9: [4fd6663eb01bc3c73143cd27fefd7b8351bc6aa6]
stable/5.10: [064faa8e8a9b50f5010c5aa5740e06d477677a89]
stable/5.14: [3a1ac1e368bedae2777d9a7cfdc65df4859f7e71]
stable/5.4: [b14f28126c51533bb329379f65de5b0dd689b13a]


Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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

--000000000000ada4af05ced2b76f
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-ovl-fix-missing-negative-dentry-check-in-ovl_rename.patch"
Content-Disposition: attachment;
	filename="0001-ovl-fix-missing-negative-dentry-check-in-ovl_rename.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kv08uq5j0>
X-Attachment-Id: f_kv08uq5j0

RnJvbSAxZTQzYTA5MzNkZTFhYjg1M2YxNzFkZTQ1YTE3YjVmOWM0M2IxMTBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuZyBMaWFuZyA8emhlbmdsaWFuZzZAaHVhd2VpLmNvbT4K
RGF0ZTogRnJpLCAyNCBTZXAgMjAyMSAwOToxNjoyNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIG92
bDogZml4IG1pc3NpbmcgbmVnYXRpdmUgZGVudHJ5IGNoZWNrIGluIG92bF9yZW5hbWUoKQoKRnJv
bTogWmhlbmcgTGlhbmcgPHpoZW5nbGlhbmc2QGh1YXdlaS5jb20+Cgpjb21taXQgYTI5NWFlZjYw
M2UxMDlhNDdhZjM1NTQ3NzMyNmJkNDExNTE3NjViNiB1cHN0cmVhbS4KClRoZSBmb2xsb3dpbmcg
cmVwcm9kdWNlcgoKICBta2RpciBsb3dlciB1cHBlciB3b3JrIG1lcmdlCiAgdG91Y2ggbG93ZXIv
b2xkCiAgdG91Y2ggbG93ZXIvbmV3CiAgbW91bnQgLXQgb3ZlcmxheSBvdmVybGF5IC1vbG93ZXJk
aXI9bG93ZXIsdXBwZXJkaXI9dXBwZXIsd29ya2Rpcj13b3JrIG1lcmdlCiAgcm0gbWVyZ2UvbmV3
CiAgbXYgbWVyZ2Uvb2xkIG1lcmdlL25ldyAmIHVubGluayB1cHBlci9uZXcKCm1heSByZXN1bHQg
aW4gdGhpcyByYWNlOgoKUFJPQ0VTUyBBOgogIHJlbmFtZSgibWVyZ2Uvb2xkIiwgIm1lcmdlL25l
dyIpOwogIG92ZXJ3cml0ZT10cnVlLG92bF9sb3dlcl9wb3NpdGl2ZShvbGQpPXRydWUsCiAgb3Zs
X2RlbnRyeV9pc193aGl0ZW91dChuZXcpPXRydWUgLT4gZmxhZ3MgfD0gUkVOQU1FX0VYQ0hBTkdF
CgpQUk9DRVNTIEI6CiAgdW5saW5rKCJ1cHBlci9uZXciKTsKClBST0NFU1MgQToKICBsb29rdXAg
bmV3ZGVudHJ5IGluIG5ld191cHBlcmRpcgogIGNhbGwgdmZzX3JlbmFtZSgpIHdpdGggbmVnYXRp
dmUgbmV3ZGVudHJ5IGFuZCBSRU5BTUVfRVhDSEFOR0UKCkZpeCBieSBhZGRpbmcgdGhlIG1pc3Np
bmcgY2hlY2sgZm9yIG5lZ2F0aXZlIG5ld2RlbnRyeS4KClNpZ25lZC1vZmYtYnk6IFpoZW5nIExp
YW5nIDx6aGVuZ2xpYW5nNkBodWF3ZWkuY29tPgpGaXhlczogZTliZTlkNWU3NmUzICgib3Zlcmxh
eSBmaWxlc3lzdGVtIikKQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHYzLjE4ClNpZ25l
ZC1vZmYtYnk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgpSZWZlcmVuY2U6
IENWRS0yMDIxLTIwMzIxClNpZ25lZC1vZmYtYnk6IE1hc2FtaSBJY2hpa2F3YShDSVApIDxtYXNh
bWkuaWNoaWthd2FAY3liZXJ0cnVzdC5jby5qcD4KLS0tCiBmcy9vdmVybGF5ZnMvZGlyLmMgfCAx
MCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9kaXIuYyBiL2ZzL292ZXJsYXlmcy9kaXIu
YwppbmRleCBlZWRhY2FlODg5YjkuLjgwYmYwYWI1MmU4MSAxMDA2NDQKLS0tIGEvZnMvb3Zlcmxh
eWZzL2Rpci5jCisrKyBiL2ZzL292ZXJsYXlmcy9kaXIuYwpAQCAtODI0LDkgKzgyNCwxMyBAQCBz
dGF0aWMgaW50IG92bF9yZW5hbWUyKHN0cnVjdCBpbm9kZSAqb2xkZGlyLCBzdHJ1Y3QgZGVudHJ5
ICpvbGQsCiAJCX0KIAl9IGVsc2UgewogCQluZXdfY3JlYXRlID0gdHJ1ZTsKLQkJaWYgKCFkX2lz
X25lZ2F0aXZlKG5ld2RlbnRyeSkgJiYKLQkJICAgICghbmV3X29wYXF1ZSB8fCAhb3ZsX2lzX3do
aXRlb3V0KG5ld2RlbnRyeSkpKQotCQkJZ290byBvdXRfZHB1dDsKKwkJaWYgKCFkX2lzX25lZ2F0
aXZlKG5ld2RlbnRyeSkpIHsKKwkJCWlmICghbmV3X29wYXF1ZSB8fCAhb3ZsX2lzX3doaXRlb3V0
KG5ld2RlbnRyeSkpCisJCQkJZ290byBvdXRfZHB1dDsKKwkJfSBlbHNlIHsKKwkJCWlmIChmbGFn
cyAmIFJFTkFNRV9FWENIQU5HRSkKKwkJCQlnb3RvIG91dF9kcHV0OworCQl9CiAJfQogCiAJaWYg
KG9sZGRlbnRyeSA9PSB0cmFwKQotLSAKMi4zMy4wCgo=
--000000000000ada4af05ced2b76f--

