Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ACC28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 22:28:44 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.1241.1741818517028186529
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 15:28:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=XBuQ+/Wu;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e589c258663so354889276.1
        for <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1741818516; x=1742423316; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yelEYh3ljb+u2TCZwlFAQH48dq+jeefG7hc6VJ7yq5U=;
        b=XBuQ+/Wu6GNlXspoYgbZ4SM6HuOA2XOzQuO/3ElpZxzQ/8rfZUgx03nJluynWmdSw0
         OUQWeJlv3tArbwdARX1LSvSWLKurxMOEQDCllg8A7Gpv2OUDPM1mhDoADf6gv0d36lq+
         gF7qbPSWdXSpmxn30QJgcPIjqx1oLFPDdVwRqSxD4rIvo7/FkV+Dzuik7J/IjSqjCDy3
         1i7gmAsGavt9cI12VNGtydgHU0JNMTeuvNtMAc/Bgix8rmcKLvB7MREEbZOWsIbIWS6l
         gqlm7Ilt2Uwhp/Nj/k42pB43mVRrbUk/OMg3zEN1oyd7KQySp9B30XnDG8XSV6ZyYoiH
         P8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818516; x=1742423316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yelEYh3ljb+u2TCZwlFAQH48dq+jeefG7hc6VJ7yq5U=;
        b=W0ZSrvAirg8XrRk24eKJ3KoDuxh5wZE/PR+A4oMEjRLkHusGPyY9/NvIk32Wkcqb/B
         IVrsH2r5hBTROUf7spX/jaS9E3lqlFHYmcgw1nOxg/DFpj79uz5evcO+yMtAm8ACZQpk
         rcpmCnsMvbDWbReRD0HjxfNqEqkmuJGl4LWS7vBFBbgeC40t8+kiZehsIjSxVrI7/WaU
         9Onk/n8Gvg7nx73zx2b7fJ0k0OkxGqJrYfFI3h3gONoO2I8ePOiAX5VrbjRJD3Lk9ABw
         ++roFiXyTGAWi76+ppghLwzmEk0+dtDCl5OqjEgN2E6w333lSDUTGOVtyan/2bF7OEJ7
         F6gA==
X-Gm-Message-State: AOJu0YwBo0nJx9ByBNSuH1L9C9Xh1Ispx2wGW3TcBA88036foKTOP3sm
	s1P+5QrHFt2+v3Kxot+XzdUxl2n0X4leJmgXpZT9sLS6QoQtDe+YGCznD3KPk8V23P62nzykwmZ
	PV3t+MOm64Sp7EiTlG2gqBpmZvdZlp44JZb5/Li3XLC1su7W0L2Q=
X-Gm-Gg: ASbGncu+9oVuWhdexYzXBFJehUvrJvwGzEelseIjK6Wi1u2i21i2sa95ivPPTr+NMbi
	4QQFrPllEi0VC4/VjJo+vntVEuBXvq+p6pPhj2Sqwufntd6V4C8IZbe7EeUvQLwlbCyd3VRp0iw
	1r7RMPLl+zIkvL0vjNR8CndISOz14=
X-Google-Smtp-Source: AGHT+IGeVqzTRmDTvcNITaBvXj4KawEfXvhFn16Ys+sApMWkCpXpNo9leVqiCz8y5DGwQxJO2azSgTB+6VLcZeXm1TA=
X-Received: by 2002:a05:6902:1026:b0:e58:ac80:3492 with SMTP id
 3f1490d57ef6-e635c1140a9mr32392701276.9.1741818515242; Wed, 12 Mar 2025
 15:28:35 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Mar 2025 07:27:58 +0900
X-Gm-Features: AQ5f1Jqq0BLiSbbau4gbl8I1iBRVKv6Gc2z1GYzIHu8J8hqYe7mpC7u--u-pHhI
Message-ID: <CAODzB9oz3upEwHtcC+65Tkt094SbDuZx0+FYSar45K5QghJhmQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 22:28:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18091

Hi!

It's this week's CVE report.

This week reported 82 new CVEs and 15 updated CVEs.

* New CVEs
CVE-2024-58051: ipmi: ipmb: Add check devm_kasprintf() returned value

Announce: https://lore.kernel.org/linux-cve-announce/2025030603-CVE-2024-58051-8e8a@gregkh/

Introduced by commit 51bd6f2 ("Add support for IPMB driver") in v5.3-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2378bd0b264ad3a1f76bd957caf33ee0c7945351]
stable/6.1: [312a6445036d692bc5665307eeafa4508c33c4b5]
stable/6.6: [4c9caf86d04dcb10e9fd8cd9db8eb79b5bfcc4d8]

CVE-2024-58052: drm/amdgpu: Fix potential NULL pointer dereference in
atomctrl_get_smc_sclk_range_table

Announce: https://lore.kernel.org/linux-cve-announce/2025030605-CVE-2024-58052-c947@gregkh/

Introduced by commit a23eefa ("drm/amd/powerplay: enable dpm for
baffin.") in v4.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [357445e28ff004d7f10967aa93ddb4bffa5c3688]
stable/6.1: [ae522ad211ec4b72eaf742b25f24b0a406afcba1]
stable/6.6: [6a30634a2e0f1dd3c6b39fd0f114c32893a9907a]

CVE-2024-58053: rxrpc: Fix handling of received connection abort

Announce: https://lore.kernel.org/linux-cve-announce/2025030605-CVE-2024-58053-3c8d@gregkh/

Introduced by commit 248f219 ("rxrpc: Rewrite the data and ack
handling code") in v4.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e56ebde245e4799ce74d38419426f2a80d39950]
stable/6.6: [9c6702260557c0183d8417c79a37777a3d3e58e8]

CVE-2024-58054: staging: media: max96712: fix kernel oops when removing module

Announce: https://lore.kernel.org/linux-cve-announce/2025030606-CVE-2024-58054-cdfe@gregkh/

Introduced by commit 5814f32 ("media: staging: max96712: Add basic
support for MAX96712 GMSL2 deserializer") in v5.17-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee1b5046d5cd892a0754ab982aeaaad3702083a5]
stable/6.1: [3311c5395e7322298b659b8addc704b39fb3a59c]
stable/6.6: [dfde3d63afbaae664c4d36e53cfb4045d5374561]

CVE-2024-58055: usb: gadget: f_tcm: Don't free command immediately

Announce: https://lore.kernel.org/linux-cve-announce/2025030606-CVE-2024-58055-39b6@gregkh/

Introduced by commit cff834c ("usb-gadget/tcm: Convert to
TARGET_SCF_ACK_KREF I/O krefs") in v4.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c225d006a31949d673e646d585d9569bc28feeb9]
stable/6.1: [f0c33e7d387ccbb6870e73a43c558fefede06614]
stable/6.6: [16907219ad6763f401700e1b57b2da4f3e07f047]

CVE-2024-58056: remoteproc: core: Fix ida_free call while not allocated

Announce: https://lore.kernel.org/linux-cve-announce/2025030606-CVE-2024-58056-6955@gregkh/

Introduced by commit 08333b9 ("remoteproc: Directly use
ida_alloc()/free()") in v6.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7378aeb664e5ebc396950b36a1f2dedf5aabec20]
stable/6.1: [2cf54928e7e32362215c69b68a6a53d110323bf3]
stable/6.6: [b32d60a852bb3952886625d0c3b1c9a88c3ceb7c]

CVE-2024-58057: idpf: convert workqueues to unbound

Announce: https://lore.kernel.org/linux-cve-announce/2025030607-CVE-2024-58057-5c91@gregkh/

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a5b021cb8186f1854bac2812bd4f396bb1e881c]

CVE-2024-58058: ubifs: skip dumping tnc tree when zroot is null

Announce: https://lore.kernel.org/linux-cve-announce/2025030607-CVE-2024-58058-31d9@gregkh/

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdb0ca39e0acccf6771db49c3f94ed787d05f2d7]
stable/6.1: [e01b55f261ccc96e347eba4931e4429d080d879d]
stable/6.6: [40e25a3c0063935763717877bb2a814c081509ff]

CVE-2024-58059: media: uvcvideo: Fix deadlock during uvc_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025030608-CVE-2024-58059-4753@gregkh/

Introduced by commit c5fe3ed ("media: uvcvideo: Avoid race condition
during unregister") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a67f75c2b5ecf534eab416ce16c11fe780c4f8f6]

CVE-2024-58060: bpf: Reject struct_ops registration that uses module
ptr and the module btf_id is missing

Announce: https://lore.kernel.org/linux-cve-announce/2025030608-CVE-2024-58060-e849@gregkh/

Introduced by commit 1611603 ("bpf: Create argument information for
nullable arguments.") in v6.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96ea081ed52bf077cad6d00153b6fba68e510767]

CVE-2024-58061: wifi: mac80211: prohibit deactivating all links

Announce: https://lore.kernel.org/linux-cve-announce/2025030608-CVE-2024-58061-80cf@gregkh/

Introduced by commit 3d90110 ("wifi: mac80211: implement link
switching") in v6.1-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7553477cbfd784b128297f9ed43751688415bbaa]
stable/6.1: [dfe9a043300261afe5eadc07b867a6810c4e999a]
stable/6.6: [d36e48a4d81c647df8a76cc58fd4d2442ba10744]

CVE-2024-58062: wifi: iwlwifi: mvm: avoid NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58062-00c9@gregkh/

Introduced by commit 2b7ee1a ("wifi: iwlwiif: mvm: handle the new BT
notif") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf704a7624f99eb2ffca1a16c69183e85544a613]

CVE-2024-58063: wifi: rtlwifi: fix memory leaks and invalid access at
probe error path

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58063-5fd7@gregkh/

Introduced by commit 0c81733 ("rtl8192ce: Add new driver") in v2.6.38-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7ceefbfd8d447abc8aca8ab993a942803522c06]
stable/6.1: [ee0b0d7baa8a6d42c7988f6e50c8f164cdf3fa47]
stable/6.6: [624cea89a0865a2bc3e00182a6b0f954a94328b4]

CVE-2024-58064: wifi: cfg80211: tests: Fix potential NULL dereference
in test_cfg80211_parse_colocated_ap()

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58064-6aa6@gregkh/

Introduced by commit 45d4393 ("wifi: cfg80211: add a kunit test for 6
GHz colocated AP parsing") in v6.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13c4f7714c6a1ecf748a2f22099447c14fe6ed8c]

CVE-2024-58065: clk: mmp: pxa1908-apbc: Fix NULL vs IS_ERR() check

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58065-a049@gregkh/

Introduced by commit 51ce559 ("clk: mmp: Add Marvell PXA1908 APBC
driver") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5ca5d7b4d7c29246d957dc45d63610584ae3a54]

CVE-2024-58066: clk: mmp: pxa1908-apbcp: Fix a NULL vs IS_ERR() check

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58066-d537@gregkh/

Introduced by commit a89233d ("clk: mmp: Add Marvell PXA1908 APBCP
driver") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3acea81be689b77b3ceac6ff345ff0366734d967]

CVE-2024-58067: clk: mmp: pxa1908-mpmu: Fix a NULL vs IS_ERR() check

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58067-0807@gregkh/

Introduced by commit ebac87c ("clk: mmp: Add Marvell PXA1908 MPMU
driver") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7def56f841af22e07977e193eea002e085facbdb]

CVE-2024-58068: OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
not initialized

Announce: https://lore.kernel.org/linux-cve-announce/2025030611-CVE-2024-58068-24c2@gregkh/

Introduced by commit add1dc0 ("OPP: Use generic key finding helpers
for bandwidth key") in v6.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b44b9bc7cab2967c3d6a791b1cd542c89fc07f0e]
stable/6.1: [8532fd078d2a5286915d03bb0a0893ee1955acef]
stable/6.6: [84ff05c9bd577157baed711a4f0b41206593978b]

CVE-2024-58069: rtc: pcf85063: fix potential OOB write in PCF85063 NVMEM read

Announce: https://lore.kernel.org/linux-cve-announce/2025030611-CVE-2024-58069-d1d4@gregkh/

Introduced by commit fadfd09 ("rtc: pcf85063: add nvram support") in v5.2-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ab8c5ed4f84fa20cd16794fe8dc31f633fbc70c]
stable/6.1: [c72b7a474d3f445bf0c5bcf8ffed332c78eb28a1]
stable/6.6: [9adefa7b9559d0f21034a5d5ec1b55840c9348b9]

CVE-2024-58070: bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT

Announce: https://lore.kernel.org/linux-cve-announce/2025030611-CVE-2024-58070-3c5f@gregkh/

Introduced by commit 08a7ce3 ("bpf: Use bpf_mem_cache_alloc/free in
bpf_local_storage_elem") in v6.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8eef6ac4d70eb1f0099fff93321d90ce8fa49ee1]
stable/6.6: [3392fa605d7c5708c5fbe02e4fbdac547c3b7352]

CVE-2024-58071: team: prevent adding a device which is already a team
device lower

Announce: https://lore.kernel.org/linux-cve-announce/2025030612-CVE-2024-58071-496f@gregkh/

Introduced by commit 3d249d4 ("net: introduce ethernet teaming
device") in v3.3-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fff5da4ca2164bb4d0f1e6cd33f6eb8a0e73e50]
stable/6.1: [adff6ac889e16d97abd1e4543f533221127e978a]
stable/6.6: [184a564e6000b41582f160a5be9a9b5aabe22ac1]

CVE-2024-58072: wifi: rtlwifi: remove unused check_buddy_priv

Announce: https://lore.kernel.org/linux-cve-announce/2025030612-CVE-2024-58072-2dc3@gregkh/

Introduced by commit 26634c4 ("rtlwifi Modify existing bits to match
vendor version 2013.02.07") in v3.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fdac64c3c35858aa8ac5caa70b232e03456e120]
stable/6.1: [1e39b0486cdb496cdfba3bc89886150e46acf6f4]
stable/6.6: [465d01ef6962b82b1f0ad1f3e58b398dbd35c1c1]

CVE-2024-58073: drm/msm/dpu: check dpu_plane_atomic_print_state() for valid sspp

Announce: https://lore.kernel.org/linux-cve-announce/2025030612-CVE-2024-58073-10bf@gregkh/

Introduced by commit 31f7148 ("drm/msm/dpu: move pstate->pipe
initialization to dpu_plane_atomic_check") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [789384eb1437aed94155dc0eac8a8a6ba1baf578]

CVE-2024-58074: drm/i915: Grab intel_display from the encoder to avoid
potential oopsies

Announce: https://lore.kernel.org/linux-cve-announce/2025030627-CVE-2024-58074-28c1@gregkh/

Introduced by commit 40eb34c ("drm/i915/crt: convert to struct
intel_display") in v6.13-rc1.
Introduced by commit ab0b0eb ("drm/i915/tv: convert to struct
intel_display") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc3806d9eb66d0105f8d55d462d4ef681d9eac59]

CVE-2024-58075: crypto: tegra - do not transfer req when tegra init fails

Announce: https://lore.kernel.org/linux-cve-announce/2025030629-CVE-2024-58075-2f60@gregkh/

Introduced by commit 0880bb3 ("crypto: tegra - Add Tegra Security
Engine driver") in v6.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15589bda46830695a3261518bb7627afac61f519]

CVE-2024-58076: clk: qcom: gcc-sm6350: Add missing parent_map for two clocks

Announce: https://lore.kernel.org/linux-cve-announce/2025030608-CVE-2024-58076-3dcc@gregkh/

Introduced by commit 131abae ("clk: qcom: Add SM6350 GCC driver") in v5.15-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96fe1a7ee477d701cfc98ab9d3c730c35d966861]
stable/6.1: [39336edd14a59dc086fb19957655e0f340bb28e8]
stable/6.6: [08b77ed7cfaac62bba51ac7a0487409ec9fcbc84]

CVE-2024-58077: ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback

Announce: https://lore.kernel.org/linux-cve-announce/2025030608-CVE-2024-58077-d4e3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
It seems as if this bug was introduced by ccommit 1f56643 ("ASoC: lower \"no
backend DAIs enabled for ... Port\" log severity")  in 6.5-rc7.

Fixed status
mainline: [301c26a018acb94dd537a4418cefa0f654500c6f]
stable/6.1: [b65ba768302adc7ddc70811116cef80ca089af59]
stable/6.6: [79b8c7c93beb4f5882c9ee5b9ba73354fa4bc9ee]

CVE-2024-58078: misc: misc_minor_alloc to use ida for all dynamic/misc
dynamic minors

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58078-3d63@gregkh/

Introduced by commit ab76079 ("char: misc: Increase the maximum number
of dynamic misc devices to 1048448") in v6.2-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d04d2b554b14ae6c428a9c60b6c85f1e5c89f68]
stable/6.6: [3df72111c39f7e4c5029c9ff720b56ec2e05b764]

CVE-2024-58079: media: uvcvideo: Fix crash during unbind if gpio unit is in use

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58079-f973@gregkh/

Introduced by commit 2886477 ("media: uvcvideo: Implement
UVC_EXT_GPIO_UNIT") in v5.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9ea1a3d88b7947ce8cadb2afceee7a54872bbc5]
stable/6.1: [3c00e94d00ca079bef7906d6f39d1091bccfedd3]
stable/6.6: [0b5e0445bc8384c18bd35cb9fe87f6258c6271d9]

CVE-2024-58080: clk: qcom: dispcc-sm6350: Add missing parent_map for a clock

Announce: https://lore.kernel.org/linux-cve-announce/2025030609-CVE-2024-58080-9425@gregkh/

Introduced by commit 8375197 ("clk: qcom: Add display clock controller
driver for SM6350") in v5.18-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4cdb196f182d2fbe336c968228be00d8c3fed05]
stable/6.1: [3daca9050857220726732ad9d4a8512069386f46]
stable/6.6: [3ad28517385e2821e8e43388d6a0b3e1ba0bc3ab]

CVE-2024-58081: clk: mmp2: call pm_genpd_init() only after genpd.name is set

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58081-5d47@gregkh/

Introduced by commit 899f445 ("pmdomain: core: Add
GENPD_FLAG_DEV_NAME_FW flag") in v6.12.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e24b15d4704dcb73920c3d18a6157abd18df08c1]

CVE-2024-58082: media: nuvoton: Fix an error check in npcm_video_ece_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58082-3925@gregkh/

Introduced by commit 46c15a4 ("media: nuvoton: Add driver for NPCM
video capture and encoding engine") in v6.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4b7779abc6633677e6edb79e2809f4f61fde157]

CVE-2024-58083: KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()

Announce: https://lore.kernel.org/linux-cve-announce/2025030610-CVE-2024-58083-62b7@gregkh/

Introduced by commit 1d487e9 ("KVM: fix spectrev1 gadgets") in v5.1-rc6.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [1e7381f3617d14b3c11da80ff5f8a93ab14cfc46]
stable/6.1: [d817e510662fd1c9797952408d94806f97a5fffd]
stable/6.6: [125da53b3c0c9d7f58353aea0076e9efd6498ba7]

CVE-2024-58084: firmware: qcom: scm: Fix missing read barrier in
qcom_scm_get_tzmem_pool()

Announce: https://lore.kernel.org/linux-cve-announce/2025030634-CVE-2024-58084-16e9@gregkh/

Introduced by commit ca61d68 ("firmware: qcom: scm: fix a NULL-pointer
dereference") in v6.12-rc7.
Introduced by commit 449d0d8 ("firmware: qcom: scm: smc: switch to
using the SCM allocator") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b628510397b5cafa1f5d3e848a28affd1c635302]

CVE-2024-58085: tomoyo: don't emit warning in tomoyo_write_control()

Announce: https://lore.kernel.org/linux-cve-announce/2025030634-CVE-2024-58085-1af4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
It looks as if this bug was introduced by commit bd03a3e ("TOMOYO: Add policy
namespace support.") in 3.1-rc1.

Fixed status
mainline: [3df7546fc03b8f004eee0b9e3256369f7d096685]
stable/6.1: [a01c200fa7eb59da4d2dbbb48b61f4a0d196c09f]
stable/6.6: [fe1c021eb03dae0dc9dce55e81f77a60e419a27a]

CVE-2024-58086: drm/v3d: Stop active perfmon if it is being destroyed

Announce: https://lore.kernel.org/linux-cve-announce/2025030624-CVE-2024-58086-080c@gregkh/

Introduced by commit 26a4dc2 ("drm/v3d: Expose performance counters to
userspace") in v5.15-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21f1435b1e6b012a07c42f36b206d2b66fc8f13b]
stable/6.1: [95036d4c01167568166108d42c2b0e9f8dbd7d2b]
stable/6.6: [eb0e0eca0eab93f310c6c37b8564049366704691]

CVE-2025-21825: bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT

Announce: https://lore.kernel.org/linux-cve-announce/2025030629-CVE-2025-21825-b3bd@gregkh/

Introduced by commit b00628b ("bpf: Introduce bpf timers.") in v5.15-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58f038e6d209d2dd862fcf5de55407855856794d]

CVE-2025-21826: netfilter: nf_tables: reject mismatching sum of
field_len with set key length

Announce: https://lore.kernel.org/linux-cve-announce/2025030630-CVE-2025-21826-c263@gregkh/

Introduced by commit 3ce67e3 ("netfilter: nf_tables: do not allow
mismatch field size and set key length") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [1b9335a8000fb70742f7db10af314104b6ace220]
stable/6.1: [2ac254343d3cf228ae0738b2615fedf85d000752]
stable/6.6: [82e491e085719068179ff6a5466b7387cc4bbf32]

CVE-2025-21827: Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()

Announce: https://lore.kernel.org/linux-cve-announce/2025030630-CVE-2025-21827-6735@gregkh/

Introduced by commit ceac1cb ("Bluetooth: btusb: mediatek: add ISO
data transmission functions") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9087e828827e5a5c85e124ce77503f2b81c3491]

CVE-2025-21828: wifi: mac80211: don't flush non-uploaded STAs

Announce: https://lore.kernel.org/linux-cve-announce/2025030630-CVE-2025-21828-cb05@gregkh/

Introduced by commit d00800a ("wifi: mac80211: add flush_sta method")
in v6.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa3ce3f8fafa0b8fb062f28024855ea8cb3f3450]
stable/6.6: [cf21ef3d430847ba864bbc9b2774fffcc03ce321]

CVE-2025-21829: RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"

Announce: https://lore.kernel.org/linux-cve-announce/2025030611-CVE-2025-21829-50f9@gregkh/

Introduced by commit 215d0a7 ("RDMA/rxe: Stop lookup of partially
built objects") in v6.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edc4ef0e0154096d6c0cf5e06af6fc330dbad9d1]
stable/6.1: [720653309dd31c8a927ef5d87964578ad544980f]
stable/6.6: [45e567800492088bc52c9abac35524b4d332a8f8]

CVE-2025-21830: landlock: Handle weird files

Announce: https://lore.kernel.org/linux-cve-announce/2025030611-CVE-2025-21830-da64@gregkh/

Introduced by commit cb2c7d1 ("landlock: Support filesystem
access-control") in v5.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49440290a0935f428a1e43a5ac8dc275a647ff80]
stable/6.1: [7d6121228959ddf44a4b9b6a177384ac7854e2f9]
stable/6.6: [39bb3d56f1c351e76bb18895d0e73796e653d5c1]

CVE-2025-21831: PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

Announce: https://lore.kernel.org/linux-cve-announce/2025030634-CVE-2025-21831-3ada@gregkh/

Introduced by commit 9d26d3a ("PCI: Put PCIe ports into D3 during
suspend") in v4.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1049f2d68693c80a576c4578d96774a68df2bad]
stable/6.6: [8852e056e297df1d8635ee7504e780d3184e45d0]

CVE-2025-21832: block: don't revert iter for -EIOCBQUEUED

Announce: https://lore.kernel.org/linux-cve-announce/2025030635-CVE-2025-21832-943e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.
It seems as if this bug was introduced by commit 3e1f941 ("block: fix
DIO handling
regressions in blkdev_read_iter()") in 5.17-rc3.

Fixed status
mainline: [b13ee668e8280ca5b07f8ce2846b9957a8a10853]
stable/6.1: [6c26619effb1b4cb7d20b4e666ab8f71f6a53ccb]
stable/6.6: [84671b0630ccb46ae9f1f99a45c7d63ffcd6a474]

CVE-2025-21833: iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Announce: https://lore.kernel.org/linux-cve-announce/2025030635-CVE-2025-21833-dd2d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [60f030f7418d3f1d94f2fb207fe3080e1844630b]

CVE-2025-21834: seccomp: passthrough uretprobe systemcall without filtering

Announce: https://lore.kernel.org/linux-cve-announce/2025030635-CVE-2025-21834-d92c@gregkh/

Introduced by commit ff474a7 ("uprobe: Add uretprobe syscall to speed
up return probe") in v6.11-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf6cb56ef24410fb5308f9655087f1eddf4452e6]

CVE-2024-36347: [AMD CPU Microcode Signature Verification Vulnerability]

Announce: https://www.cve.org/CVERecord?id=CVE-2024-36347



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb2281fb05e50108ce95c43ab7e701ee564565c8]

CVE-2025-21835: usb: gadget: f_midi: fix MIDI Streaming descriptor lengths

Announce: https://lore.kernel.org/linux-cve-announce/2025030704-CVE-2025-21835-7fab@gregkh/

Introduced by commit c8933c3 ("USB: gadget: f_midi: allow a dynamic
number of input and output ports") in v3.2-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1668997052ed1cb00322e1f3b63702615c9429]
stable/6.1: [9f6860a9c11301b052225ca8825f8d2b1a5825bf]
stable/6.6: [6ae6dee9f005a2f3b739b85abb6f14a0935699e0]

CVE-2025-21836: io_uring/kbuf: reallocate buf lists on upgrade

Announce: https://lore.kernel.org/linux-cve-announce/2025030706-CVE-2025-21836-b358@gregkh/

Introduced by commit 2fcabce ("io_uring: disallow mixed provided
buffer group registrations") in v5.19-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8802766324e1f5d414a81ac43365c20142e85603]
stable/6.6: [146a185f6c05ee263db715f860620606303c4633]

CVE-2025-21837: io_uring/uring_cmd: unconditionally copy SQEs at prep time

Announce: https://lore.kernel.org/linux-cve-announce/2025030706-CVE-2025-21837-85ef@gregkh/

Introduced by commit 5eff57f ("io_uring/uring_cmd: defer SQE copying
until it's needed") in v6.10-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6211ebbdaa541af197b50b8dd8f22642ce0b87f]

CVE-2025-21838: usb: gadget: core: flush gadget workqueue after device removal

Announce: https://lore.kernel.org/linux-cve-announce/2025030706-CVE-2025-21838-5ade@gregkh/

Introduced by commit 5702f75 ("usb: gadget: udc-core: move
sysfs_notify() to a workqueue") in v3.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [399a45e5237ca14037120b1b895bd38a3b4492ea]
stable/6.1: [e3bc1a9a67ce33a2e761e6e7b7c2afc6cb9b7266]
stable/6.6: [859cb45aefa6de823b2fa7f229fe6d9562c9f3b7]

CVE-2025-21839: KVM: x86: Load DR6 with guest value only before
entering .vcpu_run() loop

Announce: https://lore.kernel.org/linux-cve-announce/2025030707-CVE-2025-21839-dfd9@gregkh/

Introduced by commit 375e28f ("KVM: X86: Set host DR6 only on VMX and
for KVM_DEBUGREG_WONT_EXIT") in v5.15-rc1.
Introduced by commit d67668e ("KVM: x86, SVM: isolate vcpu->arch.dr6
from vmcb->save.dr6") in v5.7-rc6.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2fee09fc167c74a64adb08656cb993ea475197e]

CVE-2025-21840: thermal/netlink: Prevent userspace segmentation fault
by adjusting UAPI header

Announce: https://lore.kernel.org/linux-cve-announce/2025030707-CVE-2025-21840-096c@gregkh/

Introduced by commit 1773572 ("thermal: netlink: Add the commands and
the events for the thresholds") in v6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c195b9c6ab9c383d7aa3f4a65879b3ca90cb378b]

CVE-2025-21841: cpufreq/amd-pstate: Fix cpufreq_policy ref counting

Announce: https://lore.kernel.org/linux-cve-announce/2025030707-CVE-2025-21841-1182@gregkh/

Introduced by commit 45722e7 ("cpufreq: amd-pstate: Optimize
amd_pstate_update_limits()") in v6.12-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ace20038e19f23fe73259513f1f08d4bf1a3c83]

CVE-2025-21842: amdkfd: properly free gang_ctx_bo when failed to init user queue

Announce: https://lore.kernel.org/linux-cve-announce/2025030708-CVE-2025-21842-2ddd@gregkh/

Introduced by commit fb91065 ("drm/amdkfd: Refactor queue wptr_bo GART
mapping") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a33f7f9660705fb2ecf3467b2c48965564f392ce]

CVE-2025-21843: drm/panthor: avoid garbage value in panthor_ioctl_dev_query()

Announce: https://lore.kernel.org/linux-cve-announce/2025030708-CVE-2025-21843-4385@gregkh/

Introduced by commit f70000e ("drm/panthor: Add
DEV_QUERY_GROUP_PRIORITIES_INFO dev query") in v6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b32b7f638fe61e9d29290960172f4e360e38233]

CVE-2024-58087: ksmbd: fix racy issue from session lookup and expire

Announce: https://lore.kernel.org/linux-cve-announce/2025031253-CVE-2024-58087-d9e7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.


Fixed status
mainline: [b95629435b84b9ecc0c765995204a4d8a913ed52]
stable/5.15: [2107ab40629aeabbec369cf34b8cf0f288c3eb1b]
stable/6.1: [37a0e2b362b3150317fb6e2139de67b1e29ae5ff]
stable/6.6: [450a844c045ff0895d41b05a1cbe8febd1acfcfd]

CVE-2024-58088: bpf: Fix deadlock when freeing cgroup storage

Announce: https://lore.kernel.org/linux-cve-announce/2025031208-CVE-2024-58088-2b01@gregkh/

Introduced by commit c4bcfb3 ("bpf: Implement cgroup storage available
to non-cgroup-attached bpf progs") in v6.2-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c78f4afbd962f43a3989f45f3ca04300252b19b5]
stable/6.6: [6ecb9fa14eec5f15d97c84c36896871335f6ddfb]

CVE-2024-58089: btrfs: fix double accounting race when
btrfs_run_delalloc_range() failed

Announce: https://lore.kernel.org/linux-cve-announce/2025031210-CVE-2024-58089-8e03@gregkh/

Introduced by commit d1051d6 ("btrfs: Fix error handling in
btrfs_cleanup_ordered_extents") in v5.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [72dad8e377afa50435940adfb697e070d3556670]

CVE-2025-21844: smb: client: Add check for next_buffer in
receive_encrypted_standard()

Announce: https://lore.kernel.org/linux-cve-announce/2025031210-CVE-2025-21844-a1cc@gregkh/

Introduced by commit eec04ea ("smb: client: fix OOB in
receive_encrypted_standard()") in v6.7-rc6.
Fixed in v6.14-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [860ca5e50f73c2a1cef7eefc9d39d04e275417f7]
stable/6.1: [24e8e4523d3071bc5143b0db9127d511489f7b3b]
stable/6.6: [9e5d99a4cf2e23c716b44862975548415fae5391]

CVE-2025-21845: mtd: spi-nor: sst: Fix SST write failure

Announce: https://lore.kernel.org/linux-cve-announce/2025031211-CVE-2025-21845-66d5@gregkh/

Introduced by commit 18bcb4a ("mtd: spi-nor: sst: Factor out common
write operation to `sst_nor_write_data()`") in v6.12-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [539bd20352832b9244238a055eb169ccf1c41ff6]

CVE-2025-21846: acct: perform last write from workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2025031211-CVE-2025-21846-25c1@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56d5f3eba3f5de0efdd556de4ef381e109b973a9]
stable/6.1: [5ee8da9bea70dda492d61f075658939af33d8410]
stable/6.6: [5c928e14a2ccd99462f2351ead627b58075bb736]

CVE-2025-21847: ASoC: SOF: stream-ipc: Check for cstream nullity in
sof_ipc_msg_data()

Announce: https://lore.kernel.org/linux-cve-announce/2025031211-CVE-2025-21847-a72f@gregkh/

Introduced by commit 090349a ("ASoC: SOF: Add support for compress API
for stream data/offset") in v6.3-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8d99c3b5c485f339864aeaa29f76269cc0ea975]
stable/6.6: [2b3878baf90918a361a3dfd3513025100b1b40b6]

CVE-2025-21848: nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2025031212-CVE-2025-21848-30e8@gregkh/

Introduced by commit ff3d43f ("nfp: bpf: implement helpers for FW map
ops") in v4.16-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [878e7b11736e062514e58f3b445ff343e6705537]
stable/6.1: [1358d8e07afdf21d49ca6f00c56048442977e00a]
stable/6.6: [29ccb1e4040da6ff02b7e64efaa2f8e6bf06020d]

CVE-2025-21849: drm/i915/gt: Use spin_lock_irqsave() in interruptible context

Announce: https://lore.kernel.org/linux-cve-announce/2025031212-CVE-2025-21849-c95e@gregkh/

Introduced by commit 2f2cc53 ("drm/i915/guc: Close deregister-context
race against CT-loss") in v6.9-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e49477f7f78598295551d486ecc7f020d796432e]

CVE-2025-21850: nvmet: Fix crash when a namespace is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025031213-CVE-2025-21850-3b06@gregkh/

Introduced by commit 74d1696 ("nvmet-loop: avoid using mutex in IO
hotpath") in v6.13-rc6.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4082326807072b71496501b6a0c55ffe8d5092a5]

CVE-2025-21851: bpf: Fix softlockup in arena_map_free on 64k page kernel

Announce: https://lore.kernel.org/linux-cve-announce/2025031213-CVE-2025-21851-87bd@gregkh/

Introduced by commit 3174603 ("bpf: Introduce bpf_arena.") in v6.9-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [517e8a7835e8cfb398a0aeb0133de50e31cae32b]

CVE-2025-21852: net: Add rx_skb of kfree_skb to raw_tp_null_args[].

Announce: https://lore.kernel.org/linux-cve-announce/2025031213-CVE-2025-21852-b942@gregkh/

Introduced by commit c53795d ("net: add rx_sk to trace_kfree_skb") in v6.11-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5da7e15fb5a12e78de974d8908f348e279922ce9]

CVE-2025-21853: bpf: avoid holding freeze_mutex during mmap operation

Announce: https://lore.kernel.org/linux-cve-announce/2025031214-CVE-2025-21853-cf76@gregkh/

Introduced by commit fc97022 ("bpf: Add mmap() support for
BPF_MAP_TYPE_ARRAY") in v5.5-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc27c52eea189e8f7492d40739b7746d67b65beb]
stable/6.6: [29cfda62ab4d92ab94123813db49ab76c1e61b29]

CVE-2025-21854: sockmap, vsock: For connectible sockets allow only connected

Announce: https://lore.kernel.org/linux-cve-announce/2025031214-CVE-2025-21854-98fb@gregkh/

Introduced by commit 634f1a7 ("vsock: support sockmap") in v6.4-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fb5bb169d17cdd12c2dcc2e96830ed487d77a0f]
stable/6.6: [cc9a7832ede53ade1ba9991f0e27314caa4029d8]

CVE-2025-21855: ibmvnic: Don't reference skb after sending to VIOS

Announce: https://lore.kernel.org/linux-cve-announce/2025031214-CVE-2025-21855-2d67@gregkh/

Introduced by commit 032c5e8 ("Driver for IBM System i/p VNIC
protocol") in v4.5-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdf5d13aa05ec314d4385b31ac974d6c7e0997c9]
stable/6.1: [501ac6a7e21b82e05207c6b4449812d82820f306]
stable/6.6: [093b0e5c90592773863f300b908b741622eef597]

CVE-2025-21856: s390/ism: add release function for struct device

Announce: https://lore.kernel.org/linux-cve-announce/2025031215-CVE-2025-21856-8865@gregkh/

Introduced by commit 8c81ba2 ("net/smc: De-tangle ism and smc device
initialization") in v6.3-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [915e34d5ad35a6a9e56113f852ade4a730fb88f0]
stable/6.6: [940d15254d2216b585558bcf36312da50074e711]

CVE-2025-21857: net/sched: cls_api: fix error handling causing NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025031215-CVE-2025-21857-ab00@gregkh/

Introduced by commit 80cd22c ("net/sched: cls_api: Support hardware
miss to tc action") in v6.3-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [071ed42cff4fcdd89025d966d48eabef59913bf2]
stable/6.6: [de4b679aa3b4da7ec34f639df068b914f20e3c3c]

CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().

Announce: https://lore.kernel.org/linux-cve-announce/2025031215-CVE-2025-21858-3986@gregkh/

Introduced by commit 2d07dc7 ("geneve: add initial netdev driver for
GENEVE tunnels") in v4.2-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9593172d93b9f91c362baec4643003dc29802929]
stable/6.1: [904e746b2e7fa952ab8801b303ce826a63153d78]
stable/6.6: [3ce92ca990cfac88a87c61df3cc0b5880e688ecf]

CVE-2025-21859: USB: gadget: f_midi: f_midi_complete to call queue_work

Announce: https://lore.kernel.org/linux-cve-announce/2025031216-CVE-2025-21859-514d@gregkh/

Introduced by commit d5daf49 ("USB: gadget: midi: add midi function
driver") in v3.2-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ab37fcb42832cdd3e9d5e50653285ca84d6686f]
stable/6.1: [24a942610ee9bafb2692a456ae850c5b2e409b05]
stable/6.6: [deeee3adb2c01eedab32c3b4519337689ad02e8a]

CVE-2025-21860: mm/zswap: fix inconsistency when zswap_store_page() fails

Announce: https://lore.kernel.org/linux-cve-announce/2025031216-CVE-2025-21860-48f9@gregkh/

Introduced by commit b7c0ccd ("mm: zswap: support large folios in
zswap_store()") in v6.13-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63895d20d63b446f5049a963983489319c2ea3e2]

CVE-2025-21861: mm/migrate_device: don't add folio to be freed to LRU
in migrate_device_finalize()

Announce: https://lore.kernel.org/linux-cve-announce/2025031216-CVE-2025-21861-c775@gregkh/

Introduced by commit 8763cb4 ("mm/migrate: new memory migration helper
for use with device memory") in v4.14-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41cddf83d8b00f29fd105e7a0777366edc69a5cf]

CVE-2025-21862: drop_monitor: fix incorrect initialization order

Announce: https://lore.kernel.org/linux-cve-announce/2025031217-CVE-2025-21862-e8a0@gregkh/

Introduced by commit 9a8afc8 ("Network Drop Monitor: Adding drop
monitor implementation & Netlink protocol") in v2.6.30-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07b598c0e6f06a0f254c88dafb4ad50f8a8c6eea]
stable/6.1: [fcfc00bfec7bb6661074cb21356d05a4c9470a3c]
stable/6.6: [0efa6c42f81c60d8f72ba7f5ed8d4fec8c526282]

CVE-2025-21863: io_uring: prevent opcode speculation

Announce: https://lore.kernel.org/linux-cve-announce/2025031217-CVE-2025-21863-a73a@gregkh/

Introduced by commit d365634 ("io_uring: add lookup table for various
opcode needs") in v5.6-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e988c3fe1264708f4f92109203ac5b1d65de50b]
stable/6.6: [b9826e3b26ec031e9063f64a7c735449c43955e4]

CVE-2025-21864: tcp: drop secpath at the same time as we currently drop dst

Announce: https://lore.kernel.org/linux-cve-announce/2025031218-CVE-2025-21864-9a8a@gregkh/

Introduced by commit 68822bd ("net: generalize skb freeing deferral to
per-cpu lists") in v5.19-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b6412e6979f6f9e0632075f8f008937b5cd4efd]
stable/6.1: [87858bbf21da239ace300d61dd209907995c0491]
stable/6.6: [f1d5e6a5e468308af7759cf5276779d3155c5e98]

CVE-2025-21865: gtp: Suppress list corruption splat in
gtp_net_exit_batch_rtnl().

Announce: https://lore.kernel.org/linux-cve-announce/2025031218-CVE-2025-21865-1837@gregkh/

Introduced by commit eb28fd7 ("gtp: Destroy device along with udp
socket's netns dismantle.") in v6.13.
Fixed in v6.14-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [4ccacf86491d33d2486b62d4d44864d7101b299d]
stable/6.1: [b70fa591b066d52b141fc430ffdee35b6cc87a66]
stable/6.6: [9d03e7e37187ae140e716377599493987fb20c5b]

CVE-2025-21866: powerpc/code-patching: Fix KASAN hit by not flagging
text patching area as VM_ALLOC

Announce: https://lore.kernel.org/linux-cve-announce/2025031218-CVE-2025-21866-11c0@gregkh/

Introduced by commit 37bc3e5 ("powerpc/lib/code-patching: Use
alternate map for patch_instruction()") in v4.13-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d262a192d38e527faa5984629aabda2e0d1c4f54]
stable/6.1: [c905a3053518212a1017e50bd2be3bee59305bb0]
stable/6.6: [2d542f13d26344e3452eee77613026ce9b653065]

* Updated CVEs

CVE-2024-26767: drm/amd/display: fixed integer types and null check locations

stable/6.1 was fixed.

Fixed status
stable/6.1: [070fda699dfdce560755379bc428d9edada7a54e]
stable/6.6: [71783d1ff65204d69207fd156d4b2eb1d3882375]
stable/6.7: [beea9ab9080cd2ef46296070bb327af066ee09d7]

CVE-2024-26982: Squashfs: check the inode number is not the invalid
value of zero

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b99dea79650b50909c50aba24fbae00f203f013]
stable/6.6: [be383effaee3d89034f0828038f95065b518772e]
stable/6.8: [7def00ebc9f2d6a581ddf46ce4541f84a10680e5]

CVE-2024-40973: media: mtk-vcodec: potential null pointer deference in SCP

stable/6.1 was fixed.

Fixed status
stable/6.1: [eeb62bb4ca22db17f7dfe8fb8472e0442df3d92f]
stable/6.6: [f066882293b5ad359e44c4ed24ab1811ffb0b354]
stable/6.9: [3a693c7e243b932faee5c1fb728efa73f0abc39b]

CVE-2024-44953: scsi: ufs: core: Fix deadlock during RTC update

stable/6.6 was fixed.

Fixed status
stable/6.10: [f13f1858a28c68b7fc0d72c2008d5c1f80d2e8d5]
stable/6.6: [a4921b76bc9421d3838e167f6a17ea3112d8fe62]

CVE-2024-47754: media: mediatek: vcodec: Fix H264 multi stateless
decoder smatch warning

stable/6.1 was fixed.

Fixed status
stable/6.1: [d48890ef8765001caff732ac6ec80a3b2e470215]
stable/6.11: [301f7778263116388c20521a1a641067647ab31c]
stable/6.6: [588bcce9e64cc5138858ab562268eb3943c5b06c]

CVE-2024-53053: scsi: ufs: core: Fix another deadlock during RTC update

stable/6.6 was fixed.

Fixed status
stable/6.11: [a128cfec44709ab1bd1f01d158569bcb2386f54f]
stable/6.6: [9aa1f0da237d6b16e36e0a0cc9f746d1d78396ed]

CVE-2024-53067: scsi: ufs: core: Start the RTC update work later

stable/6.6 was fixed.

Fixed status
stable/6.11: [4c25f784fba81227e0437337f962d34380d1c250]
stable/6.6: [6e34b9d7caa5a4c831b74bdfed5ef86fa0c03316]

CVE-2024-53166: block, bfq: fix bfqq uaf in bfq_limit_depth()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ada4ca5fd5a9d5212f28164d49a4885951c979c9]
stable/6.12: [01a853faaeaf3379ccf358ade582b1d28752126e]
stable/6.6: [906cdbdd3b018ff69cc830173bce277a847d4fdc]

CVE-2024-56621: scsi: ufs: core: Cancel RTC work during ufshcd_remove()

stable/6.6 was fixed.

Fixed status
stable/6.12: [2e7a3bb0331efb292e0fb022c36bc592137f0520]
stable/6.6: [57479e37d3f69efee2f0678568274db773284bc8]

CVE-2024-57977: memcg: fix soft lockup in the OOM process

stable/6.1 was fixed.

Fixed status
stable/6.1: [0a09d56e1682c951046bf15542b3e9553046c9f6]
stable/6.12: [c3a3741db8c1202aa959c77df3a4c361612d1eb1]
stable/6.13: [46576834291869457d4772bb7df72d7c2bb3d57f]
stable/6.6: [972486d37169fe85035e81b8c5dff21f70df1173]

CVE-2024-58002: media: uvcvideo: Remove dangling pointers

stable/6.1 was fixed.

Fixed status
stable/6.1: [ac18d781466252cd35a3e311e0a4b264260fd927]
stable/6.12: [438bda062b2c40ddd7df23b932e29ffe0a448cac]
stable/6.13: [9edc7d25f7e49c33a1ce7a5ffadea2222065516c]
stable/6.6: [4dbaa738c583a0e947803c69e8996e88cf98d971]

CVE-2024-58005: tpm: Change to kvalloc() in eventlog/acpi.c

stable/6.1 was fixed.

Fixed status
stable/6.1: [77779d1258a287f2c5c2c6aeae203e0996209c77]
stable/6.12: [422d7f4e8d817be467986589c7968d3ea402f7da]
stable/6.13: [4c8bfe643bbd00b04ee8f9545ef33bf6a68c38db]
stable/6.6: [50365a6304a57266e8f4d3078060743c3b7a1e0d]

CVE-2024-58079: media: uvcvideo: Fix crash during unbind if gpio unit is in use

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c00e94d00ca079bef7906d6f39d1091bccfedd3]
stable/6.12: [d2eac8b14ac690aa73052aa6d4ba69005715367e]
stable/6.13: [5d2e65cbe53d0141ed095cf31c2dcf3d8668c11d]
stable/6.6: [0b5e0445bc8384c18bd35cb9fe87f6258c6271d9]

CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit == 0

stable/6.1 was fixed.

Fixed status
stable/6.1: [020ecb76812a0526f4130ab5aeb6dc7c773e7ab9]
stable/6.12: [e40cb34b7f247fe2e366fd192700d1b4f38196ca]
stable/6.13: [b6a079c3b6f95378f26e2aeda520cb3176f7067b]

CVE-2025-21712: md/md-bitmap: Synchronize bitmap_get_stats() with
bitmap lifetime

stable/6.1 was fixed.

Fixed status
stable/6.1: [032fa54f486eac5507976e7e31f079a767bc13a8]
stable/6.12: [237e19519c8ff6949f0ef57c4a0243f5b2b0fa18]
stable/6.13: [4e9316eee3885bfb311b4759513f2ccf37891c09]
stable/6.6: [52848a095b55a302af92f52ca0de5b3112059bb8]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

