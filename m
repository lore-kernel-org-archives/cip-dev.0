Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BEAC433F5
	for <webhook@archiver.kernel.org>; Wed, 27 Apr 2022 23:04:21 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web08.3487.1651100649998860917
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Apr 2022 16:04:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=H581m26v;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so3563278fac.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 27 Apr 2022 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/0uVUuMdkA17YFPhcGwCN60IqXeB3tvUIlMgPPDkBGQ=;
        b=H581m26vmpEDmiryAltkQDJYiw/rjilYYVq7rV0qxz/eEyaT4FYKEdmqbQWpzCQmHD
         nrI3/KZSBRfw7K0QAVXAbGOqMxlsx9rg+xd0pu7g4FQWJUtV/pSeZVpuNq5CoHQO1ZmA
         MCG4lnA91IIb6XOIz6CuC+rUHhS10H4wJTf41LGo/ajm65EMRm1YTAbXrJuqgrrOb97A
         BeJcBGvOR2iV/tyqBtU1t0IfAwIvbQkbQnNbeA8xaRdXqsBth3WO9DlUfdBkf1OfqBII
         b1OTagjmPqWUvB8vLawQqpE6FnL2tjxhNbmI7i/YJjlRmD2Q4eOyrAuyGoTHTszTy460
         iQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/0uVUuMdkA17YFPhcGwCN60IqXeB3tvUIlMgPPDkBGQ=;
        b=xEcVvPGGLUqnRU3gLoGzByzs3fEfVfIVFkV39AEtGuLpXC2hcSHFNmL6Ck3EgAiZ09
         yoenZAso0iftGJFcuouJMo3HH9k1JwyWnI/QJgabA4w30x4Ed9FNM9H8Ie4fAyMRalYl
         m6q+RzZ9s/QW9iDrHZDdFCdik103HTsWEKdhtfpZqnRWMxjlVCKi/2iU4AKGJxVSTRXb
         1Go6bayeTgCphYhOpgVH0n3pD2ViP6RrVllfA+Y+L/fZ6tHIz4pGPXh23n6YBqWYQb/6
         8sc25zkx30frEzKx2UUFHp/imtc/z2jHsYtWSbXrjcynYYQUf6jf0cbeaNaTnRh043uy
         KKzw==
X-Gm-Message-State: AOAM532THbtvX1Vfge4uag0rNYoua8yv0LcmQY8PKKlLApIt/Xr/+ZY5
	w5iOpbzlFvjrkxJslyzyMucOdxrnVkK4s9hFltzZvma8iyofFQ==
X-Google-Smtp-Source: 
 ABdhPJz6F1fN1BjJgdoyfm9ttX0LAUL2SgjiWD7hPZqQ550rLZuaQPnmWLYcGxd/J1KzuhpAWBRDDfmNU8dO2hYwijw=
X-Received: by 2002:a05:6870:9615:b0:e7:c74:e993 with SMTP id
 d21-20020a056870961500b000e70c74e993mr13003425oaq.87.1651100648424; Wed, 27
 Apr 2022 16:04:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Apr 2022 08:03:32 +0900
Message-ID: 
 <CAODzB9oesm1jaYyjfyziBx=2UPaZrUNRA+yuMOutFqKFoZT61A@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Apr 2022 23:04:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8219

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2022-1419 : drm/vgem: Close use-after-free race in vgem_gem_create

CVSS v3 score is not provided

Fixed in 5.6-rc2. An attacker should have the privilege to access drm
to abuse this bug.

Fixed status

mainline: [4b848f20eda5974020f043ca14bacf7a7e634fc8]
stable/5.4: [3ea7f138cec139be98f8bb9fc1a6b432003f834e]

CVE-2022-29582: io_uring: fix race between timeout flush and removal

CVSS v3 score is not provided

A race condition bug will cause an UAF bug.
io_uring was introduced in 5.1. 5.4 doesn't have io_flush_timeouts()
so 5.4 may not be affected by this issue.

Fixed status

mainline: [e677edbcabee849bfdd43f1602bccbecf736a646]
stable/5.10: [2827328e646d0c2d3db1bfcad4b5f5016ce0d643]
stable/5.15: [ba7261af2b030ab2c06189be1fc77b273716839f]
stable/5.17: [11cd7959400258beb1dc17c8680055966263f316]

* Updated CVEs

CVE-2022-1263: KVM: avoid NULL pointer dereference in kvm_dirty_ring_push

The mainline, 5.15, and 5.17 were fixed this week.

This bug was introduced by commit fb04a1e ("KVM: X86: Implement
ring-based dirty memory tracking") so all stable kernels were fixed.

Fixed status

mainline: [5593473a1e6c743764b08e3b6071cb43b5cfa6c4]
stable/5.15: [226b4327ef5c88572fc12187193f1b5073c10837]
stable/5.17: [e8d7f0dad29e634e26d4614cfbd081514c16e042]

CVE-2022-0812: NFS over RDMA random memory leakage

This bug was introduced  in 4.7-rc1 by 302d3de ("xprtrdma: Prevent
inline overflow") , then fixed in 5.8-rc6.
4.4 isn't affected by this issue.

Fixed status

mainline: [912288442cb2f431bf3c8cb097a5de83bc6dbac1]
stable/5.4: [c8a4452da9f4b09c28d904f70247b097d4c14932]

CVE-2022-1204: UAF caused by binding operation when ax25 device is detaching

4.14 and 4.19 were fixed this week.

Fixed status

mainline: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
9fd75b66b8f68498454d685dc4ba13192ae069b0,
  5352a761308397a0e6250fdc629bb3f615b94747]
stable/4.14: [ef0a2a0565727a48f2e36a2c461f8b1e3a61922d,
9f444dedb486b9e184bd774caebbd09733ccf859,
  b8c07f33aa35dacf5444e7053ed9662d1869f536,
c44a453ffe16eb08acdc6129ac4fa0192dbc0456,
  62accd4682d1d85290a9859091d201e6a4701205]
stable/4.19: [e2b558fe507a1ed4c43db2b0057fc6e41f20a14c,
a518be5772d36fcd0e4815d156e06feb137aad82,
  b1e0a6fc7f17500484c402ad1cd018c24dfc14b3,
de55a1338e6a48ff1e41ea8db1432496fbe2a62b,
  1bf1b2a8a2caf9bc0d3cf1aa903a8dcaaa4371d0]
stable/5.10: [5ea00fc60676c0eebfa8560ec461209d638bca9d,
5ddae8d064412ed868610127561652e90acabeea,
  57cc15f5fd550316e4104eaf84b90fbc640fd7a5,
b20a5ab0f5fb175750c6bafd4cf12daccf00c738,
  a4942c6fea879972a7fee50f7e92e2e10f3fc23e]
stable/5.15: [9af0fd5c4453a44c692be0cbb3724859b75d739b,
bc706d89199b0d8ee5e2229e18fdb9c0720f6ba8,
  b982492ec3a115e0a136856a1b2dbe32f2d21a0e,
452ae92b99062d2f6a34324eaf705a3b7eac9f8b,
  1bf8946d5826788c82971977245bcd3313678eac]
stable/5.17: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
534156dd4ed768e30a43de0036f45dca7c54818f,
  01619aa347d35ac8b79751757784ec6f507a3215]
stable/5.4: [418993bbaafb0cd48f904ba68eeda052d624c821,
1db0b2c55c934a33b6fa4d4a4865f5a5be641344,
  7528d0f2210c3a1154186175516ed37aa970f2b1,
9e1e088a57c23251f1cfe9601bbd90ade2ea73b9,
  eaa7eb23fa76db45f7da1b6192518705863d0ebe]

CVE-2022-1205: Null pointer dereference and use-after-free in
net/ax25/ax25_timer.c

4.14 and 4.19 were fixed this week.

Fixed status

mainline: [fc6d01ff9ef03b66d4a3a23b46fc3c3d8cf92009,
82e31755e55fbcea6a9dfaae5fe4860ade17cbc0]
stable/4.14: [331210983ba5ce82bf63b827bca0e1c833f293db,
093ab7f96dd3ebaf240fee02d6752c6b0825cc0b]
stable/4.19: [512f09df261b51b088f17d86dbdf300a3492523d,
3082f32c45465b692c314131c2a3657e0c23e09d]
stable/5.10: [f934fa478dd17411bc6884153dc824ff9e7505d8,
5c62d3bf14100a88d30888b925fcb61a8c11c012]
stable/5.15: [43c107021d9160f6a1610bafba6dadc0323ae548,
85f25bb9a0051198af48ac2f3afc9f16f2277114]
stable/5.17: [a45dba71849a963c427637b3330e2ccf098f42d1,
76ff66bb3b22f202c226ddbb0a811f8fb8aab2fa]
stable/5.4: [40cb8b3b19c087a4e20f6740701e53fefbe19a7b,
a83a18c4c9033fb6604c587f52a2d78857cf0ac2]

CVE-2022-28388: can: usb_8dev: usb_8dev_start_xmit(): fix double
dev_kfree_skb() in error path

4.14, 4.19, and 5.4 were fixed this week.

Fixed status

mainline: [3d3925ff6433f98992685a9679613a2cc97f3ce2]
stable/4.14: [a5e2259173eb52a728bbf32e02aa9a388451e614]
stable/4.19: [8eb78da898079c0d7250c32ebf0c35fb81737abe]
stable/5.10: [5318cdf4fd834856ce71238b064f35386f9ef528]
stable/5.15: [f2ce5238904f539648aaf56c5ee49e5eaf44d8fc]
stable/5.16: [3e006cf0fb809815d56e59c9de4486fbe253ccdf]
stable/5.17: [29d6c06168faa23ce23db3321981c8fde576c95c]
stable/5.4: [660784e7194ac2953aebe874c1f75f2441ba3d19]

CVE-2022-1199: Null pointer dereference and use-after-free in ax25_release()

4.14 was fixed this week.
Added commit cb18d72 ("ax25: fix NPD bug in ax25_disconnect") to 4.19.

Fixed status

mainline: [4e0f718daf97d47cf7dec122da1be970f145c809,
7ec02f5ac8a5be5a3f20611731243dc5e1d9ba10,
  71171ac8eb34ce7fe6b3267dce27c313ab3cb3ac]
stable/4.14: [a509dbde35fa51d140512cbcf50068a84fdb7aad,
0b0ae8b9813b84f73dfcdec197b6455844ae6bf1,
  d03aba820f1549c9f3b1d14bf48fa082663d22b5]
stable/4.19: [3072e72814de56f3c674650a8af98233ddf78b19,
5ab8de9377edde3eaf1de9872e2f01d43157cd6c,
  cb18d72179bf42a6ccd2b311739017b0ba9bc26e]
stable/4.9: [851901d339b2ba766ffcf754d37a6f52fa07cea2,
cad71f1094834eb69f7ceec8100d300c26b43053]
stable/5.10: [b9a229fd48bfa45edb954c75a57e3931a3da6c5f,
e2201ef32f933944ee02e59205adb566bafcdf91,
  145ea8d213e8f46667cd904ae79d17f298750f00]
stable/5.15: [4c958f0c5714812461da7785393315b35145ac8c,
da6509fba636f7f8b2e902b1e4742fdbf1bf059f,
  46ad629e58ce3a88c924ff3c5a7e9129b0df5659]
stable/5.4: [cfc8b37ef0418529e3719c2d128e59e74a3114b0,
d2be5b563ef391f684592a28440067f4fa3735f4,
  0a64aea5fe023cf1e4973676b11f49038b1f045b]

CVE-2022-1280: concurrency use-after-free between drm_setmaster_ioctl
and drm_mode_getresources

Fixed in the mainline. Some patches were backported to stable kernels.

The mainline contains the following patches.

b436acd ("drm: Fix use-after-free read in drm_getunique()") was merged
in v5.13-rc6
c336a5e ("drm: Lock pointer access in drm_master_release()") was
merged in v5.13-rc6
869e76f ("drm: avoid circular locks in drm_mode_getconnector") was
merged in v5.15-rc1
5eff958 ("drm: avoid blocking in drm_clients_info's rcu section") was
merged in  v5.15-rc1
1f7ef07 ("drm: add a locked version of drm_is_current_master") was
merged in v5.15-rc1
0b0860a ("drm: serialize drm_file.master with a new spinlock") was
merged in v5.15-rc1
56f0729 ("drm: protect drm_master pointers in drm_lease.c") was merged
in v5.15-rc1
28be240 ("drm: use the lookup lock in drm_is_current_master") was
merged in v5.15-rc1
2bc5da5 ("drm/vmwgfx: fix potential UAF in vmwgfx_surface.c") was
merged in v5.15-rc1

The commit 1f7ef07 was reverted in
5.10(https://lore.kernel.org/stable/20210628142607.32218-97-sashal@kernel.org/).
Searching in lore.kernel.org, the commit 869e76f looks as if it isn't
backported to stable kernels.
Searching in lore.kernel.org, the commit 28be240 looks as if it isn't
backported to stable kernels.

Fixed status

mainline: [b436acd1cf7fac0ba987abd22955d98025c80c2b,
c336a5ee984708db4826ef9e47d184e638e29717,
  869e76f7a918f010bd4518d58886969b1f642a04,
5eff9585de220cdd131237f5665db5e6c6bdf590,
  1f7ef07cfa14fb8557d1f1b7a14c76926142a4fb,
0b0860a3cf5eccf183760b1177a1dcdb821b0b66,
  56f0729a510f92151682ff6c89f69724d5595d6e,
28be2405fb753927e18bc1a891617a430b2a0684,
  2bc5da528dd570c5ecabc107e6fbdbc55974276f]
stable/4.19: [7d233ba700ceb593905ea82b42dadb4ec8ef85e9,
a376f7e66b654cb290fa9d16d8dab5bfef744463]
stable/4.9: [8e250a134c8fe2a945d10b421d0ccb54e85d8683]
stable/5.10: [491d52e0078860b33b6c14f0a7ac74ca1b603bd6,
aa8591a58cbd2986090709e4202881f18e8ae30e,
  54e51d288b38377e8cd645a83e1ad08cc9d20ccc,
06a553a99bacb00d3bc25f79e75c8e0fbf7a5025,
  34609faad0c9f9f08d4b59d25c94b78bf5710d93,
d6c91423993e8164ca4162ff046c6437bbd75b53]

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

