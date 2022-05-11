X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.11862.1652278176932696167
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 07:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BzwNhF+u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id x88so2362713pjj.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5qE0Z/1a9VCsyVWDay1k+qr3lUxL/QUwrH0pzYQJYiQ=;
        b=BzwNhF+uSGr+XHMqHNg/Mvapk4tOVHJu48VoxZIhgMKVdToi0nRpp57zIFCcp8ZehO
         HCcxiHAMMh90KmL3LvCAb92yBuWhtBlHKCIehypnDtoGEg4xgn8sAuqBrEjqAQx798G5
         17mOpdOp/VjONSC8R5zAIuwYBrjlvnF6BkMukwqmusoDyn/9twOaC+bURMZBOfp9F5Tf
         6GYhqzcxXzVcsD7hRdGuTFVv69mL8Ruflvwa6CFtdXfHdIjdIuwRupmXS2xq6gyvpFK5
         n9mKlmkOOU9Y1nAPslGhy1ZEe5BbeVk70PVGon+8ficuZSOgewej5m5rx722Kwdl5lkd
         xvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5qE0Z/1a9VCsyVWDay1k+qr3lUxL/QUwrH0pzYQJYiQ=;
        b=7jFUKcPvbq+gohsmL2tEAJfQXfO+lVK2YKaJB3Ltzzi531OsczTmd7hoN/FBfbTRZG
         TWrGO3u0j4zgNAo988iF5RItRBgXrbnAVF9CXqbNbE3GXAcvhT1tsfTDWbLmeTMV85rV
         xWJR5cBXFSQIx5Kah1KqFGh+9aZTuZJ4ejm+VApdcNENa8Vo/FEEz79mx7cnxSACk6LT
         ZuCyt1tYnAD/AxopXPo8If3QDN5kuGBnCgZPx6OgTvViucBGhUHnaCVcJl3VG1VQ1XCj
         HKyL1jH4q5IDfcALgoyCQZUgjg1IvqQOdCpt6Kin17K/zfPty4cr5a/rhygzbHu6DmJw
         MeRw==
X-Gm-Message-State: AOAM5310TrKKHBsvY9u8l9q/O1uS73GRoCO13OMd+iAiE+EPMI2ZQnyv
	t/cfMYurSn1zCGbOXJS1GyKZuA1YfhNqNmXqFOM=
X-Google-Smtp-Source: ABdhPJyD3zx1TRO/OCuxy9M3Vh9PAppEeE7rfCmx4qwBxFZRmxQzBejoIUAUMMLaEIvkOusD5R7DFg==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr24894742plt.101.1652278175916;
        Wed, 11 May 2022 07:09:35 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090abf0d00b001d9e3b0e10fsm4041221pjs.16.2022.05.11.07.09.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:09:35 -0700 (PDT)
Message-ID: <627bc39f.1c69fb81.8c57d.8fd3@mx.google.com>
Date: Wed, 11 May 2022 07:09:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs, 3 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs, 3 regressions (v4.4=
-st5-17-g04a3c17cb526f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bba94a6b74170668f5724

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/627bba94a6b741=
70668f5725
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb8f0ba5be7a57c8f5754

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/627bb8f0ba5be7=
a57c8f5755
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bc100782b18f61d8f5754

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/627bc100782b18=
f61d8f5755
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

