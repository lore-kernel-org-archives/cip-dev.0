Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69013C001DE
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.53524.1688455558474342838
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=y1QlDLA1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6687446eaccso4027771b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455557; x=1691047557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDJYuPg7se37hNA1cobKE7VATeGd1sWZh/TzuGZveKs=;
        b=y1QlDLA1AheAqD+mfDMrwQ21Q5LuYT7KGGBrCjv3Hm4U19TGfyJFfPYQDmm3m4DKrB
         poxDMpow62uGgRhAe+GxMkwqODkgCKCUoMSmIHYcfgqhXMbzUnU14sUDxsAyk68pte+Z
         a9NzW6HWfkTgqoYSxHppx2zvjQF92ejuDN0kqmjhhSUlXFen/gzr0XDzJ7xpo4+Utmcn
         wtF8AHtKV9X5c4NXXVVng2MmhXLGygfrX1/M2g7JEbYzzuhV3o7gR5eEqMQnvVbS2ooW
         j0hgXqni4Ggy3YXplvF2tS4TVPqZ+GSECvHE+VcndC0TMCZj1qBa7wlVNqSYPcOG94Lv
         zsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455557; x=1691047557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDJYuPg7se37hNA1cobKE7VATeGd1sWZh/TzuGZveKs=;
        b=PxEpQUUBZcjO3PWKI4UxLrZHXdqIK+SbbvxYVB1LZgzr7xb4nmA6mU95T9QxByoQ6I
         kymxfwS8hiu/+Mnkz9whbDaOmAiW2GKB+77pMO0xXAsX408tgea6J9+QIuvShvAhkyE8
         2Z/SMFzQ8Kl9R5fmV66sOzvsEe53kWQgftRkR2A/tH6/Di7GMk+JuxI5VqupBnLJj5u3
         mG1JH1WOb3aOSh6W6KASzmKl9AbLH7Xfl3aEzsrD7Hel/KST+h8JG5wEW43cyqRqs81u
         Zz0laN+kiENKhdXWd68tBFV0gis+U7J3l7Hde2aWFdsEYX4Bk/z81hK7+ilp0ZLc2VAV
         5Djw==
X-Gm-Message-State: ABy/qLYUy08AlcR6x7UYV9DeMRo7RNdvrqgTKjKc7NSe+X+lfPivNBI8
	W8B6Mmb9sqqJh54jxqRJBXwxYjb1tJmarRIHMZPlIQ==
X-Google-Smtp-Source: APBJJlHWfjZjOCLd0sj+OvGhnp/rVg38PNDWMcFdXFOXb/LeX17HLv3sLy9jN8ar9txuzsD3DjuQ6g==
X-Received: by 2002:a05:6a00:9a8:b0:677:cda3:2222 with SMTP id u40-20020a056a0009a800b00677cda32222mr16828985pfg.14.1688455557537;
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w6-20020aa78586000000b0067b384d5955sm11420016pfn.26.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:56 -0700 (PDT)
Message-ID: <64a3c984.a70a0220.86698.6d94@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 2 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12206

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regre=
ssions (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b9da1438dd721cbb2a75

  Results:     37 PASS, 17 FAIL, 17 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_HEAP_SIZE_FROM_sh: https://kernelci.org/=
test/case/id/64a3b9da1438dd721cbb2a7f
        failing since 19 days (last pass: v5.10.182-cip35-8-gc3d08808cfa7, =
first fail: v5.10.182-cip35-191-gf4efde512959) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3bc5e4daaed05afbb2a87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A2005=
7-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A2005=
7-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64a3bc5e4daaed=
05afbb2a88
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

