Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB0CA5FC4
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 22:32:04 +0000 (UTC)
Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3232.1790807514697752158
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 15:31:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=n6GNRyak;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756f62025aso2451109d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790807514; cv=none;
        d=google.com; s=arc-20260327;
        b=nf8xBu1DRPVlrVLh6OnFJCLUJ2RiabATEXhj5DJMT821vMjV5z4hjY2BRmGDeKmHcQ
         mrwCotCU+dVvxp0jQISR75oVRejtyDQqftBEGliOluv+1VOcY0LShcTXw/HIMWBncFhr
         U4nhPHcnCOhBi3Ph08eqmO0uLwnsxhe0XYM+qEmuxYxyuc07BrOKOb0hJ79QE6ICRc5t
         GIFx7hje27fzHMJvSL/RqPiHIjE3yAtoRzPDyYftadVK/YVwvcO3xEyxdB7xM99fvCzI
         29ZqQBOLags1apqvrMAiIcEohlaQLNDSBESsfnklPoQpGrIgOpv5kL2FcQL35s4yoNwi
         W0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=08tLlCNVYi8jxggO21cnGJQYfmzdKWRl0R5ODWbGtVU=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=C62c+firFl/D8PNLFeuoivrVnPSdsSN7rxiPxigX44shY1zl5IKWNdaecLxMbR5zq5
         AwsfFcIiTdZBelv984WsGtzc9w+BQSPoQvepvMzleaY4fsLS55eYipVngwkVy71OYrn5
         kS5TpYELGob74SeugHBb+TjJESadY2wdeKN5Mc3lX2p3H/Plh7GtCJSEzo+kDAC+ZOiy
         DUktsQZqk9AHdKE6FdBn5eb5ZaEf3z0KefMtPR1WGHFrZ7hvHGdz9nHziudSJtiuulDu
         3F+8+UKwMj7fncF4N27zX3TdcjL+kan7Wnq+VZroJJQaVySB/PHqyj1yyRuY1UR3uau3
         Gq/Q==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1790807514; x=1791412314; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=08tLlCNVYi8jxggO21cnGJQYfmzdKWRl0R5ODWbGtVU=;
        b=n6GNRyakWBt63AAaRuDC6hcVjI+0365JMZ4WzvbfNMX4U+f4X6TlgrYk134B2uI0om
         ihvBT1q+0peGs2SgBW8uUpLZj0xqK1AwWYjdfbxvFu2XXo8yc3d54gftdNp4PZPdigzB
         eCdvhINkD8g9QP7MnNljqVA3Cm2j0CFgEwQJ9pggbtjwi1dOjBsCowcSH3uHL12P5lIO
         7ZYYazsQ+AJWMRjMIKm3rucL94C50sIPQrXKcbRvS1goL3dQrAd+ehJvFljHmGMI+wqk
         UT4THANPZPu07ZJ33ooy6YvDt5N5r1rEYLx7LB7VcMIdkRN+9ZK4m37FWyv8ZAOVdsR+
         1ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807514; x=1791412314;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08tLlCNVYi8jxggO21cnGJQYfmzdKWRl0R5ODWbGtVU=;
        b=kmzI7algI71rMZWYNzPs24CeLqMY0Y5AclK/dOmdP5cmArAWgMgtj6tDJuA2ki8S2C
         CP0pgfdgPIeSfawnN6DckVz+nAtz9XIP/EuGK1+RfbIsb+LrRmQToEUJDhuMQVuGwZxC
         XtSZ0HNOcDl9uwgzfvZ3eLgEv+YILYL7JRVgEXuMYepOaEbQ9iWOV4Lo2vh/+CMSv11D
         PFV2uZl1Z/uTg6CeX7/38vxYRP7O+ygXXIUxv3YggLVilIeDZU2I1dSBylK3J+2VR2uK
         K4c5UeP508BOLMyhkZtQIMVMDHshy45AJY6I29VzcGDzJJwB24mYUMOyCCh3ybqzUdi/
         /dsA==
X-Gm-Message-State: AFq9FYL92zQ2NugwhABoYDHC4Hrv7l7+cdGU0svXDfJ/RnZ/Smt4FzAw
	f//2vci4EL7y4+olX/rAtD2IrmzZPK4XYaKMlo7svlTBlNCOqiVc93nMaSe4u8UU5RrKSRrj2UE
	zKCl9x4DhxhUSUqnpimjExJWT+pfnWOFHGXg0TjrxbLza/HzYaiEE4wZLWw==
X-Gm-Gg: AYBFou3NQlJ0ghms09/HcusKoZvaoeEOcYnUZuieT42XAyoKO7aqE/cTTgx6zkKBltt
	nd03XxBjLkmglCmqKwpLlSUFOygHLWKN62AjSEIdKJ2xZ67ftIAZTB0TrvWeW466x870JcsGUzb
	910Gr8jtkYKA75ex3AOFM3rcj6Of+AoCGliVPw+vK0pue9t67lxeNTmVICFsC3G0Nm7r7VsTe7S
	J/qkS4s7OrvQsm5X58/oOCCbY9bx3Vui5vN2xMUIVoIqc0Q+Ih3RC4U5D01BKRi3Z7zFpxCoUU6
	UYheGhuAzCYGxU1cbF7UIRiFdDk+DRaFDqedg0LhMLAJI4pZ1gSzsKv3HK943xa7zUoiXinotPY
	yX3mo+o5HM9YUDq3GZkhzW8m+F08=
X-Received: by 2002:a05:690e:4885:10b0:676:82f3:e5ac with SMTP id
 956f58d0204a3-676834c8244mr895297d50.29.1790807508385; Wed, 30 Sep 2026
 15:31:48 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Oct 2026 07:31:11 +0900
X-Gm-Features: AclHuK8Jrw_0DicBX3DZeyywaXGEclqEHLZUppeOBb7g-HXkLivE7JTQfWHd8r4
Message-ID: <CAODzB9p76ZiOMEejXKrjPTO2Li2=MK251_kPeVwWHrf6+K9f1w@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 22:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24390

Hi!

It's this week's CVE report.

This week reported 608 new CVEs and 4 updated CVEs.

* New CVEs
CVE-2026-93205: iommu/arm-smmu-v3: Manage teardown with devm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93205

According to the .vulnerable file, this bug was introduced by commit
395ad89 in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bd22a0d40503a65d243b011de146603c8ce1cbc]
stable/6.12: [981686f4137760a16a03c5193f11d85133533f93]
stable/6.18: [2235eafda9b3df9295efd0593cd4a8977440c3f6]
stable/7.2: [78fd5a2d65f3546cb4285f8e52f445baecbd00e0]

CVE-2026-93206: PCI/proc: Use file_ns_capable() when checking config
space read access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93206

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f82f53e75eff382fc8f56b73279b54f7cf5a5c65]
stable/5.10: [8a3a54aa3e65ed76f8560a387243a7738ae0cb1c]
stable/5.15: [5c7ab4ca66f0880cffc3735555ea719dd5253726]
stable/6.1: [53407535d49ec034e476121020b5c878f0d92e18]
stable/6.12: [77272b7fd0e472086fd626a1fcd11da625822cc2]
stable/6.18: [c2d4174f492458ecdcdef309243624999612d526]
stable/6.6: [e7730acd6a01c5931a3afb83639810ff2fb9cc92]
stable/7.2: [6351e94076329dab517ea94c115e15c4d8459381]

CVE-2026-93207: SUNRPC: Zero rpc_gss_wire_cred at
svcauth_gss_decode_credbody() entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93207

Introduced by commit b0bc534 ("SUNRPC: Convert the
svcauth_gss_accept() pre-amble to use xdr_stream") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11539e8fcce0b0af062ae5fecf7b3676c2f7aeed]
stable/6.12: [0e18641708eaa8bc3c1ff338cd844aeadbd52bac]
stable/6.18: [e0778464049b0238f2915a40007a4154f86cf351]
stable/6.6: [56b29d62017c7dd1718d060dd5b3a2ce61095d0c]
stable/7.2: [0fa8a8acae57e6373962741d5b06d13f44aba6a9]

CVE-2026-93208: kasan: fix cache shrink race with CPU hotplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93208

Introduced by commit 07d067e ("kasan: fix sleeping function called
from invalid context on RT kernel") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8790303cbaac52a11dfed4aab261f8ea60682525]
stable/6.12: [709c3646545e0a1f99a5816384c633f6552c5a98]
stable/6.18: [30e8cb8598aa41b1b9f8803081d2ae5e5369c0f3]
stable/6.6: [7cd164f0e1bab0f8dd125c92ed4f19bbd6b92a4a]
stable/7.2: [3119d58e4ef8719d669911d38a53fc00086ac48b]

CVE-2026-93209: Bluetooth: hci_core: use skb_get() instead of
skb_clone() for req_skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93209

Introduced by commit 2615fd9 ("Bluetooth: hci_sync: Fix overwriting
request callback") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [f5afdff569a09d1cb8cf19826199d024725576cb]
stable/6.1: [0337fb092873a4146aa854acb554675b49c8f6b5]
stable/6.12: [d7723320db4c9cb9ec2b9a36140e6c641dd77814]
stable/6.18: [d0b28e9655f4b3195210627577f81883dc1d0162]
stable/6.6: [d5eef0747071934a1c080ee617fa4fd3566394c5]
stable/7.2: [26f66d5b8a5663af498f7ccc94fc79fb47a2191f]

CVE-2026-93210: smb: client: harden DFS cache against invalid target hints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93210

According to the .vulnerable file, this bug was introduced by commit
54be1f6 in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf86c08123c6ab8c61cc0be1dad7540db93738ff]
stable/6.1: [a48328afbc3f63e3b9de8827e2e16c15b17976f7]
stable/6.12: [66dbcdbb0cadffd12eb8f2b115fd57d384c5109d]
stable/6.18: [846f0709559b9e27024e126a80bc7afb76516912]
stable/6.6: [6cb7f9fed8f40f28fbd464ca99c946951afc0952]
stable/7.2: [7e32da6047d9afdae8dd17b87b4c8d97363c4ee2]

CVE-2026-93211: nfsd: initialize DRC hash table before registering shrinker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93211

Introduced by commit 8eea99a ("nfsd: dynamically allocate the
nfsd-reply shrinker") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0c58934f5cc4f05b63ef6605dd10c1d0d489e88]
stable/6.12: [f060f43a67635dbb393bf5dcbfc3e8b9a44942cb]
stable/6.18: [b57bd8cb739cb3cf88bdb1a5903a42a707a5c282]
stable/7.2: [431c70ca5163c98c746f22f16cd58ca5aefec6dc]

CVE-2026-93212: nfsd: guard nfsd_serv deref in nfsd_file_net_dispose

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93212

Introduced by commit ffb4025 ("nfsd: Don't leave work of closing files
to a work queue") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f1ddfc8cb9076592401a611eb3a44d36186d014]
stable/6.12: [f4776c1c4b38fbc459420321c8ece87d0f7f95fb]
stable/6.18: [59baf45a06435194005fc5fa9a42d89f77a30432]
stable/7.2: [766170b4fd2daaf5c4d6735560101474e18edab6]

CVE-2026-93213: of: fix out-of-bounds read in of_alias_scan() stem parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93213

Introduced by commit 611cad7 ("dt: add of_alias_scan and
of_alias_get_id") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bb01c657ff9fc807c2c592ca18af34c4fc3bc6f]
stable/5.10: [fd0c7bbda81c0e0c1cb7b68d267b87371584f560]
stable/5.15: [958d7ee9fcf008ef9d2072c6410ee1bf6abf3b64]
stable/6.1: [f7f6c3e32a31f2e1ed12075e8cd22b370a84e67a]
stable/6.12: [96a9c984dd7c3589a2707a32b62802f98311dbfd]
stable/6.18: [9253cfc5a85be1494ce56b4fc6f2d2b509440910]
stable/6.6: [da7a80ddc610a19b0378016a4d816b9355f013a7]
stable/7.2: [acd1b49043366f43e932308b4db7d3ce568eeadb]

CVE-2026-93214: usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93214

Introduced by commit 4bb8548 ("usb: gadget: f_tcm: add configfs
support") in v4.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dbf74f4022f80f7669d2b3c22c5deb46c1b5674]
stable/5.10: [abad5daa41cf5d0a0a9cba0397d3a0e7f11e0277]
stable/5.15: [3639438a4c83ffc2e564c8c010b92137c5d11cfa]
stable/6.1: [78a14ea2284825055ab6c2a1f3489510f560f3a2]
stable/6.12: [f81a2da137b029a282b9bc64d2f267d242948659]
stable/6.18: [6bcd9ee6ad6989d1d85a7459687e45b7ad7568d9]
stable/6.6: [eef3e62f90d86c1c5651742f84ecc9db1814a893]
stable/7.2: [d90b0f90e30cd59b36005a4016b15cf02bcd7fb2]

CVE-2026-93215: cdx: Fix double free when sysfs file creation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93215

Introduced by commit aeda33a ("cdx: create sysfs bin files for cdx
resources") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f4acc3a3c300e174e3f586b97b04ed8f5948c36]
stable/6.12: [88f4cd42a04bdadd189d7f667a4c279f4e962ca6]
stable/6.18: [4cd24873ab9fdbd730604881a6e8087bc7b99336]
stable/7.2: [7e9451bf0bdba6daee1eaf4e7566612af6ca1c32]

CVE-2026-93216: mm/page_owner: use memcg_data snapshot to avoid TOCTOU
in print_page_owner_memcg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93216

Introduced by commit fcf8935 ("mm/page_owner: print memcg
information") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90f095b816e25c6a9e4446d299bac5007fdcb3df]
stable/7.2: [46761406e14381dc35f498c247a87565b87ea2ef]

CVE-2026-93217: mm/madvise: skip device-private PMDs in cold and pageout walks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93217

Introduced by commit 368076f ("mm/huge_memory: add device-private THP
support to PMD operations") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4b76d0b03cb49611312ecc4bcfb55ccdf0843e2]
stable/7.2: [5c0d7b658cda62cd17cb3652783386d5608030ef]

CVE-2026-93218: mm/huge_memory: skip device-private PMDs in
madvise_free_huge_pmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93218

Introduced by commit 368076f ("mm/huge_memory: add device-private THP
support to PMD operations") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce579dcf730ce5ed8043a5eeea18a3e6706a97e5]
stable/7.2: [5e3026bf736498115884d6c7bd0308ba29e0474c]

CVE-2026-93219: clocksource/drivers/timer-sun4i: Advertise a real minimum delta

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93219

Introduced by commit 12e1480 ("clocksource: sun4i: Report the minimum
tick that we can program") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d21808328225ab8cee46885bf9a0dffcefbe630e]
stable/5.10: [0cc4b14d7401d50e53a01f1554147ee075ee6943]
stable/5.15: [53a3bc024b8e5d284468cce84957cded5f859f98]
stable/6.1: [753a220084dfc4d737f2ab9eaddc9a01a397edd7]
stable/6.12: [151eb52f8712017c8f7b00bb2305e8916cb9e3dc]
stable/6.18: [bf38be01d43c4e4ca903aff7236d8486a950a252]
stable/6.6: [ebba4d0aeba0e8eb3a9676380fc2652de8ab1c44]
stable/7.2: [f0efafcdf6eec1f3361bfd8c811420198f55c8bb]

CVE-2026-93220: sched_ext: Keep kick_sync waiting on the rq's own CPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93220

Introduced by commit 4c95380 ("sched/ext: Fold balance_scx() into
pick_task_scx()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0253dd04beb03e79477c5ef4768b11135687206]
stable/7.2: [c736ea0fe7b4df920da6bd43a81c5eeecadcc8be]

CVE-2026-93221: nfsd: convert nfsd_net boolean flags to unsigned long flags word

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93221

Introduced by commit 362063a ("nfsd: keep a tally of RECLAIM_COMPLETE
operations when using nfsdcld") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11a5fe42e1811f793e04ef885b639ea7668f439d]
stable/7.2: [df5922fe09a8131c793ffa86adf204999b0470f8]

CVE-2026-93222: signal: avoid shared siginfo namespace rewrites

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93222

Introduced by commit 7a0cf09 ("signal: Correct namespace fixups of
si_pid and si_uid") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d19cdc167e696714509e87d3f7ae765b6e164589]
stable/5.10: [e015d1ac6b43a23c52c5163299414ae77d7d4ae0]
stable/5.15: [4ee7c4e4719a825052f42f02ec159b5b42b68fbc]
stable/6.1: [148b0dae2a1755beb873a2aab51fb191414f068c]
stable/6.12: [03c8761e75d1619906bb503686f9cc1dfc6a67f4]
stable/6.18: [a246da20c8e4ae4319511c698b9f26ad0ad1769f]
stable/6.6: [6b1de022304ef85284c5933a5fb8492f6f54efc9]
stable/7.2: [b655c2040ce836afad5643842543567b31f8c11d]

CVE-2026-93223: staging: media: tegra-video: fix of_node_put() on VIP
parse errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93223

Introduced by commit e740d19 ("staging: media: tegra-video: add
support for Tegra20 parallel input") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7393372f79db940acff206b43e2905685a0c57ad]
stable/6.12: [1295ba29ac590bbb5c4a586afd408018168af10b]
stable/6.18: [656d047dc0c29c0964d840217a0593f16aa9bc5e]
stable/6.6: [a3783800c9475fa58b8db0885893f96a23f949da]
stable/7.2: [fc9937019cf7e2fe4e29f9341e6400bcd2cde721]

CVE-2026-93224: svcrdma: Fix unmatched rn_unregister on failed accept

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93224

Introduced by commit 8ac6fca ("svcrdma: Unregister the device if
svc_rdma_accept() fails") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [26190394c64c9429481fc88a4738f70bb92fb352]
stable/6.12: [0335800071a6dfdf7d21d729b5e7d8fa98936211]
stable/6.18: [5aabe070c00e5bdf4ab150fb5f72ad5f266d6241]
stable/7.2: [45a444a17240f4fa2235f0dfd4a96fc80f1eb2c2]

CVE-2026-93225: phy: fsl-imx8mq-usb: fix typec switch leak on probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93225

Introduced by commit b58f0f8 ("phy: fsl-imx8mq-usb: add tca function
driver for imx95") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87a1805b1c346b092c34f96f3806f207792910e1]
stable/6.18: [f1b7b2c7ffa9711d1298f52790b377fe02efc1db]
stable/7.2: [84646f5b945a370f6999eed59a334387b0abc282]

CVE-2026-93226: ipv6: use RCU iterator to dump route exceptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93226

Introduced by commit 1e47b48 ("ipv6: Dump route exceptions if
requested") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47cdab0d51aaa9bd85f8e4904585bd5bd4df4488]
stable/5.10: [dffbfb3117138e8e0e09d05f507bd36ca1f696e5]
stable/5.15: [6bd3f94ed858f2d072627546b4cdf712b0f8ea88]
stable/6.1: [9c6be625e1a7258e845d6193b3b6b084a00f8e9e]
stable/6.12: [eda56ee17713f9dd834b922f7dbfa2e25fa6358c]
stable/6.18: [a602cd128d17a793e12888edc8eda85821ede7e1]
stable/6.6: [3665abc3d2ae8a78cb67f858e848481432ec75db]
stable/7.2: [f6b1b15848fd91fe122dac0d19d3d666e35075b6]

CVE-2026-93227: mm/mm_init: deferred_grow_zone(): fix out-of-range
first_deferred_pfn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93227

Introduced by commit 3acb913 ("mm/mm_init: use
deferred_init_memmap_chunk() in deferred_grow_zone()") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97090500d776c3f6d08e857e3a0a7cf092999094]
stable/6.18: [45489d4f95802903ab35799b400b346fa4e13151]
stable/7.2: [84339578c2d6936ac3a93cd1f0bbaa3468a988f2]

CVE-2026-93228: svcrdma: Reject Write/Reply chunks with segcount 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93228

Introduced by commit 78147ca ("svcrdma: Add a "parsed chunk list" data
structure") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9808eb7656666acc7291bae9ab6b987bd16e47e0]
stable/6.12: [fe533ae1bed2ef2b3d54ee7ab410da1874ed3d4f]
stable/6.18: [a798714b58041e88716db3bf8fb03ae13eecd54a]
stable/7.2: [45dbdb2637b7fc5f1355b588780d2a7fb0516805]

CVE-2026-93229: nfsd: add missing read barrier to rpc_status_get
dumpit seqcount retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93229

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a71f161a857117e8e0264deb7d14fff5c98adcf5]
stable/6.12: [f501f2f4ec1d2dfe39e21c98630314074a9b30b0]
stable/6.18: [1aea0482b98ecd7d0249204665f2ad4ad517f66b]
stable/7.2: [9b5f6475006cd8e3b5b99b8eb3cd74dbb1ce9df8]

CVE-2026-93230: mm/hugetlb: initialize gigantic bootmem hugepage
struct pages earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93230

Introduced by commit fde1c4e ("mm: hugetlb: skip initialization of
gigantic tail struct pages if freed by HVO") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1b7c045e808c761b1cc8c19b3040fadedda3fef]
stable/6.18: [09505232eced5f1c42902d8f28740f070c3fc6dc]
stable/7.2: [29968bc7aefb3cf1e72aa7c5f52697a6b0527094]

CVE-2026-93231: lockd: fix swapped arguments in nlmsvc_match_ip()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93231

Introduced by commit 4373ea8 ("lockd: unlock lockd locks associated
with a given server ip") in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9060689f49dc663e9a3d069c4a65ff63a836e66]
stable/6.18: [0d72e78c9d38d5377a059a4837f82b65b91cdcf6]
stable/7.2: [21bcb609e0ab1dd60f39ca3498f85808933bcc9f]

CVE-2026-93232: mm/hugetlb: fix boot panic with CONFIG_DEBUG_VM and
HVO bootmem pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93232

Introduced by commit 622026e ("mm/hugetlb: remove fake head pages") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0caeceb0c3899dc42844d3979093b27d1434108]
stable/7.2: [2ddf429e25cf8415d9c308f07e64012026bd4d77]

CVE-2026-93233: drm/nouveau/dmem: fix callocated underflow on large folio split

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93233

Introduced by commit c322874 ("gpu/drm/nouveau: enable THP support for
GPU memory migration") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2256c044a1df39c8aad4dd2d6f709b2533e2d7a]
stable/7.2: [0163b92946d0a7c816f619c57a4d9867954dd106]

CVE-2026-93234: drm/gud: validate TV mode names before creating enum property

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93234

Introduced by commit 40e1a70 ("drm: Add GUD USB Display driver") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1ea35fea67ad841f4ada28dd61b41be65e5437]
stable/5.15: [676f1fb3632bbc9ce83be7938e93fe6bfc9510fd]
stable/6.1: [06fcaf21c18ac88f57fee3803554f48c6026b95f]
stable/6.12: [70cffc31a380b3eae45027101647aa94c242aa0e]
stable/6.18: [72a95df6bbc7d20c7af1e39d86b3e910cccd01ad]
stable/6.6: [082e378886547b5b1c4075ed307f7c68547868dc]
stable/7.2: [eab46d9629807db1b5647d17227e16110a18227f]

CVE-2026-93235: f2fs: fix to zero post-EOF data when extending file size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93235

According to the .vulnerable file, this bug was introduced by commit
fbfa2cc in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eced87b7d19dbc76ebdddaf322046f9ac582fcb]
stable/6.12: [32c7f11a24268ba8d3bb50ea7f54d33f698cd253]
stable/6.18: [91ec55ddc097ccddd25ffb95a3d079b2ef362372]
stable/6.6: [6882d458d2e403f6ba7b45542dd31a6b7531eb2e]
stable/7.2: [c42608c09b6b5d5967bf211c255914c068c2cde1]

CVE-2026-93236: media: meson: vdec: fix NULL pointer deref in
vdec_try_fmt_common

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93236

Introduced by commit 3e7f51b ("media: meson: add v4l2 m2m video
decoder driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20aa934ace6917262ff579a73ec018d06a7bad1c]
stable/5.10: [276f28672bb6d5d5feca78db4219c7b5adf1be26]
stable/5.15: [c620906fb1b2ad75d408ea9d06040d66952d4a31]
stable/6.1: [3839b6be2279fc4f558723f2c0fbfc9c42070958]
stable/6.12: [f2375a308640e401c142c5426d52c3d10e016d25]
stable/6.18: [96dafbae77f50bfe2228bcfedcd8652c5e5f08e8]
stable/6.6: [680a89683197cdfe4e03e6fd7755454c647d39c1]
stable/7.2: [d61ba609c3226af3c84268ba606ea06ee63e511b]

CVE-2026-93237: LoongArch: Add DIRECT_MAP_PHYSMEM_END definition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93237

According to the .vulnerable file, this bug was introduced by commit
7b09f5a in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2677f97a67fdbc62a82ce1faa67791f54451d36f]
stable/6.18: [ab275a23b4d9f04ca6c2f5f6a3246194e045a761]
stable/7.2: [55e18311c705cceef6c34d522ea387b1f0069bab]

CVE-2026-93238: s390/vfio-ap: fix potential use of uninitialized
apm_filtered bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93238

Introduced by commit eeb386a ("s390/vfio-ap: handle config changed and
scan complete notification") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf09b9d7cd7890bc3a3b7eb63d5ece15f88bfde7]
stable/6.12: [f73db632524320d2b93bc8534be8ea875053502d]
stable/6.18: [6d554f2571e6b4db242593ba561efd6a6d1f99a9]
stable/6.6: [4ba8a08f5f26ed59f356a6318bca3aa7cc0af3e2]
stable/7.2: [09548edc6114f1eb1035b30795e893204ef45b85]

CVE-2026-93239: arm64: mm: Fix the lockless page-table walk in show_pte()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93239

Introduced by commit 1d18c47 ("arm64: MMU fault handling and page
table management") in v3.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a77644d009dece1104b6fcc6e322b0e4503db0d6]
stable/6.12: [b28fe65a36b8209b6adcf2722c7ce974cf9ac8d1]
stable/6.18: [68cbd70795dd8c06e7ccdc4eb0b74c5b180076c3]
stable/6.6: [08d931a0a850ad16a64f2cd23a19f40795cdbdf7]
stable/7.2: [0f05d95b99164a9ccc4cf4a4920e0ff0228138ad]

CVE-2026-93240: memcg: make the v1 soft limit knob inert

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93240

According to the .vulnerable file, this bug was introduced by commit
e9d4e1e in v6.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3417097fb107cea3358b19bcbb4eb655fd67f8c]
stable/6.12: [72fb67f6e0e5d78e4f34cf9929d1afdb0fd54203]
stable/6.18: [0a90e268cce7023f34087bfa4affb42e29ff5f45]
stable/7.2: [5ec8f629a300cc40e746d6178f724bdff7683fa7]

CVE-2026-93241: memcg: bypass the reclaim and oom killer for dying
tasks once oom_reaper is done

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93241

According to the .vulnerable file, this bug was introduced by commit
a75ffa2 in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b0d1083364fc8e7cc2f7d1f93ee3ee78f4d52f7]
stable/6.18: [801bcbdbfd595cc7f0de95f2802b5596c8971315]
stable/7.2: [d44c3c5986c7a4a5f913a813e18cda08a838f91b]

CVE-2026-93242: scsi: qla2xxx: Fix response queue over-consumption in
__qla_consume_iocb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93242

Introduced by commit fac2807 ("scsi: qla2xxx: edif: Add extraction of
auth_els from the wire") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ba019bdd89d931499d9476456b5d9c7ab7fa753]
stable/5.15: [a136c311676fd1010b1bde3bcfd410caa2fa040f]
stable/6.1: [d841707fafba5f80341b82e8c3a4c24fc5aa5132]
stable/6.12: [bd1534d4afab47f13dfc27fff6f59dd859a0ac3a]
stable/6.18: [31715d1e1cbf3a37ce3452635c5602f73fd7abd4]
stable/6.6: [6e3f129538c32d0019437197735912308c161843]
stable/7.2: [df86c27cf1ba9d66f737a1fa56479c6e7efafe4e]

CVE-2026-93243: mm/secretmem: properly account locked pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93243

Introduced by commit 1507f51 ("mm: introduce memfd_secret system call
to create "secret" memory areas") in v5.14-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97d34aa65c29cca85e3e9050f4c936389b38a054]
stable/6.18: [853043cb129473ff2fa0090602be944d96b9d5c9]
stable/7.2: [3b4f72bdddff69819d665395376329ef21f37a06]

CVE-2026-93244: drm/sysfb: simpledrm: Improve stride validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93244

Introduced by commit 7bfa5c7 ("drm/simpledrm: Compute linestride with
drm_format_info_min_pitch()") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df6533f11688aa30be3bb883c7637f4ffdbb7cbd]
stable/6.18: [6892f0a2f6b5990b9572ba043dd14dd4df6bb3f0]
stable/7.2: [bbdc6761c55662fb9ddf5ab580acb616131998fe]

CVE-2026-93245: apparmor: policy_int make sure list heads are
initialized before fail path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93245

Introduced by commit fe6bb31 ("apparmor: split out shared policy_XXX
fns to lib") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3daad923a8685adb66087e0d819559b7eb6ba975]
stable/5.10: [88ba930e7d0586ca2700757249f1e6fc0bbab0fc]
stable/5.15: [ee017ef9aa2cf20d85d4a20c09ef3db9fb240310]
stable/6.1: [62f159fac76468dbbfd977f4f18472d4a01e8d74]
stable/6.12: [4a09a5e6512a3792c78ae8e3ca79cb55a11eed57]
stable/6.18: [5449f715f24e86648f8cc8fba8d97ff6b5d04981]
stable/6.6: [0664c75afe87a1d7d4f4e1d7eecf50ad829fb6e8]
stable/7.2: [dd52ab1c5436be86f5b8ca118fa8e5d61d63ffed]

CVE-2026-93246: octeontx2-af: fix out-of-bounds read setting MSI-X irq affinity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93246

Introduced by commit 4e527f1 ("octeontx2-af: npc: cn20k: Add new
mailboxes for CN20K silicon") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d5df98369c5f45710b786499f8bd7ffc3196433]
stable/7.2: [2f460aa0211e97c011ef0cfe5016f8f2a2ed059b]

CVE-2026-93247: Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93247

Introduced by commit 2935e55 ("Bluetooth: hci_sync: fix double free in
'hci_discovery_filter_clear()'") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [59eecbe2f2f38d8f3e1104bd11da97f9a2c58998]
stable/6.1: [f02c01ccd12cb2b8a290077d4c90f29a6e109b16]
stable/6.12: [18fda026a13c5abd6c1e0dfd3549f490b73378fb]
stable/6.18: [c3f63610bceaa182e4683b23cc47baf36b5f1496]
stable/6.6: [bbd262d2d750b67b15a5e1008d3848309c87e7a7]
stable/7.2: [ee2135a14fb2a3e176149122764d293f0796b1eb]

CVE-2026-93248: drm/xe: don't WARN on kernel job timeout when device
already wedged

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93248

Introduced by commit 5a2f117 ("drm/xe: Do not wedge device on killed
exec queues") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13087ad7817e6e5f210064518bfc4d6d58a9c2f3]
stable/7.2: [24d81b72992006f9c390f1fc85c7f991e6d06fd6]

CVE-2026-93249: spi: amlogic-spisg: Make sure clk_init_data is fully initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93249

Introduced by commit cef9991 ("spi: Add Amlogic SPISG driver") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2702908ee23ef31bfcf241a2e07ace0eb76bd71]
stable/6.18: [bfce0f324efaa605e606cbb3f0bdb8fe5c910c11]
stable/7.2: [5969a3df8361a0e20379a308c2313d3e263123de]

CVE-2026-93250: vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93250

Introduced by commit a3a48de ("vxlan: mdb: Add MDB control path
support") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc2dc66a6693a78f8c1e6ca2dbebd50f16e2c366]
stable/6.12: [c7dc26d06f90ca11bbd6114f6a62a67d038816c7]
stable/6.18: [3e6b705bc162fc7257645725a7d2cf6c71250318]
stable/6.6: [f8a9b988e7a7bc674e74e8c901794d792c35689e]
stable/7.2: [f26400b325bdc2868e40612c4804c82cf8ba6275]

CVE-2026-93251: ACPI: bus: Introduce acpi_bus_get_primary_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93251

According to the .vulnerable file, this bug was introduced by commit
91e5687 in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72530e1f72b0515a73fd88292254d04fecf03649]
stable/7.2: [5657859851abb65105220a6cdb5804926249f714]

CVE-2026-93252: ocfs2: fix circular locking dependency in ocfs2_init_acl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93252

Introduced by commit 16c8d56 ("ocfs2/acl: use 'ip_xattr_sem' to
protect getting extended attribute") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [bd7c05fb4a4776dff5a87b19008d28458647d15d]
stable/5.10: [4936d4464d1ae10b5fbba64374085a0dcc060560]
stable/5.15: [caf3056936fb8b5ce92e419cf8b246ce9c437343]
stable/6.1: [5b7b3c50c39ad0dc27e7418981e01c4183273f89]
stable/6.12: [8931403ee3dcfe8a24a5267efec9d9460ab7a1b5]
stable/6.18: [f8747d81aa6d3efe3ee339a9d912ff3ca6e4d758]
stable/6.6: [8d88f52fbbbcc18adf4091a955511d0cf605bf11]
stable/7.2: [1222f7a3183b35c0c566899fdaead5c7c4043076]

CVE-2026-93253: sched/isolation: Defer freeing of cpumask memblock
memory to initcall

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93253

Introduced by commit 27c3a59 ("sched/isolation: Convert housekeeping
cpumasks to rcu pointers") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b58c749b8c5244e259a0230bc57b10b010dc545]
stable/7.2: [811fdac2d1bdf0b0d3fda262aac288ddd13a1422]

CVE-2026-93254: arm64: entry: Avoid unnecessary local_irq_disable() on
kernel exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93254

Introduced by commit ae65411 ("arm64: entry: Use split preemption
logic") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39aebe0e89469c2904e60b1e977e0d4dbf33326b]
stable/7.2: [49a61174186bed25d439ff37400c7ce5e3603e73]

CVE-2026-93255: btrfs: make sure EXTENT_BUFFER_READING is cleared
under refs_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93255

Introduced by commit 83f7e52 ("btrfs: warn about extent buffer that
can not be released") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [690c2accacb1aca91ab8186d15dee56da8723f31]
stable/7.2: [2073f3d97b0c5d34fe64812d1237e37bd79c17ec]

CVE-2026-93256: arm64: hibernate: mask DAIF before restoring hibernated kernel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93256

Introduced by commit 82869ac ("arm64: kernel: Add support for
hibernate/suspend-to-disk") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [684bde100117931f4c51c644a95f42f2dab041bc]
stable/5.10: [c9c671e9ab87b639720db8f7f8648bdf0f3bc8ec]
stable/5.15: [099ad3edcef1d955d9f5d6aab16ae78ecdfd4cda]
stable/6.1: [716c41bd476334afb943308be9ff2142e34461b7]
stable/6.12: [290c5b0c9fc0c61fb1c41421ed2394f955206ea0]
stable/6.18: [012823494e20c3cce622982ebd3fd6971be39ad2]
stable/6.6: [5370853041a3cb53a125b77528586278f64b378b]
stable/7.2: [d736ace2c491623c9ab5e73744085e93e9ae3ebe]

CVE-2026-93257: block: handle nogenerate/noverify properly in fs-integrity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93257

Introduced by commit 0bde8a1 ("block: add fs_bio_integrity helpers")
in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bf9a21e7bccfd8c35b440efd114c61cc9838a41]
stable/7.2: [b681c740e6d645f7d7477e9208db57917c6c0fbc]

CVE-2026-93258: ocfs2: do not use make_bad_inode() in
ocfs2_read_inode_block_full()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93258

Introduced by commit 58b6fcd ("ocfs2: mark inode bad upon validation
failure during read") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d48ace65322001b41bb5322442a21425ef4407d4]
stable/7.2: [0e7459abff46e28e64367057038ef8607e63f599]

CVE-2026-93259: powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93259

Introduced by commit 7e3a68b ("powerpc/64: vmlinux support building
with PCREL addresing") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00be69070d91d2be978e752bb117a0a4db0e1281]
stable/6.12: [602ee44415f3eaa7893f7fc488c7c1d4a0bdbd7a]
stable/6.18: [90d953002cf0b233dd053a0e7cb67ab79cebd0e3]
stable/6.6: [dcc442a49c0f540193910dacdca7506bcadc7ec5]
stable/7.2: [7b0093b638c8f2b94b0778a69fd1ccad54299b29]

CVE-2026-93260: powerpc/xive: propagate IPI init errors to prevent
use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93260

Introduced by commit 243e251 ("powerpc/xive: Native exploitation of
the XIVE interrupt controller") in v4.12-rc1.
Introduced by commit cbc06f0 ("powerpc/xive: Do not skip CPU-less
nodes when creating the IPIs") in v5.14-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [411a3c016e7a95f5fa105a0587e07d0647a77727]
stable/7.2: [c554a8d376d5aea1b237ed6bef6f9fbfc550e67f]

CVE-2026-93261: locking/lockdep: Fix NULL pointer dereference in
__lock_set_class()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93261

Introduced by commit 64aa348 ("lockdep: lock_set_subclass - reset a
held lock's subclass") in v2.6.27-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7577e00b9ab506202b9f1a33de3cc8cc6413a4db]
stable/5.10: [f6093ff67ea6e347574819ed23e96e0f82a25ffc]
stable/5.15: [59a5c7dd331a3dab48100e1ef8e9bb4f9132a2b2]
stable/6.1: [f56e54fd24f05e9de528fcb77f6084f80c8066ce]
stable/6.12: [b2113dcd8238bf00ce37a34e67b29cf31d32a545]
stable/6.18: [e7c69c6695d84220847cca62a45e879e71e79e9d]
stable/6.6: [5c3bff6cf26e6a54fbf8b893a879c32824d2d50d]
stable/7.2: [9be10f49dfc2e4b472b3a5f346483b67374774b8]

CVE-2026-93262: md/raid5-ppl: fix use-after-free in ppl_do_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93262

Introduced by commit 1532d9e ("raid5-ppl: PPL support for disks with
write-back cache enabled") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [371f7a1b392edc8b7cf449cc7713179b588f2d0e]
stable/5.10: [cf01f9413565e86673baf927291a088b6975692b]
stable/5.15: [e7505842f1329ece90cb9ea0db87772aeca44052]
stable/6.1: [b5123bf667ac29ddd8106f9ca7cc01316513ae66]
stable/6.12: [8914c3d40870f16429a326e97e4016bedc6ede4c]
stable/6.18: [455b56209f9615c3902dcc398dd867abb5ade3ab]
stable/6.6: [e77c80670f2c2bf491da9b173931e1da4677c23a]
stable/7.2: [fcf21df7d3c50c8ebeb0757df5d21b02dcae4218]

CVE-2026-93263: clk: eswin: Zero-initialize stack-allocated clk_init_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93263

Introduced by commit cd44f12 ("clk: eswin: Add eic7700 clock driver")
in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011d8de504bc84402aabc1dda1cf0552fe9a5af2]
stable/7.2: [1183dc2450a268a536a15da8b106ec520cdbd19f]

CVE-2026-93264: RDMA/efa: Fix PBL chunk length computation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93264

Introduced by commit 40909f6 ("RDMA/efa: Add EFA verbs
implementation") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [229b42d7450c1cf96f45ec39ebb69211b06bc036]
stable/5.10: [665cd418b8561a099c3854443f8ad8ae751b72a0]
stable/5.15: [932e5684906a090644a9061fae2d254041c3b8f2]
stable/6.1: [489b28f2377afa70c18c45b06a6387f3d39bb123]
stable/6.12: [3982714e15512b83115897806dacc94899683420]
stable/6.18: [da7805f0211af19968584e621074f253ac07dba7]
stable/6.6: [aadf3f9b5edb7f0a77e9172b237d2e07c754829c]
stable/7.2: [1d4b5902773475fc97151379b7e5f09cad0fa57b]

CVE-2026-93265: PCI/pwrctrl: tc9563: Fix parsing the integrated
Ethernet MAC Endpoint node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93265

Introduced by commit 4c9c7be ("PCI: pwrctrl: Add power control driver
for TC9563") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e5e6c2194b2acbded5b12ed80590d215b786d29]
stable/7.2: [972c771674e88a43c8310c459ea30f0f0d0c168f]

CVE-2026-93266: arm64: RSI: fix field-spanning write warning in
attestation token init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93266

Introduced by commit b880a80 ("arm64: rsi: Add RSI definitions") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [221049874b6a78c7d87bc826581b0695cd338e2b]
stable/6.18: [e505092cb200d430d5b8d8d3e926d45f29474ba3]
stable/7.2: [d29a8ee271da17b5e32d7a76a9c78d43f66447ca]

CVE-2026-93267: RDMA/core: Fix potential use after free in uverbs_free_dmah()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93267

Introduced by commit d83edab ("RDMA/core: Introduce a DMAH object and
its alloc/free APIs") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2696626a0be5877f445fb647c25ef43930c777e6]
stable/6.18: [8b22722f45a29a7c0900b1d4d0bc5da5492ece10]
stable/7.2: [bfc119a40c04bbe3daad826f2160ccbfae6c64ce]

CVE-2026-93268: ext4: skip extra isize expansion during mount to
prevent deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93268

Introduced by commit c8585c6 ("ext4: fix races between changing inode
journal mode and ext4_writepages") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7461c60b9c6a839b13ad4c3490681a0cf5aa0637]
stable/5.10: [41897f1bcf4ace5f1f28d0be784b6f4f0e929641]
stable/5.15: [9c3469377b1d8caba6bec6ef3c460810bbfb02cc]
stable/6.1: [1dd4882dbdc8bfdf2182fa388883c143fac0902a]
stable/6.12: [c5e6434cc55f30220b228be237bb666351f9f4dd]
stable/6.18: [7ace189b9ea79cf78df9c32b940ce12735f9459a]
stable/6.6: [7ba09330d9ea6e996228316719eae812d7e04983]
stable/7.2: [2fb8ff81659a57c42bb7b49e8339a2be2a318ef8]

CVE-2026-93269: ext4: fix circular lock dependency in ext4_ext_migrate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93269

Introduced by commit cb85f4d ("ext4: fix race between writepages and
enabling EXT4_EXTENTS_FL") in v5.6-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [a897682793eba5de51ee6f3152760374afa629cf]
stable/6.12: [ada23457d4748d6e9c36c6f871fc29a6f558c48c]
stable/6.18: [e4223231b6860141813637a6413c2371ae4d6fa8]
stable/6.6: [452950461241dfed8b1d32e94b227db38c99c5af]
stable/7.2: [32f7ab52875ec7f800ca67e7176e5743a84baddf]

CVE-2026-93270: bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93270

Introduced by commit 7bdbf74 ("bpf: add special internal-only MOV
instruction to resolve per-CPU addrs") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a0855e73757ee9cf25ba635a1c735018ecba742]
stable/7.2: [57cf929a33cb76be3f24886073ae820b4c496914]

CVE-2026-93271: wifi: ath11k: cap out-of-range rx MCS instead of
leaving bogus rate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93271

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b09e478aa7459b7893a695ef77682202f2da83]
stable/5.10: [6ad04c3e2ec54bf5ec72c81afdd66318a116c539]
stable/5.15: [a6b951f79e66fc8bd93a537ff1040fbfb567c8bf]
stable/6.1: [b77bfe6e59b98dff3ccfcf9b45fc27e3db498626]
stable/6.12: [a0b3e6f9645d88f387c4fea546048a91952cd4cd]
stable/6.18: [2bb2a778a487305bd378db5fd5014fbdce4ada2c]
stable/6.6: [fb7b9a7209f839c17c66484dfdc84c9a23c6fd2f]
stable/7.2: [ccbd20f2168f581d90265da1a925b9b6472a0b05]

CVE-2026-93272: remoteproc: qcom_wcnss: Fix handling the lack of PD
regulators in v3

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93272

Introduced by commit 65991ea ("remoteproc: qcom_wcnss: Handle
platforms with only single power domain") in v6.15-rc1.
Introduced by commit 65991ea ("remoteproc: qcom_wcnss: Handle
platforms with only  single power domain") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [3dbc90b9c22ea96e37bf55f6011e63b5123ec668]
stable/7.2: [bce6b48af3abf7468d12ef4933f21bd8c1d822e9]

CVE-2026-93273: regulator: tps6594: Fix device node reference leaks in
multiphase loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93273

Introduced by commit f17ccc5 ("regulator: tps6594-regulator: Add
driver for TI TPS6594 regulators") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fd28093b3effc4f92566466df364622830ec608]
stable/6.12: [4a672bff99f6b58dde419fd12b3a53da137f032d]
stable/6.18: [68ce4f8223b78f8616ec7f4a02c38988eae627d2]
stable/6.6: [28f70e0aa767a8f022c70ed75ecef227dc668121]
stable/7.2: [fceac25487b21d6db940d2aed368e465d89cd1f4]

CVE-2026-93274: pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93274

Introduced by commit 266423e ("pinctrl: bcm2835: Change init order for
gpio hogs") in v5.16-rc7.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [32711f77db0641e57fd96fdc013bf1286b9f2514]
stable/5.10: [d428863ca8baa4e9eaf781266ac219b017dcf277]
stable/5.15: [f494cfc254cd509d7cbc44b843e0a6602a520a33]
stable/6.1: [dd6b1919e41d1260259c4505777be565fb3a7efd]
stable/6.12: [b8535f5c77cc61352d02a0c038a280127a8b8208]
stable/6.18: [68ea6dd23b732081826c36033835468383487864]
stable/6.6: [3b978fd0a3092b25561ac26bc1a87149fa981ddc]
stable/7.2: [727f043d699ab0d5d87122c2177f2b45fbe58d35]

CVE-2026-93275: perf/x86/intel/pt: Fix stop/start with no update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93275

Introduced by commit 52ca9ce ("perf/x86/intel/pt: Add Intel PT PMU
driver") in v4.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e17bf3a469a41457a3bc31b1f8fd66b6ce94a6d]
stable/6.12: [9b919fb5512f256e9e0604faf960b2bb98aab454]
stable/6.18: [cab5015ee3f25f789b4a368f2abfa65536576b78]
stable/7.2: [304844b5545f444d523286da8228a1cbc46ffffa]

CVE-2026-93276: phy: renesas: phy-rcar-gen3-usb2: Fix devm action
registration for disabled VBUS regulator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93276

Introduced by commit 2484340 ("phy: renesas: phy-rcar-gen3-usb2:
Control VBUS for RZ/G2L SoCs") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt

Fixed status
mainline: [49c9b71b45081e5e5eeb507a2d6edb80d332dc59]
stable/6.18: [bf7fefbc26e292c08cfe7b6496b879109ef1475a]
stable/7.2: [935f6e837a83b86b073a7601f699dc2c00e01322]

CVE-2026-93277: RDMA/bnxt_re: Validate udata before executing commands

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93277

Introduced by commit bed686d ("RDMA/bnxt_re: Use
ib_respond_empty_udata()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d38c835925d4a3bfdf0a85ff2829ee90c709c561]
stable/7.2: [c5643ea4f040acc2f4d1e88f49bd0be51110ff2f]

CVE-2026-93278: staging: octeon: add missing napi_disable in cvm_oct_rx_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93278

Introduced by commit 3368c78 ("Staging: Octeon Ethernet: Convert to
NAPI.") in v2.6.34-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0a9a8586a63fda49e61a6b83360feac2a60d898]
stable/5.15: [158389d7af04bbf0664d91c2ce31fcc9eeace1eb]
stable/6.1: [c124049c3a7006fd6caf629139a5722610bbffb4]
stable/6.12: [b38fbd68cc36b4f478a1e3cfc169b8616ae1337d]
stable/6.18: [89f9f433271fad9351de6a3c713b45b2cfb23e4a]
stable/6.6: [98f9036b2254c928cb44da0c77dba38f66f7d8f1]
stable/7.2: [b2243ffaac14cc3639b5b32a371aac37f96ee554]

CVE-2026-93279: staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93279

Introduced by commit 4898c56 ("Staging: Octeon:  Free transmit SKBs in
a timely manner") in v2.6.34-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9af44b0d20b2247c4eb0ea5cfca907d643eea50]
stable/5.10: [32efcb6d5f4e3f030e7b0a3ba5c6c0684dd07486]
stable/5.15: [d15226338dfaa84ffff142d32723cdf74d0c47c4]
stable/6.1: [a77efd85e0d48c877f66d2bc3ab89cc1b8dacd19]
stable/6.12: [03d12490afd1198310ad0aba42462329832eb739]
stable/6.18: [2c0c9956596e48654bb4855e2a0742748a0826a7]
stable/6.6: [b6365e4186322858a82c8713b1d0bd209c8e765a]
stable/7.2: [41a79bd9e5a74f8f483b3b206d10567912874fb4]

CVE-2026-93280: greybus: audio: bound the topology section sizes
against the fetched size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93280

Introduced by commit 184992e ("greybus: audio: Add Greybus Audio
Device Class Protocol helper routines") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33d8c7b794d2a30637c9d3fcb478f1d3222bef1e]
stable/5.10: [ba86de9f7b0d7903d2df5ea2373e34d8ca3fc43e]
stable/5.15: [dd5593aee0a0fb353e1164aff7b65e563fe1f232]
stable/6.1: [6f764363b3173d805be11e59a8f23ecee2d420d5]
stable/6.12: [d0f6eaba60705bacd9bb4ce48eab50ef3f546777]
stable/6.18: [c9191f2e2f35f1209eb2dc24b31129dd47b48c16]
stable/6.6: [52daf9de692ebac813d110eb1e677dc0e1f4a5ab]
stable/7.2: [cfcc5a41a9664eb68023aae4cd0d485b256bd7c7]

CVE-2026-93281: wifi: rtw89: fix HE extended capability length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93281

Introduced by commit 8d540f9 ("wifi: rtw89: disable 26-tone RU HE TB
PPDU transmissions") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aba608a86e9b099c9af2ea70b620552dee2b628]
stable/6.1: [eddf53f1edb0cf7f302bd15cdb47cca90948c205]
stable/6.12: [bddbd1de765bf6ddc0473ad683910eb3a2a92a43]
stable/6.18: [f2a01deff7d0d5cc3dcbf2358dac113979303c8e]
stable/6.6: [655c4401c18d735dbaf2cc172ff4f626b3a896a0]
stable/7.2: [f132fc01b359a0f7d81fe13d769ea4e7c4baa66e]

CVE-2026-93282: ksmbd: fix maximum allowed access checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93282

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc2f133e80eb2c4a04bfa77a2f207749fe2f516a]
stable/7.2: [35d5c59fe6b1d9fe43fb14eb384f69ee1a120f9c]

CVE-2026-93283: i3c: master: Fix device_register() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93283

Introduced by commit cab63f6 ("i3c: Fix potential refcount leak in
i3c_master_register_new_i3c_devs") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [74be657d98a8d684c0475f3cbd450ef2a30ffc73]
stable/5.10: [5bf498623f8397d45f85f14cd631c5e5a565c2fb]
stable/5.15: [20a2b6df91fd782ef2ff551febef594d0b46a9a7]
stable/6.1: [a14dbdf471001dd0601b0c491184990c178a199c]
stable/6.12: [7f8e2c4f3704d9774bb26b49b1ad6a60ae57d4a0]
stable/6.18: [7ef12e1dd06e442eebf370f6e53c41bd056d0f22]
stable/6.6: [d22ad96f1a0c89e0ba66a2facc7430f0923919e3]
stable/7.2: [6ecf17bf5fe8da51a6e3fc9e03a76898fcc5c6cf]

CVE-2026-93284: drm/pagemap: dma-unmap pages before handling migration errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93284

Introduced by commit f86ad0e ("drm/gpusvm, drm/pagemap: Move migration
functionality to drm_pagemap") in v6.17-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e6372ec2a3990662ae0a67f56ac0aee19848d5b]
stable/6.18: [e4331c6644db85bc6ceb470bd84bcf371b6dbfa6]

CVE-2026-93285: f2fs: embed f2fs_gc_kthread in f2fs_sb_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93285

Introduced by commit 5219093 ("f2fs: sysfs: introduce
critical_task_priority") in v7.0-rc1.
Introduced by commit 7950e9a ("f2fs: stop gc/discard thread after fs
shutdown") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d7bca9d583793bb7d0bac0d95a24ddd2e129eed]
stable/6.18: [23eee01c732ec8c62b05416a05f0f88129df2960]
stable/7.2: [99d14d61aa8beb6cb9a984b9fcddd45e35b24494]

CVE-2026-93286: net: appletalk: fix NULL pointer dereference in aarp_send_ddp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93286

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e7f36ab5b7bf68463faa5f7b926fea8f35597bb]
stable/6.12: [8fc30f0cdf4207a5aa2341c0a98d0f1713b3ce2c]
stable/6.18: [83899a056aeb120898a6e3a989971fc63e274e2e]

CVE-2026-93287: i2c: smbus: reject oversized block transfers in the common path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93287

Introduced by commit 8a32599 ("i2c: Add message transfer tracepoints
for SMBUS [ver #2]") in v3.15-rc1.
Introduced by commit 4710317 ("i2c-stub: Implement I2C block support")
in v2.6.33-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3051cd060fa496df42954291fa2306ed2eab4ecc]
stable/6.12: [f09edffba97d37b1fdff5f818a9a45f8a98ac171]
stable/6.18: [c4b478bc50b7ca9865e237909941253a0f7111a2]

CVE-2026-93288: netfilter: nfnetlink_log: wait for rcu grace period
before freeing pernet state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93288

According to the .vulnerable file, this bug was introduced by commit
c83fa19 in v4.12-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33d1469b0124cc0baaea7a2032123b77a81e0940]
stable/6.12: [f4461654374576e9d5d0245fd534c46ad8509051]
stable/6.18: [dc20050b6b12ca58066715d088e1a537535d938d]

CVE-2026-93781: scsi: core: Do not block on tag allocation in
scsi_eh_lock_door()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93781

According to the .vulnerable file, this bug was introduced by commit
6e68af6 in v2.6.20.16.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [732cb6bb37fd26863d5786522fb1997e7f5865b4]
stable/6.12: [261c80a6b23e34ba98bcf3f75317e35ecf0a08f0]
stable/6.18: [dc9e1b6b9080dd6374cc9a38e4b53abca63c3b1b]

CVE-2026-93782: vhost-scsi: flush backend after device ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93782

According to the .vulnerable file, this bug was introduced by commit
057cbf4 in v3.6-rc2.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22598f55a4c2b510b3df5e69e563387a963222ae]
stable/6.12: [981c97d09c6b9560bb12dcc41f11ce59b1a48e97]
stable/6.18: [6c1b802e36b05ebd9d41686c4dce6f06966af469]

CVE-2026-93783: Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93783

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b230e5bf501c5edaf2eb0991cb862ac142031d4b]
stable/6.12: [67dc3b40fae71b6b11c71e7ff69bac0758818c05]
stable/6.18: [bbc310caa2b6bf5fe42896ba27da0fbc12e4ac51]

CVE-2026-93784: wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93784

According to the .vulnerable file, this bug was introduced by commit
f212935 in v2.6.32-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2f5286ca4f304d3fd469f01b96b518608912a5c]
stable/6.12: [c970879e03b23a27df42caf7ba506485a165fb96]
stable/6.18: [01cc395cecfaa73134d39fb9a401d9605d8bb2c5]

CVE-2026-93785: cifs: validate idmap key payload length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93785

According to the .vulnerable file, this bug was introduced by commit
21fed0d in v3.2-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [455488cd5054bcc59db40fa1cc2c004031a5b2a5]
stable/6.12: [6cfeef221ac00d63c07f6122f58e6159bde69ca0]
stable/6.18: [8b12f65d7caf16d124098cb4895a203367d35b57]

CVE-2026-93786: ksmbd: preserve VFS inherited POSIX ACL mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93786

According to the .vulnerable file, this bug was introduced by commit
f441584 in v5.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e148e567a9252643baa125cb65d7ae9c2c6cf68a]
stable/6.12: [591acf171644de590cda245fd8595b473a1beb70]
stable/6.18: [0093909becbda22b62b39b654dbc607faed59cd0]

CVE-2026-93787: smb: client: bound dirent name against end of SMB
response in cifs_filldir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93787

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8cf09a53a0dc1da298e9dd0ba5f21710cf119d6]
stable/6.12: [6e3b965267b7313903baba2739992b1e2e92d540]
stable/6.18: [03003506c86f90312b0966283662c42fcab66e4b]

CVE-2026-93788: wifi: iwlwifi: acpi: validate WGDS table revision index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93788

According to the .vulnerable file, this bug was introduced by commit
97f8a3d in v5.16-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [954e821f42aaca56073ca830c5fd4bcf1a89048c]
stable/6.12: [2fc98ab6fe8acabd13eb09dc17426a33cf9f27f7]
stable/6.18: [346a558491241cbe8fef82b3d8f62d1a6b6bf61f]

CVE-2026-93789: wifi: iwlwifi: bound aligned TLV advance in FW parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93789

According to the .vulnerable file, this bug was introduced by commit
dd7a250 in v2.6.35-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acad742714bdc70e7fd7f234323807c596828213]
stable/6.12: [528fa9eb14c209533ca26958b76da55e0ce239d8]
stable/6.18: [7aa9097623afb694bc25382a62e14d8e82bf002f]

CVE-2026-93790: wifi: iwlwifi: mvm: fix out-of-bounds tid_data access
in BA notif

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93790

According to the .vulnerable file, this bug was introduced by commit
41fd2fe in v4.15-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94d3982806c7f194b23484befde12934dda23064]
stable/6.12: [c48b741277b01b2c3b4ecccedc72fc575b71dc04]
stable/6.18: [e8ac5e91b1296f65c3d119fac3fa917ff458f811]

CVE-2026-93791: wifi: iwlwifi: mvm: add a check on the tid coming from
the firmware

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93791

According to the .vulnerable file, this bug was introduced by commit
c46e772 in v4.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e4c0d83267261cf67ec9690856edf4a56bb7dfc]
stable/6.12: [0b5325a0771674f1d65618de7db3df9d49186a12]
stable/6.18: [59f64c2839022f41a7867b38f9e38c185ff39283]

CVE-2026-93792: wifi: iwlwifi: mvm: fix a possible underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93792

According to the .vulnerable file, this bug was introduced by commit
f444eb1 in v3.9-rc2.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cb5260a1027a43f8cdb961e128f2ddd42e46832]
stable/6.12: [38ad8339211bf24c19126ec7629ea52094676454]
stable/6.18: [83f32942a501c80f44b8a8f668bc8b56d5d0d43f]

CVE-2026-93793: wifi: iwlwifi: mvm: validate TX_CMD response layout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93793

According to the .vulnerable file, this bug was introduced by commit
8ca151b in v3.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d70881707b47353359df57df12f6de67fdacdd2]
stable/6.12: [fc14f5fe8a4374ed1088cfbddc1dae4d16c9935b]
stable/6.18: [4d942dfc13aec393e003ab28ff58db744c26e6eb]

CVE-2026-93794: smb/client: flush dirty data before punching a hole

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93794

According to the .vulnerable file, this bug was introduced by commit
31742c5 in v3.17-rc2.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7d2adcd022baade5cab65ca492ce63421ce3a6e]
stable/6.12: [6c265aca08155e519a8f6f6071c59dff4f535f70]
stable/6.18: [39562a56cdb515f6635c3e7bfe6629439b18a169]

CVE-2026-93795: blk-cgroup: fix leaks and online flag on
radix_tree_insert failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93795

According to the .vulnerable file, this bug was introduced by commit
7fcf2b0 in v5.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbbca20764382b4d411ec2918f4e278ffe547acc]
stable/6.12: [6e85f02d45b5977c0326a8d854c6db878aa6b34a]
stable/6.18: [4c0d150fb98ea40760611979f4e664c244b20966]

CVE-2026-93796: wifi: iwlwifi: pcie: null RX pointers after free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93796

According to the .vulnerable file, this bug was introduced by commit
9cf671d in v5.12-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c79d7a7b583050c9f58041465cb46fe3483ab5d]
stable/6.12: [6ec5bf430cf7466cb412e47f2761594092781fac]
stable/6.18: [3456c5bcc987aeb182e50e30c9b02be8420e9953]

CVE-2026-93797: wifi: iwlwifi: mvm: fix an off-by-1 boundary check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93797

According to the .vulnerable file, this bug was introduced by commit
4f58121 in v5.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d77aff138c9ec6c8562f4c2c9f262d3d9c4b4cb8]
stable/6.12: [1e3b72c9b63288a5f204e2c8f38eae01515d7dc5]
stable/6.18: [4d60332387336088e66cc8f1e71e516b6b872ef9]

CVE-2026-93798: btrfs: fix reloc root cleanup in merge_reloc_roots()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93798

According to the .vulnerable file, this bug was introduced by commit
1dae7e0 in v5.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b78fe9563e2d5ae47805f1e5dc722c91fd30e1f8]
stable/6.12: [ab48583aa9948205ff9a6470e23dbff74c565e24]
stable/6.18: [63d6b1f04cd91c825329712aa526215ffa5d11ca]

CVE-2026-93799: wifi: iwlwifi: mvm: validate sta_id in BA window status notif

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93799

According to the .vulnerable file, this bug was introduced by commit
3af512d in v4.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aa77efaea9efea92e3090c35ad348fd759a3cf3]
stable/6.12: [bb08fbbbd5568d33069485ecb0a1657f115a4e9f]
stable/6.18: [e35ae757c6462bfd3437bf58121bb721fe1f790c]

CVE-2026-93800: btrfs: fix use-after-free on reloc root after error in
insert_dirty_subvol()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93800

According to the .vulnerable file, this bug was introduced by commit
592fbcd in v5.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [83201804efa4a5168be754e1dfc9b2faee760cac]
stable/6.12: [97a540d72ebcb21853d11f2a56782fe377f358e7]
stable/6.18: [fda1b6636ff1846f00643e791099db5564b547d9]

CVE-2026-93801: smb/client: zero-initialize stack-allocated cifs_open_info_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93801

According to the .vulnerable file, this bug was introduced by commit
057ac50 in v6.18-rc1.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [8fce4cf4369c766a3293a05419500cbfde72e60d]
stable/6.12: [74ff47e6c4213fcfeba2de448d9cbda200507d22]
stable/6.18: [22532dd88694ed20bdd47523ffa709f166ce776b]

CVE-2026-93802: wifi: rsi: validate beacon length before fixed buffer copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93802

According to the .vulnerable file, this bug was introduced by commit
d26a955 in v4.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ecdeb8b8a33b22c597299043c0dcfce50beb9ea]
stable/6.12: [87710ad633ce4588aec88611d0d0745eb33a6991]
stable/6.18: [266f195d5a14eec6c482fd09fbc924584c3371a7]

CVE-2026-93803: wifi: libipw: fix key index receive bound checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93803

According to the .vulnerable file, this bug was introduced by commit
b453872 in v2.6.20.16.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74ed3669f26803b1761c1f55403062bea44c3466]
stable/6.12: [062840bdc9ee06169b3c371bf66711f1d7ec0bf4]
stable/6.18: [c54b643e9a0936d038921c547736574fd7382cea]

CVE-2026-93804: wifi: mac80211: ibss: wait for in-flight TX on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93804

According to the .vulnerable file, this bug was introduced by commit
86a2ea4 in v3.3-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0e69d9afa59b93c30294eba89b1f15f69e91105]
stable/6.12: [20a3fb5e1a95caa34896853ca17a50d21c754969]
stable/6.18: [b3451e6971248250312ad32dd7f63cc9f0a925f5]

CVE-2026-93805: wifi: cfg80211: validate rx/tx MLME callback frame
lengths before access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93805

According to the .vulnerable file, this bug was introduced by commit
6829c87 in v2.6.32-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5e4586546974179feca305a94e07fac3e9727fe]
stable/6.12: [0ec738a0d361d7eb37188117166d201f9df622d3]
stable/6.18: [8f4127a93cf60d561ad39849a9ac763ba0e14db5]

CVE-2026-93806: wifi: cfg80211: validate assoc response length before
status and IE access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93806

According to the .vulnerable file, this bug was introduced by commit
6829c87 in v2.6.32-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b760113aeca2e9362d56bf9e9263373ffe6c8eb3]
stable/6.12: [a57310600c1e2b9ada0f37c96e8f48aef47d3093]
stable/6.18: [78ac450ad4624d6b2999cb4eeb28916767f81247]

CVE-2026-93807: wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93807

According to the .vulnerable file, this bug was introduced by commit
dad0d04 in v3.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [843fe9bc583b7686ca68312ac9319c9240a73c03]
stable/6.12: [5902e3c08c63d65724772f74d65b9fb032625dca]
stable/6.18: [55b86ef6c2e68879ffd95203b011ef42a013ab88]

CVE-2026-93808: ALSA: usb-audio: caiaq: validate EP1 reply lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93808

According to the .vulnerable file, this bug was introduced by commit
523f1dc in v2.6.22-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aba30af07d4fe499b50209801eba9da8a815522f]
stable/6.12: [af8a172c4f71ac30d625f2966d2389a7fa872819]
stable/6.18: [74f3c639f64fa5da4e1613149798b5089bce2807]

CVE-2026-93809: drm/amdgpu: flush pending RCU callbacks on module unload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93809

According to the .vulnerable file, this bug was introduced by commit
4e02e0a in v7.1-rc3.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67a654b41cfa73c3b83402c4a01b2689cad5b9bc]
stable/6.12: [5063ae84c45299a100bf1d6ed11945f688063649]
stable/6.18: [27d43ad57759c73b8fad5b2bad62a0616e116bbc]

CVE-2026-93810: cachefiles: Fix double fput

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93810

According to the .vulnerable file, this bug was introduced by commit
24a8175 in v6.1-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af6830cc12dfe86c832dccc9c9878a93aaa22f83]
stable/6.12: [e9c2e68c3890a935abbd5f54dbce653f9a16836c]
stable/6.18: [90b306eee037d0a6a8f4aac834b46e05c5ddd0bf]

CVE-2026-93811: ksmbd: Fix acl.sd_buf memory leak and invalid sd_size
error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93811

According to the .vulnerable file, this bug was introduced by commit
8f05411 in v6.0-rc1.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d708a36634bb7b6f94d0e76d587d2ec50b2b93b5]
stable/6.12: [c3836f55e0dab96314774215e12d87f63fa919f2]
stable/6.18: [6e6329322ad733c5b23555c609353841560b26bc]

CVE-2026-93812: ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93812

According to the .vulnerable file, this bug was introduced by commit
303fff2 in v5.15-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4d56b00c7df88cd5751e7415bdfabc9fdbc82a7]
stable/6.12: [9b4dec75498fd0a1c9eaea680aef59c9519eb16f]
stable/6.18: [c521dd78e036b5e0cfd394dd2ff2218890dd9e41]

CVE-2026-93813: btrfs: tree-checker: validate INODE_REF's namelen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93813

According to the .vulnerable file, this bug was introduced by commit
2ede0da in v2.6.37-rc4.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dc22abc21f5892406c09202fa2627196cc96967]
stable/6.12: [eeddee090b834a7d4b6a8214d2e3739e64c7a338]
stable/6.18: [8f75c19892263bc0555fba922aefe103e841e86d]

CVE-2026-93814: spi: core: Abort active target transfer on controller suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93814

According to the .vulnerable file, this bug was introduced by commit
6c36406 in v4.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1bab046d4786c5b17aab7c5225bf0d4a2a2d19b]
stable/6.12: [b81ac605763c319ca9928a237818ab4e8ab7bb59]
stable/6.18: [f6a0cafa265c8a4aed585d873747e3b88b146eed]

CVE-2026-93815: net: au1000: move free_irq out of the close-time
spinlocked section

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93815

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f48763beab4eea41fc480c9702ec6eebe8d75e4f]
stable/6.12: [4536667fba8ddbaff2f2a135080ae6aabf737b5e]
stable/6.18: [fc2233f1ab2a1ca562869bca6987d7477671388c]

CVE-2026-93816: f2fs: validate inline dentry name lengths before conversion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93816

According to the .vulnerable file, this bug was introduced by commit
675f10b in v4.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfcd0e49a178b3dac2c0ece656079081dbf5da74]
stable/6.12: [2ce0bc5853bec7cdc724477a87ea579fde664243]
stable/6.18: [7caa8a0ae94b132576c2e46e9b4fd4e0f356f373]

CVE-2026-93817: perf: Fix addr_filter_ranges lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93817

According to the .vulnerable file, this bug was introduced by commit
375637b in v4.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e62d4192e593630f355094adc467058a05bdc935]
stable/6.12: [cd8dab11046c03ab07899ce3fe2aa7d1a9702cf1]
stable/6.18: [6f1853b2b9f38f1343790bae8c0601b3f7554754]

CVE-2026-93818: PCI: plda: Protect root bus removal with rescan lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93818

According to the .vulnerable file, this bug was introduced by commit
76c9113 in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e4f9745f016c1631d00a4035b06f6e75d449e01]
stable/6.12: [105f212a21cc6bef6855841216dd476022626170]
stable/6.18: [cb78a1d7a2787758a2d8e1182c346d4349f43260]

CVE-2026-93819: PCI: mediatek: Protect root bus removal with rescan lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93819

According to the .vulnerable file, this bug was introduced by commit
031337a in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a29812a55da8d0dbeb071b26ac428c338e3fc389]
stable/6.12: [c57b971765f835138fa2fce3f2a171b004cbb114]
stable/6.18: [a568939487dcbc1a3e341208585e224be897e25e]

CVE-2026-93820: PCI: rockchip: Protect root bus removal with rescan lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93820

According to the .vulnerable file, this bug was introduced by commit
073d3db in v4.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bd9611587bb494c33566d825fe34b2705e4b167]
stable/6.12: [ebca7e5947720e9d4bd918af3e17720270c50744]
stable/6.18: [9b19201f57d87c4d0777621275dbc59bff41b7f2]

CVE-2026-93821: PCI: altera: Protect root bus removal with rescan lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93821

According to the .vulnerable file, this bug was introduced by commit
ec15c4d in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8759c8ac48c0419f5899e95a6ffc611b07c965b]
stable/6.12: [c0cd65906e5f7e293ef2568c9524cc0a918333c3]
stable/6.18: [7cbb8f2750d91e64caff89e164ac8280bb80bedc]

CVE-2026-93822: PCI: iproc: Protect root bus removal with rescan lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93822

According to the .vulnerable file, this bug was introduced by commit
1fb37a8 in v4.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6a64e150f12ad5391e0a0d60f6a3d119b06ce50]
stable/6.12: [bd2bf1e0d973c93fc1637b90cbb9a5a5f6884bd3]
stable/6.18: [ee06aafc2d760a4ee023e0b2e95ce1ec71bddc6c]

CVE-2026-93823: drm/amdkfd: Let driver decide buffer size at
AMDKFD_IOC_GET_DMABUF_INFO ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93823

According to the .vulnerable file, this bug was introduced by commit
1dde0ea in v5.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8242a8d9d7194d5ef8a8b38a5621ca0966a3ec15]
stable/6.12: [a65ccabde6deb95baf9442bd98299e2248884162]
stable/6.18: [2d9fd0f01550aab4a0a1984b4379e50545906248]

CVE-2026-93824: tls: reject the combination of TLS and sockmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93824

According to the .vulnerable file, this bug was introduced by commit
d3b18ad in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [460e6486617c17dd19abe8f3fc67d9a6fa25f8ca]
stable/6.12: [c3d4d537337f69e405a36fa561e7292ee4148bf7]
stable/6.18: [a08e780b6cc1153cbff8be55de9ec9da809e344f]

CVE-2026-93825: spi: Add NULL check for spi_get_device_id() in
spi_get_device_match_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93825

According to the .vulnerable file, this bug was introduced by commit
aea672d in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [f1b061b4d4c6cbf861319ba954caa80145cf018f]
stable/6.12: [3fcd9415144f4fbd21e1bef35a7f8dbd734f607d]
stable/6.18: [72cc9c6d6fba5b4e0aaf89126884a56bb54b92f8]

CVE-2026-93826: HID: hidpp: fix potential UAF in hidpp_connect_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93826

According to the .vulnerable file, this bug was introduced by commit
c39e3d5 in v3.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6df6b1f2c49678211f65647c300bc51dda02893b]
stable/6.12: [3b8b2e58b078cd30e121401535541bb8a6d57133]
stable/6.18: [3303398cc2aa255ba251650a30024e11d48ea6c3]

CVE-2026-93827: virtio-fs: avoid double-free on failed queue setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93827

According to the .vulnerable file, this bug was introduced by commit
a8f62f5 in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6af3330ec5d5fb8c06c04eb520a71cf73ea5a765]
stable/6.12: [3fbc5ee776fefbc6ea34d2518f1f5f90aa2e1dad]
stable/6.18: [20ef4739b329bb09cff11dd2458795a50674658e]

CVE-2026-93828: exfat: fix handling of damaged volume in
exfat_create_upcase_table()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93828

According to the .vulnerable file, this bug was introduced by commit
370e812 in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20dd3185d13865214ff25b0bf7b931e8d73be1ac]
stable/6.12: [60ace93811609e4dd883e9de5fb4462ed834160a]
stable/6.18: [2cc0b612343638057ef321ce735201a7c2f52f25]

CVE-2026-93829: smb: client: fix races in cifsd thread creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93829

According to the .vulnerable file, this bug was introduced by commit
aaf737a in v2.6.22-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8a5cf2ff5a13fefb228f2069e29dd7d8e37185d]
stable/6.12: [ee8f811cbac56ffb738b3a73671a9e75b0f56e99]
stable/6.18: [0eee1e6cddd1d9ce14da06e0238ca8d3362dec90]

CVE-2026-93830: net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93830

According to the .vulnerable file, this bug was introduced by commit
d6ddfac in v4.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3265c19b35d036bba327b36b5366bee76b0157c]
stable/6.12: [0b1a5d3647ce07c27a9fffefc11a8cbf7d7b25ce]
stable/6.18: [87e2826ed2058747ddf014c082569a46bfadd96b]

CVE-2026-97407: ASoC: rockchip: rockchip_pdm: Handle runtime PM resume
failures in set_fmt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97407

According to the .vulnerable file, this bug was introduced by commit
c850644 in v5.1-rc5.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [ee7b5f7b39332febf917f9ebf212842cc9379815]
stable/6.12: [a9cc27a4a9b5fe013e152841fd8408061fa2312f]
stable/6.18: [b2b5c2ca5a4924271fa86d75a252de32fa285375]

CVE-2026-97408: Bluetooth: L2CAP: validate connectionless PSM length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97408

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a40a5f922546b3bd7c094d882b29177db4f2abe0]
stable/6.12: [3502ede8aed3c3ee1786d952a11054ac737d1a38]
stable/6.18: [ae69dca122f6d6046a68cf40153e6e827c77ff5c]

CVE-2026-97409: nvme-fc: Do not cancel requests in io target before it
is initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97409

According to the .vulnerable file, this bug was introduced by commit
52793d6 in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee38469f88492df99e1d97f03aa40ecfd218934f]
stable/6.12: [da930308b4bc24c335574e85ca84ff70a988cf05]
stable/6.18: [dd39064d2948b14dbe4f364fe4b3c9cfc632cc21]

CVE-2026-97410: netconsole: take target_cleanup_list_lock in
drop_netconsole_target()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97410

According to the .vulnerable file, this bug was introduced by commit
9771469 in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91aeb87f052367a5a2743cc93777dfb4386f2f14]
stable/6.12: [84592ee22f7d1583ce33aa733411ff36c7a1c44c]
stable/6.18: [fe8e6c0a2f28bdab14cdf7eff4dd9755d3793007]

CVE-2026-97411: net: ibm: emac: mal: fix potential system hang in mal_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97411

According to the .vulnerable file, this bug was introduced by commit
b3e441c in v2.6.24-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c5d41f87f079990bf241359e3c1332d8d10fe87]
stable/6.12: [f6c1aad9b35fa083f48ce0c5926204891d82e089]
stable/6.18: [c4cb9a728df66c46067b26263f5beb633aae4087]

CVE-2026-97412: pds_core: quiesce DMA before freeing resources

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97412

According to the .vulnerable file, this bug was introduced by commit
45d76f4 in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6443f4f20bdae726fe01cf5946fba9742a0ffda6]
stable/6.12: [cc8beb70e70fc90e54efdbc1128cf7de799e6be4]
stable/6.18: [9eee6b90bee3df496ed9094d9e76d5e478d72d0a]

CVE-2026-97413: RDMA/rtrs-srv: Fix integer underflow in process_read
and process_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97413

According to the .vulnerable file, this bug was introduced by commit
9cb8374 in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54bf38b27afc08a0eb6b732f9c14eb8a4bcb66b5]
stable/6.12: [24ad03bfeda05fca04c56677e57fd3d6bc3e9978]
stable/6.18: [c76e9123ab91a903396d26e6ab1b5caae5c6b149]

CVE-2026-97414: ASoC: mediatek: mt8365-afe-pcm: fix possible
NULL-pointer dereferences in mt8365_afe_suspend()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97414

According to the .vulnerable file, this bug was introduced by commit
e1991d1 in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8948ac26efc395264a47f9a743889065adb5cff]
stable/6.12: [f87707bc0406fe92bc142a9eee5f480c94ce9ff8]
stable/6.18: [1094d83ad325829acd68e63147793536060a0d60]

CVE-2026-97415: btrfs: tree-checker: validate names in ROOT_REF and ROOT_BACKREF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97415

According to the .vulnerable file, this bug was introduced by commit
2ede0da in v2.6.37-rc4.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af37c217edf15fa21dac1c40822086df356c6bb]
stable/6.12: [9154542070ca7eadb3c764a882f39a127677854b]
stable/6.18: [74f577c722c99248d804eca18e7de7c5e47549d7]

CVE-2026-97416: btrfs: balance: fix potential bg lookup failure in
btrfs_may_alloc_data_chunk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97416

According to the .vulnerable file, this bug was introduced by commit
a6f93c7 in v4.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18d32b0013efba19f7ad3e5b08d7aee813d604a6]
stable/6.12: [9740dd0c17a4be8cc47a06c5ca5293471a7e286e]
stable/6.18: [59f75e0c8724d4adebc08c7dd3ff2358b80c21f7]

CVE-2026-97417: netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97417

According to the .vulnerable file, this bug was introduced by commit
bb9fc37 in v3.1-rc7.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3bf9eae486490832bd08fd62ab0ac601f346bd4]
stable/6.12: [7ecfa46a536578a7ed335ddf31a854127268c27c]
stable/6.18: [4abc1af7ac209c066f4e5dd75cdd56876e5829a9]

CVE-2026-97418: ALSA: es18xx: check control allocation before private data setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97418

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [422e42b7c2b882ba1d16d4afc8891bcea7c4de93]
stable/6.12: [978079238f40f1a08ddb12ce208c484246f6a1b0]
stable/6.18: [d88c24b76f285df9d206751e22c28e2613258cb3]

CVE-2026-97419: hsr: broadcast netlink notifications in the device's
net namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97419

According to the .vulnerable file, this bug was introduced by commit
f421436 in v3.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a762fabd7ef9a6cc07258684138f9c3f078d0326]
stable/6.12: [25b69f281cebe051a8e4ab19950a939c27ead1bc]
stable/6.18: [24b3f1a9982c176d05a523a4bb9314dca0db4488]

CVE-2026-97420: bpf: NUL-terminate replaced sysctl value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97420

According to the .vulnerable file, this bug was introduced by commit
3292739 in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a66e3b5bacf38d6ab29fa05a9754f7a114485605]
stable/6.12: [76c14b10f50eb0afcc76e244562fa2d8c661e224]
stable/6.18: [3b2814dd842a565fcf9cc370156e1ba9eae16239]

CVE-2026-97421: RDMA/umem: Be careful about boundary conditions in
ib_umem_find_best_pgsz()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97421

According to the .vulnerable file, this bug was introduced by commit
a40c20d in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09ea6837a0434fb4db99528a5055b6d822135dcf]
stable/6.12: [ae3cf7d2c4d506c5c91746321644e1a08d989e2a]
stable/6.18: [5fc5b73109540809b094710fac44da81dd8a3ff8]

CVE-2026-97422: drm/amdkfd: fix SMI event cross-process information leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97422

According to the .vulnerable file, this bug was introduced by commit
938a065 in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92a8dba246d371fe268280e5fd74b0955688e6df]
stable/6.18: [5bb2dfa65d8da83e87b2a31c270bc567df69a5ca]

CVE-2026-97423: cxl/region: Validate partition index before array access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97423

According to the .vulnerable file, this bug was introduced by commit
b6faa9c in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16329b510f76e5b824e05bf8add8b29850f1f16f]
stable/6.18: [06322da06116f1ee52271dd4d84dc69580087df7]

CVE-2026-97424: drm/amdgpu/ras: add ras_suspend callback and use it
for cp_ecc_error_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97424

According to the .vulnerable file, this bug was introduced by commit
760a1d5 in v5.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3829992dd9fa0a82511af4f01733fc854cd15a5]
stable/6.18: [001824103f2fe6ffd2380afddf81f43b446035b2]

CVE-2026-97425: drm/amdgpu: fix buffer overflow during vBIOS update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97425

According to the .vulnerable file, this bug was introduced by commit
8424f2c in v5.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6229898d46c0cbc238a6fe9f11c1ea12cf8bb9c5]
stable/6.12: [c7b2af01ee2ecfb8f2289dc83524d8fb1ec72992]
stable/6.18: [29fef371331e87311822000535f491ffc3d7a64f]

CVE-2026-97426: drm/amdgpu/pm: fix SmartShift bias sysfs store PM
refcount on parse error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97426

According to the .vulnerable file, this bug was introduced by commit
55aa33c in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4b0c3f5d2287997876d8f711a40d3c0418458d8]
stable/6.18: [95e13b25196295654563028861e6802807006ad4]

CVE-2026-97427: drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97427

According to the .vulnerable file, this bug was introduced by commit
b9c1a77 in v4.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f193e71fa9fab2e68ef85201b106e8f580d3a25b]
stable/6.12: [43d2ab8408f9f468b232350c74160ae21e763020]
stable/6.18: [3334985f8b4c7c637a829744c81518ad9a671bcb]

CVE-2026-97428: drm/amdgpu: harden FRU PIA parsing with bounded helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97428

According to the .vulnerable file, this bug was introduced by commit
0dbf2c5 in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c990c05eb6c74c98d1ff3acf67a19015312820b7]
stable/6.12: [813311512505e95e4e3c898ff94b11886a15e494]
stable/6.18: [4396d74b0c7304946ee343a6611ac6dbc0bfbf78]

CVE-2026-97429: drm/amdkfd: fix UAF race in destroy_queue_cpsch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97429

According to the .vulnerable file, this bug was introduced by commit
a70a93f in v6.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac081deaf16a639ea7dff2f285fe421a33c1ade0]
stable/6.12: [41144829f4645c2bd4cb501d34d253858f750c0a]
stable/6.18: [d98c8032c29944e1e572e1f49a0613d364fece0f]

CVE-2026-97430: xhci: Prevent queuing new commands if xhci is inaccessible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97430

According to the .vulnerable file, this bug was introduced by commit
5535b1d in v2.6.37-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82b70c799281cc24506085be978b829149ba0ca4]
stable/6.12: [a50948386256b24d73971b9a152fe1de808446ab]
stable/6.18: [a05e54c1eeaba10414aa2fde94589a7c9885f2a1]

CVE-2026-97431: drm/amd/display: Avoid DPMS-on for phantom stream

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97431

According to the .vulnerable file, this bug was introduced by commit
9c6669c in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10f5f9c0ef32d08b228bfee3684b62f36f395852]
stable/6.18: [f2463fc246d3c39be1371389c52b29418ad673d0]

CVE-2026-97432: wifi: iwlwifi: mvm: fix P2P-Device binding handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97432

According to the .vulnerable file, this bug was introduced by commit
84ef7cb in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b74e377cad9271950c57472867c469e4b5b2ff0c]
stable/6.18: [7be2fc679c8f657868988e41c0bb15bf5a454620]

CVE-2026-97433: nvme: validate FDP configuration descriptor sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97433

According to the .vulnerable file, this bug was introduced by commit
30b5f20 in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ef4daa6534a510d61ea67c8ad9bb5097b0dd5f8]
stable/6.18: [97efd7a41aac08b43ea2337c5913a2bc75484f9f]

CVE-2026-97434: dpaa2-switch: fix handling of NAPI on the remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97434

According to the .vulnerable file, this bug was introduced by commit
0b1b713 in v5.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e23d7c8c1d4ba435c457d7ffb2669175ec819b07]
stable/6.12: [569df157eb874cb3b50554d73b89f31599397b42]
stable/6.18: [6518f87771c8833e587bd9881346fa759651c2ae]

CVE-2026-97435: net: dsa: sja1105: flower: reject cross-chip redirect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97435

According to the .vulnerable file, this bug was introduced by commit
dfacc5a in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfa5274a5dc2a23b957da5dc806d2ac0c7a66af0]
stable/6.12: [c999cc39775381b68ed66eae57c1425452672c0f]
stable/6.18: [abd7511e12b231798332afa04ed9bee9e84f9445]

CVE-2026-97436: dpaa2-switch: rework FDB management on the bridge leave path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97436

According to the .vulnerable file, this bug was introduced by commit
539dda3 in v5.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efc1d92eacf03afa6f4d53bf7120e059b6f961f2]
stable/6.12: [abea361a11e4e48695ea149652ef5d3f308b6a49]
stable/6.18: [5adbc4d02d7df8bd7aa02c21874f7a582a576b55]

CVE-2026-97437: ntfs3: fix out-of-bounds read in ntfs_dir_emit() and
hdr_find_e()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97437

According to the .vulnerable file, this bug was introduced by commit
4342306 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa1bdbb39f49c5bc9779316891c40005517842a5]
stable/6.12: [ed6da1abeec50db9060d714f03743fe0b63e4fe4]
stable/6.18: [6a8149a20e46086c756c2a9202e377c0b649a0c3]

CVE-2026-97438: fs/ntfs3: validate index entry key bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97438

According to the .vulnerable file, this bug was introduced by commit
82cae26 in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98d6e5d9dc1d34dcffc61549617581a5fe1ef807]
stable/6.12: [a8f4fb6a7d58974ffc9aed597401528b181d76dc]
stable/6.18: [0257e3ea00e19129f3ad5c039d8b8fdff0796835]

CVE-2026-97439: fs/ntfs3: preserve non-DOS attribute bits in system.dos_attrib

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97439

According to the .vulnerable file, this bug was introduced by commit
be71b5c in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1c1101067d9536bcb0fe023b96ee2dde5535959]
stable/6.12: [2de91ae285b0b878604d2bd83c3c395a8071e482]
stable/6.18: [407ee19828a7d9700969ed9cc53be50d0f533619]

CVE-2026-97440: net: qrtr: fix node refcount leak on ctrl packet alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97440

According to the .vulnerable file, this bug was introduced by commit
cb6530b in v5.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b09ff54114566864eea59020f6b69c5bb325b9d]
stable/6.12: [477353db343663d5502ca442c6de785d2f23f273]
stable/6.18: [9d969c98732a4d42212ec580dd5bbad53f246103]

CVE-2026-97441: ata: ahci: fail probe if BAR too small for claimed ports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97441

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4086c6e1af757e1ff26fa2d2926b3ec0195de79]
stable/6.12: [df262c828b616450eb351349e91c63447551bd01]
stable/6.18: [f2e291043c37a896d7f9797e25a356dceb030177]

CVE-2026-97442: wifi: ath11k: fix invalid data access in
ath11k_dp_rx_h_undecap_nwifi

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97442

According to the .vulnerable file, this bug was introduced by commit
acc79d9 in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b471e9aefee9ed73278eb1141e0d8530a56fae9]
stable/6.12: [1c0a13be76db3c1cf774aa11d9f4c3f8239ac567]
stable/6.18: [00738665c875ab34efa7126ea63c9d70b48ee169]

CVE-2026-97443: perf/ftrace: Fix WARNING in __unregister_ftrace_function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97443

According to the .vulnerable file, this bug was introduced by commit
c70ca29 in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [9581123304b23049437324038698af9fb56ee663]
stable/6.12: [df097713b56ffac5eed32a9be2e7d27ac48d9087]
stable/6.18: [7f845820afaad339341c2ae42bc7fdec175df9ea]

CVE-2026-97444: ACPICA: add boundary checks in two places

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97444

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdc35754012906dbf094be104b103ca3adfef6f7]
stable/6.12: [253d7272d01db9529c79b95205c0f859ef9f4f23]
stable/6.18: [4de2cffef5e6b5b79eec8c934df582459b818228]

CVE-2026-97445: ACPICA: Enhance buffer validation in
acpi_ut_walk_aml_resources()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97445

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2e21fe8c3361c3d0d57ee56d359bea9b51fda3d]
stable/6.12: [f65e2ef7ccca11dc874f48aff996a6a26528f8e7]
stable/6.18: [d0fb1973f705c8b8bd7e118e4a9a65d05d800fba]

CVE-2026-97446: ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97446

According to the .vulnerable file, this bug was introduced by commit
7952d40 in v4.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8d14b7bb0063bbbd86c0e4d73edb8cea7b362bc]
stable/6.12: [3762c6c8ae5073892d7cec736cc54270c7c9ce90]
stable/6.18: [3cbf096a478f4fa03953f0685ad28c9c82ce67cb]

CVE-2026-97447: ACPICA: Enhance OEM ID and Table ID validation in
acpi_ex_load_table_op()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97447

According to the .vulnerable file, this bug was introduced by commit
ebf2776 in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [485829e6999b7909f50761a1c708660304edc945]
stable/6.12: [e9a717b21caba155abe9d0c2102fe497536126b5]
stable/6.18: [d15c574022e0944f651759f567a9eef61e7b93ca]

CVE-2026-97448: ACPICA: Add validation for node in
acpi_ns_build_normalized_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97448

According to the .vulnerable file, this bug was introduced by commit
d1e7ffe in v4.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96b2b616870e46e2bc04efec03879683a0036e66]
stable/6.12: [babb146ceb79e71f328788f1e2c8c7c224026e61]
stable/6.18: [21a73528579fcbd673b668bd27a05b658123bc1b]

CVE-2026-97449: ACPICA: Add package limit checks in parser functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97449

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d27d48a528e437aed690f977e69a6fe73fe82ab5]
stable/6.12: [250800658bf3db32e7accc615b0a134c30fba203]
stable/6.18: [1cac04312b77fb81209da13bf5e0b83962568fcb]

CVE-2026-97450: ACPICA: validate handler object type in two places

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97450

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5296da2d516707862f8a2dbb4b515f777e5294f]
stable/6.12: [bfd981d35ed3156414fd35b4fe311d5d25cbfca6]
stable/6.18: [4c977d57a784682dc8c6cce2f9253ef44ec28ae8]

CVE-2026-97451: ACPICA: Fix integer overflow in
acpi_ex_opcode_3A_1T_1R() (mid_op)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97451

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e2021f49e64b3c8a9aa880d0c62a218bfe147ce]
stable/6.12: [d0d89f2e16a874e0f8fb17045da293e8bedf8b21]
stable/6.18: [b96401812cbfbb4803faabeefa1f20b8562268b3]

CVE-2026-97452: ACPICA: Prevent adding invalid references

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97452

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e8c55e13a5e3a9f38921d62924f18ceba3330eb]
stable/6.12: [e16d1e5fcb17dfc369e20095f8cf5e841101279e]
stable/6.18: [a6cd2fc2d5429a5b7d5a8b9ba0e6663e8ccbc9ba]

CVE-2026-97453: ACPICA: validate byte_count in acpi_ps_get_next_package_length()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97453

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d49c6ee08365a8596f639da46eb7e71752b0cd42]
stable/6.12: [780f380c66b80030379bec65bb1bd09ce6f6d9fc]
stable/6.18: [9bc0e8c3df689765ad5161eb3aed15de8544f5ce]

CVE-2026-97454: ACPICA: add boundary checks in acpi_ps_get_next_field()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97454

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e15aa60de0256d63df2331bf5a4bc4dd287504cd]
stable/6.12: [add715fc1ef5b0a71afe22b3f02aa28775d9ba62]
stable/6.18: [bc5b2158c7626e3e8a78c5bb93ce0a734a26b84a]

CVE-2026-97455: ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97455

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [945e87267cfd90937b3c637f87324cbb56998b72]
stable/6.12: [fe7b3d3b7490c2c0119f2d84fa33996dcbc71042]
stable/6.18: [ef5a8d939c1e5b36e75450bbb5b6348faff4dcf3]

CVE-2026-97456: ACPICA: Fix condition check in acpi_ps_parse_loop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97456

According to the .vulnerable file, this bug was introduced by commit
5088814 in v4.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8de27e2d83c0d07ae9443c6304575b0609394bfd]
stable/6.12: [a477c6ef5335d2d0613ff7c1779a8209f16627c5]
stable/6.18: [5d16f40b019e59df81deb594ed4eafefc8e43cc0]

CVE-2026-97472: ipv6: addrconf: fix temp address generation after
prefix deprecation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97472

According to the .vulnerable file, this bug was introduced by commit
76f793e in v3.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e20d8922aa8fe441d291364c96c2179a005b79ea]
stable/6.12: [bff7b87dfa28a1502c18d0c6f1fadda5162fa854]
stable/6.18: [4df5597c65446135362f72880995e8920f058fa0]

CVE-2026-97473: powercap: intel_rapl: Fix memory leak in
rapl_add_package_cpuslocked()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97473

According to the .vulnerable file, this bug was introduced by commit
26096ae in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfc7d93bc5e12288e5dc6bb54260f68cdf5a5c47]
stable/6.12: [3e9e9337e03be946ec93f2c9d28dab242482be1b]
stable/6.18: [992c60771749d8d8cbfbd06049785fff95c72df1]

CVE-2026-97474: wifi: iwlwifi: mld: purge async notifications upon nic error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97474

According to the .vulnerable file, this bug was introduced by commit
d1e879e in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a40ad60a47f7c904b75a9ff83b39edebf3961c85]
stable/6.18: [1b3b7b521041d55459f8457db8921e9778482063]

CVE-2026-97475: thermal/drivers/tegra/soctherma: Switch to devm
cooling device registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97475

According to the .vulnerable file, this bug was introduced by commit
ce0dbf0 in v4.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee126267bc04bfb03816ae9d71ca24c5bf99e739]
stable/6.12: [6f2a863e7e9adf6088fe644259576181e60ee5e5]
stable/6.18: [deaeb7be8e6b04c8b71080acba1bd88698f56b1d]

CVE-2026-97476: rds: filter RDS_INFO_* getsockopt by caller's netns

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97476

According to the .vulnerable file, this bug was introduced by commit
639b321 in v2.6.30-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c96a5209dda666004b8ee1ed7f0d493d09a4f200]
stable/6.12: [093f172296d32499ffac7809629b206178776eb6]
stable/6.18: [c4081e49ebe0e3160c4b70ec7639494792dee206]

CVE-2026-97477: RDMA/counter: Fix num_counters leak on bind_qp failure
in alloc_and_bind()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97477

According to the .vulnerable file, this bug was introduced by commit
8bc205e in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fbc8230009f5b1bcd13cc74c5a6a43ddba141fd]
stable/6.18: [da95cb016812c0e012ea839f191926e35ca8f57f]

CVE-2026-97478: virt: acrn: Fix irqfd use-after-free during eventfd shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97478

According to the .vulnerable file, this bug was introduced by commit
aa3b483 in v5.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [666c7f9e07925aa0863348f960e09bb89f8f05a3]
stable/6.18: [d8156aacfcabb81f52c20ef89094945434d08079]

CVE-2026-97479: driver core: Avoid warning when removing a device
while its supplier is unbinding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97479

According to the .vulnerable file, this bug was introduced by commit
8c3e315 in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36d74f17e03f7e60e1b08fbe16cfad6e69cc3aa9]
stable/6.18: [73ea4ec0ec46d12558a61842b474e7dd63538edc]

CVE-2026-97480: tty: serial: 8250: protect against NULL uart->port.dev
in register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97480

According to the .vulnerable file, this bug was introduced by commit
4a96895 in v5.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [941c9f84c9b6310f7aaa1c8c785dcc634ee33050]
stable/6.18: [5cbab666721d974bfe033a12045d808936deaefd]

CVE-2026-97481: serial: 8250: fix possible ISR soft lockup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97481

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c6bf45e5a345cc3b9ffbeaf9083ecac3c2293eb]
stable/6.12: [2881b2e6da02daea1eb8254247ba8fd20c9d3348]
stable/6.18: [4295c58990b7a84e8349a2226db692e252825b60]

CVE-2026-97482: usb: gadget: goku_udc: avoid NULL deref of dev->driver
in INT_USBRESET log

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97482

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bf5e3fba9bc7dfd69701521dbe9809f8ccbdb02]
stable/6.12: [10d7fc3008d5b7ec03af8e08927f1d090014c2af]
stable/6.18: [28d78783a871cdb7a637dcb72452ff7d303430ae]

CVE-2026-97483: usb: core: hcd: fix possible deadlock in rh control transfers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97483

According to the .vulnerable file, this bug was introduced by commit
e57e780 in v3.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5559f43d76b398392b26a15cbc16d731969cd1c]
stable/6.12: [fff917c85d37a294397c5440a795591ca9d6b602]
stable/6.18: [549672a3fb6b36ea408238f89ecf9f41d2da6225]

CVE-2026-97484: usbip: vhci_hcd: fix NULL deref in status_show_vhci

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97484

According to the .vulnerable file, this bug was introduced by commit
0775a9c in v4.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc150783542ba2e7c1257d1299c6f3269bdba270]
stable/6.12: [046a94fdb02eb1df86c8fa4614104ff801ba3ab7]
stable/6.18: [dacd7c317ba12e035653c28a0eaaf23d91abc073]

CVE-2026-97485: omfs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97485

According to the .vulnerable file, this bug was introduced by commit
555e377 in v2.6.27-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18c3d6fcb557f920c9143711497625e70153874c]
stable/6.12: [61ffc31cd8642d7a950b6831720629c8331365f6]
stable/6.18: [fd4d6593c51253c79be422d6ae42e318250e20a7]

CVE-2026-97486: hpfs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97486

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a405996f23e04942aad064ab8d50c55827482872]
stable/6.12: [fc79fcc78cb771f2a803e52149cac5ca9050fd05]
stable/6.18: [f27e21cf3c0446a3536ea9b588a78a46b0a2cb66]

CVE-2026-97487: jfs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97487

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05107f5602751fcfd3d108c1f579eb45aabead52]
stable/6.12: [a0ac22af8acca6ea6c57aff72662086cb3243b1c]
stable/6.18: [153374ee67a458c77b5755d3cc57fbdc639d327e]

CVE-2026-97488: qnx4: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97488

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d911ea1cc9a63b07e52f5e75b263be0615b289]
stable/6.12: [aac97a4b3f47c36a47f934aa679407b718b67537]
stable/6.18: [60f7ccf669882262330171eda51a4f52fa2e69c9]

CVE-2026-97489: bfs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97489

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2430e3380936df0b648af720cae624eef035a2d1]
stable/6.12: [7cc713b29eecc0189a184e82f42d174fddaa9e1e]
stable/6.18: [ab1d6160d26e6ee8939e994999be9b45e90a42ef]

CVE-2026-97490: affs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97490

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0861182af5983a39bd2a891966436c5679b74a45]
stable/6.12: [bb45146a661934ef801f8fc62f88cdbcf6584ed1]
stable/6.18: [e01af5aa641039e000af855f448475316f0550fc]

CVE-2026-97491: net/rds: Don't sleep inside rds_ib_conn_path_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97491

According to the .vulnerable file, this bug was introduced by commit
ec16227 in v2.6.30-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16f48efaeb6991193fb7775c577f06f5b20b0c90]
stable/6.12: [db22e77df66353f1299153f6fa9620a2825bc63f]
stable/6.18: [caa51e6da596ed6008cd06605a725568b8e7be4e]

CVE-2026-97492: wifi: mac80211: don't call
ieee80211_handle_reconfig_failure when not needed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97492

According to the .vulnerable file, this bug was introduced by commit
167e33f in v4.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a8a3ff2815501f78f494808355ddf37e08647d0]
stable/6.12: [60b96e44489d6775fe9cd8df619c29e0dc285c49]
stable/6.18: [6fb64029457cdcd77be546daf4c7c7cf04891857]

CVE-2026-97493: drm/amdgpu: Bound GPIO I2C table entry count from VBIOS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97493

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a99cd231cd924b7160fecb9fb3a94b801522323b]
stable/6.18: [f8f0985375c3b977757fd73e2b691ff1bf1ea7b9]

CVE-2026-97494: drm/amdgpu: validate and share PSP fw_pri_buf copies
via psp_copy_fw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97494

According to the .vulnerable file, this bug was introduced by commit
2b0c3ae in v4.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1f9f5839bd785a3a06335a01d53282e80f8e5fa]
stable/6.12: [25bec2425c3d50ba9a92ad87bbf8628be29e5c32]
stable/6.18: [1aa55af304a2decaacca1d1fabe4257c277ca54a]

CVE-2026-97495: drm/amdkfd: Check bounds on allocate_doorbell

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97495

According to the .vulnerable file, this bug was introduced by commit
5bb6a8f in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f087bb8cf9e8797633da35c85435e557ef74d06]
stable/6.12: [e0cecd04a4fc4c75e375b91cf53eab5ba2e4ab7f]
stable/6.18: [c2c89118c27cbd3adace62c5df19d15b0e96ade1]

CVE-2026-97496: drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97496

According to the .vulnerable file, this bug was introduced by commit
42c6c48 in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ef144458f48d5589e36f1b3d83e83db2e5c5ba5]
stable/6.12: [d9183d974ddd5f09d029beaf359275ac20d4d5fe]
stable/6.18: [ec646686613d8ab05b282d1463a7baa49fd6b83b]

CVE-2026-97497: drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97497

According to the .vulnerable file, this bug was introduced by commit
2485c12 in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfe9a7545b2a7be1c543f1741e16f2d5ec4116ae]
stable/6.12: [42f2bd50236b61ad0aeb2c233c990ee0d615fdad]
stable/6.18: [dd2870ca036e1d51baa59f942007b36a595b5890]

CVE-2026-97498: drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97498

According to the .vulnerable file, this bug was introduced by commit
0385800 in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3bbf32a336939a1d21b9561f8e53333b684b7ef]
stable/6.18: [a16d9986b7b27b08a696524a4dbf03dbf5433a16]

CVE-2026-97499: coresight: perf: Retrieve path and source from event data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97499

According to the .vulnerable file, this bug was introduced by commit
0bcbf2e in v4.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f37bc31447c0ddafedb25e3c4a4f4e2284034247]
stable/6.18: [0f4cb08f30011b7625a4fba668fa5c36da5e6637]

CVE-2026-97500: wifi: rtw89: phy: check length before parsing PHY status IE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97500

According to the .vulnerable file, this bug was introduced by commit
e3ec701 in v5.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [884495c39de1a02f42bd40051b921e2311d6ac91]
stable/6.12: [213f9e0ab2b4f35fe8d342333238c6cc91513fbf]
stable/6.18: [98e5720afd7495eece580238f232e3b3b4c022da]

CVE-2026-97501: pinctrl: mediatek: paris: bypass pinctrl GPIO layer in
set GPIO direction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97501

According to the .vulnerable file, this bug was introduced by commit
8052509 in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c87c9046c4e00d599454e033a477176c4d73ac2a]
stable/6.18: [428b031dad390edd5da729b9afd474a95dc4f76b]

CVE-2026-97502: mmc: davinci: avoid NULL deref of host->data in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97502

According to the .vulnerable file, this bug was introduced by commit
b4cff45 in v2.6.33-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f28846aaf8db9668e338b8987973f8935edff34]
stable/6.12: [a01cedf230dc0fcd55b994f5e548d3982ba4c732]
stable/6.18: [5b7e151fe9ea9311ba601849aaecdc4fc97fd577]

CVE-2026-97503: genirq/proc: Size interrupt directory names for
10-digit interrupt numbers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97503

According to the .vulnerable file, this bug was introduced by commit
721255b in v6.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2c7983c93f5d86962318be7e7298f1bc3feb1a6]
stable/6.18: [d4b22fbae70037299e96539c330e4a1054b28a91]

CVE-2026-97504: watchdog: lenovo_se10_wdt: Fix use-after-free and
resource leak risk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97504

According to the .vulnerable file, this bug was introduced by commit
1f6602c in v6.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3394e894880a60338a2981dd688fd25e88d79667]
stable/6.12: [e9adbc3a116dfa8c7b643180dabf6166c99bcec7]
stable/6.18: [c9f1fb55646534370b00824a1fdb47718c72f115]

CVE-2026-97505: PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97505

According to the .vulnerable file, this bug was introduced by commit
91fa127 in v6.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25ec7f57deceec633f27bc93b615f951e2ade814]
stable/6.12: [b722a607f858b9cd036075ea0efad553fb98e982]
stable/6.18: [cbf0628c0b7db86c5ce36451f088101546acbf1d]

CVE-2026-97506: crypto: ixp4xx - fix buffer chain unwind on allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97506

According to the .vulnerable file, this bug was introduced by commit
0d44dc5 in v2.6.30-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25056329384010a8672552b134f609601dc4f80e]
stable/6.12: [04cb00106ca4d0fa9eca24cadc4eda6036e855c8]
stable/6.18: [028a7f4f3d69e551f6bf9f728d547bbf4cfc707d]

CVE-2026-97507: media: dm1105: fix missing error check for dma_alloc_coherent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97507

According to the .vulnerable file, this bug was introduced by commit
a611d0c in v2.6.28-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3eaac9e02d8591d3c790db572ef1c8fa5a841fdb]
stable/6.12: [07d6a76a17b550e94ca5cc0060ad6e77952390f2]
stable/6.18: [f3f135c4fac6194933b952e98a15dc05aa420956]

CVE-2026-97508: thunderbolt: Set tb->root_switch to NULL when domain is stopped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97508

According to the .vulnerable file, this bug was introduced by commit
d1ff702 in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e56249d8a68e712f3b60e1f3fdbb5b4fea146468]
stable/6.12: [f06e9fbae78a51832211b4495a19412c7d49ecb4]
stable/6.18: [99f019d2e9eb79adc485fef8aa8ada2cd0c843e9]

CVE-2026-97509: thunderbolt: Keep XDomain reference during the
lifetime of a service

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97509

According to the .vulnerable file, this bug was introduced by commit
d1ff702 in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [11615a3df6e0c211c0bdb7225bb78b6e82495623]
mainline: [8b4060998637f06975fceee9b73845d8672d411e]
stable/5.10: [a4567e5380e4e46d0ea9a28d2d675e5c6f013d54]
stable/5.15: [daeaa6c7211d03ed061b0dd22a875fad9372b090]
stable/6.12: [8ab12d015884b8aa85ea7ed58c5a0bae4264fe60]
stable/6.18: [ea60ae6233ca0fc0d414e9c11f0d86c63b303fc7]

CVE-2026-97510: thunderbolt: Release request if tb_cfg_request() fails
in __tb_xdomain_response()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97510

According to the .vulnerable file, this bug was introduced by commit
d1ff702 in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c63f29872cb444b33665348bbd2f45cab06afcd]
stable/6.12: [42dddadf6b6131af4d12bfa8bdc84ef954e8cef8]
stable/6.18: [0325d017bf4354a015a02413ee1c7e51266cecf4]

CVE-2026-97511: wifi: mac80211: avoid out-of-bounds access in monitor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97511

According to the .vulnerable file, this bug was introduced by commit
fc41f4a in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03c41203ee5a833a9d7a7630be190830cede29d8]
stable/6.18: [7f087f70e020b16a5b967332ee6e937817eaa173]

CVE-2026-97512: spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97512

According to the .vulnerable file, this bug was introduced by commit
cff8064 in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d283d5d4d9f6d081ddb65e371be26fffeb611c42]
stable/6.12: [62dd3b8d3a92eb4e080b2ae491c2a5341654c1ee]
stable/6.18: [bb18a346271f87889bd64a3861c9a656a3509ea6]

CVE-2026-97513: media: chips-media: wave5: Release m2m_ctx after
Instance Removed from List

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97513

According to the .vulnerable file, this bug was introduced by commit
9707a62 in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cdbd7bb21949a8fda10c7104a2b12ee363cbf5c]
stable/6.18: [04cda0b5c4ca3f61cbc86e41ead3c462c8cfd659]

CVE-2026-97514: media: chips-media: wave5: Fix Reports from Kernel
Lock Validator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97514

According to the .vulnerable file, this bug was introduced by commit
9707a62 in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d5d364f8b2dcc9b6b92456fb55632fde4a4d96f]
stable/6.12: [629a937091ecf9c5c9f7a18f41cb0e6c778a7b2f]
stable/6.18: [072beef6a19f9c84dc5a50c5499663a5734c1096]

CVE-2026-97515: i3c: master: svc: Prevent IRQ storm from false
SLVSTART on NPCM845

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97515

According to the .vulnerable file, this bug was introduced by commit
0430bf9 in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [1effa3adfe53cb2bb28bf5640a676b791d5ab405]
stable/6.18: [e9b139c4684ed8593a0b779ca02ea05f460b2eec]

CVE-2026-97516: wifi: rtw88: Add NULL check for chip->edcca_th in
rtw_fw_adaptivity_result()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97516

According to the .vulnerable file, this bug was introduced by commit
fe7bc23 in v5.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5e6f353ce1e1c25b8458ea390ed09d2377412c5]
stable/6.12: [6fa23cafaf30f4877e357f8eebcff00dff4aa9cb]
stable/6.18: [1d1f250432cd8704c3c125168887f9724021c81a]

CVE-2026-97517: wifi: nl80211: reject beacons with bad HE operation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97517

According to the .vulnerable file, this bug was introduced by commit
7e8d6f1 in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b9a100e1a76c52988b31099b349fd95a58c8768]
stable/6.12: [6c4bb5450b9d9111faaaba581ea45a3a79844e50]
stable/6.18: [0d635f0b4a634eb599ed13a87ece0b5f129f9900]

CVE-2026-97518: wifi: cfg80211: reject duplicate wiphy cipher suite entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97518

According to the .vulnerable file, this bug was introduced by commit
2ab658f in v2.6.32-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7187d145d9042b037e4f10538f70cf95e380219f]
stable/6.12: [1305f8b925fe92edf5fec183588dfc7db719180b]
stable/6.18: [4cbb2360f4d8c29e67bc7a8bf6ba0ae096583923]

CVE-2026-97519: drm/xe: Fix null pointer dereference in devcoredump cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97519

According to the .vulnerable file, this bug was introduced by commit
ecb6336 in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12ef528d78adc8ea4e7e3db594f3bcac327e79fa]
stable/6.18: [f5c3144f783f91d74b4fae84fb8bd7a4edf001f8]

CVE-2026-97520: gfs2: move quota_init qc iterator increment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97520

According to the .vulnerable file, this bug was introduced by commit
de0d95c in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [942202677f8f2ee448a6a2feb06aeeaf520342e3]
stable/6.12: [04ec2f3b29b3c8a59950b8816b5ebc8ba052808a]
stable/6.18: [21a50a9373adab35ffadf5cf59272dc99078170e]

CVE-2026-97521: gfs2: fix quota init duplicate scan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97521

According to the .vulnerable file, this bug was introduced by commit
de0d95c in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b99a1f0f18ee50445907f55069e88bcfd8947383]
stable/6.12: [7fdcf16e5e14e11028f5bcaa6d25075eb5e876a0]
stable/6.18: [812a766e2b0a8f4d094393fad13475c57f5f86db]

CVE-2026-100070: netfilter: nf_nat_sip: rewind offset when NAT shrinks
the packet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100070

Introduced by commit c978cd3 ("[NETFILTER]: nf_nat_sip: translate all
Contact headers") in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16aecbe3036f6097c26b51b12e4c1cf207769690]
stable/5.10: [6828aca3d82717c2fda92af81c0dda642bc2b465]
stable/5.15: [2703f5ea8d85bc729f433ac09ee902084c947122]
stable/6.1: [0f4d30e2e49f343fc28ba1e259fd22969b940c46]
stable/6.12: [668cc1c30caedc63070b10d17d5514748988a140]
stable/6.18: [e70d48fcf8382581162608a4a322919bfd22aef3]
stable/6.6: [810da5a63549531da78348b0a4545042d84e01e2]
stable/7.2: [c408d416618ebb8a95e3097a13f3b793ea9272ee]

CVE-2026-100071: net: hsr: free learned nodes on device setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100071

Introduced by commit 81ba6af ("net/hsr: Switch from dev_add_pack() to
netdev_rx_handler_register()") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f16289b91eb316f170a6bd22d32e6c632f6a5b6]
stable/6.1: [e691eee886871b933d772ffc76d66c80b4c0a25e]
stable/6.12: [f7289e3492f2694dccd3d79287e0e31879b58650]
stable/6.18: [65702339b3e9fd792f65d4b740928798194d86ce]
stable/6.6: [0a340ffd96943a49a78e367efac9517ca767d99b]
stable/7.2: [49b01f2939abc676a6f9a118f07a10110ee5f683]

CVE-2026-100072: ACPI: platform: Use acpi_bus_get_primary_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100072

Introduced by commit 3b95bd1 ("ACPI: introduce a function to find the
first physical device") in v4.6-rc1.
Introduced by commit a252d88 ("ACPI / platform: Pay attention to
parent device's resources") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9ba4dd2f18bf3f439d9ef0d8f375f90360ba1bd]
stable/7.2: [c9d202d3b6c28e8c779cd2f2b10d2f7ab665ca71]

CVE-2026-100073: ext4: fix transaction overflow during writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100073

Introduced by commit 95ad8ee ("ext4: correct the reserved credits for
extent conversion") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46e8e31771f4f1c5e1cdec37a889a6730e42e9f1]
stable/7.2: [a22464c5df5827e884a5a7d3d8fb03870e5bb6c8]

CVE-2026-100074: bpf: Mark bpf_refcount field as unique

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100074

Introduced by commit d54730b ("bpf: Introduce opaque bpf_refcount
struct and add btf_record plumbing") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61e655391cb19c31f94ecd4354f624c81ce4cf75]
stable/6.18: [e42cede6f90177f4f92f80d3de18f628e61d2087]
stable/7.2: [641f814965d733936ca3618d4d5a12a8fa9be00e]

CVE-2026-100075: RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100075

Introduced by commit b99f8e4 ("IB/srpt: convert to the generic RDMA
READ/WRITE API") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b38f98e176050850f41bb6415f3a71400056623e]
stable/5.10: [af00051dbc9f467d4840ec709680660a3f8990fa]
stable/5.15: [717ab4d0614e9446bf8e2de6229464499e4008d6]
stable/6.1: [f1f2252da52cdda912da9993f39f58783b01b38f]
stable/6.12: [be1478849e1abb1e12dc12e14cdbf800cc6fa99a]
stable/6.18: [af073bd245180393bcb15d33d3990a6bdc32593a]
stable/6.6: [f65f45dfa1e6e2eaa9e11c8b8ce8857799cb189d]
stable/7.2: [bd02d644bd19a2795c018635d273d91e45d2bb95]

CVE-2026-100076: staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on
mgnt-frame error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100076

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41b8209376dffbd7b0b85c8bc4697d9166ac62ef]
stable/6.18: [6c9f6a3b9fdd31a0836b681053155b5997c0156e]
stable/7.2: [c48e5aa01525577d6b6e782962a5bfb0e1535cb5]

CVE-2026-100077: drm/msm: Recover HW before retire hung submit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100077

Introduced by commit 1a370be ("drm/msm: restart queued submits after
hang") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b303e1d52811de7d1bcf793560754d4df68d4a1c]
stable/6.18: [e36284257eeca13768687bf8e52f66f8ea0e8794]
stable/7.2: [dc64cf9d71428234389b635d142cb5fe07d57eab]

CVE-2026-100078: wifi: iwlwifi: mei: pass correct argument to function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100078

Introduced by commit 6522916 ("iwlwifi: mei: don't rely on the size
from the shared area") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [905f57aefde4f4092a411c8a55856182fb1c7598]
stable/6.1: [034445e19f12bb8771c58e2ecf1fbd6eac9b5fac]
stable/6.12: [ee91ae7f5815345612d8c0afd5d7efed361bcdb5]
stable/6.18: [6b7d5abf3e374ca3af31ceb6b9b2efc7a48afde3]
stable/6.6: [f22ad9d1077c83718d9e6c84b71726287c1d1ad3]
stable/7.2: [082b353c05b8eaf07e03fc1918c176cd3c216e25]

CVE-2026-100079: usb: typec: ucsi: unregister debugfs entries on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-100079

Introduced by commit df0383f ("usb: typec: ucsi: Add debugfs for ucsi
commands") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eed73a65ab609b79d53de88cccc34b36dfe753c4]
stable/6.12: [7177c215e69658adbd2f2fc5b72e14be9208d2ba]
stable/6.18: [1f44d001620fd3caa30619a9bc73e9d15555408b]
stable/6.6: [fb7393519908befdc094be4ea913f582adbf2f7c]
stable/7.2: [62efee351566321ad72a4abaf6eb7d972590585d]

CVE-2026-97522: mptcp: fix bad accounting in __mptcp_subflow_push_pending()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97522

Introduced by commit 0fa1b37 ("mptcp: use get_send wrapper") in v6.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3ef03357396d4b147d8e76c75fb612c2f264ffc]
stable/6.12: [9781fa35d9f7a87a83115acd3a88bc9ce35b5407]
stable/6.18: [a0a64525f3414268ed4b1945a1dc690aa974dd4f]
stable/7.2: [dc054821e639a2e14f1419436612db70b6af45fc]

CVE-2026-97523: mptcp: close race between scheduler and state change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97523

Introduced by commit c886d70 ("mptcp: do not queue data on closed
subflows") in v6.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [42064de57fb83231fcc89663a94885f228a1ee53]
stable/6.12: [8f11430d51ff8365bc51b670bc3002b65ae4c6b7]
stable/6.18: [a09c87abf10a0a7e203137c75b5381aa63d9b31d]
stable/7.2: [4c856f3c151a2f3fa237caa651c44015916ca584]

CVE-2026-97524: mptcp: avoid unneeded actions on subflow reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97524

Introduced by commit e32d262 ("mptcp: handle consistently DSS
corruption") in v6.12-rc3.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [2b0f561f21b27c40c91ea4975268a06092bd7e9c]
stable/6.12: [4b7abdcb5ba832fafab679f0d998af39cbc99307]
stable/6.18: [b2dbcc1ed48b5ac070a41db4a52aade6823c4df0]
stable/7.2: [ce7e4ede01ed3e47a48c0f1ce1d87bf4864bee9f]

CVE-2026-97525: x86/mm/pat: Allocate split page tables as kernel page tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97525

Introduced by commit 5ba2f0a ("mm: introduce deferred freeing for
kernel page tables") in v6.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [9e4a3ec3411bb6bb59e3c1f29b75609f1e87aac4]
stable/6.18: [84e0cd79d57f06b872154eb5d8f610584133f260]
stable/7.2: [922873cf4fc34124215070a8ad391bf831538bb9]

CVE-2026-97526: s390/pai: Support CPU hotplug for PMU PAI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97526

Introduced by commit 582cc1b ("s390/pai_ext: Enable per-task and
system-wide sampling event") in v6.11-rc1.
Introduced by commit 9f66572 ("s390/pai_crypto: Enable per-task and
system-wide sampling event") in v6.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ecc4d033879f7761f2df07e20cd2fbec00fd90b]
stable/7.2: [706e2bf330144995d123dccf32aaf1981ce5abc2]

CVE-2026-97527: scsi: qla2xxx: Serialize NVMe unsol ctx list with a
per-fcport lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97527

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76da0c43c63eb0496649e372ac64466364d0fe7d]
stable/6.18: [b211d138cad86f749826d6132db6388eded992d8]
stable/7.2: [4d8ad6bc8cc5eff1870cef00a0d611f38f8b6bd0]

CVE-2026-97528: scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on
LS reject error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97528

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e46160a5d4fa59bf4d5f3412b6b5cb79edb967dd]
stable/6.18: [a95fc5f1c12bba1dbff72bd2611e7fad0758831b]
stable/7.2: [c55d649a6cc246c3ccd5d118faea230c46b60f35]

CVE-2026-97529: scsi: qla2xxx: Validate BSG request_len before reading
vendor_cmd[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97529

Introduced by commit 01e0e15 ("scsi: don't use fc_bsg_job::request and
fc_bsg_job::reply directly") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cf38dd9465736141263ebb63375868311a0ec81]
stable/6.18: [740f3458a4798af54aaf8cf63e797d407e8b6d3b]
stable/7.2: [f75bff451a2fac5aed82f9641df1e9a42c5a899d]

CVE-2026-97530: scsi: qla2xxx: Fix soft lockup polling continuation
IOCB signature

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97530

Introduced by commit 9f2475f ("scsi: qla2xxx: SAN congestion
management implementation") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7e3fa7d06bf7fcaac186d3c4d635caac166d36c]
stable/6.18: [6e6c2ba9022eb8f9b062c81bdc6fd24c7b4c4c16]
stable/7.2: [6aa722fca9d2aa1f64094101587f8f4a2f83f6aa]

CVE-2026-97531: scsi: qla2xxx: Skip vport under deletion in report ID
acquisition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97531

Introduced by commit 41dc529 ("qla2xxx: Improve RSCN handling in
driver") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23582731afa35031c94fadb71a4f3b4afd094649]
stable/6.18: [d61e8de98c5a52978fb1edd95fe4dde3131b280e]
stable/7.2: [7a83979d92782f83c90888ebe19bdc9420521940]

CVE-2026-97532: scsi: qla2xxx: Null out freed pointers in
qla2x00_mem_alloc() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97532

According to the .vulnerable file, this bug was introduced by commit
d64d6c5 in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d90f0feb929f6c0f3010f9af4747c7230b75993]
stable/6.18: [a57570229edb7a0990d5c8067daeb9ac8858a961]
stable/7.2: [286d9594a022dd7e0caa3de9daa63b896bc70d43]

CVE-2026-97533: x86/mm/pat: Acquire init_mm read lock on attribute
changes to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97533

Introduced by commit 41d8848 ("x86/mm/pat: restore large ROX pages
after fragmentation") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5d8b8662e6e5a565b47a0388640e88402f23274]
stable/6.18: [e21a9ea81426a85fdb0cdcfcc99d5d9c16b402ab]
stable/7.2: [cc73b2043d106b467accd38e9b1fc09e0607c056]

CVE-2026-97534: f2fs: accurately adjust free_sections during free_segment_range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97534

Introduced by commit b4b1006 ("f2fs: refactor resize_fs to avoid meta
updates in progress") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c963d1738fdca400082ff5f9d99e083de4f4e70]
stable/6.18: [ca31116fad0954c61a0d38163cc51c48e4981b75]
stable/7.2: [8a123a10770d2132d046748f20f02baa8d5539a1]

CVE-2026-97535: scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97535

Introduced by commit 2853192 ("scsi: qla2xxx: Use IOCB path to submit
Control VP MBX command") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [878613ecb5a36db26859c4fd83daf9283a334fa2]
stable/6.18: [48a44e19746eaa70320a3c2571dcb345192fca72]
stable/7.2: [13354ad251ab009102597a791bc7c4d2265229e1]

CVE-2026-97536: scsi: qla2xxx: Fix use-after-free of qpair work on
queue teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97536

Introduced by commit 68ca949 ("[SCSI] qla2xxx: Add CPU affinity
support.") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19788a55cab61d78e33e0914a5a31d27843e8a4a]
stable/6.18: [1710a69fd74d0b4bdfcc57c3309b1c4057f70d85]
stable/7.2: [f1f4d1cb93eeeb250eac9405121933e268eefbd3]

CVE-2026-97537: scsi: qla2xxx: Fix queue teardown NULL dma_free and
bitmap locking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97537

According to the .vulnerable file, this bug was introduced by commit
73208df in v2.6.29-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34a40e0dff940ac5eba494a69b553ea571e24873]
stable/6.18: [f35cb67f2092b49d7949065dd56895ed47238f22]
stable/7.2: [94fc0c5b45de2bf3a691619bcfd10b9a49fc647e]

CVE-2026-97538: hwmon: (asus_rog_ryujin) Validate HID report lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97538

Introduced by commit ed3e037 ("hwmon: Add driver for ASUS ROG RYUJIN
II 360 AIO cooler") in v6.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8042312e73c50de82634ce63eae7cf219464b481]
stable/7.2: [1caa5f9399ff107a8fa221b1eaca0a9e729d3758]

CVE-2026-97539: usb: xusbatm: don't rely on id table pointer arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97539

According to the .vulnerable file, this bug was introduced by commit
733260f in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb6cd6d3d8abeac5d7e8251b898067184afdad8a]
stable/6.12: [fad6cab36474758abf55c6419dd79a06a27fcefc]
stable/6.18: [8944ef1bfda537aaf329c82e7a5f9faf61340aa9]
stable/7.2: [f7db611d98b68d15661561d2cefa774208774ccc]

CVE-2026-97540: net: usb: pegasus: don't rely on id table pointer arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97540

According to the .vulnerable file, this bug was introduced by commit
733260f in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce8101c331956bbd3e20681331dfd22eb7c1c1ea]
stable/6.12: [9425a13960ef38bac237608f25c9ee64ff113086]
stable/6.18: [7654812b65047349ea4c111eed42c4315a00e462]
stable/7.2: [61b84e964a829d534f24eab4cbd4035d22b52601]

CVE-2026-97541: wifi: ath9k_htc: don't store usb_device_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97541

According to the .vulnerable file, this bug was introduced by commit
0ed7b93 in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14d2ac442d660e112efc0ce87ad10085013ed2b1]
stable/6.12: [8e70a6785bd02cf9ef7fd21ebccf46a8ba23014e]
stable/6.18: [9d5e396578097d02e859798207db41ed4b831f50]
stable/7.2: [c34aa59950597e3360e9cef9d08cdf4edb30ad4d]

CVE-2026-97542: xfs: bail out on bitmap errors in xrep_agfl_fill

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97542

Introduced by commit 014ad53 ("xfs: use per-AG bitmaps to reap unused
AG metadata blocks during repair") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eaf580538eb1be3d162400d04c4b7dc4c627296b]
stable/6.12: [e49977bc568c2649cf1a37992e538df8e3779ee4]
stable/6.18: [82a0fd3fe908914425798b6be2b9b0a4f69ff84d]
stable/7.2: [b5309ae6504e9b727d83bdfb2a19f44896a8f019]

CVE-2026-97543: xfs: destroy seen inode bitmap when we fail to add a dirpath

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97543

Introduced by commit 928b721 ("xfs: teach online scrub to find
directory tree structure problems") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a441c6842da75c5b862cc1c9f7969d6a93b54b9]
stable/6.12: [3b10ca4302ee2dda4233f70b2033883ee376fa6a]
stable/6.18: [0b756de8167f2f06ffceadc71cb17c1fc7be4be8]
stable/7.2: [582f54dce62043f7a0503ab8c76d718d0293da59]

CVE-2026-97544: xfs: don't leak dqacct if rhashtable insertion fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97544

Introduced by commit 2004918 ("xfs: track quota updates during live
quotacheck") in v6.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eac8d01d2c776fc26b0ac74aebdf91bc4490891]
stable/6.12: [9036e078bd51683e862afd5ed25ecba2f780b165]
stable/6.18: [7791970a76a3e23f6f51451dbb1e48bd57f94f93]
stable/7.2: [788c3a46ef9d79f875312b95cffe0961a13167a7]

CVE-2026-97545: xfs: don't leak new_bp if xfs_btree_bload_drop_buf fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97545

Introduced by commit e069d54 ("xfs: constrain dirty buffers while
formatting a staged btree") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1930bc578095409c2dcfca6e4e898b24f0f0de6]
stable/6.12: [355b8a5d7e9a38fca8dbf7a4721450252ac7868f]
stable/6.18: [176a53af77b430e1c19ee15fc492145ace666de7]
stable/7.2: [b19dfd4546088a0823e0c47f8ceb6b2775bd1ac7]

CVE-2026-97546: xfs: don't spin forever on zero-length dirents when
salvaging them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97546

Introduced by commit b1991ee ("xfs: online repair of directories") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f84792b40d0c96833341602144574bf0bd14a6a]
stable/6.12: [5442f0c56445618544a801fb4dae35aed87a1aaa]
stable/6.18: [08754ebfa5c28e8d57316b1bd7a5a921a5e2e762]
stable/7.2: [a455c83ce5dc1a2da33b1b84253d298372a8dfbd]

CVE-2026-97547: xfs: fix exchange-range reflink flag clearing issue
with INO1_WRITTEN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97547

Introduced by commit 966ceaf ("xfs: create deferred log items for file
mapping exchanges") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a23eca88448e52eb1a81549862df7adce794fafb]
stable/6.12: [56f87ac2b9543be2be529b831666682e6df4bc40]
stable/6.18: [fac32b9950a2aab3f8659d23b2947b8fb305c3fe]
stable/7.2: [8ae30b9a8c207f9bd03a98eda7b5d641daa79bdb]

CVE-2026-97548: xfs: fix the rtrmap and rtrefcount _maxlevels_ondisk functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97548

Introduced by commit 9abe03a ("xfs: introduce realtime refcount btree
ondisk definitions") in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa301322f72f82f26e4ba0826018d41388ab9896]
stable/6.18: [108114437915e61e8f88d1cbcc442c3f886a347e]
stable/7.2: [84316cb25af95a60e655ccc8fe646bb5ad631b71]

CVE-2026-97549: xfs: fix under-reservation of blocks when repairing sf
directories

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97549

Introduced by commit 629fdaf ("xfs: use atomic extent swapping to fix
user file fork data") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d3c07591534517c633945c8d8e6526f10e3fabc]
stable/6.18: [b8f46ca5cbd629ffb91489ad7f970b3837835b0a]
stable/7.2: [b950e84acd072ac648ace4fea53c0b1212da4b2c]

CVE-2026-97550: xfs: fix unit conversions in per_binval computation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97550

Introduced by commit b2311ec ("xfs: compute per-AG extent reap limits
dynamically") in v6.18-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05cff7c2b79f76c7cfe90613a60e16aaaa051ef7]
stable/6.18: [b5089a328acc83fe2f23127a79397a0bfd9ebc33]
stable/7.2: [cfeba3bdf4dfa405e29f4ee13a20e9063fd0b7ef]

CVE-2026-97551: xfs: initialise args->total for parent pointer updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97551

Introduced by commit b7c62d9 ("xfs: parent pointer attribute
creation") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e4ebb6afaa34bd2e8ce52da231003d24111c2d6]
stable/6.12: [9ad85bce62cadfdf4242f6e6bbff2a52e51d30f1]
stable/6.18: [c66e138af626cad4210da449996ae9e07ee63add]
stable/7.2: [ac9032882d673dd6679e1d873a2dc0131a1aeb43]

CVE-2026-97552: xfs: initialise error in xfs_defer_finish_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97552

Introduced by commit 3f3cec0 ("xfs: force small EFIs for reaping btree
extents") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6176d21d7bd609632c5b7e87a3adb9be29ec1e72]
stable/6.12: [30748a24b9f04f9a83599ba907cc8fbff0729f3c]
stable/6.18: [ba949a14446b7346e92e676ee3fe2bb79d9ce450]
stable/7.2: [6b507c239884f7d4bf8339f6e9eb8bfcb540afde]

CVE-2026-97553: xfs: lock the healthmon when inserting unmount event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97553

Introduced by commit 25ca57f ("xfs: convey filesystem unmount events
to the health monitor") in v7.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7538ba528cfd6f176076186c1b1678fdca1c197b]
stable/7.2: [d963ce1910bc4e23c60a4787af8a3aa3498a053e]

CVE-2026-97554: smb: client: avoid using uninitialized SIDs in
cifs_posix_to_fattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97554

According to the .vulnerable file, this bug was introduced by commit
9934430 in v5.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da6e25842431982d5a53cf00d925b98c690f4467]
stable/7.2: [c9a8b60ce140a68d172452f418137fc7ddbae7db]

CVE-2026-97555: smb: client: fix heap overflow in DACL owner/group rewrite

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97555

Introduced by commit bc3e9dd ("cifs: Change SIDs in ACEs while
transferring file ownership.") in v5.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ee150794c75bcd0be0e24ff3394f433cbae18cc]
stable/6.12: [fb736ab4fb8c4fdb8b2f9ccd3a62e03d11549ca1]
stable/6.18: [7fa84c9ca690643f429ae2709584a47e74b572c9]
stable/7.2: [2a9aee9ef5622d58d8aafaa3263b3ffe70e2d9dd]

CVE-2026-97556: smb: client: avoid leaking refcount when cifs_sb_tlink() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97556

Introduced by commit e8f5f84 ("cifs: fix potential oops in
cifs_oplock_break") in v6.5-rc7.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [23b26f4408ac3f35a482d2e5cf6fc865d4201b71]
stable/6.12: [9ec991e148368e3207e98134c509a625097f7693]
stable/6.18: [dd03fd658ea59821505e0e643b6b7cbdf51c4e1d]
stable/7.2: [1d1b0f1d812a4011a57bc6c70492c34a2e46c6dd]

CVE-2026-97557: smb: client: avoid leaking refcount in cifs_queue_oplock_break()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97557

Introduced by commit b98749c ("CIFS: keep FileInfo handle live during
oplock break") in v5.1-rc6.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [9f2e63f1b2d5fc5b5423424902c091123e220e7e]
stable/6.12: [af0193bbf1ac8c0f67f972998b0cc629d6116cf6]
stable/6.18: [2ed2c29dd9593637cfa25ac1eb23241b20202778]
stable/7.2: [dfe7b750c7e069873a8a57a11c816831a235618a]

CVE-2026-97558: smb: client: fix cifsFileInfo reference leak in deferred close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97558

Introduced by commit c3f207a ("cifs: Deferred close for files") in v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5520e89a5a4f834bced64cf2ac927001cc513a40]
stable/6.18: [a6767712902beb0f53238be485971c9a83ea1079]
stable/7.2: [ea93759d6c2789924f4e557aed5be532207715ea]

CVE-2026-97559: smb: client: fail DACL rewrite when the new DACL exceeds 64K

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97559

Introduced by commit f506550 ("cifs: Retain old ACEs when converting
between mode bits and ACL.") in v5.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d05045177a855386bca5e1909e08d06290e6e3b3]
stable/6.18: [2ef532a01f44687f5b95001e88247cf05bff9892]
stable/7.2: [ee13d687d06a6fbb2008625dd560c654231b28e0]

CVE-2026-97560: smb: client: fix one-byte OOB read in
smb2_parse_native_symlink()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97560

Introduced by commit 723f4ef ("cifs: Fix parsing native symlinks
relative to the export") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [cb26524ef4ac28fcfa554c0656e8dc412c38a8ff]
stable/6.12: [22a9d0a9ba0c89be57558c1aa80dc60a571dd89c]
stable/6.18: [d1f173d28e964ba2c3c4ebe7491d594dc8c77a40]
stable/7.2: [2a302fdbaf7dd00d285303c94af8f48321c22993]

CVE-2026-97561: smb: client: honor forceuid/forcegid when mapping SIDs
to uid/gid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97561

According to the .vulnerable file, this bug was introduced by commit
9409ae5 in v3.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18a72975e9f35aadecc75b031f693f2d1f49308f]
stable/7.2: [e1b74f8f8c1d13190b09fe623b729d36b7ac22a8]

CVE-2026-97562: smb: client: pin DFS superblock in iterator callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97562

Introduced by commit bacd704 ("cifs: handle prefix paths in
reconnect") in v5.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d806d5a85dcbe2a0f181b2f0f9f61ddfbefa1818]
stable/6.12: [ea43a15cea36dc5ddd832be5bddeac7dd804cbcf]
stable/6.18: [a6b6561522212af852c9ad8a7dca8d59ef2c7377]
stable/7.2: [5b01a8c0209690db75341528ec53fd87e0ac1460]

CVE-2026-97563: smb: client: reject out-of-bounds DataOffset in CIFSSMBRead()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97563

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5be5bdda5863eacc964b609ba927764f253431b3]
stable/7.2: [667feba13e78d16393aacb15869f70970f422227]

CVE-2026-97564: smb: client: reject userspace cifs.idmap descriptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97564

Introduced by commit 4d79dba ("cifs: Add idmap key and related data
structures and functions (try #17 repost)") in v3.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9d7eeb0cea5b55b82888f443622fd8d4ee064f3]
stable/6.12: [e5964064e3fbe6325893408faff08ca33de0e2c3]
stable/6.18: [96751028c0d4dec785709ea3eb0ab38a4f2ded96]
stable/7.2: [1d3b24b16a0b013792e8f1e3ed060f0b46f537d1]

CVE-2026-97565: smb: client: reject short READ responses in CIFSSMBRead()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97565

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6142a8bfc230c7263eb8b0475249c958ce49367]
stable/6.18: [0f1f77b821506a4dacab6ce7d29cf9e0c26f14cd]
stable/7.2: [aaa221c1b1d288845b55e9c366e5ef608dfff49d]

CVE-2026-97566: mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97566

Introduced by commit 740d798 ("mptcp: remove id 0 address") in v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ac7d6e620764f1fc79eb4edd3610a7a661981ca]
stable/6.18: [d4a67a880654e1bfe318a31bea0bdbb026a09ade]
stable/7.2: [545616b4e7325be3c61fc082538cb06d14f7b1db]

CVE-2026-97567: mptcp: prevent race between disconnect() and rtx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97567

Introduced by commit b29fcfb ("mptcp: full disconnect implementation")
in v5.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85c580b0d8590520ae00a15c29e9fb9c99427a3e]
stable/6.18: [374da2b9be1280695ce41f108334a8f16e3e54be]
stable/7.2: [69a7b2a912672159dda7dcf325d27752d448dfdf]

CVE-2026-97568: mptcp: syncookies: remember the request backup flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97568

Introduced by commit efd340b ("mptcp: distinguish rcv vs sent backup
flag in requests") in v6.11-rc2.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [b76c0e28b392620dfbaf92cdeedbf115820b44cb]
stable/6.12: [61178d0b85b4b1b53e78b06e89d018d22d102f88]
stable/6.18: [00b2bd518911e0daab00f4749cce68c191ccebb4]
stable/7.2: [06d649f9cd03a9f8e768a658b20acf8d2c8022e0]

CVE-2026-97569: bnxt_en: Prevent queue stop with deferred completions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97569

Introduced by commit cc5d906 ("net: bnxt: Implement software USO") in v7.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39b23c1c40e1f73d2b94a09282cc476af647e438]
stable/7.2: [e33ce547c0cd40738d6bad23e5fc0539ee3e8f7d]

CVE-2026-97570: bnxt_en: Bound SW TPA IDs to prevent crashes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97570

Introduced by commit 54c28fa ("bnxt_en: Set bp->max_tpa according to
what the FW supports") in v7.1-rc3.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0aceaf65b70b3c000e70dd867f3a673015f24ca]
stable/7.2: [05cf64d171772c65bcdee76ee7163c35d9f55a89]

CVE-2026-97571: bnxt_en: Propagate TPA buffer allocation failures in
bnxt_queue_mem_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97571

Introduced by commit bd649c5 ("bnxt_en: handle tpa_info in queue API
implementation") in v6.13-rc2.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [b814dfbfeb0a68c9a52073f2caa05a2d5247a329]
stable/6.18: [c8050386a2209b2a474c1eb4bd1574dc19129bfb]
stable/7.2: [37e08dc821a57fe0592c917486b638caa888b46d]

CVE-2026-97572: bnxt_en: Propagate RX ring init failures in bnxt_init_nic()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97572

Introduced by commit c0c050c ("bnxt_en: New Broadcom ethernet
driver.") in v4.4-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e6a850c0746bb4be167aedf1ee57469fcda09a9]
stable/6.12: [daadccd062fdca5e77a8cc22ffe35857803b6c49]
stable/6.18: [b4c40f2c80d7bf50648878bc206a39adfbfaec6c]
stable/7.2: [dfd73af81cdb9f7b399754a59e2658a08211bee5]

CVE-2026-97573: bnxt_en: Handle buffer allocation failure in
bnxt_rx_ring_reset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97573

Introduced by commit 8fbf58e ("bnxt_en: Implement RX ring reset in
response to buffer errors.") in v5.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [961e2a17c5e3559b3f8654d2daabdd25a42e770a]
stable/6.12: [1a3670b6a6b5679fe56c5890157b344f091e64f8]
stable/6.18: [4a17c73c83798c2fa9c7920ad5a98803adce3e01]
stable/7.2: [8b2fd5c0aeda935294159206af9d6179282d425a]

CVE-2026-97574: bnxt_en: Don't free the live ring's TPA state on queue
restart failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97574

Introduced by commit bd649c5 ("bnxt_en: handle tpa_info in queue API
implementation") in v6.13-rc2.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [5ce7f36c334d723954855ac769ede2fe0e8f89c8]
stable/6.18: [8ade95619cbfd1fc57f0f1a9a5ebdca2345a8d27]
stable/7.2: [0596a7caa6fc283e142716739099c038d8714082]

CVE-2026-97575: media: v4l2-ctrls: validate AV1 tile counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97575

Introduced by commit 9de30f5 ("media: Add AV1 uAPI") in v6.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [439058ced617fbb3febc017b9e93bb7387f309e0]
stable/6.12: [85df9fc79b07f1cc7c953f930ae7e675d0c1e820]
stable/6.18: [c8891da0186fe4c04bccbbd7d84b01a3c941ac7a]
stable/7.2: [c4c88b5ba85685043d171e0e9c9d00a8cf6a89e8]

CVE-2026-97576: media: v4l2-ctrls: validate HEVC tile counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97576

Introduced by commit 256fa39 ("media: v4l: Add definitions for HEVC
stateless decoding") in v5.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc694a9929f7cb9c88ef91e45eb982b7bbe5a477]
stable/6.12: [400cd78a63cc647412cf069c9851bdea2818340c]
stable/6.18: [c7b1ef6dc57f4e57fe27cfdd3bf82033ed91ca34]
stable/7.2: [ba1023d3a6d5d244d59f20c4ba6af4879ae08a9f]

CVE-2026-97577: media: verisilicon: rockchip: reject AV1 frames
exceeding the tile capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97577

Introduced by commit 727a400 ("media: verisilicon: Add Rockchip AV1
decoder") in v6.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [367db8b23c26a913d76ed70457bbcd781c422b49]
stable/6.12: [40029f7f35397853f8711d6fce1d90a4c7a01f8c]
stable/6.18: [a41babf528f70c9a82ed31cfb5fe19065910f7f0]
stable/7.2: [fd965369220cc160bb20a24991790814bfbab401]

CVE-2026-97578: media: verisilicon: rockchip: guard VPU981 AV1 divisor
and tile buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97578

Introduced by commit 727a400 ("media: verisilicon: Add Rockchip AV1
decoder") in v6.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b84f6533a8ed2fd7b282fc7ab4b8efadc745a89c]
stable/6.12: [7baa7bb1b784c19170df8c99466fa412040eb431]
stable/6.18: [8f19d869a9f6800547c9ad7ebaf3b94f973dab50]
stable/7.2: [6b7a281a815ae7c5e7bb2aad039ffea9bc933157]

CVE-2026-97579: media: mediatek: vcodec: bound AV1 tile-start copy to
the array capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97579

Introduced by commit 0934d37 ("media: mediatek: vcodec: separate
decoder and encoder") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37bef2170d4c88fc3d708eecf3ef0f4032bc1372]
stable/6.12: [ad47a250afafa3a51cfb4a004463ff28e66c596e]
stable/6.18: [7992059c045780095ba5a696dcb2f5400a82803c]
stable/7.2: [eb0ea3898e3921900939e30c3946dd2b52281859]

CVE-2026-97580: media: rkvdec: bound HEVC tile loops and PPS id to the
array capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97580

Introduced by commit 3595375 ("media: rkvdec: Add HEVC backend") in v6.19-rc1.
Introduced by commit c9a59dc ("media: rkvdec: Add HEVC support for the
VDPU381 variant") in v7.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81ad46bb33d8fd279aaa33af5296c648814c964b]
stable/7.2: [03beb248d8a7bab30559a60d4df81f167e63b9e3]

CVE-2026-97581: media: verisilicon: hantro: bound G2 HEVC tile loop to
the buffer capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97581

Introduced by commit cb5dd5a ("media: hantro: Introduce G2/HEVC
decoder") in v5.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06236b094c899c22c12ac5097935eb6719293de8]
stable/6.12: [62ae24639d22909a5724627a0467e4bde9704020]
stable/6.18: [4f654c9bc954569ff9b8ab860b29480c4cf6f57b]
stable/7.2: [05e8e4cdfe692f5cedba9aa9d7b8f2584cf926c8]

CVE-2026-97582: hwmon: (gpio-fan) Fix use-after-free in alarm work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97582

Introduced by commit d6fe136 ("hwmon: add generic GPIO fan driver") in
v2.6.37-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2471ed17b0e6ff7bfb6b2ea8e6e5b04c309d293]
stable/6.12: [9b12bd724db9db318e3a68be17693583dc29a066]
stable/6.18: [30755d3a5782cd704c8921cac8ee66dffe4383ea]
stable/7.2: [c6ab7f855891877a16d2e2ddf0cd0305fd098a85]

CVE-2026-97583: afs: Clear stale peer app data after address list changes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97583

Introduced by commit 40e8b52 ("afs: Use the per-peer app data provided
by rxrpc") in v6.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [ba0623fc19a424f4745394c499f9f28a8d88d397]
stable/6.12: [3afb988fd0411707bdafb9b321086fff0da28aae]
stable/6.18: [c7f77a11a1e719192c7262aad38a3919aec62c21]
stable/7.2: [7f7f5589d048821dea316cbac9b37d27eaf7530e]

CVE-2026-97584: afs: Fix incorrect free in candidate cleanup in
afs_lookup_server()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97584

Introduced by commit 4882ba7 ("afs: Fix afs_server ref accounting") in
v6.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [044d596094af4b769fb8e1173dff0d08bd68db6c]
stable/6.12: [981d72663dee2fa6efaf202293e68d2b10a0d1d4]
stable/6.18: [e5bc0fa9959dc8f7eb1afab7c039594a16a1a65c]
stable/7.2: [349e713039a1fd6659c27e7a66238bfa49ce37e9]

CVE-2026-97585: afs: Fix double-unmap of directory block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97585

Introduced by commit a5b5bee ("afs: Use the contained hashtable to
search a directory") in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3cfd3eb7d5be7787cc69530b423f788f14d084f]
stable/6.18: [9d6c703e24da3d39067e3c75f4ac2f6001c2472f]
stable/7.2: [b60f51e4ad0f6f940899788ccc2762db1e3b69e6]

CVE-2026-97586: afs: Fix missing kunmap in afs_dir_search_bucket()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97586

Introduced by commit a5b5bee ("afs: Use the contained hashtable to
search a directory") in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [950ae84b5cc944fbe27d81806d0b76af765f779c]
stable/6.18: [c5fa4eb9c4b2c744ba88fb4ff2d729a158e66832]
stable/7.2: [f57d4728ac54921b871868c5d5bd29b8ab50ee12]

CVE-2026-97587: perf: RISC-V: store available counter mask as bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97587

Introduced by commit e999143 ("RISC-V: Add perf platform driver based
on SBI PMU extension") in v5.18-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6809da6e9c08ccc9a09cb0a48c61471679274aaa]
stable/6.12: [143668c424772979a45118dc9cc9c2c13a35f41d]
stable/6.18: [9bec7beaed074bcae4181fde9ff9dfbe4e7b0957]
stable/7.2: [e5481db31f4654e9a1254d5d467d9b1ff2f8b1cb]

CVE-2026-97588: s390/crypto: Map EBUSY to EIO when key conversion
fails repeatedly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97588

Introduced by commit 6cd87cb ("s390/crypto: Rework protected key AES
for true asynch support") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a08507ea5b4d06ad8d269287913573f34467565]
stable/6.18: [f6b263679aa72ad2e534bf93db55f2589549a40e]
stable/7.2: [e267bd142664a181474112392aeaa8b3d4b12f2e]

CVE-2026-97589: s390/crypto: Fix wrong return code to engine in asynch callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97589

Introduced by commit 6cd87cb ("s390/crypto: Rework protected key AES
for true asynch support") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac1481320110b803ab9b79ab4d2ca11a74fc05f2]
stable/6.18: [972e0d9b7d1d112240ccde1f1be85bf9ffaa1720]
stable/7.2: [5480291aa848e19e61175abfd457933516db70c6]

CVE-2026-97590: s390/crypto: Fix missing scrub of temp buffers with
PAES algorithm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97590

Introduced by commit 6cd87cb ("s390/crypto: Rework protected key AES
for true asynch support") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19a218b46b2471d370c11fb52040f36ac8d05d23]
stable/6.18: [7d1456d54b3c784cc2917c219a528092cefe30cd]
stable/7.2: [d7159d2132e9aa51af7acb51c6742d9b30f987b3]

CVE-2026-97591: s390/crypto: Fix handling of EBUSY in PHMAC when req
is pushed to crypto engine

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97591

Introduced by commit cbbc675 ("crypto: s390 - New s390 specific
protected key hash phmac") in v6.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [330148371401de474b656eaf521861f12ec1a1ce]
stable/6.18: [203702f0013f9b7324e8c5facb6cd6e9c0942b13]
stable/7.2: [bcd7f1f1e2f2882ad206f72425255be105178151]

CVE-2026-97592: s390/crypto: Fix missing scrub of temp buffers with
AES ctr and gcm algorithm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97592

Introduced by commit d07f951 ("crypto: s390/aes - Fix buffer overread
in CTR mode") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [8b7c3b6914f19caf648d05726a86af6326d3c2c6]
stable/6.12: [11eca05d2062032e1f07d56be58ed0b99f4b1d63]
stable/6.18: [8b90a47c4fba27bb4f2f086611742493629e9696]
stable/7.2: [a83488cecb35f924b7541306ed84893bb9906196]

CVE-2026-97593: iommu/s390: Fix NULL dereference in iova_to_phys()
with ZPCI_TABLE_TYPE_RFX

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97593

Introduced by commit 8124407 ("iommu/s390: allow larger region
tables") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20db6573301e66cd65ebf6c130b6563c69374d9d]
stable/6.18: [d0502ed0a1aae97e2ab7a21545903ba612d9f02e]
stable/7.2: [41b5e0ce6801bf04d8fd3bca46e8c393349ebd5c]

CVE-2026-97594: landlock: Fix use-after-free of the source's parent directory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97594

Introduced by commit b91c3e4 ("landlock: Add support for file
reparenting with LANDLOCK_ACCESS_FS_REFER") in v5.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c6dc792538260a8087ac5b22c31b3b8e47c85d6]
stable/6.18: [379efd2ce8b26fd35feb13ccc2f671ff105a5052]
stable/7.2: [ba29c46ccfe3ebadfb8aa18149186c49f84b14f8]

CVE-2026-97595: mac802154: fix use-after-free of sdata via queued RX frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97595

Introduced by commit 57588c7 ("mac802154: Handle passive scanning") in v6.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f37fba846c9fdff5fc15b6d93656057ccd13031]
stable/6.12: [4740ef0518c5e3bf31ebfb2288a6ac3b462ead06]
stable/6.18: [07f0214018d7241e3610c1be984c8abfce16c099]
stable/7.2: [3d1fde35f95d7f02a7dc473c51d81e8d9e992cfc]

CVE-2026-97596: ipvs: reject invalid states in connection template sync records

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97596

Introduced by commit 2754114 ("ipvs: add assured state for conn
templates") in v4.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74cb39735b6cd0aff4b5584158f09376fd97aadf]
stable/6.12: [fc10dc4511e6e2e2b4098ee115c8e5639471f23d]
stable/6.18: [50c3f06222eafe9cca7ca51a0ef83311d7cab353]
stable/7.2: [0c61f7d8e18a978aec2a16d9acd5f682f1c72476]

CVE-2026-97597: ipv6: flowlabel: cap duplicate leases per socket

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97597

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d6cd188508513503805c156165de38e4e4a8615]
stable/6.18: [2f1a6dd5c80ceb902f50449efe899f29cd7918e3]
stable/7.2: [467467bf4209f9f8add0c648bae763f92a0224c3]

CVE-2026-97598: ipv4: fib: bound automatic table ID allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97598

Introduced by commit b801f54 ("[NET]: Increate RT_TABLE_MAX to 2^32")
in v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efdfb1e27a3328085b79540dfe781d537b576ea1]
stable/6.12: [bc8d01d856db106f284b19961af6112e10c3e3b4]
stable/6.18: [fe9a906d2bff2d2707bafd6353b5e032a42aeb35]
stable/7.2: [2c29c053a6627dc4f12fcfe6b4860bcd9e5d7503]

CVE-2026-97599: ieee802154: hwsim: serialize pib updates to fix double-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97599

Introduced by commit f25da51 ("ieee802154: hwsim: add replacement for
fakelb") in v4.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [979d5b8de8ed4e1f997aef12da5694b99be7b871]
stable/6.12: [9973b3a67a7592a780ea12b08334539a900deec1]
stable/6.18: [d3b8f264ce09573aededd0a97dc41c8147797d8f]
stable/7.2: [db6442deecb1f13aeaf4f9d77746ea7555630fb3]

CVE-2026-97600: ieee802154: cc2520: fix FIFOP work use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97600

Introduced by commit 0da6bc8 ("ieee802154: cc2520: adds driver for TI
CC2520 radio") in v3.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff5891b266a7fc6a062710836be84f1cc19338b5]
stable/6.12: [56a9919d8494fb118eebf167bef0622528fbf2e7]
stable/6.18: [c68fd52c73b676aee67020011e98fea125a978f4]
stable/7.2: [890a80d516a1447db5c21bf92841a82914ea897d]

CVE-2026-97601: ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97601

Introduced by commit 51e0e5d ("ieee802154: 6lowpan: remove multiple
lowpan per wpan support") in v4.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf79662bc85e820ac3b846e2f347da29fbf6ac95]
stable/6.12: [1c7710af7ad9532b534f1c134c11b04dbe4e0e0f]
stable/6.18: [98ce5a42cde780ee0e40378607d4428c8fc12ec1]
stable/7.2: [8528da2333ce05cf627f93425f9d05efb08b3146]

CVE-2026-97602: inet: frags: invalidate queues before flushing them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97602

Introduced by commit 006a503 ("inet: frags: flush pending skbs in
fqdir_pre_exit()") in v6.19-rc2.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b824476c56a153934c67c9e0f873e1fd967743d6]
stable/6.12: [b9d77f1652e79e58eac48430d0431c329137efcc]
stable/6.18: [7cb5f4643a7fcdbfbee1fad3cdfc678add62d378]
stable/7.2: [bf3d6c44c84c57e8a4bb7f40ad95b64f9b0198ba]

CVE-2026-97603: idpf: disable DIM work before freeing q_vectors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97603

Introduced by commit c2d548c ("idpf: add TX splitq napi poll support")
in v6.7-rc1.
Introduced by commit 3a8845a ("idpf: add RX splitq napi poll support")
in v6.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dd4c829bac2916be98a3e34b41daaba7f42b4c4]
stable/6.18: [7e4312953788244d47074987d40d76702cf929f1]
stable/7.2: [cd7a1598645b6917a8676b7e2efe8d97ce68a952]

CVE-2026-97604: fbdev: vfb: defer cleanup until the last reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97604

Introduced by commit 5e266e2 ("vfb: fix memory leaks in removal path")
in v2.6.30-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0a34a40ed299c9c7cff6af163a5b883ee9d6d73]
stable/6.12: [86356f13598f59f5acb1754895747dcdaf65a254]
stable/6.18: [5ff1effb047e465cde193d7df95988aa1520035e]
stable/7.2: [3c91e51a53cf805e551e5dc8149cd0539a6dbb9d]

CVE-2026-97605: erofs: preserve LZMA decoders on resize failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97605

Introduced by commit 622cead ("erofs: lzma compression support") in v5.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [617d0d8d199ba1790c94310fd75a22d01c97a8d6]
stable/6.12: [604ce546e1b9f35b1f45588004f53fac6b2869c1]
stable/6.18: [0b3c8c39e50249470f00a5f73c288b95a55ab576]
stable/7.2: [38e9e07ac02a9453a117410776f1502a9980997e]

CVE-2026-97606: fs: autofs: fix memory leak in autofs_fill_super()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97606

Introduced by commit 66917f8 ("autofs: add: new_inode check in
autofs_fill_super()") in v6.7-rc3.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ab54837fce04a1c9923d0bfd3d5de51fdc768b3]
stable/6.12: [4262b91e08e74cb5209ea737c554cf983d332382]
stable/6.18: [9933ad1c4ff67680cd59c47f6d2e81b533bcd467]
stable/7.2: [6259b5d9bdc45fdb3158406b28c27fa074823159]

CVE-2026-97607: vdpa: ifcvf: Put device on unsupported feature error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97607

Introduced by commit 46fc091 ("vDPA/ifcvf: implement features
provisioning") in v6.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d470be71196ca0ce302e6623454533dc31b465b]
stable/6.12: [2d7b5fbc7180dc9a0d105b97390422a11ccfe9cd]
stable/6.18: [5ae2dab5d88e527cd55e9dc642f39a2993e81754]
stable/7.2: [816fd60fea5d58944086c1fc5587daa71f3d929f]

CVE-2026-97608: netfilter: nf_log: unregister loggers before per-net teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97608

Introduced by commit 5b023fc ("netfilter: enable per netns support for
nf_loggers") in v3.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c018cc4842c33f0c732962e2ab58635e8ae5823]
stable/6.12: [eaec35fae8f2052c1878a5c7cc7699d8357d79f2]
stable/6.18: [64803ba0a05791cf9ca874466480e4c4cadaf7ab]
stable/7.2: [dce24f3a146948595bb1b86347f31e20b4975daa]

CVE-2026-97609: netfilter: cttimeout: prevent UAF during module unload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97609

Introduced by commit ebfbe67 ("netfilter: cttimeout: use net_generic
infra") in v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fec9b1de0d02de8dafa3cc344bcb91cf28660643]
stable/6.18: [a7fdd86c386b7f7cc72a126389c2cdb55d035221]
stable/7.2: [1f69c570a73f2dedf75ea5166d47622d5fa958c1]

CVE-2026-97610: netfs: Fix uninitialized return value in
netfs_unbuffered_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97610

Introduced by commit a0b4c7a ("netfs: Fix unbuffered/DIO writes to
dispatch subrequests in strict sequence") in v7.0-rc3.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [f18e8774f4d3137fa0a5fb8ffa83d59a719666d8]
stable/6.18: [3d038eebdbd400c3bc4b66bd8aa0dff0c2bcce26]
stable/7.2: [2e38d500471d097cda87d7d374bbc1b13493075d]

CVE-2026-97611: net: openvswitch: fix use-after-free of the flow table
mask array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97611

Introduced by commit eac87c4 ("net: openvswitch: reorder masks array
based on usage") in v5.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba4ba11ed6eb8972c69070417fc27b48deb002e8]
stable/6.12: [cd982e11684def5d4a9fcfd5354de09032828414]
stable/6.18: [a0d18d21d48a551f82ee344e50efb8a682161489]
stable/7.2: [035e9c3722067648a99010711d0ce81f42572ef4]

CVE-2026-97612: net: mpls: clear inner_protocol when the last label is popped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97612

Introduced by commit 48d2ab6 ("net: mpls: Fixups for GSO") in v4.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78a86d75a70e1e227711c72865c59b1422d0a5ae]
stable/6.12: [011e17b5cae19b9f6a150923275e41c278de64f0]
stable/6.18: [da8c3a7f5d3137fec4ff60a6248f5f6d66b6a63e]
stable/7.2: [b39120523475d6b436be7f6cb27d48064148a327]

CVE-2026-97613: net: mana: Reserve extra CQ slot for the fence completion CQE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97613

Introduced by commit 6cc7444 ("net: mana: Add RX fencing") in v5.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80dd7e754b3aa9637a0758ad93fa209f9650ec48]
stable/6.12: [62eb52454afcc1d390b8624c5d1ddc92cf382f39]
stable/6.18: [1e43c407624d2111c19d4d8ffe9b2191a0ec42de]
stable/7.2: [6c739cb89ebd6cf225dac46d2721e11927a7ead4]

CVE-2026-97614: net: dsa: tag_brcm: legacy FCS: request needed tailroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97614

Introduced by commit ef07df3 ("net: dsa: tag_brcm: add support for
legacy FCS tags") in v6.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5be081b83abd3f17d908953b4bb77279f5a149e3]
stable/6.18: [709451db123d90743fa9104b48f324a8e49f8c6f]
stable/7.2: [3eb5c7e1c154c74568620a25c6751bb8d6d8d728]

CVE-2026-97615: net: bridge: use option bits for CFM/MRP frame handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97615

Introduced by commit 90c628d ("net: bridge: extend the process of
special frames") in v5.11-rc1.
Introduced by commit dc32cbb ("bridge: cfm: Kernel space
implementation of CFM. CCM frame RX added.") in v5.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a49e6b16f36b8e085521699adbca3e321b6dd0c]
stable/6.18: [994fd705ca498223d188024cde833739a9dddbd2]
stable/7.2: [42e033c8f30fd2923ccac3373ae70797e521dae1]

CVE-2026-97616: net/sched: act_api: release all action references on
NEWACTION failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97616

Introduced by commit 55334a5 ("net_sched: act: refuse to remove bound
action outside") in v3.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [478eb5abb51931a152abab068f8a717b7ff480fd]
stable/6.12: [f908c8a969946a45225fd7f9d9a85771e12ae0a8]
stable/6.18: [64b36eaef6ea5ada9aea4c2cf87099aaa8a4869b]
stable/7.2: [048617743febf6530111cfb594e9bbbd7918bf67]

CVE-2026-97617: ring-buffer: Check resize_disabled before publishing
the new subbuf order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97617

Introduced by commit 117c392 ("ring-buffer: Introducing ring-buffer
mapping functions") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d860c67c051685abb0460b593b193f0f45f4fa92]
stable/6.12: [f2099644e1b2a2c0805c5240d63ab0522d9d0174]
stable/6.18: [9fd4ea952e6ac12a63c3fe89f08ad02771aa2c06]
stable/7.2: [32bf47db9237c5b8b6f6aaa5356bb4c79d241f76]

CVE-2026-97618: io_uring/net: don't overconsume buffers when using MSG_TRUNC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97618

Introduced by commit ae98dbf ("io_uring/kbuf: add support for
incremental buffer consumption") in v6.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6028b543884f8735e057ec9eea4908cd61cab230]
stable/6.18: [927d96f91c582b319d104ecf50ec935a8dc29193]
stable/7.2: [2e70ea75c7bb38a6dc212975f887310f14f7c043]

CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97619

Introduced by commit b000145 ("io_uring/rw: defer fsnotify calls to
task context") in v6.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [796aa0547557e63338657ed1c487906f9fac4c73]
stable/6.18: [cc580cee4dfa2ec9099c30ecbd4d804cbb996432]
stable/7.2: [055d43a1233edbd80e558889258105ce63051bcd]

CVE-2026-97620: drm/xe: Flush LSC untyped L1 dataport cache after
rcs/ccs batches

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97620

Introduced by commit 9f8f93b ("drm/xe: Emit a render cache flush after
each rcs/ccs batch") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5fcf7e638b904397ec0f66d3ea6766ef0cfe25b]
stable/6.18: [fab569a69c3ae9beced68307e36048efa2709bec]
stable/7.2: [92393fc5227b2b701f2b1530c9cd6dac6ee90b71]

CVE-2026-97621: drm/rockchip: analogix_dp: fix unchecked bound
endpoint name length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97621

Introduced by commit 729f8ee ("drm/rockchip: analogix_dp: Add support
for RK3588") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc69439d983cc491cc86e01fafc1deb94e1bb85e]
stable/6.18: [49f5268f43a791dd0d9ff554cce25a3685c7250b]
stable/7.2: [2fcd112caa4ebc64fdcb509f0b26d8daa3fac950]

CVE-2026-97899: drm/i915: Fix memory leak in query_perf_config_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97899

Introduced by commit 4f6ccc7 ("drm/i915: add support for perf
configuration queries") in v5.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbd3dafc2003db679ccd2f6c6a2551db79657049]
stable/6.12: [d004303557924077a327d71c80f5863b1b9ff1d7]
stable/6.18: [9ac6db531abe98adfd395fea25c00fee37de8154]
stable/7.2: [59e0a04d95e160547065ab3704bd809ddf3f0e1e]

CVE-2026-97900: drm/drm_exec: fix up contended obj when num_objects is 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97900

Introduced by commit 0959321 ("drm: execution context for GEM buffers
v7") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [159720704d9d652b64390c11fb971e15b0a78d23]
stable/6.12: [831cd124ce99c3e61266bed30519d52f7c26abed]
stable/6.18: [f3e74866018dab793ebee1fdf0ef34f7271d1f8c]
stable/7.2: [a565022c02f218ec9789c2baf4690792e7a48cbb]

CVE-2026-97901: genetlink: pin family module during policy dump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97901

Introduced by commit d07dcf9 ("netlink: add infrastructure to expose
policies to userspace") in v5.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a1094c34d176827b2b173e163dcc964a13af93f]
stable/6.18: [508387ad95ef9c13aa6431678c39763e882da2dc]
stable/7.2: [6d8e653fcf1c90310797eeba8e5fafe9ccc3de9e]

CVE-2026-97902: fs: don't return -EINVAL for successful nested thaw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97902

Introduced by commit 7366f8b ("fs: handle freezing from multiple
devices") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe967191e5851ea79818c5fe4e781c3882139218]
stable/6.12: [111339816138f042a59778322f941edc26903484]
stable/6.18: [76e478499913dc1f368aebe85b28b7d1265985ff]
stable/7.2: [ff2a694f6613d54ebd77ba72583d4d94446f55bd]

CVE-2026-97903: exit: hold a reference to thread_pid across proc_flush_pid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97903

Introduced by commit 0a36bad ("release_task: kill the no longer needed
get/put_pid(thread_pid)") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdd812d0683dee14ead02c9eded568685e61b23f]
stable/6.18: [bcb0936862f2b653114d9bd582ca26990ef54a64]
stable/7.2: [96803a12e8ac15f0a1b4b151db59038f12304e58]

CVE-2026-97904: cpufreq: initialize policy rwsem before sysfs publication

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97904

Introduced by commit 2fc3384 ("cpufreq: Initialize policy->kobj while
allocating policy") in v4.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e5d1bf4bd687beb2cb4e32a07af695455925588]
stable/6.12: [dc11263cb05ed519758fd135fe08d611bad1f241]
stable/6.18: [27c9b491bf7604e83b50c3bbfa18a30266ff345f]
stable/7.2: [2cee937f779f69b195b37bbec1e888da9bfe9d58]

CVE-2026-97905: cpufreq: zero-initialize policy cpumask before sysfs publication

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97905

Introduced by commit 2fc3384 ("cpufreq: Initialize policy->kobj while
allocating policy") in v4.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54d37bcf2f497140b9207968557ddb484058e749]
stable/6.12: [0de2f3918fbbbb767e7e716178194b66560dd12a]
stable/6.18: [6e166b9281dec98aed19213a84235250e5fdb081]
stable/7.2: [bbc0472d2270bf732142ca71579d6ede636174ed]

CVE-2026-97906: bootconfig: Fix integer overflow in initrd size check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97906

Introduced by commit de462e5 ("bootconfig: Fix to remove bootconfig
data from initrd while boot") in v5.7-rc5.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7812d6dab0698001e50e8c2f901e17da3eb6f429]
stable/6.18: [8d4343a411eaa182d323ab5b149496416015f27d]
stable/7.2: [bff9a1579e2c9b2a59fdf3793becc9d7bf5ff1a6]

CVE-2026-97907: Bluetooth: btrtl: Don't leak return code when parsing
firmware format v2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97907

Introduced by commit 9a24ce5 ("Bluetooth: btrtl: Firmware format v2
support") in v6.4-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83e3e515fd261600ed8491fb0a8bcdfb115c904e]
stable/6.12: [90f3a142b5f8596a565b8e080d18a8050be6edef]
stable/6.18: [422f6547259654bae690713614c794dd1e2c0a0b]
stable/7.2: [c4249cf6e80b1bd62a6a409aaabe760fe025dac3]

CVE-2026-97908: Bluetooth: btqcomsmd: destroy RPMsg endpoints before
freeing hci_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97908

Introduced by commit 5052de8 ("soc: qcom: smd: Transition client
drivers from smd to rpmsg") in v4.12-rc1.
Introduced by commit 9a39a92 ("Bluetooth: btqcomsmd: Fix a resource
leak in error handling paths in the probe function") in v5.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [f5a427b16e45210dee656b0860728f3d496dee85]
stable/6.12: [962dcc1d8a52e64428cae07806e7f6b8d3ec6ac0]
stable/6.18: [2dcc2240b4e5f6e5dce1736f82666aba40eb3b13]
stable/7.2: [2d016208a011558f211ec9687889df8318654730]

CVE-2026-97909: ASoC: sti: initialize IRQ lock before requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97909

Introduced by commit d05d862 ("ASoC: STI: Fix null ptr deference in
IRQ handler") in v4.11.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04405aeef4f8d7bcac6dcb1947acafdb4420c2c3]
stable/6.12: [f1e7b74512164314d0550ec5b62e3d40b95b0986]
stable/6.18: [998ca92f69bc43499705016d02ffaf0663126d57]
stable/7.2: [a42dd4dae4c9191caa017cf54cc40b6bb125be65]

CVE-2026-97910: ASoC: sprd: validate compress buffer sizes against
fixed allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97910

Introduced by commit cce1396 ("ASoC: sprd: Add Spreadtrum audio
compress offload support") in v5.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a4ce92d150b9e7ecf1a710a34d8cdeb590d3751]
stable/6.12: [38a9bb5221bcdece5507299f739c6751d8fc16b2]
stable/6.18: [ff63b0adc4f6a5b61c8393d204fac44c594c4d39]
stable/7.2: [8064b73997f137c00a7e2e38295a763f9423928b]

CVE-2026-97911: accel: ethosu: Ensure SRAM region size matches job

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97911

Introduced by commit 9cff907 ("accel: ethosu: Validate SRAM size on
submit") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b39d680c9e0fb4d625f2916980977622e84248c]
stable/7.2: [50c27d412fedc95b8d54d477af47451a382e8cdd]

CVE-2026-97912: accel: ethosu: Ensure SRAM size is 0 on mapping failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97912

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5376d7e0fb703876199d3b6f9f97e128fa2f8a4]
stable/7.2: [e5576641b79ecd36acaf91fec4a5333b1ad19c57]

CVE-2026-97913: accel: ethosu: Ensure cmd stream ends with a stop op

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97913

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb3a41fd35e352fba387c4320a1fa0352f3e551c]
stable/7.2: [bf957f166f7ba548034db2a10e63f71df97f12e2]

CVE-2026-97914: accel: ethosu: Fix ethosu_job_open() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97914

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3c8d4672f7a8735e2884cefcd89286268e88b2e]
stable/7.2: [e98afe5142add34b70b305408317a325f14c37f5]

CVE-2026-97915: accel/ivpu: Limit firmware log name prints to field size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97915

Introduced by commit d4e4257 ("accel/ivpu: Add firmware tracing
support") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95bf070f3225dc7175725438c916ad321d42fe45]
stable/6.12: [6dbba89df4e842d226f5cd3dbc5e94533cfceea2]
stable/6.18: [5d06257359c9006a208fece9eb7f0a0e83e0cc92]
stable/7.2: [3d7130807009e9be6132c1394a2c7708a3ba39a7]

CVE-2026-97916: accel/ivpu: Validate firmware log buffer metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97916

Introduced by commit d4e4257 ("accel/ivpu: Add firmware tracing
support") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0724afc55c77c36c7feb9a7264b02aa7593c5c2d]
stable/6.12: [8ec3d6972f1440fae6c8dadd1859892775208759]
stable/6.18: [40868f80a89199630b03d4457876f9a1feba0660]
stable/7.2: [b1555f63ee1a680f280bc18e8dac416f250e2ec3]

CVE-2026-97917: accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97917

Introduced by commit 647371a ("accel/ivpu: Add GEM buffer object
management") in v6.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3837c3f29fbc3b8c12bebf5c62741e2befe3482a]
stable/6.12: [5419be345f32222750e006b85b7f9bae1a285c8e]
stable/6.18: [43c68f52aecd519eb682fa09d57ae52c896f860f]
stable/7.2: [29f82a2280e170429370e7a842cde4e70ead8547]

CVE-2026-97918: tracing: Undo the registration when enabling the
histogram trigger fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97918

Introduced by commit 067fe03 ("tracing: Add variable reference
handling to hist triggers") in v4.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92383cef66791a0c63a2f27755cadbdb2fbf270b]
stable/6.18: [51b07104d563d4be2be34158d3b9d922ca417642]
stable/7.2: [bfa6bc11aef93a3d9db0ac9564b734849a9d959b]

CVE-2026-97919: tracing: Take the reference before publishing the
named histogram trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97919

Introduced by commit 7ab0fc6 ("tracing: Move histogram trigger
variables from stack to per CPU structure") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [0fe23b8eaba0d3372c66b7b31204408da0715edc]
stable/6.18: [2ffaade3611bd9501bc0b9d5d19fc75bfee7a16b]
stable/7.2: [91c15cdda6033e2439f5975b938754152f3d6e38]

CVE-2026-97920: tracing: Keep the entry count when the histogram stats
allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97920

Introduced by commit abaa525 ("tracing: Add .percent suffix option to
histogram values") in v6.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [06f5634ec5584954177f9a22e36b3bfb398a971b]
stable/6.12: [9bd8321f5370295d1ae96dd17d43be3c9edd441b]
stable/6.18: [c80b2a8067d58ff7d268ceef781c68b37a16c321]
stable/7.2: [17e87ce55f877efff1b08fe509e8bf91378cbbc9]

CVE-2026-97921: tracing: Free histogram the field rejected for a bad modifier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97921

Introduced by commit e30fbc6 ("tracing/histograms: Allow variables to
have some modifiers") in v6.4-rc5.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [230234d12ce42ab04132a32c3a848f07a5d27a71]
stable/6.12: [e787361bb6b0026ea3eb4d3fa7a304c7fcb99555]
stable/6.18: [b22dc0add7d72b8bd9cae3188db0dd65da1c8652]
stable/7.2: [891c21f6d5673b2a519b536243bfc6dd2d35beb6]

CVE-2026-97922: tracing: Free histogram var refs regardless of how
often they are referenced

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97922

Introduced by commit 8bcebc7 ("tracing: Fix histogram code when
expression has same var as value") in v5.5.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [4bddcb346a6cf4615ca77f69a589623b877ca267]
stable/6.12: [e7b6d67b43caee9183a4374d23641578ea556e6c]
stable/6.18: [4cff53bb19412c6f2d90b50678de5c3903f7f96a]
stable/7.2: [94bbd65da4ae26592fa1977a74ee94218ab02a26]

CVE-2026-97923: tracing: Free histogram the var ref when its
initialization fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97923

Introduced by commit 656fe2b ("tracing: Use hist trigger's var_ref
array to destroy var_refs") in v5.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [516001d53e6b2ea95a251ee2ef54a1a689a3fd58]
stable/6.12: [74375caa20fe5165807b4334c783d1790b01f02a]
stable/6.18: [222abcbe7866fef04563b6eb89fb21f627dcbc77]
stable/7.2: [a69baeac38677270656e85753d93856a076dee57]

CVE-2026-97924: tracing/user_events: Don't destroy fields when event
removal fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97924

Introduced by commit 7f5a08c ("user_events: Add minimal support for
trace_event into ftrace") in v5.18-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2deb753127d7b7035e893955c5e91875e767d1f8]
stable/6.12: [9c62b7e92b6086a2a0aeb71f3553dd8cf7fdcd8b]
stable/6.18: [0892da2272ec565858aa1ec5458552d699de9142]
stable/7.2: [62d6544e86506bb0695c9594c713cba859666f2f]

CVE-2026-97925: tick/broadcast: Plug clockevents replacement race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97925

Introduced by commit f8381cb ("[PATCH] tick-management: broadcast
functionality") in v2.6.21-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [113a9796effe3376d2ec5aabcca1fef4fef4cd62]
stable/6.12: [3da55616db2b6b7d9caa3b7ff1e8983224e0ed52]
stable/6.18: [3525b94b2f258e0b99d1ee5a82a80b51bc1cc818]
stable/7.2: [292b7a8ed84032cfdfc9076a690360f7d3f640d4]

CVE-2026-97926: ufs: validate cylinder group metadata before caching it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97926

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9d263be26806d388129fab8c6904bed197fc6af]
stable/6.12: [5902a95066883cf96fa15b2680694fc5dd0c7d11]
stable/6.18: [87b12dc360a002eb2d498aa4f01e84347019612d]
stable/7.2: [abde9eb33106850dfa367ad3965d3588bb8558d5]

CVE-2026-97927: ufs: create the root dentry after loading cylinder metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97927

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55a4c98abb9694b067c6a031d11501f06b6b523c]
stable/6.12: [a9804121d55aaa4319c1cac00b99794aa177dd6a]
stable/6.18: [785e523b6c1931d802cab9f85912f3e6c7028af1]
stable/7.2: [8173e051a8acbb4ae6547be0436727944119e0b5]

CVE-2026-97928: drm/amdgpu: skip the VMID 0 flush for VRAM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97928

Introduced by commit a68c7ea ("drm/amdgpu: Enable clear page
functionality") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87ceb8cba73d0b3c4025ff42495bccd8164acaed]
stable/7.2: [241d7450cf75969cea450eb3e740cb9682f69c2f]

CVE-2026-97929: ALSA: usbusx2y: validate URB actual_length in interrupt callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97929

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f5ef203abda9dd36b2af473c7b737d544f807bd]
stable/6.12: [c156584999bf15118f523ef6c6fedc5b21f46bd9]
stable/6.18: [b0c30fe6c0d5902bd8a7d1d5720bead5bbe46f7d]
stable/7.2: [2770321b358658e0a39fe39ccf6a91ee97a81931]

CVE-2026-97930: ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97930

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [861111a14740e12c36d363e9830f8daa734279c9]
stable/6.12: [229cab526580f82839ae8e4e379753c8cf16952e]
stable/6.18: [381495b5b3da12d714e53d9d12d955b13fe26eac]
stable/7.2: [b5753bdfd909f7f095fb464d67802b5e52cbadbf]

CVE-2026-97931: ALSA: us122l: Prevent write upgrades for read mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97931

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71c610aeb1770302ac9c9e0b9a4ecd37f1311928]
stable/6.12: [64a87950239867682cde128020e1a47088295e5c]
stable/6.18: [d9c537b14f4982f17b103e3a2cfeee4bee6bc026]
stable/7.2: [0eb9dd4774af0ac4d1fd105ef2b0a1f6cec06f2f]

CVE-2026-97932: tracing: Don't dereference trace_event_file in
deferred trigger free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97932

Introduced by commit e091351 ("tracing: Delay module ref count for
"enable_event" trigger") in v7.2-rc5.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcfe2816e6ec46c3f4c58aa4264476665ddb3f69]
stable/7.2: [67fb91a7f7bb1d958cf9cc249c912bca9b2fc821]

CVE-2026-97933: tracing: Take trace_array reference when opening a
tracer options file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97933

Introduced by commit 7e2cfbd ("tracing: Have option files inc the
trace array ref count") in v6.6-rc2.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [ed0aff60f83a9bdc2f6556376ac79c96b3ce7e80]
stable/7.2: [b2fb87d29ffb3a7a9ccc5acf12898ecb80587427]

CVE-2026-97934: tracing: Fix memory corruption from a "STACKTRACE" histogram key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97934

Introduced by commit 4b51286 ("tracing: Rename stacktrace field to
common_stacktrace") in v6.4-rc5.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f711e62355bb3123a2ca2f97a2facbfebc678c6]
stable/6.18: [9e026a91fe79966e2baabd4345c6e3a26975c729]
stable/7.2: [c27f8b68c05808bb4f2bcde0e6d1c954a4b65f8a]

CVE-2026-97935: tracing: Set the trace clock before registering the
histogram trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97935

Introduced by commit a4072fe ("tracing: Add a clock attribute for hist
triggers") in v4.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ede78d0563a2a3ae3e46f9c07cedb5d79645429]
stable/6.18: [cfad128171f8e2237a3c723d6478ef2cfb3b9127]
stable/7.2: [65d1e28198f344832a8a63e8ccf84b8f65b92a32]

CVE-2026-97936: tracing: Fix memory corruption from the histogram
stacktrace modifier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97936

Introduced by commit cc5fc8b ("tracing/histogram: Add stacktrace
type") in v6.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5e70ba87ca8ebc79b4e63de302d03b0625fe153]
stable/6.12: [e183b84968d4a6ea476d806ea97668405aa56880]
stable/6.18: [57bfc2a17954d173d2a4182f3b582ffbb23aff64]
stable/7.2: [55caaf25da2c2bb9b75307e4c868726cb954b1d6]

CVE-2026-97937: ftrace: fork: Initialize function graph state before
copy_exec_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97937

Introduced by commit 6b1c66c ("exec_state: relocate dumpable
information") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08cacffeef8f64f1a222c93467ca84f24a46c953]
stable/7.2: [1fadebbbf31f65beba353fa9d1373bf183e03fed]

CVE-2026-97938: reboot: fix cad_pid use-after-free race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97938

Introduced by commit 9ec5209 ("[PATCH] replace cad_pid by a struct
pid") in v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a88f78df753993469dab4d1831f8fb4256a9468]
stable/6.18: [ad72e2566643fff7f01666d845fb026898155e1f]
stable/7.2: [9a17b0e053197a6a42cdc75e75a35b17aa662088]

CVE-2026-97939: ipmr: account multicast table and route memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97939

Introduced by commit f0ad086 ("ipv4: ipmr: support multiple tables")
in v2.6.35-rc1.
Introduced by commit d1db275 ("ipv6: ip6mr: support multiple tables")
in v2.6.35-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7ee18725f2292ab554aa96a101ae42d45f008bd]
stable/6.18: [0264b3ee09b118fec8a5471b4ca288f8ab84722f]
stable/7.2: [d0a2e2a4ee6bfe51e398bfb6921a7d0f4c26bc1c]

CVE-2026-97940: ipv6: fix fib6 walker UAF on seq stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97940

Introduced by commit 8d2ca1d ("ipv6: avoid high order memory
allocations for /proc/net/ipv6_route") in v3.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19b4ed644d68098cc62ab612727f40d30f43476c]
stable/6.12: [0eede1689610e9eeaf729ba86fd1321799eb91a0]
stable/6.18: [b89b691dd00bf39b9ba39ab9446f8c62f419fa7b]
stable/7.2: [4553cfafa8d05c4ce20b1d18f79d9bb3b303fc02]

CVE-2026-97941: mm/slab: take n->list_lock in
__slab_try_return_freelist() to avoid race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97941

Introduced by commit ba74253 ("mm, slab: add an optimistic
__slab_try_return_freelist()") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a724bcf5d703e18957397914d79156fa2cf1174]
stable/7.2: [570a6aaf6b52c6ec098f4811cdb52b1496f13d15]

CVE-2026-97942: x86/alternatives: Exclude text poking against change_page_attr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97942

Introduced by commit 64f6a4e ("x86: re-enable EXECMEM_ROX support") in
v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1587d3394e254639cc36516256031334095e6ef3]
stable/6.18: [281e6f536f2f3f95d91938c5bd7ba9bcb4c1049d]
stable/7.2: [89c60435b90d32ab5e3a39da3ae73d463d07debe]

CVE-2026-97943: x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97943

Introduced by commit 41d8848 ("x86/mm/pat: restore large ROX pages
after fragmentation") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1c7570cedd03372812a5b693732880867babbca]
stable/6.18: [35820cf8dd521f5a651e221483015b0586794516]
stable/7.2: [93b98882198b15bd482da1fe8e84b05c7c3b3d83]

CVE-2026-97944: x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97944

Introduced by commit 85a2d4a ("x86,ibt: Use UDB instead of 0xEA") in v6.18-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a5d26f2cfe13467166219f6bf58099326912ddb]
stable/6.18: [cd9b4595d6283f9b8a35d7ae607508de45a351ce]
stable/7.2: [67cf94c30a8b5ebc839f282f5c5a522b35903524]

CVE-2026-97945: x86/mm: Fix user-space data loss with MADV_FREE and THP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97945

Introduced by commit bb3aadf ("x86/mm: Start actually marking
_PAGE_SAVED_DIRTY") in v6.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7491d7c81db0e7c304a7bd757a76d2fbeaff80e]
stable/6.12: [e4d569fe2f436a9b58c048fefabf56eab68c1b7e]
stable/6.18: [55ddbc2ca6d5db64d44c3fb8f8705b4d39eb30b7]
stable/7.2: [a5ad97cbcfcec31430268441c10eedde73200177]

CVE-2026-97946: x86/amd_node: Fix PCI device reference counting in
amd_smn_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97946

Introduced by commit 0a4b61d ("x86/amd_node: Fix AMD root device
caching") in v6.18-rc5.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27600805e62f800bacf990354632eae4e487d34c]
stable/6.18: [84e3a71d11d8593c127b468d75b2653af5074f81]
stable/7.2: [aa2a4277ad42fd8f918c6dc652473946a253f7b0]

CVE-2026-97947: x86/amd_node: Fix potential NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97947

Introduced by commit 77466b7 ("x86/amd_node: Remove dependency on
AMD_NB") in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aefdbd574a362dcf7569bada6d72f64a006b9fb9]
stable/6.18: [fcd19bc829eca237742a3b123f839ad1c473ec85]
stable/7.2: [a797a2331e5d2ecdbccbae222ea71c759fdb2c2b]

CVE-2026-97948: powerpc/eeh: Fix recursive locking on devices without
EEH sensitive driver

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97948

Introduced by commit 1010b4c ("powerpc/eeh: Make EEH driver device
hotplug safe") in v6.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [c5e68706527968282e49de205cc2b935823cb88a]
stable/6.12: [102e3dc5ab5ba052e294819e83384166b242c1ec]
stable/6.18: [2920af33d097ca335e492b346af70b72986ad6dc]
stable/7.2: [85d8eaefc052cf3e5ae2c7bafeda2db68b8898b4]

CVE-2026-97949: configfs: unhash the dentry before dropping the item in rmdir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97949

Introduced by commit 7063fbf ("[PATCH] configfs: User-driven
configuration filesystem") in v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f06c2d26d1999d37e93299db0ecead04ca7d0b9f]
stable/6.18: [5d7cbfb65e47cc71d5d94d87d5d0d1679080f3eb]
stable/7.2: [925d8564f1b2d9b46c5ab63b9bc942cea006da9b]

CVE-2026-97950: configfs: pin the symlink target's dirent instead of
chasing ->ci_dentry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97950

Introduced by commit 7063fbf ("[PATCH] configfs: User-driven
configuration filesystem") in v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7c1290eef60711c10289c056ad32ed1f2b47b12]
stable/6.18: [4f54beb2e7f6d399396466682fba3539bcdcb414]
stable/7.2: [d47c5de1cd6bfbe1067fc310bf90e4e00205e839]

CVE-2026-97951: scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97951

According to the .vulnerable file, this bug was introduced by commit
2c9fa49 in v5.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5869dae5080e976d4b03cc33eb7ceb527f242bf]
stable/6.12: [638cf7c0cf64d5bb5704c3a78b54ae6602f69a32]
stable/6.18: [f6f6351e98c77c27b51763ef52deb2efe4b46ac7]
stable/7.2: [37f7f54d06c6100511979d6e9c1222b404e3f006]

CVE-2026-97952: sunvdc: unmap LDC cookies when the descriptor send fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97952

Introduced by commit a11f6ca ("sunvdc: Do not spin in an infinite loop
when vio_ldc_send() returns EAGAIN") in v5.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [0c6da21fa35e03fc74f09895433ccd6d4a9c3530]
stable/6.12: [ab81a5c1014a38dab0fb402609fd866b0bcb4726]
stable/6.18: [57835952566f0be9b365a6eb3a70b397a9d5ef47]
stable/7.2: [f3322baa3a8ac87730feae952c1146269d78e098]

CVE-2026-97953: net: stmmac: fix TX descriptor availability check for
TSO traffic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97953

Introduced by commit f748be5 ("stmmac: support new GMAC4") in v4.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e38d732ec67a5b1f9a56e6c73add480c4b6030a]
stable/6.12: [ffa6d2481bc1c87f822ecd626561484e4ee24cef]
stable/6.18: [c28175220f808c867d5618de8ecc6dbcc815c773]
stable/7.2: [65820fc743eae322f7f94f6a64d07861211d4b21]

CVE-2026-97954: net/rds: fix tcp stream corruption with large pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97954

Introduced by commit 7875e18 ("RDS: Message parsing") in v2.6.30-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ac09b5353fe6858411fdc8c6efa60d832e20f13]
stable/6.12: [ef3565a418b8309589fe9b5df098a892c9146b06]
stable/6.18: [8cbfeb54bf781d9693778aaba133bb58c0285332]
stable/7.2: [f4649a716be20ef9272f97a166dea1825ba5b554]

CVE-2026-97955: net: mana: restore the XDP program pointer when
pre-allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97955

Introduced by commit 730ff06 ("net: mana: Use page pool fragments for
RX buffers instead of full pages to improve memory efficiency.") in
v6.18-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c46beb807efcc93f5899ebe1f5958248eb296c6]
stable/6.18: [5b3cdc9abd82b7e49e0f1a21d6eb75466c5ecef8]
stable/7.2: [9801edfba8dfcdb1da3b0afccdf143e13d646b56]

CVE-2026-97956: net: net_failover: Fix the deadlock in
net_failover_slave_name_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97956

Introduced by commit 7e4d784 ("net: hold netdev instance lock during
rtnetlink operations") in v6.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [985a663bf00799c1daf1c5789efa6406958780c8]
stable/6.18: [4b20e66d2e52d3628db4dccc1a33f134e73375d5]
stable/7.2: [c49bfa2c5dbd89f7683c26fc08b11e7369ea11e5]

CVE-2026-97957: net: hinic: fix mailbox segment buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97957

Introduced by commit a425b6e ("hinic: add mailbox function support")
in v5.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d4d985957434867bbe85e4fa5e638f3e48ad522]
stable/6.12: [eca54a092d5f7b497b458ff5a6f66d4f7bfb6674]
stable/6.18: [9f6ad383901d0cb1c8ea5f7f3160fabfe1540eb5]
stable/7.2: [513f7b16ed0cffae9348151c72bed17c7073096f]

CVE-2026-97958: net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97958

Introduced by commit 2ed9db3 ("net: sched: cls_api: fix dead code in
switch") in v4.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dff39930ad5e53d202bfdfb14687d1d2fd753b4d]
stable/6.12: [a1c2840d95af1fa3d83ba71e23fa0c674a4c6796]
stable/6.18: [503ba58481e3ba69d28127d35a39cec529f9670c]
stable/7.2: [e9ac395bb56122a057d0aa91a6b55d9e3fa37c26]

CVE-2026-97959: net/sched: cls_route: free emptied bucket on filter move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97959

Introduced by commit 1e052be ("net_sched: destroy proto tp when all
filters are gone") in v4.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1853f30cf5c84971f99788a76207c6f745380896]
stable/6.12: [2e2f130951d34871b0643bf700164d97cff4b427]
stable/6.18: [f8495d67434e1cb7e511297687ca55fdb28e4c20]
stable/7.2: [81dd117c04422c6d0c7974aba9fa6a0ba370959b]

CVE-2026-97960: perf/x86/intel: Prevent drain_pebs() reentry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97960

Introduced by commit b752ea0 ("perf/x86/intel/ds: Flush PEBS DS when
changing PEBS_DATA_CFG") in v6.4-rc2.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a56c03a397e2cd0c4cf8da96dcd6214f7d0e7d8c]
stable/6.18: [a5fe19dd8b3ed5fad6e5e0f0c58c7245043ee4af]
stable/7.2: [c55599c0ec2aa020e41a0599c3044c56d8a2e7d9]

CVE-2026-97961: perf/core: Allow list_del during perf_event_overflow()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97961

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59e63416f5153e7d58652c616fbdcb7d5e01fff7]
stable/6.12: [723e85fb2c3bcd237ac02cbd69502ed62ce0068c]
stable/6.18: [6d0b9ce3be221c9077653f3670d60d66bb725ee2]
stable/7.2: [e2770c76a02452fddb52e9e05c7ed6acfef06c32]

CVE-2026-97962: net/mlx5e: Move representor vnic reporter to eswitch
devlink port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97962

Introduced by commit cf14af1 ("net/mlx5e: Add vnic devlink health
reporter to representors") in v6.4-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f26a5e8040b4957ef4dbdfcde6cc7ba2db53937]
stable/6.18: [dcaba72c85c14fe7393a59d61695941e6ccbd7d7]
stable/7.2: [d1fcff9b39bac188ef62a77ebd176484be928ec2]

CVE-2026-97963: net: stmmac: initialize ptp_lock at probe time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97963

Introduced by commit b60189e ("net: stmmac: Integrate EST with TAPRIO
scheduler API") in v5.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0338c68e22abd2ee509ec2e32508a50896618c32]
stable/6.12: [420315413b29635de1d4ea4142e410e6465260f3]
stable/6.18: [25cc0096efba83b4e0e6fa50f03e9543b41e9d3d]
stable/7.2: [b1986595cf827c38ff929e22fbc9ca8f76379306]

CVE-2026-97964: ppp_synctty: ensure a writeable skb header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97964

Introduced by commit 4cf476c ("ppp: add PPPIOCBRIDGECHAN and
PPPIOCUNBRIDGECHAN ioctls") in v5.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8aaeb56aff2a557a88f83ae866da2c91ad247e59]
stable/6.12: [3af7797fbabc84992e0ca5ad2bc0ca8537d053ef]
stable/6.18: [0996c3e6bcc6ae08cb371ed43648c9f7f748ae6e]
stable/7.2: [15d0a6c9a42df2d745c37510dba828f6dbe60d9f]

CVE-2026-97965: vxlan: initialize _md in vxlan_xmit_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97965

Introduced by commit ee122c7 ("vxlan: Flow based tunneling") in v4.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be83178bfc44588f6e3adb827ed874c683193466]
stable/6.12: [0d13b5a413bffc8718b3821b78537ccc6596c233]
stable/6.18: [bfb74c48ac2d31476d5e09cf9658844508d2608a]
stable/7.2: [081f22177d9d12b1e381b787f203cd5f47508187]

CVE-2026-97966: octeontx2-pf: reset HTB scheduler topology before freeing queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97966

Introduced by commit 5e6808b ("octeontx2-pf: Add support for HTB
offload") in v6.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef39fca8508597fa565cf2be72a884a712fb98af]
stable/6.12: [0aa2dd6eaa347c7aab448df0eec0afcfe7489885]
stable/6.18: [621c99be42e3f5cb68a6af9480a255218a761c4e]
stable/7.2: [2df186418e17b30b319cf9ff81aad137692ab107]

CVE-2026-97967: hwmon: (corsair-cpro) Remove debugfs entries when probe fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97967

Introduced by commit 5997eb6 ("hwmon: (corsair-cpro) Add firmware and
bootloader information") in v6.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ee875c423c66c45d7ef7bbff403cd0e3971e0a2]
stable/6.12: [ae01aafd8214e48cb7eff11e92dfbf3778d52d9d]
stable/6.18: [a5de53b08cc319dadce6fb68d33749ea37962952]
stable/7.2: [fdc1bc23ff59ee308042342cefcb918d6efba409]

CVE-2026-97968: hwmon: (corsair-cpro) Create debugfs entries after
hwmon registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97968

Introduced by commit 5997eb6 ("hwmon: (corsair-cpro) Add firmware and
bootloader information") in v6.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [508baf1713f32f287bfb4f85d759403ec8ba35a3]
stable/6.12: [6c5d333216a937044acd3336e9ec7e30ff2eaee4]
stable/6.18: [a58a966a440071bb877ef62535d1016952f83101]
stable/7.2: [fdfe17cb865715aad30328678344eb79889207ab]

CVE-2026-97969: watchdog: msc313e: Fix clock leak and spurious timer
in settimeout()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97969

Introduced by commit e9800b7 ("watchdog: Add Mstar MSC313e WDT
driver") in v5.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3db30f315935c2fb0d95f46b7a593b5b4d3ec3d0]
stable/6.12: [2152a13ee2a9af09a668ebd053a8dbf771dadb80]
stable/6.18: [2abf99a57b0b71b2b97745981f4039370ab78044]
stable/7.2: [faf1eb2895c87a8c0fb920439dddc7e0d97c6a69]

CVE-2026-97970: watchdog: msc313e: Avoid division by zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97970

Introduced by commit e9800b7 ("watchdog: Add Mstar MSC313e WDT
driver") in v5.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c73a37f5e40972ce26d8eeb98e8b938d719b069]
stable/6.12: [3ae8eb30f8a0a839bf36fa62e4201ac99946447f]
stable/6.18: [47eae41c630b9d2ce16a528a1517d4d2f857cd47]
stable/7.2: [5788a6747eda85051838628b40c430ec6343f3c6]

CVE-2026-97971: nstree: check listing permission before taking a
namespace reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97971

Introduced by commit 76b6f5d ("nstree: add listns()") in v6.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56ea4e86832d8abe8930394473566c194d189f85]
stable/7.2: [9e673bf5d88aa898e52cef5c87058c3fa845bc71]

CVE-2026-97972: net: macb: put the "mdio" child node reference on success

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97972

Introduced by commit 8a6631f ("net: macb: avoid redundant lookup for
"mdio" child node in MDIO setup") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [382a373d9ea7a6ac4de9c022385b6217f65ae3cc]
stable/6.18: [5fba30080d298edb742396073372385c961578d3]
stable/7.2: [7d60dc7ff85b73a2119d582ca2d4456b30960380]

CVE-2026-97973: net: macb: destroy the phylink instance on the probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97973

Introduced by commit 7897b07 ("net: macb: convert to phylink") in v5.5-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d059f390750152b9bd69df934198651b94fc26d]
stable/6.12: [23b6a44ffea1c54a4232aa86ee470b21422a8cc5]
stable/6.18: [e92a45b872b035c79acde8dd0da096a72b61ff2f]
stable/7.2: [8558e3195664113c14a4d8fcf221b3caff41fed1]

CVE-2026-97974: ipv6: null-check fib6_node before accessing in
__ip6_del_rt_siblings()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97974

Introduced by commit bd11ff4 ("ipv6: Get rid of RTNL for SIOCDELRT and
RTM_DELROUTE.") in v6.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdca92eddc025fdb90071be97738f7d55a65f8dd]
stable/6.18: [e7ff91f19c1aae039a4257fa86fe849afe185291]
stable/7.2: [1155234c2227cf36072a43e1e09119472ade7ca7]

CVE-2026-97975: Bluetooth: hci_sysfs: Fix NULL pointer dereference in
device_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97975

Introduced by commit 27aabf2 ("Bluetooth: fix use-after-free in
device_for_each_child()") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9b851b09b392da68bd715601f10a5adb2d8d19b8]
stable/6.18: [eeabdb25c3209569367e99a85ca9a503b64a646d]
stable/7.2: [9e9ece97b8e716890793de261574b8efef7d8702]

CVE-2026-97976: Bluetooth: btintel_pcie: validate packet_len before skb_put_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97976

Introduced by commit c2b636b ("Bluetooth: btintel_pcie: Add support
for PCIe transport") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6436e1b5331b1aebf905c13e0880a37032719b75]
stable/6.12: [ab0159b1f7214ce9bad9862751e4553e635a21b1]
stable/6.18: [73a50c636425cb9f7ab647b5a97bd14dd5610076]
stable/7.2: [46884c0f92708f1d218fc94d88800227a19b52f8]

CVE-2026-97977: Bluetooth: btusb: Fix UAF of btusb_data by rx_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97977

Introduced by commit 800fe5e ("Bluetooth: btusb: Add support for
queuing during polling interval") in v5.17-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c12c3117639e78940959d956519c758c57d0849]
stable/6.12: [472d005622525b7be155cac99dde2252b0163bd1]
stable/6.18: [93b59937bda3fffc6386c79f5544a39bc680c8e8]
stable/7.2: [fa391adb9c755515a89993634745e9079e5ef37c]

CVE-2026-97978: eth: ice: don't dereference pointers from TP_printk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97978

Introduced by commit 3089cf6 ("ice: add tracepoints") in v5.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8bf9bfda5f62e11444e483c2b4aaff90c5cfc6b]
stable/6.12: [ae230874e3ba27e975a9bb21a6ffd05d6a2ea318]
stable/6.18: [0b0d2f9db2406aa541a8bc3737f4f4aae1cafde9]
stable/7.2: [c42db35518bb0eae42ec955520eee0aa94a4a6fe]

CVE-2026-97979: ice: add missing xa_destroy for sched_node_ids

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97979

Introduced by commit 16dfa49 ("ice: Introduce new parameters in
ice_sched_node") in v6.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [53432c4c3e869076350aef319534431af8ba99c1]
stable/6.12: [44cdd6b7e036303f7fecf841cf23c05a4a4faf2d]
stable/6.18: [f5463bc124c0d6f922e272336584730c5c61c4f1]
stable/7.2: [d6f38fb12069fb1edf762962b5fcf3f42d643b47]

CVE-2026-97980: s390/debug: Fix NULL pointer dereference in debug_set_level()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97980

Introduced by commit a2cec68 ("s390/debug: Add s390dbf kernel
parameter") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1eb31d533cdfcae1011ed53850d52f36afe5774]
stable/7.2: [716e1cd3783806929407dbd596e6b1118971eb9e]

CVE-2026-97981: net: ethernet: cortina: Count dropped frames as NAPI work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97981

Introduced by commit 4d5ae32 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in v4.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b856c552f556bc0341c1dbe0bf88e630fd1dc4b7]
stable/6.12: [58140f1cebb776d174dc6ff41c15401654a5b1ea]
stable/6.18: [cceb6cd7f0e5ed2944a9ca22443d7b9da82f60ab]
stable/7.2: [5754e0c0758805096ecfeaf4c1b146ad51ed246f]

CVE-2026-97982: net: ethernet: cortina: Fix budget accounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97982

Introduced by commit 4d5ae32 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in v4.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0de06d0da78a3db53de65dfd7452cc6d111f703]
stable/6.12: [631c47e2e1154f2741c555b91df1b8cb99294c6a]
stable/6.18: [0ef8eaef5806c84db2334111d6f299c246a592bc]
stable/7.2: [94e06e12a376710587cfeea481b65e7c49747003]

CVE-2026-97983: vduse: return compat ioctl results directly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97983

Introduced by commit 455a2a1 ("vduse: fix compat handling for
VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO") in v7.2-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48a4ee65e677559776349128e6a81a6041986c99]
stable/7.2: [135ac58097fa5fc707bf392c5cececf59e4080c0]

CVE-2026-97984: net: ipv6: Fix UDP length overflow with PMTU discover
and big MTU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97984

Introduced by commit 427faee ("net: ipv6: introduce
ip6_dst_mtu_maybe_forward") in v5.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ae10b6be49b425827659b23bcce498f80eb7182]
stable/6.12: [1d56a00ec91f2885c64ea5b8cea18cb746b91bbb]
stable/6.18: [ce66352d3eb21825410af8b91db7cc4bb8e22c98]
stable/7.2: [e01b7c176d9af2b7c22bb3fe12cf9a7904f99fdc]

CVE-2026-97985: af_unix: Update last skb marker in manage_oob().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97985

Introduced by commit 22dd70e ("af_unix: Don't peek OOB data without
MSG_OOB.") in v6.9-rc5.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [94fd4debd2e3a69cf93e766c8b328a810c228119]
stable/6.12: [0630bfc773d85ac44da05b2c5a037dbbd39301ab]
stable/6.18: [f1816b3d7ce80dcf086bb68ff5ae6e09520ca1fa]
stable/7.2: [fc62a26493a98a0424d9dae2eb92a1daa1321f65]

CVE-2026-97986: virtio_input: stop callbacks before unregistering input device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97986

Introduced by commit 271c865 ("Add virtio-input driver.") in v4.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7808b37da0a619cf1fa541c2384e783fecc2480]
stable/6.12: [8226aeee9b9a94cd699fbb51cb230feff46cfaf2]
stable/6.18: [a3ba86a270dd87460759214046dc7cbd409ac711]
stable/7.2: [5378f7945856a5ed88e6f9850bc7a68f54090135]

CVE-2026-97987: virtio_input: reset device if input_register_device() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97987

Introduced by commit 271c865 ("Add virtio-input driver.") in v4.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81489b32a21c9360f8750d1fb600155d27452e19]
stable/6.12: [9a7e107734137f098f9b81e5615aa5a02c5395c7]
stable/6.18: [8407da8974326c1ffdfe6a5a9bfc8fed3212bbdf]
stable/7.2: [668ebfea7ba623450b12fdeaa0d080464d0c0a14]

CVE-2026-97988: vhost: invalidate vring access on IOTLB transitions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97988

Introduced by commit 6b1e6cc ("vhost: new device IOTLB API") in v4.8-rc1.
Introduced by commit e13a691 ("vhost/vsock: add IOTLB API support") in
v5.11-rc3.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4f4761879a230aa59e569102a6ab9851847d833]
stable/7.2: [4a454af8e56c1596ada1421ae5eba90c8896c7c7]

CVE-2026-97989: vduse: validate virtqueue alignment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97989

Introduced by commit c8a6153 ("vduse: Introduce VDUSE - vDPA Device in
Userspace") in v5.15-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa2c25b4add57888acfa89e398389e267bff3dcf]
stable/7.2: [c3c3b0839a1197530cc18f535062fc84dbdfc885]

CVE-2026-97990: vdpa_sim_net: check TX pull result before RX copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97990

Introduced by commit cfe2268 ("vdpa_sim: filter destination mac
address") in v5.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d195797a80b77f2ec56718cd26d3ee65d0093e8]
stable/6.12: [c001abcde865b74231da8f1412c3217dbf66781e]
stable/6.18: [3af20238a09ca180d66623e3bed16b64e9975f39]
stable/7.2: [2bbf1c1f69991e28787e02b0a2f826289d5fc730]

CVE-2026-97991: vdpa_sim_blk: reject out-of-range sector starts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97991

Introduced by commit 7d189f6 ("vdpa_sim_blk: implement ramdisk
behaviour") in v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a8693f00c408d85f086ad85d29e7030bf1e2055]
stable/6.12: [14acb0d44b7d90a077beb7b92b444b90bafda9d9]
stable/6.18: [a8a1413a2cfdbedc896249f461d6d92efbbfe21f]
stable/7.2: [d6dac17e20fd2abd0eb8c09d69fccf7426e12bcf]

CVE-2026-97992: vhost-vdpa: protect config_ctx from being freed under
the config callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97992

Introduced by commit 776f395 ("vhost_vdpa: Support config interrupt in
vdpa") in v5.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62be4e3e5f5f947fbf765b914cebdc478f715d12]
stable/6.12: [bf35c8948ab7a3eaf1f724fa1e870e3f73a1749b]
stable/6.18: [5a075ee2398929d5cc1393666f219c35332becb1]
stable/7.2: [f4a93f15ed1c8406ba5c8e5b28cafacb2b3bcd11]

CVE-2026-97993: vhost-vdpa: don't install the eventfd_ctx_fdget()
error in config_ctx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97993

Introduced by commit 776f395 ("vhost_vdpa: Support config interrupt in
vdpa") in v5.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e74a9fa50749b9940b4fb13199652325e08d3c4a]
stable/6.12: [388c678639a0cebfd936b3e56c64ac6a371efec2]
stable/6.18: [65faf9eaa00e408e1406fbcf675c8c8d0e27ff2a]
stable/7.2: [6b20b40f020bde236f6b8a08ff88d8653261ec2b]

CVE-2026-97994: vhost/vdpa: reject VRING_NUM larger than device max

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97994

Introduced by commit 4c8cf31 ("vhost: introduce vDPA-based backend")
in v5.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccb1dc7c527f8c925925cf92afc76ae590dac311]
stable/6.12: [1d09201d81b7d3e276860cc7b7dbf6c6cbe8e9b4]
stable/6.18: [68232102f20fc961327fb9e0f605a7eaadf030a9]
stable/7.2: [59522639a7d71cff4e20d594d0b9ea30dd0c77e0]

CVE-2026-97995: virtio_console: do not free control-out buffers on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97995

Introduced by commit a7a69ec ("virtio_console: free buffers after
reset") in v4.17-rc3.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [894f98e73983f37354214a89a3a7fd35bf9e3072]
stable/6.12: [177ee901aa2bab02e7f1f8edbb814fd5e386ed62]
stable/6.18: [a80c33488e0bbe642ed803b13a4ac8078a70b507]
stable/7.2: [f620c40ea6862feed84deb105568b21ec53a7830]

CVE-2026-97996: virtio: fix use-after-free in unregister_virtio_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97996

Introduced by commit 96a8326 ("virtio: add debugfs infrastructure to
allow to debug virtio features") in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f9a0fceb730f5107d52421ead5568eae25a0049]
stable/6.12: [951cad50cba89e736afdee4a730e0e52f9245c9b]
stable/6.18: [77dbd10a701a30fdfea5c3bb7a29163128f9a9c7]
stable/7.2: [caf042153016d651b55d0fb4a63cdf7d0d23dee2]

CVE-2026-97997: virtio_ring: fix stale descriptor flags after a failed
packed add

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97997

Introduced by commit 1ce9e60 ("virtio_ring: introduce packed ring
support") in v5.0-rc1.
Introduced by commit f6a15d8 ("virtio_ring: add in order support") in v7.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75d276e5bb68778b2916f98a2bc30f142ebadc64]
stable/7.2: [d595358276b60e5df4d3930bc94033249b1d5adc]

CVE-2026-97998: netfilter: nfnetlink_log: cope with concurrent
instance destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-97998

Introduced by commit 0597f26 ("[NETFILTER]: Add new "nfnetlink_log"
userspace packet logging facility") in v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [387d744fa7e499d2c3748a4e60e02ebb24e7fb16]
stable/6.12: [0234d7ca0317be0a623300e1693cd794bbfdf8af]
stable/6.18: [1a7a8ac9a9f0ad0d410c901cb6f233833518844c]
stable/7.2: [e2dd0f1f8c4e6334699ea6382e52f6da0c7e45eb]

CVE-2026-98000: hwmon: Fix potential UAF in pec_store

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98000

Introduced by commit 3ad2a7b ("hwmon: Serialize accesses in hwmon
core") in v6.18-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [354ccc99b2dc8ba0cf6d4de34e520bcf6ecca5c2]
stable/6.18: [8afab57bcdbc2186f325972e777880ac5a220f4f]
stable/7.2: [01dd8b4fc2cf83c66565c0f382fb1841e9000a89]

CVE-2026-98001: hwmon: (ltc4282) Make sure clk_init_data is fully initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98001

Introduced by commit cbc2953 ("hwmon: Add driver for LTC4282") in v6.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e317326d1755ea054b98e7a4833b929157461c35]
stable/6.12: [c4a96da5a3f132d80aa971ddbeb86808539ba0e6]
stable/6.18: [80b46a3d066d4e2c1dd4edb90d4aa3f22ca79f39]
stable/7.2: [aa08ce1ffaf36c7bdd3edd0ad65f72413639bfad]

CVE-2026-98002: iommu/amd: Fix ineffective error check in nested
domain allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98002

Introduced by commit 757d2b1 ("iommu/amd: Introduce gDomID-to-hDomID
Mapping and handle parent domain invalidation") in v7.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa5c0827f0b7bac6d0a188f10118151769ae68fd]
stable/7.2: [80c231f5577229d1e90a1e312b3095f9502f8625]

CVE-2026-98003: iommu/amd: Do not reallocate GA log buffers on resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98003

Introduced by commit c5e1a1e ("iommu/amd: Simplify and Consolidate
Virtual APIC (AVIC) Enablement") in v6.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00a7dd64888d6dd72110b40e2824a088cf7b7386]
stable/6.18: [94458b80d3b203c1c9e2c98aa7319b7713e006c0]
stable/7.2: [b6be275d19cee01f8f1f08a2ff18337103d05d40]

CVE-2026-98004: iommu/riscv: Serialize command queue publishing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98004

Introduced by commit 856c0cf ("iommu/riscv: Command and fault queue
support") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca58afa40946acd252a50fa4d4a86f15847a3d7d]
stable/7.2: [6d4c12ab9ab8db87411c863a54e0e97f9197afde]

CVE-2026-98005: erofs: delimit inode_share cache key components

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98005

Introduced by commit e0bf7d1 ("erofs: support user-defined fingerprint
name") in v7.0-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96bf9831fbf423b8104f7948cd8fe7007ecfb46c]
stable/7.2: [16322a67336cfeea0af4b05206ef8d0e0eda55bb]

CVE-2026-98006: ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98006

Introduced by commit 523f1dc ("[ALSA] Add Native Instrument usb audio
device support") in v2.6.22-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [402a9d6aab7ac787ab075adeb562c3db8b8f564b]
stable/6.12: [d6dd3c915b0d02457711d8fbaa60efc52144557f]
stable/6.18: [0c1b907d5db2f3508375776e5b78d69591aa5626]
stable/7.2: [d41e6c1533f09b27fc562260d41417490d2b6084]

CVE-2026-98007: bpf: Reject non-scalar bpf_loop iteration counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98007

Introduced by commit bb124da ("bpf: keep track of max number of
bpf_loop callback iterations") in v6.7-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [c3fd8e5fd100f122bad503bdc0e9277219533253]
stable/6.12: [656d40d1ca228ee21a9b3280432479fc9eae75ab]
stable/6.18: [e2e1161e03fecff6d2229a81b024337144bfcd97]
stable/7.2: [f8ae8275c721334ee50fafdd986fb83294eb941a]

CVE-2026-98008: net: macb: fix NULL pointer dereference on unbind with
fixed-link

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98008

Introduced by commit d0c3601 ("net: macb: Avoid 20s boot delay by
skipping MDIO bus registration for fixed-link PHY") in v6.12-rc4.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [38b6be101006d3e7af972999f45d4f1e8250587a]
stable/6.12: [f737d999fcb8f276d77b01ea4c2016ee01dad19b]
stable/6.18: [5710f6a74f63cbba0e15cd75917234916181c9d4]
stable/7.2: [edb39c7666bb3924da761dfb417db85c1e5d8ad3]

CVE-2026-98009: net/sched: ets: clamp quantum in parse and fallback paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98009

Introduced by commit dcc68b4 ("net: sch_ets: Add a new Qdisc") in v5.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c38487f46b243bfeefec0c0c86023a3904f2214]
stable/6.12: [99ae477b892e203a37985ebc56f0063e072f7f4b]
stable/6.18: [8f80b113dea0bed3c1a31a4224b72775cd9ec52d]
stable/7.2: [de22c30ec5598aca8797f02082d2ee1358dfa3ff]

CVE-2026-98010: net/sched: drr: clamp quantum in change class

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98010

Introduced by commit 13d2a1d ("pkt_sched: add DRR scheduler") in v2.6.29-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8382abec0f1568d0a5590d75a3df92f23fcf5196]
stable/6.12: [dc8b374214ef5bba4882bbd95b361e42555cfc0d]
stable/6.18: [d43cded350fe1218493ad3d37a276aff14108ae6]
stable/7.2: [8f756ae1c87414ce9cc21b30e6e4c036d6e9e80b]

CVE-2026-98011: net/sched: hhf: clamp quantum in change and init paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98011

Introduced by commit 10239ed ("net-qdisc-hhf: Heavy-Hitter Filter
(HHF) qdisc") in v3.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb56a495f59baf6cad5ed80e3ffb9078098b1346]
stable/6.12: [1113b674307ffddd402524bd1fd9d7d5629b705b]
stable/6.18: [2e77947bbf6c166e76c038663832d0914418f761]
stable/7.2: [0898c6f9fa9ce2632ae88bd0f34a878ccc6335af]

CVE-2026-98012: net/sched: sfq: clamp quantum in change path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98012

Introduced by commit e4650d7 ("net_sched: sch_sfq: handle bigger
packets") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [fb9f88a33c516ea5c0bcd9a22ca288b246b34567]
stable/6.12: [f3820dce042a673fcb28cc31c87ee14257e21a17]
stable/6.18: [534cd7ecbbc6e8a974f4003a5c1557439c6e0a72]
stable/7.2: [e6c1cb728e389354203a72bc77464c222a247aeb]

CVE-2026-98013: net/sched: fq_pie: clamp quantum in change path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98013

Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4864f58c53eb47257d55e01f47d4a9f355f7f970]
stable/6.12: [f90fe65b977e7aa9eb302230a09eb18f8c32ceaa]
stable/6.18: [c11e3a39807eb5a200445ae9082843ab86800415]
stable/7.2: [6655b56e2801008566c594ef231f6c7b3f716c61]

CVE-2026-98014: net/mlx5: E-Switch, prevent mc_list repopulation
during vport disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98014

Introduced by commit 922f56e ("net/mlx5: Fix steering rules cleanup")
in v6.3-rc4.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [c0c6f4ba8a37688f7b4d4044898d88f0450d44c2]
stable/6.12: [69904608e25e8ba58111aadd9210892cf3876201]
stable/6.18: [72cfcb79026cffb6490f5044153a841d360b0cfc]
stable/7.2: [668e050429c7ca688cf4e7112f97f0cd269d446b]

CVE-2026-98015: net/mlx5: E-Switch: fix use-after-free in
mlx5_eswitch_termtbl_put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98015

Introduced by commit 10caabd ("net/mlx5e: Use termination table for
VLAN push actions") in v5.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ee07f601f8f507c9faf25c68a49396ab8950596]
stable/6.12: [304ea40ef4561671503c36e47da44a0a31b71e36]
stable/6.18: [e393789e92310d7c66f57c876101779c90816a12]
stable/7.2: [18b2969073879b9cce24e1a78b118bdad54518d1]

CVE-2026-98016: net/mlx5e: Fix use-after-free race in sample_restore_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98016

Introduced by commit 36a3196 ("net/mlx5e: TC, Add sampler restore
handle API") in v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af3aef0245abbab5e9f6302e7a7d6407187afb71]
stable/6.12: [3efd1a1938cbb33c53b0d75e55b6c0fe2ebad79a]
stable/6.18: [72324da8eeca269db9196c2a555abf72eb0385c5]
stable/7.2: [1daecd76ab9e5f055fe3970462410ad1d40bd177]

CVE-2026-98017: net/sched: defer qdisc freeing after failed creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98017

Introduced by commit 51ab299 ("net: sched: allow ingress and clsact
qdiscs to share filter blocks") in v4.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6662f2100f8d33b0f4d0047c219efd6bba186ea]
stable/6.12: [20bf6fa34b345333971bd4464a322cce87b83f4e]
stable/6.18: [156a3bab69744e9225bb9eff8c5cc53da18d5a2e]
stable/7.2: [5bfe927c5b4b290fad529186218c728589b4b101]

CVE-2026-98018: net: mctp: i3c: serialize probe with bus removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98018

Introduced by commit c8755b2 ("mctp i3c: MCTP I3C driver") in v6.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b4707a149a55e8fa75c9ef32b359d60f470a566]
stable/6.12: [e6541b2747682fdb2c6ded4a7cf7c39c4067a35c]
stable/6.18: [765c5e357e67916a7aac8ead4ac2fa7d2bffe000]
stable/7.2: [906d8dbafabfa81a30e3ade420cb9912f223a5e1]

CVE-2026-98019: bpf: mark a NULL call argument precise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98019

Introduced by commit b5dc016 ("bpf: precise scalar_value tracking") in v5.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a3a10b030c96ea88868ccc060a16827c01eaa5a]
stable/7.2: [69a9ad004ccf5d45e534c7d503f47f643abe64b7]

CVE-2026-98020: pds_core: fix cmd_regs access racing BAR unmap on reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98020

Introduced by commit e96094c ("pds_core: Clear BARs on reset") in v6.8-rc3.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [7980325b2f71e3f65c1323c39792e2455da6fab6]
stable/6.12: [2cc697565fd19b5ba2d100cdd4a20dd6d263abc2]
stable/6.18: [fa31bd14c5042c6315bb2182c963f03ca6e79ca4]
stable/7.2: [09f831bfe39de5b8026fefb3d106b5cc93272170]

CVE-2026-98021: net: reject oversized tx_queue_len at netlink parse time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98021

Introduced by commit 38f7b87 ("[RTNETLINK]: Link creation API") in v2.6.23-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aa9e143bf51405665a793d4cc925e1c4f0c5922]
stable/6.12: [45ca9f59b6c7ea70e0a17054902b8a556913db34]
stable/6.18: [2fd0880f0272ec022906a05587fd91416ebecc38]
stable/7.2: [a638a2625aa83160a394abe8e8b2e524a80c771b]

CVE-2026-98022: net: cap tx_queue_len at S16_MAX to prevent oversized
ring allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98022

Introduced by commit 6a643dd ("net: introduce helper
dev_change_tx_queue_len()") in v4.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66ab4c59b74db7ab53a1c9083feaaede393a96a0]
stable/6.12: [81c0e02076989743a603806a5a4f44d2c40dc01f]
stable/6.18: [081340cf70a789b94b4174af54a63ffd49677a4e]
stable/7.2: [a03b927bae4af5c23fd5315a237855c17cc8f422]

CVE-2026-98023: vxlan: reject dynamic fdb entries that reference a nexthop id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98023

Introduced by commit 1274e1c ("vxlan: ecmp support for mac fdb
entries") in v5.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98fc57d167446b95b4e719815fe79edef93f8e7a]
stable/6.12: [28f86eec851b7406a4bc6143f82aeba2882d9842]
stable/6.18: [53359916ceb649b7e6947c8c2f669368a41c1354]
stable/7.2: [3fa64d86fc64eda104e3e97721a12a42a2fd2073]

CVE-2026-98024: s390/ism: folio_put() after error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98024

Introduced by commit 8378138 ("s390/ism: Properly fix receive message
buffer allocation") in v6.9-rc5.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [907a56ab3eb8a58500a58daa76087f17bb2b6826]
stable/6.12: [890e2ef726904d1d8328e4b9f5090eeb8761b9d1]
stable/6.18: [eebb6a9017b55ac05be770cf7b89f9da49505ae7]
stable/7.2: [60983356fab0c1171c5cb1b56a36349ebadc608e]

CVE-2026-98025: net: usb: cx82310_eth: drop URB after 0xffff reboot
sentinel to prevent partial_data heap overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98025

Introduced by commit ca139d7 ("cx82310_eth: re-enable ethernet mode
after router reboot") in v5.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [5d50e90add8b4a978395e893e81954d19d58a7c5]
stable/6.12: [3bd689409bb1c93bdc6dd8ec6cbf5161bc4f0287]
stable/6.18: [659654654eb140851467af41d610473c100c7975]
stable/7.2: [237c9ae7145772af147e4665f158938350fa5658]

CVE-2026-98026: net: bridge: mcast: properly convert mglist to rcu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98026

Introduced by commit 07f8ac4 ("bridge: add export of multicast
database adjacent to net_dev") in v3.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b772869a1e5f9da5cef5b9c722ec0aa424ee0a0]
stable/6.12: [98247c8264d2076f81fa114bdfa2c2271953ac7c]
stable/6.18: [38ab2a435001a3c4dbeb70a52f5921e1ccd66f55]
stable/7.2: [f7bf57e94a5d6214b87be08486cb33836fbfa573]

CVE-2026-98027: net: dsa: mv88e6xxx: bound the policy rule dump by the
caller's buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98027

Introduced by commit da7dc87 ("net: dsa: mv88e6xxx: add RXNFC
support") in v5.4-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1fffc273112e7284c5b705e186b43b5770cd3d5]
stable/6.12: [44cd4674d9aa5bdf793b8a8b481c9e8536ed6070]
stable/6.18: [7a683c2b062810bca203e41866389daf387c235b]
stable/7.2: [cda5ac8fe8ac8e80b1703ebb8c4250726fc19739]

CVE-2026-98028: eth: nfp: drop the replaced rule from the list when
reprogramming fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98028

Introduced by commit 9eb03bb ("nfp: add ethtool flow steering
callbacks") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [108bb2142e3a12c9ad625ad662973127a113ddc6]
stable/6.12: [603b70093f729f52a37544b48679903cad834856]
stable/6.18: [edaec279f59f801a05b751df475ed71a0a68c88a]
stable/7.2: [552e528a7d85cbe088b2ae4f78194713975b46cf]

CVE-2026-98029: eth: nfp: bound the ntuple rule dump by the caller's buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98029

Introduced by commit 9eb03bb ("nfp: add ethtool flow steering
callbacks") in v6.8-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1986bf87b0709c95126fe196cf39e5b8c8453a1]
stable/6.12: [82812583b9c69c241da6da4186f14e9df2516488]
stable/6.18: [a7e023c63e855761c1426cee8d17c2bca32aa339]
stable/7.2: [ecebfdaab72a504c10f4907bd00fc3b705ec3b12]

CVE-2026-98030: net: dsa: bcm_sf2: bound the CFP rule dump by the
caller's buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98030

Introduced by commit 7318166 ("net: dsa: bcm_sf2: Add support for
ethtool::rxnfc") in v4.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdb719f4b8596d9ccee2d56d204c2c4dce982f46]
stable/6.12: [f1a2869b3629c0e8394b77b38cb9f19a018c653c]
stable/6.18: [fd1a78c16b1f6978c09cf048e15f349732e4c707]
stable/7.2: [b231b6d8516d3fe0d4bba549908e08d26a4531a5]

CVE-2026-98031: nexthop: Initialize extack in remove_nh_grp_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98031

Introduced by commit 833a106 ("nexthop: Emit a notification when a
nexthop group is reduced") in v5.11-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bd9e4e7cdaa03879e9b73b12ab52cceb1edd55b]
stable/6.12: [030c878eaedf0449e2b5401a0a0146d0afcc645e]
stable/6.18: [d643cea4248668dc493c513aa7cbc6505eb1a4a9]
stable/7.2: [d80677ad7aa5bebfccfd58caa4852b65abe70561]

CVE-2026-98032: tracing: Fix subbuf resize races with trace_pipe_raw readers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98032

Introduced by commit bce761d ("ring-buffer: Read and write to ring
buffers with custom sub buffer size") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dae8dda341d2d9034a90d59e8a7d502e1263813f]
stable/7.2: [75b37b8369778b69ce9738d1c97685a1615cb252]

CVE-2026-98033: bpf: Preserve inner map identity in callback frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98033

Introduced by commit 3e8ce29 ("bpf: Prevent pointer mismatch in
bpf_timer_init.") in v5.15-rc1.
Introduced by commit 69c087b ("bpf: Add bpf_for_each_map_elem()
helper") in v5.13-rc1.
Introduced by commit 5c8fd7e ("bpf: bpf task work plumbing") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b90c5d770dad910fb89e6c1b15052a8a1e8db752]
stable/7.2: [66ff2eff093d2a0838f39c713eeb590bc0946c2a]

CVE-2026-98034: bpf: Mark NULL kptr stores precise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98034

Introduced by commit 61df10c ("bpf: Allow storing unreferenced kptr in
map") in v5.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecdc5043794c9184aa8e6c814603899479c46b35]
stable/7.2: [86168208737bdd267d92d855d453d1d2f840df19]

CVE-2026-98035: bpf: Cancel special fields when recycling rhtab elements

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98035

Introduced by commit 6905f86 ("bpf: Allow special fields in resizable
hashtab") in v7.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65cc95eba9e8b46312cac38c227473605a4b996a]
stable/7.2: [28fde1356dbc35e20a9f22a5ee65af09698fdf92]

CVE-2026-98036: bpf: Preserve special fields in recycled rhtab elements

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98036

Introduced by commit 6905f86 ("bpf: Allow special fields in resizable
hashtab") in v7.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5df46ddcb7b36878c1b691e9057a0509042a2567]
stable/7.2: [6a5266b8288216b86602ff687d528abfb066dfd8]

CVE-2026-98037: bpf: Reject untrusted allocated-object pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98037

Introduced by commit 1b12171 ("bpf: Mark direct ld of stashed
bpf_{rb,list}_node as non-owning ref") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7441ee8276641bddaf1cba7bb75ef9c1458ceb3b]
stable/6.12: [092c2874dc1b2060fa77a465a971acd4fdf87683]
stable/6.18: [135d542b97fa93e32c457d49d6e7b33ca7d05bae]
stable/7.2: [6b1f786ad85a0b63393b76f5e634deab1a73198c]

CVE-2026-98038: bpf: Keep refcount_acquire nullable for borrowed RCU kptrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98038

Introduced by commit 1b12171 ("bpf: Mark direct ld of stashed
bpf_{rb,list}_node as non-owning ref") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc36739e5cc9f60485418a910b42bc95339218d2]
stable/7.2: [85074498228a2500ea8b8039c49cc1ab8ad5328f]

CVE-2026-98039: bpf: Require MEM_PERCPU for percpu kptr stores

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98039

Introduced by commit 36d8bdf ("bpf: Add alloc/xchg/direct_access
support for local percpu kptr") in v6.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [048029ba1c793f8cabc4ad5eea765da01903f8f1]
stable/6.12: [aaa9cf7707d1c5c0d2ca9d40c8b71652ac1c3c3f]
stable/6.18: [0bdd6121c8dd5f1764efe701ce26bb8e15acb172]
stable/7.2: [ad4ebae5dbc2d47b544aa54f03c12490065be08a]

CVE-2026-98040: bpf: Mark the zero register precise for a
register-form NULL check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98040

Introduced by commit 2f4cb53 ("bpf: detect non null pointer with
register operand in JEQ/JNE.") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aed0134d3cda6382385a734ae0158eb7df6b142]
stable/7.2: [ddca9a3b8833168dda3e62676648a636fb3f221c]

CVE-2026-98041: bpf: Don't predict JMP32 pointer vs zero comparisons

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98041

Introduced by commit cac616d ("bpf: Verifier track null pointer
branch_taken with JNE and JEQ") in v5.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e51179a4e09846f8fd0f26a05068520de2b301bf]
stable/6.12: [d16f0eafcaa62e677a2b5b0dabc1f8d31dfe3d4d]
stable/6.18: [e2ae33247e8b2dbe9d116d3e61cadf6d548339c6]
stable/7.2: [a4d7f94c1ca914469ced665ec2f98be669aef462]

CVE-2026-98042: bpf: Don't resurrect a scalar id dropped by
collect_linked_regs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98042

Introduced by commit ec1d77c ("bpf: Use bpf_verifier_env buffers for
reg_set_min_max") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73a98f96811e2cb0f4210b1caa8cb322f92f2a2b]
stable/7.2: [e821ff19b8ef08255ff8d8234774ed814637e9bf]

CVE-2026-98043: bpf: Don't infer non-NULL from a pointer with an
unbounded offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98043

Introduced by commit cac616d ("bpf: Verifier track null pointer
branch_taken with JNE and JEQ") in v5.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67b529f521a6676cdfc78b91b0217d7eaa84216b]
stable/7.2: [cb6642048739bf4ee5aa09fe465511f1e87caa63]

CVE-2026-98044: bpf: Reject legacy packet loads from callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98044

Introduced by commit ee86148 ("bpf: Fix ld_{abs,ind} failure path
analysis in subprogs") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [e7d28823c662128caae63f14e16bd394916c139b]
stable/6.18: [3484a99303912db62428494a9061212049027e57]
stable/7.2: [bc489c0c9b8c86bd7fac42cfd1bb152f042fca56]

CVE-2026-98045: bpf: Mark faultable stack helpers as sleepable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98045

Introduced by commit d4dd977 ("bpf: wire up sleepable bpf_get_stack()
and bpf_get_task_stack() helpers") in v6.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d02927fdf4e930893c92e35fed01a2704496900]
stable/6.12: [44b8d370f2725bad215da3e67668e98ba96671bd]
stable/6.18: [3014e8a8bdad55075d89836ad9c10710a9a69837]
stable/7.2: [19e8d5a98afd071d8c1c5adeccf92b3c42eddc70]

CVE-2026-98046: bpf: Mark bpf_btf_find_by_name_kind() as sleepable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98046

Introduced by commit 3d78417 ("bpf: Add bpf_btf_find_by_name_kind()
helper.") in v5.14-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [620614bf7672130c43b3cff375525a2202f61979]
stable/6.12: [29e40175617216fbd4544529f6bfb51d1ab95ba1]
stable/6.18: [4d8784226bd3c6a707975081f986078f40456cec]
stable/7.2: [17f54a8f2b9714529d56edbbe12d448ccdbbf469]

CVE-2026-98047: bpf: Check ancestor frames for rbtree callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98047

Introduced by commit a44b133 ("bpf: Allow calling static subprogs
while holding a bpf_spin_lock") in v6.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [369f4ce734570bdfedaa4b5ca50e2a3f6a892728]
stable/6.18: [b545fa447e09e6844868deb2bee228827fe54d15]
stable/7.2: [2410cb2ac0416dd2795a81984c8c73d7250bd8c4]

CVE-2026-98048: bpf: don't rewrite bpf_fastcall patterns entered by a jump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98048

Introduced by commit 5b5f51b ("bpf: no_caller_saved_registers
attribute for helper calls") in v6.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b1c83dc3c4401cd7e846548f62e3caf3d06742e]
stable/7.2: [24adbc2c3bbe3385ce922587e1f8e837a68b3e25]

CVE-2026-98049: bpf: zero extend the result of an arena 32-bit cmpxchg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98049

Introduced by commit d503a04 ("bpf: Add support for certain atomics in
bpf_arena to x86 JIT") in v6.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4814ed6406f3493bd554ad046da5f7fc04833571]
stable/7.2: [1c1b476d43a8b6c9bc04600369dd8cc39950d98e]

CVE-2026-98050: mlxsw: spectrum_ptp: Fix napi_gro_receive() call from
GC workqueue context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98050

Introduced by commit 1ba06ca ("mlxsw: Switch to napi_gro_receive()")
in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ac174dfcdde399fa95ba889541fb5e688d8bb35]
stable/6.18: [4375b3d1c2898886df1f908160c7004bdd938e73]
stable/7.2: [7ddcc460176eb34f9bc5bda3cc274d0d24dc62a9]

CVE-2026-98051: net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98051

Introduced by commit 490cb41 ("net: bcmasp: Add support for ASP2.0
Ethernet controller") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c5cf62e72d7a666ee4da757e122dc1600df1ecc]
stable/6.12: [f7f7a16dd46ace4e221336a184c7806f7de19547]
stable/6.18: [a8bddab54aa68b407f12294acb05bd552fb6a492]
stable/7.2: [5df7ecd302488287665ab9767bacba7ed7e2842f]

CVE-2026-98052: net: bcmasp: clear txcb->last before writing each descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98052

Introduced by commit 490cb41 ("net: bcmasp: Add support for ASP2.0
Ethernet controller") in v6.6-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18e5e0ec0e9282c897e2aa81a3e43ccaee03b003]
stable/6.12: [9b26b54861ce05307d39a54ddedddf8747419614]
stable/6.18: [47a5cecca925ceb175d5adf712e667acf78f475f]
stable/7.2: [17e6ad484dea5ddf1c4a3d6ec77a5929161234de]

CVE-2026-98053: ASoC: Intel: avs: Refactor and fix init_config access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98053

Introduced by commit 8a49ef7 ("ASoC: Intel: avs: Send initial config
to module if present") in v6.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [681e91035dc794896a904852040837190e5041f5]
stable/6.18: [75bd5ea9c858d89fb8862f23afb00783bf02cd7a]
stable/7.2: [8f20a0f4f7d638e83ae86db1719a24c7049762f5]

CVE-2026-98054: ASoC: Intel: avs: Fix unbalanced module reference count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98054

Introduced by commit 0a5fb3c ("ASoC: Intel: avs: Keep module refcount
up when gathering traces") in v6.7-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4fa6f94b91137e329ea3f5b360e140b227bb696]
stable/6.12: [3fcf670f023d47e4eb970fb886ee562b5bdfbee7]
stable/6.18: [23ebd4ed5799340f1d2193195c97f61d39aa9899]
stable/7.2: [60b396b2aeca303bc468937d2b44a82399f37b3c]

CVE-2026-98055: ASoC: Intel: avs: Clean up the bus when fetching ML caps fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98055

Introduced by commit 1affc44 ("ASoC: Intel: avs: PCI driver
implementation") in v5.19-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [559ea14b7ae7c7562b48759fa545b64958f35b73]
stable/6.12: [2d96325e8ed97ec70623f788c35cca5d68c34351]
stable/6.18: [498bf26639e99a98e7a3db880a7da8251aaf4289]
stable/7.2: [04447cd14ebcc924f2d745dd33b9506735bda5b4]

CVE-2026-98056: nvme: remove stale namespaces by NSID range during scan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98056

Introduced by commit 540c801 ("NVMe: Implement namespace list
scanning") in v4.5-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ed7f3d7d435bf5b63da2814dc9270f5ba896011]
stable/6.12: [c84ad7407fb16b92d9b7a649cc304a9cf3757897]
stable/6.18: [f56b2bb4b18b017b056c4c17c66b2c4c54bf6ee4]
stable/7.2: [52200fc41a79da430ccf7c126ed837535b087ea2]

CVE-2026-98057: ring-buffer: Add checking nr_subbufs to persistent
ring buffer validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98057

Introduced by commit f5b95f1 ("ring-buffer: Validate the persistent
meta data subbuf array") in v6.14-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [6c001a62c34f13fe1c6a24304c289b387d9e697d]
stable/6.12: [f0467190e6a9fc61e343c8064ef16aad513788c3]
stable/7.2: [69d502457e3f76142f7fcf6e2625e80e0ce8a60f]

CVE-2026-98058: bpf: Mark syscall helpers as sleepable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98058

Introduced by commit 79a7f8b ("bpf: Introduce bpf_sys_bpf() helper and
program type.") in v5.14-rc1.
Introduced by commit 3abea08 ("bpf: Add bpf_sys_close() helper.") in v5.14-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d05524794240b52fdc3b6c1220dd05505715824d]
stable/7.2: [3408e98f06ce06ea6a58ca6c39da9c23f0029c06]

CVE-2026-98059: bpf: Mark sched_process_wait argument as nullable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98059

Introduced by commit 838a10b ("bpf: Augment raw_tp arguments with
PTR_MAYBE_NULL") in v6.13-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a453d6e3b8e8e1a321c8744d6189d763af9287d0]
stable/6.12: [bee862c79cb7e0e5c33b2df2e3a31d164705120d]
stable/6.18: [3c03a1b8ded858685a73c1ba4080adef99db4544]
stable/7.2: [b9205e936dde9a94e93376c8de6195b740bcd5d2]

CVE-2026-98060: bpf: Reject resilient lock operations in rbtree callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98060

Introduced by commit 0de2046 ("bpf: Implement verifier support for
rqspinlock") in v6.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b7b8b5960102566bd625ae829d1f330c5b5d104]
stable/6.18: [cc2e065ed206aecd9b94564779244f3ffb26e356]
stable/7.2: [71930202a0a0c49f0a3b45b41907a074cb780266]

CVE-2026-98061: bpf: Reject tail calls directly from callback frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98061

Introduced by commit e3245f8 ("bpf: properly verify tail call
behavior") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [266aa4ad0b2e82397cd9045752c9bff03d98eddd]
stable/6.18: [617c8266e49f45747f71e74177646a63f72b7025]
stable/7.2: [96d31b28263c429a56e4de85bcf744a5c320b3a3]

CVE-2026-98062: bpf: Mark signal tracepoint siginfo arguments as scalar

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98062

Introduced by commit 838a10b ("bpf: Augment raw_tp arguments with
PTR_MAYBE_NULL") in v6.13-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [77515ab12e4983e6416f8c35039a3f0c0822ac70]
stable/6.18: [0e78cb242a57e481061fcb542fed4d51afba25c4]
stable/7.2: [d2eaea3599bcce659ce91862254dc91bcbdb6351]

CVE-2026-98063: bpf: Fix NULL-ptr-deref in btf_var_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98063

Introduced by commit c4d0bfb ("bpf: Add bpf_snprintf_btf helper") in v5.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5403a383f52fc0905703b488f7c3db4b2447dc58]
stable/6.12: [e472ae0d97865e2021ee668a13eab64013aebf23]
stable/6.18: [ca086264e98108b44fdf53971033811a48defe2b]
stable/7.2: [ea383b3ea56979ce54c8aa88e6ec67164986c401]

CVE-2026-98064: bpf: Fix NULL-ptr-deref when showing a void BTF type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98064

Introduced by commit c4d0bfb ("bpf: Add bpf_snprintf_btf helper") in v5.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ea508b9ebd78bce7f212166d2e2cba66b875f08]
stable/6.12: [717abdfd1d559d01fdd102023f0a990fb0437240]
stable/6.18: [98f1cb95221332139acf514350ae2cae3b8656c5]
stable/7.2: [5324f4e75ff6e9c2ca2e267c5f34f0937f9d0ac9]

CVE-2026-98065: bpf: Reject key-less BTF for hash maps

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98065

Introduced by commit 1df97a7 ("bpf: Register dtor for freeing special
fields") in v7.0-rc2.
Introduced by commit 6905f86 ("bpf: Allow special fields in resizable
hashtab") in v7.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0895a0c0734703be5532f3883c42db95615fd98b]
stable/7.2: [7ca231252820c47aaec42a5db580db98f9b64724]

CVE-2026-98066: ALSA: caiaq: Fix potential double-free at error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98066

Introduced by commit 28abd22 ("ALSA: caiaq: Handle probe errors
properly") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [3b26ceef88c110f4d188387cffa0df78657be904]
stable/6.12: [2883d65a3d9a8d9a682cdb003e6ab7fb28bb17f8]
stable/6.18: [1dd715ca0568e4833ed5878f49b028b449941096]
stable/7.2: [b629ae7b3eddc6812d5af3614b8c1bd76d65fa75]

CVE-2026-98067: erofs: disable LZ4 rolling decompression for now

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98067

Introduced by commit 8e6c8fa ("erofs: enable big pcluster feature") in
v5.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82e664cf1219c459c33aae931b222cf951af9cb7]
stable/6.18: [ec52dfed7b14514ed97ee71161e4cf4cfe2fbff2]
stable/7.2: [c9a2db4b9950b59c571258e4bae74c271f62dd66]

CVE-2026-98068: net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98068

Introduced by commit e97656d ("rds: tcp: allow progress of
rds_conn_shutdown if the rds_connection is marked ERROR by an
intervening FIN") in v4.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [260c6308fe2e19ad519389d44d582e292aecc3af]
stable/6.12: [bd1cb197a07111ca8d4f4c21411c56a3c85a9797]
stable/6.18: [4cb9b6d3d31a2dbaa5469981c2c4c03e9acc7aca]
stable/7.2: [2941561395066be856a53626d4ca973dd9c982b2]

CVE-2026-98069: net/rds: acquire the fastpath locks in rds_conn_shutdown()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98069

Introduced by commit 0f4b1c7 ("rds: fix rds_send_xmit()
serialization") in v2.6.37-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [813f3582ac7ae9f60f917937d54660e0952d5f2d]
stable/6.12: [7febb113795d5de5b690b208f4b0e64a5fad1201]
stable/6.18: [900e96c9749a06833801f60c393aa1d405ea226c]
stable/7.2: [1fe627e5db5c3f53a9f9f9c8a66671755d306955]

CVE-2026-98070: net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98070

Introduced by commit 335b48d ("RDS: TCP: Add/use
rds_tcp_reset_callbacks to reset tcp socket safely") in v4.7-rc3.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02c5f9dc2efd823e061954d564ce00bacd1bebeb]
stable/6.12: [d625112564c3e980e02504270222b49b82690cee]
stable/6.18: [8e4c3b7844c906c7097b4cfedd9dd1f48c9a6a92]
stable/7.2: [062d9e008c67289e8e1b221ecdd8f9d60566d012]

CVE-2026-98071: net/rds: clear cp_flags bits individually in
rds_conn_path_reset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98071

Introduced by commit 00e0f34 ("RDS: Connection handling") in v2.6.30-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [103c4b13c4f50322910078d1c02f29334a574122]
stable/6.12: [ed3ee0ac4aafda50c2f4381eb973beefeb7879ac]
stable/6.18: [6b8d7563c28b8112e6e54abe413b028ef3f8c549]
stable/7.2: [cb62aa8f04655a4df487913949719c0a1266ed73]

CVE-2026-98072: net/rds: use wq_has_sleeper() in release_in_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98072

Introduced by commit 1422f28 ("rds: introduce acquire/release ordering
in acquire/release_in_xmit()") in v6.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [6d0c8b7073913011459cf968cbbadd341e166bc3]
stable/6.12: [ed7ee0cd0e136d02f87f13181b1a89880463c7e9]
stable/6.18: [a269795107f45adc95975a83324f8fef40bec4ce]
stable/7.2: [3764627b30a283e611e652c4a2bb8cdc74a75a99]

CVE-2026-98073: net: Remove conflicting altnames for dying netns in
__dev_change_net_namespace().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98073

Introduced by commit 36fbf1e ("net: rtnetlink: add linkprop commands
to add and delete alternative ifnames") in v5.5-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [debac3a20dec524a59625cf10fa2f18571127824]
stable/6.18: [a29ea5b5034654aaaa4aadd771f48c01abfd2dfa]
stable/7.2: [ac6631843269e6a9b2164e393b7f729328711d78]

CVE-2026-98074: bonding: do not clear curr_active_slave prematurely
when releasing all slaves

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98074

Introduced by commit 0896341 ("bonding: fix bond_release_all
inconsistencies") in v3.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af602c7aa5fedc9be3043244017aef4f26c96b70]
stable/6.12: [d6ef22e79c2be3612868daede0e9a84f05439d9e]
stable/6.18: [19ba7ecfade159b3702c78a360fd7d971e2b7109]
stable/7.2: [6d0ee411d5437f3d126ea6979acb83a8da29dc81]

CVE-2026-98075: bpf: reject BPF_PSEUDO_FUNC reference to the main program

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98075

Introduced by commit 69c087b ("bpf: Add bpf_for_each_map_elem()
helper") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [374b2c5561db80fcdd7cdce44af37a49416f61c7]
stable/6.12: [118212417ba0120d99f84154799f8880f07411f4]
stable/6.18: [d6c39774ae093c9f7009cc4ae918f18fc1af7ae7]
stable/7.2: [92f0bd0e2b632c6565ac2214a4d7d2ed37e5b9f6]

CVE-2026-98076: tracing/probes: Fix use-after-free on field name/type
of events with multiple probes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98076

Introduced by commit ca89bc0 ("tracing/kprobe: Add multi-probe per
event support") in v5.4-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86b7a239ec6b14a7544200ede85474c6f5526049]
stable/6.12: [68ae584169c7a41fc9bc4677c1d368983cf44b21]
stable/6.18: [411c9080a776577664531b4f7d3ee53b7a747ba8]
stable/7.2: [178ff2e011e21fbebdf57f5d58a408fe59136d82]

CVE-2026-98077: netfilter: nf_conntrack_sip: fix OOB read in
sip_skip_whitespace()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98077

Introduced by commit ea45f12 ("[NETFILTER]: nf_conntrack_sip: parse
SIP headers properly") in v2.6.26-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8f8231824b5815f57ce62cba116e511b10196de]
stable/6.12: [60c012b2d05e1558b0f30ea3f15a2c3ca2f24d94]
stable/6.18: [4be8380e3af008f418f97992c06f23be649a430d]
stable/7.2: [4a30aa2ba007db18210dd52219ecbd5528c03523]

CVE-2026-98078: ipvs: fix reversed sequence option serialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98078

Introduced by commit 986a075 ("IPVS: Backup, Change sending to Version
1 format") in v2.6.39-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b04578b74f2d3755548fe9e829e3b2a6c6f966a1]
stable/6.12: [e1c9f9446d3eaae323f1689f9e5de3b1ad6e47ec]
stable/6.18: [524599714558da83747c04952d378155c69f5b6b]
stable/7.2: [de6cc6ec7932bc530f2bb92005dac9123d50659c]

CVE-2026-98079: btrfs: zstd: fix lost wakeup when waiting for a workspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98079

Introduced by commit 3f93aef ("btrfs: add zstd compression level
support") in v5.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2acb9f3d1cc8f65dc81ed55e238cbf8e5b60bff7]
stable/6.18: [d8f57049521948df5f50797141472fbbed3b0723]
stable/7.2: [0de9f31d447ae71ab08c7850a321682f8d2907c3]

CVE-2026-98080: btrfs: do not force reloc root creation during
qgroup_account_snapshot()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98080

Introduced by commit 4d31778 ("btrfs: qgroup: Fix root item corruption
when multiple same source snapshots are created with quota enabled")
in v4.17-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cacf35832292997018837e484283f95a9301ebf5]
stable/6.12: [c4c78768d1a8ceb713693cc5524acbe984c31f3c]
stable/6.18: [203cbfb4fba590bd9b08bd36fa6d05b5d28923bf]
stable/7.2: [b5d5ab5a715001dd937c920ef8c5688fd4999ba1]

CVE-2026-98081: btrfs: zoned: finish active block group cleanup if
call_zone_finish() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98081

Introduced by commit d70cbdd ("btrfs: zoned: consolidate zone finish
functions") in v5.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a18a6b93a2843b9d103d3456bbd4b3f90282a379]
stable/6.12: [36b9cdab44848f25879ca625275c92b007f84653]
stable/6.18: [40370f02a1ca3760f8925ffcbe76eb4d91ea758d]
stable/7.2: [e1b168a53174b385e3548bfbd079513b22ac240c]

CVE-2026-98082: btrfs: fix the possible bioc_list memory leak during error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98082

Introduced by commit 02c372e ("btrfs: add support for inserting raid
stripe extents") in v6.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [afbe73778338e6d1ac8c4486fbdf33f0cc1f2624]
stable/6.12: [83f0c973cffb184d019390ffdb5d31de5c85bc61]
stable/6.18: [1b4d4e890c2c85d0f6365b5a08c48b4bbf85deb0]
stable/7.2: [bb4da45766d16503821f167054db76b735d89e94]

CVE-2026-98083: btrfs: fix transaction use-after-free in raid stripe insertion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98083

Introduced by commit 02c372e ("btrfs: add support for inserting raid
stripe extents") in v6.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a8813a923f9e43f788b357fb55c35f7f6ed6f98c]
stable/6.12: [b185bdf30313e213fa1c887fe22fc3d513c061d9]
stable/6.18: [2fbfd02bdfe12b20bd3cc7a3190fb32e3f7072f5]
stable/7.2: [b7b94923b3b5774d85a2a7c8d6eb9e3e0ef66685]

CVE-2026-98084: bpf: backtracking shouldn't clear outer frame R1-R5
for callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98084

Introduced by commit ab5cfac ("bpf: verify callbacks as if they are
called unknown number of times") in v6.7-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [e3e4f66cc4b72333d0886ae2673c360248987889]
stable/7.2: [f83890dfed9efc5e19df1dbc1ad707a142936923]

CVE-2026-98085: bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98085

Introduced by commit ee86148 ("bpf: Fix ld_{abs,ind} failure path
analysis in subprogs") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [387b1baefbb776e3f48dc2261e77a49213f470f7]
stable/7.2: [671b7b9a660ef15b25faa3df161205b9dc8d1eb2]

CVE-2026-98086: ALSA: ump: do not touch legacy_rmidi before it exists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98086

Introduced by commit 37e0e14 ("ALSA: ump: Support UMP Endpoint and
Function Block parsing") in v6.5-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adeee7187694719890aaffdc14b7e89cfd736f1d]
stable/6.12: [1c8e01792adf91879322f1ad752f1814de8b7e7d]
stable/6.18: [228075f31b141395233218712242913125ace4e0]
stable/7.2: [a4cef20cd473e0640fefd38094d4baac0ec76ae3]

CVE-2026-98087: sched/rt,dl: Skip migrate-disabled tasks when picking
a push candidate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98087

Introduced by commit a7c8155 ("sched: Fix migrate_disable() vs rt/dl
balancing") in v5.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dae5c0292080dd7b9c7d784268dcf443f1f3d15e]
stable/6.18: [755476d7ba92a1f3fe2a376c515d710bc6baebc3]
stable/7.2: [b0c6f947057751ab4d30ccf8095cd19804fb97fa]

CVE-2026-98088: scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node()
call in _base_assign_reply_queues()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98088

Introduced by commit 728bbc6 ("scsi: mpt3sas: Affinity high iops
queues IRQs to local node") in v5.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0d26fe176a8db6ccad4ab38c5bab29391c1946b]
stable/6.12: [0a5f7cdb0cb911584720591069065f09c59ec4fc]
stable/6.18: [7b23144c3ff6e46d7d4a464b02f8944265684e39]
stable/7.2: [45504e621b7e884abe59f201e093a3eac7fca7fe]

CVE-2026-98089: bonding: alb: fix uninitialized transport header
access in alb_determine_nd()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98089

Introduced by commit 0da8aa0 ("net: bonding: Add support for IPV6
ns/na to balance-alb/balance-tlb mode") in v5.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70f3995830d3f1e79faa14eb0605914f778feca9]
stable/6.12: [e39cf90bd856443542b97933289749fca07476bf]
stable/6.18: [27314f96d29b54e815e7a9b84c3273f1895e68e2]
stable/7.2: [3b178894931a268c09126a5b53630f343e10e296]

CVE-2026-98090: btrfs: restore active device pointers after failed sprout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98090

Introduced by commit b7cb29e ("btrfs: update latest_dev when we create
a sprout device") in v5.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0b54613aabeb8e9da597f23b90c6a03d0981986]
stable/6.12: [2ee5c4bc11007c51f63f0c1be5d3f07f2b404ff7]
stable/6.18: [e127ac29a52134d0f4cba39d38e4b375deb3d1aa]
stable/7.2: [b79b4b29003690acfade8241998fc0104ef9c84c]

CVE-2026-98091: btrfs: detach failed sprout device from transaction update list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98091

Introduced by commit bbbf724 ("btrfs: combine device update operations
during transaction commit") in v5.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c93b3c43df561cd9f592cee20ae058b563f9e5b6]
stable/6.12: [e9e7e37afa85db770e6084360b21a21a8b3a583f]
stable/6.18: [8b001df2b37ca022f710f3254fbb0bcd6d9e1bed]
stable/7.2: [0ea6814bc0ff7cff443241bd34db9f0f828f3190]

CVE-2026-98092: ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98092

Introduced by commit 7610174 ("ASoC: amd: add acp6x pdm platform
driver") in v5.16-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b67e0d3b9691d7b6b74e18960ddd2be24f9dc9d]
stable/6.12: [8069bc3798dd33e8e7e9ad21370ee32dcd69957c]
stable/6.18: [ecd88ef5f1d208596592cfa6695ab9e240ac6a72]
stable/7.2: [ac961c34cf39f66296caf8294fa5baaee4124266]

CVE-2026-98093: ASoC: fsl_micfil: balance mclk enable/disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98093

Introduced by commit b47024d ("ASoC: fsl_micfil: Add mclk enable
flag") in v6.13-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3dbccfe6afa7b9a6a7ed65cfaa76a47fa050a56]
stable/6.18: [470db2026a435b79f7ecb4d65523ea16a99d55d8]
stable/7.2: [fa1bbe3534499dd89d3b0b941d6dd4ddb70c31b5]

CVE-2026-98094: staging: fbtft: make dirty_lock IRQ-safe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98094

Introduced by commit c296d5f ("staging: fbtft: core support") in v4.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f576944a59f31bcffff121117ebf452c5dd162b7]
stable/6.12: [2a609e29efbba79f9abd68c4ec8a2bd7ecf291e7]
stable/6.18: [f0c869df2c33793c8828acaab3e4a5e0176f9f00]
stable/7.2: [dcb48fde8003492256dee45815144aa5ed26ce7c]

CVE-2026-98095: af_packet: Don't cast tpacket_hdr.tp_len to int in
tpacket_parse_header().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98095

Introduced by commit 69e3c75 ("net: TX_RING and packet mmap") in v2.6.31-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73e594c19b4f815d8343461cec7074c4713bbde7]
stable/6.12: [c6b3db727876a027013aa4ccb6913a153a2af41a]
stable/6.18: [72abe77e88c3f1f71c5348124e9b28e285f26950]
stable/7.2: [9d714076ff398ba8cc5ae0ae146f4a1ea0bbf5e8]

CVE-2026-98096: ipv6: sr: restore network header before routing and forwarding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98096

Introduced by commit 1ababeb ("ipv6: implement dataplane support for
rthdr type 4 (Segment Routing Header)") in v4.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [975b5b067f525a1b1338c4a3bee1c46545801518]
stable/6.12: [ce4c8beedc19aceeab0e7bdc6f34394fb158c47c]
stable/6.18: [97b21ef57dfabbff660a4672c9fef7edfb720f47]
stable/7.2: [3ad7dca5e03bd64c65983a19734337512fd75491]

CVE-2026-98097: tipc: Dont send random pad bytes in RESET/ACTIVATE messages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98097

Introduced by commit e74a386 ("tipc: remove pre-allocated message
header in link struct") in v4.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81c600c26302a27852ed8b19c5f2f647ea3555c9]
stable/6.12: [48033a89356b8ae21a94db70c79bb6fcc91a23c2]
stable/6.18: [4ab2977323d5f068a872126f7818d1aeb9e9ca0d]
stable/7.2: [bee1459e57f2e0bd240c62f35c0a284291e27971]

CVE-2026-98098: tipc: fix NULL deref in tipc_named_node_up() on empty
publication list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98098

Introduced by commit a5e7ac5 ("tipc: fix regression bug where node
events are not being generated") in v3.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3b76e9f4f2476f1135b2ba7743a821db4a0df4b]
stable/6.12: [68619f965329d2f7b113a3d5811aa23198f39105]
stable/6.18: [ad805326d874062f8bc72a94884f86046148cde3]
stable/7.2: [d0d82f1214f321143c5dbc2e48e4a4e6c4226895]

CVE-2026-98099: ipv6: mcast: use rcu_assign_pointer() for __rcu list updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98099

Introduced by commit 456b61b ("ipv6: mcast: RCU conversion") in v2.6.38-rc1.
Introduced by commit 88e2ca3 ("mld: convert ifmcaddr6 to RCU") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [0c8f56c583c3250408367880c98e4d6fbc929315]
stable/7.2: [2e46b0c9fcf7e10b64ce1630b925f47918d1f7f6]

CVE-2026-98101: ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98101

Introduced by commit 882ba1f ("mld: convert ipv6_mc_socklist->sflist
to RCU") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [c073d1b070f171d206b19c98d71739a97f15b3f1]
stable/6.18: [2c2091e2ee93049fc513ad1e6c99d8b6c809f467]
stable/7.2: [20db91a052332ef5552bd2f651ffb9db911cf67b]

CVE-2026-98102: ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98102

Introduced by commit 4b200e3 ("mld: convert ip6_sf_list to RCU") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [93b49239840b91313adbd77b8b52993eff2d08c1]
stable/6.12: [4352737297b262e8367675c19a7dc6a9f53c97af]
stable/6.18: [8d4fe5c13f5056faa6deb09a90e24a89f9ebfad4]
stable/7.2: [5149c60c406595b56fda0c6e9aae7fd287f636aa]

CVE-2026-98103: igmp: convert struct ip_sf_list to RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98103

Introduced by commit 23d2b94 ("igmp: Add ip_mc_list lock in
ip_check_mc_rcu") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [2987ee196c88dbde0463dc87d5fb209c684e34a2]
stable/6.12: [f5182dfad54277267a8cb0c004a9cd4cf35aeebb]
stable/6.18: [d3011d1f293478c730aa0870490afa145c37600e]
stable/7.2: [e3206419bdb04e2087d8cc6be324df8639b3fac5]

CVE-2026-98104: net/sched: cls_u32: fix duplicate handle when node ID
pool is exhausted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98104

Introduced by commit 7801db8 ("net_sched: avoid generating same handle
for u32 filters") in v3.16-rc7.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7e7e98d23f42a92d9ab7e36302bd96bd9b33b5f]
stable/6.12: [6890e28840bae4f6805e8de981c4ec8e12a4e064]
stable/6.18: [feab9261b537df4ebb8350e4779bc185373059fd]
stable/7.2: [f594f04268d01c5fdc975f3f51fc219ea2159ac6]

CVE-2026-98105: net: ethernet: oa_tc6: Improve the error recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98105

Introduced by commit d70a0d8 ("net: ethernet: oa_tc6: implement
receive path to receive rx ethernet frames") in v6.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [172c974113bffe5723b80b1acac17593bb50513c]
stable/6.12: [d33003e752f25c385f2cf21964123582a44f6818]
stable/6.18: [9d3f6e714d5f8b728837f31bbe865b64cfd3216a]
stable/7.2: [b89770d493749d7c3b8649996e1089719b4eff8d]

CVE-2026-98106: drm/pagemap: Prevent double migration of device pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98106

Introduced by commit 99624bd ("drm/gpusvm: Add support for GPU Shared
Virtual Memory") in v6.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4126f1db36e6b2e1c79b0e30a8a2de91c568f4c]
stable/7.2: [62451f540c46bf5c51143a1c8681b472608bd54d]

CVE-2026-98107: Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98107

Introduced by commit da49b60 ("Bluetooth: L2CAP: Use DEFER_SETUP to
group ECRED connections") in v5.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56c2b5831d39dc84aad2573dc3e197af1a872a05]
stable/6.12: [ce0927eb3ee2939fab5ce3f9334bfd2fafb38481]
stable/6.18: [6da5c0331fc3ef0c7b8df8269523fc3b2cce1e65]
stable/7.2: [df8c3af6132640da4788e96a02d653e642059803]

CVE-2026-98108: Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ +
EXT_FLOWCTL pchan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98108

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ef05db5b08b176a551b4a6287372045998806b0]
stable/6.12: [1074bcc57f741223f9fa82ce6afe5c3d783e4d10]
stable/6.18: [5d5a625cbc854d4c4f68e4b16fcf6e682d9a9ed1]
stable/7.2: [6cb79e6499228cfdbd4b3301371ce74d01cd2f80]

CVE-2026-98109: Bluetooth: hci_core: Fix race condition during device
registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98109

Introduced by commit 9e14606 ("Bluetooth: msft: Extended monitor
tracking by address filter") in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57938bbdb9bf7fd41cbd5cd509ec10c4b22bec18]
stable/6.12: [b1faf348c29e6f8302ec7769cbf1c1ef05be014f]
stable/6.18: [a11ebe8dc0333fb870bbbb656b34690e87ee3f98]
stable/7.2: [d427b1c71d9798083e954d3c13469dc0a2305868]

CVE-2026-98110: Bluetooth: btintel: bound firmware ID by TLV length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98110

Introduced by commit 164c62f ("Bluetooth: btintel: Add firmware ID to
firmware name") in v6.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac8aa9e0ec93a12a60230066f199f49c3b9aac3d]
stable/6.12: [aef56a2bd5aa22808ce508605d7497d2b5e8eb5f]
stable/6.18: [058f56de5f48ba4b3be01526006ac83ce9e79f39]
stable/7.2: [a07b3024a927892dd46e7dfbed438e8834e24098]

CVE-2026-98111: Bluetooth: btintel: validate version TLV value lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98111

Introduced by commit 57375be ("Bluetooth: btintel: Add infrastructure
to read controller information") in v5.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a086c0892969bf8a0151b0f12bd14a68827c88b2]
stable/6.12: [83499ac3ca62e43ed40f7574b13ed398a6891511]
stable/6.18: [76948d207d0978a613ce06a05cba07284a5578a7]
stable/7.2: [5ec43df2830b73e004147303bf7914ca884d6770]

CVE-2026-98112: ksmbd: fix listener task lifetime on netdev events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98112

Introduced by commit 3316a8f ("ksmbd: server: avoid busy polling in
accept loop") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a506290f59e1c6ce9ac0a13158640bb8fee93471]
stable/7.2: [40581f10c1e56238b157af5f260b8f9518a0cbc1]

CVE-2026-98113: ksmbd: rate limit unmapped SID errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98113

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feca5e70fc963b088377b20879e8cd8237c2fd7d]
stable/6.12: [13af319c1efec0b45fb5c1b16830eb0888b3fd1e]
stable/6.18: [30dbb08777b9a611d7d9193c040f382fbd0e7562]
stable/7.2: [54cb2a909996346ac6a8a3beac96c07b3dcba584]

CVE-2026-98114: ksmbd: propagate DACL parsing errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98114

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c61dc7b1b4a3234b4aa3965502908a292238805c]
stable/6.12: [461f10a5297e85b7c1cd21838922f2e57b934d2d]
stable/6.18: [37952f03d5171eb3a33b2abc2cf6e456d69ff4a1]
stable/7.2: [a04dac1f2cffe9533f4260f0659297d805e69194]

CVE-2026-98115: ksmbd: safely drain sessions during logoff

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98115

Introduced by commit 76e98a1 ("ksmbd: fix race condition between
destroy_previous_session() and smb2 operations()") in v6.11-rc5.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d12168084c8c1b6d883c8eca5853929ac5136a9e]
stable/7.2: [a7e6df0bb92642bee4431b2b85c69ada1e463b21]

CVE-2026-98116: ALSA: pcm: Serialize PCM mmap with buffer reallocation
to fix page UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98116

Introduced by commit 92ee3c6 ("ALSA: pcm: Fix races among concurrent
hw_params and hw_free calls") in v5.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [9b110a9dcecc59516c77cb3c0caf1f492f75df2d]
stable/6.12: [cbc7ec97601d09b74e05e44470fa6b0bcdabf3f5]
stable/6.18: [fd137bf8149bc6460f9b7b1fc292025da04cb9ee]
stable/7.2: [8c1882dfee8f404d118020664b73eb4592172226]

CVE-2026-98117: cachefiles: Fix potential UAF/KASAN warning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98117

Introduced by commit 229105e ("cachefiles: Add auxiliary data trace")
in v6.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a67632c8c2688d6e0091529bcefe54bc5ee80e9b]
stable/6.18: [68d459e6e609c31f96a203dd6eec60c634f155e1]
stable/7.2: [93488ea378b4427598cace558236c110515d743b]

CVE-2026-98118: netfs: Fix readahead synchronisation issues by loading
all folios upfront

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98118

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fed0b33e6c584986ba70018ec9f9787a98216e64]
stable/7.2: [8c9b33945712074a85d3bdacbca036ba6b3d92c6]

CVE-2026-98119: netfs: break unbuffered write when
netfs_alloc_subrequest() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98119

Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fb45a934661419c04a44d4cfea1e0df7dcf2805]
stable/6.18: [cf6f93b8b06acf57de62dacbe71a3b99c68656a7]
stable/7.2: [19f246c795e940dc5f11cd5bc0cb1e81bc7b7090]

CVE-2026-98120: netfs: Fix subreq ref leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98120

Introduced by commit a0b4c7a ("netfs: Fix unbuffered/DIO writes to
dispatch subrequests in strict sequence") in v7.0-rc3.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [3c30087e27598d9d359763e8be9bd3017fe08348]
stable/6.18: [ebefb12122d1319257ecac01c1a928f78007716a]
stable/7.2: [0a573f4283a965a5e8716f621aec404cb4575328]

CVE-2026-98121: watchdog: msc313e: Fix NULL pointer dereference in PM callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98121

Introduced by commit e9800b7 ("watchdog: Add Mstar MSC313e WDT
driver") in v5.14-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3eceb76515910746e6268c4e4ac1c07516ebd7b]
stable/6.12: [b02f902fe4b59d65f74a25c4523a75453bd3f808]
stable/6.18: [744b25040d8206f7925b8ba0be5edf93fa4bf81e]
stable/7.2: [6495dc16e635356fd2b7535dcbf9b6779de4e753]

CVE-2026-98122: vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98122

Introduced by commit a3a48de ("vxlan: mdb: Add MDB control path
support") in v6.4-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4aa61c88b4e292e10abdfd791334b8272108d68a]
stable/6.12: [e12c903fd13c6261b98ca18d8f70ac26e739e2f8]
stable/6.18: [74e2a56c82209b0335b53e25f19f9b0590e2483d]
stable/7.2: [71203a41d6fa2fa0ea2f3a7541987958bd3694fd]

CVE-2026-98123: sctp: fix soft lockup from unpadded ASCONF-ACK
parameter iteration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98123

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cb0b0b1ed69430bf73740377ea0a1c44c50db63]
stable/6.12: [abf59d7f6fff23227256e8199aca5ade45758f8b]
stable/6.18: [3be02999ab9131a4b96eb1eda4ca48b1cea80f03]
stable/7.2: [7ba84e2971d208a2d6413a334ec28a8a32cdce0f]

CVE-2026-98124: smb/client: invalidate fscache for fallocate range operations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98124

Introduced by commit 3017562 ("[SMB3] Enable fallocate -z support for
SMB3 mounts") in v3.17-rc2.
Introduced by commit 31742c5 ("enable fallocate punch hole ("fallocate
-p") for SMB3") in v3.17-rc2.
Introduced by commit 5476b5d ("cifs: add support for
FALLOC_FL_COLLAPSE_RANGE") in v5.13-rc1.
Introduced by commit 7fe6fe9 ("cifs: add FALLOC_FL_INSERT_RANGE
support") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [448ba0ae65ca61064183564d2983c9aa59bd6ba7]
stable/7.2: [93c6e5a8d7c5071d586c1411596d5db5faad22b2]

CVE-2026-98125: smb/client: fix stale page cache in insert/collapse range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98125

Introduced by commit 9c8b7a2 ("smb3: fix temporary data corruption in
insert range") in v6.0-rc4.
Introduced by commit fa30a81 ("smb3: fix temporary data corruption in
collapse range") in v6.0-rc4.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01261a6fa48b62f5ead8e88aaca1e27cb9ab9032]
stable/7.2: [76222e76d08fbae4092ee9da84ded2b4c24ee598]

CVE-2026-98126: smb/client: validate new EOF for zero range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98126

Introduced by commit 72c419d ("cifs: fix smb3_zero_range so it can
expand the file-size when required") in v5.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88972e35750792e717af287dc71f42a03b5cbce4]
stable/6.12: [3673f057b64abfa957e8ae84448db69369a5091a]
stable/6.18: [06a4f9049cb6dc319bceec2dc813ba89add8b828]
stable/7.2: [f320ca20c273a26cd779bdb2b2e4b076a95c76f6]

CVE-2026-98127: smb/client: validate new EOF for insert range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98127

Introduced by commit 7fe6fe9 ("cifs: add FALLOC_FL_INSERT_RANGE
support") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1519dc88c87f5346dae0464d7d6da1b6bf1f6e8e]
stable/6.12: [7c2c69045aa76ccaa7f16f1478eb312130ce4951]
stable/6.18: [bc7602b9082ef195d913c4c16fa9853dd262333e]
stable/7.2: [f8cbfe3a3fcee7d991fd223f660f3e5df13221cf]

CVE-2026-98128: scsi: mpi3mr: Fix target device refcount leak in
mpi3mr_sas_port_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98128

Introduced by commit e22bae3 ("scsi: mpi3mr: Add expander devices to
STL") in v6.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [419d129f970aaa6567dbac366b0c93784bf9ec97]
stable/6.12: [040146f81d099006a354b0caacc7f01ca00f257e]
stable/6.18: [06a7073b33b8f5cb0ee71e07dc669efffb1c7d58]
stable/7.2: [1ccbe8c42009706af79e6629c70d42fc929aef2b]

CVE-2026-98129: scsi: mpi3mr: Fix NULL pointer dereference in
mpi3mr_sas_port_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98129

Introduced by commit e22bae3 ("scsi: mpi3mr: Add expander devices to
STL") in v6.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dba9e2181ca5e875f98b8b9b4535cdaab87dcb0d]
stable/6.12: [5c50137ba11b6e20e7074303dae35ff58d5a0b6f]
stable/6.18: [2f69ed909de9e3d46af9db7dd24b9b80dc31b5ec]
stable/7.2: [5cb58b052cf09dd8e88d92c1d649b3eea5c95d4d]

CVE-2026-98130: sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98130

Introduced by commit 20a785a ("sctp: Don't add the shutdown timer if
its already been added") in v5.7-rc7.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [2188569e7e1b0bc3f3b557dc97ab7a02befc11c8]
stable/6.12: [e42ba56281ca3ae2dcb3558bebee9a1c9a4831d9]
stable/6.18: [00b841bac10230c557be6b38efc48508198fe23e]
stable/7.2: [3d698d1e6c8bc41e3e1707777a016f1bdd07842d]

CVE-2026-98131: net: stmmac: fix dma mapping leak in stmmac_tso_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98131

Introduced by commit f748be5 ("stmmac: support new GMAC4") in v4.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5d946466a95621fa2769720d59ea336003aa1a5]
stable/7.2: [e85adaac3dc6317cae902372c6849189ec62cf7d]

CVE-2026-98132: bpf: don't downgrade half-dead scalar zero spills to STACK_ZERO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98132

Introduced by commit be23266 ("bpf: 4-byte precise
clean_verifier_state") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3536bff8823d3c5fdbbe15e17bfca696cc2b2e]
stable/7.2: [436fa689630b741a77ef8c4a6f426479affd5bac]

CVE-2026-98133: ntfs: leave HasEA flag untouched on setxattr failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98133

Introduced by commit fc053f0 ("ntfs: add reparse and ea operations")
in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac727d86fb84bdc9626ba9c756c26767459f3083]
stable/7.2: [5811a08310754cbf4a1122c81d14c54b8873c35c]

CVE-2026-98134: bpf: check_cond_jmp_op(): properly infer if register is null

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98134

Introduced by commit befae75 ("bpf: propagate nullness information for
reg to reg comparisons") in v6.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3ef6c097ba078e1f8c7239d76a0ce8b61e75095]
stable/7.2: [b55c9f019e169ed0d01394f96e172286a8b21b99]

CVE-2026-98135: ntfs: reject invalid sectors_per_cluster in the boot sector

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98135

Introduced by commit 6251f0b ("ntfs: update super block operations")
in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323751a604e7533fa473874d999371592a614207]
stable/7.2: [7524c3145a3bac92bebbc47a29c007f1d874c9b3]

CVE-2026-98136: ntfs: bound $AttrDef table walk to the loaded table size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98136

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8504fc1245f5322af5fa5c325ab05f9cf792b87]
stable/7.2: [3e2ae47b8ebc632c27e7843a4632d9a7c060885e]

CVE-2026-98137: ntfs: treat any nonzero dio zero-range return as an error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98137

Introduced by commit 495e90f ("ntfs: update attrib operations") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [607a9478833db656e7ceac8e9e382fa4acfde545]
stable/7.2: [56392b0d5290ff2b05fc673bc07803b8ae4cfd1b]

CVE-2026-98138: ntfs: do not mark the volume clean in sync_fs when
errors were recorded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98138

Introduced by commit 6251f0b ("ntfs: update super block operations")
in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e4c839905418d55bafe571a92533a1d1ac7b0a8]
stable/7.2: [ca1f9933eff777a604eb664d0f9ae433b8664cbf]

CVE-2026-98139: ntfs: only count successfully cleared runs when freeing clusters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98139

Introduced by commit 11ccc91 ("ntfs: update runlist handling and
cluster allocator") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be9e89ccb8e52a3e4b67feeb03ebd8133091dc7e]
stable/7.2: [7eb97d8828e7758b9c81277f7802e740a800f78a]

CVE-2026-98140: ntfs: fix kmap_local leak in write_mft_record_nolock()
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98140

Introduced by commit 115380f ("ntfs: update mft operations") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf06dcd572845723821b54a608fc2da995c3c8e2]
stable/7.2: [5d7f7bf8fba8cf563b42b44aa4ab3d9928ac480c]

CVE-2026-98141: ntfs: propagate reparse index insertion failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98141

Introduced by commit fc053f0 ("ntfs: add reparse and ea operations")
in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9692b1b4fc00cf89628bc43f71729ab21f14f8d3]
stable/7.2: [c62f446c63398dc7151f413069bf617032cf7a71]

CVE-2026-98142: drm/cirrus-qemu: Validate BAR0 size during probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98142

Introduced by commit ab3e023 ("drm/cirrus: rewrite and modernize
driver.") in v5.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92312d333bf700798f92f30406c721bce87506f3]
stable/6.12: [0b5084a1f070ad1fc34e11945644ae034bbc774c]
stable/6.18: [26bd90c886218f36c9adeab206b0e27b4384e2f6]
stable/7.2: [144f51cd0ccc3ad47a6099917b7bb535611fb18f]

CVE-2026-98143: accel: ethosu: Don't read the U65 rounding mode as a
storage mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98143

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Introduced by commit 6b7e006 ("accel: ethosu: Handle U85 internal
chaining buffer") in v7.2-rc5.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db9deec5a345abc538d081fb221dc0b00a9695bd]
stable/7.2: [6b08adbda8ea797849e3654ce12cb3856ce6051a]

CVE-2026-98144: accel/amdxdna: put the chained BO when its mapping fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98144

Introduced by commit d76856b ("accel/amdxdna: Refactor GEM BO handling
and add helper APIs for address retrieval") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e33ba3a1d48c2d20ed270dec9d2d08332585c8e]
stable/7.2: [eb90cb257e0792ac11f0347254bad3fc72417db6]

CVE-2026-98145: accel/amdxdna: reject a command chain that carries no commands

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98145

Introduced by commit 8ed8b02 ("accel/amdxdna: Add debug prints for
command submission") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef6d27af71e1dc43181ec797a6aaa77c27c36786]
stable/7.2: [ed74e8d603df457bfcf16ed4f8f1660a1525759e]

CVE-2026-98146: accel/amdxdna: Remove __counted_by from struct amdxdna_cmd_chain

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98146

Introduced by commit aac2430 ("accel/amdxdna: Add command execution")
in v6.14-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3709d354545e70388177500761f92d906c4dfd6]
stable/6.18: [93fa3e925b15b0ded0a549fe7f12bfbb1c4e171a]
stable/7.2: [52f3e086760a9a3e02a46a10b57caffd73b1c204]

CVE-2026-98147: printk: Don't WARN on kthread_run failure.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98147

Introduced by commit 5f53ca3 ("printk: Implement legacy printer
kthread for PREEMPT_RT") in v6.12-rc1.
Introduced by commit 76f258b ("printk: nbcon: Introduce printer
kthreads") in v6.12-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72dd0ec09e7cc98ed58ddeac26575e5d1ab8a93d]
stable/7.2: [4e676279798148382497d0e38c0bd51115e64be1]

CVE-2026-98148: drm/gud: validate GUD_ROTATION_0 is present in
supported rotations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98148

Introduced by commit 40e1a70 ("drm: Add GUD USB Display driver") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb732d027aa18e1fcf9d2797f47d20b179ebc59c]
stable/6.18: [b2cd682324b889011874cf844b7c7efa97c97296]
stable/7.2: [876b33d8a9a00e9d4bbcbb7f55ad2c05974850de]

CVE-2026-98149: bpf: Fix percpu map update indexing with sparse CPU IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98149

Introduced by commit 8eb76cb ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
flags support for percpu_array maps") in v7.0-rc1.
Introduced by commit c693616 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
flags support for percpu_hash and lru_percpu_hash maps") in v7.0-rc1.
Introduced by commit 47c79f0 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
flags support for percpu_cgroup_storage maps") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75b0a6db4300e4c2c9e97a0848deaa7acfb42fb7]
stable/7.2: [c16c62c91e5d6737a9fbb0a541b8b34610470a2b]

CVE-2026-98150: bpf: Fix BPF_F_CPU validation for sparse CPU IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98150

Introduced by commit 2b42166 ("bpf: Introduce BPF_F_CPU and
BPF_F_ALL_CPUS flags") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed54bf564ac52699cf4def3d0c2125d493e756f9]
stable/7.2: [bdc5941f6eeef90b76a07fd8ca38ac1933ba2195]

CVE-2026-98151: bpf: Fix REG INVARIANTS VIOLATION on speculative
pointer arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98151

Introduced by commit 5f99f31 ("bpf: add register bounds sanity checks
and sanitization") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [150aeba624e8b7cac51c39440d7e8e1fd11de9a0]
stable/6.12: [21a681526c715aebb4f918b8c131583442d1b3d8]
stable/6.18: [d623a4a58bb238443505d5c2949d1182dcfc26b6]
stable/7.2: [9f9477ae73de9c5a28e8ab7000d8097b078faee4]

CVE-2026-98152: nvmet-rdma: fix queue leak when connect backlog is exceeded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98152

Introduced by commit badc536 ("nvme: target: rdma: fix ndev refcount
leak on queue connect") in v7.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [fb1ed67788e21832b614c23767a088c08cfdd2f2]
stable/5.15: [186414a6a1a34e081b07e8873622f90402346235]
stable/6.1: [e48f9d1076f8c62c3969588d638602b94aaeff12]
stable/6.12: [287420cde9d6669abcd2878c344db67423eb7df6]
stable/6.18: [4f7cf573cdf0ee857448b9b1967d686b07c71e7d]
stable/6.6: [32e598324edc3ebb1ac9362d5b9fc30ce0de4873]
stable/7.2: [60d56bf0b14d3c545bacb9aeef92a7e6f2cf0caa]

CVE-2026-98153: nvme: fix racy access to FDP placement id array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98153

Introduced by commit 30b5f20 ("nvme: register fdp parameters with the
block layer") in v6.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56e1c6bbe4bb084d7ecf61698afdf70be23dd35f]
stable/7.2: [e0a23e3c8c4c3ce11529fa70d2292b4e56d143ba]

CVE-2026-98154: nvme-rdma: fix -EIO cleanup order in queue_rq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98154

Introduced by commit 62eca39 ("nvme-rdma: handle nvme_rdma_post_send
failures better") in v5.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d61828199c6cb4b76d48403c77023cd4bb9d09fc]
stable/6.12: [a41e7fc8d244d9cfc6273051aed85b67adedbb89]
stable/6.18: [cf3e706963ffbd3ee2568fa0d08ab016f0575ea8]
stable/7.2: [171b993a4aed9889159df4815b6a6ba141e61975]

CVE-2026-98155: accel/qaic: Address potential out-of-bounds read in
resp_worker()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98155

Introduced by commit 2feec5a ("accel/qaic: Handle DBC deactivation if
the owner went away") in v7.0-rc7.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ab243f74ab4084ca5c8dec608cb5b0deb27db067]
stable/6.12: [f4b64488f3deca63f7fbc7d7c3835b2e668003f9]
stable/6.18: [12deeade460d47031267256ba07add51cc7eabd0]
stable/7.2: [c72e81ee46bdd4c221114d6e9515e9b4647616d7]

CVE-2026-98156: drm/virtio: use the DMA API for resource backing on Xen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98156

Introduced by commit a3b815f ("drm/virtio: add iommu support.") in v4.20-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a736d2f9d0c6e6217fe7532bc4c50ceca71db78]
stable/6.18: [93c557e947ef0040004b1ac6a1c1265d79a957e1]
stable/7.2: [455184dbe9652d01470d3c5cf5edd09a7a673a99]

CVE-2026-98157: EDAC/device_sysfs: Use kstrtouint() for poll_msec to
prevent truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98157

Introduced by commit e27e3da ("drivers/edac: add edac_device class")
in v2.6.23-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66cc9dec919dd63d8e4b3d386f7aed3ae684e645]
stable/6.12: [ea01c061d839b520f385f112908de1c6e3391327]
stable/6.18: [528052af901d6e6bbfa0e52362a70a58a5dd1e43]
stable/7.2: [0e022ee4f8e0dc843ba4c80bb75408a7704279af]

CVE-2026-98158: ppp_async: drop the errored frame instead of resetting
its headroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98158

Introduced by commit 6722e78 ("[PPP]: handle misaligned accesses") in
v2.6.20.16.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dc5d98a16fa23c00999aecf10018c9f69fa5bf4]
stable/6.12: [d0fc3dabfe67caf084e7119ceb2ee23f5ad2f2da]
stable/6.18: [0c53eb14975f029abd6b26896a460f0d2aaefe6b]
stable/7.2: [717137221c7d90e7c98bda9a370c9da6cbf015e5]

CVE-2026-98159: wifi: mt76: mt7921: validate CLC firmware records

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98159

Introduced by commit 23bdc5d ("wifi: mt76: mt7921: introduce Country
Location Control support") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9417c5818a0146980c2608fda94c908e604eb033]
stable/6.12: [602a950134ee2940136f60797e4457c3983b06ce]
stable/6.18: [3896be051e928c891922d91de94c99519d215dff]
stable/7.2: [3c505e2af16a9320f4355218394a955fbbc65322]

CVE-2026-98160: staging: rtl8723bs: fix mismatched free of HalData in
rtw_sdio_if1_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98160

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [264676418b726baca7be49171e306b6aa05cceb0]
stable/5.10: [ff6d1ba247b5c62bdb678f1069abc86ad88a1402]
stable/5.15: [d6158333d630a1b21d8914feaf77a6f5deb185d9]
stable/6.1: [6c017ab2b0e1b60b5be94636c94720347213d78b]
stable/6.12: [423574feaed192063ef0cd0813fb85425f39e539]
stable/6.18: [737c928ff5092d7e55128a232c231248fc993777]
stable/6.6: [4520d673d49dabfd42c008a33889251025f7d6d5]
stable/7.2: [911190f0b9511c3c81f2f2484414c1ae26f636b3]

CVE-2026-98161: nvdimm: pmem: keep PREFLUSH before data writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98161

According to the .vulnerable file, this bug was introduced by commit
c5d4355 in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c644a2f8fef5618fcf453c591177700fd07dd024]
stable/6.18: [770a90c2127220f0fc194ce909ad4f0842e141cb]
stable/7.2: [72561ca1ab96f0f0f32737a6171641e05a318538]

CVE-2026-98162: smb/server: fix tree connection leak in smb2_tree_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98162

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [39f2032096715daae5f6fd0f587ca7a474b019df]
stable/7.2: [a6c88e5e3a75f1e4a98ad4bc4037465ccd7925bc]

CVE-2026-98163: cgroup: Avoid iteration of dying tasks with zero refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98163

Introduced by commit 260fbcb ("cgroup: Move dying_tasks cleanup from
cgroup_task_release() to cgroup_task_free()") in v6.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [057dac23d329d5c5ed62352f2659a39fd46c6d4a]
stable/7.2: [828938118d6c2bb711301748c3e39e4bed6a62f5]

CVE-2026-98164: KVM: x86/mmu: Check write tracking in all address spaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98164

Introduced by commit 699023e ("KVM: x86: add SMM to the MMU role,
support SMRAM address space") in v4.2-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f38453cdb2e17566ccb7c0f3dabd5bd21caca26]
stable/6.1: [09aa68552d2542cc6c23edd1568ac265dc5d886f]
stable/6.12: [d8636c8f9f95d0fd1e2f6f1cad0d5757aa6f212a]
stable/6.18: [c0a9bd5fca0b5f2dea32b0fc31350e71e8648112]
stable/6.6: [429b6f43b4d8c98988fdca99e02dc156134e3d77]


* Updated CVEs

CVE-2026-72315: smb: client: fix busy dentry warning on unmount after DIO

stable/6.18 was fixed.

Fixed status
stable/6.18: [9fc87899276af941ecf3045798887db7deb85605]

CVE-2026-72463: xfrm: Fix dev use-after-free in xfrm async resumption

stable/6.18 was fixed.

Fixed status
stable/6.18: [1acd93259b6be269e26be5d71c224bccd1f8352f]

CVE-2026-74304: Bluetooth: hci_qca: fix NULL pointer dereference in
qca_setup() for non-serdev device

stable/6.18 was fixed.

Fixed status
stable/6.18: [74f179e75ab03bdc818a5e9709d8a8440c351463]

CVE-2024-44986: ipv6: fix possible UAF in ip6_finish_output2()

stable/5.10 was fixed.

Fixed status
stable/5.10: [1504108cb6020df7b1a31c9bb80fd587470aa448]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

