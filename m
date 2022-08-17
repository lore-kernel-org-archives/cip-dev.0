Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C3C3F6B0
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 01:08:21 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web09.23887.1660698491491122847
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=txCXBoEG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id pm17so11167715pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Sbo3q0iOhaFk3gc6WPXXk471PbYDE9teMiC1zatV0nU=;
        b=txCXBoEGVqIvdUe2oLxoRl7mrE2GoYiVzCF9970/fNta50Dh4nLaBQhnVsX6yv0l7H
         Q3cymlbBRn8xh4FhCNJobsVVBrS64qNTLgcDr68HP/OpDcALyPPwe7BICisPJk6pRH4K
         4oBxvCCODEpZbUrJWHoNr7lY7JDURjVkijsnIiXYSjEMYRHgvu2EyHb8PNt7kIxdOEFx
         jS7C+pAqRD2vouCwT4z1OlMNrHlYt6WsWhZ5RWnQzQvlgdxdMc+Rqt0RzLumwcC7z5+W
         vME+k54ZM04JiAwL51X4p6fCpq04WWbndB64R2KDDiDR2bILLqv6ayc7lhmMgb2qXYMC
         Kq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Sbo3q0iOhaFk3gc6WPXXk471PbYDE9teMiC1zatV0nU=;
        b=k3Q3dZkpTSdiSkpGP/phKTSM61PA2JvvZlbA7mYMlFeXQ6E8BZ9QV2oEAVfU/gL3H1
         h2E5g0m4MqAaLTDx+wPYFy507QcU6Cjpl+cLuBoLBpztv8LmZz6+x0SBs+ayYN++7t89
         EzsBKJ/K0EVFb44VOfTT/9PPLbG2rXwIEA6oK2ubLDvTenUrCyQi9G1tY3a9hfl6JQsE
         5lguvZ3+qOMsQp+xxL66svbjN2b+Mpkgpb0f9sZOOXyf13Jm0JncCqW53O6vNOLlolPB
         fQTa0bIlFsOcKHFrSwqVFwdIPQif+MAp7ggSeJ3hH96zXXNZoj/gaiY4NH0tIhZSMdoX
         NShA==
X-Gm-Message-State: ACgBeo3Y9gCI/dz85HGpbIFJeME7ipulGakiKCb4pNedwcZY6Yje98LW
	TP+jAULYK3K+EUVMV6b18EtcaTBIeRK22xJF
X-Google-Smtp-Source: 
 AA6agR7P4k6Ns7oXVnYtDA9u/pepwuo9LyjX2cSUt0icCLDbIzAUXR0UBxDDkGtjuN4cirsrVhrg0Q==
X-Received: by 2002:a17:902:d4d2:b0:16f:8311:54ba with SMTP id
 o18-20020a170902d4d200b0016f831154bamr24102162plg.15.1660698490753;
        Tue, 16 Aug 2022 18:08:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n15-20020a63590f000000b0040c52ff0ba9sm8223045pgb.37.2022.08.16.18.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:08:10 -0700 (PDT)
Message-ID: <62fc3f7a.630a0220.e50a4.df32@mx.google.com>
Date: Tue, 16 Aug 2022 18:08:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs,
 2 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 01:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9266

cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs, 2 regressions (v5.10.131-cip1=
3-49-g1145e9c6352e6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-49-g1145e9c6352e6/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2d4222e7b790ae35564f

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62fc2d4222e7b790ae355655
        failing since 49 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2d7f56f430fcb63556a6

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62fc2d7f56f430fcb63556ac
        failing since 49 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

