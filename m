Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95149E7718B
	for <webhook@archiver.kernel.org>; Wed, 25 Dec 2024 22:17:17 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web10.14107.1735165030117400601
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Dec 2024 14:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0IqXpmCz;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e399e904940so5406495276.2
        for <cip-dev@lists.cip-project.org>; Wed, 25 Dec 2024 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1735165029; x=1735769829; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSP28WelnU9gtTMRZY/BkborO/54qSFlFxd9IRbuDtQ=;
        b=0IqXpmCz1S9afgjCm1w25VKkFDKcKYOt1oW3kr83vVHNW79FR67NNA22qzSPBIE/O7
         GjFrw5cuyyPSwlZGmf69Nshe8kPlA0+NWraMJqX81UyhuTlh51qLy1TKGGLPqdfT2u5t
         ZRLoQmcfX9hEyq7EuDPmb970O7gflUshN4r6+PhqUdlW7mH729Is2rijRqV92+dN3S+v
         CRb6p/0Dcf8HtEEdlXBu9wn8+3go6bcxOl1vOZFPvq6vZEApB5J7WwyqvJjZCizUmcAN
         lfT3h7WqWyaApXOjA2XHai6pfG14+OFRSVWTnKyXJJHErNSHt2dSp0mNQ5KxURgANJ+Z
         F1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735165029; x=1735769829;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSP28WelnU9gtTMRZY/BkborO/54qSFlFxd9IRbuDtQ=;
        b=aeHOYXQxGO7gJmWK5w5FFu80yi1UjKi0cJ6PcTEa2Eptjy4mIHqFa5aqD9SCJRCWQ+
         jtOX+lFTJUewkq0HIihNq7GbBAPH/CIkjpPk66T3DmvjftNCQ8GfnyLAAt+E0U0ijYCk
         WEHJAm/eMMKi0gSFw8561gakt42JFAopuz8/slxZixVjxkUwXVH/SapWJE/J+cyUku3B
         O7F94Znxlq3JwRpsljiA8UDGDXYxvAGZjpPR6//xDVGQZvsnFNPVP58K6g3oZx8ZfRCu
         nU+IvgjVioFVvo6afVAb9tfotqO8fn/6A/kDybdjenS0ug4FiFkB4PAqRWpzP5XQaWrg
         nqFQ==
X-Gm-Message-State: AOJu0Yw2dvKrWlWW8VviWuGnkl/TQjVBfnSuSbkVTZZH5/yaM0z5qgdy
	FUAfFWcGiGBbPUoLkqe+H8gnQu/YZ4u8KZXR3Nb7EGofb43kAvKOpzALw1yiZTEB6i7mk7qEjJR
	eX0LytVBscWzW1cE5ZkJHX/yNL1+emCecn+a5DM1X5blWoxK1Dxc=
X-Gm-Gg: ASbGnctWdAdfSdgS/SVZQVjlux0HxWBFvfl//MSprUWSvohK6DTlsYjzjodBZM6ZSV2
	RppeZ/qReq4WPak2e1jML07s1buP9lBuqFZ8gebA=
X-Google-Smtp-Source: AGHT+IGkqvuQ7GIj/XVUG47lI5SneKXPpUjJJFpTcRNEwjXUSnrZOWBh7KithmGgV1Qn7aPWXWIMkaCL41mmJqT1vQI=
X-Received: by 2002:a05:690c:708a:b0:6ef:a187:f3a3 with SMTP id
 00721157ae682-6f3f822353fmr149565997b3.27.1735165028775; Wed, 25 Dec 2024
 14:17:08 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Dec 2024 07:16:33 +0900
Message-ID: <CAODzB9prLAW5QDmJ5JndMFiGKZkywWqQfDPawAS4urJcFOLbNA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Dec 2024 22:17:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17494

Hi!

It's this week's CVE report.

This week reported 19 new CVEs and 7 updated CVEs.

* New CVEs
CVE-2024-53145: um: Fix potential integer overflow during physmem setup

Announce: https://lore.kernel.org/linux-cve-announce/2024122424-CVE-2024-53145-1a25@gregkh/

Introduced by commit fe205bd ("um: Print minimum physical memory
requirement") in v4.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a98b7761f697e590ed5d610d87fa12be66f23419]
stable/5.10: [e6102b72edc4eb8c0858df00ba74b5ce579c8fa2]
stable/5.15: [1bd118c5f887802cef2d9ba0d1917258667f1cae]
stable/5.4: [5c710f45811e7e2bfcf703980c306f19c7e1ecfe]
stable/6.1: [1575df968650d11771359e5ac78278c5b0cc19f3]
stable/6.6: [a875c023155ea92b75d6323977003e64d92ae7fc]

CVE-2024-53146: NFSD: Prevent a potential integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024122426-CVE-2024-53146-c503@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Vulnerable function was added by commit 85a5648 ("NFSD: Update XDR decoders in
NFSv4 callback client") in v2.6.38-rc1.

Fixed status
mainline: [7f33b92e5b18e904a481e6e208486da43e4dc841]
stable/4.19: [745f7ce5a95e783ba62fe774325829466aec2aa8]
stable/5.10: [3c5f545c9a1f8a1869246f6f3ae8c17289d6a841]
stable/5.15: [842f1c27a1aef5367e535f9e85c8c3b06352151a]
stable/5.4: [90adbae9dd158da8331d9fdd32077bd1af04f553]
stable/6.1: [de53c5305184ca1333b87e695d329d1502d694ce]
stable/6.6: [dde654cad08fdaac370febb161ec41eb58e9d2a2]

CVE-2024-53147: exfat: fix out-of-bounds access of directory entries

Announce: https://lore.kernel.org/linux-cve-announce/2024122426-CVE-2024-53147-bea5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Affected function was added by commit 5f2aa0750 ("exfat: add inode operations")
in 5.7-rc1.

Fixed status
mainline: [184fa506e392eb78364d9283c961217ff2c0617b]

CVE-2024-53148: comedi: Flush partial mappings in error case

Announce: https://lore.kernel.org/linux-cve-announce/2024122426-CVE-2024-53148-2c24@gregkh/

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce8f9fb651fac95dd41f69afe54d935420b945bd]
stable/5.10: [b9322408d83accc8b96322bc7356593206288c56]
stable/5.15: [8797b7712de704dc231f9e821d8eb3b9aeb3a032]
stable/5.4: [57f048c2d205b85e34282a9b0b0ae177e84c2f44]
stable/6.1: [16c507df509113c037cdc0ba642b9ab3389bd26c]
stable/6.6: [9b07fb464eb69a752406e78e62ab3a60bfa7b00d]

CVE-2024-53149: usb: typec: ucsi: glink: fix off-by-one in connector_status

Announce: https://lore.kernel.org/linux-cve-announce/2024122427-CVE-2024-53149-8fe0@gregkh/

Introduced by commit 76716fd ("usb: typec: ucsi: glink: move GPIO
reading into connector_status callback") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a22918810980897393fa1776ea3877e4baf8cca]

CVE-2024-53150: ALSA: usb-audio: Fix out of bounds reads when finding
clock sources

Announce: https://lore.kernel.org/linux-cve-announce/2024122427-CVE-2024-53150-3a7d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [a3dd4d63eeb452cfb064a13862fb376ab108f6a6]
stable/5.10: [45a92cbc88e4013bfed7fd2ccab3ade45f8e896b]
stable/5.15: [ab011f7439d9bbfd34fd3b9cef4b2d6d952c9bb9]
stable/5.4: [a632bdcb359fd8145e86486ff8612da98e239acd]
stable/6.1: [da13ade87a12dd58829278bc816a61bea06a56a9]
stable/6.6: [74cb86e1006c5437b1d90084d22018da30fddc77]

CVE-2024-53151: svcrdma: Address an integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024122428-CVE-2024-53151-0e74@gregkh/

Introduced by commit 78147ca ("svcrdma: Add a "parsed chunk list" data
structure") in v5.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c63d8946e578663b868cb9912dac616ea68bfd0]
stable/5.15: [21e1cf688fb0397788c8dd42e1e0b08d58ac5c7b]
stable/6.1: [c1f8195bf68edd2cef0f18a4cead394075a54b5a]
stable/6.6: [838dd342962cef4c320632a5af48d3c31f2f9877]

CVE-2024-53152: PCI: tegra194: Move controller cleanups to
pex_ep_event_pex_rst_deassert()

Announce: https://lore.kernel.org/linux-cve-announce/2024122428-CVE-2024-53152-ada9@gregkh/

Introduced by commit 473b2cf ("PCI: endpoint: Introduce 'epc_deinit'
event and notify the EPF drivers") in v6.11-rc1.
Introduced by commit 570d771 ("PCI: dwc: ep: Introduce
dw_pcie_ep_cleanup() API for drivers supporting PERST#") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40e2125381dc11379112485e3eefdd25c6df5375]

CVE-2024-53153: PCI: qcom-ep: Move controller cleanups to
qcom_pcie_perst_deassert()

Announce: https://lore.kernel.org/linux-cve-announce/2024122428-CVE-2024-53153-8c3a@gregkh/

Introduced by commit 473b2cf ("PCI: endpoint: Introduce 'epc_deinit'
event and notify the EPF drivers") in v6.11-rc1.
Introduced by commit 570d771 ("PCI: dwc: ep: Introduce
dw_pcie_ep_cleanup() API for drivers supporting PERST#") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d7cf89b119af433354f865fc01017b9f8aa411a]

CVE-2024-53154: clk: clk-apple-nco: Add NULL check in applnco_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122429-CVE-2024-53154-504f@gregkh/

Introduced by commit 6641057 ("clk: clk-apple-nco: Add driver for
Apple NCO") in v5.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [969c765e2b508cca9099d246c010a1e48dcfd089]
stable/6.1: [9a5905b725739af6a105f9e564e7c80d69969d2b]
stable/6.6: [72ea9a7e9e260aa39f9d1c9254cf92adfb05c4f5]

CVE-2024-53155: ocfs2: fix uninitialized value in ocfs2_file_read_iter()

Announce: https://lore.kernel.org/linux-cve-announce/2024122429-CVE-2024-53155-df38@gregkh/

Introduced by commit 7cdfc3a ("ocfs2: Remember rw lock level during
direct io") in v2.6.22-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adc77b19f62d7e80f98400b2fca9d700d2afdd6f]
stable/4.19: [6c8f8d1e595dabd5389817f6d798cc8bd95c40ab]
stable/5.10: [66b7ddd1804e2c4216dd7ead8eeb746cdbb3b62f]
stable/5.15: [8c966150d5abff58c3c2bdb9a6e63fd773782905]
stable/5.4: [f4078ef38d3163e6be47403a619558b19c4bfccd]
stable/6.1: [83f8713a0ef1d55d6a287bcfadcaab8245ac5098]
stable/6.6: [8e0de82ed18ba0e71f817adbd81317fd1032ca5a]

CVE-2024-53156: wifi: ath9k: add range check for conn_rsp_epid in
htc_connect_service()

Announce: https://lore.kernel.org/linux-cve-announce/2024122429-CVE-2024-53156-732e@gregkh/

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8619593634cbdf5abf43f5714df49b04e4ef09ab]
stable/4.19: [5f177fb9d01355ac183e65ad8909ea8ef734e0cf]
stable/5.10: [c941af142200d975dd3be632aeb490f4cb91dae4]
stable/5.15: [8965db7fe2e913ee0802b05fc94c6d6aa74e0596]
stable/5.4: [cb480ae80fd4d0f1ac9e107ce799183beee5124b]
stable/6.1: [70eae50d2156cb6e078d0d78809b49bf2f4c7540]
stable/6.6: [b6551479daf2bfa80bfd5d9016b02a810e508bfb]

CVE-2024-53157: firmware: arm_scpi: Check the DVFS OPP count returned
by the firmware

Announce: https://lore.kernel.org/linux-cve-announce/2024122430-CVE-2024-53157-6c40@gregkh/

Introduced by commit 8cb7cf5 ("firmware: add support for ARM System
Control and Power Interface(SCPI) protocol") in v4.4-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [109aa654f85c5141e813b2cd1bd36d90be678407]
stable/4.19: [12e2c520a0a4202575e4a45ea41f06a8e9aa3417]
stable/5.10: [380c0e1d96f3b522f3170c18ee5e0f1a28fec5d6]
stable/5.15: [2a5b8de6fcb944f9af0c5fcb30bb0c039705e051]
stable/5.4: [8be4e51f3ecfb0915e3510b600c4cce0dc68a383]
stable/6.1: [06258e57fee253f4046d3a6a86d7fde09f596eac]
stable/6.6: [025067eeb945aa17c7dd483a63960125b7efb577]

CVE-2024-53158: soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024122430-CVE-2024-53158-9e9f@gregkh/

Introduced by commit eddac5a ("soc: qcom: Add GENI based QUP Wrapper
driver") in v4.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78261cb08f06c93d362cab5c5034bf5899bc7552]
stable/4.19: [37cdd4f0c266560b7b924c42361eeae3dc5f0c3e]
stable/5.10: [748557ca7dc94695a6e209eb68fce365da9a3bb3]
stable/5.15: [f4b7bf5a50f1fa25560f0b66a13563465542861b]
stable/5.4: [7a3465b79ef0539aa10b310ac3cc35e0ae25b79e]
stable/6.1: [b0a9c6ccaf88c4701787f61ecd2ec0eb014a0677]
stable/6.6: [c24e019ca12d9ec814af04b30a64dd7173fb20fe]

CVE-2024-53159: hwmon: (nct6775-core) Fix overflows seen when writing
limit attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024122430-CVE-2024-53159-f910@gregkh/

Introduced by commit c3963bc ("hwmon: (nct6775) Split core and
platform driver") in v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57ee12b6c514146c19b6a159013b48727a012960]
stable/6.1: [ae703f8ff083c5267af30d6c8cf096d562623b3b]
stable/6.6: [685c10269c41d23d7a2b85d3fd6b6345390c8746]

CVE-2024-53160: rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu

Announce: https://lore.kernel.org/linux-cve-announce/2024122431-CVE-2024-53160-692f@gregkh/

Introduced by commit 8fc5494 ("rcu/kvfree: Move need_offload_krc() out
of krcp->lock") in v6.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a23da88c6c80e41e0503e0b481a22c9eea63f263]
stable/6.6: [967a0e61910825d1fad009d836a6cb41f7402395]

CVE-2024-53161: EDAC/bluefield: Fix potential integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024122431-CVE-2024-53161-50f6@gregkh/

Introduced by commit 82413e5 ("EDAC, mellanox: Add ECC support for
BlueField DDR4") in v5.4-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fe774a93b46bb029b8f6fa9d1f25affa53f06c6]
stable/5.10: [e0269ea7a628fdeddd65b92fe29c09655dbb80b9]
stable/5.15: [4ad7033de109d0fec99086f352f58a3412e378b8]
stable/5.4: [8cc31cfa36ff37aff399b72faa2ded58110112ae]
stable/6.1: [578ca89b04680145d41011e7cec8806fefbb59e7]
stable/6.6: [ac6ebb9edcdb7077e841862c402697c4c48a7c0a]

CVE-2024-53162: crypto: qat/qat_4xxx - fix off by one in uof_get_name()

Announce: https://lore.kernel.org/linux-cve-announce/2024122431-CVE-2024-53162-25cd@gregkh/

Introduced by commit 10484c6 ("crypto: qat - refactor fw config logic
for 4xxx") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [475b5098043eef6e72751aadeab687992a5b63d1]
stable/6.6: [05c9a7a5344425860202a8f3efea4d8ed2d10edb]

CVE-2024-53163: crypto: qat/qat_420xx - fix off by one in uof_get_name()

Announce: https://lore.kernel.org/linux-cve-announce/2024122432-CVE-2024-53163-05eb@gregkh/

Introduced by commit fcf60f4 ("crypto: qat - add support for 420xx
devices") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93a11608fb3720e1bc2b19a2649ac2b49cca1921]


* Updated CVEs

CVE-2024-35870: smb: client: fix UAF in smb2_reconnect_server()

stable/6.1 was fixed.

Fixed status
stable/6.1: [755fe68cd4b59e1d2a2dd3286177fd4404f57fed]
stable/6.6: [6202996a1c1887e83d0b3b0fcd86d0e5e6910ea0]
stable/6.8: [45f2beda1f1bc3d962ec07db1ccc3197c25499a5]

CVE-2024-42108: net: rswitch: Avoid use-after-free in rswitch_poll()

stable/6.6 was fixed.

Fixed status
stable/6.6: [4a41bb9f2b402469d425a1c13359d3b3ea4e6403]

CVE-2024-42315: exfat: fix potential deadlock on __exfat_get_dentry_set

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [632fb232b6bbf8277edcbe9ecd4b4d98ecb122eb]
stable/5.15: [c052f775ee6ccacd3c97e4cf41a2a657e63d4259]
stable/6.1: [cd1c7858641384191ff7033fb1fc65dfcd559c6f]
stable/6.10: [1d1970493c289e3f44b9ec847ed26a5dbdf56a62]
stable/6.6: [a7ac198f8dba791e3144c4da48a5a9b95773ee4b]

CVE-2024-53119: virtio/vsock: Fix accept_queue memory leak

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e26fa236758e8baa61a82cfd9fd4388d2e8d6a4c]
stable/5.15: [4310902c766e371359e6c6311056ae80b5beeac9]
stable/6.1: [946c7600fa2207cc8d3fbc86a518ec56f98a5813]
stable/6.11: [2415345042245de7601dcc6eafdbe3a3dcc9e379]
stable/6.6: [897617a413e0bf1c6380e3b34b2f28f450508549]

CVE-2024-53125: bpf: sync_linked_regs() must preserve subreg_def

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [dadf82c1b2608727bcc306843b540cd7414055a7]
stable/5.15: [b57ac2d92c1f565743f6890a5b9cf317ed856b09]
stable/6.1: [60fd3538d2a8fd44c41d25088c0ece3e1fd30659]
stable/6.11: [e2ef0f317a52e678fe8fa84b94d6a15b466d6ff0]
stable/6.6: [bfe9446ea1d95f6cb7848da19dfd58d2eec6fd84]

CVE-2024-53240: Backend can crash Linux netfront

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.12,
stable/6.6 were fixed.

Fixed status
stable/5.10: [1d5354a9182b6d302ae10367cbec1ca339d4e4e7]
stable/5.15: [2657ba851fa3381256d81e431b20041dc232fd88]
stable/5.4: [20f7f0cf7af5d81b218202ef504223af84b16a8f]
stable/6.1: [8b41e6bccf7de93982781be4125211443382e66d]
stable/6.12: [7728e974ffbf14f17648dd92ea640b42b654d47c]
stable/6.6: [fe9a8f5250aed0948b668c8a4e051e3b0fc29f09]

CVE-2024-53241: Xen hypercall page unsafe against speculative attacks

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [e74011db51793c9fc5ed5abb6e12c77b806e04bd,
4099bcd87390c64d6778a17d5495863a11a7b356,
bed5b6a6f207ebd2248c8381ff56ed1a009953d9,
05df6e6cd9a76b778aee33c3c18c9f3b3566d4a5,
76b42b1340ca0c17961a1000474a23eff6f15f83,
b09001da822721fc65ef14b37018b17f282dbf3b,
b751972c26f678c0c61a1702a00714d912312877]
stable/5.15: [8f2c179b1d3ce0a0c5d623fc9991d71167fd076f,
1c50e8da50b07c69385d601dd0443f5bbe71d933,
8abab99114f1713914d833344e74a0944291a5fb,
c7b4cfa6213a44fa48714186dfdf125072d036e3,
a501b4dbedb4cdcfa2372b40e6b405e26d3e8069,
1ef790d6bf55099750f1402b188c27bc42261c41,
ae7c1c5233237cd89bf1bb59fbcad516212c6f42]
stable/6.1: [259550d6b0b352dded1b97b1243aa4a6b45c6de9,
054f07a2040819bff1d5ebfb583fc2874cb29908,
f8b1f5472b19e29439d58dc52cfb67cfeac18770,
fa719857f613fed94a79da055b13ca51214c694f,
7e44e7065263c3baf287e7ff267a610cccde7544,
1a2471af32acd00378d07164d025eaf226f337c3,
4c24703978b44d4bb95413a6b85c3254a5fa9bc1]
stable/6.12: [505b3523644d80f80f8d3de6d311ad1fa5a8242b,
c6eef3643608616b1dfdcf325738329d19d5d9e2,
fa0f23a60ea5c20e9e41bd2cf8bc049017c4f305,
f7c3fdad0a474062d566aae3289d490d7e702d30,
3fbfac0f30441725e87d85d8629fa9dbc673704b,
42d50bb38a691ea8ac459b4f966f7e66f939c147,
f6e1c44d731a9fcfc36f351f6896960940aa69da]
stable/6.6: [aac984c87ef8e99d1ff5c05b7b4fac3bf58433bf,
8fb54fe2e70912620732d051a34e7a325885ce48,
cd95149561d582ecbcf29387b9c7ec4563084ada,
82c211ead1ec440dbf81727e17b03b5e3c44b93d,
31f29270c15bef700cbea40297c6b9a7114b3960,
bcca7e0679095c0fbaae48b01c159a985ec105dc,
bcf0e2fda80c69392489d7739708409b7db1c865]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

