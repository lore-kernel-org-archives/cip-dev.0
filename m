Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA7C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:30:33 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.42915.1679491833418994899
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7q97q9t3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id w4so11192380plg.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679491832;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8KGLb31EQerhUdfgZ911t131jlSkQzJ5Z1CHyNbROkg=;
        b=7q97q9t3EVTaaIbHPF5kGAd0YOQWADmb5ep42nopl2HgPVACRdn9Afc1yte2lJbxfQ
         NjLT54Ld4oA+2Os0EOh6fhLsAC9d/z7bUtzCJUxxkcH/Z4R9SnYKSYn+kjr79FHlFer4
         RXsi9Xf0P5TmJV/2gtLL3jb4zI45TibDzyid3IujYYi5nXJbFCNQkRqh0jXOeHHDQL6e
         4REVgf0XjBn0C/9V6Scp94a9ei9ei+yQ1PcGOYvm/9M6mjtxtvlXbPuIH2NomDF+vBT5
         cNIMZBuZEHL/511Uj7liSJUjqSpm+dbaV0nb0Mu24SoWX+ypyBvgUrmBxAEfw5maJOcz
         0jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491832;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KGLb31EQerhUdfgZ911t131jlSkQzJ5Z1CHyNbROkg=;
        b=Ssr4XHkE+VlJYN9W2O5KXJDihMUqqSUgTFsnVGx5/TmKV9dTq8bFt6Gh1weC9tu221
         E3EzDcoTfte9cT2f1uB59LgRyC6SodXpaazkEgM1LWkY9mXPX1w9oGbrvoXuvGNc4up1
         RRlGTPp0REPjrClKy1FN5fQvsKehu/0r9FgylukHZAEnTcU3lCuWyk+4/K4L5c/1CAEd
         67lBsc1g0fR9WW6aHektYv+UGrhSETiyaJVOd6lIz85K0oSgT9XkjpVYhDjX1z7eMV2B
         O8fiy20tQq/SezL9b3K31WbeS5ZkRQITCD6lkH2OVE5qDkXo/MH91YDzgG/x+3hH4Vl+
         dvUg==
X-Gm-Message-State: AO0yUKWGzuqRboDC5ccfVyHFha0m5JPx4rFgP+8CGiDhd/tX/axohavo
	tfrlNdpAW1uaF9ruccLoGT7AMsneM5i0G04zOwTPTA==
X-Google-Smtp-Source: AK7set/xX5Jl++W4h2Ywg9NPZEhexAy4BAbg1kxdbUNZ8bFTvsgkQAgWvOrQ0RXzSL9NmTnhakA+sw==
X-Received: by 2002:a17:90a:e7c5:b0:23b:3422:e78a with SMTP id kb5-20020a17090ae7c500b0023b3422e78amr3858856pjb.6.1679491832622;
        Wed, 22 Mar 2023 06:30:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b00198ac2769aesm10527595plj.135.2023.03.22.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:30:32 -0700 (PDT)
Message-ID: <641b02f8.170a0220.c1914.34ec@mx.google.com>
Date: Wed, 22 Mar 2023 06:30:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-rt29
Subject: cip/linux-4.19.y-cip-rt ltp-pty: 8 runs,
 1 regressions (v4.19.277-cip94-rt29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:30:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11080

cip/linux-4.19.y-cip-rt ltp-pty: 8 runs, 1 regressions (v4.19.277-cip94-rt2=
9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.277-cip94-rt29/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.277-cip94-rt29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4aae0db35a10a9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641af4aae0db35a10a9c95=
06
        new failure (last pass: v4.19.269-cip88-rt28) =

 =20

