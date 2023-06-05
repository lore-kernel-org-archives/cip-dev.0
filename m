Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BADC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 00:22:40 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.1236.1685924558957379502
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 17:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=D5VQ1Psj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-653bed78635so1405681b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685924558; x=1688516558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVkrhF7580PjUmC+Rc6CiFHgp5X71yQKsnLDFNDJUFE=;
        b=D5VQ1PsjU99eylVFwGaTY8xsDI1C6zhdPpk4DWz3nNEuGRJK7/mMlk/KiQiGXRWtNr
         guI50EpaRAcCCOWevj7j2+KqLa3nSZvf/YhwmPQBOCckY/i4elbn6qYznMdxl9CjQBhH
         3ocd+vCmXQr+vRDkCyNCKZ4mmx4Mr4U1QHqBn8P3wt+1q7Rebvge0rEz6KbPpn+oW24m
         N09q6HxUtX+ZTgOBkZfvXF7GJlmRi4In+DqFYyXoRf+WTH2fwZLY04Ikf6Zh58UlKmO3
         SvRR/dRjvxyTnnuabBSh8PuE+kumbyFCE/OO0y39HB4mpZz69+L5tdtUNtVvZ4DILe3y
         zwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685924558; x=1688516558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVkrhF7580PjUmC+Rc6CiFHgp5X71yQKsnLDFNDJUFE=;
        b=eiuNIJ7vkd1lJEx9oA0fkJis5drYarxhprA5ViFSImJMtCBB+UR7MvKTznROBjHbKd
         9IkSo2h3aUKAMkNpBXoo2U882JDUw7B7W+GUfZdANGC0u5aMHV3KvaVsG9KW3765yx2y
         sWsMTiOF8wRF+2NiQGjeNpwoeulQ99djydXvu/+MLkEypGg4rAGB4mI5jrNUgJgWmjO5
         cR44ovGXMXxnEpHsGQhZDVO0lRa3Mx6WIU1agOncc0/wW33m7yumsdlWKBuhwoyWrVAi
         cqPRV+cIjEvVsMJZjUsfLrL+0RIzkhXyk8L3/9K+bBAUX6oSwS7KQ0W+K9oFjRgGme1T
         WC+w==
X-Gm-Message-State: AC+VfDyu85abtmgHaQepD2XyPBYs2IozQh6r6Hs9BqrccOyG4+PNvoJV
	lshm5llKEQJHKxxGUS1xgQH3b//5+0riEl7EpXEjMQ==
X-Google-Smtp-Source: ACHHUZ4wHRAr128eXE5iRhoY7Jz/HbYaGyXo9BteeGjmkI+WvZI2HzHy56bbuK2N7OL9lS09LvYBAg==
X-Received: by 2002:a05:6a00:39a4:b0:652:e23b:a078 with SMTP id fi36-20020a056a0039a400b00652e23ba078mr8449626pfb.13.1685924557580;
        Sun, 04 Jun 2023 17:22:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79207000000b0065418efa5ebsm2871996pfo.155.2023.06.04.17.22.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 17:22:36 -0700 (PDT)
Message-ID: <647d2acc.a70a0220.53651.4dc5@mx.google.com>
Date: Sun, 04 Jun 2023 17:22:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1301-g6369cf0363211
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs,
 2 regressions (v6.1.26-1301-g6369cf0363211)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 00:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11765

cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs, 2 regressions (v6.1=
.26-1301-g6369cf0363211)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1301-g6369cf0363211/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1301-g6369cf0363211
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6369cf036321117aa7bd9be009c3b7107cea2007 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647d1fbdb84355737df5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647d1fbdb84355=
737df5de26
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647d1f96c700c0e920f5de29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647d1f96c700c0=
e920f5de2a
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =20

