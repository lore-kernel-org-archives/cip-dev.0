Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD8C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:14 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web09.8547.1658851153688001760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=kVmGdMpF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id
 f11-20020a17090a4a8b00b001f2f7e32d03so1263879pjh.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dqyvHQBVGswVX8WAuXYkrEilDrpQjUsBxjJKDlagKAQ=;
        b=kVmGdMpFnVi7nS+Gd7IQSz2QHLZ4Ca05ospATF2VjcMSd7DsYbbPEqFVkiIPFpKzPV
         VBKsFur98jwTmnyUvWcGqr8BYRF6AntFk1tDPHVD6cWwIhaQCHvVIt9LFtJKVQjys6/J
         Ir2Pahuhx+aogALTqpfFfXZg9D5zrdk7CHP9gf/CEbN5zObLSrZ9tbTmUTx9kzA80DgY
         GdKUDI9knj1KdGT6hmW+tKxfddcxSy/d7y7CZAFfKn6jLIKo+NLPOW1poFFD65smFVgF
         3zNJs5aBU0XOOn0nXLwLzvIoWBLyQpKq25LvmtVuHXCT+3dn9EQdiwm2q4aa653OwhVX
         z9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dqyvHQBVGswVX8WAuXYkrEilDrpQjUsBxjJKDlagKAQ=;
        b=tVvUk0yJdlLfFScNRmbIHFBwanApUrYuTthdkUEeLL1EXJy9wx+HbMEEAy2jRudihR
         dLLpgIzA7wNR9Wt/pFupUfo/WALcMT1pRxweD17y7zbeacA4q0JY2lynEwVl/F6SgxqI
         v95jjWMdZ0ZooytKs7LvF4T5PgilPHy7I2uQYyo4+erBS2up9I8LmX9m5zkqYqknXEzC
         ekUknzH33ma7xNHExBbJDNc3QUbqfI6yBAdIyc54C+zIvenm9Up8hoc5vzQg9j0ySVf3
         BNAfQgeYFbLMz9YQRtQJ1y4BBvFvHUd1Ie2CVGvSwbc3hiFmeTVY+lBPzuGdFYw41xgV
         8kqw==
X-Gm-Message-State: AJIora9RfuLM+277R+lKgyx0g/RDU9D2+d3HPLTBhDGghIJDAgQI0YYz
	Bo2m6JmnYMKIHLWEzvT8IK0vu7rbIsvNlF2s
X-Google-Smtp-Source: 
 AGRyM1sKFb16VfykBS687mbHcDDlb21zlDrbaPMfv2PrPe8euhTjX2Xu5j5/hPAzI4bRo+UgarOP0g==
X-Received: by 2002:a17:902:eb88:b0:16d:9b10:1407 with SMTP id
 q8-20020a170902eb8800b0016d9b101407mr4335623plg.56.1658851153033;
        Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 ne16-20020a17090b375000b001f3009a5ccfsm596221pjb.54.2022.07.26.08.59.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Message-ID: <62e00f50.1c69fb81.a8f00.0fea@mx.google.com>
Date: Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 2 runs,
 2 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:59:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8949

cip-gitlab/ci/pavel/linux-test ltp-pty: 2 runs, 2 regressions (v4.4-st5-586=
-geb97410e0086c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffbdbf708195f44daf07e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62dffbdbf708195f44daf0=
7f
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e00568ebdd1158d0daf088

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62e00568ebdd1158d0daf0=
89
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

