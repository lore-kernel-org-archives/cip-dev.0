Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30207C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:44:21 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.104558.1701985459667396034
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:44:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=iKxKxzpD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2868cf6cb82so1263290a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701985458; x=1702590258; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GtonhtxxLec7jGLosk2eY42ZY+2k/Vkm46yecdRU1X0=;
        b=iKxKxzpDZuDHVQ5KJWdsJ1Jc21WnDKiqbj/5ZS44xIJj0l2LCwo7RnBeH+25NVlVGS
         WeOtmagc1easwztXx/mRx9oQbpEdamvZ6369rLsYI1PGaYD+dCYyh/t+n5uGxd301zX4
         NrnLqbEx0gQgqo2DBWePdUBACZZxk9uBb5i/0bAZC/j705AmTuhO71UWaHFJ1rbFftGx
         DFIyBafIOV4nULPbKBWCoTz7UMxDWcP3cg8eITuX8+QdM99rklDEMANVr0UtMsGZE0kd
         AoqF7xgCU6TMrvDwxKYUSwMSMdg3azklTk9KY3pphOU2t5YNX0FWlDL3BiqTEKGNqQFq
         +H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985458; x=1702590258;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtonhtxxLec7jGLosk2eY42ZY+2k/Vkm46yecdRU1X0=;
        b=t7olaS+/j8gknlWy8cfkLjI4bzo5cOkOs5gbmy08sE0ND/m3PesXWrUkseGVn9Jama
         m+AkiQR8D/FabZy8fKkTipHo62LGiB2AkhOPBiQwBFcE+jfUPo9+M5rmIoow4CPcvKn/
         sh3bMk0Kyretxnk/29c4x9xPyvkR15RhVd5K+2s2ke6SAEuVHCWu+rsGlasXzsyv4PBQ
         CUbXUzNtlVujvafjof0Z2igQsfnCwMKOVn+qHXjWqv5hhU8hBeElesI1feJ6dWtHW7xf
         dW9HZ65yNeBO2kKe6e8kC892+R9sAZ6Fv862m3V3dEyAXUOu8wfTSZES414edZiz2Rja
         F7XQ==
X-Gm-Message-State: AOJu0YzdrVJgzKP72yOy4kt5aoAAlvUeuC0eBRt5VC/nwK++Dgig1Xjx
	3KbqSk3xdktBAAhyTCu5XuGE9mccL5TrGd/u7rt6pg==
X-Google-Smtp-Source: AGHT+IHRoCNL/XiGqDT/AnvZVcjnxot5jdm8gWSd/ks+4HBqruB+ONs5cHM8RndxZsrSwcTyk3JNAg==
X-Received: by 2002:a17:90b:300d:b0:286:54a3:c34e with SMTP id hg13-20020a17090b300d00b0028654a3c34emr2498029pjb.26.1701985458541;
        Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a68c100b00286558ad352sm1859619pjj.8.2023.12.07.13.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:44:17 -0800 (PST)
Message-ID: <65723cb1.170a0220.9677f.5a1b@mx.google.com>
Date: Thu, 07 Dec 2023 13:44:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip kselftest-seccomp: 3 runs,
 1 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13924

cip/linux-4.19.y-cip kselftest-seccomp: 3 runs, 1 regressions (v4.19.299-ci=
p105)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig               =
     | regressions
-----------------+------+-------------+----------+-------------------------=
-----+------------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig+kself=
test | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig               =
     | regressions
-----------------+------+-------------+----------+-------------------------=
-----+------------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig+kself=
test | 1          =


  Details:     https://kernelci.org/test/plan/id/657232551b3e3046c6e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-secco=
mp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-secco=
mp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657232551b3e=
3046c6e1347d
        failing since 167 days (last pass: v4.19.284-cip99, first fail: v4.=
19.287-cip100) =

 =20

