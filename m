Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00575C4167B
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 09:19:13 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.1067.1668331151343821185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 01:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=yFTHfDSs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id b62so7897800pgc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qjUt9rsGe9NFH3Xs2VsKkFO6rejLn5h26mWu2IE2A4I=;
        b=yFTHfDSsB2hR/e5WbP/2XWS2V8R8Ovw+ncUpsvjECQ1ZY94UKzalCdaWr8X7qTWVd9
         P1itjLuiZ5/1kTe1FaHrAz7mNQiUw/LpMinm8uucXWbp2+hpjDP31+S6af/Pa3u70td0
         2o1MG2NKYk9yU1EawEkvaER1Kg5KSp+LMDZ7OFY6I46SloNKBZCO0EIRsWgmIwr1iHDn
         cG+OFbtsAP9vPhZwrzykBfccVm7UnCZ8ibkIj5nnNvt9hpaVML3nbGSgCmP0mzq5Ji+z
         JgPla/H2WZ5hFEfy+HkDlS24dQJHvoJKMFdwGpZqlCBrEobpo3u4YxP95JgysId8u070
         /b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjUt9rsGe9NFH3Xs2VsKkFO6rejLn5h26mWu2IE2A4I=;
        b=lXRb99lBHnmUQneq92hTZb4zTGIyMrINaw7Pq4zbs3lzfim1xSKSZUTzzY+RENUOlZ
         6kv4HbIbXqJdG1S05P0Zbqz4Ok7e1j1QQE6WZeGxq3llt/fbowwr2umoNord1jLA8M0+
         5DGYUQ51XdGb2y2/M3JZwZKZwvFXKflAH+20OmRWWGGH6gLThH/eGeZadZWKP17srOMD
         M5pnGFVlW+WADKm1+Djy0Bh0mzTqDOAUYFef6FXqZLR8iFfF/jl8kOyPp1eEGeBGpkQJ
         VdYAbAYU//fDghmYHofta92V5jRjP1mu53CHfE3Y24/AMa3eBp039M26zfY/S09tJbU/
         uPmA==
X-Gm-Message-State: ANoB5pkEU/VydtVyT42xQfnEIW5cyU0QEiM8q5zt+g/6F4Ct7BN2mqhH
	2Wha/foIa8JDryR3pAHHKgsrsJIC+kxOLAHD2II=
X-Google-Smtp-Source: AA0mqf7LSLVX4vBaeiuK60oDrYnZ+voW9Rt8VATjEYELEvJ5pRDJkcZPyhKdEcEv/h2MMDpItPPUuA==
X-Received: by 2002:a05:6a00:3307:b0:56e:e2f4:4191 with SMTP id cq7-20020a056a00330700b0056ee2f44191mr9729294pfb.27.1668331150742;
        Sun, 13 Nov 2022 01:19:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00185402cfedesm4799830plm.246.2022.11.13.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:19:10 -0800 (PST)
Message-ID: <6370b68e.170a0220.34cec.6b63@mx.google.com>
Date: Sun, 13 Nov 2022 01:19:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 4 runs, 1 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 09:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10030

cip/linux-5.10.y-cip ltp-mm: 4 runs, 1 regressions (v5.10.154-cip20)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a960a7e7bc9bfce7db6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6370a960a7e7bc9bfce7db70
        new failure (last pass: v5.10.153-cip19-3-gc76f4e7e5c71) =

 =20

