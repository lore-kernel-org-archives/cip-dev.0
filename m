Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FBC76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 14:09:48 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.130980.1680703785391074265
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Apr 2023 07:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fcJjl9Yk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id s72so6003596pgs.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Apr 2023 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680703784;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=09rtr07soP6kWQqQLfl7anrBoF06l34zMIQaCzthWa4=;
        b=fcJjl9Yki44d0gehmjN7Iqxp8wehUhuFZUliIPvDz7s5211LsKQjzlat0/GMIsH2H/
         Ndpg4cSmzdOsb0Hej5kEELV/urkb0qsaAn0+uk/UgGKhBRIET1nVKVQZ+rdpgn1jk3Oa
         bSknG21lQTMqLXFbfIYcAHsGei1ZHdSWnUKRxfmRCHM9sYkULaQc9vdEzPhx7HcyjaKD
         65d2E3HBftMEHGl6/nOzmqOMlPdT52U1mZG4QCnw2mOxKwcw4wCKkxElfIoPKa++igJ5
         BsS41EJ9rhWjw0dShL/xYL6HZp3KJ18dYa0XB/4r7mRW6IiCvANW4pVoztFRa8azridx
         JBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703784;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09rtr07soP6kWQqQLfl7anrBoF06l34zMIQaCzthWa4=;
        b=hL2kbZMk+b+KTUsRlc0VxegOrDch8FHKIWaCrk/xljWUiGDkipPnLVjkCHRWUvfA1F
         ZtHsleA3Tudwp7O+Nr5lfFh+m+CeRl2l3zoRpNBGvWgb7wZkTyHFrjH5wDc+gvUgubxC
         GFbKOHW6abijSkGyG/aZ1yaoRpJtTMjLiRuHOd3VdBE02qN4CbKvKyjfYff4KyifDmQq
         SVRRUbw2209JFMtt2HrD/mh4OLB7OttnN0oTym8ZfY9Ovl5CnpJi+3KVAE2JzOkcGF9r
         rB0W2G24zsH9tnIPFwrNyme5VOYMOkFM3tWrZVRvp89IPNxJPfwxIrmS2qbpbvRPvpMp
         VdQw==
X-Gm-Message-State: AAQBX9eK0cy6XS3ILkDfd8WHe08QSIH/V0vu2ksBY+LEhwye6xaqJg2Z
	+qLUjGQK89fWfZP8fVNv3WcaGJFxdZQA+62oyExtxA==
X-Google-Smtp-Source: AKy350bBqA1UN+dEQ+xf+YW2ru1Hzaf/N9BC7fPP2kJSntT984hWJw3dpOM5t2H4CegTA/M4V6kbig==
X-Received: by 2002:a62:1a45:0:b0:62d:b4ad:522c with SMTP id a66-20020a621a45000000b0062db4ad522cmr5888516pfa.24.1680703784376;
        Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b00627df889420sm11098368pfn.173.2023.04.05.07.09.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Message-ID: <642d8128.a70a0220.18466.5f2b@mx.google.com>
Date: Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95-86-g16c082d0be46
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs,
 1 regressions (v4.19.279-cip95-86-g16c082d0be46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 14:09:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11184

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 1 regressions (=
v4.19.279-cip95-86-g16c082d0be46)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.279-cip95-86-g16c082d0be46/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.279-cip95-86-g16c082d0be46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      16c082d0be46e1e0049aa4aa2c022b53c67690ad

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/642d72efc3b9bd153879e944

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/642d72efc3b9bd153879e9=
45
        new failure (last pass: v4.19.276-cip93-5-g2eb2a953ab59) =

 =20

