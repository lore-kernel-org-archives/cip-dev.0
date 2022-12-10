Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A3C4167B
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.6171.1670638769298450915
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XQd2teFN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so10018428pjr.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6vfY9A3bM/f39fk+XmjfpVyLJNaz/xyJNIRJZL5g6tU=;
        b=XQd2teFNsAG7jbwsJUkx5DbuQVlvPAqS7lzmIGF598pkS/wQ2gip8ycgBRctGz15FO
         ramMkKVc4cSe57/CoPTg7WhFnbvP7lmaAFCzB6Xs6kPCa7fYchN10E4StJA7DVdYBucA
         fMqHYfGZhzIzqwYo0t0tme3HAUNnDMM5dO4DY1FB02TuZHHZtFPbkRIRWPn1mDE3Seec
         UPNoC6v54GShd8pTHfaHB75skBb3wK2faMlKJgUN2YfQW6fm5g0LLWEjCWojCfqeomLT
         CHmX7x0yEm2NWIyF2toZnLEB1mtcAcc6ArVSz0zshlW28jNXKzQcbfhp8pNL+cP1iEpT
         eghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vfY9A3bM/f39fk+XmjfpVyLJNaz/xyJNIRJZL5g6tU=;
        b=NwZIqbq+UAwxCRadVV54lGgP6Nh/RlNWYxMTwLfq0i/IqlvqJFGWO8tCNHgUhercoz
         Z4T9DrxGtuQnBxCHjRbTVWA/GyfL9pOujbcmaUNHIreAZaBW/09J6hlyspBcUHlMOIvN
         rzwlkfJP5cqt4vAayXk1i19T4/qFplaN2k8njEgtJQ4e8tCqXQzBE07NlzFy7RoEi/Rg
         8Ld0VSizElA+pZjYgJYYsBJKYf5/Lon5D3IdEnHksopBgzT9PAH2H/+xPWLJKfmS5efY
         9lba/nz6grpv4jF7tjnuHeE75wXJ0LbEQFi4cmYmdm7RGqqkyHhVHBLGAQJtv8r/1LT6
         whgw==
X-Gm-Message-State: ANoB5pk2mYNVrJ19h2GF1hAGDQTrqa1rYPuDW8Dep3YbHh3XrPvr27qX
	999xYVSkTvOEY1MLuKBqYR6eoEdD28XyGbPDrSs=
X-Google-Smtp-Source: AA0mqf51EQQXwy2uEhI9gKqlzHLhhauimSTXVnsXgphnuKTBSx3ZJ9VAI/DlpbzGWyarsO3TR/X8SQ==
X-Received: by 2002:a05:6a20:6983:b0:a3:9d91:b6a6 with SMTP id t3-20020a056a20698300b000a39d91b6a6mr11687532pzk.35.1670638768381;
        Fri, 09 Dec 2022 18:19:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 1-20020a621801000000b0057462848b94sm1792272pfy.184.2022.12.09.18.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:27 -0800 (PST)
Message-ID: <6393ecaf.620a0220.2e0c6.3f07@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10187

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.15=
8-cip22)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6393dfeea49d7bd1fa2abd76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6393dfee=
a49d7bd1fa2abd77
        failing since 35 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =20

