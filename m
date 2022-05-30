X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.38978.1653929491189815605
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mMyDVkFJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id y189so10983711pfy.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=r6ZdquzT4ugimmTaUJDd6l0/eBGBjC/IBPkoZfyaCY0=;
        b=mMyDVkFJwdmNA5KJgtltYSOcfxtG1MhqTvzNF3BqclSIYzQLJ4lFAqeCMz7DzNR/vP
         q+KiuJB+27ieIU0weBieCsX1aMjCNp7fJh2F18P15XetuAzn0zy4uXfBJCU65i0OFhE9
         H7TcQc3oKQ4wpzfLajHgf4Y2c/X+VJkq42as0WmOZeAA7jQFLFnln3n2liS8w45/fv7W
         oo2+oqsMI0fxNTHmh/pv7Sw4gVv59ZaaGeGf9ivjFaDFQoeNjoWW1C7DtrjxFu4Om4Yd
         XsYA8pwItL7UgJ/ZntJtR7n38aR2UwMmtJVgUP4+/ufwQzYujzGTOwpdAADXdT983SIZ
         SHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=r6ZdquzT4ugimmTaUJDd6l0/eBGBjC/IBPkoZfyaCY0=;
        b=0ycXnfbgAZQUI86LkxH5dBJZnMYNtMnhWTlRnmzdBDIyL56OBcftMG6KBBG3E+h8Cv
         CMZcyveqsIjAdijChgE0BJ+QvAMc6V4TNQF59nWjCn/6Jqn1w3PAePGafw0/t0vv8AIu
         Foj4MjTu5zoURvdWaewm+zISWh3FX/9gFU8gZqiJis6uxEogZe7AFUMyOeZO/Fjm8nKk
         xSi6F6W21CbS+nANOM214taQdoZRtDOxnRbqWYO6D4I1Ie+gYL5RJ6QbgKA7cbGsRGma
         V7My3e8gH+V8MsYcSXioALgyALf1lJI86fvVmFALn/7k/J0ytdo1IMU6c9VjlS5liuuH
         RqAQ==
X-Gm-Message-State: AOAM533OZZdGnMc7oaUhgkzwNRdusimYvq14YVz4UF21bzPwGjrpO7a4
	O/ApmBs3swkQAEr5stRgj63mUxttaik66NM5pjM=
X-Google-Smtp-Source: ABdhPJzW0GYlWam5ma+NVOhoV8kxQ5xj5VBT/BcUws7TlgGbfHMvmqTvAWGU8B/M3Pg+GwcrwoZf7g==
X-Received: by 2002:a05:6a02:11c:b0:3f9:e159:5fa5 with SMTP id bg28-20020a056a02011c00b003f9e1595fa5mr40138052pgb.245.1653929490418;
        Mon, 30 May 2022 09:51:30 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090a029600b001e31fea8c85sm1230764pja.14.2022.05.30.09.51.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:51:29 -0700 (PDT)
Message-ID: <6294f611.1c69fb81.7da57.2547@mx.google.com>
Date: Mon, 30 May 2022 09:51:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v=
5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  83978df41846c88a0d491b9cef3e8cecae02bef4 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e8bd148f63ebd4a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/x86_64/x86_64_defconfig+x86-chrome=
book/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/x86_64/x86_64_defconfig+x86-chrome=
book/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6294e8bd148f63ebd4a39be9
        new failure (last pass: v5.10.115-cip7-81-gd05f72e501084) =

 =20

