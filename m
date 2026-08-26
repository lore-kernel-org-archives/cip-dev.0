Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15156C61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 22:35:57 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24453.1787783752565721974
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 15:35:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=XXfFev/v;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c8bde2dcso21113247b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787783751; cv=none;
        d=google.com; s=arc-20260327;
        b=mUbzk2C90l2mAsoitQrQhuOrQBKR4eAcYvxZFR+kHhCYsA54mE2QhzdXkMjo38LYqw
         saZ0Ou7YgYo9rgqCLtGJy6CtOuLNSODOlfj8eFImHgFdrwe1dpNn52Lm6d9nXKuQ5sph
         gP71thky8nxlYkD6Y3Z3CnZgbvN6JAnOO+Vn4kreGxszzWkbzRLNhMhofzMRXee9hAUm
         gBbjtYtE+yO5hM3SZwexICiW5q0ZKpi0Gly/PjEiyx9Gvsh4/UDuHcZS4a+0m9csHYg3
         cGih3OvKlDYKKdwxXqvcHCK+4CVcFRhpphUCEblr8XxVejHAfJle+cJQhF/qjMFNZSyp
         CEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cD2kOvIVqw5dIV3jmBu4MOY5YrawQbc01vzA2GQn1W8=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=K2icy9uNPx1zjB2j+iGKm89l2BW0aeRwe+SJFrdNGiRaPVMBq23/arBrfbM2m5FtNU
         kqaqu18KERkuLANnId0wyojKItnupZNlRXQzj4aPw/l10xqYpFu06vJMCvGBpSEaNjVj
         nnwK0hnuJUK8PAT0tEeeTxXYxmpy3lVrAs/OYtZDSBoMCo4Ekr/gzKASTY02NeOOmo1S
         DIuT5barvZ471HowlNhueOesmx/ERcRzM8Yon618ATvEhZM4/tKNlDDpM1DY2RAtp1SJ
         TX4tG2pRsD3FkU/IHzlo6ThVHc8tRRMfm/rgpIyDf/w6x2CPxcTCFVdZTV3uR7eLp086
         KLMg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1787783751; x=1788388551; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cD2kOvIVqw5dIV3jmBu4MOY5YrawQbc01vzA2GQn1W8=;
        b=XXfFev/vmpkA73SOzxKG/kQdaEWtK6lmbz+j5W1uTNjXArYYdK8+aYPEt6asRgXFMx
         o1g258MkZCEpx6n8ZRb3ckiUibqgn/b8HHlr6ASzuCG11oy6iYwy4mpUP/sRWSe3QJiK
         SI9VSp5JEGceMJkOolfBjgHcfz/BsfmLu5Wbb75VusF318AhX80M0bACU8YR4/WlazsD
         yaWBjTfBC8GOP0QNyDU7VGd/++Y0hbOWukNSSIw9HV8E/ttGivKl9SPm6Wmz6NfoU9n/
         9xXwZ+eh7pNWdAcRXHFG9t7sfktUlzyDUcd9xkHHSWmSDF/rugulW5YBnHOCt6J97G8D
         kJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787783751; x=1788388551;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cD2kOvIVqw5dIV3jmBu4MOY5YrawQbc01vzA2GQn1W8=;
        b=pVpgiQpsb/JrlxjijRJl0V6XLMbyV10k6mncMet8ZK6shd3occ3Jyg/16fJIGfG3XO
         1MexQrfEy06JDV/D3RRV7ACrjPw5CqshbifQHk1Xs1NuVfWRdhQPErnLcZ+zhp0PAjQC
         jSlICDTcvAGdz3+ek1swDkF0xwe34Z7rWtcuu0mBl3DyswtldYUayZckofcgp3ZZPZzn
         BV0QhQ+dBMq7Sl5iYTYGpSakmAuP0dwe1HGFIS0ulbvJ5qHZTGXZYNkMJcQnkS+qwLYO
         mkll3XX1UZspUjjcNJiY+cUJd7ahEzGTTLA/gZycYB4ctkSNTloi2bZWO6vUoCfQIE8o
         MTWQ==
X-Gm-Message-State: AFuF++kK13u1DaRfJ8/JQzVwc7kiJMH36A3xPAkqgyNM0ZMrkyArinhX
	+ra3Oad6qHyVZ1wF/YU6IPEZpuz5oHSnGAw59DJQxg8Gh7B01Mang96m3ngYi/euDkLa58I/5n6
	XlIC6QdJmlkduWVFo/MecNuXXQOZRn5+tWXXWxyGgZcDaMz8650FKIJFn1w==
X-Gm-Gg: AR+sD11tTZ0xwN/6iJhirN6llB1SCxcGfSqLsTBfK0IRD5LlVNkuDDzTxl/PKa085Uk
	qCqq32SAtRiAV6aDx9n6k0Wq9nnnJROLGjdYetpPL2HrM++ee8Z09LoX4qY0+n53aIuBpzO4g98
	WyTykvwj3xfti+awrVEZ7wW5UYySQ2wgX9NvcKvlAuBERtrC5qAGySnU+DgtxligFLrK518jpFm
	TnuAWTbw96PEl+Im1GBPMoozvvMi01XVzvzJd4WalMBeJ5CepbanwMan5zP0Bl7+t3jnclSXQ2u
	JEzbZBdoXVF162o3wW6hLDNhcLPXnI5ID2zDVJotbb0R3ROYrRiUFcEOfQ13HuV09ARxSCUbFrH
	A7Po4FR5uc/cunoau
X-Received: by 2002:a05:690c:6d82:b0:857:97ce:dfa5 with SMTP id
 00721157ae682-85797cee02fmr37748847b3.10.1787783747431; Wed, 26 Aug 2026
 15:35:47 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Aug 2026 07:35:11 +0900
X-Gm-Features: AcwNN1WqaODJeCkoPbRFVuJVDtq9ZHSlD965-kE9NPMTN4w1rC_P9OyTKXeAkUw
Message-ID: <CAODzB9rD1j80dtvRfGRO9LXaObbeC6KLTfeFYr4RKJa4K6X4yg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 22:35:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24031

Hi!

It's this week's CVE report.

This week reported 246 new CVEs and 125 updated CVEs.

* New CVEs
CVE-2026-74580: vhost: reset the vring metadata cache on vring reconfiguration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74580

Introduced by commit f889491 ("vhost: introduce O(1) vq metadata
cache") in v4.11-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de845981da67a6b049080c87e605130b0c30adc5]
stable/5.10: [5224bd37e37d36076a550d99b2aebba33939fd95]
stable/5.15: [54617e9119be2eb728ecdd8d977b99c99d4c498a]
stable/6.1: [13fa6f32a56a386a82bd7451644c494beed034af]
stable/6.12: [6fa3e9b1fe856259555a7e22f3f3082e7827fd9b]
stable/6.18: [f1e21108e3ddfcce62f6cad4ebd7b5674543c9e6]
stable/6.6: [cf363a7a02ce132ef1f58084fdb13e1a3b7da7e7]
stable/7.1: [b70ebe0bba254e093dd5fd4c0c170941ce83eb85]

CVE-2026-74581: net: ipv6: clear suppressed fib6 rule result

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74581

Introduced by commit cdef485 ("ipv6: fix memory leak in
fib6_rule_suppress") in v5.16-rc4.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [6aea62e433fe1b586202a5fee8b5807ce635e1d7]
stable/5.10: [90c57310e266eb94e4a80d6b15a9ca131d2e82cb]
stable/5.15: [5d29b286c9de0b309e94b9ed083aa1a2f429434f]
stable/6.1: [354db6243eca59e9d187ffbf8b7955b044ce84dc]
stable/6.12: [9bad152c42b37499162367fe47867411e62fffa3]
stable/6.18: [dc3ab04220667f254f4348572b2a0b3febff89fb]
stable/6.6: [6d98c70fe0ba8c7708bfd5b2a5174d2086775daa]
stable/7.1: [a341c091ca0bfae377747b1b59a3bd8ebe18a937]

CVE-2026-74582: packet: use consistent hard_header_len in non-ring send paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74582

Introduced by commit b84bbaf ("packet: in packet_snd start writing at
link layer allocation") in v4.17-rc7.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [03390aa32e669cc4ecd7d34108e2e1afc13d689d]
stable/6.12: [9052756290962ffb9a661bcf319e92dedaaedfed]
stable/6.18: [5bb10753d428aadfc356a2bfe9acea09c82a62ec]
stable/6.6: [91f041451f967cd87ed722a8f43c0b767a64f1a0]
stable/7.1: [b06b6fce6d7deaf7238e09b48ce3b1125ff41acd]

CVE-2026-74583: net/sched: cls_route: fix fastmap use-after-free on filter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74583

Introduced by commit 1109c00 ("net: sched: RCU cls_route") in v3.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47d7f7051253bdc02b1d245d87e38f16d31a74df]
stable/5.10: [7897198b26445b4009a057bda1986b94a99e5d5f]
stable/5.15: [820f083c294ad6d319c02a7d43294f2ed2565139]
stable/6.1: [5ec9001be6d0eb527251125632ec8fe88278897f]
stable/6.12: [a17f636c9330eac879822ce29f998e5abd1b72c1]
stable/6.18: [0e7a8cf8895b06d07c7311f028eba16ad742b9bc]
stable/6.6: [b969984b2bdc85d721ce4047cd270cd37ec705a2]
stable/7.1: [ae9aff87025219005a2d16b4fe83d6f24643e50d]

CVE-2026-74584: RDMA/bnxt_re: zero shared page before exposing to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74584

Introduced by commit 1ac5a40 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
in v4.11-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [939d36e381d41a8c3042e82f8446f86553f42966]
mainline: [f6b079629becfa977f9c51fe53ad2e6dcc55ef44]
stable/5.10: [53c97e9882f4e747b4ac31b211317c2eba541af9]
stable/5.15: [9896bdfd21d918e9f26a52bc6109cc77970ee0b1]
stable/6.1: [9128c2411b83a64c0a69d2ff059c741bde25a9cc]
stable/6.12: [a3ed2daab02b2a706e882ad31b5c3c4f33cb5bb1]
stable/6.18: [e2b143df29003d2704b51f62e9297006953dbacb]
stable/6.6: [c19b360fa10c521c0b681875cdaa51545d45a491]

CVE-2026-74585: thunderbolt: Bound the DROM dual link port number
before indexing sw->ports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74585

Introduced by commit cd22e73 ("thunderbolt: Read port configuration
from eeprom.") in v3.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6764992f17b23d91ff93ce905ab53c2aa7191f0]
stable/5.10: [6c892ed9f4129ae40ef0f92e1bb31aa0b0ddc72c]
stable/5.15: [3d3c212b70633332ab71672aa2bc6af257d2ec83]
stable/6.1: [b98e1e28bd95b0fa33164eec1e763d26c7058b39]
stable/6.12: [f28066057134aa9294caa597b670daf505ad9dce]
stable/6.18: [40d2ffb74094cf36edbe05855566a4c58b6ce808]
stable/6.6: [50f0c8dd8c3390f851cfb97ca13116f9ee6469d1]
stable/7.1: [f32c3a9a77cfb50934a60b05d5407649af062535]

CVE-2026-74586: sctp: clear new_transport when removing a peer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74586

Introduced by commit 6af29cc ("sctp: Bundle HEAERTBEAT into
ASCONF_ACK") in v3.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beb33f8ee1ca83acddb2a5ae80f3d22ec550b4c3]
stable/5.10: [c0f973bb5118dd1b146cda3fcc8af6f6057befec]
stable/5.15: [3b539b317cd052236fed0350364ff1268996ba46]
stable/6.1: [db9d8e3b670f841755bc2018f178472dc6064d27]
stable/6.12: [291accf36febce751021888de5f15090f4875b56]
stable/6.18: [ca33df36aa0143a1d04f57d2086020c12e7eddb7]
stable/6.6: [31efa656cf6aface26e88f038c14f22ee6ca1500]
stable/7.1: [163847552a571bd55094291f4ffcdc1de0f14a7b]

CVE-2026-74587: sctp: fix use-after-free of cached ASCONF chunk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74587

Introduced by commit a000c01 ("sctp: stop pending timers and purge
queues when peer restart asoc") in v3.0-rc2.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c283e7b56adce00193837f3311b06662466fb21]
stable/5.10: [10459b03e2d9ee12435e96f587de4d4cacdbf435]
stable/5.15: [e1bb114e09372fd6e03387ced9ef566da336ed6c]
stable/6.1: [179676f0166230c80053a392303485b37c93dd33]
stable/6.12: [618b5c6d049896fcfabb91afc072954c92cb2693]
stable/6.18: [07daf4f9750104960a1d60831b2353c0d41f35fb]
stable/6.6: [dc67d528c2fa939cec7fe3bf7f3089c8d281ca3d]
stable/7.1: [d949992bc3f00027a2c755e860a11950c75f6073]

CVE-2026-74588: sctp: keep chunk->transport in step with the list it
is queued on

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74588

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f2cf069a9a72a2d6b97ca8b4c70e714aac99749]
stable/5.10: [6575fb17230814b48b471727c8410c0aadff9274]
stable/5.15: [6b9e2ea2057113f3393990ba646d2d97c719a80d]
stable/6.1: [874a7c2b5e184f06134fdfde27e9ce9271bafe58]
stable/6.12: [e2e7c1de0e226ca1b7fea2de57a6c9bca408709b]
stable/6.18: [2b3b5eec8b2c30ee237e3c31a6a38de9c39d804d]
stable/6.6: [1adf929121e13e0b19200bb9fef715b918d483fe]
stable/7.1: [5ccf35ef0ed6059cdf8b1f4606a6584d5b67166b]

CVE-2026-74589: bpf, sockmap: Fix sk_redir use-after-free in send verdict

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74589

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a76624733730e541e4955fdecf506af2f6b20558]
stable/5.10: [41b7da0cb72ca5aa1e62b68dab323d0791fc6bdf]
stable/5.15: [9b4fbc371a6ecf1b4e43b5a629015cc0830d8de3]
stable/6.1: [90a19b0894ba79a699b48cf44421b36fbd566e99]
stable/6.12: [4c9d9aa809c261dc0490a0e19d675f7e8e4c85bf]
stable/6.18: [a14e4ef1d90c3418f01b3b6b8fd3a40a0a208a10]
stable/6.6: [d192cff2a37d59206dabe6ec2e60ceac6271f274]
stable/7.1: [1cec526cf0a2227395f2c2f4b671cb052ff0b00e]

CVE-2026-74590: fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74590

Introduced by commit 67814c0 ("bpf, fsverity: Add kfunc
bpf_get_fsverity_digest") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e8ec7c0387273329374f5c7bd61f5f38af71fe1]
stable/6.12: [1344b632cb5043e32939a84568125719111c5af3]
stable/6.18: [2a5cfcad1d56e26d645b7887b0ed24c371851525]
stable/7.1: [5bd63cad9df4328a184c409fbdad4f17944bcdb8]

CVE-2026-74591: mm/filemap: __filemap_add_folio() restore index before retrying

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74591

Introduced by commit 200a89c ("mm/filemap: use xas_try_split() in
__filemap_add_folio()") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86da3f7e1e609e1e8bfbab198af68467c5a015a5]
stable/6.18: [4917e3ebcab50f0265e8ca01c8567de4c4a47511]
stable/7.1: [267ecd2eb7759c26f1a026eb0a5b231071534c9c]

CVE-2026-74592: ima: Instantiate file_truncate and path_truncate hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74592

According to the .vulnerable file, this bug was introduced by commit
3323eec in v2.6.30-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b80bed5c871a80151351342c065579405ce77145]
stable/6.12: [5f46705d96eb60587aa7035acfcbec977e08d620]
stable/6.18: [dd21c96a71e876c8df9ec546b885a2c5f47bbb05]
stable/7.1: [0baed1fa2184c81e4baf76f445d3faa4b738c8f7]

CVE-2026-74593: sched_ext: Take cgroup_lock() first in scx_cgroup_lock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74593

Introduced by commit a5bd6ba ("sched_ext: Use cgroup_lock/unlock() to
synchronize against cgroup operations") in v6.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f8b69642d18e1f3e11996707842ac530444e959]
stable/6.18: [2ca6b43edf83f8fc368cc3094ee5f3b1e8e0b0f0]
stable/7.1: [a054c9ffa9b7a0dffb763837b91ac9d381ec6d10]

CVE-2026-74594: sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74594

Introduced by commit 8f91efd ("psi: Fix race between
psi_trigger_create/destroy") in v5.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5457025fa8ca3c0d2732109513de839e3e797190]
stable/5.10: [4addb102154b7cf6e2310ccbe20c3c08619e520d]
stable/5.15: [894a9300d7fb2e2951da92e565ae6de7ddfb0a69]
stable/6.1: [1e5ca82eee59caca6988f9d6e859786aab8a5fa0]
stable/6.12: [806fcff98c1d7cb3c1dc0015e55ebdbe819e6b08]
stable/6.18: [8037c5b2b2a447df52542f4d8535895d837bdcbd]
stable/6.6: [310b5a537a78c358a4cd244bd767c1a517a05459]
stable/7.1: [611e7821c4f83a671455658797336faecc3a5196]

CVE-2026-74595: fscrypt: use the mount idmap for the owner check in
fscrypt_ioctl_set_policy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74595

Introduced by commit 14f3db5 ("ext4: support idmapped mounts") in v5.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf6c993c0feca7984797e634deba3c80342e199a]
stable/5.15: [174633a468817a49bd474bcfc9067c84e54efe68]
stable/6.1: [0baeb730044981f5ec5fb7d62a3763835ea606f6]
stable/6.12: [6a67c460b12315033268dce597546984fe5739e7]
stable/6.18: [653e888a24c87b8bbeab44d7e558a1c1a3641088]
stable/6.6: [33b7e810ce09955aa02f3b632455cf5e7ac990a9]
stable/7.1: [98516ba8b817f34e86bdd7a5b7a383cff75c3ddf]

CVE-2026-74596: fs,fsverity: remove check for fsverity being enabled
in setattr_prepare()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74596

Introduced by commit e973465 ("fs,fsverity: reject size changes on
fsverity files in setattr_prepare") in v7.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2f96bcb89d36d488a10e3bcf819b98536968286]
stable/7.1: [2d2b2ed7bdcc6df4942292318c5455b5e94ba525]

CVE-2026-74597: ip6_tunnel: clear skb2->cb[] in ip6ip6_err()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74597

Introduced by commit e490d1d ("[IPV6] IP6TUNNEL: Split out generic
routine in ip6ip6_err().") in v2.6.22-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f803c086399da277b5d0ff36a107d0f162751800]
stable/5.10: [44fe898df302e91c5ee5acbc71ffa74e78e6c183]
stable/5.15: [0dadb0620ab65949a8bc2439dd28ea3c942fe87d]
stable/6.1: [b6816536a2990c0db44a26130a03e40b441e829b]
stable/6.12: [484134e1eb07d700a73b1e4bbf3fb503e299be60]
stable/6.18: [4eb15c465337b18f44716c499cd6ad63eee0ad54]
stable/6.6: [64e41736a26f37ab6215bc2e6df125df05aceb08]
stable/7.1: [fbf40faa0414b753212494ad197542002e66ed9e]

CVE-2026-74598: ipv6: fix Route Information option length validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74598

Introduced by commit 70ceb4f ("[IPV6]: ROUTE: Add experimental support
for Route Information Option in RA (RFC4191).") in v2.6.20.16.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1ad8fb2ac6a1afb71dc22d9ae8efb4dda96c824]
stable/5.10: [2f6f94eda12430fb41b24b44a71e2ea4e93561d7]
stable/5.15: [7eac87396c44a312be457ef41d4c5687883be9a2]
stable/6.1: [7309529f257ae18e72112ef9f614edfd6df229bb]
stable/6.12: [ff3cb05289b8a4ef95fa7ea14c7d34818359edbb]
stable/6.18: [3b2231e358d26e3aec5d8040b1fb777af03c5f05]
stable/6.6: [0b9e02f3bd31c888f2ccdc0ca08e546d6abe9c4d]
stable/7.1: [da64ed1f346ba84df574d6469fa2e422b2511719]

CVE-2026-74599: mm/ptdump: always stabilise against page table freeing
using init_mm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74599

Introduced by commit b6bdb75 ("mm/vmalloc: add interfaces to free
unmapped page table") in v4.16-rc7.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [27c32e5538344b13c1505a08861e04620c125d47]
stable/5.10: [3c0391b9a774cc0854f3152e484a9d4835b12b40]
stable/5.15: [cbd9583bb6f70733d0022a66d3546a15c76ae744]
stable/6.12: [b9c6d048bdfaae78d7d921b454f7de7baefaa2f0]
stable/6.18: [7f740664aec1f832953c2e6d9b8920cd6c8bcc0c]
stable/6.6: [76df4edf7d61ecb711bc517ff4c20a5e85c4e9f7]
stable/7.1: [4adc4c9a9a43d61fe476dfe10811f3df2e7e4106]

CVE-2026-74600: mm/page_table_check: skip special zero mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74600

Introduced by commit df4e817 ("mm: page table check") in v5.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8db4bab826ccc9ec10fa41736a48031cd338d392]
stable/6.18: [7755be923e325dc300f4b0c3e1ad7e91b28b3cb9]
stable/7.1: [b726eb3c94d23e09da0e0f46b0fa09fb2b5d99cc]

CVE-2026-74601: ring-buffer: Use current_context for safe per-CPU buffer swap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74601

Introduced by commit 4239c38 ("ring-buffer: Process commits whenever
moving to a new page.") in v4.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f27bdc43077e4fcb5557dfc315ee8d91e741f483]
stable/5.10: [26662bc8fced1d668fa1aa146eda085bfc67bd0b]
stable/5.15: [6b524e6b234e45c7f5f90d13b042c6f57f80105c]
stable/6.1: [597f279b7b4a06412e3d965e98cc36e181cdbede]
stable/6.12: [ad7e10c7ea89af45ac1bf1814855d45da472703d]
stable/6.18: [5b926fb04cb9ef3156dcf88c69a59d3d1a1c4f9f]
stable/6.6: [22709117d9ae95e52673685f98caac7c356a8227]
stable/7.1: [5e6e2a18c20e88167d414f666032792e8bf19b80]

CVE-2026-74602: ring-buffer: Initialise reader page order in
rb_allocate_cpu_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74602

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d014e44b68ddd43f71288d2a4dbb1a259869149]
stable/6.12: [7c620d89bae1a926ab7d626600285d3516c9f3c4]
stable/6.18: [2e37f2bf111429fbfa4d985b12df3ba496ca70aa]
stable/7.1: [3b3e0a6ee5bb3ac000f135beef26b2b7ed1a771a]

CVE-2026-74603: ptp: ocp: Fix board ID over-read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74603

Introduced by commit 0cfcdd1 ("ptp: ocp: add nvmem interface for
accessing eeprom") in v5.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b69f2ef10cdb018c0b127a7cab88e590bbddba4]
stable/6.1: [72ef3ce80078199bfad32f98d055f44ba7cd0c3d]
stable/6.12: [f92558bbe78d6284fedd053900f82a70f0aa8707]
stable/6.18: [5fd91dd4a143479b0575fb1f202ec1c501e71fd5]
stable/6.6: [3d965811be78473654e6e8cc8e4fb7b6b87aa6c1]
stable/7.1: [f8d7e5751267637190eff887c971d5b468106213]

CVE-2026-74604: Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74604

According to the .vulnerable file, this bug was introduced by commit
030a48b in v5.11-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff8da20b6f47c48d46e47f93f7a59e2d56ee9107]
stable/5.15: [2434f4765da8ccd7ef31be88b86f1bfa2e95be11]
stable/6.1: [b4c01ae6dd56d9dfd96bd1b29c28afa8fa06b366]
stable/6.12: [6a48ee9a5bda0f8ee501f9bef159fb9f39ff519a]
stable/6.18: [8d34019d1413629a434a7e8d9f91c76d256196a0]
stable/6.6: [999e573212d5f1debf073c68be35e55bbfad12fc]
stable/7.1: [6b446d335ba16e93a266dd77adf1ba51abc82df4]

CVE-2026-74605: eventfs: Use children field for rcu head and add memory barriers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74605

Introduced by commit 704f960 ("eventfs: Read ei->entries before
ei->children in eventfs_iterate()") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [f0ece16ffca7384787b692431961ce202907acf5]
stable/7.1: [004f7232e49730448f91665e76bdd7dff8e0c638]

CVE-2026-74606: eventfs: Fix use-after-free in eventfs_remove_rec()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74606

Introduced by commit 43aa6f9 ("eventfs: Get rid of dentry pointers
without refcounts") in v6.8-rc3.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [fd73b691702170d37d66f4b0278530cea8ed419a]
stable/6.12: [f161d7861a0bfdf10af6b738b3b57636204661fb]
stable/6.18: [5635211b44969f4816e29ec4d5f8665fb39535d0]
stable/6.6: [b77581b25e213e83b79ce11eb30024e55ceeb3e9]
stable/7.1: [74bb1eaf72d185a78c879eb2678ea500f82f46a8]

CVE-2026-74607: KVM: SVM: Serialize accesses to the owner and mirror
list with separate lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74607

Introduced by commit b212551 ("KVM: SEV: Allow SEV intra-host
migration of VM with mirrors") in v5.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d78d33275ef2a16c6d080910b291d0a97a0e613]
stable/6.1: [7943ec3a6d0e7e0a2eb4943300bce089ac3e8c3e]
stable/6.12: [328ab4fabe05af004d886659f8744076e320ddce]
stable/6.18: [47976eaaf0a4eb46dade48b3246779090db9e3ec]
stable/6.6: [28afde1edbd8b20058cbf4d75fb57876471ec334]
stable/7.1: [d728baba0f20e49439fc7831bf3e4e7dee82161a]

CVE-2026-74608: smb: client: Fix use-after-free in cifs_try_adding_channels()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74608

Introduced by commit 6aac002 ("cifs: failure to add channel on iface
should bump up weight") in v6.8-rc3.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [4986410316b1ae0e63c6ce418e4eb196723626e7]
stable/6.1: [64d7584e62ac8cdc750455c5fdc6008fc2de4f06]
stable/6.12: [47dfac48bce7198ad4f1a388fc8c9491f878ac3b]
stable/6.18: [1ffacbadc14530e55b8d86f7b917524f6a0fb891]
stable/6.6: [c292d4686f717c03e5022fc4ae7c782f39a94915]
stable/7.1: [1305eadc6a7d78a8d0a52eee29ddd2d9e8a27805]

CVE-2026-74609: tipc: read le->link under the node lock in tipc_node_link_down()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74609

Introduced by commit 73f646c ("tipc: delay ESTABLISH state event when
link is established") in v4.4-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cba9ccb47e9fa4cc77692fb896cc5ab57a667882]
stable/5.10: [2be741ad565c610871a6a95062c12c39da7168fd]
stable/5.15: [69d209461c110388710e483a130caf051e4fd09a]
stable/6.1: [de017c22135f545ca4e65d1eada22887b64958eb]
stable/6.12: [a714d62513befef37f71f4ae89bb1fe173b65f2e]
stable/6.18: [c3f2347a47754eac690967cfd82cb6d559817b07]
stable/6.6: [47ba70891b10b2feb52462086b7fcd2ad75d3ce3]
stable/7.1: [5558a8312452ddb21eff22b1cbd84302ad951944]

CVE-2026-74610: tls: don't leave a full plaintext sk_msg ring unpushed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74610

Introduced by commit fe1e81d ("tls/sw: Support MSG_SPLICE_PAGES") in v6.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bca91d63341274e857f4aeaad54d229405e93dc]
stable/6.12: [f634289a0b557a197c5f37284b623cefedfe73d5]
stable/6.18: [3fc5044796dd87b8d68be4207046f5ce2748174c]
stable/6.6: [aa8b14647721b5a4958712b35cf43e3125d47753]
stable/7.1: [3c5f8f2aa57c647b83add4896aab64aac5fdedad]

CVE-2026-74611: tls: rx: restore msg_iter before TLS 1.3 optimistic retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74611

Introduced by commit ce61327 ("tls: rx: support optimistic decrypt to
user buffer with TLS 1.3") in v6.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c8629651cb54f7b51db8fc0b1a9944e4a4b0f5e]
stable/6.18: [68787940274ec89f41dc91b1a68ee1a16a90735f]
stable/7.1: [3c837266a734e2a22b24d2d567404a501d405835]

CVE-2026-74612: veth: fix skb length accounting after XDP frag adjustment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74612

Introduced by commit 718a18a ("veth: Rework veth_xdp_rcv_skb in order
to accept non-linear skb") in v5.18-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb6379feaaff11c4e1e79c26c745ffa23182768a]
stable/6.1: [0c3024afabb8064b141f3cedcb1ddd6ab05ad9d5]
stable/6.12: [41b96667d42b74bb4b137f1bb78b611a953c5943]
stable/6.18: [cdf745b7a777f87f51666e5d8f4c6fc279bcf54d]
stable/6.6: [2f2a7f3f8b9f1bffc9b0488aa02b6951b2aec139]
stable/7.1: [3205b0652a37255dbb7ca8f3d942c8d8aa677c21]

CVE-2026-74613: vsock/virtio: avoid refilling the RX queue after teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74613

Introduced by commit b917507 ("vsock/virtio: stop workers during the
.remove()") in v5.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a31e0ad444698d8aa7534a0f89fda543730f97a5]
stable/5.10: [a7658508f5fe8f1077a65e8cb9535d3426f37a2f]
stable/5.15: [1aa21e7c8702a7c37cd7d3cace1a652cfa5e8171]
stable/6.1: [4d37e3525cc346a1421c1bdeaad5848e249fc60c]
stable/6.12: [a309b74e3fc052352ab778500449cb9c3853c363]
stable/6.18: [38c7763fdc533edb34dc8f4489c260e8ba2ccae9]
stable/6.6: [9d80a04129a6c27a690cb69de3fe3f50be5aa8b9]
stable/7.1: [e82a5faea2e3886dfb2a65ce092a132e7e896915]

CVE-2026-74614: vsock/virtio: read virtqueues under worker locks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74614

Introduced by commit bd50c5d ("vsock/virtio: add support for device
suspend/resume") in v5.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ebac8f6b1ef0e9278afe204b8692a7479988dace]
stable/5.15: [941329ce14c5f481223a10d1d4c8b57ea7f3048a]
stable/6.1: [29dd10583bf9d2744cd84b862e4257c0a5699570]
stable/6.12: [eae099c764c7ebdb842eb1f638913e310bdd6513]
stable/6.18: [bd43a7ec668be428265b3209eb43647aedcf720a]
stable/6.6: [a1fb0c5b8a7c2753758aeced40971f99449dde0c]
stable/7.1: [1cecb4202afdbeddcf29d59baf596ac6ab753f7f]

CVE-2026-74615: vxlan: do not arm the ageing timer on a device that is down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74615

Introduced by commit 40051c4 ("vxlan: Allow changing ageing time") in v5.0-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b37971686ec59fb027fa4910ba16805e68fddb97]
stable/5.10: [be44d79d14d7f9ae7c8ffb7272142005341b5123]
stable/5.15: [26c179d47403d2f919ee914cc02c31d896b59fee]
stable/6.1: [9dc561f0522c35bdd66e0646a748814a138ec4ca]
stable/6.12: [6b095e99b9e67ea31f0c4b00260e010898253519]
stable/6.18: [46bb297ad77680e009244f067f27d51cf5b8c7cf]
stable/6.6: [619dd29045e439d0b0f8c6d4fec1af447a050680]
stable/7.1: [6b4119af544996a545cf84b16f1dbce829ba0de8]

CVE-2026-74616: xdp: reject clones that overrun skb_shared_info tailroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74616

Introduced by commit e624d4e ("xdp: Extend xdp_redirect_map with
broadcast support") in v5.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e48e8edbef2eb824201495daa5234560f632b23c]
stable/5.15: [58408982fa39f9758124cec169f42854d6f98f35]
stable/6.1: [685edea27ac68d08fe4dbd3de74b858d2ad8e830]
stable/6.12: [ef4b7c7046d29a67090de15af0da0d1ae8d1b192]
stable/6.18: [fab820f1691a9e26d9031f18aae1e9ce09078f92]
stable/6.6: [ba13763d667e008e185fedf592d53846a5b457d1]
stable/7.1: [f463b6f4957c9c3fd1c75f8d3e5af4879fa609c0]

CVE-2026-74617: dibs: initialise dibs->lock in dibs_dev_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74617

Introduced by commit cc21191 ("dibs: Move data path to dibs layer") in
v6.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c27e360545373b7aee9862a5beef3b9fb3df0c25]
stable/6.18: [fe79571f40434b257d68cbfb7b3ae93a794d8a11]
stable/7.1: [2926031acba100d0c18fcfaa7a2ed29609318848]

CVE-2026-74618: binfmt_misc: don't warn when the mount is completed
from another user namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74618

Introduced by commit 21ca59b ("binfmt_misc: enable sandboxed mounts")
in v6.7-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79fdf39f1a31f88cb3833b6f8091fbf6acdca2c6]
stable/6.12: [37cf5cf1320a84a17225a1690547b8a0812ca94e]
stable/6.18: [24e95a24f151ce40d5fc1b3a6cefbcda8ded736c]
stable/7.1: [047f927f54c6c17593e93aafe82dcb7acdda2a71]

CVE-2026-74619: ovl: don't warn when the mount is completed from
another user namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74619

Introduced by commit 1784fbc ("ovl: port to new mount api") in v6.5-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63981fc786daaa626cb14d9be1406f674d79f98f]
stable/6.12: [494346f2aab2489d379d43ff614aea447cf4e94d]
stable/6.18: [be161fa31e3e9cc828a3c1bd935edca461e8a7a1]
stable/6.6: [513478092966dc9818d96dd2b3ed613fd2f6e30e]
stable/7.1: [42d99fcd8006007e2f708bede6789f37f3910b30]

CVE-2026-74620: net/sched: act_gact, act_police: range check the
fallback control action

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74620

Introduced by commit 720f22f ("net: sched: refactor reinsert action")
in v5.3-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [883b56ae58fe657d8497806c7059646e9ba6dbd0]
stable/5.10: [5f038affdacaffedf6a85a06cf59ec0a852d36a7]
stable/5.15: [efa58aeb6a99028b1fbc3ab2f31ba3a881211ad4]
stable/6.1: [725efc2ab4a40affc4e285a2dc4896d103948a6c]
stable/6.12: [5344e01179baa37547ab29fd7b8614f83faa190c]
stable/6.18: [92f00f1d4d204a428b38e26fce3baee144b6955d]
stable/6.6: [6bcb8839aa2d686964a4154650afc4db91e1c514]
stable/7.1: [2e8df8c9190335475a3b64a159d3efd8cdd1cb73]

CVE-2026-74621: net/sched: act_ct: fix sk_buff leak when the header
checks reject a packet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74621

Introduced by commit 3f14b37 ("net/sched: act_ct: fix skb leak and
crash on ooo frags") in v6.8-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [8a7ed561671aa6a911a2de99e59ef670a4d0b1df]
stable/5.15: [b5dbecc2016e1692fd1c2532af9c41ba729cb747]
stable/6.1: [23e97d594ddd0153020c506d5041048fbde1beb4]
stable/6.12: [47d99828591d0fe8be4b9c8992ff3b8e47968db9]
stable/6.18: [b47bb899e04b5407c5a63fe88d4b6676586a6e84]
stable/6.6: [737873a59905a54ca0d2d127ef882f3f88bf4379]
stable/7.1: [439d3e404f9d5e515911cc8132cde198b337c19e]

CVE-2026-74622: net: atlantic: free RX pages of consumed but not
refilled buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74622

Introduced by commit 46f4c29 ("net: aquantia: optimize rx performance
by page reuse strategy") in v5.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8e7471ef686b6c002218fee9671cc61992ae01a]
stable/5.10: [1e58b0bab40dcbdfc04acaba6a221d40801c3770]
stable/5.15: [30c473ea097ef0c93b064281b3e295c97d17e28b]
stable/6.1: [17c99dd86f169c7a3e73d6778e79ef5b1ed3ceac]
stable/6.12: [64e1346bc66b947eb80b848e4c8d9828ba50e0fe]
stable/6.18: [782cc40b7ade4614a8aec0b948b8cf95c69f8d4b]
stable/6.6: [ff451bc4290b79c04f1c5cfa928d448f9d47ecf5]
stable/7.1: [24d87dc28ddd3771dd0e88719209811809729439]

CVE-2026-74623: net: atlantic: free stranded TX buffers on ring deinit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74623

Introduced by commit eb36bed ("net: aquantia: remove function
aq_ring_tx_deinit") in v4.11-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [452636ea5410a96e02ebaaf80b21e3620b98e0dd]
stable/5.10: [a14ceebd13bf857bfca052bc5a6bd49e737912be]
stable/5.15: [4f1c20873f70b4b22ef86dc38dad1fda8e169bcd]
stable/6.1: [307d80193b4a4a75b8dc4e0d3162be3755abbed7]
stable/6.12: [3447641d361dcc5511841d986ad4d849b2900d9b]
stable/6.18: [b13202d401e1a20fec89b0cda733dcbaf279f79d]
stable/6.6: [7a3e1481f4ee6c581bccc6bfc6c970aac5be7b0c]
stable/7.1: [dd633280de7fdfd60dc4fcf63d04e2ad95b43269]

CVE-2026-74624: netfilter: nf_conntrack: defer invalid log until after unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74624

Introduced by commit 628d694 ("netfilter: conntrack: reduce timeout
when receiving out-of-window fin or rst") in v6.1-rc1.
Introduced by commit d9a6f0d ("netfilter: conntrack: prepare
tcp_in_window for ternary return value") in v6.1-rc1.
Introduced by commit f71cb8f ("netfilter: conntrack: sctp: use nf log
infrastructure for invalid packets") in v6.3-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
stable/6.1

Fixed status
mainline: [2d19b95c9723001f214f7a47d67b09f46238f200]
stable/6.1: [ca97360eba4b3dc67f1804625542f4ccc774242a]
stable/6.12: [9480fcf70a5aa9d320088a01c95df0e5e6391f4a]
stable/6.18: [0424186d570aa4d1ad17f516afb86bd9eaa4f42e]
stable/6.6: [63853eb20bba4e00b7cd0b8cfc19337bbaaf5037]
stable/7.1: [c0224327b7cbed9d3198e8dbec847281053dcd06]

CVE-2026-74625: netfilter: bridge: release template ct on non-IP path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74625

Introduced by commit 3c171f4 ("netfilter: bridge: add connection
tracking system") in v5.3-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d45cc8020d7c0a9f01dee42ff5c40bc14c9af72f]
stable/5.10: [fc90df37540627d092af770215fb4b7befe9409b]
stable/5.15: [daa6e070f8e1e7a4dddec8b64ca37663f8cda917]
stable/6.1: [bd7b16494dacf87e9336a1dcfdada83b9e40edd6]
stable/6.12: [46d559f00b1ab1d114f92d2f16c5ef0093b3b9dd]
stable/6.18: [c58d34fe8b7e47bb0b350a7625023b1261342be5]
stable/6.6: [6ea88401e10e04e0b3bb7a7adea54932fb60b93b]
stable/7.1: [7cff440d702616022769f2643168d7f9820547a0]

CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74626

Introduced by commit 548c237 ("net: Add support for NTB virtual
ethernet device") in v3.9-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2121faf133ac3bf9531b53a7e21273649a08517]
stable/6.18: [a4e340971fe8ccd245d206db4d43b2a0eec240bd]
stable/7.1: [755fd7843f300d724caceabdf9bb13adc8701540]

CVE-2026-74627: net: devmem: prevent net-iov / page mixing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74627

Introduced by commit bd61848 ("net: devmem: Implement TX path") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53a43508ee332d8bffe40590c3d189c92a551f9f]
stable/6.18: [e9bfe12b1d04c34c6fedcba21d9709b65c08aa33]
stable/7.1: [ed08011ae0be88f16cceae190535d6c790c83b0c]

CVE-2026-74628: net/x25: fix use-after-free of the socket by its timers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74628

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2195424c3da2ef1829a63b807e3a900a90e57d85]
stable/5.15: [6b79659590f0f82a9b8efd2ffd55ec6399ebfc33]
stable/6.1: [fdd9ac50b9b61ef2b2d52c5156aff788be91454d]
stable/6.12: [3c4919be5d910db4beebca420953858606fba7d8]
stable/6.18: [4bc522b33438fefc3272840ae5988771863a4f1f]
stable/6.6: [1fc9f6d2c7c9fdb341bfe8ca449c990632299ea6]
stable/7.1: [e92c7e2b41d1528a830bc64c5e4e46dfa8133dda]

CVE-2026-74629: net/dibs: Correct freeing of dmb_clientid_arr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74629

Introduced by commit cc21191 ("dibs: Move data path to dibs layer") in
v6.18-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e6869be49064915edb6c8776b27c376cfdb0df5]
stable/6.18: [ece6426b61241e9bfb41aa131f235168f55229b1]
stable/7.1: [7a1df20a8d2cc89e3a442b6e0b43b1cacde8d403]

CVE-2026-74630: ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74630

Introduced by commit 8814c4b ("[IPV6] ADDRCONF: Convert addrconf_lock
to RCU.") in v2.6.20.16.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e243671bc7b8eaf00f83dd2f4367436dc0cff98]
stable/5.10: [785d908f8d21c8bc78b6fb2c2932ab662bf6918a]
stable/5.15: [aedcfefdb5b7ed7f8a6196a3e68a25bdbe51d2f8]
stable/6.1: [145812b678de9f3b59780173be3c0d22ed60dd93]
stable/6.12: [1c206d461c680c3151daa3c89fc26eaf5bf98a7f]
stable/6.18: [680fbd7942185448eadb990a3d10a53eb946b702]
stable/6.6: [cc5bd568f9b7683e60841b6fd02c10d64535bd6e]
stable/7.1: [14e812ab41df0cac033479da835ec9a5de633404]

CVE-2026-74631: net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74631

Introduced by commit 9014db2 ("smc: add support for splice()") in v4.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d9686af2976741bbd79b150d1c9e60b81e7f12e]
stable/5.10: [7ddc7af2ae7fc5a0c0635b245c0824c8b76de5cb]
stable/5.15: [07ad246529d136d5ef441d5ab4c305d132ff3090]
stable/6.1: [c841789e456ec6751342fa800639ce8e82ff0e6b]
stable/6.12: [ca8342b5fc24c249fdb998468f6a168b457c67e5]
stable/6.18: [0b7d54cedea5cb158e21925ae0c6c2f5c87ed2a0]
stable/6.6: [af02c67ce654356c58db20a0bb2db33ace3b07a8]
stable/7.1: [4515c78f4d9fd577270f012efeb062ea58b3682d]

CVE-2026-74632: mm/huge_memory: fix huge_zero_pfn race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74632

Introduced by commit 3b77e8c ("mm/thp: make is_huge_zero_pmd() safe
and quicker") in v5.13-rc7.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [33192a26cddea7a7e4ca66e5c3eebd36fa8be2bb]
stable/6.1: [9332b080ad57650d1dc582e54517f9fc78ef89cc]
stable/6.12: [6024f6d0d9b9ca5138bfc4ac6f6e4bdf616e42b3]
stable/6.18: [105d04edbec83010df5728f74d17fd9c108e7553]
stable/6.6: [f3a874a903053c53fb53ba287ea9eacda69c68e8]
stable/7.1: [ab7e4b407c7f58d1a003134eff3841f303d5ccc2]

CVE-2026-74633: tracing: Fix NULL pointer dereference in module event
cache removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74633

Introduced by commit b355247 ("tracing: Cache \":mod:\" events for
modules not loaded yet") in v6.14-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b69859204d4db3acd86c1c2dadcef0d77b451933]
stable/6.18: [152a00440dc6ef62c6e4cf9bd881a7e6bb81fda9]
stable/7.1: [ad4e9dd5fec7a322a471ff36fb9c76214e3c6992]

CVE-2026-74634: ring-buffer: Prevent subbuf order change when resizing
is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74634

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf98d7b0d5a99991e47e66cee4eb1d3fa514be97]
stable/6.12: [b45b91db41379ee5fb36c187d6d7c37b725cbe8e]
stable/6.18: [62978cf6347972c04130e4e841ba404504d92b32]
stable/7.1: [7568e9e717e7540bd05bcc007f5d76fcaff3cdff]

CVE-2026-74635: fbdev: bitblit: bound-check glyph index in bit_cursor()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74635

Introduced by commit 18c4ef4 ("fbdev: bitblit: bound-check glyph index
in bit_putcs*") in v6.18-rc4.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [e033cbf3975a8465f879ebd5989dc35b04423a4d]
stable/5.10: [250159ace2dc53c1bdad267aa8da51b638748700]
stable/5.15: [46336f476484f36145e5117e72d7b590f47433ee]
stable/6.1: [bf750cfeacf4e47ac72dadc7f05839696efb8576]
stable/6.12: [c1e7351767dd30fc574395c82121e4c67b882da3]
stable/6.18: [bc9db0d879c655d5dfd8add32fd60f13e65d132c]
stable/6.6: [94134d70abf9273b70499d97d0adc9185ef21091]
stable/7.1: [9ea879862e66e354e616028c31b39aa3eb6d35d8]

CVE-2026-74636: tracing: Fix race between update_event_fields and,
event_define_fields

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74636

Introduced by commit b3bc854 ("tracing: Have TRACE_DEFINE_ENUM affect
trace event types as well") in v5.18-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [c3730b8373bb5059d735509b9e6a00d7eb337d7c]
stable/5.15: [4e39f7b4d9d36508c53e89e6cbc640728df870b5]
stable/6.1: [a30d421468300b1e7b2f233136aeb2db8013f555]
stable/6.12: [fdeb190b0905a6aaed1e5d6adfb8613214748d7d]
stable/6.18: [ed49684e69f846bf50b5050651ccdb87cfd152c0]
stable/6.6: [e5f1d301b4bdaa4206db251fdc691f623162b0a8]
stable/7.1: [f128740f39ab28d1f4ad5bdd10f3e117eec0c374]

CVE-2026-74637: perf/core: Fix group leader use-after-free after sibling detach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74637

Introduced by commit 8a49542 ("perf_events: Fix races in group
composition") in v2.6.35-rc2.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42c5ca1f0a288a52878bd72a5595b08261057438]
stable/6.12: [b42948f9e0d1ea4dbd5742ce1dfc7688de5d4a35]
stable/6.18: [a979a642402d0b1f856c7a729b4cb2d92de4cf2f]
stable/7.1: [1e7abfeb23c12bf46f6457e4a3e1a1a300d50619]

CVE-2026-74638: drm/v3d: Serialize the scheduler timeout handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74638

According to the .vulnerable file, this bug was introduced by commit
35e4079 in v6.15-rc6.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [4da94744707b27a3ae1197bdd7127da4505dc5b1]
stable/6.18: [5884851a096d8afcdf91f0e542bac193035183a6]
stable/7.1: [c22a45817b9c92aa0391db60e2ed467c7e6027d7]

CVE-2026-74639: ALSA: us144mkii: re-anchor capture URBs on resubmission

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74639

Introduced by commit 5cff152 ("ALSA: us144mkii: capture_urb_complete:
redundant usb_anchor_urb corrupts anchor list on each resubmission")
in v7.2-rc2.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.1

Fixed status
mainline: [2615f0fb90df8cf5a96133ca4be74294ed288604]
stable/6.18: [7779249561d14b8a17c0c83783225794e24a587d]
stable/7.1: [a5548ce916594c811bd90ce33d67baa3557a6791]

CVE-2026-74640: ALSA: FCP: fix OOB write in fcp_meter_ctl_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74640

Introduced by commit 46757a3 ("ALSA: FCP: Add Focusrite Control
Protocol driver") in v6.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [620f1e52a46f604635efd0fb78138afd6a513b5d]
stable/6.18: [bb30e35c36ed00f24fa39aded811f64230a913b0]
stable/7.1: [bb61dc2ae59026f76db26e1909746908bc5b6f31]

CVE-2026-74641: ALSA: usx2y: bound the hwdep mmap fault offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74641

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ca1eea3cd17930daffe9e429a7c89232036ec24]
stable/5.10: [ad6fedea65c6e90eda00d716c8bf20cdc437ed10]
stable/5.15: [10a87401fb3148c388e55df0148295b3b137da07]
stable/6.1: [34ab56ed854baa73a731cfd99af689f0b1bac444]
stable/6.12: [f613b4a2d87247b51a1b2b330f2e083a454125f2]
stable/6.18: [f75d6f61f0d9c5c1ea725104014e10d26d1e3a00]
stable/6.6: [4208db2453e1ea71b8048a5b7802360cb29a53f1]
stable/7.1: [5bf5ccddf00b59f1e3ea7e65d76a5f5b5c21cc2e]

CVE-2026-74642: ALSA: usb: Fix UAF at delayed release of MIDI2 EPs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74642

Introduced by commit 4a05b2d ("ALSA: usb-audio: fix use-after-free in
ump_to_endpoint()") in v7.2-rc6.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6 stable/7.1

Fixed status
mainline: [f8a80cfb68613fb7e6452b66447dbc63f435d140]
stable/6.12: [422d8a02de5ce6a29d616d55e5ead5dec69ac1d7]
stable/6.18: [d217d723c5e43881b952cdb978477f7f2dc0b6d7]
stable/6.6: [d431941825d357be7d9ab0cb7505e3a1963bd89e]
stable/7.1: [f9d492a39ebeb1a56f13ec6dd165a18a48dec812]

CVE-2026-74643: samples/damon/mtier: error out for zero quota goal target values

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74643

Introduced by commit c5e67d4 ("samples/damon/mtier: add parameters for
node0 memory usage") in v6.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a16fd3ad9d89b05475864da97327870464611736]
stable/6.18: [e16b8d640ec99b28bc827560edcf9706e610c3aa]
stable/7.1: [684f271210becd7b8c4088f06c442499e48a43a0]

CVE-2026-74644: mm/damon/ops-common: putback folios on invalid migrate nid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74644

Introduced by commit 7e6c313 ("mm/damon/ops-common: ignore migration
request to invalid nodes") in v6.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [5deb65c34e682e7c5f5df417a70e223e8fcc5f5a]
stable/6.12: [7001c0a1bc9018cd5b2b72ebebb216d738b2ec81]
stable/6.18: [460181e4bb47a57776c64f0832c2096de8878cb3]
stable/7.1: [cfef454862b7d2776e0955b873dd59af6b47cfcb]

CVE-2026-74645: mm/damon/lru_sort: error out for >10000 active_mem_bp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74645

Introduced by commit 40d98d3 ("mm/damon/lru_sort: support
active:inactive memory ratio based auto-tuning") in v7.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06befa61c427e74319781e6f35a364cfc32dbae8]
stable/7.1: [e7e5e5e0dfe2ea171044c24c263efae4ee882b3f]

CVE-2026-74646: misc: fastrpc: take fl->lock when moving mmaps on
interrupted invoke

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74646

Introduced by commit 76e8e4a ("misc: fastrpc: Safekeep mmaps on
interrupted invoke") in v6.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b85a0e91d7d6cd06a53c881a46f749cfcef416a2]
stable/6.12: [a902fe1f80f58a2335b6be1131866f827ec44d1a]
stable/6.18: [af6345159abcbaa550518f31990d2a9558c2d369]
stable/6.6: [3f265e405e5ef85030c3777262e18bb556bc8724]
stable/7.1: [efd02f8d1a7449f15809bc18d3cd41aafea75d7e]

CVE-2026-74647: misc: fastrpc: Remove buffer from list prior to unmap operation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74647

Introduced by commit 2419e55 ("misc: fastrpc: add mmap/unmap support")
in v5.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6102ceb4eab845743ee57acd3863fbd06e93c927]
stable/6.12: [fe70329055977fc1e8dc6291318d0dd75470795a]
stable/6.18: [9bf22a7d950cec2d1efeca7f16bb20fcca84c36a]
stable/6.6: [97273624f7b356eaf8261609a75cfcb8738a165a]
stable/7.1: [0beaa9bd7eb10d9b5e6352ed5161f3f3bbd4c3c5]

CVE-2026-74648: staging: rtl8723bs: validate monitor transmit frame lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74648

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6829665d050983907b560173e49dcc6c11cb2730]
stable/5.10: [f03398d835f5249c49546f0eb0d0df6792b95d5f]
stable/5.15: [a3ac6d849de5f7abe14761d741bbb843ac793454]
stable/6.1: [7edd3adb0c80d70b4237640275c559610f438476]
stable/6.12: [7b0f62d2986a28e5e4188366bc2f4e2868b14790]
stable/6.18: [8b3e4ed9c35d3d3b64fcc23f4a1f22b37c1865b1]
stable/6.6: [c5e5d78743992e235b76d2ebe5a403d60315aa8a]
stable/7.1: [bd88f6289b7e483216a9c1df15a0460ef9b02cb6]

CVE-2026-74649: staging: rtl8723bs: fix missing shared-key auth
challenge length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74649

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c56ef658ac8c6bca36bc5574715e8f717207c6c]
stable/5.15: [39ae1033071001af9bb4573ebdbb43bbbe88f749]
stable/6.1: [4d018e7d7d908bdfcb5ecfa922b1d5cb9ddb3722]
stable/6.12: [87c2f073d2aaea041d531b8e579c47570b54b3b7]
stable/6.18: [a28a4b0592e4a37ea471bc0d308513a93133ce7e]
stable/6.6: [4ba402fd47009d20e51dbfc934abb562098ea35b]
stable/7.1: [6235b5156b48ed5d1ce3410d8f0b2fd67d30d944]

CVE-2026-74650: staging: rtl8723bs: fix OOB read in WMM_param_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74650

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae21407350151bddfd4fea7aa39bd0643c0ca9d3]
stable/5.15: [6cdca4c8b64c15a3ab9ad7a85f482e9519eadf93]
stable/6.1: [2bee6f7a0f0125238951e31da2e96d06fe359043]
stable/6.12: [ce2399717de242344880044b91a20a712644fdfb]
stable/6.18: [e5b7610008f4e6a80c8b071aa77ddbd5e17ea472]
stable/6.6: [1158b9931207392d6dd136aa0c4be18893b50fa1]
stable/7.1: [e429c6dfd5d2324cd866daaf4c29d5cfe4dea0e4]

CVE-2026-74651: staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74651

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c3e23e78862493e8cf1adad02b10ffcb8b9921c]
stable/5.10: [4fc459c5cd8767ca4d9bf2f7becbd562639ba4d9]
stable/5.15: [b45be82387bf759931acdd21ca7dfe740f16eb97]
stable/6.1: [c9068f82a0906b29c905e8788edb62c3208c7c8a]
stable/6.12: [42c5a0d454aa5b54fec17162d9a1f8c30f8af45a]
stable/6.18: [e167a38a8a8f50f137721fef1a1fbba0f4588b5d]
stable/6.6: [0d19f0600fbb610c42f2a86f95c35706dc04691b]
stable/7.1: [01ab275f8f3e497a13ebbe4ded44ec0623bccde3]

CVE-2026-74652: serial: amba-pl011: cancel RS485 hrtimers after freeing IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74652

Introduced by commit 2c1fd53 ("serial: amba-pl011: Fix RTS handling in
RS485 mode") in v6.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36672c8d7d14e9c43287528455d2c97b526ea6ad]
stable/6.18: [759ead98a39fb625be302f9aa66290985dcaa325]
stable/7.1: [e57f0aa5c35be37218ba0e4887b241584dd4b2d2]

CVE-2026-74653: serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74653

According to the .vulnerable file, this bug was introduced by commit
e6e912c in v2.6.36-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1423415471274abda87024967d7fe2206ceee0ea]
stable/6.18: [3ce24bc4d115336218e59b7e286fd3a79f4fc4c6]
stable/7.1: [7795e8abedc86438cae0454602cbf9038b94bf38]

CVE-2026-74654: serial: 8250_dma: Clear stale RX state on shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74654

Introduced by commit 0fcb790 ("tty: serial: 8250_dma: keep own book
keeping about RX transfers") in v3.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2fe6a0efecbef00e3ecc2db64dd5afa8c212b41]
stable/5.10: [bf4fb620e02962b2b52500a4b3d8420f351eb46a]
stable/5.15: [e10f06ee050a08930e2339b6fec7148fd0b2a8f6]
stable/6.1: [d06cfb1add4a2d5b393e9e31f49ebbd168beea49]
stable/6.12: [9f2444f4c0e4b06f61bae38da87c9c94c78efa86]
stable/6.18: [ae05d9e50b6b9f246c110b3bdc03676145c2d0d4]
stable/6.6: [e7a5d792cf64a2096e18f1d573cc3d01cba15e92]
stable/7.1: [e7e3cc6709caa49d1d6ce6c1f7cb305e38675cc9]

CVE-2026-74655: serial: qcom-geni: fix TX DMA buffer flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74655

Introduced by commit 2aaa43c ("tty: serial: qcom-geni-serial: add
support for serial engine DMA") in v6.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3c04834ae1ab5e9cfbe8ac54ec734aa4774249d]
stable/6.12: [313ae287442e5e8d3f7b53b73f37d384bda072d0]
stable/6.18: [1c31e2377f4c1bb110ca7f6e597b2253a7440c37]
stable/7.1: [b1801c0d40f62778b613334de5840aba10a564d5]

CVE-2026-74656: ipv4: fix use-after-free in fib_nhc_update_mtu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74656

Introduced by commit af7d6cc ("net: ipv4: update fnhe_pmtu when first
hop's MTU changes") in v4.19-rc8.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [bc5bde9ce3cc36502839dfe98e068f7303a50982]
stable/5.10: [fd39e711866498ae94fcf9acf6f422a4f045b681]
stable/5.15: [e1e602d6b22d5cb1641c4459c487eb18bf569e0a]
stable/6.1: [e00f7d2b5f2540a3415a229c982af7a25ff6362e]
stable/6.12: [5a28a4b22dde92f9d293b94236314b8d6181dc4a]
stable/6.18: [63996ffc594d128ccec8fc0983f91effd2d3adc4]
stable/6.6: [dfe388da13aa784851e5ebbea90afbb099075761]
stable/7.1: [ed503eaad62f20cdd5122d7c3078a648a99c8f16]

CVE-2026-74657: ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74657

Introduced by commit d156626 ("ipv4: Allow ipv6 gateway with ipv4
routes") in v5.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ff9548d84945d2cbf9e4c207288063a200ea397]
stable/5.15: [0f0ca602941d0a81ae9514943ca06c55159c6385]
stable/6.1: [5307a53599fa762c06e475ee4a375252074fd324]
stable/6.12: [4a5dfbae5179f6574695012a980476254df2d295]
stable/6.18: [a59edda6eda1252340354322d8ab318b2e9052fb]
stable/6.6: [7f80ad373ce4a7af5367ff273cea0f16e91387f3]
stable/7.1: [9b22f13524fa0de0d963bbd3002df6c28bae3395]

CVE-2026-74658: futex: Prevent robust futex exit race some more

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74658

Introduced by commit ca16d5b ("futex: Prevent robust futex exit race")
in v5.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [6d4514ca9cdf61fec4ec634cf50386f6f7e69748]
stable/5.10: [83b0f71d5a313a765754acab51d2ecc5de76e0b9]
stable/5.15: [a1c2b7b86a946b6b172bce44d74553da2323a36c]
stable/6.1: [33bfa85458105d6169ebdb697f692b8bb8025bae]
stable/6.12: [925628656b73b70930972ccde421de4f758d8650]
stable/6.18: [7b8c53263f8878bdd12c87e147ac6feca5c05211]
stable/6.6: [aa5c571901c6b22b58373693a4bf889ecab11ff5]
stable/7.1: [7cf710e70f9bb8ea75f759ebed09871801315992]

CVE-2026-74659: net: bridge: mrp: fix uninitialised bytes on the wire

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74659

Introduced by commit f745893 ("net: bridge: mrp: Update the Test
frames for MRA") in v5.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63488dba65ef91373ef616575b32eb0eb21459f4]
stable/5.15: [014c062d23c63ec77ef2cf17a0d9363c7441cc94]
stable/6.1: [7ebc23ff03668042e0b0e4034bb1518d36198d9e]
stable/6.12: [a5e385eeb2d6dbbbdebfa050e67c34734ae12693]
stable/6.18: [5912cf1822fbe53ae275c147868740eb384a5d3e]
stable/6.6: [06d58b8d2f053ced82e01efaeb6e7c82891eed58]
stable/7.1: [e08665218040f8e312abe40f74543186f3c2c941]

CVE-2026-74660: netfilter: ebt_nflog: pin the NFLOG backend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74660

Introduced by commit c83fa19 ("netfilter: nf_log: don't call
synchronize_rcu in nf_log_unset") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30825970339c107bacaf7f61af90fcdb1f597ca1]
stable/5.10: [3bcce49d617c593c7606083bfdb464a1761fa68d]
stable/5.15: [394d7939c6b2b9e6bea0844c89efb5913168d898]
stable/6.1: [2cac4294f184c9bc19ff82552c62b80498694c39]
stable/6.12: [6809379a860b9fccbb5435bf08343f6d081ac68d]
stable/6.18: [47a119ec8a7e2d5c8c4e86fb1a56c4e696e500fb]
stable/6.6: [9d8a94b48b393885e7f876c8ef68ed4da5012078]
stable/7.1: [e2ab7e878bdbe80104c879c31fd2d82a476703b8]

CVE-2026-74661: mac802154: fix netdev use-after-free in beacon worker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74661

Introduced by commit 3accf47 ("mac802154: Handle basic beaconing") in v6.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f26a690e8efa54315e4922368daf54e0b8f5515]
stable/6.12: [e5fb0e03bc7f45508c182a427357bf6b389a9033]
stable/6.18: [e6cd416a899edc912b428c4ba399bd73f516cb31]
stable/6.6: [fe820dcc1d8ff77783a9d2bcc93b98c99ac6d517]
stable/7.1: [9d067e581597c462c51fee8a30b51bc48a68c4e1]

CVE-2026-74662: inet: frags: publish queues before arming timer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74662

Introduced by commit 648700f ("inet: frags: use rhashtables for
reassembly units") in v4.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [653d7ddf6cba867777a3d14c4f83ace008c5ad13]
stable/6.18: [9f904dd3e455750e5d4ec9b2f134835811b85a2f]
stable/7.1: [928128865e43b197e30688dc1bc991592c97edcf]

CVE-2026-74663: net/sched: reject overly deep qdisc hierarchies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74663

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dedd34b0f2310e28c5f6d4875cfbf4b7ed821c01]
stable/6.1: [9f69bb9fdaa2fe64b68bb62fb84d405784bee540]
stable/6.12: [2759acf08a3454866660edcd3ef4e64139f254a6]
stable/6.18: [a4b14a4df29d36458a943f9b521ddd0f940363cc]
stable/6.6: [8ca8cdb74939581339e1ae370193c0adb5a85336]
stable/7.1: [e2d658c6427844cee5bc654b436ca68d680b6148]

CVE-2026-74664: net: openvswitch: reallocate update replies for mismatched IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74664

Introduced by commit 74ed7ab ("openvswitch: Add support for unique
flow IDs.") in v4.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d1c224dd914579524a183a514c12b95095d12ce]
stable/5.10: [bd8ca84d48cd9a4f6fc63df26512c55e1d339927]
stable/5.15: [00f987f066e802793a37dd2167459e67cf2cf2ec]
stable/6.1: [696a0b9435fce9cf4f1e9ba7f6afa6bee96c97fc]
stable/6.12: [69f40ccf85074981340847d650a9cbf9adabfbbe]
stable/6.18: [23716dd9d8d46a5908536b73dc085e62f2b5c237]
stable/6.6: [87d0c0040b5d4b61de51ae39132c4c46709f2f77]
stable/7.1: [20751193d83be2e9735d4faee71375691c09cd13]

CVE-2026-74665: net: fix skb length accounting after generic XDP frag adjustment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74665

Introduced by commit e6d5dbd ("xdp: add multi-buff support for xdp
running in generic mode") in v6.9-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33f2b2eb33d666ecac68031e0f31424fb70528db]
stable/6.12: [72468efcc089782fa047afddd10856b11a14ef5b]
stable/6.18: [5f30f9c302cea1f2ebf97abe574c1826544223d7]
stable/7.1: [ea1ccd6d1c6370868e3b032a3fc575b9c397f2e1]

CVE-2026-74666: packet: synchronize pressure clearing with ring reconfiguration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74666

Introduced by commit 2ccdbaa ("packet: rollover lock contention
avoidance") in v4.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a35da325cac4d5bcad76a2aa943408a6f1d9000]
stable/6.12: [ad740b4990347521f0db260d381f9f74e7b340ba]
stable/6.18: [2c7b5eb87b2b288cdbde825f21d2b83b2f5da747]
stable/6.6: [cf8189b82bb93f219ab740e0346c919ad65ada62]
stable/7.1: [a08196c3cc105947746ec21309edfbb60275fcdb]

CVE-2026-74667: net/packet: reset the MAC header on the packet-socket
transmit path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74667

Introduced by commit 75c6577 ("net/packet: Ask driver for protocol if
not provided by user") in v5.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2707480cfbf19c7619acc9c089d17f20869821f]
stable/5.10: [1e43a1d66615f411d427f9df1f46dd049d9e3681]
stable/5.15: [4057853a91fb796c4f47c7d1baf1aa085394148e]
stable/6.1: [2610ed4e86a4590234a9d70518c469751c5af231]
stable/6.12: [284f3e7a3f1a743fdf89e304fd1f19d5ffcff46d]
stable/6.18: [971aa7d99242bbf09513e27b7a243f0b29ff23ae]
stable/6.6: [b47ba8fe6e1d2df8c92048de5afafd059447dc30]
stable/7.1: [fdd4d7d52358a58e351dd9d82530c04eba8ccd7a]

CVE-2026-74668: packet: use consistent hard_header_len in TX_RING send path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74668

Introduced by commit 69e3c75 ("net: TX_RING and packet mmap") in v2.6.31-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21b5953e7494c16a42e6cd8cf110e18d13ae4a6b]
stable/6.12: [016763e829cac37b3234eace86fd0a4c560de4a7]
stable/6.18: [27e068d1b35dbec10a3cf268887c94407be4badc]
stable/6.6: [d85d2fd54e901637c81d847811e03c662aee13cd]
stable/7.1: [d48ea5c9c4c34dc0df621f0e39ed3a16b644621a]

CVE-2026-74669: ipvs: clear IPv4 options after rebasing tunnel ICMP errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74669

Introduced by commit f2edb9f ("ipvs: implement passive PMTUD for IPIP
packets") in v3.7-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0ba936287dfe9783426aac27e5fd76fe35b38c9]
stable/5.10: [79ffa99202c944467e28b13b513bf2998732edff]
stable/5.15: [c9413b50204738fbc429bb86bf01353c393a6c28]
stable/6.1: [37c61b3745129cbd682c557b51345828120972e5]
stable/6.12: [6f46fc460e9316062bdcdf89199eb5d7a33da33b]
stable/6.18: [75eec935444db4af2123e0491936f6e273d7ea00]
stable/6.6: [ed246dd85ebf27c1f6b7897834d40786c0ca3006]
stable/7.1: [384b4dae14277d369221d187e9b3af56c79d2e50]

CVE-2026-74670: ipvs: stop estimator after disabled calc phase

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74670

Introduced by commit 705dd34 ("ipvs: use kthreads for stats
estimation") in v6.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [558f67f1340f803a346ecd14a69c49653111c5f4]
stable/6.12: [de98dc5ef94b83bbb444c670c253ea02ca0f5e43]
stable/6.18: [e7f34f29b330265d456943bf0b984dcecfcef9af]
stable/6.6: [d5122a2b2601145975d387006e517c56896e310e]
stable/7.1: [2335dedc1922dfa889ca1f9f70370924e8e79a08]

CVE-2026-74671: ima: fix out-of-bounds read in xattr_verify()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74671

Introduced by commit 3ea7a56 ("ima: provide hash algo info in the
xattr") in v3.13-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ff232d31106f45ac87c3b64e1d35a0667777797]
stable/5.10: [d823b5f4557083d1dd92096f796a78a2b1b06d10]
stable/5.15: [caeb105c15ea2431fa8da7ecfa242d0c68272426]
stable/6.1: [a784b4732ac7e51862b9b210c2d8b2ab9e83568c]
stable/6.12: [7e515b6c9aab452a4f0734bd7208e4e780e164ca]
stable/6.18: [27f3924061592d0ef6b04e16f48754b6cb6adf27]
stable/6.6: [b6cb134707a2127d90a58d69dd818679cae8033c]
stable/7.1: [dd04114af0d451091f7b8cbd26d9e37d011e9131]

CVE-2026-74672: mm/vmalloc: acquire init_mm lock on huge vmap to avoid
ptdump UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74672

Introduced by commit b6bdb75 ("mm/vmalloc: add interfaces to free
unmapped page table") in v4.16-rc7.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [26444eb71465c9934d9d418ef69c43f61185329b]
stable/6.1: [39c6772b56a6bbdd62794833f74232971d94d7c9]
stable/6.12: [7ac8a333dd41ba5e1b4e8c6edbc48b15446c5468]
stable/6.18: [c5bf8cd148cfea948cfa3db71da427294b20db0f]
stable/6.6: [8d7f560f4b0482d469de962fbe4b59c37561052e]
stable/7.1: [3cc26c8907db0f5d1ff8043b5851ee572e9b3c98]

CVE-2026-74673: Input: evdev - fix information leak in evdev_pass_values()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74673

According to the .vulnerable file, this bug was introduced by commit
6addb1d in v2.6.24-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90f305f2c7a30257c683e13f4bf7c798eea992a0]
stable/5.10: [d2e3839419ac4047835762c4d7712bda1101b57e]
stable/5.15: [c6d5fa46c1ee25d068fc730fd377f0f54188d290]
stable/6.1: [e748811d9b80a3e101110ff4b3c612e5fca54d98]
stable/6.12: [7d17e9454a9af3ec7aebb88b41a9deedd5b19a6b]
stable/6.18: [bd3c4108a56de34380edab670065e86283cb3029]
stable/6.6: [06a286b320236508d02ab2ccc9496352748652a8]
stable/7.1: [7e55ca1080f09d9f7112c7f20ac31f682c1f2374]

CVE-2026-74674: mm: fix incorrect flush address in direct page table reclaim

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74674

Introduced by commit 4c640eb ("mm: move pte table reclaim code to
memory.c") in v7.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [478a1c3abebfc717db0d1281a9cdd7befafee542]
stable/7.1: [0b8ff21cbda8808c86b18f1b0ca2d0025af9a80a]

CVE-2026-74675: vt: stabilize tty reference in kbd_keycode with tty_port_tty_get

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74675

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e25d47a526939ad44b75f778b8a7500562b84fc1]
stable/5.10: [b84fd400f80adf4d1c88fbce50ae1cf2f8119e65]
stable/5.15: [38400673c9bfb39cfc87539e1a072087e98f4e4f]
stable/6.1: [cab5a342f0589334046741006d8a280514f94235]
stable/6.12: [3f6b1d3fcfc26dc3fc85262f753439df93b055b4]
stable/6.18: [b664592e9ba8c47c9e23408db7ba52eb9f946c8a]
stable/6.6: [38a0aa593ebc275aea6f79534d07f44e43768ce6]
stable/7.1: [cc4a1a2ce0c58eafd477effb055863935260ddc1]

CVE-2026-74676: vt: add permission check for KDSKBMETA ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74676

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7ad0034453ba4c353f9b8f810ee2569de33d283]
stable/5.10: [9f8cbaf4b774694dcc292e60509762483ebfd9ae]
stable/5.15: [ddc4a8303347114e945b9e6e81b81d77855f7358]
stable/6.1: [1c5b67a1e2cb7d78dab321280f330b056e3bf437]
stable/6.12: [4671c3b79e337bbae28c2d79023dc642df012bde]
stable/6.18: [a1c31e026c93e378e297a8df8328983d3013a59f]
stable/6.6: [d8ead5083b203d12b8319e7cb29cc6b8836e813f]
stable/7.1: [7bf32337a7103ccb686cbd240324bf26225ef2d6]

CVE-2026-74677: net: usb: ipheth: fix carrier_work UAF on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74677

Introduced by commit bb1b40c ("usbnet: ipheth: prevent TX queue
timeouts when device not ready") in v4.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [fde39b8a521780391fb4e5bda2c0aa4928947f12]
stable/6.12: [d07133fe1befae9a1e4c4c5e46ef0b73d2992020]
stable/6.18: [2c7496124e94c7f9c3daa5c5b1fb563ca9d62c45]
stable/7.1: [48303f3ae0fa6e102f3fc7dbf1688cc179131962]

CVE-2026-74678: net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74678

Introduced by commit 16b1c4e ("net: usb: ax88179_178a: add TSO
feature") in v5.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f428e30947395d9b9aacee03e25a4e6cfcad7a4]
stable/6.1: [83a765cbd7b4d11b0b9fa1bb9d941ae911a2159b]
stable/6.12: [2be5091fa693b9119ad25a8bb8c149d236a23ade]
stable/6.18: [58733b1dd46bb231d9d279c132a20ee46da1b664]
stable/6.6: [1c63303659a2264bd55d9813df74cb4caeed5922]
stable/7.1: [4039cd807a5a46dc5f7618fffae926b8ad8455eb]

CVE-2026-74679: usb: gadget: f_ncm: Use unsigned int for ndp_index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74679

Introduced by commit 370af73 ("usb: gadget: NCM: RX function support
multiple NDPs") in v3.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b1c8a9403a26cb0fed7a648916c74dc236da591]
stable/5.10: [9c8c6825a750fcd3efbe922847ca70ccd5a66857]
stable/5.15: [a1c0deeba4a46481543d6b09c665f758c54c3a1a]
stable/6.1: [d13f650a3485b58c124b3cda45597e8002c9c833]
stable/6.12: [5b2b3a3229a3f4c493ffdee53aee2f173b6f13b3]
stable/6.18: [d328fdc607fa1bb668ad512e1c918a120f78f337]
stable/6.6: [11413d7ed42174b8f5d8d0b6a25d10dc88239b21]
stable/7.1: [fc9e54e22845c4da29588ca0986cb7c795b5a262]

CVE-2026-74680: usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74680

Introduced by commit 1b0e614 ("[PATCH] USB ATM: driver for the
Conexant AccessRunner chipset cxacru") in v2.6.13-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2f811314be351d86b6ab41e9297ae80d8da6f86]
stable/5.10: [6133b461058316e3ccba7331f974d110d4c08b23]
stable/5.15: [61093d7f1144f6a15bac505df35e5f535ade2ac1]
stable/6.1: [645d98dbccdbfdbf0129f48822af7183492de091]
stable/6.12: [939b6a41f681aea52af678053072ee443068e93e]
stable/6.18: [2f73a065791d2a8e3f0bdf29248e33600359e865]
stable/6.6: [993f7677949e3d72e360e86eed1f41c2511f75ed]
stable/7.1: [0af047703dbed8224552587ed436f14a24371b46]

CVE-2026-74681: usb: misc: usbio: check ibuf_len against rxbuf_len in bulk msg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74681

Introduced by commit 121a0f8 ("usb: misc: Add Intel USBIO bridge
driver") in v6.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e22c9f79b200672f3e477421b6c9050d8cf70a5]
stable/6.18: [ebfd1e82ab0a6d26efd9bdd89de899215851f5bf]
stable/7.1: [9ad0164f78b66b0b5eca3a5748cc94dd87e28124]

CVE-2026-74682: ALSA: usb-audio: fix OOB write on Type II inbound URBs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74682

Introduced by commit 8fdff6a ("ALSA: snd-usb: implement new endpoint
streaming model") in v3.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69ee44e1a23be62318189dc4b37fa4ad94053269]
stable/5.10: [6af5f29af7711233ae68d3b25c15d67478468900]
stable/5.15: [f1fbb50b99311b35c2e85cc70341d62082dca4b5]
stable/6.1: [137bf034740e5a2734794908d0aff1e0bd7cee6e]
stable/6.12: [ca22c94bdfc22c564ca2e11c87ba4d17ebeaaa9a]
stable/6.18: [0a235379825e1a6194e43861ee6658e5fc35686d]
stable/6.6: [6607f85242577f33d4540a0d1f4a6137f5367058]
stable/7.1: [d3ed4e6321bb453757044cb9e5ecb30a33f04903]

CVE-2026-74683: Input: evdev - sanitize event type index when fetching
event masks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74683

According to the .vulnerable file, this bug was introduced by commit
06a1629 in v4.4-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3abd29c61d2ef37c4102cf755b18be53bb9dbea6]
stable/5.10: [c79b08d8fa230871a3634e34a66e591ac2d084ef]
stable/5.15: [f27fa9b39f925d26e034a1f382cb45523138f4ae]
stable/6.1: [f3fc329acad9a71b3c077237cbac20670d2358c8]
stable/6.12: [433913b4a92214d76e9f0c03ad9128fec943d5f8]
stable/6.18: [4034ef247a9dde3f56660b01f0c3280dac6b1274]
stable/6.6: [5db341189bb7ff041d570dbe36ecca7e32913927]
stable/7.1: [810e1883d4815f29c30d900ad7333d03cc2515d1]

CVE-2026-74684: net: tap: set skb->dev before parsing virtio net
header in tap_get_user_xdp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74684

Introduced by commit 924a9bc ("net: check if protocol extracted by
virtio_net_hdr_set_proto is correct") in v5.12-rc3.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [3874892dd27d5387aa9a06f58d9060f18f351d24]
stable/6.12: [15583b07fd691a844fbf7b3ad612cdc9e9a657c0]
stable/6.18: [8b444b126cd8e4473e652f529753ed4dd1360a9c]
stable/7.1: [164c31ee252ebd1ac8f44c2dfc5486b6d9a0379b]

CVE-2026-74685: hwmon: (ltc4282) Clamp negative current limits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74685

Introduced by commit cbc2953 ("hwmon: Add driver for LTC4282") in v6.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e253dd5f9f6d875a317895bf43ec9534ed7523cb]
stable/6.12: [60e06c4dba696173982393252a40ceb7dd2eec18]
stable/6.18: [de58b90a4d1417c15b693eb04c0ce6bc925d84c6]
stable/7.1: [046e56b53c09375ef39903514496aa5508db9729]

CVE-2026-74686: rqspinlock: Reset tail when preserving queue on deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74686

Introduced by commit 7bd6e5c ("rqspinlock: Disable queue destruction
for deadlocks") in v6.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a3c0289c3c8eb4607dff448ae9ff9f902c813af]
stable/7.1: [f54667b0c16213285c9d9b8e3929f738b8f71826]

CVE-2026-74687: watchdog: at91sam9_wdt: prevent timer rearm during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74687

Introduced by commit 5161b31 ("watchdog: at91sam9_wdt: better watchdog
support") in v3.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8444d66aa6b6e7fe0a26fa1a00a11cb4d0523783]
stable/6.18: [29fe74c9aa69d78c1c6a3930f1d9fc5db71a6eed]
stable/7.1: [b7949b0a7d998013b7ec8617a0ef5b07cca80be4]

CVE-2026-74688: sctp: clear control chunk transport if it is being removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74688

Introduced by commit 8a07eb0 ("sctp: Add ASCONF operation on the
single-homed host") in v3.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9158ceaf27780ef64534ad72f44ffde3f8ccc49]
stable/5.10: [dbb3f418a8665ffb0514e1a9520ab6a1c5d4d886]
stable/5.15: [fad4766a74220fe579c6fcaa10ba01c23529814f]
stable/6.1: [936658ec41c28c397ef390140e02d4c91ade92f0]
stable/6.12: [6160e756db81d6cb63e3e2952efcf6c5134be385]
stable/6.18: [18d704bdd809377dfd81a3c2f42426763b5da227]
stable/6.6: [8de65194a04d2552cd39b6c67d942d490f22d174]
stable/7.1: [4d6b9cac6df5e0cfef1a66b3edd7aebdb9e4b7e7]

CVE-2026-74689: net/atm: fix slab-out-of-bounds read in vcc_setsockopt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74689

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0c80dbb970439bd2eeb0e5effff8c16a5f4e1e3]
stable/6.1: [b3bcd5d65ac03c15787b2a5b36c718e26a689336]
stable/6.12: [6eb6af88710977eb529b558a07294874d8c40c4d]
stable/6.18: [9f77c1ab382188f5b51982fab6d913443b6dc59f]
stable/6.6: [35f258fee9ed358c6d0f57f91c30bf029c3724af]
stable/7.1: [2c5988c7349c0b64a7e0441bfc6e1dca54f7116a]

CVE-2026-74690: s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74690

Introduced by commit 684b89b ("s390/ism: add device driver for
internal shared memory") in v4.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1896543ce59c4258625a35cf41e23a9a1f80ea2]
stable/6.18: [fc3021284050ecb3bba8a7851340cedcb5037928]
stable/7.1: [774394d27930ec4cf4cb3eed8ab6a4d20cb2430a]

CVE-2026-74691: net: thunderbolt: Tear down DMA paths before stopping the rings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74691

Introduced by commit e69b6c0 ("net: Add support for networking over
Thunderbolt cable") in v4.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68bf02b6b4ad3f748c6db71fd77b6c0402d252f4]
stable/5.15: [7cce39109206bc5497e0953806563644b88bfc44]
stable/6.1: [0da9a6d27155ad072dd76db8cd637feead99a0e0]
stable/6.12: [103a9b663ac1cacb8465aeff18f84a247154a562]
stable/6.18: [4dd71cb0d23d40cb58fe4261c7bd183dca66caa0]
stable/6.6: [b5a21615f627c48dafaa6ef82a34a5b97a4352aa]
stable/7.1: [9a482b2b117e5fa656b6d24fc01799e8ac2d4368]

CVE-2026-74692: net/smc: fix TOCTOU race between smc_listen_out() and
listener close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74692

Introduced by commit fd57770 ("net/smc: wait for pending work before
clcsock release_sock") in v5.1-rc6.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [185a4caeecabc150106deda1da170b09f2ad803f]
stable/5.15: [53c7938d8bcfde3296ec1a347ba2a9393c1fdcfa]
stable/6.1: [feb71634bb1abab3e8fb5cde874b27001cc1282e]
stable/6.12: [00f89433777236ced4771211047fb5d4cd581cea]
stable/6.18: [78e5ebcd1c10ed7c8bda0a99e0abd5b62da86d67]
stable/6.6: [01865e1ddb126b25ac9eba5cdd7ec49e11183a64]
stable/7.1: [ff5bcd804b5bc5c64736b7d318c20e12ea9506b8]

CVE-2026-74693: net: prestera: validate firmware header length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74693

Introduced by commit 4c2703d ("net: marvell: prestera: Add PCI
interface support") in v5.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae344eb540af3f457179b52bc6061416752485c]
stable/5.10: [38a3afbf9fd8a2e8c47fa3ca47b425a8a9623240]
stable/5.15: [0fbcceb9d19f2d1dcdf099aee590f2517cb718bb]
stable/6.1: [e0f382e8084117f0b11ffb070fe1079e38c0d7f9]
stable/6.12: [470ac9cce7308e60cf2dceb448749cdd006e73de]
stable/6.18: [363e048a9d0a6c245cbc348c8a220170afed046a]
stable/6.6: [6fad06bb793d7089ae05b9fcf46e11be2dfe4850]
stable/7.1: [7fa8a12296d8d5aa4b1c3904f0b354d81124cf29]

CVE-2026-74694: net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74694

Introduced by commit 9771b8c ("net/ncsi: Extend NC-SI Netlink
interface to allow user space to send NC-SI command") in v4.20-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afa58b7384913c8773d837acdb07b035690ec5d2]
stable/5.10: [e60afa01d35f8b2671b27ca93309921427144cce]
stable/5.15: [67c72b8ef63d9d9a610546fda30b116638f39745]
stable/6.1: [4489b4a17892750131e4bef4bc1d3d703c8fb5ba]
stable/6.12: [b5231ad0b376b801ab8cf2962b182cc29deaedb3]
stable/6.18: [02226af69362758046822840fc6a497f5de33f00]
stable/6.6: [43c7d0a6917751ea898ae584d00f24f5deac46d4]
stable/7.1: [3a60b5af75abe8e3494ccd074fb4ae6e601a3e55]

CVE-2026-74695: netfilter: nf_flow_table: drop existing skb dst before
skb_dst_set_noref()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74695

Introduced by commit 2a79fd3 ("netfilter: nf_flow_table: attach dst to
skbs") in v4.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8aecf0bbcc72605592134c917c222207d8f63ab0]
stable/6.18: [12afa450a6a6c0cce2c42b7545a9958f62d8a00c]
stable/7.1: [538e67e8c7889cf5f93951f5309d1bcb41f86036]

CVE-2026-74696: tcp: fix TFO max_qlen accounting across reuseport migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74696

Introduced by commit 54b92e8 ("tcp: Migrate
TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.") in v5.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0ab2ba83e35159d81cec830a92e885ecf8139be]
stable/5.15: [e98f0d80b9cccb5f828425d2004f9686e7d1ae24]
stable/6.1: [b6247e0f96bd825ffb2005257f6177b5e642dee6]
stable/6.12: [6e10ee56524a26b250229ad348637825646ddb88]
stable/6.18: [a66e869cf0c90c1e47ae75f72b6482acbfc808ff]
stable/6.6: [585fc5247d14939a561056aa2addd9b7c2b1f670]
stable/7.1: [d974618b2097453778389d385e3741629c40e0a3]

CVE-2026-74697: bnxt_en: Disable EOP for TPA on all chips to prevent
data corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74697

Introduced by commit bfcd8d7 ("bnxt_en: Add fast path logic for TPA on
57500 chips.") in v5.4-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3faf548a00f4c17100cc9204746975fa46a73b9]
stable/5.10: [68c181af7cd1ca9cbf29acd95911073bfd3c6397]
stable/5.15: [7aee22a35978b44784612c156e358e375ddf5d16]
stable/6.1: [410da4428b1f47bf9a84bdc0bcaa089d73ba2048]
stable/6.18: [aab3b5f4d8ec8598606ee011e219ef824ae25ca0]
stable/6.6: [b61c4911204a0a2f900e538d64ceb608f6c9614d]
stable/7.1: [c1962ab4645a914a91ff492735881150ddc8a79e]

CVE-2026-74698: net/mlx5e: fix BQL reset on SQ re-activation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74698

Introduced by commit b2588ea ("net/mlx5e: Implement queue mgmt ops and
single channel swap") in v6.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7386770be1bf810bcd6af39d1e4bfeab3408430]
stable/6.18: [88664c48d7d1eca8e1ac92da85c89c26af741cf1]
stable/7.1: [d2897717cd222e575599d903d885c48602699800]

CVE-2026-74699: drm/xe: Fix memory leak in exec_queue_set_hang_replay_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74699

Introduced by commit 1026c1a ("drm/xe: Implement
DRM_XE_EXEC_QUEUE_SET_HANG_REPLAY_STATE") in v7.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5f500161709f27719701334190dff2325868ef0]
stable/7.1: [410596743958fbddeb845ff3efe2645397d7c7e2]

CVE-2026-74700: net/sched: cls_api: Always acquire rtnl_lock when
destroying locked classifiers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74700

Introduced by commit 12db03b ("net: sched: extend proto ops to support
unlocked classifiers") in v5.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a347304b2ca1a5377d5bd2d8a72e4b4f12afe648]
stable/6.12: [b648c8a56531aeabd1c14f6b5cf1891e269b3756]
stable/6.18: [d6222af7274f08e7a1848131dc30319993d8f377]
stable/6.6: [34e77d8e3570f9df3952496ddb402833695662fd]
stable/7.1: [a81f9c44d87fb59d99fce72e29e02cab3a49a1c3]

CVE-2026-74701: net/openvswitch: check Ethernet header length in key_extract()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74701

Introduced by commit 217ac77 ("openvswitch: allow L3 netdev ports") in
v4.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf6f8b29befb92173659bcef6a441d274947bfae]
stable/5.10: [e85278afd4890dd190ba3c7a1b1a712b801c9fe1]
stable/5.15: [81f9b09f0ea3ba9ab966dd17e9f32625a14555e9]
stable/6.1: [831471718f6e19aed1a330b03b53190a90e06466]
stable/6.12: [0b60b55652ba772b173dddc63f3851e1d2dd5927]
stable/6.18: [a8139285c8925efe59af28a9169bb2fda91bff15]
stable/6.6: [d8bea341b183190ce6c055ab0e64ab78eb9a7290]
stable/7.1: [9b8cfbb58b85bfa7a78fac47fdc77396cd01f699]

CVE-2026-74702: vhost-scsi: reject feature changes after endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74702

Introduced by commit bf2d650 ("vhost-scsi: Allocate T10 PI structs
only when enabled") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42bc45df5905e2b7dccb72adaf7730f66cfbe03f]
stable/6.18: [a06e4611d45518896fbff4f45d9581578b107e91]
stable/7.1: [9a3eb77a612f9d158e4d27df43677a014e9cfa55]

CVE-2026-74703: vhost-scsi: Validate T10 PI scatterlist counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74703

Introduced by commit bca939d ("vhost-scsi: Dynamically allocate
scatterlists") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d876c493fc4b811941bfeb4c80beb2dfc4bf025e]
stable/6.18: [2417a498cf3fe64d06faf87e236eda98dd4f04e0]
stable/7.1: [f8fe3f8d342da750dd10361bf66009fd3072926b]

CVE-2026-74704: net/sched: sch_cake: drop WARN_ON(1) for malformed
packets in ACK filter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74704

Introduced by commit 8b71388 ("sch_cake: Add optional ACK filter") in v4.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a33516f9ef59ad11844d4fc152f889449b5daf3]
stable/5.10: [c1693b7844a6c06d31a565e5a494948034dfd235]
stable/5.15: [a4b52612004a5639c4bfc30ba93ba414b8326e2a]
stable/6.1: [ae1b2f8e21a41e7c7e75511bea0c4ccc59ec1bd3]
stable/6.12: [2504a76e5c0694e14e15562730e1339f2d9f9458]
stable/6.18: [cd2f1d9fe8a507c2dc86ad326fe221f121c47734]
stable/6.6: [0c4882bff34558d8d53fb04c3e96da5c327c7dc8]
stable/7.1: [a1ae353d8355407c1bea971d1c1af5e7f242bb7d]

CVE-2026-74705: udp: fix potential use-after-free in tunnel segmentation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74705

Introduced by commit dbef491 ("udp: Use uh->len instead of skb->len to
compute checksum in segmentation") in v4.6-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0f86fb36eb260abd10007b62c9dcc1028e03e61]
stable/5.10: [6a733a38b983d8c2e222f13968209010cf44de87]
stable/5.15: [19d89b13a43640b2da2f277ee462d919d988cb6f]
stable/6.1: [b3df61bb745eb5201eac22679a2839d4ccbf3442]
stable/6.12: [5161e67c561c4f28a5d9335a6e859b02511de92b]
stable/6.18: [64d322c288577793eedd352b96ef75234ed380fe]
stable/6.6: [1ae134c012e10384cdac420b5cc6e0615cde0b55]
stable/7.1: [588d4a6795d99d080f74ef0b5f391ea8c453ae5d]

CVE-2026-74706: bnge: Fix NULL pointer dereference in aux device release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74706

Introduced by commit 8ac050e ("bng_en: Add RoCE aux device support")
in v6.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb4298810e27e037d3ca07286ecbb97e89ba58d]
stable/7.1: [83ef2f3cab7fe6dd9155cd598dc64be524d963a9]

CVE-2026-74707: xsk: validate metadata when processing requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74707

Introduced by commit ca4419f ("xsk: Add launch time hardware offload
support to XDP Tx metadata") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [849b1664dbda1cf6c63e0fd4f9dec23782b8c851]
stable/6.18: [5fd121971912dee2f5af1efec64462ac722deb17]
stable/7.1: [0cc7aa6e0d19027fdd42e6fbd156267ac1e3bbba]

CVE-2026-74708: xsk: validate launch-time metadata size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74708

Introduced by commit ca4419f ("xsk: Add launch time hardware offload
support to XDP Tx metadata") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [439ce2dddf3d22129b9113a7881637256a35e936]
stable/6.18: [af511afa1d2977f384044df78d6fbf9fba653f7a]
stable/7.1: [bc63d47611c07b0d5d655fe1a590861931527920]

CVE-2026-74709: xsk: clear metadata pointer when no timestamp is requested

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74709

Introduced by commit ca4419f ("xsk: Add launch time hardware offload
support to XDP Tx metadata") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f60a67df8d3c862503bee62bada8e7089cba438]
stable/6.18: [0ba2e1eb07a826d021344e2f146b6716c58139eb]
stable/7.1: [eb4c613d4ebc3f664e70d572b8867ba114a8754e]

CVE-2026-74710: xsk: require at least 16 bytes of TX metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74710

Introduced by commit 341ac98 ("xsk: Support tx_metadata_len") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bb30b181d9f0484e141f8411e15ed906d5c6780]
stable/6.12: [21b8536aee819792f1b4b38b9aacf2a073025d49]
stable/6.18: [642c6e73fce17fdca93a5793c4d22359fda866d7]
stable/7.1: [cfb9d2976b277e554e28c165e3eff4b4a8ea10bd]

CVE-2026-74711: hwmon: (pmbus) Fix type confusion in notification logic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74711

Introduced by commit f469bde ("hwmon: (pmbus/core) Notify hwmon
events") in v6.4-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59bd68ab05a8f9c9a60b6ec44682084184803ff4]
stable/6.18: [821f6416e69782fa662aff94b5ea52c943042790]
stable/7.1: [0b121de89a99c54bcf516999b04e8531c84f08d5]

CVE-2026-74712: vdpa/mlx5: Fix buffer length in create_direct_keys()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74712

Introduced by commit 0071b13 ("vdpa/mlx5: Create direct MKEYs in
parallel") in v6.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [727e1f569855df83579edbd73dcb4a0723543a12]
stable/6.12: [ec3bb289cf19d526224117d5d450a5fd9cbd5ab2]
stable/6.18: [cde8931a25392670dd59a0acfcab87a830ab66c5]
stable/7.1: [6c8a9f7bc00301e533a5366384f3070a8e7f8430]

CVE-2026-74713: vhost_iotlb: bound map allocation in add_range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74713

Introduced by commit 0bbe306 ("vhost: factor out IOTLB") in v5.7-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ed35ac7f3fe2b4396bdd29ac3a7f0ebc0829e94]
stable/7.1: [ae128dd19040ee06a4f8143c7ced4d18080d7a9a]

CVE-2026-74714: bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74714

Introduced by commit 04c7820 ("bpf: tcp: Bpf iter batching and
lock_sock") in v5.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5fd3f514e27db1f05fbd72ba615d74941e23c51]
stable/6.1: [cc0295f89296ed351fc4b0b48fee887ba02c5d24]
stable/6.12: [7d2b60a4bc0499f62ff8520af6309bbe170882fd]
stable/6.18: [cefcbbe20846a45f9a7dae868f7ef1000953e2df]
stable/6.6: [ddbe966b5d1fe212ada749bc3d0b410f1a7dea74]
stable/7.1: [97e74d3e45d653c07c2d406fc530a9bbe3df8396]

CVE-2026-74715: bpf: Fix netns reference imbalance in conntrack kfuncs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74715

Introduced by commit aed8ee7 ("net: netfilter: Deduplicate code in
bpf_{xdp,skb}_ct_lookup") in v6.0-rc1.
Introduced by commit d7e79c9 ("net: netfilter: Add kfuncs to allocate
and insert CT") in v6.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdeba03fea78407a8c52faa99177c9f7f29f90eb]
stable/7.1: [e5e060eb63d10b41ab60fd955649479d99b38210]

CVE-2026-74716: accel/amdxdna: Fix locally exploitable BUG_ON in
amdxdna_insert_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74716

Introduced by commit e486147 ("accel/amdxdna: Add BO import and
export") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a19f7ab5972ef608b31ae921419bc3e04b3f8ad]
stable/7.1: [13339132d89d00b513dff0730bff3a313b9b13b5]

CVE-2026-74717: net/mlx5: fw_tracer, return NULL on create error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74717

Introduced by commit fd1483f ("net/mlx5: Add support for FW reporter
dump") in v5.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af39eb111ce6b5eba9c08513b62c4868eb7e7fd5]
stable/5.10: [47fe0d2571e5b446a0f0b0c1d6b99f55e51f5cc0]
stable/5.15: [ee41ea49c4ab0e4015919f52ad23ec251d3b39d3]
stable/6.1: [04599570c3a18f9ae7aad36825eb46f3dcd2c4e3]
stable/6.12: [b1d6375b9a63c9dc7e5e780d3ea9b126fe30d6cb]
stable/6.18: [80094352bd40ba54a33731f9c22872493983ed6d]
stable/6.6: [9a416f000285a94c1b723877547981dec8132434]
stable/7.1: [4aafa600d93e9551c1f24e785d57cbd4adf021d5]

CVE-2026-74718: devlink: fix net namespace reference leak in reload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74718

Introduced by commit 2edd925 ("devlink: don't allow to change net
namespace for FW_ACTIVATE reload action") in v6.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c4dac9bf1d2ac31da63b794bdec697777cbd0fd]
stable/6.12: [bf0797b92be591ac71d7c0f610e695caca3c72c9]
stable/6.18: [7b02c6d2a3cd2cd669f5c16685779f84328ae60c]
stable/6.6: [7b6552e53426ea0539c667bbc5a524fdf7feae6f]
stable/7.1: [eda60c85b4f4c7d66b7141a5fe020b1a7f395341]

CVE-2026-74719: net/smc: fix qentry overwrite for CONFIRM_LINK and
ADD_LINK_CONT in smc_llc_event_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74719

Introduced by commit 0fb0b02 ("net/smc: adapt SMC client code to use
the LLC flow") in v5.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [976245094925bab9bc39366b2e9ab44ffcde61d0]
stable/5.10: [e384f3cba6ea709f5b2272b1770db4ce14047f78]
stable/5.15: [a1e980d7a9e7ee6faf4f5fd7b450413b969af26d]
stable/6.1: [e0eb87677c76b157cdf8eb7c1f19e56227165a33]
stable/6.12: [c23c409228629107203d3c3e95fff1473173f1a6]
stable/6.18: [10cb31b2b74cb664c6c95cf72364d7d5c483ab82]
stable/6.6: [06734dfeaeba886aab1bf147249195b888ac3e4d]
stable/7.1: [bfc336a9fbbf09805f3dfe25c195a4db90af2846]

CVE-2026-74720: bpf: Preserve pointer state for commuted arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74720

Introduced by commit f4d7e40 ("bpf: introduce function calls
(verification)") in v4.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4c6f804b44c5c790269b25e0e61cf4e9f117c86]
stable/5.10: [86b203aadc2930e0a4f9c6277b5b80ff3664c472]
stable/5.15: [8109c25e0c41f5f19a1c2380bb49c991a877494e]
stable/6.1: [d1959028190a7649b926f5867a58de5fe221b23c]
stable/6.12: [29c239f8dbec5ab33a61796724d189bddee6cd4b]
stable/6.18: [db6382ed3361bdd8129572a3423956cba1dae829]
stable/6.6: [8cb23101a3fcc7432b451ea3d0f14a90711f4acf]
stable/7.1: [eaffa1495e4fe6330aeff9f323ea3d48b01f118a]

CVE-2026-74721: accel/amxdna: Fix page-insertion errors in
amdxdna_insert_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74721

Introduced by commit e486147 ("accel/amdxdna: Add BO import and
export") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d51e0fd3e698919d2adeff71936377f0c0d4aa0]
stable/7.1: [1501e4d07c6fee0d50531a0d1cb2be01a63e6e75]

CVE-2026-74722: btrfs: fix memory leak in btrfs_do_encoded_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74722

Introduced by commit 7c0c726 ("btrfs: add BTRFS_IOC_ENCODED_WRITE") in
v5.18-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2a4e4e626b2f4670b69b430c357f03f53eb6632]
stable/6.1: [0f0da96ccb1b9f35f4d3d4540dcaab0969d9d6b0]
stable/6.12: [20c0eeb4313f9f89d47b80b672b5846f9827cb31]
stable/6.18: [24a8f2c29aebb753ccb962fbb25bae18d7978f6e]
stable/6.6: [e2c7e88815edd5ecfb88e7660ab9fd42bda6bc47]
stable/7.1: [60b50ceba6243802f8d2c0a9a7c2d549a93b1d64]

CVE-2026-74723: btrfs: lzo: reject inline extents without valid headers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74723

Introduced by commit a6fa6fa ("btrfs: Add lzo compression support") in
v2.6.38-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fa78ef637deb5dbe341582f88553a4bce496de0]
stable/7.1: [fc50b475ad27f50b4dcc98fc4c44e8802bc1b248]

CVE-2026-74724: ipvs: avoid out-of-bounds write in ip_vs_nat_icmp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74724

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [646922a0379496154e8c8faca4f8e2fd9100cacc]
stable/6.1: [3b8f79af0e98f27b932b0b416e9c52b692d31ff9]
stable/6.12: [be65fa324640c7a95e30b146159a2be5cc73f22e]
stable/6.18: [a69a4b3fff5814d079beff9a1e9d369994b2ed47]
stable/6.6: [3c779b258c9c3c3567af68d4f45c2f751f35bd0e]
stable/7.1: [243d0187ec4c3837b9b0004f18d1068e46115760]

CVE-2026-74725: enic: fix tx_hang_reset use-after-free on device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74725

Introduced by commit 937317c ("enic: do hang reset only in case of tx
timeout") in v4.4-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec680ea4ba1bca92a767fb7e7869758bfdd886e3]
stable/6.12: [8619865f34fb3b130b567855382a5c4aadd522b9]
stable/6.18: [e506e704b74748ffd0e1c92a7453ca2a959f832b]
stable/7.1: [4f3464fc6c1f26afc504fd525c574f2bc14c9d42]

CVE-2026-74726: bonding: alb: re-check primary_is_promisc under RTNL
in bond_alb_monitor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74726

Introduced by commit d0e81b7 ("bonding: Acquire correct locks in alb
for promisc change") in v2.6.24-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [683c6ba6e58e6ed1037831ea97dd58d9c0e76b8d]
stable/5.10: [f7668762bf5fd6db9397de5c0514407489d9d815]
stable/5.15: [09add8d5cfa9c46828f51eaad162c36e86366b71]
stable/6.1: [b82f51681a7a88c7d3c865e817a3340d42b5fa2a]
stable/6.12: [dccec0227ed8d9e36936d66e256b957dc2858468]
stable/6.18: [2faf75a8a06504071b4c0aea7e45a9cc49a4e187]
stable/6.6: [dd148539fb4741d01c06b7d2c8bd84b01920756c]
stable/7.1: [257c4a3a34d8f51efb00f35375a0c6ce3c8f6ce2]

CVE-2026-74727: ovpn: skip rehash for peers already removed from by_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74727

Introduced by commit 1d36a36 ("ovpn: implement peer
add/get/dump/delete via netlink") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33ec10567fe14456063daf549fdf1a4f53448e4c]
stable/6.18: [d20c181088984b6eaa8d7fe7cb5ab3510988df59]
stable/7.1: [66745480298775f188b2f5ad266643e85a90f73b]

CVE-2026-74728: xfs: handle NULL b_addr in xfs_buf_free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74728

Introduced by commit 5076a60 ("xfs: support in-memory buffer cache
targets") in v6.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d852729c5f4f830fbe7413df032e29459b3daf83]
stable/6.18: [ccf6738adcafa5ddbddc4e71b45d8a51b86643c7]
stable/7.1: [3aa0c1d23ee1b9d9b340fb2f4736536e1408d706]

CVE-2026-74729: soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74729

Introduced by commit 3772e5d ("drivers/misc: Aspeed LPC snoop output
using misc chardev") in v4.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1acef6d85bfd98bd9dfe1f08bffa397a4dda8a6f]
stable/7.1: [131ab677b03349a5ae48da8722ec7075b37ec66e]

CVE-2026-74730: NFS: Pin the 'struct nfs_server' during a FREE_STATEID call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74730

Introduced by commit 7c1d5fa ("NFSv4: Convert nfs41_free_stateid to
use an asynchronous RPC call") in v3.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf616096a0f3a2b60f7d68b6b39674a6867ded9c]
stable/5.10: [ed2f92ce2fc48463c41e0e540b9a3454889e8af8]
stable/5.15: [d858ab09e787106432d4d9830bad9dfedf02f890]
stable/6.1: [af62f1af182d33a0de38308c012841885d8ab92e]
stable/6.12: [ed1161ab6239761958b38d5667225634fc2be894]
stable/6.18: [d71dfffa512e71b166a889484e4c3b148a9a3af2]
stable/6.6: [caee6a68ffaa5016dfc01cd0b3dc1896a32e3abd]
stable/7.1: [80ed3d762628b36c9e4b22fac7c65b72ef3b13dd]

CVE-2026-74731: sched_ext: Skip sub-disable teardown for never-linked
sub-schedulers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74731

Introduced by commit 337ec00 ("sched_ext: Implement cgroup sub-sched
enabling and disabling") in v7.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c13364db9c9a43ed286f3a8d0fb9477b1adc43c]
stable/7.1: [6428093a4a986c38c9089b5eb32b56d914ef437a]

CVE-2026-74732: drm/amd/display: Check for tg ops in dce110_set_avmute

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74732

Introduced by commit 414da24 ("drm/amd/display: Add AV mute wait
frames to dce110_set_avmute") in .
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/7.1

Fixed status
mainline: [3141e3d61469bba2624a91c5e2407f110b33b29e]
stable/6.12: [853c2d31408bd45dcf92d0eb1f06eb439a56cf04]
stable/6.18: [d089f32d34f821c8f0ef23d5fcd77bd43c1b3b92]
stable/7.1: [5edbb409b0bc5001195f4b7cfca19122361211a1]

CVE-2026-74733: gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74733

Introduced by commit bfc6444 ("gpio: pca953x: fix
pca953x_irq_bus_sync_unlock race") in v6.10-rc6.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [9dc325327babe7f159e84cbe9380a45342da0585]
stable/7.1: [e6a2f5f845f50b0c4299bace5111f56d3390a090]

CVE-2026-74734: firewire: ohci: fix NULL pointer dereference in
ar_context_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74734

Introduced by commit 5716e58 ("firewire: ohci: release buffer for AR
req/resp contexts when managed resource is released") in v6.5-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42d217add8d80d6e7d9f58f80d11ea9b07ea113e]
stable/6.18: [ed5470771c7ed7f959230c4697f316af83426a90]
stable/7.1: [7d228ba43279de2d191f25e139fad166409c2c06]

CVE-2026-74735: l2tp: fix tunnel and session refcount leak on seq_file release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74735

Introduced by commit 0e0c3fe ("l2tp: hold reference on tunnels printed
in pppol2tp proc file") in v4.17-rc2.
Introduced by commit f726214 ("l2tp: hold reference on tunnels printed
in l2tp/tunnels debugfs file") in v4.17-rc2.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9006c116dd111d457bf5d074990210f70a4ad2c8]
stable/7.1: [ebe2774e956482dd3c70b8991f6f7654356339e6]

CVE-2026-74736: net/sched: cls_bpf: reject dev-bound programs bound to
a different device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74736

Introduced by commit 2b3486b ("bpf: Introduce device-bound XDP
programs") in v6.3-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [120977e2c096deea4e866e4273be9220b957c29e]
stable/6.12: [daf546ab5763ce6a18280cb4db060e836c515301]
stable/6.18: [adb3e7c26a51a10d94a241c6de7a81a2863dcacf]
stable/6.6: [ec5a552f4b2d841c6c021752450716e1a9676661]
stable/7.1: [5685bbbd3cbfbeb0de96a1d275a5ca073dfebb5e]

CVE-2026-74737: net: ethernet: ti: am65-cpsw-nuss: Fix port_id
extraction from SRC TAG

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74737

Introduced by commit 93a7653 ("net: ethernet: ti: introduce
am65x/j721e gigabit eth subsystem driver") in v5.7-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36a05d2820077bb3955acb8111e1041d39148037]
stable/5.10: [14fc40bf28390e0ebee6a072457c36b82c614100]
stable/5.15: [1c0e35ce761131f82062222779d8574849790892]
stable/6.1: [9a220225efd6f58350bbb53fe70bdec08519267f]
stable/6.12: [46a8e084a159e638ac2728e96980b65d752d65fd]
stable/6.18: [72e4e3d7efc3b7d85f86abbe8b94f8e45074abe3]
stable/6.6: [551688b410d3fb0dae7739724422f268cd9446d6]
stable/7.1: [914e0100df3435bd14d09f397238e891cf9b7dce]

CVE-2026-74738: regmap: sdw-mbq: don't call an unset readable_reg callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74738

Introduced by commit 5bc493b ("regmap: sdw-mbq: Add support for SDCA
deferred controls") in v6.14-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00268f9452d2a0d660aa9c1bb0ca07a994af6a4f]
stable/6.18: [6cf600b276a55a6481462830607a611f32e737c0]
stable/7.1: [5bd8e897ecf558507142f4553e4526adfc1d6482]

CVE-2026-74739: net/sched: cls_u32: skip hash tables in u32_bind_class()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74739

Introduced by commit 07d79fc ("net_sched: add reverse binding for tc
class") in v4.14-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d3724e616faf952c3adcf8414fc21a828ef3709]
stable/6.1: [ec5f3005586a785689fd568361b0c5925cb1548b]
stable/6.12: [594a064d603202b9ee21e07679d854e5c1750cc4]
stable/6.18: [31f26a95eeee926946809ac456c61a3217936a62]
stable/6.6: [19d114b93c94bdef70496f26685c2a6b242f41b3]
stable/7.1: [e71f8e9ed6f311410b14741f6012afe01869c0fa]

CVE-2026-74740: net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74740

Introduced by commit ee3bbfe ("net/sched: let actions use RCU to
access 'goto_chain'") in v5.1-rc3.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f60b396ee174206fe08ebf997d16cd3801b77b22]
stable/6.12: [1ec48b6715c29b20105e3485206602cff6c51ae5]
stable/6.18: [abceabc4408fca6a9dd52611f5d197dec9390d63]
stable/6.6: [91d55fd1fdb85c8371ca8793c788ea7d5192383a]
stable/7.1: [6b70886ebc428eed43a069c8944a931b5fb3f4e4]

CVE-2026-74741: net: ngbe: fix NULL pointer dereference in non-MSI-X
interrupt enabling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74741

Introduced by commit 4174c0c ("net: ngbe: specify IRQ vector when the
number of VFs is 7") in v6.16-rc5.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f3a13e0bb5ebcc1ca2dfda42ea40b9f3c2be6ea]
stable/6.18: [cef4c5b9aca24651d069adf9462b221df6a2a669]
stable/7.1: [0ab482b2195edc000262f0eae1cdcb416b8f335d]

CVE-2026-74742: veth: fix queue index used to wake the peer txq in veth_poll

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74742

Introduced by commit dc82a33 ("veth: apply qdisc backpressure on full
ptr_ring to reduce TX drops") in v6.16-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [60db47f02bfa2aa688938aa199117ec4f8e31d23]
stable/6.12: [b662a1fb4f3a5ea19bac24eea8315b1d05be51e7]
stable/6.18: [73f8dd22b1e533a99ecc3f9b5de6c6daccaecace]
stable/7.1: [90bb11fb29d3c55a2c46dc7c386d096b286e7fcf]

CVE-2026-74743: macvlan: inherit needed_headroom and needed_tailroom
from lowerdev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74743

Introduced by commit b863ceb ("[NET]: Add macvlan driver") in v2.6.23-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cef51860becd9700217c81732ca1eb1ea6ed6fe1]
stable/6.1: [8cd90e850e434577bf6774778657d26d6995e53f]
stable/6.12: [8f6a05dbac05725e0786701eb04778c5bdbe4eaa]
stable/6.18: [96fa90b74385b7f2b0d97251dd43d5ee6ca44668]
stable/6.6: [28afc87bd8da0b3348bbbd834c8a89e83712cf5e]
stable/7.1: [bc9a00fb78e32bccc39d763bfd13a450705bac5d]

CVE-2026-74744: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74744

Introduced by commit 2ad7bf3 ("ipvlan: Initial check-in of the IPVLAN
driver.") in v3.19-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e16e960d55a40d36bd7c2494cc005e757dc9a1ef]
stable/6.1: [af602c4d0ee548da18e2409b4b4da1079625a372]
stable/6.12: [c0fbe31f6b20ade0465130685859faa5c86fda59]
stable/6.18: [5f33188457bbcc1b11ca87084037963c516ed3d9]
stable/6.6: [f3c17ff65f54781cde696e16a6c577615ed735aa]
stable/7.1: [5c2ca77212eb38559b0353b8363b7a84f4b019dd]

CVE-2026-74745: eth: bnxt: avoid deadlock when canceling IRQ affinity notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74745

Introduced by commit c214410 ("bnxt_en: Add TPH support in BNXT
driver") in v6.15-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51e96fa31f7e7eac2cba8f854e24d36600cc040b]
stable/7.1: [8b1118fc5a5d2cdc21cc07b5106921ad4f77c544]

CVE-2026-74746: netfilter: flowtable: publish GC-visible tuple last

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74746

Introduced by commit ac2a666 ("netfilter: add generic flow table
infrastructure") in v4.16-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2014ac62df9d45bb9a004a043e85df7be09ed780]
stable/5.10: [0a00254585827f1695aa2700114af622ea754cfa]
stable/5.15: [be345dcbddb4643a54252b954af974b16eda8f91]
stable/6.1: [211ee5d998d92a7d548811939c65942d06c146e4]
stable/6.12: [972fdf7c4f5c282a239c88fea614b056c33dc025]
stable/6.18: [d9d3050a70efe217e73a0751e55fdae6a7092620]
stable/6.6: [d37917e7bebe078f3c17e47fd6fc1c9f6e8497b2]
stable/7.1: [d16b71231e65cb05daea2b45701fcf09cef041e7]

CVE-2026-74747: ipvs: revalidate ihl to prevent out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74747

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d93660df4dd1d116f608ada4a29a80a5d6f0a6ed]
stable/7.1: [5365f012451fce2453f13a568dcb72ea534c1e4d]

CVE-2026-74748: netfilter: ipset: fix refcount race between list:set GC and swap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74748

Introduced by commit 9076aea ("netfilter: ipset: Increase the number
of maximal sets automatically") in v3.8-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c88868271653537ed443272dd8e7d13634d214b]
stable/5.10: [97a01de0c6321b7210d30d0a4d60f10f561097c7]
stable/5.15: [c21afc7c216a4d257a4f3f300e0791890bc846b9]
stable/6.1: [b0aab9dd1a348b99d75ff52765719d0cc2050630]
stable/6.12: [20cb13a523f0a05cb2d0a7d72abae687683712e0]
stable/6.18: [cb20da33839f28f590c99f16bafaa6151451c0e8]
stable/6.6: [b891e7a6bb06e0f6560e5932665ac660acd12225]
stable/7.1: [24ffcb1e1688c55fd2a505f064295cd28eac546d]

CVE-2026-74749: rseq: Prevent hard lockup on granted time slice extension

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74749

Introduced by commit 15dd3a9 ("hrtimer: Push reprogramming timers into
the interrupt return path") in v7.1-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ada54c2ba652348c590d1ace6a2f4ff77cbbf809]
stable/7.1: [8bbf4405050bc4f98be68082a20efa081ea8ad9b]

CVE-2026-74750: ovpn: defer key slot crypto freeing to workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74750

Introduced by commit 8534731 ("ovpn: implement packet processing") in v6.16-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2da3dfa1ddfe55a065f484750c83660e3bd4ac00]
stable/7.1: [0f77ed5ee91946ea63e29f2e0ff9dc9e722d8da3]

CVE-2026-74751: riscv: lib: Fix ZBB strnlen reading past count boundary

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74751

Introduced by commit 5ba15d4 ("riscv: lib: add strnlen()
implementation") in v7.1-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d588c684833e678a0008eb69c33190f01a65f4b]
stable/7.1: [e697e30f3dd2da3a1df7dc0980546d5b53aea4b6]

CVE-2026-74752: sctp: validate cookie AUTH state before use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74752

Introduced by commit bbd0d59 ("[SCTP]: Implement the receive and
verification of AUTH chunk") in v2.6.24-rc1.
Introduced by commit 1f48564 ("[SCTP]: Implement SCTP-AUTH internals")
in v2.6.24-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dbb44d88b1e94dd31fe43588af7437b34b44d56]
stable/7.1: [88619b117be1daf633ce32210570ce35a0bd1c98]

CVE-2026-74753: perf: Reject exited events as group leaders

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74753

Introduced by commit 037a3c4 ("perf/core: Detach event groups during
remove_on_exec") in v7.2-rc2.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6 stable/7.1

Fixed status
mainline: [fa091f46c3833fb22384f10eade2b4e1e1d0b278]
stable/6.18: [7a03413f31c196ab3894f988cdce0bb47b4fec42]
stable/7.1: [7ce010275c531475f9d6e7efb11b9e522c74ed2e]

CVE-2026-74754: scsi: core: pair EH runtime PM get and put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-74754

Introduced by commit ae0751f ("[SCSI] add flag to skip the runtime PM
calls on the host") in v3.3-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [872f486259ae0bc6b73ca4735a15d013241f73e9]
stable/7.1: [e83eed1bea142c8fe852fd53156845b88252ecd8]

CVE-2026-80519: ovpn: finish crypto callback cleanup before peer release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80519

Introduced by commit 8534731 ("ovpn: implement packet processing") in v6.16-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e163917a86c6adfbe150e13f4c73653a54616de]
stable/6.18: [a3a676495c6419e0cca04d6a67227604e92a3d5a]
stable/7.1: [4b0de8be288f5fbec5d8ee64ed4e8b14bf19b517]

CVE-2026-80520: ovpn: fix NULL dereference when killing missing key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80520

Introduced by commit 89d3c0e ("ovpn: kill key and notify userspace in
case of IV exhaustion") in v6.16-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41d44ac7a61e2f74453af40d4fe1b82af9ea0ada]
stable/6.18: [a47a080d06ee9d94dc6a2da0fc2b9beeeedb92b3]
stable/7.1: [acf32a5dff082044cf0fd9492f3c10b7357c15ee]

CVE-2026-80521: af_unix: Unlink scc_entry in unix_del_edge().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80521

Introduced by commit 4090fa3 ("af_unix: Replace garbage collection
algorithm.") in v6.10-rc1.
Introduced by commit 4090fa3 ("af_unix: Replace garbage collection
algorithm."). in v6.10-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [594d905195024b228c962627ae5ae7c17bd582a4]
stable/7.1: [e3702470ced94fad74d71e2232f022d2eb752a6d]

CVE-2026-80522: crypto: tegra - fix rctx->cryptlen calculation in
tegra_gcm_do_one_req()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80522

Introduced by commit 0880bb3 ("crypto: tegra - Add Tegra Security
Engine driver") in v6.10-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [360f2974fcea49c61f6d6f81554741a9eeee7168]
stable/6.12: [cd6991001bf0681ed0bcf21f9cc3d261d749b2bb]
stable/6.18: [99a18e1d979e0fad3aaf9c65ae6696897c1d9869]
stable/7.1: [c6237834d9994de209cb90c7a2c461247bce8e90]

CVE-2026-80523: clk: spacemit: k3: set hdma clock as critical

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80523

Introduced by commit e371a77 ("clk: spacemit: k3: add the clock tree")
in v7.0-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb525edd48907795c0d4e498ff57ad168070b289]
stable/7.1: [bb81b608db6342e5adccb6aabe900d739dc7cddb]

CVE-2026-80524: optee: ffa: Add NULL check in optee_ffa_lend_protmem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80524

Introduced by commit 2b78d79 ("optee: FF-A: dynamic protected memory
allocation") in v6.18-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [650c88738ae8976f46ba71b24dd8aa311adc6fde]
stable/7.1: [94bf4fe0e46349c4e73df66dcda073187bc90cc1]

CVE-2026-80525: ASoC: SOF: ipc4-topology: Refresh copier IPC payload
before widget setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80525

Introduced by commit e9c6b11 ("ASoC: SOF: make dma_config_tlv be an
array") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c0e418dbcf0582bf80d8dbfd9b306607c065992]
stable/6.12: [decb87e76716d11d846c9c055e309c8ff90d7656]
stable/6.18: [2a7d8fc0fd50e7a2020989d9840cabb74c0282e3]
stable/7.1: [574498e56024082a0da68474ad4526d250732411]

CVE-2026-80526: ASoC: tas2562: Validate values for volume writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80526

Introduced commit is not determined.Fixed in v7.2-rc6.
Affected file was added by c173dba ("ASoC: tas2562: Introduce the
TAS2562 amplifier") in v5.5-rc1.

Fixed status
mainline: [8fb41964f7e4e4207c8999af2056894caa7a252a]
stable/6.12: [20bdbb1376457ecbf418bf677fd285820d1fc011]
stable/6.18: [db488d653d896fcf9ac87e15239924c2928bbc3c]
stable/6.6: [1f389ecd0c35e9e281036e44c121df904f3164c1]
stable/7.1: [c37a0461c0d0a70c5de4fdbd70449a7f53c12dda]

CVE-2026-80527: ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80527

Introduced by commit 0a454bd ("ceph: reorganize __send_cap for less
spinlock abuse") in v5.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50958bb928bad3bdba9e5d1b7ff4bbadcf6951e6]
stable/5.10: [b5661524c5a45085a866864ca9b8ae2513dfd67a]
stable/5.15: [5e84bc6f67e19fdd192d8b215de728acbfc12572]
stable/6.1: [5fedf279a1ea369d39c8b06dd4547cdc576065d0]
stable/6.12: [fcce1b3be6d286aa80831e730289f4c062053ae6]
stable/6.18: [a3bc6b3e9ef3f5f5cb85a902a30a090c7931127c]
stable/6.6: [e05c315b4da0c16ea800ee4b2cb6c617f586d1b5]
stable/7.1: [9e55fe24c548ad3163903eb58bb002d28d32a630]

CVE-2026-80528: ceph: avoid fs reclaim while using current->journal_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80528

Introduced by commit 315f240 ("ceph: fix security xattr deadlock") in v4.6-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b602344a49e039e792ce5a8923bcc61412ee134]
stable/5.10: [ca5fa2380dd90a0adb01580fa6225025351a90f6]
stable/5.15: [00c12f57a87f537fa8779258fb3a03003a99963e]
stable/6.1: [4dbb2c02558e71f93510a6461d7e798b67426b49]
stable/6.12: [47b745747b3aa39064724a642884f9df924ddf20]
stable/6.18: [79d95b43ca090426399651ed580dd9bf2db36ab8]
stable/6.6: [c8a21660c3b90864c391164eea5622e7b5b2897c]
stable/7.1: [b6a0989613072499633e761a1536428a466de7d3]

CVE-2026-80529: xfs: don't swallow dquot recovery verification errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80529

Introduced by commit 9c235df ("xfs: dquot recovery does not validate
the recovered dquot") in v6.7-rc3.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [e2b4a856085e9bd939bde2dee0d08b1d41babde9]
stable/6.1: [e506e127fcb4e2bad1045805f1740b395eea9618]
stable/6.12: [a233b3362a3c7bf23f5143b4ef4b17ec337fcb4d]
stable/6.18: [38a4dbe588bd028a07a77dc5cee62ee3ce21e87d]
stable/6.6: [5b756fbb60b5d26063f46a11a3c7daa7eb616d79]
stable/7.1: [36a31b12540c0a0a3b77a01fda86de646f2961fb]

CVE-2026-80530: xfs: fix exchange-range reflink flag clearing issue
with INO1_WRITTEN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80530

Introduced by commit 966ceaf ("xfs: create deferred log items for file
mapping exchanges") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2d5a81dae385333f9734910277fbf94c78bd17f]
stable/6.12: [2efbd8890b53f4756fdc7b0ef346fa514ffb7d66]
stable/6.18: [0f27b22343b63e10773e6781344640c2c753eec3]
stable/7.1: [03c9c9116e6da641424681f705698d7f5e2128e0]

CVE-2026-80531: xfs: avoid UAF on sc->tempip in xrep_tempfile_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80531

Introduced by commit 84c14ee ("xfs: create temporary files and
directories for online repair") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c88e10d12de9ca7cbed1467bb1b52310101bff8]
stable/6.12: [08a20776ce33a2a52d856911e447c59424f0465a]
stable/6.18: [cd1f876d1bc2e94f271e07c606cacd85b109108a]
stable/7.1: [96246a3200d32a43766152e56bc7ae2d93604d74]

CVE-2026-80532: xfs: fix another iunlink infinite loop bug in online fsck

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80532

Introduced by commit ab97f4b ("xfs: repair AGI unlinked inode bucket
lists") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d67c6b99f1fc07c64b97fcbc974c6f1ada7f622]
stable/6.12: [24aec8c88539a382355761a9b924046885b6be40]
stable/6.18: [b6baf0db357fb84f3f3cfd33383a00de71a5a1c3]
stable/7.1: [23690064f235a88a00c04f2e49f36bfb54ae560d]

CVE-2026-80533: xfs: don't walk off the end of a null sc->sa.agi_bp in
AGI repair

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80533

Introduced by commit ab97f4b ("xfs: repair AGI unlinked inode bucket
lists") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e96a00e0d3a00be6e4f368b2f18e2d345f813ce]
stable/6.12: [43b4ecbc948a2e441804c9d7b772deb6b2e44e3d]
stable/6.18: [c36d7f68f1c2e7e528ad11044a0bd6a3016a6a03]
stable/7.1: [a6cfd0e4bb1e5f4dd2a67fa99eab36bda47cf081]

CVE-2026-80534: xfs: fix ilock leak on error in xfs_dq_get_next_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80534

Introduced by commit bda250d ("xfs: rewrite xfs_dq_get_next_id using
xfs_iext_lookup_extent") in v4.13-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63320a0f70f66f311f4bccff3af0719c2119f46c]
stable/5.15: [6401b99a285cd4cfb2949ba44675541b91ad7e4f]
stable/6.1: [0865e4fca02e418fd2423fae9a887dee87b778a1]
stable/6.12: [e270d539b8a2e0cb8f617fee47a7b083c0088361]
stable/6.18: [514a5d42d4188fc5f1499a8d654c717ebf981193]
stable/6.6: [ed8bfb43de71213cfdbbe833b2c2817250e18b1a]
stable/7.1: [08bed2b67d2ee79d3e138c344d8dcfa4c9b26a38]

CVE-2026-80535: xfs: don't double-lock when deleting a
self-referential directory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80535

Introduced by commit 3f31406 ("xfs: fix corruptions in the directory
tree") in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fc643fb86599e29b38e7b2c2680b4b15bf8f772]
stable/6.12: [17bc347cbdfb125eddac0a815b1f6c1f6eb56676]
stable/6.18: [ce2a7006ec5ed88db1b1669124ec85bc1714ccaa]
stable/7.1: [c575904471570e69bce40fa638365c6c0403e2ff]

CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80536

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [813f8136a2ce1fee266d02a7df73db6e8a541604]
stable/6.18: [f8288214459ead7e87d26e5822f62c14a4f2ed6b]
stable/7.1: [edaf5b6bd625356893da20d69a259b34a9de2694]

CVE-2026-80537: xfs: fix off-by-one in rtrefcount btree root level validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80537

Introduced by commit 9abe03a ("xfs: introduce realtime refcount btree
ondisk definitions") in v6.14-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc3144da377de5fb422d44a2311f978623f7c900]
stable/6.18: [8a0ecae2ecda9f9a83a496ed05c42c4b1f5c3f2d]
stable/7.1: [ccebfc309441e0b37b2e6ece90f18810a489d326]

CVE-2026-80538: xfs: propagate errors from xfs_rtginode_load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80538

Introduced by commit ae897e0 ("xfs: support creating per-RTG files in
growfs") in v6.13-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7e53968cb8882c2d276429ea8550848a4940874]
stable/6.18: [ec19cea4ef1ce9d6e2e3f7e9e7bf88ede31176e7]
stable/7.1: [61c5165f02deb2eed9b6b539bb279e6629fee652]

CVE-2026-80539: drm/amdgpu: disallow multiple FENCE chunks in one submit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80539

Introduced by commit d38ceaf ("drm/amdgpu: add core driver (v4)") in v4.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [931cd1d1baeae68e8eb2c23bc1f3d8934dca6241]
stable/6.12: [5f46322e0b84af29e10eb951ff45bd6ea40640de]
stable/6.18: [71aa45f7bfe46fbc6f51e7832573ff49b6005fea]
stable/6.6: [070229262ede37d17c4ea596650deb6e5eb5d106]
stable/7.1: [e3ee74d6dbbe409eb99546a7b0a02b2782f9021d]

CVE-2026-80540: drm/amdgpu: Fix UVD decode image min size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80540

Introduced commit is not determined.Fixed in v7.2.


Fixed status
mainline: [b8bb9ba3f101a1b0011f785a577a4a0a38371174]
stable/5.10: [bc7397a033ac52f6d8c9bb6510d61694b2a3fce7]
stable/5.15: [d058f7a6709441afe1784eecd8c0643dd84750bc]
stable/6.1: [b7549e3f96c78921751c4b3e69af729662130d83]
stable/6.12: [271a7da84a6262a09de549912dcf6a749d169cb6]
stable/6.18: [25ee120f3803ad9e416ef9f76f4c3234cc4d645b]
stable/6.6: [60539d517e8439621532d8c01091ac049c596b4b]
stable/7.1: [5cbd8af02b0b9c8723fa30edcf6fccab5170af8d]

CVE-2026-80541: drm/amdgpu: validate GEM_CREATE domain combinations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80541

Introduced commit is not determined.Fixed in v7.2.


Fixed status
mainline: [5e9d136ad74df4edec67e502ce267597064d8f86]
stable/5.10: [5c73485af7ad9c3ae592db3481f370bc07705391]
stable/5.15: [584e3d47736fe2e7184ef3fc16b00b41485f96c6]
stable/6.1: [66133fc05c3af002f45de8a71b833c026ccbfba6]
stable/6.12: [493355096e397f9217b41c8574ed2784c7351443]
stable/6.18: [220aa2589d7321fb68d2e8597862711b5f22ae0b]
stable/6.6: [ce5da474c3ddf7cccec5dce6aa4296297dd7caff]
stable/7.1: [80f0b53860d02577709d69a312a29ca674b9297c]

CVE-2026-80542: drm/amd/display: Fix NULL pointer dereference in
amdgpu_dm_crtc_set_vblank()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80542

Introduced by commit 34d66bc ("drm/amd/display: Fix Xorg desktop
unresponsive on Replay panel") in v6.18-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [f2a1c4c6fe0a6fcde02e59dde546dba28d283635]
stable/6.18: [5045fb4c70bfde36a05e0f41cf35ddfb6d85d3af]
stable/7.1: [4a6bc92fac30070511d66bcce4ed9b7dac983180]

CVE-2026-80543: s390/zcrypt: Pad trailing CCA or EP11 message with zeros

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80543

Introduced by commit e2c6d91 ("s390/zcrypt: Rework domain processing
within zcrypt device driver") in v7.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb363254472493e3458156fc11fd56dca92f4333]
stable/7.1: [2db92a56b000173d332b6c30f38a5a4444e4355a]

CVE-2026-80544: s390/zcrypt: Improve EP11 CPRB domain handling with
ASN.1 parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80544

Introduced by commit e2c6d91 ("s390/zcrypt: Rework domain processing
within zcrypt device driver") in v7.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0864a163783bff109b548266921829ea794edc93]
stable/7.1: [db21b2cf6dd0af5ffd08931e0a9fcda5a0473220]

CVE-2026-80545: s390/zcrypt: Improve EP11 CPRB length and overflow checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80545

Introduced by commit e2c6d91 ("s390/zcrypt: Rework domain processing
within zcrypt device driver") in v7.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17ac0bc866fc624cd05f022dcd8b730c0af11bb1]
stable/7.1: [2976b9d2e716c7e5487ca7c29a7bd076cf9adf08]

CVE-2026-80546: s390/zcrypt: Improve CCA CPRB length and overflow checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80546

Introduced by commit e2c6d91 ("s390/zcrypt: Rework domain processing
within zcrypt device driver") in v7.1-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35ac6754ba6da45fd193f5ce3f665f7490b830d5]
stable/7.1: [50fe5133dcb46449daf2435fa705264364411129]

CVE-2026-80547: s390/vfio_ccw: Implement a crw lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80547

Introduced by commit 3f02cb2 ("vfio-ccw: Wire up the CRW irq and CRW
region") in v5.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16b0798024c0e9117e395829ddbbe70981c79d9c]
stable/6.12: [49fa26b0df009dc1f420980bd71780e70615b83b]
stable/6.18: [7902be374cbfc11c3435e1e87bf22195bf06a558]
stable/7.1: [c76c4ee72bfc3824f4f491f18ed0323bf2e2daf9]

CVE-2026-80548: s390/vfio_ccw: Selectively expand io_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80548

Introduced by commit 4f76617 ("vfio-ccw: protect the I/O region") in v5.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34f4feff3e90bd09308fad0974e97113b23b812a]
stable/6.12: [2ba9efdf9ebedc4e54df4b56aa3b43a65f7967cd]
stable/6.18: [b6aecea4b2b246f9fbd98a5712daa1193a60818e]
stable/6.6: [f72a51810d49411bd8cad0c2df8592320a2fe5cc]
stable/7.1: [2a5ac0c0f1f7da33929211a2e41911bf72ee35d8]

CVE-2026-80549: s390/vfio_ccw: Move cp cleanup out of not operational

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80549

Introduced by commit 204b394 ("vfio/ccw: Move FSM open/close to MDEV
open/close") in v6.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c11f61a876ed6fcca53d442ed3f33ea8362a0f9]
stable/6.12: [4e3301e2a651d742c05914f6074a25b8e41bce19]
stable/6.18: [af1759d8e6e6da9ba94f30a2f92546f406899aa7]
stable/6.6: [f98a9890ca42f4223d2d4c50e0660af3e012fcb4]
stable/7.1: [56100baa0eb7055b1026dfa73e696e8066ff71fd]

CVE-2026-80550: s390/vfio_ccw: Fix out of bounds check on CCW array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80550

Introduced by commit 0a19e61 ("vfio: ccw: introduce channel program
interfaces") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a005b7f1a491ffda61bff0fd0f6548f8986fb977]
stable/5.10: [0282fb1c4b638eecfe2cc558092c460911d8f7e2]
stable/5.15: [907adc667d902fafbdb2d740d57b55bd025dc4cd]
stable/6.1: [f20be33d093ce7630c17ff7ed93caf7eaf8ac1a3]
stable/6.12: [499a8a66b1598bfab97182aed15e0f1646074a3d]
stable/6.18: [4c2e1d359d7a2b82cdf3254e4e480af9417f99fb]
stable/6.6: [af3f80ca4c8b17f20f9e588def076288fdb49e65]
stable/7.1: [d5d096cd9369e986d4e5153baa86b8b35c283e09]

CVE-2026-80551: s390/vfio_ccw: Ensure first IDAW remains constant

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80551

Introduced by commit 01aa26c ("s390/cio: Combine direct and indirect
CCW paths") in v5.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [565bef268d75bf7df665bce6923a88cd0eb74592]
stable/6.12: [0d46c2565f173bcddcdcaf44a4f69789a20535e2]
stable/6.18: [08ef2a82115690d6e229615872ac1731af732497]
stable/7.1: [fc59e9482117ebdccd6dc7fa8082f8b980fd021e]

CVE-2026-80552: s390/vfio_ccw: Ensure index for read/write regions are
within range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80552

Introduced by commit db8e5d1 ("vfio-ccw: add capabilities chain") in v5.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f5f9a78fedc45bc29d6a0a64e3a3472361afae5]
stable/6.1: [d3b1e38404b22df5a1f93019f2bb656feaad5ae3]
stable/6.12: [d597fa1273802941c7801202135976fecc29672b]
stable/6.18: [649badf3a2fd8929e40198603a2cb21b74c21700]
stable/6.6: [79ea5e0c4c8a9842ae85f45062d947b3297dfc07]
stable/7.1: [988d9b5be3c2c4baf9457ce8e11b477e13eb9fcf]

CVE-2026-80553: s390/vfio_ccw: Cancel existing workqueues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80553

Introduced by commit e5f84db ("vfio: ccw: return I/O results
asynchronously") in v4.12-rc1.
Introduced by commit 3f02cb2 ("vfio-ccw: Wire up the CRW irq and CRW
region") in v5.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79c60b2c61105368dcc8444eb45847e21734f7c4]
stable/6.12: [dc47a98abe6714577a25224534dbd356051097a3]
stable/6.18: [b7ae0f7993867d009a4b554fc1d6d451c10580a0]
stable/6.6: [e868ea8be0bc88c6982f48ecf3259d98afd884ae]
stable/7.1: [77f5e888d2e607a0b3141fb95091ad6ef1cca9a2]

CVE-2026-80554: s390/vfio_ccw: Limit the number of channel program segments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80554

Introduced by commit 0a19e61 ("vfio: ccw: introduce channel program
interfaces") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5405c90d6a47b3014e74ee0618a162449abbbc93]
stable/6.12: [a1625f66eaa1200068a0e2c05bc90e65182fc4e3]
stable/6.18: [06f4d6e5a8af6c2072e8cd39dbc512c683ca7fb2]
stable/6.6: [15fb4559a7fdf0b8725e433a71cfd03a1313a48b]
stable/7.1: [4ee94790490ae8dcc97df8597f07836c8a81bbcf]

CVE-2026-80555: s390/vfio_ccw: Free all memory if cp_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80555

Introduced by commit 8b515be ("vfio-ccw: Fix memory leak and don't
call cp_free in cp_init") in v5.3-rc2.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74186c2968f8f756ac3226b545b598457c910c75]
stable/6.12: [6a917199aaf97904f5619afe3dfdacb155b03e8c]
stable/6.18: [32e3d364a7b8295120d37e6a6bd433d2de26f748]
stable/7.1: [4699b54fada156534cbb39834d47fc9374d7a1f5]

CVE-2026-80556: mmc: atmel-mci: Fix use-after-free in atmci_remove due
to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80556

Introduced by commit 7d2be07 ("atmel-mci: Driver for Atmel on-chip MMC
controllers") in v2.6.27-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c125ee35a49a0518521b52b27631eef061b8719a]
stable/6.12: [22aecf6c4721727a2f724ca0438bc7d4b609bf3f]
stable/6.18: [b5060ff2f5460795a3e9f7cdf5052aa42f96ff81]
stable/7.1: [7599a73ff66d195a908f5d88b427933a9fb1c02a]

CVE-2026-80557: libceph: fix OOB read in decode_watchers() via missing
bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80557

Introduced by commit a4ed38d ("libceph: support for
CEPH_OSD_OP_LIST_WATCHERS") in v4.9-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00ead17c7de137a692edee59f2772e6af687e8eb]
stable/7.1: [7130d94846dadbb97b6b7f4d78a3a7bba6e3daa1]

CVE-2026-80558: libceph: Avoid using invalid osd indices from primary_temp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80558

Introduced by commit 5e8d4d3 ("libceph: add support for primary_temp
mappings") in v3.15-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3660b98d1204b419f6a77e9a295f148dcf38d042]
stable/5.10: [505fc50b8ff8e687b7e3ef6866269dea27366224]
stable/5.15: [1c705fe8e59c6b16f48964973fb23c8ec4735b73]
stable/6.1: [dfe1877d351b99eb1b1a62a3fc2d174220e88e20]
stable/6.12: [6799d4a916ffcb3d450d8440f9fe0f0862f768d6]
stable/6.18: [4f392fec075562dc93bb0c69f37423ca2af9b48f]
stable/6.6: [e2ffeec85201b2bb748e99e12539ee1b92f62796]
stable/7.1: [e009c5f0ad634c62f5c48a41f1f3c019ecf52555]

CVE-2026-80559: Input: sur40 - fix input device registration ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80559

Introduced commit is not determined.Fixed in v7.2.


Fixed status
mainline: [9da976eb649c9e2f588a4499410e4d8af687925f]
stable/5.10: [cd4ecce2fd87760c0ad9a9d28c9fc62ea1dbfd3d]
stable/5.15: [dab741c9da72102a37cc1020a929051b7c45f9fb]
stable/6.1: [764b507be7b51787e1f577ca3bf0bab7efe81ff8]
stable/6.12: [83aa12f9f2468a4fbef027c09224dc1011850fb0]
stable/6.18: [5c1c5227c93f18cd329dd754b4df5e0e2daece1e]
stable/6.6: [3e8ed76a4f3572e637653f0654cccdf617903231]
stable/7.1: [beb9b0bd6e6e23f5e9e42b7ef890a50f57f1f3aa]

CVE-2026-80560: openrisc: signal: do not restore privileged SR bits on sigreturn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80560

Introduced by commit ac689eb ("OpenRISC: Signal handling") in v3.1-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32ef1b30ad736519f7a207bcc2986f3d4129d972]
stable/5.10: [bc2e24ba6e167ccf374a197457aa5640a802f429]
stable/5.15: [cf1b5514ddf9df098ce7e3741fc9679fd85a4ec6]
stable/6.1: [cd8b43a71755c516f5c1f265a103438ae9ab15be]
stable/6.12: [89a91b30685c0493b0fa2b47d0ab41061a63069d]
stable/6.18: [a88d688be8d7f03cbf927f2ab454ea9fa58d2979]
stable/6.6: [b4d73c3848bae9084fa8b9b2aa76d99a7d8eb17d]
stable/7.1: [212fc482ddd7f9ccdd74a05eab1cac849350dcd6]

CVE-2026-80561: libceph: fix multiple unsafe decodes in decode_locker()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80561

Introduced by commit d4ed4a5 ("libceph: support for lock.lock_info")
in v4.9-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [437b6551cfcc235eea1d735a874f9d421f555e17]
stable/5.10: [1ed45c8d96498725eb54f740172f9068d8673906]
stable/5.15: [6265103e78f0ee7e2518de9cf938b94bee9700a0]
stable/6.1: [3c3716dc06a34e4ca7f743f5fcfa07fbc5a11070]
stable/6.12: [dbfd83f722a78446ec18a476ef7a38e52240b50a]
stable/6.18: [d1bba38574d095f191557d397d9633f08cd966b1]
stable/6.6: [fa4aa86fff0c56799c2e3f51a88879053285f4a9]
stable/7.1: [51c8d238fe7236de627ab1a1433694552a904136]

CVE-2026-80562: gpio: ml-ioh: use raw_spinlock_t for the register lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80562

Introduced by commit 54be566 ("gpio-ml-ioh: Support interrupt
function") in v3.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [600411ea1f2443fdf5b1af9b6480f616d7aff9d0]
stable/6.18: [bc7934d0acd4fc1c7e5b7c68debdb4a991121628]
stable/7.1: [0559b86611c35d342dd48542ea26a9e437046bf6]

CVE-2026-80563: gpio: sloppy-logic-analyzer: fix use-after-free via
debugfs trigger on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80563

Introduced by commit 7828b7b ("gpio: add sloppy logic analyzer using
polling") in v6.11-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44f3468a0aef1aabdad551898ab7cfa2a9d20e99]
stable/6.12: [49a1ebb1ef2c8ada300c174b65273810abb4e326]
stable/6.18: [23e9f32c0c7d2043e39655cff5ee3ddf29a43f80]
stable/7.1: [24bef4918f6ab806260476e2f93d8f791fd17449]

CVE-2026-80564: gve: fix NULL dereference due to missing ptp adjfine

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80564

Introduced by commit acd1638 ("gve: Add initial PTP device support")
in v6.17-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3992ced109c70b771efad9e51ae68e5c7a04dea3]
stable/6.18: [e9482feeed66d4bc805458631013e9b61b1a9eaf]
stable/7.1: [fa9b991bf678dd412dc0ed080672d34d7558d7af]

CVE-2026-80565: crypto: qce - fix error path in devm_qce_register_algs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80565

Introduced by commit e80cf84 ("crypto: qce - unregister previously
registered algos in error path") in v6.14-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9c75402286409f5e1a75e4a445555c84066f89db]
stable/5.10: [dbca8b798caf47fb2799a26dd09c9ad66305883d]
stable/5.15: [fef187c6194d67395182d58169dd14ba631f1b41]
stable/6.1: [1ece8e16c085e8cd60ecbdb641269aaa53d31da4]
stable/6.12: [c7dc487aade12c692add3221673c9bdf32dc24f5]
stable/6.18: [a134e4b8102c077286818ee112b9f925db613d4c]
stable/6.6: [de52c713d21806b93b00a6074056b57aec4f8919]
stable/7.1: [4e88b4fda48282f3fd504b4d4f5d2d4f996b76ce]

CVE-2026-80566: Input: hynitron_cstxxx - validate touch count and finger IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80566

Introduced by commit 6660324 ("Input: add driver for Hynitron cstxxx
touchscreens") in v6.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27f380ef0e1d3de3cde114e02d33f9320ce3a5a6]
stable/6.12: [387829ee60de26c7c073ed4e27ecfab2b75d4c74]
stable/6.18: [38e7d5c1ade04b99c70da0298ca296ee62bc99c0]
stable/6.6: [ec61ca4e310665816a639cb2e46cd9b3af0a9bee]
stable/7.1: [51c5503554c87e4de4035468bebf186205391ce9]

CVE-2026-80567: Input: synaptics-rmi4 - propagate F54 worker errors to
V4L2 queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80567

Introduced by commit 3a762db ("[media] Input: synaptics-rmi4 - add
support for F54 diagnostics") in v4.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8786d74bf50e6797b6f655eb381ef6b25451161f]
stable/5.10: [305c24ee25b6e08ac9f4c5f697e823cc638c38da]
stable/5.15: [7d33b752e0df385b285492b74699fc73b6becdfb]
stable/6.1: [be56730b547737151f24357d832b04aaa93755d5]
stable/6.12: [6741a8c21d98088b7f2d9f4f86a706d311ce34a2]
stable/6.18: [70f9aad3943559af6f32cb303744f35c05ce9cf1]
stable/6.6: [2b0403fb7e28f65883cd03814b62c9aa9bc7f04d]
stable/7.1: [9bbd3682f8a3e064271547133c37fcb17668d860]

CVE-2026-80568: Input: synaptics-rmi4 - block s_input when F54 queue is busy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80568

Introduced by commit 3a762db ("[media] Input: synaptics-rmi4 - add
support for F54 diagnostics") in v4.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbfd76746adc16d64be29ff113f673b70bc3f5c2]
stable/5.10: [7e994a9ecc0b49ad2fe63da9c92a8aca8a6614af]
stable/5.15: [fa69f93015becf3729716de2199b58540aa99672]
stable/6.1: [493ba8e794729649689438edba72337111303cc4]
stable/6.12: [cae79513f9115c350561b16f36adcb47c9bfff12]
stable/6.18: [ff0849705d29277fd1f6fc6596674b9308724fb2]
stable/6.6: [1d718f1461766e9f00a8dbeb4f13f1b1c19d90ac]
stable/7.1: [ddd9a53faf3b65e5920cb802cb1db6f4615bdfef]

CVE-2026-80569: Input: synaptics-rmi4 - bound the F54 report size to
the allocated buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80569

Introduced by commit c762cc6 ("Input: synaptics-rmi4 - propagate
correct number of rx and tx electrodes to F54") in v4.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49c5adc2b7d6e43c5cf033e1c86fdb9c16ababb1]
stable/5.10: [6b3bdd44d4cd7d5e35de1d0f06d4930f3cecd403]
stable/5.15: [b2f596f00d27703ce09167201ba57f55be8d2f9a]
stable/6.1: [b3932101c9c457148038392bc977f9b31e125a86]
stable/6.12: [42eaf0e6f79c487f419737314cf0760f7331d368]
stable/6.18: [6b06aab79ff166d5781ce792d91acc2e58b1770b]
stable/6.6: [12be3c6ca9589afd6ade41a59c761866e526634d]
stable/7.1: [b7b9a8b1c303b62371698e396654d6724c79cb74]

CVE-2026-80570: Input: synaptics-rmi4 - zero report size on F54 work error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80570

Introduced by commit 3a762db ("[media] Input: synaptics-rmi4 - add
support for F54 diagnostics") in v4.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc76c3c8e8ad09362b8c1561f3928288c15cba2e]
stable/5.10: [62079c17ec07d64362bec367ee7a525b0dbf6bf9]
stable/5.15: [79521ed3cc9ea48476666ccacf45ecd6954b29a4]
stable/6.1: [c669c64ab71afa7b467c4d7e18f6a05e96b97a1f]
stable/6.12: [c6cfda79f26c69e97db9805808c3b44d02227b4b]
stable/6.18: [b28593a05afdd812b590e1045b5bd862a5869225]
stable/6.6: [77749685e55da19b187df215b5da4080842ca5c7]
stable/7.1: [88c8174d72900d77fbdf2f527d54b6ff2da876a8]

CVE-2026-80571: powerpc/pseries: papr-phy-attest - validate
cmd.length, plug mem leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80571

Introduced by commit 86900ab ("powerpc/pseries: Add a char driver for
physical-attestation RTAS") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b17f3f34391372faf03e79d947e0c50ab6dd258]
stable/6.18: [828a8d1a9107aec6353d896882df8383accf7e80]
stable/7.1: [ed98ce338f9a65c90cb930b088f1eb36de7181af]

CVE-2026-80572: Input: byd - synchronize timer deletion before freeing
private data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80572

Introduced by commit 2d5f561 ("Input: byd - enable absolute mode") in v4.6-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c83e79c0842ed29860648bcce5022ef0ba5001c6]
stable/6.18: [8dbfd8e32a13e116790780ed0be82b5a05eb9916]
stable/7.1: [2e509ef60ee41a2da0deb062c262bb530143fb37]

CVE-2026-80573: Input: iforce - validate input packet lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80573

Introduced commit is not determined.Fixed in v7.2-rc7.


Fixed status
mainline: [5751c781d3c97ab6ce0e2a966156ed882152c415]
stable/5.10: [0ec411167655ef3ff3e84f6af685e962aff9a75b]
stable/5.15: [609be40988898a4d75225ade0ea5c1734757dd33]
stable/6.1: [e73d7a7d913d89141321f5f3f16343ecc200d152]
stable/6.12: [2c083ab16e33fbff3ab8c752fbf8118ed3dd31ce]
stable/6.18: [a64a8b6b31cd669f0449138e53cc2592d454ccf1]
stable/6.6: [5232529eaf57f08fe37484e301579a1915b93d14]
stable/7.1: [84e5cb517f445dadbd5f8bf4ec513540e51f9c36]

CVE-2026-80574: Input: focaltech - fix array out-of-bounds in
focaltech_process_rel_packet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80574

Introduced by commit 05be1d0 ("Input: psmouse - support for the
FocalTech PS/2 protocol extensions") in v4.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [296736076b3fd078742651c719555a488624023a]
stable/5.10: [063b4c6a6f3fc01bca085c442000c9c100fdbd93]
stable/5.15: [bb502d79acb9ac1e0a77fa8bc7b7b4729140b11f]
stable/6.1: [ca92c98b806839c108995b2bbff7061515bdfb53]
stable/6.12: [6f6d5fe29efdf5001bc146fc292e6592cace93eb]
stable/6.18: [83c265bfc084d77e2171d4b67362150ab38c935b]
stable/6.6: [81b07470cb2937ceb74b00be88151582a322433b]
stable/7.1: [1842e47126816e56d30c4f856f9854fd7831066c]

CVE-2026-80575: Input: cs40l50-vibra - validate custom data from user space

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80575

Introduced by commit c38fe1b ("Input: cs40l50 - Add support for the
CS40L50 haptic driver") in v6.11-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d5c576cb1c86047b1fcb1aa9532e17fc5e46c1d]
stable/6.12: [3855b6a11f8a7aceb8181cc08c99afef58517006]
stable/6.18: [52a818c586ae2c36b7324bfaefb547f5e866a8ae]
stable/7.1: [d38554602a0b04e85fad28ce72c7500cf50d419b]

CVE-2026-80576: drm/amdgpu: reject oversized IBs with per-ring packet limits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80576

Introduced commit is not determined.Fixed in v7.2-rc7.


Fixed status
mainline: [fd37f9dd5b5ab70a46fa7bc76623c0528d602b27]
stable/6.12: [6e164ba1057175fb8a370d8e05cbff5c57eac0c8]
stable/6.18: [1474f3970d1afd303e12ff14d06808eabb371576]
stable/7.1: [07fe270ec07c138a70afe7a81e115a85c35c545c]

CVE-2026-80577: drm/panthor: skip zero-sized firmware sections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80577

Introduced by commit 2718d91 ("drm/panthor: Add the FW logical block")
in v6.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b8f13d3c7e26c46c20d9e367904cf01729c88e6]
stable/6.12: [f0f3c3922db981031733a25c51e1f37cf9b9e251]
stable/6.18: [25556a46ae6ecf2a9f1c1c5096828eecd4596b91]
stable/7.1: [5d222b657f02a37f658e4e21925b85b4703855e7]

CVE-2026-80578: fbdev: core: Fix pointer desynchronization in fb_io_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80578

Introduced by commit 6121cd9 ("fbdev: Move I/O read and write code
into helper functions") in v6.5-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81cc73be40c6f028f1ee3f438ace46afe666dbae]
stable/6.12: [42a6d8126c194133eafab2b0fd5c8668ebfcba5b]
stable/6.18: [7ff87a01ae3a8cd0208f7499386998223a8b5dba]
stable/6.6: [42bc07b4e5a3c8a02a433388f562a8f46d093e11]
stable/7.1: [7110b7b794a2aac2c5cf8eb06ebf2af724c74d50]

CVE-2026-80579: fbdev: clear fb_info->mode before deleting a videomode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80579

Introduced commit is not determined.Fixed in v7.2-rc7.


Fixed status
mainline: [95e647d2a5304a8fd11f1ba3c8502de700650131]
stable/7.1: [ce7fef961c63229b22dec415fb988899f479d61f]

CVE-2026-80580: fbdev: bound mode sysfs output to the sysfs buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80580

Introduced commit is not determined.Fixed in v7.2-rc7.


Fixed status
mainline: [d15d51fb26e830af58f3f21964f1c09c239077ea]
stable/7.1: [873a1aa15c313263f2e18b38cf525623cc4fabf6]

CVE-2026-80581: ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in
case of IPC timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80581

Introduced by commit c40aad7 ("ASoC: SOF: ipc4-pcm: Workaround for
crashed firmware on system suspend") in v6.8-rc5.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [17661c67b206612cb3ba65d5ae726cd2015d0a53]
stable/6.18: [f2435a46dfa1a5693cf2664afd022db66ee58121]
stable/7.1: [6b512a5330ef1a41db7aff4b80c4e952b8d52f17]

CVE-2026-80582: drm/shmem_helper: Check VMA boundaries for PMD mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80582

Introduced by commit fc3bbf3 ("drm/shmem-helper: Fix huge page mapping
in fault handler") in v7.0-rc6.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [617bbd08714857c1613d7c550d43a9092ec0fb97]
stable/7.1: [12803e89a1e593fd1e784dfe7453f5e392ccaff2]

CVE-2026-80583: ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80583

Introduced by commit c39667d ("ASoC: codecs: lpass-tx-macro: add
support for lpass tx macro") in v5.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ba381759e45d5d0442452cfa5c42e836191a568]
stable/7.1: [3ee3c26ceee562079596abc9bc3307dd56dab4ed]

CVE-2026-80584: s390/qeth: validate user buffer length in SNMP and ARP
query ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80584

Introduced by commit 4a71df5 ("qeth: new qeth device driver") in v2.6.26-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d141f087b1af656f055d7c5793a3e87817ba0bbe]
stable/5.10: [9d00eeb2d27f4cc817c5e408760226d43f811ec6]
stable/5.15: [46443eaddebd84c51940857b11787229be169dec]
stable/6.1: [91935843f9396a9e45253e2c0d4337ca1371754b]
stable/6.12: [3083818e67bcd656965797fbac9a3d6c1d44f78a]
stable/6.18: [a3083647747942ea32faf14560d6397ff3068046]
stable/6.6: [cc423f4105fe145b33e1d7cad34245a798358f73]
stable/7.1: [75fb3151513d7d9f77a8f9545418279b119c06b8]

CVE-2026-80585: mptcp: fastopen: only mark MPTFO subflows with SYN data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80585

Introduced by commit 36b122b ("mptcp: add
subflow_v(4,6)_send_synack()") in v6.2-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e00b63056fb4f261455b3e5df5268a1f8ce47a87]
stable/6.12: [fca7e444c04689fe4cc6b56f2725f804a4bb1ef9]
stable/6.18: [75e564b2ced1cc3d9a8904c7d2d2bb448fffb8b5]
stable/6.6: [f75f174edc865738522e514d042cf5627f084859]
stable/7.1: [72b4a0c51a4b550d40301d60a366b429b8c8e78d]

CVE-2026-80586: mptcp: options: reset DSS fields in case of unexpected size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80586

Introduced by commit 648ef4b ("mptcp: Implement MPTCP receive path")
in v5.6-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35772b4981f38ba8059372cde8753e8e477e98ec]
stable/5.10: [15e35fdad7a5576bf3f1c8d688877aeb5d1b506b]
stable/5.15: [b1256090816ec46011601e084be580731df58fc7]
stable/6.1: [192878df582c51d440bf7b91a15f297f29f2b596]
stable/6.12: [4e80eff5c1c893aca2ac1d202f0b256d2e52ecde]
stable/6.18: [1fade1b2ac5b1a4948e538fae7313bea57b5ac36]
stable/6.6: [26dac5c9ffb20812b475fdf253eb04fab99cff3b]
stable/7.1: [27ed642a4e7e4b5df4b8522c72c457a67e052493]

CVE-2026-80587: mptcp: avoid combining some incoming suboptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80587

Introduced by commit eda7acd ("mptcp: Handle MPTCP TCP options") in v5.6-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ee361524641f57b2e2363f7737f20e17f67827]
stable/6.12: [099bfcbd0c16ae9b50aba2a1bea033e63f895da7]
stable/6.18: [a04dcc784959e4702048785d87e0d029bd2fbdcb]
stable/6.6: [dc1d8d3eb345c616fbe922a010fa391c72c54d52]
stable/7.1: [6bab907292155513af397a12ccb488acbfc30d79]

CVE-2026-80588: mptcp: reclaim forward-allocated memory on RX path errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80588

Introduced by commit 9db5b3c ("mptcp: borrow forward memory from
subflow") in v6.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [41b49a8b914ec7dcb03eae93fb27f3c464078644]
stable/6.18: [473f1a5ab2abc98dd9e74b95b9c23c66c47535cc]
stable/7.1: [8277f48a06d3aa1441f6d0b6998ccc0360d30ed8]

CVE-2026-80589: block: stop the timeout timer when releasing a never added disk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80589

Introduced by commit 6f8191f ("block: simplify disk shutdown") in v6.0-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26cb8ebbfaf713c82e142d08828d4d765057633b]
stable/6.1: [6ae7364f68e6c7af6b6df4bbb14040b89e5975d0]
stable/6.12: [1a0ae4d502062a2759f2a92d12bdeab3c64c7372]
stable/6.18: [bb03b56d1d754908a37a160603be21769da423cf]
stable/6.6: [6f06dbe5012c160e0dba418a5a9cb16c456ad46a]
stable/7.1: [93d620519d71dfc6ee64b5baea74f1d85d4439fb]

* Updated CVEs

CVE-2023-53706: mm/vmemmap/devdax: fix kernel crash when probing devdax devices

stable/6.1 was fixed.

Fixed status
stable/6.1: [87349cf6818c4a0be00d49a13572f20a9e17887d]

CVE-2024-38620: Bluetooth: HCI: Remove HCI_AMP support

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e6cf0eccfe15b67bf9773ecd101162dfdfed5e2]

CVE-2024-40973: media: mtk-vcodec: potential null pointer deference in SCP

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ac79a923365ae1e524398087cf16313cdbd7a144]
stable/5.15: [19ef02106c990bf4235365a08b9d8d2fee37272a]

CVE-2025-23160: media: mediatek: vcodec: Fix a resource leak related
to the scp device in FW initialization

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [beaefe8dbb261f36376bb533a89ed69ab38e6747]
stable/5.15: [2540a81d5532829150b2e7cca977313b524066a9]

CVE-2025-38117: Bluetooth: MGMT: Protect mgmt_pending list with its own lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [7b5958332f20dc66b19be564c402dbc21b927a81]

CVE-2025-38524: rxrpc: Fix recv-recv race of completed call

stable/5.10 was fixed.

Fixed status
stable/5.10: [4aed0eeca58e26d752bb08b293b8dc75c6820b23]

CVE-2025-39758: RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

stable/6.1 was fixed.

Fixed status
stable/6.1: [b47c4b7cb78b6382c6d1af0bfc0d8218e4f445cc]

CVE-2025-40054: f2fs: fix UAF issue in f2fs_merge_page_bio()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [1f7b44b4a2b2939f08b279cbb9e6b5dcb8ffea32]
stable/5.15: [e193d8953647c8b575830852aa5ea0995b98d2b1]
stable/6.1: [410337c2301ae78a081e1b5ebbe8ec374fef4cb6]
stable/6.12: [7dd611131d82d7fc4212b555eb1103160bdad302]
stable/6.6: [68e094232dfe5027c4fd2dcded93d2d6800bae04]

CVE-2025-40206: netfilter: nft_objref: validate objref and objrefmap expressions

stable/6.1 was fixed.

Fixed status
stable/6.1: [f31bcea12222a26d6f151df9c4a6d21f2eec1724]

CVE-2025-68305: Bluetooth: hci_sock: Prevent race in socket write iter
and sock bind

stable/6.1 was fixed.

Fixed status
stable/6.1: [7344feaed3c8aa46d397984ae855e6026d3c3e95]

CVE-2026-23459: ip_tunnel: adapt iptunnel_xmit_stats() to
NETDEV_PCPU_STAT_DSTATS

stable/6.12 was fixed.

Fixed status
stable/6.12: [e40e2d11ced8119d3e4469ebe91264bc1cf71530]

CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadcast()

stable/6.1 was fixed.

Fixed status
stable/6.1: [00752893f96b344f258c9c6de18b33171ac4872c]

CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8ea162a817c31c5fb00bef2f70cdd53810d6c643]
stable/5.15: [f6dd35a2599aa55421fe5fde5f1e377004089afb]
stable/6.1: [9bfe14729c18fb5b2af5edcdd6756a8bedbd2418]

CVE-2026-53092: bpf: Fix linked reg delta tracking when src_reg == dst_reg

stable/6.12 was fixed.

Fixed status
stable/6.12: [1509c1ae9185ec7103899967ed788b6eebab3fcc]

CVE-2026-64048: net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [903f7688ffeb9b323d70652c01f554bd4ba2a3d6]
stable/5.15: [dd2f9dd83c68abd7ba7ded7075290b016cb7ecd0]

CVE-2026-64139: ksmbd: fix SID memory leak in
set_posix_acl_entries_dacl() on overflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [9b0a8985b419a71ee1cc9c0cc6a9e1bb7815a2c5]

CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF
LSM is uninitialized

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [413b14b9623a2e6ee131c2b2152b304aeb04e378]
stable/5.15: [a6d634f794c808a261eac7d5af023a7e06b9ecd8]
stable/6.1: [721f669853bdbf46b475a81bb5d05d610f8c19de]

CVE-2026-64269: RDMA/rtrs-srv: Bound RDMA-Write length to chunk size
in rdma_write_sg

stable/5.10 was fixed.

Fixed status
stable/5.10: [a35b7a8728a53ddc80b323970689fa5985816836]

CVE-2026-64270: Input: mms114 - reject an oversized device packet size

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [040843281eebfa110d08fd7fb083fe6cb55cea14]
stable/5.15: [39b12daf1adb80f9595fdfe584961deb80860cbb]
stable/6.1: [d99ba93c35ff2d5276e9c2632967481bd53a79d0]

CVE-2026-64272: Input: mms114 - fix touch indexing for MMS134S and MMS136

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [062bbe55a1f6d77b89d07135ba3b09f97bfac1cb]
stable/6.1: [38de2979d90d8cd94f18e0567be4c8342d0e0410]

CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in
afu_dma_map_region()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5352d488ce4ae5e8c68c080ad4c3a5f084ad5fbc]
stable/5.15: [d7e787eee2ea619b6dbb98890472ee73daf2e7fd]
stable/6.1: [a6a3884ff500f04f3088d6d09eec803cd35331a2]

CVE-2026-64294: mm: do file ownership checks with the proper mount idmap

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [7368bec565bac3e536cd43579dbde1e715e6ba61]
stable/6.1: [b2f3d94ea310bea9d36d53e9d9b3f45e86c1d893]

CVE-2026-64336: USB: serial: keyspan_pda: fix information leak

stable/5.10 was fixed.

Fixed status
stable/5.10: [cccef1711efbcdbe999738ac27d37b9ef6271abd]

CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain
func_wake_notify before teardown

stable/5.10 was fixed.

Fixed status
stable/5.10: [eac1107e54679db2df2c36d8bba3b66d3ab6cbcd]

CVE-2026-64585: can: esd_usb: kill anchored URBs before freeing netdevs

stable/5.15 was fixed.

Fixed status
stable/5.15: [d12f6add48f2da15c8c8281961d3faad804c76cf]

CVE-2026-64586: wifi: brcmfmac: drain bus_reset work on device removal

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9dfb09cb0abbf92a06f93e0715e163aa188a84da]
stable/5.15: [4824e3bcc68f8d678b409039d1bb48c7b5ea73dc]
stable/6.1: [61127dd20920bf28460a1609aabb0dafa2f54fac]

CVE-2026-64590: dma-buf/udmabuf: skip redundant cpu sync to fix
cacheline EEXIST warning

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4a7c644e632741c2a3116a0d3da6c11de957a6ba]
stable/5.15: [01126abc11bcc6a45b664293b0b5df715be911d7]
stable/6.1: [dd7f1e572f44d3d039dc77e3989f537196c3bf52]

CVE-2026-68082: libceph: fix two unsafe bare decodes in decode_lockers()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [c8ade01170a27d8ede0d761c255268af81e417f8]
stable/5.15: [001835c599899ef1bd3506a815110a6374451554]
stable/6.1: [7c422364acd93d7da1dfc27d6b54635a269653a1]
stable/6.12: [57ba829804fe6d34bbac3b826c4b15c1caa54862]
stable/6.18: [89df5d71f83f8e2781286798fd8ae5e42cf5f1a7]
stable/6.6: [02430f6f729b297e803d0605871f0a670b4eafd6]

CVE-2026-68096: audit: fix recursive locking deadlock in audit_dupe_exe()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6114c3f21eb2ae175401736da744b684705e7ed9]
stable/5.15: [f6fda0ac6661c23b8356dfb1cc423960cc6f0593]
stable/6.1: [3bbb4931f7cd84cecf29ec222c0732bf9ad4da9f]

CVE-2026-68099: ksmbd: restore DACL size on check_add_overflow() to
avoid malformed ACL

stable/6.1 was fixed.

Fixed status
stable/6.1: [8f3a7a499a7d9bb1c0f33fe78c4a4594d7e307f4]

CVE-2026-68100: ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

stable/6.1 was fixed.

Fixed status
stable/6.1: [26cb845e22a00c85bf566337417fa33492395f10]

CVE-2026-68118: tcp: challenge ACK for non-exact RST in SYN-RECEIVED

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0fe4636665d14a258de70b4f3e8248e6d42038f1]
stable/6.6: [8b0a3a094f4cae2fb92e4d08d4eef7246a9d9c49]

CVE-2026-68130: ksmbd: defer destroy_previous_session() until after
NTLM authentication

stable/5.15 was fixed.

Fixed status
stable/5.15: [ab0230257ebdf48b07eaa679a8c92bc842fe3498]

CVE-2026-68132: super: fix emergency thaw deadlock on frozen block devices

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [96248aeddde794227a49af1a332a1e21b3c15d56]
stable/5.15: [c202aa03388fd1889b7aa4f7d677c49e22cd9700]
stable/6.1: [2a1127c1c58b4f15a93f2fd56ff7c2c3d611d5c5]
stable/6.12: [99719b5da9320ed344daee87d9c73d321a98f252]
stable/6.6: [05536cad35f27b520d4b6f0e57c8cc5bfb6b0502]

CVE-2026-68136: net: gro: fix double aggregation of flush-marked skbs

stable/5.10, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7fc7e35212cf58c134310fb47566a844297ceae9]
stable/6.1: [d1fb23f8f794ac4683127bd49a6422bd87e0ac02]
stable/6.6: [db3e82da616f52e2b27e25e7be3fde2f2a5e54d6]

CVE-2026-68138: net/sched: serialize qdisc_rtab_list against concurrent get/put

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [1b050d09dd1a0ddae83bf012cf4956b7a960235f]
stable/5.15: [6e0241f6cbb149d926ee8efee2c734fea71452cf]
stable/6.1: [f93c89392bd3b180b5b7abc6fdae8e3dd667a313]
stable/6.12: [d981098b76756ed71666a27518eeb69883657c43]
stable/6.18: [8ddc2eb0d2da9c83f54f1e5720525b461b8480c4]
stable/6.6: [4131dd0b6f67acddd616ed7c244e1d3eedd46e7b]

CVE-2026-68145: iomap: fix out-of-bounds bitmap_set() with zero-length range

stable/6.6 was fixed.

Fixed status
stable/6.6: [48829622212f6b8f49155889aecc818ba28ba680]

CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser access

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a29bc20ea5f0cb79c6287f2c6182c5eeb8e6c01f]
stable/5.15: [db76744d588086695371ecdd982694395628ba48]

CVE-2026-68150: fs/super: fix emergency thaw double-unlock of s_umount

stable/6.12 was fixed.

Fixed status
stable/6.12: [79e04370657a2581e3189f9c7fc166e7c4fbab3a]

CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to
CEPH_PG_MAX_SIZE

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [66eec4af1e080b695229c9a20635648a6d12fedf]
stable/5.15: [4daf06456677177f2a6044729abac59c1b49e87b]
stable/6.1: [d5650ddbd4d42c1a916c8fe1a4c4cb573ef810a1]
stable/6.12: [ebdf4b4f3b1474079980a2e5cd79ad65fb54db57]
stable/6.18: [590b07ceea138d49c9b64f65d263aa902d3b4730]
stable/6.6: [42bc06c67d94d5f2a6b33294b0c4b07d8a47c515]

CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ceb7190b5c873d4a1267a1600c5aa52c600e929f]
stable/5.15: [fd66854a22661929245f3d2b244c432bc8b1a150]
stable/6.1: [158f3cc332dc53f43ec20060233d7c3cecd6d912]

CVE-2026-68166: userfaultfd: prevent registration of special VMAs

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [495a28d5a100be1b232633f4c2dcc42ba10b3796]
stable/6.6: [d974b4b786214883bd8e56bda10b454c80fd6205]

CVE-2026-68169: mptcp: pm: userspace: fix use-after-free in get_local_id

stable/6.1 was fixed.

Fixed status
stable/6.1: [8ce48d2879aafc0e7a6f8bfc3613c0ba979ec6f5]

CVE-2026-68181: mei: bus: access mei_device under device_lock on cleanup

stable/6.1 was fixed.

Fixed status
stable/6.1: [02e3a755086db847d795f2593ebc45e8ee4f1755]

CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a1bac650b2d6b1baab1f3e78e2e007a6e2948dde]
stable/5.15: [2132a6db05846dd2318857d00e0c1291f9e41b29]
stable/6.1: [17ff29cd8dbc977c97788a5f7c011ec807b58242]

CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destructor

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b7feeaca1f53b10df9b4de9eaf611767ca70dc92]
stable/5.15: [7478ef94b49bc9789cf1a003deec58b42283dde4]

CVE-2026-68205: media: v4l2-fwnode: Fix subdev owner overwritten in
v4l2_async_register_subdev_sensor()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f35e85a9d919d7954d9a7752e4644c0b403ad025]
stable/5.15: [c5e47cf9a6cffef73a1ed40b3648e6097aac165a]

CVE-2026-68253: drm/i915/hdcp: check streams[] bounds before overflow

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [336cf6d80d41457442b659e7ba7a7badc0ffe79d]
stable/6.1: [389079bf04e6f0c6f10f5b879f6d7a9cf80f0567]

CVE-2026-68254: drm/i915/vrr: require valid min/max vfreq for VRR

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2f9aa8d42b7fc17621894456433ac07689fb4a21]
stable/6.1: [5225122b9cad6b0c61e767fb2adea8c07da925be]

CVE-2026-68255: drm/virtio: bound EDID block reads to the response buffer

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [65ce911f341ad8ff0c08922eff5bb6db75666eb0]
stable/5.15: [64bedd2758eccbc74d39f7006a7ec16fa39dc901]

CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideband
reply parsers

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c1f72a13d54ffd16647d3fa540d961f5deba8790]
stable/5.15: [192e146c2d57ad033b0d418ec64ee390f8dc074e]

CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk accumulation

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ef2ecb6cf268debf3890df99fea01b6452dcf78e]
stable/5.15: [d4e05dedb252ed3e540a0c9be511e427f098110a]

CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband
reply parsers

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [185de1d74e658e2edb723ba76fa61903f77d8a68]
stable/5.15: [d7b9b1e33b4ed8c48d4db6e6e21c257ebbbb2586]

CVE-2026-68280: drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1014b279264c0fc9f56324608754e36d33b7b5ae]

CVE-2026-68367: usb: gadget: f_tcm: synchronize delayed set_alt with teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8fb317058d165c88f3344f59439c14872c162b3c]
stable/5.15: [90431d8523c0c1c9f8e3e3f0895727063f93da85]
stable/6.1: [ee07d09419f1c59c74f73107aa08444f2f2fc6c8]

CVE-2026-68371: usb: musb: omap2430: Do not put borrowed of_node in probe

stable/6.1 was fixed.

Fixed status
stable/6.1: [f0e68402d13cd9ffb289da50e65d4429d0002174]

CVE-2026-68392: Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync

stable/6.1 was fixed.

Fixed status
stable/6.1: [74f3e6e21ebc6c418d348f8ce68aef6fe6d82c82]

CVE-2026-68431: ksmbd: validate minimum PDU size for transform requests

stable/5.15, stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/5.15: [22f1aa35b87e471cc31b35b74451f46630863b12]
stable/6.1: [928dda88d0e13fbca381255028f65b244343a4ea]
stable/6.12: [32e486b70c256d5ef4baa5a2936ade2fea50e8eb]
stable/6.18: [d9e9753dfd43bd27c956578df7804a3c90b80fdc]
stable/6.6: [d8e5c5672724b8f3c4c099d2cf60239c996e5424]

CVE-2026-68434: serial: 8250_mid: Fix NULL function pointer
dereference on DNV/ICX-D/SNR platforms

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bdaa8871b53fe9b1730ef64dda2fcd662fd83339]
stable/5.15: [f85a42fb90399dedcf81c146d09c07e4548b1e8c]

CVE-2026-72012: tracing/osnoise: Call synchronize_rcu() when unregistering

stable/6.1 was fixed.

Fixed status
stable/6.1: [428cedade9b2cc8e48f00742df0cfd770e77a803]

CVE-2026-72015: fs/resctrl: Fix double-add of pseudo-locked region's
RMID to free list

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bab7dbba38ed3011972c3d9be2dcdca7575cbe32]
stable/5.15: [ad12e70d7dc3c94a05efc61d1e4861078e0e162b]
stable/6.1: [52b769165f20b38092f28ce064b4b143471540a7]

CVE-2026-72017: net: macb: drop in-flight Tx SKBs on close

stable/6.1 was fixed.

Fixed status
stable/6.1: [0e9797dc4ebdefe1b7f931b1f92d5e98e5dbf655]

CVE-2026-72023: octeontx2-pf: fix SQB pointer leak on init failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fca9c22633169a6c5d429a32e439121b6419e2be]
stable/5.15: [42c2836f10ac0427dac9e9a923d6ee2189dec544]
stable/6.1: [2cac2eac935ed7e0a9203204e036a1f6090ebc3d]

CVE-2026-72030: ata: libata-core: Reject an invalid concurrent
positioning ranges count

stable/6.1 was fixed.

Fixed status
stable/6.1: [01d7d321e6046f87ba270aeeffdc5260209bd91e]

CVE-2026-72035: net/sched: sch_taprio: Replace direct dequeue call
with peek and qdisc_dequeue_peeked

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [51f8af240aed903e988755af33d7491030b50ae9]
stable/5.15: [17ab5f76f3899f67e5569722f334591f4b88b17b]
stable/6.1: [f60d5c12e0551012cee5c272b0bcbcc78f7bb506]

CVE-2026-72040: ipmi: fix refcount leak in i_ipmi_request()

stable/6.1 was fixed.

Fixed status
stable/6.1: [122ca6b2af714e114c9b872a48372ace31a9ab1f]

CVE-2026-72041: espintcp: use sk_msg_free_partial to fix partial send

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [518dcb84b997dff461800b079e5f2596389f766a]
stable/5.15: [4ea8c051b4bd7feec7749a980f2f70e1782b84d7]
stable/6.1: [a977f78adce40b39d90d9567e7987bb110102810]

CVE-2026-72045: octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [04c014e49b9f53d58a8f94adece8a0af3ae1b85c]
stable/6.1: [6967dd944be2a71eddab3a2ae1a1a4dd9e5f8eed]

CVE-2026-72051: net: ip6_tunnel: require CAP_NET_ADMIN in the device
netns for changelink

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2d53ee7daabe733deb81f51d2cc90188f8ad59a1]
stable/5.15: [82e53e7281c71e174f9f5877c566a623c637b406]
stable/6.1: [5252db8fb604321133138c7069d6fc3fcd89cdee]

CVE-2026-72053: net: ipip: require CAP_NET_ADMIN in the device netns
for changelink

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a7d2642a50282322bc33f34ee7305f2b793df494]
stable/5.15: [068ad9b85f681755f751ebab82ae98146cec163d]

CVE-2026-72057: net/sched: act_ct: preserve tc_skb_cb across defragmentation

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [fb080b6f54835d5d4d11ce3122800e6f0f6689e6]
stable/6.1: [67d6b00a54446c008f52cf70fc0c2ad0c712f85d]

CVE-2026-72058: net: ixp4xx_hss: fix duplicate HDLC netdev allocation

stable/5.15 was fixed.

Fixed status
stable/5.15: [77d925b948ee594a79afe66f85bb94b67940140b]

CVE-2026-72062: gpio: mt7621: avoid corruption of shared interrupt trigger state

stable/6.1 was fixed.

Fixed status
stable/6.1: [bddf9314a57a243dd11ed945ba11e146e331257e]

CVE-2026-72063: gpio: tegra: do not call pinctrl for GPIO direction

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [89904b4f1dc0f9550c3f206dcdfceed0b7ce7c49]
stable/5.15: [d3b92d16e1c4debec7526b6dbb2d98d0aeed796b]
stable/6.1: [616188becd4a208afbae1653fc5241e1748bae80]

CVE-2026-72065: net: mana: Validate the packet length reported by the NIC

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [a631f82f89c76084ad5b2b9c043d3b391ffa56d8]
stable/6.1: [d2568e64d01f480200063fadd67d6938f676c66f]

CVE-2026-72069: locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [af28d801cd2db4cc7378554499bd4a5d84a5517e]
stable/6.1: [9d1fcd64ab81200e02b7a6db5eb1da8e244e8289]

CVE-2026-72070: wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bd75636681588c67006279abdb9a76a708b3ce29]
stable/5.15: [2fba1d3b2f031a2c68e566a6d45cc5b7a8d6683d]
stable/6.1: [9392fd5de555272449d3d8c63410ea00f8ec853a]

CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f8334e8ddb718317952207ab66ea2f81472ff7d6]
stable/5.15: [7c0c50fffd9c2a09d1b0393402a8fdd62d17f52a]
stable/6.1: [d7ed2e5f643d3fb2ebbde82772f34c759926158a]

CVE-2026-72075: Input: ims-pcu - fix race condition in reset_device
sysfs callback

stable/5.10 was fixed.

Fixed status
stable/5.10: [8b9ff928aa71a2ff6f559da45821b64fa4886a75]

CVE-2026-72077: Input: ims-pcu - fix firmware leak in async update

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f4b8cd2a96b47473e912e8a134f3c59efb81f10f]
stable/5.15: [9efba5177a51ed996b0bdc03aa677c08247d5b91]
stable/6.1: [af0641337f6584ccbc7a42ce3f4803d8ff9c5a4a]

CVE-2026-72084: scsi: target: Bound PR-OUT TransportID parsing to the
received buffer

stable/5.10 was fixed.

Fixed status
stable/5.10: [88c67c3de914e19172e1d878a7625c5b06c20ec5]

CVE-2026-72087: scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4d920852c0a3cfbcb42bcd2680b091f5c0072fc2]
stable/5.15: [7795037f15289ac1ed620603511b67d820a93762]

CVE-2026-72096: dm-verity: make error counter atomic

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b8eddcb1bf72199451950aff9087bd76da80635d]
stable/5.15: [aab5cb8a40e82bd33d0f3ae3c73041848b18bfd2]
stable/6.1: [a7df22c4e0e9110f0be577919d3cb9389b2aba65]

CVE-2026-72099: dm-integrity: don't increment hash_offset twice

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c66b1781a54984227e94b862be9328d81d81e51c]
stable/5.15: [39697e2759ac23e65361fe61482f8174cad8a752]
stable/6.1: [e6646f4d711d74930d39cce6fb7bfcae4cbee5fd]

CVE-2026-72110: bpf,fork: wipe ->bpf_storage before bailouts that access it

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [7df67a4799067a59e6a2d53f8059a6be6e73e678]
stable/6.1: [aff686efd38728e06daf12417a0d7ed454ce4cff]

CVE-2026-72142: i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0f29df3c3d607a9dbc14aed0e45504ced4d2e7ec]
stable/5.15: [38d4947431b2410850409fda016b2ac9f640a4dd]
stable/6.1: [e3e8b02d4773cfc5ad561d2e5505efde36c6927a]

CVE-2026-72148: dmaengine: dw-edma: Add spinlock to protect
DONE_INT_MASK and ABORT_INT_MASK

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3989b4775bc2cdbdb4ddc4b1d2420a82b40913f2]
stable/5.15: [f60c7463d44fbc1585d247d0bd6976f7a1099472]

CVE-2026-72152: tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [45ceeb08bf1f4f7353ffb529d8682a0cf5506318]
stable/5.15: [eef71c01deb08547956df3634a0d34c6bdbcecb8]

CVE-2026-72155: mtd: spi-nor: swp: Improve locking user experience

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [23c285be8f6fcde9088fe12bb69c701d46696be1]
stable/5.15: [a6fd2145c73b80bb6a5eed7355a4f63597d712d9]

CVE-2026-72157: net: thunderbolt: Fix frags[] overflow by bounding frame_count

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f96b3b35c622d565eff2438993e028d280163f5c]
stable/5.15: [6262f51e09d8dc8b07599a9e4f03bd3989d13fff]
stable/6.1: [569ba39b2d12995a29dc158e5b4de6e449278f30]

CVE-2026-72166: net/9p: fix infinite loop in p9_client_rpc on fatal signal

stable/5.10 was fixed.

Fixed status
stable/5.10: [18a3427526e2141f80050f82c1d26b19a454707d]

CVE-2026-72168: mtd: maps: vmu-flash: fix fault in unaligned fixup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f781e80c9f1e52d92535c076573b0cdafab04864]
stable/5.15: [631edc934e476991a04723d3283e6628d077f8c1]
stable/6.1: [90494884cd9f02c38b4eafb0ed3b0e1a4410e2ac]

CVE-2026-72170: 9p: skip nlink update in cacheless mode to fix WARN_ON

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6086469f7d469549bfd070348b717a6e43736200]
stable/5.15: [ab257019cb72f467b55c95384d99c94e3908b928]
stable/6.1: [4ec4ebe40c82cb4c60756732f6593055d010c59c]

CVE-2026-72172: mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE

stable/6.1 was fixed.

Fixed status
stable/6.1: [c5ef574d57e4a701485c13f26822328c91f05413]

CVE-2026-72191: ntfs3: validate split-point offset in indx_insert_into_buffer

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [8e4ba5a38c155bb3c1c11e63cd285b178cdb099e]
stable/6.1: [4c2f648139a0a86f4486170f72e24fedd4fae74e]

CVE-2026-72216: remoteproc: qcom: Fix leak when custom dump_segments
addition fails

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [491edca252d1256b57e805c6e3acae320b53f53e]
stable/6.1: [8bfe7e7729617e73233ab5f1a2edbeee5e75c722]

CVE-2026-72225: jbd2: fix integer underflow in
jbd2_journal_initialize_fast_commit()

stable/5.10 was fixed.

Fixed status
stable/5.10: [aa90f00932bf572d6ef284c977c2a60b39c13bd6]

CVE-2026-72236: s390/perf_cpum_cf: Add missing array_index_nospec() to
__hw_perf_event_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4c249b214c686f9a1c4cf4f32893b59b189e897a]

CVE-2026-72242: selinux: avoid sk_socket dereference in
selinux_sctp_bind_connect()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e4f3b8db1b0c5e9f6374b8996d9e1888d1042b55]
stable/5.15: [2fcaf133a8fd88b69f32ebaecad93fd302da828f]
stable/6.1: [a4bc2fb8536488b37680c0b66c59434a4b7f8c2f]

CVE-2026-72252: netfilter: nft_set_pipapo: don't leak bad clone into
future transaction

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0ab7b1802f63ca5b288ea59acb467830b83abd6b]
stable/6.1: [cc53703f48558896295f565cd4f5e956d21b7af4]

CVE-2026-72253: netfilter: nf_conntrack_sip: validate skb_dst() before
accessing it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7866116a040b3a23fb094e7d8f7ea3d61b3ac70b]
stable/5.15: [c5ef7228be04518d95591fc5369a9c554b19756d]
stable/6.1: [0aec339694a56e263d4b22475ff7211d40900830]

CVE-2026-72255: netfilter: nf_queue: pin bridge device while NFQUEUE
holds fake dst

stable/5.15 was fixed.

Fixed status
stable/5.15: [8dc51351472825500145eed5bddfb88b2ec32008]

CVE-2026-72260: ASoC: mediatek: mt8192: Check runtime resume during probe

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [9339266a8a720889d0385cfd78ba6652fe7bb1a8]
stable/6.1: [91b20e8c9b64042056d14394c89c81fc16a1c327]

CVE-2026-72262: ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get

stable/6.1 was fixed.

Fixed status
stable/6.1: [af4b437a463ac0482ba705434a44da06783778e6]

CVE-2026-72299: tipc: restrict socket queue dumps in enqueue tracepoints

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ae5d0d9ce767b20a5580bb6dc5e06f3e1b8a0fb0]
stable/5.15: [273ff83c49b82e4267373adbe629e6ee8aeaa16c]
stable/6.1: [258fb15b30db4f3941ab335d5e02f744baf1da54]

CVE-2026-72305: VDUSE: avoid leaking information to userspace

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [41e27a6aca608c9e04f091c29c420d03fafe0313]
stable/6.1: [3ae878f262bd1445c8c31511856a99962a05fe16]

CVE-2026-72308: mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3fbeaa8ecd144ad593f9fa1ab4b40a780ad3700b]
stable/5.15: [99ff5b0083eae6f774360c4ea6874604e6c9b553]
stable/6.1: [9bf2d6eea26a226f8ebab7baea6f2b018f914560]

CVE-2026-74436: rxrpc: serialize kernel accept preallocation with
socket teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d6207326b4ca0ae1041281b6af9df53f8080669a]
stable/5.15: [11b429b84c87cb5a0152f14e7d6cb649ed363901]
stable/6.1: [c20d983968f239574290cf804a58cde18ad1c559]

CVE-2026-74441: usb: typec: ucsi: Fix race condition and ordering in
port unregistration

stable/6.1 was fixed.

Fixed status
stable/6.1: [7b63c680ff605f60f056e5f2c323f1a602aee182]

CVE-2026-74450: drm/amd/pm: fix pptable use-after-free

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [3fbb3ac75000e3187f500a91a4099b24206866a1]
stable/6.12: [81b5af1fb0f14cace6c3b3130a05e5602a597820]
stable/6.18: [8c685df5c3b261c42505110965b42f9a754eb9b7]
stable/6.6: [9efc767335234cf7a892e46d45cd453b711421e7]

CVE-2026-74470: scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [23535c4ec9417e838a979df5a002f2921a46e553]
stable/5.15: [7b615fc139e35c81077046df44725c532f7e2404]

CVE-2026-74474: vxlan: use pskb_network_may_pull() for transmit path
header pulls

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6146901881f09ef063eb34ad389f63231f8486f5]
stable/6.6: [bb01c51950c3ff3c76acdd54b85ab38ccc2a8bb4]

CVE-2026-74476: veth: convert frag_list skbs before running XDP

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0be3632597b8349d43a7dc4244b492dc62a05998]
stable/6.6: [04958dba44dc795dc79ce2fcbc117821bbbd6542]

CVE-2026-74479: net: pktgen: fix proc entry use-after-free

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [82ed3db9269cb61e3c15bad2f6e221efce90e1e0]
stable/5.15: [d1cc9797cf8f7aeb87e7ad01b748c6a960a819e4]
stable/6.1: [7991c7cff8b8622cddb3d8dee07dbe74aa4cbec4]
stable/6.12: [f85a58340b91f225de3299dfa782c6414098077c]
stable/6.6: [577443530cb592d5782a1f79847411a9363a65c8]

CVE-2026-74483: binfmt_misc: don't leak the user namespace when the mount fails

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [ffec017158d3aad8a6ffca1dfad63d63bde9caad]
stable/6.18: [867aed6a4848761190d5ebdedf9642648f97bceb]

CVE-2026-74486: binfmt_misc: use exe_file_deny_write_access() for the
interpreter clone

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [c65eb018c12179b5e2c7afe1f0956298576fecec]
stable/5.15: [2bd860b7e752a51185960143cab9fec7bf32c84e]
stable/6.1: [eea4b7c7711b1e425272d23352af157f45f4c3e3]
stable/6.12: [f1e7ea3c8e070f19771cdaef55bbeda1359ad490]
stable/6.6: [2fdf8b07bee5ef99ec77773a6be05fbb8ee5cdb9]

CVE-2026-74487: binfmt_misc: restore write access when removing an entry

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [7873f987213695e3564c8c259e6db283e4739472]
stable/5.15: [13efc628fdf641d901bdba07caa1c558e1bed046]
stable/6.1: [f1cf67f6be0babc73afa4ee0e27bdedffeeeb095]
stable/6.12: [a50296cca2a1db9d8d21051e7d50f0cf3a4b7ec8]
stable/6.6: [dd9ba32169e73a3c3ba595cf1de1f4c69ceafb3c]

CVE-2026-74494: ksmbd: reject repeated SMB2 NEGOTIATE requests

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [0b1390cf2b6b91723b37c0909dd123f7a5eba1a7]
stable/6.1: [fd6a6c43f96b40a08a22ff62f08d194a49741c8a]
stable/6.12: [7fb8dbeb3f2868ae836ca12311d89aed16fc2927]
stable/6.6: [81e21cb7bd1479bb5238e0004a7e0110452c610b]

CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction header

stable/5.10 was fixed.

Fixed status
stable/5.10: [24c64ccd5c1fc9934b427335b0d976c7f2b1a7d8]

CVE-2026-74509: Bluetooth: hci_sync: Fix advertising data UAFs

stable/6.1 was fixed.

Fixed status
stable/6.1: [565971488191bf54a87a417abafab6ad0de72201]

CVE-2026-74510: Bluetooth: mgmt: fix UAF in pair command cancellation

stable/6.1 was fixed.

Fixed status
stable/6.1: [50af4280a587c9971b5388cbc438f1324e626b7b]

CVE-2026-74511: [REJECTED]: Bluetooth: mgmt: fix pending command UAF
in EIR updates

stable/6.1 was fixed.

Fixed status
stable/6.1: [68db850630d05177d450aabe4850027133ed54c5]

CVE-2026-74514: KVM: s390: pci: Fix memory accounting for pinned/unpinned pages

stable/6.1 was fixed.

Fixed status
stable/6.1: [ad1c2ac7f15b224cf9ab26b593caa9bd1a4be72e]

CVE-2026-74517: KVM: x86: Cancel delayed I/O APIC EOI handling before
destroying vCPUs

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [69d040448067cebdd5598684db36ce7d8fb2f43e]
stable/6.18: [5f0a99ea721203a4063618aafcca32abf573cb96]

CVE-2026-74575: thunderbolt: Prevent XDomain delayed work
use-after-free on disconnect

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d4fa0d544c04dea636bf821ff5582cd7d63e2c34]
stable/5.15: [cfbd2dba3d862c9be8c92bea2a357d9ed828a54a]
stable/6.1: [dc11d5118f9da6ea28487ffe055de5a0d0734125]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

