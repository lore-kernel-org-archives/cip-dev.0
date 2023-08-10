Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E2C001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 00:05:12 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.6672.1691625907129019579
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Aug 2023 17:05:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=p2z8For9;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1bb75afeee3so345789fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1691625906; x=1692230706;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+dmYgOfDBjxmb8odFD/0AWGaPSyYpfbvymkBMlviOoY=;
        b=p2z8For9JyCIwhozUMbxsqqxvS4I/8Rvp+/T7lMr9G/DUe9UG3nToIOGQJfHGyMtqd
         p945d7hfVdF1bGCnOf4F+MaaY8swfWCg8v5RieovoV3Ya2uS6U+4dHk55AsLNp9ryp/1
         haHEoNi6BlLf8ZJqt3R2cRwIJpxVJyOOGBzCQsLOyiOHChqBjTnr6vMBJcuRNBLHoxub
         Hn9cDYQUXQRkrxevv7zdbCbjjJp9BibMLtxoO4usSH41VLkX1S2f1BZOnEuLgLZDdt05
         N4p+5eYqcmh+bBTIal1WCkfX3JwqsmKGjBszCc0UfGt9GGxTncuW3nbf1siNBgD9NsSH
         X3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691625906; x=1692230706;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dmYgOfDBjxmb8odFD/0AWGaPSyYpfbvymkBMlviOoY=;
        b=HhmpaSKbNuZ/VtHOoLdgDWHHPEgQeoAdi0EtI+NCh7VYCfSBBUOW6E/mu360jPbUIF
         ySAZvdIx319O947yQqxUDBxFsrAztwp4kW2pdhizoiSGylNVEwTNyi3hDzbqtXkOpIrD
         HxvG9RPK8gKW3b8XIXY4dapY9C9qDloaZ89eoFFqSkpLre9NqQlDvnihY1PL5VBBMMmd
         7gkAkG+QhwbRSQWkUvDFVnL5QAF2xfBPp7Fsar8rBsSEkHr97sm0L8UVIffyH8Akp827
         klk5mUgv3YsBm5kAr8mHkdE9Dvr1uwNtajNPYu051HGSvJMTqBB/ujcnnbrTTm4YlIW0
         t2zg==
X-Gm-Message-State: AOJu0YxocmpQS58uOC9HltEpAQgNDWKuIYFYHXzfTvd0A7I1TxGadXcZ
	0K4dtc9xsnVGqp5fdK4nJpjrhURHfmlye1zpkZj5yAt+RdzzOPAcnFQ=
X-Google-Smtp-Source: AGHT+IHwjmischikIFLVCz/AVnzdYYDhMfX3CnSS/N00n7Jws97fI36HCcRNURfqGnJNEcoX+84oJhdZuo8bqqPknCo=
X-Received: by 2002:a05:6870:1793:b0:1bb:9bb3:b931 with SMTP id
 r19-20020a056870179300b001bb9bb3b931mr854022oae.41.1691625905634; Wed, 09 Aug
 2023 17:05:05 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Aug 2023 09:04:29 +0900
Message-ID: <CAODzB9ogtuZV-K1X8QZbi_9R8Z9ngGrE_bOyi31s-ADbggozyw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 00:05:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12586

Hi !

It's this week's CVE report.

This week reported 19 new CVEs and 1 updated CVEs.

There is a new speculative-execution vulnerability reported as CVE-2022-409=
82.
More details on the https://downfall.page/ .

Also, there is another AMD CPU specific bug called Inception(CVE-2023-20569=
).
More details on the https://comsec.ethz.ch/research/microarch/inception/ .

The Debian and Ubuntu assigned CVE-2022-3533 and CVE-2022-3606 to
libbpf package because they create libbpf package
from libbpf's upstream source not linux kernel. But NVD sets cpe to
linux kernel. So, we need to track this CVEs.

I think I'll create a script that get CVE information from NVD to
track such CVEs.

* New CVEs

CVE-2023-21400: io_uring: ensure IOPOLL locks around deferred work

CVSS v3 score is 6.7 MEDIUM.

In multiple functions of io_uring.c, there is a possible kernel memory
corruption due to improper locking. This could lead to local
escalation of privilege in the kernel with System execution privileges
needed. User interaction is not needed for exploitation.

The commit log said that

"""
No direct upstream commit exists for this issue. It was fixed in
5.18 as part of a larger rework of the completion side.
"""

I couldn't find actual fixed commit in 5.18 so added commit hash which
is tagged to 5.18.

Fixed status
stable/5.10: [810e401b34c4c4c244d8b93b9947ea5b3d4d49f8]
mainline: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f]

CVE-2022-3533: libbpf: Fix memory leak in parse_usdt_arg()

CVSS v3 score is 5.7 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(CNA).

A vulnerability was found in Linux Kernel. It has been rated as
problematic. This issue affects the function parse_usdt_arg
of the file tools/lib/bpf/usdt.c of the component BPF. The
manipulation of the argument reg_name leads to memory leak.
It is recommended to apply a patch to fix this issue. The associated
identifier of this vulnerability is VDB-211031.

This CVE was introduced by commit 0f86199 ("libbpf: Usdt aarch64 arg
parsing support") in 5.19-rc1 then fixed in v6.2-rc1

Fixed status
mainline: [0dc9254e03704c75f2ebc9cbef2ce4de83fba603]
stable/6.1: [13866e924a5760ee1ba9aa64dbfb5b44f4138c01]

CVE-2022-3606: libbpf: Fix null-pointer dereference in find_prog_by_sec_ins=
n()

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(CNA).

A vulnerability was found in Linux Kernel. It has been classified as
problematic. This affects the function find_prog_by_sec_insn
of the file tools/lib/bpf/libbpf.c of the component BPF. The
manipulation leads to null pointer dereference. It is recommended to
apply a patch to fix this issue. The identifier VDB-211749 was
assigned to this vulnerability.

This CVE was introduced by commit db2b8b0 ("libbpf: Support CO-RE
relocations for multi-prog sections") in 5.10-rc1 then fixed in
6.2-rc1.

Fixed status
mainline: [d0d382f95a9270dcf803539d6781d6bd67e3f5b2]
stable/5.10: [85b297d7986c64f36825020b848f09f0415f325a]
stable/5.15: [67061355776e9f95bf28097cc8a32bde428a6d80]
stable/6.1: [ecb0f3d7dd137828940d14b7706096a96b43d815]

CVE-2023-3777: netfilter: nf_tables: skip bound chain on rule flush

CVSS v3 score is not provided.

This bug was introduced by commit d0e2c7d ("netfilter: nf_tables: add
NFT_CHAIN_BINDING") in 5.9-rc1.
Before 5.9 kernels are not affected.

CVE-2023-3777, CVE-2023-3995, and CVE-2023-4147 are introduced by same comm=
it.

Fixed status
mainline: [6eaf41e87a223ae6f8e7a28d6e78384ad7e407f8]
stable/5.10: [30e5460d69e631c0e84db37dba2d8f98648778d4]
stable/5.15: [10013f764ad2957de08968bd02870b6b7683e3f6]
stable/6.1: [e18922ce3e3169eb97838d1dcba2d679bcca446c]
stable/6.4: [ab87c6b43822a56ae0aadc715364b5f8d4a96037]

CVE-2023-3995: netfilter: nf_tables: disallow rule addition to bound
chain via NFTA_RULE_CHAIN_ID

CVSS v3 score is not provided.

This bug was introduced by commit d0e2c7d ("netfilter: nf_tables: add
NFT_CHAIN_BINDING") in 5.9-rc1.
Before 5.9 kernels are not affected.

Fixed status
mainline: [0ebc1064e4874d5987722a2ddbc18f94aa53b211]
stable/5.15: [5bee91121ccea8d69cea51632e9a1dd348ee49a1]
stable/6.1: [268cb07ef3ee17b5454a7c4b23376802c5b00c79]
stable/6.4: [14448359681062bf51d9c67e0264869548b79853]

CVE-2023-4015: netfilter: nf_tables: skip immediate deactivate in _PREPARE_=
ERROR

CVSS v3 score is not provided.

This bug was introduced by commit 4bedf9e ("netfilter: nf_tables: fix
chain binding transaction logic") in 6.4.
This patch was backported to 5.10, 5.15, and 6.1. So 4.4, 4.14, 4.19,
and 5.4 are not affected.

Fixed status
mainline: [0a771f7b266b02d262900c75f1e175c7fe76fec2]
stable/5.15: [98bcfcaecc76c4be288278c213b47d36292f40fa]
stable/6.1: [4237462a073e24f71c700f3e5929f07b6ee1bcaa]
stable/6.4: [027d00132487bcf2a4ee7493bb8de9d6331d48e3]

CVE-2023-4132: smsusb: use-after-free caused by do_submit_urb()

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.5 MEDIUM(CNA).

A use-after-free vulnerability was found in the siano smsusb module in
the Linux kernel.
The bug occurs during device initialization when the siano device is plugge=
d in.
This flaw allows a local user to crash the system, causing a denial of
service condition.

Commit ebad8e73 ("media: usb: siano: Fix use after free bugs caused by
do_submit_urb") fixes a use-after-free bug in
do_submit_urb(). Commit 6f489a9 fixes a bug that was introduced by ebad8e73=
.

Linux 4.19 backported ebad8e73 ("media: usb: siano: Fix use after free
bugs caused by do_submit_urb") but
6f489a9 ("media: usb: siano: Fix warning due to null work_func_t
function pointer") is not yet.

Fixed status
mainline: [ebad8e731c1c06adf04621d6fd327b860c0861b5,
6f489a966fbeb0da63d45c2c66a8957eab604bf6]
stable/4.19: [1477b00ff582970df110fc9e15a5e2021acb9222]
stable/5.10: [42f8ba8355682f6c4125b75503cac0cef4ac91d3,
d87ef4e857b790f1616809eccda6b4d0c9c3da11]
stable/5.15: [114f768e7314ca9e1fdbebe11267c4403e89e7f2,
784a8027b8ac5a876d71cb3d3d4d97b2b6cb5920]
stable/5.4: [a41bb59eff7a58a6772f84a5b70ad7ec26dad074,
d485150c9a52167a6175f542397a098b4cd89dc9]
stable/6.1: [479796534a450fd44189080d51bebefa3b42c6fc,
8abb53c5167cfb5bb275512a3da4ec2468478626]
stable/6.4: [ebad8e731c1c06adf04621d6fd327b860c0861b5,
ae65238d3f5a2df48341a7112820e04fb1017422]

CVE-2023-4133: cxgb4: fix use after free bugs caused by circular
dependency problem

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.5 MEDIUM(CNA).

A use-after-free vulnerability was found in the cxgb4 driver in the
Linux kernel.
The bug occurs when the cxgb4 device is detaching due to a possible
rearming of the flower_stats_timer from the work queue.
This flaw allows a local user to crash the system, causing a denial of
service condition.

This bug was introduced by commit e0f911c ("cxgb4: fetch stats for
offloaded tc flower flows") in 4.15-rc1.

Fixed status
mainline: [e50b9b9e8610d47b7c22529443e45a16b1ea3a15]

CVE-2023-4134: Input: cyttsp4_core - change del_timer_sync() to
timer_shutdown_sync()

CVSS v3 score is not provided.

A use-after-free bug was found in the Cypress TrueTouch Gen4 Touchscreen Dr=
iver.
This bug was introduced by commit 17fb156 ("Input: cyttsp4 - add core
driver for Cypress TMA4XX touchscreen devices") in 3.11-rc1.

Fixed status
mainline: [dbe836576f12743a7d2d170ad4ad4fd324c4d47a]
stable/6.4: [28dc11949357f10712bd641b724ab373a92318de]

CVE-2023-4147: netfilter: nf_tables: disallow rule addition to bound
chain via NFTA_RULE_CHAIN_ID

CVSS v3 score is not provided(NIST).
CVSS v3 score is 7.8 HIGH(CNA).

A use-after-free bug was found in the netfilter subsystem, if bail out
with EOPNOTSUPP when adding rule to bound chain via
NFTA_RULE_CHAIN_ID. This bug was introduced by commit d0e2c7d
("netfilter: nf_tables: add NFT_CHAIN_BINDING")in 5.i-rc1.
Before 5.9 kernels are not affected.

Fixed status
mainline: [0ebc1064e4874d5987722a2ddbc18f94aa53b211]
stable/5.15: [5bee91121ccea8d69cea51632e9a1dd348ee49a1]
stable/6.1: [268cb07ef3ee17b5454a7c4b23376802c5b00c79]
stable/6.4: [14448359681062bf51d9c67e0264869548b79853]

CVE-2023-4194: tap: tap_open(): correctly initialize socket uid next
fix of i_uid to current_fsuid

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.5 MEDIUM(CNA).

A flaw was found in the Linux kernel's TUN/TAP functionality. This
issue could allow a local user to bypass network filters and gain
unauthorized access to some resources. The original patches fixing
CVE-2023-1076 are incorrect or incomplete. The problem is
that the following upstream commits - a096ccca6e50 ("tun:
tun_chr_open(): correctly initialize socket uid"),
- 66b2c338adce ("tap: tap_open(): correctly initialize socket uid"),
pass "inode->i_uid" to sock_init_data_uid() as the last
parameter and that turns out to not be accurate

Both commits a096ccca6e50 and 66b2c338adce are not exists in 4.x
kernels so these kernels aren't affected by this CVE.

Fixed status
mainline: [9bc3047374d5bec163e83e743709e23753376f0c,
5c9241f3ceab3257abe2923a59950db0dc8bb737]

CVE-2023-4205: UBSAN: OOB in do_journal_end with the fail of
array-index-out-of-bounds in fs reiserfs

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.5 MEDIUM(CNA).

An out-of-bounds memory access flaw was found in the Linux kernel=E2=80=99s
do_journal_end function when the fails
array-index-out-of-bounds in fs/reiserfs/journal.c could happen. This
flaw allows a local user to crash the system.

Fixed status
Not fixed yet

CVE-2023-4155: KVM: SEV: only access GHCB fields once

CVSS v3 score is not provided.

KVM guest using SEV-ES or SEV-SNP with multiple vCPUs can exploit a
vulnerability, invoking recursive VMGEXIT
handler through a double fetch race condition.The issue arises from a
shared GHCB page used by sev_handle_vmgexit()
and sev_es_validate_vmgexit(), allowing quick swapping of values and
bypassing validation.
Although exploiting recursion in the Linux kernel has been feasible,
the impact is mitigated by stack guard pages,
yet attackers could potentially trigger a DoS or guest-to-host escape
in kernel configurations without stack guard pages.

This CVE was introduced by commit 291bd20 ("KVM: SVM: Add initial
support for a VMGEXIT VMEXIT") in 5.11-rc1.

Fixed status
mainline: [7588dbcebcbf0193ab5b76987396d0254270b04a]

CVE-2022-40982: Downfall vulnerability

CVSS v3 score is not provided.

Downfall attacks exploit a major weakness in modern processors used in
personal and cloud computers, enabling data theft between users
sharing the same system.
CVE-2022-40982 is the identified vulnerability that allows malicious
apps to steal sensitive data like passwords and banking details.
Memory optimization features in Intel processors inadvertently expose
internal hardware registers, leading to the vulnerability exploited
through
Gather Data Sampling (GDS) and Gather Value Injection (GVI) techniques.

Fixed status
mainline: [8974eb588283b7d44a7c91fa09fcbaf380339f3a,
553a5c03e90a6087e88f8ff878335ef0621536fb,
  53cf5797f114ba2bd86d23a862302119848eff19,
81ac7e5d741742d650b4ed6186c4826c1a0631a7,
  1b0fc0345f2852ffe54fb9ae0e12e2ee69ad6a20]
stable/4.14: [cdc2724c9d060a8fa9652a9aa6347d8324f6cd82,
74a10924f5b5b7b997745be50595129a418b8b4d,
  c9a54e5b917ea4c365e47ccb183d903df940eb94,
2f17bdaa6f1c15d1a17bdc3fa26bc3598b22ae95,
  3c385319a284829b9c669e46908c474845002581]
stable/4.19: [ecc9d725a30dc53046f3739be9b7ac800d66c11b,
047ac82a3a9792264ec261f8812a14df28f28302,
  c3188cac78ced4eafdc4280feaeb08a47585151d,
6c18fb3d9d3876a709b43c42c8d45a8a4e5ca6f0,
  edb21f8093a187c9e17acb507900eaab80e516df,
c0f82528e7afa445c5e8d67e2a7615e1ed87aa00,
  15f5646fd2dbfa7298216418d383be36b470d01b,
b698b5d11a169b4d41d7afe488ab3c408e39e5bc,
  504aece3f6bcf88b31a809b3bbbe6b1931f78d18,
ecc68c37bba469401a2cdc1a73661c31ef014742,
  82f4acbce852b4795c32d38be2b164af27d1d125,
211ec614c9f107dfd1c3a1c14d097be474bb6b53,
  7c7bb95ece11a94b9fa1cf117cf27ce6324bbe3b,
542dac06335106f81149ae96577f28d6123506e0,
  2323f105866e6a456b219b9e3cde53d560464c43,
e81494b7259b6b1ab81a9f9be3385b4aa99a7a59,
  91e24758cd8e53b030146fbe7ff5c2b258e60c66,
0461f6027566f1bc68c7de160213813d340abf75,
  1af834f2f4f824fd36130d3efe52922aec5a852c,
64f142253bd20cf39de9f931bb910f0e6de0d268,
  b8d22bdfef99923c3727950ae4158ee07ecc8740]
stable/5.10: [6e606e681873b37aa252486d43be4cf007544e85,
e5eb18e164d08986543f8259d0cc10e120fb8746,
  c0fff20d4efa3bdb3ef203a8ae6e703e0c010199,
12d93c6c98d5478128d90ad4fbdf705753a0197e,
  1cd3fc18eb169e2f81a34eeaf8147f9395ee8a11,
75bb54c951e92714a50cdc063f9953d11e8d36a2,
  3c45134b38b417d17103f1f0b9a8b32f98ac358c,
2edb3b39ca793bf13a123ea6a25da640be36e7a5,
  b05031c2bca790afed717bc59cde2dac722efb94,
bf2fa3a9d0e65326917273d17a8e9c6880d7b97c,
  09658b81d158c15112a56323d8db8fed83e8cd4a,
18fcd72da1ed6166f1cbb03f713bed50c839fc22,
  7a2f42bce9ab23fb9e59fe6de45bfedb5d611eee,
2462bc3ef0611646d94658ff250bb16669347361,
  4ae1cbb730bd574d57d3996d4c20974972d47009,
288a2f6bc1ce03ddb3f05fd8c79b00d5d7160b4a,
  363c98f9cfa8124cc49b2dfc5d48666b138f7e2e,
7db4ddcb8d8e356387a773728b2479d390488b1e,
  eb13cce488745176db654b20ea438f4b5b91ab9c,
583016037a092e4189c86bad7946c6d88669b4ca,
  f076d081787803b972a9939e477c6456f0c8fd70,
6ee042fd240fb669f4637f8cd89899b15911e5df,
  1ff14defdfc9180bfcfd76a70463a5feb188a5db,
79972c2b95eca5e7d3d237d728339b21e9075629,
  6750468784314bc8a336f80493cd82cde2afa655]
stable/5.15: [348a89e2018428c3e55a87cdd9ae3cbd6cc8248a,
0cc5643b63aef90165488dabaeff92697925baa6,
  59d78655f808eb82a103f0fb79df9aa20ee2c7c1,
348741a9e4d37d83024b45acce9b65233127f8b2,
  0242a8bdef560523b5d81f5979854266092ab0a6]
stable/5.4: [f68f9f2df68e246548bdc1a2279c55f98c4ca473,
e35c6579436504435c04f6908c364a9a37e353e8,
  ed56430ab2532bf5c91e91e9b4eb9d094d0f36fa,
e56c1e0f91343007dbeb5e05e0b09f5c9e8a5560,
  3e21d8b0f3a9c0acc8d4f0d6829efbdad4157830]
stable/6.1: [d5501f2ff80d30d615d59531825d3a5f0bb0d35d,
7918a3555a2502a4d86b831da089f3b985d1bca9,
  e2e06240ae4780977387906e2e11774283ca7997,
403e4cc67e4cf9226c57a7cb27c7f4365d2143b7,
  08e86d42e2c916e362d124e3bc6c824eb1862498,
489ae02c89936c7e40f04191e8c160ac53649526,
  6a90583dbd9b794071b8b54d8c36f40a459d1051,
84f585542ec69226311be5a4500a4b3cbad6fb5b,
  ce97072e10cc844fac8176681b2cb17bf3eaaa7b,
8beabde0ed8d31e45a3d9484f0591a18c0c94cc7,
  a3342c60dcc58007cc14b2cf1ebc7e2b563423a8,
8183a89caf67a1f56f1da1d6081e26a0ae7a5fdf,
  b0837880fa65fa4a6dc407b42e9b33e18f7b44e3,
c956807d8462e94a1450dc0737728c25917b1d67,
  9e8d9d399094dd911059ff337dd8a104f052e1ca,
e26932942b2c505d5e8a9f263cbe66de4fab1b24,
  f25ad76d92176f41a543a812972e9937ce4f7d08,
c66ebe070d9641c9339e42e1c2d707a5052e9904,
  92fc27c79bc7f3e2bfd2b88e197762566daf02a1,
c04579e95492dff342cb4976dd2f5728c0f87eee,
  b6fd07c41b4c64faff368728cef13439ee62860d,
baa7b7501e41344f95da0bd3042dd04110d58edb,
  7f3982de36c6620c2faae6fd960fa4021d71e16a,
d972c8c08f96518ff02efd87c4fef594a833f6ea,
  9ae15aaff39c831e2f9d8b029e85a2d70c7c8a68,
e0fd83a193c530fdeced8b2e2ec83039ffdb884b,
  051f5dcf144aa7659c4f4be04c66c3eda9b1bad3,
dacb0bac2edb649ce01c25da9f8898769516d716]
stable/6.4: [ff0642207e24f9a7011e8982ab7da1e16db75a38,
c73393948612b24b1298c6a4bf88276d5216648e,
  4da542e6b2bbcb05305de5c3bfd52bcfa0a3b93e,
6f29afbba8fc7f79790add4725a78064791bbd50,
  7be4a6b1128c2d6136c591b055b834d81198749e]

CVE-2023-20569: Speculative Return Stack Overflow (SRSO)

CVSS v3 score is not provided.

A side channel vulnerability on some of the AMD CPUs may allow an
attacker to influence the return address prediction.
This may result in speculative execution at an attacker-controlled
address, potentially leading to information disclosure.

AMD published vulnerability information on their security page.
https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7005.html

Fixed status
mainline: [0e52740ffd10c6c316837c6c128f460f1aaba1ea,
fb3bd914b3ec28f5fb697ac55c4846ac2d542855,
  79113e4060aba744787a81edb9014f2865193854,
1b5277c0ea0b247393a9c426769fde18cff5e2f6,
  233d6f68b98d480a7c42ebe78c38f79d44741ca9,
d893832d0e1ef41c72cdae444268c1d64a2be8ad,
  238ec850b95a02dcdff3edc86781aa913549282f,
3bbbe97ad83db8d9df06daf027b0840188de625d,
  5a15d8348881e9371afdf9f5357a135489496955]
stable/5.10: [baf6d6c39e2390ef91bec12d057294dd507d1115,
437fa179f2136d349fda78331fd28696e40def9d,
  9b7fe7c6fbc007564f97805ff45882e79f0c70d0,
073a28a9b50662991e7d6956c2cf2fc5d54f28cd,
  34f23ba8a399ecd38b45c84da257b91d278e88aa,
3f9b7101bea1dcb63410c016ceb266f6e9f733c9,
  df76a59feba549825f426cb1586bfa86b49c08fa,
e47af0c255aed7da91202f26250558a8e34e1c26,
  4acaea47e3bcb7cd55cc56c7fd4e5fb60eebdada,
384d41bea948a18288aff668b7bdf3b522b7bf73,
  4873939c0e1cec2fd04a38ddf2c03a05e4eeb7ef,
8457fb5740b14311a8941044ff4eb5a3945de9b2]
stable/6.1: [dfede4cb8ef732039b7a479d260bd89d3b474f14,
dec3b91f2c4b2c9b24d933e2c3f17493e30149ac,
  ac41e90d8daa8815d8bee774a1975435fbfe1ae7,
9139f4b6dd4fe1003ba79ab317d1a9f48849b369,
  98f62883e7519011bf63f85381d637f65d7f180e,
79c8091888ef61aac79ef72122d1e6cd0b620669,
  c9ae63d773ca182c4ef63fbdd22cdf090d9c1cd7,
c7f2cd04554259c2474c4f9fa134528bc2826b22,
  77cf32d0dbfbf575fe66561e069228c532dc1da9,
4f25355540ad4d40dd3445f66159a321dad29cc8]

CVE-2023-21264: KVM: arm64: Implement do_share() helper for sharing memory

CVSS v3 score is not provided.

This bug was introduced by commit e82edcc ("KVM: arm64: Implement
do_share() helper for sharing memory") in 5.17-rc1.

The commit e82edcc introduced a new helper function to establish
shared-memory regions between components.
It uses pte for host-initiated memory transition but it wasn't good
way to do so.

Fixed status
mainline: [09cce60bddd6461a93a5bf434265a47827d1bc6f]

CVE-2023-34319: xen/netback: Fix buffer overrun triggered by unusual packet

CVSS v3 score is not provided.

An unprivileged guest can cause Denial of Service (DoS) of the host by
sending network packets to the backend, causing the backend to crash.

It introduced by commit ad7f402 ("xen/netback: Ensure protocol headers
don't fall in the non-linear area") in 6.1.
This commit was backported to all stable kernels(include cip/4.4,
cip/4.4-rt, cip/4.4-st).

Fixed status
mainline: [534fc31d09b706a16d83533e16b5dc855caf7576]
stable/4.14: [e1142d87c185c7d7bbf05d175754638b5b9dbf16]
stable/4.19: [11e6919ae028b5de1fc48007354ea07069561b31]
stable/5.10: [f9167a2d6b943f30743de6ff8163d1981c34f9a9]
stable/5.15: [b14a3924c2675c22e07a5a190223b6b6cdc2867d]
stable/5.4: [bc7b9a6c2ca42b116b0f24dbaa52b5a07d96d1d6]
stable/6.1: [fa5b932b77c815d0e416612859d5899424bb4212]
stable/6.4: [cf482893f721f76ac60c0a43482a59b2f194156b]

CVE-2023-20588: x86/CPU/AMD: Do not leak quotient data after a division by =
0

CVSS v3 score is not provided.

A division-by-zero error on some AMD processors can potentially return
speculative data resulting in loss of confidentiality.

Affected CPUs are listed on the AMD's security advisory page
(https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7007.htm=
l).

Fixed status
mainline: [77245f1c3c6495521f6a3af082696ee2f8ce3921]

CVE-2023-4273: exfat: check if filename entries exceeds max filename length

CVSS v3 score is not provided (NIST).
CVSS v3 score is 6.0 MEDIUM (CNA).

A flaw was found in the exFAT driver of the Linux kernel. The
vulnerability exists in the implementation of the file name
reconstruction function, which is responsible for reading file name
entries from a directory index and merging file name
parts belonging to onefile into a single long file name. Since the
file name characters are copied into a stack variable,
a local privileged attacker could use this flaw to overflow the kernel stac=
k.

The exfat_get_uniname_from_ext_entry() doesn't check filename length
so it will overwrite more thant max filename length.
This function was introduced by commit ca06197 ("exfat: add directory
operations") in 5.7-rc1.

Fixed status
mainline: [d42334578eba1390859012ebb91e1e556d51db49]

* Updated CVEs

CVE-2023-1206: hash collisions in the IPv6 connection lookup table

The mainline, 5.15, 6.1, and 6.4 were fixed.

Fixed status
mainline: [d11b0df7ddf1831f3e170972f43186dad520bfcc]
stable/5.15: [ecb741a17cb2abf693b34d8e05a1e7e40494afb6]
stable/6.1: [51aea7e9d5212adb8a3d198510cfcde4125988f9]
stable/6.4: [1e50c11ed44e28a57c6215a5e7643ae85c6297fa]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

