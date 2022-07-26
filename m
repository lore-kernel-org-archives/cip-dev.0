Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B1CCA48B
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:32:50 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web12.1702.1658799162321959656
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tcSBzNaN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id bh13so11896224pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WcrO62pDtds4Qg3YmJ7mQVGzm20C/Lwu2BvQH3afwII=;
        b=tcSBzNaNqYbA/DsIRCCQKvvmiwr1mKv5rc+54hdyodhc+rOpCE9puSAYmMsF17Lg+Y
         flMcLu6czGkrm/Uyo/3ZcQoXL/7xxYvDgcR0Jr27Yj4y6JMZrJueVPVfVHNm5sJy3nU4
         1fC8xI/zQGNv12NbQutMdK1I83psBC/4DrVg1O9BOXxqYX3eUEgZ8U2jcNJq3nrmFZdB
         j8vaUnR9AjfqEANXMLdr86fOxwqGTcBA1h9k0RsllmsDyfokM5j6vhOdAuFirAsCl6GK
         +n+Ph4aX/D4cEuA9arNvsanGzv16qaRPsVKJnaeomizSfyysaW3fDj+6s3Tsfm2yebEG
         ELHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WcrO62pDtds4Qg3YmJ7mQVGzm20C/Lwu2BvQH3afwII=;
        b=g/N2lx8I4us4njtQSso1S2kPKs/6en5qdscEBWw3B/bFL+5za7S9hD19PVNNv0KI9z
         7T9LrQrsH2Tmn2QwexPfOmMwadIx9+TZ7LlQZ6EcHNxZaLVkP97vI3r21UjWdXHVnpwN
         RB2cFOGX6Rd6jfvGH7gQyC1UzLFi5saJZZtd3a8f3pQsdx6WCPlEr343d+NCIhTBWqYB
         NgpgX8twj4xlZLpw0emkGRTYkVx+nzm3dWlM8Gw8wZODg/SllHoikKm7gOdsfp5MmPK/
         fxYEtr9n4NnhLrFTHSgwtcnkAvWv1ec0CMSLdfGFnKEjD5PnNPK6yki+YWnw5v58Zu7O
         icmA==
X-Gm-Message-State: AJIora/XOyqHF4HuC/6RMXkK+vBhsYmoN2Mmp+hcl/AQRTp7DOwqyaEE
	9ZqS9WVDi7QaVAPR3uxK9UgaGGMGk9IDpEJu
X-Google-Smtp-Source: 
 AGRyM1vhn9RyNXGijXtMv8d3O/nDeo+y1wfVJY6YjYfgNOhwSul7IIFuQnCH7qoXJkq9IXKyD8vTWA==
X-Received: by 2002:a63:fe0f:0:b0:41a:1817:7dec with SMTP id
 p15-20020a63fe0f000000b0041a18177decmr13299322pgh.78.1658799161682;
        Mon, 25 Jul 2022 18:32:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b19-20020a62a113000000b0052ba88f2de0sm10228092pff.131.2022.07.25.18.32.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:32:41 -0700 (PDT)
Message-ID: <62df4439.1c69fb81.3d415.fbe1@mx.google.com>
Date: Mon, 25 Jul 2022 18:32:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs,
 1 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8916

cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs, 1 regressions (v5.10.129-ci=
p12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3673e91f097b06daf05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62df3673e91f097b06daf0=
5e
        new failure (last pass: v5.10.112-cip6) =

 =20

