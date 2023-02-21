Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF57C64ED6
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 14:22:47 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.43776.1676989363432238593
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 06:22:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lzRSFtn1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id pt11so5716971pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7SL0WNQQDO27ADKNebYiSYHnsO6+NnmKmEB72ozfsCs=;
        b=lzRSFtn1ool06MXLT8S1En+mGumT6K9Fj2UFl6MbIgGGkx30cpdtr2uvy3p72azsrU
         ctNMZBgrbp0/5WRZHhkv106BGaQ57CALVYu320KUaIp2Kk4B+T9GYDugAC6p7iKAte68
         NlzPEb1KgDZKKLAYhLu4E6cxDI4Eg9WNcODRD02VonsNPErZjzNq9ofHLAASQ30uFSF8
         CmOoJ3uG7XmqCJL1RS1dBzbvfp4dsdYfCCiP+oxoE4A7lTXhJPU6625aKzh2/VRcpbKc
         r2Zx9SY3kkRnJS5RjmgJio08S/wbIhG9pYWKQuUwjgcsSXjapJ9UBvcEzWFIDvgnPl0P
         ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SL0WNQQDO27ADKNebYiSYHnsO6+NnmKmEB72ozfsCs=;
        b=6Z6c5Wi+ekeUNZoscpkIU8N71cYzS9cdiYnsL/uXEYTIfzVld78bsKTlFIAgnoSL4T
         HcGOmiOlsY9JOukAMW4b+ULuZHQ8ZMnJ4g39ynnM1zjJtt0cmUsQhPUeRWek7JWfj8ER
         wlSm+kLWlPkgtaS6ORWVr6wUkACySUzJ+k1MbyyAU8p2Zh/NthmxwXgj0T/FWvFFdV2b
         ISeg80nTCFVqzyKql3oFL4GQY4d6mjVleeoxctuMbR9T/qjsYTBddLccmzONXGMPsjDr
         IWFbrliPA5JU/M1uJlXptHfstksHgERw5xDXMOpzlgTE5bnDmwy3JHGDIhph2aYd3FiO
         aYhA==
X-Gm-Message-State: AO0yUKXxhXkdw/7g/arRdn32WDf5pHb6vIHM46kvfgnnTmxfAMoa3wE7
	YASrlWaKszUO6viw5tv9+Tf1vud2nsc8bXJN
X-Google-Smtp-Source: AK7set8sIXgq5O56tKp2XQALG2OzJVAwFA0HHyYWduDR4SRiCjAL19+JHbLHVLouI3Cob7a6V+4Mhg==
X-Received: by 2002:a17:90b:4b4c:b0:229:649a:9a05 with SMTP id mi12-20020a17090b4b4c00b00229649a9a05mr7050365pjb.11.1676989362597;
        Tue, 21 Feb 2023 06:22:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090a690900b00230cbb4b6e8sm1794787pjj.24.2023.02.21.06.22.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 06:22:42 -0800 (PST)
Message-ID: <63f4d3b2.170a0220.3f970.3066@mx.google.com>
Date: Tue, 21 Feb 2023 06:22:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g28bb49f7179b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 2 regressions (v5.10.167-cip26-2-g28bb49f7179b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 14:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10757

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 2 regressions (v5.10.167=
-cip26-2-g28bb49f7179b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.167-cip26-2-g28bb49f7179b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.167-cip26-2-g28bb49f7179b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      28bb49f7179b9cb7b4cd5c5a139820ec49c19d6d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3b0d7f6f204e94e92ba2255b90edb36b1852d368 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f4cac72ed46b461c8c8657

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230211.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f4cac72ed=
46b461c8c865a
        failing since 104 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f4cac72ed=
46b461c8c865a
        failing since 104 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

