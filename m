Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C4AC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 01:36:07 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web08.4430.1644456965967976637
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Feb 2022 17:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=xd7oC54Q;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id r27so4461965oiw.4
        for <cip-dev@lists.cip-project.org>;
 Wed, 09 Feb 2022 17:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3jTKdMwGyC6ZZWevV87ZK8vb0gSps9sRRNZZmrK9hf0=;
        b=xd7oC54QDSGgatOf907FxXj/vCiNF/JQClpPwFqSkNW2TveMVZEkr4WewSa+3lonon
         +m5pkpnAa6Oh0Z+8aq+WUZJaT+I2/wDL/J1lMyHzvHYCYcNzi+qTsh7wKq/VDnolXxlA
         0YMwpevNPTdEySRgYbZyBCUboUBxsH2vR8z7mMB0BmIQpo/VJTLfzqACDVUXX07qSXZt
         im7qvFXqWd6fczQ4AcVQDrEVCkgQLEKJM0Pl82bd/m9qqSidOgXMGTZa9mJzbP0bBviy
         +OGPKn0d1/cooqh/3p6Ofqn6FmgGkOafN64GZmHARIDioVqz6FEl7S3qT04w+gfipSap
         RnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3jTKdMwGyC6ZZWevV87ZK8vb0gSps9sRRNZZmrK9hf0=;
        b=cKlWp1lEJgV+tnxSa1CkF66wD8Nml0i/ZmEbxJfsZVDkQGsvlH82rsQ0dODKjBr/7u
         pK0A4Ov22XorAvi1mgjwdlfVEszFN2VVnQohgDYl6hGj+ncd/0K44G5fgvVASY0b3Skm
         YNSuNtFBERioShRU6hMTC9iy3Ndb0lgs+7TnJ8eE6uG02jh4yRu8Qqa7Cw5n1wCQ4yJj
         TepMAOFv8HOkM24xqCVqATcWYtcgP1GOKpwd60ZvcJias9X1XkrRR9V2YDjPyw8WroNM
         TvhtIkEi/UfJNzscfzcWz0mpxnsfTbM+P9/1jygUe1ocv1jFAqep69EOUQbfQRb7uEMc
         aUgA==
X-Gm-Message-State: AOAM531Jrozv5l3mG/aVnYlr0GR+upKzMtuGsH3MXpQ/HzOCylDoVVIf
	6sbh6PZjVnUzPvtMThbVC6X+COwRvx3VNBowCeBZMpOPfFJ78g==
X-Google-Smtp-Source: 
 ABdhPJyxqGq8XSmcKTU2Bl1wrJ0o2jBda1F3eeYCe8cHutRQNjZVTd0yRr3Q9WuzJSwb7d24YAaCnWPTjKMFkge0Pds=
X-Received: by 2002:aca:1011:: with SMTP id 17mr75810oiq.27.1644456964695;
 Wed, 09 Feb 2022 17:36:04 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Feb 2022 10:35:28 +0900
Message-ID: 
 <CAODzB9q=mZ-SdrAZJzgLBCn9pJ+GnDha6JcjqvKOAuYxRvUkyw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: multipart/mixed; boundary="0000000000003ae2b205d79ff921"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Feb 2022 01:36:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7588

--0000000000003ae2b205d79ff921
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported 5 new CVEs.

* New CVEs

CVE-2021-3894: sctp: local DoS: unprivileged user can cause BUG()

CVSS v3 score is not provided

A local unprivileged user can cause local DoS by sctp subsystem.
The commit a2d859e3fc97 ("sctp: account stream padding length for
reconf chunk") may fix this issue.

Fixed status

Not fixed yet.

CVE-2022-0487: Use after free in moxart_remove

CVSS v3 score is not provided

UAF bug was found in moxart_remove() in drivers/mmc/host/moxart-mmc.c.
The mainline was fixed. Stable kernels are being reviewed.

Apply patch bd2db32 ("moxart: fix potential use-after-free on remove
path") to 4.4 needs to a bit modify code. However, it seems no CIP
member enables CONFIG_MMC_MOXART.

Fixed status

mainline: [bd2db32e7c3e35bd4d9b8bbff689434a50893546]

CVE-2022-0492: cgroup-v1: Require capabilities to set release_agent

CVSS v3 score is not provided

There was a bug in cgroups v1 release_agent feature to escalate
privilege and bypass namespace isolation.
The mainline and 5.X series were fixed but failed to applied the fix
to all 4.X series. This issue is affected to 2.6.24-rc1 or later
version.

Applying the commit 24f6008 ("cgroup-v1: Require capabilities to set
release_agent") depends on the following commits.

- a3ff937 ("prefix-handling analogues of errorf() and friends ")
This commit was introduced at 5.6-rc1. It added invalfc macro to
include/linux/fs_context.h. 5.4 uses cg_invalf macro which calls
invalfc in it.

- 8d2451f ("https://github.com/torvalds/linux/commit/8d2451f4994fa60a57617282bab91b98266a00b1").
This commit was introduced at 5.1-rc1. It added cgroup1_parse_param().

So 4.X series do other way to fix this issue (e.g.
https://lore.kernel.org/stable/20220209191248.652388187@linuxfoundation.org/).
4.9, 4.14, and 4.19 are being reviewed.

4.X series use struct cgroup_namespace to get namespace object which
was introduced at 4.6-rc1. So fixing 4.4 needs the other way to get
namespace object instead of struct cgroup_namespace.

Fixed status

mainline: [24f6008564183aa120d07c03d9289519c2fe02af]
stable/5.10: [1fc3444cda9a78c65b769e3fa93455e09ff7a0d3]
stable/5.15: [4b1c32bfaa02255a5df602b41587174004996477]
stable/5.16: [9c9dbb954e618e3d9110f13cc02c5db1fb73ea5d]
stable/5.4: [0e8283cbe4996ae046cd680b3ed598a8f2b0d5d8]

CVE-2022-24448: NFSv4: Handle case where the lookup of a directory fails

CVSS v3 score is not provided

Server returns uninitialized data in the file descriptor in nfs_atomic_open().
The mainline and stable kernels are fixed.

I attached 0001-NFSv4-Handle-case-where-the-lookup-of-a-directory-fa.patch
for 4.4.y.

Fixed status

mainline: [ac795161c93699d600db16c1a8cc23a65a1eceaf]
stable/4.14: [516f348b759f6a92819820a3f56d678458e22cc8]
stable/4.19: [b00b4c6faad0f21e443fb1584f7a8ea222beb0de]
stable/4.9: [8788981e120694a82a3672e062fe4ea99446634a]
stable/5.10: [ce8c552b88ca25d775ecd0a0fbef4e0e03de9ed2]
stable/5.15: [4c36ca387af4a9b5d775e46a6cb9dc2d151bf057]
stable/5.16: [f0583af88e7dd413229ea5e670a0db36fdf34ba2]
stable/5.4: [0dfacee40021dcc0a9aa991edd965addc04b9370]

CVE-2022-0480: memcg: enable accounting for file lock caches

CVSS v3 score is not provided

A user can cause host memory exhaustion becase of memcg doesn't limit
the number of POSIX file locks.
This issues was fixed in 5.15-rc1.

Patch cannot be applied to 4.4 because this fix uses SLAB_ACCOUNT flag
which was introduced by commit 230e9fc ("slab: add SLAB_ACCOUNT flag
") at 4.5-rc1 is not backported to 4.4.

Fixed status

mainline: [0f12156dff2862ac54235fc72703f18770769042]

* Updated CVEs

CVE-2018-25020: bpf: fix truncated jump targets on heavy expansions

This issue was fixed in 4.17-rc7. 4.14 was fixed this week.

Fixed status

mainline: [050fad7c4534c13c8eb1d9c2ba66012e014773cb]
stable/4.14: [6824208b59a4727b8a8653f83d8e685584d04606]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

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

--0000000000003ae2b205d79ff921
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-NFSv4-Handle-case-where-the-lookup-of-a-directory-fa.patch"
Content-Disposition: attachment;
	filename="0001-NFSv4-Handle-case-where-the-lookup-of-a-directory-fa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kzgb55bp0>
X-Attachment-Id: f_kzgb55bp0

RnJvbSA5MTJjNmUyMmNmODJhYTViYjYzZTVmMjdhM2EzOTQ5MGU3NThmN2FiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+CkRhdGU6IFRodSwgNiBKYW4gMjAyMiAxODoyNDowMiAtMDUwMApTdWJqZWN0
OiBbUEFUQ0hdIE5GU3Y0OiBIYW5kbGUgY2FzZSB3aGVyZSB0aGUgbG9va3VwIG9mIGEgZGlyZWN0
b3J5IGZhaWxzCgpJZiB0aGUgYXBwbGljYXRpb24gc2V0cyB0aGUgT19ESVJFQ1RPUlkgZmxhZywg
YW5kIHRyaWVzIHRvIG9wZW4gYQpyZWd1bGFyIGZpbGUsIG5mc19hdG9taWNfb3BlbigpIHdpbGwg
cHVudCB0byBkb2luZyBhIHJlZ3VsYXIgbG9va3VwLgpJZiB0aGUgc2VydmVyIHRoZW4gcmV0dXJu
cyBhIHJlZ3VsYXIgZmlsZSwgd2Ugd2lsbCBoYXBwaWx5IHJldHVybiBhCmZpbGUgZGVzY3JpcHRv
ciB3aXRoIHVuaW5pdGlhbGlzZWQgb3BlbiBzdGF0ZS4KClRoZSBmaXggaXMgdG8gcmV0dXJuIHRo
ZSBleHBlY3RlZCBFTk9URElSIGVycm9yIGluIHRoZXNlIGNhc2VzLgoKUmVwb3J0ZWQtYnk6IEx5
dSBUYW8gPHRhby5seXVAZXBmbC5jaD4KRml4ZXM6IDBkZDJiNDc0ZDBiNiAoIm5mczogaW1wbGVt
ZW50IGlfb3AtPmF0b21pY19vcGVuKCkiKQpTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+ClNpZ25lZC1vZmYtYnk6IEFubmEgU2No
dW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAuY29tPgpbRml4IG1lcmdlIGNvbmZsaWN0IGlu
IG5mc19hdG9taWNfb3BlbigpLl0KUmVmZXJlbmNlOiBDVkUtMjAyMi0yNDQ0OApTaWduZWQtb2Zm
LWJ5OiBNYXNhbWkgSWNoaWthd2EoQ0lQKSA8bWFzYW1pLmljaGlrYXdhQGN5YmVydHJ1c3QuY28u
anA+Ci0tLQogZnMvbmZzL2Rpci5jIHwgMTMgKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGly
LmMKaW5kZXggYmE3ZTk4ZDhjZTA5Li43YzFmODM2MzJkNjMgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9k
aXIuYworKysgYi9mcy9uZnMvZGlyLmMKQEAgLTE1NzcsNiArMTU3NywxOSBAQCBvdXQ6CiAKIG5v
X29wZW46CiAJcmVzID0gbmZzX2xvb2t1cChkaXIsIGRlbnRyeSwgbG9va3VwX2ZsYWdzKTsKKwlp
ZiAoIXJlcykgeworCQlpbm9kZSA9IGRfaW5vZGUoZGVudHJ5KTsKKwkJaWYgKChsb29rdXBfZmxh
Z3MgJiBMT09LVVBfRElSRUNUT1JZKSAmJiBpbm9kZSAmJgorCQkgICAgIVNfSVNESVIoaW5vZGUt
PmlfbW9kZSkpCisJCQlyZXMgPSBFUlJfUFRSKC1FTk9URElSKTsKKwl9IGVsc2UgaWYgKCFJU19F
UlIocmVzKSkgeworCQlpbm9kZSA9IGRfaW5vZGUocmVzKTsKKwkJaWYgKChsb29rdXBfZmxhZ3Mg
JiBMT09LVVBfRElSRUNUT1JZKSAmJiBpbm9kZSAmJgorCQkgICAgIVNfSVNESVIoaW5vZGUtPmlf
bW9kZSkpIHsKKwkJCWRwdXQocmVzKTsKKwkJCXJlcyA9IEVSUl9QVFIoLUVOT1RESVIpOworCQl9
CisJfQkKIAllcnIgPSBQVFJfRVJSKHJlcyk7CiAJaWYgKElTX0VSUihyZXMpKQogCQlnb3RvIG91
dDsKLS0gCjIuMzUuMQoK
--0000000000003ae2b205d79ff921--

