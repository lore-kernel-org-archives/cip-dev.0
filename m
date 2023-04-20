Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C1C7EE23
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:26:26 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.2083.1682022385891700678
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=r+obYBdd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-247048f86c7so1036375a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682022385; x=1684614385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qDrDkJtTCrSmxUod94iQ65mz52nz2Y9/cpvkxzwk+TI=;
        b=r+obYBddouVn+0CPNMNPBaW+L2eKEabYd3eSIOhw9XR6ifZutXxL8rRzypUZGdx9Up
         YUM61gDUiFiNF3L62tiAEzPHH9srrX7HRzKbT0jWQP+AlftGP/XZ34SQiHIAdIifzy8g
         8dT/3nw8441JRedsFkRGgzmtCkpa0sGTNF4x9T+yibqFhgAOM9AX0F54mh9Ifgdd3Poi
         oJmq8Mum8hgaHSo819/s3aq4RZH8GjhVUiYyGdSgYrjMwrNfEjksn1HQ8K3efruIEVcb
         Qlrxe4kJjDWwNbGLJfb2L8Otxm+MiaY6jD3xm+pEm48di+nHi2LMc/iGKe2OdHL2mQ/J
         +uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022385; x=1684614385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDrDkJtTCrSmxUod94iQ65mz52nz2Y9/cpvkxzwk+TI=;
        b=iloHqitZpoa/Ks5cu6yRax19Yd7KWBHy6vM5sNji26ujFv0bqQ2YVtVBT0LsOmqKd/
         pFD9+4cwi0J6tYGaPLYnHWxIUa9+EYENAdvC9xNVDZ2sPAjxthmw3RVjcMRGSfmSOPGA
         IlpXQp/ccQ1vrsPW/J1L9TSoephKB3RpPJYMtrvr9/ixAskW513APmqqOXE/zveFCGM7
         0dMyXnPjDVKVMEEDQHgtiXFNBP2GKcEweqTcAbvAMIxa64+tu6ZFyeBoRjjJ2YeNEgNm
         WbNKvCcSlHmWfE8+PTvYYda+wxDVD49xbs18kcL+tGKbL1rfgytEnmcwfwiBiO2GsW7Y
         Ms4A==
X-Gm-Message-State: AAQBX9fOstMNn/xBxDQrVoTBea2G6zTZa4euO5ClA1hLZ9j2IR1Den3h
	2qt/hl2uXY6WRYVVgiSHnYXY1x6UIj92hZbgZ6XZH/nI
X-Google-Smtp-Source: AKy350YyHdpzgCA3Oa68qfmARvAuBirP6mZa25DSKGB4J95oYTTAaxJfWoNsp5j4tOONWXlfQTlKwA==
X-Received: by 2002:a17:90a:fd06:b0:247:1c17:77eb with SMTP id cv6-20020a17090afd0600b002471c1777ebmr2651143pjb.27.1682022385223;
        Thu, 20 Apr 2023 13:26:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090abc9800b00246be20e216sm3377632pjr.34.2023.04.20.13.26.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Message-ID: <64419ff0.170a0220.b37fd.82cc@mx.google.com>
Date: Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1100-ga8cadce4b9649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4-st20-1100-ga8cadce4b9649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11272

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st20-1100-g=
a8cadce4b9649)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1100-ga8cadce4b9649/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1100-ga8cadce4b9649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8cadce4b9649177791a9adf0eef53ef0c90de78 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441948278e8ddcf242e85fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6441948278e8ddcf242e85ff
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

