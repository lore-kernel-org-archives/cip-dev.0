Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE9EC00144
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:14 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web12.8554.1658851153434843143
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=c7hZNzSm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id y141so13575813pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CzYljIL81WEPoM8MBowFTj1yS6fx/4oCpMfy7Mdxyj0=;
        b=c7hZNzSmUw5ozMENKQxpTOXwx6eqGXvZzKz+7v4u2Skeo28K6iycsILvQiIX4yxWFk
         bw0U9zjoovG9TI+LlsnjrQzeELFTWovR8PDdQkwyqducXJUgpG6unXJmOYy41uRjt7dN
         9jc/jlZSx8htOhsVPewknDROtaklEkCSSVFxtDDdWp1QzLQyE2jFmEW1vDn3fww18bd9
         ymexx/aYN3WB/CwDjAePt8G9hxYK34M9IiC/2jgeGR48Xawp72xFvfSl6d6IK52Zy8L7
         u468vL78G3aq9Gr/puwt94riaKmBHyOYBWlvBxbHMXAWYEchvCxG3s2Jvqck1fXnk58C
         9Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CzYljIL81WEPoM8MBowFTj1yS6fx/4oCpMfy7Mdxyj0=;
        b=sQlTECHYbRMKQVoaeLvcipA8n7viq0MgainGGXMaC1G0V8QfMX7+F+bY+NBoIzkE5+
         PDSRsKGcN0uH61kfKHe1rXTNGPe7FFwcgNLndRFckf0PzbTYq5rtm2/LMa+LHQ3MFFWH
         gBGA5HbzBN7ViALJ6Z3DNRKpL8pItTQlmaQuMnnTR7pSZCGNaoAUHoQyjLzFtUgF9jHs
         ElLJzZo6N2zBMs+gKy8L+S1g3YILpd1uic2q3znmU+tQz+P/jxtKYxI0DYSXkdEPQtYV
         6YPI+xRFrO8pDaRNpMrUWbeJ/tanYQkveNERDaxFvGG7EG6m2B/zBaq5NljovH8J7al2
         QI7A==
X-Gm-Message-State: AJIora/cf6agEqjQCK/933B0BT3w2FrbyJesFL7XGf4weHFNchgS7zJe
	DcclBClwZSnulJYlQTWlLkodCISgtT8hFwaI
X-Google-Smtp-Source: 
 AGRyM1vhoD4i+q6GPDWjNXnMPJ4UH3KnMxYUiGGo7NqZR99mJUoj7ps73q9fpFC3rMalAutnDrm2Pw==
X-Received: by 2002:a63:20a:0:b0:411:909f:8ae2 with SMTP id
 10-20020a63020a000000b00411909f8ae2mr15961448pgc.132.1658851152706;
        Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q9-20020a17090a7a8900b001f219c5ae7dsm11303366pjf.31.2022.07.26.08.59.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Message-ID: <62e00f50.1c69fb81.d11b.118f@mx.google.com>
Date: Tue, 26 Jul 2022 08:59:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs,
 3 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:59:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8947

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 3 regressions (v4.4-st5-586-=
geb97410e0086c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/ltp-mm/

  Test:     ltp-mm
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



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e00222bf84cf303cdaf069

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62e00222bf84cf303cdaf06a
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0069576399bf95cdaf070

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62e0069576399bf95cdaf071
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e002b3ad11d175d6daf063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62e002b3ad11d175d6daf064
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

