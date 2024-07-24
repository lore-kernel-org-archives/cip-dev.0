Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09912C3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 22:15:23 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.22898.1721859312117436325
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 15:15:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=gF+qLnME;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.41, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5af7ae388so157391eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1721859311; x=1722464111; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2exAnbohx4nMckhUbnJyEaiT4yl1ML7OnPn784JOOQ=;
        b=gF+qLnMEaOMVYF4lB3gEqMXxO1Lf6j32rjSdsN+mobwmmOYAEL9RObjMoU/1u183R0
         DLRmTt9Agy4QVQGwAuhiwx5R4/SJ+eKC9fpksGg8Ljy23JQc+6jS3MfvpkVo7dqamgAq
         lvpyth0Z3M88CrIPEvlXDRlub+20F8w3UFl95g6XPuc12If5YpHpHAEyHphVttdgefJL
         b0Nh9sqTWI0Q9X3X1lhOigaM1he/ZwbJTXmDZL6FpEXSPxSfkaZ5BUGVkRiATUUK5E9/
         e/lH7awMSPhsq0cyy5OUlyEIBNBOySeG3zP++mz9q03ysqRcc5ILpVc/BACiXKF5xE1g
         mHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859311; x=1722464111;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2exAnbohx4nMckhUbnJyEaiT4yl1ML7OnPn784JOOQ=;
        b=k3/lwtT9E4NQUvdX1fK1N78fEGnJjNJIMkeorJ2ZYcbZLQzhmv03yVqO1AB7bQTc2/
         R1rdmogv45bt4hiIj0WyzQFCbyKcMpgfiyeP8wZxM0Q4iHzmhCH/A2kJoktK6m50GnLe
         hqbeQoWT0Vz/DN+tdBAhpAVDF3xGoXE5D/EFry8gt5P7P9uC6DzIcV8mpKLBfm3VFYT0
         HrVRg1hYKxOw9z1uDgW9R1PuzIfK3NKSMtSLQ+UFVwGAEV7jMnoRs8yFBU9+Vnh0LIhO
         prWygPSqsacGvJ387DWl2aTVnx4fOHadAZXfpNqRK2U8yj/67xEWZqUSioJHcK6i6poT
         1OeA==
X-Gm-Message-State: AOJu0YwYuJhnbC6lIiKnH3t4lOGo5TDk4jzz3dE1I3VMayM3SUIMQiUI
	i+q53CqhkLWAcRX3vkDHJgKFGwfGlu8yyxkc9a1D8Ch+uc/TijKaQj/32Mb1pfKknkPJRfC8aCo
	Tjo4he6ZiDlLK5y82zjkLqZU4cRsNdFmWejJVzrLn1pn3+mQw1J4=
X-Google-Smtp-Source: AGHT+IEVVFQb59qZpm+sxFR9qqa5qomaFC7Rcp38fpkTPeXOIUwndOF7yaLWlvUOI7/hjii+phY5QhBq05qkhK8Nh0E=
X-Received: by 2002:a05:6871:ca26:b0:25e:b8ca:4b5 with SMTP id
 586e51a60fabf-2648e640ef4mr1589141fac.4.1721859310756; Wed, 24 Jul 2024
 15:15:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Jul 2024 07:14:34 +0900
Message-ID: <CAODzB9r0p=GCbAxnj6-YjQY=J2NerO_TgjqQ1hU2rNMz92rDeA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 22:15:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16615

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 6 updated CVEs.

* New CVEs

* New CVEs
CVE-2024-41011: drm/amdkfd: don't allow mapping the MMIO HDP page with
large pages

Announce: https://lore.kernel.org/linux-cve-announce/2024071807-CVE-2024-41011-616d@gregkh/

Introduced by commit d8e408a ("drm/amdkfd: Expose HDP registers to
user space") in v5.3-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7]
stable/6.1: [89fffbdf535ce659c1a26b51ad62070566e33b28]
stable/6.6: [4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724]

CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race
is detected

Announce: https://lore.kernel.org/linux-cve-announce/2024072314-CVE-2024-41012-a1cf@gregkh/

Introduced by commit c293621 ("[PATCH] stale POSIX lock handling") in v2.6.13.4.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cad1bc010416c6dd780643476bc59ed742436b9]

Fixed status

* Updated CVEs

CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

stable/4.19, stable/5.4 were fixed.

Fixed status
mainline: [bfca5fb4e97c46503ddfc582335917b0cc228264]
stable/4.19: [17866066b8ac1cc38fb449670bc15dc9fee4b40a]
stable/5.10: [dedf2a0eb9448ae73b270743e6ea9b108189df46]
stable/5.15: [194454afa6aa9d6ed74f0c57127bc8beb27c20df]
stable/5.4: [7d61d1da2ed1f682c41cae0c8d4719cdaccee5c5]
stable/6.1: [7749fd2dbef72a52b5c9ffdbf877691950ed4680]
stable/6.6: [cc2e7ebbeb1d0601f7f3c8d93b78fcc03a95e44a]

CVE-2024-36901: ipv6: prevent NULL dereference in ip6_output()

stable/5.10, stable/5.15 were fixed.

Fixed status
mainline: [4db783d68b9b39a411a96096c10828ff5dfada7a]
stable/5.10: [9df3b2474a627994433a87cbf325a562555b17de]
stable/5.15: [2272e2db38f2e85929278146d7c770f22f528579]
stable/6.1: [ea0cb87402f774b0e1214ffba0f57028b27cf155]
stable/6.6: [e31b25cc2066d3f2b6c38579253882008d4469b0]

CVE-2024-39487: bonding: Fix out-of-bounds read in
bond_option_arp_ip_targets_set()

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
mainline: [e271ff53807e8f2c628758290f0e499dbe51cb3d]
stable/4.19: [6a8a4fd082c439e19fede027e80c79bc4c84bb8e]
stable/5.10: [707c85ba3527ad6aa25552033576b0f1ff835d7b]
stable/5.15: [bfd14e5915c2669f292a31d028e75dcd82f1e7e9]
stable/5.4: [6b21346b399fd1336fe59233a17eb5ce73041ee1]
stable/6.1: [c8eb8ab9a44ff0e73492d0a12a643c449f641a9f]
stable/6.6: [b75e33eae8667084bd4a63e67657c6a5a0f8d1e8]
stable/6.9: [9f835e48bd4c75fdf6a9cff3f0b806a7abde78da]

CVE-2024-40947: ima: Avoid blocking in RCU read-side critical section

stable/5.10, stable/5.15 were fixed.

Fixed status
mainline: [9a95c5bfbf02a0a7f5983280fe284a0ff0836c34]
stable/5.10: [a6176a802c4bfb83bf7524591aa75f44a639a853]
stable/5.15: [a38e02265c681b51997a264aaf743095e2ee400a]
stable/6.1: [9c3906c3738562b1fedc6f1cfc81756a7cfefff0]
stable/6.6: [28d0ecc52f6c927d0e9ba70a4f2c1ea15453ee88]
stable/6.9: [58275455893066149e9f4df2223ab2fdbdc59f9c]

CVE-2024-41007: tcp: avoid too many retransmit packets

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1,
stable/6.6, stable/6.9 were fixed.

Fixed status
mainline: [97a9063518f198ec0adb2ecb89789de342bb8283]
stable/4.19: [7bb7670f92bfbd05fc41a8f9a8f358b7ffed65f4]
stable/5.10: [5d7e64d70a11d988553a08239c810a658e841982]
stable/5.15: [04317a2471c2f637b4c49cbd0e9c0d04a519f570]
stable/5.4: [d2346fca5bed130dc712f276ac63450201d52969]
stable/6.1: [e113cddefa27bbf5a79f72387b8fbd432a61a466]
stable/6.6: [dfcdd7f89e401d2c6616be90c76c2fac3fa98fde]
stable/6.9: [66cb64a1d2239cd0309f9b5038b05462570a5be1]

CVE-2024-41010: bpf: Fix too early release of tcx_entry

stable/6.6, stable/6.9 were fixed.

Fixed status
mainline: [1cb6f0bae50441f4b4b32a28315853b279c7404e]
stable/6.6: [230bb13650b0f186f540500fd5f5f7096a822a2a]
stable/6.9: [f61ecf1bd5b562ebfd7d430ccb31619857e80857]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

