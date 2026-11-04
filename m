Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22005.1793832363430917339
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 14:46:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=U7sAzc0Y;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67990a45e02so1390656d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Nov 2026 14:46:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793832362; cv=none;
        d=google.com; s=arc-20260327;
        b=Ir24y0naPGtvmRI4Bnq4LpM6zInP1REB/G+yca2g3UyhooONzsfsi4dTZUpcAvRSkb
         xS0jg7WAkhtKyT3ZWCtDFESOLm7JTrpt8nJoL8t74ZS1SzD61fOAAYeJU187TKqt44v2
         B3Tohr+KFSgzVn+ZEL8yxY4OaGYj+Fibgkqd8Gz0812/3OLtq5orh/XLQpHdXH2RNejJ
         G1Bhvi2ZC4eYuj3f3aHmdIuDK6Ba6pNJwyQ3DJ1yuXVLPxNRpXrarEOUQ9GTNPuPOaCT
         vo98XgVa+yHpDBOaSXiPj/3QI8vAHmJBZQqwHmFTqvtVxiLoP4WbNqwFDimxMXV4CcIq
         TO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ryRoxg1DZEpcme50akwmO4fgw0oGVAUTeVGCLw7KIBY=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=dTKkgjAd2wdFXArwo5tod8OM7rsfvhP+KS7XAQyDsVm5qHSySHFff/PfhMRqc5o4jU
         maITSGTXoRcCq/rkPaaLYclZKDCI5yub6GREQrJIhbVy9GhEmbPJhUoPUZagZCg7YPOI
         uv1Y3nnLCbyEO9TbCCJcLgIo/913cGyPSwoXpDtJ2/xB0mtKhYC0gf9bf3FvmGtcah1U
         Xuiz91G1r33+yCDfSXsFYLnZ9WqSCr/1eXMDriazfbFvVHfMIZotIoMmwnyEuMLI33aH
         8DhbuBEXbtC0CbTqOcXoluU56xUshGrglCkn8SYZgwtVB126ORbGcXBedWb51gNSea/d
         IyaQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1793832362; x=1794437162; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ryRoxg1DZEpcme50akwmO4fgw0oGVAUTeVGCLw7KIBY=;
        b=U7sAzc0YS1cKqEZisRUWsxjrl+SxS66fQQkwoA9v+vvrCUT4OzXWgIyoO019YcGFmk
         /NJ9fZmGrmPS+Trwuk9Xr6+OxrLIeXilCr1+Qqmzq9id5DiameBzThidkt4yq2tG78Kc
         K35vqOjPyD8/D1hrZn9qT85TX6AWCLPtWxGBLqWGNFLbE8XRObVzE4JKEmvSxLWsafYW
         DV9v0HNsYLwgM/lRQPcCoBCsFmKon4KOSLyxo6G+QddzGDuQzcoGPrbFUoGo4x1yczoG
         xrd6NFQP48aP3sl9NejlZ5p+kT2eVSasZndie3WBLf+hfZrxs5mtbxvPmnla2p8K72Fy
         IhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832362; x=1794437162;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryRoxg1DZEpcme50akwmO4fgw0oGVAUTeVGCLw7KIBY=;
        b=pqODSkrH7bZO1RllPaj9oDK8o/1Q3f/6+/VVZlshxW5IfKMpanU+4g3Vz2Ie3kOjMC
         9eV1tRXoGwr6aaCo/bxiR5VOy5hOPdbb/4J8VoRgbIuWHmUkEn+28CNUu46YA4LKddQY
         OhzovUm5Ab7ZyjHOSFU40oC93IB+b7aOCka5RXyQDvc0lellaJMNteGHe0hb1jnzw3yD
         zGI4/oaN6Jwl8ynoFxULR0DtVLCs4VeWlK51lyRZvifyhzocd5ujKNhPEKmZckC+98Nb
         num5onRghcqP3nFt0TdkWePG3lwcKkFATILIZ0V7ZE/XNRDnkcgjqlNuACkm3vBrrWSX
         Z5Aw==
X-Gm-Message-State: APuU4Z8HGmCh8kWEuj/WZNVsT6x6v5veiE+kmVWxGBbiFUj0GB1cphE/
	jh33uvkLhKSfTzdQFet/uSCfeMwSPIO+q8F3BfILyK/3vpc8UZ3Q5ojgMeaoQ8Yosmom2xItcsM
	vZQZPsIpuJJgXTqEIzsOgiwJ3ZUrCJsUe0pz+uWEt2VTV1Kc78XpRQzzXcQ==
X-Gm-Gg: AYBFou0twzkTq0JFk1EIhGkrN6FWtz7KxIg63T7gdpKoxpcA9XI8MmDcqv3UCghMcOX
	4fTJzI5qSXQy0vqnUp65FWDHdmWt5QSEG2vvGJevefmJz0gu9+zRR7OAt/mam304maom/1skxn0
	XZ9LbZU2p8b+rKR7e0ENt0JP9s+5AWkhPaNUCtrLLypN+WKxLnbn9UXOKibcoDTRdq/eiXpT8hi
	sUYDQQ6ktTs2LDjmpe8jy9w07QXE1J8hroVoZBoj88zqj6DFtJxyhqtDm7+PXQOOWAbUaBVxjCr
	OF2mTsd8CCmG4KpO7o+QmCo5Y4wq3ycWg6x7nqJ4jEOiIAJYC0/9l8uxQfpsrc1HZHPNlpUYn4c
	HlRl92LC8QuBZBI6u+S74GOH3+AcPoj9NDbaD4np0IROFsAjXFwu9VQthEwfjGye3TRg9F4D3bT
	OZm3+MrjPz
X-Received: by 2002:a05:690e:440e:b0:67a:5e25:607b with SMTP id
 956f58d0204a3-67ba4fa412cmr10016838d50.54.1793832357132; Wed, 04 Nov 2026
 14:45:57 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Nov 2026 07:45:20 +0900
X-Gm-Features: AclHuK_5V8p_fsF49xryJ1ZFA1Zr-qXpPUeueGsjLW5pQt0_1p6H64JhCZHjFL8
Message-ID: <CAODzB9qtj8khz-6MjC-cen8drTtuRzAi5atE-Rug+cs=hGcScA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 04 Nov 2026 22:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24634

Hi!

It's this week's CVE report.

This week reported 44 new CVEs and 1383 updated CVEs.

* New CVEs
CVE-2026-99218: coredump: hold RCU while releasing parked threads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99218

Introduced commit is not determined.


Fixed status
mainline: [61d58591aa0188bf2463e263962256316ff8b576]
stable/6.1: [fd0fbe84312fda2fc187428c92c50b7d03a9d24c]
stable/6.12: [0fce73efee40c65ce26641c5d93942462f9e8307]
stable/6.18: [16e94ed90b1b02398e044d41fd1db34828daa08e]
stable/6.6: [71146c437bae59e5280f657965dc6d006ee3989b]
stable/7.3: [b0eca0edddf4c1dbaf6d1f6a8636b4235f5bc573]

CVE-2026-99219: ftrace: Initialize modname and offset in print_rec()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99219

Introduced commit is not determined.


Fixed status
mainline: [e1f339ff3b83857b93baf8b88186275a413d445e]
stable/6.1: [753d5cba113a52cb155428f4ea93a4b0148c4bf1]
stable/6.12: [e2e6fb972bfec4a0551bc7c185bdb17f78f94997]
stable/6.18: [8932e5a4df110a25578728526bb5a3dbc849d8a2]
stable/6.6: [0e5ff07be834abaf4280e1dca7f9591e339d0960]
stable/7.3: [d97dba9ff13987d1fc415408557a54adde980311]

CVE-2026-99220: asymmetric_keys: reject trust keys without IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99220

Introduced commit is not determined.


Fixed status
mainline: [9695df3b1db4ac4534274d38ee16e3b9b0bf910e]
stable/6.1: [889a2293a95f6c2880bf73b67f9b0af23251a128]
stable/6.12: [2a40bdd4409567de4c2a141ac66439dc238af752]
stable/6.18: [1aa0c7aa4c2554a5b6d74ae1924508ca4718234b]
stable/6.6: [7f0728ba89624e25df2bb80ff59bbfb545060935]
stable/7.3: [57e54b6939c6539d90a81c7e57531901d5991651]

CVE-2026-99221: keys/trusted_keys: return immediately after TPM unseal failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99221

Introduced commit is not determined.


Fixed status
mainline: [f92d0ccb05bf9089072cb067dda0dffd5394c4ef]
stable/5.15: [4876f09ce222e140a73aad950882b3605440c935]
stable/6.1: [2d92a0f87c338a08367aff05edd1ade86da4ac8d]
stable/6.12: [6e359d8cb8580b9874801dea930086effd4d9c62]
stable/6.18: [e55d48f21f591a9fe80d26b5fbd1912ea725d9e6]
stable/6.6: [234d09bb3b3d84851d4b3246272addc30f3353eb]
stable/7.3: [ed697a5f667435bbb1cedbe5bd9f300de645047d]

CVE-2026-99222: keys: Protect the read method check against type removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99222

Introduced commit is not determined.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [925c84e3cc21caf09de92d9bcafab0147790debf]
stable/5.10: [e5f830ae6611cddbfc504c43f14155f60b63206a]
stable/5.15: [ff11cfed85cbfdd7fe1185ebd18d2c7a8353ad8d]
stable/6.1: [1486caee47b4909f52835a957c3293e970113e44]
stable/6.12: [6a36e2a1a017c51f8a8ad2a094566bad97c46a9b]
stable/6.18: [3edc064069d07e7d37359fcb4d03d3bab15ee3ab]
stable/6.6: [ff44f1b303aa76a818d898e85c56ed4852c031e2]
stable/7.3: [e2a2deda08d91644f5e30c17d267b1cdc5f124b2]

CVE-2026-99223: keys: make keyring indexes independent of kernel addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99223

Introduced commit is not determined.


Fixed status
mainline: [de891c73c1cf41ac8de12c07fa2c84d6a912ad0c]
stable/5.10: [9ebe824d55983c9f063a2c9ef1a08b29812d406f]
stable/5.15: [e108b22999edbc6f431466baf6b2016c19b7ed31]
stable/6.1: [9f084ef0beb68091e96ab96f0e95579aac8a77f9]
stable/6.12: [13fc051269d670810d9e314061b61c6dd06116a0]
stable/6.18: [61ac0585d9f4344d3dfb84b5edff1fee7d532897]
stable/6.6: [8451d4a4c43127c3b9fdf9fc9ff3fea5539a61f9]
stable/7.3: [a113eba06bd1183c614d7994864d6e7054140cb9]

CVE-2026-99224: keys: Protect the type name while describing a key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99224

Introduced commit is not determined.


Fixed status
mainline: [fced7238b7e80cf8aa688d5af976e4aa6e33c329]
stable/5.10: [19c4de819e52b7f606468fbfe4fcef4e812e2777]
stable/5.15: [a49e6c9a1a5b3457c946a8efb616ce13b4ca8194]
stable/6.1: [916667df7695366f23cfaf365b5840b228cc4b2e]
stable/6.12: [3c3cfd9e262afc9558c38f8cec57f09d10988546]
stable/6.18: [6b613747f7ea309ada5b8d05b55398c338f7a968]
stable/6.6: [dddd3a1ab7d12ee163477918ff6eb943361db4fe]
stable/7.3: [0461bc8f91116aae4a020e15f4e1c1fd535ab35e]

CVE-2026-99225: keys: Check the authorization payload in process
keyring searches

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99225

Introduced commit is not determined.


Fixed status
mainline: [0a0ec45bf577a9b4d4960567f20d3877ef480de9]
stable/5.10: [14fb6fad526b35a7ebd121f1dd313abe652e0aa6]
stable/5.15: [458cf9715af6aff3ac8d2ec60bd59e9d6236fd0f]
stable/6.1: [7d3d2fffe933e538472ccafe5bbc7109488b9ce3]
stable/6.12: [984a178d54515779a1bee100b92a6cee8777c830]
stable/6.18: [b86db7993051d05810601654e886a1e78e1fa495]
stable/6.6: [26949c2e4c461e9e620e935bc22717f36a40b615]
stable/7.3: [49f4e768540d25d8852ef750313afda6a4774871]

CVE-2026-99226: keys: Avoid the owner account dereference in named
keyring lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99226

Introduced commit is not determined.


Fixed status
mainline: [51409aaa01f8602552c336009fd22b226b0cdf1d]
stable/5.10: [77249d4b1bb5ad43552b7023c4a0978937aa7a56]
stable/5.15: [0b865fa477d94ac96c26848aab1fd176397de3f6]
stable/6.1: [6763329f673d261641c79212abf773af77b2c922]
stable/6.12: [c9664f780f861dd9f11f120c7a03ed0993671ebb]
stable/6.18: [b0830a26e2c3008a6e21863126b4a0e68b2761cd]
stable/6.6: [aa03c8fb4334f14d218020f7431debf2b7766865]
stable/7.3: [40b12b93ae4ab9e22c3d571e9b09fd08afad53f6]

CVE-2026-99227: io_uring/waitid: prevent cancel reference wrap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99227

Introduced commit is not determined.


Fixed status
mainline: [98787d3fa4e99564d2b2bc21255b21f670c450d0]
stable/6.12: [20b67288574c7c3df6b8ea7ed3b7af90a868006f]
stable/6.18: [5bfeee1774791602a0d53eb717f00f172127a017]
stable/7.3: [22fb4a4518e305164c7f203608287564de292f34]

CVE-2026-99228: io_uring/io-wq: don't lose the signal that ends work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99228

Introduced commit is not determined.


Fixed status
mainline: [63c103279a95e82280092f2f4232e91e8117a252]
stable/6.1: [ddccc60f036b309430cf130d48aafed94ef7355a]
stable/6.12: [62996803c1b5f18176de255db4c843021f2d19c8]
stable/6.18: [7309fea05a3d66af9746843c43fef14c10b8141e]
stable/6.6: [08c42055b8f9a5d29236d34ad4bce08828239fe1]

CVE-2026-99229: io_uring/wait: don't spin on a stuck overflow list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99229

Introduced commit is not determined.


Fixed status
mainline: [34f5a664c34d3cb62f6bec7f4156754594a7d25b]
stable/6.12: [a6cfc85c6bf9498aaf1978b503f9663635a1aa22]
stable/6.18: [4a89352edd8b3e20d1e1fb33f0fc297dd137149f]
stable/6.6: [bf1d2ed84b3162e3b0e0bb7018ac59147da6e975]

CVE-2026-99230: io_uring/cmd: don't leave list poison in ->hash_node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99230

Introduced commit is not determined.


Fixed status
mainline: [4c83e39f4d1944d7146fd06094f2c8053238d55c]
stable/6.12: [cc7f13d006fcefed9564bd79f135b51d344e9c77]
stable/6.18: [2d5af21422060c088f6e4fb0f1e7dcf5bcdd6707]

CVE-2026-99231: io_uring/waitid: own the request before clearing ->head

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99231

Introduced commit is not determined.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [c254eec4364b9f4b4cbdce43be3fb4df5a651a70]
stable/6.12: [bf01da1a9cca4a54e5c30b8344e52c26afb87be7]
stable/6.18: [8381a912c65b8de16e8a848225c7c5a56b6ea834]

CVE-2026-99232: tracing/syscalls: Use copy_from_user for the faultable
syscall buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99232

Introduced commit is not determined.


Fixed status
mainline: [097fd0050089df17b032f2b852b9b65e548e342a]
stable/7.3: [041d1a568a11a7ed7415ef1408d0c65041c1ad69]

CVE-2026-99233: tracing/histograms: Verify event_call identity when
updating synth_event refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99233

Introduced commit is not determined.


Fixed status
mainline: [3403d9bb27ebc3572bd048620746b4414e073bf9]
stable/6.1: [381f543ed35c434d5b707369aa5dcd69ecf440af]
stable/6.12: [23b4106e8b35823acc79e206c7745f55b9cfd78b]
stable/6.18: [06e816bed499fe47f39f12044382cc5d064485fb]
stable/6.6: [4472579bd1c83708b6fe623c870cdf728e947205]
stable/7.3: [cf4e31d5da80fae4c9cdbe7af55b7c3ad213f0e4]

CVE-2026-99234: tracing: Unregister field variable histograms when the
command fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99234

Introduced commit is not determined.


Fixed status
mainline: [91c14d6c13096091c56304120aaa26e479130b8b]
stable/5.10: [f21351d1c4cdcc6a68f03636a407c2af1a5e1e10]
stable/5.15: [dba0f492703956801149cc70b39d2650a37995c3]
stable/6.1: [a3d7ffd2409700748a495b645948fef48199206e]
stable/6.12: [8482ec5b65f606d5bbcec518e0afc69ad65ca414]
stable/6.18: [431959fc76456cbba539279fe8967aa9391e6f23]
stable/6.6: [aae0ccd7326eef78dcdefffef3d1253e6f0615ca]
stable/7.3: [d0090baf02dd08f6e909f36f0ad54a4e80f5e79b]

CVE-2026-99235: tracing: Save the event file instead of the compatible histogram

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99235

Introduced commit is not determined.


Fixed status
mainline: [d5c42664fc094899af9aae5300b27fe8fdb658ef]
stable/5.10: [a6165126b1a1b26342b55be6eb6ee23af8756aba]
stable/5.15: [173914501b97236d7ea7dc2af7f30feddd4e1436]
stable/6.1: [ac815a379644b2ad5008a009a3516ada31b5dd82]
stable/6.12: [7a111ba0d1b74c99bc8f096565dc71945f694254]
stable/6.18: [3609ada3c12cecfb0ae5ee82ef4f86c5f18a2dea]
stable/6.6: [8b307d64a60548e4a74cb746f74d7ed4bd49965e]
stable/7.3: [7cafc82e6153f05a221be678cd649d02e06ba909]

CVE-2026-99236: tracing: Reject incomplete event filter expressions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99236

Introduced commit is not determined.


Fixed status
mainline: [1fdc4164e488916402badddbb1f51e9380dabb91]
stable/5.10: [4a1a6d35359991c5d47f4bf101cfbe1475c94093]
stable/5.15: [2a98f5d4913ec081e08e1075512cb7ec313d9f72]
stable/6.1: [15ff3cc7f2beecc3f95d66358f20ad7b057466aa]
stable/6.12: [5a999b5a16530898f0dbe5f8c50fd45ea72e110b]
stable/6.18: [1008e9e0b8280d47f1ab5e9c113f666a023a9697]
stable/6.6: [b205ff58e02922ac324f931cf9eb238a3acdb048]
stable/7.3: [5bcdf3c18c3471122ee9652b0e2f5cdb718d9a46]

CVE-2026-99237: tracing: Hold trace_types_lock when resetting last
boot data from readers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99237

Introduced commit is not determined.


Fixed status
mainline: [5a6bd62f09147b49b31fd19d4eba122cb5f941a1]
stable/6.18: [92b69f6db640dadc0851762ee2e12db99f083cad]
stable/7.3: [1f06cfe0b60a878619d1d8efe1cd0f515b7dc2aa]

CVE-2026-99238: tracing: Hold trace_types_lock when updating modules
in persistent instances

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99238

Introduced commit is not determined.


Fixed status
mainline: [66877a312ae3c2c3d849e82e882f642ffd4ec3e2]
stable/6.18: [57408eac99b0d8a005796346d317d31f0ca4e07a]
stable/7.3: [244c442f54601a24c86ad90572bf36fc3df41c5e]

CVE-2026-99239: Bluetooth: L2CAP: refuse __l2cap_chan_add if chan
already has conn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99239

Introduced commit is not determined.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [86b55991d3cd690e73c5ef8d20b75ae4905b357a]
stable/5.10: [85cc289eb08afa975375f838187369e68b429ee0]
stable/5.15: [820579652b24ce277e0097cd65b42bd9b7b8bf07]
stable/6.1: [e618d928ec7f88cbeadfa3542adcac40f474e629]
stable/6.12: [52fe88e4ef87311eee32b45c65603e7c69e75e7d]
stable/6.18: [10c705dd706aa93164ba41f2566f15206d6c178e]
stable/6.6: [fabaff1c59ff2cc89cb7e5bd0186a5e15f0c73b2]
stable/7.3: [d3afd7803f9bc2a8c4270199497b60158b2fc647]

CVE-2026-99240: mm/damon/core: error damos_commit_quota_goal() for
zero target_value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99240

According to the .vulnerable file, this bug was introduced by commit
c5e67d4 in v6.17-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [610c4438fb66e06d9e693c0ad3b2c1be54c0d61f]
stable/6.18: [d5482be6243b816730689099c017109eb8730dd5]
stable/7.3: [156aeda4d74e9007b56492ed1f3b5838822632be]

CVE-2026-99241: ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99241

Introduced by commit 9c87959 ("ntfs: update file operations") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fecc393f2060e6bc25138df32cb923ec7071c6b]

CVE-2026-99242: ntfs: fix race between fallocate and mmap reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99242

Introduced by commit 495e90f ("ntfs: update attrib operations") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67aded1da114dc44808315f249bd9e7e440f799d]

CVE-2026-99244: pid_namespace: prevent TIF_NOTIFY_SIGNAL from
interrupting the reaper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99244

Introduced by commit 7fea700 ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") in v6.10-rc5.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2]
stable/6.1: [2c20ace1698d03a23467351be1d281e89b36ade3]
stable/6.12: [30b274508c743f243c82904954c4e416d7143d4c]
stable/6.18: [70178691c467c8f9f722765299fd8524c3121a35]
stable/6.6: [9ab0324f4868eeb20c63f063a1e5bc01d5539212]
stable/7.3: [f46cd8241d9b83f2279cc0db3e9d3e181b548a59]

CVE-2026-99245: KEYS: Fix key_reject_and_link() race with keyring restriction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99245

Introduced by commit 5ac7eac ("KEYS: Add a facility to restrict new
links into a keyring") in v4.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b157166e612b70f98a332b6c7be7eac6f8e9593]
stable/5.10: [c7956ec99ad0e173720d95de9fa788bb077809f2]
stable/5.15: [2c3d907dd15f4e30d4c35b9f7a7a5078de6a1b1f]
stable/6.1: [72f367417a6aee56821d0b0114cfd2b080008b63]
stable/6.12: [5787887eba0f0979a8c86d03a8e891395d5c24ad]
stable/6.18: [01835d3a3709be508ae5209f806640336c48e395]
stable/6.6: [19dfc37c9deefa69dc805d01d35d1f2fd7902e33]
stable/7.3: [23a9163cc40b4996ba1e20533b1210a1a0bee416]

CVE-2026-99246: tipc: protect node reset trace dump with node lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99246

Introduced by commit eb18a51 ("tipc: add trace_events for tipc node")
in v5.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dddf197f29ba5e47a476dde82bf542ca2e0d5e5e]
stable/5.10: [c8b72ca0918e95f708f67c8b3e69b05290f2b6d2]
stable/5.15: [6e492cb98ca69cc1145175e23e22e3b84da7f26d]
stable/6.1: [7bb6a35bd6d69019539d8782fb590fd2aa8a3236]
stable/6.12: [a6101d62ccfa153db8c218ce59362b8e0316fd4f]
stable/6.18: [b8b7d28dc2b7472ffd1eff3954c38f1976b21a7b]
stable/6.6: [6abd93d01b0f495f29201925a5ee8e6a583c4044]

CVE-2026-99247: tracing: Do not initialize tracefs work if tracing is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99247

Introduced by commit 6621a70 ("tracing: make tracer_init_tracefs
initcall asynchronous") in v5.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3b974008388ab59e44d764ba7a63c988fec2524]
stable/6.1: [e8665e884e076d894f3eed8b9ea28e37a6448604]
stable/6.12: [afd38b10b1c6a5c5d6952b15b990596dab9684e6]
stable/6.18: [813e18881c6472eb229a63180ff42c808e3e949b]
stable/6.6: [e8cfcd7e60eaa3b0dea4d71c64499604e7081736]

CVE-2026-99248: i2c: xiic: restore non-managed runtime PM to fix clk WARN flood

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99248

Introduced by commit 50c6349 ("i2c: xiic: switch to devres managed
APIs") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d33373c565af9c8a28776af02bd20ba6e5724211]

CVE-2026-99249: pid_namespace: make zap_pid_ns_processes() freezable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99249

Introduced by commit 3eb07c8 ("pid namespaces: destroy pid namespace
on init's death") in v2.6.24-rc1.
Introduced by commit b9a985d ("pid_ns: Sleep in TASK_INTERRUPTIBLE in
zap_pid_ns_processes") in v4.12-rc2.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [81933038f5e273d17ed22792f906889393b204c5]
stable/6.1: [064a6761d6f6ac55d090d3eaca649577ee736713]
stable/6.12: [4b47107f1a80c809c80093e872bcaccdbae13db4]
stable/6.18: [2e10b8a74f55b5aae33db105d3e2d3ae759c865a]
stable/6.6: [e8dafad7de9ede813af2d48cc04b7c88fef16682]

CVE-2026-99250: printk: Postpone kthread startup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99250

Introduced by commit 76f258b ("printk: nbcon: Introduce printer
kthreads") in v6.12-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f339c46f153184570f16c8e789c9709b14cbe8b]
stable/6.12: [a86bcdd84c8fe7a45f73e12d53fe06fea07d1ceb]
stable/6.18: [7595bacee48bc30b5021eccf199d704d4e5e5374]

CVE-2026-99251: Drivers: hv: Avoid infinite retry loop in init_vp_index()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99251

Introduced by commit 6640b5d ("Drivers: hv: vmbus: Don't assign VMbus
channel interrupts to isolated CPUs") in v5.19-rc3.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32ea0a33e3a0fb7c10c601b43e1b2f6c06a3f5fd]
stable/6.1: [b3993f6dc106ff416c7a613c631e1e0af451aed7]
stable/6.12: [15dd3429f0e76ca071657e480cb7e6ff3a1af730]
stable/6.18: [7141331f2d245efc07175802a6bf76badec871ed]
stable/6.6: [f561392afb44a8a42c54c1cfd3f33dace0b50537]

CVE-2026-99253: io_uring/cancel: rearm local work wake up before sleep

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99253

Introduced by commit d46ab2c ("io_uring: switch local task_work to a
mpscq") in v7.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76a82c666abf155ad52d5f41043eac77dd3e41d8]

CVE-2026-99254: io_uring: don't flood a cancelling task with task_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99254

Introduced by commit d56d938 ("io_uring: do ctx initiated file note
removal") in v5.12-rc3.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22e643e61b9b6299b42ff7d88bab48bccada8a5d]
stable/6.1: [a22fb44e988b01b82235ea07f0bf0fc73e256596]
stable/6.12: [61c761fc21e00e45c33c2bb596be442d92fb8792]
stable/6.18: [14f56e9c0b8fdc2e178acdbec9781e90ef46f7e9]
stable/6.6: [2c75ebae8a7f09c99e31c7042b7d4d595f03b2b1]

CVE-2026-99255: io_uring/io-wq: don't hide a link from cancellations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99255

Introduced by commit 768134d ("io_uring: don't do flush cancel under
inflight_lock") in v5.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [436d48a2ed13112d2d27085325838e5bce6b4507]
stable/6.1: [98470f164286f7f62aaee519d4d11b9370ce6d7b]
stable/6.12: [ebe8e97fb99d9f374c482902a00677cfd24a6c27]
stable/6.18: [3e02b8df0e9fa1423ac2a4e03409a9329c30ac49]
stable/6.6: [d39ebc7a583d650b1d6da9b45e2ce96ad4d877e4]

CVE-2026-99256: dm cache: fix issue with background work locking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99256

Introduced by commit b29d498 ("dm cache: significant rework to
leverage dm-bio-prison-v2") in v4.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc9781c0247de107876f32929f1637db93a42b34]
stable/5.10: [0c7a8cad7c96012a9157a189649e569d0390f384]
stable/5.15: [f5db935d257023c3ef410bd39163b949b0e5a55d]
stable/6.1: [6290507ecc0dd6dd40759729cbbbd49b1d2a63c4]
stable/6.12: [2f2cfa16dd0f4179bb988139dd37d00a42324f6c]
stable/6.18: [73df2ff409f3db95029982fe3656329568e3715d]
stable/6.6: [8433fd005c25fd127021f67c9144a879fb585572]

CVE-2026-99257: gpio: shared: gracefully handle no-device lookup of shared GPIOs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99257

Introduced by commit a060b8c ("gpiolib: implement low-level, shared
GPIO support") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf73c3fc03c43a8a86fd487c62390b4744eff9ec]

CVE-2026-99258: x86/hyperv: Avoid using per-cpu output page in
hv_apicid_to_vp_index()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99258

Introduced by commit 86c4827 ("x86/hyperv: Fix APIC ID and VP index
confusion in hv_snp_boot_ap()") in v6.16-rc1.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [7b74c117e2aac78e0f723e1c9c3644451c56b0d9]
stable/6.12: [bdba5f1b8bd0d18b1df61f769b559ed272902489]
stable/6.18: [2b561786c9076a892ef8b8f416c9828bc87ed44f]

CVE-2026-99259: soc/tegra: pmc: Fix uninitialised clock rate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99259

Introduced by commit 4d61f03 ("soc/tegra: pmc: Create PMC context
dynamically") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5c95dbdc9011a56359df4dc00be829bbcc0b036]

CVE-2026-99260: ntfs: fix resident conversion in ntfs_new_attr_flags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99260

According to the .vulnerable file, this bug was introduced by commit
fc053f0 in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ed0028126b5a19f278183abbae2b3166d3ca9ac]

CVE-2026-99261: drm/amdgpu: correct reservation fence slots for userq
per-vm BOs eviction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99261

According to the .vulnerable file, this bug was introduced by commit
897ee11 in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50b24a20be8c0d35f89f7d5c39533f69d84fe48e]

CVE-2026-99269: sched_ext: Wait for SCX_OPSS_DISPATCHING before moving
tasks off DSQs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99269

Introduced by commit ebf1ccf ("sched_ext: Fix ops.dequeue()
semantics") in v7.1-rc1.
Introduced by commit cb86607 ("sched_ext: Don't run ops.dequeue() with
a DSQ lock held") in v7.3-rc5.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2935062be77113c1c4565ca9d0c72180449aafee]

CVE-2026-99270: tcp: Fix potential UAF in reqsk_timer_handler().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99270

Introduced by commit 83fccfc ("inet: fix potential deadlock in
reqsk_queue_unlink()") in v4.2-rc8.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97c8a3c1f73d828de43a5a88e8a9a143efb2b661]


* Updated CVEs
CVE-2022-49106: staging: vchiq_arm: Avoid NULL ptr deref in
vchiq_dump_platform_instances

stable/5.10 was fixed.

Fixed status
stable/5.10: [2eaeb83153b848923a0b121402b4be88223ca62e]

CVE-2022-49622: netfilter: nf_tables: avoid skb access on nf_stolen

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [348218a4601e93de4d1e9fab29837cf656e4bf99]
stable/5.15: [453a67af8bd77463b33cb0336dd7f2341e332d29]

CVE-2022-49961: bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO

stable/5.10 was fixed.

Fixed status
stable/5.10: [65efb481eb4572fce0f20aa6c13e880816b81579]

CVE-2022-50167: bpf: fix potential 32-bit overflow when accessing
ARRAY map element

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2157ac13db8d5763835f1663bdabda6de744cba8]
stable/5.15: [f665c56e6836933335e5a4513fc9b0bf47cdf81f]

CVE-2022-50457: mtd: core: Fix refcount error in del_mtd_device()

stable/5.15 was fixed.

Fixed status
stable/5.15: [0de86087b20675c53fda2bc903dfc26a7ec99856]

CVE-2023-52452: bpf: Fix accesses to uninit stack slots

stable/6.1 was fixed.

Fixed status
stable/6.1: [bf32eaf5093dc1c24ccc26b14c3422f6dfcc5236]

CVE-2023-52490: mm: migrate: fix getting incorrect page mapping during
page migration

stable/6.1 was fixed.

Fixed status
stable/6.1: [1ce870a2d85969e2c9dafd2af20f205494a490f6]

CVE-2023-52561: arm64: dts: qcom: sdm845-db845c: Mark cont splash
memory region as reserved

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e6bdc8977543f340adc8f63ddd336805805aed28]
stable/5.15: [f6ef99aa56089e9a2126648a56b93ac2004224e7]

CVE-2023-52586: drm/msm/dpu: Add mutex lock in control vblank irq

stable/6.1 was fixed.

Fixed status
stable/6.1: [763ca8d84f34d1db00d5750f77e6001765916d44]

CVE-2023-52590: ocfs2: Avoid touching renamed directory if parent does
not change

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8723454ded3633f71ae35e0d5744518afc72d4a]

CVE-2023-52591: reiserfs: Avoid touching renamed directory if parent
does not change

stable/6.1 was fixed.

Fixed status
stable/6.1: [9de2e9fcede300579b9b65139d669ccdc134a459]

CVE-2023-52653: SUNRPC: fix a memleak in gss_import_v2_context

stable/6.1 was fixed.

Fixed status
stable/6.1: [32a15b6a9a0ac326ca65ce988a1ba046517af3d5]

CVE-2023-52671: drm/amd/display: Fix hang/underflow when transitioning to ODM4:1

stable/6.1 was fixed.

Fixed status
stable/6.1: [335fb62c36611f4a154983466cb7e9daa149a1d5]

CVE-2023-52751: smb: client: fix use-after-free in smb2_query_info_compound()

stable/6.1 was fixed.

Fixed status
stable/6.1: [06c106e1e8568e840c946cc0222579e3d29dab8e]

CVE-2023-52761: riscv: VMAP_STACK overflow detection thread-safe

stable/6.1 was fixed.

Fixed status
stable/6.1: [fbf55cd7d342507e8b029fab5e36033d81823845]

CVE-2023-52770: f2fs: split initial and dynamic conditions for extent_cache

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff9bc1161cd0209d6f5bee8128a1f078576eea42]

CVE-2023-52771: cxl/port: Fix delete_endpoint() vs parent unregistration race

stable/6.1 was fixed.

Fixed status
stable/6.1: [de0c4ff2fcaec149254b32f18b3ec806b312be74]

CVE-2023-52888: media: mediatek: vcodec: Only free buffer VA that is not NULL

stable/6.1 was fixed.

Fixed status
stable/6.1: [56d27b9fca840c68f67706e3cc5f2000c17bce39]

CVE-2023-53111: loop: Fix use-after-free issues

stable/5.10 was fixed.

Fixed status
stable/5.10: [81bf9d78fa246a166619196ff5005430ed2bc7c2]

CVE-2023-53149: ext4: avoid deadlock in fs reclaim with page writeback

stable/6.1 was fixed.

Fixed status
stable/6.1: [385b49a1f34b26f62e3834c773560b120825b6f8]

CVE-2023-53261: coresight: Fix memory leak in acpi_buffer->pointer

stable/6.1 was fixed.

Fixed status
stable/6.1: [10bbb7efcad40a06d7acfc0a14af21c19b496eff]

CVE-2023-53394: net/mlx5e: xsk: Fix crash on regular rq reactivation

stable/6.1 was fixed.

Fixed status
stable/6.1: [ecf583abb07da326d5058dc6ba79dae58aa800d3]

CVE-2023-53523: can: gs_usb: fix time stamp counter initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [7d470bb955210eb7d31f14427b48058487d42355]

CVE-2023-53651: Input: exc3000 - properly stop timer on shutdown

stable/5.15 was fixed.

Fixed status
stable/5.15: [0914496ec5ca04dfafe1a5d562477029b1f92b96]

CVE-2023-53733: net: sched: cls_u32: Undo tcf_bind_filter if
u32_replace_hw_knode

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d83345a8c0143ea31822be0aeb91a63bfc58215e]
stable/5.15: [3d5edcd3bca4aff15a18e45c79df1525059ab0e2]

CVE-2023-53750: pinctrl: freescale: Fix a memory out of bounds when
num_configs is 1

stable/6.1 was fixed.

Fixed status
stable/6.1: [0d200240038bc40b1b073a3fd978764c829af77f]

CVE-2023-53781: smc: Fix use-after-free in tcp_write_timer_handler().

stable/6.1 was fixed.

Fixed status
stable/6.1: [08f057bd1e559cdb388c77b18de3eea3d3d8cb24]

CVE-2023-53823: block/rq_qos: protect rq_qos apis with a new lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [f54c4ab8ffecf621ab20fb6d2b194af93616cd7e]

CVE-2024-14040: net: nexthop: Increase weight to u16

stable/6.1 was fixed.

Fixed status
stable/6.1: [f9d682935afe102d6b7060914304c04483d6cbd6]

CVE-2024-26589: bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS

stable/5.10 was fixed.

Fixed status
stable/5.10: [7856cb9f0d795ce518a44c5d135dd932cfbfc656]

CVE-2024-26661: drm/amd/display: Add NULL test for 'timing generator'
in 'dcn21_set_pipe()'

stable/6.1 was fixed.

Fixed status
stable/6.1: [e3bc103045c51271c3e7a808efb187a354678b7d]

CVE-2024-26662: drm/amd/display: Fix 'panel_cntl' could be null in
'dcn21_set_backlight_level()'

stable/6.1 was fixed.

Fixed status
stable/6.1: [94a506cbfd1bd4817502bed097e24cbab23cfce3]

CVE-2024-26669: net/sched: flower: Fix chain template offload

stable/6.1 was fixed.

Fixed status
stable/6.1: [a400208567c3927d8ff2b93f397526795e92d684]

CVE-2024-26670: arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

stable/6.1 was fixed.

Fixed status
stable/6.1: [d9a9a4d8ebc2fa534c0eb3eef3dae45f5e61b3e3]

CVE-2024-26677: rxrpc: Fix delayed ACKs to not set the reference serial number

stable/6.1 was fixed.

Fixed status
stable/6.1: [7a72f92f42b728f0d45efa081e78d1ebaf7ac725]

CVE-2024-26690: net: stmmac: protect updates of 64-bit statistics counters

stable/6.1 was fixed.

Fixed status
stable/6.1: [52002cae02db6ab4c50efe4095d68db3a6892b11]

CVE-2024-26740: net/sched: act_mirred: use the backlog for mirred ingress

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac5c2ed6394c85f84877b1a1eec61cf004f90f4f]

CVE-2024-26799: ASoC: qcom: Fix uninitialized pointer dmactl

stable/6.1 was fixed.

Fixed status
stable/6.1: [3301f5513e668d47514f32b0fea39e85b1152010]

CVE-2024-26828: cifs: fix underflow in parse_server_interfaces()

stable/5.15 was fixed.

Fixed status
stable/5.15: [3babdcb5f1809a9a41e31547a063dedf6bb44cca]

CVE-2024-26841: LoongArch: Update cpu_sibling_map when disabling nonboot CPUs

stable/6.1 was fixed.

Fixed status
stable/6.1: [3630771843bab987bbbbd5bdc39becb17684d26c]

CVE-2024-26866: spi: lpspi: Avoid potential use-after-free in probe()

stable/6.1 was fixed.

Fixed status
stable/6.1: [57a9b7fe61031f30c90d20c898160c397f6abe9f]

CVE-2024-26869: f2fs: fix to truncate meta inode pages forcely

stable/6.1 was fixed.

Fixed status
stable/6.1: [0721a4f85d12a364002a9476c84b930fbc993f83]

CVE-2024-26873: scsi: hisi_sas: Fix a deadlock issue related to automatic dump

stable/6.1 was fixed.

Fixed status
stable/6.1: [384f907946abe091da6ebcd65a15315896fb366c]

CVE-2024-26876: drm/bridge: adv7511: fix crash on irq during probe

stable/6.1 was fixed.

Fixed status
stable/6.1: [67b92950912195b9c83e3d652d7eb3551741d850]

CVE-2024-26902: perf: RISCV: Fix panic on pmu overflow handler

stable/6.1 was fixed.

Fixed status
stable/6.1: [dbf3b0ed79abeb552df4f0d8a6d84cee48b5ee77]

CVE-2024-26947: ARM: 9359/1: flush: check if the folio is reserved for
no-mapping addresses

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed95b1e88174566de3dc81d94399aacf2c9dfba4]

CVE-2024-26948: drm/amd/display: Add a dc_state NULL check in dc_state_release

stable/6.1 was fixed.

Fixed status
stable/6.1: [76fce0ebf9c770fdf259d167eadf5f05a9bd96b0]

CVE-2024-26953: net: esp: fix bad handling of pages from page_pool

stable/6.1 was fixed.

Fixed status
stable/6.1: [21b989b62456a0e1eae9f464a5ca360a608625d1]

CVE-2024-27005: interconnect: Don't access req_list while it's being manipulated

stable/6.1 was fixed.

Fixed status
stable/6.1: [8401bc2c188030fb14d1cb43c402a1cf42d86dd2]

CVE-2024-27010: net/sched: Fix mirred deadlock on device recursion

stable/6.1 was fixed.

Fixed status
stable/6.1: [09d2e807aeb8e4f2e5eac4a3064f28dcf19b9c1e]

CVE-2024-27011: netfilter: nf_tables: fix memleak in map from abort path

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ad58ebb394f803d80986b6ea59c57bb49a9b5f2]

CVE-2024-27041: drm/amd/display: fix NULL checks for adev->dm.dc in
amdgpu_dm_fini()

stable/6.1 was fixed.

Fixed status
stable/6.1: [cef0f2fe65ccee638e48fd5c1d590a3c0539acdd]

CVE-2024-27057: ASoC: SOF: ipc4-pcm: Workaround for crashed firmware
on system suspend

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ee66295542f88e5179439f60053de792df3f90e]

CVE-2024-27062: nouveau: lock the client object tree.

stable/6.1 was fixed.

Fixed status
stable/6.1: [bc91f00112f944f3cb488f7f9266c8b4761157a6]

CVE-2024-27408: dmaengine: dw-edma: eDMA: Add sync read before
starting the DMA transfer in remote setup

stable/6.1 was fixed.

Fixed status
stable/6.1: [85cb0ca8efa483e5d22385ea12fc5857c48a0904]

CVE-2024-35784: btrfs: fix deadlock with fiemap and extent locking

stable/6.1 was fixed.

Fixed status
stable/6.1: [06d3879bb51be205a04b3da752cfd121a3367fb1]

CVE-2024-35799: drm/amd/display: Prevent crash when disable stream

stable/6.1 was fixed.

Fixed status
stable/6.1: [967ebae13e206b90c2ef57b917adceaee1fa5390]

CVE-2024-35860: bpf: support deferring bpf_link dealloc to after RCU
grace period

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac48dc6ac9240f73bf08d29edf65c2deca93ee5d]

CVE-2024-35904: selinux: avoid dereference of garbage after mount failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [563e631a18c5b2bbab674a58154bcf41a6d90f13]

CVE-2024-35924: usb: typec: ucsi: Limit read size on v1.2

stable/6.1 was fixed.

Fixed status
stable/6.1: [af9bdf05557dc21040df2f11062133dd1e503a09]

CVE-2024-35942: pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock
to hdmimix domain

stable/6.1 was fixed.

Fixed status
stable/6.1: [7c280b5fa64fe78a1a1d198b44a2d90bda36ed65]

CVE-2024-35945: net: phy: phy_device: Prevent nullptr exceptions on ISR

stable/6.1 was fixed.

Fixed status
stable/6.1: [a4f082d6a90ecb6c980579ae170b27f48d5601f5]

CVE-2024-35946: wifi: rtw89: fix null pointer access when abort scan

stable/6.1 was fixed.

Fixed status
stable/6.1: [96b49702bc0db9263c06840099b5008b72be919a]

CVE-2024-35951: drm/panfrost: Fix the error path in
panfrost_mmu_map_fault_addr()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f959d043b745b352c7d1c9b832a57ffcf05bc935]

CVE-2024-36881: mm/userfaultfd: reset ptes when close() for wr-protected ones

stable/6.1 was fixed.

Fixed status
stable/6.1: [1da0471de653b13c8f63dcd32a23574d683c8310]

CVE-2024-36911: hv_netvsc: Don't free decrypted memory

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb671512ffb26570c05ba3fbe20752e645809192]

CVE-2024-36968: Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e34634fad3792d4d35850cae72b7b7813466844f]

CVE-2024-38390: drm/msm/a6xx: Avoid a nullptr dereference when
speedbin setting fails

stable/5.15 was fixed.

Fixed status
stable/5.15: [e23060710e6c92f7fe096c62b93b433ee03541aa]

CVE-2024-38557: net/mlx5: Reload only IB representors upon lag disable/enable

stable/6.1 was fixed.

Fixed status
stable/6.1: [6077962743c037cbd49fd31e5c4cdd20ffd03bad]

CVE-2024-38564: bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
enforcement in BPF_LINK_CREATE

stable/6.1 was fixed.

Fixed status
stable/6.1: [05254ef6fe09cf12afe6ac40915c3b423c852237]

CVE-2024-38570: gfs2: Fix potential glock use-after-free on unmount

stable/6.1 was fixed.

Fixed status
stable/6.1: [94b32a85d1a76ae4f1b42a88677fa20b20187729]

CVE-2024-38594: net: stmmac: move the EST lock to struct stmmac_priv

stable/6.1 was fixed.

Fixed status
stable/6.1: [4fe005dca04cf906cc699efac49a24838ab4be0b]

CVE-2024-38608: net/mlx5e: Fix netif state handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [96e3eeccea9b55ca9c6a18a5a59ee3d6f12e0fb3]

CVE-2024-38622: drm/msm/dpu: Add callback function pointer check before its call

stable/6.1 was fixed.

Fixed status
stable/6.1: [cefb0a99eddf7dd131121a7b348ffbbe32254ec4]

CVE-2024-38625: fs/ntfs3: Check 'folio' pointer for NULL

stable/6.1 was fixed.

Fixed status
stable/6.1: [1263c0f5019ba248494f7182b18216632c31231c]

CVE-2024-38630: watchdog: cpu5wdt.c: Fix use-after-free bug caused by
cpu5wdt_trigger

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [948ed659c0151a605bd126da1e95f350ec5a7956]
stable/6.1: [9abe50e8492d1accd7d8dc17991179472d3d4573]

CVE-2024-40909: bpf: Fix a potential use-after-free in bpf_link_free()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e8ccda39b395169622855607085cdeef4d376e0f]

CVE-2024-40975: platform/x86: x86-android-tablets: Unregister devices
in reverse order

stable/6.1 was fixed.

Fixed status
stable/6.1: [f3f8517f9839f8731e2eeccdc52fc1e84ee4a98a]

CVE-2024-40998: ext4: fix uninitialized ratelimit_state->lock access
in __ext4_fill_super()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1e2df0ee0afd6d4b436a740f04f7a759e6531005]

CVE-2024-40999: net: ena: Add validation for completion descriptors consistency

stable/6.1 was fixed.

Fixed status
stable/6.1: [4f163a8035e76e835a984cf548b3e6922cfe145f]

CVE-2024-41008: drm/amdgpu: change vm->task_info handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa22d6c58505d239814b5ef8fa7da4ce43e9212b]

CVE-2024-41023: sched/deadline: Fix task_struct reference leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [8acaaeb484097f46c93bb6c3f836d1c1c07fcbdc]

CVE-2024-41031: mm/filemap: skip to create PMD-sized page cache if needed

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ab83133e44ad42e07665a4f63274f1bf749e8cc]

CVE-2024-41045: bpf: Defer work in bpf_timer_cancel_and_free

stable/6.1 was fixed.

Fixed status
stable/6.1: [7b27f15cab4c7d4f28c25b94a5284ad6d9d3695d]

CVE-2024-41048: skmsg: Skip zero length skb in sk_msg_recvmsg

stable/5.10 was fixed.

Fixed status
stable/5.10: [ddf6f5179638ef0716d32e8fc04a72822b135351]

CVE-2024-41082: nvme-fabrics: use reserved tag for reg read/write command

stable/6.1 was fixed.

Fixed status
stable/6.1: [2f07bdd363e95b71959d1ea1a7bca53c9e1f1efb]

CVE-2024-41935: f2fs: fix to shrink read extent node in batches

stable/6.1 was fixed.

Fixed status
stable/6.1: [e05d3eab90d6657bdcaa40ed129e9c767ed43188]

CVE-2024-42107: ice: Don't process extts if PTP is disabled

stable/6.1 was fixed.

Fixed status
stable/6.1: [2ab26aeec3de0a677e02d6bc4dc85d49cd1ec4ac]

CVE-2024-42123: drm/amdgpu: fix double free err_addr pointer warnings

stable/6.1 was fixed.

Fixed status
stable/6.1: [e4233036eaa4c6a4087e42bb18bc853b4b5fab3b]

CVE-2024-42128: leds: an30259a: Use devm_mutex_init() for mutex initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [56c05de9749534436f1a3c7859a8167f34dd5010]

CVE-2024-42139: ice: Fix improper extts handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [2aa24007bf037194e9c72e7c83b26b2e9e07ab62]

CVE-2024-42155: s390/pkey: Wipe copies of protected- and secure-keys

stable/6.1 was fixed.

Fixed status
stable/6.1: [016dbf1a1ae1d13fca8589f884a296854c1756db]

CVE-2024-42156: s390/pkey: Wipe copies of clear-key structures on failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [382f94bb724b41a76030557a29bbffb965d4c0ae]

CVE-2024-42158: s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings

stable/6.1 was fixed.

Fixed status
stable/6.1: [f2e43af834fcc652b324384f14b561cf610742d4]

CVE-2024-42239: bpf: Fail bpf_timer_cancel when callback is being cancelled

stable/6.1 was fixed.

Fixed status
stable/6.1: [82f2348592ef16c90a55b783c3a1354bcd6d4d1d]

CVE-2024-42241: mm/shmem: disable PMD-sized page cache if needed

stable/6.1 was fixed.

Fixed status
stable/6.1: [e991bfc6b69e3db6bdefde34f5d5c9686a192e8f]

CVE-2024-42243: mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c8a837153c15c33f9b4616860331a2dba1120c1]

CVE-2024-42279: spi: microchip-core: ensure TX and RX FIFOs are empty
at start of a transfer

stable/6.1 was fixed.

Fixed status
stable/6.1: [950375a0ba7d6c82ea5b5a44dd48a9e41fa45826]

CVE-2024-43819: kvm: s390: Reject memory region operations for ucontrol VMs

stable/6.1 was fixed.

Fixed status
stable/6.1: [8a1bbff443a5a22c466d11cbefca9cb361306a9b]

CVE-2024-43824: PCI: endpoint: pci-epf-test: Make use of cached
'epc_features' in pci_epf_test_core_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5c71be3476088ab490d48a468b54d791f91241b8]

CVE-2024-43850: soc: qcom: icc-bwmon: Fix refcount imbalance seen
during bwmon_remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [8bbcd84133e16e8f87d6765681639e2210d4be69]

CVE-2024-43872: RDMA/hns: Fix soft lockup under heavy CEQE load

stable/6.1 was fixed.

Fixed status
stable/6.1: [97740304c953ac43aebd24678ae999fe0bc9decf]

CVE-2024-43899: drm/amd/display: Fix null pointer deref in dcn20_resource.c

stable/6.1 was fixed.

Fixed status
stable/6.1: [dc4428bf483cb8335bb3377534d19b1b7e62ec5c]

CVE-2024-43913: nvme: apple: fix device reference counting

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c9e4e99dcc0d30160d65044f54a92ff6372c90d]

CVE-2024-44941: f2fs: fix to cover read extent cache access with lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [9bd5d5e3244242e7be26e86025b74eff3cf20d8c]

CVE-2024-44942: f2fs: fix to do sanity check on F2FS_INLINE_DATA flag
in inode during GC

stable/6.1 was fixed.

Fixed status
stable/6.1: [54a8da38b70553b61e2265ee0f26d034349dde25]

CVE-2024-44951: serial: sc16is7xx: fix TX fifo corruption

stable/6.1 was fixed.

Fixed status
stable/6.1: [263682f5669ceeb70b14b4eda209fb34d67331ec]

CVE-2024-44963: btrfs: do not BUG_ON() when freeing tree block after error

stable/6.1 was fixed.

Fixed status
stable/6.1: [bfcef12f80b3a9bd6b09c7305679164e3307328a]

CVE-2024-46681: pktgen: use cpus_read_lock() in pg_net_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1b4fe364b561b952dd7beeba7f7616f9a419b83a]

CVE-2024-46728: drm/amd/display: Check index for aux_rd_interval before using

stable/6.1 was fixed.

Fixed status
stable/6.1: [393b398fa09226e5d1d7f67da399cc88f56e2395]

CVE-2024-46730: drm/amd/display: Ensure array index tg_inst won't be -1

stable/6.1 was fixed.

Fixed status
stable/6.1: [1de84b6d65a7df30b5edc7208f828c4ecc8a7154]

CVE-2024-46765: ice: protect XDP configuration with a mutex

stable/6.1 was fixed.

Fixed status
stable/6.1: [01f2f2659de463ca8bcd90e9d2fe36211edad7a8]

CVE-2024-46775: drm/amd/display: Validate function returns

stable/6.1 was fixed.

Fixed status
stable/6.1: [18792cbeba632cedc816eaea1dd448ebb35de809]

CVE-2024-46787: userfaultfd: fix checks for huge PMDs

stable/6.1 was fixed.

Fixed status
stable/6.1: [b25c0767a6a18a8399f57c63e50b5cc19037e90a]

CVE-2024-46808: drm/amd/display: Add missing NULL pointer check within
dpcd_extend_address_range

stable/6.1 was fixed.

Fixed status
stable/6.1: [2aed55dca0ee2a14ba86d08299d7fca33b075d4b]

CVE-2024-46811: drm/amd/display: Fix index may exceed array range
within fpu_update_bw_bounding_box

stable/6.1 was fixed.

Fixed status
stable/6.1: [6d8685dd9718e0613f7c64253500874021b9efc9]

CVE-2024-46813: drm/amd/display: Check link_index before accessing dc->links[]

stable/6.1 was fixed.

Fixed status
stable/6.1: [8ad4c2cf6c1af18f556e5c591fb313b2982ddf60]

CVE-2024-46834: ethtool: fail closed if we can't get max channel used
in indirection tables

stable/6.1 was fixed.

Fixed status
stable/6.1: [83203ec6f65680109b2048c4f3e501efc14104ba]

CVE-2024-46860: wifi: mt76: mt7921: fix NULL pointer access in
mt7921_ipv6_addr_change

stable/6.1 was fixed.

Fixed status
stable/6.1: [bcf390440080c24983ab035660203b17e7c7f31e]

CVE-2024-47141: pinmux: Use sequential access to access desc->pinmux data

stable/6.1 was fixed.

Fixed status
stable/6.1: [d25e45dcf8e32062f7935e4ba154869043812ab6]

CVE-2024-47658: crypto: stm32/cryp - call finalize with bh disabled

stable/6.1 was fixed.

Fixed status
stable/6.1: [d16983c48f922ef46fb154b52a5b7eed2e689eae]

CVE-2024-47661: drm/amd/display: Avoid overflow from uint32_t to uint8_t

stable/6.1 was fixed.

Fixed status
stable/6.1: [1f95056cae7bded5614ecda415af1d6d4428494e]

CVE-2024-47664: spi: hisi-kunpeng: Add verification for the
max_frequency provided by the firmware

stable/6.1 was fixed.

Fixed status
stable/6.1: [dc30f8d9b25db3b79d36971a90c1ee95010ff45a]

CVE-2024-47677: exfat: resolve memory leak from exfat_create_upcase_table()

stable/6.1 was fixed.

Fixed status
stable/6.1: [34b44a17fad82d41a69a2a3e68b5c27016828ba6]

CVE-2024-47752: media: mediatek: vcodec: Fix H264 stateless decoder
smatch warning

stable/6.1 was fixed.

Fixed status
stable/6.1: [207268a03149e134ce60f63dd79a9fbb0ac95e69]

CVE-2024-47794: bpf: Prevent tailcall infinite loop caused by freplace

stable/6.1 was fixed.

Fixed status
stable/6.1: [272f92998cbec9e12fea8ef28f48d6b1bc625a34]

CVE-2024-49569: nvme-rdma: unquiesce admin_q before destroy it

stable/6.1 was fixed.

Fixed status
stable/6.1: [53bdbe5dc80b5887af51d62bf44e50f56972db5f]

CVE-2024-49901: drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4a48e2e501267c8d0a9a10ada41d960ddb2dae22]
stable/5.15: [542e679cd4ec93c959b014df9c31b4888e92bac8]
stable/6.1: [24168aae5a5010fa7d5068a318366e847ec3ad1e]

CVE-2024-49906: drm/amd/display: Check null pointer before try to access it

stable/6.1 was fixed.

Fixed status
stable/6.1: [a38571ce60adb24c0db2448006d0ccc64da21adb]

CVE-2024-49914: drm/amd/display: Add null check for
pipe_ctx->plane_state in dcn20_program_pipe

stable/6.1 was fixed.

Fixed status
stable/6.1: [21c613e1c6ae45bb29ebc156d22060f034cc5665]

CVE-2024-49918: drm/amd/display: Add null check for head_pipe in
dcn32_acquire_idle_pipe_for_head_pipe_in_layer

stable/6.1 was fixed.

Fixed status
stable/6.1: [360eebfdd0ac5acd45a5fb888c2caecf19093b3f]

CVE-2024-49919: drm/amd/display: Add null check for head_pipe in
dcn201_acquire_free_pipe_for_layer

stable/6.1 was fixed.

Fixed status
stable/6.1: [d11ae22a8beee9771d933c1e5c95e217edcdbd38]

CVE-2024-49920: drm/amd/display: Check null pointers before multiple uses

stable/6.1 was fixed.

Fixed status
stable/6.1: [7dc67992b35bc11895149b4261c4ad745312a18d]

CVE-2024-49921: drm/amd/display: Check null pointers before used

stable/6.1 was fixed.

Fixed status
stable/6.1: [348f8668dfa77294a277946cb0231c29b5474e1d]

CVE-2024-49922: drm/amd/display: Check null pointers before using them

stable/6.1 was fixed.

Fixed status
stable/6.1: [530e3d67637e55a59c131f1569352798692b81e9]

CVE-2024-49923: drm/amd/display: Pass non-null to
dcn20_validate_apply_pipe_split_flags

stable/6.1 was fixed.

Fixed status
stable/6.1: [34fe02e7207be635725dcf92dbe7003e11697a5b]

CVE-2024-49940: l2tp: prevent possible tunnel refcount underflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa7132362e79abc4f2add4d8657dd1679341edc5]

CVE-2024-49945: net/ncsi: Disable the ncsi work before freeing the
associated structure

stable/6.1 was fixed.

Fixed status
stable/6.1: [6a921089feeef364169a34a7e5a3968138c00c7f]

CVE-2024-49970: drm/amd/display: Implement bounds check for stream
encoder creation in DCN401

stable/6.1 was fixed.

Fixed status
stable/6.1: [664f12d9ebdfdfb9c05e5cb31f268e92fb9042fe]

CVE-2024-50009: cpufreq: amd-pstate: add check for cpufreq_cpu_get's
return value

stable/6.1 was fixed.

Fixed status
stable/6.1: [93f404a55ff06fb0978dfdc786139b8af4a531a8]

CVE-2024-50135: nvme-pci: fix race condition between reset and
nvme_dev_disable()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0beb55fc6086c86eb07954c914e728a8cb0cd57e]

CVE-2024-50226: cxl/port: Fix use-after-free, permit out-of-order
decoder shutdown

stable/6.1 was fixed.

Fixed status
stable/6.1: [3ecd2b229f5e42b36b5acf0e82510a70a632f041]

CVE-2024-50285: ksmbd: check outstanding simultaneous SMB operations

stable/6.1 was fixed.

Fixed status
stable/6.1: [d2e2830c19824c221b6f5e17bf272438cc0e601c]

CVE-2024-50289: media: av7110: fix a spectre vulnerability

stable/6.1 was fixed.

Fixed status
stable/6.1: [8567e451158fc75b633c37a5b15bb40a954ec554]

CVE-2024-52559: drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e6a1565f5edacc37a82f12810566b8f6d73c33e5]

CVE-2024-52560: fs/ntfs3: Mark inode as bad as soon as error detected
in mi_enum_attr()

stable/6.1 was fixed.

Fixed status
stable/6.1: [bbab6587559d1a22f2c28d93ff4ca744d3667c8f]

CVE-2024-53050: drm/i915/hdcp: Add encoder check in hdcp2_get_capability

stable/6.1 was fixed.

Fixed status
stable/6.1: [54224c32330f63e2d5c339d49be71705f4e2d113]

CVE-2024-53051: drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability

stable/6.1 was fixed.

Fixed status
stable/6.1: [b402f41a3095552d854b4ae670220f46410e8937]

CVE-2024-53056: drm/mediatek: Fix potential NULL dereference in
mtk_crtc_destroy()

stable/6.1 was fixed.

Fixed status
stable/6.1: [32ac6dccf561af97f20a3831430577d8a978e672]

CVE-2024-53068: firmware: arm_scmi: Fix slab-use-after-free in
scmi_bus_notifier()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c3c49feed980279e8342b934bf2c7f25df1b0bc1]

CVE-2024-53090: afs: Fix lock recursion

stable/6.1 was fixed.

Fixed status
stable/6.1: [d256a7f2385cf59d09526c794367d44fd7a26c7a]

CVE-2024-53091: bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx

stable/6.1 was fixed.

Fixed status
stable/6.1: [e675829d287791dd90b70a9413fa7cfb8308830c]

CVE-2024-53094: RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

stable/6.1 was fixed.

Fixed status
stable/6.1: [d5a019e819a0f0457570416bb2eb5f3321f5be81]

CVE-2024-53095: smb: client: Fix use-after-free of network namespace.

stable/6.1 was fixed.

Fixed status
stable/6.1: [7e487bbab951f15113edc5061bedf1d4aaf834eb]

CVE-2024-53114: x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

stable/6.1 was fixed.

Fixed status
stable/6.1: [e7c81a79fe1fa28c1825fb786bd3c749af471b0b]

CVE-2024-53134: pmdomain: imx93-blk-ctrl: correct remove path

stable/6.1 was fixed.

Fixed status
stable/6.1: [138b0c42153681cd2121a286c8b35083de9d0427]

CVE-2024-53147: exfat: fix out-of-bounds access of directory entries

stable/6.1 was fixed.

Fixed status
stable/6.1: [98e3572505a9ec550b5296c67c4517120356c8d6]

CVE-2024-53168: sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

stable/6.1 was fixed.

Fixed status
stable/6.1: [7d44f706c6f1d89bcec901aa0da9067815803baf]

CVE-2024-53178: smb: Don't leak cfid when reconnect races with open_cached_dir

stable/6.1 was fixed.

Fixed status
stable/6.1: [c8bf625e188593232d515fb50e240305b6ae14dd]

CVE-2024-53179: smb: client: fix use-after-free of signing key

stable/6.1 was fixed.

Fixed status
stable/6.1: [0944c2596c2a3442735b5bb6714a17a16188a68f]

CVE-2024-53187: io_uring: check for overflows in io_pin_pages

stable/6.1 was fixed.

Fixed status
stable/6.1: [f1938217aee05be1c1dc53f581a3c353d033b508]

CVE-2024-53195: KVM: arm64: Get rid of userspace_irqchip_in_use

stable/6.1 was fixed.

Fixed status
stable/6.1: [982a1461ab9cf3146302fe5a139ecb1f9b2d33fc]

CVE-2024-53201: drm/amd/display: Fix null check for
pipe_ctx->plane_state in dcn20_program_pipe

stable/6.1 was fixed.

Fixed status
stable/6.1: [82f7058ce05c1fad8573950c50bb5befafe7e787]

CVE-2024-53216: nfsd: release svc_expkey/svc_export with rcu_work

stable/6.1 was fixed.

Fixed status
stable/6.1: [a98fa661769edacd3bf319c4a150f00bea61945b]

CVE-2024-53224: RDMA/mlx5: Move events notifier registration to be
after device registration

stable/6.1 was fixed.

Fixed status
stable/6.1: [09ef1c03a7ac2b57be8aeb0c7a75d538ded2562a]

CVE-2024-54683: netfilter: IDLETIMER: Fix for possible ABBA deadlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [5493d84a40f0e61da74e1b0db640845997836b4e]

CVE-2024-56538: drm: zynqmp_kms: Unplug DRM device before removal

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c8ca1da81e5a9787284eb84c0c6ae927f063c15]

CVE-2024-56565: f2fs: fix to drop all discards after creating snapshot
on lvm device

stable/6.1 was fixed.

Fixed status
stable/6.1: [0f3b00763dae90e94eed94a39d32d252d8750e9d]

CVE-2024-56566: mm/slub: Avoid list corruption when removing a slab
from the full list

stable/6.1 was fixed.

Fixed status
stable/6.1: [a81a0e7fc85125248363d5c944bef268218c9718]

CVE-2024-56583: sched/deadline: Fix warning in migrate_enable for boosted tasks

stable/6.1 was fixed.

Fixed status
stable/6.1: [6923c1b117a93477c392a1d46da73ef40987a091]

CVE-2024-56588: scsi: hisi_sas: Create all dump files during debugfs
initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [76d5b00af5422b899b3c1761328dc933e17c1a66]

CVE-2024-56592: bpf: Call free_htab_elem() after htab_unlock_bucket()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b6a49b87cc73153a3ea5ae3f64b980386059dca]

CVE-2024-56611: mm/mempolicy: fix migrate_to_node() assuming there is
at least one VMA in a MM

stable/6.1 was fixed.

Fixed status
stable/6.1: [482bafbbebcaf286579f93494ba6899030a6ad47]

CVE-2024-56641: net/smc: initialize close_work early to avoid warning

stable/6.1 was fixed.

Fixed status
stable/6.1: [d3909a85414041c2a4d147ae5589767d58ee794b]

CVE-2024-56692: f2fs: fix to do sanity check on node blkaddr in truncate_node()

stable/6.1 was fixed.

Fixed status
stable/6.1: [a6d51de6bf729edc9fc7f87ffaae4e6bbda6329a]

CVE-2024-56712: udmabuf: fix memory leak on last export_udmabuf() error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [00ebdef47994206f60546929a0f6f63285497272]

CVE-2024-56729: smb: Initialize cfid->tcon before performing network ops

stable/6.1 was fixed.

Fixed status
stable/6.1: [269ff24a5b2b58600151e04e964d2043bfe1843c]

CVE-2024-56742: vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()

stable/6.1 was fixed.

Fixed status
stable/6.1: [549384162ed7e84bdefa004b589215d18b0190c5]

CVE-2024-57804: scsi: mpi3mr: Fix corrupt config pages PHY state is
switched in sysfs

stable/6.1 was fixed.

Fixed status
stable/6.1: [90dffa3cec53c0d1af7813a2603f740730c4417e]

CVE-2024-57888: workqueue: Do not warn when cancelling WQ_MEM_RECLAIM
work from !WQ_MEM_RECLAIM worker

stable/6.1 was fixed.

Fixed status
stable/6.1: [b5d9d93910dc2ec25f66cfaf5d90b74feac109d1]

CVE-2024-57974: udp: Deal with race between UDP socket address change and rehash

stable/6.1 was fixed.

Fixed status
stable/6.1: [3946283de7bbb76b2995bd51ab0388d4fd556c77]

CVE-2024-57976: btrfs: do proper folio cleanup when cow_file_range() failed

stable/6.1 was fixed.

Fixed status
stable/6.1: [29418ebb8b4d4d090e403d395a6db7e8455331f7]

CVE-2024-57982: xfrm: state: fix out-of-bounds read during lookup

stable/6.1 was fixed.

Fixed status
stable/6.1: [80610185e9dd2ef7c0a4818a47390a8655b3dc27]

CVE-2024-57999: powerpc/pseries/iommu: IOMMU incorrectly marks MMIO range in DDW

stable/6.1 was fixed.

Fixed status
stable/6.1: [c2776107f3309141ae98b27571c47f26436be854]

CVE-2024-58006: PCI: dwc: ep: Prevent changing BAR size/flags in
pci_epc_set_bar()

stable/6.1 was fixed.

Fixed status
stable/6.1: [8dbc2d9e6b8612b9d5f41c0ea875e86183ff9617]

CVE-2024-58012: ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid
during params

stable/6.1 was fixed.

Fixed status
stable/6.1: [eb36662773ce1dd9b709fc0b962b2149b2a2e60e]

CVE-2024-58096: wifi: ath11k: add srng->lock for ath11k_hal_srng_* in
monitor mode

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7cc16629ae391c8ba44464ca29fcbbc1a3e1336]

CVE-2025-21635: rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

stable/6.1 was fixed.

Fixed status
stable/6.1: [6f353c2230c199f343406c08482940ec5d8ba89c]

CVE-2025-21656: hwmon: (drivetemp) Fix driver producing garbage data
when SCSI errors occur

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [babdf2a11329d30dc5086eb7a938a360aa490282]
stable/5.15: [0435d35f9d511fa5ddba49c9f68f947e395c93f9]
stable/6.1: [f9723fd2770ef5563ff1685f72bcc1c411219c29]

CVE-2025-21658: btrfs: avoid NULL pointer dereference if no valid extent tree

stable/6.1 was fixed.

Fixed status
stable/6.1: [1fb37b7840fdcbf69d062a79d14afbf566b11873]

CVE-2025-21673: smb: client: fix double free of TCP_Server_Info::hostname

stable/6.1 was fixed.

Fixed status
stable/6.1: [35455f6c9326a8d10e91f3d5ba9260ab795b7d9a]

CVE-2025-21696: mm: clear uffd-wp PTE/PMD state on mremap()

stable/6.1 was fixed.

Fixed status
stable/6.1: [96fed9f20481d07eba8a7fe93bc77abef178198c]

CVE-2025-21714: RDMA/mlx5: Fix implicit ODP use after free

stable/6.1 was fixed.

Fixed status
stable/6.1: [032f3f799fdb807a21467b7dc7d620395a735e2b]

CVE-2025-21723: scsi: mpi3mr: Fix possible crash when setting up bsg fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [1ee558f98d9e247210e2301e19cc6e605778d4f1]

CVE-2025-21729: wifi: rtw89: fix race between cancel_hw_scan and
hw_scan completion

stable/6.1 was fixed.

Fixed status
stable/6.1: [02d78fb7fa1f4f4d6ecc6034e81c6db38385ce96]

CVE-2025-21732: RDMA/mlx5: Fix a race for an ODP MR which leads to CQE
with error

stable/6.1 was fixed.

Fixed status
stable/6.1: [63126215de7beebb662fcef7c7558c795000c904]

CVE-2025-21768: net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels

stable/6.1 was fixed.

Fixed status
stable/6.1: [26f0b472ae2a82920e38c7cf41583951046d586a]

CVE-2025-21801: net: ravb: Fix missing rtnl lock in suspend/resume path

stable/6.1 was fixed.

Fixed status
stable/6.1: [5d45f5c51e676e3bcbfe49249499621d571287d4]

CVE-2025-21831: PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff1cc51313ebe2f17530fcce0fb908cfcbbf38e5]

CVE-2025-21870: ASoC: SOF: ipc4-topology: Harden loops for looking up
ALH copiers

stable/6.1 was fixed.

Fixed status
stable/6.1: [ec8f5a4fe296c311d4b45db7a25a0e9e69802372]

CVE-2025-21872: efi: Don't map the entire mokvar table to determine its size

stable/6.1 was fixed.

Fixed status
stable/6.1: [f17a72ac7dd6f9469c9e6185bdbb22dbb744dd74]

CVE-2025-21885: RDMA/bnxt_re: Fix the page details for the srq created
by kernel consumers

stable/6.1 was fixed.

Fixed status
stable/6.1: [c07040d450581b50db3311d1348c4018ef704de0]

CVE-2025-21886: RDMA/mlx5: Fix implicit ODP hang on parent deregistration

stable/6.1 was fixed.

Fixed status
stable/6.1: [641e50b27e87d7cd0d194f7a164703de599055b1]

CVE-2025-21888: RDMA/mlx5: Fix a WARN during dereg_mr for DM type

stable/6.1 was fixed.

Fixed status
stable/6.1: [8fe3c674ef289cdc0760fe787e7584d805ab9301]

CVE-2025-21892: RDMA/mlx5: Fix the recovery flow of the UMR QP

stable/6.1 was fixed.

Fixed status
stable/6.1: [439cc4210978e6d03c5c374ecf967b361595a55b]

CVE-2025-21894: net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC

stable/6.1 was fixed.

Fixed status
stable/6.1: [3ad5fe77e477a8652c535b3a0343cf3d9ee10056]

CVE-2025-21927: nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3b54109b2f771f74fd53b027429796326f84ab36]

CVE-2025-21955: ksmbd: prevent connection release during oplock break
notification

stable/6.1 was fixed.

Fixed status
stable/6.1: [8e6508c7ecb1802909f294827eff38f301d0c937]

CVE-2025-21961: eth: bnxt: fix truesize for mb-xdp-pass case

stable/6.1 was fixed.

Fixed status
stable/6.1: [01492e94a823c50f4ab5084e3ac210ba981133be]

CVE-2025-21967: ksmbd: fix use-after-free in ksmbd_free_work_struct

stable/6.1 was fixed.

Fixed status
stable/6.1: [ffe0909010b21df8f948d624ad00cf14dd856721]

CVE-2025-21969: Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd

stable/6.1 was fixed.

Fixed status
stable/6.1: [967473b1e8bb6d941e034ec1f76de40ccf54a8cf]

CVE-2025-21972: net: mctp: unshare packets when reassembling

stable/6.1 was fixed.

Fixed status
stable/6.1: [771087069a27c35c0a9fd7cc74fe7725b189b96b]

CVE-2025-22037: ksmbd: fix null pointer dereference in alloc_preauth_hash()

stable/6.1 was fixed.

Fixed status
stable/6.1: [2d3461d6ae74ebdcd4d65128c855198649bcadcd]

CVE-2025-22048: LoongArch: BPF: Don't override subprog's return value

stable/6.1 was fixed.

Fixed status
stable/6.1: [d99845f672cce0b610f7c51248ef95d7df63927e]

CVE-2025-22053: net: ibmveth: make veth_pool_store stop hanging

stable/6.1 was fixed.

Fixed status
stable/6.1: [c1bcbc4ee8f2e4567a9f63ec5a37e29b3fecf15a]

CVE-2025-22057: net: decrease cached dst counters in dst_release

stable/6.1 was fixed.

Fixed status
stable/6.1: [973bb0bc6240b55e313248ef3c6aa551ab7bb735]

CVE-2025-22070: fs/9p: fix NULL pointer dereference on mkdir

stable/6.1 was fixed.

Fixed status
stable/6.1: [d5031a71a2d0e76d3eb02b52b21c17c881919d53]

CVE-2025-22074: ksmbd: fix r_count dec/increment mismatch

stable/6.1 was fixed.

Fixed status
stable/6.1: [8829849da3f68697b830a5b36047b0d8a50ae3ed]

CVE-2025-22109: ax25: Remove broken autobind

stable/6.1 was fixed.

Fixed status
stable/6.1: [7bffc5aad1e89354151150af2d4ded20b3c702a0]

CVE-2025-22115: btrfs: fix block group refcount race in
btrfs_create_pending_block_groups()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3232bdf8a135877345c25bf4c0d892334a4c03f7]

CVE-2025-22127: f2fs: fix potential deadloop in prepare_compress_overwrite()

stable/6.1 was fixed.

Fixed status
stable/6.1: [353b262268c1646a0e7c96d4ed14c5d72a30ccb4]

CVE-2025-37747: perf: Fix hang while freeing sigtrap event

stable/6.1 was fixed.

Fixed status
stable/6.1: [20ab73bb467d900662dca043452aadecb2db8338]

CVE-2025-37750: smb: client: fix UAF in decryption with multichannel

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e94c8cc7fa220ac50d6a3ce9a63d227696c95b8]

CVE-2025-37806: fs/ntfs3: Keep write operations atomic

stable/6.1 was fixed.

Fixed status
stable/6.1: [ad4429a5cd6b9175532d62e97262d16e60c3b166]

CVE-2025-37807: bpf: Fix kmemleak warning for percpu hashmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [c5f4b04e1838b9eec426d80500af49cff8631762]

CVE-2025-37842: spi: fsl-qspi: use devm function instead of driver remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [69d2d7020b9966817ffc7442ae778c29cb81813f]

CVE-2025-37853: drm/amdkfd: debugfs hang_hws skip GPU with MES

stable/6.1 was fixed.

Fixed status
stable/6.1: [36282eb8b8e056f7b681975ab3774f587c4fbc34]

CVE-2025-37856: btrfs: harden block_group::bg_list against list_del() races

stable/6.1 was fixed.

Fixed status
stable/6.1: [ccb20413e7c82e4429c81f10d0e36cd9c0c643cd]

CVE-2025-37860: sfc: fix NULL dereferences in ef100_process_design_param()

stable/6.1 was fixed.

Fixed status
stable/6.1: [68ce59a1fdec97d94384499d3b5bc097fca0dd5d]

CVE-2025-37861: scsi: mpi3mr: Synchronous access b/w reset and tm
thread for reply queue

stable/6.1 was fixed.

Fixed status
stable/6.1: [e9efbd037b9002ce9dd012da612e857e98dfcb3e]

CVE-2025-37952: ksmbd: Fix UAF in __close_file_table_ids

stable/6.1 was fixed.

Fixed status
stable/6.1: [21100812657965dd95bc305f6076f62012f34cf4]

CVE-2025-37956: ksmbd: prevent rename with empty string

stable/6.1 was fixed.

Fixed status
stable/6.1: [35e2964e93d95185d2db0c0ffd9959d0197b3956]

CVE-2025-37957: KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

stable/6.1 was fixed.

Fixed status
stable/6.1: [dc86a9cd181788f6cc4a2dbcd92ea6473dc2923f]

CVE-2025-37977: scsi: ufs: exynos: Disable iocc if dma-coherent
property isn't set

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa64b94202d4453d616873ce318e19b064dfce04]

CVE-2025-38006: net: mctp: Don't access ifa_index when missing

stable/6.1 was fixed.

Fixed status
stable/6.1: [d22efcd246a7688599eefcf8e5c7985a3854ef5d]

CVE-2025-38029: kasan: avoid sleepable page allocation from atomic context

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6a895d88fbd453dc8f1c5e038188b49b272afe6]

CVE-2025-38041: clk: sunxi-ng: h616: Reparent GPU clock during frequency changes

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b447255bf170aee508d50c4a3a1156eb6dcc9b4]

CVE-2025-38042: dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
from k3_udma_glue_reset_rx_chn

stable/6.1 was fixed.

Fixed status
stable/6.1: [575c1b6c5574196071cd8ee672e87641ef15778f]

CVE-2025-38045: wifi: iwlwifi: fix debug actions order

stable/6.1 was fixed.

Fixed status
stable/6.1: [49d7587274282fd92a7db6b70dfbc7c973f4f52b]

CVE-2025-38059: btrfs: avoid NULL pointer dereference if no valid csum tree

stable/6.1 was fixed.

Fixed status
stable/6.1: [2db25048a61c0909459b074af04e06ab8a8b939e]

CVE-2025-38064: virtio: break and reset virtio devices on device_shutdown()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c03e32494dd0bbcc301523e5ae567c2f567a7d9]

CVE-2025-38069: PCI: endpoint: pci-epf-test: Fix double free that
causes kernel to oops

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2e43854ab72a9d4908ac2bf6087f80aa138a8b5]

CVE-2025-38081: spi-rockchip: Fix register out of bounds access

stable/6.1 was fixed.

Fixed status
stable/6.1: [7a27d8dd9354f00e823dfb557b690ea44b4a146f]

CVE-2025-38096: wifi: iwlwifi: don't warn when if there is a FW error

stable/6.1 was fixed.

Fixed status
stable/6.1: [0709bdf1faa6136c13808289b01db426cfd03ed7]

CVE-2025-38127: ice: fix Tx scheduler error handling in XDP callback

stable/6.1 was fixed.

Fixed status
stable/6.1: [6bea620584f079d7aa3924ee191ea7ba25e02fc2]

CVE-2025-38132: coresight: holding cscfg_csdev_lock while removing
cscfg from csdev

stable/6.1 was fixed.

Fixed status
stable/6.1: [18a3a21c39cca593762aa90f322bd74c18ec59d4]

CVE-2025-38182: ublk: santizize the arguments from userspace when
adding a device

stable/6.1 was fixed.

Fixed status
stable/6.1: [a52d4e28f643eb4ffc7ccb1de9bd47d876804f1f]

CVE-2025-38195: LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

stable/6.1 was fixed.

Fixed status
stable/6.1: [55a9a7d21309bbea1dd629cf28396521a2803bb3]

CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missing_indices

stable/6.1 was fixed.

Fixed status
stable/6.1: [5730e2da0655336fed6aa3c25892e69e2ba5cb76]

CVE-2025-38234: sched/rt: Fix race in push_rt_task

stable/6.1 was fixed.

Fixed status
stable/6.1: [35b55cd665fbfd72805318f7017626eefd13dca5]

CVE-2025-38244: smb: client: fix potential deadlock when reconnecting channels

stable/6.1 was fixed.

Fixed status
stable/6.1: [35fe966449280bfdf4c1bc0c42e7f4672290515a]

CVE-2025-38246: bnxt: properly flush XDP redirect lists

stable/6.1 was fixed.

Fixed status
stable/6.1: [003439d07d5cfc6fb72d8b923439f273c3954c41]

CVE-2025-38248: bridge: mcast: Fix use-after-free during router port
configuration

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [5df2d582f6e8a81e7ab066464845b38b2fb04094]
stable/6.1: [7bb080340bb5ffc928f47c563a9ca1528ce54911]

CVE-2025-38261: riscv: save the SR_SUM status over switches

stable/6.1 was fixed.

Fixed status
stable/6.1: [c75dc906eef2a31c18318236f1047c6e0ef4e9dd]

CVE-2025-38272: net: dsa: b53: do not enable EEE on bcm63xx

stable/6.1 was fixed.

Fixed status
stable/6.1: [3f87fe8ceaa775a5b0ed02802146c1f4743998fb]

CVE-2025-38283: hisi_acc_vfio_pci: bugfix live migration function
without VF device driver

stable/6.1 was fixed.

Fixed status
stable/6.1: [4bbc4db69264d4d38a6340d9751fb213943346d3]

CVE-2025-38359: s390/mm: Fix in_atomic() handling in do_secure_storage_access()

stable/6.1 was fixed.

Fixed status
stable/6.1: [2990e937eaff741eda531f4190455ed7f3d5c348]

CVE-2025-38429: bus: mhi: ep: Update read pointer only after buffer is written

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2176aa3ba4361e98d9f91178a762dca6cf21fe0]

CVE-2025-38507: HID: nintendo: avoid bluetooth suspend/resume stalls

stable/6.1 was fixed.

Fixed status
stable/6.1: [167c610b45b4c23a954aac70df9760a4bf358b20]

CVE-2025-38524: rxrpc: Fix recv-recv race of completed call

stable/6.1 was fixed.

Fixed status
stable/6.1: [cb720b068b18fb39c96980eb3c13f09427512be7]

CVE-2025-38531: iio: common: st_sensors: Fix use of uninitialize device structs

stable/6.1 was fixed.

Fixed status
stable/6.1: [1f88548ec8ade8538eb970e36ffe5049b89d86f7]

CVE-2025-38544: rxrpc: Fix bug due to prealloc collision

stable/6.1 was fixed.

Fixed status
stable/6.1: [3838acfc347b803b66a2c8eb510da1c489d44ca1]

CVE-2025-38582: RDMA/hns: Fix double destruction of rsv_qp

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a791715803304bf81ae2a3a278f606e36b82481]

CVE-2025-38590: net/mlx5e: Remove skb secpath if xfrm state is not found

stable/6.1 was fixed.

Fixed status
stable/6.1: [8c684ce222c54cd67ca0358ca718c8b042c75541]

CVE-2025-38595: xen: fix UAF in dmabuf_exp_from_pages()

stable/6.1 was fixed.

Fixed status
stable/6.1: [2be49867e68abbeb52d7f5d15eb1216154e2c0a0]

CVE-2025-38597: drm/rockchip: vop2: fail cleanly if missing a primary
plane for a video-port

stable/6.1 was fixed.

Fixed status
stable/6.1: [93857359a07e425b643178ce3c6e60a9e4605cac]

CVE-2025-38615: fs/ntfs3: cancle set bad inode after removing name fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [47856e10f8d5e066aa26b1f9c02d933fe0620399]

CVE-2025-38632: pinmux: fix race causing mux_owner NULL with active mux_usecount

stable/6.1 was fixed.

Fixed status
stable/6.1: [8434dec94e73cad527341d6280895191d949a702]

CVE-2025-38636: rv: Use strings in da monitors tracepoints

stable/6.1 was fixed.

Fixed status
stable/6.1: [cb8de6f5ed5c43f7387615bbe601d2a4a31b7b35]

CVE-2025-38692: exfat: add cluster chain loop check for dir

stable/6.1 was fixed.

Fixed status
stable/6.1: [1715f0996f7baf817c73613aeda500c4f73a6bd6]

CVE-2025-38705: drm/amd/pm: fix null pointer access

stable/6.1 was fixed.

Fixed status
stable/6.1: [61c643a4229c182fbfef0f93df2b2e6b79d37575]

CVE-2025-38709: loop: Avoid updating block size under exclusive owner

stable/6.1 was fixed.

Fixed status
stable/6.1: [46034518cae95db4abfde990c9ca1a0751855072]

CVE-2025-38722: habanalabs: fix UAF in export_dmabuf()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b0c23e9ec3e161a893d6ff9b4fad479e4539627]

CVE-2025-38728: smb3: fix for slab out of bounds on mount to ksmbd

stable/5.15 was fixed.

Fixed status
stable/5.15: [248c1142f09478d6cb8151510cbf4ac2673c8ac5]

CVE-2025-38734: net/smc: fix UAF on smcsk after smc_listen_out()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e3065286959664207c0162178a3b5a90808a1bf9]

CVE-2025-39677: net/sched: Fix backlog accounting in qdisc_dequeue_internal

stable/6.1 was fixed.

Fixed status
stable/6.1: [65d1b5d84a0d697e9cfcdd0e07aad1bf1cb96295]

CVE-2025-39705: drm/amd/display: fix a Null pointer dereference vulnerability

stable/6.1 was fixed.

Fixed status
stable/6.1: [dd9699368f37aca4f216857847a46a8a2c289f94]

CVE-2025-39720: ksmbd: fix refcount leak causing resource not released

stable/6.1 was fixed.

Fixed status
stable/6.1: [263680d314eaaa27334f486d86c9fe7d19f50c8a]

CVE-2025-39726: s390/ism: fix concurrency management in ism_cmd()

stable/6.1 was fixed.

Fixed status
stable/6.1: [79536c83cf38c285709757c4026da4ae151223ae]

CVE-2025-39744: rcu: Fix rcu_read_unlock() deadloop due to IRQ work

stable/6.1 was fixed.

Fixed status
stable/6.1: [6b552ffd21f9be57806ade167a757f32dd66a98d]

CVE-2025-39754: mm/smaps: fix race between smaps_hugetlb_range and migration

stable/6.1 was fixed.

Fixed status
stable/6.1: [37ee0d97298b0547cb26b6957ccfea2d356bd0e7]

CVE-2025-39767: LoongArch: Optimize module load time by optimizing
PLT/GOT counting

stable/6.1 was fixed.

Fixed status
stable/6.1: [45b4617608304119fa4da338ae2c7823982d00f6]

CVE-2025-39797: xfrm: Duplicate SPI Handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb58962aa3b9359988c7b5b15a971fd9ad5b0ecd]

CVE-2025-39810: bnxt_en: Fix memory corruption when FW resources
change during ifdown

stable/6.1 was fixed.

Fixed status
stable/6.1: [c0082a8947cf1a543013346d10c1857f0c57db83]

CVE-2025-39829: trace/fgraph: Fix the warning caused by missing
unregister notifier

stable/6.1 was fixed.

Fixed status
stable/6.1: [3cfa337c1adceda1632aefee4c3562440446ce51]

CVE-2025-39850: vxlan: Fix NPD in {arp,neigh}_reduce() when using
nexthop objects

stable/6.1 was fixed.

Fixed status
stable/6.1: [87cd41faceb0eea6201d32d6b11f861ea30591ae]

CVE-2025-39851: vxlan: Fix NPD when refreshing an FDB entry with a
nexthop object

stable/6.1 was fixed.

Fixed status
stable/6.1: [b1113c7f6110e4c7f16bbaaabf355a8948873777]

CVE-2025-39859: ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

stable/6.1 was fixed.

Fixed status
stable/6.1: [a59822a762039b6e0252f21b091245d6ad7f324b]

CVE-2025-39886: bpf: Tell memcg to use allow_spinning=false path in
bpf_timer_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3e42431a705be8417ac5b696daa1dd43b3d27169]

CVE-2025-39910: mm/vmalloc, mm/kasan: respect gfp mask in
kasan_populate_vmalloc()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c136f2e4f2edd58a62a3425d4dd373d82834d1f9]

CVE-2025-39932: smb: client: let smbd_destroy() call
disable_work_sync(&info->post_send_credits_work)

stable/6.1 was fixed.

Fixed status
stable/6.1: [5e919f0420fa3f467c0cc12bd60d08ca8a45ef8b]

CVE-2025-39933: smb: client: let recv_done verify data_offset,
data_length and remaining_data_length

stable/6.1 was fixed.

Fixed status
stable/6.1: [fdc23a47be015fba915c4f9dfd43c65ad4829a35]

CVE-2025-39952: wifi: wilc1000: avoid buffer overflow in WID string
configuration

stable/6.1 was fixed.

Fixed status
stable/6.1: [5f1578a8684794318a60a022cedbffaa3dc444ce]

CVE-2025-39989: x86/mce: use is_copy_from_user() to determine
copy-from-user context

stable/6.1 was fixed.

Fixed status
stable/6.1: [7a1168257e81954fa1b5b1ce86f47d2567e734ab]

CVE-2025-40003: net: mscc: ocelot: Fix use-after-free caused by cyclic
delayed work

stable/6.1 was fixed.

Fixed status
stable/6.1: [2dd7540183f7410e0dc85661defcc8035c14ddc9]

CVE-2025-40057: ptp: Add a upper bound on max_vclocks

stable/6.1 was fixed.

Fixed status
stable/6.1: [5ba2f8fd3db1c695f74f7f5df72eb87d52668a66]

CVE-2025-40065: RISC-V: KVM: Write hgatp register with valid mode bits

stable/6.1 was fixed.

Fixed status
stable/6.1: [feb64ca53d97b3ac8ba9ecbeae5f9426f1513650]

CVE-2025-40067: fs/ntfs3: reject index allocation if $BITMAP is empty
but blocks exist

stable/6.1 was fixed.

Fixed status
stable/6.1: [aab2e34b139f6df71ab2b1adeec9927c206adc79]

CVE-2025-40071: tty: n_gsm: Don't block input queue by waiting MSC

stable/6.1 was fixed.

Fixed status
stable/6.1: [8fcc22d6b90304d8b7436e101562218ea3faf73b]

CVE-2025-40075: tcp_metrics: use dst_dev_net_rcu()

stable/6.1 was fixed.

Fixed status
stable/6.1: [23261817e955ebeb91d7c5c667d09fa415eb88b4]

CVE-2025-40077: f2fs: fix to avoid overflow while left shift operation

stable/6.1 was fixed.

Fixed status
stable/6.1: [7fb12f75da1da83b29964c02646f851d919301ea]

CVE-2025-40135: ipv6: use RCU in ip6_xmit()

stable/5.15 was fixed.

Fixed status
stable/5.15: [7a228cfbb66cca49e9baf901c506364f8dfe036b]

CVE-2025-40136: crypto: hisilicon/qm - request reserved interrupt for
virtual function

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0a82361cef20380b1c0f342c7e92f8ddabeefc2]

CVE-2025-40137: f2fs: fix to truncate first page in error path of
f2fs_truncate()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3500d7e1ba53f39bdb8a5aa9c2066b2f08e8c92e]

CVE-2025-40158: ipv6: use RCU in ip6_output()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4549ce1057363c8dc072f40c6aa591c279eafed2]

CVE-2025-40160: xen/events: Return -EEXIST for bound VIRQs

stable/6.1 was fixed.

Fixed status
stable/6.1: [7e19b3643855d4b63442bd20e8bb811e1a75998e]

CVE-2025-40170: net: use dst_dev_rcu() in sk_setup_caps()

stable/6.1 was fixed.

Fixed status
stable/6.1: [13b0e14bfa7e6d506d8d6426b9e6d7feef01ded3]

CVE-2025-40180: mailbox: zynqmp-ipi: Fix out-of-bounds access in
mailbox cleanup loop

stable/6.1 was fixed.

Fixed status
stable/6.1: [b91951f76be14a393439c7063974b4d26f3cb64f]

CVE-2025-40268: cifs: client: fix memory leak in smb3_fs_context_parse_param

stable/6.1 was fixed.

Fixed status
stable/6.1: [299bc05e1475a4aa1eb985ade8f39e68c1bba9b9]

CVE-2025-40289: drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

stable/6.1 was fixed.

Fixed status
stable/6.1: [2d8a7e0867c9acf7084b08e3f4382967203d4ef2]

CVE-2025-40311: accel/habanalabs: support mapping cb with
vmalloc-backed coherent memory

stable/6.1 was fixed.

Fixed status
stable/6.1: [8de421db5b1b2b37e9643ea7f6ade90fd756892d]

CVE-2025-40325: md/raid10: wait barrier before returning discard
request with REQ_NOWAIT

stable/6.1 was fixed.

Fixed status
stable/6.1: [9fd04328b37b6b911c2556f6dd2625a58c3c30db]

CVE-2025-40328: smb: client: fix potential UAF in smb2_close_cached_fid()

stable/6.1 was fixed.

Fixed status
stable/6.1: [bb3355ce9dcaba1b4a766f98b2ad373cab6cd626]

CVE-2025-40337: net: stmmac: Correctly handle Rx checksum offload errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c5e5fccc4138c072d99be4ebe6b16df6a70a40c]

CVE-2025-40338: ASoC: Intel: avs: Do not share the name pointer
between components

stable/6.1 was fixed.

Fixed status
stable/6.1: [0e1440e0d8b2394adfc3f1ac0710e6419600d5c1]

CVE-2025-68183: ima: don't clear IMA_DIGSIG flag when setting or
removing non-IMA xattr

stable/6.1 was fixed.

Fixed status
stable/6.1: [7d9ae9d4d45b28c18ca06ae047aabe09d9639643]

CVE-2025-68188: tcp: use dst_dev_rcu() in
tcp_fastopen_active_disable_ofo_check()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d3fe882ed33a1e45921764f4615bf82db79d8dcd]

CVE-2025-68209: mlx5: Fix default values in create CQ

stable/6.1 was fixed.

Fixed status
stable/6.1: [5c08079c3e5a3c1573afcb5643b5d296865d1170]

CVE-2025-68219: cifs: fix memory leak in smb3_fs_context_parse_param error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8071fd69df335362be5ecf5df5a167fd1eb5853]

CVE-2025-68236: scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS
power down (PC=3)

stable/6.1 was fixed.

Fixed status
stable/6.1: [dd52d72f2bd727ca60c1bc9820a307b70e2154ec]

CVE-2025-68320: lan966x: Fix sleeping in atomic context

stable/6.1 was fixed.

Fixed status
stable/6.1: [cabb8cbeab49f4b74d78a91a277e00d4f6dd5d7d]

CVE-2025-68321: page_pool: always add GFP_NOWARN for ATOMIC allocations

stable/5.10 was fixed.

Fixed status
stable/5.10: [3c4c2c96d00d112626736cc865b3c75aa8fb6de3]

CVE-2025-68324: scsi: imm: Fix use-after-free bug caused by unfinished
delayed work

stable/6.1 was fixed.

Fixed status
stable/6.1: [cfd561e8df5f46fc1c9d54885165a60e63831c14]

CVE-2025-68342: can: gs_usb: gs_usb_receive_bulk_callback(): check
actual_length before accessing data

stable/6.1 was fixed.

Fixed status
stable/6.1: [8376208db9283fbdfaa06c8d80735ac9954fa64a]

CVE-2025-68378: bpf: Fix stackmap overflow check in __bpf_get_stackid()

stable/6.1 was fixed.

Fixed status
stable/6.1: [03fe4c886667b3a09b9d6afc03bbc68afb35c82b]

CVE-2025-68379: RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [3733e80e32d1479a8b9bbffffac644068483c720]

CVE-2025-68745: scsi: qla2xxx: Clear cmds after chip reset

stable/6.1 was fixed.

Fixed status
stable/6.1: [e87e9f92d7735895b7dd97f53dce6d95d08cf29c]

CVE-2025-68755: staging: most: remove broken i2c driver

stable/6.1 was fixed.

Fixed status
stable/6.1: [f4cb61138482dd0b7ba551037b61f5e50a889604]

CVE-2025-68809: ksmbd: vfs: fix race on m_flags in vfs_cache

stable/6.1 was fixed.

Fixed status
stable/6.1: [a4fd1fdf505facfae26b5654c9eff321f4cbc1a7]

CVE-2025-68822: Input: alps - fix use-after-free bugs caused by
dev3_register_work

stable/6.1 was fixed.

Fixed status
stable/6.1: [55beb00222af2eee967322670a0c8f3c6426becb]

CVE-2025-71068: svcrdma: bound check rq_pages index in inline path

stable/6.1 was fixed.

Fixed status
stable/6.1: [a1ed26debcc74050d3000dff7c4ea5e77f830695]

CVE-2025-71073: Input: lkkbd - disable pending work before freeing device

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb76f871d6155c52ccc0401bbde77dd20b83d0c1]

CVE-2025-71074: functionfs: fix the open/removal races

stable/6.1 was fixed.

Fixed status
stable/6.1: [e002b3c1e6a0faa53329ef0d21e6351bcece6edb]

CVE-2025-71089: iommu: disable SVA when CONFIG_X86 is set

stable/5.10 was fixed.

Fixed status
stable/5.10: [845875f4c6788c88e2334fe5825934821decbdc8]

CVE-2025-71109: MIPS: ftrace: Fix memory corruption when kernel is
located beyond 32 bits

stable/6.1 was fixed.

Fixed status
stable/6.1: [3f7a003fe2646337fbc5dd41051ad6754ac34064]

CVE-2025-71138: drm/msm/dpu: Add missing NULL pointer check for
pingpong interface

stable/6.1 was fixed.

Fixed status
stable/6.1: [0d63df37b56a0aae2503147f234f5238304c62b5]

CVE-2025-71152: net: dsa: properly keep track of conduit reference

stable/6.1 was fixed.

Fixed status
stable/6.1: [bc3305eeeee5d8e43005ad46e252991e46d10f33]

CVE-2025-71184: btrfs: fix NULL dereference on root when tracing inode eviction

stable/6.1 was fixed.

Fixed status
stable/6.1: [99181ddb124cfe2b09f5e924c308222d2339e82a]

CVE-2025-71193: phy: qcom-qusb2: Fix NULL pointer dereference on early suspend

stable/6.1 was fixed.

Fixed status
stable/6.1: [f8a30ff99ae45d368737993961f7c334c76af5fa]

CVE-2025-71198: iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors
without event detection

stable/6.1 was fixed.

Fixed status
stable/6.1: [33c683417232b9111e29458954529942137780a3]

CVE-2025-71227: wifi: mac80211: don't WARN for connections on invalid channels

stable/6.1 was fixed.

Fixed status
stable/6.1: [6acc2d23f13d60874981b4828ba156ba01c86510]

CVE-2025-71273: wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()

stable/6.1 was fixed.

Fixed status
stable/6.1: [537723ada6d6655f0a2f48ab000fd9b0358bb442]

CVE-2025-71285: net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7874c74bcc224fd586679e51b9ded65f66edc2a]

CVE-2025-71289: fs/ntfs3: handle attr_set_size() errors when truncating files

stable/6.1 was fixed.

Fixed status
stable/6.1: [20bfb08c8355b8300d2bbcaa4bbc24122a4b2d99]

CVE-2025-71313: PCI: endpoint: Add missing NULL check for alloc_workqueue()

stable/6.1 was fixed.

Fixed status
stable/6.1: [62b9e706d226329d1374c0c1b80222e75ae9d8cd]

CVE-2026-100076: staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on
mgnt-frame error paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [973a629f19c226c8f6080badea7ccf59cc04233f]

CVE-2026-100077: drm/msm: Recover HW before retire hung submit

stable/6.1 was fixed.

Fixed status
stable/6.1: [9cf623ae29876788adfddd6ca01e2b8545594c14]

CVE-2026-13087: A heap out-of-bounds write vulnerability was found in
the Linux kernel's
RPC-over-RDMA server reply path in net/sunrpc/xprtrdma/svc_rdma_sendto.c.
When a crafted RPC-over-RDMA client sends a large NFS READ request with an
empty Write list and no Reply chunk, the server linearizes the entire
multi-page reply into a fixed-size 4096-byte heap buffer without bounds
checking, resulting in a kernel heap overflow. This can lead to denial of
service via kernel crash or potential code execution through corruption of
adjacent kernel heap objects.

stable/6.1 was fixed.

Fixed status
stable/6.1: [b73011049dbe909f73fd9620d94ef1757d7af2eb]

CVE-2026-23004: dst: fix races in rt6_uncached_list_del() and
rt_del_uncached_list()

stable/6.1 was fixed.

Fixed status
stable/6.1: [72f39a3cc78b2c6d780376adf68e3de5355e71f8]

CVE-2026-23050: pNFS: Fix a deadlock when returning a delegation during open()

stable/6.1 was fixed.

Fixed status
stable/6.1: [05a685b38dbca489d5f21eac9e7f20959344076a]

CVE-2026-23118: rxrpc: Fix data-race warning and potential load/store tearing

stable/6.1 was fixed.

Fixed status
stable/6.1: [49b8ef1abfe7713e15d9128006cb76e413b12b57]

CVE-2026-23137: of: unittest: Fix memory leak in unittest_data_add()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4bafaec9e3a784d103ab9da11095708fcca70e76]

CVE-2026-23138: tracing: Add recursion protection in kernel stack
trace recording

stable/6.1 was fixed.

Fixed status
stable/6.1: [80fe242a6239778025ba3be8e7263e3d69c37947]

CVE-2026-23171: bonding: fix use-after-free due to enslave fail after
slave array update

stable/6.1 was fixed.

Fixed status
stable/6.1: [c6ae2b978001065ca0e1d33d5cbf949efeff879e]

CVE-2026-23207: spi: tegra210-quad: Protect curr_xfer check in IRQ handler

stable/6.1 was fixed.

Fixed status
stable/6.1: [8261fa3da6e9001be95a54b857df9759e9098d2f]

CVE-2026-23208: ALSA: usb-audio: Prevent excessive number of frames

stable/6.1 was fixed.

Fixed status
stable/6.1: [581821f4b2ecbf411027b0af82b561ee208f4ba4]

CVE-2026-23213: drm/amd/pm: Disable MMIO access during SMU Mode 1 reset

stable/6.1 was fixed.

Fixed status
stable/6.1: [4027796f024dabb2766afde4f7e772c92bc4d056]

CVE-2026-23214: btrfs: reject new transactions if the fs is fully read-only

stable/6.1 was fixed.

Fixed status
stable/6.1: [5319d8598ea45ae144149593ae701d2ca3bd3294]

CVE-2026-23226: ksmbd: add chann_lock to protect ksmbd_chann_list xarray

stable/6.1 was fixed.

Fixed status
stable/6.1: [c00f3938f7ac52770907768e440cf253af9cbb63]

CVE-2026-23247: tcp: secure_seq: add back ports to TS offset

stable/6.1 was fixed.

Fixed status
stable/6.1: [025f532d8c5cfac77845e50daab7f478b360f2ac]

CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelems
before insertion

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [25841e8d4241c6c3763e70ae95050f8108707b46]
stable/5.15: [022effa9c54903858e443b1225370e6c758d03f6]

CVE-2026-23278: netfilter: nf_tables: always walk all pending catchall elements

stable/5.15 was fixed.

Fixed status
stable/5.15: [ae8f3cedc5f5653a5bed45c5ed016fe156e2af55]

CVE-2026-23327: cxl/mbox: validate payload size before accessing
contents in cxl_payload_from_user_allowed()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c0874ca9282ccf5aeae559c697dd1feb577aad0e]

CVE-2026-23330: nfc: nci: complete pending data exchange on device close

stable/6.1 was fixed.

Fixed status
stable/6.1: [75fdb22ef0635c02337de0c08c98f93f37b5cbee]

CVE-2026-23361: PCI: dwc: ep: Flush MSI-X write before unmapping its ATU entry

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d35fc94cd723ae27371a31f404685a24b097d71]

CVE-2026-23371: sched/deadline: Fix missing ENQUEUE_REPLENISH during
PI de-boosting

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0e20852d44261a9d69188bc483872930e7ba727]

CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible context

stable/6.1 was fixed.

Fixed status
stable/6.1: [37e86414cc9989344de82d2a658a095f8d5e71d9]

CVE-2026-23377: ice: change XDP RxQ frag_size from DMA write length to
xdp.frame_sz

stable/6.18 was fixed.

Fixed status
stable/6.18: [2a2927e95cf1b8efb15bcb741bbd06c9bb0537b7]

CVE-2026-23383: bpf, arm64: Force 8-byte alignment for JIT buffer to
prevent atomic tearing

stable/6.1 was fixed.

Fixed status
stable/6.1: [fcb9c6275f712860c22c96a472b73d05cabb75cd]

CVE-2026-23385: netfilter: nf_tables: clone set on flush only

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e63e1c2b171d30f5351b89b0a5d3926902f9ca6]

CVE-2026-23392: netfilter: nf_tables: release flowtable after rcu
grace period on error

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [29538fb3f412f3ce5ad9f97fe7fd84952dacd3af]
stable/5.15: [ec0f801e5ce0162fc4fea95607c716b264d283fb]

CVE-2026-23419: net/rds: Fix circular locking dependency in rds_tcp_tune

stable/6.1 was fixed.

Fixed status
stable/6.1: [ce5be6703afd2ac2ff7dabd397137d71d22d4bc3]

CVE-2026-23465: btrfs: log new dentries when logging parent dir of a
conflicting inode

stable/6.1 was fixed.

Fixed status
stable/6.1: [6c23595c54cfeb878e3fbbb8eb08bc5061d0c2d4]

CVE-2026-23472: serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN

stable/6.1 was fixed.

Fixed status
stable/6.1: [91c2a5d201daf66fa3f42b8a383bb89174bde2c8]

CVE-2026-31410: ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION

stable/6.1 was fixed.

Fixed status
stable/6.1: [5258e9187703bfd02faf19c37c23ab9d6587f24c]

CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadcast()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [060d83bb6147c36fc21134d5b332d266b8c176bc]
stable/5.15: [df690112b2172e8eb0f4dd8ec1019b65ee979203]

CVE-2026-31432: ksmbd: fix OOB write in QUERY_INFO for compound requests

stable/6.1 was fixed.

Fixed status
stable/6.1: [533f84264e28c54a79257ea87d2f94a0fcc9a611]

CVE-2026-31462: drm/amdgpu: prevent immediate PASID reuse case

stable/6.1 was fixed.

Fixed status
stable/6.1: [185a5e779c259869b8d5c20bd90e7a780c56576b]

CVE-2026-31486: hwmon: (pmbus/core) Protect regulator operations with mutex

stable/6.1 was fixed.

Fixed status
stable/6.1: [f0c9ea9c3a208e79c812e10e2bcef87b46564f01]

CVE-2026-31502: team: fix header_ops type confusion with non-Ethernet ports

stable/6.1 was fixed.

Fixed status
stable/6.1: [c6e255b0ce30cdea37e34d6d87e2212eb8c7f7a4]

CVE-2026-31505: iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

stable/6.1 was fixed.

Fixed status
stable/6.1: [20a31b84b3e3af21bbb2628fdad185b1f274a5f5]

CVE-2026-31531: ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5f479aac1262959e54cdd978d873be5f202e2a40]

CVE-2026-31557: nvmet: move async event work off nvmet-wq

stable/6.1 was fixed.

Fixed status
stable/6.1: [ede147a85d1d4c075d13ba190453d6b09ecbea37]

CVE-2026-31560: spi: spi-dw-dma: fix print error log when wait finish
transaction

stable/6.1 was fixed.

Fixed status
stable/6.1: [3709357c1a7b7a422b0cbc2748f187acf612cd94]

CVE-2026-31568: s390/mm: Add missing secure storage access fixups for
donated memory

stable/6.1 was fixed.

Fixed status
stable/6.1: [48eda93e50f8361dee8e261fe55d0b31714e1e56]

CVE-2026-31573: media: verisilicon: Fix kernel panic due to __initconst misuse

stable/6.1 was fixed.

Fixed status
stable/6.1: [53b88097bb0e0b895a691ae7da4a54b567c0d375]

CVE-2026-31592: KVM: SEV: Protect *all* of
sev_mem_enc_register_region() with kvm->lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [c506405f438b3e739fa43d509d367d1946ad9ffe]

CVE-2026-31606:  usb: gadget: f_hid: don't call cdev_init while cdev in use

stable/6.1 was fixed.

Fixed status
stable/6.1: [92f23ab86d9524bc51dae25ed916d0e69dce5992]

CVE-2026-31655: pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

stable/6.1 was fixed.

Fixed status
stable/6.1: [d215b525ace9af310b26a24232289770d5834dc3]

CVE-2026-31663: xfrm: hold dev ref until after transport_finish NF_HOOK

stable/6.1 was fixed.

Fixed status
stable/6.1: [4d06caedea587c59cc2cc893ceecc57c75c64312]

CVE-2026-31675: net/sched: sch_netem: fix out-of-bounds access in
packet corruption

stable/6.1 was fixed.

Fixed status
stable/6.1: [8d3de49c22ec0ec8f7199cc7e2b0559de7306f87]

CVE-2026-31677: crypto: af_alg - limit RX SG extraction by receive buffer budget

stable/6.1 was fixed.

Fixed status
stable/6.1: [960c56743988d8ce9ff9b5d770dbeb5f64823a23]

CVE-2026-31678: openvswitch: defer tunnel netdev_put to RCU release

stable/5.15 was fixed.

Fixed status
stable/5.15: [f0ec49d3a39c1f5a4f3270ea27ca0854fad2a2a2]

CVE-2026-31706: ksmbd: validate num_aces and harden ACE walk in
smb_inherit_dacl()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4d37830c2c834987de329d58fb9a319067400361]

CVE-2026-31707: ksmbd: validate response sizes in ipc_validate_msg()

stable/6.1 was fixed.

Fixed status
stable/6.1: [52518503a1a00bc33e9522c4eb05df023e3ae978]

CVE-2026-31722: usb: gadget: f_rndis: Fix net_device lifecycle with device_move

stable/6.1 was fixed.

Fixed status
stable/6.1: [f374388891778c2f58facc0f61f2610a206a1876]

CVE-2026-31723: usb: gadget: f_subset: Fix net_device lifecycle with device_move

stable/6.1 was fixed.

Fixed status
stable/6.1: [c26916e8413c8fc44834fd9df4899312fd6cf880]

CVE-2026-31724: usb: gadget: f_eem: Fix net_device lifecycle with device_move

stable/6.1 was fixed.

Fixed status
stable/6.1: [2479c26019a4009d84c7b98031a9fd7f9871a16b]

CVE-2026-31725: usb: gadget: f_ecm: Fix net_device lifecycle with device_move

stable/6.1 was fixed.

Fixed status
stable/6.1: [40c4d35c71a170889fe9333a1feb69a4dd5d4365]

CVE-2026-31767: drm/i915/dsi: Don't do DSC horizontal timing
adjustments in command mode

stable/6.1 was fixed.

Fixed status
stable/6.1: [80cc84bdc49addaee6b6e4f735f574ab5a424c42]

CVE-2026-31771: Bluetooth: hci_event: move wake reason storage into
validated event handlers

stable/6.1 was fixed.

Fixed status
stable/6.1: [fbea63d0d301edd4a42f4390b49b8519d78b802d]

CVE-2026-43009: bpf: Fix incorrect pruning due to atomic fetch
precision tracking

stable/6.1 was fixed.

Fixed status
stable/6.1: [06999c8a2c52b13977771ab093b8e179821b532d]

CVE-2026-43010: bpf: Reject sleepable kprobe_multi programs at attach time

stable/6.1 was fixed.

Fixed status
stable/6.1: [c2b5e13dee9cc83e664daf4c13077dcc618a44e9]

CVE-2026-43016: bpf: sockmap: Fix use-after-free of sk->sk_socket in
sk_psock_verdict_data_ready().

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac9f092e9994cada106432d5070e28ee9cb2fdac]

CVE-2026-43022: Bluetooth: hci_sync: hci_cmd_sync_queue_once() return
-EEXIST if exists

stable/6.1 was fixed.

Fixed status
stable/6.1: [da531f7108218ab6a779861e4646562fc769c9b3]

CVE-2026-43036: net: use skb_header_pointer() for TCPv4 GSO frag_off check

stable/6.1 was fixed.

Fixed status
stable/6.1: [362bacb37d88a178bfaefc4484623eae44425a70]

CVE-2026-43042: mpls: add seqcount to protect the platform_label{,s} pair

stable/6.1 was fixed.

Fixed status
stable/6.1: [6b9184ebc936f791631e51e783ab30320b3770e4]

CVE-2026-43048: HID: core: Mitigate potential OOB by removing bogus memset()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ad4316edbc63949094edeee538517dd689df7b24]

CVE-2026-43049: HID: logitech-hidpp: Prevent use-after-free on force
feedback initialisation failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [222bcf7b02899250b20a7a02d29b4e89fe537322]

CVE-2026-43083: net: ioam6: fix OOB and missing lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [d8fa972c543e6a41f9a0873a725fd1d8d4d9dbfc]

CVE-2026-43091: xfrm: Wait for RCU readers during policy netns exit

stable/6.1 was fixed.

Fixed status
stable/6.1: [b2faee12538b5b008eaef65a4201eb29cb5cefb3]

CVE-2026-43101: ipv6: ioam: fix potential NULL dereferences in
__ioam6_fill_trace_data()

stable/6.1 was fixed.

Fixed status
stable/6.1: [dd0d2827b3643ff307c766865f8e31eab5cbd1f5]

CVE-2026-43107: xfrm: account XFRMA_IF_ID in aevent size calculation

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7dbdc34d22f743abb2c460dfae0d69cd8a45e69]

CVE-2026-43118: btrfs: fix zero size inode with non-zero size after log replay

stable/6.1 was fixed.

Fixed status
stable/6.1: [126999610eddeb1de3b47680585f4bc9531dc7f4]

CVE-2026-43119: Bluetooth: hci_sync: annotate data-races around hdev->req_status

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff5855e8891e1e2490741366d087fd2fbcaabc4a]

CVE-2026-43125: dlm: validate length in dlm_search_rsb_tree

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0270664871616eb3a5c864b9aa17be76fd35b920]
stable/6.1: [c98d071a1ca903b705316225e47006aaa20e989c]

CVE-2026-43126: ALSA: mixer: oss: Add card disconnect checkpoints

stable/6.1 was fixed.

Fixed status
stable/6.1: [11ecfba92bdb420456a48da45a756b24d6356f72]

CVE-2026-43129: ima: verify the previous kernel's IMA buffer lies in
addressable RAM

stable/6.1 was fixed.

Fixed status
stable/6.1: [5bfa1941ec40d5bed68f3e3f22ea13aff9c6d67a]

CVE-2026-43153: xfs: remove xfs_attr_leaf_hasname

stable/6.1 was fixed.

Fixed status
stable/6.1: [dfb3474230d392f809359f15aeaa9be4b1798199]

CVE-2026-43167: xfrm: always flush state and policy upon NETDEV_UNREGISTER event

stable/6.1 was fixed.

Fixed status
stable/6.1: [d4df5a7da376e35089b8b601a86ff8a4cf997e2f]

CVE-2026-43170: usb: dwc3: gadget: Move vbus draw to workqueue context

stable/6.1 was fixed.

Fixed status
stable/6.1: [b214f0b11a0f1186f83c284f6a545110f76066b6]

CVE-2026-43185: ksmbd: fix signededness bug in smb_direct_prepare_negotiation()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1c268fd2f59dc9ccb2c2a7d1f439b232dbe1c06c]

CVE-2026-43204: ASoC: qcom: q6asm: drop DSP responses for closed data streams

stable/6.1 was fixed.

Fixed status
stable/6.1: [750b468d8e0ba0ba1774a0da55b950dc23ffda67]

CVE-2026-43213: wifi: rtw89: pci: validate sequence number of TX release report

stable/6.1 was fixed.

Fixed status
stable/6.1: [973392ea942a8a2981724c2c230972c8eb3cb703]

CVE-2026-43215: cifs: Fix locking usage for tcon fields

stable/6.1 was fixed.

Fixed status
stable/6.1: [92d197ef7e9bb4994dae2bb17c2f19fa09d219a2]

CVE-2026-43234: team: avoid NETDEV_CHANGEMTU event when unregistering slave

stable/6.1 was fixed.

Fixed status
stable/6.1: [9372774650ec960929cc2817bc5139a44a9a00db]

CVE-2026-43239: smb: client: prevent races in ->query_interfaces()

stable/6.1 was fixed.

Fixed status
stable/6.1: [de3c1653510d566a245cc54ac4bb9e50ebc5faa8]

CVE-2026-43244: kcm: fix zero-frag skb in frag_list on partial sendmsg error

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6dcbcc8d630d14e9651fe93a9386b35f4dcfd56]

CVE-2026-43248: vhost: move vdpa group bound check to vhost_vdpa

stable/6.1 was fixed.

Fixed status
stable/6.1: [69ec8dd6696069c2f18430d0e05f81d604484ee8]

CVE-2026-43249: 9p/xen: protect xen_9pfs_front_free against concurrent calls

stable/6.1 was fixed.

Fixed status
stable/6.1: [056709e2c6f121548df108a9fef2d1430b233e56]

CVE-2026-43250: usb: chipidea: udc: fix DMA and SG cleanup in _ep_nuke()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1497998749600411d75e60a44f7e572b2348bd9a]

CVE-2026-43253: iommu/amd: move wait_on_sem() out of spinlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [69d9339c02eddfc2a345be7220651068a3684383]

CVE-2026-43258: alpha: fix user-space corruption during memory compaction

stable/6.1 was fixed.

Fixed status
stable/6.1: [01cddfc34bf2a813a2773f1d607305515be55409]

CVE-2026-43271: md-cluster: fix NULL pointer dereference in
process_metadata_update

stable/6.1 was fixed.

Fixed status
stable/6.1: [b65ea893290056bee380d0c8eeb47797c2bcb311]

CVE-2026-43299: btrfs: do not ASSERT() when the fs flips RO inside
btrfs_repair_io_failure()

stable/6.1 was fixed.

Fixed status
stable/6.1: [053dd7f3c9647d3a781919c1b14105f46786d677]

CVE-2026-43308: btrfs: don't BUG() on unexpected delayed ref type in
run_one_delayed_ref()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c614b64bee2c3cbb0c80dd3a9ee492c74364e275]

CVE-2026-43310: media: verisilicon: Avoid G2 bus error while decoding
H.264 and HEVC

stable/6.1 was fixed.

Fixed status
stable/6.1: [42a9fbccb33a38c5a9e0a84680939da8eae4f60e]

CVE-2026-43338: btrfs: reserve enough transaction items for qgroup ioctls

stable/6.1 was fixed.

Fixed status
stable/6.1: [4ccd563214419cef14a54df9333ed655484e9dc8]

CVE-2026-43344: perf/x86/intel/uncore: Fix die ID init and look up bugs

stable/6.1 was fixed.

Fixed status
stable/6.1: [4eb511275e37c580156e787baab5232aeb0bfea0]

CVE-2026-43352: i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in
DMA dequeue

stable/6.1 was fixed.

Fixed status
stable/6.1: [377e75da122ffce7cec551f43fa884d57f2f8e63]

CVE-2026-43353: i3c: mipi-i3c-hci: Fix race in DMA ring dequeue

stable/6.1 was fixed.

Fixed status
stable/6.1: [d2fa9b855c7b42b34b2fb32731bf533952370384]

CVE-2026-43413: scsi: hisi_sas: Fix NULL pointer exception during user_scan()

stable/6.1 was fixed.

Fixed status
stable/6.1: [a0e952a99440258a6130ec4119ea4c62a8b4716b]

CVE-2026-43414: scsi: qla2xxx: Completely fix fcport double free

stable/6.1 was fixed.

Fixed status
stable/6.1: [bb9c7eca6f8f2e4a1cd8ba6711e7efe9044c0327]

CVE-2026-43419: ceph: fix memory leaks in ceph_mdsc_build_path()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d39366c169f873edc8ad21fdf6bf08d1de603dbb]

CVE-2026-43443: ASoC: amd: acp-mach-common: Add missing error check
for clock acquisition

stable/6.1 was fixed.

Fixed status
stable/6.1: [f9cdfe3f94e93b606ff5d6e8e6dc405e07acce84]

CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b1f22a658a7b20bcb7d34d40cb2ef3e52847e2fb]

CVE-2026-43490: ksmbd: validate inherited ACE SID length

stable/6.1 was fixed.

Fixed status
stable/6.1: [00f053d97b63591cafd791dce8d6c53e1625dad1]

CVE-2026-45855: ata: libata-scsi: avoid Non-NCQ command starvation

stable/6.1 was fixed.

Fixed status
stable/6.1: [c475bfce918dc413c4d59b97710b94b1c955ea5f]

CVE-2026-45859: netfilter: nfnetlink_queue: do shared-unconfirmed
check before segmentation

stable/6.1 was fixed.

Fixed status
stable/6.1: [4666688657e1054278b836b825fb88b2907e2da2]

CVE-2026-45877: HID: intel-ish-hid: fix NULL-ptr-deref in
ishtp_bus_remove_all_clients

stable/6.1 was fixed.

Fixed status
stable/6.1: [08baf418d79d289a7bc38be519289b3a48b83da9]

CVE-2026-45893: apparmor: Fix & Optimize table creation from possibly
unaligned memory

stable/6.1 was fixed.

Fixed status
stable/6.1: [83939c2afba70b49062c31ca6a6de7f46951d26d]

CVE-2026-45894: iommu/vt-d: Clear Present bit before tearing down PASID entry

stable/6.1 was fixed.

Fixed status
stable/6.1: [bed36f5657d34ae982d48045a75bff6113790cf9]

CVE-2026-45917: ipvs: do not keep dest_dst if dev is going down

stable/6.1 was fixed.

Fixed status
stable/6.1: [0b60fb44247eab81e7a9490c38ca62c7120eec75]

CVE-2026-45934: btrfs: fix EEXIST abort due to non-consecutive gaps in
chunk allocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [8f01e82c58f40739dfec32fc83dfd66711d473b9]

CVE-2026-45940: net: stmmac: fix oops when split header is enabled

stable/6.1 was fixed.

Fixed status
stable/6.1: [a7fe1d75e087862bc4087f3fcdfd5e291b9d9caa]

CVE-2026-45942: ext4: fix e4b bitmap inconsistency reports

stable/6.1 was fixed.

Fixed status
stable/6.1: [a3a7d360252c0d84ae8bda067fb296c9e82928d3]

CVE-2026-45943: erofs: fix inline data read failure for ztailpacking pclusters

stable/6.1 was fixed.

Fixed status
stable/6.1: [9ac759f2fb20b0cc3e367ce965b7279ea3919505]

CVE-2026-45944: iommu/vt-d: Clear Present bit before tearing down context entry

stable/6.1 was fixed.

Fixed status
stable/6.1: [61fa8546e39331103d6ce01575699c577d83e000]

CVE-2026-45949: hwrng: core - use RCU and work_struct to fix race condition

stable/6.1 was fixed.

Fixed status
stable/6.1: [d60bd663b746f17fc01fdc44dd01642594176344]

CVE-2026-45957: rcu: Fix rcu_read_unlock() deadloop due to softirq

stable/6.1 was fixed.

Fixed status
stable/6.1: [d36d8a7cf0e1d52ccde290855782b7b2ffc78f63]

CVE-2026-45961: gfs2: fix memory leaks in gfs2_fill_super error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [1fcca0f021ac8e2d19efddb6a733e8b6d4a3fb72]

CVE-2026-45985: ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting
before submitting I/O

stable/6.1 was fixed.

Fixed status
stable/6.1: [6d8fa684b42724d74a77f980f5ee47cfd1ec7e74]

CVE-2026-46000: rxrpc: Fix conn-level packet handling to unshare
RESPONSE packets

stable/6.1 was fixed.

Fixed status
stable/6.1: [ae19f6a54206534a85830dd92985f5f41441d241]

CVE-2026-46012: rxrpc: Fix memory leaks in rxkad_verify_response()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c14433e967cff95bebc77c9c4a2a0ed4e0e22783]

CVE-2026-46032: KVM: nSVM: Triple fault if restore host CR3 fails on
nested #VMEXIT

stable/6.1 was fixed.

Fixed status
stable/6.1: [e6318570a9b4e137b0b744832b920b38bb069561]

CVE-2026-46059: KVM: nSVM: Always use NextRIP as vmcb02's NextRIP
after first L2 VMRUN

stable/6.1 was fixed.

Fixed status
stable/6.1: [98717fb482fa269db491f7c84aec777d3aeb2cd1]

CVE-2026-46071: KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7fefb393a926bdfe445c63b4091185ed7da2733]

CVE-2026-46148: spi: microchip-core-qspi: control built-in cs manually

stable/6.1 was fixed.

Fixed status
stable/6.1: [06b14dd2393933e8cd574157369e551bd615b52a]

CVE-2026-46157: ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger

stable/6.1 was fixed.

Fixed status
stable/6.1: [e718cecb73214f53fe8f48083eb7afe9b0921103]

CVE-2026-46165: openvswitch: vport: fix self-deadlock on release of tunnel ports

stable/5.15 was fixed.

Fixed status
stable/5.15: [3600033f31b1afa16d73a24905eec9ee1d222b97]

CVE-2026-46175: f2fs: fix fsck inconsistency caused by FGGC of node block

stable/6.1 was fixed.

Fixed status
stable/6.1: [3b7a0bbb3444addddb139f42a74ab4492052fa27]

CVE-2026-46181: RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()

stable/6.1 was fixed.

Fixed status
stable/6.1: [654aeddbc6e0f6e56531985bb12328ab4230c6c1]

CVE-2026-46200: spi: mpc52xx: fix controller deregistration

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff2979c57b70be6d8b64e40d7b4217341a877fcd]

CVE-2026-46204: drm/amdgpu/vcn4: Prevent OOB reads when parsing IB

stable/6.1 was fixed.

Fixed status
stable/6.1: [92724364702fd12d99f441a4af11d9c8bcd52217]

CVE-2026-46225: spi: rspi: fix controller deregistration

stable/6.1 was fixed.

Fixed status
stable/6.1: [434804ab2089f1671a718b2af9f94a3b8f9f9b49]

CVE-2026-46226: spi: fsl: fix controller deregistration

stable/6.1 was fixed.

Fixed status
stable/6.1: [af8ba212fdc985b7853e8aff3fd2ca65f94aafc9]

CVE-2026-46229: drm/amdkfd: Clear VRAM on allocation to prevent stale
data exposure

stable/6.1 was fixed.

Fixed status
stable/6.1: [6bcf59545c84a5105d14d59f40069ef4c033584e]

CVE-2026-46241: spi: mpc52xx: fix use-after-free on registration failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [b25eb3d24d03e571f09c04a0522c798ea35e48a1]

CVE-2026-46254: AppArmor: Allow apparmor to handle unaligned dfa tables

stable/6.1 was fixed.

Fixed status
stable/6.1: [60d175ecba4d067bd3379617eb09a905de476fcc]

CVE-2026-46265: RDMA/hns: Fix WQ_MEM_RECLAIM warning

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [31b22ca4f5ab8c495fd8bb44c06573f1fb7833a2]
stable/5.15: [5fb5028a7a80c2f8fd1e06cea7c4a0af1a58f9ef]

CVE-2026-46302: selinux: allow multiple opens of /sys/fs/selinux/policy

stable/6.1 was fixed.

Fixed status
stable/6.1: [9795810d116bc9071485929ba6471dc8d5bd158b]

CVE-2026-46312: media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [feb34085774d7b6d09265883782160100c5aac28]

CVE-2026-46324: netfilter: nf_tables: use list_del_rcu for netlink hooks

stable/6.1 was fixed.

Fixed status
stable/6.1: [6480ea533cedfbf79ea5a1f12c5f71d41484dd8a]

CVE-2026-46330: Revert "net/smc: Introduce TCP ULP support"

stable/6.1 was fixed.

Fixed status
stable/6.1: [c7cb174a1edc80fe1f75b169a57726ed46704074]

CVE-2026-52936: crypto: jitterentropy - replace long-held spinlock with mutex

stable/6.1 was fixed.

Fixed status
stable/6.1: [21de77d06f6b540e870e64ef5ff56be4eb8ba08f]

CVE-2026-52937: tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

stable/6.1 was fixed.

Fixed status
stable/6.1: [4b6dcfe0e3dfffd8057a4fc99b3f096c45709905]

CVE-2026-52956: libceph: Fix potential out-of-bounds access in
__ceph_x_decrypt()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c417b7d2d1c7fdc25af24490201320e36a3cc21d]

CVE-2026-52961: ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to
stale blob size

stable/6.1 was fixed.

Fixed status
stable/6.1: [0fe79375e48efee268e766c800bacbd58bed655b]

CVE-2026-52990: fsnotify: fix inode reference leak in fsnotify_recalc_mask()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ba4d88bfd58739698a9bd2309659c9cc26acf7f7]

CVE-2026-52991: sched/psi: fix race between file release and pressure write

stable/6.1 was fixed.

Fixed status
stable/6.1: [58e6ca11e45c9d6e52255d1135e7dbff0a360334]

CVE-2026-53000: netfilter: nat: use kfree_rcu to release ops

stable/6.1 was fixed.

Fixed status
stable/6.1: [bf17f1d3b307196d9282c4b1dd8be0d0e5f8e529]

CVE-2026-53009: ice: fix double-free of tx_buf skb

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa30e355ee951e804cbc9ff3d5de429ec850eccb]

CVE-2026-53015: erofs: unify lcn as u64 for 32-bit platforms

stable/6.1 was fixed.

Fixed status
stable/6.1: [d142250132454bf86cba87018fb2d29c482dacd6]

CVE-2026-53017: f2fs: fix data loss caused by incorrect use of nat_entry flag

stable/6.1 was fixed.

Fixed status
stable/6.1: [eb65e8c7bd0a78a470cbdd3ff96232ba4a2ace89]

CVE-2026-53018: f2fs: avoid reading already updated pages during GC

stable/6.1 was fixed.

Fixed status
stable/6.1: [ecf53b5c9ccba6e6a7db111722cc8bbfc92d4558]

CVE-2026-53024: greybus: raw: fix use-after-free if write is called
after disconnect

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a6ce05ccd9eca653b09d67eb59026821ffaf61b]

CVE-2026-53025: greybus: raw: fix use-after-free on cdev close

stable/6.1 was fixed.

Fixed status
stable/6.1: [0597908256173da5256ef8e6db17ccc8d5c40ee3]

CVE-2026-53027: fs/ntfs3: fix missing run load for vcn0 in
attr_data_get_block_locked()

stable/6.1 was fixed.

Fixed status
stable/6.1: [543093f65318d012850e548b241f85381b14d643]

CVE-2026-53053: iommu/amd: Fix clone_alias() to use the original device's devid

stable/6.1 was fixed.

Fixed status
stable/6.1: [880a2e6c887c8f51870c0a00dfba3c8519178b65]

CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2933f5b3a31b175628985b92895269b778674a1]

CVE-2026-53076: bpf: Fix OOB in pcpu_init_value

stable/6.1 was fixed.

Fixed status
stable/6.1: [d138ea2fe01c254413d5a6104eb236e0d5c7dd9a]

CVE-2026-53083: bpf: Fix RCU stall in bpf_fd_array_map_clear()

stable/6.1 was fixed.

Fixed status
stable/6.1: [419878a48085e6d5c2fcc4912eeaac2f8abf36ed]

CVE-2026-53102: wifi: mt76: Fix memory leak after
mt76_connac_mcu_alloc_sta_req()

stable/6.1 was fixed.

Fixed status
stable/6.1: [25af8229133c8dc69b12721ad84165cced83caed]

CVE-2026-53108: powerpc/64s: Fix unmap race with PMD migration entries

stable/6.1 was fixed.

Fixed status
stable/6.1: [3d4999bfbcbc5b801bfcf482c567380dd26ad268]

CVE-2026-53122: btrfs: fix deadlock between reflink and transaction
commit when using flushoncommit

stable/6.1 was fixed.

Fixed status
stable/6.1: [5446d3e7676d73737f8dca816a956ede8ac24921]

CVE-2026-53129: fs/mbcache: cancel shrink work before destroying the cache

stable/6.1 was fixed.

Fixed status
stable/6.1: [40148c615687c1692712e50a6de53d62dfbfc20f]

CVE-2026-53220: netfilter: revalidate bridge ports

stable/6.1 was fixed.

Fixed status
stable/6.1: [a1c12915d2502aff00df82f4ccb8c214f956129d]

CVE-2026-53224: sctp: validate embedded INIT chunk and address list
lengths in cookie

stable/6.1 was fixed.

Fixed status
stable/6.1: [b1ca7dcfb335caa2c73d2d1bb5710e6dea2c11e0]

CVE-2026-53229: net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX
xmit failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [bf0247d34d79d2740b3f1d6cc44dbd38ab2b169e]

CVE-2026-53230: net/mlx5: Fix slab-out-of-bounds in
mlx5_query_nic_vport_mac_list

stable/6.1 was fixed.

Fixed status
stable/6.1: [87149f3e53f3839454b837f87a2ec7c926775a6a]

CVE-2026-53232: net: phy: clean the sfp upstream if phy probing fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [18c7c311323b19a353c3042180982e0ce5fa7e5f]

CVE-2026-53237: gpio: mvebu: fix NULL pointer dereference in suspend/resume

stable/6.1 was fixed.

Fixed status
stable/6.1: [3cb53f89049c3769e102ac5b7692e679a1d45510]

CVE-2026-53258: wifi: fix leak if split 6 GHz scanning fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [c3d30daf03130cf35c0e70185719ce16fc3ea6c4]

CVE-2026-53262: l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

stable/6.1 was fixed.

Fixed status
stable/6.1: [cc19c164a99ab706d4cb45d3c300b305c16798b5]

CVE-2026-53267: netfilter: nft_ct: bail out on template ct in get eval

stable/6.1 was fixed.

Fixed status
stable/6.1: [15bf8091f424f97ed8bfd2385f9fca3203f27be2]

CVE-2026-53272: erofs: fix use-after-free on sbi->sync_decompress

stable/6.1 was fixed.

Fixed status
stable/6.1: [5627e57f1da68ff0146896eb3d2eed25e62adc44]

CVE-2026-53284: btrfs: only release the dirty pages io tree after
successful writes

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff49321d29770e2d41bec65b43099997af5d2eaa]

CVE-2026-53292: net: phonet: do not BUG_ON() in pn_socket_autobind()
on failed bind

stable/6.1 was fixed.

Fixed status
stable/6.1: [6972021488e3142f30a89d8035eebeefbbe65656]

CVE-2026-53297: net: mana: Guard mana_remove against double invocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [f63a6d2e4167703611f5c2602eaa1a23f635430f]

CVE-2026-53313: drm/amd/display: Avoid NULL dereference in dc_dmub_srv
error paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [2afedb8b9262df2a09e62ee7c22530a8c9df5934]

CVE-2026-53317: wifi: mt76: mt7921: Place upper limit on station AID

stable/6.1 was fixed.

Fixed status
stable/6.1: [8f2ce0910b25173049910ec9a49304150534afd4]

CVE-2026-53330: drm/amd/display: Fix out-of-bounds read in
dp_get_eq_aux_rd_interval()

stable/6.1 was fixed.

Fixed status
stable/6.1: [7b310c6d82d782282085c9728dfe69e07d185b6c]

CVE-2026-53345: KVM: Don't WARN if memory is dirtied without a vCPU
when the VM is dying

stable/6.1 was fixed.

Fixed status
stable/6.1: [21b880f040bd0e8b50ff30c5a40db7bf3384ff48]

CVE-2026-53353: hsr: Remove WARN_ONCE() in hsr_addr_is_self().

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ff88df6d6a72458e1c4ca0e0342327cafd8317f4]
stable/5.15: [4d256cddc47c0c34ffcf7e5205ee4c38863bf457]
stable/6.1: [7610e3298aeb2439caa735131265fb634e0db4ec]

CVE-2026-53368: f2fs: fix fsck inconsistency caused by incorrect
nat_entry flag usage

stable/6.1 was fixed.

Fixed status
stable/6.1: [bb1275802b482bc5854e434e212589fe253eab22]

CVE-2026-53376: drm/amdkfd: Add upper bound check for num_of_nodes

stable/6.1 was fixed.

Fixed status
stable/6.1: [f0f19e614cdd7d9cff2fb280cf923c99256d7915]

CVE-2026-53377: drm/msm: always recover the gpu

stable/6.1 was fixed.

Fixed status
stable/6.1: [f8410426e46a8449a3734b037286cbafe0110033]

CVE-2026-53401: fbdev: omap2: fix use-after-free in omapfb_mmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [a1a00f664a409b3412f9e1408c12890cffe50362]

CVE-2026-63825: gcov: use atomic counter updates to fix concurrent
access crashes

stable/6.1 was fixed.

Fixed status
stable/6.1: [76cb9fde95eba4bd8f06d142a8b8810bf2d09de4]

CVE-2026-63826: fbdev: fix use-after-free in store_modes()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3047319e44f1368370f6fa2c04dea2961fb10215]

CVE-2026-63845: drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [8350819f3e09d494c8178faabe1fc2b18e095a27]

CVE-2026-63846: drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [34d72bb699305992d3190220e331a95bfd3e9f7f]

CVE-2026-63847: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [c9e367e6e630e1655184ca886a9290bfe8cb30a9]

CVE-2026-63848: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [08a5f07da71006f4309724715f99c6920c762034]

CVE-2026-63853: drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [772f83fc70b797ac88d696671780eaf175cc7f31]

CVE-2026-63854: drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings

stable/6.1 was fixed.

Fixed status
stable/6.1: [e3d339b0d9051d49eb9c78459091bba4fb525100]

CVE-2026-63855: drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings

stable/6.1 was fixed.

Fixed status
stable/6.1: [8156e258025f2a22fcf7486c96848ac3cd3541dd]

CVE-2026-63856: drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings

stable/6.1 was fixed.

Fixed status
stable/6.1: [bcb972496f189edbf56a18b14f9b4831fd127ab8]

CVE-2026-63871: Bluetooth: ISO: Fix data-race on iso_pi fields in
hci_get_route calls

stable/6.1 was fixed.

Fixed status
stable/6.1: [122b6a8b0c75b5f808aa6ea68e97103330b9ffa7]

CVE-2026-63940: KVM: SEV: Ignore Port I/O requests of length '0'

stable/6.1 was fixed.

Fixed status
stable/6.1: [c8aa0a79ab0b23cde4c46ccff78e63be35733e04]

CVE-2026-63959: usb: typec: tcpm/tcpci_maxim: validate header NDO
against RX_BYTE_CNT

stable/6.1 was fixed.

Fixed status
stable/6.1: [8a8cd4790b08c9f79ea2250b3bd933fd79f67e56]

CVE-2026-63962: usb: typec: tcpm: bound altmode_desc[] per iteration
in svdm_consume_modes()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f6694bac643c7ae25c0634b63e67d573ed31e5b7]

CVE-2026-63963: usb: typec: tcpm: validate VDO count in Discover
Identity ACK handlers

stable/6.1 was fixed.

Fixed status
stable/6.1: [150c30131c032b4b1ad9acd29f2834321d85ae4b]

CVE-2026-63974: Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE
during device close

stable/6.1 was fixed.

Fixed status
stable/6.1: [ccf07dfb9d7d1e2c7a1eeb782f90d9b614ebba9c]

CVE-2026-64006: netfilter: nf_tables: fix dst corruption in same
register operation

stable/6.1 was fixed.

Fixed status
stable/6.1: [95bf63844045e7948fd1aeb5e71b942e86ca0414]

CVE-2026-64015: security/keys: fix missed RCU read section on lookup

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1d8d987a2aacde238ecd0f4946f28cef74c42b79]
stable/5.15: [5036a9aa7f21fbce89a2a8451bbc177bae2e920d]

CVE-2026-64017: blk-mq: pop cached request if it is usable

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a3fefe65b94b095c9b66420ee0ecabd9fc2e1568]
stable/6.6: [f122d9968d730c2e71d5e59d0d8b7d67acb5b3bb]

CVE-2026-64025: bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

stable/6.1 was fixed.

Fixed status
stable/6.1: [d698bdba0f9969a6e390d1b1a9a3e283f1f174a7]

CVE-2026-64036: cgroup/rstat: validate cpu before css_rstat_cpu() access

stable/6.1 was fixed.

Fixed status
stable/6.1: [ee5afb74688aa6f1f16d8c7e7b6bfaf803fb62fc]

CVE-2026-64038: hwmon: (lm90) Stop work before releasing hwmon device

stable/6.1 was fixed.

Fixed status
stable/6.1: [1decb2c1762f77910de787fbf9b3afb40cc1d646]

CVE-2026-64076: netfilter: bridge: eb_tables: close module init race

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0e7dec9dfc02987598e6a42bdfcab51dcc43e10]

CVE-2026-64077: netfilter: ebtables: move to two-stage removal scheme

stable/6.1 was fixed.

Fixed status
stable/6.1: [b37e27f5d5cbb7723644fdf089e28a216d6093ed]

CVE-2026-64136: smb: client: protect tc_count increment in
smb2_find_smb_sess_tcon_unlocked()

stable/6.1 was fixed.

Fixed status
stable/6.1: [7585d4242f59185b084957fa077396e53dbf7c24]

CVE-2026-64138: ksmbd: validate SID in parent security descriptor
during ACL inheritance

stable/6.1 was fixed.

Fixed status
stable/6.1: [f7c4dee323d9176b8d3f5c69018ee57ae0d4653c]

CVE-2026-64144: Bluetooth: btmtk: fix urb->setup_packet leak in error paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [ecd8d2531766641958a667829907204066cfb51a]

CVE-2026-64146: erofs: fix metabuf leak in inode xattr initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [89682dd09efb3825b0f162a72e342c52b69ea14a]

CVE-2026-64163: test_kprobes: clear kprobes between test runs

stable/6.1 was fixed.

Fixed status
stable/6.1: [29ec976006dfab171a7e007976e38af56ce286e4]

CVE-2026-64190: net: team: fix NULL pointer dereference in team_xmit
during mode change

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d61bf3bc17de1e18cbdac94cf5389bb9dc2ddfe7]
stable/5.15: [ac342f86638f5e184c8511cff12a421aea56acc6]
stable/6.1: [a879f78c478cee77f4bd43e92225a640c23f45d4]

CVE-2026-64213: hwmon: (lm90) Add lock protection to lm90_alert

stable/6.1 was fixed.

Fixed status
stable/6.1: [1dc6a3469b5427e3bfd19010d7755ebc6019abc1]

CVE-2026-64305: crypto: qat - protect service table iterations with service_lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [d36bff434e01d06d1e1fa98aa2b34ec32185c1ab]

CVE-2026-64319: nvmet-auth: validate reply message payload bounds
against transfer length

stable/6.1 was fixed.

Fixed status
stable/6.1: [04fb6ff8b87a0ffff3860ff52bdb2fd04b31ece5]

CVE-2026-64320: nvmet: fix pre-auth out-of-bounds heap read in
Discovery Get Log Page

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff815b5e8688dcf68529b7f0fde8de5847f63f1e]

CVE-2026-64341: USB: iowarrior: fix use-after-free on disconnect race

stable/6.1 was fixed.

Fixed status
stable/6.1: [9472acd56a020c93be4189d2dba9c743b9fc8039]

CVE-2026-64345: usb: gadget: f_printer: take kref only for successful open

stable/6.1 was fixed.

Fixed status
stable/6.1: [a12d81a9cc2a012a24ecb7f9ba076b9f7c179bd3]

CVE-2026-64348: usb: free iso schedules on failed submit

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab12316c4639237cc9d50c80a0c6240f11fbba3f]

CVE-2026-64388: smb/client: fix chown/chgrp with SMB3 POSIX Extensions

stable/6.1 was fixed.

Fixed status
stable/6.1: [c0fe1118a1471d459f76c3e70ff2abbf784ce6bf]

CVE-2026-64389: ksmbd: validate NTLMv2 response before updating session key

stable/6.1 was fixed.

Fixed status
stable/6.1: [e589e997bddde0a6f45672dd871cba7b3ff28e17]

CVE-2026-64391: ksmbd: use opener credentials for ADS I/O

stable/6.1 was fixed.

Fixed status
stable/6.1: [222c4c52c3af2d0f68de31182710df3508a31095]

CVE-2026-64392: ksmbd: use opener credentials for delete-on-close

stable/6.1 was fixed.

Fixed status
stable/6.1: [3cb2e6e2a6798909507b9d695e4b80e685e72d26]

CVE-2026-64400: ksmbd: prevent path traversal bypass by restricting
caseless retry

stable/6.1 was fixed.

Fixed status
stable/6.1: [21f050439db157f2afcc19885dec14549ca6ffc0]

CVE-2026-64424: netpoll: fix a use-after-free on shutdown path

stable/6.1 was fixed.

Fixed status
stable/6.1: [b67625b85c4b1a3725f4be9c6dd8ce3399d11732]

CVE-2026-64444: staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop

stable/5.10 was fixed.

Fixed status
stable/5.10: [3ae0577d3be9f1e2707cce4749da250054e25e3f]

CVE-2026-64463: usb: typec: tcpci_rt1711h: unregister TCPCI port with devres

stable/6.1 was fixed.

Fixed status
stable/6.1: [388f5354158fc038214b73baad43a723385fea1e]

CVE-2026-64481: ALSA: hda/cs35l41: Fix firmware load work teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [b3647e5b7b817272fdef057948c37fcb0704edc7]

CVE-2026-64556: perf/core: Detach event groups during remove_on_exec

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d3e1102273f09180262496658e7eeed8a5a7b59]

CVE-2026-68081: KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state

stable/6.1 was fixed.

Fixed status
stable/6.1: [c174eb76484786721ae9a104344b952acf0e2717]

CVE-2026-68083: ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

stable/6.1 was fixed.

Fixed status
stable/6.1: [f1f53dc95edfb3d2072e5e8cd8eb9a2fe7d7f2d0]

CVE-2026-68098: ksmbd: bound DACL dedup walk to copied ACEs

stable/6.1 was fixed.

Fixed status
stable/6.1: [05aa552bd69a96e090cbd45656e18cdc46524e20]

CVE-2026-68102: drm/amdgpu: fix aperture mapping leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [8cf4724ea4f23c438af87a6cd0582a3372d30da9]

CVE-2026-68118: tcp: challenge ACK for non-exact RST in SYN-RECEIVED

stable/6.1 was fixed.

Fixed status
stable/6.1: [c5dc463cc60eb26079b19607c9dbda76491dad05]

CVE-2026-68185: LoongArch: Move jump_label_init() before parse_early_param()

stable/6.1 was fixed.

Fixed status
stable/6.1: [02f993165fdbba98dd6a9ec230a3deda891bb9f2]

CVE-2026-68203: media: vivid: fix cleanup bugs in vivid_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [6c7307c1b45da4fef6b445ca5c113457d86a7806]

CVE-2026-68233: drm/vc4: Shut down BO cache timer before teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [948cd4876dafbfab826384516df19fe813d9f1d1]

CVE-2026-68238: drm/amdgpu: Release VFCT ACPI table reference

stable/6.1 was fixed.

Fixed status
stable/6.1: [1c19e02a689661a9687d689dcc5995d3be538262]

CVE-2026-68241: drm/i915/mst: limit DP MST ESI service loop

stable/6.1 was fixed.

Fixed status
stable/6.1: [76a1817d31f1a01fc5d9de63cb219e2c10d40400]

CVE-2026-68242: drm/i915/gt: Fix NULL deref on sched_engine alloc failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [9ea0aaf8bf9fda6e101f2304391f066d99d0d054]

CVE-2026-68247: drm/i915/bios: range check LFP Data Block panel_type2

stable/6.1 was fixed.

Fixed status
stable/6.1: [a06256ac0c3b40abf83ac257ada3c4368bd136a2]

CVE-2026-68258: drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

stable/6.1 was fixed.

Fixed status
stable/6.1: [dcd8f5e049ff31e73f91fbccd9a9b9d725a2ff3e]

CVE-2026-68273: drm/amdgpu: Fix context pstate override handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [ebed6179c993f07da24d0a454816e7da790377af]

CVE-2026-68290: rds: tcp: unregister sysctl before tearing down listen socket

stable/6.1 was fixed.

Fixed status
stable/6.1: [66fd678eef1bc2862bde5e7a0f6106256de74f30]

CVE-2026-68293: net/mlx5: Fix MCIA register buffer overflow on 32 dword reads

stable/6.1 was fixed.

Fixed status
stable/6.1: [5ed6d41029832b11bc204d7cc326cf309d073666]

CVE-2026-68303: drm/vc4: hvs/v3d: Fix null dereference in unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [3ed3d0b31500b11c8fd9ef96b7703edbccb32e2e]

CVE-2026-68312: cifs: fix cifsFileInfo leak on kmalloc failure in
deferred close drain paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [75143abc21f627da7ee3b0336814bd702692e830]

CVE-2026-68323: tipc: serialize udp bearer replicast list updates

stable/6.1 was fixed.

Fixed status
stable/6.1: [c148aec60ef1e806cbc9da44b3d89409df998ade]

CVE-2026-68329: iommu/amd: Wait for completion instead of returning
early in iommu_completion_wait()

stable/6.1 was fixed.

Fixed status
stable/6.1: [82c9a749d44efaaa1a1c781f8a6cf1747718f228]

CVE-2026-68381: ksmbd: pin conn during async oplock break notification

stable/6.1 was fixed.

Fixed status
stable/6.1: [dab1493bc9d97947f1219d6823c2e2a28636021b]

CVE-2026-68396: scsi: core: wake eh reliably when using scsi_schedule_eh

stable/6.1 was fixed.

Fixed status
stable/6.1: [d1280822db11c423ad47b43c9d69a5e56199161e]

CVE-2026-68399: bpf: Fix UAF in sock clone early bailouts

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac855efc6bb216b262b672af68219e5b731f42a4]

CVE-2026-68401: firmware: arm_ffa: Fix out-of-bound writes in
ffa_setup_and_transmit()

stable/6.1 was fixed.

Fixed status
stable/6.1: [500f92f398c717aa515afd23c7a38c0e7f4a1dc9]

CVE-2026-68404: wifi: cfg80211: use wiphy work for socket owner autodisconnect

stable/6.1 was fixed.

Fixed status
stable/6.1: [23517673b1eecaec95e61dde285220d5a980cf3f]

CVE-2026-68408: wifi: cfg80211: convert pmsr_free_wk to wiphy_work to
fix deadlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [efe47df4de5e3e19b0670c5f2f67bdc4c9dc02af]

CVE-2026-68409: wifi: mac80211: defer link RX stats percpu free to RCU

stable/6.1 was fixed.

Fixed status
stable/6.1: [acd5931d5adf12f0163f83dc00320e7011f4da92]

CVE-2026-68416: mtd: fix double free and WARN_ON in add_mtd_device() error paths

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b1f78dc4a6869e30ff64345a5d3e7da1b6da0061]
stable/6.1: [1dfe90daee6080b088b65620ff690a56f59ddea2]

CVE-2026-68418: RDMA/irdma: Prevent user-triggered null deref on QP create

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e75028c000e9560a7ff66a23d7cd872a967ab7e]

CVE-2026-68426: xfrm: fix stale skb->prev after async crypto steals a
GSO segment

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e695742396be18d5291c310a3d7c450959d647a]

CVE-2026-68435: LoongArch: Fix address space mismatch in kexec command
line lookup

stable/6.1 was fixed.

Fixed status
stable/6.1: [742f2c0a64a7557495e831c3c112d92e308bd4ae]

CVE-2026-68441: net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

stable/6.1 was fixed.

Fixed status
stable/6.1: [06629ed4d0ecba55bc425eaea79974484fe0b414]

CVE-2026-68445: drm/vc4: Prevent shader BO mappings from becoming writable

stable/6.1 was fixed.

Fixed status
stable/6.1: [4c98260a967e8536c69437b8da8eea3188cd6db8]

CVE-2026-68448: ovl: check access to copy_file_range source with src
mounter creds

stable/6.1 was fixed.

Fixed status
stable/6.1: [214c292d135ac11d32c766c6c4276092b80b2fbd]

CVE-2026-68449: ata: sata_dwc_460ex: fix infinite loop in NCQ tag
completion bit-scanning

stable/6.1 was fixed.

Fixed status
stable/6.1: [90e8cf489b593814b9398aa187ddbb790e33ec6f]

CVE-2026-68453: s390/zcrypt: Fix buffer over-read in cca_cipher2protkey

stable/6.1 was fixed.

Fixed status
stable/6.1: [1adfec7be6f34c1073c9cf15040bc4e3fdc6dc51]

CVE-2026-68471: wifi: ieee80211: validate MLE common info length

stable/6.1 was fixed.

Fixed status
stable/6.1: [bba41664af19b8a07d3d728855088ae80e47a4b3]

CVE-2026-72007: pmdomain: imx: Fix i.MX8MP VC8000E power up sequence

stable/6.1 was fixed.

Fixed status
stable/6.1: [9601551ceb039ab1c01cfa3aee153928a6d4f3c5]

CVE-2026-72009: pmdomain: imx93-blk-ctrl: Extract PHY as shared domain
for DSI/CSI

stable/6.1 was fixed.

Fixed status
stable/6.1: [73c0d6957811d7c138124107e1d31e8fb0133156]

CVE-2026-72028: riscv: probes: save original sp in rethook trampoline

stable/6.1 was fixed.

Fixed status
stable/6.1: [d21109fe4a55247094f913773a334772907cd016]

CVE-2026-72098: dm-verity: fix buffer overflow in FEC calculation

stable/6.1 was fixed.

Fixed status
stable/6.1: [84d4d2a6988c9a733f7821452cefb5b0d93de2d1]

CVE-2026-72106: dm-ioctl: fix a possible overflow in list_version_get_info

stable/6.1 was fixed.

Fixed status
stable/6.1: [3cba74d3fb2c1890ffae019301227d1366f74907]

CVE-2026-72130: nvmet-auth: reject short AUTH_RECEIVE buffers

stable/6.1 was fixed.

Fixed status
stable/6.1: [ecdb6332fe59ddf18aad758a4926e3d483f4860a]

CVE-2026-72144: platform/x86: dell-laptop: fix missing cleanups in
init error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0a2f1ff408beb3aa5832098e8805db4d31dba7e]

CVE-2026-72147: dmaengine: dw-edma-pcie: Reject devices without driver data

stable/6.1 was fixed.

Fixed status
stable/6.1: [69bf416b31e2dc44aa8a10e7a215ad388994c7c6]

CVE-2026-72162: ocfs2: fix UBSAN array-index-out-of-bounds in
ocfs2_sum_rightmost_rec

stable/6.1 was fixed.

Fixed status
stable/6.1: [c88226315aec298894ec57e532f5e95f3b09e874]

CVE-2026-72198: ntfs: reject non-resident records for resident-only attributes

stable/6.1 was fixed.

Fixed status
stable/6.1: [b06b4fc2138ded8ee0b3dc602991ff6dbb10dd0a]

CVE-2026-72200: ntfs: detect mapping-pairs LCN accumulator overflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [b06b4fc2138ded8ee0b3dc602991ff6dbb10dd0a]

CVE-2026-72203: ntfs: skip extent mft records in writeback to prevent deadlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [b06b4fc2138ded8ee0b3dc602991ff6dbb10dd0a]

CVE-2026-72213: mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch

stable/6.1 was fixed.

Fixed status
stable/6.1: [f8dfdf725bccb0ae41eead2f6da8183727218855]

CVE-2026-72254: netfilter: nft_fib: reject fib expression on the
netdev egress hook

stable/6.1 was fixed.

Fixed status
stable/6.1: [1258a6da042c0c283dcf5c581acb318db29c760a]

CVE-2026-72288: KVM: arm64: vgic: Handle race between interrupt
affinity change and LPI disabling

stable/6.1 was fixed.

Fixed status
stable/6.1: [7328cff91703ac4e93c200b20cebaa36d2f314ed]

CVE-2026-72320: netfilter: nft_lookup: fix catchall element handling
with inverted lookups

stable/6.1 was fixed.

Fixed status
stable/6.1: [87ff022a58788ff4a25cf2c609b9abae418c9323]

CVE-2026-72321: ipv4: igmp: Fix potential memory leaks in
igmp_mod_timer() and igmp_stop_timer()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d4fe30f4671033a27fba077b3976dc113ffc0169]

CVE-2026-72325: perf/x86/amd/core: Avoid enabling BRS from the SVM reload path

stable/6.1 was fixed.

Fixed status
stable/6.1: [cb5322d04694d153cd5418267f8765a44b935f82]

CVE-2026-72329: net/liquidio: drop cached VF pci_dev LUT

stable/6.1 was fixed.

Fixed status
stable/6.1: [4ec87796fadf5a631ee6513c258c0e3d9ca62f79]

CVE-2026-72336: Bluetooth: 6lowpan: hold L2CAP conn across debugfs control

stable/6.1 was fixed.

Fixed status
stable/6.1: [1df008a0770843caaeb7148705fc104bfb266630]

CVE-2026-72337: Bluetooth: 6lowpan: avoid untracked enable work

stable/6.1 was fixed.

Fixed status
stable/6.1: [4137ad60d23ace43c7fc857bd12167750c85e89d]

CVE-2026-72338: net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload

stable/6.1 was fixed.

Fixed status
stable/6.1: [1afdf2268b71251ea70d80bd8232a2f022e62a73]

CVE-2026-72341: net/mlx5e: Fix publication race for priv->channel_stats[]

stable/6.1 was fixed.

Fixed status
stable/6.1: [df122c593735aa5e1c97457767aa10ed8fa972e0]

CVE-2026-72375: afs: Fix reinitialisation of the inode, in particular
->lock_work

stable/6.1 was fixed.

Fixed status
stable/6.1: [1471eef04c074029e2512a36e4d37d8547ff9762]

CVE-2026-72379: fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid

stable/6.1 was fixed.

Fixed status
stable/6.1: [74365c6e367725728d5ce36d38ca116c9f77a254]

CVE-2026-72380: xen/pvcalls: bound backend response req_id before indexing rsp[]

stable/6.1 was fixed.

Fixed status
stable/6.1: [4aaf7f32f1569e2c0475e073b8d7ec63b231d4c6]

CVE-2026-72382: ksmbd: reject undersized DACLs before parsing ACEs

stable/6.1 was fixed.

Fixed status
stable/6.1: [8dc949061e35427433feac3ebe5ec089f2aa857e]

CVE-2026-72383: sctp: fix addr_wq_timer race in sctp_free_addr_wq()

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb6117713abef8646fdbf58256532451bcf26c47]

CVE-2026-72398: sctp: add INIT verification after cookie unpacking

stable/6.1 was fixed.

Fixed status
stable/6.1: [ca967418a60b33158e859daf202f3858fd1c8afd]

CVE-2026-72404: tipc: fix UAF in cleanup_bearer() due to premature
dst_cache_destroy()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a66ca574eee958123ee9d2822683964d42d656a]

CVE-2026-72405: net: udp_tunnel: prevent double queueing in
udp_tunnel_nic_device_sync

stable/6.1 was fixed.

Fixed status
stable/6.1: [d59d3b19e1cd1a01a6db59705327387a30aed153]

CVE-2026-72416: netfilter: nft_compat: ebtables emulation must reject
non-bridge targets

stable/6.1 was fixed.

Fixed status
stable/6.1: [7c4f6a55a0fa8efbbe06dfed3fd440bca121f41a]

CVE-2026-72420: md/raid5: avoid R5_Overlap races while breaking stripe batches

stable/6.1 was fixed.

Fixed status
stable/6.1: [205e33bad8ebf5674fbe6ec3ae3805878abb4f2c]

CVE-2026-72423: bpf: Guard conntrack opts error writes

stable/6.1 was fixed.

Fixed status
stable/6.1: [6fd973def4d6cb89aaf7e9b6bc26cac977f6da13]

CVE-2026-72438: md/raid10: fix writes_pending and barrier reference
leaks on discard failures

stable/6.1 was fixed.

Fixed status
stable/6.1: [2d264c00beadcc67f16d683ab27eed28c047ba2e]

CVE-2026-72439: md/raid10: fix writes_pending leak on write request failures

stable/6.1 was fixed.

Fixed status
stable/6.1: [55dc3d1d6a9983867273d3531e3ddd743428db8d]

CVE-2026-72440: md/raid1: fix writes_pending and barrier reference
leaks on write failures

stable/6.1 was fixed.

Fixed status
stable/6.1: [874f54243d881fde1890849000beb88a7880d1ec]

CVE-2026-72453: regcache: Do not overwrite error code when finalizing
cache after error

stable/6.12 was fixed.

Fixed status
stable/6.12: [b454870bbdb3b34ffeaebf0d8e1726cc0aaa2de4]

CVE-2026-72470: fs/ntfs3: resize log->one_page_buf when adopting
on-disk page size

stable/6.1 was fixed.

Fixed status
stable/6.1: [220a6ef5e89a11ffd5e490046b86dc9fb6da0e4b]

CVE-2026-72472: nfs: use nfsi->rwsem to protect traversal of the file lock list

stable/6.1 was fixed.

Fixed status
stable/6.1: [7813adb38c88573b730219c1dc1b630dfab7165e]

CVE-2026-72488: soundwire: fix bug in sdw_add_element_group_count
found by syzkaller

stable/6.1 was fixed.

Fixed status
stable/6.1: [c35474cf6a7d0891ebebbeda08ce34b602885ab6]

CVE-2026-72494: RDMA/irdma: Replace waitqueue and flag with completion

stable/6.1 was fixed.

Fixed status
stable/6.1: [4dcd5afcc3516b07f0a506c338a49bccfd24589b]

CVE-2026-74257: sockmap: Fix use-after-free in udp_bpf_recvmsg()

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ea94949a5afe457647def276cd6958721481abd]

CVE-2026-74261: ALSA: seq: avoid stale FIFO cells during resize

stable/6.1 was fixed.

Fixed status
stable/6.1: [8bb506ffb848e3de1496a4cf23a2fd694da2a7d2]

CVE-2026-74264: net: watchdog: fix refcount tracking races

stable/6.1 was fixed.

Fixed status
stable/6.1: [fbb8e79c117adcbfafef33b81d0db853b461bdac]

CVE-2026-74269: bnxt: fix head underflow on XDP head-grow

stable/6.1 was fixed.

Fixed status
stable/6.1: [59f6211c006cb5936b443fb396eb43864ca21ed5]

CVE-2026-74278: ALSA: seq: Fix kernel heap address leak in bounce_error_event()

stable/6.1 was fixed.

Fixed status
stable/6.1: [05e2358fec8812c37516ccea63bc4b9956d864ba]

CVE-2026-74291: ASoC: topology: Check PCM and DAI name strings before use

stable/6.1 was fixed.

Fixed status
stable/6.1: [d09dad8dff862c4b5aac48b1223e512074ffeb08]

CVE-2026-74302: Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c277f624cd99e4f0e0223fd039b7615feea4afdc]

CVE-2026-74307: ext4: validate donor file superblock early in EXT4_IOC_MOVE_EXT

stable/6.1 was fixed.

Fixed status
stable/6.1: [23380fc1bf5d3b75dcbd51eb72be4eb0a3300370]

CVE-2026-74308: ext4: fix kernel BUG in ext4_write_inline_data_end

stable/6.1 was fixed.

Fixed status
stable/6.1: [13db1ccae4d38f6d9296ee74aa1d39b429959ddb]

CVE-2026-74317: ixgbe: do not configure xps for XDP queues

stable/6.1 was fixed.

Fixed status
stable/6.1: [4b7bd53d91155eeb0961f26930f0c70b6538613f]

CVE-2026-74318: btrfs: fix deadlock cloning inline extent when using
flushoncommit

stable/6.1 was fixed.

Fixed status
stable/6.1: [18694c1ca40c8d7a6a3e593ed3d764b0e18d33cd]

CVE-2026-74338: bpf: Reject sleepable BPF_LSM_CGROUP programs at load time

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0c76212af693734e5a2c9e9a48568f99f5bc46c]

CVE-2026-74339: ALSA: seq: Clear variable event pointer on read

stable/5.10 was fixed.

Fixed status
stable/5.10: [8a631e1aaa1ebbc9de916927fa01707244e18291]

CVE-2026-74341: wifi: wcn36xx: fix heap overflow from oversized
firmware HAL response

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7acc1995bdcfdd82b2dd0dc735b1a4b076ae88a0]
stable/5.15: [b80c4b5268c297b0503f65ef18038327e2119ad1]

CVE-2026-74345: RDMA/siw: Fix endpoint/socket association handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [f27da1192118fb6a7e73a85cfe4b02ccf8298619]

CVE-2026-74347: netfilter: cttimeout: detach dataplane timeout policy
and repurpose refcount

stable/6.1 was fixed.

Fixed status
stable/6.1: [b512f4bacb73219bd525b5189a26143cabd7b38c]

CVE-2026-74350: ocfs2: validate fast symlink target during inode read

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed9f95ee3bbaea9b05808727eb86ea5e5ccf2b52]

CVE-2026-74356: vhost: fix vhost_get_avail_idx for a non empty ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [7536f8f72bd24f1ae316c24231faaa3667eba837]

CVE-2026-74386: nvmet-tcp: fix page fragment cache leak in error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [aadb8eb9006e192c51b499860f40765de7d55680]

CVE-2026-74388: ALSA: seq: oss: Fix UAF at handling events with
embedded SysEx data

stable/6.1 was fixed.

Fixed status
stable/6.1: [3e85e690e787fa42f35e1bd9d18a7979c201d165]

CVE-2026-74389: RDMA/hns: Fix log flood after cmd_mbox failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [a194e535019e0b32831f16b0eafd83c54d57ccbb]

CVE-2026-74391: tracing: Bound synthetic-field strings with seq_buf

stable/6.1 was fixed.

Fixed status
stable/6.1: [9f8ef2e1e95a42044e614b0a5277e3f53f545135]

CVE-2026-74397: IB/mlx5: Fix transport-domain rollback and initialize
lb mutex earlier

stable/6.1 was fixed.

Fixed status
stable/6.1: [6da717ed8a0703a331295fdd5ad8b7eacec216ad]

CVE-2026-74401: dlm: fix add msg handle in send_queue ordered

stable/6.1 was fixed.

Fixed status
stable/6.1: [482606fea302d8bab86901d7426c3716980d99a8]

CVE-2026-74405: OPP: Fix race between OPP addition and lookup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [835b9b5b4d287a03c713680b0231d36ff599201b]
stable/5.15: [2fb061a90898420d8ca1a0b9959ca977d90fa841]
stable/6.1: [e25be5d812ec8ca2615d23726b3861b04e2fff35]

CVE-2026-74406: vxlan: Fix potential null-ptr-deref in
vxlan_gro_prepare_receive().

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [022af89207fcc992ec5c712c14e2e018c335eb1e]
stable/5.15: [a3104cc1fed994519538301efcaab175f9af6008]

CVE-2026-74407: wifi: ath11k: cancel SSR work items during PCI shutdown

stable/6.1 was fixed.

Fixed status
stable/6.1: [7630eb217166435e8a6dd501fa4ad304e2264407]

CVE-2026-74417: drm/radeon: fix integer overflow in radeon_align_pitch()

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e0c822907bedeaec317f84e6990d265f03db85d]

CVE-2026-74445: drm/vmwgfx: reject DX_BIND_QUERY without a DX context

stable/6.1 was fixed.

Fixed status
stable/6.1: [6af8f0571b4f07e9b102641f195e0ae3cd3a6c71]

CVE-2026-74466: s390/zcrypt: Close speculative mem read possibility

stable/6.1 was fixed.

Fixed status
stable/6.1: [55ac533c568a5dcaa41cd26d6e089f9dff2a7c22]

CVE-2026-74527: octeontx2-af: Block VFs from clobbering special CGX PKIND state

stable/6.1 was fixed.

Fixed status
stable/6.1: [f24f7ce6fb2d1ae080a05371afddba30a3e0b919]

CVE-2026-74537: Bluetooth: ISO: hold sk properly in iso_conn_ready

stable/6.1 was fixed.

Fixed status
stable/6.1: [622180fe44fb52d4d7bafcd67922959823fec263]

CVE-2026-74543: net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d53a8b927ac9788257266e115d4901ec6f455387]

CVE-2026-74544: net/sched: cls_u32: validate offshift to prevent
shift-out-of-bounds

stable/6.1 was fixed.

Fixed status
stable/6.1: [7fd5b2287e5cf33e114fb7f0cef781a546039757]

CVE-2026-74571: btrfs: skip global block reserve accounting for rescue mounts

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa72cc4675240ab6b01ec72ac6a1fe832e715569]

CVE-2026-74599: mm/ptdump: always stabilise against page table freeing
using init_mm

stable/6.1 was fixed.

Fixed status
stable/6.1: [42c9464975cf21346a8950b8ba0ac3234b385be1]

CVE-2026-74600: mm/page_table_check: skip special zero mappings

stable/6.1 was fixed.

Fixed status
stable/6.1: [084b031a1cc13b1d50b9660baace0b7eba52bebe]

CVE-2026-74611: tls: rx: restore msg_iter before TLS 1.3 optimistic retry

stable/6.1 was fixed.

Fixed status
stable/6.1: [97004f3c17371ee1b259887298711e0604666688]

CVE-2026-74672: mm/vmalloc: acquire init_mm lock on huge vmap to avoid
ptdump UAF

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [51eaba47b3dc258d1182fc3a88da544ed6b6bb2d]
stable/5.15: [e85ed734611616d4a9d8a240bde563dd6ac7452f]

CVE-2026-74684: net: tap: set skb->dev before parsing virtio net
header in tap_get_user_xdp()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d022885f3e6e0e238815391a4afaf3a4fb0a442]

CVE-2026-74687: watchdog: at91sam9_wdt: prevent timer rearm during teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [f96c18a766477e5f33d51697963a5c8aed260dae]

CVE-2026-74690: s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

stable/6.1 was fixed.

Fixed status
stable/6.1: [9c9a59603b2b016424fe2f9a1cb58c8c2f7198f4]

CVE-2026-74695: netfilter: nf_flow_table: drop existing skb dst before
skb_dst_set_noref()

stable/6.1 was fixed.

Fixed status
stable/6.1: [763f59b72ddaf18d0750d53083a74355f6c003c8]

CVE-2026-74700: net/sched: cls_api: Always acquire rtnl_lock when
destroying locked classifiers

stable/6.1 was fixed.

Fixed status
stable/6.1: [73e8544e0df5d11b1914bcc25ae284946b51786d]

CVE-2026-74713: vhost_iotlb: bound map allocation in add_range

stable/6.1 was fixed.

Fixed status
stable/6.1: [91d3f1fcb8f7109f18d46a7366bb8202ac4b4456]

CVE-2026-74715: bpf: Fix netns reference imbalance in conntrack kfuncs

stable/6.1 was fixed.

Fixed status
stable/6.1: [cfde990193135a35637e55f69e83e4ab441e60ab]

CVE-2026-74723: btrfs: lzo: reject inline extents without valid headers

stable/6.1 was fixed.

Fixed status
stable/6.1: [0b824d657d2403e8dbe4257d62825e66f79dcf8c]

CVE-2026-74729: soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

stable/6.1 was fixed.

Fixed status
stable/6.1: [f62afe827c52c300c64715631e6ac9e576c5112d]

CVE-2026-74733: gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [58ed56c093a857c19f04cf3db1f02d2e793aec88]

CVE-2026-74735: l2tp: fix tunnel and session refcount leak on seq_file release

stable/6.1 was fixed.

Fixed status
stable/6.1: [c38b723858a51d6ca4e56470b9f1087f23276772]

CVE-2026-74739: net/sched: cls_u32: skip hash tables in u32_bind_class()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [43e1a952d534fc0e173b513a24b19ce99bb60974]
stable/5.15: [07f57c7c47459e9bc75186b3af0fc2bc5be72f89]

CVE-2026-74740: net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain

stable/6.1 was fixed.

Fixed status
stable/6.1: [28aa0c9dd0b1b38436995d4c15621ad3f896c7e3]

CVE-2026-74747: ipvs: revalidate ihl to prevent out-of-bounds access

stable/6.1 was fixed.

Fixed status
stable/6.1: [f55bb94946fb8ee6304590a731c39c1fbc3b28bc]

CVE-2026-74754: scsi: core: pair EH runtime PM get and put

stable/6.1 was fixed.

Fixed status
stable/6.1: [9aca00c74730f4bc12d0717d33db637a16ccdfea]

CVE-2026-80526: ASoC: tas2562: Validate values for volume writes

stable/6.1 was fixed.

Fixed status
stable/6.1: [602b209a5cfcf8e891afba12fad109db4141d4b8]

CVE-2026-80551: s390/vfio_ccw: Ensure first IDAW remains constant

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b7c23440343e336259cd45017cc901a744c41b0]

CVE-2026-80554: s390/vfio_ccw: Limit the number of channel program segments

stable/6.1 was fixed.

Fixed status
stable/6.1: [2ce00bb19db13606cda79f4b7aae4d9775de3096]

CVE-2026-80572: Input: byd - synchronize timer deletion before freeing
private data

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [fe2785d5513b3254368a1f0831515fc59ab0d40d]
stable/5.15: [b4d74810aad9b29c313b4d7880c84aceb5abe488]

CVE-2026-80576: drm/amdgpu: reject oversized IBs with per-ring packet limits

stable/6.1 was fixed.

Fixed status
stable/6.1: [ecdaefe825555f133a2ef80f39d1ae94d6e1b26a]

CVE-2026-80587: mptcp: avoid combining some incoming suboptions

stable/6.1 was fixed.

Fixed status
stable/6.1: [d1bce616636c1c42649966677973490a510055c4]

CVE-2026-80602: perf/x86/amd/lbr: Fix kernel address leakage

stable/6.1 was fixed.

Fixed status
stable/6.1: [5adfec05e804ce4bd3368b75df5e5b7b40ee960b]

CVE-2026-80611: ACPI: processor_idle: Mark LPI enter functions as __cpuidle

stable/6.1 was fixed.

Fixed status
stable/6.1: [8ca5dfe4249bbb6bd34f37d16c2ea933c31f6a2a]

CVE-2026-80616: ieee802154: Avoid calling WARN_ON() on -ENOMEM in
cfg802154_switch_netns()

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ff703da843d665ce7fc3fe5c202cf8121cc2a1f]

CVE-2026-80623: coresight: ete: Always save state on power down

stable/6.1 was fixed.

Fixed status
stable/6.1: [0f8396271d7026583bcaa71ffe2e7f6025244705]

CVE-2026-80628: ALSA: seq: oss: Serialize readq reset state with q->lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [cf58e4abf61d6643446f08ce69993688bb914420]

CVE-2026-80629: octeontx2-af: npc: Fix size of entry2cntr_map

stable/6.1 was fixed.

Fixed status
stable/6.1: [b7727c4d6f1d3bf85fec781ffe2b3c7ba4c1ecdc]

CVE-2026-80631: btrfs: lzo: reject compressed segment that overflows
the compressed input

stable/6.1 was fixed.

Fixed status
stable/6.1: [e4325fb00e0c7269cb67f97d7148507787a57fd7]

CVE-2026-80634: netfilter: flowtable: avoid num_encaps underflow on
bridge VLAN untag

stable/6.1 was fixed.

Fixed status
stable/6.1: [9a4e3a9017ba3da2de187b72ed6545641a0d0a84]

CVE-2026-80637: netfilter: synproxy: fix unaligned memory access in
timestamp adjustment

stable/6.1 was fixed.

Fixed status
stable/6.1: [b30a2d56ee47282f6a46cb2f50e315b2414851fe]

CVE-2026-80643: EDAC/igen6: Fix call trace due to missing release()

stable/6.1 was fixed.

Fixed status
stable/6.1: [be6059b0552d73a0b5430bc7a71a9c74f4d944e5]

CVE-2026-80650: media: atomisp: gc2235: fix UAF and memory leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [5bed166be3054f9ebb527dbce7158677085eea59]

CVE-2026-80653: scsi: hisi_sas: Add slave_destroy interface for v3 hw

stable/6.1 was fixed.

Fixed status
stable/6.1: [d664252d414aae17066a2831fe7bfd8f0e27b018]

CVE-2026-80654: soc: xilinx: Shutdown and free rx mailbox channel

stable/6.1 was fixed.

Fixed status
stable/6.1: [059522f4df86198f0df10dbc53d7ac04cf36a0b8]

CVE-2026-80668: netfilter: nf_conntrack_expect: use conntrack GC to
reap expectations

stable/6.1 was fixed.

Fixed status
stable/6.1: [61ca26e1a45965590f7e477c4d6f711162642e1c]

CVE-2026-80694: net: ethernet: mtk_eth_soc: pass eth to
mtk_handle_irq_rx in poll_controller

stable/6.1 was fixed.

Fixed status
stable/6.1: [979a736fcac2ee32b55dafa6766188aa8b6927a4]

CVE-2026-80695: hwmon: (sht3x) Fix unaligned accesses

stable/6.1 was fixed.

Fixed status
stable/6.1: [3eed79d882c98f1805dc537ed393d8e257a46017]

CVE-2026-80698: dmaengine: idxd: fix double free of wq, engine, and
group structs

stable/6.1 was fixed.

Fixed status
stable/6.1: [899aa2424a75b1812a1f4766e41e82315a521e7e]

CVE-2026-80710: s390/dasd: Fix undersized format-check buffer

stable/6.1 was fixed.

Fixed status
stable/6.1: [3d6be353ba0515247f527c6522348ac730b86ff0]

CVE-2026-80729: mm/huge_memory: initialise workingset state before folio split

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [27c04ec3756380c788bf632502d1b5a700ea7072]
stable/6.12: [3e73e23de354f61768b1fda4d6cf552c3a736be7]
stable/6.6: [25dbafda0e43292669223dbcb2b682b61b89e341]

CVE-2026-80738: bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

stable/6.1 was fixed.

Fixed status
stable/6.1: [b75f1c071f31be7f4b950721e04240c250091ad4]

CVE-2026-80739: net/mlx5e: TC, Check if flow is PEER before acquiring
devcom lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [ead5145d290a918b7c3c3141a64b3f827a9e1b6b]

CVE-2026-80747: drm/amdkfd: Add bounds check for CRAT subtype length

stable/6.1 was fixed.

Fixed status
stable/6.1: [1f9cc5375916b57acb1ad4443af7b4dbf347638a]

CVE-2026-80755: selinux: reject a permission value exceeding the class
permission count

stable/6.1 was fixed.

Fixed status
stable/6.1: [766051751cfb90fc9c29c30c2943b0f24eda9594]

CVE-2026-80761: Bluetooth: ISO: zero the sockaddr before returning it in getname

stable/6.1 was fixed.

Fixed status
stable/6.1: [182d3ef350c437b1e4ae07e45f82e271e2033bd7]

CVE-2026-80771: HID: nintendo: register input device after capabilities are set

stable/6.1 was fixed.

Fixed status
stable/6.1: [a2a46a705c1fa724aac158fd188273dd7ee8c171]

CVE-2026-80786: fbdev: Wrap user-invoked calls to fb_set_var() in helper

stable/6.1 was fixed.

Fixed status
stable/6.1: [af39d039b5591e3ebaa2e013862bd8cacc6d9dc3]

CVE-2026-80836: crypto: virtio - bound the akcipher result length

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0ffee8adc71a0bc548e5ebc6e021c013a874d79]

CVE-2026-80837: netfilter: nf_tables: don't queue packet path object
notifications

stable/6.1 was fixed.

Fixed status
stable/6.1: [f010756ed75ac003146a1cbc93501092343bb3a3]

CVE-2026-80841: net/packet: defer vmalloc TX_RING free until skbs finish

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed126ca71d4d949ad99f40b974a8f7685e808f8b]

CVE-2026-80847: tcp: clamp route advmss to TCP_MIN_MSS

stable/6.1 was fixed.

Fixed status
stable/6.1: [1aedef9ca04aad427a077c7c427ffd89768038bc]

CVE-2026-80851: gtp: serialize PDP context updates

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d8ebf8875fb97b3e39aa226af78f9c619e96ee31]
stable/5.15: [6e5472c1c1619793cbadb02bccf7d2d9f826052f]
stable/6.1: [d9a83492ffc99f228d91873473e3820300525f00]

CVE-2026-80852: tls: device: fix out-of-bounds write in tls_append_frag()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bc09411a11b5a676c59ff8612c6873d014f6fb36]
stable/5.15: [1fc6eb0c756b8be693b72e9e636ae5e236dcb6ee]

CVE-2026-80855: fuse: fix invalidate lock leak on open O_TRUNC DAX failure

stable/5.10 was fixed.

Fixed status
stable/5.10: [69a294e561c10909688bcb25456535dcd1818e1a]

CVE-2026-80856: fuse: fix invalidate lock leak on setattr writeback failure

stable/5.10 was fixed.

Fixed status
stable/5.10: [92faaee1b108c6e4b07730d20896a6593a85f675]

CVE-2026-80861: usb: xhci: bail out of setup if the controller is inaccessible

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9f8b403d5f8c1ac361533c73fa449153a3c7fc6c]
stable/5.15: [15e62f969fecf459a0b873004cc5f4c5a6ba5fcc]
stable/6.1: [99e78b54cc3d70e008bd1a30d43e13d652c773e0]

CVE-2026-80864: RDMA/rxe: Fix responder UAF on
IB_QP_MAX_DEST_RD_ATOMIC modify_qp

stable/6.1 was fixed.

Fixed status
stable/6.1: [87e40635d77aa19088550698c81eb295d5131f71]

CVE-2026-80866: tipc: avoid busy looping in tipc_exit_net()

stable/6.1 was fixed.

Fixed status
stable/6.1: [772769859226a5b004442403510acb58a1c32e72]

CVE-2026-80883: drm/tegra: gr2d/gr3d: Initialize address register map
before HOST1X client is registered

stable/6.1 was fixed.

Fixed status
stable/6.1: [3a5f1ac5658bae5200bb6a85312b5388bc26ca55]

CVE-2026-80884: ntb: Store original DMA address for future release

stable/6.1 was fixed.

Fixed status
stable/6.1: [05a4585f76fd7bbec41bb7bf07a4d2ee2ba607d0]

CVE-2026-80905: net: tap: fix wrong transport_header when sending
VLAN-tagged frame

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8f49e83e4447b885376e6a937d62df883cc8824]

CVE-2026-80907: drm/amdgpu: Fix UVD dpb min size calculation for H264

stable/6.1 was fixed.

Fixed status
stable/6.1: [dfd3ccdd77363a3e3e0ea7babd932c3966f0aef8]

CVE-2026-80925: vlan: fix skb_under_panic and races when toggling HW
VLAN offload

stable/6.1 was fixed.

Fixed status
stable/6.1: [69f2fc6e761ee68a4c0c8e416ae88c573d4d7319]

CVE-2026-80937: wifi: mt76: mt7915: bound the device EEPROM address
before the EFUSE copy

stable/6.1 was fixed.

Fixed status
stable/6.1: [ef10a2ec2a74c4a6aa5c086fc0c2b01037569134]

CVE-2026-80947: wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [75e7e19e9218e3b895e652f04acf08113dc3aa00]
stable/5.15: [da1678cca182567fd84618b689f4424f3f55f712]
stable/6.1: [06e6bbb0abc2ae22e6e4d184250075e5c9e090d6]

CVE-2026-80948: wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0540361ac82095b25e6eebd70b1df37d2faf45bd]

CVE-2026-80967: ALSA: pcxhr: initialize mutexes before requesting threaded IRQ

stable/5.10 was fixed.

Fixed status
stable/5.10: [20a0f80f67a1495a57e5a3ba0fa172a0f919691d]

CVE-2026-80974: mfd: sm501: Fix potential memory leaks during remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [0eae998ca448029fb61a6bb9fd7b1f9d05a9490d]

CVE-2026-80980: net/smc: stop killed, freed and out_of_sync sharing a byte

stable/6.1 was fixed.

Fixed status
stable/6.1: [a6efc0f4dbdba6595d89cdaf2d8f26f68be16f0b]

CVE-2026-80983: net/smc: fix socket refcount leak in smc_switch_conns()

stable/5.10 was fixed.

Fixed status
stable/5.10: [8cb289eb764ff18000a33ddbc287d676d8597eea]

CVE-2026-80989: net: thunderbolt: Mark the connection down when
bringing it up fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [c18f4ce9e2cb8836c302ef30a1e3392a0233c7b3]

CVE-2026-80990: net: thunderbolt: Release the Rx HopID that was handed
out on mismatch

stable/6.1 was fixed.

Fixed status
stable/6.1: [b098f01638a142afbb1e00b323e2fc40f237907a]

CVE-2026-80991: net: ravb: serialize PTP clock teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [0400b9c5608933289bcacc3886dd3e4f6b7695f1]

CVE-2026-80996: net: l2tp: do not propagate multicast notification errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [73761c3cfb6d86392d63335d10f464b9d43275a7]

CVE-2026-81016: platform/x86/amd/pmc: Propagate SMU errors and
validate S2D address

stable/6.1 was fixed.

Fixed status
stable/6.1: [646cdcc6c7594d8ad81577b2cb05276a927edc28]

CVE-2026-89437: platform/x86: int1092: Fix potential memory leak in sar_probe()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ef8eb7613db672def645f19387d7daead5c29a0e]

CVE-2026-89441: mmc: via-sdmmc: cancel card-detect work on remove

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [28e8e9e1f3bdb75b611ea14c39775455528c4012]
stable/5.15: [a32603f9b4dd0a1c3ea5845eec7c95f5f8741b3d]
stable/6.1: [3ee1b5c8618a26811840bf9f45cb3120dac1e273]

CVE-2026-89448: iommu/vt-d: Force requesting ACS when tboot is enabled

stable/6.1 was fixed.

Fixed status
stable/6.1: [3fd2b60ea9bd18348f5e971678f31041ef211047]

CVE-2026-89452: iommu/msm: Unwind probe state on registration failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [51424c14dbdadc8c2ad4abf842265a50f69d78aa]

CVE-2026-89462: power: supply: max17040: propagate register read errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [abf348c40cd409db72758377f1eb6ed400c981c6]

CVE-2026-89463: power: supply: ucs1002: fix use-after-free on remove

stable/5.10 was fixed.

Fixed status
stable/5.10: [b389325e1ad3bfd113aac6a1fcf1658fec2aebb1]

CVE-2026-89465: power: supply: rt9455: quiesce delayed work before teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3def4721431f3e374e1e3124f4d32bb07ae8df1c]
stable/5.15: [c8645073876cbb1cdc8c2b995d093d08facfb187]
stable/6.1: [c09a2e4f8f101a44bd786a31696c958473469be0]

CVE-2026-89468: power: supply: lp8788-charger: fix use-after-free on remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [8758fe39a993f86998c8071826150b8859902497]

CVE-2026-89472: power: supply: charger-manager: register regulators
before exposing sysfs

stable/6.1 was fixed.

Fixed status
stable/6.1: [5763750916d28a29f1375a14dd6dadd5f2d2e178]

CVE-2026-89475: power: supply: bq24257: fix use-after-free on remove

stable/5.10 was fixed.

Fixed status
stable/5.10: [9aace29bbcfa64450c53773ed2f20e95987b3690]

CVE-2026-89480: nvme-tcp: reject a read that transferred too few bytes

stable/5.10 was fixed.

Fixed status
stable/5.10: [b674af31d044a86bd094ba8bb8f2bb92fb49aac5]

CVE-2026-89481: nvme-tcp: fix host memory disclosure on R2T for a read command

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [effe898669c5f69ed519d6339be01ee9cd91d1a4]
stable/5.15: [377aa04d7b3e73ffef6364818def188da8d6f025]

CVE-2026-89484: lockd: fix NULL dereference on lockowner allocation failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [b61053a3795c2913a7af3ab6218acfdaf52fcafe]

CVE-2026-89492: ocfs2: validate directory-index entry counts when
reading metadata

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3f28574dd59672ac47f3110c9a8ead703ec021c0]
stable/5.15: [3497aa757788de5d904f41814f1df0b292a8be09]
stable/6.1: [47b8152ed7709f7ef30b398fb0bfe4b452dd0495]

CVE-2026-89520: sched/core: Make core-sched flips wait for in-flight selections

stable/6.1 was fixed.

Fixed status
stable/6.1: [8e9376420321026ae1a0d8c3040682242db10be7]

CVE-2026-89526: svcrdma: Validate Read chunk positions before reconstruction

stable/6.1 was fixed.

Fixed status
stable/6.1: [6388f2ed36c10f59d926735b92c2b152d2c635e5]

CVE-2026-89527: svcrdma: Use svc_xprt_put to free listener on create failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [31b8293495ba94ccf494e556a318886b716884b6]

CVE-2026-89528: svcrdma: Reject Read lists that exceed the page budget

stable/6.1 was fixed.

Fixed status
stable/6.1: [08aa4162df91880a79be744aaa9570b04d4875c4]

CVE-2026-89530: svcrdma: Reject inline replies that overflow the pull-up buffer

stable/6.1 was fixed.

Fixed status
stable/6.1: [b73011049dbe909f73fd9620d94ef1757d7af2eb]

CVE-2026-89531: svcrdma: Reject connection when transport allocation fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [387401ebe7f4897acd18321dc94817ad6a33f580]

CVE-2026-89537: SUNRPC: Reject short RFC 4121 MIC tokens in
gss_krb5_verify_mic_v2

stable/6.1 was fixed.

Fixed status
stable/6.1: [86c3d527303ec79805098bda3dfc4fa994757f59]

CVE-2026-89539: SUNRPC: reject duplicate CREDS_VALUE options

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6207d7df96b3a7f507f0bfc8842b3760ee2fb1f8]
stable/5.15: [4904d61eb2e2bd484000725fd302b8f37b4fcf3a]
stable/6.1: [64b9ef369a6f723294613cb129e5f62c35429df5]

CVE-2026-89543: sunrpc: fix use-after-free in __rpc_clnt_handle_event
and __rpc_clnt_remove_pipedir

stable/6.1 was fixed.

Fixed status
stable/6.1: [1a713814e0580f946196bca5e340b37991c6e8bf]

CVE-2026-89544: SUNRPC: fix gssx_dec_option_array error path bugs

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ac86b45bb978cd4fdbcaaca82dd0f2337f8e310c]
stable/5.15: [3473139d15d67e2fd737cf0613082adb5499362f]
stable/6.1: [993a9012e68b8667a0a9b316fd718680c7e008a0]

CVE-2026-89545: sunrpc: defer rq_argp and rq_resp free until after RCU
grace period

stable/6.1 was fixed.

Fixed status
stable/6.1: [c977158237bccc3d2512d5b17c47ee3760dc8839]

CVE-2026-89550: SUNRPC: svcauth_gss: enforce krb5 token minimum length

stable/6.1 was fixed.

Fixed status
stable/6.1: [2188232509f1559cb8fcb0c9a4b1e04317fa0f15]

CVE-2026-89552: params: fix charp corruption on allocation failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [72835d539ed3eb4c4b85b85a3f3976c7bdc70b91]
stable/5.15: [c7cc1edf3c0de948abcb3e4a44ee86a82403ce2f]
stable/6.1: [32c1f305cfad192cd98468140beedeffe4792f53]

CVE-2026-89553: nouveau/gem: reserve the bo in the info ioctl around
the vma lookup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3e9c9090d4cc5a61ab5067ac5502c4fd37891b97]
stable/5.15: [24340ab41c33e16b3d64d89cb738ecd83c78de49]
stable/6.1: [f57e0d3bee3f7a459c048e10fd1cbcfd1dac2e0f]

CVE-2026-89561: ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f5e89dfc0a815c6ed12791d8deb3b6f39dd0621e]

CVE-2026-89564: ip: orphan prefetched skbs before multicast forwarding

stable/6.1 was fixed.

Fixed status
stable/6.1: [592b91f41d4f35e37c9e0be1c46a4c28437642cd]

CVE-2026-89574: dm array: validate array block headers on read

stable/6.1 was fixed.

Fixed status
stable/6.1: [e09d8b34ed199c8b7d7528c2b8324aa7cff712f8]

CVE-2026-89580: bpf: Disable preemption in __bpf_get_stack

stable/6.1 was fixed.

Fixed status
stable/6.1: [68eebc89c5ab5a8f9281773f35e49c83940450a0]

CVE-2026-89598: fbdev: ssd1307fb: defer I2C transfers from damage callbacks

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab8c8e027fa8f9314340a96999dd3309b7f80d61]

CVE-2026-89601: ext2: Fix lost inode updates for IS_SYNC inodes

stable/6.1 was fixed.

Fixed status
stable/6.1: [55e66d84b5272c425b324a2b247cdacacf1e10b9]

CVE-2026-89622: HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

stable/6.1 was fixed.

Fixed status
stable/6.1: [198bf4a226229e36dfe254493a45c71c3ffc7e57]

CVE-2026-89625: HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [9405e50a64b07d9c6216381d7eac5373e8ce5077]
stable/6.1: [8c18db1d6618b37efdb819e35a44d16bfabf171b]

CVE-2026-89631: smb: client: reject a tree connect response whose byte
count is too small

stable/6.1 was fixed.

Fixed status
stable/6.1: [bb99866cb1d3d5e8201200a8692fd8da3106a8fd]

CVE-2026-89633: smb: client: fix OOB read/write from unvalidated
DataOffset in coalesce_t2()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f7baf60435129e3a5f3500a38e3cb4c3860deed7]
stable/5.15: [9f3a7440731a34c89ad04fef6616f185acb28401]
stable/6.1: [531ac35abd74fb5b4aec5e19543e832613a1789d]

CVE-2026-89638: smb: client: clear setuid/setgid bit on write with
cifsacl/modefromsid/posix extensions

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ce0e675907b887db2b1e44a806118b0a7d8b6b18]
stable/5.15: [a3a0cc83761e46a75b1ed6bfaf35961f2c211148]
stable/6.1: [2a5206992f526178881e8f5c4644757c336fb76d]

CVE-2026-89640: cifs: fix loff_t underflow in cifs_remap_file_range()
when len == 0

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2c6eede83b3de1268db92c7e49741761c954aa26]
stable/5.15: [ce813e5eebf46851e872ce59bdc34dc5dd4e29a4]

CVE-2026-89642: cifs: call pagecache_isize_extended() in
cifs_setsize() when extending

stable/6.1 was fixed.

Fixed status
stable/6.1: [880e1b5883a5d78d916fa446791c48f28a16719b]

CVE-2026-89644: btrfs: fix extent map leak in NOCOW direct I/O write

stable/6.1 was fixed.

Fixed status
stable/6.1: [8d264d35df981e943171ddc09cd6cc1d38c65e17]

CVE-2026-89645: btrfs: drop recovered reloc root refs on recovery failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [f671ffc678e0247aad77126670cb28c766d6ab3d]

CVE-2026-89647: ceph: do not repeat ceph_trim_dentries() if no progress possible

stable/6.1 was fixed.

Fixed status
stable/6.1: [f2f6daf8e99e15d636b1706bb4efd9a856195324]

CVE-2026-89648: ceph: cap delegated inode count in ceph_parse_deleg_inos()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4606d76748affb378f9d15a5d77c128793f4b996]

CVE-2026-89650: ceph: bound num_export_targets array for mds info v2/v3

stable/5.10 was fixed.

Fixed status
stable/5.10: [a6eaf7bd229d0940ba8f126c684a663a680abef1]

CVE-2026-89652: ceph: bound copied dentry name length in NFS export get_name

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [aadfe588ad8032ea99bda259ae7b8d42854f8193]
stable/5.15: [3cb09301c30909a7935e9de41f98eeb5ef7e4d40]
stable/6.1: [dff3d84d14142ea43ad61ef5d6b4de05ba16ba42]

CVE-2026-89654: ceph: fix UAF in check_new_map() on session freed during unlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [989343b7ee5b1a08778be0c7c4bf6030d3910807]

CVE-2026-89659: NFSD: Prevent client use-after-free during delegation revoke

stable/6.1 was fixed.

Fixed status
stable/6.1: [2f9a200c0ea5b214609b8cea2b6666458bcb54cd]

CVE-2026-89666: nfsd: reject out-of-range nseconds in NFSv3 SETATTR
and create ops

stable/6.1 was fixed.

Fixed status
stable/6.1: [cacda0762d7af24a27f7265711bc05095ece56b9]

CVE-2026-89671: nfsd: gate nfs3 setacl by argp->mask

stable/6.1 was fixed.

Fixed status
stable/6.1: [beeb33152873ad40692bd255b562966f8ba43dbd]

CVE-2026-89672: nfsd: gate nfs2 setacl by argp->mask

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d00a2f81ba7c57045bd644971ddb6961c5efe3e0]
stable/5.15: [760e7a4f92f597c61ab6b089f934a7e3acf238b7]
stable/6.1: [54ff9c81d6b77de4540ba33a3b4d613ce3194863]

CVE-2026-89676: nfsd: fix stale s2s_cp_stateids IDR entry for async COPY

stable/6.1 was fixed.

Fixed status
stable/6.1: [745b2edfdd96b8738a94dee450adff4c7d026d5b]

CVE-2026-89680: nfsd: fix nfsd_file leak on inter-server COPY setup failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d15f76fddc5d0215db5f18851048376a1ea79bd6]
stable/5.15: [eb22420e5bd6eb3afa1f840036bb08a7ac90db76]
stable/6.1: [94c28af6fd89cb204975e49b824f8ee521bb84e9]

CVE-2026-89682: nfsd: fix fcache_disposal UAF by inlining dispose
state into nfsd_net

stable/6.1 was fixed.

Fixed status
stable/6.1: [41fe0e804bbf1110c0aba2ebdfc729efb240d8a6]

CVE-2026-89685: nfsd: fix clock domain mismatch in clients_still_reclaiming()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7ca44a63d9a554ba7ad05b06d88746eab08b760e]
stable/5.15: [2c9efc6b692a153643d0f204b3c3632cb6b5761e]
stable/6.1: [a22ee3a2cadef44f2edeb909ae36bd72450a3a35]

CVE-2026-89686: nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
racing delegation revoke

stable/6.1 was fixed.

Fixed status
stable/6.1: [f5011c26246d1abed3dc750c9744e33cb79ff9bc]

CVE-2026-89693: nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [154acf97ecd2c0bb00f6533f86d4bd2b934475d5]
stable/5.15: [73dfa989f6f0dedcae1f2650aab3401537044282]
stable/6.1: [04b913ab96c2a874f41b5e5a19ac7120526723c2]

CVE-2026-89702: nfsd: size fh_verify server sockaddr slot by xpt_locallen

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4c7569ad68fc8b86ca40c7e56ef21460c0344955]
stable/6.1: [50d9d581d2af80799125ee62617d37e9b6b476a7]

CVE-2026-89707: nfsd: release path refs on follow_down() error

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bdf5a0f88d21239d8f9f7519b87359ba95fd045c]
stable/5.15: [18847cbf5900f5c6c55bef5a6f7a34a1918d1181]
stable/6.1: [e301c5cdb0dc2c4aeffc0c055ea15615d9c51fdc]

CVE-2026-89709: lockd, nfsd: RCU-protect nlmsvc_ops dispatch

stable/6.1 was fixed.

Fixed status
stable/6.1: [cc2f0d79b21be69b891cbd1899daf2a1fdf9df87]

CVE-2026-89713: NFSD: check truncate permission under inode lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [0669861a2e8e2bdb9c1149417d8ad821996ae4fe]

CVE-2026-89718: zram: fix out-of-bounds access in writeback_store()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f1c5611f699a3aa2a85ebd5fec03dc9bc501e6d0]

CVE-2026-89719: zram: fix out-of-bounds access in read_block_state()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fee53224c8261541cf310b57ac7c77a80e144483]
stable/5.15: [26a55336be91004dbd438f3b89b0c31617459976]
stable/6.1: [a189cae92e97d90a9553740f5558d6f74446d3d1]

CVE-2026-89738: usb: gadget: at91_udc: drain polled-VBUS timer/work
before udc is freed

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2440ce54b8c4c8aa6963c181eb56164a466fbe1c]
stable/6.1: [1674e34fe61ad3f5585dc833ba6bb6522912e6a5]

CVE-2026-89740: serial: imx: serialize imx_uart_ports[] lifetime

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ce9c074868d5c8adfb0c72de4324138d6fa1a1a8]
stable/6.1: [a4acf2739434a014cdfc282175cffd3e35a97fa4]

CVE-2026-89744: device property: fix infinite loop in
fwnode_for_each_child_node()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [45a8fc4a12751833ed3868095d18200a85336760]
stable/5.15: [770c9bde93c8bb644f590743e9fbae3492a20f9e]

CVE-2026-89754: mm/pagewalk: fix stale walk->action escaping walk_pmd_range()

stable/6.12 was fixed.

Fixed status
stable/6.12: [648f70d84003cf2ccedcb69983d4404211936923]

CVE-2026-89757: mm/mglru: fix and remove redundant unevictable folio handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [e9f2160081a1e3ebb285bd71be3382abaeb8390a]

CVE-2026-89759: mm/kmemleak: avoid soft lockup when scanning task stacks

stable/6.1 was fixed.

Fixed status
stable/6.1: [2567818c2776d0a820506c3612261d9e24af7164]

CVE-2026-89761: apparmor: fix out-of-bounds write when null
terminating a label vec

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0d4cb3af82556afc48f90fd3e8a126ff32343f41]
stable/5.15: [40fdee1cb4f18e6a1a21a891ae4735bcd4d35026]
stable/6.1: [57bb24025f450728f342d8e08cd3909c89361d90]

CVE-2026-89762: apparmor: fix cred UAF caused by
begin_current_label_crit_section()

stable/6.1 was fixed.

Fixed status
stable/6.1: [42d0791f8aa90382c22dbe0443712c78d1e9d212]

CVE-2026-89763: KEYS: trusted: Fix TPM teardown ordering

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b254cdadbcb6bdd0daf7391d63b3b97b2bec1ad9]
stable/5.15: [c96518231608bbf9568f539aadb20a8e366b54c7]
stable/6.1: [6564808189c9a1e682ee7b5e70f5f1c73c89c3a4]

CVE-2026-89788: ksmbd: fix tree connection use-after-free in smb2_tree_connect()

stable/6.1 was fixed.

Fixed status
stable/6.1: [63f5939b50470ef4d245c16d2098376b952beb51]

CVE-2026-89794: ksmbd: zero pipe read compound padding

stable/6.1 was fixed.

Fixed status
stable/6.1: [c7516bdf7d2c1a64b14a9f444e2ee58c12c384ae]

CVE-2026-89795: PCI: Allow per function PCI slots to fix slot reset on s390

stable/6.1 was fixed.

Fixed status
stable/6.1: [afdd497ca3836eda13530ab75b416d52f6d6129a]

CVE-2026-89799: bpf: Disable preemption in bpf_get_stackid

stable/6.1 was fixed.

Fixed status
stable/6.1: [01fc93f670b3e759413a4d574c18ccfc636d2728]

CVE-2026-89803: drm/nouveau: unsubscribe the channel-kill event before
the fence context

stable/6.1 was fixed.

Fixed status
stable/6.1: [ee1cfb1acdff3fe3b47de7c536e5c77443c8e74f]

CVE-2026-89808: drm/amdkfd: Fix the case that vm range is hole at
svm_migrate_copy_to_vram

stable/6.1 was fixed.

Fixed status
stable/6.1: [d5872c81c70163a3ba9eb4da9a94c92b03067576]

CVE-2026-89810: drm/amdkfd: Fix error path at svm_migrate_copy_to_ram

stable/6.1 was fixed.

Fixed status
stable/6.1: [ee007a238dd363ba2f3a3b01815703cfe98711c7]

CVE-2026-89811: drm/amdkfd: Add TLB flush after MES queue eviction/suspension

stable/6.1 was fixed.

Fixed status
stable/6.1: [750cd793ee69c27faf17fb9c49f92f71716bbc8b]

CVE-2026-89813: drm/amdgpu: force complete the KIQ ring fences on reset

stable/6.1 was fixed.

Fixed status
stable/6.1: [83c54ed3be2f71a21e0f12ce5ca64435e33ba440]

CVE-2026-89832: f2fs: fix to clear dirty flag on folio in error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e0d9a317ce2cae3768626599d857bb3f0fd96fc]

CVE-2026-89833: f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

stable/6.1 was fixed.

Fixed status
stable/6.1: [64a47dc8286ff98d8c231ae035bdfe16be1b93bf]

CVE-2026-89834: f2fs: fix to migrate all curseg types during free_segment_range

stable/6.1 was fixed.

Fixed status
stable/6.1: [7ffac0deea2d84cf79051f16fed8e215c4bcf0e6]

CVE-2026-89835: f2fs: avoid NULL checkpoint thread access in sysfs

stable/6.1 was fixed.

Fixed status
stable/6.1: [54196bcfde998fb37009f50e0ef16498f651f0f9]

CVE-2026-89837: f2fs: fix dentry folio leak in find_in_level

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [d2011b371fcb9247b2ef4ea2d852401a6c82ab88]
stable/6.1: [3b8593f7965fcb22672d98b55ae2e9410ea3d9f7]

CVE-2026-89838: f2fs: limit recovery filename logging to stored length

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b8ac8b14b9d92dd2e1cb05fa8994f41f701fbf28]
stable/5.15: [450ab2e5dbe0ef6e3ed73214256565f6f003d62a]
stable/6.1: [3d02c7c8446f5d6793ac67f93bf3f84bf24e3f25]

CVE-2026-89840: f2fs: validate MOVE_RANGE destination size

stable/6.1 was fixed.

Fixed status
stable/6.1: [454de20a5a36c000b75f49337aae8c92045c5242]

CVE-2026-89848: scsi: qla2xxx: Quiesce response IRQ before freeing request queue

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [730a18768b27582636b5af343069c30809b763a2]
stable/5.15: [be68aef64ab2e633867c4ac946d16644c306fc3d]
stable/6.1: [0a005dcc5e9bf7b31a45422b10f2765b25161389]

CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [eeef4fa993b3f962de9b45999f12ff25a5c79ce7]
stable/5.15: [504b177ad58c45be7e1cfa81f9b42f7f040737c5]
stable/6.1: [c3e4c716909a053391b06a9a816c8588b652e3d2]

CVE-2026-89860: scsi: qla2xxx: Initialize NVMe abort_work once at submission

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6ee4e3774349fa04bba13e668f3322db47d89b08]
stable/5.15: [55259e225412721c3cc09e4d95a489542c0c05b0]
stable/6.1: [17d9011c96f819e69074f465c04ee79e693de6a1]

CVE-2026-89870: media: zoran: Avoid freeing a registered video_device twice

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [29792762e65d4eefbe75b6048c59763fd844191a]
stable/5.15: [99277a387802eb6c1907c73f09d746908cc64913]

CVE-2026-89877: media: saa7164: fix cleanup on resource allocation failure

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ac9d7ca8199c64c320ba8177e3c0f7b0deb7ff06]
stable/5.15: [99bf01e2563f8bdfe5f25e489596cff455a35d6b]

CVE-2026-89884: media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup

stable/6.1 was fixed.

Fixed status
stable/6.1: [c49e8097815463199f42304438038e90b02ba7c5]

CVE-2026-89912: KVM: arm64: vgic-its: Don't dereference a NULL
collection on ITT save

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [df829e4fe235b3a0dbf830986d81c040d3d2e940]
stable/5.15: [0fb71211146e39cf67811ccb873d2770a9c129ac]
stable/6.1: [566d0f99aec92280ce403f22068eb07241a79e2a]

CVE-2026-89920: KVM: s390: Fix memory corruption by not reinjecting CK
machine checks

stable/6.1 was fixed.

Fixed status
stable/6.1: [045f3e95a0deccb277c29bd003e1d43c0ad40c90]

CVE-2026-89921: KVM: s390: Zero initialize data structures for
inject_pfault_token

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3da26db3323cbccf509005fdbc4ebae842d323cd]
stable/5.15: [5b0ae4443383fbacd905522f0c95ad6c85a3b43e]
stable/6.1: [7090818ba774d254eba80979c2d4da23d91de02f]

CVE-2026-89926: KVM: s390: Fix length check __import_wp_info()

stable/5.10 was fixed.

Fixed status
stable/5.10: [36d62dfb3cac66e6a97fd850a592c2ed56e35ba5]

CVE-2026-89930: KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

stable/5.10 was fixed.

Fixed status
stable/5.10: [b577a7cd6d984dd430af88ee1c9e03da71b73ee0]

CVE-2026-89933: iio: pressure: dps310: fix NULL pointer dereference on
ACPI probe

stable/6.1 was fixed.

Fixed status
stable/6.1: [37e59123a5f1dc9030825685074819f8318153b9]

CVE-2026-89934: iio: light: ltrf216a: fix runtime PM reference leak in
error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [a065b8b596d23de4b2e108d78ba34d17e723c865]

CVE-2026-89944: ASoC: hdac_hda: Fix hlink refcount leak on component
registration failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [1c2625fbdeb17376f76c57b7669e6aa6500a7149]

CVE-2026-89955: s390/vfio-ap: Fix NULL deref in status_show() during queue probe

stable/6.1 was fixed.

Fixed status
stable/6.1: [10606c9af18baed75cd180b96ee695441aa15134]

CVE-2026-89956: s390/vfio-ap: Fix missing lock required to access list
of ap_matrix_mdev objects

stable/6.1 was fixed.

Fixed status
stable/6.1: [3ea443510739468238324234eaab0d37922283f5]

CVE-2026-89958: s390/vfio-ap: Fix dereference matrix_mdev->kvm without
checking for NULL

stable/6.1 was fixed.

Fixed status
stable/6.1: [2fbe430fe40bc5adb7e439d0136d2c5fe34613ba]

CVE-2026-89960: s390/vfio-ap: fix stale pqap_hook pointer on error in
vfio_ap_mdev_set_kvm()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6b7b166d5310fa3e4d5802c4177a0264d9140bd]

CVE-2026-89962: powerpc/kexec_file: Prevent kexec range truncation

stable/6.1 was fixed.

Fixed status
stable/6.1: [1b9f9d566a5826da373dce7fe8958a4f23e86019]

CVE-2026-89972: nvme: add missing SRCU grace period in error path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [037e71058e8a59568db72015d4386f54e54dff77]
stable/5.15: [7f180cef9f3421ece85c43bfdc326ce5875845bb]
stable/6.1: [da710ec2a70a85de73afd4f7869b234fd9ede49e]

CVE-2026-89975: nvme-fabrics: fix DHCHAP secret leak on parse failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [35ec48228f6739339583e5a73ca315156372e30d]

CVE-2026-89980: ALSA: harmony: initialize locks before requesting IRQ

stable/5.10 was fixed.

Fixed status
stable/5.10: [00fee94390e90c2e4db0a502bd1e2ea7f0b795b9]

CVE-2026-89987: mm/huge_memory: transfer the pmd dirty bit to the folio on zap

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [79d8c89baa10612c1675972a632c65cdbe0936f6]
stable/5.15: [13f4910d81b62a214cdb28b47237198fa96078a2]
stable/6.1: [7a4c3f7b47ba34b021a7747081f330bfb76a4271]

CVE-2026-89988: kprobes: Protect kprobe_blacklist with RCU

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3fb8386682ef4d0858c38bf0d8d8a47ba171fa23]
stable/5.15: [5d97a13defc648c64d138145ace429b6a3d08943]

CVE-2026-89995: dma-direct: return struct page from dma_direct_alloc_from_pool()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1ca96bbfef42bbfb139cc6eb1d940c8ca9046f95]

CVE-2026-89996: dma-buf: dma-heap: don't publish fd before
copy_to_user() succeeds

stable/6.1 was fixed.

Fixed status
stable/6.1: [1953ef8d11eb5870fe621259708a90900bead272]

CVE-2026-90002: ftrace: Take trace_array reference before accessing
its ftrace_ops

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0124b36a7eac1dd0402146fc6c1f732877b9cd9f]
stable/5.15: [ffe16fe221e25cd1915602e6753c3d3285ed9a98]
stable/6.1: [8f062a6bfeb4b4e18d469a673aec23a7b73c3e8a]

CVE-2026-90013: tracing: Take trace_array reference when opening options file

stable/6.1 was fixed.

Fixed status
stable/6.1: [a6e15eadfdb6de30c24ef21b31f39a86359f4ab5]

CVE-2026-90016: staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0c1f8bada613edbd810d010996d36159092576d5]
stable/5.15: [55034fa38bd8b302ceb32c15e8a98298f56f629b]
stable/6.1: [a8d76480d1abbbf617c2d6d9f60bf95ab45cff04]

CVE-2026-90021: usb: gadget: f_midi: initialize work in f_midi_alloc()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c76e82b026a28c348e5d841922aa73db36eca1d3]

CVE-2026-90023: usb: gadget: f_mass_storage: fix null pointer
dereference in fsg_common_set_num_buffers()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [38edd187a37db0d8e4bf84cc954dbdbe7bfa366f]
stable/5.15: [e54820b9dc1d6d731ecc3e51462445dc952906a7]
stable/6.1: [5d56dbaeb81d5cd967cdee8ddcc70814b7139246]

CVE-2026-90029: usb: storage: realtek_cr: fix use-after-free on disconnect

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [f98c2f119fcd81cfede114d2fd3463a17aed8209]
stable/6.1: [0935e57ede003bbe35de9c5d6a49260999ca0314]

CVE-2026-90037: NFSD: Prevent client use-after-free during close_lru reaping

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d721729762a413015864b2a56d7fb86fb8efa9f]

CVE-2026-90041: HID: sony: clean up device list on probe failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [41d92c2e02788c04663b11335454b094dc4672bc]

CVE-2026-90044: usb: gadget: f_fs: Fix Use-After-Free in AIO error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [922a29e1f8573fd405eea1a73a52112c4e7fcfc4]

CVE-2026-90045: USB: gadget: ffs: fix mm lifetime handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [68895e50c2250d9edd6e0a5967bf351221fd88b4]

CVE-2026-90048: fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

stable/6.1 was fixed.

Fixed status
stable/6.1: [3a38f3c71bcd9bd58d86489c364bd29a4c2c860e]

CVE-2026-90061: netfilter: nf_tables: skip double clone set
expressions on element insert

stable/6.1 was fixed.

Fixed status
stable/6.1: [109bf28a90ac365ec4d25622c50959bb43b35ed4]

CVE-2026-90066: samples/ftrace: Fix kthread_stop() on ERR_PTR in
ftrace-direct-multi-modify

stable/6.1 was fixed.

Fixed status
stable/6.1: [02866f063062dcc5686445c738be003de9787250]

CVE-2026-90076: net/sched: fq: add overflow bounds to quantum and
initial quantum

stable/6.1 was fixed.

Fixed status
stable/6.1: [cf398f67d9caa71af3b9fb9319058b22fe6b524e]

CVE-2026-90083: net/sched: act_ife: Only operate on Ethernet frames

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c07621770b04f19b67e3af4a24b4d447826fbdd]

CVE-2026-90084: octeontx2-vf: fix workqueue and netdev race in probe/remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [4a4b53231b77986ce55b38122174222c86416de7]

CVE-2026-90087: Bluetooth: do not leak an hci_conn when a second LE
connect is rejected

stable/6.1 was fixed.

Fixed status
stable/6.1: [42fe0278d05d75c405abad62dafaeec713cec2e2]

CVE-2026-90093: Bluetooth: L2CAP: access chan->conn safely in get/setsockopt

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c66cd500ba1a58b3798c468fcc774ed2c8c2ec7d]
stable/5.15: [737b80c97aef10404a9beed7c0ed45fcd5fc5931]
stable/6.1: [0d7b7b31ea092e17d757bd24e2e9028ba5e3a4ca]

CVE-2026-90097: Drivers: hv: vmbus: Skip VMBus module cleanup for
non-nested root partition

stable/6.1 was fixed.

Fixed status
stable/6.1: [321f650493d6b8169dacd4d5d6f63550dce54d6c]

CVE-2026-90099: net/sched: account classifier filter allocations to memcg

stable/6.1 was fixed.

Fixed status
stable/6.1: [8a622d5b4d81c1572f42bbf3fb823b6e63d44dae]

CVE-2026-90104: NFSv4.1: zero referring call lists before decoding

stable/6.1 was fixed.

Fixed status
stable/6.1: [810f6b3a29ac96fdc16909132b31627dae6824c2]

CVE-2026-90105: vxlan: fix reading neigh ha

stable/6.1 was fixed.

Fixed status
stable/6.1: [a1e86c5b4463178751a9fd3f0a3876a602dc360c]

CVE-2026-90106: net: bridge: arp/nd proxy: fix reading neigh ha

stable/6.1 was fixed.

Fixed status
stable/6.1: [2365b25b4add42bb5f652920b45bc9ad0e35cbc7]

CVE-2026-90109: net: sched: fix 32-bit backlog wrap in gred, bfifo and
plug enqueue

stable/6.1 was fixed.

Fixed status
stable/6.1: [771a1123570b487765bcf2d4cff3567e66bf1322]

CVE-2026-90111: ip6mr: do not clone dst in ip6mr_cache_report()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b50d3cfb8513e895cee453dd0f834deee6ccc231]

CVE-2026-90112: net: qlcnic: validate unified ROM sections before loading

stable/6.1 was fixed.

Fixed status
stable/6.1: [ad6cceee7aca7762f90f155480c2cd8d11ec6914]

CVE-2026-90116: ALSA: mtpav: shut down output timer before card teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [a9435a1f14a6f9520452617343ea59bb35ba9e79]

CVE-2026-90125: smb: client: fix request buffer leak in smb2_new_read_req()

stable/6.1 was fixed.

Fixed status
stable/6.1: [38daae149c2102d96833cc6acd79c8f98fcce208]

CVE-2026-90135: net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0859020cab4ea6101478141aeec1b052ed80bdd]

CVE-2026-90138: vsock: don't check the listener's sk_err in vsock_accept()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c99d12052f663d9914bc944302fee5a1d50d8ca5]

CVE-2026-90139: fuse: check for NULL root inode in fuse_fill_super_submount

stable/6.1 was fixed.

Fixed status
stable/6.1: [4844aeb0de5fb0de4f7c9aaf2bf05cb8cffe60d5]

CVE-2026-90146: bpf, xdp: move offload check into dev_xdp_install()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4a0467819bc2423be8fc4c9834e8f42af2af0861]

CVE-2026-90148: NFSv4: Fix incorrect argument passed to
nfs4_delete_lease() in nfs4_add_lease()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c951b876cccd8a4e21fe8b9712894f6a2513ddbc]

CVE-2026-90149: NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

stable/6.1 was fixed.

Fixed status
stable/6.1: [e55d7fec8a9290f73032ee34c35dd68532809633]

CVE-2026-90150: pnfs/blocklayout: Fix device leaks on parse failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [710ae187a5d490a894054d17645cf5c83d37dfbf]

CVE-2026-90152: smb/server: fix session leak in ksmbd_session_register()

stable/6.1 was fixed.

Fixed status
stable/6.1: [869807cdd5599c289c21d40f36a504d72a0d23c6]

CVE-2026-90153: ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

stable/6.1 was fixed.

Fixed status
stable/6.1: [930dcdd888eabf166589e020dcbf6d15b5e13305]

CVE-2026-90155: ksmbd: detach blocked lock requests before freeing

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e8b69c06bd6583ec11abef4fae50c2c8d5f3679]

CVE-2026-90156: ksmbd: safely discard unregistered deferred locks

stable/6.1 was fixed.

Fixed status
stable/6.1: [aaa51ac0d934cb4e2ab96e150fccc934e822009b]

CVE-2026-90161: erofs: fix interlaced ztailpacking pclusters

stable/6.1 was fixed.

Fixed status
stable/6.1: [b634286a8628155557a4f473a9dbab18bb439a7b]

CVE-2026-90162: ksmbd: defer publishing granted locks to prevent
UAF/double-free race

stable/6.1 was fixed.

Fixed status
stable/6.1: [f1371a140722c1d6868f9acf69d601de7d4142bf]

CVE-2026-90166: smb/server: fix null-ptr-deref in
ksmbd_ipc_tree_connect_request()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d601be98c9445894c759c28d4a7a52151387f1fb]

CVE-2026-90167: ksmbd: serialize oplock close with pending break ownership

stable/6.1 was fixed.

Fixed status
stable/6.1: [02a31a30ccd09f3ff35ab5861c04209c381aa5dd]

CVE-2026-90169: ksmbd: free preauth sessions on connection teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [1f60a88b2e0203e50f65b0fb9c32ecb0ae0aa683]

CVE-2026-90174: ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

stable/6.1 was fixed.

Fixed status
stable/6.1: [792dd35013427995e742c7928ef5b564434a4321]

CVE-2026-90179: apparmor: fix deadlock in complain-mode change_hat

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb8ac089815dc192d891294cf0ffeeafd910136a]

CVE-2026-90182: blk-iocost: clear delay state when freeing policy data

stable/6.1 was fixed.

Fixed status
stable/6.1: [6942cb740fb17b24731728b25994eba361776011]

CVE-2026-90183: blk-iolatency: clear delay state when freeing policy data

stable/6.1 was fixed.

Fixed status
stable/6.1: [27573278b1cbc2313ebd31309ac18ac6179b828a]

CVE-2026-90187: null_blk: free zones array on device power-off

stable/6.1 was fixed.

Fixed status
stable/6.1: [26d21585caa61c30d0f3044a1e6d172456148c9f]

CVE-2026-90200: fs/ntfs3: fix integer overflow in MFT cluster validation

stable/6.1 was fixed.

Fixed status
stable/6.1: [8ecb1525a9520acd3d5ea3e2593e487fd9f143ce]

CVE-2026-90204: ocfs2: validate DIO orphan slot during inode read

stable/6.1 was fixed.

Fixed status
stable/6.1: [b5fcd0aa818e08ede9a1d705ffadb0a19b565ebc]

CVE-2026-90205: ocfs2: validate orphan slot during inode read

stable/6.1 was fixed.

Fixed status
stable/6.1: [edd76be702c0f8702472888425237fb9219e1c43]

CVE-2026-90206: nvmet: fix max_qid race between configfs and
controller allocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [cae0f5ed6ce7af3f7e0003c417f1953a350f55bf]

CVE-2026-90208: clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

stable/6.1 was fixed.

Fixed status
stable/6.1: [9c97311a5f5d388eece66fc415167b38f35fe6a1]

CVE-2026-90213: firewire: core: fix memory leak in error path of build_tree()

stable/6.1 was fixed.

Fixed status
stable/6.1: [026b44ad1037a89da04e9985246376c7adb52be6]

CVE-2026-90220: ALSA: seq: Don't leak the extension cell pointer in
the bounce payload

stable/6.1 was fixed.

Fixed status
stable/6.1: [c92b2e6e418a3885758438dddcead6e954a9e095]

CVE-2026-90229: nvme-apple: Destroy the admin queue on removal

stable/6.1 was fixed.

Fixed status
stable/6.1: [97cb6867c9f6de75905b361abfeba136a3d3d120]

CVE-2026-90232: amt: Don't support cross-netns setup.

stable/6.1 was fixed.

Fixed status
stable/6.1: [2a5a578d2e13d2dd6c1b272be7cfa0a6dd64552c]

CVE-2026-90234: NFS: Return a delegation the client fails to record

stable/6.1 was fixed.

Fixed status
stable/6.1: [61b23f482b2082e77d2f78bd1624f93a12ec35ce]

CVE-2026-90235: sunrpc: xprtsock: annotate shared socket callbacks
with READ_ONCE/WRITE_ONCE

stable/6.1 was fixed.

Fixed status
stable/6.1: [6b79b5a0f1c566f0aa6e08c7981826015a0acc4d]

CVE-2026-90247: bpf: Fix mmap_lock leak in irq_work path

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6d091873e12d1de36d7228c4f452e6cace3a23e]

CVE-2026-90250: bpf, cgroup: Fix storage null-ptr-deref after replacing prog

stable/6.1 was fixed.

Fixed status
stable/6.1: [85785e7e2ebddcaa5c3b31bd3bcd83ae648985d4]

CVE-2026-90259: btrfs: qgroup: fix a wrong length calculation in
qgroup_free_reserved_data()

stable/6.1 was fixed.

Fixed status
stable/6.1: [036e6c216be66a085da3a0519f1be5f3230b6e26]

CVE-2026-90263: btrfs: check if root is readonly when setting posix acl

stable/6.1 was fixed.

Fixed status
stable/6.1: [f3e6b504a79d8e90bb7aa8a03a42dc2b51dcc4c4]

CVE-2026-90264: btrfs: always wait for ordered extents to avoid OE races

stable/6.1 was fixed.

Fixed status
stable/6.1: [fa9f6e1958bb05b8a660d9cf2b6f51dee0077290]

CVE-2026-90265: btrfs: defrag: fix deadlock between defrag and
delalloc space reservation

stable/6.1 was fixed.

Fixed status
stable/6.1: [046396bd16fdf0a9fbdf5f04c6eda26024e7695e]

CVE-2026-90267: scsi: sd: Fix special_vec mempool leak when
scsi_alloc_sgtables() fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [05bc68669549bfddfdeef2fd119855cab3e9615a]

CVE-2026-90273: coresight: etm4x: missing
cscfg_csdev_disable_active_config() in perf enable

stable/6.1 was fixed.

Fixed status
stable/6.1: [f097b6969e9961365358fc5ba5892db2f284f020]

CVE-2026-90289: drm/amd/display: Resize MST HDCP per-connector arrays to 32

stable/6.1 was fixed.

Fixed status
stable/6.1: [1c22294c7d9b3b1c26a18ca4eca8c863a5a0d907]

CVE-2026-90300: bpf: Clear buf on error in __bpf_get_task_stack

stable/6.1 was fixed.

Fixed status
stable/6.1: [5c4c57a277a87ed235183d03b671d346f5101f62]

CVE-2026-90301: ocfs2: o2hb: quiesce negotiate handlers and timeout work

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed3c9aebd6bb5aa6ccc2a9177fab7a87ae895715]

CVE-2026-90308: RDMA/erdma: Hold QP references for AE and CM processing

stable/6.1 was fixed.

Fixed status
stable/6.1: [92101d7bd67cf313d65baede27118614a283f6bf]

CVE-2026-90311: thermal: hwmon: Remove hwmon class device along with its parent

stable/6.1 was fixed.

Fixed status
stable/6.1: [e67dad2cff9e4fedce69e752d515ef651d745a90]

CVE-2026-90313: bpf, cgroup: Fix invalid storage access after
__cgroup_bpf_attach failed

stable/6.1 was fixed.

Fixed status
stable/6.1: [217b257d2c39e8dc32d691e8952f3cd921a80233]

CVE-2026-90322: ocfs2/cluster: keep heartbeat local node stable

stable/6.1 was fixed.

Fixed status
stable/6.1: [d429482a67df16a30afaf9a3f1fe239fe73b44de]

CVE-2026-90328: HID: steam: Reject short reads

stable/6.1 was fixed.

Fixed status
stable/6.1: [304b24432c7ab40d63cd698729a7305c3b8eada2]

CVE-2026-90330: HID: logitech-hidpp: Fix FF device cleanup on init failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [a265fee3d24bd611783fd929582b7b6d62000a65]

CVE-2026-90335: tty: skip cdev_del() when no cdev is registered

stable/6.1 was fixed.

Fixed status
stable/6.1: [6c92b8d9c23a92f85b20bee3578d0f19cd1b1a68]

CVE-2026-90336: serial: core: clear freed pointers on
uart_register_driver() failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [5e260edd28eddc3b92c9f578df3026fd11c710cf]

CVE-2026-90337: serial: core: do fallible allocations before the
console can be registered

stable/6.1 was fixed.

Fixed status
stable/6.1: [be61f56c4f0ed1cbf16c5f7b0dec6d6414993dd4]

CVE-2026-90343: wifi: cfg80211: stop PMSR before P2P and NAN teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [af158188ef7b4e89d0a3c04680a98d90b3822ec5]

CVE-2026-90345: wifi: brcmfmac: fix P2P action frame handling without device vif

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb01b8c85682e531516adf6fb632bf2ccb67ec1d]

CVE-2026-90346: wifi: nl80211: clean up color-change beacon data on errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [62f8c28a0fb08611e1278ab2af964550e22aac3c]

CVE-2026-90347: arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

stable/6.1 was fixed.

Fixed status
stable/6.1: [a9e7743b1067ea38c4ad2665d40c3c4a920ad9a9]

CVE-2026-90358: bpf, x86: Fix trampoline stack size for 128-bit arguments

stable/6.1 was fixed.

Fixed status
stable/6.1: [2189232984b45ac8281c80484ab9f67b380a2ca1]

CVE-2026-90365: wifi: mt76: cancel reset and rc work on device unregister

stable/6.1 was fixed.

Fixed status
stable/6.1: [13f230b8e3335ed761986fcd6b04049ff06471eb]

CVE-2026-90368: wifi: mt76: mt7915: unwind state on add_interface failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [09f3dced52c22d9b20f356b01986c5ea0f446cea]

CVE-2026-90375: wifi: mt76: fix non-AQL packet accounting for MLO stations

stable/6.1 was fixed.

Fixed status
stable/6.1: [f94842ee088744a9e4b3b3ce4c91e897c4e72aba]

CVE-2026-90383: misc: sgi-gru: remove interrupt-context page-table walks

stable/6.1 was fixed.

Fixed status
stable/6.1: [0ca505b973aa1a5e3fcca7bd04774e794ff5e662]

CVE-2026-90385: md/raid1: create serial pool adding rdev to array with
serialize_policy=1

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ea458171bed2b706dc7bcd80b15356c0e9ed718]

CVE-2026-90392: bpf: Fix potential UAF when reading bpf link info

stable/6.1 was fixed.

Fixed status
stable/6.1: [4c8432a332d4a24dc2742f56062a53d8fad36f53]

CVE-2026-90398: wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()

stable/6.1 was fixed.

Fixed status
stable/6.1: [deb14c9932509c0defaa0620c9ca8d20b385a6bd]

CVE-2026-90407: wifi: ath11k: fix overreads in
ath11k_wmi_process_csa_switch_count_event()

stable/6.1 was fixed.

Fixed status
stable/6.1: [57e77a6d900e5bc6e73ccd3ee1ba3bce834c9dde]

CVE-2026-90410: spi: davinci: switch to managed controller allocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [2382f18daa4303923d66526db984e9a38074a312]

CVE-2026-90417: RDMA/cxgb4: Fix dereg_skb leak and double free in
write_tpt_entry()

stable/6.1 was fixed.

Fixed status
stable/6.1: [26c6e9bc0b907b880c5d8486291f0452c8227fbe]

CVE-2026-90418: nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty
state mismatch

stable/6.1 was fixed.

Fixed status
stable/6.1: [6879c603a8d07af82da83768cc2342a11bd444e5]

CVE-2026-90421: PCI: Fix UAF when probe runs concurrent to dyn ID removal

stable/6.1 was fixed.

Fixed status
stable/6.1: [74133e74619d108eeaaa787d78906314d7a7b077]

CVE-2026-90433: spi: oc-tiny: switch to managed controller allocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [a2f1c58864fc3612c230a9d5cc1929e1ffe348ac]

CVE-2026-92480: scsi: ufs: core: Validate string descriptors

stable/6.1 was fixed.

Fixed status
stable/6.1: [22c076f72ad67d89dab58d9c97a17c33e8130e82]

CVE-2026-92482: pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

stable/6.1 was fixed.

Fixed status
stable/6.1: [13a25cb4f0f0863afded5e915cb3bceede221426]

CVE-2026-92485: bpf: Fix WARNING in bpf_tracing_link_release

stable/6.1 was fixed.

Fixed status
stable/6.1: [1757598b3804f7cb35b5b5e02558f6d8b9c2f254]

CVE-2026-92488: RDMA/erdma: complete object teardown when the destroy
command fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [4f5cd6a2081ec956db25b8e9f71d052f68d522c7]

CVE-2026-92490: firmware: arm_scmi: Unrequest devices if driver
registration fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [35a36fbbc985135f0d35a89d7f9d035ffc499d6e]

CVE-2026-92503: ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e5e883ffe5230320060ea613a1acf750f3161c95]

CVE-2026-92506: firmware: arm_scmi: Fix requested device removal race

stable/6.1 was fixed.

Fixed status
stable/6.1: [803e50af43ab1c3f76cbc744e496532ec151f305]

CVE-2026-92520: bpf: Zero queue and stack outputs on lock failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [6468e8ac026b44ae2a78114b80f9d1b9164d0f6c]

CVE-2026-93042: dmaengine: dw-edma: Terminate all descriptors without callbacks

stable/6.1 was fixed.

Fixed status
stable/6.1: [da56839aced48ecb70033962d7ea98f55b0c5656]

CVE-2026-93058: drm/msm: Only fini scheduler after successful init

stable/6.1 was fixed.

Fixed status
stable/6.1: [20ea0ae8e90702acca83467207db4c9bd8c8bd03]

CVE-2026-93062: wifi: iwlwifi: guard against division by zero in
iwl_dbg_tlv_alloc_fragments

stable/6.1 was fixed.

Fixed status
stable/6.1: [897097eec925fbecdb1f8698b9e7bacb501a5b64]

CVE-2026-93081: firmware: arm_scmi: Fix SCMI device destroy lifetimes

stable/6.1 was fixed.

Fixed status
stable/6.1: [afe5c022a180e0ade394d3fffbafc1a701f50993]

CVE-2026-93084: firmware: arm_scmi: Drop handle on protocol bind failures

stable/6.1 was fixed.

Fixed status
stable/6.1: [b5377e690cd4fe87ee52fcf067c9929414ea8f4e]

CVE-2026-93085: firmware: arm_scmi: Reject out of range DT protocol IDs

stable/6.1 was fixed.

Fixed status
stable/6.1: [75d6273a28cdb543a167ac5fbfca75dc286ffe10]

CVE-2026-93086: firmware: arm_scmi: Avoid IDR updates while cleaning channels

stable/6.1 was fixed.

Fixed status
stable/6.1: [f50698c617350a6e2064dffd6cff3f391e142f55]

CVE-2026-93089: firmware: arm_scmi: Free transport channel on IDR failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [10fae57504ee0ef791d145278b339184cd9db45f]

CVE-2026-93092: firmware: arm_scmi: Unregister device notifier before
IDR teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [3ec1f79e912fa0e1c119753c819eb3c2591e71b7]

CVE-2026-93093: firmware: arm_scmi: Publish channel state before callbacks

stable/6.1 was fixed.

Fixed status
stable/6.1: [9d349c7b2392b1196e10421421ea9a09fcc5d3cc]

CVE-2026-93100: fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

stable/6.1 was fixed.

Fixed status
stable/6.1: [906b3044dbf7c38cc411f7cf457c811363161e3b]

CVE-2026-93104: RDMA/rvt: Return NULL after port allocation failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [32d2cdb0f3cac430b04124c3b7248851fe2037f8]

CVE-2026-93105: esp: do not unref managed frag pages in esp_ssg_unref()

stable/6.1 was fixed.

Fixed status
stable/6.1: [cb375965800d474c0281a2e92c43c724fce9f463]

CVE-2026-93116: platform/x86: asus-wmi: fix resource leaks on probe failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [72d792c8053f238ae541fdaa90e609548509b65f]

CVE-2026-93122: usb: gadget: uac: validate rate list length before storing

stable/6.1 was fixed.

Fixed status
stable/6.1: [30b3b3494000aa01fc8f08bf07ed503c9fde4895]

CVE-2026-93125: bpf: Reject rdonly/rdwr_buf_size kfunc arguments that
exceed u32 max

stable/6.1 was fixed.

Fixed status
stable/6.1: [00bb52be60da16cd5ead4eb9f8ddc9a66d003ff2]

CVE-2026-93128: platform/x86: lg-laptop: Fix LED resource handling

stable/6.1 was fixed.

Fixed status
stable/6.1: [4f9f1448dac4927ce5160f3a4a295e08fb969d32]

CVE-2026-93129: platform/x86: dell-wmi-base: Fix handling of ultra
performance key

stable/6.1 was fixed.

Fixed status
stable/6.1: [ef16f467393ca1a15ec8431fba5e67dd6071074e]

CVE-2026-93146: time/namespace: Validate nanosecond field in
proc_timens_set_offset()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ce0dd307dfa3193fbf06371b7c819a6bff7d3d68]

CVE-2026-93150: cgroup/cpuset: Make nr_deadline_tasks an atomic_t

stable/6.1 was fixed.

Fixed status
stable/6.1: [4987d336abf3fa575a2d953f69e11154ac9802c3]

CVE-2026-93155: crypto: keembay - Fix AEAD unregister count in error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [ccfaccc35e5a911ec1748291ea505e03b1ac03d9]

CVE-2026-93163: hwrng: core - fix rng list on registration error

stable/6.1 was fixed.

Fixed status
stable/6.1: [30b2cc2966dac87ee95a99c49e28486c2a8129cd]

CVE-2026-93168: dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

stable/6.1 was fixed.

Fixed status
stable/6.1: [4237b5cc181a17f5a2a797655c1ce2c64e01c550]

CVE-2026-93172: mm/mm_init: handle alloc_percpu failure in
free_area_init_core_hotplug

stable/6.1 was fixed.

Fixed status
stable/6.1: [eb872b92e26c2576742d541e45f28b50af059b8b]

CVE-2026-93174: bpf: Copy per-CPU map value padding in copy_map_value_long()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0653c8f718109d140e806daac166c43e2b2b8bd]

CVE-2026-93175: drm/amd/display: Fix dangling pointer in CRTC reset function

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c311d5fcfcd4e83c1aeeb4fccb04861be3357a9]

CVE-2026-93176: drm/amd/display: Fix dangling pointer in plane reset function

stable/6.1 was fixed.

Fixed status
stable/6.1: [154883749cae674fb38e83c1b3a096ce71122229]

CVE-2026-93179: drm/amd/powerplay: fix VoltageObjectInfo zero-stride
loop and OOB read

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ed84504713e8357f33693f638fda68fc98f0c9d2]
stable/5.15: [86644d37d2b388854b2cfd4d4f57b3d84a57154b]
stable/6.1: [e5b3c485ef911358752a3abbf3705d05d0eafd7a]

CVE-2026-93186: cxl/mbox: Clamp mailbox output allocation to the payload size

stable/6.1 was fixed.

Fixed status
stable/6.1: [123f6d154253939ce38f0ec0b6d1ba67f870e01f]

CVE-2026-93192: drm/v3d: Clear queue->active_job when v3d_fence_create() fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [dc0fba19ef518920073d1d639317b2dd8266fe5e]

CVE-2026-93196: nvdimm: virtio_pmem: refcount requests for token lifetime

stable/6.1 was fixed.

Fixed status
stable/6.1: [71ac70fc7f95963eca9d1145a9b02b8fe149eb4f]

CVE-2026-93199: i3c: master: Do not treat master device as a duplicate target

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3728d90ec66d4ad33d357e7d6e82b02d34e1c99c]
stable/5.15: [6f2340857fc206e7ebfc50c568fb65c3055e568b]
stable/6.1: [d72a5e9060030a1c205b54157c15a428b741d83f]

CVE-2026-93200: i3c: master: Fix use-after-free of master->this

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a9b9cae0bd887ef0d438887f20b0a417491e45f0]
stable/5.15: [94af669037d129914828a851d8b2a79b4537b73f]
stable/6.1: [e766605a0490723df7b61e6abd0c392889732dd7]

CVE-2026-93202: i3c: master: Fix recursive locking during device registration

stable/6.1 was fixed.

Fixed status
stable/6.1: [015fcf330c29803bbf92b719b4889ba74ecbbc71]

CVE-2026-93205: iommu/arm-smmu-v3: Manage teardown with devm

stable/6.1 was fixed.

Fixed status
stable/6.1: [041b5e2a2a31c62049af30c5716099eebab86cb8]

CVE-2026-93208: kasan: fix cache shrink race with CPU hotplug

stable/6.1 was fixed.

Fixed status
stable/6.1: [eab61c0781cbe899e074c0009af304f3b337e0c9]

CVE-2026-93228: svcrdma: Reject Write/Reply chunks with segcount 0

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac730b8cbaeec6831116e1455d909ecbdcdcbd34]

CVE-2026-93231: lockd: fix swapped arguments in nlmsvc_match_ip()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e7124d223c5a2dfb4c1a7b2eea24375edc355a10]
stable/5.15: [68282cbc197b280711f66c4cf05165f911785bcc]
stable/6.1: [cfbf21d21aea1a83d5ff38d50466a655e0a6a31d]

CVE-2026-93239: arm64: mm: Fix the lockless page-table walk in show_pte()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b8f06b73ad146d84a33c124563c93eeef4f5b674]
stable/5.15: [b3535b6cb2c48f97b8c3378eb9ea12538425bf14]
stable/6.1: [e1b06278a7e241da0cd3187871e67255f956d184]

CVE-2026-93243: mm/secretmem: properly account locked pages

stable/6.1 was fixed.

Fixed status
stable/6.1: [37fd10e3d079bccf348180ff0bdac074d84ff31f]

CVE-2026-93244: drm/sysfb: simpledrm: Improve stride validation

stable/6.1 was fixed.

Fixed status
stable/6.1: [f69b81d1f70573ba68685a0a0a197613f5efc7cd]

CVE-2026-93251: ACPI: bus: Introduce acpi_bus_get_primary_device()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f912f88126e385f6cfcd1a28de73afb7d3943c8d]

CVE-2026-93260: powerpc/xive: propagate IPI init errors to prevent
use-after-free

stable/6.1 was fixed.

Fixed status
stable/6.1: [89e1caa5b0aafe23e9938d9a311e9d41baee583e]

CVE-2026-93269: ext4: fix circular lock dependency in ext4_ext_migrate

stable/6.1 was fixed.

Fixed status
stable/6.1: [f204882d5eaca09f7848f081c9c9b5bbf2234895]

CVE-2026-93272: remoteproc: qcom_wcnss: Fix handling the lack of PD
regulators in v3

stable/6.1 was fixed.

Fixed status
stable/6.1: [d5deaa0b6d91b1063055415fc53f75c40c2a077d]

CVE-2026-93282: ksmbd: fix maximum allowed access checks

stable/6.1 was fixed.

Fixed status
stable/6.1: [faf0b894eedc7b2ebb36c48d04d412240dd0ea71]

CVE-2026-93285: f2fs: embed f2fs_gc_kthread in f2fs_sb_info

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f13308f19d710c41a91421ad8a9dce5ed9f82ad0]
stable/5.15: [89c9954739c9b7aaaa1081faa53aa500b734bb93]
stable/6.1: [8592a6238d6071fa22228f151abb002db7383750]

CVE-2026-93786: ksmbd: preserve VFS inherited POSIX ACL mask

stable/6.1 was fixed.

Fixed status
stable/6.1: [8493da704275ca5ab67fb88c0ae7b71576e91951]

CVE-2026-93790: wifi: iwlwifi: mvm: fix out-of-bounds tid_data access
in BA notif

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed9869e64dd7a397a320ae7a37f1e4a36f866f74]

CVE-2026-93791: wifi: iwlwifi: mvm: add a check on the tid coming from
the firmware

stable/6.1 was fixed.

Fixed status
stable/6.1: [03084a2c61838ce6a12f082025cbf9ed869f0492]

CVE-2026-93792: wifi: iwlwifi: mvm: fix a possible underflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [2df7c1843bdc65157bccd6110f005b93bdde39de]

CVE-2026-93793: wifi: iwlwifi: mvm: validate TX_CMD response layout

stable/6.1 was fixed.

Fixed status
stable/6.1: [658b5c00d653cdd72babc86791f6f6711190c740]

CVE-2026-93794: smb/client: flush dirty data before punching a hole

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c9fcab9bf1ef3516983f3de05a19c5658c7a01e]

CVE-2026-93796: wifi: iwlwifi: pcie: null RX pointers after free

stable/6.1 was fixed.

Fixed status
stable/6.1: [847103369489110a222482c7781e0fe62cdbd3d5]

CVE-2026-93804: wifi: mac80211: ibss: wait for in-flight TX on disconnect

stable/6.1 was fixed.

Fixed status
stable/6.1: [47185b5dbac264e7eb48c6d44368be6bfec17085]

CVE-2026-93817: perf: Fix addr_filter_ranges lifetime

stable/6.1 was fixed.

Fixed status
stable/6.1: [a0b1ec3a2daf4d4233fae9b5b8d657b4a5db4df6]

CVE-2026-93823: drm/amdkfd: Let driver decide buffer size at
AMDKFD_IOC_GET_DMABUF_INFO ioctl

stable/6.1 was fixed.

Fixed status
stable/6.1: [d298c100796b2cd1e7e75f8e615b79d034e510f8]

CVE-2026-93828: exfat: fix handling of damaged volume in
exfat_create_upcase_table()

stable/6.1 was fixed.

Fixed status
stable/6.1: [091ca992218105a050af0b863337e02a2d518b2f]

CVE-2026-93829: smb: client: fix races in cifsd thread creation

stable/6.1 was fixed.

Fixed status
stable/6.1: [2376fb3348b4fa72a5158c8a63ff2489e1956541]

CVE-2026-97409: nvme-fc: Do not cancel requests in io target before it
is initialized

stable/6.1 was fixed.

Fixed status
stable/6.1: [0b7c8009b3037722103032c336732d63e0507a51]

CVE-2026-97422: drm/amdkfd: fix SMI event cross-process information leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [b8151aeb4f34e913315058c192f78fea2223f36a]

CVE-2026-97425: drm/amdgpu: fix buffer overflow during vBIOS update

stable/6.1 was fixed.

Fixed status
stable/6.1: [bce28deb42b9e8d368648a002ffe3a6124c482aa]

CVE-2026-97477: RDMA/counter: Fix num_counters leak on bind_qp failure
in alloc_and_bind()

stable/6.1 was fixed.

Fixed status
stable/6.1: [4517686789b404827591c52f79e9a57822371ca0]

CVE-2026-97478: virt: acrn: Fix irqfd use-after-free during eventfd shutdown

stable/6.1 was fixed.

Fixed status
stable/6.1: [dccf23a72a6c5ec8d9eab2a7f98e186af6eaff48]

CVE-2026-97479: driver core: Avoid warning when removing a device
while its supplier is unbinding

stable/6.1 was fixed.

Fixed status
stable/6.1: [3d13785eabc3871bde179f3f17a2b2bef064864a]

CVE-2026-97480: tty: serial: 8250: protect against NULL uart->port.dev
in register

stable/6.1 was fixed.

Fixed status
stable/6.1: [f728f7f38a6eca16923c72fc6826445810d2b41f]

CVE-2026-97493: drm/amdgpu: Bound GPIO I2C table entry count from VBIOS

stable/6.1 was fixed.

Fixed status
stable/6.1: [b12abff6a52d96c4114d7668f790b18f9201c17c]

CVE-2026-97494: drm/amdgpu: validate and share PSP fw_pri_buf copies
via psp_copy_fw

stable/6.1 was fixed.

Fixed status
stable/6.1: [cb755c29d0fa8fa4b0630bf60cf434c30ffdf0c7]

CVE-2026-97500: wifi: rtw89: phy: check length before parsing PHY status IE

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8659bacf9a2a4f33690c573f35bb5b11d06bf12]

CVE-2026-97501: pinctrl: mediatek: paris: bypass pinctrl GPIO layer in
set GPIO direction

stable/6.1 was fixed.

Fixed status
stable/6.1: [f1536772cb3e4aa8d63988051f6fd6e4bb005cf7]

CVE-2026-97505: PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0be4e21287e1e4865b9de498e1acc65b873f52f5]

CVE-2026-97512: spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2540dfa3e63512300ca7575c42e9183a6677f26]

CVE-2026-97518: wifi: cfg80211: reject duplicate wiphy cipher suite entries

stable/6.1 was fixed.

Fixed status
stable/6.1: [539d7f795bf0c41fb533c99e6010cdfaf5a1b6a6]

CVE-2026-97529: scsi: qla2xxx: Validate BSG request_len before reading
vendor_cmd[]

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a0c6842ec825a91693626dbd9a4c54f2b9dc15ea]
stable/5.15: [0540676f5fefdff748b8d57a927b143e31dc21fd]
stable/6.1: [d3762cc777544a4cbc4635a787e1cfc021e1a615]

CVE-2026-97530: scsi: qla2xxx: Fix soft lockup polling continuation
IOCB signature

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [bded2de273c5b0e50e3e23de937260436cd67df2]
stable/6.1: [70df7f03499046da0d28a58ec8b237ed5dfbd0a7]

CVE-2026-97531: scsi: qla2xxx: Skip vport under deletion in report ID
acquisition

stable/6.1 was fixed.

Fixed status
stable/6.1: [d3ac7e0f454c7d52c0c2e5ecaf5a3d938f1b166d]

CVE-2026-97532: scsi: qla2xxx: Null out freed pointers in
qla2x00_mem_alloc() error path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e6732abc33c41772192ef8717354a5574a5c2ebf]
stable/5.15: [aea0901d35beb3acc8a4086fb00c5b9c0e9c83ab]
stable/6.1: [d3dee064ab9d705f6f652c639c55d7ea74df87cc]

CVE-2026-97534: f2fs: accurately adjust free_sections during free_segment_range

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e7a744c9db8c2d33ed6ac2ff9bca9323a38b038]

CVE-2026-97535: scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c73631101e7889c519d4a621cc958f487f8e01a]

CVE-2026-97536: scsi: qla2xxx: Fix use-after-free of qpair work on
queue teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2089647f81ff5263867ec08589f273899016ad4a]
stable/5.15: [bf3f802619eb57cb11c706263dca13255db9f3fd]
stable/6.1: [942ceba876881a57e5157bb30a8a05f99a77ddd8]

CVE-2026-97537: scsi: qla2xxx: Fix queue teardown NULL dma_free and
bitmap locking

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b65e3a82f77b7a63e386623d2ea70d2b5580295a]
stable/5.15: [a9ff85886425355c72749be6090758aa19a89f16]
stable/6.1: [81ee4df2a488f0909f7ff563e88a0e0099485a8b]

CVE-2026-97554: smb: client: avoid using uninitialized SIDs in
cifs_posix_to_fattr()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1915b69e36906968e2b698699d0f219875ae846e]

CVE-2026-97555: smb: client: fix heap overflow in DACL owner/group rewrite

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4e78b5ff13214353750b87283ff79f62510f5844]
stable/6.1: [63c2fbde15ffc9a0c21adf670c38d028e20fa65c]

CVE-2026-97556: smb: client: avoid leaking refcount when cifs_sb_tlink() fails

stable/5.15 was fixed.

Fixed status
stable/5.15: [f1fd8a84181b3af03c508e0b02b4877945dd070a]

CVE-2026-97557: smb: client: avoid leaking refcount in cifs_queue_oplock_break()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [13b9519b19e6e58a6cd01e63062cd1da7bd6449a]
stable/5.15: [0fb92ac85db58945ad7b970ff17674001487b3a3]

CVE-2026-97558: smb: client: fix cifsFileInfo reference leak in deferred close

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [645a7359c1f740152464edf84f1030e0cad42c9d]
stable/6.1: [46d98be6c34a52182ea3c2f849a3ea0e9419eaf2]

CVE-2026-97559: smb: client: fail DACL rewrite when the new DACL exceeds 64K

stable/6.1 was fixed.

Fixed status
stable/6.1: [f033d6e5aadf3e8c6a12873110557ed40cd71388]

CVE-2026-97561: smb: client: honor forceuid/forcegid when mapping SIDs
to uid/gid

stable/6.1 was fixed.

Fixed status
stable/6.1: [89a3b4704af2208e381c55037ff2d1e2365b83e4]

CVE-2026-97564: smb: client: reject userspace cifs.idmap descriptions

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [91da70a2e5c6f54e1316d51e0e6911e78ef5e09a]
stable/5.15: [856cb3f05b49d23dc1542f78696e20c4ea6dd7de]

CVE-2026-97566: mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

stable/6.1 was fixed.

Fixed status
stable/6.1: [4af59a98aead422a152d805a89586dbb65616fc8]

CVE-2026-97567: mptcp: prevent race between disconnect() and rtx

stable/6.1 was fixed.

Fixed status
stable/6.1: [1a68a88369c0ab6309bd17f7e408290c5cb80dcf]

CVE-2026-97582: hwmon: (gpio-fan) Fix use-after-free in alarm work

stable/5.10 was fixed.

Fixed status
stable/5.10: [7f96803f612134f585ab3b39e6d5b2d4b9c0606f]

CVE-2026-97587: perf: RISC-V: store available counter mask as bitmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [433249a4de52ecda40ffa9c466cec1312e62826f]

CVE-2026-97594: landlock: Fix use-after-free of the source's parent directory

stable/6.1 was fixed.

Fixed status
stable/6.1: [0475440ff8c04be26a88733af0c85f597bb28c0a]

CVE-2026-97597: ipv6: flowlabel: cap duplicate leases per socket

stable/6.1 was fixed.

Fixed status
stable/6.1: [42abef116bb2265eeccae55a0dc91a9f1546f74c]

CVE-2026-97599: ieee802154: hwsim: serialize pib updates to fix double-free

stable/6.1 was fixed.

Fixed status
stable/6.1: [8f44a61f816581c35c1974c8c1a3b3c2c49e96be]

CVE-2026-97605: erofs: preserve LZMA decoders on resize failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [164cdbd7ac748c4df1a0c9b435286835668c1f33]

CVE-2026-97609: netfilter: cttimeout: prevent UAF during module unload

stable/6.1 was fixed.

Fixed status
stable/6.1: [763787e9d43982d1082b59caeabd317343b153ea]

CVE-2026-97613: net: mana: Reserve extra CQ slot for the fence completion CQE

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a41af0d906360f09527629f7d9ef4e342c58a89]

CVE-2026-97615: net: bridge: use option bits for CFM/MRP frame handlers

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [935eb5581583b008d0c8e928c03021b45967439b]
stable/6.1: [158b6563c6c9dc0f368a2169911fb4f8a5ea0592]

CVE-2026-97616: net/sched: act_api: release all action references on
NEWACTION failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b7133be1faa35b38f68d78a9f950f1dddf3eb8e5]
stable/5.15: [b83a51a83e85411c050c7b16cdc43b331c6565be]
stable/6.1: [e469765708b1afa9b9565dbafca09e22ec4edfa7]

CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [aa4a3bec32ffe20ba1044db8211140edf7637310]
stable/5.15: [16840e3478c72ebbf093c52cbdcd8a1f12fad692]

CVE-2026-97901: genetlink: pin family module during policy dump

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7ee2c0f82354da9bae04b14e0e5b2037d2de48a7]
stable/5.15: [7f71414c206a0e2babf4ec2756c0d15776c5dfd2]
stable/6.1: [ad01ec35360e803670168d63a856629d6aeaec48]

CVE-2026-97908: Bluetooth: btqcomsmd: destroy RPMsg endpoints before
freeing hci_dev

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b9b34cc149f8344d1cffbf318eb1c8cb414f74ac]
stable/5.15: [e2a0d9401368ec29bd0cdbfe9545d2a800429875]
stable/6.1: [f5e4f81f4e075cd5ec062f81b576b88cdee998d1]

CVE-2026-97924: tracing/user_events: Don't destroy fields when event
removal fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [c8efcb80f0b4d253482f9117db29bb92b4197d52]

CVE-2026-97925: tick/broadcast: Plug clockevents replacement race

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9fa1fb4a876e10cc17182ce339625ec4d4b75f20]
stable/5.15: [bc988724973b7f50d5dd05637f1e9ef4f009afd5]

CVE-2026-97935: tracing: Set the trace clock before registering the
histogram trigger

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [85e6df6e9cd489de8e238596a68b89eee0c03b88]
stable/5.15: [3568dabef3fb56517777ab981584f72ab1e90186]
stable/6.1: [c7b77c22adcf314ec8aa4807f01914dcbc62ed54]

CVE-2026-97939: ipmr: account multicast table and route memory

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3e808d8dfebd8f114a747bd90c8f7d2a6fd7474f]
stable/5.15: [57c523e95ea2608a19e6bfcd664d641ddf7bc4b4]
stable/6.1: [20424f267c9dbdfcade28b2b2306767a7dfb43d1]

CVE-2026-98169: smb: client: fix potential OOB read in smb3_enum_snapshots()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [67ef1d6da00f4f39eb5fcebe7a44fe494b645059]
stable/5.15: [5edf5b398d49b881c0df79d6e4f6df251236c533]

CVE-2026-98170: smb: client: fix OOB struct field reads in
move_smb2_ea_to_cifs()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [22886b1b7464613373c9a7d0af2ace029c50cd97]
stable/5.15: [9d707a278c100c26d10fbbbd03988778ffc992ce]
stable/6.1: [90a13af4c9b1369327395bababfe87c75599cc19]

CVE-2026-98171: smb: client: fix next_buffer UAF and NextCommand
bounds in compound PDUs

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1ed29f7a03417b405f38c09cfe04124883127b53]
stable/5.15: [7f022867ec9f0166a0b4400385bb601b1c6b2c75]

CVE-2026-98172: smb: client: fix smbd_connection leak on
cifs_get_tcp_session() error

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c295f6505aec085d73e8dcea9f648c8af1b9da8c]
stable/5.15: [45a97df1b7fe6c1ca5493f8fb5284203991aeeb9]

CVE-2026-98173: smb: client: fix use-after-free of iface in
cifs_try_adding_channels()

stable/6.1 was fixed.

Fixed status
stable/6.1: [93e8a49adb2a575202c5ee766435eff2f9f95f5b]

CVE-2026-98192: wifi: wcn36xx: Fix potential use-after-free in TX ack
timer teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [915298dbb766d2311b0822ab6ef24780def0bd53]
stable/5.15: [e7f265d507ee55017b67ef4722df884468be1113]
stable/6.1: [7ce1e55a439968a298a63d3199cb1c2636429746]

CVE-2026-98193: wifi: libipw: reject TKIP frames without a full MIC

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2e23abdaf6d32aa112efaa474629af7584d3acc6]
stable/5.15: [9442bf5ea83314ef9a8a33e6885da45a61d1474d]
stable/6.1: [0636970f31dd9099f98578a62335eb534be72e3a]

CVE-2026-98198: hwmon: (pwm-fan) Stop RPM timer before freeing tach data

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [6f890d1fe8325ac8330473428b9a9d6526de1b32]
stable/6.1: [7743183d8b0f6ba88738805c824a255baae674b9]

CVE-2026-98245: btrfs: take commit root semaphore when iterating in
mark_block_group_to_copy()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [90242b776df83f8b1ea901f80b568b4fc2318c61]
stable/6.1: [bffe773f92885603db14047bba0f12089105929e]

CVE-2026-98260: exec: Cleanup POSIX timers right after de_thread()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f6c93e8ecaaf12959b7ef6eb611351001db2ff5d]

CVE-2026-98264: ALSA: virtio: reset device before deleting virtqueues

stable/5.15 was fixed.

Fixed status
stable/5.15: [c0156a60adfb351b15ff25fbd76a0c639e96246c]

CVE-2026-98265: ALSA: usb-audio: Clamp implicit feedback packet count
to URB capacity

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [6c5c986f761756a6ff7b3aea51c11994fc2464e5]
stable/6.1: [e44cee1bf51e606f3e70a213eb5a1abb3fa56a81]

CVE-2026-98297: Bluetooth: hci_core: Fix queuing tx_work after
workqueue is drained

stable/6.1 was fixed.

Fixed status
stable/6.1: [9943b4c70ad972f368705da8605054f865b08dad]

CVE-2026-98373: mm/hugetlb: preserve mremap address delta when
skipping page tables

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab4f0f68cf4773dc0513baccbbe790c80a301773]

CVE-2026-98375: xen/netfront: drop RX packets with a short Ethernet header

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fd5481dd75ea879c53c17882cbb065ad3bd6b766]
stable/5.15: [9cb8813d157b4d15103d3b34c635620f36df4173]
stable/6.1: [57508819da8dc1cf5a2c3b64570aa02cc5ae28b6]

CVE-2026-98377: vlan: require the MAC header to be present in
__vlan_insert_inner_tag()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [12295e0728488105b152b57fe8bc5e86f1d21a73]
stable/5.15: [aecace4ef31bd4e8ca1f224280ab52a457b0dc9a]
stable/6.1: [50a958f865173e8752ff07bf0eff7b55cdeb5d74]

CVE-2026-98386: scsi: qla2xxx: Use memset_io() to clear QLAFX00
request ring slot

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0eca1d7a4dac793224e6e295e29e00245e96cf16]
stable/5.15: [337026cf8149dcfedacd60d6d7081bff10ee5cd4]
stable/6.1: [6e8f1144d06cfd8cf8c346066efd8f572b28f768]

CVE-2026-98409: watchdog: rtd119x: Avoid division by zero

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b2876193a150301993ab2f88afde07568e4de9c7]
stable/5.15: [5cfea211bd3440b1de0b2d7dc2809c6350a5b722]
stable/6.1: [d4ef7cf5d31c3cbc6f87721fb950ab10dadeee72]

CVE-2026-98443: xfs: fix cursor and pointer handling when recovering
iunlink buckets

stable/6.1 was fixed.

Fixed status
stable/6.1: [8cfde7b2fb7288f4f6b90293e8702ff897c682fe]

CVE-2026-98450: smb: client: close completed creates on compound wait errors

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [da83fed81241b03fd0e7ccf0091b051cf420d8d2]
stable/5.15: [e94370cf2b76e913a997e9a633ab521a45029284]
stable/6.1: [c8c6c7e665af4dba75a02f4c9bad3ae2ce341619]

CVE-2026-98451: smb: client: use finish_no_open() for non-regular inodes

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bc585d5a381ab49cb611c35dda93a997214ca874]
stable/5.15: [26f4bca335e719e291995e28dc434de0145a6a54]
stable/6.1: [51c7b0593f6eaba05349fd2a01a9cb4df7d7412f]

CVE-2026-98453: smb: client: close handle after create-context parsing failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d4c05b5cb0a3132453e36a300d45de44bf6783c4]
stable/5.15: [ee61f1dc516d97afa79908140d0a8c556c2fe90c]
stable/6.1: [007b87f6a7c38959ed79cf7d3fd7b3b4eb5f67fd]

CVE-2026-98454: smb: client: fix create context out-of-bounds reads

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [34245048d6c1fa6d7be4f0dec1d14b5be02360e1]
stable/5.15: [0a8c2a6715c2a67b7abbbf874fccc9f5518146d9]
stable/6.1: [43d0ca48bb902d554b6531862248810d2ae3b8ef]

CVE-2026-98456: Bluetooth: mgmt: fix race in read_unconf_index_list()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fa6f79bb0009406bb11e6912b53ab7c564d6f06b]
stable/5.15: [76dc7e0297f6f7ebefc36a69251e3f4a676d9853]
stable/6.1: [9c32455f490b960efccedd041c7aabb1a04c5cc4]

CVE-2026-98484: netfilter: nf_tables: skip expired catchall elements
on insert and delete

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2462ff0861f0dd5b2abdc3e95c3360d8566ab081]
stable/6.1: [f347d71d0d1a2157d8ecadbe1fba69cff32fce98]

CVE-2026-98486: net: ena: fix MMIO read buffer leak on probe failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9de940a3c5731be5a544f6f366576cc4dc073f7c]
stable/5.15: [4b90112826439149dcee20e73d02f25ae0e2a9fb]
stable/6.1: [0d31edc7ff1f7f265c11248819dfaf5a8274b209]

CVE-2026-98490: net: openvswitch: conntrack: fix helper UAF due to
extensions realloc

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f53d13a286fb275bda0efdf445b8a1e4dfcb717b]
stable/5.15: [84d47a83b7b717576de0defab46b8823a22853b0]
stable/6.1: [9f308197395c1a524b736e401cbc8a2ed7d246c9]

CVE-2026-98493: net: ipconfig: bound DHCP option construction

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e0a221cec0e0ee437680ae0314a4b166509442c5]
stable/5.15: [ca811550b9fa87e02845b4a332d194c2304d933f]
stable/6.1: [d8016c82acdd7eaa462e1f38a962b15d8c6a650b]

CVE-2026-98502: HID: alps: unregister DualPoint Stick input device on remove

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [10c14ba9a2f75be78bde46fb7f5432bf02b39676]
stable/5.15: [3efab2a65f6062fa80322095a124c16e2fe0f119]
stable/6.1: [0cd13b96e00cacf1b252814442d197fdff0b1f4f]

CVE-2026-98507: mm/rmap: fix missing barrier between anon_vma init and
vma->anon_vma publish

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [badedec499f6320742368c73fa77cd63dcf8ca55]
stable/5.15: [aef0f69b515af1c8a4147f68a46b6b81854f46f7]
stable/6.1: [7d103fc7b836084af585d9d3471334624354cf26]

CVE-2026-98511: drm/nouveau: don't bump pin count on failed re-pin in
nouveau_bo_pin_locked()

stable/5.10 was fixed.

Fixed status
stable/5.10: [6d6e9291413fda06588846cbbf09b789a0e948fa]

CVE-2026-98519: drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6d2ccd1b810654ec4d26ccda0482283ffe22dda2]
stable/5.15: [878cfe9f2e2850cc1d998491776db3f7bc58e1dd]

CVE-2026-98544: bna: prevent IOC timer rearm during teardown

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [8160cd1ec527caedd36c36f948234e834cd086e6]
stable/6.1: [3614582375fc4407e09ff42ff178a045e2fe6e8f]

CVE-2026-98549: tcp: prevent collapsing skbs across boundary in rtx queue

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bf785a303e5faad16439c563826a07cb811856c8]
stable/5.15: [7061aafc680e14e22b191f178b768886475f8524]
stable/6.1: [533344a00ad968181e60d0980c076a9d0de57482]

CVE-2026-98568: vxlan: use one headroom snapshot for neighbour replies

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e3e24f4c434c56952412f875b834aa9daaa4fb15]
stable/5.15: [9ed5a548b42d46e6968a46b67ca8a8e49b12a5a1]
stable/6.1: [fcaf456092dc86fd5b0b523ac27ec0d114066931]

CVE-2026-98655: perf: Require kernel access for text poke events

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4d8fc6290d14aa9e4c3b620fe3e5dc8ba3bea7e3]
stable/5.15: [c30886396eb1c0e9fdc4296398dea0db0ab37610]
stable/6.1: [0e26d44b7c64b045adebcf5d614140f811f09752]

CVE-2026-98656: iio: trigger: cancel reenable_work before freeing trigger

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [beec4c9e23b8293c41d3448f9807c28fc9a599d4]
stable/6.1: [4e790a5bd4249877bcf0c94db12ac490965f9296]

CVE-2026-98657: iio: proximity: pulsedlight: fix iio_device left
registered on PM setup failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [93ecee9ff3af4c2b482fdd4ec98c3308e8dd23a6]
stable/5.15: [58e68e5272a319fff4a704df1ac41e9e3c69587c]
stable/6.1: [4a564e39cb99234e8c5b0a39aa30edcc8cf4cf1b]

CVE-2026-98660: iio: pressure: bmp280: fix out-of-bounds access in
sampling frequency lookup

stable/6.1 was fixed.

Fixed status
stable/6.1: [fed876157271fc4bc28b8739ad73642553a5920e]

CVE-2026-98662: iio: light: gp2ap020a00f: drain irq_work after free_irq

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6f2bb000493c3b4f5715b3103657393672aea05b]
stable/5.15: [43fbbb9eaae5d6f45668e3c4d45508c498d6ba9c]
stable/6.1: [d029639b079b28a5334f934c848d895bef0653d1]

CVE-2026-98663: iio: imu: adis16480: fix unprotected debugfs reads

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8a7ff80c5cce57c65c105efd3a3e112edcce0e08]
stable/5.15: [cd2923032a9b8774e5a110c62c35919266387a2e]
stable/6.1: [ef4a716c51e19c2f2565d9993c110e5ecc3b3783]

CVE-2026-98664: iio: imu: adis16400: fix unprotected debugfs reads

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [48bb3c9b4a2fac64cb17c357418ebfbd4c9ac8ff]
stable/5.15: [69cc001761894c65a0eef1bb6df911b39d30d71e]
stable/6.1: [d32eb2161b452a25b03f915f431bdcb9722cd92c]

CVE-2026-98666: iio: gyro: adis16136: fix unprotected debugfs reads

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c325d98b824b61cf7761335c633bfac22ec8e85b]
stable/5.15: [c8cf798ad3ae0573e83c01c73228f5f46e54f1a0]
stable/6.1: [3558b125b034003b04e89d0d7b38733a08d3fc49]

CVE-2026-98668: iio: buffer: Ensure bounce buffer used for unaligned
case is zeroed.

stable/6.1 was fixed.

Fixed status
stable/6.1: [b953b8d5e6f2d53e81faa0f3b42856cdf16fe563]

CVE-2026-98669: iio: buffer: serialize buffer teardown with mode claims

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [261f54966ebf45ced5fe5e1fe5119c6c44e140ab]
stable/6.1: [cebbecb26d22368440c4779f8275d790cf347177]

CVE-2026-98670: iio: adc: xilinx-xadc: free IRQ before cancelling the
unmask worker on unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [7958959ab2a906c04f783a3ffb979c45472ad647]

CVE-2026-98671: iio: adc: sun4i-gpadc-iio: clean up on thermal zone
registration failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4a816f67853d4b2915b9e913c4434fb0f3f5d018]
stable/5.15: [bd16e71c2d4aa0aba65823d3abdd767ec858ac49]
stable/6.1: [d90d7871b683103e01f33801c3fd747ab6434305]

CVE-2026-98672: iio: adc: stm32-adc: fix possible division by zero in
processed channel

stable/6.1 was fixed.

Fixed status
stable/6.1: [f6ec4b0769821d03083ce30e041c8349fca844eb]

CVE-2026-98677: iio: adc: ad_sigma_delta: fix use-after-free on unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [b2a991d33f1e2207052fe745d1fe459db8b365e2]

CVE-2026-98679: iio: accel: kxcjk-1013: reject duplicate event disable

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b33dfdc0f22dd6c9cb9ae34a32723ef0a5d2ccf5]
stable/5.15: [8c6d1abaff5dbbe2d2b7529de7f1f2395a2f07e9]
stable/6.1: [2f9f88da802733bab7a87a0e685c8cfa7488f6ac]

CVE-2026-98681: smb: client: split cifsFileInfo bitfields to avoid
shared-byte RMW races

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f255e87b4f7eda568c37d6eae5db1d1a8aca5968]
stable/5.15: [7fa619367869be705942f087b2ecd209efc78fe1]
stable/6.1: [e961baf9c1a4f2e93a55f8eb2c6151fc27b96a4c]

CVE-2026-98686: smb: client: discard post-EOF pagecache when extending
a file via zero range

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [1ecf89d8efca618e0c758c06b9a1fdde8bd941da]
stable/6.1: [03408d15c5405f8dc3e1a114cdce2174027a85f6]

CVE-2026-98687: thunderbolt: Reject oversized XDomain properties responses

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9fba032802b5858bc6186b34f8e966429ff155ab]
stable/5.15: [7c028d2ae85eca86b82cab1163a9ac1187a2e666]
stable/6.1: [37ea4304bd9f57ebe719409f010915495467f05c]

CVE-2026-98694: thunderbolt: Fix KASAN reported use-after-free when
request is canceled

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [94358146389d985b809898cc23b1030ff240a25d]
stable/5.15: [9594550e95bcc362027b7ad5f0d5665110f8a7d8]
stable/6.1: [0dc4296ac0910d3a43d9e105226ace463e475304]

CVE-2026-98695: USB: serial: fix ioctl hangup race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c7ef25e96dc3f808eb891bbbd43b6a682846eb0c]
stable/5.15: [98f0a25134bfce44ebd1db0341fa0e8603ff276d]
stable/6.1: [3a728adbed9fd822f99a9d9c5ebad5c3b565ba4a]

CVE-2026-98696: USB: serial: fix driver deregistration order

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [991904982827f07706c643bb0428c4b689b254e3]
stable/5.15: [7c65438e3b98bd6009af09db8c725547192cdfe0]
stable/6.1: [2f12343f39e316ff66adc84a6db3569f33b50f66]

CVE-2026-98697: USB: serial: fix dynamic id driver deregistration race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e8dd520070e1d89ab2fabdd514dd2b4024fabc1f]
stable/5.15: [025e149e471bfa07622b8b77050facfc9b7704b4]
stable/6.1: [5f83c41fac8f4048f2ded4ffdd74907888a3bb91]

CVE-2026-98698: wifi: mac80211: handle empty FILS association request payload

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [de3297c8e521c0b0ddc89ece6fee84e25da9ecf0]
stable/5.15: [ce70c87252a14020cb40032efe208efc6e61b1ee]
stable/6.1: [d8c5dbbf584a1baaa008988ac64dd4495f7086bd]

CVE-2026-98700: wifi: mac80211: set info->band for 802.3 encap offload frames

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a182c0bbb3c0332189f04b241a71455539f58433]
stable/5.15: [3ce62fa18975316547c971cf60c4533077a60c48]
stable/6.1: [c85c0d897b91c74c0a2c0d0ad29f1ae970dc1e0d]

CVE-2026-98701: wifi: mac80211: release mesh path quota on failed additions

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9c715919369a6bae12f03debfcf0716f5d8db1c1]
stable/5.15: [019c0a91e99f0eb6c331ca63f4fa361e9bfcb089]
stable/6.1: [b5b08afe4d020acb1e6ea1021ce6fb63dedd1f46]

CVE-2026-98703: wifi: mac80211: minstrel_ht: validate fixed rate index

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [63097bf1b7f17f14bd9ffcae6590c63272da8bb0]
stable/6.1: [9b685cfb5cc8ed57991b1a956b06c6658d7cf455]

CVE-2026-98704: wifi: mac80211: keep fallback association elements alive

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [409da4ad76d921b173ebb801e316023f74564239]
stable/5.15: [fb47973eecd869ab5662bb39002f6680536caa6c]
stable/6.1: [64183344f6f29ed0cad33d6ec0e769aa5e31fb19]

CVE-2026-98705: wifi: mac80211: account proxy paths against the mesh path limit

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0e79c9d260862bd4676955d3cac7baa0d38a5b2e]
stable/5.15: [bfd447ee32f727e535e317aa5a8447488f943803]
stable/6.1: [7f83dab0045f756a82a15ac751165aefa03bed11]

CVE-2026-98706: wifi: mac80211: drain PS delivery work during station teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [01292d4c491b9b78c23cde3c5eaa9fb8c8e241f8]
stable/5.15: [dedae75046c47d191b9ffe3771c09281a9a94fba]
stable/6.1: [086e7aebd3a9f91435cac348828a339e1070b188]

CVE-2026-98707: wifi: mac80211: shut down RX BA session timer on teardown

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [225c67a0bea0bd42f568f4842e747bb7f4bafebb]
stable/6.1: [18cf74311f3f0bc77384549d270c489f64c6510a]

CVE-2026-98708: wifi: mac80211: keep paired old chanctx alive

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [026ae72fa6d0f7e04951441026be473f22911b87]
stable/5.15: [624bf5338d8c2f55db455ce4f2543ca4a83fab03]
stable/6.1: [0fba8fbf5ab0bffc1866e5038aaab772d31d1584]

CVE-2026-98709: wifi: mac80211: count only matching reservations in
reserved switch

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4c4671a706d2d85442a30850abfada5377ffbbc8]
stable/5.15: [183cc72ae9467717afba8b8d194a558a6666cb53]
stable/6.1: [b3d9f582f98e06070d5233b177b2899b693a01ec]

CVE-2026-98710: wifi: iwlegacy: 3945: free EEPROM data on remove

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [52990dd317f76c1baa3665e3b1513cf3d4b48f5e]
stable/5.15: [a17d3fbca1731ae84c03a3dea0970f62f19757fb]
stable/6.1: [39a3af97a23f6778887528c1fb4ffc60017ed0e6]

CVE-2026-98711: wifi: cw1200: fix TX padding OOB read leaking heap
data to device

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8e8e4d0b15f174d964a48b1c54dc8828e5ae87c5]
stable/5.15: [a7eae7547ae1443bfbca2cb90d3ef5e501d6445c]
stable/6.1: [5897945635aa5413595bf696127493be96c08e2d]

CVE-2026-98716: KVM: SVM: Use the active VMCB's MSR bitmap when
checking if MSR is intercepted

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [001c78bc64389cabe4f9015ab3942ec9c3592caa]
stable/5.15: [552a110c403f1a61eba0bf71519c6585d9d4242d]
stable/6.1: [0e79ebf6f92a7d15187aede44204fa04b93e474c]

CVE-2026-98721: mtd: rawnand: cadence: Initialize IRQ state before
requesting IRQ

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [942274f94c1d547fb212de4403e9ee66443a9c86]
stable/5.15: [f636a8c4e1c8c82d2dae3b4af16e9aa9971ef0a2]
stable/6.1: [4592c3b4de4b65ec5d5265a272f84d5691005c14]

CVE-2026-98722: mtd: block2mtd: Fix divide error when erase_size is zero

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c8004de07739fa9a39e310e859384f1458d7d076]
stable/5.15: [7ad5287e58d7aa1a848105f119e6c5b00446882f]
stable/6.1: [fd73c079abc58e10183a4db4dc9dc5012db17476]

CVE-2026-98725: nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e94ff1771c4cb398749789557f0b6feb871e3486]

CVE-2026-98726: nvme-multipath: fix underflow in ANA log bounds checks

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [52c4294f3c26ec9db0e6f2e599096673d6f0f34d]
stable/5.15: [fe6e003c132b7c204f63e7a7ec422904fa3141b6]
stable/6.1: [08ab1e2dddf26248d5e6246046096b281cf5a319]

CVE-2026-98732: Bluetooth: btintel: fix buffer over-read in btintel_hw_error()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [162bb126d5c07a0150a171f8f3f1996e445922b3]
stable/5.15: [d850e34c73175f5d7860b17f4810fcb6e5ab8727]
stable/6.1: [0fa8630506f36374911772647bc5bcfeb47c5195]

CVE-2026-98733: Bluetooth: hci_core: Serialize fragmented ISO packet queueing

stable/6.1 was fixed.

Fixed status
stable/6.1: [e328b5823fa6b0b160d0922d6d68323e910d09a4]

CVE-2026-98735: Bluetooth: hci_core: Serialize ACL scheduling with
channel deletion

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [126714c495bf31a5e71411b8e0b65a685bb5e58d]
stable/5.15: [7fbeda3dcd5f54e7429f4b5e2cfa7344b7e9b1c9]
stable/6.1: [74667f6eb7c12b65c56e02e0f527e4099db4ebfd]

CVE-2026-98736: Bluetooth: hci_conn: Lock parent access during
enhanced SCO setup

stable/6.1 was fixed.

Fixed status
stable/6.1: [48bf3b94c7331e11eaa6c89adc054a7bc7c0382e]

CVE-2026-98739: Bluetooth: RFCOMM: Fix initial port reference race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [cd247e38b14df48d6b3940c4573a9f7acb10c363]
stable/5.15: [d3dd18e85c140df72e0f2b5ee156ebfba04c06cb]
stable/6.1: [c50360a019766fafa27318928bfea96dcce8a37d]

CVE-2026-98741: ALSA: ua101: reject mismatched capture/playback packet sizes

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b54976c81a6b8cae311b75be1a4cda444689bca0]
stable/5.15: [a2d326b3f6d470ea4bfde00245794e0dc6dbbc3d]
stable/6.1: [0a6a5eecc92c13f936d8d90975116d6bbdf4f876]

CVE-2026-98742: ALSA: seq: Serialize compat port-info ioctls

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [14e178c60ba1cea49186fcfccac93d66aa94e9e0]
stable/5.15: [4980768c5d092493be0deb20d1ee86aa661466f8]
stable/6.1: [2c0cce3a5a660270d65729b0f318d4e01470479d]

CVE-2026-98745: arm64/fpsimd: signal: Forbid non-streaming SVE payload
on SME-only systems

stable/6.1 was fixed.

Fixed status
stable/6.1: [6c5b3ec340921617d965b7c87959560e886e778f]

CVE-2026-98748: serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [134d239558f2ac2602fad2392ec3e6d8d76af7d8]
stable/6.1: [dad9fb86829ee96bbc6315d7209ceb24820ef889]

CVE-2026-98749: tty: serial: max3100: shut down timer before freeing port

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d1187a7deac1e90182372a188dfe33ddd2b53cba]
stable/5.15: [cbb3fcc7cd14396ccc1379c164d96a247331f2e6]
stable/6.1: [fb8cefd66a6055a313c993fa9e8bed9be9b088f6]

CVE-2026-98750: tty: fix saved termios reset race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [15ddaf908a8eee14e1872ff9c4cdb73562634e7e]
stable/5.15: [bcb9b5df70d439f3c9d5a2d7f359dd7ab117bee0]
stable/6.1: [33048616c4e22930e8769b8d14ee8a0dc5a80ceb]

CVE-2026-98751: tty: abort break signalling on hangup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [70fa2bec352d9f949b882af3c380b916e4a29a43]
stable/5.15: [8224d25534580d07925607bbd617daf9c8de26c3]
stable/6.1: [8a0f0f9ef41cb80de4d5da4ae146df3075463f6b]

CVE-2026-98752: tty: port: fix tty_port_tty_vhangup() race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a78910f6d78cc1415cbc9b4fb621c3f4f6945be2]
stable/5.15: [2e16ae1464a4f435425c6f6ff1e293db850a624c]
stable/6.1: [a776d603d1e1bba2837295817b0a39394707b10d]

CVE-2026-98753: tty: tty_port: restore TTY_IO_ERROR on activation failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [761e8c5eb13d1b5e196b0b39bdfed6fc67af9dd2]
stable/5.15: [5469dc4153a60289c5bae00215947c6ce09fcc0e]
stable/6.1: [e24625bff786fa3f22cc38b5038362b910621e83]

CVE-2026-98754: tty: vcc: hold port lock when clearing tty pointer in
vcc_cleanup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b0ad9d025c3229a628a82fbaa7578891075a950d]
stable/5.15: [b193617080b7036d143674089bcfb7d2ba3db588]
stable/6.1: [afcbb821c571f39b273127a7c7d26cb2cef27d2f]

CVE-2026-98755: tty: vcc: zero-initialize control packet in vcc_send_ctl()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9e2eedb3611c1a3a377105cb26af52731e826fa5]
stable/5.15: [360111628a968ebc8e6da400b28f23ae317d4e04]
stable/6.1: [639178bc8e77aad307a9ee5e62471c5dcc8dda67]

CVE-2026-98756: usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [399b18b18f54495eeeda8d88e039e6af27d020c9]
stable/5.15: [88b473800ae11397e2e169aff2e17b041c040409]
stable/6.1: [fc13243658da9ed3c4c94aaff77c36a10f441b89]

CVE-2026-98757: usb: cdns3: fix use-after-free in cdns3_gadget_exit()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a980a250de22bb4a487e935176d5f7a6b81f9a02]
stable/5.15: [5d148a6afe13db0ba0e7a83e0e355ff5b7d6e3e8]
stable/6.1: [8650216d82e7713a0083377ebcc3a2af5978c8a8]

CVE-2026-98760: usb: typec: tipd: fix uninitialized typec_partner_desc
in tps6598x_connect()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [bab4210634be8e6d4181155d1b99106ad24cea70]
stable/6.1: [72582e9bb721cd766ae333af8ebf90061dfefeaf]

CVE-2026-98761: usb: typec: tcpm: recover after failure to start the frs ams

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b321eaa21555889aa42c4b45627f544565dc82c1]
stable/6.1: [7a7d9df0b82fbb40e70394b67a06670b9516ff94]

CVE-2026-98762: USB: dwc2: shut down wakeup timer before freeing HCD state

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [f3d76baa5b902f681100447e9d185819c5c1316d]
stable/6.1: [0b2ea59d66d046d5601ffc3e61dd09d3597c704e]

CVE-2026-98763: usb: core: clear both ep_in and ep_out for non-ep0
control endpoints

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [59d2c9d70fa42e2290ff68e6430d38a1c817fcb7]
stable/5.15: [a7928ad4bbb330dfb0f726166384f319d66eb5d1]
stable/6.1: [b521fe45e06b3f7042e6d1f9566ddb6f179dcb1d]

CVE-2026-98764: usb: gadget: f_fs: Fix NULL pointer dereference in
FUNCTIONFS_ENDPOINT_DESC

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c5f452e057df6ef89300523d13ad6833bfd199cd]
stable/5.15: [e5b9d6bb2a8906a1188c9a90cc8d102de3f07cad]
stable/6.1: [7ef0ad5f462fa95bc4c6647d097d7c0384245b9c]

CVE-2026-98765: USB: gadget: dummy-hcd: Fix wait for outstanding
request completions

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [32721319e89a2be610b0518b88f0d188ce878063]
stable/5.15: [48ef54100ceffbd1a055f193873574c45f408eb5]
stable/6.1: [d77cc7c0d739fb17413714c5c4914bd396502e20]

CVE-2026-98766: usb: gadget: aspeed-vhub: cancel wake work on device removal

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [89b3fef8809ec1a9acf5f753eb89b9508d7e4466]
stable/5.15: [3aed0c86afa7877d08722233a8b15e8c1ff8bcb8]
stable/6.1: [552f580a18787cfbd83d28d7d76d584c29f2c4c2]

CVE-2026-98767: usb: dwc3: gadget: fix IRQ storm on invalid event buffer count

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2c41e442ff6304532bf369aa618b23c8a474feb4]
stable/6.1: [86b9c867fb061a147df05ff0d9bb69dd3d79f49a]

CVE-2026-98768: usb: typec: anx7411 - stop the IRQ before destroying
the workqueue

stable/6.1 was fixed.

Fixed status
stable/6.1: [3deed12f7b54a52879eb7b3f94d9f132c0144401]

CVE-2026-98769: usb: gadget: f_uac1_legacy: validate bRequest index in
generic_{set,get}_cmd

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3e655ebe0e45b7b026a4d3e6c10586b95164b3fd]
stable/5.15: [f8a4ddc23056560dc3333839a4c6998f644db303]
stable/6.1: [f0ff630d83c12c9a97637dded1dc27558bee3760]

CVE-2026-98771: usb: storage: sierra_ms: reject short SWoC info transfers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [353ca2623104a3baf5642c3ea31569df04ce4aaf]
stable/5.15: [799810166646bcf9dc5a4e77bc4b0bdf6bc443f2]
stable/6.1: [411da2ec8c62bfa39407e5a20d659b973b3cf311]

CVE-2026-98772: USB: serial: fix port tear down use-after-free

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8ed69d299b9d7872f911f089e00cdd2ea6969d2c]
stable/5.15: [bf296d7b75bfd49dc519ad0406e89ddc5c3f02e3]
stable/6.1: [94601d83fc4811485ca6fb1d50bece589fe1c24d]

CVE-2026-98773: USB: cdc-acm: skip URB restart in port_shutdown if disconnected

stable/6.1 was fixed.

Fixed status
stable/6.1: [d97da42e9de577dc827d4e8866e6971deefe2d9c]

CVE-2026-98775: nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [718965a5fcea47f7ec6accff55306317aadc3af3]
stable/5.15: [dac89ed976d9826eae4703281d0d51b062b58eef]
stable/6.1: [8024c50b8763add7912b6d9830327ba73f994204]

CVE-2026-98777: binder: fix leaked fd fixups on TF_UPDATE_TXN supersede

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab3f0ea529d4e36dde52c8efc76082c501abf9b6]

CVE-2026-98778: binder: fix is_failure flag for superseded transaction cleanup

stable/6.1 was fixed.

Fixed status
stable/6.1: [f4c072e544b8c15e6b9157208761db6fa4fe95a1]

CVE-2026-98779: drm/amdgpu: fix ACP MFD device leak on init failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [385ad314f1c096aae71fff516214bb312a6047fb]
stable/5.15: [7b7f770f48be77ce38e93216983dcdf1ea3a42ba]
stable/6.1: [65ef6645982ccde16a7bc98d025eb80f5fab47f6]

CVE-2026-98780: drm/amdgpu: fix IP instance memory leak on kobject add failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [1d7dd4f230867231abfc5cc413dae5260e06fdb2]

CVE-2026-98784: drm/amdgpu/gfx6: fix firmware leak on teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [59bdbbb70be95100aab3a3a3f4017861c0bbef8c]
stable/5.15: [18b7d69dabb61551d3a45be6300b0e6e6b04d02c]
stable/6.1: [bf3a59afc6e57957eb66ab3a86e24e2ad8b8e8d8]

CVE-2026-98785: drm/amd/display: check dc_state_create_copy() for NULL
in dm_suspend

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ed65678bb23a5f5040932960851ac39bdeafb765]
stable/6.1: [0b24f9d4e6e8ab64da8f2ae85bd1790d0f6a596f]

CVE-2026-98790: perf: Fix race between perf_event_exit_task() and
perf_pending_task()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [6e454fbe3e646d119ab75e907035950e0e857c09]
stable/6.1: [a8a6fe5601fa2d2c0fbfb3e531a1063f73c1eae3]

CVE-2026-98793: netfilter: bpf: reject invalid NAT manipulation types

stable/6.1 was fixed.

Fixed status
stable/6.1: [ce7b41f0e4b5db0580d0a2059a0c9e672b461b5e]

CVE-2026-98794: ipvs: filter some flags received in the backup server

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ef3cd6c0b826e50dc21653b32552e258de6fd51c]
stable/5.15: [3a9f5459db60311643bfbadf019f6d5370f2f26a]
stable/6.1: [438a5335276614186d6a96b8e7bddce811ad4ad6]

CVE-2026-98798: net: bcmgenet: fix NULL dereference in set_coalesce
before first open

stable/6.1 was fixed.

Fixed status
stable/6.1: [51e76b4113e5147329ed8dd232375bf11fd34044]

CVE-2026-98805: tipc: prevent GCM nonce reuse on peer key changes

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [04d67f77fe3f9ec9c60db70773fb1696d0d58da8]
stable/5.15: [7e5d5ac25e0857548cac963a2f850b19b2e1d59c]
stable/6.1: [0ff0ca5b514ceecad68b8682e072f373acc5acec]

CVE-2026-98809: Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister

stable/6.1 was fixed.

Fixed status
stable/6.1: [b06d85b114cc5fa61809f9950bca66502e0e1173]

CVE-2026-98811: net/sched: cls_api: reclaim an empty proto on the error path

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0f005c9b8b2e4c018e598cbaf490f27bebfd3d1f]
stable/6.1: [00ad96ee96760d2f12f8c4b3a43f6c6b742c452f]

CVE-2026-98812: net/mctp: publish the mctp_dev only after it is initialised

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [58a270b5ecd8629114a4754d642bad6a33bef493]
stable/6.1: [fdf09d0fa2fb639950bede185d22689f68df140e]

CVE-2026-98819: Bluetooth: btintel: validate DDC record lengths

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [780665bed305718a9fbb10e4aa4d5570d772c9f6]
stable/5.15: [93f00db7441eec84a11029662f04b152386107a9]
stable/6.1: [e65c8f4ca39959889fcaf9779c3adf1a421aeb8d]

CVE-2026-98823: wifi: cfg80211: preserve hidden-group beacon IE ownership

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [00f83d39675adc12d56957a1f5e316812157e4d3]
stable/5.15: [3c44f780d1738e9ddf438729f5ff6ceb45f9ded3]
stable/6.1: [8f79f429dc87a4f21e4fcf9a4d3df9484ca9a294]

CVE-2026-98825: rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

stable/6.1 was fixed.

Fixed status
stable/6.1: [7f59e824a4403e156cf930fe556b75139452099e]

CVE-2026-98830: wifi: wfx: validate MIB read length before copying to caller

stable/6.1 was fixed.

Fixed status
stable/6.1: [b8310b55e53622a393d14af4939f620c1828778b]

CVE-2026-98831: of/overlay: don't leak fragment references when
changeset init fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c654f283d7db20648a5bbf979209f78d4fa9be3f]
stable/5.15: [64517aeaa3d8b158e4d01321a095be48cb551251]
stable/6.1: [bbe3dc64b28a14bd9ecb514bbf5115ac8472ed80]

CVE-2026-98833: mtd: core: call _get_device() with the master MTD

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [522e821e41654eb06d2f21ac78a0f22fb6b198c2]
stable/6.1: [e7e37358408b0690c367cf38aec81a9b7e2475b5]

CVE-2026-98836: ALSA: line6: reject oversized playback packets

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [48c76820dd8858ce60a6e42519141ebcf3dfeebf]
stable/5.15: [7f31587e26e1d4735924bc324e7fa506d85de150]
stable/6.1: [e3b68b1d92f279e203923dc8bf45c8860e5b5985]

CVE-2026-98837: ALSA: caiaq: unregister the input device when probe fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7017c9dda1ebbab428a6fd29c841596b5c9c84d1]
stable/5.15: [8315ea07ebb2497531ff42dd640396f6f1d4a8f0]
stable/6.1: [1d5d194594ff616ad36a052bde739d1cf5855b95]

CVE-2026-98838: vt: skip screen update for DEC alignment test on
backgroup consoles

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d388658505bf707ff0cd7142c37c868febf8c2a5]
stable/5.15: [82561eee12a342994daf3a70590f5d07c35da743]
stable/6.1: [663cf98baced6941a0f3f00e1be61024e57d4429]

CVE-2026-98840: vc_screen: reload vc pointer before if (ret) in
vcs_write() to avoid UAF

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [cbc05413d3694193494b2374b56bae801ac41fec]
stable/5.15: [942742000a0288d4ca60c448894aabacd48004d5]
stable/6.1: [c9f56d4b29792a62b17f2051ba93fd3b40a479ec]

CVE-2026-98846: sctp: check RCV_SHUTDOWN after the sendmsg connect wait

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7f798168c54455559da0f7a377a23ab7019fec35]
stable/5.15: [fe5a23c76fc48b711eb7d6f3462c994e34da36f9]
stable/6.1: [1e7cd89975fa3b11ebd7e1bbb4648a71c0e0e2d4]

CVE-2026-98847: rtc: spear: initialize IRQ state before requesting alarm IRQ

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [709edb317ec4a1429dfa1bf41577aa03d7b147c1]
stable/5.15: [0d4144e7d6cc5ed266dbef8eb25b602314d3e245]
stable/6.1: [ca8b230188f6a5ad8d47c751d1213b2062679c9d]

CVE-2026-98850: net/packet: prevent TX_RING byte count overflow

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1e6ee93cea4b77253b1b81eb5759899f959ebee3]
stable/5.15: [70fefff0801d4c5405e515592d1e7ad1351530cd]
stable/6.1: [4848c175b5984e6358bcca794ac1dee4d527efcc]

CVE-2026-98851: netfilter: nft_flow_offload: drop flowtable reference
on init error path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4e5a6d89083af6f23f0ac2cb611ef267590a3ece]
stable/5.15: [1f43b6b099fa39032780b9494cedfd98f318f3c4]
stable/6.1: [87f4914758f2da10b56cdb7f90ed815ade1e8ea3]

CVE-2026-98853: net: gso: limit recursive IP-in-IP segmentation

stable/6.18 was fixed.

Fixed status
stable/6.18: [388604279da3d0698a151efa4fb6d852efa0de4a]

CVE-2026-98854: of/overlay: only treat a positive changeset id as registered

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [7af5d66d0514b8f1d759d0e32b9d4c5d26263e4a]
stable/6.1: [71065f3d6864a101b77e7af84566757c4df415a0]

CVE-2026-98855: of/overlay: put property on deadprops only after
changeset add succeeds

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [004a0ee2e5315f1245775b369fcb940e8cda3807]
stable/5.15: [f6f70b12ae3e4074e4cd3f42cd66fd482ce7a4b5]
stable/6.1: [50c3663790c61648a51f197970f660fd543269a7]

CVE-2026-98856: kprobes: Skip disarmed probes when checking optkprobe overlap

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e29e819cacfb4e3cd56d41eb704ab4718d6d2915]
stable/5.15: [ab9ed9faa67bf67383ff7e1479655e232a843c2b]
stable/6.1: [3b0f604df9e2b9a456f1ae5266a439998c4c8826]

CVE-2026-98857: ipvs: bound LBLCR and LBLC cache growth

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8b93288b4543ad5139a25a5b211a07bf755652dd]
stable/5.15: [f6e9446bfb79907d3092fc45a0054b0c3b329bfe]
stable/6.1: [488eaba207dd2e4c5afc65e18dc237d70f01d283]

CVE-2026-98862: audit: fix exe mark UAF in kill_rules()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8d9c97fb262067933ff4452db19e692d26622352]
stable/5.15: [11715656540360906235d724fde5349631425073]
stable/6.1: [0afb9202c1fb88387d0577524bf9785664bdd802]

CVE-2026-98931: mtd: spinand: fix NULL pointer dereference with no ECC engine

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab781c7840bb8a210156e25eb0c027d6097fb74d]

CVE-2026-98933: usb: hub: use shorter 120ms post resume hold for SS root hubs

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ff21323b74a876c54b1ebe9e5f8ba5abc7e07fd3]
stable/5.15: [73d4fbc496935ccaffba15ca5ec33660c2b587fb]
stable/6.1: [86e0baedd55fca30081fcd858ab336dfc0f1cc09]

CVE-2026-98934: ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [de83419b5062a6f83bb9421be77cae734cbead65]
stable/5.15: [8407a2c1aa67c2a110a576df8f82a4e259188b82]
stable/6.1: [a43d96620d080b1b2324a53e38dd7b4bff4825c1]

CVE-2026-98935: rtc: dev: zero-initialize struct rtc_wkalrm to prevent
information leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [f84eb9b7b0feeb267a174237d70a857042ce0158]

CVE-2026-98936: wifi: ath11k: reset ar->num_stations on hardware start

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [302b622d5f3c9ef5efa36e41e69d278599265cfc]
stable/5.15: [5f814ca9a68fd12a51fe82c36a4a876f5b8329f1]
stable/6.1: [a78f2d082f72e3c140c4542cade7f7f56f3cc62d]

CVE-2026-98940: ASoC: qcom: lpass-cpu: use DAI table index for
playback constraints

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [c10823507a74d7474391c01121e3f59901b1789f]
stable/6.1: [63987bb73df65fb01245b5905b005aa47c1dd27a]

CVE-2026-98944: HID: steam: Refactor registration

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6e44418d3a06f023877959cc6dd7386ec7f64d59]
stable/5.15: [bdfad7759fef1a5d8be9bacee3c72ce40f148b63]
stable/6.1: [39568571aee4f5499a6d254812fe4b75dc3d4ace]

CVE-2026-98945: HID: steam: Rearrange teardown sequence

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [af1b56182e54b505b216550587703c861e12368c]
stable/5.15: [1641843d089de18145cff0340fb16ddbd6552560]
stable/6.1: [15a88f39e232975378af3a14e8ebfc58f7eb4b14]

CVE-2026-98950: flow_dissector: avoid u16 truncation of hlen in
bpf_flow_dissect()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [46d21495f633e38d40857401504ee51c56ffed2a]
stable/5.15: [6267f8304cbd9ec9f3f53bd227a733e07131492e]
stable/6.1: [99c59062172620a0bac4ae8cf37c83bb78772cdd]

CVE-2026-98955: flow_dissector: avoid u16 truncation of skb->len when
computing thoff

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3f6000fdf8a57b9786669869af8a3e050b541bf3]
stable/5.15: [2c2f82b696c5e877f60ea77b7784e906a5e63014]
stable/6.1: [d44e66f5dd99319a32e378b610af7fcf78da985a]

CVE-2026-98956: ASoC: adau1372: allow sleepy powerdown GPIOs

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [1eb957ff50d74fe3fb56cf77184dfa9bd0f4a541]
stable/6.1: [9a13f13b11e1f36a3cbf79cae1862d87bd74f890]

CVE-2026-98964: nvmet: use the local P2P device on metadata allocation failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [eb72e2eeff559eb1eb07b1d644ce2bc1a16c4a80]
stable/5.15: [48c8b59429d09a7c3598de425acbc2d3f4e6647b]
stable/6.1: [e8f24ae4f45efe6861f801c6ebd2789c9016f1bc]

CVE-2026-98967: cxgb4/ch_ktls: disable softirqs around tid_list erases

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2c49ea1dd16d6dc0dd895e6aec57c9a448191cfe]
stable/5.15: [bafe51bb145e6ae549ae79dcbc35648292625934]
stable/6.1: [0c5063a898813a420e6bad93debd134ef8b3bfd1]

CVE-2026-98968: amt: send the relay's General Query directly from the
receive path

stable/6.1 was fixed.

Fixed status
stable/6.1: [423a46053788ec4a021d57e69d66db7f7f550da4]

CVE-2026-98969: net/sched: em_text: reject unterminated algo before autoload

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [64153f1dd14dabfd4e79bf506bb5b5d66f7b42eb]
stable/5.15: [b62fb105961b677418cbc0a0a8837a41735729ec]
stable/6.1: [b4da5c85cd701066ff429727fb61b84bde8bcce2]

CVE-2026-98970: drm/vc4: Free the BO cache size list on teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [75f89ab8cb4c9f136af790cc5df1f88d2726953a]
stable/5.15: [2f19ddd4bf56a057dbf17e434a3c9ea45adaf7e8]
stable/6.1: [27c17ca90202d2a20def0316fb9403971ac9dfa7]

CVE-2026-98971: gpio: exar: initialize the ID before registering its cleanup

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0250acba81654b2ee50bde324ad72b3f0c04d0bd]
stable/6.1: [88b9c4bbf83d940ab672956e5af921215905dcb4]

CVE-2026-98977: namespace: handle mount locking for automounts correctly

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f9b488641cfa63f9b41321530c543688b2e34f03]
stable/5.15: [91676705756af6a59a515087b8b854c8a28d12eb]
stable/6.1: [587d25c4b13d49c8fd05df2f71240f73bb2a058c]

CVE-2026-98979: namespace: refuse an automount below a mount that is
in no namespace

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d8c7f74adf5de78035d41aa33c8f71e12b3ca430]
stable/5.15: [c88546071d30417ab9e55821c83f4dc7756cff6f]
stable/6.1: [c98e74d73a3356ab00fc6bb9dec3c77da1ec1ce4]

CVE-2026-98981: namespace: unhash a dentry before detaching the mounts on it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b3fa3811ffffa130586c4ff8f7299b7fc69216d5]
stable/5.15: [97cc290c57ea04337fd33912d780367add41525c]
stable/6.1: [bb917ec497f6099c6cb9375596e085a5f6b52ff2]

CVE-2026-98984: dcache: don't put a mountpoint on a dentry that's being removed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [25e3ce3e2ebdd8ed3fc19dc1f7e3bc487f9240f3]
stable/5.15: [982d231ad863bb14f7bda4852ab942c0203cec4b]
stable/6.1: [96ca40461d8b91e13061ec4afb59bae6f07a516a]

CVE-2026-98985: namespace: check the mounts before reading their
parents in pivot_root()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [43fd2e2ec66e6db26b6ea3e9e7a4c1018455e1b0]
stable/5.15: [5b5f8d0895cfa9f781ce107225d578897203444f]
stable/6.1: [3184a2fda996af8fcd6def36020ec023c6279015]

CVE-2026-98990: namespace: check a submount for references right
before unmounting it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [cda0c4e502a0f74a191471ce100fb061e5ab35d6]
stable/5.15: [3f55f71291e4332983cd63b288d1f2be3c9c08fc]
stable/6.1: [361f59e7f3f9a219fb5567bf9abc8482a154a399]

CVE-2026-98992: namespace: don't copy an unmounted mount tree

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [94d05b62dc7aea236db20166e79ee002e466393a]
stable/5.15: [07c6a8f004bcc58b4ccf993e6efa7b9b8b4a1b8b]
stable/6.1: [31cf157298271392ab5fb0805b28d37c8d7a8057]

CVE-2026-98993: namespace: don't inherit MNT_UMOUNT in clone_mnt()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b201d59d047a5e05728c10864a56bdb67950d0b1]
stable/5.15: [de098fb4594f8724fa286f08c7f42837bc19b478]
stable/6.1: [fc1f3a476c35164c1beed7090fc0e630f52d778e]

CVE-2026-99002: drm/vmwgfx: validate pitch coming from userspace

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [073437615a8da528935146ca6a17292c0ca8ce19]
stable/5.15: [f54b41644744f72c86e44a21733ac6fc910ca133]
stable/6.1: [cbf7616464334b217ed07b8adacaed549f2a9433]

CVE-2026-99005: drm/i915/gt: Unmask interrupts only when ACTIVE is true

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c2c2bab5eeb227c0c45d971c58a5f66661e7bb8a]
stable/5.15: [0eb18add8cd84b4d7a6caa71e78cbe5faa912498]
stable/6.1: [8833daaa6f2102b4d527711d09cd72741601242a]

CVE-2026-99006: drm/i915/gem: Prevent overstepping exec array boundary

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7bed07cb4daa610cd6d92d9e72a575275a99ed54]
stable/5.15: [cf42a445bd5036c30d57ae65b041b8b17dfef7b0]
stable/6.1: [859e52356f913806e5c1ee5d2022b7aeda0a784a]

CVE-2026-99007: drm/fb-helper: defer setup when fbdev_probe() fails,
not just on -EAGAIN

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [423c871a586cff8b29f48db00e3c45c21d0e8121]
stable/5.15: [e5f8f6e0f0a18c77c04b757d72319d897a0b4bc1]
stable/6.1: [9124411cb91b129ff3ffb0d723ecba7a5bf893f9]

CVE-2026-99008: Bluetooth: RFCOMM: Fix NULL tty_dev dereference in
rfcomm_dev_shutdown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b2b915042be073637d9f93dc51ef15fc0685ae8a]
stable/5.15: [a43452d8c1015ac2f0e43ff946be5425427b02cc]
stable/6.1: [3f6394f6c6d1b6817065d3b402f55d437063a704]

CVE-2026-99009: Bluetooth: RFCOMM: connect the session socket without
rfcomm_mutex

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d7a3bf6f55ab77d465206b25fe3418091c3d4b92]
stable/5.15: [172b152119643018a2ed792e5096f33a4491c7de]
stable/6.1: [caf78390f78a005d5cdc1db2eb467b2794bbf020]

CVE-2026-99010: Bluetooth: RFCOMM: free the skb when the DLC has no owner

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [05145638e0db770267c39615c8ce51ab058e34cf]
stable/5.15: [91492e9194f3b10bc1eb50683ac440b74a487e39]
stable/6.1: [a835b7f445427c7bdfc7169a97e0a1bec375e408]

CVE-2026-99012: Bluetooth: ISO: Serialize concurrent connect calls

stable/6.1 was fixed.

Fixed status
stable/6.1: [a33de694226838d133dfdb7953c1955acb20df3d]

CVE-2026-99015: Bluetooth: hci_sock: Serialize dead-device detachment

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [88f47e66b1a6e0bfc350676937f3b552b434e74c]
stable/5.15: [304adbdb96b0491c2b377e216b0bf417fc8e69a9]
stable/6.1: [362126f739889436048f5573ebc87466d2525fd9]

CVE-2026-99019: scsi: ch: Do not keep references to data transfer
element devices

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7412c6fb671dda9776deebb283daf0bb2f1b48e5]
stable/5.15: [03287b176e8f7cc5680a7053e2d53bd5cb05d80c]
stable/6.1: [72ad7b08ffd5d9495715db0d74ce325a485f1b52]

CVE-2026-99022: regulator: ltc3676: don't read the write-only HRST and
CLIRQ registers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4cc1e849bb7dd8deb37f6a51e1aaf725e2016595]
stable/5.15: [0893de2397d85547d4b88379044aa541b07b56af]
stable/6.1: [f8b0ccdcf3ca7cf6e4c2c400e80f81a727f768c7]

CVE-2026-99024: optee: register TEE devices only once fully initialized

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8de131e1a2ab379641bb475f1bcb472a1a1d75df]
stable/5.15: [db36c37a2c3f13d5fd0f1afd8e2391d6c50793e6]
stable/6.1: [6b21a716ccab7fa42e8dfa3118000bc5274004ab]

CVE-2026-99025: openvswitch: fix soft lockup in the netlink flow dump

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ef77dd59cb7b7b0ac0bedd3fe9ee7a8acd8a58f2]
stable/5.15: [9ffb9897b39037a688ae01d0b3aea4ccce27dd75]
stable/6.1: [5b6a8bbdcdd7d0fddee466c1c7fe5b7f30aa392c]

CVE-2026-99027: net: team: stop reusing skb after queue override

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [13be794844e368b4f8e8d33e97efa23c0a1ebaf8]
stable/5.15: [e40846f661075c4c653988363f38e6868bd0a240]
stable/6.1: [eaf49fba9cd054e84906d2416e8662194f763c9e]

CVE-2026-99031: net: bridge: avoid recursive multicast port cleanup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0ed8edcbcf2290dba13c1beeba27fc19ad38515b]
stable/5.15: [6a7385f6605958aa69eeb185c91f45d77640d1e2]
stable/6.1: [26142868b0767e95e28b7a1237f58b292b54d1d9]

CVE-2026-99032: net/smc: protect clcsock lifetime in smc_getname

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5d0fa089d5ed497366ea5c000c6eefb346c7cb01]
stable/5.15: [94a43efd71ad440c35dd469559d3a6d665f102d9]
stable/6.1: [04069199816285c49199a35971f4298199609687]

CVE-2026-99033: net/packet: guard the ll header push in packet_rcv_spkt()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [48aa1155fa8d83362fc33d02d527a3c3fe40ce1c]
stable/5.15: [7f84ed94ccfe36091234a2891b88356dc06e6d66]
stable/6.1: [b880df0e487caa85c3c7ffda37dcd05334b1aa80]

CVE-2026-99034: mmc: sdhci-sprd: disable runtime PM on remove

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a0c7facc0fe9ec772cf8bffac2315a8e1311d39a]
stable/5.15: [4dce8c272417a564bd8c8d2ea88ef901e5447f22]
stable/6.1: [cccd175dd2bfbf8c34a1b0f413760d2ce9ff3ac9]

CVE-2026-99035: mmc: mtk-sd: Cancel request timeout work on remove

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d8ce81006ee4e42ce2d0bd3a2ab87adc1e24ef11]
stable/5.15: [2cff6a2a912a3464ae1fefb7e0a82393682ccea6]
stable/6.1: [e5d82695f2cabca3222b8f6a89ea0e18bafc4c0a]

CVE-2026-99036: dm: fix reading free memory in do_resume

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2bc5df0cf906f36a8f59ac864139ee2b7b53d3c0]
stable/5.15: [48169328021dfd59121f9a66cca919b7defcd3fa]
stable/6.1: [7a272c2338f758e3b6e664ebf7488ac40f48a2a4]

CVE-2026-99037: dm-crypt: reject the lmk IV mode with AEAD ciphers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a04546fa65cbcf4a2774f93f365d747a19abb9b8]
stable/5.15: [412d1c1f490ed9ec5bd029883e8a626626613a70]
stable/6.1: [a50e830ded5a0d0cb9e897d1521716ba654f8c3e]

CVE-2026-99038: memstick: rtsx_usb_ms: complete requests after eject
instead of dropping them

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c48245ef696e590e92cbfb622625642bec8dbbad]
stable/5.15: [602a00d75d2ab079c9ab7c0d7b56ae436e604148]
stable/6.1: [8e4eda6e1b00624820fea1d35508d7422330ee25]

CVE-2026-99039: memstick: core: wait for request completion before freeing card

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b90f33ad9179c69658342323382bfed158f88cb9]
stable/5.15: [1c23da6f148089d59b3d3e9b2e7f1eefa927cab9]
stable/6.1: [a2f1aa3341f185ca52103dc4908647570b208855]

CVE-2026-99040: KEYS: Fix add_key() race with keyring restriction

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [24806fc9bca28fa1433bf938d1424dcb45d80e50]
stable/5.15: [9a5c2700336878465a630804a2d21864f22eca9c]
stable/6.1: [b3e404550dc2b7f3d4bb64b1da8005a1fa9a798d]

CVE-2026-99041: ip6_gre: remove obsolete ERSPAN PMTU update

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2e151c74bcc53e3ed313bd1c21b0d5bb442edbc0]
stable/6.1: [ba72ed1c8476ce68eb7152dfcbc5330cefcbaa91]

CVE-2026-99043: ice: fix metadata_dst refcount handling on representor teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [41f0d9ab158fb51f34bded5f8a40918e4f70b2b6]

CVE-2026-99045: ibmveth: h_free logical LAN on open-fail after register

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [073df7871a7023298ce27cfa518fbc30cc155651]
stable/5.15: [7bd67d324d952101b3431c796d79f5e329bba159]
stable/6.1: [eae138e880686ce19879aa0d158fa3c73516f632]

CVE-2026-99049: gpio: xilinx: fix runtime PM leak on request error path

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [3c7c764a3e933b4b32a847edeb89c8d1930613f4]
stable/6.1: [7fa0e73dc31f4e653918fc002d64909c83f4b020]

CVE-2026-99052: selinux: preserve NATIVE_LABELS on already-initialized
sb in set_mnt_opts

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [22987d24a159ed7df3cdc9090ca5d61e58df0cac]
stable/5.15: [2f0f1f5a3b89c1ed67e39be49d29ee7f5c96e039]
stable/6.1: [dc579e43b13cb65e55eabaae4f1a950e43567fb1]

CVE-2026-99053: tipc: hold a reference to nodes found by link name

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [384edc67201f8561b7de952647b923f0524b1f36]
stable/5.15: [5b7e58e8be90f4e8530e7a60372d003dfa7fd666]
stable/6.1: [92f3b3368722631e933a4db0cf8bd578ed08cd9c]

CVE-2026-99054: tipc: destroy topsrv workqueues before closing connections

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [09dbd610f78aaed65d7b379c270ce4090a8151ac]
stable/5.15: [21622e5ae8b232c2e64eb1adf5546cf078d2987d]
stable/6.1: [7167afaaaee37191f8b6afa0c91e0fef41460705]

CVE-2026-99056: strparser: make sure __strp_recv isn't running before
tearing down the parser

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b09071e2f8460b35c7d355addad0fc7b31c6904d]
stable/5.15: [933df60a465b1b82ff92dcd6870504da90ba4e9b]
stable/6.1: [61cc5dac60d50dee06cf5c7b7ab246f9c825a715]

CVE-2026-99057: xen/netfront: don't leak the skb when xennet_fill_frags() fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6e6bd1051daabc327233c3ca3d00613fc6783c8e]
stable/5.15: [0cf0a25a639c535146c5eb4480d256995721aed6]
stable/6.1: [53a131eb2a998c77e2851401b32b712d6c6e8487]

CVE-2026-99058: workqueue: Fix NULL current_pwq deref in chained work check

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [73bec442f913855907b63225306dd162c18e5c71]
stable/5.15: [6877de2c75f0dd342099a1357856e6c8d474abc3]
stable/6.1: [54361e4924c2c52a501b74ef10217c32f45fccfa]

CVE-2026-99059: wireguard: noise: reject response consumption after
intermediate initiation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [dbd1e21f4301bd2157cd771255f1ca6ba1c8a1f9]
stable/5.15: [f4012ec25a4abb6a23dc40043f61e2d9a7deca6d]
stable/6.1: [6b5b14cb5421e84191e3f6b5a7566783a402ff7f]

CVE-2026-99061: wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [75e917473e20dea61f837f9afb5fc3435c9200d2]
stable/5.15: [c4c0659eb74f807e0e73742b101a07b0bb703d97]
stable/6.1: [0f84eec09039deb9229fd35c55912a2397d3ae55]

CVE-2026-99063: dm ioctl: don't let data_start run past the buffer

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [aaa93e41ae308ad9ff9d9ba3296a0d0f4d45bad3]
stable/5.15: [f171054f3c4cfc4dc0cb622ec5b15793e5f23029]
stable/6.1: [afe80ec31464f4c54cc1bc658753bc14cb14bd6c]

CVE-2026-99067: btrfs: scrub: fix local_root reference leak in
scrub_print_warning_inode()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [caebda739a724f0db57753351c01eaf2bf610576]
stable/5.15: [fc6d6b17584de7fb616b011e01f008ec3328063f]
stable/6.1: [e8d5cdd2b2e88177334326b002a58a5fae6e380c]

CVE-2026-99070: ipv6: do not warn on route notification size race

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [dac2b0328495971c7b417fd0143e53643343936e]
stable/6.1: [24b2c95a046e15c9504a6d672b6b0b252952493f]

CVE-2026-99071: ipv4: do not warn on route notification size race

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [8b35e7767fdee63e57948a1ec89d9238a651f8c6]
stable/6.1: [096ad0cb77f8da1928d04a0d170535e14ca6311b]

CVE-2026-99072: ipv4: stop route notification sizing when nexthop group shrinks

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [96f3fbb8575593657c7e80786dc3251d2fe3931b]
stable/6.1: [81f0deb02a5b5477f236bbbaed1149b779a8632b]

CVE-2026-99074: ipv4: stop PMTU walk when nexthop group shrinks

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [82d83eec893d8ae84f280aec44c60d9fdecc62b5]
stable/6.1: [a411df69524f91fe3adb8f9544d33e701fc9732c]

CVE-2026-99077: ipv4: udp: Create exceptions before socket matching

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [e8f211a37396f1684af9ac81b3fc53538eb9c2f7]
stable/5.15: [9f97b01ee799bdf57d9183623f3987c8bbfd4f6f]
stable/6.1: [e0cd4942831d4ef8f6d4b90b0d3510460fdfbceb]
stable/6.12: [3b92e4349c6b0dd1e05d5f0483e71ef37691b1c3]
stable/6.6: [0cf0ff2f728f2a1434c56c0bcf267fe230abf124]

CVE-2026-99080: fs: Free any excess xarray nodes in clear_inode()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3e837269bbfe78a602e0c259d57ffafe7a4df3b2]
stable/5.15: [813779d7974e51a6950c7237708853b129d564e1]
stable/6.1: [04456642e33022cc53562a91393a09d492124b44]

CVE-2026-99081: bnxt_en: fix DMA mapping length for padded small packets

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0f347e00d060dc0bf3b2d0ee041206e54848c233]
stable/5.15: [b3fd0177cf18a6ac98d41af80b4040010ea40f4d]
stable/6.1: [3a5d8465e73aff3c7d1ec38261dcaaa317367467]

CVE-2026-99082: KVM: x86: Use active memslots for the per-vCPU MMIO cache

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [485a5286675b15b00ee850d90eaa178cc588445f]
stable/5.15: [445e3369ac8cc1b18aedc8e8f977c68a0a326fa9]
stable/6.1: [1c77d33d85786d36e56ca1b580fb55347fd65b47]

CVE-2026-99083: ksmbd: fix heap out-of-bounds write in krb5_authenticate()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [a07dfb33112a42437f9d2d0bfd35c68575257381]
stable/6.1: [1f73a6d40f4d1bae4f3491c0ec1ea8ee6ce035ff]

CVE-2026-99088: net: openvswitch: validate transport header presence
in set_ipv6_addr

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1efa6842e94aa70237446b31fbe2bc16586809c3]
stable/5.15: [ad4258db21e801a7aae614afca89a2e39283080d]
stable/6.1: [54cb98ed23866205926298621e04169f50665b59]

CVE-2026-99089: ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [09cda41564966c7f9d2a5fa7022af18b5d4161be]
stable/5.15: [004c8ec5d71c01b93284042f1174b70cf1390e59]
stable/6.1: [05d79040b7ebd46862c4bf4864d373dad8b6fecb]

CVE-2026-99091: Bluetooth: MGMT: Fix status of pending commands
flushed on power off

stable/6.1 was fixed.

Fixed status
stable/6.1: [bbc485ee811a74fc1d4733d0a2b0eb5aeb271a08]

CVE-2026-99095: drm/vc4: drain the hangcheck timer and works on V3D unbind

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [839eebfc95f8530feaa99677274912ac09b5820b]
stable/6.1: [a1e7c7789aef551eea85de2f63989753c4fe9df6]

CVE-2026-99100: wifi: p54: validate firmware record lengths

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [87a9aba92485889d510052e474999a6ec00b888c]
stable/5.15: [d5c28994b2c1440480fccd0b6c2ce72c23bb9fff]
stable/6.1: [9af312d3607c8f9b5166a19cbf40cee351cc3a1d]
stable/6.12: [f4c6fcc2ad462ffd76d6e6f909bcd6ae0391f5b7]
stable/6.6: [dda5245afc3470d70406764e3d9f5508e534920a]

CVE-2026-99103: workqueue: Fix unbound pool lifetime for pending pwqs

stable/6.12 was fixed.

Fixed status
stable/6.12: [390b9542fe670b8936738140ef9f349df6adeab6]

CVE-2026-99105: sched_ext: Fix stall when a task enqueued with
SCX_ENQ_LAST lands back on its CPU's local DSQ

stable/6.12 was fixed.

Fixed status
stable/6.12: [ea47eec058fc1b6a3c3c54870d24a8bdcb3e204d]

CVE-2026-99106: drm/amdgpu: free the userptr ranges when a CS fails
after parser_bos

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [79179efd1ad4729cf0ff9e15eb9414f883e4aec2]
stable/6.6: [e265221019d20fa162b62baec16c44b5b2ea295b]

CVE-2026-99110: smb: client: fix heap overflow in cifs_do_set_acl()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9312a00215602ba028495ef3fa00fb84af0478e0]
stable/6.6: [68652afb9b9adf70125971abee9b95341e042249]

CVE-2026-99112: net/sched: cls_flower: validate mask pointer after nla_next()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [a9283d006eef7e3b56f0f279a49bb63f6e5e61df]
stable/5.15: [497944d534ffb1be300365523030c7c6517cbbb6]
stable/6.1: [a55d84907337580d91c0d54779d9d4b934633158]
stable/6.12: [35354bf67aa0f7bace66ffb614906124ed50d59d]
stable/6.6: [cff9bf34afde46c238189cc6f7690b7e35225df1]

CVE-2026-99113: ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before
filling it in

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [dbd0f13de153d7094b85034daffa7533d7c2b17a]
stable/6.1: [90898571fb2c6813c007a62833dd65c00481d44e]
stable/6.12: [3fc33ac2125b60f103592b83821f69f3f9aa23ba]
stable/6.6: [1a35a81c302b36fe4acd35b47b51d5d73e89ba0a]

CVE-2026-99114: ksmbd: initialize FileSystemControlFlags in
FS_CONTROL_INFORMATION

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [995456b5e703e128904a6cbc8b3347eb3d04c72c]
stable/6.1: [c78aea8984c84767e87f677477e4784deb8adfde]
stable/6.12: [370459776468fc68c97008360108f381e3120953]
stable/6.6: [e8b82184a1982894820a91a72ac9857ddd5dffbf]

CVE-2026-99115: ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [cb9fbcaf1f3351bea771eec557fc6c4d2f35762b]
stable/6.1: [1d644ab9eac767d52c9b8dc0eb68c0085994d9b6]
stable/6.12: [f5c50f69a70fe22c44a50c869c8cd65fc35a0686]
stable/6.6: [da2ec27fdd7effbe4c94ec15b6c6a281800c5123]

CVE-2026-99117: net: bridge: mcast: don't truncate the port group walk
on teardown

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [be331b23c650de9518f8266b901d8abb9b36af77]
stable/5.15: [ab836d56ff43f2e7927e88c83cd02c47a98a672e]
stable/6.1: [025c25ad73323c7dc5af4ee97fe0a2c0b3c177c8]
stable/6.12: [e69d4927dacd6ddaff09777a89efc0d3143d3b0d]
stable/6.6: [b0db9f4ff402becff710ab27dbd9f6fe4850b47e]

CVE-2026-99118: drm/i915/dmc: Harden DMC firmware payload parsing

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [0e396088fa5c1f96ff43de29c2a2f8807078723d]
stable/5.15: [53068cf3851dd4e00e8e668563e0353d9d79a98b]
stable/6.1: [e33921271d4438f4a24014f560e5ab297d7eda3f]
stable/6.12: [eb7a0ba650d607976d1a0a5e7501d3f14b35d026]
stable/6.6: [4589ad76a6b1011538600ad398baf0b7d73a1252]

CVE-2026-99121: ipv4: avoid divide by zero in fib_rebalance

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [baf3a767b2845eb8e68f056ee4aa5b41b151e990]
stable/5.15: [f655a26490e705ec76a79db7f412847fda342b39]
stable/6.1: [7c68f4de5090b17b63b9a0a3b01b3807e01a296a]
stable/6.12: [0800c92ca5d1983df6843a5435299978901d1d02]
stable/6.6: [226a974054acbd892560bfa67f0ae8ffe271a736]

CVE-2026-99123: vsock/virtio: validate packet source for connected sockets

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [bda841af86cdfe7fcf4a2f4db22e27f1b852b1ff]
stable/6.1: [c0a3a786a5e8b5007d6a3c34721ab052399ab2ad]
stable/6.12: [ec231dd3b14e541ba1c4f842a7d152fb61037333]
stable/6.6: [f77fb90edca5385d0eecbfd6d2c8ef60afff24a9]

CVE-2026-99124: s390/pci: Fix leak of uninitialized kernel data in SCLP report

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [ad1be38823d4b6dbc88648da296ca0c0f8824a55]
stable/5.15: [61ce6f9a527932f4482ebe00847490f17d63a0d1]
stable/6.1: [332f2d867f64dd530517e9a58394e3eab454df12]
stable/6.12: [eb10f25e32576bb3dbbea4457648614537f04211]
stable/6.6: [ff31c34e921d11c7da3d7664ce495106267ca408]

CVE-2026-99126: s390/ctcm: Prevent XID null dereference

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [f9d9e2dadc9fbdfe01aeb6581978c3b59092919e]
stable/5.15: [a7c3e1795e4fe5e6680cab7cd7eee0503b00a248]
stable/6.1: [c11e435d334e4c311eaaf721e179a5ca6852c221]
stable/6.12: [1525fb6e2f9f9a2c8c8723ee0959b1130a6b8213]
stable/6.6: [977dac6cc5531a8e058df05b6af94406b940cb9e]

CVE-2026-99127: page_pool: keep frag_offset aligned for odd-sized requests

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [8ab058f49e801803c4a755b09fe4a920d194da7f]
stable/6.1: [31e1a71995f23446c9d9e6ba170a6b16b110d243]
stable/6.12: [22b67b0f59f5a7f4fa1e6043a1987e167c5d06d2]
stable/6.6: [ccc28e498ef1c6eaaa16e61c6edb52c32a4f14bb]

CVE-2026-99128: sctp: validate chunk length in the inqueue parser

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [cc4a4f1d6b6d725438dc37b97f03d95ed9feb63f]
stable/5.15: [b0dbd53b242609c88e81b0a49093bdbef5d5a418]
stable/6.1: [d28ea1a62e27210d8ea3cf496dfae85dbdd7b84f]
stable/6.12: [e0fb7fe180488a5afa2e91509ea838e8df8cb771]
stable/6.6: [5a7ee52589dae36c93dc64d7a97c5ded84618572]

CVE-2026-99130: io_uring/cancel: don't spin on local work the task can't run

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8a241d7ca23be2695a1fbe587ee12eae061c31af]
stable/6.6: [64e196a6d7173667a2a0fe2f191bc64eecd07778]

CVE-2026-99131: xfs: fix capability check in xfs

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [29f994db0447104a7a52fb6495193c80007cb66a]
stable/6.12: [87881f816ab721d8a727cba20c36b9c71b489c8e]
stable/6.6: [e84bfb08016496ec5ce09a5ef9c813f23c060781]

CVE-2026-99132: xfs: don't hold buffer locks across sync transaction
commit in xfs_sync_sb_buf

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [16468281da17263095bd1906cf2d16a972f10791]
stable/5.15: [45f124f3902bfae6a366d124db04f707264176fb]
stable/6.1: [d900946853c2d183fa0e199bae9ddbcd21795a18]
stable/6.12: [acd7f2f9b822b6e126f3e3c99c173e62aa315b6f]
stable/6.6: [83b2e511cf9ba22904b167e00fcbd85169b50b2c]

CVE-2026-99133: net/iucv: fix the recvmsg window update

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [01123990f59ce32a1a5e690a4aeee002e932bb07]
stable/6.1: [1ebe68bbf8e75eeccaca0c7bc9694f5bc0c3f00a]
stable/6.12: [ce8aac3eb57f5366fa082b7cb8a1ac5652274f37]
stable/6.6: [23e7fbbdca5aaba2a9a7bb9e4f2dc179c290ee76]

CVE-2026-99134: mac802154: fix data race and NULL deref on local->assoc_dev

stable/6.12 was fixed.

Fixed status
stable/6.12: [cfbb59fb0bc8ec82d98189a4df66ccc03d159386]

CVE-2026-99135: dm-integrity: fix infinite loop on discard with large tag size

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [f41a224b3c9d66c7b59afc7cae02a8b214f3c684]
stable/5.15: [c66f5c6ccfa832d28b44a66c01e3468c246adac4]
stable/6.1: [41a18e6c6e2c4a912494a035c17ecfe79c68b9e6]
stable/6.12: [c4cba6670fa199415689f67108e96b0ba469d767]
stable/6.6: [bbc154a7da4e075aef720ef051aff6094400eb66]

CVE-2026-99136: dm-crypt: fix a tiny race condition in crypt_dec_pending

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [445a6883f46d3ab1ff545199a8cc1d5834936d3f]
stable/5.15: [6f82e86471c92fd874f2630c9a6af887f4ed1a77]
stable/6.1: [6ac8546df1f8a2b1ca7f6d67c269057a99fbbf8c]
stable/6.12: [d9d7069bb79139271b54dc477f07e242c445de6b]
stable/6.6: [056bf8322e39a48026df352d6227ec03dd8cd032]

CVE-2026-99138: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [7c312f17917455eedcea29735fa302ebb93cb9b9]
stable/5.15: [66b831b427301a9c3e485564009d476631413103]
stable/6.1: [a8b024cbf62b497062c86995737fc303e4cc384e]
stable/6.12: [e057d201640eebb8ed47ec924872c41570a3bd28]
stable/6.6: [8d5fc9e6dc09174d0da6e59678eb8e01a890cbd3]

CVE-2026-99139: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [a60e62705c17534d6b6539de7b3a40c259e6827f]
stable/6.12: [08dc5c62c09653d1c4ba67a009beb138486c2604]
stable/6.6: [4b0930d66dde0a1d1898f0edbbb5496c4dfa5f03]

CVE-2026-99140: tracing: Fix hist trigger timestamps for buffered events

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [b3a94a79047d3fc9385b3709cb2b86f4a26ed0c3]
stable/6.1: [71c5c7420478d94d6eb0b427f66fa41bbda651e3]
stable/6.12: [af192a356e9830a0df231b590ad6fb1fc28c9315]
stable/6.6: [ab320f6aa3769480f735ed0ad026c4a61799b7bc]

CVE-2026-99142: tracing: Check operator stack capacity before pushing

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d6f0006f194db49c54117ae22146421da5a2ca59]
stable/6.6: [c43c41ec62ca54ae145aa4912c6692a26d625734]

CVE-2026-99143: tracing: Keep the predicate limit separate from program capacity

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [37049f8c56d377e46a8ef1ff93178a39a68a9c9c]
stable/6.6: [f4fcbae8b27350565026807e77c96541d9e7a349]

CVE-2026-99147: drm/exec: don't immediately add prelocked obj to array
of locked objs

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9dd91a22f076a4d19f14d82a5ab790c6bbaa073e]
stable/6.6: [74b4d2370a9e2b77247063dfa05f452766102676]

CVE-2026-99150: drm/amdgpu: don't drop the runtime PM reference twice
in amdgpu_gpr

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [24c1f6e381d564e5f6893323cfe0264950358451]
stable/5.15: [c333834b1b9cbb1021c954d29fa2373ac9e73499]
stable/6.1: [eda6b57a83d942199a5947e73556fe918affad86]
stable/6.12: [35aa048f242cade635f17924183c1df0ffe7a486]
stable/6.6: [f9c0b333a5e44f734478ca8a7345f8b87d65ba7c]

CVE-2026-99152: scsi: libiscsi: Validate the task named by a management response

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [bf4035656852a386fecb5d6217710a1bde536e76]
stable/5.15: [5b56229cc152095fbe4e4ff537cb206c4aa41610]
stable/6.1: [7a7a473aec51195778a54fdd71f20fda3047b8ef]
stable/6.12: [e96ae694c5038aae84142b64e41b56324b7af9a7]
stable/6.6: [77134cf996bab55683f0ceafb9e300d97ac046f8]

CVE-2026-99153: scsi: libiscsi: Validate the ITT reflected in a Reject PDU

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [3637a4ad1d07477f1c60609876da6b60154d224b]
stable/5.15: [21ef746340ce246344f34278e205b8960c1d8874]
stable/6.1: [d20583a9dbe0d32a9af8384c857c95c0fc115103]
stable/6.12: [576125e7382a7826bd6c3c1ca4d9c582ed5be21d]
stable/6.6: [ebb8c5ef2aabf66895253600e8390e8fc7094807]

CVE-2026-99154: scsi: libiscsi: Reject a negative task index from parse_pdu_itt

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [24bd9ba431b2daa263f3551bc2f09f6b4487f5ae]
stable/5.15: [f8fabe1fe044f86abc42194b8f86dfd70212115f]
stable/6.1: [e896a97f336c5edfc13066b57ed431cb3f64e68c]
stable/6.12: [0eb06ebbbecb122f0df9a1f7f623f5255be741ed]
stable/6.6: [6200fb2de579f268742a77b0f3d823cb0a8b1947]

CVE-2026-99155: scsi: xen/scsifront: Check for a NULL shadow entry on
a backend response

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [448b9a8b530b753d346dab10add09a502fc719a4]
stable/6.12: [90186a2354821329a27d92b266c0f05e8f4f637c]
stable/6.6: [e397d4da76bed72db6ac4a0848fb6217f8394dca]

CVE-2026-99156: scsi: st: Fix use-after-free race between st_remove()
and st_open()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [7d7f9d2ee4b0841f3eba9fa3627044ad329428de]
stable/5.15: [d9517fc39ec3ee13eadefdc17f45300f7d23ed8c]
stable/6.1: [e7a5da4a4820210aa7d7cd8e6eb25aabe9e5b5a7]
stable/6.12: [5ef230f734e0d23db007c8405f38b7e226740084]
stable/6.6: [00ff1128123d4bdfacd28d68fb4b6e6f657a3648]

CVE-2026-99157: scsi: bsg: Pass reply_len to bsg_setup_queue() to fit
UFS ARPMB replies

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [bfb0582708b3432919a8baaa3a65de5fdb1490ea]
stable/6.6: [913a1876fbe9a168030013b9e6cb2746fe41fff4]

CVE-2026-99158: ring-buffer: Fix false warning in ring_buffer_map_get_reader()

stable/6.12 was fixed.

Fixed status
stable/6.12: [32751946f9b3e502e3d6e42d98b343473112f887]

CVE-2026-99159: ring-buffer: Fix the sub-buffer array base in
rb_meta_subbuf_idx()

stable/6.12 was fixed.

Fixed status
stable/6.12: [0c0cf2240bb5ca5704ea932ba66ee54f43173915]

CVE-2026-99160: ring-buffer: Do not show buffer_meta for CPUs without a buffer

stable/6.12 was fixed.

Fixed status
stable/6.12: [445bc0e0ed7b3f69b78a0fd8d3a8fdb4e20bc379]

CVE-2026-99161: i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [e48754da403f61a347d2198fd8b50111319b3a52]
stable/5.15: [f66341404d6ee3f5d451cc97c2f2c5b771e48d25]
stable/6.1: [aa910d9d4c2711478ed1567bc691d0f9651166cb]
stable/6.12: [a1b0b91c663be67072a76d76d980577a160ce694]
stable/6.6: [9504c8b6644f3c8799206c2e2840260bd416f341]

CVE-2026-99163: tracing/histograms: Reject non-stacktrace fields for
synthetic stacktrace fields

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [eba0a6365a0f38f7598a02fc7f9ee341c7efe7f5]
stable/5.15: [326c45c9e201e3ff4c9e9e0e14c2c91364d6c8be]
stable/6.1: [6c4e4946febb585d2fc93a02a0cd12cec715bb32]
stable/6.12: [648687f2b448d8527cd7b112fe5d4bd0fec85a87]
stable/6.6: [7e0d05a6234a984ac23b8a563fb7f66f2572b668]

CVE-2026-99165: sctp: revalidate output stream after association connect wait

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [26af2969b29cc5eb893a454fee2a36b39521a5bd]
stable/5.15: [b925652ba3a3ee11b2617e68de92379144b5b84b]
stable/6.1: [504bdf55438ad4b1ecbfba0f7fe95e1933f7fb66]
stable/6.12: [84f741b7bb3974e674c9739055826aa040362bba]
stable/6.6: [994694a2d4611d7b76cf05ff401a92b1c0451e1f]

CVE-2026-99166: net: rds: fix uninitialized trans dereference in CM
event handler

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [0d15e853aa88da5375edd32b39d08a048b64a1c5]
stable/5.15: [8c77774535c3d6162929521a6fa11e3db086fa32]
stable/6.1: [8973f70cb068012d83cff1cfa3f45ef94ab02267]
stable/6.12: [074bb7cdc3e26afa698888ba56fc1df0e3f24650]
stable/6.6: [a2fde862b98db8908e2ebaffbb35a75a0e9d5b33]

CVE-2026-99167: net/sched: fix use-after-free in __tcf_action_put()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [4d83a3fc03bc595dd39b79ad61288738fbb1f2ba]
stable/5.15: [fd01abed2568209f7daaf60e5ee68ae4a4744f48]
stable/6.1: [fcc7d734ceccfab8ec3398c5b34f8e775d459507]
stable/6.12: [969ad6f2b266f383b44194d50d15631969b26222]
stable/6.6: [fde33eb9955d819af282d5f5e84684eaec248291]

CVE-2026-99169: futex: Fix mm reuse handling for FUT_OFF_MMSHARED

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [096b5d4b80d19b1f7bf8e63fae0d0a32dbb6e1a2]
stable/5.15: [a7aa4ce1b56a688fe4da75430ec7bf9fe3311807]
stable/6.1: [f470b76584b5e32d9f9436ef78fb899914116d75]
stable/6.12: [16cc0fee39dffd9994b7bea676a886ed52206754]
stable/6.6: [0c133ed51700036796318f038dde813976bf1227]

CVE-2026-99171: ntfs3: free the sbi after a grace period

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [36e6753daf9bb64563dcb5a3bb22f7699d973fa2]
stable/6.6: [c39150784a801dbbfaf4fbfa284cb610552a5039]

CVE-2026-99173: eventfs: Free the eventfs_inode after an rcu grace period too

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dd2c767814a876be0f16f0b7f98a403dc176f51e]
stable/6.6: [5819018dc29fb2ac2fd4865d507f9893c89c0624]

CVE-2026-99174: ext4: free the sbi after a grace period

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [cf3bd5824c985b350d150bcd76698ee5e993fcba]
stable/6.12: [4ce0e27ea610663a9cdc04e3bca38559147428d4]
stable/6.6: [b4b0598fad51a978fcbda9d55eef6b5bd3cbe7d8]

CVE-2026-99175: fsnotify: prevent mark additions during connector teardown

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [f7def717c06aea7004905e4d1568c3691ef9825d]
stable/5.15: [da2f9aa89ef1b1fe7a7c6e1a8ddacd9c975e86aa]
stable/6.1: [587d80966dcce2824f13fd32dab83bf882acf66f]
stable/6.12: [61133f15773b907bada651a02d9c6d38eae37c48]
stable/6.6: [d28a460a2237220d9ccbdd3baac6eaead44e96cb]

CVE-2026-99176: KVM: nVMX: Reset MMU back to the root MMU if loading
L2 state fails for !VM-Entry

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [c2586874605ec23b611c57fe71d183d98f168971]
stable/5.15: [c611337aee17a0627e365e58e2b6e78803fb3c36]
stable/6.1: [df4d01be5b318024bec68654c7af0ebc0e0ed8a1]
stable/6.12: [f0c077c36fda9d498db39199e3997860e985efc8]
stable/6.6: [6a36b05fc5b3d660fcc826133dc92e2fc87bd1de]

CVE-2026-99178: x86/kvm: Don't consume async #PF flags on a kernel #PF
in NMI context

stable/6.12 was fixed.

Fixed status
stable/6.12: [fd60b32a99627fda479c9fa1d4a82fa9f7994670]

CVE-2026-99179: watch_queue: Fix note pool publication race in
watch_queue_set_size()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [2137d487b25eefa862be70de489b64f4c679fe1f]
stable/5.15: [6aaa6c1a1b61aae332d6e7e0083140b86ea51e14]
stable/6.1: [4b20867d80e7e91fb7db531f34035d91591ba405]
stable/6.12: [f94c45f83e688e41dfe1b3a589806a0a25567260]
stable/6.6: [da52e5fcb2cae6acdc0d5722ff83499f8232b9d1]

CVE-2026-99180: unicode: free the map after a grace period

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [092e14e1479a39157ca01668d43e4649793f39ed]
stable/5.15: [6472455f2b015cad43adb790cb63fe1d3cff2f57]
stable/6.1: [f96c2731a105d6663c606388f5dc21781e00ade5]
stable/6.12: [69a0d6b31d05e856c7335509222f25321e3c69ca]
stable/6.6: [5d7687b0b71601cc32f1bfd62f56cf5eea3e5a07]

CVE-2026-99181: autofs: ignore notification errors from a replaced pipe

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [95ba5de229c1875e836f10646c4e6c454d560060]
stable/5.15: [d3477ebdce74dc3bae404048258e70d7046c208a]
stable/6.1: [6d2b8ad36e09e07993addd4ce92b578d3b13c8f8]
stable/6.12: [8c8386ffc582155451f074f25759f665e626a850]
stable/6.6: [35c2c4f3cf1403b058237c44000199a6c9a59273]

CVE-2026-99182: ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for
aggregated ALH capture

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a92dee3a2a5e1ef05d13731b2f5e2eb9a3125e4e]
stable/6.6: [ef9342fa7433643f54de19b980e2aac0fae7201c]

CVE-2026-99187: perf: Fix perf_pmu_migrate_context() leaving events behind

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d4002e954c612dfc7e3fb5549e4a188ea281fe35]
stable/6.6: [3caf006eb731e88cbb33fb5b7d1f2fdb23712bc7]

CVE-2026-99190: gpiolib: fix memory leak in
gpiod_set_array_value_complex() on error paths

stable/6.12 was fixed.

Fixed status
stable/6.12: [68a2cd5381b8d89dc80bd16dd9cc9ca2d5c25e7f]

CVE-2026-99191: calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [929dc8e2c9165bb651dca26b2c68067a3880406b]
stable/6.6: [e29d0a00c619ac794b05d64f4438204478137365]

CVE-2026-99192: net: bcmgenet: unshare the skb before writing the control block

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [c13d43c92bc89f494592a60e624a7c0c42218d36]
stable/6.12: [2e5fb9dd3aca0da534793ad8123b81deff396efe]
stable/6.6: [e5aa07c62e4fda1206d314c9ea36d67cd6b95cad]

CVE-2026-99201: netlink: avoid hashing the network namespace pointer

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [c61431f3b8c9824e9848a0308054f92b27fa7794]
stable/5.15: [f8d2690f3c5dfad1fc306f6d5d84a1d3176c3af9]
stable/6.1: [c03fb9c4be3b2dd0996d91e54f65407f7f475238]
stable/6.12: [18edcb9945118beb7a1b64a31a7370ecab485a79]
stable/6.6: [41a2f69f091b0765f17890d8ac04852c12f25cf6]

CVE-2026-99202: scsi: libsas: Fix SMP IO deadlock during HA resume

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [ab91a558084fdb8cca4919ffb769ca4328e91bbd]
stable/6.12: [7004c18c38aaa2b87164b54dd77c320b4c63b89b]
stable/6.6: [6078a5369f9e8d22bb03b8890cb0bb47c91a5017]

CVE-2026-99203: pipe: preserve existing fasync readers on writer setup failure

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [6041bcd185d4df051490fe166e64feae6c3b8291]
stable/5.15: [7cdbfa22a7e270b155ddb958b1583a999c0c8abb]
stable/6.1: [22c7f57b0c0b0b8e19cfb41a1bd85f55715ad386]
stable/6.12: [9b0aa2a1d8df51f3dcb363c3a2d9531098e88dc6]
stable/6.6: [94be790dd6fbe0912f35bb711bea8ef3687eaca9]

CVE-2026-99204: ocfs2/dlm: Protect the recovery list during debugfs reads

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [03f2fdcc94238a5127ff8a21a4544fd6118cfc7b]
stable/5.15: [1c1dbaa16d70cf3d6b9b21503fc188f560376866]
stable/6.1: [c8bc0d0f2ca3df37ef4d9c69ac5fb7d417d9b035]
stable/6.12: [25de9d3b5a81ba7bd52fdc9601f9ea7d1d3d6ae8]
stable/6.6: [403669041cb77bb5ffc5ce92bcfb49b2da3d989d]

CVE-2026-99206: scsi: target: iscsi: Fix race in discovery auth updates

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [128dfa7a9b4b3c956e8ac04a169a7ba04960cd75]
stable/5.15: [35f3eb8ba914cbe079faf8712101b94ce6b2d821]
stable/6.1: [3b206898acaf40f87cf59e97e511a6b60aad9d5e]
stable/6.12: [083eea404d162c324456cf4ff9912fe8701d936b]
stable/6.6: [57b6ebcc83afb5338c561ff97ca85dc954a89136]

CVE-2026-99211: netlink: reset skb headers before unicast and
multicast filtering

stable/5.10, stable/5.15, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [4123f8d2099863e2421187af9d87b45e8eebd867]
stable/5.15: [6ec7cc02458c6a1509377a7f2eec9c7b1a355b5e]
stable/6.12: [c69db9e1f5cf886d4e3011313761a0f63a1d0da0]
stable/6.6: [ea0e0fc4c72f71bd6d8bf460bfe309b61c35b548]

CVE-2026-99212: net/rds: don't let the rdma_cm destroy an id RDS still
owns on route failure

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [664fd3205cbec71ac52c005ee705cd917bb6fb1a]
stable/6.1: [b8f141f65885810e24fc23b8a71692db62d535bf]
stable/6.12: [92143c5d80382588d5a3047a4f14023ee9ef6485]
stable/6.6: [e677eda15df7d5ce256654343418043c7ffd6f9b]

CVE-2026-99213: vsock: treat TCP_CLOSING as once-established

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [ea36ef3c229d54b552432d1290aee1d807f67fd5]
stable/5.15: [5f2ab77028602a22f0cc33cac063a313787cbeae]
stable/6.1: [f89770c7365748d9d6a2ae07d1c23497ca21ec07]
stable/6.12: [baf1b5715640e434249ce7f63f94bd1a00938ef9]
stable/6.6: [deb972c7eea8d0bc3109c35c30a1c86d4939f811]

CVE-2026-99214: drm/vc4: hdmi: Move packet RAM enable to PM runtime

stable/6.12 was fixed.

Fixed status
stable/6.12: [03cf08ed84fd43cd7d90696736dcde15f5eefca6]

CVE-2026-99216: Drivers: hv: Don't reset VMBus connection state on
error/exit paths

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [2939215d57bc8e4189290544fca78f3809ac3ef8]
stable/5.15: [a0ae955ba9a5067a157ebb8defb4a0a9cb1fc304]
stable/6.1: [deef3ab5129ae4c45662c957cdab3739eb047fb1]
stable/6.12: [2732210132f92aca0622b5134027990a809279d5]
stable/6.6: [2e5ffbf1e41abbf6e02ce28115107938f55ff646]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
