Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B6C6379F
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:37:55 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.12218.1676029066418173426
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:37:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KVHplVJ1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id k13so6232094plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dC6uCIjiXiXLKEdomt09OfdJ0BpKDVEl28AWKpBJGM0=;
        b=KVHplVJ1T4xWbpT90w44dnAt/vRZb1V64FaxP7kva6ls/6FEXtGYoVzT9cX49gMXkB
         jgJJ080qZfmysR3cRDTIglHgr5okUbxYRA7LhEgQMixj+ld3Z32sxE38o3nPxhqwlnSt
         2q2V6QTBSCZeSG4Fzku20PT3AlpTwBFAkiUHJFgmVSCdaF4VUDzAJ3En0Qv7elGdP6fL
         YVyyvd/PRbPRJRA96Lw6IHm9UvqMzvnDckRn9KtdhCqMdFUrH/FJ/G18xexjwQOVGS1b
         1aTqSuZpKonCa5hxFgtam/P6z/P3hiiI9A8vdEV10KNKoJRrHdmTlcvOF0eEvHRr/OFv
         gG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC6uCIjiXiXLKEdomt09OfdJ0BpKDVEl28AWKpBJGM0=;
        b=j2ZONSbWOj1QerNTMskFmtJqP2cdbdNMWOAaKKgvf7coqUfhtnJDmvNA+8vyQxlLLl
         PKNLXjAXufG9Rx+GFu4bLvEN0SG00fLP3wLkDcWO4yL49pnFAtuQYUmy7CmetQcVegHS
         3U3fMb85W0evUPeJRICBuPRiyMtgR7CBleEqa+P7anwfQFw8kLn7qfO/qovnWEeoH0bP
         uNDNYaWa6UF3v4qUw7O9tBRrhPJLpRnDiRhtYQxphXOMBHj5kmAMAKZK9kQWwOMiAcxT
         zd7Pj96RWUjW5kYzGMYqWBOAlgFlBJKuQwp/LkwyKD7D4XxoPyRhZ7LIoKtm8zjJcm4U
         iW2Q==
X-Gm-Message-State: AO0yUKW893/CjDITLY5ZF/tpQbTJNpZGRezGCKL7T8nXnLUyz7QrB3xr
	jJQHR7umcmxZPCkBS55atU/jtF7p0fdZJWW8KJK2IQ==
X-Google-Smtp-Source: AK7set+NFz6+dh/HMeLayXhwupQwj8CYcX74JmuHUaaFjWQnO55UQ9OHu1stcs8n5fnBkCHmdOkogg==
X-Received: by 2002:a05:6a20:3d8b:b0:be:d4be:50a2 with SMTP id s11-20020a056a203d8b00b000bed4be50a2mr18177418pzi.32.1676029065728;
        Fri, 10 Feb 2023 03:37:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a62e10e000000b005897f5436c0sm3115477pfh.118.2023.02.10.03.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:37:45 -0800 (PST)
Message-ID: <63e62c89.620a0220.74218.5fb1@mx.google.com>
Date: Fri, 10 Feb 2023 03:37:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10643

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.167-cip26)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7b5ee038995273bcb614321dd1112311e3b7e8eb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63e622910ec05cd3018c8645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63e622910ec05cd3018c8646
        failing since 394 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

