X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web09.1710.1646795167297020607
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 19:06:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rBiydkjA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id s11so1044438pfu.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 19:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=P4LZ9DNgDjF1Nq7+q/m3gOSZ0M8Dne+DmA16o+4fyp8=;
        b=rBiydkjAmoZYv3+f/ciph+RC1d/TrUDx4qrrw88IbiULL78QcvDcw6prvV8USbi6lR
         lBQzU/UJklc6QiljBbz9gXyngUbX3ZyxyN+8dy9fGh9YzsTWXh1OfmdZAqrd4nuAPaDf
         CaZsdYBQnBQnHIP0rkfrThgxmQEbV8Jnxxu3wmtuIYeR8H/F1uz0cN/BM6eK8uUTG9dL
         iRzRYqYPQ1EUXQ0dG66rdxShZWe4vRZbzjPQcxh+o8vMSEErukIq3LSptCnRnnooV6Ye
         WbUy6fqoYb4eccuG6SH525cLqqgsLUc4S6jRxnBxqp97WKtl8UCUBp7QDXDmBKIuSNgw
         otsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=P4LZ9DNgDjF1Nq7+q/m3gOSZ0M8Dne+DmA16o+4fyp8=;
        b=d57XLi8pFBvbBZw2TrtO1fo0STh4KlA7HRyM7hKJi9mLnS3470RziJgXTwPmjCqYrT
         I2/dfvv3lka00SVIzcpAfWkl4vJxqXevq6t9lXFNIT6vqK3ENa1eAbBfaBcX68x79QRz
         sBqNFqib8LAoY6jC33kuQHlf7YrzX7C8yHj0BAPY7pskpEo6qFIduhV7mmsCeIU8RQAM
         5ptY7ItMwU9Xf+DepCauRVNAnl5yjozSSJZ6DOrZwUEcFs2TbeFLrn4ZbtOp4AQ/YjPx
         qZ5lFGm2EgsvYml+UVG7qFHYqvh0vnSLKyQgNrX35rz6uM+lP3RWcxfm/kdcmQ9cRnj3
         RFvA==
X-Gm-Message-State: AOAM531yEy1Aw9dsYh9p/lb+mHCEe1P+bzptXYZwuOMxkMgiU256vBue
	JevU5z9eCFrvGpqFx/9KsjbiJSdoKQRdNTU73Jc=
X-Google-Smtp-Source: ABdhPJx25Eyt2T6DtPB50UMWQ8yHpF69jNrvPqwZyopQkLcDws4bcx6MZec9fRN8dppb+4db5aHJBA==
X-Received: by 2002:a63:8948:0:b0:37f:f087:9cac with SMTP id v69-20020a638948000000b0037ff0879cacmr16595964pgd.120.1646795166490;
        Tue, 08 Mar 2022 19:06:06 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a63214a000000b003652f4ee81fsm455673pgm.69.2022.03.08.19.06.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:06:06 -0800 (PST)
Message-ID: <6228199e.1c69fb81.1836f.2003@mx.google.com>
Date: Tue, 08 Mar 2022 19:06:06 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 9 runs, 1 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 9 runs, 1 regressions (=
v5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6228043e7ebfcf591cc6296b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6228043e7ebfcf591cc629=
6c
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566) =

 =20

