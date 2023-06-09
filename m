Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65ABC8300C
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:39:34 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.2403.1686335972370836275
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aIDIaEBh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5428f63c73aso862815a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335971; x=1688927971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PqFc1MbBfIYPiXi+k5ObtWLSx+qmaBgqE2r47OwZCjI=;
        b=aIDIaEBhKr+6esMZ4DAyjX0oajcjNw1/Gs6dsyJ+D1A7AfiM8Pipjcz+T9ywggxv63
         WrnriJ+NpXcqH6XVSgaoPLMwAwhKSoUnYDtqFArPWD3MYUKm73vuDand1uQ+HNgdA14B
         yWEEFHtpBubIKO57GrD9F0szqtSlo5r4iVUtxtUKW5uNKhomb2/4RiDpw+jZcJhgQoaU
         QIIzTk+fwktLA051V0NQViRj18JoRSWIaQGGf7lMPoXvRNrMqujydjLdEsECmFcd7bHD
         TGp8z6Y34rhqqrHDetpTutvEqVBOVxH5Piuji5MDp/QX/jx5lQru9vthTzkmR4cn8IQf
         S58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335971; x=1688927971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqFc1MbBfIYPiXi+k5ObtWLSx+qmaBgqE2r47OwZCjI=;
        b=jQPJkoOkm0R6DbIuKkRHdLVKDPYN7r1KWmsBJeKmqADv9Ega5ELmGswWtgrfD4S1gU
         PTRn+bd0P+daDpc2TDcZMTbOvdLLQHdmPxO+cm4CSGdjAueAIlLFfn8T8FCEJBNuLKQo
         5CT6r31PxfH/RVCO3sZgnCjULNqPl/0Keq5mgM4hWOGmIs6HckzkeAq0SKTs8zmRbEtC
         x2zl3vHm6jthQwVDmD/lIPo1uuA+DoeRBwZcoIErYOAcsSinwtIOgp2qbymVJDDH9vLH
         HcG0qUFjv3hDZuEqLezWZ+bsATLpcn90oePWPx88gqrzMkQdixOO8xz6oCCSmoCy+GqS
         /tLA==
X-Gm-Message-State: AC+VfDzSVG1hLsn6d9H3zQ7jnVGw0ptxwBkK1/c6SL8PGlyzObRPKkpM
	54Ftksr72CdxAOICgSZNBEVBoKVw8vrUmdLqcJXYEA==
X-Google-Smtp-Source: ACHHUZ4Qo5v3jKtAtnviUK3n92JVUBheomDnKSKhRlDYtM5d9KncX/ETI7BCxVRf9jWOYWnvQtUUlQ==
X-Received: by 2002:a17:903:1110:b0:1ae:10bc:4ae8 with SMTP id n16-20020a170903111000b001ae10bc4ae8mr1666545plh.26.1686335971303;
        Fri, 09 Jun 2023 11:39:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001a52c38350fsm3572200plg.169.2023.06.09.11.39.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:39:29 -0700 (PDT)
Message-ID: <648371e1.170a0220.90125.7cd8@mx.google.com>
Date: Fri, 09 Jun 2023 11:39:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 2 runs,
 1 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11958

cip-gitlab/ci/pavel/linux-test ltp-mm: 2 runs, 1 regressions (v4.19.283-cip=
98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483615b07266b093730622e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6483615b07266b093730622f
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =20

