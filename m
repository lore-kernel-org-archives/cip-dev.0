Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05627C433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 05:04:53 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web08.52436.1656392689396611397
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 22:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=s6Jx1e1C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id c4so10033301plc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UQCtDAxmONt0Em+L/4EjYBT4uxT+54yS2j1iYhUbe0c=;
        b=s6Jx1e1Cb2INsJCkRP0D27eRzTNjrZJehL0vHw9R4kBjbvjAGOrFwUrTy3tTsYN9xi
         JrDDx6MwXsq+fZDHf3UPgPgVowsWO6EfP+duCnug9R/dRy7t7uop9tBwpT1ZaBcxnmt3
         pBX/EVA21xQdxKKTDGi9pi/2Vv17JTQKKvmr19uEjTVM+sVoRszRl2hNZcIUGOvbaA/D
         iutnFnQD0iHpTPaeTYu6agAEidAOCBJXskLh7q+q1MLkVKn7KEpTGzBBjBPtNLaFAmyR
         aoK8HXKt3QRkdnGTwhJBgtILQzWJU9YIxQuFAP51U3G+IRchNAEDNwDz7W7tpRttF24Z
         8wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UQCtDAxmONt0Em+L/4EjYBT4uxT+54yS2j1iYhUbe0c=;
        b=TD0XU1mDI9GHiLVtUchQjXCSiOVgU5u08RIrFMSEf/2vkfFBmKhHoVjOnB7WLSxl1T
         OEtCGXfI4BI44l3aqFUFVSifuITlCunhbFoRFdbqY2rrp81mURvyBRcUbIO0OJeRvIsP
         amzcWczzBprzkvyGxXjzt9j0XidpHrg69u2wk4jjvep8dptvjuKMmmw8aYGKUBI5Whe4
         oStL/SAAikc17loyv/qJeqSLkT/8isiWVWDgZcVMzp60xc9UmfaLXj+RD0KfMrC/84Zi
         o6sfheyNJvutoPSPOx+8JXfyOTCsgYEVQ6FyNmGL70xFJdoe9o7ZDZBUELYc8i3tiVIR
         6HJw==
X-Gm-Message-State: AJIora/IGHMy/xqZTa2wXxtHBiHAmlgyU2onsg4ynUayQIYoVqvktsXa
	AcrVkltx4SPNARndvKvb/zOhjSIsZUfe9Ubs
X-Google-Smtp-Source: 
 AGRyM1s5kX+Cw4g9RR4/UzbePFA0xNlXPPul6mEJclQ5UMIo5GBi4tBC207Eb4KM1m2vZroAzkFjAg==
X-Received: by 2002:a17:902:d48a:b0:16a:3e7f:db21 with SMTP id
 c10-20020a170902d48a00b0016a3e7fdb21mr3177122plg.50.1656392688676;
        Mon, 27 Jun 2022 22:04:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c16-20020a170902b69000b001678dcb4c5asm8154240pls.100.2022.06.27.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 22:04:48 -0700 (PDT)
Message-ID: <62ba8bf0.1c69fb81.b0664.ba84@mx.google.com>
Date: Mon, 27 Jun 2022 22:04:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.125-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 05:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8621

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.125-cip1=
0)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.125-cip10/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.125-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93e5c28cd0bdd8a2d89059fe7218ce98dd7c81ce =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba77bc9c15ef5434a39c80

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ba77bc9c15ef5434a39c86
        new failure (last pass: v5.10.121-cip9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba79170cd85320a3a39bcf

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ba79170cd85320a3a39bd5
        new failure (last pass: v5.10.121-cip9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba77e4e6ef36e87fa39bf3

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ba77e4e6ef36e87fa39bf9
        new failure (last pass: v5.10.121-cip9) =

 =20

