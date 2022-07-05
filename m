Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE31CCA47C
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 04:24:45 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web08.80639.1656995080412657046
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=OUFBA1qt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id q82so3200517pgq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9q7Fm9A2vp+pIFJ1sb3Z8YJvz9ms/wyIeVULS6S8U5s=;
        b=OUFBA1qty9oA4ZIJ23wp/Sn32NvseCj9fFOxgu5qtqVNBLCkwyTrEbl4OAE7WWgaWX
         WJH+S4meSOJI7Cr43ie93D7fo7EiUNqJGCVkLILtaleaImTQ48jOKZV7/i6QPQPiNDWr
         kbE/3XCa22yYnw2N3cqQBhkZ4TNncjG4D7Acz0dkpUEAwoZ/8ec+kS1JVx9vuJ/CQwRN
         YnYBFk3nVPQV8uHS6eYsVB3NmxlzQUz5u0TUOWfobmWDKB/mJRVDpFTL/iSt4NM0/hSx
         lxyx/XNYWjS3wxDA7HQxFMVEaRWQoSSYzLhZXj4/QDgO3KGGrvk3R+csHGTSlr9QqrRb
         2giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9q7Fm9A2vp+pIFJ1sb3Z8YJvz9ms/wyIeVULS6S8U5s=;
        b=5IJJEZFjlZfFFBrYFQvD+YkOCpyEsjHpdSjLAH/zHbzZbU/RuxUoj4gyQWdWnTJtE/
         sU+1/v8zGT7j+nObWOvhqR4lpnHWVzg9nVVYJFn2vVFQsVsn9C29rUV8IRHFc06sXuMW
         Nns/SlDhuUQet+OhNTfIgxbNQB/r796szXOeL/YAEqYnzsIQhCxRp3wgJTFkvSUhpC0n
         FfOVnNMcMEMVsp+00RCpHYm8/yZLr0R7v/0iCaLbfHyTyux1x9LoPhzUq/sNrHmsiC3d
         B0taNFkzoyVV7rC3H2M66Hbr+lZPufjNxjS7ss2M9Vspnw5dONspZpdNGdXhoiGX06cF
         Vz4Q==
X-Gm-Message-State: AJIora9uVsERCzms546MiXzqTTCHZ+hI9SxoKP7fMvnZq48jCBSqaAZo
	1MqZoXYssuc7xfcT4YrHoVODQFCAg9iGhIkB
X-Google-Smtp-Source: 
 AGRyM1uJTnSJVMwahzgD3cSwkKpJnn8v8sZHueKRjqdv1faPDR5Pp2ov7+ZOm55hJxIppFItW1VCbw==
X-Received: by 2002:a05:6a00:1394:b0:525:2dc4:cff2 with SMTP id
 t20-20020a056a00139400b005252dc4cff2mr40510873pfg.5.1656995079527;
        Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k22-20020a170902761600b00167942e0ee9sm22111303pll.61.2022.07.04.21.24.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:24:38 -0700 (PDT)
Message-ID: <62c3bd06.1c69fb81.aa194.fd34@mx.google.com>
Date: Mon, 04 Jul 2022 21:24:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-120-gf70f522cb972
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 2 regressions (v5.10.125-cip10-120-gf70f522cb972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 04:24:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8670

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 2 regre=
ssions (v5.10.125-cip10-120-gf70f522cb972)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-120-gf70f522cb972/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-120-gf70f522cb972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f70f522cb9729264739dd5a10a8e68d86241981f =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a98e467eeed2baa39c33

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c3a98e467eeed2baa39c39
        failing since 10 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a9770f09249fcea39c30

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c3a9770f09249fcea39c36
        failing since 10 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

