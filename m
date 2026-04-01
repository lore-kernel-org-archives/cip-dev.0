Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC3410FCAF2
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 22:37:47 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3930.1775083060934554542
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Apr 2026 15:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=gE+XoVrO;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79be0de8610so2484957b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 15:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083060; cv=none;
        d=google.com; s=arc-20240605;
        b=ffU5KjsDOEufl6Sf00HH9K2/Num4qOLwlkiUyYkUwmveJkMF4S/m7RYihXIvPUtNX2
         oNszPNJwu08mZ0eJqRtY/IzkKkVwTsjMPwyuZQdKuIg+R4UH7LVR57eHobx+n2jUgotR
         BqOLiXKdbYOqmsyfXSjVUSYbu5JqU0rb0y3tUuipfgQ4b5qZjObVmlFmPvrE9UDpB8Hi
         hAELJREUpSLyr20VBN0da3qEX0lsh8d7OAu0fEbidVEbU/0EBhrf45tNWN0q1rOpxKLF
         96kgRc56YoMnpKRTlosic+iQW9TY5LTf2/xRQlCJhx/Q1zGjrxkFUhX6afIuH27TNr+v
         GmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WGe7rGtCSqXl7OrzTH0qCMBWJ73gAEsN1n/lsP2QR7c=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=jP4mWqNTDjTGoglV5BpWbJ4J2F7VZEWelnqKf4A3aqBtGmWFgdIn4HAz3FxCqLBOwq
         kYmr3qaFsmAWCD7W2Rwb9PRN8SP6i+zSWbrm6gnV/ErEBIVyDCcZQ13PhDiYJh0pRNpF
         8o4TY0ZBEAg9o2EOdWGfdZeXTYA2jZc8IusY/ULlx7Qr9IKsbGuCTQeujQowyUg2yQSl
         IVCaZWLfo9zMHByMP+9IAcPPgnjZsOgNgs6JR58ppxdb7b/3/O9sRH3q+8pni4DAjEyy
         vPmAzAaTTisnEIVUHe5ogxPC9AXx5AfCD8C8UrtzoReHaqaPYOYOUoaHs5cG2aaHKYrZ
         2zgw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1775083060; x=1775687860; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGe7rGtCSqXl7OrzTH0qCMBWJ73gAEsN1n/lsP2QR7c=;
        b=gE+XoVrO9yGJtfHtfB5gDZ4hzM4MP017JrGac68yZs37adhWEQPbRJLFVSysRtiYBG
         OH3AQMr7Y7VmEP45SQHgqMJG+xlw/I1gq8aT2Iab4z5ombq050wGQCXs4NupRa3NJVh0
         x3DmUY4ktMINYxzQvQZl2jVgHjgt9zjk56QeL7y9WJRr+SLt3FaD/edmYyUn4kcLZT2B
         n4WX2QX3Kuv3x3tCAcVXEAS1lXo/FCtlJCR+7KCDC3kwmb4LnontKXAwcoGLYeDpJ/jQ
         AzLnpmGr3UFXryR1KXYSCo2KSYJCMNrwJUcGJ5J5Reloubqf7LKicx1Tq3mtcDYz1JoT
         wCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083060; x=1775687860;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGe7rGtCSqXl7OrzTH0qCMBWJ73gAEsN1n/lsP2QR7c=;
        b=pH8ixJg/Vxweb6jiaYBwoYJrbotFSZ+QG75Nq8IU9Jw32kg3C25hn3JkTDfqQ0KI9t
         U8FXRSwS4p5po5I2iF8ZXmfZE39f6iqBV4YAN5rIEJ19zI/U5ZRFWg97RJ3/4eHIu7f9
         qQaEFYERRuy0Tnw/qxs1rjKOFYam3JMhpdgt41L6aK4XcSmR2N8neZfmdkEBgQOuiTAa
         HoJqQfLZ4Tu853/zVseW7whzAG/BbHvOYPYJQ4vvtZOaL0ozHwdx7aE5XdBA7fW3UMyO
         wK2dhW/+DAr4u30GF/La027JkHFgPMdLd2x146nQwJskbFqIZHsNb3VpITwZvvG6gvtS
         JNSQ==
X-Gm-Message-State: AOJu0YyvEi8K5VpwheLnT4FtiPIJH5FIVPqlkLWK3j4+Vq/TVT45WeQ6
	pzxOHyeq3IWUOeR511izXqmWC38NfjFQzd0LoKljyyEW3F9iPU2EG31f8yns8347pmUGv9fxGuS
	ofagavqXN4+D5l5jeEWUIfdvjy1arubW25DLnV1VZmPkOQmhPHy4oDVK1aA==
X-Gm-Gg: AeBDiesievx94L7fWTcAy6ZC+eep0NY0i/9R0SaOWWAZ+6Viclt21YTl+rQLTuY+kC7
	JcQYced1xuVg09gi/4ZjbncT5GpcUaw2A2Qx5fk5612a6wOzuhgVXpUYL4rrq0+gzF9hydqxWyt
	rIqKOZTDgvtwG+c643Px0R3lW5Mhcr6H0quz8O7uM4O5P2ybNDwJ6j/6PhJvnuCgXSHLqLZymm3
	Z6UAUfriJIlwHCvuJm4c8Bu0reapPUVBOE7wTGtcqmMS3RTnnTDWldYi5CQjQ/IKS7v8zJdSTZZ
	O89jLHAC
X-Received: by 2002:a05:690c:e3cd:b0:79c:875c:c914 with SMTP id
 00721157ae682-7a211a412e4mr64074307b3.37.1775083059750; Wed, 01 Apr 2026
 15:37:39 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Apr 2026 07:37:03 +0900
X-Gm-Features: AQROBzA_7PrkeLfMiCvXVu0SB46yFyshLllj0DfYSoMGAmzvfE4a9XQRoQMNefE
Message-ID: <CAODzB9rN48YRbNMVxdAy2RCat_KCw04cMXmJO3C8+vMDPK=vdw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 22:37:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22614

Hi!

It's this week's CVE report.

This week reported 16 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23396

Introduced by commit 2e3c873 ("mac80211: support functions for mesh")
in v2.6.26-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c73bb9a2d33bf81f6eecaa0f474b6c6dbe9855bd]
stable/6.1: [c1e3f2416fb27c816ce96d747d3e784e31f4d95c]
stable/6.12: [a90279e7f7ea0b7e923a1c5ebee9a6b78b6d1004]
stable/6.18: [44699c6cdfce80a0f296b54ae9314461e3e41b3d]
stable/6.19: [7c55a3deaf7eaaafa2546f8de7fed19382a0a116]
stable/6.6: [0a4da176ae4b4e075a19c00d3e269cfd5e05a813]

CVE-2026-23397: nfnetlink_osf: validate individual option lengths in
fingerprints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23397

Introduced by commit 11eeef4 ("netfilter: passive OS fingerprint
xtables match") in v2.6.31-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbdfaae9609629a9569362e3b8f33d0a20fd783c]
stable/6.1: [aa0574182c46963c3cdb8cde46ec93aca21100d8]
stable/6.12: [ec8bf0571b142f29dc0b68ae2ac3952f7a464b38]
stable/6.18: [3932620c04c2938c93c0890c225960d3d34ba355]
stable/6.19: [4c6aa008b913e808c4f4d3cde36cb1d9bb5967c6]
stable/6.6: [224f4678812e1a7bc8341bcb666773a0aec5ea6f]

CVE-2026-23398: icmp: fix NULL pointer dereference in icmp_tag_validation()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23398

Introduced by commit 8ed1dc4 ("ipv4: introduce hardened
ip_no_pmtu_disc mode") in v3.14-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [614aefe56af8e13331e50220c936fc0689cf5675]
stable/6.1: [1f9f2c6d4b2a613b7756fc5679c5116ba2ca0161]
stable/6.12: [9647e99d2a617c355d2b378be0ff6d0e848fd579]
stable/6.18: [d938dd5a0ad780c891ea3bc94cae7405f11e618a]
stable/6.19: [1e4e2f5e48cec0cccaea9815fb9486c084ba41e2]
stable/6.6: [b61529c357f1ee4d64836eb142a542d2e7ad67ce]

CVE-2026-23399: nf_tables: nft_dynset: fix possible stateful
expression memleak in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23399

Introduced by commit 563125a ("netfilter: nftables: generalize set
extension to support for several expressions") in v5.11-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0548a13b5a145b16e4da0628b5936baf35f51b43]
stable/6.12: [d1354873cbe3b344899c4311ac05897fd83e3f21]
stable/6.18: [31641c682db73353e4647e40735c7f2a75ff58ef]
stable/6.19: [c88a9fd26cee365bec932196f76175772a941cca]

CVE-2026-23400: rust_binder: call set_notification_done() without proc lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23400

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e303f0febb65a434040774b793ba8356698802b]
stable/6.18: [dd109e3442817bc03ad1f3ffd541092f8c428141]
stable/6.19: [3be72099067d2cd4a0e089696f19780f75b2b88a]

CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even when
creating an MMIO SPTE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23401

Introduced by commit a54aa15 ("KVM: x86/mmu: Handle MMIO SPTEs
directly in mmu_set_spte()") in v5.13-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aad885e774966e97b675dfe928da164214a71605]

CVE-2026-23402: KVM: x86/mmu: Only WARN in direct MMUs when
overwriting shadow-present SPTE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23402

Introduced by commit 11d4517 ("KVM: x86/mmu: Warn if PFN changes on
shadow-present SPTE in shadow MMU") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df83746075778958954aa0460cca55f4b3fc9c02]

CVE-2026-23403: apparmor: fix memory leak in verify_header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23403

Introduced by commit dd51c84 ("apparmor: provide base for multiple
profiles to be replaced at once") in v3.12-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e38c55d9f834e5b848bfed0f5c586aaf45acb825]
stable/6.12: [786e2c2a87d9c505f33321d1fd23a176aa8ddeb1]
stable/6.18: [4f0889f2df1ab99224a5e1ac4e20437eea5fe38e]
stable/6.19: [42fd831abfc15d0643c14688f0522556b347e7e6]
stable/6.6: [663ce34786e759ebcbeb3060685c20bcc886d51a]

CVE-2026-23404: apparmor: replace recursive profile removal with
iterative approach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23404

Introduced by commit c88d4c7 ("AppArmor: core policy routines") in v2.6.36-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab09264660f9de5d05d1ef4e225aa447c63a8747]
stable/6.12: [999bd704b0b641527a5ed46f0d969deff8cfa68b]
stable/6.18: [7eade846e013cbe8d2dc4a484463aa19e6515c7f]
stable/6.19: [a6a941a1294ac5abe22053dc501d25aed96e48fe]
stable/6.6: [33959a491e9fd557abfa5fce5ae4637d400915d3]

CVE-2026-23405: apparmor: fix: limit the number of levels of policy namespaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23405

Introduced by commit c88d4c7 ("AppArmor: core policy routines") in v2.6.36-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [306039414932c80f8420695a24d4fe10c84ccfb2]
stable/6.12: [853ce31ca72097d23991a06876a2ccb5cb64b603]
stable/6.18: [d42b2b6bb77ca40ee34ab74ad79305840b5f315d]
stable/6.19: [7b6495ead2c611647f6b11441a852324e3eb8616]
stable/6.6: [3f8699b3ee0c04b4b9bc27b82cd89a40e81e1d2e]

CVE-2026-23406: apparmor: fix side-effect bug in match_char() macro usage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23406

Introduced by commit 074c1cd ("apparmor: dfa move character match into
a macro") in v4.17-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8756b68edae37ff546c02091989a4ceab3f20abd]
stable/6.12: [b73c1dff8a9d7eeaebabf8097a5b2de192f40913]
stable/6.18: [0510d1ba0976f97f521feb2b75b0572ea5df3ceb]
stable/6.19: [383b7270faf42564f133134c2fc3c24bbae52615]
stable/6.6: [5a184f7cbdeaad17e16dedf3c17d0cd622edfed8]

CVE-2026-23407: apparmor: fix missing bounds check on DEFAULT table in
verify_dfa()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23407

Introduced by commit 031dcc8 ("apparmor: dfa add support for state
differential encoding") in v4.17-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d352873bbefa7eb39995239d0b44ccdf8aaa79a4]
stable/6.12: [76b4d36c5122866452d34d8f79985e191f9c3831]
stable/6.18: [5a68e46dfe0c8c8ffc6f425ebc4cae6238566ecc]
stable/6.19: [f39e126e56c6ec1930fae51ad6bca3dae2a4c3ed]
stable/6.6: [7c7cf05e0606f554c467e3a4dc49e2e578a755b4]

CVE-2026-23408: apparmor: Fix double free of ns_name in aa_replace_profiles()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23408

Introduced by commit 145a0ef ("apparmor: fix blob compression when ns
is forced on a policy load in v5.5-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5df0c44e8f5f619d3beb871207aded7c78414502]
stable/6.12: [86feeccd6b93ed94bd6655f30de80f163f8d5a45]
stable/6.18: [7998ab3010d2317643f91828f1853d954ef31387]
stable/6.19: [18b5233e860c294a847ee07869d93c0b8673a54b]
stable/6.6: [55ef2af7490aaf72f8ffe11ec44c6bcb7eb2162a]

CVE-2026-23409: apparmor: fix differential encoding verification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23409

Introduced by commit 031dcc8 ("apparmor: dfa add support for state
differential encoding") in v4.17-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39440b137546a3aa383cfdabc605fb73811b6093]
stable/6.12: [34fc60b125ed1d4eb002c76b0664bf0619492167]
stable/6.18: [623a9d211bbbb031bb1cbdb38b23487648167f8a]
stable/6.19: [1ff4857fac56ac5a90ee63b24db05fa5e91a45aa]
stable/6.6: [f90e3ecd9e1ed69f1a370f866ceed1f104f3ab4a]

CVE-2026-23410: apparmor: fix race on rawdata dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23410

Introduced by commit 5d5182c ("apparmor: move to per loaddata files,
instead of replicating in profiles") in v4.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0b7091c4de45a7325c8780e6934a894f92ac86b]
stable/6.12: [f9761add6d100962a23996cb68f3d6abdd4d1815]
stable/6.18: [af782cc8871e3683ddd5a3cd2f7df526599863a9]
stable/6.19: [763e838adc3c7ec5a7df2990ce84cad951e42721]
stable/6.6: [6ef1f2926c41ab96952d9696d55a052f1b3a9418]

CVE-2026-23411: apparmor: fix race between freeing data and fs accessing it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23411

Introduced by commit c961ee5 ("apparmor: convert from securityfs to
apparmorfs for policy ns files") in v4.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e135b8aee5a06c52a4347a5a6d51223c6f36ba3]
stable/6.12: [eecce026399917f6efa532c56bc7a3e9dd6ee68b]
stable/6.18: [13bc2772414d68e94e273dea013181a986948ddf]
stable/6.19: [2a732ed26fbd048e7925d227af8cf9ea43fb5cc9]
stable/6.6: [ae10787d955fb255d381e0d5589451dd72c614b1]


* Updated CVEs

no updated CVEs.

Fixed status

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

